#該程式未解開Section, 採用最新樣板產出!
{<section id="apmi127.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-06-08 14:20:02), PR版次:0004(2016-03-18 15:17:59)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000182
#+ Filename...: apmi127
#+ Description: 彈性採購價格畫面設定作業
#+ Creator....: 01996(2014-01-27 10:21:52)
#+ Modifier...: 07024 -SD/PR- 05016
 
{</section>}
 
{<section id="apmi127.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#34  2016/03/18   By Hans  將重複內容的錯誤訊息置換為公用錯誤訊息  
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
PRIVATE TYPE type_g_pmas_m RECORD
       pmas001 LIKE pmas_t.pmas001, 
   gzzz001 LIKE type_t.chr500, 
   gzzal003 LIKE type_t.chr500, 
   gzzz001_1 LIKE type_t.chr500, 
   gzzal003_1 LIKE type_t.chr500, 
   pmas011 LIKE pmas_t.pmas011, 
   pmas003 LIKE pmas_t.pmas003, 
   pmas007 LIKE pmas_t.pmas007, 
   pmas002 LIKE pmas_t.pmas002, 
   pmas004 LIKE pmas_t.pmas004, 
   pmas008 LIKE pmas_t.pmas008, 
   pmas012 LIKE pmas_t.pmas012, 
   pmas005 LIKE pmas_t.pmas005, 
   pmas009 LIKE pmas_t.pmas009, 
   pmas013 LIKE pmas_t.pmas013, 
   pmas006 LIKE pmas_t.pmas006, 
   pmas010 LIKE pmas_t.pmas010, 
   pmasstus LIKE pmas_t.pmasstus, 
   pmasownid LIKE pmas_t.pmasownid, 
   pmasownid_desc LIKE type_t.chr80, 
   pmasowndp LIKE pmas_t.pmasowndp, 
   pmasowndp_desc LIKE type_t.chr80, 
   pmascrtid LIKE pmas_t.pmascrtid, 
   pmascrtid_desc LIKE type_t.chr80, 
   pmascrtdp LIKE pmas_t.pmascrtdp, 
   pmascrtdp_desc LIKE type_t.chr80, 
   pmascrtdt LIKE pmas_t.pmascrtdt, 
   pmasmodid LIKE pmas_t.pmasmodid, 
   pmasmodid_desc LIKE type_t.chr80, 
   pmasmoddt LIKE pmas_t.pmasmoddt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_pmas001 LIKE pmas_t.pmas001,
   b_gzzz001 LIKE type_t.chr80,
   b_gzzal003 LIKE type_t.chr80,
   b_gzzz001_1 LIKE type_t.chr80,
   b_gzzal003_1 LIKE type_t.chr80
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmas_m        type_g_pmas_m  #單頭變數宣告
DEFINE g_pmas_m_t      type_g_pmas_m  #單頭舊值宣告(系統還原用)
DEFINE g_pmas_m_o      type_g_pmas_m  #單頭舊值宣告(其他用途)
DEFINE g_pmas_m_mask_o type_g_pmas_m  #轉換遮罩前資料
DEFINE g_pmas_m_mask_n type_g_pmas_m  #轉換遮罩後資料
 
   DEFINE g_pmas001_t LIKE pmas_t.pmas001
 
   
 
   
 
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
 
{<section id="apmi127.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pmas001,'','','','',pmas011,pmas003,pmas007,pmas002,pmas004,pmas008,pmas012, 
       pmas005,pmas009,pmas013,pmas006,pmas010,pmasstus,pmasownid,'',pmasowndp,'',pmascrtid,'',pmascrtdp, 
       '',pmascrtdt,pmasmodid,'',pmasmoddt", 
                      " FROM pmas_t",
                      " WHERE pmasent= ? AND pmas001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmi127_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmas001,t0.pmas011,t0.pmas003,t0.pmas007,t0.pmas002,t0.pmas004,t0.pmas008, 
       t0.pmas012,t0.pmas005,t0.pmas009,t0.pmas013,t0.pmas006,t0.pmas010,t0.pmasstus,t0.pmasownid,t0.pmasowndp, 
       t0.pmascrtid,t0.pmascrtdp,t0.pmascrtdt,t0.pmasmodid,t0.pmasmoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 , 
       t4.ooefl003 ,t5.ooag011",
               " FROM pmas_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.pmasownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.pmasowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.pmascrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.pmascrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.pmasmodid  ",
 
               " WHERE t0.pmasent = " ||g_enterprise|| " AND t0.pmas001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmi127_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmi127 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmi127_init()   
 
      #進入選單 Menu (="N")
      CALL apmi127_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmi127
      
   END IF 
   
   CLOSE apmi127_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmi127.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmi127_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('pmasstus','17','N,Y')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL apmi127_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="apmi127.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmi127_ui_dialog() 
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
            CALL apmi127_insert()
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
         INITIALIZE g_pmas_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL apmi127_init()
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
               CALL apmi127_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL apmi127_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL apmi127_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL apmi127_set_act_visible()
               CALL apmi127_set_act_no_visible()
               IF NOT (g_pmas_m.pmas001 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " pmasent = " ||g_enterprise|| " AND",
                                     " pmas001 = '", g_pmas_m.pmas001, "' "
 
                  #填到對應位置
                  CALL apmi127_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL apmi127_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL apmi127_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL apmi127_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL apmi127_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL apmi127_fetch("L")  
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
                  CALL apmi127_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL apmi127_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmi127_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apmi127_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmi127_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmi127_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_azzi910
            LET g_action_choice="open_azzi910"
            IF cl_auth_chk_act("open_azzi910") THEN
               
               #add-point:ON ACTION open_azzi910 name="menu2.open_azzi910"
               CALL apmi127_open_azzi910()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apmi127_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmi127_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmi127_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmi127_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmi127_set_pk_array()
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
                  CALL apmi127_fetch("")
 
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
                  CALL apmi127_browser_fill(g_wc,"")
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
                  CALL apmi127_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL apmi127_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL apmi127_set_act_visible()
               CALL apmi127_set_act_no_visible()
               IF NOT (g_pmas_m.pmas001 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " pmasent = " ||g_enterprise|| " AND",
                                     " pmas001 = '", g_pmas_m.pmas001, "' "
 
                  #填到對應位置
                  CALL apmi127_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL apmi127_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL apmi127_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL apmi127_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL apmi127_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL apmi127_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL apmi127_fetch("L")  
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
                  CALL apmi127_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL apmi127_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmi127_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apmi127_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmi127_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmi127_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_azzi910
            LET g_action_choice="open_azzi910"
            IF cl_auth_chk_act("open_azzi910") THEN
               
               #add-point:ON ACTION open_azzi910 name="menu.open_azzi910"
               
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
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apmi127_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmi127_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmi127_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmi127_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmi127_set_pk_array()
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
 
{<section id="apmi127.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION apmi127_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "pmas001"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM pmas_t ",
               "  ",
               "  ",
               " WHERE pmasent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("pmas_t")
                
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
      INITIALIZE g_pmas_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.pmasstus,t0.pmas001",
               " FROM pmas_t t0 ",
               "  ",
               
               " WHERE t0.pmasent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("pmas_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmas_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmas001
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
      CALL apmi127_get_gzzz001(g_browser[g_cnt].b_pmas001) RETURNING g_browser[g_cnt].b_gzzz001
      DISPLAY BY NAME g_browser[g_cnt].b_gzzz001
      
      CALL apmi127_get_gzzal003(g_browser[g_cnt].b_gzzz001) RETURNING g_browser[g_cnt].b_gzzal003
      DISPLAY BY NAME g_browser[g_cnt].b_gzzal003
      
      CALL apmi127_get_gzzz001_1(g_browser[g_cnt].b_pmas001) RETURNING g_browser[g_cnt].b_gzzz001_1
      DISPLAY BY NAME g_browser[g_cnt].b_gzzz001_1
      
      CALL apmi127_get_gzzal003(g_browser[g_cnt].b_gzzz001_1) RETURNING g_browser[g_cnt].b_gzzal003_1
      DISPLAY BY NAME g_browser[g_cnt].b_gzzal003_1
         #end add-point
         
         #遮罩相關處理
         CALL apmi127_browser_mask()
         
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_pmas001) THEN
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
 
{<section id="apmi127.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmi127_construct()
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
   INITIALIZE g_pmas_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON pmas001,pmas011,pmas003,pmas007,pmas002,pmas004,pmas008,pmas012,pmas005, 
          pmas009,pmas013,pmas006,pmas010,pmasstus,pmasownid,pmasowndp,pmascrtid,pmascrtdp,pmascrtdt, 
          pmasmodid,pmasmoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pmascrtdt>>----
         AFTER FIELD pmascrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pmasmoddt>>----
         AFTER FIELD pmasmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmascnfdt>>----
         
         #----<<pmaspstdt>>----
 
 
 
      
         #一般欄位
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas001
            #add-point:BEFORE FIELD pmas001 name="construct.b.pmas001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas001
            
            #add-point:AFTER FIELD pmas001 name="construct.a.pmas001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmas001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas001
            #add-point:ON ACTION controlp INFIELD pmas001 name="construct.c.pmas001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmas001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmas001  #顯示到畫面上

            NEXT FIELD pmas001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas011
            #add-point:BEFORE FIELD pmas011 name="construct.b.pmas011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas011
            
            #add-point:AFTER FIELD pmas011 name="construct.a.pmas011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmas011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas011
            #add-point:ON ACTION controlp INFIELD pmas011 name="construct.c.pmas011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas003
            #add-point:BEFORE FIELD pmas003 name="construct.b.pmas003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas003
            
            #add-point:AFTER FIELD pmas003 name="construct.a.pmas003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmas003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas003
            #add-point:ON ACTION controlp INFIELD pmas003 name="construct.c.pmas003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas007
            #add-point:BEFORE FIELD pmas007 name="construct.b.pmas007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas007
            
            #add-point:AFTER FIELD pmas007 name="construct.a.pmas007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmas007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas007
            #add-point:ON ACTION controlp INFIELD pmas007 name="construct.c.pmas007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas002
            #add-point:BEFORE FIELD pmas002 name="construct.b.pmas002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas002
            
            #add-point:AFTER FIELD pmas002 name="construct.a.pmas002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmas002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas002
            #add-point:ON ACTION controlp INFIELD pmas002 name="construct.c.pmas002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas004
            #add-point:BEFORE FIELD pmas004 name="construct.b.pmas004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas004
            
            #add-point:AFTER FIELD pmas004 name="construct.a.pmas004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmas004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas004
            #add-point:ON ACTION controlp INFIELD pmas004 name="construct.c.pmas004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas008
            #add-point:BEFORE FIELD pmas008 name="construct.b.pmas008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas008
            
            #add-point:AFTER FIELD pmas008 name="construct.a.pmas008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmas008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas008
            #add-point:ON ACTION controlp INFIELD pmas008 name="construct.c.pmas008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas012
            #add-point:BEFORE FIELD pmas012 name="construct.b.pmas012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas012
            
            #add-point:AFTER FIELD pmas012 name="construct.a.pmas012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmas012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas012
            #add-point:ON ACTION controlp INFIELD pmas012 name="construct.c.pmas012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas005
            #add-point:BEFORE FIELD pmas005 name="construct.b.pmas005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas005
            
            #add-point:AFTER FIELD pmas005 name="construct.a.pmas005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmas005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas005
            #add-point:ON ACTION controlp INFIELD pmas005 name="construct.c.pmas005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas009
            #add-point:BEFORE FIELD pmas009 name="construct.b.pmas009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas009
            
            #add-point:AFTER FIELD pmas009 name="construct.a.pmas009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmas009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas009
            #add-point:ON ACTION controlp INFIELD pmas009 name="construct.c.pmas009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas013
            #add-point:BEFORE FIELD pmas013 name="construct.b.pmas013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas013
            
            #add-point:AFTER FIELD pmas013 name="construct.a.pmas013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmas013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas013
            #add-point:ON ACTION controlp INFIELD pmas013 name="construct.c.pmas013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas006
            #add-point:BEFORE FIELD pmas006 name="construct.b.pmas006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas006
            
            #add-point:AFTER FIELD pmas006 name="construct.a.pmas006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmas006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas006
            #add-point:ON ACTION controlp INFIELD pmas006 name="construct.c.pmas006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas010
            #add-point:BEFORE FIELD pmas010 name="construct.b.pmas010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas010
            
            #add-point:AFTER FIELD pmas010 name="construct.a.pmas010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmas010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas010
            #add-point:ON ACTION controlp INFIELD pmas010 name="construct.c.pmas010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmasstus
            #add-point:BEFORE FIELD pmasstus name="construct.b.pmasstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmasstus
            
            #add-point:AFTER FIELD pmasstus name="construct.a.pmasstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmasstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmasstus
            #add-point:ON ACTION controlp INFIELD pmasstus name="construct.c.pmasstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmasownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmasownid
            #add-point:ON ACTION controlp INFIELD pmasownid name="construct.c.pmasownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmasownid  #顯示到畫面上

            NEXT FIELD pmasownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmasownid
            #add-point:BEFORE FIELD pmasownid name="construct.b.pmasownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmasownid
            
            #add-point:AFTER FIELD pmasownid name="construct.a.pmasownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmasowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmasowndp
            #add-point:ON ACTION controlp INFIELD pmasowndp name="construct.c.pmasowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmasowndp  #顯示到畫面上

            NEXT FIELD pmasowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmasowndp
            #add-point:BEFORE FIELD pmasowndp name="construct.b.pmasowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmasowndp
            
            #add-point:AFTER FIELD pmasowndp name="construct.a.pmasowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmascrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmascrtid
            #add-point:ON ACTION controlp INFIELD pmascrtid name="construct.c.pmascrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmascrtid  #顯示到畫面上

            NEXT FIELD pmascrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmascrtid
            #add-point:BEFORE FIELD pmascrtid name="construct.b.pmascrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmascrtid
            
            #add-point:AFTER FIELD pmascrtid name="construct.a.pmascrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmascrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmascrtdp
            #add-point:ON ACTION controlp INFIELD pmascrtdp name="construct.c.pmascrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmascrtdp  #顯示到畫面上

            NEXT FIELD pmascrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmascrtdp
            #add-point:BEFORE FIELD pmascrtdp name="construct.b.pmascrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmascrtdp
            
            #add-point:AFTER FIELD pmascrtdp name="construct.a.pmascrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmascrtdt
            #add-point:BEFORE FIELD pmascrtdt name="construct.b.pmascrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmasmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmasmodid
            #add-point:ON ACTION controlp INFIELD pmasmodid name="construct.c.pmasmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmasmodid  #顯示到畫面上

            NEXT FIELD pmasmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmasmodid
            #add-point:BEFORE FIELD pmasmodid name="construct.b.pmasmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmasmodid
            
            #add-point:AFTER FIELD pmasmodid name="construct.a.pmasmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmasmoddt
            #add-point:BEFORE FIELD pmasmoddt name="construct.b.pmasmoddt"
            
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
 
{<section id="apmi127.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION apmi127_filter()
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
      CONSTRUCT g_wc_filter ON pmas001
                          FROM s_browse[1].b_pmas001
 
         BEFORE CONSTRUCT
               DISPLAY apmi127_filter_parser('pmas001') TO s_browse[1].b_pmas001
      
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
 
      CALL apmi127_filter_show('pmas001')
 
END FUNCTION
 
{</section>}
 
{<section id="apmi127.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION apmi127_filter_parser(ps_field)
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
 
{<section id="apmi127.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION apmi127_filter_show(ps_field)
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
   LET ls_condition = apmi127_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmi127.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmi127_query()
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
 
   INITIALIZE g_pmas_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL apmi127_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmi127_browser_fill(g_wc,"F")
      CALL apmi127_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL apmi127_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL apmi127_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="apmi127.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmi127_fetch(p_fl)
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
   LET g_pmas_m.pmas001 = g_browser[g_current_idx].b_pmas001
 
                       
   #讀取單頭所有欄位資料
   EXECUTE apmi127_master_referesh USING g_pmas_m.pmas001 INTO g_pmas_m.pmas001,g_pmas_m.pmas011,g_pmas_m.pmas003, 
       g_pmas_m.pmas007,g_pmas_m.pmas002,g_pmas_m.pmas004,g_pmas_m.pmas008,g_pmas_m.pmas012,g_pmas_m.pmas005, 
       g_pmas_m.pmas009,g_pmas_m.pmas013,g_pmas_m.pmas006,g_pmas_m.pmas010,g_pmas_m.pmasstus,g_pmas_m.pmasownid, 
       g_pmas_m.pmasowndp,g_pmas_m.pmascrtid,g_pmas_m.pmascrtdp,g_pmas_m.pmascrtdt,g_pmas_m.pmasmodid, 
       g_pmas_m.pmasmoddt,g_pmas_m.pmasownid_desc,g_pmas_m.pmasowndp_desc,g_pmas_m.pmascrtid_desc,g_pmas_m.pmascrtdp_desc, 
       g_pmas_m.pmasmodid_desc
   
   #遮罩相關處理
   LET g_pmas_m_mask_o.* =  g_pmas_m.*
   CALL apmi127_pmas_t_mask()
   LET g_pmas_m_mask_n.* =  g_pmas_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL apmi127_set_act_visible()
   CALL apmi127_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,delete",TRUE)
   IF g_pmas_m.pmasstus = 'N' THEN
      CALL cl_set_act_visible("modify,delete",FALSE)
   END IF  
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_pmas_m_t.* = g_pmas_m.*
   LET g_pmas_m_o.* = g_pmas_m.*
   
   LET g_data_owner = g_pmas_m.pmasownid      
   LET g_data_dept  = g_pmas_m.pmasowndp
   
   #重新顯示
   CALL apmi127_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="apmi127.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmi127_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_pmas_m.* TO NULL             #DEFAULT 設定
   LET g_pmas001_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmas_m.pmasownid = g_user
      LET g_pmas_m.pmasowndp = g_dept
      LET g_pmas_m.pmascrtid = g_user
      LET g_pmas_m.pmascrtdp = g_dept 
      LET g_pmas_m.pmascrtdt = cl_get_current()
      LET g_pmas_m.pmasmodid = g_user
      LET g_pmas_m.pmasmoddt = cl_get_current()
      LET g_pmas_m.pmasstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_pmas_m.pmas011 = "N"
      LET g_pmas_m.pmas003 = "N"
      LET g_pmas_m.pmas007 = "N"
      LET g_pmas_m.pmas002 = "N"
      LET g_pmas_m.pmas004 = "N"
      LET g_pmas_m.pmas008 = "N"
      LET g_pmas_m.pmas012 = "N"
      LET g_pmas_m.pmas005 = "N"
      LET g_pmas_m.pmas009 = "N"
      LET g_pmas_m.pmas013 = "N"
      LET g_pmas_m.pmas006 = "N"
      LET g_pmas_m.pmas010 = "N"
      LET g_pmas_m.pmasstus = "Y"
 
 
      #add-point:單頭預設值 name="insert.default"
      LET g_pmas_m_t.* = g_pmas_m.*
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmas_m.pmasstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL apmi127_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
 
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_pmas_m.* TO NULL
         CALL apmi127_show()
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
   CALL apmi127_set_act_visible()
   CALL apmi127_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pmas001_t = g_pmas_m.pmas001
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmasent = " ||g_enterprise|| " AND",
                      " pmas001 = '", g_pmas_m.pmas001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmi127_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmi127_master_referesh USING g_pmas_m.pmas001 INTO g_pmas_m.pmas001,g_pmas_m.pmas011,g_pmas_m.pmas003, 
       g_pmas_m.pmas007,g_pmas_m.pmas002,g_pmas_m.pmas004,g_pmas_m.pmas008,g_pmas_m.pmas012,g_pmas_m.pmas005, 
       g_pmas_m.pmas009,g_pmas_m.pmas013,g_pmas_m.pmas006,g_pmas_m.pmas010,g_pmas_m.pmasstus,g_pmas_m.pmasownid, 
       g_pmas_m.pmasowndp,g_pmas_m.pmascrtid,g_pmas_m.pmascrtdp,g_pmas_m.pmascrtdt,g_pmas_m.pmasmodid, 
       g_pmas_m.pmasmoddt,g_pmas_m.pmasownid_desc,g_pmas_m.pmasowndp_desc,g_pmas_m.pmascrtid_desc,g_pmas_m.pmascrtdp_desc, 
       g_pmas_m.pmasmodid_desc
   
   
   #遮罩相關處理
   LET g_pmas_m_mask_o.* =  g_pmas_m.*
   CALL apmi127_pmas_t_mask()
   LET g_pmas_m_mask_n.* =  g_pmas_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmas_m.pmas001,g_pmas_m.gzzz001,g_pmas_m.gzzal003,g_pmas_m.gzzz001_1,g_pmas_m.gzzal003_1, 
       g_pmas_m.pmas011,g_pmas_m.pmas003,g_pmas_m.pmas007,g_pmas_m.pmas002,g_pmas_m.pmas004,g_pmas_m.pmas008, 
       g_pmas_m.pmas012,g_pmas_m.pmas005,g_pmas_m.pmas009,g_pmas_m.pmas013,g_pmas_m.pmas006,g_pmas_m.pmas010, 
       g_pmas_m.pmasstus,g_pmas_m.pmasownid,g_pmas_m.pmasownid_desc,g_pmas_m.pmasowndp,g_pmas_m.pmasowndp_desc, 
       g_pmas_m.pmascrtid,g_pmas_m.pmascrtid_desc,g_pmas_m.pmascrtdp,g_pmas_m.pmascrtdp_desc,g_pmas_m.pmascrtdt, 
       g_pmas_m.pmasmodid,g_pmas_m.pmasmodid_desc,g_pmas_m.pmasmoddt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_pmas_m.pmasownid      
   LET g_data_dept  = g_pmas_m.pmasowndp
 
   #功能已完成,通報訊息中心
   CALL apmi127_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmi127.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmi127_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_pmas_m.pmas001 IS NULL
 
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
   LET g_pmas001_t = g_pmas_m.pmas001
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN apmi127_cl USING g_enterprise,g_pmas_m.pmas001
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmi127_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE apmi127_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmi127_master_referesh USING g_pmas_m.pmas001 INTO g_pmas_m.pmas001,g_pmas_m.pmas011,g_pmas_m.pmas003, 
       g_pmas_m.pmas007,g_pmas_m.pmas002,g_pmas_m.pmas004,g_pmas_m.pmas008,g_pmas_m.pmas012,g_pmas_m.pmas005, 
       g_pmas_m.pmas009,g_pmas_m.pmas013,g_pmas_m.pmas006,g_pmas_m.pmas010,g_pmas_m.pmasstus,g_pmas_m.pmasownid, 
       g_pmas_m.pmasowndp,g_pmas_m.pmascrtid,g_pmas_m.pmascrtdp,g_pmas_m.pmascrtdt,g_pmas_m.pmasmodid, 
       g_pmas_m.pmasmoddt,g_pmas_m.pmasownid_desc,g_pmas_m.pmasowndp_desc,g_pmas_m.pmascrtid_desc,g_pmas_m.pmascrtdp_desc, 
       g_pmas_m.pmasmodid_desc
 
   #檢查是否允許此動作
   IF NOT apmi127_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_pmas_m_mask_o.* =  g_pmas_m.*
   CALL apmi127_pmas_t_mask()
   LET g_pmas_m_mask_n.* =  g_pmas_m.*
   
   
 
   #顯示資料
   CALL apmi127_show()
   
   WHILE TRUE
      LET g_pmas_m.pmas001 = g_pmas001_t
 
      
      #寫入修改者/修改日期資訊
      LET g_pmas_m.pmasmodid = g_user 
LET g_pmas_m.pmasmoddt = cl_get_current()
LET g_pmas_m.pmasmodid_desc = cl_get_username(g_pmas_m.pmasmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      LET g_pmas_m_t.* =  g_pmas_m.*
      #end add-point
 
      #資料輸入
      CALL apmi127_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pmas_m.* = g_pmas_m_t.*
         CALL apmi127_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE pmas_t SET (pmasmodid,pmasmoddt) = (g_pmas_m.pmasmodid,g_pmas_m.pmasmoddt)
       WHERE pmasent = g_enterprise AND pmas001 = g_pmas001_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL apmi127_set_act_visible()
   CALL apmi127_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmasent = " ||g_enterprise|| " AND",
                      " pmas001 = '", g_pmas_m.pmas001, "' "
 
   #填到對應位置
   CALL apmi127_browser_fill(g_wc,"")
 
   CLOSE apmi127_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmi127_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="apmi127.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmi127_input(p_cmd)
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
   DISPLAY BY NAME g_pmas_m.pmas001,g_pmas_m.gzzz001,g_pmas_m.gzzal003,g_pmas_m.gzzz001_1,g_pmas_m.gzzal003_1, 
       g_pmas_m.pmas011,g_pmas_m.pmas003,g_pmas_m.pmas007,g_pmas_m.pmas002,g_pmas_m.pmas004,g_pmas_m.pmas008, 
       g_pmas_m.pmas012,g_pmas_m.pmas005,g_pmas_m.pmas009,g_pmas_m.pmas013,g_pmas_m.pmas006,g_pmas_m.pmas010, 
       g_pmas_m.pmasstus,g_pmas_m.pmasownid,g_pmas_m.pmasownid_desc,g_pmas_m.pmasowndp,g_pmas_m.pmasowndp_desc, 
       g_pmas_m.pmascrtid,g_pmas_m.pmascrtid_desc,g_pmas_m.pmascrtdp,g_pmas_m.pmascrtdp_desc,g_pmas_m.pmascrtdt, 
       g_pmas_m.pmasmodid,g_pmas_m.pmasmodid_desc,g_pmas_m.pmasmoddt
   
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
   CALL apmi127_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apmi127_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_pmas_m.pmas001,g_pmas_m.pmas011,g_pmas_m.pmas003,g_pmas_m.pmas007,g_pmas_m.pmas002, 
          g_pmas_m.pmas004,g_pmas_m.pmas008,g_pmas_m.pmas012,g_pmas_m.pmas005,g_pmas_m.pmas009,g_pmas_m.pmas013, 
          g_pmas_m.pmas006,g_pmas_m.pmas010,g_pmas_m.pmasstus 
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
         BEFORE FIELD pmas001
            #add-point:BEFORE FIELD pmas001 name="input.b.pmas001"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas001
            
            #add-point:AFTER FIELD pmas001 name="input.a.pmas001"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_pmas_m.pmas001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmas_m.pmas001 != g_pmas001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmas_t WHERE "||"pmasent = '" ||g_enterprise|| "' AND "||"pmas001 = '"||g_pmas_m.pmas001 ||"'",'std-00004',0) THEN 
                     LET g_pmas_m.pmas001 = g_pmas_m_t.pmas001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmas001
            #add-point:ON CHANGE pmas001 name="input.g.pmas001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas011
            #add-point:BEFORE FIELD pmas011 name="input.b.pmas011"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas011
            
            #add-point:AFTER FIELD pmas011 name="input.a.pmas011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmas011
            #add-point:ON CHANGE pmas011 name="input.g.pmas011"
            #料件編號是否勾選，決定產品特徵是否開放勾選
            CALL apmi127_set_entry(p_cmd)
            CALL apmi127_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas003
            #add-point:BEFORE FIELD pmas003 name="input.b.pmas003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas003
            
            #add-point:AFTER FIELD pmas003 name="input.a.pmas003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmas003
            #add-point:ON CHANGE pmas003 name="input.g.pmas003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas007
            #add-point:BEFORE FIELD pmas007 name="input.b.pmas007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas007
            
            #add-point:AFTER FIELD pmas007 name="input.a.pmas007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmas007
            #add-point:ON CHANGE pmas007 name="input.g.pmas007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas002
            #add-point:BEFORE FIELD pmas002 name="input.b.pmas002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas002
            
            #add-point:AFTER FIELD pmas002 name="input.a.pmas002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmas002
            #add-point:ON CHANGE pmas002 name="input.g.pmas002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas004
            #add-point:BEFORE FIELD pmas004 name="input.b.pmas004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas004
            
            #add-point:AFTER FIELD pmas004 name="input.a.pmas004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmas004
            #add-point:ON CHANGE pmas004 name="input.g.pmas004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas008
            #add-point:BEFORE FIELD pmas008 name="input.b.pmas008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas008
            
            #add-point:AFTER FIELD pmas008 name="input.a.pmas008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmas008
            #add-point:ON CHANGE pmas008 name="input.g.pmas008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas012
            #add-point:BEFORE FIELD pmas012 name="input.b.pmas012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas012
            
            #add-point:AFTER FIELD pmas012 name="input.a.pmas012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmas012
            #add-point:ON CHANGE pmas012 name="input.g.pmas012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas005
            #add-point:BEFORE FIELD pmas005 name="input.b.pmas005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas005
            
            #add-point:AFTER FIELD pmas005 name="input.a.pmas005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmas005
            #add-point:ON CHANGE pmas005 name="input.g.pmas005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas009
            #add-point:BEFORE FIELD pmas009 name="input.b.pmas009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas009
            
            #add-point:AFTER FIELD pmas009 name="input.a.pmas009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmas009
            #add-point:ON CHANGE pmas009 name="input.g.pmas009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas013
            #add-point:BEFORE FIELD pmas013 name="input.b.pmas013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas013
            
            #add-point:AFTER FIELD pmas013 name="input.a.pmas013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmas013
            #add-point:ON CHANGE pmas013 name="input.g.pmas013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas006
            #add-point:BEFORE FIELD pmas006 name="input.b.pmas006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas006
            
            #add-point:AFTER FIELD pmas006 name="input.a.pmas006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmas006
            #add-point:ON CHANGE pmas006 name="input.g.pmas006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmas010
            #add-point:BEFORE FIELD pmas010 name="input.b.pmas010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmas010
            
            #add-point:AFTER FIELD pmas010 name="input.a.pmas010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmas010
            #add-point:ON CHANGE pmas010 name="input.g.pmas010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmasstus
            #add-point:BEFORE FIELD pmasstus name="input.b.pmasstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmasstus
            
            #add-point:AFTER FIELD pmasstus name="input.a.pmasstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmasstus
            #add-point:ON CHANGE pmasstus name="input.g.pmasstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmas001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas001
            #add-point:ON ACTION controlp INFIELD pmas001 name="input.c.pmas001"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmas011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas011
            #add-point:ON ACTION controlp INFIELD pmas011 name="input.c.pmas011"
 
            #END add-point
 
 
         #Ctrlp:input.c.pmas003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas003
            #add-point:ON ACTION controlp INFIELD pmas003 name="input.c.pmas003"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmas007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas007
            #add-point:ON ACTION controlp INFIELD pmas007 name="input.c.pmas007"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmas002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas002
            #add-point:ON ACTION controlp INFIELD pmas002 name="input.c.pmas002"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmas004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas004
            #add-point:ON ACTION controlp INFIELD pmas004 name="input.c.pmas004"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmas008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas008
            #add-point:ON ACTION controlp INFIELD pmas008 name="input.c.pmas008"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmas012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas012
            #add-point:ON ACTION controlp INFIELD pmas012 name="input.c.pmas012"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmas005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas005
            #add-point:ON ACTION controlp INFIELD pmas005 name="input.c.pmas005"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmas009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas009
            #add-point:ON ACTION controlp INFIELD pmas009 name="input.c.pmas009"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmas013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas013
            #add-point:ON ACTION controlp INFIELD pmas013 name="input.c.pmas013"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmas006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas006
            #add-point:ON ACTION controlp INFIELD pmas006 name="input.c.pmas006"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmas010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmas010
            #add-point:ON ACTION controlp INFIELD pmas010 name="input.c.pmas010"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmasstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmasstus
            #add-point:ON ACTION controlp INFIELD pmasstus name="input.c.pmasstus"
            
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
               SELECT COUNT(1) INTO l_count FROM pmas_t
                WHERE pmasent = g_enterprise AND pmas001 = g_pmas_m.pmas001
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  IF NOT apmi127_all_y_chk() THEN
                     NEXT FIELD CURRENT
                  END IF
                  #料件編號、系列、產品分類至少輸入一個
                  IF g_pmas_m.pmas011='N' AND g_pmas_m.pmas012='N' AND g_pmas_m.pmas013='N' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend=""
                     LET g_errparam.code="apm-00915"
                     LET g_errparam.popup=TRUE
                     CALL cl_err()
                     NEXT FIELD pmas011
                  END IF
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO pmas_t (pmasent,pmas001,pmas011,pmas003,pmas007,pmas002,pmas004,pmas008, 
                      pmas012,pmas005,pmas009,pmas013,pmas006,pmas010,pmasstus,pmasownid,pmasowndp,pmascrtid, 
                      pmascrtdp,pmascrtdt,pmasmodid,pmasmoddt)
                  VALUES (g_enterprise,g_pmas_m.pmas001,g_pmas_m.pmas011,g_pmas_m.pmas003,g_pmas_m.pmas007, 
                      g_pmas_m.pmas002,g_pmas_m.pmas004,g_pmas_m.pmas008,g_pmas_m.pmas012,g_pmas_m.pmas005, 
                      g_pmas_m.pmas009,g_pmas_m.pmas013,g_pmas_m.pmas006,g_pmas_m.pmas010,g_pmas_m.pmasstus, 
                      g_pmas_m.pmasownid,g_pmas_m.pmasowndp,g_pmas_m.pmascrtid,g_pmas_m.pmascrtdp,g_pmas_m.pmascrtdt, 
                      g_pmas_m.pmasmodid,g_pmas_m.pmasmoddt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmas_t:",SQLERRMESSAGE 
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
                  LET g_errparam.extend = g_pmas_m.pmas001
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               IF NOT apmi127_all_y_chk() THEN
                  NEXT FIELD CURRENT
               END IF
               #料件編號、系列、產品分類至少輸入一個
               IF g_pmas_m.pmas011='N' AND g_pmas_m.pmas012='N' AND g_pmas_m.pmas013='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend=""
                  LET g_errparam.code="apm-00915"
                  LET g_errparam.popup=TRUE
                  CALL cl_err()
                  NEXT FIELD pmas011
               END IF
               #end add-point
               
               #將遮罩欄位還原
               CALL apmi127_pmas_t_mask_restore('restore_mask_o')
               
               UPDATE pmas_t SET (pmas001,pmas011,pmas003,pmas007,pmas002,pmas004,pmas008,pmas012,pmas005, 
                   pmas009,pmas013,pmas006,pmas010,pmasstus,pmasownid,pmasowndp,pmascrtid,pmascrtdp, 
                   pmascrtdt,pmasmodid,pmasmoddt) = (g_pmas_m.pmas001,g_pmas_m.pmas011,g_pmas_m.pmas003, 
                   g_pmas_m.pmas007,g_pmas_m.pmas002,g_pmas_m.pmas004,g_pmas_m.pmas008,g_pmas_m.pmas012, 
                   g_pmas_m.pmas005,g_pmas_m.pmas009,g_pmas_m.pmas013,g_pmas_m.pmas006,g_pmas_m.pmas010, 
                   g_pmas_m.pmasstus,g_pmas_m.pmasownid,g_pmas_m.pmasowndp,g_pmas_m.pmascrtid,g_pmas_m.pmascrtdp, 
                   g_pmas_m.pmascrtdt,g_pmas_m.pmasmodid,g_pmas_m.pmasmoddt)
                WHERE pmasent = g_enterprise AND pmas001 = g_pmas001_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmas_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmas_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL apmi127_pmas_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
 
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_pmas_m_t)
                     LET g_log2 = util.JSON.stringify(g_pmas_m)
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
 
{<section id="apmi127.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmi127_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE pmas_t.pmas001 
   DEFINE l_oldno     LIKE pmas_t.pmas001 
 
   DEFINE l_master    RECORD LIKE pmas_t.* #此變數樣板目前無使用
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
   IF g_pmas_m.pmas001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_pmas001_t = g_pmas_m.pmas001
 
   
   #清空key值
   LET g_pmas_m.pmas001 = ""
 
    
   CALL apmi127_set_entry("a")
   CALL apmi127_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmas_m.pmasownid = g_user
      LET g_pmas_m.pmasowndp = g_dept
      LET g_pmas_m.pmascrtid = g_user
      LET g_pmas_m.pmascrtdp = g_dept 
      LET g_pmas_m.pmascrtdt = cl_get_current()
      LET g_pmas_m.pmasmodid = g_user
      LET g_pmas_m.pmasmoddt = cl_get_current()
      LET g_pmas_m.pmasstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_pmas_m.pmasstus = "Y"
   LET g_pmas_m.gzzz001 = ""
   LET g_pmas_m.gzzal003 = ""
   LET g_pmas_m.gzzz001_1 = ""
   LET g_pmas_m.gzzal003_1 = ""
   LET g_pmas_m_t.* = g_pmas_m.*
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmas_m.pmasstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL apmi127_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_pmas_m.* TO NULL
      CALL apmi127_show()
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
      LET g_errparam.extend = "pmas_t:",SQLERRMESSAGE 
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
   CALL apmi127_set_act_visible()
   CALL apmi127_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pmas001_t = g_pmas_m.pmas001
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmasent = " ||g_enterprise|| " AND",
                      " pmas001 = '", g_pmas_m.pmas001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmi127_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_pmas_m.pmasownid      
   LET g_data_dept  = g_pmas_m.pmasowndp
              
   #功能已完成,通報訊息中心
   CALL apmi127_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="apmi127.show" >}
#+ 資料顯示 
PRIVATE FUNCTION apmi127_show()
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
   CALL apmi127_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            CALL apmi127_get_gzzz001(g_pmas_m.pmas001) RETURNING g_pmas_m.gzzz001
            DISPLAY BY NAME g_pmas_m.gzzz001
            
            CALL apmi127_get_gzzal003(g_pmas_m.gzzz001) RETURNING g_pmas_m.gzzal003
            DISPLAY BY NAME g_pmas_m.gzzal003
            
            CALL apmi127_get_gzzz001_1(g_pmas_m.pmas001) RETURNING g_pmas_m.gzzz001_1
            DISPLAY BY NAME g_pmas_m.gzzz001_1
            
            CALL apmi127_get_gzzal003(g_pmas_m.gzzz001_1) RETURNING g_pmas_m.gzzal003_1
            DISPLAY BY NAME g_pmas_m.gzzal003_1
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmas_m.pmasownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmas_m.pmasownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmas_m.pmasownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmas_m.pmasowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmas_m.pmasowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmas_m.pmasowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmas_m.pmascrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmas_m.pmascrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmas_m.pmascrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmas_m.pmascrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmas_m.pmascrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmas_m.pmascrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmas_m.pmasmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmas_m.pmasmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmas_m.pmasmodid_desc

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmas_m.pmas001,g_pmas_m.gzzz001,g_pmas_m.gzzal003,g_pmas_m.gzzz001_1,g_pmas_m.gzzal003_1, 
       g_pmas_m.pmas011,g_pmas_m.pmas003,g_pmas_m.pmas007,g_pmas_m.pmas002,g_pmas_m.pmas004,g_pmas_m.pmas008, 
       g_pmas_m.pmas012,g_pmas_m.pmas005,g_pmas_m.pmas009,g_pmas_m.pmas013,g_pmas_m.pmas006,g_pmas_m.pmas010, 
       g_pmas_m.pmasstus,g_pmas_m.pmasownid,g_pmas_m.pmasownid_desc,g_pmas_m.pmasowndp,g_pmas_m.pmasowndp_desc, 
       g_pmas_m.pmascrtid,g_pmas_m.pmascrtid_desc,g_pmas_m.pmascrtdp,g_pmas_m.pmascrtdp_desc,g_pmas_m.pmascrtdt, 
       g_pmas_m.pmasmodid,g_pmas_m.pmasmodid_desc,g_pmas_m.pmasmoddt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL apmi127_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmas_m.pmasstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   #設定作業編號空白或申請作業編號空白才可執行open_azzi910功能
   IF cl_null(g_pmas_m.gzzz001) OR cl_null(g_pmas_m.gzzz001_1) THEN
      CALL cl_set_act_visible("open_azzi910", TRUE)
   ELSE
      CALL cl_set_act_visible("open_azzi910", FALSE)
   END IF 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmi127.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION apmi127_delete()
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
   IF g_pmas_m.pmas001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_pmas001_t = g_pmas_m.pmas001
 
   
   
 
   OPEN apmi127_cl USING g_enterprise,g_pmas_m.pmas001
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmi127_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE apmi127_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmi127_master_referesh USING g_pmas_m.pmas001 INTO g_pmas_m.pmas001,g_pmas_m.pmas011,g_pmas_m.pmas003, 
       g_pmas_m.pmas007,g_pmas_m.pmas002,g_pmas_m.pmas004,g_pmas_m.pmas008,g_pmas_m.pmas012,g_pmas_m.pmas005, 
       g_pmas_m.pmas009,g_pmas_m.pmas013,g_pmas_m.pmas006,g_pmas_m.pmas010,g_pmas_m.pmasstus,g_pmas_m.pmasownid, 
       g_pmas_m.pmasowndp,g_pmas_m.pmascrtid,g_pmas_m.pmascrtdp,g_pmas_m.pmascrtdt,g_pmas_m.pmasmodid, 
       g_pmas_m.pmasmoddt,g_pmas_m.pmasownid_desc,g_pmas_m.pmasowndp_desc,g_pmas_m.pmascrtid_desc,g_pmas_m.pmascrtdp_desc, 
       g_pmas_m.pmasmodid_desc
   
   
   #檢查是否允許此動作
   IF NOT apmi127_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmas_m_mask_o.* =  g_pmas_m.*
   CALL apmi127_pmas_t_mask()
   LET g_pmas_m_mask_n.* =  g_pmas_m.*
   
   #將最新資料顯示到畫面上
   CALL apmi127_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmi127_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM pmas_t 
       WHERE pmasent = g_enterprise AND pmas001 = g_pmas_m.pmas001 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmas_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
 
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pmas_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE apmi127_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL apmi127_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL apmi127_browser_fill(g_wc,"")
         CALL apmi127_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apmi127_cl
 
   #功能已完成,通報訊息中心
   CALL apmi127_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmi127.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmi127_ui_browser_refresh()
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
      IF g_browser[l_i].b_pmas001 = g_pmas_m.pmas001
 
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
 
{<section id="apmi127.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmi127_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("pmas001",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   IF g_pmas_m.pmas011 = 'Y' THEN    #料件編號是否勾選，決定產品特徵是否開放勾選
      CALL cl_set_comp_entry("pmas002",TRUE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmi127.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmi127_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pmas001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
 
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_pmas_m.pmas011 = 'N' THEN   #料件編號是否勾選，決定產品特徵是否開放勾選
       LET g_pmas_m.pmas002 = 'N'
      CALL cl_set_comp_entry("pmas002",FALSE)
   END IF 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmi127.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmi127_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmi127.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmi127_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmi127.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmi127_default_search()
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
      LET ls_wc = ls_wc, " pmas001 = '", g_argv[01], "' AND "
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
 
{<section id="apmi127.mask_functions" >}
&include "erp/apm/apmi127_mask.4gl"
 
{</section>}
 
{<section id="apmi127.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION apmi127_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_pmas_m.pmas001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN apmi127_cl USING g_enterprise,g_pmas_m.pmas001
   IF STATUS THEN
      CLOSE apmi127_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmi127_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE apmi127_master_referesh USING g_pmas_m.pmas001 INTO g_pmas_m.pmas001,g_pmas_m.pmas011,g_pmas_m.pmas003, 
       g_pmas_m.pmas007,g_pmas_m.pmas002,g_pmas_m.pmas004,g_pmas_m.pmas008,g_pmas_m.pmas012,g_pmas_m.pmas005, 
       g_pmas_m.pmas009,g_pmas_m.pmas013,g_pmas_m.pmas006,g_pmas_m.pmas010,g_pmas_m.pmasstus,g_pmas_m.pmasownid, 
       g_pmas_m.pmasowndp,g_pmas_m.pmascrtid,g_pmas_m.pmascrtdp,g_pmas_m.pmascrtdt,g_pmas_m.pmasmodid, 
       g_pmas_m.pmasmoddt,g_pmas_m.pmasownid_desc,g_pmas_m.pmasowndp_desc,g_pmas_m.pmascrtid_desc,g_pmas_m.pmascrtdp_desc, 
       g_pmas_m.pmasmodid_desc
   
 
   #檢查是否允許此動作
   IF NOT apmi127_action_chk() THEN
      CLOSE apmi127_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmas_m.pmas001,g_pmas_m.gzzz001,g_pmas_m.gzzal003,g_pmas_m.gzzz001_1,g_pmas_m.gzzal003_1, 
       g_pmas_m.pmas011,g_pmas_m.pmas003,g_pmas_m.pmas007,g_pmas_m.pmas002,g_pmas_m.pmas004,g_pmas_m.pmas008, 
       g_pmas_m.pmas012,g_pmas_m.pmas005,g_pmas_m.pmas009,g_pmas_m.pmas013,g_pmas_m.pmas006,g_pmas_m.pmas010, 
       g_pmas_m.pmasstus,g_pmas_m.pmasownid,g_pmas_m.pmasownid_desc,g_pmas_m.pmasowndp,g_pmas_m.pmasowndp_desc, 
       g_pmas_m.pmascrtid,g_pmas_m.pmascrtid_desc,g_pmas_m.pmascrtdp,g_pmas_m.pmascrtdp_desc,g_pmas_m.pmascrtdt, 
       g_pmas_m.pmasmodid,g_pmas_m.pmasmodid_desc,g_pmas_m.pmasmoddt
 
   CASE g_pmas_m.pmasstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_pmas_m.pmasstus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.inactive"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
 
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_pmas_m.pmasstus = lc_state OR cl_null(lc_state) THEN
      CLOSE apmi127_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_pmas_m.pmasmodid = g_user
   LET g_pmas_m.pmasmoddt = cl_get_current()
   LET g_pmas_m.pmasstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE pmas_t 
      SET (pmasstus,pmasmodid,pmasmoddt) 
        = (g_pmas_m.pmasstus,g_pmas_m.pmasmodid,g_pmas_m.pmasmoddt)     
    WHERE pmasent = g_enterprise AND pmas001 = g_pmas_m.pmas001
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE apmi127_master_referesh USING g_pmas_m.pmas001 INTO g_pmas_m.pmas001,g_pmas_m.pmas011, 
          g_pmas_m.pmas003,g_pmas_m.pmas007,g_pmas_m.pmas002,g_pmas_m.pmas004,g_pmas_m.pmas008,g_pmas_m.pmas012, 
          g_pmas_m.pmas005,g_pmas_m.pmas009,g_pmas_m.pmas013,g_pmas_m.pmas006,g_pmas_m.pmas010,g_pmas_m.pmasstus, 
          g_pmas_m.pmasownid,g_pmas_m.pmasowndp,g_pmas_m.pmascrtid,g_pmas_m.pmascrtdp,g_pmas_m.pmascrtdt, 
          g_pmas_m.pmasmodid,g_pmas_m.pmasmoddt,g_pmas_m.pmasownid_desc,g_pmas_m.pmasowndp_desc,g_pmas_m.pmascrtid_desc, 
          g_pmas_m.pmascrtdp_desc,g_pmas_m.pmasmodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_pmas_m.pmas001,g_pmas_m.gzzz001,g_pmas_m.gzzal003,g_pmas_m.gzzz001_1,g_pmas_m.gzzal003_1, 
          g_pmas_m.pmas011,g_pmas_m.pmas003,g_pmas_m.pmas007,g_pmas_m.pmas002,g_pmas_m.pmas004,g_pmas_m.pmas008, 
          g_pmas_m.pmas012,g_pmas_m.pmas005,g_pmas_m.pmas009,g_pmas_m.pmas013,g_pmas_m.pmas006,g_pmas_m.pmas010, 
          g_pmas_m.pmasstus,g_pmas_m.pmasownid,g_pmas_m.pmasownid_desc,g_pmas_m.pmasowndp,g_pmas_m.pmasowndp_desc, 
          g_pmas_m.pmascrtid,g_pmas_m.pmascrtid_desc,g_pmas_m.pmascrtdp,g_pmas_m.pmascrtdp_desc,g_pmas_m.pmascrtdt, 
          g_pmas_m.pmasmodid,g_pmas_m.pmasmodid_desc,g_pmas_m.pmasmoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   IF NOT SQLCA.sqlcode THEN
      UPDATE gzzz_t SET gzzzstus = g_pmas_m.pmasstus
       WHERE gzzz001 = g_pmas_m.gzzz001 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      UPDATE gzzz_t SET gzzzstus = g_pmas_m.pmasstus
       WHERE gzzz001 = g_pmas_m.gzzz001_1 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   CALL cl_set_act_visible("modify,delete",TRUE)
   IF g_pmas_m.pmasstus = 'N' THEN
      CALL cl_set_act_visible("modify,delete",FALSE)
   END IF
   #end add-point  
 
   CLOSE apmi127_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmi127_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmi127.signature" >}
   
 
{</section>}
 
{<section id="apmi127.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmi127_set_pk_array()
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
   LET g_pk_array[1].values = g_pmas_m.pmas001
   LET g_pk_array[1].column = 'pmas001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmi127.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="apmi127.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmi127_msgcentre_notify(lc_state)
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
   CALL apmi127_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmas_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmi127.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apmi127_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmi127.other_function" readonly="Y" >}

PRIVATE FUNCTION apmi127_get_gzzal003(p_gzzz001)
DEFINE p_gzzz001 LIKE gzzz_t.gzzz001
DEFINE r_gzzal003 LIKE gzzal_t.gzzal003
   SELECT gzzal003 INTO r_gzzal003 FROM gzzal_t 
    WHERE gzzal001 = p_gzzz001 AND gzzal002 = g_dlang
   RETURN r_gzzal003
END FUNCTION

PRIVATE FUNCTION apmi127_get_gzzz001(p_pmas001)
DEFINE p_pmas001   LIKE pmas_t.pmas001
DEFINE l_gzzz004   LIKE gzzz_t.gzzz004
DEFINE r_gzzz001   LIKE gzzz_t.gzzz001
   LET l_gzzz004 = '"" "" "" "" "" "" "',p_pmas001,'"'
   SELECT gzzz001 INTO r_gzzz001 FROM gzzz_t 
    WHERE gzzz002 = 'apmi128' AND gzzz004 = l_gzzz004
   RETURN r_gzzz001
END FUNCTION

PRIVATE FUNCTION apmi127_get_gzzz001_1(p_pmas001)
DEFINE p_pmas001   LIKE pmas_t.pmas001
DEFINE l_gzzz004   LIKE gzzz_t.gzzz004
DEFINE r_gzzz001_1 LIKE gzzz_t.gzzz001
   LET l_gzzz004 = '"" "',p_pmas001,'"'
   SELECT gzzz001 INTO r_gzzz001_1 FROM gzzz_t 
    WHERE gzzz002 = 'apmt128' AND gzzz004 = l_gzzz004
   RETURN r_gzzz001_1 
END FUNCTION

PRIVATE FUNCTION apmi127_all_y_chk()
   IF g_pmas_m.pmas002 = 'Y' AND g_pmas_m.pmas003 = 'Y' AND g_pmas_m.pmas004 = 'Y' AND 
      g_pmas_m.pmas005 = 'Y' AND g_pmas_m.pmas006 = 'Y' AND g_pmas_m.pmas007 = 'Y' AND 
      g_pmas_m.pmas008 = 'Y' AND g_pmas_m.pmas009 = 'Y' AND g_pmas_m.pmas010 = 'Y' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00299'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 執行azzi910(系統可執行作業設定)
# Memo...........:
# Usage..........: CALL apmi127_open_azzi910()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 14/04/29 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION apmi127_open_azzi910()
   DEFINE l_gzzz004        LIKE gzzz_t.gzzz004
   DEFINE l_gzzz001        LIKE gzzz_t.gzzz001
   DEFINE l_prog_i         LIKE gzzz_t.gzzz001
   DEFINE l_prog_t         LIKE gzzz_t.gzzz001
   DEFINE l_module_i       LIKE gzzz_t.gzzz005
   DEFINE l_module_t       LIKE gzzz_t.gzzz005
   DEFINE ls_js            STRING
   DEFINE la_param    RECORD
             prog     STRING,
             param    DYNAMIC ARRAY OF STRING
                  END RECORD

   IF cl_null(g_pmas_m.pmas001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '-400'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   ELSE
      LET l_prog_i = 'apmi128'
      LET l_prog_t = 'apmt128'
      LET l_module_i=''   LET l_module_t=''
      SELECT gzzz005 INTO l_module_i FROM gzzz_t WHERE gzzz001=l_prog_i
      SELECT gzzz005 INTO l_module_t FROM gzzz_t WHERE gzzz001=l_prog_t
      IF cl_null(g_pmas_m.gzzz001) AND cl_null(g_pmas_m.gzzz001_1) THEN
#         LET l_msg ="請到azzi910(系統可執行作業設定)手動新增兩筆作業資料。",
#                    "維護作業--",
#                    "程式編號:",l_prog_i,"，",
#                    "第七個額外參數:",g_pmas_m.pmas001,"，",
#                    "歸屬模組:",l_module_i,"。",
#                    "申請作業--",
#                    "程式編號:",l_prog_t,"，",
#                    "第二個額外參數:",g_pmas_m.pmas001,"，",
#                    "歸屬模組:",l_module_t,"，",
#                    "預設單據性質:",l_prog_t
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "azz-00652"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  l_prog_i 
         LET g_errparam.replace[2] =  g_pmas_m.pmas001 
         LET g_errparam.replace[3] =  l_module_i 
         LET g_errparam.replace[4] =  l_prog_t 
         LET g_errparam.replace[5] =  g_pmas_m.pmas001 
         LET g_errparam.replace[6] =  l_module_t 
         LET g_errparam.replace[7] =  l_prog_t
         CALL cl_err()

      END IF
      IF cl_null(g_pmas_m.gzzz001) AND NOT cl_null(g_pmas_m.gzzz001_1) THEN
#         LET l_msg ="請到azzi910(系統可執行作業設定)手動新增作業資料。",
#                    "程式編號:",l_prog_i,"，",
#                    "第七個額外參數:",g_pmas_m.pmas001,"，",
#                    "歸屬模組:",l_module_i,"。",
         INITIALIZE g_errparam TO NULL
         #LET g_errparam.code =  "azz-00653"   #160318-00005#34 
         LET g_errparam.code =  "sub-01335"    #160318-00005#34 
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  l_prog_i 
         LET g_errparam.replace[2] =  g_pmas_m.pmas001 
         LET g_errparam.replace[3] =  l_module_i
         CALL cl_err()

      END IF
      IF NOT cl_null(g_pmas_m.gzzz001) AND cl_null(g_pmas_m.gzzz001_1) THEN
#         LET l_msg ="請到azzi910(系統可執行作業設定)手動新增作業資料。",
#                    "程式編號:",l_prog_t,"，",
#                    "第二個額外參數:",g_pmas_m.pmas001,"，",
#                    "歸屬模組:",l_module_t,"，",
#                    "預設單據性質:",l_prog_t
         INITIALIZE g_errparam TO NULL
         #LET g_errparam.code =  "azz-00654"   #160318-00005#34 
         LET g_errparam.code =  "sub-01335"    #160318-00005#34 
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  l_prog_t 
         LET g_errparam.replace[2] =  g_pmas_m.pmas001 
         LET g_errparam.replace[3] =  l_module_t 
         LET g_errparam.replace[4] =  l_prog_t
         CALL cl_err()

      END IF   
      LET la_param.prog = 'azzi910'
      LET la_param.param[1] = g_pmas_m.pmas001   #故意傳一個不存在的作業編號,讓azzi910開起來是沒有資料的
      LET ls_js = util.JSON.stringify( la_param )
      CALL cl_cmdrun(ls_js)      
   END IF
END FUNCTION

 
{</section>}
 
