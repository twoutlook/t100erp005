#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi359.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-05-16 14:04:30), PR版次:0002(2016-03-26 22:57:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000204
#+ Filename...: aooi359
#+ Description: 常用備註維護作業
#+ Creator....: 02299(2013-07-01 00:00:00)
#+ Modifier...: 02295 -SD/PR- 07900
 
{</section>}
 
{<section id="aooi359.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#31  2016/03/24 By 07900    重复错误信息修改
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
PRIVATE TYPE type_g_oofe_m RECORD
       oofe001 LIKE oofe_t.oofe001, 
   oofe008 LIKE oofe_t.oofe008, 
   oofe002 LIKE oofe_t.oofe002, 
   oofe003 LIKE oofe_t.oofe003, 
   oofe004 LIKE oofe_t.oofe004, 
   oofe005 LIKE oofe_t.oofe005, 
   oofe006 LIKE oofe_t.oofe006, 
   oofe007 LIKE oofe_t.oofe007, 
   oofestus LIKE oofe_t.oofestus, 
   oofeownid LIKE oofe_t.oofeownid, 
   oofeownid_desc LIKE type_t.chr80, 
   oofeowndp LIKE oofe_t.oofeowndp, 
   oofeowndp_desc LIKE type_t.chr80, 
   oofecrtid LIKE oofe_t.oofecrtid, 
   oofecrtid_desc LIKE type_t.chr80, 
   oofecrtdp LIKE oofe_t.oofecrtdp, 
   oofecrtdp_desc LIKE type_t.chr80, 
   oofecrtdt LIKE oofe_t.oofecrtdt, 
   oofemodid LIKE oofe_t.oofemodid, 
   oofemodid_desc LIKE type_t.chr80, 
   oofemoddt LIKE oofe_t.oofemoddt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_oofe001 LIKE oofe_t.oofe001,
      b_oofe002 LIKE oofe_t.oofe002,
      b_oofe003 LIKE oofe_t.oofe003,
      b_oofe004 LIKE oofe_t.oofe004,
      b_oofe005 LIKE oofe_t.oofe005,
      b_oofe006 LIKE oofe_t.oofe006
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_oofe_m        type_g_oofe_m  #單頭變數宣告
DEFINE g_oofe_m_t      type_g_oofe_m  #單頭舊值宣告(系統還原用)
DEFINE g_oofe_m_o      type_g_oofe_m  #單頭舊值宣告(其他用途)
DEFINE g_oofe_m_mask_o type_g_oofe_m  #轉換遮罩前資料
DEFINE g_oofe_m_mask_n type_g_oofe_m  #轉換遮罩後資料
 
   DEFINE g_oofe001_t LIKE oofe_t.oofe001
DEFINE g_oofe002_t LIKE oofe_t.oofe002
DEFINE g_oofe003_t LIKE oofe_t.oofe003
DEFINE g_oofe004_t LIKE oofe_t.oofe004
DEFINE g_oofe005_t LIKE oofe_t.oofe005
DEFINE g_oofe006_t LIKE oofe_t.oofe006
 
   
 
   
 
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
 
{<section id="aooi359.main" >}
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
   CALL cl_ap_init("aoo","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT oofe001,oofe008,oofe002,oofe003,oofe004,oofe005,oofe006,oofe007,oofestus, 
       oofeownid,'',oofeowndp,'',oofecrtid,'',oofecrtdp,'',oofecrtdt,oofemodid,'',oofemoddt", 
                      " FROM oofe_t",
                      " WHERE oofeent= ? AND oofe001=? AND oofe002=? AND oofe003=? AND oofe004=? AND  
                          oofe005=? AND oofe006=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi359_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.oofe001,t0.oofe008,t0.oofe002,t0.oofe003,t0.oofe004,t0.oofe005,t0.oofe006, 
       t0.oofe007,t0.oofestus,t0.oofeownid,t0.oofeowndp,t0.oofecrtid,t0.oofecrtdp,t0.oofecrtdt,t0.oofemodid, 
       t0.oofemoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011",
               " FROM oofe_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.oofeownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.oofeowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.oofecrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.oofecrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.oofemodid  ",
 
               " WHERE t0.oofeent = " ||g_enterprise|| " AND t0.oofe001 = ? AND t0.oofe002 = ? AND t0.oofe003 = ? AND t0.oofe004 = ? AND t0.oofe005 = ? AND t0.oofe006 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aooi359_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooi359 WITH FORM cl_ap_formpath("aoo",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aooi359_init()   
 
      #進入選單 Menu (="N")
      CALL aooi359_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aooi359
      
   END IF 
   
   CLOSE aooi359_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aooi359.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aooi359_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('oofestus','17','N,Y')
 
      CALL cl_set_combo_scc('oofe001','3') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL aooi359_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aooi359.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aooi359_ui_dialog() 
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
            CALL aooi359_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL cl_set_combo_scc_part('oofe001','3','1')
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_oofe_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aooi359_init()
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
               CALL aooi359_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aooi359_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aooi359_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aooi359_set_act_visible()
               CALL aooi359_set_act_no_visible()
               IF NOT (g_oofe_m.oofe001 IS NULL
                 OR g_oofe_m.oofe002 IS NULL
                 OR g_oofe_m.oofe003 IS NULL
                 OR g_oofe_m.oofe004 IS NULL
                 OR g_oofe_m.oofe005 IS NULL
                 OR g_oofe_m.oofe006 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " oofeent = " ||g_enterprise|| " AND",
                                     " oofe001 = '", g_oofe_m.oofe001, "' "
                                     ," AND oofe002 = '", g_oofe_m.oofe002, "' "
                                     ," AND oofe003 = '", g_oofe_m.oofe003, "' "
                                     ," AND oofe004 = '", g_oofe_m.oofe004, "' "
                                     ," AND oofe005 = '", g_oofe_m.oofe005, "' "
                                     ," AND oofe006 = '", g_oofe_m.oofe006, "' "
 
                  #填到對應位置
                  CALL aooi359_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL aooi359_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aooi359_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aooi359_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aooi359_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aooi359_fetch("L")  
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
                  CALL aooi359_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aooi359_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aooi359_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aooi359_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aooi359_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi359_insert()
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
               CALL aooi359_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aooi359_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aooi359_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi359_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi359_set_pk_array()
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
                  CALL aooi359_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL aooi359_browser_fill(g_wc,"")
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aooi359_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aooi359_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aooi359_set_act_visible()
               CALL aooi359_set_act_no_visible()
               IF NOT (g_oofe_m.oofe001 IS NULL
                 OR g_oofe_m.oofe002 IS NULL
                 OR g_oofe_m.oofe003 IS NULL
                 OR g_oofe_m.oofe004 IS NULL
                 OR g_oofe_m.oofe005 IS NULL
                 OR g_oofe_m.oofe006 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " oofeent = " ||g_enterprise|| " AND",
                                     " oofe001 = '", g_oofe_m.oofe001, "' "
                                     ," AND oofe002 = '", g_oofe_m.oofe002, "' "
                                     ," AND oofe003 = '", g_oofe_m.oofe003, "' "
                                     ," AND oofe004 = '", g_oofe_m.oofe004, "' "
                                     ," AND oofe005 = '", g_oofe_m.oofe005, "' "
                                     ," AND oofe006 = '", g_oofe_m.oofe006, "' "
 
                  #填到對應位置
                  CALL aooi359_browser_fill(g_wc,"")
               END IF
         
            
            
            #第一筆資料
            ON ACTION first
               CALL aooi359_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aooi359_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aooi359_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aooi359_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aooi359_fetch("L")  
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
                  CALL aooi359_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aooi359_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aooi359_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aooi359_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aooi359_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi359_insert()
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
               CALL aooi359_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aooi359_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aooi359_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi359_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi359_set_pk_array()
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
 
{<section id="aooi359.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION aooi359_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "oofe001,oofe002,oofe003,oofe004,oofe005,oofe006"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM oofe_t ",
               "  ",
               "  ",
               " WHERE oofeent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("oofe_t")
                
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
      INITIALIZE g_oofe_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.oofestus,t0.oofe001,t0.oofe002,t0.oofe003,t0.oofe004,t0.oofe005,t0.oofe006", 
 
               " FROM oofe_t t0 ",
               "  ",
               
               " WHERE t0.oofeent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("oofe_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"oofe_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_oofe001,g_browser[g_cnt].b_oofe002, 
          g_browser[g_cnt].b_oofe003,g_browser[g_cnt].b_oofe004,g_browser[g_cnt].b_oofe005,g_browser[g_cnt].b_oofe006 
 
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
   
   IF cl_null(g_browser[g_cnt].b_oofe001) THEN
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
 
{<section id="aooi359.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aooi359_construct()
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
   INITIALIZE g_oofe_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON oofe001,oofe008,oofe002,oofe003,oofe004,oofe005,oofe006,oofe007,oofestus, 
          oofeownid,oofeowndp,oofecrtid,oofecrtdp,oofecrtdt,oofemodid,oofemoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<oofecrtdt>>----
         AFTER FIELD oofecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<oofemoddt>>----
         AFTER FIELD oofemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<oofecnfdt>>----
         
         #----<<oofepstdt>>----
 
 
 
      
         #一般欄位
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe001
            #add-point:BEFORE FIELD oofe001 name="construct.b.oofe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe001
            
            #add-point:AFTER FIELD oofe001 name="construct.a.oofe001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oofe001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe001
            #add-point:ON ACTION controlp INFIELD oofe001 name="construct.c.oofe001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe008
            #add-point:BEFORE FIELD oofe008 name="construct.b.oofe008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe008
            
            #add-point:AFTER FIELD oofe008 name="construct.a.oofe008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oofe008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe008
            #add-point:ON ACTION controlp INFIELD oofe008 name="construct.c.oofe008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe002
            #add-point:BEFORE FIELD oofe002 name="construct.b.oofe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe002
            
            #add-point:AFTER FIELD oofe002 name="construct.a.oofe002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oofe002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe002
            #add-point:ON ACTION controlp INFIELD oofe002 name="construct.c.oofe002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe003
            #add-point:BEFORE FIELD oofe003 name="construct.b.oofe003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe003
            
            #add-point:AFTER FIELD oofe003 name="construct.a.oofe003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oofe003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe003
            #add-point:ON ACTION controlp INFIELD oofe003 name="construct.c.oofe003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe004
            #add-point:BEFORE FIELD oofe004 name="construct.b.oofe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe004
            
            #add-point:AFTER FIELD oofe004 name="construct.a.oofe004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oofe004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe004
            #add-point:ON ACTION controlp INFIELD oofe004 name="construct.c.oofe004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe005
            #add-point:BEFORE FIELD oofe005 name="construct.b.oofe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe005
            
            #add-point:AFTER FIELD oofe005 name="construct.a.oofe005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oofe005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe005
            #add-point:ON ACTION controlp INFIELD oofe005 name="construct.c.oofe005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe006
            #add-point:BEFORE FIELD oofe006 name="construct.b.oofe006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe006
            
            #add-point:AFTER FIELD oofe006 name="construct.a.oofe006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oofe006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe006
            #add-point:ON ACTION controlp INFIELD oofe006 name="construct.c.oofe006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe007
            #add-point:BEFORE FIELD oofe007 name="construct.b.oofe007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe007
            
            #add-point:AFTER FIELD oofe007 name="construct.a.oofe007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oofe007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe007
            #add-point:ON ACTION controlp INFIELD oofe007 name="construct.c.oofe007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofestus
            #add-point:BEFORE FIELD oofestus name="construct.b.oofestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofestus
            
            #add-point:AFTER FIELD oofestus name="construct.a.oofestus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oofestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofestus
            #add-point:ON ACTION controlp INFIELD oofestus name="construct.c.oofestus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.oofeownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofeownid
            #add-point:ON ACTION controlp INFIELD oofeownid name="construct.c.oofeownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofeownid  #顯示到畫面上

            NEXT FIELD oofeownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofeownid
            #add-point:BEFORE FIELD oofeownid name="construct.b.oofeownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofeownid
            
            #add-point:AFTER FIELD oofeownid name="construct.a.oofeownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oofeowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofeowndp
            #add-point:ON ACTION controlp INFIELD oofeowndp name="construct.c.oofeowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofeowndp  #顯示到畫面上

            NEXT FIELD oofeowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofeowndp
            #add-point:BEFORE FIELD oofeowndp name="construct.b.oofeowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofeowndp
            
            #add-point:AFTER FIELD oofeowndp name="construct.a.oofeowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oofecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofecrtid
            #add-point:ON ACTION controlp INFIELD oofecrtid name="construct.c.oofecrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofecrtid  #顯示到畫面上

            NEXT FIELD oofecrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofecrtid
            #add-point:BEFORE FIELD oofecrtid name="construct.b.oofecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofecrtid
            
            #add-point:AFTER FIELD oofecrtid name="construct.a.oofecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oofecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofecrtdp
            #add-point:ON ACTION controlp INFIELD oofecrtdp name="construct.c.oofecrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofecrtdp  #顯示到畫面上

            NEXT FIELD oofecrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofecrtdp
            #add-point:BEFORE FIELD oofecrtdp name="construct.b.oofecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofecrtdp
            
            #add-point:AFTER FIELD oofecrtdp name="construct.a.oofecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofecrtdt
            #add-point:BEFORE FIELD oofecrtdt name="construct.b.oofecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.oofemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofemodid
            #add-point:ON ACTION controlp INFIELD oofemodid name="construct.c.oofemodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofemodid  #顯示到畫面上

            NEXT FIELD oofemodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofemodid
            #add-point:BEFORE FIELD oofemodid name="construct.b.oofemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofemodid
            
            #add-point:AFTER FIELD oofemodid name="construct.a.oofemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofemoddt
            #add-point:BEFORE FIELD oofemoddt name="construct.b.oofemoddt"
            
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
 
{<section id="aooi359.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aooi359_query()
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
 
   INITIALIZE g_oofe_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aooi359_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aooi359_browser_fill(g_wc,"F")
      CALL aooi359_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aooi359_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL aooi359_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aooi359.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aooi359_fetch(p_fl)
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
   LET g_oofe_m.oofe001 = g_browser[g_current_idx].b_oofe001
   LET g_oofe_m.oofe002 = g_browser[g_current_idx].b_oofe002
   LET g_oofe_m.oofe003 = g_browser[g_current_idx].b_oofe003
   LET g_oofe_m.oofe004 = g_browser[g_current_idx].b_oofe004
   LET g_oofe_m.oofe005 = g_browser[g_current_idx].b_oofe005
   LET g_oofe_m.oofe006 = g_browser[g_current_idx].b_oofe006
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aooi359_master_referesh USING g_oofe_m.oofe001,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004, 
       g_oofe_m.oofe005,g_oofe_m.oofe006 INTO g_oofe_m.oofe001,g_oofe_m.oofe008,g_oofe_m.oofe002,g_oofe_m.oofe003, 
       g_oofe_m.oofe004,g_oofe_m.oofe005,g_oofe_m.oofe006,g_oofe_m.oofe007,g_oofe_m.oofestus,g_oofe_m.oofeownid, 
       g_oofe_m.oofeowndp,g_oofe_m.oofecrtid,g_oofe_m.oofecrtdp,g_oofe_m.oofecrtdt,g_oofe_m.oofemodid, 
       g_oofe_m.oofemoddt,g_oofe_m.oofeownid_desc,g_oofe_m.oofeowndp_desc,g_oofe_m.oofecrtid_desc,g_oofe_m.oofecrtdp_desc, 
       g_oofe_m.oofemodid_desc
   
   #遮罩相關處理
   LET g_oofe_m_mask_o.* =  g_oofe_m.*
   CALL aooi359_oofe_t_mask()
   LET g_oofe_m_mask_n.* =  g_oofe_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aooi359_set_act_visible()
   CALL aooi359_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_oofe_m_t.* = g_oofe_m.*
   LET g_oofe_m_o.* = g_oofe_m.*
   
   LET g_data_owner = g_oofe_m.oofeownid      
   LET g_data_dept  = g_oofe_m.oofeowndp
   
   #重新顯示
   CALL aooi359_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="aooi359.insert" >}
#+ 資料新增
PRIVATE FUNCTION aooi359_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_oofe_m.* TO NULL             #DEFAULT 設定
   LET g_oofe001_t = NULL
   LET g_oofe002_t = NULL
   LET g_oofe003_t = NULL
   LET g_oofe004_t = NULL
   LET g_oofe005_t = NULL
   LET g_oofe006_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_oofe_m.oofeownid = g_user
      LET g_oofe_m.oofeowndp = g_dept
      LET g_oofe_m.oofecrtid = g_user
      LET g_oofe_m.oofecrtdp = g_dept 
      LET g_oofe_m.oofecrtdt = cl_get_current()
      LET g_oofe_m.oofemodid = g_user
      LET g_oofe_m.oofemoddt = cl_get_current()
      LET g_oofe_m.oofestus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_oofe_m.oofe001 = "1"
 
 
      #add-point:單頭預設值 name="insert.default"
      LET g_oofe_m.oofe004 = ' '
      LET g_oofe_m.oofe005 = ' '
      LET g_oofe_m.oofe006 = ' ' 
      LET g_oofe_m.oofestus = "Y"
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_oofe_m.oofestus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL aooi359_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_oofe_m.* TO NULL
         CALL aooi359_show()
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
   CALL aooi359_set_act_visible()
   CALL aooi359_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_oofe001_t = g_oofe_m.oofe001
   LET g_oofe002_t = g_oofe_m.oofe002
   LET g_oofe003_t = g_oofe_m.oofe003
   LET g_oofe004_t = g_oofe_m.oofe004
   LET g_oofe005_t = g_oofe_m.oofe005
   LET g_oofe006_t = g_oofe_m.oofe006
 
   
   #組合新增資料的條件
   LET g_add_browse = " oofeent = " ||g_enterprise|| " AND",
                      " oofe001 = '", g_oofe_m.oofe001, "' "
                      ," AND oofe002 = '", g_oofe_m.oofe002, "' "
                      ," AND oofe003 = '", g_oofe_m.oofe003, "' "
                      ," AND oofe004 = '", g_oofe_m.oofe004, "' "
                      ," AND oofe005 = '", g_oofe_m.oofe005, "' "
                      ," AND oofe006 = '", g_oofe_m.oofe006, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aooi359_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aooi359_master_referesh USING g_oofe_m.oofe001,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004, 
       g_oofe_m.oofe005,g_oofe_m.oofe006 INTO g_oofe_m.oofe001,g_oofe_m.oofe008,g_oofe_m.oofe002,g_oofe_m.oofe003, 
       g_oofe_m.oofe004,g_oofe_m.oofe005,g_oofe_m.oofe006,g_oofe_m.oofe007,g_oofe_m.oofestus,g_oofe_m.oofeownid, 
       g_oofe_m.oofeowndp,g_oofe_m.oofecrtid,g_oofe_m.oofecrtdp,g_oofe_m.oofecrtdt,g_oofe_m.oofemodid, 
       g_oofe_m.oofemoddt,g_oofe_m.oofeownid_desc,g_oofe_m.oofeowndp_desc,g_oofe_m.oofecrtid_desc,g_oofe_m.oofecrtdp_desc, 
       g_oofe_m.oofemodid_desc
   
   
   #遮罩相關處理
   LET g_oofe_m_mask_o.* =  g_oofe_m.*
   CALL aooi359_oofe_t_mask()
   LET g_oofe_m_mask_n.* =  g_oofe_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_oofe_m.oofe001,g_oofe_m.oofe008,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004, 
       g_oofe_m.oofe005,g_oofe_m.oofe006,g_oofe_m.oofe007,g_oofe_m.oofestus,g_oofe_m.oofeownid,g_oofe_m.oofeownid_desc, 
       g_oofe_m.oofeowndp,g_oofe_m.oofeowndp_desc,g_oofe_m.oofecrtid,g_oofe_m.oofecrtid_desc,g_oofe_m.oofecrtdp, 
       g_oofe_m.oofecrtdp_desc,g_oofe_m.oofecrtdt,g_oofe_m.oofemodid,g_oofe_m.oofemodid_desc,g_oofe_m.oofemoddt 
 
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_oofe_m.oofeownid      
   LET g_data_dept  = g_oofe_m.oofeowndp
 
   #功能已完成,通報訊息中心
   CALL aooi359_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aooi359.modify" >}
#+ 資料修改
PRIVATE FUNCTION aooi359_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_oofe_m.oofe001 IS NULL
 
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
   LET g_oofe001_t = g_oofe_m.oofe001
   LET g_oofe002_t = g_oofe_m.oofe002
   LET g_oofe003_t = g_oofe_m.oofe003
   LET g_oofe004_t = g_oofe_m.oofe004
   LET g_oofe005_t = g_oofe_m.oofe005
   LET g_oofe006_t = g_oofe_m.oofe006
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aooi359_cl USING g_enterprise,g_oofe_m.oofe001,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004,g_oofe_m.oofe005,g_oofe_m.oofe006
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi359_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aooi359_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aooi359_master_referesh USING g_oofe_m.oofe001,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004, 
       g_oofe_m.oofe005,g_oofe_m.oofe006 INTO g_oofe_m.oofe001,g_oofe_m.oofe008,g_oofe_m.oofe002,g_oofe_m.oofe003, 
       g_oofe_m.oofe004,g_oofe_m.oofe005,g_oofe_m.oofe006,g_oofe_m.oofe007,g_oofe_m.oofestus,g_oofe_m.oofeownid, 
       g_oofe_m.oofeowndp,g_oofe_m.oofecrtid,g_oofe_m.oofecrtdp,g_oofe_m.oofecrtdt,g_oofe_m.oofemodid, 
       g_oofe_m.oofemoddt,g_oofe_m.oofeownid_desc,g_oofe_m.oofeowndp_desc,g_oofe_m.oofecrtid_desc,g_oofe_m.oofecrtdp_desc, 
       g_oofe_m.oofemodid_desc
 
   #檢查是否允許此動作
   IF NOT aooi359_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_oofe_m_mask_o.* =  g_oofe_m.*
   CALL aooi359_oofe_t_mask()
   LET g_oofe_m_mask_n.* =  g_oofe_m.*
   
   
 
   #顯示資料
   CALL aooi359_show()
   
   WHILE TRUE
      LET g_oofe_m.oofe001 = g_oofe001_t
      LET g_oofe_m.oofe002 = g_oofe002_t
      LET g_oofe_m.oofe003 = g_oofe003_t
      LET g_oofe_m.oofe004 = g_oofe004_t
      LET g_oofe_m.oofe005 = g_oofe005_t
      LET g_oofe_m.oofe006 = g_oofe006_t
 
      
      #寫入修改者/修改日期資訊
      LET g_oofe_m.oofemodid = g_user 
LET g_oofe_m.oofemoddt = cl_get_current()
LET g_oofe_m.oofemodid_desc = cl_get_username(g_oofe_m.oofemodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL aooi359_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_oofe_m.* = g_oofe_m_t.*
         CALL aooi359_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE oofe_t SET (oofemodid,oofemoddt) = (g_oofe_m.oofemodid,g_oofe_m.oofemoddt)
       WHERE oofeent = g_enterprise AND oofe001 = g_oofe001_t
         AND oofe002 = g_oofe002_t
         AND oofe003 = g_oofe003_t
         AND oofe004 = g_oofe004_t
         AND oofe005 = g_oofe005_t
         AND oofe006 = g_oofe006_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aooi359_set_act_visible()
   CALL aooi359_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " oofeent = " ||g_enterprise|| " AND",
                      " oofe001 = '", g_oofe_m.oofe001, "' "
                      ," AND oofe002 = '", g_oofe_m.oofe002, "' "
                      ," AND oofe003 = '", g_oofe_m.oofe003, "' "
                      ," AND oofe004 = '", g_oofe_m.oofe004, "' "
                      ," AND oofe005 = '", g_oofe_m.oofe005, "' "
                      ," AND oofe006 = '", g_oofe_m.oofe006, "' "
 
   #填到對應位置
   CALL aooi359_browser_fill(g_wc,"")
 
   CLOSE aooi359_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aooi359_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aooi359.input" >}
#+ 資料輸入
PRIVATE FUNCTION aooi359_input(p_cmd)
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
   DISPLAY BY NAME g_oofe_m.oofe001,g_oofe_m.oofe008,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004, 
       g_oofe_m.oofe005,g_oofe_m.oofe006,g_oofe_m.oofe007,g_oofe_m.oofestus,g_oofe_m.oofeownid,g_oofe_m.oofeownid_desc, 
       g_oofe_m.oofeowndp,g_oofe_m.oofeowndp_desc,g_oofe_m.oofecrtid,g_oofe_m.oofecrtid_desc,g_oofe_m.oofecrtdp, 
       g_oofe_m.oofecrtdp_desc,g_oofe_m.oofecrtdt,g_oofe_m.oofemodid,g_oofe_m.oofemodid_desc,g_oofe_m.oofemoddt 
 
   
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
   CALL aooi359_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aooi359_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_oofe_m.oofe001,g_oofe_m.oofe008,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004, 
          g_oofe_m.oofe005,g_oofe_m.oofe006,g_oofe_m.oofe007,g_oofe_m.oofestus 
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
         BEFORE FIELD oofe001
            #add-point:BEFORE FIELD oofe001 name="input.b.oofe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe001
            
            #add-point:AFTER FIELD oofe001 name="input.a.oofe001"
            #此段落由子樣板a05產生
            IF NOT aooi359_key_chk(p_cmd) THEN
               IF p_cmd = 'a' THEN
                  LET g_oofe_m.oofe001 = ''
               ELSE
                  LET g_oofe_m.oofe001 = g_oofe_m_t.oofe001
               END IF 
               NEXT FIELD oofe001
            END IF 



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofe001
            #add-point:ON CHANGE oofe001 name="input.g.oofe001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe008
            #add-point:BEFORE FIELD oofe008 name="input.b.oofe008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe008
            
            #add-point:AFTER FIELD oofe008 name="input.a.oofe008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofe008
            #add-point:ON CHANGE oofe008 name="input.g.oofe008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe002
            #add-point:BEFORE FIELD oofe002 name="input.b.oofe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe002
            
            #add-point:AFTER FIELD oofe002 name="input.a.oofe002"
            #此段落由子樣板a05產生
            IF NOT aooi359_oofe002_chk(p_cmd) THEN
               IF p_cmd = 'a' THEN
                  LET g_oofe_m.oofe002 = ''
               ELSE
                  LET g_oofe_m.oofe002 = g_oofe_m_t.oofe002
               END IF 
               NEXT FIELD oofe002
            END IF 



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofe002
            #add-point:ON CHANGE oofe002 name="input.g.oofe002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe003
            #add-point:BEFORE FIELD oofe003 name="input.b.oofe003"
            IF cl_null(g_oofe_m.oofe002) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aoo-00073'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD oofe002
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe003
            
            #add-point:AFTER FIELD oofe003 name="input.a.oofe003"
            #此段落由子樣板a05產生
            IF NOT aooi359_oofe003_chk(p_cmd) THEN
               IF p_cmd = 'a' THEN
                  LET g_oofe_m.oofe003 = ''
               ELSE
                  LET g_oofe_m.oofe003 = g_oofe_m_t.oofe003
               END IF 
               NEXT FIELD oofe003
            END IF 



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofe003
            #add-point:ON CHANGE oofe003 name="input.g.oofe003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe004
            #add-point:BEFORE FIELD oofe004 name="input.b.oofe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe004
            
            #add-point:AFTER FIELD oofe004 name="input.a.oofe004"
            #此段落由子樣板a05產生
            IF NOT aooi359_key_chk(p_cmd) THEN
               IF p_cmd = 'a' THEN
                  LET g_oofe_m.oofe004 = ''
               ELSE
                  LET g_oofe_m.oofe004 = g_oofe_m_t.oofe004
               END IF 
               NEXT FIELD oofe004
            END IF 



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofe004
            #add-point:ON CHANGE oofe004 name="input.g.oofe004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe005
            #add-point:BEFORE FIELD oofe005 name="input.b.oofe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe005
            
            #add-point:AFTER FIELD oofe005 name="input.a.oofe005"
            #此段落由子樣板a05產生
            IF NOT aooi359_key_chk(p_cmd) THEN
               IF p_cmd = 'a' THEN
                  LET g_oofe_m.oofe005 = ''
               ELSE
                  LET g_oofe_m.oofe005 = g_oofe_m_t.oofe005
               END IF 
               NEXT FIELD oofe005
            END IF 



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofe005
            #add-point:ON CHANGE oofe005 name="input.g.oofe005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe006
            #add-point:BEFORE FIELD oofe006 name="input.b.oofe006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe006
            
            #add-point:AFTER FIELD oofe006 name="input.a.oofe006"
            #此段落由子樣板a05產生
            IF NOT aooi359_key_chk(p_cmd) THEN
               IF p_cmd = 'a' THEN
                  LET g_oofe_m.oofe006 = ''
               ELSE
                  LET g_oofe_m.oofe006 = g_oofe_m_t.oofe006
               END IF 
               NEXT FIELD oofe006
            END IF 



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofe006
            #add-point:ON CHANGE oofe006 name="input.g.oofe006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofe007
            #add-point:BEFORE FIELD oofe007 name="input.b.oofe007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofe007
            
            #add-point:AFTER FIELD oofe007 name="input.a.oofe007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofe007
            #add-point:ON CHANGE oofe007 name="input.g.oofe007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofestus
            #add-point:BEFORE FIELD oofestus name="input.b.oofestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofestus
            
            #add-point:AFTER FIELD oofestus name="input.a.oofestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofestus
            #add-point:ON CHANGE oofestus name="input.g.oofestus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.oofe001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe001
            #add-point:ON ACTION controlp INFIELD oofe001 name="input.c.oofe001"
            
            #END add-point
 
 
         #Ctrlp:input.c.oofe008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe008
            #add-point:ON ACTION controlp INFIELD oofe008 name="input.c.oofe008"
            
            #END add-point
 
 
         #Ctrlp:input.c.oofe002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe002
            #add-point:ON ACTION controlp INFIELD oofe002 name="input.c.oofe002"
            
            #END add-point
 
 
         #Ctrlp:input.c.oofe003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe003
            #add-point:ON ACTION controlp INFIELD oofe003 name="input.c.oofe003"
            
            #END add-point
 
 
         #Ctrlp:input.c.oofe004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe004
            #add-point:ON ACTION controlp INFIELD oofe004 name="input.c.oofe004"
            
            #END add-point
 
 
         #Ctrlp:input.c.oofe005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe005
            #add-point:ON ACTION controlp INFIELD oofe005 name="input.c.oofe005"
            
            #END add-point
 
 
         #Ctrlp:input.c.oofe006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe006
            #add-point:ON ACTION controlp INFIELD oofe006 name="input.c.oofe006"
            
            #END add-point
 
 
         #Ctrlp:input.c.oofe007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofe007
            #add-point:ON ACTION controlp INFIELD oofe007 name="input.c.oofe007"
            
            #END add-point
 
 
         #Ctrlp:input.c.oofestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofestus
            #add-point:ON ACTION controlp INFIELD oofestus name="input.c.oofestus"
            
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
               SELECT COUNT(1) INTO l_count FROM oofe_t
                WHERE oofeent = g_enterprise AND oofe001 = g_oofe_m.oofe001
                  AND oofe002 = g_oofe_m.oofe002
                  AND oofe003 = g_oofe_m.oofe003
                  AND oofe004 = g_oofe_m.oofe004
                  AND oofe005 = g_oofe_m.oofe005
                  AND oofe006 = g_oofe_m.oofe006
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  IF cl_null(g_oofe_m.oofe004) THEN LET g_oofe_m.oofe004 = ' ' END IF 
                  IF cl_null(g_oofe_m.oofe005) THEN LET g_oofe_m.oofe005 = ' ' END IF 
                  IF cl_null(g_oofe_m.oofe006) THEN LET g_oofe_m.oofe006 = ' ' END IF 
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO oofe_t (oofeent,oofe001,oofe008,oofe002,oofe003,oofe004,oofe005,oofe006, 
                      oofe007,oofestus,oofeownid,oofeowndp,oofecrtid,oofecrtdp,oofecrtdt,oofemodid,oofemoddt) 
 
                  VALUES (g_enterprise,g_oofe_m.oofe001,g_oofe_m.oofe008,g_oofe_m.oofe002,g_oofe_m.oofe003, 
                      g_oofe_m.oofe004,g_oofe_m.oofe005,g_oofe_m.oofe006,g_oofe_m.oofe007,g_oofe_m.oofestus, 
                      g_oofe_m.oofeownid,g_oofe_m.oofeowndp,g_oofe_m.oofecrtid,g_oofe_m.oofecrtdp,g_oofe_m.oofecrtdt, 
                      g_oofe_m.oofemodid,g_oofe_m.oofemoddt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oofe_t:",SQLERRMESSAGE 
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
                  LET g_errparam.extend = g_oofe_m.oofe001
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aooi359_oofe_t_mask_restore('restore_mask_o')
               
               UPDATE oofe_t SET (oofe001,oofe008,oofe002,oofe003,oofe004,oofe005,oofe006,oofe007,oofestus, 
                   oofeownid,oofeowndp,oofecrtid,oofecrtdp,oofecrtdt,oofemodid,oofemoddt) = (g_oofe_m.oofe001, 
                   g_oofe_m.oofe008,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004,g_oofe_m.oofe005, 
                   g_oofe_m.oofe006,g_oofe_m.oofe007,g_oofe_m.oofestus,g_oofe_m.oofeownid,g_oofe_m.oofeowndp, 
                   g_oofe_m.oofecrtid,g_oofe_m.oofecrtdp,g_oofe_m.oofecrtdt,g_oofe_m.oofemodid,g_oofe_m.oofemoddt) 
 
                WHERE oofeent = g_enterprise AND oofe001 = g_oofe001_t #
                  AND oofe002 = g_oofe002_t
                  AND oofe003 = g_oofe003_t
                  AND oofe004 = g_oofe004_t
                  AND oofe005 = g_oofe005_t
                  AND oofe006 = g_oofe006_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oofe_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oofe_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL aooi359_oofe_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_oofe_m_t)
                     LET g_log2 = util.JSON.stringify(g_oofe_m)
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
 
{<section id="aooi359.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aooi359_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE oofe_t.oofe001 
   DEFINE l_oldno     LIKE oofe_t.oofe001 
   DEFINE l_newno02     LIKE oofe_t.oofe002 
   DEFINE l_oldno02     LIKE oofe_t.oofe002 
   DEFINE l_newno03     LIKE oofe_t.oofe003 
   DEFINE l_oldno03     LIKE oofe_t.oofe003 
   DEFINE l_newno04     LIKE oofe_t.oofe004 
   DEFINE l_oldno04     LIKE oofe_t.oofe004 
   DEFINE l_newno05     LIKE oofe_t.oofe005 
   DEFINE l_oldno05     LIKE oofe_t.oofe005 
   DEFINE l_newno06     LIKE oofe_t.oofe006 
   DEFINE l_oldno06     LIKE oofe_t.oofe006 
 
   DEFINE l_master    RECORD LIKE oofe_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_oofe_m.oofe001 IS NULL
      OR g_oofe_m.oofe002 IS NULL
      OR g_oofe_m.oofe003 IS NULL
      OR g_oofe_m.oofe004 IS NULL
      OR g_oofe_m.oofe005 IS NULL
      OR g_oofe_m.oofe006 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_oofe001_t = g_oofe_m.oofe001
   LET g_oofe002_t = g_oofe_m.oofe002
   LET g_oofe003_t = g_oofe_m.oofe003
   LET g_oofe004_t = g_oofe_m.oofe004
   LET g_oofe005_t = g_oofe_m.oofe005
   LET g_oofe006_t = g_oofe_m.oofe006
 
   
   #清空key值
   LET g_oofe_m.oofe001 = ""
   LET g_oofe_m.oofe002 = ""
   LET g_oofe_m.oofe003 = ""
   LET g_oofe_m.oofe004 = ""
   LET g_oofe_m.oofe005 = ""
   LET g_oofe_m.oofe006 = ""
 
    
   CALL aooi359_set_entry("a")
   CALL aooi359_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_oofe_m.oofeownid = g_user
      LET g_oofe_m.oofeowndp = g_dept
      LET g_oofe_m.oofecrtid = g_user
      LET g_oofe_m.oofecrtdp = g_dept 
      LET g_oofe_m.oofecrtdt = cl_get_current()
      LET g_oofe_m.oofemodid = g_user
      LET g_oofe_m.oofemoddt = cl_get_current()
      LET g_oofe_m.oofestus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_oofe_m.oofestus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL aooi359_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_oofe_m.* TO NULL
      CALL aooi359_show()
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
   LET l_master.oofemodid = ''
   LET l_master.oofemoddt = ''
   LET l_master.oofestus = "Y"
   #end add-point
   
   #add-point:單頭複製中 name="reproduce.head.m_insert"
   
   #end add-point
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "oofe_t:",SQLERRMESSAGE 
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
   CALL aooi359_set_act_visible()
   CALL aooi359_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_oofe001_t = g_oofe_m.oofe001
   LET g_oofe002_t = g_oofe_m.oofe002
   LET g_oofe003_t = g_oofe_m.oofe003
   LET g_oofe004_t = g_oofe_m.oofe004
   LET g_oofe005_t = g_oofe_m.oofe005
   LET g_oofe006_t = g_oofe_m.oofe006
 
   
   #組合新增資料的條件
   LET g_add_browse = " oofeent = " ||g_enterprise|| " AND",
                      " oofe001 = '", g_oofe_m.oofe001, "' "
                      ," AND oofe002 = '", g_oofe_m.oofe002, "' "
                      ," AND oofe003 = '", g_oofe_m.oofe003, "' "
                      ," AND oofe004 = '", g_oofe_m.oofe004, "' "
                      ," AND oofe005 = '", g_oofe_m.oofe005, "' "
                      ," AND oofe006 = '", g_oofe_m.oofe006, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aooi359_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_oofe_m.oofeownid      
   LET g_data_dept  = g_oofe_m.oofeowndp
              
   #功能已完成,通報訊息中心
   CALL aooi359_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="aooi359.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aooi359_show()
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
   CALL aooi359_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofe_m.oofemodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_oofe_m.oofemodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oofe_m.oofemodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofe_m.oofeownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_oofe_m.oofeownid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oofe_m.oofeownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofe_m.oofeowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofe_m.oofeowndp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oofe_m.oofeowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofe_m.oofecrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofe_m.oofecrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oofe_m.oofecrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofe_m.oofecrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_oofe_m.oofecrtid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oofe_m.oofecrtid_desc

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_oofe_m.oofe001,g_oofe_m.oofe008,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004, 
       g_oofe_m.oofe005,g_oofe_m.oofe006,g_oofe_m.oofe007,g_oofe_m.oofestus,g_oofe_m.oofeownid,g_oofe_m.oofeownid_desc, 
       g_oofe_m.oofeowndp,g_oofe_m.oofeowndp_desc,g_oofe_m.oofecrtid,g_oofe_m.oofecrtid_desc,g_oofe_m.oofecrtdp, 
       g_oofe_m.oofecrtdp_desc,g_oofe_m.oofecrtdt,g_oofe_m.oofemodid,g_oofe_m.oofemodid_desc,g_oofe_m.oofemoddt 
 
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL aooi359_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_oofe_m.oofestus 
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
 
{<section id="aooi359.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aooi359_delete()
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
   IF g_oofe_m.oofe001 IS NULL
   OR g_oofe_m.oofe002 IS NULL
   OR g_oofe_m.oofe003 IS NULL
   OR g_oofe_m.oofe004 IS NULL
   OR g_oofe_m.oofe005 IS NULL
   OR g_oofe_m.oofe006 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_oofe001_t = g_oofe_m.oofe001
   LET g_oofe002_t = g_oofe_m.oofe002
   LET g_oofe003_t = g_oofe_m.oofe003
   LET g_oofe004_t = g_oofe_m.oofe004
   LET g_oofe005_t = g_oofe_m.oofe005
   LET g_oofe006_t = g_oofe_m.oofe006
 
   
   
 
   OPEN aooi359_cl USING g_enterprise,g_oofe_m.oofe001,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004,g_oofe_m.oofe005,g_oofe_m.oofe006
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi359_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aooi359_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aooi359_master_referesh USING g_oofe_m.oofe001,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004, 
       g_oofe_m.oofe005,g_oofe_m.oofe006 INTO g_oofe_m.oofe001,g_oofe_m.oofe008,g_oofe_m.oofe002,g_oofe_m.oofe003, 
       g_oofe_m.oofe004,g_oofe_m.oofe005,g_oofe_m.oofe006,g_oofe_m.oofe007,g_oofe_m.oofestus,g_oofe_m.oofeownid, 
       g_oofe_m.oofeowndp,g_oofe_m.oofecrtid,g_oofe_m.oofecrtdp,g_oofe_m.oofecrtdt,g_oofe_m.oofemodid, 
       g_oofe_m.oofemoddt,g_oofe_m.oofeownid_desc,g_oofe_m.oofeowndp_desc,g_oofe_m.oofecrtid_desc,g_oofe_m.oofecrtdp_desc, 
       g_oofe_m.oofemodid_desc
   
   
   #檢查是否允許此動作
   IF NOT aooi359_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_oofe_m_mask_o.* =  g_oofe_m.*
   CALL aooi359_oofe_t_mask()
   LET g_oofe_m_mask_n.* =  g_oofe_m.*
   
   #將最新資料顯示到畫面上
   CALL aooi359_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi359_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM oofe_t 
       WHERE oofeent = g_enterprise AND oofe001 = g_oofe_m.oofe001 
         AND oofe002 = g_oofe_m.oofe002 
         AND oofe003 = g_oofe_m.oofe003 
         AND oofe004 = g_oofe_m.oofe004 
         AND oofe005 = g_oofe_m.oofe005 
         AND oofe006 = g_oofe_m.oofe006 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oofe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_oofe_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE aooi359_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL aooi359_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL aooi359_browser_fill(g_wc,"")
         CALL aooi359_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aooi359_cl
 
   #功能已完成,通報訊息中心
   CALL aooi359_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aooi359.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aooi359_ui_browser_refresh()
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
      IF g_browser[l_i].b_oofe001 = g_oofe_m.oofe001
         AND g_browser[l_i].b_oofe002 = g_oofe_m.oofe002
         AND g_browser[l_i].b_oofe003 = g_oofe_m.oofe003
         AND g_browser[l_i].b_oofe004 = g_oofe_m.oofe004
         AND g_browser[l_i].b_oofe005 = g_oofe_m.oofe005
         AND g_browser[l_i].b_oofe006 = g_oofe_m.oofe006
 
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
 
{<section id="aooi359.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aooi359_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("oofe001,oofe002,oofe003,oofe004,oofe005,oofe006",TRUE)
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
 
{<section id="aooi359.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aooi359_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("oofe001,oofe002,oofe003,oofe004,oofe005,oofe006",FALSE)
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
 
{<section id="aooi359.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aooi359_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi359.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aooi359_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi359.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aooi359_default_search()
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
      LET ls_wc = ls_wc, " oofe001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " oofe002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " oofe003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " oofe004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " oofe005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " oofe006 = '", g_argv[06], "' AND "
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
 
{<section id="aooi359.mask_functions" >}
&include "erp/aoo/aooi359_mask.4gl"
 
{</section>}
 
{<section id="aooi359.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aooi359_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_oofe_m.oofe001 IS NULL
      OR g_oofe_m.oofe002 IS NULL      OR g_oofe_m.oofe003 IS NULL      OR g_oofe_m.oofe004 IS NULL      OR g_oofe_m.oofe005 IS NULL      OR g_oofe_m.oofe006 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aooi359_cl USING g_enterprise,g_oofe_m.oofe001,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004,g_oofe_m.oofe005,g_oofe_m.oofe006
   IF STATUS THEN
      CLOSE aooi359_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi359_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aooi359_master_referesh USING g_oofe_m.oofe001,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004, 
       g_oofe_m.oofe005,g_oofe_m.oofe006 INTO g_oofe_m.oofe001,g_oofe_m.oofe008,g_oofe_m.oofe002,g_oofe_m.oofe003, 
       g_oofe_m.oofe004,g_oofe_m.oofe005,g_oofe_m.oofe006,g_oofe_m.oofe007,g_oofe_m.oofestus,g_oofe_m.oofeownid, 
       g_oofe_m.oofeowndp,g_oofe_m.oofecrtid,g_oofe_m.oofecrtdp,g_oofe_m.oofecrtdt,g_oofe_m.oofemodid, 
       g_oofe_m.oofemoddt,g_oofe_m.oofeownid_desc,g_oofe_m.oofeowndp_desc,g_oofe_m.oofecrtid_desc,g_oofe_m.oofecrtdp_desc, 
       g_oofe_m.oofemodid_desc
   
 
   #檢查是否允許此動作
   IF NOT aooi359_action_chk() THEN
      CLOSE aooi359_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_oofe_m.oofe001,g_oofe_m.oofe008,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004, 
       g_oofe_m.oofe005,g_oofe_m.oofe006,g_oofe_m.oofe007,g_oofe_m.oofestus,g_oofe_m.oofeownid,g_oofe_m.oofeownid_desc, 
       g_oofe_m.oofeowndp,g_oofe_m.oofeowndp_desc,g_oofe_m.oofecrtid,g_oofe_m.oofecrtid_desc,g_oofe_m.oofecrtdp, 
       g_oofe_m.oofecrtdp_desc,g_oofe_m.oofecrtdt,g_oofe_m.oofemodid,g_oofe_m.oofemodid_desc,g_oofe_m.oofemoddt 
 
 
   CASE g_oofe_m.oofestus
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
         CASE g_oofe_m.oofestus
            
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
      g_oofe_m.oofestus = lc_state OR cl_null(lc_state) THEN
      CLOSE aooi359_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_oofe_m.oofemodid = g_user
   LET g_oofe_m.oofemoddt = cl_get_current()
   LET g_oofe_m.oofestus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE oofe_t 
      SET (oofestus,oofemodid,oofemoddt) 
        = (g_oofe_m.oofestus,g_oofe_m.oofemodid,g_oofe_m.oofemoddt)     
    WHERE oofeent = g_enterprise AND oofe001 = g_oofe_m.oofe001
      AND oofe002 = g_oofe_m.oofe002      AND oofe003 = g_oofe_m.oofe003      AND oofe004 = g_oofe_m.oofe004      AND oofe005 = g_oofe_m.oofe005      AND oofe006 = g_oofe_m.oofe006
    
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
      EXECUTE aooi359_master_referesh USING g_oofe_m.oofe001,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004, 
          g_oofe_m.oofe005,g_oofe_m.oofe006 INTO g_oofe_m.oofe001,g_oofe_m.oofe008,g_oofe_m.oofe002, 
          g_oofe_m.oofe003,g_oofe_m.oofe004,g_oofe_m.oofe005,g_oofe_m.oofe006,g_oofe_m.oofe007,g_oofe_m.oofestus, 
          g_oofe_m.oofeownid,g_oofe_m.oofeowndp,g_oofe_m.oofecrtid,g_oofe_m.oofecrtdp,g_oofe_m.oofecrtdt, 
          g_oofe_m.oofemodid,g_oofe_m.oofemoddt,g_oofe_m.oofeownid_desc,g_oofe_m.oofeowndp_desc,g_oofe_m.oofecrtid_desc, 
          g_oofe_m.oofecrtdp_desc,g_oofe_m.oofemodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_oofe_m.oofe001,g_oofe_m.oofe008,g_oofe_m.oofe002,g_oofe_m.oofe003,g_oofe_m.oofe004, 
          g_oofe_m.oofe005,g_oofe_m.oofe006,g_oofe_m.oofe007,g_oofe_m.oofestus,g_oofe_m.oofeownid,g_oofe_m.oofeownid_desc, 
          g_oofe_m.oofeowndp,g_oofe_m.oofeowndp_desc,g_oofe_m.oofecrtid,g_oofe_m.oofecrtid_desc,g_oofe_m.oofecrtdp, 
          g_oofe_m.oofecrtdp_desc,g_oofe_m.oofecrtdt,g_oofe_m.oofemodid,g_oofe_m.oofemodid_desc,g_oofe_m.oofemoddt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aooi359_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aooi359_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi359.signature" >}
   
 
{</section>}
 
{<section id="aooi359.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aooi359_set_pk_array()
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
   LET g_pk_array[1].values = g_oofe_m.oofe001
   LET g_pk_array[1].column = 'oofe001'
   LET g_pk_array[2].values = g_oofe_m.oofe002
   LET g_pk_array[2].column = 'oofe002'
   LET g_pk_array[3].values = g_oofe_m.oofe003
   LET g_pk_array[3].column = 'oofe003'
   LET g_pk_array[4].values = g_oofe_m.oofe004
   LET g_pk_array[4].column = 'oofe004'
   LET g_pk_array[5].values = g_oofe_m.oofe005
   LET g_pk_array[5].column = 'oofe005'
   LET g_pk_array[6].values = g_oofe_m.oofe006
   LET g_pk_array[6].column = 'oofe006'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi359.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aooi359.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aooi359_msgcentre_notify(lc_state)
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
   CALL aooi359_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_oofe_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi359.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aooi359_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aooi359.other_function" readonly="Y" >}
# 檢查key值是否重複
PRIVATE FUNCTION aooi359_key_chk(p_cmd)
DEFINE p_cmd LIKE type_t.chr1
   IF NOT cl_null(g_oofe_m.oofe001) AND NOT cl_null(g_oofe_m.oofe002) AND NOT cl_null(g_oofe_m.oofe003) AND NOT cl_null(g_oofe_m.oofe004) AND NOT cl_null(g_oofe_m.oofe005) AND NOT cl_null(g_oofe_m.oofe006) THEN 
      IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_oofe_m.oofe001 != g_oofe001_t  OR g_oofe_m.oofe002 != g_oofe002_t  OR g_oofe_m.oofe003 != g_oofe003_t  OR g_oofe_m.oofe004 != g_oofe004_t  OR g_oofe_m.oofe005 != g_oofe005_t  OR g_oofe_m.oofe006 != g_oofe006_t ))) THEN 
         IF NOT ap_chk_notDup(g_oofe_m.oofe002||"~"||g_oofe_m.oofe003,"SELECT COUNT(*) FROM oofe_t WHERE "||"oofeent = '" ||g_enterprise|| "' AND "||"oofe001 = '"||g_oofe_m.oofe001 ||"' AND "|| "oofe002 = '"||g_oofe_m.oofe002 ||"' AND "|| "oofe003 = '"||g_oofe_m.oofe003 ||"' AND "|| "oofe004 = '"||g_oofe_m.oofe004 ||"' AND "|| "oofe005 = '"||g_oofe_m.oofe005 ||"' AND "|| "oofe006 = '"||g_oofe_m.oofe006 ||"'",'std-00004',0) THEN 
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION
# 複製時候檢查key值重複性
PRIVATE FUNCTION aooi359_key_chk_1(p_oofe001,p_oofe002,p_oofe003,p_oofe004,p_oofe005,p_oofe006)
DEFINE p_oofe001 LIKE oofe_t.oofe001
   DEFINE p_oofe002 LIKE oofe_t.oofe002
   DEFINE p_oofe003 LIKE oofe_t.oofe003
   DEFINE p_oofe004 LIKE oofe_t.oofe004
   DEFINE p_oofe005 LIKE oofe_t.oofe005
   DEFINE p_oofe006 LIKE oofe_t.oofe006
   
   IF NOT cl_null(p_oofe001) AND NOT cl_null(p_oofe002) AND NOT cl_null(p_oofe003) AND NOT cl_null(p_oofe004)
      AND NOT cl_null(p_oofe005) AND NOT cl_null(p_oofe006) THEN 
      IF NOT ap_chk_notDup(p_oofe001||"~"||p_oofe002,"SELECT COUNT(*) FROM oofe_t WHERE "||"oofeent = '" ||g_enterprise|| "' AND "||"oofe001 = '"
                     ||p_oofe001 ||"' AND "|| "oofe002 = '"||p_oofe002 ||"' AND "|| "oofe003 = '"||p_oofe003 ||"' AND "
		     || "oofe004 = '"||p_oofe004 ||"' AND "|| "oofe005 = '"||p_oofe005 ||"' AND "|| "oofe006 = '"
		     ||p_oofe006 ||"'",'std-00004',0) THEN 
        RETURN FALSE
      END IF
   END IF 
   RETURN TRUE
END FUNCTION
# 檢查key值是否重複
PRIVATE FUNCTION aooi359_oofe002_chk(p_cmd)
DEFINE l_result LIKE type_t.chr1
   DEFINE p_cmd LIKE type_t.chr1
   CALL aooi359_key_chk(p_cmd) RETURNING l_result
   IF l_result=FALSE THEN
      RETURN FALSE
   ELSE 
      IF NOT ap_chk_isExist(g_oofe_m.oofe002,"SELECT COUNT(*) FROM ooag_t WHERE ooagent = '"
      ||g_enterprise||"' AND ooag001 = ? ","aoo-00074",0 ) THEN
         RETURN FALSE
      END IF 
      IF NOT ap_chk_isExist(g_oofe_m.oofe002,"SELECT COUNT(*) FROM ooag_t WHERE ooagent = '"
      ||g_enterprise||"' AND ooag001 = ? AND ooagstus = 'Y' ","sub-01302","aooi130" ) THEN  #aoo-00071  #160318-00005#31 by 07900 --mod
         RETURN FALSE
      END IF 
      IF NOT cl_null(g_oofe_m.oofe003) THEN 
         IF NOT ap_chk_notDup(g_oofe_m.oofe003,"SELECT COUNT(*) FROM oofe_t WHERE oofeent = '"
         ||g_enterprise||"' AND oofe003 = '"||g_oofe_m.oofe003||"' AND oofe002 = '"||g_oofe_m.oofe002||"' ","aoo-00072",0 ) THEN
            RETURN FALSE
         END IF 
      END IF 
   END IF 
   RETURN TRUE
END FUNCTION
# 檢查oofe002
#
PRIVATE FUNCTION aooi359_oofe002_chk_1(p_oofe001,p_oofe002,p_oofe003,p_oofe004,p_oofe005,p_oofe006)
DEFINE p_oofe001 LIKE oofe_t.oofe001
   DEFINE p_oofe002 LIKE oofe_t.oofe002
   DEFINE p_oofe003 LIKE oofe_t.oofe003
   DEFINE p_oofe004 LIKE oofe_t.oofe004
   DEFINE p_oofe005 LIKE oofe_t.oofe005
   DEFINE p_oofe006 LIKE oofe_t.oofe006
   DEFINE l_result  LIKE type_t.chr1
   
   CALL aooi359_key_chk_1(p_oofe001,p_oofe002,p_oofe003,p_oofe004,p_oofe005,p_oofe006) RETURNING l_result
   IF l_result=1 THEN
      RETURN FALSE
   ELSE 
      IF NOT ap_chk_isExist(p_oofe002,"SELECT COUNT(*) FROM ooag_t WHERE ooagent = '"
      ||g_enterprise||"' AND ooag001 = ? ","aoo-00074",0 ) THEN
         RETURN FALSE
      END IF 
      IF NOT ap_chk_isExist(p_oofe002,"SELECT COUNT(*) FROM ooag_t WHERE ooagent = '"
      ||g_enterprise||"' AND ooag001 = ? AND ooagstus = 'Y' ","sub-01302","aooi130" ) THEN  #aoo-00071  #160318-00005#31 by 07900 --mod
         RETURN FALSE
      END IF 
      IF NOT cl_null(p_oofe003) THEN 
         IF NOT ap_chk_notDup(p_oofe003,"SELECT COUNT(*) FROM oofe_t WHERE oofeent = '"
         ||g_enterprise||"' AND oofe003 = '"||g_oofe_m.oofe003||"' AND oofe002 = '"||g_oofe_m.oofe002||"' ","aoo-00072",0 ) THEN
            RETURN FALSE
         END IF 
      END IF 
   END IF 
   RETURN TRUE
END FUNCTION
# 檢查key值是否重複
PRIVATE FUNCTION aooi359_oofe003_chk(p_cmd)
DEFINE l_result LIKE type_t.chr1
   DEFINE p_cmd LIKE type_t.chr1
   
   IF cl_null(g_oofe_m.oofe003) THEN RETURN '0' END IF 
   CALL aooi359_key_chk(p_cmd) RETURNING l_result
   IF l_result=FALSE THEN
      RETURN FALSE
   ELSE 
      IF NOT ap_chk_notDup(g_oofe_m.oofe002||"~"||g_oofe_m.oofe003,"SELECT COUNT(*) FROM oofe_t WHERE oofeent = '"
      ||g_enterprise||"' AND oofe003 = '"||g_oofe_m.oofe003||"' AND oofe002 = '"||g_oofe_m.oofe002||"' ","aoo-00072",0 ) THEN
         RETURN FALSE
      END IF 
      IF g_oofe_m.oofe003 <= 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aoo-00006'
         LET g_errparam.extend = g_oofe_m.oofe003 
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN FALSE
      END IF 
   END IF 
   RETURN TRUE
END FUNCTION
# 檢查oofe003
PRIVATE FUNCTION aooi359_oofe003_chk_1(p_oofe001,p_oofe002,p_oofe003,p_oofe004,p_oofe005,p_oofe006)
DEFINE p_oofe001 LIKE oofe_t.oofe001
   DEFINE p_oofe002 LIKE oofe_t.oofe002
   DEFINE p_oofe003 LIKE oofe_t.oofe003
   DEFINE p_oofe004 LIKE oofe_t.oofe004
   DEFINE p_oofe005 LIKE oofe_t.oofe005
   DEFINE p_oofe006 LIKE oofe_t.oofe006
   DEFINE l_result  LIKE type_t.chr1
   IF cl_null(p_oofe003) THEN RETURN '0' END IF 
   CALL aooi359_key_chk_1(p_oofe001,p_oofe002,p_oofe003,p_oofe004,p_oofe005,p_oofe006) RETURNING l_result
   IF l_result=FALSE THEN
      RETURN FALSE
   ELSE 
      IF NOT ap_chk_notDup(p_oofe002||"~"||p_oofe003,"SELECT COUNT(*) FROM oofe_t WHERE oofeent = '"
      ||g_enterprise||"' AND oofe003 = '"||p_oofe003||"' AND oofe002 = '"||p_oofe002||"' ","aoo-00072",0 ) THEN
         RETURN FALSE
      END IF 
      IF p_oofe003 <= 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aoo-00006'
         LET g_errparam.extend = p_oofe003 
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN FALSE
      END IF 
   END IF 
   RETURN TRUE
END FUNCTION

 
{</section>}
 
