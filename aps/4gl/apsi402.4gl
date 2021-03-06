#該程式未解開Section, 採用最新樣板產出!
{<section id="apsi402.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2016-06-29 15:29:21), PR版次:0013(2016-09-21 16:08:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000254
#+ Filename...: apsi402
#+ Description: MDS匯總結果維護作業
#+ Creator....: 04441(2014-04-07 09:01:09)
#+ Modifier...: 02749 -SD/PR- 07804
 
{</section>}
 
{<section id="apsi402.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160415-00017#1   2016/04/21  By dorislai  修正1.DECLARE apsi402_bcl site跟psbb001位子放反的問題
#                                              2. 拿掉 apsi402_bcl多Select的psbbsite
#160318-00025#50  2016/04/26  By 07673     將重複內容的錯誤訊息置換為公用錯誤訊息 
#160509-00009#10  2016/05/20  By ming      新增欄位psbb014保稅否於需求明細頁籤下，產品特徵欄位後方
#160701-00033#1   2016/07/14  By dorislai  修正查詢料件編號，沒有作用的問題
#160907-00034#1   2016/09/21  By Ann_Huang 修正查詢條件時,在取得年月條件時要把單身料件編號考慮進來
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
PRIVATE type type_g_psbb_m        RECORD
       psbb001 LIKE psbb_t.psbb001, 
   psbb001_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_psbb_d        RECORD
       psbb012 LIKE psbb_t.psbb012, 
   psbb013 LIKE psbb_t.psbb013, 
   psbb002 LIKE psbb_t.psbb002, 
   psbbdocno LIKE psbb_t.psbbdocno, 
   psbbseq LIKE psbb_t.psbbseq, 
   psbbseq1 LIKE psbb_t.psbbseq1, 
   psbbseq2 LIKE psbb_t.psbbseq2, 
   psbb003 LIKE psbb_t.psbb003, 
   psbb003_desc_desc LIKE type_t.chr500, 
   psbb003_desc LIKE type_t.chr500, 
   psbb004 LIKE psbb_t.psbb004, 
   psbb014 LIKE psbb_t.psbb014, 
   psbb007 LIKE psbb_t.psbb007, 
   psbb005 LIKE psbb_t.psbb005, 
   psbb005_desc LIKE type_t.chr500, 
   psbb006 LIKE psbb_t.psbb006, 
   psbb008 LIKE psbb_t.psbb008, 
   psbb008_desc LIKE type_t.chr500, 
   psbb010 LIKE psbb_t.psbb010, 
   psbb010_desc LIKE type_t.chr500, 
   psbb009 LIKE psbb_t.psbb009, 
   psbb009_desc LIKE type_t.chr500, 
   psbb011 LIKE psbb_t.psbb011, 
   psbb011_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_psbb2_d RECORD
   psbb003b LIKE type_t.chr500, 
   psbb003b_desc_desc LIKE type_t.chr500, 
   psbb003b_desc LIKE type_t.chr500, 
   pre LIKE type_t.chr80, 
   d1 LIKE type_t.chr80, 
   d2 LIKE type_t.chr80, 
   d3 LIKE type_t.chr80, 
   d4 LIKE type_t.chr80, 
   d5 LIKE type_t.chr80, 
   d6 LIKE type_t.chr80, 
   d7 LIKE type_t.chr80, 
   d8 LIKE type_t.chr80, 
   d9 LIKE type_t.chr80, 
   d10 LIKE type_t.chr80, 
   d11 LIKE type_t.chr80, 
   d12 LIKE type_t.chr80, 
   d13 LIKE type_t.chr80, 
   d14 LIKE type_t.chr80, 
   d15 LIKE type_t.chr80, 
   d16 LIKE type_t.chr80, 
   d17 LIKE type_t.chr80, 
   d18 LIKE type_t.chr80, 
   d19 LIKE type_t.chr80, 
   d20 LIKE type_t.chr80, 
   d21 LIKE type_t.chr80, 
   d22 LIKE type_t.chr80, 
   d23 LIKE type_t.chr80, 
   d24 LIKE type_t.chr80, 
   d25 LIKE type_t.chr80, 
   d26 LIKE type_t.chr80, 
   d27 LIKE type_t.chr80, 
   d28 LIKE type_t.chr80, 
   d29 LIKE type_t.chr80, 
   d30 LIKE type_t.chr80, 
   d31 LIKE type_t.chr80, 
   late LIKE type_t.chr80, 
   tot LIKE type_t.chr80
       END RECORD
 TYPE type_g_psbb3_d RECORD
   psbb007b LIKE type_t.dat, 
   psbb002b LIKE type_t.chr10, 
   psbbdocnob LIKE type_t.chr20, 
   psbbseqb LIKE type_t.num10, 
   psbbseq1b LIKE type_t.num10, 
   psbbseq2b LIKE type_t.num10, 
   psbb004b LIKE type_t.chr30, 
   psbb006b LIKE type_t.num20_6, 
   psbb008b LIKE type_t.chr10, 
   psbb008b_desc LIKE type_t.chr500, 
   psbb010b LIKE type_t.chr10, 
   psbb010b_desc LIKE type_t.chr500, 
   psbb009b LIKE type_t.chr10, 
   psbb009b_desc LIKE type_t.chr500, 
   psbb011b LIKE type_t.chr10, 
   psbb011b_desc LIKE type_t.chr500, 
   psbb012b LIKE type_t.num10, 
   psbb013b LIKE type_t.chr1
       END RECORD
DEFINE g_psbb2_d   DYNAMIC ARRAY OF type_g_psbb2_d
DEFINE g_psbb2_d_t type_g_psbb2_d
DEFINE g_psbb3_d   DYNAMIC ARRAY OF type_g_psbb3_d
DEFINE g_psbb3_d_t type_g_psbb3_d

DEFINE g_year               LIKE type_t.num5
DEFINE g_month              LIKE type_t.num5
DEFINE l_year               LIKE type_t.chr5
DEFINE l_month              LIKE type_t.chr5
DEFINE l_year_str           STRING
DEFINE l_month_str          STRING
DEFINE l_cnt                LIKE type_t.num5
DEFINE g_page_flag          LIKE type_t.num5
DEFINE g_b_fill             LIKE type_t.num5
DEFINE g_wc2_table2         STRING  #160701-00033#1-add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_psbb_m          type_g_psbb_m
DEFINE g_psbb_m_t        type_g_psbb_m
DEFINE g_psbb_m_o        type_g_psbb_m
DEFINE g_psbb_m_mask_o   type_g_psbb_m #轉換遮罩前資料
DEFINE g_psbb_m_mask_n   type_g_psbb_m #轉換遮罩後資料
 
   DEFINE g_psbb001_t LIKE psbb_t.psbb001
 
 
DEFINE g_psbb_d          DYNAMIC ARRAY OF type_g_psbb_d
DEFINE g_psbb_d_t        type_g_psbb_d
DEFINE g_psbb_d_o        type_g_psbb_d
DEFINE g_psbb_d_mask_o   DYNAMIC ARRAY OF type_g_psbb_d #轉換遮罩前資料
DEFINE g_psbb_d_mask_n   DYNAMIC ARRAY OF type_g_psbb_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_psbb001 LIKE psbb_t.psbb001
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
 
{<section id="apsi402.main" >}
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
   CALL cl_ap_init("aps","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT psbb001,''", 
                      " FROM psbb_t",
                      " WHERE psbbent= ? AND psbbsite= ? AND psbb001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apsi402_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.psbb001,t1.psbal003",
               " FROM psbb_t t0",
                              " LEFT JOIN psbal_t t1 ON t1.psbalent="||g_enterprise||" AND t1.psbal001=t0.psbb001 AND t1.psbal002='"||g_dlang||"' ",
 
               " WHERE t0.psbbent = " ||g_enterprise|| " AND t0.psbbsite = ? AND t0.psbb001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apsi402_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsi402 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apsi402_init()   
 
      #進入選單 Menu (="N")
      CALL apsi402_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apsi402
      
   END IF 
   
   CLOSE apsi402_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apsi402.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apsi402_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('psbb002','5428') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("psbb002b",5428)
   CALL cl_set_combo_scc("psbb002",5428)
   CALL cl_set_comp_entry("psbb001",FALSE)
   CALL apsi402_create_temp()
   LET g_page = 0
   #end add-point
   
   CALL apsi402_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apsi402.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apsi402_ui_dialog()
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
   CALL cl_set_toolbaritem_visible("insert,delete,reproduce", FALSE)
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_psbb_m.* TO NULL
         CALL g_psbb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apsi402_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_psbb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL apsi402_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apsi402_ui_detailshow()
               
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
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_psbb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL apsi402_ui_detailshow()
               CALL apsi402_b_fill_detail()
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         END DISPLAY
         
         
         DISPLAY ARRAY g_psbb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
            
            BEFORE DISPLAY 
         
         END DISPLAY


         INPUT g_year,g_month FROM year,month
            ATTRIBUTE(WITHOUT DEFAULTS)
               
            ON CHANGE year
               LET g_year = GET_FLDBUF(year)
               LET g_month = ''
               CALL apsi402_month_combo('1')
               CALL apsi402_button_visible()
               CALL g_psbb2_d.clear()
               CALL g_psbb3_d.clear()
            
            ON CHANGE month
               LET g_month = GET_FLDBUF(month)
               CALL apsi402_button_visible()
               IF NOT cl_null(g_month) THEN
                  CALL apsi402_b_fill_count()
               END IF
               
         END INPUT
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL apsi402_browser_fill("")
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
               CALL apsi402_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apsi402_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            IF g_page_flag = 1 THEN
               LET g_page_flag = 0
               NEXT FIELD psbb012
            END IF
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apsi402_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apsi402_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apsi402_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apsi402_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apsi402_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apsi402_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apsi402_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apsi402_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apsi402_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apsi402_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_psbb_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[1] = base.typeInfo.create(g_psbb2_d)
                  LET g_export_id[1]   = "s_detail2"
                  LET g_export_node[2] = base.typeInfo.create(g_psbb3_d)
                  LET g_export_id[2]   = "s_detail3"
                  LET g_export_node[3] = base.typeInfo.create(g_psbb_d)
                  LET g_export_id[3]   = "s_detail1"

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
               NEXT FIELD psbbdocno
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
               CALL apsi402_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL apsi402_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL apsi402_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION button1
            LET g_action_choice="button1"
            IF cl_auth_chk_act("button1") THEN
               
               #add-point:ON ACTION button1 name="menu.button1"
               LET l_month = ''
               SELECT MAX(mm) INTO l_month
                 FROM date_tmp
                WHERE yy = g_year
                  AND mm < g_month
               IF cl_null(l_month) THEN
                  SELECT MAX(yy) INTO g_year
                    FROM date_tmp
                   WHERE yy < g_year
                  DISPLAY g_year TO year
                  CALL apsi402_month_combo('2')
               ELSE
                  LET g_month = l_month
                  DISPLAY g_month TO month
               END IF
               CALL apsi402_button_visible()
               CALL apsi402_b_fill_count()
               CONTINUE DIALOG
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apsi402_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apsi402_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apsi402_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apsi402_insert()
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
               CALL apsi402_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION button2
            LET g_action_choice="button2"
            IF cl_auth_chk_act("button2") THEN
               
               #add-point:ON ACTION button2 name="menu.button2"
               LET l_month = ''
               SELECT MIN(mm) INTO l_month
                 FROM date_tmp
                WHERE yy = g_year
                  AND mm > g_month
               IF cl_null(l_month) THEN
                  SELECT MIN(yy) INTO g_year
                    FROM date_tmp
                   WHERE yy > g_year
                  DISPLAY g_year TO year
                  CALL apsi402_month_combo('3')
               ELSE
                  LET g_month = l_month
                  DISPLAY g_month TO month
               END IF
               CALL apsi402_button_visible()
               CALL apsi402_b_fill_count()
               CONTINUE DIALOG
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apsi402_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apsi402_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apsi402_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apsi402_set_pk_array()
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
 
{<section id="apsi402.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION apsi402_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apsi402.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apsi402_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "psbb001"
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
      LET l_sub_sql = " SELECT DISTINCT psbb001 ",
 
                      " FROM psbb_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE psbbent = " ||g_enterprise|| " AND psbbsite = '" ||g_site|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("psbb_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT psbb001 ",
 
                      " FROM psbb_t ",
                      " ",
                      " ", 
 
 
                      " WHERE psbbent = " ||g_enterprise|| " AND psbbsite = '" ||g_site|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("psbb_t")
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
      INITIALIZE g_psbb_m.* TO NULL
      CALL g_psbb_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.psbb001 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.psbb001",
                " FROM psbb_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.psbbent = " ||g_enterprise|| " AND t0.psbbsite = '" ||g_site|| "' AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("psbb_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"psbb_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_psbb001 
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
   
   IF cl_null(g_browser[g_cnt].b_psbb001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_psbb_m.* TO NULL
      CALL g_psbb_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      CALL g_psbb2_d.clear()
      CALL g_psbb3_d.clear()
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL apsi402_fetch('')
   
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
 
{<section id="apsi402.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apsi402_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_psbb_m.psbb001 = g_browser[g_current_idx].b_psbb001   
 
   EXECUTE apsi402_master_referesh USING g_site,g_psbb_m.psbb001 INTO g_psbb_m.psbb001,g_psbb_m.psbb001_desc 
 
   CALL apsi402_show()
   
END FUNCTION
 
{</section>}
 
{<section id="apsi402.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apsi402_ui_detailshow()
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
 
{<section id="apsi402.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apsi402_ui_browser_refresh()
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
      IF g_browser[l_i].b_psbb001 = g_psbb_m.psbb001 
 
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
 
{<section id="apsi402.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apsi402_construct()
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
   INITIALIZE g_psbb_m.* TO NULL
   CALL g_psbb_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   CALL g_psbb2_d.clear()
   CALL g_psbb3_d.clear()
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON psbb001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.psbb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psbb001
            #add-point:ON ACTION controlp INFIELD psbb001 name="construct.c.psbb001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_psba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psbb001  #顯示到畫面上
            NEXT FIELD psbb001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psbb001
            #add-point:BEFORE FIELD psbb001 name="construct.b.psbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psbb001
            
            #add-point:AFTER FIELD psbb001 name="construct.a.psbb001"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON psbb014
           FROM s_detail1[1].psbb014
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psbb014
            #add-point:BEFORE FIELD psbb014 name="construct.b.page1.psbb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psbb014
            
            #add-point:AFTER FIELD psbb014 name="construct.a.page1.psbb014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.psbb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psbb014
            #add-point:ON ACTION controlp INFIELD psbb014 name="construct.c.page1.psbb014"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      #160701-00033#1-mod-(S)  不能用同個g_wc2_table1
#      CONSTRUCT g_wc2_table1 ON psbb003
#           FROM s_detail2[1].psbb003b
       CONSTRUCT g_wc2_table2 ON psbb003
           FROM s_detail2[1].psbb003b
      #160701-00033#1-mod-(E)                
         BEFORE CONSTRUCT
            
         ON ACTION controlp INFIELD psbb003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psbb003  #顯示到畫面上
            NEXT FIELD psbb003                     #返回原欄位
    
         BEFORE FIELD psbb003

         AFTER FIELD psbb003
            
         ON ACTION controlp INFIELD psbb003b
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psbb003b  #顯示到畫面上
            NEXT FIELD psbb003b                     #返回原欄位

         BEFORE FIELD psbb003b

         AFTER FIELD psbb003b

      END CONSTRUCT
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
   LET g_wc2_table1 = g_wc2_table1," AND ",g_wc2_table2 #160701-00033#1-ad
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
 
{<section id="apsi402.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apsi402_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   CALL g_psbb2_d.clear()
   CALL g_psbb3_d.clear()
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
   CALL g_psbb_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL apsi402_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apsi402_browser_fill(g_wc)
      CALL apsi402_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL apsi402_browser_fill("F")
   
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
      CALL apsi402_fetch("F") 
   END IF
   
   CALL apsi402_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="apsi402.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apsi402_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
   LET g_year = ''
   LET g_month = ''
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
   
   #CALL apsi402_browser_fill(p_flag)
   
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
   
   LET g_psbb_m.psbb001 = g_browser[g_current_idx].b_psbb001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apsi402_master_referesh USING g_site,g_psbb_m.psbb001 INTO g_psbb_m.psbb001,g_psbb_m.psbb001_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "psbb_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_psbb_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_psbb_m_mask_o.* =  g_psbb_m.*
   CALL apsi402_psbb_t_mask()
   LET g_psbb_m_mask_n.* =  g_psbb_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apsi402_set_act_visible()
   CALL apsi402_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_psbb_m_t.* = g_psbb_m.*
   LET g_psbb_m_o.* = g_psbb_m.*
   
   #重新顯示   
   CALL apsi402_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="apsi402.insert" >}
#+ 資料新增
PRIVATE FUNCTION apsi402_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   CALL g_psbb2_d.clear()
   CALL g_psbb3_d.clear()
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_psbb_d.clear()
 
 
   INITIALIZE g_psbb_m.* TO NULL             #DEFAULT 設定
   LET g_psbb001_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
 
      #end add-point 
 
      CALL apsi402_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_psbb_m.* TO NULL
         INITIALIZE g_psbb_d TO NULL
 
         CALL apsi402_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_psbb_m.* = g_psbb_m_t.*
         CALL apsi402_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_psbb_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      CALL g_psbb2_d.clear()
      CALL g_psbb3_d.clear()
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apsi402_set_act_visible()
   CALL apsi402_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_psbb001_t = g_psbb_m.psbb001
 
   
   #組合新增資料的條件
   LET g_add_browse = " psbbent = " ||g_enterprise|| " AND psbbsite = '" ||g_site|| "' AND",
                      " psbb001 = '", g_psbb_m.psbb001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apsi402_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL apsi402_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apsi402_master_referesh USING g_site,g_psbb_m.psbb001 INTO g_psbb_m.psbb001,g_psbb_m.psbb001_desc 
 
   
   #遮罩相關處理
   LET g_psbb_m_mask_o.* =  g_psbb_m.*
   CALL apsi402_psbb_t_mask()
   LET g_psbb_m_mask_n.* =  g_psbb_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_psbb_m.psbb001,g_psbb_m.psbb001_desc
   
   #功能已完成,通報訊息中心
   CALL apsi402_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apsi402.modify" >}
#+ 資料修改
PRIVATE FUNCTION apsi402_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_psbb_m.psbb001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_psbb001_t = g_psbb_m.psbb001
 
   CALL s_transaction_begin()
   
   OPEN apsi402_cl USING g_enterprise, g_site,g_psbb_m.psbb001
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apsi402_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE apsi402_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apsi402_master_referesh USING g_site,g_psbb_m.psbb001 INTO g_psbb_m.psbb001,g_psbb_m.psbb001_desc 
 
   
   #遮罩相關處理
   LET g_psbb_m_mask_o.* =  g_psbb_m.*
   CALL apsi402_psbb_t_mask()
   LET g_psbb_m_mask_n.* =  g_psbb_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL apsi402_show()
   WHILE TRUE
      LET g_psbb001_t = g_psbb_m.psbb001
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL apsi402_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_psbb_m.* = g_psbb_m_t.*
         CALL apsi402_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_psbb_m.psbb001 != g_psbb001_t 
 
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
   CALL apsi402_set_act_visible()
   CALL apsi402_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " psbbent = " ||g_enterprise|| " AND psbbsite = '" ||g_site|| "' AND",
                      " psbb001 = '", g_psbb_m.psbb001, "' "
 
   #填到對應位置
   CALL apsi402_browser_fill("")
 
   CALL apsi402_idx_chk()
 
   CLOSE apsi402_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apsi402_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="apsi402.input" >}
#+ 資料輸入
PRIVATE FUNCTION apsi402_input(p_cmd)
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
   DISPLAY BY NAME g_psbb_m.psbb001,g_psbb_m.psbb001_desc
   
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
   LET g_forupd_sql = "SELECT psbb012,psbb013,psbb002,psbbdocno,psbbseq,psbbseq1,psbbseq2,psbb003,psbb004, 
       psbb014,psbb007,psbb005,psbb006,psbb008,psbb010,psbb009,psbb011 FROM psbb_t WHERE psbbent=? AND  
       psbbsite=? AND psbb001=? AND psbbdocno=? AND psbbseq=? AND psbbseq1=? AND psbbseq2=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql"
   #160509-00009#10 20160520 modify by ming -----(S) 
   #160415-00017#1-mod-(S) psbb001跟psbbsite位子反了
   ##LET g_forupd_sql = "SELECT psbbsite,psbb012,psbb013,psbb002,psbbdocno,psbbseq,psbbseq1,psbbseq2,psbb003, 
   ##    psbb004,psbb007,psbb005,psbb006,psbb008,psbb010,psbb009,psbb011 FROM psbb_t WHERE psbbent=? AND  
   ##    psbb001=? AND psbbsite=? AND psbbdocno=? AND psbbseq=? AND psbbseq1=? AND psbbseq2=? FOR UPDATE" 
   #LET g_forupd_sql = "SELECT psbb012,psbb013,psbb002,psbbdocno,psbbseq,psbbseq1,psbbseq2,psbb003, 
   #    psbb004,psbb007,psbb005,psbb006,psbb008,psbb010,psbb009,psbb011 FROM psbb_t WHERE psbbent=? AND  
   #    psbbsite=? AND psbb001=? AND psbbdocno=? AND psbbseq=? AND psbbseq1=? AND psbbseq2=? FOR UPDATE" 
   #160415-00017#1-mod-(E)
   LET g_forupd_sql = "SELECT psbb012,psbb013,psbb002,psbbdocno,psbbseq,psbbseq1,psbbseq2,psbb003, 
       psbb004,psbb014,psbb007,psbb005,psbb006,psbb008,psbb010,psbb009,psbb011 FROM psbb_t WHERE psbbent=? AND  
       psbbsite=? AND psbb001=? AND psbbdocno=? AND psbbseq=? AND psbbseq1=? AND psbbseq2=? FOR UPDATE" 
   #160509-00009#10 20160520 modify by ming -----(E) 
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apsi402_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apsi402_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apsi402_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_psbb_m.psbb001
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apsi402.input.head" >}
   
      #單頭段
      INPUT BY NAME g_psbb_m.psbb001 
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
         AFTER FIELD psbb001
            
            #add-point:AFTER FIELD psbb001 name="input.a.psbb001"
            LET g_psbb_m.psbb001_desc = ' '
            DISPLAY BY NAME g_psbb_m.psbb001_desc
            IF NOT cl_null(g_psbb_m.psbb001) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_psbb_m.psbb001 != g_psbb_m_t.psbb001 OR g_psbb_m_t.psbb001 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE   #160318-00025#50
                  LET g_chkparam.err_str[1] = "aps-00044:sub-01302|apsi001|",cl_get_progname("apsi001",g_lang,"2"),"|:EXEPROGapsi001"    #160318-00025#50
                  IF NOT cl_chk_exist("v_psba001") THEN
                     LET g_psbb_m.psbb001 = g_psbb_m_t.psbb001
                     CALL apsi402_psba001_ref(g_psbb_m_t.psbb001) RETURNING g_psbb_m.psbb001_desc
                     DISPLAY BY NAME g_psbb_m.psbb001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apsi402_psba001_ref(g_psbb_m_t.psbb001) RETURNING g_psbb_m.psbb001_desc
            DISPLAY BY NAME g_psbb_m.psbb001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psbb001
            #add-point:BEFORE FIELD psbb001 name="input.b.psbb001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psbb001
            #add-point:ON CHANGE psbb001 name="input.g.psbb001"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.psbb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psbb001
            #add-point:ON ACTION controlp INFIELD psbb001 name="input.c.psbb001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_psbb_m.psbb001             #給予default值
            LET g_qryparam.default2 = "" #g_psbb_m.psbal003 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_psba001()                                #呼叫開窗

            LET g_psbb_m.psbb001 = g_qryparam.return1              
            #LET g_psbb_m.psbal003 = g_qryparam.return2 
            DISPLAY g_psbb_m.psbb001 TO psbb001              #
            #DISPLAY g_psbb_m.psbal003 TO psbal003 #說明
            NEXT FIELD psbb001                          #返回原欄位


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
            DISPLAY BY NAME g_psbb_m.psbb001             
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL apsi402_psbb_t_mask_restore('restore_mask_o')
            
               UPDATE psbb_t SET (psbb001) = (g_psbb_m.psbb001)
                WHERE psbbent = g_enterprise AND psbbsite = g_site AND psbb001 = g_psbb001_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "psbb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "psbb_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_psbb_m.psbb001
               LET gs_keys_bak[1] = g_psbb001_t
               LET gs_keys[2] = g_psbb_d[g_detail_idx].psbbdocno
               LET gs_keys_bak[2] = g_psbb_d_t.psbbdocno
               LET gs_keys[3] = g_psbb_d[g_detail_idx].psbbseq
               LET gs_keys_bak[3] = g_psbb_d_t.psbbseq
               LET gs_keys[4] = g_psbb_d[g_detail_idx].psbbseq1
               LET gs_keys_bak[4] = g_psbb_d_t.psbbseq1
               LET gs_keys[5] = g_psbb_d[g_detail_idx].psbbseq2
               LET gs_keys_bak[5] = g_psbb_d_t.psbbseq2
               CALL apsi402_update_b('psbb_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_psbb_m_t)
                     #LET g_log2 = util.JSON.stringify(g_psbb_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL apsi402_psbb_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apsi402_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_psbb001_t = g_psbb_m.psbb001
 
           
           IF g_psbb_d.getLength() = 0 THEN
              NEXT FIELD psbbdocno
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="apsi402.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_psbb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_psbb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apsi402_b_fill(g_wc2) #test 
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
            CALL apsi402_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN apsi402_cl USING g_enterprise, g_site,g_psbb_m.psbb001                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE apsi402_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN apsi402_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_psbb_d[l_ac].psbbdocno IS NOT NULL
               AND g_psbb_d[l_ac].psbbseq IS NOT NULL
               AND g_psbb_d[l_ac].psbbseq1 IS NOT NULL
               AND g_psbb_d[l_ac].psbbseq2 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_psbb_d_t.* = g_psbb_d[l_ac].*  #BACKUP
               LET g_psbb_d_o.* = g_psbb_d[l_ac].*  #BACKUP
               CALL apsi402_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL apsi402_set_no_entry_b(l_cmd)
               OPEN apsi402_bcl USING g_enterprise, g_site,g_psbb_m.psbb001,
 
                                                g_psbb_d_t.psbbdocno
                                                ,g_psbb_d_t.psbbseq
                                                ,g_psbb_d_t.psbbseq1
                                                ,g_psbb_d_t.psbbseq2
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN apsi402_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apsi402_bcl INTO g_psbb_d[l_ac].psbb012,g_psbb_d[l_ac].psbb013,g_psbb_d[l_ac].psbb002, 
                      g_psbb_d[l_ac].psbbdocno,g_psbb_d[l_ac].psbbseq,g_psbb_d[l_ac].psbbseq1,g_psbb_d[l_ac].psbbseq2, 
                      g_psbb_d[l_ac].psbb003,g_psbb_d[l_ac].psbb004,g_psbb_d[l_ac].psbb014,g_psbb_d[l_ac].psbb007, 
                      g_psbb_d[l_ac].psbb005,g_psbb_d[l_ac].psbb006,g_psbb_d[l_ac].psbb008,g_psbb_d[l_ac].psbb010, 
                      g_psbb_d[l_ac].psbb009,g_psbb_d[l_ac].psbb011
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_psbb_d_t.psbbdocno,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_psbb_d_mask_o[l_ac].* =  g_psbb_d[l_ac].*
                  CALL apsi402_psbb_t_mask()
                  LET g_psbb_d_mask_n[l_ac].* =  g_psbb_d[l_ac].*
                  
                  CALL apsi402_ref_show()
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
            INITIALIZE g_psbb_d_t.* TO NULL
            INITIALIZE g_psbb_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_psbb_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_psbb_d[l_ac].psbb013 = "N"
      LET g_psbb_d[l_ac].psbb014 = "N"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_psbb_d_t.* = g_psbb_d[l_ac].*     #新輸入資料
            LET g_psbb_d_o.* = g_psbb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apsi402_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL apsi402_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_psbb_d[li_reproduce_target].* = g_psbb_d[li_reproduce].*
 
               LET g_psbb_d[g_psbb_d.getLength()].psbbdocno = NULL
               LET g_psbb_d[g_psbb_d.getLength()].psbbseq = NULL
               LET g_psbb_d[g_psbb_d.getLength()].psbbseq1 = NULL
               LET g_psbb_d[g_psbb_d.getLength()].psbbseq2 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM psbb_t 
             WHERE psbbent = g_enterprise AND psbbsite = g_site AND psbb001 = g_psbb_m.psbb001
 
               AND psbbdocno = g_psbb_d[l_ac].psbbdocno
               AND psbbseq = g_psbb_d[l_ac].psbbseq
               AND psbbseq1 = g_psbb_d[l_ac].psbbseq1
               AND psbbseq2 = g_psbb_d[l_ac].psbbseq2
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO psbb_t
                           (psbbent, psbbsite,
                            psbb001,
                            psbbdocno,psbbseq,psbbseq1,psbbseq2
                            ,psbb012,psbb013,psbb002,psbb003,psbb004,psbb014,psbb007,psbb005,psbb006,psbb008,psbb010,psbb009,psbb011) 
                     VALUES(g_enterprise, g_site,
                            g_psbb_m.psbb001,
                            g_psbb_d[l_ac].psbbdocno,g_psbb_d[l_ac].psbbseq,g_psbb_d[l_ac].psbbseq1, 
                                g_psbb_d[l_ac].psbbseq2
                            ,g_psbb_d[l_ac].psbb012,g_psbb_d[l_ac].psbb013,g_psbb_d[l_ac].psbb002,g_psbb_d[l_ac].psbb003, 
                                g_psbb_d[l_ac].psbb004,g_psbb_d[l_ac].psbb014,g_psbb_d[l_ac].psbb007, 
                                g_psbb_d[l_ac].psbb005,g_psbb_d[l_ac].psbb006,g_psbb_d[l_ac].psbb008, 
                                g_psbb_d[l_ac].psbb010,g_psbb_d[l_ac].psbb009,g_psbb_d[l_ac].psbb011) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_psbb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "psbb_t:",SQLERRMESSAGE 
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
               IF apsi402_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_psbb_m.psbb001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_psbb_d_t.psbbdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_psbb_d_t.psbbseq
                  LET gs_keys[gs_keys.getLength()+1] = g_psbb_d_t.psbbseq1
                  LET gs_keys[gs_keys.getLength()+1] = g_psbb_d_t.psbbseq2
 
 
                  #刪除下層單身
                  IF NOT apsi402_key_delete_b(gs_keys,'psbb_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE apsi402_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE apsi402_bcl
               LET l_count = g_psbb_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_psbb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psbb012
            #add-point:BEFORE FIELD psbb012 name="input.b.page1.psbb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psbb012
            
            #add-point:AFTER FIELD psbb012 name="input.a.page1.psbb012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psbb012
            #add-point:ON CHANGE psbb012 name="input.g.page1.psbb012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psbb013
            #add-point:BEFORE FIELD psbb013 name="input.b.page1.psbb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psbb013
            
            #add-point:AFTER FIELD psbb013 name="input.a.page1.psbb013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psbb013
            #add-point:ON CHANGE psbb013 name="input.g.page1.psbb013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psbb014
            #add-point:BEFORE FIELD psbb014 name="input.b.page1.psbb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psbb014
            
            #add-point:AFTER FIELD psbb014 name="input.a.page1.psbb014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psbb014
            #add-point:ON CHANGE psbb014 name="input.g.page1.psbb014"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.psbb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psbb012
            #add-point:ON ACTION controlp INFIELD psbb012 name="input.c.page1.psbb012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.psbb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psbb013
            #add-point:ON ACTION controlp INFIELD psbb013 name="input.c.page1.psbb013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.psbb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psbb014
            #add-point:ON ACTION controlp INFIELD psbb014 name="input.c.page1.psbb014"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_psbb_d[l_ac].* = g_psbb_d_t.*
               CLOSE apsi402_bcl
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
               LET g_errparam.extend = g_psbb_d[l_ac].psbbdocno 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_psbb_d[l_ac].* = g_psbb_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL apsi402_psbb_t_mask_restore('restore_mask_o')
         
               UPDATE psbb_t SET (psbb001,psbb012,psbb013,psbb002,psbbdocno,psbbseq,psbbseq1,psbbseq2, 
                   psbb003,psbb004,psbb014,psbb007,psbb005,psbb006,psbb008,psbb010,psbb009,psbb011) = (g_psbb_m.psbb001, 
                   g_psbb_d[l_ac].psbb012,g_psbb_d[l_ac].psbb013,g_psbb_d[l_ac].psbb002,g_psbb_d[l_ac].psbbdocno, 
                   g_psbb_d[l_ac].psbbseq,g_psbb_d[l_ac].psbbseq1,g_psbb_d[l_ac].psbbseq2,g_psbb_d[l_ac].psbb003, 
                   g_psbb_d[l_ac].psbb004,g_psbb_d[l_ac].psbb014,g_psbb_d[l_ac].psbb007,g_psbb_d[l_ac].psbb005, 
                   g_psbb_d[l_ac].psbb006,g_psbb_d[l_ac].psbb008,g_psbb_d[l_ac].psbb010,g_psbb_d[l_ac].psbb009, 
                   g_psbb_d[l_ac].psbb011)
                WHERE psbbent = g_enterprise AND psbbsite = g_site AND psbb001 = g_psbb_m.psbb001 
 
                 AND psbbdocno = g_psbb_d_t.psbbdocno #項次   
                 AND psbbseq = g_psbb_d_t.psbbseq  
                 AND psbbseq1 = g_psbb_d_t.psbbseq1  
                 AND psbbseq2 = g_psbb_d_t.psbbseq2  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "psbb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "psbb_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_psbb_m.psbb001
               LET gs_keys_bak[1] = g_psbb001_t
               LET gs_keys[2] = g_psbb_d[g_detail_idx].psbbdocno
               LET gs_keys_bak[2] = g_psbb_d_t.psbbdocno
               LET gs_keys[3] = g_psbb_d[g_detail_idx].psbbseq
               LET gs_keys_bak[3] = g_psbb_d_t.psbbseq
               LET gs_keys[4] = g_psbb_d[g_detail_idx].psbbseq1
               LET gs_keys_bak[4] = g_psbb_d_t.psbbseq1
               LET gs_keys[5] = g_psbb_d[g_detail_idx].psbbseq2
               LET gs_keys_bak[5] = g_psbb_d_t.psbbseq2
               CALL apsi402_update_b('psbb_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_psbb_m),util.JSON.stringify(g_psbb_d_t)
                     LET g_log2 = util.JSON.stringify(g_psbb_m),util.JSON.stringify(g_psbb_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL apsi402_psbb_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_psbb_m.psbb001
 
               LET ls_keys[ls_keys.getLength()+1] = g_psbb_d_t.psbbdocno
               LET ls_keys[ls_keys.getLength()+1] = g_psbb_d_t.psbbseq
               LET ls_keys[ls_keys.getLength()+1] = g_psbb_d_t.psbbseq1
               LET ls_keys[ls_keys.getLength()+1] = g_psbb_d_t.psbbseq2
 
               CALL apsi402_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE apsi402_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_psbb_d[l_ac].* = g_psbb_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE apsi402_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_psbb_d.getLength() = 0 THEN
               NEXT FIELD psbbdocno
            END IF
            #add-point:input段after input  name="input.body.after_input"
            LET g_page_flag = 1
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_psbb_d[li_reproduce_target].* = g_psbb_d[li_reproduce].*
 
               LET g_psbb_d[li_reproduce_target].psbbdocno = NULL
               LET g_psbb_d[li_reproduce_target].psbbseq = NULL
               LET g_psbb_d[li_reproduce_target].psbbseq1 = NULL
               LET g_psbb_d[li_reproduce_target].psbbseq2 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_psbb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_psbb_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD psbb001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD psbb012
 
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
 
{<section id="apsi402.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apsi402_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_psbb007  LIKE psbb_t.psbb007
   DEFINE l_sql      STRING    #160907-00034#1 add
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   DELETE FROM date_tmp
   LET l_psbb007 = ''
   #160907-00034#1-(S)-mark
   #DECLARE ins_tmp_cur CURSOR FOR
   #   SELECT psbb007 FROM psbb_t
   #    WHERE psbbent = g_enterprise
   #      AND psbbsite = g_site
   #      AND psbb001 = g_psbb_m.psbb001
   #160907-00034#1-(E)-mark         
   
   #160907-00034#1-(S)-add
   LET l_sql = " SELECT psbb007 FROM psbb_t ",
               "  WHERE psbbent  = ",g_enterprise,
               "    AND psbbsite = '",g_site,"'",
               "    AND psbb001  = '",g_psbb_m.psbb001,"'",
               "    AND ", g_wc2_table2 CLIPPED   
   PREPARE ins_tmp_pre FROM l_sql
   DECLARE ins_tmp_cur CURSOR FOR ins_tmp_pre
   #160907-00034#1-(E)-add
   
   FOREACH ins_tmp_cur INTO l_psbb007
      LET l_year = YEAR(l_psbb007)
      LET l_month = MONTH(l_psbb007)
      INSERT INTO date_tmp VALUES(l_year,l_month)
      LET l_psbb007 = ''
   END FOREACH
   
   LET l_year = ''
   LET l_year_str = ''
   DECLARE year_cur CURSOR FOR
      SELECT yy FROM date_tmp
       GROUP BY yy
       ORDER BY yy
   FOREACH year_cur INTO l_year
      IF cl_null(l_year_str) THEN
         LET l_year_str = l_year
      ELSE
         LET l_year_str = l_year_str CLIPPED,',',l_year
      END IF
      LET l_year = ''
   END FOREACH
   CALL cl_set_combo_items('year',l_year_str,'')

   LET l_year = YEAR(g_today)
   LET l_cnt = ''
   SELECT COUNT(*) INTO l_cnt
     FROM date_tmp
    WHERE yy = l_year
   IF l_cnt > 0 THEN
      LET g_year = l_year
   ELSE
      SELECT MAX(yy) INTO g_year
        FROM date_tmp
   END IF
   IF NOT cl_null(g_year) THEN
      DISPLAY g_year TO year
      CALL apsi402_month_combo('1')
   END IF
   CALL apsi402_button_visible()
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL apsi402_b_fill(g_wc2) #第一階單身填充
      CALL apsi402_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apsi402_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   LET g_b_fill = TRUE
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_psbb_m.psbb001,g_psbb_m.psbb001_desc
 
   CALL apsi402_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   LET g_b_fill = FALSE
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="apsi402.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION apsi402_ref_show()
   #add-point:ref_show段define name="ref_show.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ref_show.define"
   DEFINE l_psbc019 DATETIME YEAR TO SECOND
   #end add-point
   
   #add-point:Function前置處理  name="ref_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference name="ref_show.head.reference"

            CALL apsi402_psba001_ref(g_psbb_m.psbb001) RETURNING g_psbb_m.psbb001_desc
            DISPLAY BY NAME g_psbb_m.psbb001_desc

            LET l_psbc019 = ''
            SELECT psbc019 INTO l_psbc019
              FROM psbc_t
             WHERE psbcent = g_enterprise
               AND psbcsite = g_site
               AND psbc001 = g_psbb_m.psbb001
               
            #2015/06/03 by stellar add ----- (S)
            IF cl_null(l_psbc019) THEN
               SELECT psba031 INTO l_psbc019 FROM psba_t
                WHERE psbaent = g_enterprise
                  AND psba001 = g_psbb_m.psbb001
            END IF
            #2015/06/03 by stellar add ----- (E)
            
            DISPLAY l_psbc019 TO psbc019

   IF g_b_fill THEN
      RETURN
   END IF
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_psbb_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"

         #料號說明
         CALL s_desc_get_item_desc(g_psbb_d[l_ac].psbb003) RETURNING g_psbb_d[l_ac].psbb003_desc_desc,g_psbb_d[l_ac].psbb003_desc
         
         #單位說明
         CALL s_desc_get_unit_desc(g_psbb_d[l_ac].psbb005) RETURNING g_psbb_d[l_ac].psbb005_desc
         
         #客戶說明
         CALL s_desc_get_trading_partner_abbr_desc(g_psbb_d[l_ac].psbb008) RETURNING g_psbb_d[l_ac].psbb008_desc
        
         #業務員說明
         CALL s_desc_get_person_desc(g_psbb_d[l_ac].psbb009) RETURNING g_psbb_d[l_ac].psbb009_desc
        
         #組織說明
         CALL s_desc_get_department_desc(g_psbb_d[l_ac].psbb010) RETURNING g_psbb_d[l_ac].psbb010_desc
         
         #通路說明
         #160621-00003#5 20160704 add by beckxie---S
         #CALL s_desc_get_acc_desc('275',g_psbb_d[l_ac].psbb011) RETURNING g_psbb_d[l_ac].psbb011_desc
         CALL s_desc_get_oojdl003_desc(g_psbb_d[l_ac].psbb011) RETURNING g_psbb_d[l_ac].psbb011_desc
         #160621-00003#5 20160704 add by beckxie---E
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   FOR l_ac = 1 TO g_psbb2_d.getLength()

            CALL s_desc_get_item_desc(g_psbb2_d[l_ac].psbb003b) RETURNING g_psbb2_d[l_ac].psbb003b_desc_desc,g_psbb2_d[l_ac].psbb003b_desc

   END FOR
   
   FOR l_ac = 1 TO g_psbb3_d.getLength()

            
            #160621-00003#5 20160704 add by beckxie---S
            #CALL s_desc_get_acc_desc('275',g_psbb3_d[l_ac].psbb011b) RETURNING g_psbb3_d[l_ac].psbb011b_desc
            CALL s_desc_get_oojdl003_desc(g_psbb3_d[l_ac].psbb011b) RETURNING g_psbb3_d[l_ac].psbb011b_desc
            #160621-00003#5 20160704 add by beckxie---E

   END FOR
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="apsi402.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apsi402_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE psbb_t.psbb001 
   DEFINE l_oldno     LIKE psbb_t.psbb001 
 
   DEFINE l_master    RECORD LIKE psbb_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE psbb_t.* #此變數樣板目前無使用
 
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
 
   IF g_psbb_m.psbb001 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_psbb001_t = g_psbb_m.psbb001
 
   
   LET g_psbb_m.psbb001 = ""
 
   LET g_master_insert = FALSE
   CALL apsi402_set_entry('a')
   CALL apsi402_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_psbb_m.psbb001_desc = ''
   DISPLAY BY NAME g_psbb_m.psbb001_desc
 
   
   CALL apsi402_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_psbb_m.* TO NULL
      INITIALIZE g_psbb_d TO NULL
 
      CALL apsi402_show()
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
   CALL apsi402_set_act_visible()
   CALL apsi402_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_psbb001_t = g_psbb_m.psbb001
 
   
   #組合新增資料的條件
   LET g_add_browse = " psbbent = " ||g_enterprise|| " AND psbbsite = '" ||g_site|| "' AND",
                      " psbb001 = '", g_psbb_m.psbb001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apsi402_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL apsi402_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL apsi402_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="apsi402.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apsi402_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE psbb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apsi402_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM psbb_t
    WHERE psbbent = g_enterprise AND psbbsite = g_site AND psbb001 = g_psbb001_t
 
       INTO TEMP apsi402_detail
   
   #將key修正為調整後   
   UPDATE apsi402_detail 
      #更新key欄位
      SET psbb001 = g_psbb_m.psbb001
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO psbb_t SELECT * FROM apsi402_detail
   
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
   DROP TABLE apsi402_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_psbb001_t = g_psbb_m.psbb001
 
   
   DROP TABLE apsi402_detail
   
END FUNCTION
 
{</section>}
 
{<section id="apsi402.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apsi402_delete()
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
   
   IF g_psbb_m.psbb001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN apsi402_cl USING g_enterprise, g_site,g_psbb_m.psbb001
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apsi402_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE apsi402_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apsi402_master_referesh USING g_site,g_psbb_m.psbb001 INTO g_psbb_m.psbb001,g_psbb_m.psbb001_desc 
 
   
   #遮罩相關處理
   LET g_psbb_m_mask_o.* =  g_psbb_m.*
   CALL apsi402_psbb_t_mask()
   LET g_psbb_m_mask_n.* =  g_psbb_m.*
   
   CALL apsi402_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apsi402_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM psbb_t WHERE psbbent = g_enterprise AND psbbsite = g_site AND psbb001 = g_psbb_m.psbb001 
 
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "psbb_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      CALL g_psbb2_d.clear()       
      CALL g_psbb3_d.clear()
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE apsi402_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_psbb_d.clear() 
 
     
      CALL apsi402_ui_browser_refresh()  
      #CALL apsi402_ui_headershow()  
      #CALL apsi402_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL apsi402_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL apsi402_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE apsi402_cl
 
   #功能已完成,通報訊息中心
   CALL apsi402_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apsi402.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apsi402_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql      STRING
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_psbb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_psbb2_d.clear()
   CALL g_psbb3_d.clear()
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT psbb012,psbb013,psbb002,psbbdocno,psbbseq,psbbseq1,psbbseq2,psbb003, 
       psbb004,psbb014,psbb007,psbb005,psbb006,psbb008,psbb010,psbb009,psbb011,t1.imaal004 ,t2.imaal003 , 
       t3.oocal003 ,t4.pmaal004 ,t5.ooefl003 ,t6.ooag011 ,t7.oojdl003 FROM psbb_t",   
               "",
               
                              " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=psbb004 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=psbb003 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=psbb005 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=psbb008 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=psbb010 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=psbb009  ",
               " LEFT JOIN oojdl_t t7 ON t7.oojdlent="||g_enterprise||" AND t7.oojdl001=psbb011 AND t7.oojdl002='"||g_dlang||"' ",
 
               " WHERE psbbent= ? AND psbbsite= ? AND psbb001=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("psbb_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET l_sql = g_sql
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF apsi402_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY psbb_t.psbbdocno,psbb_t.psbbseq,psbb_t.psbbseq1,psbb_t.psbbseq2"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
      LET g_sql = l_sql
      LET g_sql = g_sql, " ORDER BY psbb_t.psbb012 "
      
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apsi402_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apsi402_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise, g_site,g_psbb_m.psbb001   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise, g_site,g_psbb_m.psbb001 INTO g_psbb_d[l_ac].psbb012,g_psbb_d[l_ac].psbb013, 
          g_psbb_d[l_ac].psbb002,g_psbb_d[l_ac].psbbdocno,g_psbb_d[l_ac].psbbseq,g_psbb_d[l_ac].psbbseq1, 
          g_psbb_d[l_ac].psbbseq2,g_psbb_d[l_ac].psbb003,g_psbb_d[l_ac].psbb004,g_psbb_d[l_ac].psbb014, 
          g_psbb_d[l_ac].psbb007,g_psbb_d[l_ac].psbb005,g_psbb_d[l_ac].psbb006,g_psbb_d[l_ac].psbb008, 
          g_psbb_d[l_ac].psbb010,g_psbb_d[l_ac].psbb009,g_psbb_d[l_ac].psbb011,g_psbb_d[l_ac].psbb003_desc, 
          g_psbb_d[l_ac].psbb003_desc_desc,g_psbb_d[l_ac].psbb005_desc,g_psbb_d[l_ac].psbb008_desc,g_psbb_d[l_ac].psbb010_desc, 
          g_psbb_d[l_ac].psbb009_desc,g_psbb_d[l_ac].psbb011_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #料號說明
         CALL s_desc_get_item_desc(g_psbb_d[l_ac].psbb003) RETURNING g_psbb_d[l_ac].psbb003_desc_desc,g_psbb_d[l_ac].psbb003_desc
         
         #單位說明
         CALL s_desc_get_unit_desc(g_psbb_d[l_ac].psbb005) RETURNING g_psbb_d[l_ac].psbb005_desc
         
         #客戶說明
         CALL s_desc_get_trading_partner_abbr_desc(g_psbb_d[l_ac].psbb008) RETURNING g_psbb_d[l_ac].psbb008_desc
        
         #業務員說明
         CALL s_desc_get_person_desc(g_psbb_d[l_ac].psbb009) RETURNING g_psbb_d[l_ac].psbb009_desc
        
         #組織說明
         CALL s_desc_get_department_desc(g_psbb_d[l_ac].psbb010) RETURNING g_psbb_d[l_ac].psbb010_desc
         
         #通路說明
         
         #160621-00003#5 20160704 add by beckxie---S
         #CALL s_desc_get_acc_desc('275',g_psbb_d[l_ac].psbb011) RETURNING g_psbb_d[l_ac].psbb011_desc
         CALL s_desc_get_oojdl003_desc(g_psbb_d[l_ac].psbb011) RETURNING g_psbb_d[l_ac].psbb011_desc
         #160621-00003#5 20160704 add by beckxie---E
         
         #160509-00009#10 20160520 add by ming -----(S) 
         IF cl_null(g_psbb_d[l_ac].psbb014) THEN 
            LET g_psbb_d[l_ac].psbb014 = 'N' 
         END  IF 
         #160509-00009#10 20160520 add by ming -----(E) 
         #end add-point
      
         #帶出公用欄位reference值
         
         
 
        
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
 
            CALL g_psbb_d.deleteElement(g_psbb_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   CALL apsi402_b_fill_count()
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_psbb_d.getLength()
      LET g_psbb_d_mask_o[l_ac].* =  g_psbb_d[l_ac].*
      CALL apsi402_psbb_t_mask()
      LET g_psbb_d_mask_n[l_ac].* =  g_psbb_d[l_ac].*
   END FOR
   
 
 
   FREE apsi402_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="apsi402.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apsi402_idx_chk()
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
      IF g_detail_idx > g_psbb_d.getLength() THEN
         LET g_detail_idx = g_psbb_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_psbb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_psbb_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apsi402.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apsi402_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_psbb_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apsi402.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION apsi402_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM psbb_t
    WHERE psbbent = g_enterprise AND psbbsite = g_site AND psbb001 = g_psbb_m.psbb001 AND
 
          psbbdocno = g_psbb_d_t.psbbdocno
      AND psbbseq = g_psbb_d_t.psbbseq
      AND psbbseq1 = g_psbb_d_t.psbbseq1
      AND psbbseq2 = g_psbb_d_t.psbbseq2
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "psbb_t:",SQLERRMESSAGE 
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
 
{<section id="apsi402.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apsi402_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="apsi402.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apsi402_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="apsi402.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apsi402_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="apsi402.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION apsi402_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_psbb_d[l_ac].psbbdocno = g_psbb_d_t.psbbdocno 
      AND g_psbb_d[l_ac].psbbseq = g_psbb_d_t.psbbseq 
      AND g_psbb_d[l_ac].psbbseq1 = g_psbb_d_t.psbbseq1 
      AND g_psbb_d[l_ac].psbbseq2 = g_psbb_d_t.psbbseq2 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="apsi402.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apsi402_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apsi402.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apsi402_lock_b(ps_table,ps_page)
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
   #CALL apsi402_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apsi402.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apsi402_unlock_b(ps_table,ps_page)
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
 
{<section id="apsi402.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apsi402_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("psbb001",TRUE)
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
 
{<section id="apsi402.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apsi402_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("psbb001",FALSE)
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
 
{<section id="apsi402.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apsi402_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apsi402.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apsi402_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="apsi402.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apsi402_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apsi402.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apsi402_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apsi402.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apsi402_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apsi402.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apsi402_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apsi402.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apsi402_default_search()
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
      LET ls_wc = ls_wc, " psbb001 = '", g_argv[01], "' AND "
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
 
{<section id="apsi402.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apsi402_fill_chk(ps_idx)
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
 
{<section id="apsi402.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION apsi402_modify_detail_chk(ps_record)
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
         LET ls_return = "psbb012"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="apsi402.mask_functions" >}
&include "erp/aps/apsi402_mask.4gl"
 
{</section>}
 
{<section id="apsi402.state_change" >}
    
 
{</section>}
 
{<section id="apsi402.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apsi402_set_pk_array()
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
   LET g_pk_array[1].values = g_psbb_m.psbb001
   LET g_pk_array[1].column = 'psbb001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apsi402.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apsi402_msgcentre_notify(lc_state)
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
   CALL apsi402_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_psbb_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apsi402.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 暫存年月
# Memo...........:
# Usage..........: CALL apsi402_create_temp()
#                  RETURNING 回传参数
# Input parameter: no
# Return code....: no
# Date & Author..: 140408 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi402_create_temp()
   DROP TABLE date_tmp 
   CREATE TEMP TABLE date_tmp( 
      yy             VARCHAR(5),  
      mm             VARCHAR(5)  
      )
END FUNCTION

################################################################################
# Descriptions...: 月份下拉式選單的選項
# Memo...........:
# Usage..........: CALL apsi402_month_combo(p_cmd)
# Input parameter: p_cmd
# Return code....: no
# Date & Author..: 140409 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi402_month_combo(p_cmd)
DEFINE p_cmd      LIKE type_t.chr1

   LET l_month = ''
   LET l_month_str = ''
   DECLARE month_cur CURSOR FOR
      SELECT mm FROM date_tmp
       WHERE yy = g_year
       GROUP BY mm
       ORDER BY mm
   FOREACH month_cur INTO l_month
      IF cl_null(l_month_str) THEN
         LET l_month_str = l_month
      ELSE
         LET l_month_str = l_month_str CLIPPED,',',l_month
      END IF
      LET l_month = ''
   END FOREACH
   CALL cl_set_combo_items('month',l_month_str,'')
   
   LET l_cnt = ''
   CASE p_cmd
      WHEN '1'
         LET l_month = MONTH(g_today)
         SELECT COUNT(*) INTO l_cnt
           FROM date_tmp
          WHERE yy = g_year
            AND mm = l_month
         IF l_cnt > 0 THEN
            LET g_month = l_month
         ELSE
            SELECT MAX(mm) INTO g_month
              FROM date_tmp
             WHERE yy = g_year
         END IF
         DISPLAY g_month TO month
      WHEN '2'
         SELECT MAX(mm) INTO g_month
           FROM date_tmp
          WHERE yy = g_year
         DISPLAY g_month TO month
      WHEN '3'
         SELECT MIN(mm) INTO g_month
           FROM date_tmp
          WHERE yy = g_year
         DISPLAY g_month TO month
   END CASE

END FUNCTION

################################################################################
# Descriptions...: 控制<>顯隱
# Memo...........:
# Usage..........: CALL apsi402_button_visible()
# Input parameter: no
# Return code....: no
# Date & Author..: 140409 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi402_button_visible()
   IF cl_null(g_year) OR cl_null(g_month) THEN
      CALL cl_set_act_visible("button1,button2", FALSE)
   ELSE
      LET l_cnt = ''
      SELECT COUNT(*) INTO l_cnt
        FROM date_tmp
       WHERE (yy = g_year AND mm > g_month)
          OR yy > g_year
      IF cl_null(l_cnt) OR l_cnt = 0 THEN
         CALL cl_set_act_visible("button2", FALSE)
      ELSE
         CALL cl_set_act_visible("button2", TRUE)
      END IF
      LET l_cnt = ''
      SELECT COUNT(*) INTO l_cnt
        FROM date_tmp
       WHERE (yy = g_year AND mm < g_month)
          OR yy < g_year
      IF cl_null(l_cnt) OR l_cnt = 0 THEN
         CALL cl_set_act_visible("button1", FALSE)
      ELSE
         CALL cl_set_act_visible("button1", TRUE)
      END IF
   END IF

END FUNCTION

################################################################################
# Descriptions...: 每一筆需求數量的明細
# Memo...........:
# Usage..........: CALL apsi402_b_fill_detail()
# Input parameter: no
# Return code....: no
# Date & Author..: 140410 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi402_b_fill_detail()
DEFINE l_date1    STRING
DEFINE l_date2    STRING
DEFINE l_wc       STRING
DEFINE l_ac2      LIKE type_t.num5
DEFINE l_day      LIKE type_t.num5

   IF cl_null(g_year) OR cl_null(g_month) THEN
      RETURN
   END IF

   CALL g_psbb3_d.clear()
 
   LET g_sql = "SELECT psbb007,psbb002,psbbdocno,psbbseq,psbbseq1,psbbseq2,
                       psbb004,psbb006,psbb008,'',psbb010,'', 
                       psbb009,'',psbb011,'',psbb012,psbb013 FROM psbb_t", 
               " WHERE psbbent= ? AND psbbsite= ? AND psbb001=? AND psbb003 = ?"  
                  
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED
   END IF
   
   LET l_date1 = MDY(g_month,1,g_year)
   CALL s_date_get_max_day(g_year,g_month) RETURNING l_day
   LET l_date2 = MDY(g_month,l_day,g_year)
   LET l_wc = " psbb007 >= '",l_date1,"' AND psbb007 <= '",l_date2,"'"
   LET g_sql = g_sql CLIPPED," AND ",l_wc CLIPPED
   
   LET g_sql = g_sql, " ORDER BY psbb007,psbbdocno,psbbseq,psbbseq1,psbbseq2"
      
   PREPARE apsi402_pb5 FROM g_sql
   DECLARE b_fill_cs5 CURSOR FOR apsi402_pb5
      
   LET g_cnt = l_ac2
   LET l_ac2 = 1
      
   OPEN b_fill_cs5 USING g_enterprise,g_site,g_psbb_m.psbb001,g_psbb2_d[g_detail_idx].psbb003b
 
   FOREACH b_fill_cs5 INTO g_psbb3_d[l_ac2].psbb007b,g_psbb3_d[l_ac2].psbb002b,g_psbb3_d[l_ac2].psbbdocnob,g_psbb3_d[l_ac2].psbbseqb,
                           g_psbb3_d[l_ac2].psbbseq1b,g_psbb3_d[l_ac2].psbbseq2b,g_psbb3_d[l_ac2].psbb004b,
                           g_psbb3_d[l_ac2].psbb006b,g_psbb3_d[l_ac2].psbb008b,g_psbb3_d[l_ac2].psbb008b_desc,g_psbb3_d[l_ac2].psbb010b,
                           g_psbb3_d[l_ac2].psbb010b_desc,g_psbb3_d[l_ac2].psbb009b,g_psbb3_d[l_ac2].psbb009b_desc,g_psbb3_d[l_ac2].psbb011b,
                           g_psbb3_d[l_ac2].psbb011b_desc,g_psbb3_d[l_ac2].psbb012b,g_psbb3_d[l_ac2].psbb013b
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #客戶說明
      CALL s_desc_get_trading_partner_abbr_desc(g_psbb3_d[l_ac2].psbb008b) RETURNING g_psbb3_d[l_ac2].psbb008b_desc
     
      #業務員說明
      CALL s_desc_get_person_desc(g_psbb3_d[l_ac2].psbb009b) RETURNING g_psbb3_d[l_ac2].psbb009b_desc
     
      #組織說明
      CALL s_desc_get_department_desc(g_psbb3_d[l_ac2].psbb010b) RETURNING g_psbb3_d[l_ac2].psbb010b_desc
      
      #通路說明
      #160621-00003#5 20160704 add by beckxie---S
      #CALL s_desc_get_acc_desc('275',g_psbb3_d[l_ac2].psbb011b) RETURNING g_psbb3_d[l_ac2].psbb011b_desc
      CALL s_desc_get_oojdl003_desc(g_psbb3_d[l_ac2].psbb011b) RETURNING g_psbb3_d[l_ac2].psbb011b_desc
      #160621-00003#5 20160704 add by beckxie---E
      
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         EXIT FOREACH
      END IF
         
   END FOREACH
      
   CALL g_psbb3_d.deleteElement(g_psbb3_d.getLength())
   
   LET l_ac2 = g_cnt
   LET g_cnt = 0 
 
   FREE apsi402_pb5   

END FUNCTION

################################################################################
# Descriptions...: 需求數量的顯示
# Memo...........:
# Usage..........: CALL apsi402_b_fill_count()
# Input parameter: no
# Return code....: no
# Date & Author..: 140410 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi402_b_fill_count()
DEFINE l_sql1     STRING
DEFINE l_sql2     STRING
DEFINE l_sql3     STRING
DEFINE l_sql4     STRING
DEFINE l_date1    STRING
DEFINE l_date2    STRING
DEFINE l_wc       STRING
DEFINE l_ac1      LIKE type_t.num5
DEFINE l_day      LIKE type_t.num5
DEFINE l_psbb006  LIKE psbb_t.psbb006
DEFINE l_psbb007  LIKE psbb_t.psbb007

   IF cl_null(g_year) OR cl_null(g_month) THEN
      RETURN
   END IF

   CALL g_psbb2_d.clear()

   LET l_sql1 = "SELECT psbb003,'','','',
                 '0','0','0','0','0', '0','0','0','0','0',
                 '0','0','0','0','0', '0','0','0','0','0',
                 '0','0','0','0','0', '0','0','0','0','0',
                 '0','',SUM(psbb006) FROM psbb_t", 
                " WHERE psbbent= ? AND psbbsite= ? AND psbb001=?"  
 
   LET l_sql2 = "SELECT psbb006,psbb007 FROM psbb_t", 
                " WHERE psbbent= ? AND psbbsite= ? AND psbb001=? AND psbb003 = ?"  
                  
   LET l_sql3 = "SELECT SUM(psbb006) FROM psbb_t", 
                " WHERE psbbent= ? AND psbbsite= ? AND psbb001=? AND psbb003 = ?"  
                  
   IF NOT cl_null(g_wc2_table1) THEN
      #160701-00033#1-mod-(S)
#      LET l_sql1 = l_sql1 CLIPPED," AND ",g_wc2_table1 CLIPPED
#      LET l_sql2 = l_sql2 CLIPPED," AND ",g_wc2_table1 CLIPPED
#      LET l_sql3 = l_sql3 CLIPPED," AND ",g_wc2_table1 CLIPPED
      LET l_sql1 = l_sql1 CLIPPED," AND ",g_wc2_table2 CLIPPED
      LET l_sql2 = l_sql2 CLIPPED," AND ",g_wc2_table2 CLIPPED
      LET l_sql3 = l_sql3 CLIPPED," AND ",g_wc2_table2 CLIPPED
      #160701-00033#1-mod-(E)
   END IF

   LET l_date1 = MDY(g_month,1,g_year)
   CALL s_date_get_max_day(g_year,g_month) RETURNING l_day
   CALL cl_set_comp_visible("d31,d30,d29",TRUE)
   IF l_day < 31 THEN
      CALL cl_set_comp_visible("d31",FALSE)
      IF l_day < 30 THEN
         CALL cl_set_comp_visible("d30",FALSE)
         IF l_day < 29 THEN
            CALL cl_set_comp_visible("d29",FALSE)
         END IF
      END IF
   END IF
   LET l_date2 = MDY(g_month,l_day,g_year)
   LET l_wc = " psbb007 >= '",l_date1,"' AND psbb007 <= '",l_date2,"'"
   LET l_sql1 = l_sql1 CLIPPED," AND ",l_wc CLIPPED
   LET l_sql2 = l_sql2 CLIPPED," AND ",l_wc CLIPPED
   LET l_wc = " psbb007 > '",l_date2,"'"
   LET l_sql4 = l_sql3 CLIPPED," AND ",l_wc CLIPPED
   LET l_wc = " psbb007 < '",l_date1,"'"
   LET l_sql3 = l_sql3 CLIPPED," AND ",l_wc CLIPPED

   LET l_sql1 = l_sql1, " GROUP BY psbb003"
      
   PREPARE apsi402_pb1 FROM l_sql1
   DECLARE b_fill_cs1 CURSOR FOR apsi402_pb1
   
   PREPARE apsi402_pb2 FROM l_sql2
   DECLARE b_fill_cs2 CURSOR FOR apsi402_pb2
   
   PREPARE apsi402_pb3 FROM l_sql3
   DECLARE b_fill_cs3 CURSOR FOR apsi402_pb3
   
   PREPARE apsi402_pb4 FROM l_sql4
   DECLARE b_fill_cs4 CURSOR FOR apsi402_pb4
   
   LET g_cnt = l_ac1
   LET l_ac1 = 1
   
   OPEN b_fill_cs1 USING g_enterprise, g_site,g_psbb_m.psbb001
 
   FOREACH b_fill_cs1 INTO g_psbb2_d[l_ac1].psbb003b,g_psbb2_d[l_ac1].psbb003b_desc_desc,g_psbb2_d[l_ac1].psbb003b_desc, 
                           g_psbb2_d[l_ac1].pre,g_psbb2_d[l_ac1].d1,g_psbb2_d[l_ac1].d2,g_psbb2_d[l_ac1].d3,g_psbb2_d[l_ac1].d4, 
                           g_psbb2_d[l_ac1].d5,g_psbb2_d[l_ac1].d6,g_psbb2_d[l_ac1].d7,g_psbb2_d[l_ac1].d8,g_psbb2_d[l_ac1].d9, 
                           g_psbb2_d[l_ac1].d10,g_psbb2_d[l_ac1].d11,g_psbb2_d[l_ac1].d12,g_psbb2_d[l_ac1].d13,g_psbb2_d[l_ac1].d14, 
                           g_psbb2_d[l_ac1].d15,g_psbb2_d[l_ac1].d16,g_psbb2_d[l_ac1].d17,g_psbb2_d[l_ac1].d18,g_psbb2_d[l_ac1].d19, 
                           g_psbb2_d[l_ac1].d20,g_psbb2_d[l_ac1].d21,g_psbb2_d[l_ac1].d22,g_psbb2_d[l_ac1].d23,g_psbb2_d[l_ac1].d24, 
                           g_psbb2_d[l_ac1].d25,g_psbb2_d[l_ac1].d26,g_psbb2_d[l_ac1].d27,g_psbb2_d[l_ac1].d28,g_psbb2_d[l_ac1].d29, 
                           g_psbb2_d[l_ac1].d30,g_psbb2_d[l_ac1].d31,g_psbb2_d[l_ac1].late,g_psbb2_d[l_ac1].tot
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
                        
      #料號說明
      CALL s_desc_get_item_desc(g_psbb2_d[l_ac1].psbb003b) RETURNING g_psbb2_d[l_ac1].psbb003b_desc_desc,g_psbb2_d[l_ac1].psbb003b_desc

      OPEN b_fill_cs3 USING g_enterprise,g_site,g_psbb_m.psbb001,g_psbb2_d[l_ac1].psbb003b
      FETCH b_fill_cs3 INTO g_psbb2_d[l_ac1].pre
      IF cl_null(g_psbb2_d[l_ac1].pre) THEN LET g_psbb2_d[l_ac1].pre = 0 END IF

      OPEN b_fill_cs4 USING g_enterprise,g_site,g_psbb_m.psbb001,g_psbb2_d[l_ac1].psbb003b
      FETCH b_fill_cs4 INTO g_psbb2_d[l_ac1].late
      IF cl_null(g_psbb2_d[l_ac1].late) THEN LET g_psbb2_d[l_ac1].late = 0 END IF

      OPEN b_fill_cs2 USING g_enterprise,g_site,g_psbb_m.psbb001,g_psbb2_d[l_ac1].psbb003b

      LET l_psbb006 = ''
      LET l_psbb007 = ''
      
      FOREACH b_fill_cs2 INTO l_psbb006,l_psbb007
         LET l_day = ''
         CALL s_date_get_day(l_psbb007) RETURNING l_day
         CASE l_day
            WHEN '1' LET g_psbb2_d[l_ac1].d1 = g_psbb2_d[l_ac1].d1 + l_psbb006
            WHEN '2' LET g_psbb2_d[l_ac1].d2 = g_psbb2_d[l_ac1].d2 + l_psbb006
            WHEN '3' LET g_psbb2_d[l_ac1].d3 = g_psbb2_d[l_ac1].d3 + l_psbb006
            WHEN '4' LET g_psbb2_d[l_ac1].d4 = g_psbb2_d[l_ac1].d4 + l_psbb006
            WHEN '5' LET g_psbb2_d[l_ac1].d5 = g_psbb2_d[l_ac1].d5 + l_psbb006
            WHEN '6' LET g_psbb2_d[l_ac1].d6 = g_psbb2_d[l_ac1].d6 + l_psbb006
            WHEN '7' LET g_psbb2_d[l_ac1].d7 = g_psbb2_d[l_ac1].d7 + l_psbb006
            WHEN '8' LET g_psbb2_d[l_ac1].d8 = g_psbb2_d[l_ac1].d8 + l_psbb006
            WHEN '9' LET g_psbb2_d[l_ac1].d9 = g_psbb2_d[l_ac1].d9 + l_psbb006
            WHEN '10' LET g_psbb2_d[l_ac1].d10 = g_psbb2_d[l_ac1].d10 + l_psbb006
            WHEN '11' LET g_psbb2_d[l_ac1].d11 = g_psbb2_d[l_ac1].d11 + l_psbb006
            WHEN '12' LET g_psbb2_d[l_ac1].d12 = g_psbb2_d[l_ac1].d12 + l_psbb006
            WHEN '13' LET g_psbb2_d[l_ac1].d13 = g_psbb2_d[l_ac1].d13 + l_psbb006
            WHEN '14' LET g_psbb2_d[l_ac1].d14 = g_psbb2_d[l_ac1].d14 + l_psbb006
            WHEN '15' LET g_psbb2_d[l_ac1].d15 = g_psbb2_d[l_ac1].d15 + l_psbb006
            WHEN '16' LET g_psbb2_d[l_ac1].d16 = g_psbb2_d[l_ac1].d16 + l_psbb006
            WHEN '17' LET g_psbb2_d[l_ac1].d17 = g_psbb2_d[l_ac1].d17 + l_psbb006
            WHEN '18' LET g_psbb2_d[l_ac1].d18 = g_psbb2_d[l_ac1].d18 + l_psbb006
            WHEN '19' LET g_psbb2_d[l_ac1].d19 = g_psbb2_d[l_ac1].d19 + l_psbb006
            WHEN '20' LET g_psbb2_d[l_ac1].d20 = g_psbb2_d[l_ac1].d20 + l_psbb006
            WHEN '21' LET g_psbb2_d[l_ac1].d21 = g_psbb2_d[l_ac1].d21 + l_psbb006
            WHEN '22' LET g_psbb2_d[l_ac1].d22 = g_psbb2_d[l_ac1].d22 + l_psbb006
            WHEN '23' LET g_psbb2_d[l_ac1].d23 = g_psbb2_d[l_ac1].d23 + l_psbb006
            WHEN '24' LET g_psbb2_d[l_ac1].d24 = g_psbb2_d[l_ac1].d24 + l_psbb006
            WHEN '25' LET g_psbb2_d[l_ac1].d25 = g_psbb2_d[l_ac1].d25 + l_psbb006
            WHEN '26' LET g_psbb2_d[l_ac1].d26 = g_psbb2_d[l_ac1].d26 + l_psbb006
            WHEN '27' LET g_psbb2_d[l_ac1].d27 = g_psbb2_d[l_ac1].d27 + l_psbb006
            WHEN '28' LET g_psbb2_d[l_ac1].d28 = g_psbb2_d[l_ac1].d28 + l_psbb006
            WHEN '29' LET g_psbb2_d[l_ac1].d29 = g_psbb2_d[l_ac1].d29 + l_psbb006
            WHEN '30' LET g_psbb2_d[l_ac1].d30 = g_psbb2_d[l_ac1].d30 + l_psbb006
            WHEN '31' LET g_psbb2_d[l_ac1].d31 = g_psbb2_d[l_ac1].d31 + l_psbb006
         END CASE
      END FOREACH

      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   LET l_ac1 = g_cnt
   LET g_cnt = 0 
 
   CALL g_psbb2_d.deleteElement(g_psbb2_d.getLength())
   CALL apsi402_b_fill_detail()
 
   FREE apsi402_pb1   
   FREE apsi402_pb2   
   FREE apsi402_pb3   
   FREE apsi402_pb4   

END FUNCTION

################################################################################
# Descriptions...: MOD編號說明
# Memo...........:
# Usage..........: CALL apsi402_psba001_ref(p_psba001)
#                  RETURNING psbal003
# Input parameter: p_psba00   MOD編號
# Return code....: psbal003   說明
# Date & Author..: 140924 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi402_psba001_ref(p_psba001)
DEFINE p_psba001   LIKE psba_t.psba001
DEFINE r_psbal003  LIKE psbal_t.psbal003

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_psba001
   CALL ap_ref_array2(g_ref_fields,"SELECT psbal003 FROM psbal_t WHERE psbalent='"||g_enterprise||"' AND psbal001=? AND psbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_psbal003 = '', g_rtn_fields[1] , ''

   RETURN r_psbal003
END FUNCTION

 
{</section>}
 
