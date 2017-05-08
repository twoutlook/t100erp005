#該程式未解開Section, 採用最新樣板產出!
{<section id="afmi020.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-02-25 15:16:35), PR版次:0004(2016-04-21 13:59:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000081
#+ Filename...: afmi020
#+ Description: 融資科目設定
#+ Creator....: 02481(2014-08-01 15:51:21)
#+ Modifier...: 07675 -SD/PR- 07959
 
{</section>}
 
{<section id="afmi020.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#38  2016/04/21  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
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
PRIVATE TYPE type_g_fmab_m RECORD
       fmab001 LIKE fmab_t.fmab001, 
   fmab001_desc LIKE type_t.chr80, 
   fmab002 LIKE fmab_t.fmab002, 
   fmab002_desc LIKE type_t.chr80, 
   fmabstus LIKE fmab_t.fmabstus, 
   fmab003 LIKE fmab_t.fmab003, 
   fmab003_desc LIKE type_t.chr80, 
   fmab004 LIKE fmab_t.fmab004, 
   fmab004_desc LIKE type_t.chr80, 
   fmab005 LIKE fmab_t.fmab005, 
   fmab005_desc LIKE type_t.chr80, 
   fmab006 LIKE fmab_t.fmab006, 
   fmab006_desc LIKE type_t.chr80, 
   fmab007 LIKE fmab_t.fmab007, 
   fmab007_desc_desc LIKE type_t.chr80, 
   fmab008 LIKE fmab_t.fmab008, 
   fmab008_desc LIKE type_t.chr80, 
   fmab011 LIKE fmab_t.fmab011, 
   fmab011_desc LIKE type_t.chr80, 
   fmab009 LIKE fmab_t.fmab009, 
   fmab009_desc LIKE type_t.chr80, 
   fmab010 LIKE fmab_t.fmab010, 
   fmab010_desc LIKE type_t.chr80, 
   fmabownid LIKE fmab_t.fmabownid, 
   fmabownid_desc LIKE type_t.chr80, 
   fmabowndp LIKE fmab_t.fmabowndp, 
   fmabowndp_desc LIKE type_t.chr80, 
   fmabcrtid LIKE fmab_t.fmabcrtid, 
   fmabcrtid_desc LIKE type_t.chr80, 
   fmabcrtdp LIKE fmab_t.fmabcrtdp, 
   fmabcrtdp_desc LIKE type_t.chr80, 
   fmabcrtdt LIKE fmab_t.fmabcrtdt, 
   fmabmodid LIKE fmab_t.fmabmodid, 
   fmabmodid_desc LIKE type_t.chr80, 
   fmabmoddt LIKE fmab_t.fmabmoddt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_fmab001 LIKE fmab_t.fmab001,
      b_fmab002 LIKE fmab_t.fmab002
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_fmab_m        type_g_fmab_m  #單頭變數宣告
DEFINE g_fmab_m_t      type_g_fmab_m  #單頭舊值宣告(系統還原用)
DEFINE g_fmab_m_o      type_g_fmab_m  #單頭舊值宣告(其他用途)
DEFINE g_fmab_m_mask_o type_g_fmab_m  #轉換遮罩前資料
DEFINE g_fmab_m_mask_n type_g_fmab_m  #轉換遮罩後資料
 
   DEFINE g_fmab001_t LIKE fmab_t.fmab001
DEFINE g_fmab002_t LIKE fmab_t.fmab002
 
   
 
   
 
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
 
{<section id="afmi020.main" >}
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
   CALL cl_ap_init("afm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fmab001,'',fmab002,'',fmabstus,fmab003,'',fmab004,'',fmab005,'',fmab006, 
       '',fmab007,'',fmab008,'',fmab011,'',fmab009,'',fmab010,'',fmabownid,'',fmabowndp,'',fmabcrtid, 
       '',fmabcrtdp,'',fmabcrtdt,fmabmodid,'',fmabmoddt", 
                      " FROM fmab_t",
                      " WHERE fmabent= ? AND fmab001=? AND fmab002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmi020_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fmab001,t0.fmab002,t0.fmabstus,t0.fmab003,t0.fmab004,t0.fmab005, 
       t0.fmab006,t0.fmab007,t0.fmab008,t0.fmab011,t0.fmab009,t0.fmab010,t0.fmabownid,t0.fmabowndp,t0.fmabcrtid, 
       t0.fmabcrtdp,t0.fmabcrtdt,t0.fmabmodid,t0.fmabmoddt,t1.fmaal003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 , 
       t5.ooefl003 ,t6.ooag011",
               " FROM fmab_t t0",
                              " LEFT JOIN fmaal_t t1 ON t1.fmaalent="||g_enterprise||" AND t1.fmaal001=t0.fmab001 AND t1.fmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.fmabownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.fmabowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.fmabcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.fmabcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.fmabmodid  ",
 
               " WHERE t0.fmabent = " ||g_enterprise|| " AND t0.fmab001 = ? AND t0.fmab002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmi020_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmi020 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmi020_init()   
 
      #進入選單 Menu (="N")
      CALL afmi020_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmi020
      
   END IF 
   
   CLOSE afmi020_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmi020.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmi020_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('fmabstus','17','N,Y')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL afmi020_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="afmi020.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmi020_ui_dialog() 
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
            CALL afmi020_insert()
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
         INITIALIZE g_fmab_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL afmi020_init()
      END IF
      
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL afmi020_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afmi020_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL afmi020_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL afmi020_set_act_visible()
               CALL afmi020_set_act_no_visible()
               IF NOT (g_fmab_m.fmab001 IS NULL
                 OR g_fmab_m.fmab002 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " fmabent = " ||g_enterprise|| " AND",
                                     " fmab001 = '", g_fmab_m.fmab001, "' "
                                     ," AND fmab002 = '", g_fmab_m.fmab002, "' "
 
                  #填到對應位置
                  CALL afmi020_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL afmi020_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afmi020_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL afmi020_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL afmi020_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL afmi020_fetch("L")  
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
                  CALL afmi020_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afmi020_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmi020_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afmi020_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afmi020_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmi020_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmi020_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmi020_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmi020_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmi020_set_pk_array()
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
                  CALL afmi020_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL afmi020_browser_fill(g_wc,"")
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afmi020_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL afmi020_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL afmi020_set_act_visible()
               CALL afmi020_set_act_no_visible()
               IF NOT (g_fmab_m.fmab001 IS NULL
                 OR g_fmab_m.fmab002 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " fmabent = " ||g_enterprise|| " AND",
                                     " fmab001 = '", g_fmab_m.fmab001, "' "
                                     ," AND fmab002 = '", g_fmab_m.fmab002, "' "
 
                  #填到對應位置
                  CALL afmi020_browser_fill(g_wc,"")
               END IF
         
            
            
            #第一筆資料
            ON ACTION first
               CALL afmi020_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afmi020_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL afmi020_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL afmi020_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL afmi020_fetch("L")  
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
                  CALL afmi020_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afmi020_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmi020_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afmi020_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afmi020_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmi020_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmi020_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmi020_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmi020_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmi020_set_pk_array()
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
 
{<section id="afmi020.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION afmi020_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "fmab001,fmab002"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM fmab_t ",
               "  ",
               "  ",
               " WHERE fmabent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("fmab_t")
                
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
   
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_fmab_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.fmabstus,t0.fmab001,t0.fmab002",
               " FROM fmab_t t0 ",
               "  ",
               
               " WHERE t0.fmabent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("fmab_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmab_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fmab001,g_browser[g_cnt].b_fmab002 
 
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
   
   IF cl_null(g_browser[g_cnt].b_fmab001) THEN
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
 
{<section id="afmi020.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmi020_construct()
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
   INITIALIZE g_fmab_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON fmab001,fmab002,fmab002_desc,fmabstus,fmab003,fmab003_desc,fmab004,fmab004_desc, 
          fmab005,fmab005_desc,fmab006,fmab006_desc,fmab007,fmab007_desc_desc,fmab008,fmab008_desc,fmab011, 
          fmab011_desc,fmab009,fmab009_desc,fmab010,fmab010_desc,fmabownid,fmabowndp,fmabcrtid,fmabcrtdp, 
          fmabcrtdt,fmabmodid,fmabmoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fmabcrtdt>>----
         AFTER FIELD fmabcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fmabmoddt>>----
         AFTER FIELD fmabmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmabcnfdt>>----
         
         #----<<fmabpstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.fmab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab001
            #add-point:ON ACTION controlp INFIELD fmab001 name="construct.c.fmab001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmaa001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmab001  #顯示到畫面上
            NEXT FIELD fmab001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab001
            #add-point:BEFORE FIELD fmab001 name="construct.b.fmab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab001
            
            #add-point:AFTER FIELD fmab001 name="construct.a.fmab001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmab002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab002
            #add-point:ON ACTION controlp INFIELD fmab002 name="construct.c.fmab002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET  g_qryparam.arg1 ='0'
            CALL q_ooal002_0()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmab002  #顯示到畫面上
            NEXT FIELD fmab002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab002
            #add-point:BEFORE FIELD fmab002 name="construct.b.fmab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab002
            
            #add-point:AFTER FIELD fmab002 name="construct.a.fmab002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab002_desc
            #add-point:BEFORE FIELD fmab002_desc name="construct.b.fmab002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab002_desc
            
            #add-point:AFTER FIELD fmab002_desc name="construct.a.fmab002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmab002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab002_desc
            #add-point:ON ACTION controlp INFIELD fmab002_desc name="construct.c.fmab002_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmabstus
            #add-point:BEFORE FIELD fmabstus name="construct.b.fmabstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmabstus
            
            #add-point:AFTER FIELD fmabstus name="construct.a.fmabstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmabstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmabstus
            #add-point:ON ACTION controlp INFIELD fmabstus name="construct.c.fmabstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmab003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab003
            #add-point:ON ACTION controlp INFIELD fmab003 name="construct.c.fmab003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmab003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmab003  #顯示到畫面上
            NEXT FIELD fmab003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab003
            #add-point:BEFORE FIELD fmab003 name="construct.b.fmab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab003
            
            #add-point:AFTER FIELD fmab003 name="construct.a.fmab003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab003_desc
            #add-point:BEFORE FIELD fmab003_desc name="construct.b.fmab003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab003_desc
            
            #add-point:AFTER FIELD fmab003_desc name="construct.a.fmab003_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmab003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab003_desc
            #add-point:ON ACTION controlp INFIELD fmab003_desc name="construct.c.fmab003_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmab004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab004
            #add-point:ON ACTION controlp INFIELD fmab004 name="construct.c.fmab004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmab004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmab004  #顯示到畫面上
            NEXT FIELD fmab004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab004
            #add-point:BEFORE FIELD fmab004 name="construct.b.fmab004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab004
            
            #add-point:AFTER FIELD fmab004 name="construct.a.fmab004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab004_desc
            #add-point:BEFORE FIELD fmab004_desc name="construct.b.fmab004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab004_desc
            
            #add-point:AFTER FIELD fmab004_desc name="construct.a.fmab004_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmab004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab004_desc
            #add-point:ON ACTION controlp INFIELD fmab004_desc name="construct.c.fmab004_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab005
            #add-point:ON ACTION controlp INFIELD fmab005 name="construct.c.fmab005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmab005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmab005  #顯示到畫面上
            NEXT FIELD fmab005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab005
            #add-point:BEFORE FIELD fmab005 name="construct.b.fmab005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab005
            
            #add-point:AFTER FIELD fmab005 name="construct.a.fmab005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab005_desc
            #add-point:BEFORE FIELD fmab005_desc name="construct.b.fmab005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab005_desc
            
            #add-point:AFTER FIELD fmab005_desc name="construct.a.fmab005_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmab005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab005_desc
            #add-point:ON ACTION controlp INFIELD fmab005_desc name="construct.c.fmab005_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmab006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab006
            #add-point:ON ACTION controlp INFIELD fmab006 name="construct.c.fmab006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmab006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmab006  #顯示到畫面上
            NEXT FIELD fmab006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab006
            #add-point:BEFORE FIELD fmab006 name="construct.b.fmab006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab006
            
            #add-point:AFTER FIELD fmab006 name="construct.a.fmab006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab006_desc
            #add-point:BEFORE FIELD fmab006_desc name="construct.b.fmab006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab006_desc
            
            #add-point:AFTER FIELD fmab006_desc name="construct.a.fmab006_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmab006_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab006_desc
            #add-point:ON ACTION controlp INFIELD fmab006_desc name="construct.c.fmab006_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmab007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab007
            #add-point:ON ACTION controlp INFIELD fmab007 name="construct.c.fmab007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmab007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmab007  #顯示到畫面上
            NEXT FIELD fmab007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab007
            #add-point:BEFORE FIELD fmab007 name="construct.b.fmab007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab007
            
            #add-point:AFTER FIELD fmab007 name="construct.a.fmab007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab007_desc_desc
            #add-point:BEFORE FIELD fmab007_desc_desc name="construct.b.fmab007_desc_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab007_desc_desc
            
            #add-point:AFTER FIELD fmab007_desc_desc name="construct.a.fmab007_desc_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmab007_desc_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab007_desc_desc
            #add-point:ON ACTION controlp INFIELD fmab007_desc_desc name="construct.c.fmab007_desc_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmab008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab008
            #add-point:ON ACTION controlp INFIELD fmab008 name="construct.c.fmab008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmab008()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmab008  #顯示到畫面上
            NEXT FIELD fmab008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab008
            #add-point:BEFORE FIELD fmab008 name="construct.b.fmab008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab008
            
            #add-point:AFTER FIELD fmab008 name="construct.a.fmab008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab008_desc
            #add-point:BEFORE FIELD fmab008_desc name="construct.b.fmab008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab008_desc
            
            #add-point:AFTER FIELD fmab008_desc name="construct.a.fmab008_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmab008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab008_desc
            #add-point:ON ACTION controlp INFIELD fmab008_desc name="construct.c.fmab008_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmab011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab011
            #add-point:ON ACTION controlp INFIELD fmab011 name="construct.c.fmab011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmab011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmab011  #顯示到畫面上
            NEXT FIELD fmab011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab011
            #add-point:BEFORE FIELD fmab011 name="construct.b.fmab011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab011
            
            #add-point:AFTER FIELD fmab011 name="construct.a.fmab011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab011_desc
            #add-point:BEFORE FIELD fmab011_desc name="construct.b.fmab011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab011_desc
            
            #add-point:AFTER FIELD fmab011_desc name="construct.a.fmab011_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmab011_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab011_desc
            #add-point:ON ACTION controlp INFIELD fmab011_desc name="construct.c.fmab011_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmab009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab009
            #add-point:ON ACTION controlp INFIELD fmab009 name="construct.c.fmab009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmab009()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmab009  #顯示到畫面上
            NEXT FIELD fmab009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab009
            #add-point:BEFORE FIELD fmab009 name="construct.b.fmab009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab009
            
            #add-point:AFTER FIELD fmab009 name="construct.a.fmab009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab009_desc
            #add-point:BEFORE FIELD fmab009_desc name="construct.b.fmab009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab009_desc
            
            #add-point:AFTER FIELD fmab009_desc name="construct.a.fmab009_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmab009_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab009_desc
            #add-point:ON ACTION controlp INFIELD fmab009_desc name="construct.c.fmab009_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmab010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab010
            #add-point:ON ACTION controlp INFIELD fmab010 name="construct.c.fmab010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmab010()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmab010  #顯示到畫面上
            NEXT FIELD fmab010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab010
            #add-point:BEFORE FIELD fmab010 name="construct.b.fmab010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab010
            
            #add-point:AFTER FIELD fmab010 name="construct.a.fmab010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab010_desc
            #add-point:BEFORE FIELD fmab010_desc name="construct.b.fmab010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab010_desc
            
            #add-point:AFTER FIELD fmab010_desc name="construct.a.fmab010_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmab010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab010_desc
            #add-point:ON ACTION controlp INFIELD fmab010_desc name="construct.c.fmab010_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmabownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmabownid
            #add-point:ON ACTION controlp INFIELD fmabownid name="construct.c.fmabownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmabownid  #顯示到畫面上
            NEXT FIELD fmabownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmabownid
            #add-point:BEFORE FIELD fmabownid name="construct.b.fmabownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmabownid
            
            #add-point:AFTER FIELD fmabownid name="construct.a.fmabownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmabowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmabowndp
            #add-point:ON ACTION controlp INFIELD fmabowndp name="construct.c.fmabowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmabowndp  #顯示到畫面上
            NEXT FIELD fmabowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmabowndp
            #add-point:BEFORE FIELD fmabowndp name="construct.b.fmabowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmabowndp
            
            #add-point:AFTER FIELD fmabowndp name="construct.a.fmabowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmabcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmabcrtid
            #add-point:ON ACTION controlp INFIELD fmabcrtid name="construct.c.fmabcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmabcrtid  #顯示到畫面上
            NEXT FIELD fmabcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmabcrtid
            #add-point:BEFORE FIELD fmabcrtid name="construct.b.fmabcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmabcrtid
            
            #add-point:AFTER FIELD fmabcrtid name="construct.a.fmabcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmabcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmabcrtdp
            #add-point:ON ACTION controlp INFIELD fmabcrtdp name="construct.c.fmabcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmabcrtdp  #顯示到畫面上
            NEXT FIELD fmabcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmabcrtdp
            #add-point:BEFORE FIELD fmabcrtdp name="construct.b.fmabcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmabcrtdp
            
            #add-point:AFTER FIELD fmabcrtdp name="construct.a.fmabcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmabcrtdt
            #add-point:BEFORE FIELD fmabcrtdt name="construct.b.fmabcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmabmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmabmodid
            #add-point:ON ACTION controlp INFIELD fmabmodid name="construct.c.fmabmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmabmodid  #顯示到畫面上
            NEXT FIELD fmabmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmabmodid
            #add-point:BEFORE FIELD fmabmodid name="construct.b.fmabmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmabmodid
            
            #add-point:AFTER FIELD fmabmodid name="construct.a.fmabmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmabmoddt
            #add-point:BEFORE FIELD fmabmoddt name="construct.b.fmabmoddt"
            
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
 
{<section id="afmi020.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afmi020_query()
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
 
   INITIALIZE g_fmab_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL afmi020_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afmi020_browser_fill(g_wc,"F")
      CALL afmi020_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL afmi020_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL afmi020_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="afmi020.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afmi020_fetch(p_fl)
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
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_fmab_m.fmab001 = g_browser[g_current_idx].b_fmab001
   LET g_fmab_m.fmab002 = g_browser[g_current_idx].b_fmab002
 
                       
   #讀取單頭所有欄位資料
   EXECUTE afmi020_master_referesh USING g_fmab_m.fmab001,g_fmab_m.fmab002 INTO g_fmab_m.fmab001,g_fmab_m.fmab002, 
       g_fmab_m.fmabstus,g_fmab_m.fmab003,g_fmab_m.fmab004,g_fmab_m.fmab005,g_fmab_m.fmab006,g_fmab_m.fmab007, 
       g_fmab_m.fmab008,g_fmab_m.fmab011,g_fmab_m.fmab009,g_fmab_m.fmab010,g_fmab_m.fmabownid,g_fmab_m.fmabowndp, 
       g_fmab_m.fmabcrtid,g_fmab_m.fmabcrtdp,g_fmab_m.fmabcrtdt,g_fmab_m.fmabmodid,g_fmab_m.fmabmoddt, 
       g_fmab_m.fmab001_desc,g_fmab_m.fmabownid_desc,g_fmab_m.fmabowndp_desc,g_fmab_m.fmabcrtid_desc, 
       g_fmab_m.fmabcrtdp_desc,g_fmab_m.fmabmodid_desc
   
   #遮罩相關處理
   LET g_fmab_m_mask_o.* =  g_fmab_m.*
   CALL afmi020_fmab_t_mask()
   LET g_fmab_m_mask_n.* =  g_fmab_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afmi020_set_act_visible()
   CALL afmi020_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_fmab_m_t.* = g_fmab_m.*
   LET g_fmab_m_o.* = g_fmab_m.*
   
   LET g_data_owner = g_fmab_m.fmabownid      
   LET g_data_dept  = g_fmab_m.fmabowndp
   
   #重新顯示
   CALL afmi020_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="afmi020.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmi020_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_fmab_m.* TO NULL             #DEFAULT 設定
   LET g_fmab001_t = NULL
   LET g_fmab002_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmab_m.fmabownid = g_user
      LET g_fmab_m.fmabowndp = g_dept
      LET g_fmab_m.fmabcrtid = g_user
      LET g_fmab_m.fmabcrtdp = g_dept 
      LET g_fmab_m.fmabcrtdt = cl_get_current()
      LET g_fmab_m.fmabmodid = g_user
      LET g_fmab_m.fmabmoddt = cl_get_current()
      LET g_fmab_m.fmabstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
 
      #add-point:單頭預設值 name="insert.default"
         LET g_fmab_m.fmabstus = 'Y'
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmab_m.fmabstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL afmi020_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_fmab_m.* TO NULL
         CALL afmi020_show()
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
   CALL afmi020_set_act_visible()
   CALL afmi020_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fmab001_t = g_fmab_m.fmab001
   LET g_fmab002_t = g_fmab_m.fmab002
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmabent = " ||g_enterprise|| " AND",
                      " fmab001 = '", g_fmab_m.fmab001, "' "
                      ," AND fmab002 = '", g_fmab_m.fmab002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmi020_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afmi020_master_referesh USING g_fmab_m.fmab001,g_fmab_m.fmab002 INTO g_fmab_m.fmab001,g_fmab_m.fmab002, 
       g_fmab_m.fmabstus,g_fmab_m.fmab003,g_fmab_m.fmab004,g_fmab_m.fmab005,g_fmab_m.fmab006,g_fmab_m.fmab007, 
       g_fmab_m.fmab008,g_fmab_m.fmab011,g_fmab_m.fmab009,g_fmab_m.fmab010,g_fmab_m.fmabownid,g_fmab_m.fmabowndp, 
       g_fmab_m.fmabcrtid,g_fmab_m.fmabcrtdp,g_fmab_m.fmabcrtdt,g_fmab_m.fmabmodid,g_fmab_m.fmabmoddt, 
       g_fmab_m.fmab001_desc,g_fmab_m.fmabownid_desc,g_fmab_m.fmabowndp_desc,g_fmab_m.fmabcrtid_desc, 
       g_fmab_m.fmabcrtdp_desc,g_fmab_m.fmabmodid_desc
   
   
   #遮罩相關處理
   LET g_fmab_m_mask_o.* =  g_fmab_m.*
   CALL afmi020_fmab_t_mask()
   LET g_fmab_m_mask_n.* =  g_fmab_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmab_m.fmab001,g_fmab_m.fmab001_desc,g_fmab_m.fmab002,g_fmab_m.fmab002_desc,g_fmab_m.fmabstus, 
       g_fmab_m.fmab003,g_fmab_m.fmab003_desc,g_fmab_m.fmab004,g_fmab_m.fmab004_desc,g_fmab_m.fmab005, 
       g_fmab_m.fmab005_desc,g_fmab_m.fmab006,g_fmab_m.fmab006_desc,g_fmab_m.fmab007,g_fmab_m.fmab007_desc_desc, 
       g_fmab_m.fmab008,g_fmab_m.fmab008_desc,g_fmab_m.fmab011,g_fmab_m.fmab011_desc,g_fmab_m.fmab009, 
       g_fmab_m.fmab009_desc,g_fmab_m.fmab010,g_fmab_m.fmab010_desc,g_fmab_m.fmabownid,g_fmab_m.fmabownid_desc, 
       g_fmab_m.fmabowndp,g_fmab_m.fmabowndp_desc,g_fmab_m.fmabcrtid,g_fmab_m.fmabcrtid_desc,g_fmab_m.fmabcrtdp, 
       g_fmab_m.fmabcrtdp_desc,g_fmab_m.fmabcrtdt,g_fmab_m.fmabmodid,g_fmab_m.fmabmodid_desc,g_fmab_m.fmabmoddt 
 
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_fmab_m.fmabownid      
   LET g_data_dept  = g_fmab_m.fmabowndp
 
   #功能已完成,通報訊息中心
   CALL afmi020_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afmi020.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmi020_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_fmab_m.fmab001 IS NULL
 
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
   LET g_fmab001_t = g_fmab_m.fmab001
   LET g_fmab002_t = g_fmab_m.fmab002
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN afmi020_cl USING g_enterprise,g_fmab_m.fmab001,g_fmab_m.fmab002
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmi020_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afmi020_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmi020_master_referesh USING g_fmab_m.fmab001,g_fmab_m.fmab002 INTO g_fmab_m.fmab001,g_fmab_m.fmab002, 
       g_fmab_m.fmabstus,g_fmab_m.fmab003,g_fmab_m.fmab004,g_fmab_m.fmab005,g_fmab_m.fmab006,g_fmab_m.fmab007, 
       g_fmab_m.fmab008,g_fmab_m.fmab011,g_fmab_m.fmab009,g_fmab_m.fmab010,g_fmab_m.fmabownid,g_fmab_m.fmabowndp, 
       g_fmab_m.fmabcrtid,g_fmab_m.fmabcrtdp,g_fmab_m.fmabcrtdt,g_fmab_m.fmabmodid,g_fmab_m.fmabmoddt, 
       g_fmab_m.fmab001_desc,g_fmab_m.fmabownid_desc,g_fmab_m.fmabowndp_desc,g_fmab_m.fmabcrtid_desc, 
       g_fmab_m.fmabcrtdp_desc,g_fmab_m.fmabmodid_desc
 
   #檢查是否允許此動作
   IF NOT afmi020_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_fmab_m_mask_o.* =  g_fmab_m.*
   CALL afmi020_fmab_t_mask()
   LET g_fmab_m_mask_n.* =  g_fmab_m.*
   
   
 
   #顯示資料
   CALL afmi020_show()
   
   WHILE TRUE
      LET g_fmab_m.fmab001 = g_fmab001_t
      LET g_fmab_m.fmab002 = g_fmab002_t
 
      
      #寫入修改者/修改日期資訊
      LET g_fmab_m.fmabmodid = g_user 
LET g_fmab_m.fmabmoddt = cl_get_current()
LET g_fmab_m.fmabmodid_desc = cl_get_username(g_fmab_m.fmabmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL afmi020_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_fmab_m.* = g_fmab_m_t.*
         CALL afmi020_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE fmab_t SET (fmabmodid,fmabmoddt) = (g_fmab_m.fmabmodid,g_fmab_m.fmabmoddt)
       WHERE fmabent = g_enterprise AND fmab001 = g_fmab001_t
         AND fmab002 = g_fmab002_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afmi020_set_act_visible()
   CALL afmi020_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fmabent = " ||g_enterprise|| " AND",
                      " fmab001 = '", g_fmab_m.fmab001, "' "
                      ," AND fmab002 = '", g_fmab_m.fmab002, "' "
 
   #填到對應位置
   CALL afmi020_browser_fill(g_wc,"")
 
   CLOSE afmi020_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmi020_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="afmi020.input" >}
#+ 資料輸入
PRIVATE FUNCTION afmi020_input(p_cmd)
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
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmab_m.fmab001,g_fmab_m.fmab001_desc,g_fmab_m.fmab002,g_fmab_m.fmab002_desc,g_fmab_m.fmabstus, 
       g_fmab_m.fmab003,g_fmab_m.fmab003_desc,g_fmab_m.fmab004,g_fmab_m.fmab004_desc,g_fmab_m.fmab005, 
       g_fmab_m.fmab005_desc,g_fmab_m.fmab006,g_fmab_m.fmab006_desc,g_fmab_m.fmab007,g_fmab_m.fmab007_desc_desc, 
       g_fmab_m.fmab008,g_fmab_m.fmab008_desc,g_fmab_m.fmab011,g_fmab_m.fmab011_desc,g_fmab_m.fmab009, 
       g_fmab_m.fmab009_desc,g_fmab_m.fmab010,g_fmab_m.fmab010_desc,g_fmab_m.fmabownid,g_fmab_m.fmabownid_desc, 
       g_fmab_m.fmabowndp,g_fmab_m.fmabowndp_desc,g_fmab_m.fmabcrtid,g_fmab_m.fmabcrtid_desc,g_fmab_m.fmabcrtdp, 
       g_fmab_m.fmabcrtdp_desc,g_fmab_m.fmabcrtdt,g_fmab_m.fmabmodid,g_fmab_m.fmabmodid_desc,g_fmab_m.fmabmoddt 
 
   
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
   CALL afmi020_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afmi020_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_fmab_m.fmab001,g_fmab_m.fmab002,g_fmab_m.fmabstus,g_fmab_m.fmab003,g_fmab_m.fmab004, 
          g_fmab_m.fmab005,g_fmab_m.fmab006,g_fmab_m.fmab007,g_fmab_m.fmab008,g_fmab_m.fmab011,g_fmab_m.fmab009, 
          g_fmab_m.fmab010 
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
         AFTER FIELD fmab001
            
            #add-point:AFTER FIELD fmab001 name="input.a.fmab001"
            IF NOT cl_null(g_fmab_m.fmab001) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

               LET g_chkparam.arg1=g_fmab_m.fmab001     
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_fmab001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab001
            CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmab_m.fmab001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab001_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_fmab_m.fmab001) AND NOT cl_null(g_fmab_m.fmab002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fmab_m.fmab001 != g_fmab001_t  OR g_fmab_m.fmab002 != g_fmab002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmab_t WHERE "||"fmabent = '" ||g_enterprise|| "' AND "||"fmab001 = '"||g_fmab_m.fmab001 ||"' AND "|| "fmab002 = '"||g_fmab_m.fmab002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab001
            #add-point:BEFORE FIELD fmab001 name="input.b.fmab001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmab001
            #add-point:ON CHANGE fmab001 name="input.g.fmab001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab002
            
            #add-point:AFTER FIELD fmab002 name="input.a.fmab002"
            IF NOT cl_null(g_fmab_m.fmab002) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

               LET g_chkparam.arg1=g_fmab_m.fmab002 
               #160318-00025#38  2016/04/21  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00128:sub-01302|aooi071|",cl_get_progname("aooi071",g_lang,"2"),"|:EXEPROGaooi071"
               #160318-00025#38  2016/04/21  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooal002_7") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall002=? ","") RETURNING g_rtn_fields
            LET g_fmab_m.fmab002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab002_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_fmab_m.fmab001) AND NOT cl_null(g_fmab_m.fmab002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fmab_m.fmab001 != g_fmab001_t  OR g_fmab_m.fmab002 != g_fmab002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmab_t WHERE "||"fmabent = '" ||g_enterprise|| "' AND "||"fmab001 = '"||g_fmab_m.fmab001 ||"' AND "|| "fmab002 = '"||g_fmab_m.fmab002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab002
            #add-point:BEFORE FIELD fmab002 name="input.b.fmab002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmab002
            #add-point:ON CHANGE fmab002 name="input.g.fmab002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmabstus
            #add-point:BEFORE FIELD fmabstus name="input.b.fmabstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmabstus
            
            #add-point:AFTER FIELD fmabstus name="input.a.fmabstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmabstus
            #add-point:ON CHANGE fmabstus name="input.g.fmabstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab003
            
            #add-point:AFTER FIELD fmab003 name="input.a.fmab003"
            IF NOT cl_null(g_fmab_m.fmab003) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

               #yangtt 2016/03/18 mod--str
#               LET g_chkparam.arg1=g_fmab_m.fmab003 
#               LET g_chkparam.arg2=g_fmab_m.fmab002 
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_fmab003") THEN                
               LET g_chkparam.arg1=g_fmab_m.fmab002 
               LET g_chkparam.arg2=g_fmab_m.fmab003  
              
               IF cl_chk_exist("v_glac002_4") THEN  #yangtt 2016/03/18 add
               #yangtt 2016/03/18 mod--end
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab003
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=?","")
                 RETURNING g_rtn_fields
            LET g_fmab_m.fmab003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab003
            #add-point:BEFORE FIELD fmab003 name="input.b.fmab003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmab003
            #add-point:ON CHANGE fmab003 name="input.g.fmab003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab004
            
            #add-point:AFTER FIELD fmab004 name="input.a.fmab004"
            IF NOT cl_null(g_fmab_m.fmab004) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

               #yangtt 2016/03/18 mod--str
#               LET g_chkparam.arg1=g_fmab_m.fmab004 
#               LET g_chkparam.arg2=g_fmab_m.fmab002 
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_fmab004") THEN                
               LET g_chkparam.arg1=g_fmab_m.fmab002 
               LET g_chkparam.arg2=g_fmab_m.fmab004  
              
               IF cl_chk_exist("v_glac002_4") THEN 
               #yangtt 2016/03/18 mod--end
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab004
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","") RETURNING g_rtn_fields
            LET g_fmab_m.fmab004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab004
            #add-point:BEFORE FIELD fmab004 name="input.b.fmab004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmab004
            #add-point:ON CHANGE fmab004 name="input.g.fmab004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab005
            
            #add-point:AFTER FIELD fmab005 name="input.a.fmab005"
            IF NOT cl_null(g_fmab_m.fmab005) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

               #yangtt 2016/03/18 mod--str
#               LET g_chkparam.arg1=g_fmab_m.fmab005 
#               LET g_chkparam.arg2=g_fmab_m.fmab002 
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_fmab005") THEN                
               LET g_chkparam.arg1=g_fmab_m.fmab002 
               LET g_chkparam.arg2=g_fmab_m.fmab005  
              
               IF cl_chk_exist("v_glac002_4") THEN 
               #yangtt 2016/03/18 mod--end
               
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab005
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","") RETURNING g_rtn_fields
            LET g_fmab_m.fmab005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab005
            #add-point:BEFORE FIELD fmab005 name="input.b.fmab005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmab005
            #add-point:ON CHANGE fmab005 name="input.g.fmab005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab006
            
            #add-point:AFTER FIELD fmab006 name="input.a.fmab006"
            IF NOT cl_null(g_fmab_m.fmab006) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               #yangtt 2016/03/18 mod--str
#               LET g_chkparam.arg1=g_fmab_m.fmab006 
#               LET g_chkparam.arg2=g_fmab_m.fmab002 
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_fmab006") THEN                
               LET g_chkparam.arg1=g_fmab_m.fmab002 
               LET g_chkparam.arg2=g_fmab_m.fmab006  
              
               IF cl_chk_exist("v_glac002_4") THEN 
               #yangtt 2016/03/18 mod--end
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab006
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","") RETURNING g_rtn_fields
            LET g_fmab_m.fmab006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab006
            #add-point:BEFORE FIELD fmab006 name="input.b.fmab006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmab006
            #add-point:ON CHANGE fmab006 name="input.g.fmab006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab007
            
            #add-point:AFTER FIELD fmab007 name="input.a.fmab007"
            IF NOT cl_null(g_fmab_m.fmab007) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

               #yangtt 2016/03/18 mod--str
#               LET g_chkparam.arg1=g_fmab_m.fmab007 
#               LET g_chkparam.arg2=g_fmab_m.fmab002 
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_fmab007") THEN                
               LET g_chkparam.arg1=g_fmab_m.fmab002 
               LET g_chkparam.arg2=g_fmab_m.fmab007  
              
               IF cl_chk_exist("v_glac002_4") THEN 
               #yangtt 2016/03/18 mod--end
               
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab007
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","")
                 RETURNING g_rtn_fields
            LET g_fmab_m.fmab007_desc_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab007_desc_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab007
            #add-point:BEFORE FIELD fmab007 name="input.b.fmab007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmab007
            #add-point:ON CHANGE fmab007 name="input.g.fmab007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab008
            
            #add-point:AFTER FIELD fmab008 name="input.a.fmab008"
            IF NOT cl_null(g_fmab_m.fmab008) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
                #yangtt 2016/03/18 mod--str
#               LET g_chkparam.arg1=g_fmab_m.fmab008 
#               LET g_chkparam.arg2=g_fmab_m.fmab002 
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_fmab008") THEN                
               LET g_chkparam.arg1=g_fmab_m.fmab002 
               LET g_chkparam.arg2=g_fmab_m.fmab008  
              
               IF cl_chk_exist("v_glac002_4") THEN 
               #yangtt 2016/03/18 mod--end
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab008
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","") RETURNING g_rtn_fields
            LET g_fmab_m.fmab008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab008_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab008
            #add-point:BEFORE FIELD fmab008 name="input.b.fmab008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmab008
            #add-point:ON CHANGE fmab008 name="input.g.fmab008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab011
            
            #add-point:AFTER FIELD fmab011 name="input.a.fmab011"
            IF NOT cl_null(g_fmab_m.fmab011) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

               #yangtt 2016/03/18 mod--str
#               LET g_chkparam.arg1=g_fmab_m.fmab011 
#               LET g_chkparam.arg2=g_fmab_m.fmab002 
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_fmab011") THEN                
               LET g_chkparam.arg1=g_fmab_m.fmab002 
               LET g_chkparam.arg2=g_fmab_m.fmab011  
              
               IF cl_chk_exist("v_glac002_4") THEN 
               #yangtt 2016/03/18 mod--end
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab011
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","")
                 RETURNING g_rtn_fields
            LET g_fmab_m.fmab011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab011
            #add-point:BEFORE FIELD fmab011 name="input.b.fmab011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmab011
            #add-point:ON CHANGE fmab011 name="input.g.fmab011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab009
            
            #add-point:AFTER FIELD fmab009 name="input.a.fmab009"
            IF NOT cl_null(g_fmab_m.fmab009) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

               #yangtt 2016/03/18 mod--str
#               LET g_chkparam.arg1=g_fmab_m.fmab009 
#               LET g_chkparam.arg2=g_fmab_m.fmab002 
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_fmab009") THEN                
               LET g_chkparam.arg1=g_fmab_m.fmab002 
               LET g_chkparam.arg2=g_fmab_m.fmab009  
              
               IF cl_chk_exist("v_glac002_4") THEN 
               #yangtt 2016/03/18 mod--end
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab009
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","")
                 RETURNING g_rtn_fields
            LET g_fmab_m.fmab009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab009_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab009
            #add-point:BEFORE FIELD fmab009 name="input.b.fmab009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmab009
            #add-point:ON CHANGE fmab009 name="input.g.fmab009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmab010
            
            #add-point:AFTER FIELD fmab010 name="input.a.fmab010"
            IF NOT cl_null(g_fmab_m.fmab010) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

               #yangtt 2016/03/18 mod--str
#               LET g_chkparam.arg1=g_fmab_m.fmab010 
#               LET g_chkparam.arg2=g_fmab_m.fmab002 
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_fmab010") THEN                
               LET g_chkparam.arg1=g_fmab_m.fmab002 
               LET g_chkparam.arg2=g_fmab_m.fmab010  
              
               IF cl_chk_exist("v_glac002_4") THEN 
               #yangtt 2016/03/18 mod--end
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab010
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","") 
                 RETURNING g_rtn_fields
            LET g_fmab_m.fmab010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmab010
            #add-point:BEFORE FIELD fmab010 name="input.b.fmab010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmab010
            #add-point:ON CHANGE fmab010 name="input.g.fmab010"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab001
            #add-point:ON ACTION controlp INFIELD fmab001 name="input.c.fmab001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmab_m.fmab001             #給予default值

            #給予arg
                    
            CALL q_fmaa001_1()                                #呼叫開窗

            LET g_fmab_m.fmab001 = g_qryparam.return1              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab001
            CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmall002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmab_m.fmab001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab001_desc
            DISPLAY g_fmab_m.fmab001 TO fmab001              #

            NEXT FIELD fmab001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmab002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab002
            #add-point:ON ACTION controlp INFIELD fmab002 name="input.c.fmab002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmab_m.fmab002             #給予default值

            #給予arg
            LET  g_qryparam.arg1 ='0'      
            CALL q_ooal002_0()                                #呼叫開窗

            LET g_fmab_m.fmab002 = g_qryparam.return1 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall002=? ","") RETURNING g_rtn_fields
            LET g_fmab_m.fmab002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab002_desc         
            DISPLAY g_fmab_m.fmab002 TO fmab002              #

            NEXT FIELD fmab002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmabstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmabstus
            #add-point:ON ACTION controlp INFIELD fmabstus name="input.c.fmabstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmab003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab003
            #add-point:ON ACTION controlp INFIELD fmab003 name="input.c.fmab003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmab_m.fmab003             #給予default值

            #給予arg
            #LET  g_qryparam.arg1 =g_fmab_m.fmab002
             LET g_qryparam.where = "glac001 = '",g_fmab_m.fmab002,"' AND  glac003 <>'1' "
             CALL aglt310_04()                                #呼叫開窗

            LET g_fmab_m.fmab003 = g_qryparam.return1              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab003
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND g_glacl001=? AND glacl002=? ","") 
                 RETURNING g_rtn_fields
            LET g_fmab_m.fmab003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab003_desc
            DISPLAY g_fmab_m.fmab003 TO fmab003              #

            NEXT FIELD fmab003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmab004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab004
            #add-point:ON ACTION controlp INFIELD fmab004 name="input.c.fmab004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmab_m.fmab004             #給予default值

            #給予arg
            LET g_qryparam.where = "glac001 = '",g_fmab_m.fmab002,"' AND  glac003 <>'1' "
             CALL aglt310_04()                                #呼叫開窗

            LET g_fmab_m.fmab004 = g_qryparam.return1              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab004
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","")
                 RETURNING g_rtn_fields
            LET g_fmab_m.fmab004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab004_desc
            DISPLAY g_fmab_m.fmab004 TO fmab004              #

            NEXT FIELD fmab004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab005
            #add-point:ON ACTION controlp INFIELD fmab005 name="input.c.fmab005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmab_m.fmab005             #給予default值

            #給予arg
            LET g_qryparam.where = "glac001 = '",g_fmab_m.fmab002,"' AND  glac003 <>'1' "
             CALL aglt310_04()                                #呼叫開窗

            LET g_fmab_m.fmab005 = g_qryparam.return1              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab005
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","") 
                 RETURNING g_rtn_fields
            LET g_fmab_m.fmab005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab005_desc
            DISPLAY g_fmab_m.fmab005 TO fmab005              #

            NEXT FIELD fmab005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmab006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab006
            #add-point:ON ACTION controlp INFIELD fmab006 name="input.c.fmab006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmab_m.fmab006             #給予default值

            #給予arg
            LET g_qryparam.where = "glac001 = '",g_fmab_m.fmab002,"' AND  glac003 <>'1' "
             CALL aglt310_04()                                #呼叫開窗

            LET g_fmab_m.fmab006 = g_qryparam.return1              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab006
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","") 
                 RETURNING g_rtn_fields
            LET g_fmab_m.fmab006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab006_desc
            DISPLAY g_fmab_m.fmab006 TO fmab006              #

            NEXT FIELD fmab006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmab007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab007
            #add-point:ON ACTION controlp INFIELD fmab007 name="input.c.fmab007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmab_m.fmab007             #給予default值

            #給予arg
            LET g_qryparam.where = "glac001 = '",g_fmab_m.fmab002,"' AND  glac003 <>'1' "
             CALL aglt310_04()                                #呼叫開窗

            LET g_fmab_m.fmab007 = g_qryparam.return1              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab007
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","")
                 RETURNING g_rtn_fields
            LET g_fmab_m.fmab007_desc_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab007_desc_desc
            DISPLAY g_fmab_m.fmab007 TO fmab007              #

            NEXT FIELD fmab007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmab008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab008
            #add-point:ON ACTION controlp INFIELD fmab008 name="input.c.fmab008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmab_m.fmab008             #給予default值

            #給予arg
            LET g_qryparam.where = "glac001 = '",g_fmab_m.fmab002,"' AND  glac003 <>'1' "
             CALL aglt310_04()                                #呼叫開窗

            LET g_fmab_m.fmab008 = g_qryparam.return1              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab008
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","") 
                 RETURNING g_rtn_fields
            LET g_fmab_m.fmab008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab008_desc
            DISPLAY g_fmab_m.fmab008 TO fmab008              #

            NEXT FIELD fmab008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmab011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab011
            #add-point:ON ACTION controlp INFIELD fmab011 name="input.c.fmab011"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmab_m.fmab011             #給予default值

            #給予arg
            LET g_qryparam.where = "glac001 = '",g_fmab_m.fmab002,"' AND  glac003 <>'1' "
             CALL aglt310_04()                                #呼叫開窗

            LET g_fmab_m.fmab011 = g_qryparam.return1              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab011
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","") 
                 RETURNING g_rtn_fields
            LET g_fmab_m.fmab011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab011_desc
            DISPLAY g_fmab_m.fmab011 TO fmab011              #

            NEXT FIELD fmab011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmab009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab009
            #add-point:ON ACTION controlp INFIELD fmab009 name="input.c.fmab009"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmab_m.fmab009             #給予default值

            #給予arg
            LET g_qryparam.where = "glac001 = '",g_fmab_m.fmab002,"' AND  glac003 <>'1' "
             CALL aglt310_04()                                #呼叫開窗

            LET g_fmab_m.fmab009 = g_qryparam.return1              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab009
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","")
                 RETURNING g_rtn_fields
            LET g_fmab_m.fmab009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab009_desc
            DISPLAY g_fmab_m.fmab009 TO fmab009              #

            NEXT FIELD fmab009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmab010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmab010
            #add-point:ON ACTION controlp INFIELD fmab010 name="input.c.fmab010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmab_m.fmab010             #給予default值

            #給予arg
            LET g_qryparam.where = "glac001 = '",g_fmab_m.fmab002,"' AND  glac003 <>'1' "
             CALL aglt310_04()                                #呼叫開窗

            LET g_fmab_m.fmab010 = g_qryparam.return1              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmab_m.fmab002
            LET g_ref_fields[2] = g_fmab_m.fmab010
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","")
                 RETURNING g_rtn_fields
            LET g_fmab_m.fmab010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmab_m.fmab010_desc
            DISPLAY g_fmab_m.fmab010 TO fmab010              #

            NEXT FIELD fmab010                          #返回原欄位


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
               SELECT COUNT(1) INTO l_count FROM fmab_t
                WHERE fmabent = g_enterprise AND fmab001 = g_fmab_m.fmab001
                  AND fmab002 = g_fmab_m.fmab002
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO fmab_t (fmabent,fmab001,fmab002,fmabstus,fmab003,fmab004,fmab005,fmab006, 
                      fmab007,fmab008,fmab011,fmab009,fmab010,fmabownid,fmabowndp,fmabcrtid,fmabcrtdp, 
                      fmabcrtdt,fmabmodid,fmabmoddt)
                  VALUES (g_enterprise,g_fmab_m.fmab001,g_fmab_m.fmab002,g_fmab_m.fmabstus,g_fmab_m.fmab003, 
                      g_fmab_m.fmab004,g_fmab_m.fmab005,g_fmab_m.fmab006,g_fmab_m.fmab007,g_fmab_m.fmab008, 
                      g_fmab_m.fmab011,g_fmab_m.fmab009,g_fmab_m.fmab010,g_fmab_m.fmabownid,g_fmab_m.fmabowndp, 
                      g_fmab_m.fmabcrtid,g_fmab_m.fmabcrtdp,g_fmab_m.fmabcrtdt,g_fmab_m.fmabmodid,g_fmab_m.fmabmoddt)  
 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmab_t:",SQLERRMESSAGE 
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
                  LET g_errparam.extend = g_fmab_m.fmab001
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afmi020_fmab_t_mask_restore('restore_mask_o')
               
               UPDATE fmab_t SET (fmab001,fmab002,fmabstus,fmab003,fmab004,fmab005,fmab006,fmab007,fmab008, 
                   fmab011,fmab009,fmab010,fmabownid,fmabowndp,fmabcrtid,fmabcrtdp,fmabcrtdt,fmabmodid, 
                   fmabmoddt) = (g_fmab_m.fmab001,g_fmab_m.fmab002,g_fmab_m.fmabstus,g_fmab_m.fmab003, 
                   g_fmab_m.fmab004,g_fmab_m.fmab005,g_fmab_m.fmab006,g_fmab_m.fmab007,g_fmab_m.fmab008, 
                   g_fmab_m.fmab011,g_fmab_m.fmab009,g_fmab_m.fmab010,g_fmab_m.fmabownid,g_fmab_m.fmabowndp, 
                   g_fmab_m.fmabcrtid,g_fmab_m.fmabcrtdp,g_fmab_m.fmabcrtdt,g_fmab_m.fmabmodid,g_fmab_m.fmabmoddt) 
 
                WHERE fmabent = g_enterprise AND fmab001 = g_fmab001_t #
                  AND fmab002 = g_fmab002_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmab_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmab_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL afmi020_fmab_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_fmab_m_t)
                     LET g_log2 = util.JSON.stringify(g_fmab_m)
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
 
{<section id="afmi020.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afmi020_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE fmab_t.fmab001 
   DEFINE l_oldno     LIKE fmab_t.fmab001 
   DEFINE l_newno02     LIKE fmab_t.fmab002 
   DEFINE l_oldno02     LIKE fmab_t.fmab002 
 
   DEFINE l_master    RECORD LIKE fmab_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_fmab_m.fmab001 IS NULL
      OR g_fmab_m.fmab002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_fmab001_t = g_fmab_m.fmab001
   LET g_fmab002_t = g_fmab_m.fmab002
 
   
   #清空key值
   LET g_fmab_m.fmab001 = ""
   LET g_fmab_m.fmab002 = ""
 
    
   CALL afmi020_set_entry("a")
   CALL afmi020_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmab_m.fmabownid = g_user
      LET g_fmab_m.fmabowndp = g_dept
      LET g_fmab_m.fmabcrtid = g_user
      LET g_fmab_m.fmabcrtdp = g_dept 
      LET g_fmab_m.fmabcrtdt = cl_get_current()
      LET g_fmab_m.fmabmodid = g_user
      LET g_fmab_m.fmabmoddt = cl_get_current()
      LET g_fmab_m.fmabstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmab_m.fmabstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_fmab_m.fmab001_desc = ''
   DISPLAY BY NAME g_fmab_m.fmab001_desc
   LET g_fmab_m.fmab002_desc = ''
   DISPLAY BY NAME g_fmab_m.fmab002_desc
 
   
   #資料輸入
   CALL afmi020_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_fmab_m.* TO NULL
      CALL afmi020_show()
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
      LET g_errparam.extend = "fmab_t:",SQLERRMESSAGE 
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
   CALL afmi020_set_act_visible()
   CALL afmi020_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fmab001_t = g_fmab_m.fmab001
   LET g_fmab002_t = g_fmab_m.fmab002
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmabent = " ||g_enterprise|| " AND",
                      " fmab001 = '", g_fmab_m.fmab001, "' "
                      ," AND fmab002 = '", g_fmab_m.fmab002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmi020_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_fmab_m.fmabownid      
   LET g_data_dept  = g_fmab_m.fmabowndp
              
   #功能已完成,通報訊息中心
   CALL afmi020_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="afmi020.show" >}
#+ 資料顯示 
PRIVATE FUNCTION afmi020_show()
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
   CALL afmi020_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fmab_m.fmab002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fmab_m.fmab002_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fmab_m.fmab002
   LET g_ref_fields[2] = g_fmab_m.fmab003
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fmab_m.fmab003_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fmab_m.fmab002
   LET g_ref_fields[2] = g_fmab_m.fmab004
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fmab_m.fmab004_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fmab_m.fmab002
   LET g_ref_fields[2] = g_fmab_m.fmab005
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fmab_m.fmab005_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fmab_m.fmab002
   LET g_ref_fields[2] = g_fmab_m.fmab006
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fmab_m.fmab006_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fmab_m.fmab002
   LET g_ref_fields[2] = g_fmab_m.fmab007
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fmab_m.fmab007_desc_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fmab_m.fmab002
   LET g_ref_fields[2] = g_fmab_m.fmab008
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fmab_m.fmab008_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fmab_m.fmab002
   LET g_ref_fields[2] = g_fmab_m.fmab009
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fmab_m.fmab009_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fmab_m.fmab002
   LET g_ref_fields[2] = g_fmab_m.fmab010
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fmab_m.fmab010_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fmab_m.fmab002
   LET g_ref_fields[2] = g_fmab_m.fmab011
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fmab_m.fmab011_desc = '', g_rtn_fields[1] , ''
   
   DISPLAY BY NAME g_fmab_m.fmab002_desc,g_fmab_m.fmab003_desc,g_fmab_m.fmab004_desc,g_fmab_m.fmab005_desc,g_fmab_m.fmab006_desc,
                   g_fmab_m.fmab007_desc_desc,g_fmab_m.fmab008_desc,g_fmab_m.fmab009_desc,g_fmab_m.fmab010_desc,g_fmab_m.fmab011_desc        
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmab_m.fmab001,g_fmab_m.fmab001_desc,g_fmab_m.fmab002,g_fmab_m.fmab002_desc,g_fmab_m.fmabstus, 
       g_fmab_m.fmab003,g_fmab_m.fmab003_desc,g_fmab_m.fmab004,g_fmab_m.fmab004_desc,g_fmab_m.fmab005, 
       g_fmab_m.fmab005_desc,g_fmab_m.fmab006,g_fmab_m.fmab006_desc,g_fmab_m.fmab007,g_fmab_m.fmab007_desc_desc, 
       g_fmab_m.fmab008,g_fmab_m.fmab008_desc,g_fmab_m.fmab011,g_fmab_m.fmab011_desc,g_fmab_m.fmab009, 
       g_fmab_m.fmab009_desc,g_fmab_m.fmab010,g_fmab_m.fmab010_desc,g_fmab_m.fmabownid,g_fmab_m.fmabownid_desc, 
       g_fmab_m.fmabowndp,g_fmab_m.fmabowndp_desc,g_fmab_m.fmabcrtid,g_fmab_m.fmabcrtid_desc,g_fmab_m.fmabcrtdp, 
       g_fmab_m.fmabcrtdp_desc,g_fmab_m.fmabcrtdt,g_fmab_m.fmabmodid,g_fmab_m.fmabmodid_desc,g_fmab_m.fmabmoddt 
 
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL afmi020_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmab_m.fmabstus 
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
 
{<section id="afmi020.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION afmi020_delete()
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
   IF g_fmab_m.fmab001 IS NULL
   OR g_fmab_m.fmab002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_fmab001_t = g_fmab_m.fmab001
   LET g_fmab002_t = g_fmab_m.fmab002
 
   
   
 
   OPEN afmi020_cl USING g_enterprise,g_fmab_m.fmab001,g_fmab_m.fmab002
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmi020_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afmi020_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmi020_master_referesh USING g_fmab_m.fmab001,g_fmab_m.fmab002 INTO g_fmab_m.fmab001,g_fmab_m.fmab002, 
       g_fmab_m.fmabstus,g_fmab_m.fmab003,g_fmab_m.fmab004,g_fmab_m.fmab005,g_fmab_m.fmab006,g_fmab_m.fmab007, 
       g_fmab_m.fmab008,g_fmab_m.fmab011,g_fmab_m.fmab009,g_fmab_m.fmab010,g_fmab_m.fmabownid,g_fmab_m.fmabowndp, 
       g_fmab_m.fmabcrtid,g_fmab_m.fmabcrtdp,g_fmab_m.fmabcrtdt,g_fmab_m.fmabmodid,g_fmab_m.fmabmoddt, 
       g_fmab_m.fmab001_desc,g_fmab_m.fmabownid_desc,g_fmab_m.fmabowndp_desc,g_fmab_m.fmabcrtid_desc, 
       g_fmab_m.fmabcrtdp_desc,g_fmab_m.fmabmodid_desc
   
   
   #檢查是否允許此動作
   IF NOT afmi020_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmab_m_mask_o.* =  g_fmab_m.*
   CALL afmi020_fmab_t_mask()
   LET g_fmab_m_mask_n.* =  g_fmab_m.*
   
   #將最新資料顯示到畫面上
   CALL afmi020_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmi020_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM fmab_t 
       WHERE fmabent = g_enterprise AND fmab001 = g_fmab_m.fmab001 
         AND fmab002 = g_fmab_m.fmab002 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fmab_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE afmi020_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL afmi020_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL afmi020_browser_fill(g_wc,"")
         CALL afmi020_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afmi020_cl
 
   #功能已完成,通報訊息中心
   CALL afmi020_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmi020.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afmi020_ui_browser_refresh()
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
      IF g_browser[l_i].b_fmab001 = g_fmab_m.fmab001
         AND g_browser[l_i].b_fmab002 = g_fmab_m.fmab002
 
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
 
{<section id="afmi020.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afmi020_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("fmab001,fmab002",TRUE)
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
 
{<section id="afmi020.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afmi020_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fmab001,fmab002",FALSE)
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
 
{<section id="afmi020.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afmi020_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmi020.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afmi020_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmi020.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmi020_default_search()
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
      LET ls_wc = ls_wc, " fmab001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " fmab002 = '", g_argv[02], "' AND "
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
 
{<section id="afmi020.mask_functions" >}
&include "erp/afm/afmi020_mask.4gl"
 
{</section>}
 
{<section id="afmi020.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afmi020_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_fmab_m.fmab001 IS NULL
      OR g_fmab_m.fmab002 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afmi020_cl USING g_enterprise,g_fmab_m.fmab001,g_fmab_m.fmab002
   IF STATUS THEN
      CLOSE afmi020_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmi020_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afmi020_master_referesh USING g_fmab_m.fmab001,g_fmab_m.fmab002 INTO g_fmab_m.fmab001,g_fmab_m.fmab002, 
       g_fmab_m.fmabstus,g_fmab_m.fmab003,g_fmab_m.fmab004,g_fmab_m.fmab005,g_fmab_m.fmab006,g_fmab_m.fmab007, 
       g_fmab_m.fmab008,g_fmab_m.fmab011,g_fmab_m.fmab009,g_fmab_m.fmab010,g_fmab_m.fmabownid,g_fmab_m.fmabowndp, 
       g_fmab_m.fmabcrtid,g_fmab_m.fmabcrtdp,g_fmab_m.fmabcrtdt,g_fmab_m.fmabmodid,g_fmab_m.fmabmoddt, 
       g_fmab_m.fmab001_desc,g_fmab_m.fmabownid_desc,g_fmab_m.fmabowndp_desc,g_fmab_m.fmabcrtid_desc, 
       g_fmab_m.fmabcrtdp_desc,g_fmab_m.fmabmodid_desc
   
 
   #檢查是否允許此動作
   IF NOT afmi020_action_chk() THEN
      CLOSE afmi020_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmab_m.fmab001,g_fmab_m.fmab001_desc,g_fmab_m.fmab002,g_fmab_m.fmab002_desc,g_fmab_m.fmabstus, 
       g_fmab_m.fmab003,g_fmab_m.fmab003_desc,g_fmab_m.fmab004,g_fmab_m.fmab004_desc,g_fmab_m.fmab005, 
       g_fmab_m.fmab005_desc,g_fmab_m.fmab006,g_fmab_m.fmab006_desc,g_fmab_m.fmab007,g_fmab_m.fmab007_desc_desc, 
       g_fmab_m.fmab008,g_fmab_m.fmab008_desc,g_fmab_m.fmab011,g_fmab_m.fmab011_desc,g_fmab_m.fmab009, 
       g_fmab_m.fmab009_desc,g_fmab_m.fmab010,g_fmab_m.fmab010_desc,g_fmab_m.fmabownid,g_fmab_m.fmabownid_desc, 
       g_fmab_m.fmabowndp,g_fmab_m.fmabowndp_desc,g_fmab_m.fmabcrtid,g_fmab_m.fmabcrtid_desc,g_fmab_m.fmabcrtdp, 
       g_fmab_m.fmabcrtdp_desc,g_fmab_m.fmabcrtdt,g_fmab_m.fmabmodid,g_fmab_m.fmabmodid_desc,g_fmab_m.fmabmoddt 
 
 
   CASE g_fmab_m.fmabstus
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
         CASE g_fmab_m.fmabstus
            
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
      g_fmab_m.fmabstus = lc_state OR cl_null(lc_state) THEN
      CLOSE afmi020_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_fmab_m.fmabmodid = g_user
   LET g_fmab_m.fmabmoddt = cl_get_current()
   LET g_fmab_m.fmabstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE fmab_t 
      SET (fmabstus,fmabmodid,fmabmoddt) 
        = (g_fmab_m.fmabstus,g_fmab_m.fmabmodid,g_fmab_m.fmabmoddt)     
    WHERE fmabent = g_enterprise AND fmab001 = g_fmab_m.fmab001
      AND fmab002 = g_fmab_m.fmab002
    
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
      EXECUTE afmi020_master_referesh USING g_fmab_m.fmab001,g_fmab_m.fmab002 INTO g_fmab_m.fmab001, 
          g_fmab_m.fmab002,g_fmab_m.fmabstus,g_fmab_m.fmab003,g_fmab_m.fmab004,g_fmab_m.fmab005,g_fmab_m.fmab006, 
          g_fmab_m.fmab007,g_fmab_m.fmab008,g_fmab_m.fmab011,g_fmab_m.fmab009,g_fmab_m.fmab010,g_fmab_m.fmabownid, 
          g_fmab_m.fmabowndp,g_fmab_m.fmabcrtid,g_fmab_m.fmabcrtdp,g_fmab_m.fmabcrtdt,g_fmab_m.fmabmodid, 
          g_fmab_m.fmabmoddt,g_fmab_m.fmab001_desc,g_fmab_m.fmabownid_desc,g_fmab_m.fmabowndp_desc,g_fmab_m.fmabcrtid_desc, 
          g_fmab_m.fmabcrtdp_desc,g_fmab_m.fmabmodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fmab_m.fmab001,g_fmab_m.fmab001_desc,g_fmab_m.fmab002,g_fmab_m.fmab002_desc, 
          g_fmab_m.fmabstus,g_fmab_m.fmab003,g_fmab_m.fmab003_desc,g_fmab_m.fmab004,g_fmab_m.fmab004_desc, 
          g_fmab_m.fmab005,g_fmab_m.fmab005_desc,g_fmab_m.fmab006,g_fmab_m.fmab006_desc,g_fmab_m.fmab007, 
          g_fmab_m.fmab007_desc_desc,g_fmab_m.fmab008,g_fmab_m.fmab008_desc,g_fmab_m.fmab011,g_fmab_m.fmab011_desc, 
          g_fmab_m.fmab009,g_fmab_m.fmab009_desc,g_fmab_m.fmab010,g_fmab_m.fmab010_desc,g_fmab_m.fmabownid, 
          g_fmab_m.fmabownid_desc,g_fmab_m.fmabowndp,g_fmab_m.fmabowndp_desc,g_fmab_m.fmabcrtid,g_fmab_m.fmabcrtid_desc, 
          g_fmab_m.fmabcrtdp,g_fmab_m.fmabcrtdp_desc,g_fmab_m.fmabcrtdt,g_fmab_m.fmabmodid,g_fmab_m.fmabmodid_desc, 
          g_fmab_m.fmabmoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afmi020_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmi020_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmi020.signature" >}
   
 
{</section>}
 
{<section id="afmi020.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmi020_set_pk_array()
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
   LET g_pk_array[1].values = g_fmab_m.fmab001
   LET g_pk_array[1].column = 'fmab001'
   LET g_pk_array[2].values = g_fmab_m.fmab002
   LET g_pk_array[2].column = 'fmab002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmi020.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="afmi020.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afmi020_msgcentre_notify(lc_state)
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
   CALL afmi020_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fmab_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmi020.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afmi020_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmi020.other_function" readonly="Y" >}

 
{</section>}
 
