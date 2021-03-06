#該程式未解開Section, 採用最新樣板產出!
{<section id="axci120.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2015-08-07 16:39:49), PR版次:0010(2016-05-03 20:02:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000301
#+ Filename...: axci120
#+ Description: 料件成本基礎資料維護作業
#+ Creator....: 02299(2013-10-22 17:51:18)
#+ Modifier...: 03297 -SD/PR- 00593
 
{</section>}
 
{<section id="axci120.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160413-00028#1   2016/04/14  By xianghui 当年度条件下2开头的，就会组出xcbb001=2XXX，这样满足1=2就不会找到资料了
#160318-00025#40  2016/04/22  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160503-00030#1   2016/05/03  By Sarah    當客戶單身資料有54萬筆時,從查詢到顯示出資料需要將近10分鐘,需做效能優化
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
PRIVATE type type_g_xcbb_m        RECORD
       xcbbcomp LIKE xcbb_t.xcbbcomp, 
   xcbbcomp_desc LIKE type_t.chr80, 
   xcbb001 LIKE xcbb_t.xcbb001, 
   xcbb002 LIKE xcbb_t.xcbb002
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcbb_d        RECORD
       xcbbstus LIKE xcbb_t.xcbbstus, 
   xcbb003 LIKE xcbb_t.xcbb003, 
   xcbb003_desc LIKE type_t.chr500, 
   xcbb003_desc_1 LIKE type_t.chr500, 
   xcbb004 LIKE xcbb_t.xcbb004, 
   xcbb005 LIKE xcbb_t.xcbb005, 
   xcbb005_desc LIKE type_t.chr500, 
   xcbb012 LIKE xcbb_t.xcbb012, 
   xcbb012_desc LIKE type_t.chr500, 
   xcbb006 LIKE xcbb_t.xcbb006, 
   xcbb008 LIKE xcbb_t.xcbb008, 
   xcbb007 LIKE xcbb_t.xcbb007, 
   xcbb010 LIKE xcbb_t.xcbb010, 
   xcbb010_desc LIKE type_t.chr500, 
   xcbb009 LIKE xcbb_t.xcbb009
       END RECORD
PRIVATE TYPE type_g_xcbb2_d RECORD
       xcbb003 LIKE xcbb_t.xcbb003, 
   xcbb004 LIKE xcbb_t.xcbb004, 
   xcbbownid LIKE xcbb_t.xcbbownid, 
   xcbbownid_desc LIKE type_t.chr500, 
   xcbbowndp LIKE xcbb_t.xcbbowndp, 
   xcbbowndp_desc LIKE type_t.chr500, 
   xcbbcrtid LIKE xcbb_t.xcbbcrtid, 
   xcbbcrtid_desc LIKE type_t.chr500, 
   xcbbcrtdp LIKE xcbb_t.xcbbcrtdp, 
   xcbbcrtdp_desc LIKE type_t.chr500, 
   xcbbcrtdt DATETIME YEAR TO SECOND, 
   xcbbmodid LIKE xcbb_t.xcbbmodid, 
   xcbbmodid_desc LIKE type_t.chr500, 
   xcbbmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xcbb_m          type_g_xcbb_m
DEFINE g_xcbb_m_t        type_g_xcbb_m
DEFINE g_xcbb_m_o        type_g_xcbb_m
DEFINE g_xcbb_m_mask_o   type_g_xcbb_m #轉換遮罩前資料
DEFINE g_xcbb_m_mask_n   type_g_xcbb_m #轉換遮罩後資料
 
   DEFINE g_xcbbcomp_t LIKE xcbb_t.xcbbcomp
DEFINE g_xcbb001_t LIKE xcbb_t.xcbb001
DEFINE g_xcbb002_t LIKE xcbb_t.xcbb002
 
 
DEFINE g_xcbb_d          DYNAMIC ARRAY OF type_g_xcbb_d
DEFINE g_xcbb_d_t        type_g_xcbb_d
DEFINE g_xcbb_d_o        type_g_xcbb_d
DEFINE g_xcbb_d_mask_o   DYNAMIC ARRAY OF type_g_xcbb_d #轉換遮罩前資料
DEFINE g_xcbb_d_mask_n   DYNAMIC ARRAY OF type_g_xcbb_d #轉換遮罩後資料
DEFINE g_xcbb2_d   DYNAMIC ARRAY OF type_g_xcbb2_d
DEFINE g_xcbb2_d_t type_g_xcbb2_d
DEFINE g_xcbb2_d_o type_g_xcbb2_d
DEFINE g_xcbb2_d_mask_o   DYNAMIC ARRAY OF type_g_xcbb2_d #轉換遮罩前資料
DEFINE g_xcbb2_d_mask_n   DYNAMIC ARRAY OF type_g_xcbb2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcbbcomp LIKE xcbb_t.xcbbcomp,
      b_xcbb001 LIKE xcbb_t.xcbb001,
      b_xcbb002 LIKE xcbb_t.xcbb002
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
 
{<section id="axci120.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xcbbcomp,'',xcbb001,xcbb002", 
                      " FROM xcbb_t",
                      " WHERE xcbbent= ? AND xcbbcomp=? AND xcbb001=? AND xcbb002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axci120_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xcbbcomp,t0.xcbb001,t0.xcbb002,t1.ooefl003",
               " FROM xcbb_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xcbbcomp AND t1.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.xcbbent = " ||g_enterprise|| " AND t0.xcbbcomp = ? AND t0.xcbb001 = ? AND t0.xcbb002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axci120_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axci120 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axci120_init()   
 
      #進入選單 Menu (="N")
      CALL axci120_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axci120
      
   END IF 
   
   CLOSE axci120_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axci120.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axci120_init()
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
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'N' THEN
      CALL cl_set_comp_visible('xcbb004',FALSE)
   END IF
   #end add-point
   
   CALL axci120_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axci120.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axci120_ui_dialog()
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
         INITIALIZE g_xcbb_m.* TO NULL
         CALL g_xcbb_d.clear()
         CALL g_xcbb2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axci120_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcbb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axci120_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axci120_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_xcbb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axci120_idx_chk()
               CALL axci120_ui_detailshow()
               
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
            CALL axci120_browser_fill("")
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
               CALL axci120_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axci120_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axci120_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci120_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axci120_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci120_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axci120_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci120_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axci120_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci120_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axci120_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci120_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcbb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xcbb2_d)
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
               NEXT FIELD xcbb003
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
               CALL axci120_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axci120_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axci120_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axci120_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axci120_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axci120_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axci120_insert()
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axci120_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axci120_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axci120_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axci120_set_pk_array()
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
 
{<section id="axci120.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axci120_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axci120.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axci120_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "xcbbcomp,xcbb001,xcbb002"
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
      LET l_sub_sql = " SELECT DISTINCT xcbbcomp ",
                      ", xcbb001 ",
                      ", xcbb002 ",
 
                      " FROM xcbb_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xcbbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcbb_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcbbcomp ",
                      ", xcbb001 ",
                      ", xcbb002 ",
 
                      " FROM xcbb_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xcbbent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcbb_t")
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
      INITIALIZE g_xcbb_m.* TO NULL
      CALL g_xcbb_d.clear()        
      CALL g_xcbb2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcbbcomp,t0.xcbb001,t0.xcbb002 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcbbcomp,t0.xcbb001,t0.xcbb002",
                " FROM xcbb_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xcbbent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcbb_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcbb_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xcbbcomp,g_browser[g_cnt].b_xcbb001,g_browser[g_cnt].b_xcbb002  
 
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
   
   IF cl_null(g_browser[g_cnt].b_xcbbcomp) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcbb_m.* TO NULL
      CALL g_xcbb_d.clear()
      CALL g_xcbb2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axci120_fetch('')
   
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
 
{<section id="axci120.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axci120_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcbb_m.xcbbcomp = g_browser[g_current_idx].b_xcbbcomp   
   LET g_xcbb_m.xcbb001 = g_browser[g_current_idx].b_xcbb001   
   LET g_xcbb_m.xcbb002 = g_browser[g_current_idx].b_xcbb002   
 
   EXECUTE axci120_master_referesh USING g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002 INTO g_xcbb_m.xcbbcomp, 
       g_xcbb_m.xcbb001,g_xcbb_m.xcbb002,g_xcbb_m.xcbbcomp_desc
   CALL axci120_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axci120.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axci120_ui_detailshow()
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
 
{<section id="axci120.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axci120_ui_browser_refresh()
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
      IF g_browser[l_i].b_xcbbcomp = g_xcbb_m.xcbbcomp 
         AND g_browser[l_i].b_xcbb001 = g_xcbb_m.xcbb001 
         AND g_browser[l_i].b_xcbb002 = g_xcbb_m.xcbb002 
 
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
 
{<section id="axci120.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axci120_construct()
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
   INITIALIZE g_xcbb_m.* TO NULL
   CALL g_xcbb_d.clear()
   CALL g_xcbb2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
 
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcbbcomp,xcbb001,xcbb002
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            CALL axci120_head_default() #dorislai-20151022-add
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbbcomp
            #add-point:BEFORE FIELD xcbbcomp name="construct.b.xcbbcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbbcomp
            
            #add-point:AFTER FIELD xcbbcomp name="construct.a.xcbbcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbbcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbbcomp
            #add-point:ON ACTION controlp INFIELD xcbbcomp name="construct.c.xcbbcomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbbcomp  #顯示到畫面上
            NEXT FIELD xcbbcomp                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb001
            #add-point:BEFORE FIELD xcbb001 name="construct.b.xcbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb001
            
            #add-point:AFTER FIELD xcbb001 name="construct.a.xcbb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb001
            #add-point:ON ACTION controlp INFIELD xcbb001 name="construct.c.xcbb001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb002
            #add-point:BEFORE FIELD xcbb002 name="construct.b.xcbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb002
            
            #add-point:AFTER FIELD xcbb002 name="construct.a.xcbb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb002
            #add-point:ON ACTION controlp INFIELD xcbb002 name="construct.c.xcbb002"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xcbbstus,xcbb003,xcbb003_desc,xcbb003_desc_1,xcbb004,xcbb005,xcbb012, 
          xcbb006,xcbb008,xcbb007,xcbb010,xcbb009,xcbbownid,xcbbowndp,xcbbcrtid,xcbbcrtdp,xcbbcrtdt, 
          xcbbmodid,xcbbmoddt
           FROM s_detail1[1].xcbbstus,s_detail1[1].xcbb003,s_detail1[1].xcbb003_desc,s_detail1[1].xcbb003_desc_1, 
               s_detail1[1].xcbb004,s_detail1[1].xcbb005,s_detail1[1].xcbb012,s_detail1[1].xcbb006,s_detail1[1].xcbb008, 
               s_detail1[1].xcbb007,s_detail1[1].xcbb010,s_detail1[1].xcbb009,s_detail2[1].xcbbownid, 
               s_detail2[1].xcbbowndp,s_detail2[1].xcbbcrtid,s_detail2[1].xcbbcrtdp,s_detail2[1].xcbbcrtdt, 
               s_detail2[1].xcbbmodid,s_detail2[1].xcbbmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xcbbcrtdt>>----
         AFTER FIELD xcbbcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xcbbmoddt>>----
         AFTER FIELD xcbbmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xcbbcnfdt>>----
         
         #----<<xcbbpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbbstus
            #add-point:BEFORE FIELD xcbbstus name="construct.b.page1.xcbbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbbstus
            
            #add-point:AFTER FIELD xcbbstus name="construct.a.page1.xcbbstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbbstus
            #add-point:ON ACTION controlp INFIELD xcbbstus name="construct.c.page1.xcbbstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb003
            #add-point:ON ACTION controlp INFIELD xcbb003 name="construct.c.page1.xcbb003"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaa001_11()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbb003  #顯示到畫面上

            NEXT FIELD xcbb003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb003
            #add-point:BEFORE FIELD xcbb003 name="construct.b.page1.xcbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb003
            
            #add-point:AFTER FIELD xcbb003 name="construct.a.page1.xcbb003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb003_desc
            #add-point:BEFORE FIELD xcbb003_desc name="construct.b.page1.xcbb003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb003_desc
            
            #add-point:AFTER FIELD xcbb003_desc name="construct.a.page1.xcbb003_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbb003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb003_desc
            #add-point:ON ACTION controlp INFIELD xcbb003_desc name="construct.c.page1.xcbb003_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb003_desc_1
            #add-point:BEFORE FIELD xcbb003_desc_1 name="construct.b.page1.xcbb003_desc_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb003_desc_1
            
            #add-point:AFTER FIELD xcbb003_desc_1 name="construct.a.page1.xcbb003_desc_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbb003_desc_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb003_desc_1
            #add-point:ON ACTION controlp INFIELD xcbb003_desc_1 name="construct.c.page1.xcbb003_desc_1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb004
            #add-point:ON ACTION controlp INFIELD xcbb004 name="construct.c.page1.xcbb004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            #CALL q_imaa006()                           #呼叫開窗  #fengmy150807 mark
            CALL q_xcbb004()                   #fengmy150807
            DISPLAY g_qryparam.return1 TO xcbb004  #顯示到畫面上

            NEXT FIELD xcbb004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb004
            #add-point:BEFORE FIELD xcbb004 name="construct.b.page1.xcbb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb004
            
            #add-point:AFTER FIELD xcbb004 name="construct.a.page1.xcbb004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb005
            #add-point:BEFORE FIELD xcbb005 name="construct.b.page1.xcbb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb005
            
            #add-point:AFTER FIELD xcbb005 name="construct.a.page1.xcbb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb005
            #add-point:ON ACTION controlp INFIELD xcbb005 name="construct.c.page1.xcbb005"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbb005  #顯示到畫面上

            NEXT FIELD xcbb005                     #返回原欄位


            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcbb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb012
            #add-point:ON ACTION controlp INFIELD xcbb012 name="construct.c.page1.xcbb012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbb012  #顯示到畫面上
            NEXT FIELD xcbb012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb012
            #add-point:BEFORE FIELD xcbb012 name="construct.b.page1.xcbb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb012
            
            #add-point:AFTER FIELD xcbb012 name="construct.a.page1.xcbb012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb006
            #add-point:BEFORE FIELD xcbb006 name="construct.b.page1.xcbb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb006
            
            #add-point:AFTER FIELD xcbb006 name="construct.a.page1.xcbb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb006
            #add-point:ON ACTION controlp INFIELD xcbb006 name="construct.c.page1.xcbb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb008
            #add-point:BEFORE FIELD xcbb008 name="construct.b.page1.xcbb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb008
            
            #add-point:AFTER FIELD xcbb008 name="construct.a.page1.xcbb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb008
            #add-point:ON ACTION controlp INFIELD xcbb008 name="construct.c.page1.xcbb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb007
            #add-point:BEFORE FIELD xcbb007 name="construct.b.page1.xcbb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb007
            
            #add-point:AFTER FIELD xcbb007 name="construct.a.page1.xcbb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb007
            #add-point:ON ACTION controlp INFIELD xcbb007 name="construct.c.page1.xcbb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb010
            #add-point:BEFORE FIELD xcbb010 name="construct.b.page1.xcbb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb010
            
            #add-point:AFTER FIELD xcbb010 name="construct.a.page1.xcbb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb010
            #add-point:ON ACTION controlp INFIELD xcbb010 name="construct.c.page1.xcbb010"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "206" #

            CALL q_oocq002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbb010  #顯示到畫面上

            NEXT FIELD xcbb010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb009
            #add-point:BEFORE FIELD xcbb009 name="construct.b.page1.xcbb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb009
            
            #add-point:AFTER FIELD xcbb009 name="construct.a.page1.xcbb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb009
            #add-point:ON ACTION controlp INFIELD xcbb009 name="construct.c.page1.xcbb009"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '206'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbb009  #顯示到畫面上

            NEXT FIELD xcbb009                     #返回原欄位


            #END add-point
 
 
         #Ctrlp:construct.c.page2.xcbbownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbbownid
            #add-point:ON ACTION controlp INFIELD xcbbownid name="construct.c.page2.xcbbownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbbownid  #顯示到畫面上

            NEXT FIELD xcbbownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbbownid
            #add-point:BEFORE FIELD xcbbownid name="construct.b.page2.xcbbownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbbownid
            
            #add-point:AFTER FIELD xcbbownid name="construct.a.page2.xcbbownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcbbowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbbowndp
            #add-point:ON ACTION controlp INFIELD xcbbowndp name="construct.c.page2.xcbbowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbbowndp  #顯示到畫面上

            NEXT FIELD xcbbowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbbowndp
            #add-point:BEFORE FIELD xcbbowndp name="construct.b.page2.xcbbowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbbowndp
            
            #add-point:AFTER FIELD xcbbowndp name="construct.a.page2.xcbbowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcbbcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbbcrtid
            #add-point:ON ACTION controlp INFIELD xcbbcrtid name="construct.c.page2.xcbbcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbbcrtid  #顯示到畫面上

            NEXT FIELD xcbbcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbbcrtid
            #add-point:BEFORE FIELD xcbbcrtid name="construct.b.page2.xcbbcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbbcrtid
            
            #add-point:AFTER FIELD xcbbcrtid name="construct.a.page2.xcbbcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcbbcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbbcrtdp
            #add-point:ON ACTION controlp INFIELD xcbbcrtdp name="construct.c.page2.xcbbcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbbcrtdp  #顯示到畫面上

            NEXT FIELD xcbbcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbbcrtdp
            #add-point:BEFORE FIELD xcbbcrtdp name="construct.b.page2.xcbbcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbbcrtdp
            
            #add-point:AFTER FIELD xcbbcrtdp name="construct.a.page2.xcbbcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbbcrtdt
            #add-point:BEFORE FIELD xcbbcrtdt name="construct.b.page2.xcbbcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xcbbmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbbmodid
            #add-point:ON ACTION controlp INFIELD xcbbmodid name="construct.c.page2.xcbbmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbbmodid  #顯示到畫面上

            NEXT FIELD xcbbmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbbmodid
            #add-point:BEFORE FIELD xcbbmodid name="construct.b.page2.xcbbmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbbmodid
            
            #add-point:AFTER FIELD xcbbmodid name="construct.a.page2.xcbbmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbbmoddt
            #add-point:BEFORE FIELD xcbbmoddt name="construct.b.page2.xcbbmoddt"
            
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
   LET g_wc = cl_replace_str(g_wc,'xcbb001=','xcbb001 =')   #160413-00028#1
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
 
{<section id="axci120.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axci120_query()
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
   CALL g_xcbb_d.clear()
   CALL g_xcbb2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axci120_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axci120_browser_fill(g_wc)
      CALL axci120_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axci120_browser_fill("F")
   
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
      CALL axci120_fetch("F") 
   END IF
   
   CALL axci120_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axci120.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axci120_fetch(p_flag)
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
   
   #CALL axci120_browser_fill(p_flag)
   
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
   
   LET g_xcbb_m.xcbbcomp = g_browser[g_current_idx].b_xcbbcomp
   LET g_xcbb_m.xcbb001 = g_browser[g_current_idx].b_xcbb001
   LET g_xcbb_m.xcbb002 = g_browser[g_current_idx].b_xcbb002
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axci120_master_referesh USING g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002 INTO g_xcbb_m.xcbbcomp, 
       g_xcbb_m.xcbb001,g_xcbb_m.xcbb002,g_xcbb_m.xcbbcomp_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcbb_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcbb_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcbb_m_mask_o.* =  g_xcbb_m.*
   CALL axci120_xcbb_t_mask()
   LET g_xcbb_m_mask_n.* =  g_xcbb_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axci120_set_act_visible()
   CALL axci120_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xcbb_m_t.* = g_xcbb_m.*
   LET g_xcbb_m_o.* = g_xcbb_m.*
   
   #重新顯示   
   CALL axci120_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axci120.insert" >}
#+ 資料新增
PRIVATE FUNCTION axci120_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
 
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcbb_d.clear()
   CALL g_xcbb2_d.clear()
 
 
   INITIALIZE g_xcbb_m.* TO NULL             #DEFAULT 設定
   LET g_xcbbcomp_t = NULL
   LET g_xcbb001_t = NULL
   LET g_xcbb002_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      CALL axci120_head_default() #dorislai-20151022-add
      #end add-point 
 
      CALL axci120_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcbb_m.* TO NULL
         INITIALIZE g_xcbb_d TO NULL
         INITIALIZE g_xcbb2_d TO NULL
 
         CALL axci120_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcbb_m.* = g_xcbb_m_t.*
         CALL axci120_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xcbb_d.clear()
      #CALL g_xcbb2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axci120_set_act_visible()
   CALL axci120_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcbbcomp_t = g_xcbb_m.xcbbcomp
   LET g_xcbb001_t = g_xcbb_m.xcbb001
   LET g_xcbb002_t = g_xcbb_m.xcbb002
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcbbent = " ||g_enterprise|| " AND",
                      " xcbbcomp = '", g_xcbb_m.xcbbcomp, "' "
                      ," AND xcbb001 = '", g_xcbb_m.xcbb001, "' "
                      ," AND xcbb002 = '", g_xcbb_m.xcbb002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axci120_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axci120_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axci120_master_referesh USING g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002 INTO g_xcbb_m.xcbbcomp, 
       g_xcbb_m.xcbb001,g_xcbb_m.xcbb002,g_xcbb_m.xcbbcomp_desc
   
   #遮罩相關處理
   LET g_xcbb_m_mask_o.* =  g_xcbb_m.*
   CALL axci120_xcbb_t_mask()
   LET g_xcbb_m_mask_n.* =  g_xcbb_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcbb_m.xcbbcomp,g_xcbb_m.xcbbcomp_desc,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002
   
   #功能已完成,通報訊息中心
   CALL axci120_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axci120.modify" >}
#+ 資料修改
PRIVATE FUNCTION axci120_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xcbb_m.xcbbcomp IS NULL
   OR g_xcbb_m.xcbb001 IS NULL
   OR g_xcbb_m.xcbb002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xcbbcomp_t = g_xcbb_m.xcbbcomp
   LET g_xcbb001_t = g_xcbb_m.xcbb001
   LET g_xcbb002_t = g_xcbb_m.xcbb002
 
   CALL s_transaction_begin()
   
   OPEN axci120_cl USING g_enterprise,g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axci120_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axci120_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axci120_master_referesh USING g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002 INTO g_xcbb_m.xcbbcomp, 
       g_xcbb_m.xcbb001,g_xcbb_m.xcbb002,g_xcbb_m.xcbbcomp_desc
   
   #遮罩相關處理
   LET g_xcbb_m_mask_o.* =  g_xcbb_m.*
   CALL axci120_xcbb_t_mask()
   LET g_xcbb_m_mask_n.* =  g_xcbb_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axci120_show()
   WHILE TRUE
      LET g_xcbbcomp_t = g_xcbb_m.xcbbcomp
      LET g_xcbb001_t = g_xcbb_m.xcbb001
      LET g_xcbb002_t = g_xcbb_m.xcbb002
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axci120_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcbb_m.* = g_xcbb_m_t.*
         CALL axci120_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcbb_m.xcbbcomp != g_xcbbcomp_t 
      OR g_xcbb_m.xcbb001 != g_xcbb001_t 
      OR g_xcbb_m.xcbb002 != g_xcbb002_t 
 
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
   CALL axci120_set_act_visible()
   CALL axci120_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcbbent = " ||g_enterprise|| " AND",
                      " xcbbcomp = '", g_xcbb_m.xcbbcomp, "' "
                      ," AND xcbb001 = '", g_xcbb_m.xcbb001, "' "
                      ," AND xcbb002 = '", g_xcbb_m.xcbb002, "' "
 
   #填到對應位置
   CALL axci120_browser_fill("")
 
   CALL axci120_idx_chk()
 
   CLOSE axci120_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axci120_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axci120.input" >}
#+ 資料輸入
PRIVATE FUNCTION axci120_input(p_cmd)
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
   DEFINE  l_count1        LIKE type_t.num5
   DEFINE  l_ooea003       LIKE ooea_t.ooea003
   DEFINE  l_xcbbcomp      LIKE xcbb_t.xcbbcomp
   DEFINE  l_xcbb003       LIKE xcbb_t.xcbb003
   DEFINE  l_xcbb005       LIKE xcbb_t.xcbb005
   DEFINE  l_xcbb006       LIKE xcbb_t.xcbb006
   DEFINE  l_xcbb009       LIKE xcbb_t.xcbb009
   DEFINE  l_xcbb001       LIKE xcbb_t.xcbb001
   DEFINE  l_xcbb002       LIKE xcbb_t.xcbb002
   DEFINE  l_ooeastus      LIKE ooea_t.ooeastus
   DEFINE  l_imafstus      LIKE imaf_t.imafstus
   DEFINE  l_oocqstus      LIKE oocq_t.oocqstus
   DEFINE  l_xcbb010       LIKE xcbb_t.xcbb010
   DEFINE  l_xcaxstus      LIKE xcax_t.xcaxstus
   DEFINE  l_glav006       LIKE glav_t.glav006
   DEFINE  l_imagstus      LIKE imag_t.imagstus
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
   DISPLAY BY NAME g_xcbb_m.xcbbcomp,g_xcbb_m.xcbbcomp_desc,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002
   
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
   LET g_forupd_sql = "SELECT xcbbstus,xcbb003,xcbb004,xcbb005,xcbb012,xcbb006,xcbb008,xcbb007,xcbb010, 
       xcbb009,xcbb003,xcbb004,xcbbownid,xcbbowndp,xcbbcrtid,xcbbcrtdp,xcbbcrtdt,xcbbmodid,xcbbmoddt  
       FROM xcbb_t WHERE xcbbent=? AND xcbbcomp=? AND xcbb001=? AND xcbb002=? AND xcbb003=? AND xcbb004=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axci120_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axci120_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axci120_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   LET l_allow_delete = FALSE    #这只不允许删除单身
   #end add-point
 
   DISPLAY BY NAME g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axci120.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002 
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
         AFTER FIELD xcbbcomp
            
            #add-point:AFTER FIELD xcbbcomp name="input.a.xcbbcomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcbb_m.xcbbcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcbb_m.xcbbcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcbb_m.xcbbcomp_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcbb_m.xcbbcomp) AND NOT cl_null(g_xcbb_m.xcbb001) AND NOT cl_null(g_xcbb_m.xcbb002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcbb_m.xcbbcomp != g_xcbbcomp_t  OR g_xcbb_m.xcbb001 != g_xcbb001_t  OR g_xcbb_m.xcbb002 != g_xcbb002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbb_t WHERE "||"xcbbent = '" ||g_enterprise|| "' AND "||"xcbbcomp = '"||g_xcbb_m.xcbbcomp ||"' AND "|| "xcbb001 = '"||g_xcbb_m.xcbb001 ||"' AND "|| "xcbb002 = '"||g_xcbb_m.xcbb002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbbcomp
            #add-point:BEFORE FIELD xcbbcomp name="input.b.xcbbcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbbcomp
            #add-point:ON CHANGE xcbbcomp name="input.g.xcbbcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb001
            #add-point:BEFORE FIELD xcbb001 name="input.b.xcbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb001
            
            #add-point:AFTER FIELD xcbb001 name="input.a.xcbb001"
            #IF g_xcbb_m.xcbb001 IS NOT NULL THEN
            #   IF p_cmd = 'a' OR (p_cmd = 'u' AND g_xcbb_m.xcbb001 != g_xcbb_m_t.xcbb001) THEN
            #      IF NOT axci120_chk_year_month() THEN
            #         LET g_xcbb_m.xcbb001 = g_xcbb_m_t.xcbb001
            #         NEXT FIELD CURRENT
            #      END IF
            #      IF NOT axci120_chk_head_key() THEN
            #         LET g_xcbb_m.xcbb001 = g_xcbb_m_t.xcbb001
            #         NEXT FIELD CURRENT
            #      END IF                  
            #   END IF
            #END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb001
            #add-point:ON CHANGE xcbb001 name="input.g.xcbb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb002
            #add-point:BEFORE FIELD xcbb002 name="input.b.xcbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb002
            
            #add-point:AFTER FIELD xcbb002 name="input.a.xcbb002"
            #此段落由子樣板a05產生
            #IF g_xcbb_m.xcbb002 IS NOT NULL THEN
            #   IF p_cmd = 'a' OR (p_cmd = 'u' AND g_xcbb_m.xcbb002 != g_xcbb_m_t.xcbb002) THEN
            #      IF NOT axci120_chk_year_month() THEN
            #         LET g_xcbb_m.xcbb002 = g_xcbb_m_t.xcbb002
            #         NEXT FIELD CURRENT
            #      END IF
            #      IF NOT axci120_chk_head_key() THEN
            #         LET g_xcbb_m.xcbb002 = g_xcbb_m_t.xcbb002
            #         NEXT FIELD CURRENT
            #      END IF                  
            #   END IF
            #END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb002
            #add-point:ON CHANGE xcbb002 name="input.g.xcbb002"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcbbcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbbcomp
            #add-point:ON ACTION controlp INFIELD xcbbcomp name="input.c.xcbbcomp"
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_xcbb_m.xcbbcomp             #給予default值
               
               #給予arg
               
               CALL q_ooef001_2()                                      #呼叫開窗
               
               LET g_xcbb_m.xcbbcomp = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               DISPLAY g_xcbb_m.xcbbcomp TO xcbbcomp                   #顯示到畫面上
               
               NEXT FIELD xcbbcomp                                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xcbb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb001
            #add-point:ON ACTION controlp INFIELD xcbb001 name="input.c.xcbb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb002
            #add-point:ON ACTION controlp INFIELD xcbb002 name="input.c.xcbb002"
            
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
            DISPLAY BY NAME g_xcbb_m.xcbbcomp             
                            ,g_xcbb_m.xcbb001   
                            ,g_xcbb_m.xcbb002   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axci120_xcbb_t_mask_restore('restore_mask_o')
            
               UPDATE xcbb_t SET (xcbbcomp,xcbb001,xcbb002) = (g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002) 
 
                WHERE xcbbent = g_enterprise AND xcbbcomp = g_xcbbcomp_t
                  AND xcbb001 = g_xcbb001_t
                  AND xcbb002 = g_xcbb002_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcbb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcbb_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcbb_m.xcbbcomp
               LET gs_keys_bak[1] = g_xcbbcomp_t
               LET gs_keys[2] = g_xcbb_m.xcbb001
               LET gs_keys_bak[2] = g_xcbb001_t
               LET gs_keys[3] = g_xcbb_m.xcbb002
               LET gs_keys_bak[3] = g_xcbb002_t
               LET gs_keys[4] = g_xcbb_d[g_detail_idx].xcbb003
               LET gs_keys_bak[4] = g_xcbb_d_t.xcbb003
               LET gs_keys[5] = g_xcbb_d[g_detail_idx].xcbb004
               LET gs_keys_bak[5] = g_xcbb_d_t.xcbb004
               CALL axci120_update_b('xcbb_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xcbb_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xcbb_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axci120_xcbb_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axci120_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xcbbcomp_t = g_xcbb_m.xcbbcomp
           LET g_xcbb001_t = g_xcbb_m.xcbb001
           LET g_xcbb002_t = g_xcbb_m.xcbb002
 
           
           IF g_xcbb_d.getLength() = 0 THEN
              NEXT FIELD xcbb003
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axci120.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcbb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcbb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axci120_b_fill(g_wc2) #test 
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
            CALL axci120_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axci120_cl USING g_enterprise,g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axci120_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axci120_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcbb_d[l_ac].xcbb003 IS NOT NULL
               AND g_xcbb_d[l_ac].xcbb004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcbb_d_t.* = g_xcbb_d[l_ac].*  #BACKUP
               LET g_xcbb_d_o.* = g_xcbb_d[l_ac].*  #BACKUP
               CALL axci120_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axci120_set_no_entry_b(l_cmd)
               OPEN axci120_bcl USING g_enterprise,g_xcbb_m.xcbbcomp,
                                                g_xcbb_m.xcbb001,
                                                g_xcbb_m.xcbb002,
 
                                                g_xcbb_d_t.xcbb003
                                                ,g_xcbb_d_t.xcbb004
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axci120_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axci120_bcl INTO g_xcbb_d[l_ac].xcbbstus,g_xcbb_d[l_ac].xcbb003,g_xcbb_d[l_ac].xcbb004, 
                      g_xcbb_d[l_ac].xcbb005,g_xcbb_d[l_ac].xcbb012,g_xcbb_d[l_ac].xcbb006,g_xcbb_d[l_ac].xcbb008, 
                      g_xcbb_d[l_ac].xcbb007,g_xcbb_d[l_ac].xcbb010,g_xcbb_d[l_ac].xcbb009,g_xcbb2_d[l_ac].xcbb003, 
                      g_xcbb2_d[l_ac].xcbb004,g_xcbb2_d[l_ac].xcbbownid,g_xcbb2_d[l_ac].xcbbowndp,g_xcbb2_d[l_ac].xcbbcrtid, 
                      g_xcbb2_d[l_ac].xcbbcrtdp,g_xcbb2_d[l_ac].xcbbcrtdt,g_xcbb2_d[l_ac].xcbbmodid, 
                      g_xcbb2_d[l_ac].xcbbmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcbb_d_t.xcbb003,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcbb_d_mask_o[l_ac].* =  g_xcbb_d[l_ac].*
                  CALL axci120_xcbb_t_mask()
                  LET g_xcbb_d_mask_n[l_ac].* =  g_xcbb_d[l_ac].*
                  
                  CALL axci120_ref_show()
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
            INITIALIZE g_xcbb_d_t.* TO NULL
            INITIALIZE g_xcbb_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcbb_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xcbb2_d[l_ac].xcbbownid = g_user
      LET g_xcbb2_d[l_ac].xcbbowndp = g_dept
      LET g_xcbb2_d[l_ac].xcbbcrtid = g_user
      LET g_xcbb2_d[l_ac].xcbbcrtdp = g_dept 
      LET g_xcbb2_d[l_ac].xcbbcrtdt = cl_get_current()
      LET g_xcbb2_d[l_ac].xcbbmodid = g_user
      LET g_xcbb2_d[l_ac].xcbbmoddt = cl_get_current()
      LET g_xcbb_d[l_ac].xcbbstus = ''
 
 
  
            #一般欄位預設值
                  LET g_xcbb_d[l_ac].xcbbstus = "Y"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xcbb_d_t.* = g_xcbb_d[l_ac].*     #新輸入資料
            LET g_xcbb_d_o.* = g_xcbb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axci120_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axci120_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcbb_d[li_reproduce_target].* = g_xcbb_d[li_reproduce].*
               LET g_xcbb2_d[li_reproduce_target].* = g_xcbb2_d[li_reproduce].*
 
               LET g_xcbb_d[g_xcbb_d.getLength()].xcbb003 = NULL
               LET g_xcbb_d[g_xcbb_d.getLength()].xcbb004 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF cl_get_para(g_enterprise,g_xcbb_m.xcbbcomp,'S-FIN-6013') = 'N' THEN
               LET g_xcbb_d[l_ac].xcbb004 = ' '
            END IF
            LET g_xcbb_d[l_ac].xcbb009 = 'N'
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
            SELECT COUNT(1) INTO l_count FROM xcbb_t 
             WHERE xcbbent = g_enterprise AND xcbbcomp = g_xcbb_m.xcbbcomp
               AND xcbb001 = g_xcbb_m.xcbb001
               AND xcbb002 = g_xcbb_m.xcbb002
 
               AND xcbb003 = g_xcbb_d[l_ac].xcbb003
               AND xcbb004 = g_xcbb_d[l_ac].xcbb004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               #LET g_xcbb_d[l_ac].xcbb004 = ' '  #fengmy150804 mark
               IF cl_null(g_xcbb_d[l_ac].xcbb004) THEN LET g_xcbb_d[l_ac].xcbb004 = ' ' END IF  #fengmy150804
               #end add-point
               INSERT INTO xcbb_t
                           (xcbbent,
                            xcbbcomp,xcbb001,xcbb002,
                            xcbb003,xcbb004
                            ,xcbbstus,xcbb005,xcbb012,xcbb006,xcbb008,xcbb007,xcbb010,xcbb009,xcbbownid,xcbbowndp,xcbbcrtid,xcbbcrtdp,xcbbcrtdt,xcbbmodid,xcbbmoddt) 
                     VALUES(g_enterprise,
                            g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002,
                            g_xcbb_d[l_ac].xcbb003,g_xcbb_d[l_ac].xcbb004
                            ,g_xcbb_d[l_ac].xcbbstus,g_xcbb_d[l_ac].xcbb005,g_xcbb_d[l_ac].xcbb012,g_xcbb_d[l_ac].xcbb006, 
                                g_xcbb_d[l_ac].xcbb008,g_xcbb_d[l_ac].xcbb007,g_xcbb_d[l_ac].xcbb010, 
                                g_xcbb_d[l_ac].xcbb009,g_xcbb2_d[l_ac].xcbbownid,g_xcbb2_d[l_ac].xcbbowndp, 
                                g_xcbb2_d[l_ac].xcbbcrtid,g_xcbb2_d[l_ac].xcbbcrtdp,g_xcbb2_d[l_ac].xcbbcrtdt, 
                                g_xcbb2_d[l_ac].xcbbmodid,g_xcbb2_d[l_ac].xcbbmoddt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xcbb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xcbb_t:",SQLERRMESSAGE 
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
               IF axci120_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xcbb_m.xcbbcomp
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbb_m.xcbb001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbb_m.xcbb002
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbb_d_t.xcbb003
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbb_d_t.xcbb004
 
 
                  #刪除下層單身
                  IF NOT axci120_key_delete_b(gs_keys,'xcbb_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axci120_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axci120_bcl
               LET l_count = g_xcbb_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcbb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbbstus
            #add-point:BEFORE FIELD xcbbstus name="input.b.page1.xcbbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbbstus
            
            #add-point:AFTER FIELD xcbbstus name="input.a.page1.xcbbstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbbstus
            #add-point:ON CHANGE xcbbstus name="input.g.page1.xcbbstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb003
            
            #add-point:AFTER FIELD xcbb003 name="input.a.page1.xcbb003"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_xcbb_d[l_ac].xcbb003) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xcbb_d_t.xcbb003 IS NULL OR g_xcbb_d[l_ac].xcbb003 != g_xcbb_d_t.xcbb003)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xcbb_d[l_ac].xcbb003                  
                  #呼叫檢查存在的library
                  IF NOT cl_chk_exist("v_imaf001_1") THEN
                     LET g_xcbb_d[l_ac].xcbb003 = g_xcbb_d_t.xcbb003
                     NEXT FIELD CURRENT 
                  END IF
                  IF NOT axci120_chk_all_key() THEN
                     LET g_xcbb_d[l_ac].xcbb003 = g_xcbb_d_t.xcbb003
                     NEXT FIELD CURRENT                  
                  END IF
                  CALL axci120_default_xcbb003() 
               END IF
            END IF            
            CALL s_desc_get_item_desc(g_xcbb_d[l_ac].xcbb003)
            RETURNING g_xcbb_d[l_ac].xcbb003_desc,g_xcbb_d[l_ac].xcbb003_desc_1

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb003
            #add-point:BEFORE FIELD xcbb003 name="input.b.page1.xcbb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb003
            #add-point:ON CHANGE xcbb003 name="input.g.page1.xcbb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb003_desc
            #add-point:BEFORE FIELD xcbb003_desc name="input.b.page1.xcbb003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb003_desc
            
            #add-point:AFTER FIELD xcbb003_desc name="input.a.page1.xcbb003_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb003_desc
            #add-point:ON CHANGE xcbb003_desc name="input.g.page1.xcbb003_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb003_desc_1
            #add-point:BEFORE FIELD xcbb003_desc_1 name="input.b.page1.xcbb003_desc_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb003_desc_1
            
            #add-point:AFTER FIELD xcbb003_desc_1 name="input.a.page1.xcbb003_desc_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb003_desc_1
            #add-point:ON CHANGE xcbb003_desc_1 name="input.g.page1.xcbb003_desc_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb004
            
            #add-point:AFTER FIELD xcbb004 name="input.a.page1.xcbb004"
           #fengmy150807-----begin
           IF NOT cl_null(g_xcbb_d[g_detail_idx].xcbb004) THEN
               IF l_cmd = 'a' OR (l_cmd ='u' AND (g_xcbb_d_t.xcbb004 IS NULL OR g_xcbb_d[l_ac].xcbb004 != g_xcbb_d_t.xcbb004)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xcbb_d[l_ac].xcbb003
                  LET g_chkparam.arg2 = g_xcbb_d[l_ac].xcbb004                  
                  
                  LET g_chkparam.where = " inaj209 = '",g_xcbb_m.xcbbcomp,"'"
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_inaj006") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME
                  
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xcbb_d[l_ac].xcbb004 = g_xcbb_d_t.xcbb004
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF                        
            #fengmy150807-----begin
            IF cl_null(g_xcbb_d[g_detail_idx].xcbb004) THEN LET g_xcbb_d[g_detail_idx].xcbb004 = ' ' END IF  #fengmy150804          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb004
            #add-point:BEFORE FIELD xcbb004 name="input.b.page1.xcbb004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb004
            #add-point:ON CHANGE xcbb004 name="input.g.page1.xcbb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb005
            
            #add-point:AFTER FIELD xcbb005 name="input.a.page1.xcbb005"
            IF NOT cl_null(g_xcbb_d[g_detail_idx].xcbb005) THEN
               IF l_cmd = 'a' OR (l_cmd ='u' AND (g_xcbb_d_t.xcbb005 IS NULL OR g_xcbb_d[l_ac].xcbb005 != g_xcbb_d_t.xcbb005)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xcbb_d[l_ac].xcbb005 
                  
                  #160318-00025#40  2016/04/22  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#40  2016/04/22  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooca001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME
                  
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xcbb_d[l_ac].xcbb005 = g_xcbb_d_t.xcbb005
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF
            CALL s_desc_get_unit_desc(g_xcbb_d[l_ac].xcbb005) RETURNING g_xcbb_d[l_ac].xcbb005_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb005
            #add-point:BEFORE FIELD xcbb005 name="input.b.page1.xcbb005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb005
            #add-point:ON CHANGE xcbb005 name="input.g.page1.xcbb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb012
            
            #add-point:AFTER FIELD xcbb012 name="input.a.page1.xcbb012"
            IF NOT cl_null(g_xcbb_d[l_ac].xcbb012) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xcbb_d_t.xcbb012 IS NULL OR g_xcbb_d[l_ac].xcbb012 != g_xcbb_d_t.xcbb012)) THEN
#此段落由子樣板a19產生
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xcbb_d[l_ac].xcbb012
                  
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_imca001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xcbb_d[l_ac].xcbb012 = g_xcbb_d_t.xcbb012
                     NEXT FIELD CURRENT
                  END IF
               
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcbb_d[l_ac].xcbb012
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcbb_d[l_ac].xcbb012_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_xcbb_d[l_ac].xcbb012_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb012
            #add-point:BEFORE FIELD xcbb012 name="input.b.page1.xcbb012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb012
            #add-point:ON CHANGE xcbb012 name="input.g.page1.xcbb012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb006
            #add-point:BEFORE FIELD xcbb006 name="input.b.page1.xcbb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb006
            
            #add-point:AFTER FIELD xcbb006 name="input.a.page1.xcbb006"
            IF NOT cl_null(g_xcbb_d[g_detail_idx].xcbb006) AND g_xcbb_d[g_detail_idx].xcbb006 < 0 THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xcbb_d_t.xcbb006 IS NULL OR g_xcbb_d[l_ac].xcbb006 != g_xcbb_d_t.xcbb006)) THEN
                  IF g_xcbb_d[l_ac].xcbb006 <=0 THEN
                     LET g_xcbb_d[l_ac].xcbb006 = g_xcbb_d_t.xcbb006
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb006
            #add-point:ON CHANGE xcbb006 name="input.g.page1.xcbb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb008
            #add-point:BEFORE FIELD xcbb008 name="input.b.page1.xcbb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb008
            
            #add-point:AFTER FIELD xcbb008 name="input.a.page1.xcbb008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb008
            #add-point:ON CHANGE xcbb008 name="input.g.page1.xcbb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb007
            #add-point:BEFORE FIELD xcbb007 name="input.b.page1.xcbb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb007
            
            #add-point:AFTER FIELD xcbb007 name="input.a.page1.xcbb007"
            IF NOT cl_null(g_xcbb_d[g_detail_idx].xcbb007) AND g_xcbb_d[g_detail_idx].xcbb007 < 0 THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xcbb_d_t.xcbb007 IS NULL OR g_xcbb_d[l_ac].xcbb007 != g_xcbb_d_t.xcbb007)) THEN
                  IF g_xcbb_d[l_ac].xcbb007 <=0 THEN
                     LET g_xcbb_d[l_ac].xcbb007 = g_xcbb_d_t.xcbb007
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb007
            #add-point:ON CHANGE xcbb007 name="input.g.page1.xcbb007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb010
            
            #add-point:AFTER FIELD xcbb010 name="input.a.page1.xcbb010"
            IF NOT cl_null(g_xcbb_d[g_detail_idx].xcbb010) THEN
               IF l_cmd= 'a' OR (l_cmd = 'u' AND (g_xcbb_d_t.xcbb010 IS NULL OR g_xcbb_d[l_ac].xcbb010 != g_xcbb_d_t.xcbb010)) THEN
                  IF NOT s_azzi650_chk_exist('206',g_xcbb_d[l_ac].xcbb010) THEN
                     LET g_xcbb_d[l_ac].xcbb010 = g_xcbb_d_t.xcbb010
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcbb_d[l_ac].xcbb010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcbb_d[l_ac].xcbb010_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_xcbb_d[l_ac].xcbb010_desc            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb010
            #add-point:BEFORE FIELD xcbb010 name="input.b.page1.xcbb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb010
            #add-point:ON CHANGE xcbb010 name="input.g.page1.xcbb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb009
            #add-point:BEFORE FIELD xcbb009 name="input.b.page1.xcbb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb009
            
            #add-point:AFTER FIELD xcbb009 name="input.a.page1.xcbb009"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb009
            #add-point:ON CHANGE xcbb009 name="input.g.page1.xcbb009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcbbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbbstus
            #add-point:ON ACTION controlp INFIELD xcbbstus name="input.c.page1.xcbbstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb003
            #add-point:ON ACTION controlp INFIELD xcbb003 name="input.c.page1.xcbb003"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbb_d[l_ac].xcbb003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_xcbb_m.xcbbcomp

            CALL q_imag001()                                             #呼叫開窗

            LET g_xcbb_d[l_ac].xcbb003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xcbb_d[l_ac].xcbb003 TO xcbb003                    #顯示到畫面上

            NEXT FIELD xcbb003                                           #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbb003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb003_desc
            #add-point:ON ACTION controlp INFIELD xcbb003_desc name="input.c.page1.xcbb003_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbb003_desc_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb003_desc_1
            #add-point:ON ACTION controlp INFIELD xcbb003_desc_1 name="input.c.page1.xcbb003_desc_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb004
            #add-point:ON ACTION controlp INFIELD xcbb004 name="input.c.page1.xcbb004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbb_d[l_ac].xcbb004             #給予default值

            #給予arg
            LET g_qryparam.where = " inaj209 = '",g_xcbb_m.xcbbcomp,"'",
                                   " AND inaj005 = '",g_xcbb_d[l_ac].xcbb003,"'"
            CALL q_inaj006()
            #CALL q_imaa006()                                #呼叫開窗  #fengmy150807 mark
             

            LET g_xcbb_d[l_ac].xcbb004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xcbb_d[l_ac].xcbb004 TO xcbb004              #顯示到畫面上

            NEXT FIELD xcbb004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb005
            #add-point:ON ACTION controlp INFIELD xcbb005 name="input.c.page1.xcbb005"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbb_d[l_ac].xcbb005             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_xcbb_d[l_ac].xcbb005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xcbb_d[l_ac].xcbb005 TO xcbb005              #顯示到畫面上

            NEXT FIELD xcbb005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb012
            #add-point:ON ACTION controlp INFIELD xcbb012 name="input.c.page1.xcbb012"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbb_d[l_ac].xcbb012             #給予default值

            #給予arg            
            CALL q_imca001_1()                                #呼叫開窗

            LET g_xcbb_d[l_ac].xcbb012 = g_qryparam.return1              

            DISPLAY g_xcbb_d[l_ac].xcbb012 TO xcbb012              #

            NEXT FIELD xcbb012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb006
            #add-point:ON ACTION controlp INFIELD xcbb006 name="input.c.page1.xcbb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb008
            #add-point:ON ACTION controlp INFIELD xcbb008 name="input.c.page1.xcbb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb007
            #add-point:ON ACTION controlp INFIELD xcbb007 name="input.c.page1.xcbb007"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbb_d[l_ac].xcbb007             #給予default值
            LET g_qryparam.where    = " imac001 = '",g_xcbb_d[l_ac].xcbb003,"'"

            #給予arg

            CALL q_imac003()                                #呼叫開窗

            LET g_xcbb_d[l_ac].xcbb005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xcbb_d[l_ac].xcbb005 TO xcbb007              #顯示到畫面上

            NEXT FIELD xcbb007                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb010
            #add-point:ON ACTION controlp INFIELD xcbb010 name="input.c.page1.xcbb010"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbb_d[l_ac].xcbb010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "206" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_xcbb_d[l_ac].xcbb010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xcbb_d[l_ac].xcbb010 TO xcbb010              #顯示到畫面上

            NEXT FIELD xcbb010                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb009
            #add-point:ON ACTION controlp INFIELD xcbb009 name="input.c.page1.xcbb009"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbb_d[l_ac].xcbb009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "206" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_xcbb_d[l_ac].xcbb009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xcbb_d[l_ac].xcbb009 TO xcbb009              #顯示到畫面上

            NEXT FIELD xcbb009                          #返回原欄位


            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcbb_d[l_ac].* = g_xcbb_d_t.*
               CLOSE axci120_bcl
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
               LET g_errparam.extend = g_xcbb_d[l_ac].xcbb003 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcbb_d[l_ac].* = g_xcbb_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xcbb2_d[l_ac].xcbbmodid = g_user 
LET g_xcbb2_d[l_ac].xcbbmoddt = cl_get_current()
LET g_xcbb2_d[l_ac].xcbbmodid_desc = cl_get_username(g_xcbb2_d[l_ac].xcbbmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               IF cl_null(g_xcbb_d[l_ac].xcbb004) THEN LET g_xcbb_d[l_ac].xcbb004 = ' ' END IF  #fengmy150804
               #end add-point
         
               #將遮罩欄位還原
               CALL axci120_xcbb_t_mask_restore('restore_mask_o')
         
               UPDATE xcbb_t SET (xcbbcomp,xcbb001,xcbb002,xcbbstus,xcbb003,xcbb004,xcbb005,xcbb012, 
                   xcbb006,xcbb008,xcbb007,xcbb010,xcbb009,xcbbownid,xcbbowndp,xcbbcrtid,xcbbcrtdp,xcbbcrtdt, 
                   xcbbmodid,xcbbmoddt) = (g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002,g_xcbb_d[l_ac].xcbbstus, 
                   g_xcbb_d[l_ac].xcbb003,g_xcbb_d[l_ac].xcbb004,g_xcbb_d[l_ac].xcbb005,g_xcbb_d[l_ac].xcbb012, 
                   g_xcbb_d[l_ac].xcbb006,g_xcbb_d[l_ac].xcbb008,g_xcbb_d[l_ac].xcbb007,g_xcbb_d[l_ac].xcbb010, 
                   g_xcbb_d[l_ac].xcbb009,g_xcbb2_d[l_ac].xcbbownid,g_xcbb2_d[l_ac].xcbbowndp,g_xcbb2_d[l_ac].xcbbcrtid, 
                   g_xcbb2_d[l_ac].xcbbcrtdp,g_xcbb2_d[l_ac].xcbbcrtdt,g_xcbb2_d[l_ac].xcbbmodid,g_xcbb2_d[l_ac].xcbbmoddt) 
 
                WHERE xcbbent = g_enterprise AND xcbbcomp = g_xcbb_m.xcbbcomp 
                 AND xcbb001 = g_xcbb_m.xcbb001 
                 AND xcbb002 = g_xcbb_m.xcbb002 
 
                 AND xcbb003 = g_xcbb_d_t.xcbb003 #項次   
                 AND xcbb004 = g_xcbb_d_t.xcbb004  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
 
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcbb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcbb_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcbb_m.xcbbcomp
               LET gs_keys_bak[1] = g_xcbbcomp_t
               LET gs_keys[2] = g_xcbb_m.xcbb001
               LET gs_keys_bak[2] = g_xcbb001_t
               LET gs_keys[3] = g_xcbb_m.xcbb002
               LET gs_keys_bak[3] = g_xcbb002_t
               LET gs_keys[4] = g_xcbb_d[g_detail_idx].xcbb003
               LET gs_keys_bak[4] = g_xcbb_d_t.xcbb003
               LET gs_keys[5] = g_xcbb_d[g_detail_idx].xcbb004
               LET gs_keys_bak[5] = g_xcbb_d_t.xcbb004
               CALL axci120_update_b('xcbb_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcbb_m),util.JSON.stringify(g_xcbb_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcbb_m),util.JSON.stringify(g_xcbb_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axci120_xcbb_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcbb_m.xcbbcomp
               LET ls_keys[ls_keys.getLength()+1] = g_xcbb_m.xcbb001
               LET ls_keys[ls_keys.getLength()+1] = g_xcbb_m.xcbb002
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcbb_d_t.xcbb003
               LET ls_keys[ls_keys.getLength()+1] = g_xcbb_d_t.xcbb004
 
               CALL axci120_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axci120_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcbb_d[l_ac].* = g_xcbb_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axci120_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcbb_d.getLength() = 0 THEN
               NEXT FIELD xcbb003
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcbb_d[li_reproduce_target].* = g_xcbb_d[li_reproduce].*
               LET g_xcbb2_d[li_reproduce_target].* = g_xcbb2_d[li_reproduce].*
 
               LET g_xcbb_d[li_reproduce_target].xcbb003 = NULL
               LET g_xcbb_d[li_reproduce_target].xcbb004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcbb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcbb_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_xcbb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL axci120_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL axci120_idx_chk()
            CALL axci120_ui_detailshow()
        
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
            NEXT FIELD xcbbcomp
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcbbstus
               WHEN "s_detail2"
                  NEXT FIELD xcbb003_2
 
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
 
{<section id="axci120.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axci120_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axci120_b_fill(g_wc2) #第一階單身填充
      CALL axci120_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axci120_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xcbb_m.xcbbcomp,g_xcbb_m.xcbbcomp_desc,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002
 
   CALL axci120_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axci120.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axci120_ref_show()
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
   #        INITIALIZE g_ref_fields TO NULL
   #        LET g_ref_fields[1] = g_xcbb_m.xcbbcomp
   #        CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #        LET g_xcbb_m.xcbbcomp_desc = '', g_rtn_fields[1] , ''
   #        DISPLAY BY NAME g_xcbb_m.xcbbcomp_desc
   #
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcbb_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
##160503-00030#1 mark str
#此段會造成效能不佳,mark掉直接改成在axci120_b_fill1()裡面抓取
#      CALL s_desc_get_item_desc(g_xcbb_d[l_ac].xcbb003)
#            RETURNING g_xcbb_d[l_ac].xcbb003_desc,g_xcbb_d[l_ac].xcbb003_desc_1
##160503-00030#1 mark end
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xcbb2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
     #      INITIALIZE g_ref_fields TO NULL
     #      LET g_ref_fields[1] = g_xcbb2_d[l_ac].xcbbownid
     #      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
     #      LET g_xcbb2_d[l_ac].xcbbownid_desc = '', g_rtn_fields[1] , ''
     #      DISPLAY g_xcbb2_d[l_ac].xcbbownid_desc TO s_detail1[g_detail_idx].xcbbownid_desc
     #
     #      INITIALIZE g_ref_fields TO NULL
     #      LET g_ref_fields[1] = g_xcbb2_d[l_ac].xcbbowndp
     #      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
     #      LET g_xcbb2_d[l_ac].xcbbowndp_desc = '', g_rtn_fields[1] , ''
     #      DISPLAY g_xcbb2_d[l_ac].xcbbowndp_desc TO s_detail1[g_detail_idx].xcbbowndp_desc
     #
     #      INITIALIZE g_ref_fields TO NULL
     #      LET g_ref_fields[1] = g_xcbb2_d[l_ac].xcbbcrtid
     #      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
     #      LET g_xcbb2_d[l_ac].xcbbcrtid_desc = '', g_rtn_fields[1] , ''
     #      DISPLAY g_xcbb2_d[l_ac].xcbbcrtid_desc TO s_detail1[g_detail_idx].xcbbcrtid_desc
     #
     #      INITIALIZE g_ref_fields TO NULL
     #      LET g_ref_fields[1] = g_xcbb2_d[l_ac].xcbbcrtdp
     #      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
     #      LET g_xcbb2_d[l_ac].xcbbcrtdp_desc = '', g_rtn_fields[1] , ''
     #      DISPLAY g_xcbb2_d[l_ac].xcbbcrtdp_desc TO s_detail1[g_detail_idx].xcbbcrtdp_desc
     #
     #      INITIALIZE g_ref_fields TO NULL
     #      LET g_ref_fields[1] = g_xcbb2_d[l_ac].xcbbmodid
     #      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
     #      LET g_xcbb2_d[l_ac].xcbbmodid_desc = '', g_rtn_fields[1] , ''
     #      DISPLAY g_xcbb2_d[l_ac].xcbbmodid_desc TO s_detail1[g_detail_idx].xcbbmodid_desc

      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axci120.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axci120_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xcbb_t.xcbbcomp 
   DEFINE l_oldno     LIKE xcbb_t.xcbbcomp 
   DEFINE l_newno02     LIKE xcbb_t.xcbb001 
   DEFINE l_oldno02     LIKE xcbb_t.xcbb001 
   DEFINE l_newno03     LIKE xcbb_t.xcbb002 
   DEFINE l_oldno03     LIKE xcbb_t.xcbb002 
 
   DEFINE l_master    RECORD LIKE xcbb_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcbb_t.* #此變數樣板目前無使用
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_ooea003   LIKE ooea_t.ooea003
   DEFINE l_newno1    LIKE xcbb_t.xcbbcomp
   #end add-point
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_xcbb_m.xcbbcomp IS NULL
      OR g_xcbb_m.xcbb001 IS NULL
      OR g_xcbb_m.xcbb002 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xcbbcomp_t = g_xcbb_m.xcbbcomp
   LET g_xcbb001_t = g_xcbb_m.xcbb001
   LET g_xcbb002_t = g_xcbb_m.xcbb002
 
   
   LET g_xcbb_m.xcbbcomp = ""
   LET g_xcbb_m.xcbb001 = ""
   LET g_xcbb_m.xcbb002 = ""
 
   LET g_master_insert = FALSE
   CALL axci120_set_entry('a')
   CALL axci120_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_xcbb2_d[l_ac].xcbbownid = g_user
   LET g_xcbb2_d[l_ac].xcbbowndp = g_dept
   LET g_xcbb2_d[l_ac].xcbbcrtid = g_user
   LET g_xcbb2_d[l_ac].xcbbcrtdp = g_dept 
   LET g_xcbb2_d[l_ac].xcbbcrtdt = cl_get_current()
   LET g_xcbb2_d[l_ac].xcbbmodid = ""
   LET g_xcbb2_d[l_ac].xcbbmoddt = ""
   #end add-point
   
   #清空key欄位的desc
      LET g_xcbb_m.xcbbcomp_desc = ''
   DISPLAY BY NAME g_xcbb_m.xcbbcomp_desc
 
   
   CALL axci120_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcbb_m.* TO NULL
      INITIALIZE g_xcbb_d TO NULL
      INITIALIZE g_xcbb2_d TO NULL
 
      CALL axci120_show()
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
   CALL axci120_set_act_visible()
   CALL axci120_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcbbcomp_t = g_xcbb_m.xcbbcomp
   LET g_xcbb001_t = g_xcbb_m.xcbb001
   LET g_xcbb002_t = g_xcbb_m.xcbb002
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcbbent = " ||g_enterprise|| " AND",
                      " xcbbcomp = '", g_xcbb_m.xcbbcomp, "' "
                      ," AND xcbb001 = '", g_xcbb_m.xcbb001, "' "
                      ," AND xcbb002 = '", g_xcbb_m.xcbb002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axci120_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axci120_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axci120_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axci120.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axci120_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcbb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axci120_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcbb_t
    WHERE xcbbent = g_enterprise AND xcbbcomp = g_xcbbcomp_t
    AND xcbb001 = g_xcbb001_t
    AND xcbb002 = g_xcbb002_t
 
       INTO TEMP axci120_detail
   
   #將key修正為調整後   
   UPDATE axci120_detail 
      #更新key欄位
      SET xcbbcomp = g_xcbb_m.xcbbcomp
          , xcbb001 = g_xcbb_m.xcbb001
          , xcbb002 = g_xcbb_m.xcbb002
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , xcbbownid = g_user 
       , xcbbowndp = g_dept
       , xcbbcrtid = g_user
       , xcbbcrtdp = g_dept 
       , xcbbcrtdt = ld_date
       , xcbbmodid = g_user
       , xcbbmoddt = ld_date
      #, xcbbstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO xcbb_t SELECT * FROM axci120_detail
   
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
   DROP TABLE axci120_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcbbcomp_t = g_xcbb_m.xcbbcomp
   LET g_xcbb001_t = g_xcbb_m.xcbb001
   LET g_xcbb002_t = g_xcbb_m.xcbb002
 
   
   DROP TABLE axci120_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axci120.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axci120_delete()
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
   
   IF g_xcbb_m.xcbbcomp IS NULL
   OR g_xcbb_m.xcbb001 IS NULL
   OR g_xcbb_m.xcbb002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axci120_cl USING g_enterprise,g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axci120_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axci120_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axci120_master_referesh USING g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002 INTO g_xcbb_m.xcbbcomp, 
       g_xcbb_m.xcbb001,g_xcbb_m.xcbb002,g_xcbb_m.xcbbcomp_desc
   
   #遮罩相關處理
   LET g_xcbb_m_mask_o.* =  g_xcbb_m.*
   CALL axci120_xcbb_t_mask()
   LET g_xcbb_m_mask_n.* =  g_xcbb_m.*
   
   CALL axci120_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axci120_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcbb_t WHERE xcbbent = g_enterprise AND xcbbcomp = g_xcbb_m.xcbbcomp
                                                               AND xcbb001 = g_xcbb_m.xcbb001
                                                               AND xcbb002 = g_xcbb_m.xcbb002
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcbb_t:",SQLERRMESSAGE 
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
      #   CLOSE axci120_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xcbb_d.clear() 
      CALL g_xcbb2_d.clear()       
 
     
      CALL axci120_ui_browser_refresh()  
      #CALL axci120_ui_headershow()  
      #CALL axci120_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axci120_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axci120_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axci120_cl
 
   #功能已完成,通報訊息中心
   CALL axci120_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axci120.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axci120_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
  #160503-00030#1 add str
  #因為剛性結構產生的程式段沒辦法增加抓取品名(xcbb003_desc)與規格(xcbb003_desc1),這樣會造成效能不佳,直接改寫
   CALL axci120_b_fill1(p_wc2)
   RETURN
  #160503-00030#1 add end
   #end add-point
   
   #先清空單身變數內容
   CALL g_xcbb_d.clear()
   CALL g_xcbb2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xcbbstus,xcbb003,xcbb004,xcbb005,xcbb012,xcbb006,xcbb008,xcbb007,xcbb010, 
       xcbb009,xcbb003,xcbb004,xcbbownid,xcbbowndp,xcbbcrtid,xcbbcrtdp,xcbbcrtdt,xcbbmodid,xcbbmoddt, 
       t1.oocal003 ,t2.oocql004 ,t3.oocql004 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 FROM xcbb_t", 
          
               "",
               
                              " LEFT JOIN oocal_t t1 ON t1.oocalent="||g_enterprise||" AND t1.oocal001=xcbb005 AND t1.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='200' AND t2.oocql002=xcbb012 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='206' AND t3.oocql002=xcbb010 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=xcbbownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=xcbbcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=xcbbcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=xcbbcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=xcbbmodid  ",
 
               " WHERE xcbbent= ? AND xcbbcomp=? AND xcbb001=? AND xcbb002=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcbb_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axci120_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xcbb_t.xcbb003,xcbb_t.xcbb004"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axci120_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axci120_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002 INTO g_xcbb_d[l_ac].xcbbstus, 
          g_xcbb_d[l_ac].xcbb003,g_xcbb_d[l_ac].xcbb004,g_xcbb_d[l_ac].xcbb005,g_xcbb_d[l_ac].xcbb012, 
          g_xcbb_d[l_ac].xcbb006,g_xcbb_d[l_ac].xcbb008,g_xcbb_d[l_ac].xcbb007,g_xcbb_d[l_ac].xcbb010, 
          g_xcbb_d[l_ac].xcbb009,g_xcbb2_d[l_ac].xcbb003,g_xcbb2_d[l_ac].xcbb004,g_xcbb2_d[l_ac].xcbbownid, 
          g_xcbb2_d[l_ac].xcbbowndp,g_xcbb2_d[l_ac].xcbbcrtid,g_xcbb2_d[l_ac].xcbbcrtdp,g_xcbb2_d[l_ac].xcbbcrtdt, 
          g_xcbb2_d[l_ac].xcbbmodid,g_xcbb2_d[l_ac].xcbbmoddt,g_xcbb_d[l_ac].xcbb005_desc,g_xcbb_d[l_ac].xcbb012_desc, 
          g_xcbb_d[l_ac].xcbb010_desc,g_xcbb2_d[l_ac].xcbbownid_desc,g_xcbb2_d[l_ac].xcbbowndp_desc, 
          g_xcbb2_d[l_ac].xcbbcrtid_desc,g_xcbb2_d[l_ac].xcbbcrtdp_desc,g_xcbb2_d[l_ac].xcbbmodid_desc  
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
 
            CALL g_xcbb_d.deleteElement(g_xcbb_d.getLength())
      CALL g_xcbb2_d.deleteElement(g_xcbb2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcbb_d.getLength()
      LET g_xcbb_d_mask_o[l_ac].* =  g_xcbb_d[l_ac].*
      CALL axci120_xcbb_t_mask()
      LET g_xcbb_d_mask_n[l_ac].* =  g_xcbb_d[l_ac].*
   END FOR
   
   LET g_xcbb2_d_mask_o.* =  g_xcbb2_d.*
   FOR l_ac = 1 TO g_xcbb2_d.getLength()
      LET g_xcbb2_d_mask_o[l_ac].* =  g_xcbb2_d[l_ac].*
      CALL axci120_xcbb_t_mask()
      LET g_xcbb2_d_mask_n[l_ac].* =  g_xcbb2_d[l_ac].*
   END FOR
 
 
   FREE axci120_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axci120.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axci120_idx_chk()
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
      IF g_detail_idx > g_xcbb_d.getLength() THEN
         LET g_detail_idx = g_xcbb_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xcbb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcbb_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xcbb2_d.getLength() THEN
         LET g_detail_idx = g_xcbb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcbb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcbb2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axci120.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axci120_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcbb_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axci120.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axci120_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xcbb_t
    WHERE xcbbent = g_enterprise AND xcbbcomp = g_xcbb_m.xcbbcomp AND
                              xcbb001 = g_xcbb_m.xcbb001 AND
                              xcbb002 = g_xcbb_m.xcbb002 AND
 
          xcbb003 = g_xcbb_d_t.xcbb003
      AND xcbb004 = g_xcbb_d_t.xcbb004
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcbb_t:",SQLERRMESSAGE 
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
 
{<section id="axci120.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axci120_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axci120.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axci120_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axci120.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axci120_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axci120.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axci120_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcbb_d[l_ac].xcbb003 = g_xcbb_d_t.xcbb003 
      AND g_xcbb_d[l_ac].xcbb004 = g_xcbb_d_t.xcbb004 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axci120.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axci120_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axci120.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axci120_lock_b(ps_table,ps_page)
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
   #CALL axci120_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axci120.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axci120_unlock_b(ps_table,ps_page)
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
 
{<section id="axci120.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axci120_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcbbcomp,xcbb001,xcbb002",TRUE)
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
 
{<section id="axci120.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axci120_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcbbcomp,xcbb001,xcbb002",FALSE)
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
 
{<section id="axci120.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axci120_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axci120.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axci120_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
 
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axci120.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axci120_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axci120.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axci120_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axci120.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axci120_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axci120.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axci120_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axci120.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axci120_default_search()
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
      LET ls_wc = ls_wc, " xcbbcomp = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcbb001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcbb002 = '", g_argv[03], "' AND "
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
 
{<section id="axci120.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axci120_fill_chk(ps_idx)
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
 
{<section id="axci120.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axci120_modify_detail_chk(ps_record)
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
         LET ls_return = "xcbbstus"
      WHEN "s_detail2"
         LET ls_return = "xcbb003_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axci120.mask_functions" >}
&include "erp/axc/axci120_mask.4gl"
 
{</section>}
 
{<section id="axci120.state_change" >}
    
 
{</section>}
 
{<section id="axci120.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axci120_set_pk_array()
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
   LET g_pk_array[1].values = g_xcbb_m.xcbbcomp
   LET g_pk_array[1].column = 'xcbbcomp'
   LET g_pk_array[2].values = g_xcbb_m.xcbb001
   LET g_pk_array[2].column = 'xcbb001'
   LET g_pk_array[3].values = g_xcbb_m.xcbb002
   LET g_pk_array[3].column = 'xcbb002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axci120.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axci120_msgcentre_notify(lc_state)
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
   CALL axci120_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcbb_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axci120.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 检查单头key栏位是否重复
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
PRIVATE FUNCTION axci120_chk_head_key()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   
   LET r_success = TRUE
   IF g_xcbb_m.xcbbcomp IS NULL OR g_xcbb_m.xcbb001 IS NULL OR g_xcbb_m.xcbb002 IS NULL THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM xcbb_t
    WHERE xcbbent  = g_enterprise
      AND xcbbcomp = g_xcbb_m.xcbbcomp
      AND xcbb001  = g_xcbb_m.xcbb001
      AND xcbb002  = g_xcbb_m.xcbb002
    
   IF l_cnt >0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "axc-00333"
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
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
PRIVATE FUNCTION axci120_chk_year_month()
DEFINE r_success       LIKE type_t.num5
DEFINE l_glaa003       LIKE glaa_t.glaa003
DEFINE l_cnt           LIKE type_t.num5

   LET r_success = TRUE
   IF g_xcbb_m.xcbb001 IS NULL THEN
      LET r_success = TRUE
      RETURN r_success
   END IF

   IF g_xcbb_m.xcbbcomp IS NULL THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
#抓出会计周期参考表号  glaa003
   SELECT glaa003 INTO l_glaa003
     FROM glaa_t
    WHERE glaaent  = g_enterprise
      AND glaacomp = g_xcbb_m.xcbbcomp
      AND glaa014  = 'Y'     
   
   IF g_xcbb_m.xcbb002 IS NULL THEN   
#只检查年 从glav中找到输入的年是否存在
      IF s_fin_date_chk_year(g_xcbb_m.xcbb001) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      IF s_fin_date_chk_period(l_glaa003,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002) THEN  
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 检查xcbb全部key是否重复，含单身
# Memo...........:
# Usage..........: CALL axci120_chk_all_key()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axci120_chk_all_key()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_xcbb004     LIKE xcbb_t.xcbb004
   
   LET r_success = TRUE
   LET l_xcbb004 = NULL
   IF cl_get_para(g_enterprise,g_xcbb_m.xcbbcomp,'S-FIN-6013') = 'N' THEN
      LET l_xcbb004 = ' '
   ELSE
      LET l_xcbb004 = g_xcbb_d[l_ac].xcbb004
   END IF
   IF g_xcbb_m.xcbbcomp IS NULL OR g_xcbb_m.xcbb001 IS NULL OR g_xcbb_m.xcbb002 IS NULL OR g_xcbb_d[l_ac].xcbb003 IS NULL OR l_xcbb004 IS NULL THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM xcbb_t
    WHERE xcbbent  = g_enterprise
      AND xcbbcomp = g_xcbb_m.xcbbcomp
      AND xcbb001  = g_xcbb_m.xcbb001
      AND xcbb002  = g_xcbb_m.xcbb002
      AND xcbb003  = g_xcbb_d[l_ac].xcbb003
      AND xcbb004  = l_xcbb004
    
   IF l_cnt >0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "axc-00333"
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axci120_default_xcbb003()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axci120_default_xcbb003()
   
   IF l_ac = 0 OR l_ac IS NULL THEN RETURN END IF
   IF g_xcbb_d[l_ac].xcbb003 IS NULL THEN RETURN END IF
   
   SELECT imaa003,imaa006 INTO g_xcbb_d[l_ac].xcbb012,g_xcbb_d[l_ac].xcbb005
     FROM imaa_t 
    WHERE imaaent = g_enterprise
      AND imaa001 = g_xcbb_d[l_ac].xcbb003

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = 'sel imaa_t' 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
    
   SELECT imac003 INTO g_xcbb_d[l_ac].xcbb008
     FROM imac_t 
    WHERE imacent = g_enterprise
      AND imac001 = g_xcbb_d[l_ac].xcbb003 

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = 'sel imac_t' 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF

   
   SELECT imag011 INTO g_xcbb_d[l_ac].xcbb010
     FROM imag_t
    WHERE imagent  = g_enterprise
      AND imagsite = g_xcbb_m.xcbbcomp
      AND imag001  = g_xcbb_d[l_ac].xcbb003 

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = 'sel imag_t' 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 新增/查詢時，預帶單頭欄位
# Memo...........:
# Usage..........: CALL axci120_head_default()
# Input parameter: 
# Return code....: 
# Date & Author..: 20151022 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axci120_head_default()
   DEFINE l_comp        LIKE xccc_t.xccccomp
   DEFINE l_ld          LIKE xccc_t.xcccld
   DEFINE l_year        LIKE xccc_t.xccc004
   DEFINE l_period      LIKE xccc_t.xccc005
   DEFINE l_calc_type   LIKE xccc_t.xccc003


   CALL s_axc_set_site_default() RETURNING l_comp,l_ld,l_year,l_period,l_calc_type
   IF cl_null(g_xcbb_m.xcbbcomp) THEN
      LET g_xcbb_m.xcbbcomp = l_comp
      DISPLAY BY NAME g_xcbb_m.xcbbcomp
   END IF
   IF cl_null(g_xcbb_m.xcbb001) THEN
      LET g_xcbb_m.xcbb001 = l_year
      DISPLAY BY NAME g_xcbb_m.xcbb001
   END IF
   IF cl_null(g_xcbb_m.xcbb002) THEN
      LET g_xcbb_m.xcbb002 = l_period
      DISPLAY BY NAME g_xcbb_m.xcbb002
   END IF
END FUNCTION

################################################################################
# Descriptions...: 單身陣列填充
# Memo...........:
# Usage..........: CALL axci120_b_fill1(p_wc2)
# Input parameter: p_wc2   單身WHERE條件
# Return code....: 無
# Date & Author..: 16/05/03 By Sarah
# Modify.........: 160503-00030#1 add
################################################################################
PRIVATE FUNCTION axci120_b_fill1(p_wc2)
DEFINE p_wc2      STRING
   
   #先清空單身變數內容
   CALL g_xcbb_d.clear()
   CALL g_xcbb2_d.clear()
   
   LET g_wc2_table1 = cl_replace_str(g_wc2_table1,'xcbb003_desc','imaal003')
   LET g_wc2_table1 = cl_replace_str(g_wc2_table1,'xcbb003_desc_1','imaal004')
   
   LET g_sql = "SELECT UNIQUE xcbbstus,xcbb003,xcbb004,xcbb005,xcbb012,xcbb006,xcbb008,xcbb007,xcbb010,",
               "       xcbb009,xcbb003,xcbb004,xcbbownid,xcbbowndp,xcbbcrtid,xcbbcrtdp,xcbbcrtdt,xcbbmodid,xcbbmoddt,", 
               "       (SELECT oocal003 FROM oocal_t WHERE oocalent=xcbbent AND oocal001=xcbb005 AND oocal002='"||g_dlang||"') oocal003,",
               "       (SELECT oocql004 FROM oocql_t WHERE oocqlent=xcbbent AND oocql001='200' AND oocql002=xcbb012 AND oocql003='"||g_dlang||"') oocql004,",
               "       (SELECT oocql004 FROM oocql_t WHERE oocqlent=xcbbent AND oocql001='206' AND oocql002=xcbb010 AND oocql003='"||g_dlang||"') oocql004,",
               "       (SELECT ooag011 FROM ooag_t WHERE ooagent=xcbbent AND ooag001=xcbbownid) ooag011,",
               "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xcbbent AND ooefl001=xcbbowndp AND ooefl002='"||g_dlang||"') ooefl003,",
               "       (SELECT ooag011 FROM ooag_t WHERE ooagent=xcbbent AND ooag001=xcbbcrtid) ooag011,",
               "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xcbbent AND ooefl001=xcbbcrtdp AND ooefl002='"||g_dlang||"') ooefl003,",
               "       (SELECT ooag011 FROM ooag_t WHERE ooagent=xcbbent AND ooag001=xcbbmodid) ooag011,",
               "       imaal003,imaal004",               
               "  FROM xcbb_t",
               "  LEFT JOIN imaal_t ON imaalent=xcbbent AND imaal001=xcbb003 AND imaal002='"||g_dlang||"'",
               " WHERE xcbbent= ? AND xcbbcomp=? AND xcbb001=? AND xcbb002=?"
               
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcbb_t")
   END IF
   
   #判斷是否填充
   IF axci120_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = g_sql, " ORDER BY xcbb_t.xcbb003,xcbb_t.xcbb004"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axci120_pb1 FROM g_sql
         DECLARE b_fill_cs1 CURSOR FOR axci120_pb1
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs1 USING g_enterprise,g_xcbb_m.xcbbcomp,g_xcbb_m.xcbb001,g_xcbb_m.xcbb002
                                               
      FOREACH b_fill_cs1 INTO g_xcbb_d[l_ac].xcbbstus,g_xcbb_d[l_ac].xcbb003,g_xcbb_d[l_ac].xcbb004,g_xcbb_d[l_ac].xcbb005, 
          g_xcbb_d[l_ac].xcbb012,g_xcbb_d[l_ac].xcbb006,g_xcbb_d[l_ac].xcbb008,g_xcbb_d[l_ac].xcbb007, 
          g_xcbb_d[l_ac].xcbb010,g_xcbb_d[l_ac].xcbb009,g_xcbb2_d[l_ac].xcbb003,g_xcbb2_d[l_ac].xcbb004, 
          g_xcbb2_d[l_ac].xcbbownid,g_xcbb2_d[l_ac].xcbbowndp,g_xcbb2_d[l_ac].xcbbcrtid,g_xcbb2_d[l_ac].xcbbcrtdp, 
          g_xcbb2_d[l_ac].xcbbcrtdt,g_xcbb2_d[l_ac].xcbbmodid,g_xcbb2_d[l_ac].xcbbmoddt,g_xcbb_d[l_ac].xcbb005_desc, 
          g_xcbb_d[l_ac].xcbb012_desc,g_xcbb_d[l_ac].xcbb010_desc,g_xcbb2_d[l_ac].xcbbownid_desc,g_xcbb2_d[l_ac].xcbbowndp_desc, 
          g_xcbb2_d[l_ac].xcbbcrtid_desc,g_xcbb2_d[l_ac].xcbbcrtdp_desc,g_xcbb2_d[l_ac].xcbbmodid_desc,
          g_xcbb_d[l_ac].xcbb003_desc,g_xcbb_d[l_ac].xcbb003_desc_1
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
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
      
         LET l_ac = l_ac + 1
         
      END FOREACH
 
      CALL g_xcbb_d.deleteElement(g_xcbb_d.getLength())
      CALL g_xcbb2_d.deleteElement(g_xcbb2_d.getLength())
      
   END IF
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcbb_d.getLength()
      LET g_xcbb_d_mask_o[l_ac].* =  g_xcbb_d[l_ac].*
      CALL axci120_xcbb_t_mask()
      LET g_xcbb_d_mask_n[l_ac].* =  g_xcbb_d[l_ac].*
   END FOR
   
   LET g_xcbb2_d_mask_o.* =  g_xcbb2_d.*
   FOR l_ac = 1 TO g_xcbb2_d.getLength()
      LET g_xcbb2_d_mask_o[l_ac].* =  g_xcbb2_d[l_ac].*
      CALL axci120_xcbb_t_mask()
      LET g_xcbb2_d_mask_n[l_ac].* =  g_xcbb2_d[l_ac].*
   END FOR
 
 
   FREE axci120_pb1
   
END FUNCTION

 
{</section>}
 
