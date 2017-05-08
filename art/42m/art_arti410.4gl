{<section id="arti410.description" >}
#應用 a00 樣板自動產生(Version:2)
#+ Version..: T100-ERP-1.01.00(SD版次:1,PR版次:1) Build-000254
#+ 
#+ Filename...: arti410
#+ Description: 競爭門店資料
#+ Creator....: 02296(2014/01/07)
#+ Modifier...: 02296(2014/01/08) -SD/PR- 00000()
 
{</section>}
 
{<section id="arti410.global" >}
#應用 i01 樣板自動產生(Version:35)
#add-point:填寫註解說明 name="global.memo"

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
PRIVATE TYPE type_g_rtea_m RECORD
       rtea001 LIKE rtea_t.rtea001, 
   rtea001_desc LIKE type_t.chr80, 
   rtea002 LIKE rtea_t.rtea002, 
   rtea003 LIKE rtea_t.rtea003, 
   rtea004 LIKE rtea_t.rtea004, 
   rtea005 LIKE rtea_t.rtea005, 
   rtea006 LIKE rtea_t.rtea006, 
   rtea007 LIKE rtea_t.rtea007, 
   rteastus LIKE rtea_t.rteastus, 
   rteaownid LIKE rtea_t.rteaownid, 
   rteaownid_desc LIKE type_t.chr80, 
   rteaowndp LIKE rtea_t.rteaowndp, 
   rteaowndp_desc LIKE type_t.chr80, 
   rteacrtid LIKE rtea_t.rteacrtid, 
   rteacrtid_desc LIKE type_t.chr80, 
   rteacrtdp LIKE rtea_t.rteacrtdp, 
   rteacrtdp_desc LIKE type_t.chr80, 
   rteacrtdt DATETIME YEAR TO SECOND, 
   rteamodid LIKE rtea_t.rteamodid, 
   rteamodid_desc LIKE type_t.chr80, 
   rteamoddt DATETIME YEAR TO SECOND
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
            b_rtea001 LIKE rtea_t.rtea001,
      b_rtea002 LIKE rtea_t.rtea002,
      b_rtea003 LIKE rtea_t.rtea003
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_rtea_m        type_g_rtea_m  #單頭變數宣告
DEFINE g_rtea_m_t      type_g_rtea_m  #單頭舊值宣告(系統還原用)
DEFINE g_rtea_m_o      type_g_rtea_m  #單頭舊值宣告(其他用途)
DEFINE g_rtea_m_mask_o type_g_rtea_m  #轉換遮罩前資料
DEFINE g_rtea_m_mask_n type_g_rtea_m  #轉換遮罩後資料
 
   DEFINE g_rtea001_t LIKE rtea_t.rtea001
DEFINE g_rtea002_t LIKE rtea_t.rtea002
 
   
#應用 a54 樣板自動產生(Version:3)
DEFINE g_browser_expand   DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位  
      b_rtea001 STRING
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
 
{<section id="arti410.main" >}
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
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT rtea001,'',rtea002,rtea003,rtea004,rtea005,rtea006,rtea007,rteastus,rteaownid, 
       '',rteaowndp,'',rteacrtid,'',rteacrtdp,'',rteacrtdt,rteamodid,'',rteamoddt", 
                      " FROM rtea_t",
                      " WHERE rteaent= ? AND rtea001=? AND rtea002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE arti410_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.rtea001,t0.rtea002,t0.rtea003,t0.rtea004,t0.rtea005,t0.rtea006,t0.rtea007, 
       t0.rteastus,t0.rteaownid,t0.rteaowndp,t0.rteacrtid,t0.rteacrtdp,t0.rteacrtdt,t0.rteamodid,t0.rteamoddt, 
       t1.ooefl003 ,t2.oofa011 ,t3.ooefl003 ,t4.oofa011 ,t5.ooefl003 ,t6.oofa011",
               " FROM rtea_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.rtea001 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t2 ON t2.oofaent='"||g_enterprise||"' AND t2.oofa002='2' AND t2.oofa003=t0.rteaownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=t0.rteaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t4 ON t4.oofaent='"||g_enterprise||"' AND t4.oofa002='2' AND t4.oofa003=t0.rteacrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t0.rteacrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t6 ON t6.oofaent='"||g_enterprise||"' AND t6.oofa002='2' AND t6.oofa003=t0.rteamodid  ",
 
               " WHERE t0.rteaent = '" ||g_enterprise|| "' AND t0.rtea001 = ? AND t0.rtea002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE arti410_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_arti410 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL arti410_init()   
 
      #進入選單 Menu (="N")
      CALL arti410_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_arti410
      
   END IF 
   
   CLOSE arti410_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="arti410.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION arti410_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_main_hidden = 0
   #定義combobox狀態
      CALL cl_set_combo_scc_part('rteastus','17','N,Y')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL arti410_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="arti410.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION arti410_ui_dialog() 
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
            CALL arti410_insert()
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
         INITIALIZE g_rtea_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL arti410_init()
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
               CALL arti410_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL arti410_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL arti410_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL arti410_set_act_visible()
               CALL arti410_set_act_no_visible()
               IF NOT (g_rtea_m.rtea001 IS NULL
                 OR g_rtea_m.rtea002 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " rteaent = '" ||g_enterprise|| "' AND",
                                     " rtea001 = '", g_rtea_m.rtea001, "' "
                                     ," AND rtea002 = '", g_rtea_m.rtea002, "' "
 
                  #填到對應位置
                  CALL arti410_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL arti410_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL arti410_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL arti410_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL arti410_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL arti410_fetch("L")  
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
                  CALL arti410_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL arti410_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL arti410_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL arti410_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL arti410_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL arti410_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL arti410_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL arti410_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL arti410_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL arti410_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL arti410_set_pk_array()
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
                  CALL arti410_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               #應用 a53 樣板自動產生(Version:3)
               ON EXPAND (g_row_index)
                  #樹展開
                  CALL arti410_browser_expand(g_row_index)
                  LET g_browser[g_row_index].b_isExp = 1
                  LET g_browser_expand[g_browser_expand.getLength()+1].b_rtea001 = g_browser[g_row_index].b_rtea001
                  
               ON COLLAPSE (g_row_index)
                  #樹關閉
 
 
 
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL arti410_browser_fill(g_wc,"")
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
                  CALL arti410_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL arti410_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL arti410_set_act_visible()
               CALL arti410_set_act_no_visible()
               IF NOT (g_rtea_m.rtea001 IS NULL
                 OR g_rtea_m.rtea002 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " rteaent = '" ||g_enterprise|| "' AND",
                                     " rtea001 = '", g_rtea_m.rtea001, "' "
                                     ," AND rtea002 = '", g_rtea_m.rtea002, "' "
 
                  #填到對應位置
                  CALL arti410_browser_fill(g_wc,"")
               END IF
         
            
            
            #第一筆資料
            ON ACTION first
               CALL arti410_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL arti410_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL arti410_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL arti410_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL arti410_fetch("L")  
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
               CALL arti410_browser_search()
               EXIT DIALOG
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL arti410_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL arti410_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL arti410_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL arti410_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL arti410_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL arti410_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL arti410_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL arti410_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL arti410_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL arti410_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL arti410_set_pk_array()
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
      
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="arti410.browser_fill" >}
#應用 a30 樣板自動產生(Version:10)
#+ 瀏覽頁簽資料填充(六階樹狀)
PRIVATE FUNCTION arti410_browser_fill(ps_wc,ps_page_action) 
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE ps_wc              STRING
   DEFINE ps_page_action     STRING
   DEFINE ls_sql             STRING
   DEFINE li_idx             LIKE type_t.num10
   DEFINE li_idx2            LIKE type_t.num10
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="browser_fill.before_fill"
   
   #end add-point
   
   CLEAR FORM
   INITIALIZE g_rtea_m.* TO NULL
   CALL g_browser.clear()
    
   LET ls_sql = " SELECT DISTINCT rtea001 ",
                " FROM rtea_t ",
                "  ",
                "  ",
                " WHERE rteaent = '" ||g_enterprise|| "' AND ", g_wc ,cl_sql_add_filter("rtea_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtea_t")             #WC重組           
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料             
   PREPARE browse_pre FROM ls_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   LET li_idx = 1 
   FOREACH browse_cur INTO g_browser[li_idx].b_rtea001
      
      LET g_browser[li_idx].b_pid     = 0
      LET g_browser[li_idx].b_id      = 0, ".", li_idx USING "<<<"
      LET g_browser[li_idx].b_exp     = FALSE
      LET g_browser[li_idx].b_expcode = 1
      LET g_browser[li_idx].b_hasC    = TRUE
      LET g_browser[li_idx].b_show    = g_browser[li_idx].b_rtea001
      CALL arti410_desc_show(li_idx)
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
         IF g_browser_expand[li_idx2].b_rtea001.equals(g_browser[li_idx].b_rtea001)
            THEN
            CALL arti410_browser_expand(li_idx)
            LET g_browser[li_idx].b_isExp = 1  
            LET g_browser[li_idx].b_exp = TRUE
         END IF 
      END FOR
   END FOR
   
   FREE browse_pre
   
END FUNCTION
 
#+ Tree子節點展開
PRIVATE FUNCTION arti410_browser_expand(pi_id)
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
      CALL arti410_browser_expand_leaf(pi_id)
      RETURN
   END IF
   
   LET li_lv = g_browser[pi_id].b_expcode
   LET g_browser[pi_id].b_isExp = TRUE
   
   CASE li_lv
      WHEN 1
         LET ls_wc = " AND rtea001 = '",g_browser[pi_id].b_rtea001,"' "
         LET ls_type_list = "rtea001"
      WHEN 2               
         LET ls_wc = " AND rtea001 = '", g_browser[pi_id].b_rtea001, "'"
         LET ls_type_list = "rtea001"
      WHEN 3
         LET ls_wc = " AND rtea001 = '", g_browser[pi_id].b_rtea001, "'"
         LET ls_type_list = "rtea001"
      WHEN 4                
         LET ls_wc = " AND rtea001 = '", g_browser[pi_id].b_rtea001, "'"
         LET ls_type_list = "rtea001"
      WHEN 5
         LET ls_wc = " AND rtea001 = '", g_browser[pi_id].b_rtea001, "'"
         LET ls_type_list = "rtea001"
   END CASE
   
   LET ls_sql = " SELECT DISTINCT   ", ls_type_list, 
                " FROM rtea_t ",
                "  ",
                "  ",
                " WHERE rteaent = '" ||g_enterprise|| "' AND ", g_wc, ls_wc #,cl_get_extra_cond('zzuser', 'zzgrup')
 
   LET li_lv = g_browser[pi_id].b_expcode 
    
   #add-point:browser_expand段before prepare name="browser_expand.before_prepare"
   
   #end add-point
                
   PREPARE expand_pre FROM ls_sql
   DECLARE expand_cur CURSOR FOR expand_pre
   
   LET li_idx = pi_id + 1
   CALL g_browser.insertElement(li_idx)
   FOREACH expand_cur INTO g_browser[li_idx].b_rtea001
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
      CALL arti410_desc_show(li_idx)
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
PRIVATE FUNCTION arti410_browser_expand_leaf(pi_id)
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
   
   LET ls_wc = " AND rtea001 = '", g_browser[pi_id].b_rtea001, "'"
 
   LET ls_sql = " SELECT DISTINCT t0.rtea001,t0.rtea002,t0.rtea003 ",
                " FROM rtea_t t0 ",
                "  ",
                
                " WHERE rteaent = '" ||g_enterprise|| "' AND ", g_wc, ls_wc #,cl_get_extra_cond('zzuser', 'zzgrup')
 
   LET li_lv = g_browser[pi_id].b_expcode 
          
   LET ls_sql = ls_sql, " ORDER BY t0.rtea002"
          
   #add-point:browser_expand_leaf段before prepare name="browser_expand_leaf.before_prepare"
   
   #end add-point 
          
   PREPARE leaf_pre FROM ls_sql
   DECLARE leaf_cur CURSOR FOR leaf_pre
   
   LET g_cnt = pi_id + 1
   CALL g_browser.insertElement(g_cnt)
   FOREACH leaf_cur INTO g_browser[g_cnt].b_rtea001,g_browser[g_cnt].b_rtea002,g_browser[g_cnt].b_rtea003 
 
      LET g_browser[g_cnt].b_pid     = g_browser[pi_id].b_id 
      LET g_browser[g_cnt].b_id      = g_browser[pi_id].b_id , ".", g_cnt USING "<<<"
      LET g_browser[g_cnt].b_exp     = FALSE
      LET g_browser[g_cnt].b_expcode = li_lv + 1
      LET g_browser[g_cnt].b_hasC    = FALSE
      LET g_browser[g_cnt].b_show = g_browser[g_cnt].b_rtea002
      CALL arti410_desc_show(g_cnt)
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
PRIVATE FUNCTION arti410_desc_show(pi_ac)
   #add-point:desc_show段define (客製用) name="desc_show.define_customerization"
   
   #end add-point
   DEFINE pi_ac   LIKE type_t.num10
   DEFINE li_tmp  LIKE type_t.num10
   #add-point:desc_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="desc_show.define"
   
   #end add-point
   
   LET li_tmp = g_cnt
   LET g_cnt = pi_ac
   
   #add-point:desc_show段desc處理 name="desc_show.show"
   
   #end add-point
   LET g_cnt = li_tmp
   
END FUNCTION
 
#+ 簡易快速查詢
PRIVATE FUNCTION arti410_browser_search()
   #add-point:browser_search段define(客製用) name="browser_search.define_customerization"
   
   #END add-point
   DEFINE ls_wc       STRING   #若有輸入g_searchstr時用來代換g_wc的暫存變數
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
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
 
{<section id="arti410.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION arti410_construct()
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
   INITIALIZE g_rtea_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON rtea001,rtea002,rtea003,rtea004,rtea005,rtea006,rtea007,rteastus,rteaownid, 
          rteaowndp,rteacrtid,rteacrtdp,rteacrtdt,rteamodid,rteamoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rteacrtdt>>----
         AFTER FIELD rteacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rteamoddt>>----
         AFTER FIELD rteamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rteacnfdt>>----
         
         #----<<rteapstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.rtea001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtea001
            #add-point:ON ACTION controlp INFIELD rtea001 name="construct.c.rtea001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtea001  #顯示到畫面上
            NEXT FIELD rtea001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtea001
            #add-point:BEFORE FIELD rtea001 name="construct.b.rtea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtea001
            
            #add-point:AFTER FIELD rtea001 name="construct.a.rtea001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtea002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtea002
            #add-point:ON ACTION controlp INFIELD rtea002 name="construct.c.rtea002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtea002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtea002  #顯示到畫面上
            NEXT FIELD rtea002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtea002
            #add-point:BEFORE FIELD rtea002 name="construct.b.rtea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtea002
            
            #add-point:AFTER FIELD rtea002 name="construct.a.rtea002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtea003
            #add-point:BEFORE FIELD rtea003 name="construct.b.rtea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtea003
            
            #add-point:AFTER FIELD rtea003 name="construct.a.rtea003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtea003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtea003
            #add-point:ON ACTION controlp INFIELD rtea003 name="construct.c.rtea003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtea004
            #add-point:BEFORE FIELD rtea004 name="construct.b.rtea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtea004
            
            #add-point:AFTER FIELD rtea004 name="construct.a.rtea004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtea004
            #add-point:ON ACTION controlp INFIELD rtea004 name="construct.c.rtea004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtea005
            #add-point:BEFORE FIELD rtea005 name="construct.b.rtea005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtea005
            
            #add-point:AFTER FIELD rtea005 name="construct.a.rtea005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtea005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtea005
            #add-point:ON ACTION controlp INFIELD rtea005 name="construct.c.rtea005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtea006
            #add-point:BEFORE FIELD rtea006 name="construct.b.rtea006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtea006
            
            #add-point:AFTER FIELD rtea006 name="construct.a.rtea006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtea006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtea006
            #add-point:ON ACTION controlp INFIELD rtea006 name="construct.c.rtea006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtea007
            #add-point:BEFORE FIELD rtea007 name="construct.b.rtea007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtea007
            
            #add-point:AFTER FIELD rtea007 name="construct.a.rtea007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtea007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtea007
            #add-point:ON ACTION controlp INFIELD rtea007 name="construct.c.rtea007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rteastus
            #add-point:BEFORE FIELD rteastus name="construct.b.rteastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rteastus
            
            #add-point:AFTER FIELD rteastus name="construct.a.rteastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rteastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rteastus
            #add-point:ON ACTION controlp INFIELD rteastus name="construct.c.rteastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rteaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rteaownid
            #add-point:ON ACTION controlp INFIELD rteaownid name="construct.c.rteaownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rteaownid  #顯示到畫面上
            NEXT FIELD rteaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rteaownid
            #add-point:BEFORE FIELD rteaownid name="construct.b.rteaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rteaownid
            
            #add-point:AFTER FIELD rteaownid name="construct.a.rteaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rteaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rteaowndp
            #add-point:ON ACTION controlp INFIELD rteaowndp name="construct.c.rteaowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rteaowndp  #顯示到畫面上
            NEXT FIELD rteaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rteaowndp
            #add-point:BEFORE FIELD rteaowndp name="construct.b.rteaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rteaowndp
            
            #add-point:AFTER FIELD rteaowndp name="construct.a.rteaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rteacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rteacrtid
            #add-point:ON ACTION controlp INFIELD rteacrtid name="construct.c.rteacrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rteacrtid  #顯示到畫面上
            NEXT FIELD rteacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rteacrtid
            #add-point:BEFORE FIELD rteacrtid name="construct.b.rteacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rteacrtid
            
            #add-point:AFTER FIELD rteacrtid name="construct.a.rteacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rteacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rteacrtdp
            #add-point:ON ACTION controlp INFIELD rteacrtdp name="construct.c.rteacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rteacrtdp  #顯示到畫面上
            NEXT FIELD rteacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rteacrtdp
            #add-point:BEFORE FIELD rteacrtdp name="construct.b.rteacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rteacrtdp
            
            #add-point:AFTER FIELD rteacrtdp name="construct.a.rteacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rteacrtdt
            #add-point:BEFORE FIELD rteacrtdt name="construct.b.rteacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rteamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rteamodid
            #add-point:ON ACTION controlp INFIELD rteamodid name="construct.c.rteamodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rteamodid  #顯示到畫面上
            NEXT FIELD rteamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rteamodid
            #add-point:BEFORE FIELD rteamodid name="construct.b.rteamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rteamodid
            
            #add-point:AFTER FIELD rteamodid name="construct.a.rteamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rteamoddt
            #add-point:BEFORE FIELD rteamoddt name="construct.b.rteamoddt"
            
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
 
{<section id="arti410.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION arti410_query()
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
 
   INITIALIZE g_rtea_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL arti410_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL arti410_browser_fill(g_wc,"F")
      CALL arti410_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
      CALL g_browser_expand.clear()
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL arti410_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL arti410_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="arti410.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION arti410_fetch(p_fl)
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
      INITIALIZE g_rtea_m.* TO NULL
      DISPLAY BY NAME g_rtea_m.*
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
   LET g_rtea_m.rtea001 = g_browser[g_current_idx].b_rtea001
   LET g_rtea_m.rtea002 = g_browser[g_current_idx].b_rtea002
 
                       
   #讀取單頭所有欄位資料
   EXECUTE arti410_master_referesh USING g_rtea_m.rtea001,g_rtea_m.rtea002 INTO g_rtea_m.rtea001,g_rtea_m.rtea002, 
       g_rtea_m.rtea003,g_rtea_m.rtea004,g_rtea_m.rtea005,g_rtea_m.rtea006,g_rtea_m.rtea007,g_rtea_m.rteastus, 
       g_rtea_m.rteaownid,g_rtea_m.rteaowndp,g_rtea_m.rteacrtid,g_rtea_m.rteacrtdp,g_rtea_m.rteacrtdt, 
       g_rtea_m.rteamodid,g_rtea_m.rteamoddt,g_rtea_m.rtea001_desc,g_rtea_m.rteaownid_desc,g_rtea_m.rteaowndp_desc, 
       g_rtea_m.rteacrtid_desc,g_rtea_m.rteacrtdp_desc,g_rtea_m.rteamodid_desc
   
   #遮罩相關處理
   LET g_rtea_m_mask_o.* =  g_rtea_m.*
   CALL arti410_rtea_t_mask()
   LET g_rtea_m_mask_n.* =  g_rtea_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL arti410_set_act_visible()
   CALL arti410_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_rtea_m_t.* = g_rtea_m.*
   LET g_rtea_m_o.* = g_rtea_m.*
   
   LET g_data_owner = g_rtea_m.rteaownid      
   LET g_data_dept  = g_rtea_m.rteaowndp
   
   #重新顯示
   CALL arti410_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="arti410.insert" >}
#+ 資料新增
PRIVATE FUNCTION arti410_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_rtea_m.* LIKE rtea_t.*             #DEFAULT 設定
   LET g_rtea001_t = NULL
   LET g_rtea002_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      #應用 a55 樣板自動產生(Version:3)
      #六階樹狀給值
      LET g_current_idx = g_curr_diag.getCurrentRow("s_browse")
      IF g_current_idx > 0 THEN
         IF NOT cl_null(g_browser[g_current_idx].b_show) THEN
            LET g_rtea_m.rtea001 = g_browser[g_current_idx].b_rtea001
         END IF
      END IF
 
 
 
 
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtea_m.rteaownid = g_user
      LET g_rtea_m.rteaowndp = g_dept
      LET g_rtea_m.rteacrtid = g_user
      LET g_rtea_m.rteacrtdp = g_dept 
      LET g_rtea_m.rteacrtdt = cl_get_current()
      LET g_rtea_m.rteamodid = g_user
      LET g_rtea_m.rteamoddt = cl_get_current()
      LET g_rtea_m.rteastus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_rtea_m.rteastus = "Y"
 
 
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtea_m.rteastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL arti410_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_rtea_m.* TO NULL
         CALL arti410_show()
         RETURN
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL arti410_set_act_visible()
   CALL arti410_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_rtea001_t = g_rtea_m.rtea001
   LET g_rtea002_t = g_rtea_m.rtea002
 
   
   #組合新增資料的條件
   LET g_add_browse = " rteaent = '" ||g_enterprise|| "' AND",
                      " rtea001 = '", g_rtea_m.rtea001, "' "
                      ," AND rtea002 = '", g_rtea_m.rtea002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE arti410_master_referesh USING g_rtea_m.rtea001,g_rtea_m.rtea002 INTO g_rtea_m.rtea001,g_rtea_m.rtea002, 
       g_rtea_m.rtea003,g_rtea_m.rtea004,g_rtea_m.rtea005,g_rtea_m.rtea006,g_rtea_m.rtea007,g_rtea_m.rteastus, 
       g_rtea_m.rteaownid,g_rtea_m.rteaowndp,g_rtea_m.rteacrtid,g_rtea_m.rteacrtdp,g_rtea_m.rteacrtdt, 
       g_rtea_m.rteamodid,g_rtea_m.rteamoddt,g_rtea_m.rtea001_desc,g_rtea_m.rteaownid_desc,g_rtea_m.rteaowndp_desc, 
       g_rtea_m.rteacrtid_desc,g_rtea_m.rteacrtdp_desc,g_rtea_m.rteamodid_desc
   
   #遮罩相關處理
   LET g_rtea_m_mask_o.* =  g_rtea_m.*
   CALL arti410_rtea_t_mask()
   LET g_rtea_m_mask_n.* =  g_rtea_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtea_m.rtea001,g_rtea_m.rtea001_desc,g_rtea_m.rtea002,g_rtea_m.rtea003,g_rtea_m.rtea004, 
       g_rtea_m.rtea005,g_rtea_m.rtea006,g_rtea_m.rtea007,g_rtea_m.rteastus,g_rtea_m.rteaownid,g_rtea_m.rteaownid_desc, 
       g_rtea_m.rteaowndp,g_rtea_m.rteaowndp_desc,g_rtea_m.rteacrtid,g_rtea_m.rteacrtid_desc,g_rtea_m.rteacrtdp, 
       g_rtea_m.rteacrtdp_desc,g_rtea_m.rteacrtdt,g_rtea_m.rteamodid,g_rtea_m.rteamodid_desc,g_rtea_m.rteamoddt 
 
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   #功能已完成,通報訊息中心
   CALL arti410_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="arti410.modify" >}
#+ 資料修改
PRIVATE FUNCTION arti410_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_rtea_m.rtea001 IS NULL
 
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
   LET g_rtea001_t = g_rtea_m.rtea001
   LET g_rtea002_t = g_rtea_m.rtea002
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN arti410_cl USING g_enterprise,g_rtea_m.rtea001,g_rtea_m.rtea002
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN arti410_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE arti410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE arti410_master_referesh USING g_rtea_m.rtea001,g_rtea_m.rtea002 INTO g_rtea_m.rtea001,g_rtea_m.rtea002, 
       g_rtea_m.rtea003,g_rtea_m.rtea004,g_rtea_m.rtea005,g_rtea_m.rtea006,g_rtea_m.rtea007,g_rtea_m.rteastus, 
       g_rtea_m.rteaownid,g_rtea_m.rteaowndp,g_rtea_m.rteacrtid,g_rtea_m.rteacrtdp,g_rtea_m.rteacrtdt, 
       g_rtea_m.rteamodid,g_rtea_m.rteamoddt,g_rtea_m.rtea001_desc,g_rtea_m.rteaownid_desc,g_rtea_m.rteaowndp_desc, 
       g_rtea_m.rteacrtid_desc,g_rtea_m.rteacrtdp_desc,g_rtea_m.rteamodid_desc
 
   #檢查是否允許此動作
   IF NOT arti410_action_chk() THEN
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_rtea_m_mask_o.* =  g_rtea_m.*
   CALL arti410_rtea_t_mask()
   LET g_rtea_m_mask_n.* =  g_rtea_m.*
   
   
 
   #顯示資料
   CALL arti410_show()
   
   WHILE TRUE
      LET g_rtea_m.rtea001 = g_rtea001_t
      LET g_rtea_m.rtea002 = g_rtea002_t
 
      
      #寫入修改者/修改日期資訊
      LET g_rtea_m.rteamodid = g_user 
LET g_rtea_m.rteamoddt = cl_get_current()
LET g_rtea_m.rteamodid_desc = cl_get_username(g_rtea_m.rteamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL arti410_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_rtea_m.* = g_rtea_m_t.*
         CALL arti410_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE rtea_t SET (rteamodid,rteamoddt) = (g_rtea_m.rteamodid,g_rtea_m.rteamoddt)
       WHERE rteaent = g_enterprise AND rtea001 = g_rtea001_t
         AND rtea002 = g_rtea002_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL arti410_set_act_visible()
   CALL arti410_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " rteaent = '" ||g_enterprise|| "' AND",
                      " rtea001 = '", g_rtea_m.rtea001, "' "
                      ," AND rtea002 = '", g_rtea_m.rtea002, "' "
 
   #填到對應位置
   CALL arti410_browser_fill(g_wc,"")
 
   CLOSE arti410_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL arti410_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="arti410.input" >}
#+ 資料輸入
PRIVATE FUNCTION arti410_input(p_cmd)
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
   DISPLAY BY NAME g_rtea_m.rtea001,g_rtea_m.rtea001_desc,g_rtea_m.rtea002,g_rtea_m.rtea003,g_rtea_m.rtea004, 
       g_rtea_m.rtea005,g_rtea_m.rtea006,g_rtea_m.rtea007,g_rtea_m.rteastus,g_rtea_m.rteaownid,g_rtea_m.rteaownid_desc, 
       g_rtea_m.rteaowndp,g_rtea_m.rteaowndp_desc,g_rtea_m.rteacrtid,g_rtea_m.rteacrtid_desc,g_rtea_m.rteacrtdp, 
       g_rtea_m.rteacrtdp_desc,g_rtea_m.rteacrtdt,g_rtea_m.rteamodid,g_rtea_m.rteamodid_desc,g_rtea_m.rteamoddt 
 
   
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
   CALL arti410_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL arti410_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_rtea_m.rtea001,g_rtea_m.rtea002,g_rtea_m.rtea003,g_rtea_m.rtea004,g_rtea_m.rtea005, 
          g_rtea_m.rtea006,g_rtea_m.rtea007,g_rtea_m.rteastus 
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
         AFTER FIELD rtea001
            
            #add-point:AFTER FIELD rtea001 name="input.a.rtea001"
            IF NOT cl_null(g_rtea_m.rtea001) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtea_m.rtea001

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtea_m.rtea001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtea_m.rtea001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtea_m.rtea001_desc

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_rtea_m.rtea001) AND NOT cl_null(g_rtea_m.rtea002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rtea_m.rtea001 != g_rtea001_t  OR g_rtea_m.rtea002 != g_rtea002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtea_t WHERE "||"rteaent = '" ||g_enterprise|| "' AND "||"rtea001 = '"||g_rtea_m.rtea001 ||"' AND "|| "rtea002 = '"||g_rtea_m.rtea002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtea001
            #add-point:BEFORE FIELD rtea001 name="input.b.rtea001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtea001
            #add-point:ON CHANGE rtea001 name="input.g.rtea001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtea002
            #add-point:BEFORE FIELD rtea002 name="input.b.rtea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtea002
            
            #add-point:AFTER FIELD rtea002 name="input.a.rtea002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_rtea_m.rtea001) AND NOT cl_null(g_rtea_m.rtea002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rtea_m.rtea001 != g_rtea001_t  OR g_rtea_m.rtea002 != g_rtea002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtea_t WHERE "||"rteaent = '" ||g_enterprise|| "' AND "||"rtea001 = '"||g_rtea_m.rtea001 ||"' AND "|| "rtea002 = '"||g_rtea_m.rtea002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtea002
            #add-point:ON CHANGE rtea002 name="input.g.rtea002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtea003
            #add-point:BEFORE FIELD rtea003 name="input.b.rtea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtea003
            
            #add-point:AFTER FIELD rtea003 name="input.a.rtea003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtea003
            #add-point:ON CHANGE rtea003 name="input.g.rtea003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtea004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtea_m.rtea004,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtea004
            END IF 
 
 
 
            #add-point:AFTER FIELD rtea004 name="input.a.rtea004"
            IF NOT cl_null(g_rtea_m.rtea004) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtea004
            #add-point:BEFORE FIELD rtea004 name="input.b.rtea004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtea004
            #add-point:ON CHANGE rtea004 name="input.g.rtea004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtea005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtea_m.rtea005,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtea005
            END IF 
 
 
 
            #add-point:AFTER FIELD rtea005 name="input.a.rtea005"
            IF NOT cl_null(g_rtea_m.rtea005) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtea005
            #add-point:BEFORE FIELD rtea005 name="input.b.rtea005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtea005
            #add-point:ON CHANGE rtea005 name="input.g.rtea005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtea006
            #add-point:BEFORE FIELD rtea006 name="input.b.rtea006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtea006
            
            #add-point:AFTER FIELD rtea006 name="input.a.rtea006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtea006
            #add-point:ON CHANGE rtea006 name="input.g.rtea006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtea007
            #add-point:BEFORE FIELD rtea007 name="input.b.rtea007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtea007
            
            #add-point:AFTER FIELD rtea007 name="input.a.rtea007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtea007
            #add-point:ON CHANGE rtea007 name="input.g.rtea007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rteastus
            #add-point:BEFORE FIELD rteastus name="input.b.rteastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rteastus
            
            #add-point:AFTER FIELD rteastus name="input.a.rteastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rteastus
            #add-point:ON CHANGE rteastus name="input.g.rteastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rtea001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtea001
            #add-point:ON ACTION controlp INFIELD rtea001 name="input.c.rtea001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtea_m.rtea001             #給予default值
            LET g_qryparam.default2 = "" #g_rtea_m.ooef001 #組織編號
            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooef001()                                #呼叫開窗

            LET g_rtea_m.rtea001 = g_qryparam.return1              
            #LET g_rtea_m.ooef001 = g_qryparam.return2 
            DISPLAY g_rtea_m.rtea001 TO rtea001              #
            #DISPLAY g_rtea_m.ooef001 TO ooef001 #組織編號
            NEXT FIELD rtea001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtea002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtea002
            #add-point:ON ACTION controlp INFIELD rtea002 name="input.c.rtea002"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtea003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtea003
            #add-point:ON ACTION controlp INFIELD rtea003 name="input.c.rtea003"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtea004
            #add-point:ON ACTION controlp INFIELD rtea004 name="input.c.rtea004"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtea005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtea005
            #add-point:ON ACTION controlp INFIELD rtea005 name="input.c.rtea005"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtea006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtea006
            #add-point:ON ACTION controlp INFIELD rtea006 name="input.c.rtea006"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtea007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtea007
            #add-point:ON ACTION controlp INFIELD rtea007 name="input.c.rtea007"
            
            #END add-point
 
 
         #Ctrlp:input.c.rteastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rteastus
            #add-point:ON ACTION controlp INFIELD rteastus name="input.c.rteastus"
            
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
               SELECT COUNT(1) INTO l_count FROM rtea_t
                WHERE rteaent = g_enterprise AND rtea001 = g_rtea_m.rtea001
                  AND rtea002 = g_rtea_m.rtea002
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO rtea_t (rteaent,rtea001,rtea002,rtea003,rtea004,rtea005,rtea006,rtea007, 
                      rteastus,rteaownid,rteaowndp,rteacrtid,rteacrtdp,rteacrtdt,rteamodid,rteamoddt) 
 
                  VALUES (g_enterprise,g_rtea_m.rtea001,g_rtea_m.rtea002,g_rtea_m.rtea003,g_rtea_m.rtea004, 
                      g_rtea_m.rtea005,g_rtea_m.rtea006,g_rtea_m.rtea007,g_rtea_m.rteastus,g_rtea_m.rteaownid, 
                      g_rtea_m.rteaowndp,g_rtea_m.rteacrtid,g_rtea_m.rteacrtdp,g_rtea_m.rteacrtdt,g_rtea_m.rteamodid, 
                      g_rtea_m.rteamoddt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtea_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_rtea_m.rtea001
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL arti410_rtea_t_mask_restore('restore_mask_o')
               
               UPDATE rtea_t SET (rtea001,rtea002,rtea003,rtea004,rtea005,rtea006,rtea007,rteastus,rteaownid, 
                   rteaowndp,rteacrtid,rteacrtdp,rteacrtdt,rteamodid,rteamoddt) = (g_rtea_m.rtea001, 
                   g_rtea_m.rtea002,g_rtea_m.rtea003,g_rtea_m.rtea004,g_rtea_m.rtea005,g_rtea_m.rtea006, 
                   g_rtea_m.rtea007,g_rtea_m.rteastus,g_rtea_m.rteaownid,g_rtea_m.rteaowndp,g_rtea_m.rteacrtid, 
                   g_rtea_m.rteacrtdp,g_rtea_m.rteacrtdt,g_rtea_m.rteamodid,g_rtea_m.rteamoddt)
                WHERE rteaent = g_enterprise AND rtea001 = g_rtea001_t #
                  AND rtea002 = g_rtea002_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtea_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtea_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL arti410_rtea_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_rtea_m_t)
                     LET g_log2 = util.JSON.stringify(g_rtea_m)
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
 
{<section id="arti410.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION arti410_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE rtea_t.rtea001 
   DEFINE l_oldno     LIKE rtea_t.rtea001 
   DEFINE l_newno02     LIKE rtea_t.rtea002 
   DEFINE l_oldno02     LIKE rtea_t.rtea002 
 
   DEFINE l_master    RECORD LIKE rtea_t.*
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_rtea_m.rtea001 IS NULL
      OR g_rtea_m.rtea002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_rtea001_t = g_rtea_m.rtea001
   LET g_rtea002_t = g_rtea_m.rtea002
 
   
   #清空key值
   LET g_rtea_m.rtea001 = ""
   LET g_rtea_m.rtea002 = ""
 
    
   CALL arti410_set_entry("a")
   CALL arti410_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtea_m.rteaownid = g_user
      LET g_rtea_m.rteaowndp = g_dept
      LET g_rtea_m.rteacrtid = g_user
      LET g_rtea_m.rteacrtdp = g_dept 
      LET g_rtea_m.rteacrtdt = cl_get_current()
      LET g_rtea_m.rteamodid = g_user
      LET g_rtea_m.rteamoddt = cl_get_current()
      LET g_rtea_m.rteastus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtea_m.rteastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_rtea_m.rtea001_desc = ''
   DISPLAY BY NAME g_rtea_m.rtea001_desc
 
   
   #資料輸入
   CALL arti410_input("r")
   
   IF INT_FLAG THEN
      #取消
      LET INT_FLAG = 0
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      INITIALIZE g_rtea_m.* TO NULL
      CALL arti410_show()
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前 name="reproduce.head.b_insert"
   
   #end add-point
   
   #add-point:單頭複製中 name="reproduce.head.m_insert"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "rtea_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:單頭複製後 name="reproduce.head.a_insert"
   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL arti410_set_act_visible()
   CALL arti410_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_rtea001_t = g_rtea_m.rtea001
   LET g_rtea002_t = g_rtea_m.rtea002
 
   
   #組合新增資料的條件
   LET g_add_browse = " rteaent = '" ||g_enterprise|| "' AND",
                      " rtea001 = '", g_rtea_m.rtea001, "' "
                      ," AND rtea002 = '", g_rtea_m.rtea002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
                 
   #功能已完成,通報訊息中心
   CALL arti410_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="arti410.show" >}
#+ 資料顯示 
PRIVATE FUNCTION arti410_show()
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
   CALL arti410_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rtea_m.rtea001,g_rtea_m.rtea001_desc,g_rtea_m.rtea002,g_rtea_m.rtea003,g_rtea_m.rtea004, 
       g_rtea_m.rtea005,g_rtea_m.rtea006,g_rtea_m.rtea007,g_rtea_m.rteastus,g_rtea_m.rteaownid,g_rtea_m.rteaownid_desc, 
       g_rtea_m.rteaowndp,g_rtea_m.rteaowndp_desc,g_rtea_m.rteacrtid,g_rtea_m.rteacrtid_desc,g_rtea_m.rteacrtdp, 
       g_rtea_m.rteacrtdp_desc,g_rtea_m.rteacrtdt,g_rtea_m.rteamodid,g_rtea_m.rteamodid_desc,g_rtea_m.rteamoddt 
 
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL arti410_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtea_m.rteastus 
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
 
{<section id="arti410.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION arti410_delete()
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
   IF g_rtea_m.rtea001 IS NULL
   OR g_rtea_m.rtea002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_rtea001_t = g_rtea_m.rtea001
   LET g_rtea002_t = g_rtea_m.rtea002
 
   
   
 
   OPEN arti410_cl USING g_enterprise,g_rtea_m.rtea001,g_rtea_m.rtea002
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN arti410_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE arti410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE arti410_master_referesh USING g_rtea_m.rtea001,g_rtea_m.rtea002 INTO g_rtea_m.rtea001,g_rtea_m.rtea002, 
       g_rtea_m.rtea003,g_rtea_m.rtea004,g_rtea_m.rtea005,g_rtea_m.rtea006,g_rtea_m.rtea007,g_rtea_m.rteastus, 
       g_rtea_m.rteaownid,g_rtea_m.rteaowndp,g_rtea_m.rteacrtid,g_rtea_m.rteacrtdp,g_rtea_m.rteacrtdt, 
       g_rtea_m.rteamodid,g_rtea_m.rteamoddt,g_rtea_m.rtea001_desc,g_rtea_m.rteaownid_desc,g_rtea_m.rteaowndp_desc, 
       g_rtea_m.rteacrtid_desc,g_rtea_m.rteacrtdp_desc,g_rtea_m.rteamodid_desc
   
   #檢查是否允許此動作
   IF NOT arti410_action_chk() THEN
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtea_m_mask_o.* =  g_rtea_m.*
   CALL arti410_rtea_t_mask()
   LET g_rtea_m_mask_n.* =  g_rtea_m.*
   
   #將最新資料顯示到畫面上
   CALL arti410_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:3)
      #刪除相關文件
      CALL arti410_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM rtea_t 
       WHERE rteaent = g_enterprise AND rtea001 = g_rtea_m.rtea001 
         AND rtea002 = g_rtea_m.rtea002 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtea_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      IF NOT cl_log_modified_record('','') THEN 
         CLOSE arti410_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL arti410_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         CALL arti410_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE arti410_cl
 
   #功能已完成,通報訊息中心
   CALL arti410_msgcentre_notify('delete')
 
END FUNCTION
 
{</section>}
 
{<section id="arti410.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION arti410_ui_browser_refresh()
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
      IF g_browser[l_i].b_rtea001 = g_rtea_m.rtea001
         AND g_browser[l_i].b_rtea002 = g_rtea_m.rtea002
 
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
 
{<section id="arti410.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION arti410_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("rtea001,rtea002",TRUE)
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
 
{<section id="arti410.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION arti410_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("rtea001,rtea002",FALSE)
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
 
{<section id="arti410.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION arti410_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="arti410.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION arti410_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="arti410.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION arti410_default_search()
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
      LET ls_wc = ls_wc, " rtea001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " rtea002 = '", g_argv[02], "' AND "
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
 
{<section id="arti410.mask_functions" >}
&include "erp/art/arti410_mask.4gl"
 
{</section>}
 
{<section id="arti410.state_change" >}
   #應用 a09 樣板自動產生(Version:15)
#+ 確認碼變更 
PRIVATE FUNCTION arti410_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_rtea_m.rtea001 IS NULL
      OR g_rtea_m.rtea002 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN arti410_cl USING g_enterprise,g_rtea_m.rtea001,g_rtea_m.rtea002
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN arti410_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE arti410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE arti410_master_referesh USING g_rtea_m.rtea001,g_rtea_m.rtea002 INTO g_rtea_m.rtea001,g_rtea_m.rtea002, 
       g_rtea_m.rtea003,g_rtea_m.rtea004,g_rtea_m.rtea005,g_rtea_m.rtea006,g_rtea_m.rtea007,g_rtea_m.rteastus, 
       g_rtea_m.rteaownid,g_rtea_m.rteaowndp,g_rtea_m.rteacrtid,g_rtea_m.rteacrtdp,g_rtea_m.rteacrtdt, 
       g_rtea_m.rteamodid,g_rtea_m.rteamoddt,g_rtea_m.rtea001_desc,g_rtea_m.rteaownid_desc,g_rtea_m.rteaowndp_desc, 
       g_rtea_m.rteacrtid_desc,g_rtea_m.rteacrtdp_desc,g_rtea_m.rteamodid_desc
 
   #檢查是否允許此動作
   IF NOT arti410_action_chk() THEN
      CLOSE arti410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtea_m.rtea001,g_rtea_m.rtea001_desc,g_rtea_m.rtea002,g_rtea_m.rtea003,g_rtea_m.rtea004, 
       g_rtea_m.rtea005,g_rtea_m.rtea006,g_rtea_m.rtea007,g_rtea_m.rteastus,g_rtea_m.rteaownid,g_rtea_m.rteaownid_desc, 
       g_rtea_m.rteaowndp,g_rtea_m.rteaowndp_desc,g_rtea_m.rteacrtid,g_rtea_m.rteacrtid_desc,g_rtea_m.rteacrtdp, 
       g_rtea_m.rteacrtdp_desc,g_rtea_m.rteacrtdt,g_rtea_m.rteamodid,g_rtea_m.rteamodid_desc,g_rtea_m.rteamoddt 
 
 
   CASE g_rtea_m.rteastus
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
         CASE g_rtea_m.rteastus
            
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
      g_rtea_m.rteastus = lc_state OR cl_null(lc_state) THEN
      CLOSE arti410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_rtea_m.rteamodid = g_user
   LET g_rtea_m.rteamoddt = cl_get_current()
   LET g_rtea_m.rteastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE rtea_t 
      SET (rteastus,rteamodid,rteamoddt) 
        = (g_rtea_m.rteastus,g_rtea_m.rteamodid,g_rtea_m.rteamoddt)     
    WHERE rteaent = g_enterprise AND rtea001 = g_rtea_m.rtea001
      AND rtea002 = g_rtea_m.rtea002
    
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
      EXECUTE arti410_master_referesh USING g_rtea_m.rtea001,g_rtea_m.rtea002 INTO g_rtea_m.rtea001, 
          g_rtea_m.rtea002,g_rtea_m.rtea003,g_rtea_m.rtea004,g_rtea_m.rtea005,g_rtea_m.rtea006,g_rtea_m.rtea007, 
          g_rtea_m.rteastus,g_rtea_m.rteaownid,g_rtea_m.rteaowndp,g_rtea_m.rteacrtid,g_rtea_m.rteacrtdp, 
          g_rtea_m.rteacrtdt,g_rtea_m.rteamodid,g_rtea_m.rteamoddt,g_rtea_m.rtea001_desc,g_rtea_m.rteaownid_desc, 
          g_rtea_m.rteaowndp_desc,g_rtea_m.rteacrtid_desc,g_rtea_m.rteacrtdp_desc,g_rtea_m.rteamodid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_rtea_m.rtea001,g_rtea_m.rtea001_desc,g_rtea_m.rtea002,g_rtea_m.rtea003,g_rtea_m.rtea004, 
          g_rtea_m.rtea005,g_rtea_m.rtea006,g_rtea_m.rtea007,g_rtea_m.rteastus,g_rtea_m.rteaownid,g_rtea_m.rteaownid_desc, 
          g_rtea_m.rteaowndp,g_rtea_m.rteaowndp_desc,g_rtea_m.rteacrtid,g_rtea_m.rteacrtid_desc,g_rtea_m.rteacrtdp, 
          g_rtea_m.rteacrtdp_desc,g_rtea_m.rteacrtdt,g_rtea_m.rteamodid,g_rtea_m.rteamodid_desc,g_rtea_m.rteamoddt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE arti410_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL arti410_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="arti410.signature" >}
   
 
{</section>}
 
{<section id="arti410.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION arti410_set_pk_array()
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
   LET g_pk_array[1].values = g_rtea_m.rtea001
   LET g_pk_array[1].column = 'rtea001'
   LET g_pk_array[2].values = g_rtea_m.rtea002
   LET g_pk_array[2].column = 'rtea002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="arti410.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="arti410.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION arti410_msgcentre_notify(lc_state)
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
   CALL arti410_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_rtea_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="arti410.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION arti410_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="arti410.other_function" readonly="Y" >}

 
{</section>}
 
