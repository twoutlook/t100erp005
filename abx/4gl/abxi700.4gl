#該程式未解開Section, 採用最新樣板產出!
{<section id="abxi700.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-07-07 09:12:32), PR版次:0001(2016-07-25 16:23:05)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000020
#+ Filename...: abxi700
#+ Description: 年度保稅原料結算資料維護作業
#+ Creator....: 06814(2016-07-07 09:12:32)
#+ Modifier...: 06814 -SD/PR- 06814
 
{</section>}
 
{<section id="abxi700.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#Memos
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"  
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_bxgf_m RECORD
       bxgfsite LIKE bxgf_t.bxgfsite, 
   bxgf001 LIKE bxgf_t.bxgf001, 
   bxgf002 LIKE bxgf_t.bxgf002, 
   bxgf002_desc LIKE type_t.chr80, 
   bxgf002_desc_1 LIKE type_t.chr80, 
   iman013 LIKE iman_t.iman013, 
   iman012 LIKE iman_t.iman012, 
   bxgfstus LIKE bxgf_t.bxgfstus, 
   bxgf003 LIKE bxgf_t.bxgf003, 
   bxgf004 LIKE bxgf_t.bxgf004, 
   bxgf005 LIKE bxgf_t.bxgf005, 
   bxgf006 LIKE bxgf_t.bxgf006, 
   bxgf007 LIKE bxgf_t.bxgf007, 
   bxgf009 LIKE bxgf_t.bxgf009, 
   bxgf008 LIKE bxgf_t.bxgf008, 
   bxgf010 LIKE bxgf_t.bxgf010, 
   bxgf011 LIKE bxgf_t.bxgf011, 
   bxgf012 LIKE bxgf_t.bxgf012, 
   bxgf013 LIKE bxgf_t.bxgf013, 
   bxgf014 LIKE bxgf_t.bxgf014, 
   bxgf015 LIKE bxgf_t.bxgf015, 
   bxgf016 LIKE bxgf_t.bxgf016, 
   bxgfownid LIKE bxgf_t.bxgfownid, 
   bxgfownid_desc LIKE type_t.chr80, 
   bxgfowndp LIKE bxgf_t.bxgfowndp, 
   bxgfowndp_desc LIKE type_t.chr80, 
   bxgfcrtid LIKE bxgf_t.bxgfcrtid, 
   bxgfcrtid_desc LIKE type_t.chr80, 
   bxgfcrtdp LIKE bxgf_t.bxgfcrtdp, 
   bxgfcrtdp_desc LIKE type_t.chr80, 
   bxgfcrtdt LIKE bxgf_t.bxgfcrtdt, 
   bxgfmodid LIKE bxgf_t.bxgfmodid, 
   bxgfmodid_desc LIKE type_t.chr80, 
   bxgfmoddt LIKE bxgf_t.bxgfmoddt, 
   bxgfcnfid LIKE bxgf_t.bxgfcnfid, 
   bxgfcnfid_desc LIKE type_t.chr80, 
   bxgfcnfdt LIKE bxgf_t.bxgfcnfdt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_bxgfsite LIKE bxgf_t.bxgfsite,
      b_bxgf001 LIKE bxgf_t.bxgf001,
      b_bxgf002 LIKE bxgf_t.bxgf002,
      b_bxgf003 LIKE bxgf_t.bxgf003,
      b_bxgf004 LIKE bxgf_t.bxgf004,
      b_bxgf005 LIKE bxgf_t.bxgf005,
      b_bxgf006 LIKE bxgf_t.bxgf006,
      b_bxgf007 LIKE bxgf_t.bxgf007,
      b_bxgf008 LIKE bxgf_t.bxgf008,
      b_bxgf009 LIKE bxgf_t.bxgf009,
      b_bxgf010 LIKE bxgf_t.bxgf010,
      b_bxgf011 LIKE bxgf_t.bxgf011,
      b_bxgf012 LIKE bxgf_t.bxgf012,
      b_bxgf013 LIKE bxgf_t.bxgf013,
      b_bxgf014 LIKE bxgf_t.bxgf014,
      b_bxgf015 LIKE bxgf_t.bxgf015,
      b_bxgf016 LIKE bxgf_t.bxgf016
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_bxgf_m        type_g_bxgf_m  #單頭變數宣告
DEFINE g_bxgf_m_t      type_g_bxgf_m  #單頭舊值宣告(系統還原用)
DEFINE g_bxgf_m_o      type_g_bxgf_m  #單頭舊值宣告(其他用途)
DEFINE g_bxgf_m_mask_o type_g_bxgf_m  #轉換遮罩前資料
DEFINE g_bxgf_m_mask_n type_g_bxgf_m  #轉換遮罩後資料
 
   DEFINE g_bxgfsite_t LIKE bxgf_t.bxgfsite
DEFINE g_bxgf001_t LIKE bxgf_t.bxgf001
DEFINE g_bxgf002_t LIKE bxgf_t.bxgf002
 
   
 
   
 
DEFINE g_wc                  STRING                        #儲存查詢條件
DEFINE g_wc_t                STRING                        #備份查詢條件
DEFINE g_wc_filter           STRING                        #儲存過濾查詢條件
DEFINE g_wc_filter_t         STRING                        #備份過濾查詢條件
DEFINE g_sql                 STRING                        #資料撈取用SQL(含reference)
DEFINE g_forupd_sql          STRING                        #資料鎖定用SQL
DEFINE g_cnt                 LIKE type_t.num10             #指標/統計用變數
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數                         
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING                        #確認前一個動作是否為新增/複製
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息
DEFINE g_aw                  STRING                        #確定當下點擊的單身(modify_detail用)
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #cl_log_modified_record用(舊值)
DEFINE g_log2                STRING                        #cl_log_modified_record用(新值)
 
#快速搜尋用
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序模式
 
#Browser用
DEFINE g_current_idx         LIKE type_t.num10             #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10             #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num10             #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser 總筆數(所有資料)
DEFINE g_row_index           LIKE type_t.num10             #階層樹狀用指標
DEFINE g_add_browse          STRING                        #新增填充用WC
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization" 

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abxi700.main" >}
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
   CALL cl_ap_init("abx","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT bxgfsite,bxgf001,bxgf002,'','','','',bxgfstus,bxgf003,bxgf004,bxgf005, 
       bxgf006,bxgf007,bxgf009,bxgf008,bxgf010,bxgf011,bxgf012,bxgf013,bxgf014,bxgf015,bxgf016,bxgfownid, 
       '',bxgfowndp,'',bxgfcrtid,'',bxgfcrtdp,'',bxgfcrtdt,bxgfmodid,'',bxgfmoddt,bxgfcnfid,'',bxgfcnfdt", 
        
                      " FROM bxgf_t",
                      " WHERE bxgfent= ? AND bxgfsite=? AND bxgf001=? AND bxgf002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abxi700_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bxgfsite,t0.bxgf001,t0.bxgf002,t0.bxgfstus,t0.bxgf003,t0.bxgf004, 
       t0.bxgf005,t0.bxgf006,t0.bxgf007,t0.bxgf009,t0.bxgf008,t0.bxgf010,t0.bxgf011,t0.bxgf012,t0.bxgf013, 
       t0.bxgf014,t0.bxgf015,t0.bxgf016,t0.bxgfownid,t0.bxgfowndp,t0.bxgfcrtid,t0.bxgfcrtdp,t0.bxgfcrtdt, 
       t0.bxgfmodid,t0.bxgfmoddt,t0.bxgfcnfid,t0.bxgfcnfdt,t1.imaal003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 , 
       t5.ooefl003 ,t6.ooag011 ,t7.ooag011",
               " FROM bxgf_t t0",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.bxgf002 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.bxgfownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.bxgfowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.bxgfcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.bxgfcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.bxgfmodid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.bxgfcnfid  ",
 
               " WHERE t0.bxgfent = " ||g_enterprise|| " AND t0.bxgfsite = ? AND t0.bxgf001 = ? AND t0.bxgf002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abxi700_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abxi700 WITH FORM cl_ap_formpath("abx",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abxi700_init()   
 
      #進入選單 Menu (="N")
      CALL abxi700_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abxi700
      
   END IF 
   
   CLOSE abxi700_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abxi700.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abxi700_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('bxgfstus','50','N,Y,X')
 
      CALL cl_set_combo_scc('iman013','1022') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL abxi700_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="abxi700.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abxi700_ui_dialog() 
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num10       #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10       #指標變數
   DEFINE ls_wc     STRING                  #wc用
   DEFINE la_param  RECORD                  #程式串查用變數
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING                  #轉換後的json字串
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 0
 
   #若有外部參數查詢, 則直接顯示資料(隱藏查詢方案)
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL abxi700_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_bxgf_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL abxi700_init()
      END IF
      
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL abxi700_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL abxi700_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL abxi700_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL abxi700_set_act_visible()
               CALL abxi700_set_act_no_visible()
               IF NOT (g_bxgf_m.bxgfsite IS NULL
                 OR g_bxgf_m.bxgf001 IS NULL
                 OR g_bxgf_m.bxgf002 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " bxgfent = " ||g_enterprise|| " AND",
                                     " bxgfsite = '", g_bxgf_m.bxgfsite, "' "
                                     ," AND bxgf001 = '", g_bxgf_m.bxgf001, "' "
                                     ," AND bxgf002 = '", g_bxgf_m.bxgf002, "' "
 
                  #填到對應位置
                  CALL abxi700_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL abxi700_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL abxi700_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL abxi700_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL abxi700_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL abxi700_fetch("L")  
               LET g_current_row = g_current_idx
            
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU
            
            #主頁摺疊
            ON ACTION mainhidden   
               LET g_action_choice = "mainhidden"            
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
                  CALL cl_notice()
               END IF
               EXIT MENU
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               EXIT MENU
            
            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            ON ACTION controls   
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("vb_master",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("vb_master",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden     
               END IF
          
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL abxi700_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL abxi700_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL abxi700_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abxi700_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abxi700_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abxi700_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abxi700_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abxi700_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abxi700_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abxi700_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            
            #主選單用ACTION
            &include "main_menu_exit_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END MENU
      
      ELSE
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
           
      
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
            
               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()     
                  
                  #當每次點任一筆資料都會需要用到               
                  CALL abxi700_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
            #查詢方案用
            SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
            SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL abxi700_browser_fill(g_wc,"")
               END IF
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #還原為原本指定筆數
               IF g_current_row > 1 THEN
                  #當刪除最後一筆資料時可能產生錯誤, 進行額外判斷
                  IF g_current_row > g_browser.getLength() THEN
                     LET g_current_row = g_browser.getLength()
                  END IF 
                  LET g_current_idx = g_current_row
                  CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL abxi700_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL abxi700_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL abxi700_set_act_visible()
               CALL abxi700_set_act_no_visible()
               IF NOT (g_bxgf_m.bxgfsite IS NULL
                 OR g_bxgf_m.bxgf001 IS NULL
                 OR g_bxgf_m.bxgf002 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " bxgfent = " ||g_enterprise|| " AND",
                                     " bxgfsite = '", g_bxgf_m.bxgfsite, "' "
                                     ," AND bxgf001 = '", g_bxgf_m.bxgf001, "' "
                                     ," AND bxgf002 = '", g_bxgf_m.bxgf002, "' "
 
                  #填到對應位置
                  CALL abxi700_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL abxi700_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL abxi700_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL abxi700_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL abxi700_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL abxi700_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL abxi700_fetch("L")  
               LET g_current_row = g_current_idx
         
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
    
            #主頁摺疊
            ON ACTION mainhidden 
               LET g_action_choice = "mainhidden"                
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
                  CALL cl_notice()
               END IF
               #EXIT DIALOG
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               #EXIT DIALOG
         
            ON ACTION exporttoexcel
               LET g_action_choice="exporttoexcel"
               IF cl_auth_chk_act("exporttoexcel") THEN
                  #browser
                  CALL g_export_node.clear()
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               END IF
         
            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            ON ACTION controls   
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("vb_master",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("vb_master",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden     
               END IF
 
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL abxi700_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL abxi700_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL abxi700_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abxi700_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abxi700_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abxi700_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abxi700_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abxi700_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abxi700_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abxi700_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
 
            #主選單用ACTION
            &include "main_menu_exit_dialog.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      
      #(ver:50) ---start---
      IF li_exit THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
      #(ver:50) --- end ---
 
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="abxi700.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION abxi700_browser_fill(p_wc,ps_page_action) 
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
   
   #end add-point
   
   LET l_searchcol = "bxgfsite,bxgf001,bxgf002"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   IF cl_null(p_wc) THEN
      LET p_wc = " bxgfsite = '",g_site,"' "
   ELSE
      LET p_wc = p_wc," AND bxgfsite = '",g_site,"' "
   END IF
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM bxgf_t ",
               "  ",
               "  ",
               " WHERE bxgfent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("bxgf_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   
   #end add-point
                
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt
      FREE header_cnt_pre 
   END IF
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END IF
   
   LET g_error_show = 0
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_bxgf_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.bxgfstus,t0.bxgfsite,t0.bxgf001,t0.bxgf002,t0.bxgf003,t0.bxgf004,t0.bxgf005, 
       t0.bxgf006,t0.bxgf007,t0.bxgf008,t0.bxgf009,t0.bxgf010,t0.bxgf011,t0.bxgf012,t0.bxgf013,t0.bxgf014, 
       t0.bxgf015,t0.bxgf016",
               " FROM bxgf_t t0 ",
               "  ",
               
               " WHERE t0.bxgfent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("bxgf_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   LET g_sql = " SELECT t0.bxgfstus,t0.bxgfsite,t0.bxgf001,t0.bxgf002,t0.bxgf003,t0.bxgf004,t0.bxgf005, 
       t0.bxgf006,t0.bxgf007,t0.bxgf008,t0.bxgf009,t0.bxgf010,t0.bxgf011,t0.bxgf012,t0.bxgf013,t0.bxgf014, 
       t0.bxgf015,t0.bxgf016",
               " FROM bxgf_t t0 ",
               "      LEFT JOIN iman_t t1 ON t0.bxgfent = t1.imanent AND t0.bxgfsite = t1.imansite AND t0.bxgf002 = t1.iman001 ",
               " WHERE t0.bxgfent = '" ||g_enterprise|| "' AND ", ls_wc, cl_sql_add_filter("bxgf_t")
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"bxgf_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_bxgfsite,g_browser[g_cnt].b_bxgf001, 
          g_browser[g_cnt].b_bxgf002,g_browser[g_cnt].b_bxgf003,g_browser[g_cnt].b_bxgf004,g_browser[g_cnt].b_bxgf005, 
          g_browser[g_cnt].b_bxgf006,g_browser[g_cnt].b_bxgf007,g_browser[g_cnt].b_bxgf008,g_browser[g_cnt].b_bxgf009, 
          g_browser[g_cnt].b_bxgf010,g_browser[g_cnt].b_bxgf011,g_browser[g_cnt].b_bxgf012,g_browser[g_cnt].b_bxgf013, 
          g_browser[g_cnt].b_bxgf014,g_browser[g_cnt].b_bxgf015,g_browser[g_cnt].b_bxgf016
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
         
         #遮罩相關處理
         CALL abxi700_browser_mask()
         
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/valid.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/void.png"
         
      END CASE
 
 
 
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_rec THEN
            EXIT FOREACH
         END IF
      END FOREACH
 
      FREE browse_pre
 
   END IF
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_bxgfsite) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_current_cnt = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   LET g_rec_b = g_browser.getLength()
   LET g_cnt = 0
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abxi700.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abxi700_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_bxgf_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON bxgfsite,bxgf001,bxgf002,iman013,iman012,bxgfstus,bxgf003,bxgf004,bxgf005, 
          bxgf006,bxgf007,bxgf009,bxgf008,bxgf010,bxgf011,bxgf012,bxgf013,bxgf014,bxgf015,bxgf016,bxgfownid, 
          bxgfowndp,bxgfcrtid,bxgfcrtdp,bxgfcrtdt,bxgfmodid,bxgfmoddt,bxgfcnfid,bxgfcnfdt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bxgfcrtdt>>----
         AFTER FIELD bxgfcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bxgfmoddt>>----
         AFTER FIELD bxgfmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bxgfcnfdt>>----
         AFTER FIELD bxgfcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bxgfpstdt>>----
 
 
 
      
         #一般欄位
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgfsite
            #add-point:BEFORE FIELD bxgfsite name="construct.b.bxgfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgfsite
            
            #add-point:AFTER FIELD bxgfsite name="construct.a.bxgfsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgfsite
            #add-point:ON ACTION controlp INFIELD bxgfsite name="construct.c.bxgfsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf001
            #add-point:BEFORE FIELD bxgf001 name="construct.b.bxgf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf001
            
            #add-point:AFTER FIELD bxgf001 name="construct.a.bxgf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf001
            #add-point:ON ACTION controlp INFIELD bxgf001 name="construct.c.bxgf001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bxgf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf002
            #add-point:ON ACTION controlp INFIELD bxgf002 name="construct.c.bxgf002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxgf002  #顯示到畫面上
            NEXT FIELD bxgf002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf002
            #add-point:BEFORE FIELD bxgf002 name="construct.b.bxgf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf002
            
            #add-point:AFTER FIELD bxgf002 name="construct.a.bxgf002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iman013
            #add-point:BEFORE FIELD iman013 name="construct.b.iman013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iman013
            
            #add-point:AFTER FIELD iman013 name="construct.a.iman013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iman013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iman013
            #add-point:ON ACTION controlp INFIELD iman013 name="construct.c.iman013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iman012
            #add-point:BEFORE FIELD iman012 name="construct.b.iman012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iman012
            
            #add-point:AFTER FIELD iman012 name="construct.a.iman012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iman012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iman012
            #add-point:ON ACTION controlp INFIELD iman012 name="construct.c.iman012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgfstus
            #add-point:BEFORE FIELD bxgfstus name="construct.b.bxgfstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgfstus
            
            #add-point:AFTER FIELD bxgfstus name="construct.a.bxgfstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgfstus
            #add-point:ON ACTION controlp INFIELD bxgfstus name="construct.c.bxgfstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf003
            #add-point:BEFORE FIELD bxgf003 name="construct.b.bxgf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf003
            
            #add-point:AFTER FIELD bxgf003 name="construct.a.bxgf003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf003
            #add-point:ON ACTION controlp INFIELD bxgf003 name="construct.c.bxgf003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf004
            #add-point:BEFORE FIELD bxgf004 name="construct.b.bxgf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf004
            
            #add-point:AFTER FIELD bxgf004 name="construct.a.bxgf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf004
            #add-point:ON ACTION controlp INFIELD bxgf004 name="construct.c.bxgf004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf005
            #add-point:BEFORE FIELD bxgf005 name="construct.b.bxgf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf005
            
            #add-point:AFTER FIELD bxgf005 name="construct.a.bxgf005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf005
            #add-point:ON ACTION controlp INFIELD bxgf005 name="construct.c.bxgf005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf006
            #add-point:BEFORE FIELD bxgf006 name="construct.b.bxgf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf006
            
            #add-point:AFTER FIELD bxgf006 name="construct.a.bxgf006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf006
            #add-point:ON ACTION controlp INFIELD bxgf006 name="construct.c.bxgf006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf007
            #add-point:BEFORE FIELD bxgf007 name="construct.b.bxgf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf007
            
            #add-point:AFTER FIELD bxgf007 name="construct.a.bxgf007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf007
            #add-point:ON ACTION controlp INFIELD bxgf007 name="construct.c.bxgf007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf009
            #add-point:BEFORE FIELD bxgf009 name="construct.b.bxgf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf009
            
            #add-point:AFTER FIELD bxgf009 name="construct.a.bxgf009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf009
            #add-point:ON ACTION controlp INFIELD bxgf009 name="construct.c.bxgf009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf008
            #add-point:BEFORE FIELD bxgf008 name="construct.b.bxgf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf008
            
            #add-point:AFTER FIELD bxgf008 name="construct.a.bxgf008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf008
            #add-point:ON ACTION controlp INFIELD bxgf008 name="construct.c.bxgf008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf010
            #add-point:BEFORE FIELD bxgf010 name="construct.b.bxgf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf010
            
            #add-point:AFTER FIELD bxgf010 name="construct.a.bxgf010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf010
            #add-point:ON ACTION controlp INFIELD bxgf010 name="construct.c.bxgf010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf011
            #add-point:BEFORE FIELD bxgf011 name="construct.b.bxgf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf011
            
            #add-point:AFTER FIELD bxgf011 name="construct.a.bxgf011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf011
            #add-point:ON ACTION controlp INFIELD bxgf011 name="construct.c.bxgf011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf012
            #add-point:BEFORE FIELD bxgf012 name="construct.b.bxgf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf012
            
            #add-point:AFTER FIELD bxgf012 name="construct.a.bxgf012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf012
            #add-point:ON ACTION controlp INFIELD bxgf012 name="construct.c.bxgf012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf013
            #add-point:BEFORE FIELD bxgf013 name="construct.b.bxgf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf013
            
            #add-point:AFTER FIELD bxgf013 name="construct.a.bxgf013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf013
            #add-point:ON ACTION controlp INFIELD bxgf013 name="construct.c.bxgf013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf014
            #add-point:BEFORE FIELD bxgf014 name="construct.b.bxgf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf014
            
            #add-point:AFTER FIELD bxgf014 name="construct.a.bxgf014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf014
            #add-point:ON ACTION controlp INFIELD bxgf014 name="construct.c.bxgf014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf015
            #add-point:BEFORE FIELD bxgf015 name="construct.b.bxgf015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf015
            
            #add-point:AFTER FIELD bxgf015 name="construct.a.bxgf015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf015
            #add-point:ON ACTION controlp INFIELD bxgf015 name="construct.c.bxgf015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf016
            #add-point:BEFORE FIELD bxgf016 name="construct.b.bxgf016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf016
            
            #add-point:AFTER FIELD bxgf016 name="construct.a.bxgf016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgf016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf016
            #add-point:ON ACTION controlp INFIELD bxgf016 name="construct.c.bxgf016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bxgfownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgfownid
            #add-point:ON ACTION controlp INFIELD bxgfownid name="construct.c.bxgfownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxgfownid  #顯示到畫面上
            NEXT FIELD bxgfownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgfownid
            #add-point:BEFORE FIELD bxgfownid name="construct.b.bxgfownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgfownid
            
            #add-point:AFTER FIELD bxgfownid name="construct.a.bxgfownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgfowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgfowndp
            #add-point:ON ACTION controlp INFIELD bxgfowndp name="construct.c.bxgfowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxgfowndp  #顯示到畫面上
            NEXT FIELD bxgfowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgfowndp
            #add-point:BEFORE FIELD bxgfowndp name="construct.b.bxgfowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgfowndp
            
            #add-point:AFTER FIELD bxgfowndp name="construct.a.bxgfowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgfcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgfcrtid
            #add-point:ON ACTION controlp INFIELD bxgfcrtid name="construct.c.bxgfcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxgfcrtid  #顯示到畫面上
            NEXT FIELD bxgfcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgfcrtid
            #add-point:BEFORE FIELD bxgfcrtid name="construct.b.bxgfcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgfcrtid
            
            #add-point:AFTER FIELD bxgfcrtid name="construct.a.bxgfcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxgfcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgfcrtdp
            #add-point:ON ACTION controlp INFIELD bxgfcrtdp name="construct.c.bxgfcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxgfcrtdp  #顯示到畫面上
            NEXT FIELD bxgfcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgfcrtdp
            #add-point:BEFORE FIELD bxgfcrtdp name="construct.b.bxgfcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgfcrtdp
            
            #add-point:AFTER FIELD bxgfcrtdp name="construct.a.bxgfcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgfcrtdt
            #add-point:BEFORE FIELD bxgfcrtdt name="construct.b.bxgfcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bxgfmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgfmodid
            #add-point:ON ACTION controlp INFIELD bxgfmodid name="construct.c.bxgfmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxgfmodid  #顯示到畫面上
            NEXT FIELD bxgfmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgfmodid
            #add-point:BEFORE FIELD bxgfmodid name="construct.b.bxgfmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgfmodid
            
            #add-point:AFTER FIELD bxgfmodid name="construct.a.bxgfmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgfmoddt
            #add-point:BEFORE FIELD bxgfmoddt name="construct.b.bxgfmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bxgfcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgfcnfid
            #add-point:ON ACTION controlp INFIELD bxgfcnfid name="construct.c.bxgfcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxgfcnfid  #顯示到畫面上
            NEXT FIELD bxgfcnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgfcnfid
            #add-point:BEFORE FIELD bxgfcnfid name="construct.b.bxgfcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgfcnfid
            
            #add-point:AFTER FIELD bxgfcnfid name="construct.a.bxgfcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgfcnfdt
            #add-point:BEFORE FIELD bxgfcnfdt name="construct.b.bxgfcnfdt"
            
            #END add-point
 
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
  
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="abxi700.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abxi700_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON bxgfsite,bxgf001,bxgf002,bxgf003,bxgf004,bxgf005,bxgf006,bxgf007,bxgf008, 
          bxgf009,bxgf010,bxgf011,bxgf012,bxgf013,bxgf014,bxgf015,bxgf016
                          FROM s_browse[1].b_bxgfsite,s_browse[1].b_bxgf001,s_browse[1].b_bxgf002,s_browse[1].b_bxgf003, 
                              s_browse[1].b_bxgf004,s_browse[1].b_bxgf005,s_browse[1].b_bxgf006,s_browse[1].b_bxgf007, 
                              s_browse[1].b_bxgf008,s_browse[1].b_bxgf009,s_browse[1].b_bxgf010,s_browse[1].b_bxgf011, 
                              s_browse[1].b_bxgf012,s_browse[1].b_bxgf013,s_browse[1].b_bxgf014,s_browse[1].b_bxgf015, 
                              s_browse[1].b_bxgf016
 
         BEFORE CONSTRUCT
               DISPLAY abxi700_filter_parser('bxgfsite') TO s_browse[1].b_bxgfsite
            DISPLAY abxi700_filter_parser('bxgf001') TO s_browse[1].b_bxgf001
            DISPLAY abxi700_filter_parser('bxgf002') TO s_browse[1].b_bxgf002
            DISPLAY abxi700_filter_parser('bxgf003') TO s_browse[1].b_bxgf003
            DISPLAY abxi700_filter_parser('bxgf004') TO s_browse[1].b_bxgf004
            DISPLAY abxi700_filter_parser('bxgf005') TO s_browse[1].b_bxgf005
            DISPLAY abxi700_filter_parser('bxgf006') TO s_browse[1].b_bxgf006
            DISPLAY abxi700_filter_parser('bxgf007') TO s_browse[1].b_bxgf007
            DISPLAY abxi700_filter_parser('bxgf008') TO s_browse[1].b_bxgf008
            DISPLAY abxi700_filter_parser('bxgf009') TO s_browse[1].b_bxgf009
            DISPLAY abxi700_filter_parser('bxgf010') TO s_browse[1].b_bxgf010
            DISPLAY abxi700_filter_parser('bxgf011') TO s_browse[1].b_bxgf011
            DISPLAY abxi700_filter_parser('bxgf012') TO s_browse[1].b_bxgf012
            DISPLAY abxi700_filter_parser('bxgf013') TO s_browse[1].b_bxgf013
            DISPLAY abxi700_filter_parser('bxgf014') TO s_browse[1].b_bxgf014
            DISPLAY abxi700_filter_parser('bxgf015') TO s_browse[1].b_bxgf015
            DISPLAY abxi700_filter_parser('bxgf016') TO s_browse[1].b_bxgf016
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
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
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL abxi700_filter_show('bxgfsite')
   CALL abxi700_filter_show('bxgf001')
   CALL abxi700_filter_show('bxgf002')
   CALL abxi700_filter_show('bxgf003')
   CALL abxi700_filter_show('bxgf004')
   CALL abxi700_filter_show('bxgf005')
   CALL abxi700_filter_show('bxgf006')
   CALL abxi700_filter_show('bxgf007')
   CALL abxi700_filter_show('bxgf008')
   CALL abxi700_filter_show('bxgf009')
   CALL abxi700_filter_show('bxgf010')
   CALL abxi700_filter_show('bxgf011')
   CALL abxi700_filter_show('bxgf012')
   CALL abxi700_filter_show('bxgf013')
   CALL abxi700_filter_show('bxgf014')
   CALL abxi700_filter_show('bxgf015')
   CALL abxi700_filter_show('bxgf016')
 
END FUNCTION
 
{</section>}
 
{<section id="abxi700.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abxi700_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
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
 
{<section id="abxi700.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abxi700_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = abxi700_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abxi700.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abxi700_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL g_browser.clear() 
 
   #browser panel折疊
   IF g_worksheet_hidden THEN
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   
   #單頭折疊
   IF g_header_hidden THEN
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_bxgf_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL abxi700_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abxi700_browser_fill(g_wc,"F")
      CALL abxi700_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL abxi700_browser_fill(g_wc,"F")   # 移到第一頁
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL abxi700_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="abxi700.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abxi700_fetch(p_fl)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #根據傳入的條件決定抓取的資料
   CASE p_fl
      WHEN "F" 
         LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN "L" 
         #LET g_current_idx = g_header_cnt        
         LET g_current_idx = g_browser.getLength()    
      WHEN "/"
         #詢問要指定的筆數
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE     
   END CASE
 
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
   END IF
   
   
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength() 
   END IF
   
   # 設定browse索引
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_bxgf_m.bxgfsite = g_browser[g_current_idx].b_bxgfsite
   LET g_bxgf_m.bxgf001 = g_browser[g_current_idx].b_bxgf001
   LET g_bxgf_m.bxgf002 = g_browser[g_current_idx].b_bxgf002
 
                       
   #讀取單頭所有欄位資料
   EXECUTE abxi700_master_referesh USING g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002 INTO g_bxgf_m.bxgfsite, 
       g_bxgf_m.bxgf001,g_bxgf_m.bxgf002,g_bxgf_m.bxgfstus,g_bxgf_m.bxgf003,g_bxgf_m.bxgf004,g_bxgf_m.bxgf005, 
       g_bxgf_m.bxgf006,g_bxgf_m.bxgf007,g_bxgf_m.bxgf009,g_bxgf_m.bxgf008,g_bxgf_m.bxgf010,g_bxgf_m.bxgf011, 
       g_bxgf_m.bxgf012,g_bxgf_m.bxgf013,g_bxgf_m.bxgf014,g_bxgf_m.bxgf015,g_bxgf_m.bxgf016,g_bxgf_m.bxgfownid, 
       g_bxgf_m.bxgfowndp,g_bxgf_m.bxgfcrtid,g_bxgf_m.bxgfcrtdp,g_bxgf_m.bxgfcrtdt,g_bxgf_m.bxgfmodid, 
       g_bxgf_m.bxgfmoddt,g_bxgf_m.bxgfcnfid,g_bxgf_m.bxgfcnfdt,g_bxgf_m.bxgf002_desc,g_bxgf_m.bxgfownid_desc, 
       g_bxgf_m.bxgfowndp_desc,g_bxgf_m.bxgfcrtid_desc,g_bxgf_m.bxgfcrtdp_desc,g_bxgf_m.bxgfmodid_desc, 
       g_bxgf_m.bxgfcnfid_desc
   
   #遮罩相關處理
   LET g_bxgf_m_mask_o.* =  g_bxgf_m.*
   CALL abxi700_bxgf_t_mask()
   LET g_bxgf_m_mask_n.* =  g_bxgf_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL abxi700_set_act_visible()
   CALL abxi700_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_bxgf_m_t.* = g_bxgf_m.*
   LET g_bxgf_m_o.* = g_bxgf_m.*
   
   LET g_data_owner = g_bxgf_m.bxgfownid      
   LET g_data_dept  = g_bxgf_m.bxgfowndp
   
   #重新顯示
   CALL abxi700_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="abxi700.insert" >}
#+ 資料新增
PRIVATE FUNCTION abxi700_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_bxgf_m.* TO NULL             #DEFAULT 設定
   LET g_bxgfsite_t = NULL
   LET g_bxgf001_t = NULL
   LET g_bxgf002_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bxgf_m.bxgfownid = g_user
      LET g_bxgf_m.bxgfowndp = g_dept
      LET g_bxgf_m.bxgfcrtid = g_user
      LET g_bxgf_m.bxgfcrtdp = g_dept 
      LET g_bxgf_m.bxgfcrtdt = cl_get_current()
      LET g_bxgf_m.bxgfmodid = g_user
      LET g_bxgf_m.bxgfmoddt = cl_get_current()
      LET g_bxgf_m.bxgfstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_bxgf_m.bxgfstus = "Y"
      LET g_bxgf_m.bxgf003 = "0"
      LET g_bxgf_m.bxgf004 = "0"
      LET g_bxgf_m.bxgf005 = "0"
      LET g_bxgf_m.bxgf006 = "0"
      LET g_bxgf_m.bxgf007 = "0"
      LET g_bxgf_m.bxgf009 = "0"
      LET g_bxgf_m.bxgf008 = "0"
      LET g_bxgf_m.bxgf010 = "0"
      LET g_bxgf_m.bxgf011 = "0"
      LET g_bxgf_m.bxgf012 = "0"
      LET g_bxgf_m.bxgf013 = "0"
      LET g_bxgf_m.bxgf014 = "0"
      LET g_bxgf_m.bxgf015 = "0"
      LET g_bxgf_m.bxgf016 = "0"
 
 
      #add-point:單頭預設值 name="insert.default"
      LET g_bxgf_m.bxgfsite = g_site
      #用g_today去抓取aooi420的年度
      #行事曆參照表號=該據點的ooef008
      #行事曆類別=該據點的ooef009
      
      SELECT oogc015 
        INTO g_bxgf_m.bxgf001 
        FROM oogc_t 
       WHERE oogcent = g_enterprise
         AND oogc001 = (SELECT ooef008 FROM ooef_t WHERE ooefent = oogcent AND ooef001 = g_site) 
         AND oogc002 = (SELECT ooef009 FROM ooef_t WHERE ooefent = oogcent AND ooef001 = g_site) 
         AND oogc003 = g_today
      LET g_bxgf_m.bxgfcnfid = g_user
      LET g_bxgf_m.bxgfcnfdt = cl_get_current()
      
      LET g_bxgf_m_o.* = g_bxgf_m.*
      LET g_bxgf_m_t.* = g_bxgf_m.*
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bxgf_m.bxgfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL abxi700_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_bxgf_m.* TO NULL
         CALL abxi700_show()
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL abxi700_set_act_visible()
   CALL abxi700_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bxgfsite_t = g_bxgf_m.bxgfsite
   LET g_bxgf001_t = g_bxgf_m.bxgf001
   LET g_bxgf002_t = g_bxgf_m.bxgf002
 
   
   #組合新增資料的條件
   LET g_add_browse = " bxgfent = " ||g_enterprise|| " AND",
                      " bxgfsite = '", g_bxgf_m.bxgfsite, "' "
                      ," AND bxgf001 = '", g_bxgf_m.bxgf001, "' "
                      ," AND bxgf002 = '", g_bxgf_m.bxgf002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abxi700_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abxi700_master_referesh USING g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002 INTO g_bxgf_m.bxgfsite, 
       g_bxgf_m.bxgf001,g_bxgf_m.bxgf002,g_bxgf_m.bxgfstus,g_bxgf_m.bxgf003,g_bxgf_m.bxgf004,g_bxgf_m.bxgf005, 
       g_bxgf_m.bxgf006,g_bxgf_m.bxgf007,g_bxgf_m.bxgf009,g_bxgf_m.bxgf008,g_bxgf_m.bxgf010,g_bxgf_m.bxgf011, 
       g_bxgf_m.bxgf012,g_bxgf_m.bxgf013,g_bxgf_m.bxgf014,g_bxgf_m.bxgf015,g_bxgf_m.bxgf016,g_bxgf_m.bxgfownid, 
       g_bxgf_m.bxgfowndp,g_bxgf_m.bxgfcrtid,g_bxgf_m.bxgfcrtdp,g_bxgf_m.bxgfcrtdt,g_bxgf_m.bxgfmodid, 
       g_bxgf_m.bxgfmoddt,g_bxgf_m.bxgfcnfid,g_bxgf_m.bxgfcnfdt,g_bxgf_m.bxgf002_desc,g_bxgf_m.bxgfownid_desc, 
       g_bxgf_m.bxgfowndp_desc,g_bxgf_m.bxgfcrtid_desc,g_bxgf_m.bxgfcrtdp_desc,g_bxgf_m.bxgfmodid_desc, 
       g_bxgf_m.bxgfcnfid_desc
   
   
   #遮罩相關處理
   LET g_bxgf_m_mask_o.* =  g_bxgf_m.*
   CALL abxi700_bxgf_t_mask()
   LET g_bxgf_m_mask_n.* =  g_bxgf_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002,g_bxgf_m.bxgf002_desc,g_bxgf_m.bxgf002_desc_1, 
       g_bxgf_m.iman013,g_bxgf_m.iman012,g_bxgf_m.bxgfstus,g_bxgf_m.bxgf003,g_bxgf_m.bxgf004,g_bxgf_m.bxgf005, 
       g_bxgf_m.bxgf006,g_bxgf_m.bxgf007,g_bxgf_m.bxgf009,g_bxgf_m.bxgf008,g_bxgf_m.bxgf010,g_bxgf_m.bxgf011, 
       g_bxgf_m.bxgf012,g_bxgf_m.bxgf013,g_bxgf_m.bxgf014,g_bxgf_m.bxgf015,g_bxgf_m.bxgf016,g_bxgf_m.bxgfownid, 
       g_bxgf_m.bxgfownid_desc,g_bxgf_m.bxgfowndp,g_bxgf_m.bxgfowndp_desc,g_bxgf_m.bxgfcrtid,g_bxgf_m.bxgfcrtid_desc, 
       g_bxgf_m.bxgfcrtdp,g_bxgf_m.bxgfcrtdp_desc,g_bxgf_m.bxgfcrtdt,g_bxgf_m.bxgfmodid,g_bxgf_m.bxgfmodid_desc, 
       g_bxgf_m.bxgfmoddt,g_bxgf_m.bxgfcnfid,g_bxgf_m.bxgfcnfid_desc,g_bxgf_m.bxgfcnfdt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_bxgf_m.bxgfownid      
   LET g_data_dept  = g_bxgf_m.bxgfowndp
 
   #功能已完成,通報訊息中心
   CALL abxi700_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abxi700.modify" >}
#+ 資料修改
PRIVATE FUNCTION abxi700_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_bxgf_m.bxgfsite IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_bxgfsite_t = g_bxgf_m.bxgfsite
   LET g_bxgf001_t = g_bxgf_m.bxgf001
   LET g_bxgf002_t = g_bxgf_m.bxgf002
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN abxi700_cl USING g_enterprise,g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abxi700_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE abxi700_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abxi700_master_referesh USING g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002 INTO g_bxgf_m.bxgfsite, 
       g_bxgf_m.bxgf001,g_bxgf_m.bxgf002,g_bxgf_m.bxgfstus,g_bxgf_m.bxgf003,g_bxgf_m.bxgf004,g_bxgf_m.bxgf005, 
       g_bxgf_m.bxgf006,g_bxgf_m.bxgf007,g_bxgf_m.bxgf009,g_bxgf_m.bxgf008,g_bxgf_m.bxgf010,g_bxgf_m.bxgf011, 
       g_bxgf_m.bxgf012,g_bxgf_m.bxgf013,g_bxgf_m.bxgf014,g_bxgf_m.bxgf015,g_bxgf_m.bxgf016,g_bxgf_m.bxgfownid, 
       g_bxgf_m.bxgfowndp,g_bxgf_m.bxgfcrtid,g_bxgf_m.bxgfcrtdp,g_bxgf_m.bxgfcrtdt,g_bxgf_m.bxgfmodid, 
       g_bxgf_m.bxgfmoddt,g_bxgf_m.bxgfcnfid,g_bxgf_m.bxgfcnfdt,g_bxgf_m.bxgf002_desc,g_bxgf_m.bxgfownid_desc, 
       g_bxgf_m.bxgfowndp_desc,g_bxgf_m.bxgfcrtid_desc,g_bxgf_m.bxgfcrtdp_desc,g_bxgf_m.bxgfmodid_desc, 
       g_bxgf_m.bxgfcnfid_desc
 
   #檢查是否允許此動作
   IF NOT abxi700_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_bxgf_m_mask_o.* =  g_bxgf_m.*
   CALL abxi700_bxgf_t_mask()
   LET g_bxgf_m_mask_n.* =  g_bxgf_m.*
   
   
 
   #顯示資料
   CALL abxi700_show()
   
   WHILE TRUE
      LET g_bxgf_m.bxgfsite = g_bxgfsite_t
      LET g_bxgf_m.bxgf001 = g_bxgf001_t
      LET g_bxgf_m.bxgf002 = g_bxgf002_t
 
      
      #寫入修改者/修改日期資訊
      LET g_bxgf_m.bxgfmodid = g_user 
LET g_bxgf_m.bxgfmoddt = cl_get_current()
LET g_bxgf_m.bxgfmodid_desc = cl_get_username(g_bxgf_m.bxgfmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL abxi700_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bxgf_m.* = g_bxgf_m_t.*
         CALL abxi700_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE bxgf_t SET (bxgfmodid,bxgfmoddt) = (g_bxgf_m.bxgfmodid,g_bxgf_m.bxgfmoddt)
       WHERE bxgfent = g_enterprise AND bxgfsite = g_bxgfsite_t
         AND bxgf001 = g_bxgf001_t
         AND bxgf002 = g_bxgf002_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL abxi700_set_act_visible()
   CALL abxi700_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bxgfent = " ||g_enterprise|| " AND",
                      " bxgfsite = '", g_bxgf_m.bxgfsite, "' "
                      ," AND bxgf001 = '", g_bxgf_m.bxgf001, "' "
                      ," AND bxgf002 = '", g_bxgf_m.bxgf002, "' "
 
   #填到對應位置
   CALL abxi700_browser_fill(g_wc,"")
 
   CLOSE abxi700_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abxi700_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="abxi700.input" >}
#+ 資料輸入
PRIVATE FUNCTION abxi700_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num10       #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num10       #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num10
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換至輸入畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002,g_bxgf_m.bxgf002_desc,g_bxgf_m.bxgf002_desc_1, 
       g_bxgf_m.iman013,g_bxgf_m.iman012,g_bxgf_m.bxgfstus,g_bxgf_m.bxgf003,g_bxgf_m.bxgf004,g_bxgf_m.bxgf005, 
       g_bxgf_m.bxgf006,g_bxgf_m.bxgf007,g_bxgf_m.bxgf009,g_bxgf_m.bxgf008,g_bxgf_m.bxgf010,g_bxgf_m.bxgf011, 
       g_bxgf_m.bxgf012,g_bxgf_m.bxgf013,g_bxgf_m.bxgf014,g_bxgf_m.bxgf015,g_bxgf_m.bxgf016,g_bxgf_m.bxgfownid, 
       g_bxgf_m.bxgfownid_desc,g_bxgf_m.bxgfowndp,g_bxgf_m.bxgfowndp_desc,g_bxgf_m.bxgfcrtid,g_bxgf_m.bxgfcrtid_desc, 
       g_bxgf_m.bxgfcrtdp,g_bxgf_m.bxgfcrtdp_desc,g_bxgf_m.bxgfcrtdt,g_bxgf_m.bxgfmodid,g_bxgf_m.bxgfmodid_desc, 
       g_bxgf_m.bxgfmoddt,g_bxgf_m.bxgfcnfid,g_bxgf_m.bxgfcnfid_desc,g_bxgf_m.bxgfcnfdt
   
   CALL cl_set_head_visible("","YES")  
   
   #a-新增,r-複製,u-修改
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL abxi700_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abxi700_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002,g_bxgf_m.bxgfstus,g_bxgf_m.bxgf003, 
          g_bxgf_m.bxgf004,g_bxgf_m.bxgf005,g_bxgf_m.bxgf006,g_bxgf_m.bxgf007,g_bxgf_m.bxgf009,g_bxgf_m.bxgf008, 
          g_bxgf_m.bxgf010,g_bxgf_m.bxgf011,g_bxgf_m.bxgf012,g_bxgf_m.bxgf013,g_bxgf_m.bxgf014,g_bxgf_m.bxgf015, 
          g_bxgf_m.bxgf016 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgfsite
            #add-point:BEFORE FIELD bxgfsite name="input.b.bxgfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgfsite
            
            #add-point:AFTER FIELD bxgfsite name="input.a.bxgfsite"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bxgf_m.bxgfsite) AND NOT cl_null(g_bxgf_m.bxgf001) AND NOT cl_null(g_bxgf_m.bxgf002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bxgf_m.bxgfsite != g_bxgfsite_t  OR g_bxgf_m.bxgf001 != g_bxgf001_t  OR g_bxgf_m.bxgf002 != g_bxgf002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bxgf_t WHERE "||"bxgfent = '" ||g_enterprise|| "' AND "||"bxgfsite = '"||g_bxgf_m.bxgfsite ||"' AND "|| "bxgf001 = '"||g_bxgf_m.bxgf001 ||"' AND "|| "bxgf002 = '"||g_bxgf_m.bxgf002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgfsite
            #add-point:ON CHANGE bxgfsite name="input.g.bxgfsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf001
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf001,"1911","1","3000","1","azz-00087",1) THEN
               NEXT FIELD bxgf001
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf001 name="input.a.bxgf001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bxgf_m.bxgfsite) AND NOT cl_null(g_bxgf_m.bxgf001) AND NOT cl_null(g_bxgf_m.bxgf002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bxgf_m.bxgfsite != g_bxgfsite_t  OR g_bxgf_m.bxgf001 != g_bxgf001_t  OR g_bxgf_m.bxgf002 != g_bxgf002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bxgf_t WHERE "||"bxgfent = '" ||g_enterprise|| "' AND "||"bxgfsite = '"||g_bxgf_m.bxgfsite ||"' AND "|| "bxgf001 = '"||g_bxgf_m.bxgf001 ||"' AND "|| "bxgf002 = '"||g_bxgf_m.bxgf002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf001
            #add-point:BEFORE FIELD bxgf001 name="input.b.bxgf001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf001
            #add-point:ON CHANGE bxgf001 name="input.g.bxgf001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf002
            
            #add-point:AFTER FIELD bxgf002 name="input.a.bxgf002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bxgf_m.bxgfsite) AND NOT cl_null(g_bxgf_m.bxgf001) AND NOT cl_null(g_bxgf_m.bxgf002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bxgf_m.bxgfsite != g_bxgfsite_t  OR g_bxgf_m.bxgf001 != g_bxgf001_t  OR g_bxgf_m.bxgf002 != g_bxgf002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bxgf_t WHERE "||"bxgfent = '" ||g_enterprise|| "' AND "||"bxgfsite = '"||g_bxgf_m.bxgfsite ||"' AND "|| "bxgf001 = '"||g_bxgf_m.bxgf001 ||"' AND "|| "bxgf002 = '"||g_bxgf_m.bxgf002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_bxgf_m.bxgf002) AND g_bxgf_m_o.bxgf002 != g_bxgf_m.bxgf002 OR cl_null(g_bxgf_m_o.bxgf002) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_bxgf_m.bxgf002
               LET g_errshow = 1
               IF NOT cl_chk_exist("v_imaf001_1") THEN
                  LET g_bxgf_m.bxgf002 = g_bxgf_m_o.bxgf002
                  CALL abxi700_bxgf002_ref()
                  NEXT FIELD CURRENT                  
               END IF
            END IF
            LET g_bxgf_m_o.bxgf002 = g_bxgf_m.bxgf002
            CALL abxi700_bxgf002_ref()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf002
            #add-point:BEFORE FIELD bxgf002 name="input.b.bxgf002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf002
            #add-point:ON CHANGE bxgf002 name="input.g.bxgf002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgfstus
            #add-point:BEFORE FIELD bxgfstus name="input.b.bxgfstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgfstus
            
            #add-point:AFTER FIELD bxgfstus name="input.a.bxgfstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgfstus
            #add-point:ON CHANGE bxgfstus name="input.g.bxgfstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf003,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bxgf003
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf003 name="input.a.bxgf003"
            IF NOT cl_null(g_bxgf_m.bxgf003) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf003
            #add-point:BEFORE FIELD bxgf003 name="input.b.bxgf003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf003
            #add-point:ON CHANGE bxgf003 name="input.g.bxgf003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf004,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bxgf004
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf004 name="input.a.bxgf004"
            IF NOT cl_null(g_bxgf_m.bxgf004) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf004
            #add-point:BEFORE FIELD bxgf004 name="input.b.bxgf004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf004
            #add-point:ON CHANGE bxgf004 name="input.g.bxgf004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bxgf005
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf005 name="input.a.bxgf005"
            IF NOT cl_null(g_bxgf_m.bxgf005) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf005
            #add-point:BEFORE FIELD bxgf005 name="input.b.bxgf005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf005
            #add-point:ON CHANGE bxgf005 name="input.g.bxgf005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf006,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bxgf006
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf006 name="input.a.bxgf006"
            IF NOT cl_null(g_bxgf_m.bxgf006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf006
            #add-point:BEFORE FIELD bxgf006 name="input.b.bxgf006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf006
            #add-point:ON CHANGE bxgf006 name="input.g.bxgf006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bxgf007
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf007 name="input.a.bxgf007"
            IF NOT cl_null(g_bxgf_m.bxgf007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf007
            #add-point:BEFORE FIELD bxgf007 name="input.b.bxgf007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf007
            #add-point:ON CHANGE bxgf007 name="input.g.bxgf007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bxgf009
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf009 name="input.a.bxgf009"
            IF NOT cl_null(g_bxgf_m.bxgf009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf009
            #add-point:BEFORE FIELD bxgf009 name="input.b.bxgf009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf009
            #add-point:ON CHANGE bxgf009 name="input.g.bxgf009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf008,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bxgf008
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf008 name="input.a.bxgf008"
            IF NOT cl_null(g_bxgf_m.bxgf008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf008
            #add-point:BEFORE FIELD bxgf008 name="input.b.bxgf008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf008
            #add-point:ON CHANGE bxgf008 name="input.g.bxgf008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf010,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bxgf010
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf010 name="input.a.bxgf010"
            IF NOT cl_null(g_bxgf_m.bxgf010) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf010
            #add-point:BEFORE FIELD bxgf010 name="input.b.bxgf010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf010
            #add-point:ON CHANGE bxgf010 name="input.g.bxgf010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf011,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bxgf011
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf011 name="input.a.bxgf011"
            IF NOT cl_null(g_bxgf_m.bxgf011) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf011
            #add-point:BEFORE FIELD bxgf011 name="input.b.bxgf011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf011
            #add-point:ON CHANGE bxgf011 name="input.g.bxgf011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf012,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bxgf012
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf012 name="input.a.bxgf012"
            IF NOT cl_null(g_bxgf_m.bxgf012) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf012
            #add-point:BEFORE FIELD bxgf012 name="input.b.bxgf012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf012
            #add-point:ON CHANGE bxgf012 name="input.g.bxgf012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf013,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bxgf013
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf013 name="input.a.bxgf013"
            IF NOT cl_null(g_bxgf_m.bxgf013) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf013
            #add-point:BEFORE FIELD bxgf013 name="input.b.bxgf013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf013
            #add-point:ON CHANGE bxgf013 name="input.g.bxgf013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf014,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bxgf014
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf014 name="input.a.bxgf014"
            IF NOT cl_null(g_bxgf_m.bxgf014) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf014
            #add-point:BEFORE FIELD bxgf014 name="input.b.bxgf014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf014
            #add-point:ON CHANGE bxgf014 name="input.g.bxgf014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf015,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bxgf015
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf015 name="input.a.bxgf015"
            IF NOT cl_null(g_bxgf_m.bxgf015) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf015
            #add-point:BEFORE FIELD bxgf015 name="input.b.bxgf015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf015
            #add-point:ON CHANGE bxgf015 name="input.g.bxgf015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxgf016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxgf_m.bxgf016,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bxgf016
            END IF 
 
 
 
            #add-point:AFTER FIELD bxgf016 name="input.a.bxgf016"
            IF NOT cl_null(g_bxgf_m.bxgf016) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxgf016
            #add-point:BEFORE FIELD bxgf016 name="input.b.bxgf016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxgf016
            #add-point:ON CHANGE bxgf016 name="input.g.bxgf016"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bxgfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgfsite
            #add-point:ON ACTION controlp INFIELD bxgfsite name="input.c.bxgfsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf001
            #add-point:ON ACTION controlp INFIELD bxgf001 name="input.c.bxgf001"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf002
            #add-point:ON ACTION controlp INFIELD bxgf002 name="input.c.bxgf002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bxgf_m.bxgf002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_imaf001()                                #呼叫開窗
 
            LET g_bxgf_m.bxgf002 = g_qryparam.return1              
            CALL abxi700_bxgf002_ref()
            DISPLAY g_bxgf_m.bxgf002 TO bxgf002              #

            NEXT FIELD bxgf002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bxgfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgfstus
            #add-point:ON ACTION controlp INFIELD bxgfstus name="input.c.bxgfstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf003
            #add-point:ON ACTION controlp INFIELD bxgf003 name="input.c.bxgf003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf004
            #add-point:ON ACTION controlp INFIELD bxgf004 name="input.c.bxgf004"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf005
            #add-point:ON ACTION controlp INFIELD bxgf005 name="input.c.bxgf005"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf006
            #add-point:ON ACTION controlp INFIELD bxgf006 name="input.c.bxgf006"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf007
            #add-point:ON ACTION controlp INFIELD bxgf007 name="input.c.bxgf007"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf009
            #add-point:ON ACTION controlp INFIELD bxgf009 name="input.c.bxgf009"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf008
            #add-point:ON ACTION controlp INFIELD bxgf008 name="input.c.bxgf008"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf010
            #add-point:ON ACTION controlp INFIELD bxgf010 name="input.c.bxgf010"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf011
            #add-point:ON ACTION controlp INFIELD bxgf011 name="input.c.bxgf011"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf012
            #add-point:ON ACTION controlp INFIELD bxgf012 name="input.c.bxgf012"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf013
            #add-point:ON ACTION controlp INFIELD bxgf013 name="input.c.bxgf013"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf014
            #add-point:ON ACTION controlp INFIELD bxgf014 name="input.c.bxgf014"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf015
            #add-point:ON ACTION controlp INFIELD bxgf015 name="input.c.bxgf015"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxgf016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxgf016
            #add-point:ON ACTION controlp INFIELD bxgf016 name="input.c.bxgf016"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
  
            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1  
 
               #確定新增的資料不存在(不重複)
               SELECT COUNT(1) INTO l_count FROM bxgf_t
                WHERE bxgfent = g_enterprise AND bxgfsite = g_bxgf_m.bxgfsite
                  AND bxgf001 = g_bxgf_m.bxgf001
                  AND bxgf002 = g_bxgf_m.bxgf002
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO bxgf_t (bxgfent,bxgfsite,bxgf001,bxgf002,bxgfstus,bxgf003,bxgf004,bxgf005, 
                      bxgf006,bxgf007,bxgf009,bxgf008,bxgf010,bxgf011,bxgf012,bxgf013,bxgf014,bxgf015, 
                      bxgf016,bxgfownid,bxgfowndp,bxgfcrtid,bxgfcrtdp,bxgfcrtdt,bxgfmodid,bxgfmoddt, 
                      bxgfcnfid,bxgfcnfdt)
                  VALUES (g_enterprise,g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002,g_bxgf_m.bxgfstus, 
                      g_bxgf_m.bxgf003,g_bxgf_m.bxgf004,g_bxgf_m.bxgf005,g_bxgf_m.bxgf006,g_bxgf_m.bxgf007, 
                      g_bxgf_m.bxgf009,g_bxgf_m.bxgf008,g_bxgf_m.bxgf010,g_bxgf_m.bxgf011,g_bxgf_m.bxgf012, 
                      g_bxgf_m.bxgf013,g_bxgf_m.bxgf014,g_bxgf_m.bxgf015,g_bxgf_m.bxgf016,g_bxgf_m.bxgfownid, 
                      g_bxgf_m.bxgfowndp,g_bxgf_m.bxgfcrtid,g_bxgf_m.bxgfcrtdp,g_bxgf_m.bxgfcrtdt,g_bxgf_m.bxgfmodid, 
                      g_bxgf_m.bxgfmoddt,g_bxgf_m.bxgfcnfid,g_bxgf_m.bxgfcnfdt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bxgf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_bxgf_m.bxgfsite
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL abxi700_bxgf_t_mask_restore('restore_mask_o')
               
               UPDATE bxgf_t SET (bxgfsite,bxgf001,bxgf002,bxgfstus,bxgf003,bxgf004,bxgf005,bxgf006, 
                   bxgf007,bxgf009,bxgf008,bxgf010,bxgf011,bxgf012,bxgf013,bxgf014,bxgf015,bxgf016,bxgfownid, 
                   bxgfowndp,bxgfcrtid,bxgfcrtdp,bxgfcrtdt,bxgfmodid,bxgfmoddt,bxgfcnfid,bxgfcnfdt) = (g_bxgf_m.bxgfsite, 
                   g_bxgf_m.bxgf001,g_bxgf_m.bxgf002,g_bxgf_m.bxgfstus,g_bxgf_m.bxgf003,g_bxgf_m.bxgf004, 
                   g_bxgf_m.bxgf005,g_bxgf_m.bxgf006,g_bxgf_m.bxgf007,g_bxgf_m.bxgf009,g_bxgf_m.bxgf008, 
                   g_bxgf_m.bxgf010,g_bxgf_m.bxgf011,g_bxgf_m.bxgf012,g_bxgf_m.bxgf013,g_bxgf_m.bxgf014, 
                   g_bxgf_m.bxgf015,g_bxgf_m.bxgf016,g_bxgf_m.bxgfownid,g_bxgf_m.bxgfowndp,g_bxgf_m.bxgfcrtid, 
                   g_bxgf_m.bxgfcrtdp,g_bxgf_m.bxgfcrtdt,g_bxgf_m.bxgfmodid,g_bxgf_m.bxgfmoddt,g_bxgf_m.bxgfcnfid, 
                   g_bxgf_m.bxgfcnfdt)
                WHERE bxgfent = g_enterprise AND bxgfsite = g_bxgfsite_t #
                  AND bxgf001 = g_bxgf001_t
                  AND bxgf002 = g_bxgf002_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bxgf_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bxgf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL abxi700_bxgf_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_bxgf_m_t)
                     LET g_log2 = util.JSON.stringify(g_bxgf_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
               
            END IF
           #controlp
      END INPUT
      
      #add-point:input段more input  name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog  name="input.before_dialog"
         
         #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         ACCEPT DIALOG
         
      #放棄輸入
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close 
         LET INT_FLAG = TRUE 
         EXIT DIALOG
    
      #toolbar 離開
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="abxi700.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abxi700_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE bxgf_t.bxgfsite 
   DEFINE l_oldno     LIKE bxgf_t.bxgfsite 
   DEFINE l_newno02     LIKE bxgf_t.bxgf001 
   DEFINE l_oldno02     LIKE bxgf_t.bxgf001 
   DEFINE l_newno03     LIKE bxgf_t.bxgf002 
   DEFINE l_oldno03     LIKE bxgf_t.bxgf002 
 
   DEFINE l_master    RECORD LIKE bxgf_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #先確定key值無遺漏
   IF g_bxgf_m.bxgfsite IS NULL
      OR g_bxgf_m.bxgf001 IS NULL
      OR g_bxgf_m.bxgf002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_bxgfsite_t = g_bxgf_m.bxgfsite
   LET g_bxgf001_t = g_bxgf_m.bxgf001
   LET g_bxgf002_t = g_bxgf_m.bxgf002
 
   
   #清空key值
   LET g_bxgf_m.bxgfsite = ""
   LET g_bxgf_m.bxgf001 = ""
   LET g_bxgf_m.bxgf002 = ""
 
    
   CALL abxi700_set_entry("a")
   CALL abxi700_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bxgf_m.bxgfownid = g_user
      LET g_bxgf_m.bxgfowndp = g_dept
      LET g_bxgf_m.bxgfcrtid = g_user
      LET g_bxgf_m.bxgfcrtdp = g_dept 
      LET g_bxgf_m.bxgfcrtdt = cl_get_current()
      LET g_bxgf_m.bxgfmodid = g_user
      LET g_bxgf_m.bxgfmoddt = cl_get_current()
      LET g_bxgf_m.bxgfstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bxgf_m.bxgfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_bxgf_m.bxgf002_desc = ''
   DISPLAY BY NAME g_bxgf_m.bxgf002_desc
   LET g_bxgf_m.bxgf002_desc_1 = ''
   DISPLAY BY NAME g_bxgf_m.bxgf002_desc_1
 
   
   #資料輸入
   CALL abxi700_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_bxgf_m.* TO NULL
      CALL abxi700_show()
      CALL s_transaction_end('N','0')
      LET INT_FLAG = 0
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前 name="reproduce.head.b_insert"
   
   #end add-point
   
   #add-point:單頭複製中 name="reproduce.head.m_insert"
   
   #end add-point
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bxgf_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單頭複製後 name="reproduce.head.a_insert"
   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL abxi700_set_act_visible()
   CALL abxi700_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bxgfsite_t = g_bxgf_m.bxgfsite
   LET g_bxgf001_t = g_bxgf_m.bxgf001
   LET g_bxgf002_t = g_bxgf_m.bxgf002
 
   
   #組合新增資料的條件
   LET g_add_browse = " bxgfent = " ||g_enterprise|| " AND",
                      " bxgfsite = '", g_bxgf_m.bxgfsite, "' "
                      ," AND bxgf001 = '", g_bxgf_m.bxgf001, "' "
                      ," AND bxgf002 = '", g_bxgf_m.bxgf002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abxi700_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_bxgf_m.bxgfownid      
   LET g_data_dept  = g_bxgf_m.bxgfowndp
              
   #功能已完成,通報訊息中心
   CALL abxi700_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="abxi700.show" >}
#+ 資料顯示 
PRIVATE FUNCTION abxi700_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abxi700_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL abxi700_bxgf002_ref()
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002,g_bxgf_m.bxgf002_desc,g_bxgf_m.bxgf002_desc_1, 
       g_bxgf_m.iman013,g_bxgf_m.iman012,g_bxgf_m.bxgfstus,g_bxgf_m.bxgf003,g_bxgf_m.bxgf004,g_bxgf_m.bxgf005, 
       g_bxgf_m.bxgf006,g_bxgf_m.bxgf007,g_bxgf_m.bxgf009,g_bxgf_m.bxgf008,g_bxgf_m.bxgf010,g_bxgf_m.bxgf011, 
       g_bxgf_m.bxgf012,g_bxgf_m.bxgf013,g_bxgf_m.bxgf014,g_bxgf_m.bxgf015,g_bxgf_m.bxgf016,g_bxgf_m.bxgfownid, 
       g_bxgf_m.bxgfownid_desc,g_bxgf_m.bxgfowndp,g_bxgf_m.bxgfowndp_desc,g_bxgf_m.bxgfcrtid,g_bxgf_m.bxgfcrtid_desc, 
       g_bxgf_m.bxgfcrtdp,g_bxgf_m.bxgfcrtdp_desc,g_bxgf_m.bxgfcrtdt,g_bxgf_m.bxgfmodid,g_bxgf_m.bxgfmodid_desc, 
       g_bxgf_m.bxgfmoddt,g_bxgf_m.bxgfcnfid,g_bxgf_m.bxgfcnfid_desc,g_bxgf_m.bxgfcnfdt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL abxi700_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bxgf_m.bxgfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abxi700.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION abxi700_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_bxgf_m.bxgfsite IS NULL
   OR g_bxgf_m.bxgf001 IS NULL
   OR g_bxgf_m.bxgf002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_bxgfsite_t = g_bxgf_m.bxgfsite
   LET g_bxgf001_t = g_bxgf_m.bxgf001
   LET g_bxgf002_t = g_bxgf_m.bxgf002
 
   
   
 
   OPEN abxi700_cl USING g_enterprise,g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abxi700_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE abxi700_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abxi700_master_referesh USING g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002 INTO g_bxgf_m.bxgfsite, 
       g_bxgf_m.bxgf001,g_bxgf_m.bxgf002,g_bxgf_m.bxgfstus,g_bxgf_m.bxgf003,g_bxgf_m.bxgf004,g_bxgf_m.bxgf005, 
       g_bxgf_m.bxgf006,g_bxgf_m.bxgf007,g_bxgf_m.bxgf009,g_bxgf_m.bxgf008,g_bxgf_m.bxgf010,g_bxgf_m.bxgf011, 
       g_bxgf_m.bxgf012,g_bxgf_m.bxgf013,g_bxgf_m.bxgf014,g_bxgf_m.bxgf015,g_bxgf_m.bxgf016,g_bxgf_m.bxgfownid, 
       g_bxgf_m.bxgfowndp,g_bxgf_m.bxgfcrtid,g_bxgf_m.bxgfcrtdp,g_bxgf_m.bxgfcrtdt,g_bxgf_m.bxgfmodid, 
       g_bxgf_m.bxgfmoddt,g_bxgf_m.bxgfcnfid,g_bxgf_m.bxgfcnfdt,g_bxgf_m.bxgf002_desc,g_bxgf_m.bxgfownid_desc, 
       g_bxgf_m.bxgfowndp_desc,g_bxgf_m.bxgfcrtid_desc,g_bxgf_m.bxgfcrtdp_desc,g_bxgf_m.bxgfmodid_desc, 
       g_bxgf_m.bxgfcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT abxi700_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bxgf_m_mask_o.* =  g_bxgf_m.*
   CALL abxi700_bxgf_t_mask()
   LET g_bxgf_m_mask_n.* =  g_bxgf_m.*
   
   #將最新資料顯示到畫面上
   CALL abxi700_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abxi700_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM bxgf_t 
       WHERE bxgfent = g_enterprise AND bxgfsite = g_bxgf_m.bxgfsite 
         AND bxgf001 = g_bxgf_m.bxgf001 
         AND bxgf002 = g_bxgf_m.bxgf002 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bxgf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_bxgf_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE abxi700_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL abxi700_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL abxi700_browser_fill(g_wc,"")
         CALL abxi700_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE abxi700_cl
 
   #功能已完成,通報訊息中心
   CALL abxi700_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abxi700.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abxi700_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_bxgfsite = g_bxgf_m.bxgfsite
         AND g_browser[l_i].b_bxgf001 = g_bxgf_m.bxgf001
         AND g_browser[l_i].b_bxgf002 = g_bxgf_m.bxgf002
 
         THEN
         CALL g_browser.deleteElement(l_i)
       END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt  TO FORMONLY.h_count     #page count
  
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="abxi700.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abxi700_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("bxgfsite,bxgf001,bxgf002",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abxi700.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abxi700_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bxgfsite,bxgf001,bxgf002",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abxi700.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abxi700_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abxi700.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abxi700_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abxi700.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abxi700_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization" 
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point  
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " bxgfsite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bxgf001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bxgf002 = '", g_argv[03], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="abxi700.mask_functions" >}
&include "erp/abx/abxi700_mask.4gl"
 
{</section>}
 
{<section id="abxi700.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION abxi700_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_bxgf_m.bxgfsite IS NULL
      OR g_bxgf_m.bxgf001 IS NULL      OR g_bxgf_m.bxgf002 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN abxi700_cl USING g_enterprise,g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002
   IF STATUS THEN
      CLOSE abxi700_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abxi700_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE abxi700_master_referesh USING g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002 INTO g_bxgf_m.bxgfsite, 
       g_bxgf_m.bxgf001,g_bxgf_m.bxgf002,g_bxgf_m.bxgfstus,g_bxgf_m.bxgf003,g_bxgf_m.bxgf004,g_bxgf_m.bxgf005, 
       g_bxgf_m.bxgf006,g_bxgf_m.bxgf007,g_bxgf_m.bxgf009,g_bxgf_m.bxgf008,g_bxgf_m.bxgf010,g_bxgf_m.bxgf011, 
       g_bxgf_m.bxgf012,g_bxgf_m.bxgf013,g_bxgf_m.bxgf014,g_bxgf_m.bxgf015,g_bxgf_m.bxgf016,g_bxgf_m.bxgfownid, 
       g_bxgf_m.bxgfowndp,g_bxgf_m.bxgfcrtid,g_bxgf_m.bxgfcrtdp,g_bxgf_m.bxgfcrtdt,g_bxgf_m.bxgfmodid, 
       g_bxgf_m.bxgfmoddt,g_bxgf_m.bxgfcnfid,g_bxgf_m.bxgfcnfdt,g_bxgf_m.bxgf002_desc,g_bxgf_m.bxgfownid_desc, 
       g_bxgf_m.bxgfowndp_desc,g_bxgf_m.bxgfcrtid_desc,g_bxgf_m.bxgfcrtdp_desc,g_bxgf_m.bxgfmodid_desc, 
       g_bxgf_m.bxgfcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT abxi700_action_chk() THEN
      CLOSE abxi700_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002,g_bxgf_m.bxgf002_desc,g_bxgf_m.bxgf002_desc_1, 
       g_bxgf_m.iman013,g_bxgf_m.iman012,g_bxgf_m.bxgfstus,g_bxgf_m.bxgf003,g_bxgf_m.bxgf004,g_bxgf_m.bxgf005, 
       g_bxgf_m.bxgf006,g_bxgf_m.bxgf007,g_bxgf_m.bxgf009,g_bxgf_m.bxgf008,g_bxgf_m.bxgf010,g_bxgf_m.bxgf011, 
       g_bxgf_m.bxgf012,g_bxgf_m.bxgf013,g_bxgf_m.bxgf014,g_bxgf_m.bxgf015,g_bxgf_m.bxgf016,g_bxgf_m.bxgfownid, 
       g_bxgf_m.bxgfownid_desc,g_bxgf_m.bxgfowndp,g_bxgf_m.bxgfowndp_desc,g_bxgf_m.bxgfcrtid,g_bxgf_m.bxgfcrtid_desc, 
       g_bxgf_m.bxgfcrtdp,g_bxgf_m.bxgfcrtdp_desc,g_bxgf_m.bxgfcrtdt,g_bxgf_m.bxgfmodid,g_bxgf_m.bxgfmodid_desc, 
       g_bxgf_m.bxgfmoddt,g_bxgf_m.bxgfcnfid,g_bxgf_m.bxgfcnfid_desc,g_bxgf_m.bxgfcnfdt
 
   CASE g_bxgf_m.bxgfstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_bxgf_m.bxgfstus
            
            WHEN "N"
               HIDE OPTION "open"
            WHEN "Y"
               HIDE OPTION "valid"
            WHEN "X"
               HIDE OPTION "void"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION open
         IF cl_auth_chk_act("open") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.open"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION valid
         IF cl_auth_chk_act("valid") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.valid"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION void
         IF cl_auth_chk_act("void") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.void"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_bxgf_m.bxgfstus = lc_state OR cl_null(lc_state) THEN
      CLOSE abxi700_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_bxgf_m.bxgfmodid = g_user
   LET g_bxgf_m.bxgfmoddt = cl_get_current()
   LET g_bxgf_m.bxgfstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE bxgf_t 
      SET (bxgfstus,bxgfmodid,bxgfmoddt) 
        = (g_bxgf_m.bxgfstus,g_bxgf_m.bxgfmodid,g_bxgf_m.bxgfmoddt)     
    WHERE bxgfent = g_enterprise AND bxgfsite = g_bxgf_m.bxgfsite
      AND bxgf001 = g_bxgf_m.bxgf001      AND bxgf002 = g_bxgf_m.bxgf002
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE abxi700_master_referesh USING g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002 INTO g_bxgf_m.bxgfsite, 
          g_bxgf_m.bxgf001,g_bxgf_m.bxgf002,g_bxgf_m.bxgfstus,g_bxgf_m.bxgf003,g_bxgf_m.bxgf004,g_bxgf_m.bxgf005, 
          g_bxgf_m.bxgf006,g_bxgf_m.bxgf007,g_bxgf_m.bxgf009,g_bxgf_m.bxgf008,g_bxgf_m.bxgf010,g_bxgf_m.bxgf011, 
          g_bxgf_m.bxgf012,g_bxgf_m.bxgf013,g_bxgf_m.bxgf014,g_bxgf_m.bxgf015,g_bxgf_m.bxgf016,g_bxgf_m.bxgfownid, 
          g_bxgf_m.bxgfowndp,g_bxgf_m.bxgfcrtid,g_bxgf_m.bxgfcrtdp,g_bxgf_m.bxgfcrtdt,g_bxgf_m.bxgfmodid, 
          g_bxgf_m.bxgfmoddt,g_bxgf_m.bxgfcnfid,g_bxgf_m.bxgfcnfdt,g_bxgf_m.bxgf002_desc,g_bxgf_m.bxgfownid_desc, 
          g_bxgf_m.bxgfowndp_desc,g_bxgf_m.bxgfcrtid_desc,g_bxgf_m.bxgfcrtdp_desc,g_bxgf_m.bxgfmodid_desc, 
          g_bxgf_m.bxgfcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_bxgf_m.bxgfsite,g_bxgf_m.bxgf001,g_bxgf_m.bxgf002,g_bxgf_m.bxgf002_desc,g_bxgf_m.bxgf002_desc_1, 
          g_bxgf_m.iman013,g_bxgf_m.iman012,g_bxgf_m.bxgfstus,g_bxgf_m.bxgf003,g_bxgf_m.bxgf004,g_bxgf_m.bxgf005, 
          g_bxgf_m.bxgf006,g_bxgf_m.bxgf007,g_bxgf_m.bxgf009,g_bxgf_m.bxgf008,g_bxgf_m.bxgf010,g_bxgf_m.bxgf011, 
          g_bxgf_m.bxgf012,g_bxgf_m.bxgf013,g_bxgf_m.bxgf014,g_bxgf_m.bxgf015,g_bxgf_m.bxgf016,g_bxgf_m.bxgfownid, 
          g_bxgf_m.bxgfownid_desc,g_bxgf_m.bxgfowndp,g_bxgf_m.bxgfowndp_desc,g_bxgf_m.bxgfcrtid,g_bxgf_m.bxgfcrtid_desc, 
          g_bxgf_m.bxgfcrtdp,g_bxgf_m.bxgfcrtdp_desc,g_bxgf_m.bxgfcrtdt,g_bxgf_m.bxgfmodid,g_bxgf_m.bxgfmodid_desc, 
          g_bxgf_m.bxgfmoddt,g_bxgf_m.bxgfcnfid,g_bxgf_m.bxgfcnfid_desc,g_bxgf_m.bxgfcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE abxi700_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abxi700_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abxi700.signature" >}
   
 
{</section>}
 
{<section id="abxi700.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abxi700_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_bxgf_m.bxgfsite
   LET g_pk_array[1].column = 'bxgfsite'
   LET g_pk_array[2].values = g_bxgf_m.bxgf001
   LET g_pk_array[2].column = 'bxgf001'
   LET g_pk_array[3].values = g_bxgf_m.bxgf002
   LET g_pk_array[3].column = 'bxgf002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abxi700.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="abxi700.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abxi700_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL abxi700_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bxgf_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abxi700.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION abxi700_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abxi700.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 根據商品編號帶出資訊
# Memo...........:
# Usage..........: CALL abxi700_bxgf002_ref()
# Date & Author..: 150323-00006#3 20160711 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION abxi700_bxgf002_ref()
   
   #品名,規格
   CALL s_desc_get_item_desc(g_bxgf_m.bxgf002) RETURNING g_bxgf_m.bxgf002_desc,g_bxgf_m.bxgf002_desc_1
   DISPLAY BY NAME g_bxgf_m.bxgf002_desc,g_bxgf_m.bxgf002_desc_1
   
   #型態,保稅否
   SELECT iman013,iman012 INTO g_bxgf_m.iman013,g_bxgf_m.iman012
     FROM iman_t
    WHERE imanent = g_enterprise
      AND imansite = g_site
      AND iman001 = g_bxgf_m.bxgf002
   DISPLAY BY NAME g_bxgf_m.iman013,g_bxgf_m.iman012
   
END FUNCTION

 
{</section>}
 
