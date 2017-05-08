#該程式未解開Section, 採用最新樣板產出!
{<section id="axci301.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2014-07-17 16:30:07), PR版次:0005(2016-10-24 16:41:02)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000143
#+ Filename...: axci301
#+ Description: 料件轉撥計價維護作業
#+ Creator....: 02599(2014-04-23 13:52:38)
#+ Modifier...: 02291 -SD/PR- 05423
 
{</section>}
 
{<section id="axci301.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...:   No.160318-00025#36   2016/04/18 BY pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#161019-00017#7   2016/10/19   By zhujing 据点组织开窗资料整批调整
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
PRIVATE type type_g_xcbn_m        RECORD
       xcbn001 LIKE xcbn_t.xcbn001, 
   xcbn002 LIKE xcbn_t.xcbn002
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcbn_d        RECORD
       xcbn005 LIKE xcbn_t.xcbn005, 
   xcbn006 LIKE xcbn_t.xcbn006, 
   xcbn005_desc LIKE type_t.chr500, 
   xcbn005_desc_desc LIKE type_t.chr500, 
   xcbn003 LIKE xcbn_t.xcbn003, 
   xcbn003_desc LIKE type_t.chr500, 
   xcbn004 LIKE xcbn_t.xcbn004, 
   xcbn004_desc LIKE type_t.chr500, 
   xcbn010 LIKE xcbn_t.xcbn010, 
   xcbn102 LIKE xcbn_t.xcbn102, 
   xcbn102a LIKE xcbn_t.xcbn102a, 
   xcbn102b LIKE xcbn_t.xcbn102b, 
   xcbn102c LIKE xcbn_t.xcbn102c, 
   xcbn102d LIKE xcbn_t.xcbn102d, 
   xcbn102e LIKE xcbn_t.xcbn102e, 
   xcbn102f LIKE xcbn_t.xcbn102f, 
   xcbn102g LIKE xcbn_t.xcbn102g, 
   xcbn102h LIKE xcbn_t.xcbn102h
       END RECORD
PRIVATE TYPE type_g_xcbn2_d RECORD
       xcbn005 LIKE xcbn_t.xcbn005, 
   xcbn003 LIKE xcbn_t.xcbn003, 
   xcbn004 LIKE xcbn_t.xcbn004, 
   xcbnownid LIKE xcbn_t.xcbnownid, 
   xcbnownid_desc LIKE type_t.chr500, 
   xcbnowndp LIKE xcbn_t.xcbnowndp, 
   xcbnowndp_desc LIKE type_t.chr500, 
   xcbncrtid LIKE xcbn_t.xcbncrtid, 
   xcbncrtid_desc LIKE type_t.chr500, 
   xcbncrtdp LIKE xcbn_t.xcbncrtdp, 
   xcbncrtdp_desc LIKE type_t.chr500, 
   xcbncrtdt DATETIME YEAR TO SECOND, 
   xcbnmodid LIKE xcbn_t.xcbnmodid, 
   xcbnmodid_desc LIKE type_t.chr500, 
   xcbnmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_xcbn_s        RECORD
   name LIKE type_t.chr80, 
   dir  LIKE type_t.chr80
       END RECORD
DEFINE g_xcbn_s        type_g_xcbn_s
 TYPE type_g_xcbn3_d        RECORD
   xcbnent LIKE xcbn_t.xcbnent,
   xcbn001 LIKE xcbn_t.xcbn001,
   xcbn002 LIKE xcbn_t.xcbn002,
   xcbn003 LIKE xcbn_t.xcbn003, 
   xcbn004 LIKE xcbn_t.xcbn004, 
   xcbn005 LIKE xcbn_t.xcbn005,
   xcbn006 LIKE xcbn_t.xcbn006,
   xcbn010 LIKE xcbn_t.xcbn010, 
   xcbn102 LIKE xcbn_t.xcbn102, 
   xcbn102a LIKE xcbn_t.xcbn102a, 
   xcbn102b LIKE xcbn_t.xcbn102b, 
   xcbn102c LIKE xcbn_t.xcbn102c, 
   xcbn102d LIKE xcbn_t.xcbn102d, 
   xcbn102e LIKE xcbn_t.xcbn102e, 
   xcbn102f LIKE xcbn_t.xcbn102f, 
   xcbn102g LIKE xcbn_t.xcbn102g, 
   xcbn102h LIKE xcbn_t.xcbn102h
       END RECORD
DEFINE g_xcbn3_d       DYNAMIC ARRAY OF type_g_xcbn3_d
DEFINE w               ui.Window
DEFINE f               ui.Form
DEFINE page            om.DomNode
DEFINE xls_name        STRING 
DEFINE g_channel       base.Channel,
       g_field_name    STRING,
       g_hidden        DYNAMIC ARRAY OF LIKE type_t.chr1,
       g_ifchar        DYNAMIC ARRAY OF LIKE type_t.chr1,
       g_mask          DYNAMIC ARRAY OF LIKE type_t.chr1,
       g_quote         STRING,
       g_sheet         STRING        
DEFINE g_sort          RECORD
         column        LIKE type_t.num5,    #sortColumn
         type          STRING,              #sortType:排序方式:asc/desc
         name          STRING               #欄位代號
                       END RECORD
DEFINE g_bufstr        base.StringBuffer 
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xcbn_m          type_g_xcbn_m
DEFINE g_xcbn_m_t        type_g_xcbn_m
DEFINE g_xcbn_m_o        type_g_xcbn_m
DEFINE g_xcbn_m_mask_o   type_g_xcbn_m #轉換遮罩前資料
DEFINE g_xcbn_m_mask_n   type_g_xcbn_m #轉換遮罩後資料
 
   DEFINE g_xcbn001_t LIKE xcbn_t.xcbn001
DEFINE g_xcbn002_t LIKE xcbn_t.xcbn002
 
 
DEFINE g_xcbn_d          DYNAMIC ARRAY OF type_g_xcbn_d
DEFINE g_xcbn_d_t        type_g_xcbn_d
DEFINE g_xcbn_d_o        type_g_xcbn_d
DEFINE g_xcbn_d_mask_o   DYNAMIC ARRAY OF type_g_xcbn_d #轉換遮罩前資料
DEFINE g_xcbn_d_mask_n   DYNAMIC ARRAY OF type_g_xcbn_d #轉換遮罩後資料
DEFINE g_xcbn2_d   DYNAMIC ARRAY OF type_g_xcbn2_d
DEFINE g_xcbn2_d_t type_g_xcbn2_d
DEFINE g_xcbn2_d_o type_g_xcbn2_d
DEFINE g_xcbn2_d_mask_o   DYNAMIC ARRAY OF type_g_xcbn2_d #轉換遮罩前資料
DEFINE g_xcbn2_d_mask_n   DYNAMIC ARRAY OF type_g_xcbn2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcbn001 LIKE xcbn_t.xcbn001,
      b_xcbn002 LIKE xcbn_t.xcbn002
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
 
{<section id="axci301.main" >}
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
   LET g_forupd_sql = " SELECT xcbn001,xcbn002", 
                      " FROM xcbn_t",
                      " WHERE xcbnent= ? AND xcbn001=? AND xcbn002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axci301_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xcbn001,t0.xcbn002",
               " FROM xcbn_t t0",
               
               " WHERE t0.xcbnent = " ||g_enterprise|| " AND t0.xcbn001 = ? AND t0.xcbn002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axci301_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axci301 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axci301_init()   
 
      #進入選單 Menu (="N")
      CALL axci301_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axci301
      
   END IF 
   
   CLOSE axci301_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axci301.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axci301_init()
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
   
   CALL axci301_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axci301.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axci301_ui_dialog()
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
   DEFINE l_success       LIKE type_t.num5
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
         INITIALIZE g_xcbn_m.* TO NULL
         CALL g_xcbn_d.clear()
         CALL g_xcbn2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axci301_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcbn_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axci301_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axci301_ui_detailshow()
               
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
               LET g_current_page = 1
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_xcbn2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axci301_idx_chk()
               CALL axci301_ui_detailshow()
               
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
               LET g_current_page = 2
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axci301_browser_fill("")
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
               CALL axci301_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axci301_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axci301_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci301_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axci301_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci301_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axci301_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci301_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axci301_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci301_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axci301_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci301_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcbn_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xcbn2_d)
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
               NEXT FIELD xcbn003
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
               CALL axci301_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axci301_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axci301_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axci301_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axci301_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axci301_s01
            LET g_action_choice="open_axci301_s01"
            IF cl_auth_chk_act("open_axci301_s01") THEN
               
               #add-point:ON ACTION open_axci301_s01 name="menu.open_axci301_s01"
               CALL axci301_s01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axci301_01
            LET g_action_choice="open_axci301_01"
            IF cl_auth_chk_act("open_axci301_01") THEN
               
               #add-point:ON ACTION open_axci301_01 name="menu.open_axci301_01"
               CALL s_transaction_begin()
               LET INT_FLAG=FALSE
               CALL axci301_01() RETURNING l_success
               IF INT_FLAG=FALSE THEN
                  IF l_success = TRUE THEN
                     CALL s_transaction_end('Y','1')
                     ERROR "INSERT O.K"
                  ELSE
                     CALL s_transaction_end('N','1')
                  END IF
               ELSE
                  CALL s_transaction_end('N','0')
                  LET INT_FLAG=FALSE
               END IF
               CALL axci301_show()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axci301_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axci301_insert()
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
               CALL axci301_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axci301_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axci301_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axci301_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axci301_set_pk_array()
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
 
{<section id="axci301.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axci301_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axci301.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axci301_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "xcbn001,xcbn002"
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
      LET l_sub_sql = " SELECT DISTINCT xcbn001 ",
                      ", xcbn002 ",
 
                      " FROM xcbn_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xcbnent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcbn_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcbn001 ",
                      ", xcbn002 ",
 
                      " FROM xcbn_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xcbnent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcbn_t")
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
      INITIALIZE g_xcbn_m.* TO NULL
      CALL g_xcbn_d.clear()        
      CALL g_xcbn2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcbn001,t0.xcbn002 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcbn001,t0.xcbn002",
                " FROM xcbn_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xcbnent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcbn_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcbn_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xcbn001,g_browser[g_cnt].b_xcbn002 
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
   
   IF cl_null(g_browser[g_cnt].b_xcbn001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcbn_m.* TO NULL
      CALL g_xcbn_d.clear()
      CALL g_xcbn2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axci301_fetch('')
   
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
 
{<section id="axci301.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axci301_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcbn_m.xcbn001 = g_browser[g_current_idx].b_xcbn001   
   LET g_xcbn_m.xcbn002 = g_browser[g_current_idx].b_xcbn002   
 
   EXECUTE axci301_master_referesh USING g_xcbn_m.xcbn001,g_xcbn_m.xcbn002 INTO g_xcbn_m.xcbn001,g_xcbn_m.xcbn002 
 
   CALL axci301_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axci301.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axci301_ui_detailshow()
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
 
{<section id="axci301.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axci301_ui_browser_refresh()
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
      IF g_browser[l_i].b_xcbn001 = g_xcbn_m.xcbn001 
         AND g_browser[l_i].b_xcbn002 = g_xcbn_m.xcbn002 
 
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
 
{<section id="axci301.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axci301_construct()
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
   INITIALIZE g_xcbn_m.* TO NULL
   CALL g_xcbn_d.clear()
   CALL g_xcbn2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcbn001,xcbn002
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn001
            #add-point:BEFORE FIELD xcbn001 name="construct.b.xcbn001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn001
            
            #add-point:AFTER FIELD xcbn001 name="construct.a.xcbn001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn001
            #add-point:ON ACTION controlp INFIELD xcbn001 name="construct.c.xcbn001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn002
            #add-point:BEFORE FIELD xcbn002 name="construct.b.xcbn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn002
            
            #add-point:AFTER FIELD xcbn002 name="construct.a.xcbn002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn002
            #add-point:ON ACTION controlp INFIELD xcbn002 name="construct.c.xcbn002"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xcbn005,xcbn006,xcbn003,xcbn004,xcbn010,xcbn102,xcbn102a,xcbn102b,xcbn102c, 
          xcbn102d,xcbn102e,xcbn102f,xcbn102g,xcbn102h,xcbnownid,xcbnowndp,xcbncrtid,xcbncrtdp,xcbncrtdt, 
          xcbnmodid,xcbnmoddt
           FROM s_detail1[1].xcbn005,s_detail1[1].xcbn006,s_detail1[1].xcbn003,s_detail1[1].xcbn004, 
               s_detail1[1].xcbn010,s_detail1[1].xcbn102,s_detail1[1].xcbn102a,s_detail1[1].xcbn102b, 
               s_detail1[1].xcbn102c,s_detail1[1].xcbn102d,s_detail1[1].xcbn102e,s_detail1[1].xcbn102f, 
               s_detail1[1].xcbn102g,s_detail1[1].xcbn102h,s_detail2[1].xcbnownid,s_detail2[1].xcbnowndp, 
               s_detail2[1].xcbncrtid,s_detail2[1].xcbncrtdp,s_detail2[1].xcbncrtdt,s_detail2[1].xcbnmodid, 
               s_detail2[1].xcbnmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xcbncrtdt>>----
         AFTER FIELD xcbncrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xcbnmoddt>>----
         AFTER FIELD xcbnmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xcbncnfdt>>----
         
         #----<<xcbnpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #Ctrlp:construct.c.page1.xcbn005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn005
            #add-point:ON ACTION controlp INFIELD xcbn005 name="construct.c.page1.xcbn005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbn005  #顯示到畫面上
            NEXT FIELD xcbn005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn005
            #add-point:BEFORE FIELD xcbn005 name="construct.b.page1.xcbn005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn005
            
            #add-point:AFTER FIELD xcbn005 name="construct.a.page1.xcbn005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbn006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn006
            #add-point:ON ACTION controlp INFIELD xcbn006 name="construct.c.page1.xcbn006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbn006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbn006  #顯示到畫面上
            NEXT FIELD xcbn006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn006
            #add-point:BEFORE FIELD xcbn006 name="construct.b.page1.xcbn006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn006
            
            #add-point:AFTER FIELD xcbn006 name="construct.a.page1.xcbn006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbn003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn003
            #add-point:ON ACTION controlp INFIELD xcbn003 name="construct.c.page1.xcbn003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " (ooef003 = 'Y' OR ooef201 = 'Y' OR ooef202 = 'Y' ) AND ooefstus='Y' "    #161019-00017#7 marked
#            CALL q_ooef001_10()                           #呼叫開窗         #161019-00017#7 marked
            CALL q_ooef001_1()                           #呼叫開窗         #161019-00017#7 add
            DISPLAY g_qryparam.return1 TO xcbn003  #顯示到畫面上
            NEXT FIELD xcbn003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn003
            #add-point:BEFORE FIELD xcbn003 name="construct.b.page1.xcbn003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn003
            
            #add-point:AFTER FIELD xcbn003 name="construct.a.page1.xcbn003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbn004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn004
            #add-point:ON ACTION controlp INFIELD xcbn004 name="construct.c.page1.xcbn004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " (ooef003 = 'Y' OR ooef201 = 'Y' OR ooef202 = 'Y' ) AND ooefstus='Y' "  #161019-00017#7 marked
#            CALL q_ooef001_10()                           #呼叫開窗      #161019-00017#7 marked
            CALL q_ooef001_1()                            #呼叫開窗      #161019-00017#7 add
            DISPLAY g_qryparam.return1 TO xcbn004  #顯示到畫面上
            NEXT FIELD xcbn004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn004
            #add-point:BEFORE FIELD xcbn004 name="construct.b.page1.xcbn004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn004
            
            #add-point:AFTER FIELD xcbn004 name="construct.a.page1.xcbn004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbn010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn010
            #add-point:ON ACTION controlp INFIELD xcbn010 name="construct.c.page1.xcbn010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbn010  #顯示到畫面上
            NEXT FIELD xcbn010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn010
            #add-point:BEFORE FIELD xcbn010 name="construct.b.page1.xcbn010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn010
            
            #add-point:AFTER FIELD xcbn010 name="construct.a.page1.xcbn010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102
            #add-point:BEFORE FIELD xcbn102 name="construct.b.page1.xcbn102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102
            
            #add-point:AFTER FIELD xcbn102 name="construct.a.page1.xcbn102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbn102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102
            #add-point:ON ACTION controlp INFIELD xcbn102 name="construct.c.page1.xcbn102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102a
            #add-point:BEFORE FIELD xcbn102a name="construct.b.page1.xcbn102a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102a
            
            #add-point:AFTER FIELD xcbn102a name="construct.a.page1.xcbn102a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbn102a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102a
            #add-point:ON ACTION controlp INFIELD xcbn102a name="construct.c.page1.xcbn102a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102b
            #add-point:BEFORE FIELD xcbn102b name="construct.b.page1.xcbn102b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102b
            
            #add-point:AFTER FIELD xcbn102b name="construct.a.page1.xcbn102b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbn102b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102b
            #add-point:ON ACTION controlp INFIELD xcbn102b name="construct.c.page1.xcbn102b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102c
            #add-point:BEFORE FIELD xcbn102c name="construct.b.page1.xcbn102c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102c
            
            #add-point:AFTER FIELD xcbn102c name="construct.a.page1.xcbn102c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbn102c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102c
            #add-point:ON ACTION controlp INFIELD xcbn102c name="construct.c.page1.xcbn102c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102d
            #add-point:BEFORE FIELD xcbn102d name="construct.b.page1.xcbn102d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102d
            
            #add-point:AFTER FIELD xcbn102d name="construct.a.page1.xcbn102d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbn102d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102d
            #add-point:ON ACTION controlp INFIELD xcbn102d name="construct.c.page1.xcbn102d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102e
            #add-point:BEFORE FIELD xcbn102e name="construct.b.page1.xcbn102e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102e
            
            #add-point:AFTER FIELD xcbn102e name="construct.a.page1.xcbn102e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbn102e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102e
            #add-point:ON ACTION controlp INFIELD xcbn102e name="construct.c.page1.xcbn102e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102f
            #add-point:BEFORE FIELD xcbn102f name="construct.b.page1.xcbn102f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102f
            
            #add-point:AFTER FIELD xcbn102f name="construct.a.page1.xcbn102f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbn102f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102f
            #add-point:ON ACTION controlp INFIELD xcbn102f name="construct.c.page1.xcbn102f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102g
            #add-point:BEFORE FIELD xcbn102g name="construct.b.page1.xcbn102g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102g
            
            #add-point:AFTER FIELD xcbn102g name="construct.a.page1.xcbn102g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbn102g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102g
            #add-point:ON ACTION controlp INFIELD xcbn102g name="construct.c.page1.xcbn102g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102h
            #add-point:BEFORE FIELD xcbn102h name="construct.b.page1.xcbn102h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102h
            
            #add-point:AFTER FIELD xcbn102h name="construct.a.page1.xcbn102h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbn102h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102h
            #add-point:ON ACTION controlp INFIELD xcbn102h name="construct.c.page1.xcbn102h"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xcbnownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbnownid
            #add-point:ON ACTION controlp INFIELD xcbnownid name="construct.c.page2.xcbnownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbnownid  #顯示到畫面上
            NEXT FIELD xcbnownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbnownid
            #add-point:BEFORE FIELD xcbnownid name="construct.b.page2.xcbnownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbnownid
            
            #add-point:AFTER FIELD xcbnownid name="construct.a.page2.xcbnownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcbnowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbnowndp
            #add-point:ON ACTION controlp INFIELD xcbnowndp name="construct.c.page2.xcbnowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbnowndp  #顯示到畫面上
            NEXT FIELD xcbnowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbnowndp
            #add-point:BEFORE FIELD xcbnowndp name="construct.b.page2.xcbnowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbnowndp
            
            #add-point:AFTER FIELD xcbnowndp name="construct.a.page2.xcbnowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcbncrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbncrtid
            #add-point:ON ACTION controlp INFIELD xcbncrtid name="construct.c.page2.xcbncrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbncrtid  #顯示到畫面上
            NEXT FIELD xcbncrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbncrtid
            #add-point:BEFORE FIELD xcbncrtid name="construct.b.page2.xcbncrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbncrtid
            
            #add-point:AFTER FIELD xcbncrtid name="construct.a.page2.xcbncrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcbncrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbncrtdp
            #add-point:ON ACTION controlp INFIELD xcbncrtdp name="construct.c.page2.xcbncrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbncrtdp  #顯示到畫面上
            NEXT FIELD xcbncrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbncrtdp
            #add-point:BEFORE FIELD xcbncrtdp name="construct.b.page2.xcbncrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbncrtdp
            
            #add-point:AFTER FIELD xcbncrtdp name="construct.a.page2.xcbncrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbncrtdt
            #add-point:BEFORE FIELD xcbncrtdt name="construct.b.page2.xcbncrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xcbnmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbnmodid
            #add-point:ON ACTION controlp INFIELD xcbnmodid name="construct.c.page2.xcbnmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbnmodid  #顯示到畫面上
            NEXT FIELD xcbnmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbnmodid
            #add-point:BEFORE FIELD xcbnmodid name="construct.b.page2.xcbnmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbnmodid
            
            #add-point:AFTER FIELD xcbnmodid name="construct.a.page2.xcbnmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbnmoddt
            #add-point:BEFORE FIELD xcbnmoddt name="construct.b.page2.xcbnmoddt"
            
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
 
{<section id="axci301.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axci301_query()
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
   CALL g_xcbn_d.clear()
   CALL g_xcbn2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axci301_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axci301_browser_fill(g_wc)
      CALL axci301_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axci301_browser_fill("F")
   
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
      CALL axci301_fetch("F") 
   END IF
   
   CALL axci301_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axci301.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axci301_fetch(p_flag)
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
   
   #CALL axci301_browser_fill(p_flag)
   
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
   
   LET g_xcbn_m.xcbn001 = g_browser[g_current_idx].b_xcbn001
   LET g_xcbn_m.xcbn002 = g_browser[g_current_idx].b_xcbn002
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axci301_master_referesh USING g_xcbn_m.xcbn001,g_xcbn_m.xcbn002 INTO g_xcbn_m.xcbn001,g_xcbn_m.xcbn002 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcbn_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcbn_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcbn_m_mask_o.* =  g_xcbn_m.*
   CALL axci301_xcbn_t_mask()
   LET g_xcbn_m_mask_n.* =  g_xcbn_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axci301_set_act_visible()
   CALL axci301_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xcbn_m_t.* = g_xcbn_m.*
   LET g_xcbn_m_o.* = g_xcbn_m.*
   
   #重新顯示   
   CALL axci301_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axci301.insert" >}
#+ 資料新增
PRIVATE FUNCTION axci301_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcbn_d.clear()
   CALL g_xcbn2_d.clear()
 
 
   INITIALIZE g_xcbn_m.* TO NULL             #DEFAULT 設定
   LET g_xcbn001_t = NULL
   LET g_xcbn002_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL axci301_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcbn_m.* TO NULL
         INITIALIZE g_xcbn_d TO NULL
         INITIALIZE g_xcbn2_d TO NULL
 
         CALL axci301_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcbn_m.* = g_xcbn_m_t.*
         CALL axci301_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xcbn_d.clear()
      #CALL g_xcbn2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axci301_set_act_visible()
   CALL axci301_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcbn001_t = g_xcbn_m.xcbn001
   LET g_xcbn002_t = g_xcbn_m.xcbn002
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcbnent = " ||g_enterprise|| " AND",
                      " xcbn001 = '", g_xcbn_m.xcbn001, "' "
                      ," AND xcbn002 = '", g_xcbn_m.xcbn002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axci301_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axci301_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axci301_master_referesh USING g_xcbn_m.xcbn001,g_xcbn_m.xcbn002 INTO g_xcbn_m.xcbn001,g_xcbn_m.xcbn002 
 
   
   #遮罩相關處理
   LET g_xcbn_m_mask_o.* =  g_xcbn_m.*
   CALL axci301_xcbn_t_mask()
   LET g_xcbn_m_mask_n.* =  g_xcbn_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcbn_m.xcbn001,g_xcbn_m.xcbn002
   
   #功能已完成,通報訊息中心
   CALL axci301_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axci301.modify" >}
#+ 資料修改
PRIVATE FUNCTION axci301_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xcbn_m.xcbn001 IS NULL
   OR g_xcbn_m.xcbn002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xcbn001_t = g_xcbn_m.xcbn001
   LET g_xcbn002_t = g_xcbn_m.xcbn002
 
   CALL s_transaction_begin()
   
   OPEN axci301_cl USING g_enterprise,g_xcbn_m.xcbn001,g_xcbn_m.xcbn002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axci301_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axci301_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axci301_master_referesh USING g_xcbn_m.xcbn001,g_xcbn_m.xcbn002 INTO g_xcbn_m.xcbn001,g_xcbn_m.xcbn002 
 
   
   #遮罩相關處理
   LET g_xcbn_m_mask_o.* =  g_xcbn_m.*
   CALL axci301_xcbn_t_mask()
   LET g_xcbn_m_mask_n.* =  g_xcbn_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axci301_show()
   WHILE TRUE
      LET g_xcbn001_t = g_xcbn_m.xcbn001
      LET g_xcbn002_t = g_xcbn_m.xcbn002
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axci301_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcbn_m.* = g_xcbn_m_t.*
         CALL axci301_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcbn_m.xcbn001 != g_xcbn001_t 
      OR g_xcbn_m.xcbn002 != g_xcbn002_t 
 
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
   CALL axci301_set_act_visible()
   CALL axci301_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcbnent = " ||g_enterprise|| " AND",
                      " xcbn001 = '", g_xcbn_m.xcbn001, "' "
                      ," AND xcbn002 = '", g_xcbn_m.xcbn002, "' "
 
   #填到對應位置
   CALL axci301_browser_fill("")
 
   CALL axci301_idx_chk()
 
   CLOSE axci301_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axci301_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axci301.input" >}
#+ 資料輸入
PRIVATE FUNCTION axci301_input(p_cmd)
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
   DEFINE  l_max_period          LIKE glav_t.glav006
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
   DISPLAY BY NAME g_xcbn_m.xcbn001,g_xcbn_m.xcbn002
   
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
   LET g_forupd_sql = "SELECT xcbn005,xcbn006,xcbn003,xcbn004,xcbn010,xcbn102,xcbn102a,xcbn102b,xcbn102c, 
       xcbn102d,xcbn102e,xcbn102f,xcbn102g,xcbn102h,xcbn005,xcbn003,xcbn004,xcbnownid,xcbnowndp,xcbncrtid, 
       xcbncrtdp,xcbncrtdt,xcbnmodid,xcbnmoddt FROM xcbn_t WHERE xcbnent=? AND xcbn001=? AND xcbn002=?  
       AND xcbn003=? AND xcbn004=? AND xcbn005=? AND xcbn006=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axci301_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axci301_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axci301_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xcbn_m.xcbn001,g_xcbn_m.xcbn002
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axci301.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcbn_m.xcbn001,g_xcbn_m.xcbn002 
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
         BEFORE FIELD xcbn001
            #add-point:BEFORE FIELD xcbn001 name="input.b.xcbn001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn001
            
            #add-point:AFTER FIELD xcbn001 name="input.a.xcbn001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcbn_m.xcbn001) AND NOT cl_null(g_xcbn_m.xcbn002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcbn_m.xcbn001 != g_xcbn001_t  OR g_xcbn_m.xcbn002 != g_xcbn002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbn_t WHERE "||"xcbnent = '" ||g_enterprise|| "' AND "||"xcbn001 = '"||g_xcbn_m.xcbn001 ||"' AND "|| "xcbn002 = '"||g_xcbn_m.xcbn002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn001
            #add-point:ON CHANGE xcbn001 name="input.g.xcbn001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn002
            #add-point:BEFORE FIELD xcbn002 name="input.b.xcbn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn002
            
            #add-point:AFTER FIELD xcbn002 name="input.a.xcbn002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcbn_m.xcbn001) AND NOT cl_null(g_xcbn_m.xcbn002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcbn_m.xcbn001 != g_xcbn001_t  OR g_xcbn_m.xcbn002 != g_xcbn002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbn_t WHERE "||"xcbnent = '" ||g_enterprise|| "' AND "||"xcbn001 = '"||g_xcbn_m.xcbn001 ||"' AND "|| "xcbn002 = '"||g_xcbn_m.xcbn002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xcbn_m.xcbn001) THEN
               #獲取現行會計週期最大期別
               SELECT MAX(glav006) INTO l_max_period FROM glav_t 
               WHERE glavent=g_enterprise AND glav002=g_xcbn_m.xcbn001
               IF NOT cl_ap_chk_Range(g_xcbn_m.xcbn002,"0","1",l_max_period,"1","azz-00087",1) THEN
                  LET g_xcbn_m.xcbn002=g_xcbn002_t
                  NEXT FIELD xcbn001
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn002
            #add-point:ON CHANGE xcbn002 name="input.g.xcbn002"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcbn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn001
            #add-point:ON ACTION controlp INFIELD xcbn001 name="input.c.xcbn001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcbn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn002
            #add-point:ON ACTION controlp INFIELD xcbn002 name="input.c.xcbn002"
            
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
            DISPLAY BY NAME g_xcbn_m.xcbn001             
                            ,g_xcbn_m.xcbn002   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axci301_xcbn_t_mask_restore('restore_mask_o')
            
               UPDATE xcbn_t SET (xcbn001,xcbn002) = (g_xcbn_m.xcbn001,g_xcbn_m.xcbn002)
                WHERE xcbnent = g_enterprise AND xcbn001 = g_xcbn001_t
                  AND xcbn002 = g_xcbn002_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcbn_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcbn_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcbn_m.xcbn001
               LET gs_keys_bak[1] = g_xcbn001_t
               LET gs_keys[2] = g_xcbn_m.xcbn002
               LET gs_keys_bak[2] = g_xcbn002_t
               LET gs_keys[3] = g_xcbn_d[g_detail_idx].xcbn003
               LET gs_keys_bak[3] = g_xcbn_d_t.xcbn003
               LET gs_keys[4] = g_xcbn_d[g_detail_idx].xcbn004
               LET gs_keys_bak[4] = g_xcbn_d_t.xcbn004
               LET gs_keys[5] = g_xcbn_d[g_detail_idx].xcbn005
               LET gs_keys_bak[5] = g_xcbn_d_t.xcbn005
               LET gs_keys[6] = g_xcbn_d[g_detail_idx].xcbn006
               LET gs_keys_bak[6] = g_xcbn_d_t.xcbn006
               CALL axci301_update_b('xcbn_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xcbn_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xcbn_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axci301_xcbn_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axci301_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xcbn001_t = g_xcbn_m.xcbn001
           LET g_xcbn002_t = g_xcbn_m.xcbn002
 
           
           IF g_xcbn_d.getLength() = 0 THEN
              NEXT FIELD xcbn003
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axci301.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcbn_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcbn_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axci301_b_fill(g_wc2) #test 
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
            CALL axci301_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axci301_cl USING g_enterprise,g_xcbn_m.xcbn001,g_xcbn_m.xcbn002                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axci301_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axci301_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcbn_d[l_ac].xcbn003 IS NOT NULL
               AND g_xcbn_d[l_ac].xcbn004 IS NOT NULL
               AND g_xcbn_d[l_ac].xcbn005 IS NOT NULL
               AND g_xcbn_d[l_ac].xcbn006 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcbn_d_t.* = g_xcbn_d[l_ac].*  #BACKUP
               LET g_xcbn_d_o.* = g_xcbn_d[l_ac].*  #BACKUP
               CALL axci301_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axci301_set_no_entry_b(l_cmd)
               OPEN axci301_bcl USING g_enterprise,g_xcbn_m.xcbn001,
                                                g_xcbn_m.xcbn002,
 
                                                g_xcbn_d_t.xcbn003
                                                ,g_xcbn_d_t.xcbn004
                                                ,g_xcbn_d_t.xcbn005
                                                ,g_xcbn_d_t.xcbn006
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axci301_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axci301_bcl INTO g_xcbn_d[l_ac].xcbn005,g_xcbn_d[l_ac].xcbn006,g_xcbn_d[l_ac].xcbn003, 
                      g_xcbn_d[l_ac].xcbn004,g_xcbn_d[l_ac].xcbn010,g_xcbn_d[l_ac].xcbn102,g_xcbn_d[l_ac].xcbn102a, 
                      g_xcbn_d[l_ac].xcbn102b,g_xcbn_d[l_ac].xcbn102c,g_xcbn_d[l_ac].xcbn102d,g_xcbn_d[l_ac].xcbn102e, 
                      g_xcbn_d[l_ac].xcbn102f,g_xcbn_d[l_ac].xcbn102g,g_xcbn_d[l_ac].xcbn102h,g_xcbn2_d[l_ac].xcbn005, 
                      g_xcbn2_d[l_ac].xcbn003,g_xcbn2_d[l_ac].xcbn004,g_xcbn2_d[l_ac].xcbnownid,g_xcbn2_d[l_ac].xcbnowndp, 
                      g_xcbn2_d[l_ac].xcbncrtid,g_xcbn2_d[l_ac].xcbncrtdp,g_xcbn2_d[l_ac].xcbncrtdt, 
                      g_xcbn2_d[l_ac].xcbnmodid,g_xcbn2_d[l_ac].xcbnmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcbn_d_t.xcbn003,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcbn_d_mask_o[l_ac].* =  g_xcbn_d[l_ac].*
                  CALL axci301_xcbn_t_mask()
                  LET g_xcbn_d_mask_n[l_ac].* =  g_xcbn_d[l_ac].*
                  
                  CALL axci301_ref_show()
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
            INITIALIZE g_xcbn_d_t.* TO NULL
            INITIALIZE g_xcbn_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcbn_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xcbn2_d[l_ac].xcbnownid = g_user
      LET g_xcbn2_d[l_ac].xcbnowndp = g_dept
      LET g_xcbn2_d[l_ac].xcbncrtid = g_user
      LET g_xcbn2_d[l_ac].xcbncrtdp = g_dept 
      LET g_xcbn2_d[l_ac].xcbncrtdt = cl_get_current()
      LET g_xcbn2_d[l_ac].xcbnmodid = g_user
      LET g_xcbn2_d[l_ac].xcbnmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
                  LET g_xcbn_d[l_ac].xcbn102 = "0"
      LET g_xcbn_d[l_ac].xcbn102a = "0"
      LET g_xcbn_d[l_ac].xcbn102b = "0"
      LET g_xcbn_d[l_ac].xcbn102c = "0"
      LET g_xcbn_d[l_ac].xcbn102d = "0"
      LET g_xcbn_d[l_ac].xcbn102e = "0"
      LET g_xcbn_d[l_ac].xcbn102f = "0"
      LET g_xcbn_d[l_ac].xcbn102g = "0"
      LET g_xcbn_d[l_ac].xcbn102h = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xcbn_d_t.* = g_xcbn_d[l_ac].*     #新輸入資料
            LET g_xcbn_d_o.* = g_xcbn_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axci301_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axci301_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcbn_d[li_reproduce_target].* = g_xcbn_d[li_reproduce].*
               LET g_xcbn2_d[li_reproduce_target].* = g_xcbn2_d[li_reproduce].*
 
               LET g_xcbn_d[g_xcbn_d.getLength()].xcbn003 = NULL
               LET g_xcbn_d[g_xcbn_d.getLength()].xcbn004 = NULL
               LET g_xcbn_d[g_xcbn_d.getLength()].xcbn005 = NULL
               LET g_xcbn_d[g_xcbn_d.getLength()].xcbn006 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xcbn_t 
             WHERE xcbnent = g_enterprise AND xcbn001 = g_xcbn_m.xcbn001
               AND xcbn002 = g_xcbn_m.xcbn002
 
               AND xcbn003 = g_xcbn_d[l_ac].xcbn003
               AND xcbn004 = g_xcbn_d[l_ac].xcbn004
               AND xcbn005 = g_xcbn_d[l_ac].xcbn005
               AND xcbn006 = g_xcbn_d[l_ac].xcbn006
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               IF cl_null(g_xcbn_d[l_ac].xcbn102a) THEN
                  LET g_xcbn_d[l_ac].xcbn102a=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn102b) THEN
                  LET g_xcbn_d[l_ac].xcbn102b=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn102c) THEN
                  LET g_xcbn_d[l_ac].xcbn102c=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn102d) THEN
                  LET g_xcbn_d[l_ac].xcbn102d=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn102e) THEN
                  LET g_xcbn_d[l_ac].xcbn102e=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn102f) THEN
                  LET g_xcbn_d[l_ac].xcbn102f=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn102g) THEN
                  LET g_xcbn_d[l_ac].xcbn102g=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn102h) THEN
                  LET g_xcbn_d[l_ac].xcbn102h=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn006) THEN
                  LET g_xcbn_d[l_ac].xcbn006 = ' '
               END IF
               LET g_xcbn_d[l_ac].xcbn102=g_xcbn_d[l_ac].xcbn102a+g_xcbn_d[l_ac].xcbn102b+g_xcbn_d[l_ac].xcbn102c+
                                          g_xcbn_d[l_ac].xcbn102d+g_xcbn_d[l_ac].xcbn102e+g_xcbn_d[l_ac].xcbn102f+
                                          g_xcbn_d[l_ac].xcbn102g+g_xcbn_d[l_ac].xcbn102h
               #end add-point
               INSERT INTO xcbn_t
                           (xcbnent,
                            xcbn001,xcbn002,
                            xcbn003,xcbn004,xcbn005,xcbn006
                            ,xcbn010,xcbn102,xcbn102a,xcbn102b,xcbn102c,xcbn102d,xcbn102e,xcbn102f,xcbn102g,xcbn102h,xcbnownid,xcbnowndp,xcbncrtid,xcbncrtdp,xcbncrtdt,xcbnmodid,xcbnmoddt) 
                     VALUES(g_enterprise,
                            g_xcbn_m.xcbn001,g_xcbn_m.xcbn002,
                            g_xcbn_d[l_ac].xcbn003,g_xcbn_d[l_ac].xcbn004,g_xcbn_d[l_ac].xcbn005,g_xcbn_d[l_ac].xcbn006 
 
                            ,g_xcbn_d[l_ac].xcbn010,g_xcbn_d[l_ac].xcbn102,g_xcbn_d[l_ac].xcbn102a,g_xcbn_d[l_ac].xcbn102b, 
                                g_xcbn_d[l_ac].xcbn102c,g_xcbn_d[l_ac].xcbn102d,g_xcbn_d[l_ac].xcbn102e, 
                                g_xcbn_d[l_ac].xcbn102f,g_xcbn_d[l_ac].xcbn102g,g_xcbn_d[l_ac].xcbn102h, 
                                g_xcbn2_d[l_ac].xcbnownid,g_xcbn2_d[l_ac].xcbnowndp,g_xcbn2_d[l_ac].xcbncrtid, 
                                g_xcbn2_d[l_ac].xcbncrtdp,g_xcbn2_d[l_ac].xcbncrtdt,g_xcbn2_d[l_ac].xcbnmodid, 
                                g_xcbn2_d[l_ac].xcbnmoddt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xcbn_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xcbn_t:",SQLERRMESSAGE 
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
               IF axci301_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xcbn_m.xcbn001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbn_m.xcbn002
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbn_d_t.xcbn003
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbn_d_t.xcbn004
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbn_d_t.xcbn005
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbn_d_t.xcbn006
 
 
                  #刪除下層單身
                  IF NOT axci301_key_delete_b(gs_keys,'xcbn_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axci301_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axci301_bcl
               LET l_count = g_xcbn_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcbn_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn005
            
            #add-point:AFTER FIELD xcbn005 name="input.a.page1.xcbn005"
            IF NOT cl_null(g_xcbn_d[l_ac].xcbn005) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcbn_d[l_ac].xcbn005
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaf001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcbn_d[l_ac].xcbn005=g_xcbn_d_t.xcbn005
                  NEXT FIELD CURRENT
               END IF
            
            END IF
            
            #此段落由子樣板a05產生
            IF  g_xcbn_m.xcbn001 IS NOT NULL AND g_xcbn_m.xcbn002 IS NOT NULL AND g_xcbn_d[g_detail_idx].xcbn003 IS NOT NULL AND g_xcbn_d[g_detail_idx].xcbn004 IS NOT NULL AND g_xcbn_d[g_detail_idx].xcbn005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcbn_m.xcbn001 != g_xcbn001_t OR g_xcbn_m.xcbn002 != g_xcbn002_t OR g_xcbn_d[g_detail_idx].xcbn003 != g_xcbn_d_t.xcbn003 OR g_xcbn_d[g_detail_idx].xcbn004 != g_xcbn_d_t.xcbn004 OR g_xcbn_d[g_detail_idx].xcbn005 != g_xcbn_d_t.xcbn005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbn_t WHERE "||"xcbnent = '" ||g_enterprise|| "' AND "||"xcbn001 = '"||g_xcbn_m.xcbn001 ||"' AND "|| "xcbn002 = '"||g_xcbn_m.xcbn002 ||"' AND "|| "xcbn003 = '"||g_xcbn_d[g_detail_idx].xcbn003 ||"' AND "|| "xcbn004 = '"||g_xcbn_d[g_detail_idx].xcbn004 ||"' AND "|| "xcbn005 = '"||g_xcbn_d[g_detail_idx].xcbn005 ||"'",'std-00004',0) THEN 
                     LET g_xcbn_d[l_ac].xcbn005=g_xcbn_d_t.xcbn005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_xcbn_d[l_ac].xcbn006 = ' '
            CALL axci301_xcbn005_desc(g_xcbn_d[l_ac].xcbn005) RETURNING g_xcbn_d[l_ac].xcbn005_desc,g_xcbn_d[l_ac].xcbn005_desc_desc
            DISPLAY BY NAME g_xcbn_d[l_ac].xcbn005_desc,g_xcbn_d[l_ac].xcbn005_desc_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn005
            #add-point:BEFORE FIELD xcbn005 name="input.b.page1.xcbn005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn005
            #add-point:ON CHANGE xcbn005 name="input.g.page1.xcbn005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn006
            #add-point:BEFORE FIELD xcbn006 name="input.b.page1.xcbn006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn006
            
            #add-point:AFTER FIELD xcbn006 name="input.a.page1.xcbn006"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcbn_m.xcbn001 IS NOT NULL AND g_xcbn_m.xcbn002 IS NOT NULL AND g_xcbn_d[g_detail_idx].xcbn003 IS NOT NULL AND g_xcbn_d[g_detail_idx].xcbn004 IS NOT NULL AND g_xcbn_d[g_detail_idx].xcbn005 IS NOT NULL AND g_xcbn_d[g_detail_idx].xcbn006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcbn_m.xcbn001 != g_xcbn001_t OR g_xcbn_m.xcbn002 != g_xcbn002_t OR g_xcbn_d[g_detail_idx].xcbn003 != g_xcbn_d_t.xcbn003 OR g_xcbn_d[g_detail_idx].xcbn004 != g_xcbn_d_t.xcbn004 OR g_xcbn_d[g_detail_idx].xcbn005 != g_xcbn_d_t.xcbn005 OR g_xcbn_d[g_detail_idx].xcbn006 != g_xcbn_d_t.xcbn006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbn_t WHERE "||"xcbnent = '" ||g_enterprise|| "' AND "||"xcbn001 = '"||g_xcbn_m.xcbn001 ||"' AND "|| "xcbn002 = '"||g_xcbn_m.xcbn002 ||"' AND "|| "xcbn003 = '"||g_xcbn_d[g_detail_idx].xcbn003 ||"' AND "|| "xcbn004 = '"||g_xcbn_d[g_detail_idx].xcbn004 ||"' AND "|| "xcbn005 = '"||g_xcbn_d[g_detail_idx].xcbn005 ||"' AND "|| "xcbn006 = '"||g_xcbn_d[g_detail_idx].xcbn006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn006
            #add-point:ON CHANGE xcbn006 name="input.g.page1.xcbn006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn003
            
            #add-point:AFTER FIELD xcbn003 name="input.a.page1.xcbn003"
            IF NOT cl_null(g_xcbn_d[l_ac].xcbn003) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcbn_d[l_ac].xcbn003   
               #160318-00025#36  2016/05/18  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#36  2016/05/18  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001_11") THEN         #161019-00017#7 marked
               IF cl_chk_exist("v_ooef001_13") THEN         #161019-00017#7 add
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcbn_d[l_ac].xcbn003=g_xcbn_d_t.xcbn003
                  NEXT FIELD CURRENT
               END IF
            
            END IF
            
            #此段落由子樣板a05產生
            IF  g_xcbn_m.xcbn001 IS NOT NULL AND g_xcbn_m.xcbn002 IS NOT NULL AND g_xcbn_d[g_detail_idx].xcbn003 IS NOT NULL AND g_xcbn_d[g_detail_idx].xcbn004 IS NOT NULL AND g_xcbn_d[g_detail_idx].xcbn005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcbn_m.xcbn001 != g_xcbn001_t OR g_xcbn_m.xcbn002 != g_xcbn002_t OR g_xcbn_d[g_detail_idx].xcbn003 != g_xcbn_d_t.xcbn003 OR g_xcbn_d[g_detail_idx].xcbn004 != g_xcbn_d_t.xcbn004 OR g_xcbn_d[g_detail_idx].xcbn005 != g_xcbn_d_t.xcbn005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbn_t WHERE "||"xcbnent = '" ||g_enterprise|| "' AND "||"xcbn001 = '"||g_xcbn_m.xcbn001 ||"' AND "|| "xcbn002 = '"||g_xcbn_m.xcbn002 ||"' AND "|| "xcbn003 = '"||g_xcbn_d[g_detail_idx].xcbn003 ||"' AND "|| "xcbn004 = '"||g_xcbn_d[g_detail_idx].xcbn004 ||"' AND "|| "xcbn005 = '"||g_xcbn_d[g_detail_idx].xcbn005 ||"'",'std-00004',0) THEN 
                     LET g_xcbn_d[l_ac].xcbn003=g_xcbn_d_t.xcbn003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL axci301_xcbn003_desc(g_xcbn_d[l_ac].xcbn003) RETURNING g_xcbn_d[l_ac].xcbn003_desc
            DISPLAY BY NAME g_xcbn_d[l_ac].xcbn003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn003
            #add-point:BEFORE FIELD xcbn003 name="input.b.page1.xcbn003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn003
            #add-point:ON CHANGE xcbn003 name="input.g.page1.xcbn003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn004
            
            #add-point:AFTER FIELD xcbn004 name="input.a.page1.xcbn004"
            IF NOT cl_null(g_xcbn_d[l_ac].xcbn004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcbn_d[l_ac].xcbn004 
               #160318-00025#36  2016/05/18  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#36  2016/05/18  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001_11") THEN            #161019-00017#7 marked
               IF cl_chk_exist("v_ooef001_13") THEN            #161019-00017#7 add
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcbn_d[l_ac].xcbn004=g_xcbn_d_t.xcbn004
                  NEXT FIELD CURRENT
               END IF
            
            END IF 
            
            #此段落由子樣板a05產生
            IF  g_xcbn_m.xcbn001 IS NOT NULL AND g_xcbn_m.xcbn002 IS NOT NULL AND g_xcbn_d[g_detail_idx].xcbn003 IS NOT NULL AND g_xcbn_d[g_detail_idx].xcbn004 IS NOT NULL AND g_xcbn_d[g_detail_idx].xcbn005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcbn_m.xcbn001 != g_xcbn001_t OR g_xcbn_m.xcbn002 != g_xcbn002_t OR g_xcbn_d[g_detail_idx].xcbn003 != g_xcbn_d_t.xcbn003 OR g_xcbn_d[g_detail_idx].xcbn004 != g_xcbn_d_t.xcbn004 OR g_xcbn_d[g_detail_idx].xcbn005 != g_xcbn_d_t.xcbn005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbn_t WHERE "||"xcbnent = '" ||g_enterprise|| "' AND "||"xcbn001 = '"||g_xcbn_m.xcbn001 ||"' AND "|| "xcbn002 = '"||g_xcbn_m.xcbn002 ||"' AND "|| "xcbn003 = '"||g_xcbn_d[g_detail_idx].xcbn003 ||"' AND "|| "xcbn004 = '"||g_xcbn_d[g_detail_idx].xcbn004 ||"' AND "|| "xcbn005 = '"||g_xcbn_d[g_detail_idx].xcbn005 ||"'",'std-00004',0) THEN 
                     LET g_xcbn_d[l_ac].xcbn004=g_xcbn_d_t.xcbn004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL axci301_xcbn003_desc(g_xcbn_d[l_ac].xcbn004) RETURNING g_xcbn_d[l_ac].xcbn004_desc
            DISPLAY BY NAME g_xcbn_d[l_ac].xcbn004_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn004
            #add-point:BEFORE FIELD xcbn004 name="input.b.page1.xcbn004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn004
            #add-point:ON CHANGE xcbn004 name="input.g.page1.xcbn004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn010
            
            #add-point:AFTER FIELD xcbn010 name="input.a.page1.xcbn010"
            IF NOT cl_null(g_xcbn_d[l_ac].xcbn010) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcbn_d[l_ac].xcbn010
               #160318-00025#36  2016/05/18  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               #160318-00025#36  2016/05/18  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcbn_d[l_ac].xcbn010=g_xcbn_d_t.xcbn010
                  NEXT FIELD CURRENT
               END IF
            
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn010
            #add-point:BEFORE FIELD xcbn010 name="input.b.page1.xcbn010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn010
            #add-point:ON CHANGE xcbn010 name="input.g.page1.xcbn010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbn_d[l_ac].xcbn102,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbn102
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbn102 name="input.a.page1.xcbn102"
            IF NOT cl_null(g_xcbn_d[l_ac].xcbn102) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102
            #add-point:BEFORE FIELD xcbn102 name="input.b.page1.xcbn102"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn102
            #add-point:ON CHANGE xcbn102 name="input.g.page1.xcbn102"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102a
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbn_d[l_ac].xcbn102a,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbn102a
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbn102a name="input.a.page1.xcbn102a"
            IF NOT cl_null(g_xcbn_d[l_ac].xcbn102a) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102a
            #add-point:BEFORE FIELD xcbn102a name="input.b.page1.xcbn102a"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn102a
            #add-point:ON CHANGE xcbn102a name="input.g.page1.xcbn102a"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102b
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbn_d[l_ac].xcbn102b,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbn102b
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbn102b name="input.a.page1.xcbn102b"
            IF NOT cl_null(g_xcbn_d[l_ac].xcbn102b) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102b
            #add-point:BEFORE FIELD xcbn102b name="input.b.page1.xcbn102b"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn102b
            #add-point:ON CHANGE xcbn102b name="input.g.page1.xcbn102b"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102c
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbn_d[l_ac].xcbn102c,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbn102c
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbn102c name="input.a.page1.xcbn102c"
            IF NOT cl_null(g_xcbn_d[l_ac].xcbn102c) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102c
            #add-point:BEFORE FIELD xcbn102c name="input.b.page1.xcbn102c"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn102c
            #add-point:ON CHANGE xcbn102c name="input.g.page1.xcbn102c"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102d
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbn_d[l_ac].xcbn102d,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbn102d
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbn102d name="input.a.page1.xcbn102d"
            IF NOT cl_null(g_xcbn_d[l_ac].xcbn102d) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102d
            #add-point:BEFORE FIELD xcbn102d name="input.b.page1.xcbn102d"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn102d
            #add-point:ON CHANGE xcbn102d name="input.g.page1.xcbn102d"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102e
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbn_d[l_ac].xcbn102e,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbn102e
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbn102e name="input.a.page1.xcbn102e"
            IF NOT cl_null(g_xcbn_d[l_ac].xcbn102e) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102e
            #add-point:BEFORE FIELD xcbn102e name="input.b.page1.xcbn102e"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn102e
            #add-point:ON CHANGE xcbn102e name="input.g.page1.xcbn102e"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102f
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbn_d[l_ac].xcbn102f,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbn102f
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbn102f name="input.a.page1.xcbn102f"
            IF NOT cl_null(g_xcbn_d[l_ac].xcbn102f) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102f
            #add-point:BEFORE FIELD xcbn102f name="input.b.page1.xcbn102f"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn102f
            #add-point:ON CHANGE xcbn102f name="input.g.page1.xcbn102f"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102g
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbn_d[l_ac].xcbn102g,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbn102g
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbn102g name="input.a.page1.xcbn102g"
            IF NOT cl_null(g_xcbn_d[l_ac].xcbn102g) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102g
            #add-point:BEFORE FIELD xcbn102g name="input.b.page1.xcbn102g"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn102g
            #add-point:ON CHANGE xcbn102g name="input.g.page1.xcbn102g"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbn102h
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbn_d[l_ac].xcbn102h,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbn102h
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbn102h name="input.a.page1.xcbn102h"
            IF NOT cl_null(g_xcbn_d[l_ac].xcbn102h) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbn102h
            #add-point:BEFORE FIELD xcbn102h name="input.b.page1.xcbn102h"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbn102h
            #add-point:ON CHANGE xcbn102h name="input.g.page1.xcbn102h"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcbn005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn005
            #add-point:ON ACTION controlp INFIELD xcbn005 name="input.c.page1.xcbn005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbn_d[l_ac].xcbn005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imaf001()                                #呼叫開窗

            LET g_xcbn_d[l_ac].xcbn005 = g_qryparam.return1              

            DISPLAY g_xcbn_d[l_ac].xcbn005 TO xcbn005              #

            NEXT FIELD xcbn005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn006
            #add-point:ON ACTION controlp INFIELD xcbn006 name="input.c.page1.xcbn006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbn003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn003
            #add-point:ON ACTION controlp INFIELD xcbn003 name="input.c.page1.xcbn003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " (ooef003 = 'Y' OR ooef201 = 'Y' OR ooef202 = 'Y' ) " #161019-00017#7 marked
            LET g_qryparam.default1 = g_xcbn_d[l_ac].xcbn003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
#            CALL q_ooef001_10()                                #呼叫開窗    #161019-00017#7 marked
            CALL q_ooef001_1()                                 #呼叫開窗    #161019-00017#7 add

            LET g_xcbn_d[l_ac].xcbn003 = g_qryparam.return1              

            DISPLAY g_xcbn_d[l_ac].xcbn003 TO xcbn003              #

            NEXT FIELD xcbn003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbn004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn004
            #add-point:ON ACTION controlp INFIELD xcbn004 name="input.c.page1.xcbn004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " (ooef003 = 'Y' OR ooef201 = 'Y' OR ooef202 = 'Y' ) "      #161019-00017#7 marked
            LET g_qryparam.default1 = g_xcbn_d[l_ac].xcbn004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
#            CALL q_ooef001_10()                                #呼叫開窗 #161019-00017#7 marked
            CALL q_ooef001_1()                                #呼叫開窗 #161019-00017#7 add

            LET g_xcbn_d[l_ac].xcbn004 = g_qryparam.return1              

            DISPLAY g_xcbn_d[l_ac].xcbn004 TO xcbn004              #

            NEXT FIELD xcbn004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbn010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn010
            #add-point:ON ACTION controlp INFIELD xcbn010 name="input.c.page1.xcbn010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbn_d[l_ac].xcbn010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooai001()                                #呼叫開窗

            LET g_xcbn_d[l_ac].xcbn010 = g_qryparam.return1              

            DISPLAY g_xcbn_d[l_ac].xcbn010 TO xcbn010              #

            NEXT FIELD xcbn010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbn102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102
            #add-point:ON ACTION controlp INFIELD xcbn102 name="input.c.page1.xcbn102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbn102a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102a
            #add-point:ON ACTION controlp INFIELD xcbn102a name="input.c.page1.xcbn102a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbn102b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102b
            #add-point:ON ACTION controlp INFIELD xcbn102b name="input.c.page1.xcbn102b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbn102c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102c
            #add-point:ON ACTION controlp INFIELD xcbn102c name="input.c.page1.xcbn102c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbn102d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102d
            #add-point:ON ACTION controlp INFIELD xcbn102d name="input.c.page1.xcbn102d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbn102e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102e
            #add-point:ON ACTION controlp INFIELD xcbn102e name="input.c.page1.xcbn102e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbn102f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102f
            #add-point:ON ACTION controlp INFIELD xcbn102f name="input.c.page1.xcbn102f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbn102g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102g
            #add-point:ON ACTION controlp INFIELD xcbn102g name="input.c.page1.xcbn102g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbn102h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbn102h
            #add-point:ON ACTION controlp INFIELD xcbn102h name="input.c.page1.xcbn102h"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcbn_d[l_ac].* = g_xcbn_d_t.*
               CLOSE axci301_bcl
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
               LET g_errparam.extend = g_xcbn_d[l_ac].xcbn003 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcbn_d[l_ac].* = g_xcbn_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xcbn2_d[l_ac].xcbnmodid = g_user 
LET g_xcbn2_d[l_ac].xcbnmoddt = cl_get_current()
LET g_xcbn2_d[l_ac].xcbnmodid_desc = cl_get_username(g_xcbn2_d[l_ac].xcbnmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               IF cl_null(g_xcbn_d[l_ac].xcbn102a) THEN
                  LET g_xcbn_d[l_ac].xcbn102a=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn102b) THEN
                  LET g_xcbn_d[l_ac].xcbn102b=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn102c) THEN
                  LET g_xcbn_d[l_ac].xcbn102c=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn102d) THEN
                  LET g_xcbn_d[l_ac].xcbn102d=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn102e) THEN
                  LET g_xcbn_d[l_ac].xcbn102e=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn102f) THEN
                  LET g_xcbn_d[l_ac].xcbn102f=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn102g) THEN
                  LET g_xcbn_d[l_ac].xcbn102g=0
               END IF
               IF cl_null(g_xcbn_d[l_ac].xcbn102h) THEN
                  LET g_xcbn_d[l_ac].xcbn102h=0
               END IF
               LET g_xcbn_d[l_ac].xcbn102=g_xcbn_d[l_ac].xcbn102a+g_xcbn_d[l_ac].xcbn102b+g_xcbn_d[l_ac].xcbn102c+
                                          g_xcbn_d[l_ac].xcbn102d+g_xcbn_d[l_ac].xcbn102e+g_xcbn_d[l_ac].xcbn102f+
                                          g_xcbn_d[l_ac].xcbn102g+g_xcbn_d[l_ac].xcbn102h
               #end add-point
         
               #將遮罩欄位還原
               CALL axci301_xcbn_t_mask_restore('restore_mask_o')
         
               UPDATE xcbn_t SET (xcbn001,xcbn002,xcbn005,xcbn006,xcbn003,xcbn004,xcbn010,xcbn102,xcbn102a, 
                   xcbn102b,xcbn102c,xcbn102d,xcbn102e,xcbn102f,xcbn102g,xcbn102h,xcbnownid,xcbnowndp, 
                   xcbncrtid,xcbncrtdp,xcbncrtdt,xcbnmodid,xcbnmoddt) = (g_xcbn_m.xcbn001,g_xcbn_m.xcbn002, 
                   g_xcbn_d[l_ac].xcbn005,g_xcbn_d[l_ac].xcbn006,g_xcbn_d[l_ac].xcbn003,g_xcbn_d[l_ac].xcbn004, 
                   g_xcbn_d[l_ac].xcbn010,g_xcbn_d[l_ac].xcbn102,g_xcbn_d[l_ac].xcbn102a,g_xcbn_d[l_ac].xcbn102b, 
                   g_xcbn_d[l_ac].xcbn102c,g_xcbn_d[l_ac].xcbn102d,g_xcbn_d[l_ac].xcbn102e,g_xcbn_d[l_ac].xcbn102f, 
                   g_xcbn_d[l_ac].xcbn102g,g_xcbn_d[l_ac].xcbn102h,g_xcbn2_d[l_ac].xcbnownid,g_xcbn2_d[l_ac].xcbnowndp, 
                   g_xcbn2_d[l_ac].xcbncrtid,g_xcbn2_d[l_ac].xcbncrtdp,g_xcbn2_d[l_ac].xcbncrtdt,g_xcbn2_d[l_ac].xcbnmodid, 
                   g_xcbn2_d[l_ac].xcbnmoddt)
                WHERE xcbnent = g_enterprise AND xcbn001 = g_xcbn_m.xcbn001 
                 AND xcbn002 = g_xcbn_m.xcbn002 
 
                 AND xcbn003 = g_xcbn_d_t.xcbn003 #項次   
                 AND xcbn004 = g_xcbn_d_t.xcbn004  
                 AND xcbn005 = g_xcbn_d_t.xcbn005  
                 AND xcbn006 = g_xcbn_d_t.xcbn006  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcbn_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcbn_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcbn_m.xcbn001
               LET gs_keys_bak[1] = g_xcbn001_t
               LET gs_keys[2] = g_xcbn_m.xcbn002
               LET gs_keys_bak[2] = g_xcbn002_t
               LET gs_keys[3] = g_xcbn_d[g_detail_idx].xcbn003
               LET gs_keys_bak[3] = g_xcbn_d_t.xcbn003
               LET gs_keys[4] = g_xcbn_d[g_detail_idx].xcbn004
               LET gs_keys_bak[4] = g_xcbn_d_t.xcbn004
               LET gs_keys[5] = g_xcbn_d[g_detail_idx].xcbn005
               LET gs_keys_bak[5] = g_xcbn_d_t.xcbn005
               LET gs_keys[6] = g_xcbn_d[g_detail_idx].xcbn006
               LET gs_keys_bak[6] = g_xcbn_d_t.xcbn006
               CALL axci301_update_b('xcbn_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcbn_m),util.JSON.stringify(g_xcbn_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcbn_m),util.JSON.stringify(g_xcbn_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axci301_xcbn_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcbn_m.xcbn001
               LET ls_keys[ls_keys.getLength()+1] = g_xcbn_m.xcbn002
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcbn_d_t.xcbn003
               LET ls_keys[ls_keys.getLength()+1] = g_xcbn_d_t.xcbn004
               LET ls_keys[ls_keys.getLength()+1] = g_xcbn_d_t.xcbn005
               LET ls_keys[ls_keys.getLength()+1] = g_xcbn_d_t.xcbn006
 
               CALL axci301_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axci301_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcbn_d[l_ac].* = g_xcbn_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axci301_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcbn_d.getLength() = 0 THEN
               NEXT FIELD xcbn003
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcbn_d[li_reproduce_target].* = g_xcbn_d[li_reproduce].*
               LET g_xcbn2_d[li_reproduce_target].* = g_xcbn2_d[li_reproduce].*
 
               LET g_xcbn_d[li_reproduce_target].xcbn003 = NULL
               LET g_xcbn_d[li_reproduce_target].xcbn004 = NULL
               LET g_xcbn_d[li_reproduce_target].xcbn005 = NULL
               LET g_xcbn_d[li_reproduce_target].xcbn006 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcbn_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcbn_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_xcbn2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL axci301_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL axci301_idx_chk()
            CALL axci301_ui_detailshow()
        
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
            NEXT FIELD xcbn001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcbn005
               WHEN "s_detail2"
                  NEXT FIELD xcbn005_2
 
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
 
{<section id="axci301.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axci301_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axci301_b_fill(g_wc2) #第一階單身填充
      CALL axci301_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axci301_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xcbn_m.xcbn001,g_xcbn_m.xcbn002
 
   CALL axci301_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axci301.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axci301_ref_show()
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
   FOR l_ac = 1 TO g_xcbn_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xcbn2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
 
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axci301.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axci301_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xcbn_t.xcbn001 
   DEFINE l_oldno     LIKE xcbn_t.xcbn001 
   DEFINE l_newno02     LIKE xcbn_t.xcbn002 
   DEFINE l_oldno02     LIKE xcbn_t.xcbn002 
 
   DEFINE l_master    RECORD LIKE xcbn_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcbn_t.* #此變數樣板目前無使用
 
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
 
   IF g_xcbn_m.xcbn001 IS NULL
      OR g_xcbn_m.xcbn002 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xcbn001_t = g_xcbn_m.xcbn001
   LET g_xcbn002_t = g_xcbn_m.xcbn002
 
   
   LET g_xcbn_m.xcbn001 = ""
   LET g_xcbn_m.xcbn002 = ""
 
   LET g_master_insert = FALSE
   CALL axci301_set_entry('a')
   CALL axci301_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
   
   
   CALL axci301_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcbn_m.* TO NULL
      INITIALIZE g_xcbn_d TO NULL
      INITIALIZE g_xcbn2_d TO NULL
 
      CALL axci301_show()
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
   CALL axci301_set_act_visible()
   CALL axci301_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcbn001_t = g_xcbn_m.xcbn001
   LET g_xcbn002_t = g_xcbn_m.xcbn002
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcbnent = " ||g_enterprise|| " AND",
                      " xcbn001 = '", g_xcbn_m.xcbn001, "' "
                      ," AND xcbn002 = '", g_xcbn_m.xcbn002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axci301_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axci301_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axci301_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axci301.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axci301_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcbn_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axci301_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcbn_t
    WHERE xcbnent = g_enterprise AND xcbn001 = g_xcbn001_t
    AND xcbn002 = g_xcbn002_t
 
       INTO TEMP axci301_detail
   
   #將key修正為調整後   
   UPDATE axci301_detail 
      #更新key欄位
      SET xcbn001 = g_xcbn_m.xcbn001
          , xcbn002 = g_xcbn_m.xcbn002
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , xcbnownid = g_user 
       , xcbnowndp = g_dept
       , xcbncrtid = g_user
       , xcbncrtdp = g_dept 
       , xcbncrtdt = ld_date
       , xcbnmodid = g_user
       , xcbnmoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO xcbn_t SELECT * FROM axci301_detail
   
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
   DROP TABLE axci301_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcbn001_t = g_xcbn_m.xcbn001
   LET g_xcbn002_t = g_xcbn_m.xcbn002
 
   
   DROP TABLE axci301_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axci301.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axci301_delete()
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
   
   IF g_xcbn_m.xcbn001 IS NULL
   OR g_xcbn_m.xcbn002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axci301_cl USING g_enterprise,g_xcbn_m.xcbn001,g_xcbn_m.xcbn002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axci301_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axci301_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axci301_master_referesh USING g_xcbn_m.xcbn001,g_xcbn_m.xcbn002 INTO g_xcbn_m.xcbn001,g_xcbn_m.xcbn002 
 
   
   #遮罩相關處理
   LET g_xcbn_m_mask_o.* =  g_xcbn_m.*
   CALL axci301_xcbn_t_mask()
   LET g_xcbn_m_mask_n.* =  g_xcbn_m.*
   
   CALL axci301_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axci301_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcbn_t WHERE xcbnent = g_enterprise AND xcbn001 = g_xcbn_m.xcbn001
                                                               AND xcbn002 = g_xcbn_m.xcbn002
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcbn_t:",SQLERRMESSAGE 
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
      #   CLOSE axci301_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xcbn_d.clear() 
      CALL g_xcbn2_d.clear()       
 
     
      CALL axci301_ui_browser_refresh()  
      #CALL axci301_ui_headershow()  
      #CALL axci301_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axci301_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axci301_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axci301_cl
 
   #功能已完成,通報訊息中心
   CALL axci301_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axci301.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axci301_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xcbn_d.clear()
   CALL g_xcbn2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xcbn005,xcbn006,xcbn003,xcbn004,xcbn010,xcbn102,xcbn102a,xcbn102b,xcbn102c, 
       xcbn102d,xcbn102e,xcbn102f,xcbn102g,xcbn102h,xcbn005,xcbn003,xcbn004,xcbnownid,xcbnowndp,xcbncrtid, 
       xcbncrtdp,xcbncrtdt,xcbnmodid,xcbnmoddt,t1.imaal003 ,t2.imaal004 ,t3.ooefl003 ,t4.ooefl003 ,t5.ooag011 , 
       t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 FROM xcbn_t",   
               "",
               
                              " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=xcbn005 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xcbn005 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=xcbn003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=xcbn004 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=xcbnownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=xcbnowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=xcbncrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=xcbncrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=xcbnmodid  ",
 
               " WHERE xcbnent= ? AND xcbn001=? AND xcbn002=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcbn_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axci301_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xcbn_t.xcbn003,xcbn_t.xcbn004,xcbn_t.xcbn005,xcbn_t.xcbn006"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axci301_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axci301_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcbn_m.xcbn001,g_xcbn_m.xcbn002   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcbn_m.xcbn001,g_xcbn_m.xcbn002 INTO g_xcbn_d[l_ac].xcbn005, 
          g_xcbn_d[l_ac].xcbn006,g_xcbn_d[l_ac].xcbn003,g_xcbn_d[l_ac].xcbn004,g_xcbn_d[l_ac].xcbn010, 
          g_xcbn_d[l_ac].xcbn102,g_xcbn_d[l_ac].xcbn102a,g_xcbn_d[l_ac].xcbn102b,g_xcbn_d[l_ac].xcbn102c, 
          g_xcbn_d[l_ac].xcbn102d,g_xcbn_d[l_ac].xcbn102e,g_xcbn_d[l_ac].xcbn102f,g_xcbn_d[l_ac].xcbn102g, 
          g_xcbn_d[l_ac].xcbn102h,g_xcbn2_d[l_ac].xcbn005,g_xcbn2_d[l_ac].xcbn003,g_xcbn2_d[l_ac].xcbn004, 
          g_xcbn2_d[l_ac].xcbnownid,g_xcbn2_d[l_ac].xcbnowndp,g_xcbn2_d[l_ac].xcbncrtid,g_xcbn2_d[l_ac].xcbncrtdp, 
          g_xcbn2_d[l_ac].xcbncrtdt,g_xcbn2_d[l_ac].xcbnmodid,g_xcbn2_d[l_ac].xcbnmoddt,g_xcbn_d[l_ac].xcbn005_desc, 
          g_xcbn_d[l_ac].xcbn005_desc_desc,g_xcbn_d[l_ac].xcbn003_desc,g_xcbn_d[l_ac].xcbn004_desc,g_xcbn2_d[l_ac].xcbnownid_desc, 
          g_xcbn2_d[l_ac].xcbnowndp_desc,g_xcbn2_d[l_ac].xcbncrtid_desc,g_xcbn2_d[l_ac].xcbncrtdp_desc, 
          g_xcbn2_d[l_ac].xcbnmodid_desc   #(ver:49)
                             
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
 
            CALL g_xcbn_d.deleteElement(g_xcbn_d.getLength())
      CALL g_xcbn2_d.deleteElement(g_xcbn2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcbn_d.getLength()
      LET g_xcbn_d_mask_o[l_ac].* =  g_xcbn_d[l_ac].*
      CALL axci301_xcbn_t_mask()
      LET g_xcbn_d_mask_n[l_ac].* =  g_xcbn_d[l_ac].*
   END FOR
   
   LET g_xcbn2_d_mask_o.* =  g_xcbn2_d.*
   FOR l_ac = 1 TO g_xcbn2_d.getLength()
      LET g_xcbn2_d_mask_o[l_ac].* =  g_xcbn2_d[l_ac].*
      CALL axci301_xcbn_t_mask()
      LET g_xcbn2_d_mask_n[l_ac].* =  g_xcbn2_d[l_ac].*
   END FOR
 
 
   FREE axci301_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axci301.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axci301_idx_chk()
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
      IF g_detail_idx > g_xcbn_d.getLength() THEN
         LET g_detail_idx = g_xcbn_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xcbn_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcbn_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xcbn2_d.getLength() THEN
         LET g_detail_idx = g_xcbn2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcbn2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcbn2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axci301.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axci301_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcbn_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axci301.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axci301_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xcbn_t
    WHERE xcbnent = g_enterprise AND xcbn001 = g_xcbn_m.xcbn001 AND
                              xcbn002 = g_xcbn_m.xcbn002 AND
 
          xcbn003 = g_xcbn_d_t.xcbn003
      AND xcbn004 = g_xcbn_d_t.xcbn004
      AND xcbn005 = g_xcbn_d_t.xcbn005
      AND xcbn006 = g_xcbn_d_t.xcbn006
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcbn_t:",SQLERRMESSAGE 
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
 
{<section id="axci301.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axci301_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axci301.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axci301_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axci301.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axci301_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axci301.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axci301_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcbn_d[l_ac].xcbn003 = g_xcbn_d_t.xcbn003 
      AND g_xcbn_d[l_ac].xcbn004 = g_xcbn_d_t.xcbn004 
      AND g_xcbn_d[l_ac].xcbn005 = g_xcbn_d_t.xcbn005 
      AND g_xcbn_d[l_ac].xcbn006 = g_xcbn_d_t.xcbn006 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axci301.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axci301_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axci301.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axci301_lock_b(ps_table,ps_page)
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
   #CALL axci301_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axci301.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axci301_unlock_b(ps_table,ps_page)
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
 
{<section id="axci301.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axci301_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcbn001,xcbn002",TRUE)
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
 
{<section id="axci301.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axci301_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcbn001,xcbn002",FALSE)
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
 
{<section id="axci301.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axci301_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axci301.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axci301_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axci301.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axci301_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axci301.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axci301_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axci301.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axci301_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axci301.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axci301_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axci301.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axci301_default_search()
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
      LET ls_wc = ls_wc, " xcbn001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcbn002 = '", g_argv[02], "' AND "
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
 
{<section id="axci301.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axci301_fill_chk(ps_idx)
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
 
{<section id="axci301.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axci301_modify_detail_chk(ps_record)
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
         LET ls_return = "xcbn005"
      WHEN "s_detail2"
         LET ls_return = "xcbn005_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axci301.mask_functions" >}
&include "erp/axc/axci301_mask.4gl"
 
{</section>}
 
{<section id="axci301.state_change" >}
    
 
{</section>}
 
{<section id="axci301.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axci301_set_pk_array()
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
   LET g_pk_array[1].values = g_xcbn_m.xcbn001
   LET g_pk_array[1].column = 'xcbn001'
   LET g_pk_array[2].values = g_xcbn_m.xcbn002
   LET g_pk_array[2].column = 'xcbn002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axci301.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axci301_msgcentre_notify(lc_state)
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
   CALL axci301_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcbn_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axci301.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取營運據點說明
# Memo...........:
# Usage..........: CALL axci301_xcbn003_desc(p_xcbn003)
#                  RETURNING r_desc
# Input parameter: p_xcbn003      營運據點編號
# Return code....: r_desc         說明
# Date & Author..: 2014/4/23 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axci301_xcbn003_desc(p_xcbn003)
   DEFINE p_xcbn003         LIKE xcbn_t.xcbn003
   DEFINE r_desc            LIKE ooefl_t.ooefl003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xcbn003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 獲取品名規格
# Memo...........:
# Usage..........: CALL axci301_xcbn005_desc(p_xcbn005)
#                  RETURNING r_imaal003,r_imaal004
# Input parameter: p_xcbn005      料號
# Return code....: r_imaal003     品名
#                : r_imaal004     規格
# Date & Author..: 14/4/23 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axci301_xcbn005_desc(p_xcbn005)
   DEFINE p_xcbn005         LIKE xcbn_t.xcbn005
   DEFINE r_imaal003        LIKE imaal_t.imaal003
   DEFINE r_imaal004        LIKE imaal_t.imaal004
   
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = p_xcbn005
   CALL ap_ref_array2(g_ref_fields," SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND imaal001 = ? AND imaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET r_imaal003 = g_rtn_fields[1] 
   LET r_imaal004 = g_rtn_fields[2]
   RETURN r_imaal003,r_imaal004
END FUNCTION

################################################################################
# Descriptions...: 根據畫面table導出Excel格式
# Memo...........:
# Usage..........: CALL axci301_excelexample(n,t,p_show_hidden)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/04/24 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axci301_excelexample(n,t,p_show_hidden)
   DEFINE  t,t1,t2,n1_text,n3_text         om.DomNode,
         n,n2,n_child                    om.DomNode,
           p_show_hidden                   LIKE type_t.chr1,    #隱藏欄位是否顯示
           n1,n_table,n3                   om.NodeList,
           i,res,p,q,k                     LIKE type_t.num10,
           h                               LIKE type_t.num10,
           cnt_combo_data,cnt_combo_tot    LIKE type_t.num10,
           cells,values,j,l,sheet,cc       STRING,
           table_name,l_length             STRING,
           l_table_name                    LIKE type_t.chr20,
           l_datatype                      LIKE type_t.chr20,
           l_bufstr                        base.StringBuffer,
           lwin_curr                       ui.Window,
           l_show                          LIKE type_t.chr1,
           l_time                          LIKE type_t.chr8
   
   DEFINE  combo_arr        DYNAMIC ARRAY OF RECORD
             sheet          LIKE type_t.num10,
             seq            LIKE type_t.num10,
             name           LIKE type_t.chr2,
             text           LIKE type_t.chr50
                            END RECORD
   DEFINE  customize_table  LIKE type_t.chr1
   DEFINE  l_str            STRING
   DEFINE  l_i              LIKE type_t.num5
   DEFINE  buf              base.StringBuffer
   DEFINE  l_dec_point      STRING,
           l_qry_name       LIKE type_t.chr20,
           l_cust           LIKE type_t.chr1
   DEFINE  l_tabIndex       LIKE type_t.num10
   DEFINE  l_seq            DYNAMIC ARRAY OF LIKE type_t.num10
   DEFINE  l_seq2           DYNAMIC ARRAY OF LIKE type_t.num10
   DEFINE  l_j              LIKE type_t.num5
   DEFINE  bFound           LIKE type_t.num5
   DEFINE  l_dbname         STRING
   DEFINE  l_zal09          LIKE type_t.chr1
   DEFINE  l_desc           STRING
   DEFINE  l_cnt_table      LIKE type_t.num10
   DEFINE  l_cnt_header      LIKE type_t.num10
   DEFINE  ms_codeset       STRING
   DEFINE  ms_locale        STRING
   DEFINE  tsconv_cmd       STRING
   DEFINE  l_win_name       STRING
   
   WHENEVER ERROR CALL cl_err_msg_log

   LET l_cnt_table = 1

   LET l_bufstr = base.StringBuffer.create()
   WHENEVER ERROR CALL cl_err_msg_log
   LET lwin_curr = ui.window.getCurrent()

   LET g_channel = base.Channel.create()
   LET l_time = TIME(CURRENT)
   LET xls_name = g_xcbn_s.name CLIPPED,".xls"

   LET buf = base.StringBuffer.create()
   CALL buf.append(xls_name)
   CALL buf.replace( ":","-", 0)
   LET xls_name = buf.toString()

   # 個資會記錄使用者的行為模式，在此說明excel的檔名及匯出excel的方式
   LET l_desc = xls_name CLIPPED," Using HTML to export the Table to excel."

   IF os.Path.delete(xls_name CLIPPED) THEN END IF
   CALL g_channel.openFile( xls_name CLIPPED, "a" )
   CALL g_channel.setDelimiter("")

   IF ms_codeset.getIndexOf("BIG5", 1) OR
      ( ms_codeset.getIndexOf("GB2312", 1) OR ms_codeset.getIndexOf("GBK", 1) OR ms_codeset.getIndexOf("GB18030", 1) ) THEN
      IF ms_locale = "ZH_TW" AND g_lang = "ZH_TW" THEN
         LET tsconv_cmd = "big5_to_gb2312"
         LET ms_codeset = "GB2312"
      END IF
      IF ms_locale = "ZH_CN" AND g_lang = "ZH_CN" THEN
         LET tsconv_cmd = "gb2312_to_big5"
         LET ms_codeset = "BIG5"
      END IF
   END IF

   LET l_str = "<html xmlns:o=",g_quote,"urn:schemas-microsoft-com:office:office",g_quote
   CALL g_channel.write(l_str CLIPPED)
   LET l_str = "<meta http-equiv=Content-Type content=",g_quote,"text/html; charset=",ms_codeset,g_quote,">"
   CALL g_channel.write(l_str CLIPPED)
   LET l_str = "xmlns:x=",g_quote,"urn:schemas-microsoft-com:office:excel",g_quote
   CALL g_channel.write(l_str CLIPPED)
   LET l_str = "xmlns=",g_quote,"http://www.w3.org/TR/REC-html40",g_quote,">"
   CALL g_channel.write(l_str CLIPPED)
   CALL g_channel.write("<head><style><!--")

   IF not ms_codeset.getIndexOf("UTF-8", 1) THEN
      IF g_lang = "zh_TW" THEN  #繁體中文
         CALL g_channel.write("td  {font-family:細明體, serif;}")
      ELSE
         IF g_lang = "zh_CN" THEN  #簡體中文
            CALL g_channel.write("td  {font-family:新宋体, serif;}")
         ELSE
            CALL g_channel.write("td  {font-family:細明體, serif;}")
         END IF
      END IF
   ELSE
      CALL g_channel.write("td  {font-family:Courier New, serif;}")
   END IF

   LET l_str = ".xl24  {mso-number-format:",g_quote,"\@",g_quote,";}",
               ".xl30 {mso-style-parent:style0; mso-number-format:\"0_ \";} ",
               ".xl31 {mso-style-parent:style0; mso-number-format:\"0\.0_ \";} ",
               ".xl32 {mso-style-parent:style0; mso-number-format:\"0\.00_ \";} ",
               ".xl33 {mso-style-parent:style0; mso-number-format:\"0\.000_ \";} ",
               ".xl34 {mso-style-parent:style0; mso-number-format:\"0\.0000_ \";} ",
               ".xl35 {mso-style-parent:style0; mso-number-format:\"0\.00000_ \";} ",
               ".xl36 {mso-style-parent:style0; mso-number-format:\"0\.000000_ \";} ",
               ".xl37 {mso-style-parent:style0; mso-number-format:\"0\.0000000_ \";} ",
               ".xl38 {mso-style-parent:style0; mso-number-format:\"0\.00000000_ \";} ",
               ".xl39 {mso-style-parent:style0; mso-number-format:\"0\.000000000_ \";} ",
               ".xl40 {mso-style-parent:style0; mso-number-format:\"0\.0000000000_ \";} "
   CALL g_channel.write(l_str CLIPPED)
   CALL g_channel.write("--></style>")
   CALL g_channel.write("<!--[if gte mso 9]><xml>")
   CALL g_channel.write("<x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>")
   CALL g_channel.write("<x:DefaultRowHeight>330</x:DefaultRowHeight>")
   CALL g_channel.write("</xml><![endif]--></head>")
   CALL g_channel.write("<body><table border=1 cellpadding=0 cellspacing=0 width=432 style='border-collapse: collapse;table-layout:fixed;width:324pt'>")
   CALL g_channel.write("<tr height=22>")

   LET l_win_name = NULL
   LET l_win_name = n.getAttribute("name")

   LET n_table = n.selectByTagName("Table")
   CALL combo_arr.clear()
   FOR h=1 to l_cnt_table
      CALL g_hidden.clear()
      CALL g_ifchar.clear()
      CALL g_mask.clear()
      LET n2 = n_table.item(h)

      IF l_win_name = "p_dbqry_table" THEN
         LET n1 = n2.selectByPath("//TableColumn[@hidden=\"0\"]")
      ELSE
         LET n1 = n2.selectByTagName("TableColumn")
      END IF

      #抓取 table 是否有進行欄位排序
      INITIALIZE g_sort.* TO NULL
      LET g_sort.column = n2.getAttribute("sortColumn")
      IF g_sort.column >=0 AND g_sort.column IS NOT NULL  THEN
         LET g_sort.column = g_sort.column + 1    #屬性 sortColumn 為 0 開始
         LET g_sort.type = n2.getAttribute("sortType")
      END IF

      LET l_cnt_header = n1.getLength()
      LET l = h
      LET sheet=g_sheet  CLIPPED,l
      LET k = 0

      CALL l_seq.clear()
      CALL l_seq2.clear()

     #循環Table中的每一個列
     FOR i=1 TO l_cnt_header
       #得到對應的DomNode節點
       LET n1_text = n1.item(i)
       #得到該列的TabIndex屬性
       LET l_tabIndex = n1_text.getAttribute("tabIndex")

       #如果TabIndex屬性不為空
       IF NOT cl_null(l_tabIndex) THEN
          #初始化一個標志變量（表明是否在數組中找到比當前TabIndex更大的節點）
          LET bFound = FALSE
          #開始在已有的數組中定位比當前tabIndex大的成員
          FOR l_j=1 TO l_seq2.getLength()
              #如果有找到
              IF l_seq2[l_j] > l_tabIndex THEN
                 #設置標志變量
                 LET bFound = TRUE
                 #退出搜尋過程（此時下標j保存的該成員變量的位置）
                 EXIT FOR
              END IF
          END FOR
          #如果始終沒有找到（比如數組根本就是空的）那麼j里面保存的就是當前數組最大下標+1
          #判斷有沒有找到
          IF bFound THEN
             #如果找到則向該數組中插入一個元素（在這個tabIndex比它大的元素前面插入)
             CALL l_seq2.InsertElement(l_j)
             CALL l_seq.InsertElement(l_j)
          END IF
          #把當前的下標（列的位置）和tabIndex填充到這個位置上
          #如果沒有找到，則填充的位置會是整個數組的末尾
          LET l_seq[l_j] = i
          LET l_seq2[l_j] = l_tabIndex
       END IF
     END FOR

      FOR i=1 to l_cnt_header
         LET n1_text = n1.item(l_seq[i])
         LET k = k + 1
         LET j = k
         LET cells = "R1C" CLIPPED,j
         LET g_field_name = NULL
         LET l_show = n1_text.getAttribute("hidden")
         IF ((p_show_hidden = 'N' OR p_show_hidden IS NULL) AND (l_show = "0" OR l_show IS NULL)) OR p_show_hidden = 'Y' THEN
            LET g_field_name = n1_text.getAttribute("name")
            IF g_field_name = 'xcbn_t.xcbnent' OR g_field_name = 'xcbn_t.xcbn001' OR
               g_field_name = 'xcbn_t.xcbn002' OR g_field_name = 'xcbn_t.xcbn003' OR
               g_field_name = 'xcbn_t.xcbn004' OR g_field_name = 'xcbn_t.xcbn005' OR
               g_field_name = 'xcbn_t.xcbn006' OR
               g_field_name = 'xcbn_t.xcbn010' OR g_field_name = 'xcbn_t.xcbn102' OR
               g_field_name = 'xcbn_t.xcbn102a' OR g_field_name = 'xcbn_t.xcbn102b' OR
               g_field_name = 'xcbn_t.xcbn102c' OR g_field_name = 'xcbn_t.xcbn102d' OR
               g_field_name = 'xcbn_t.xcbn102e' OR g_field_name = 'xcbn_t.xcbn102f' OR
               g_field_name = 'xcbn_t.xcbn102g' OR g_field_name = 'xcbn_t.xcbn102h' 
               THEN
               LET values = n1_text.getAttribute("text")
               LET l_str = "<td>",axci301_add_span(values),"</td>"
               CALL g_channel.write(l_str CLIPPED)
            END IF
         ELSE
            LET g_hidden[i] = "1"
            LET k = k -1
         END IF
      END FOR
      IF h=1 THEN CALL axci301_get_boday(h,l_cnt_header,t,combo_arr,l_seq) END IF

   END FOR

   # 使用者的行為模式改到前面判斷，在此僅將前面判斷的結果說明傳至syslog中做紀錄
   IF cl_log_sys_operation("A","G",l_desc) THEN
   END IF
END FUNCTION

################################################################################
# Descriptions...: 匯出格式
# Memo...........:
# Usage..........: CALL axci301_s01()
# Date & Author..: 2014/04/24 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axci301_s01()
   DEFINE ls_str         STRING
   DEFINE l_chr          LIKE type_t.chr1
   DEFINE l_chr1         LIKE type_t.chr1
   DEFINE l_num          LIKE type_t.num5
   
   OPEN WINDOW w_axci301_s01 WITH FORM cl_ap_formpath("axc","axci301_s01")
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_xcbn_s.name,g_xcbn_s.dir
         BEFORE INPUT
           

         AFTER INPUT         
            

      END INPUT
      
      DISPLAY ARRAY g_xcbn3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               
               LET g_current_page = 3
               
         
         END DISPLAY

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG
      
      ON ACTION produce
         LET w = ui.Window.getCurrent()
         LET f = w.getForm()
         LET page = f.FindNode("Page","page3")
         CALL axci301_excelexample(page,base.TypeInfo.create(g_xcbn3_d),'Y')
         ACCEPT DIALOG

      ON ACTION off
         LET INT_FLAG = TRUE
         EXIT DIALOG
      
      ON ACTION browser
         CALL cl_client_browse_dir() RETURNING g_xcbn_s.dir
         LET ls_str = g_xcbn_s.dir
         #抓取目录斜杆
         LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
         LET l_chr = ls_str.substring(l_num+1,l_num+1)                        #截取冒号后的字符 
         LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())    #判断是否为根目录
         IF l_chr <> l_chr1  THEN
            LET g_xcbn_s.dir = g_xcbn_s.dir||l_chr
         ELSE
            LET g_xcbn_s.dir = g_xcbn_s.dir
         END IF
         DISPLAY BY NAME g_xcbn_s.dir


   END DIALOG

   #畫面關閉
      CLOSE WINDOW w_axci301_s01
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axci301_get_boday(p_h,p_cnt_header,s,s_combo_arr,p_seq)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/04/24 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axci301_get_boday(p_h,p_cnt_header,s,s_combo_arr,p_seq)
   DEFINE  s,n1_text                          om.DomNode,
           n1                                 om.NodeList,
           i,m,k,cnt_body,res,p               LIKE type_t.num10,
           l_hidden_cnt,n,l_last_hidden       LIKE type_t.num10,
           p_h,p_cnt_header,arr_len           LIKE type_t.num10,
           p_null                             LIKE type_t.num10,
           cells,values,j,l,sheet             STRING,
           l_bufstr                           base.StringBuffer
  
   DEFINE  s_combo_arr    DYNAMIC ARRAY OF RECORD
            sheet         LIKE type_t.num10,       #sheet
            seq           LIKE type_t.num10,       #項次
            name          LIKE type_t.chr2,        #代號
            text          LIKE type_t.chr50        #說明
                          END RECORD
   DEFINE  p_seq          DYNAMIC ARRAY OF LIKE type_t.num10
   DEFINE  l_item         LIKE type_t.num10
  
   DEFINE  unix_path      STRING,
           window_path    STRING
   DEFINE  l_dom_doc      om.DomDocument,
           r,n_node       om.DomNode
   DEFINE  l_status       LIKE type_t.num5

   LET l_hidden_cnt = 0
   LET l = p_h
   LET sheet=g_sheet CLIPPED,l
   LET l_bufstr = base.StringBuffer.create()
   LET l = 0
   LET i = 0
   LET m = 0

   CALL g_channel.write("</tr></table></body></html>")
   CALL g_channel.close()

   LET unix_path = os.Path.join(FGL_GETENV("TEMPDIR"),xls_name CLIPPED)

  #LET window_path = "c:\\TT\\",xls_name CLIPPED
   LET window_path = g_xcbn_s.dir,"\\",xls_name CLIPPED
   LET status = cl_client_download_file(unix_path, window_path)
   IF status then
      DISPLAY "Download OK!!"
   ELSE
      DISPLAY "Download fail!!"
   END IF

   LET status = cl_client_open_prog("excel",window_path)
   IF status then
      DISPLAY "Open OK!!"
   ELSE
      DISPLAY "Open fail!!"
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axci301_add_span(p_str)
#                  RETURNING r_str
# Input parameter: p_str     欄位名稱
# Return code....: r_str   
# Date & Author..: 2014/04/24 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axci301_add_span(p_str)
   DEFINE p_str    STRING
   DEFINE r_str    STRING


   LET p_str = p_str.trimRight()

   #若字串有空白就必須加上 <span> 屬性，並將空白轉換為 &nbsp;
   IF p_str.getIndexOf(" ",1) > 0 THEN
      LET g_bufstr = base.StringBuffer.create()   
      CALL g_bufstr.clear()
      CALL g_bufstr.append(p_str)
      CALL g_bufstr.replace(" ","&nbsp;",0)
      CALL g_bufstr.replace("<","&lt;",0)   
      LET r_str = g_bufstr.tostring()
      LET r_str = "<span style='mso-spacerun:yes'>", r_str, "</span>"
   ELSE
      LET g_bufstr = base.StringBuffer.create()
      CALL g_bufstr.clear()
      CALL g_bufstr.append(p_str)
      CALL g_bufstr.replace("<","&lt;",0)
      LET r_str = g_bufstr.tostring()
   END IF

   RETURN r_str
END FUNCTION

 
{</section>}
 
