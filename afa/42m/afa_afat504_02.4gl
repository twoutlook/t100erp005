#該程式未解開Section, 採用最新樣板產出!
{<section id="afat504_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-09-19 11:24:34), PR版次:0002(2016-09-05 16:10:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000131
#+ Filename...: afat504_02
#+ Description: 憑證預覽
#+ Creator....: 01531(2014-09-17 10:32:19)
#+ Modifier...: 02599 -SD/PR- 08742
 
{</section>}
 
{<section id="afat504_02.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160905-00007#2   2016/09/05  by 08742    调整系统中无ENT的SQL条件增加ent
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
PRIVATE TYPE type_g_fabo_m RECORD
       fabo035 LIKE fabo_t.fabo035, 
   fabo035_desc LIKE type_t.chr80, 
   fabo036 LIKE fabo_t.fabo036, 
   fabo036_desc LIKE type_t.chr80, 
   fabo037 LIKE fabo_t.fabo037, 
   fabo037_desc LIKE type_t.chr80, 
   fabo038 LIKE fabo_t.fabo038, 
   fabo038_desc LIKE type_t.chr80, 
   fabo031 LIKE fabo_t.fabo031, 
   fabo031_desc LIKE type_t.chr80, 
   fabo032 LIKE fabo_t.fabo032, 
   fabo032_desc LIKE type_t.chr80, 
   fabo033 LIKE fabo_t.fabo033, 
   fabo033_desc LIKE type_t.chr80, 
   fabo034 LIKE fabo_t.fabo034, 
   fabo034_desc LIKE type_t.chr80, 
   fabold LIKE fabo_t.fabold, 
   fabodocno LIKE fabo_t.fabodocno, 
   faboseq LIKE fabo_t.faboseq, 
   fabo039 LIKE fabo_t.fabo039, 
   fabo039_desc LIKE type_t.chr80, 
   fabo040 LIKE fabo_t.fabo040, 
   fabo040_desc LIKE type_t.chr80, 
   fabo041 LIKE fabo_t.fabo041
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_fabold LIKE fabo_t.fabold,
      b_fabodocno LIKE fabo_t.fabodocno,
      b_faboseq LIKE fabo_t.faboseq
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_fabgdocno           LIKE fabg_t.fabgdocno          #異動單號
DEFINE  g_fabgld             LIKE fabg_t.fabgld             #帳套
DEFINE  g_faboseq            LIKE fabo_t.faboseq                   #項次

DEFINE g_fabo_d DYNAMIC ARRAY OF  RECORD
   fabo042    LIKE fabo_t.fabo042,                           #摘要 
   fabo024    LIKE fabo_t.fabo024,                           #異動科目
   jfje       LIKE fabo_t.fabo008,                           #借方金額
   dfje       LIKE fabo_t.fabo008,                           #貸方金額
   jfje_1     LIKE fabo_t.fabo008,                           #本位幣二借方金額
   dfje_1     LIKE fabo_t.fabo008,                           #本位幣二貸方金額 
   jfje_2     LIKE fabo_t.fabo008,                           #本位幣三借方金額
   dfje_2     LIKE fabo_t.fabo008                            #本位幣三貸方金額
                        END RECORD
 
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_idx         LIKE type_t.num5              #單身 所在筆數(所有資料)
#end add-point
 
#模組變數(Module Variables)
DEFINE g_fabo_m        type_g_fabo_m  #單頭變數宣告
DEFINE g_fabo_m_t      type_g_fabo_m  #單頭舊值宣告(系統還原用)
DEFINE g_fabo_m_o      type_g_fabo_m  #單頭舊值宣告(其他用途)
DEFINE g_fabo_m_mask_o type_g_fabo_m  #轉換遮罩前資料
DEFINE g_fabo_m_mask_n type_g_fabo_m  #轉換遮罩後資料
 
   DEFINE g_fabold_t LIKE fabo_t.fabold
DEFINE g_fabodocno_t LIKE fabo_t.fabodocno
DEFINE g_faboseq_t LIKE fabo_t.faboseq
 
   
 
   
 
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
 
{<section id="afat504_02.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION afat504_02(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_fabgdocno,p_fabgld,p_faboseq
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE  p_fabgdocno     LIKE fabg_t.fabgdocno
   DEFINE  p_fabgld        LIKE fabg_t.fabgld
   DEFINE  p_faboseq       LIKE fabo_t.faboseq
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_fabgdocno=p_fabgdocno
   LET g_fabgld=p_fabgld
   LET g_faboseq=p_faboseq
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = "SELECT fabo035,'',fabo036,'',fabo037,'',fabo038,'',fabo031,'',fabo032,'',fabo033, 
       '',fabo034,'',fabold,fabodocno,faboseq,fabo039,'',fabo040,'',fabo041 FROM fabo_t WHERE faboent=  
       ? AND fabold=? AND fabodocno=? AND faboseq=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)   #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat504_02_cl CURSOR FROM g_forupd_sql     # LOCK CURSOR
 
   LET g_sql = " SELECT t0.fabo035,t0.fabo036,t0.fabo037,t0.fabo038,t0.fabo031,t0.fabo032,t0.fabo033, 
       t0.fabo034,t0.fabold,t0.fabodocno,t0.faboseq,t0.fabo039,t0.fabo040,t0.fabo041",
               " FROM fabo_t t0",
               " WHERE faboent = " ||g_enterprise|| " AND t0.fabold = ? AND t0.fabodocno = ? AND t0.faboseq = ?"
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afat504_02_master_referesh FROM g_sql
   
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat504_02 WITH FORM cl_ap_formpath("afa","afat504_02")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL afat504_02_init()   
 
   #進入選單 Menu (="N")
   CALL afat504_02_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_afat504_02
 
   CLOSE afat504_02_cl
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat504_02.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afat504_02_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   DROP TABLE fabo_temp_t;
   CREATE TEMP TABLE fabo_temp_t(
   faboent     SMALLINT,
   fabo042     VARCHAR(40),                                #摘要 
   fabo024     VARCHAR(24),                                #異動科目
   jfje        DECIMAL(20,6),                                #借方金額
   dfje        DECIMAL(20,6),                                #貸方金額
   jfje_1      DECIMAL(20,6),                                #本位幣二借方金額
   dfje_1      DECIMAL(20,6),                                #本位幣二貸方金額 
   jfje_2      DECIMAL(20,6),                                #本位幣三借方金額
   dfje_2      DECIMAL(20,6)     #本位幣三貸方金額
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   #end add-point
   
   #根據外部參數進行搜尋
   CALL afat504_02_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="afat504_02.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afat504_02_ui_dialog() 
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
            CALL afat504_02_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL afat504_02_b_fill()
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_fabo_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL afat504_02_init()
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
               CALL afat504_02_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afat504_02_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
 
 
               
            #第一筆資料
            ON ACTION first
               CALL afat504_02_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afat504_02_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL afat504_02_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL afat504_02_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL afat504_02_fetch("L")  
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
                  CALL afat504_02_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afat504_02_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afat504_02_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afat504_02_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afat504_02_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afat504_02_insert()
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
               CALL afat504_02_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afat504_02_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afat504_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afat504_02_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afat504_02_set_pk_array()
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
                  CALL afat504_02_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL afat504_02_browser_fill(g_wc,"")
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afat504_02_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
 
 
         
            
            
            #第一筆資料
            ON ACTION first
               CALL afat504_02_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afat504_02_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL afat504_02_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL afat504_02_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL afat504_02_fetch("L")  
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
                  CALL afat504_02_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afat504_02_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afat504_02_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afat504_02_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afat504_02_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afat504_02_insert()
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
               CALL afat504_02_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afat504_02_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afat504_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afat504_02_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afat504_02_set_pk_array()
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
 
{<section id="afat504_02.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION afat504_02_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "fabold,fabodocno,faboseq"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
    
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM fabo_t ",
               "  ",
               "  ",
               " WHERE faboent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("fabo_t")
                
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
      INITIALIZE g_fabo_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT '',t0.fabold,t0.fabodocno,t0.faboseq",
               " FROM fabo_t t0 ",
               "  ",
               
               " WHERE t0.faboent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("fabo_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"fabo_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fabold,g_browser[g_cnt].b_fabodocno, 
          g_browser[g_cnt].b_faboseq
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
   
   IF cl_null(g_browser[g_cnt].b_fabold) THEN
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
 
{<section id="afat504_02.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afat504_02_construct()
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
   INITIALIZE g_fabo_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON fabo035,fabo035_desc,fabo036,fabo036_desc,fabo037,fabo037_desc,fabo038, 
          fabo038_desc,fabo031,fabo031_desc,fabo032,fabo032_desc,fabo033,fabo033_desc,fabo034,fabo034_desc, 
          fabold,fabodocno,faboseq,fabo039,fabo039_desc,fabo040,fabo040_desc,fabo041
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         
      
         #一般欄位
                  #Ctrlp:construct.c.fabo035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo035
            #add-point:ON ACTION controlp INFIELD fabo035 name="construct.c.fabo035"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo035  #顯示到畫面上
            NEXT FIELD fabo035                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo035
            #add-point:BEFORE FIELD fabo035 name="construct.b.fabo035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo035
            
            #add-point:AFTER FIELD fabo035 name="construct.a.fabo035"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo035_desc
            #add-point:BEFORE FIELD fabo035_desc name="construct.b.fabo035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo035_desc
            
            #add-point:AFTER FIELD fabo035_desc name="construct.a.fabo035_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabo035_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo035_desc
            #add-point:ON ACTION controlp INFIELD fabo035_desc name="construct.c.fabo035_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabo036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo036
            #add-point:ON ACTION controlp INFIELD fabo036 name="construct.c.fabo036"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo036  #顯示到畫面上
            NEXT FIELD fabo036                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo036
            #add-point:BEFORE FIELD fabo036 name="construct.b.fabo036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo036
            
            #add-point:AFTER FIELD fabo036 name="construct.a.fabo036"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo036_desc
            #add-point:BEFORE FIELD fabo036_desc name="construct.b.fabo036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo036_desc
            
            #add-point:AFTER FIELD fabo036_desc name="construct.a.fabo036_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabo036_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo036_desc
            #add-point:ON ACTION controlp INFIELD fabo036_desc name="construct.c.fabo036_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabo037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo037
            #add-point:ON ACTION controlp INFIELD fabo037 name="construct.c.fabo037"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo037  #顯示到畫面上
            NEXT FIELD fabo037                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo037
            #add-point:BEFORE FIELD fabo037 name="construct.b.fabo037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo037
            
            #add-point:AFTER FIELD fabo037 name="construct.a.fabo037"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo037_desc
            #add-point:BEFORE FIELD fabo037_desc name="construct.b.fabo037_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo037_desc
            
            #add-point:AFTER FIELD fabo037_desc name="construct.a.fabo037_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabo037_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo037_desc
            #add-point:ON ACTION controlp INFIELD fabo037_desc name="construct.c.fabo037_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabo038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo038
            #add-point:ON ACTION controlp INFIELD fabo038 name="construct.c.fabo038"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo038  #顯示到畫面上
            NEXT FIELD fabo038                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo038
            #add-point:BEFORE FIELD fabo038 name="construct.b.fabo038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo038
            
            #add-point:AFTER FIELD fabo038 name="construct.a.fabo038"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo038_desc
            #add-point:BEFORE FIELD fabo038_desc name="construct.b.fabo038_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo038_desc
            
            #add-point:AFTER FIELD fabo038_desc name="construct.a.fabo038_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabo038_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo038_desc
            #add-point:ON ACTION controlp INFIELD fabo038_desc name="construct.c.fabo038_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabo031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo031
            #add-point:ON ACTION controlp INFIELD fabo031 name="construct.c.fabo031"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo031  #顯示到畫面上
            NEXT FIELD fabo031                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo031
            #add-point:BEFORE FIELD fabo031 name="construct.b.fabo031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo031
            
            #add-point:AFTER FIELD fabo031 name="construct.a.fabo031"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo031_desc
            #add-point:BEFORE FIELD fabo031_desc name="construct.b.fabo031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo031_desc
            
            #add-point:AFTER FIELD fabo031_desc name="construct.a.fabo031_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabo031_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo031_desc
            #add-point:ON ACTION controlp INFIELD fabo031_desc name="construct.c.fabo031_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabo032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo032
            #add-point:ON ACTION controlp INFIELD fabo032 name="construct.c.fabo032"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo032  #顯示到畫面上
            NEXT FIELD fabo032                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo032
            #add-point:BEFORE FIELD fabo032 name="construct.b.fabo032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo032
            
            #add-point:AFTER FIELD fabo032 name="construct.a.fabo032"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo032_desc
            #add-point:BEFORE FIELD fabo032_desc name="construct.b.fabo032_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo032_desc
            
            #add-point:AFTER FIELD fabo032_desc name="construct.a.fabo032_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabo032_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo032_desc
            #add-point:ON ACTION controlp INFIELD fabo032_desc name="construct.c.fabo032_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabo033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo033
            #add-point:ON ACTION controlp INFIELD fabo033 name="construct.c.fabo033"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo033  #顯示到畫面上
            NEXT FIELD fabo033                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo033
            #add-point:BEFORE FIELD fabo033 name="construct.b.fabo033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo033
            
            #add-point:AFTER FIELD fabo033 name="construct.a.fabo033"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo033_desc
            #add-point:BEFORE FIELD fabo033_desc name="construct.b.fabo033_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo033_desc
            
            #add-point:AFTER FIELD fabo033_desc name="construct.a.fabo033_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabo033_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo033_desc
            #add-point:ON ACTION controlp INFIELD fabo033_desc name="construct.c.fabo033_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabo034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo034
            #add-point:ON ACTION controlp INFIELD fabo034 name="construct.c.fabo034"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo034  #顯示到畫面上
            NEXT FIELD fabo034                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo034
            #add-point:BEFORE FIELD fabo034 name="construct.b.fabo034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo034
            
            #add-point:AFTER FIELD fabo034 name="construct.a.fabo034"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo034_desc
            #add-point:BEFORE FIELD fabo034_desc name="construct.b.fabo034_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo034_desc
            
            #add-point:AFTER FIELD fabo034_desc name="construct.a.fabo034_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabo034_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo034_desc
            #add-point:ON ACTION controlp INFIELD fabo034_desc name="construct.c.fabo034_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabold
            #add-point:BEFORE FIELD fabold name="construct.b.fabold"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabold
            
            #add-point:AFTER FIELD fabold name="construct.a.fabold"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabold
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabold
            #add-point:ON ACTION controlp INFIELD fabold name="construct.c.fabold"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabodocno
            #add-point:BEFORE FIELD fabodocno name="construct.b.fabodocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabodocno
            
            #add-point:AFTER FIELD fabodocno name="construct.a.fabodocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabodocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabodocno
            #add-point:ON ACTION controlp INFIELD fabodocno name="construct.c.fabodocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faboseq
            #add-point:BEFORE FIELD faboseq name="construct.b.faboseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faboseq
            
            #add-point:AFTER FIELD faboseq name="construct.a.faboseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faboseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faboseq
            #add-point:ON ACTION controlp INFIELD faboseq name="construct.c.faboseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabo039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo039
            #add-point:ON ACTION controlp INFIELD fabo039 name="construct.c.fabo039"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo039  #顯示到畫面上
            NEXT FIELD fabo039                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo039
            #add-point:BEFORE FIELD fabo039 name="construct.b.fabo039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo039
            
            #add-point:AFTER FIELD fabo039 name="construct.a.fabo039"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo039_desc
            #add-point:BEFORE FIELD fabo039_desc name="construct.b.fabo039_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo039_desc
            
            #add-point:AFTER FIELD fabo039_desc name="construct.a.fabo039_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabo039_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo039_desc
            #add-point:ON ACTION controlp INFIELD fabo039_desc name="construct.c.fabo039_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabo040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo040
            #add-point:ON ACTION controlp INFIELD fabo040 name="construct.c.fabo040"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo040  #顯示到畫面上
            NEXT FIELD fabo040                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo040
            #add-point:BEFORE FIELD fabo040 name="construct.b.fabo040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo040
            
            #add-point:AFTER FIELD fabo040 name="construct.a.fabo040"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo040_desc
            #add-point:BEFORE FIELD fabo040_desc name="construct.b.fabo040_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo040_desc
            
            #add-point:AFTER FIELD fabo040_desc name="construct.a.fabo040_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabo040_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo040_desc
            #add-point:ON ACTION controlp INFIELD fabo040_desc name="construct.c.fabo040_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo041
            #add-point:BEFORE FIELD fabo041 name="construct.b.fabo041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo041
            
            #add-point:AFTER FIELD fabo041 name="construct.a.fabo041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabo041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo041
            #add-point:ON ACTION controlp INFIELD fabo041 name="construct.c.fabo041"
            
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
 
{<section id="afat504_02.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afat504_02_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   RETURN
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
 
   INITIALIZE g_fabo_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL afat504_02_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afat504_02_browser_fill(g_wc,"F")
      CALL afat504_02_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL afat504_02_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL afat504_02_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="afat504_02.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afat504_02_fetch(p_fl)
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
   
   
   CALL afat504_02_browser_fill(g_wc,p_fl)
   
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
   LET g_fabo_m.fabold = g_browser[g_current_idx].b_fabold
   LET g_fabo_m.fabodocno = g_browser[g_current_idx].b_fabodocno
   LET g_fabo_m.faboseq = g_browser[g_current_idx].b_faboseq
 
                       
   #讀取單頭所有欄位資料
   EXECUTE afat504_02_master_referesh USING g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq INTO g_fabo_m.fabo035, 
       g_fabo_m.fabo036,g_fabo_m.fabo037,g_fabo_m.fabo038,g_fabo_m.fabo031,g_fabo_m.fabo032,g_fabo_m.fabo033, 
       g_fabo_m.fabo034,g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq,g_fabo_m.fabo039,g_fabo_m.fabo040, 
       g_fabo_m.fabo041
   
   #遮罩相關處理
   LET g_fabo_m_mask_o.* =  g_fabo_m.*
   CALL afat504_02_fabo_t_mask()
   LET g_fabo_m_mask_n.* =  g_fabo_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afat504_02_set_act_visible()
   CALL afat504_02_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_fabo_m_t.* = g_fabo_m.*
   LET g_fabo_m_o.* = g_fabo_m.*
   
   
   #重新顯示
   CALL afat504_02_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="afat504_02.insert" >}
#+ 資料新增
PRIVATE FUNCTION afat504_02_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_fabo_m.* TO NULL             #DEFAULT 設定
   LET g_fabold_t = NULL
   LET g_fabodocno_t = NULL
   LET g_faboseq_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      
 
      #append欄位給值
      
     
      #一般欄位給值
      
 
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point   
     
      #顯示狀態(stus)圖片
      
     
      #資料輸入
      CALL afat504_02_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_fabo_m.* TO NULL
         CALL afat504_02_show()
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
   CALL afat504_02_set_act_visible()
   CALL afat504_02_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fabold_t = g_fabo_m.fabold
   LET g_fabodocno_t = g_fabo_m.fabodocno
   LET g_faboseq_t = g_fabo_m.faboseq
 
   
   #組合新增資料的條件
   LET g_add_browse = " faboent = " ||g_enterprise|| " AND",
                      " fabold = '", g_fabo_m.fabold, "' "
                      ," AND fabodocno = '", g_fabo_m.fabodocno, "' "
                      ," AND faboseq = '", g_fabo_m.faboseq, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afat504_02_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afat504_02_master_referesh USING g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq INTO g_fabo_m.fabo035, 
       g_fabo_m.fabo036,g_fabo_m.fabo037,g_fabo_m.fabo038,g_fabo_m.fabo031,g_fabo_m.fabo032,g_fabo_m.fabo033, 
       g_fabo_m.fabo034,g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq,g_fabo_m.fabo039,g_fabo_m.fabo040, 
       g_fabo_m.fabo041
   
   
   #遮罩相關處理
   LET g_fabo_m_mask_o.* =  g_fabo_m.*
   CALL afat504_02_fabo_t_mask()
   LET g_fabo_m_mask_n.* =  g_fabo_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fabo_m.fabo035,g_fabo_m.fabo035_desc,g_fabo_m.fabo036,g_fabo_m.fabo036_desc,g_fabo_m.fabo037, 
       g_fabo_m.fabo037_desc,g_fabo_m.fabo038,g_fabo_m.fabo038_desc,g_fabo_m.fabo031,g_fabo_m.fabo031_desc, 
       g_fabo_m.fabo032,g_fabo_m.fabo032_desc,g_fabo_m.fabo033,g_fabo_m.fabo033_desc,g_fabo_m.fabo034, 
       g_fabo_m.fabo034_desc,g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq,g_fabo_m.fabo039,g_fabo_m.fabo039_desc, 
       g_fabo_m.fabo040,g_fabo_m.fabo040_desc,g_fabo_m.fabo041
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
 
   #功能已完成,通報訊息中心
   CALL afat504_02_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afat504_02.modify" >}
#+ 資料修改
PRIVATE FUNCTION afat504_02_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   RETURN
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_fabo_m.fabold IS NULL
 
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
   LET g_fabold_t = g_fabo_m.fabold
   LET g_fabodocno_t = g_fabo_m.fabodocno
   LET g_faboseq_t = g_fabo_m.faboseq
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN afat504_02_cl USING g_enterprise,g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat504_02_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afat504_02_cl
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat504_02_master_referesh USING g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq INTO g_fabo_m.fabo035, 
       g_fabo_m.fabo036,g_fabo_m.fabo037,g_fabo_m.fabo038,g_fabo_m.fabo031,g_fabo_m.fabo032,g_fabo_m.fabo033, 
       g_fabo_m.fabo034,g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq,g_fabo_m.fabo039,g_fabo_m.fabo040, 
       g_fabo_m.fabo041
 
   #檢查是否允許此動作
   IF NOT afat504_02_action_chk() THEN
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_fabo_m_mask_o.* =  g_fabo_m.*
   CALL afat504_02_fabo_t_mask()
   LET g_fabo_m_mask_n.* =  g_fabo_m.*
   
   
 
   #顯示資料
   CALL afat504_02_show()
   
   WHILE TRUE
      LET g_fabo_m.fabold = g_fabold_t
      LET g_fabo_m.fabodocno = g_fabodocno_t
      LET g_fabo_m.faboseq = g_faboseq_t
 
      
      #寫入修改者/修改日期資訊
      
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL afat504_02_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_fabo_m.* = g_fabo_m_t.*
         CALL afat504_02_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afat504_02_set_act_visible()
   CALL afat504_02_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " faboent = " ||g_enterprise|| " AND",
                      " fabold = '", g_fabo_m.fabold, "' "
                      ," AND fabodocno = '", g_fabo_m.fabodocno, "' "
                      ," AND faboseq = '", g_fabo_m.faboseq, "' "
 
   #填到對應位置
   CALL afat504_02_browser_fill(g_wc,"")
 
   CLOSE afat504_02_cl
 
   #功能已完成,通報訊息中心
   CALL afat504_02_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="afat504_02.input" >}
#+ 資料輸入
PRIVATE FUNCTION afat504_02_input(p_cmd)
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
   DISPLAY BY NAME g_fabo_m.fabo035,g_fabo_m.fabo035_desc,g_fabo_m.fabo036,g_fabo_m.fabo036_desc,g_fabo_m.fabo037, 
       g_fabo_m.fabo037_desc,g_fabo_m.fabo038,g_fabo_m.fabo038_desc,g_fabo_m.fabo031,g_fabo_m.fabo031_desc, 
       g_fabo_m.fabo032,g_fabo_m.fabo032_desc,g_fabo_m.fabo033,g_fabo_m.fabo033_desc,g_fabo_m.fabo034, 
       g_fabo_m.fabo034_desc,g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq,g_fabo_m.fabo039,g_fabo_m.fabo039_desc, 
       g_fabo_m.fabo040,g_fabo_m.fabo040_desc,g_fabo_m.fabo041
   
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
   CALL afat504_02_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afat504_02_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_fabo_m.fabo035,g_fabo_m.fabo036,g_fabo_m.fabo037,g_fabo_m.fabo038,g_fabo_m.fabo031, 
          g_fabo_m.fabo032,g_fabo_m.fabo033,g_fabo_m.fabo034,g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq, 
          g_fabo_m.fabo039,g_fabo_m.fabo040,g_fabo_m.fabo041 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo035
            
            #add-point:AFTER FIELD fabo035 name="input.a.fabo035"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo035
            #add-point:BEFORE FIELD fabo035 name="input.b.fabo035"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo035
            #add-point:ON CHANGE fabo035 name="input.g.fabo035"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo036
            
            #add-point:AFTER FIELD fabo036 name="input.a.fabo036"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo036
            #add-point:BEFORE FIELD fabo036 name="input.b.fabo036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo036
            #add-point:ON CHANGE fabo036 name="input.g.fabo036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo037
            
            #add-point:AFTER FIELD fabo037 name="input.a.fabo037"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo037
            #add-point:BEFORE FIELD fabo037 name="input.b.fabo037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo037
            #add-point:ON CHANGE fabo037 name="input.g.fabo037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo038
            
            #add-point:AFTER FIELD fabo038 name="input.a.fabo038"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo038
            #add-point:BEFORE FIELD fabo038 name="input.b.fabo038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo038
            #add-point:ON CHANGE fabo038 name="input.g.fabo038"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo031
            
            #add-point:AFTER FIELD fabo031 name="input.a.fabo031"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo031
            #add-point:BEFORE FIELD fabo031 name="input.b.fabo031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo031
            #add-point:ON CHANGE fabo031 name="input.g.fabo031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo032
            
            #add-point:AFTER FIELD fabo032 name="input.a.fabo032"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo032
            #add-point:BEFORE FIELD fabo032 name="input.b.fabo032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo032
            #add-point:ON CHANGE fabo032 name="input.g.fabo032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo033
            
            #add-point:AFTER FIELD fabo033 name="input.a.fabo033"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo033
            #add-point:BEFORE FIELD fabo033 name="input.b.fabo033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo033
            #add-point:ON CHANGE fabo033 name="input.g.fabo033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo034
            
            #add-point:AFTER FIELD fabo034 name="input.a.fabo034"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo034
            #add-point:BEFORE FIELD fabo034 name="input.b.fabo034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo034
            #add-point:ON CHANGE fabo034 name="input.g.fabo034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabold
            #add-point:BEFORE FIELD fabold name="input.b.fabold"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabold
            
            #add-point:AFTER FIELD fabold name="input.a.fabold"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_fabo_m.fabold) AND NOT cl_null(g_fabo_m.fabodocno) AND NOT cl_null(g_fabo_m.faboseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabo_m.fabold != g_fabold_t  OR g_fabo_m.fabodocno != g_fabodocno_t  OR g_fabo_m.faboseq != g_faboseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabo_t WHERE "||"faboent = '" ||g_enterprise|| "' AND "||"fabold = '"||g_fabo_m.fabold ||"' AND "|| "fabodocno = '"||g_fabo_m.fabodocno ||"' AND "|| "faboseq = '"||g_fabo_m.faboseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabold
            #add-point:ON CHANGE fabold name="input.g.fabold"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabodocno
            #add-point:BEFORE FIELD fabodocno name="input.b.fabodocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabodocno
            
            #add-point:AFTER FIELD fabodocno name="input.a.fabodocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_fabo_m.fabold) AND NOT cl_null(g_fabo_m.fabodocno) AND NOT cl_null(g_fabo_m.faboseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabo_m.fabold != g_fabold_t  OR g_fabo_m.fabodocno != g_fabodocno_t  OR g_fabo_m.faboseq != g_faboseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabo_t WHERE "||"faboent = '" ||g_enterprise|| "' AND "||"fabold = '"||g_fabo_m.fabold ||"' AND "|| "fabodocno = '"||g_fabo_m.fabodocno ||"' AND "|| "faboseq = '"||g_fabo_m.faboseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabodocno
            #add-point:ON CHANGE fabodocno name="input.g.fabodocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faboseq
            #add-point:BEFORE FIELD faboseq name="input.b.faboseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faboseq
            
            #add-point:AFTER FIELD faboseq name="input.a.faboseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_fabo_m.fabold) AND NOT cl_null(g_fabo_m.fabodocno) AND NOT cl_null(g_fabo_m.faboseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabo_m.fabold != g_fabold_t  OR g_fabo_m.fabodocno != g_fabodocno_t  OR g_fabo_m.faboseq != g_faboseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabo_t WHERE "||"faboent = '" ||g_enterprise|| "' AND "||"fabold = '"||g_fabo_m.fabold ||"' AND "|| "fabodocno = '"||g_fabo_m.fabodocno ||"' AND "|| "faboseq = '"||g_fabo_m.faboseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faboseq
            #add-point:ON CHANGE faboseq name="input.g.faboseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo039
            
            #add-point:AFTER FIELD fabo039 name="input.a.fabo039"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo039
            #add-point:BEFORE FIELD fabo039 name="input.b.fabo039"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo039
            #add-point:ON CHANGE fabo039 name="input.g.fabo039"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo040
            
            #add-point:AFTER FIELD fabo040 name="input.a.fabo040"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo040
            #add-point:BEFORE FIELD fabo040 name="input.b.fabo040"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo040
            #add-point:ON CHANGE fabo040 name="input.g.fabo040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo041
            #add-point:BEFORE FIELD fabo041 name="input.b.fabo041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo041
            
            #add-point:AFTER FIELD fabo041 name="input.a.fabo041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo041
            #add-point:ON CHANGE fabo041 name="input.g.fabo041"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fabo035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo035
            #add-point:ON ACTION controlp INFIELD fabo035 name="input.c.fabo035"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_m.fabo035             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001()                                #呼叫開窗

            LET g_fabo_m.fabo035 = g_qryparam.return1              

            DISPLAY g_fabo_m.fabo035 TO fabo035              #

            NEXT FIELD fabo035                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabo036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo036
            #add-point:ON ACTION controlp INFIELD fabo036 name="input.c.fabo036"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_m.fabo036             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001()                                #呼叫開窗

            LET g_fabo_m.fabo036 = g_qryparam.return1              

            DISPLAY g_fabo_m.fabo036 TO fabo036              #

            NEXT FIELD fabo036                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabo037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo037
            #add-point:ON ACTION controlp INFIELD fabo037 name="input.c.fabo037"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_m.fabo037             #給予default值
            LET g_qryparam.default2 = "" #g_fabo_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabo_m.fabo037 = g_qryparam.return1              
            #LET g_fabo_m.oocq002 = g_qryparam.return2 
            DISPLAY g_fabo_m.fabo037 TO fabo037              #
            #DISPLAY g_fabo_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabo037                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabo038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo038
            #add-point:ON ACTION controlp INFIELD fabo038 name="input.c.fabo038"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_m.fabo038             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_fabo_m.fabo038 = g_qryparam.return1              

            DISPLAY g_fabo_m.fabo038 TO fabo038              #

            NEXT FIELD fabo038                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabo031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo031
            #add-point:ON ACTION controlp INFIELD fabo031 name="input.c.fabo031"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_m.fabo031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooed004_1()                                #呼叫開窗

            LET g_fabo_m.fabo031 = g_qryparam.return1              

            DISPLAY g_fabo_m.fabo031 TO fabo031              #

            NEXT FIELD fabo031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabo032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo032
            #add-point:ON ACTION controlp INFIELD fabo032 name="input.c.fabo032"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_m.fabo032             #給予default值
            LET g_qryparam.default2 = "" #g_fabo_m.ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooeg001()                                #呼叫開窗

            LET g_fabo_m.fabo032 = g_qryparam.return1              
            #LET g_fabo_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_fabo_m.fabo032 TO fabo032              #
            #DISPLAY g_fabo_m.ooeg001 TO ooeg001 #部門編號
            NEXT FIELD fabo032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabo033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo033
            #add-point:ON ACTION controlp INFIELD fabo033 name="input.c.fabo033"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_m.fabo033             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooed004_1()                                #呼叫開窗

            LET g_fabo_m.fabo033 = g_qryparam.return1              

            DISPLAY g_fabo_m.fabo033 TO fabo033              #

            NEXT FIELD fabo033                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabo034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo034
            #add-point:ON ACTION controlp INFIELD fabo034 name="input.c.fabo034"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_m.fabo034             #給予default值
            LET g_qryparam.default2 = "" #g_fabo_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabo_m.fabo034 = g_qryparam.return1              
            #LET g_fabo_m.oocq002 = g_qryparam.return2 
            DISPLAY g_fabo_m.fabo034 TO fabo034              #
            #DISPLAY g_fabo_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabo034                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabold
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabold
            #add-point:ON ACTION controlp INFIELD fabold name="input.c.fabold"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabodocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabodocno
            #add-point:ON ACTION controlp INFIELD fabodocno name="input.c.fabodocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.faboseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faboseq
            #add-point:ON ACTION controlp INFIELD faboseq name="input.c.faboseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabo039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo039
            #add-point:ON ACTION controlp INFIELD fabo039 name="input.c.fabo039"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_m.fabo039             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_fabo_m.fabo039 = g_qryparam.return1              

            DISPLAY g_fabo_m.fabo039 TO fabo039              #

            NEXT FIELD fabo039                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabo040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo040
            #add-point:ON ACTION controlp INFIELD fabo040 name="input.c.fabo040"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_m.fabo040             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjbb002()                                #呼叫開窗

            LET g_fabo_m.fabo040 = g_qryparam.return1              

            DISPLAY g_fabo_m.fabo040 TO fabo040              #

            NEXT FIELD fabo040                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabo041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo041
            #add-point:ON ACTION controlp INFIELD fabo041 name="input.c.fabo041"
            
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
               SELECT COUNT(1) INTO l_count FROM fabo_t
                WHERE faboent = g_enterprise AND fabold = g_fabo_m.fabold
                  AND fabodocno = g_fabo_m.fabodocno
                  AND faboseq = g_fabo_m.faboseq
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO fabo_t (faboent,fabo035,fabo036,fabo037,fabo038,fabo031,fabo032,fabo033, 
                      fabo034,fabold,fabodocno,faboseq,fabo039,fabo040,fabo041)
                  VALUES (g_enterprise,g_fabo_m.fabo035,g_fabo_m.fabo036,g_fabo_m.fabo037,g_fabo_m.fabo038, 
                      g_fabo_m.fabo031,g_fabo_m.fabo032,g_fabo_m.fabo033,g_fabo_m.fabo034,g_fabo_m.fabold, 
                      g_fabo_m.fabodocno,g_fabo_m.faboseq,g_fabo_m.fabo039,g_fabo_m.fabo040,g_fabo_m.fabo041)  
 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fabo_m.fabold
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afat504_02_fabo_t_mask_restore('restore_mask_o')
               
               UPDATE fabo_t SET (fabo035,fabo036,fabo037,fabo038,fabo031,fabo032,fabo033,fabo034,fabold, 
                   fabodocno,faboseq,fabo039,fabo040,fabo041) = (g_fabo_m.fabo035,g_fabo_m.fabo036,g_fabo_m.fabo037, 
                   g_fabo_m.fabo038,g_fabo_m.fabo031,g_fabo_m.fabo032,g_fabo_m.fabo033,g_fabo_m.fabo034, 
                   g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq,g_fabo_m.fabo039,g_fabo_m.fabo040, 
                   g_fabo_m.fabo041)
                WHERE faboent = g_enterprise AND fabold = g_fabold_t #
                  AND fabodocno = g_fabodocno_t
                  AND faboseq = g_faboseq_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabo_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL afat504_02_fabo_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_fabo_m_t)
                     LET g_log2 = util.JSON.stringify(g_fabo_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     ELSE
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
 
{<section id="afat504_02.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afat504_02_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE fabo_t.fabold 
   DEFINE l_oldno     LIKE fabo_t.fabold 
   DEFINE l_newno02     LIKE fabo_t.fabodocno 
   DEFINE l_oldno02     LIKE fabo_t.fabodocno 
   DEFINE l_newno03     LIKE fabo_t.faboseq 
   DEFINE l_oldno03     LIKE fabo_t.faboseq 
 
   DEFINE l_master    RECORD LIKE fabo_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_fabo_m.fabold IS NULL
      OR g_fabo_m.fabodocno IS NULL
      OR g_fabo_m.faboseq IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_fabold_t = g_fabo_m.fabold
   LET g_fabodocno_t = g_fabo_m.fabodocno
   LET g_faboseq_t = g_fabo_m.faboseq
 
   
   #清空key值
   LET g_fabo_m.fabold = ""
   LET g_fabo_m.fabodocno = ""
   LET g_fabo_m.faboseq = ""
 
    
   CALL afat504_02_set_entry("a")
   CALL afat504_02_set_no_entry("a")
   
   #公用欄位給予預設值
   
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL afat504_02_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_fabo_m.* TO NULL
      CALL afat504_02_show()
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
      LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單頭複製後 name="reproduce.head.a_insert"
   
   #end add-point
   
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afat504_02_set_act_visible()
   CALL afat504_02_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fabold_t = g_fabo_m.fabold
   LET g_fabodocno_t = g_fabo_m.fabodocno
   LET g_faboseq_t = g_fabo_m.faboseq
 
   
   #組合新增資料的條件
   LET g_add_browse = " faboent = " ||g_enterprise|| " AND",
                      " fabold = '", g_fabo_m.fabold, "' "
                      ," AND fabodocno = '", g_fabo_m.fabodocno, "' "
                      ," AND faboseq = '", g_fabo_m.faboseq, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afat504_02_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
              
   #功能已完成,通報訊息中心
   CALL afat504_02_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="afat504_02.show" >}
#+ 資料顯示 
PRIVATE FUNCTION afat504_02_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   RETURN
   #end add-point
   
   
   
   #帶出公用欄位reference值
   
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afat504_02_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fabo_m.fabo035,g_fabo_m.fabo035_desc,g_fabo_m.fabo036,g_fabo_m.fabo036_desc,g_fabo_m.fabo037, 
       g_fabo_m.fabo037_desc,g_fabo_m.fabo038,g_fabo_m.fabo038_desc,g_fabo_m.fabo031,g_fabo_m.fabo031_desc, 
       g_fabo_m.fabo032,g_fabo_m.fabo032_desc,g_fabo_m.fabo033,g_fabo_m.fabo033_desc,g_fabo_m.fabo034, 
       g_fabo_m.fabo034_desc,g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq,g_fabo_m.fabo039,g_fabo_m.fabo039_desc, 
       g_fabo_m.fabo040,g_fabo_m.fabo040_desc,g_fabo_m.fabo041
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL afat504_02_set_pk_array()
   
   #顯示狀態(stus)圖片
   
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   CALL afat504_02_b_fill()
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afat504_02.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION afat504_02_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   RETURN
   #end add-point  
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_fabo_m.fabold IS NULL
   OR g_fabo_m.fabodocno IS NULL
   OR g_fabo_m.faboseq IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_fabold_t = g_fabo_m.fabold
   LET g_fabodocno_t = g_fabo_m.fabodocno
   LET g_faboseq_t = g_fabo_m.faboseq
 
   
   
 
   OPEN afat504_02_cl USING g_enterprise,g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat504_02_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afat504_02_cl
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat504_02_master_referesh USING g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq INTO g_fabo_m.fabo035, 
       g_fabo_m.fabo036,g_fabo_m.fabo037,g_fabo_m.fabo038,g_fabo_m.fabo031,g_fabo_m.fabo032,g_fabo_m.fabo033, 
       g_fabo_m.fabo034,g_fabo_m.fabold,g_fabo_m.fabodocno,g_fabo_m.faboseq,g_fabo_m.fabo039,g_fabo_m.fabo040, 
       g_fabo_m.fabo041
   
   
   #檢查是否允許此動作
   IF NOT afat504_02_action_chk() THEN
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fabo_m_mask_o.* =  g_fabo_m.*
   CALL afat504_02_fabo_t_mask()
   LET g_fabo_m_mask_n.* =  g_fabo_m.*
   
   #將最新資料顯示到畫面上
   CALL afat504_02_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat504_02_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM fabo_t 
       WHERE faboent = g_enterprise AND fabold = g_fabo_m.fabold 
         AND fabodocno = g_fabo_m.fabodocno 
         AND faboseq = g_fabo_m.faboseq 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fabo_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE afat504_02_cl
         RETURN
      END IF
      
      CLEAR FORM
      CALL afat504_02_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL afat504_02_browser_fill(g_wc,"")
         CALL afat504_02_fetch("P")
      ELSE
         CLEAR FORM
      END IF
   ELSE    
   END IF
 
   CLOSE afat504_02_cl
 
   #功能已完成,通報訊息中心
   CALL afat504_02_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afat504_02.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afat504_02_ui_browser_refresh()
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
      IF g_browser[l_i].b_fabold = g_fabo_m.fabold
         AND g_browser[l_i].b_fabodocno = g_fabo_m.fabodocno
         AND g_browser[l_i].b_faboseq = g_fabo_m.faboseq
 
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
 
{<section id="afat504_02.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afat504_02_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("fabold,fabodocno,faboseq",TRUE)
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
 
{<section id="afat504_02.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afat504_02_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fabold,fabodocno,faboseq",FALSE)
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
 
{<section id="afat504_02.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afat504_02_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afat504_02.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afat504_02_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afat504_02.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afat504_02_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization" 
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   LET  g_argv[01]=g_fabgld
   LET  g_argv[02]=g_fabgdocno
   LET  g_argv[03]=g_faboseq
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   RETURN
   #end add-point  
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " fabold = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " fabodocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " faboseq = '", g_argv[03], "' AND "
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
 
{<section id="afat504_02.mask_functions" >}
&include "erp/afa/afat504_02_mask.4gl"
 
{</section>}
 
{<section id="afat504_02.state_change" >}
   
 
{</section>}
 
{<section id="afat504_02.signature" >}
   
 
{</section>}
 
{<section id="afat504_02.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afat504_02_set_pk_array()
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
   LET g_pk_array[1].values = g_fabo_m.fabold
   LET g_pk_array[1].column = 'fabold'
   LET g_pk_array[2].values = g_fabo_m.fabodocno
   LET g_pk_array[2].column = 'fabodocno'
   LET g_pk_array[3].values = g_fabo_m.faboseq
   LET g_pk_array[3].column = 'faboseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat504_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afat504_02.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afat504_02_msgcentre_notify(lc_state)
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
   CALL afat504_02_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fabo_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat504_02.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afat504_02_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afat504_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 欄位取值顯示
################################################################################
PRIVATE FUNCTION afat504_02_b_fill()
DEFINE p_wc2    STRING
   #add-point:b_fill段define
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_glaa015       LIKE glaa_t.glaa015
   DEFINE l_glaa016       LIKE glaa_t.glaa016
   DEFINE l_glaa019       LIKE glaa_t.glaa019
   DEFINE l_glaa020       LIKE glaa_t.glaa020
   DEFINE l_fabh021       STRING
   DEFINE l_str           STRING 
   DEFINE l_str1          STRING
   DEFINE l_str2          STRING
   DEFINE l_str3          STRING
   DEFINE l_str4          STRING
   DEFINE l_msg1          STRING
   DEFINE l_msg2          STRING
   DEFINE l_msg3          STRING
   DEFINE l_msg4          STRING
   DEFINE l_fabo024       LIKE fabo_t.fabo024
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_jfje          LIKE fabo_t.fabo008
   DEFINE l_jfje_1        LIKE fabo_t.fabo008
   DEFINE l_jfje_2        LIKE fabo_t.fabo008
   DEFINE l_dfje          LIKE fabo_t.fabo008
   DEFINE l_dfje_1        LIKE fabo_t.fabo008
   DEFINE l_dfje_2        LIKE fabo_t.fabo008
   DEFINE g_fabo_1_m RECORD
      fabo013 LIKE fabo_t.fabo013, 
      fabo014 LIKE fabo_t.fabo014, 
      fabo019 LIKE fabo_t.fabo019, 
      fabo020 LIKE fabo_t.fabo020, 
      fabo026 LIKE fabo_t.fabo026, 
      fabo027 LIKE fabo_t.fabo027, 
      fabo028 LIKE fabo_t.fabo028, 
      fabo031 LIKE fabo_t.fabo031, 
      fabo049 LIKE fabo_t.fabo049, 
      fabo024 LIKE fabo_t.fabo024, 
      fabo018 LIKE fabo_t.fabo018,
      fabo001 LIKE fabo_t.fabo001,
      fabo002 LIKE fabo_t.fabo002,
      fabo003 LIKE fabo_t.fabo003,
      fabo042 LIKE fabo_t.fabo042,
      fabo107 LIKE fabo_t.fabo107,
      fabo108 LIKE fabo_t.fabo108,
      fabo109 LIKE fabo_t.fabo109,
      fabo156 LIKE fabo_t.fabo156,
      fabo157 LIKE fabo_t.fabo157,
      fabo158 LIKE fabo_t.fabo158,
      fabo029 LIKE fabo_t.fabo029,
      fabo030 LIKE fabo_t.fabo030,
      fabo105 LIKE fabo_t.fabo105,
      fabo154 LIKE fabo_t.fabo154,
      fabo104 LIKE fabo_t.fabo104,
      fabo153 LIKE fabo_t.fabo153,
      fabo106 LIKE fabo_t.fabo106,
      fabo155 LIKE fabo_t.fabo155
       END RECORD
DEFINE l_faah006  LIKE faah_t.faah006
DEFINE l_faal004  LIKE faal_t.faal004
   
   
    SELECT glaa015,glaa016,glaa019,glaa020
     INTO l_glaa015,l_glaa016,l_glaa019,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_fabgld
      
   LET l_str1 = cl_getmsg("axr-00090",g_lang)     #借方金額(
   LET l_str2 = cl_getmsg("axr-00091",g_lang)     #貸方金額(
   LET l_str3 = cl_getmsg("axr-00092",g_lang)     #)(本位幣二)
   LET l_str4 = cl_getmsg("axr-00093",g_lang)     #)(本位幣三)
   
   LET l_msg1 = l_str1 CLIPPED,l_glaa016 CLIPPED,l_str3
   LET l_msg2 = l_str2 CLIPPED,l_glaa016 CLIPPED,l_str3
   LET l_msg3 = l_str1 CLIPPED,l_glaa020 CLIPPED,l_str4
   LET l_msg4 = l_str2 CLIPPED,l_glaa020 CLIPPED,l_str4
      
   IF l_glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible('jfje_1,dfje_1',TRUE)
      CALL cl_set_comp_att_text('jfje_1',l_msg1)
      CALL cl_set_comp_att_text('dfje_1',l_msg2)
   ELSE
      CALL cl_set_comp_visible('jfje_1,dfje_1',FALSE)
   END IF
      
   IF l_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible('jfje_2,dfje_2',TRUE)
      CALL cl_set_comp_att_text('jfje_2',l_msg3)
      CALL cl_set_comp_att_text('dfje_2',l_msg4)
   ELSE
      CALL cl_set_comp_visible('jfje_2,dfje_2',FALSE)
   END IF
   
   
   LET l_ac=1
   LET g_sql = "SELECT t0.fabo001,t0.fabo002,t0.fabo003, t0.fabo013,t0.fabo014,t0.fabo018,
                t0.fabo019,t0.fabo020,t0.fabo024, t0.fabo026,t0.fabo027,t0.fabo028,
                t0.fabo031,t0.fabo049,t0.fabo042, t0.fabo107,t0.fabo108,t0.fabo109,
                t0.fabo156,t0.fabo157,t0.fabo158, t0.fabo029,t0.fabo030,t0.fabo105,
                t0.fabo154,t0.fabo104,t0.fabo153, t0.fabo106,t0.fabo155 
                FROM fabo_t t0",
               "",
               
               " WHERE t0.faboent= ? AND t0.fabodocno='",g_fabgdocno,"'  AND t0.fabold='",g_fabgld,"' AND  1=1   " 

   LET g_sql = g_sql, cl_sql_add_filter("fabo_t"),
                      " ORDER BY t0.fabo001,t0.fabo002,t0.fabo003"

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afat504_02_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR afat504_02_pb2
   
   OPEN b_fill_curs2 USING g_enterprise
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs2 INTO g_fabo_1_m.fabo001,g_fabo_1_m.fabo002,  g_fabo_1_m.fabo003,
                             g_fabo_1_m.fabo013, g_fabo_1_m.fabo014, g_fabo_1_m.fabo018, g_fabo_1_m.fabo019, 
                             g_fabo_1_m.fabo020, g_fabo_1_m.fabo024, g_fabo_1_m.fabo026, g_fabo_1_m.fabo027, 
                             g_fabo_1_m.fabo028, g_fabo_1_m.fabo031, g_fabo_1_m.fabo049, g_fabo_1_m.fabo042,
                             g_fabo_1_m.fabo107,g_fabo_1_m.fabo108,  g_fabo_1_m.fabo109,g_fabo_1_m.fabo156,
                             g_fabo_1_m.fabo157,g_fabo_1_m.fabo158,g_fabo_1_m.fabo029,
                             g_fabo_1_m.fabo030,g_fabo_1_m.fabo105,g_fabo_1_m.fabo154,g_fabo_1_m.fabo104,
                             g_fabo_1_m.fabo153,g_fabo_1_m.fabo106,g_fabo_1_m.fabo155        
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF  
      #根据财编+卡片编号+附号获取资产主类别
       SELECT faah006 INTO l_faah006 FROM faah_t WHERE faahent=g_enterprise AND faah001=g_fabo_1_m.fabo001 AND faah003=g_fabo_1_m.fabo002 AND faah004=g_fabo_1_m.fabo003
                 
       #根据帐套+资产主类别判断是否转入清理科目
       SELECT faal004 INTO l_faal004 FROM faal_t WHERE faalent=g_enterprise AND faalld=g_fabgld AND faal001=l_faah006
       IF l_faal004='Y' THEN  
         #借方科目    
               #固資清理科目    
         IF g_fabo_1_m.fabo018-g_fabo_1_m.fabo019-g_fabo_1_m.fabo020=0 AND    
            g_fabo_1_m.fabo107-g_fabo_1_m.fabo108-g_fabo_1_m.fabo109=0 AND   
            g_fabo_1_m.fabo156-g_fabo_1_m.fabo157-g_fabo_1_m.fabo158=0 THEN
         ELSE
            LET l_count=0
            IF NOT cl_null(g_fabo_1_m.fabo024) THEN 
               SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo024 
            END IF               
            IF l_count<1 THEN  #科目不存在于临时表，新增数据            
               INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_fabo_1_m.fabo042,g_fabo_1_m.fabo024,g_fabo_1_m.fabo018-g_fabo_1_m.fabo019-g_fabo_1_m.fabo020,0,
                                  g_fabo_1_m.fabo107-g_fabo_1_m.fabo108-g_fabo_1_m.fabo109,0, g_fabo_1_m.fabo156-g_fabo_1_m.fabo157-g_fabo_1_m.fabo158,0)
            ELSE 
               SELECT jfje,jfje_1,jfje_2 INTO l_jfje,l_jfje_1,l_jfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo024
               UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                 =   (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo024,
                                      g_fabo_1_m.fabo018-g_fabo_1_m.fabo019-g_fabo_1_m.fabo020+l_jfje,0,
                                      g_fabo_1_m.fabo107-g_fabo_1_m.fabo108-g_fabo_1_m.fabo109+l_jfje_1,0,
                                      g_fabo_1_m.fabo156-g_fabo_1_m.fabo157-g_fabo_1_m.fabo158+l_jfje_2,0)
                                   WHERE fabo024=g_fabo_1_m.fabo024 
               
            END IF
         END IF
          #累折科目
          IF g_fabo_1_m.fabo019=0 AND g_fabo_1_m.fabo108=0 AND g_fabo_1_m.fabo157=0 THEN
          ELSE 
             LET l_count=0
             IF NOT cl_null(g_fabo_1_m.fabo026) THEN 
                SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo026
             END IF               
             IF l_count<1 THEN  #科目不存在于临时表，新增数据         
                INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_fabo_1_m.fabo042,g_fabo_1_m.fabo026,g_fabo_1_m.fabo019,0,
                                    g_fabo_1_m.fabo108,0, g_fabo_1_m.fabo157,0)
             ELSE
                SELECT jfje,jfje_1,jfje_2 INTO l_jfje,l_jfje_1,l_jfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo026
                UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo026,g_fabo_1_m.fabo019+l_jfje,0,
                                       g_fabo_1_m.fabo108+l_jfje_1,0, g_fabo_1_m.fabo157+l_jfje_2,0)
                                   WHERE fabo024=g_fabo_1_m.fabo026 
               
             END IF
                            
          END IF                          
                #減值準備科目  
         IF g_fabo_1_m.fabo020=0 AND g_fabo_1_m.fabo109=0 AND g_fabo_1_m.fabo158=0 THEN 
         ELSE      
            LET l_count=0
            IF NOT cl_null(g_fabo_1_m.fabo027) THEN 
               SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo027
            END IF               
            IF l_count<1 THEN  #科目不存在于临时表，新增数据      
               INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo027,g_fabo_1_m.fabo020,0,
                                    g_fabo_1_m.fabo109,0, g_fabo_1_m.fabo158,0)
            ELSE
               SELECT jfje,jfje_1,jfje_2 INTO l_jfje,l_jfje_1,l_jfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo027
               UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo027,g_fabo_1_m.fabo020+l_jfje,0,
                                    g_fabo_1_m.fabo109+l_jfje_1,0, g_fabo_1_m.fabo158+l_jfje_2,0)
                                   WHERE fabo024=g_fabo_1_m.fabo027 
            END IF
         END IF 
         
         #貸方科目    
               #資產科目（成本）  
         IF  g_fabo_1_m.fabo018=0 AND g_fabo_1_m.fabo107=0 AND g_fabo_1_m.fabo156=0 THEN
         ELSE
            LET l_count=0
            IF NOT cl_null(g_fabo_1_m.fabo028) THEN 
               SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo028
            END IF 
            IF l_count<1 THEN  #科目不存在于临时表，新增数据  
               INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_fabo_1_m.fabo042,g_fabo_1_m.fabo028,0,g_fabo_1_m.fabo018,
                                    0, g_fabo_1_m.fabo107,0, g_fabo_1_m.fabo156)
             ELSE 
                SELECT dfje,dfje_1,dfje_2 INTO l_dfje,l_dfje_1,l_dfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo028
                UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo028,0,g_fabo_1_m.fabo018+l_dfje,
                                    0, g_fabo_1_m.fabo107+l_dfje_1,0, g_fabo_1_m.fabo156+l_dfje_2)
                                   WHERE fabo024=g_fabo_1_m.fabo028 
             END IF
          END IF                    
       ELSE 
       
          IF g_fabo_1_m.fabo049>0 THEN 
             #借方科目
                  #出售應收科目 
            IF g_fabo_1_m.fabo014=0 AND g_fabo_1_m.fabo105=0 AND g_fabo_1_m.fabo154=0 THEN
            ELSE         
               LET l_count=0
               IF NOT cl_null(g_fabo_1_m.fabo029) THEN 
                  SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo029
               END IF 
               IF l_count<1 THEN  #科目不存在于临时表，新增数据  
               INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo029,g_fabo_1_m.fabo014,0,
                                  g_fabo_1_m.fabo105,0, g_fabo_1_m.fabo154,0)
               ELSE 
                  SELECT jfje,jfje_1,jfje_2 INTO l_jfje,l_jfje_1,l_jfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo029
                  UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo029,g_fabo_1_m.fabo014+l_jfje,0,
                                    g_fabo_1_m.fabo105+l_jfje_1,0, g_fabo_1_m.fabo154+l_jfje_2,0)
                                   WHERE fabo024=g_fabo_1_m.fabo029 

               END IF
            END IF                      
                  #減值科目
             IF g_fabo_1_m.fabo020=0 AND g_fabo_1_m.fabo109=0 AND g_fabo_1_m.fabo158=0 THEN
             ELSE
                LET l_count=0
                IF NOT cl_null(g_fabo_1_m.fabo027) THEN 
                   SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo027
                END IF 
                IF l_count<1 THEN  #科目不存在于临时表，新增数据  
                   INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo027,g_fabo_1_m.fabo020,0,
                                   g_fabo_1_m.fabo109,0, g_fabo_1_m.fabo158,0) 
                ELSE 
                   SELECT jfje,jfje_1,jfje_2 INTO l_jfje,l_jfje_1,l_jfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo027
                   UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo027,g_fabo_1_m.fabo020+l_jfje,0,
                                       g_fabo_1_m.fabo109+l_jfje_1,0, g_fabo_1_m.fabo158+l_jfje_2,0)
                                   WHERE fabo024=g_fabo_1_m.fabo027 
                END IF
             END IF                      
                   #累折科目
             IF g_fabo_1_m.fabo019=0 AND g_fabo_1_m.fabo108=0 AND g_fabo_1_m.fabo157=0 THEN
             ELSE
                LET l_count=0             
                IF NOT cl_null(g_fabo_1_m.fabo026) THEN 
                   SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo026
                END IF 
                IF l_count<1 THEN  #科目不存在于临时表，新增数据  
                   INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo026,g_fabo_1_m.fabo019,0,
                                    g_fabo_1_m.fabo108,0, g_fabo_1_m.fabo157,0)
                ELSE
                   SELECT jfje,jfje_1,jfje_2 INTO l_jfje,l_jfje_1,l_jfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo026
                   UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo026,g_fabo_1_m.fabo019+l_jfje,0,
                                    g_fabo_1_m.fabo108+l_jfje_1,0, g_fabo_1_m.fabo157+l_jfje_2,0)
                                   WHERE fabo024=g_fabo_1_m.fabo026 
                END IF                
             END IF                                 
                                    
             #貸方科目
                     #稅額科目 
             IF g_fabo_1_m.fabo030=0 AND  g_fabo_1_m.fabo104=0 AND  g_fabo_1_m.fabo153=0 THEN
             ELSE 
                LET l_count=0             
                IF NOT cl_null(g_fabo_1_m.fabo030) THEN 
                   SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo030
                END IF 
                IF l_count<1 THEN  #科目不存在于临时表，新增数据               
                   INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo030,0,g_fabo_1_m.fabo013,
                                    0, g_fabo_1_m.fabo104,0, g_fabo_1_m.fabo153) 
                ELSE
                   SELECT dfje,dfje_1,dfje_2 INTO l_dfje,l_dfje_1,l_dfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo030
                   UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo030,0,g_fabo_1_m.fabo013+l_dfje,
                                       0, g_fabo_1_m.fabo104+l_fdje_1,0, g_fabo_1_m.fabo153+l_dfje_2)
                                   WHERE fabo024=g_fabo_1_m.fabo030 
                END IF
             END IF                                 
                     #資產科目（成本）
             IF g_fabo_1_m.fabo018=0 AND  g_fabo_1_m.fabo107=0 AND  g_fabo_1_m.fabo156=0 THEN
             ELSE       
               LET l_count=0             
               IF NOT cl_null(g_fabo_1_m.fabo028) THEN 
                  SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo028
               END IF 
               IF l_count<1 THEN  #科目不存在于临时表，新增数据                            
                  INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo028,0,g_fabo_1_m.fabo018,
                                    0,g_fabo_1_m.fabo107,0, g_fabo_1_m.fabo156)
                ELSE
                   SELECT dfje,dfje_1,dfje_2 INTO l_dfje,l_dfje_1,l_dfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo028
                   UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo028,0,g_fabo_1_m.fabo018+l_dfje,
                                    0,g_fabo_1_m.fabo107+l_dfje_1,0, g_fabo_1_m.fabo156+l_dfje_2)
                                   WHERE fabo024=g_fabo_1_m.fabo028 
                END IF                
             END IF                                 
                      #營業處收入科目  
             IF  g_fabo_1_m.fabo049=0 AND g_fabo_1_m.fabo106=0 AND g_fabo_1_m.fabo155=0 THEN 
             ELSE
                IF NOT cl_null(g_fabo_1_m.fabo024) THEN 
                   SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo024
                END IF 
                IF l_count<1 THEN  #科目不存在于临时表，新增数据                
                  INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo024,0,g_fabo_1_m.fabo049,
                                    0,g_fabo_1_m.fabo106,0, g_fabo_1_m.fabo155)
                ELSE
                   SELECT dfje,dfje_1,dfje_2 INTO l_dfje,l_dfje_1,l_dfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo024
                   UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo024,0,g_fabo_1_m.fabo049+l_dfje,
                                    0,g_fabo_1_m.fabo106+l_dfje_1,0, g_fabo_1_m.fabo155+l_dfje_2)
                                   WHERE fabo024=g_fabo_1_m.fabo024 
                END IF                
             END IF 
             
          ELSE 
          
             #借方科目
                  #出售應收科目 
             IF  g_fabo_1_m.fabo014=0 AND  g_fabo_1_m.fabo105=0 AND  g_fabo_1_m.fabo154=0 THEN
             ELSE 
                LET l_count=0             
                IF NOT cl_null(g_fabo_1_m.fabo029) THEN 
                   SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo029
                END IF 
                IF l_count<1 THEN  #科目不存在于临时表，新增数据               
                   INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo029,g_fabo_1_m.fabo014,0,
                                  g_fabo_1_m.fabo105,0, g_fabo_1_m.fabo154,0)
                 ELSE
                    SELECT jfje,jfje_1,jfje_2 INTO l_jfje,l_jfje_1,l_jfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo026
                    UPDATE fabo_temp_t SET (faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo029,g_fabo_1_m.fabo014+l_jfje,0,
                                  g_fabo_1_m.fabo105+l_jfje_1,0, g_fabo_1_m.fabo154+l_jfje_2,0)
                                   WHERE fabo024=g_fabo_1_m.fabo029 
                 
                 END IF
             END IF                      
                  #減值科目
             IF g_fabo_1_m.fabo020=0 AND g_fabo_1_m.fabo109=0 AND g_fabo_1_m.fabo158=0 THEN 
             ELSE
                LET l_count=0             
                IF NOT cl_null(g_fabo_1_m.fabo027) THEN 
                   SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo027
                END IF 
                IF l_count<1 THEN  #科目不存在于临时表，新增数据            
                   INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo027,g_fabo_1_m.fabo020,0,
                                    g_fabo_1_m.fabo109,0, g_fabo_1_m.fabo158,0)
                ELSE
                   SELECT jfje,jfje_1,jfje_2 INTO l_jfje,l_jfje_1,l_jfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo027
                   UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo027,g_fabo_1_m.fabo020+l_jfje,0,
                                    g_fabo_1_m.fabo109+l_jfje_1,0, g_fabo_1_m.fabo158+l_jfje_2,0)
                                    WHERE fabo024=g_fabo_1_m.fabo027 
                END IF
             END IF                                 
                   #累折科目
             IF g_fabo_1_m.fabo019=0 AND g_fabo_1_m.fabo108=0 AND g_fabo_1_m.fabo157=0 THEN 
             ELSE
                LET l_count=0             
                IF NOT cl_null(g_fabo_1_m.fabo026) THEN 
                   SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo026
                END IF 
                IF l_count<1 THEN  #科目不存在于临时表，新增数据                   
                   INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo026,g_fabo_1_m.fabo019,0,
                                    g_fabo_1_m.fabo108,0, g_fabo_1_m.fabo157,0)
                ELSE 
                   SELECT jfje,jfje_1,jfje_2 INTO l_jfje,l_jfje_1,l_jfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo026
                   UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo026,g_fabo_1_m.fabo019+l_jfje,0,
                                    g_fabo_1_m.fabo108+l_jfje_1,0, g_fabo_1_m.fabo157+l_jfje_2,0)
                                    WHERE fabo024=g_fabo_1_m.fabo026 
                END IF                
             END IF                                 
                    #營業處支出科目
             IF g_fabo_1_m.fabo049=0 AND g_fabo_1_m.fabo106=0 AND g_fabo_1_m.fabo155=0 THEN 
             ELSE
                LET l_count=0             
                IF NOT cl_null(g_fabo_1_m.fabo024) THEN 
                   SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo024
                END IF 
                IF l_count<1 THEN  #科目不存在于临时表，新增数据    
                  INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo024,g_fabo_1_m.fabo049,0,
                                    g_fabo_1_m.fabo106,0, g_fabo_1_m.fabo155,0)
                ELSE
                   SELECT jfje,jfje_1,jfje_2 INTO l_jfje,l_jfje_1,l_jfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo024
                   UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo024,g_fabo_1_m.fabo049+l_jfje,0,
                                    g_fabo_1_m.fabo106+l_jfje_1,0, g_fabo_1_m.fabo155+l_jfje_2,0)
                                    WHERE fabo024=g_fabo_1_m.fabo024 
                END IF      
             END IF                                 
            #貸方科目   
                #稅額科目
             IF g_fabo_1_m.fabo013=0 AND  g_fabo_1_m.fabo104=0 AND  g_fabo_1_m.fabo153=0 THEN
             ELSE
                LET l_count=0
                IF NOT cl_null(g_fabo_1_m.fabo030) THEN 
                   SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo030
                END IF 
                IF l_count<1 THEN  #科目不存在于临时表，新增数据         
                   INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo030,0,g_fabo_1_m.fabo013,
                                    0, g_fabo_1_m.fabo104,0, g_fabo_1_m.fabo153)
                ELSE
                   SELECT dfje,dfje_1,dfje_2 INTO l_dfje,l_dfje_1,l_dfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo030
                   UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo030,0,g_fabo_1_m.fabo013+l_dfje,
                                       0, g_fabo_1_m.fabo104+l_dfje_1,0, g_fabo_1_m.fabo153+l_dfje_2)
                                 WHERE fabo024=g_fabo_1_m.fabo030 
                END IF                
             END IF                                 
                     #資產科目（成本）
             IF g_fabo_1_m.fabo018=0 AND  g_fabo_1_m.fabo107=0 AND  g_fabo_1_m.fabo156=0 THEN 
             ELSE
                LET l_count=0
                IF NOT cl_null(g_fabo_1_m.fabo028) THEN 
                   SELECT COUNT(*) INTO l_count FROM  fabo_temp_t  WHERE fabo024=g_fabo_1_m.fabo028
                END IF 
                IF l_count<1 THEN  #科目不存在于临时表，新增数据               
                   INSERT INTO fabo_temp_t(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                            VALUES(g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo028,0,g_fabo_1_m.fabo018,
                                    0,g_fabo_1_m.fabo107,0, g_fabo_1_m.fabo156)
                ELSE 
                   SELECT dfje,dfje_1,dfje_2 INTO l_dfje,l_dfje_1,l_dfje_2 FROM fabo_temp_t WHERE fabo024=g_fabo_1_m.fabo028
                   UPDATE fabo_temp_t SET(faboent,fabo042,fabo024,jfje,dfje,jfje_1,dfje_1,jfje_2,dfje_2)
                                   =  (g_enterprise,g_fabo_1_m.fabo042,g_fabo_1_m.fabo028,0,g_fabo_1_m.fabo018+l_dfje,
                                    0,g_fabo_1_m.fabo107+l_dfje_1,0, g_fabo_1_m.fabo156+l_dfje_2)
                                 WHERE fabo024=g_fabo_1_m.fabo028 
                END IF
             END IF                                 
                 
          END IF                     
      END IF


      LET l_ac = l_ac + 1
      
   END FOREACH
#   SELECT fabo001,fabo002,fabo003, fabo013,fabo014,fabo018,fabo019,fabo020,fabo024,fabo026,fabo027,fabo028,fabo031,fabo049,fabo042,
#          fabo107,fabo108,fabo109,fabo156,fabo157,fabo158,fabo029,fabo030,fabo105,fabo154,fabo104,fabo153,fabo106,fabo155
#   INTO g_fabo_1_m.fabo001,g_fabo_1_m.fabo002,  g_fabo_1_m.fabo003,
#        g_fabo_1_m.fabo013, g_fabo_1_m.fabo014, g_fabo_1_m.fabo018, g_fabo_1_m.fabo019, 
#        g_fabo_1_m.fabo020, g_fabo_1_m.fabo024, g_fabo_1_m.fabo026, g_fabo_1_m.fabo027, 
#        g_fabo_1_m.fabo028, g_fabo_1_m.fabo031, g_fabo_1_m.fabo049, g_fabo_1_m.fabo042,
#        g_fabo_1_m.fabo107,g_fabo_1_m.fabo108,  g_fabo_1_m.fabo109,g_fabo_1_m.fabo156,
#        g_fabo_1_m.fabo157,g_fabo_1_m.fabo158,g_fabo_1_m.fabo029,
#        g_fabo_1_m.fabo030,g_fabo_1_m.fabo105,g_fabo_1_m.fabo154,g_fabo_1_m.fabo104,
#        g_fabo_1_m.fabo153,g_fabo_1_m.fabo106,g_fabo_1_m.fabo155
#        
#    FROM fabo_t 
#    WHERE fabodocno=g_fabgdocno AND faboseq=g_faboseq AND fabold=g_fabgld  
      
   
   LET g_sql="SELECT  UNIQUE t0.fabo042,t0.fabo024,t0.jfje,t0.dfje,t0.jfje_1,t0.dfje_1,t0.jfje_2,t0.dfje_2 FROM fabo_temp_t t0",
               "",
               
               " WHERE t0.faboent= ? "
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"fabh_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afat504_02_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR afat504_02_pb1
   
   OPEN b_fill_curs1 USING g_enterprise
 
   CALL g_fabo_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs1 INTO g_fabo_d[l_ac].fabo042, g_fabo_d[l_ac].fabo024, g_fabo_d[l_ac].jfje, g_fabo_d[l_ac].dfje, 
                             g_fabo_d[l_ac].jfje_1, g_fabo_d[l_ac].dfje_1, g_fabo_d[l_ac].jfje_2, g_fabo_d[l_ac].dfje_2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      CALL afat504_02_fabo024_desc(g_fabo_d[l_ac].fabo024) RETURNING l_fabo024,l_str
      LET g_fabo_d[l_ac].fabo024=g_fabo_d[l_ac].fabo024,l_str,'\n',l_fabo024
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
 
      LET l_ac = l_ac + 1
      
   END FOREACH
 
   LET g_error_show = 0
   
 
   
   CALL g_fabo_d.deleteElement(g_fabo_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_fabo_d.getLength()
 
   END FOR
   
   IF g_cnt > g_fabo_d.getLength() THEN
      LET l_ac = g_fabo_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
   
   ERROR "" 
   LET g_detail_cnt = g_fabo_d.getLength()
   #CALL afat504_02_get_org_data()
   CLOSE b_fill_curs1
   FREE afat504_02_pb1
  
   CALL afat504_02_b_show()
   #CALL afat504_02_b_detail()
END FUNCTION

################################################################################
# Descriptions...: 科目名稱組合
################################################################################
PRIVATE FUNCTION afat504_02_fabo024_desc(p_fabo024)
DEFINE p_fabo024           LIKE fabo_t.fabo024
DEFINE l_fabo024_desc      LIKE glacl_t.glacl004
DEFINE r_glaq002           STRING
DEFINE l_oogf002_desc      LIKE oofa_t.oofa011
DEFINE r_str               STRING
DEFINE l_fabo     RECORD 
         fabo031   LIKE fabo_t.fabo031,
         fabo032   LIKE fabo_t.fabo032,
         fabo033   LIKE fabo_t.fabo033,
         fabo034   LIKE fabo_t.fabo034,
         fabo035   LIKE fabo_t.fabo035,
         fabo036   LIKE fabo_t.fabo036,
         fabo037   LIKE fabo_t.fabo037,
         fabo038   LIKE fabo_t.fabo038,
         fabo039   LIKE fabo_t.fabo039,
         fabo040   LIKE fabo_t.fabo040
                   END RECORD
   
   SELECT fabo031,fabo032,fabo033,fabo034,
          fabo035,fabo036,fabo037,fabo038,
          fabo039,fabo040
     INTO l_fabo.*
     FROM fabo_t
    WHERE faboent = g_enterprise
      AND fabold = g_fabgld 
      AND fabodocno = g_fabgdocno  

   
   #抓取科目名称
   LET l_fabo024_desc = ''
   SELECT glacl004 INTO l_fabo024_desc FROM glacl_t,glaa_t
    WHERE glaaent = glaclent 
      AND glaa004 = glacl001
      AND glaclent = g_enterprise
      AND glaald = g_fabgld
      AND glacl002 = p_fabo024
      AND glacl003 = g_dlang  


   #组合名称以及核算项
   LET r_glaq002 = ''
   LET r_str = ''
   #營運據點
   IF NOT cl_null(l_fabo.fabo031) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_fabo.fabo031
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_glaq002 = g_rtn_fields[1]     
      LET r_str = l_fabo.fabo031 
   END IF
   #部门
   IF NOT cl_null(l_fabo.fabo032) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_fabo.fabo032
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_glaq002 = g_rtn_fields[1]   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabo.fabo032
      ELSE
         LET r_str=l_fabo.fabo032
      END IF   
   END IF 
   #成本利润中心
   IF NOT cl_null(l_fabo.fabo033) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_fabo.fabo033
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabo.fabo033
      ELSE
         LET r_str=l_fabo.fabo033
      END IF      
   END IF 
   
   #区域
   IF NOT cl_null(l_fabo.fabo034) THEN 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '287'
      LET g_ref_fields[2] = l_fabo.fabo034
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields  
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabo.fabo034
      ELSE
         LET r_str=l_fabo.fabo034
      END IF       
   END IF 
   #交易客商
   IF NOT cl_null(l_fabo.fabo035) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_fabo.fabo035
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1] 
      ELSE
         LET r_glaq002 = g_rtn_fields[1] 
      END IF    
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabo.fabo035
      ELSE
         LET r_str=l_fabo.fabo035
      END IF       
   END IF 
   #帐款客商
   IF NOT cl_null(l_fabo.fabo036) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_fabo.fabo036
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF     
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabo.fabo036
      ELSE
         LET r_str=l_fabo.fabo036
      END IF        
   END IF 
   #客群
   IF NOT cl_null(l_fabo.fabo037) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '281'
      LET g_ref_fields[2] = l_fabo.fabo037
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF  
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabo.fabo037
      ELSE
         LET r_str=l_fabo.fabo037
      END IF        
   END IF 
   
  
   #人员
   IF NOT cl_null(l_fabo.fabo038) THEN
      LET  l_oogf002_desc = ''
      SELECT oofa011 INTO l_oogf002_desc FROM oofa_t
       WHERE oofaent = g_enterprise
         AND oofa001 IN (SELECT ooag002 FROM ooag_t
                          WHERE ooagent = g_enterprise
                            AND ooag001 = l_fabo.fabo038)
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_oogf002_desc
      ELSE
         LET r_glaq002 = l_oogf002_desc
      END IF     
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabo.fabo038
      ELSE
         LET r_str=l_fabo.fabo038
      END IF       
   END IF 
   
   #专案编号
   IF NOT cl_null(l_fabo.fabo039) THEN
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_fabo.fabo039
      ELSE
         LET r_glaq002 = l_fabo.fabo039
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabo.fabo039
      ELSE
         LET r_str=l_fabo.fabo039
      END IF          
   END IF 
   #WBS
   IF NOT cl_null(l_fabo.fabo040) THEN
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_fabo.fabo040
      ELSE
         LET r_glaq002 = l_fabo.fabo040
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabo.fabo040
      ELSE
         LET r_str=l_fabo.fabo040
      END IF       
   END IF 
   #组合科目名称以及核算项
   LET r_glaq002 = l_fabo024_desc,'\n',
                   r_glaq002
   IF NOT cl_null(r_str) THEN
      LET r_str="(",r_str,")"
   END IF  
   RETURN r_glaq002,r_str 
END FUNCTION

################################################################################
# Descriptions...: 获取核算项
################################################################################
PRIVATE FUNCTION afat504_02_get_org_data()
   SELECT fabo031,fabo032,fabo033,fabo034,fabo035,fabo036,fabo037,fabo038,fabo039,fabo040
      INTO g_fabo_m.fabo031,g_fabo_m.fabo032,g_fabo_m.fabo033,
           g_fabo_m.fabo034,g_fabo_m.fabo035,g_fabo_m.fabo036,
           g_fabo_m.fabo037,g_fabo_m.fabo038,g_fabo_m.fabo039,g_fabo_m.fabo040
       #FROM fabo_t WHERE fabold=g_fabgld AND fabodocno=g_fabgdocno AND fabo024=g_fabo_d[g_detail_idx].fabo024   #160905-00007#2 mark
       FROM fabo_t WHERE fabold=g_fabgld AND fabodocno=g_fabgdocno AND fabo024=g_fabo_d[g_detail_idx].fabo024 AND faboent = g_enterprise   #160905-00007#2 add
       DISPLAY g_fabo_m.fabo031 TO fabo031
       DISPLAY g_fabo_m.fabo032 TO fabo032
       DISPLAY g_fabo_m.fabo033 TO fabo033
       DISPLAY g_fabo_m.fabo034 TO fabo034
       DISPLAY g_fabo_m.fabo035 TO fabo035
       DISPLAY g_fabo_m.fabo036 TO fabo036
       DISPLAY g_fabo_m.fabo037 TO fabo037
       DISPLAY g_fabo_m.fabo038 TO fabo038
       DISPLAY g_fabo_m.fabo039 TO fabo039
       DISPLAY g_fabo_m.fabo040 TO fabo040 
       CALL afat504_02_get_org_desc()
END FUNCTION

################################################################################
# Descriptions...:获取核算项说明
################################################################################
PRIVATE FUNCTION afat504_02_get_org_desc()
LET g_ref_fields[1] = g_fabo_m.fabo031
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabo_m.fabo031_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_fabo_m.fabo031_desc TO fabo031_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabo_m.fabo032
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabo_m.fabo032_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabo_m.fabo032_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabo_m.fabo033
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabo_m.fabo033_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabo_m.fabo033_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabo_m.fabo034
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='287' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabo_m.fabo034_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabo_m.fabo034_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabo_m.fabo035
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabo_m.fabo035_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabo_m.fabo035_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabo_m.fabo036
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabo_m.fabo036_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabo_m.fabo036_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabo_m.fabo037
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabo_m.fabo037_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabo_m.fabo037_desc

   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabo_m.fabo038
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_fabo_m.fabo038_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabo_m.fabo038_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabo_m.fabo039
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabo_m.fabo039_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabo_m.fabo039_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabo_m.fabo039
   LET g_ref_fields[2] = g_fabo_m.fabo040
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabo_m.fabo040_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabo_m.fabo040_desc
END FUNCTION

################################################################################
# Descriptions...: 科目显示
################################################################################
PRIVATE FUNCTION afat504_02_b_show()
 DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      DISPLAY ARRAY g_fabo_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
            
      BEFORE DISPLAY
         BEFORE ROW
             LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
             LET l_ac = g_detail_idx

             CALL cl_show_fld_cont() 
               
            CALL afat504_02_set_pk_array()
            CALL afat504_02_get_org_data()         
      END DISPLAY
      
      BEFORE DIALOG
      
      ON ACTION close
         LET INT_FLAG=FALSE         
         LET g_action_choice="exit"
         EXIT DIALOG
      
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DIALOG
   END DIALOG
END FUNCTION

 
{</section>}
 
