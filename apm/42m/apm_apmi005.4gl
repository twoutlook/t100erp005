#該程式未解開Section, 採用最新樣板產出!
{<section id="apmi005.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2014-12-19 10:32:37), PR版次:0009(2016-12-13 15:05:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000261
#+ Filename...: apmi005
#+ Description: 交易對象聯絡人維護作業
#+ Creator....: 02294(2013-08-27 10:00:45)
#+ Modifier...: 02294 -SD/PR- 08532
 
{</section>}
 
{<section id="apmi005.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#49  2016/04/26 By 07673     將重複內容的錯誤訊息置換為公用錯誤訊息
#160905-00007#3   2016/09/05 By zhujing   调整系统中无ENT的SQL条件增加ent
#160912-00007#1   2016/09/20 By Charles4m apmi005 獨立執行時，不可自動查出資料
#161207-00072#1   2016/12/13 By liqma     删除资料时，oofb档和oofc档中的数据没有被删除
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL aoo_aooi350_01
IMPORT FGL aoo_aooi350_02
#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
#160318-00025#49 2016/04/26 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_pmaj_m        RECORD
       pmaj001 LIKE pmaj_t.pmaj001, 
   pmaal004 LIKE type_t.chr500, 
   pmaa002 LIKE pmaa_t.pmaa002
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pmaj_d        RECORD
       pmajstus LIKE pmaj_t.pmajstus, 
   pmaj002 LIKE pmaj_t.pmaj002, 
   pmaj003 LIKE pmaj_t.pmaj003, 
   pmaj003_desc LIKE type_t.chr500, 
   pmaj009 LIKE pmaj_t.pmaj009, 
   pmaj010 LIKE pmaj_t.pmaj010, 
   pmaj011 LIKE pmaj_t.pmaj011, 
   pmaj012 LIKE pmaj_t.pmaj012, 
   pmaj013 LIKE pmaj_t.pmaj013, 
   pmaj014 LIKE pmaj_t.pmaj014, 
   pmaj004 LIKE pmaj_t.pmaj004, 
   pmaj005 LIKE pmaj_t.pmaj005, 
   pmaj006 LIKE pmaj_t.pmaj006, 
   pmaj007 LIKE pmaj_t.pmaj007, 
   pmaj008 LIKE pmaj_t.pmaj008
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
GLOBALS
 TYPE type_g_oofb_d        RECORD
       oofbstus LIKE oofb_t.oofbstus, 
   oofb001 LIKE oofb_t.oofb001, 
   oofb019 LIKE oofb_t.oofb019, 
   oofb011 LIKE oofb_t.oofb011, 
   oofb008 LIKE oofb_t.oofb008, 
   oofb009 LIKE oofb_t.oofb009, 
   oofb009_desc LIKE type_t.chr500, 
   oofb010 LIKE oofb_t.oofb010, 
   oofb012 LIKE oofb_t.oofb012, 
   oofb012_desc LIKE type_t.chr500, 
   oofb013 LIKE oofb_t.oofb013, 
   oofb014 LIKE oofb_t.oofb014, 
   oofb014_desc LIKE type_t.chr500, 
   oofb015 LIKE oofb_t.oofb015, 
   oofb015_desc LIKE type_t.chr500, 
   oofb016 LIKE oofb_t.oofb016, 
   oofb016_desc LIKE type_t.chr500, 
   oofb017 LIKE oofb_t.oofb017, 
   oofb022 LIKE oofb_t.oofb022, 
   oofb022_desc LIKE type_t.chr500, 
   oofb020 LIKE oofb_t.oofb020, 
   oofb021 LIKE oofb_t.oofb021, 
   oofb018 LIKE oofb_t.oofb018
       END RECORD
DEFINE g_pmba_d          DYNAMIC ARRAY OF type_g_oofb_d

 TYPE type_g_oofc_d        RECORD
       oofcstus LIKE oofc_t.oofcstus, 
   oofc001 LIKE oofc_t.oofc001, 
   oofc008 LIKE oofc_t.oofc008, 
   oofc009 LIKE oofc_t.oofc009, 
   oofc009_desc LIKE type_t.chr500, 
   oofc012 LIKE oofc_t.oofc012, 
   oofc010 LIKE oofc_t.oofc010, 
   oofc014 LIKE oofc_t.oofc014, 
   oofc011 LIKE oofc_t.oofc011, 
   oofc015 LIKE oofc_t.oofc015,
   oofc013 LIKE oofc_t.oofc013
       END RECORD
DEFINE g_pmba2_d          DYNAMIC ARRAY OF type_g_oofc_d

   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
   DEFINE g_wc2_i35001      STRING             #聯絡地址QBE條件
   DEFINE g_wc2_i35002      STRING             #通訊方式QBE條件
   DEFINE g_d_idx_i35001    LIKE type_t.num5   #聯絡地址所在筆數
   DEFINE g_d_cnt_i35001    LIKE type_t.num5   #聯絡地址總筆數
   DEFINE g_d_idx_i35002    LIKE type_t.num5   #通訊方式所在筆數
   DEFINE g_d_cnt_i35002    LIKE type_t.num5   #通訊方式總筆數
   DEFINE g_pmaa027_d       LIKE pmaa_t.pmaa027
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
END GLOBALS
DEFINE g_detail_id          STRING             #紀錄停留在聯絡地址, 通訊方式或不在此兩個Page
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_pmaj_m          type_g_pmaj_m
DEFINE g_pmaj_m_t        type_g_pmaj_m
DEFINE g_pmaj_m_o        type_g_pmaj_m
DEFINE g_pmaj_m_mask_o   type_g_pmaj_m #轉換遮罩前資料
DEFINE g_pmaj_m_mask_n   type_g_pmaj_m #轉換遮罩後資料
 
   DEFINE g_pmaj001_t LIKE pmaj_t.pmaj001
 
 
DEFINE g_pmaj_d          DYNAMIC ARRAY OF type_g_pmaj_d
DEFINE g_pmaj_d_t        type_g_pmaj_d
DEFINE g_pmaj_d_o        type_g_pmaj_d
DEFINE g_pmaj_d_mask_o   DYNAMIC ARRAY OF type_g_pmaj_d #轉換遮罩前資料
DEFINE g_pmaj_d_mask_n   DYNAMIC ARRAY OF type_g_pmaj_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_pmaj001 LIKE pmaj_t.pmaj001
       #,rank           LIKE type_t.num10
      END RECORD 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING 
 
 
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入(僅用於三階)
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmi005.main" >}
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
   IF cl_null(g_argv[1]) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00042'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE WINDOW w_apmi005
      CALL cl_ap_exitprogram("0")
   ELSE
      IF g_argv[1] NOT MATCHES '[123]' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00043'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CLOSE WINDOW w_apmi005
         CALL cl_ap_exitprogram("0") 
      END IF
   END IF
   
   #IF NOT cl_null(g_argv[1]) THEN
   #   LET g_pmaj_m.pmaa002 = g_argv[1]
   #END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_pmaj_m.pmaj001 = g_argv[02]
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pmaj001,'',''", 
                      " FROM pmaj_t",
                      " WHERE pmajent= ? AND pmaj001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmi005_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmaj001",
               " FROM pmaj_t t0",
               
               " WHERE t0.pmajent = " ||g_enterprise|| " AND t0.pmaj001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmi005_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmi005 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmi005_init()   
 
      #進入選單 Menu (="N")
      CALL apmi005_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmi005
      
   END IF 
   
   CLOSE apmi005_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmi005.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmi005_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
DEFINE l_n  LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('pmaa002','2014') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   IF NOT cl_null(g_argv[02]) THEN
      #有傳入參數，根據傳入的參數判斷是否存在，若不存在資料，直接進入新增狀態
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM pmaj_t WHERE pmajent = g_enterprise AND pmaj001 = g_pmaj_m.pmaj001
      IF l_n = 0 THEN
         CALL apmi005_insert()
      END IF
   END IF
   
   #子程式畫面取代主程式元件
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_01"), "grid_contact", "Table", "s_detail1_aooi350_01")
   CALL cl_set_combo_scc('oofb008','9')   #地址類型
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_02"), "grid_communication", "Table", "s_detail1_aooi350_02")
   CALL cl_set_combo_scc('oofc008','6')   #通訊類型
   #end add-point
   
   CALL apmi005_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apmi005.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apmi005_ui_dialog()
   #add-point:ui_dialog段define name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE la_param  RECORD
          prog                  STRING,
          actionid              STRING,
          background            LIKE type_t.chr1,
          param                 DYNAMIC ARRAY OF STRING
                                END RECORD
   DEFINE ls_js                 STRING
   DEFINE li_idx                LIKE type_t.num10
   DEFINE ls_wc                 STRING
   DEFINE lb_first              BOOLEAN
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL apmi005_set_title_visible()
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_pmaj_m.* TO NULL
         CALL g_pmaj_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmi005_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_pmaj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL apmi005_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apmi005_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               CALL aooi350_01_clear_detail()   #清除聯絡地址
               CALL aooi350_02_clear_detail()   #清除通訊方式
               #取得通訊地址, 聯絡方式單身資料
               IF cl_null(l_ac) OR l_ac < = 0 THEN
                  LET l_ac = 1
               END IF
               CALL aooi350_01_b_fill(g_pmaj_d[l_ac].pmaj002)
               CALL aooi350_02_b_fill(g_pmaj_d[l_ac].pmaj002)
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
    
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            CALL aooi350_01_clear_detail()   #清除聯絡地址
            CALL aooi350_02_clear_detail()   #清除通訊方式
            #取得通訊地址, 聯絡方式單身資料
            IF cl_null(l_ac) OR l_ac < = 0 THEN
               LET l_ac = 1
            END IF
            CALL aooi350_01_b_fill(g_pmaj_d[l_ac].pmaj002)
            CALL aooi350_02_b_fill(g_pmaj_d[l_ac].pmaj002)
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #通訊地址單身顯示
         SUBDIALOG aoo_aooi350_01.aooi350_01_display
         #聯絡方式單身顯示
         SUBDIALOG aoo_aooi350_02.aooi350_02_display
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL apmi005_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LET g_current_idx = g_browser.getLength()
            END IF 
            
            IF g_current_idx = 0 AND g_browser.getLength() > 0 THEN
               LET g_current_idx = 1 
            END IF
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL apmi005_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apmi005_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
         ON ACTION cont_page
            LET g_detail_id = "cont_page"
            NEXT FIELD oofbstus
         ON ACTION comm_page
            LET g_detail_id = "comm_page"
            NEXT FIELD oofcstus
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apmi005_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmi005_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apmi005_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmi005_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apmi005_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmi005_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apmi005_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmi005_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apmi005_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmi005_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_pmaj_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[2] = base.typeInfo.create(g_pmba_d)
                  LET g_export_id[2]   = "s_detail1_aooi350_01"
                  LET g_export_node[3] = base.typeInfo.create(g_pmba2_d)
                  LET g_export_id[3]   = "s_detail1_aooi350_02"                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
          
         ON ACTION close
            LET INT_FLAG=FALSE        
            LET g_action_choice = "exit"
            EXIT DIALOG     
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
          
            
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
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD pmaj002
            END IF
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
            
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL apmi005_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL apmi005_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL apmi005_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apmi005_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apmi005_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmi005_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmi005_insert()
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
               CALL apmi005_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmi005_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aooi350_01
            LET g_action_choice="aooi350_01"
            IF cl_auth_chk_act("aooi350_01") THEN
               
               #add-point:ON ACTION aooi350_01 name="menu.aooi350_01"
               IF l_ac > 0 THEN
                  IF NOT cl_null(g_pmaj_d[l_ac].pmaj002) THEN
                     CALL aooi350_01(g_pmaj_d[l_ac].pmaj002)
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aooi350_02
            LET g_action_choice="aooi350_02"
            IF cl_auth_chk_act("aooi350_02") THEN
               
               #add-point:ON ACTION aooi350_02 name="menu.aooi350_02"
               IF l_ac > 0 THEN
                  IF NOT cl_null(g_pmaj_d[l_ac].pmaj002) THEN
                     CALL aooi350_02(g_pmaj_d[l_ac].pmaj002)
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmi005_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmi005_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmi005_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl" 
         CONTINUE DIALOG
            
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION apmi005_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apmi005.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apmi005_browser_fill(ps_page_action)
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point   
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   IF NOT cl_null(g_argv[1]) THEN
      CASE g_argv[1] 
         WHEN '1' LET g_wc = g_wc," AND pmaj001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise," AND (pmaa002 = '1' OR pmaa002 = '3') ) "
         WHEN '2' LET g_wc = g_wc," AND pmaj001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise," AND (pmaa002 = '2' OR pmaa002 = '3') ) "
         WHEN '3' LET g_wc = g_wc," AND pmaj001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise," AND (pmaa002 = '1' OR pmaa002 = '2' OR pmaa002 = '3') ) "
      END CASE
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc," AND pmaj001 = '",g_argv[02], "' "
   END IF
   
   IF cl_null(g_add_browse) THEN
      CALL aooi350_01_clear_detail()   #清除聯絡地址
      CALL aooi350_02_clear_detail()   #清除通訊方式
   END IF
   #end add-point    
 
   LET l_searchcol = "pmaj001"
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      LET l_wc = " 1=1"
   END IF
   IF cl_null(l_wc2) THEN  #p_wc 查詢條件
      LET l_wc2 = " 1=1"
   END IF
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT pmaj001 ",
 
                      " FROM pmaj_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE pmajent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pmaj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pmaj001 ",
 
                      " FROM pmaj_t ",
                      " ",
                      " ", 
 
 
                      " WHERE pmajent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pmaj_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   #IF l_wc2 <> " 1=1" OR NOT cl_null(l_wc2) THEN
   #   #單身有輸入搜尋條件                      
   #   LET l_sub_sql = " SELECT UNIQUE pmaj001 ",
   #
   #                   " FROM pmaj_t ",
   #                   " LEFT JOIN pmaal_t ON pmaalent = pmajent AND pmaal001 = pmaj001 AND pmaal002 = '",g_dlang,"' ",
   #                   " LEFT JOIN pmaa_t ON pmaaent = pmajent AND pmaa001 = pmaj001 ",
   #
   #                   " WHERE pmajent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pmaj_t")
   #ELSE
   #   #單身未輸入搜尋條件
   #   LET l_sub_sql = " SELECT UNIQUE pmaj001 ",
   #
   #                   " FROM pmaj_t ",
   #                   " LEFT JOIN pmaal_t ON pmaalent = pmajent AND pmaal001 = pmaj001 AND pmaal002 = '",g_dlang,"' ",
   #                   " LEFT JOIN pmaa_t ON pmaaent = pmajent AND pmaa001 = pmaj001 ",
   #                   " WHERE pmajent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("pmaj_t")
   #END IF 
   #
   #LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
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
      LET g_browser_cnt = g_max_browse
   END IF
   LET g_error_show = 0
 
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_pmaj_m.* TO NULL
      CALL g_pmaj_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pmaj001 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.pmaj001",
                " FROM pmaj_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.pmajent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("pmaj_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   #LET g_sql  = "SELECT DISTINCT t0.pmaj001",
   #             " FROM pmaj_t t0",
   #             " LEFT JOIN pmaal_t ON pmaalent = t0.pmajent AND pmaal001 = t0.pmaj001 AND pmaal002 = '",g_dlang,"' ",
   #             " LEFT JOIN pmaa_t ON pmaaent = t0.pmajent AND pmaa001 = t0.pmaj001 ",
   #             
   #             " WHERE t0.pmajent = '" ||g_enterprise|| "' AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("pmaj_t")
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmaj_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_pmaj001 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point  
      
         
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
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
   
   IF cl_null(g_browser[g_cnt].b_pmaj001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_pmaj_m.* TO NULL
      CALL g_pmaj_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL apmi005_fetch('')
   
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apmi005_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pmaj_m.pmaj001 = g_browser[g_current_idx].b_pmaj001   
 
   EXECUTE apmi005_master_referesh USING g_pmaj_m.pmaj001 INTO g_pmaj_m.pmaj001
   CALL apmi005_show()
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apmi005_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmi005_ui_browser_refresh()
   #add-point:ui_browser_refresh段define name="ui_browser_refresh.define_customerization"
   
   #end add-point   
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_pmaj001 = g_pmaj_m.pmaj001 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmi005_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_pmaj_m.* TO NULL
   CALL g_pmaj_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   CALL aooi350_01_clear_detail()   #清除聯絡地址
   CALL aooi350_02_clear_detail()   #清除通訊方式
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON pmaj001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.pmaj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj001
            #add-point:ON ACTION controlp INFIELD pmaj001 name="construct.c.pmaj001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CASE g_argv[1]
               WHEN '1' LET g_qryparam.where= " (pmaa002 = '1' OR pmaa002 = '3') "
               WHEN '2' LET g_qryparam.where= " (pmaa002 = '2' OR pmaa002 = '3') "
               WHEN '3' LET g_qryparam.where= " (pmaa002 = '1' OR pmaa002 = '2' OR pmaa002 = '3') "
            END CASE
            CALL q_pmaa001_4()                           #呼叫開窗
            LET g_qryparam.where= " "
            DISPLAY g_qryparam.return1 TO pmaj001  #顯示到畫面上

            NEXT FIELD pmaj001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj001
            #add-point:BEFORE FIELD pmaj001 name="construct.b.pmaj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj001
            
            #add-point:AFTER FIELD pmaj001 name="construct.a.pmaj001"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON pmajstus,pmaj002,pmaj003,pmaj009,pmaj010,pmaj011,pmaj012,pmaj013,pmaj014, 
          pmaj004,pmaj005,pmaj006,pmaj007,pmaj008
           FROM s_detail1[1].pmajstus,s_detail1[1].pmaj002,s_detail1[1].pmaj003,s_detail1[1].pmaj009, 
               s_detail1[1].pmaj010,s_detail1[1].pmaj011,s_detail1[1].pmaj012,s_detail1[1].pmaj013,s_detail1[1].pmaj014, 
               s_detail1[1].pmaj004,s_detail1[1].pmaj005,s_detail1[1].pmaj006,s_detail1[1].pmaj007,s_detail1[1].pmaj008 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pmajcrtdt>>----
 
         #----<<pmajmoddt>>----
         
         #----<<pmajcnfdt>>----
         
         #----<<pmajpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmajstus
            #add-point:BEFORE FIELD pmajstus name="construct.b.page1.pmajstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmajstus
            
            #add-point:AFTER FIELD pmajstus name="construct.a.page1.pmajstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmajstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmajstus
            #add-point:ON ACTION controlp INFIELD pmajstus name="construct.c.page1.pmajstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj002
            #add-point:BEFORE FIELD pmaj002 name="construct.b.page1.pmaj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj002
            
            #add-point:AFTER FIELD pmaj002 name="construct.a.page1.pmaj002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmaj002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj002
            #add-point:ON ACTION controlp INFIELD pmaj002 name="construct.c.page1.pmaj002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmaj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj003
            #add-point:ON ACTION controlp INFIELD pmaj003 name="construct.c.page1.pmaj003"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where= " oocqstus = 'Y' "
            LET g_qryparam.arg1 = "259"
            CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.where= " "
            DISPLAY g_qryparam.return1 TO pmaj003  #顯示到畫面上

            NEXT FIELD pmaj003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj003
            #add-point:BEFORE FIELD pmaj003 name="construct.b.page1.pmaj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj003
            
            #add-point:AFTER FIELD pmaj003 name="construct.a.page1.pmaj003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj009
            #add-point:BEFORE FIELD pmaj009 name="construct.b.page1.pmaj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj009
            
            #add-point:AFTER FIELD pmaj009 name="construct.a.page1.pmaj009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmaj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj009
            #add-point:ON ACTION controlp INFIELD pmaj009 name="construct.c.page1.pmaj009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj010
            #add-point:BEFORE FIELD pmaj010 name="construct.b.page1.pmaj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj010
            
            #add-point:AFTER FIELD pmaj010 name="construct.a.page1.pmaj010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmaj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj010
            #add-point:ON ACTION controlp INFIELD pmaj010 name="construct.c.page1.pmaj010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj011
            #add-point:BEFORE FIELD pmaj011 name="construct.b.page1.pmaj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj011
            
            #add-point:AFTER FIELD pmaj011 name="construct.a.page1.pmaj011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmaj011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj011
            #add-point:ON ACTION controlp INFIELD pmaj011 name="construct.c.page1.pmaj011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj012
            #add-point:BEFORE FIELD pmaj012 name="construct.b.page1.pmaj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj012
            
            #add-point:AFTER FIELD pmaj012 name="construct.a.page1.pmaj012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmaj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj012
            #add-point:ON ACTION controlp INFIELD pmaj012 name="construct.c.page1.pmaj012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj013
            #add-point:BEFORE FIELD pmaj013 name="construct.b.page1.pmaj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj013
            
            #add-point:AFTER FIELD pmaj013 name="construct.a.page1.pmaj013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmaj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj013
            #add-point:ON ACTION controlp INFIELD pmaj013 name="construct.c.page1.pmaj013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj014
            #add-point:BEFORE FIELD pmaj014 name="construct.b.page1.pmaj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj014
            
            #add-point:AFTER FIELD pmaj014 name="construct.a.page1.pmaj014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmaj014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj014
            #add-point:ON ACTION controlp INFIELD pmaj014 name="construct.c.page1.pmaj014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj004
            #add-point:BEFORE FIELD pmaj004 name="construct.b.page1.pmaj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj004
            
            #add-point:AFTER FIELD pmaj004 name="construct.a.page1.pmaj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmaj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj004
            #add-point:ON ACTION controlp INFIELD pmaj004 name="construct.c.page1.pmaj004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj005
            #add-point:BEFORE FIELD pmaj005 name="construct.b.page1.pmaj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj005
            
            #add-point:AFTER FIELD pmaj005 name="construct.a.page1.pmaj005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmaj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj005
            #add-point:ON ACTION controlp INFIELD pmaj005 name="construct.c.page1.pmaj005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj006
            #add-point:BEFORE FIELD pmaj006 name="construct.b.page1.pmaj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj006
            
            #add-point:AFTER FIELD pmaj006 name="construct.a.page1.pmaj006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmaj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj006
            #add-point:ON ACTION controlp INFIELD pmaj006 name="construct.c.page1.pmaj006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj007
            #add-point:BEFORE FIELD pmaj007 name="construct.b.page1.pmaj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj007
            
            #add-point:AFTER FIELD pmaj007 name="construct.a.page1.pmaj007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmaj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj007
            #add-point:ON ACTION controlp INFIELD pmaj007 name="construct.c.page1.pmaj007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj008
            #add-point:BEFORE FIELD pmaj008 name="construct.b.page1.pmaj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj008
            
            #add-point:AFTER FIELD pmaj008 name="construct.a.page1.pmaj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmaj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj008
            #add-point:ON ACTION controlp INFIELD pmaj008 name="construct.c.page1.pmaj008"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      #通訊地址查詢
      SUBDIALOG aoo_aooi350_01.aooi350_01_construct
      
      SUBDIALOG aoo_aooi350_02.aooi350_02_construct
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         
         #end add-point
      
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   LET g_current_row = 1
 
   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""
 
END FUNCTION
 
{</section>}
 
{<section id="apmi005.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmi005_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   CALL aooi350_01_clear_detail()   #清除聯絡地址
   CALL aooi350_02_clear_detail()   #清除通訊方式
   #end add-point 
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
   
   LET ls_wc = g_wc
 
   LET INT_FLAG = 0    
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_pmaj_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL apmi005_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmi005_browser_fill(g_wc)
      CALL apmi005_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL apmi005_browser_fill("F")
   
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
      CALL apmi005_fetch("F") 
   END IF
   
   CALL apmi005_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmi005_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
   
   #end add-point    
 
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L' 
         LET g_current_idx = g_header_cnt
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,': ' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF
            
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
            LET g_current_idx = g_jump
         END IF
 
         LET g_no_ask = FALSE  
   END CASE    
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   #CALL apmi005_browser_fill(p_flag)
   
   LET g_detail_cnt = g_header_cnt                  
   
   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart + g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting(g_current_idx,g_detail_cnt)
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_pmaj_m.pmaj001 = g_browser[g_current_idx].b_pmaj001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apmi005_master_referesh USING g_pmaj_m.pmaj001 INTO g_pmaj_m.pmaj001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "pmaj_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_pmaj_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_pmaj_m_mask_o.* =  g_pmaj_m.*
   CALL apmi005_pmaj_t_mask()
   LET g_pmaj_m_mask_n.* =  g_pmaj_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apmi005_set_act_visible()
   CALL apmi005_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_pmaj_m_t.* = g_pmaj_m.*
   LET g_pmaj_m_o.* = g_pmaj_m.*
   
   #重新顯示   
   CALL apmi005_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="apmi005.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmi005_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   #INITIALIZE g_pmaa027_d TO NULL
   CALL aooi350_01_clear_detail()   #清除聯絡地址
   CALL aooi350_02_clear_detail()   #清除通訊方式
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_pmaj_d.clear()
 
 
   INITIALIZE g_pmaj_m.* TO NULL             #DEFAULT 設定
   LET g_pmaj001_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      INITIALIZE g_pmaj_m_t.* TO NULL
      IF NOT cl_null(g_argv[02]) THEN
         LET g_pmaj_m.pmaj001 = g_argv[02]
         CALL apmi005_pmaj001_ref(g_pmaj_m.pmaj001) RETURNING g_pmaj_m.pmaa002,g_pmaj_m.pmaal004
         DISPLAY BY NAME g_pmaj_m.pmaa002,g_pmaj_m.pmaal004
      END IF
      
      #LET g_pmaj_m.pmaa002 = g_argv[1]
      LET g_pmaj_m_t.* = g_pmaj_m.*
      #end add-point 
 
      CALL apmi005_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_pmaj_m.* TO NULL
         INITIALIZE g_pmaj_d TO NULL
 
         CALL apmi005_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pmaj_m.* = g_pmaj_m_t.*
         CALL apmi005_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_pmaj_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apmi005_set_act_visible()
   CALL apmi005_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pmaj001_t = g_pmaj_m.pmaj001
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmajent = " ||g_enterprise|| " AND",
                      " pmaj001 = '", g_pmaj_m.pmaj001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmi005_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL apmi005_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmi005_master_referesh USING g_pmaj_m.pmaj001 INTO g_pmaj_m.pmaj001
   
   #遮罩相關處理
   LET g_pmaj_m_mask_o.* =  g_pmaj_m.*
   CALL apmi005_pmaj_t_mask()
   LET g_pmaj_m_mask_n.* =  g_pmaj_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmaj_m.pmaj001,g_pmaj_m.pmaal004,g_pmaj_m.pmaa002
   
   #功能已完成,通報訊息中心
   CALL apmi005_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmi005_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_pmaj_m.pmaj001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_pmaj001_t = g_pmaj_m.pmaj001
 
   CALL s_transaction_begin()
   
   OPEN apmi005_cl USING g_enterprise,g_pmaj_m.pmaj001
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmi005_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE apmi005_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmi005_master_referesh USING g_pmaj_m.pmaj001 INTO g_pmaj_m.pmaj001
   
   #遮罩相關處理
   LET g_pmaj_m_mask_o.* =  g_pmaj_m.*
   CALL apmi005_pmaj_t_mask()
   LET g_pmaj_m_mask_n.* =  g_pmaj_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL apmi005_show()
   WHILE TRUE
      LET g_pmaj001_t = g_pmaj_m.pmaj001
 
 
      #add-point:modify段修改前 name="modify.before_input"
      #LET g_pmaj_m.pmaa002 = g_argv[1]
      #LET g_pmaj_m_t.pmaa002 = g_pmaj_m.pmaa002
      #end add-point
      
      CALL apmi005_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pmaj_m.* = g_pmaj_m_t.*
         CALL apmi005_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_pmaj_m.pmaj001 != g_pmaj001_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前 name="modify.b_key_update"
         
         #end add-point
         
         #add-point:單頭(偽)修改中 name="modify.m_key_update"
         
         #end add-point
         
 
         
         #add-point:單頭(偽)修改後 name="modify.a_key_update"
         
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apmi005_set_act_visible()
   CALL apmi005_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmajent = " ||g_enterprise|| " AND",
                      " pmaj001 = '", g_pmaj_m.pmaj001, "' "
 
   #填到對應位置
   CALL apmi005_browser_fill("")
 
   CALL apmi005_idx_chk()
 
   CLOSE apmi005_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmi005_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="apmi005.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmi005_input(p_cmd)
   #add-point:input段define name="input.define_customerization"
   
   #end add-point   
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_oofa001       LIKE oofa_t.oofa001
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmaj_m.pmaj001,g_pmaj_m.pmaal004,g_pmaj_m.pmaa002
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF  
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT pmajstus,pmaj002,pmaj003,pmaj009,pmaj010,pmaj011,pmaj012,pmaj013,pmaj014, 
       pmaj004,pmaj005,pmaj006,pmaj007,pmaj008 FROM pmaj_t WHERE pmajent=? AND pmaj001=? AND pmaj002=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmi005_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apmi005_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   #將單身輸入權限放入共用變數給嵌入的子程式用, 若子程式要自己控管, 還是可以從子程式中覆蓋掉值
   LET g_detail_insert = l_allow_insert
   LET g_detail_delete = l_allow_delete
   #end add-point
   CALL apmi005_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_pmaj_m.pmaj001,g_pmaj_m.pmaal004,g_pmaj_m.pmaa002
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apmi005.input.head" >}
   
      #單頭段
      INPUT BY NAME g_pmaj_m.pmaj001,g_pmaj_m.pmaal004,g_pmaj_m.pmaa002 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj001
            #add-point:BEFORE FIELD pmaj001 name="input.b.pmaj001"
            IF NOT cl_null(g_argv[02]) THEN
               CALL cl_set_comp_entry("pmaj001",FALSE)
               NEXT FIELD pmaj003
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj001
            
            #add-point:AFTER FIELD pmaj001 name="input.a.pmaj001"
            #此段落由子樣板a05產生
            IF cl_null(g_argv[02]) THEN
               LET g_pmaj_m.pmaal004 = ' '
               LET g_pmaj_m.pmaa002 =  ' '
               DISPLAY BY NAME g_pmaj_m.pmaa002,g_pmaj_m.pmaal004
               
               IF  NOT cl_null(g_pmaj_m.pmaj001) THEN 
                  IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_pmaj_m.pmaj001 != g_pmaj001_t ))) THEN 
                     IF NOT apmi005_pmaj001_chk(g_pmaj_m.pmaj001) THEN
                        LET g_pmaj_m.pmaj001 = g_pmaj_m_t.pmaj001
                        CALL apmi005_pmaj001_ref(g_pmaj_m.pmaj001) RETURNING g_pmaj_m.pmaa002,g_pmaj_m.pmaal004
                        DISPLAY BY NAME g_pmaj_m.pmaa002,g_pmaj_m.pmaal004
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL apmi005_pmaj001_ref(g_pmaj_m.pmaj001) RETURNING g_pmaj_m.pmaa002,g_pmaj_m.pmaal004
            DISPLAY BY NAME g_pmaj_m.pmaa002,g_pmaj_m.pmaal004


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaj001
            #add-point:ON CHANGE pmaj001 name="input.g.pmaj001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal004
            #add-point:BEFORE FIELD pmaal004 name="input.b.pmaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal004
            
            #add-point:AFTER FIELD pmaal004 name="input.a.pmaal004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaal004
            #add-point:ON CHANGE pmaal004 name="input.g.pmaal004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa002
            #add-point:BEFORE FIELD pmaa002 name="input.b.pmaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa002
            
            #add-point:AFTER FIELD pmaa002 name="input.a.pmaa002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa002
            #add-point:ON CHANGE pmaa002 name="input.g.pmaa002"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmaj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj001
            #add-point:ON ACTION controlp INFIELD pmaj001 name="input.c.pmaj001"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmaj_m.pmaj001             #給予default值

            CASE g_argv[1]
               WHEN '1' LET g_qryparam.where= " (pmaa002 = '1' OR pmaa002 = '3') "
               WHEN '2' LET g_qryparam.where= " (pmaa002 = '2' OR pmaa002 = '3') "
               WHEN '3' LET g_qryparam.where= " (pmaa002 = '1' OR pmaa002 = '2' OR pmaa002 = '3') "
            END CASE
            CALL q_pmaa001_4()                                #呼叫開窗
        
            LET g_qryparam.where= " "
            LET g_pmaj_m.pmaj001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaj_m.pmaj001 TO pmaj001              #顯示到畫面上
            CALL apmi005_pmaj001_ref(g_pmaj_m.pmaj001) RETURNING g_pmaj_m.pmaa002,g_pmaj_m.pmaal004
            DISPLAY BY NAME g_pmaj_m.pmaa002,g_pmaj_m.pmaal004

            NEXT FIELD pmaj001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal004
            #add-point:ON ACTION controlp INFIELD pmaal004 name="input.c.pmaal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa002
            #add-point:ON ACTION controlp INFIELD pmaa002 name="input.c.pmaa002"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            DISPLAY BY NAME g_pmaj_m.pmaj001             
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL apmi005_pmaj_t_mask_restore('restore_mask_o')
            
               UPDATE pmaj_t SET (pmaj001) = (g_pmaj_m.pmaj001)
                WHERE pmajent = g_enterprise AND pmaj001 = g_pmaj001_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmaj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmaj_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmaj_m.pmaj001
               LET gs_keys_bak[1] = g_pmaj001_t
               LET gs_keys[2] = g_pmaj_d[g_detail_idx].pmaj002
               LET gs_keys_bak[2] = g_pmaj_d_t.pmaj002
               CALL apmi005_update_b('pmaj_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_pmaj_m_t)
                     #LET g_log2 = util.JSON.stringify(g_pmaj_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL apmi005_pmaj_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apmi005_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_pmaj001_t = g_pmaj_m.pmaj001
 
           
           IF g_pmaj_d.getLength() = 0 THEN
              NEXT FIELD pmaj002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="apmi005.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_pmaj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmaj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmi005_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmi005_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN apmi005_cl USING g_enterprise,g_pmaj_m.pmaj001                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE apmi005_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN apmi005_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_pmaj_d[l_ac].pmaj002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pmaj_d_t.* = g_pmaj_d[l_ac].*  #BACKUP
               LET g_pmaj_d_o.* = g_pmaj_d[l_ac].*  #BACKUP
               CALL apmi005_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL apmi005_set_no_entry_b(l_cmd)
               OPEN apmi005_bcl USING g_enterprise,g_pmaj_m.pmaj001,
 
                                                g_pmaj_d_t.pmaj002
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN apmi005_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmi005_bcl INTO g_pmaj_d[l_ac].pmajstus,g_pmaj_d[l_ac].pmaj002,g_pmaj_d[l_ac].pmaj003, 
                      g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011,g_pmaj_d[l_ac].pmaj012, 
                      g_pmaj_d[l_ac].pmaj013,g_pmaj_d[l_ac].pmaj014,g_pmaj_d[l_ac].pmaj004,g_pmaj_d[l_ac].pmaj005, 
                      g_pmaj_d[l_ac].pmaj006,g_pmaj_d[l_ac].pmaj007,g_pmaj_d[l_ac].pmaj008
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_pmaj_d_t.pmaj002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pmaj_d_mask_o[l_ac].* =  g_pmaj_d[l_ac].*
                  CALL apmi005_pmaj_t_mask()
                  LET g_pmaj_d_mask_n[l_ac].* =  g_pmaj_d[l_ac].*
                  
                  CALL apmi005_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            #--mark by shiunyo 14/09/10--(S)
            IF l_cmd = 'u' THEN
               #CALL apmi005_pmaj002_ref(g_pmaj_d[l_ac].pmaj002) RETURNING g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011,g_pmaj_d[l_ac].pmaj012,g_pmaj_d[l_ac].pmaj013,g_pmaj_d[l_ac].pmaj014
               LET g_pmaa027_d = g_pmaj_d[l_ac].pmaj002
               CALL aooi350_01_b_fill(g_pmaj_d[l_ac].pmaj002)
               CALL aooi350_02_b_fill(g_pmaj_d[l_ac].pmaj002)
            END IF
            #--mark by shiunyo 14/09/10--(E)
            #end add-point  
            
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_pmaj_d_t.* TO NULL
            INITIALIZE g_pmaj_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmaj_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmaj_d[l_ac].pmajstus = ''
 
 
  
            #一般欄位預設值
                  LET g_pmaj_d[l_ac].pmajstus = "Y"
      LET g_pmaj_d[l_ac].pmaj004 = "N"
      LET g_pmaj_d[l_ac].pmaj005 = "N"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_pmaj_d_t.* = g_pmaj_d[l_ac].*     #新輸入資料
            LET g_pmaj_d_o.* = g_pmaj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmi005_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL apmi005_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmaj_d[li_reproduce_target].* = g_pmaj_d[li_reproduce].*
 
               LET g_pmaj_d[g_pmaj_d.getLength()].pmaj002 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_pmaj_d[l_ac].pmaj002 = " "
            LET g_pmaj_d_t.* = g_pmaj_d[l_ac].* 
            
            INITIALIZE g_pmaa027_d TO NULL
            CALL aooi350_01_clear_detail()   #清除聯絡地址
            CALL aooi350_02_clear_detail()   #清除通訊方式
            #end add-point  
 
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM pmaj_t 
             WHERE pmajent = g_enterprise AND pmaj001 = g_pmaj_m.pmaj001
 
               AND pmaj002 = g_pmaj_d[l_ac].pmaj002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO pmaj_t
                           (pmajent,
                            pmaj001,
                            pmaj002
                            ,pmajstus,pmaj003,pmaj009,pmaj010,pmaj011,pmaj012,pmaj013,pmaj014,pmaj004,pmaj005,pmaj006,pmaj007,pmaj008) 
                     VALUES(g_enterprise,
                            g_pmaj_m.pmaj001,
                            g_pmaj_d[l_ac].pmaj002
                            ,g_pmaj_d[l_ac].pmajstus,g_pmaj_d[l_ac].pmaj003,g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010, 
                                g_pmaj_d[l_ac].pmaj011,g_pmaj_d[l_ac].pmaj012,g_pmaj_d[l_ac].pmaj013, 
                                g_pmaj_d[l_ac].pmaj014,g_pmaj_d[l_ac].pmaj004,g_pmaj_d[l_ac].pmaj005, 
                                g_pmaj_d[l_ac].pmaj006,g_pmaj_d[l_ac].pmaj007,g_pmaj_d[l_ac].pmaj008) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_pmaj_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmaj_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert"
               LET l_success = ''
               LET l_oofa001 = ''
               CALL s_aooi350_ins_oofa('4',g_pmaj_m.pmaj001,g_pmaj_m.pmaa002) RETURNING l_success,l_oofa001
               IF l_success THEN
                  #UPDATE pmaj_t SET (pmaj009,pmaj010,pmaj011,pmaj012,pmaj013,pmaj014) = (g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011,g_pmaj_d[l_ac].pmaj012,g_pmaj_d[l_ac].pmaj013,g_pmaj_d[l_ac].pmaj014)
                  # WHERE pmajent = g_enterprise AND pmaj001 = g_pmaj_m.pmaj001 AND pmaj002 = l_oofa001
                  #IF SQLCA.sqlcode THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = SQLCA.sqlcode
                  #   LET g_errparam.extend = "pmaj_t"
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #
                  #   CALL s_transaction_end('N','0')
                  #   CANCEL INSERT
                  #ELSE
                     
                     UPDATE pmaj_t SET pmaj002 = l_oofa001 WHERE pmajent = g_enterprise AND pmaj001 = g_pmaj_m.pmaj001 AND pmaj002 = g_pmaj_d[l_ac].pmaj002
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "pmaj_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        CANCEL INSERT
                     END IF
                     LET g_pmaj_d[l_ac].pmaj002 = l_oofa001
                     LET g_pmaa027_d = g_pmaj_d[l_ac].pmaj002
                  #END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmaj_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後 name="input.body.after_insert"
            
            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF apmi005_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_pmaj_m.pmaj001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pmaj_d_t.pmaj002
 
 
                  #刪除下層單身
                  IF NOT apmi005_key_delete_b(gs_keys,'pmaj_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE apmi005_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE apmi005_bcl
               LET l_count = g_pmaj_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_pmaj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmajstus
            #add-point:BEFORE FIELD pmajstus name="input.b.page1.pmajstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmajstus
            
            #add-point:AFTER FIELD pmajstus name="input.a.page1.pmajstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmajstus
            #add-point:ON CHANGE pmajstus name="input.g.page1.pmajstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj002
            #add-point:BEFORE FIELD pmaj002 name="input.b.page1.pmaj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj002
            
            #add-point:AFTER FIELD pmaj002 name="input.a.page1.pmaj002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_pmaj_m.pmaj001) AND NOT cl_null(g_pmaj_d[l_ac].pmaj002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_pmaj_m.pmaj001 != g_pmaj001_t OR g_pmaj_d[l_ac].pmaj002 != g_pmaj_d_t.pmaj002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmaj_t WHERE "||"pmajent = '" ||g_enterprise|| "' AND "||"pmaj001 = '"||g_pmaj_m.pmaj001 ||"' AND "|| "pmaj002 = '"||g_pmaj_d[l_ac].pmaj002 ||"'",'std-00004',0) THEN 
                     LET g_pmaj_d[l_ac].pmaj002 = g_pmaj_d_t.pmaj002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaj002
            #add-point:ON CHANGE pmaj002 name="input.g.page1.pmaj002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj003
            
            #add-point:AFTER FIELD pmaj003 name="input.a.page1.pmaj003"
            CALL apmi005_pmaj003_ref(g_pmaj_d[l_ac].pmaj003) RETURNING g_pmaj_d[l_ac].pmaj003_desc
            DISPLAY BY NAME g_pmaj_d[l_ac].pmaj003_desc
            
            IF NOT cl_null(g_pmaj_d[l_ac].pmaj003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj003 != g_pmaj_d_t.pmaj003))) THEN  
                  IF NOT s_azzi650_chk_exist('259',g_pmaj_d[l_ac].pmaj003) THEN
                     LET g_pmaj_d[l_ac].pmaj003 = g_pmaj_d_t.pmaj003
                     CALL apmi005_pmaj003_ref(g_pmaj_d[l_ac].pmaj003) RETURNING g_pmaj_d[l_ac].pmaj003_desc
                     DISPLAY BY NAME g_pmaj_d[l_ac].pmaj003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj003
            #add-point:BEFORE FIELD pmaj003 name="input.b.page1.pmaj003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaj003
            #add-point:ON CHANGE pmaj003 name="input.g.page1.pmaj003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj009
            #add-point:BEFORE FIELD pmaj009 name="input.b.page1.pmaj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj009
            
            #add-point:AFTER FIELD pmaj009 name="input.a.page1.pmaj009"
            IF (NOT cl_null(g_pmaj_d[l_ac].pmaj009)) AND (NOT cl_null(g_pmaj_d[l_ac].pmaj011)) THEN
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj009 != g_pmaj_d_t.pmaj009 OR cl_null(g_pmaj_d_t.pmaj009))) THEN
                   CALL s_aooi350_gen_fullname(g_site,g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011) RETURNING l_success,g_pmaj_d[l_ac].pmaj012
                END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaj009
            #add-point:ON CHANGE pmaj009 name="input.g.page1.pmaj009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj010
            #add-point:BEFORE FIELD pmaj010 name="input.b.page1.pmaj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj010
            
            #add-point:AFTER FIELD pmaj010 name="input.a.page1.pmaj010"
            IF (NOT cl_null(g_pmaj_d[l_ac].pmaj010)) AND (NOT cl_null(g_pmaj_d[l_ac].pmaj009)) AND (NOT cl_null(g_pmaj_d[l_ac].pmaj011)) THEN
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj010 != g_pmaj_d_t.pmaj010 OR cl_null(g_pmaj_d_t.pmaj010))) THEN
                   CALL s_aooi350_gen_fullname(g_site,g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011) RETURNING l_success,g_pmaj_d[l_ac].pmaj012
                END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaj010
            #add-point:ON CHANGE pmaj010 name="input.g.page1.pmaj010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj011
            #add-point:BEFORE FIELD pmaj011 name="input.b.page1.pmaj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj011
            
            #add-point:AFTER FIELD pmaj011 name="input.a.page1.pmaj011"
            IF (NOT cl_null(g_pmaj_d[l_ac].pmaj009)) AND (NOT cl_null(g_pmaj_d[l_ac].pmaj011)) THEN
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj011 != g_pmaj_d_t.pmaj011 OR cl_null(g_pmaj_d_t.pmaj011))) THEN
                   CALL s_aooi350_gen_fullname(g_site,g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011) RETURNING l_success,g_pmaj_d[l_ac].pmaj012
                END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaj011
            #add-point:ON CHANGE pmaj011 name="input.g.page1.pmaj011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj012
            #add-point:BEFORE FIELD pmaj012 name="input.b.page1.pmaj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj012
            
            #add-point:AFTER FIELD pmaj012 name="input.a.page1.pmaj012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaj012
            #add-point:ON CHANGE pmaj012 name="input.g.page1.pmaj012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj013
            #add-point:BEFORE FIELD pmaj013 name="input.b.page1.pmaj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj013
            
            #add-point:AFTER FIELD pmaj013 name="input.a.page1.pmaj013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaj013
            #add-point:ON CHANGE pmaj013 name="input.g.page1.pmaj013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj014
            #add-point:BEFORE FIELD pmaj014 name="input.b.page1.pmaj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj014
            
            #add-point:AFTER FIELD pmaj014 name="input.a.page1.pmaj014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaj014
            #add-point:ON CHANGE pmaj014 name="input.g.page1.pmaj014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj004
            #add-point:BEFORE FIELD pmaj004 name="input.b.page1.pmaj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj004
            
            #add-point:AFTER FIELD pmaj004 name="input.a.page1.pmaj004"
            IF g_pmaj_d[l_ac].pmaj004 = 'Y' THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj004 != g_pmaj_d_t.pmaj004)) THEN 
                  IF NOT apmi005_pmaj004_chk() THEN
                     LET g_pmaj_d[l_ac].pmaj004 = g_pmaj_d_t.pmaj004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaj004
            #add-point:ON CHANGE pmaj004 name="input.g.page1.pmaj004"
            IF g_pmaj_d[l_ac].pmaj004 = 'Y' THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj004 != g_pmaj_d_t.pmaj004)) THEN
                  IF NOT apmi005_pmaj004_chk() THEN
                     LET g_pmaj_d[l_ac].pmaj004 = g_pmaj_d_t.pmaj004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj005
            #add-point:BEFORE FIELD pmaj005 name="input.b.page1.pmaj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj005
            
            #add-point:AFTER FIELD pmaj005 name="input.a.page1.pmaj005"
            IF g_pmaj_d[l_ac].pmaj005 = 'Y' THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj005 != g_pmaj_d_t.pmaj005)) THEN
                  IF NOT apmi005_pmaj005_chk() THEN
                     LET g_pmaj_d[l_ac].pmaj005 = g_pmaj_d_t.pmaj005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaj005
            #add-point:ON CHANGE pmaj005 name="input.g.page1.pmaj005"
            IF g_pmaj_d[l_ac].pmaj005 = 'Y' THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmaj_d[l_ac].pmaj005 != g_pmaj_d_t.pmaj005)) THEN
                  IF NOT apmi005_pmaj005_chk() THEN
                     LET g_pmaj_d[l_ac].pmaj005 = g_pmaj_d_t.pmaj005
                     NEXT FIELD CURRENT
                   END IF
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj006
            #add-point:BEFORE FIELD pmaj006 name="input.b.page1.pmaj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj006
            
            #add-point:AFTER FIELD pmaj006 name="input.a.page1.pmaj006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaj006
            #add-point:ON CHANGE pmaj006 name="input.g.page1.pmaj006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj007
            #add-point:BEFORE FIELD pmaj007 name="input.b.page1.pmaj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj007
            
            #add-point:AFTER FIELD pmaj007 name="input.a.page1.pmaj007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaj007
            #add-point:ON CHANGE pmaj007 name="input.g.page1.pmaj007"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaj008
            #add-point:BEFORE FIELD pmaj008 name="input.b.page1.pmaj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaj008
            
            #add-point:AFTER FIELD pmaj008 name="input.a.page1.pmaj008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaj008
            #add-point:ON CHANGE pmaj008 name="input.g.page1.pmaj008"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pmajstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmajstus
            #add-point:ON ACTION controlp INFIELD pmajstus name="input.c.page1.pmajstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmaj002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj002
            #add-point:ON ACTION controlp INFIELD pmaj002 name="input.c.page1.pmaj002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmaj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj003
            #add-point:ON ACTION controlp INFIELD pmaj003 name="input.c.page1.pmaj003"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmaj_d[l_ac].pmaj003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "259" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaj_d[l_ac].pmaj003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL apmi005_pmaj003_ref(g_pmaj_d[l_ac].pmaj003) RETURNING g_pmaj_d[l_ac].pmaj003_desc
            DISPLAY BY NAME g_pmaj_d[l_ac].pmaj003_desc

            DISPLAY g_pmaj_d[l_ac].pmaj003 TO pmaj003              #顯示到畫面上

            NEXT FIELD pmaj003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmaj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj009
            #add-point:ON ACTION controlp INFIELD pmaj009 name="input.c.page1.pmaj009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmaj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj010
            #add-point:ON ACTION controlp INFIELD pmaj010 name="input.c.page1.pmaj010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmaj011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj011
            #add-point:ON ACTION controlp INFIELD pmaj011 name="input.c.page1.pmaj011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmaj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj012
            #add-point:ON ACTION controlp INFIELD pmaj012 name="input.c.page1.pmaj012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmaj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj013
            #add-point:ON ACTION controlp INFIELD pmaj013 name="input.c.page1.pmaj013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmaj014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj014
            #add-point:ON ACTION controlp INFIELD pmaj014 name="input.c.page1.pmaj014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmaj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj004
            #add-point:ON ACTION controlp INFIELD pmaj004 name="input.c.page1.pmaj004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmaj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj005
            #add-point:ON ACTION controlp INFIELD pmaj005 name="input.c.page1.pmaj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmaj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj006
            #add-point:ON ACTION controlp INFIELD pmaj006 name="input.c.page1.pmaj006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmaj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj007
            #add-point:ON ACTION controlp INFIELD pmaj007 name="input.c.page1.pmaj007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmaj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaj008
            #add-point:ON ACTION controlp INFIELD pmaj008 name="input.c.page1.pmaj008"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pmaj_d[l_ac].* = g_pmaj_d_t.*
               CLOSE apmi005_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pmaj_d[l_ac].pmaj002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_pmaj_d[l_ac].* = g_pmaj_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL apmi005_pmaj_t_mask_restore('restore_mask_o')
         
               UPDATE pmaj_t SET (pmaj001,pmajstus,pmaj002,pmaj003,pmaj009,pmaj010,pmaj011,pmaj012,pmaj013, 
                   pmaj014,pmaj004,pmaj005,pmaj006,pmaj007,pmaj008) = (g_pmaj_m.pmaj001,g_pmaj_d[l_ac].pmajstus, 
                   g_pmaj_d[l_ac].pmaj002,g_pmaj_d[l_ac].pmaj003,g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010, 
                   g_pmaj_d[l_ac].pmaj011,g_pmaj_d[l_ac].pmaj012,g_pmaj_d[l_ac].pmaj013,g_pmaj_d[l_ac].pmaj014, 
                   g_pmaj_d[l_ac].pmaj004,g_pmaj_d[l_ac].pmaj005,g_pmaj_d[l_ac].pmaj006,g_pmaj_d[l_ac].pmaj007, 
                   g_pmaj_d[l_ac].pmaj008)
                WHERE pmajent = g_enterprise AND pmaj001 = g_pmaj_m.pmaj001 
 
                 AND pmaj002 = g_pmaj_d_t.pmaj002 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmaj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "pmaj_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmaj_m.pmaj001
               LET gs_keys_bak[1] = g_pmaj001_t
               LET gs_keys[2] = g_pmaj_d[g_detail_idx].pmaj002
               LET gs_keys_bak[2] = g_pmaj_d_t.pmaj002
               CALL apmi005_update_b('pmaj_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_pmaj_m),util.JSON.stringify(g_pmaj_d_t)
                     LET g_log2 = util.JSON.stringify(g_pmaj_m),util.JSON.stringify(g_pmaj_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL apmi005_pmaj_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_pmaj_m.pmaj001
 
               LET ls_keys[ls_keys.getLength()+1] = g_pmaj_d_t.pmaj002
 
               CALL apmi005_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               LET g_pmaa027_d = g_pmaj_d[l_ac].pmaj002
               
               #--mark by shiunyo 14/09/10--(S)
#               IF SQLCA.sqlcode THEN
#               ELSE          
#                  UPDATE oofa_t SET (pmaj009,pmaj010,pmaj011,pmaj012,pmaj013,pmaj014) = (g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011,g_pmaj_d[l_ac].pmaj012,g_pmaj_d[l_ac].pmaj013,g_pmaj_d[l_ac].pmaj014)
#                    WHERE oofaent = g_enterprise AND oofa001 = g_pmaj_d_t.pmaj002
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "oofa_t"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_pmaj_d[l_ac].* = g_pmaj_d_t.*
#                  END IF
#               END IF
               #--mark by shiunyo 14/09/10--(E)
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE apmi005_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pmaj_d[l_ac].* = g_pmaj_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE apmi005_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_pmaj_d.getLength() = 0 THEN
               NEXT FIELD pmaj002
            END IF
            #add-point:input段after input  name="input.body.after_input"
 
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_pmaj_d[li_reproduce_target].* = g_pmaj_d[li_reproduce].*
 
               LET g_pmaj_d[li_reproduce_target].pmaj002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pmaj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pmaj_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      #聯絡地址輸入
      SUBDIALOG aoo_aooi350_01.aooi350_01_input
      #通訊方式輸入
      SUBDIALOG aoo_aooi350_02.aooi350_02_input  
         
         
         ON ACTION aooi350_01

            LET g_action_choice="aooi350_01"
            IF cl_auth_chk_act("aooi350_01") THEN 
               #add-point:ON ACTION aooi350_01
               IF l_ac > 0 THEN
                  IF NOT cl_null(g_pmaj_d[l_ac].pmaj002) THEN
                     CALL aooi350_01(g_pmaj_d[l_ac].pmaj002)
                  END IF
               END IF
               #END add-point
                EXIT DIALOG
            END IF


         ON ACTION aooi350_02

            LET g_action_choice="aooi350_02"
            IF cl_auth_chk_act("aooi350_02") THEN 
               #add-point:ON ACTION aooi350_02
               IF l_ac > 0 THEN
                  IF NOT cl_null(g_pmaj_d[l_ac].pmaj002) THEN
                     CALL aooi350_02(g_pmaj_d[l_ac].pmaj002)
                  END IF
               END IF
               
               #END add-point
                EXIT DIALOG
            END IF
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         #為了修改功能doubleClick可以直接進入單身, 需指定要進入哪一個單身
         IF NOT cl_null(p_cmd) AND p_cmd != 'a' THEN
            CASE g_aw
               WHEN "s_detail1_aooi350_01"
                  NEXT FIELD oofbstus
               WHEN "s_detail1_aooi350_02"
                  NEXT FIELD oofcstus
            END CASE
         END IF
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD pmaj001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pmajstus
 
            END CASE
         END IF
   
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
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
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
   #將畫面指標同步到當下指定的位置上
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apmi005_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   IF NOT cl_null(g_argv[02]) THEN
      CALL cl_set_act_visible("query",FALSE)
   END IF
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL apmi005_b_fill(g_wc2) #第一階單身填充
      CALL apmi005_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apmi005_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_pmaj_m.pmaj001,g_pmaj_m.pmaal004,g_pmaj_m.pmaa002
 
   CALL apmi005_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
 
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION apmi005_ref_show()
   #add-point:ref_show段define name="ref_show.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ref_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ref_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference name="ref_show.head.reference"
   CALL apmi005_pmaj001_ref(g_pmaj_m.pmaj001) RETURNING g_pmaj_m.pmaa002,g_pmaj_m.pmaal004
   DISPLAY BY NAME g_pmaj_m.pmaa002,g_pmaj_m.pmaal004
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_pmaj_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="apmi005.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmi005_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE pmaj_t.pmaj001 
   DEFINE l_oldno     LIKE pmaj_t.pmaj001 
 
   DEFINE l_master    RECORD LIKE pmaj_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pmaj_t.* #此變數樣板目前無使用
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_oofa001   LIKE oofa_t.oofa001
   #end add-point
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_pmaj_m.pmaj001 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_pmaj001_t = g_pmaj_m.pmaj001
 
   
   LET g_pmaj_m.pmaj001 = ""
 
   LET g_master_insert = FALSE
   CALL apmi005_set_entry('a')
   CALL apmi005_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_pmaj_m.pmaal004 = ""
   LET g_pmaj_m.pmaa002 = ""
   DISPLAY BY NAME g_pmaj_m.pmaal004,g_pmaj_m.pmaa002
   #end add-point
   
   #清空key欄位的desc
   
   
   CALL apmi005_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_pmaj_m.* TO NULL
      INITIALIZE g_pmaj_d TO NULL
 
      CALL apmi005_show()
      LET INT_FLAG = 0
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN 
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apmi005_set_act_visible()
   CALL apmi005_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pmaj001_t = g_pmaj_m.pmaj001
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmajent = " ||g_enterprise|| " AND",
                      " pmaj001 = '", g_pmaj_m.pmaj001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmi005_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL apmi005_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL apmi005_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apmi005_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pmaj_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apmi005_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmaj_t
    WHERE pmajent = g_enterprise AND pmaj001 = g_pmaj001_t
 
       INTO TEMP apmi005_detail
   
   #將key修正為調整後   
   UPDATE apmi005_detail 
      #更新key欄位
      SET pmaj001 = g_pmaj_m.pmaj001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
      #, pmajstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO pmaj_t SELECT * FROM apmi005_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE apmi005_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pmaj001_t = g_pmaj_m.pmaj001
 
   
   DROP TABLE apmi005_detail
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apmi005_delete()
   #add-point:delete段define name="delete.define_customerization"
   
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
   
   IF g_pmaj_m.pmaj001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN apmi005_cl USING g_enterprise,g_pmaj_m.pmaj001
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmi005_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE apmi005_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmi005_master_referesh USING g_pmaj_m.pmaj001 INTO g_pmaj_m.pmaj001
   
   #遮罩相關處理
   LET g_pmaj_m_mask_o.* =  g_pmaj_m.*
   CALL apmi005_pmaj_t_mask()
   LET g_pmaj_m_mask_n.* =  g_pmaj_m.*
   
   CALL apmi005_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmi005_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      #161207-00072#1 add ---s
      DELETE FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 IN ( SELECT pmaj002 FROM pmaj_t WHERE pmajent = g_enterprise AND pmaj001 = g_pmaj_m.pmaj001 )
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oofa_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF
      
      DELETE FROM oofc_t WHERE oofcent = g_enterprise AND oofc002 IN ( SELECT pmaj002 FROM pmaj_t WHERE pmajent = g_enterprise AND pmaj001 = g_pmaj_m.pmaj001 )
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oofa_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF
      #161207-00072#1 add ---e
      #end add-point
      
      DELETE FROM pmaj_t WHERE pmajent = g_enterprise AND pmaj001 = g_pmaj_m.pmaj001
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmaj_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      DELETE FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '4' AND oofa003 = g_pmaj_m.pmaj001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oofa_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF
      
      CALL aooi350_01_clear_detail()   #清除聯絡地址
      CALL aooi350_02_clear_detail()   #清除通訊方式
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE apmi005_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_pmaj_d.clear() 
 
     
      CALL apmi005_ui_browser_refresh()  
      #CALL apmi005_ui_headershow()  
      #CALL apmi005_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL apmi005_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL apmi005_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE apmi005_cl
 
   #功能已完成,通報訊息中心
   CALL apmi005_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apmi005.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmi005_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_cnt_t    LIKE type_t.num10
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_pmaj_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT pmajstus,pmaj002,pmaj003,pmaj009,pmaj010,pmaj011,pmaj012,pmaj013,pmaj014, 
       pmaj004,pmaj005,pmaj006,pmaj007,pmaj008,t1.oocql004 FROM pmaj_t",   
               "",
               
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='259' AND t1.oocql002=pmaj003 AND t1.oocql003='"||g_dlang||"' ",
 
               " WHERE pmajent= ? AND pmaj001=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("pmaj_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF apmi005_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY pmaj_t.pmaj002"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmi005_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apmi005_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pmaj_m.pmaj001   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pmaj_m.pmaj001 INTO g_pmaj_d[l_ac].pmajstus,g_pmaj_d[l_ac].pmaj002, 
          g_pmaj_d[l_ac].pmaj003,g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011, 
          g_pmaj_d[l_ac].pmaj012,g_pmaj_d[l_ac].pmaj013,g_pmaj_d[l_ac].pmaj014,g_pmaj_d[l_ac].pmaj004, 
          g_pmaj_d[l_ac].pmaj005,g_pmaj_d[l_ac].pmaj006,g_pmaj_d[l_ac].pmaj007,g_pmaj_d[l_ac].pmaj008, 
          g_pmaj_d[l_ac].pmaj003_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #--mark by shiunyo 14/09/10--(S)
#         CALL apmi005_pmaj002_ref(g_pmaj_d[l_ac].pmaj002) RETURNING g_pmaj_d[l_ac].pmaj009,g_pmaj_d[l_ac].pmaj010,g_pmaj_d[l_ac].pmaj011,g_pmaj_d[l_ac].pmaj012,g_pmaj_d[l_ac].pmaj013,g_pmaj_d[l_ac].pmaj014
         #--mark by shiunyo 14/09/10--(E)
         
         #CALL aooi350_01_clear_detail()   #清除聯絡地址
         #CALL aooi350_02_clear_detail()   #清除通訊方式
         ##取得通訊地址, 聯絡方式單身資料
         #IF NOT cl_null(g_pmaj_d[l_ac].pmaj002) THEN
         #   CALL aooi350_01_b_fill(g_pmaj_d[l_ac].pmaj002)
         #   CALL aooi350_02_b_fill(g_pmaj_d[l_ac].pmaj002)
         #END IF
         #LET g_pmaa027_d = g_pmaj_d[l_ac].pmaj002
      
         #end add-point
      
         #帶出公用欄位reference值
         #應用 a12 樣板自動產生(Version:4)
 
 
 
         
 
        
         #add-point:單身資料抓取 name="bfill.foreach"
 
         #end add-point
      
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
 
            CALL g_pmaj_d.deleteElement(g_pmaj_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
 
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_pmaj_d.getLength()
      LET g_pmaj_d_mask_o[l_ac].* =  g_pmaj_d[l_ac].*
      CALL apmi005_pmaj_t_mask()
      LET g_pmaj_d_mask_n[l_ac].* =  g_pmaj_d[l_ac].*
   END FOR
   
 
 
   FREE apmi005_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apmi005_idx_chk()
   #add-point:idx_chk段define name="idx_chk.define_customerization"
   
   #end add-point
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   #判定目前選擇的頁面
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_pmaj_d.getLength() THEN
         LET g_detail_idx = g_pmaj_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_pmaj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmaj_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmi005_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_pmaj_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
      LET g_detail_idx = 1
   END IF      
   CALL aooi350_01_clear_detail()   #清除聯絡地址
   CALL aooi350_02_clear_detail()   #清除通訊方式
   #取得通訊地址, 聯絡方式單身資料
   IF NOT cl_null(g_pmaj_d[g_detail_idx].pmaj002) THEN
      CALL aooi350_01_b_fill(g_pmaj_d[g_detail_idx].pmaj002)
      CALL aooi350_02_b_fill(g_pmaj_d[g_detail_idx].pmaj002)
   END IF
   LET g_pmaa027_d = g_pmaj_d[g_detail_idx].pmaj002

   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION apmi005_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM pmaj_t
    WHERE pmajent = g_enterprise AND pmaj001 = g_pmaj_m.pmaj001 AND
 
          pmaj002 = g_pmaj_d_t.pmaj002
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "pmaj_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後 name="delete.body.a_single_delete"
   IF NOT s_aooi350_del(g_pmaj_d_t.pmaj002) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "oofa_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE 
   END IF
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="apmi005.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apmi005_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apmi005_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apmi005_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define name="update_b.define_customerization"
   
   #end add-point 
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION apmi005_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_pmaj_d[l_ac].pmaj002 = g_pmaj_d_t.pmaj002 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apmi005_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apmi005_lock_b(ps_table,ps_page)
   #add-point:lock_b段define name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL apmi005_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apmi005.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apmi005_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmi005.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmi005_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pmaj001",TRUE)
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
 
{<section id="apmi005.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmi005_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pmaj001",FALSE)
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
 
{<section id="apmi005.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apmi005_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apmi005_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmi005_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("insert,query",TRUE)
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmi005.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmi005_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF NOT cl_null(g_argv[02]) THEN
      CALL cl_set_act_visible("insert,query",FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmi005.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apmi005_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
 
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmi005.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apmi005_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmi005.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmi005_default_search()
   #add-point:default_search段define name="default_search.define_customerization"
   
   #end add-point    
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " pmaj001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   #160912-00007#1 add start -----
    IF NOT cl_null(g_argv[01]) AND NOT cl_null(g_argv[02]) THEN
       CASE g_argv[1] 
          WHEN '1' LET ls_wc = " pmaj001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise," AND (pmaa002 = '1' OR pmaa002 = '3') )  AND "
          WHEN '2' LET ls_wc = " pmaj001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise," AND (pmaa002 = '2' OR pmaa002 = '3') ) AND "
          WHEN '3' LET ls_wc = " pmaj001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise," AND (pmaa002 = '1' OR pmaa002 = '2' OR pmaa002 = '3') ) AND "
       END CASE
       LET ls_wc = ls_wc," pmaj001 = '",g_argv[02], "' AND "
    ELSE
       LET ls_wc = " 1=2 AND "
    END IF
   #160912-00007#1 add end   -----
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   #160912-00007#1 mark start -----
   #IF NOT cl_null(g_argv[1]) THEN
   #   CASE g_argv[1] 
   #      WHEN '1' LET g_wc = " pmaj001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise," AND (pmaa002 = '1' OR pmaa002 = '3') ) "
   #      WHEN '2' LET g_wc = " pmaj001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise," AND (pmaa002 = '2' OR pmaa002 = '3') ) "
   #      WHEN '3' LET g_wc = " pmaj001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise," AND (pmaa002 = '1' OR pmaa002 = '2' OR pmaa002 = '3') ) "
   #   END CASE
   #ELSE
   #   LET g_wc = " 1=1"
   #END IF
   #IF NOT cl_null(g_argv[02]) THEN
   #   LET g_wc = g_wc," AND pmaj001 = '",g_argv[02], "' "
   #END IF
   #160912-00007#1 mark end   -----         
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmi005.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apmi005_fill_chk(ps_idx)
   #add-point:fill_chk段define name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fill_chk.pre_function"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
   
   #add-point:fill_chk段other name="fill_chk.other"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apmi005.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION apmi005_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="modify_detail_chk.before"
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "pmajstus"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="apmi005.mask_functions" >}
&include "erp/apm/apmi005_mask.4gl"
 
{</section>}
 
{<section id="apmi005.state_change" >}
    
 
{</section>}
 
{<section id="apmi005.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmi005_set_pk_array()
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
   LET g_pk_array[1].values = g_pmaj_m.pmaj001
   LET g_pk_array[1].column = 'pmaj001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmi005.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmi005_msgcentre_notify(lc_state)
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
   CALL apmi005_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmaj_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmi005.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION apmi005_pmaj001_chk(p_pmaj001)
DEFINE p_pmaj001    LIKE pmaj_t.pmaj001
DEFINE r_success    LIKE type_t.num5
DEFINE l_pmaj002    LIKE pmaj_t.pmaj002

      LET r_success = TRUE

      IF g_argv[1] = '1' THEN     
         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
         INITIALIZE g_chkparam.* TO NULL

         #設定g_chkparam.*的參數
         LET g_chkparam.arg1 = p_pmaj001

         #呼叫檢查存在並帶值的library
         IF NOT cl_chk_exist("v_pmaa001_4") THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      IF g_argv[1] = '2' THEN
         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
         INITIALIZE g_chkparam.* TO NULL

         #設定g_chkparam.*的參數
         LET g_chkparam.arg1 = p_pmaj001

         #呼叫檢查存在並帶值的library
         IF NOT cl_chk_exist("v_pmaa001_5") THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      IF g_argv[1] = '3' THEN
         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
         INITIALIZE g_chkparam.* TO NULL

         #設定g_chkparam.*的參數
         LET g_chkparam.arg1 = p_pmaj001
         LET g_errshow = TRUE   #160318-00025#49
         LET g_chkparam.err_str[1] = "apm-00029:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"    #160318-00025#49
         #呼叫檢查存在並帶值的library
         IF NOT cl_chk_exist("v_pmaa001_6") THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      
      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmaj_t WHERE "||"pmajent = '" ||g_enterprise|| "' AND "||"pmaj001 = '"||p_pmaj001 ||"'",'std-00004',1) THEN 
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      RETURN r_success
      
END FUNCTION
#+
PRIVATE FUNCTION apmi005_pmaj002_ref(p_pmaj002)
DEFINE p_pmaj002   LIKE pmaj_t.pmaj002
DEFINE r_oofa008   LIKE oofa_t.oofa008
DEFINE r_oofa009   LIKE oofa_t.oofa009
DEFINE r_oofa010   LIKE oofa_t.oofa010
DEFINE r_oofa011   LIKE oofa_t.oofa011
DEFINE r_oofa012   LIKE oofa_t.oofa012
DEFINE r_oofa013   LIKE oofa_t.oofa013

      LET r_oofa008 = ' '
      LET r_oofa009 = ' '
      LET r_oofa010 = ' '
      LET r_oofa011 = ' '
      LET r_oofa012 = ' '
      LET r_oofa013 = ' '
      SELECT oofa008,oofa009,oofa010,oofa011,oofa012,oofa013 INTO r_oofa008,r_oofa009,r_oofa010,r_oofa011,r_oofa012,r_oofa013 FROM oofa_t 
         WHERE oofaent=g_enterprise AND oofa001=p_pmaj002
      RETURN r_oofa008,r_oofa009,r_oofa010,r_oofa011,r_oofa012,r_oofa013
      
END FUNCTION
#+
PRIVATE FUNCTION apmi005_pmaj001_ref(p_pmaj001)
DEFINE p_pmaj001      LIKE pmaj_t.pmaj001
DEFINE r_pmaa002      LIKE pmaa_t.pmaa002
DEFINE r_pmaal004     LIKE pmaal_t.pmaal004

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_pmaj001
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_pmaal004 = g_rtn_fields[1]
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_pmaj001
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaa002 FROM pmaa_t WHERE pmaaent='"||g_enterprise||"' AND pmaa001=? ","") RETURNING g_rtn_fields
      LET r_pmaa002 = g_rtn_fields[1]
      RETURN r_pmaa002,r_pmaal004
      
END FUNCTION
#+不可多次勾選財務主要聯絡人
PRIVATE FUNCTION apmi005_pmaj005_chk()
DEFINE l_n         LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5
 
       LET l_n = 0
       LET r_success = TRUE
       
       SELECT COUNT(*) INTO l_n FROM pmaj_t WHERE pmaj001 = g_pmaj_m.pmaj001 AND pmaj005 = 'Y'
          AND pmajent = g_enterprise   #160905-00007#3 add
       IF l_n > 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00049'
          LET g_errparam.extend = g_pmaj_m.pmaj001
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
       
END FUNCTION
#+不可勾選多個主要聯絡人
PRIVATE FUNCTION apmi005_pmaj004_chk()
DEFINE l_n         LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5
 
       LET l_n = 0
       LET r_success = TRUE
       
       SELECT COUNT(*) INTO l_n FROM pmaj_t WHERE pmajent = g_enterprise AND pmaj001 = g_pmaj_m.pmaj001 AND pmaj004 = 'Y'
       IF l_n > 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00048'
          LET g_errparam.extend = g_pmaj_m.pmaj001
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION apmi005_set_title_visible()
DEFINE l_gzze003   LIKE gzze_t.gzze003

       IF NOT cl_null(g_argv[1]) THEN
          IF g_argv[1] = '1' THEN
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00050' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaj001',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00051' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaal004',l_gzze003)
          END IF
          IF g_argv[1] = '2' THEN
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00052' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaj001',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00053' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaal004',l_gzze003)
          END IF
       END IF
END FUNCTION

PRIVATE FUNCTION apmi005_pmaj003_ref(p_pmaj003)
DEFINE p_pmaj003      LIKE pmaj_t.pmaj003
DEFINE r_oocql004     LIKE oocql_t.oocql004

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_pmaj003
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='259' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_oocql004 = g_rtn_fields[1]

      RETURN r_oocql004
      
END FUNCTION

 
{</section>}
 
