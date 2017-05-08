#該程式未解開Section, 採用最新樣板產出!
{<section id="aimi101.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2016-10-24 16:04:28), PR版次:0016(2016-10-27 17:36:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000383
#+ Filename...: aimi101
#+ Description: 集團預設料件產品分群資料維護作業
#+ Creator....: 02294(2013-07-17 17:11:36)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="aimi101.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160705-00042#11 2016/07/14 By sakura  程式中寫死g_prog部分改寫MATCHES方式
#160523-00031#1  2016/08/02 By zhujing 將主畫面上的所有欄位放到瀏覽畫面上
#161013-00017#1  2016/10/24 By zhujing 可以直接在aimi100增加新的分群代號，不用先在aimi001增加
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
#+ Modifier...:   No.160318-00025#39  2016/04/22  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"  
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_imcb_m RECORD
       imcb011 LIKE imcb_t.imcb011, 
   oocql004 LIKE oocql_t.oocql004, 
   oocql005 LIKE oocql_t.oocql005, 
   imcb012 LIKE imcb_t.imcb012, 
   imcb013 LIKE imcb_t.imcb013, 
   imcb014 LIKE imcb_t.imcb014, 
   imcb015 LIKE imcb_t.imcb015, 
   imcb015_desc LIKE type_t.chr80, 
   imcb016 LIKE imcb_t.imcb016, 
   imcb016_desc LIKE type_t.chr80, 
   imcb017 LIKE imcb_t.imcb017, 
   imcb017_desc LIKE type_t.chr80, 
   imcb018 LIKE imcb_t.imcb018, 
   imcbstus LIKE imcb_t.imcbstus, 
   imcbownid LIKE imcb_t.imcbownid, 
   imcbownid_desc LIKE type_t.chr80, 
   imcbowndp LIKE imcb_t.imcbowndp, 
   imcbowndp_desc LIKE type_t.chr80, 
   imcbcrtid LIKE imcb_t.imcbcrtid, 
   imcbcrtid_desc LIKE type_t.chr80, 
   imcbcrtdp LIKE imcb_t.imcbcrtdp, 
   imcbcrtdp_desc LIKE type_t.chr80, 
   imcbcrtdt LIKE imcb_t.imcbcrtdt, 
   imcbmodid LIKE imcb_t.imcbmodid, 
   imcbmodid_desc LIKE type_t.chr80, 
   imcbmoddt LIKE imcb_t.imcbmoddt, 
   imcb021 LIKE imcb_t.imcb021, 
   imcb022 LIKE imcb_t.imcb022, 
   imcb023 LIKE imcb_t.imcb023, 
   imcb024 LIKE imcb_t.imcb024, 
   imcb025 LIKE imcb_t.imcb025, 
   imcb026 LIKE imcb_t.imcb026, 
   imcb027 LIKE imcb_t.imcb027, 
   imcb031 LIKE imcb_t.imcb031, 
   imcb032 LIKE imcb_t.imcb032, 
   imcb033 LIKE imcb_t.imcb033, 
   imcb034 LIKE imcb_t.imcb034
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_imcb011 LIKE imcb_t.imcb011,
   b_imcb011_desc LIKE type_t.chr80,
      b_imcb012 LIKE imcb_t.imcb012,
      b_imcb013 LIKE imcb_t.imcb013,
      b_imcb014 LIKE imcb_t.imcb014,
      b_imcb015 LIKE imcb_t.imcb015,
   b_imcb015_desc LIKE type_t.chr80,
      b_imcb016 LIKE imcb_t.imcb016,
   b_imcb016_desc LIKE type_t.chr80,
      b_imcb017 LIKE imcb_t.imcb017,
   b_imcb017_desc LIKE type_t.chr80,
      b_imcb018 LIKE imcb_t.imcb018,
      b_imcb021 LIKE imcb_t.imcb021,
      b_imcb022 LIKE imcb_t.imcb022,
      b_imcb023 LIKE imcb_t.imcb023,
      b_imcb024 LIKE imcb_t.imcb024,
      b_imcb025 LIKE imcb_t.imcb025,
      b_imcb026 LIKE imcb_t.imcb026,
      b_imcb027 LIKE imcb_t.imcb027,
      b_imcb031 LIKE imcb_t.imcb031,
      b_imcb032 LIKE imcb_t.imcb032,
      b_imcb033 LIKE imcb_t.imcb033,
      b_imcb034 LIKE imcb_t.imcb034
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_t              LIKE ooef_t.ooef001
#end add-point
 
#模組變數(Module Variables)
DEFINE g_imcb_m        type_g_imcb_m  #單頭變數宣告
DEFINE g_imcb_m_t      type_g_imcb_m  #單頭舊值宣告(系統還原用)
DEFINE g_imcb_m_o      type_g_imcb_m  #單頭舊值宣告(其他用途)
DEFINE g_imcb_m_mask_o type_g_imcb_m  #轉換遮罩前資料
DEFINE g_imcb_m_mask_n type_g_imcb_m  #轉換遮罩後資料
 
   DEFINE g_imcb011_t LIKE imcb_t.imcb011
 
   
 
   
DEFINE g_master_multi_table_t    RECORD
      oocql001 LIKE oocql_t.oocql001,
      oocql002 LIKE oocql_t.oocql002,
      oocql004 LIKE oocql_t.oocql004,
      oocql005 LIKE oocql_t.oocql005
      END RECORD
 
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
 
{<section id="aimi101.main" >}
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
   CALL cl_ap_init("aim","")
 
   #add-point:作業初始化 name="main.init"
   LET g_site_t = g_site  #備份當前的營運據點
   
   IF NOT cl_null(g_argv[1]) THEN
      LET g_site = g_argv[1]
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT imcb011,'','',imcb012,imcb013,imcb014,imcb015,'',imcb016,'',imcb017,'', 
       imcb018,imcbstus,imcbownid,'',imcbowndp,'',imcbcrtid,'',imcbcrtdp,'',imcbcrtdt,imcbmodid,'',imcbmoddt, 
       imcb021,imcb022,imcb023,imcb024,imcb025,imcb026,imcb027,imcb031,imcb032,imcb033,imcb034", 
                      " FROM imcb_t",
                      " WHERE imcbent= ? AND imcbsite= ? AND imcb011=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimi101_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imcb011,t0.imcb012,t0.imcb013,t0.imcb014,t0.imcb015,t0.imcb016,t0.imcb017, 
       t0.imcb018,t0.imcbstus,t0.imcbownid,t0.imcbowndp,t0.imcbcrtid,t0.imcbcrtdp,t0.imcbcrtdt,t0.imcbmodid, 
       t0.imcbmoddt,t0.imcb021,t0.imcb022,t0.imcb023,t0.imcb024,t0.imcb025,t0.imcb026,t0.imcb027,t0.imcb031, 
       t0.imcb032,t0.imcb033,t0.imcb034,t1.oocal003 ,t2.oocql004 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 , 
       t6.ooefl003 ,t7.ooag011",
               " FROM imcb_t t0",
                              " LEFT JOIN oocal_t t1 ON t1.oocalent="||g_enterprise||" AND t1.oocal001=t0.imcb015 AND t1.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='210' AND t2.oocql002=t0.imcb016 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.imcbownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.imcbowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.imcbcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.imcbcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.imcbmodid  ",
 
               " WHERE t0.imcbent = " ||g_enterprise|| " AND t0.imcbsite = ? AND t0.imcb011 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aimi101_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimi101 WITH FORM cl_ap_formpath("aim",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aimi101_init()   
 
      #進入選單 Menu (="N")
      CALL aimi101_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aimi101
      
   END IF 
   
   CLOSE aimi101_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aimi101.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aimi101_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('imcbstus','17','N,Y')
 
      CALL cl_set_combo_scc('imcb012','2021') 
   CALL cl_set_combo_scc('imcb013','2022') 
   CALL cl_set_combo_scc('imcb014','2023') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
      CALL cl_set_combo_scc("b_imcb012",2021)
      CALL cl_set_combo_scc("b_imcb013",2022)
      CALL cl_set_combo_scc("b_imcb014",2023)
      CALL cl_set_combo_scc("imcb012",2021)
      CALL cl_set_combo_scc("imcb013",2022)
      CALL cl_set_combo_scc("imcb014",2023)
   #end add-point
   
   #根據外部參數進行搜尋
   CALL aimi101_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aimi101.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimi101_ui_dialog() 
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
   DEFINE l_cmd    STRING
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
            CALL aimi101_insert()
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
         INITIALIZE g_imcb_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aimi101_init()
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
               CALL aimi101_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aimi101_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               #若執行集團級程式，則不開放切換營運中心的功能
               #IF g_prog = 'aimi101' THEN        #160705-00042#11 160714 by sakura mark
               IF g_prog MATCHES 'aimi101' THEN   #160705-00042#11 160714 by sakura add
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aimi101_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aimi101_set_act_visible()
               CALL aimi101_set_act_no_visible()
               IF NOT (g_imcb_m.imcb011 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " imcbent = " ||g_enterprise|| " AND imcbsite = '" ||g_site|| "' AND",
                                     " imcb011 = '", g_imcb_m.imcb011, "' "
 
                  #填到對應位置
                  CALL aimi101_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL aimi101_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimi101_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aimi101_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aimi101_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aimi101_fetch("L")  
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
                  CALL aimi101_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimi101_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimi101_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimi101_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_cg
            LET g_action_choice="open_cg"
            IF cl_auth_chk_act("open_cg") THEN
               
               #add-point:ON ACTION open_cg name="menu2.open_cg"
               IF g_site = 'ALL' THEN
                  CALL cl_cmdrun("aimi104")
               ELSE
                  CALL cl_cmdrun("aimi114")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_sg
            LET g_action_choice="open_sg"
            IF cl_auth_chk_act("open_sg") THEN
               
               #add-point:ON ACTION open_sg name="menu2.open_sg"
               IF g_site = 'ALL' THEN
                  CALL cl_cmdrun("aimi105")
               ELSE
                  CALL cl_cmdrun("aimi115")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aimi101_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aimi101_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_kc
            LET g_action_choice="open_kc"
            IF cl_auth_chk_act("open_kc") THEN
               
               #add-point:ON ACTION open_kc name="menu2.open_kc"
               IF g_site = 'ALL' THEN
                  CALL cl_cmdrun("aimi102")
               ELSE
                  CALL cl_cmdrun("aimi112")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_xs
            LET g_action_choice="open_xs"
            IF cl_auth_chk_act("open_xs") THEN
               
               #add-point:ON ACTION open_xs name="menu2.open_xs"
               IF g_site = 'ALL' THEN
                  CALL cl_cmdrun("aimi103")
               ELSE
                  CALL cl_cmdrun("aimi113")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION about_file
            LET g_action_choice="about_file"
            IF cl_auth_chk_act("about_file") THEN
               
               #add-point:ON ACTION about_file name="menu2.about_file"
               
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
               CALL aimi101_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimi101_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pg
            LET g_action_choice="open_pg"
            IF cl_auth_chk_act("open_pg") THEN
               
               #add-point:ON ACTION open_pg name="menu2.open_pg"
               IF g_site = 'ALL' THEN
                  CALL cl_cmdrun("aimi106")
               ELSE
                  CALL cl_cmdrun("aimi116")
               END IF
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimi101_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimi101_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimi101_set_pk_array()
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
                  CALL aimi101_fetch("")
 
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
                  CALL aimi101_browser_fill(g_wc,"")
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
                  CALL aimi101_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               #若執行集團級程式，則不開放切換營運中心的功能
               #IF g_prog = 'aimi101' THEN        #160705-00042#11 160714 by sakura mark
               IF g_prog MATCHES 'aimi101' THEN   #160705-00042#11 160714 by sakura add
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aimi101_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aimi101_set_act_visible()
               CALL aimi101_set_act_no_visible()
               IF NOT (g_imcb_m.imcb011 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " imcbent = " ||g_enterprise|| " AND imcbsite = '" ||g_site|| "' AND",
                                     " imcb011 = '", g_imcb_m.imcb011, "' "
 
                  #填到對應位置
                  CALL aimi101_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aimi101_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL aimi101_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimi101_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aimi101_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aimi101_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aimi101_fetch("L")  
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
                  CALL aimi101_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimi101_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimi101_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimi101_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_cg
            LET g_action_choice="open_cg"
            IF cl_auth_chk_act("open_cg") THEN
               
               #add-point:ON ACTION open_cg name="menu.open_cg"
               IF g_site = 'ALL' THEN
                  CALL cl_cmdrun("aimi104")
               ELSE
                  CALL cl_cmdrun("aimi114")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_sg
            LET g_action_choice="open_sg"
            IF cl_auth_chk_act("open_sg") THEN
               
               #add-point:ON ACTION open_sg name="menu.open_sg"
               IF g_site = 'ALL' THEN
                  CALL cl_cmdrun("aimi105")
               ELSE
                  CALL cl_cmdrun("aimi115")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aimi101_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aimi101_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_kc
            LET g_action_choice="open_kc"
            IF cl_auth_chk_act("open_kc") THEN
               
               #add-point:ON ACTION open_kc name="menu.open_kc"
               IF g_site = 'ALL' THEN
                  CALL cl_cmdrun("aimi102")
               ELSE
                  CALL cl_cmdrun("aimi112")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_xs
            LET g_action_choice="open_xs"
            IF cl_auth_chk_act("open_xs") THEN
               
               #add-point:ON ACTION open_xs name="menu.open_xs"
               IF g_site = 'ALL' THEN
                  CALL cl_cmdrun("aimi103")
               ELSE
                  CALL cl_cmdrun("aimi113")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION about_file
            LET g_action_choice="about_file"
            IF cl_auth_chk_act("about_file") THEN
               
               #add-point:ON ACTION about_file name="menu.about_file"
               
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
               CALL aimi101_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimi101_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pg
            LET g_action_choice="open_pg"
            IF cl_auth_chk_act("open_pg") THEN
               
               #add-point:ON ACTION open_pg name="menu.open_pg"
               IF g_site = 'ALL' THEN
                  CALL cl_cmdrun("aimi106")
               ELSE
                  CALL cl_cmdrun("aimi116")
               END IF
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimi101_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimi101_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimi101_set_pk_array()
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
 
{<section id="aimi101.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION aimi101_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "imcb011"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM imcb_t ",
               "  ",
               "  LEFT JOIN oocql_t ON oocqlent = "||g_enterprise||" AND '200' = oocql001 AND imcb011 = oocql002 AND oocql003 = '",g_dlang,"' ",
               " WHERE imcbent = " ||g_enterprise|| " AND imcbsite = '" ||g_site|| "' AND ", 
               p_wc CLIPPED, cl_sql_add_filter("imcb_t")
                
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
      INITIALIZE g_imcb_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.imcbstus,t0.imcb011,t0.imcb012,t0.imcb013,t0.imcb014,t0.imcb015,t0.imcb016, 
       t0.imcb017,t0.imcb018,t0.imcb021,t0.imcb022,t0.imcb023,t0.imcb024,t0.imcb025,t0.imcb026,t0.imcb027, 
       t0.imcb031,t0.imcb032,t0.imcb033,t0.imcb034,t1.oocql004 ,t2.oocal003 ,t3.oocql004",
               " FROM imcb_t t0 ",
               "  ",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='200' AND t1.oocql002=t0.imcb011 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=t0.imcb015 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='210' AND t3.oocql002=t0.imcb016 AND t3.oocql003='"||g_dlang||"' ",
 
               " WHERE t0.imcbent = " ||g_enterprise|| " AND t0.imcbsite = '" ||g_site|| "' AND ", ls_wc, cl_sql_add_filter("imcb_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"imcb_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imcb011,g_browser[g_cnt].b_imcb012, 
          g_browser[g_cnt].b_imcb013,g_browser[g_cnt].b_imcb014,g_browser[g_cnt].b_imcb015,g_browser[g_cnt].b_imcb016, 
          g_browser[g_cnt].b_imcb017,g_browser[g_cnt].b_imcb018,g_browser[g_cnt].b_imcb021,g_browser[g_cnt].b_imcb022, 
          g_browser[g_cnt].b_imcb023,g_browser[g_cnt].b_imcb024,g_browser[g_cnt].b_imcb025,g_browser[g_cnt].b_imcb026, 
          g_browser[g_cnt].b_imcb027,g_browser[g_cnt].b_imcb031,g_browser[g_cnt].b_imcb032,g_browser[g_cnt].b_imcb033, 
          g_browser[g_cnt].b_imcb034,g_browser[g_cnt].b_imcb011_desc,g_browser[g_cnt].b_imcb015_desc, 
          g_browser[g_cnt].b_imcb016_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         #160523-00031#1 add-S
         IF NOT cl_null(g_browser[g_cnt].b_imcb017) THEN
            CALL aimi101_imcb017_ref(g_browser[g_cnt].b_imcb017) RETURNING  g_browser[g_cnt].b_imcb017_desc
         END IF
         #160523-00031#1 add-E
         #end add-point
         
         #遮罩相關處理
         CALL aimi101_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_imcb011) THEN
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
 
{<section id="aimi101.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimi101_construct()
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
   INITIALIZE g_imcb_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON imcb011,oocql004,oocql005,imcb012,imcb013,imcb014,imcb015,imcb016,imcb017, 
          imcb018,imcbstus,imcbownid,imcbowndp,imcbcrtid,imcbcrtdp,imcbcrtdt,imcbmodid,imcbmoddt,imcb021, 
          imcb022,imcb023,imcb024,imcb025,imcb026,imcb027,imcb031,imcb032,imcb033,imcb034
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imcbcrtdt>>----
         AFTER FIELD imcbcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imcbmoddt>>----
         AFTER FIELD imcbmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imcbcnfdt>>----
         
         #----<<imcbpstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.imcb011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb011
            #add-point:ON ACTION controlp INFIELD imcb011 name="construct.c.imcb011"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.arg1 = '200'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcb011  #顯示到畫面上
            NEXT FIELD imcb011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb011
            #add-point:BEFORE FIELD imcb011 name="construct.b.imcb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb011
            
            #add-point:AFTER FIELD imcb011 name="construct.a.imcb011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql004
            #add-point:BEFORE FIELD oocql004 name="construct.b.oocql004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql004
            
            #add-point:AFTER FIELD oocql004 name="construct.a.oocql004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocql004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql004
            #add-point:ON ACTION controlp INFIELD oocql004 name="construct.c.oocql004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql005
            #add-point:BEFORE FIELD oocql005 name="construct.b.oocql005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql005
            
            #add-point:AFTER FIELD oocql005 name="construct.a.oocql005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocql005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql005
            #add-point:ON ACTION controlp INFIELD oocql005 name="construct.c.oocql005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb012
            #add-point:BEFORE FIELD imcb012 name="construct.b.imcb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb012
            
            #add-point:AFTER FIELD imcb012 name="construct.a.imcb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb012
            #add-point:ON ACTION controlp INFIELD imcb012 name="construct.c.imcb012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb013
            #add-point:BEFORE FIELD imcb013 name="construct.b.imcb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb013
            
            #add-point:AFTER FIELD imcb013 name="construct.a.imcb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb013
            #add-point:ON ACTION controlp INFIELD imcb013 name="construct.c.imcb013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb014
            #add-point:BEFORE FIELD imcb014 name="construct.b.imcb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb014
            
            #add-point:AFTER FIELD imcb014 name="construct.a.imcb014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb014
            #add-point:ON ACTION controlp INFIELD imcb014 name="construct.c.imcb014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb015
            #add-point:ON ACTION controlp INFIELD imcb015 name="construct.c.imcb015"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oocastus = 'Y' "
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcb015  #顯示到畫面上
            LET g_qryparam.where = " "
            NEXT FIELD imcb015                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb015
            #add-point:BEFORE FIELD imcb015 name="construct.b.imcb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb015
            
            #add-point:AFTER FIELD imcb015 name="construct.a.imcb015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb016
            #add-point:ON ACTION controlp INFIELD imcb016 name="construct.c.imcb016"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.arg1 = '210'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oocqstus = 'Y' "
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcb016  #顯示到畫面上
            LET g_qryparam.where = " "
            NEXT FIELD imcb016                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb016
            #add-point:BEFORE FIELD imcb016 name="construct.b.imcb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb016
            
            #add-point:AFTER FIELD imcb016 name="construct.a.imcb016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb017
            #add-point:ON ACTION controlp INFIELD imcb017 name="construct.c.imcb017"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#LET g_qryparam.where = " oodb008 = 'Y' "
            IF g_site = 'ALL' THEN
			   LET g_qryparam.arg1 = g_site_t
			ELSE
			   LET g_qryparam.arg1 = g_site
			END IF
            CALL q_oodb002_3()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcb017  #顯示到畫面上
            LET g_qryparam.where = " "
            NEXT FIELD imcb017                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb017
            #add-point:BEFORE FIELD imcb017 name="construct.b.imcb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb017
            
            #add-point:AFTER FIELD imcb017 name="construct.a.imcb017"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb018
            #add-point:BEFORE FIELD imcb018 name="construct.b.imcb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb018
            
            #add-point:AFTER FIELD imcb018 name="construct.a.imcb018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb018
            #add-point:ON ACTION controlp INFIELD imcb018 name="construct.c.imcb018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcbstus
            #add-point:BEFORE FIELD imcbstus name="construct.b.imcbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcbstus
            
            #add-point:AFTER FIELD imcbstus name="construct.a.imcbstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcbstus
            #add-point:ON ACTION controlp INFIELD imcbstus name="construct.c.imcbstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcbownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcbownid
            #add-point:ON ACTION controlp INFIELD imcbownid name="construct.c.imcbownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcbownid  #顯示到畫面上

            NEXT FIELD imcbownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcbownid
            #add-point:BEFORE FIELD imcbownid name="construct.b.imcbownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcbownid
            
            #add-point:AFTER FIELD imcbownid name="construct.a.imcbownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcbowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcbowndp
            #add-point:ON ACTION controlp INFIELD imcbowndp name="construct.c.imcbowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcbowndp  #顯示到畫面上

            NEXT FIELD imcbowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcbowndp
            #add-point:BEFORE FIELD imcbowndp name="construct.b.imcbowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcbowndp
            
            #add-point:AFTER FIELD imcbowndp name="construct.a.imcbowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcbcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcbcrtid
            #add-point:ON ACTION controlp INFIELD imcbcrtid name="construct.c.imcbcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcbcrtid  #顯示到畫面上

            NEXT FIELD imcbcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcbcrtid
            #add-point:BEFORE FIELD imcbcrtid name="construct.b.imcbcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcbcrtid
            
            #add-point:AFTER FIELD imcbcrtid name="construct.a.imcbcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcbcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcbcrtdp
            #add-point:ON ACTION controlp INFIELD imcbcrtdp name="construct.c.imcbcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcbcrtdp  #顯示到畫面上

            NEXT FIELD imcbcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcbcrtdp
            #add-point:BEFORE FIELD imcbcrtdp name="construct.b.imcbcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcbcrtdp
            
            #add-point:AFTER FIELD imcbcrtdp name="construct.a.imcbcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcbcrtdt
            #add-point:BEFORE FIELD imcbcrtdt name="construct.b.imcbcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcbmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcbmodid
            #add-point:ON ACTION controlp INFIELD imcbmodid name="construct.c.imcbmodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcbmodid  #顯示到畫面上

            NEXT FIELD imcbmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcbmodid
            #add-point:BEFORE FIELD imcbmodid name="construct.b.imcbmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcbmodid
            
            #add-point:AFTER FIELD imcbmodid name="construct.a.imcbmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcbmoddt
            #add-point:BEFORE FIELD imcbmoddt name="construct.b.imcbmoddt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb021
            #add-point:BEFORE FIELD imcb021 name="construct.b.imcb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb021
            
            #add-point:AFTER FIELD imcb021 name="construct.a.imcb021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb021
            #add-point:ON ACTION controlp INFIELD imcb021 name="construct.c.imcb021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb022
            #add-point:BEFORE FIELD imcb022 name="construct.b.imcb022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb022
            
            #add-point:AFTER FIELD imcb022 name="construct.a.imcb022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb022
            #add-point:ON ACTION controlp INFIELD imcb022 name="construct.c.imcb022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb023
            #add-point:BEFORE FIELD imcb023 name="construct.b.imcb023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb023
            
            #add-point:AFTER FIELD imcb023 name="construct.a.imcb023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb023
            #add-point:ON ACTION controlp INFIELD imcb023 name="construct.c.imcb023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb024
            #add-point:BEFORE FIELD imcb024 name="construct.b.imcb024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb024
            
            #add-point:AFTER FIELD imcb024 name="construct.a.imcb024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb024
            #add-point:ON ACTION controlp INFIELD imcb024 name="construct.c.imcb024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb025
            #add-point:BEFORE FIELD imcb025 name="construct.b.imcb025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb025
            
            #add-point:AFTER FIELD imcb025 name="construct.a.imcb025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb025
            #add-point:ON ACTION controlp INFIELD imcb025 name="construct.c.imcb025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb026
            #add-point:BEFORE FIELD imcb026 name="construct.b.imcb026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb026
            
            #add-point:AFTER FIELD imcb026 name="construct.a.imcb026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb026
            #add-point:ON ACTION controlp INFIELD imcb026 name="construct.c.imcb026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb027
            #add-point:BEFORE FIELD imcb027 name="construct.b.imcb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb027
            
            #add-point:AFTER FIELD imcb027 name="construct.a.imcb027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb027
            #add-point:ON ACTION controlp INFIELD imcb027 name="construct.c.imcb027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb031
            #add-point:BEFORE FIELD imcb031 name="construct.b.imcb031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb031
            
            #add-point:AFTER FIELD imcb031 name="construct.a.imcb031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb031
            #add-point:ON ACTION controlp INFIELD imcb031 name="construct.c.imcb031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb032
            #add-point:BEFORE FIELD imcb032 name="construct.b.imcb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb032
            
            #add-point:AFTER FIELD imcb032 name="construct.a.imcb032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb032
            #add-point:ON ACTION controlp INFIELD imcb032 name="construct.c.imcb032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb033
            #add-point:BEFORE FIELD imcb033 name="construct.b.imcb033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb033
            
            #add-point:AFTER FIELD imcb033 name="construct.a.imcb033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb033
            #add-point:ON ACTION controlp INFIELD imcb033 name="construct.c.imcb033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb034
            #add-point:BEFORE FIELD imcb034 name="construct.b.imcb034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb034
            
            #add-point:AFTER FIELD imcb034 name="construct.a.imcb034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcb034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb034
            #add-point:ON ACTION controlp INFIELD imcb034 name="construct.c.imcb034"
            
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
 
{<section id="aimi101.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aimi101_filter()
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
      CONSTRUCT g_wc_filter ON imcb011,imcb012,imcb013,imcb014,imcb015,imcb016,imcb017,imcb018,imcb021, 
          imcb022,imcb023,imcb024,imcb025,imcb026,imcb027,imcb031,imcb032,imcb033,imcb034
                          FROM s_browse[1].b_imcb011,s_browse[1].b_imcb012,s_browse[1].b_imcb013,s_browse[1].b_imcb014, 
                              s_browse[1].b_imcb015,s_browse[1].b_imcb016,s_browse[1].b_imcb017,s_browse[1].b_imcb018, 
                              s_browse[1].b_imcb021,s_browse[1].b_imcb022,s_browse[1].b_imcb023,s_browse[1].b_imcb024, 
                              s_browse[1].b_imcb025,s_browse[1].b_imcb026,s_browse[1].b_imcb027,s_browse[1].b_imcb031, 
                              s_browse[1].b_imcb032,s_browse[1].b_imcb033,s_browse[1].b_imcb034
 
         BEFORE CONSTRUCT
               DISPLAY aimi101_filter_parser('imcb011') TO s_browse[1].b_imcb011
            DISPLAY aimi101_filter_parser('imcb012') TO s_browse[1].b_imcb012
            DISPLAY aimi101_filter_parser('imcb013') TO s_browse[1].b_imcb013
            DISPLAY aimi101_filter_parser('imcb014') TO s_browse[1].b_imcb014
            DISPLAY aimi101_filter_parser('imcb015') TO s_browse[1].b_imcb015
            DISPLAY aimi101_filter_parser('imcb016') TO s_browse[1].b_imcb016
            DISPLAY aimi101_filter_parser('imcb017') TO s_browse[1].b_imcb017
            DISPLAY aimi101_filter_parser('imcb018') TO s_browse[1].b_imcb018
            DISPLAY aimi101_filter_parser('imcb021') TO s_browse[1].b_imcb021
            DISPLAY aimi101_filter_parser('imcb022') TO s_browse[1].b_imcb022
            DISPLAY aimi101_filter_parser('imcb023') TO s_browse[1].b_imcb023
            DISPLAY aimi101_filter_parser('imcb024') TO s_browse[1].b_imcb024
            DISPLAY aimi101_filter_parser('imcb025') TO s_browse[1].b_imcb025
            DISPLAY aimi101_filter_parser('imcb026') TO s_browse[1].b_imcb026
            DISPLAY aimi101_filter_parser('imcb027') TO s_browse[1].b_imcb027
            DISPLAY aimi101_filter_parser('imcb031') TO s_browse[1].b_imcb031
            DISPLAY aimi101_filter_parser('imcb032') TO s_browse[1].b_imcb032
            DISPLAY aimi101_filter_parser('imcb033') TO s_browse[1].b_imcb033
            DISPLAY aimi101_filter_parser('imcb034') TO s_browse[1].b_imcb034
      
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
 
      CALL aimi101_filter_show('imcb011')
   CALL aimi101_filter_show('imcb012')
   CALL aimi101_filter_show('imcb013')
   CALL aimi101_filter_show('imcb014')
   CALL aimi101_filter_show('imcb015')
   CALL aimi101_filter_show('imcb016')
   CALL aimi101_filter_show('imcb017')
   CALL aimi101_filter_show('imcb018')
   CALL aimi101_filter_show('imcb021')
   CALL aimi101_filter_show('imcb022')
   CALL aimi101_filter_show('imcb023')
   CALL aimi101_filter_show('imcb024')
   CALL aimi101_filter_show('imcb025')
   CALL aimi101_filter_show('imcb026')
   CALL aimi101_filter_show('imcb027')
   CALL aimi101_filter_show('imcb031')
   CALL aimi101_filter_show('imcb032')
   CALL aimi101_filter_show('imcb033')
   CALL aimi101_filter_show('imcb034')
 
END FUNCTION
 
{</section>}
 
{<section id="aimi101.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aimi101_filter_parser(ps_field)
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
 
{<section id="aimi101.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aimi101_filter_show(ps_field)
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
   LET ls_condition = aimi101_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aimi101.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aimi101_query()
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
 
   INITIALIZE g_imcb_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aimi101_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aimi101_browser_fill(g_wc,"F")
      CALL aimi101_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aimi101_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL aimi101_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aimi101.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aimi101_fetch(p_fl)
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
   LET g_imcb_m.imcb011 = g_browser[g_current_idx].b_imcb011
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aimi101_master_referesh USING g_site,g_imcb_m.imcb011 INTO g_imcb_m.imcb011,g_imcb_m.imcb012, 
       g_imcb_m.imcb013,g_imcb_m.imcb014,g_imcb_m.imcb015,g_imcb_m.imcb016,g_imcb_m.imcb017,g_imcb_m.imcb018, 
       g_imcb_m.imcbstus,g_imcb_m.imcbownid,g_imcb_m.imcbowndp,g_imcb_m.imcbcrtid,g_imcb_m.imcbcrtdp, 
       g_imcb_m.imcbcrtdt,g_imcb_m.imcbmodid,g_imcb_m.imcbmoddt,g_imcb_m.imcb021,g_imcb_m.imcb022,g_imcb_m.imcb023, 
       g_imcb_m.imcb024,g_imcb_m.imcb025,g_imcb_m.imcb026,g_imcb_m.imcb027,g_imcb_m.imcb031,g_imcb_m.imcb032, 
       g_imcb_m.imcb033,g_imcb_m.imcb034,g_imcb_m.imcb015_desc,g_imcb_m.imcb016_desc,g_imcb_m.imcbownid_desc, 
       g_imcb_m.imcbowndp_desc,g_imcb_m.imcbcrtid_desc,g_imcb_m.imcbcrtdp_desc,g_imcb_m.imcbmodid_desc 
 
   
   #遮罩相關處理
   LET g_imcb_m_mask_o.* =  g_imcb_m.*
   CALL aimi101_imcb_t_mask()
   LET g_imcb_m_mask_n.* =  g_imcb_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimi101_set_act_visible()
   CALL aimi101_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("delete", TRUE)
   IF g_imcb_m.imcbstus != 'Y' THEN
      CALL cl_set_act_visible("delete", FALSE)
   END IF
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_imcb_m_t.* = g_imcb_m.*
   LET g_imcb_m_o.* = g_imcb_m.*
   
   LET g_data_owner = g_imcb_m.imcbownid      
   LET g_data_dept  = g_imcb_m.imcbowndp
   
   #重新顯示
   CALL aimi101_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="aimi101.insert" >}
#+ 資料新增
PRIVATE FUNCTION aimi101_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_imcb_m.* TO NULL             #DEFAULT 設定
   LET g_imcb011_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imcb_m.imcbownid = g_user
      LET g_imcb_m.imcbowndp = g_dept
      LET g_imcb_m.imcbcrtid = g_user
      LET g_imcb_m.imcbcrtdp = g_dept 
      LET g_imcb_m.imcbcrtdt = cl_get_current()
      LET g_imcb_m.imcbmodid = g_user
      LET g_imcb_m.imcbmoddt = cl_get_current()
      LET g_imcb_m.imcbstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_imcb_m.imcb012 = "1"
      LET g_imcb_m.imcb013 = "1"
      LET g_imcb_m.imcb014 = "1"
      LET g_imcb_m.imcb018 = "N"
      LET g_imcb_m.imcbstus = "Y"
      LET g_imcb_m.imcb021 = "0"
      LET g_imcb_m.imcb022 = "0"
      LET g_imcb_m.imcb023 = "0"
      LET g_imcb_m.imcb024 = "0"
      LET g_imcb_m.imcb025 = "0"
      LET g_imcb_m.imcb026 = "0"
      LET g_imcb_m.imcb027 = "0"
      LET g_imcb_m.imcb031 = "0"
      LET g_imcb_m.imcb032 = "0"
      LET g_imcb_m.imcb033 = "0"
      LET g_imcb_m.imcb034 = "N"
 
 
      #add-point:單頭預設值 name="insert.default"
#2014/10/29 by stellar mark ---------- (S)
#樣板有自動給預設值
#      LET g_imcb_m.imcbstus = "Y"
#      LET g_imcb_m.imcb012 = '1'
#      LET g_imcb_m.imcb013 = '1'
#      LET g_imcb_m.imcb014 = '1'
#      LET g_imcb_m.imcb021 = 0
#      LET g_imcb_m.imcb022 = 0
#      LET g_imcb_m.imcb023 = 0
#      LET g_imcb_m.imcb024 = 0
#      LET g_imcb_m.imcb025 = 0
#      LET g_imcb_m.imcb026 = 0
#      LET g_imcb_m.imcb027 = 0
#2014/10/29 by stellar mark ---------- (E)
      
      INITIALIZE g_imcb_m_t.* LIKE imcb_t.*
      LET g_imcb_m_t.* = g_imcb_m.*
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imcb_m.imcbstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL aimi101_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_imcb_m.* TO NULL
         CALL aimi101_show()
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
   CALL aimi101_set_act_visible()
   CALL aimi101_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imcb011_t = g_imcb_m.imcb011
 
   
   #組合新增資料的條件
   LET g_add_browse = " imcbent = " ||g_enterprise|| " AND imcbsite = '" ||g_site|| "' AND",
                      " imcb011 = '", g_imcb_m.imcb011, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimi101_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aimi101_master_referesh USING g_site,g_imcb_m.imcb011 INTO g_imcb_m.imcb011,g_imcb_m.imcb012, 
       g_imcb_m.imcb013,g_imcb_m.imcb014,g_imcb_m.imcb015,g_imcb_m.imcb016,g_imcb_m.imcb017,g_imcb_m.imcb018, 
       g_imcb_m.imcbstus,g_imcb_m.imcbownid,g_imcb_m.imcbowndp,g_imcb_m.imcbcrtid,g_imcb_m.imcbcrtdp, 
       g_imcb_m.imcbcrtdt,g_imcb_m.imcbmodid,g_imcb_m.imcbmoddt,g_imcb_m.imcb021,g_imcb_m.imcb022,g_imcb_m.imcb023, 
       g_imcb_m.imcb024,g_imcb_m.imcb025,g_imcb_m.imcb026,g_imcb_m.imcb027,g_imcb_m.imcb031,g_imcb_m.imcb032, 
       g_imcb_m.imcb033,g_imcb_m.imcb034,g_imcb_m.imcb015_desc,g_imcb_m.imcb016_desc,g_imcb_m.imcbownid_desc, 
       g_imcb_m.imcbowndp_desc,g_imcb_m.imcbcrtid_desc,g_imcb_m.imcbcrtdp_desc,g_imcb_m.imcbmodid_desc 
 
   
   
   #遮罩相關處理
   LET g_imcb_m_mask_o.* =  g_imcb_m.*
   CALL aimi101_imcb_t_mask()
   LET g_imcb_m_mask_n.* =  g_imcb_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imcb_m.imcb011,g_imcb_m.oocql004,g_imcb_m.oocql005,g_imcb_m.imcb012,g_imcb_m.imcb013, 
       g_imcb_m.imcb014,g_imcb_m.imcb015,g_imcb_m.imcb015_desc,g_imcb_m.imcb016,g_imcb_m.imcb016_desc, 
       g_imcb_m.imcb017,g_imcb_m.imcb017_desc,g_imcb_m.imcb018,g_imcb_m.imcbstus,g_imcb_m.imcbownid, 
       g_imcb_m.imcbownid_desc,g_imcb_m.imcbowndp,g_imcb_m.imcbowndp_desc,g_imcb_m.imcbcrtid,g_imcb_m.imcbcrtid_desc, 
       g_imcb_m.imcbcrtdp,g_imcb_m.imcbcrtdp_desc,g_imcb_m.imcbcrtdt,g_imcb_m.imcbmodid,g_imcb_m.imcbmodid_desc, 
       g_imcb_m.imcbmoddt,g_imcb_m.imcb021,g_imcb_m.imcb022,g_imcb_m.imcb023,g_imcb_m.imcb024,g_imcb_m.imcb025, 
       g_imcb_m.imcb026,g_imcb_m.imcb027,g_imcb_m.imcb031,g_imcb_m.imcb032,g_imcb_m.imcb033,g_imcb_m.imcb034 
 
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_imcb_m.imcbownid      
   LET g_data_dept  = g_imcb_m.imcbowndp
 
   #功能已完成,通報訊息中心
   CALL aimi101_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aimi101.modify" >}
#+ 資料修改
PRIVATE FUNCTION aimi101_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_imcb_m.imcb011 IS NULL
 
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
   LET g_imcb011_t = g_imcb_m.imcb011
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aimi101_cl USING g_enterprise, g_site,g_imcb_m.imcb011
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi101_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimi101_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimi101_master_referesh USING g_site,g_imcb_m.imcb011 INTO g_imcb_m.imcb011,g_imcb_m.imcb012, 
       g_imcb_m.imcb013,g_imcb_m.imcb014,g_imcb_m.imcb015,g_imcb_m.imcb016,g_imcb_m.imcb017,g_imcb_m.imcb018, 
       g_imcb_m.imcbstus,g_imcb_m.imcbownid,g_imcb_m.imcbowndp,g_imcb_m.imcbcrtid,g_imcb_m.imcbcrtdp, 
       g_imcb_m.imcbcrtdt,g_imcb_m.imcbmodid,g_imcb_m.imcbmoddt,g_imcb_m.imcb021,g_imcb_m.imcb022,g_imcb_m.imcb023, 
       g_imcb_m.imcb024,g_imcb_m.imcb025,g_imcb_m.imcb026,g_imcb_m.imcb027,g_imcb_m.imcb031,g_imcb_m.imcb032, 
       g_imcb_m.imcb033,g_imcb_m.imcb034,g_imcb_m.imcb015_desc,g_imcb_m.imcb016_desc,g_imcb_m.imcbownid_desc, 
       g_imcb_m.imcbowndp_desc,g_imcb_m.imcbcrtid_desc,g_imcb_m.imcbcrtdp_desc,g_imcb_m.imcbmodid_desc 
 
 
   #檢查是否允許此動作
   IF NOT aimi101_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_imcb_m_mask_o.* =  g_imcb_m.*
   CALL aimi101_imcb_t_mask()
   LET g_imcb_m_mask_n.* =  g_imcb_m.*
   
   
 
   #顯示資料
   CALL aimi101_show()
   
   WHILE TRUE
      LET g_imcb_m.imcb011 = g_imcb011_t
 
      
      #寫入修改者/修改日期資訊
      LET g_imcb_m.imcbmodid = g_user 
LET g_imcb_m.imcbmoddt = cl_get_current()
LET g_imcb_m.imcbmodid_desc = cl_get_username(g_imcb_m.imcbmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL aimi101_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_imcb_m.* = g_imcb_m_t.*
         CALL aimi101_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE imcb_t SET (imcbmodid,imcbmoddt) = (g_imcb_m.imcbmodid,g_imcb_m.imcbmoddt)
       WHERE imcbent = g_enterprise AND imcbsite = g_site AND imcb011 = g_imcb011_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimi101_set_act_visible()
   CALL aimi101_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imcbent = " ||g_enterprise|| " AND imcbsite = '" ||g_site|| "' AND",
                      " imcb011 = '", g_imcb_m.imcb011, "' "
 
   #填到對應位置
   CALL aimi101_browser_fill(g_wc,"")
 
   CLOSE aimi101_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimi101_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aimi101.input" >}
#+ 資料輸入
PRIVATE FUNCTION aimi101_input(p_cmd)
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
   DEFINE l_ooef019      LIKE ooef_t.ooef019
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
   DISPLAY BY NAME g_imcb_m.imcb011,g_imcb_m.oocql004,g_imcb_m.oocql005,g_imcb_m.imcb012,g_imcb_m.imcb013, 
       g_imcb_m.imcb014,g_imcb_m.imcb015,g_imcb_m.imcb015_desc,g_imcb_m.imcb016,g_imcb_m.imcb016_desc, 
       g_imcb_m.imcb017,g_imcb_m.imcb017_desc,g_imcb_m.imcb018,g_imcb_m.imcbstus,g_imcb_m.imcbownid, 
       g_imcb_m.imcbownid_desc,g_imcb_m.imcbowndp,g_imcb_m.imcbowndp_desc,g_imcb_m.imcbcrtid,g_imcb_m.imcbcrtid_desc, 
       g_imcb_m.imcbcrtdp,g_imcb_m.imcbcrtdp_desc,g_imcb_m.imcbcrtdt,g_imcb_m.imcbmodid,g_imcb_m.imcbmodid_desc, 
       g_imcb_m.imcbmoddt,g_imcb_m.imcb021,g_imcb_m.imcb022,g_imcb_m.imcb023,g_imcb_m.imcb024,g_imcb_m.imcb025, 
       g_imcb_m.imcb026,g_imcb_m.imcb027,g_imcb_m.imcb031,g_imcb_m.imcb032,g_imcb_m.imcb033,g_imcb_m.imcb034 
 
   
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
   CALL aimi101_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aimi101_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_imcb_m.imcb011,g_imcb_m.oocql004,g_imcb_m.oocql005,g_imcb_m.imcb012,g_imcb_m.imcb013, 
          g_imcb_m.imcb014,g_imcb_m.imcb015,g_imcb_m.imcb016,g_imcb_m.imcb017,g_imcb_m.imcb018,g_imcb_m.imcbstus, 
          g_imcb_m.imcb021,g_imcb_m.imcb022,g_imcb_m.imcb023,g_imcb_m.imcb024,g_imcb_m.imcb025,g_imcb_m.imcb026, 
          g_imcb_m.imcb027,g_imcb_m.imcb031,g_imcb_m.imcb032,g_imcb_m.imcb033,g_imcb_m.imcb034 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               #161013-00017#1 add-S
               IF NOT cl_null(g_imcb_m.imcb011)  THEN
                  CALL n_oocql('200',g_imcb_m.imcb011)    # n_glacl:對應多語言表格 。 g_glac_m.glac002: 對應值
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = '200'
                  LET g_ref_fields[2] = g_imcb_m.imcb011
                  CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
                      ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imcb_m.oocql004 = g_rtn_fields[1]
                  LET g_imcb_m.oocql005 = g_rtn_fields[2]

                  DISPLAY BY NAME g_imcb_m.oocql004
                  DISPLAY BY NAME g_imcb_m.oocql005
               END IF
               #161013-00017#1 add-E
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.oocql001 = '200'
LET g_master_multi_table_t.oocql002 = g_imcb_m.imcb011
LET g_master_multi_table_t.oocql004 = g_imcb_m.oocql004
LET g_master_multi_table_t.oocql005 = g_imcb_m.oocql005
 
            #add-point:input開始前 name="input.before.input"
            IF p_cmd = 'a' THEN
               LET g_imcb_m.imcb011 = ''
               DISPLAY BY NAME g_imcb_m.imcb011        #161013-00017#1 add
#               LET g_imcb_m.imcb011_desc = ''         #161013-00017#1 marked
#               DISPLAY BY NAME g_imcb_m.imcb011,g_imcb_m.imcb011_desc   #161013-00017#1 marked
               LET g_imcb_m.imcbownid = g_user
               LET g_imcb_m.imcbowndp = g_dept
               LET g_imcb_m.imcbcrtid = g_user
               LET g_imcb_m.imcbcrtdp = g_dept 
               LET g_imcb_m.imcbcrtdt = cl_get_current()
               LET g_imcb_m.imcbmodid = NULL
               LET g_imcb_m.imcbmoddt = NULL
               LET g_imcb_m.imcbstus = "Y"
               CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
               DISPLAY BY NAME g_imcb_m.imcbstus
            END IF
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb011
            #add-point:BEFORE FIELD imcb011 name="input.b.imcb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb011
            
            #add-point:AFTER FIELD imcb011 name="input.a.imcb011"
            #此段落由子樣板a05產生
            #161013-00017#1 marked-S
#            CALL aimi101_imcb011_ref(g_imcb_m.imcb011) RETURNING g_imcb_m.imcb011_desc
#            DISPLAY BY NAME g_imcb_m.imcb011_desc
            #161013-00017#1 marked-E
            IF NOT cl_null(g_imcb_m.imcb011) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imcb_m.imcb011 != g_imcb011_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM imcb_t WHERE "||"imcbent = '" ||g_enterprise|| "' AND imcbsite = '" ||g_site|| "' AND "||"imcb011 = '"||g_imcb_m.imcb011 ||"'",'std-00004',0) THEN 
                     LET g_imcb_m.imcb011 = g_imcb_m_t.imcb011
                     #161013-00017#1 marked-S
#                     CALL aimi101_imcb011_ref(g_imcb_m.imcb011) RETURNING g_imcb_m.imcb011_desc
#                     DISPLAY BY NAME g_imcb_m.imcb011_desc
                     #161013-00017#1 marked-E
                     #161013-00017#1 add-S
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = '200'
                     LET g_ref_fields[2] = g_imcb_m.imcb011
                     CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
                         ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                     LET g_imcb_m.oocql004 = g_rtn_fields[1]
                     LET g_imcb_m.oocql005 = g_rtn_fields[2]
   
                     DISPLAY BY NAME g_imcb_m.oocql004
                     DISPLAY BY NAME g_imcb_m.oocql005
                     #161013-00017#1 add-E
                     NEXT FIELD CURRENT
                  END IF 
                  #161013-00017#1 add-S
                  LET l_count = 1
                  SELECT COUNT(1) INTO l_count FROM oocq_t
                   WHERE oocqent = g_enterprise AND oocq001 = '200' AND oocq002 = g_imcb_m.imcb011
                  IF l_count > 0 THEN
                     LET l_count = 1
                     SELECT COUNT(1) INTO l_count FROM oocq_t
                      WHERE oocqent = g_enterprise AND oocq001 = '200' AND oocq002 = g_imcb_m.imcb011 AND oocqstus = 'Y'
                     IF l_count = 0 OR cl_null(l_count) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aim-00095'
                        LET g_errparam.extend = g_imcb_m.imcb011 
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_imcb_m.imcb011 = g_imcb_m_t.imcb011
                        INITIALIZE g_ref_fields TO NULL
                        LET g_ref_fields[1] = '200'
                        LET g_ref_fields[2] = g_imcb_m.imcb011
                        CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
                            ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                        LET g_imcb_m.oocql004 = g_rtn_fields[1]
                        LET g_imcb_m.oocql005 = g_rtn_fields[2]
                        DISPLAY BY NAME g_imcb_m.oocql004
                        DISPLAY BY NAME g_imcb_m.oocql005
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #161013-00017#1 add-E
                  #161013-00017#1 marked-S
#                  IF NOT s_azzi650_chk_exist('200',g_imcb_m.imcb011) THEN
#                     LET g_imcb_m.imcb011 = g_imcb_m_t.imcb011
#                     CALL aimi101_imcb011_ref(g_imcb_m.imcb011) RETURNING g_imcb_m.imcb011_desc
#                     DISPLAY BY NAME g_imcb_m.imcb011_desc
#                     NEXT FIELD CURRENT
#                  END IF                  
                  #161013-00017#1 marked-E
                  #161013-00017#1 add-S
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = '200'
                  LET g_ref_fields[2] = g_imcb_m.imcb011
                  CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
                      ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imcb_m.oocql004 = g_rtn_fields[1]
                  LET g_imcb_m.oocql005 = g_rtn_fields[2]

                  DISPLAY BY NAME g_imcb_m.oocql004
                  DISPLAY BY NAME g_imcb_m.oocql005
                  #161013-00017#1 add-E
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb011
            #add-point:ON CHANGE imcb011 name="input.g.imcb011"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql004
            #add-point:BEFORE FIELD oocql004 name="input.b.oocql004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql004
            
            #add-point:AFTER FIELD oocql004 name="input.a.oocql004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocql004
            #add-point:ON CHANGE oocql004 name="input.g.oocql004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql005
            #add-point:BEFORE FIELD oocql005 name="input.b.oocql005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql005
            
            #add-point:AFTER FIELD oocql005 name="input.a.oocql005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocql005
            #add-point:ON CHANGE oocql005 name="input.g.oocql005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb012
            #add-point:BEFORE FIELD imcb012 name="input.b.imcb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb012
            
            #add-point:AFTER FIELD imcb012 name="input.a.imcb012"
            CALL aimi101_imcb012_set()
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb012
            #add-point:ON CHANGE imcb012 name="input.g.imcb012"
            CALL aimi101_imcb012_set() 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb013
            #add-point:BEFORE FIELD imcb013 name="input.b.imcb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb013
            
            #add-point:AFTER FIELD imcb013 name="input.a.imcb013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb013
            #add-point:ON CHANGE imcb013 name="input.g.imcb013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb014
            #add-point:BEFORE FIELD imcb014 name="input.b.imcb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb014
            
            #add-point:AFTER FIELD imcb014 name="input.a.imcb014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb014
            #add-point:ON CHANGE imcb014 name="input.g.imcb014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb015
            
            #add-point:AFTER FIELD imcb015 name="input.a.imcb015"
            CALL aimi101_imcb015_ref(g_imcb_m.imcb015) RETURNING g_imcb_m.imcb015_desc
            DISPLAY BY NAME g_imcb_m.imcb015_desc
            IF NOT cl_null(g_imcb_m.imcb015) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imcb_m.imcb015 != g_imcb_m_t.imcb015 ))) THEN  
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
         
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_imcb_m.imcb015
                  #160318-00025#39  2016/04/22  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#39  2016/04/22  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooca001") THEN 
                     LET g_imcb_m.imcb015 = g_imcb_m_t.imcb015 
                     CALL aimi101_imcb015_ref(g_imcb_m.imcb015) RETURNING g_imcb_m.imcb015_desc
                     DISPLAY BY NAME g_imcb_m.imcb015_desc
                     NEXT FIELD CURRENT
                  END IF
                  
               #END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb015
            #add-point:BEFORE FIELD imcb015 name="input.b.imcb015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb015
            #add-point:ON CHANGE imcb015 name="input.g.imcb015"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb016
            
            #add-point:AFTER FIELD imcb016 name="input.a.imcb016"
            CALL aimi101_imcb016_ref(g_imcb_m.imcb016) RETURNING g_imcb_m.imcb016_desc
            DISPLAY BY NAME g_imcb_m.imcb016_desc
            IF NOT cl_null(g_imcb_m.imcb016) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imcb_m.imcb016 != g_imcb_m_t.imcb016 ))) THEN                    
                  IF NOT s_azzi650_chk_exist('210',g_imcb_m.imcb016) THEN
                     LET g_imcb_m.imcb016 = g_imcb_m_t.imcb016
                     CALL aimi101_imcb016_ref(g_imcb_m.imcb016) RETURNING g_imcb_m.imcb016_desc
                     DISPLAY BY NAME g_imcb_m.imcb016_desc
                     NEXT FIELD CURRENT
                  END IF
                  
               #END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb016
            #add-point:BEFORE FIELD imcb016 name="input.b.imcb016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb016
            #add-point:ON CHANGE imcb016 name="input.g.imcb016"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb017
            
            #add-point:AFTER FIELD imcb017 name="input.a.imcb017"
            CALL aimi101_imcb017_ref(g_imcb_m.imcb017) RETURNING g_imcb_m.imcb017_desc
            DISPLAY BY NAME g_imcb_m.imcb017_desc
            IF NOT cl_null(g_imcb_m.imcb017) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imcb_m.imcb017 != g_imcb_m_t.imcb017 OR cl_null(g_imcb_m_t.imcb017))) THEN                    
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
   
                  #設定g_chkparam.*的參數
                  IF g_site = 'ALL' THEN
                     LET g_chkparam.arg1 = g_site_t
                  ELSE
                     LET g_chkparam.arg1 = g_site
                  END IF
                  LET g_chkparam.arg2 = g_imcb_m.imcb017
                  #160318-00025#39  2016/04/22  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  #160318-00025#39  2016/04/22  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_oodb002") THEN
                     LET g_imcb_m.imcb017 = g_imcb_m_t.imcb017
                     CALL aimi101_imcb017_ref(g_imcb_m.imcb017) RETURNING g_imcb_m.imcb017_desc
                     DISPLAY BY NAME g_imcb_m.imcb017_desc
                     NEXT FIELD CURRENT
                  END IF                  
               #END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb017
            #add-point:BEFORE FIELD imcb017 name="input.b.imcb017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb017
            #add-point:ON CHANGE imcb017 name="input.g.imcb017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb018
            #add-point:BEFORE FIELD imcb018 name="input.b.imcb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb018
            
            #add-point:AFTER FIELD imcb018 name="input.a.imcb018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb018
            #add-point:ON CHANGE imcb018 name="input.g.imcb018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcbstus
            #add-point:BEFORE FIELD imcbstus name="input.b.imcbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcbstus
            
            #add-point:AFTER FIELD imcbstus name="input.a.imcbstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcbstus
            #add-point:ON CHANGE imcbstus name="input.g.imcbstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb021
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imcb_m.imcb021,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imcb021
            END IF 
 
 
 
            #add-point:AFTER FIELD imcb021 name="input.a.imcb021"
             IF g_imcb_m.imcb021 < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aim-00009'
                LET g_errparam.extend = g_imcb_m.imcb021
                LET g_errparam.popup = FALSE
                CALL cl_err()

                LET g_imcb_m.imcb021 = g_imcb_m_t.imcb021
                NEXT FIELD imcb021
             END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb021
            #add-point:BEFORE FIELD imcb021 name="input.b.imcb021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb021
            #add-point:ON CHANGE imcb021 name="input.g.imcb021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imcb_m.imcb022,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imcb022
            END IF 
 
 
 
            #add-point:AFTER FIELD imcb022 name="input.a.imcb022"
             IF g_imcb_m.imcb022 < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aim-00009'
                LET g_errparam.extend = g_imcb_m.imcb022
                LET g_errparam.popup = FALSE
                CALL cl_err()

                LET g_imcb_m.imcb022 = g_imcb_m_t.imcb022
                NEXT FIELD imcb022
             END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb022
            #add-point:BEFORE FIELD imcb022 name="input.b.imcb022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb022
            #add-point:ON CHANGE imcb022 name="input.g.imcb022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb023
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imcb_m.imcb023,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imcb023
            END IF 
 
 
 
            #add-point:AFTER FIELD imcb023 name="input.a.imcb023"
             IF g_imcb_m.imcb023 < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aim-00009'
                LET g_errparam.extend = g_imcb_m.imcb023
                LET g_errparam.popup = FALSE
                CALL cl_err()

                LET g_imcb_m.imcb023 = g_imcb_m_t.imcb023
                NEXT FIELD imcb023
             END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb023
            #add-point:BEFORE FIELD imcb023 name="input.b.imcb023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb023
            #add-point:ON CHANGE imcb023 name="input.g.imcb023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb024
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imcb_m.imcb024,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imcb024
            END IF 
 
 
 
            #add-point:AFTER FIELD imcb024 name="input.a.imcb024"
             IF g_imcb_m.imcb024 < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aim-00009'
                LET g_errparam.extend = g_imcb_m.imcb024
                LET g_errparam.popup = FALSE
                CALL cl_err()

                LET g_imcb_m.imcb024 = g_imcb_m_t.imcb024
                NEXT FIELD imcb024
             END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb024
            #add-point:BEFORE FIELD imcb024 name="input.b.imcb024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb024
            #add-point:ON CHANGE imcb024 name="input.g.imcb024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb025
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imcb_m.imcb025,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imcb025
            END IF 
 
 
 
            #add-point:AFTER FIELD imcb025 name="input.a.imcb025"
             IF g_imcb_m.imcb025 < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aim-00009'
                LET g_errparam.extend = g_imcb_m.imcb025
                LET g_errparam.popup = FALSE
                CALL cl_err()

                LET g_imcb_m.imcb025 = g_imcb_m_t.imcb025
                NEXT FIELD imcb025
             END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb025
            #add-point:BEFORE FIELD imcb025 name="input.b.imcb025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb025
            #add-point:ON CHANGE imcb025 name="input.g.imcb025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb026
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imcb_m.imcb026,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imcb026
            END IF 
 
 
 
            #add-point:AFTER FIELD imcb026 name="input.a.imcb026"
             IF g_imcb_m.imcb026 < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aim-00009'
                LET g_errparam.extend = g_imcb_m.imcb026
                LET g_errparam.popup = FALSE
                CALL cl_err()

                LET g_imcb_m.imcb026 = g_imcb_m_t.imcb026
                NEXT FIELD imcb026
             END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb026
            #add-point:BEFORE FIELD imcb026 name="input.b.imcb026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb026
            #add-point:ON CHANGE imcb026 name="input.g.imcb026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb027
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imcb_m.imcb027,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imcb027
            END IF 
 
 
 
            #add-point:AFTER FIELD imcb027 name="input.a.imcb027"
             IF g_imcb_m.imcb027 < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aim-00009'
                LET g_errparam.extend = g_imcb_m.imcb027
                LET g_errparam.popup = FALSE
                CALL cl_err()

                LET g_imcb_m.imcb027 = g_imcb_m_t.imcb027
                NEXT FIELD imcb027
             END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb027
            #add-point:BEFORE FIELD imcb027 name="input.b.imcb027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb027
            #add-point:ON CHANGE imcb027 name="input.g.imcb027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb031
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imcb_m.imcb031,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imcb031
            END IF 
 
 
 
            #add-point:AFTER FIELD imcb031 name="input.a.imcb031"
             IF g_imcb_m.imcb031 < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aim-00009'
                LET g_errparam.extend = g_imcb_m.imcb031
                LET g_errparam.popup = FALSE
                CALL cl_err()

                LET g_imcb_m.imcb031 = g_imcb_m_t.imcb031
                NEXT FIELD imcb031
             END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb031
            #add-point:BEFORE FIELD imcb031 name="input.b.imcb031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb031
            #add-point:ON CHANGE imcb031 name="input.g.imcb031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb032
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imcb_m.imcb032,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imcb032
            END IF 
 
 
 
            #add-point:AFTER FIELD imcb032 name="input.a.imcb032"
             IF g_imcb_m.imcb032 < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aim-00009'
                LET g_errparam.extend = g_imcb_m.imcb032
                LET g_errparam.popup = FALSE
                CALL cl_err()

                LET g_imcb_m.imcb032 = g_imcb_m_t.imcb032
                NEXT FIELD imcb032
             END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb032
            #add-point:BEFORE FIELD imcb032 name="input.b.imcb032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb032
            #add-point:ON CHANGE imcb032 name="input.g.imcb032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb033
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imcb_m.imcb033,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imcb033
            END IF 
 
 
 
            #add-point:AFTER FIELD imcb033 name="input.a.imcb033"
             IF g_imcb_m.imcb033 < 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'aim-00009'
                LET g_errparam.extend = g_imcb_m.imcb033
                LET g_errparam.popup = FALSE
                CALL cl_err()

                LET g_imcb_m.imcb033 = g_imcb_m_t.imcb033
                NEXT FIELD imcb033
             END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb033
            #add-point:BEFORE FIELD imcb033 name="input.b.imcb033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb033
            #add-point:ON CHANGE imcb033 name="input.g.imcb033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcb034
            #add-point:BEFORE FIELD imcb034 name="input.b.imcb034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcb034
            
            #add-point:AFTER FIELD imcb034 name="input.a.imcb034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcb034
            #add-point:ON CHANGE imcb034 name="input.g.imcb034"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imcb011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb011
            #add-point:ON ACTION controlp INFIELD imcb011 name="input.c.imcb011"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcb_m.imcb011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "200" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imcb_m.imcb011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imcb_m.imcb011 TO imcb011              #顯示到畫面上
            #161013-00017#1 marked-S
#            CALL aimi101_imcb011_ref(g_imcb_m.imcb011) RETURNING g_imcb_m.imcb011_desc
#            DISPLAY BY NAME g_imcb_m.imcb011_desc
            #161013-00017#1 marked-E
            #161013-00017#1 add-S
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = '200'
            LET g_ref_fields[2] = g_imcb_m.imcb011
            CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
                ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imcb_m.oocql004 = g_rtn_fields[1]
            LET g_imcb_m.oocql005 = g_rtn_fields[2]
            
            DISPLAY BY NAME g_imcb_m.oocql004
            DISPLAY BY NAME g_imcb_m.oocql005
            #161013-00017#1 add-E
            NEXT FIELD imcb011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.oocql004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql004
            #add-point:ON ACTION controlp INFIELD oocql004 name="input.c.oocql004"
            
            #END add-point
 
 
         #Ctrlp:input.c.oocql005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql005
            #add-point:ON ACTION controlp INFIELD oocql005 name="input.c.oocql005"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb012
            #add-point:ON ACTION controlp INFIELD imcb012 name="input.c.imcb012"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb013
            #add-point:ON ACTION controlp INFIELD imcb013 name="input.c.imcb013"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb014
            #add-point:ON ACTION controlp INFIELD imcb014 name="input.c.imcb014"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb015
            #add-point:ON ACTION controlp INFIELD imcb015 name="input.c.imcb015"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcb_m.imcb015             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imcb_m.imcb015 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imcb_m.imcb015 TO imcb015              #顯示到畫面上
            CALL aimi101_imcb015_ref(g_imcb_m.imcb015) RETURNING g_imcb_m.imcb015_desc
            DISPLAY BY NAME g_imcb_m.imcb015_desc
            NEXT FIELD imcb015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcb016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb016
            #add-point:ON ACTION controlp INFIELD imcb016 name="input.c.imcb016"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcb_m.imcb016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "210" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imcb_m.imcb016 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imcb_m.imcb016 TO imcb016              #顯示到畫面上
            CALL aimi101_imcb016_ref(g_imcb_m.imcb016) RETURNING g_imcb_m.imcb016_desc
            DISPLAY BY NAME g_imcb_m.imcb016_desc
            NEXT FIELD imcb016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcb017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb017
            #add-point:ON ACTION controlp INFIELD imcb017 name="input.c.imcb017"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			IF g_site = 'ALL' THEN
			   LET g_qryparam.arg1 = g_site_t
			ELSE
			   LET g_qryparam.arg1 = g_site
			END IF
            #LET g_qryparam.where = " oodb008 = 'Y' "
            LET g_qryparam.default1 = g_imcb_m.imcb017             #給予default值

            CALL q_oodb002_3()                                #呼叫開窗

            LET g_imcb_m.imcb017 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imcb_m.imcb017 TO imcb017              #顯示到畫面上
            LET g_qryparam.where = " "
            CALL aimi101_imcb017_ref(g_imcb_m.imcb017) RETURNING g_imcb_m.imcb017_desc
            DISPLAY BY NAME g_imcb_m.imcb017_desc

            NEXT FIELD imcb017      
            #END add-point
 
 
         #Ctrlp:input.c.imcb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb018
            #add-point:ON ACTION controlp INFIELD imcb018 name="input.c.imcb018"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcbstus
            #add-point:ON ACTION controlp INFIELD imcbstus name="input.c.imcbstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb021
            #add-point:ON ACTION controlp INFIELD imcb021 name="input.c.imcb021"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb022
            #add-point:ON ACTION controlp INFIELD imcb022 name="input.c.imcb022"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb023
            #add-point:ON ACTION controlp INFIELD imcb023 name="input.c.imcb023"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb024
            #add-point:ON ACTION controlp INFIELD imcb024 name="input.c.imcb024"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb025
            #add-point:ON ACTION controlp INFIELD imcb025 name="input.c.imcb025"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb026
            #add-point:ON ACTION controlp INFIELD imcb026 name="input.c.imcb026"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb027
            #add-point:ON ACTION controlp INFIELD imcb027 name="input.c.imcb027"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb031
            #add-point:ON ACTION controlp INFIELD imcb031 name="input.c.imcb031"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb032
            #add-point:ON ACTION controlp INFIELD imcb032 name="input.c.imcb032"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb033
            #add-point:ON ACTION controlp INFIELD imcb033 name="input.c.imcb033"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcb034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcb034
            #add-point:ON ACTION controlp INFIELD imcb034 name="input.c.imcb034"
            
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
               SELECT COUNT(1) INTO l_count FROM imcb_t
                WHERE imcbent = g_enterprise AND imcbsite = g_site AND imcb011 = g_imcb_m.imcb011
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO imcb_t (imcbent, imcbsite,imcb011,imcb012,imcb013,imcb014,imcb015,imcb016, 
                      imcb017,imcb018,imcbstus,imcbownid,imcbowndp,imcbcrtid,imcbcrtdp,imcbcrtdt,imcbmodid, 
                      imcbmoddt,imcb021,imcb022,imcb023,imcb024,imcb025,imcb026,imcb027,imcb031,imcb032, 
                      imcb033,imcb034)
                  VALUES (g_enterprise, g_site,g_imcb_m.imcb011,g_imcb_m.imcb012,g_imcb_m.imcb013,g_imcb_m.imcb014, 
                      g_imcb_m.imcb015,g_imcb_m.imcb016,g_imcb_m.imcb017,g_imcb_m.imcb018,g_imcb_m.imcbstus, 
                      g_imcb_m.imcbownid,g_imcb_m.imcbowndp,g_imcb_m.imcbcrtid,g_imcb_m.imcbcrtdp,g_imcb_m.imcbcrtdt, 
                      g_imcb_m.imcbmodid,g_imcb_m.imcbmoddt,g_imcb_m.imcb021,g_imcb_m.imcb022,g_imcb_m.imcb023, 
                      g_imcb_m.imcb024,g_imcb_m.imcb025,g_imcb_m.imcb026,g_imcb_m.imcb027,g_imcb_m.imcb031, 
                      g_imcb_m.imcb032,g_imcb_m.imcb033,g_imcb_m.imcb034) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  #161013-00017#1 add-S
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcb_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET l_count = 1
                  SELECT COUNT(1) INTO l_count FROM oocq_t
                   WHERE oocqent = g_enterprise AND oocq001 = '200' AND oocq002 = g_imcb_m.imcb011
                  IF l_count = 0 THEN #新增分类码及说明
                     INSERT INTO oocq_t (oocqent,oocqstus,oocq001,oocq002,oocq003)
                     VALUES (g_enterprise,'Y','200',g_imcb_m.imcb011,'200')
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET SQLCA.sqlcode = NULL
                  #161013-00017#1 add-E
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                           INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF '200' = g_master_multi_table_t.oocql001 AND
         g_imcb_m.imcb011 = g_master_multi_table_t.oocql002 AND
         g_imcb_m.oocql004 = g_master_multi_table_t.oocql004 AND 
         g_imcb_m.oocql005 = g_master_multi_table_t.oocql005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = '200'
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.oocql001
            LET l_var_keys[03] = g_imcb_m.imcb011
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys_bak[03] = g_master_multi_table_t.oocql002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = g_imcb_m.oocql004
            LET l_fields[01] = 'oocql004'
            LET l_vars[02] = g_imcb_m.oocql005
            LET l_fields[02] = 'oocql005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocql_t')
         END IF 
 
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_imcb_m.imcb011
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aimi101_imcb_t_mask_restore('restore_mask_o')
               
               UPDATE imcb_t SET (imcb011,imcb012,imcb013,imcb014,imcb015,imcb016,imcb017,imcb018,imcbstus, 
                   imcbownid,imcbowndp,imcbcrtid,imcbcrtdp,imcbcrtdt,imcbmodid,imcbmoddt,imcb021,imcb022, 
                   imcb023,imcb024,imcb025,imcb026,imcb027,imcb031,imcb032,imcb033,imcb034) = (g_imcb_m.imcb011, 
                   g_imcb_m.imcb012,g_imcb_m.imcb013,g_imcb_m.imcb014,g_imcb_m.imcb015,g_imcb_m.imcb016, 
                   g_imcb_m.imcb017,g_imcb_m.imcb018,g_imcb_m.imcbstus,g_imcb_m.imcbownid,g_imcb_m.imcbowndp, 
                   g_imcb_m.imcbcrtid,g_imcb_m.imcbcrtdp,g_imcb_m.imcbcrtdt,g_imcb_m.imcbmodid,g_imcb_m.imcbmoddt, 
                   g_imcb_m.imcb021,g_imcb_m.imcb022,g_imcb_m.imcb023,g_imcb_m.imcb024,g_imcb_m.imcb025, 
                   g_imcb_m.imcb026,g_imcb_m.imcb027,g_imcb_m.imcb031,g_imcb_m.imcb032,g_imcb_m.imcb033, 
                   g_imcb_m.imcb034)
                WHERE imcbent = g_enterprise AND imcbsite = g_site AND imcb011 = g_imcb011_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF '200' = g_master_multi_table_t.oocql001 AND
         g_imcb_m.imcb011 = g_master_multi_table_t.oocql002 AND
         g_imcb_m.oocql004 = g_master_multi_table_t.oocql004 AND 
         g_imcb_m.oocql005 = g_master_multi_table_t.oocql005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = '200'
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.oocql001
            LET l_var_keys[03] = g_imcb_m.imcb011
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys_bak[03] = g_master_multi_table_t.oocql002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = g_imcb_m.oocql004
            LET l_fields[01] = 'oocql004'
            LET l_vars[02] = g_imcb_m.oocql005
            LET l_fields[02] = 'oocql005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocql_t')
         END IF 
 
                     
                     #將遮罩欄位進行遮蔽
                     CALL aimi101_imcb_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_imcb_m_t)
                     LET g_log2 = util.JSON.stringify(g_imcb_m)
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
 
{<section id="aimi101.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aimi101_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE imcb_t.imcb011 
   DEFINE l_oldno     LIKE imcb_t.imcb011 
 
   DEFINE l_master    RECORD LIKE imcb_t.* #此變數樣板目前無使用
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
   IF g_imcb_m.imcb011 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_imcb011_t = g_imcb_m.imcb011
 
   
   #清空key值
   LET g_imcb_m.imcb011 = ""
 
    
   CALL aimi101_set_entry("a")
   CALL aimi101_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imcb_m.imcbownid = g_user
      LET g_imcb_m.imcbowndp = g_dept
      LET g_imcb_m.imcbcrtid = g_user
      LET g_imcb_m.imcbcrtdp = g_dept 
      LET g_imcb_m.imcbcrtdt = cl_get_current()
      LET g_imcb_m.imcbmodid = g_user
      LET g_imcb_m.imcbmoddt = cl_get_current()
      LET g_imcb_m.imcbstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #161013-00017#1 marked-S
#   LET g_imcb_m.imcb011_desc = ""
#   DISPLAY BY NAME g_imcb_m.imcb011_desc
   #161013-00017#1 marked-E
   #161013-00017#1 add-S
   LET g_imcb_m.oocql004 = ""
   LET g_imcb_m.oocql005 = ""
   DISPLAY BY NAME g_imcb_m.oocql004
   DISPLAY BY NAME g_imcb_m.oocql005
   #161013-00017#1 add-E
   LET g_imcb_m.imcbstus = "Y"
   CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imcb_m.imcbstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL aimi101_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_imcb_m.* TO NULL
      CALL aimi101_show()
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
      LET g_errparam.extend = "imcb_t:",SQLERRMESSAGE 
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
   CALL aimi101_set_act_visible()
   CALL aimi101_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imcb011_t = g_imcb_m.imcb011
 
   
   #組合新增資料的條件
   LET g_add_browse = " imcbent = " ||g_enterprise|| " AND imcbsite = '" ||g_site|| "' AND",
                      " imcb011 = '", g_imcb_m.imcb011, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimi101_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_imcb_m.imcbownid      
   LET g_data_dept  = g_imcb_m.imcbowndp
              
   #功能已完成,通報訊息中心
   CALL aimi101_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="aimi101.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aimi101_show()
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
   CALL aimi101_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   #161013-00017#1 add-S
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = '200'
   LET g_ref_fields[2] = g_imcb_m.imcb011
   CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
       ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imcb_m.oocql004 = g_rtn_fields[1]
   LET g_imcb_m.oocql005 = g_rtn_fields[2]
   #161013-00017#1 add-E
    
   DISPLAY BY NAME g_imcb_m.oocql004
   DISPLAY BY NAME g_imcb_m.oocql005   
   
            CALL aimi101_imcb017_ref(g_imcb_m.imcb017) RETURNING g_imcb_m.imcb017_desc
            DISPLAY BY NAME g_imcb_m.imcb017_desc
            
            #160617-00004#1--s
            ##add--2015/05/18 By shiun--(S)
            #CALL aimi101_imcb037_ref(g_imcb_m.imcb037) RETURNING g_imcb_m.imcb037_desc
            #DISPLAY BY NAME g_imcb_m.imcb037_desc
            ##add--2015/05/18 By shiun--(E)
            #160617-00004#1--e--
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcb_m.imcbownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imcb_m.imcbownid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcb_m.imcbownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcb_m.imcbowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imcb_m.imcbowndp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcb_m.imcbowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcb_m.imcbcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imcb_m.imcbcrtid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcb_m.imcbcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcb_m.imcbcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imcb_m.imcbcrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcb_m.imcbcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcb_m.imcbmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imcb_m.imcbmodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcb_m.imcbmodid_desc

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imcb_m.imcb011,g_imcb_m.oocql004,g_imcb_m.oocql005,g_imcb_m.imcb012,g_imcb_m.imcb013, 
       g_imcb_m.imcb014,g_imcb_m.imcb015,g_imcb_m.imcb015_desc,g_imcb_m.imcb016,g_imcb_m.imcb016_desc, 
       g_imcb_m.imcb017,g_imcb_m.imcb017_desc,g_imcb_m.imcb018,g_imcb_m.imcbstus,g_imcb_m.imcbownid, 
       g_imcb_m.imcbownid_desc,g_imcb_m.imcbowndp,g_imcb_m.imcbowndp_desc,g_imcb_m.imcbcrtid,g_imcb_m.imcbcrtid_desc, 
       g_imcb_m.imcbcrtdp,g_imcb_m.imcbcrtdp_desc,g_imcb_m.imcbcrtdt,g_imcb_m.imcbmodid,g_imcb_m.imcbmodid_desc, 
       g_imcb_m.imcbmoddt,g_imcb_m.imcb021,g_imcb_m.imcb022,g_imcb_m.imcb023,g_imcb_m.imcb024,g_imcb_m.imcb025, 
       g_imcb_m.imcb026,g_imcb_m.imcb027,g_imcb_m.imcb031,g_imcb_m.imcb032,g_imcb_m.imcb033,g_imcb_m.imcb034 
 
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL aimi101_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imcb_m.imcbstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimi101.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aimi101_delete()
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
   IF g_imcb_m.imcb011 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_imcb011_t = g_imcb_m.imcb011
 
   
   LET g_master_multi_table_t.oocql001 = '200'
LET g_master_multi_table_t.oocql002 = g_imcb_m.imcb011
LET g_master_multi_table_t.oocql004 = g_imcb_m.oocql004
LET g_master_multi_table_t.oocql005 = g_imcb_m.oocql005
 
 
   OPEN aimi101_cl USING g_enterprise, g_site,g_imcb_m.imcb011
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi101_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimi101_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimi101_master_referesh USING g_site,g_imcb_m.imcb011 INTO g_imcb_m.imcb011,g_imcb_m.imcb012, 
       g_imcb_m.imcb013,g_imcb_m.imcb014,g_imcb_m.imcb015,g_imcb_m.imcb016,g_imcb_m.imcb017,g_imcb_m.imcb018, 
       g_imcb_m.imcbstus,g_imcb_m.imcbownid,g_imcb_m.imcbowndp,g_imcb_m.imcbcrtid,g_imcb_m.imcbcrtdp, 
       g_imcb_m.imcbcrtdt,g_imcb_m.imcbmodid,g_imcb_m.imcbmoddt,g_imcb_m.imcb021,g_imcb_m.imcb022,g_imcb_m.imcb023, 
       g_imcb_m.imcb024,g_imcb_m.imcb025,g_imcb_m.imcb026,g_imcb_m.imcb027,g_imcb_m.imcb031,g_imcb_m.imcb032, 
       g_imcb_m.imcb033,g_imcb_m.imcb034,g_imcb_m.imcb015_desc,g_imcb_m.imcb016_desc,g_imcb_m.imcbownid_desc, 
       g_imcb_m.imcbowndp_desc,g_imcb_m.imcbcrtid_desc,g_imcb_m.imcbcrtdp_desc,g_imcb_m.imcbmodid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aimi101_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imcb_m_mask_o.* =  g_imcb_m.*
   CALL aimi101_imcb_t_mask()
   LET g_imcb_m_mask_n.* =  g_imcb_m.*
   
   #將最新資料顯示到畫面上
   CALL aimi101_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aimi101_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM imcb_t 
       WHERE imcbent = g_enterprise AND imcbsite = g_site AND imcb011 = g_imcb_m.imcb011 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      #161013-00017#2 mod-S
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcb_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      #多语言不删除
      {
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'oocqlent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.oocql001
   LET l_field_keys[02] = 'oocql001'
   LET l_var_keys_bak[03] = g_master_multi_table_t.oocql002
   LET l_field_keys[03] = 'oocql002'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'oocql_t')
 
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      }
      #161013-00017#2 mod-E
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imcb_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE aimi101_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL aimi101_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL aimi101_browser_fill(g_wc,"")
         CALL aimi101_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aimi101_cl
 
   #功能已完成,通報訊息中心
   CALL aimi101_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimi101.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aimi101_ui_browser_refresh()
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
      IF g_browser[l_i].b_imcb011 = g_imcb_m.imcb011
 
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
 
{<section id="aimi101.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aimi101_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("imcb011",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL aimi101_imcb012_set()
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   #CALL cl_set_comp_entry("imcb037,imcb038",TRUE)   #add--2015/05/18 By shiun  #160617-00004#1
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aimi101.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aimi101_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imcb011",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL aimi101_imcb012_set()

      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #160617-00004#1--s
   ##add--2015/05/18 By shiun--(S)
   #IF cl_null(g_imcb_m.imcb036) OR g_imcb_m.imcb036 = 'N' THEN
   #   CALL cl_set_comp_entry("imcb037,imcb038",FALSE)
   #   LET g_imcb_m.imcb037 = ''
   #   LET g_imcb_m.imcb037_desc = ''
   #   LET g_imcb_m.imcb038 = ''
   #   DISPLAY BY NAME g_imcb_m.imcb037,g_imcb_m.imcb037_desc,g_imcb_m.imcb038
   #END IF
   ##add--2015/05/18 By shiun--(E)
   #160617-00004#1--e--
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aimi101.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aimi101_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimi101.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aimi101_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimi101.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aimi101_default_search()
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
      LET ls_wc = ls_wc, " imcb011 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc =  " imcb011 = '", g_argv[02], "' AND "
   END IF
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
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc , " AND imcbsite = '", g_argv[01], "' "
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aimi101.mask_functions" >}
&include "erp/aim/aimi101_mask.4gl"
 
{</section>}
 
{<section id="aimi101.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aimi101_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_imcbmoddt DATETIME YEAR TO SECOND
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_imcb_m.imcb011 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aimi101_cl USING g_enterprise, g_site,g_imcb_m.imcb011
   IF STATUS THEN
      CLOSE aimi101_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi101_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aimi101_master_referesh USING g_site,g_imcb_m.imcb011 INTO g_imcb_m.imcb011,g_imcb_m.imcb012, 
       g_imcb_m.imcb013,g_imcb_m.imcb014,g_imcb_m.imcb015,g_imcb_m.imcb016,g_imcb_m.imcb017,g_imcb_m.imcb018, 
       g_imcb_m.imcbstus,g_imcb_m.imcbownid,g_imcb_m.imcbowndp,g_imcb_m.imcbcrtid,g_imcb_m.imcbcrtdp, 
       g_imcb_m.imcbcrtdt,g_imcb_m.imcbmodid,g_imcb_m.imcbmoddt,g_imcb_m.imcb021,g_imcb_m.imcb022,g_imcb_m.imcb023, 
       g_imcb_m.imcb024,g_imcb_m.imcb025,g_imcb_m.imcb026,g_imcb_m.imcb027,g_imcb_m.imcb031,g_imcb_m.imcb032, 
       g_imcb_m.imcb033,g_imcb_m.imcb034,g_imcb_m.imcb015_desc,g_imcb_m.imcb016_desc,g_imcb_m.imcbownid_desc, 
       g_imcb_m.imcbowndp_desc,g_imcb_m.imcbcrtid_desc,g_imcb_m.imcbcrtdp_desc,g_imcb_m.imcbmodid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aimi101_action_chk() THEN
      CLOSE aimi101_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imcb_m.imcb011,g_imcb_m.oocql004,g_imcb_m.oocql005,g_imcb_m.imcb012,g_imcb_m.imcb013, 
       g_imcb_m.imcb014,g_imcb_m.imcb015,g_imcb_m.imcb015_desc,g_imcb_m.imcb016,g_imcb_m.imcb016_desc, 
       g_imcb_m.imcb017,g_imcb_m.imcb017_desc,g_imcb_m.imcb018,g_imcb_m.imcbstus,g_imcb_m.imcbownid, 
       g_imcb_m.imcbownid_desc,g_imcb_m.imcbowndp,g_imcb_m.imcbowndp_desc,g_imcb_m.imcbcrtid,g_imcb_m.imcbcrtid_desc, 
       g_imcb_m.imcbcrtdp,g_imcb_m.imcbcrtdp_desc,g_imcb_m.imcbcrtdt,g_imcb_m.imcbmodid,g_imcb_m.imcbmodid_desc, 
       g_imcb_m.imcbmoddt,g_imcb_m.imcb021,g_imcb_m.imcb022,g_imcb_m.imcb023,g_imcb_m.imcb024,g_imcb_m.imcb025, 
       g_imcb_m.imcb026,g_imcb_m.imcb027,g_imcb_m.imcb031,g_imcb_m.imcb032,g_imcb_m.imcb033,g_imcb_m.imcb034 
 
 
   CASE g_imcb_m.imcbstus
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
         CASE g_imcb_m.imcbstus
            
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
      g_imcb_m.imcbstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aimi101_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_imcbmoddt = cl_get_current()
   UPDATE imcb_t SET imcbstus = lc_state,imcbmodid = g_user,imcbmoddt = l_imcbmoddt 
    WHERE imcbent = g_enterprise AND imcbsite = g_site AND imcb011 = g_imcb_m.imcb011
   LET g_imcb_m.imcbmodid = g_user
   LET g_imcb_m.imcbmoddt = l_imcbmoddt 
   DISPLAY BY NAME g_imcb_m.imcbmodid,g_imcb_m.imcbmoddt  
   #end add-point
   
   LET g_imcb_m.imcbmodid = g_user
   LET g_imcb_m.imcbmoddt = cl_get_current()
   LET g_imcb_m.imcbstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE imcb_t 
      SET (imcbstus,imcbmodid,imcbmoddt) 
        = (g_imcb_m.imcbstus,g_imcb_m.imcbmodid,g_imcb_m.imcbmoddt)     
    WHERE imcbent = g_enterprise AND imcbsite = g_site AND imcb011 = g_imcb_m.imcb011
 
    
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
      EXECUTE aimi101_master_referesh USING g_site,g_imcb_m.imcb011 INTO g_imcb_m.imcb011,g_imcb_m.imcb012, 
          g_imcb_m.imcb013,g_imcb_m.imcb014,g_imcb_m.imcb015,g_imcb_m.imcb016,g_imcb_m.imcb017,g_imcb_m.imcb018, 
          g_imcb_m.imcbstus,g_imcb_m.imcbownid,g_imcb_m.imcbowndp,g_imcb_m.imcbcrtid,g_imcb_m.imcbcrtdp, 
          g_imcb_m.imcbcrtdt,g_imcb_m.imcbmodid,g_imcb_m.imcbmoddt,g_imcb_m.imcb021,g_imcb_m.imcb022, 
          g_imcb_m.imcb023,g_imcb_m.imcb024,g_imcb_m.imcb025,g_imcb_m.imcb026,g_imcb_m.imcb027,g_imcb_m.imcb031, 
          g_imcb_m.imcb032,g_imcb_m.imcb033,g_imcb_m.imcb034,g_imcb_m.imcb015_desc,g_imcb_m.imcb016_desc, 
          g_imcb_m.imcbownid_desc,g_imcb_m.imcbowndp_desc,g_imcb_m.imcbcrtid_desc,g_imcb_m.imcbcrtdp_desc, 
          g_imcb_m.imcbmodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_imcb_m.imcb011,g_imcb_m.oocql004,g_imcb_m.oocql005,g_imcb_m.imcb012,g_imcb_m.imcb013, 
          g_imcb_m.imcb014,g_imcb_m.imcb015,g_imcb_m.imcb015_desc,g_imcb_m.imcb016,g_imcb_m.imcb016_desc, 
          g_imcb_m.imcb017,g_imcb_m.imcb017_desc,g_imcb_m.imcb018,g_imcb_m.imcbstus,g_imcb_m.imcbownid, 
          g_imcb_m.imcbownid_desc,g_imcb_m.imcbowndp,g_imcb_m.imcbowndp_desc,g_imcb_m.imcbcrtid,g_imcb_m.imcbcrtid_desc, 
          g_imcb_m.imcbcrtdp,g_imcb_m.imcbcrtdp_desc,g_imcb_m.imcbcrtdt,g_imcb_m.imcbmodid,g_imcb_m.imcbmodid_desc, 
          g_imcb_m.imcbmoddt,g_imcb_m.imcb021,g_imcb_m.imcb022,g_imcb_m.imcb023,g_imcb_m.imcb024,g_imcb_m.imcb025, 
          g_imcb_m.imcb026,g_imcb_m.imcb027,g_imcb_m.imcb031,g_imcb_m.imcb032,g_imcb_m.imcb033,g_imcb_m.imcb034 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
 
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aimi101_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimi101_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi101.signature" >}
   
 
{</section>}
 
{<section id="aimi101.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aimi101_set_pk_array()
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
   LET g_pk_array[1].values = g_imcb_m.imcb011
   LET g_pk_array[1].column = 'imcb011'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi101.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aimi101.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aimi101_msgcentre_notify(lc_state)
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
   CALL aimi101_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imcb_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi101.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aimi101_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimi101.other_function" readonly="Y" >}

PRIVATE FUNCTION aimi101_imcb011_ref(p_imcb011)
#161013-00017#1 marked-S
DEFINE p_imcb011      LIKE imcb_t.imcb011
#DEFINE r_imcb011_desc LIKE oocql_t.oocql004  
#
#       INITIALIZE g_ref_fields TO NULL
#       LET g_ref_fields[1] = p_imcb011
#       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#       LET r_imcb011_desc = g_rtn_fields[1]
#       RETURN r_imcb011_desc
#161013-00017#1 marked-E
END FUNCTION

PRIVATE FUNCTION aimi101_imcb016_ref(p_imcb016)
DEFINE p_imcb016      LIKE imcb_t.imcb016
DEFINE r_imcb016_desc LIKE oocql_t.oocql004

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imcb016
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='210' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imcb016_desc = g_rtn_fields[1]
      RETURN r_imcb016_desc
END FUNCTION

PRIVATE FUNCTION aimi101_imcb015_ref(p_imcb015)
DEFINE p_imcb015      LIKE imcb_t.imcb015
DEFINE r_imcb015_desc LIKE oocql_t.oocql004  

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_imcb015
       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_imcb015_desc = g_rtn_fields[1]
       RETURN r_imcb015_desc
END FUNCTION

PRIVATE FUNCTION aimi101_imcb012_set()
           IF g_imcb_m.imcb012 = '3' THEN
               CALL cl_set_comp_entry("imcb021,imcb022,imcb023",TRUE)
            ELSE
               CALL cl_set_comp_entry("imcb021,imcb022,imcb023",FALSE)
               LET g_imcb_m.imcb021 = 0
               LET g_imcb_m.imcb022 = 0
               LET g_imcb_m.imcb023 = 0
            END IF
            IF g_imcb_m.imcb012 = '4' THEN
               CALL cl_set_comp_entry("imcb024,imcb025",TRUE)
            ELSE
               CALL cl_set_comp_entry("imcb024,imcb025",FALSE)
               LET g_imcb_m.imcb024 = 0
               LET g_imcb_m.imcb025 = 0
            END IF
END FUNCTION

PRIVATE FUNCTION aimi101_imcb017_ref(p_imcb017)
DEFINE p_imcb017      LIKE imcb_t.imcb017
DEFINE l_ooef019      LIKE ooef_t.ooef019
DEFINE r_imcb017_desc LIKE oodbl_t.oodbl004

       LET l_ooef019 = ''
       SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
       
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_imcb017
       CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001='"||l_ooef019||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_imcb017_desc = g_rtn_fields[1]
       RETURN r_imcb017_desc
       
END FUNCTION

PRIVATE FUNCTION aimi101_imcb037_ref(p_imcb037)
DEFINE p_imcb037      LIKE imcb_t.imcb037
DEFINE r_imcb037_desc LIKE oofgl_t.oofgl004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_imcb037
   CALL ap_ref_array2(g_ref_fields,"SELECT oofgl004 FROM oofgl_t WHERE oofglent='"||g_enterprise||"' AND oofgl001=? AND oofgl002=' ' AND oofgl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_imcb037_desc =  g_rtn_fields[1]
   RETURN r_imcb037_desc
END FUNCTION

 
{</section>}
 
