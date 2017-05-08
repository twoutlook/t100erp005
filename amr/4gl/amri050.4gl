#該程式未解開Section, 採用最新樣板產出!
{<section id="amri050.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-05-12 13:40:19), PR版次:0006(2016-09-08 12:51:01)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000080
#+ Filename...: amri050
#+ Description: 資源行事曆維護作業
#+ Creator....: 03079(2014-07-22 09:46:10)
#+ Modifier...: 03079 -SD/PR- 00593
 
{</section>}
 
{<section id="amri050.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#3   2016/04/11  By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160826-00015#1   2016/09/08  By Sarah       增加接收參數g_argv[4]為一個where字串
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
PRIVATE type type_g_mrbh_m        RECORD
       mrbh006 LIKE mrbh_t.mrbh006, 
   mrbh006_desc LIKE type_t.chr80, 
   mrbh002 LIKE mrbh_t.mrbh002, 
   mrbhsite LIKE mrbh_t.mrbhsite
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mrbh_d        RECORD
       mrbh001 LIKE mrbh_t.mrbh001, 
   mrbh001_desc LIKE type_t.chr500, 
   mrba010 LIKE type_t.chr10, 
   mrba010_desc LIKE type_t.chr500, 
   mrba021 LIKE type_t.chr10, 
   mrba021_desc LIKE type_t.chr500, 
   mrbh003 LIKE mrbh_t.mrbh003, 
   mrbh004 LIKE mrbh_t.mrbh004, 
   time01 LIKE type_t.num15_3, 
   time02 LIKE type_t.num10, 
   mrbh005 LIKE mrbh_t.mrbh005, 
   mrbh007 LIKE mrbh_t.mrbh007, 
   mrbh007_desc LIKE type_t.chr500, 
   mrbh008 LIKE mrbh_t.mrbh008, 
   mrbhstus LIKE mrbh_t.mrbhstus
       END RECORD
PRIVATE TYPE type_g_mrbh2_d RECORD
       mrbhownid LIKE mrbh_t.mrbhownid, 
   mrbhownid_desc LIKE type_t.chr500, 
   mrbhowndp LIKE mrbh_t.mrbhowndp, 
   mrbhowndp_desc LIKE type_t.chr500, 
   mrbhcrtid LIKE mrbh_t.mrbhcrtid, 
   mrbhcrtid_desc LIKE type_t.chr500, 
   mrbhcrtdp LIKE mrbh_t.mrbhcrtdp, 
   mrbhcrtdp_desc LIKE type_t.chr500, 
   mrbhcrtdt DATETIME YEAR TO SECOND, 
   mrbhmodid LIKE mrbh_t.mrbhmodid, 
   mrbhmodid_desc LIKE type_t.chr500, 
   mrbhmoddt DATETIME YEAR TO SECOND, 
   mrbhcnfid LIKE mrbh_t.mrbhcnfid, 
   mrbhcnfid_desc LIKE type_t.chr500, 
   mrbhcnfdt DATETIME YEAR TO SECOND, 
   mrbh001 LIKE mrbh_t.mrbh001, 
   mrbh003 LIKE mrbh_t.mrbh003, 
   mrbh007 LIKE mrbh_t.mrbh007
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_mrbh_m          type_g_mrbh_m
DEFINE g_mrbh_m_t        type_g_mrbh_m
DEFINE g_mrbh_m_o        type_g_mrbh_m
DEFINE g_mrbh_m_mask_o   type_g_mrbh_m #轉換遮罩前資料
DEFINE g_mrbh_m_mask_n   type_g_mrbh_m #轉換遮罩後資料
 
   DEFINE g_mrbh006_t LIKE mrbh_t.mrbh006
DEFINE g_mrbh002_t LIKE mrbh_t.mrbh002
DEFINE g_mrbhsite_t LIKE mrbh_t.mrbhsite
 
 
DEFINE g_mrbh_d          DYNAMIC ARRAY OF type_g_mrbh_d
DEFINE g_mrbh_d_t        type_g_mrbh_d
DEFINE g_mrbh_d_o        type_g_mrbh_d
DEFINE g_mrbh_d_mask_o   DYNAMIC ARRAY OF type_g_mrbh_d #轉換遮罩前資料
DEFINE g_mrbh_d_mask_n   DYNAMIC ARRAY OF type_g_mrbh_d #轉換遮罩後資料
DEFINE g_mrbh2_d   DYNAMIC ARRAY OF type_g_mrbh2_d
DEFINE g_mrbh2_d_t type_g_mrbh2_d
DEFINE g_mrbh2_d_o type_g_mrbh2_d
DEFINE g_mrbh2_d_mask_o   DYNAMIC ARRAY OF type_g_mrbh2_d #轉換遮罩前資料
DEFINE g_mrbh2_d_mask_n   DYNAMIC ARRAY OF type_g_mrbh2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_mrbh006 LIKE mrbh_t.mrbh006,
   b_mrbh006_desc LIKE type_t.chr80,
      b_mrbh002 LIKE mrbh_t.mrbh002,
      b_mrbhsite LIKE mrbh_t.mrbhsite
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
 
{<section id="amri050.main" >}
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
   CALL cl_ap_init("amr","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_ins_able_time_create_tmp()
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mrbh006,'',mrbh002,mrbhsite", 
                      " FROM mrbh_t",
                      " WHERE mrbhent= ? AND mrbh002=? AND mrbh006=? AND mrbhsite=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   LET g_forupd_sql = " SELECT mrbh006,'',mrbh002,mrbhsite",
                      " FROM mrbh_t",
                      " WHERE mrbhent= ? ", 
                      "   AND mrbhsite = '",g_site,"' ", 
                      "   AND mrbh002=? ", 
                      "   AND mrbh006=? ", 
                      "   AND mrbhsite=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amri050_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mrbh006,t0.mrbh002,t0.mrbhsite,t1.ecaa002",
               " FROM mrbh_t t0",
                              " LEFT JOIN ecaa_t t1 ON t1.ecaaent="||g_enterprise||" AND t1.ecaasite=t0.mrbhsite AND t1.ecaa001=t0.mrbh006  ",
 
               " WHERE t0.mrbhent = " ||g_enterprise|| " AND t0.mrbh002 = ? AND t0.mrbh006 = ? AND t0.mrbhsite = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
    LET g_sql = " SELECT UNIQUE t0.mrbh006,t0.mrbh002,t0.mrbhsite,t1.ecaa002",
               " FROM mrbh_t t0 LEFT JOIN ecaa_t t1 ON t1.ecaaent='"||g_enterprise||"' AND t1.ecaasite=t0.mrbhsite AND t1.ecaa001=t0.mrbh006  ",
               " WHERE t0.mrbhent = '" ||g_enterprise|| "' ", 
               "   AND t0.mrbhsite = '",g_site,"' ",  
               "  AND t0.mrbh002 = ? AND t0.mrbh006 = ? AND t0.mrbhsite = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #end add-point
   PREPARE amri050_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amri050 WITH FORM cl_ap_formpath("amr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amri050_init()   
 
      #進入選單 Menu (="N")
      CALL amri050_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amri050
      
   END IF 
   
   CLOSE amri050_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_ins_able_time_drop_tmp()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amri050.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION amri050_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL amri050_set_time_format("mrbh_t","mrbh003")
   CALL amri050_set_time_format("mrbh_t","mrbh004")
   #end add-point
   
   CALL amri050_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="amri050.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION amri050_ui_dialog()
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
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0 
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_mrbh_m.* TO NULL
         CALL g_mrbh_d.clear()
         CALL g_mrbh2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL amri050_init()
      END IF
 
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
         
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
               
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL amri050_idx_chk()
               CALL amri050_fetch('') # reload data
               LET g_detail_idx = 1
               CALL amri050_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_mrbh_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL amri050_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL amri050_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               
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
            
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_mrbh2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL amri050_idx_chk()
               CALL amri050_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body2.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 2
            
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL amri050_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
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
               CALL amri050_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL amri050_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL amri050_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL amri050_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amri050_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL amri050_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amri050_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL amri050_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amri050_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL amri050_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amri050_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL amri050_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amri050_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_mrbh_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_mrbh2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
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
          
         ON ACTION mainhidden       #主頁摺疊
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
               NEXT FIELD mrbh001
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
               CALL amri050_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL amri050_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL amri050_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL amri050_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL amri050_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL amri050_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amri050_insert()
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
               CALL amri050_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL amri050_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL amri050_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amri050_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amri050_set_pk_array()
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
 
{<section id="amri050.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION amri050_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="amri050.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION amri050_browser_fill(ps_page_action)
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
   
   #end add-point    
 
   LET l_searchcol = "mrbh002,mrbh006,mrbhsite"
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
      LET l_sub_sql = " SELECT DISTINCT mrbh002 ",
                      ", mrbh006 ",
                      ", mrbhsite ",
 
                      " FROM mrbh_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE mrbhent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mrbh_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mrbh002 ",
                      ", mrbh006 ",
                      ", mrbhsite ",
 
                      " FROM mrbh_t ",
                      " ",
                      " ", 
 
 
                      " WHERE mrbhent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mrbh_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   IF l_wc2 <> " 1=1" OR NOT cl_null(l_wc2) THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE mrbh002 ",
                      ", mrbh006 ",
                      ", mrbhsite ",
                      " FROM mrbh_t ",
                      " WHERE mrbhent = '" ||g_enterprise|| "' ",
                      "   AND mrbhsite = '",g_site,"' ",
                      "   AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mrbh_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE mrbh002 ",
                      ", mrbh006 ",
                      ", mrbhsite ",
                      " FROM mrbh_t ",
                      " WHERE mrbhent = '" ||g_enterprise|| "' ",
                      "   AND mrbhsite = '",g_site,"' ",
                      "   AND ",l_wc CLIPPED, cl_sql_add_filter("mrbh_t")
   END IF

   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
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
      INITIALIZE g_mrbh_m.* TO NULL
      CALL g_mrbh_d.clear()        
      CALL g_mrbh2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mrbh006,t0.mrbh002,t0.mrbhsite Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.mrbh006,t0.mrbh002,t0.mrbhsite,t1.ecaa002",
                " FROM mrbh_t t0",
                #" ",
                " ",
 
 
 
                               " LEFT JOIN ecaa_t t1 ON t1.ecaaent="||g_enterprise||" AND t1.ecaasite=t0.mrbhsite AND t1.ecaa001=t0.mrbh006  ",
 
                " WHERE t0.mrbhent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("mrbh_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   LET g_sql  = "SELECT DISTINCT t0.mrbh006,t0.mrbh002,t0.mrbhsite,t1.ecaa002",
                " FROM mrbh_t t0 LEFT JOIN ecaa_t t1 ON t1.ecaaent='"||g_enterprise||"' AND t1.ecaasite=t0.mrbhsite AND t1.ecaa001=t0.mrbh006  ",
                " WHERE t0.mrbhent = '" ||g_enterprise|| "' ",
                "   AND t0.mrbhsite = '",g_site,"' ",
                "   AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("mrbh_t")
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"mrbh_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_mrbh006,g_browser[g_cnt].b_mrbh002,g_browser[g_cnt].b_mrbhsite, 
          g_browser[g_cnt].b_mrbh006_desc 
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
      
         #遮罩相關處理
         CALL amri050_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_mrbh002) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_mrbh_m.* TO NULL
      CALL g_mrbh_d.clear()
      CALL g_mrbh2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL amri050_fetch('')
   
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
 
{<section id="amri050.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION amri050_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mrbh_m.mrbh002 = g_browser[g_current_idx].b_mrbh002   
   LET g_mrbh_m.mrbh006 = g_browser[g_current_idx].b_mrbh006   
   LET g_mrbh_m.mrbhsite = g_browser[g_current_idx].b_mrbhsite   
 
   EXECUTE amri050_master_referesh USING g_mrbh_m.mrbh002,g_mrbh_m.mrbh006,g_mrbh_m.mrbhsite INTO g_mrbh_m.mrbh006, 
       g_mrbh_m.mrbh002,g_mrbh_m.mrbhsite,g_mrbh_m.mrbh006_desc
   CALL amri050_show()
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION amri050_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION amri050_ui_browser_refresh()
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
      IF g_browser[l_i].b_mrbh002 = g_mrbh_m.mrbh002 
         AND g_browser[l_i].b_mrbh006 = g_mrbh_m.mrbh006 
         AND g_browser[l_i].b_mrbhsite = g_mrbh_m.mrbhsite 
 
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
 
{<section id="amri050.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION amri050_construct()
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
   INITIALIZE g_mrbh_m.* TO NULL
   CALL g_mrbh_d.clear()
   CALL g_mrbh2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON mrbh006,mrbh002,mrbhsite
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.mrbh006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh006
            #add-point:ON ACTION controlp INFIELD mrbh006 name="construct.c.mrbh006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ecaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbh006  #顯示到畫面上
            NEXT FIELD mrbh006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh006
            #add-point:BEFORE FIELD mrbh006 name="construct.b.mrbh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh006
            
            #add-point:AFTER FIELD mrbh006 name="construct.a.mrbh006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh002
            #add-point:BEFORE FIELD mrbh002 name="construct.b.mrbh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh002
            
            #add-point:AFTER FIELD mrbh002 name="construct.a.mrbh002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrbh002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh002
            #add-point:ON ACTION controlp INFIELD mrbh002 name="construct.c.mrbh002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbhsite
            #add-point:BEFORE FIELD mrbhsite name="construct.b.mrbhsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbhsite
            
            #add-point:AFTER FIELD mrbhsite name="construct.a.mrbhsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrbhsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbhsite
            #add-point:ON ACTION controlp INFIELD mrbhsite name="construct.c.mrbhsite"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON mrbh001,mrbh003,mrbh004,time01,time02,mrbh005,mrbh007,mrbh008,mrbhstus, 
          mrbhownid,mrbhowndp,mrbhcrtid,mrbhcrtdp,mrbhcrtdt,mrbhmodid,mrbhmoddt,mrbhcnfid,mrbhcnfdt
           FROM s_detail1[1].mrbh001,s_detail1[1].mrbh003,s_detail1[1].mrbh004,s_detail1[1].time01,s_detail1[1].time02, 
               s_detail1[1].mrbh005,s_detail1[1].mrbh007,s_detail1[1].mrbh008,s_detail1[1].mrbhstus, 
               s_detail2[1].mrbhownid,s_detail2[1].mrbhowndp,s_detail2[1].mrbhcrtid,s_detail2[1].mrbhcrtdp, 
               s_detail2[1].mrbhcrtdt,s_detail2[1].mrbhmodid,s_detail2[1].mrbhmoddt,s_detail2[1].mrbhcnfid, 
               s_detail2[1].mrbhcnfdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mrbhcrtdt>>----
         AFTER FIELD mrbhcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mrbhmoddt>>----
         AFTER FIELD mrbhmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrbhcnfdt>>----
         AFTER FIELD mrbhcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrbhpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #Ctrlp:construct.c.page1.mrbh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh001
            #add-point:ON ACTION controlp INFIELD mrbh001 name="construct.c.page1.mrbh001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbh001  #顯示到畫面上
            NEXT FIELD mrbh001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh001
            #add-point:BEFORE FIELD mrbh001 name="construct.b.page1.mrbh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh001
            
            #add-point:AFTER FIELD mrbh001 name="construct.a.page1.mrbh001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh003
            #add-point:BEFORE FIELD mrbh003 name="construct.b.page1.mrbh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh003
            
            #add-point:AFTER FIELD mrbh003 name="construct.a.page1.mrbh003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh003
            #add-point:ON ACTION controlp INFIELD mrbh003 name="construct.c.page1.mrbh003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh004
            #add-point:BEFORE FIELD mrbh004 name="construct.b.page1.mrbh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh004
            
            #add-point:AFTER FIELD mrbh004 name="construct.a.page1.mrbh004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh004
            #add-point:ON ACTION controlp INFIELD mrbh004 name="construct.c.page1.mrbh004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD time01
            #add-point:BEFORE FIELD time01 name="construct.b.page1.time01"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD time01
            
            #add-point:AFTER FIELD time01 name="construct.a.page1.time01"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.time01
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD time01
            #add-point:ON ACTION controlp INFIELD time01 name="construct.c.page1.time01"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD time02
            #add-point:BEFORE FIELD time02 name="construct.b.page1.time02"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD time02
            
            #add-point:AFTER FIELD time02 name="construct.a.page1.time02"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.time02
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD time02
            #add-point:ON ACTION controlp INFIELD time02 name="construct.c.page1.time02"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh005
            #add-point:BEFORE FIELD mrbh005 name="construct.b.page1.mrbh005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh005
            
            #add-point:AFTER FIELD mrbh005 name="construct.a.page1.mrbh005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbh005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh005
            #add-point:ON ACTION controlp INFIELD mrbh005 name="construct.c.page1.mrbh005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrbh007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh007
            #add-point:ON ACTION controlp INFIELD mrbh007 name="construct.c.page1.mrbh007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '1104'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbh007  #顯示到畫面上
            NEXT FIELD mrbh007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh007
            #add-point:BEFORE FIELD mrbh007 name="construct.b.page1.mrbh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh007
            
            #add-point:AFTER FIELD mrbh007 name="construct.a.page1.mrbh007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh008
            #add-point:BEFORE FIELD mrbh008 name="construct.b.page1.mrbh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh008
            
            #add-point:AFTER FIELD mrbh008 name="construct.a.page1.mrbh008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh008
            #add-point:ON ACTION controlp INFIELD mrbh008 name="construct.c.page1.mrbh008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbhstus
            #add-point:BEFORE FIELD mrbhstus name="construct.b.page1.mrbhstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbhstus
            
            #add-point:AFTER FIELD mrbhstus name="construct.a.page1.mrbhstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbhstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbhstus
            #add-point:ON ACTION controlp INFIELD mrbhstus name="construct.c.page1.mrbhstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mrbhownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbhownid
            #add-point:ON ACTION controlp INFIELD mrbhownid name="construct.c.page2.mrbhownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbhownid  #顯示到畫面上
            NEXT FIELD mrbhownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbhownid
            #add-point:BEFORE FIELD mrbhownid name="construct.b.page2.mrbhownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbhownid
            
            #add-point:AFTER FIELD mrbhownid name="construct.a.page2.mrbhownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrbhowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbhowndp
            #add-point:ON ACTION controlp INFIELD mrbhowndp name="construct.c.page2.mrbhowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbhowndp  #顯示到畫面上
            NEXT FIELD mrbhowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbhowndp
            #add-point:BEFORE FIELD mrbhowndp name="construct.b.page2.mrbhowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbhowndp
            
            #add-point:AFTER FIELD mrbhowndp name="construct.a.page2.mrbhowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrbhcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbhcrtid
            #add-point:ON ACTION controlp INFIELD mrbhcrtid name="construct.c.page2.mrbhcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbhcrtid  #顯示到畫面上
            NEXT FIELD mrbhcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbhcrtid
            #add-point:BEFORE FIELD mrbhcrtid name="construct.b.page2.mrbhcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbhcrtid
            
            #add-point:AFTER FIELD mrbhcrtid name="construct.a.page2.mrbhcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrbhcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbhcrtdp
            #add-point:ON ACTION controlp INFIELD mrbhcrtdp name="construct.c.page2.mrbhcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbhcrtdp  #顯示到畫面上
            NEXT FIELD mrbhcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbhcrtdp
            #add-point:BEFORE FIELD mrbhcrtdp name="construct.b.page2.mrbhcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbhcrtdp
            
            #add-point:AFTER FIELD mrbhcrtdp name="construct.a.page2.mrbhcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbhcrtdt
            #add-point:BEFORE FIELD mrbhcrtdt name="construct.b.page2.mrbhcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mrbhmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbhmodid
            #add-point:ON ACTION controlp INFIELD mrbhmodid name="construct.c.page2.mrbhmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbhmodid  #顯示到畫面上
            NEXT FIELD mrbhmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbhmodid
            #add-point:BEFORE FIELD mrbhmodid name="construct.b.page2.mrbhmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbhmodid
            
            #add-point:AFTER FIELD mrbhmodid name="construct.a.page2.mrbhmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbhmoddt
            #add-point:BEFORE FIELD mrbhmoddt name="construct.b.page2.mrbhmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mrbhcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbhcnfid
            #add-point:ON ACTION controlp INFIELD mrbhcnfid name="construct.c.page2.mrbhcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbhcnfid  #顯示到畫面上
            NEXT FIELD mrbhcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbhcnfid
            #add-point:BEFORE FIELD mrbhcnfid name="construct.b.page2.mrbhcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbhcnfid
            
            #add-point:AFTER FIELD mrbhcnfid name="construct.a.page2.mrbhcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbhcnfdt
            #add-point:BEFORE FIELD mrbhcnfdt name="construct.b.page2.mrbhcnfdt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
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
 
{<section id="amri050.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION amri050_filter()
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
      CONSTRUCT g_wc_filter ON mrbh006,mrbh002,mrbhsite
                          FROM s_browse[1].b_mrbh006,s_browse[1].b_mrbh002,s_browse[1].b_mrbhsite
 
         BEFORE CONSTRUCT
               DISPLAY amri050_filter_parser('mrbh006') TO s_browse[1].b_mrbh006
            DISPLAY amri050_filter_parser('mrbh002') TO s_browse[1].b_mrbh002
            DISPLAY amri050_filter_parser('mrbhsite') TO s_browse[1].b_mrbhsite
      
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
 
      CALL amri050_filter_show('mrbh006')
   CALL amri050_filter_show('mrbh002')
   CALL amri050_filter_show('mrbhsite')
 
END FUNCTION
 
{</section>}
 
{<section id="amri050.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION amri050_filter_parser(ps_field)
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
 
{<section id="amri050.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION amri050_filter_show(ps_field)
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
   LET ls_condition = amri050_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="amri050.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION amri050_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   
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
   CALL g_mrbh_d.clear()
   CALL g_mrbh2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL amri050_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL amri050_browser_fill(g_wc)
      CALL amri050_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL amri050_browser_fill("F")
   
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
      CALL amri050_fetch("F") 
   END IF
   
   CALL amri050_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION amri050_fetch(p_flag)
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
   
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
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
   
   LET g_mrbh_m.mrbh002 = g_browser[g_current_idx].b_mrbh002
   LET g_mrbh_m.mrbh006 = g_browser[g_current_idx].b_mrbh006
   LET g_mrbh_m.mrbhsite = g_browser[g_current_idx].b_mrbhsite
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE amri050_master_referesh USING g_mrbh_m.mrbh002,g_mrbh_m.mrbh006,g_mrbh_m.mrbhsite INTO g_mrbh_m.mrbh006, 
       g_mrbh_m.mrbh002,g_mrbh_m.mrbhsite,g_mrbh_m.mrbh006_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "mrbh_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_mrbh_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_mrbh_m_mask_o.* =  g_mrbh_m.*
   CALL amri050_mrbh_t_mask()
   LET g_mrbh_m_mask_n.* =  g_mrbh_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL amri050_set_act_visible()
   CALL amri050_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_mrbh_m_t.* = g_mrbh_m.*
   LET g_mrbh_m_o.* = g_mrbh_m.*
   
   #重新顯示   
   CALL amri050_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="amri050.insert" >}
#+ 資料新增
PRIVATE FUNCTION amri050_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_mrbh_d.clear()
   CALL g_mrbh2_d.clear()
 
 
   INITIALIZE g_mrbh_m.* TO NULL             #DEFAULT 設定
   LET g_mrbh002_t = NULL
   LET g_mrbh006_t = NULL
   LET g_mrbhsite_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      LET g_mrbh_m.mrbhsite = g_site
      #end add-point 
 
      CALL amri050_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_mrbh_m.* TO NULL
         INITIALIZE g_mrbh_d TO NULL
         INITIALIZE g_mrbh2_d TO NULL
 
         CALL amri050_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_mrbh_m.* = g_mrbh_m_t.*
         CALL amri050_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_mrbh_d.clear()
      #CALL g_mrbh2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL amri050_set_act_visible()
   CALL amri050_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_mrbh002_t = g_mrbh_m.mrbh002
   LET g_mrbh006_t = g_mrbh_m.mrbh006
   LET g_mrbhsite_t = g_mrbh_m.mrbhsite
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrbhent = " ||g_enterprise|| " AND",
                      " mrbh002 = '", g_mrbh_m.mrbh002, "' "
                      ," AND mrbh006 = '", g_mrbh_m.mrbh006, "' "
                      ," AND mrbhsite = '", g_mrbh_m.mrbhsite, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amri050_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL amri050_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE amri050_master_referesh USING g_mrbh_m.mrbh002,g_mrbh_m.mrbh006,g_mrbh_m.mrbhsite INTO g_mrbh_m.mrbh006, 
       g_mrbh_m.mrbh002,g_mrbh_m.mrbhsite,g_mrbh_m.mrbh006_desc
   
   #遮罩相關處理
   LET g_mrbh_m_mask_o.* =  g_mrbh_m.*
   CALL amri050_mrbh_t_mask()
   LET g_mrbh_m_mask_n.* =  g_mrbh_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrbh_m.mrbh006,g_mrbh_m.mrbh006_desc,g_mrbh_m.mrbh002,g_mrbh_m.mrbhsite
   
   #功能已完成,通報訊息中心
   CALL amri050_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.modify" >}
#+ 資料修改
PRIVATE FUNCTION amri050_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_mrbh_m.mrbh002 IS NULL
   OR g_mrbh_m.mrbh006 IS NULL
   OR g_mrbh_m.mrbhsite IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_mrbh002_t = g_mrbh_m.mrbh002
   LET g_mrbh006_t = g_mrbh_m.mrbh006
   LET g_mrbhsite_t = g_mrbh_m.mrbhsite
 
   CALL s_transaction_begin()
   
   OPEN amri050_cl USING g_enterprise,g_mrbh_m.mrbh002,g_mrbh_m.mrbh006,g_mrbh_m.mrbhsite
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amri050_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE amri050_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amri050_master_referesh USING g_mrbh_m.mrbh002,g_mrbh_m.mrbh006,g_mrbh_m.mrbhsite INTO g_mrbh_m.mrbh006, 
       g_mrbh_m.mrbh002,g_mrbh_m.mrbhsite,g_mrbh_m.mrbh006_desc
   
   #遮罩相關處理
   LET g_mrbh_m_mask_o.* =  g_mrbh_m.*
   CALL amri050_mrbh_t_mask()
   LET g_mrbh_m_mask_n.* =  g_mrbh_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL amri050_show()
   WHILE TRUE
      LET g_mrbh002_t = g_mrbh_m.mrbh002
      LET g_mrbh006_t = g_mrbh_m.mrbh006
      LET g_mrbhsite_t = g_mrbh_m.mrbhsite
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL amri050_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_mrbh_m.* = g_mrbh_m_t.*
         CALL amri050_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_mrbh_m.mrbh002 != g_mrbh002_t 
      OR g_mrbh_m.mrbh006 != g_mrbh006_t 
      OR g_mrbh_m.mrbhsite != g_mrbhsite_t 
 
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
   CALL amri050_set_act_visible()
   CALL amri050_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mrbhent = " ||g_enterprise|| " AND",
                      " mrbh002 = '", g_mrbh_m.mrbh002, "' "
                      ," AND mrbh006 = '", g_mrbh_m.mrbh006, "' "
                      ," AND mrbhsite = '", g_mrbh_m.mrbhsite, "' "
 
   #填到對應位置
   CALL amri050_browser_fill("")
 
   CALL amri050_idx_chk()
 
   CLOSE amri050_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amri050_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="amri050.input" >}
#+ 資料輸入
PRIVATE FUNCTION amri050_input(p_cmd)
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
   DEFINE l_sql                  STRING
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
   DISPLAY BY NAME g_mrbh_m.mrbh006,g_mrbh_m.mrbh006_desc,g_mrbh_m.mrbh002,g_mrbh_m.mrbhsite
   
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
   LET g_forupd_sql = "SELECT mrbh001,mrbh003,mrbh004,mrbh005,mrbh007,mrbh008,mrbhstus,mrbhownid,mrbhowndp, 
       mrbhcrtid,mrbhcrtdp,mrbhcrtdt,mrbhmodid,mrbhmoddt,mrbhcnfid,mrbhcnfdt,mrbh001,mrbh003,mrbh007  
       FROM mrbh_t WHERE mrbhent=? AND mrbh002=? AND mrbh006=? AND mrbhsite=? AND mrbh001=? AND mrbh003=?  
       AND mrbh007=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amri050_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL amri050_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL amri050_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_mrbh_m.mrbh006,g_mrbh_m.mrbh002,g_mrbh_m.mrbhsite
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="amri050.input.head" >}
   
      #單頭段
      INPUT BY NAME g_mrbh_m.mrbh006,g_mrbh_m.mrbh002,g_mrbh_m.mrbhsite 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            CALL amri050_set_time_format("mrbh_t","mrbh003")
            CALL amri050_set_time_format("mrbh_t","mrbh004")
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh006
            
            #add-point:AFTER FIELD mrbh006 name="input.a.mrbh006"
            LET g_mrbh_m.mrbh006_desc = ' '
            CALL amri050_mrbh006_ref(g_mrbh_m.mrbh006)
                 RETURNING g_mrbh_m.mrbh006_desc
            DISPLAY BY NAME g_mrbh_m.mrbh006_desc

            IF cl_null(g_mrbh_m.mrbh006) THEN
               LET g_mrbh_m.mrbh006 = ' '
            END IF 
            
            IF NOT cl_null(g_mrbh_m.mrbh002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrbh_m.mrbh002 != g_mrbh002_t OR g_mrbh_m.mrbh006 != g_mrbh006_t )) THEN
                  LET l_sql = "SELECT COUNT(*) FROM mrbh_t ",
                              " WHERE mrbhent = '",g_enterprise,"' ",
                              "   AND mrbhsite = '",g_site,"' ",
                              "   AND mrbh002 = '",g_mrbh_m.mrbh002,"' ",
                              "   AND mrbh006 = '",g_mrbh_m.mrbh006,"' "
                  IF NOT ap_chk_notDup("",l_sql,'std-00004',0) THEN
                     LET g_mrbh_m.mrbh006 = g_mrbh006_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_mrbh_m.mrbh006) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrbh_m.mrbh006 != g_mrbh006_t)) THEN
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  #呼叫檢查存在並帶值的library
                  LET g_chkparam.arg1 = g_mrbh_m.mrbh006
                  #160318-00025#3--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aec-00010:sub-01302|aeci001|",cl_get_progname("aeci001",g_lang,"2"),"|:EXEPROGaeci001"
                  #160318-00025#3--add--end
                  IF NOT cl_chk_exist("v_ecaa001_1") THEN
                     LET g_mrbh_m.mrbh006 = g_mrbh006_t
                     CALL amri050_mrbh006_ref(g_mrbh_m.mrbh006)
                          RETURNING g_mrbh_m.mrbh006_desc
                     DISPLAY BY NAME g_mrbh_m.mrbh006_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            
            CALL amri050_mrbh006_ref(g_mrbh_m.mrbh006)
                 RETURNING g_mrbh_m.mrbh006_desc
            DISPLAY BY NAME g_mrbh_m.mrbh006_desc

            LET g_mrbh_m_o.mrbh006 = g_mrbh_m.mrbh006


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh006
            #add-point:BEFORE FIELD mrbh006 name="input.b.mrbh006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbh006
            #add-point:ON CHANGE mrbh006 name="input.g.mrbh006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh002
            #add-point:BEFORE FIELD mrbh002 name="input.b.mrbh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh002
            
            #add-point:AFTER FIELD mrbh002 name="input.a.mrbh002"
            IF NOT cl_null(g_mrbh_m.mrbh002) THEN
               IF cl_null(g_mrbh_m.mrbh006) THEN
                  LET g_mrbh_m.mrbh006 = ' '
               END IF
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrbh_m.mrbh002 != g_mrbh002_t OR g_mrbh_m.mrbh006 != g_mrbh006_t )) THEN
                  LET l_sql = "SELECT COUNT(*) FROM mrbh_t ",
                              " WHERE mrbhent = '",g_enterprise,"' ",
                              "   AND mrbhsite = '",g_site,"' ",
                              "   AND mrbh002 = '",g_mrbh_m.mrbh002,"' ",
                              "   AND mrbh006 = '",g_mrbh_m.mrbh006,"' "
                  IF NOT ap_chk_notDup("",l_sql,'std-00004',0) THEN
                     LET g_mrbh_m.mrbh002 = g_mrbh002_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbh002
            #add-point:ON CHANGE mrbh002 name="input.g.mrbh002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbhsite
            #add-point:BEFORE FIELD mrbhsite name="input.b.mrbhsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbhsite
            
            #add-point:AFTER FIELD mrbhsite name="input.a.mrbhsite"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbhsite
            #add-point:ON CHANGE mrbhsite name="input.g.mrbhsite"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mrbh006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh006
            #add-point:ON ACTION controlp INFIELD mrbh006 name="input.c.mrbh006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrbh_m.mrbh006             #給予default值
            
            CALL q_ecaa001()                                #呼叫開窗

            LET g_mrbh_m.mrbh006 = g_qryparam.return1              

            DISPLAY g_mrbh_m.mrbh006 TO mrbh006              #
            CALL amri050_mrbh006_ref(g_mrbh_m.mrbh006)
                 RETURNING g_mrbh_m.mrbh006_desc
            DISPLAY BY NAME g_mrbh_m.mrbh006_desc
            NEXT FIELD mrbh006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrbh002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh002
            #add-point:ON ACTION controlp INFIELD mrbh002 name="input.c.mrbh002"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrbhsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbhsite
            #add-point:ON ACTION controlp INFIELD mrbhsite name="input.c.mrbhsite"
            
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
            DISPLAY BY NAME g_mrbh_m.mrbh002             
                            ,g_mrbh_m.mrbh006   
                            ,g_mrbh_m.mrbhsite   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL amri050_mrbh_t_mask_restore('restore_mask_o')
            
               UPDATE mrbh_t SET (mrbh006,mrbh002,mrbhsite) = (g_mrbh_m.mrbh006,g_mrbh_m.mrbh002,g_mrbh_m.mrbhsite) 
 
                WHERE mrbhent = g_enterprise AND mrbh002 = g_mrbh002_t
                  AND mrbh006 = g_mrbh006_t
                  AND mrbhsite = g_mrbhsite_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbh_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbh_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrbh_m.mrbh002
               LET gs_keys_bak[1] = g_mrbh002_t
               LET gs_keys[2] = g_mrbh_m.mrbh006
               LET gs_keys_bak[2] = g_mrbh006_t
               LET gs_keys[3] = g_mrbh_m.mrbhsite
               LET gs_keys_bak[3] = g_mrbhsite_t
               LET gs_keys[4] = g_mrbh_d[g_detail_idx].mrbh001
               LET gs_keys_bak[4] = g_mrbh_d_t.mrbh001
               LET gs_keys[5] = g_mrbh_d[g_detail_idx].mrbh003
               LET gs_keys_bak[5] = g_mrbh_d_t.mrbh003
               LET gs_keys[6] = g_mrbh_d[g_detail_idx].mrbh007
               LET gs_keys_bak[6] = g_mrbh_d_t.mrbh007
               CALL amri050_update_b('mrbh_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_mrbh_m_t)
                     #LET g_log2 = util.JSON.stringify(g_mrbh_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL amri050_mrbh_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL amri050_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_mrbh002_t = g_mrbh_m.mrbh002
           LET g_mrbh006_t = g_mrbh_m.mrbh006
           LET g_mrbhsite_t = g_mrbh_m.mrbhsite
 
           
           IF g_mrbh_d.getLength() = 0 THEN
              NEXT FIELD mrbh001
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="amri050.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_mrbh_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrbh_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amri050_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            CALL amri050_set_time_format("mrbh_t","mrbh003")
            CALL amri050_set_time_format("mrbh_t","mrbh004")
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
            CALL amri050_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN amri050_cl USING g_enterprise,g_mrbh_m.mrbh002,g_mrbh_m.mrbh006,g_mrbh_m.mrbhsite                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE amri050_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN amri050_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_mrbh_d[l_ac].mrbh001 IS NOT NULL
               AND g_mrbh_d[l_ac].mrbh003 IS NOT NULL
               AND g_mrbh_d[l_ac].mrbh007 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mrbh_d_t.* = g_mrbh_d[l_ac].*  #BACKUP
               LET g_mrbh_d_o.* = g_mrbh_d[l_ac].*  #BACKUP
               CALL amri050_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL amri050_set_no_entry_b(l_cmd)
               OPEN amri050_bcl USING g_enterprise,g_mrbh_m.mrbh002,
                                                g_mrbh_m.mrbh006,
                                                g_mrbh_m.mrbhsite,
 
                                                g_mrbh_d_t.mrbh001
                                                ,g_mrbh_d_t.mrbh003
                                                ,g_mrbh_d_t.mrbh007
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN amri050_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amri050_bcl INTO g_mrbh_d[l_ac].mrbh001,g_mrbh_d[l_ac].mrbh003,g_mrbh_d[l_ac].mrbh004, 
                      g_mrbh_d[l_ac].mrbh005,g_mrbh_d[l_ac].mrbh007,g_mrbh_d[l_ac].mrbh008,g_mrbh_d[l_ac].mrbhstus, 
                      g_mrbh2_d[l_ac].mrbhownid,g_mrbh2_d[l_ac].mrbhowndp,g_mrbh2_d[l_ac].mrbhcrtid, 
                      g_mrbh2_d[l_ac].mrbhcrtdp,g_mrbh2_d[l_ac].mrbhcrtdt,g_mrbh2_d[l_ac].mrbhmodid, 
                      g_mrbh2_d[l_ac].mrbhmoddt,g_mrbh2_d[l_ac].mrbhcnfid,g_mrbh2_d[l_ac].mrbhcnfdt, 
                      g_mrbh2_d[l_ac].mrbh001,g_mrbh2_d[l_ac].mrbh003,g_mrbh2_d[l_ac].mrbh007
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_mrbh_d_t.mrbh001,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrbh_d_mask_o[l_ac].* =  g_mrbh_d[l_ac].*
                  CALL amri050_mrbh_t_mask()
                  LET g_mrbh_d_mask_n[l_ac].* =  g_mrbh_d[l_ac].*
                  
                  CALL amri050_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_mrbh_d_t.* TO NULL
            INITIALIZE g_mrbh_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mrbh_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrbh2_d[l_ac].mrbhownid = g_user
      LET g_mrbh2_d[l_ac].mrbhowndp = g_dept
      LET g_mrbh2_d[l_ac].mrbhcrtid = g_user
      LET g_mrbh2_d[l_ac].mrbhcrtdp = g_dept 
      LET g_mrbh2_d[l_ac].mrbhcrtdt = cl_get_current()
      LET g_mrbh2_d[l_ac].mrbhmodid = g_user
      LET g_mrbh2_d[l_ac].mrbhmoddt = cl_get_current()
      LET g_mrbh_d[l_ac].mrbhstus = ''
 
 
  
            #一般欄位預設值
                  LET g_mrbh_d[l_ac].mrbh005 = "Y"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            LET g_mrbh_d[l_ac].mrbh007 = ' '
            LET g_mrbh_d[l_ac].mrbhstus = 'Y' 
            #end add-point
            LET g_mrbh_d_t.* = g_mrbh_d[l_ac].*     #新輸入資料
            LET g_mrbh_d_o.* = g_mrbh_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amri050_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL amri050_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrbh_d[li_reproduce_target].* = g_mrbh_d[li_reproduce].*
               LET g_mrbh2_d[li_reproduce_target].* = g_mrbh2_d[li_reproduce].*
 
               LET g_mrbh_d[g_mrbh_d.getLength()].mrbh001 = NULL
               LET g_mrbh_d[g_mrbh_d.getLength()].mrbh003 = NULL
               LET g_mrbh_d[g_mrbh_d.getLength()].mrbh007 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            
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
            SELECT COUNT(1) INTO l_count FROM mrbh_t 
             WHERE mrbhent = g_enterprise AND mrbh002 = g_mrbh_m.mrbh002
               AND mrbh006 = g_mrbh_m.mrbh006
               AND mrbhsite = g_mrbh_m.mrbhsite
 
               AND mrbh001 = g_mrbh_d[l_ac].mrbh001
               AND mrbh003 = g_mrbh_d[l_ac].mrbh003
               AND mrbh007 = g_mrbh_d[l_ac].mrbh007
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               IF cl_null(g_mrbh_d[l_ac].mrbh007) THEN
                  LET g_mrbh_d[l_ac].mrbh007 = ' '
               END IF
               #end add-point
               INSERT INTO mrbh_t
                           (mrbhent,
                            mrbh006,mrbh002,mrbhsite,
                            mrbh001,mrbh003,mrbh007
                            ,mrbh004,mrbh005,mrbh008,mrbhstus,mrbhownid,mrbhowndp,mrbhcrtid,mrbhcrtdp,mrbhcrtdt,mrbhmodid,mrbhmoddt,mrbhcnfid,mrbhcnfdt) 
                     VALUES(g_enterprise,
                            g_mrbh_m.mrbh006,g_mrbh_m.mrbh002,g_mrbh_m.mrbhsite,
                            g_mrbh_d[l_ac].mrbh001,g_mrbh_d[l_ac].mrbh003,g_mrbh_d[l_ac].mrbh007
                            ,g_mrbh_d[l_ac].mrbh004,g_mrbh_d[l_ac].mrbh005,g_mrbh_d[l_ac].mrbh008,g_mrbh_d[l_ac].mrbhstus, 
                                g_mrbh2_d[l_ac].mrbhownid,g_mrbh2_d[l_ac].mrbhowndp,g_mrbh2_d[l_ac].mrbhcrtid, 
                                g_mrbh2_d[l_ac].mrbhcrtdp,g_mrbh2_d[l_ac].mrbhcrtdt,g_mrbh2_d[l_ac].mrbhmodid, 
                                g_mrbh2_d[l_ac].mrbhmoddt,g_mrbh2_d[l_ac].mrbhcnfid,g_mrbh2_d[l_ac].mrbhcnfdt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_mrbh_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mrbh_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert"
               
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
               IF amri050_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_mrbh_m.mrbh002
                  LET gs_keys[gs_keys.getLength()+1] = g_mrbh_m.mrbh006
                  LET gs_keys[gs_keys.getLength()+1] = g_mrbh_m.mrbhsite
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mrbh_d_t.mrbh001
                  LET gs_keys[gs_keys.getLength()+1] = g_mrbh_d_t.mrbh003
                  LET gs_keys[gs_keys.getLength()+1] = g_mrbh_d_t.mrbh007
 
 
                  #刪除下層單身
                  IF NOT amri050_key_delete_b(gs_keys,'mrbh_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE amri050_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE amri050_bcl
               LET l_count = g_mrbh_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_mrbh_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh001
            
            #add-point:AFTER FIELD mrbh001 name="input.a.page1.mrbh001"
            #取得資源編號的說明 
            LET g_mrbh_d[l_ac].mrbh001_desc = ' '
            CALL amri050_mrbh001_ref(g_mrbh_d[l_ac].mrbh001)
                 RETURNING g_mrbh_d[l_ac].mrbh001_desc

            #取得資源分類與作業編號  
            CALL amri050_get_mrba010_021(g_mrbh_d[l_ac].mrbh001)
                 RETURNING g_mrbh_d[l_ac].mrba010,g_mrbh_d[l_ac].mrba021

            #取得資源分類的說明 
            LET g_mrbh_d[l_ac].mrba010_desc = ' '
            CALL s_desc_get_acc_desc('1101',g_mrbh_d[l_ac].mrba010)
                 RETURNING g_mrbh_d[l_ac].mrba010_desc

            #取得作業編號的說明 
            LET g_mrbh_d[l_ac].mrba021_desc = ' '
            CALL s_desc_get_acc_desc('221',g_mrbh_d[l_ac].mrba021)
                 RETURNING g_mrbh_d[l_ac].mrba021_desc
            
            #確認資料無重複
            IF g_mrbh_m.mrbh006 IS NOT NULL AND
               g_mrbh_m.mrbh002 IS NOT NULL AND 
               g_mrbh_m.mrbhsite IS NOT NULL AND
               g_mrbh_d[g_detail_idx].mrbh001 IS NOT NULL AND
               g_mrbh_d[g_detail_idx].mrbh003 IS NOT NULL AND
               g_mrbh_d[g_detail_idx].mrbh007 IS NOT NULL THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_mrbh_m.mrbh006 != g_mrbh006_t OR
                                                   g_mrbh_m.mrbh002 != g_mrbh002_t OR 
                                                   g_mrbh_m.mrbhsite != g_mrbhsite_t OR
                                                   g_mrbh_d[g_detail_idx].mrbh001 != g_mrbh_d_t.mrbh001 OR
                                                   g_mrbh_d[g_detail_idx].mrbh003 != g_mrbh_d_t.mrbh003 OR
                                                   g_mrbh_d[g_detail_idx].mrbh007 != g_mrbh_d_t.mrbh007)) THEN
                  LET l_sql = "SELECT COUNT(*) FROM mrbh_t ",
                              " WHERE mrbhent = '",g_enterprise,"' ",
                              "   AND mrbh006 = '",g_mrbh_m.mrbh006,"' ",
                              "   AND mrbh002 = '",g_mrbh_m.mrbh002,"' ", 
                              "   AND mrbhsite = '",g_mrbh_m.mrbhsite,"'",
                              "   AND mrbh001 = '",g_mrbh_d[g_detail_idx].mrbh001,"' ",
                              "   AND mrbh003 = '",g_mrbh_d[g_detail_idx].mrbh003,"' ",
                              "   AND mrbh007 = '",g_mrbh_d[g_detail_idx].mrbh007,"' "
                  IF NOT ap_chk_notDup("",l_sql,'std-00004',0) THEN
                     LET g_mrbh_d[l_ac].mrbh001 = g_mrbh_d_t.mrbh001 
                     
                     CALL amri050_mrbh001_ref(g_mrbh_d[l_ac].mrbh001)
                          RETURNING g_mrbh_d[l_ac].mrbh001_desc

                     #取得資源分類與作業編號  
                     CALL amri050_get_mrba010_021(g_mrbh_d[l_ac].mrbh001)
                          RETURNING g_mrbh_d[l_ac].mrba010,g_mrbh_d[l_ac].mrba021

                     #取得資源分類的說明 
                     LET g_mrbh_d[l_ac].mrba010_desc = ' '
                     CALL s_desc_get_acc_desc('1101',g_mrbh_d[l_ac].mrba010)
                          RETURNING g_mrbh_d[l_ac].mrba010_desc

                     #取得作業編號的說明 
                     LET g_mrbh_d[l_ac].mrba021_desc = ' '
                     CALL s_desc_get_acc_desc('221',g_mrbh_d[l_ac].mrba021)
                          RETURNING g_mrbh_d[l_ac].mrba021_desc
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            
            IF NOT cl_null(g_mrbh_d[l_ac].mrbh001) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_mrbh_d[l_ac].mrbh001 != g_mrbh_d_o.mrbh001 )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mrbh_d[l_ac].mrbh001 
                  LET g_chkparam.arg2 = g_mrbh_m.mrbh006
                  #160318-00025#3--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
                  #160318-00025#3--add--end
                  IF NOT cl_chk_exist("v_mrba001_8") THEN
                     LET g_mrbh_d[l_ac].mrbh001 = g_mrbh_d_o.mrbh001 
                     
                     CALL amri050_mrbh001_ref(g_mrbh_d[l_ac].mrbh001)
                          RETURNING g_mrbh_d[l_ac].mrbh001_desc
                     #取得資源分類與作業編號  
                     CALL amri050_get_mrba010_021(g_mrbh_d[l_ac].mrbh001)
                          RETURNING g_mrbh_d[l_ac].mrba010,g_mrbh_d[l_ac].mrba021

                     #取得資源分類的說明 
                     LET g_mrbh_d[l_ac].mrba010_desc = ' '
                     CALL s_desc_get_acc_desc('1101',g_mrbh_d[l_ac].mrba010)
                          RETURNING g_mrbh_d[l_ac].mrba010_desc

                     #取得作業編號的說明 
                     LET g_mrbh_d[l_ac].mrba021_desc = ' '
                     CALL s_desc_get_acc_desc('221',g_mrbh_d[l_ac].mrba021)
                          RETURNING g_mrbh_d[l_ac].mrba021_desc
                     
                     NEXT FIELD CURRENT
                  END IF 
                  
                  CALL amri050_chk_mrbh001(g_mrbh_d[l_ac].mrbh001)
                  IF NOT cl_null(g_errno) THEN
                     LET g_mrbh_d[l_ac].mrbh001 = g_mrbh_d_o.mrbh001
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     CALL amri050_mrbh001_ref(g_mrbh_d[l_ac].mrbh001)
                          RETURNING g_mrbh_d[l_ac].mrbh001_desc

                     #取得資源分類與作業編號 
                     CALL amri050_get_mrba010_021(g_mrbh_d[l_ac].mrbh001)
                          RETURNING g_mrbh_d[l_ac].mrba010,g_mrbh_d[l_ac].mrba021

                     #取得資源分類的說明 
                     LET g_mrbh_d[l_ac].mrba010_desc = ' '
                     CALL s_desc_get_acc_desc('1101',g_mrbh_d[l_ac].mrba010)
                          RETURNING g_mrbh_d[l_ac].mrba010_desc

                     #取得作業編號的說明 
                     LET g_mrbh_d[l_ac].mrba021_desc = ' '
                     CALL s_desc_get_acc_desc('221',g_mrbh_d[l_ac].mrba021)
                          RETURNING g_mrbh_d[l_ac].mrba021_desc

                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_mrbh_d[l_ac].mrbh003) THEN 
                     #檢查時間是否落在其他資料的區間中 
                     LET l_cnt = 0
                     SELECT COUNT(*) INTO l_cnt
                       FROM mrbh_t
                      WHERE mrbhent = g_enterprise
                        AND mrbhsite = g_site
                        AND mrbh002 = g_mrbh002_t
                        AND mrbh006 = g_mrbh006_t
                        AND mrbh001 = g_mrbh_d[l_ac].mrbh001
                        AND mrbh003 <= g_mrbh_d[l_ac].mrbh003 
                        #ming 20150211 modify -------------------------------(S) 
                        #AND (mrbh004 IS NULL OR mrbh004 >= g_mrbh_d[l_ac].mrbh003) 
                        AND (mrbh004 IS NULL OR mrbh004 > g_mrbh_d[l_ac].mrbh003) 
                        #ming 20150211 modify -------------------------------(E) 
                        AND mrbh003 <> NVL(g_mrbh_d_t.mrbh003,' ') 
                        
                     
                     IF l_cnt > 0 THEN
                        LET g_mrbh_d[l_ac].mrbh003 = g_mrbh_d_o.mrbh003
                        #時間不可重疊 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = "art-00358"     #此輸入值不可重疊其他筆資料的起迄區間！  
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                     
                        NEXT FIELD mrbh003
                     END IF 
                  END IF 
                  
                  IF NOT cl_null(g_mrbh_d[l_ac].mrbh004) THEN 
                     #檢查時間是否落在其他資料的區間中 
                     LET l_cnt = 0
                     SELECT COUNT(*) INTO l_cnt
                       FROM mrbh_t
                      WHERE mrbhent = g_enterprise
                        AND mrbhsite = g_site
                        AND mrbh002 = g_mrbh002_t
                        AND mrbh006 = g_mrbh006_t
                        AND mrbh001 = g_mrbh_d[l_ac].mrbh001
                        AND mrbh003 <= g_mrbh_d[l_ac].mrbh004
                        #ming 20150211 ----------------------------------------(S) 
                        #AND (mrbh004 IS NULL OR mrbh004 >= g_mrbh_d[l_ac].mrbh004) 
                        AND (mrbh004 IS NULL OR mrbh004 > g_mrbh_d[l_ac].mrbh004) 
                        #ming 20150211 ----------------------------------------(E) 
                        AND mrbh003 <> NVL(g_mrbh_d_t.mrbh003,' ')
                        
                    
                     IF l_cnt > 0 THEN
                        LET g_mrbh_d[l_ac].mrbh004 = g_mrbh_d_o.mrbh004
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = "art-00358"     #此輸入值不可重疊其他筆資料的起迄區間！  
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                    
                        NEXT FIELD mrbh004
                     END IF
                  END IF 
                  
                  IF NOT cl_null(g_mrbh_d[l_ac].mrbh003) AND NOT cl_null(g_mrbh_d[l_ac].mrbh004) THEN
                     IF g_mrbh_d[l_ac].mrbh005 = 'Y' THEN
                        #可用時間  
                        CALL amri050_get_time01(g_mrbh_d[l_ac].mrbh003,g_mrbh_d[l_ac].mrbh004)
                             RETURNING g_mrbh_d[l_ac].time01
                     ELSE
                        #保修時間  
                        CALL amri050_get_time02(g_mrbh_d[l_ac].mrbh003,g_mrbh_d[l_ac].mrbh004)
                             RETURNING g_mrbh_d[l_ac].time02
                     END IF
                  END IF

               END IF
            END IF 
            
            CALL amri050_mrbh001_ref(g_mrbh_d[l_ac].mrbh001)
                 RETURNING g_mrbh_d[l_ac].mrbh001_desc

            #取得資源分類與作業編號  
            CALL amri050_get_mrba010_021(g_mrbh_d[l_ac].mrbh001)
                 RETURNING g_mrbh_d[l_ac].mrba010,g_mrbh_d[l_ac].mrba021

            #取得資源分類的說明 
            LET g_mrbh_d[l_ac].mrba010_desc = ' '
            CALL s_desc_get_acc_desc('1101',g_mrbh_d[l_ac].mrba010)
                 RETURNING g_mrbh_d[l_ac].mrba010_desc

            #取得作業編號的說明 
            LET g_mrbh_d[l_ac].mrba021_desc = ' '
            CALL s_desc_get_acc_desc('221',g_mrbh_d[l_ac].mrba021)
                 RETURNING g_mrbh_d[l_ac].mrba021_desc

            LET g_mrbh_d_o.mrbh001 = g_mrbh_d[l_ac].mrbh001


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh001
            #add-point:BEFORE FIELD mrbh001 name="input.b.page1.mrbh001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbh001
            #add-point:ON CHANGE mrbh001 name="input.g.page1.mrbh001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh003
            #add-point:BEFORE FIELD mrbh003 name="input.b.page1.mrbh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh003
            
            #add-point:AFTER FIELD mrbh003 name="input.a.page1.mrbh003"
            IF g_mrbh_m.mrbh006 IS NOT NULL AND
               g_mrbh_m.mrbh002 IS NOT NULL AND 
               g_mrbh_m.mrbhsite IS NOT NULL AND
               g_mrbh_d[g_detail_idx].mrbh001 IS NOT NULL AND
               g_mrbh_d[g_detail_idx].mrbh003 IS NOT NULL AND
               g_mrbh_d[g_detail_idx].mrbh007 IS NOT NULL THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_mrbh_m.mrbh006 != g_mrbh006_t OR
                                                   g_mrbh_m.mrbh002 != g_mrbh002_t OR 
                                                   g_mrbh_m.mrbhsite != g_mrbhsite_t OR
                                                   g_mrbh_d[g_detail_idx].mrbh001 != g_mrbh_d_t.mrbh001 OR
                                                   g_mrbh_d[g_detail_idx].mrbh003 != g_mrbh_d_t.mrbh003 OR
                                                   g_mrbh_d[g_detail_idx].mrbh007 != g_mrbh_d_t.mrbh007)) THEN
                  LET l_sql = "SELECT COUNT(*) FROM mrbh_t ",
                              " WHERE mrbhent = '",g_enterprise,"' ",
                              "   AND mrbh006 = '",g_mrbh_m.mrbh006,"' ",
                              "   AND mrbh002 = '",g_mrbh_m.mrbh002,"' ", 
                              "   AND mrbhsite = '",g_mrbh_m.mrbhsite,"'",
                              "   AND mrbh001 = '",g_mrbh_d[g_detail_idx].mrbh001,"' ",
                              "   AND mrbh003 = '",g_mrbh_d[g_detail_idx].mrbh003,"' ",
                              "   AND mrbh007 = '",g_mrbh_d[g_detail_idx].mrbh007,"' "
                  IF NOT ap_chk_notDup("",l_sql,'std-00004',0) THEN
                     LET g_mrbh_d[l_ac].mrbh003 = g_mrbh_d_t.mrbh003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            
            IF NOT cl_null(g_mrbh_d[l_ac].mrbh003) THEN
               IF g_mrbh_d[l_ac].mrbh003 != g_mrbh_d_o.mrbh003 OR
                  g_mrbh_d_o.mrbh003 IS NULL THEN
                  CALL amri050_base_time_chk(g_mrbh_d[l_ac].mrbh003)
                  IF NOT cl_null(g_errno) THEN
                     LET g_mrbh_d[l_ac].mrbh003 = g_mrbh_d_o.mrbh003
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF

                  #檢查時間是否落在其他資料的區間中 
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM mrbh_t
                   WHERE mrbhent = g_enterprise
                     AND mrbhsite = g_site
                     AND mrbh002 = g_mrbh002_t
                     AND mrbh006 = g_mrbh006_t
                     AND mrbh001 = g_mrbh_d[l_ac].mrbh001
                     AND mrbh003 <= g_mrbh_d[l_ac].mrbh003 
                     #ming 20150211 modify --------------------------------(S) 
                     #AND (mrbh004 IS NULL OR mrbh004 >= g_mrbh_d[l_ac].mrbh003) 
                     AND (mrbh004 IS NULL OR mrbh004 > g_mrbh_d[l_ac].mrbh003) 
                     #ming 20150211 modify --------------------------------(E) 
                     AND mrbh003 <> NVL(g_mrbh_d_t.mrbh003,' ') 
                     

                  IF l_cnt > 0 THEN
                     LET g_mrbh_d[l_ac].mrbh003 = g_mrbh_d_o.mrbh003
                     #時間不可重疊 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = "art-00358"     #此輸入值不可重疊其他筆資料的起迄區間！  
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF 
                  
                  IF NOT cl_null(g_mrbh_d[l_ac].mrbh004) THEN
                     IF g_mrbh_d[l_ac].mrbh003 >= g_mrbh_d[l_ac].mrbh004 THEN
                        LET g_mrbh_d[l_ac].mrbh003 = g_mrbh_d_o.mrbh003
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = "amr-00072"     #起始時間不可大於截止時間  
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()

                        NEXT FIELD CURRENT
                     END IF

                     IF g_mrbh_d[l_ac].mrbh005 = 'Y' THEN
                        #可用時間  
                        CALL amri050_get_time01(g_mrbh_d[l_ac].mrbh003,g_mrbh_d[l_ac].mrbh004)
                             RETURNING g_mrbh_d[l_ac].time01
                     ELSE
                        #保修時間  
                        CALL amri050_get_time02(g_mrbh_d[l_ac].mrbh003,g_mrbh_d[l_ac].mrbh004)
                             RETURNING g_mrbh_d[l_ac].time02
                     END IF
                  END IF

               END IF
            END IF

            LET g_mrbh_d_o.mrbh003 = g_mrbh_d[l_ac].mrbh003


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbh003
            #add-point:ON CHANGE mrbh003 name="input.g.page1.mrbh003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh004
            #add-point:BEFORE FIELD mrbh004 name="input.b.page1.mrbh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh004
            
            #add-point:AFTER FIELD mrbh004 name="input.a.page1.mrbh004"
            IF NOT cl_null(g_mrbh_d[l_ac].mrbh004) THEN
               IF g_mrbh_d[l_ac].mrbh004 != g_mrbh_d_o.mrbh004 OR
                  g_mrbh_d_o.mrbh004 IS NULL THEN
                  CALL amri050_base_time_chk(g_mrbh_d[l_ac].mrbh004)
                  IF NOT cl_null(g_errno) THEN
                     LET g_mrbh_d[l_ac].mrbh004 = g_mrbh_d_o.mrbh004
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF

                  #檢查時間是否落在其他資料的區間中 
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM mrbh_t
                   WHERE mrbhent = g_enterprise
                     AND mrbhsite = g_site
                     AND mrbh002 = g_mrbh002_t
                     AND mrbh006 = g_mrbh006_t
                     AND mrbh001 = g_mrbh_d[l_ac].mrbh001
                     AND mrbh003 < g_mrbh_d[l_ac].mrbh004 
                     #ming 20150211 modify ---------------------------------(S) 
                     #AND (mrbh004 IS NULL OR mrbh004 >= g_mrbh_d[l_ac].mrbh004) 
                     AND (mrbh004 IS NULL OR mrbh004 > g_mrbh_d[l_ac].mrbh004) 
                     #ming 20150211 modify ---------------------------------(E) 
                     AND mrbh003 <> NVL(g_mrbh_d_t.mrbh003,' ')
                     

                  IF l_cnt > 0 THEN
                     LET g_mrbh_d[l_ac].mrbh004 = g_mrbh_d_o.mrbh004
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = "art-00358"     #此輸入值不可重疊其他筆資料的起迄區間！  
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF 
                  
                  IF NOT cl_null(g_mrbh_d[l_ac].mrbh004) THEN
                     IF g_mrbh_d[l_ac].mrbh003 >= g_mrbh_d[l_ac].mrbh004 THEN
                        LET g_mrbh_d[l_ac].mrbh004 = g_mrbh_d_o.mrbh004
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = "amr-00072"     #起始時間不可大於截止時間  
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        NEXT FIELD CURRENT
                     END IF

                     IF g_mrbh_d[l_ac].mrbh005 = 'Y' THEN
                        #可用時間   
                        CALL amri050_get_time01(g_mrbh_d[l_ac].mrbh003,g_mrbh_d[l_ac].mrbh004)
                             RETURNING g_mrbh_d[l_ac].time01
                     ELSE
                        #保修時間  
                        CALL amri050_get_time02(g_mrbh_d[l_ac].mrbh003,g_mrbh_d[l_ac].mrbh004)
                             RETURNING g_mrbh_d[l_ac].time02
                     END IF
                  END IF

               END IF
            END IF

            LET g_mrbh_d_o.mrbh004 = g_mrbh_d[l_ac].mrbh004
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbh004
            #add-point:ON CHANGE mrbh004 name="input.g.page1.mrbh004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD time01
            #add-point:BEFORE FIELD time01 name="input.b.page1.time01"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD time01
            
            #add-point:AFTER FIELD time01 name="input.a.page1.time01"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE time01
            #add-point:ON CHANGE time01 name="input.g.page1.time01"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD time02
            #add-point:BEFORE FIELD time02 name="input.b.page1.time02"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD time02
            
            #add-point:AFTER FIELD time02 name="input.a.page1.time02"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE time02
            #add-point:ON CHANGE time02 name="input.g.page1.time02"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh005
            #add-point:BEFORE FIELD mrbh005 name="input.b.page1.mrbh005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh005
            
            #add-point:AFTER FIELD mrbh005 name="input.a.page1.mrbh005"
            IF g_mrbh_d[l_ac].mrbh005 = 'Y' THEN
               LET g_mrbh_d[l_ac].mrbh007 = ' '
            END IF 
            
            IF NOT cl_null(g_mrbh_d[l_ac].mrbh003) AND
               NOT cl_null(g_mrbh_d[l_ac].mrbh004) THEN
               LET g_mrbh_d[l_ac].time01 = ''
               LET g_mrbh_d[l_ac].time02 = ''
               IF g_mrbh_d[l_ac].mrbh005 = 'Y' THEN
                  CALL amri050_get_time01(g_mrbh_d[l_ac].mrbh003,g_mrbh_d[l_ac].mrbh004)
                       RETURNING g_mrbh_d[l_ac].time01
               ELSE
                  CALL amri050_get_time02(g_mrbh_d[l_ac].mrbh003,g_mrbh_d[l_ac].mrbh004)
                       RETURNING g_mrbh_d[l_ac].time02
               END IF
            END IF

            CALL amri050_set_entry_b(p_cmd)
            CALL amri050_set_no_entry_b(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbh005
            #add-point:ON CHANGE mrbh005 name="input.g.page1.mrbh005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh007
            
            #add-point:AFTER FIELD mrbh007 name="input.a.page1.mrbh007"
            LET g_mrbh_d[l_ac].mrbh007_desc = ' '
            CALL s_desc_get_acc_desc('1104',g_mrbh_d[l_ac].mrbh007)
                 RETURNING g_mrbh_d[l_ac].mrbh007_desc
            
            IF g_mrbh_m.mrbh006 IS NOT NULL AND
               g_mrbh_m.mrbh002 IS NOT NULL AND 
               g_mrbh_m.mrbhsite IS NOT NULL AND
               g_mrbh_d[g_detail_idx].mrbh001 IS NOT NULL AND
               g_mrbh_d[g_detail_idx].mrbh003 IS NOT NULL AND
               g_mrbh_d[g_detail_idx].mrbh007 IS NOT NULL THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_mrbh_m.mrbh006 != g_mrbh006_t OR
                                                   g_mrbh_m.mrbh002 != g_mrbh002_t OR 
                                                   g_mrbh_m.mrbhsite != g_mrbhsite_t OR
                                                   g_mrbh_d[g_detail_idx].mrbh001 != g_mrbh_d_t.mrbh001 OR
                                                   g_mrbh_d[g_detail_idx].mrbh003 != g_mrbh_d_t.mrbh003 OR
                                                   g_mrbh_d[g_detail_idx].mrbh007 != g_mrbh_d_t.mrbh007)) THEN
                  LET l_sql = "SELECT COUNT(*) FROM mrbh_t ",
                              " WHERE mrbhent = '",g_enterprise,"' ",
                              "   AND mrbh006 = '",g_mrbh_m.mrbh006,"' ",
                              "   AND mrbh002 = '",g_mrbh_m.mrbh002,"' ", 
                              "   AND mrbhsite = '",g_mrbh_m.mrbhsite,"'",
                              "   AND mrbh001 = '",g_mrbh_d[g_detail_idx].mrbh001,"' ",
                              "   AND mrbh003 = '",g_mrbh_d[g_detail_idx].mrbh003,"' ",
                              "   AND mrbh007 = '",g_mrbh_d[g_detail_idx].mrbh007,"' "
                  IF NOT ap_chk_notDup("",l_sql,'std-00004',0) THEN
                     LET g_mrbh_d[l_ac].mrbh007 = g_mrbh_d_t.mrbh007 
                     CALL s_desc_get_acc_desc('1104',g_mrbh_d[l_ac].mrbh007)
                          RETURNING g_mrbh_d[l_ac].mrbh007_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_mrbh_d[l_ac].mrbh007) THEN 
               IF g_mrbh_d[l_ac].mrbh007 != g_mrbh_d_o.mrbh007 OR g_mrbh_d_o.mrbh007 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = '1104'
                  LET g_chkparam.arg2 = g_mrbh_d[l_ac].mrbh007
                  #160318-00025#3--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
                  #160318-00025#3--add--end
                  IF NOT cl_chk_exist("v_oocq002_01") THEN
                     LET g_mrbh_d[l_ac].mrbh007 = g_mrbh_d_o.mrbh007

                     CALL s_desc_get_acc_desc('1104',g_mrbh_d[l_ac].mrbh007)
                          RETURNING g_mrbh_d[l_ac].mrbh007_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            
            CALL s_desc_get_acc_desc('1104',g_mrbh_d[l_ac].mrbh007)
                 RETURNING g_mrbh_d[l_ac].mrbh007_desc

            LET g_mrbh_d_o.mrbh007 = g_mrbh_d[l_ac].mrbh007

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh007
            #add-point:BEFORE FIELD mrbh007 name="input.b.page1.mrbh007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbh007
            #add-point:ON CHANGE mrbh007 name="input.g.page1.mrbh007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbh008
            #add-point:BEFORE FIELD mrbh008 name="input.b.page1.mrbh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbh008
            
            #add-point:AFTER FIELD mrbh008 name="input.a.page1.mrbh008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbh008
            #add-point:ON CHANGE mrbh008 name="input.g.page1.mrbh008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbhstus
            #add-point:BEFORE FIELD mrbhstus name="input.b.page1.mrbhstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbhstus
            
            #add-point:AFTER FIELD mrbhstus name="input.a.page1.mrbhstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbhstus
            #add-point:ON CHANGE mrbhstus name="input.g.page1.mrbhstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mrbh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh001
            #add-point:ON ACTION controlp INFIELD mrbh001 name="input.c.page1.mrbh001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrbh_d[l_ac].mrbh001             #給予default值 
            
            #mrba000 = 1 拿掉  
            #改成工作站、班別有設的都可以 
            #LET g_qryparam.where = " mrba000 = '1' AND mrba022 = '",g_mrbh_m.mrbh006,"' " 
            LET g_qryparam.where = " mrbasite = '",g_site,"' AND mrba103 IS NOT NULL AND mrba022 = '",g_mrbh_m.mrbh006,"' "
            CALL q_mrba001()                                #呼叫開窗

            LET g_mrbh_d[l_ac].mrbh001 = g_qryparam.return1              

            DISPLAY g_mrbh_d[l_ac].mrbh001 TO mrbh001              #
            CALL amri050_mrbh001_ref(g_mrbh_d[l_ac].mrbh001)
                 RETURNING g_mrbh_d[l_ac].mrbh001_desc

            #取得資源分類與作業編號 
            CALL amri050_get_mrba010_021(g_mrbh_d[l_ac].mrbh001)
                 RETURNING g_mrbh_d[l_ac].mrba010,g_mrbh_d[l_ac].mrba021

            #取得資源分類的說明 
            LET g_mrbh_d[l_ac].mrba010_desc = ' '
            CALL s_desc_get_acc_desc('1101',g_mrbh_d[l_ac].mrba010)
                 RETURNING g_mrbh_d[l_ac].mrba010_desc

            #取得作業編號的說明 
            LET g_mrbh_d[l_ac].mrba021_desc = ' '
            CALL s_desc_get_acc_desc('221',g_mrbh_d[l_ac].mrba021)
                 RETURNING g_mrbh_d[l_ac].mrba021_desc
            NEXT FIELD mrbh001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh003
            #add-point:ON ACTION controlp INFIELD mrbh003 name="input.c.page1.mrbh003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh004
            #add-point:ON ACTION controlp INFIELD mrbh004 name="input.c.page1.mrbh004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.time01
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD time01
            #add-point:ON ACTION controlp INFIELD time01 name="input.c.page1.time01"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.time02
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD time02
            #add-point:ON ACTION controlp INFIELD time02 name="input.c.page1.time02"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbh005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh005
            #add-point:ON ACTION controlp INFIELD mrbh005 name="input.c.page1.mrbh005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbh007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh007
            #add-point:ON ACTION controlp INFIELD mrbh007 name="input.c.page1.mrbh007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrbh_d[l_ac].mrbh007             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "1104" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_mrbh_d[l_ac].mrbh007 = g_qryparam.return1              
            #LET g_mrbh_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_mrbh_d[l_ac].mrbh007 TO mrbh007              #
            #DISPLAY g_mrbh_d[l_ac].oocq002 TO oocq002 #應用分類碼 
            CALL s_desc_get_acc_desc('1104',g_mrbh_d[l_ac].mrbh007)
                 RETURNING g_mrbh_d[l_ac].mrbh007_desc
            NEXT FIELD mrbh007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbh008
            #add-point:ON ACTION controlp INFIELD mrbh008 name="input.c.page1.mrbh008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbhstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbhstus
            #add-point:ON ACTION controlp INFIELD mrbhstus name="input.c.page1.mrbhstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mrbh_d[l_ac].* = g_mrbh_d_t.*
               CLOSE amri050_bcl
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
               LET g_errparam.extend = g_mrbh_d[l_ac].mrbh001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_mrbh_d[l_ac].* = g_mrbh_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_mrbh2_d[l_ac].mrbhmodid = g_user 
LET g_mrbh2_d[l_ac].mrbhmoddt = cl_get_current()
LET g_mrbh2_d[l_ac].mrbhmodid_desc = cl_get_username(g_mrbh2_d[l_ac].mrbhmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               IF cl_null(g_mrbh_d[l_ac].mrbh007) THEN
                  LET g_mrbh_d[l_ac].mrbh007 = ' '
               END IF
               #end add-point
         
               #將遮罩欄位還原
               CALL amri050_mrbh_t_mask_restore('restore_mask_o')
         
               UPDATE mrbh_t SET (mrbh002,mrbh006,mrbhsite,mrbh001,mrbh003,mrbh004,mrbh005,mrbh007,mrbh008, 
                   mrbhstus,mrbhownid,mrbhowndp,mrbhcrtid,mrbhcrtdp,mrbhcrtdt,mrbhmodid,mrbhmoddt,mrbhcnfid, 
                   mrbhcnfdt) = (g_mrbh_m.mrbh002,g_mrbh_m.mrbh006,g_mrbh_m.mrbhsite,g_mrbh_d[l_ac].mrbh001, 
                   g_mrbh_d[l_ac].mrbh003,g_mrbh_d[l_ac].mrbh004,g_mrbh_d[l_ac].mrbh005,g_mrbh_d[l_ac].mrbh007, 
                   g_mrbh_d[l_ac].mrbh008,g_mrbh_d[l_ac].mrbhstus,g_mrbh2_d[l_ac].mrbhownid,g_mrbh2_d[l_ac].mrbhowndp, 
                   g_mrbh2_d[l_ac].mrbhcrtid,g_mrbh2_d[l_ac].mrbhcrtdp,g_mrbh2_d[l_ac].mrbhcrtdt,g_mrbh2_d[l_ac].mrbhmodid, 
                   g_mrbh2_d[l_ac].mrbhmoddt,g_mrbh2_d[l_ac].mrbhcnfid,g_mrbh2_d[l_ac].mrbhcnfdt)
                WHERE mrbhent = g_enterprise AND mrbh002 = g_mrbh_m.mrbh002 
                 AND mrbh006 = g_mrbh_m.mrbh006 
                 AND mrbhsite = g_mrbh_m.mrbhsite 
 
                 AND mrbh001 = g_mrbh_d_t.mrbh001 #項次   
                 AND mrbh003 = g_mrbh_d_t.mrbh003  
                 AND mrbh007 = g_mrbh_d_t.mrbh007  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbh_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "mrbh_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrbh_m.mrbh002
               LET gs_keys_bak[1] = g_mrbh002_t
               LET gs_keys[2] = g_mrbh_m.mrbh006
               LET gs_keys_bak[2] = g_mrbh006_t
               LET gs_keys[3] = g_mrbh_m.mrbhsite
               LET gs_keys_bak[3] = g_mrbhsite_t
               LET gs_keys[4] = g_mrbh_d[g_detail_idx].mrbh001
               LET gs_keys_bak[4] = g_mrbh_d_t.mrbh001
               LET gs_keys[5] = g_mrbh_d[g_detail_idx].mrbh003
               LET gs_keys_bak[5] = g_mrbh_d_t.mrbh003
               LET gs_keys[6] = g_mrbh_d[g_detail_idx].mrbh007
               LET gs_keys_bak[6] = g_mrbh_d_t.mrbh007
               CALL amri050_update_b('mrbh_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_mrbh_m),util.JSON.stringify(g_mrbh_d_t)
                     LET g_log2 = util.JSON.stringify(g_mrbh_m),util.JSON.stringify(g_mrbh_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amri050_mrbh_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_mrbh_m.mrbh002
               LET ls_keys[ls_keys.getLength()+1] = g_mrbh_m.mrbh006
               LET ls_keys[ls_keys.getLength()+1] = g_mrbh_m.mrbhsite
 
               LET ls_keys[ls_keys.getLength()+1] = g_mrbh_d_t.mrbh001
               LET ls_keys[ls_keys.getLength()+1] = g_mrbh_d_t.mrbh003
               LET ls_keys[ls_keys.getLength()+1] = g_mrbh_d_t.mrbh007
 
               CALL amri050_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE amri050_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mrbh_d[l_ac].* = g_mrbh_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE amri050_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_mrbh_d.getLength() = 0 THEN
               NEXT FIELD mrbh001
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mrbh_d[li_reproduce_target].* = g_mrbh_d[li_reproduce].*
               LET g_mrbh2_d[li_reproduce_target].* = g_mrbh2_d[li_reproduce].*
 
               LET g_mrbh_d[li_reproduce_target].mrbh001 = NULL
               LET g_mrbh_d[li_reproduce_target].mrbh003 = NULL
               LET g_mrbh_d[li_reproduce_target].mrbh007 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrbh_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrbh_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_mrbh2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL amri050_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL amri050_idx_chk()
            CALL amri050_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
         
      END DISPLAY
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         #因為底下的硬框架會讓程式在新增的情況下 
         #讓游標位在下方的日期 所以copy出來改寫  
         IF p_cmd = 'a' THEN
            NEXT FIELD mrbh006
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mrbh001
               WHEN "s_detail2"
                  NEXT FIELD mrbhownid
            END CASE
         END IF
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD mrbh002
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mrbh001
               WHEN "s_detail2"
                  NEXT FIELD mrbhownid
 
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
   CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
   #ming 20150512 mark --------------------(S) 
   #不再重新產生單身，可讓user微調 
   #CALL amri050_rebuild_body()
   #ming 20150512 mark --------------------(E)
   CALL amri050_b_fill(g_wc2)
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION amri050_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL amri050_b_fill(g_wc2) #第一階單身填充
      CALL amri050_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL amri050_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_mrbh_m.mrbh006,g_mrbh_m.mrbh006_desc,g_mrbh_m.mrbh002,g_mrbh_m.mrbhsite
 
   CALL amri050_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION amri050_ref_show()
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
   
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mrbh_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_mrbh2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="amri050.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION amri050_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE mrbh_t.mrbh002 
   DEFINE l_oldno     LIKE mrbh_t.mrbh002 
   DEFINE l_newno02     LIKE mrbh_t.mrbh006 
   DEFINE l_oldno02     LIKE mrbh_t.mrbh006 
   DEFINE l_newno03     LIKE mrbh_t.mrbhsite 
   DEFINE l_oldno03     LIKE mrbh_t.mrbhsite 
 
   DEFINE l_master    RECORD LIKE mrbh_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mrbh_t.* #此變數樣板目前無使用
 
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
 
   IF g_mrbh_m.mrbh002 IS NULL
      OR g_mrbh_m.mrbh006 IS NULL
      OR g_mrbh_m.mrbhsite IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_mrbh002_t = g_mrbh_m.mrbh002
   LET g_mrbh006_t = g_mrbh_m.mrbh006
   LET g_mrbhsite_t = g_mrbh_m.mrbhsite
 
   
   LET g_mrbh_m.mrbh002 = ""
   LET g_mrbh_m.mrbh006 = ""
   LET g_mrbh_m.mrbhsite = ""
 
   LET g_master_insert = FALSE
   CALL amri050_set_entry('a')
   CALL amri050_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_mrbh_m.mrbh006_desc = ''
   DISPLAY BY NAME g_mrbh_m.mrbh006_desc
 
   
   CALL amri050_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_mrbh_m.* TO NULL
      INITIALIZE g_mrbh_d TO NULL
      INITIALIZE g_mrbh2_d TO NULL
 
      CALL amri050_show()
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
   CALL amri050_set_act_visible()
   CALL amri050_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_mrbh002_t = g_mrbh_m.mrbh002
   LET g_mrbh006_t = g_mrbh_m.mrbh006
   LET g_mrbhsite_t = g_mrbh_m.mrbhsite
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrbhent = " ||g_enterprise|| " AND",
                      " mrbh002 = '", g_mrbh_m.mrbh002, "' "
                      ," AND mrbh006 = '", g_mrbh_m.mrbh006, "' "
                      ," AND mrbhsite = '", g_mrbh_m.mrbhsite, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amri050_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL amri050_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL amri050_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION amri050_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mrbh_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE amri050_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrbh_t
    WHERE mrbhent = g_enterprise AND mrbh002 = g_mrbh002_t
    AND mrbh006 = g_mrbh006_t
    AND mrbhsite = g_mrbhsite_t
 
       INTO TEMP amri050_detail
   
   #將key修正為調整後   
   UPDATE amri050_detail 
      #更新key欄位
      SET mrbh002 = g_mrbh_m.mrbh002
          , mrbh006 = g_mrbh_m.mrbh006
          , mrbhsite = g_mrbh_m.mrbhsite
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , mrbhownid = g_user 
       , mrbhowndp = g_dept
       , mrbhcrtid = g_user
       , mrbhcrtdp = g_dept 
       , mrbhcrtdt = ld_date
       , mrbhmodid = g_user
       , mrbhmoddt = ld_date
      #, mrbhstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO mrbh_t SELECT * FROM amri050_detail
   
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
   DROP TABLE amri050_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mrbh002_t = g_mrbh_m.mrbh002
   LET g_mrbh006_t = g_mrbh_m.mrbh006
   LET g_mrbhsite_t = g_mrbh_m.mrbhsite
 
   
   DROP TABLE amri050_detail
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amri050_delete()
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
   
   IF g_mrbh_m.mrbh002 IS NULL
   OR g_mrbh_m.mrbh006 IS NULL
   OR g_mrbh_m.mrbhsite IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN amri050_cl USING g_enterprise,g_mrbh_m.mrbh002,g_mrbh_m.mrbh006,g_mrbh_m.mrbhsite
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amri050_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE amri050_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amri050_master_referesh USING g_mrbh_m.mrbh002,g_mrbh_m.mrbh006,g_mrbh_m.mrbhsite INTO g_mrbh_m.mrbh006, 
       g_mrbh_m.mrbh002,g_mrbh_m.mrbhsite,g_mrbh_m.mrbh006_desc
   
   #遮罩相關處理
   LET g_mrbh_m_mask_o.* =  g_mrbh_m.*
   CALL amri050_mrbh_t_mask()
   LET g_mrbh_m_mask_n.* =  g_mrbh_m.*
   
   CALL amri050_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amri050_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM mrbh_t WHERE mrbhent = g_enterprise AND mrbh002 = g_mrbh_m.mrbh002
                                                               AND mrbh006 = g_mrbh_m.mrbh006
                                                               AND mrbhsite = g_mrbh_m.mrbhsite
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbh_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE amri050_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_mrbh_d.clear() 
      CALL g_mrbh2_d.clear()       
 
     
      CALL amri050_ui_browser_refresh()  
      #CALL amri050_ui_headershow()  
      #CALL amri050_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL amri050_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL amri050_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE amri050_cl
 
   #功能已完成,通報訊息中心
   CALL amri050_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="amri050.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amri050_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_mrbh_d.clear()
   CALL g_mrbh2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT mrbh001,mrbh003,mrbh004,mrbh005,mrbh007,mrbh008,mrbhstus,mrbhownid, 
       mrbhowndp,mrbhcrtid,mrbhcrtdp,mrbhcrtdt,mrbhmodid,mrbhmoddt,mrbhcnfid,mrbhcnfdt,mrbh001,mrbh003, 
       mrbh007,t1.mrba004 ,t4.oocql004 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 , 
       t10.ooag011 FROM mrbh_t",   
               "",
               
                              " LEFT JOIN mrba_t t1 ON t1.mrbaent="||g_enterprise||" AND t1.mrbasite=mrbhsite AND t1.mrba001=mrbh001  ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='1104' AND t4.oocql002=mrbh007 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=mrbhownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=mrbhowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=mrbhcrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=mrbhcrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=mrbhmodid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=mrbhcnfid  ",
 
               " WHERE mrbhent= ? AND mrbh002=? AND mrbh006=? AND mrbhsite=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("mrbh_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF amri050_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY mrbh_t.mrbh001,mrbh_t.mrbh003,mrbh_t.mrbh007"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amri050_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR amri050_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mrbh_m.mrbh002,g_mrbh_m.mrbh006,g_mrbh_m.mrbhsite   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mrbh_m.mrbh002,g_mrbh_m.mrbh006,g_mrbh_m.mrbhsite INTO g_mrbh_d[l_ac].mrbh001, 
          g_mrbh_d[l_ac].mrbh003,g_mrbh_d[l_ac].mrbh004,g_mrbh_d[l_ac].mrbh005,g_mrbh_d[l_ac].mrbh007, 
          g_mrbh_d[l_ac].mrbh008,g_mrbh_d[l_ac].mrbhstus,g_mrbh2_d[l_ac].mrbhownid,g_mrbh2_d[l_ac].mrbhowndp, 
          g_mrbh2_d[l_ac].mrbhcrtid,g_mrbh2_d[l_ac].mrbhcrtdp,g_mrbh2_d[l_ac].mrbhcrtdt,g_mrbh2_d[l_ac].mrbhmodid, 
          g_mrbh2_d[l_ac].mrbhmoddt,g_mrbh2_d[l_ac].mrbhcnfid,g_mrbh2_d[l_ac].mrbhcnfdt,g_mrbh2_d[l_ac].mrbh001, 
          g_mrbh2_d[l_ac].mrbh003,g_mrbh2_d[l_ac].mrbh007,g_mrbh_d[l_ac].mrbh001_desc,g_mrbh_d[l_ac].mrbh007_desc, 
          g_mrbh2_d[l_ac].mrbhownid_desc,g_mrbh2_d[l_ac].mrbhowndp_desc,g_mrbh2_d[l_ac].mrbhcrtid_desc, 
          g_mrbh2_d[l_ac].mrbhcrtdp_desc,g_mrbh2_d[l_ac].mrbhmodid_desc,g_mrbh2_d[l_ac].mrbhcnfid_desc  
            #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #取得資源分類與作業編號  
         CALL amri050_get_mrba010_021(g_mrbh_d[l_ac].mrbh001)
              RETURNING g_mrbh_d[l_ac].mrba010,g_mrbh_d[l_ac].mrba021

         #取得資源分類的說明 
         LET g_mrbh_d[l_ac].mrba010_desc = ' '
         CALL s_desc_get_acc_desc('1101',g_mrbh_d[l_ac].mrba010)
              RETURNING g_mrbh_d[l_ac].mrba010_desc

         #取得作業編號的說明 
         LET g_mrbh_d[l_ac].mrba021_desc = ' '
         CALL s_desc_get_acc_desc('221',g_mrbh_d[l_ac].mrba021)
              RETURNING g_mrbh_d[l_ac].mrba021_desc    
              
         IF NOT cl_null(g_mrbh_d[l_ac].mrbh003) AND 
            NOT cl_null(g_mrbh_d[l_ac].mrbh004) THEN 
            IF g_mrbh_d[l_ac].mrbh005 = 'Y' THEN 
               CALL amri050_get_time01(g_mrbh_d[l_ac].mrbh003,g_mrbh_d[l_ac].mrbh004)
                    RETURNING g_mrbh_d[l_ac].time01
            ELSE 
               CALL amri050_get_time02(g_mrbh_d[l_ac].mrbh003,g_mrbh_d[l_ac].mrbh004)
                    RETURNING g_mrbh_d[l_ac].time02            
            END IF 
         END IF     
         
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
 
            CALL g_mrbh_d.deleteElement(g_mrbh_d.getLength())
      CALL g_mrbh2_d.deleteElement(g_mrbh2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_mrbh_d.getLength()
      LET g_mrbh_d_mask_o[l_ac].* =  g_mrbh_d[l_ac].*
      CALL amri050_mrbh_t_mask()
      LET g_mrbh_d_mask_n[l_ac].* =  g_mrbh_d[l_ac].*
   END FOR
   
   LET g_mrbh2_d_mask_o.* =  g_mrbh2_d.*
   FOR l_ac = 1 TO g_mrbh2_d.getLength()
      LET g_mrbh2_d_mask_o[l_ac].* =  g_mrbh2_d[l_ac].*
      CALL amri050_mrbh_t_mask()
      LET g_mrbh2_d_mask_n[l_ac].* =  g_mrbh2_d[l_ac].*
   END FOR
 
 
   FREE amri050_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION amri050_idx_chk()
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
      IF g_detail_idx > g_mrbh_d.getLength() THEN
         LET g_detail_idx = g_mrbh_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_mrbh_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mrbh_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_mrbh2_d.getLength() THEN
         LET g_detail_idx = g_mrbh2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mrbh2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mrbh2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION amri050_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_mrbh_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION amri050_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM mrbh_t
    WHERE mrbhent = g_enterprise AND mrbh002 = g_mrbh_m.mrbh002 AND
                              mrbh006 = g_mrbh_m.mrbh006 AND
                              mrbhsite = g_mrbh_m.mrbhsite AND
 
          mrbh001 = g_mrbh_d_t.mrbh001
      AND mrbh003 = g_mrbh_d_t.mrbh003
      AND mrbh007 = g_mrbh_d_t.mrbh007
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "mrbh_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後 name="delete.body.a_single_delete"
   
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="amri050.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amri050_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="amri050.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amri050_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="amri050.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amri050_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="amri050.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION amri050_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_mrbh_d[l_ac].mrbh001 = g_mrbh_d_t.mrbh001 
      AND g_mrbh_d[l_ac].mrbh003 = g_mrbh_d_t.mrbh003 
      AND g_mrbh_d[l_ac].mrbh007 = g_mrbh_d_t.mrbh007 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION amri050_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="amri050.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amri050_lock_b(ps_table,ps_page)
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
   #CALL amri050_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="amri050.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amri050_unlock_b(ps_table,ps_page)
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
 
{<section id="amri050.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION amri050_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mrbh002,mrbh006,mrbhsite",TRUE)
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
 
{<section id="amri050.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION amri050_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mrbh002,mrbh006,mrbhsite",FALSE)
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
 
{<section id="amri050.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amri050_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CALL cl_set_comp_entry("mrbh007",TRUE)
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amri050_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   IF g_mrbh_d[l_ac].mrbh005 = 'Y' THEN
      CALL cl_set_comp_entry("mrbh007",FALSE)
   END IF
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION amri050_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amri050.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION amri050_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amri050.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION amri050_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amri050.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION amri050_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amri050.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amri050_default_search()
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
      LET ls_wc = ls_wc, " mrbh002 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " mrbh006 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " mrbhsite = '", g_argv[03], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
#160826-00015#1-s add
   IF NOT cl_null(g_argv[04]) THEN
      IF cl_null(ls_wc) THEN
         LET ls_wc = g_argv[04], " AND "
      ELSE
         LET ls_wc = ls_wc, g_argv[04], " AND "
      END IF
   END IF
#160826-00015#1-e add
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
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amri050.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION amri050_fill_chk(ps_idx)
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
 
{<section id="amri050.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION amri050_modify_detail_chk(ps_record)
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
         LET ls_return = "mrbh001"
      WHEN "s_detail2"
         LET ls_return = "mrbhownid"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="amri050.mask_functions" >}
&include "erp/amr/amri050_mask.4gl"
 
{</section>}
 
{<section id="amri050.state_change" >}
    
 
{</section>}
 
{<section id="amri050.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amri050_set_pk_array()
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
   LET g_pk_array[1].values = g_mrbh_m.mrbh002
   LET g_pk_array[1].column = 'mrbh002'
   LET g_pk_array[2].values = g_mrbh_m.mrbh006
   LET g_pk_array[2].column = 'mrbh006'
   LET g_pk_array[3].values = g_mrbh_m.mrbhsite
   LET g_pk_array[3].column = 'mrbhsite'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amri050.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION amri050_msgcentre_notify(lc_state)
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
   CALL amri050_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mrbh_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amri050.other_function" readonly="Y" >}

PRIVATE FUNCTION amri050_mrbh006_ref(p_ecaa001)
   DEFINE p_ecaa001     LIKE ecaa_t.ecaa001
   DEFINE r_ecaa002     LIKE ecaa_t.ecaa002

   LET r_ecaa002 = ''
   #因為工作站有可能會是一個空白 所以就不浪費效能了  
   IF cl_null(p_ecaa001) THEN
      RETURN r_ecaa002
   END IF

   SELECT ecaa002 INTO r_ecaa002
     FROM ecaa_t
    WHERE ecaaent  = g_enterprise
      AND ecaasite = g_site
      AND ecaa001  = p_ecaa001

   RETURN r_ecaa002
END FUNCTION

################################################################################
# Descriptions...: 設置HH:MM的輸入格式
# Memo...........:
# Usage..........: CALL amri050_set_time_format(ps_tabname,ps_field)
# Date & Author..: 2014/07/23 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION amri050_set_time_format(ps_tabname,ps_field)
   DEFINE ps_tabname   STRING
   DEFINE ps_field     STRING
   DEFINE lwin_curr    ui.Window
   DEFINE lfrm_curr    ui.Form
   DEFINE lnode_item   om.DomNode
   DEFINE lnode_child  om.DomNode
   DEFINE ls_picture   STRING        #格式設定 
   DEFINE li_i         LIKE type_t.num10
   DEFINE ls_sql       STRING

   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()

   IF lfrm_curr IS NULL THEN
      RETURN
   END IF 
   
   LET lnode_item = lfrm_curr.findNode("FormField",ps_tabname||"."||ps_FIELD)
   IF lnode_item IS NULL THEN
      LET lnode_item = lfrm_curr.findNode("TableColumn",ps_tabNAME||"."||ps_field)
      IF lnode_item IS NULL THEN
         LET lnode_item = lfrm_curr.findNode("Matrix",ps_tabname||"."||ps_field)
         IF lnode_item IS NULL THEN
            RETURN
         END IF
      END IF
   END IF

   LET lnode_child = lnode_item.getFirstChild()

   FOR li_i = 1 TO 2
      LET ls_picture = ls_PICTURE,"#"
   END FOR

   LET ls_picture = ls_picture,":"

   FOR li_i = 1 TO 2
      LET ls_picture = ls_picture,"#"
   END FOR

   CALL lnode_child.setAttribute("picture",ls_picture)
END FUNCTION

################################################################################
# Descriptions...: 針對時間做基本檢查
# Memo...........:
# Usage..........: CALL amri050_base_time_chk(p_time)
# Input parameter: p_time：  HH:MM的日期格式 
# Date & Author..: 2014/07/23 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION amri050_base_time_chk(p_time)
   DEFINE p_time     LIKE mrbh_t.mrbh003
   DEFINE l_hh       LIKE type_t.chr8
   DEFINE l_mm       LIKE type_t.chr8 
   DEFINE l_str      STRING 

   LET g_errno = '' 
   
   LET l_str = p_time
   IF l_str.getLength() <> 5 THEN
      LET g_errno = 'amr-00073'    #不正確的時間格式！   
      RETURN 
   END IF

   #LET l_hh = p_time[1,2]
   #LET l_mm = p_time[4,5]

   #IF l_hh < 0 OR l_hh > 23 THEN
   #   LET g_errno = 'amr-00074'          #輸入值需要在0-23之間  
   #   RETURN 
   #END IF

   #IF l_mm < 0 OR l_mm > 59 THEN
   #   LET g_errno = 'amr-00075'          #輸入值需要在0-59之間  
   #   RETURN 
   #END IF 
   
   IF p_time < '00:00' OR p_time > '24:00' THEN 
      LET g_errno = 'amr-00086'           #時間需介於00:00~24:00之間！
      RETURN 
   END IF 
END FUNCTION

PRIVATE FUNCTION amri050_mrbh001_ref(p_mrba001)
   DEFINE p_mrba001     LIKE mrba_t.mrba001
   DEFINE r_mrba004     LIKE mrba_t.mrba004

   LET r_mrba004 = ''
   SELECT mrba004 INTO r_mrba004
     FROM mrba_t
    WHERE mrbaent  = g_enterprise
      AND mrbasite = g_site
      AND mrba001  = p_mrba001

   RETURN r_mrba004
END FUNCTION

################################################################################
# Descriptions...: 取得資源分類與作業編號
# Memo...........:
# Usage..........: CALL amri050_get_mrba010_021(p_mrba001)
#                  RETURNING r_mrba010,r_mrba021
# Input parameter: p_mrba001
# Return code....: r_mrba010
#                : r_mrba021
# Date & Author..: 2014/07/24 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION amri050_get_mrba010_021(p_mrba001)
   DEFINE p_mrba001     LIKE mrba_t.mrba001
   DEFINE r_mrba010     LIKE mrba_t.mrba010
   DEFINE r_mrba021     LIKE mrba_t.mrba021

   LET r_mrba010 = ''
   LET r_mrba021 = ''

   SELECT mrba010,mrba021 INTO r_mrba010,r_mrba021
     FROM mrba_t
    WHERE mrbaent  = g_enterprise
      AND mrbasite = g_site
      AND mrba001  = p_mrba001

   RETURN r_mrba010,r_mrba021
END FUNCTION

################################################################################
# Descriptions...: 檢查此資源編號是否存在其他的工作站中 
# Memo...........:
# Usage..........: CALL amri050_chk_mrbh001(p_mrbh001)
# Input parameter: p_mrbh001
# Date & Author..: 2014/07/24 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION amri050_chk_mrbh001(p_mrbh001)
   DEFINE p_mrbh001     LIKE mrbh_t.mrbh001
   DEFINE l_cnt         LIKE type_t.num5

   LET g_errno = ''

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM mrbh_t
    WHERE mrbhent  = g_enterprise
      AND mrbhsite = g_site
      AND mrbh006  <> g_mrbh006_t
      AND mrbh001  = p_mrbh001

   IF l_cnt > 0 THEN
      LET g_errno = 'amr-00076'        #此資源編號已存在其他的工作站中  
   END IF
END FUNCTION

################################################################################
# Descriptions...: 計算可用時間(hr)
# Memo...........:
# Usage..........: CALL amri050_get_time01(p_mrbh003,p_mrbh004)
#                  RETURNING r_time01
# Input parameter: p_mrbh003：開始時間
#                : p_mrbh004：結束時間
# Return code....: r_time01：可用時間
# Date & Author..: 2014/07/24 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION amri050_get_time01(p_mrbh003,p_mrbh004)
   DEFINE p_mrbh003     LIKE mrbh_t.mrbh003
   DEFINE p_mrbh004     LIKE mrbh_t.mrbh004
   DEFINE r_time01      LIKE type_t.num15_3
   DEFINE l_mrbh003_h   LIKE type_t.num5       #開始時間的小時   
   DEFINE l_mrbh004_h   LIKE type_t.num5       #結束時間的小時   
   DEFINE l_mrbh003_m   LIKE type_t.num5       #開始時間的分鐘 
   DEFINE l_mrbh004_m   LIKE type_t.num5       #結束時間的分鐘 

   LET r_time01 = 0

   LET l_mrbh003_h = p_mrbh003[1,2]
   LET l_mrbh004_h = p_mrbh004[1,2]
   LET l_mrbh003_m = p_mrbh003[4,5]
   LET l_mrbh004_m = p_mrbh004[4,5]

   LET r_time01 = (l_mrbh004_h * 60 + l_mrbh004_m) -
                  (l_mrbh003_h * 60 + l_mrbh003_m)

   LET r_time01 = r_time01 / 60

   RETURN r_time01
END FUNCTION

################################################################################
# Descriptions...: 計算保修時間
# Memo...........:
# Usage..........: CALL amri050_get_time02(p_mrbh003,p_mrbh004)
#                  RETURNING r_time02
# Input parameter: p_mrbh003：開始時間
#                : p_mrbh004：結束時間
# Return code....: r_time02：保修時間
# Date & Author..: 2014/07/24 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION amri050_get_time02(p_mrbh003,p_mrbh004)
   DEFINE p_mrbh003     LIKE mrbh_t.mrbh003
   DEFINE p_mrbh004     LIKE mrbh_t.mrbh004
   DEFINE r_time02      LIKE type_t.num15_3
   DEFINE l_mrbh003_h   LIKE type_t.num5       #開始時間的小時   
   DEFINE l_mrbh004_h   LIKE type_t.num5       #結束時間的小時   
   DEFINE l_mrbh003_m   LIKE type_t.num5       #開始時間的分鐘 
   DEFINE l_mrbh004_m   LIKE type_t.num5       #結束時間的分鐘 

   LET l_mrbh003_h = p_mrbh003[1,2]
   LET l_mrbh004_h = p_mrbh004[1,2]
   LET l_mrbh003_m = p_mrbh003[4,5]
   LET l_mrbh004_m = p_mrbh004[4,5]

   LET r_time02 = (l_mrbh004_h * 60 + l_mrbh004_m) -
                  (l_mrbh003_h * 60 + l_mrbh003_m)

   RETURN r_time02
END FUNCTION

################################################################################
# Descriptions...: 重新產生單身資料
# Memo...........:
# Usage..........: CALL amri050_rebuild_body()
# Date & Author..: 2014/09/04 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION amri050_rebuild_body()
   DEFINE l_sql      STRING
   DEFINE l_mrbh001  LIKE mrbh_t.mrbh001     #資源編號  
   DEFINE l_mrbh002  LIKE mrbh_t.mrbh002     #日期  
   DEFINE l_mrba103  LIKE mrba_t.mrba103     #嫁動班別  
   DEFINE l_success  LIKE type_t.num5

   LET l_sql = "SELECT DISTINCT mrbh001,mrbh002 ",
               "  FROM mrbh_t ",
               " WHERE mrbhent  = '",g_enterprise,"' ",
               "   AND mrbhsite = '",g_site,"' ",
               "   AND mrbh006  = '",g_mrbh_m.mrbh006,"' ",
               "   AND mrbh002  = '",g_mrbh_m.mrbh002,"' " #,  #ming 2014/12/01 mark , 
               #"   AND mrbh005  = 'Y' "                       #ming 2014/12/01 mark 
   PREPARE amri050_rebuild_body_prep FROM l_sql
   DECLARE amri050_rebuild_body_curs CURSOR WITH HOLD FOR amri050_rebuild_body_prep

   LET l_success = TRUE
   CALL s_transaction_begin()
   FOREACH amri050_rebuild_body_curs INTO l_mrbh001,l_mrbh002
      LET l_mrba103 = '' 
      SELECT mrba103 INTO l_mrba103
        FROM mrba_t
       WHERE mrbaent  = g_enterprise
         AND mrbasite = g_site
         AND mrba001  = l_mrbh001

      IF cl_null(l_mrba103) THEN
         LET l_success = FALSE

         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_mrbh001
         LET g_errparam.code   = "sub-00455"         #班別不可為空!  
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL s_ins_able_time(l_mrbh001,l_mrbh002,l_mrba103) RETURNING l_success
      IF NOT l_success THEN
         EXIT FOREACH
      END IF
   END FOREACH

   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
END FUNCTION

 
{</section>}
 
