#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt005.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-09-16 02:12:02), PR版次:0005(2017-02-16 14:04:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: apmt005
#+ Description: 交易對象聯絡人申請作業
#+ Creator....: 00593(2015-09-07 12:10:56)
#+ Modifier...: 00593 -SD/PR- 08992
 
{</section>}
 
{<section id="apmt005.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#49 2016/04/26 By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息
#161124-00048#9  2016/12/19 By zhujing  .*整批调整
#170213-00050#1  2017/02/16 By 08992    新增時的pmbjdocno開窗能抓取未確認資料
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

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_pmbj_m        RECORD
       pmbjdocno LIKE pmbj_t.pmbjdocno, 
   pmbjdocno_desc LIKE type_t.chr80, 
   pmbj001 LIKE pmbj_t.pmbj001, 
   pmbal003 LIKE type_t.chr500, 
   pmaa002 LIKE pmaa_t.pmaa002
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pmbj_d        RECORD
       pmbjstus LIKE pmbj_t.pmbjstus, 
   pmbj003 LIKE pmbj_t.pmbj003, 
   pmbj003_desc LIKE type_t.chr500, 
   pmbj002 LIKE pmbj_t.pmbj002, 
   pmbj009 LIKE pmbj_t.pmbj009, 
   pmbj010 LIKE pmbj_t.pmbj010, 
   pmbj011 LIKE pmbj_t.pmbj011, 
   pmbj012 LIKE pmbj_t.pmbj012, 
   pmbj013 LIKE pmbj_t.pmbj013, 
   pmbj014 LIKE pmbj_t.pmbj014, 
   pmbj004 LIKE pmbj_t.pmbj004, 
   pmbj005 LIKE pmbj_t.pmbj005, 
   pmbj006 LIKE pmbj_t.pmbj006, 
   pmbj007 LIKE pmbj_t.pmbj007, 
   pmbj008 LIKE pmbj_t.pmbj008, 
   pmbj015 LIKE pmbj_t.pmbj015
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
DEFINE g_pmbj_m          type_g_pmbj_m
DEFINE g_pmbj_m_t        type_g_pmbj_m
DEFINE g_pmbj_m_o        type_g_pmbj_m
DEFINE g_pmbj_m_mask_o   type_g_pmbj_m #轉換遮罩前資料
DEFINE g_pmbj_m_mask_n   type_g_pmbj_m #轉換遮罩後資料
 
   DEFINE g_pmbjdocno_t LIKE pmbj_t.pmbjdocno
 
 
DEFINE g_pmbj_d          DYNAMIC ARRAY OF type_g_pmbj_d
DEFINE g_pmbj_d_t        type_g_pmbj_d
DEFINE g_pmbj_d_o        type_g_pmbj_d
DEFINE g_pmbj_d_mask_o   DYNAMIC ARRAY OF type_g_pmbj_d #轉換遮罩前資料
DEFINE g_pmbj_d_mask_n   DYNAMIC ARRAY OF type_g_pmbj_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_pmbjdocno LIKE pmbj_t.pmbjdocno
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
 
{<section id="apmt005.main" >}
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

      CLOSE WINDOW w_apmt005
      CALL cl_ap_exitprogram("0")
   ELSE
      IF g_argv[1] NOT MATCHES '[123]' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00043'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CLOSE WINDOW w_apmt005
         CALL cl_ap_exitprogram("0") 
      END IF
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET g_pmbj_m.pmbjdocno = g_argv[02]
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pmbjdocno,'',pmbj001,'',''", 
                      " FROM pmbj_t",
                      " WHERE pmbjent= ? AND pmbjdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt005_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmbjdocno,t0.pmbj001",
               " FROM pmbj_t t0",
               
               " WHERE t0.pmbjent = " ||g_enterprise|| " AND t0.pmbjdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmt005_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmt005 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmt005_init()   
 
      #進入選單 Menu (="N")
      CALL apmt005_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmt005
      
   END IF 
   
   CLOSE apmt005_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmt005.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmt005_init()
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
      SELECT COUNT(*) INTO l_n FROM pmbj_t WHERE pmbjent = g_enterprise AND pmbjdocno = g_pmbj_m.pmbjdocno
      IF l_n = 0 THEN
         CALL apmt005_insert()
      END IF
   END IF
   
   #子程式畫面取代主程式元件
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_01"), "grid_contact", "Table", "s_detail1_aooi350_01")
   CALL cl_set_combo_scc('oofb008','9')   #地址類型
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_02"), "grid_communication", "Table", "s_detail1_aooi350_02")
   CALL cl_set_combo_scc('oofc008','6')   #通訊類型
   #end add-point
   
   CALL apmt005_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apmt005.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apmt005_ui_dialog()
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
   CALL apmt005_set_title_visible()
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_pmbj_m.* TO NULL
         CALL g_pmbj_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmt005_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_pmbj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL apmt005_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apmt005_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               CALL aooi350_01_clear_detail()   #清除聯絡地址
               CALL aooi350_02_clear_detail()   #清除通訊方式
               #取得通訊地址, 聯絡方式單身資料
               IF cl_null(l_ac) OR l_ac < = 0 THEN
                  LET l_ac = 1
               END IF
               IF NOT cl_null(g_pmbj_d[l_ac].pmbj002) THEN
                  CALL aooi350_01_b_fill(g_pmbj_d[l_ac].pmbj002)            
                  CALL aooi350_02_b_fill(g_pmbj_d[l_ac].pmbj002)
               END IF
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
            IF NOT cl_null(g_pmbj_d[l_ac].pmbj002) THEN
               CALL aooi350_01_b_fill(g_pmbj_d[l_ac].pmbj002)            
               CALL aooi350_02_b_fill(g_pmbj_d[l_ac].pmbj002)
            END IF
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
            CALL apmt005_browser_fill("")
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
               CALL apmt005_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apmt005_ui_detailshow() #Setting the current row 
            
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
            CALL apmt005_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt005_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apmt005_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt005_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apmt005_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt005_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apmt005_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt005_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apmt005_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt005_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_pmbj_d)
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
               NEXT FIELD pmbj002
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
               CALL apmt005_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL apmt005_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL apmt005_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apmt005_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apmt005_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmt005_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmt005_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/apm/apmt005_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/apm/apmt005_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apmt005_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmt005_query()
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
                  IF NOT cl_null(g_pmbj_d[l_ac].pmbj002) THEN
                     CALL aooi350_01(g_pmbj_d[l_ac].pmbj002)
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
                  IF NOT cl_null(g_pmbj_d[l_ac].pmbj002) THEN
                     CALL aooi350_02(g_pmbj_d[l_ac].pmbj002)
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmt005_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmt005_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmt005_set_pk_array()
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
 
{<section id="apmt005.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION apmt005_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apmt005.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apmt005_browser_fill(ps_page_action)
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
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF NOT cl_null(g_argv[1]) THEN
      #若pmbj001為NULL，就不只單獨出現在某一支申請作業中，而是交易對象/客戶/供應商的申請作業都能查到
      LET g_wc = g_wc CLIPPED," AND ",
                 "(pmbj001 IS NULL OR",
                 " pmbj001 IN (SELECT pmba001 FROM pmba_t WHERE pmbaent = ",g_enterprise
      CASE g_argv[1] 
         WHEN '1' LET g_wc = g_wc ," AND (pmba002 = '1' OR pmba002 = '3') ) )"
         WHEN '2' LET g_wc = g_wc ," AND (pmba002 = '2' OR pmba002 = '3') ) )"
         WHEN '3' LET g_wc = g_wc ," AND (pmba002 = '1' OR pmba002 = '2' OR pmba002 = '3') ) )"
      END CASE
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc," AND pmbjdocno = '",g_argv[02], "' "
   END IF
   
   IF cl_null(g_add_browse) THEN
      CALL aooi350_01_clear_detail()   #清除聯絡地址
      CALL aooi350_02_clear_detail()   #清除通訊方式
   END IF
   #end add-point    
 
   LET l_searchcol = "pmbjdocno"
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
      LET l_sub_sql = " SELECT DISTINCT pmbjdocno ",
 
                      " FROM pmbj_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE pmbjent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pmbj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pmbjdocno ",
 
                      " FROM pmbj_t ",
                      " ",
                      " ", 
 
 
                      " WHERE pmbjent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pmbj_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
 
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
      INITIALIZE g_pmbj_m.* TO NULL
      CALL g_pmbj_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pmbjdocno Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.pmbjdocno",
                " FROM pmbj_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.pmbjent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("pmbj_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
 
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmbj_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_pmbjdocno 
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
   
   IF cl_null(g_browser[g_cnt].b_pmbjdocno) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_pmbj_m.* TO NULL
      CALL g_pmbj_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL apmt005_fetch('')
   
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
 
{<section id="apmt005.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apmt005_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pmbj_m.pmbjdocno = g_browser[g_current_idx].b_pmbjdocno   
 
   EXECUTE apmt005_master_referesh USING g_pmbj_m.pmbjdocno INTO g_pmbj_m.pmbjdocno,g_pmbj_m.pmbj001
   CALL apmt005_show()
   
END FUNCTION
 
{</section>}
 
{<section id="apmt005.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apmt005_ui_detailshow()
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
 
{<section id="apmt005.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmt005_ui_browser_refresh()
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
      IF g_browser[l_i].b_pmbjdocno = g_pmbj_m.pmbjdocno 
 
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
 
{<section id="apmt005.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmt005_construct()
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
   INITIALIZE g_pmbj_m.* TO NULL
   CALL g_pmbj_d.clear()
 
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
      CONSTRUCT BY NAME g_wc ON pmbjdocno,pmbjdocno_desc,pmbj001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.pmbjdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbjdocno
            #add-point:ON ACTION controlp INFIELD pmbjdocno name="construct.c.pmbjdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_pmbadocno()                       #呼叫開窗  #170213-00050#1 MARK
            CALL q_pmbadocno_1()                                #170213-00050#1 add
            DISPLAY g_qryparam.return1 TO pmbjdocno  #顯示到畫面上
            NEXT FIELD pmbjdocno                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbjdocno
            #add-point:BEFORE FIELD pmbjdocno name="construct.b.pmbjdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbjdocno
            
            #add-point:AFTER FIELD pmbjdocno name="construct.a.pmbjdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbjdocno_desc
            #add-point:BEFORE FIELD pmbjdocno_desc name="construct.b.pmbjdocno_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbjdocno_desc
            
            #add-point:AFTER FIELD pmbjdocno_desc name="construct.a.pmbjdocno_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbjdocno_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbjdocno_desc
            #add-point:ON ACTION controlp INFIELD pmbjdocno_desc name="construct.c.pmbjdocno_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj001
            #add-point:ON ACTION controlp INFIELD pmbj001 name="construct.c.pmbj001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CASE g_argv[1]
               WHEN '1' LET g_qryparam.where= " (pmaa002 = '1' OR pmaa002 = '3') "
               WHEN '2' LET g_qryparam.where= " (pmaa002 = '2' OR pmaa002 = '3') "
               WHEN '3' LET g_qryparam.where= " (pmaa002 = '1' OR pmaa002 = '2' OR pmaa002 = '3') "
            END CASE
            CALL q_pmaa001_4()                     #呼叫開窗
            LET g_qryparam.where= " "
            DISPLAY g_qryparam.return1 TO pmbj001  #顯示到畫面上
            NEXT FIELD pmbj001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj001
            #add-point:BEFORE FIELD pmbj001 name="construct.b.pmbj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj001
            
            #add-point:AFTER FIELD pmbj001 name="construct.a.pmbj001"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON pmbjstus,pmbj003,pmbj002,pmbj009,pmbj010,pmbj011,pmbj012,pmbj013,pmbj014, 
          pmbj004,pmbj005,pmbj006,pmbj007,pmbj008,pmbj015
           FROM s_detail1[1].pmbjstus,s_detail1[1].pmbj003,s_detail1[1].pmbj002,s_detail1[1].pmbj009, 
               s_detail1[1].pmbj010,s_detail1[1].pmbj011,s_detail1[1].pmbj012,s_detail1[1].pmbj013,s_detail1[1].pmbj014, 
               s_detail1[1].pmbj004,s_detail1[1].pmbj005,s_detail1[1].pmbj006,s_detail1[1].pmbj007,s_detail1[1].pmbj008, 
               s_detail1[1].pmbj015
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pmbjcrtdt>>----
 
         #----<<pmbjmoddt>>----
         
         #----<<pmbjcnfdt>>----
         
         #----<<pmbjpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbjstus
            #add-point:BEFORE FIELD pmbjstus name="construct.b.page1.pmbjstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbjstus
            
            #add-point:AFTER FIELD pmbjstus name="construct.a.page1.pmbjstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmbjstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbjstus
            #add-point:ON ACTION controlp INFIELD pmbjstus name="construct.c.page1.pmbjstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmbj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj003
            #add-point:ON ACTION controlp INFIELD pmbj003 name="construct.c.page1.pmbj003"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where= " oocqstus = 'Y' "
            LET g_qryparam.arg1 = "259"
            CALL q_oocq002()                       #呼叫開窗
            LET g_qryparam.where= " "
            DISPLAY g_qryparam.return1 TO pmbj003  #顯示到畫面上
            NEXT FIELD pmbj003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj003
            #add-point:BEFORE FIELD pmbj003 name="construct.b.page1.pmbj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj003
            
            #add-point:AFTER FIELD pmbj003 name="construct.a.page1.pmbj003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj002
            #add-point:BEFORE FIELD pmbj002 name="construct.b.page1.pmbj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj002
            
            #add-point:AFTER FIELD pmbj002 name="construct.a.page1.pmbj002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmbj002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj002
            #add-point:ON ACTION controlp INFIELD pmbj002 name="construct.c.page1.pmbj002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj009
            #add-point:BEFORE FIELD pmbj009 name="construct.b.page1.pmbj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj009
            
            #add-point:AFTER FIELD pmbj009 name="construct.a.page1.pmbj009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmbj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj009
            #add-point:ON ACTION controlp INFIELD pmbj009 name="construct.c.page1.pmbj009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj010
            #add-point:BEFORE FIELD pmbj010 name="construct.b.page1.pmbj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj010
            
            #add-point:AFTER FIELD pmbj010 name="construct.a.page1.pmbj010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmbj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj010
            #add-point:ON ACTION controlp INFIELD pmbj010 name="construct.c.page1.pmbj010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj011
            #add-point:BEFORE FIELD pmbj011 name="construct.b.page1.pmbj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj011
            
            #add-point:AFTER FIELD pmbj011 name="construct.a.page1.pmbj011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmbj011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj011
            #add-point:ON ACTION controlp INFIELD pmbj011 name="construct.c.page1.pmbj011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj012
            #add-point:BEFORE FIELD pmbj012 name="construct.b.page1.pmbj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj012
            
            #add-point:AFTER FIELD pmbj012 name="construct.a.page1.pmbj012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmbj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj012
            #add-point:ON ACTION controlp INFIELD pmbj012 name="construct.c.page1.pmbj012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj013
            #add-point:BEFORE FIELD pmbj013 name="construct.b.page1.pmbj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj013
            
            #add-point:AFTER FIELD pmbj013 name="construct.a.page1.pmbj013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmbj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj013
            #add-point:ON ACTION controlp INFIELD pmbj013 name="construct.c.page1.pmbj013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj014
            #add-point:BEFORE FIELD pmbj014 name="construct.b.page1.pmbj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj014
            
            #add-point:AFTER FIELD pmbj014 name="construct.a.page1.pmbj014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmbj014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj014
            #add-point:ON ACTION controlp INFIELD pmbj014 name="construct.c.page1.pmbj014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj004
            #add-point:BEFORE FIELD pmbj004 name="construct.b.page1.pmbj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj004
            
            #add-point:AFTER FIELD pmbj004 name="construct.a.page1.pmbj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmbj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj004
            #add-point:ON ACTION controlp INFIELD pmbj004 name="construct.c.page1.pmbj004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj005
            #add-point:BEFORE FIELD pmbj005 name="construct.b.page1.pmbj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj005
            
            #add-point:AFTER FIELD pmbj005 name="construct.a.page1.pmbj005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmbj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj005
            #add-point:ON ACTION controlp INFIELD pmbj005 name="construct.c.page1.pmbj005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj006
            #add-point:BEFORE FIELD pmbj006 name="construct.b.page1.pmbj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj006
            
            #add-point:AFTER FIELD pmbj006 name="construct.a.page1.pmbj006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmbj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj006
            #add-point:ON ACTION controlp INFIELD pmbj006 name="construct.c.page1.pmbj006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj007
            #add-point:BEFORE FIELD pmbj007 name="construct.b.page1.pmbj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj007
            
            #add-point:AFTER FIELD pmbj007 name="construct.a.page1.pmbj007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmbj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj007
            #add-point:ON ACTION controlp INFIELD pmbj007 name="construct.c.page1.pmbj007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj008
            #add-point:BEFORE FIELD pmbj008 name="construct.b.page1.pmbj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj008
            
            #add-point:AFTER FIELD pmbj008 name="construct.a.page1.pmbj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmbj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj008
            #add-point:ON ACTION controlp INFIELD pmbj008 name="construct.c.page1.pmbj008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj015
            #add-point:BEFORE FIELD pmbj015 name="construct.b.page1.pmbj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj015
            
            #add-point:AFTER FIELD pmbj015 name="construct.a.page1.pmbj015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmbj015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj015
            #add-point:ON ACTION controlp INFIELD pmbj015 name="construct.c.page1.pmbj015"
            
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
 
{<section id="apmt005.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmt005_query()
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
   CALL g_pmbj_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL apmt005_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmt005_browser_fill(g_wc)
      CALL apmt005_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL apmt005_browser_fill("F")
   
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
      CALL apmt005_fetch("F") 
   END IF
   
   CALL apmt005_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="apmt005.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmt005_fetch(p_flag)
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
   
   #CALL apmt005_browser_fill(p_flag)
   
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
   
   LET g_pmbj_m.pmbjdocno = g_browser[g_current_idx].b_pmbjdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apmt005_master_referesh USING g_pmbj_m.pmbjdocno INTO g_pmbj_m.pmbjdocno,g_pmbj_m.pmbj001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "pmbj_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_pmbj_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_pmbj_m_mask_o.* =  g_pmbj_m.*
   CALL apmt005_pmbj_t_mask()
   LET g_pmbj_m_mask_n.* =  g_pmbj_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt005_set_act_visible()
   CALL apmt005_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_pmbj_m_t.* = g_pmbj_m.*
   LET g_pmbj_m_o.* = g_pmbj_m.*
   
   #重新顯示   
   CALL apmt005_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="apmt005.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmt005_insert()
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
   CALL g_pmbj_d.clear()
 
 
   INITIALIZE g_pmbj_m.* TO NULL             #DEFAULT 設定
   LET g_pmbjdocno_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      INITIALIZE g_pmbj_m_t.* TO NULL
      IF NOT cl_null(g_argv[02]) THEN
         LET g_pmbj_m.pmbjdocno = g_argv[02]
         CALL s_aooi200_get_slip_desc(g_pmbj_m.pmbjdocno) RETURNING g_pmbj_m.pmbjdocno_desc
         DISPLAY BY NAME g_pmbj_m.pmbjdocno,g_pmbj_m.pmbjdocno_desc
         CALL apmt005_pmbjdocno_ref(g_pmbj_m.pmbjdocno)
              RETURNING g_pmbj_m.pmbj001,g_pmbj_m.pmbal003,g_pmbj_m.pmaa002
         DISPLAY BY NAME g_pmbj_m.pmbj001,g_pmbj_m.pmbal003,g_pmbj_m.pmaa002
      END IF
      
      LET g_pmbj_m_t.* = g_pmbj_m.*
      #end add-point 
 
      CALL apmt005_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_pmbj_m.* TO NULL
         INITIALIZE g_pmbj_d TO NULL
 
         CALL apmt005_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pmbj_m.* = g_pmbj_m_t.*
         CALL apmt005_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_pmbj_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt005_set_act_visible()
   CALL apmt005_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pmbjdocno_t = g_pmbj_m.pmbjdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmbjent = " ||g_enterprise|| " AND",
                      " pmbjdocno = '", g_pmbj_m.pmbjdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt005_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL apmt005_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmt005_master_referesh USING g_pmbj_m.pmbjdocno INTO g_pmbj_m.pmbjdocno,g_pmbj_m.pmbj001
   
   #遮罩相關處理
   LET g_pmbj_m_mask_o.* =  g_pmbj_m.*
   CALL apmt005_pmbj_t_mask()
   LET g_pmbj_m_mask_n.* =  g_pmbj_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmbj_m.pmbjdocno,g_pmbj_m.pmbjdocno_desc,g_pmbj_m.pmbj001,g_pmbj_m.pmbal003,g_pmbj_m.pmaa002 
 
   
   #功能已完成,通報訊息中心
   CALL apmt005_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmt005.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmt005_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_pmbj_m.pmbjdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_pmbjdocno_t = g_pmbj_m.pmbjdocno
 
   CALL s_transaction_begin()
   
   OPEN apmt005_cl USING g_enterprise,g_pmbj_m.pmbjdocno
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt005_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE apmt005_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt005_master_referesh USING g_pmbj_m.pmbjdocno INTO g_pmbj_m.pmbjdocno,g_pmbj_m.pmbj001
   
   #遮罩相關處理
   LET g_pmbj_m_mask_o.* =  g_pmbj_m.*
   CALL apmt005_pmbj_t_mask()
   LET g_pmbj_m_mask_n.* =  g_pmbj_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL apmt005_show()
   WHILE TRUE
      LET g_pmbjdocno_t = g_pmbj_m.pmbjdocno
 
 
      #add-point:modify段修改前 name="modify.before_input"
      #LET g_pmbj_m.pmaa002 = g_argv[1]
      #LET g_pmbj_m_t.pmaa002 = g_pmbj_m.pmaa002
      #end add-point
      
      CALL apmt005_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pmbj_m.* = g_pmbj_m_t.*
         CALL apmt005_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_pmbj_m.pmbjdocno != g_pmbjdocno_t 
 
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
   CALL apmt005_set_act_visible()
   CALL apmt005_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmbjent = " ||g_enterprise|| " AND",
                      " pmbjdocno = '", g_pmbj_m.pmbjdocno, "' "
 
   #填到對應位置
   CALL apmt005_browser_fill("")
 
   CALL apmt005_idx_chk()
 
   CLOSE apmt005_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt005_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="apmt005.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmt005_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_oofa001             LIKE oofa_t.oofa001
   DEFINE  l_pmba000             LIKE pmba_t.pmba000
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
   DISPLAY BY NAME g_pmbj_m.pmbjdocno,g_pmbj_m.pmbjdocno_desc,g_pmbj_m.pmbj001,g_pmbj_m.pmbal003,g_pmbj_m.pmaa002 
 
   
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
   LET g_forupd_sql = "SELECT pmbjstus,pmbj003,pmbj002,pmbj009,pmbj010,pmbj011,pmbj012,pmbj013,pmbj014, 
       pmbj004,pmbj005,pmbj006,pmbj007,pmbj008,pmbj015 FROM pmbj_t WHERE pmbjent=? AND pmbjdocno=? AND  
       pmbj002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt005_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apmt005_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   #將單身輸入權限放入共用變數給嵌入的子程式用, 若子程式要自己控管, 還是可以從子程式中覆蓋掉值
   LET g_detail_insert = l_allow_insert
   LET g_detail_delete = l_allow_delete
   #end add-point
   CALL apmt005_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_pmbj_m.pmbjdocno,g_pmbj_m.pmbj001,g_pmbj_m.pmbal003,g_pmbj_m.pmaa002
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apmt005.input.head" >}
   
      #單頭段
      INPUT BY NAME g_pmbj_m.pmbjdocno,g_pmbj_m.pmbj001,g_pmbj_m.pmbal003,g_pmbj_m.pmaa002 
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
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbjdocno
            
            #add-point:AFTER FIELD pmbjdocno name="input.a.pmbjdocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF NOT cl_null(g_pmbj_m.pmbjdocno) THEN 
               IF p_cmd = 'a' OR 
                 (p_cmd = 'u' AND (g_pmbj_m.pmbjdocno != g_pmbjdocno_t OR g_pmbjdocno_t IS NULL)) THEN 
                 #160119-00011#1 add -----(S)
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM pmba_t
                   WHERE pmbaent = g_enterprise
                     AND pmbadocno = g_pmbj_m.pmbjdocno
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00264'   #申請單號不存在！
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                 #160119-00011#1 add -----(E)
                 
                  CALL apmt005_pmbjdocno_ref(g_pmbj_m.pmbjdocno)
                       RETURNING g_pmbj_m.pmbj001,g_pmbj_m.pmbal003,g_pmbj_m.pmaa002
                  DISPLAY BY NAME g_pmbj_m.pmbj001,g_pmbj_m.pmbal003,g_pmbj_m.pmaa002
                  
                  #複製交易對象聯絡人
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM pmaj_t WHERE pmajent = g_enterprise AND pmaj001 = g_pmbj_m.pmbj001
                  IF l_n > 0 THEN
                     CALL apmt005_pmaj_ins_pmbj(g_pmbj_m.pmbjdocno,g_pmbj_m.pmbj001) RETURNING l_success
                     IF NOT l_success THEN
                        LET g_pmbj_m.pmbj001 = g_pmbj_m_o.pmbj001
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbjdocno
            #add-point:BEFORE FIELD pmbjdocno name="input.b.pmbjdocno"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbjdocno
            #add-point:ON CHANGE pmbjdocno name="input.g.pmbjdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj001
            #add-point:BEFORE FIELD pmbj001 name="input.b.pmbj001"
#            IF NOT cl_null(g_argv[02]) THEN
#               CALL cl_set_comp_entry("pmbj001",FALSE)
#               NEXT FIELD pmbj003
#            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj001
            
            #add-point:AFTER FIELD pmbj001 name="input.a.pmbj001"
#            #此段落由子樣板a05產生
#            IF cl_null(g_argv[02]) THEN
#               LET g_pmbj_m.pmaal004 = ' '
#               LET g_pmbj_m.pmaa002 =  ' '
#               DISPLAY BY NAME g_pmbj_m.pmaal004,g_pmbj_m.pmaa002
#               
#               IF NOT cl_null(g_pmbj_m.pmbj001) THEN 
#                  IF p_cmd = 'a' OR 
#                    (p_cmd = 'u' AND (g_pmbj_m.pmbjdocno != g_pmbjdocno_t OR g_pmbjdocno_t IS NULL)) THEN
#                     IF NOT apmt005_pmbj001_chk(g_pmbj_m.pmbj001) THEN
#                        LET g_pmbj_m.pmbj001 = g_pmbj_m_t.pmbj001
#                        CALL apmt005_pmbj001_ref(g_pmbj_m.pmbj001) RETURNING g_pmbj_m.pmaa002,g_pmbj_m.pmaal004
#                        DISPLAY BY NAME g_pmbj_m.pmaa002,g_pmbj_m.pmaal004
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
#               END IF
#            END IF
#            CALL apmt005_pmbj001_ref(g_pmbj_m.pmbj001) RETURNING g_pmbj_m.pmaa002,g_pmbj_m.pmaal004
#            DISPLAY BY NAME g_pmbj_m.pmaa002,g_pmbj_m.pmaal004
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj001
            #add-point:ON CHANGE pmbj001 name="input.g.pmbj001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbal003
            #add-point:BEFORE FIELD pmbal003 name="input.b.pmbal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbal003
            
            #add-point:AFTER FIELD pmbal003 name="input.a.pmbal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbal003
            #add-point:ON CHANGE pmbal003 name="input.g.pmbal003"
            
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
                  #Ctrlp:input.c.pmbjdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbjdocno
            #add-point:ON ACTION controlp INFIELD pmbjdocno name="input.c.pmbjdocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i' 
            LET g_qryparam.reqry = FALSE
            #CALL q_pmbadocno()                       #呼叫開窗  #170213-00050#1 MARK
            CALL q_pmbadocno_1()                                #170213-00050#1 add
            LET g_pmbj_m.pmbjdocno = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_pmbj_m.pmbjdocno TO pmbjdocno       #顯示到畫面上
            #確認資料無重複
            IF NOT cl_null(g_pmbj_m.pmbjdocno) THEN 
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmbj_t WHERE "||"pmbjent = '" ||g_enterprise|| "' AND "||"pmbjdocno = '"||g_pmbj_m.pmbjdocno ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
               END IF               
            END IF
            NEXT FIELD pmbjdocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj001
            #add-point:ON ACTION controlp INFIELD pmbj001 name="input.c.pmbj001"
#            #此段落由子樣板a07產生            
#            #開窗i段
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.default1 = g_pmbj_m.pmbj001             #給予default值
#            CASE g_argv[1]
#               WHEN '1' LET g_qryparam.where= " (pmaa002 = '1' OR pmaa002 = '3') "
#               WHEN '2' LET g_qryparam.where= " (pmaa002 = '2' OR pmaa002 = '3') "
#               WHEN '3' LET g_qryparam.where= " (pmaa002 = '1' OR pmaa002 = '2' OR pmaa002 = '3') "
#            END CASE
#            CALL q_pmaa001_4()                               #呼叫開窗        
#            LET g_qryparam.where= " "
#            LET g_pmbj_m.pmbj001 = g_qryparam.return1        #將開窗取得的值回傳到變數
#            DISPLAY g_pmbj_m.pmbj001 TO pmbj001              #顯示到畫面上
#            CALL apmt005_pmbj001_ref(g_pmbj_m.pmbj001) RETURNING g_pmbj_m.pmaa002,g_pmbj_m.pmaal004
#            DISPLAY BY NAME g_pmbj_m.pmaa002,g_pmbj_m.pmaal004
#            NEXT FIELD pmbj001                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmbal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbal003
            #add-point:ON ACTION controlp INFIELD pmbal003 name="input.c.pmbal003"
            
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
            DISPLAY BY NAME g_pmbj_m.pmbjdocno             
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL apmt005_pmbj_t_mask_restore('restore_mask_o')
            
               UPDATE pmbj_t SET (pmbjdocno,pmbj001) = (g_pmbj_m.pmbjdocno,g_pmbj_m.pmbj001)
                WHERE pmbjent = g_enterprise AND pmbjdocno = g_pmbjdocno_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmbj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmbj_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmbj_m.pmbjdocno
               LET gs_keys_bak[1] = g_pmbjdocno_t
               LET gs_keys[2] = g_pmbj_d[g_detail_idx].pmbj002
               LET gs_keys_bak[2] = g_pmbj_d_t.pmbj002
               CALL apmt005_update_b('pmbj_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_pmbj_m_t)
                     #LET g_log2 = util.JSON.stringify(g_pmbj_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL apmt005_pmbj_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apmt005_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_pmbjdocno_t = g_pmbj_m.pmbjdocno
 
           
           IF g_pmbj_d.getLength() = 0 THEN
              NEXT FIELD pmbj002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="apmt005.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_pmbj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmbj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmt005_b_fill(g_wc2) #test 
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
            CALL apmt005_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN apmt005_cl USING g_enterprise,g_pmbj_m.pmbjdocno                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE apmt005_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN apmt005_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_pmbj_d[l_ac].pmbj002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pmbj_d_t.* = g_pmbj_d[l_ac].*  #BACKUP
               LET g_pmbj_d_o.* = g_pmbj_d[l_ac].*  #BACKUP
               CALL apmt005_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL apmt005_set_no_entry_b(l_cmd)
               OPEN apmt005_bcl USING g_enterprise,g_pmbj_m.pmbjdocno,
 
                                                g_pmbj_d_t.pmbj002
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN apmt005_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt005_bcl INTO g_pmbj_d[l_ac].pmbjstus,g_pmbj_d[l_ac].pmbj003,g_pmbj_d[l_ac].pmbj002, 
                      g_pmbj_d[l_ac].pmbj009,g_pmbj_d[l_ac].pmbj010,g_pmbj_d[l_ac].pmbj011,g_pmbj_d[l_ac].pmbj012, 
                      g_pmbj_d[l_ac].pmbj013,g_pmbj_d[l_ac].pmbj014,g_pmbj_d[l_ac].pmbj004,g_pmbj_d[l_ac].pmbj005, 
                      g_pmbj_d[l_ac].pmbj006,g_pmbj_d[l_ac].pmbj007,g_pmbj_d[l_ac].pmbj008,g_pmbj_d[l_ac].pmbj015 
 
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_pmbj_d_t.pmbj002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pmbj_d_mask_o[l_ac].* =  g_pmbj_d[l_ac].*
                  CALL apmt005_pmbj_t_mask()
                  LET g_pmbj_d_mask_n[l_ac].* =  g_pmbj_d[l_ac].*
                  
                  CALL apmt005_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF l_cmd = 'u' THEN
               LET g_pmaa027_d = g_pmbj_d[l_ac].pmbj002
               IF NOT cl_null(g_pmbj_d[l_ac].pmbj002) THEN
                  CALL aooi350_01_b_fill(g_pmbj_d[l_ac].pmbj002)            
                  CALL aooi350_02_b_fill(g_pmbj_d[l_ac].pmbj002)
               END IF
            END IF
            #end add-point  
            
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_pmbj_d_t.* TO NULL
            INITIALIZE g_pmbj_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmbj_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmbj_d[l_ac].pmbjstus = ''
 
 
  
            #一般欄位預設值
                  LET g_pmbj_d[l_ac].pmbjstus = "Y"
      LET g_pmbj_d[l_ac].pmbj004 = "N"
      LET g_pmbj_d[l_ac].pmbj005 = "N"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_pmbj_d_t.* = g_pmbj_d[l_ac].*     #新輸入資料
            LET g_pmbj_d_o.* = g_pmbj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmt005_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL apmt005_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmbj_d[li_reproduce_target].* = g_pmbj_d[li_reproduce].*
 
               LET g_pmbj_d[g_pmbj_d.getLength()].pmbj002 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_pmbj_d[l_ac].pmbj002 = " "
            LET g_pmbj_d_t.* = g_pmbj_d[l_ac].* 
            
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
            SELECT COUNT(1) INTO l_count FROM pmbj_t 
             WHERE pmbjent = g_enterprise AND pmbjdocno = g_pmbj_m.pmbjdocno
 
               AND pmbj002 = g_pmbj_d[l_ac].pmbj002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO pmbj_t
                           (pmbjent,
                            pmbjdocno,pmbj001,
                            pmbj002
                            ,pmbjstus,pmbj003,pmbj009,pmbj010,pmbj011,pmbj012,pmbj013,pmbj014,pmbj004,pmbj005,pmbj006,pmbj007,pmbj008,pmbj015) 
                     VALUES(g_enterprise,
                            g_pmbj_m.pmbjdocno,g_pmbj_m.pmbj001,
                            g_pmbj_d[l_ac].pmbj002
                            ,g_pmbj_d[l_ac].pmbjstus,g_pmbj_d[l_ac].pmbj003,g_pmbj_d[l_ac].pmbj009,g_pmbj_d[l_ac].pmbj010, 
                                g_pmbj_d[l_ac].pmbj011,g_pmbj_d[l_ac].pmbj012,g_pmbj_d[l_ac].pmbj013, 
                                g_pmbj_d[l_ac].pmbj014,g_pmbj_d[l_ac].pmbj004,g_pmbj_d[l_ac].pmbj005, 
                                g_pmbj_d[l_ac].pmbj006,g_pmbj_d[l_ac].pmbj007,g_pmbj_d[l_ac].pmbj008, 
                                g_pmbj_d[l_ac].pmbj015)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_pmbj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "pmbj_t:",SQLERRMESSAGE 
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
               CALL s_aooi350_ins_oofa('4',g_pmbj_m.pmbjdocno,g_pmbj_d[l_ac].pmbj012) RETURNING l_success,l_oofa001
               IF l_success THEN
                  UPDATE pmbj_t SET pmbj002 = l_oofa001
                   WHERE pmbjent = g_enterprise
                     AND pmbjdocno = g_pmbj_m.pmbjdocno
                     AND pmbj002 = g_pmbj_d[l_ac].pmbj002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmbj_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL INSERT
                  END IF
                  LET g_pmbj_d[l_ac].pmbj002 = l_oofa001
                  LET g_pmaa027_d = g_pmbj_d[l_ac].pmbj002
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pmbj_t"
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
               IF apmt005_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_pmbj_m.pmbjdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pmbj_d_t.pmbj002
 
 
                  #刪除下層單身
                  IF NOT apmt005_key_delete_b(gs_keys,'pmbj_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE apmt005_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE apmt005_bcl
               LET l_count = g_pmbj_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_pmbj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbjstus
            #add-point:BEFORE FIELD pmbjstus name="input.b.page1.pmbjstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbjstus
            
            #add-point:AFTER FIELD pmbjstus name="input.a.page1.pmbjstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbjstus
            #add-point:ON CHANGE pmbjstus name="input.g.page1.pmbjstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj003
            
            #add-point:AFTER FIELD pmbj003 name="input.a.page1.pmbj003"
            CALL apmt005_pmbj003_ref(g_pmbj_d[l_ac].pmbj003) RETURNING g_pmbj_d[l_ac].pmbj003_desc
            DISPLAY BY NAME g_pmbj_d[l_ac].pmbj003_desc
            
            IF NOT cl_null(g_pmbj_d[l_ac].pmbj003) THEN 
               IF l_cmd = 'a' OR 
                 (l_cmd = 'u' AND (g_pmbj_d[l_ac].pmbj003 != g_pmbj_d_t.pmbj003 OR g_pmbj_d_t.pmbj003 IS NULL)) THEN  
                  IF NOT s_azzi650_chk_exist('259',g_pmbj_d[l_ac].pmbj003) THEN
                     LET g_pmbj_d[l_ac].pmbj003 = g_pmbj_d_t.pmbj003
                     CALL apmt005_pmbj003_ref(g_pmbj_d[l_ac].pmbj003) RETURNING g_pmbj_d[l_ac].pmbj003_desc
                     DISPLAY BY NAME g_pmbj_d[l_ac].pmbj003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj003
            #add-point:BEFORE FIELD pmbj003 name="input.b.page1.pmbj003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj003
            #add-point:ON CHANGE pmbj003 name="input.g.page1.pmbj003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj002
            #add-point:BEFORE FIELD pmbj002 name="input.b.page1.pmbj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj002
            
            #add-point:AFTER FIELD pmbj002 name="input.a.page1.pmbj002"
#            #此段落由子樣板a05產生
#            IF NOT cl_null(g_pmbj_m.pmbj001) AND NOT cl_null(g_pmbj_d[l_ac].pmbj002) THEN 
#               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmbj_m.pmbjdocno != g_pmbjdocno_t OR g_pmbj_d[l_ac].pmbj002 != g_pmbj_d_t.pmbj002)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmbj_t WHERE "||"pmbjent = '" ||g_enterprise|| "' AND "||"pmbj001 = '"||g_pmbj_m.pmbj001 ||"' AND "|| "pmbj002 = '"||g_pmbj_d[l_ac].pmbj002 ||"'",'std-00004',0) THEN 
#                     LET g_pmbj_d[l_ac].pmbj002 = g_pmbj_d_t.pmbj002
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj002
            #add-point:ON CHANGE pmbj002 name="input.g.page1.pmbj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj009
            #add-point:BEFORE FIELD pmbj009 name="input.b.page1.pmbj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj009
            
            #add-point:AFTER FIELD pmbj009 name="input.a.page1.pmbj009"
            IF apmt005_pmbj012_chk(g_pmbj_d[l_ac].pmbj009,g_pmbj_d[l_ac].pmbj010,g_pmbj_d[l_ac].pmbj011) THEN
               CALL s_aooi350_gen_fullname(g_site,g_pmbj_d[l_ac].pmbj009,g_pmbj_d[l_ac].pmbj010,g_pmbj_d[l_ac].pmbj011)
                    RETURNING l_success,g_pmbj_d[l_ac].pmbj012
               DISPLAY BY NAME g_pmbj_d[l_ac].pmbj012
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj009
            #add-point:ON CHANGE pmbj009 name="input.g.page1.pmbj009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj010
            #add-point:BEFORE FIELD pmbj010 name="input.b.page1.pmbj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj010
            
            #add-point:AFTER FIELD pmbj010 name="input.a.page1.pmbj010"
            IF apmt005_pmbj012_chk(g_pmbj_d[l_ac].pmbj009,g_pmbj_d[l_ac].pmbj010,g_pmbj_d[l_ac].pmbj011) THEN
               CALL s_aooi350_gen_fullname(g_site,g_pmbj_d[l_ac].pmbj009,g_pmbj_d[l_ac].pmbj010,g_pmbj_d[l_ac].pmbj011)
                    RETURNING l_success,g_pmbj_d[l_ac].pmbj012
               DISPLAY BY NAME g_pmbj_d[l_ac].pmbj012
            END IF           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj010
            #add-point:ON CHANGE pmbj010 name="input.g.page1.pmbj010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj011
            #add-point:BEFORE FIELD pmbj011 name="input.b.page1.pmbj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj011
            
            #add-point:AFTER FIELD pmbj011 name="input.a.page1.pmbj011"
            IF apmt005_pmbj012_chk(g_pmbj_d[l_ac].pmbj009,g_pmbj_d[l_ac].pmbj010,g_pmbj_d[l_ac].pmbj011) THEN
               CALL s_aooi350_gen_fullname(g_site,g_pmbj_d[l_ac].pmbj009,g_pmbj_d[l_ac].pmbj010,g_pmbj_d[l_ac].pmbj011)
                    RETURNING l_success,g_pmbj_d[l_ac].pmbj012
               DISPLAY BY NAME g_pmbj_d[l_ac].pmbj012
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj011
            #add-point:ON CHANGE pmbj011 name="input.g.page1.pmbj011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj012
            #add-point:BEFORE FIELD pmbj012 name="input.b.page1.pmbj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj012
            
            #add-point:AFTER FIELD pmbj012 name="input.a.page1.pmbj012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj012
            #add-point:ON CHANGE pmbj012 name="input.g.page1.pmbj012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj013
            #add-point:BEFORE FIELD pmbj013 name="input.b.page1.pmbj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj013
            
            #add-point:AFTER FIELD pmbj013 name="input.a.page1.pmbj013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj013
            #add-point:ON CHANGE pmbj013 name="input.g.page1.pmbj013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj014
            #add-point:BEFORE FIELD pmbj014 name="input.b.page1.pmbj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj014
            
            #add-point:AFTER FIELD pmbj014 name="input.a.page1.pmbj014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj014
            #add-point:ON CHANGE pmbj014 name="input.g.page1.pmbj014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj004
            #add-point:BEFORE FIELD pmbj004 name="input.b.page1.pmbj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj004
            
            #add-point:AFTER FIELD pmbj004 name="input.a.page1.pmbj004"
            IF g_pmbj_d[l_ac].pmbj004 = 'Y' THEN
               IF l_cmd = 'a' OR 
                 (l_cmd = 'u' AND (g_pmbj_d[l_ac].pmbj004 != g_pmbj_d_t.pmbj004 OR g_pmbj_d_t.pmbj004 IS NULL)) THEN 
                  IF NOT apmt005_pmbj004_chk() THEN
                     LET g_pmbj_d[l_ac].pmbj004 = g_pmbj_d_t.pmbj004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj004
            #add-point:ON CHANGE pmbj004 name="input.g.page1.pmbj004"
            IF g_pmbj_d[l_ac].pmbj004 = 'Y' THEN
               IF l_cmd = 'a' OR
                 (l_cmd = 'u' AND (g_pmbj_d[l_ac].pmbj004 != g_pmbj_d_t.pmbj004 OR g_pmbj_d_t.pmbj004 IS NULL)) THEN
                  IF NOT apmt005_pmbj004_chk() THEN
                     LET g_pmbj_d[l_ac].pmbj004 = g_pmbj_d_t.pmbj004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj005
            #add-point:BEFORE FIELD pmbj005 name="input.b.page1.pmbj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj005
            
            #add-point:AFTER FIELD pmbj005 name="input.a.page1.pmbj005"
            IF g_pmbj_d[l_ac].pmbj005 = 'Y' THEN
               IF l_cmd = 'a' OR
                 (l_cmd = 'u' AND (g_pmbj_d[l_ac].pmbj005 != g_pmbj_d_t.pmbj005 OR g_pmbj_d_t.pmbj005 IS NULL)) THEN               
                  IF NOT apmt005_pmbj005_chk() THEN
                     LET g_pmbj_d[l_ac].pmbj005 = g_pmbj_d_t.pmbj005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj005
            #add-point:ON CHANGE pmbj005 name="input.g.page1.pmbj005"
            IF g_pmbj_d[l_ac].pmbj005 = 'Y' THEN
               IF l_cmd = 'a' OR
                 (l_cmd = 'u' AND (g_pmbj_d[l_ac].pmbj005 != g_pmbj_d_t.pmbj005 OR g_pmbj_d_t.pmbj005 IS NULL)) THEN  
                  IF NOT apmt005_pmbj005_chk() THEN
                     LET g_pmbj_d[l_ac].pmbj005 = g_pmbj_d_t.pmbj005
                     NEXT FIELD CURRENT
                   END IF
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj006
            #add-point:BEFORE FIELD pmbj006 name="input.b.page1.pmbj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj006
            
            #add-point:AFTER FIELD pmbj006 name="input.a.page1.pmbj006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj006
            #add-point:ON CHANGE pmbj006 name="input.g.page1.pmbj006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj007
            #add-point:BEFORE FIELD pmbj007 name="input.b.page1.pmbj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj007
            
            #add-point:AFTER FIELD pmbj007 name="input.a.page1.pmbj007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj007
            #add-point:ON CHANGE pmbj007 name="input.g.page1.pmbj007"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj008
            #add-point:BEFORE FIELD pmbj008 name="input.b.page1.pmbj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj008
            
            #add-point:AFTER FIELD pmbj008 name="input.a.page1.pmbj008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj008
            #add-point:ON CHANGE pmbj008 name="input.g.page1.pmbj008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbj015
            #add-point:BEFORE FIELD pmbj015 name="input.b.page1.pmbj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbj015
            
            #add-point:AFTER FIELD pmbj015 name="input.a.page1.pmbj015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbj015
            #add-point:ON CHANGE pmbj015 name="input.g.page1.pmbj015"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pmbjstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbjstus
            #add-point:ON ACTION controlp INFIELD pmbjstus name="input.c.page1.pmbjstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmbj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj003
            #add-point:ON ACTION controlp INFIELD pmbj003 name="input.c.page1.pmbj003"
            #此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmbj_d[l_ac].pmbj003       #給予default值
            #給予arg
            LET g_qryparam.arg1 = "259"                            #應用分類
            CALL q_oocq002()                                       #呼叫開窗
            LET g_pmbj_d[l_ac].pmbj003 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL apmt005_pmbj003_ref(g_pmbj_d[l_ac].pmbj003) RETURNING g_pmbj_d[l_ac].pmbj003_desc
            DISPLAY BY NAME g_pmbj_d[l_ac].pmbj003_desc
            DISPLAY g_pmbj_d[l_ac].pmbj003 TO pmbj003              #顯示到畫面上
            NEXT FIELD pmbj003                                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmbj002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj002
            #add-point:ON ACTION controlp INFIELD pmbj002 name="input.c.page1.pmbj002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmbj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj009
            #add-point:ON ACTION controlp INFIELD pmbj009 name="input.c.page1.pmbj009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmbj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj010
            #add-point:ON ACTION controlp INFIELD pmbj010 name="input.c.page1.pmbj010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmbj011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj011
            #add-point:ON ACTION controlp INFIELD pmbj011 name="input.c.page1.pmbj011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmbj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj012
            #add-point:ON ACTION controlp INFIELD pmbj012 name="input.c.page1.pmbj012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmbj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj013
            #add-point:ON ACTION controlp INFIELD pmbj013 name="input.c.page1.pmbj013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmbj014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj014
            #add-point:ON ACTION controlp INFIELD pmbj014 name="input.c.page1.pmbj014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmbj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj004
            #add-point:ON ACTION controlp INFIELD pmbj004 name="input.c.page1.pmbj004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmbj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj005
            #add-point:ON ACTION controlp INFIELD pmbj005 name="input.c.page1.pmbj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmbj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj006
            #add-point:ON ACTION controlp INFIELD pmbj006 name="input.c.page1.pmbj006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmbj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj007
            #add-point:ON ACTION controlp INFIELD pmbj007 name="input.c.page1.pmbj007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmbj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj008
            #add-point:ON ACTION controlp INFIELD pmbj008 name="input.c.page1.pmbj008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmbj015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbj015
            #add-point:ON ACTION controlp INFIELD pmbj015 name="input.c.page1.pmbj015"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pmbj_d[l_ac].* = g_pmbj_d_t.*
               CLOSE apmt005_bcl
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
               LET g_errparam.extend = g_pmbj_d[l_ac].pmbj002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_pmbj_d[l_ac].* = g_pmbj_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL apmt005_pmbj_t_mask_restore('restore_mask_o')
         
               UPDATE pmbj_t SET (pmbjdocno,pmbjstus,pmbj003,pmbj002,pmbj009,pmbj010,pmbj011,pmbj012, 
                   pmbj013,pmbj014,pmbj004,pmbj005,pmbj006,pmbj007,pmbj008,pmbj015) = (g_pmbj_m.pmbjdocno, 
                   g_pmbj_d[l_ac].pmbjstus,g_pmbj_d[l_ac].pmbj003,g_pmbj_d[l_ac].pmbj002,g_pmbj_d[l_ac].pmbj009, 
                   g_pmbj_d[l_ac].pmbj010,g_pmbj_d[l_ac].pmbj011,g_pmbj_d[l_ac].pmbj012,g_pmbj_d[l_ac].pmbj013, 
                   g_pmbj_d[l_ac].pmbj014,g_pmbj_d[l_ac].pmbj004,g_pmbj_d[l_ac].pmbj005,g_pmbj_d[l_ac].pmbj006, 
                   g_pmbj_d[l_ac].pmbj007,g_pmbj_d[l_ac].pmbj008,g_pmbj_d[l_ac].pmbj015)
                WHERE pmbjent = g_enterprise AND pmbjdocno = g_pmbj_m.pmbjdocno 
 
                 AND pmbj002 = g_pmbj_d_t.pmbj002 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmbj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "pmbj_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmbj_m.pmbjdocno
               LET gs_keys_bak[1] = g_pmbjdocno_t
               LET gs_keys[2] = g_pmbj_d[g_detail_idx].pmbj002
               LET gs_keys_bak[2] = g_pmbj_d_t.pmbj002
               CALL apmt005_update_b('pmbj_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_pmbj_m),util.JSON.stringify(g_pmbj_d_t)
                     LET g_log2 = util.JSON.stringify(g_pmbj_m),util.JSON.stringify(g_pmbj_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL apmt005_pmbj_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_pmbj_m.pmbjdocno
 
               LET ls_keys[ls_keys.getLength()+1] = g_pmbj_d_t.pmbj002
 
               CALL apmt005_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               LET g_pmaa027_d = g_pmbj_d[l_ac].pmbj002
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE apmt005_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pmbj_d[l_ac].* = g_pmbj_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE apmt005_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_pmbj_d.getLength() = 0 THEN
               NEXT FIELD pmbj002
            END IF
            #add-point:input段after input  name="input.body.after_input"
 
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_pmbj_d[li_reproduce_target].* = g_pmbj_d[li_reproduce].*
 
               LET g_pmbj_d[li_reproduce_target].pmbj002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pmbj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pmbj_d.getLength()+1
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
                  IF NOT cl_null(g_pmbj_d[l_ac].pmbj002) THEN
                     CALL aooi350_01(g_pmbj_d[l_ac].pmbj002)
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
                  IF NOT cl_null(g_pmbj_d[l_ac].pmbj002) THEN
                     CALL aooi350_02(g_pmbj_d[l_ac].pmbj002)
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
            NEXT FIELD pmbjdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pmbjstus
 
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
 
{<section id="apmt005.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apmt005_show()
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
      CALL apmt005_b_fill(g_wc2) #第一階單身填充
      CALL apmt005_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apmt005_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_pmbj_m.pmbjdocno,g_pmbj_m.pmbjdocno_desc,g_pmbj_m.pmbj001,g_pmbj_m.pmbal003,g_pmbj_m.pmaa002 
 
 
   CALL apmt005_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
 
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="apmt005.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION apmt005_ref_show()
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
   CALL apmt005_pmbjdocno_ref(g_pmbj_m.pmbjdocno)
        RETURNING g_pmbj_m.pmbj001,g_pmbj_m.pmaa002,g_pmbj_m.pmbal003
   DISPLAY BY NAME g_pmbj_m.pmbj001,g_pmbj_m.pmaa002,g_pmbj_m.pmbal003
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_pmbj_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="apmt005.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmt005_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE pmbj_t.pmbjdocno 
   DEFINE l_oldno     LIKE pmbj_t.pmbjdocno 
 
   DEFINE l_master    RECORD LIKE pmbj_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pmbj_t.* #此變數樣板目前無使用
 
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
 
   IF g_pmbj_m.pmbjdocno IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_pmbjdocno_t = g_pmbj_m.pmbjdocno
 
   
   LET g_pmbj_m.pmbjdocno = ""
 
   LET g_master_insert = FALSE
   CALL apmt005_set_entry('a')
   CALL apmt005_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_pmbj_m.pmbal003 = ""
   LET g_pmbj_m.pmaa002 = ""
   DISPLAY BY NAME g_pmbj_m.pmbal003,g_pmbj_m.pmaa002
   #end add-point
   
   #清空key欄位的desc
      LET g_pmbj_m.pmbjdocno_desc = ''
   DISPLAY BY NAME g_pmbj_m.pmbjdocno_desc
 
   
   CALL apmt005_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_pmbj_m.* TO NULL
      INITIALIZE g_pmbj_d TO NULL
 
      CALL apmt005_show()
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
   CALL apmt005_set_act_visible()
   CALL apmt005_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pmbjdocno_t = g_pmbj_m.pmbjdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmbjent = " ||g_enterprise|| " AND",
                      " pmbjdocno = '", g_pmbj_m.pmbjdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt005_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL apmt005_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL apmt005_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="apmt005.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apmt005_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pmbj_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apmt005_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmbj_t
    WHERE pmbjent = g_enterprise AND pmbjdocno = g_pmbjdocno_t
 
       INTO TEMP apmt005_detail
   
   #將key修正為調整後   
   UPDATE apmt005_detail 
      #更新key欄位
      SET pmbjdocno = g_pmbj_m.pmbjdocno
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
      #, pmbjstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO pmbj_t SELECT * FROM apmt005_detail
   
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
   DROP TABLE apmt005_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pmbjdocno_t = g_pmbj_m.pmbjdocno
 
   
   DROP TABLE apmt005_detail
   
END FUNCTION
 
{</section>}
 
{<section id="apmt005.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apmt005_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_pmbj002       LIKE pmbj_t.pmbj002
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_pmbj_m.pmbjdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN apmt005_cl USING g_enterprise,g_pmbj_m.pmbjdocno
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt005_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE apmt005_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt005_master_referesh USING g_pmbj_m.pmbjdocno INTO g_pmbj_m.pmbjdocno,g_pmbj_m.pmbj001
   
   #遮罩相關處理
   LET g_pmbj_m_mask_o.* =  g_pmbj_m.*
   CALL apmt005_pmbj_t_mask()
   LET g_pmbj_m_mask_n.* =  g_pmbj_m.*
   
   CALL apmt005_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmt005_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      DELETE FROM oofb_t
       WHERE oofbent = g_enterprise
         AND oofb002 IN (SELECT oofa001 FROM oofa_t WHERE oofaent = g_enterprise
                                                      AND oofa002 = '4'
                                                      AND oofa003 = g_pmbj_m.pmbjdocno)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oofb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF

      DELETE FROM oofc_t
       WHERE oofcent = g_enterprise
         AND oofc002 IN (SELECT oofa001 FROM oofa_t WHERE oofaent = g_enterprise
                                                      AND oofa002 = '4'
                                                      AND oofa003 = g_pmbj_m.pmbjdocno)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oofc_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF

      DELETE FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '4' AND oofa003 = g_pmbj_m.pmbjdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oofa_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF
      #end add-point
      
      DELETE FROM pmbj_t WHERE pmbjent = g_enterprise AND pmbjdocno = g_pmbj_m.pmbjdocno
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmbj_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      CALL aooi350_01_clear_detail()   #清除聯絡地址
      CALL aooi350_02_clear_detail()   #清除通訊方式
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE apmt005_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_pmbj_d.clear() 
 
     
      CALL apmt005_ui_browser_refresh()  
      #CALL apmt005_ui_headershow()  
      #CALL apmt005_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL apmt005_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL apmt005_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE apmt005_cl
 
   #功能已完成,通報訊息中心
   CALL apmt005_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apmt005.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmt005_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_cnt_t    LIKE type_t.num10
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_pmbj_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT pmbjstus,pmbj003,pmbj002,pmbj009,pmbj010,pmbj011,pmbj012,pmbj013,pmbj014, 
       pmbj004,pmbj005,pmbj006,pmbj007,pmbj008,pmbj015,t1.oocql004 FROM pmbj_t",   
               "",
               
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='259' AND t1.oocql002=pmbj003 AND t1.oocql003='"||g_dlang||"' ",
 
               " WHERE pmbjent= ? AND pmbjdocno=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("pmbj_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF apmt005_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY pmbj_t.pmbj002"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmt005_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apmt005_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pmbj_m.pmbjdocno   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pmbj_m.pmbjdocno INTO g_pmbj_d[l_ac].pmbjstus,g_pmbj_d[l_ac].pmbj003, 
          g_pmbj_d[l_ac].pmbj002,g_pmbj_d[l_ac].pmbj009,g_pmbj_d[l_ac].pmbj010,g_pmbj_d[l_ac].pmbj011, 
          g_pmbj_d[l_ac].pmbj012,g_pmbj_d[l_ac].pmbj013,g_pmbj_d[l_ac].pmbj014,g_pmbj_d[l_ac].pmbj004, 
          g_pmbj_d[l_ac].pmbj005,g_pmbj_d[l_ac].pmbj006,g_pmbj_d[l_ac].pmbj007,g_pmbj_d[l_ac].pmbj008, 
          g_pmbj_d[l_ac].pmbj015,g_pmbj_d[l_ac].pmbj003_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
 
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
 
            CALL g_pmbj_d.deleteElement(g_pmbj_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
 
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_pmbj_d.getLength()
      LET g_pmbj_d_mask_o[l_ac].* =  g_pmbj_d[l_ac].*
      CALL apmt005_pmbj_t_mask()
      LET g_pmbj_d_mask_n[l_ac].* =  g_pmbj_d[l_ac].*
   END FOR
   
 
 
   FREE apmt005_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="apmt005.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apmt005_idx_chk()
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
      IF g_detail_idx > g_pmbj_d.getLength() THEN
         LET g_detail_idx = g_pmbj_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_pmbj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmbj_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmt005.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmt005_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_pmbj_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
      LET g_detail_idx = 1
   END IF      
   CALL aooi350_01_clear_detail()   #清除聯絡地址
   CALL aooi350_02_clear_detail()   #清除通訊方式
   #取得通訊地址, 聯絡方式單身資料
   IF NOT cl_null(g_pmbj_d[g_detail_idx].pmbj002) THEN
      CALL aooi350_01_b_fill(g_pmbj_d[g_detail_idx].pmbj002)
      CALL aooi350_02_b_fill(g_pmbj_d[g_detail_idx].pmbj002)
   END IF
   LET g_pmaa027_d = g_pmbj_d[g_detail_idx].pmbj002
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apmt005.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION apmt005_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM pmbj_t
    WHERE pmbjent = g_enterprise AND pmbjdocno = g_pmbj_m.pmbjdocno AND
 
          pmbj002 = g_pmbj_d_t.pmbj002
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "pmbj_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後 name="delete.body.a_single_delete"
   IF NOT s_aooi350_del(g_pmbj_d_t.pmbj002) THEN
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
 
{<section id="apmt005.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apmt005_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="apmt005.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apmt005_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="apmt005.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apmt005_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="apmt005.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION apmt005_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_pmbj_d[l_ac].pmbj002 = g_pmbj_d_t.pmbj002 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmt005.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apmt005_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apmt005.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apmt005_lock_b(ps_table,ps_page)
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
   #CALL apmt005_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apmt005.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apmt005_unlock_b(ps_table,ps_page)
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
 
{<section id="apmt005.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmt005_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pmbjdocno",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("pmbjdocno,pmbj001",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt005.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmt005_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pmbjdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT cl_null(g_argv[02]) THEN
      CALL cl_set_comp_entry("pmbjdocno,pmbj001",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt005.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apmt005_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmt005.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apmt005_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="apmt005.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmt005_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("insert,query",TRUE)
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmt005.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmt005_set_act_no_visible()
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
 
{<section id="apmt005.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apmt005_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
 
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmt005.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apmt005_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmt005.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmt005_default_search()
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
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " pmbjdocno = '", g_argv[02], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
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
   IF NOT cl_null(g_argv[1]) THEN
      #若pmbj001為NULL，就不只單獨出現在某一支申請作業中，而是交易對象/客戶/供應商的申請作業都能查到
      LET g_wc = g_wc CLIPPED," AND ",
                 "(pmbj001 IS NULL OR",
                 " pmbj001 IN (SELECT pmba001 FROM pmba_t WHERE pmbaent = ",g_enterprise
      CASE g_argv[1] 
         WHEN '1' LET g_wc = g_wc ," AND (pmba002 = '1' OR pmba002 = '3') ) "
         WHEN '2' LET g_wc = g_wc ," AND (pmba002 = '2' OR pmba002 = '3') ) "
         WHEN '3' LET g_wc = g_wc ," AND (pmba002 = '1' OR pmba002 = '2' OR pmba002 = '3') ) "
      END CASE
   ELSE
      LET g_wc = " 1=1"
   END IF         
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmt005.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apmt005_fill_chk(ps_idx)
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
 
{<section id="apmt005.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION apmt005_modify_detail_chk(ps_record)
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
         LET ls_return = "pmbjstus"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="apmt005.mask_functions" >}
&include "erp/apm/apmt005_mask.4gl"
 
{</section>}
 
{<section id="apmt005.state_change" >}
    
 
{</section>}
 
{<section id="apmt005.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmt005_set_pk_array()
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
   LET g_pk_array[1].values = g_pmbj_m.pmbjdocno
   LET g_pk_array[1].column = 'pmbjdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt005.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmt005_msgcentre_notify(lc_state)
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
   CALL apmt005_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmbj_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt005.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION apmt005_pmbj001_chk(p_pmbj001)
DEFINE p_pmbj001    LIKE pmbj_t.pmbj001
DEFINE r_success    LIKE type_t.num5
DEFINE l_pmbj002    LIKE pmbj_t.pmbj002

   LET r_success = TRUE
   
   IF g_argv[1] = '1' THEN     
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL   
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = p_pmbj001   
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
      LET g_chkparam.arg1 = p_pmbj001   
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
      LET g_chkparam.arg1 = p_pmbj001
      LET g_errshow = TRUE   #160318-00025#49
      LET g_chkparam.err_str[1] = "apm-00029:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"    #160318-00025#49      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_pmaa001_6") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmbj_t WHERE "||"pmbjent = '" ||g_enterprise|| "' AND "||"pmbj001 = '"||p_pmbj001 ||"'",'std-00004',1) THEN 
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
      
END FUNCTION
#+
PRIVATE FUNCTION apmt005_pmbj001_ref(p_pmbjdocno,p_pmbj001)
DEFINE p_pmbjdocno    LIKE pmbj_t.pmbjdocno
DEFINE p_pmbj001      LIKE pmbj_t.pmbj001
DEFINE r_pmaa002      LIKE pmaa_t.pmaa002
DEFINE r_pmbal003     LIKE pmbal_t.pmbal003

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmbjdocno
   CALL ap_ref_array2(g_ref_fields,"SELECT pmbal003 FROM pmbal_t WHERE pmbalent='"||g_enterprise||"' AND pmbaldocno=? AND pmbal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_pmbal003 = g_rtn_fields[1]
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmbj001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmba002 FROM pmba_t WHERE pmbaent='"||g_enterprise||"' AND pmba001=? ","") RETURNING g_rtn_fields
   LET r_pmaa002 = g_rtn_fields[1]
   
   RETURN r_pmaa002,r_pmbal003
      
END FUNCTION
#+不可多次勾選財務主要聯絡人
PRIVATE FUNCTION apmt005_pmbj005_chk()
DEFINE l_n         LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5
 
   LET l_n = 0
   LET r_success = TRUE
   
   SELECT COUNT(*) INTO l_n FROM pmbj_t
    WHERE pmbjent = g_enterprise AND pmbjdocno = g_pmbj_m.pmbjdocno AND pmbj005 = 'Y'
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00049'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
       
END FUNCTION
#+不可勾選多個主要聯絡人
PRIVATE FUNCTION apmt005_pmbj004_chk()
DEFINE l_n         LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5
 
   LET l_n = 0
   LET r_success = TRUE
   
   SELECT COUNT(*) INTO l_n FROM pmbj_t
    WHERE pmbjent = g_enterprise AND pmbjdocno = g_pmbj_m.pmbjdocno AND pmbj004 = 'Y'
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00048'      
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION apmt005_set_title_visible()
DEFINE l_gzze003   LIKE gzze_t.gzze003

   IF NOT cl_null(g_argv[1]) THEN
      IF g_argv[1] = '1' THEN
         LET l_gzze003 = ' '
         SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00050' AND gzze002 = g_dlang
         CALL cl_set_comp_att_text('pmbj001',l_gzze003)
         LET l_gzze003 = ' '
         SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00051' AND gzze002 = g_dlang
         CALL cl_set_comp_att_text('pmbal003',l_gzze003)
      END IF
      
      IF g_argv[1] = '2' THEN
         LET l_gzze003 = ' '
         SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00052' AND gzze002 = g_dlang
         CALL cl_set_comp_att_text('pmbj001',l_gzze003)
         LET l_gzze003 = ' '
         SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00053' AND gzze002 = g_dlang
         CALL cl_set_comp_att_text('pmbal003',l_gzze003)
      END IF
   END IF
   
END FUNCTION

PRIVATE FUNCTION apmt005_pmbj003_ref(p_pmbj003)
DEFINE p_pmbj003      LIKE pmbj_t.pmbj003
DEFINE r_oocql004     LIKE oocql_t.oocql004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmbj003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='259' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_oocql004 = g_rtn_fields[1]
   
   RETURN r_oocql004
      
END FUNCTION

################################################################################
# Descriptions...: 依據申請單號帶出交易對象資料
# Memo...........:
# Usage..........: CALL apmt005_pmbjdocno_ref(p_pmbjdocno)
#                       RETURNING r_pmba001,r_pmbal003,r_pmaa002
# Input parameter: p_pmbjdocno    申請單號
# Return code....: r_pmba001      交易對象編號
#                  r_pmbal003     交易對象簡稱
#                  r_pmaa002      交易對象類型
# Date & Author..: 15/09/15 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt005_pmbjdocno_ref(p_pmbjdocno)
DEFINE p_pmbjdocno    LIKE pmbj_t.pmbjdocno
DEFINE r_pmba001      LIKE pmba_t.pmba001
DEFINE r_pmba002      LIKE pmba_t.pmba002
DEFINE r_pmbal003     LIKE pmbal_t.pmbal003

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmbjdocno
   CALL ap_ref_array2(g_ref_fields,"SELECT pmba001,pmba002 FROM pmba_t WHERE pmbaent='"||g_enterprise||"' AND pmbadocno=?","") RETURNING g_rtn_fields
   LET r_pmba001 = g_rtn_fields[1]
   LET r_pmba002 = g_rtn_fields[2]

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmbjdocno
   CALL ap_ref_array2(g_ref_fields,"SELECT pmbal003 FROM pmbal_t WHERE pmbalent='"||g_enterprise||"' AND pmbaldocno=? AND pmbal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_pmbal003 = g_rtn_fields[1]
   
   RETURN r_pmba001,r_pmba002,r_pmbal003   

END FUNCTION

################################################################################
# Descriptions...: 複製交易對象聯絡人檔
# Memo...........:
# Usage..........: CALL apmt005_pmaj_ins_pmbj(p_pmbjdocno,p_pmbj001)
#                  RETURNING r_success 
# Input parameter: p_pmbjdocno   申請單號
#                  p_pmbj001     交易對象編號
# Return code....: r_success     TRUE/FALSE
# Date & Author..: 15/09/14 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt005_pmaj_ins_pmbj(p_pmbjdocno,p_pmbj001)
DEFINE p_pmbjdocno    LIKE pmbj_t.pmbjdocno  #申請單號
DEFINE p_pmbj001      LIKE pmbj_t.pmbj001    #交易對象編號
DEFINE r_success      LIKE type_t.num5       #處理狀態
DEFINE l_success      LIKE type_t.num5
DEFINE l_sql          STRING
#161124-00048#9 mod-S
#DEFINE l_pmaj         RECORD LIKE pmaj_t.*
DEFINE l_pmaj RECORD  #交易對象聯絡人檔
       pmajent LIKE pmaj_t.pmajent, #企业编号
       pmaj001 LIKE pmaj_t.pmaj001, #交易对象编号
       pmaj002 LIKE pmaj_t.pmaj002, #联络人识别码
       pmaj003 LIKE pmaj_t.pmaj003, #联络人类别
       pmaj004 LIKE pmaj_t.pmaj004, #主要联络人否
       pmaj005 LIKE pmaj_t.pmaj005, #财务主要联络人否
       pmaj006 LIKE pmaj_t.pmaj006, #联络人部门
       pmaj007 LIKE pmaj_t.pmaj007, #职称
       pmaj008 LIKE pmaj_t.pmaj008, #简要说明
       pmajstus LIKE pmaj_t.pmajstus, #状态码
       pmaj009 LIKE pmaj_t.pmaj009, #姓氏
       pmaj010 LIKE pmaj_t.pmaj010, #中间名
       pmaj011 LIKE pmaj_t.pmaj011, #名字
       pmaj012 LIKE pmaj_t.pmaj012, #全名
       pmaj013 LIKE pmaj_t.pmaj013, #参考名
       pmaj014 LIKE pmaj_t.pmaj014  #昵称
END RECORD
#161124-00048#9 mod-E
DEFINE l_wc           STRING
#161124-00048#9 mod-S
#DEFINE l_oofa         RECORD LIKE oofa_t.*
DEFINE l_oofa RECORD  #聯絡對象檔
       oofastus LIKE oofa_t.oofastus, #状态码
       oofaent LIKE oofa_t.oofaent, #企业编号
       oofa001 LIKE oofa_t.oofa001, #联络对象识别码
       oofa002 LIKE oofa_t.oofa002, #联络对象类型
       oofa003 LIKE oofa_t.oofa003, #联络对象编号一
       oofa004 LIKE oofa_t.oofa004, #联络对象编号二
       oofa005 LIKE oofa_t.oofa005, #联络对象编号三
       oofa006 LIKE oofa_t.oofa006, #联络对象编号四
       oofa007 LIKE oofa_t.oofa007, #联络对象编号五
       oofa008 LIKE oofa_t.oofa008, #姓氏
       oofa009 LIKE oofa_t.oofa009, #中间名
       oofa010 LIKE oofa_t.oofa010, #名字
       oofa011 LIKE oofa_t.oofa011, #全名
       oofa012 LIKE oofa_t.oofa012, #参考名
       oofa013 LIKE oofa_t.oofa013, #暱称
       oofa014 LIKE oofa_t.oofa014, #助记码
       oofa015 LIKE oofa_t.oofa015, #识别证号
       oofa016 LIKE oofa_t.oofa016, #简要说明
       oofa017 LIKE oofa_t.oofa017, #失效日期
       oofaownid LIKE oofa_t.oofaownid, #资料所有者
       oofaowndp LIKE oofa_t.oofaowndp, #资料所有部门
       oofacrtid LIKE oofa_t.oofacrtid, #资料录入者
       oofacrtdp LIKE oofa_t.oofacrtdp, #资料录入部门
       oofacrtdt LIKE oofa_t.oofacrtdt, #资料创建日
       oofamodid LIKE oofa_t.oofamodid, #资料更改者
       oofamoddt LIKE oofa_t.oofamoddt  #最近更改日
END RECORD
#161124-00048#9 mod-E
DEFINE l_oofa001      LIKE oofa_t.oofa001

   LET r_success = TRUE

   #檢查:應在事物中的
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #將來源交易對象的聯絡人檔取出
   #161124-00048#9 mod-S
#   LET l_sql = "SELECT * FROM pmaj_t  ",
   LET l_sql = "SELECT pmajent,pmaj001,pmaj002,pmaj003,pmaj004,",
               "       pmaj005,pmaj006,pmaj007,pmaj008,pmajstus,",
               "       pmaj009,pmaj010,pmaj011,pmaj012,pmaj013,",
               "       pmaj014 ",
               "FROM pmaj_t  ",
   #161124-00048#9 mod-E
               " WHERE pmaj001='",p_pmbj001,"' ",
               "   AND pmajent='",g_enterprise,"' "     
   PREPARE apmt100_sel_pmaj_p FROM l_sql
   DECLARE apmt100_sel_pmaj_c CURSOR FOR apmt100_sel_pmaj_p
   FOREACH apmt100_sel_pmaj_c INTO l_pmaj.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmaj_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      
      ###需寫入四個檔案:oofa_t,oofb_t,oofc_t,pmbj_t
      #產生聯絡人識別碼
      LET l_wc = " oofaent = ",g_enterprise
      CALL s_aooi350_get_idno('oofa001','oofa_t',l_wc)
           RETURNING l_success,l_oofa001
      IF NOT l_success THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #oofa_t欄位賦值
      LET l_oofa.oofastus = 'Y'
      LET l_oofa.oofaent  = g_enterprise
      LET l_oofa.oofa001  = l_oofa001
      LET l_oofa.oofa002  = '4'
      LET l_oofa.oofa003  = p_pmbjdocno        #申請單號
      LET l_oofa.oofa004  = l_pmaj.pmaj012     #全名
      LET l_oofa.oofa017  = ''
      LET l_oofa.oofaownid = g_user
      LET l_oofa.oofaowndp = g_dept
      LET l_oofa.oofacrtid = g_user
      LET l_oofa.oofacrtdp = g_dept
      LET l_oofa.oofacrtdt = cl_get_current()    #资料创建日
      LET l_oofa.oofamodid = null
      LET l_oofa.oofamoddt = null
      
      #插入联络地址识别档
      #161124-00048#9 mod-S
#      INSERT INTO oofa_t VALUES (l_oofa.*)      
      INSERT INTO oofa_t (oofastus,oofaent,oofa001,oofa002,oofa003,
                          oofa004,oofa005,oofa006,oofa007,oofa008,
                          oofa009,oofa010,oofa011,oofa012,oofa013,
                          oofa014,oofa015,oofa016,oofa017,oofaownid,
                          oofaowndp,oofacrtid,oofacrtdp,oofacrtdt,oofamodid,
                          oofamoddt)
                  VALUES (l_oofa.*)      
      #161124-00048#9 mod-E
      IF SQLCA.sqlcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oofa_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #複製某一聯絡對象識別碼的聯絡地址與通訊方式
      CALL s_aooi350_reproduce_oofb_oofc(l_pmaj.pmaj002,l_oofa001,'1') RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF

      #插入交易對象交易夥伴檔
      INSERT INTO pmbj_t(pmbjent,pmbjdocno,pmbj001,pmbj002,pmbj003,
                         pmbj004,pmbj005,pmbj006,pmbj007,pmbj008,
                         pmbjstus,pmbj009,pmbj010,pmbj011,pmbj012,
                         pmbj013,pmbj014,pmbj015)
      VALUES (l_pmaj.pmajent,p_pmbjdocno,l_pmaj.pmaj001,l_oofa001,l_pmaj.pmaj003,
              l_pmaj.pmaj004,l_pmaj.pmaj005,l_pmaj.pmaj006,l_pmaj.pmaj007,l_pmaj.pmaj008,
              l_pmaj.pmajstus,l_pmaj.pmaj009,l_pmaj.pmaj010,l_pmaj.pmaj011,l_pmaj.pmaj012,
              l_pmaj.pmaj013,l_pmaj.pmaj014,l_pmaj.pmaj002)
      IF SQLCA.sqlcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmaj_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 檢查可不可以組全名
# Memo...........:
# Usage..........: CALL apmt005_pmbj012_chk(p_pmbj009,p_pmbj010,p_pmbj011)
#                  RETURNING r_success
# Input parameter: p_pmbj009   姓氏
#                : p_pmbj010   中間名
#                : p_pmbj011   名字
# Return code....: r_success   檢查結果(TRUE:表示可以組全名了 FALSE:表示無法組全名)
# Date & Author..: 15/10/02 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt005_pmbj012_chk(p_pmbj009,p_pmbj010,p_pmbj011)
DEFINE p_pmbj009    LIKE pmbj_t.pmbj009    #姓氏
DEFINE p_pmbj010    LIKE pmbj_t.pmbj010    #中間名
DEFINE p_pmbj011    LIKE pmbj_t.pmbj011    #名字
DEFINE r_success    LIKE type_t.num5       #檢查結果(TRUE:表示可以組全名了 FALSE:表示無法組全名)
DEFINE l_ooef006    LIKE ooef_t.ooef006    #國家地區
DEFINE l_oocg007    LIKE oocg_t.oocg007    #全名組合方式

   LET r_success = FALSE
   LET l_ooef006 = ''
   LET l_oocg007 = ''
   
   #根據營運據點獲取國家地區
   SELECT ooef006 INTO l_ooef006
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   IF SQLCA.sqlcode OR cl_null(l_ooef006) THEN
      #抓不到營運據點的國家地區,則直接預設全名組合方式為1.姓氏+名字
      LET l_oocg007 = '1'
   ELSE
      #從國家地區檔中抓取全名組合方式
      SELECT oocg007 INTO l_oocg007
        FROM oocg_t
       WHERE oocgent = g_enterprise
         AND oocg001 = l_ooef006
      IF SQLCA.sqlcode OR cl_null(l_oocg007) THEN
         #抓不到國家地區的全名組合方式,則直接預設全名組合方式為1.姓氏+名字
         LET l_oocg007 = '1'
      END IF
   END IF
   
   IF ((l_oocg007 = '1' OR l_oocg007 = '2') AND NOT cl_null(p_pmbj009) AND NOT cl_null(p_pmbj011)) OR
      (l_oocg007 = '3' AND NOT cl_null(p_pmbj009) AND NOT cl_null(p_pmbj010) AND NOT cl_null(p_pmbj011)) THEN
      LET r_success = TRUE
   END IF

   RETURN r_success

END FUNCTION

 
{</section>}
 
