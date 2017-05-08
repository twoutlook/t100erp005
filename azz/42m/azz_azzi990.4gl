#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi990.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2016-03-23 17:11:11), PR版次:0011(2017-01-10 17:15:31)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000443
#+ Filename...: azzi990
#+ Description: 參數資料定義作業
#+ Creator....: 00845(2013-08-28 13:10:45)
#+ Modifier...: 01856 -SD/PR- 01856
 
{</section>}
 
{<section id="azzi990.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160321-00010 #1 2016/03/23 By jrg542  輸入的如果是行業別作業，要進行檢查 (包含修改)
#160419-00009 #1 2016/03/23 By jrg542  行業主機(38)的單據別參數維護作業[azzi991]-領域(應用類型)欄位的下拉選項BPH:製藥業
#161125-00032 #1 2016/11/25 By jrg542  單據參數不可以在azzi990 新增，請在azzi991 新增
#170110-00033 #1 2017/01/10 By jrg542  azzi990 參數說明及使用說明 設定欄位屬性為require
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
PRIVATE type type_g_gzsz_m        RECORD
       gzsz001 LIKE gzsz_t.gzsz001, 
   gzsz001_desc LIKE type_t.chr80, 
   combobox1 LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gzsz_d        RECORD
       gzszstus LIKE gzsz_t.gzszstus, 
   gzsz011 LIKE gzsz_t.gzsz011, 
   gzsz002 LIKE gzsz_t.gzsz002, 
   gzszl004 LIKE gzszl_t.gzszl004, 
   gzsz003 LIKE gzsz_t.gzsz003, 
   gzsz008 LIKE gzsz_t.gzsz008, 
   gzsz016 LIKE gzsz_t.gzsz016, 
   gzsz009 LIKE gzsz_t.gzsz009, 
   gzsz017 LIKE gzsz_t.gzsz017, 
   gzsz013 LIKE gzsz_t.gzsz013, 
   gzsz014 LIKE gzsz_t.gzsz014, 
   gzszl005 LIKE gzszl_t.gzszl005, 
   gzszl006 LIKE gzszl_t.gzszl006
       END RECORD
PRIVATE TYPE type_g_gzsz2_d RECORD
       gzsz002 LIKE gzsz_t.gzsz002, 
   gzszownid LIKE gzsz_t.gzszownid, 
   gzszownid_desc LIKE type_t.chr500, 
   gzszowndp LIKE gzsz_t.gzszowndp, 
   gzszowndp_desc LIKE type_t.chr500, 
   gzszcrtid LIKE gzsz_t.gzszcrtid, 
   gzszcrtid_desc LIKE type_t.chr500, 
   gzszcrtdp LIKE gzsz_t.gzszcrtdp, 
   gzszcrtdp_desc LIKE type_t.chr500, 
   gzszcrtdt DATETIME YEAR TO SECOND, 
   gzszmodid LIKE gzsz_t.gzszmodid, 
   gzszmodid_desc LIKE type_t.chr500, 
   gzszmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_gzsz_temp_d DYNAMIC ARRAY OF RECORD  
   gzsz001 LIKE gzsz_t.gzsz001,
   combobox LIKE type_t.chr80
   END RECORD 
#end add-point
 
DEFINE g_detail_multi_table_t    RECORD
      gzszl001 LIKE gzszl_t.gzszl001,
      gzszl002 LIKE gzszl_t.gzszl002,
      gzszl003 LIKE gzszl_t.gzszl003,
      gzszl004 LIKE gzszl_t.gzszl004,
      gzszl005 LIKE gzszl_t.gzszl005,
      gzszl006 LIKE gzszl_t.gzszl006
      END RECORD
 
#模組變數(Module Variables)
DEFINE g_gzsz_m          type_g_gzsz_m
DEFINE g_gzsz_m_t        type_g_gzsz_m
DEFINE g_gzsz_m_o        type_g_gzsz_m
DEFINE g_gzsz_m_mask_o   type_g_gzsz_m #轉換遮罩前資料
DEFINE g_gzsz_m_mask_n   type_g_gzsz_m #轉換遮罩後資料
 
   DEFINE g_gzsz001_t LIKE gzsz_t.gzsz001
 
 
DEFINE g_gzsz_d          DYNAMIC ARRAY OF type_g_gzsz_d
DEFINE g_gzsz_d_t        type_g_gzsz_d
DEFINE g_gzsz_d_o        type_g_gzsz_d
DEFINE g_gzsz_d_mask_o   DYNAMIC ARRAY OF type_g_gzsz_d #轉換遮罩前資料
DEFINE g_gzsz_d_mask_n   DYNAMIC ARRAY OF type_g_gzsz_d #轉換遮罩後資料
DEFINE g_gzsz2_d   DYNAMIC ARRAY OF type_g_gzsz2_d
DEFINE g_gzsz2_d_t type_g_gzsz2_d
DEFINE g_gzsz2_d_o type_g_gzsz2_d
DEFINE g_gzsz2_d_mask_o   DYNAMIC ARRAY OF type_g_gzsz2_d #轉換遮罩前資料
DEFINE g_gzsz2_d_mask_n   DYNAMIC ARRAY OF type_g_gzsz2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_gzsz001 LIKE gzsz_t.gzsz001,
   b_gzsz001_desc LIKE type_t.chr80
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
 
{<section id="azzi990.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   #DEFINE li_cnt LIKE type_t.num5 
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT gzsz001,'',''", 
                      " FROM gzsz_t",
                      " WHERE gzsz001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi990_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.gzsz001,t1.dzeal003",
               " FROM gzsz_t t0",
                              " LEFT JOIN dzeal_t t1 ON t1.dzeal001=t0.gzsz001 AND t1.dzeal002='"||g_lang||"' ",
 
               " WHERE  t0.gzsz001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE azzi990_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi990 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzi990_init()   
 
      #進入選單 Menu (="N")
      CALL azzi990_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzi990
      
   END IF 
   
   CLOSE azzi990_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
#   #先註解 移到AFTER INPUT 執行    
#   FOR li_cnt = 1 TO g_gzsz_temp_d.getLength()
#          #單身輸入後會call s_azzi990 insert 相對表格 
#       CALL s_azzi990_ins_parameter(g_gzsz_temp_d[li_cnt].gzsz001,g_gzsz_temp_d[li_cnt].combobox)
#       DISPLAY "call s_azzi990_ins_parameter:",g_gzsz_temp_d[li_cnt].gzsz001 ,"  ",g_gzsz_temp_d[li_cnt].combobox
#   END FOR 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="azzi990.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzi990_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('gzsz011','90') 
   CALL cl_set_combo_scc('gzsz003','89') 
   CALL cl_set_combo_scc('gzsz017','160') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   #160419-00009 #1
   CALL s_azzi990_combobox_gzsz011()
   #end add-point
   
   CALL azzi990_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="azzi990.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION azzi990_ui_dialog()
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
         INITIALIZE g_gzsz_m.* TO NULL
         CALL g_gzsz_d.clear()
         CALL g_gzsz2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL azzi990_init()
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
               CALL azzi990_idx_chk()
               CALL azzi990_fetch('') # reload data
               LET g_detail_idx = 1
               CALL azzi990_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_gzsz_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL azzi990_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL azzi990_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_gzsz2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL azzi990_idx_chk()
               CALL azzi990_ui_detailshow()
               
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
            CALL azzi990_browser_fill("")
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
               CALL azzi990_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL azzi990_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL azzi990_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL azzi990_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi990_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL azzi990_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi990_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL azzi990_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi990_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL azzi990_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi990_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL azzi990_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi990_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_gzsz_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_gzsz2_d)
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
               NEXT FIELD gzsz002
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
               CALL azzi990_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL azzi990_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL azzi990_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzi990_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL azzi990_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION view_parameter
            LET g_action_choice="view_parameter"
            IF cl_auth_chk_act("view_parameter") THEN
               
               #add-point:ON ACTION view_parameter name="menu.view_parameter"
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE 
               LET g_qryparam.arg1 = 'ooab_t'
               CALL azzi990_01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi990_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_batch_param
            LET g_action_choice="gen_batch_param"
            IF cl_auth_chk_act("gen_batch_param") THEN
               
               #add-point:ON ACTION gen_batch_param name="menu.gen_batch_param"
               CALL s_azzi990_gen_batch_param()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi990_insert()
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
               CALL azzi990_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi990_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL azzi990_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi990_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi990_set_pk_array()
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
 
{<section id="azzi990.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION azzi990_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi990.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION azzi990_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "gzsz001"
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
      LET l_sub_sql = " SELECT DISTINCT gzsz001 ",
 
                      " FROM gzsz_t ",
                      " ",
                      " LEFT JOIN gzszl_t ON gzsz001 = gzszl001 AND gzsz002 = gzszl002 AND gzszl003 = '",g_dlang,"' ", 
 
 
 
                      " WHERE  ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gzsz_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gzsz001 ",
 
                      " FROM gzsz_t ",
                      " ",
                      " LEFT JOIN gzszl_t ON gzsz001 = gzszl001 AND gzsz002 = gzszl002 AND gzszl003 = '",g_dlang,"' ", 
 
 
                      " WHERE  ",l_wc CLIPPED, cl_sql_add_filter("gzsz_t")
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
      INITIALIZE g_gzsz_m.* TO NULL
      CALL g_gzsz_d.clear()        
      CALL g_gzsz2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.gzsz001 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.gzsz001,t1.dzeal003",
                " FROM gzsz_t t0",
                #" ",
                " LEFT JOIN gzszl_t ON gzsz001 = gzszl001 AND gzsz002 = gzszl002 AND gzszl003 = '",g_dlang,"' ",
 
 
 
                               " LEFT JOIN dzeal_t t1 ON t1.dzeal001=t0.gzsz001 AND t1.dzeal002='"||g_lang||"' ",
 
                " WHERE  ", l_wc," AND ",l_wc2, cl_sql_add_filter("gzsz_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzsz_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_gzsz001,g_browser[g_cnt].b_gzsz001_desc 
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
         CALL azzi990_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_gzsz001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_gzsz_m.* TO NULL
      CALL g_gzsz_d.clear()
      CALL g_gzsz2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL azzi990_fetch('')
   
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
 
{<section id="azzi990.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION azzi990_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_gzsz_m.gzsz001 = g_browser[g_current_idx].b_gzsz001   
 
   EXECUTE azzi990_master_referesh USING g_gzsz_m.gzsz001 INTO g_gzsz_m.gzsz001,g_gzsz_m.gzsz001_desc 
 
   CALL azzi990_show()
   
END FUNCTION
 
{</section>}
 
{<section id="azzi990.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION azzi990_ui_detailshow()
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
 
{<section id="azzi990.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION azzi990_ui_browser_refresh()
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
      IF g_browser[l_i].b_gzsz001 = g_gzsz_m.gzsz001 
 
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
 
{<section id="azzi990.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi990_construct()
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
   INITIALIZE g_gzsz_m.* TO NULL
   CALL g_gzsz_d.clear()
   CALL g_gzsz2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON gzsz001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.gzsz001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz001
            #add-point:ON ACTION controlp INFIELD gzsz001 name="construct.c.gzsz001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_gzsz001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzsz001  #顯示到畫面上

            NEXT FIELD gzsz001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz001
            #add-point:BEFORE FIELD gzsz001 name="construct.b.gzsz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz001
            
            #add-point:AFTER FIELD gzsz001 name="construct.a.gzsz001"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON gzszstus,gzsz011,gzsz002,gzszl004,gzsz003,gzsz008,gzsz016,gzsz009,gzsz017, 
          gzsz013,gzsz014,gzszl005,gzszl006,gzszownid,gzszowndp,gzszcrtid,gzszcrtdp,gzszcrtdt,gzszmodid, 
          gzszmoddt
           FROM s_detail1[1].gzszstus,s_detail1[1].gzsz011,s_detail1[1].gzsz002,s_detail1[1].gzszl004, 
               s_detail1[1].gzsz003,s_detail1[1].gzsz008,s_detail1[1].gzsz016,s_detail1[1].gzsz009,s_detail1[1].gzsz017, 
               s_detail1[1].gzsz013,s_detail1[1].gzsz014,s_detail1[1].gzszl005,s_detail1[1].gzszl006, 
               s_detail2[1].gzszownid,s_detail2[1].gzszowndp,s_detail2[1].gzszcrtid,s_detail2[1].gzszcrtdp, 
               s_detail2[1].gzszcrtdt,s_detail2[1].gzszmodid,s_detail2[1].gzszmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gzszcrtdt>>----
         AFTER FIELD gzszcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gzszmoddt>>----
         AFTER FIELD gzszmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzszcnfdt>>----
         
         #----<<gzszpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszstus
            #add-point:BEFORE FIELD gzszstus name="construct.b.page1.gzszstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzszstus
            
            #add-point:AFTER FIELD gzszstus name="construct.a.page1.gzszstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzszstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzszstus
            #add-point:ON ACTION controlp INFIELD gzszstus name="construct.c.page1.gzszstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz011
            #add-point:BEFORE FIELD gzsz011 name="construct.b.page1.gzsz011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz011
            
            #add-point:AFTER FIELD gzsz011 name="construct.a.page1.gzsz011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzsz011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz011
            #add-point:ON ACTION controlp INFIELD gzsz011 name="construct.c.page1.gzsz011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz002
            #add-point:BEFORE FIELD gzsz002 name="construct.b.page1.gzsz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz002
            
            #add-point:AFTER FIELD gzsz002 name="construct.a.page1.gzsz002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzsz002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz002
            #add-point:ON ACTION controlp INFIELD gzsz002 name="construct.c.page1.gzsz002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszl004
            #add-point:BEFORE FIELD gzszl004 name="construct.b.page1.gzszl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzszl004
            
            #add-point:AFTER FIELD gzszl004 name="construct.a.page1.gzszl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzszl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzszl004
            #add-point:ON ACTION controlp INFIELD gzszl004 name="construct.c.page1.gzszl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz003
            #add-point:BEFORE FIELD gzsz003 name="construct.b.page1.gzsz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz003
            
            #add-point:AFTER FIELD gzsz003 name="construct.a.page1.gzsz003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzsz003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz003
            #add-point:ON ACTION controlp INFIELD gzsz003 name="construct.c.page1.gzsz003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz008
            #add-point:BEFORE FIELD gzsz008 name="construct.b.page1.gzsz008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz008
            
            #add-point:AFTER FIELD gzsz008 name="construct.a.page1.gzsz008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzsz008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz008
            #add-point:ON ACTION controlp INFIELD gzsz008 name="construct.c.page1.gzsz008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz016
            #add-point:BEFORE FIELD gzsz016 name="construct.b.page1.gzsz016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz016
            
            #add-point:AFTER FIELD gzsz016 name="construct.a.page1.gzsz016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzsz016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz016
            #add-point:ON ACTION controlp INFIELD gzsz016 name="construct.c.page1.gzsz016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz009
            #add-point:BEFORE FIELD gzsz009 name="construct.b.page1.gzsz009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz009
            
            #add-point:AFTER FIELD gzsz009 name="construct.a.page1.gzsz009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzsz009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz009
            #add-point:ON ACTION controlp INFIELD gzsz009 name="construct.c.page1.gzsz009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz017
            #add-point:BEFORE FIELD gzsz017 name="construct.b.page1.gzsz017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz017
            
            #add-point:AFTER FIELD gzsz017 name="construct.a.page1.gzsz017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzsz017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz017
            #add-point:ON ACTION controlp INFIELD gzsz017 name="construct.c.page1.gzsz017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz013
            #add-point:BEFORE FIELD gzsz013 name="construct.b.page1.gzsz013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz013
            
            #add-point:AFTER FIELD gzsz013 name="construct.a.page1.gzsz013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzsz013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz013
            #add-point:ON ACTION controlp INFIELD gzsz013 name="construct.c.page1.gzsz013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz014
            #add-point:BEFORE FIELD gzsz014 name="construct.b.page1.gzsz014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz014
            
            #add-point:AFTER FIELD gzsz014 name="construct.a.page1.gzsz014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzsz014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz014
            #add-point:ON ACTION controlp INFIELD gzsz014 name="construct.c.page1.gzsz014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszl005
            #add-point:BEFORE FIELD gzszl005 name="construct.b.page1.gzszl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzszl005
            
            #add-point:AFTER FIELD gzszl005 name="construct.a.page1.gzszl005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzszl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzszl005
            #add-point:ON ACTION controlp INFIELD gzszl005 name="construct.c.page1.gzszl005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszl006
            #add-point:BEFORE FIELD gzszl006 name="construct.b.page1.gzszl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzszl006
            
            #add-point:AFTER FIELD gzszl006 name="construct.a.page1.gzszl006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzszl006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzszl006
            #add-point:ON ACTION controlp INFIELD gzszl006 name="construct.c.page1.gzszl006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.gzszownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzszownid
            #add-point:ON ACTION controlp INFIELD gzszownid name="construct.c.page2.gzszownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzszownid  #顯示到畫面上

            NEXT FIELD gzszownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszownid
            #add-point:BEFORE FIELD gzszownid name="construct.b.page2.gzszownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzszownid
            
            #add-point:AFTER FIELD gzszownid name="construct.a.page2.gzszownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzszowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzszowndp
            #add-point:ON ACTION controlp INFIELD gzszowndp name="construct.c.page2.gzszowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzszowndp  #顯示到畫面上

            NEXT FIELD gzszowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszowndp
            #add-point:BEFORE FIELD gzszowndp name="construct.b.page2.gzszowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzszowndp
            
            #add-point:AFTER FIELD gzszowndp name="construct.a.page2.gzszowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzszcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzszcrtid
            #add-point:ON ACTION controlp INFIELD gzszcrtid name="construct.c.page2.gzszcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzszcrtid  #顯示到畫面上

            NEXT FIELD gzszcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszcrtid
            #add-point:BEFORE FIELD gzszcrtid name="construct.b.page2.gzszcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzszcrtid
            
            #add-point:AFTER FIELD gzszcrtid name="construct.a.page2.gzszcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzszcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzszcrtdp
            #add-point:ON ACTION controlp INFIELD gzszcrtdp name="construct.c.page2.gzszcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzszcrtdp  #顯示到畫面上

            NEXT FIELD gzszcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszcrtdp
            #add-point:BEFORE FIELD gzszcrtdp name="construct.b.page2.gzszcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzszcrtdp
            
            #add-point:AFTER FIELD gzszcrtdp name="construct.a.page2.gzszcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszcrtdt
            #add-point:BEFORE FIELD gzszcrtdt name="construct.b.page2.gzszcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.gzszmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzszmodid
            #add-point:ON ACTION controlp INFIELD gzszmodid name="construct.c.page2.gzszmodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzszmodid  #顯示到畫面上

            NEXT FIELD gzszmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszmodid
            #add-point:BEFORE FIELD gzszmodid name="construct.b.page2.gzszmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzszmodid
            
            #add-point:AFTER FIELD gzszmodid name="construct.a.page2.gzszmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszmoddt
            #add-point:BEFORE FIELD gzszmoddt name="construct.b.page2.gzszmoddt"
            
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
   IF cl_null(g_wc2) THEN 
       LET g_wc2 =  " (gzsz002 LIKE 'A%' OR gzsz002 LIKE 'S%' OR gzsz002 LIKE 'E%' OR gzsz002 LIKE 'T%' ) "
   ELSE 
       #IF g_wc2 " 1=1"
       LET g_wc2 =  g_wc2 CLIPPED, " AND (gzsz002 LIKE 'A%' OR gzsz002 LIKE 'S%' OR gzsz002 LIKE 'E%' OR gzsz002 LIKE 'T%' ) "
   END IF 
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
 
{<section id="azzi990.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION azzi990_filter()
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
      CONSTRUCT g_wc_filter ON gzsz001
                          FROM s_browse[1].b_gzsz001
 
         BEFORE CONSTRUCT
               DISPLAY azzi990_filter_parser('gzsz001') TO s_browse[1].b_gzsz001
      
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
 
      CALL azzi990_filter_show('gzsz001')
 
END FUNCTION
 
{</section>}
 
{<section id="azzi990.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION azzi990_filter_parser(ps_field)
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
 
{<section id="azzi990.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION azzi990_filter_show(ps_field)
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
   LET ls_condition = azzi990_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="azzi990.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION azzi990_query()
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
   CALL g_gzsz_d.clear()
   CALL g_gzsz2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL azzi990_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL azzi990_browser_fill(g_wc)
      CALL azzi990_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL azzi990_browser_fill("F")
   
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
      CALL azzi990_fetch("F") 
   END IF
   
   CALL azzi990_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="azzi990.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION azzi990_fetch(p_flag)
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
   
   LET g_gzsz_m.gzsz001 = g_browser[g_current_idx].b_gzsz001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE azzi990_master_referesh USING g_gzsz_m.gzsz001 INTO g_gzsz_m.gzsz001,g_gzsz_m.gzsz001_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzsz_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_gzsz_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_gzsz_m_mask_o.* =  g_gzsz_m.*
   CALL azzi990_gzsz_t_mask()
   LET g_gzsz_m_mask_n.* =  g_gzsz_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi990_set_act_visible()
   CALL azzi990_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_gzsz_m_t.* = g_gzsz_m.*
   LET g_gzsz_m_o.* = g_gzsz_m.*
   
   #重新顯示   
   CALL azzi990_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="azzi990.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi990_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_gzsz_d.clear()
   CALL g_gzsz2_d.clear()
 
 
   INITIALIZE g_gzsz_m.* TO NULL             #DEFAULT 設定
   LET g_gzsz001_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL azzi990_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_gzsz_m.* TO NULL
         INITIALIZE g_gzsz_d TO NULL
         INITIALIZE g_gzsz2_d TO NULL
 
         CALL azzi990_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_gzsz_m.* = g_gzsz_m_t.*
         CALL azzi990_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_gzsz_d.clear()
      #CALL g_gzsz2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi990_set_act_visible()
   CALL azzi990_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzsz001_t = g_gzsz_m.gzsz001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzsz001 = '", g_gzsz_m.gzsz001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi990_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL azzi990_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE azzi990_master_referesh USING g_gzsz_m.gzsz001 INTO g_gzsz_m.gzsz001,g_gzsz_m.gzsz001_desc 
 
   
   #遮罩相關處理
   LET g_gzsz_m_mask_o.* =  g_gzsz_m.*
   CALL azzi990_gzsz_t_mask()
   LET g_gzsz_m_mask_n.* =  g_gzsz_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzsz_m.gzsz001,g_gzsz_m.gzsz001_desc,g_gzsz_m.combobox1
   
   #功能已完成,通報訊息中心
   CALL azzi990_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi990.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi990_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   #161125-00032 start 
   IF g_gzsz_m.combobox1 = "D" THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = "azz-00420" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN 
   END IF
   #161125-00032 end
   #end add-point
   
   IF g_gzsz_m.gzsz001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_gzsz001_t = g_gzsz_m.gzsz001
 
   CALL s_transaction_begin()
   
   OPEN azzi990_cl USING g_gzsz_m.gzsz001
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi990_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE azzi990_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi990_master_referesh USING g_gzsz_m.gzsz001 INTO g_gzsz_m.gzsz001,g_gzsz_m.gzsz001_desc 
 
   
   #遮罩相關處理
   LET g_gzsz_m_mask_o.* =  g_gzsz_m.*
   CALL azzi990_gzsz_t_mask()
   LET g_gzsz_m_mask_n.* =  g_gzsz_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL azzi990_show()
   WHILE TRUE
      LET g_gzsz001_t = g_gzsz_m.gzsz001
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL azzi990_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_gzsz_m.* = g_gzsz_m_t.*
         CALL azzi990_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_gzsz_m.gzsz001 != g_gzsz001_t 
 
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
   CALL azzi990_set_act_visible()
   CALL azzi990_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzsz001 = '", g_gzsz_m.gzsz001, "' "
 
   #填到對應位置
   CALL azzi990_browser_fill("")
 
   CALL azzi990_idx_chk()
 
   CLOSE azzi990_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL azzi990_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="azzi990.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzi990_input(p_cmd)
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
   DEFINE  li_result             LIKE type_t.num5
   DEFINE  li_cnt                LIKE type_t.num5
   DEFINE  ls_gzcb_cnt           LIKE type_t.num5
   DEFINE  ls_str                STRING 
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
   DISPLAY BY NAME g_gzsz_m.gzsz001,g_gzsz_m.gzsz001_desc,g_gzsz_m.combobox1
   
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
   LET g_forupd_sql = "SELECT gzszstus,gzsz011,gzsz002,gzsz003,gzsz008,gzsz016,gzsz009,gzsz017,gzsz013, 
       gzsz014,gzsz002,gzszownid,gzszowndp,gzszcrtid,gzszcrtdp,gzszcrtdt,gzszmodid,gzszmoddt FROM gzsz_t  
       WHERE gzsz001=? AND gzsz002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi990_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL azzi990_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL azzi990_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_gzsz_m.gzsz001
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="azzi990.input.head" >}
   
      #單頭段
      INPUT BY NAME g_gzsz_m.gzsz001 
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
         AFTER FIELD gzsz001
            
            #add-point:AFTER FIELD gzsz001 name="input.a.gzsz001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gzsz_m.gzsz001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_gzsz_m.gzsz001 != g_gzsz001_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzsz_t WHERE "||"gzsz001 = '"||g_gzsz_m.gzsz001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_gzsz_m.gzsz001) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_gzsz_m.gzsz001

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_dzea001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL azzi990_chk_gzsz004()
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzsz_m.gzsz001
            CALL ap_ref_array2(g_ref_fields,"SELECT dzeal003 FROM dzeal_t WHERE dzeal001=? AND dzeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gzsz_m.gzsz001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzsz_m.gzsz001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz001
            #add-point:BEFORE FIELD gzsz001 name="input.b.gzsz001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzsz001
            #add-point:ON CHANGE gzsz001 name="input.g.gzsz001"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gzsz001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz001
            #add-point:ON ACTION controlp INFIELD gzsz001 name="input.c.gzsz001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzsz_m.gzsz001             #給予default值

            #給予arg

            CALL q_dzea002_1()                                #呼叫開窗

            LET g_gzsz_m.gzsz001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gzsz_m.gzsz001 TO gzsz001              #顯示到畫面上

            NEXT FIELD gzsz001                          #返回原欄位


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
            DISPLAY BY NAME g_gzsz_m.gzsz001             
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL azzi990_gzsz_t_mask_restore('restore_mask_o')
            
               UPDATE gzsz_t SET (gzsz001) = (g_gzsz_m.gzsz001)
                WHERE  gzsz001 = g_gzsz001_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzsz_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzsz_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzsz_m.gzsz001
               LET gs_keys_bak[1] = g_gzsz001_t
               LET gs_keys[2] = g_gzsz_d[g_detail_idx].gzsz002
               LET gs_keys_bak[2] = g_gzsz_d_t.gzsz002
               CALL azzi990_update_b('gzsz_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_gzsz_m_t)
                     #LET g_log2 = util.JSON.stringify(g_gzsz_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL azzi990_gzsz_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL azzi990_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_gzsz001_t = g_gzsz_m.gzsz001
 
           
           IF g_gzsz_d.getLength() = 0 THEN
              NEXT FIELD gzsz002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="azzi990.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_gzsz_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_batch_param
            LET g_action_choice="gen_batch_param"
            IF cl_auth_chk_act("gen_batch_param") THEN
               
               #add-point:ON ACTION gen_batch_param name="input.detail_input.page1.gen_batch_param"
               CALL s_azzi990_gen_batch_param()
               #END add-point
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.detail_input.page1.update_item"
                                IF  NOT cl_null(g_gzsz_m.gzsz001 ) AND NOT cl_null(g_gzsz_d[l_ac].gzsz002) THEN
                  CALL n_gzszl(g_gzsz_m.gzsz001,g_gzsz_d[l_ac].gzsz002) 
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_gzsz_m.gzsz001
                  LET g_ref_fields[2] = g_gzsz_d[l_ac].gzsz002
                  CALL ap_ref_array2(g_ref_fields," SELECT gzszl004,gzszl005,gzszl006,gzszl007 FROM gzszl_t WHERE gzszl001 = ? AND gzszl002 = ? AND gzszl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_gzsz_d[l_ac].gzszl004 = g_rtn_fields[1]
                  LET g_gzsz_d[l_ac].gzszl005 = g_rtn_fields[2] 
                  LET g_gzsz_d[l_ac].gzszl006 = g_rtn_fields[3]             
                  DISPLAY BY NAME g_gzsz_d[l_ac].gzszl004
                  DISPLAY BY NAME g_gzsz_d[l_ac].gzszl005
                  DISPLAY BY NAME g_gzsz_d[l_ac].gzszl006

               END IF
               #END add-point
            END IF
 
 
 
 
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzsz_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi990_b_fill(g_wc2) #test 
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
            CALL azzi990_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN azzi990_cl USING g_gzsz_m.gzsz001                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE azzi990_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN azzi990_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_gzsz_d[l_ac].gzsz002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzsz_d_t.* = g_gzsz_d[l_ac].*  #BACKUP
               LET g_gzsz_d_o.* = g_gzsz_d[l_ac].*  #BACKUP
               CALL azzi990_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL azzi990_set_no_entry_b(l_cmd)
               OPEN azzi990_bcl USING g_gzsz_m.gzsz001,
 
                                                g_gzsz_d_t.gzsz002
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN azzi990_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi990_bcl INTO g_gzsz_d[l_ac].gzszstus,g_gzsz_d[l_ac].gzsz011,g_gzsz_d[l_ac].gzsz002, 
                      g_gzsz_d[l_ac].gzsz003,g_gzsz_d[l_ac].gzsz008,g_gzsz_d[l_ac].gzsz016,g_gzsz_d[l_ac].gzsz009, 
                      g_gzsz_d[l_ac].gzsz017,g_gzsz_d[l_ac].gzsz013,g_gzsz_d[l_ac].gzsz014,g_gzsz2_d[l_ac].gzsz002, 
                      g_gzsz2_d[l_ac].gzszownid,g_gzsz2_d[l_ac].gzszowndp,g_gzsz2_d[l_ac].gzszcrtid, 
                      g_gzsz2_d[l_ac].gzszcrtdp,g_gzsz2_d[l_ac].gzszcrtdt,g_gzsz2_d[l_ac].gzszmodid, 
                      g_gzsz2_d[l_ac].gzszmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_gzsz_d_t.gzsz002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzsz_d_mask_o[l_ac].* =  g_gzsz_d[l_ac].*
                  CALL azzi990_gzsz_t_mask()
                  LET g_gzsz_d_mask_n[l_ac].* =  g_gzsz_d[l_ac].*
                  
                  CALL azzi990_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL azzi990_check_gzsz003()
            #end add-point  
            
LET g_detail_multi_table_t.gzszl001 = g_gzsz_m.gzsz001
LET g_detail_multi_table_t.gzszl002 = g_gzsz_d[l_ac].gzsz002
LET g_detail_multi_table_t.gzszl003 = g_dlang
LET g_detail_multi_table_t.gzszl004 = g_gzsz_d[l_ac].gzszl004
LET g_detail_multi_table_t.gzszl005 = g_gzsz_d[l_ac].gzszl005
LET g_detail_multi_table_t.gzszl006 = g_gzsz_d[l_ac].gzszl006
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_gzsz_d_t.* TO NULL
            INITIALIZE g_gzsz_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzsz_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gzsz2_d[l_ac].gzszownid = g_user
      LET g_gzsz2_d[l_ac].gzszowndp = g_dept
      LET g_gzsz2_d[l_ac].gzszcrtid = g_user
      LET g_gzsz2_d[l_ac].gzszcrtdp = g_dept 
      LET g_gzsz2_d[l_ac].gzszcrtdt = cl_get_current()
      LET g_gzsz2_d[l_ac].gzszmodid = g_user
      LET g_gzsz2_d[l_ac].gzszmoddt = cl_get_current()
      LET g_gzsz_d[l_ac].gzszstus = ''
 
 
  
            #一般欄位預設值
                  LET g_gzsz_d[l_ac].gzszstus = "Y"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            #161125-00032 start
            IF g_gzsz_m.combobox1 = "D" THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = "azz-00420" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT 
            END IF 
            #161125-00032 end
            #end add-point
            LET g_gzsz_d_t.* = g_gzsz_d[l_ac].*     #新輸入資料
            LET g_gzsz_d_o.* = g_gzsz_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi990_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL azzi990_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzsz_d[li_reproduce_target].* = g_gzsz_d[li_reproduce].*
               LET g_gzsz2_d[li_reproduce_target].* = g_gzsz2_d[li_reproduce].*
 
               LET g_gzsz_d[g_gzsz_d.getLength()].gzsz002 = NULL
 
            END IF
            
LET g_detail_multi_table_t.gzszl001 = g_gzsz_m.gzsz001
LET g_detail_multi_table_t.gzszl002 = g_gzsz_d[l_ac].gzsz002
LET g_detail_multi_table_t.gzszl003 = g_dlang
LET g_detail_multi_table_t.gzszl004 = g_gzsz_d[l_ac].gzszl004
LET g_detail_multi_table_t.gzszl005 = g_gzsz_d[l_ac].gzszl005
LET g_detail_multi_table_t.gzszl006 = g_gzsz_d[l_ac].gzszl006
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            NEXT FIELD gzsz011
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
            SELECT COUNT(1) INTO l_count FROM gzsz_t 
             WHERE  gzsz001 = g_gzsz_m.gzsz001
 
               AND gzsz002 = g_gzsz_d[l_ac].gzsz002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO gzsz_t
                           (
                            gzsz001,
                            gzsz002
                            ,gzszstus,gzsz011,gzsz003,gzsz008,gzsz016,gzsz009,gzsz017,gzsz013,gzsz014,gzszownid,gzszowndp,gzszcrtid,gzszcrtdp,gzszcrtdt,gzszmodid,gzszmoddt) 
                     VALUES(
                            g_gzsz_m.gzsz001,
                            g_gzsz_d[l_ac].gzsz002
                            ,g_gzsz_d[l_ac].gzszstus,g_gzsz_d[l_ac].gzsz011,g_gzsz_d[l_ac].gzsz003,g_gzsz_d[l_ac].gzsz008, 
                                g_gzsz_d[l_ac].gzsz016,g_gzsz_d[l_ac].gzsz009,g_gzsz_d[l_ac].gzsz017, 
                                g_gzsz_d[l_ac].gzsz013,g_gzsz_d[l_ac].gzsz014,g_gzsz2_d[l_ac].gzszownid, 
                                g_gzsz2_d[l_ac].gzszowndp,g_gzsz2_d[l_ac].gzszcrtid,g_gzsz2_d[l_ac].gzszcrtdp, 
                                g_gzsz2_d[l_ac].gzszcrtdt,g_gzsz2_d[l_ac].gzszmodid,g_gzsz2_d[l_ac].gzszmoddt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_gzsz_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gzsz_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_gzsz_m.gzsz001 = g_detail_multi_table_t.gzszl001 AND
         g_gzsz_d[l_ac].gzsz002 = g_detail_multi_table_t.gzszl002 AND
         g_gzsz_d[l_ac].gzszl004 = g_detail_multi_table_t.gzszl004 AND
         g_gzsz_d[l_ac].gzszl005 = g_detail_multi_table_t.gzszl005 AND
         g_gzsz_d[l_ac].gzszl006 = g_detail_multi_table_t.gzszl006 THEN
         ELSE 
            LET l_var_keys[01] = g_gzsz_m.gzsz001
            LET l_field_keys[01] = 'gzszl001'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.gzszl001
            LET l_var_keys[02] = g_gzsz_d[l_ac].gzsz002
            LET l_field_keys[02] = 'gzszl002'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.gzszl002
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'gzszl003'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.gzszl003
            LET l_vars[01] = g_gzsz_d[l_ac].gzszl004
            LET l_fields[01] = 'gzszl004'
            LET l_vars[02] = g_gzsz_d[l_ac].gzszl005
            LET l_fields[02] = 'gzszl005'
            LET l_vars[03] = g_gzsz_d[l_ac].gzszl006
            LET l_fields[03] = 'gzszl006'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzszl_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert"
               LET li_result = FALSE 
               FOR l_i = 1 TO g_gzsz_temp_d.getLength()
                   IF g_gzsz_temp_d[l_i].gzsz001 = g_gzsz_m.gzsz001 THEN 
                      LET li_result = TRUE 
                      EXIT FOR  
                  END IF
               END FOR
               IF NOT li_result THEN  
                  LET l_i = g_gzsz_temp_d.getLength() + 1 
                  LET g_gzsz_temp_d[l_i].gzsz001 = g_gzsz_m.gzsz001
                  LET g_gzsz_temp_d[l_i].combobox = g_gzsz_m.combobox1 
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
               IF azzi990_chk_gzsz002_param() THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "azz-00151"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  #azzi993 有設定資料不能異動
                  CANCEL DELETE
               END IF
               
               #grep "參數編號" $ERP/???/4gl/*.4gl
               #grep "參數編號" $COM/???/4gl/*.4gl
               IF azzi990_chk_gzsz002_grep_param() THEN 
                  CANCEL DELETE
               END IF
               #161125-00032 #1 start
               IF g_gzsz_m.combobox1 = "D" THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = "azz-00420" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE 
               END IF
               #161125-00032 #1 end               
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
               IF azzi990_before_delete() THEN 
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'gzszl001'
                  LET l_var_keys_bak[01] = g_detail_multi_table_t.gzszl001
                  LET l_field_keys[02] = 'gzszl002'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.gzszl002
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'gzszl_t')
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_gzsz_m.gzsz001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gzsz_d_t.gzsz002
 
 
                  #刪除下層單身
                  IF NOT azzi990_key_delete_b(gs_keys,'gzsz_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE azzi990_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE azzi990_bcl
               LET l_count = g_gzsz_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_gzsz_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszstus
            #add-point:BEFORE FIELD gzszstus name="input.b.page1.gzszstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzszstus
            
            #add-point:AFTER FIELD gzszstus name="input.a.page1.gzszstus"
             IF l_cmd = 'u' AND (g_gzsz_d[l_ac].gzszstus != g_gzsz_d_t.gzszstus) THEN 
               IF azzi990_chk_gzsz002_param() THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "azz-00151"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  #azzi993 有設定資料不能異動
                  NEXT FIELD CURRENT
               END IF
               IF azzi990_chk_gzsz002_grep_param() THEN                    
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzszstus
            #add-point:ON CHANGE gzszstus name="input.g.page1.gzszstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz011
            #add-point:BEFORE FIELD gzsz011 name="input.b.page1.gzsz011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz011
            
            #add-point:AFTER FIELD gzsz011 name="input.a.page1.gzsz011"
            CALL azzi990_check_gzsz011(l_cmd) 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzsz011
            #add-point:ON CHANGE gzsz011 name="input.g.page1.gzsz011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz002
            #add-point:BEFORE FIELD gzsz002 name="input.b.page1.gzsz002"
            IF cl_null(g_gzsz_d[l_ac].gzsz002) THEN 
               NEXT FIELD gzsz011
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz002
            
            #add-point:AFTER FIELD gzsz002 name="input.a.page1.gzsz002"
            #此段落由子樣板a05產生
           IF  NOT cl_null(g_gzsz_m.gzsz001) AND NOT cl_null(g_gzsz_d[l_ac].gzsz002) THEN 
               IF l_cmd = 'a' OR  ( l_cmd = 'u' AND (g_gzsz_m.gzsz001 != g_gzsz001_t OR g_gzsz_d[l_ac].gzsz002 != g_gzsz_d_t.gzsz002)) THEN 
                  IF l_cmd = 'u' AND g_gzsz_d[l_ac].gzsz002 != g_gzsz_d_t.gzsz002 THEN 
                     IF azzi990_chk_gzsz002_param() THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code =  "azz-00151"
                        LET g_errparam.extend = ""
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  #azzi993 有設定資料不能異動
                        NEXT FIELD CURRENT
                     END IF
                     IF azzi990_chk_gzsz002_grep_param() THEN                    
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  
                  #IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzsz_t WHERE "||"gzsz001 = '"||g_gzsz_m.gzsz001 ||"' AND "|| "gzsz002 = '"||g_gzsz_d[l_ac].gzsz002 ||"'",'std-00004',0) THEN 
                  #為了同一支參數作業 可以設定不同table的參數設定 把gzsz001拿掉只檢核gzsz002，gzsz002不可以重複
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzsz_t WHERE gzsz002 = '"||g_gzsz_d[l_ac].gzsz002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  #檢核gzsz002 
                  CALL azzi990_check_gzsz002(l_cmd) RETURNING li_result 
                  IF NOT li_result THEN
                     IF g_errno = "azz-00196" THEN #參數編號沒有應用類型
                        NEXT FIELD gzsz011
                     END IF  
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzsz002
            #add-point:ON CHANGE gzsz002 name="input.g.page1.gzsz002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszl004
            #add-point:BEFORE FIELD gzszl004 name="input.b.page1.gzszl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzszl004
            
            #add-point:AFTER FIELD gzszl004 name="input.a.page1.gzszl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzszl004
            #add-point:ON CHANGE gzszl004 name="input.g.page1.gzszl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz003
            #add-point:BEFORE FIELD gzsz003 name="input.b.page1.gzsz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz003
            
            #add-point:AFTER FIELD gzsz003 name="input.a.page1.gzsz003"
            CALL azzi990_check_gzsz003()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzsz003
            #add-point:ON CHANGE gzsz003 name="input.g.page1.gzsz003"
            IF l_cmd = 'a' THEN 
               CASE 
                  WHEN g_gzsz_d[l_ac].gzsz003 = "4" AND cl_null(g_gzsz_d[l_ac].gzsz016)
                     LET g_gzsz_d[l_ac].gzsz008 = "NOT_DEFINED"
                  WHEN g_gzsz_d[l_ac].gzsz003 = "5" 
                     LET ls_str = cl_get_today()  #2016-03-23
                     IF ls_str.getIndexOf("-",1) THEN 
                        LET ls_str = ls_str.subString(1,ls_str.getIndexOf("-",1)-1),"/",ls_str.subString(ls_str.getIndexOf("-",1)+1,ls_str.getLength())
                        IF  ls_str.getIndexOf("-",1) THEN  
                           LET ls_str = ls_str.subString(1,ls_str.getIndexOf("-",1)-1),"/",ls_str.subString(ls_str.getIndexOf("-",1)+1,ls_str.getLength())
                        END IF 
                     END IF 
                     LET g_gzsz_d[l_ac].gzsz008 = ls_str  
                  OTHERWISE 
                     LET g_gzsz_d[l_ac].gzsz008 = ""  
               END CASE 
#               IF g_gzsz_d[l_ac].gzsz003 = "4" AND cl_null(g_gzsz_d[l_ac].gzsz016) THEN 
#                  LET g_gzsz_d[l_ac].gzsz008 = "NOT_DEFINED"
#               ELSE 
#                  LET g_gzsz_d[l_ac].gzsz008 = ""
#               END IF 
            END IF 
            CALL azzi990_check_gzsz003()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz008
            #add-point:BEFORE FIELD gzsz008 name="input.b.page1.gzsz008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz008
            
            #add-point:AFTER FIELD gzsz008 name="input.a.page1.gzsz008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzsz008
            #add-point:ON CHANGE gzsz008 name="input.g.page1.gzsz008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz016
            #add-point:BEFORE FIELD gzsz016 name="input.b.page1.gzsz016"
            CALL azzi990_check_gzsz003()
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz016
            
            #add-point:AFTER FIELD gzsz016 name="input.a.page1.gzsz016"
            IF NOT cl_null(g_gzsz_d[l_ac].gzsz016) THEN 
               CALL azzi990_get_scc()
               CALL DIALOG.setFieldTouched("s_detail1.gzsz009",TRUE)

               #檢核scc資料是否存在
               LET ls_gzcb_cnt = 0
               SELECT COUNT(1) INTO ls_gzcb_cnt FROM gzcb_t
                WHERE gzcb001 = g_gzsz_d[l_ac].gzsz016

               IF ls_gzcb_cnt <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00368"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD gzsz016
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzsz016
            #add-point:ON CHANGE gzsz016 name="input.g.page1.gzsz016"
 
            #檢核scc是否存在
            #若有輸入正確的scc資訊，則將校驗及開窗的設定清空
            CALL azzi990_check_gzsz003()

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz009
            #add-point:BEFORE FIELD gzsz009 name="input.b.page1.gzsz009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz009
            
            #add-point:AFTER FIELD gzsz009 name="input.a.page1.gzsz009"
            CALL s_azzi990_check_gzsz009(g_gzsz_d[l_ac].gzsz009,g_gzsz_d[l_ac].gzsz003)
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD gzsz009
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzsz009
            #add-point:ON CHANGE gzsz009 name="input.g.page1.gzsz009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz017
            #add-point:BEFORE FIELD gzsz017 name="input.b.page1.gzsz017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz017
            
            #add-point:AFTER FIELD gzsz017 name="input.a.page1.gzsz017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzsz017
            #add-point:ON CHANGE gzsz017 name="input.g.page1.gzsz017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz013
            #add-point:BEFORE FIELD gzsz013 name="input.b.page1.gzsz013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz013
            
            #add-point:AFTER FIELD gzsz013 name="input.a.page1.gzsz013"
            #校驗 
            IF NOT cl_null(g_gzsz_d[l_ac].gzsz013) THEN
               IF NOT azzi990_check_gzsz013() THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00160"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD gzsz013
               END IF
            END IF             
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzsz013
            #add-point:ON CHANGE gzsz013 name="input.g.page1.gzsz013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzsz014
            #add-point:BEFORE FIELD gzsz014 name="input.b.page1.gzsz014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzsz014
            
            #add-point:AFTER FIELD gzsz014 name="input.a.page1.gzsz014"
            #開窗
            IF NOT cl_null(g_gzsz_d[l_ac].gzsz014) THEN 
               IF NOT azzi990_check_gzsz014() THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00159"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD gzsz014
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzsz014
            #add-point:ON CHANGE gzsz014 name="input.g.page1.gzsz014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszl005
            #add-point:BEFORE FIELD gzszl005 name="input.b.page1.gzszl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzszl005
            
            #add-point:AFTER FIELD gzszl005 name="input.a.page1.gzszl005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzszl005
            #add-point:ON CHANGE gzszl005 name="input.g.page1.gzszl005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzszl006
            #add-point:BEFORE FIELD gzszl006 name="input.b.page1.gzszl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzszl006
            
            #add-point:AFTER FIELD gzszl006 name="input.a.page1.gzszl006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzszl006
            #add-point:ON CHANGE gzszl006 name="input.g.page1.gzszl006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gzszstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzszstus
            #add-point:ON ACTION controlp INFIELD gzszstus name="input.c.page1.gzszstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzsz011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz011
            #add-point:ON ACTION controlp INFIELD gzsz011 name="input.c.page1.gzsz011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzsz002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz002
            #add-point:ON ACTION controlp INFIELD gzsz002 name="input.c.page1.gzsz002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzszl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzszl004
            #add-point:ON ACTION controlp INFIELD gzszl004 name="input.c.page1.gzszl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzsz003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz003
            #add-point:ON ACTION controlp INFIELD gzsz003 name="input.c.page1.gzsz003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzsz008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz008
            #add-point:ON ACTION controlp INFIELD gzsz008 name="input.c.page1.gzsz008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzsz016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz016
            #add-point:ON ACTION controlp INFIELD gzsz016 name="input.c.page1.gzsz016"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzsz_d[l_ac].gzsz016             #給予default值

            #給予arg

            CALL q_gzca002()                                #呼叫開窗

            LET g_gzsz_d[l_ac].gzsz016 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gzsz_d[l_ac].gzsz016 TO gzsz016              #顯示到畫面上

            NEXT FIELD gzsz016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gzsz009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz009
            #add-point:ON ACTION controlp INFIELD gzsz009 name="input.c.page1.gzsz009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzsz017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz017
            #add-point:ON ACTION controlp INFIELD gzsz017 name="input.c.page1.gzsz017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzsz013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz013
            #add-point:ON ACTION controlp INFIELD gzsz013 name="input.c.page1.gzsz013"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzsz_d[l_ac].gzsz013             #給予default值
            LET g_qryparam.default2 = "" #g_gzsz_d[l_ac].dzcd001 #校驗帶值識別碼

            #給予arg

            CALL q_dzcd001()                                #呼叫開窗

            LET g_gzsz_d[l_ac].gzsz013 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_gzsz_d[l_ac].dzcd001 = g_qryparam.return2 #校驗帶值識別碼

            DISPLAY g_gzsz_d[l_ac].gzsz013 TO gzsz013              #顯示到畫面上
            #DISPLAY g_gzsz_d[l_ac].dzcd001 TO dzcd001 #校驗帶值識別碼

            NEXT FIELD gzsz013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gzsz014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzsz014
            #add-point:ON ACTION controlp INFIELD gzsz014 name="input.c.page1.gzsz014"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzsz_d[l_ac].gzsz014             #給予default值

            #給予arg

            CALL q_dzca001()                                #呼叫開窗

            LET g_gzsz_d[l_ac].gzsz014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gzsz_d[l_ac].gzsz014 TO gzsz014              #顯示到畫面上

            NEXT FIELD gzsz014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gzszl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzszl005
            #add-point:ON ACTION controlp INFIELD gzszl005 name="input.c.page1.gzszl005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzszl006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzszl006
            #add-point:ON ACTION controlp INFIELD gzszl006 name="input.c.page1.gzszl006"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gzsz_d[l_ac].* = g_gzsz_d_t.*
               CLOSE azzi990_bcl
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
               LET g_errparam.extend = g_gzsz_d[l_ac].gzsz002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gzsz_d[l_ac].* = g_gzsz_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_gzsz2_d[l_ac].gzszmodid = g_user 
LET g_gzsz2_d[l_ac].gzszmoddt = cl_get_current()
LET g_gzsz2_d[l_ac].gzszmodid_desc = cl_get_username(g_gzsz2_d[l_ac].gzszmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL azzi990_gzsz_t_mask_restore('restore_mask_o')
         
               UPDATE gzsz_t SET (gzsz001,gzszstus,gzsz011,gzsz002,gzsz003,gzsz008,gzsz016,gzsz009,gzsz017, 
                   gzsz013,gzsz014,gzszownid,gzszowndp,gzszcrtid,gzszcrtdp,gzszcrtdt,gzszmodid,gzszmoddt) = (g_gzsz_m.gzsz001, 
                   g_gzsz_d[l_ac].gzszstus,g_gzsz_d[l_ac].gzsz011,g_gzsz_d[l_ac].gzsz002,g_gzsz_d[l_ac].gzsz003, 
                   g_gzsz_d[l_ac].gzsz008,g_gzsz_d[l_ac].gzsz016,g_gzsz_d[l_ac].gzsz009,g_gzsz_d[l_ac].gzsz017, 
                   g_gzsz_d[l_ac].gzsz013,g_gzsz_d[l_ac].gzsz014,g_gzsz2_d[l_ac].gzszownid,g_gzsz2_d[l_ac].gzszowndp, 
                   g_gzsz2_d[l_ac].gzszcrtid,g_gzsz2_d[l_ac].gzszcrtdp,g_gzsz2_d[l_ac].gzszcrtdt,g_gzsz2_d[l_ac].gzszmodid, 
                   g_gzsz2_d[l_ac].gzszmoddt)
                WHERE  gzsz001 = g_gzsz_m.gzsz001 
 
                 AND gzsz002 = g_gzsz_d_t.gzsz002 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzsz_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "gzsz_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzsz_m.gzsz001
               LET gs_keys_bak[1] = g_gzsz001_t
               LET gs_keys[2] = g_gzsz_d[g_detail_idx].gzsz002
               LET gs_keys_bak[2] = g_gzsz_d_t.gzsz002
               CALL azzi990_update_b('gzsz_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_gzsz_m.gzsz001 = g_detail_multi_table_t.gzszl001 AND
         g_gzsz_d[l_ac].gzsz002 = g_detail_multi_table_t.gzszl002 AND
         g_gzsz_d[l_ac].gzszl004 = g_detail_multi_table_t.gzszl004 AND
         g_gzsz_d[l_ac].gzszl005 = g_detail_multi_table_t.gzszl005 AND
         g_gzsz_d[l_ac].gzszl006 = g_detail_multi_table_t.gzszl006 THEN
         ELSE 
            LET l_var_keys[01] = g_gzsz_m.gzsz001
            LET l_field_keys[01] = 'gzszl001'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.gzszl001
            LET l_var_keys[02] = g_gzsz_d[l_ac].gzsz002
            LET l_field_keys[02] = 'gzszl002'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.gzszl002
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'gzszl003'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.gzszl003
            LET l_vars[01] = g_gzsz_d[l_ac].gzszl004
            LET l_fields[01] = 'gzszl004'
            LET l_vars[02] = g_gzsz_d[l_ac].gzszl005
            LET l_fields[02] = 'gzszl005'
            LET l_vars[03] = g_gzsz_d[l_ac].gzszl006
            LET l_fields[03] = 'gzszl006'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzszl_t')
         END IF 
 
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_gzsz_m),util.JSON.stringify(g_gzsz_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzsz_m),util.JSON.stringify(g_gzsz_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL azzi990_gzsz_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_gzsz_m.gzsz001
 
               LET ls_keys[ls_keys.getLength()+1] = g_gzsz_d_t.gzsz002
 
               CALL azzi990_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE azzi990_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gzsz_d[l_ac].* = g_gzsz_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE azzi990_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_gzsz_d.getLength() = 0 THEN
               NEXT FIELD gzsz002
            END IF
            #add-point:input段after input  name="input.body.after_input"
            #檢查是否 transaction
            IF s_transaction_chk("Y",0) THEN 
               CALL s_transaction_end('Y','0')   
            END IF
            FOR li_cnt = 1 TO g_gzsz_temp_d.getLength()
               #單身輸入後會call azzp990 insert 相對表格 
               RUN " r.r azzp990 " || g_gzsz_temp_d[li_cnt].gzsz001 || " " ||  g_gzsz_temp_d[li_cnt].combobox WITHOUT WAITING 
                   
                   DISPLAY "r.r azzp990 ",g_gzsz_temp_d[li_cnt].gzsz001 ," ",g_gzsz_temp_d[li_cnt].combobox
           END FOR
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gzsz_d[li_reproduce_target].* = g_gzsz_d[li_reproduce].*
               LET g_gzsz2_d[li_reproduce_target].* = g_gzsz2_d[li_reproduce].*
 
               LET g_gzsz_d[li_reproduce_target].gzsz002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gzsz_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gzsz_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_gzsz2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL azzi990_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL azzi990_idx_chk()
            CALL azzi990_ui_detailshow()
        
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
         
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD gzsz001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gzszstus
               WHEN "s_detail2"
                  NEXT FIELD gzsz002_2
 
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
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi990.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION azzi990_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   CALL azzi990_chk_gzsz004()
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL azzi990_b_fill(g_wc2) #第一階單身填充
      CALL azzi990_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL azzi990_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_gzsz_m.gzsz001,g_gzsz_m.gzsz001_desc,g_gzsz_m.combobox1
 
   CALL azzi990_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
 
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="azzi990.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION azzi990_ref_show()
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
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzsz_m.gzsz001
            CALL ap_ref_array2(g_ref_fields,"SELECT dzeal003 FROM dzeal_t WHERE dzeal001=? AND dzeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gzsz_m.gzsz001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzsz_m.gzsz001_desc

            

   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gzsz_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_gzsz_m.gzsz001
   LET g_ref_fields[2] = g_gzsz_d[l_ac].gzsz002
   CALL ap_ref_array2(g_ref_fields," SELECT gzszl004,gzszl005,gzszl006 FROM gzszl_t WHERE gzszl001 = ? AND gzszl002 = ? AND gzszl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_gzsz_d[l_ac].gzszl004 = g_rtn_fields[1] 
   LET g_gzsz_d[l_ac].gzszl005 = g_rtn_fields[2] 
   LET g_gzsz_d[l_ac].gzszl006 = g_rtn_fields[3] 
   DISPLAY BY NAME g_gzsz_d[l_ac].gzszl004,g_gzsz_d[l_ac].gzszl005,g_gzsz_d[l_ac].gzszl006
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_gzsz2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzsz2_d[l_ac].gzszownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_gzsz2_d[l_ac].gzszownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzsz2_d[l_ac].gzszownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzsz2_d[l_ac].gzszowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gzsz2_d[l_ac].gzszowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzsz2_d[l_ac].gzszowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzsz2_d[l_ac].gzszcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_gzsz2_d[l_ac].gzszcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzsz2_d[l_ac].gzszcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzsz2_d[l_ac].gzszcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gzsz2_d[l_ac].gzszcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzsz2_d[l_ac].gzszcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzsz2_d[l_ac].gzszmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_gzsz2_d[l_ac].gzszmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzsz2_d[l_ac].gzszmodid_desc

      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="azzi990.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION azzi990_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE gzsz_t.gzsz001 
   DEFINE l_oldno     LIKE gzsz_t.gzsz001 
 
   DEFINE l_master    RECORD LIKE gzsz_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE gzsz_t.* #此變數樣板目前無使用
 
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
 
   IF g_gzsz_m.gzsz001 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_gzsz001_t = g_gzsz_m.gzsz001
 
   
   LET g_gzsz_m.gzsz001 = ""
 
   LET g_master_insert = FALSE
   CALL azzi990_set_entry('a')
   CALL azzi990_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_gzsz_m.gzsz001_desc = ''
   DISPLAY BY NAME g_gzsz_m.gzsz001_desc
 
   
   CALL azzi990_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_gzsz_m.* TO NULL
      INITIALIZE g_gzsz_d TO NULL
      INITIALIZE g_gzsz2_d TO NULL
 
      CALL azzi990_show()
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
   CALL azzi990_set_act_visible()
   CALL azzi990_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzsz001_t = g_gzsz_m.gzsz001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzsz001 = '", g_gzsz_m.gzsz001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi990_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL azzi990_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL azzi990_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi990.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION azzi990_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gzsz_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE azzi990_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gzsz_t
    WHERE  gzsz001 = g_gzsz001_t
 
       INTO TEMP azzi990_detail
   
   #將key修正為調整後   
   UPDATE azzi990_detail 
      #更新key欄位
      SET gzsz001 = g_gzsz_m.gzsz001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , gzszownid = g_user 
       , gzszowndp = g_dept
       , gzszcrtid = g_user
       , gzszcrtdp = g_dept 
       , gzszcrtdt = ld_date
       , gzszmodid = g_user
       , gzszmoddt = ld_date
      #, gzszstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO gzsz_t SELECT * FROM azzi990_detail
   
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
   DROP TABLE azzi990_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
      #應用 a38 樣板自動產生(Version:6)
   #單身多語言複製
   DROP TABLE azzi990_detail_lang
   
   #add-point:單身複製前1 name="detail_reproduce.body.lang0.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE & INSERT 
   SELECT * FROM gzszl_t 
    WHERE  gzszl001 = g_gzsz001_t
 
     INTO TEMP azzi990_detail_lang
 
   #將key修正為調整後   
   UPDATE azzi990_detail_lang 
      #更新key欄位
      SET gzszl001 = g_gzsz_m.gzsz001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.lang0.b_update"
   
   #end add-point   
  
   #將資料塞回原table   
   INSERT INTO gzszl_t SELECT * FROM azzi990_detail_lang
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.lang0.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE azzi990_detail_lang
   
   #add-point:單身複製後1 name="detail_reproduce.lang0.table1.a_insert"
   
   #end add-point
 
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gzsz001_t = g_gzsz_m.gzsz001
 
   
   DROP TABLE azzi990_detail
   
END FUNCTION
 
{</section>}
 
{<section id="azzi990.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi990_delete()
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
   #161125-00032 start
   IF g_gzsz_m.combobox1 = "D" THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = "azz-00420" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN 
   END IF
   #161125-00032 end
   #end add-point
   
   IF g_gzsz_m.gzsz001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN azzi990_cl USING g_gzsz_m.gzsz001
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi990_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE azzi990_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi990_master_referesh USING g_gzsz_m.gzsz001 INTO g_gzsz_m.gzsz001,g_gzsz_m.gzsz001_desc 
 
   
   #遮罩相關處理
   LET g_gzsz_m_mask_o.* =  g_gzsz_m.*
   CALL azzi990_gzsz_t_mask()
   LET g_gzsz_m_mask_n.* =  g_gzsz_m.*
   
   CALL azzi990_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzi990_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM gzsz_t WHERE  gzsz001 = g_gzsz_m.gzsz001
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzsz_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
         INITIALIZE l_field_keys TO NULL 
         LET l_field_keys[01] = 'gzszl001'
         LET l_var_keys_bak[01] = g_detail_multi_table_t.gzszl001
         CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'gzszl_t')
 
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE azzi990_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_gzsz_d.clear() 
      CALL g_gzsz2_d.clear()       
 
     
      CALL azzi990_ui_browser_refresh()  
      #CALL azzi990_ui_headershow()  
      #CALL azzi990_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL azzi990_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL azzi990_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE azzi990_cl
 
   #功能已完成,通報訊息中心
   CALL azzi990_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="azzi990.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi990_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_gzsz_d.clear()
   CALL g_gzsz2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT gzszstus,gzsz011,gzsz002,gzsz003,gzsz008,gzsz016,gzsz009,gzsz017,gzsz013, 
       gzsz014,gzsz002,gzszownid,gzszowndp,gzszcrtid,gzszcrtdp,gzszcrtdt,gzszmodid,gzszmoddt,t1.ooag011 , 
       t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM gzsz_t",   
               " LEFT JOIN gzszl_t ON gzsz001 = gzszl001 AND gzsz002 = gzszl002 AND gzszl003 = '",g_dlang,"'",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=gzszownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=gzszowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=gzszcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=gzszcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=gzszmodid  ",
 
               " WHERE gzsz001=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("gzsz_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF azzi990_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY gzsz_t.gzsz002"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE azzi990_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR azzi990_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_gzsz_m.gzsz001   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_gzsz_m.gzsz001 INTO g_gzsz_d[l_ac].gzszstus,g_gzsz_d[l_ac].gzsz011,g_gzsz_d[l_ac].gzsz002, 
          g_gzsz_d[l_ac].gzsz003,g_gzsz_d[l_ac].gzsz008,g_gzsz_d[l_ac].gzsz016,g_gzsz_d[l_ac].gzsz009, 
          g_gzsz_d[l_ac].gzsz017,g_gzsz_d[l_ac].gzsz013,g_gzsz_d[l_ac].gzsz014,g_gzsz2_d[l_ac].gzsz002, 
          g_gzsz2_d[l_ac].gzszownid,g_gzsz2_d[l_ac].gzszowndp,g_gzsz2_d[l_ac].gzszcrtid,g_gzsz2_d[l_ac].gzszcrtdp, 
          g_gzsz2_d[l_ac].gzszcrtdt,g_gzsz2_d[l_ac].gzszmodid,g_gzsz2_d[l_ac].gzszmoddt,g_gzsz2_d[l_ac].gzszownid_desc, 
          g_gzsz2_d[l_ac].gzszowndp_desc,g_gzsz2_d[l_ac].gzszcrtid_desc,g_gzsz2_d[l_ac].gzszcrtdp_desc, 
          g_gzsz2_d[l_ac].gzszmodid_desc   #(ver:49)
                             
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
 
            CALL g_gzsz_d.deleteElement(g_gzsz_d.getLength())
      CALL g_gzsz2_d.deleteElement(g_gzsz2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_gzsz_d.getLength()
      LET g_gzsz_d_mask_o[l_ac].* =  g_gzsz_d[l_ac].*
      CALL azzi990_gzsz_t_mask()
      LET g_gzsz_d_mask_n[l_ac].* =  g_gzsz_d[l_ac].*
   END FOR
   
   LET g_gzsz2_d_mask_o.* =  g_gzsz2_d.*
   FOR l_ac = 1 TO g_gzsz2_d.getLength()
      LET g_gzsz2_d_mask_o[l_ac].* =  g_gzsz2_d[l_ac].*
      CALL azzi990_gzsz_t_mask()
      LET g_gzsz2_d_mask_n[l_ac].* =  g_gzsz2_d[l_ac].*
   END FOR
 
 
   FREE azzi990_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="azzi990.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION azzi990_idx_chk()
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
      IF g_detail_idx > g_gzsz_d.getLength() THEN
         LET g_detail_idx = g_gzsz_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_gzsz_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzsz_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_gzsz2_d.getLength() THEN
         LET g_detail_idx = g_gzsz2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzsz2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzsz2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi990.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzi990_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_gzsz_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="azzi990.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION azzi990_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM gzsz_t
    WHERE  gzsz001 = g_gzsz_m.gzsz001 AND
 
          gzsz002 = g_gzsz_d_t.gzsz002
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzsz_t:",SQLERRMESSAGE 
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
 
{<section id="azzi990.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi990_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="azzi990.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi990_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="azzi990.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi990_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="azzi990.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION azzi990_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_gzsz_d[l_ac].gzsz002 = g_gzsz_d_t.gzsz002 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi990.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION azzi990_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="azzi990.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi990_lock_b(ps_table,ps_page)
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
   #CALL azzi990_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi990.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi990_unlock_b(ps_table,ps_page)
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
 
{<section id="azzi990.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION azzi990_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gzsz001",TRUE)
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
 
{<section id="azzi990.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION azzi990_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gzsz001",FALSE)
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
 
{<section id="azzi990.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi990_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   CALL cl_set_comp_required("gzszl004,gzszl005",TRUE)    #170110-00033 #1 add
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi990.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi990_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi990.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION azzi990_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi990.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION azzi990_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi990.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION azzi990_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi990.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION azzi990_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi990.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi990_default_search()
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
      LET ls_wc = ls_wc, " gzsz001 = '", g_argv[01], "' AND "
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
   IF cl_null(g_wc2) THEN 
      LET g_wc2 = " (gzsz002 LIKE 'A%' OR gzsz002 LIKE 'S%' OR gzsz002 LIKE 'E%' OR gzsz002 LIKE 'T%' ) "
   END IF 
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzi990.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION azzi990_fill_chk(ps_idx)
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
 
{<section id="azzi990.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION azzi990_modify_detail_chk(ps_record)
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
         LET ls_return = "gzszstus"
      WHEN "s_detail2"
         LET ls_return = "gzsz002_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="azzi990.mask_functions" >}
&include "erp/azz/azzi990_mask.4gl"
 
{</section>}
 
{<section id="azzi990.state_change" >}
    
 
{</section>}
 
{<section id="azzi990.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi990_set_pk_array()
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
   LET g_pk_array[1].values = g_gzsz_m.gzsz001
   LET g_pk_array[1].column = 'gzsz001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi990.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION azzi990_msgcentre_notify(lc_state)
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
   CALL azzi990_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gzsz_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi990.other_function" readonly="Y" >}
################################################################################
# Descriptions...: #+ 檢核限制資料型態
#+                      選項有
#+                      1: Y/N
#+                      2: 整數選項  
#+                      3: 範圍設定
#+                      4: 字元
#+                      5: 日期
# Memo...........:
# Usage..........: CALL azzi990_check_gzsz003
#                  
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi990_check_gzsz003()
   #gzsz003: 1:Y/N
   #gzsz003: 2:整數選項
   #gzsz003: 3:範圍設定
   #gzsz003: 4:字元
   #gzsz003: 5:日期

  #輸入限制資料型態設定為整數選項或範圍設定(gzsz003) 值域範圍說明SCC(gzsz016) 
  #在『整數選項』OR『範圍設定』 OR『字元』(未設定SCC) 情況下，才可以設定『開窗  (查詢r.q是否存在)』『校驗 (查詢r.v是否存在)
  IF g_gzsz_d[l_ac].gzsz003 = "2" OR g_gzsz_d[l_ac].gzsz003 = "3" THEN 
     CALL cl_set_comp_entry("gzsz016",FALSE)
     CALL cl_set_comp_entry("gzsz013,gzsz014",TRUE) 
     IF g_gzsz_d[l_ac].gzsz003 = "2" THEN 
        LET g_gzsz_d[l_ac].gzsz016 =  "" #值域範圍說明(SCC)
     END IF  
  ELSE

     IF g_gzsz_d[l_ac].gzsz003 = "4" AND NOT sadzp153_chk_gzsz016(g_gzsz_d[l_ac].gzsz016) THEN 
        
        CALL cl_set_comp_entry("gzsz013,gzsz014",TRUE) 
     ELSE 
        
        CALL cl_set_comp_entry("gzsz013,gzsz014",FALSE)

        #若有設定scc資訊，則將校驗及開窗資訊清空
        LET g_gzsz_d[l_ac].gzsz013 = ""
        LET g_gzsz_d[l_ac].gzsz014 = ""
        DISPLAY g_gzsz_d[l_ac].gzsz013 TO gzsz013
        DISPLAY g_gzsz_d[l_ac].gzsz014 TO gzsz014
     END IF  
     CALL cl_set_comp_entry("gzsz016",TRUE)
  END IF
END FUNCTION
#+ 檢核 ent 及site
#+ Site 級參數：依 Site 設置 (PK = ENT + SITE)
#+ Enterprise 級參數：依 Enterprise 設置  (PK = ENT)
PRIVATE FUNCTION azzi990_check_ent_or_site(ps_temp)
   DEFINE ps_temp    STRING
   DEFINE ls_token   STRING
   DEFINE ls_return  STRING
   DEFINE tok        base.StringTokenizer
   DEFINE li_rtn     STRING 
   DEFINE li_chk_ent LIKE type_t.num5
   DEFINE li_chk_site LIKE type_t.num5

   LET li_chk_ent = FALSE
   LET li_chk_site = FALSE 
   LET tok = base.StringTokenizer.create(ps_temp,",")
   WHILE tok.hasMoreTokens()
      LET ls_token = tok.nextToken()

      CASE 
         WHEN ls_token.getIndexOf("ent",1) 
            LET li_chk_ent = TRUE  
            #EXIT WHILE  
         WHEN ls_token.getIndexOf("site",1) 
            LET li_chk_site = TRUE  
            #EXIT WHILE 
         OTHERWISE 
            LET li_rtn = "" 
      END CASE    
 
   END WHILE

   #All system級參數
   IF NOT li_chk_ent AND NOT li_chk_site THEN 
      LET li_rtn = "A" 
   END IF
   #Enterprise 級參數：依 Enterprise 設置(PK = ENT)
   IF li_chk_ent AND NOT li_chk_site THEN 
      #161125-00032 start
      IF g_gzsz_m.gzsz001 = "ooac_t" THEN  #ooac_t 是單據別參數表
         LET li_rtn = "D"
         RETURN li_rtn
      END IF 
      #161125-00032 end
      LET li_rtn = "E" 
   END IF
   #Site 級參數：依 Site 設置(PK = ENT + SITE) 
   IF li_chk_ent AND li_chk_site THEN 
      LET li_rtn = "S" 
   END IF

   RETURN li_rtn
END FUNCTION
#+ 檢核gzsz002
#+ Site 級參數 S開頭-gzsz011-xxxx
#+ Enterprise 級參數 E開頭-gzsz011-xxx

#+客製機制
#+一樣採取分開註冊區域的動作 (但在 azzi993 不勾稽不管制)
#+DGENV = c 參數編號 型態-分類C參數編號
#+DGENV = s 參數編號 型態-分類-參數編號
PRIVATE FUNCTION azzi990_check_gzsz002(ps_cmd)
   DEFINE  ps_cmd          LIKE type_t.chr1
   DEFINE ps_field         STRING 
   DEFINE ls_str           STRING
   DEFINE ls_num           STRING
   DEFINE li_num           LIKE type_t.num5
   DEFINE li_inx           LIKE type_t.num5
   DEFINE ls_st_or_cust    STRING 

   LET g_errno = NULL 
   #判斷標準或客製
   IF FGL_GETENV("DGENV") = 's' THEN 
      LET ls_st_or_cust = '-' 
   ELSE 
      LET ls_st_or_cust = 'C'
   END IF
   
   LET ls_str = g_gzsz_d[l_ac].gzsz002
   
      LET li_num = ls_str.getIndexOf("-",1)
      IF li_num THEN
         LET ls_num = ls_str.subString(li_num+1,li_num+3)  
         IF NOT azzi990_chk_app_range(ls_num) THEN 
            LET g_errno = "azz-00196"
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "azz-00196"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF  
      END IF 
      LET li_num = ls_str.getLength()-3
      IF cl_chk_num(ls_str.subString(li_num,ls_str.getLength()),"N") THEN 
         LET ls_num =  ls_str.subString(li_num,ls_str.getLength())
      END IF   
  
      IF cl_null(ls_num) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "azz-00131"
         LET g_errparam.extend = ls_str
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE 
      ELSE 
         IF NOT cl_chk_num(ls_num,"N") OR ls_num.getLength() <> 4 THEN 
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "azz-00131"
         LET g_errparam.extend = ls_str
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
            RETURN FALSE
         END IF
          
         LET ls_str = g_gzsz_m.combobox1,"-",g_gzsz_d[l_ac].gzsz011,ls_st_or_cust,ls_num
         LET g_gzsz_d[l_ac].gzsz002 = ls_str 
         RETURN TRUE 
      END IF  
   RETURN TRUE  
END FUNCTION
#+ 檢核gzsz004
#+ 顯示E企業級或 S據點級或 R參照表 或 D單據別
PRIVATE FUNCTION azzi990_chk_gzsz004()
   DEFINE lc_dzed004 LIKE  dzed_t.dzed004
   DEFINE li_rtn     LIKE  type_t.num5

  SELECT  dzed004 INTO lc_dzed004
     FROM dzed_t  
     WHERE dzed001 = g_gzsz_m.gzsz001 
      AND dzed003 = 'P' 
     
  DISPLAY   "PK:",lc_dzed004
  LET g_gzsz_m.combobox1 =  azzi990_check_ent_or_site(lc_dzed004)
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi990_get_max_serial_num(ps_str)
#                  RETURNING lc_gzsz002
# Input parameter:  ps_str STRING  
#                :
# Return code....:  lc_gzsz002 CHAR
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi990_get_max_serial_num(ps_str)
   DEFINE ls_sql STRING 
   DEFINE ps_str STRING 
   DEFINE lc_gzsz002 LIKE gzsz_t.gzsz002
   
   LET ls_sql = "SELECT max(gzsz002) FROM gzsz_t " ,
                "   WHERE gzsz001 = '",g_gzsz_m.gzsz001,"'",
                "   AND  gzsz002 LIKE '",ps_str,"%'" , 
                "   ORDER BY gzsz002 " 
   PREPARE azzi990_get_max_pre FROM ls_sql 
   EXECUTE azzi990_get_max_pre INTO lc_gzsz002              
   FREE azzi990_get_max_pre
   RETURN lc_gzsz002
END FUNCTION
################################################################################
# Descriptions...: 檢核gzsz009 值域範圍
# Memo...........:
# Usage..........: CALL azzi990_check_gzsz009()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi990_check_gzsz009()
   DEFINE ls_gzsz009 STRING 
   DEFINE li_index   LIKE type_t.num5
   DEFINE li_chk     LIKE type_t.num5
    

   LET ls_gzsz009 = g_gzsz_d[l_ac].gzsz009
   LET li_chk = FALSE
   LET g_errno = NULL 

   #輸入資料型態是整數選項:2或範圍選項:3 必須檢核
   #可以數字區間
   #可以>= > < <=
   #離散性的資料，可以用逗號分隔，如：1,8,9,20,21,99 只有正數選項才有
   IF g_gzsz_d[l_ac].gzsz003 = "2" OR g_gzsz_d[l_ac].gzsz003 = "3" THEN 
      #確認第1個位置是否數字
      IF cl_chk_num(ls_gzsz009.subString(1,1),"N") THEN  
         IF ls_gzsz009.getIndexOf("-",1) THEN  #表示數字區間

            CASE 
               WHEN ls_gzsz009.getIndexOf("-",1)
                    LET li_index = ls_gzsz009.getIndexOf("-",1)
            END CASE 
            #整數選項:2 
            IF g_gzsz_d[l_ac].gzsz003 = "2" THEN 
               IF NOT cl_chk_num(ls_gzsz009.subString(1,li_index-1),"N") OR NOT cl_chk_num(ls_gzsz009.subString(li_index+1,ls_gzsz009.getLength()),"N") THEN 
                  LET g_errno = "azz-00139"            #值域範圍須數字 
               END IF
            ELSE
               #範圍選項:3 檢核小數資料
               IF azzi990_chk_decimal_data(ls_gzsz009.subString(1,li_index-1)) OR 
                  azzi990_chk_decimal_data(ls_gzsz009.subString(li_index+1,ls_gzsz009.getLength())) THEN 
                  LET g_errno = "azz-00139" 
              END IF   
            END IF 
         ELSE 
            CASE
               # 整數選項:2  可以有離散性的資料
               #WHEN g_gzsz_d[l_ac].gzsz003 = "2" AND ls_gzsz009.getIndexOf(",",1) 
                    #CALL azzi990_chk_gzsz009_discrete_data(ls_gzsz009)
               WHEN ls_gzsz009.getIndexOf(",",1) 
                  CALL azzi990_chk_gzsz009_discrete_data(g_gzsz_d[l_ac].gzsz003,ls_gzsz009)

               OTHERWISE 
                  LET g_errno = "azz-00140"          #值域範圍要有區間 
            END CASE                  
         END IF
      ELSE
         CASE 
            WHEN ls_gzsz009.getIndexOf(">",1) OR ls_gzsz009.getIndexOf("<",1)
                 CASE 
                     WHEN ls_gzsz009.getIndexOf(">",1)
                        LET li_index = ls_gzsz009.getIndexOf(">",1)
  
                     WHEN ls_gzsz009.getIndexOf("<",1)
                        LET li_index = ls_gzsz009.getIndexOf("<",1)
                 END CASE

                    IF ls_gzsz009.getIndexOf("=",li_index+1) THEN 
                       IF g_gzsz_d[l_ac].gzsz003 = "2" THEN  
                          IF NOT cl_chk_num(ls_gzsz009.subString(li_index+2,ls_gzsz009.getLength()),"N") THEN 
                             LET g_errno = "azz-00139"  #值域範圍須數字
                          END IF
                       ELSE
                          # 範圍選項:3  
                          IF azzi990_chk_decimal_data(ls_gzsz009.subString(li_index+2,ls_gzsz009.getLength())) THEN 
                             LET g_errno = "azz-00139"  #值域範圍須數字
                          END IF 
                       END IF  
                    ELSE
                       IF g_gzsz_d[l_ac].gzsz003 = "2" THEN  
                          IF NOT cl_chk_num(ls_gzsz009.subString(li_index+1,ls_gzsz009.getLength()),"N") THEN 
                             LET g_errno = "azz-00139"  #值域範圍須數字
                          END IF
                       ELSE 
                          # 範圍選項:3  
                          IF azzi990_chk_decimal_data(ls_gzsz009.subString(li_index+1,ls_gzsz009.getLength())) THEN 
                             LET g_errno = "azz-00139"  #值域範圍須數字
                          END IF 
                       END IF  

                    END IF





            OTHERWISE
              LET li_chk = FALSE 
              LET g_errno = "azz-00141"           #值域範圍要有>= > < <= 符號開頭
         END CASE       
      END IF 
   END IF
   #RETURN  
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi990_chk_gzsz009_discrete_data(ps_gzsz003,ps_gzsz009)
#                  
# Input parameter: ps_gzsz009  STRING  離散資料
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi990_chk_gzsz009_discrete_data(ps_gzsz003,ps_gzsz009)
   DEFINE ps_gzsz009    STRING 
   DEFINE l_token       base.StringTokenizer
   DEFINE l_token2      base.StringTokenizer
   DEFINE ls_next       STRING
   DEFINE ls_next2      STRING
   DEFINE ps_gzsz003    STRING 
   DEFINE li_chk        LIKE type_t.num5

   LET l_token = base.StringTokenizer.create(ps_gzsz009, ",")
   LET li_chk = FALSE 
   WHILE l_token.hasMoreTokens()
      LET ls_next = l_token.nextToken()
      LET ls_next = ls_next.trim()
      IF NOT cl_chk_num(ls_next,"N") THEN 
         #資料型態是整數選項:2 必須是整數 
         IF ps_gzsz003 = "2" THEN 
            LET g_errno = "azz-00139"
            EXIT WHILE 

         ELSE 
            IF ls_next.getIndexOf(".",1) THEN 
               LET l_token2 = base.StringTokenizer.create(ls_next, ".")
               WHILE l_token2.hasMoreTokens()
                  LET ls_next2 = l_token2.nextToken()
                  LET ls_next2 = ls_next2.trim()

                  IF NOT cl_chk_num(ls_next2,"N") THEN 
                     LET g_errno = "azz-00139"
                     LET li_chk = TRUE 
                     EXIT WHILE 
                  END IF 
               END WHILE
               IF li_chk THEN 
                  EXIT WHILE 
               END IF  
            ELSE
               LET g_errno = "azz-00139"               #小數點
               EXIT WHILE 
            END IF 
         END IF 
         #LET g_errno = "azz-00139"                 #整數數字 
      END IF  
   END WHILE 
END FUNCTION
################################################################################
# Descriptions...: 檢核gzsz002 參數編號是否可以修改或刪除 
#                  假如有在gzsv_t 有資料表示不可以修改或刪除
# Memo...........:
# Usage..........: azzi990_chk_gzsz002_param()
#                  RETURNING TRUE/FALSE
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi990_chk_gzsz002_param()
   DEFINE p_cmd  LIKE type_t.chr1
   DEFINE li_cnt LIKE type_t.num5

   SELECT COUNT(*) INTO li_cnt
      FROM  gzsv_t 
      WHERE gzsv005 = g_gzsz_m.gzsz001 
      AND gzsv006 = g_gzsz_d_t.gzsz002

   IF li_cnt > 0 THEN 
      RETURN TRUE 
   ELSE 
      RETURN FALSE 
   END IF    
END FUNCTION
################################################################################
# Descriptions...: 產生批次參數程式
# Memo...........:
# Usage..........: CALL azzi990_gen_batch_param()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi990_gen_batch_param()
   DEFINE lc_gzsv001 LIKE gzsv_t.gzsv001

   DECLARE azzi990_gen_bat_param CURSOR FOR
      SELECT DISTINCT gzsv001 
       FROM gzsv_t  
        WHERE gzsv005 = g_gzsz_m.gzsz001

   FOREACH  azzi990_gen_bat_param INTO lc_gzsv001
      RUN os.Path.join(os.Path.join(FGL_GETENV("UTL"),"bin"),"gens") || " " ||  cl_get_module(lc_gzsv001,"d") || " " || lc_gzsv001 WITHOUT WAITING
   END FOREACH 
         
   CLOSE azzi990_gen_bat_param
END FUNCTION
################################################################################
# Descriptions...: grep "參數編號" $ERP/???/4gl/*.4gl
#                  grep "參數編號" $COM/???/4gl/*.4gl                  
# Memo...........:
# Usage..........: CALL azzi990_chk_gzsz002_grep_param()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi990_chk_gzsz002_grep_param()
    DEFINE ls_cmd STRING 
   DEFINE ls_str                  STRING
   DEFINE l_read                  base.Channel
   DEFINE ls_msg                   STRING
   

   LET l_read = base.Channel.create()
   #“參數編號” $ERP/???/4gl/*.4gl
   LET ls_cmd = "grep ","\'",g_gzsz_d[l_ac].gzsz002,"\' $ERP",os.Path.separator(),"???",os.Path.separator(),"4gl",os.Path.separator(),"*.4gl"
      #執行指令
   CALL l_read.openPipe(ls_cmd, "r")
   
   WHILE TRUE
      LET ls_str = l_read.readLine()
      IF l_read.isEof() THEN 
         EXIT WHILE 
      END IF
      LET ls_msg = ls_msg, ls_str
   END WHILE
   DISPLAY ls_msg
   CALL l_read.close()
   LET ls_str =  g_gzsz_d[l_ac].gzsz002,'|', ls_msg
   IF NOT cl_null(ls_msg) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "azz-00158"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  ls_str
      CALL cl_err()
 
      RETURN TRUE 
   END IF 
   
   #“參數編號” $ERP/???/4gl/*.4gl
   LET ls_cmd = "grep ", "\'",g_gzsz_d[l_ac].gzsz002,"\' $COM",os.Path.separator(),"???",os.Path.separator(),"4gl",os.Path.separator(),"*.4gl"
   #執行指令
   CALL l_read.openPipe(ls_cmd, "r")
   LET ls_str = ""
   LET ls_msg = ""
   WHILE TRUE
      LET ls_str = l_read.readLine()
      IF l_read.isEof() THEN 
         EXIT WHILE 
      END IF
      LET ls_msg = ls_msg, ls_str
   END WHILE

   LET ls_str =  g_gzsz_d[l_ac].gzsz002,'|', ls_msg
   IF NOT cl_null(ls_msg) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "azz-00158"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  ls_str
      CALL cl_err()
      RETURN TRUE 
   END IF
   DISPLAY ls_msg
   CALL l_read.close()
   RETURN FALSE 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi990_check_gzsz013()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi990_check_gzsz013()
    #(查詢r.v是否存在)
    DEFINE li_cnt     LIKE type_t.num5
    
    SELECT COUNT(*) INTO li_cnt 
     FROM dzcd_t
      WHERE dzcd001 = g_gzsz_d[l_ac].gzsz013 

   IF li_cnt > 0 THEN 
      RETURN TRUE 
   END IF 
   RETURN FALSE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi990_check_gzsz014()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi990_check_gzsz014()
   #(查詢r.q是否存在)
      DEFINE li_cnt     LIKE type_t.num5
    
     SELECT COUNT(*) INTO li_cnt 
      FROM dzca_t
       WHERE dzca001 = g_gzsz_d[l_ac].gzsz014  

   IF li_cnt > 0 THEN 
      RETURN TRUE 
   END IF 
   RETURN FALSE    
   
END FUNCTION

################################################################################
# Descriptions...: 帶出SCC
# Memo...........:
# Usage..........: CALL azzi990_get_scc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi990_get_scc()
   DEFINE lc_gzcb002 LIKE gzcb_t.gzcb002 
   DEFINE ls_gzcb002 STRING 
   DECLARE azzi990_get_scc_cs CURSOR FOR 
     SELECT gzcb002 FROM gzcb_t 
       WHERE gzcb001 = g_gzsz_d[l_ac].gzsz016
   FOREACH azzi990_get_scc_cs INTO lc_gzcb002
      LET ls_gzcb002 = ls_gzcb002,lc_gzcb002,","
   END FOREACH
   IF NOT cl_null(ls_gzcb002) THEN 
      LET ls_gzcb002 = ls_gzcb002.subString(1,ls_gzcb002.getLength()-1) 
   END IF 
   LET g_gzsz_d[l_ac].gzsz009 = ls_gzcb002
   CLOSE azzi990_get_scc_cs
END FUNCTION

################################################################################
# Descriptions...: 檢核參數類型
# Memo...........:
# Usage..........: CALL azzi990_chk_app_range(pc_gzcb002)
#                  RETURNING TRUE/FALSE
# Input parameter: pc_gzcb002 CHAR(10)
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi990_chk_app_range(pc_gzcb002)
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE pc_gzcb002  LIKE gzcb_t.gzcb002
   DEFINE ps_gzcb002  STRING 

   SELECT COUNT(*) INTO li_cnt FROM gzcb_t
    WHERE gzcb001 = '90' 
     AND gzcb002 = pc_gzcb002

   IF li_cnt > 0 THEN 
      RETURN TRUE 
   ELSE
      #確認是否 行業專用 
      IF pc_gzcb002[1,1] = "B" THEN
         LET pc_gzcb002 = DOWNSHIFT(pc_gzcb002[2,3])  
         SELECT COUNT(*) INTO li_cnt FROM gzoi_t
          WHERE gzoi001 = pc_gzcb002  
           AND gzoistus = 'Y'
         IF li_cnt > 0 THEN 
            RETURN TRUE
         END IF   
      END IF 
      RETURN FALSE 
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 檢核gzsz011
# Memo...........:
# Usage..........: CALL azzi990_check_gzsz011(ps_cmd)
#                  RETURNING 
# Input parameter: ps_cmd CHAR(1)
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi990_check_gzsz011(ps_cmd)
   DEFINE  ps_cmd          LIKE type_t.chr1
   DEFINE ls_str           STRING
   DEFINE ls_num           STRING
   DEFINE li_num           LIKE type_t.num5
   DEFINE li_inx           LIKE type_t.num5
   DEFINE ls_st_or_cust    STRING 

   DEFINE lc_first_code  LIKE type_t.chr1 

   LET lc_first_code = DOWNSHIFT(g_gzsz_d[l_ac].gzsz011[1,1])
   #標準
   IF FGL_GETENV("DGENV") = "s" THEN 

      IF lc_first_code MATCHES "[b]" THEN 
         #檢查行業代碼不可以為sd
         IF DOWNSHIFT(g_gzsz_d[l_ac].gzsz011[2,3]) = "sd" THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "azz-00179"
            LET g_errparam.extend = ""               
            LET g_errparam.popup = FALSE
            CALL cl_err()
            RETURN   
         END IF
         
         #檢查在指定區域才可以設置指定的行業編號 
         IF NOT cl_chk_in_industry(DOWNSHIFT(g_gzsz_d[l_ac].gzsz011[2,3])) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "azz-00378"
            LET g_errparam.extend = ""
            LET g_errparam.replace[1] = g_gzsz_d[l_ac].gzsz011[2,3]
            LET g_errparam.replace[2] = FGL_GETENV("TOPIND")
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN 
         END IF

      ELSE 
         #行業的開發環境,不可以讓他建立標準程式
         IF FGL_GETENV("TOPIND") IS NOT NULL AND FGL_GETENV("TOPIND") <> "sd" THEN  
            #IF FGL_GETENV("DGENV") IS NOT NULL AND FGL_GETENV("DGENV") = "s" THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = "azz-00378"
                LET g_errparam.extend = ""
                LET g_errparam.replace[1] = "sd"
                LET g_errparam.replace[2] = FGL_GETENV("TOPIND")
                LET g_errparam.popup = TRUE
                CALL cl_err() 
                RETURN 
            #END IF  
          END IF 
      END IF 
   ELSE 
      #不可以客製行業新建參數
      IF lc_first_code MATCHES "[b]" THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "azz-00176"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_gzsz_d[l_ac].gzsz002
         CALL cl_err()
         RETURN
      END IF      
   END IF 


   #判斷標準或客製
   IF FGL_GETENV("DGENV") = 's' THEN 
      LET ls_st_or_cust = '-' 
   ELSE 
      LET ls_st_or_cust = 'C'
   END IF
   LET ls_str = g_gzsz_d[l_ac].gzsz002 
  #新增
  IF ps_cmd = 'a' THEN 
      #領域應用類型gzsz011
      IF cl_null(g_gzsz_d[l_ac].gzsz011) THEN 
         LET ls_str = g_gzsz_m.combobox1,"-"
      ELSE 
         LET ls_str = g_gzsz_m.combobox1,"-",g_gzsz_d[l_ac].gzsz011 
         #取最大數字
         CALL azzi990_get_max_serial_num(ls_str) RETURNING ls_num
         #ls_num 第一筆 從0001開始
         IF cl_null(ls_num) THEN                       
            LET ls_str = g_gzsz_m.combobox1,"-",g_gzsz_d[l_ac].gzsz011,ls_st_or_cust,"0001" 
         ELSE
            LET li_num = ls_num.subString(ls_num.getIndexOf("-",3)+1,ls_num.getLength()) + 1
            LET ls_num = li_num USING "&&&&"   #補零          
            LET ls_str = g_gzsz_m.combobox1,"-",g_gzsz_d[l_ac].gzsz011,ls_st_or_cust,ls_num         
         END IF 
      END IF  
   ELSE 
      LET ls_str = g_gzsz_m.combobox1,"-",g_gzsz_d[l_ac].gzsz011,ls_st_or_cust,ls_str.subString(ls_str.getLength()-3,ls_str.getLength())
   END IF 
   LET g_gzsz_d[l_ac].gzsz002 = ls_str
END FUNCTION

################################################################################
# Descriptions...: 檢核小數資料
# Memo...........:
# Usage..........: CALL azzi990_chk_decimal_data(ps_data)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi990_chk_decimal_data(ps_data)
   DEFINE ps_data STRING 
   DEFINE ps_gzsz009    STRING 
   DEFINE l_token       base.StringTokenizer
   DEFINE ls_next       STRING
   DEFINE li_chk        LIKE type_t.num5

   LET li_chk = FALSE 
   LET l_token = base.StringTokenizer.create(ps_data, ".")
   WHILE l_token.hasMoreTokens()
      LET ls_next = l_token.nextToken()
      LET ls_next = ls_next.trim()
      IF NOT cl_chk_num(ls_next,"N") THEN 
         LET li_chk = TRUE 
         EXIT WHILE 
      END IF  
   END WHILE 

   RETURN li_chk
END FUNCTION

 
{</section>}
 
