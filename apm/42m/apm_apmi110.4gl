#該程式未解開Section, 採用最新樣板產出!
{<section id="apmi110.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-06-27 17:46:07), PR版次:0006(2016-09-19 11:16:56)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000237
#+ Filename...: apmi110
#+ Description: 採購控制組供應商預設條件作業
#+ Creator....: 02294(2013-09-11 10:47:50)
#+ Modifier...: 06814 -SD/PR- 02294
 
{</section>}
 
{<section id="apmi110.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...:   No.160318-00025#31   2016/04/11  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160913-00055#4   2016/09/18  By lixiang  供应商栏位开窗调整为q_pmaa001，去掉手动加的限定条件
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
PRIVATE TYPE type_g_pmal_m RECORD
       pmal002 LIKE pmal_t.pmal002, 
   pmal002_desc LIKE type_t.chr80, 
   pmal001 LIKE pmal_t.pmal001, 
   pmal001_desc LIKE type_t.chr80, 
   pmalstus LIKE pmal_t.pmalstus, 
   pmal003 LIKE pmal_t.pmal003, 
   pmal003_desc LIKE type_t.chr80, 
   pmal004 LIKE pmal_t.pmal004, 
   pmal004_desc LIKE type_t.chr80, 
   pmal020 LIKE pmal_t.pmal020, 
   pmal020_desc LIKE type_t.chr80, 
   pmal021 LIKE pmal_t.pmal021, 
   pmal021_desc LIKE type_t.chr80, 
   pmal005 LIKE pmal_t.pmal005, 
   pmal022 LIKE pmal_t.pmal022, 
   pmal022_desc LIKE type_t.chr80, 
   pmal006 LIKE pmal_t.pmal006, 
   pmal006_desc LIKE type_t.chr80, 
   pmal008 LIKE pmal_t.pmal008, 
   pmal008_desc LIKE type_t.chr80, 
   pmal009 LIKE pmal_t.pmal009, 
   pmal009_desc LIKE type_t.chr80, 
   pmal023 LIKE pmal_t.pmal023, 
   pmal024 LIKE pmal_t.pmal024, 
   pmal010 LIKE pmal_t.pmal010, 
   pmal011 LIKE pmal_t.pmal011, 
   pmal011_desc LIKE type_t.chr80, 
   pmal012 LIKE pmal_t.pmal012, 
   pmal012_desc LIKE type_t.chr80, 
   pmal013 LIKE pmal_t.pmal013, 
   pmal013_desc LIKE type_t.chr80, 
   pmal014 LIKE pmal_t.pmal014, 
   pmal014_desc LIKE type_t.chr80, 
   pmal015 LIKE pmal_t.pmal015, 
   pmal016 LIKE pmal_t.pmal016, 
   pmal017 LIKE pmal_t.pmal017, 
   pmal017_desc LIKE type_t.chr80, 
   pmal018 LIKE pmal_t.pmal018, 
   pmal019 LIKE pmal_t.pmal019, 
   pmal019_desc LIKE type_t.chr80, 
   pmal025 LIKE pmal_t.pmal025, 
   pmal025_desc LIKE type_t.chr80, 
   pmalownid LIKE pmal_t.pmalownid, 
   pmalownid_desc LIKE type_t.chr80, 
   pmalowndp LIKE pmal_t.pmalowndp, 
   pmalowndp_desc LIKE type_t.chr80, 
   pmalcrtid LIKE pmal_t.pmalcrtid, 
   pmalcrtid_desc LIKE type_t.chr80, 
   pmalcrtdp LIKE pmal_t.pmalcrtdp, 
   pmalcrtdp_desc LIKE type_t.chr80, 
   pmalcrtdt LIKE pmal_t.pmalcrtdt, 
   pmalmodid LIKE pmal_t.pmalmodid, 
   pmalmodid_desc LIKE type_t.chr80, 
   pmalmoddt LIKE pmal_t.pmalmoddt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_pmal001 LIKE pmal_t.pmal001,
   b_pmal001_desc LIKE type_t.chr80,
   b_pmaal003 LIKE pmaal_t.pmaal003,
      b_pmal002 LIKE pmal_t.pmal002,
   b_pmal002_desc LIKE type_t.chr80
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef019    LIKE ooef_t.ooef019
#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmal_m        type_g_pmal_m  #單頭變數宣告
DEFINE g_pmal_m_t      type_g_pmal_m  #單頭舊值宣告(系統還原用)
DEFINE g_pmal_m_o      type_g_pmal_m  #單頭舊值宣告(其他用途)
DEFINE g_pmal_m_mask_o type_g_pmal_m  #轉換遮罩前資料
DEFINE g_pmal_m_mask_n type_g_pmal_m  #轉換遮罩後資料
 
   DEFINE g_pmal002_t LIKE pmal_t.pmal002
DEFINE g_pmal001_t LIKE pmal_t.pmal001
 
   
 
   
 
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
 
{<section id="apmi110.main" >}
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
   LET g_ooef019 = ''
   SELECT ooef019 INTO g_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pmal002,'',pmal001,'',pmalstus,pmal003,'',pmal004,'',pmal020,'',pmal021, 
       '',pmal005,pmal022,'',pmal006,'',pmal008,'',pmal009,'',pmal023,pmal024,pmal010,pmal011,'',pmal012, 
       '',pmal013,'',pmal014,'',pmal015,pmal016,pmal017,'',pmal018,pmal019,'',pmal025,'',pmalownid,'', 
       pmalowndp,'',pmalcrtid,'',pmalcrtdp,'',pmalcrtdt,pmalmodid,'',pmalmoddt", 
                      " FROM pmal_t",
                      " WHERE pmalent= ? AND pmal001=? AND pmal002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmi110_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmal002,t0.pmal001,t0.pmalstus,t0.pmal003,t0.pmal004,t0.pmal020, 
       t0.pmal021,t0.pmal005,t0.pmal022,t0.pmal006,t0.pmal008,t0.pmal009,t0.pmal023,t0.pmal024,t0.pmal010, 
       t0.pmal011,t0.pmal012,t0.pmal013,t0.pmal014,t0.pmal015,t0.pmal016,t0.pmal017,t0.pmal018,t0.pmal019, 
       t0.pmal025,t0.pmalownid,t0.pmalowndp,t0.pmalcrtid,t0.pmalcrtdp,t0.pmalcrtdt,t0.pmalmodid,t0.pmalmoddt, 
       t1.oohal003 ,t2.pmaal004 ,t3.ooail003 ,t4.oocql004 ,t5.pmaml003 ,t6.isacl004 ,t7.ooibl004 ,t8.oojdl003 , 
       t9.oocql004 ,t10.oocql004 ,t11.oocql004 ,t12.oocql004 ,t13.oocql004 ,t14.pmaal004 ,t15.ooag011 , 
       t16.ooefl003",
               " FROM pmal_t t0",
                              " LEFT JOIN oohal_t t1 ON t1.oohalent="||g_enterprise||" AND t1.oohal001=t0.pmal002 AND t1.oohal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.pmal001 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=t0.pmal003 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='238' AND t4.oocql002=t0.pmal020 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaml_t t5 ON t5.pmamlent="||g_enterprise||" AND t5.pmaml001=t0.pmal021 AND t5.pmaml002='"||g_dlang||"' ",
               " LEFT JOIN isacl_t t6 ON t6.isaclent="||g_enterprise||" AND t6.isacl002=t0.pmal022 AND t6.isacl003='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t7 ON t7.ooiblent="||g_enterprise||" AND t7.ooibl002=t0.pmal006 AND t7.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN oojdl_t t8 ON t8.oojdlent="||g_enterprise||" AND t8.oojdl001=t0.pmal008 AND t8.oojdl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='264' AND t9.oocql002=t0.pmal009 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='263' AND t10.oocql002=t0.pmal011 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t11 ON t11.oocqlent="||g_enterprise||" AND t11.oocql001='262' AND t11.oocql002=t0.pmal012 AND t11.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t12 ON t12.oocqlent="||g_enterprise||" AND t12.oocql001='262' AND t12.oocql002=t0.pmal013 AND t12.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t13 ON t13.oocqlent="||g_enterprise||" AND t13.oocql001='262' AND t13.oocql002=t0.pmal014 AND t13.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t14 ON t14.pmaalent="||g_enterprise||" AND t14.pmaal001=t0.pmal017 AND t14.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.pmal019  ",
               " LEFT JOIN ooefl_t t16 ON t16.ooeflent="||g_enterprise||" AND t16.ooefl001=t0.pmal025 AND t16.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.pmalent = " ||g_enterprise|| " AND t0.pmal001 = ? AND t0.pmal002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmi110_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmi110 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmi110_init()   
 
      #進入選單 Menu (="N")
      CALL apmi110_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmi110
      
   END IF 
   
   CLOSE apmi110_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmi110.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmi110_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('pmalstus','17','N,Y')
 
      CALL cl_set_combo_scc('pmal005','8322') 
   CALL cl_set_combo_scc('pmal023','2087') 
   CALL cl_set_combo_scc('pmal024','2086') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_lang("pmal010")
   #end add-point
   
   #根據外部參數進行搜尋
   CALL apmi110_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="apmi110.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmi110_ui_dialog() 
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
            CALL apmi110_insert()
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
         INITIALIZE g_pmal_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL apmi110_init()
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
               CALL apmi110_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL apmi110_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL apmi110_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL apmi110_set_act_visible()
               CALL apmi110_set_act_no_visible()
               IF NOT (g_pmal_m.pmal001 IS NULL
                 OR g_pmal_m.pmal002 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " pmalent = " ||g_enterprise|| " AND",
                                     " pmal001 = '", g_pmal_m.pmal001, "' "
                                     ," AND pmal002 = '", g_pmal_m.pmal002, "' "
 
                  #填到對應位置
                  CALL apmi110_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL apmi110_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL apmi110_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL apmi110_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL apmi110_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL apmi110_fetch("L")  
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
                  CALL apmi110_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL apmi110_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmi110_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apmi110_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmi110_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmi110_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
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
               CALL apmi110_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmi110_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmi110_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmi110_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmi110_set_pk_array()
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
                  CALL apmi110_fetch("")
 
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
                  CALL apmi110_browser_fill(g_wc,"")
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
                  CALL apmi110_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL apmi110_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL apmi110_set_act_visible()
               CALL apmi110_set_act_no_visible()
               IF NOT (g_pmal_m.pmal001 IS NULL
                 OR g_pmal_m.pmal002 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " pmalent = " ||g_enterprise|| " AND",
                                     " pmal001 = '", g_pmal_m.pmal001, "' "
                                     ," AND pmal002 = '", g_pmal_m.pmal002, "' "
 
                  #填到對應位置
                  CALL apmi110_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL apmi110_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL apmi110_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL apmi110_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL apmi110_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL apmi110_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL apmi110_fetch("L")  
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
                  CALL apmi110_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL apmi110_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmi110_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apmi110_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmi110_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmi110_insert()
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
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apmi110_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmi110_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmi110_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmi110_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmi110_set_pk_array()
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
 
{<section id="apmi110.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION apmi110_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "pmal001,pmal002"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM pmal_t ",
               "  ",
               "  ",
               " WHERE pmalent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("pmal_t")
                
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
      INITIALIZE g_pmal_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.pmalstus,t0.pmal001,t0.pmal002,t1.pmaal004 ,t2.oohal003",
               " FROM pmal_t t0 ",
               "  ",
                              " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.pmal001 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oohal_t t2 ON t2.oohalent="||g_enterprise||" AND t2.oohal001=t0.pmal002 AND t2.oohal002='"||g_dlang||"' ",
 
               " WHERE t0.pmalent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("pmal_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmal_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmal001,g_browser[g_cnt].b_pmal002, 
          g_browser[g_cnt].b_pmal001_desc,g_browser[g_cnt].b_pmal002_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_pmal001
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_pmaal003 = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_pmaal003
         #end add-point
         
         #遮罩相關處理
         CALL apmi110_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_pmal001) THEN
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
 
{<section id="apmi110.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmi110_construct()
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
   INITIALIZE g_pmal_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON pmal002,pmal001,pmalstus,pmal003,pmal004,pmal020,pmal021,pmal005,pmal022, 
          pmal006,pmal008,pmal009,pmal023,pmal024,pmal010,pmal011,pmal012,pmal013,pmal014,pmal015,pmal016, 
          pmal017,pmal018,pmal019,pmal025,pmalownid,pmalowndp,pmalcrtid,pmalcrtdp,pmalcrtdt,pmalmodid, 
          pmalmoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pmalcrtdt>>----
         AFTER FIELD pmalcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pmalmoddt>>----
         AFTER FIELD pmalmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmalcnfdt>>----
         
         #----<<pmalpstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.pmal002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal002
            #add-point:ON ACTION controlp INFIELD pmal002 name="construct.c.pmal002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooha002 = '4' "
            CALL q_ooha001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal002  #顯示到畫面上
            LET g_qryparam.where = " "

            NEXT FIELD pmal002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal002
            #add-point:BEFORE FIELD pmal002 name="construct.b.pmal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal002
            
            #add-point:AFTER FIELD pmal002 name="construct.a.pmal002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal001
            #add-point:ON ACTION controlp INFIELD pmal001 name="construct.c.pmal001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "   #160913-00055#4 
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal001  #顯示到畫面上
            LET g_qryparam.where = " "

            NEXT FIELD pmal001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal001
            #add-point:BEFORE FIELD pmal001 name="construct.b.pmal001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal001
            
            #add-point:AFTER FIELD pmal001 name="construct.a.pmal001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmalstus
            #add-point:BEFORE FIELD pmalstus name="construct.b.pmalstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmalstus
            
            #add-point:AFTER FIELD pmalstus name="construct.a.pmalstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmalstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmalstus
            #add-point:ON ACTION controlp INFIELD pmalstus name="construct.c.pmalstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmal003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal003
            #add-point:ON ACTION controlp INFIELD pmal003 name="construct.c.pmal003"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal003  #顯示到畫面上

            NEXT FIELD pmal003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal003
            #add-point:BEFORE FIELD pmal003 name="construct.b.pmal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal003
            
            #add-point:AFTER FIELD pmal003 name="construct.a.pmal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal004
            #add-point:ON ACTION controlp INFIELD pmal004 name="construct.c.pmal004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oodb002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal004  #顯示到畫面上

            NEXT FIELD pmal004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal004
            #add-point:BEFORE FIELD pmal004 name="construct.b.pmal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal004
            
            #add-point:AFTER FIELD pmal004 name="construct.a.pmal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal020
            #add-point:ON ACTION controlp INFIELD pmal020 name="construct.c.pmal020"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "238"
            LET g_qryparam.where = " oocqstus = 'Y' "
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal020  #顯示到畫面上
            LET g_qryparam.where = " "

            NEXT FIELD pmal020                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal020
            #add-point:BEFORE FIELD pmal020 name="construct.b.pmal020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal020
            
            #add-point:AFTER FIELD pmal020 name="construct.a.pmal020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal021
            #add-point:ON ACTION controlp INFIELD pmal021 name="construct.c.pmal021"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmam001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal021  #顯示到畫面上

            NEXT FIELD pmal021                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal021
            #add-point:BEFORE FIELD pmal021 name="construct.b.pmal021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal021
            
            #add-point:AFTER FIELD pmal021 name="construct.a.pmal021"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal005
            #add-point:BEFORE FIELD pmal005 name="construct.b.pmal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal005
            
            #add-point:AFTER FIELD pmal005 name="construct.a.pmal005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal005
            #add-point:ON ACTION controlp INFIELD pmal005 name="construct.c.pmal005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmal022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal022
            #add-point:ON ACTION controlp INFIELD pmal022 name="construct.c.pmal022"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#給予arg
            LET g_qryparam.arg1 = g_ooef019
            LET g_qryparam.arg2 = "1" 
            CALL q_isac002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal022  #顯示到畫面上

            NEXT FIELD pmal022                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal022
            #add-point:BEFORE FIELD pmal022 name="construct.b.pmal022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal022
            
            #add-point:AFTER FIELD pmal022 name="construct.a.pmal022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal006
            #add-point:ON ACTION controlp INFIELD pmal006 name="construct.c.pmal006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmad002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal006  #顯示到畫面上

            NEXT FIELD pmal006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal006
            #add-point:BEFORE FIELD pmal006 name="construct.b.pmal006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal006
            
            #add-point:AFTER FIELD pmal006 name="construct.a.pmal006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal008
            #add-point:ON ACTION controlp INFIELD pmal008 name="construct.c.pmal008"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   #160621-00003#3 20160627 modify by beckxie---S
			   #LET g_qryparam.arg1 = "275"
            #CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.arg1 = '2'
            CALL q_oojd001_1()
            #160621-00003#3 20160627 modify by beckxie---E
            DISPLAY g_qryparam.return1 TO pmal008  #顯示到畫面上

            NEXT FIELD pmal008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal008
            #add-point:BEFORE FIELD pmal008 name="construct.b.pmal008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal008
            
            #add-point:AFTER FIELD pmal008 name="construct.a.pmal008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal009
            #add-point:ON ACTION controlp INFIELD pmal009 name="construct.c.pmal009"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "264"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal009  #顯示到畫面上
            LET g_qryparam.where = " "

            NEXT FIELD pmal009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal009
            #add-point:BEFORE FIELD pmal009 name="construct.b.pmal009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal009
            
            #add-point:AFTER FIELD pmal009 name="construct.a.pmal009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal023
            #add-point:BEFORE FIELD pmal023 name="construct.b.pmal023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal023
            
            #add-point:AFTER FIELD pmal023 name="construct.a.pmal023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal023
            #add-point:ON ACTION controlp INFIELD pmal023 name="construct.c.pmal023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal024
            #add-point:BEFORE FIELD pmal024 name="construct.b.pmal024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal024
            
            #add-point:AFTER FIELD pmal024 name="construct.a.pmal024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal024
            #add-point:ON ACTION controlp INFIELD pmal024 name="construct.c.pmal024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal010
            #add-point:BEFORE FIELD pmal010 name="construct.b.pmal010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal010
            
            #add-point:AFTER FIELD pmal010 name="construct.a.pmal010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal010
            #add-point:ON ACTION controlp INFIELD pmal010 name="construct.c.pmal010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmal011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal011
            #add-point:ON ACTION controlp INFIELD pmal011 name="construct.c.pmal011"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "263"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal011  #顯示到畫面上
            LET g_qryparam.where = " "

            NEXT FIELD pmal011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal011
            #add-point:BEFORE FIELD pmal011 name="construct.b.pmal011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal011
            
            #add-point:AFTER FIELD pmal011 name="construct.a.pmal011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal012
            #add-point:ON ACTION controlp INFIELD pmal012 name="construct.c.pmal012"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "262"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal012  #顯示到畫面上
            LET g_qryparam.where = " "

            NEXT FIELD pmal012                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal012
            #add-point:BEFORE FIELD pmal012 name="construct.b.pmal012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal012
            
            #add-point:AFTER FIELD pmal012 name="construct.a.pmal012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal013
            #add-point:ON ACTION controlp INFIELD pmal013 name="construct.c.pmal013"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "262"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal013  #顯示到畫面上
            LET g_qryparam.where = " "

            NEXT FIELD pmal013                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal013
            #add-point:BEFORE FIELD pmal013 name="construct.b.pmal013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal013
            
            #add-point:AFTER FIELD pmal013 name="construct.a.pmal013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal014
            #add-point:ON ACTION controlp INFIELD pmal014 name="construct.c.pmal014"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "262"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal014  #顯示到畫面上
            LET g_qryparam.where = " "

            NEXT FIELD pmal014                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal014
            #add-point:BEFORE FIELD pmal014 name="construct.b.pmal014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal014
            
            #add-point:AFTER FIELD pmal014 name="construct.a.pmal014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal015
            #add-point:BEFORE FIELD pmal015 name="construct.b.pmal015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal015
            
            #add-point:AFTER FIELD pmal015 name="construct.a.pmal015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal015
            #add-point:ON ACTION controlp INFIELD pmal015 name="construct.c.pmal015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal016
            #add-point:BEFORE FIELD pmal016 name="construct.b.pmal016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal016
            
            #add-point:AFTER FIELD pmal016 name="construct.a.pmal016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal016
            #add-point:ON ACTION controlp INFIELD pmal016 name="construct.c.pmal016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmal017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal017
            #add-point:ON ACTION controlp INFIELD pmal017 name="construct.c.pmal017"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "
            CALL q_pmaa001_4()                           #呼叫開窗
            LET g_qryparam.where = " "
            DISPLAY g_qryparam.return1 TO pmal017  #顯示到畫面上

            NEXT FIELD pmal017                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal017
            #add-point:BEFORE FIELD pmal017 name="construct.b.pmal017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal017
            
            #add-point:AFTER FIELD pmal017 name="construct.a.pmal017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal018
            #add-point:BEFORE FIELD pmal018 name="construct.b.pmal018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal018
            
            #add-point:AFTER FIELD pmal018 name="construct.a.pmal018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal018
            #add-point:ON ACTION controlp INFIELD pmal018 name="construct.c.pmal018"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmal019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal019
            #add-point:ON ACTION controlp INFIELD pmal019 name="construct.c.pmal019"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal019  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD pmal019                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal019
            #add-point:BEFORE FIELD pmal019 name="construct.b.pmal019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal019
            
            #add-point:AFTER FIELD pmal019 name="construct.a.pmal019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmal025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal025
            #add-point:ON ACTION controlp INFIELD pmal025 name="construct.c.pmal025"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmal025  #顯示到畫面上
            NEXT FIELD pmal025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal025
            #add-point:BEFORE FIELD pmal025 name="construct.b.pmal025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal025
            
            #add-point:AFTER FIELD pmal025 name="construct.a.pmal025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmalownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmalownid
            #add-point:ON ACTION controlp INFIELD pmalownid name="construct.c.pmalownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmalownid  #顯示到畫面上

            NEXT FIELD pmalownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmalownid
            #add-point:BEFORE FIELD pmalownid name="construct.b.pmalownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmalownid
            
            #add-point:AFTER FIELD pmalownid name="construct.a.pmalownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmalowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmalowndp
            #add-point:ON ACTION controlp INFIELD pmalowndp name="construct.c.pmalowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmalowndp  #顯示到畫面上

            NEXT FIELD pmalowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmalowndp
            #add-point:BEFORE FIELD pmalowndp name="construct.b.pmalowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmalowndp
            
            #add-point:AFTER FIELD pmalowndp name="construct.a.pmalowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmalcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmalcrtid
            #add-point:ON ACTION controlp INFIELD pmalcrtid name="construct.c.pmalcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmalcrtid  #顯示到畫面上

            NEXT FIELD pmalcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmalcrtid
            #add-point:BEFORE FIELD pmalcrtid name="construct.b.pmalcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmalcrtid
            
            #add-point:AFTER FIELD pmalcrtid name="construct.a.pmalcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmalcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmalcrtdp
            #add-point:ON ACTION controlp INFIELD pmalcrtdp name="construct.c.pmalcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmalcrtdp  #顯示到畫面上

            NEXT FIELD pmalcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmalcrtdp
            #add-point:BEFORE FIELD pmalcrtdp name="construct.b.pmalcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmalcrtdp
            
            #add-point:AFTER FIELD pmalcrtdp name="construct.a.pmalcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmalcrtdt
            #add-point:BEFORE FIELD pmalcrtdt name="construct.b.pmalcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmalmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmalmodid
            #add-point:ON ACTION controlp INFIELD pmalmodid name="construct.c.pmalmodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmalmodid  #顯示到畫面上

            NEXT FIELD pmalmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmalmodid
            #add-point:BEFORE FIELD pmalmodid name="construct.b.pmalmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmalmodid
            
            #add-point:AFTER FIELD pmalmodid name="construct.a.pmalmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmalmoddt
            #add-point:BEFORE FIELD pmalmoddt name="construct.b.pmalmoddt"
            
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
 
{<section id="apmi110.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION apmi110_filter()
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
      CONSTRUCT g_wc_filter ON pmal001,pmal002
                          FROM s_browse[1].b_pmal001,s_browse[1].b_pmal002
 
         BEFORE CONSTRUCT
               DISPLAY apmi110_filter_parser('pmal001') TO s_browse[1].b_pmal001
            DISPLAY apmi110_filter_parser('pmal002') TO s_browse[1].b_pmal002
      
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
 
      CALL apmi110_filter_show('pmal001')
   CALL apmi110_filter_show('pmal002')
 
END FUNCTION
 
{</section>}
 
{<section id="apmi110.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION apmi110_filter_parser(ps_field)
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
 
{<section id="apmi110.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION apmi110_filter_show(ps_field)
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
   LET ls_condition = apmi110_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmi110.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmi110_query()
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
 
   INITIALIZE g_pmal_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL apmi110_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmi110_browser_fill(g_wc,"F")
      CALL apmi110_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL apmi110_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL apmi110_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="apmi110.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmi110_fetch(p_fl)
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
   LET g_pmal_m.pmal001 = g_browser[g_current_idx].b_pmal001
   LET g_pmal_m.pmal002 = g_browser[g_current_idx].b_pmal002
 
                       
   #讀取單頭所有欄位資料
   EXECUTE apmi110_master_referesh USING g_pmal_m.pmal001,g_pmal_m.pmal002 INTO g_pmal_m.pmal002,g_pmal_m.pmal001, 
       g_pmal_m.pmalstus,g_pmal_m.pmal003,g_pmal_m.pmal004,g_pmal_m.pmal020,g_pmal_m.pmal021,g_pmal_m.pmal005, 
       g_pmal_m.pmal022,g_pmal_m.pmal006,g_pmal_m.pmal008,g_pmal_m.pmal009,g_pmal_m.pmal023,g_pmal_m.pmal024, 
       g_pmal_m.pmal010,g_pmal_m.pmal011,g_pmal_m.pmal012,g_pmal_m.pmal013,g_pmal_m.pmal014,g_pmal_m.pmal015, 
       g_pmal_m.pmal016,g_pmal_m.pmal017,g_pmal_m.pmal018,g_pmal_m.pmal019,g_pmal_m.pmal025,g_pmal_m.pmalownid, 
       g_pmal_m.pmalowndp,g_pmal_m.pmalcrtid,g_pmal_m.pmalcrtdp,g_pmal_m.pmalcrtdt,g_pmal_m.pmalmodid, 
       g_pmal_m.pmalmoddt,g_pmal_m.pmal002_desc,g_pmal_m.pmal001_desc,g_pmal_m.pmal003_desc,g_pmal_m.pmal020_desc, 
       g_pmal_m.pmal021_desc,g_pmal_m.pmal022_desc,g_pmal_m.pmal006_desc,g_pmal_m.pmal008_desc,g_pmal_m.pmal009_desc, 
       g_pmal_m.pmal011_desc,g_pmal_m.pmal012_desc,g_pmal_m.pmal013_desc,g_pmal_m.pmal014_desc,g_pmal_m.pmal017_desc, 
       g_pmal_m.pmal019_desc,g_pmal_m.pmal025_desc
   
   #遮罩相關處理
   LET g_pmal_m_mask_o.* =  g_pmal_m.*
   CALL apmi110_pmal_t_mask()
   LET g_pmal_m_mask_n.* =  g_pmal_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL apmi110_set_act_visible()
   CALL apmi110_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_pmal_m_t.* = g_pmal_m.*
   LET g_pmal_m_o.* = g_pmal_m.*
   
   LET g_data_owner = g_pmal_m.pmalownid      
   LET g_data_dept  = g_pmal_m.pmalowndp
   
   #重新顯示
   CALL apmi110_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="apmi110.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmi110_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_pmal_m.* TO NULL             #DEFAULT 設定
   LET g_pmal001_t = NULL
   LET g_pmal002_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmal_m.pmalownid = g_user
      LET g_pmal_m.pmalowndp = g_dept
      LET g_pmal_m.pmalcrtid = g_user
      LET g_pmal_m.pmalcrtdp = g_dept 
      LET g_pmal_m.pmalcrtdt = cl_get_current()
      LET g_pmal_m.pmalmodid = g_user
      LET g_pmal_m.pmalmoddt = cl_get_current()
      LET g_pmal_m.pmalstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_pmal_m.pmalstus = "Y"
      LET g_pmal_m.pmal005 = "10"
      LET g_pmal_m.pmal023 = "1"
      LET g_pmal_m.pmal024 = "1"
 
 
      #add-point:單頭預設值 name="insert.default"
      INITIALIZE g_pmal_m_t.* TO NULL
      LET g_pmal_m_t.* = g_pmal_m.*
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmal_m.pmalstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL apmi110_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_pmal_m.* TO NULL
         CALL apmi110_show()
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
   CALL apmi110_set_act_visible()
   CALL apmi110_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pmal001_t = g_pmal_m.pmal001
   LET g_pmal002_t = g_pmal_m.pmal002
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmalent = " ||g_enterprise|| " AND",
                      " pmal001 = '", g_pmal_m.pmal001, "' "
                      ," AND pmal002 = '", g_pmal_m.pmal002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmi110_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmi110_master_referesh USING g_pmal_m.pmal001,g_pmal_m.pmal002 INTO g_pmal_m.pmal002,g_pmal_m.pmal001, 
       g_pmal_m.pmalstus,g_pmal_m.pmal003,g_pmal_m.pmal004,g_pmal_m.pmal020,g_pmal_m.pmal021,g_pmal_m.pmal005, 
       g_pmal_m.pmal022,g_pmal_m.pmal006,g_pmal_m.pmal008,g_pmal_m.pmal009,g_pmal_m.pmal023,g_pmal_m.pmal024, 
       g_pmal_m.pmal010,g_pmal_m.pmal011,g_pmal_m.pmal012,g_pmal_m.pmal013,g_pmal_m.pmal014,g_pmal_m.pmal015, 
       g_pmal_m.pmal016,g_pmal_m.pmal017,g_pmal_m.pmal018,g_pmal_m.pmal019,g_pmal_m.pmal025,g_pmal_m.pmalownid, 
       g_pmal_m.pmalowndp,g_pmal_m.pmalcrtid,g_pmal_m.pmalcrtdp,g_pmal_m.pmalcrtdt,g_pmal_m.pmalmodid, 
       g_pmal_m.pmalmoddt,g_pmal_m.pmal002_desc,g_pmal_m.pmal001_desc,g_pmal_m.pmal003_desc,g_pmal_m.pmal020_desc, 
       g_pmal_m.pmal021_desc,g_pmal_m.pmal022_desc,g_pmal_m.pmal006_desc,g_pmal_m.pmal008_desc,g_pmal_m.pmal009_desc, 
       g_pmal_m.pmal011_desc,g_pmal_m.pmal012_desc,g_pmal_m.pmal013_desc,g_pmal_m.pmal014_desc,g_pmal_m.pmal017_desc, 
       g_pmal_m.pmal019_desc,g_pmal_m.pmal025_desc
   
   
   #遮罩相關處理
   LET g_pmal_m_mask_o.* =  g_pmal_m.*
   CALL apmi110_pmal_t_mask()
   LET g_pmal_m_mask_n.* =  g_pmal_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmal_m.pmal002,g_pmal_m.pmal002_desc,g_pmal_m.pmal001,g_pmal_m.pmal001_desc,g_pmal_m.pmalstus, 
       g_pmal_m.pmal003,g_pmal_m.pmal003_desc,g_pmal_m.pmal004,g_pmal_m.pmal004_desc,g_pmal_m.pmal020, 
       g_pmal_m.pmal020_desc,g_pmal_m.pmal021,g_pmal_m.pmal021_desc,g_pmal_m.pmal005,g_pmal_m.pmal022, 
       g_pmal_m.pmal022_desc,g_pmal_m.pmal006,g_pmal_m.pmal006_desc,g_pmal_m.pmal008,g_pmal_m.pmal008_desc, 
       g_pmal_m.pmal009,g_pmal_m.pmal009_desc,g_pmal_m.pmal023,g_pmal_m.pmal024,g_pmal_m.pmal010,g_pmal_m.pmal011, 
       g_pmal_m.pmal011_desc,g_pmal_m.pmal012,g_pmal_m.pmal012_desc,g_pmal_m.pmal013,g_pmal_m.pmal013_desc, 
       g_pmal_m.pmal014,g_pmal_m.pmal014_desc,g_pmal_m.pmal015,g_pmal_m.pmal016,g_pmal_m.pmal017,g_pmal_m.pmal017_desc, 
       g_pmal_m.pmal018,g_pmal_m.pmal019,g_pmal_m.pmal019_desc,g_pmal_m.pmal025,g_pmal_m.pmal025_desc, 
       g_pmal_m.pmalownid,g_pmal_m.pmalownid_desc,g_pmal_m.pmalowndp,g_pmal_m.pmalowndp_desc,g_pmal_m.pmalcrtid, 
       g_pmal_m.pmalcrtid_desc,g_pmal_m.pmalcrtdp,g_pmal_m.pmalcrtdp_desc,g_pmal_m.pmalcrtdt,g_pmal_m.pmalmodid, 
       g_pmal_m.pmalmodid_desc,g_pmal_m.pmalmoddt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_pmal_m.pmalownid      
   LET g_data_dept  = g_pmal_m.pmalowndp
 
   #功能已完成,通報訊息中心
   CALL apmi110_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmi110.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmi110_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_pmal_m.pmal001 IS NULL
 
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
   LET g_pmal001_t = g_pmal_m.pmal001
   LET g_pmal002_t = g_pmal_m.pmal002
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN apmi110_cl USING g_enterprise,g_pmal_m.pmal001,g_pmal_m.pmal002
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmi110_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE apmi110_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmi110_master_referesh USING g_pmal_m.pmal001,g_pmal_m.pmal002 INTO g_pmal_m.pmal002,g_pmal_m.pmal001, 
       g_pmal_m.pmalstus,g_pmal_m.pmal003,g_pmal_m.pmal004,g_pmal_m.pmal020,g_pmal_m.pmal021,g_pmal_m.pmal005, 
       g_pmal_m.pmal022,g_pmal_m.pmal006,g_pmal_m.pmal008,g_pmal_m.pmal009,g_pmal_m.pmal023,g_pmal_m.pmal024, 
       g_pmal_m.pmal010,g_pmal_m.pmal011,g_pmal_m.pmal012,g_pmal_m.pmal013,g_pmal_m.pmal014,g_pmal_m.pmal015, 
       g_pmal_m.pmal016,g_pmal_m.pmal017,g_pmal_m.pmal018,g_pmal_m.pmal019,g_pmal_m.pmal025,g_pmal_m.pmalownid, 
       g_pmal_m.pmalowndp,g_pmal_m.pmalcrtid,g_pmal_m.pmalcrtdp,g_pmal_m.pmalcrtdt,g_pmal_m.pmalmodid, 
       g_pmal_m.pmalmoddt,g_pmal_m.pmal002_desc,g_pmal_m.pmal001_desc,g_pmal_m.pmal003_desc,g_pmal_m.pmal020_desc, 
       g_pmal_m.pmal021_desc,g_pmal_m.pmal022_desc,g_pmal_m.pmal006_desc,g_pmal_m.pmal008_desc,g_pmal_m.pmal009_desc, 
       g_pmal_m.pmal011_desc,g_pmal_m.pmal012_desc,g_pmal_m.pmal013_desc,g_pmal_m.pmal014_desc,g_pmal_m.pmal017_desc, 
       g_pmal_m.pmal019_desc,g_pmal_m.pmal025_desc
 
   #檢查是否允許此動作
   IF NOT apmi110_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_pmal_m_mask_o.* =  g_pmal_m.*
   CALL apmi110_pmal_t_mask()
   LET g_pmal_m_mask_n.* =  g_pmal_m.*
   
   
 
   #顯示資料
   CALL apmi110_show()
   
   WHILE TRUE
      LET g_pmal_m.pmal001 = g_pmal001_t
      LET g_pmal_m.pmal002 = g_pmal002_t
 
      
      #寫入修改者/修改日期資訊
      LET g_pmal_m.pmalmodid = g_user 
LET g_pmal_m.pmalmoddt = cl_get_current()
LET g_pmal_m.pmalmodid_desc = cl_get_username(g_pmal_m.pmalmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL apmi110_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pmal_m.* = g_pmal_m_t.*
         CALL apmi110_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE pmal_t SET (pmalmodid,pmalmoddt) = (g_pmal_m.pmalmodid,g_pmal_m.pmalmoddt)
       WHERE pmalent = g_enterprise AND pmal001 = g_pmal001_t
         AND pmal002 = g_pmal002_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL apmi110_set_act_visible()
   CALL apmi110_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmalent = " ||g_enterprise|| " AND",
                      " pmal001 = '", g_pmal_m.pmal001, "' "
                      ," AND pmal002 = '", g_pmal_m.pmal002, "' "
 
   #填到對應位置
   CALL apmi110_browser_fill(g_wc,"")
 
   CLOSE apmi110_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmi110_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="apmi110.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmi110_input(p_cmd)
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
   DEFINE l_msg2          LIKE gzze_t.gzze003   #160621-00003#3 20160629 add by beckxie
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   #160621-00003#3 20160629 add by beckxie---S
   LET l_msg2 = ''
   SELECT gzze003 INTO l_msg2 FROM gzze_t WHERE gzze001 = 'aoo-00309' AND gzze002 = g_dlang
   #160621-00003#3 20160629 add by beckxie---E
   #end add-point
   
   #切換至輸入畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmal_m.pmal002,g_pmal_m.pmal002_desc,g_pmal_m.pmal001,g_pmal_m.pmal001_desc,g_pmal_m.pmalstus, 
       g_pmal_m.pmal003,g_pmal_m.pmal003_desc,g_pmal_m.pmal004,g_pmal_m.pmal004_desc,g_pmal_m.pmal020, 
       g_pmal_m.pmal020_desc,g_pmal_m.pmal021,g_pmal_m.pmal021_desc,g_pmal_m.pmal005,g_pmal_m.pmal022, 
       g_pmal_m.pmal022_desc,g_pmal_m.pmal006,g_pmal_m.pmal006_desc,g_pmal_m.pmal008,g_pmal_m.pmal008_desc, 
       g_pmal_m.pmal009,g_pmal_m.pmal009_desc,g_pmal_m.pmal023,g_pmal_m.pmal024,g_pmal_m.pmal010,g_pmal_m.pmal011, 
       g_pmal_m.pmal011_desc,g_pmal_m.pmal012,g_pmal_m.pmal012_desc,g_pmal_m.pmal013,g_pmal_m.pmal013_desc, 
       g_pmal_m.pmal014,g_pmal_m.pmal014_desc,g_pmal_m.pmal015,g_pmal_m.pmal016,g_pmal_m.pmal017,g_pmal_m.pmal017_desc, 
       g_pmal_m.pmal018,g_pmal_m.pmal019,g_pmal_m.pmal019_desc,g_pmal_m.pmal025,g_pmal_m.pmal025_desc, 
       g_pmal_m.pmalownid,g_pmal_m.pmalownid_desc,g_pmal_m.pmalowndp,g_pmal_m.pmalowndp_desc,g_pmal_m.pmalcrtid, 
       g_pmal_m.pmalcrtid_desc,g_pmal_m.pmalcrtdp,g_pmal_m.pmalcrtdp_desc,g_pmal_m.pmalcrtdt,g_pmal_m.pmalmodid, 
       g_pmal_m.pmalmodid_desc,g_pmal_m.pmalmoddt
   
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
   CALL apmi110_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apmi110_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_pmal_m.pmal002,g_pmal_m.pmal001,g_pmal_m.pmalstus,g_pmal_m.pmal003,g_pmal_m.pmal004, 
          g_pmal_m.pmal020,g_pmal_m.pmal021,g_pmal_m.pmal005,g_pmal_m.pmal022,g_pmal_m.pmal006,g_pmal_m.pmal008, 
          g_pmal_m.pmal009,g_pmal_m.pmal023,g_pmal_m.pmal024,g_pmal_m.pmal010,g_pmal_m.pmal011,g_pmal_m.pmal012, 
          g_pmal_m.pmal013,g_pmal_m.pmal014,g_pmal_m.pmal015,g_pmal_m.pmal016,g_pmal_m.pmal017,g_pmal_m.pmal018, 
          g_pmal_m.pmal019,g_pmal_m.pmal025 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal002
            
            #add-point:AFTER FIELD pmal002 name="input.a.pmal002"
            #此段落由子樣板a05產生
            CALL apmi110_pmal002_ref(g_pmal_m.pmal002) RETURNING g_pmal_m.pmal002_desc
            DISPLAY BY NAME g_pmal_m.pmal002_desc

            IF  NOT cl_null(g_pmal_m.pmal002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_pmal_m.pmal002 != g_pmal_m_t.pmal002 ))) THEN 
                  IF NOT cl_null(g_pmal_m.pmal001) THEN
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmal_t WHERE "||"pmalent = '" ||g_enterprise|| "' AND "||"pmal001 = '"||g_pmal_m.pmal001 ||"' AND "|| "pmal002 = '"||g_pmal_m.pmal002 ||"'",'std-00004',0) THEN 
                        LET g_pmal_m.pmal002 = g_pmal_m_t.pmal002
                        CALL apmi110_pmal002_ref(g_pmal_m.pmal002) RETURNING g_pmal_m.pmal002_desc
                        DISPLAY BY NAME g_pmal_m.pmal002_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  IF NOT apmi110_pmal002_chk(g_pmal_m.pmal002) THEN
                     LET g_pmal_m.pmal002 = g_pmal_m_t.pmal002
                     CALL apmi110_pmal002_ref(g_pmal_m.pmal002) RETURNING g_pmal_m.pmal002_desc
                     DISPLAY BY NAME g_pmal_m.pmal002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal002
            #add-point:BEFORE FIELD pmal002 name="input.b.pmal002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal002
            #add-point:ON CHANGE pmal002 name="input.g.pmal002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal001
            
            #add-point:AFTER FIELD pmal001 name="input.a.pmal001"
            #此段落由子樣板a05產生
            CALL apmi110_pmal001_ref(g_pmal_m.pmal001) RETURNING g_pmal_m.pmal001_desc
            DISPLAY BY NAME g_pmal_m.pmal001_desc
            
            IF  NOT cl_null(g_pmal_m.pmal001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_pmal_m.pmal001 != g_pmal_m_t.pmal001 ))) THEN 
                  IF NOT cl_null(g_pmal_m.pmal002) THEN
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmal_t WHERE "||"pmalent = '" ||g_enterprise|| "' AND "||"pmal001 = '"||g_pmal_m.pmal001 ||"' AND "|| "pmal002 = '"||g_pmal_m.pmal002 ||"'",'std-00004',0) THEN 
                        LET g_pmal_m.pmal001 = g_pmal_m_t.pmal001
                        CALL apmi110_pmal001_ref(g_pmal_m.pmal001) RETURNING g_pmal_m.pmal001_desc
                        DISPLAY BY NAME g_pmal_m.pmal001_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  IF NOT apmi110_pmal001_chk(g_pmal_m.pmal001) THEN
                     LET g_pmal_m.pmal001 = g_pmal_m_t.pmal001
                     CALL apmi110_pmal001_ref(g_pmal_m.pmal001) RETURNING g_pmal_m.pmal001_desc
                     DISPLAY BY NAME g_pmal_m.pmal001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal001
            #add-point:BEFORE FIELD pmal001 name="input.b.pmal001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal001
            #add-point:ON CHANGE pmal001 name="input.g.pmal001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmalstus
            #add-point:BEFORE FIELD pmalstus name="input.b.pmalstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmalstus
            
            #add-point:AFTER FIELD pmalstus name="input.a.pmalstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmalstus
            #add-point:ON CHANGE pmalstus name="input.g.pmalstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal003
            
            #add-point:AFTER FIELD pmal003 name="input.a.pmal003"
            CALL apmi110_pmal003_ref(g_pmal_m.pmal003) RETURNING g_pmal_m.pmal003_desc
            DISPLAY BY NAME g_pmal_m.pmal003_desc
            
            IF  NOT cl_null(g_pmal_m.pmal003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmal_m.pmal003 != g_pmal_m_t.pmal003 OR cl_null(g_pmal_m_t.pmal003))) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_pmal_m.pmal003
                  LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"  #160318-00025#31  add
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     LET g_pmal_m.pmal003 = g_pmal_m_t.pmal003
                     CALL apmi110_pmal003_ref(g_pmal_m.pmal003) RETURNING g_pmal_m.pmal003_desc
                     DISPLAY BY NAME g_pmal_m.pmal003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal003
            #add-point:BEFORE FIELD pmal003 name="input.b.pmal003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal003
            #add-point:ON CHANGE pmal003 name="input.g.pmal003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal004
            
            #add-point:AFTER FIELD pmal004 name="input.a.pmal004"
            CALL apmi110_pmal004_ref(g_pmal_m.pmal004) RETURNING g_pmal_m.pmal004_desc
            DISPLAY BY NAME g_pmal_m.pmal004_desc
            IF NOT cl_null(g_pmal_m.pmal004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_pmal_m.pmal004
               LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"  #160318-00025#31  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_oodb002") THEN
                  LET g_pmal_m.pmal004 = g_pmal_m_t.pmal004
                  CALL apmi110_pmal004_ref(g_pmal_m.pmal004) RETURNING g_pmal_m.pmal004_desc
                  DISPLAY BY NAME g_pmal_m.pmal004_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal004
            #add-point:BEFORE FIELD pmal004 name="input.b.pmal004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal004
            #add-point:ON CHANGE pmal004 name="input.g.pmal004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal020
            
            #add-point:AFTER FIELD pmal020 name="input.a.pmal020"
            CALL apmi110_pmal020_ref(g_pmal_m.pmal020) RETURNING g_pmal_m.pmal020_desc
            DISPLAY BY NAME g_pmal_m.pmal020_desc
            
            IF  NOT cl_null(g_pmal_m.pmal020) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmal_m.pmal020 != g_pmal_m_t.pmal020 OR cl_null(g_pmal_m_t.pmal020))) THEN 
                  IF NOT s_azzi650_chk_exist('238',g_pmal_m.pmal020) THEN
                     LET g_pmal_m.pmal020 = g_pmal_m_t.pmal020
                     CALL apmi110_pmal020_ref(g_pmal_m.pmal020) RETURNING g_pmal_m.pmal020_desc
                     DISPLAY BY NAME g_pmal_m.pmal020_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal020
            #add-point:BEFORE FIELD pmal020 name="input.b.pmal020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal020
            #add-point:ON CHANGE pmal020 name="input.g.pmal020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal021
            
            #add-point:AFTER FIELD pmal021 name="input.a.pmal021"
            CALL apmi110_pmal021_ref(g_pmal_m.pmal021) RETURNING g_pmal_m.pmal021_desc
            DISPLAY BY NAME g_pmal_m.pmal021_desc
            IF NOT cl_null(g_pmal_m.pmal021) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmal_m.pmal021
               LET g_chkparam.err_str[1] = "apm-00210:sub-01302|apmi130|",cl_get_progname("apmi130",g_lang,"2"),"|:EXEPROGapmi130"  #160318-00025#31  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pmam001") THEN
                  LET g_pmal_m.pmal021 = g_pmal_m_t.pmal021
                  CALL apmi110_pmal021_ref(g_pmal_m.pmal021) RETURNING g_pmal_m.pmal021_desc
                  DISPLAY BY NAME g_pmal_m.pmal021_desc 
                  NEXT FIELD CURRENT
               END IF
            END IF 
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal021
            #add-point:BEFORE FIELD pmal021 name="input.b.pmal021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal021
            #add-point:ON CHANGE pmal021 name="input.g.pmal021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal005
            #add-point:BEFORE FIELD pmal005 name="input.b.pmal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal005
            
            #add-point:AFTER FIELD pmal005 name="input.a.pmal005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal005
            #add-point:ON CHANGE pmal005 name="input.g.pmal005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal022
            
            #add-point:AFTER FIELD pmal022 name="input.a.pmal022"
            CALL apmi110_pmal022_ref(g_pmal_m.pmal022) RETURNING g_pmal_m.pmal022_desc
            DISPLAY BY NAME g_pmal_m.pmal022_desc
            IF NOT cl_null(g_pmal_m.pmal022) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooef019
               LET g_chkparam.arg2 = g_pmal_m.pmal022

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_isac002_1") THEN
                  LET g_pmal_m.pmal022 = g_pmal_m_t.pmal022
                  CALL apmi110_pmal022_ref(g_pmal_m.pmal022) RETURNING g_pmal_m.pmal022_desc
                  DISPLAY BY NAME g_pmal_m.pmal022_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal022
            #add-point:BEFORE FIELD pmal022 name="input.b.pmal022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal022
            #add-point:ON CHANGE pmal022 name="input.g.pmal022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal006
            
            #add-point:AFTER FIELD pmal006 name="input.a.pmal006"
            CALL apmi110_pmal006_ref(g_pmal_m.pmal006) RETURNING g_pmal_m.pmal006_desc
            DISPLAY BY NAME g_pmal_m.pmal006_desc
            IF NOT cl_null(g_pmal_m.pmal006) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmal_m.pmal001
               LET g_chkparam.arg2 = g_pmal_m.pmal006

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pmad002_1") THEN
                  LET g_pmal_m.pmal006 = g_pmal_m_t.pmal006
                  CALL apmi110_pmal006_ref(g_pmal_m.pmal006) RETURNING g_pmal_m.pmal006_desc
                  DISPLAY BY NAME g_pmal_m.pmal006_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal006
            #add-point:BEFORE FIELD pmal006 name="input.b.pmal006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal006
            #add-point:ON CHANGE pmal006 name="input.g.pmal006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal008
            
            #add-point:AFTER FIELD pmal008 name="input.a.pmal008"
            CALL apmi110_pmal008_ref(g_pmal_m.pmal008) RETURNING g_pmal_m.pmal008_desc
            DISPLAY BY NAME g_pmal_m.pmal008_desc
            
            IF NOT cl_null(g_pmal_m.pmal008) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmal_m.pmal008 != g_pmal_m_t.pmal008 OR cl_null(g_pmal_m_t.pmal008))) THEN 
                  #160621-00003#3 20160627 modify by beckxie---S
                  #IF NOT s_azzi650_chk_exist('275',g_pmal_m.pmal008) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmal_m.pmal008
                  LET g_chkparam.arg2 = '2'
                  LET g_chkparam.err_str[1] = "aoo-00299|",l_msg2
                  IF NOT cl_chk_exist("v_oojd001") THEN
                  #160621-00003#3 20160627 modify by beckxie---E
                     LET g_pmal_m.pmal008 = g_pmal_m_t.pmal008
                     CALL apmi110_pmal008_ref(g_pmal_m.pmal008) RETURNING g_pmal_m.pmal008_desc
                     DISPLAY BY NAME g_pmal_m.pmal008_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal008
            #add-point:BEFORE FIELD pmal008 name="input.b.pmal008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal008
            #add-point:ON CHANGE pmal008 name="input.g.pmal008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal009
            
            #add-point:AFTER FIELD pmal009 name="input.a.pmal009"
            CALL apmi110_pmal009_ref(g_pmal_m.pmal009) RETURNING g_pmal_m.pmal009_desc
            DISPLAY BY NAME g_pmal_m.pmal009_desc
            
            IF  NOT cl_null(g_pmal_m.pmal009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmal_m.pmal009 != g_pmal_m_t.pmal009 OR cl_null(g_pmal_m_t.pmal009))) THEN 
                  IF NOT s_azzi650_chk_exist('264',g_pmal_m.pmal009) THEN
                     LET g_pmal_m.pmal009 = g_pmal_m_t.pmal009
                     CALL apmi110_pmal009_ref(g_pmal_m.pmal009) RETURNING g_pmal_m.pmal009_desc
                     DISPLAY BY NAME g_pmal_m.pmal009_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal009
            #add-point:BEFORE FIELD pmal009 name="input.b.pmal009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal009
            #add-point:ON CHANGE pmal009 name="input.g.pmal009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal023
            #add-point:BEFORE FIELD pmal023 name="input.b.pmal023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal023
            
            #add-point:AFTER FIELD pmal023 name="input.a.pmal023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal023
            #add-point:ON CHANGE pmal023 name="input.g.pmal023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal024
            #add-point:BEFORE FIELD pmal024 name="input.b.pmal024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal024
            
            #add-point:AFTER FIELD pmal024 name="input.a.pmal024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal024
            #add-point:ON CHANGE pmal024 name="input.g.pmal024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal010
            #add-point:BEFORE FIELD pmal010 name="input.b.pmal010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal010
            
            #add-point:AFTER FIELD pmal010 name="input.a.pmal010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal010
            #add-point:ON CHANGE pmal010 name="input.g.pmal010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal011
            
            #add-point:AFTER FIELD pmal011 name="input.a.pmal011"
            CALL apmi110_pmal011_ref(g_pmal_m.pmal011) RETURNING g_pmal_m.pmal011_desc
            DISPLAY BY NAME g_pmal_m.pmal011_desc
            
            IF  NOT cl_null(g_pmal_m.pmal011) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmal_m.pmal011 != g_pmal_m_t.pmal011 OR cl_null(g_pmal_m_t.pmal011))) THEN 
                  IF NOT s_azzi650_chk_exist('263',g_pmal_m.pmal011) THEN
                     LET g_pmal_m.pmal011 = g_pmal_m_t.pmal011
                     CALL apmi110_pmal011_ref(g_pmal_m.pmal011) RETURNING g_pmal_m.pmal011_desc
                     DISPLAY BY NAME g_pmal_m.pmal011_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal011
            #add-point:BEFORE FIELD pmal011 name="input.b.pmal011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal011
            #add-point:ON CHANGE pmal011 name="input.g.pmal011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal012
            
            #add-point:AFTER FIELD pmal012 name="input.a.pmal012"
            CALL apmi110_pmal012_ref(g_pmal_m.pmal012) RETURNING g_pmal_m.pmal012_desc
            DISPLAY BY NAME g_pmal_m.pmal012_desc
            
            IF  NOT cl_null(g_pmal_m.pmal012) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmal_m.pmal012 != g_pmal_m_t.pmal012 OR cl_null(g_pmal_m_t.pmal012))) THEN 
                  IF NOT apmi110_pmal012_chk(g_pmal_m.pmal012) THEN
                     LET g_pmal_m.pmal012 = g_pmal_m_t.pmal012
                     CALL apmi110_pmal012_ref(g_pmal_m.pmal012) RETURNING g_pmal_m.pmal012_desc
                     DISPLAY BY NAME g_pmal_m.pmal012_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal012
            #add-point:BEFORE FIELD pmal012 name="input.b.pmal012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal012
            #add-point:ON CHANGE pmal012 name="input.g.pmal012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal013
            
            #add-point:AFTER FIELD pmal013 name="input.a.pmal013"
            CALL apmi110_pmal012_ref(g_pmal_m.pmal013) RETURNING g_pmal_m.pmal013_desc
            DISPLAY BY NAME g_pmal_m.pmal013_desc
            
            IF  NOT cl_null(g_pmal_m.pmal013) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmal_m.pmal013 != g_pmal_m_t.pmal013 OR cl_null(g_pmal_m_t.pmal013))) THEN 
                  IF NOT apmi110_pmal012_chk(g_pmal_m.pmal013) THEN
                     LET g_pmal_m.pmal013 = g_pmal_m_t.pmal013
                     CALL apmi110_pmal012_ref(g_pmal_m.pmal013) RETURNING g_pmal_m.pmal013_desc
                     DISPLAY BY NAME g_pmal_m.pmal013_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal013
            #add-point:BEFORE FIELD pmal013 name="input.b.pmal013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal013
            #add-point:ON CHANGE pmal013 name="input.g.pmal013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal014
            
            #add-point:AFTER FIELD pmal014 name="input.a.pmal014"
            CALL apmi110_pmal012_ref(g_pmal_m.pmal014) RETURNING g_pmal_m.pmal014_desc
            DISPLAY BY NAME g_pmal_m.pmal014_desc
            
            IF  NOT cl_null(g_pmal_m.pmal014) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmal_m.pmal014 != g_pmal_m_t.pmal014 OR cl_null(g_pmal_m_t.pmal014))) THEN 
                  IF NOT apmi110_pmal012_chk(g_pmal_m.pmal014) THEN
                     LET g_pmal_m.pmal014 = g_pmal_m_t.pmal014
                     CALL apmi110_pmal012_ref(g_pmal_m.pmal014) RETURNING g_pmal_m.pmal014_desc
                     DISPLAY BY NAME g_pmal_m.pmal014_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal014
            #add-point:BEFORE FIELD pmal014 name="input.b.pmal014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal014
            #add-point:ON CHANGE pmal014 name="input.g.pmal014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmal_m.pmal015,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmal015
            END IF 
 
 
 
            #add-point:AFTER FIELD pmal015 name="input.a.pmal015"
            IF NOT cl_null(g_pmal_m.pmal015) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal015
            #add-point:BEFORE FIELD pmal015 name="input.b.pmal015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal015
            #add-point:ON CHANGE pmal015 name="input.g.pmal015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmal_m.pmal016,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmal016
            END IF 
 
 
 
            #add-point:AFTER FIELD pmal016 name="input.a.pmal016"
            IF NOT cl_null(g_pmal_m.pmal016) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal016
            #add-point:BEFORE FIELD pmal016 name="input.b.pmal016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal016
            #add-point:ON CHANGE pmal016 name="input.g.pmal016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal017
            
            #add-point:AFTER FIELD pmal017 name="input.a.pmal017"
            CALL apmi110_pmal001_ref(g_pmal_m.pmal017) RETURNING g_pmal_m.pmal017_desc
            DISPLAY BY NAME g_pmal_m.pmal017_desc
            
            IF NOT cl_null(g_pmal_m.pmal017) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmal_m.pmal017 != g_pmal_m_t.pmal017 OR cl_null(g_pmal_m_t.pmal017))) THEN 
                  IF NOT apmi110_pmal001_chk(g_pmal_m.pmal017) THEN
                     LET g_pmal_m.pmal017 = g_pmal_m_t.pmal017
                     CALL apmi110_pmal001_ref(g_pmal_m.pmal017) RETURNING g_pmal_m.pmal017_desc
                     DISPLAY BY NAME g_pmal_m.pmal017_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal017
            #add-point:BEFORE FIELD pmal017 name="input.b.pmal017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal017
            #add-point:ON CHANGE pmal017 name="input.g.pmal017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal018
            #add-point:BEFORE FIELD pmal018 name="input.b.pmal018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal018
            
            #add-point:AFTER FIELD pmal018 name="input.a.pmal018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal018
            #add-point:ON CHANGE pmal018 name="input.g.pmal018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal019
            
            #add-point:AFTER FIELD pmal019 name="input.a.pmal019"
            CALL apmi110_pmal019_ref(g_pmal_m.pmal019) RETURNING g_pmal_m.pmal019_desc
            DISPLAY BY NAME g_pmal_m.pmal019_desc
            
            IF  NOT cl_null(g_pmal_m.pmal019) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmal_m.pmal019 != g_pmal_m_t.pmal019 OR cl_null(g_pmal_m_t.pmal019))) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmal_m.pmal019
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#31  add
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     LET g_pmal_m.pmal019 = g_pmal_m_t.pmal019
                     CALL apmi110_pmal019_ref(g_pmal_m.pmal019) RETURNING g_pmal_m.pmal019_desc
                     DISPLAY BY NAME g_pmal_m.pmal019_desc 
                     NEXT FIELD CURRENT
                  END IF
                  
                  #帶出歸屬部門ooag003
                  SELECT ooag003 INTO g_pmal_m.pmal025
                    FROM ooag_t
                   WHERE ooagent = g_enterprise
                     AND ooag001 = g_pmal_m.pmal019
               
                  LET g_pmal_m_o.pmal025 = g_pmal_m.pmal025
                  DISPLAY BY NAME g_pmal_m.pmal025

                  CALL s_desc_get_department_desc(g_pmal_m.pmal025) RETURNING g_pmal_m.pmal025_desc
                  DISPLAY BY NAME g_pmal_m.pmal025_desc
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal019
            #add-point:BEFORE FIELD pmal019 name="input.b.pmal019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal019
            #add-point:ON CHANGE pmal019 name="input.g.pmal019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmal025
            
            #add-point:AFTER FIELD pmal025 name="input.a.pmal025"
            CALL s_desc_get_department_desc(g_pmal_m.pmal025) RETURNING g_pmal_m.pmal025_desc
            DISPLAY BY NAME g_pmal_m.pmal025_desc
   
            IF NOT cl_null(g_pmal_m.pmal025) THEN 
               IF g_pmal_m.pmal025 <> g_pmal_m_o.pmal025 OR cl_null(g_pmal_m_o.pmal025) THEN
                  
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmal_m.pmal025
                  LET g_chkparam.arg2 = g_today
                  LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#31  add
                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_pmal_m.pmal025 = g_pmal_m_o.pmal025
                     
                     CALL s_desc_get_department_desc(g_pmal_m.pmal025) RETURNING g_pmal_m.pmal025_desc
                     DISPLAY BY NAME g_pmal_m.pmal025_desc                    
   
                     NEXT FIELD CURRENT
                  END IF               
               END IF
            END IF 
            
            LET g_pmal_m_o.pmal025 = g_pmal_m.pmal025


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmal025
            #add-point:BEFORE FIELD pmal025 name="input.b.pmal025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmal025
            #add-point:ON CHANGE pmal025 name="input.g.pmal025"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmal002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal002
            #add-point:ON ACTION controlp INFIELD pmal002 name="input.c.pmal002"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal002             #給予default值
            LET g_qryparam.where = " ooha002 = '4' "
            #給予arg

            CALL q_ooha001()                                #呼叫開窗

            LET g_pmal_m.pmal002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = " "

            DISPLAY g_pmal_m.pmal002 TO pmal002              #顯示到畫面上
            CALL apmi110_pmal002_ref(g_pmal_m.pmal002) RETURNING g_pmal_m.pmal002_desc
            DISPLAY BY NAME g_pmal_m.pmal002_desc

            NEXT FIELD pmal002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal001
            #add-point:ON ACTION controlp INFIELD pmal001 name="input.c.pmal001"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal001             #給予default值
            #LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "  #160913-00055#4 

            #給予arg

            CALL q_pmaa001()                                #呼叫開窗

            LET g_pmal_m.pmal001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = " "

            DISPLAY g_pmal_m.pmal001 TO pmal001              #顯示到畫面上
            
            CALL apmi110_pmal001_ref(g_pmal_m.pmal001) RETURNING g_pmal_m.pmal001_desc
            DISPLAY BY NAME g_pmal_m.pmal001_desc

            NEXT FIELD pmal001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmalstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmalstus
            #add-point:ON ACTION controlp INFIELD pmalstus name="input.c.pmalstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmal003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal003
            #add-point:ON ACTION controlp INFIELD pmal003 name="input.c.pmal003"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site
            
            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_pmal_m.pmal003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL apmi110_pmal003_ref(g_pmal_m.pmal003) RETURNING g_pmal_m.pmal003_desc
            DISPLAY BY NAME g_pmal_m.pmal003_desc

            DISPLAY g_pmal_m.pmal003 TO pmal003              #顯示到畫面上

            NEXT FIELD pmal003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal004
            #add-point:ON ACTION controlp INFIELD pmal004 name="input.c.pmal004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal004             #給予default值

            #給予arg

            CALL q_oodb002_2()                                #呼叫開窗

            LET g_pmal_m.pmal004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmal_m.pmal004 TO pmal004              #顯示到畫面上
            CALL apmi110_pmal004_ref(g_pmal_m.pmal004) RETURNING g_pmal_m.pmal004_desc
            DISPLAY BY NAME g_pmal_m.pmal004_desc
            
            NEXT FIELD pmal004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal020
            #add-point:ON ACTION controlp INFIELD pmal020 name="input.c.pmal020"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal020             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "238" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmal_m.pmal020 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmal_m.pmal020 TO pmal020              #顯示到畫面上
            CALL apmi110_pmal020_ref(g_pmal_m.pmal020) RETURNING g_pmal_m.pmal020_desc
            DISPLAY BY NAME g_pmal_m.pmal020_desc
            

            NEXT FIELD pmal020                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal021
            #add-point:ON ACTION controlp INFIELD pmal021 name="input.c.pmal021"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal021             #給予default值

            #給予arg

            CALL q_pmam001()                                #呼叫開窗

            LET g_pmal_m.pmal021 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmal_m.pmal021 TO pmal021              #顯示到畫面上
            
            CALL apmi110_pmal021_ref(g_pmal_m.pmal021) RETURNING g_pmal_m.pmal021_desc
            DISPLAY BY NAME g_pmal_m.pmal021_desc
            
            NEXT FIELD pmal021                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal005
            #add-point:ON ACTION controlp INFIELD pmal005 name="input.c.pmal005"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmal022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal022
            #add-point:ON ACTION controlp INFIELD pmal022 name="input.c.pmal022"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal022             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef019
            LET g_qryparam.arg2 = "1" #

            CALL q_isac002_1()                                #呼叫開窗

            LET g_pmal_m.pmal022 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmal_m.pmal022 TO pmal022              #顯示到畫面上
            CALL apmi110_pmal022_ref(g_pmal_m.pmal022) RETURNING g_pmal_m.pmal022_desc
            DISPLAY BY NAME g_pmal_m.pmal022_desc
            
            NEXT FIELD pmal022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal006
            #add-point:ON ACTION controlp INFIELD pmal006 name="input.c.pmal006"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmal_m.pmal001 #

            CALL q_pmad002_2()                                #呼叫開窗

            LET g_pmal_m.pmal006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmal_m.pmal006 TO pmal006              #顯示到畫面上
            CALL apmi110_pmal006_ref(g_pmal_m.pmal006) RETURNING g_pmal_m.pmal006_desc
            DISPLAY BY NAME g_pmal_m.pmal006_desc
            
            NEXT FIELD pmal006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal008
            #add-point:ON ACTION controlp INFIELD pmal008 name="input.c.pmal008"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal008             #給予default值

            #給予arg
            #160621-00003#3 20160627 modify by beckxie---S
			   #LET g_qryparam.arg1 = "275"
            #CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.arg1 = '2'
            CALL q_oojd001_1()
            #160621-00003#3 20160627 modify by beckxie---E

            LET g_pmal_m.pmal008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmal_m.pmal008 TO pmal008              #顯示到畫面上
            CALL apmi110_pmal008_ref(g_pmal_m.pmal008) RETURNING g_pmal_m.pmal008_desc
            DISPLAY BY NAME g_pmal_m.pmal008_desc


            NEXT FIELD pmal008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal009
            #add-point:ON ACTION controlp INFIELD pmal009 name="input.c.pmal009"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "264" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmal_m.pmal009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmal_m.pmal009 TO pmal009              #顯示到畫面上
            CALL apmi110_pmal009_ref(g_pmal_m.pmal009) RETURNING g_pmal_m.pmal009_desc
            DISPLAY BY NAME g_pmal_m.pmal009_desc
            
            

            NEXT FIELD pmal009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal023
            #add-point:ON ACTION controlp INFIELD pmal023 name="input.c.pmal023"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmal024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal024
            #add-point:ON ACTION controlp INFIELD pmal024 name="input.c.pmal024"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmal010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal010
            #add-point:ON ACTION controlp INFIELD pmal010 name="input.c.pmal010"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmal011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal011
            #add-point:ON ACTION controlp INFIELD pmal011 name="input.c.pmal011"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "263" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmal_m.pmal011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmal_m.pmal011 TO pmal011              #顯示到畫面上
            CALL apmi110_pmal011_ref(g_pmal_m.pmal011) RETURNING g_pmal_m.pmal011_desc
            DISPLAY BY NAME g_pmal_m.pmal011_desc
            
            NEXT FIELD pmal011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal012
            #add-point:ON ACTION controlp INFIELD pmal012 name="input.c.pmal012"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "262" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmal_m.pmal012 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmal_m.pmal012 TO pmal012              #顯示到畫面上
            CALL apmi110_pmal012_ref(g_pmal_m.pmal012) RETURNING g_pmal_m.pmal012_desc
            DISPLAY BY NAME g_pmal_m.pmal012_desc
            
            NEXT FIELD pmal012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal013
            #add-point:ON ACTION controlp INFIELD pmal013 name="input.c.pmal013"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "262" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmal_m.pmal013 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmal_m.pmal013 TO pmal013              #顯示到畫面上
            CALL apmi110_pmal012_ref(g_pmal_m.pmal013) RETURNING g_pmal_m.pmal013_desc
            DISPLAY BY NAME g_pmal_m.pmal013_desc
            
            NEXT FIELD pmal013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal014
            #add-point:ON ACTION controlp INFIELD pmal014 name="input.c.pmal014"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "262" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmal_m.pmal014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmal_m.pmal014 TO pmal014              #顯示到畫面上
            CALL apmi110_pmal012_ref(g_pmal_m.pmal014) RETURNING g_pmal_m.pmal014_desc
            DISPLAY BY NAME g_pmal_m.pmal014_desc
            
            NEXT FIELD pmal014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal015
            #add-point:ON ACTION controlp INFIELD pmal015 name="input.c.pmal015"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmal016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal016
            #add-point:ON ACTION controlp INFIELD pmal016 name="input.c.pmal016"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmal017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal017
            #add-point:ON ACTION controlp INFIELD pmal017 name="input.c.pmal017"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal017             #給予default值
            LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "
     
            #給予arg

            CALL q_pmaa001_4()                                #呼叫開窗

            LET g_pmal_m.pmal017 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = " "

            DISPLAY g_pmal_m.pmal017 TO pmal017              #顯示到畫面上
            
            CALL apmi110_pmal001_ref(g_pmal_m.pmal017) RETURNING g_pmal_m.pmal017_desc
            DISPLAY BY NAME g_pmal_m.pmal017_desc

            NEXT FIELD pmal017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal018
            #add-point:ON ACTION controlp INFIELD pmal018 name="input.c.pmal018"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmal019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal019
            #add-point:ON ACTION controlp INFIELD pmal019 name="input.c.pmal019"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal019             #給予default值
            LET g_qryparam.default2 = "" #g_pmal_m.oofa011 #全名

            #給予arg

            CALL q_ooag001_2()                                #呼叫開窗

            LET g_pmal_m.pmal019 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_pmal_m.oofa011 = g_qryparam.return2 #全名

            DISPLAY g_pmal_m.pmal019 TO pmal019              #顯示到畫面上
            #DISPLAY g_pmal_m.oofa011 TO oofa011 #全名
            
            CALL apmi110_pmal019_ref(g_pmal_m.pmal019) RETURNING g_pmal_m.pmal019_desc
            DISPLAY BY NAME g_pmal_m.pmal019_desc
            
            #帶出歸屬部門ooag003
            SELECT ooag003 INTO g_pmal_m.pmal025
              FROM ooag_t
             WHERE ooagent = g_enterprise
               AND ooag001 = g_pmal_m.pmal019
            
            LET g_pmal_m_o.pmal025 = g_pmal_m.pmal025
            DISPLAY BY NAME g_pmal_m.pmal025

            CALL s_desc_get_department_desc(g_pmal_m.pmal025) RETURNING g_pmal_m.pmal025_desc
            DISPLAY BY NAME g_pmal_m.pmal025_desc
            NEXT FIELD pmal019                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmal025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmal025
            #add-point:ON ACTION controlp INFIELD pmal025 name="input.c.pmal025"
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmal_m.pmal025             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            CALL q_ooeg001()                                #呼叫開窗

            LET g_pmal_m.pmal025 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmal_m.pmal025 TO pmal025              #顯示到畫面上

            CALL s_desc_get_department_desc(g_pmal_m.pmal025) RETURNING g_pmal_m.pmal025_desc
            DISPLAY BY NAME g_pmal_m.pmal025_desc
   
            NEXT FIELD pmal025                          #返回原欄位
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
               SELECT COUNT(1) INTO l_count FROM pmal_t
                WHERE pmalent = g_enterprise AND pmal001 = g_pmal_m.pmal001
                  AND pmal002 = g_pmal_m.pmal002
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO pmal_t (pmalent,pmal002,pmal001,pmalstus,pmal003,pmal004,pmal020,pmal021, 
                      pmal005,pmal022,pmal006,pmal008,pmal009,pmal023,pmal024,pmal010,pmal011,pmal012, 
                      pmal013,pmal014,pmal015,pmal016,pmal017,pmal018,pmal019,pmal025,pmalownid,pmalowndp, 
                      pmalcrtid,pmalcrtdp,pmalcrtdt,pmalmodid,pmalmoddt)
                  VALUES (g_enterprise,g_pmal_m.pmal002,g_pmal_m.pmal001,g_pmal_m.pmalstus,g_pmal_m.pmal003, 
                      g_pmal_m.pmal004,g_pmal_m.pmal020,g_pmal_m.pmal021,g_pmal_m.pmal005,g_pmal_m.pmal022, 
                      g_pmal_m.pmal006,g_pmal_m.pmal008,g_pmal_m.pmal009,g_pmal_m.pmal023,g_pmal_m.pmal024, 
                      g_pmal_m.pmal010,g_pmal_m.pmal011,g_pmal_m.pmal012,g_pmal_m.pmal013,g_pmal_m.pmal014, 
                      g_pmal_m.pmal015,g_pmal_m.pmal016,g_pmal_m.pmal017,g_pmal_m.pmal018,g_pmal_m.pmal019, 
                      g_pmal_m.pmal025,g_pmal_m.pmalownid,g_pmal_m.pmalowndp,g_pmal_m.pmalcrtid,g_pmal_m.pmalcrtdp, 
                      g_pmal_m.pmalcrtdt,g_pmal_m.pmalmodid,g_pmal_m.pmalmoddt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmal_t:",SQLERRMESSAGE 
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
                  LET g_errparam.extend = g_pmal_m.pmal001
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL apmi110_pmal_t_mask_restore('restore_mask_o')
               
               UPDATE pmal_t SET (pmal002,pmal001,pmalstus,pmal003,pmal004,pmal020,pmal021,pmal005,pmal022, 
                   pmal006,pmal008,pmal009,pmal023,pmal024,pmal010,pmal011,pmal012,pmal013,pmal014,pmal015, 
                   pmal016,pmal017,pmal018,pmal019,pmal025,pmalownid,pmalowndp,pmalcrtid,pmalcrtdp,pmalcrtdt, 
                   pmalmodid,pmalmoddt) = (g_pmal_m.pmal002,g_pmal_m.pmal001,g_pmal_m.pmalstus,g_pmal_m.pmal003, 
                   g_pmal_m.pmal004,g_pmal_m.pmal020,g_pmal_m.pmal021,g_pmal_m.pmal005,g_pmal_m.pmal022, 
                   g_pmal_m.pmal006,g_pmal_m.pmal008,g_pmal_m.pmal009,g_pmal_m.pmal023,g_pmal_m.pmal024, 
                   g_pmal_m.pmal010,g_pmal_m.pmal011,g_pmal_m.pmal012,g_pmal_m.pmal013,g_pmal_m.pmal014, 
                   g_pmal_m.pmal015,g_pmal_m.pmal016,g_pmal_m.pmal017,g_pmal_m.pmal018,g_pmal_m.pmal019, 
                   g_pmal_m.pmal025,g_pmal_m.pmalownid,g_pmal_m.pmalowndp,g_pmal_m.pmalcrtid,g_pmal_m.pmalcrtdp, 
                   g_pmal_m.pmalcrtdt,g_pmal_m.pmalmodid,g_pmal_m.pmalmoddt)
                WHERE pmalent = g_enterprise AND pmal001 = g_pmal001_t #
                  AND pmal002 = g_pmal002_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmal_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmal_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL apmi110_pmal_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_pmal_m_t)
                     LET g_log2 = util.JSON.stringify(g_pmal_m)
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
 
{<section id="apmi110.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmi110_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE pmal_t.pmal001 
   DEFINE l_oldno     LIKE pmal_t.pmal001 
   DEFINE l_newno02     LIKE pmal_t.pmal002 
   DEFINE l_oldno02     LIKE pmal_t.pmal002 
 
   DEFINE l_master    RECORD LIKE pmal_t.* #此變數樣板目前無使用
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
   IF g_pmal_m.pmal001 IS NULL
      OR g_pmal_m.pmal002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_pmal001_t = g_pmal_m.pmal001
   LET g_pmal002_t = g_pmal_m.pmal002
 
   
   #清空key值
   LET g_pmal_m.pmal001 = ""
   LET g_pmal_m.pmal002 = ""
 
    
   CALL apmi110_set_entry("a")
   CALL apmi110_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmal_m.pmalownid = g_user
      LET g_pmal_m.pmalowndp = g_dept
      LET g_pmal_m.pmalcrtid = g_user
      LET g_pmal_m.pmalcrtdp = g_dept 
      LET g_pmal_m.pmalcrtdt = cl_get_current()
      LET g_pmal_m.pmalmodid = g_user
      LET g_pmal_m.pmalmoddt = cl_get_current()
      LET g_pmal_m.pmalstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_pmal_m.pmal001 = ''
   LET g_pmal_m.pmal002 = ''
   LET g_pmal_m.pmal001_desc = ''
   LET g_pmal_m.pmal002_desc = ''
   DISPLAY BY NAME g_pmal_m.pmal001_desc,g_pmal_m.pmal002_desc
   
   LET g_pmal_m.pmalstus = "Y"
   CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmal_m.pmalstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_pmal_m.pmal002_desc = ''
   DISPLAY BY NAME g_pmal_m.pmal002_desc
   LET g_pmal_m.pmal001_desc = ''
   DISPLAY BY NAME g_pmal_m.pmal001_desc
 
   
   #資料輸入
   CALL apmi110_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_pmal_m.* TO NULL
      CALL apmi110_show()
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
      LET g_errparam.extend = "pmal_t:",SQLERRMESSAGE 
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
   CALL apmi110_set_act_visible()
   CALL apmi110_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pmal001_t = g_pmal_m.pmal001
   LET g_pmal002_t = g_pmal_m.pmal002
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmalent = " ||g_enterprise|| " AND",
                      " pmal001 = '", g_pmal_m.pmal001, "' "
                      ," AND pmal002 = '", g_pmal_m.pmal002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmi110_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_pmal_m.pmalownid      
   LET g_data_dept  = g_pmal_m.pmalowndp
              
   #功能已完成,通報訊息中心
   CALL apmi110_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="apmi110.show" >}
#+ 資料顯示 
PRIVATE FUNCTION apmi110_show()
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
   CALL apmi110_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            #CALL apmi110_pmal002_ref(g_pmal_m.pmal002) RETURNING g_pmal_m.pmal002_desc
            #DISPLAY BY NAME g_pmal_m.pmal002_desc
            #
            #CALL apmi110_pmal001_ref(g_pmal_m.pmal001) RETURNING g_pmal_m.pmal001_desc
            #DISPLAY BY NAME g_pmal_m.pmal001_desc
            #
            #CALL apmi110_pmal003_ref(g_pmal_m.pmal003) RETURNING g_pmal_m.pmal003_desc
            #DISPLAY BY NAME g_pmal_m.pmal003_desc
            
            CALL apmi110_pmal004_ref(g_pmal_m.pmal004) RETURNING g_pmal_m.pmal004_desc
            DISPLAY BY NAME g_pmal_m.pmal004_desc
            
            #CALL apmi110_pmal020_ref(g_pmal_m.pmal020) RETURNING g_pmal_m.pmal020_desc
            #DISPLAY BY NAME g_pmal_m.pmal020_desc
            #
            #CALL apmi110_pmal021_ref(g_pmal_m.pmal021) RETURNING g_pmal_m.pmal021_desc
            #DISPLAY BY NAME g_pmal_m.pmal021_desc
            #
            #CALL apmi110_pmal022_ref(g_pmal_m.pmal022) RETURNING g_pmal_m.pmal022_desc
            #DISPLAY BY NAME g_pmal_m.pmal022_desc
            #
            #CALL apmi110_pmal006_ref(g_pmal_m.pmal006) RETURNING g_pmal_m.pmal006_desc
            #DISPLAY BY NAME g_pmal_m.pmal006_desc
            #
            #CALL apmi110_pmal008_ref(g_pmal_m.pmal008) RETURNING g_pmal_m.pmal008_desc
            #DISPLAY BY NAME g_pmal_m.pmal008_desc
            #
            #CALL apmi110_pmal009_ref(g_pmal_m.pmal009) RETURNING g_pmal_m.pmal009_desc
            #DISPLAY BY NAME g_pmal_m.pmal009_desc
            #
            #CALL apmi110_pmal011_ref(g_pmal_m.pmal011) RETURNING g_pmal_m.pmal011_desc
            #DISPLAY BY NAME g_pmal_m.pmal011_desc
            #
            #CALL apmi110_pmal012_ref(g_pmal_m.pmal012) RETURNING g_pmal_m.pmal012_desc
            #DISPLAY BY NAME g_pmal_m.pmal012_desc
            #
            #CALL apmi110_pmal012_ref(g_pmal_m.pmal013) RETURNING g_pmal_m.pmal013_desc
            #DISPLAY BY NAME g_pmal_m.pmal013_desc
            #
            #CALL apmi110_pmal012_ref(g_pmal_m.pmal014) RETURNING g_pmal_m.pmal014_desc
            #DISPLAY BY NAME g_pmal_m.pmal014_desc
            #
            #CALL apmi110_pmal001_ref(g_pmal_m.pmal017) RETURNING g_pmal_m.pmal017_desc
            #DISPLAY BY NAME g_pmal_m.pmal017_desc
            #
            #CALL apmi110_pmal019_ref(g_pmal_m.pmal019) RETURNING g_pmal_m.pmal019_desc
            #DISPLAY BY NAME g_pmal_m.pmal019_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmal_m.pmalownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmal_m.pmalownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmal_m.pmalownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmal_m.pmalowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmal_m.pmalowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmal_m.pmalowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmal_m.pmalcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmal_m.pmalcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmal_m.pmalcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmal_m.pmalcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmal_m.pmalcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmal_m.pmalcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmal_m.pmalmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmal_m.pmalmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmal_m.pmalmodid_desc

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmal_m.pmal002,g_pmal_m.pmal002_desc,g_pmal_m.pmal001,g_pmal_m.pmal001_desc,g_pmal_m.pmalstus, 
       g_pmal_m.pmal003,g_pmal_m.pmal003_desc,g_pmal_m.pmal004,g_pmal_m.pmal004_desc,g_pmal_m.pmal020, 
       g_pmal_m.pmal020_desc,g_pmal_m.pmal021,g_pmal_m.pmal021_desc,g_pmal_m.pmal005,g_pmal_m.pmal022, 
       g_pmal_m.pmal022_desc,g_pmal_m.pmal006,g_pmal_m.pmal006_desc,g_pmal_m.pmal008,g_pmal_m.pmal008_desc, 
       g_pmal_m.pmal009,g_pmal_m.pmal009_desc,g_pmal_m.pmal023,g_pmal_m.pmal024,g_pmal_m.pmal010,g_pmal_m.pmal011, 
       g_pmal_m.pmal011_desc,g_pmal_m.pmal012,g_pmal_m.pmal012_desc,g_pmal_m.pmal013,g_pmal_m.pmal013_desc, 
       g_pmal_m.pmal014,g_pmal_m.pmal014_desc,g_pmal_m.pmal015,g_pmal_m.pmal016,g_pmal_m.pmal017,g_pmal_m.pmal017_desc, 
       g_pmal_m.pmal018,g_pmal_m.pmal019,g_pmal_m.pmal019_desc,g_pmal_m.pmal025,g_pmal_m.pmal025_desc, 
       g_pmal_m.pmalownid,g_pmal_m.pmalownid_desc,g_pmal_m.pmalowndp,g_pmal_m.pmalowndp_desc,g_pmal_m.pmalcrtid, 
       g_pmal_m.pmalcrtid_desc,g_pmal_m.pmalcrtdp,g_pmal_m.pmalcrtdp_desc,g_pmal_m.pmalcrtdt,g_pmal_m.pmalmodid, 
       g_pmal_m.pmalmodid_desc,g_pmal_m.pmalmoddt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL apmi110_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmal_m.pmalstus 
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
 
{<section id="apmi110.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION apmi110_delete()
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
   IF g_pmal_m.pmal001 IS NULL
   OR g_pmal_m.pmal002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_pmal001_t = g_pmal_m.pmal001
   LET g_pmal002_t = g_pmal_m.pmal002
 
   
   
 
   OPEN apmi110_cl USING g_enterprise,g_pmal_m.pmal001,g_pmal_m.pmal002
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmi110_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE apmi110_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmi110_master_referesh USING g_pmal_m.pmal001,g_pmal_m.pmal002 INTO g_pmal_m.pmal002,g_pmal_m.pmal001, 
       g_pmal_m.pmalstus,g_pmal_m.pmal003,g_pmal_m.pmal004,g_pmal_m.pmal020,g_pmal_m.pmal021,g_pmal_m.pmal005, 
       g_pmal_m.pmal022,g_pmal_m.pmal006,g_pmal_m.pmal008,g_pmal_m.pmal009,g_pmal_m.pmal023,g_pmal_m.pmal024, 
       g_pmal_m.pmal010,g_pmal_m.pmal011,g_pmal_m.pmal012,g_pmal_m.pmal013,g_pmal_m.pmal014,g_pmal_m.pmal015, 
       g_pmal_m.pmal016,g_pmal_m.pmal017,g_pmal_m.pmal018,g_pmal_m.pmal019,g_pmal_m.pmal025,g_pmal_m.pmalownid, 
       g_pmal_m.pmalowndp,g_pmal_m.pmalcrtid,g_pmal_m.pmalcrtdp,g_pmal_m.pmalcrtdt,g_pmal_m.pmalmodid, 
       g_pmal_m.pmalmoddt,g_pmal_m.pmal002_desc,g_pmal_m.pmal001_desc,g_pmal_m.pmal003_desc,g_pmal_m.pmal020_desc, 
       g_pmal_m.pmal021_desc,g_pmal_m.pmal022_desc,g_pmal_m.pmal006_desc,g_pmal_m.pmal008_desc,g_pmal_m.pmal009_desc, 
       g_pmal_m.pmal011_desc,g_pmal_m.pmal012_desc,g_pmal_m.pmal013_desc,g_pmal_m.pmal014_desc,g_pmal_m.pmal017_desc, 
       g_pmal_m.pmal019_desc,g_pmal_m.pmal025_desc
   
   
   #檢查是否允許此動作
   IF NOT apmi110_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmal_m_mask_o.* =  g_pmal_m.*
   CALL apmi110_pmal_t_mask()
   LET g_pmal_m_mask_n.* =  g_pmal_m.*
   
   #將最新資料顯示到畫面上
   CALL apmi110_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmi110_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM pmal_t 
       WHERE pmalent = g_enterprise AND pmal001 = g_pmal_m.pmal001 
         AND pmal002 = g_pmal_m.pmal002 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmal_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pmal_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE apmi110_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL apmi110_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL apmi110_browser_fill(g_wc,"")
         CALL apmi110_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apmi110_cl
 
   #功能已完成,通報訊息中心
   CALL apmi110_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmi110.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmi110_ui_browser_refresh()
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
      IF g_browser[l_i].b_pmal001 = g_pmal_m.pmal001
         AND g_browser[l_i].b_pmal002 = g_pmal_m.pmal002
 
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
 
{<section id="apmi110.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmi110_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("pmal001,pmal002",TRUE)
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
 
{<section id="apmi110.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmi110_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pmal001,pmal002",FALSE)
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
 
{<section id="apmi110.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmi110_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmi110.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmi110_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmi110.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmi110_default_search()
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
      LET ls_wc = ls_wc, " pmal001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " pmal002 = '", g_argv[02], "' AND "
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
 
{<section id="apmi110.mask_functions" >}
&include "erp/apm/apmi110_mask.4gl"
 
{</section>}
 
{<section id="apmi110.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION apmi110_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_pmal_m.pmal001 IS NULL
      OR g_pmal_m.pmal002 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN apmi110_cl USING g_enterprise,g_pmal_m.pmal001,g_pmal_m.pmal002
   IF STATUS THEN
      CLOSE apmi110_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmi110_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE apmi110_master_referesh USING g_pmal_m.pmal001,g_pmal_m.pmal002 INTO g_pmal_m.pmal002,g_pmal_m.pmal001, 
       g_pmal_m.pmalstus,g_pmal_m.pmal003,g_pmal_m.pmal004,g_pmal_m.pmal020,g_pmal_m.pmal021,g_pmal_m.pmal005, 
       g_pmal_m.pmal022,g_pmal_m.pmal006,g_pmal_m.pmal008,g_pmal_m.pmal009,g_pmal_m.pmal023,g_pmal_m.pmal024, 
       g_pmal_m.pmal010,g_pmal_m.pmal011,g_pmal_m.pmal012,g_pmal_m.pmal013,g_pmal_m.pmal014,g_pmal_m.pmal015, 
       g_pmal_m.pmal016,g_pmal_m.pmal017,g_pmal_m.pmal018,g_pmal_m.pmal019,g_pmal_m.pmal025,g_pmal_m.pmalownid, 
       g_pmal_m.pmalowndp,g_pmal_m.pmalcrtid,g_pmal_m.pmalcrtdp,g_pmal_m.pmalcrtdt,g_pmal_m.pmalmodid, 
       g_pmal_m.pmalmoddt,g_pmal_m.pmal002_desc,g_pmal_m.pmal001_desc,g_pmal_m.pmal003_desc,g_pmal_m.pmal020_desc, 
       g_pmal_m.pmal021_desc,g_pmal_m.pmal022_desc,g_pmal_m.pmal006_desc,g_pmal_m.pmal008_desc,g_pmal_m.pmal009_desc, 
       g_pmal_m.pmal011_desc,g_pmal_m.pmal012_desc,g_pmal_m.pmal013_desc,g_pmal_m.pmal014_desc,g_pmal_m.pmal017_desc, 
       g_pmal_m.pmal019_desc,g_pmal_m.pmal025_desc
   
 
   #檢查是否允許此動作
   IF NOT apmi110_action_chk() THEN
      CLOSE apmi110_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmal_m.pmal002,g_pmal_m.pmal002_desc,g_pmal_m.pmal001,g_pmal_m.pmal001_desc,g_pmal_m.pmalstus, 
       g_pmal_m.pmal003,g_pmal_m.pmal003_desc,g_pmal_m.pmal004,g_pmal_m.pmal004_desc,g_pmal_m.pmal020, 
       g_pmal_m.pmal020_desc,g_pmal_m.pmal021,g_pmal_m.pmal021_desc,g_pmal_m.pmal005,g_pmal_m.pmal022, 
       g_pmal_m.pmal022_desc,g_pmal_m.pmal006,g_pmal_m.pmal006_desc,g_pmal_m.pmal008,g_pmal_m.pmal008_desc, 
       g_pmal_m.pmal009,g_pmal_m.pmal009_desc,g_pmal_m.pmal023,g_pmal_m.pmal024,g_pmal_m.pmal010,g_pmal_m.pmal011, 
       g_pmal_m.pmal011_desc,g_pmal_m.pmal012,g_pmal_m.pmal012_desc,g_pmal_m.pmal013,g_pmal_m.pmal013_desc, 
       g_pmal_m.pmal014,g_pmal_m.pmal014_desc,g_pmal_m.pmal015,g_pmal_m.pmal016,g_pmal_m.pmal017,g_pmal_m.pmal017_desc, 
       g_pmal_m.pmal018,g_pmal_m.pmal019,g_pmal_m.pmal019_desc,g_pmal_m.pmal025,g_pmal_m.pmal025_desc, 
       g_pmal_m.pmalownid,g_pmal_m.pmalownid_desc,g_pmal_m.pmalowndp,g_pmal_m.pmalowndp_desc,g_pmal_m.pmalcrtid, 
       g_pmal_m.pmalcrtid_desc,g_pmal_m.pmalcrtdp,g_pmal_m.pmalcrtdp_desc,g_pmal_m.pmalcrtdt,g_pmal_m.pmalmodid, 
       g_pmal_m.pmalmodid_desc,g_pmal_m.pmalmoddt
 
   CASE g_pmal_m.pmalstus
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
         CASE g_pmal_m.pmalstus
            
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
      g_pmal_m.pmalstus = lc_state OR cl_null(lc_state) THEN
      CLOSE apmi110_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_pmal_m.pmalmodid = g_user
   LET g_pmal_m.pmalmoddt = cl_get_current()
   LET g_pmal_m.pmalstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE pmal_t 
      SET (pmalstus,pmalmodid,pmalmoddt) 
        = (g_pmal_m.pmalstus,g_pmal_m.pmalmodid,g_pmal_m.pmalmoddt)     
    WHERE pmalent = g_enterprise AND pmal001 = g_pmal_m.pmal001
      AND pmal002 = g_pmal_m.pmal002
    
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
      EXECUTE apmi110_master_referesh USING g_pmal_m.pmal001,g_pmal_m.pmal002 INTO g_pmal_m.pmal002, 
          g_pmal_m.pmal001,g_pmal_m.pmalstus,g_pmal_m.pmal003,g_pmal_m.pmal004,g_pmal_m.pmal020,g_pmal_m.pmal021, 
          g_pmal_m.pmal005,g_pmal_m.pmal022,g_pmal_m.pmal006,g_pmal_m.pmal008,g_pmal_m.pmal009,g_pmal_m.pmal023, 
          g_pmal_m.pmal024,g_pmal_m.pmal010,g_pmal_m.pmal011,g_pmal_m.pmal012,g_pmal_m.pmal013,g_pmal_m.pmal014, 
          g_pmal_m.pmal015,g_pmal_m.pmal016,g_pmal_m.pmal017,g_pmal_m.pmal018,g_pmal_m.pmal019,g_pmal_m.pmal025, 
          g_pmal_m.pmalownid,g_pmal_m.pmalowndp,g_pmal_m.pmalcrtid,g_pmal_m.pmalcrtdp,g_pmal_m.pmalcrtdt, 
          g_pmal_m.pmalmodid,g_pmal_m.pmalmoddt,g_pmal_m.pmal002_desc,g_pmal_m.pmal001_desc,g_pmal_m.pmal003_desc, 
          g_pmal_m.pmal020_desc,g_pmal_m.pmal021_desc,g_pmal_m.pmal022_desc,g_pmal_m.pmal006_desc,g_pmal_m.pmal008_desc, 
          g_pmal_m.pmal009_desc,g_pmal_m.pmal011_desc,g_pmal_m.pmal012_desc,g_pmal_m.pmal013_desc,g_pmal_m.pmal014_desc, 
          g_pmal_m.pmal017_desc,g_pmal_m.pmal019_desc,g_pmal_m.pmal025_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_pmal_m.pmal002,g_pmal_m.pmal002_desc,g_pmal_m.pmal001,g_pmal_m.pmal001_desc, 
          g_pmal_m.pmalstus,g_pmal_m.pmal003,g_pmal_m.pmal003_desc,g_pmal_m.pmal004,g_pmal_m.pmal004_desc, 
          g_pmal_m.pmal020,g_pmal_m.pmal020_desc,g_pmal_m.pmal021,g_pmal_m.pmal021_desc,g_pmal_m.pmal005, 
          g_pmal_m.pmal022,g_pmal_m.pmal022_desc,g_pmal_m.pmal006,g_pmal_m.pmal006_desc,g_pmal_m.pmal008, 
          g_pmal_m.pmal008_desc,g_pmal_m.pmal009,g_pmal_m.pmal009_desc,g_pmal_m.pmal023,g_pmal_m.pmal024, 
          g_pmal_m.pmal010,g_pmal_m.pmal011,g_pmal_m.pmal011_desc,g_pmal_m.pmal012,g_pmal_m.pmal012_desc, 
          g_pmal_m.pmal013,g_pmal_m.pmal013_desc,g_pmal_m.pmal014,g_pmal_m.pmal014_desc,g_pmal_m.pmal015, 
          g_pmal_m.pmal016,g_pmal_m.pmal017,g_pmal_m.pmal017_desc,g_pmal_m.pmal018,g_pmal_m.pmal019, 
          g_pmal_m.pmal019_desc,g_pmal_m.pmal025,g_pmal_m.pmal025_desc,g_pmal_m.pmalownid,g_pmal_m.pmalownid_desc, 
          g_pmal_m.pmalowndp,g_pmal_m.pmalowndp_desc,g_pmal_m.pmalcrtid,g_pmal_m.pmalcrtid_desc,g_pmal_m.pmalcrtdp, 
          g_pmal_m.pmalcrtdp_desc,g_pmal_m.pmalcrtdt,g_pmal_m.pmalmodid,g_pmal_m.pmalmodid_desc,g_pmal_m.pmalmoddt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE apmi110_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmi110_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmi110.signature" >}
   
 
{</section>}
 
{<section id="apmi110.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmi110_set_pk_array()
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
   LET g_pk_array[1].values = g_pmal_m.pmal001
   LET g_pk_array[1].column = 'pmal001'
   LET g_pk_array[2].values = g_pmal_m.pmal002
   LET g_pk_array[2].column = 'pmal002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmi110.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="apmi110.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmi110_msgcentre_notify(lc_state)
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
   CALL apmi110_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmal_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmi110.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apmi110_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmi110.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION apmi110_pmal001_ref(p_pmal001)
DEFINE p_pmal001      LIKE pmal_t.pmal001
DEFINE r_pmal001_desc LIKE pmaal_t.pmaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmal001
       CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmal001_desc = g_rtn_fields[1]
       RETURN r_pmal001_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmi110_pmal002_ref(p_pmal002)
DEFINE p_pmal002      LIKE pmal_t.pmal002
DEFINE r_pmal002_desc LIKE oohal_t.oohal003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmal002
       CALL ap_ref_array2(g_ref_fields,"SELECT oohal003 FROM oohal_t WHERE oohalent='"||g_enterprise||"' AND oohal001=? AND oohal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmal002_desc = g_rtn_fields[1]
       RETURN r_pmal002_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmi110_pmal020_ref(p_pmal020)
DEFINE p_pmal020      LIKE pmal_t.pmal020
DEFINE r_pmal020_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmal020
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='238' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmal020_desc = g_rtn_fields[1]
       RETURN r_pmal020_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmi110_pmal009_ref(p_pmal009)
DEFINE p_pmal009      LIKE pmal_t.pmal009
DEFINE r_pmal009_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmal009
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='264' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmal009_desc = g_rtn_fields[1]
       RETURN r_pmal009_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmi110_pmal011_ref(p_pmal011)
DEFINE p_pmal011      LIKE pmal_t.pmal011
DEFINE r_pmal011_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmal011
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='263' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmal011_desc = g_rtn_fields[1]
       RETURN r_pmal011_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmi110_pmal012_ref(p_pmal012)
DEFINE p_pmal012      LIKE pmal_t.pmal012
DEFINE r_pmal012_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmal012
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='262' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmal012_desc = g_rtn_fields[1]
       RETURN r_pmal012_desc
    
END FUNCTION
#+
PRIVATE FUNCTION apmi110_pmal019_ref(p_pmal019)
DEFINE p_pmal019      LIKE pmal_t.pmal019
DEFINE r_pmal019_desc LIKE oofa_t.oofa011

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmal019
       CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
       LET r_pmal019_desc = g_rtn_fields[1]
       RETURN r_pmal019_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmi110_pmal002_chk(p_pmal002)
DEFINE p_pmal002 LIKE pmal_t.pmal002
DEFINE r_success LIKE type_t.num5

       LET r_success = TRUE
       
       #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
       INITIALIZE g_chkparam.* TO NULL
       LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
       #設定g_chkparam.*的參數
       LET g_chkparam.arg1 = p_pmal002
       LET g_chkparam.err_str[1] = "apm-00066:sub-01302|aooi384|",cl_get_progname("aooi384",g_lang,"2"),"|:EXEPROGaooi384"  #160318-00025#31  add
       #呼叫檢查存在並帶值的library
       IF NOT cl_chk_exist("v_ooha001_4") THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION apmi110_pmal001_chk(p_pmal001)
DEFINE p_pmal001 LIKE pmal_t.pmal001
DEFINE r_success LIKE type_t.num5

       LET r_success = TRUE
       
       #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
       INITIALIZE g_chkparam.* TO NULL

       #設定g_chkparam.*的參數
       LET g_chkparam.arg1 = p_pmal001

       #呼叫檢查存在並帶值的library
       IF NOT cl_chk_exist("v_pmaa001_1") THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION apmi110_pmal012_chk(p_pmal012)
DEFINE p_pmal012    LIKE pmal_t.pmal012
DEFINE r_success    LIKE type_t.num5

       LET r_success = TRUE
       
       IF NOT cl_null(p_pmal012) THEN 
          IF NOT s_azzi650_chk_exist('262',p_pmal012) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION apmi110_pmal003_ref(p_pmal003)
DEFINE p_pmal003      LIKE pmal_t.pmal003
DEFINE r_pmal003_desc LIKE ooail_t.ooail003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmal003
       CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001 = ? AND ooail002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmal003_desc = g_rtn_fields[1]
       RETURN r_pmal003_desc
       
END FUNCTION

PRIVATE FUNCTION apmi110_pmal004_ref(p_pmal004)
DEFINE p_pmal004      LIKE pmal_t.pmal004
DEFINE r_pmal004_desc LIKE oodbl_t.oodbl004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmal004
       CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001='"||g_ooef019||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmal004_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmal004_desc

END FUNCTION

PRIVATE FUNCTION apmi110_pmal021_ref(p_pmal021)
DEFINE p_pmal021      LIKE pmal_t.pmal021
DEFINE r_pmal021_desc LIKE pmaml_t.pmaml003

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = p_pmal021
        CALL ap_ref_array2(g_ref_fields,"SELECT pmaml003 FROM pmaml_t WHERE pmamlent='"||g_enterprise||"' AND pmaml001=? AND pmaml002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET r_pmal021_desc = '', g_rtn_fields[1] , ''
        RETURN r_pmal021_desc
        
END FUNCTION

PRIVATE FUNCTION apmi110_pmal022_ref(p_pmal022)
DEFINE p_pmal022      LIKE pmal_t.pmal022
DEFINE r_pmal022_desc LIKE isacl_t.isacl004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmal022
       CALL ap_ref_array2(g_ref_fields,"SELECT isacl004 FROM isacl_t WHERE isaclent='"||g_enterprise||"' AND isacl001='"||g_ooef019||"' AND isacl002=? AND isacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmal022_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmal022_desc

END FUNCTION

PRIVATE FUNCTION apmi110_pmal006_ref(p_pmal006)
DEFINE p_pmal006      LIKE pmal_t.pmal006
DEFINE r_pmal006_desc LIKE ooibl_t.ooibl004

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = p_pmal006
        CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET r_pmal006_desc = '', g_rtn_fields[1] , ''
        RETURN r_pmal006_desc

END FUNCTION

PRIVATE FUNCTION apmi110_pmal008_ref(p_pmal008)
DEFINE p_pmal008      LIKE pmal_t.pmal008
DEFINE r_pmal008_desc LIKE oocql_t.oocql004

         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = p_pmal008
         #160621-00003#3 20160627 modify by beckxie---S
         #CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='275' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         #160621-00003#3 20160627 modify by beckxie---E
         LET r_pmal008_desc = '', g_rtn_fields[1] , ''
         RETURN r_pmal008_desc

END FUNCTION

 
{</section>}
 
