#該程式未解開Section, 採用最新樣板產出!
{<section id="anmi960.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-09-03 09:27:39), PR版次:0004(2016-11-02 11:17:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000065
#+ Filename...: anmi960
#+ Description: 資金計劃審批權限設定
#+ Creator....: 04152(2014-08-11 19:43:55)
#+ Modifier...: 04152 -SD/PR- 08732
 
{</section>}
 
{<section id="anmi960.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#150715-00014#1   150716     By Jessy     bug修復
#160318-00025#45  2016/04/19 by 07959     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160822-00012#5   2016/11/02 By 08732     新舊值調整
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
PRIVATE TYPE type_g_nmbh_m RECORD
       nmbh001 LIKE nmbh_t.nmbh001, 
   nmbh002 LIKE nmbh_t.nmbh002, 
   nmbh003 LIKE nmbh_t.nmbh003, 
   nmbh004 LIKE nmbh_t.nmbh004, 
   nmbh004_desc LIKE type_t.chr80, 
   nmbh005 LIKE nmbh_t.nmbh005, 
   nmbh005_desc LIKE type_t.chr80, 
   nmbh006 LIKE nmbh_t.nmbh006, 
   nmbh006_desc LIKE type_t.chr80, 
   nmbh007 LIKE nmbh_t.nmbh007, 
   nmbh007_desc LIKE type_t.chr80, 
   nmbh008 LIKE nmbh_t.nmbh008, 
   nmbh008_desc LIKE type_t.chr80, 
   nmbhstus LIKE nmbh_t.nmbhstus, 
   nmbhownid LIKE nmbh_t.nmbhownid, 
   nmbhownid_desc LIKE type_t.chr80, 
   nmbhowndp LIKE nmbh_t.nmbhowndp, 
   nmbhowndp_desc LIKE type_t.chr80, 
   nmbhcrtid LIKE nmbh_t.nmbhcrtid, 
   nmbhcrtid_desc LIKE type_t.chr80, 
   nmbhcrtdp LIKE nmbh_t.nmbhcrtdp, 
   nmbhcrtdp_desc LIKE type_t.chr80, 
   nmbhcrtdt LIKE nmbh_t.nmbhcrtdt, 
   nmbhmodid LIKE nmbh_t.nmbhmodid, 
   nmbhmodid_desc LIKE type_t.chr80, 
   nmbhmoddt LIKE nmbh_t.nmbhmoddt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
                  #外顯欄位
       b_show          LIKE type_t.chr100,
         #父節點id
       b_pid           LIKE type_t.chr100,
         #本身節點id
       b_id            LIKE type_t.chr100,
         #是否展開
       b_exp           LIKE type_t.chr100,
         #是否有子節點
       b_hasC          LIKE type_t.num5,
         #是否已展開
       b_isExp         LIKE type_t.num5,
         #展開值
       b_expcode       LIKE type_t.num5,
         #tree自定義欄位
         b_ooej001 LIKE ooej_t.ooej001,
   b_ooej002 LIKE ooej_t.ooej002,
   b_ooej003 LIKE ooej_t.ooej003,
   b_ooej004 LIKE ooej_t.ooej004,
   b_ooej005 LIKE ooej_t.ooej005,
   b_nmbh006_desc LIKE type_t.chr80,
   b_nmbh007_desc LIKE type_t.chr80,
   b_nmbh008_desc LIKE type_t.chr80,
      b_nmbh001 LIKE nmbh_t.nmbh001,
      b_nmbh002 LIKE nmbh_t.nmbh002,
      b_nmbh003 LIKE nmbh_t.nmbh003,
      b_nmbh004 LIKE nmbh_t.nmbh004,
      b_nmbh005 LIKE nmbh_t.nmbh005
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_nmbh006_t           LIKE nmbh_t.nmbh006
DEFINE g_nmbh007_t           LIKE nmbh_t.nmbh007
DEFINE g_nmbh008_t           LIKE nmbh_t.nmbh008
DEFINE g_ooej001             LIKE ooej_t.ooej001
DEFINE g_ooej006             LIKE ooej_t.ooej006
DEFINE g_ooej001_t           LIKE ooej_t.ooej001
DEFINE g_ooej006_t           LIKE ooej_t.ooej006
DEFINE g_browser_root        DYNAMIC ARRAY OF INTEGER
#end add-point
 
#模組變數(Module Variables)
DEFINE g_nmbh_m        type_g_nmbh_m  #單頭變數宣告
DEFINE g_nmbh_m_t      type_g_nmbh_m  #單頭舊值宣告(系統還原用)
DEFINE g_nmbh_m_o      type_g_nmbh_m  #單頭舊值宣告(其他用途)
DEFINE g_nmbh_m_mask_o type_g_nmbh_m  #轉換遮罩前資料
DEFINE g_nmbh_m_mask_n type_g_nmbh_m  #轉換遮罩後資料
 
   DEFINE g_nmbh001_t LIKE nmbh_t.nmbh001
DEFINE g_nmbh002_t LIKE nmbh_t.nmbh002
DEFINE g_nmbh003_t LIKE nmbh_t.nmbh003
DEFINE g_nmbh004_t LIKE nmbh_t.nmbh004
DEFINE g_nmbh005_t LIKE nmbh_t.nmbh005
 
   
#應用 a54 樣板自動產生(Version:3)
DEFINE g_browser_expand   DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位  
      b_nmbh004 STRING
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
 
{<section id="anmi960.main" >}
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
   LET g_forupd_sql = " SELECT nmbh001,nmbh002,nmbh003,nmbh004,'',nmbh005,'',nmbh006,'',nmbh007,'',nmbh008, 
       '',nmbhstus,nmbhownid,'',nmbhowndp,'',nmbhcrtid,'',nmbhcrtdp,'',nmbhcrtdt,nmbhmodid,'',nmbhmoddt", 
        
                      " FROM nmbh_t",
                      " WHERE nmbhent= ? AND nmbh001=? AND nmbh002=? AND nmbh003=? AND nmbh004=? AND  
                          nmbh005=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmi960_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.nmbh001,t0.nmbh002,t0.nmbh003,t0.nmbh004,t0.nmbh005,t0.nmbh006,t0.nmbh007, 
       t0.nmbh008,t0.nmbhstus,t0.nmbhownid,t0.nmbhowndp,t0.nmbhcrtid,t0.nmbhcrtdp,t0.nmbhcrtdt,t0.nmbhmodid, 
       t0.nmbhmoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011",
               " FROM nmbh_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.nmbhownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.nmbhowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.nmbhcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.nmbhcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.nmbhmodid  ",
 
               " WHERE t0.nmbhent = " ||g_enterprise|| " AND t0.nmbh001 = ? AND t0.nmbh002 = ? AND t0.nmbh003 = ? AND t0.nmbh004 = ? AND t0.nmbh005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmi960_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmi960 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmi960_init()   
 
      #進入選單 Menu (="N")
      CALL anmi960_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmi960
      
   END IF 
   
   CLOSE anmi960_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmi960.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmi960_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_main_hidden = 0
   #定義combobox狀態
      CALL cl_set_combo_scc_part('nmbhstus','17','N,Y')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL anmi960_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="anmi960.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmi960_ui_dialog() 
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
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL anmi960_insert()
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
         INITIALIZE g_nmbh_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL anmi960_init()
      END IF
      
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_worksheet_hidden = 1 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL anmi960_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL anmi960_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL anmi960_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL anmi960_set_act_visible()
               CALL anmi960_set_act_no_visible()
               IF NOT (g_nmbh_m.nmbh001 IS NULL
                 OR g_nmbh_m.nmbh002 IS NULL
                 OR g_nmbh_m.nmbh003 IS NULL
                 OR g_nmbh_m.nmbh004 IS NULL
                 OR g_nmbh_m.nmbh005 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " nmbhent = " ||g_enterprise|| " AND",
                                     " nmbh001 = '", g_nmbh_m.nmbh001, "' "
                                     ," AND nmbh002 = '", g_nmbh_m.nmbh002, "' "
                                     ," AND nmbh003 = '", g_nmbh_m.nmbh003, "' "
                                     ," AND nmbh004 = '", g_nmbh_m.nmbh004, "' "
                                     ," AND nmbh005 = '", g_nmbh_m.nmbh005, "' "
 
                  #填到對應位置
                  CALL anmi960_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL anmi960_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL anmi960_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL anmi960_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL anmi960_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL anmi960_fetch("L")  
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
                  CALL gfrm_curr.setElementImage("mainhidden","16/worksheethidden.png")
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementImage("mainhidden","16/worksheethidden.png")
                  LET g_main_hidden = 1
               END IF
               EXIT MENU
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_worksheet_hidden THEN
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/mainhidden.png")
                  LET g_worksheet_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/mainhidden.png")
                  LET g_worksheet_hidden = 1
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
                  CALL anmi960_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL anmi960_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL anmi960_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL anmi960_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL anmi960_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmi960_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL anmi960_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmi960_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL anmi960_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmi960_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmi960_set_pk_array()
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
           
            #快速搜尋(樹狀專用)
            INPUT g_searchstr,g_searchcol FROM formonly.searchstr,formonly.cbo_searchcol
               BEFORE INPUT
            
            END INPUT
      
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
                  CALL anmi960_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               #應用 a53 樣板自動產生(Version:3)
               ON EXPAND (g_row_index)
                  #樹展開
                  CALL anmi960_browser_expand(g_row_index)
                  LET g_browser[g_row_index].b_isExp = 1
                  LET g_browser_expand[g_browser_expand.getLength()+1].b_nmbh004 = g_browser[g_row_index].b_nmbh004
                  
               ON COLLAPSE (g_row_index)
                  #樹關閉
 
 
 
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL anmi960_browser_fill(g_wc,"")
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
                  CALL anmi960_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL anmi960_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL anmi960_set_act_visible()
               CALL anmi960_set_act_no_visible()
               IF NOT (g_nmbh_m.nmbh001 IS NULL
                 OR g_nmbh_m.nmbh002 IS NULL
                 OR g_nmbh_m.nmbh003 IS NULL
                 OR g_nmbh_m.nmbh004 IS NULL
                 OR g_nmbh_m.nmbh005 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " nmbhent = " ||g_enterprise|| " AND",
                                     " nmbh001 = '", g_nmbh_m.nmbh001, "' "
                                     ," AND nmbh002 = '", g_nmbh_m.nmbh002, "' "
                                     ," AND nmbh003 = '", g_nmbh_m.nmbh003, "' "
                                     ," AND nmbh004 = '", g_nmbh_m.nmbh004, "' "
                                     ," AND nmbh005 = '", g_nmbh_m.nmbh005, "' "
 
                  #填到對應位置
                  CALL anmi960_browser_fill(g_wc,"")
               END IF
         
            
            
            #第一筆資料
            ON ACTION first
               CALL anmi960_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL anmi960_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL anmi960_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL anmi960_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL anmi960_fetch("L")  
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
                  CALL gfrm_curr.setElementImage("mainhidden","16/worksheethidden.png")
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementImage("mainhidden","16/mainhidden.png")
                  LET g_main_hidden = 1
               END IF
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_worksheet_hidden THEN
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/mainhidden.png")
                  LET g_worksheet_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/worksheethidden.png")
                  LET g_worksheet_hidden = 1
               END IF
         
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
 
            #快速搜尋(樹狀專用)
            ON ACTION searchdata
               LET g_current_idx = 1
               LET g_searchstr = GET_FLDBUF(searchstr)
               CALL anmi960_browser_search()
               EXIT DIALOG
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL anmi960_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL anmi960_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL anmi960_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL anmi960_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL anmi960_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmi960_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL anmi960_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmi960_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL anmi960_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmi960_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmi960_set_pk_array()
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
 
{<section id="anmi960.browser_fill" >}
#應用 a30 樣板自動產生(Version:10)
#+ 瀏覽頁簽資料填充(六階樹狀)
PRIVATE FUNCTION anmi960_browser_fill(ps_wc,ps_page_action) 
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE ps_wc              STRING
   DEFINE ps_page_action     STRING
   DEFINE ls_sql             STRING
   DEFINE li_idx             LIKE type_t.num10
   DEFINE li_idx2            LIKE type_t.num10
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_sql              STRING
   DEFINE l_pid              LIKE type_t.chr50   #用於樹的第一層
   DEFINE l_ac2              LIKE type_t.num5
   DEFINE l_n2               LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理 name="browser_fill.before_fill"
   CALL g_browser.clear()

   #第一層的資料
   LET l_sql = "SELECT UNIQUE ooej002,MAX(ooej003) FROM ooej_t ",
               " WHERE ooejent = '",g_enterprise,"'",
               "   AND ooej001 = '7' ",
               "   AND (ooej007 IS NULL OR ooej007 >= '",g_today,"' ) ",
               " GROUP BY ooej002 ",
               " ORDER BY ooej002 "
   PREPARE master_type_0 FROM l_sql
   DECLARE master_typecur_0 CURSOR FOR master_type_0
   #第二層的資料
   LET l_sql = "SELECT UNIQUE ooej004,MAX(ooej003) FROM ooej_t ",
               " WHERE ooejent = '",g_enterprise,"'",
               "   AND ooej001 = '7' ",
               "   AND ooej002 = ? ",
               "   AND ooej003 = ? ",
               "   AND ooej002 = ooej005 ",
               "   AND ooej004 <> ooej005 ",
               "   AND (ooej007 IS NULL OR ooej007 >= '",g_today,"' ) ",
               " GROUP BY ooej004 ",
               " ORDER BY ooej004 "
   PREPARE master_type_1 FROM l_sql
   DECLARE master_typecur_1 CURSOR FOR master_type_1
   
   INITIALIZE g_browser_root TO NULL
   #初始化l_ac
   LET l_ac = 1
   FOREACH master_typecur_0 INTO g_browser[l_ac].b_ooej002,g_browser[l_ac].b_ooej003
      #確定第一层root節點所在
      LET g_browser_root[g_browser_root.getLength()+1] = l_ac
      #此處(LV-1)
      LET g_browser[l_ac].b_ooej002 = g_browser[l_ac].b_ooej002
      LET g_browser[l_ac].b_pid = '0' CLIPPED
      LET g_browser[l_ac].b_id = l_ac USING "<<<"
      LET g_browser[l_ac].b_exp = TRUE
      LET g_browser[l_ac].b_hasC = TRUE
      LET g_browser[l_ac].b_isExp = TRUE
      #第一層節點編號
      LET l_pid = g_browser[l_ac].b_id CLIPPED
      
      LET l_ac2 = l_ac+1
      FOREACH master_typecur_1 USING g_browser[l_ac].b_ooej002,g_browser[l_ac].b_ooej003 
         INTO g_browser[l_ac2].b_ooej004,g_browser[l_ac2].b_ooej003
         
         LET g_browser[l_ac2].b_ooej002 = g_browser[l_ac].b_ooej002
         LET g_browser[l_ac2].b_ooej005 = g_browser[l_ac].b_ooej004
         LET g_browser[l_ac2].b_ooej004 = g_browser[l_ac2].b_ooej004
         LET g_browser[l_ac2].b_pid = l_pid
         LET g_browser[l_ac2].b_id = l_pid,".",l_ac2 USING "<<<"
         LET g_browser[l_ac2].b_exp = TRUE
         LET g_browser[l_ac2].b_hasC = anmi960_chk_hasC(l_ac2)
         IF g_browser[l_ac2].b_hasC = 1 THEN
            CALL anmi960_browser_detail(l_ac2)
            LET l_ac2 = g_browser.getLength()
         END IF
         LET l_ac2 = l_ac2 +1
      END FOREACH
      LET l_ac = g_browser.getLength()
   END FOREACH
   CALL g_browser.deleteElement(g_browser.getLength())
   FOR l_ac = 1 TO g_browser.getLength()
       CALL anmi960_desc_show(l_ac)
   END FOR

   LET g_browser_cnt = g_browser.getLength() - g_browser_root.getLength()

   FREE master_type_0
   FREE master_type_1
   
   FOR l_n2 = 1 TO g_browser.getLength()
      IF g_browser[l_n2].b_isExp is null THEN
         CALL anmi960_browser_detail(l_n2)
      END IF
   END FOR

   RETURN
   #end add-point
   
   CLEAR FORM
   INITIALIZE g_nmbh_m.* TO NULL
   CALL g_browser.clear()
    
   LET ls_sql = " SELECT DISTINCT nmbh004 ",
                " FROM nmbh_t ",
                "  ",
                "  ",
                " WHERE nmbhent = " ||g_enterprise|| " AND ", g_wc ,cl_sql_add_filter("nmbh_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point
   #LET g_sql = cl_sql_add_tabid(g_sql,"nmbh_t")             #WC重組           
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料             
   PREPARE browse_pre FROM ls_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   LET li_idx = 1 
   FOREACH browse_cur INTO g_browser[li_idx].b_nmbh004
      
      LET g_browser[li_idx].b_pid     = 0
      LET g_browser[li_idx].b_id      = 0, ".", li_idx USING "<<<"
      LET g_browser[li_idx].b_exp     = FALSE
      LET g_browser[li_idx].b_expcode = 1
      LET g_browser[li_idx].b_hasC    = TRUE
      LET g_browser[li_idx].b_show    = g_browser[li_idx].b_nmbh004
      CALL anmi960_desc_show(li_idx)
      LET li_idx = li_idx + 1
      
      IF li_idx > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   IF li_idx > g_max_rec AND g_error_show = 1 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = li_idx
      LET g_errparam.code   = 9035 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   LET g_error_show = 0
   
   CALL g_browser.deleteElement(g_browser.getLength())
   
   LET g_browser_cnt = g_browser.getLength()
 
   #瀏覽頁筆數顯示
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   
   #樹展開
   FOR li_idx = 1 TO g_browser.getLength()
      FOR li_idx2 = 1 TO g_browser_expand.getLength()
         IF g_browser_expand[li_idx2].b_nmbh004.equals(g_browser[li_idx].b_nmbh004)
            THEN
            CALL anmi960_browser_expand(li_idx)
            LET g_browser[li_idx].b_isExp = 1  
            LET g_browser[li_idx].b_exp = TRUE
         END IF 
      END FOR
   END FOR
   
   FREE browse_pre
   
END FUNCTION
 
#+ Tree子節點展開
PRIVATE FUNCTION anmi960_browser_expand(pi_id)
   #add-point:browser_expand段define(客製用) name="browser_expand.define_customerization"
   
   #end add-point
   DEFINE pi_id            LIKE type_t.num10
   DEFINE li_lv            LIKE type_t.num10
   DEFINE li_idx           LIKE type_t.num10
   DEFINE ls_wc            STRING
   DEFINE ls_type_list     STRING
   DEFINE ls_sql           STRING
   #add-point:browser_expand段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_expand.define"
   
   #end add-point
   
   #已經展開過或展開leaf
   IF g_browser[pi_id].b_isExp = TRUE OR g_browser[pi_id].b_expcode > (2-1) THEN
      RETURN
   END IF
   
   #leaf展開
   IF g_browser[pi_id].b_expcode = (2-1) THEN
      CALL anmi960_browser_expand_leaf(pi_id)
      RETURN
   END IF
   
   LET li_lv = g_browser[pi_id].b_expcode
   LET g_browser[pi_id].b_isExp = TRUE
   
   CASE li_lv
      WHEN 1
         LET ls_wc = " AND nmbh004 = '",g_browser[pi_id].b_nmbh004,"' "
         LET ls_type_list = "nmbh004"
      WHEN 2               
         LET ls_wc = " AND nmbh004 = '", g_browser[pi_id].b_nmbh004, "'"
         LET ls_type_list = "nmbh004"
      WHEN 3
         LET ls_wc = " AND nmbh004 = '", g_browser[pi_id].b_nmbh004, "'"
         LET ls_type_list = "nmbh004"
      WHEN 4                
         LET ls_wc = " AND nmbh004 = '", g_browser[pi_id].b_nmbh004, "'"
         LET ls_type_list = "nmbh004"
      WHEN 5
         LET ls_wc = " AND nmbh004 = '", g_browser[pi_id].b_nmbh004, "'"
         LET ls_type_list = "nmbh004"
   END CASE
   
   LET ls_sql = " SELECT DISTINCT   ", ls_type_list, 
                " FROM nmbh_t ",
                "  ",
                "  ",
                " WHERE nmbhent = " ||g_enterprise|| " AND ", g_wc, ls_wc #,cl_get_extra_cond('zzuser', 'zzgrup')
 
   LET li_lv = g_browser[pi_id].b_expcode 
    
   #add-point:browser_expand段before prepare name="browser_expand.before_prepare"
   
   #end add-point
                
   PREPARE expand_pre FROM ls_sql
   DECLARE expand_cur CURSOR FOR expand_pre
   
   LET li_idx = pi_id + 1
   CALL g_browser.insertElement(li_idx)
   FOREACH expand_cur INTO g_browser[li_idx].b_nmbh004
      LET g_browser[li_idx].b_pid     = g_browser[pi_id].b_id 
      LET g_browser[li_idx].b_id      = g_browser[pi_id].b_id , ".", li_idx USING "<<<"
      LET g_browser[li_idx].b_exp     = FALSE
      LET g_browser[li_idx].b_expcode = li_lv + 1
      LET g_browser[li_idx].b_hasC    = TRUE
      CASE li_lv
         WHEN 1
         WHEN 2
         WHEN 3
         WHEN 4
         WHEN 5
      END CASE
      CALL anmi960_desc_show(li_idx)
      LET li_idx = li_idx + 1
      CALL g_browser.insertElement(li_idx)
   END FOREACH
   
   CALL g_browser.deleteElement(li_idx)
   
   LET g_browser_cnt = g_browser.getLength()
 
   #瀏覽頁筆數顯示
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
 
END FUNCTION
 
#+ Tree leaf節點展開
PRIVATE FUNCTION anmi960_browser_expand_leaf(pi_id)
   #add-point:browser_expand_leaf段define(客製用) name="browser_expand_leaf.define_customerization"
   
   #end add-point
   DEFINE pi_id            LIKE type_t.num10
   DEFINE li_lv            LIKE type_t.num10
   DEFINE li_idx           LIKE type_t.num10
   DEFINE ls_wc            STRING
   DEFINE ls_sql           STRING
   DEFINE ls_type_list     STRING
   #add-point:browser_expand_leaf段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_expand_leaf.define"
   
   #end add-point
   
   LET ls_wc = " AND nmbh004 = '", g_browser[pi_id].b_nmbh004, "'"
 
   LET ls_sql = " SELECT DISTINCT t0.nmbh001,t0.nmbh002,t0.nmbh003,t0.nmbh004,t0.nmbh005 ",
                " FROM nmbh_t t0 ",
                "  ",
                
                " WHERE nmbhent = " ||g_enterprise|| " AND ", g_wc, ls_wc #,cl_get_extra_cond('zzuser', 'zzgrup')
 
   LET li_lv = g_browser[pi_id].b_expcode 
          
   LET ls_sql = ls_sql, " ORDER BY t0.nmbh003"
          
   #add-point:browser_expand_leaf段before prepare name="browser_expand_leaf.before_prepare"
   
   #end add-point 
          
   PREPARE leaf_pre FROM ls_sql
   DECLARE leaf_cur CURSOR FOR leaf_pre
   
   LET g_cnt = pi_id + 1
   CALL g_browser.insertElement(g_cnt)
   FOREACH leaf_cur INTO g_browser[g_cnt].b_nmbh001,g_browser[g_cnt].b_nmbh002,g_browser[g_cnt].b_nmbh003, 
       g_browser[g_cnt].b_nmbh004,g_browser[g_cnt].b_nmbh005
      LET g_browser[g_cnt].b_pid     = g_browser[pi_id].b_id 
      LET g_browser[g_cnt].b_id      = g_browser[pi_id].b_id , ".", g_cnt USING "<<<"
      LET g_browser[g_cnt].b_exp     = FALSE
      LET g_browser[g_cnt].b_expcode = li_lv + 1
      LET g_browser[g_cnt].b_hasC    = FALSE
      LET g_browser[g_cnt].b_show = g_browser[g_cnt].b_nmbh003
      CALL anmi960_desc_show(g_cnt)
      LET g_cnt = g_cnt + 1
      CALL g_browser.insertElement(g_cnt)
   END FOREACH
   
   CALL g_browser.deleteElement(g_cnt)
   
   LET g_browser_cnt = g_browser.getLength()
 
   #瀏覽頁筆數顯示
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
                      
END FUNCTION
 
#+ 組合顯示在畫面上的資訊
PRIVATE FUNCTION anmi960_desc_show(pi_ac)
   #add-point:desc_show段define (客製用) name="desc_show.define_customerization"
   
   #end add-point
   DEFINE pi_ac   LIKE type_t.num10
   DEFINE li_tmp  LIKE type_t.num10
   #add-point:desc_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="desc_show.define"
   DEFINE l_ooej004_desc LIKE type_t.chr80 
   DEFINE ls_msg         STRING
   #end add-point
   
   LET li_tmp = g_cnt
   LET g_cnt = pi_ac
   
   #add-point:desc_show段desc處理 name="desc_show.show"
   LET l_ac = pi_ac
   IF cl_null(l_ac) OR l_ac = 0 THEN
      LET l_ac = 1
   END IF
   IF cl_null(g_browser[l_ac].b_ooej004) AND cl_null(g_browser[l_ac].b_ooej005) THEN
      LET l_ooej004_desc = s_desc_get_department_desc(g_browser[l_ac].b_ooej002)
      LET ls_msg = cl_getmsg("aoo-00232",g_lang)
      IF NOT cl_null(l_ooej004_desc) AND NOT cl_null(g_browser[l_ac].b_ooej003) THEN
         LET g_browser[l_ac].b_show = g_browser[l_ac].b_ooej002,' (',l_ooej004_desc,')','(',ls_msg,g_browser[l_ac].b_ooej003,')'
      ELSE
         IF NOT cl_null(l_ooej004_desc) THEN
            LET g_browser[l_ac].b_show = g_browser[l_ac].b_ooej002,' (',l_ooej004_desc,')'
         ELSE
            IF NOT cl_null(g_browser[l_ac].b_ooej003) THEN
               LET g_browser[l_ac].b_show = g_browser[l_ac].b_ooej002,'(',ls_msg,g_browser[l_ac].b_ooej003,')'
            ELSE
               LET g_browser[l_ac].b_show = g_browser[l_ac].b_ooej002
            END IF
         END IF
      END IF
   ELSE
      LET l_ooej004_desc = s_desc_get_department_desc(g_browser[l_ac].b_ooej004)
      IF NOT cl_null(l_ooej004_desc) THEN
         LET g_browser[l_ac].b_show = g_browser[l_ac].b_ooej004,' (',l_ooej004_desc,')'
      ELSE
         LET g_browser[l_ac].b_show = g_browser[l_ac].b_ooej004
      END IF
   END IF
   #end add-point
   LET g_cnt = li_tmp
   
END FUNCTION
 
#+ 簡易快速查詢
PRIVATE FUNCTION anmi960_browser_search()
   #add-point:browser_search段define(客製用) name="browser_search.define_customerization"
   
   #END add-point
   DEFINE ls_wc       STRING   #若有輸入g_searchstr時用來代換g_wc的暫存變數
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   #IF NOT cl_null(g_searchstr) THEN
   #   LET g_wc = " nmbh002 = '",g_searchstr,"'"
   #ELSE
   #   LET g_wc = " 1=1 "
   #END IF
   #RETURN
   #END add-point
   
   IF NOT cl_null(g_searchstr) THEN
      LET ls_wc = " lower(", g_searchcol, ") LIKE '", g_searchstr, "%'"
      LET ls_wc = ls_wc.toLowerCase()
   ELSE
      LET ls_wc = " 1=1 "
   END IF
 
   LET g_wc = ls_wc
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmi960.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmi960_construct()
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
   INITIALIZE g_nmbh_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON nmbh001,nmbh002,nmbh003,nmbh004,nmbh004_desc,nmbh005,nmbh005_desc,nmbh006, 
          nmbh006_desc,nmbh007,nmbh007_desc,nmbh008,nmbh008_desc,nmbhstus,nmbhownid,nmbhowndp,nmbhcrtid, 
          nmbhcrtdp,nmbhcrtdt,nmbhmodid,nmbhmoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<nmbhcrtdt>>----
         AFTER FIELD nmbhcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<nmbhmoddt>>----
         AFTER FIELD nmbhmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmbhcnfdt>>----
         
         #----<<nmbhpstdt>>----
 
 
 
      
         #一般欄位
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh001
            #add-point:BEFORE FIELD nmbh001 name="construct.b.nmbh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh001
            
            #add-point:AFTER FIELD nmbh001 name="construct.a.nmbh001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbh001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh001
            #add-point:ON ACTION controlp INFIELD nmbh001 name="construct.c.nmbh001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh002
            #add-point:BEFORE FIELD nmbh002 name="construct.b.nmbh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh002
            
            #add-point:AFTER FIELD nmbh002 name="construct.a.nmbh002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbh002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh002
            #add-point:ON ACTION controlp INFIELD nmbh002 name="construct.c.nmbh002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh003
            #add-point:BEFORE FIELD nmbh003 name="construct.b.nmbh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh003
            
            #add-point:AFTER FIELD nmbh003 name="construct.a.nmbh003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh003
            #add-point:ON ACTION controlp INFIELD nmbh003 name="construct.c.nmbh003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh004
            #add-point:BEFORE FIELD nmbh004 name="construct.b.nmbh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh004
            
            #add-point:AFTER FIELD nmbh004 name="construct.a.nmbh004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh004
            #add-point:ON ACTION controlp INFIELD nmbh004 name="construct.c.nmbh004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh004_desc
            #add-point:BEFORE FIELD nmbh004_desc name="construct.b.nmbh004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh004_desc
            
            #add-point:AFTER FIELD nmbh004_desc name="construct.a.nmbh004_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbh004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh004_desc
            #add-point:ON ACTION controlp INFIELD nmbh004_desc name="construct.c.nmbh004_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbh005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh005
            #add-point:ON ACTION controlp INFIELD nmbh005 name="construct.c.nmbh005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmbd002_01()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbh005  #顯示到畫面上
            NEXT FIELD nmbh005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh005
            #add-point:BEFORE FIELD nmbh005 name="construct.b.nmbh005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh005
            
            #add-point:AFTER FIELD nmbh005 name="construct.a.nmbh005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh005_desc
            #add-point:BEFORE FIELD nmbh005_desc name="construct.b.nmbh005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh005_desc
            
            #add-point:AFTER FIELD nmbh005_desc name="construct.a.nmbh005_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbh005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh005_desc
            #add-point:ON ACTION controlp INFIELD nmbh005_desc name="construct.c.nmbh005_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh006
            #add-point:ON ACTION controlp INFIELD nmbh006 name="construct.c.nmbh006"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh006
            #add-point:BEFORE FIELD nmbh006 name="construct.b.nmbh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh006
            
            #add-point:AFTER FIELD nmbh006 name="construct.a.nmbh006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh006_desc
            #add-point:BEFORE FIELD nmbh006_desc name="construct.b.nmbh006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh006_desc
            
            #add-point:AFTER FIELD nmbh006_desc name="construct.a.nmbh006_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbh006_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh006_desc
            #add-point:ON ACTION controlp INFIELD nmbh006_desc name="construct.c.nmbh006_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh007
            #add-point:ON ACTION controlp INFIELD nmbh007 name="construct.c.nmbh007"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh007
            #add-point:BEFORE FIELD nmbh007 name="construct.b.nmbh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh007
            
            #add-point:AFTER FIELD nmbh007 name="construct.a.nmbh007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh007_desc
            #add-point:BEFORE FIELD nmbh007_desc name="construct.b.nmbh007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh007_desc
            
            #add-point:AFTER FIELD nmbh007_desc name="construct.a.nmbh007_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbh007_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh007_desc
            #add-point:ON ACTION controlp INFIELD nmbh007_desc name="construct.c.nmbh007_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbh008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh008
            #add-point:ON ACTION controlp INFIELD nmbh008 name="construct.c.nmbh008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbh008  #顯示到畫面上
            NEXT FIELD nmbh008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh008
            #add-point:BEFORE FIELD nmbh008 name="construct.b.nmbh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh008
            
            #add-point:AFTER FIELD nmbh008 name="construct.a.nmbh008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh008_desc
            #add-point:BEFORE FIELD nmbh008_desc name="construct.b.nmbh008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh008_desc
            
            #add-point:AFTER FIELD nmbh008_desc name="construct.a.nmbh008_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbh008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh008_desc
            #add-point:ON ACTION controlp INFIELD nmbh008_desc name="construct.c.nmbh008_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbhstus
            #add-point:BEFORE FIELD nmbhstus name="construct.b.nmbhstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbhstus
            
            #add-point:AFTER FIELD nmbhstus name="construct.a.nmbhstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbhstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbhstus
            #add-point:ON ACTION controlp INFIELD nmbhstus name="construct.c.nmbhstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbhownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbhownid
            #add-point:ON ACTION controlp INFIELD nmbhownid name="construct.c.nmbhownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbhownid  #顯示到畫面上
            NEXT FIELD nmbhownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbhownid
            #add-point:BEFORE FIELD nmbhownid name="construct.b.nmbhownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbhownid
            
            #add-point:AFTER FIELD nmbhownid name="construct.a.nmbhownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbhowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbhowndp
            #add-point:ON ACTION controlp INFIELD nmbhowndp name="construct.c.nmbhowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbhowndp  #顯示到畫面上
            NEXT FIELD nmbhowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbhowndp
            #add-point:BEFORE FIELD nmbhowndp name="construct.b.nmbhowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbhowndp
            
            #add-point:AFTER FIELD nmbhowndp name="construct.a.nmbhowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbhcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbhcrtid
            #add-point:ON ACTION controlp INFIELD nmbhcrtid name="construct.c.nmbhcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbhcrtid  #顯示到畫面上
            NEXT FIELD nmbhcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbhcrtid
            #add-point:BEFORE FIELD nmbhcrtid name="construct.b.nmbhcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbhcrtid
            
            #add-point:AFTER FIELD nmbhcrtid name="construct.a.nmbhcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbhcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbhcrtdp
            #add-point:ON ACTION controlp INFIELD nmbhcrtdp name="construct.c.nmbhcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbhcrtdp  #顯示到畫面上
            NEXT FIELD nmbhcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbhcrtdp
            #add-point:BEFORE FIELD nmbhcrtdp name="construct.b.nmbhcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbhcrtdp
            
            #add-point:AFTER FIELD nmbhcrtdp name="construct.a.nmbhcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbhcrtdt
            #add-point:BEFORE FIELD nmbhcrtdt name="construct.b.nmbhcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbhmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbhmodid
            #add-point:ON ACTION controlp INFIELD nmbhmodid name="construct.c.nmbhmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbhmodid  #顯示到畫面上
            NEXT FIELD nmbhmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbhmodid
            #add-point:BEFORE FIELD nmbhmodid name="construct.b.nmbhmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbhmodid
            
            #add-point:AFTER FIELD nmbhmodid name="construct.a.nmbhmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbhmoddt
            #add-point:BEFORE FIELD nmbhmoddt name="construct.b.nmbhmoddt"
            
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
 
{<section id="anmi960.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION anmi960_query()
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
 
   INITIALIZE g_nmbh_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL anmi960_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL anmi960_browser_fill(g_wc,"F")
      CALL anmi960_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
      CALL g_browser_expand.clear()
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL anmi960_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL anmi960_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="anmi960.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION anmi960_fetch(p_fl)
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
   
   #樹狀管控(action)
   IF g_browser[g_current_idx].b_expcode <> "2" THEN
      INITIALIZE g_nmbh_m.* TO NULL
      DISPLAY BY NAME g_nmbh_m.*
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
      RETURN
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
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
   LET g_nmbh_m.nmbh001 = g_browser[g_current_idx].b_nmbh001
   LET g_nmbh_m.nmbh002 = g_browser[g_current_idx].b_nmbh002
   LET g_nmbh_m.nmbh003 = g_browser[g_current_idx].b_nmbh003
   LET g_nmbh_m.nmbh004 = g_browser[g_current_idx].b_nmbh004
   LET g_nmbh_m.nmbh005 = g_browser[g_current_idx].b_nmbh005
 
                       
   #讀取單頭所有欄位資料
   EXECUTE anmi960_master_referesh USING g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004, 
       g_nmbh_m.nmbh005 INTO g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh005, 
       g_nmbh_m.nmbh006,g_nmbh_m.nmbh007,g_nmbh_m.nmbh008,g_nmbh_m.nmbhstus,g_nmbh_m.nmbhownid,g_nmbh_m.nmbhowndp, 
       g_nmbh_m.nmbhcrtid,g_nmbh_m.nmbhcrtdp,g_nmbh_m.nmbhcrtdt,g_nmbh_m.nmbhmodid,g_nmbh_m.nmbhmoddt, 
       g_nmbh_m.nmbhownid_desc,g_nmbh_m.nmbhowndp_desc,g_nmbh_m.nmbhcrtid_desc,g_nmbh_m.nmbhcrtdp_desc, 
       g_nmbh_m.nmbhmodid_desc
   
   #遮罩相關處理
   LET g_nmbh_m_mask_o.* =  g_nmbh_m.*
   CALL anmi960_nmbh_t_mask()
   LET g_nmbh_m_mask_n.* =  g_nmbh_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL anmi960_set_act_visible()
   CALL anmi960_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_nmbh_m_t.* = g_nmbh_m.*
   LET g_nmbh_m_o.* = g_nmbh_m.*
   
   LET g_data_owner = g_nmbh_m.nmbhownid      
   LET g_data_dept  = g_nmbh_m.nmbhowndp
   
   #重新顯示
   CALL anmi960_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="anmi960.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmi960_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_nmbh_m.* TO NULL             #DEFAULT 設定
   LET g_nmbh001_t = NULL
   LET g_nmbh002_t = NULL
   LET g_nmbh003_t = NULL
   LET g_nmbh004_t = NULL
   LET g_nmbh005_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      #應用 a55 樣板自動產生(Version:3)
      #六階樹狀給值
      LET g_current_idx = g_curr_diag.getCurrentRow("s_browse")
      IF g_current_idx > 0 THEN
         IF NOT cl_null(g_browser[g_current_idx].b_show) THEN
            LET g_nmbh_m.nmbh004 = g_browser[g_current_idx].b_nmbh004
         END IF
      END IF
 
 
 
 
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmbh_m.nmbhownid = g_user
      LET g_nmbh_m.nmbhowndp = g_dept
      LET g_nmbh_m.nmbhcrtid = g_user
      LET g_nmbh_m.nmbhcrtdp = g_dept 
      LET g_nmbh_m.nmbhcrtdt = cl_get_current()
      LET g_nmbh_m.nmbhmodid = g_user
      LET g_nmbh_m.nmbhmoddt = cl_get_current()
      LET g_nmbh_m.nmbhstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_nmbh_m.nmbh001 = "7"
      LET g_nmbh_m.nmbhstus = "Y"
 
 
      #add-point:單頭預設值 name="insert.default"
      #版本
      SELECT ooej003 INTO g_nmbh_m.nmbh002
        FROM ooej_t
       WHERE ooejent = g_enterprise
         AND ooej001 = '7'
      
      SELECT UNIQUE nmbd001 INTO g_nmbh_m.nmbh003
        FROM nmbd_t
       WHERE nmbdent = g_enterprise
         AND nmbd005='Y'
     #CALL anmi960_tree_refresh()
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmbh_m.nmbhstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL anmi960_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
     #CALL anmi960_browser_fill(g_wc,"")
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_nmbh_m.* TO NULL
         CALL anmi960_show()
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
   CALL anmi960_set_act_visible()
   CALL anmi960_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_nmbh001_t = g_nmbh_m.nmbh001
   LET g_nmbh002_t = g_nmbh_m.nmbh002
   LET g_nmbh003_t = g_nmbh_m.nmbh003
   LET g_nmbh004_t = g_nmbh_m.nmbh004
   LET g_nmbh005_t = g_nmbh_m.nmbh005
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmbhent = " ||g_enterprise|| " AND",
                      " nmbh001 = '", g_nmbh_m.nmbh001, "' "
                      ," AND nmbh002 = '", g_nmbh_m.nmbh002, "' "
                      ," AND nmbh003 = '", g_nmbh_m.nmbh003, "' "
                      ," AND nmbh004 = '", g_nmbh_m.nmbh004, "' "
                      ," AND nmbh005 = '", g_nmbh_m.nmbh005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE anmi960_master_referesh USING g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004, 
       g_nmbh_m.nmbh005 INTO g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh005, 
       g_nmbh_m.nmbh006,g_nmbh_m.nmbh007,g_nmbh_m.nmbh008,g_nmbh_m.nmbhstus,g_nmbh_m.nmbhownid,g_nmbh_m.nmbhowndp, 
       g_nmbh_m.nmbhcrtid,g_nmbh_m.nmbhcrtdp,g_nmbh_m.nmbhcrtdt,g_nmbh_m.nmbhmodid,g_nmbh_m.nmbhmoddt, 
       g_nmbh_m.nmbhownid_desc,g_nmbh_m.nmbhowndp_desc,g_nmbh_m.nmbhcrtid_desc,g_nmbh_m.nmbhcrtdp_desc, 
       g_nmbh_m.nmbhmodid_desc
   
   
   #遮罩相關處理
   LET g_nmbh_m_mask_o.* =  g_nmbh_m.*
   CALL anmi960_nmbh_t_mask()
   LET g_nmbh_m_mask_n.* =  g_nmbh_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh004_desc, 
       g_nmbh_m.nmbh005,g_nmbh_m.nmbh005_desc,g_nmbh_m.nmbh006,g_nmbh_m.nmbh006_desc,g_nmbh_m.nmbh007, 
       g_nmbh_m.nmbh007_desc,g_nmbh_m.nmbh008,g_nmbh_m.nmbh008_desc,g_nmbh_m.nmbhstus,g_nmbh_m.nmbhownid, 
       g_nmbh_m.nmbhownid_desc,g_nmbh_m.nmbhowndp,g_nmbh_m.nmbhowndp_desc,g_nmbh_m.nmbhcrtid,g_nmbh_m.nmbhcrtid_desc, 
       g_nmbh_m.nmbhcrtdp,g_nmbh_m.nmbhcrtdp_desc,g_nmbh_m.nmbhcrtdt,g_nmbh_m.nmbhmodid,g_nmbh_m.nmbhmodid_desc, 
       g_nmbh_m.nmbhmoddt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_nmbh_m.nmbhownid      
   LET g_data_dept  = g_nmbh_m.nmbhowndp
 
   #功能已完成,通報訊息中心
   CALL anmi960_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="anmi960.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmi960_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_nmbh_m.nmbh001 IS NULL
 
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
   LET g_nmbh001_t = g_nmbh_m.nmbh001
   LET g_nmbh002_t = g_nmbh_m.nmbh002
   LET g_nmbh003_t = g_nmbh_m.nmbh003
   LET g_nmbh004_t = g_nmbh_m.nmbh004
   LET g_nmbh005_t = g_nmbh_m.nmbh005
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN anmi960_cl USING g_enterprise,g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh005
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmi960_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE anmi960_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmi960_master_referesh USING g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004, 
       g_nmbh_m.nmbh005 INTO g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh005, 
       g_nmbh_m.nmbh006,g_nmbh_m.nmbh007,g_nmbh_m.nmbh008,g_nmbh_m.nmbhstus,g_nmbh_m.nmbhownid,g_nmbh_m.nmbhowndp, 
       g_nmbh_m.nmbhcrtid,g_nmbh_m.nmbhcrtdp,g_nmbh_m.nmbhcrtdt,g_nmbh_m.nmbhmodid,g_nmbh_m.nmbhmoddt, 
       g_nmbh_m.nmbhownid_desc,g_nmbh_m.nmbhowndp_desc,g_nmbh_m.nmbhcrtid_desc,g_nmbh_m.nmbhcrtdp_desc, 
       g_nmbh_m.nmbhmodid_desc
 
   #檢查是否允許此動作
   IF NOT anmi960_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_nmbh_m_mask_o.* =  g_nmbh_m.*
   CALL anmi960_nmbh_t_mask()
   LET g_nmbh_m_mask_n.* =  g_nmbh_m.*
   
   
 
   #顯示資料
   CALL anmi960_show()
   
   WHILE TRUE
      LET g_nmbh_m.nmbh001 = g_nmbh001_t
      LET g_nmbh_m.nmbh002 = g_nmbh002_t
      LET g_nmbh_m.nmbh003 = g_nmbh003_t
      LET g_nmbh_m.nmbh004 = g_nmbh004_t
      LET g_nmbh_m.nmbh005 = g_nmbh005_t
 
      
      #寫入修改者/修改日期資訊
      LET g_nmbh_m.nmbhmodid = g_user 
LET g_nmbh_m.nmbhmoddt = cl_get_current()
LET g_nmbh_m.nmbhmodid_desc = cl_get_username(g_nmbh_m.nmbhmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      LET g_nmbh006_t = g_nmbh_m.nmbh006
      LET g_nmbh007_t = g_nmbh_m.nmbh007
      LET g_nmbh008_t = g_nmbh_m.nmbh008
      #end add-point
 
      #資料輸入
      CALL anmi960_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_nmbh_m.* = g_nmbh_m_t.*
         CALL anmi960_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE nmbh_t SET (nmbhmodid,nmbhmoddt) = (g_nmbh_m.nmbhmodid,g_nmbh_m.nmbhmoddt)
       WHERE nmbhent = g_enterprise AND nmbh001 = g_nmbh001_t
         AND nmbh002 = g_nmbh002_t
         AND nmbh003 = g_nmbh003_t
         AND nmbh004 = g_nmbh004_t
         AND nmbh005 = g_nmbh005_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL anmi960_set_act_visible()
   CALL anmi960_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " nmbhent = " ||g_enterprise|| " AND",
                      " nmbh001 = '", g_nmbh_m.nmbh001, "' "
                      ," AND nmbh002 = '", g_nmbh_m.nmbh002, "' "
                      ," AND nmbh003 = '", g_nmbh_m.nmbh003, "' "
                      ," AND nmbh004 = '", g_nmbh_m.nmbh004, "' "
                      ," AND nmbh005 = '", g_nmbh_m.nmbh005, "' "
 
   #填到對應位置
   CALL anmi960_browser_fill(g_wc,"")
 
   CLOSE anmi960_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmi960_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="anmi960.input" >}
#+ 資料輸入
PRIVATE FUNCTION anmi960_input(p_cmd)
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
   CALL gfrm_curr.setElementHidden("mainlayout",0)
   CALL gfrm_curr.setElementImage("mainhidden","small/arr-u.png")
   LET g_main_hidden = 1
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh004_desc, 
       g_nmbh_m.nmbh005,g_nmbh_m.nmbh005_desc,g_nmbh_m.nmbh006,g_nmbh_m.nmbh006_desc,g_nmbh_m.nmbh007, 
       g_nmbh_m.nmbh007_desc,g_nmbh_m.nmbh008,g_nmbh_m.nmbh008_desc,g_nmbh_m.nmbhstus,g_nmbh_m.nmbhownid, 
       g_nmbh_m.nmbhownid_desc,g_nmbh_m.nmbhowndp,g_nmbh_m.nmbhowndp_desc,g_nmbh_m.nmbhcrtid,g_nmbh_m.nmbhcrtid_desc, 
       g_nmbh_m.nmbhcrtdp,g_nmbh_m.nmbhcrtdp_desc,g_nmbh_m.nmbhcrtdt,g_nmbh_m.nmbhmodid,g_nmbh_m.nmbhmodid_desc, 
       g_nmbh_m.nmbhmoddt
   
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
   CALL anmi960_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL anmi960_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh005, 
          g_nmbh_m.nmbh006,g_nmbh_m.nmbh007,g_nmbh_m.nmbh008,g_nmbh_m.nmbhstus 
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
         BEFORE FIELD nmbh001
            #add-point:BEFORE FIELD nmbh001 name="input.b.nmbh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh001
            
            #add-point:AFTER FIELD nmbh001 name="input.a.nmbh001"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbh001
            #add-point:ON CHANGE nmbh001 name="input.g.nmbh001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh002
            #add-point:BEFORE FIELD nmbh002 name="input.b.nmbh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh002
            
            #add-point:AFTER FIELD nmbh002 name="input.a.nmbh002"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbh002
            #add-point:ON CHANGE nmbh002 name="input.g.nmbh002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh003
            #add-point:BEFORE FIELD nmbh003 name="input.b.nmbh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh003
            
            #add-point:AFTER FIELD nmbh003 name="input.a.nmbh003"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbh003
            #add-point:ON CHANGE nmbh003 name="input.g.nmbh003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh004
            
            #add-point:AFTER FIELD nmbh004 name="input.a.nmbh004"
            #資金計劃組織代碼
            LET g_nmbh_m.nmbh004_desc = ''
            IF NOT cl_null(g_nmbh_m.nmbh004) THEN 
               IF p_cmd = 'a' THEN 
                  CALL anmi960_nmbh005_chk(g_nmbh_m.nmbh004)RETURNING g_sub_success,g_errno  #150715-00014#1 修改檢核條件
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmbh_m.nmbh004 = g_nmbh004_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_nmbh_m.nmbh004) RETURNING g_nmbh_m.nmbh004_desc
            DISPLAY BY NAME g_nmbh_m.nmbh004_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh004
            #add-point:BEFORE FIELD nmbh004 name="input.b.nmbh004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbh004
            #add-point:ON CHANGE nmbh004 name="input.g.nmbh004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh005
            
            #add-point:AFTER FIELD nmbh005 name="input.a.nmbh005"
            #收支項目代碼
            LET g_nmbh_m.nmbh005_desc = ''
            IF NOT cl_null(g_nmbh_m.nmbh005) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmbh_m.nmbh005 != g_nmbh005_t)) THEN    #160822-00012#5   mark
               IF g_nmbh_m.nmbh005 != g_nmbh_m_o.nmbh005 OR cl_null(g_nmbh_m_o.nmbh005) THEN   #160822-00012#5    add
                  INITIALIZE g_chkparam.* TO NULL
                  CALL s_anm_nmbd002_chk(g_nmbh_m.nmbh005)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_nmbh_m.nmbh005 = g_nmbh005_t         #160822-00012#5   mark
                     LET g_nmbh_m.nmbh005 = g_nmbh_m_o.nmbh005   #160822-00012#5   add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_nmbd002_desc(g_nmbh_m.nmbh003,g_nmbh_m.nmbh005) RETURNING g_nmbh_m.nmbh005_desc
            DISPLAY BY NAME g_nmbh_m.nmbh005_desc
            LET g_nmbh_m_o.* = g_nmbh_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh005
            #add-point:BEFORE FIELD nmbh005 name="input.b.nmbh005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbh005
            #add-point:ON CHANGE nmbh005 name="input.g.nmbh005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh006
            
            #add-point:AFTER FIELD nmbh006 name="input.a.nmbh006"
            #編製單位代碼
            LET g_nmbh_m.nmbh006_desc = ''
            IF NOT cl_null(g_nmbh_m.nmbh006) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmbh_m.nmbh006 != g_nmbh006_t)) THEN    #160822-00012#5   mark
               IF g_nmbh_m.nmbh006 != g_nmbh_m_o.nmbh006 OR cl_null(g_nmbh_m_o.nmbh006) THEN   #160822-00012#5    add 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_nmbh_m.nmbh006
                  #160318-00025#45  2016/04/26  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#45  2016/04/26  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     #LET g_nmbh_m.nmbh006 = g_nmbh006_t         #160822-00012#5   mark
                     LET g_nmbh_m.nmbh006 = g_nmbh_m_o.nmbh006   #160822-00012#5   add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_nmbh_m.nmbh006) RETURNING g_nmbh_m.nmbh006_desc
            DISPLAY BY NAME g_nmbh_m.nmbh006_desc
            LET g_nmbh_m_o.* = g_nmbh_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh006
            #add-point:BEFORE FIELD nmbh006 name="input.b.nmbh006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbh006
            #add-point:ON CHANGE nmbh006 name="input.g.nmbh006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh007
            
            #add-point:AFTER FIELD nmbh007 name="input.a.nmbh007"
            #審批單位代碼
            LET g_nmbh_m.nmbh007_desc = ''
            IF NOT cl_null(g_nmbh_m.nmbh007) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmbh_m.nmbh007 != g_nmbh007_t)) THEN    #160822-00012#5   mark
               IF g_nmbh_m.nmbh007 != g_nmbh_m_o.nmbh007 OR cl_null(g_nmbh_m_o.nmbh007) THEN   #160822-00012#5    add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_nmbh_m.nmbh007
                  #160318-00025#45  2016/04/26  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#45  2016/04/26  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     #LET g_nmbh_m.nmbh007 = g_nmbh007_t         #160822-00012#5   mark
                     LET g_nmbh_m.nmbh007 = g_nmbh_m_o.nmbh007   #160822-00012#5   add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_nmbh_m.nmbh007) RETURNING g_nmbh_m.nmbh007_desc
            DISPLAY BY NAME g_nmbh_m.nmbh007_desc
            LET g_nmbh_m_o.* = g_nmbh_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh007
            #add-point:BEFORE FIELD nmbh007 name="input.b.nmbh007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbh007
            #add-point:ON CHANGE nmbh007 name="input.g.nmbh007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbh008
            
            #add-point:AFTER FIELD nmbh008 name="input.a.nmbh008"
            #變更單位代碼
            LET g_nmbh_m.nmbh008_desc = ''
            IF NOT cl_null(g_nmbh_m.nmbh008) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmbh_m.nmbh008 != g_nmbh008_t)) THEN    #160822-00012#5   mark
               IF g_nmbh_m.nmbh008 != g_nmbh_m_o.nmbh008 OR cl_null(g_nmbh_m_o.nmbh008) THEN   #160822-00012#5    add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_nmbh_m.nmbh008
                  #160318-00025#45  2016/04/26  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#45  2016/04/26  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     #LET g_nmbh_m.nmbh008 = g_nmbh008_t         #160822-00012#5   mark
                     LET g_nmbh_m.nmbh008 = g_nmbh_m_o.nmbh008   #160822-00012#5   add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_nmbh_m.nmbh008) RETURNING g_nmbh_m.nmbh008_desc
            DISPLAY BY NAME g_nmbh_m.nmbh008_desc
            LET g_nmbh_m_o.* = g_nmbh_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbh008
            #add-point:BEFORE FIELD nmbh008 name="input.b.nmbh008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbh008
            #add-point:ON CHANGE nmbh008 name="input.g.nmbh008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbhstus
            #add-point:BEFORE FIELD nmbhstus name="input.b.nmbhstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbhstus
            
            #add-point:AFTER FIELD nmbhstus name="input.a.nmbhstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbhstus
            #add-point:ON CHANGE nmbhstus name="input.g.nmbhstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmbh001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh001
            #add-point:ON ACTION controlp INFIELD nmbh001 name="input.c.nmbh001"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbh002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh002
            #add-point:ON ACTION controlp INFIELD nmbh002 name="input.c.nmbh002"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh003
            #add-point:ON ACTION controlp INFIELD nmbh003 name="input.c.nmbh003"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh004
            #add-point:ON ACTION controlp INFIELD nmbh004 name="input.c.nmbh004"
 
            #END add-point
 
 
         #Ctrlp:input.c.nmbh005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh005
            #add-point:ON ACTION controlp INFIELD nmbh005 name="input.c.nmbh005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbh_m.nmbh005      #給予default值
            CALL q_nmbd002_01()                             #呼叫開窗
            LET g_nmbh_m.nmbh003 = g_qryparam.return1       #將開窗取得的值回傳到變數
            LET g_nmbh_m.nmbh005 = g_qryparam.return2       #將開窗取得的值回傳到變數
            DISPLAY g_nmbh_m.nmbh005 TO nmbh005             #顯示到畫面上
            CALL s_desc_get_nmbd002_desc(g_nmbh_m.nmbh003,g_nmbh_m.nmbh005) RETURNING g_nmbh_m.nmbh005_desc
            DISPLAY BY NAME g_nmbh_m.nmbh005_desc
            NEXT FIELD nmbh005                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.nmbh006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh006
            #add-point:ON ACTION controlp INFIELD nmbh006 name="input.c.nmbh006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef206 = 'Y' "
            LET g_qryparam.default1 = g_nmbh_m.nmbh006      #給予default值
            CALL q_ooef001()                                #呼叫開窗
            LET g_nmbh_m.nmbh006 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_nmbh_m.nmbh006 TO nmbh006             #顯示到畫面上
            CALL s_desc_get_department_desc(g_nmbh_m.nmbh006) RETURNING g_nmbh_m.nmbh006_desc
            DISPLAY BY NAME g_nmbh_m.nmbh006_desc
            NEXT FIELD nmbh006                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.nmbh007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh007
            #add-point:ON ACTION controlp INFIELD nmbh007 name="input.c.nmbh007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef206 = 'Y' "
            LET g_qryparam.default1 = g_nmbh_m.nmbh007      #給予default值
            CALL q_ooef001()                                #呼叫開窗
            LET g_nmbh_m.nmbh007 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_nmbh_m.nmbh007 TO nmbh007             #顯示到畫面上
            CALL s_desc_get_department_desc(g_nmbh_m.nmbh007) RETURNING g_nmbh_m.nmbh007_desc
            DISPLAY BY NAME g_nmbh_m.nmbh007_desc
            NEXT FIELD nmbh007                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.nmbh008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbh008
            #add-point:ON ACTION controlp INFIELD nmbh008 name="input.c.nmbh008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef206 = 'Y' "
            LET g_qryparam.default1 = g_nmbh_m.nmbh008      #給予default值
            CALL q_ooef001()                                #呼叫開窗
            LET g_nmbh_m.nmbh008 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_nmbh_m.nmbh008 TO nmbh008             #顯示到畫面上
            CALL s_desc_get_department_desc(g_nmbh_m.nmbh008) RETURNING g_nmbh_m.nmbh008_desc
            DISPLAY BY NAME g_nmbh_m.nmbh008_desc
            NEXT FIELD nmbh008                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.nmbhstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbhstus
            #add-point:ON ACTION controlp INFIELD nmbhstus name="input.c.nmbhstus"
            
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
               SELECT COUNT(1) INTO l_count FROM nmbh_t
                WHERE nmbhent = g_enterprise AND nmbh001 = g_nmbh_m.nmbh001
                  AND nmbh002 = g_nmbh_m.nmbh002
                  AND nmbh003 = g_nmbh_m.nmbh003
                  AND nmbh004 = g_nmbh_m.nmbh004
                  AND nmbh005 = g_nmbh_m.nmbh005
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO nmbh_t (nmbhent,nmbh001,nmbh002,nmbh003,nmbh004,nmbh005,nmbh006,nmbh007, 
                      nmbh008,nmbhstus,nmbhownid,nmbhowndp,nmbhcrtid,nmbhcrtdp,nmbhcrtdt,nmbhmodid,nmbhmoddt) 
 
                  VALUES (g_enterprise,g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004, 
                      g_nmbh_m.nmbh005,g_nmbh_m.nmbh006,g_nmbh_m.nmbh007,g_nmbh_m.nmbh008,g_nmbh_m.nmbhstus, 
                      g_nmbh_m.nmbhownid,g_nmbh_m.nmbhowndp,g_nmbh_m.nmbhcrtid,g_nmbh_m.nmbhcrtdp,g_nmbh_m.nmbhcrtdt, 
                      g_nmbh_m.nmbhmodid,g_nmbh_m.nmbhmoddt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbh_t:",SQLERRMESSAGE 
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
                  LET g_errparam.extend = g_nmbh_m.nmbh001
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL anmi960_nmbh_t_mask_restore('restore_mask_o')
               
               UPDATE nmbh_t SET (nmbh001,nmbh002,nmbh003,nmbh004,nmbh005,nmbh006,nmbh007,nmbh008,nmbhstus, 
                   nmbhownid,nmbhowndp,nmbhcrtid,nmbhcrtdp,nmbhcrtdt,nmbhmodid,nmbhmoddt) = (g_nmbh_m.nmbh001, 
                   g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh005,g_nmbh_m.nmbh006, 
                   g_nmbh_m.nmbh007,g_nmbh_m.nmbh008,g_nmbh_m.nmbhstus,g_nmbh_m.nmbhownid,g_nmbh_m.nmbhowndp, 
                   g_nmbh_m.nmbhcrtid,g_nmbh_m.nmbhcrtdp,g_nmbh_m.nmbhcrtdt,g_nmbh_m.nmbhmodid,g_nmbh_m.nmbhmoddt) 
 
                WHERE nmbhent = g_enterprise AND nmbh001 = g_nmbh001_t #
                  AND nmbh002 = g_nmbh002_t
                  AND nmbh003 = g_nmbh003_t
                  AND nmbh004 = g_nmbh004_t
                  AND nmbh005 = g_nmbh005_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbh_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbh_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL anmi960_nmbh_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_nmbh_m_t)
                     LET g_log2 = util.JSON.stringify(g_nmbh_m)
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
 
{<section id="anmi960.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION anmi960_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE nmbh_t.nmbh001 
   DEFINE l_oldno     LIKE nmbh_t.nmbh001 
   DEFINE l_newno02     LIKE nmbh_t.nmbh002 
   DEFINE l_oldno02     LIKE nmbh_t.nmbh002 
   DEFINE l_newno03     LIKE nmbh_t.nmbh003 
   DEFINE l_oldno03     LIKE nmbh_t.nmbh003 
   DEFINE l_newno04     LIKE nmbh_t.nmbh004 
   DEFINE l_oldno04     LIKE nmbh_t.nmbh004 
   DEFINE l_newno05     LIKE nmbh_t.nmbh005 
   DEFINE l_oldno05     LIKE nmbh_t.nmbh005 
 
   DEFINE l_master    RECORD LIKE nmbh_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_nmbh_m.nmbh001 IS NULL
      OR g_nmbh_m.nmbh002 IS NULL
      OR g_nmbh_m.nmbh003 IS NULL
      OR g_nmbh_m.nmbh004 IS NULL
      OR g_nmbh_m.nmbh005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_nmbh001_t = g_nmbh_m.nmbh001
   LET g_nmbh002_t = g_nmbh_m.nmbh002
   LET g_nmbh003_t = g_nmbh_m.nmbh003
   LET g_nmbh004_t = g_nmbh_m.nmbh004
   LET g_nmbh005_t = g_nmbh_m.nmbh005
 
   
   #清空key值
   LET g_nmbh_m.nmbh001 = ""
   LET g_nmbh_m.nmbh002 = ""
   LET g_nmbh_m.nmbh003 = ""
   LET g_nmbh_m.nmbh004 = ""
   LET g_nmbh_m.nmbh005 = ""
 
    
   CALL anmi960_set_entry("a")
   CALL anmi960_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmbh_m.nmbhownid = g_user
      LET g_nmbh_m.nmbhowndp = g_dept
      LET g_nmbh_m.nmbhcrtid = g_user
      LET g_nmbh_m.nmbhcrtdp = g_dept 
      LET g_nmbh_m.nmbhcrtdt = cl_get_current()
      LET g_nmbh_m.nmbhmodid = g_user
      LET g_nmbh_m.nmbhmoddt = cl_get_current()
      LET g_nmbh_m.nmbhstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #150715-00014#1-----s
   #複製功能
   LET g_nmbh_m.nmbh001 = "7"
   SELECT ooej003 INTO g_nmbh_m.nmbh002
     FROM ooej_t
    WHERE ooejent = g_enterprise
      AND ooej001 = '7'
      
   SELECT UNIQUE nmbd001 INTO g_nmbh_m.nmbh003
     FROM nmbd_t
    WHERE nmbdent = g_enterprise
      AND nmbd005='Y'
   #150715-00014#1-----e
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmbh_m.nmbhstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_nmbh_m.nmbh004_desc = ''
   DISPLAY BY NAME g_nmbh_m.nmbh004_desc
   LET g_nmbh_m.nmbh005_desc = ''
   DISPLAY BY NAME g_nmbh_m.nmbh005_desc
 
   
   #資料輸入
   CALL anmi960_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_nmbh_m.* TO NULL
      CALL anmi960_show()
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
      LET g_errparam.extend = "nmbh_t:",SQLERRMESSAGE 
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
   CALL anmi960_set_act_visible()
   CALL anmi960_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_nmbh001_t = g_nmbh_m.nmbh001
   LET g_nmbh002_t = g_nmbh_m.nmbh002
   LET g_nmbh003_t = g_nmbh_m.nmbh003
   LET g_nmbh004_t = g_nmbh_m.nmbh004
   LET g_nmbh005_t = g_nmbh_m.nmbh005
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmbhent = " ||g_enterprise|| " AND",
                      " nmbh001 = '", g_nmbh_m.nmbh001, "' "
                      ," AND nmbh002 = '", g_nmbh_m.nmbh002, "' "
                      ," AND nmbh003 = '", g_nmbh_m.nmbh003, "' "
                      ," AND nmbh004 = '", g_nmbh_m.nmbh004, "' "
                      ," AND nmbh005 = '", g_nmbh_m.nmbh005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_nmbh_m.nmbhownid      
   LET g_data_dept  = g_nmbh_m.nmbhowndp
              
   #功能已完成,通報訊息中心
   CALL anmi960_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="anmi960.show" >}
#+ 資料顯示 
PRIVATE FUNCTION anmi960_show()
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
   CALL anmi960_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL s_desc_get_department_desc(g_nmbh_m.nmbh004) RETURNING g_nmbh_m.nmbh004_desc
   CALL s_desc_get_nmbd002_desc(g_nmbh_m.nmbh003,g_nmbh_m.nmbh005) RETURNING g_nmbh_m.nmbh005_desc
   CALL s_desc_get_department_desc(g_nmbh_m.nmbh006) RETURNING g_nmbh_m.nmbh006_desc
   CALL s_desc_get_department_desc(g_nmbh_m.nmbh007) RETURNING g_nmbh_m.nmbh007_desc
   CALL s_desc_get_department_desc(g_nmbh_m.nmbh008) RETURNING g_nmbh_m.nmbh008_desc
   DISPLAY BY NAME g_nmbh_m.nmbh004_desc,g_nmbh_m.nmbh005_desc,g_nmbh_m.nmbh006_desc,g_nmbh_m.nmbh007_desc,g_nmbh_m.nmbh008_desc
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh004_desc, 
       g_nmbh_m.nmbh005,g_nmbh_m.nmbh005_desc,g_nmbh_m.nmbh006,g_nmbh_m.nmbh006_desc,g_nmbh_m.nmbh007, 
       g_nmbh_m.nmbh007_desc,g_nmbh_m.nmbh008,g_nmbh_m.nmbh008_desc,g_nmbh_m.nmbhstus,g_nmbh_m.nmbhownid, 
       g_nmbh_m.nmbhownid_desc,g_nmbh_m.nmbhowndp,g_nmbh_m.nmbhowndp_desc,g_nmbh_m.nmbhcrtid,g_nmbh_m.nmbhcrtid_desc, 
       g_nmbh_m.nmbhcrtdp,g_nmbh_m.nmbhcrtdp_desc,g_nmbh_m.nmbhcrtdt,g_nmbh_m.nmbhmodid,g_nmbh_m.nmbhmodid_desc, 
       g_nmbh_m.nmbhmoddt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL anmi960_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmbh_m.nmbhstus 
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
 
{<section id="anmi960.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION anmi960_delete()
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
   IF g_nmbh_m.nmbh001 IS NULL
   OR g_nmbh_m.nmbh002 IS NULL
   OR g_nmbh_m.nmbh003 IS NULL
   OR g_nmbh_m.nmbh004 IS NULL
   OR g_nmbh_m.nmbh005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_nmbh001_t = g_nmbh_m.nmbh001
   LET g_nmbh002_t = g_nmbh_m.nmbh002
   LET g_nmbh003_t = g_nmbh_m.nmbh003
   LET g_nmbh004_t = g_nmbh_m.nmbh004
   LET g_nmbh005_t = g_nmbh_m.nmbh005
 
   
   
 
   OPEN anmi960_cl USING g_enterprise,g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh005
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmi960_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE anmi960_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmi960_master_referesh USING g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004, 
       g_nmbh_m.nmbh005 INTO g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh005, 
       g_nmbh_m.nmbh006,g_nmbh_m.nmbh007,g_nmbh_m.nmbh008,g_nmbh_m.nmbhstus,g_nmbh_m.nmbhownid,g_nmbh_m.nmbhowndp, 
       g_nmbh_m.nmbhcrtid,g_nmbh_m.nmbhcrtdp,g_nmbh_m.nmbhcrtdt,g_nmbh_m.nmbhmodid,g_nmbh_m.nmbhmoddt, 
       g_nmbh_m.nmbhownid_desc,g_nmbh_m.nmbhowndp_desc,g_nmbh_m.nmbhcrtid_desc,g_nmbh_m.nmbhcrtdp_desc, 
       g_nmbh_m.nmbhmodid_desc
   
   
   #檢查是否允許此動作
   IF NOT anmi960_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmbh_m_mask_o.* =  g_nmbh_m.*
   CALL anmi960_nmbh_t_mask()
   LET g_nmbh_m_mask_n.* =  g_nmbh_m.*
   
   #將最新資料顯示到畫面上
   CALL anmi960_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmi960_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM nmbh_t 
       WHERE nmbhent = g_enterprise AND nmbh001 = g_nmbh_m.nmbh001 
         AND nmbh002 = g_nmbh_m.nmbh002 
         AND nmbh003 = g_nmbh_m.nmbh003 
         AND nmbh004 = g_nmbh_m.nmbh004 
         AND nmbh005 = g_nmbh_m.nmbh005 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      CALL anmi960_browser_fill(" 1=1 ","F")
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_nmbh_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE anmi960_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL anmi960_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         CALL anmi960_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE anmi960_cl
 
   #功能已完成,通報訊息中心
   CALL anmi960_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmi960.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION anmi960_ui_browser_refresh()
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
      IF g_browser[l_i].b_nmbh001 = g_nmbh_m.nmbh001
         AND g_browser[l_i].b_nmbh002 = g_nmbh_m.nmbh002
         AND g_browser[l_i].b_nmbh003 = g_nmbh_m.nmbh003
         AND g_browser[l_i].b_nmbh004 = g_nmbh_m.nmbh004
         AND g_browser[l_i].b_nmbh005 = g_nmbh_m.nmbh005
 
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
 
{<section id="anmi960.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION anmi960_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("nmbh001,nmbh002,nmbh003,nmbh004,nmbh005",TRUE)
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
 
{<section id="anmi960.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION anmi960_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("nmbh001,nmbh002,nmbh003,nmbh004,nmbh005",FALSE)
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
 
{<section id="anmi960.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION anmi960_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmi960.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION anmi960_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmi960.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION anmi960_default_search()
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
      LET ls_wc = ls_wc, " nmbh001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " nmbh002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " nmbh003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " nmbh004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " nmbh005 = '", g_argv[05], "' AND "
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
 
{<section id="anmi960.mask_functions" >}
&include "erp/anm/anmi960_mask.4gl"
 
{</section>}
 
{<section id="anmi960.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION anmi960_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_nmbh_m.nmbh001 IS NULL
      OR g_nmbh_m.nmbh002 IS NULL      OR g_nmbh_m.nmbh003 IS NULL      OR g_nmbh_m.nmbh004 IS NULL      OR g_nmbh_m.nmbh005 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN anmi960_cl USING g_enterprise,g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh005
   IF STATUS THEN
      CLOSE anmi960_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmi960_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE anmi960_master_referesh USING g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004, 
       g_nmbh_m.nmbh005 INTO g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh005, 
       g_nmbh_m.nmbh006,g_nmbh_m.nmbh007,g_nmbh_m.nmbh008,g_nmbh_m.nmbhstus,g_nmbh_m.nmbhownid,g_nmbh_m.nmbhowndp, 
       g_nmbh_m.nmbhcrtid,g_nmbh_m.nmbhcrtdp,g_nmbh_m.nmbhcrtdt,g_nmbh_m.nmbhmodid,g_nmbh_m.nmbhmoddt, 
       g_nmbh_m.nmbhownid_desc,g_nmbh_m.nmbhowndp_desc,g_nmbh_m.nmbhcrtid_desc,g_nmbh_m.nmbhcrtdp_desc, 
       g_nmbh_m.nmbhmodid_desc
   
 
   #檢查是否允許此動作
   IF NOT anmi960_action_chk() THEN
      CLOSE anmi960_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh004_desc, 
       g_nmbh_m.nmbh005,g_nmbh_m.nmbh005_desc,g_nmbh_m.nmbh006,g_nmbh_m.nmbh006_desc,g_nmbh_m.nmbh007, 
       g_nmbh_m.nmbh007_desc,g_nmbh_m.nmbh008,g_nmbh_m.nmbh008_desc,g_nmbh_m.nmbhstus,g_nmbh_m.nmbhownid, 
       g_nmbh_m.nmbhownid_desc,g_nmbh_m.nmbhowndp,g_nmbh_m.nmbhowndp_desc,g_nmbh_m.nmbhcrtid,g_nmbh_m.nmbhcrtid_desc, 
       g_nmbh_m.nmbhcrtdp,g_nmbh_m.nmbhcrtdp_desc,g_nmbh_m.nmbhcrtdt,g_nmbh_m.nmbhmodid,g_nmbh_m.nmbhmodid_desc, 
       g_nmbh_m.nmbhmoddt
 
   CASE g_nmbh_m.nmbhstus
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
         CASE g_nmbh_m.nmbhstus
            
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
      g_nmbh_m.nmbhstus = lc_state OR cl_null(lc_state) THEN
      CLOSE anmi960_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_nmbh_m.nmbhmodid = g_user
   LET g_nmbh_m.nmbhmoddt = cl_get_current()
   LET g_nmbh_m.nmbhstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE nmbh_t 
      SET (nmbhstus,nmbhmodid,nmbhmoddt) 
        = (g_nmbh_m.nmbhstus,g_nmbh_m.nmbhmodid,g_nmbh_m.nmbhmoddt)     
    WHERE nmbhent = g_enterprise AND nmbh001 = g_nmbh_m.nmbh001
      AND nmbh002 = g_nmbh_m.nmbh002      AND nmbh003 = g_nmbh_m.nmbh003      AND nmbh004 = g_nmbh_m.nmbh004      AND nmbh005 = g_nmbh_m.nmbh005
    
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
      EXECUTE anmi960_master_referesh USING g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004, 
          g_nmbh_m.nmbh005 INTO g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004, 
          g_nmbh_m.nmbh005,g_nmbh_m.nmbh006,g_nmbh_m.nmbh007,g_nmbh_m.nmbh008,g_nmbh_m.nmbhstus,g_nmbh_m.nmbhownid, 
          g_nmbh_m.nmbhowndp,g_nmbh_m.nmbhcrtid,g_nmbh_m.nmbhcrtdp,g_nmbh_m.nmbhcrtdt,g_nmbh_m.nmbhmodid, 
          g_nmbh_m.nmbhmoddt,g_nmbh_m.nmbhownid_desc,g_nmbh_m.nmbhowndp_desc,g_nmbh_m.nmbhcrtid_desc, 
          g_nmbh_m.nmbhcrtdp_desc,g_nmbh_m.nmbhmodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_nmbh_m.nmbh001,g_nmbh_m.nmbh002,g_nmbh_m.nmbh003,g_nmbh_m.nmbh004,g_nmbh_m.nmbh004_desc, 
          g_nmbh_m.nmbh005,g_nmbh_m.nmbh005_desc,g_nmbh_m.nmbh006,g_nmbh_m.nmbh006_desc,g_nmbh_m.nmbh007, 
          g_nmbh_m.nmbh007_desc,g_nmbh_m.nmbh008,g_nmbh_m.nmbh008_desc,g_nmbh_m.nmbhstus,g_nmbh_m.nmbhownid, 
          g_nmbh_m.nmbhownid_desc,g_nmbh_m.nmbhowndp,g_nmbh_m.nmbhowndp_desc,g_nmbh_m.nmbhcrtid,g_nmbh_m.nmbhcrtid_desc, 
          g_nmbh_m.nmbhcrtdp,g_nmbh_m.nmbhcrtdp_desc,g_nmbh_m.nmbhcrtdt,g_nmbh_m.nmbhmodid,g_nmbh_m.nmbhmodid_desc, 
          g_nmbh_m.nmbhmoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE anmi960_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmi960_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmi960.signature" >}
   
 
{</section>}
 
{<section id="anmi960.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmi960_set_pk_array()
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
   LET g_pk_array[1].values = g_nmbh_m.nmbh001
   LET g_pk_array[1].column = 'nmbh001'
   LET g_pk_array[2].values = g_nmbh_m.nmbh002
   LET g_pk_array[2].column = 'nmbh002'
   LET g_pk_array[3].values = g_nmbh_m.nmbh003
   LET g_pk_array[3].column = 'nmbh003'
   LET g_pk_array[4].values = g_nmbh_m.nmbh004
   LET g_pk_array[4].column = 'nmbh004'
   LET g_pk_array[5].values = g_nmbh_m.nmbh005
   LET g_pk_array[5].column = 'nmbh005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmi960.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="anmi960.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION anmi960_msgcentre_notify(lc_state)
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
   CALL anmi960_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_nmbh_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmi960.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION anmi960_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmi960.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 檢查是否有下節
# Usage..........: CALL anmi960_chk_hasC (pi_id)
# Input parameter: pi_id 節點
# Return code....: TRUE or FALSE
# Date & Author..: 2014/08/12 By Reanna
################################################################################
PRIVATE FUNCTION anmi960_chk_hasC(pi_id)
DEFINE pi_id    INTEGER
DEFINE li_cnt   INTEGER
#DEFINE l_n      LIKE type_t.num5

   LET g_sql = "SELECT COUNT(*) FROM ooej_t ",
               " WHERE ooejent = '" ||g_enterprise|| "'",
               "   AND ooej004 <> ooej005 ",
               "   AND ooej001 = '7' ",
               "   AND ooej005 = ? ",
               "   AND ooej002 = ? ",
               "   AND ooej003 = ? "
   PREPARE anmi960_master_chk1 FROM g_sql 
   EXECUTE anmi960_master_chk1 USING g_browser[pi_id].b_ooej004,g_browser[pi_id].b_ooej002,g_browser[pi_id].b_ooej003 INTO li_cnt
   FREE anmi960_master_chk1
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION

################################################################################
# Descriptions...: Tree子節點展開
# Memo...........: 組織的子節點
# Usage..........: CALL anmi960_browser_detail(p_id)
#                  RETURNING 回传参数
# Input parameter: p_id   節點
# Date & Author..: 2014/08/12 By Reanna
################################################################################
PRIVATE FUNCTION anmi960_browser_detail(p_id)
DEFINE p_id           LIKE type_t.num10
DEFINE l_id           LIKE type_t.num10
DEFINE l_cnt          LIKE type_t.num10
DEFINE l_keyvalue     LIKE type_t.chr50
DEFINE l_sql          LIKE type_t.chr500
DEFINE l_return       LIKE type_t.num5
DEFINE l_n            LIKE type_t.num5

   #若已經展開
   IF g_browser[p_id].b_isExp = 1 THEN
      RETURN
   END IF

   LET l_keyvalue = g_browser[p_id].b_ooej004
   
   #先確認是否還有下階
   SELECT COUNT(ooej004) INTO l_n
     FROM ooej_t
    WHERE ooejent = g_enterprise
      AND ooej005 = l_keyvalue
      AND ooej004 <> ooej005
      AND ooej001 = '7'
      AND ooej002 = g_browser[p_id].b_ooej002
      AND ooej003 = g_browser[p_id].b_ooej003
      AND (ooej007 IS NULL OR ooej007 >= g_today )
    ORDER BY ooej004
   IF l_n > 0 THEN
      LET g_browser[p_id].b_isExp = 1 
      LET l_return = FALSE
      LET l_sql = "SELECT UNIQUE ooej004,MAX(ooej003) ",
                  "  FROM ooej_t ",
                  " WHERE ooejent = '",g_enterprise,"' ",
                  "   AND ooej005 = '",l_keyvalue,"' ",
                  "   AND ooej004 <> ooej005",
                  "   AND ooej001 = '7'", 
                  "   AND ooej002 = '",g_browser[p_id].b_ooej002,"' ",
                  "   AND ooej003 = '",g_browser[p_id].b_ooej003,"' ",
                  "   AND (ooej007 IS NULL OR ooej007 >= '",g_today,"' ) ",
                  " GROUP BY ooej004 ",
                  " ORDER BY ooej004"
      
      PREPARE tree_expand1 FROM l_sql
      DECLARE tree_ex_cur1 CURSOR FOR tree_expand1

      LET l_id = p_id + 1
      CALL g_browser.insertElement(l_id)
      LET l_cnt = 1
      FOREACH tree_ex_cur1 INTO g_browser[l_id].b_ooej004,g_browser[l_id].b_ooej003
         IF cl_null(g_browser[l_id].b_ooej004) THEN
            EXIT FOREACH
         END IF
         #pid=父節點id
         LET g_browser[l_id].b_pid  = g_browser[p_id].b_id
         #id=本身節點id(採流水號遞增)
         LET g_browser[l_id].b_id  = g_browser[p_id].b_id||"."||l_cnt
         LET g_browser[l_id].b_exp = TRUE
         LET g_browser[l_id].b_ooej005 = g_browser[p_id].b_ooej004
         LET g_browser[l_id].b_ooej002 = g_browser[p_id].b_ooej002
         #hasC=確認該節點是否有子孫
         CALL anmi960_desc_show(l_id)
         LET g_browser[l_id].b_hasC = anmi960_chk_hasC(l_id)
         LET l_id = l_id + 1
         CALL g_browser.insertElement(l_id)
         LET l_cnt = l_cnt + 1
         LET l_return = TRUE
      END FOREACH
   ELSE
      #開始展收支項目
      LET l_sql = " SELECT nmbh001,nmbh002,nmbh003,nmbh004,nmbh005,",
                  "        nmbh006,nmbh007,nmbh008",
                  "   FROM nmbh_t ",
                  "  WHERE nmbhent = '" ||g_enterprise|| "' ",
                  "    AND nmbh002 = '",g_browser[p_id].b_ooej003,"'",
                  "    AND nmbh004 = '",g_browser[p_id].b_ooej004,"' "
      PREPARE tree_expand2 FROM l_sql
      DECLARE tree_ex_cur2 CURSOR FOR tree_expand2
      LET l_id = p_id+1
      CALL g_browser.insertElement(l_id)
      LET l_cnt = 1
      FOREACH tree_ex_cur2 INTO g_browser[l_id].b_nmbh001,g_browser[l_id].b_nmbh002,g_browser[l_id].b_nmbh003,
                                g_browser[l_id].b_nmbh004,g_browser[l_id].b_nmbh005,g_browser[l_id].b_nmbh006_desc,
                                g_browser[l_id].b_nmbh007_desc,g_browser[l_id].b_nmbh008_desc
         
         IF NOT cl_null(s_desc_get_department_desc(g_browser[l_id].b_nmbh006_desc)) THEN
            LET g_browser[l_id].b_nmbh006_desc = g_browser[l_id].b_nmbh006_desc,'(',s_desc_get_department_desc(g_browser[l_id].b_nmbh006_desc),')'
         END IF
         IF NOT cl_null(s_desc_get_department_desc(g_browser[l_id].b_nmbh007_desc)) THEN
            LET g_browser[l_id].b_nmbh007_desc = g_browser[l_id].b_nmbh007_desc,'(',s_desc_get_department_desc(g_browser[l_id].b_nmbh007_desc),')'
         END IF
         IF NOT cl_null(s_desc_get_department_desc(g_browser[l_id].b_nmbh008_desc)) THEN
            LET g_browser[l_id].b_nmbh008_desc = g_browser[l_id].b_nmbh008_desc,'(',s_desc_get_department_desc(g_browser[l_id].b_nmbh008_desc),')'
         END IF
         #pid=父節點id
         LET g_browser[l_id].b_pid  = g_browser[p_id].b_id
         #id=本身節點id(採流水號遞增)
         LET g_browser[l_id].b_id  = g_browser[p_id].b_pid||"."||l_cnt
         LET g_browser[l_id].b_exp = TRUE
         IF NOT cl_null(s_desc_get_nmbd002_desc(g_browser[l_id].b_nmbh003,g_browser[l_id].b_nmbh005)) THEN
            LET g_browser[l_id].b_show = g_browser[l_id].b_nmbh005,'(',s_desc_get_nmbd002_desc(g_browser[l_id].b_nmbh003,g_browser[l_id].b_nmbh005),')'
         ELSE
            LET g_browser[l_id].b_show = g_browser[l_id].b_nmbh005
         END IF
         LET g_browser[l_id].b_hasC = FALSE
         LET g_browser[l_id].b_isExp = TRUE
         LET l_id = l_id + 1
         CALL g_browser.insertElement(l_id)
         LET l_cnt = l_cnt + 1
      END FOREACH
      LET g_browser[p_id].b_nmbh004=g_browser[p_id].b_ooej004
   END IF
   #刪除空資料
   CALL g_browser.deleteElement(l_id)
END FUNCTION

################################################################################
# Descriptions...: 刷新tree
# Memo...........:
# Usage..........: CALL anmi960_tree_refresh()
# Date & Author..: 2014/09/08 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION anmi960_tree_refresh()
   DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)         
       BEFORE DISPLAY
          EXIT DISPLAY
   END DISPLAY 
END FUNCTION

################################################################################
# Descriptions...: 欄位檢核
# Memo...........: #150715-00014#1
# Usage..........: CALL anmi960_nmbh005_chk(p_ooed004)
# Date & Author..: 150724 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION anmi960_nmbh005_chk(p_ooed004)
DEFINE p_ooed004  LIKE ooed_t.ooed004
DEFINE r_success  LIKE type_t.num10
DEFINE r_errno    LIKE gzze_t.gzze001
DEFINE l_cnt      LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_errno = NULL
   LET r_success = TRUE
   #組織編號
   IF cl_null(p_ooed004) THEN
      LET r_errno = ''
      LET r_success = FALSE
      RETURN r_success,r_errno
   END IF
  
   SELECT COUNT(*) INTO l_cnt
     FROM ooed_t
    WHERE ooedent = g_enterprise
      AND ooed001 = '7'
      AND ooed004 = p_ooed004

   IF l_cnt = 0 THEN
      LET r_errno = 'amm-00201'
      LET r_success = FALSE
   END IF

   RETURN r_success,r_errno
END FUNCTION

 
{</section>}
 
