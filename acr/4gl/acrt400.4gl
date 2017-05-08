#該程式未解開Section, 採用最新樣板產出!
{<section id="acrt400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2015-04-29 16:00:56), PR版次:0009(2016-11-21 14:48:07)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000208
#+ Filename...: acrt400
#+ Description: 潛在客戶等級資料變更作業
#+ Creator....: 02749(2014-04-18 17:21:41)
#+ Modifier...: 06189 -SD/PR- 02159
 
{</section>}
 
{<section id="acrt400.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#27  2016/04/29 BY 07900   校验代码重复错误讯息的修改
#160818-00017#5   2016/08/22 By 08172   修改删除时重新检查状态
#161024-00025#6   2016/10/25 By 02481   组织开窗aooi500规范调整
#160824-00007#104 2016/11/15 By sakura  新舊值備份處理
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
PRIVATE TYPE type_g_crac_m RECORD
       cracunit LIKE crac_t.cracunit, 
   cracunit_desc LIKE type_t.chr80, 
   cracdocdt LIKE crac_t.cracdocdt, 
   cracdocno LIKE crac_t.cracdocno, 
   cracsite LIKE type_t.chr10, 
   crac001 LIKE crac_t.crac001, 
   crac001_desc LIKE type_t.chr80, 
   crac002 LIKE crac_t.crac002, 
   craa032 LIKE type_t.chr10, 
   crac003 LIKE crac_t.crac003, 
   crac003_desc LIKE type_t.chr80, 
   cracstus LIKE crac_t.cracstus, 
   crac004 LIKE crac_t.crac004, 
   crac004_desc LIKE type_t.chr80, 
   crac005 LIKE crac_t.crac005, 
   crac005_desc LIKE type_t.chr80, 
   cracownid LIKE crac_t.cracownid, 
   cracownid_desc LIKE type_t.chr80, 
   cracowndp LIKE crac_t.cracowndp, 
   cracowndp_desc LIKE type_t.chr80, 
   craccrtid LIKE crac_t.craccrtid, 
   craccrtid_desc LIKE type_t.chr80, 
   craccrtdp LIKE crac_t.craccrtdp, 
   craccrtdp_desc LIKE type_t.chr80, 
   craccrtdt LIKE crac_t.craccrtdt, 
   cracmodid LIKE crac_t.cracmodid, 
   cracmodid_desc LIKE type_t.chr80, 
   cracmoddt LIKE crac_t.cracmoddt, 
   craccnfid LIKE crac_t.craccnfid, 
   craccnfid_desc LIKE type_t.chr80, 
   craccnfdt LIKE crac_t.craccnfdt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_cracunit LIKE crac_t.cracunit,
   b_cracunit_desc LIKE type_t.chr80,
      b_cracdocdt LIKE crac_t.cracdocdt,
      b_cracdocno LIKE crac_t.cracdocno,
      b_crac001 LIKE crac_t.crac001,
   b_crac001_desc LIKE type_t.chr80,
      b_crac002 LIKE crac_t.crac002,
      b_crac003 LIKE crac_t.crac003,
   b_crac003_desc LIKE type_t.chr80,
      b_crac004 LIKE crac_t.crac004,
   b_crac004_desc LIKE type_t.chr80,
      b_crac005 LIKE crac_t.crac005,
   b_crac005_desc LIKE type_t.chr80
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_crac_m        type_g_crac_m  #單頭變數宣告
DEFINE g_crac_m_t      type_g_crac_m  #單頭舊值宣告(系統還原用)
DEFINE g_crac_m_o      type_g_crac_m  #單頭舊值宣告(其他用途)
DEFINE g_crac_m_mask_o type_g_crac_m  #轉換遮罩前資料
DEFINE g_crac_m_mask_n type_g_crac_m  #轉換遮罩後資料
 
   DEFINE g_cracdocno_t LIKE crac_t.cracdocno
 
   
 
   
 
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
DEFINE g_ins_site_flag       LIKE type_t.chr1       #紀錄新增單據cracunit是否已輸入  #161024-00025#6--add
#end add-point
 
{</section>}
 
{<section id="acrt400.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("acr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT cracunit,'',cracdocdt,cracdocno,'',crac001,'',crac002,'',crac003,'',cracstus, 
       crac004,'',crac005,'',cracownid,'',cracowndp,'',craccrtid,'',craccrtdp,'',craccrtdt,cracmodid, 
       '',cracmoddt,craccnfid,'',craccnfdt", 
                      " FROM crac_t",
                      " WHERE cracent= ? AND cracdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE acrt400_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.cracunit,t0.cracdocdt,t0.cracdocno,t0.cracsite,t0.crac001,t0.crac002, 
       t0.crac003,t0.cracstus,t0.crac004,t0.crac005,t0.cracownid,t0.cracowndp,t0.craccrtid,t0.craccrtdp, 
       t0.craccrtdt,t0.cracmodid,t0.cracmoddt,t0.craccnfid,t0.craccnfdt,t1.ooefl003 ,t2.craal004 ,t3.oocql004 , 
       t4.oocql004 ,t5.ooag011 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooag011", 
 
               " FROM crac_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.cracunit AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN craal_t t2 ON t2.craalent="||g_enterprise||" AND t2.craal001=t0.crac001 AND t2.craal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='2109' AND t3.oocql002=t0.crac003 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='2105' AND t4.oocql002=t0.crac004 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.crac005  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.cracownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.cracowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.craccrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.craccrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.cracmodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.craccnfid  ",
 
               " WHERE t0.cracent = " ||g_enterprise|| " AND t0.cracdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE acrt400_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrt400 WITH FORM cl_ap_formpath("acr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL acrt400_init()   
 
      #進入選單 Menu (="N")
      CALL acrt400_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_acrt400
      
   END IF 
   
   CLOSE acrt400_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   LET l_success = ''
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="acrt400.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION acrt400_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('cracstus','13','N,Y,A,D,R,W,X')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = '1'
   CALL cl_set_combo_scc('craa032','6052')
   LET l_success = ''
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL acrt400_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="acrt400.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrt400_ui_dialog() 
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
            CALL acrt400_insert()
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
         INITIALIZE g_crac_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL acrt400_init()
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
               CALL acrt400_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL acrt400_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL acrt400_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL acrt400_set_act_visible()
               CALL acrt400_set_act_no_visible()
               IF NOT (g_crac_m.cracdocno IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " cracent = " ||g_enterprise|| " AND",
                                     " cracdocno = '", g_crac_m.cracdocno, "' "
 
                  #填到對應位置
                  CALL acrt400_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL acrt400_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL acrt400_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL acrt400_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL acrt400_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL acrt400_fetch("L")  
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
                  CALL acrt400_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL acrt400_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL acrt400_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL acrt400_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               #160818-00017#5 -s by 08172
               IF g_crac_m.cracstus = 'N' THEN
                  CALL cl_set_act_visible("modify,modify_detail,delete",TRUE)
               ELSE
                  CALL cl_set_act_visible("modify,modify_detail,delete",FALSE)
               END IF
               #160818-00017#5 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL acrt400_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               #160818-00017#5 -s by 08172
               IF g_crac_m.cracstus = 'N' THEN
                  CALL cl_set_act_visible("modify,modify_detail,delete",TRUE)
               ELSE
                  CALL cl_set_act_visible("modify,modify_detail,delete",FALSE)
               END IF
               #160818-00017#5 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL acrt400_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               
               #END add-point
               &include "erp/acr/acrt400_rep.4gl"
               #add-point:ON ACTION output.after name="menu2.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               &include "erp/acr/acrt400_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu2.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL acrt400_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL acrt400_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_crac005
            LET g_action_choice="prog_crac005"
            IF cl_auth_chk_act("prog_crac005") THEN
               
               #add-point:ON ACTION prog_crac005 name="menu2.prog_crac005"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_crac_m.crac005)
               #END add-point
               
            END IF
 
 
 
 
            
            #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu2.bpm_status"
            
            #END add-point
 
 
 
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL acrt400_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL acrt400_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL acrt400_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_crac_m.cracdocdt)
 
 
 
            
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
                  CALL acrt400_fetch("")
 
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
                  CALL acrt400_browser_fill(g_wc,"")
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
                  CALL acrt400_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL acrt400_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL acrt400_set_act_visible()
               CALL acrt400_set_act_no_visible()
               IF NOT (g_crac_m.cracdocno IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " cracent = " ||g_enterprise|| " AND",
                                     " cracdocno = '", g_crac_m.cracdocno, "' "
 
                  #填到對應位置
                  CALL acrt400_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL acrt400_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL acrt400_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL acrt400_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL acrt400_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL acrt400_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL acrt400_fetch("L")  
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
                  CALL acrt400_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL acrt400_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL acrt400_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL acrt400_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#5 -s by 08172
               IF g_crac_m.cracstus = 'N' THEN
                  CALL cl_set_act_visible("modify,modify_detail,delete",TRUE)
               ELSE
                  CALL cl_set_act_visible("modify,modify_detail,delete",FALSE)
               END IF
               #160818-00017#5 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL acrt400_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#5 -s by 08172
               IF g_crac_m.cracstus = 'N' THEN
                  CALL cl_set_act_visible("modify,modify_detail,delete",TRUE)
               ELSE
                  CALL cl_set_act_visible("modify,modify_detail,delete",FALSE)
               END IF
               #160818-00017#5 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL acrt400_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/acr/acrt400_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/acr/acrt400_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL acrt400_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL acrt400_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_crac005
            LET g_action_choice="prog_crac005"
            IF cl_auth_chk_act("prog_crac005") THEN
               
               #add-point:ON ACTION prog_crac005 name="menu.prog_crac005"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_crac_m.crac005)
               #END add-point
               
            END IF
 
 
 
 
            
            #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL acrt400_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL acrt400_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL acrt400_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_crac_m.cracdocdt)
 
 
 
 
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
 
{<section id="acrt400.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION acrt400_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "cracdocno"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"


   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM crac_t ",
               "  ",
               "  ",
               " WHERE cracent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("crac_t")
                
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
      INITIALIZE g_crac_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.cracstus,t0.cracunit,t0.cracdocdt,t0.cracdocno,t0.crac001,t0.crac002,t0.crac003, 
       t0.crac004,t0.crac005,t1.ooefl003 ,t2.craal003 ,t3.oocql004 ,t4.oocql004 ,t5.ooag011",
               " FROM crac_t t0 ",
               "  ",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.cracunit AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN craal_t t2 ON t2.craalent="||g_enterprise||" AND t2.craal001=t0.crac001 AND t2.craal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='2109' AND t3.oocql002=t0.crac003 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='2105' AND t4.oocql002=t0.crac004 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.crac005  ",
 
               " WHERE t0.cracent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("crac_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"crac_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_cracunit,g_browser[g_cnt].b_cracdocdt, 
          g_browser[g_cnt].b_cracdocno,g_browser[g_cnt].b_crac001,g_browser[g_cnt].b_crac002,g_browser[g_cnt].b_crac003, 
          g_browser[g_cnt].b_crac004,g_browser[g_cnt].b_crac005,g_browser[g_cnt].b_cracunit_desc,g_browser[g_cnt].b_crac001_desc, 
          g_browser[g_cnt].b_crac003_desc,g_browser[g_cnt].b_crac004_desc,g_browser[g_cnt].b_crac005_desc 
 
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
         CALL acrt400_browser_mask()
         
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_cracdocno) THEN
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
 
{<section id="acrt400.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION acrt400_construct()
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
   INITIALIZE g_crac_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON cracunit,cracdocdt,cracdocno,crac001,crac002,craa032,crac003,cracstus, 
          crac004,crac005,cracownid,cracowndp,craccrtid,craccrtdp,craccrtdt,cracmodid,cracmoddt,craccnfid, 
          craccnfdt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<craccrtdt>>----
         AFTER FIELD craccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<cracmoddt>>----
         AFTER FIELD cracmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<craccnfdt>>----
         AFTER FIELD craccnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<cracpstdt>>----
 
 
 
      
         #一般欄位
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cracunit
            #add-point:BEFORE FIELD cracunit name="construct.b.cracunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cracunit
            
            #add-point:AFTER FIELD cracunit name="construct.a.cracunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.cracunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cracunit
            #add-point:ON ACTION controlp INFIELD cracunit name="construct.c.cracunit"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'cracunit',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO cracunit          #顯示到畫面上
            NEXT FIELD cracunit                             #返回原欄位  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cracdocdt
            #add-point:BEFORE FIELD cracdocdt name="construct.b.cracdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cracdocdt
            
            #add-point:AFTER FIELD cracdocdt name="construct.a.cracdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.cracdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cracdocdt
            #add-point:ON ACTION controlp INFIELD cracdocdt name="construct.c.cracdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.cracdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cracdocno
            #add-point:ON ACTION controlp INFIELD cracdocno name="construct.c.cracdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_cracdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO cracdocno  #顯示到畫面上
            NEXT FIELD cracdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cracdocno
            #add-point:BEFORE FIELD cracdocno name="construct.b.cracdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cracdocno
            
            #add-point:AFTER FIELD cracdocno name="construct.a.cracdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.crac001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crac001
            #add-point:ON ACTION controlp INFIELD crac001 name="construct.c.crac001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_craa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crac001  #顯示到畫面上
            NEXT FIELD crac001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crac001
            #add-point:BEFORE FIELD crac001 name="construct.b.crac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crac001
            
            #add-point:AFTER FIELD crac001 name="construct.a.crac001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crac002
            #add-point:BEFORE FIELD crac002 name="construct.b.crac002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crac002
            
            #add-point:AFTER FIELD crac002 name="construct.a.crac002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.crac002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crac002
            #add-point:ON ACTION controlp INFIELD crac002 name="construct.c.crac002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD craa032
            #add-point:BEFORE FIELD craa032 name="construct.b.craa032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD craa032
            
            #add-point:AFTER FIELD craa032 name="construct.a.craa032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.craa032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD craa032
            #add-point:ON ACTION controlp INFIELD craa032 name="construct.c.craa032"
            
            #END add-point
 
 
         #Ctrlp:construct.c.crac003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crac003
            #add-point:ON ACTION controlp INFIELD crac003 name="construct.c.crac003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2019"            
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crac003  #顯示到畫面上
            NEXT FIELD crac003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crac003
            #add-point:BEFORE FIELD crac003 name="construct.b.crac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crac003
            
            #add-point:AFTER FIELD crac003 name="construct.a.crac003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cracstus
            #add-point:BEFORE FIELD cracstus name="construct.b.cracstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cracstus
            
            #add-point:AFTER FIELD cracstus name="construct.a.cracstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.cracstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cracstus
            #add-point:ON ACTION controlp INFIELD cracstus name="construct.c.cracstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.crac004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crac004
            #add-point:ON ACTION controlp INFIELD crac004 name="construct.c.crac004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2015" 
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crac004  #顯示到畫面上
            NEXT FIELD crac004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crac004
            #add-point:BEFORE FIELD crac004 name="construct.b.crac004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crac004
            
            #add-point:AFTER FIELD crac004 name="construct.a.crac004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.crac005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crac005
            #add-point:ON ACTION controlp INFIELD crac005 name="construct.c.crac005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crac005  #顯示到畫面上
            NEXT FIELD crac005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crac005
            #add-point:BEFORE FIELD crac005 name="construct.b.crac005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crac005
            
            #add-point:AFTER FIELD crac005 name="construct.a.crac005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.cracownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cracownid
            #add-point:ON ACTION controlp INFIELD cracownid name="construct.c.cracownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO cracownid  #顯示到畫面上
            NEXT FIELD cracownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cracownid
            #add-point:BEFORE FIELD cracownid name="construct.b.cracownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cracownid
            
            #add-point:AFTER FIELD cracownid name="construct.a.cracownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.cracowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cracowndp
            #add-point:ON ACTION controlp INFIELD cracowndp name="construct.c.cracowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO cracowndp  #顯示到畫面上
            NEXT FIELD cracowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cracowndp
            #add-point:BEFORE FIELD cracowndp name="construct.b.cracowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cracowndp
            
            #add-point:AFTER FIELD cracowndp name="construct.a.cracowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.craccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD craccrtid
            #add-point:ON ACTION controlp INFIELD craccrtid name="construct.c.craccrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craccrtid  #顯示到畫面上
            NEXT FIELD craccrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD craccrtid
            #add-point:BEFORE FIELD craccrtid name="construct.b.craccrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD craccrtid
            
            #add-point:AFTER FIELD craccrtid name="construct.a.craccrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.craccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD craccrtdp
            #add-point:ON ACTION controlp INFIELD craccrtdp name="construct.c.craccrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craccrtdp  #顯示到畫面上
            NEXT FIELD craccrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD craccrtdp
            #add-point:BEFORE FIELD craccrtdp name="construct.b.craccrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD craccrtdp
            
            #add-point:AFTER FIELD craccrtdp name="construct.a.craccrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD craccrtdt
            #add-point:BEFORE FIELD craccrtdt name="construct.b.craccrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.cracmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cracmodid
            #add-point:ON ACTION controlp INFIELD cracmodid name="construct.c.cracmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO cracmodid  #顯示到畫面上
            NEXT FIELD cracmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cracmodid
            #add-point:BEFORE FIELD cracmodid name="construct.b.cracmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cracmodid
            
            #add-point:AFTER FIELD cracmodid name="construct.a.cracmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cracmoddt
            #add-point:BEFORE FIELD cracmoddt name="construct.b.cracmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.craccnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD craccnfid
            #add-point:ON ACTION controlp INFIELD craccnfid name="construct.c.craccnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craccnfid  #顯示到畫面上
            NEXT FIELD craccnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD craccnfid
            #add-point:BEFORE FIELD craccnfid name="construct.b.craccnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD craccnfid
            
            #add-point:AFTER FIELD craccnfid name="construct.a.craccnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD craccnfdt
            #add-point:BEFORE FIELD craccnfdt name="construct.b.craccnfdt"
            
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
 
{<section id="acrt400.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION acrt400_filter()
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
      CONSTRUCT g_wc_filter ON cracunit,cracdocdt,cracdocno,crac001,crac002,crac003,crac004,crac005
                          FROM s_browse[1].b_cracunit,s_browse[1].b_cracdocdt,s_browse[1].b_cracdocno, 
                              s_browse[1].b_crac001,s_browse[1].b_crac002,s_browse[1].b_crac003,s_browse[1].b_crac004, 
                              s_browse[1].b_crac005
 
         BEFORE CONSTRUCT
               DISPLAY acrt400_filter_parser('cracunit') TO s_browse[1].b_cracunit
            DISPLAY acrt400_filter_parser('cracdocdt') TO s_browse[1].b_cracdocdt
            DISPLAY acrt400_filter_parser('cracdocno') TO s_browse[1].b_cracdocno
            DISPLAY acrt400_filter_parser('crac001') TO s_browse[1].b_crac001
            DISPLAY acrt400_filter_parser('crac002') TO s_browse[1].b_crac002
            DISPLAY acrt400_filter_parser('crac003') TO s_browse[1].b_crac003
            DISPLAY acrt400_filter_parser('crac004') TO s_browse[1].b_crac004
            DISPLAY acrt400_filter_parser('crac005') TO s_browse[1].b_crac005
      
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
 
      CALL acrt400_filter_show('cracunit')
   CALL acrt400_filter_show('cracdocdt')
   CALL acrt400_filter_show('cracdocno')
   CALL acrt400_filter_show('crac001')
   CALL acrt400_filter_show('crac002')
   CALL acrt400_filter_show('crac003')
   CALL acrt400_filter_show('crac004')
   CALL acrt400_filter_show('crac005')
 
END FUNCTION
 
{</section>}
 
{<section id="acrt400.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION acrt400_filter_parser(ps_field)
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
 
{<section id="acrt400.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION acrt400_filter_show(ps_field)
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
   LET ls_condition = acrt400_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="acrt400.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION acrt400_query()
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
 
   INITIALIZE g_crac_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL acrt400_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL acrt400_browser_fill(g_wc,"F")
      CALL acrt400_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL acrt400_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL acrt400_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="acrt400.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION acrt400_fetch(p_fl)
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
   LET g_crac_m.cracdocno = g_browser[g_current_idx].b_cracdocno
 
                       
   #讀取單頭所有欄位資料
   EXECUTE acrt400_master_referesh USING g_crac_m.cracdocno INTO g_crac_m.cracunit,g_crac_m.cracdocdt, 
       g_crac_m.cracdocno,g_crac_m.cracsite,g_crac_m.crac001,g_crac_m.crac002,g_crac_m.crac003,g_crac_m.cracstus, 
       g_crac_m.crac004,g_crac_m.crac005,g_crac_m.cracownid,g_crac_m.cracowndp,g_crac_m.craccrtid,g_crac_m.craccrtdp, 
       g_crac_m.craccrtdt,g_crac_m.cracmodid,g_crac_m.cracmoddt,g_crac_m.craccnfid,g_crac_m.craccnfdt, 
       g_crac_m.cracunit_desc,g_crac_m.crac001_desc,g_crac_m.crac003_desc,g_crac_m.crac004_desc,g_crac_m.crac005_desc, 
       g_crac_m.cracownid_desc,g_crac_m.cracowndp_desc,g_crac_m.craccrtid_desc,g_crac_m.craccrtdp_desc, 
       g_crac_m.cracmodid_desc,g_crac_m.craccnfid_desc
   
   #遮罩相關處理
   LET g_crac_m_mask_o.* =  g_crac_m.*
   CALL acrt400_crac_t_mask()
   LET g_crac_m_mask_n.* =  g_crac_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL acrt400_set_act_visible()
   CALL acrt400_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   #ADD BY zhujing 2015-4-30---(S)
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   IF g_crac_m.cracstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #ADD BY zhujing 2015-4-30---(E)
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_crac_m_t.* = g_crac_m.*
   LET g_crac_m_o.* = g_crac_m.*
   
   LET g_data_owner = g_crac_m.cracownid      
   LET g_data_dept  = g_crac_m.cracowndp
   
   #重新顯示
   CALL acrt400_show()
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="acrt400.insert" >}
#+ 資料新增
PRIVATE FUNCTION acrt400_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_insert    LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_crac_m.* TO NULL             #DEFAULT 設定
   LET g_cracdocno_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_crac_m.cracownid = g_user
      LET g_crac_m.cracowndp = g_dept
      LET g_crac_m.craccrtid = g_user
      LET g_crac_m.craccrtdp = g_dept 
      LET g_crac_m.craccrtdt = cl_get_current()
      LET g_crac_m.cracmodid = g_user
      LET g_crac_m.cracmoddt = cl_get_current()
      LET g_crac_m.cracstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_crac_m.craa032 = "0"
      LET g_crac_m.cracstus = "N"
 
 
      #add-point:單頭預設值 name="insert.default"
    # LET g_crac_m.cracunit = g_site  #161024-00025#6--mark
      LET g_crac_m.cracunit_desc = acrt400_get_org_ref(g_crac_m.cracunit)
      LET g_crac_m.cracdocdt = cl_get_current()
    #161024-00025#6--add--begin----------  
      LET g_ins_site_flag = FALSE   
      CALL s_aooi500_default(g_prog,'cracunit',g_site)
       RETURNING l_insert,g_crac_m.cracunit
      IF NOT l_insert THEN
        RETURN
      END IF
      
      CALL s_aooi500_default(g_prog,'cracsite',g_site)
       RETURNING l_insert,g_crac_m.cracsite
      IF NOT l_insert THEN
        RETURN
      END IF
      
      
    #161024-00025#6--add---end------------
      CALL s_arti200_get_def_doc_type(g_site,g_prog,'1') RETURNING l_success,g_crac_m.cracdocno
      IF NOT l_success THEN
         LET g_crac_m.cracdocno = ''
      END IF
      LET g_crac_m_t.* = g_crac_m.*
      LET g_crac_m_o.* = g_crac_m.*  #160824-00007#104 by sakura add
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_crac_m.cracstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL acrt400_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_crac_m.* TO NULL
         CALL acrt400_show()
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
   CALL acrt400_set_act_visible()
   CALL acrt400_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_cracdocno_t = g_crac_m.cracdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " cracent = " ||g_enterprise|| " AND",
                      " cracdocno = '", g_crac_m.cracdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL acrt400_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE acrt400_master_referesh USING g_crac_m.cracdocno INTO g_crac_m.cracunit,g_crac_m.cracdocdt, 
       g_crac_m.cracdocno,g_crac_m.cracsite,g_crac_m.crac001,g_crac_m.crac002,g_crac_m.crac003,g_crac_m.cracstus, 
       g_crac_m.crac004,g_crac_m.crac005,g_crac_m.cracownid,g_crac_m.cracowndp,g_crac_m.craccrtid,g_crac_m.craccrtdp, 
       g_crac_m.craccrtdt,g_crac_m.cracmodid,g_crac_m.cracmoddt,g_crac_m.craccnfid,g_crac_m.craccnfdt, 
       g_crac_m.cracunit_desc,g_crac_m.crac001_desc,g_crac_m.crac003_desc,g_crac_m.crac004_desc,g_crac_m.crac005_desc, 
       g_crac_m.cracownid_desc,g_crac_m.cracowndp_desc,g_crac_m.craccrtid_desc,g_crac_m.craccrtdp_desc, 
       g_crac_m.cracmodid_desc,g_crac_m.craccnfid_desc
   
   
   #遮罩相關處理
   LET g_crac_m_mask_o.* =  g_crac_m.*
   CALL acrt400_crac_t_mask()
   LET g_crac_m_mask_n.* =  g_crac_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_crac_m.cracunit,g_crac_m.cracunit_desc,g_crac_m.cracdocdt,g_crac_m.cracdocno,g_crac_m.cracsite, 
       g_crac_m.crac001,g_crac_m.crac001_desc,g_crac_m.crac002,g_crac_m.craa032,g_crac_m.crac003,g_crac_m.crac003_desc, 
       g_crac_m.cracstus,g_crac_m.crac004,g_crac_m.crac004_desc,g_crac_m.crac005,g_crac_m.crac005_desc, 
       g_crac_m.cracownid,g_crac_m.cracownid_desc,g_crac_m.cracowndp,g_crac_m.cracowndp_desc,g_crac_m.craccrtid, 
       g_crac_m.craccrtid_desc,g_crac_m.craccrtdp,g_crac_m.craccrtdp_desc,g_crac_m.craccrtdt,g_crac_m.cracmodid, 
       g_crac_m.cracmodid_desc,g_crac_m.cracmoddt,g_crac_m.craccnfid,g_crac_m.craccnfid_desc,g_crac_m.craccnfdt 
 
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_crac_m.cracownid      
   LET g_data_dept  = g_crac_m.cracowndp
 
   #功能已完成,通報訊息中心
   CALL acrt400_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="acrt400.modify" >}
#+ 資料修改
PRIVATE FUNCTION acrt400_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_crac_m.cracdocno IS NULL
 
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
   LET g_cracdocno_t = g_crac_m.cracdocno
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN acrt400_cl USING g_enterprise,g_crac_m.cracdocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN acrt400_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE acrt400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE acrt400_master_referesh USING g_crac_m.cracdocno INTO g_crac_m.cracunit,g_crac_m.cracdocdt, 
       g_crac_m.cracdocno,g_crac_m.cracsite,g_crac_m.crac001,g_crac_m.crac002,g_crac_m.crac003,g_crac_m.cracstus, 
       g_crac_m.crac004,g_crac_m.crac005,g_crac_m.cracownid,g_crac_m.cracowndp,g_crac_m.craccrtid,g_crac_m.craccrtdp, 
       g_crac_m.craccrtdt,g_crac_m.cracmodid,g_crac_m.cracmoddt,g_crac_m.craccnfid,g_crac_m.craccnfdt, 
       g_crac_m.cracunit_desc,g_crac_m.crac001_desc,g_crac_m.crac003_desc,g_crac_m.crac004_desc,g_crac_m.crac005_desc, 
       g_crac_m.cracownid_desc,g_crac_m.cracowndp_desc,g_crac_m.craccrtid_desc,g_crac_m.craccrtdp_desc, 
       g_crac_m.cracmodid_desc,g_crac_m.craccnfid_desc
 
   #檢查是否允許此動作
   IF NOT acrt400_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_crac_m_mask_o.* =  g_crac_m.*
   CALL acrt400_crac_t_mask()
   LET g_crac_m_mask_n.* =  g_crac_m.*
   
   
 
   #顯示資料
   CALL acrt400_show()
   
   WHILE TRUE
      LET g_crac_m.cracdocno = g_cracdocno_t
 
      
      #寫入修改者/修改日期資訊
      LET g_crac_m.cracmodid = g_user 
LET g_crac_m.cracmoddt = cl_get_current()
LET g_crac_m.cracmodid_desc = cl_get_username(g_crac_m.cracmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      LET g_crac_m_o.* = g_crac_m.*  #160824-00007#104 by sakura add
      #ADD BY zhujing 2015-4-30----(S)
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_crac_m.cracstus MATCHES "[DR]" THEN
         LET g_crac_m.cracstus = "N"
      END IF
      #ADD BY zhujing 2015-4-30----(E)
      #end add-point
 
      #資料輸入
      CALL acrt400_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_crac_m.* = g_crac_m_t.*
         CALL acrt400_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE crac_t SET (cracmodid,cracmoddt) = (g_crac_m.cracmodid,g_crac_m.cracmoddt)
       WHERE cracent = g_enterprise AND cracdocno = g_cracdocno_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL acrt400_set_act_visible()
   CALL acrt400_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " cracent = " ||g_enterprise|| " AND",
                      " cracdocno = '", g_crac_m.cracdocno, "' "
 
   #填到對應位置
   CALL acrt400_browser_fill(g_wc,"")
 
   CLOSE acrt400_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL acrt400_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="acrt400.input" >}
#+ 資料輸入
PRIVATE FUNCTION acrt400_input(p_cmd)
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
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_ooef004       LIKE ooef_t.ooef004
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_errno         LIKE type_t.chr10
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
   DISPLAY BY NAME g_crac_m.cracunit,g_crac_m.cracunit_desc,g_crac_m.cracdocdt,g_crac_m.cracdocno,g_crac_m.cracsite, 
       g_crac_m.crac001,g_crac_m.crac001_desc,g_crac_m.crac002,g_crac_m.craa032,g_crac_m.crac003,g_crac_m.crac003_desc, 
       g_crac_m.cracstus,g_crac_m.crac004,g_crac_m.crac004_desc,g_crac_m.crac005,g_crac_m.crac005_desc, 
       g_crac_m.cracownid,g_crac_m.cracownid_desc,g_crac_m.cracowndp,g_crac_m.cracowndp_desc,g_crac_m.craccrtid, 
       g_crac_m.craccrtid_desc,g_crac_m.craccrtdp,g_crac_m.craccrtdp_desc,g_crac_m.craccrtdt,g_crac_m.cracmodid, 
       g_crac_m.cracmodid_desc,g_crac_m.cracmoddt,g_crac_m.craccnfid,g_crac_m.craccnfid_desc,g_crac_m.craccnfdt 
 
   
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
   CALL acrt400_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL acrt400_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   DISPLAY BY NAME g_crac_m.cracunit_desc
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_crac_m.cracunit,g_crac_m.cracdocdt,g_crac_m.cracdocno,g_crac_m.crac001,g_crac_m.crac002, 
          g_crac_m.crac003,g_crac_m.cracstus,g_crac_m.crac004,g_crac_m.crac005 
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
         AFTER FIELD cracunit
            
            #add-point:AFTER FIELD cracunit name="input.a.cracunit"
            LET g_crac_m.cracunit_desc = NULL
            DISPLAY BY NAME g_crac_m.cracunit_desc
            IF NOT cl_null(g_crac_m.cracunit) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_crac_m.cracunit != g_crac_m_t.cracunit OR g_crac_m_t.cracunit IS null)) THEN #160824-00007#104 by sakura mark
               IF g_crac_m.cracunit != g_crac_m_o.cracunit OR cl_null(g_crac_m_o.cracunit) THEN #160824-00007#104 by sakura add
                  CALL s_aooi500_chk(g_prog,'cracunit',g_crac_m.cracunit,g_site)
                       RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_crac_m.cracunit
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     #LET g_crac_m.cracunit = g_crac_m_t.cracunit  #160824-00007#104 by sakura mark
                     LET  g_crac_m.cracunit = g_crac_m_o.cracunit  #160824-00007#104 by sakura add
                     LET g_crac_m.cracunit_desc = acrt400_get_org_ref(g_crac_m.cracunit)
                     DISPLAY BY NAME g_crac_m.cracunit,g_crac_m.cracunit_desc
                     NEXT FIELD CURRENT
                  ELSE
                     LET g_ins_site_flag = TRUE  #161024-00025#6--add
                  END IF
               END IF
            END IF
            LET g_crac_m.cracunit_desc = acrt400_get_org_ref(g_crac_m.cracunit)
            DISPLAY BY NAME g_crac_m.cracunit,g_crac_m.cracunit_desc
            CALL acrt400_set_entry(p_cmd)      #161024-00025#6--add
            CALL acrt400_set_no_entry(p_cmd)   #161024-00025#6--add
            LET g_crac_m_o.* = g_crac_m.*  #160824-00007#104 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cracunit
            #add-point:BEFORE FIELD cracunit name="input.b.cracunit"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE cracunit
            #add-point:ON CHANGE cracunit name="input.g.cracunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cracdocdt
            #add-point:BEFORE FIELD cracdocdt name="input.b.cracdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cracdocdt
            
            #add-point:AFTER FIELD cracdocdt name="input.a.cracdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE cracdocdt
            #add-point:ON CHANGE cracdocdt name="input.g.cracdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cracdocno
            #add-point:BEFORE FIELD cracdocno name="input.b.cracdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cracdocno
            
            #add-point:AFTER FIELD cracdocno name="input.a.cracdocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_crac_m.cracdocno) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_crac_m.cracdocno != g_cracdocno_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM crac_t WHERE "||"cracent = '" ||g_enterprise|| "' AND "||"cracdocno = '"||g_crac_m.cracdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  ELSE
                     IF NOT s_aooi200_chk_slip(g_crac_m.cracsite,'',g_crac_m.cracdocno,g_prog) THEN
                        LET g_crac_m.cracdocno = g_cracdocno_t
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE cracdocno
            #add-point:ON CHANGE cracdocno name="input.g.cracdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crac001
            
            #add-point:AFTER FIELD crac001 name="input.a.crac001"
            IF NOT cl_null(g_crac_m.crac001) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_crac_m.crac001 != g_crac_m_t.crac001) ) THEN #160824-00007#104 by sakura mark
               IF g_crac_m.crac001 != g_crac_m_o.crac001 OR cl_null(g_crac_m_o.crac001) THEN        #160824-00007#104 by sakura add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_crac_m.crac001
                  IF cl_chk_exist("v_craa001_1") THEN
                     #160824-00007#104 by sakura add(S)
                     LET g_crac_m.craa032 = ''
                     LET g_crac_m.crac004 = ''
                     LET g_crac_m.crac005 = ''
                     #160824-00007#104 by sakura add(E)
                     CALL acrt400_get_craa_info(g_crac_m.crac001)
                          RETURNING g_crac_m.craa032,g_crac_m.crac004,g_crac_m.crac005
                     IF g_crac_m.craa032 MATCHES '[34]' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'acr-00040'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_crac_m.crac001 = g_crac_m_t.crac001 #160824-00007#104 by sakura mark
                        LET g_crac_m.crac001 = g_crac_m_o.crac001  #160824-00007#104 by sakura add
                        LET g_crac_m.crac001_desc = acrt400_get_crac001_ref(g_crac_m.crac001) 
                        #160824-00007#104 by sakura mark(S)
                        #LET g_crac_m.crac002 = g_crac_m_t.crac002
                        #LET g_crac_m.craa032 = g_crac_m_t.craa032
                        #LET g_crac_m.crac004 = g_crac_m_t.crac004
                        #LET g_crac_m.crac005 = g_crac_m_t.crac005
                        #160824-00007#104 by sakura mark(E)
                        #160824-00007#104 by sakura add(S)
                        LET g_crac_m.crac002 = g_crac_m_o.crac002
                        LET g_crac_m.craa032 = g_crac_m_o.craa032
                        LET g_crac_m.crac004 = g_crac_m_o.crac004
                        LET g_crac_m.crac005 = g_crac_m_o.crac005
                        #160824-00007#104 by sakura add(E)
                        DISPLAY BY NAME g_crac_m.crac001,g_crac_m.crac001_desc,
                                        g_crac_m.crac002,g_crac_m.craa032,g_crac_m.crac004,g_crac_m.crac005
                        NEXT FIELD CURRENT
                     ELSE
                        LET g_crac_m.crac001_desc = acrt400_get_crac001_ref(g_crac_m.crac001)
                        LET g_crac_m.crac002 = acrt400_get_crac002(g_crac_m.crac001)
                        DISPLAY BY NAME g_crac_m.crac001_desc,g_crac_m.crac002,g_crac_m.craa032
                        
                        IF NOT cl_null(g_crac_m.crac004) THEN
                           LET g_crac_m.crac004_desc = acrt400_get_crac004_ref(g_crac_m.crac004)
                           DISPLAY BY NAME g_crac_m.crac004_desc   
                        END IF
                        
                        IF NOT cl_null(g_crac_m.crac005) THEN
                           LET g_crac_m.crac005_desc = acrt400_user_ref(g_crac_m.crac005)
                           DISPLAY BY NAME g_crac_m.crac005_desc
                        END IF
                     END IF
                  ELSE
                     #LET g_crac_m.crac001 = g_crac_m_t.crac001 #160824-00007#104 by sakura mark
                     LET g_crac_m.crac001 = g_crac_m_o.crac001  #160824-00007#104 by sakura add
                     LET g_crac_m.crac001_desc = acrt400_get_crac001_ref(g_crac_m.crac001)
                     #160824-00007#104 by sakura mark(S)
                     #LET g_crac_m.crac002 = g_crac_m_t.crac002
                     #LET g_crac_m.craa032 = g_crac_m_t.craa032
                     #LET g_crac_m.crac004 = g_crac_m_t.crac004
                     #LET g_crac_m.crac005 = g_crac_m_t.crac005
                     #160824-00007#104 by sakura mark(E)
                     #160824-00007#104 by sakura add(S)
                     LET g_crac_m.crac002 = g_crac_m_o.crac002
                     LET g_crac_m.craa032 = g_crac_m_o.craa032
                     LET g_crac_m.crac004 = g_crac_m_o.crac004
                     LET g_crac_m.crac005 = g_crac_m_o.crac005
                     #160824-00007#104 by sakura add(E)
                     DISPLAY BY NAME g_crac_m.crac001,g_crac_m.crac001_desc,
                                     g_crac_m.crac002,g_crac_m.craa032,g_crac_m.crac004,g_crac_m.crac005
                     NEXT FIELD CURRENT
                  END IF
               END IF                  
            END IF
            
            LET g_crac_m.crac001_desc = acrt400_get_crac001_ref(g_crac_m.crac001)
            LET g_crac_m.crac004_desc = acrt400_get_crac004_ref(g_crac_m.crac004)
            LET g_crac_m.crac005_desc = acrt400_user_ref(g_crac_m.crac005)
            DISPLAY BY NAME g_crac_m.craa032,g_crac_m.crac001_desc,g_crac_m.crac004_desc,g_crac_m.crac005_desc
            
            CALL acrt400_set_entry(p_cmd)
            CALL acrt400_set_no_entry(p_cmd)
            
            LET g_crac_m_o.* = g_crac_m.*   #160824-00007#104 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crac001
            #add-point:BEFORE FIELD crac001 name="input.b.crac001"
            CALL acrt400_set_entry(p_cmd)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crac001
            #add-point:ON CHANGE crac001 name="input.g.crac001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crac002
            #add-point:BEFORE FIELD crac002 name="input.b.crac002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crac002
            
            #add-point:AFTER FIELD crac002 name="input.a.crac002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crac002
            #add-point:ON CHANGE crac002 name="input.g.crac002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crac003
            
            #add-point:AFTER FIELD crac003 name="input.a.crac003"
            IF NOT cl_null(g_crac_m.crac003) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_crac_m.crac003 != g_crac_m_t.crac003) ) THEN #160824-00007#104 by sakura mark
               IF g_crac_m.crac003 != g_crac_m_o.crac003 OR cl_null(g_crac_m_o.crac003) THEN        #160824-00007#104 by sakura add
                  IF NOT s_azzi650_chk_exist('2109',g_crac_m.crac003) THEN
                     #LET g_crac_m.crac003 = g_crac_m_t.crac003 #160824-00007#104 by sakura mark
                     LET g_crac_m.crac003 = g_crac_m_o.crac003  #160824-00007#104 by sakura add
                     LET g_crac_m.crac003_desc = acrt400_get_crac003_ref(g_crac_m.crac003)
                     DISPLAY BY NAME g_crac_m.crac003,g_crac_m.crac003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_crac_m.crac003_desc = acrt400_get_crac003_ref(g_crac_m.crac003)
            DISPLAY BY NAME g_crac_m.crac003_desc
            LET g_crac_m_o.* = g_crac_m.*   #160824-00007#104 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crac003
            #add-point:BEFORE FIELD crac003 name="input.b.crac003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crac003
            #add-point:ON CHANGE crac003 name="input.g.crac003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cracstus
            #add-point:BEFORE FIELD cracstus name="input.b.cracstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cracstus
            
            #add-point:AFTER FIELD cracstus name="input.a.cracstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE cracstus
            #add-point:ON CHANGE cracstus name="input.g.cracstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crac004
            
            #add-point:AFTER FIELD crac004 name="input.a.crac004"
            IF NOT cl_null(g_crac_m.crac004) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_crac_m.crac004 != g_crac_m_t.crac004) ) THEN #160824-00007#104 by sakura mark
               IF g_crac_m.crac004 != g_crac_m_o.crac004 OR cl_null(g_crac_m_o.crac004) THEN        #160824-00007#104 by sakura add
                  IF NOT s_azzi650_chk_exist('2105',g_crac_m.crac004) THEN
                     #LET g_crac_m.crac004 = g_crac_m_t.crac004 #160824-00007#104 by sakura mark
                     LET g_crac_m.crac004 = g_crac_m_o.crac004  #160824-00007#104 by sakura add
                     LET g_crac_m.crac004_desc = acrt400_get_crac004_ref(g_crac_m.crac004)
                     DISPLAY BY NAME g_crac_m.crac004,g_crac_m.crac004_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_crac_m.crac004_desc = acrt400_get_crac004_ref(g_crac_m.crac004)
            DISPLAY BY NAME g_crac_m.crac004_desc
            LET g_crac_m_o.* = g_crac_m.*   #160824-00007#104 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crac004
            #add-point:BEFORE FIELD crac004 name="input.b.crac004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crac004
            #add-point:ON CHANGE crac004 name="input.g.crac004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crac005
            
            #add-point:AFTER FIELD crac005 name="input.a.crac005"
            IF NOT cl_null(g_crac_m.crac005) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_crac_m.crac005 != g_crac_m_t.crac005) ) THEN #160824-00007#104 by sakura mark
               IF g_crac_m.crac005 != g_crac_m_o.crac005 OR cl_null(g_crac_m_o.crac005) THEN        #160824-00007#104 by sakura add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_crac_m.crac005
                  #160318-00025#27  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#27  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     #LET g_crac_m.crac005 = g_crac_m_t.crac005 #160824-00007#104 by sakura mark
                     LET g_crac_m.crac005 = g_crac_m_o.crac005  #160824-00007#104 by sakura add
                     LET g_crac_m.crac005_desc = acrt400_user_ref(g_crac_m.crac005)
                     DISPLAY BY NAME g_crac_m.crac005,g_crac_m.crac005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               IF g_crac_m.craa032 = '1' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00022'
                  LET g_errparam.extend = g_crac_m.crac001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #LET g_crac_m.crac005 = g_crac_m_t.crac005 #160824-00007#104 by sakura mark
                  LET g_crac_m.crac005 = g_crac_m_o.crac005  #160824-00007#104 by sakura add
                  LET g_crac_m.crac005_desc = acrt400_user_ref(g_crac_m.crac005)
                  DISPLAY BY NAME g_crac_m.crac005,g_crac_m.crac005_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_crac_m.crac005_desc = acrt400_user_ref(g_crac_m.crac005)
            DISPLAY BY NAME g_crac_m.crac005_desc
            LET g_crac_m_o.* = g_crac_m.*   #160824-00007#104 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crac005
            #add-point:BEFORE FIELD crac005 name="input.b.crac005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crac005
            #add-point:ON CHANGE crac005 name="input.g.crac005"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.cracunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cracunit
            #add-point:ON ACTION controlp INFIELD cracunit name="input.c.cracunit"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_crac_m.cracunit
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'cracunit',g_site,'i') #150308-00001#1  By Ken add 'i' 150309
            CALL q_ooef001_24()
            LET g_crac_m.cracunit = g_qryparam.return1
            DISPLAY g_crac_m.cracunit TO cracunit
            LET g_crac_m.cracunit_desc = acrt400_get_org_ref(g_crac_m.cracunit)
            DISPLAY BY NAME g_crac_m.cracunit_desc
            NEXT FIELD cracunit
            #END add-point
 
 
         #Ctrlp:input.c.cracdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cracdocdt
            #add-point:ON ACTION controlp INFIELD cracdocdt name="input.c.cracdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.cracdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cracdocno
            #add-point:ON ACTION controlp INFIELD cracdocno name="input.c.cracdocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_crac_m.cracdocno             #給予default值

            #給予arg
            CALL s_aooi100_sel_ooef004(g_site) RETURNING l_success,l_ooef004
            LET g_qryparam.arg1 = l_ooef004 #
            LET g_qryparam.arg2 = g_prog #
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_crac_m.cracdocno = g_qryparam.return1              

            DISPLAY g_crac_m.cracdocno TO cracdocno              #

            NEXT FIELD cracdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.crac001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crac001
            #add-point:ON ACTION controlp INFIELD crac001 name="input.c.crac001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_crac_m.crac001             #給予default值
            LET g_qryparam.where = " craa032 IN ('0','1','2') " 
            CALL q_craa001()                                #呼叫開窗
            LET g_crac_m.crac001 = g_qryparam.return1   
            DISPLAY g_crac_m.crac001 TO crac001              #

            LET g_crac_m.crac001_desc = acrt400_get_crac001_ref(g_crac_m.crac001)
            DISPLAY BY NAME g_crac_m.crac001_desc
            
            NEXT FIELD crac001                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.crac002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crac002
            #add-point:ON ACTION controlp INFIELD crac002 name="input.c.crac002"
            
            #END add-point
 
 
         #Ctrlp:input.c.crac003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crac003
            #add-point:ON ACTION controlp INFIELD crac003 name="input.c.crac003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_crac_m.crac003             #給予default值
            LET g_qryparam.default2 = "" #g_crac_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2109" #
            CALL q_oocq002()                                #呼叫開窗

            LET g_crac_m.crac003 = g_qryparam.return1              
            #LET g_crac_m.oocq002 = g_qryparam.return2 
            DISPLAY g_crac_m.crac003 TO crac003              #
            #DISPLAY g_crac_m.oocq002 TO oocq002 #應用分類碼

            LET g_crac_m.crac003_desc = acrt400_get_crac003_ref(g_crac_m.crac003)
            DISPLAY BY NAME g_crac_m.crac003_desc            
            
            NEXT FIELD crac003                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.cracstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cracstus
            #add-point:ON ACTION controlp INFIELD cracstus name="input.c.cracstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.crac004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crac004
            #add-point:ON ACTION controlp INFIELD crac004 name="input.c.crac004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_crac_m.crac004             #給予default值
            LET g_qryparam.default2 = "" #g_crac_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2105" #
            CALL q_oocq002()                                #呼叫開窗
            LET g_crac_m.crac004 = g_qryparam.return1              
            #LET g_crac_m.oocq002 = g_qryparam.return2 
            DISPLAY g_crac_m.crac004 TO crac004              #
            #DISPLAY g_crac_m.oocq002 TO oocq002 #應用分類碼
            
            LET g_crac_m.crac004_desc = acrt400_get_crac004_ref(g_crac_m.crac004)
            DISPLAY BY NAME g_crac_m.crac004_desc  
            
            NEXT FIELD crac004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.crac005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crac005
            #add-point:ON ACTION controlp INFIELD crac005 name="input.c.crac005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_crac_m.crac005             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_ooag001()                                #呼叫開窗
            LET g_crac_m.crac005 = g_qryparam.return1     
            DISPLAY g_crac_m.crac005 TO crac005              #
            
            LET g_crac_m.crac005_desc = acrt400_user_ref(g_crac_m.crac005)
            DISPLAY BY NAME g_crac_m.crac005_desc
            
            NEXT FIELD crac005                          #返回原欄位
            
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
               SELECT COUNT(1) INTO l_count FROM crac_t
                WHERE cracent = g_enterprise AND cracdocno = g_crac_m.cracdocno
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  CALL s_aooi200_gen_docno(g_crac_m.cracsite,g_crac_m.cracdocno,g_crac_m.cracdocdt,g_prog) RETURNING l_flag,g_crac_m.cracdocno
                  IF NOT l_flag THEN
                     NEXT FIELD cracdocno
                  END IF
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO crac_t (cracent,cracunit,cracdocdt,cracdocno,cracsite,crac001,crac002, 
                      crac003,cracstus,crac004,crac005,cracownid,cracowndp,craccrtid,craccrtdp,craccrtdt, 
                      cracmodid,cracmoddt,craccnfid,craccnfdt)
                  VALUES (g_enterprise,g_crac_m.cracunit,g_crac_m.cracdocdt,g_crac_m.cracdocno,g_crac_m.cracsite, 
                      g_crac_m.crac001,g_crac_m.crac002,g_crac_m.crac003,g_crac_m.cracstus,g_crac_m.crac004, 
                      g_crac_m.crac005,g_crac_m.cracownid,g_crac_m.cracowndp,g_crac_m.craccrtid,g_crac_m.craccrtdp, 
                      g_crac_m.craccrtdt,g_crac_m.cracmodid,g_crac_m.cracmoddt,g_crac_m.craccnfid,g_crac_m.craccnfdt)  
 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "crac_t:",SQLERRMESSAGE 
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
                  LET g_errparam.extend = g_crac_m.cracdocno
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL acrt400_crac_t_mask_restore('restore_mask_o')
               
               UPDATE crac_t SET (cracunit,cracdocdt,cracdocno,cracsite,crac001,crac002,crac003,cracstus, 
                   crac004,crac005,cracownid,cracowndp,craccrtid,craccrtdp,craccrtdt,cracmodid,cracmoddt, 
                   craccnfid,craccnfdt) = (g_crac_m.cracunit,g_crac_m.cracdocdt,g_crac_m.cracdocno,g_crac_m.cracsite, 
                   g_crac_m.crac001,g_crac_m.crac002,g_crac_m.crac003,g_crac_m.cracstus,g_crac_m.crac004, 
                   g_crac_m.crac005,g_crac_m.cracownid,g_crac_m.cracowndp,g_crac_m.craccrtid,g_crac_m.craccrtdp, 
                   g_crac_m.craccrtdt,g_crac_m.cracmodid,g_crac_m.cracmoddt,g_crac_m.craccnfid,g_crac_m.craccnfdt) 
 
                WHERE cracent = g_enterprise AND cracdocno = g_cracdocno_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "crac_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "crac_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL acrt400_crac_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_crac_m_t)
                     LET g_log2 = util.JSON.stringify(g_crac_m)
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
 
{<section id="acrt400.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION acrt400_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE crac_t.cracdocno 
   DEFINE l_oldno     LIKE crac_t.cracdocno 
 
   DEFINE l_master    RECORD LIKE crac_t.* #此變數樣板目前無使用
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
   IF g_crac_m.cracdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_cracdocno_t = g_crac_m.cracdocno
 
   
   #清空key值
   LET g_crac_m.cracdocno = ""
 
    
   CALL acrt400_set_entry("a")
   CALL acrt400_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_crac_m.cracownid = g_user
      LET g_crac_m.cracowndp = g_dept
      LET g_crac_m.craccrtid = g_user
      LET g_crac_m.craccrtdp = g_dept 
      LET g_crac_m.craccrtdt = cl_get_current()
      LET g_crac_m.cracmodid = g_user
      LET g_crac_m.cracmoddt = cl_get_current()
      LET g_crac_m.cracstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
 
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_crac_m.cracstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL acrt400_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_crac_m.* TO NULL
      CALL acrt400_show()
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
      LET g_errparam.extend = "crac_t:",SQLERRMESSAGE 
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
   CALL acrt400_set_act_visible()
   CALL acrt400_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_cracdocno_t = g_crac_m.cracdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " cracent = " ||g_enterprise|| " AND",
                      " cracdocno = '", g_crac_m.cracdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL acrt400_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_crac_m.cracownid      
   LET g_data_dept  = g_crac_m.cracowndp
              
   #功能已完成,通報訊息中心
   CALL acrt400_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="acrt400.show" >}
#+ 資料顯示 
PRIVATE FUNCTION acrt400_show()
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
   CALL acrt400_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

   LET g_crac_m.cracunit_desc = acrt400_get_org_ref(g_crac_m.cracunit)
   DISPLAY BY NAME g_crac_m.cracunit_desc

   LET g_crac_m.crac001_desc = acrt400_get_crac001_ref(g_crac_m.crac001)
   DISPLAY BY NAME g_crac_m.crac001_desc

   LET g_crac_m.crac003_desc = acrt400_get_crac003_ref(g_crac_m.crac003)
   DISPLAY BY NAME g_crac_m.crac003_desc

   LET g_crac_m.crac004_desc = acrt400_get_crac004_ref(g_crac_m.crac004)
   DISPLAY BY NAME g_crac_m.crac004_desc

   LET g_crac_m.crac005_desc = acrt400_user_ref(g_crac_m.crac005)
   DISPLAY BY NAME g_crac_m.crac005_desc

   LET g_crac_m.cracownid_desc = acrt400_user_ref(g_crac_m.cracownid)
   DISPLAY BY NAME g_crac_m.cracownid_desc

   LET g_crac_m.cracowndp_desc = acrt400_get_org_ref(g_crac_m.cracowndp)
   DISPLAY BY NAME g_crac_m.cracowndp_desc

   LET g_crac_m.craccrtid_desc = acrt400_user_ref(g_crac_m.craccrtid)
   DISPLAY BY NAME g_crac_m.craccrtid_desc

   LET g_crac_m.craccrtdp_desc = acrt400_get_org_ref(g_crac_m.craccrtdp)
   DISPLAY BY NAME g_crac_m.craccrtdp_desc

   LET g_crac_m.cracmodid_desc = acrt400_user_ref(g_crac_m.cracmodid)
   DISPLAY BY NAME g_crac_m.cracmodid_desc

   LET g_crac_m.craccnfid_desc = acrt400_user_ref( g_crac_m.craccnfid)
   DISPLAY BY NAME g_crac_m.craccnfid_desc

   SELECT craa032 INTO g_crac_m.craa032
     FROM craa_t
    WHERE craaent = g_enterprise AND craa001 = g_crac_m.crac001 
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_crac_m.cracunit,g_crac_m.cracunit_desc,g_crac_m.cracdocdt,g_crac_m.cracdocno,g_crac_m.cracsite, 
       g_crac_m.crac001,g_crac_m.crac001_desc,g_crac_m.crac002,g_crac_m.craa032,g_crac_m.crac003,g_crac_m.crac003_desc, 
       g_crac_m.cracstus,g_crac_m.crac004,g_crac_m.crac004_desc,g_crac_m.crac005,g_crac_m.crac005_desc, 
       g_crac_m.cracownid,g_crac_m.cracownid_desc,g_crac_m.cracowndp,g_crac_m.cracowndp_desc,g_crac_m.craccrtid, 
       g_crac_m.craccrtid_desc,g_crac_m.craccrtdp,g_crac_m.craccrtdp_desc,g_crac_m.craccrtdt,g_crac_m.cracmodid, 
       g_crac_m.cracmodid_desc,g_crac_m.cracmoddt,g_crac_m.craccnfid,g_crac_m.craccnfid_desc,g_crac_m.craccnfdt 
 
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL acrt400_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_crac_m.cracstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrt400.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION acrt400_delete()
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
   IF g_crac_m.cracdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_cracdocno_t = g_crac_m.cracdocno
 
   
   
 
   OPEN acrt400_cl USING g_enterprise,g_crac_m.cracdocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN acrt400_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE acrt400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE acrt400_master_referesh USING g_crac_m.cracdocno INTO g_crac_m.cracunit,g_crac_m.cracdocdt, 
       g_crac_m.cracdocno,g_crac_m.cracsite,g_crac_m.crac001,g_crac_m.crac002,g_crac_m.crac003,g_crac_m.cracstus, 
       g_crac_m.crac004,g_crac_m.crac005,g_crac_m.cracownid,g_crac_m.cracowndp,g_crac_m.craccrtid,g_crac_m.craccrtdp, 
       g_crac_m.craccrtdt,g_crac_m.cracmodid,g_crac_m.cracmoddt,g_crac_m.craccnfid,g_crac_m.craccnfdt, 
       g_crac_m.cracunit_desc,g_crac_m.crac001_desc,g_crac_m.crac003_desc,g_crac_m.crac004_desc,g_crac_m.crac005_desc, 
       g_crac_m.cracownid_desc,g_crac_m.cracowndp_desc,g_crac_m.craccrtid_desc,g_crac_m.craccrtdp_desc, 
       g_crac_m.cracmodid_desc,g_crac_m.craccnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT acrt400_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_crac_m_mask_o.* =  g_crac_m.*
   CALL acrt400_crac_t_mask()
   LET g_crac_m_mask_n.* =  g_crac_m.*
   
   #將最新資料顯示到畫面上
   CALL acrt400_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL acrt400_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM crac_t 
       WHERE cracent = g_enterprise AND cracdocno = g_crac_m.cracdocno 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "crac_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_crac_m.cracdocno,g_crac_m.cracdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_crac_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE acrt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL acrt400_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL acrt400_browser_fill(g_wc,"")
         CALL acrt400_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE acrt400_cl
 
   #功能已完成,通報訊息中心
   CALL acrt400_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrt400.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION acrt400_ui_browser_refresh()
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
      IF g_browser[l_i].b_cracdocno = g_crac_m.cracdocno
 
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
 
{<section id="acrt400.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION acrt400_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("cracdocno",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("crac004,crac005",TRUE)
   CALL cl_set_comp_entry("cracunit",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="acrt400.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION acrt400_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("cracdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_crac_m.craa032 <> '1' THEN
      CALL cl_set_comp_entry("crac005",FALSE)
   END IF
   
   IF g_crac_m.craa032 NOT MATCHES '[012]' THEN
      CALL cl_set_comp_entry("crac005",FALSE)
   END IF

   IF NOT s_aooi500_comp_entry(g_prog,'cracunit') OR g_ins_site_flag  THEN
      CALL cl_set_comp_entry("cracunit",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="acrt400.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION acrt400_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrt400.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION acrt400_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #160818-00017#5 -s by 08172
   IF g_crac_m.cracstus = 'N' THEN
      CALL cl_set_act_visible("modify,delete",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete",FALSE)
   END IF
   #160818-00017#5 -e by 08172
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrt400.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION acrt400_default_search()
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
      LET ls_wc = ls_wc, " cracdocno = '", g_argv[01], "' AND "
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
 
{<section id="acrt400.mask_functions" >}
&include "erp/acr/acrt400_mask.4gl"
 
{</section>}
 
{<section id="acrt400.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION acrt400_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
 
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_crac_m.cracdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN acrt400_cl USING g_enterprise,g_crac_m.cracdocno
   IF STATUS THEN
      CLOSE acrt400_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN acrt400_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE acrt400_master_referesh USING g_crac_m.cracdocno INTO g_crac_m.cracunit,g_crac_m.cracdocdt, 
       g_crac_m.cracdocno,g_crac_m.cracsite,g_crac_m.crac001,g_crac_m.crac002,g_crac_m.crac003,g_crac_m.cracstus, 
       g_crac_m.crac004,g_crac_m.crac005,g_crac_m.cracownid,g_crac_m.cracowndp,g_crac_m.craccrtid,g_crac_m.craccrtdp, 
       g_crac_m.craccrtdt,g_crac_m.cracmodid,g_crac_m.cracmoddt,g_crac_m.craccnfid,g_crac_m.craccnfdt, 
       g_crac_m.cracunit_desc,g_crac_m.crac001_desc,g_crac_m.crac003_desc,g_crac_m.crac004_desc,g_crac_m.crac005_desc, 
       g_crac_m.cracownid_desc,g_crac_m.cracowndp_desc,g_crac_m.craccrtid_desc,g_crac_m.craccrtdp_desc, 
       g_crac_m.cracmodid_desc,g_crac_m.craccnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT acrt400_action_chk() THEN
      CLOSE acrt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_crac_m.cracunit,g_crac_m.cracunit_desc,g_crac_m.cracdocdt,g_crac_m.cracdocno,g_crac_m.cracsite, 
       g_crac_m.crac001,g_crac_m.crac001_desc,g_crac_m.crac002,g_crac_m.craa032,g_crac_m.crac003,g_crac_m.crac003_desc, 
       g_crac_m.cracstus,g_crac_m.crac004,g_crac_m.crac004_desc,g_crac_m.crac005,g_crac_m.crac005_desc, 
       g_crac_m.cracownid,g_crac_m.cracownid_desc,g_crac_m.cracowndp,g_crac_m.cracowndp_desc,g_crac_m.craccrtid, 
       g_crac_m.craccrtid_desc,g_crac_m.craccrtdp,g_crac_m.craccrtdp_desc,g_crac_m.craccrtdt,g_crac_m.cracmodid, 
       g_crac_m.cracmodid_desc,g_crac_m.cracmoddt,g_crac_m.craccnfid,g_crac_m.craccnfid_desc,g_crac_m.craccnfdt 
 
 
   CASE g_crac_m.cracstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_crac_m.cracstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      #ADD BY zhujing 2015-4-30----(S)
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      #ADD BY zhujing 2015-4-30----(E)
      CASE g_crac_m.cracstus
         WHEN "N"
            HIDE OPTION "unconfirmed"
            HIDE OPTION "signing"
            HIDE OPTION "rejection"
            HIDE OPTION "withdraw"
            HIDE OPTION "approved"
            #ADD BY zhujing 2015-4-30----(S)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "R"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
         WHEN "D"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
         WHEN "A"    #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)
            #ADD BY zhujing 2015-4-30----(E)
         WHEN "X"
            HIDE OPTION "invalid"
            HIDE OPTION "confirmed"
            HIDE OPTION "unconfirmed"
            HIDE OPTION "signing"
            HIDE OPTION "rejection"
            HIDE OPTION "withdraw"
            RETURN                  #160818-00017#5
         WHEN "Y"
            HIDE OPTION "confirmed"
            HIDE OPTION "invalid"
            HIDE OPTION "signing"
            HIDE OPTION "rejection"
            HIDE OPTION "withdraw"
         END CASE 
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT acrt400_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE acrt400_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT acrt400_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE acrt400_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_crac_m.cracstus = lc_state OR cl_null(lc_state) THEN
      CLOSE acrt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   
   OPEN acrt400_cl USING g_enterprise,g_crac_m.cracdocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN acrt400_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      CLOSE acrt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CASE
      WHEN lc_state = 'Y' 
         IF s_acrt400_conf(g_crac_m.cracdocno,g_crac_m.cracstus) THEN
            CALL s_transaction_end('Y','0')                  
         ELSE
            CALL s_transaction_end('N','0')
            RETURN      
         END IF 
      WHEN lc_state = 'X'
         IF s_acrt400_invalid(g_crac_m.cracdocno,g_crac_m.cracstus) THEN
            CALL s_transaction_end('Y','0')                  
         ELSE
            CALL s_transaction_end('N','0')
            RETURN      
         END IF          
   END CASE
   #end add-point
   
   LET g_crac_m.cracmodid = g_user
   LET g_crac_m.cracmoddt = cl_get_current()
   LET g_crac_m.cracstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE crac_t 
      SET (cracstus,cracmodid,cracmoddt) 
        = (g_crac_m.cracstus,g_crac_m.cracmodid,g_crac_m.cracmoddt)     
    WHERE cracent = g_enterprise AND cracdocno = g_crac_m.cracdocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE acrt400_master_referesh USING g_crac_m.cracdocno INTO g_crac_m.cracunit,g_crac_m.cracdocdt, 
          g_crac_m.cracdocno,g_crac_m.cracsite,g_crac_m.crac001,g_crac_m.crac002,g_crac_m.crac003,g_crac_m.cracstus, 
          g_crac_m.crac004,g_crac_m.crac005,g_crac_m.cracownid,g_crac_m.cracowndp,g_crac_m.craccrtid, 
          g_crac_m.craccrtdp,g_crac_m.craccrtdt,g_crac_m.cracmodid,g_crac_m.cracmoddt,g_crac_m.craccnfid, 
          g_crac_m.craccnfdt,g_crac_m.cracunit_desc,g_crac_m.crac001_desc,g_crac_m.crac003_desc,g_crac_m.crac004_desc, 
          g_crac_m.crac005_desc,g_crac_m.cracownid_desc,g_crac_m.cracowndp_desc,g_crac_m.craccrtid_desc, 
          g_crac_m.craccrtdp_desc,g_crac_m.cracmodid_desc,g_crac_m.craccnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_crac_m.cracunit,g_crac_m.cracunit_desc,g_crac_m.cracdocdt,g_crac_m.cracdocno, 
          g_crac_m.cracsite,g_crac_m.crac001,g_crac_m.crac001_desc,g_crac_m.crac002,g_crac_m.craa032, 
          g_crac_m.crac003,g_crac_m.crac003_desc,g_crac_m.cracstus,g_crac_m.crac004,g_crac_m.crac004_desc, 
          g_crac_m.crac005,g_crac_m.crac005_desc,g_crac_m.cracownid,g_crac_m.cracownid_desc,g_crac_m.cracowndp, 
          g_crac_m.cracowndp_desc,g_crac_m.craccrtid,g_crac_m.craccrtid_desc,g_crac_m.craccrtdp,g_crac_m.craccrtdp_desc, 
          g_crac_m.craccrtdt,g_crac_m.cracmodid,g_crac_m.cracmodid_desc,g_crac_m.cracmoddt,g_crac_m.craccnfid, 
          g_crac_m.craccnfid_desc,g_crac_m.craccnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
 
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE acrt400_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL acrt400_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="acrt400.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION acrt400_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
 
 
   CALL acrt400_show()
   CALL acrt400_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #ADD BY zhujing 2015-4-30---(S)
   CALL s_acrt400_conf_chk(g_crac_m.cracdocno,g_crac_m.cracstus) RETURNING l_success
   IF NOT l_success THEN
      CLOSE acrt400_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #ADD BY zhujing 2015-4-30---(E)
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_crac_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL acrt400_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION acrt400_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="acrt400.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION acrt400_set_pk_array()
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
   LET g_pk_array[1].values = g_crac_m.cracdocno
   LET g_pk_array[1].column = 'cracdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="acrt400.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="acrt400.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION acrt400_msgcentre_notify(lc_state)
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
   CALL acrt400_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_crac_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="acrt400.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION acrt400_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#5 -s by 08172
   SELECT cracstus  INTO g_crac_m.cracstus
     FROM crac_t
    WHERE cracent = g_enterprise
      AND cracdocno = g_crac_m.cracdocno
   LET g_errno = NULL
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_crac_m.cracstus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_crac_m.cracdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL acrt400_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#5 -e by 08172
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="acrt400.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 理由碼說明
# Memo...........:
# Usage..........: CALL acrt400_get_crac003_ref(p_crac003)
#                  RETURNING r_crac003_desc
# Input parameter: p_crac003        理由碼
# Return code....: r_crac003_desc   理由碼說明
# Date & Author..: 2014/04/23 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION acrt400_get_crac003_ref(p_crac003)
   DEFINE p_crac003        LIKE crac_t.crac003
   DEFINE r_crac003_desc   LIKE oocql_t.oocql004
   
   LET r_crac003_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_crac003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2109' AND oocql002 =?  AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_crac003_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_crac003_desc
END FUNCTION

################################################################################
# Descriptions...: 組織說明
# Memo...........:
# Usage..........: CALL acrt400_get_org_ref(p_org_id)
#                  RETURNING r_org_desc
# Input parameter: p_org_id    組織編號
# Return code....: r_org_desc  組織說明
# Date & Author..: 2014/04/23 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION acrt400_get_org_ref(p_org_id)
   DEFINE p_org_id     LIKE crac_t.cracunit
   DEFINE r_org_desc   LIKE ooefl_t.ooefl003
   
   LET r_org_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_org_id
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_org_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_org_desc
END FUNCTION

################################################################################
# Descriptions...: 客戶等級說明
# Memo...........:
# Usage..........: CALL acrt400_get_crac004_ref(p_crac004)
#                  RETURNING r_crac004_desc
# Input parameter: p_crac004        客戶等級
# Return code....: r_crac004_desc   客戶等級說明
# Date & Author..: 2014/04/23 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION acrt400_get_crac004_ref(p_crac004)
   DEFINE p_crac004        LIKE crac_t.crac004
   DEFINE r_crac004_desc   LIKE oocql_t.oocql004
   
   LET r_crac004_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_crac004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2105' AND oocql002=?  AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_crac004_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_crac004_desc
END FUNCTION

################################################################################
# Descriptions...: 人員说明
# Memo...........:
# Usage..........: CALL acrt400_user_ref(p_userid)
#                  RETURNING r_userid_desc
# Input parameter: p_userid        人員編號
# Return code....: r_userid_desc   人員名稱
# Date & Author..: 2014/04/23 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION acrt400_user_ref(p_userid)
   DEFINE p_userid        LIKE rtkd_t.rtkdmodid
   DEFINE r_userid_desc   LIKE oofa_t.oofa011
   
   LET r_userid_desc = NULL
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_userid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET r_userid_desc = g_rtn_fields[1]
   
   RETURN r_userid_desc
END FUNCTION

################################################################################
# Descriptions...: 潛客名稱
# Memo...........:
# Usage..........: CALL acrt400_get_crac001_ref(p_crac001)
#                  RETURNING r_crac001_desc
# Input parameter: p_crac001        潛客編號
# Return code....: r_crac001_desc   潛客說明
# Date & Author..: 2014/04/23 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION acrt400_get_crac001_ref(p_crac001)
   DEFINE p_crac001        LIKE crac_t.crac001
   DEFINE r_crac001_desc   LIKE craal_t.craal004
   
   LET r_crac001_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_crac001
   CALL ap_ref_array2(g_ref_fields,"SELECT craal004 FROM craal_t WHERE craalent='"||g_enterprise||"' AND craal001=? AND craal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_crac001_desc = '', g_rtn_fields[1] , ''

   RETURN r_crac001_desc
END FUNCTION

################################################################################
# Descriptions...: 取潛客資料
# Memo...........:
# Usage..........: CALL acrt400_get_craa_info(p_crac001)
# Input parameter: p_crac001   潛客編號
# Return code....: 
# Date & Author..: 2014/04/23 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION acrt400_get_craa_info(p_crac001)
   DEFINE p_crac001   LIKE crac_t.crac001
   DEFINE r_craa032   LIKE craa_t.craa032
   DEFINE r_craa016   LIKE craa_t.craa016
   DEFINE r_craa021   LIKE craa_t.craa021
   
   SELECT craa032,craa016,craa021 INTO r_craa032,r_craa016,r_craa021
     FROM craa_t
    WHERE craaent = g_enterprise AND craa001 = p_crac001

   #DISPLAY l_craa032 TO g_crac_m.craa032
   #DISPLAY l_craa016 TO g_crac_m.crac004
   #DISPLAY l_craa021 TO g_crac_m.crac005
   #
   #IF NOT cl_null(l_craa016) THEN
   #   LET g_crac_m.crac004_desc = acrt400_get_crac004_ref(g_crac_m.crac004)
   #   DISPLAY BY NAME g_crac_m.crac004_desc   
   #END IF
   #
   #IF NOT cl_null(l_craa021) THEN
   #   LET g_crac_m.crac005_desc = acrt400_user_ref(g_crac_m.crac005)
   #   DISPLAY BY NAME g_crac_m.crac005_desc
   #END IF
   
   RETURN r_craa032,r_craa016,r_craa021
END FUNCTION

################################################################################
# Descriptions...: 取最新版本
# Memo...........: 新增時使用
# Usage..........: CALL acrt400_get_crac002(p_crac001)
#                  RETURNING r_crac002
# Input parameter: p_crac001     潛客編號
# Return code....: r_crac002     版本
# Date & Author..: 2014/04/23 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION acrt400_get_crac002(p_crac001)
   DEFINE p_crac001   LIKE crac_t.crac001
   DEFINE r_crac002   LIKE crac_t.crac002
   
   LET r_crac002 = NULL
   
   SELECT MAX(crac002)+1 INTO r_crac002
     FROM crac_t
    WHERE cracent = g_enterprise AND crac001 = p_crac001

   IF cl_null(r_crac002) THEN
      LET r_crac002 = 1
   END IF
   
    LET r_crac002 = r_crac002 + 1 USING "<<<<<<<<<#"
    
   RETURN r_crac002
END FUNCTION

 
{</section>}
 
