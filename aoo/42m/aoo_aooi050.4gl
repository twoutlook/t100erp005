#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi050.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-06-30 16:11:25), PR版次:0004(2016-03-25 16:37:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000337
#+ Filename...: aooi050
#+ Description: 行政地區資料維護作業
#+ Creator....: 02587(2013-07-01 00:00:00)
#+ Modifier...: 01534 -SD/PR- 07900
 
{</section>}
 
{<section id="aooi050.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#30 2016/03/24 By 07900    重复错误信息修改
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
PRIVATE type type_g_oocm_m        RECORD
       oocm001 LIKE oocm_t.oocm001, 
   oocm001_desc LIKE type_t.chr80, 
   oocm002 LIKE oocm_t.oocm002, 
   oocm002_desc LIKE type_t.chr80, 
   oocm003 LIKE oocm_t.oocm003, 
   oocm003_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_oocm_d        RECORD
       oocmstus LIKE oocm_t.oocmstus, 
   oocm004 LIKE oocm_t.oocm004, 
   oocml006 LIKE oocml_t.oocml006, 
   oocml007 LIKE oocml_t.oocml007
       END RECORD
PRIVATE TYPE type_g_oocm1_info_d RECORD
       oocm004 LIKE oocm_t.oocm004, 
   oocmmodid LIKE oocm_t.oocmmodid, 
   oocmmodid_desc LIKE type_t.chr500, 
   oocmmoddt DATETIME YEAR TO SECOND, 
   oocmownid LIKE oocm_t.oocmownid, 
   oocmownid_desc LIKE type_t.chr500, 
   oocmowndp LIKE oocm_t.oocmowndp, 
   oocmowndp_desc LIKE type_t.chr500, 
   oocmcrtid LIKE oocm_t.oocmcrtid, 
   oocmcrtid_desc LIKE type_t.chr500, 
   oocmcrtdp LIKE oocm_t.oocmcrtdp, 
   oocmcrtdp_desc LIKE type_t.chr500, 
   oocmcrtdt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_detail_multi_table_t    RECORD
      oocml001 LIKE oocml_t.oocml001,
      oocml002 LIKE oocml_t.oocml002,
      oocml003 LIKE oocml_t.oocml003,
      oocml004 LIKE oocml_t.oocml004,
      oocml005 LIKE oocml_t.oocml005,
      oocml006 LIKE oocml_t.oocml006,
      oocml007 LIKE oocml_t.oocml007
      END RECORD
 
#模組變數(Module Variables)
DEFINE g_oocm_m          type_g_oocm_m
DEFINE g_oocm_m_t        type_g_oocm_m
DEFINE g_oocm_m_o        type_g_oocm_m
DEFINE g_oocm_m_mask_o   type_g_oocm_m #轉換遮罩前資料
DEFINE g_oocm_m_mask_n   type_g_oocm_m #轉換遮罩後資料
 
   DEFINE g_oocm001_t LIKE oocm_t.oocm001
DEFINE g_oocm002_t LIKE oocm_t.oocm002
DEFINE g_oocm003_t LIKE oocm_t.oocm003
 
 
DEFINE g_oocm_d          DYNAMIC ARRAY OF type_g_oocm_d
DEFINE g_oocm_d_t        type_g_oocm_d
DEFINE g_oocm_d_o        type_g_oocm_d
DEFINE g_oocm_d_mask_o   DYNAMIC ARRAY OF type_g_oocm_d #轉換遮罩前資料
DEFINE g_oocm_d_mask_n   DYNAMIC ARRAY OF type_g_oocm_d #轉換遮罩後資料
DEFINE g_oocm1_info_d   DYNAMIC ARRAY OF type_g_oocm1_info_d
DEFINE g_oocm1_info_d_t type_g_oocm1_info_d
DEFINE g_oocm1_info_d_o type_g_oocm1_info_d
DEFINE g_oocm1_info_d_mask_o   DYNAMIC ARRAY OF type_g_oocm1_info_d #轉換遮罩前資料
DEFINE g_oocm1_info_d_mask_n   DYNAMIC ARRAY OF type_g_oocm1_info_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_oocm001 LIKE oocm_t.oocm001,
      b_oocm002 LIKE oocm_t.oocm002,
      b_oocm003 LIKE oocm_t.oocm003
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
 
{<section id="aooi050.main" >}
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
   CALL cl_ap_init("aoo","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT oocm001,'',oocm002,'',oocm003,''", 
                      " FROM oocm_t",
                      " WHERE oocment= ? AND oocm001=? AND oocm002=? AND oocm003=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi050_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.oocm001,t0.oocm002,t0.oocm003,t1.oocgl003 ,t2.oocil004 ,t3.oockl005", 
 
               " FROM oocm_t t0",
                              " LEFT JOIN oocgl_t t1 ON t1.oocglent="||g_enterprise||" AND t1.oocgl001=t0.oocm001 AND t1.oocgl002='"||g_dlang||"' ",
               " LEFT JOIN oocil_t t2 ON t2.oocilent="||g_enterprise||" AND t2.oocil001=t0.oocm001 AND t2.oocil002=t0.oocm002 AND t2.oocil003='"||g_dlang||"' ",
               " LEFT JOIN oockl_t t3 ON t3.oocklent="||g_enterprise||" AND t3.oockl001=t0.oocm001 AND t3.oockl002=t0.oocm002 AND t3.oockl003=t0.oocm003 AND t3.oockl004='"||g_dlang||"' ",
 
               " WHERE t0.oocment = " ||g_enterprise|| " AND t0.oocm001 = ? AND t0.oocm002 = ? AND t0.oocm003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aooi050_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooi050 WITH FORM cl_ap_formpath("aoo",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aooi050_init()   
 
      #進入選單 Menu (="N")
      CALL aooi050_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aooi050
      
   END IF 
   
   CLOSE aooi050_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aooi050.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aooi050_init()
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
   
   CALL aooi050_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aooi050.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aooi050_ui_dialog()
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
         INITIALIZE g_oocm_m.* TO NULL
         CALL g_oocm_d.clear()
         CALL g_oocm1_info_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aooi050_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_oocm_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL aooi050_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aooi050_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_oocm1_info_d TO s_detail1_info.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1_info")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aooi050_idx_chk()
               CALL aooi050_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body1_info.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 2
            
            
         
            #add-point:page2自定義行為 name="ui_dialog.body1_info.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL aooi050_browser_fill("")
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
               CALL aooi050_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aooi050_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aooi050_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi050_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aooi050_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi050_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aooi050_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi050_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aooi050_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi050_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aooi050_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi050_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_oocm_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_oocm1_info_d)
                  LET g_export_id[2]   = "s_detail1_info"
 
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
               NEXT FIELD oocm004
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
               CALL aooi050_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aooi050_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL aooi050_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aooi050_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aooi050_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aooi050_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi050_insert()
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
               CALL aooi050_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aooi050_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail1_info",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aooi050_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi050_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi050_set_pk_array()
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
 
{<section id="aooi050.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION aooi050_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aooi050.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aooi050_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "oocm001,oocm002,oocm003"
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
      LET l_sub_sql = " SELECT DISTINCT oocm001 ",
                      ", oocm002 ",
                      ", oocm003 ",
 
                      " FROM oocm_t ",
                      " ",
                      " LEFT JOIN oocml_t ON oocmlent = "||g_enterprise||" AND oocm001 = oocml001 AND oocm002 = oocml002 AND oocm003 = oocml003 AND oocm004 = oocml004 AND oocml005 = '",g_dlang,"' ", 
 
 
 
                      " WHERE oocment = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("oocm_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT oocm001 ",
                      ", oocm002 ",
                      ", oocm003 ",
 
                      " FROM oocm_t ",
                      " ",
                      " LEFT JOIN oocml_t ON oocmlent = "||g_enterprise||" AND oocm001 = oocml001 AND oocm002 = oocml002 AND oocm003 = oocml003 AND oocm004 = oocml004 AND oocml005 = '",g_dlang,"' ", 
 
 
                      " WHERE oocment = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("oocm_t")
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
      INITIALIZE g_oocm_m.* TO NULL
      CALL g_oocm_d.clear()        
      CALL g_oocm1_info_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.oocm001,t0.oocm002,t0.oocm003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.oocm001,t0.oocm002,t0.oocm003",
                " FROM oocm_t t0",
                #" ",
                " LEFT JOIN oocml_t ON oocmlent = "||g_enterprise||" AND oocm001 = oocml001 AND oocm002 = oocml002 AND oocm003 = oocml003 AND oocm004 = oocml004 AND oocml005 = '",g_dlang,"' ",
 
 
 
                
                " WHERE t0.oocment = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("oocm_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"oocm_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_oocm001,g_browser[g_cnt].b_oocm002,g_browser[g_cnt].b_oocm003  
 
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
   
   IF cl_null(g_browser[g_cnt].b_oocm001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_oocm_m.* TO NULL
      CALL g_oocm_d.clear()
      CALL g_oocm1_info_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL aooi050_fetch('')
   
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
 
{<section id="aooi050.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aooi050_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_oocm_m.oocm001 = g_browser[g_current_idx].b_oocm001   
   LET g_oocm_m.oocm002 = g_browser[g_current_idx].b_oocm002   
   LET g_oocm_m.oocm003 = g_browser[g_current_idx].b_oocm003   
 
   EXECUTE aooi050_master_referesh USING g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003 INTO g_oocm_m.oocm001, 
       g_oocm_m.oocm002,g_oocm_m.oocm003,g_oocm_m.oocm001_desc,g_oocm_m.oocm002_desc,g_oocm_m.oocm003_desc 
 
   CALL aooi050_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aooi050_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail1_info",g_detail_idx)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aooi050_ui_browser_refresh()
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
      IF g_browser[l_i].b_oocm001 = g_oocm_m.oocm001 
         AND g_browser[l_i].b_oocm002 = g_oocm_m.oocm002 
         AND g_browser[l_i].b_oocm003 = g_oocm_m.oocm003 
 
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
 
{<section id="aooi050.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aooi050_construct()
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
   INITIALIZE g_oocm_m.* TO NULL
   CALL g_oocm_d.clear()
   CALL g_oocm1_info_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON oocm001,oocm002,oocm003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.oocm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocm001
            #add-point:ON ACTION controlp INFIELD oocm001 name="construct.c.oocm001"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            CALL q_oocg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocm001  #顯示到畫面上

            NEXT FIELD oocm001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocm001
            #add-point:BEFORE FIELD oocm001 name="construct.b.oocm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocm001
            
            #add-point:AFTER FIELD oocm001 name="construct.a.oocm001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocm002
            #add-point:ON ACTION controlp INFIELD oocm002 name="construct.c.oocm002"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            CALL q_ooci002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocm002  #顯示到畫面上

            NEXT FIELD oocm002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocm002
            #add-point:BEFORE FIELD oocm002 name="construct.b.oocm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocm002
            
            #add-point:AFTER FIELD oocm002 name="construct.a.oocm002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocm003
            #add-point:ON ACTION controlp INFIELD oocm003 name="construct.c.oocm003"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            CALL q_oock003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocm003  #顯示到畫面上

            NEXT FIELD oocm003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocm003
            #add-point:BEFORE FIELD oocm003 name="construct.b.oocm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocm003
            
            #add-point:AFTER FIELD oocm003 name="construct.a.oocm003"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON oocm004,oocml006,oocml007,oocmmodid,oocmmoddt,oocmownid,oocmowndp,oocmcrtid, 
          oocmcrtdp,oocmcrtdt
           FROM s_detail1[1].oocm004,s_detail1[1].oocml006,s_detail1[1].oocml007,s_detail1_info[1].oocmmodid, 
               s_detail1_info[1].oocmmoddt,s_detail1_info[1].oocmownid,s_detail1_info[1].oocmowndp,s_detail1_info[1].oocmcrtid, 
               s_detail1_info[1].oocmcrtdp,s_detail1_info[1].oocmcrtdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<oocmcrtdt>>----
         AFTER FIELD oocmcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<oocmmoddt>>----
         AFTER FIELD oocmmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<oocmcnfdt>>----
         
         #----<<oocmpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #Ctrlp:construct.c.page1.oocm004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocm004
            #add-point:ON ACTION controlp INFIELD oocm004 name="construct.c.page1.oocm004"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_oocm004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocm004  #顯示到畫面上

            NEXT FIELD oocm004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocm004
            #add-point:BEFORE FIELD oocm004 name="construct.b.page1.oocm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocm004
            
            #add-point:AFTER FIELD oocm004 name="construct.a.page1.oocm004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocml006
            #add-point:BEFORE FIELD oocml006 name="construct.b.page1.oocml006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocml006
            
            #add-point:AFTER FIELD oocml006 name="construct.a.page1.oocml006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.oocml006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocml006
            #add-point:ON ACTION controlp INFIELD oocml006 name="construct.c.page1.oocml006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocml007
            #add-point:BEFORE FIELD oocml007 name="construct.b.page1.oocml007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocml007
            
            #add-point:AFTER FIELD oocml007 name="construct.a.page1.oocml007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.oocml007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocml007
            #add-point:ON ACTION controlp INFIELD oocml007 name="construct.c.page1.oocml007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1_info.oocmmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocmmodid
            #add-point:ON ACTION controlp INFIELD oocmmodid name="construct.c.page1_info.oocmmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocmmodid  #顯示到畫面上

            NEXT FIELD oocmmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocmmodid
            #add-point:BEFORE FIELD oocmmodid name="construct.b.page1_info.oocmmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocmmodid
            
            #add-point:AFTER FIELD oocmmodid name="construct.a.page1_info.oocmmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocmmoddt
            #add-point:BEFORE FIELD oocmmoddt name="construct.b.page1_info.oocmmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1_info.oocmownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocmownid
            #add-point:ON ACTION controlp INFIELD oocmownid name="construct.c.page1_info.oocmownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocmownid  #顯示到畫面上

            NEXT FIELD oocmownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocmownid
            #add-point:BEFORE FIELD oocmownid name="construct.b.page1_info.oocmownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocmownid
            
            #add-point:AFTER FIELD oocmownid name="construct.a.page1_info.oocmownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1_info.oocmowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocmowndp
            #add-point:ON ACTION controlp INFIELD oocmowndp name="construct.c.page1_info.oocmowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocmowndp  #顯示到畫面上

            NEXT FIELD oocmowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocmowndp
            #add-point:BEFORE FIELD oocmowndp name="construct.b.page1_info.oocmowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocmowndp
            
            #add-point:AFTER FIELD oocmowndp name="construct.a.page1_info.oocmowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1_info.oocmcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocmcrtid
            #add-point:ON ACTION controlp INFIELD oocmcrtid name="construct.c.page1_info.oocmcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocmcrtid  #顯示到畫面上

            NEXT FIELD oocmcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocmcrtid
            #add-point:BEFORE FIELD oocmcrtid name="construct.b.page1_info.oocmcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocmcrtid
            
            #add-point:AFTER FIELD oocmcrtid name="construct.a.page1_info.oocmcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1_info.oocmcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocmcrtdp
            #add-point:ON ACTION controlp INFIELD oocmcrtdp name="construct.c.page1_info.oocmcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocmcrtdp  #顯示到畫面上

            NEXT FIELD oocmcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocmcrtdp
            #add-point:BEFORE FIELD oocmcrtdp name="construct.b.page1_info.oocmcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocmcrtdp
            
            #add-point:AFTER FIELD oocmcrtdp name="construct.a.page1_info.oocmcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocmcrtdt
            #add-point:BEFORE FIELD oocmcrtdt name="construct.b.page1_info.oocmcrtdt"
            
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
 
{<section id="aooi050.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aooi050_query()
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
   CALL g_oocm_d.clear()
   CALL g_oocm1_info_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aooi050_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aooi050_browser_fill(g_wc)
      CALL aooi050_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL aooi050_browser_fill("F")
   
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
      CALL aooi050_fetch("F") 
   END IF
   
   CALL aooi050_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aooi050_fetch(p_flag)
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
   
   #CALL aooi050_browser_fill(p_flag)
   
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
   
   LET g_oocm_m.oocm001 = g_browser[g_current_idx].b_oocm001
   LET g_oocm_m.oocm002 = g_browser[g_current_idx].b_oocm002
   LET g_oocm_m.oocm003 = g_browser[g_current_idx].b_oocm003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aooi050_master_referesh USING g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003 INTO g_oocm_m.oocm001, 
       g_oocm_m.oocm002,g_oocm_m.oocm003,g_oocm_m.oocm001_desc,g_oocm_m.oocm002_desc,g_oocm_m.oocm003_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "oocm_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_oocm_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_oocm_m_mask_o.* =  g_oocm_m.*
   CALL aooi050_oocm_t_mask()
   LET g_oocm_m_mask_n.* =  g_oocm_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aooi050_set_act_visible()
   CALL aooi050_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_oocm_m_t.* = g_oocm_m.*
   LET g_oocm_m_o.* = g_oocm_m.*
   
   #重新顯示   
   CALL aooi050_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aooi050.insert" >}
#+ 資料新增
PRIVATE FUNCTION aooi050_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_oocm_d.clear()
   CALL g_oocm1_info_d.clear()
 
 
   INITIALIZE g_oocm_m.* TO NULL             #DEFAULT 設定
   LET g_oocm001_t = NULL
   LET g_oocm002_t = NULL
   LET g_oocm003_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      LET g_oocm_m_t.oocm001_desc = NULL
      LET g_oocm_m_t.oocm002_desc = NULL
      LET g_oocm_m_t.oocm003_desc = NULL
      IF cl_null(g_oocm_m.oocm003)THEN
         LET g_oocm_m.oocm003 = ' '
      END IF   
      #end add-point 
 
      CALL aooi050_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_oocm_m.* TO NULL
         INITIALIZE g_oocm_d TO NULL
         INITIALIZE g_oocm1_info_d TO NULL
 
         CALL aooi050_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_oocm_m.* = g_oocm_m_t.*
         CALL aooi050_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_oocm_d.clear()
      #CALL g_oocm1_info_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aooi050_set_act_visible()
   CALL aooi050_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_oocm001_t = g_oocm_m.oocm001
   LET g_oocm002_t = g_oocm_m.oocm002
   LET g_oocm003_t = g_oocm_m.oocm003
 
   
   #組合新增資料的條件
   LET g_add_browse = " oocment = " ||g_enterprise|| " AND",
                      " oocm001 = '", g_oocm_m.oocm001, "' "
                      ," AND oocm002 = '", g_oocm_m.oocm002, "' "
                      ," AND oocm003 = '", g_oocm_m.oocm003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aooi050_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL aooi050_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aooi050_master_referesh USING g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003 INTO g_oocm_m.oocm001, 
       g_oocm_m.oocm002,g_oocm_m.oocm003,g_oocm_m.oocm001_desc,g_oocm_m.oocm002_desc,g_oocm_m.oocm003_desc 
 
   
   #遮罩相關處理
   LET g_oocm_m_mask_o.* =  g_oocm_m.*
   CALL aooi050_oocm_t_mask()
   LET g_oocm_m_mask_n.* =  g_oocm_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_oocm_m.oocm001,g_oocm_m.oocm001_desc,g_oocm_m.oocm002,g_oocm_m.oocm002_desc,g_oocm_m.oocm003, 
       g_oocm_m.oocm003_desc
   
   #功能已完成,通報訊息中心
   CALL aooi050_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.modify" >}
#+ 資料修改
PRIVATE FUNCTION aooi050_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_oocm_m.oocm001 IS NULL
   OR g_oocm_m.oocm002 IS NULL
   OR g_oocm_m.oocm003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_oocm001_t = g_oocm_m.oocm001
   LET g_oocm002_t = g_oocm_m.oocm002
   LET g_oocm003_t = g_oocm_m.oocm003
 
   CALL s_transaction_begin()
   
   OPEN aooi050_cl USING g_enterprise,g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi050_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aooi050_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aooi050_master_referesh USING g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003 INTO g_oocm_m.oocm001, 
       g_oocm_m.oocm002,g_oocm_m.oocm003,g_oocm_m.oocm001_desc,g_oocm_m.oocm002_desc,g_oocm_m.oocm003_desc 
 
   
   #遮罩相關處理
   LET g_oocm_m_mask_o.* =  g_oocm_m.*
   CALL aooi050_oocm_t_mask()
   LET g_oocm_m_mask_n.* =  g_oocm_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL aooi050_show()
   WHILE TRUE
      LET g_oocm001_t = g_oocm_m.oocm001
      LET g_oocm002_t = g_oocm_m.oocm002
      LET g_oocm003_t = g_oocm_m.oocm003
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL aooi050_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_oocm_m.* = g_oocm_m_t.*
         CALL aooi050_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_oocm_m.oocm001 != g_oocm001_t 
      OR g_oocm_m.oocm002 != g_oocm002_t 
      OR g_oocm_m.oocm003 != g_oocm003_t 
 
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
   CALL aooi050_set_act_visible()
   CALL aooi050_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " oocment = " ||g_enterprise|| " AND",
                      " oocm001 = '", g_oocm_m.oocm001, "' "
                      ," AND oocm002 = '", g_oocm_m.oocm002, "' "
                      ," AND oocm003 = '", g_oocm_m.oocm003, "' "
 
   #填到對應位置
   CALL aooi050_browser_fill("")
 
   CALL aooi050_idx_chk()
 
   CLOSE aooi050_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aooi050_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="aooi050.input" >}
#+ 資料輸入
PRIVATE FUNCTION aooi050_input(p_cmd)
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
   DEFINE l_oocg001        LIKE oocg_t.oocg001
   DEFINE l_oocgstus       LIKE oocg_t.oocgstus
   DEFINE l_ooci002        LIKE ooci_t.ooci002  
   DEFINE l_oocistus       LIKE ooci_t.oocistus
   DEFINE l_oock003        LIKE oock_t.oock003 
   DEFINE l_oockstus       LIKE oock_t.oockstus
   DEFINE l_sql            STRING
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
   DISPLAY BY NAME g_oocm_m.oocm001,g_oocm_m.oocm001_desc,g_oocm_m.oocm002,g_oocm_m.oocm002_desc,g_oocm_m.oocm003, 
       g_oocm_m.oocm003_desc
   
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
   LET g_forupd_sql = "SELECT oocmstus,oocm004,oocm004,oocmmodid,oocmmoddt,oocmownid,oocmowndp,oocmcrtid, 
       oocmcrtdp,oocmcrtdt FROM oocm_t WHERE oocment=? AND oocm001=? AND oocm002=? AND oocm003=? AND  
       oocm004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi050_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aooi050_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aooi050_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aooi050.input.head" >}
   
      #單頭段
      INPUT BY NAME g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003 
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
         AFTER FIELD oocm001
            
            #add-point:AFTER FIELD oocm001 name="input.a.oocm001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_oocm_m.oocm001) AND NOT cl_null(g_oocm_m.oocm002) AND NOT cl_null(g_oocm_m.oocm003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_oocm_m.oocm001 != g_oocm001_t  OR g_oocm_m.oocm002 != g_oocm002_t  OR g_oocm_m.oocm003 != g_oocm003_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oocm_t WHERE "||"oocment = '" ||g_enterprise|| "' AND "||"oocm001 = '"||g_oocm_m.oocm001 ||"' AND "|| "oocm002 = '"||g_oocm_m.oocm002 ||"' AND "|| "oocm003 = '"||g_oocm_m.oocm003 ||"'",'std-00004',0) THEN 
                     LET g_oocm_m.oocm001 = g_oocm001_t
                     LET g_oocm_m.oocm001_desc = g_oocm_m_t.oocm001_desc
                     DISPLAY BY NAME g_oocm_m.oocm001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
          
            IF NOT aooi050_oocm001_chk(g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003) THEN
               LET g_oocm_m.oocm001 = g_oocm001_t
               LET g_oocm_m.oocm001_desc = g_oocm_m_t.oocm001_desc
               DISPLAY BY NAME g_oocm_m.oocm001_desc
               NEXT FIELD oocm001
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocm001
            #add-point:BEFORE FIELD oocm001 name="input.b.oocm001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocm001
            #add-point:ON CHANGE oocm001 name="input.g.oocm001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocm002
            
            #add-point:AFTER FIELD oocm002 name="input.a.oocm002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_oocm_m.oocm001) AND NOT cl_null(g_oocm_m.oocm002) AND NOT cl_null(g_oocm_m.oocm003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_oocm_m.oocm001 != g_oocm001_t  OR g_oocm_m.oocm002 != g_oocm002_t  OR g_oocm_m.oocm003 != g_oocm003_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oocm_t WHERE "||"oocment = '" ||g_enterprise|| "' AND "||"oocm001 = '"||g_oocm_m.oocm001 ||"' AND "|| "oocm002 = '"||g_oocm_m.oocm002 ||"' AND "|| "oocm003 = '"||g_oocm_m.oocm003 ||"'",'std-00004',0) THEN 
                     LET g_oocm_m.oocm002 = g_oocm002_t
                     LET g_oocm_m.oocm002_desc = g_oocm_m_t.oocm002_desc
                     DISPLAY BY NAME g_oocm_m.oocm002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

           IF NOT aooi050_oocm001_chk(g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003) THEN
              LET g_oocm_m.oocm002 = g_oocm002_t
              LET g_oocm_m.oocm002_desc = g_oocm_m_t.oocm002_desc
              DISPLAY BY NAME g_oocm_m.oocm002_desc
              NEXT FIELD oocm002
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocm002
            #add-point:BEFORE FIELD oocm002 name="input.b.oocm002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocm002
            #add-point:ON CHANGE oocm002 name="input.g.oocm002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocm003
            
            #add-point:AFTER FIELD oocm003 name="input.a.oocm003"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_oocm_m.oocm001) AND NOT cl_null(g_oocm_m.oocm002) AND NOT cl_null(g_oocm_m.oocm003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_oocm_m.oocm001 != g_oocm001_t  OR g_oocm_m.oocm002 != g_oocm002_t  OR g_oocm_m.oocm003 != g_oocm003_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oocm_t WHERE "||"oocment = '" ||g_enterprise|| "' AND "||"oocm001 = '"||g_oocm_m.oocm001 ||"' AND "|| "oocm002 = '"||g_oocm_m.oocm002 ||"' AND "|| "oocm003 = '"||g_oocm_m.oocm003 ||"'",'std-00004',0) THEN 
                     LET g_oocm_m.oocm003 = g_oocm003_t
                     LET g_oocm_m.oocm003_desc = g_oocm_m_t.oocm003_desc
                     DISPLAY BY NAME g_oocm_m.oocm003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT aooi050_oocm001_chk(g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003) THEN
               LET g_oocm_m.oocm003 = g_oocm003_t
               LET g_oocm_m.oocm003_desc = g_oocm_m_t.oocm003_desc
               DISPLAY BY NAME g_oocm_m.oocm003_desc
               NEXT FIELD oocm003
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocm003
            #add-point:BEFORE FIELD oocm003 name="input.b.oocm003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocm003
            #add-point:ON CHANGE oocm003 name="input.g.oocm003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.oocm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocm001
            #add-point:ON ACTION controlp INFIELD oocm001 name="input.c.oocm001"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_oocm_m.oocm001             #給予default值
              
            LET g_qryparam.where = ''  
            #給予arg
            LET g_qryparam.where = "oocgstus = 'Y' "
            CALL q_oocg001()                                #呼叫開窗

            LET g_oocm_m.oocm001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_oocm_m.oocm001 TO oocm001              #顯示到畫面上

            NEXT FIELD oocm001                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.oocm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocm002
            #add-point:ON ACTION controlp INFIELD oocm002 name="input.c.oocm002"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.where = ''
            LET g_qryparam.default1 = g_oocm_m.oocm002             #給予default值

            IF NOT cl_null(g_oocm_m.oocm001) THEN          
               LET g_qryparam.where = " ooci001 = '",g_oocm_m.oocm001, "'" ," AND oocistus = 'Y' "   
            END IF  
            #給予arg

            CALL q_ooci002()                                #呼叫開窗

            LET g_oocm_m.oocm002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_oocm_m.oocm002 TO oocm002              #顯示到畫面上

            NEXT FIELD oocm002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.oocm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocm003
            #add-point:ON ACTION controlp INFIELD oocm003 name="input.c.oocm003"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''

            IF NOT cl_null(g_oocm_m.oocm001) THEN          
               LET g_qryparam.where = " oock001 = '",g_oocm_m.oocm001, "'" ," AND oockstus = 'Y' "   
            END IF   
            IF NOT cl_null(g_oocm_m.oocm002) THEN          
               LET g_qryparam.where = " oock002 = '",g_oocm_m.oocm002, "'" ," AND oockstus = 'Y' "      
            END IF  
            IF NOT cl_null(g_oocm_m.oocm001) AND NOT cl_null(g_oocm_m.oocm002) THEN 
               LET g_qryparam.where = "oock001 = '", g_oocm_m.oocm001, "' AND oock002 = '",g_oocm_m.oocm002, "'" ," AND oockstus = 'Y' "      
            END IF  
            LET g_qryparam.default1 = g_oocm_m.oocm003             #給予default值

            #給予arg

            CALL q_oock003()                                #呼叫開窗

            LET g_oocm_m.oocm003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_oocm_m.oocm003 TO oocm003              #顯示到畫面上

            NEXT FIELD oocm003                          #返回原欄位
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
            DISPLAY BY NAME g_oocm_m.oocm001             
                            ,g_oocm_m.oocm002   
                            ,g_oocm_m.oocm003   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL aooi050_oocm_t_mask_restore('restore_mask_o')
            
               UPDATE oocm_t SET (oocm001,oocm002,oocm003) = (g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003) 
 
                WHERE oocment = g_enterprise AND oocm001 = g_oocm001_t
                  AND oocm002 = g_oocm002_t
                  AND oocm003 = g_oocm003_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oocm_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oocm_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oocm_m.oocm001
               LET gs_keys_bak[1] = g_oocm001_t
               LET gs_keys[2] = g_oocm_m.oocm002
               LET gs_keys_bak[2] = g_oocm002_t
               LET gs_keys[3] = g_oocm_m.oocm003
               LET gs_keys_bak[3] = g_oocm003_t
               LET gs_keys[4] = g_oocm_d[g_detail_idx].oocm004
               LET gs_keys_bak[4] = g_oocm_d_t.oocm004
               CALL aooi050_update_b('oocm_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_oocm_m_t)
                     #LET g_log2 = util.JSON.stringify(g_oocm_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL aooi050_oocm_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aooi050_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_oocm001_t = g_oocm_m.oocm001
           LET g_oocm002_t = g_oocm_m.oocm002
           LET g_oocm003_t = g_oocm_m.oocm003
 
           
           IF g_oocm_d.getLength() = 0 THEN
              NEXT FIELD oocm004
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="aooi050.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_oocm_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.detail_input.page1.update_item"
               IF NOT cl_null(g_oocm_m.oocm001) AND NOT cl_null(g_oocm_m.oocm002) AND NOT cl_null(g_oocm_m.oocm003) AND NOT cl_null(g_oocm_d[l_ac].oocm004) THEN               
                  CALL n_oocml(g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003,g_oocm_d[l_ac].oocm004)
                  INITIALIZE g_ref_fields TO NULL 
                  LET g_ref_fields[1] = g_oocm_m.oocm001
                  LET g_ref_fields[2] = g_oocm_m.oocm002
                  LET g_ref_fields[3] = g_oocm_m.oocm003
                  LET g_ref_fields[4] = g_oocm_d[l_ac].oocm004
                  CALL ap_ref_array2(g_ref_fields," SELECT oocml006,oocml007 FROM oocml_t WHERE oocmlent = '"||g_enterprise||"' AND oocml001 = ? AND oocml002 = ? AND oocml003 = ? AND oocml004 = ? AND oocml005 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
                  LET g_oocm_d[l_ac].oocml006 = g_rtn_fields[1] 
                  LET g_oocm_d[l_ac].oocml007 = g_rtn_fields[2] 
               END IF             
               #END add-point
            END IF
 
 
 
 
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oocm_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi050_b_fill(g_wc2) #test 
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
            CALL aooi050_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN aooi050_cl USING g_enterprise,g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE aooi050_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aooi050_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_oocm_d[l_ac].oocm004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_oocm_d_t.* = g_oocm_d[l_ac].*  #BACKUP
               LET g_oocm_d_o.* = g_oocm_d[l_ac].*  #BACKUP
               CALL aooi050_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL aooi050_set_no_entry_b(l_cmd)
               OPEN aooi050_bcl USING g_enterprise,g_oocm_m.oocm001,
                                                g_oocm_m.oocm002,
                                                g_oocm_m.oocm003,
 
                                                g_oocm_d_t.oocm004
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aooi050_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi050_bcl INTO g_oocm_d[l_ac].oocmstus,g_oocm_d[l_ac].oocm004,g_oocm1_info_d[l_ac].oocm004, 
                      g_oocm1_info_d[l_ac].oocmmodid,g_oocm1_info_d[l_ac].oocmmoddt,g_oocm1_info_d[l_ac].oocmownid, 
                      g_oocm1_info_d[l_ac].oocmowndp,g_oocm1_info_d[l_ac].oocmcrtid,g_oocm1_info_d[l_ac].oocmcrtdp, 
                      g_oocm1_info_d[l_ac].oocmcrtdt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_oocm_d_t.oocm004,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oocm_d_mask_o[l_ac].* =  g_oocm_d[l_ac].*
                  CALL aooi050_oocm_t_mask()
                  LET g_oocm_d_mask_n[l_ac].* =  g_oocm_d[l_ac].*
                  
                  CALL aooi050_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF l_cmd ='u' THEN 
               INITIALIZE g_ref_fields TO NULL 
               LET g_ref_fields[1] = g_oocm_m.oocm001
               LET g_ref_fields[2] = g_oocm_m.oocm002
               LET g_ref_fields[3] = g_oocm_m.oocm003
               LET g_ref_fields[4] = g_oocm_d[l_ac].oocm004
               CALL ap_ref_array2(g_ref_fields," SELECT oocml006,oocml007 FROM oocml_t WHERE oocmlent = '"||g_enterprise||"' AND oocml001 = ? AND oocml002 = ? AND oocml003 = ? AND oocml004 = ? AND oocml005 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
               LET g_oocm_d[l_ac].oocml006 = g_rtn_fields[1] 
               LET g_oocm_d[l_ac].oocml007 = g_rtn_fields[2] 
            END IF
            #end add-point  
            
LET g_detail_multi_table_t.oocml001 = g_oocm_m.oocm001
LET g_detail_multi_table_t.oocml002 = g_oocm_m.oocm002
LET g_detail_multi_table_t.oocml003 = g_oocm_m.oocm003
LET g_detail_multi_table_t.oocml004 = g_oocm_d[l_ac].oocm004
LET g_detail_multi_table_t.oocml005 = g_dlang
LET g_detail_multi_table_t.oocml006 = g_oocm_d[l_ac].oocml006
LET g_detail_multi_table_t.oocml007 = g_oocm_d[l_ac].oocml007
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_oocm_d_t.* TO NULL
            INITIALIZE g_oocm_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oocm_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_oocm1_info_d[l_ac].oocmownid = g_user
      LET g_oocm1_info_d[l_ac].oocmowndp = g_dept
      LET g_oocm1_info_d[l_ac].oocmcrtid = g_user
      LET g_oocm1_info_d[l_ac].oocmcrtdp = g_dept 
      LET g_oocm1_info_d[l_ac].oocmcrtdt = cl_get_current()
      LET g_oocm1_info_d[l_ac].oocmmodid = g_user
      LET g_oocm1_info_d[l_ac].oocmmoddt = cl_get_current()
      LET g_oocm_d[l_ac].oocmstus = ''
 
 
  
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_oocm_d_t.* = g_oocm_d[l_ac].*     #新輸入資料
            LET g_oocm_d_o.* = g_oocm_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi050_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL aooi050_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oocm_d[li_reproduce_target].* = g_oocm_d[li_reproduce].*
               LET g_oocm1_info_d[li_reproduce_target].* = g_oocm1_info_d[li_reproduce].*
 
               LET g_oocm_d[g_oocm_d.getLength()].oocm004 = NULL
 
            END IF
            
LET g_detail_multi_table_t.oocml001 = g_oocm_m.oocm001
LET g_detail_multi_table_t.oocml002 = g_oocm_m.oocm002
LET g_detail_multi_table_t.oocml003 = g_oocm_m.oocm003
LET g_detail_multi_table_t.oocml004 = g_oocm_d[l_ac].oocm004
LET g_detail_multi_table_t.oocml005 = g_dlang
LET g_detail_multi_table_t.oocml006 = g_oocm_d[l_ac].oocml006
LET g_detail_multi_table_t.oocml007 = g_oocm_d[l_ac].oocml007
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_oocm_d[l_ac].oocmstus = "Y"
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
            SELECT COUNT(1) INTO l_count FROM oocm_t 
             WHERE oocment = g_enterprise AND oocm001 = g_oocm_m.oocm001
               AND oocm002 = g_oocm_m.oocm002
               AND oocm003 = g_oocm_m.oocm003
 
               AND oocm004 = g_oocm_d[l_ac].oocm004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO oocm_t
                           (oocment,
                            oocm001,oocm002,oocm003,
                            oocm004
                            ,oocmstus,oocmmodid,oocmmoddt,oocmownid,oocmowndp,oocmcrtid,oocmcrtdp,oocmcrtdt) 
                     VALUES(g_enterprise,
                            g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003,
                            g_oocm_d[l_ac].oocm004
                            ,g_oocm_d[l_ac].oocmstus,g_oocm1_info_d[l_ac].oocmmodid,g_oocm1_info_d[l_ac].oocmmoddt, 
                                g_oocm1_info_d[l_ac].oocmownid,g_oocm1_info_d[l_ac].oocmowndp,g_oocm1_info_d[l_ac].oocmcrtid, 
                                g_oocm1_info_d[l_ac].oocmcrtdp,g_oocm1_info_d[l_ac].oocmcrtdt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_oocm_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oocm_t:",SQLERRMESSAGE 
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
         IF g_oocm_m.oocm001 = g_detail_multi_table_t.oocml001 AND
         g_oocm_m.oocm002 = g_detail_multi_table_t.oocml002 AND
         g_oocm_m.oocm003 = g_detail_multi_table_t.oocml003 AND
         g_oocm_d[l_ac].oocm004 = g_detail_multi_table_t.oocml004 AND
         g_oocm_d[l_ac].oocml006 = g_detail_multi_table_t.oocml006 AND
         g_oocm_d[l_ac].oocml007 = g_detail_multi_table_t.oocml007 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocmlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_oocm_m.oocm001
            LET l_field_keys[02] = 'oocml001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.oocml001
            LET l_var_keys[03] = g_oocm_m.oocm002
            LET l_field_keys[03] = 'oocml002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.oocml002
            LET l_var_keys[04] = g_oocm_m.oocm003
            LET l_field_keys[04] = 'oocml003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.oocml003
            LET l_var_keys[05] = g_oocm_d[l_ac].oocm004
            LET l_field_keys[05] = 'oocml004'
            LET l_var_keys_bak[05] = g_detail_multi_table_t.oocml004
            LET l_var_keys[06] = g_dlang
            LET l_field_keys[06] = 'oocml005'
            LET l_var_keys_bak[06] = g_detail_multi_table_t.oocml005
            LET l_vars[01] = g_oocm_d[l_ac].oocml006
            LET l_fields[01] = 'oocml006'
            LET l_vars[02] = g_oocm_d[l_ac].oocml007
            LET l_fields[02] = 'oocml007'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocml_t')
         END IF 
 
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
               IF aooi050_before_delete() THEN 
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'oocmlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'oocml001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.oocml001
                  LET l_field_keys[03] = 'oocml002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.oocml002
                  LET l_field_keys[04] = 'oocml003'
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.oocml003
                  LET l_field_keys[05] = 'oocml004'
                  LET l_var_keys_bak[05] = g_detail_multi_table_t.oocml004
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'oocml_t')
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_oocm_m.oocm001
                  LET gs_keys[gs_keys.getLength()+1] = g_oocm_m.oocm002
                  LET gs_keys[gs_keys.getLength()+1] = g_oocm_m.oocm003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_oocm_d_t.oocm004
 
 
                  #刪除下層單身
                  IF NOT aooi050_key_delete_b(gs_keys,'oocm_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aooi050_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aooi050_bcl
               LET l_count = g_oocm_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_oocm_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocm004
            #add-point:BEFORE FIELD oocm004 name="input.b.page1.oocm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocm004
            
            #add-point:AFTER FIELD oocm004 name="input.a.page1.oocm004"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_oocm_m.oocm001) AND NOT cl_null(g_oocm_m.oocm002) AND NOT cl_null(g_oocm_m.oocm003) AND NOT cl_null(g_oocm_d[l_ac].oocm004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_oocm_m.oocm001 != g_oocm001_t  OR g_oocm_m.oocm002 != g_oocm002_t  OR g_oocm_m.oocm003 != g_oocm003_t  OR g_oocm_d[l_ac].oocm004 != g_oocm_d_t.oocm004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oocm_t WHERE "||"oocment = '" ||g_enterprise|| "' AND "||"oocm001 = '"||g_oocm_m.oocm001 ||"' AND "|| "oocm002 = '"||g_oocm_m.oocm002 ||"' AND "|| "oocm003 = '"||g_oocm_m.oocm003 ||"' AND "|| "oocm004 = '"||g_oocm_d[l_ac].oocm004 ||"'",'std-00004',0) THEN 
                      LET g_oocm_d[l_ac].oocm004 = g_oocm_d_t.oocm004
                      NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocm004
            #add-point:ON CHANGE oocm004 name="input.g.page1.oocm004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocml006
            #add-point:BEFORE FIELD oocml006 name="input.b.page1.oocml006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocml006
            
            #add-point:AFTER FIELD oocml006 name="input.a.page1.oocml006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocml006
            #add-point:ON CHANGE oocml006 name="input.g.page1.oocml006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocml007
            #add-point:BEFORE FIELD oocml007 name="input.b.page1.oocml007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocml007
            
            #add-point:AFTER FIELD oocml007 name="input.a.page1.oocml007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocml007
            #add-point:ON CHANGE oocml007 name="input.g.page1.oocml007"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.oocm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocm004
            #add-point:ON ACTION controlp INFIELD oocm004 name="input.c.page1.oocm004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocml006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocml006
            #add-point:ON ACTION controlp INFIELD oocml006 name="input.c.page1.oocml006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocml007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocml007
            #add-point:ON ACTION controlp INFIELD oocml007 name="input.c.page1.oocml007"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_oocm_d[l_ac].* = g_oocm_d_t.*
               CLOSE aooi050_bcl
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
               LET g_errparam.extend = g_oocm_d[l_ac].oocm004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_oocm_d[l_ac].* = g_oocm_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_oocm1_info_d[l_ac].oocmmodid = g_user 
LET g_oocm1_info_d[l_ac].oocmmoddt = cl_get_current()
LET g_oocm1_info_d[l_ac].oocmmodid_desc = cl_get_username(g_oocm1_info_d[l_ac].oocmmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
 
               #end add-point
         
               #將遮罩欄位還原
               CALL aooi050_oocm_t_mask_restore('restore_mask_o')
         
               UPDATE oocm_t SET (oocm001,oocm002,oocm003,oocmstus,oocm004,oocmmodid,oocmmoddt,oocmownid, 
                   oocmowndp,oocmcrtid,oocmcrtdp,oocmcrtdt) = (g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003, 
                   g_oocm_d[l_ac].oocmstus,g_oocm_d[l_ac].oocm004,g_oocm1_info_d[l_ac].oocmmodid,g_oocm1_info_d[l_ac].oocmmoddt, 
                   g_oocm1_info_d[l_ac].oocmownid,g_oocm1_info_d[l_ac].oocmowndp,g_oocm1_info_d[l_ac].oocmcrtid, 
                   g_oocm1_info_d[l_ac].oocmcrtdp,g_oocm1_info_d[l_ac].oocmcrtdt)
                WHERE oocment = g_enterprise AND oocm001 = g_oocm_m.oocm001 
                 AND oocm002 = g_oocm_m.oocm002 
                 AND oocm003 = g_oocm_m.oocm003 
 
                 AND oocm004 = g_oocm_d_t.oocm004 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oocm_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "oocm_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oocm_m.oocm001
               LET gs_keys_bak[1] = g_oocm001_t
               LET gs_keys[2] = g_oocm_m.oocm002
               LET gs_keys_bak[2] = g_oocm002_t
               LET gs_keys[3] = g_oocm_m.oocm003
               LET gs_keys_bak[3] = g_oocm003_t
               LET gs_keys[4] = g_oocm_d[g_detail_idx].oocm004
               LET gs_keys_bak[4] = g_oocm_d_t.oocm004
               CALL aooi050_update_b('oocm_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_oocm_m.oocm001 = g_detail_multi_table_t.oocml001 AND
         g_oocm_m.oocm002 = g_detail_multi_table_t.oocml002 AND
         g_oocm_m.oocm003 = g_detail_multi_table_t.oocml003 AND
         g_oocm_d[l_ac].oocm004 = g_detail_multi_table_t.oocml004 AND
         g_oocm_d[l_ac].oocml006 = g_detail_multi_table_t.oocml006 AND
         g_oocm_d[l_ac].oocml007 = g_detail_multi_table_t.oocml007 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocmlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_oocm_m.oocm001
            LET l_field_keys[02] = 'oocml001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.oocml001
            LET l_var_keys[03] = g_oocm_m.oocm002
            LET l_field_keys[03] = 'oocml002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.oocml002
            LET l_var_keys[04] = g_oocm_m.oocm003
            LET l_field_keys[04] = 'oocml003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.oocml003
            LET l_var_keys[05] = g_oocm_d[l_ac].oocm004
            LET l_field_keys[05] = 'oocml004'
            LET l_var_keys_bak[05] = g_detail_multi_table_t.oocml004
            LET l_var_keys[06] = g_dlang
            LET l_field_keys[06] = 'oocml005'
            LET l_var_keys_bak[06] = g_detail_multi_table_t.oocml005
            LET l_vars[01] = g_oocm_d[l_ac].oocml006
            LET l_fields[01] = 'oocml006'
            LET l_vars[02] = g_oocm_d[l_ac].oocml007
            LET l_fields[02] = 'oocml007'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocml_t')
         END IF 
 
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_oocm_m),util.JSON.stringify(g_oocm_d_t)
                     LET g_log2 = util.JSON.stringify(g_oocm_m),util.JSON.stringify(g_oocm_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi050_oocm_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_oocm_m.oocm001
               LET ls_keys[ls_keys.getLength()+1] = g_oocm_m.oocm002
               LET ls_keys[ls_keys.getLength()+1] = g_oocm_m.oocm003
 
               LET ls_keys[ls_keys.getLength()+1] = g_oocm_d_t.oocm004
 
               CALL aooi050_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE aooi050_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oocm_d[l_ac].* = g_oocm_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE aooi050_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_oocm_d.getLength() = 0 THEN
               NEXT FIELD oocm004
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_oocm_d[li_reproduce_target].* = g_oocm_d[li_reproduce].*
               LET g_oocm1_info_d[li_reproduce_target].* = g_oocm1_info_d[li_reproduce].*
 
               LET g_oocm_d[li_reproduce_target].oocm004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_oocm_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oocm_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_oocm1_info_d TO s_detail1_info.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL aooi050_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1_info")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL aooi050_idx_chk()
            CALL aooi050_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body1_info.action"
         
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
         CALL DIALOG.setCurrentRow("s_detail1_info",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD oocm001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD oocmstus
               WHEN "s_detail1_info"
                  NEXT FIELD oocm004_2
 
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
   CALL g_curr_diag.setCurrentRow("s_detail1_info",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aooi050_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL aooi050_b_fill(g_wc2) #第一階單身填充
      CALL aooi050_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aooi050_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_oocm_m.oocm001,g_oocm_m.oocm001_desc,g_oocm_m.oocm002,g_oocm_m.oocm002_desc,g_oocm_m.oocm003, 
       g_oocm_m.oocm003_desc
 
   CALL aooi050_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION aooi050_ref_show()
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
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oocm_m.oocm001
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_oocm_m.oocm001_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_oocm_m.oocm001_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oocm_m.oocm001
#            LET g_ref_fields[2] = g_oocm_m.oocm002
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocil004 FROM oocil_t WHERE oocilent='"||g_enterprise||"' AND oocil001=? AND oocil002=? AND oocil003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_oocm_m.oocm002_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_oocm_m.oocm002_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oocm_m.oocm001
#            LET g_ref_fields[2] = g_oocm_m.oocm002
#            LET g_ref_fields[3] = g_oocm_m.oocm003
#            CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl001=? AND oockl002=? AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_oocm_m.oocm003_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_oocm_m.oocm003_desc

   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_oocm_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = g_oocm_m.oocm001
#   LET g_ref_fields[2] = g_oocm_m.oocm002
#   LET g_ref_fields[3] = g_oocm_m.oocm003
#   LET g_ref_fields[4] = g_oocm_d[l_ac].oocm004
#   CALL ap_ref_array2(g_ref_fields," SELECT oocml006,oocml007 FROM oocml_t WHERE oocmlent = '"||g_enterprise||"' AND oocml001 = ? AND oocml002 = ? AND oocml003 = ? AND oocml004 = ? AND oocml005 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
#   LET g_oocm_d[l_ac].oocml006 = g_rtn_fields[1] 
#   LET g_oocm_d[l_ac].oocml007 = g_rtn_fields[2] 
#   DISPLAY BY NAME g_oocm_d[l_ac].oocml006,g_oocm_d[l_ac].oocml007
  
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_oocm1_info_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body1_info.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oocm1_info_d[l_ac].oocmmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_oocm1_info_d[l_ac].oocmmodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_oocm1_info_d[l_ac].oocmmodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oocm1_info_d[l_ac].oocmownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_oocm1_info_d[l_ac].oocmownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_oocm1_info_d[l_ac].oocmownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oocm1_info_d[l_ac].oocmowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_oocm1_info_d[l_ac].oocmowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_oocm1_info_d[l_ac].oocmowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oocm1_info_d[l_ac].oocmcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_oocm1_info_d[l_ac].oocmcrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_oocm1_info_d[l_ac].oocmcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oocm1_info_d[l_ac].oocmcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_oocm1_info_d[l_ac].oocmcrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_oocm1_info_d[l_ac].oocmcrtdp_desc

      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="aooi050.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aooi050_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE oocm_t.oocm001 
   DEFINE l_oldno     LIKE oocm_t.oocm001 
   DEFINE l_newno02     LIKE oocm_t.oocm002 
   DEFINE l_oldno02     LIKE oocm_t.oocm002 
   DEFINE l_newno03     LIKE oocm_t.oocm003 
   DEFINE l_oldno03     LIKE oocm_t.oocm003 
 
   DEFINE l_master    RECORD LIKE oocm_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE oocm_t.* #此變數樣板目前無使用
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_oocg001        LIKE oocg_t.oocg001
   DEFINE l_oocgstus       LIKE oocg_t.oocgstus
   DEFINE l_ooci002        LIKE ooci_t.ooci002  
   DEFINE l_oocistus       LIKE ooci_t.oocistus
   DEFINE l_oock003        LIKE oock_t.oock003 
   DEFINE l_oockstus       LIKE oock_t.oockstus
   DEFINE l_sql            STRING
   #end add-point
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_oocm_m.oocm001 IS NULL
      OR g_oocm_m.oocm002 IS NULL
      OR g_oocm_m.oocm003 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_oocm001_t = g_oocm_m.oocm001
   LET g_oocm002_t = g_oocm_m.oocm002
   LET g_oocm003_t = g_oocm_m.oocm003
 
   
   LET g_oocm_m.oocm001 = ""
   LET g_oocm_m.oocm002 = ""
   LET g_oocm_m.oocm003 = ""
 
   LET g_master_insert = FALSE
   CALL aooi050_set_entry('a')
   CALL aooi050_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_oocm_m.oocm001_desc = ''
   DISPLAY BY NAME g_oocm_m.oocm001_desc
   LET g_oocm_m.oocm002_desc = ''
   DISPLAY BY NAME g_oocm_m.oocm002_desc
   LET g_oocm_m.oocm003_desc = ''
   DISPLAY BY NAME g_oocm_m.oocm003_desc
 
   
   CALL aooi050_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_oocm_m.* TO NULL
      INITIALIZE g_oocm_d TO NULL
      INITIALIZE g_oocm1_info_d TO NULL
 
      CALL aooi050_show()
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
   CALL aooi050_set_act_visible()
   CALL aooi050_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_oocm001_t = g_oocm_m.oocm001
   LET g_oocm002_t = g_oocm_m.oocm002
   LET g_oocm003_t = g_oocm_m.oocm003
 
   
   #組合新增資料的條件
   LET g_add_browse = " oocment = " ||g_enterprise|| " AND",
                      " oocm001 = '", g_oocm_m.oocm001, "' "
                      ," AND oocm002 = '", g_oocm_m.oocm002, "' "
                      ," AND oocm003 = '", g_oocm_m.oocm003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aooi050_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL aooi050_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL aooi050_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aooi050_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE oocm_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aooi050_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM oocm_t
    WHERE oocment = g_enterprise AND oocm001 = g_oocm001_t
    AND oocm002 = g_oocm002_t
    AND oocm003 = g_oocm003_t
 
       INTO TEMP aooi050_detail
   
   #將key修正為調整後   
   UPDATE aooi050_detail 
      #更新key欄位
      SET oocm001 = g_oocm_m.oocm001
          , oocm002 = g_oocm_m.oocm002
          , oocm003 = g_oocm_m.oocm003
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , oocmownid = g_user 
       , oocmowndp = g_dept
       , oocmcrtid = g_user
       , oocmcrtdp = g_dept 
       , oocmcrtdt = ld_date
       , oocmmodid = g_user
       , oocmmoddt = ld_date
      #, oocmstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO oocm_t SELECT * FROM aooi050_detail
   
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
   DROP TABLE aooi050_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
      #應用 a38 樣板自動產生(Version:6)
   #單身多語言複製
   DROP TABLE aooi050_detail_lang
   
   #add-point:單身複製前1 name="detail_reproduce.body.lang0.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE & INSERT 
   SELECT * FROM oocml_t 
    WHERE oocmlent = g_enterprise AND oocml001 = g_oocm001_t
      AND oocml002 = g_oocm002_t      AND oocml003 = g_oocm003_t
     INTO TEMP aooi050_detail_lang
 
   #將key修正為調整後   
   UPDATE aooi050_detail_lang 
      #更新key欄位
      SET oocml001 = g_oocm_m.oocm001
          , oocml002 = g_oocm_m.oocm002          , oocml003 = g_oocm_m.oocm003
  
   #add-point:單身修改前 name="detail_reproduce.body.lang0.b_update"
   
   #end add-point   
  
   #將資料塞回原table   
   INSERT INTO oocml_t SELECT * FROM aooi050_detail_lang
   
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
   DROP TABLE aooi050_detail_lang
   
   #add-point:單身複製後1 name="detail_reproduce.lang0.table1.a_insert"
   
   #end add-point
 
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_oocm001_t = g_oocm_m.oocm001
   LET g_oocm002_t = g_oocm_m.oocm002
   LET g_oocm003_t = g_oocm_m.oocm003
 
   
   DROP TABLE aooi050_detail
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aooi050_delete()
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
   
   IF g_oocm_m.oocm001 IS NULL
   OR g_oocm_m.oocm002 IS NULL
   OR g_oocm_m.oocm003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN aooi050_cl USING g_enterprise,g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi050_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aooi050_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aooi050_master_referesh USING g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003 INTO g_oocm_m.oocm001, 
       g_oocm_m.oocm002,g_oocm_m.oocm003,g_oocm_m.oocm001_desc,g_oocm_m.oocm002_desc,g_oocm_m.oocm003_desc 
 
   
   #遮罩相關處理
   LET g_oocm_m_mask_o.* =  g_oocm_m.*
   CALL aooi050_oocm_t_mask()
   LET g_oocm_m_mask_n.* =  g_oocm_m.*
   
   CALL aooi050_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi050_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM oocm_t WHERE oocment = g_enterprise AND oocm001 = g_oocm_m.oocm001
                                                               AND oocm002 = g_oocm_m.oocm002
                                                               AND oocm003 = g_oocm_m.oocm003
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oocm_t:",SQLERRMESSAGE 
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
         LET l_field_keys[01] = 'oocmlent'
         LET l_var_keys_bak[01] = g_enterprise
         LET l_field_keys[02] = 'oocml001'
         LET l_var_keys_bak[02] = g_detail_multi_table_t.oocml001
         LET l_field_keys[02] = 'oocml002'
         LET l_var_keys_bak[02] = g_detail_multi_table_t.oocml002
         LET l_field_keys[02] = 'oocml003'
         LET l_var_keys_bak[02] = g_detail_multi_table_t.oocml003
         CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'oocml_t')
 
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE aooi050_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_oocm_d.clear() 
      CALL g_oocm1_info_d.clear()       
 
     
      CALL aooi050_ui_browser_refresh()  
      #CALL aooi050_ui_headershow()  
      #CALL aooi050_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL aooi050_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL aooi050_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE aooi050_cl
 
   #功能已完成,通報訊息中心
   CALL aooi050_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aooi050.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aooi050_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_oocm_d.clear()
   CALL g_oocm1_info_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT oocmstus,oocm004,oocm004,oocmmodid,oocmmoddt,oocmownid,oocmowndp,oocmcrtid, 
       oocmcrtdp,oocmcrtdt,t1.ooag011 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 FROM oocm_t", 
          
               " LEFT JOIN oocml_t ON oocmlent = "||g_enterprise||" AND oocm001 = oocml001 AND oocm002 = oocml002 AND oocm003 = oocml003 AND oocm004 = oocml004 AND oocml005 = '",g_dlang,"'",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=oocmmodid  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=oocmownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=oocmowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=oocmcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=oocmcrtdp AND t5.ooefl002='"||g_dlang||"' ",
 
               " WHERE oocment= ? AND oocm001=? AND oocm002=? AND oocm003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("oocm_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF aooi050_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY oocm_t.oocm004"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aooi050_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aooi050_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_oocm_m.oocm001,g_oocm_m.oocm002,g_oocm_m.oocm003 INTO g_oocm_d[l_ac].oocmstus, 
          g_oocm_d[l_ac].oocm004,g_oocm1_info_d[l_ac].oocm004,g_oocm1_info_d[l_ac].oocmmodid,g_oocm1_info_d[l_ac].oocmmoddt, 
          g_oocm1_info_d[l_ac].oocmownid,g_oocm1_info_d[l_ac].oocmowndp,g_oocm1_info_d[l_ac].oocmcrtid, 
          g_oocm1_info_d[l_ac].oocmcrtdp,g_oocm1_info_d[l_ac].oocmcrtdt,g_oocm1_info_d[l_ac].oocmmodid_desc, 
          g_oocm1_info_d[l_ac].oocmownid_desc,g_oocm1_info_d[l_ac].oocmowndp_desc,g_oocm1_info_d[l_ac].oocmcrtid_desc, 
          g_oocm1_info_d[l_ac].oocmcrtdp_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_oocm_m.oocm001
   LET g_ref_fields[2] = g_oocm_m.oocm002
   LET g_ref_fields[3] = g_oocm_m.oocm003
   LET g_ref_fields[4] = g_oocm_d[l_ac].oocm004
   CALL ap_ref_array2(g_ref_fields," SELECT oocml006,oocml007 FROM oocml_t WHERE oocmlent = '"||g_enterprise||"' AND oocml001 = ? AND oocml002 = ? AND oocml003 = ? AND oocml004 = ? AND oocml005 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_oocm_d[l_ac].oocml006 = g_rtn_fields[1] 
   LET g_oocm_d[l_ac].oocml007 = g_rtn_fields[2]
         #end add-point
      
         #帶出公用欄位reference值
         
         
         #應用 a12 樣板自動產生(Version:4)
 
 
 
 
        
         #add-point:單身資料抓取 name="bfill.foreach"
         LET  g_oocm1_info_d[l_ac].oocm004 = g_oocm_d[l_ac].oocm004
      LET g_oocm1_info_d[l_ac].oocmownid_desc = cl_get_username(g_oocm1_info_d[l_ac].oocmownid)
      LET g_oocm1_info_d[l_ac].oocmowndp_desc = cl_get_deptname(g_oocm1_info_d[l_ac].oocmowndp)
      LET g_oocm1_info_d[l_ac].oocmcrtid_desc = cl_get_username(g_oocm1_info_d[l_ac].oocmcrtid)
      LET g_oocm1_info_d[l_ac].oocmcrtdp_desc = cl_get_deptname(g_oocm1_info_d[l_ac].oocmcrtdp)
      LET g_oocm1_info_d[l_ac].oocmmodid_desc = cl_get_username(g_oocm1_info_d[l_ac].oocmmodid)
        
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
 
            CALL g_oocm_d.deleteElement(g_oocm_d.getLength())
      CALL g_oocm1_info_d.deleteElement(g_oocm1_info_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_oocm_d.getLength()
      LET g_oocm_d_mask_o[l_ac].* =  g_oocm_d[l_ac].*
      CALL aooi050_oocm_t_mask()
      LET g_oocm_d_mask_n[l_ac].* =  g_oocm_d[l_ac].*
   END FOR
   
   LET g_oocm1_info_d_mask_o.* =  g_oocm1_info_d.*
   FOR l_ac = 1 TO g_oocm1_info_d.getLength()
      LET g_oocm1_info_d_mask_o[l_ac].* =  g_oocm1_info_d[l_ac].*
      CALL aooi050_oocm_t_mask()
      LET g_oocm1_info_d_mask_n[l_ac].* =  g_oocm1_info_d[l_ac].*
   END FOR
 
 
   FREE aooi050_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aooi050_idx_chk()
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
      IF g_detail_idx > g_oocm_d.getLength() THEN
         LET g_detail_idx = g_oocm_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_oocm_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oocm_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1_info")
      IF g_detail_idx > g_oocm1_info_d.getLength() THEN
         LET g_detail_idx = g_oocm1_info_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oocm1_info_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oocm1_info_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail1_info",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aooi050_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_oocm_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION aooi050_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM oocm_t
    WHERE oocment = g_enterprise AND oocm001 = g_oocm_m.oocm001 AND
                              oocm002 = g_oocm_m.oocm002 AND
                              oocm003 = g_oocm_m.oocm003 AND
 
          oocm004 = g_oocm_d_t.oocm004
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "oocm_t:",SQLERRMESSAGE 
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
 
{<section id="aooi050.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aooi050_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="aooi050.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aooi050_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="aooi050.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aooi050_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="aooi050.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION aooi050_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_oocm_d[l_ac].oocm004 = g_oocm_d_t.oocm004 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aooi050_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aooi050.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aooi050_lock_b(ps_table,ps_page)
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
   #CALL aooi050_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aooi050.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aooi050_unlock_b(ps_table,ps_page)
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
 
{<section id="aooi050.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aooi050_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("oocm001,oocm002,oocm003",TRUE)
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
 
{<section id="aooi050.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aooi050_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("oocm001,oocm002,oocm003",FALSE)
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
 
{<section id="aooi050.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aooi050_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aooi050_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aooi050_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi050.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aooi050_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi050.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aooi050_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi050.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aooi050_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi050.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aooi050_default_search()
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
   IF cl_null(g_argv[1]) THEN
      LET g_chkparam.arg1 = g_user
      CALL cl_ref_val("v_ooef006")
      LET g_argv[1] = g_chkparam.return1
   END IF   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " oocm001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " oocm002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " oocm003 = '", g_argv[03], "' AND "
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
 
{<section id="aooi050.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aooi050_fill_chk(ps_idx)
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
 
{<section id="aooi050.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION aooi050_modify_detail_chk(ps_record)
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
         LET ls_return = "oocmstus"
      WHEN "s_detail1_info"
         LET ls_return = "oocm004_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aooi050.mask_functions" >}
&include "erp/aoo/aooi050_mask.4gl"
 
{</section>}
 
{<section id="aooi050.state_change" >}
    
 
{</section>}
 
{<section id="aooi050.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aooi050_set_pk_array()
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
   LET g_pk_array[1].values = g_oocm_m.oocm001
   LET g_pk_array[1].column = 'oocm001'
   LET g_pk_array[2].values = g_oocm_m.oocm002
   LET g_pk_array[2].column = 'oocm002'
   LET g_pk_array[3].values = g_oocm_m.oocm003
   LET g_pk_array[3].column = 'oocm003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi050.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aooi050_msgcentre_notify(lc_state)
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
   CALL aooi050_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_oocm_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi050.other_function" readonly="Y" >}
#+ oocm001,oocm002,oocm003欄位檢查
PRIVATE FUNCTION aooi050_oocm001_chk(p_oocm001,p_oocm002,p_oocm003)
   DEFINE p_oocm001        LIKE oocm_t.oocm001
   DEFINE p_oocm002        LIKE oocm_t.oocm002
   DEFINE p_oocm003        LIKE oocm_t.oocm003
   DEFINE l_oocg001        LIKE oocg_t.oocg001
   DEFINE l_oocgstus       LIKE oocg_t.oocgstus
   DEFINE l_ooci002        LIKE ooci_t.ooci002  
   DEFINE l_oocistus       LIKE ooci_t.oocistus
   DEFINE l_oock003        LIKE oock_t.oock003 
   DEFINE l_oockstus       LIKE oock_t.oockstus
   DEFINE l_sql            STRING
   
   IF NOT cl_null(p_oocm001) THEN 
      LET l_oocg001 = ''
      LET l_oocgstus = ''
      SELECT oocg001,oocgstus INTO l_oocg001,l_oocgstus FROM oocg_t
       WHERE oocgent = g_enterprise
         AND oocg001 = p_oocm001
      IF cl_null(l_oocg001) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aoo-00013'
         LET g_errparam.extend =  p_oocm001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF 
      IF l_oocgstus != 'Y' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-01302' #aoo-00035  #160318-00005#30  By 07900 --mod 
         LET g_errparam.extend = p_oocm001
         #160318-00005#30  By 07900 --add-str
         LET g_errparam.replace[1] ='aooi020'
         LET g_errparam.replace[2] = cl_get_progname("aooi020",g_lang,"2")
         LET g_errparam.exeprog ='aooi020'
         #160318-00005#30  By 07900 --add-end
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN FALSE
      END IF 
    END IF
    
    IF NOT cl_null(p_oocm002) THEN 
      LET l_ooci002 = ''
      LET l_oocistus = ''   
      LET l_sql = "SELECT ooci002,oocistus FROM ooci_t ",
                 "  WHERE ooci002 = '",p_oocm002,"' AND oocient = '",g_enterprise,"'"
      IF NOT cl_null(p_oocm001) THEN 
         LET l_sql = l_sql," AND ooci001 = '",p_oocm001,"'"
      END IF  
      PREPARE pre_oocm002 FROM l_sql 
      EXECUTE pre_oocm002 INTO l_ooci002, l_oocistus   
      IF cl_null(l_ooci002) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aoo-00014'
         LET g_errparam.extend =  p_oocm002
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN FALSE
      END IF 
      IF l_oocistus != 'Y' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-01302'  #aoo-00143  #160318-00005#30  By 07900 --mod
         LET g_errparam.extend = p_oocm002 
         #160318-00005#30  By 07900 --add-str
         LET g_errparam.replace[1] ='aooi030'
         LET g_errparam.replace[2] = cl_get_progname("aooi030",g_lang,"2")
         LET g_errparam.exeprog ='aooi030'
         #160318-00005#30  By 07900 --add-end
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF 
   
    IF NOT cl_null(p_oocm003) THEN 
      LET l_oock003 = ''
      LET l_oockstus = ''
      LET l_sql = "SELECT oock003,oockstus FROM oock_t ",
                 "  WHERE oock003 = '",p_oocm003,"' AND oockent = '",g_enterprise,"'"
      IF NOT cl_null(p_oocm001) THEN 
         LET l_sql = l_sql," AND oock001 = '",p_oocm001,"'"
      END IF  
      IF NOT cl_null(p_oocm002) THEN 
         LET l_sql = l_sql," AND oock002 = '",p_oocm002,"'"
      END IF     
      PREPARE pre_oocm003 FROM l_sql
      EXECUTE pre_oocm003 INTO l_oock003, l_oockstus   
      IF cl_null(l_oock003) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aoo-00015'
         LET g_errparam.extend =  p_oocm003
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN FALSE
      END IF 
      IF l_oockstus != 'Y' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aoo-00036'
         LET g_errparam.extend = p_oocm003
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN FALSE      
      END IF 
   END IF 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oocm001
   CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_oocm_m.oocm001_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_oocm_m.oocm001_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oocm001
   LET g_ref_fields[2] = p_oocm002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocil004 FROM oocil_t WHERE oocilent='"||g_enterprise||"' AND oocil001=? AND oocil002=? AND oocil003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_oocm_m.oocm002_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_oocm_m.oocm002_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oocm001
   LET g_ref_fields[2] = p_oocm002
   LET g_ref_fields[3] = p_oocm003
   CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl001=? AND oockl002=? AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_oocm_m.oocm003_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_oocm_m.oocm003_desc           
   RETURN TRUE           

END FUNCTION

 
{</section>}
 
