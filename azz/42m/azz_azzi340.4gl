#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi340.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-08-17 16:56:05), PR版次:0001(2015-08-27 23:44:54)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000034
#+ Filename...: azzi340
#+ Description: 報表匯出權限控管設定作業
#+ Creator....: 04010(2015-08-03 17:32:09)
#+ Modifier...: 04010 -SD/PR- 04010
 
{</section>}
 
{<section id="azzi340.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#Memos
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
PRIVATE type type_g_gzgo_m        RECORD
       gzgo001 LIKE gzgo_t.gzgo001, 
   gzgo001_desc LIKE type_t.chr80, 
   gzgo002 LIKE gzgo_t.gzgo002, 
   gzgo002_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gzgo_d        RECORD
       gzgostus LIKE gzgo_t.gzgostus, 
   gzgo003 LIKE gzgo_t.gzgo003, 
   gzgo003_desc LIKE type_t.chr500, 
   gzgo004 LIKE gzgo_t.gzgo004
       END RECORD
PRIVATE TYPE type_g_gzgo2_d RECORD
       gzgo003 LIKE gzgo_t.gzgo003, 
   gzgoownid LIKE gzgo_t.gzgoownid, 
   gzgoownid_desc LIKE type_t.chr500, 
   gzgoowndp LIKE gzgo_t.gzgoowndp, 
   gzgoowndp_desc LIKE type_t.chr500, 
   gzgocrtid LIKE gzgo_t.gzgocrtid, 
   gzgocrtid_desc LIKE type_t.chr500, 
   gzgocrtdp LIKE gzgo_t.gzgocrtdp, 
   gzgocrtdp_desc LIKE type_t.chr500, 
   gzgocrtdt DATETIME YEAR TO SECOND, 
   gzgomodid LIKE gzgo_t.gzgomodid, 
   gzgomodid_desc LIKE type_t.chr500, 
   gzgomoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_gzgo_m          type_g_gzgo_m
DEFINE g_gzgo_m_t        type_g_gzgo_m
DEFINE g_gzgo_m_o        type_g_gzgo_m
DEFINE g_gzgo_m_mask_o   type_g_gzgo_m #轉換遮罩前資料
DEFINE g_gzgo_m_mask_n   type_g_gzgo_m #轉換遮罩後資料
 
   DEFINE g_gzgo001_t LIKE gzgo_t.gzgo001
DEFINE g_gzgo002_t LIKE gzgo_t.gzgo002
 
 
DEFINE g_gzgo_d          DYNAMIC ARRAY OF type_g_gzgo_d
DEFINE g_gzgo_d_t        type_g_gzgo_d
DEFINE g_gzgo_d_o        type_g_gzgo_d
DEFINE g_gzgo_d_mask_o   DYNAMIC ARRAY OF type_g_gzgo_d #轉換遮罩前資料
DEFINE g_gzgo_d_mask_n   DYNAMIC ARRAY OF type_g_gzgo_d #轉換遮罩後資料
DEFINE g_gzgo2_d   DYNAMIC ARRAY OF type_g_gzgo2_d
DEFINE g_gzgo2_d_t type_g_gzgo2_d
DEFINE g_gzgo2_d_o type_g_gzgo2_d
DEFINE g_gzgo2_d_mask_o   DYNAMIC ARRAY OF type_g_gzgo2_d #轉換遮罩前資料
DEFINE g_gzgo2_d_mask_n   DYNAMIC ARRAY OF type_g_gzgo2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_gzgo001 LIKE gzgo_t.gzgo001,
      b_gzgo002 LIKE gzgo_t.gzgo002
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
 
{<section id="azzi340.main" >}
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
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT gzgo001,'',gzgo002,''", 
                      " FROM gzgo_t",
                      " WHERE gzgoent= ? AND gzgo001=? AND gzgo002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi340_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.gzgo001,t0.gzgo002",
               " FROM gzgo_t t0",
               
               " WHERE t0.gzgoent = " ||g_enterprise|| " AND t0.gzgo001 = ? AND t0.gzgo002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE azzi340_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi340 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzi340_init()   
 
      #進入選單 Menu (="N")
      CALL azzi340_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzi340
      
   END IF 
   
   CLOSE azzi340_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="azzi340.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzi340_init()
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
   
   #end add-point
   
   CALL azzi340_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="azzi340.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION azzi340_ui_dialog()
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
   
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_gzgo_m.* TO NULL
         CALL g_gzgo_d.clear()
         CALL g_gzgo2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL azzi340_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_gzgo_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL azzi340_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL azzi340_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_gzgo2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL azzi340_idx_chk()
               CALL azzi340_ui_detailshow()
               
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
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL azzi340_browser_fill("")
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
               CALL azzi340_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL azzi340_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL azzi340_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi340_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL azzi340_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi340_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL azzi340_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi340_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL azzi340_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi340_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL azzi340_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi340_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_gzgo_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_gzgo2_d)
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
               NEXT FIELD gzgo003
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
               CALL azzi340_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL azzi340_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL azzi340_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzi340_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL azzi340_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi340_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi340_insert()
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
               CALL azzi340_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi340_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL azzi340_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi340_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi340_set_pk_array()
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
 
{<section id="azzi340.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION azzi340_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi340.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION azzi340_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "gzgo001,gzgo002"
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
      LET l_sub_sql = " SELECT DISTINCT gzgo001 ",
                      ", gzgo002 ",
 
                      " FROM gzgo_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE gzgoent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gzgo_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gzgo001 ",
                      ", gzgo002 ",
 
                      " FROM gzgo_t ",
                      " ",
                      " ", 
 
 
                      " WHERE gzgoent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("gzgo_t")
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
      INITIALIZE g_gzgo_m.* TO NULL
      CALL g_gzgo_d.clear()        
      CALL g_gzgo2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.gzgo001,t0.gzgo002 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.gzgo001,t0.gzgo002",
                " FROM gzgo_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.gzgoent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("gzgo_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzgo_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_gzgo001,g_browser[g_cnt].b_gzgo002 
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
   
   IF cl_null(g_browser[g_cnt].b_gzgo001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_gzgo_m.* TO NULL
      CALL g_gzgo_d.clear()
      CALL g_gzgo2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL azzi340_fetch('')
   
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
 
{<section id="azzi340.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION azzi340_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_gzgo_m.gzgo001 = g_browser[g_current_idx].b_gzgo001   
   LET g_gzgo_m.gzgo002 = g_browser[g_current_idx].b_gzgo002   
 
   EXECUTE azzi340_master_referesh USING g_gzgo_m.gzgo001,g_gzgo_m.gzgo002 INTO g_gzgo_m.gzgo001,g_gzgo_m.gzgo002 
 
   CALL azzi340_show()
   
END FUNCTION
 
{</section>}
 
{<section id="azzi340.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION azzi340_ui_detailshow()
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
 
{<section id="azzi340.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION azzi340_ui_browser_refresh()
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
      IF g_browser[l_i].b_gzgo001 = g_gzgo_m.gzgo001 
         AND g_browser[l_i].b_gzgo002 = g_gzgo_m.gzgo002 
 
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
 
{<section id="azzi340.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi340_construct()
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
   INITIALIZE g_gzgo_m.* TO NULL
   CALL g_gzgo_d.clear()
   CALL g_gzgo2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON gzgo001,gzgo001_desc,gzgo002,gzgo002_desc
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgo001
            #add-point:BEFORE FIELD gzgo001 name="construct.b.gzgo001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgo001
            
            #add-point:AFTER FIELD gzgo001 name="construct.a.gzgo001"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzgo001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgo001
            #add-point:ON ACTION controlp INFIELD gzgo001 name="construct.c.gzgo001"
            ### 用戶查詢### start ###
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gzgo_m.gzgo001
            LET g_qryparam.arg1 = ""
            CALL q_gzxa003_2()
            LET g_gzgo_m.gzgo001 = g_qryparam.return1              
            DISPLAY g_gzgo_m.gzgo001 TO gzgo001
            NEXT FIELD gzgo001
            ### 用戶查詢### end ###
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgo001_desc
            #add-point:BEFORE FIELD gzgo001_desc name="construct.b.gzgo001_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgo001_desc
            
            #add-point:AFTER FIELD gzgo001_desc name="construct.a.gzgo001_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzgo001_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgo001_desc
            #add-point:ON ACTION controlp INFIELD gzgo001_desc name="construct.c.gzgo001_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgo002
            #add-point:BEFORE FIELD gzgo002 name="construct.b.gzgo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgo002
            
            #add-point:AFTER FIELD gzgo002 name="construct.a.gzgo002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzgo002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgo002
            #add-point:ON ACTION controlp INFIELD gzgo002 name="construct.c.gzgo002"
            ### 角色查詢### start ### 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gzgo_m.gzgo002
            LET g_qryparam.arg1 = ""
            CALL q_gzya001()
            LET g_gzgo_m.gzgo002 = g_qryparam.return1
            DISPLAY g_gzgo_m.gzgo002 TO gzgo002
            NEXT FIELD gzgo002
            ### 角色查詢### end ###
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgo002_desc
            #add-point:BEFORE FIELD gzgo002_desc name="construct.b.gzgo002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgo002_desc
            
            #add-point:AFTER FIELD gzgo002_desc name="construct.a.gzgo002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzgo002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgo002_desc
            #add-point:ON ACTION controlp INFIELD gzgo002_desc name="construct.c.gzgo002_desc"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON gzgostus,gzgo003,gzgo004,gzgoownid,gzgoowndp,gzgocrtid,gzgocrtdp,gzgocrtdt, 
          gzgomodid,gzgomoddt
           FROM s_detail1[1].gzgostus,s_detail1[1].gzgo003,s_detail1[1].gzgo004,s_detail2[1].gzgoownid, 
               s_detail2[1].gzgoowndp,s_detail2[1].gzgocrtid,s_detail2[1].gzgocrtdp,s_detail2[1].gzgocrtdt, 
               s_detail2[1].gzgomodid,s_detail2[1].gzgomoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gzgocrtdt>>----
         AFTER FIELD gzgocrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gzgomoddt>>----
         AFTER FIELD gzgomoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzgocnfdt>>----
         
         #----<<gzgopstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgostus
            #add-point:BEFORE FIELD gzgostus name="construct.b.page1.gzgostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgostus
            
            #add-point:AFTER FIELD gzgostus name="construct.a.page1.gzgostus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzgostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgostus
            #add-point:ON ACTION controlp INFIELD gzgostus name="construct.c.page1.gzgostus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgo003
            #add-point:BEFORE FIELD gzgo003 name="construct.b.page1.gzgo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgo003
            
            #add-point:AFTER FIELD gzgo003 name="construct.a.page1.gzgo003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzgo003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgo003
            #add-point:ON ACTION controlp INFIELD gzgo003 name="construct.c.page1.gzgo003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.arg1 = ""
            CALL q_gzzz001_8()
            LET g_gzgo_d[l_ac].gzgo003 = g_qryparam.return1
            DISPLAY g_gzgo_d[l_ac].gzgo003 TO gzgo003
            LET g_gzgo_d[l_ac].gzgo003_desc = g_qryparam.return2
            DISPLAY g_gzgo_d[l_ac].gzgo003_desc TO gzgo003_desc
            NEXT FIELD gzgo003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgo004
            #add-point:BEFORE FIELD gzgo004 name="construct.b.page1.gzgo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgo004
            
            #add-point:AFTER FIELD gzgo004 name="construct.a.page1.gzgo004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzgo004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgo004
            #add-point:ON ACTION controlp INFIELD gzgo004 name="construct.c.page1.gzgo004"
            CALL azzi340_s01()
            DISPLAY BY NAME g_gzgo_d[l_ac].gzgo004
            NEXT FIELD CURRENT
            #END add-point
 
 
         #Ctrlp:construct.c.page2.gzgoownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgoownid
            #add-point:ON ACTION controlp INFIELD gzgoownid name="construct.c.page2.gzgoownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzgoownid  #顯示到畫面上
            NEXT FIELD gzgoownid                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgoownid
            #add-point:BEFORE FIELD gzgoownid name="construct.b.page2.gzgoownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgoownid
            
            #add-point:AFTER FIELD gzgoownid name="construct.a.page2.gzgoownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzgoowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgoowndp
            #add-point:ON ACTION controlp INFIELD gzgoowndp name="construct.c.page2.gzgoowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzgoowndp  #顯示到畫面上
            NEXT FIELD gzgoowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgoowndp
            #add-point:BEFORE FIELD gzgoowndp name="construct.b.page2.gzgoowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgoowndp
            
            #add-point:AFTER FIELD gzgoowndp name="construct.a.page2.gzgoowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzgocrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgocrtid
            #add-point:ON ACTION controlp INFIELD gzgocrtid name="construct.c.page2.gzgocrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzgocrtid  #顯示到畫面上
            NEXT FIELD gzgocrtid                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgocrtid
            #add-point:BEFORE FIELD gzgocrtid name="construct.b.page2.gzgocrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgocrtid
            
            #add-point:AFTER FIELD gzgocrtid name="construct.a.page2.gzgocrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzgocrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgocrtdp
            #add-point:ON ACTION controlp INFIELD gzgocrtdp name="construct.c.page2.gzgocrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzgocrtdp  #顯示到畫面上
            NEXT FIELD gzgocrtdp                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgocrtdp
            #add-point:BEFORE FIELD gzgocrtdp name="construct.b.page2.gzgocrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgocrtdp
            
            #add-point:AFTER FIELD gzgocrtdp name="construct.a.page2.gzgocrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgocrtdt
            #add-point:BEFORE FIELD gzgocrtdt name="construct.b.page2.gzgocrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.gzgomodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgomodid
            #add-point:ON ACTION controlp INFIELD gzgomodid name="construct.c.page2.gzgomodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzgomodid  #顯示到畫面上
            NEXT FIELD gzgomodid                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgomodid
            #add-point:BEFORE FIELD gzgomodid name="construct.b.page2.gzgomodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgomodid
            
            #add-point:AFTER FIELD gzgomodid name="construct.a.page2.gzgomodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgomoddt
            #add-point:BEFORE FIELD gzgomoddt name="construct.b.page2.gzgomoddt"
            
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
 
{<section id="azzi340.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION azzi340_query()
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
   CALL g_gzgo_d.clear()
   CALL g_gzgo2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL azzi340_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL azzi340_browser_fill(g_wc)
      CALL azzi340_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL azzi340_browser_fill("F")
   
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
      CALL azzi340_fetch("F") 
   END IF
   
   CALL azzi340_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="azzi340.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION azzi340_fetch(p_flag)
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
   
   #CALL azzi340_browser_fill(p_flag)
   
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
   
   LET g_gzgo_m.gzgo001 = g_browser[g_current_idx].b_gzgo001
   LET g_gzgo_m.gzgo002 = g_browser[g_current_idx].b_gzgo002
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE azzi340_master_referesh USING g_gzgo_m.gzgo001,g_gzgo_m.gzgo002 INTO g_gzgo_m.gzgo001,g_gzgo_m.gzgo002 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzgo_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_gzgo_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_gzgo_m_mask_o.* =  g_gzgo_m.*
   CALL azzi340_gzgo_t_mask()
   LET g_gzgo_m_mask_n.* =  g_gzgo_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi340_set_act_visible()
   CALL azzi340_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_gzgo_m_t.* = g_gzgo_m.*
   LET g_gzgo_m_o.* = g_gzgo_m.*
   
   #重新顯示   
   CALL azzi340_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="azzi340.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi340_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_gzgo_d.clear()
   CALL g_gzgo2_d.clear()
 
 
   INITIALIZE g_gzgo_m.* TO NULL             #DEFAULT 設定
   LET g_gzgo001_t = NULL
   LET g_gzgo002_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL azzi340_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_gzgo_m.* TO NULL
         INITIALIZE g_gzgo_d TO NULL
         INITIALIZE g_gzgo2_d TO NULL
 
         CALL azzi340_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_gzgo_m.* = g_gzgo_m_t.*
         CALL azzi340_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_gzgo_d.clear()
      #CALL g_gzgo2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi340_set_act_visible()
   CALL azzi340_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzgo001_t = g_gzgo_m.gzgo001
   LET g_gzgo002_t = g_gzgo_m.gzgo002
 
   
   #組合新增資料的條件
   LET g_add_browse = " gzgoent = " ||g_enterprise|| " AND",
                      " gzgo001 = '", g_gzgo_m.gzgo001, "' "
                      ," AND gzgo002 = '", g_gzgo_m.gzgo002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi340_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL azzi340_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE azzi340_master_referesh USING g_gzgo_m.gzgo001,g_gzgo_m.gzgo002 INTO g_gzgo_m.gzgo001,g_gzgo_m.gzgo002 
 
   
   #遮罩相關處理
   LET g_gzgo_m_mask_o.* =  g_gzgo_m.*
   CALL azzi340_gzgo_t_mask()
   LET g_gzgo_m_mask_n.* =  g_gzgo_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzgo_m.gzgo001,g_gzgo_m.gzgo001_desc,g_gzgo_m.gzgo002,g_gzgo_m.gzgo002_desc
   
   #功能已完成,通報訊息中心
   CALL azzi340_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi340.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi340_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_gzgo_m.gzgo001 IS NULL
   OR g_gzgo_m.gzgo002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_gzgo001_t = g_gzgo_m.gzgo001
   LET g_gzgo002_t = g_gzgo_m.gzgo002
 
   CALL s_transaction_begin()
   
   OPEN azzi340_cl USING g_enterprise,g_gzgo_m.gzgo001,g_gzgo_m.gzgo002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi340_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE azzi340_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi340_master_referesh USING g_gzgo_m.gzgo001,g_gzgo_m.gzgo002 INTO g_gzgo_m.gzgo001,g_gzgo_m.gzgo002 
 
   
   #遮罩相關處理
   LET g_gzgo_m_mask_o.* =  g_gzgo_m.*
   CALL azzi340_gzgo_t_mask()
   LET g_gzgo_m_mask_n.* =  g_gzgo_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL azzi340_show()
   WHILE TRUE
      LET g_gzgo001_t = g_gzgo_m.gzgo001
      LET g_gzgo002_t = g_gzgo_m.gzgo002
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL azzi340_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_gzgo_m.* = g_gzgo_m_t.*
         CALL azzi340_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_gzgo_m.gzgo001 != g_gzgo001_t 
      OR g_gzgo_m.gzgo002 != g_gzgo002_t 
 
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
   CALL azzi340_set_act_visible()
   CALL azzi340_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " gzgoent = " ||g_enterprise|| " AND",
                      " gzgo001 = '", g_gzgo_m.gzgo001, "' "
                      ," AND gzgo002 = '", g_gzgo_m.gzgo002, "' "
 
   #填到對應位置
   CALL azzi340_browser_fill("")
 
   CALL azzi340_idx_chk()
 
   CLOSE azzi340_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL azzi340_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="azzi340.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzi340_input(p_cmd)
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
   DEFINE  l_cnt2                LIKE type_t.num5  #檢查資料是否存在用
   DEFINE  l_prt                 LIKE type_t.chr1
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
   DISPLAY BY NAME g_gzgo_m.gzgo001,g_gzgo_m.gzgo001_desc,g_gzgo_m.gzgo002,g_gzgo_m.gzgo002_desc
   
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
   LET g_forupd_sql = "SELECT gzgostus,gzgo003,gzgo004,gzgo003,gzgoownid,gzgoowndp,gzgocrtid,gzgocrtdp, 
       gzgocrtdt,gzgomodid,gzgomoddt FROM gzgo_t WHERE gzgoent=? AND gzgo001=? AND gzgo002=? AND gzgo003=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi340_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL azzi340_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL azzi340_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   IF p_cmd = 'a' THEN
      LET g_gzgo_m.gzgo001 = 'default'
      LET g_gzgo_m.gzgo002 = 'default'
   END IF
   #end add-point
 
   DISPLAY BY NAME g_gzgo_m.gzgo001,g_gzgo_m.gzgo002
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   CALL azzi340_get_desc("gzgo001")
   CALL azzi340_get_desc("gzgo002")
#   DISPLAY BY NAME g_gzgo_m.gzgo001_desc,g_gzgo_m.gzgo002_desc
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="azzi340.input.head" >}
   
      #單頭段
      INPUT BY NAME g_gzgo_m.gzgo001,g_gzgo_m.gzgo002 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            IF p_cmd = 'u' THEN
               IF g_gzgo_m.gzgo001 = 'default' THEN
                  IF g_gzgo_m.gzgo002 <> 'default' THEN
                     CALL cl_set_comp_entry("gzgo002",TRUE)
                     CALL cl_set_comp_entry("gzgo001",FALSE)
                  ELSE
                     CALL cl_set_comp_entry("gzgo002",TRUE)
                     CALL cl_set_comp_entry("gzgo001",TRUE)
                  END IF
               ELSE
                  IF g_gzgo_m.gzgo002 = 'default' THEN
                     CALL cl_set_comp_entry("gzgo001",TRUE)
                     CALL cl_set_comp_entry("gzgo002",FALSE)
                  END IF
               END IF
            END IF
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgo001
            
            #add-point:AFTER FIELD gzgo001 name="input.a.gzgo001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
#            IF  NOT cl_null(g_gzgo_m.gzgo001) AND NOT cl_null(g_gzgo_m.gzgo002) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzgo_m.gzgo001 != g_gzgo001_t  OR g_gzgo_m.gzgo002 != g_gzgo002_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzgo_t WHERE "||"gzgoent = '" ||g_enterprise|| "' AND "||"gzgo001 = '"||g_gzgo_m.gzgo001 ||"' AND "|| "gzgo002 = '"||g_gzgo_m.gzgo002 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF

            #確認用戶存在
            IF NOT cl_null(g_gzgo_m.gzgo001) THEN
               IF g_gzgo_m.gzgo001 <> 'default' THEN
                  SELECT COUNT(*) INTO g_cnt FROM gzxa_t WHERE gzxa003 = g_gzgo_m.gzgo001 AND gzxastus = 'Y'
                  
                  IF g_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'azz-00688'
                     LET g_errparam.extend = g_gzgo_m.gzgo001
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD gzgo001
                  END IF
               END IF
            END IF

            IF g_gzgo_m.gzgo001 = 'default' THEN
               IF g_gzgo_m.gzgo002 <> 'default' THEN
                  CALL cl_set_comp_entry("gzgo002",TRUE)
                  CALL cl_set_comp_entry("gzgo001",FALSE)
               ELSE
                  CALL cl_set_comp_entry("gzgo002",TRUE)
                  CALL cl_set_comp_entry("gzgo001",TRUE)
               END IF
            ELSE
               IF g_gzgo_m.gzgo002 = 'default' THEN
                  CALL cl_set_comp_entry("gzgo001",TRUE)
                  CALL cl_set_comp_entry("gzgo002",FALSE)
               END IF
            END IF
            
            CALL azzi340_get_desc("gzgo001")
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgo001
            #add-point:BEFORE FIELD gzgo001 name="input.b.gzgo001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzgo001
            #add-point:ON CHANGE gzgo001 name="input.g.gzgo001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgo002
            
            #add-point:AFTER FIELD gzgo002 name="input.a.gzgo002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
#            IF  NOT cl_null(g_gzgo_m.gzgo001) AND NOT cl_null(g_gzgo_m.gzgo002) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzgo_m.gzgo001 != g_gzgo001_t  OR g_gzgo_m.gzgo002 != g_gzgo002_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzgo_t WHERE "||"gzgoent = '" ||g_enterprise|| "' AND "||"gzgo001 = '"||g_gzgo_m.gzgo001 ||"' AND "|| "gzgo002 = '"||g_gzgo_m.gzgo002 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF

            #確認角色存在
            IF g_gzgo_m.gzgo002 CLIPPED  <> 'default' THEN
               SELECT COUNT(*) INTO g_cnt FROM gzya_t
               WHERE gzya001 = g_gzgo_m.gzgo002
               AND gzyastus = 'Y'
               
               IF g_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'azz-00689'
                  LET g_errparam.extend =  g_gzgo_m.gzgo002
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD gzgo002
               END IF
            END IF

            IF g_gzgo_m.gzgo002 = 'default' THEN
               IF g_gzgo_m.gzgo001 <> 'default' THEN
                  CALL cl_set_comp_entry("gzgo001",TRUE)
                  CALL cl_set_comp_entry("gzgo002",FALSE)
               ELSE
                  CALL cl_set_comp_entry("gzgo002",TRUE)
                  CALL cl_set_comp_entry("gzgo001",TRUE)
               END IF
            ELSE
               IF g_gzgo_m.gzgo001 = 'default' THEN
                  CALL cl_set_comp_entry("gzgo002",TRUE)
                  CALL cl_set_comp_entry("gzgo001",FALSE)
               END IF
            END IF

            CALL azzi340_get_desc("gzgo002")
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgo002
            #add-point:BEFORE FIELD gzgo002 name="input.b.gzgo002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzgo002
            #add-point:ON CHANGE gzgo002 name="input.g.gzgo002"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gzgo001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgo001
            #add-point:ON ACTION controlp INFIELD gzgo001 name="input.c.gzgo001"
            ### 用戶查詢### start ###
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gzgo_m.gzgo001
            LET g_qryparam.arg1 = ""
            CALL q_gzxa003_2()
            LET g_gzgo_m.gzgo001 = g_qryparam.return1              
            DISPLAY g_gzgo_m.gzgo001 TO gzgo001
            NEXT FIELD gzgo001
            ### 用戶查詢### end ###
            #END add-point
 
 
         #Ctrlp:input.c.gzgo002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgo002
            #add-point:ON ACTION controlp INFIELD gzgo002 name="input.c.gzgo002"
            ### 角色查詢### start ### 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gzgo_m.gzgo002
            LET g_qryparam.arg1 = ""
            CALL q_gzya001()
            LET g_gzgo_m.gzgo002 = g_qryparam.return1
            DISPLAY g_gzgo_m.gzgo002 TO gzgo002
            NEXT FIELD gzgo002
            ### 角色查詢### end ###
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
            DISPLAY BY NAME g_gzgo_m.gzgo001             
                            ,g_gzgo_m.gzgo002   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               #確認資料無重複
               IF  NOT cl_null(g_gzgo_m.gzgo001) AND NOT cl_null(g_gzgo_m.gzgo002) THEN 
                  IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzgo_m.gzgo001 != g_gzgo001_t  OR g_gzgo_m.gzgo002 != g_gzgo002_t )) THEN 
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzgo_t WHERE "||"gzgoent = '" ||g_enterprise|| "' AND "||"gzgo001 = '"||g_gzgo_m.gzgo001 ||"' AND "|| "gzgo002 = '"||g_gzgo_m.gzgo002 ||"'",'std-00004',0) THEN 
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               #end add-point
            
               #將遮罩欄位還原
               CALL azzi340_gzgo_t_mask_restore('restore_mask_o')
            
               UPDATE gzgo_t SET (gzgo001,gzgo002) = (g_gzgo_m.gzgo001,g_gzgo_m.gzgo002)
                WHERE gzgoent = g_enterprise AND gzgo001 = g_gzgo001_t
                  AND gzgo002 = g_gzgo002_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzgo_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzgo_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzgo_m.gzgo001
               LET gs_keys_bak[1] = g_gzgo001_t
               LET gs_keys[2] = g_gzgo_m.gzgo002
               LET gs_keys_bak[2] = g_gzgo002_t
               LET gs_keys[3] = g_gzgo_d[g_detail_idx].gzgo003
               LET gs_keys_bak[3] = g_gzgo_d_t.gzgo003
               CALL azzi340_update_b('gzgo_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_gzgo_m_t)
                     #LET g_log2 = util.JSON.stringify(g_gzgo_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL azzi340_gzgo_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               #確認資料無重複
               IF  NOT cl_null(g_gzgo_m.gzgo001) AND NOT cl_null(g_gzgo_m.gzgo002) THEN 
                  IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzgo_m.gzgo001 != g_gzgo001_t  OR g_gzgo_m.gzgo002 != g_gzgo002_t )) THEN 
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzgo_t WHERE "||"gzgoent = '" ||g_enterprise|| "' AND "||"gzgo001 = '"||g_gzgo_m.gzgo001 ||"' AND "|| "gzgo002 = '"||g_gzgo_m.gzgo002 ||"'",'std-00004',0) THEN 
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL azzi340_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_gzgo001_t = g_gzgo_m.gzgo001
           LET g_gzgo002_t = g_gzgo_m.gzgo002
 
           
           IF g_gzgo_d.getLength() = 0 THEN
              NEXT FIELD gzgo003
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="azzi340.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_gzgo_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzgo_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi340_b_fill(g_wc2) #test 
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
            CALL azzi340_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN azzi340_cl USING g_enterprise,g_gzgo_m.gzgo001,g_gzgo_m.gzgo002                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE azzi340_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN azzi340_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_gzgo_d[l_ac].gzgo003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzgo_d_t.* = g_gzgo_d[l_ac].*  #BACKUP
               LET g_gzgo_d_o.* = g_gzgo_d[l_ac].*  #BACKUP
               CALL azzi340_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL azzi340_set_no_entry_b(l_cmd)
               OPEN azzi340_bcl USING g_enterprise,g_gzgo_m.gzgo001,
                                                g_gzgo_m.gzgo002,
 
                                                g_gzgo_d_t.gzgo003
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN azzi340_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi340_bcl INTO g_gzgo_d[l_ac].gzgostus,g_gzgo_d[l_ac].gzgo003,g_gzgo_d[l_ac].gzgo004, 
                      g_gzgo2_d[l_ac].gzgo003,g_gzgo2_d[l_ac].gzgoownid,g_gzgo2_d[l_ac].gzgoowndp,g_gzgo2_d[l_ac].gzgocrtid, 
                      g_gzgo2_d[l_ac].gzgocrtdp,g_gzgo2_d[l_ac].gzgocrtdt,g_gzgo2_d[l_ac].gzgomodid, 
                      g_gzgo2_d[l_ac].gzgomoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_gzgo_d_t.gzgo003,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzgo_d_mask_o[l_ac].* =  g_gzgo_d[l_ac].*
                  CALL azzi340_gzgo_t_mask()
                  LET g_gzgo_d_mask_n[l_ac].* =  g_gzgo_d[l_ac].*
                  
                  CALL azzi340_ref_show()
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
            INITIALIZE g_gzgo_d_t.* TO NULL
            INITIALIZE g_gzgo_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzgo_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gzgo2_d[l_ac].gzgoownid = g_user
      LET g_gzgo2_d[l_ac].gzgoowndp = g_dept
      LET g_gzgo2_d[l_ac].gzgocrtid = g_user
      LET g_gzgo2_d[l_ac].gzgocrtdp = g_dept 
      LET g_gzgo2_d[l_ac].gzgocrtdt = cl_get_current()
      LET g_gzgo2_d[l_ac].gzgomodid = g_user
      LET g_gzgo2_d[l_ac].gzgomoddt = cl_get_current()
      LET g_gzgo_d[l_ac].gzgostus = ''
 
 
  
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_gzgo_d_t.* = g_gzgo_d[l_ac].*     #新輸入資料
            LET g_gzgo_d_o.* = g_gzgo_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi340_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL azzi340_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzgo_d[li_reproduce_target].* = g_gzgo_d[li_reproduce].*
               LET g_gzgo2_d[li_reproduce_target].* = g_gzgo2_d[li_reproduce].*
 
               LET g_gzgo_d[g_gzgo_d.getLength()].gzgo003 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_gzgo_d[g_detail_idx].gzgostus = 'Y'
            LET g_gzgo_d[g_detail_idx].gzgo004 = NULL
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
            SELECT COUNT(1) INTO l_count FROM gzgo_t 
             WHERE gzgoent = g_enterprise AND gzgo001 = g_gzgo_m.gzgo001
               AND gzgo002 = g_gzgo_m.gzgo002
 
               AND gzgo003 = g_gzgo_d[l_ac].gzgo003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO gzgo_t
                           (gzgoent,
                            gzgo001,gzgo002,
                            gzgo003
                            ,gzgostus,gzgo004,gzgoownid,gzgoowndp,gzgocrtid,gzgocrtdp,gzgocrtdt,gzgomodid,gzgomoddt) 
                     VALUES(g_enterprise,
                            g_gzgo_m.gzgo001,g_gzgo_m.gzgo002,
                            g_gzgo_d[l_ac].gzgo003
                            ,g_gzgo_d[l_ac].gzgostus,g_gzgo_d[l_ac].gzgo004,g_gzgo2_d[l_ac].gzgoownid, 
                                g_gzgo2_d[l_ac].gzgoowndp,g_gzgo2_d[l_ac].gzgocrtid,g_gzgo2_d[l_ac].gzgocrtdp, 
                                g_gzgo2_d[l_ac].gzgocrtdt,g_gzgo2_d[l_ac].gzgomodid,g_gzgo2_d[l_ac].gzgomoddt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_gzgo_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gzgo_t:",SQLERRMESSAGE 
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
               IF azzi340_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_gzgo_m.gzgo001
                  LET gs_keys[gs_keys.getLength()+1] = g_gzgo_m.gzgo002
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gzgo_d_t.gzgo003
 
 
                  #刪除下層單身
                  IF NOT azzi340_key_delete_b(gs_keys,'gzgo_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE azzi340_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE azzi340_bcl
               LET l_count = g_gzgo_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_gzgo_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgostus
            #add-point:BEFORE FIELD gzgostus name="input.b.page1.gzgostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgostus
            
            #add-point:AFTER FIELD gzgostus name="input.a.page1.gzgostus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzgostus
            #add-point:ON CHANGE gzgostus name="input.g.page1.gzgostus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgo003
            
            #add-point:AFTER FIELD gzgo003 name="input.a.page1.gzgo003"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gzgo_m.gzgo001 IS NOT NULL AND g_gzgo_m.gzgo002 IS NOT NULL AND g_gzgo_d[g_detail_idx].gzgo003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzgo_m.gzgo001 != g_gzgo001_t OR g_gzgo_m.gzgo002 != g_gzgo002_t OR g_gzgo_d[g_detail_idx].gzgo003 != g_gzgo_d_t.gzgo003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzgo_t WHERE "||"gzgoent = '" ||g_enterprise|| "' AND "||"gzgo001 = '"||g_gzgo_m.gzgo001 ||"' AND "|| "gzgo002 = '"||g_gzgo_m.gzgo002 ||"' AND "|| "gzgo003 = '"||g_gzgo_d[g_detail_idx].gzgo003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #檢查作業編號是否有效
            IF g_gzgo_d[l_ac].gzgo003 IS NOT NULL THEN
               SELECT COUNT(*) INTO l_cnt2 FROM gzzz_t 
                 LEFT OUTER JOIN gzza_t ON gzzz002 = gzza001 
                WHERE gzzz001 = g_gzgo_d[l_ac].gzgo003 AND gzzzstus='Y'
                  AND gzza002 IN ('R','Q') 
                
               IF l_cnt2 <= 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code   = "azz-00083"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err() 
                  NEXT FIELD CURRENT
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.code   = "azz-00736"
               LET g_errparam.popup  = FALSE
               CALL cl_err() 
               NEXT FIELD CURRENT
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzgo_d[l_ac].gzgo003
            CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_gzgo_d[l_ac].gzgo003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzgo_d[l_ac].gzgo003_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgo003
            #add-point:BEFORE FIELD gzgo003 name="input.b.page1.gzgo003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzgo003
            #add-point:ON CHANGE gzgo003 name="input.g.page1.gzgo003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzgo004
            #add-point:BEFORE FIELD gzgo004 name="input.b.page1.gzgo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzgo004
            
            #add-point:AFTER FIELD gzgo004 name="input.a.page1.gzgo004"
            IF NOT cl_null(g_gzgo_d[l_ac].gzgo004) THEN
               IF g_gzgo_d[l_ac].gzgo004 != g_gzgo_d_t.gzgo004 OR g_gzgo_d_t.gzgo004 IS NULL THEN
                  FOR l_i = 1 TO length(g_gzgo_d[l_ac].gzgo004)
                     LET l_prt = g_gzgo_d[l_ac].gzgo004[l_i,l_i]
                     IF l_prt NOT MATCHES "[DXPICJ]" THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'azz-00921'
                        LET g_errparam.replace[1] = l_prt
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()      
                        NEXT FIELD gzgo004
                     END IF               
                  END FOR
               END IF
            END IF               
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzgo004
            #add-point:ON CHANGE gzgo004 name="input.g.page1.gzgo004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gzgostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgostus
            #add-point:ON ACTION controlp INFIELD gzgostus name="input.c.page1.gzgostus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzgo003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgo003
            #add-point:ON ACTION controlp INFIELD gzgo003 name="input.c.page1.gzgo003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.arg1 = ""
            CALL q_gzzz001_8()
            LET g_gzgo_d[l_ac].gzgo003 = g_qryparam.return1
            DISPLAY g_gzgo_d[l_ac].gzgo003 TO gzgo003
            LET g_gzgo_d[l_ac].gzgo003_desc = g_qryparam.return2
            DISPLAY g_gzgo_d[l_ac].gzgo003_desc TO gzgo003_desc
            NEXT FIELD gzgo003
            #END add-point
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzgo004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzgo004
            #add-point:ON ACTION controlp INFIELD gzgo004 name="input.c.page1.gzgo004"
            CALL azzi340_s01()
            DISPLAY BY NAME g_gzgo_d[l_ac].gzgo004
            NEXT FIELD CURRENT
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gzgo_d[l_ac].* = g_gzgo_d_t.*
               CLOSE azzi340_bcl
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
               LET g_errparam.extend = g_gzgo_d[l_ac].gzgo003 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gzgo_d[l_ac].* = g_gzgo_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_gzgo2_d[l_ac].gzgomodid = g_user 
LET g_gzgo2_d[l_ac].gzgomoddt = cl_get_current()
LET g_gzgo2_d[l_ac].gzgomodid_desc = cl_get_username(g_gzgo2_d[l_ac].gzgomodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL azzi340_gzgo_t_mask_restore('restore_mask_o')
         
               UPDATE gzgo_t SET (gzgo001,gzgo002,gzgostus,gzgo003,gzgo004,gzgoownid,gzgoowndp,gzgocrtid, 
                   gzgocrtdp,gzgocrtdt,gzgomodid,gzgomoddt) = (g_gzgo_m.gzgo001,g_gzgo_m.gzgo002,g_gzgo_d[l_ac].gzgostus, 
                   g_gzgo_d[l_ac].gzgo003,g_gzgo_d[l_ac].gzgo004,g_gzgo2_d[l_ac].gzgoownid,g_gzgo2_d[l_ac].gzgoowndp, 
                   g_gzgo2_d[l_ac].gzgocrtid,g_gzgo2_d[l_ac].gzgocrtdp,g_gzgo2_d[l_ac].gzgocrtdt,g_gzgo2_d[l_ac].gzgomodid, 
                   g_gzgo2_d[l_ac].gzgomoddt)
                WHERE gzgoent = g_enterprise AND gzgo001 = g_gzgo_m.gzgo001 
                 AND gzgo002 = g_gzgo_m.gzgo002 
 
                 AND gzgo003 = g_gzgo_d_t.gzgo003 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzgo_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "gzgo_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzgo_m.gzgo001
               LET gs_keys_bak[1] = g_gzgo001_t
               LET gs_keys[2] = g_gzgo_m.gzgo002
               LET gs_keys_bak[2] = g_gzgo002_t
               LET gs_keys[3] = g_gzgo_d[g_detail_idx].gzgo003
               LET gs_keys_bak[3] = g_gzgo_d_t.gzgo003
               CALL azzi340_update_b('gzgo_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_gzgo_m),util.JSON.stringify(g_gzgo_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzgo_m),util.JSON.stringify(g_gzgo_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL azzi340_gzgo_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_gzgo_m.gzgo001
               LET ls_keys[ls_keys.getLength()+1] = g_gzgo_m.gzgo002
 
               LET ls_keys[ls_keys.getLength()+1] = g_gzgo_d_t.gzgo003
 
               CALL azzi340_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE azzi340_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gzgo_d[l_ac].* = g_gzgo_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE azzi340_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_gzgo_d.getLength() = 0 THEN
               NEXT FIELD gzgo003
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gzgo_d[li_reproduce_target].* = g_gzgo_d[li_reproduce].*
               LET g_gzgo2_d[li_reproduce_target].* = g_gzgo2_d[li_reproduce].*
 
               LET g_gzgo_d[li_reproduce_target].gzgo003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gzgo_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gzgo_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_gzgo2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL azzi340_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL azzi340_idx_chk()
            CALL azzi340_ui_detailshow()
        
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
            NEXT FIELD gzgo001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gzgostus
               WHEN "s_detail2"
                  NEXT FIELD gzgo003_2
 
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
 
{<section id="azzi340.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION azzi340_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   CALL azzi340_get_desc("gzgo001")
   CALL azzi340_get_desc("gzgo002")   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL azzi340_b_fill(g_wc2) #第一階單身填充
      CALL azzi340_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL azzi340_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_gzgo_m.gzgo001,g_gzgo_m.gzgo001_desc,g_gzgo_m.gzgo002,g_gzgo_m.gzgo002_desc
 
   CALL azzi340_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="azzi340.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION azzi340_ref_show()
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
   FOR l_ac = 1 TO g_gzgo_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_gzgo2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="azzi340.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION azzi340_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE gzgo_t.gzgo001 
   DEFINE l_oldno     LIKE gzgo_t.gzgo001 
   DEFINE l_newno02     LIKE gzgo_t.gzgo002 
   DEFINE l_oldno02     LIKE gzgo_t.gzgo002 
 
   DEFINE l_master    RECORD LIKE gzgo_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE gzgo_t.* #此變數樣板目前無使用
 
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
 
   IF g_gzgo_m.gzgo001 IS NULL
      OR g_gzgo_m.gzgo002 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_gzgo001_t = g_gzgo_m.gzgo001
   LET g_gzgo002_t = g_gzgo_m.gzgo002
 
   
   LET g_gzgo_m.gzgo001 = ""
   LET g_gzgo_m.gzgo002 = ""
 
   LET g_master_insert = FALSE
   CALL azzi340_set_entry('a')
   CALL azzi340_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_gzgo_m.gzgo001_desc = ''
   DISPLAY BY NAME g_gzgo_m.gzgo001_desc
   LET g_gzgo_m.gzgo002_desc = ''
   DISPLAY BY NAME g_gzgo_m.gzgo002_desc
 
   
   CALL azzi340_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_gzgo_m.* TO NULL
      INITIALIZE g_gzgo_d TO NULL
      INITIALIZE g_gzgo2_d TO NULL
 
      CALL azzi340_show()
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
   CALL azzi340_set_act_visible()
   CALL azzi340_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzgo001_t = g_gzgo_m.gzgo001
   LET g_gzgo002_t = g_gzgo_m.gzgo002
 
   
   #組合新增資料的條件
   LET g_add_browse = " gzgoent = " ||g_enterprise|| " AND",
                      " gzgo001 = '", g_gzgo_m.gzgo001, "' "
                      ," AND gzgo002 = '", g_gzgo_m.gzgo002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi340_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL azzi340_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL azzi340_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi340.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION azzi340_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gzgo_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE azzi340_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gzgo_t
    WHERE gzgoent = g_enterprise AND gzgo001 = g_gzgo001_t
    AND gzgo002 = g_gzgo002_t
 
       INTO TEMP azzi340_detail
   
   #將key修正為調整後   
   UPDATE azzi340_detail 
      #更新key欄位
      SET gzgo001 = g_gzgo_m.gzgo001
          , gzgo002 = g_gzgo_m.gzgo002
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , gzgoownid = g_user 
       , gzgoowndp = g_dept
       , gzgocrtid = g_user
       , gzgocrtdp = g_dept 
       , gzgocrtdt = ld_date
       , gzgomodid = g_user
       , gzgomoddt = ld_date
      #, gzgostus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO gzgo_t SELECT * FROM azzi340_detail
   
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
   DROP TABLE azzi340_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gzgo001_t = g_gzgo_m.gzgo001
   LET g_gzgo002_t = g_gzgo_m.gzgo002
 
   
   DROP TABLE azzi340_detail
   
END FUNCTION
 
{</section>}
 
{<section id="azzi340.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi340_delete()
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
   
   IF g_gzgo_m.gzgo001 IS NULL
   OR g_gzgo_m.gzgo002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN azzi340_cl USING g_enterprise,g_gzgo_m.gzgo001,g_gzgo_m.gzgo002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi340_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE azzi340_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi340_master_referesh USING g_gzgo_m.gzgo001,g_gzgo_m.gzgo002 INTO g_gzgo_m.gzgo001,g_gzgo_m.gzgo002 
 
   
   #遮罩相關處理
   LET g_gzgo_m_mask_o.* =  g_gzgo_m.*
   CALL azzi340_gzgo_t_mask()
   LET g_gzgo_m_mask_n.* =  g_gzgo_m.*
   
   CALL azzi340_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzi340_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM gzgo_t WHERE gzgoent = g_enterprise AND gzgo001 = g_gzgo_m.gzgo001
                                                               AND gzgo002 = g_gzgo_m.gzgo002
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzgo_t:",SQLERRMESSAGE 
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
      #   CLOSE azzi340_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_gzgo_d.clear() 
      CALL g_gzgo2_d.clear()       
 
     
      CALL azzi340_ui_browser_refresh()  
      #CALL azzi340_ui_headershow()  
      #CALL azzi340_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL azzi340_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL azzi340_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE azzi340_cl
 
   #功能已完成,通報訊息中心
   CALL azzi340_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="azzi340.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi340_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_gzgo_d.clear()
   CALL g_gzgo2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT gzgostus,gzgo003,gzgo004,gzgo003,gzgoownid,gzgoowndp,gzgocrtid,gzgocrtdp, 
       gzgocrtdt,gzgomodid,gzgomoddt,t1.gzzal003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 , 
       t6.ooag011 FROM gzgo_t",   
               "",
               
                              " LEFT JOIN gzzal_t t1 ON t1.gzzal001=gzgo003 AND t1.gzzal002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=gzgoownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=gzgoowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=gzgocrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=gzgocrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=gzgomodid  ",
 
               " WHERE gzgoent= ? AND gzgo001=? AND gzgo002=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("gzgo_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF azzi340_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY gzgo_t.gzgo003"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE azzi340_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR azzi340_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_gzgo_m.gzgo001,g_gzgo_m.gzgo002   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_gzgo_m.gzgo001,g_gzgo_m.gzgo002 INTO g_gzgo_d[l_ac].gzgostus, 
          g_gzgo_d[l_ac].gzgo003,g_gzgo_d[l_ac].gzgo004,g_gzgo2_d[l_ac].gzgo003,g_gzgo2_d[l_ac].gzgoownid, 
          g_gzgo2_d[l_ac].gzgoowndp,g_gzgo2_d[l_ac].gzgocrtid,g_gzgo2_d[l_ac].gzgocrtdp,g_gzgo2_d[l_ac].gzgocrtdt, 
          g_gzgo2_d[l_ac].gzgomodid,g_gzgo2_d[l_ac].gzgomoddt,g_gzgo_d[l_ac].gzgo003_desc,g_gzgo2_d[l_ac].gzgoownid_desc, 
          g_gzgo2_d[l_ac].gzgoowndp_desc,g_gzgo2_d[l_ac].gzgocrtid_desc,g_gzgo2_d[l_ac].gzgocrtdp_desc, 
          g_gzgo2_d[l_ac].gzgomodid_desc   #(ver:49)
                             
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
 
            CALL g_gzgo_d.deleteElement(g_gzgo_d.getLength())
      CALL g_gzgo2_d.deleteElement(g_gzgo2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_gzgo_d.getLength()
      LET g_gzgo_d_mask_o[l_ac].* =  g_gzgo_d[l_ac].*
      CALL azzi340_gzgo_t_mask()
      LET g_gzgo_d_mask_n[l_ac].* =  g_gzgo_d[l_ac].*
   END FOR
   
   LET g_gzgo2_d_mask_o.* =  g_gzgo2_d.*
   FOR l_ac = 1 TO g_gzgo2_d.getLength()
      LET g_gzgo2_d_mask_o[l_ac].* =  g_gzgo2_d[l_ac].*
      CALL azzi340_gzgo_t_mask()
      LET g_gzgo2_d_mask_n[l_ac].* =  g_gzgo2_d[l_ac].*
   END FOR
 
 
   FREE azzi340_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="azzi340.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION azzi340_idx_chk()
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
      IF g_detail_idx > g_gzgo_d.getLength() THEN
         LET g_detail_idx = g_gzgo_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_gzgo_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzgo_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_gzgo2_d.getLength() THEN
         LET g_detail_idx = g_gzgo2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzgo2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzgo2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi340.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzi340_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_gzgo_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="azzi340.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION azzi340_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM gzgo_t
    WHERE gzgoent = g_enterprise AND gzgo001 = g_gzgo_m.gzgo001 AND
                              gzgo002 = g_gzgo_m.gzgo002 AND
 
          gzgo003 = g_gzgo_d_t.gzgo003
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzgo_t:",SQLERRMESSAGE 
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
 
{<section id="azzi340.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi340_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="azzi340.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi340_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="azzi340.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi340_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="azzi340.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION azzi340_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_gzgo_d[l_ac].gzgo003 = g_gzgo_d_t.gzgo003 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi340.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION azzi340_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="azzi340.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi340_lock_b(ps_table,ps_page)
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
   #CALL azzi340_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi340.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi340_unlock_b(ps_table,ps_page)
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
 
{<section id="azzi340.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION azzi340_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gzgo001,gzgo002",TRUE)
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
 
{<section id="azzi340.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION azzi340_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gzgo001,gzgo002",FALSE)
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
 
{<section id="azzi340.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi340_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi340.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi340_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi340.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION azzi340_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi340.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION azzi340_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi340.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION azzi340_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi340.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION azzi340_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi340.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi340_default_search()
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
      LET ls_wc = ls_wc, " gzgo001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " gzgo002 = '", g_argv[02], "' AND "
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
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzi340.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION azzi340_fill_chk(ps_idx)
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
 
{<section id="azzi340.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION azzi340_modify_detail_chk(ps_record)
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
         LET ls_return = "gzgostus"
      WHEN "s_detail2"
         LET ls_return = "gzgo003_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="azzi340.mask_functions" >}
&include "erp/azz/azzi340_mask.4gl"
 
{</section>}
 
{<section id="azzi340.state_change" >}
    
 
{</section>}
 
{<section id="azzi340.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi340_set_pk_array()
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
   LET g_pk_array[1].values = g_gzgo_m.gzgo001
   LET g_pk_array[1].column = 'gzgo001'
   LET g_pk_array[2].values = g_gzgo_m.gzgo002
   LET g_pk_array[2].column = 'gzgo002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi340.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION azzi340_msgcentre_notify(lc_state)
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
   CALL azzi340_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gzgo_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi340.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi340_get_desc(p_field)
# Input parameter: p_field        欄位名稱
#                : p_value        传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/8/4 By Cynthia
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi340_get_desc(p_field)
   DEFINE p_field        STRING
   DEFINE r_field_desc   STRING
   
   CASE p_field
      WHEN "gzgo001"   #用戶
         IF g_gzgo_m.gzgo001 = "default" THEN 
            LET g_gzgo_m.gzgo001_desc = cl_getmsg("azz-00665",g_lang)
         ELSE 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzgo_m.gzgo001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_gzgo_m.gzgo001_desc = '', g_rtn_fields[1] , ''
         END IF
         DISPLAY g_gzgo_m.gzgo001_desc TO gzgo001_desc
        
      WHEN "gzgo002"   #角色
         IF g_gzgo_m.gzgo002 = "default" THEN 
             LET g_gzgo_m.gzgo002_desc = cl_getmsg("azz-00666",g_lang)
         ELSE    
             INITIALIZE g_ref_fields TO NULL
             LET g_ref_fields[1] = g_gzgo_m.gzgo002
             CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
             LET g_gzgo_m.gzgo002_desc = '', g_rtn_fields[1] , ''
         END IF
         DISPLAY g_gzgo_m.gzgo002_desc TO gzgo002_desc


   END CASE   
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/8/6 By Cynthia
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi340_s01()
   DEFINE l_gzgo004_chk     RECORD
          d              LIKE type_t.chr1,
          x              LIKE type_t.chr1,
          p              LIKE type_t.chr1,
          i              LIKE type_t.chr1,
          j              LIKE type_t.chr1,
          c              LIKE type_t.chr1
   END RECORD
   DEFINE l_i            LIKE type_t.num10
   DEFINE l_prt          LIKE type_t.chr1
   DEFINE lwin_curr      ui.Window
   DEFINE lfrm_curr      ui.Form
   DEFINE ls_path        STRING   

   LET l_gzgo004_chk.d = 'N'
   LET l_gzgo004_chk.x = 'N'
   LET l_gzgo004_chk.p = 'N'
   LET l_gzgo004_chk.i = 'N'
   LET l_gzgo004_chk.j = 'N'
   LET l_gzgo004_chk.c = 'N'

   IF NOT cl_null(g_gzgo_d[g_detail_idx].gzgo004) THEN
      FOR l_i = 1 TO length(g_gzgo_d[g_detail_idx].gzgo004)
         LET l_prt = g_gzgo_d[g_detail_idx].gzgo004[l_i,l_i]
         CASE l_prt
            WHEN 'D'   LET l_gzgo004_chk.d = 'Y'
            WHEN 'X'   LET l_gzgo004_chk.x = 'Y'
            WHEN 'P'   LET l_gzgo004_chk.p = 'Y'
            WHEN 'I'   LET l_gzgo004_chk.i = 'Y'
            WHEN 'J'   LET l_gzgo004_chk.j = 'Y'
            WHEN 'C'   LET l_gzgo004_chk.c = 'Y'
         END CASE            
      END FOR
   ELSE   #gzgp004如果是空的,視為不設限
      LET l_gzgo004_chk.d = 'Y'
      LET l_gzgo004_chk.x = 'Y'
      LET l_gzgo004_chk.p = 'Y'
      LET l_gzgo004_chk.i = 'Y'
      LET l_gzgo004_chk.j = 'Y'
      LET l_gzgo004_chk.c = 'Y'   
   END IF
   
   OPEN WINDOW w_azzi340_s01 WITH FORM cl_ap_formpath("azz",'azzi340_s01')
  LET lwin_curr = ui.Window.getCurrent()
  LET lfrm_curr = lwin_curr.getForm()
  LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
  LET ls_path = os.Path.join(ls_path,"toolbar_openwin.4tb")
  CALL lfrm_curr.loadToolBar(ls_path)   
   
   CALL cl_ui_init()
   CALL azzi340_s01_init()   
   
   DISPLAY BY NAME 
      l_gzgo004_chk.d, l_gzgo004_chk.x, l_gzgo004_chk.p,
      l_gzgo004_chk.i,  l_gzgo004_chk.j, l_gzgo004_chk.c
   
   INPUT BY NAME  
      l_gzgo004_chk.d, l_gzgo004_chk.x, l_gzgo004_chk.p,
      l_gzgo004_chk.i,  l_gzgo004_chk.j, l_gzgo004_chk.c
      WITHOUT DEFAULTS ATTRIBUTE (UNBUFFERED)   
      
      #選取全部   
      ON ACTION selectall
         LET l_gzgo004_chk.d = 'Y'
         LET l_gzgo004_chk.x = 'Y'
         LET l_gzgo004_chk.p = 'Y'
         LET l_gzgo004_chk.i = 'Y'
         LET l_gzgo004_chk.j = 'Y'
         LET l_gzgo004_chk.c = 'Y'
    
      #取消選擇全部
      ON ACTION selectnone   
         LET l_gzgo004_chk.d = 'N'
         LET l_gzgo004_chk.x = 'N'
         LET l_gzgo004_chk.p = 'N'
         LET l_gzgo004_chk.i = 'N'
         LET l_gzgo004_chk.j = 'N'
         LET l_gzgo004_chk.c = 'N'
         
      ON CHANGE d
         IF GET_FLDBUF(l) = 'Y' THEN
            LET l_gzgo004_chk.d = 'N'
         END IF
         
      ON CHANGE x
         IF GET_FLDBUF(l) = 'Y' THEN
            LET l_gzgo004_chk.x = 'N'
         END IF
         
      ON CHANGE p
         IF GET_FLDBUF(l) = 'Y' THEN
            LET l_gzgo004_chk.p = 'N'
         END IF
         
      ON CHANGE i
         IF GET_FLDBUF(l) = 'Y' THEN
            LET l_gzgo004_chk.i = 'N'
         END IF
         
         
      ON CHANGE c
         IF GET_FLDBUF(l) = 'Y' THEN
            LET l_gzgo004_chk.c = 'N'
         END IF

      ON CHANGE j
         IF GET_FLDBUF(l) = 'Y' THEN
            LET l_gzgo004_chk.j = 'N'
         END IF

      ON ACTION accept
         LET g_gzgo_d[g_detail_idx].gzgo004 = ''
         IF l_gzgo004_chk.d = 'Y' THEN LET g_gzgo_d[g_detail_idx].gzgo004 = g_gzgo_d[g_detail_idx].gzgo004 CLIPPED,'D' END IF
         IF l_gzgo004_chk.x = 'Y' THEN LET g_gzgo_d[g_detail_idx].gzgo004 = g_gzgo_d[g_detail_idx].gzgo004 CLIPPED,'X' END IF         
         IF l_gzgo004_chk.p = 'Y' THEN LET g_gzgo_d[g_detail_idx].gzgo004 = g_gzgo_d[g_detail_idx].gzgo004 CLIPPED,'P' END IF         
         IF l_gzgo004_chk.i = 'Y' THEN LET g_gzgo_d[g_detail_idx].gzgo004 = g_gzgo_d[g_detail_idx].gzgo004 CLIPPED,'I' END IF         
         IF l_gzgo004_chk.c = 'Y' THEN LET g_gzgo_d[g_detail_idx].gzgo004 = g_gzgo_d[g_detail_idx].gzgo004 CLIPPED,'C' END IF         
         IF l_gzgo004_chk.j = 'Y' THEN LET g_gzgo_d[g_detail_idx].gzgo004 = g_gzgo_d[g_detail_idx].gzgo004 CLIPPED,'J' END IF         
      
         IF cl_null(g_gzgo_d[g_detail_idx].gzgo004) THEN LET g_gzgo_d[g_detail_idx].gzgo004 = 'N' END IF   #無任何匯出權限
         IF g_gzgo_d[g_detail_idx].gzgo004 = 'DXPICJ' THEN LET g_gzgo_d[g_detail_idx].gzgo004 = NULL END IF   #不設限 
         EXIT INPUT
         
      ON ACTION cancel
         EXIT INPUT
         
   END INPUT
   CLOSE WINDOW w_azzi340_s01
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi340_s01_init()

   CALL cl_set_toolbaritem_visible("refresh, reconstruct, selectpageall, selectpagenone, exporttoexcel, cmd", FALSE)  
   LET INT_FLAG = FALSE         #避免被其他函式影響
END FUNCTION

 
{</section>}
 
