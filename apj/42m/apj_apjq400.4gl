#該程式未解開Section, 採用最新樣板產出!
{<section id="apjq400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2017-01-04 11:22:39), PR版次:0001(2017-01-18 14:00:03)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: apjq400
#+ Description: 項目費用分攤查詢作業
#+ Creator....: 01996(2017-01-04 11:22:39)
#+ Modifier...: 01996 -SD/PR- 01996
 
{</section>}
 
{<section id="apjq400.global" >}
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
PRIVATE type type_g_pjec_m        RECORD
       pjeccomp LIKE pjec_t.pjeccomp, 
   pjeccomp_desc LIKE type_t.chr80, 
   pjecld LIKE pjec_t.pjecld, 
   pjecld_desc LIKE type_t.chr80, 
   pjec002 LIKE pjec_t.pjec002, 
   pjec003 LIKE pjec_t.pjec003, 
   byear LIKE type_t.num5, 
   bmonth LIKE type_t.num5, 
   eyear LIKE type_t.num5, 
   emonth LIKE type_t.num5
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pjec_d        RECORD
       pjecseq LIKE pjec_t.pjecseq, 
   pjec004 LIKE pjec_t.pjec004, 
   pjec004_desc LIKE type_t.chr500, 
   pjec005 LIKE pjec_t.pjec005, 
   pjec005_desc LIKE type_t.chr500, 
   pjec010 LIKE pjec_t.pjec010, 
   pjec010_desc LIKE type_t.chr500, 
   pjec011 LIKE pjec_t.pjec011, 
   pjec011_desc LIKE type_t.chr500, 
   pjec012 LIKE pjec_t.pjec012, 
   pjec012_desc LIKE type_t.chr500, 
   pjec013 LIKE pjec_t.pjec013, 
   pjec013_desc LIKE type_t.chr500, 
   pjec014 LIKE pjec_t.pjec014, 
   pjec015 LIKE pjec_t.pjec015, 
   pjec016 LIKE pjec_t.pjec016, 
   pjec017 LIKE pjec_t.pjec017, 
   pjec018 LIKE pjec_t.pjec018, 
   pjec019 LIKE pjec_t.pjec019, 
   pjec020 LIKE pjec_t.pjec020, 
   pjec021 LIKE pjec_t.pjec021, 
   pjec022 LIKE pjec_t.pjec022, 
   pjec099 LIKE pjec_t.pjec099, 
   pjec200 LIKE pjec_t.pjec200, 
   pjec100 LIKE pjec_t.pjec100, 
   pjec110 LIKE pjec_t.pjec110, 
   pjec120 LIKE pjec_t.pjec120, 
   pjec300 LIKE pjec_t.pjec300, 
   pjec310 LIKE pjec_t.pjec310, 
   pjec320 LIKE pjec_t.pjec320
       END RECORD
PRIVATE TYPE type_g_pjec2_d RECORD
       pjecownid LIKE pjec_t.pjecownid, 
   pjecownid_desc LIKE type_t.chr500, 
   pjecowndp LIKE pjec_t.pjecowndp, 
   pjecowndp_desc LIKE type_t.chr500, 
   pjeccrtid LIKE pjec_t.pjeccrtid, 
   pjeccrtid_desc LIKE type_t.chr500, 
   pjeccrtdp LIKE pjec_t.pjeccrtdp, 
   pjeccrtdp_desc LIKE type_t.chr500, 
   pjeccrtdt DATETIME YEAR TO SECOND, 
   pjecmodid LIKE pjec_t.pjecmodid, 
   pjecmodid_desc LIKE type_t.chr500, 
   pjecmoddt DATETIME YEAR TO SECOND, 
   pjecseq LIKE pjec_t.pjecseq
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
PRIVATE TYPE type_g_detail_d        RECORD
   pjec010 LIKE pjec_t.pjec010, 
   pjec010_desc LIKE type_t.chr500,
   pjec011 LIKE pjec_t.pjec011, 
   pjec011_desc LIKE type_t.chr500, 
   pjec012 LIKE pjec_t.pjec012, 
   pjec012_desc LIKE type_t.chr500, 
   pjec013 LIKE pjec_t.pjec013, 
   pjec013_desc LIKE type_t.chr500, 
   pjec014 LIKE pjec_t.pjec014, 
   pjec015 LIKE pjec_t.pjec015, 
   pjec016 LIKE pjec_t.pjec016, 
   pjec017 LIKE pjec_t.pjec017, 
   pjec018 LIKE pjec_t.pjec018, 
   pjec019 LIKE pjec_t.pjec019, 
   pjec020 LIKE pjec_t.pjec020, 
   pjec021 LIKE pjec_t.pjec021, 
   pjec022 LIKE pjec_t.pjec022, 
   pjeb100 LIKE pjeb_t.pjeb100,
   pjeb110 LIKE pjeb_t.pjeb110,
   pjeb120 LIKE pjeb_t.pjeb120
       END RECORD
PRIVATE TYPE type_g_detail2_d        RECORD
   pjec004 LIKE pjec_t.pjec004, 
   pjec004_desc LIKE type_t.chr500, 
   pjec005 LIKE pjec_t.pjec005, 
   pjec005_desc LIKE type_t.chr500, 
   pjec099 LIKE pjec_t.pjec099, 
   pjec200 LIKE pjec_t.pjec200, 
   pjec100 LIKE pjec_t.pjec100, 
   pjec110 LIKE pjec_t.pjec110, 
   pjec120 LIKE pjec_t.pjec120, 
   pjec300 LIKE pjec_t.pjec300, 
   pjec310 LIKE pjec_t.pjec310, 
   pjec320 LIKE pjec_t.pjec320
       END RECORD
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
DEFINE g_detail2_d DYNAMIC ARRAY OF type_g_detail2_d
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_pjec_m          type_g_pjec_m
DEFINE g_pjec_m_t        type_g_pjec_m
DEFINE g_pjec_m_o        type_g_pjec_m
DEFINE g_pjec_m_mask_o   type_g_pjec_m #轉換遮罩前資料
DEFINE g_pjec_m_mask_n   type_g_pjec_m #轉換遮罩後資料
 
   DEFINE g_pjecld_t LIKE pjec_t.pjecld
DEFINE g_pjec002_t LIKE pjec_t.pjec002
DEFINE g_pjec003_t LIKE pjec_t.pjec003
 
 
DEFINE g_pjec_d          DYNAMIC ARRAY OF type_g_pjec_d
DEFINE g_pjec_d_t        type_g_pjec_d
DEFINE g_pjec_d_o        type_g_pjec_d
DEFINE g_pjec_d_mask_o   DYNAMIC ARRAY OF type_g_pjec_d #轉換遮罩前資料
DEFINE g_pjec_d_mask_n   DYNAMIC ARRAY OF type_g_pjec_d #轉換遮罩後資料
DEFINE g_pjec2_d   DYNAMIC ARRAY OF type_g_pjec2_d
DEFINE g_pjec2_d_t type_g_pjec2_d
DEFINE g_pjec2_d_o type_g_pjec2_d
DEFINE g_pjec2_d_mask_o   DYNAMIC ARRAY OF type_g_pjec2_d #轉換遮罩前資料
DEFINE g_pjec2_d_mask_n   DYNAMIC ARRAY OF type_g_pjec2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_pjecld LIKE pjec_t.pjecld,
      b_pjec002 LIKE pjec_t.pjec002,
      b_pjec003 LIKE pjec_t.pjec003
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
 
{<section id="apjq400.main" >}
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
   CALL cl_ap_init("apj","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pjeccomp,'',pjecld,'',pjec002,pjec003,'','','',''", 
                      " FROM pjec_t",
                      " WHERE pjecent= ? AND pjecld=? AND pjec002=? AND pjec003=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apjq400_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pjeccomp,t0.pjecld,t0.pjec002,t0.pjec003,t1.ooefl003 ,t2.glaal003", 
 
               " FROM pjec_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.pjeccomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaal001=t0.pjecld AND t2.glaal002='"||g_dlang||"' ",
 
               " WHERE t0.pjecent = " ||g_enterprise|| " AND t0.pjecld = ? AND t0.pjec002 = ? AND t0.pjec003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apjq400_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apjq400 WITH FORM cl_ap_formpath("apj",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apjq400_init()   
 
      #進入選單 Menu (="N")
      CALL apjq400_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apjq400
      
   END IF 
   
   CLOSE apjq400_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apjq400.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apjq400_init()
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
   CALL cl_set_comp_visible("byear,eyear,bmonth,emonth",FALSE)
   #end add-point
   
   CALL apjq400_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apjq400.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apjq400_ui_dialog()
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
   CALL apjq400_query()
   #add-point:ON ACTION query name="menu.query"
   CALL apjq400_set_entry('')
   CALL apjq400_set_no_entry('')
   LET g_action_choice = "query"
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_pjec_m.* TO NULL
         CALL g_pjec_d.clear()
         CALL g_pjec2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apjq400_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_pjec_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL apjq400_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apjq400_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_pjec2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL apjq400_idx_chk()
               CALL apjq400_ui_detailshow()
               
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
            CALL apjq400_browser_fill("")
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
               CALL apjq400_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apjq400_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apjq400_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjq400_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apjq400_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjq400_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apjq400_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjq400_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apjq400_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjq400_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apjq400_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjq400_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_pjec_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_pjec2_d)
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
               NEXT FIELD pjecseq
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
               CALL apjq400_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL apjq400_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL apjq400_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
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
               CALL apjq400_query()
               #add-point:ON ACTION query name="menu.query"
               CALL apjq400_set_entry('')
               CALL apjq400_set_no_entry('')
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION sub_query
            LET g_action_choice="sub_query"
            IF cl_auth_chk_act("sub_query") THEN
               
               #add-point:ON ACTION sub_query name="menu.sub_query"
               CALL apjq400_open_s01()
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apjq400_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apjq400_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apjq400_set_pk_array()
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
 
{<section id="apjq400.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION apjq400_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apjq400.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apjq400_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "pjecld,pjec002,pjec003"
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
      LET l_sub_sql = " SELECT DISTINCT pjecld ",
                      ", pjec002 ",
                      ", pjec003 ",
 
                      " FROM pjec_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE pjecent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pjec_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pjecld ",
                      ", pjec002 ",
                      ", pjec003 ",
 
                      " FROM pjec_t ",
                      " ",
                      " ", 
 
 
                      " WHERE pjecent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pjec_t")
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
      INITIALIZE g_pjec_m.* TO NULL
      CALL g_pjec_d.clear()        
      CALL g_pjec2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pjecld,t0.pjec002,t0.pjec003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.pjecld,t0.pjec002,t0.pjec003",
                " FROM pjec_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.pjecent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("pjec_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"pjec_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_pjecld,g_browser[g_cnt].b_pjec002,g_browser[g_cnt].b_pjec003  
 
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
   
   IF cl_null(g_browser[g_cnt].b_pjecld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_pjec_m.* TO NULL
      CALL g_pjec_d.clear()
      CALL g_pjec2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL apjq400_fetch('')
   
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
 
{<section id="apjq400.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apjq400_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pjec_m.pjecld = g_browser[g_current_idx].b_pjecld   
   LET g_pjec_m.pjec002 = g_browser[g_current_idx].b_pjec002   
   LET g_pjec_m.pjec003 = g_browser[g_current_idx].b_pjec003   
 
   EXECUTE apjq400_master_referesh USING g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003 INTO g_pjec_m.pjeccomp, 
       g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003,g_pjec_m.pjeccomp_desc,g_pjec_m.pjecld_desc 
 
   CALL apjq400_show()
   
END FUNCTION
 
{</section>}
 
{<section id="apjq400.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apjq400_ui_detailshow()
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
 
{<section id="apjq400.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apjq400_ui_browser_refresh()
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
      IF g_browser[l_i].b_pjecld = g_pjec_m.pjecld 
         AND g_browser[l_i].b_pjec002 = g_pjec_m.pjec002 
         AND g_browser[l_i].b_pjec003 = g_pjec_m.pjec003 
 
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
 
{<section id="apjq400.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apjq400_construct()
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
   INITIALIZE g_pjec_m.* TO NULL
   CALL g_pjec_d.clear()
   CALL g_pjec2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   CALL apjq400_set_entry('')
   CALL apjq400_set_no_entry('')
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON pjeccomp,pjecld,pjec002,pjec003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.pjeccomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjeccomp
            #add-point:ON ACTION controlp INFIELD pjeccomp name="construct.c.pjeccomp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjeccomp  #顯示到畫面上
            NEXT FIELD pjeccomp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeccomp
            #add-point:BEFORE FIELD pjeccomp name="construct.b.pjeccomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjeccomp
            
            #add-point:AFTER FIELD pjeccomp name="construct.a.pjeccomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjecld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjecld
            #add-point:ON ACTION controlp INFIELD pjecld name="construct.c.pjecld"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaald_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjecld  #顯示到畫面上
            NEXT FIELD pjecld                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjecld
            #add-point:BEFORE FIELD pjecld name="construct.b.pjecld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjecld
            
            #add-point:AFTER FIELD pjecld name="construct.a.pjecld"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec002
            #add-point:BEFORE FIELD pjec002 name="construct.b.pjec002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec002
            
            #add-point:AFTER FIELD pjec002 name="construct.a.pjec002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjec002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec002
            #add-point:ON ACTION controlp INFIELD pjec002 name="construct.c.pjec002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec003
            #add-point:BEFORE FIELD pjec003 name="construct.b.pjec003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec003
            
            #add-point:AFTER FIELD pjec003 name="construct.a.pjec003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjec003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec003
            #add-point:ON ACTION controlp INFIELD pjec003 name="construct.c.pjec003"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON pjecseq,pjec004,pjec005,pjec010,pjec010_desc,pjec011,pjec012,pjec013, 
          pjec014,pjec015,pjec016,pjec017,pjec018,pjec019,pjec020,pjec021,pjec022,pjec099,pjec200,pjec100, 
          pjec110,pjec120,pjec300,pjec310,pjec320,pjecownid,pjecowndp,pjeccrtid,pjeccrtdp,pjeccrtdt, 
          pjecmodid,pjecmoddt
           FROM s_detail1[1].pjecseq,s_detail1[1].pjec004,s_detail1[1].pjec005,s_detail1[1].pjec010, 
               s_detail1[1].pjec010_desc,s_detail1[1].pjec011,s_detail1[1].pjec012,s_detail1[1].pjec013, 
               s_detail1[1].pjec014,s_detail1[1].pjec015,s_detail1[1].pjec016,s_detail1[1].pjec017,s_detail1[1].pjec018, 
               s_detail1[1].pjec019,s_detail1[1].pjec020,s_detail1[1].pjec021,s_detail1[1].pjec022,s_detail1[1].pjec099, 
               s_detail1[1].pjec200,s_detail1[1].pjec100,s_detail1[1].pjec110,s_detail1[1].pjec120,s_detail1[1].pjec300, 
               s_detail1[1].pjec310,s_detail1[1].pjec320,s_detail2[1].pjecownid,s_detail2[1].pjecowndp, 
               s_detail2[1].pjeccrtid,s_detail2[1].pjeccrtdp,s_detail2[1].pjeccrtdt,s_detail2[1].pjecmodid, 
               s_detail2[1].pjecmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pjeccrtdt>>----
         AFTER FIELD pjeccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pjecmoddt>>----
         AFTER FIELD pjecmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pjeccnfdt>>----
         
         #----<<pjecpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjecseq
            #add-point:BEFORE FIELD pjecseq name="construct.b.page1.pjecseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjecseq
            
            #add-point:AFTER FIELD pjecseq name="construct.a.page1.pjecseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjecseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjecseq
            #add-point:ON ACTION controlp INFIELD pjecseq name="construct.c.page1.pjecseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pjec004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec004
            #add-point:ON ACTION controlp INFIELD pjec004 name="construct.c.page1.pjec004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjec004  #顯示到畫面上
            NEXT FIELD pjec004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec004
            #add-point:BEFORE FIELD pjec004 name="construct.b.page1.pjec004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec004
            
            #add-point:AFTER FIELD pjec004 name="construct.a.page1.pjec004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec005
            #add-point:ON ACTION controlp INFIELD pjec005 name="construct.c.page1.pjec005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjec005  #顯示到畫面上
            NEXT FIELD pjec005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec005
            #add-point:BEFORE FIELD pjec005 name="construct.b.page1.pjec005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec005
            
            #add-point:AFTER FIELD pjec005 name="construct.a.page1.pjec005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec010
            #add-point:ON ACTION controlp INFIELD pjec010 name="construct.c.page1.pjec010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glac002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjec010  #顯示到畫面上
            NEXT FIELD pjec010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec010
            #add-point:BEFORE FIELD pjec010 name="construct.b.page1.pjec010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec010
            
            #add-point:AFTER FIELD pjec010 name="construct.a.page1.pjec010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec010_desc
            #add-point:BEFORE FIELD pjec010_desc name="construct.b.page1.pjec010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec010_desc
            
            #add-point:AFTER FIELD pjec010_desc name="construct.a.page1.pjec010_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec010_desc
            #add-point:ON ACTION controlp INFIELD pjec010_desc name="construct.c.page1.pjec010_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pjec011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec011
            #add-point:ON ACTION controlp INFIELD pjec011 name="construct.c.page1.pjec011"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjec011  #顯示到畫面上
            NEXT FIELD pjec011                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec011
            #add-point:BEFORE FIELD pjec011 name="construct.b.page1.pjec011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec011
            
            #add-point:AFTER FIELD pjec011 name="construct.a.page1.pjec011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec012
            #add-point:ON ACTION controlp INFIELD pjec012 name="construct.c.page1.pjec012"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_71()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjec012  #顯示到畫面上
            NEXT FIELD pjec012                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec012
            #add-point:BEFORE FIELD pjec012 name="construct.b.page1.pjec012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec012
            
            #add-point:AFTER FIELD pjec012 name="construct.a.page1.pjec012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec013
            #add-point:ON ACTION controlp INFIELD pjec013 name="construct.c.page1.pjec013"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjec013  #顯示到畫面上
            NEXT FIELD pjec013                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec013
            #add-point:BEFORE FIELD pjec013 name="construct.b.page1.pjec013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec013
            
            #add-point:AFTER FIELD pjec013 name="construct.a.page1.pjec013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec014
            #add-point:BEFORE FIELD pjec014 name="construct.b.page1.pjec014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec014
            
            #add-point:AFTER FIELD pjec014 name="construct.a.page1.pjec014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec014
            #add-point:ON ACTION controlp INFIELD pjec014 name="construct.c.page1.pjec014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec015
            #add-point:BEFORE FIELD pjec015 name="construct.b.page1.pjec015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec015
            
            #add-point:AFTER FIELD pjec015 name="construct.a.page1.pjec015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec015
            #add-point:ON ACTION controlp INFIELD pjec015 name="construct.c.page1.pjec015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pjec016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec016
            #add-point:ON ACTION controlp INFIELD pjec016 name="construct.c.page1.pjec016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjec016  #顯示到畫面上
            NEXT FIELD pjec016                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec016
            #add-point:BEFORE FIELD pjec016 name="construct.b.page1.pjec016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec016
            
            #add-point:AFTER FIELD pjec016 name="construct.a.page1.pjec016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec017
            #add-point:BEFORE FIELD pjec017 name="construct.b.page1.pjec017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec017
            
            #add-point:AFTER FIELD pjec017 name="construct.a.page1.pjec017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec017
            #add-point:ON ACTION controlp INFIELD pjec017 name="construct.c.page1.pjec017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec018
            #add-point:BEFORE FIELD pjec018 name="construct.b.page1.pjec018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec018
            
            #add-point:AFTER FIELD pjec018 name="construct.a.page1.pjec018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec018
            #add-point:ON ACTION controlp INFIELD pjec018 name="construct.c.page1.pjec018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec019
            #add-point:BEFORE FIELD pjec019 name="construct.b.page1.pjec019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec019
            
            #add-point:AFTER FIELD pjec019 name="construct.a.page1.pjec019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec019
            #add-point:ON ACTION controlp INFIELD pjec019 name="construct.c.page1.pjec019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec020
            #add-point:BEFORE FIELD pjec020 name="construct.b.page1.pjec020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec020
            
            #add-point:AFTER FIELD pjec020 name="construct.a.page1.pjec020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec020
            #add-point:ON ACTION controlp INFIELD pjec020 name="construct.c.page1.pjec020"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pjec021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec021
            #add-point:ON ACTION controlp INFIELD pjec021 name="construct.c.page1.pjec021"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjec021  #顯示到畫面上
            NEXT FIELD pjec021                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec021
            #add-point:BEFORE FIELD pjec021 name="construct.b.page1.pjec021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec021
            
            #add-point:AFTER FIELD pjec021 name="construct.a.page1.pjec021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec022
            #add-point:ON ACTION controlp INFIELD pjec022 name="construct.c.page1.pjec022"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjec022  #顯示到畫面上
            NEXT FIELD pjec022                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec022
            #add-point:BEFORE FIELD pjec022 name="construct.b.page1.pjec022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec022
            
            #add-point:AFTER FIELD pjec022 name="construct.a.page1.pjec022"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec099
            #add-point:BEFORE FIELD pjec099 name="construct.b.page1.pjec099"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec099
            
            #add-point:AFTER FIELD pjec099 name="construct.a.page1.pjec099"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec099
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec099
            #add-point:ON ACTION controlp INFIELD pjec099 name="construct.c.page1.pjec099"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec200
            #add-point:BEFORE FIELD pjec200 name="construct.b.page1.pjec200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec200
            
            #add-point:AFTER FIELD pjec200 name="construct.a.page1.pjec200"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec200
            #add-point:ON ACTION controlp INFIELD pjec200 name="construct.c.page1.pjec200"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec100
            #add-point:BEFORE FIELD pjec100 name="construct.b.page1.pjec100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec100
            
            #add-point:AFTER FIELD pjec100 name="construct.a.page1.pjec100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec100
            #add-point:ON ACTION controlp INFIELD pjec100 name="construct.c.page1.pjec100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec110
            #add-point:BEFORE FIELD pjec110 name="construct.b.page1.pjec110"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec110
            
            #add-point:AFTER FIELD pjec110 name="construct.a.page1.pjec110"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec110
            #add-point:ON ACTION controlp INFIELD pjec110 name="construct.c.page1.pjec110"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec120
            #add-point:BEFORE FIELD pjec120 name="construct.b.page1.pjec120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec120
            
            #add-point:AFTER FIELD pjec120 name="construct.a.page1.pjec120"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec120
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec120
            #add-point:ON ACTION controlp INFIELD pjec120 name="construct.c.page1.pjec120"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec300
            #add-point:BEFORE FIELD pjec300 name="construct.b.page1.pjec300"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec300
            
            #add-point:AFTER FIELD pjec300 name="construct.a.page1.pjec300"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec300
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec300
            #add-point:ON ACTION controlp INFIELD pjec300 name="construct.c.page1.pjec300"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec310
            #add-point:BEFORE FIELD pjec310 name="construct.b.page1.pjec310"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec310
            
            #add-point:AFTER FIELD pjec310 name="construct.a.page1.pjec310"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec310
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec310
            #add-point:ON ACTION controlp INFIELD pjec310 name="construct.c.page1.pjec310"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec320
            #add-point:BEFORE FIELD pjec320 name="construct.b.page1.pjec320"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec320
            
            #add-point:AFTER FIELD pjec320 name="construct.a.page1.pjec320"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjec320
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec320
            #add-point:ON ACTION controlp INFIELD pjec320 name="construct.c.page1.pjec320"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.pjecownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjecownid
            #add-point:ON ACTION controlp INFIELD pjecownid name="construct.c.page2.pjecownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjecownid  #顯示到畫面上
            NEXT FIELD pjecownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjecownid
            #add-point:BEFORE FIELD pjecownid name="construct.b.page2.pjecownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjecownid
            
            #add-point:AFTER FIELD pjecownid name="construct.a.page2.pjecownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pjecowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjecowndp
            #add-point:ON ACTION controlp INFIELD pjecowndp name="construct.c.page2.pjecowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjecowndp  #顯示到畫面上
            NEXT FIELD pjecowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjecowndp
            #add-point:BEFORE FIELD pjecowndp name="construct.b.page2.pjecowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjecowndp
            
            #add-point:AFTER FIELD pjecowndp name="construct.a.page2.pjecowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pjeccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjeccrtid
            #add-point:ON ACTION controlp INFIELD pjeccrtid name="construct.c.page2.pjeccrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjeccrtid  #顯示到畫面上
            NEXT FIELD pjeccrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeccrtid
            #add-point:BEFORE FIELD pjeccrtid name="construct.b.page2.pjeccrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjeccrtid
            
            #add-point:AFTER FIELD pjeccrtid name="construct.a.page2.pjeccrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pjeccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjeccrtdp
            #add-point:ON ACTION controlp INFIELD pjeccrtdp name="construct.c.page2.pjeccrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjeccrtdp  #顯示到畫面上
            NEXT FIELD pjeccrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeccrtdp
            #add-point:BEFORE FIELD pjeccrtdp name="construct.b.page2.pjeccrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjeccrtdp
            
            #add-point:AFTER FIELD pjeccrtdp name="construct.a.page2.pjeccrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeccrtdt
            #add-point:BEFORE FIELD pjeccrtdt name="construct.b.page2.pjeccrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.pjecmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjecmodid
            #add-point:ON ACTION controlp INFIELD pjecmodid name="construct.c.page2.pjecmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjecmodid  #顯示到畫面上
            NEXT FIELD pjecmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjecmodid
            #add-point:BEFORE FIELD pjecmodid name="construct.b.page2.pjecmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjecmodid
            
            #add-point:AFTER FIELD pjecmodid name="construct.a.page2.pjecmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjecmoddt
            #add-point:BEFORE FIELD pjecmoddt name="construct.b.page2.pjecmoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      INPUT BY NAME g_pjec_m.byear,g_pjec_m.bmonth,g_pjec_m.eyear,g_pjec_m.emonth ATTRIBUTE(WITHOUT DEFAULTS)
         AFTER FIELD byear
             IF NOT cl_null(g_pjec_m.byear) THEN
                IF g_pjec_m.byear < 1911 OR g_pjec_m.byear > 3000 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'abx-00066'
                   LET g_errparam.extend = g_pjec_m.byear
                   LET g_errparam.popup = TRUE
                   CALL cl_err()    
                   NEXT FIELD CURRENT                  
                END IF
             END IF
             IF NOT cl_null(g_pjec_m.byear) AND NOT cl_null(g_pjec_m.eyear) 
               AND g_pjec_m.byear>g_pjec_m.eyear THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'acr-00064'   #  起始年度不能大于截止年度！
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            
         AFTER FIELD bmonth           
            IF NOT cl_null(g_pjec_m.bmonth) THEN
                IF g_pjec_m.bmonth < 1 OR g_pjec_m.bmonth > 12 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'abx-00067'
                   LET g_errparam.extend = g_pjec_m.bmonth
                   LET g_errparam.popup = TRUE
                   CALL cl_err()    
                   NEXT FIELD CURRENT                  
                END IF
             END IF
            IF NOT cl_null(g_pjec_m.bmonth) AND NOT cl_null(g_pjec_m.byear)
               AND NOT cl_null(g_pjec_m.emonth) AND NOT cl_null(g_pjec_m.eyear)
               AND g_pjec_m.byear=g_pjec_m.eyear AND g_pjec_m.bmonth>g_pjec_m.emonth THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'agl-00227'   #  起始期别不可大于截止期别！
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            
         AFTER FIELD eyear
             IF NOT cl_null(g_pjec_m.eyear) THEN
                IF g_pjec_m.eyear < 1911 OR g_pjec_m.eyear > 3000 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'abx-00066'
                   LET g_errparam.extend = g_pjec_m.byear
                   LET g_errparam.popup = TRUE
                   CALL cl_err()    
                   NEXT FIELD CURRENT                  
                END IF
             END IF
             IF NOT cl_null(g_pjec_m.byear) AND NOT cl_null(g_pjec_m.eyear) 
                AND g_pjec_m.byear>g_pjec_m.eyear THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "" 
                LET g_errparam.code   = 'gl-00373'   #  起始年度不能大于截止年度！
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                NEXT FIELD CURRENT
             END IF
            
         AFTER FIELD emonth
            IF NOT cl_null(g_pjec_m.emonth) THEN
               IF g_pjec_m.emonth < 1 OR g_pjec_m.emonth > 12 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abx-00067'
                  LET g_errparam.extend = g_pjec_m.emonth
                  LET g_errparam.popup = TRUE
                  CALL cl_err()    
                  NEXT FIELD CURRENT                  
               END IF
            END IF
            IF NOT cl_null(g_pjec_m.bmonth) AND NOT cl_null(g_pjec_m.byear)
               AND NOT cl_null(g_pjec_m.emonth) AND NOT cl_null(g_pjec_m.eyear)
               AND g_pjec_m.byear=g_pjec_m.eyear AND g_pjec_m.bmonth>g_pjec_m.emonth THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'agl-00228'   #  起始期别不可大于截止期别！
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
      END INPUT
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
   IF NOT cl_null(g_pjec_m.byear) AND NOT cl_null(g_pjec_m.eyear) AND NOT cl_null(g_pjec_m.bmonth) AND NOT cl_null(g_pjec_m.emonth) THEN
      IF cl_null(g_wc) THEN LET g_wc = " 1=1 " END IF
      LET g_wc = g_wc," AND (pjec002*12+pjec003 BETWEEN ",g_pjec_m.byear*12+g_pjec_m.bmonth," AND ",g_pjec_m.eyear*12+g_pjec_m.emonth,") "
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
 
{<section id="apjq400.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apjq400_query()
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
   CALL g_pjec_d.clear()
   CALL g_pjec2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL apjq400_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apjq400_browser_fill(g_wc)
      CALL apjq400_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL apjq400_browser_fill("F")
   
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
      CALL apjq400_fetch("F") 
   END IF
   
   CALL apjq400_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="apjq400.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apjq400_fetch(p_flag)
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
   
   #CALL apjq400_browser_fill(p_flag)
   
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
   
   LET g_pjec_m.pjecld = g_browser[g_current_idx].b_pjecld
   LET g_pjec_m.pjec002 = g_browser[g_current_idx].b_pjec002
   LET g_pjec_m.pjec003 = g_browser[g_current_idx].b_pjec003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apjq400_master_referesh USING g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003 INTO g_pjec_m.pjeccomp, 
       g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003,g_pjec_m.pjeccomp_desc,g_pjec_m.pjecld_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "pjec_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_pjec_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_pjec_m_mask_o.* =  g_pjec_m.*
   CALL apjq400_pjec_t_mask()
   LET g_pjec_m_mask_n.* =  g_pjec_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apjq400_set_act_visible()
   CALL apjq400_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_pjec_m_t.* = g_pjec_m.*
   LET g_pjec_m_o.* = g_pjec_m.*
   
   #重新顯示   
   CALL apjq400_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="apjq400.insert" >}
#+ 資料新增
PRIVATE FUNCTION apjq400_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_pjec_d.clear()
   CALL g_pjec2_d.clear()
 
 
   INITIALIZE g_pjec_m.* TO NULL             #DEFAULT 設定
   LET g_pjecld_t = NULL
   LET g_pjec002_t = NULL
   LET g_pjec003_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL apjq400_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_pjec_m.* TO NULL
         INITIALIZE g_pjec_d TO NULL
         INITIALIZE g_pjec2_d TO NULL
 
         CALL apjq400_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pjec_m.* = g_pjec_m_t.*
         CALL apjq400_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_pjec_d.clear()
      #CALL g_pjec2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apjq400_set_act_visible()
   CALL apjq400_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pjecld_t = g_pjec_m.pjecld
   LET g_pjec002_t = g_pjec_m.pjec002
   LET g_pjec003_t = g_pjec_m.pjec003
 
   
   #組合新增資料的條件
   LET g_add_browse = " pjecent = " ||g_enterprise|| " AND",
                      " pjecld = '", g_pjec_m.pjecld, "' "
                      ," AND pjec002 = '", g_pjec_m.pjec002, "' "
                      ," AND pjec003 = '", g_pjec_m.pjec003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apjq400_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL apjq400_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apjq400_master_referesh USING g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003 INTO g_pjec_m.pjeccomp, 
       g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003,g_pjec_m.pjeccomp_desc,g_pjec_m.pjecld_desc 
 
   
   #遮罩相關處理
   LET g_pjec_m_mask_o.* =  g_pjec_m.*
   CALL apjq400_pjec_t_mask()
   LET g_pjec_m_mask_n.* =  g_pjec_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pjec_m.pjeccomp,g_pjec_m.pjeccomp_desc,g_pjec_m.pjecld,g_pjec_m.pjecld_desc,g_pjec_m.pjec002, 
       g_pjec_m.pjec003,g_pjec_m.byear,g_pjec_m.bmonth,g_pjec_m.eyear,g_pjec_m.emonth
   
   #功能已完成,通報訊息中心
   CALL apjq400_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apjq400.modify" >}
#+ 資料修改
PRIVATE FUNCTION apjq400_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_pjec_m.pjecld IS NULL
   OR g_pjec_m.pjec002 IS NULL
   OR g_pjec_m.pjec003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_pjecld_t = g_pjec_m.pjecld
   LET g_pjec002_t = g_pjec_m.pjec002
   LET g_pjec003_t = g_pjec_m.pjec003
 
   CALL s_transaction_begin()
   
   OPEN apjq400_cl USING g_enterprise,g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apjq400_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE apjq400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apjq400_master_referesh USING g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003 INTO g_pjec_m.pjeccomp, 
       g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003,g_pjec_m.pjeccomp_desc,g_pjec_m.pjecld_desc 
 
   
   #遮罩相關處理
   LET g_pjec_m_mask_o.* =  g_pjec_m.*
   CALL apjq400_pjec_t_mask()
   LET g_pjec_m_mask_n.* =  g_pjec_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL apjq400_show()
   WHILE TRUE
      LET g_pjecld_t = g_pjec_m.pjecld
      LET g_pjec002_t = g_pjec_m.pjec002
      LET g_pjec003_t = g_pjec_m.pjec003
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL apjq400_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pjec_m.* = g_pjec_m_t.*
         CALL apjq400_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_pjec_m.pjecld != g_pjecld_t 
      OR g_pjec_m.pjec002 != g_pjec002_t 
      OR g_pjec_m.pjec003 != g_pjec003_t 
 
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
   CALL apjq400_set_act_visible()
   CALL apjq400_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pjecent = " ||g_enterprise|| " AND",
                      " pjecld = '", g_pjec_m.pjecld, "' "
                      ," AND pjec002 = '", g_pjec_m.pjec002, "' "
                      ," AND pjec003 = '", g_pjec_m.pjec003, "' "
 
   #填到對應位置
   CALL apjq400_browser_fill("")
 
   CALL apjq400_idx_chk()
 
   CLOSE apjq400_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apjq400_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="apjq400.input" >}
#+ 資料輸入
PRIVATE FUNCTION apjq400_input(p_cmd)
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
   DISPLAY BY NAME g_pjec_m.pjeccomp,g_pjec_m.pjeccomp_desc,g_pjec_m.pjecld,g_pjec_m.pjecld_desc,g_pjec_m.pjec002, 
       g_pjec_m.pjec003,g_pjec_m.byear,g_pjec_m.bmonth,g_pjec_m.eyear,g_pjec_m.emonth
   
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
   LET g_forupd_sql = "SELECT pjecseq,pjec004,pjec005,pjec010,pjec011,pjec012,pjec013,pjec014,pjec015, 
       pjec016,pjec017,pjec018,pjec019,pjec020,pjec021,pjec022,pjec099,pjec200,pjec100,pjec110,pjec120, 
       pjec300,pjec310,pjec320,pjecownid,pjecowndp,pjeccrtid,pjeccrtdp,pjeccrtdt,pjecmodid,pjecmoddt, 
       pjecseq FROM pjec_t WHERE pjecent=? AND pjecld=? AND pjec002=? AND pjec003=? AND pjecseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apjq400_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apjq400_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apjq400_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_pjec_m.pjeccomp,g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003,g_pjec_m.byear, 
       g_pjec_m.bmonth,g_pjec_m.eyear,g_pjec_m.emonth
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apjq400.input.head" >}
   
      #單頭段
      INPUT BY NAME g_pjec_m.pjeccomp,g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003,g_pjec_m.byear, 
          g_pjec_m.bmonth,g_pjec_m.eyear,g_pjec_m.emonth 
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
         AFTER FIELD pjeccomp
            
            #add-point:AFTER FIELD pjeccomp name="input.a.pjeccomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjec_m.pjeccomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjec_m.pjeccomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjec_m.pjeccomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeccomp
            #add-point:BEFORE FIELD pjeccomp name="input.b.pjeccomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjeccomp
            #add-point:ON CHANGE pjeccomp name="input.g.pjeccomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjecld
            
            #add-point:AFTER FIELD pjecld name="input.a.pjecld"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_pjec_m.pjecld) AND NOT cl_null(g_pjec_m.pjec002) AND NOT cl_null(g_pjec_m.pjec003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjec_m.pjecld != g_pjecld_t  OR g_pjec_m.pjec002 != g_pjec002_t  OR g_pjec_m.pjec003 != g_pjec003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjec_t WHERE "||"pjecent = " ||g_enterprise|| " AND "||"pjecld = '"||g_pjec_m.pjecld ||"' AND "|| "pjec002 = '"||g_pjec_m.pjec002 ||"' AND "|| "pjec003 = '"||g_pjec_m.pjec003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjecld
            #add-point:BEFORE FIELD pjecld name="input.b.pjecld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjecld
            #add-point:ON CHANGE pjecld name="input.g.pjecld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec002
            #add-point:BEFORE FIELD pjec002 name="input.b.pjec002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec002
            
            #add-point:AFTER FIELD pjec002 name="input.a.pjec002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_pjec_m.pjecld) AND NOT cl_null(g_pjec_m.pjec002) AND NOT cl_null(g_pjec_m.pjec003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjec_m.pjecld != g_pjecld_t  OR g_pjec_m.pjec002 != g_pjec002_t  OR g_pjec_m.pjec003 != g_pjec003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjec_t WHERE "||"pjecent = " ||g_enterprise|| " AND "||"pjecld = '"||g_pjec_m.pjecld ||"' AND "|| "pjec002 = '"||g_pjec_m.pjec002 ||"' AND "|| "pjec003 = '"||g_pjec_m.pjec003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec002
            #add-point:ON CHANGE pjec002 name="input.g.pjec002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec003
            #add-point:BEFORE FIELD pjec003 name="input.b.pjec003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec003
            
            #add-point:AFTER FIELD pjec003 name="input.a.pjec003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_pjec_m.pjecld) AND NOT cl_null(g_pjec_m.pjec002) AND NOT cl_null(g_pjec_m.pjec003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjec_m.pjecld != g_pjecld_t  OR g_pjec_m.pjec002 != g_pjec002_t  OR g_pjec_m.pjec003 != g_pjec003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjec_t WHERE "||"pjecent = " ||g_enterprise|| " AND "||"pjecld = '"||g_pjec_m.pjecld ||"' AND "|| "pjec002 = '"||g_pjec_m.pjec002 ||"' AND "|| "pjec003 = '"||g_pjec_m.pjec003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec003
            #add-point:ON CHANGE pjec003 name="input.g.pjec003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD byear
            #add-point:BEFORE FIELD byear name="input.b.byear"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD byear
            
            #add-point:AFTER FIELD byear name="input.a.byear"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE byear
            #add-point:ON CHANGE byear name="input.g.byear"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmonth
            #add-point:BEFORE FIELD bmonth name="input.b.bmonth"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmonth
            
            #add-point:AFTER FIELD bmonth name="input.a.bmonth"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmonth
            #add-point:ON CHANGE bmonth name="input.g.bmonth"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD eyear
            #add-point:BEFORE FIELD eyear name="input.b.eyear"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD eyear
            
            #add-point:AFTER FIELD eyear name="input.a.eyear"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE eyear
            #add-point:ON CHANGE eyear name="input.g.eyear"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD emonth
            #add-point:BEFORE FIELD emonth name="input.b.emonth"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD emonth
            
            #add-point:AFTER FIELD emonth name="input.a.emonth"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE emonth
            #add-point:ON CHANGE emonth name="input.g.emonth"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pjeccomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjeccomp
            #add-point:ON ACTION controlp INFIELD pjeccomp name="input.c.pjeccomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjecld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjecld
            #add-point:ON ACTION controlp INFIELD pjecld name="input.c.pjecld"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjec002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec002
            #add-point:ON ACTION controlp INFIELD pjec002 name="input.c.pjec002"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjec003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec003
            #add-point:ON ACTION controlp INFIELD pjec003 name="input.c.pjec003"
            
            #END add-point
 
 
         #Ctrlp:input.c.byear
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD byear
            #add-point:ON ACTION controlp INFIELD byear name="input.c.byear"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmonth
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmonth
            #add-point:ON ACTION controlp INFIELD bmonth name="input.c.bmonth"
            
            #END add-point
 
 
         #Ctrlp:input.c.eyear
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD eyear
            #add-point:ON ACTION controlp INFIELD eyear name="input.c.eyear"
            
            #END add-point
 
 
         #Ctrlp:input.c.emonth
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD emonth
            #add-point:ON ACTION controlp INFIELD emonth name="input.c.emonth"
            
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
            DISPLAY BY NAME g_pjec_m.pjecld             
                            ,g_pjec_m.pjec002   
                            ,g_pjec_m.pjec003   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL apjq400_pjec_t_mask_restore('restore_mask_o')
            
               UPDATE pjec_t SET (pjeccomp,pjecld,pjec002,pjec003) = (g_pjec_m.pjeccomp,g_pjec_m.pjecld, 
                   g_pjec_m.pjec002,g_pjec_m.pjec003)
                WHERE pjecent = g_enterprise AND pjecld = g_pjecld_t
                  AND pjec002 = g_pjec002_t
                  AND pjec003 = g_pjec003_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pjec_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pjec_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pjec_m.pjecld
               LET gs_keys_bak[1] = g_pjecld_t
               LET gs_keys[2] = g_pjec_m.pjec002
               LET gs_keys_bak[2] = g_pjec002_t
               LET gs_keys[3] = g_pjec_m.pjec003
               LET gs_keys_bak[3] = g_pjec003_t
               LET gs_keys[4] = g_pjec_d[g_detail_idx].pjecseq
               LET gs_keys_bak[4] = g_pjec_d_t.pjecseq
               CALL apjq400_update_b('pjec_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_pjec_m_t)
                     #LET g_log2 = util.JSON.stringify(g_pjec_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL apjq400_pjec_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apjq400_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_pjecld_t = g_pjec_m.pjecld
           LET g_pjec002_t = g_pjec_m.pjec002
           LET g_pjec003_t = g_pjec_m.pjec003
 
           
           IF g_pjec_d.getLength() = 0 THEN
              NEXT FIELD pjecseq
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="apjq400.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_pjec_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pjec_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apjq400_b_fill(g_wc2) #test 
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
            CALL apjq400_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN apjq400_cl USING g_enterprise,g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE apjq400_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN apjq400_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_pjec_d[l_ac].pjecseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pjec_d_t.* = g_pjec_d[l_ac].*  #BACKUP
               LET g_pjec_d_o.* = g_pjec_d[l_ac].*  #BACKUP
               CALL apjq400_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL apjq400_set_no_entry_b(l_cmd)
               OPEN apjq400_bcl USING g_enterprise,g_pjec_m.pjecld,
                                                g_pjec_m.pjec002,
                                                g_pjec_m.pjec003,
 
                                                g_pjec_d_t.pjecseq
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN apjq400_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apjq400_bcl INTO g_pjec_d[l_ac].pjecseq,g_pjec_d[l_ac].pjec004,g_pjec_d[l_ac].pjec005, 
                      g_pjec_d[l_ac].pjec010,g_pjec_d[l_ac].pjec011,g_pjec_d[l_ac].pjec012,g_pjec_d[l_ac].pjec013, 
                      g_pjec_d[l_ac].pjec014,g_pjec_d[l_ac].pjec015,g_pjec_d[l_ac].pjec016,g_pjec_d[l_ac].pjec017, 
                      g_pjec_d[l_ac].pjec018,g_pjec_d[l_ac].pjec019,g_pjec_d[l_ac].pjec020,g_pjec_d[l_ac].pjec021, 
                      g_pjec_d[l_ac].pjec022,g_pjec_d[l_ac].pjec099,g_pjec_d[l_ac].pjec200,g_pjec_d[l_ac].pjec100, 
                      g_pjec_d[l_ac].pjec110,g_pjec_d[l_ac].pjec120,g_pjec_d[l_ac].pjec300,g_pjec_d[l_ac].pjec310, 
                      g_pjec_d[l_ac].pjec320,g_pjec2_d[l_ac].pjecownid,g_pjec2_d[l_ac].pjecowndp,g_pjec2_d[l_ac].pjeccrtid, 
                      g_pjec2_d[l_ac].pjeccrtdp,g_pjec2_d[l_ac].pjeccrtdt,g_pjec2_d[l_ac].pjecmodid, 
                      g_pjec2_d[l_ac].pjecmoddt,g_pjec2_d[l_ac].pjecseq
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_pjec_d_t.pjecseq,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pjec_d_mask_o[l_ac].* =  g_pjec_d[l_ac].*
                  CALL apjq400_pjec_t_mask()
                  LET g_pjec_d_mask_n[l_ac].* =  g_pjec_d[l_ac].*
                  
                  CALL apjq400_ref_show()
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
            INITIALIZE g_pjec_d_t.* TO NULL
            INITIALIZE g_pjec_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pjec_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pjec2_d[l_ac].pjecownid = g_user
      LET g_pjec2_d[l_ac].pjecowndp = g_dept
      LET g_pjec2_d[l_ac].pjeccrtid = g_user
      LET g_pjec2_d[l_ac].pjeccrtdp = g_dept 
      LET g_pjec2_d[l_ac].pjeccrtdt = cl_get_current()
      LET g_pjec2_d[l_ac].pjecmodid = g_user
      LET g_pjec2_d[l_ac].pjecmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
                  LET g_pjec_d[l_ac].pjec200 = "0"
      LET g_pjec_d[l_ac].pjec100 = "0"
      LET g_pjec_d[l_ac].pjec110 = "0"
      LET g_pjec_d[l_ac].pjec120 = "0"
      LET g_pjec_d[l_ac].pjec300 = "0"
      LET g_pjec_d[l_ac].pjec310 = "0"
      LET g_pjec_d[l_ac].pjec320 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_pjec_d_t.* = g_pjec_d[l_ac].*     #新輸入資料
            LET g_pjec_d_o.* = g_pjec_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apjq400_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL apjq400_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pjec_d[li_reproduce_target].* = g_pjec_d[li_reproduce].*
               LET g_pjec2_d[li_reproduce_target].* = g_pjec2_d[li_reproduce].*
 
               LET g_pjec_d[g_pjec_d.getLength()].pjecseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM pjec_t 
             WHERE pjecent = g_enterprise AND pjecld = g_pjec_m.pjecld
               AND pjec002 = g_pjec_m.pjec002
               AND pjec003 = g_pjec_m.pjec003
 
               AND pjecseq = g_pjec_d[l_ac].pjecseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO pjec_t
                           (pjecent,
                            pjeccomp,pjecld,pjec002,pjec003,
                            pjecseq
                            ,pjec004,pjec005,pjec010,pjec011,pjec012,pjec013,pjec014,pjec015,pjec016,pjec017,pjec018,pjec019,pjec020,pjec021,pjec022,pjec099,pjec200,pjec100,pjec110,pjec120,pjec300,pjec310,pjec320,pjecownid,pjecowndp,pjeccrtid,pjeccrtdp,pjeccrtdt,pjecmodid,pjecmoddt) 
                     VALUES(g_enterprise,
                            g_pjec_m.pjeccomp,g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003,
                            g_pjec_d[l_ac].pjecseq
                            ,g_pjec_d[l_ac].pjec004,g_pjec_d[l_ac].pjec005,g_pjec_d[l_ac].pjec010,g_pjec_d[l_ac].pjec011, 
                                g_pjec_d[l_ac].pjec012,g_pjec_d[l_ac].pjec013,g_pjec_d[l_ac].pjec014, 
                                g_pjec_d[l_ac].pjec015,g_pjec_d[l_ac].pjec016,g_pjec_d[l_ac].pjec017, 
                                g_pjec_d[l_ac].pjec018,g_pjec_d[l_ac].pjec019,g_pjec_d[l_ac].pjec020, 
                                g_pjec_d[l_ac].pjec021,g_pjec_d[l_ac].pjec022,g_pjec_d[l_ac].pjec099, 
                                g_pjec_d[l_ac].pjec200,g_pjec_d[l_ac].pjec100,g_pjec_d[l_ac].pjec110, 
                                g_pjec_d[l_ac].pjec120,g_pjec_d[l_ac].pjec300,g_pjec_d[l_ac].pjec310, 
                                g_pjec_d[l_ac].pjec320,g_pjec2_d[l_ac].pjecownid,g_pjec2_d[l_ac].pjecowndp, 
                                g_pjec2_d[l_ac].pjeccrtid,g_pjec2_d[l_ac].pjeccrtdp,g_pjec2_d[l_ac].pjeccrtdt, 
                                g_pjec2_d[l_ac].pjecmodid,g_pjec2_d[l_ac].pjecmoddt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_pjec_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "pjec_t:",SQLERRMESSAGE 
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
               IF apjq400_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_pjec_m.pjecld
                  LET gs_keys[gs_keys.getLength()+1] = g_pjec_m.pjec002
                  LET gs_keys[gs_keys.getLength()+1] = g_pjec_m.pjec003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pjec_d_t.pjecseq
 
 
                  #刪除下層單身
                  IF NOT apjq400_key_delete_b(gs_keys,'pjec_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE apjq400_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE apjq400_bcl
               LET l_count = g_pjec_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_pjec_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjecseq
            #add-point:BEFORE FIELD pjecseq name="input.b.page1.pjecseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjecseq
            
            #add-point:AFTER FIELD pjecseq name="input.a.page1.pjecseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_pjec_m.pjecld IS NOT NULL AND g_pjec_m.pjec002 IS NOT NULL AND g_pjec_m.pjec003 IS NOT NULL AND g_pjec_d[g_detail_idx].pjecseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjec_m.pjecld != g_pjecld_t OR g_pjec_m.pjec002 != g_pjec002_t OR g_pjec_m.pjec003 != g_pjec003_t OR g_pjec_d[g_detail_idx].pjecseq != g_pjec_d_t.pjecseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjec_t WHERE "||"pjecent = " ||g_enterprise|| " AND "||"pjecld = '"||g_pjec_m.pjecld ||"' AND "|| "pjec002 = '"||g_pjec_m.pjec002 ||"' AND "|| "pjec003 = '"||g_pjec_m.pjec003 ||"' AND "|| "pjecseq = '"||g_pjec_d[g_detail_idx].pjecseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjecseq
            #add-point:ON CHANGE pjecseq name="input.g.page1.pjecseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec004
            
            #add-point:AFTER FIELD pjec004 name="input.a.page1.pjec004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjec_d[l_ac].pjec004
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent="||g_enterprise||" AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjec_d[l_ac].pjec004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjec_d[l_ac].pjec004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec004
            #add-point:BEFORE FIELD pjec004 name="input.b.page1.pjec004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec004
            #add-point:ON CHANGE pjec004 name="input.g.page1.pjec004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec005
            
            #add-point:AFTER FIELD pjec005 name="input.a.page1.pjec005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjec_d[l_ac].pjec004
            LET g_ref_fields[2] = g_pjec_d[l_ac].pjec005
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent="||g_enterprise||" AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjec_d[l_ac].pjec005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjec_d[l_ac].pjec005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec005
            #add-point:BEFORE FIELD pjec005 name="input.b.page1.pjec005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec005
            #add-point:ON CHANGE pjec005 name="input.g.page1.pjec005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec010
            
            #add-point:AFTER FIELD pjec010 name="input.a.page1.pjec010"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec010
            #add-point:BEFORE FIELD pjec010 name="input.b.page1.pjec010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec010
            #add-point:ON CHANGE pjec010 name="input.g.page1.pjec010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec011
            
            #add-point:AFTER FIELD pjec011 name="input.a.page1.pjec011"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjec_d[l_ac].pjec011
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjec_d[l_ac].pjec011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjec_d[l_ac].pjec011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec011
            #add-point:BEFORE FIELD pjec011 name="input.b.page1.pjec011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec011
            #add-point:ON CHANGE pjec011 name="input.g.page1.pjec011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec012
            
            #add-point:AFTER FIELD pjec012 name="input.a.page1.pjec012"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjec_d[l_ac].pjec012
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjec_d[l_ac].pjec012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjec_d[l_ac].pjec012_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec012
            #add-point:BEFORE FIELD pjec012 name="input.b.page1.pjec012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec012
            #add-point:ON CHANGE pjec012 name="input.g.page1.pjec012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec013
            
            #add-point:AFTER FIELD pjec013 name="input.a.page1.pjec013"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjec_d[l_ac].pjec013
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent="||g_enterprise||" AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjec_d[l_ac].pjec013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjec_d[l_ac].pjec013_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec013
            #add-point:BEFORE FIELD pjec013 name="input.b.page1.pjec013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec013
            #add-point:ON CHANGE pjec013 name="input.g.page1.pjec013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec014
            #add-point:BEFORE FIELD pjec014 name="input.b.page1.pjec014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec014
            
            #add-point:AFTER FIELD pjec014 name="input.a.page1.pjec014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec014
            #add-point:ON CHANGE pjec014 name="input.g.page1.pjec014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec015
            #add-point:BEFORE FIELD pjec015 name="input.b.page1.pjec015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec015
            
            #add-point:AFTER FIELD pjec015 name="input.a.page1.pjec015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec015
            #add-point:ON CHANGE pjec015 name="input.g.page1.pjec015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec016
            #add-point:BEFORE FIELD pjec016 name="input.b.page1.pjec016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec016
            
            #add-point:AFTER FIELD pjec016 name="input.a.page1.pjec016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec016
            #add-point:ON CHANGE pjec016 name="input.g.page1.pjec016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec017
            #add-point:BEFORE FIELD pjec017 name="input.b.page1.pjec017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec017
            
            #add-point:AFTER FIELD pjec017 name="input.a.page1.pjec017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec017
            #add-point:ON CHANGE pjec017 name="input.g.page1.pjec017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec018
            #add-point:BEFORE FIELD pjec018 name="input.b.page1.pjec018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec018
            
            #add-point:AFTER FIELD pjec018 name="input.a.page1.pjec018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec018
            #add-point:ON CHANGE pjec018 name="input.g.page1.pjec018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec019
            #add-point:BEFORE FIELD pjec019 name="input.b.page1.pjec019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec019
            
            #add-point:AFTER FIELD pjec019 name="input.a.page1.pjec019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec019
            #add-point:ON CHANGE pjec019 name="input.g.page1.pjec019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec020
            #add-point:BEFORE FIELD pjec020 name="input.b.page1.pjec020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec020
            
            #add-point:AFTER FIELD pjec020 name="input.a.page1.pjec020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec020
            #add-point:ON CHANGE pjec020 name="input.g.page1.pjec020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec021
            #add-point:BEFORE FIELD pjec021 name="input.b.page1.pjec021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec021
            
            #add-point:AFTER FIELD pjec021 name="input.a.page1.pjec021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec021
            #add-point:ON CHANGE pjec021 name="input.g.page1.pjec021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec022
            #add-point:BEFORE FIELD pjec022 name="input.b.page1.pjec022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec022
            
            #add-point:AFTER FIELD pjec022 name="input.a.page1.pjec022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec022
            #add-point:ON CHANGE pjec022 name="input.g.page1.pjec022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec099
            #add-point:BEFORE FIELD pjec099 name="input.b.page1.pjec099"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec099
            
            #add-point:AFTER FIELD pjec099 name="input.a.page1.pjec099"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec099
            #add-point:ON CHANGE pjec099 name="input.g.page1.pjec099"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec200
            #add-point:BEFORE FIELD pjec200 name="input.b.page1.pjec200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec200
            
            #add-point:AFTER FIELD pjec200 name="input.a.page1.pjec200"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec200
            #add-point:ON CHANGE pjec200 name="input.g.page1.pjec200"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec100
            #add-point:BEFORE FIELD pjec100 name="input.b.page1.pjec100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec100
            
            #add-point:AFTER FIELD pjec100 name="input.a.page1.pjec100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec100
            #add-point:ON CHANGE pjec100 name="input.g.page1.pjec100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec110
            #add-point:BEFORE FIELD pjec110 name="input.b.page1.pjec110"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec110
            
            #add-point:AFTER FIELD pjec110 name="input.a.page1.pjec110"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec110
            #add-point:ON CHANGE pjec110 name="input.g.page1.pjec110"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec120
            #add-point:BEFORE FIELD pjec120 name="input.b.page1.pjec120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec120
            
            #add-point:AFTER FIELD pjec120 name="input.a.page1.pjec120"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec120
            #add-point:ON CHANGE pjec120 name="input.g.page1.pjec120"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec300
            #add-point:BEFORE FIELD pjec300 name="input.b.page1.pjec300"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec300
            
            #add-point:AFTER FIELD pjec300 name="input.a.page1.pjec300"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec300
            #add-point:ON CHANGE pjec300 name="input.g.page1.pjec300"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec310
            #add-point:BEFORE FIELD pjec310 name="input.b.page1.pjec310"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec310
            
            #add-point:AFTER FIELD pjec310 name="input.a.page1.pjec310"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec310
            #add-point:ON CHANGE pjec310 name="input.g.page1.pjec310"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec320
            #add-point:BEFORE FIELD pjec320 name="input.b.page1.pjec320"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec320
            
            #add-point:AFTER FIELD pjec320 name="input.a.page1.pjec320"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec320
            #add-point:ON CHANGE pjec320 name="input.g.page1.pjec320"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pjecseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjecseq
            #add-point:ON ACTION controlp INFIELD pjecseq name="input.c.page1.pjecseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec004
            #add-point:ON ACTION controlp INFIELD pjec004 name="input.c.page1.pjec004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec005
            #add-point:ON ACTION controlp INFIELD pjec005 name="input.c.page1.pjec005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec010
            #add-point:ON ACTION controlp INFIELD pjec010 name="input.c.page1.pjec010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec011
            #add-point:ON ACTION controlp INFIELD pjec011 name="input.c.page1.pjec011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec012
            #add-point:ON ACTION controlp INFIELD pjec012 name="input.c.page1.pjec012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec013
            #add-point:ON ACTION controlp INFIELD pjec013 name="input.c.page1.pjec013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec014
            #add-point:ON ACTION controlp INFIELD pjec014 name="input.c.page1.pjec014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec015
            #add-point:ON ACTION controlp INFIELD pjec015 name="input.c.page1.pjec015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec016
            #add-point:ON ACTION controlp INFIELD pjec016 name="input.c.page1.pjec016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec017
            #add-point:ON ACTION controlp INFIELD pjec017 name="input.c.page1.pjec017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec018
            #add-point:ON ACTION controlp INFIELD pjec018 name="input.c.page1.pjec018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec019
            #add-point:ON ACTION controlp INFIELD pjec019 name="input.c.page1.pjec019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec020
            #add-point:ON ACTION controlp INFIELD pjec020 name="input.c.page1.pjec020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec021
            #add-point:ON ACTION controlp INFIELD pjec021 name="input.c.page1.pjec021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec022
            #add-point:ON ACTION controlp INFIELD pjec022 name="input.c.page1.pjec022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec099
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec099
            #add-point:ON ACTION controlp INFIELD pjec099 name="input.c.page1.pjec099"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec200
            #add-point:ON ACTION controlp INFIELD pjec200 name="input.c.page1.pjec200"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec100
            #add-point:ON ACTION controlp INFIELD pjec100 name="input.c.page1.pjec100"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec110
            #add-point:ON ACTION controlp INFIELD pjec110 name="input.c.page1.pjec110"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec120
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec120
            #add-point:ON ACTION controlp INFIELD pjec120 name="input.c.page1.pjec120"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec300
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec300
            #add-point:ON ACTION controlp INFIELD pjec300 name="input.c.page1.pjec300"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec310
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec310
            #add-point:ON ACTION controlp INFIELD pjec310 name="input.c.page1.pjec310"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjec320
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec320
            #add-point:ON ACTION controlp INFIELD pjec320 name="input.c.page1.pjec320"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pjec_d[l_ac].* = g_pjec_d_t.*
               CLOSE apjq400_bcl
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
               LET g_errparam.extend = g_pjec_d[l_ac].pjecseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_pjec_d[l_ac].* = g_pjec_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_pjec2_d[l_ac].pjecmodid = g_user 
LET g_pjec2_d[l_ac].pjecmoddt = cl_get_current()
LET g_pjec2_d[l_ac].pjecmodid_desc = cl_get_username(g_pjec2_d[l_ac].pjecmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL apjq400_pjec_t_mask_restore('restore_mask_o')
         
               UPDATE pjec_t SET (pjecld,pjec002,pjec003,pjecseq,pjec004,pjec005,pjec010,pjec011,pjec012, 
                   pjec013,pjec014,pjec015,pjec016,pjec017,pjec018,pjec019,pjec020,pjec021,pjec022,pjec099, 
                   pjec200,pjec100,pjec110,pjec120,pjec300,pjec310,pjec320,pjecownid,pjecowndp,pjeccrtid, 
                   pjeccrtdp,pjeccrtdt,pjecmodid,pjecmoddt) = (g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003, 
                   g_pjec_d[l_ac].pjecseq,g_pjec_d[l_ac].pjec004,g_pjec_d[l_ac].pjec005,g_pjec_d[l_ac].pjec010, 
                   g_pjec_d[l_ac].pjec011,g_pjec_d[l_ac].pjec012,g_pjec_d[l_ac].pjec013,g_pjec_d[l_ac].pjec014, 
                   g_pjec_d[l_ac].pjec015,g_pjec_d[l_ac].pjec016,g_pjec_d[l_ac].pjec017,g_pjec_d[l_ac].pjec018, 
                   g_pjec_d[l_ac].pjec019,g_pjec_d[l_ac].pjec020,g_pjec_d[l_ac].pjec021,g_pjec_d[l_ac].pjec022, 
                   g_pjec_d[l_ac].pjec099,g_pjec_d[l_ac].pjec200,g_pjec_d[l_ac].pjec100,g_pjec_d[l_ac].pjec110, 
                   g_pjec_d[l_ac].pjec120,g_pjec_d[l_ac].pjec300,g_pjec_d[l_ac].pjec310,g_pjec_d[l_ac].pjec320, 
                   g_pjec2_d[l_ac].pjecownid,g_pjec2_d[l_ac].pjecowndp,g_pjec2_d[l_ac].pjeccrtid,g_pjec2_d[l_ac].pjeccrtdp, 
                   g_pjec2_d[l_ac].pjeccrtdt,g_pjec2_d[l_ac].pjecmodid,g_pjec2_d[l_ac].pjecmoddt)
                WHERE pjecent = g_enterprise AND pjecld = g_pjec_m.pjecld 
                 AND pjec002 = g_pjec_m.pjec002 
                 AND pjec003 = g_pjec_m.pjec003 
 
                 AND pjecseq = g_pjec_d_t.pjecseq #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pjec_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "pjec_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pjec_m.pjecld
               LET gs_keys_bak[1] = g_pjecld_t
               LET gs_keys[2] = g_pjec_m.pjec002
               LET gs_keys_bak[2] = g_pjec002_t
               LET gs_keys[3] = g_pjec_m.pjec003
               LET gs_keys_bak[3] = g_pjec003_t
               LET gs_keys[4] = g_pjec_d[g_detail_idx].pjecseq
               LET gs_keys_bak[4] = g_pjec_d_t.pjecseq
               CALL apjq400_update_b('pjec_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_pjec_m),util.JSON.stringify(g_pjec_d_t)
                     LET g_log2 = util.JSON.stringify(g_pjec_m),util.JSON.stringify(g_pjec_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL apjq400_pjec_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_pjec_m.pjecld
               LET ls_keys[ls_keys.getLength()+1] = g_pjec_m.pjec002
               LET ls_keys[ls_keys.getLength()+1] = g_pjec_m.pjec003
 
               LET ls_keys[ls_keys.getLength()+1] = g_pjec_d_t.pjecseq
 
               CALL apjq400_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE apjq400_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pjec_d[l_ac].* = g_pjec_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE apjq400_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_pjec_d.getLength() = 0 THEN
               NEXT FIELD pjecseq
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_pjec_d[li_reproduce_target].* = g_pjec_d[li_reproduce].*
               LET g_pjec2_d[li_reproduce_target].* = g_pjec2_d[li_reproduce].*
 
               LET g_pjec_d[li_reproduce_target].pjecseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pjec_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pjec_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_pjec2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL apjq400_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL apjq400_idx_chk()
            CALL apjq400_ui_detailshow()
        
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
            NEXT FIELD pjecld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pjecseq
               WHEN "s_detail2"
                  NEXT FIELD pjecownid
 
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
 
{<section id="apjq400.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apjq400_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL apjq400_b_fill(g_wc2) #第一階單身填充
      CALL apjq400_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apjq400_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_pjec_m.pjeccomp,g_pjec_m.pjeccomp_desc,g_pjec_m.pjecld,g_pjec_m.pjecld_desc,g_pjec_m.pjec002, 
       g_pjec_m.pjec003,g_pjec_m.byear,g_pjec_m.bmonth,g_pjec_m.eyear,g_pjec_m.emonth
 
   CALL apjq400_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="apjq400.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION apjq400_ref_show()
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
   FOR l_ac = 1 TO g_pjec_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_pjec2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="apjq400.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apjq400_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE pjec_t.pjecld 
   DEFINE l_oldno     LIKE pjec_t.pjecld 
   DEFINE l_newno02     LIKE pjec_t.pjec002 
   DEFINE l_oldno02     LIKE pjec_t.pjec002 
   DEFINE l_newno03     LIKE pjec_t.pjec003 
   DEFINE l_oldno03     LIKE pjec_t.pjec003 
 
   DEFINE l_master    RECORD LIKE pjec_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pjec_t.* #此變數樣板目前無使用
 
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
 
   IF g_pjec_m.pjecld IS NULL
      OR g_pjec_m.pjec002 IS NULL
      OR g_pjec_m.pjec003 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_pjecld_t = g_pjec_m.pjecld
   LET g_pjec002_t = g_pjec_m.pjec002
   LET g_pjec003_t = g_pjec_m.pjec003
 
   
   LET g_pjec_m.pjecld = ""
   LET g_pjec_m.pjec002 = ""
   LET g_pjec_m.pjec003 = ""
 
   LET g_master_insert = FALSE
   CALL apjq400_set_entry('a')
   CALL apjq400_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_pjec_m.pjecld_desc = ''
   DISPLAY BY NAME g_pjec_m.pjecld_desc
 
   
   CALL apjq400_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_pjec_m.* TO NULL
      INITIALIZE g_pjec_d TO NULL
      INITIALIZE g_pjec2_d TO NULL
 
      CALL apjq400_show()
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
   CALL apjq400_set_act_visible()
   CALL apjq400_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pjecld_t = g_pjec_m.pjecld
   LET g_pjec002_t = g_pjec_m.pjec002
   LET g_pjec003_t = g_pjec_m.pjec003
 
   
   #組合新增資料的條件
   LET g_add_browse = " pjecent = " ||g_enterprise|| " AND",
                      " pjecld = '", g_pjec_m.pjecld, "' "
                      ," AND pjec002 = '", g_pjec_m.pjec002, "' "
                      ," AND pjec003 = '", g_pjec_m.pjec003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apjq400_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL apjq400_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL apjq400_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="apjq400.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apjq400_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pjec_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apjq400_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pjec_t
    WHERE pjecent = g_enterprise AND pjecld = g_pjecld_t
    AND pjec002 = g_pjec002_t
    AND pjec003 = g_pjec003_t
 
       INTO TEMP apjq400_detail
   
   #將key修正為調整後   
   UPDATE apjq400_detail 
      #更新key欄位
      SET pjecld = g_pjec_m.pjecld
          , pjec002 = g_pjec_m.pjec002
          , pjec003 = g_pjec_m.pjec003
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , pjecownid = g_user 
       , pjecowndp = g_dept
       , pjeccrtid = g_user
       , pjeccrtdp = g_dept 
       , pjeccrtdt = ld_date
       , pjecmodid = g_user
       , pjecmoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO pjec_t SELECT * FROM apjq400_detail
   
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
   DROP TABLE apjq400_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pjecld_t = g_pjec_m.pjecld
   LET g_pjec002_t = g_pjec_m.pjec002
   LET g_pjec003_t = g_pjec_m.pjec003
 
   
   DROP TABLE apjq400_detail
   
END FUNCTION
 
{</section>}
 
{<section id="apjq400.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apjq400_delete()
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
   
   IF g_pjec_m.pjecld IS NULL
   OR g_pjec_m.pjec002 IS NULL
   OR g_pjec_m.pjec003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN apjq400_cl USING g_enterprise,g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apjq400_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE apjq400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apjq400_master_referesh USING g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003 INTO g_pjec_m.pjeccomp, 
       g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003,g_pjec_m.pjeccomp_desc,g_pjec_m.pjecld_desc 
 
   
   #遮罩相關處理
   LET g_pjec_m_mask_o.* =  g_pjec_m.*
   CALL apjq400_pjec_t_mask()
   LET g_pjec_m_mask_n.* =  g_pjec_m.*
   
   CALL apjq400_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apjq400_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM pjec_t WHERE pjecent = g_enterprise AND pjecld = g_pjec_m.pjecld
                                                               AND pjec002 = g_pjec_m.pjec002
                                                               AND pjec003 = g_pjec_m.pjec003
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pjec_t:",SQLERRMESSAGE 
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
      #   CLOSE apjq400_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_pjec_d.clear() 
      CALL g_pjec2_d.clear()       
 
     
      CALL apjq400_ui_browser_refresh()  
      #CALL apjq400_ui_headershow()  
      #CALL apjq400_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL apjq400_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL apjq400_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE apjq400_cl
 
   #功能已完成,通報訊息中心
   CALL apjq400_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apjq400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apjq400_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_pjec004_t LIKE pjec_t.pjec004
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_pjec_d.clear()
   CALL g_pjec2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT pjecseq,pjec004,pjec005,pjec010,pjec011,pjec012,pjec013,pjec014,pjec015, 
       pjec016,pjec017,pjec018,pjec019,pjec020,pjec021,pjec022,pjec099,pjec200,pjec100,pjec110,pjec120, 
       pjec300,pjec310,pjec320,pjecownid,pjecowndp,pjeccrtid,pjeccrtdp,pjeccrtdt,pjecmodid,pjecmoddt, 
       pjecseq,t1.pjbal003 ,t2.pjbbl004 ,t3.ooefl003 ,t4.ooefl003 ,t5.pmaal004 ,t6.ooag011 ,t7.ooefl003 , 
       t8.ooag011 ,t9.ooefl003 ,t10.ooag011 FROM pjec_t",   
               "",
               
                              " LEFT JOIN pjbal_t t1 ON t1.pjbalent="||g_enterprise||" AND t1.pjbal001=pjec004 AND t1.pjbal002='"||g_dlang||"' ",
               " LEFT JOIN pjbbl_t t2 ON t2.pjbblent="||g_enterprise||" AND t2.pjbbl001=pjec004 AND t2.pjbbl002=pjec005 AND t2.pjbbl003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=pjec011 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=pjec012 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=pjec013 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=pjecownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=pjecowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=pjeccrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=pjeccrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=pjecmodid  ",
 
               " WHERE pjecent= ? AND pjecld=? AND pjec002=? AND pjec003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("pjec_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET l_pjec004_t = ''
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF apjq400_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY pjec_t.pjecseq"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
          LET g_sql = "SELECT  DISTINCT pjecseq,pjec004,pjec005,pjec010,pjec011,pjec012,pjec013,pjec014,pjec015, 
                      pjec016,pjec017,pjec018,pjec019,pjec020,pjec021,pjec022,pjec099,pjec200,pjec100,pjec110,pjec120, 
                      pjec300,pjec310,pjec320,pjecownid,pjecowndp,pjeccrtid,pjeccrtdp,pjeccrtdt,pjecmodid,pjecmoddt, 
                      pjecseq,t1.pjbal003 ,t2.pjbbl004 ,t3.ooefl003 ,t4.ooefl003 ,t5.pmaal004 ,t6.ooag011 ,t7.ooefl003 , 
                      t8.ooag011 ,t9.ooefl003 ,t10.ooag011 FROM pjec_t",   
                       "",
               
                              " LEFT JOIN pjbal_t t1 ON t1.pjbalent="||g_enterprise||" AND t1.pjbal001=pjec004 AND t1.pjbal002='"||g_dlang||"' ",
               " LEFT JOIN pjbbl_t t2 ON t2.pjbblent="||g_enterprise||" AND t2.pjbbl001=pjec004 AND t2.pjbbl002=pjec005 AND t2.pjbbl003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=pjec011 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=pjec012 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=pjec013 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=pjecownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=pjecowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=pjeccrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=pjeccrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=pjecmodid  ",
               " LEFT JOIN glaa_t ON glaaent = pjecent AND glaald = pjecld ",
               " LEFT JOIN glacl_t ON glaclent = pjecent AND glacl001 = glaa004 AND glacl002 = pjec010 AND glacl003 = '",g_dlang,"'",
               " WHERE pjecent= ? AND pjecld=? AND pjec002=? AND pjec003=?"  
 
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("pjec_t")
         END IF
         LET g_sql = g_sql," ORDER BY pjec_t.pjec004"
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apjq400_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apjq400_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pjec_m.pjecld,g_pjec_m.pjec002,g_pjec_m.pjec003 INTO g_pjec_d[l_ac].pjecseq, 
          g_pjec_d[l_ac].pjec004,g_pjec_d[l_ac].pjec005,g_pjec_d[l_ac].pjec010,g_pjec_d[l_ac].pjec011, 
          g_pjec_d[l_ac].pjec012,g_pjec_d[l_ac].pjec013,g_pjec_d[l_ac].pjec014,g_pjec_d[l_ac].pjec015, 
          g_pjec_d[l_ac].pjec016,g_pjec_d[l_ac].pjec017,g_pjec_d[l_ac].pjec018,g_pjec_d[l_ac].pjec019, 
          g_pjec_d[l_ac].pjec020,g_pjec_d[l_ac].pjec021,g_pjec_d[l_ac].pjec022,g_pjec_d[l_ac].pjec099, 
          g_pjec_d[l_ac].pjec200,g_pjec_d[l_ac].pjec100,g_pjec_d[l_ac].pjec110,g_pjec_d[l_ac].pjec120, 
          g_pjec_d[l_ac].pjec300,g_pjec_d[l_ac].pjec310,g_pjec_d[l_ac].pjec320,g_pjec2_d[l_ac].pjecownid, 
          g_pjec2_d[l_ac].pjecowndp,g_pjec2_d[l_ac].pjeccrtid,g_pjec2_d[l_ac].pjeccrtdp,g_pjec2_d[l_ac].pjeccrtdt, 
          g_pjec2_d[l_ac].pjecmodid,g_pjec2_d[l_ac].pjecmoddt,g_pjec2_d[l_ac].pjecseq,g_pjec_d[l_ac].pjec004_desc, 
          g_pjec_d[l_ac].pjec005_desc,g_pjec_d[l_ac].pjec011_desc,g_pjec_d[l_ac].pjec012_desc,g_pjec_d[l_ac].pjec013_desc, 
          g_pjec2_d[l_ac].pjecownid_desc,g_pjec2_d[l_ac].pjecowndp_desc,g_pjec2_d[l_ac].pjeccrtid_desc, 
          g_pjec2_d[l_ac].pjeccrtdp_desc,g_pjec2_d[l_ac].pjecmodid_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         SELECT glacl004 INTO g_pjec_d[l_ac].pjec010_desc
           FROM glaa_t LEFT JOIN glacl_t ON glaclent = g_enterprise
            AND glacl001 = glaa004 AND glacl002 = g_pjec_d[l_ac].pjec010 
            AND glacl003 = g_dlang
          WHERE glaaent = g_enterprise AND glaald = g_pjec_m.pjecld 
         #end add-point
      
         #帶出公用欄位reference值
         
         
         #應用 a12 樣板自動產生(Version:4)
 
 
 
 
        
         #add-point:單身資料抓取 name="bfill.foreach"
         LET g_pjec_d_o.* = g_pjec_d[l_ac].*
         IF NOT cl_null(l_pjec004_t) AND l_pjec004_t != g_pjec_d[l_ac].pjec004 THEN
            INITIALIZE g_pjec_d[l_ac].* TO NULL
            SELECT SUM(pjec099),SUM(pjec100),SUM(pjec110),SUM(pjec120)
              INTO g_pjec_d[l_ac].pjec099,g_pjec_d[l_ac].pjec100,g_pjec_d[l_ac].pjec110,g_pjec_d[l_ac].pjec120
              FROM pjec_t
             WHERE pjecent = g_enterprise AND pjecld = g_pjec_m.pjecld
               AND pjec002 = g_pjec_m.pjec002 AND pjec003 = g_pjec_m.pjec003
               AND pjec004 = l_pjec004_t
              GROUP BY pjec004
           LET g_pjec_d[l_ac].pjec010 =cl_getmsg('aap-00287',g_dlang)
           LET l_ac = l_ac + 1
           LET g_pjec_d[l_ac].* = g_pjec_d_o.*        
         END IF
         LET l_pjec004_t = g_pjec_d[l_ac].pjec004

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
 
            CALL g_pjec_d.deleteElement(g_pjec_d.getLength())
      CALL g_pjec2_d.deleteElement(g_pjec2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
    INITIALIZE g_pjec_d[l_ac].* TO NULL
    SELECT SUM(pjec099),SUM(pjec100),SUM(pjec110),SUM(pjec120)
      INTO g_pjec_d[l_ac].pjec099,g_pjec_d[l_ac].pjec100,g_pjec_d[l_ac].pjec110,g_pjec_d[l_ac].pjec120
      FROM pjec_t
     WHERE pjecent = g_enterprise AND pjecld = g_pjec_m.pjecld
       AND pjec002 = g_pjec_m.pjec002 AND pjec003 = g_pjec_m.pjec003
       AND pjec004 = l_pjec004_t
      GROUP BY pjec004
    LET g_pjec_d[l_ac].pjec010 =cl_getmsg('aap-00287',g_dlang)
    
    LET l_ac = l_ac + 1
    INITIALIZE g_pjec_d[l_ac].* TO NULL
    SELECT SUM(pjec099),SUM(pjec100),SUM(pjec110),SUM(pjec120)
      INTO g_pjec_d[l_ac].pjec099,g_pjec_d[l_ac].pjec100,g_pjec_d[l_ac].pjec110,g_pjec_d[l_ac].pjec120
      FROM pjec_t
     WHERE pjecent = g_enterprise AND pjecld = g_pjec_m.pjecld
       AND pjec002 = g_pjec_m.pjec002 AND pjec003 = g_pjec_m.pjec003
    LET g_pjec_d[l_ac].pjec010 =cl_getmsg('axc-00204',g_dlang)
    
    LET l_ac = l_ac + 1
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_pjec_d.getLength()
      LET g_pjec_d_mask_o[l_ac].* =  g_pjec_d[l_ac].*
      CALL apjq400_pjec_t_mask()
      LET g_pjec_d_mask_n[l_ac].* =  g_pjec_d[l_ac].*
   END FOR
   
   LET g_pjec2_d_mask_o.* =  g_pjec2_d.*
   FOR l_ac = 1 TO g_pjec2_d.getLength()
      LET g_pjec2_d_mask_o[l_ac].* =  g_pjec2_d[l_ac].*
      CALL apjq400_pjec_t_mask()
      LET g_pjec2_d_mask_n[l_ac].* =  g_pjec2_d[l_ac].*
   END FOR
 
 
   FREE apjq400_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="apjq400.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apjq400_idx_chk()
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
      IF g_detail_idx > g_pjec_d.getLength() THEN
         LET g_detail_idx = g_pjec_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_pjec_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pjec_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_pjec2_d.getLength() THEN
         LET g_detail_idx = g_pjec2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pjec2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pjec2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apjq400.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apjq400_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_pjec_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apjq400.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION apjq400_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM pjec_t
    WHERE pjecent = g_enterprise AND pjecld = g_pjec_m.pjecld AND
                              pjec002 = g_pjec_m.pjec002 AND
                              pjec003 = g_pjec_m.pjec003 AND
 
          pjecseq = g_pjec_d_t.pjecseq
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "pjec_t:",SQLERRMESSAGE 
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
 
{<section id="apjq400.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apjq400_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="apjq400.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apjq400_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="apjq400.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apjq400_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="apjq400.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION apjq400_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_pjec_d[l_ac].pjecseq = g_pjec_d_t.pjecseq 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="apjq400.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apjq400_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apjq400.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apjq400_lock_b(ps_table,ps_page)
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
   #CALL apjq400_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apjq400.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apjq400_unlock_b(ps_table,ps_page)
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
 
{<section id="apjq400.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apjq400_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pjecld,pjec002,pjec003",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
    CALL cl_set_comp_visible("pjec002,pjec003,byear,bmonth,eyear,emonth",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apjq400.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apjq400_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pjecld,pjec002,pjec003",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF cl_null(g_wc) THEN
      CALL cl_set_comp_visible("pjec002,pjec003",FALSE)
   ELSE
      CALL cl_set_comp_visible("byear,eyear,bmonth,emonth",FALSE)
   END IF 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apjq400.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apjq400_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apjq400.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apjq400_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="apjq400.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apjq400_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("sub_query",TRUE)
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apjq400.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apjq400_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF cl_null(g_pjec_m.pjecld) OR cl_null(g_pjec_m.pjec002) OR cl_null(g_pjec_m.pjec003) THEN
      CALL cl_set_act_visible("sub_query",FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apjq400.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apjq400_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apjq400.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apjq400_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apjq400.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apjq400_default_search()
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
      LET ls_wc = ls_wc, " pjecld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " pjec002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " pjec003 = '", g_argv[03], "' AND "
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
 
{<section id="apjq400.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apjq400_fill_chk(ps_idx)
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
 
{<section id="apjq400.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION apjq400_modify_detail_chk(ps_record)
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
         LET ls_return = "pjecseq"
      WHEN "s_detail2"
         LET ls_return = "pjecownid"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="apjq400.mask_functions" >}
&include "erp/apj/apjq400_mask.4gl"
 
{</section>}
 
{<section id="apjq400.state_change" >}
    
 
{</section>}
 
{<section id="apjq400.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apjq400_set_pk_array()
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
   LET g_pk_array[1].values = g_pjec_m.pjecld
   LET g_pk_array[1].column = 'pjecld'
   LET g_pk_array[2].values = g_pjec_m.pjec002
   LET g_pk_array[2].column = 'pjec002'
   LET g_pk_array[3].values = g_pjec_m.pjec003
   LET g_pk_array[3].column = 'pjec003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apjq400.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apjq400_msgcentre_notify(lc_state)
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
   CALL apjq400_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pjec_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apjq400.other_function" readonly="Y" >}
#开启子画面
PRIVATE FUNCTION apjq400_open_s01()
DEFINE lwin_curr        ui.Window
DEFINE lfrm_curr        ui.Form
DEFINE ls_path          STRING

   OPEN WINDOW w_apjq400_s01 WITH FORM cl_ap_formpath("apj","apjq400_s01")
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_i.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
    
   DISPLAY BY NAME g_pjec_m.pjeccomp,g_pjec_m.pjeccomp_desc,g_pjec_m.pjecld, 
                   g_pjec_m.pjecld_desc,g_pjec_m.pjec002,g_pjec_m.pjec003 
   CALL apjq400_apjq400_s01_b_fill()
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      DISPLAY ARRAY g_detail_d TO s_detail3.* #ATTRIBUTES(COUNT=g_rec_b)
          BEFORE DISPLAY
             DISPLAY g_detail_d.getLength() TO FORMONLY.cnt
          BEFORE ROW
             LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
             LET l_ac = g_detail_idx
             DISPLAY g_detail_idx TO FORMONLY.idx
             CALL apjq400_apjq400_s01_b_fill2(g_detail_d[l_ac].pjec010)
      END DISPLAY
      
      DISPLAY ARRAY g_detail2_d TO s_detail4.* #ATTRIBUTES(COUNT=g_rec_b)
         BEFORE DISPLAY 
            DISPLAY g_detail2_d.getLength() TO FORMONLY.cnt 
         BEFORE ROW
             LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
             DISPLAY g_detail_idx TO FORMONLY.idx
             
      END DISPLAY
      ON ACTION accept
        ACCEPT DIALOG
      
      ON ACTION cancel
         EXIT DIALOG
       
      ON ACTION close
         EXIT DIALOG
       
      ON ACTION exit
         EXIT DIALOG
     
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   CLOSE WINDOW w_apjq400_s01
END FUNCTION
#填充子画面第一单身
PRIVATE FUNCTION apjq400_apjq400_s01_b_fill()
DEFINE l_sql  STRING
DEFINE l_cnt LIKE type_t.num5
   LET l_sql ="SELECT DISTINCT pjeb010,glacl004,pjeb011,t1.ooefl003,pjeb012,t2.ooefl003,pjeb013,pmaal004,pjeb014,pjeb015,pjeb016,",
               "       pjeb017,pjeb018,pjeb019,pjeb020,pjeb021,pjeb022,SUM(pjeb100),SUM(pjeb110),SUM(pjeb120)",
#               "       pjeb017,pjeb018,pjeb019,pjeb020,pjeb021,pjeb022,pjeb100,pjeb110,pjeb120",
               "  FROM pjeb_t LEFT JOIN ooefl_t t1 ON t1.ooeflent = pjebent AND t1.ooefl001 = pjeb011 AND t1.ooefl002 = '",g_dlang,"'",
               "              LEFT JOIN ooefl_t t2 ON t2.ooeflent = pjebent AND t2.ooefl001 = pjeb012 AND t2.ooefl002 = '",g_dlang,"'",
               "              LEFT JOIN pmaal_t ON pmaalent = pjebent AND pmaal001 = pjeb013 AND pmaal002 = '",g_dlang,"'",
               "              LEFT JOIN glaa_t ON glaaent = pjebent AND glaald = pjebld ",
               "              LEFT JOIN glacl_t ON glaclent = pjebent AND glacl001 = glaa004 AND glacl002 = pjeb010 AND glacl003 = '",g_dlang,"'",
               " WHERE pjebent = ",g_enterprise," AND pjebld = '",g_pjec_m.pjecld,"'", 
               "   AND pjeb002 = ",g_pjec_m.pjec002," AND pjeb003 = ",g_pjec_m.pjec003,
               " GROUP BY pjeb010,glacl004,pjeb011,t1.ooefl003,pjeb012,t2.ooefl003,pjeb013,pmaal004,pjeb014,pjeb015,pjeb016,",
               "       pjeb017,pjeb018,pjeb019,pjeb020,pjeb021,pjeb022"
   PREPARE apjq400_s01_prep1 FROM l_sql
   DECLARE apjq400_s01_curs1 CURSOR FOR apjq400_s01_prep1
   CALL g_detail_d.clear()
   LET l_cnt = 1
   FOREACH apjq400_s01_curs1 INTO g_detail_d[l_cnt].*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
      IF l_cnt > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_cnt
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF 
         EXIT FOREACH
      END IF
      
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
END FUNCTION
#填充子画面第二单身
PRIVATE FUNCTION apjq400_apjq400_s01_b_fill2(p_pjec010)
DEFINE l_sql  STRING
DEFINE l_cnt LIKE type_t.num5
DEFINE p_pjec010  LIKE pjec_t.pjec010
   LET l_sql = "SELECT pjec004,pjbal003,pjec005,pjbbl004,pjec099,pjec200,pjec100,pjec110,pjec120,pjec300,pjec310,pjec320",
               "  FROM pjec_t LEFT JOIN pjbal_t ON pjecent = pjbalent AND pjec004 = pjbal001 AND pjbal002 = '",g_dlang,"'",
               "              LEFT JOIN pjbbl_t ON pjecent = pjbblent AND pjec004 = pjbbl001 AND pjbbl002 = pjec005 AND pjbbl003 = '",g_dlang,"'",
               " WHERE pjecent = ",g_enterprise," AND pjecld = '",g_pjec_m.pjecld,"'", 
               "   AND pjec002 = ",g_pjec_m.pjec002," AND pjec003 = ",g_pjec_m.pjec003,
               "   AND pjec010 = '",p_pjec010,"'"
   PREPARE apjq400_s01_prep2 FROM l_sql
   DECLARE apjq400_s01_curs2 CURSOR FOR apjq400_s01_prep2
   CALL g_detail2_d.clear()
   LET l_cnt = 1
   FOREACH apjq400_s01_curs2 INTO g_detail2_d[l_cnt].*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
      IF l_cnt > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_cnt
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF 
         EXIT FOREACH
      END IF
      
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength()) 
END FUNCTION

 
{</section>}
 
