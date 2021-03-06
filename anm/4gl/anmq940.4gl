#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq940.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-03-21 16:22:17), PR版次:0002(2016-09-21 15:34:09)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: anmq940
#+ Description: 資金模擬查詢
#+ Creator....: 02114(2016-03-14 16:54:21)
#+ Modifier...: 02114 -SD/PR- 07900
 
{</section>}
 
{<section id="anmq940.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
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
GLOBALS "../../cfg/top_report.inc"
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_master        RECORD
       nmfd001 LIKE type_t.chr20, 
   nmfd003 LIKE type_t.chr10, 
   nmfd003_desc LIKE type_t.chr80, 
   time LIKE type_t.chr500, 
   b LIKE type_t.num10, 
   a LIKE type_t.chr500, 
   nmfa006 LIKE type_t.dat, 
   nmfa007 LIKE type_t.dat, 
   nmfa005 LIKE type_t.chr10, 
   nmfa004 LIKE type_t.chr10, 
   nmfa003 LIKE type_t.chr10
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   seq LIKE type_t.num10, 
   nmfd002 LIKE nmfd_t.nmfd002, 
   nmfd002_desc LIKE type_t.chr500, 
   nmbd003 LIKE type_t.chr1, 
   nmbd004 LIKE type_t.chr1, 
   sum LIKE type_t.num20_6, 
   date1 LIKE type_t.num20_6, 
   date2 LIKE type_t.num20_6, 
   date3 LIKE type_t.num20_6, 
   date4 LIKE type_t.num20_6, 
   date5 LIKE type_t.num20_6, 
   date6 LIKE type_t.num20_6, 
   date7 LIKE type_t.num20_6, 
   date8 LIKE type_t.num20_6, 
   date9 LIKE type_t.num20_6, 
   date10 LIKE type_t.num20_6, 
   date11 LIKE type_t.num20_6, 
   date12 LIKE type_t.num20_6, 
   date13 LIKE type_t.num20_6, 
   date14 LIKE type_t.num20_6, 
   date15 LIKE type_t.num20_6, 
   date16 LIKE type_t.num20_6, 
   date17 LIKE type_t.num20_6, 
   date18 LIKE type_t.num20_6, 
   date19 LIKE type_t.num20_6, 
   date20 LIKE type_t.num20_6, 
   date21 LIKE type_t.num20_6, 
   date22 LIKE type_t.num20_6, 
   date23 LIKE type_t.num20_6, 
   date24 LIKE type_t.num20_6, 
   date25 LIKE type_t.num20_6, 
   date26 LIKE type_t.num20_6, 
   date27 LIKE type_t.num20_6, 
   date28 LIKE type_t.num20_6, 
   date29 LIKE type_t.num20_6, 
   date30 LIKE type_t.num20_6, 
   date31 LIKE type_t.num20_6, 
   date32 LIKE type_t.num20_6, 
   date33 LIKE type_t.num20_6, 
   date34 LIKE type_t.num20_6, 
   date35 LIKE type_t.num20_6, 
   date36 LIKE type_t.num20_6, 
   date37 LIKE type_t.num20_6, 
   date38 LIKE type_t.num20_6, 
   date39 LIKE type_t.num20_6, 
   date40 LIKE type_t.num20_6, 
   date41 LIKE type_t.num20_6, 
   date42 LIKE type_t.num20_6, 
   date43 LIKE type_t.num20_6, 
   date44 LIKE type_t.num20_6, 
   date45 LIKE type_t.num20_6, 
   date46 LIKE type_t.num20_6, 
   date47 LIKE type_t.num20_6, 
   date48 LIKE type_t.num20_6, 
   date49 LIKE type_t.num20_6, 
   date50 LIKE type_t.num20_6, 
   date51 LIKE type_t.num20_6, 
   date52 LIKE type_t.num20_6, 
   date53 LIKE type_t.num20_6, 
   date54 LIKE type_t.num20_6, 
   date55 LIKE type_t.num20_6, 
   date56 LIKE type_t.num20_6, 
   date57 LIKE type_t.num20_6, 
   date58 LIKE type_t.num20_6, 
   date59 LIKE type_t.num20_6, 
   date60 LIKE type_t.num20_6, 
   date61 LIKE type_t.num20_6, 
   date62 LIKE type_t.num20_6, 
   date63 LIKE type_t.num20_6, 
   date64 LIKE type_t.num20_6, 
   date65 LIKE type_t.num20_6, 
   date66 LIKE type_t.num20_6, 
   date67 LIKE type_t.num20_6, 
   date68 LIKE type_t.num20_6, 
   date69 LIKE type_t.num20_6, 
   date70 LIKE type_t.num20_6, 
   date71 LIKE type_t.num20_6, 
   date72 LIKE type_t.num20_6, 
   date73 LIKE type_t.num20_6, 
   date74 LIKE type_t.num20_6, 
   date75 LIKE type_t.num20_6, 
   date76 LIKE type_t.num20_6, 
   date77 LIKE type_t.num20_6, 
   date78 LIKE type_t.num20_6, 
   date79 LIKE type_t.num20_6, 
   date80 LIKE type_t.num20_6, 
   date81 LIKE type_t.num20_6, 
   date82 LIKE type_t.num20_6, 
   date83 LIKE type_t.num20_6, 
   date84 LIKE type_t.num20_6, 
   date85 LIKE type_t.num20_6, 
   date86 LIKE type_t.num20_6, 
   date87 LIKE type_t.num20_6, 
   date88 LIKE type_t.num20_6, 
   date89 LIKE type_t.num20_6, 
   date90 LIKE type_t.num20_6, 
   date91 LIKE type_t.num20_6, 
   date92 LIKE type_t.num20_6, 
   date93 LIKE type_t.num20_6, 
   date94 LIKE type_t.num20_6, 
   date95 LIKE type_t.num20_6, 
   date96 LIKE type_t.num20_6, 
   date97 LIKE type_t.num20_6, 
   date98 LIKE type_t.num20_6, 
   date99 LIKE type_t.num20_6, 
   date100 LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_nmfa002           LIKE nmfa_t.nmfa002
DEFINE g_ooec004_str       STRING
DEFINE g_str               STRING 
DEFINE tok                 base.StringTokenizer
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
 
{<section id="anmq940.main" >}
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
   DECLARE anmq940_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq940_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq940_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq940 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq940_init()   
 
      #進入選單 Menu (="N")
      CALL anmq940_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      DROP TABLE anmq940_tmp;
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq940
      
   END IF 
   
   CLOSE anmq940_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq940.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmq940_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_str         STRING
   DEFINE l_i           LIKE type_t.num5
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
   CALL cl_set_combo_scc('time','8740')
   CALL cl_set_combo_scc('nmbd003','8026')
   CALL cl_set_combo_scc('nmbd004','8709')
   FOR l_i = 1 TO 100            
       IF NOT cl_null(l_str) THEN LET l_str = l_str CLIPPED,"," END IF
       LET l_str = l_str,"date",l_i USING '<<<<' CLIPPED
    END FOR
    CALL cl_set_comp_visible(l_str,FALSE)
    
    CALL anmq940_create_for_xg()   #150701-00005#15 add lujh
   #end add-point
 
   CALL anmq940_default_search()
END FUNCTION
 
{</section>}
 
{<section id="anmq940.default_search" >}
PRIVATE FUNCTION anmq940_default_search()
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
 
{<section id="anmq940.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq940_ui_dialog() 
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
      CALL anmq940_cs()
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
 
         CALL anmq940_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.nmfd001,g_master.nmfd003,g_master.nmfd003_desc,
                       g_master.time,g_master.b,g_master.a,g_master.nmfa006,
                       g_master.nmfa007,g_master.nmfa005,g_master.nmfa004,
                       g_master.nmfa003
                       
         
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
                     CALL anmq940_get_nmfa()                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL anmq940_get_nmfa()  
            
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

                  #160816-00012#4 Add  ---(E)---
               END IF
               CALL s_desc_get_department_desc(g_master.nmfd003) RETURNING g_master.nmfd003_desc
               DISPLAY g_master.nmfd003_desc TO nmfd003_desc 
               
            ON CHANGE time
               IF g_master.time <> '5' THEN
                  CALL cl_set_comp_entry('b',FALSE) 
                  LET g_master.b = ''
               ELSE
                  CALL cl_set_comp_entry('b',TRUE) 
               END IF
            
            
            ON ACTION controlp INFIELD nmfd001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.nmfd001       
               CALL q_nmfa001()                                
               LET g_master.nmfd001 = g_qryparam.return1     
               CALL anmq940_get_nmfa()                 
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
               CALL anmq940_detail_action_trans()
               LET g_master_idx = l_ac
               CALL anmq940_b_fill2()
 
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
            CALL anmq940_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            LET g_master.a = 'N'
            LET g_master.time = '1'
            CALL cl_set_comp_entry('b',FALSE) 
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
            CALL anmq940_b_fill()
            #end add-point
 
            CALL anmq940_cs()
 
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
            CALL anmq940_fetch('F')
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
            CALL anmq940_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq940_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq940_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq940_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq940_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq940_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL anmq940_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL anmq940_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL anmq940_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL anmq940_b_fill()
 
         
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
         ON ACTION modify_detail
            IF NOT cl_null(g_detail[l_ac].nmfd002) THEN 
               LET la_param.prog = 'anmq950'
               LET la_param.param[1] = 'N'
               LET la_param.param[2] = g_master.nmfd001
               LET la_param.param[3] = g_master.nmfd003
               LET la_param.param[4] = g_master.a
               LET la_param.param[5] = g_detail[l_ac].nmfd002
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js)
            END IF
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
               CALL anmq940_ins_xg_tmp()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL anmq940_ins_xg_tmp()
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
 
{<section id="anmq940.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION anmq940_cs()
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
 
   PREPARE anmq940_pre FROM g_sql
   DECLARE anmq940_curs SCROLL CURSOR WITH HOLD FOR anmq940_pre
   OPEN anmq940_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   LET g_cnt_sql = "SELECT COUNT(*) FROM (",g_sql,")"
   #end add-point
   PREPARE anmq940_precount FROM g_cnt_sql
   EXECUTE anmq940_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL anmq940_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="anmq940.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION anmq940_fetch(p_flag)
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
      DISPLAY g_master.* TO nmfd001,nmfd003,nmfd003_desc,time,b,a,nmfa006,nmfa007,nmfa005,nmfa004,nmfa003 
 
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
   CALL anmq940_show()
 
END FUNCTION
 
{</section>}
 
{<section id="anmq940.show" >}
PRIVATE FUNCTION anmq940_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO nmfd001,nmfd003,nmfd003_desc,time,b,a,nmfa006,nmfa007,nmfa005,nmfa004,nmfa003 
 
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL anmq940_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="anmq940.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq940_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_date          LIKE nmfd_t.nmfddocdt
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_str           STRING
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_str1          STRING
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
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
   CALL anmq940_create_tmp() RETURNING l_success
   IF l_success = FALSE THEN
      RETURN
   END IF
   
   FOR l_i = 1 TO 100            
      IF NOT cl_null(l_str) THEN LET l_str = l_str CLIPPED,"," END IF
      LET l_str = l_str,"date",l_i USING '<<<<' CLIPPED
   END FOR
   CALL cl_set_comp_visible(l_str,FALSE)
   
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
   CALL anmq940_ins_tmp() RETURNING l_success
   IF l_success = FALSE THEN
      RETURN
   END IF
   
   LET ls_sql_rank = "SELECT * FROM anmq940_tmp",
                     " ORDER BY seq"
  
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
   
   LET g_sql = "SELECT * ",
               "  FROM (",ls_sql_rank,")"
                
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq940_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq940_pb
   
   OPEN b_fill_curs
   
   FOREACH b_fill_curs INTO g_detail[l_ac].*
                            

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      CALL anmq940_detail_show("'1'")      
 
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
   CALL anmq940_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq940_detail_action_trans()
 
   CALL anmq940_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="anmq940.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq940_b_fill2()
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
 
{<section id="anmq940.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq940_detail_show(ps_page)
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
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq940.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION anmq940_maintain_prog()
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
 
{<section id="anmq940.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq940_detail_action_trans()
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
 
{<section id="anmq940.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq940_detail_index_setting()
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
 
{<section id="anmq940.mask_functions" >}
 &include "erp/anm/anmq940_mask.4gl"
 
{</section>}
 
{<section id="anmq940.other_function" readonly="Y" >}
# 抓取模拟方案资料
PRIVATE FUNCTION anmq940_get_nmfa()
   
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
PRIVATE FUNCTION anmq940_get_ooec004()
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
               
   PREPARE anmq940_ooec004_pre FROM l_sql
   DECLARE anmq940_ooec004_cs CURSOR FOR anmq940_ooec004_pre
   
   FOREACH anmq940_ooec004_cs INTO l_ooec004
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
# 创建临时表
PRIVATE FUNCTION anmq940_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   DROP TABLE anmq940_tmp;
   CREATE TEMP TABLE anmq940_tmp(
   sel             LIKE type_t.chr1,
   seq             LIKE type_t.num5,
   nmfd002         LIKE nmfd_t.nmfd002, 
   nmfd002_desc    LIKE type_t.chr500, 
   nmbd003         LIKE type_t.chr1, 
   nmbd004         LIKE type_t.chr1, 
   sum             LIKE type_t.num20_6, 
   date1           LIKE type_t.num20_6, 
   date2           LIKE type_t.num20_6, 
   date3           LIKE type_t.num20_6, 
   date4           LIKE type_t.num20_6, 
   date5           LIKE type_t.num20_6, 
   date6           LIKE type_t.num20_6, 
   date7           LIKE type_t.num20_6, 
   date8           LIKE type_t.num20_6, 
   date9           LIKE type_t.num20_6, 
   date10          LIKE type_t.num20_6, 
   date11          LIKE type_t.num20_6, 
   date12          LIKE type_t.num20_6, 
   date13          LIKE type_t.num20_6, 
   date14          LIKE type_t.num20_6, 
   date15          LIKE type_t.num20_6, 
   date16          LIKE type_t.num20_6, 
   date17          LIKE type_t.num20_6, 
   date18          LIKE type_t.num20_6, 
   date19          LIKE type_t.num20_6, 
   date20          LIKE type_t.num20_6, 
   date21          LIKE type_t.num20_6, 
   date22          LIKE type_t.num20_6, 
   date23          LIKE type_t.num20_6, 
   date24          LIKE type_t.num20_6, 
   date25          LIKE type_t.num20_6, 
   date26          LIKE type_t.num20_6, 
   date27          LIKE type_t.num20_6, 
   date28          LIKE type_t.num20_6, 
   date29          LIKE type_t.num20_6, 
   date30          LIKE type_t.num20_6, 
   date31          LIKE type_t.num20_6, 
   date32          LIKE type_t.num20_6, 
   date33          LIKE type_t.num20_6, 
   date34          LIKE type_t.num20_6, 
   date35          LIKE type_t.num20_6, 
   date36          LIKE type_t.num20_6, 
   date37          LIKE type_t.num20_6, 
   date38          LIKE type_t.num20_6, 
   date39          LIKE type_t.num20_6, 
   date40          LIKE type_t.num20_6, 
   date41          LIKE type_t.num20_6, 
   date42          LIKE type_t.num20_6, 
   date43          LIKE type_t.num20_6, 
   date44          LIKE type_t.num20_6, 
   date45          LIKE type_t.num20_6, 
   date46          LIKE type_t.num20_6, 
   date47          LIKE type_t.num20_6, 
   date48          LIKE type_t.num20_6, 
   date49          LIKE type_t.num20_6, 
   date50          LIKE type_t.num20_6, 
   date51          LIKE type_t.num20_6, 
   date52          LIKE type_t.num20_6, 
   date53          LIKE type_t.num20_6, 
   date54          LIKE type_t.num20_6, 
   date55          LIKE type_t.num20_6, 
   date56          LIKE type_t.num20_6, 
   date57          LIKE type_t.num20_6, 
   date58          LIKE type_t.num20_6, 
   date59          LIKE type_t.num20_6, 
   date60          LIKE type_t.num20_6, 
   date61          LIKE type_t.num20_6, 
   date62          LIKE type_t.num20_6, 
   date63          LIKE type_t.num20_6, 
   date64          LIKE type_t.num20_6, 
   date65          LIKE type_t.num20_6, 
   date66          LIKE type_t.num20_6, 
   date67          LIKE type_t.num20_6, 
   date68          LIKE type_t.num20_6, 
   date69          LIKE type_t.num20_6, 
   date70          LIKE type_t.num20_6, 
   date71          LIKE type_t.num20_6, 
   date72          LIKE type_t.num20_6, 
   date73          LIKE type_t.num20_6, 
   date74          LIKE type_t.num20_6, 
   date75          LIKE type_t.num20_6, 
   date76          LIKE type_t.num20_6, 
   date77          LIKE type_t.num20_6, 
   date78          LIKE type_t.num20_6, 
   date79          LIKE type_t.num20_6, 
   date80          LIKE type_t.num20_6, 
   date81          LIKE type_t.num20_6, 
   date82          LIKE type_t.num20_6, 
   date83          LIKE type_t.num20_6, 
   date84          LIKE type_t.num20_6, 
   date85          LIKE type_t.num20_6, 
   date86          LIKE type_t.num20_6, 
   date87          LIKE type_t.num20_6, 
   date88          LIKE type_t.num20_6, 
   date89          LIKE type_t.num20_6, 
   date90          LIKE type_t.num20_6, 
   date91          LIKE type_t.num20_6, 
   date92          LIKE type_t.num20_6, 
   date93          LIKE type_t.num20_6, 
   date94          LIKE type_t.num20_6, 
   date95          LIKE type_t.num20_6, 
   date96          LIKE type_t.num20_6, 
   date97          LIKE type_t.num20_6, 
   date98          LIKE type_t.num20_6, 
   date99          LIKE type_t.num20_6, 
   date100         LIKE type_t.num20_6
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION
# 插入临时表
PRIVATE FUNCTION anmq940_ins_tmp()
   DEFINE l_sql           STRING
   DEFINE l_nmfd002       LIKE nmfd_t.nmfd002
   DEFINE l_date          LIKE nmfd_t.nmfddocdt
   DEFINE l_date_1        LIKE nmfd_t.nmfddocdt
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_str           STRING
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_str1          STRING
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_amt           LIKE nmfd_t.nmfd009
   DEFINE l_amt1          LIKE nmfd_t.nmfd009
   DEFINE l_amt2          LIKE nmfd_t.nmfd009
   DEFINE l_amt3          LIKE nmfd_t.nmfd009
   DEFINE l_amt4          LIKE nmfd_t.nmfd009
   DEFINE l_amt5          LIKE nmfd_t.nmfd009
   DEFINE l_amt_000       LIKE nmfd_t.nmfd009
   DEFINE l_amt1_sum      LIKE nmfd_t.nmfd009
   DEFINE l_amt2_sum      LIKE nmfd_t.nmfd009
   DEFINE l_amt3_sum      LIKE nmfd_t.nmfd009
   DEFINE l_nmbd003       LIKE nmbd_t.nmbd003
   DEFINE l_date_str      STRING
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_tmp           type_g_detail
   DEFINE l_tmp1          type_g_detail
       
   
   INITIALIZE l_tmp.* TO NULL
   INITIALIZE l_tmp1.* TO NULL
   
   LET r_success = TRUE
   LET g_str = ''
   LET l_flag = TRUE
   DELETE FROM anmq940_tmp;
   
   CALL anmq940_get_ooec004()
  
   LET l_sql = "SELECT DISTINCT nmfd002,nmbd003 ",
                     "  FROM nmfd_t ",
                     "  LEFT OUTER JOIN nmfa_t ",
                     "    ON nmfdent = nmfaent ",
                     "   AND nmfd001 = nmfa001 ",
                     "  LEFT OUTER JOIN nmbd_t ",
                     "    ON nmfaent = nmbdent ",
                     "   AND nmfa004 = nmbd001 ",
                     "   AND nmfd002 = nmbd002 ",
                     " WHERE nmfdent = ",g_enterprise,
                     "   AND nmfd001 = '",g_master.nmfd001,"'",
                     "   AND ",g_wc
                
   IF g_master.a = 'N' THEN 
      LET l_sql = l_sql," AND nmfd003 = '",g_master.nmfd003,"'"
   ELSE
      LET l_sql = l_sql," AND nmfd003 IN (",g_ooec004_str,")"
   END IF
   
   LET l_sql = l_sql," ORDER BY nmfd002,nmbd003"
   
   PREPARE anmq940_tmp_pre FROM l_sql
   DECLARE anmq940_tmp_cs CURSOR FOR anmq940_tmp_pre
   
   FOREACH anmq940_tmp_cs INTO l_nmfd002,l_nmbd003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      LET l_j =1
      LET l_date = g_master.nmfa006
      LET l_tmp.sum = 0
      
      WHILE TRUE
         IF l_j > 1 THEN 
            CASE g_master.time
               WHEN '1'    LET l_date = l_date + 1                #日   
               WHEN '2'    LET l_date = l_date + 7                #周
               WHEN '3'    LET l_date = l_date + 30               #月
               WHEN '4'    LET l_date = l_date + 90               #季
               WHEN '5'    LET l_date = l_date + g_master.b       #其他            
            END CASE  
         END IF               
         
         IF l_date > g_master.nmfa007 THEN
            CASE g_master.time
               WHEN '1'    LET l_date_1 = l_date - 1                #日   
               WHEN '2'    LET l_date_1 = l_date - 7                #周
               WHEN '3'    LET l_date_1 = l_date - 30               #月
               WHEN '4'    LET l_date_1 = l_date - 90               #季
               WHEN '5'    LET l_date_1 = l_date - g_master.b       #其他            
            END CASE  
            LET l_date = g_master.nmfa007
         END IF
         IF l_flag = TRUE THEN
            IF NOT cl_null(l_str1) THEN LET l_str1 = l_str1 CLIPPED,"," END IF
            CALL cl_set_comp_att_text("date" || l_j,l_date)
            LET l_str1 = l_str1,"date" CLIPPED,l_j USING '<<<<'
            IF cl_null(g_str) THEN 
               LET g_str = l_date
            ELSE
               LET g_str = g_str CLIPPED,",",l_date
            END IF
         END IF
         
         #第一天的金额
         IF l_j = 1 THEN 
            LET l_sql = "SELECT SUM(nmfd009) ",
                        "  FROM nmfd_t ",
                        " WHERE nmfdent = ",g_enterprise,
                        "   AND nmfd001 = '",g_master.nmfd001,"'",
                        "   AND nmfd002 = '",l_nmfd002,"'",
                        "   AND nmfddocdt = '",l_date,"'"
            IF g_master.a = 'N' THEN 
               LET l_sql = l_sql," AND nmfd003 = '",g_master.nmfd003,"'"
            ELSE
               LET l_sql = l_sql," AND nmfd003 IN (",g_ooec004_str,")"
            END IF
            PREPARE anmq940_tmp_pre1 FROM l_sql
            EXECUTE anmq940_tmp_pre1 INTO l_amt
       
            IF cl_null(l_amt) THEN LET l_amt = 0 END IF
            
            LET l_amt_000 = l_amt
         ELSE
            #从第二期开始到最后的金额
            CALL anmq940_get_amt(l_nmfd002,l_date,l_date_1) RETURNING l_amt
         END IF
         
         CASE l_j
            WHEN 1   LET l_tmp.date1 = l_amt
            WHEN 2   LET l_tmp.date2 = l_amt
            WHEN 3   LET l_tmp.date3 = l_amt
            WHEN 4   LET l_tmp.date4 = l_amt  
            WHEN 5   LET l_tmp.date5 = l_amt
            WHEN 6   LET l_tmp.date6 = l_amt
            WHEN 7   LET l_tmp.date7 = l_amt
            WHEN 8   LET l_tmp.date8 = l_amt
            WHEN 9   LET l_tmp.date9 = l_amt
            WHEN 10  LET l_tmp.date10 = l_amt  
            WHEN 11  LET l_tmp.date11 = l_amt
            WHEN 12  LET l_tmp.date12 = l_amt
            WHEN 13  LET l_tmp.date13 = l_amt
            WHEN 14  LET l_tmp.date14 = l_amt
            WHEN 15  LET l_tmp.date15 = l_amt
            WHEN 16  LET l_tmp.date16 = l_amt 
            WHEN 17  LET l_tmp.date17 = l_amt
            WHEN 18  LET l_tmp.date18 = l_amt           
            WHEN 19  LET l_tmp.date19 = l_amt
            WHEN 20  LET l_tmp.date20 = l_amt
            WHEN 21  LET l_tmp.date21 = l_amt
            WHEN 22  LET l_tmp.date22 = l_amt 
            WHEN 23  LET l_tmp.date23 = l_amt
            WHEN 24  LET l_tmp.date24 = l_amt
            WHEN 25  LET l_tmp.date25 = l_amt
            WHEN 26  LET l_tmp.date26 = l_amt
            WHEN 27  LET l_tmp.date27 = l_amt
            WHEN 28  LET l_tmp.date28 = l_amt
            WHEN 29  LET l_tmp.date29 = l_amt 
            WHEN 30  LET l_tmp.date30 = l_amt
            WHEN 31  LET l_tmp.date31 = l_amt           
            WHEN 32  LET l_tmp.date32 = l_amt
            WHEN 33  LET l_tmp.date33 = l_amt
            WHEN 34  LET l_tmp.date34 = l_amt
            WHEN 35  LET l_tmp.date35 = l_amt
            WHEN 36  LET l_tmp.date36 = l_amt
            WHEN 37  LET l_tmp.date37 = l_amt
            WHEN 38  LET l_tmp.date38 = l_amt
            WHEN 39  LET l_tmp.date39 = l_amt
            WHEN 40  LET l_tmp.date40 = l_amt
            WHEN 41  LET l_tmp.date41 = l_amt
            WHEN 42  LET l_tmp.date42 = l_amt 
            WHEN 43  LET l_tmp.date43 = l_amt
            WHEN 44  LET l_tmp.date44 = l_amt           
            WHEN 45  LET l_tmp.date45 = l_amt
            WHEN 46  LET l_tmp.date46 = l_amt
            WHEN 47  LET l_tmp.date47 = l_amt
            WHEN 48  LET l_tmp.date48 = l_amt 
            WHEN 49  LET l_tmp.date49 = l_amt
            WHEN 50  LET l_tmp.date50 = l_amt
            WHEN 51  LET l_tmp.date51 = l_amt
            WHEN 52  LET l_tmp.date52 = l_amt 
            WHEN 53  LET l_tmp.date53 = l_amt
            WHEN 54  LET l_tmp.date54 = l_amt           
            WHEN 55  LET l_tmp.date55 = l_amt
            WHEN 56  LET l_tmp.date56 = l_amt
            WHEN 57  LET l_tmp.date57 = l_amt
            WHEN 58  LET l_tmp.date58 = l_amt 
            WHEN 59  LET l_tmp.date59 = l_amt
            WHEN 60  LET l_tmp.date60 = l_amt 
            WHEN 61  LET l_tmp.date61 = l_amt
            WHEN 62  LET l_tmp.date62 = l_amt 
            WHEN 63  LET l_tmp.date63 = l_amt
            WHEN 64  LET l_tmp.date64 = l_amt           
            WHEN 65  LET l_tmp.date65 = l_amt
            WHEN 66  LET l_tmp.date66 = l_amt
            WHEN 67  LET l_tmp.date67 = l_amt
            WHEN 68  LET l_tmp.date68 = l_amt 
            WHEN 69  LET l_tmp.date69 = l_amt
            WHEN 70  LET l_tmp.date70 = l_amt 
            WHEN 71  LET l_tmp.date71 = l_amt
            WHEN 72  LET l_tmp.date72 = l_amt 
            WHEN 73  LET l_tmp.date73 = l_amt
            WHEN 74  LET l_tmp.date74 = l_amt           
            WHEN 75  LET l_tmp.date75 = l_amt
            WHEN 76  LET l_tmp.date76 = l_amt
            WHEN 77  LET l_tmp.date77 = l_amt
            WHEN 78  LET l_tmp.date78 = l_amt 
            WHEN 79  LET l_tmp.date79 = l_amt
            WHEN 80  LET l_tmp.date80 = l_amt 
            WHEN 81  LET l_tmp.date81 = l_amt
            WHEN 82  LET l_tmp.date82 = l_amt 
            WHEN 83  LET l_tmp.date83 = l_amt
            WHEN 84  LET l_tmp.date84 = l_amt           
            WHEN 85  LET l_tmp.date85 = l_amt
            WHEN 86  LET l_tmp.date86 = l_amt
            WHEN 87  LET l_tmp.date87 = l_amt
            WHEN 88  LET l_tmp.date88 = l_amt 
            WHEN 89  LET l_tmp.date89 = l_amt
            WHEN 90  LET l_tmp.date90 = l_amt 
            WHEN 91  LET l_tmp.date91 = l_amt
            WHEN 92  LET l_tmp.date92 = l_amt 
            WHEN 93  LET l_tmp.date93 = l_amt
            WHEN 94  LET l_tmp.date94 = l_amt           
            WHEN 95  LET l_tmp.date95 = l_amt
            WHEN 96  LET l_tmp.date96 = l_amt
            WHEN 97  LET l_tmp.date97 = l_amt
            WHEN 98  LET l_tmp.date98 = l_amt 
            WHEN 99  LET l_tmp.date99 = l_amt
            WHEN 100 LET l_tmp.date100= l_amt 
         OTHERWISE
            EXIT WHILE         
         END CASE
         
         IF l_nmfd002 = '000' THEN 
            LET l_tmp.sum = l_amt_000
         ELSE
            LET l_tmp.sum = l_tmp.sum + l_amt
         END IF
         
         LET l_j = l_j + 1
         IF l_date = g_master.nmfa007 THEN
            EXIT WHILE
         END IF 
         
      END WHILE
         
      LET l_flag = FALSE
      
      LET l_tmp.sel = ''
 
      SELECT MAX(seq) INTO l_tmp.seq
        FROM anmq940_tmp
      IF cl_null(l_tmp.seq) THEN 
         LET l_tmp.seq = 10
      ELSE
         LET l_tmp.seq = l_tmp.seq + 10
      END IF
      
      IF l_nmfd002 = '000' THEN 
         LET l_tmp.seq = 1
      END IF
      
      LET l_tmp.nmfd002 = l_nmfd002
      IF l_tmp.nmfd002 = '000' THEN 
         LET l_tmp.nmfd002_desc = cl_getmsg('ais-00176',g_lang)
      ELSE
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_master.nmfa004
         LET g_ref_fields[2] = l_tmp.nmfd002
         CALL ap_ref_array2(g_ref_fields," SELECT nmbdl004 FROM nmbdl_t WHERE nmbdlent = '" ||g_enterprise||"' AND nmbdl001 = ? AND nmbdl002 = ? AND nmbdl003 = '"||g_dlang||"'","")
         RETURNING g_rtn_fields
         LET l_tmp.nmfd002_desc = g_rtn_fields[1]
      END IF
      
      SELECT nmbd003,nmbd004 
        INTO l_tmp.nmbd003,l_tmp.nmbd004
        FROM nmbd_t
       WHERE nmbdent = g_enterprise
         AND nmbd001 = g_master.nmfa004
         AND nmbd002 = l_tmp.nmfd002
      
      INSERT INTO anmq940_tmp VALUES(l_tmp.*)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET r_success = FALSE
      END IF  
   END FOREACH 
   
   #设置栏位显示
   CALL cl_set_comp_visible(l_str1,TRUE)
   
   SELECT COUNT(*) INTO l_n FROM anmq940_tmp
   IF l_n > 0 THEN
      INITIALIZE l_tmp.* TO NULL
      INITIALIZE l_tmp1.* TO NULL
      
      #插入小计行
      LET l_sql = "SELECT DISTINCT nmbd003 FROM anmq940_tmp ",
                  " WHERE nmfd002 <> '000' ",
                  " ORDER BY nmbd003"
      PREPARE anmq940_tmp_pre4 FROM l_sql
      DECLARE anmq940_tmp_cs4 CURSOR FOR anmq940_tmp_pre4
         
      FOREACH anmq940_tmp_cs4 INTO l_nmbd003
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
      
            EXIT FOREACH
         END IF
         
         LET l_j = 1
         LET l_tmp.sum = 0
         LET l_tmp1.sum = 0
         LET tok = base.StringTokenizer.create(g_str,",")
         WHILE tok.hasMoreTokens()
            LET l_date = tok.nextToken()
            LET l_date_str = "date" CLIPPED,l_j USING '<<<<'
            
            #加项
            LET l_sql = "SELECT SUM(",l_date_str,")",
                        "  FROM anmq940_tmp ",
                        " WHERE nmbd003 = '",l_nmbd003,"'",
                        "   AND nmbd004 = '+' "
            PREPARE anmq940_tmp_pre5 FROM l_sql
            EXECUTE anmq940_tmp_pre5 INTO l_amt1
            
            IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
            
            #减项
            LET l_sql = "SELECT SUM(",l_date_str,")",
                        "  FROM anmq940_tmp ",
                        " WHERE nmbd003 = '",l_nmbd003,"'",
                        "   AND nmbd004 = '-' "
            PREPARE anmq940_tmp_pre6 FROM l_sql
            EXECUTE anmq940_tmp_pre6 INTO l_amt2
            IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
            
            CASE l_j
               WHEN 1   LET l_tmp.date1 = l_amt1        LET l_tmp1.date1 = l_amt2  
               WHEN 2   LET l_tmp.date2 = l_amt1        LET l_tmp1.date2 = l_amt2
               WHEN 3   LET l_tmp.date3 = l_amt1        LET l_tmp1.date3 = l_amt2
               WHEN 4   LET l_tmp.date4 = l_amt1        LET l_tmp1.date4 = l_amt2 
               WHEN 5   LET l_tmp.date5 = l_amt1        LET l_tmp1.date5 = l_amt2
               WHEN 6   LET l_tmp.date6 = l_amt1        LET l_tmp1.date6 = l_amt2
               WHEN 7   LET l_tmp.date7 = l_amt1        LET l_tmp1.date7 = l_amt2
               WHEN 8   LET l_tmp.date8 = l_amt1        LET l_tmp1.date8 = l_amt2
               WHEN 9   LET l_tmp.date9 = l_amt1        LET l_tmp1.date9 = l_amt2
               WHEN 10  LET l_tmp.date10 = l_amt1       LET l_tmp1.date10 = l_amt2 
               WHEN 11  LET l_tmp.date11 = l_amt1       LET l_tmp1.date11 = l_amt2
               WHEN 12  LET l_tmp.date12 = l_amt1       LET l_tmp1.date12 = l_amt2
               WHEN 13  LET l_tmp.date13 = l_amt1       LET l_tmp1.date13 = l_amt2
               WHEN 14  LET l_tmp.date14 = l_amt1       LET l_tmp1.date14 = l_amt2
               WHEN 15  LET l_tmp.date15 = l_amt1       LET l_tmp1.date15 = l_amt2
               WHEN 16  LET l_tmp.date16 = l_amt1       LET l_tmp1.date16 = l_amt2 
               WHEN 17  LET l_tmp.date17 = l_amt1       LET l_tmp1.date17 = l_amt2
               WHEN 18  LET l_tmp.date18 = l_amt1       LET l_tmp1.date18 = l_amt2     
               WHEN 19  LET l_tmp.date19 = l_amt1       LET l_tmp1.date19 = l_amt2
               WHEN 20  LET l_tmp.date20 = l_amt1       LET l_tmp1.date20 = l_amt2
               WHEN 21  LET l_tmp.date21 = l_amt1       LET l_tmp1.date21 = l_amt2
               WHEN 22  LET l_tmp.date22 = l_amt1       LET l_tmp1.date22 = l_amt2 
               WHEN 23  LET l_tmp.date23 = l_amt1       LET l_tmp1.date23 = l_amt2
               WHEN 24  LET l_tmp.date24 = l_amt1       LET l_tmp1.date24 = l_amt2
               WHEN 25  LET l_tmp.date25 = l_amt1       LET l_tmp1.date25 = l_amt2
               WHEN 26  LET l_tmp.date26 = l_amt1       LET l_tmp1.date26 = l_amt2
               WHEN 27  LET l_tmp.date27 = l_amt1       LET l_tmp1.date27 = l_amt2
               WHEN 28  LET l_tmp.date28 = l_amt1       LET l_tmp1.date28 = l_amt2
               WHEN 29  LET l_tmp.date29 = l_amt1       LET l_tmp1.date29 = l_amt2 
               WHEN 30  LET l_tmp.date30 = l_amt1       LET l_tmp1.date30 = l_amt2
               WHEN 31  LET l_tmp.date31 = l_amt1       LET l_tmp1.date31 = l_amt2     
               WHEN 32  LET l_tmp.date32 = l_amt1       LET l_tmp1.date32 = l_amt2
               WHEN 33  LET l_tmp.date33 = l_amt1       LET l_tmp1.date33 = l_amt2
               WHEN 34  LET l_tmp.date34 = l_amt1       LET l_tmp1.date34 = l_amt2
               WHEN 35  LET l_tmp.date35 = l_amt1       LET l_tmp1.date35 = l_amt2
               WHEN 36  LET l_tmp.date36 = l_amt1       LET l_tmp1.date36 = l_amt2
               WHEN 37  LET l_tmp.date37 = l_amt1       LET l_tmp1.date37 = l_amt2
               WHEN 38  LET l_tmp.date38 = l_amt1       LET l_tmp1.date38 = l_amt2
               WHEN 39  LET l_tmp.date39 = l_amt1       LET l_tmp1.date39 = l_amt2
               WHEN 40  LET l_tmp.date40 = l_amt1       LET l_tmp1.date40 = l_amt2
               WHEN 41  LET l_tmp.date41 = l_amt1       LET l_tmp1.date41 = l_amt2
               WHEN 42  LET l_tmp.date42 = l_amt1       LET l_tmp1.date42 = l_amt2 
               WHEN 43  LET l_tmp.date43 = l_amt1       LET l_tmp1.date43 = l_amt2
               WHEN 44  LET l_tmp.date44 = l_amt1       LET l_tmp1.date44 = l_amt2     
               WHEN 45  LET l_tmp.date45 = l_amt1       LET l_tmp1.date45 = l_amt2
               WHEN 46  LET l_tmp.date46 = l_amt1       LET l_tmp1.date46 = l_amt2
               WHEN 47  LET l_tmp.date47 = l_amt1       LET l_tmp1.date47 = l_amt2
               WHEN 48  LET l_tmp.date48 = l_amt1       LET l_tmp1.date48 = l_amt2 
               WHEN 49  LET l_tmp.date49 = l_amt1       LET l_tmp1.date49 = l_amt2
               WHEN 50  LET l_tmp.date50 = l_amt1       LET l_tmp1.date50 = l_amt2
               WHEN 51  LET l_tmp.date51 = l_amt1       LET l_tmp1.date51 = l_amt2
               WHEN 52  LET l_tmp.date52 = l_amt1       LET l_tmp1.date52 = l_amt2 
               WHEN 53  LET l_tmp.date53 = l_amt1       LET l_tmp1.date53 = l_amt2
               WHEN 54  LET l_tmp.date54 = l_amt1       LET l_tmp1.date54 = l_amt2     
               WHEN 55  LET l_tmp.date55 = l_amt1       LET l_tmp1.date55 = l_amt2
               WHEN 56  LET l_tmp.date56 = l_amt1       LET l_tmp1.date56 = l_amt2
               WHEN 57  LET l_tmp.date57 = l_amt1       LET l_tmp1.date57 = l_amt2
               WHEN 58  LET l_tmp.date58 = l_amt1       LET l_tmp1.date58 = l_amt2 
               WHEN 59  LET l_tmp.date59 = l_amt1       LET l_tmp1.date59 = l_amt2
               WHEN 60  LET l_tmp.date60 = l_amt1       LET l_tmp1.date60 = l_amt2 
               WHEN 61  LET l_tmp.date61 = l_amt1       LET l_tmp1.date61 = l_amt2
               WHEN 62  LET l_tmp.date62 = l_amt1       LET l_tmp1.date62 = l_amt2 
               WHEN 63  LET l_tmp.date63 = l_amt1       LET l_tmp1.date63 = l_amt2
               WHEN 64  LET l_tmp.date64 = l_amt1       LET l_tmp1.date64 = l_amt2     
               WHEN 65  LET l_tmp.date65 = l_amt1       LET l_tmp1.date65 = l_amt2
               WHEN 66  LET l_tmp.date66 = l_amt1       LET l_tmp1.date66 = l_amt2
               WHEN 67  LET l_tmp.date67 = l_amt1       LET l_tmp1.date67 = l_amt2
               WHEN 68  LET l_tmp.date68 = l_amt1       LET l_tmp1.date68 = l_amt2 
               WHEN 69  LET l_tmp.date69 = l_amt1       LET l_tmp1.date69 = l_amt2
               WHEN 70  LET l_tmp.date70 = l_amt1       LET l_tmp1.date70 = l_amt2 
               WHEN 71  LET l_tmp.date71 = l_amt1       LET l_tmp1.date71 = l_amt2
               WHEN 72  LET l_tmp.date72 = l_amt1       LET l_tmp1.date72 = l_amt2 
               WHEN 73  LET l_tmp.date73 = l_amt1       LET l_tmp1.date73 = l_amt2
               WHEN 74  LET l_tmp.date74 = l_amt1       LET l_tmp1.date74 = l_amt2     
               WHEN 75  LET l_tmp.date75 = l_amt1       LET l_tmp1.date75 = l_amt2
               WHEN 76  LET l_tmp.date76 = l_amt1       LET l_tmp1.date76 = l_amt2
               WHEN 77  LET l_tmp.date77 = l_amt1       LET l_tmp1.date77 = l_amt2
               WHEN 78  LET l_tmp.date78 = l_amt1       LET l_tmp1.date78 = l_amt2 
               WHEN 79  LET l_tmp.date79 = l_amt1       LET l_tmp1.date79 = l_amt2
               WHEN 80  LET l_tmp.date80 = l_amt1       LET l_tmp1.date80 = l_amt2 
               WHEN 81  LET l_tmp.date81 = l_amt1       LET l_tmp1.date81 = l_amt2
               WHEN 82  LET l_tmp.date82 = l_amt1       LET l_tmp1.date82 = l_amt2 
               WHEN 83  LET l_tmp.date83 = l_amt1       LET l_tmp1.date83 = l_amt2
               WHEN 84  LET l_tmp.date84 = l_amt1       LET l_tmp1.date84 = l_amt2     
               WHEN 85  LET l_tmp.date85 = l_amt1       LET l_tmp1.date85 = l_amt2
               WHEN 86  LET l_tmp.date86 = l_amt1       LET l_tmp1.date86 = l_amt2
               WHEN 87  LET l_tmp.date87 = l_amt1       LET l_tmp1.date87 = l_amt2
               WHEN 88  LET l_tmp.date88 = l_amt1       LET l_tmp1.date88 = l_amt2 
               WHEN 89  LET l_tmp.date89 = l_amt1       LET l_tmp1.date89 = l_amt2
               WHEN 90  LET l_tmp.date90 = l_amt1       LET l_tmp1.date90 = l_amt2 
               WHEN 91  LET l_tmp.date91 = l_amt1       LET l_tmp1.date91 = l_amt2
               WHEN 92  LET l_tmp.date92 = l_amt1       LET l_tmp1.date92 = l_amt2 
               WHEN 93  LET l_tmp.date93 = l_amt1       LET l_tmp1.date93 = l_amt2
               WHEN 94  LET l_tmp.date94 = l_amt1       LET l_tmp1.date94 = l_amt2     
               WHEN 95  LET l_tmp.date95 = l_amt1       LET l_tmp1.date95 = l_amt2
               WHEN 96  LET l_tmp.date96 = l_amt1       LET l_tmp1.date96 = l_amt2
               WHEN 97  LET l_tmp.date97 = l_amt1       LET l_tmp1.date97 = l_amt2
               WHEN 98  LET l_tmp.date98 = l_amt1       LET l_tmp1.date98 = l_amt2 
               WHEN 99  LET l_tmp.date99 = l_amt1       LET l_tmp1.date99 = l_amt2
               WHEN 100 LET l_tmp.date100= l_amt1       LET l_tmp1.date100= l_amt2 
            OTHERWISE
               EXIT WHILE 
            END CASE
            
            LET l_tmp.sum = l_tmp.sum + l_amt1
            LET l_tmp1.sum = l_tmp1.sum + l_amt2        
            
            LET l_j = l_j + 1
         END WHILE
         
         #小计加项
         SELECT MAX(seq)+1 INTO l_tmp.seq
           FROM anmq940_tmp
          WHERE nmbd003 = l_nmbd003
      
         LET l_tmp.nmfd002 = ''
         LET l_tmp.nmfd002_desc = cl_getmsg('anm-02984',g_lang)
         LET l_tmp.nmbd003 = l_nmbd003
         LET l_tmp.nmbd004 = '+'
         
         INSERT INTO anmq940_tmp VALUES(l_tmp.*)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET r_success = FALSE
         END IF  
         
         #小计减项
         SELECT MAX(seq)+1 INTO l_tmp1.seq
           FROM anmq940_tmp
          WHERE nmbd003 = l_nmbd003
      
         LET l_tmp1.nmfd002 = ''
         LET l_tmp1.nmfd002_desc = cl_getmsg('anm-02985',g_lang)
         LET l_tmp1.nmbd003 = l_nmbd003
         LET l_tmp1.nmbd004 = '-'
         
         INSERT INTO anmq940_tmp VALUES(l_tmp1.*)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET r_success = FALSE
         END IF  
         
      END FOREACH 
      
      INITIALIZE l_tmp.* TO NULL
      #插入合计行
      LET l_j = 1
      LET l_amt = 0
      LET l_tmp.sum = 0
      LET tok = base.StringTokenizer.create(g_str,",")
      WHILE tok.hasMoreTokens()
         LET l_date = tok.nextToken()
         LET l_date_str = "date" CLIPPED,l_j USING '<<<<'
         
         #期初金额
         LET l_sql = "SELECT SUM(",l_date_str,")",
                     "  FROM anmq940_tmp ",
                     " WHERE nmfd002 = '000' ",
                     "   AND nmfd002 IS NOT NULL "
         PREPARE anmq940_tmp_pre7 FROM l_sql
         EXECUTE anmq940_tmp_pre7 INTO l_amt3
         IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
         
         #加项
         LET l_sql = "SELECT SUM(",l_date_str,")",
                     "  FROM anmq940_tmp ",
                     " WHERE nmfd002 IS NULL",
                     "   AND nmbd004 = '+' "
         PREPARE anmq940_tmp_pre8 FROM l_sql
         EXECUTE anmq940_tmp_pre8 INTO l_amt4
         IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
         
         #减项
         LET l_sql = "SELECT SUM(",l_date_str,")",
                     "  FROM anmq940_tmp ",
                     " WHERE nmfd002 IS NULL",
                     "   AND nmbd004 = '-' "
         PREPARE anmq940_tmp_pre9 FROM l_sql
         EXECUTE anmq940_tmp_pre9 INTO l_amt5
         IF cl_null(l_amt5) THEN LET l_amt5 = 0 END IF
         LET l_amt = l_amt3 + l_amt4 - l_amt5 
         
         CASE l_j
            WHEN 1   LET l_tmp.date1 = l_amt      
            WHEN 2   LET l_tmp.date2 = l_amt       
            WHEN 3   LET l_tmp.date3 = l_amt       
            WHEN 4   LET l_tmp.date4 = l_amt       
            WHEN 5   LET l_tmp.date5 = l_amt       
            WHEN 6   LET l_tmp.date6 = l_amt       
            WHEN 7   LET l_tmp.date7 = l_amt       
            WHEN 8   LET l_tmp.date8 = l_amt       
            WHEN 9   LET l_tmp.date9 = l_amt       
            WHEN 10  LET l_tmp.date10 = l_amt     
            WHEN 11  LET l_tmp.date11 = l_amt     
            WHEN 12  LET l_tmp.date12 = l_amt     
            WHEN 13  LET l_tmp.date13 = l_amt     
            WHEN 14  LET l_tmp.date14 = l_amt     
            WHEN 15  LET l_tmp.date15 = l_amt     
            WHEN 16  LET l_tmp.date16 = l_amt     
            WHEN 17  LET l_tmp.date17 = l_amt     
            WHEN 18  LET l_tmp.date18 = l_amt         
            WHEN 19  LET l_tmp.date19 = l_amt     
            WHEN 20  LET l_tmp.date20 = l_amt     
            WHEN 21  LET l_tmp.date21 = l_amt     
            WHEN 22  LET l_tmp.date22 = l_amt     
            WHEN 23  LET l_tmp.date23 = l_amt     
            WHEN 24  LET l_tmp.date24 = l_amt     
            WHEN 25  LET l_tmp.date25 = l_amt     
            WHEN 26  LET l_tmp.date26 = l_amt     
            WHEN 27  LET l_tmp.date27 = l_amt     
            WHEN 28  LET l_tmp.date28 = l_amt     
            WHEN 29  LET l_tmp.date29 = l_amt     
            WHEN 30  LET l_tmp.date30 = l_amt     
            WHEN 31  LET l_tmp.date31 = l_amt         
            WHEN 32  LET l_tmp.date32 = l_amt     
            WHEN 33  LET l_tmp.date33 = l_amt     
            WHEN 34  LET l_tmp.date34 = l_amt     
            WHEN 35  LET l_tmp.date35 = l_amt     
            WHEN 36  LET l_tmp.date36 = l_amt     
            WHEN 37  LET l_tmp.date37 = l_amt     
            WHEN 38  LET l_tmp.date38 = l_amt     
            WHEN 39  LET l_tmp.date39 = l_amt     
            WHEN 40  LET l_tmp.date40 = l_amt     
            WHEN 41  LET l_tmp.date41 = l_amt     
            WHEN 42  LET l_tmp.date42 = l_amt     
            WHEN 43  LET l_tmp.date43 = l_amt     
            WHEN 44  LET l_tmp.date44 = l_amt         
            WHEN 45  LET l_tmp.date45 = l_amt     
            WHEN 46  LET l_tmp.date46 = l_amt     
            WHEN 47  LET l_tmp.date47 = l_amt     
            WHEN 48  LET l_tmp.date48 = l_amt     
            WHEN 49  LET l_tmp.date49 = l_amt     
            WHEN 50  LET l_tmp.date50 = l_amt     
            WHEN 51  LET l_tmp.date51 = l_amt     
            WHEN 52  LET l_tmp.date52 = l_amt     
            WHEN 53  LET l_tmp.date53 = l_amt     
            WHEN 54  LET l_tmp.date54 = l_amt         
            WHEN 55  LET l_tmp.date55 = l_amt     
            WHEN 56  LET l_tmp.date56 = l_amt     
            WHEN 57  LET l_tmp.date57 = l_amt     
            WHEN 58  LET l_tmp.date58 = l_amt     
            WHEN 59  LET l_tmp.date59 = l_amt     
            WHEN 60  LET l_tmp.date60 = l_amt     
            WHEN 61  LET l_tmp.date61 = l_amt     
            WHEN 62  LET l_tmp.date62 = l_amt     
            WHEN 63  LET l_tmp.date63 = l_amt     
            WHEN 64  LET l_tmp.date64 = l_amt         
            WHEN 65  LET l_tmp.date65 = l_amt     
            WHEN 66  LET l_tmp.date66 = l_amt     
            WHEN 67  LET l_tmp.date67 = l_amt     
            WHEN 68  LET l_tmp.date68 = l_amt     
            WHEN 69  LET l_tmp.date69 = l_amt     
            WHEN 70  LET l_tmp.date70 = l_amt     
            WHEN 71  LET l_tmp.date71 = l_amt     
            WHEN 72  LET l_tmp.date72 = l_amt     
            WHEN 73  LET l_tmp.date73 = l_amt     
            WHEN 74  LET l_tmp.date74 = l_amt         
            WHEN 75  LET l_tmp.date75 = l_amt     
            WHEN 76  LET l_tmp.date76 = l_amt     
            WHEN 77  LET l_tmp.date77 = l_amt     
            WHEN 78  LET l_tmp.date78 = l_amt     
            WHEN 79  LET l_tmp.date79 = l_amt     
            WHEN 80  LET l_tmp.date80 = l_amt     
            WHEN 81  LET l_tmp.date81 = l_amt     
            WHEN 82  LET l_tmp.date82 = l_amt     
            WHEN 83  LET l_tmp.date83 = l_amt     
            WHEN 84  LET l_tmp.date84 = l_amt         
            WHEN 85  LET l_tmp.date85 = l_amt     
            WHEN 86  LET l_tmp.date86 = l_amt     
            WHEN 87  LET l_tmp.date87 = l_amt     
            WHEN 88  LET l_tmp.date88 = l_amt     
            WHEN 89  LET l_tmp.date89 = l_amt     
            WHEN 90  LET l_tmp.date90 = l_amt     
            WHEN 91  LET l_tmp.date91 = l_amt     
            WHEN 92  LET l_tmp.date92 = l_amt     
            WHEN 93  LET l_tmp.date93 = l_amt     
            WHEN 94  LET l_tmp.date94 = l_amt         
            WHEN 95  LET l_tmp.date95 = l_amt     
            WHEN 96  LET l_tmp.date96 = l_amt     
            WHEN 97  LET l_tmp.date97 = l_amt     
            WHEN 98  LET l_tmp.date98 = l_amt     
            WHEN 99  LET l_tmp.date99 = l_amt     
            WHEN 100 LET l_tmp.date100= l_amt 
         OTHERWISE
            EXIT WHILE             
         END CASE
         
         LET l_j = l_j + 1
      END WHILE
      
      SELECT MAX(seq)+1 INTO l_tmp.seq
        FROM anmq940_tmp
      
      LET l_tmp.nmfd002 = ''
      LET l_tmp.nmfd002_desc = cl_getmsg('axc-00204',g_lang)
      LET l_tmp.nmbd003 = ''
      LET l_tmp.nmbd004 = ''
      
      LET l_sql = "SELECT SUM(sum) ",
                  "  FROM anmq940_tmp ",
                  " WHERE nmfd002 = '000' "
      PREPARE anmq940_sum_pre1 FROM l_sql
      EXECUTE anmq940_sum_pre1 INTO l_amt1_sum
      
      IF cl_null(l_amt1_sum) THEN LET l_amt1_sum = 0 END IF
      
      LET l_sql = "SELECT SUM(sum) ",
                  "  FROM anmq940_tmp ",
                  " WHERE nmfd002 IS NULL ",
                  "   AND nmbd004 = '+' "
      PREPARE anmq940_sum_pre2 FROM l_sql
      EXECUTE anmq940_sum_pre2 INTO l_amt2_sum
      
      IF cl_null(l_amt2_sum) THEN LET l_amt2_sum = 0 END IF
      
      LET l_sql = "SELECT SUM(sum) ",
                  "  FROM anmq940_tmp ",
                  " WHERE nmfd002 IS NULL ",
                  "   AND nmbd004 = '-' "
      PREPARE anmq940_sum_pre3 FROM l_sql
      EXECUTE anmq940_sum_pre3 INTO l_amt3_sum
      
      IF cl_null(l_amt3_sum) THEN LET l_amt3_sum = 0 END IF
    
      LET l_tmp.sum = l_amt1_sum + l_amt2_sum - l_amt3_sum    
      
      INSERT INTO anmq940_tmp VALUES(l_tmp.*)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET r_success = FALSE
      END IF
   END IF      
   
   RETURN r_success
END FUNCTION
# 获取金额
PRIVATE FUNCTION anmq940_get_amt(p_nmfd002,p_date,p_date_1)
   DEFINE p_nmfd002           LIKE nmfd_t.nmfd002
   DEFINE p_date              LIKE nmfd_t.nmfddocdt
   DEFINE p_date_1            LIKE nmfd_t.nmfddocdt     #最后一天的上一期
   DEFINE r_amt               LIKE nmfd_t.nmfd009
   DEFINE l_date              LIKE nmfd_t.nmfddocdt
   DEFINE l_sql               STRING
   
   #计算上期的下一天的日期
   CASE g_master.time
      WHEN '1'    LET l_date = p_date - 1  + 1               #日   
      WHEN '2'    LET l_date = p_date - 7  + 1               #周
      WHEN '3'    LET l_date = p_date - 30 + 1               #月
      WHEN '4'    LET l_date = p_date - 90 + 1               #季
      WHEN '5'    LET l_date = p_date - g_master.b + 1       #其他            
   END CASE 
   
   #如果已经到了最后一天,计算最后一天的上一期的下一天
   IF p_date = g_master.nmfa007 THEN 
      LET l_date = p_date_1 + 1
   END IF
   
   #期初金额的计算
   #本期的金额为上期的下一天的期初金额
   IF p_nmfd002 = '000' THEN 
      LET l_sql = "SELECT SUM(nmfd009) ",
                  "  FROM nmfd_t ",
                  " WHERE nmfdent = ",g_enterprise,
                  "   AND nmfd001 = '",g_master.nmfd001,"'",
                  "   AND nmfd002 = '",p_nmfd002,"'",
                  "   AND nmfddocdt = '",l_date,"'"
      IF g_master.a = 'N' THEN 
         LET l_sql = l_sql," AND nmfd003 = '",g_master.nmfd003,"'"
      ELSE
         LET l_sql = l_sql," AND nmfd003 IN (",g_ooec004_str,")"
      END IF
      PREPARE anmq940_tmp_pre2 FROM l_sql
      EXECUTE anmq940_tmp_pre2 INTO r_amt
      
      IF cl_null(r_amt) THEN LET r_amt = 0 END IF
      
      RETURN r_amt
   END IF
   
   #其他收支项目的金额计算
   #本期的金额为上期的下一天开始到本期的金额之和   
   
   SELECT SUM(nmfd009) INTO r_amt
     FROM nmfd_t
    WHERE nmfdent = g_enterprise
      AND nmfd001 = g_master.nmfd001
      AND nmfd002 = p_nmfd002
      AND nmfddocdt BETWEEN l_date AND p_date
      
   LET l_sql = "SELECT SUM(nmfd009) ",
               "  FROM nmfd_t ",
               " WHERE nmfdent = ",g_enterprise,
               "   AND nmfd001 = '",g_master.nmfd001,"'",
               "   AND nmfd002 = '",p_nmfd002,"'",
               "   AND nmfddocdt BETWEEN '",l_date,"' AND '",p_date,"'"
   IF g_master.a = 'N' THEN 
      LET l_sql = l_sql," AND nmfd003 = '",g_master.nmfd003,"'"
   ELSE
      LET l_sql = l_sql," AND nmfd003 IN (",g_ooec004_str,")"
   END IF
   PREPARE anmq940_tmp_pre3 FROM l_sql
   EXECUTE anmq940_tmp_pre3 INTO r_amt

   IF cl_null(r_amt) THEN LET r_amt = 0 END IF
   
   RETURN r_amt
   
END FUNCTION

################################################################################
# Descriptions...: 為XG報表建立臨時表
# Memo...........:
# Usage..........: CALL anmq940_create_for_xg()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/03/17 By lujh
# Modify.........: #150701-00005#15 add lujh
################################################################################
PRIVATE FUNCTION anmq940_create_for_xg()
   DROP TABLE anmq940_xg_tmp;
      CREATE TEMP TABLE anmq940_xg_tmp( 
            seq            LIKE type_t.num10, 
            nmfd002        LIKE nmfd_t.nmfd002, 
            nmfd002_desc   LIKE type_t.chr500, 
            nmbd003        LIKE type_t.chr80,
            nmbd004        LIKE type_t.chr80,
            sum            LIKE type_t.num20_6, 
            date1          LIKE type_t.num20_6, 
            date2          LIKE type_t.num20_6, 
            date3          LIKE type_t.num20_6, 
            date4          LIKE type_t.num20_6, 
            date5          LIKE type_t.num20_6, 
            date6          LIKE type_t.num20_6, 
            date7          LIKE type_t.num20_6, 
            date8          LIKE type_t.num20_6, 
            date9          LIKE type_t.num20_6, 
            date10         LIKE type_t.num20_6, 
            date11         LIKE type_t.num20_6, 
            date12         LIKE type_t.num20_6, 
            date13         LIKE type_t.num20_6, 
            date14         LIKE type_t.num20_6, 
            date15         LIKE type_t.num20_6, 
            date16         LIKE type_t.num20_6, 
            date17         LIKE type_t.num20_6, 
            date18         LIKE type_t.num20_6, 
            date19         LIKE type_t.num20_6, 
            date20         LIKE type_t.num20_6, 
            date21         LIKE type_t.num20_6, 
            date22         LIKE type_t.num20_6, 
            date23         LIKE type_t.num20_6, 
            date24         LIKE type_t.num20_6, 
            date25         LIKE type_t.num20_6, 
            date26         LIKE type_t.num20_6, 
            date27         LIKE type_t.num20_6, 
            date28         LIKE type_t.num20_6, 
            date29         LIKE type_t.num20_6, 
            date30         LIKE type_t.num20_6, 
            date31         LIKE type_t.num20_6, 
            date32         LIKE type_t.num20_6, 
            date33         LIKE type_t.num20_6, 
            date34         LIKE type_t.num20_6, 
            date35         LIKE type_t.num20_6, 
            date36         LIKE type_t.num20_6, 
            date37         LIKE type_t.num20_6, 
            date38         LIKE type_t.num20_6, 
            date39         LIKE type_t.num20_6, 
            date40         LIKE type_t.num20_6, 
            date41         LIKE type_t.num20_6, 
            date42         LIKE type_t.num20_6, 
            date43         LIKE type_t.num20_6, 
            date44         LIKE type_t.num20_6, 
            date45         LIKE type_t.num20_6, 
            date46         LIKE type_t.num20_6, 
            date47         LIKE type_t.num20_6, 
            date48         LIKE type_t.num20_6, 
            date49         LIKE type_t.num20_6, 
            date50         LIKE type_t.num20_6,
            date51         LIKE type_t.num20_6, 
            date52         LIKE type_t.num20_6, 
            date53         LIKE type_t.num20_6, 
            date54         LIKE type_t.num20_6, 
            date55         LIKE type_t.num20_6, 
            date56         LIKE type_t.num20_6, 
            date57         LIKE type_t.num20_6, 
            date58         LIKE type_t.num20_6, 
            date59         LIKE type_t.num20_6,
            date60         LIKE type_t.num20_6,
            date61         LIKE type_t.num20_6, 
            date62         LIKE type_t.num20_6, 
            date63         LIKE type_t.num20_6, 
            date64         LIKE type_t.num20_6, 
            date65         LIKE type_t.num20_6, 
            date66         LIKE type_t.num20_6, 
            date67         LIKE type_t.num20_6, 
            date68         LIKE type_t.num20_6, 
            date69         LIKE type_t.num20_6,
            date70         LIKE type_t.num20_6,
            date71         LIKE type_t.num20_6, 
            date72         LIKE type_t.num20_6, 
            date73         LIKE type_t.num20_6, 
            date74         LIKE type_t.num20_6, 
            date75         LIKE type_t.num20_6, 
            date76         LIKE type_t.num20_6, 
            date77         LIKE type_t.num20_6, 
            date78         LIKE type_t.num20_6, 
            date79         LIKE type_t.num20_6,
            date80         LIKE type_t.num20_6,
            date81         LIKE type_t.num20_6, 
            date82         LIKE type_t.num20_6, 
            date83         LIKE type_t.num20_6, 
            date84         LIKE type_t.num20_6, 
            date85         LIKE type_t.num20_6, 
            date86         LIKE type_t.num20_6, 
            date87         LIKE type_t.num20_6, 
            date88         LIKE type_t.num20_6, 
            date89         LIKE type_t.num20_6,
            date90         LIKE type_t.num20_6,
            date91         LIKE type_t.num20_6, 
            date92         LIKE type_t.num20_6, 
            date93         LIKE type_t.num20_6, 
            date94         LIKE type_t.num20_6, 
            date95         LIKE type_t.num20_6, 
            date96         LIKE type_t.num20_6, 
            date97         LIKE type_t.num20_6, 
            date98         LIKE type_t.num20_6, 
            date99         LIKE type_t.num20_6,
            date100        LIKE type_t.num20_6
          )
END FUNCTION

################################################################################
# Descriptions...: 透過RECORD把資料放入TEMP TABLE
# Memo...........: 
#
# Date & Author..: #150701-00005#15 By lujh
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq940_ins_xg_tmp()
   DEFINE l_i like type_t.num10
   DEFINE l_nmfd003_desc  LIKE type_t.chr500    #取得SCC的說明文字
   DEFINE l_nmbd003_desc  LIKE type_t.chr500    #取得SCC的說明文字
   DEFINE l_nmbd004_desc  LIKE type_t.chr500    #取得SCC的說明文字
   DEFINE l_x01_tmp        RECORD
            seq            LIKE type_t.num10,
            nmfd002        LIKE nmfd_t.nmfd002, 
            nmfd002_desc   LIKE type_t.chr500, 
            nmbd003        LIKE type_t.chr80,
            nmbd004        LIKE type_t.chr80,
            sum            LIKE type_t.num20_6, 
            date1          LIKE type_t.num20_6, 
            date2          LIKE type_t.num20_6, 
            date3          LIKE type_t.num20_6, 
            date4          LIKE type_t.num20_6, 
            date5          LIKE type_t.num20_6, 
            date6          LIKE type_t.num20_6, 
            date7          LIKE type_t.num20_6, 
            date8          LIKE type_t.num20_6, 
            date9          LIKE type_t.num20_6, 
            date10         LIKE type_t.num20_6, 
            date11         LIKE type_t.num20_6, 
            date12         LIKE type_t.num20_6, 
            date13         LIKE type_t.num20_6, 
            date14         LIKE type_t.num20_6, 
            date15         LIKE type_t.num20_6, 
            date16         LIKE type_t.num20_6, 
            date17         LIKE type_t.num20_6, 
            date18         LIKE type_t.num20_6, 
            date19         LIKE type_t.num20_6, 
            date20         LIKE type_t.num20_6, 
            date21         LIKE type_t.num20_6, 
            date22         LIKE type_t.num20_6, 
            date23         LIKE type_t.num20_6, 
            date24         LIKE type_t.num20_6, 
            date25         LIKE type_t.num20_6, 
            date26         LIKE type_t.num20_6, 
            date27         LIKE type_t.num20_6, 
            date28         LIKE type_t.num20_6, 
            date29         LIKE type_t.num20_6, 
            date30         LIKE type_t.num20_6, 
            date31         LIKE type_t.num20_6, 
            date32         LIKE type_t.num20_6, 
            date33         LIKE type_t.num20_6, 
            date34         LIKE type_t.num20_6, 
            date35         LIKE type_t.num20_6, 
            date36         LIKE type_t.num20_6, 
            date37         LIKE type_t.num20_6, 
            date38         LIKE type_t.num20_6, 
            date39         LIKE type_t.num20_6, 
            date40         LIKE type_t.num20_6, 
            date41         LIKE type_t.num20_6, 
            date42         LIKE type_t.num20_6, 
            date43         LIKE type_t.num20_6, 
            date44         LIKE type_t.num20_6, 
            date45         LIKE type_t.num20_6, 
            date46         LIKE type_t.num20_6, 
            date47         LIKE type_t.num20_6, 
            date48         LIKE type_t.num20_6, 
            date49         LIKE type_t.num20_6, 
            date50         LIKE type_t.num20_6,
            date51         LIKE type_t.num20_6, 
            date52         LIKE type_t.num20_6, 
            date53         LIKE type_t.num20_6, 
            date54         LIKE type_t.num20_6, 
            date55         LIKE type_t.num20_6, 
            date56         LIKE type_t.num20_6, 
            date57         LIKE type_t.num20_6, 
            date58         LIKE type_t.num20_6, 
            date59         LIKE type_t.num20_6,
            date60         LIKE type_t.num20_6,
            date61         LIKE type_t.num20_6, 
            date62         LIKE type_t.num20_6, 
            date63         LIKE type_t.num20_6, 
            date64         LIKE type_t.num20_6, 
            date65         LIKE type_t.num20_6, 
            date66         LIKE type_t.num20_6, 
            date67         LIKE type_t.num20_6, 
            date68         LIKE type_t.num20_6, 
            date69         LIKE type_t.num20_6,
            date70         LIKE type_t.num20_6,
            date71         LIKE type_t.num20_6, 
            date72         LIKE type_t.num20_6, 
            date73         LIKE type_t.num20_6, 
            date74         LIKE type_t.num20_6, 
            date75         LIKE type_t.num20_6, 
            date76         LIKE type_t.num20_6, 
            date77         LIKE type_t.num20_6, 
            date78         LIKE type_t.num20_6, 
            date79         LIKE type_t.num20_6,
            date80         LIKE type_t.num20_6,
            date81         LIKE type_t.num20_6, 
            date82         LIKE type_t.num20_6, 
            date83         LIKE type_t.num20_6, 
            date84         LIKE type_t.num20_6, 
            date85         LIKE type_t.num20_6, 
            date86         LIKE type_t.num20_6, 
            date87         LIKE type_t.num20_6, 
            date88         LIKE type_t.num20_6, 
            date89         LIKE type_t.num20_6,
            date90         LIKE type_t.num20_6,
            date91         LIKE type_t.num20_6, 
            date92         LIKE type_t.num20_6, 
            date93         LIKE type_t.num20_6, 
            date94         LIKE type_t.num20_6, 
            date95         LIKE type_t.num20_6, 
            date96         LIKE type_t.num20_6, 
            date97         LIKE type_t.num20_6, 
            date98         LIKE type_t.num20_6, 
            date99         LIKE type_t.num20_6,
            date100        LIKE type_t.num20_6
                           END RECORD
   DELETE FROM anmq940_xg_tmp
   FOR l_i = 1 TO g_detail.getLength()
      INITIALIZE l_x01_tmp.* TO NULL
      CALL s_desc_gzcbl004_desc('8026',g_detail[l_i].nmbd003) RETURNING l_nmbd003_desc 
      CALL s_desc_gzcbl004_desc('8709',g_detail[l_i].nmbd004) RETURNING l_nmbd004_desc 
      
      LET l_x01_tmp.seq          = g_detail[l_i].seq
      LET l_x01_tmp.nmfd002      = g_detail[l_i].nmfd002     
      LET l_x01_tmp.nmfd002_desc = g_detail[l_i].nmfd002_desc
      IF NOT cl_null(g_detail[l_i].nmbd003) THEN
         LET l_x01_tmp.nmbd003   = g_detail[l_i].nmbd003,":",l_nmbd003_desc  
      END IF   
      IF NOT cl_null(g_detail[l_i].nmbd004) THEN
         LET l_x01_tmp.nmbd004   = g_detail[l_i].nmbd004,":",l_nmbd004_desc  
      END IF  
      LET l_x01_tmp.sum          = g_detail[l_i].sum         
      LET l_x01_tmp.date1        = g_detail[l_i].date1       
      LET l_x01_tmp.date2        = g_detail[l_i].date2       
      LET l_x01_tmp.date3        = g_detail[l_i].date3       
      LET l_x01_tmp.date4        = g_detail[l_i].date4       
      LET l_x01_tmp.date5        = g_detail[l_i].date5       
      LET l_x01_tmp.date6        = g_detail[l_i].date6       
      LET l_x01_tmp.date7        = g_detail[l_i].date7       
      LET l_x01_tmp.date8        = g_detail[l_i].date8       
      LET l_x01_tmp.date9        = g_detail[l_i].date9       
      LET l_x01_tmp.date10       = g_detail[l_i].date10      
      LET l_x01_tmp.date11       = g_detail[l_i].date11      
      LET l_x01_tmp.date12       = g_detail[l_i].date12      
      LET l_x01_tmp.date13       = g_detail[l_i].date13      
      LET l_x01_tmp.date14       = g_detail[l_i].date14      
      LET l_x01_tmp.date15       = g_detail[l_i].date15      
      LET l_x01_tmp.date16       = g_detail[l_i].date16      
      LET l_x01_tmp.date17       = g_detail[l_i].date17      
      LET l_x01_tmp.date18       = g_detail[l_i].date18      
      LET l_x01_tmp.date19       = g_detail[l_i].date19      
      LET l_x01_tmp.date20       = g_detail[l_i].date20      
      LET l_x01_tmp.date21       = g_detail[l_i].date21      
      LET l_x01_tmp.date22       = g_detail[l_i].date22      
      LET l_x01_tmp.date23       = g_detail[l_i].date23      
      LET l_x01_tmp.date24       = g_detail[l_i].date24      
      LET l_x01_tmp.date25       = g_detail[l_i].date25      
      LET l_x01_tmp.date26       = g_detail[l_i].date26      
      LET l_x01_tmp.date27       = g_detail[l_i].date27      
      LET l_x01_tmp.date28       = g_detail[l_i].date28      
      LET l_x01_tmp.date29       = g_detail[l_i].date29      
      LET l_x01_tmp.date30       = g_detail[l_i].date30      
      LET l_x01_tmp.date31       = g_detail[l_i].date31      
      LET l_x01_tmp.date32       = g_detail[l_i].date32      
      LET l_x01_tmp.date33       = g_detail[l_i].date33      
      LET l_x01_tmp.date34       = g_detail[l_i].date34      
      LET l_x01_tmp.date35       = g_detail[l_i].date35      
      LET l_x01_tmp.date36       = g_detail[l_i].date36      
      LET l_x01_tmp.date37       = g_detail[l_i].date37      
      LET l_x01_tmp.date38       = g_detail[l_i].date38      
      LET l_x01_tmp.date39       = g_detail[l_i].date39      
      LET l_x01_tmp.date40       = g_detail[l_i].date40      
      LET l_x01_tmp.date41       = g_detail[l_i].date41      
      LET l_x01_tmp.date42       = g_detail[l_i].date42      
      LET l_x01_tmp.date43       = g_detail[l_i].date43      
      LET l_x01_tmp.date44       = g_detail[l_i].date44      
      LET l_x01_tmp.date45       = g_detail[l_i].date45      
      LET l_x01_tmp.date46       = g_detail[l_i].date46      
      LET l_x01_tmp.date47       = g_detail[l_i].date47      
      LET l_x01_tmp.date48       = g_detail[l_i].date48      
      LET l_x01_tmp.date49       = g_detail[l_i].date49      
      LET l_x01_tmp.date50       = g_detail[l_i].date50      
      LET l_x01_tmp.date51       = g_detail[l_i].date51      
      LET l_x01_tmp.date52       = g_detail[l_i].date52      
      LET l_x01_tmp.date53       = g_detail[l_i].date53      
      LET l_x01_tmp.date54       = g_detail[l_i].date54      
      LET l_x01_tmp.date55       = g_detail[l_i].date55      
      LET l_x01_tmp.date56       = g_detail[l_i].date56      
      LET l_x01_tmp.date57       = g_detail[l_i].date57      
      LET l_x01_tmp.date58       = g_detail[l_i].date58      
      LET l_x01_tmp.date59       = g_detail[l_i].date59      
      LET l_x01_tmp.date60       = g_detail[l_i].date60      
      LET l_x01_tmp.date61       = g_detail[l_i].date61      
      LET l_x01_tmp.date62       = g_detail[l_i].date62      
      LET l_x01_tmp.date63       = g_detail[l_i].date63      
      LET l_x01_tmp.date64       = g_detail[l_i].date64      
      LET l_x01_tmp.date65       = g_detail[l_i].date65      
      LET l_x01_tmp.date66       = g_detail[l_i].date66      
      LET l_x01_tmp.date67       = g_detail[l_i].date67      
      LET l_x01_tmp.date68       = g_detail[l_i].date68      
      LET l_x01_tmp.date69       = g_detail[l_i].date69      
      LET l_x01_tmp.date70       = g_detail[l_i].date70      
      LET l_x01_tmp.date71       = g_detail[l_i].date71      
      LET l_x01_tmp.date72       = g_detail[l_i].date72      
      LET l_x01_tmp.date73       = g_detail[l_i].date73      
      LET l_x01_tmp.date74       = g_detail[l_i].date74      
      LET l_x01_tmp.date75       = g_detail[l_i].date75      
      LET l_x01_tmp.date76       = g_detail[l_i].date76      
      LET l_x01_tmp.date77       = g_detail[l_i].date77      
      LET l_x01_tmp.date78       = g_detail[l_i].date78      
      LET l_x01_tmp.date79       = g_detail[l_i].date79      
      LET l_x01_tmp.date80       = g_detail[l_i].date80      
      LET l_x01_tmp.date81       = g_detail[l_i].date81      
      LET l_x01_tmp.date82       = g_detail[l_i].date82      
      LET l_x01_tmp.date83       = g_detail[l_i].date83      
      LET l_x01_tmp.date84       = g_detail[l_i].date84      
      LET l_x01_tmp.date85       = g_detail[l_i].date85      
      LET l_x01_tmp.date86       = g_detail[l_i].date86      
      LET l_x01_tmp.date87       = g_detail[l_i].date87      
      LET l_x01_tmp.date88       = g_detail[l_i].date88      
      LET l_x01_tmp.date89       = g_detail[l_i].date89      
      LET l_x01_tmp.date90       = g_detail[l_i].date90      
      LET l_x01_tmp.date91       = g_detail[l_i].date91      
      LET l_x01_tmp.date92       = g_detail[l_i].date92      
      LET l_x01_tmp.date93       = g_detail[l_i].date93      
      LET l_x01_tmp.date94       = g_detail[l_i].date94      
      LET l_x01_tmp.date95       = g_detail[l_i].date95      
      LET l_x01_tmp.date96       = g_detail[l_i].date96      
      LET l_x01_tmp.date97       = g_detail[l_i].date97      
      LET l_x01_tmp.date98       = g_detail[l_i].date98      
      LET l_x01_tmp.date99       = g_detail[l_i].date99      
      LET l_x01_tmp.date100      = g_detail[l_i].date100     
      
      INSERT INTO anmq940_xg_tmp VALUES(l_x01_tmp.*)
   END FOR
   
   LET l_i = 1
   LET tok = base.StringTokenizer.create(g_str,",")
   WHILE tok.hasMoreTokens()
      LET g_xg_fieldname[4 + l_i] = tok.nextToken()
      LET l_i = l_i + 1
   END WHILE
   
   CALL anmq940_x01('1=1','anmq940_xg_tmp',l_i)
END FUNCTION

 
{</section>}
 
