#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi760.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-10-27 11:08:03), PR版次:0001(2016-10-31 14:11:31)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgi760
#+ Description: 標準工資設置
#+ Creator....: 07952(2016-10-27 11:08:03)
#+ Modifier...: 07952 -SD/PR- 07952
 
{</section>}
 
{<section id="abgi760.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#Memos
#140306-00006 2016/10/28 By TSD.Chiu
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
PRIVATE type type_g_bggd_m        RECORD
       bggd001 LIKE bggd_t.bggd001, 
   bggd001_desc LIKE type_t.chr80, 
   bggd004 LIKE bggd_t.bggd004, 
   bggd004_desc LIKE type_t.chr80, 
   l_bgaa002 LIKE type_t.chr500, 
   l_bgaa002_desc LIKE type_t.chr80, 
   bggd002 LIKE bggd_t.bggd002, 
   bggd002_desc LIKE type_t.chr80, 
   bggd005 LIKE bggd_t.bggd005, 
   bggd005_desc LIKE type_t.chr80, 
   l_bgaa003 LIKE type_t.chr500, 
   l_bgaa003_desc LIKE type_t.chr80, 
   bggd003 LIKE bggd_t.bggd003, 
   bggd003_desc LIKE type_t.chr80, 
   bggd006 LIKE bggd_t.bggd006
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bggd_d        RECORD
       bggd007 LIKE bggd_t.bggd007, 
   bggd007_desc LIKE type_t.chr500, 
   bggd008 LIKE bggd_t.bggd008, 
   bggd008_desc LIKE type_t.chr500, 
   bggd009 LIKE bggd_t.bggd009, 
   bggd010 LIKE bggd_t.bggd010
       END RECORD
PRIVATE TYPE type_g_bggd2_d RECORD
       bggd007 LIKE bggd_t.bggd007, 
   bggd008 LIKE bggd_t.bggd008, 
   bggdownid LIKE bggd_t.bggdownid, 
   bggdownid_desc LIKE type_t.chr500, 
   bggdowndp LIKE bggd_t.bggdowndp, 
   bggdowndp_desc LIKE type_t.chr500, 
   bggdcrtid LIKE bggd_t.bggdcrtid, 
   bggdcrtid_desc LIKE type_t.chr500, 
   bggdcrtdp LIKE bggd_t.bggdcrtdp, 
   bggdcrtdp_desc LIKE type_t.chr500, 
   bggdcrtdt DATETIME YEAR TO SECOND, 
   bggdmodid LIKE bggd_t.bggdmodid, 
   bggdmodid_desc LIKE type_t.chr500, 
   bggdmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_bggd_m          type_g_bggd_m
DEFINE g_bggd_m_t        type_g_bggd_m
DEFINE g_bggd_m_o        type_g_bggd_m
DEFINE g_bggd_m_mask_o   type_g_bggd_m #轉換遮罩前資料
DEFINE g_bggd_m_mask_n   type_g_bggd_m #轉換遮罩後資料
 
   DEFINE g_bggd001_t LIKE bggd_t.bggd001
DEFINE g_bggd004_t LIKE bggd_t.bggd004
DEFINE g_bggd002_t LIKE bggd_t.bggd002
DEFINE g_bggd005_t LIKE bggd_t.bggd005
DEFINE g_bggd003_t LIKE bggd_t.bggd003
 
 
DEFINE g_bggd_d          DYNAMIC ARRAY OF type_g_bggd_d
DEFINE g_bggd_d_t        type_g_bggd_d
DEFINE g_bggd_d_o        type_g_bggd_d
DEFINE g_bggd_d_mask_o   DYNAMIC ARRAY OF type_g_bggd_d #轉換遮罩前資料
DEFINE g_bggd_d_mask_n   DYNAMIC ARRAY OF type_g_bggd_d #轉換遮罩後資料
DEFINE g_bggd2_d   DYNAMIC ARRAY OF type_g_bggd2_d
DEFINE g_bggd2_d_t type_g_bggd2_d
DEFINE g_bggd2_d_o type_g_bggd2_d
DEFINE g_bggd2_d_mask_o   DYNAMIC ARRAY OF type_g_bggd2_d #轉換遮罩前資料
DEFINE g_bggd2_d_mask_n   DYNAMIC ARRAY OF type_g_bggd2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_bggd001 LIKE bggd_t.bggd001,
      b_bggd002 LIKE bggd_t.bggd002,
   b_bggd002_desc LIKE type_t.chr80,
      b_bggd003 LIKE bggd_t.bggd003,
   b_bggd003_desc LIKE type_t.chr80,
      b_bggd004 LIKE bggd_t.bggd004,
   b_bggd004_desc LIKE type_t.chr80,
      b_bggd005 LIKE bggd_t.bggd005,
   b_bggd005_desc LIKE type_t.chr80
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
 
{<section id="abgi760.main" >}
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
   CALL cl_ap_init("abg","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT bggd001,'',bggd004,'','','',bggd002,'',bggd005,'','','',bggd003,'',bggd006", 
        
                      " FROM bggd_t",
                      " WHERE bggdent= ? AND bggd001=? AND bggd002=? AND bggd003=? AND bggd004=? AND  
                          bggd005=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgi760_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bggd001,t0.bggd004,t0.bggd002,t0.bggd005,t0.bggd003,t0.bggd006,t1.bgaal003 , 
       t4.ooefl003 ,t5.bggal004 ,t7.bggbl004",
               " FROM bggd_t t0",
                              " LEFT JOIN bgaal_t t1 ON t1.bgaalent="||g_enterprise||" AND t1.bgaal001=t0.bggd001 AND t1.bgaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.bggd002 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN bggal_t t5 ON t5.bggalent="||g_enterprise||" AND t5.bggal001='abgi730' AND t5.bggal002=t0.bggd005 AND t5.bggal003='"||g_dlang||"' ",
               " LEFT JOIN bggbl_t t7 ON t7.bggblent="||g_enterprise||" AND t7.bggbl001='0' AND t7.bggbl002=t0.bggd003 AND t7.bggbl003='"||g_dlang||"' ",
 
               " WHERE t0.bggdent = " ||g_enterprise|| " AND t0.bggd001 = ? AND t0.bggd002 = ? AND t0.bggd003 = ? AND t0.bggd004 = ? AND t0.bggd005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgi760_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgi760 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgi760_init()   
 
      #進入選單 Menu (="N")
      CALL abgi760_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgi760
      
   END IF 
   
   CLOSE abgi760_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgi760.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgi760_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('bggd006','8956') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_create_account_center_tmp()
   #end add-point
   
   CALL abgi760_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abgi760.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abgi760_ui_dialog()
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
         INITIALIZE g_bggd_m.* TO NULL
         CALL g_bggd_d.clear()
         CALL g_bggd2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abgi760_init()
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
               CALL abgi760_idx_chk()
               CALL abgi760_fetch('') # reload data
               LET g_detail_idx = 1
               CALL abgi760_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_bggd_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL abgi760_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL abgi760_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_bggd2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL abgi760_idx_chk()
               CALL abgi760_ui_detailshow()
               
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
            CALL abgi760_browser_fill("")
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
               CALL abgi760_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abgi760_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL abgi760_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abgi760_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi760_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abgi760_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi760_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abgi760_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi760_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abgi760_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi760_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abgi760_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi760_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_bggd_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_bggd2_d)
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
               NEXT FIELD bggd007
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
               CALL abgi760_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL abgi760_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL abgi760_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abgi760_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abgi760_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abgi760_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgi760_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgi760_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abgi760_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgi760_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgi760_set_pk_array()
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
 
{<section id="abgi760.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION abgi760_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgi760.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abgi760_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "bggd001,bggd002,bggd003,bggd004,bggd005"
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
      LET l_sub_sql = " SELECT DISTINCT bggd001 ",
                      ", bggd002 ",
                      ", bggd003 ",
                      ", bggd004 ",
                      ", bggd005 ",
 
                      " FROM bggd_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE bggdent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bggd_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bggd001 ",
                      ", bggd002 ",
                      ", bggd003 ",
                      ", bggd004 ",
                      ", bggd005 ",
 
                      " FROM bggd_t ",
                      " ",
                      " ", 
 
 
                      " WHERE bggdent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bggd_t")
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
      INITIALIZE g_bggd_m.* TO NULL
      CALL g_bggd_d.clear()        
      CALL g_bggd2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bggd001,t0.bggd002,t0.bggd003,t0.bggd004,t0.bggd005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.bggd001,t0.bggd002,t0.bggd003,t0.bggd004,t0.bggd005,t1.ooefl003 , 
       t2.bggbl004 ,t4.bggal004",
                " FROM bggd_t t0",
                #" ",
                " ",
 
 
 
                               " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.bggd002 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN bggbl_t t2 ON t2.bggblent="||g_enterprise||" AND t2.bggbl001='0' AND t2.bggbl002=t0.bggd003 AND t2.bggbl003='"||g_dlang||"' ",
               " LEFT JOIN bggal_t t4 ON t4.bggalent="||g_enterprise||" AND t4.bggal001='abgi730' AND t4.bggal002=t0.bggd006 AND t4.bggal003='"||g_dlang||"' ",
 
                " WHERE t0.bggdent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("bggd_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"bggd_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_bggd001,g_browser[g_cnt].b_bggd002,g_browser[g_cnt].b_bggd003, 
          g_browser[g_cnt].b_bggd004,g_browser[g_cnt].b_bggd005,g_browser[g_cnt].b_bggd002_desc,g_browser[g_cnt].b_bggd003_desc, 
          g_browser[g_cnt].b_bggd005_desc 
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
         CALL abgi760_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_bggd001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_bggd_m.* TO NULL
      CALL g_bggd_d.clear()
      CALL g_bggd2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL abgi760_fetch('')
   
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
 
{<section id="abgi760.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abgi760_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bggd_m.bggd001 = g_browser[g_current_idx].b_bggd001   
   LET g_bggd_m.bggd002 = g_browser[g_current_idx].b_bggd002   
   LET g_bggd_m.bggd003 = g_browser[g_current_idx].b_bggd003   
   LET g_bggd_m.bggd004 = g_browser[g_current_idx].b_bggd004   
   LET g_bggd_m.bggd005 = g_browser[g_current_idx].b_bggd005   
 
   EXECUTE abgi760_master_referesh USING g_bggd_m.bggd001,g_bggd_m.bggd002,g_bggd_m.bggd003,g_bggd_m.bggd004, 
       g_bggd_m.bggd005 INTO g_bggd_m.bggd001,g_bggd_m.bggd004,g_bggd_m.bggd002,g_bggd_m.bggd005,g_bggd_m.bggd003, 
       g_bggd_m.bggd006,g_bggd_m.bggd001_desc,g_bggd_m.bggd002_desc,g_bggd_m.bggd005_desc,g_bggd_m.bggd003_desc 
 
   CALL abgi760_show()
   
END FUNCTION
 
{</section>}
 
{<section id="abgi760.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abgi760_ui_detailshow()
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
 
{<section id="abgi760.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abgi760_ui_browser_refresh()
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
      IF g_browser[l_i].b_bggd001 = g_bggd_m.bggd001 
         AND g_browser[l_i].b_bggd002 = g_bggd_m.bggd002 
         AND g_browser[l_i].b_bggd003 = g_bggd_m.bggd003 
         AND g_browser[l_i].b_bggd004 = g_bggd_m.bggd004 
         AND g_browser[l_i].b_bggd005 = g_bggd_m.bggd005 
 
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
 
{<section id="abgi760.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgi760_construct()
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
   INITIALIZE g_bggd_m.* TO NULL
   CALL g_bggd_d.clear()
   CALL g_bggd2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON bggd001,bggd004,bggd002,bggd005,bggd003,bggd006
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.bggd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd001
            #add-point:ON ACTION controlp INFIELD bggd001 name="construct.c.bggd001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggd001  #顯示到畫面上
            NEXT FIELD bggd001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd001
            #add-point:BEFORE FIELD bggd001 name="construct.b.bggd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd001
            
            #add-point:AFTER FIELD bggd001 name="construct.a.bggd001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd004
            #add-point:ON ACTION controlp INFIELD bggd004 name="construct.c.bggd004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3401"
            CALL q_bggb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggd004  #顯示到畫面上
            NEXT FIELD bggd004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd004
            #add-point:BEFORE FIELD bggd004 name="construct.b.bggd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd004
            
            #add-point:AFTER FIELD bggd004 name="construct.a.bggd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd002
            #add-point:ON ACTION controlp INFIELD bggd002 name="construct.c.bggd002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggd002  #顯示到畫面上
            NEXT FIELD bggd002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd002
            #add-point:BEFORE FIELD bggd002 name="construct.b.bggd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd002
            
            #add-point:AFTER FIELD bggd002 name="construct.a.bggd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd005
            #add-point:ON ACTION controlp INFIELD bggd005 name="construct.c.bggd005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "abgi730"
            CALL q_bgga003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggd005  #顯示到畫面上
            NEXT FIELD bggd005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd005
            #add-point:BEFORE FIELD bggd005 name="construct.b.bggd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd005
            
            #add-point:AFTER FIELD bggd005 name="construct.a.bggd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggd003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd003
            #add-point:ON ACTION controlp INFIELD bggd003 name="construct.c.bggd003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bggb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggd003  #顯示到畫面上
            NEXT FIELD bggd003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd003
            #add-point:BEFORE FIELD bggd003 name="construct.b.bggd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd003
            
            #add-point:AFTER FIELD bggd003 name="construct.a.bggd003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd006
            #add-point:BEFORE FIELD bggd006 name="construct.b.bggd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd006
            
            #add-point:AFTER FIELD bggd006 name="construct.a.bggd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd006
            #add-point:ON ACTION controlp INFIELD bggd006 name="construct.c.bggd006"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON bggd007,bggd008,bggd009,bggd010,bggdownid,bggdowndp,bggdcrtid,bggdcrtdp, 
          bggdcrtdt,bggdmodid,bggdmoddt
           FROM s_detail1[1].bggd007,s_detail1[1].bggd008,s_detail1[1].bggd009,s_detail1[1].bggd010, 
               s_detail2[1].bggdownid,s_detail2[1].bggdowndp,s_detail2[1].bggdcrtid,s_detail2[1].bggdcrtdp, 
               s_detail2[1].bggdcrtdt,s_detail2[1].bggdmodid,s_detail2[1].bggdmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bggdcrtdt>>----
         AFTER FIELD bggdcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bggdmoddt>>----
         AFTER FIELD bggdmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bggdcnfdt>>----
         
         #----<<bggdpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #Ctrlp:construct.c.page1.bggd007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd007
            #add-point:ON ACTION controlp INFIELD bggd007 name="construct.c.page1.bggd007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "abgi710"
            CALL q_bgga003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggd007  #顯示到畫面上
            NEXT FIELD bggd007                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd007
            #add-point:BEFORE FIELD bggd007 name="construct.b.page1.bggd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd007
            
            #add-point:AFTER FIELD bggd007 name="construct.a.page1.bggd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggd008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd008
            #add-point:ON ACTION controlp INFIELD bggd008 name="construct.c.page1.bggd008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "abgi720"
            CALL q_bgga003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggd008  #顯示到畫面上
            NEXT FIELD bggd008                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd008
            #add-point:BEFORE FIELD bggd008 name="construct.b.page1.bggd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd008
            
            #add-point:AFTER FIELD bggd008 name="construct.a.page1.bggd008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggd009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd009
            #add-point:ON ACTION controlp INFIELD bggd009 name="construct.c.page1.bggd009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggd009  #顯示到畫面上
            NEXT FIELD bggd009                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd009
            #add-point:BEFORE FIELD bggd009 name="construct.b.page1.bggd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd009
            
            #add-point:AFTER FIELD bggd009 name="construct.a.page1.bggd009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd010
            #add-point:BEFORE FIELD bggd010 name="construct.b.page1.bggd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd010
            
            #add-point:AFTER FIELD bggd010 name="construct.a.page1.bggd010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd010
            #add-point:ON ACTION controlp INFIELD bggd010 name="construct.c.page1.bggd010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bggdownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggdownid
            #add-point:ON ACTION controlp INFIELD bggdownid name="construct.c.page2.bggdownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggdownid  #顯示到畫面上
            NEXT FIELD bggdownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggdownid
            #add-point:BEFORE FIELD bggdownid name="construct.b.page2.bggdownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggdownid
            
            #add-point:AFTER FIELD bggdownid name="construct.a.page2.bggdownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggdowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggdowndp
            #add-point:ON ACTION controlp INFIELD bggdowndp name="construct.c.page2.bggdowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggdowndp  #顯示到畫面上
            NEXT FIELD bggdowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggdowndp
            #add-point:BEFORE FIELD bggdowndp name="construct.b.page2.bggdowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggdowndp
            
            #add-point:AFTER FIELD bggdowndp name="construct.a.page2.bggdowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggdcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggdcrtid
            #add-point:ON ACTION controlp INFIELD bggdcrtid name="construct.c.page2.bggdcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggdcrtid  #顯示到畫面上
            NEXT FIELD bggdcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggdcrtid
            #add-point:BEFORE FIELD bggdcrtid name="construct.b.page2.bggdcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggdcrtid
            
            #add-point:AFTER FIELD bggdcrtid name="construct.a.page2.bggdcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggdcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggdcrtdp
            #add-point:ON ACTION controlp INFIELD bggdcrtdp name="construct.c.page2.bggdcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggdcrtdp  #顯示到畫面上
            NEXT FIELD bggdcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggdcrtdp
            #add-point:BEFORE FIELD bggdcrtdp name="construct.b.page2.bggdcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggdcrtdp
            
            #add-point:AFTER FIELD bggdcrtdp name="construct.a.page2.bggdcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggdcrtdt
            #add-point:BEFORE FIELD bggdcrtdt name="construct.b.page2.bggdcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bggdmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggdmodid
            #add-point:ON ACTION controlp INFIELD bggdmodid name="construct.c.page2.bggdmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggdmodid  #顯示到畫面上
            NEXT FIELD bggdmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggdmodid
            #add-point:BEFORE FIELD bggdmodid name="construct.b.page2.bggdmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggdmodid
            
            #add-point:AFTER FIELD bggdmodid name="construct.a.page2.bggdmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggdmoddt
            #add-point:BEFORE FIELD bggdmoddt name="construct.b.page2.bggdmoddt"
            
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
 
{<section id="abgi760.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abgi760_filter()
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
      CONSTRUCT g_wc_filter ON bggd001,bggd002,bggd003,bggd004,bggd005
                          FROM s_browse[1].b_bggd001,s_browse[1].b_bggd002,s_browse[1].b_bggd003,s_browse[1].b_bggd004, 
                              s_browse[1].b_bggd005
 
         BEFORE CONSTRUCT
               DISPLAY abgi760_filter_parser('bggd001') TO s_browse[1].b_bggd001
            DISPLAY abgi760_filter_parser('bggd002') TO s_browse[1].b_bggd002
            DISPLAY abgi760_filter_parser('bggd003') TO s_browse[1].b_bggd003
            DISPLAY abgi760_filter_parser('bggd004') TO s_browse[1].b_bggd004
            DISPLAY abgi760_filter_parser('bggd005') TO s_browse[1].b_bggd005
      
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
 
      CALL abgi760_filter_show('bggd001')
   CALL abgi760_filter_show('bggd002')
   CALL abgi760_filter_show('bggd003')
   CALL abgi760_filter_show('bggd004')
   CALL abgi760_filter_show('bggd005')
 
END FUNCTION
 
{</section>}
 
{<section id="abgi760.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abgi760_filter_parser(ps_field)
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
 
{<section id="abgi760.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abgi760_filter_show(ps_field)
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
   LET ls_condition = abgi760_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abgi760.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abgi760_query()
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
   CALL g_bggd_d.clear()
   CALL g_bggd2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL abgi760_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abgi760_browser_fill(g_wc)
      CALL abgi760_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL abgi760_browser_fill("F")
   
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
      CALL abgi760_fetch("F") 
   END IF
   
   CALL abgi760_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="abgi760.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abgi760_fetch(p_flag)
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
   
   LET g_bggd_m.bggd001 = g_browser[g_current_idx].b_bggd001
   LET g_bggd_m.bggd002 = g_browser[g_current_idx].b_bggd002
   LET g_bggd_m.bggd003 = g_browser[g_current_idx].b_bggd003
   LET g_bggd_m.bggd004 = g_browser[g_current_idx].b_bggd004
   LET g_bggd_m.bggd005 = g_browser[g_current_idx].b_bggd005
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abgi760_master_referesh USING g_bggd_m.bggd001,g_bggd_m.bggd002,g_bggd_m.bggd003,g_bggd_m.bggd004, 
       g_bggd_m.bggd005 INTO g_bggd_m.bggd001,g_bggd_m.bggd004,g_bggd_m.bggd002,g_bggd_m.bggd005,g_bggd_m.bggd003, 
       g_bggd_m.bggd006,g_bggd_m.bggd001_desc,g_bggd_m.bggd002_desc,g_bggd_m.bggd005_desc,g_bggd_m.bggd003_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bggd_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_bggd_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_bggd_m_mask_o.* =  g_bggd_m.*
   CALL abgi760_bggd_t_mask()
   LET g_bggd_m_mask_n.* =  g_bggd_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgi760_set_act_visible()
   CALL abgi760_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_bggd_m_t.* = g_bggd_m.*
   LET g_bggd_m_o.* = g_bggd_m.*
   
   #重新顯示   
   CALL abgi760_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abgi760.insert" >}
#+ 資料新增
PRIVATE FUNCTION abgi760_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_bggd_d.clear()
   CALL g_bggd2_d.clear()
 
 
   INITIALIZE g_bggd_m.* TO NULL             #DEFAULT 設定
   LET g_bggd001_t = NULL
   LET g_bggd002_t = NULL
   LET g_bggd003_t = NULL
   LET g_bggd004_t = NULL
   LET g_bggd005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_bggd_m.bggd006 = "1"
 
     
      #add-point:單頭預設值 name="insert.default"
      LET g_bggd_m.bggd002 = g_site
      #end add-point 
 
      CALL abgi760_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_bggd_m.* TO NULL
         INITIALIZE g_bggd_d TO NULL
         INITIALIZE g_bggd2_d TO NULL
 
         CALL abgi760_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bggd_m.* = g_bggd_m_t.*
         CALL abgi760_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_bggd_d.clear()
      #CALL g_bggd2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgi760_set_act_visible()
   CALL abgi760_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bggd001_t = g_bggd_m.bggd001
   LET g_bggd002_t = g_bggd_m.bggd002
   LET g_bggd003_t = g_bggd_m.bggd003
   LET g_bggd004_t = g_bggd_m.bggd004
   LET g_bggd005_t = g_bggd_m.bggd005
 
   
   #組合新增資料的條件
   LET g_add_browse = " bggdent = " ||g_enterprise|| " AND",
                      " bggd001 = '", g_bggd_m.bggd001, "' "
                      ," AND bggd002 = '", g_bggd_m.bggd002, "' "
                      ," AND bggd003 = '", g_bggd_m.bggd003, "' "
                      ," AND bggd004 = '", g_bggd_m.bggd004, "' "
                      ," AND bggd005 = '", g_bggd_m.bggd005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgi760_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL abgi760_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abgi760_master_referesh USING g_bggd_m.bggd001,g_bggd_m.bggd002,g_bggd_m.bggd003,g_bggd_m.bggd004, 
       g_bggd_m.bggd005 INTO g_bggd_m.bggd001,g_bggd_m.bggd004,g_bggd_m.bggd002,g_bggd_m.bggd005,g_bggd_m.bggd003, 
       g_bggd_m.bggd006,g_bggd_m.bggd001_desc,g_bggd_m.bggd002_desc,g_bggd_m.bggd005_desc,g_bggd_m.bggd003_desc 
 
   
   #遮罩相關處理
   LET g_bggd_m_mask_o.* =  g_bggd_m.*
   CALL abgi760_bggd_t_mask()
   LET g_bggd_m_mask_n.* =  g_bggd_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bggd_m.bggd001,g_bggd_m.bggd001_desc,g_bggd_m.bggd004,g_bggd_m.bggd004_desc,g_bggd_m.l_bgaa002, 
       g_bggd_m.l_bgaa002_desc,g_bggd_m.bggd002,g_bggd_m.bggd002_desc,g_bggd_m.bggd005,g_bggd_m.bggd005_desc, 
       g_bggd_m.l_bgaa003,g_bggd_m.l_bgaa003_desc,g_bggd_m.bggd003,g_bggd_m.bggd003_desc,g_bggd_m.bggd006 
 
   
   #功能已完成,通報訊息中心
   CALL abgi760_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abgi760.modify" >}
#+ 資料修改
PRIVATE FUNCTION abgi760_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_bggd_m.bggd001 IS NULL
   OR g_bggd_m.bggd002 IS NULL
   OR g_bggd_m.bggd003 IS NULL
   OR g_bggd_m.bggd004 IS NULL
   OR g_bggd_m.bggd005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_bggd001_t = g_bggd_m.bggd001
   LET g_bggd002_t = g_bggd_m.bggd002
   LET g_bggd003_t = g_bggd_m.bggd003
   LET g_bggd004_t = g_bggd_m.bggd004
   LET g_bggd005_t = g_bggd_m.bggd005
 
   CALL s_transaction_begin()
   
   OPEN abgi760_cl USING g_enterprise,g_bggd_m.bggd001,g_bggd_m.bggd002,g_bggd_m.bggd003,g_bggd_m.bggd004,g_bggd_m.bggd005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgi760_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgi760_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgi760_master_referesh USING g_bggd_m.bggd001,g_bggd_m.bggd002,g_bggd_m.bggd003,g_bggd_m.bggd004, 
       g_bggd_m.bggd005 INTO g_bggd_m.bggd001,g_bggd_m.bggd004,g_bggd_m.bggd002,g_bggd_m.bggd005,g_bggd_m.bggd003, 
       g_bggd_m.bggd006,g_bggd_m.bggd001_desc,g_bggd_m.bggd002_desc,g_bggd_m.bggd005_desc,g_bggd_m.bggd003_desc 
 
   
   #遮罩相關處理
   LET g_bggd_m_mask_o.* =  g_bggd_m.*
   CALL abgi760_bggd_t_mask()
   LET g_bggd_m_mask_n.* =  g_bggd_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL abgi760_show()
   WHILE TRUE
      LET g_bggd001_t = g_bggd_m.bggd001
      LET g_bggd002_t = g_bggd_m.bggd002
      LET g_bggd003_t = g_bggd_m.bggd003
      LET g_bggd004_t = g_bggd_m.bggd004
      LET g_bggd005_t = g_bggd_m.bggd005
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL abgi760_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bggd_m.* = g_bggd_m_t.*
         CALL abgi760_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_bggd_m.bggd001 != g_bggd001_t 
      OR g_bggd_m.bggd002 != g_bggd002_t 
      OR g_bggd_m.bggd003 != g_bggd003_t 
      OR g_bggd_m.bggd004 != g_bggd004_t 
      OR g_bggd_m.bggd005 != g_bggd005_t 
 
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
   CALL abgi760_set_act_visible()
   CALL abgi760_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bggdent = " ||g_enterprise|| " AND",
                      " bggd001 = '", g_bggd_m.bggd001, "' "
                      ," AND bggd002 = '", g_bggd_m.bggd002, "' "
                      ," AND bggd003 = '", g_bggd_m.bggd003, "' "
                      ," AND bggd004 = '", g_bggd_m.bggd004, "' "
                      ," AND bggd005 = '", g_bggd_m.bggd005, "' "
 
   #填到對應位置
   CALL abgi760_browser_fill("")
 
   CALL abgi760_idx_chk()
 
   CLOSE abgi760_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgi760_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="abgi760.input" >}
#+ 資料輸入
PRIVATE FUNCTION abgi760_input(p_cmd)
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
   DEFINE  l_ooef014             LIKE ooef_t.ooef014
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
   DISPLAY BY NAME g_bggd_m.bggd001,g_bggd_m.bggd001_desc,g_bggd_m.bggd004,g_bggd_m.bggd004_desc,g_bggd_m.l_bgaa002, 
       g_bggd_m.l_bgaa002_desc,g_bggd_m.bggd002,g_bggd_m.bggd002_desc,g_bggd_m.bggd005,g_bggd_m.bggd005_desc, 
       g_bggd_m.l_bgaa003,g_bggd_m.l_bgaa003_desc,g_bggd_m.bggd003,g_bggd_m.bggd003_desc,g_bggd_m.bggd006 
 
   
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
   LET g_forupd_sql = "SELECT bggd007,bggd008,bggd009,bggd010,bggd007,bggd008,bggdownid,bggdowndp,bggdcrtid, 
       bggdcrtdp,bggdcrtdt,bggdmodid,bggdmoddt FROM bggd_t WHERE bggdent=? AND bggd001=? AND bggd002=?  
       AND bggd003=? AND bggd004=? AND bggd005=? AND bggd007=? AND bggd008=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgi760_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abgi760_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abgi760_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_bggd_m.bggd001,g_bggd_m.bggd004,g_bggd_m.bggd002,g_bggd_m.bggd005,g_bggd_m.bggd003, 
       g_bggd_m.bggd006
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abgi760.input.head" >}
   
      #單頭段
      INPUT BY NAME g_bggd_m.bggd001,g_bggd_m.bggd004,g_bggd_m.bggd002,g_bggd_m.bggd005,g_bggd_m.bggd003, 
          g_bggd_m.bggd006 
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
         AFTER FIELD bggd001
            
            #add-point:AFTER FIELD bggd001 name="input.a.bggd001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bggd_m.bggd001) AND NOT cl_null(g_bggd_m.bggd002) AND NOT cl_null(g_bggd_m.bggd003) AND NOT cl_null(g_bggd_m.bggd004) AND NOT cl_null(g_bggd_m.bggd005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggd_m.bggd001 != g_bggd001_t  OR g_bggd_m.bggd002 != g_bggd002_t  OR g_bggd_m.bggd003 != g_bggd003_t  OR g_bggd_m.bggd004 != g_bggd004_t  OR g_bggd_m.bggd005 != g_bggd005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggd_t WHERE "||"bggdent = " ||g_enterprise|| " AND "||"bggd001 = '"||g_bggd_m.bggd001 ||"' AND "|| "bggd002 = '"||g_bggd_m.bggd002 ||"' AND "|| "bggd003 = '"||g_bggd_m.bggd003 ||"' AND "|| "bggd004 = '"||g_bggd_m.bggd004 ||"' AND "|| "bggd005 = '"||g_bggd_m.bggd005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            LET g_bggd_m.bggd001_desc = ' '
            LET g_bggd_m.l_bgaa002 = ' '
            LET g_bggd_m.l_bgaa002_desc = ' '
            LET g_bggd_m.l_bgaa003 = ' '
            LET g_bggd_m.l_bgaa003_desc = ' '
            DISPLAY BY NAME g_bggd_m.bggd001_desc,g_bggd_m.l_bgaa002,g_bggd_m.l_bgaa002_desc,
                            g_bggd_m.l_bgaa003,g_bggd_m.l_bgaa003_desc
            IF NOT cl_null(g_bggd_m.bggd001) THEN
               IF g_bggd_m.bggd001 != g_bggd_m_o.bggd001 OR g_bggd_m_o.bggd001 IS NULL THEN
                  CALL s_fin_budget_chk(g_bggd_m.bggd001)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success  THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = 'abgi040'
                     LET g_errparam.replace[2] = cl_get_progname('abgi040',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi040'
                     LET g_errparam.extend = ''
                     CALL cl_err()
                     LET g_bggd_m.bggd001 = g_bggd_m_t.bggd001
                     LET g_bggd_m.bggd001_desc = s_desc_get_budget_desc(g_bggd_m.bggd001)
                     DISPLAY BY NAME g_bggd_m.bggd001,g_bggd_m.bggd001_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_abg_center_sons_query(g_bggd_m.bggd001,'','')
                     
                  LET g_bggd_m.bggd002 = ''
                  LET g_bggd_m.bggd002_desc = ''
                  DISPLAY BY NAME g_bggd_m.bggd002,g_bggd_m.bggd002_desc
               END IF            
            ELSE
               DELETE FROM s_fin_tmp1 where 1=1            
            END IF
            LET g_bggd_m_o.bggd001 = g_bggd_m.bggd001
            LET g_bggd_m.bggd001_desc = s_desc_get_budget_desc(g_bggd_m.bggd001)
            
            #預算編號帶出預算週期,預算幣別
            SELECT bgaa002,bgaa003 
              INTO g_bggd_m.l_bgaa002,g_bggd_m.l_bgaa003
              FROM bgaa_t
             WHERE bgaa001 = g_bggd_m.bggd001
               AND bgaaent = g_enterprise               

            #預算週期的說明
            SELECT bgacl003 
              INTO g_bggd_m.l_bgaa002_desc
              FROM bgacl_t
             WHERE bgaclent = g_enterprise
               AND bgacl001 = g_bggd_m.l_bgaa002
               AND bgacl002 = g_dlang         
               
            #預算幣別的說明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bggd_m.l_bgaa003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bggd_m.l_bgaa003_desc = '', g_rtn_fields[1] , ''
               
            DISPLAY BY NAME g_bggd_m.bggd001,g_bggd_m.bggd001_desc,g_bggd_m.l_bgaa002,g_bggd_m.l_bgaa002_desc,
                            g_bggd_m.l_bgaa003,g_bggd_m.l_bgaa003_desc



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd001
            #add-point:BEFORE FIELD bggd001 name="input.b.bggd001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggd001
            #add-point:ON CHANGE bggd001 name="input.g.bggd001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd004
            
            #add-point:AFTER FIELD bggd004 name="input.a.bggd004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = 3401
            LET g_ref_fields[2] = g_bggd_m.bggd004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bggd_m.bggd004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bggd_m.bggd004_desc

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bggd_m.bggd001) AND NOT cl_null(g_bggd_m.bggd002) AND NOT cl_null(g_bggd_m.bggd003) AND NOT cl_null(g_bggd_m.bggd004) AND NOT cl_null(g_bggd_m.bggd005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggd_m.bggd001 != g_bggd001_t  OR g_bggd_m.bggd002 != g_bggd002_t  OR g_bggd_m.bggd003 != g_bggd003_t  OR g_bggd_m.bggd004 != g_bggd004_t  OR g_bggd_m.bggd005 != g_bggd005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggd_t WHERE "||"bggdent = " ||g_enterprise|| " AND "||"bggd001 = '"||g_bggd_m.bggd001 ||"' AND "|| "bggd002 = '"||g_bggd_m.bggd002 ||"' AND "|| "bggd003 = '"||g_bggd_m.bggd003 ||"' AND "|| "bggd004 = '"||g_bggd_m.bggd004 ||"' AND "|| "bggd005 = '"||g_bggd_m.bggd005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bggd_m.bggd003) AND NOT cl_null(g_bggd_m.bggd004) THEN
               CALL abgi760_chk_bggd004(g_bggd_m.bggd003,g_bggd_m.bggd004)
               IF NOT cl_null(g_errno) THEN
                  LET g_errparam.extend = g_bggd_m.bggd003,"/",g_bggd_m.bggd004
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd004
            #add-point:BEFORE FIELD bggd004 name="input.b.bggd004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggd004
            #add-point:ON CHANGE bggd004 name="input.g.bggd004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd002
            
            #add-point:AFTER FIELD bggd002 name="input.a.bggd002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bggd_m.bggd002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bggd_m.bggd002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bggd_m.bggd002_desc

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bggd_m.bggd001) AND NOT cl_null(g_bggd_m.bggd002) AND NOT cl_null(g_bggd_m.bggd003) AND NOT cl_null(g_bggd_m.bggd004) AND NOT cl_null(g_bggd_m.bggd005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggd_m.bggd001 != g_bggd001_t  OR g_bggd_m.bggd002 != g_bggd002_t  OR g_bggd_m.bggd003 != g_bggd003_t  OR g_bggd_m.bggd004 != g_bggd004_t  OR g_bggd_m.bggd005 != g_bggd005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggd_t WHERE "||"bggdent = " ||g_enterprise|| " AND "||"bggd001 = '"||g_bggd_m.bggd001 ||"' AND "|| "bggd002 = '"||g_bggd_m.bggd002 ||"' AND "|| "bggd003 = '"||g_bggd_m.bggd003 ||"' AND "|| "bggd004 = '"||g_bggd_m.bggd004 ||"' AND "|| "bggd005 = '"||g_bggd_m.bggd005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            LET g_bggd_m.bggd002_desc = ' '
            DISPLAY BY NAME g_bggd_m.bggd002_desc
            IF NOT cl_null(g_bggd_m.bggd002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bggd_m.bggd002 != g_bggd_m_t.bggd002 OR g_bggd_m_t.bggd002 IS NULL )) THEN
                  CALL abgi750_chk_bggd002(g_bggd_m.bggd002)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggd_m.bggd002 = g_bggd_m_t.bggd002
                     LET g_bggd_m.bggd002_desc =s_desc_get_department_desc(g_bggd_m.bggd002)
                     DISPLAY BY NAME g_bggd_m.bggd002,g_bggd_m.bggd002_desc
                     NEXT FIELD CURRENT
                  END IF

                  IF NOT cl_null(g_bggd_m.bggd001)THEN
                     CALL s_abg_site_chk(g_bggd_m.bggd002)RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bggd_m.bggd002 = g_bggd_m_t.bggd002
                        LET g_bggd_m.bggd002_desc =s_desc_get_department_desc(g_bggd_m.bggd002)
                        DISPLAY BY NAME g_bggd_m.bggd002,g_bggd_m.bggd002_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_bggd_m.bggd002_desc =s_desc_get_department_desc(g_bggd_m.bggd002)
            DISPLAY BY NAME g_bggd_m.bggd002,g_bggd_m.bggd002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd002
            #add-point:BEFORE FIELD bggd002 name="input.b.bggd002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggd002
            #add-point:ON CHANGE bggd002 name="input.g.bggd002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd005
            
            #add-point:AFTER FIELD bggd005 name="input.a.bggd005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bggd_m.bggd005
            CALL ap_ref_array2(g_ref_fields,"SELECT bggal004 FROM bggal_t WHERE bggalent="||g_enterprise||" AND bggal001='abgi730' AND bggal002=? AND bggal003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bggd_m.bggd005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bggd_m.bggd005_desc

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bggd_m.bggd001) AND NOT cl_null(g_bggd_m.bggd002) AND NOT cl_null(g_bggd_m.bggd003) AND NOT cl_null(g_bggd_m.bggd004) AND NOT cl_null(g_bggd_m.bggd005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggd_m.bggd001 != g_bggd001_t  OR g_bggd_m.bggd002 != g_bggd002_t  OR g_bggd_m.bggd003 != g_bggd003_t  OR g_bggd_m.bggd004 != g_bggd004_t  OR g_bggd_m.bggd005 != g_bggd005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggd_t WHERE "||"bggdent = " ||g_enterprise|| " AND "||"bggd001 = '"||g_bggd_m.bggd001 ||"' AND "|| "bggd002 = '"||g_bggd_m.bggd002 ||"' AND "|| "bggd003 = '"||g_bggd_m.bggd003 ||"' AND "|| "bggd004 = '"||g_bggd_m.bggd004 ||"' AND "|| "bggd005 = '"||g_bggd_m.bggd005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bggd_m.bggd005) THEN
               CALL abgi760_chk_abgi710s('abgi730',g_bggd_m.bggd005)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_bggd_m.bggd005
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  NEXT FIELD bggd005
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd005
            #add-point:BEFORE FIELD bggd005 name="input.b.bggd005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggd005
            #add-point:ON CHANGE bggd005 name="input.g.bggd005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd003
            
            #add-point:AFTER FIELD bggd003 name="input.a.bggd003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bggd_m.bggd003
            CALL ap_ref_array2(g_ref_fields,"SELECT bggbl004 FROM bggbl_t WHERE bggblent="||g_enterprise||" AND bggbl001=? AND bggbl002='0' AND bggbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bggd_m.bggd003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bggd_m.bggd003_desc

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bggd_m.bggd001) AND NOT cl_null(g_bggd_m.bggd002) AND NOT cl_null(g_bggd_m.bggd003) AND NOT cl_null(g_bggd_m.bggd004) AND NOT cl_null(g_bggd_m.bggd005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggd_m.bggd001 != g_bggd001_t  OR g_bggd_m.bggd002 != g_bggd002_t  OR g_bggd_m.bggd003 != g_bggd003_t  OR g_bggd_m.bggd004 != g_bggd004_t  OR g_bggd_m.bggd005 != g_bggd005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggd_t WHERE "||"bggdent = " ||g_enterprise|| " AND "||"bggd001 = '"||g_bggd_m.bggd001 ||"' AND "|| "bggd002 = '"||g_bggd_m.bggd002 ||"' AND "|| "bggd003 = '"||g_bggd_m.bggd003 ||"' AND "|| "bggd004 = '"||g_bggd_m.bggd004 ||"' AND "|| "bggd005 = '"||g_bggd_m.bggd005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bggd_m.bggd003) THEN
               CALL abgi760_chk_bggd003(g_bggd_m.bggd003)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_bggd_m.bggd003
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_bggd_m.bggd004) THEN
                  CALL abgi760_chk_bggd004(g_bggd_m.bggd003,g_bggd_m.bggd004)
                  IF NOT cl_null(g_errno) THEN
                     LET g_errparam.extend = g_bggd_m.bggd003,"/",g_bggd_m.bggd004
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd003
            #add-point:BEFORE FIELD bggd003 name="input.b.bggd003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggd003
            #add-point:ON CHANGE bggd003 name="input.g.bggd003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd006
            #add-point:BEFORE FIELD bggd006 name="input.b.bggd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd006
            
            #add-point:AFTER FIELD bggd006 name="input.a.bggd006"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggd006
            #add-point:ON CHANGE bggd006 name="input.g.bggd006"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bggd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd001
            #add-point:ON ACTION controlp INFIELD bggd001 name="input.c.bggd001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bggd_m.bggd001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgaa001()                                #呼叫開窗
 
            LET g_bggd_m.bggd001 = g_qryparam.return1              

            DISPLAY g_bggd_m.bggd001 TO bggd001              #

            NEXT FIELD bggd001                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bggd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd004
            #add-point:ON ACTION controlp INFIELD bggd004 name="input.c.bggd004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "EXISTS(SELECT 1 ",
                                   "         FROM bggb_t ",
                                   "        WHERE bggbent='",g_enterprise,"'",
                                   "          AND bggb001='",g_bggd_m.bggd003,"'",
                                   "          AND bggb002=oocq002",
                                   "          AND bggb003='1')"
 
            LET g_qryparam.default1 = g_bggd_m.bggd004             #給予default值
            LET g_qryparam.default2 = "" #g_bggd_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "3401" #s

 
            CALL q_bggb002()                                #呼叫開窗
 
            LET g_bggd_m.bggd004 = g_qryparam.return1              
            #LET g_bggd_m.oocq002 = g_qryparam.return2 
            DISPLAY g_bggd_m.bggd004 TO bggd004              #
            #DISPLAY g_bggd_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bggd004                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bggd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd002
            #add-point:ON ACTION controlp INFIELD bggd002 name="input.c.bggd002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "    ooef205 = 'Y' ",
                       "AND ooef001 IN (SELECT ooef001 ",
                       "                  FROM s_fin_tmp1 )"  
            LET g_qryparam.default1 = g_bggd_m.bggd002             #給予default值
            LET g_qryparam.default2 = "" #g_bggd_m.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_bggd_m.bggd002 = g_qryparam.return1              
            #LET g_bggd_m.ooef001 = g_qryparam.return2 
            DISPLAY g_bggd_m.bggd002 TO bggd002              #
            #DISPLAY g_bggd_m.ooef001 TO ooef001 #组织编号
            NEXT FIELD bggd002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bggd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd005
            #add-point:ON ACTION controlp INFIELD bggd005 name="input.c.bggd005"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "bggastus='Y'"
            LET g_qryparam.default1 = g_bggd_m.bggd005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "abgi730" #s

 
            CALL q_bgga003()                                #呼叫開窗
 
            LET g_bggd_m.bggd005 = g_qryparam.return1              

            DISPLAY g_bggd_m.bggd005 TO bggd005              #

            NEXT FIELD bggd005                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bggd003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd003
            #add-point:ON ACTION controlp INFIELD bggd003 name="input.c.bggd003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bggd_m.bggd003             #給予default值
            LET g_qryparam.default2 = "" #g_bggd_m.bggbl004 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_bggb001()                                #呼叫開窗
 
            LET g_bggd_m.bggd003 = g_qryparam.return1              
            #LET g_bggd_m.bggbl004 = g_qryparam.return2 
            DISPLAY g_bggd_m.bggd003 TO bggd003              #
            #DISPLAY g_bggd_m.bggbl004 TO bggbl004 #說明
            NEXT FIELD bggd003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bggd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd006
            #add-point:ON ACTION controlp INFIELD bggd006 name="input.c.bggd006"
            
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
            DISPLAY BY NAME g_bggd_m.bggd001             
                            ,g_bggd_m.bggd002   
                            ,g_bggd_m.bggd003   
                            ,g_bggd_m.bggd004   
                            ,g_bggd_m.bggd005   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL abgi760_bggd_t_mask_restore('restore_mask_o')
            
               UPDATE bggd_t SET (bggd001,bggd004,bggd002,bggd005,bggd003,bggd006) = (g_bggd_m.bggd001, 
                   g_bggd_m.bggd004,g_bggd_m.bggd002,g_bggd_m.bggd005,g_bggd_m.bggd003,g_bggd_m.bggd006) 
 
                WHERE bggdent = g_enterprise AND bggd001 = g_bggd001_t
                  AND bggd002 = g_bggd002_t
                  AND bggd003 = g_bggd003_t
                  AND bggd004 = g_bggd004_t
                  AND bggd005 = g_bggd005_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bggd_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bggd_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bggd_m.bggd001
               LET gs_keys_bak[1] = g_bggd001_t
               LET gs_keys[2] = g_bggd_m.bggd002
               LET gs_keys_bak[2] = g_bggd002_t
               LET gs_keys[3] = g_bggd_m.bggd003
               LET gs_keys_bak[3] = g_bggd003_t
               LET gs_keys[4] = g_bggd_m.bggd004
               LET gs_keys_bak[4] = g_bggd004_t
               LET gs_keys[5] = g_bggd_m.bggd005
               LET gs_keys_bak[5] = g_bggd005_t
               LET gs_keys[6] = g_bggd_d[g_detail_idx].bggd007
               LET gs_keys_bak[6] = g_bggd_d_t.bggd007
               LET gs_keys[7] = g_bggd_d[g_detail_idx].bggd008
               LET gs_keys_bak[7] = g_bggd_d_t.bggd008
               CALL abgi760_update_b('bggd_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_bggd_m_t)
                     #LET g_log2 = util.JSON.stringify(g_bggd_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL abgi760_bggd_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL abgi760_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_bggd001_t = g_bggd_m.bggd001
           LET g_bggd002_t = g_bggd_m.bggd002
           LET g_bggd003_t = g_bggd_m.bggd003
           LET g_bggd004_t = g_bggd_m.bggd004
           LET g_bggd005_t = g_bggd_m.bggd005
 
           
           IF g_bggd_d.getLength() = 0 THEN
              NEXT FIELD bggd007
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="abgi760.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_bggd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bggd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgi760_b_fill(g_wc2) #test 
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
            CALL abgi760_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN abgi760_cl USING g_enterprise,g_bggd_m.bggd001,g_bggd_m.bggd002,g_bggd_m.bggd003,g_bggd_m.bggd004,g_bggd_m.bggd005                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE abgi760_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgi760_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_bggd_d[l_ac].bggd007 IS NOT NULL
               AND g_bggd_d[l_ac].bggd008 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bggd_d_t.* = g_bggd_d[l_ac].*  #BACKUP
               LET g_bggd_d_o.* = g_bggd_d[l_ac].*  #BACKUP
               CALL abgi760_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL abgi760_set_no_entry_b(l_cmd)
               OPEN abgi760_bcl USING g_enterprise,g_bggd_m.bggd001,
                                                g_bggd_m.bggd002,
                                                g_bggd_m.bggd003,
                                                g_bggd_m.bggd004,
                                                g_bggd_m.bggd005,
 
                                                g_bggd_d_t.bggd007
                                                ,g_bggd_d_t.bggd008
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgi760_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgi760_bcl INTO g_bggd_d[l_ac].bggd007,g_bggd_d[l_ac].bggd008,g_bggd_d[l_ac].bggd009, 
                      g_bggd_d[l_ac].bggd010,g_bggd2_d[l_ac].bggd007,g_bggd2_d[l_ac].bggd008,g_bggd2_d[l_ac].bggdownid, 
                      g_bggd2_d[l_ac].bggdowndp,g_bggd2_d[l_ac].bggdcrtid,g_bggd2_d[l_ac].bggdcrtdp, 
                      g_bggd2_d[l_ac].bggdcrtdt,g_bggd2_d[l_ac].bggdmodid,g_bggd2_d[l_ac].bggdmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_bggd_d_t.bggd007,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bggd_d_mask_o[l_ac].* =  g_bggd_d[l_ac].*
                  CALL abgi760_bggd_t_mask()
                  LET g_bggd_d_mask_n[l_ac].* =  g_bggd_d[l_ac].*
                  
                  CALL abgi760_ref_show()
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
            INITIALIZE g_bggd_d_t.* TO NULL
            INITIALIZE g_bggd_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bggd_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bggd2_d[l_ac].bggdownid = g_user
      LET g_bggd2_d[l_ac].bggdowndp = g_dept
      LET g_bggd2_d[l_ac].bggdcrtid = g_user
      LET g_bggd2_d[l_ac].bggdcrtdp = g_dept 
      LET g_bggd2_d[l_ac].bggdcrtdt = cl_get_current()
      LET g_bggd2_d[l_ac].bggdmodid = g_user
      LET g_bggd2_d[l_ac].bggdmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
                  LET g_bggd_d[l_ac].bggd010 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            LET g_bggd_d[l_ac].bggd010=0
            #end add-point
            LET g_bggd_d_t.* = g_bggd_d[l_ac].*     #新輸入資料
            LET g_bggd_d_o.* = g_bggd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abgi760_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL abgi760_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bggd_d[li_reproduce_target].* = g_bggd_d[li_reproduce].*
               LET g_bggd2_d[li_reproduce_target].* = g_bggd2_d[li_reproduce].*
 
               LET g_bggd_d[g_bggd_d.getLength()].bggd007 = NULL
               LET g_bggd_d[g_bggd_d.getLength()].bggd008 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM bggd_t 
             WHERE bggdent = g_enterprise AND bggd001 = g_bggd_m.bggd001
               AND bggd002 = g_bggd_m.bggd002
               AND bggd003 = g_bggd_m.bggd003
               AND bggd004 = g_bggd_m.bggd004
               AND bggd005 = g_bggd_m.bggd005
 
               AND bggd007 = g_bggd_d[l_ac].bggd007
               AND bggd008 = g_bggd_d[l_ac].bggd008
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO bggd_t
                           (bggdent,
                            bggd001,bggd004,bggd002,bggd005,bggd003,bggd006,
                            bggd007,bggd008
                            ,bggd009,bggd010,bggdownid,bggdowndp,bggdcrtid,bggdcrtdp,bggdcrtdt,bggdmodid,bggdmoddt) 
                     VALUES(g_enterprise,
                            g_bggd_m.bggd001,g_bggd_m.bggd004,g_bggd_m.bggd002,g_bggd_m.bggd005,g_bggd_m.bggd003,g_bggd_m.bggd006,
                            g_bggd_d[l_ac].bggd007,g_bggd_d[l_ac].bggd008
                            ,g_bggd_d[l_ac].bggd009,g_bggd_d[l_ac].bggd010,g_bggd2_d[l_ac].bggdownid, 
                                g_bggd2_d[l_ac].bggdowndp,g_bggd2_d[l_ac].bggdcrtid,g_bggd2_d[l_ac].bggdcrtdp, 
                                g_bggd2_d[l_ac].bggdcrtdt,g_bggd2_d[l_ac].bggdmodid,g_bggd2_d[l_ac].bggdmoddt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_bggd_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "bggd_t:",SQLERRMESSAGE 
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
               IF abgi760_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_bggd_m.bggd001
                  LET gs_keys[gs_keys.getLength()+1] = g_bggd_m.bggd002
                  LET gs_keys[gs_keys.getLength()+1] = g_bggd_m.bggd003
                  LET gs_keys[gs_keys.getLength()+1] = g_bggd_m.bggd004
                  LET gs_keys[gs_keys.getLength()+1] = g_bggd_m.bggd005
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bggd_d_t.bggd007
                  LET gs_keys[gs_keys.getLength()+1] = g_bggd_d_t.bggd008
 
 
                  #刪除下層單身
                  IF NOT abgi760_key_delete_b(gs_keys,'bggd_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE abgi760_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE abgi760_bcl
               LET l_count = g_bggd_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_bggd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd007
            
            #add-point:AFTER FIELD bggd007 name="input.a.page1.bggd007"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bggd_m.bggd001 IS NOT NULL AND g_bggd_m.bggd002 IS NOT NULL AND g_bggd_m.bggd003 IS NOT NULL AND g_bggd_m.bggd004 IS NOT NULL AND g_bggd_m.bggd005 IS NOT NULL AND g_bggd_d[g_detail_idx].bggd007 IS NOT NULL AND g_bggd_d[g_detail_idx].bggd008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bggd_m.bggd001 != g_bggd001_t OR g_bggd_m.bggd002 != g_bggd002_t OR g_bggd_m.bggd003 != g_bggd003_t OR g_bggd_m.bggd004 != g_bggd004_t OR g_bggd_m.bggd005 != g_bggd005_t OR g_bggd_d[g_detail_idx].bggd007 != g_bggd_d_t.bggd007 OR g_bggd_d[g_detail_idx].bggd008 != g_bggd_d_t.bggd008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggd_t WHERE "||"bggdent = " ||g_enterprise|| " AND "||"bggd001 = '"||g_bggd_m.bggd001 ||"' AND "|| "bggd002 = '"||g_bggd_m.bggd002 ||"' AND "|| "bggd003 = '"||g_bggd_m.bggd003 ||"' AND "|| "bggd004 = '"||g_bggd_m.bggd004 ||"' AND "|| "bggd005 = '"||g_bggd_m.bggd005 ||"' AND "|| "bggd007 = '"||g_bggd_d[g_detail_idx].bggd007 ||"' AND "|| "bggd008 = '"||g_bggd_d[g_detail_idx].bggd008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bggd_d[g_detail_idx].bggd007) THEN
               CALL abgi760_chk_abgi710s('abgi710',g_bggd_d[g_detail_idx].bggd007)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_bggd_d[g_detail_idx].bggd007
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bggd_d[l_ac].bggd007
            CALL ap_ref_array2(g_ref_fields,"SELECT bggal004 FROM bggal_t WHERE bggalent="||g_enterprise||" AND bggal001='abgi710' AND bggal002=? AND bggal003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bggd_d[l_ac].bggd007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bggd_d[l_ac].bggd007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd007
            #add-point:BEFORE FIELD bggd007 name="input.b.page1.bggd007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggd007
            #add-point:ON CHANGE bggd007 name="input.g.page1.bggd007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd008
            
            #add-point:AFTER FIELD bggd008 name="input.a.page1.bggd008"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bggd_m.bggd001 IS NOT NULL AND g_bggd_m.bggd002 IS NOT NULL AND g_bggd_m.bggd003 IS NOT NULL AND g_bggd_m.bggd004 IS NOT NULL AND g_bggd_m.bggd005 IS NOT NULL AND g_bggd_d[g_detail_idx].bggd007 IS NOT NULL AND g_bggd_d[g_detail_idx].bggd008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bggd_m.bggd001 != g_bggd001_t OR g_bggd_m.bggd002 != g_bggd002_t OR g_bggd_m.bggd003 != g_bggd003_t OR g_bggd_m.bggd004 != g_bggd004_t OR g_bggd_m.bggd005 != g_bggd005_t OR g_bggd_d[g_detail_idx].bggd007 != g_bggd_d_t.bggd007 OR g_bggd_d[g_detail_idx].bggd008 != g_bggd_d_t.bggd008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggd_t WHERE "||"bggdent = " ||g_enterprise|| " AND "||"bggd001 = '"||g_bggd_m.bggd001 ||"' AND "|| "bggd002 = '"||g_bggd_m.bggd002 ||"' AND "|| "bggd003 = '"||g_bggd_m.bggd003 ||"' AND "|| "bggd004 = '"||g_bggd_m.bggd004 ||"' AND "|| "bggd005 = '"||g_bggd_m.bggd005 ||"' AND "|| "bggd007 = '"||g_bggd_d[g_detail_idx].bggd007 ||"' AND "|| "bggd008 = '"||g_bggd_d[g_detail_idx].bggd008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bggd_d[g_detail_idx].bggd008) THEN
               CALL abgi760_chk_abgi710s('abgi720',g_bggd_d[g_detail_idx].bggd008)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_bggd_d[g_detail_idx].bggd008
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bggd_d[l_ac].bggd008
            CALL ap_ref_array2(g_ref_fields,"SELECT bggal004 FROM bggal_t WHERE bggalent="||g_enterprise||" AND bggal001='abgi720' AND bggal002=? AND bggal003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bggd_d[l_ac].bggd008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bggd_d[l_ac].bggd008_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd008
            #add-point:BEFORE FIELD bggd008 name="input.b.page1.bggd008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggd008
            #add-point:ON CHANGE bggd008 name="input.g.page1.bggd008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd009
            #add-point:BEFORE FIELD bggd009 name="input.b.page1.bggd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd009
            
            #add-point:AFTER FIELD bggd009 name="input.a.page1.bggd009"
            IF NOT cl_null(g_bggd_d[l_ac].bggd009) THEN
               CALL abgi760_chk_bggd009()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_bggd_d[l_ac].bggd009
                  LET g_errparam.code   = g_errno 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_bggd_d[l_ac].bggd010) THEN 
                  IF cl_null(g_bggd_m.bggd002) THEN
                     CALL s_curr_round(g_site,g_bggd_d[l_ac].bggd009,g_bggd_d[l_ac].bggd010,'2') RETURNING g_bggd_d[l_ac].bggd010
                  ELSE
                     CALL s_curr_round(g_bggd_m.bggd002,g_bggd_d[l_ac].bggd009,g_bggd_d[l_ac].bggd010,'2') RETURNING g_bggd_d[l_ac].bggd010
                  END IF
                  DISPLAY BY NAME g_bggd_d[l_ac].bggd010
               END IF   
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggd009
            #add-point:ON CHANGE bggd009 name="input.g.page1.bggd009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggd010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bggd_d[l_ac].bggd010,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bggd010
            END IF 
 
 
 
            #add-point:AFTER FIELD bggd010 name="input.a.page1.bggd010"
            IF NOT cl_null(g_bggd_d[l_ac].bggd010) AND NOT cl_null(g_bggd_d[l_ac].bggd009) THEN 
               IF cl_null(g_bggd_m.bggd002) THEN
                  CALL s_curr_round(g_site,g_bggd_d[l_ac].bggd009,g_bggd_d[l_ac].bggd010,'2') RETURNING g_bggd_d[l_ac].bggd010
               ELSE
                  CALL s_curr_round(g_bggd_m.bggd002,g_bggd_d[l_ac].bggd009,g_bggd_d[l_ac].bggd010,'2') RETURNING g_bggd_d[l_ac].bggd010
               END IF
               DISPLAY BY NAME g_bggd_d[l_ac].bggd010
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggd010
            #add-point:BEFORE FIELD bggd010 name="input.b.page1.bggd010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggd010
            #add-point:ON CHANGE bggd010 name="input.g.page1.bggd010"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bggd007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd007
            #add-point:ON ACTION controlp INFIELD bggd007 name="input.c.page1.bggd007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "bggastus='Y'"
            LET g_qryparam.default1 = g_bggd_d[l_ac].bggd007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "abgi710" #s

 
            CALL q_bgga003()                                #呼叫開窗
 
            LET g_bggd_d[l_ac].bggd007 = g_qryparam.return1              

            DISPLAY g_bggd_d[l_ac].bggd007 TO bggd007              #

            NEXT FIELD bggd007                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bggd008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd008
            #add-point:ON ACTION controlp INFIELD bggd008 name="input.c.page1.bggd008"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "bggastus='Y'"
            LET g_qryparam.default1 = g_bggd_d[l_ac].bggd008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "abgi720" #s

 
            CALL q_bgga003()                                #呼叫開窗
 
            LET g_bggd_d[l_ac].bggd008 = g_qryparam.return1              

            DISPLAY g_bggd_d[l_ac].bggd008 TO bggd008              #

            NEXT FIELD bggd008                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bggd009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd009
            #add-point:ON ACTION controlp INFIELD bggd009 name="input.c.page1.bggd009"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            
            LET l_ooef014=NULL
            SELECT ooef014
              INTO l_ooef014
              FROM ooef_t
             WHERE ooefent=g_enterprise
               AND ooef001=g_bggd_m.bggd002
            LET g_qryparam.where = "  EXISTS(SELECT 1 ",
                                   "           FROM ooaj_t",
                                   "          WHERE ooaj002=ooai001 ",
                                   "            AND ooajent='",g_enterprise,"'",
                                   "            AND ooaj001='",l_ooef014,"')"
            LET g_qryparam.default1 = g_bggd_d[l_ac].bggd009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooai001()                                #呼叫開窗
 
            LET g_bggd_d[l_ac].bggd009 = g_qryparam.return1              

            DISPLAY g_bggd_d[l_ac].bggd009 TO bggd009              #

            NEXT FIELD bggd009                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bggd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggd010
            #add-point:ON ACTION controlp INFIELD bggd010 name="input.c.page1.bggd010"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bggd_d[l_ac].* = g_bggd_d_t.*
               CLOSE abgi760_bcl
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
               LET g_errparam.extend = g_bggd_d[l_ac].bggd007 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_bggd_d[l_ac].* = g_bggd_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_bggd2_d[l_ac].bggdmodid = g_user 
LET g_bggd2_d[l_ac].bggdmoddt = cl_get_current()
LET g_bggd2_d[l_ac].bggdmodid_desc = cl_get_username(g_bggd2_d[l_ac].bggdmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL abgi760_bggd_t_mask_restore('restore_mask_o')
         
               UPDATE bggd_t SET (bggd001,bggd002,bggd003,bggd004,bggd005,bggd007,bggd008,bggd009,bggd010, 
                   bggdownid,bggdowndp,bggdcrtid,bggdcrtdp,bggdcrtdt,bggdmodid,bggdmoddt) = (g_bggd_m.bggd001, 
                   g_bggd_m.bggd002,g_bggd_m.bggd003,g_bggd_m.bggd004,g_bggd_m.bggd005,g_bggd_d[l_ac].bggd007, 
                   g_bggd_d[l_ac].bggd008,g_bggd_d[l_ac].bggd009,g_bggd_d[l_ac].bggd010,g_bggd2_d[l_ac].bggdownid, 
                   g_bggd2_d[l_ac].bggdowndp,g_bggd2_d[l_ac].bggdcrtid,g_bggd2_d[l_ac].bggdcrtdp,g_bggd2_d[l_ac].bggdcrtdt, 
                   g_bggd2_d[l_ac].bggdmodid,g_bggd2_d[l_ac].bggdmoddt)
                WHERE bggdent = g_enterprise AND bggd001 = g_bggd_m.bggd001 
                 AND bggd002 = g_bggd_m.bggd002 
                 AND bggd003 = g_bggd_m.bggd003 
                 AND bggd004 = g_bggd_m.bggd004 
                 AND bggd005 = g_bggd_m.bggd005 
 
                 AND bggd007 = g_bggd_d_t.bggd007 #項次   
                 AND bggd008 = g_bggd_d_t.bggd008  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bggd_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "bggd_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bggd_m.bggd001
               LET gs_keys_bak[1] = g_bggd001_t
               LET gs_keys[2] = g_bggd_m.bggd002
               LET gs_keys_bak[2] = g_bggd002_t
               LET gs_keys[3] = g_bggd_m.bggd003
               LET gs_keys_bak[3] = g_bggd003_t
               LET gs_keys[4] = g_bggd_m.bggd004
               LET gs_keys_bak[4] = g_bggd004_t
               LET gs_keys[5] = g_bggd_m.bggd005
               LET gs_keys_bak[5] = g_bggd005_t
               LET gs_keys[6] = g_bggd_d[g_detail_idx].bggd007
               LET gs_keys_bak[6] = g_bggd_d_t.bggd007
               LET gs_keys[7] = g_bggd_d[g_detail_idx].bggd008
               LET gs_keys_bak[7] = g_bggd_d_t.bggd008
               CALL abgi760_update_b('bggd_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_bggd_m),util.JSON.stringify(g_bggd_d_t)
                     LET g_log2 = util.JSON.stringify(g_bggd_m),util.JSON.stringify(g_bggd_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abgi760_bggd_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_bggd_m.bggd001
               LET ls_keys[ls_keys.getLength()+1] = g_bggd_m.bggd002
               LET ls_keys[ls_keys.getLength()+1] = g_bggd_m.bggd003
               LET ls_keys[ls_keys.getLength()+1] = g_bggd_m.bggd004
               LET ls_keys[ls_keys.getLength()+1] = g_bggd_m.bggd005
 
               LET ls_keys[ls_keys.getLength()+1] = g_bggd_d_t.bggd007
               LET ls_keys[ls_keys.getLength()+1] = g_bggd_d_t.bggd008
 
               CALL abgi760_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE abgi760_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bggd_d[l_ac].* = g_bggd_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE abgi760_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_bggd_d.getLength() = 0 THEN
               NEXT FIELD bggd007
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_bggd_d[li_reproduce_target].* = g_bggd_d[li_reproduce].*
               LET g_bggd2_d[li_reproduce_target].* = g_bggd2_d[li_reproduce].*
 
               LET g_bggd_d[li_reproduce_target].bggd007 = NULL
               LET g_bggd_d[li_reproduce_target].bggd008 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bggd_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bggd_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_bggd2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL abgi760_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL abgi760_idx_chk()
            CALL abgi760_ui_detailshow()
        
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
            NEXT FIELD bggd001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bggd007
               WHEN "s_detail2"
                  NEXT FIELD bggd007_2
 
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
 
{<section id="abgi760.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abgi760_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   #預算編號帶出預算週期,預算幣別
   SELECT bgaa002,bgaa003 
     INTO g_bggd_m.l_bgaa002,g_bggd_m.l_bgaa003
     FROM bgaa_t
    WHERE bgaa001 = g_bggd_m.bggd001
      AND bgaaent = g_enterprise               

    #預算週期的說明
    SELECT bgacl003 
      INTO g_bggd_m.l_bgaa002_desc
      FROM bgacl_t
     WHERE bgaclent = g_enterprise
       AND bgacl001 = g_bggd_m.l_bgaa002
       AND bgacl002 = g_dlang  
       
   #工資方案的說明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bggd_m.bggd003
   CALL ap_ref_array2(g_ref_fields,"SELECT bggbl004 FROM bggbl_t WHERE bggblent="||g_enterprise||" AND bggbl001=? AND bggbl002='0' AND bggbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bggd_m.bggd003_desc = '', g_rtn_fields[1] , ''
   
   #工資項目的說明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = 3401
   LET g_ref_fields[2] = g_bggd_m.bggd004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bggd_m.bggd004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_bggd_m.bggd004_desc
   
   #預算幣別的說明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bggd_m.l_bgaa003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bggd_m.l_bgaa003_desc = '', g_rtn_fields[1] , ''
       
   LET g_bggd_m_o.* = g_bggd_m.*
   CALL s_fin_abg_center_sons_query(g_bggd_m.bggd001,'','')
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL abgi760_b_fill(g_wc2) #第一階單身填充
      CALL abgi760_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abgi760_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_bggd_m.bggd001,g_bggd_m.bggd001_desc,g_bggd_m.bggd004,g_bggd_m.bggd004_desc,g_bggd_m.l_bgaa002, 
       g_bggd_m.l_bgaa002_desc,g_bggd_m.bggd002,g_bggd_m.bggd002_desc,g_bggd_m.bggd005,g_bggd_m.bggd005_desc, 
       g_bggd_m.l_bgaa003,g_bggd_m.l_bgaa003_desc,g_bggd_m.bggd003,g_bggd_m.bggd003_desc,g_bggd_m.bggd006 
 
 
   CALL abgi760_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="abgi760.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION abgi760_ref_show()
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
   FOR l_ac = 1 TO g_bggd_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_bggd2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="abgi760.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abgi760_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE bggd_t.bggd001 
   DEFINE l_oldno     LIKE bggd_t.bggd001 
   DEFINE l_newno02     LIKE bggd_t.bggd002 
   DEFINE l_oldno02     LIKE bggd_t.bggd002 
   DEFINE l_newno03     LIKE bggd_t.bggd003 
   DEFINE l_oldno03     LIKE bggd_t.bggd003 
   DEFINE l_newno04     LIKE bggd_t.bggd004 
   DEFINE l_oldno04     LIKE bggd_t.bggd004 
   DEFINE l_newno05     LIKE bggd_t.bggd005 
   DEFINE l_oldno05     LIKE bggd_t.bggd005 
 
   DEFINE l_master    RECORD LIKE bggd_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bggd_t.* #此變數樣板目前無使用
 
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
 
   IF g_bggd_m.bggd001 IS NULL
      OR g_bggd_m.bggd002 IS NULL
      OR g_bggd_m.bggd003 IS NULL
      OR g_bggd_m.bggd004 IS NULL
      OR g_bggd_m.bggd005 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_bggd001_t = g_bggd_m.bggd001
   LET g_bggd002_t = g_bggd_m.bggd002
   LET g_bggd003_t = g_bggd_m.bggd003
   LET g_bggd004_t = g_bggd_m.bggd004
   LET g_bggd005_t = g_bggd_m.bggd005
 
   
   LET g_bggd_m.bggd001 = ""
   LET g_bggd_m.bggd002 = ""
   LET g_bggd_m.bggd003 = ""
   LET g_bggd_m.bggd004 = ""
   LET g_bggd_m.bggd005 = ""
 
   LET g_master_insert = FALSE
   CALL abgi760_set_entry('a')
   CALL abgi760_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_bggd_m.bggd001_desc = ''
   DISPLAY BY NAME g_bggd_m.bggd001_desc
   LET g_bggd_m.bggd004_desc = ''
   DISPLAY BY NAME g_bggd_m.bggd004_desc
   LET g_bggd_m.bggd002_desc = ''
   DISPLAY BY NAME g_bggd_m.bggd002_desc
   LET g_bggd_m.bggd005_desc = ''
   DISPLAY BY NAME g_bggd_m.bggd005_desc
   LET g_bggd_m.bggd003_desc = ''
   DISPLAY BY NAME g_bggd_m.bggd003_desc
 
   
   CALL abgi760_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_bggd_m.* TO NULL
      INITIALIZE g_bggd_d TO NULL
      INITIALIZE g_bggd2_d TO NULL
 
      CALL abgi760_show()
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
   CALL abgi760_set_act_visible()
   CALL abgi760_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bggd001_t = g_bggd_m.bggd001
   LET g_bggd002_t = g_bggd_m.bggd002
   LET g_bggd003_t = g_bggd_m.bggd003
   LET g_bggd004_t = g_bggd_m.bggd004
   LET g_bggd005_t = g_bggd_m.bggd005
 
   
   #組合新增資料的條件
   LET g_add_browse = " bggdent = " ||g_enterprise|| " AND",
                      " bggd001 = '", g_bggd_m.bggd001, "' "
                      ," AND bggd002 = '", g_bggd_m.bggd002, "' "
                      ," AND bggd003 = '", g_bggd_m.bggd003, "' "
                      ," AND bggd004 = '", g_bggd_m.bggd004, "' "
                      ," AND bggd005 = '", g_bggd_m.bggd005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgi760_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL abgi760_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL abgi760_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="abgi760.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abgi760_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bggd_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abgi760_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bggd_t
    WHERE bggdent = g_enterprise AND bggd001 = g_bggd001_t
    AND bggd002 = g_bggd002_t
    AND bggd003 = g_bggd003_t
    AND bggd004 = g_bggd004_t
    AND bggd005 = g_bggd005_t
 
       INTO TEMP abgi760_detail
   
   #將key修正為調整後   
   UPDATE abgi760_detail 
      #更新key欄位
      SET bggd001 = g_bggd_m.bggd001
          , bggd002 = g_bggd_m.bggd002
          , bggd003 = g_bggd_m.bggd003
          , bggd004 = g_bggd_m.bggd004
          , bggd005 = g_bggd_m.bggd005
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , bggdownid = g_user 
       , bggdowndp = g_dept
       , bggdcrtid = g_user
       , bggdcrtdp = g_dept 
       , bggdcrtdt = ld_date
       , bggdmodid = g_user
       , bggdmoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO bggd_t SELECT * FROM abgi760_detail
   
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
   DROP TABLE abgi760_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bggd001_t = g_bggd_m.bggd001
   LET g_bggd002_t = g_bggd_m.bggd002
   LET g_bggd003_t = g_bggd_m.bggd003
   LET g_bggd004_t = g_bggd_m.bggd004
   LET g_bggd005_t = g_bggd_m.bggd005
 
   
   DROP TABLE abgi760_detail
   
END FUNCTION
 
{</section>}
 
{<section id="abgi760.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abgi760_delete()
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
   
   IF g_bggd_m.bggd001 IS NULL
   OR g_bggd_m.bggd002 IS NULL
   OR g_bggd_m.bggd003 IS NULL
   OR g_bggd_m.bggd004 IS NULL
   OR g_bggd_m.bggd005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN abgi760_cl USING g_enterprise,g_bggd_m.bggd001,g_bggd_m.bggd002,g_bggd_m.bggd003,g_bggd_m.bggd004,g_bggd_m.bggd005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgi760_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgi760_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgi760_master_referesh USING g_bggd_m.bggd001,g_bggd_m.bggd002,g_bggd_m.bggd003,g_bggd_m.bggd004, 
       g_bggd_m.bggd005 INTO g_bggd_m.bggd001,g_bggd_m.bggd004,g_bggd_m.bggd002,g_bggd_m.bggd005,g_bggd_m.bggd003, 
       g_bggd_m.bggd006,g_bggd_m.bggd001_desc,g_bggd_m.bggd002_desc,g_bggd_m.bggd005_desc,g_bggd_m.bggd003_desc 
 
   
   #遮罩相關處理
   LET g_bggd_m_mask_o.* =  g_bggd_m.*
   CALL abgi760_bggd_t_mask()
   LET g_bggd_m_mask_n.* =  g_bggd_m.*
   
   CALL abgi760_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgi760_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM bggd_t WHERE bggdent = g_enterprise AND bggd001 = g_bggd_m.bggd001
                                                               AND bggd002 = g_bggd_m.bggd002
                                                               AND bggd003 = g_bggd_m.bggd003
                                                               AND bggd004 = g_bggd_m.bggd004
                                                               AND bggd005 = g_bggd_m.bggd005
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bggd_t:",SQLERRMESSAGE 
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
      #   CLOSE abgi760_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_bggd_d.clear() 
      CALL g_bggd2_d.clear()       
 
     
      CALL abgi760_ui_browser_refresh()  
      #CALL abgi760_ui_headershow()  
      #CALL abgi760_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL abgi760_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL abgi760_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE abgi760_cl
 
   #功能已完成,通報訊息中心
   CALL abgi760_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abgi760.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgi760_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_bggd_d.clear()
   CALL g_bggd2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT bggd007,bggd008,bggd009,bggd010,bggd007,bggd008,bggdownid,bggdowndp, 
       bggdcrtid,bggdcrtdp,bggdcrtdt,bggdmodid,bggdmoddt,t1.bggal004 ,t2.bggal004 ,t3.ooag011 ,t4.ooefl003 , 
       t5.ooag011 ,t6.ooefl003 ,t7.ooag011 FROM bggd_t",   
               "",
               
                              " LEFT JOIN bggal_t t1 ON t1.bggalent="||g_enterprise||" AND t1.bggal001='abgi710' AND t1.bggal002=bggd007 AND t1.bggal003='"||g_dlang||"' ",
               " LEFT JOIN bggal_t t2 ON t2.bggalent="||g_enterprise||" AND t2.bggal001='abgi720' AND t2.bggal002=bggd008 AND t2.bggal003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=bggdownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=bggdowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=bggdcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=bggdcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=bggdmodid  ",
 
               " WHERE bggdent= ? AND bggd001=? AND bggd002=? AND bggd003=? AND bggd004=? AND bggd005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("bggd_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF abgi760_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY bggd_t.bggd007,bggd_t.bggd008"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abgi760_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abgi760_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bggd_m.bggd001,g_bggd_m.bggd002,g_bggd_m.bggd003,g_bggd_m.bggd004,g_bggd_m.bggd005   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bggd_m.bggd001,g_bggd_m.bggd002,g_bggd_m.bggd003,g_bggd_m.bggd004, 
          g_bggd_m.bggd005 INTO g_bggd_d[l_ac].bggd007,g_bggd_d[l_ac].bggd008,g_bggd_d[l_ac].bggd009, 
          g_bggd_d[l_ac].bggd010,g_bggd2_d[l_ac].bggd007,g_bggd2_d[l_ac].bggd008,g_bggd2_d[l_ac].bggdownid, 
          g_bggd2_d[l_ac].bggdowndp,g_bggd2_d[l_ac].bggdcrtid,g_bggd2_d[l_ac].bggdcrtdp,g_bggd2_d[l_ac].bggdcrtdt, 
          g_bggd2_d[l_ac].bggdmodid,g_bggd2_d[l_ac].bggdmoddt,g_bggd_d[l_ac].bggd007_desc,g_bggd_d[l_ac].bggd008_desc, 
          g_bggd2_d[l_ac].bggdownid_desc,g_bggd2_d[l_ac].bggdowndp_desc,g_bggd2_d[l_ac].bggdcrtid_desc, 
          g_bggd2_d[l_ac].bggdcrtdp_desc,g_bggd2_d[l_ac].bggdmodid_desc   #(ver:49)
                             
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
 
            CALL g_bggd_d.deleteElement(g_bggd_d.getLength())
      CALL g_bggd2_d.deleteElement(g_bggd2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bggd_d.getLength()
      LET g_bggd_d_mask_o[l_ac].* =  g_bggd_d[l_ac].*
      CALL abgi760_bggd_t_mask()
      LET g_bggd_d_mask_n[l_ac].* =  g_bggd_d[l_ac].*
   END FOR
   
   LET g_bggd2_d_mask_o.* =  g_bggd2_d.*
   FOR l_ac = 1 TO g_bggd2_d.getLength()
      LET g_bggd2_d_mask_o[l_ac].* =  g_bggd2_d[l_ac].*
      CALL abgi760_bggd_t_mask()
      LET g_bggd2_d_mask_n[l_ac].* =  g_bggd2_d[l_ac].*
   END FOR
 
 
   FREE abgi760_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="abgi760.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abgi760_idx_chk()
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
      IF g_detail_idx > g_bggd_d.getLength() THEN
         LET g_detail_idx = g_bggd_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_bggd_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bggd_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_bggd2_d.getLength() THEN
         LET g_detail_idx = g_bggd2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bggd2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bggd2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgi760.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgi760_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_bggd_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="abgi760.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION abgi760_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM bggd_t
    WHERE bggdent = g_enterprise AND bggd001 = g_bggd_m.bggd001 AND
                              bggd002 = g_bggd_m.bggd002 AND
                              bggd003 = g_bggd_m.bggd003 AND
                              bggd004 = g_bggd_m.bggd004 AND
                              bggd005 = g_bggd_m.bggd005 AND
 
          bggd007 = g_bggd_d_t.bggd007
      AND bggd008 = g_bggd_d_t.bggd008
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bggd_t:",SQLERRMESSAGE 
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
 
{<section id="abgi760.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abgi760_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="abgi760.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abgi760_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="abgi760.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abgi760_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="abgi760.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION abgi760_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_bggd_d[l_ac].bggd007 = g_bggd_d_t.bggd007 
      AND g_bggd_d[l_ac].bggd008 = g_bggd_d_t.bggd008 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgi760.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abgi760_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="abgi760.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abgi760_lock_b(ps_table,ps_page)
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
   #CALL abgi760_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgi760.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abgi760_unlock_b(ps_table,ps_page)
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
 
{<section id="abgi760.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abgi760_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bggd001,bggd002,bggd003,bggd004,bggd005",TRUE)
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
 
{<section id="abgi760.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abgi760_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bggd001,bggd002,bggd003,bggd004,bggd005",FALSE)
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
 
{<section id="abgi760.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abgi760_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgi760.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abgi760_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="abgi760.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abgi760_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgi760.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abgi760_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgi760.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abgi760_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgi760.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abgi760_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgi760.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abgi760_default_search()
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
      LET ls_wc = ls_wc, " bggd001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bggd002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bggd003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " bggd004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " bggd005 = '", g_argv[05], "' AND "
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
 
{<section id="abgi760.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abgi760_fill_chk(ps_idx)
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
 
{<section id="abgi760.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION abgi760_modify_detail_chk(ps_record)
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
         LET ls_return = "bggd007"
      WHEN "s_detail2"
         LET ls_return = "bggd007_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="abgi760.mask_functions" >}
&include "erp/abg/abgi760_mask.4gl"
 
{</section>}
 
{<section id="abgi760.state_change" >}
    
 
{</section>}
 
{<section id="abgi760.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abgi760_set_pk_array()
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
   LET g_pk_array[1].values = g_bggd_m.bggd001
   LET g_pk_array[1].column = 'bggd001'
   LET g_pk_array[2].values = g_bggd_m.bggd002
   LET g_pk_array[2].column = 'bggd002'
   LET g_pk_array[3].values = g_bggd_m.bggd003
   LET g_pk_array[3].column = 'bggd003'
   LET g_pk_array[4].values = g_bggd_m.bggd004
   LET g_pk_array[4].column = 'bggd004'
   LET g_pk_array[5].values = g_bggd_m.bggd005
   LET g_pk_array[5].column = 'bggd005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgi760.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abgi760_msgcentre_notify(lc_state)
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
   CALL abgi760_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bggd_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgi760.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預算組織檢核
# Usage..........: CALL abgi750_chk_bggd002(p_bggd002)
#                  RETURNING r_success,r_errno
# Input parameter: p_bggd002 預算組織
# Return code....: r_success 檢核成功否
#                : r_errno 錯誤訊息代碼
# Date & Author..: #140306-00006 2016/10/26 By TSD.Chiu
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi750_chk_bggd002(p_bggd002)
   DEFINE p_bggd002   LIKE bggd_t.bggd002
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_ooef      RECORD
                      ooef205  LIKE ooef_t.ooef205,
                      ooefstus LIKE ooef_t.ooefstus
                      END RECORD

   LET r_success = TRUE
   LET r_errno   = ''
   INITIALIZE l_ooef.* TO NULL
   SELECT ooef205,ooefstus
     INTO l_ooef.*
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_bggd002

   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_success = FALSE
         LET r_errno = 'aoo-00094'
      WHEN l_ooef.ooefstus <> 'Y'
         LET r_success = FALSE
         LET r_errno = 'apm-00249'
      WHEN l_ooef.ooef205 <> 'Y'
         LET r_success = FALSE
         LET r_errno = 'axm-00159'
   END CASE

   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 檢核工資方案
# Memo...........:
# Usage..........: CALL abgi760_chk_bggd003(p_bggd003)
# Date & Author..: #140306-00006 2016/10/28 By TSD.Chiu
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi760_chk_bggd003(p_bggd003)
   DEFINE p_bggd003 LIKE bggc_t.bggc003
   
   LET g_errno=NULL
   SELECT 1
     FROM bggb_t
    WHERE bggbent=g_enterprise
      AND bggb001=p_bggd003
   CASE
      WHEN SQLCA.sqlcode=100 LET g_errno='abg-00197'
      OTHERWISE EXIT CASE
   END CASE         
END FUNCTION

################################################################################
# Descriptions...: 檢核職級職等用工屬性
# Memo...........:
# Usage..........: CALL abgi760_chk_abgi710s(p_bgga001,p_bgga002)
# Input parameter: p_bgga001      作業編號
#                  p_bgga002      代碼
# Date & Author..: #140306-00006 2016/10/28 By TSD.Chiu
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi760_chk_abgi710s(p_bgga001,p_bgga002)
   DEFINE p_bgga001  LIKE bgga_t.bgga001
   DEFINE p_bgga002  LIKE bgga_t.bgga002
   DEFINE l_bggastus LIKE bgga_t.bggastus
   
   LET g_errno=NULL
   LET l_bggastus=NULL
   SELECT bggastus
     INTO l_bggastus
     FROM bgga_t
    WHERE bggaent=g_enterprise
      AND bgga001=p_bgga001
      AND bgga002=p_bgga002
   CASE
      WHEN SQLCA.sqlcode=100 AND p_bgga001='abgi710'  LET g_errno='abg-00192' 
      WHEN SQLCA.sqlcode=100 AND p_bgga001='abgi720'  LET g_errno='abg-00193' 
      WHEN SQLCA.sqlcode=100 AND p_bgga001='abgi730'  LET g_errno='abg-00194' 
      WHEN l_bggastus<>'Y' LET g_errno='aoo-00004'
      OTHERWISE 
         LET g_errno=SQLCA.sqlcode USING '---------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 幣別檢核
# Memo...........:
# Usage..........: CALL abgi760_chk_bggd009()
# Date & Author..: #140306-00006 2016/10/28 By TSD.Chiu
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi760_chk_bggd009()
   DEFINE l_ooaistus LIKE ooai_t.ooaistus
   DEFINE l_ooef014  LIKE ooef_t.ooef014  
   
   LET l_ooef014=NULL
   SELECT ooef014
     INTO l_ooef014
     FROM ooef_t
    WHERE ooefent=g_enterprise
      AND ooef001=g_bggd_m.bggd002
      
   LET g_errno=NULL
   SELECT ooaistus
     INTO l_ooaistus
     FROM ooai_t,ooaj_t
    WHERE ooaient=ooajent
      AND ooai001=ooaj002
      AND ooaient=g_enterprise
      AND ooaj001=l_ooef014
      AND ooai001=g_bggd_d[l_ac].bggd009
   CASE
      WHEN SQLCA.sqlcode=100 LET g_errno='aoo-00066'
      WHEN l_ooaistus<>'Y'   LET g_errno='aoo-00004'
      OTHERWISE 
         LET g_errno=SQLCA.sqlcode USING '---------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 檢核工資項目+編號合理性
# Memo...........:
# Usage..........: CALL abgi760_chk_bggd004(p_bggd003,p_bggd004)
# Input parameter: p_bggd003 工資方案
#                : p_bggd004 工資項目 
# Date & Author..: #140306-00006 2016/10/28 By TSD.Chiu
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi760_chk_bggd004(p_bggd003,p_bggd004)
   DEFINE p_bggd003 LIKE bggd_t.bggd003
   DEFINE p_bggd004 LIKE bggd_t.bggd004
   DEFINE l_bggb003 LIKE bggb_t.bggb003
   
   LET g_errno=NULL
   LET l_bggb003=NULL
   SELECT bggb003
     INTO l_bggb003
     FROM bggb_t
    WHERE bggbent=g_enterprise
      AND bggb001=p_bggd003
      AND bggb002=p_bggd004
   CASE
      WHEN SQLCA.sqlcode=100 LET g_errno='abg-00196'
      WHEN l_bggb003<>'1'    LET g_errno='abg-00195'
      OTHERWISE 
         LET g_errno=SQLCA.sqlcode USING '---------'
   END CASE 
END FUNCTION

 
{</section>}
 