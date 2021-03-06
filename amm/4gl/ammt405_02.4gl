#該程式未解開Section, 採用最新樣板產出!
{<section id="ammt405_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-06-11 10:27:42), PR版次:0003(2016-11-23 18:40:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: ammt405_02
#+ Description: 卡密碼設定
#+ Creator....: 03247(2015-06-11 10:25:53)
#+ Modifier...: 03247 -SD/PR- 02159
 
{</section>}
 
{<section id="ammt405_02.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160824-00007#123 2016/11/23 By sakura  新舊值備份處理
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT JAVA java.security.MessageDigest
IMPORT JAVA java.lang.String
IMPORT JAVA java.lang.Byte
IMPORT JAVA java.lang.Integer
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"  
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_mmaq_m RECORD
       mmaq001 LIKE type_t.chr30, 
   mmaq001_2 LIKE type_t.chr30, 
   pwd1 LIKE type_t.chr500, 
   pwd2 LIKE type_t.chr500, 
   pwd3 LIKE type_t.chr500
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_mmaq001 LIKE mmaq_t.mmaq001
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_mmaq001_t  LIKE mmaq_t.mmaq001
DEFINE g_type       LIKE type_t.chr1
DEFINE g_bcard      LIKE mmaq_t.mmaq001
DEFINE g_ecard      LIKE mmaq_t.mmaq001
DEFINE g_cardtype   LIKE mmaq_t.mmaq002
#end add-point
 
#模組變數(Module Variables)
DEFINE g_mmaq_m        type_g_mmaq_m  #單頭變數宣告
DEFINE g_mmaq_m_t      type_g_mmaq_m  #單頭舊值宣告(系統還原用)
DEFINE g_mmaq_m_o      type_g_mmaq_m  #單頭舊值宣告(其他用途)
DEFINE g_mmaq_m_mask_o type_g_mmaq_m  #轉換遮罩前資料
DEFINE g_mmaq_m_mask_n type_g_mmaq_m  #轉換遮罩後資料
 
   
   
 
   
 
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
 
{<section id="ammt405_02.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION ammt405_02(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_type,p_bcard,p_ecard
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_type       LIKE type_t.chr1
   DEFINE p_bcard      LIKE mmaq_t.mmaq001
   DEFINE p_ecard      LIKE mmaq_t.mmaq001
   DEFINE p_cardtype   LIKE mmaq_t.mmaq002
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_type = p_type
   LET g_bcard = p_bcard
   LET g_ecard = p_ecard
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = "SELECT '','','','','' FROM mmaq_t WHERE mmaqent= ? AND mmaq001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)   #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt405_02_cl CURSOR FROM g_forupd_sql     # LOCK CURSOR
 
   LET g_sql = " SELECT t0.mmaq001",
               " FROM mmaq_t t0",
               " WHERE mmaqent = " ||g_enterprise|| " AND t0.mmaq001 = ?"
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE ammt405_02_master_referesh FROM g_sql
   
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_ammt405_02 WITH FORM cl_ap_formpath("amm","ammt405_02")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL ammt405_02_init()   
 
   #進入選單 Menu (="N")
   CALL ammt405_02_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_ammt405_02
 
   CLOSE ammt405_02_cl
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt405_02.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ammt405_02_init()
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
   CALL cl_set_act_visible("modify,delete,query", FALSE)
   IF g_type = '1' THEN
      CALL cl_set_comp_visible("pwd1",TRUE)
   ELSE
      CALL cl_set_comp_visible("pwd1",FALSE)
   END IF
   LET g_actdefault = "insert"
   #end add-point
   
   #根據外部參數進行搜尋
   CALL ammt405_02_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="ammt405_02.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ammt405_02_ui_dialog() 
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
            CALL ammt405_02_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            CALL cl_set_act_visible("modify,delete,query", TRUE)
            RETURN
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
         INITIALIZE g_mmaq_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL ammt405_02_init()
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
               CALL ammt405_02_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL ammt405_02_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
 
 
               
            #第一筆資料
            ON ACTION first
               CALL ammt405_02_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL ammt405_02_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL ammt405_02_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL ammt405_02_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL ammt405_02_fetch("L")  
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
                  CALL ammt405_02_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL ammt405_02_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL ammt405_02_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL ammt405_02_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL ammt405_02_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL ammt405_02_insert()
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
               CALL ammt405_02_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL ammt405_02_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL ammt405_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL ammt405_02_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL ammt405_02_set_pk_array()
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
                  CALL ammt405_02_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL ammt405_02_browser_fill(g_wc,"")
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL ammt405_02_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
 
 
         
            
            
            #第一筆資料
            ON ACTION first
               CALL ammt405_02_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL ammt405_02_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL ammt405_02_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL ammt405_02_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL ammt405_02_fetch("L")  
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
                  CALL ammt405_02_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL ammt405_02_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL ammt405_02_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL ammt405_02_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL ammt405_02_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL ammt405_02_insert()
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
               CALL ammt405_02_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL ammt405_02_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL ammt405_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL ammt405_02_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL ammt405_02_set_pk_array()
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
 
{<section id="ammt405_02.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION ammt405_02_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "mmaq001"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM mmaq_t ",
               "  ",
               "  ",
               " WHERE mmaqent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("mmaq_t")
                
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
      INITIALIZE g_mmaq_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT '',t0.mmaq001",
               " FROM mmaq_t t0 ",
               "  ",
               
               " WHERE t0.mmaqent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("mmaq_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"mmaq_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mmaq001
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
   
   IF cl_null(g_browser[g_cnt].b_mmaq001) THEN
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
 
{<section id="ammt405_02.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION ammt405_02_construct()
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
   INITIALIZE g_mmaq_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON mmaq001,mmaq001_2,pwd1,pwd2,pwd3
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         
      
         #一般欄位
                  #Ctrlp:construct.c.mmaq001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaq001
            #add-point:ON ACTION controlp INFIELD mmaq001 name="construct.c.mmaq001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mmaq001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaq001  #顯示到畫面上
            NEXT FIELD mmaq001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaq001
            #add-point:BEFORE FIELD mmaq001 name="construct.b.mmaq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaq001
            
            #add-point:AFTER FIELD mmaq001 name="construct.a.mmaq001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaq001_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaq001_2
            #add-point:ON ACTION controlp INFIELD mmaq001_2 name="construct.c.mmaq001_2"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mmaq001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaq001_2  #顯示到畫面上
            NEXT FIELD mmaq001_2                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaq001_2
            #add-point:BEFORE FIELD mmaq001_2 name="construct.b.mmaq001_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaq001_2
            
            #add-point:AFTER FIELD mmaq001_2 name="construct.a.mmaq001_2"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pwd1
            #add-point:BEFORE FIELD pwd1 name="construct.b.pwd1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pwd1
            
            #add-point:AFTER FIELD pwd1 name="construct.a.pwd1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pwd1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pwd1
            #add-point:ON ACTION controlp INFIELD pwd1 name="construct.c.pwd1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pwd2
            #add-point:BEFORE FIELD pwd2 name="construct.b.pwd2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pwd2
            
            #add-point:AFTER FIELD pwd2 name="construct.a.pwd2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pwd2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pwd2
            #add-point:ON ACTION controlp INFIELD pwd2 name="construct.c.pwd2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pwd3
            #add-point:BEFORE FIELD pwd3 name="construct.b.pwd3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pwd3
            
            #add-point:AFTER FIELD pwd3 name="construct.a.pwd3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pwd3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pwd3
            #add-point:ON ACTION controlp INFIELD pwd3 name="construct.c.pwd3"
            
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
 
{<section id="ammt405_02.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION ammt405_02_query()
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
 
   INITIALIZE g_mmaq_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL ammt405_02_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL ammt405_02_browser_fill(g_wc,"F")
      CALL ammt405_02_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL ammt405_02_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL ammt405_02_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="ammt405_02.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION ammt405_02_fetch(p_fl)
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
   
   
   CALL ammt405_02_browser_fill(g_wc,p_fl)
   
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
   LET g_mmaq_m.mmaq001 = g_browser[g_current_idx].b_mmaq001
 
                       
   #讀取單頭所有欄位資料
   EXECUTE ammt405_02_master_referesh USING g_mmaq_m.mmaq001 INTO g_mmaq_m.mmaq001
   
   #遮罩相關處理
   LET g_mmaq_m_mask_o.* =  g_mmaq_m.*
   CALL ammt405_02_mmaq_t_mask()
   LET g_mmaq_m_mask_n.* =  g_mmaq_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL ammt405_02_set_act_visible()
   CALL ammt405_02_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_mmaq_m_t.* = g_mmaq_m.*
   LET g_mmaq_m_o.* = g_mmaq_m.*
   
   
   #重新顯示
   CALL ammt405_02_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="ammt405_02.insert" >}
#+ 資料新增
PRIVATE FUNCTION ammt405_02_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_mmaq_m.* TO NULL             #DEFAULT 設定
   LET g_mmaq001_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      
 
      #append欄位給值
      
     
      #一般欄位給值
      
 
      #add-point:單頭預設值 name="insert.default"
      LET g_mmaq_m.mmaq001 = g_bcard
      LET g_mmaq_m.mmaq001_2 = g_ecard
      #end add-point   
     
      #顯示狀態(stus)圖片
      
     
      #資料輸入
      CALL ammt405_02_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         INITIALIZE g_mmaq_m.* TO NULL
      END IF
      RETURN
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_mmaq_m.* TO NULL
         CALL ammt405_02_show()
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
   CALL ammt405_02_set_act_visible()
   CALL ammt405_02_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_mmaq001_t = g_mmaq_m.mmaq001
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmaqent = " ||g_enterprise|| " AND",
                      " mmaq001 = '", g_mmaq_m.mmaq001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt405_02_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE ammt405_02_master_referesh USING g_mmaq_m.mmaq001 INTO g_mmaq_m.mmaq001
   
   
   #遮罩相關處理
   LET g_mmaq_m_mask_o.* =  g_mmaq_m.*
   CALL ammt405_02_mmaq_t_mask()
   LET g_mmaq_m_mask_n.* =  g_mmaq_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmaq_m.mmaq001,g_mmaq_m.mmaq001_2,g_mmaq_m.pwd1,g_mmaq_m.pwd2,g_mmaq_m.pwd3
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
 
   #功能已完成,通報訊息中心
   CALL ammt405_02_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="ammt405_02.modify" >}
#+ 資料修改
PRIVATE FUNCTION ammt405_02_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_mmaq_m.mmaq001 IS NULL
 
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
   LET g_mmaq001_t = g_mmaq_m.mmaq001
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN ammt405_02_cl USING g_enterprise,g_mmaq_m.mmaq001
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt405_02_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE ammt405_02_cl
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt405_02_master_referesh USING g_mmaq_m.mmaq001 INTO g_mmaq_m.mmaq001
 
   #檢查是否允許此動作
   IF NOT ammt405_02_action_chk() THEN
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_mmaq_m_mask_o.* =  g_mmaq_m.*
   CALL ammt405_02_mmaq_t_mask()
   LET g_mmaq_m_mask_n.* =  g_mmaq_m.*
   
   
 
   #顯示資料
   CALL ammt405_02_show()
   
   WHILE TRUE
      LET g_mmaq_m.mmaq001 = g_mmaq001_t
 
      
      #寫入修改者/修改日期資訊
      
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL ammt405_02_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_mmaq_m.* = g_mmaq_m_t.*
         CALL ammt405_02_show()
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
   CALL ammt405_02_set_act_visible()
   CALL ammt405_02_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mmaqent = " ||g_enterprise|| " AND",
                      " mmaq001 = '", g_mmaq_m.mmaq001, "' "
 
   #填到對應位置
   CALL ammt405_02_browser_fill(g_wc,"")
 
   CLOSE ammt405_02_cl
 
   #功能已完成,通報訊息中心
   CALL ammt405_02_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="ammt405_02.input" >}
#+ 資料輸入
PRIVATE FUNCTION ammt405_02_input(p_cmd)
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
   DEFINE r_success       LIKE type_t.chr1
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換至輸入畫面
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mmaq_m.mmaq001,g_mmaq_m.mmaq001_2,g_mmaq_m.pwd1,g_mmaq_m.pwd2,g_mmaq_m.pwd3
   
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
   CALL ammt405_02_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL ammt405_02_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   LET p_cmd = "u"
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_mmaq_m.mmaq001,g_mmaq_m.mmaq001_2,g_mmaq_m.pwd1,g_mmaq_m.pwd2,g_mmaq_m.pwd3 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaq001
            #add-point:BEFORE FIELD mmaq001 name="input.b.mmaq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaq001
            
            #add-point:AFTER FIELD mmaq001 name="input.a.mmaq001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF NOT cl_null(g_mmaq_m.mmaq001) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mmaq_m.mmaq001 != g_mmaq001_t )) THEN #160824-00007#123 by sakura mark
               IF g_mmaq_m.mmaq001 != g_mmaq_m_o.mmaq001 OR cl_null(g_mmaq_m_o.mmaq001) THEN #160824-00007#123 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmaq_t WHERE "||"mmaqent = '" ||g_enterprise|| "' AND "||"mmaq001 = '"||g_mmaq_m.mmaq001 ||"'",'std-00004',0) THEN 
                     LET g_mmaq_m.mmaq001 = g_mmaq_m_o.mmaq001  #160824-00007#123 by sakura add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mmaq_m_o.* = g_mmaq_m.*   #160824-00007#123 by sakura add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaq001
            #add-point:ON CHANGE mmaq001 name="input.g.mmaq001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaq001_2
            #add-point:BEFORE FIELD mmaq001_2 name="input.b.mmaq001_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaq001_2
            
            #add-point:AFTER FIELD mmaq001_2 name="input.a.mmaq001_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaq001_2
            #add-point:ON CHANGE mmaq001_2 name="input.g.mmaq001_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pwd1
            #add-point:BEFORE FIELD pwd1 name="input.b.pwd1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pwd1
            
            #add-point:AFTER FIELD pwd1 name="input.a.pwd1"
            IF NOT cl_null(g_mmaq_m.pwd1) THEN
               IF NOT ammt405_02_chk_passwd(g_mmaq_m.mmaq001,g_mmaq_m.mmaq001_2,g_mmaq_m.pwd1) THEN
                  LET g_mmaq_m.pwd1 = ''
                  NEXT FIELD pwd1
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pwd1
            #add-point:ON CHANGE pwd1 name="input.g.pwd1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pwd2
            #add-point:BEFORE FIELD pwd2 name="input.b.pwd2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pwd2
            
            #add-point:AFTER FIELD pwd2 name="input.a.pwd2"
            IF NOT cl_null(g_mmaq_m.pwd2) THEN
               IF LENGTH(g_mmaq_m.pwd2) > 10 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00462'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD pwd2
               END IF
               IF NOT cl_null(g_mmaq_m.pwd3) THEN
                  IF g_mmaq_m.pwd2 <> g_mmaq_m.pwd3 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00463'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_mmaq_m.pwd2 = ''
                     NEXT FIELD pwd2
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pwd2
            #add-point:ON CHANGE pwd2 name="input.g.pwd2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pwd3
            #add-point:BEFORE FIELD pwd3 name="input.b.pwd3"
            IF cl_null(g_mmaq_m.pwd2) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00464'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD pwd2
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pwd3
            
            #add-point:AFTER FIELD pwd3 name="input.a.pwd3"
            IF NOT cl_null(g_mmaq_m.pwd3) THEN
               IF LENGTH(g_mmaq_m.pwd3) > 10 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00462'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD pwd3
               END IF
               IF NOT cl_null(g_mmaq_m.pwd2) THEN
                  IF g_mmaq_m.pwd2 <> g_mmaq_m.pwd3 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00463'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_mmaq_m.pwd3 = ''
                     NEXT FIELD pwd3
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pwd3
            #add-point:ON CHANGE pwd3 name="input.g.pwd3"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mmaq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaq001
            #add-point:ON ACTION controlp INFIELD mmaq001 name="input.c.mmaq001"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaq001_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaq001_2
            #add-point:ON ACTION controlp INFIELD mmaq001_2 name="input.c.mmaq001_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.pwd1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pwd1
            #add-point:ON ACTION controlp INFIELD pwd1 name="input.c.pwd1"
            
            #END add-point
 
 
         #Ctrlp:input.c.pwd2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pwd2
            #add-point:ON ACTION controlp INFIELD pwd2 name="input.c.pwd2"
            
            #END add-point
 
 
         #Ctrlp:input.c.pwd3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pwd3
            #add-point:ON ACTION controlp INFIELD pwd3 name="input.c.pwd3"
            
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
               SELECT COUNT(1) INTO l_count FROM mmaq_t
                WHERE mmaqent = g_enterprise AND mmaq001 = g_mmaq_m.mmaq001
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO mmaq_t (mmaqent,mmaq001)
                  VALUES (g_enterprise,g_mmaq_m.mmaq001) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmaq_t:",SQLERRMESSAGE 
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
                  LET g_errparam.extend = g_mmaq_m.mmaq001
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               IF NOT cl_null(g_mmaq_m.mmaq001) AND NOT cl_null(g_mmaq_m.pwd3) THEN
                  CALL ammt405_02_upd(g_mmaq_m.mmaq001,g_mmaq_m.mmaq001_2,g_mmaq_m.pwd3) RETURNING r_success
                  IF r_success = 'N' THEN
                     CALL s_transaction_end('N','0')
                     EXIT DIALOG
                  END IF
                  CALL s_transaction_end('Y','0')
                  EXIT DIALOG
               END IF
               EXIT DIALOG
               #end add-point
               
               #將遮罩欄位還原
               CALL ammt405_02_mmaq_t_mask_restore('restore_mask_o')
               
               UPDATE mmaq_t SET (mmaq001) = (g_mmaq_m.mmaq001)
                WHERE mmaqent = g_enterprise AND mmaq001 = g_mmaq001_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmaq_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmaq_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL ammt405_02_mmaq_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_mmaq_m_t)
                     LET g_log2 = util.JSON.stringify(g_mmaq_m)
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
 
{<section id="ammt405_02.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION ammt405_02_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE mmaq_t.mmaq001 
   DEFINE l_oldno     LIKE mmaq_t.mmaq001 
 
   DEFINE l_master    RECORD LIKE mmaq_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_mmaq_m.mmaq001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_mmaq001_t = g_mmaq_m.mmaq001
 
   
   #清空key值
   LET g_mmaq_m.mmaq001 = ""
 
    
   CALL ammt405_02_set_entry("a")
   CALL ammt405_02_set_no_entry("a")
   
   #公用欄位給予預設值
   
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL ammt405_02_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_mmaq_m.* TO NULL
      CALL ammt405_02_show()
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
      LET g_errparam.extend = "mmaq_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單頭複製後 name="reproduce.head.a_insert"
   
   #end add-point
   
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL ammt405_02_set_act_visible()
   CALL ammt405_02_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_mmaq001_t = g_mmaq_m.mmaq001
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmaqent = " ||g_enterprise|| " AND",
                      " mmaq001 = '", g_mmaq_m.mmaq001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt405_02_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
              
   #功能已完成,通報訊息中心
   CALL ammt405_02_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="ammt405_02.show" >}
#+ 資料顯示 
PRIVATE FUNCTION ammt405_02_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值
   
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL ammt405_02_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mmaq_m.mmaq001,g_mmaq_m.mmaq001_2,g_mmaq_m.pwd1,g_mmaq_m.pwd2,g_mmaq_m.pwd3
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL ammt405_02_set_pk_array()
   
   #顯示狀態(stus)圖片
   
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ammt405_02.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION ammt405_02_delete()
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
   IF g_mmaq_m.mmaq001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_mmaq001_t = g_mmaq_m.mmaq001
 
   
   
 
   OPEN ammt405_02_cl USING g_enterprise,g_mmaq_m.mmaq001
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt405_02_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE ammt405_02_cl
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt405_02_master_referesh USING g_mmaq_m.mmaq001 INTO g_mmaq_m.mmaq001
   
   
   #檢查是否允許此動作
   IF NOT ammt405_02_action_chk() THEN
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmaq_m_mask_o.* =  g_mmaq_m.*
   CALL ammt405_02_mmaq_t_mask()
   LET g_mmaq_m_mask_n.* =  g_mmaq_m.*
   
   #將最新資料顯示到畫面上
   CALL ammt405_02_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL ammt405_02_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM mmaq_t 
       WHERE mmaqent = g_enterprise AND mmaq001 = g_mmaq_m.mmaq001 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmaq_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mmaq_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE ammt405_02_cl
         RETURN
      END IF
      
      CLEAR FORM
      CALL ammt405_02_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL ammt405_02_browser_fill(g_wc,"")
         CALL ammt405_02_fetch("P")
      ELSE
         CLEAR FORM
      END IF
   ELSE    
   END IF
 
   CLOSE ammt405_02_cl
 
   #功能已完成,通報訊息中心
   CALL ammt405_02_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ammt405_02.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION ammt405_02_ui_browser_refresh()
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
      IF g_browser[l_i].b_mmaq001 = g_mmaq_m.mmaq001
 
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
 
{<section id="ammt405_02.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION ammt405_02_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("mmaq001",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("pwd1",FALSE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt405_02.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION ammt405_02_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_n   LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mmaq001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   CALL cl_set_comp_entry("mmaq001",FALSE)
   SELECT COUNT(*) INTO l_n
     FROM mmaq_t
    WHERE mmaqent = g_enterprise
      AND mmaq001 BETWEEN g_mmaq_m.mmaq001 AND g_mmaq_m.mmaq001_2
      AND mmaq004 IS NOT NULL
   IF l_n > 0 THEN
      CALL cl_set_comp_entry("pwd1",TRUE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt405_02.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION ammt405_02_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ammt405_02.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION ammt405_02_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ammt405_02.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION ammt405_02_default_search()
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
      LET ls_wc = ls_wc, " mmaq001 = '", g_argv[01], "' AND "
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
 
{<section id="ammt405_02.mask_functions" >}
&include "erp/amm/ammt405_02_mask.4gl"
 
{</section>}
 
{<section id="ammt405_02.state_change" >}
   
 
{</section>}
 
{<section id="ammt405_02.signature" >}
   
 
{</section>}
 
{<section id="ammt405_02.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION ammt405_02_set_pk_array()
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
   LET g_pk_array[1].values = g_mmaq_m.mmaq001
   LET g_pk_array[1].column = 'mmaq001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt405_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="ammt405_02.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION ammt405_02_msgcentre_notify(lc_state)
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
   CALL ammt405_02_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mmaq_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt405_02.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION ammt405_02_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt405_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 更新卡密碼
# Memo...........:
# Usage..........: CALL ammt405_02_upd(p_bcard,p_ecard,p_passwd)
# Date & Author..: 20150611 By dongsz
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt405_02_upd(p_bcard,p_ecard,p_passwd)
DEFINE p_bcard      LIKE mmaq_t.mmaq001
DEFINE p_ecard      LIKE mmaq_t.mmaq001
DEFINE p_passwd     LIKE mmaq_t.mmaq004
DEFINE l_sql        STRING
DEFINE l_str        STRING
DEFINE l_mmaq001    LIKE mmaq_t.mmaq001
DEFINE l_newpw      LIKE mmaq_t.mmaq004
DEFINE r_success    LIKE type_t.chr1

   IF cl_null(p_ecard) THEN
      LET p_ecard = p_bcard
   END IF
   
   LET r_success = 'Y'
   LET l_sql = " SELECT mmaq001 FROM mmaq_t ",
               "  WHERE mmaqent = ",g_enterprise," ",
               "    AND (mmaq001 BETWEEN '",p_bcard,"' AND '",p_ecard,"') "
   PREPARE sel_mmaq001_pre FROM l_sql
   DECLARE sel_mmaq001_cs  CURSOR FOR sel_mmaq001_pre
   FOREACH sel_mmaq001_cs  INTO l_mmaq001
      LET l_str = l_mmaq001,p_passwd
      CALL ammt405_02_changepw(l_str) RETURNING l_newpw
      UPDATE mmaq_t SET mmaq004 = l_newpw
       WHERE mmaqent = g_enterprise
         AND mmaq001 = l_mmaq001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = 'N'
      END IF
   END FOREACH
   
   IF r_success = 'Y' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00465'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 卡密碼加密
# Memo...........:
# Usage..........: CALL ammt405_02_changepw(l_str)
# Date & Author..: 20150611 By dongsz
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt405_02_changepw(l_str)
DEFINE l_str       java.lang.String               #要加密的明文
DEFINE l_digest    java.security.MessageDigest    #加密演算法物件
DEFINE l_ength     INTEGER                        #加密後長度(應該為16 Byte)
DEFINE l_i         SMALLINT
DEFINE l_byte      java.lang.Byte                 #加密後每一個Byte值(有可能為負數)
DEFINE l_encrypt   STRING                         #以MD5來說加密後就是32位16進制的數值字串
DEFINE l_tmp       STRING
DEFINE l_int       INTEGER

   LET l_encrypt = ""
      
   IF l_str IS NULL THEN
      display "Encryption string is null."
      LET g_success = 'N'
      RETURN ''
   END IF
                             
   TRY    
      #指定加密演算法
      LET l_digest = java.security.MessageDigest.getInstance("MD5")
      #將字串轉換成byte,並傳送要演算的字串
            
      CALL l_digest.update(l_str.getBytes())
      
      #原則上MD5加密後長度應該會是16 bytes
      LET l_ength = l_digest.getDigestLength()       #因為在java裡無法做byte與java.lang.Byte的型態轉換
      #而且在4gl code中又無法引用java裡byte這個基本型態
      #因此只能利用for迴圈逐一抓出byte的值,順便做16進制的轉換
      FOR l_i = 1 TO l_ength
         #逐一取出每一個byte加密後的值
         LET l_byte = java.lang.Byte.valueOf(l_digest.digest()[l_i])
         #DISPLAY "digest[", l_i, "]: ", l_byte, ";"

         #java的toHexString參數是int,所以這裡還需做型態轉換
         #心得:利用4gl寫java要特別注意型態,一但型態錯誤就無法做api的呼叫
         LET l_int = l_byte.intValue()

         #因為每一個byte加密後的值有可能是負數,所以需做補數轉換
         #java code本是這樣做:(l_byte & 0XFF)就可以了
         #4gl code就直接將負數加256吧(因為1個byte是8 bit,所以要加上2的8次方=256)
         IF l_byte < 0 THEN
            LET l_int = l_byte.intValue() + 256
         ELSE
            LET l_int = l_byte.intValue()
         END IF

         #進行16進位轉碼,因為需固定取出二位字串故先在前面多加個"0"字串
         #等後面再做subString取出二個長度的字串
         LET l_tmp = java.lang.Integer.toHexString(l_int)
           LET l_tmp = "0", l_tmp
         #取出二位字串
         #範例1,有可能出來的是0:  "0", "0"  = "00"  ===> subString(1, 2)
         #範例2,有可能出來的是FF: "0", "FF" = "0FF" ===> subString(2, 3)
         LET l_tmp = l_tmp.subString(l_tmp.getLength() - 1, l_tmp.getLength())          #組合加密後之16進制的32位元數值字串
         LET l_encrypt = l_encrypt, l_tmp

         #重新傳送要演算的字串
         #要這樣做的原因就在於在for圈裡會再執行l_digest.digest()
         #呼叫digest()時會重新再一次用演算法進行加密
         #這樣下一個再取出的byte值就會和第一次計算的不一樣
         #所以這裡要再重新傳送要演算的字串
         CALL l_digest.update(l_str.getBytes())
      END FOR

      DISPLAY "Encrypt Finish."
   CATCH
      LET l_encrypt = ""
      DISPLAY "Error:", STATUS
      display "Generate MD5 key failed."
      LET g_success = 'N'
      RETURN ''
   END TRY

   RETURN l_encrypt
END FUNCTION

################################################################################
# Descriptions...: 檢查卡密碼
# Memo...........:
# Usage..........: CALL ammt405_02_chk_passwd(p_bcard,p_ecard,p_passwd)
# Date & Author..: 20150611 By dongsz
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt405_02_chk_passwd(p_bcard,p_ecard,p_passwd)
DEFINE p_bcard      LIKE mmaq_t.mmaq001
DEFINE p_ecard      LIKE mmaq_t.mmaq001
DEFINE p_passwd     LIKE mmaq_t.mmaq004
DEFINE l_str        STRING
DEFINE l_sql        STRING
DEFINE l_mmaq001    LIKE mmaq_t.mmaq001
DEFINE l_mmaq004    LIKE mmaq_t.mmaq004
DEFINE l_oldpw      LIKE mmaq_t.mmaq004

   IF cl_null(p_ecard) THEN
      LET p_ecard = p_bcard
   END IF
   
   LET l_sql = " SELECT mmaq001,mmaq004 FROM mmaq_t ",
               "  WHERE mmaqent = ",g_enterprise," ",
               "    AND (mmaq001 BETWEEN '",p_bcard,"' AND '",p_ecard,"') "
   PREPARE sel_mmaq_pre FROM l_sql
   DECLARE sel_mmaq_cs  CURSOR FOR sel_mmaq_pre
   FOREACH sel_mmaq_cs  INTO l_mmaq001,l_mmaq004
      LET l_str = l_mmaq001,p_passwd
      CALL ammt405_02_changepw(l_str) RETURNING l_oldpw
      IF l_oldpw <> l_mmaq004 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amm-00466'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END FOREACH
   
   RETURN TRUE
END FUNCTION

 
{</section>}
 
