#該程式未解開Section, 採用最新樣板產出!
{<section id="apji400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2017-01-12 17:45:46), PR版次:0001(2017-01-17 17:48:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: apji400
#+ Description: 項目費用分攤科目設定作業
#+ Creator....: 05423(2017-01-03 11:36:22)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="apji400.global" >}
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
PRIVATE type type_g_pjea_m        RECORD
       pjeald LIKE pjea_t.pjeald, 
   pjeald_desc LIKE type_t.chr80, 
   pjea002 LIKE pjea_t.pjea002, 
   pjea003 LIKE pjea_t.pjea003
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pjea_d        RECORD
       pjeastus LIKE pjea_t.pjeastus, 
   pjea005 LIKE pjea_t.pjea005, 
   l_pjea005_desc LIKE type_t.chr500, 
   pjea006 LIKE pjea_t.pjea006, 
   pjea006_desc LIKE type_t.chr500, 
   pjea004 LIKE pjea_t.pjea004, 
   pjea009 LIKE pjea_t.pjea009
       END RECORD
PRIVATE TYPE type_g_pjea3_d RECORD
       pjea005 LIKE pjea_t.pjea005, 
   pjea006 LIKE pjea_t.pjea006, 
   pjeaownid LIKE pjea_t.pjeaownid, 
   pjeaownid_desc LIKE type_t.chr500, 
   pjeaowndp LIKE pjea_t.pjeaowndp, 
   pjeaowndp_desc LIKE type_t.chr500, 
   pjeacrtid LIKE pjea_t.pjeacrtid, 
   pjeacrtid_desc LIKE type_t.chr500, 
   pjeacrtdp LIKE pjea_t.pjeacrtdp, 
   pjeacrtdp_desc LIKE type_t.chr500, 
   pjeacrtdt DATETIME YEAR TO SECOND, 
   pjeamodid LIKE pjea_t.pjeamodid, 
   pjeamodid_desc LIKE type_t.chr500, 
   pjeamoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaacomp       LIKE glaa_t.glaacomp
DEFINE g_ooef004         LIKE ooef_t.ooef004
DEFINE g_ooef008         LIKE ooef_t.ooef008
DEFINE g_ooef009         LIKE ooef_t.ooef009
DEFINE g_ooef017         LIKE ooef_t.ooef017
DEFINE g_oogc006         LIKE oogc_t.oogc006
TYPE type_g_pjea_s        RECORD
   pjeald               LIKE pjea_t.pjeald,
   pjeald_desc          LIKE type_t.chr50,
   pjea002              LIKE pjea_t.pjea002,
   pjea003              LIKE pjea_t.pjea003,
   pjea005              LIKE pjea_t.pjea005,
   pjea006              LIKE pjea_t.pjea006,
   l_comp               LIKE glaa_t.glaacomp,
   glaa004              LIKE glaa_t.glaa004
END RECORD
DEFINE g_pjea_s        type_g_pjea_s         
TYPE type_g_pjea2_s        RECORD
  l_pjeald_b       LIKE pjea_t.pjeald,
  l_pjeald_b_desc  LIKE type_t.chr80,
  l_pjea002_b      LIKE pjea_t.pjea002,
  l_pjea003_b      LIKE pjea_t.pjea003,
  l_pjeald_e       LIKE type_t.chr80,
  l_pjeald_e_desc  LIKE type_t.chr80,
  l_pjea002_e      LIKE type_t.num5,
  l_pjea003_e      LIKE type_t.num5
END RECORD
DEFINE g_pjea2_s        type_g_pjea2_s   
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_pjea_m          type_g_pjea_m
DEFINE g_pjea_m_t        type_g_pjea_m
DEFINE g_pjea_m_o        type_g_pjea_m
DEFINE g_pjea_m_mask_o   type_g_pjea_m #轉換遮罩前資料
DEFINE g_pjea_m_mask_n   type_g_pjea_m #轉換遮罩後資料
 
   DEFINE g_pjeald_t LIKE pjea_t.pjeald
DEFINE g_pjea002_t LIKE pjea_t.pjea002
DEFINE g_pjea003_t LIKE pjea_t.pjea003
 
 
DEFINE g_pjea_d          DYNAMIC ARRAY OF type_g_pjea_d
DEFINE g_pjea_d_t        type_g_pjea_d
DEFINE g_pjea_d_o        type_g_pjea_d
DEFINE g_pjea_d_mask_o   DYNAMIC ARRAY OF type_g_pjea_d #轉換遮罩前資料
DEFINE g_pjea_d_mask_n   DYNAMIC ARRAY OF type_g_pjea_d #轉換遮罩後資料
DEFINE g_pjea3_d   DYNAMIC ARRAY OF type_g_pjea3_d
DEFINE g_pjea3_d_t type_g_pjea3_d
DEFINE g_pjea3_d_o type_g_pjea3_d
DEFINE g_pjea3_d_mask_o   DYNAMIC ARRAY OF type_g_pjea3_d #轉換遮罩前資料
DEFINE g_pjea3_d_mask_n   DYNAMIC ARRAY OF type_g_pjea3_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_pjeald LIKE pjea_t.pjeald,
      b_pjea002 LIKE pjea_t.pjea002,
      b_pjea003 LIKE pjea_t.pjea003
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
 
{<section id="apji400.main" >}
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
   LET g_forupd_sql = " SELECT pjeald,'',pjea002,pjea003", 
                      " FROM pjea_t",
                      " WHERE pjeaent= ? AND pjeald=? AND pjea002=? AND pjea003=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apji400_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pjeald,t0.pjea002,t0.pjea003,t1.glaal002",
               " FROM pjea_t t0",
                              " LEFT JOIN glaal_t t1 ON t1.glaalent="||g_enterprise||" AND t1.glaalld=t0.pjeald AND t1.glaal001='"||g_dlang||"' ",
 
               " WHERE t0.pjeaent = " ||g_enterprise|| " AND t0.pjeald = ? AND t0.pjea002 = ? AND t0.pjea003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apji400_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apji400 WITH FORM cl_ap_formpath("apj",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apji400_init()   
 
      #進入選單 Menu (="N")
      CALL apji400_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apji400
      
   END IF 
   
   CLOSE apji400_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apji400.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apji400_init()
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
   SELECT ooef004,ooef008,ooef009,ooef017 INTO g_ooef004,g_ooef008,g_ooef009,g_ooef017 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site 
   LET g_errshow = 1
   #end add-point
   
   CALL apji400_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apji400.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apji400_ui_dialog()
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
         INITIALIZE g_pjea_m.* TO NULL
         CALL g_pjea_d.clear()
         CALL g_pjea3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apji400_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_pjea_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL apji400_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apji400_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_pjea3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL apji400_idx_chk()
               CALL apji400_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body3.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 2
            
            
         
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL apji400_browser_fill("")
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
               CALL apji400_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apji400_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apji400_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apji400_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apji400_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apji400_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apji400_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apji400_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apji400_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apji400_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apji400_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apji400_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_pjea_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_pjea3_d)
                  LET g_export_id[2]   = "s_detail3"
 
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
               NEXT FIELD pjea004
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
               CALL apji400_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL apji400_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL apji400_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apji400_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apji400_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION auto_reproduce
            LET g_action_choice="auto_reproduce"
            IF cl_auth_chk_act("auto_reproduce") THEN
               
               #add-point:ON ACTION auto_reproduce name="menu.auto_reproduce"
               CALL apji400_s02()
               CALL apji400_browser_fill("F")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apji400_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apji400_insert()
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
               CALL apji400_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apji400_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION auto_gen
            LET g_action_choice="auto_gen"
            IF cl_auth_chk_act("auto_gen") THEN
               
               #add-point:ON ACTION auto_gen name="menu.auto_gen"
               CALL apji400_s01()
               CALL apji400_browser_fill("F")
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apji400_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apji400_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apji400_set_pk_array()
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
 
{<section id="apji400.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION apji400_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apji400.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apji400_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "pjeald,pjea002,pjea003"
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
      LET l_sub_sql = " SELECT DISTINCT pjeald ",
                      ", pjea002 ",
                      ", pjea003 ",
 
                      " FROM pjea_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE pjeaent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pjea_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pjeald ",
                      ", pjea002 ",
                      ", pjea003 ",
 
                      " FROM pjea_t ",
                      " ",
                      " ", 
 
 
                      " WHERE pjeaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pjea_t")
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
      INITIALIZE g_pjea_m.* TO NULL
      CALL g_pjea_d.clear()        
      CALL g_pjea3_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pjeald,t0.pjea002,t0.pjea003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.pjeald,t0.pjea002,t0.pjea003",
                " FROM pjea_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.pjeaent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("pjea_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"pjea_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_pjeald,g_browser[g_cnt].b_pjea002,g_browser[g_cnt].b_pjea003  
 
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
   
   IF cl_null(g_browser[g_cnt].b_pjeald) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_pjea_m.* TO NULL
      CALL g_pjea_d.clear()
      CALL g_pjea3_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL apji400_fetch('')
   
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
 
{<section id="apji400.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apji400_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pjea_m.pjeald = g_browser[g_current_idx].b_pjeald   
   LET g_pjea_m.pjea002 = g_browser[g_current_idx].b_pjea002   
   LET g_pjea_m.pjea003 = g_browser[g_current_idx].b_pjea003   
 
   EXECUTE apji400_master_referesh USING g_pjea_m.pjeald,g_pjea_m.pjea002,g_pjea_m.pjea003 INTO g_pjea_m.pjeald, 
       g_pjea_m.pjea002,g_pjea_m.pjea003,g_pjea_m.pjeald_desc
   CALL apji400_show()
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apji400_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apji400_ui_browser_refresh()
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
      IF g_browser[l_i].b_pjeald = g_pjea_m.pjeald 
         AND g_browser[l_i].b_pjea002 = g_pjea_m.pjea002 
         AND g_browser[l_i].b_pjea003 = g_pjea_m.pjea003 
 
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
 
{<section id="apji400.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apji400_construct()
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
   INITIALIZE g_pjea_m.* TO NULL
   CALL g_pjea_d.clear()
   CALL g_pjea3_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON pjeald,pjea002,pjea003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.pjeald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjeald
            #add-point:ON ACTION controlp INFIELD pjeald name="construct.c.pjeald"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjeald  #顯示到畫面上
            NEXT FIELD pjeald                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeald
            #add-point:BEFORE FIELD pjeald name="construct.b.pjeald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjeald
            
            #add-point:AFTER FIELD pjeald name="construct.a.pjeald"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjea002
            #add-point:BEFORE FIELD pjea002 name="construct.b.pjea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjea002
            
            #add-point:AFTER FIELD pjea002 name="construct.a.pjea002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjea002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjea002
            #add-point:ON ACTION controlp INFIELD pjea002 name="construct.c.pjea002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjea003
            #add-point:BEFORE FIELD pjea003 name="construct.b.pjea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjea003
            
            #add-point:AFTER FIELD pjea003 name="construct.a.pjea003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjea003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjea003
            #add-point:ON ACTION controlp INFIELD pjea003 name="construct.c.pjea003"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON pjeastus,pjea005,pjea006,pjea004,pjea009,pjeaownid,pjeaowndp,pjeacrtid, 
          pjeacrtdp,pjeacrtdt,pjeamodid,pjeamoddt
           FROM s_detail1[1].pjeastus,s_detail1[1].pjea005,s_detail1[1].pjea006,s_detail1[1].pjea004, 
               s_detail1[1].pjea009,s_detail3[1].pjeaownid,s_detail3[1].pjeaowndp,s_detail3[1].pjeacrtid, 
               s_detail3[1].pjeacrtdp,s_detail3[1].pjeacrtdt,s_detail3[1].pjeamodid,s_detail3[1].pjeamoddt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pjeacrtdt>>----
         AFTER FIELD pjeacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pjeamoddt>>----
         AFTER FIELD pjeamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pjeacnfdt>>----
         
         #----<<pjeapstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeastus
            #add-point:BEFORE FIELD pjeastus name="construct.b.page1.pjeastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjeastus
            
            #add-point:AFTER FIELD pjeastus name="construct.a.page1.pjeastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjeastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjeastus
            #add-point:ON ACTION controlp INFIELD pjeastus name="construct.c.page1.pjeastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pjea005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjea005
            #add-point:ON ACTION controlp INFIELD pjea005 name="construct.c.page1.pjea005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 != '1' AND glac006 = '1' "
            CALL q_glac002_7()
            DISPLAY g_qryparam.return1 TO pjea005  #顯示到畫面上
            LET g_qryparam.where = NULL
            NEXT FIELD pjea005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjea005
            #add-point:BEFORE FIELD pjea005 name="construct.b.page1.pjea005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjea005
            
            #add-point:AFTER FIELD pjea005 name="construct.a.page1.pjea005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjea006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjea006
            #add-point:ON ACTION controlp INFIELD pjea006 name="construct.c.page1.pjea006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_71()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjea006  #顯示到畫面上
            NEXT FIELD pjea006                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjea006
            #add-point:BEFORE FIELD pjea006 name="construct.b.page1.pjea006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjea006
            
            #add-point:AFTER FIELD pjea006 name="construct.a.page1.pjea006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjea004
            #add-point:BEFORE FIELD pjea004 name="construct.b.page1.pjea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjea004
            
            #add-point:AFTER FIELD pjea004 name="construct.a.page1.pjea004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjea004
            #add-point:ON ACTION controlp INFIELD pjea004 name="construct.c.page1.pjea004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjea009
            #add-point:BEFORE FIELD pjea009 name="construct.b.page1.pjea009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjea009
            
            #add-point:AFTER FIELD pjea009 name="construct.a.page1.pjea009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjea009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjea009
            #add-point:ON ACTION controlp INFIELD pjea009 name="construct.c.page1.pjea009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.pjeaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjeaownid
            #add-point:ON ACTION controlp INFIELD pjeaownid name="construct.c.page3.pjeaownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjeaownid  #顯示到畫面上
            NEXT FIELD pjeaownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeaownid
            #add-point:BEFORE FIELD pjeaownid name="construct.b.page3.pjeaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjeaownid
            
            #add-point:AFTER FIELD pjeaownid name="construct.a.page3.pjeaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pjeaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjeaowndp
            #add-point:ON ACTION controlp INFIELD pjeaowndp name="construct.c.page3.pjeaowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjeaowndp  #顯示到畫面上
            NEXT FIELD pjeaowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeaowndp
            #add-point:BEFORE FIELD pjeaowndp name="construct.b.page3.pjeaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjeaowndp
            
            #add-point:AFTER FIELD pjeaowndp name="construct.a.page3.pjeaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pjeacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjeacrtid
            #add-point:ON ACTION controlp INFIELD pjeacrtid name="construct.c.page3.pjeacrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjeacrtid  #顯示到畫面上
            NEXT FIELD pjeacrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeacrtid
            #add-point:BEFORE FIELD pjeacrtid name="construct.b.page3.pjeacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjeacrtid
            
            #add-point:AFTER FIELD pjeacrtid name="construct.a.page3.pjeacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pjeacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjeacrtdp
            #add-point:ON ACTION controlp INFIELD pjeacrtdp name="construct.c.page3.pjeacrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjeacrtdp  #顯示到畫面上
            NEXT FIELD pjeacrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeacrtdp
            #add-point:BEFORE FIELD pjeacrtdp name="construct.b.page3.pjeacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjeacrtdp
            
            #add-point:AFTER FIELD pjeacrtdp name="construct.a.page3.pjeacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeacrtdt
            #add-point:BEFORE FIELD pjeacrtdt name="construct.b.page3.pjeacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.pjeamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjeamodid
            #add-point:ON ACTION controlp INFIELD pjeamodid name="construct.c.page3.pjeamodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjeamodid  #顯示到畫面上
            NEXT FIELD pjeamodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeamodid
            #add-point:BEFORE FIELD pjeamodid name="construct.b.page3.pjeamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjeamodid
            
            #add-point:AFTER FIELD pjeamodid name="construct.a.page3.pjeamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeamoddt
            #add-point:BEFORE FIELD pjeamoddt name="construct.b.page3.pjeamoddt"
            
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
 
{<section id="apji400.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apji400_query()
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
   CALL g_pjea_d.clear()
   CALL g_pjea3_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL apji400_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apji400_browser_fill(g_wc)
      CALL apji400_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL apji400_browser_fill("F")
   
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
      CALL apji400_fetch("F") 
   END IF
   
   CALL apji400_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apji400_fetch(p_flag)
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
   
   #CALL apji400_browser_fill(p_flag)
   
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
   
   LET g_pjea_m.pjeald = g_browser[g_current_idx].b_pjeald
   LET g_pjea_m.pjea002 = g_browser[g_current_idx].b_pjea002
   LET g_pjea_m.pjea003 = g_browser[g_current_idx].b_pjea003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apji400_master_referesh USING g_pjea_m.pjeald,g_pjea_m.pjea002,g_pjea_m.pjea003 INTO g_pjea_m.pjeald, 
       g_pjea_m.pjea002,g_pjea_m.pjea003,g_pjea_m.pjeald_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "pjea_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_pjea_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_pjea_m_mask_o.* =  g_pjea_m.*
   CALL apji400_pjea_t_mask()
   LET g_pjea_m_mask_n.* =  g_pjea_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apji400_set_act_visible()
   CALL apji400_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_pjea_m_t.* = g_pjea_m.*
   LET g_pjea_m_o.* = g_pjea_m.*
   
   #重新顯示   
   CALL apji400_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="apji400.insert" >}
#+ 資料新增
PRIVATE FUNCTION apji400_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_pjea_d.clear()
   CALL g_pjea3_d.clear()
 
 
   INITIALIZE g_pjea_m.* TO NULL             #DEFAULT 設定
   LET g_pjeald_t = NULL
   LET g_pjea002_t = NULL
   LET g_pjea003_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL apji400_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_pjea_m.* TO NULL
         INITIALIZE g_pjea_d TO NULL
         INITIALIZE g_pjea3_d TO NULL
 
         CALL apji400_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pjea_m.* = g_pjea_m_t.*
         CALL apji400_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_pjea_d.clear()
      #CALL g_pjea3_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apji400_set_act_visible()
   CALL apji400_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pjeald_t = g_pjea_m.pjeald
   LET g_pjea002_t = g_pjea_m.pjea002
   LET g_pjea003_t = g_pjea_m.pjea003
 
   
   #組合新增資料的條件
   LET g_add_browse = " pjeaent = " ||g_enterprise|| " AND",
                      " pjeald = '", g_pjea_m.pjeald, "' "
                      ," AND pjea002 = '", g_pjea_m.pjea002, "' "
                      ," AND pjea003 = '", g_pjea_m.pjea003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apji400_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL apji400_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apji400_master_referesh USING g_pjea_m.pjeald,g_pjea_m.pjea002,g_pjea_m.pjea003 INTO g_pjea_m.pjeald, 
       g_pjea_m.pjea002,g_pjea_m.pjea003,g_pjea_m.pjeald_desc
   
   #遮罩相關處理
   LET g_pjea_m_mask_o.* =  g_pjea_m.*
   CALL apji400_pjea_t_mask()
   LET g_pjea_m_mask_n.* =  g_pjea_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pjea_m.pjeald,g_pjea_m.pjeald_desc,g_pjea_m.pjea002,g_pjea_m.pjea003
   
   #功能已完成,通報訊息中心
   CALL apji400_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.modify" >}
#+ 資料修改
PRIVATE FUNCTION apji400_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_pjea_m.pjeald IS NULL
   OR g_pjea_m.pjea002 IS NULL
   OR g_pjea_m.pjea003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_pjeald_t = g_pjea_m.pjeald
   LET g_pjea002_t = g_pjea_m.pjea002
   LET g_pjea003_t = g_pjea_m.pjea003
 
   CALL s_transaction_begin()
   
   OPEN apji400_cl USING g_enterprise,g_pjea_m.pjeald,g_pjea_m.pjea002,g_pjea_m.pjea003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apji400_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE apji400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apji400_master_referesh USING g_pjea_m.pjeald,g_pjea_m.pjea002,g_pjea_m.pjea003 INTO g_pjea_m.pjeald, 
       g_pjea_m.pjea002,g_pjea_m.pjea003,g_pjea_m.pjeald_desc
   
   #遮罩相關處理
   LET g_pjea_m_mask_o.* =  g_pjea_m.*
   CALL apji400_pjea_t_mask()
   LET g_pjea_m_mask_n.* =  g_pjea_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL apji400_show()
   WHILE TRUE
      LET g_pjeald_t = g_pjea_m.pjeald
      LET g_pjea002_t = g_pjea_m.pjea002
      LET g_pjea003_t = g_pjea_m.pjea003
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL apji400_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pjea_m.* = g_pjea_m_t.*
         CALL apji400_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_pjea_m.pjeald != g_pjeald_t 
      OR g_pjea_m.pjea002 != g_pjea002_t 
      OR g_pjea_m.pjea003 != g_pjea003_t 
 
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
   CALL apji400_set_act_visible()
   CALL apji400_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pjeaent = " ||g_enterprise|| " AND",
                      " pjeald = '", g_pjea_m.pjeald, "' "
                      ," AND pjea002 = '", g_pjea_m.pjea002, "' "
                      ," AND pjea003 = '", g_pjea_m.pjea003, "' "
 
   #填到對應位置
   CALL apji400_browser_fill("")
 
   CALL apji400_idx_chk()
 
   CLOSE apji400_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apji400_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="apji400.input" >}
#+ 資料輸入
PRIVATE FUNCTION apji400_input(p_cmd)
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
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_pass                 LIKE type_t.num5
   DEFINE l_glac001              LIKE glac_t.glac001
   DEFINE l_glaa004_t            LIKE glaa_t.glaa004
   DEFINE l_glaa004              LIKE glaa_t.glaa004
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
   DISPLAY BY NAME g_pjea_m.pjeald,g_pjea_m.pjeald_desc,g_pjea_m.pjea002,g_pjea_m.pjea003
   
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
   LET g_forupd_sql = "SELECT pjeastus,pjea005,pjea006,pjea004,pjea009,pjea005,pjea006,pjeaownid,pjeaowndp, 
       pjeacrtid,pjeacrtdp,pjeacrtdt,pjeamodid,pjeamoddt FROM pjea_t WHERE pjeaent=? AND pjeald=? AND  
       pjea002=? AND pjea003=? AND pjea004=? AND pjea005=? AND pjea006=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apji400_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apji400_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apji400_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_pjea_m.pjeald,g_pjea_m.pjea002,g_pjea_m.pjea003
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apji400.input.head" >}
   
      #單頭段
      INPUT BY NAME g_pjea_m.pjeald,g_pjea_m.pjea002,g_pjea_m.pjea003 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            LET g_pjea_m.pjea002 = YEAR(g_today)
            LET g_pjea_m.pjea003 = MONTH(g_today)
            CALL s_ld_bookno()  RETURNING l_success,g_pjea_m.pjeald  #预设帐别编号：所在营运据点归属法人对应主账套编号 
            IF l_success = FALSE THEN
               LET g_pjea_m.pjeald =""
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjea_m.pjeald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent="||g_enterprise||" AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjea_m.pjeald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjea_m.pjeald_desc
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjeald
            
            #add-point:AFTER FIELD pjeald name="input.a.pjeald"
            IF NOT cl_null(g_pjea_m.pjeald) THEN 
               IF l_cmd_t = 'r' THEN
                  SELECT glaa004 INTO l_glaa004_t FROM glaa_t WHERE glaaent=g_enterprise AND glaald = g_pjea_m_t.pjeald
                  SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald = g_pjea_m.pjeald
                  IF l_glaa004_t != l_glaa004 THEN
                     LET g_pjea_m.pjeald = ''
                     LET g_pjea_m.pjeald_desc = ''
                     DISPLAY BY NAME g_pjea_m.pjeald_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00138'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD pjeald
                  END IF
               END IF
               IF NOT ap_chk_isExist(g_pjea_m.pjeald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00055',0) THEN
                  IF p_cmd = 'a' THEN
                     LET g_pjea_m.pjeald = ''
                     LET g_pjea_m.pjeald_desc = ''
                  ELSE
                     LET g_pjea_m.pjeald = g_pjea_m_t.pjeald
                     LET g_pjea_m.pjeald_desc = g_pjea_m_t.pjeald_desc
                  END IF
                  DISPLAY BY NAME g_pjea_m.pjeald_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_ld_chk_authorization(g_user,g_pjea_m.pjeald) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_pjea_m.pjeald
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  IF p_cmd = 'a' THEN
                     LET g_pjea_m.pjeald = ''
                     LET g_pjea_m.pjeald_desc = ''
                  ELSE
                     LET g_pjea_m.pjeald = g_pjea_m_t.pjeald
                     LET g_pjea_m.pjeald_desc = g_pjea_m_t.pjeald_desc
                  END IF
                  DISPLAY BY NAME g_pjea_m.pjeald_desc
                  NEXT FIELD CURRENT
               END IF
               SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjea_m.pjeald
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjea_m.pjeald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent="||g_enterprise||" AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjea_m.pjeald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjea_m.pjeald_desc

#            #應用 a05 樣板自動產生(Version:3)
#            #確認資料無重複
#            IF  NOT cl_null(g_pjea_m.pjeald) AND NOT cl_null(g_pjea_m.pjea002) AND NOT cl_null(g_pjea_m.pjea003) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjea_m.pjeald != g_pjeald_t  OR g_pjea_m.pjea002 != g_pjea002_t  OR g_pjea_m.pjea003 != g_pjea003_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjea_t WHERE "||"pjeaent = " ||g_enterprise|| " AND "||"pjeald = '"||g_pjea_m.pjeald ||"' AND "|| "pjea002 = '"||g_pjea_m.pjea002 ||"' AND "|| "pjea003 = '"||g_pjea_m.pjea003 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeald
            #add-point:BEFORE FIELD pjeald name="input.b.pjeald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjeald
            #add-point:ON CHANGE pjeald name="input.g.pjeald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjea002
            #add-point:BEFORE FIELD pjea002 name="input.b.pjea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjea002
            
            #add-point:AFTER FIELD pjea002 name="input.a.pjea002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  NOT cl_null(g_pjea_m.pjeald) AND NOT cl_null(g_pjea_m.pjea002) AND NOT cl_null(g_pjea_m.pjea003) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjea_m.pjeald != g_pjeald_t  OR g_pjea_m.pjea002 != g_pjea002_t  OR g_pjea_m.pjea003 != g_pjea003_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjea_t WHERE "||"pjeaent = " ||g_enterprise|| " AND "||"pjeald = '"||g_pjea_m.pjeald ||"' AND "|| "pjea002 = '"||g_pjea_m.pjea002 ||"' AND "|| "pjea003 = '"||g_pjea_m.pjea003 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            IF NOT cl_null(g_pjea_m.pjea002) THEN
                  IF g_pjea_m.pjea002 <1000 OR g_pjea_m.pjea002 >9999 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00113'
                     LET g_errparam.extend = g_pjea_m.pjea002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
   
                     LET g_pjea_m.pjea002 =''
                     NEXT FIELD pjea002
                  END IF
               END IF
            SELECT MAX(oogc006) INTO g_oogc006 FROM oogc_t
             WHERE oogcent = g_enterprise
               AND oogc001 = g_ooef008
               AND oogc002 = g_ooef009
               AND oogc015 = g_pjea_m.pjea002
            IF cl_null(g_oogc006) THEN LET g_oogc006 = 12 END IF 
            IF g_pjea_m.pjea003 > g_oogc006 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00844'
               LET g_errparam.extend = g_pjea_m.pjea003
               LET g_errparam.replace[1] =  g_oogc006
               LET g_errparam.popup = TRUE
               CALL cl_err()  
               LET g_pjea_m.pjea002 = g_pjea_m_t.pjea002 
               NEXT FIELD pjea002
               DISPLAY BY NAME g_pjea_m.pjea002                    
            END IF                  


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjea002
            #add-point:ON CHANGE pjea002 name="input.g.pjea002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjea003
            #add-point:BEFORE FIELD pjea003 name="input.b.pjea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjea003
            
            #add-point:AFTER FIELD pjea003 name="input.a.pjea003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  NOT cl_null(g_pjea_m.pjeald) AND NOT cl_null(g_pjea_m.pjea002) AND NOT cl_null(g_pjea_m.pjea003) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjea_m.pjeald != g_pjeald_t  OR g_pjea_m.pjea002 != g_pjea002_t  OR g_pjea_m.pjea003 != g_pjea003_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjea_t WHERE "||"pjeaent = " ||g_enterprise|| " AND "||"pjeald = '"||g_pjea_m.pjeald ||"' AND "|| "pjea002 = '"||g_pjea_m.pjea002 ||"' AND "|| "pjea003 = '"||g_pjea_m.pjea003 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            SELECT MAX(oogc006) INTO g_oogc006 FROM oogc_t
             WHERE oogcent = g_enterprise
               AND oogc001 = g_ooef008
               AND oogc002 = g_ooef009
               AND oogc015 = g_pjea_m.pjea002
            IF cl_null(g_oogc006) THEN LET g_oogc006 = 12 END IF 
            IF g_pjea_m.pjea003 > g_oogc006 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00844'
               LET g_errparam.extend = g_pjea_m.pjea003
               LET g_errparam.replace[1] =  g_oogc006
               LET g_errparam.popup = TRUE
               CALL cl_err()  
               LET g_pjea_m.pjea003 = g_pjea_m_t.pjea003 
               NEXT FIELD pjea003
               DISPLAY BY NAME g_pjea_m.pjea003                  
            END IF               



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjea003
            #add-point:ON CHANGE pjea003 name="input.g.pjea003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pjeald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjeald
            #add-point:ON ACTION controlp INFIELD pjeald name="input.c.pjeald"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_pjea_m.pjeald             #給予default值
            IF l_cmd_t = 'r' THEN
               LET g_qryparam.where = " glaa004 = '",l_glaa004_t,"'"
            ELSE
               LET g_qryparam.where = NULL
            END IF
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
 
            CALL q_authorised_ld()                                #呼叫開窗
 
            LET g_pjea_m.pjeald = g_qryparam.return1              #將開窗取得的值回傳到變數
 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjea_m.pjeald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjea_m.pjeald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjea_m.pjeald_desc
            LET g_qryparam.where = NULL
            DISPLAY g_pjea_m.pjeald TO pjeald              #顯示到畫面上

            NEXT FIELD pjeald                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.pjea002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjea002
            #add-point:ON ACTION controlp INFIELD pjea002 name="input.c.pjea002"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjea003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjea003
            #add-point:ON ACTION controlp INFIELD pjea003 name="input.c.pjea003"
            
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
            DISPLAY BY NAME g_pjea_m.pjeald             
                            ,g_pjea_m.pjea002   
                            ,g_pjea_m.pjea003   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_pjea_m.pjeald) AND NOT cl_null(g_pjea_m.pjea002) AND NOT cl_null(g_pjea_m.pjea003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjea_m.pjeald != g_pjeald_t  OR g_pjea_m.pjea002 != g_pjea002_t  OR g_pjea_m.pjea003 != g_pjea003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjea_t WHERE "||"pjeaent = " ||g_enterprise|| " AND "||"pjeald = '"||g_pjea_m.pjeald ||"' AND "|| "pjea002 = '"||g_pjea_m.pjea002 ||"' AND "|| "pjea003 = '"||g_pjea_m.pjea003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD pjeald
                  END IF
               END IF
            END IF
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL apji400_pjea_t_mask_restore('restore_mask_o')
            
               UPDATE pjea_t SET (pjeald,pjea002,pjea003) = (g_pjea_m.pjeald,g_pjea_m.pjea002,g_pjea_m.pjea003) 
 
                WHERE pjeaent = g_enterprise AND pjeald = g_pjeald_t
                  AND pjea002 = g_pjea002_t
                  AND pjea003 = g_pjea003_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pjea_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pjea_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pjea_m.pjeald
               LET gs_keys_bak[1] = g_pjeald_t
               LET gs_keys[2] = g_pjea_m.pjea002
               LET gs_keys_bak[2] = g_pjea002_t
               LET gs_keys[3] = g_pjea_m.pjea003
               LET gs_keys_bak[3] = g_pjea003_t
               LET gs_keys[4] = g_pjea_d[g_detail_idx].pjea004
               LET gs_keys_bak[4] = g_pjea_d_t.pjea004
               LET gs_keys[5] = g_pjea_d[g_detail_idx].pjea005
               LET gs_keys_bak[5] = g_pjea_d_t.pjea005
               LET gs_keys[6] = g_pjea_d[g_detail_idx].pjea006
               LET gs_keys_bak[6] = g_pjea_d_t.pjea006
               CALL apji400_update_b('pjea_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_pjea_m_t)
                     #LET g_log2 = util.JSON.stringify(g_pjea_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL apji400_pjea_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apji400_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_pjeald_t = g_pjea_m.pjeald
           LET g_pjea002_t = g_pjea_m.pjea002
           LET g_pjea003_t = g_pjea_m.pjea003
 
           
           IF g_pjea_d.getLength() = 0 THEN
              NEXT FIELD pjea004
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="apji400.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_pjea_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pjea_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apji400_b_fill(g_wc2) #test 
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
            CALL apji400_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN apji400_cl USING g_enterprise,g_pjea_m.pjeald,g_pjea_m.pjea002,g_pjea_m.pjea003                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE apji400_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN apji400_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_pjea_d[l_ac].pjea004 IS NOT NULL
               AND g_pjea_d[l_ac].pjea005 IS NOT NULL
               AND g_pjea_d[l_ac].pjea006 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pjea_d_t.* = g_pjea_d[l_ac].*  #BACKUP
               LET g_pjea_d_o.* = g_pjea_d[l_ac].*  #BACKUP
               CALL apji400_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL apji400_set_no_entry_b(l_cmd)
               OPEN apji400_bcl USING g_enterprise,g_pjea_m.pjeald,
                                                g_pjea_m.pjea002,
                                                g_pjea_m.pjea003,
 
                                                g_pjea_d_t.pjea004
                                                ,g_pjea_d_t.pjea005
                                                ,g_pjea_d_t.pjea006
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN apji400_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apji400_bcl INTO g_pjea_d[l_ac].pjeastus,g_pjea_d[l_ac].pjea005,g_pjea_d[l_ac].pjea006, 
                      g_pjea_d[l_ac].pjea004,g_pjea_d[l_ac].pjea009,g_pjea3_d[l_ac].pjea005,g_pjea3_d[l_ac].pjea006, 
                      g_pjea3_d[l_ac].pjeaownid,g_pjea3_d[l_ac].pjeaowndp,g_pjea3_d[l_ac].pjeacrtid, 
                      g_pjea3_d[l_ac].pjeacrtdp,g_pjea3_d[l_ac].pjeacrtdt,g_pjea3_d[l_ac].pjeamodid, 
                      g_pjea3_d[l_ac].pjeamoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_pjea_d_t.pjea004,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pjea_d_mask_o[l_ac].* =  g_pjea_d[l_ac].*
                  CALL apji400_pjea_t_mask()
                  LET g_pjea_d_mask_n[l_ac].* =  g_pjea_d[l_ac].*
                  
                  CALL apji400_ref_show()
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
            INITIALIZE g_pjea_d_t.* TO NULL
            INITIALIZE g_pjea_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pjea_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pjea3_d[l_ac].pjeaownid = g_user
      LET g_pjea3_d[l_ac].pjeaowndp = g_dept
      LET g_pjea3_d[l_ac].pjeacrtid = g_user
      LET g_pjea3_d[l_ac].pjeacrtdp = g_dept 
      LET g_pjea3_d[l_ac].pjeacrtdt = cl_get_current()
      LET g_pjea3_d[l_ac].pjeamodid = g_user
      LET g_pjea3_d[l_ac].pjeamoddt = cl_get_current()
      LET g_pjea_d[l_ac].pjeastus = ''
 
 
  
            #一般欄位預設值
                  LET g_pjea_d[l_ac].pjeastus = "Y"
      LET g_pjea_d[l_ac].pjea009 = "NULL"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            #项目编号pjea004 为预留，暂不启用，预设值给一个空格（因为是key不可为null）——后续若希望不同项目分摊不同范围的科目，可开启此栏位
            #比如A项目分摊001、002科目，B项目分摊002、003科目
            #分摊权数pjea009为预留，暂不启用，预设值NULL
            LET g_pjea_d[l_ac].pjea004 = " "       
            #end add-point
            LET g_pjea_d_t.* = g_pjea_d[l_ac].*     #新輸入資料
            LET g_pjea_d_o.* = g_pjea_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apji400_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL apji400_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pjea_d[li_reproduce_target].* = g_pjea_d[li_reproduce].*
               LET g_pjea3_d[li_reproduce_target].* = g_pjea3_d[li_reproduce].*
 
               LET g_pjea_d[g_pjea_d.getLength()].pjea004 = NULL
               LET g_pjea_d[g_pjea_d.getLength()].pjea005 = NULL
               LET g_pjea_d[g_pjea_d.getLength()].pjea006 = NULL
 
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
            IF cl_null(g_pjea_d[l_ac].pjea006) THEN
               LET g_pjea_d[l_ac].pjea006 = ' '
            END IF
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM pjea_t 
             WHERE pjeaent = g_enterprise AND pjeald = g_pjea_m.pjeald
               AND pjea002 = g_pjea_m.pjea002
               AND pjea003 = g_pjea_m.pjea003
 
               AND pjea004 = g_pjea_d[l_ac].pjea004
               AND pjea005 = g_pjea_d[l_ac].pjea005
               AND pjea006 = g_pjea_d[l_ac].pjea006
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO pjea_t
                           (pjeaent,
                            pjeald,pjea002,pjea003,
                            pjea004,pjea005,pjea006
                            ,pjeastus,pjea009,pjeaownid,pjeaowndp,pjeacrtid,pjeacrtdp,pjeacrtdt,pjeamodid,pjeamoddt) 
                     VALUES(g_enterprise,
                            g_pjea_m.pjeald,g_pjea_m.pjea002,g_pjea_m.pjea003,
                            g_pjea_d[l_ac].pjea004,g_pjea_d[l_ac].pjea005,g_pjea_d[l_ac].pjea006
                            ,g_pjea_d[l_ac].pjeastus,g_pjea_d[l_ac].pjea009,g_pjea3_d[l_ac].pjeaownid, 
                                g_pjea3_d[l_ac].pjeaowndp,g_pjea3_d[l_ac].pjeacrtid,g_pjea3_d[l_ac].pjeacrtdp, 
                                g_pjea3_d[l_ac].pjeacrtdt,g_pjea3_d[l_ac].pjeamodid,g_pjea3_d[l_ac].pjeamoddt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_pjea_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "pjea_t:",SQLERRMESSAGE 
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
               IF apji400_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_pjea_m.pjeald
                  LET gs_keys[gs_keys.getLength()+1] = g_pjea_m.pjea002
                  LET gs_keys[gs_keys.getLength()+1] = g_pjea_m.pjea003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pjea_d_t.pjea004
                  LET gs_keys[gs_keys.getLength()+1] = g_pjea_d_t.pjea005
                  LET gs_keys[gs_keys.getLength()+1] = g_pjea_d_t.pjea006
 
 
                  #刪除下層單身
                  IF NOT apji400_key_delete_b(gs_keys,'pjea_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE apji400_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE apji400_bcl
               LET l_count = g_pjea_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_pjea_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjea005
            
            #add-point:AFTER FIELD pjea005 name="input.a.page1.pjea005"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_pjea_m.pjeald IS NOT NULL AND g_pjea_m.pjea002 IS NOT NULL AND g_pjea_m.pjea003 IS NOT NULL AND g_pjea_d[g_detail_idx].pjea004 IS NOT NULL AND g_pjea_d[g_detail_idx].pjea005 IS NOT NULL AND g_pjea_d[g_detail_idx].pjea006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjea_m.pjeald != g_pjeald_t OR g_pjea_m.pjea002 != g_pjea002_t OR g_pjea_m.pjea003 != g_pjea003_t OR g_pjea_d[g_detail_idx].pjea004 != g_pjea_d_t.pjea004 OR g_pjea_d[g_detail_idx].pjea005 != g_pjea_d_t.pjea005 OR g_pjea_d[g_detail_idx].pjea006 != g_pjea_d_t.pjea006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjea_t WHERE "||"pjeaent = " ||g_enterprise|| " AND "||"pjeald = '"||g_pjea_m.pjeald ||"' AND "|| "pjea002 = '"||g_pjea_m.pjea002 ||"' AND "|| "pjea003 = '"||g_pjea_m.pjea003 ||"' AND "|| "pjea004 = '"||g_pjea_d[g_detail_idx].pjea004 ||"' AND "|| "pjea005 = '"||g_pjea_d[g_detail_idx].pjea005 ||"' AND "|| "pjea006 = '"||g_pjea_d[g_detail_idx].pjea006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF g_pjea_d[g_detail_idx].pjea005  <> g_pjea_d_t.pjea005 OR cl_null(g_pjea_d_t.pjea005) THEN
               IF NOT cl_null(g_pjea_d[g_detail_idx].pjea005) THEN 
                  LET l_sql = "AND glac007 = '6'"
                  IF  s_aglt310_getlike_lc_subject(g_pjea_m.pjeald,g_pjea_d[g_detail_idx].pjea005,l_sql) THEN
                     INITIALIZE g_qryparam.* TO NULL
                     SELECT glaa004 INTO l_glaa004
                       FROM glaa_t
                      WHERE glaaent = g_enterprise
                        AND glaald = g_pjea_m.pjeald
                     LET g_qryparam.state = 'i'
                     LET g_qryparam.reqry = 'FALSE'
                     LET g_qryparam.default1 = g_pjea_d[g_detail_idx].pjea005
                     
                     LET g_qryparam.arg1 = l_glaa004
                     LET g_qryparam.arg2 = g_pjea_d[g_detail_idx].pjea005
                     LET g_qryparam.arg3 = g_pjea_m.pjeald
                     LET g_qryparam.arg4 = "1 AND glac007 = '6'"
                     CALL q_glac002_6()
                     LET g_pjea_d[g_detail_idx].pjea005 = g_qryparam.return1
                     SELECT glacl004 INTO g_pjea_d[l_ac].l_pjea005_desc
                       FROM glacl_t 
                      WHERE glaclent = g_enterprise  AND glacl002 = g_pjea_d[l_ac].pjea005 AND glacl003 = g_dlang
                        AND glacl001 = l_glac001
                     DISPLAY g_pjea_d[l_ac].pjea005 TO pjea005             #顯示到畫面上
                     DISPLAY BY NAME g_pjea_d[l_ac].l_pjea005_desc
                
                  END IF
                  IF NOT s_aglt310_lc_subject(g_pjea_m.pjeald,g_pjea_d[g_detail_idx].pjea005,'N') THEN
                     LET g_pjea_d[g_detail_idx].pjea005 = g_pjea_d_t.pjea005
                     NEXT FIELD CURRENT 
                  END IF
                  #應用 a17 樣板自動產生(Version:2)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  SELECT UNIQUE glaa004 INTO l_glac001 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjea_m.pjeald
                  INITIALIZE g_chkparam.* TO NULL
   
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = l_glac001
                  LET g_chkparam.arg2 = g_pjea_d[g_detail_idx].pjea005
                  #160318-00025#8--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
                  #160318-00025#8--add--end  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_glac002_1") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     LET g_pjea_d[g_detail_idx].pjea005 = g_pjea_d_t.pjea005
                     NEXT FIELD CURRENT
                  END IF
                  SELECT glacl004 INTO g_pjea_d[g_detail_idx].l_pjea005_desc
                    FROM glacl_t 
                   WHERE glaclent = g_enterprise  AND glacl002 = g_pjea_d[g_detail_idx].pjea005 AND glacl003 = g_dlang
                     AND glacl001 = l_glac001
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjea005
            #add-point:BEFORE FIELD pjea005 name="input.b.page1.pjea005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjea005
            #add-point:ON CHANGE pjea005 name="input.g.page1.pjea005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjea006
            
            #add-point:AFTER FIELD pjea006 name="input.a.page1.pjea006"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_pjea_m.pjeald IS NOT NULL AND g_pjea_m.pjea002 IS NOT NULL AND g_pjea_m.pjea003 IS NOT NULL AND g_pjea_d[g_detail_idx].pjea004 IS NOT NULL AND g_pjea_d[g_detail_idx].pjea005 IS NOT NULL AND g_pjea_d[g_detail_idx].pjea006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjea_m.pjeald != g_pjeald_t OR g_pjea_m.pjea002 != g_pjea002_t OR g_pjea_m.pjea003 != g_pjea003_t OR g_pjea_d[g_detail_idx].pjea004 != g_pjea_d_t.pjea004 OR g_pjea_d[g_detail_idx].pjea005 != g_pjea_d_t.pjea005 OR g_pjea_d[g_detail_idx].pjea006 != g_pjea_d_t.pjea006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjea_t WHERE "||"pjeaent = " ||g_enterprise|| " AND "||"pjeald = '"||g_pjea_m.pjeald ||"' AND "|| "pjea002 = '"||g_pjea_m.pjea002 ||"' AND "|| "pjea003 = '"||g_pjea_m.pjea003 ||"' AND "|| "pjea004 = '"||g_pjea_d[g_detail_idx].pjea004 ||"' AND "|| "pjea005 = '"||g_pjea_d[g_detail_idx].pjea005 ||"' AND "|| "pjea006 = '"||g_pjea_d[g_detail_idx].pjea006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_pjea_d[l_ac].pjea006) THEN 
            #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjea_d[l_ac].pjea006
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#8--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_14") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_pjea_d[l_ac].pjea006 = g_pjea_d_t.pjea006
                  NEXT FIELD CURRENT
               END IF
               SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjea_m.pjeald
               IF NOT ap_chk_isExist(g_pjea_d[l_ac].pjea006,"SELECT COUNT(*) FROM ooeg_t,ooef_t WHERE ooegent = ooefent AND ooeg001 = ooef001 AND ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND (ooef017 = '"||g_glaacomp||"' OR ooef017 = 'ALL') AND ooegstus = 'Y' ","axc-00092",1 ) THEN  #fengmy150313
                   LET g_pjea_d[l_ac].pjea006 = ''
                   LET g_pjea_d[l_ac].pjea006_desc = ''
                   DISPLAY BY NAME g_pjea_d[l_ac].pjea006_desc
                   NEXT FIELD pjea006
               END IF

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjea_d[l_ac].pjea006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjea_d[l_ac].pjea006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjea_d[l_ac].pjea006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjea006
            #add-point:BEFORE FIELD pjea006 name="input.b.page1.pjea006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjea006
            #add-point:ON CHANGE pjea006 name="input.g.page1.pjea006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjea004
            #add-point:BEFORE FIELD pjea004 name="input.b.page1.pjea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjea004
            
            #add-point:AFTER FIELD pjea004 name="input.a.page1.pjea004"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_pjea_m.pjeald IS NOT NULL AND g_pjea_m.pjea002 IS NOT NULL AND g_pjea_m.pjea003 IS NOT NULL AND g_pjea_d[g_detail_idx].pjea004 IS NOT NULL AND g_pjea_d[g_detail_idx].pjea005 IS NOT NULL AND g_pjea_d[g_detail_idx].pjea006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjea_m.pjeald != g_pjeald_t OR g_pjea_m.pjea002 != g_pjea002_t OR g_pjea_m.pjea003 != g_pjea003_t OR g_pjea_d[g_detail_idx].pjea004 != g_pjea_d_t.pjea004 OR g_pjea_d[g_detail_idx].pjea005 != g_pjea_d_t.pjea005 OR g_pjea_d[g_detail_idx].pjea006 != g_pjea_d_t.pjea006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjea_t WHERE "||"pjeaent = " ||g_enterprise|| " AND "||"pjeald = '"||g_pjea_m.pjeald ||"' AND "|| "pjea002 = '"||g_pjea_m.pjea002 ||"' AND "|| "pjea003 = '"||g_pjea_m.pjea003 ||"' AND "|| "pjea004 = '"||g_pjea_d[g_detail_idx].pjea004 ||"' AND "|| "pjea005 = '"||g_pjea_d[g_detail_idx].pjea005 ||"' AND "|| "pjea006 = '"||g_pjea_d[g_detail_idx].pjea006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjea004
            #add-point:ON CHANGE pjea004 name="input.g.page1.pjea004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjea009
            #add-point:BEFORE FIELD pjea009 name="input.b.page1.pjea009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjea009
            
            #add-point:AFTER FIELD pjea009 name="input.a.page1.pjea009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjea009
            #add-point:ON CHANGE pjea009 name="input.g.page1.pjea009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pjea005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjea005
            #add-point:ON ACTION controlp INFIELD pjea005 name="input.c.page1.pjea005"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_pjea_d[l_ac].pjea005             #給予default值

            SELECT UNIQUE glaa004 INTO l_glac001 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjea_m.pjeald
            LET g_qryparam.where = " glac001 = '",l_glac001,"' AND glac003 != '1' AND glac006 = '1' AND glac007 = '6'",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_pjea_m.pjeald,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"

            CALL q_glac002_7()                                #呼叫開窗
 
            LET g_pjea_d[l_ac].pjea005 = g_qryparam.return1              
            #
            SELECT glacl004 INTO g_pjea_d[l_ac].l_pjea005_desc
              FROM glacl_t 
             WHERE glaclent = g_enterprise  
             AND glacl002 = g_pjea_d[l_ac].pjea005 
             AND glacl003 = g_dlang
             AND glacl001 = l_glac001
             
            DISPLAY g_pjea_d[l_ac].pjea005 TO pjea005             #顯示到畫面上
            DISPLAY BY NAME g_pjea_d[l_ac].l_pjea005_desc
            LET g_qryparam.where = NULL
            
            NEXT FIELD pjea005                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.pjea006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjea006
            #add-point:ON ACTION controlp INFIELD pjea006 name="input.c.page1.pjea006"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_pjea_d[l_ac].pjea006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaacomp

 
            CALL q_ooeg001_71()                                #呼叫開窗
 
            LET g_pjea_d[l_ac].pjea006 = g_qryparam.return1              
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjea_d[l_ac].pjea006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjea_d[l_ac].pjea006_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_pjea_d[l_ac].pjea006 TO pjea006             
            DISPLAY g_pjea_d[l_ac].pjea006_desc TO pjea006_desc              #

            NEXT FIELD pjea006                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.pjea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjea004
            #add-point:ON ACTION controlp INFIELD pjea004 name="input.c.page1.pjea004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjea009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjea009
            #add-point:ON ACTION controlp INFIELD pjea009 name="input.c.page1.pjea009"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pjea_d[l_ac].* = g_pjea_d_t.*
               CLOSE apji400_bcl
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
               LET g_errparam.extend = g_pjea_d[l_ac].pjea004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_pjea_d[l_ac].* = g_pjea_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_pjea3_d[l_ac].pjeamodid = g_user 
LET g_pjea3_d[l_ac].pjeamoddt = cl_get_current()
LET g_pjea3_d[l_ac].pjeamodid_desc = cl_get_username(g_pjea3_d[l_ac].pjeamodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               IF cl_null(g_pjea_d[l_ac].pjea006) THEN
                  LET g_pjea_d[l_ac].pjea006 = ' '
               END IF
               #end add-point
         
               #將遮罩欄位還原
               CALL apji400_pjea_t_mask_restore('restore_mask_o')
         
               UPDATE pjea_t SET (pjeald,pjea002,pjea003,pjeastus,pjea005,pjea006,pjea004,pjea009,pjeaownid, 
                   pjeaowndp,pjeacrtid,pjeacrtdp,pjeacrtdt,pjeamodid,pjeamoddt) = (g_pjea_m.pjeald,g_pjea_m.pjea002, 
                   g_pjea_m.pjea003,g_pjea_d[l_ac].pjeastus,g_pjea_d[l_ac].pjea005,g_pjea_d[l_ac].pjea006, 
                   g_pjea_d[l_ac].pjea004,g_pjea_d[l_ac].pjea009,g_pjea3_d[l_ac].pjeaownid,g_pjea3_d[l_ac].pjeaowndp, 
                   g_pjea3_d[l_ac].pjeacrtid,g_pjea3_d[l_ac].pjeacrtdp,g_pjea3_d[l_ac].pjeacrtdt,g_pjea3_d[l_ac].pjeamodid, 
                   g_pjea3_d[l_ac].pjeamoddt)
                WHERE pjeaent = g_enterprise AND pjeald = g_pjea_m.pjeald 
                 AND pjea002 = g_pjea_m.pjea002 
                 AND pjea003 = g_pjea_m.pjea003 
 
                 AND pjea004 = g_pjea_d_t.pjea004 #項次   
                 AND pjea005 = g_pjea_d_t.pjea005  
                 AND pjea006 = g_pjea_d_t.pjea006  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pjea_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "pjea_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pjea_m.pjeald
               LET gs_keys_bak[1] = g_pjeald_t
               LET gs_keys[2] = g_pjea_m.pjea002
               LET gs_keys_bak[2] = g_pjea002_t
               LET gs_keys[3] = g_pjea_m.pjea003
               LET gs_keys_bak[3] = g_pjea003_t
               LET gs_keys[4] = g_pjea_d[g_detail_idx].pjea004
               LET gs_keys_bak[4] = g_pjea_d_t.pjea004
               LET gs_keys[5] = g_pjea_d[g_detail_idx].pjea005
               LET gs_keys_bak[5] = g_pjea_d_t.pjea005
               LET gs_keys[6] = g_pjea_d[g_detail_idx].pjea006
               LET gs_keys_bak[6] = g_pjea_d_t.pjea006
               CALL apji400_update_b('pjea_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_pjea_m),util.JSON.stringify(g_pjea_d_t)
                     LET g_log2 = util.JSON.stringify(g_pjea_m),util.JSON.stringify(g_pjea_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL apji400_pjea_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_pjea_m.pjeald
               LET ls_keys[ls_keys.getLength()+1] = g_pjea_m.pjea002
               LET ls_keys[ls_keys.getLength()+1] = g_pjea_m.pjea003
 
               LET ls_keys[ls_keys.getLength()+1] = g_pjea_d_t.pjea004
               LET ls_keys[ls_keys.getLength()+1] = g_pjea_d_t.pjea005
               LET ls_keys[ls_keys.getLength()+1] = g_pjea_d_t.pjea006
 
               CALL apji400_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE apji400_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pjea_d[l_ac].* = g_pjea_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE apji400_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_pjea_d.getLength() = 0 THEN
               NEXT FIELD pjea004
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_pjea_d[li_reproduce_target].* = g_pjea_d[li_reproduce].*
               LET g_pjea3_d[li_reproduce_target].* = g_pjea3_d[li_reproduce].*
 
               LET g_pjea_d[li_reproduce_target].pjea004 = NULL
               LET g_pjea_d[li_reproduce_target].pjea005 = NULL
               LET g_pjea_d[li_reproduce_target].pjea006 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pjea_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pjea_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_pjea3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL apji400_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL apji400_idx_chk()
            CALL apji400_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body3.action"
         
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
         CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD pjeald
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pjeastus
               WHEN "s_detail3"
                  NEXT FIELD pjea005_2
 
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
   CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apji400_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL apji400_b_fill(g_wc2) #第一階單身填充
      CALL apji400_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apji400_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_pjea_m.pjeald,g_pjea_m.pjeald_desc,g_pjea_m.pjea002,g_pjea_m.pjea003
 
   CALL apji400_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION apji400_ref_show()
   #add-point:ref_show段define name="ref_show.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ref_show.define"
   DEFINE l_glac001     LIKE glac_t.glac001
   #end add-point
   
   #add-point:Function前置處理  name="ref_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference name="ref_show.head.reference"
   #帐套
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjea_m.pjeald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjea_m.pjeald_desc=g_rtn_fields[1]
   DISPLAY g_pjea_m.pjeald_desc TO pjeald_desc
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_pjea_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      #会计科目说明
      SELECT UNIQUE glaa004 INTO l_glac001 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjea_m.pjeald
      SELECT glacl004 INTO g_pjea_d[l_ac].l_pjea005_desc
        FROM glacl_t 
       WHERE glaclent = g_enterprise  AND glacl002 = g_pjea_d[l_ac].pjea005 AND glacl003 = g_dlang
       AND glacl001 = l_glac001
      #部门说明
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_pjea_d[l_ac].pjea006
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_pjea_d[l_ac].pjea006_desc = '', g_rtn_fields[1] , ''
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_pjea3_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body3.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="apji400.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apji400_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE pjea_t.pjeald 
   DEFINE l_oldno     LIKE pjea_t.pjeald 
   DEFINE l_newno02     LIKE pjea_t.pjea002 
   DEFINE l_oldno02     LIKE pjea_t.pjea002 
   DEFINE l_newno03     LIKE pjea_t.pjea003 
   DEFINE l_oldno03     LIKE pjea_t.pjea003 
 
   DEFINE l_master    RECORD LIKE pjea_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pjea_t.* #此變數樣板目前無使用
 
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
 
   IF g_pjea_m.pjeald IS NULL
      OR g_pjea_m.pjea002 IS NULL
      OR g_pjea_m.pjea003 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_pjeald_t = g_pjea_m.pjeald
   LET g_pjea002_t = g_pjea_m.pjea002
   LET g_pjea003_t = g_pjea_m.pjea003
 
   
   LET g_pjea_m.pjeald = ""
   LET g_pjea_m.pjea002 = ""
   LET g_pjea_m.pjea003 = ""
 
   LET g_master_insert = FALSE
   CALL apji400_set_entry('a')
   CALL apji400_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_pjea_m.pjeald_desc = ''
   DISPLAY BY NAME g_pjea_m.pjeald_desc
 
   
   CALL apji400_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_pjea_m.* TO NULL
      INITIALIZE g_pjea_d TO NULL
      INITIALIZE g_pjea3_d TO NULL
 
      CALL apji400_show()
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
   CALL apji400_set_act_visible()
   CALL apji400_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pjeald_t = g_pjea_m.pjeald
   LET g_pjea002_t = g_pjea_m.pjea002
   LET g_pjea003_t = g_pjea_m.pjea003
 
   
   #組合新增資料的條件
   LET g_add_browse = " pjeaent = " ||g_enterprise|| " AND",
                      " pjeald = '", g_pjea_m.pjeald, "' "
                      ," AND pjea002 = '", g_pjea_m.pjea002, "' "
                      ," AND pjea003 = '", g_pjea_m.pjea003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apji400_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL apji400_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL apji400_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apji400_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pjea_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apji400_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pjea_t
    WHERE pjeaent = g_enterprise AND pjeald = g_pjeald_t
    AND pjea002 = g_pjea002_t
    AND pjea003 = g_pjea003_t
 
       INTO TEMP apji400_detail
   
   #將key修正為調整後   
   UPDATE apji400_detail 
      #更新key欄位
      SET pjeald = g_pjea_m.pjeald
          , pjea002 = g_pjea_m.pjea002
          , pjea003 = g_pjea_m.pjea003
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , pjeaownid = g_user 
       , pjeaowndp = g_dept
       , pjeacrtid = g_user
       , pjeacrtdp = g_dept 
       , pjeacrtdt = ld_date
       , pjeamodid = g_user
       , pjeamoddt = ld_date
      #, pjeastus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO pjea_t SELECT * FROM apji400_detail
   
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
   DROP TABLE apji400_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pjeald_t = g_pjea_m.pjeald
   LET g_pjea002_t = g_pjea_m.pjea002
   LET g_pjea003_t = g_pjea_m.pjea003
 
   
   DROP TABLE apji400_detail
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apji400_delete()
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
   
   IF g_pjea_m.pjeald IS NULL
   OR g_pjea_m.pjea002 IS NULL
   OR g_pjea_m.pjea003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN apji400_cl USING g_enterprise,g_pjea_m.pjeald,g_pjea_m.pjea002,g_pjea_m.pjea003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apji400_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE apji400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apji400_master_referesh USING g_pjea_m.pjeald,g_pjea_m.pjea002,g_pjea_m.pjea003 INTO g_pjea_m.pjeald, 
       g_pjea_m.pjea002,g_pjea_m.pjea003,g_pjea_m.pjeald_desc
   
   #遮罩相關處理
   LET g_pjea_m_mask_o.* =  g_pjea_m.*
   CALL apji400_pjea_t_mask()
   LET g_pjea_m_mask_n.* =  g_pjea_m.*
   
   CALL apji400_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apji400_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM pjea_t WHERE pjeaent = g_enterprise AND pjeald = g_pjea_m.pjeald
                                                               AND pjea002 = g_pjea_m.pjea002
                                                               AND pjea003 = g_pjea_m.pjea003
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pjea_t:",SQLERRMESSAGE 
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
      #   CLOSE apji400_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_pjea_d.clear() 
      CALL g_pjea3_d.clear()       
 
     
      CALL apji400_ui_browser_refresh()  
      #CALL apji400_ui_headershow()  
      #CALL apji400_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL apji400_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL apji400_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE apji400_cl
 
   #功能已完成,通報訊息中心
   CALL apji400_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apji400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apji400_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_pjea_d.clear()
   CALL g_pjea3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT pjeastus,pjea005,pjea006,pjea004,pjea009,pjea005,pjea006,pjeaownid, 
       pjeaowndp,pjeacrtid,pjeacrtdp,pjeacrtdt,pjeamodid,pjeamoddt,t1.ooefl004 ,t2.ooag011 ,t3.ooefl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 FROM pjea_t",   
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=pjea006 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=pjeaownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=pjeaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=pjeacrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=pjeacrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=pjeamodid  ",
 
               " WHERE pjeaent= ? AND pjeald=? AND pjea002=? AND pjea003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("pjea_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  DISTINCT pjeastus,pjea005,pjea006,pjea004,pjea009,pjea005,pjea006,pjeaownid, 
       pjeaowndp,pjeacrtid,pjeacrtdp,pjeacrtdt,pjeamodid,pjeamoddt,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 FROM pjea_t",   
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=pjea006 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=pjeaownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=pjeaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=pjeacrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=pjeacrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=pjeamodid  ",
 
               " WHERE pjeaent= ? AND pjeald=? AND pjea002=? AND pjea003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("pjea_t")
   END IF
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF apji400_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY pjea_t.pjea004,pjea_t.pjea005,pjea_t.pjea006"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apji400_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apji400_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pjea_m.pjeald,g_pjea_m.pjea002,g_pjea_m.pjea003   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pjea_m.pjeald,g_pjea_m.pjea002,g_pjea_m.pjea003 INTO g_pjea_d[l_ac].pjeastus, 
          g_pjea_d[l_ac].pjea005,g_pjea_d[l_ac].pjea006,g_pjea_d[l_ac].pjea004,g_pjea_d[l_ac].pjea009, 
          g_pjea3_d[l_ac].pjea005,g_pjea3_d[l_ac].pjea006,g_pjea3_d[l_ac].pjeaownid,g_pjea3_d[l_ac].pjeaowndp, 
          g_pjea3_d[l_ac].pjeacrtid,g_pjea3_d[l_ac].pjeacrtdp,g_pjea3_d[l_ac].pjeacrtdt,g_pjea3_d[l_ac].pjeamodid, 
          g_pjea3_d[l_ac].pjeamoddt,g_pjea_d[l_ac].pjea006_desc,g_pjea3_d[l_ac].pjeaownid_desc,g_pjea3_d[l_ac].pjeaowndp_desc, 
          g_pjea3_d[l_ac].pjeacrtid_desc,g_pjea3_d[l_ac].pjeacrtdp_desc,g_pjea3_d[l_ac].pjeamodid_desc  
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
 
            CALL g_pjea_d.deleteElement(g_pjea_d.getLength())
      CALL g_pjea3_d.deleteElement(g_pjea3_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_pjea_d.getLength()
      LET g_pjea_d_mask_o[l_ac].* =  g_pjea_d[l_ac].*
      CALL apji400_pjea_t_mask()
      LET g_pjea_d_mask_n[l_ac].* =  g_pjea_d[l_ac].*
   END FOR
   
   LET g_pjea3_d_mask_o.* =  g_pjea3_d.*
   FOR l_ac = 1 TO g_pjea3_d.getLength()
      LET g_pjea3_d_mask_o[l_ac].* =  g_pjea3_d[l_ac].*
      CALL apji400_pjea_t_mask()
      LET g_pjea3_d_mask_n[l_ac].* =  g_pjea3_d[l_ac].*
   END FOR
 
 
   FREE apji400_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apji400_idx_chk()
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
      IF g_detail_idx > g_pjea_d.getLength() THEN
         LET g_detail_idx = g_pjea_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_pjea_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pjea_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_pjea3_d.getLength() THEN
         LET g_detail_idx = g_pjea3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pjea3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pjea3_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apji400_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_pjea_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION apji400_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM pjea_t
    WHERE pjeaent = g_enterprise AND pjeald = g_pjea_m.pjeald AND
                              pjea002 = g_pjea_m.pjea002 AND
                              pjea003 = g_pjea_m.pjea003 AND
 
          pjea004 = g_pjea_d_t.pjea004
      AND pjea005 = g_pjea_d_t.pjea005
      AND pjea006 = g_pjea_d_t.pjea006
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "pjea_t:",SQLERRMESSAGE 
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
 
{<section id="apji400.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apji400_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="apji400.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apji400_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="apji400.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apji400_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="apji400.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION apji400_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_pjea_d[l_ac].pjea004 = g_pjea_d_t.pjea004 
      AND g_pjea_d[l_ac].pjea005 = g_pjea_d_t.pjea005 
      AND g_pjea_d[l_ac].pjea006 = g_pjea_d_t.pjea006 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apji400_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apji400.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apji400_lock_b(ps_table,ps_page)
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
   #CALL apji400_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apji400.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apji400_unlock_b(ps_table,ps_page)
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
 
{<section id="apji400.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apji400_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pjeald,pjea002,pjea003",TRUE)
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
 
{<section id="apji400.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apji400_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pjeald,pjea002,pjea003",FALSE)
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
 
{<section id="apji400.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apji400_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apji400_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   CALL cl_set_comp_required('pjea006',FALSE)
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apji400_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apji400.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apji400_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apji400.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apji400_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apji400.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apji400_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apji400.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apji400_default_search()
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
      LET ls_wc = ls_wc, " pjeald = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " pjea002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " pjea003 = '", g_argv[03], "' AND "
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
 
{<section id="apji400.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apji400_fill_chk(ps_idx)
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
 
{<section id="apji400.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION apji400_modify_detail_chk(ps_record)
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
         LET ls_return = "pjeastus"
      WHEN "s_detail3"
         LET ls_return = "pjea005_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="apji400.mask_functions" >}
&include "erp/apj/apji400_mask.4gl"
 
{</section>}
 
{<section id="apji400.state_change" >}
    
 
{</section>}
 
{<section id="apji400.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apji400_set_pk_array()
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
   LET g_pk_array[1].values = g_pjea_m.pjeald
   LET g_pk_array[1].column = 'pjeald'
   LET g_pk_array[2].values = g_pjea_m.pjea002
   LET g_pk_array[2].column = 'pjea002'
   LET g_pk_array[3].values = g_pjea_m.pjea003
   LET g_pk_array[3].column = 'pjea003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apji400.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apji400_msgcentre_notify(lc_state)
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
   CALL apji400_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pjea_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apji400.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 整批生成
################################################################################
PRIVATE FUNCTION apji400_s01()
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_str           STRING 
   DEFINE lwin_curr       ui.Window
   DEFINE lfrm_curr       ui.Form
   DEFINE ls_path   STRING
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_wc           STRING
   DEFINE l_wc1          STRING
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_apji400_s01 WITH FORM cl_ap_formpath("apj","apji400_s01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   LET g_qryparam.state = "i"
   WHILE TRUE 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT BY NAME g_pjea_s.pjeald,g_pjea_s.pjea002,g_pjea_s.pjea003
         ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               LET g_pjea_s.pjea002 = YEAR(g_today)       #预设年度：现行年度
               LET g_pjea_s.pjea003 = MONTH(g_today)       #预设期别：现行期别
               CALL s_ld_bookno()  RETURNING l_success,g_pjea_s.pjeald  #预设帐别编号：所在营运据点归属法人对应主账套编号 
               IF l_success = FALSE THEN
                  LET g_pjea_s.pjeald =""
               END IF 
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_pjea_s.pjeald
               CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_pjea_s.pjeald_desc=g_rtn_fields[1]
               DISPLAY g_pjea_s.pjeald_desc TO pjeald_desc
   
            #應用 a02 樣板自動產生(Version:1)
            AFTER FIELD pjeald
               
               #add-point:AFTER FIELD pjeald
               IF NOT cl_null(g_pjea_s.pjeald) THEN 
               #應用 a17 樣板自動產生(Version:2)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pjea_s.pjeald
                  #160318-00025#8--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
                  #160318-00025#8--add--end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_glaald") THEN
                     #檢查成功時後續處理
                     SELECT glaa004,glaacomp INTO g_pjea_s.glaa004,g_pjea_s.l_comp
                        FROM glaa_t
                       WHERE glaaent = g_enterprise
                         AND glaald  = g_pjea_s.pjeald
                         AND glaastus = 'Y'
                         AND (glaa008  = 'Y' OR glaa014 ='Y')
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF 
   
            #應用 a02 樣板自動產生(Version:1)
            AFTER FIELD pjea002
               #應用 a15 樣板自動產生(Version:2)
               #確認欄位值在特定區間內
               IF NOT cl_null(g_pjea_s.pjea002) THEN
                  IF g_pjea_s.pjea002 <1000 OR g_pjea_s.pjea002 >9999 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00113'
                     LET g_errparam.extend = g_pjea_s.pjea002
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
   
                     LET g_pjea_s.pjea002 =''
                     NEXT FIELD pjea002
                  END IF
               END IF
               SELECT MAX(oogc006) INTO g_oogc006 FROM oogc_t
                WHERE oogcent = g_enterprise
                  AND oogc001 = g_ooef008
                  AND oogc002 = g_ooef009
                  AND oogc015 = g_pjea_s.pjea002
               IF cl_null(g_oogc006) THEN LET g_oogc006 = 12 END IF 
               IF g_pjea_s.pjea003 > g_oogc006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00844'
                  LET g_errparam.extend = g_pjea_s.pjea003
                  LET g_errparam.replace[1] =  g_oogc006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  LET g_pjea_s.pjea002 = ''
                  NEXT FIELD pjea002
                  DISPLAY BY NAME g_pjea_s.pjea002                    
               END IF   
    
            #應用 a02 樣板自動產生(Version:1)
            AFTER FIELD pjea003
               #應用 a15 樣板自動產生(Version:2)
               #確認欄位值在特定區間內
               SELECT MAX(oogc006) INTO g_oogc006 FROM oogc_t
                WHERE oogcent = g_enterprise
                  AND oogc001 = g_ooef008
                  AND oogc002 = g_ooef009
                  AND oogc015 = g_pjea_s.pjea002
               IF cl_null(g_oogc006) THEN LET g_oogc006 = 12 END IF 
               IF g_pjea_s.pjea003 > g_oogc006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00844'
                  LET g_errparam.extend = g_pjea_s.pjea003
                  LET g_errparam.replace[1] =  g_oogc006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  LET g_pjea_s.pjea002 = ''
                  NEXT FIELD pjea002
                  DISPLAY BY NAME g_pjea_s.pjea002                    
               END IF   
            
            #Ctrlp:input.c.pjeald
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD pjeald
               #add-point:ON ACTION controlp INFIELD pjeald
               #應用 a07 樣板自動產生(Version:2)   
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_pjea_s.pjeald             #給予default值
               #給予arg
               LET g_qryparam.arg1 = "" #
               CALL q_glaa()                                #呼叫開窗
               LET g_pjea_s.pjeald = g_qryparam.return1        
               DISPLAY g_pjea_s.pjeald TO pjeald              #
               NEXT FIELD pjeald                          #返回原欄位
    
            #Ctrlp:input.c.pjea002
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD pjea002
               
            #Ctrlp:input.c.pjea003
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD pjea003
               
            AFTER INPUT
            
         END INPUT
             
         CONSTRUCT BY NAME l_wc ON pjea006
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
               
            #----<<pjea006>>----
            #Ctrlp:construct.c.page1.pjea006
            ON ACTION controlp INFIELD pjea006
               #add-point:ON ACTION controlp INFIELD pjea006
               #此段落由子樣板a08產生
               #開窗c段
   			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   			   LET g_qryparam.reqry = FALSE
   			   LET g_qryparam.arg1 = g_glaacomp
#   			   LET g_qryparam.where = " (ooef017 = '",g_pjea_s.l_comp,"' OR ooef017 = 'ALL') " 
               CALL q_ooeg001_71()                           
               DISPLAY g_qryparam.return1 TO pjea006  #顯示到畫面上
   
               NEXT FIELD pjea006                     #返回原欄位
               
         END CONSTRUCT
         
         CONSTRUCT BY NAME l_wc1 ON pjea005
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
               
            ON ACTION controlp INFIELD pjea005
               #add-point:ON ACTION controlp INFIELD pjea005
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " glac003 != '1' AND glac006 = '1' "
   
               #給予arg
               CALL q_glac002_7()
               DISPLAY g_qryparam.return1 TO pjea005  #顯示到畫面上
               NEXT FIELD pjea005 
         END CONSTRUCT  
             
         ON ACTION accept
            CALL apji400_ins_pjea_s01(l_wc,l_wc1)
             
            ACCEPT DIALOG
            
         ON ACTION cancel
            LET INT_FLAG = TRUE 
            EXIT DIALOG
       
         ON ACTION close
            LET INT_FLAG = TRUE 
            EXIT DIALOG
                
         ON ACTION exit
            LET INT_FLAG = TRUE 
            EXIT DIALOG
       
          #交談指令共用ACTION
          &include "common_action.4gl" 
             CONTINUE DIALOG 
       END DIALOG
       IF INT_FLAG THEN
          EXIT WHILE
       END IF
   END WHILE 
   
   #畫面關閉
   CLOSE WINDOW w_apji400_s01
END FUNCTION

################################################################################
# Descriptions...: 整批复制
################################################################################
PRIVATE FUNCTION apji400_s02()
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_glaa004     LIKE glaa_t.glaa004
   DEFINE l_glaa004_1   LIKE glaa_t.glaa004
   
   OPEN WINDOW w_apji400_s02 WITH FORM cl_ap_formpath("apj","apji400_s02")
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_pjea2_s.l_pjeald_b,g_pjea2_s.l_pjea002_b,g_pjea2_s.l_pjea003_b,g_pjea2_s.l_pjeald_e,g_pjea2_s.l_pjea002_e,g_pjea2_s.l_pjea003_e
         BEFORE INPUT
           SELECT glaald INTO g_pjea2_s.l_pjeald_b FROM glaa_t
            WHERE glaaent = g_enterprise AND glaa014 = 'Y' 
              AND glaacomp = (SELECT UNIQUE ooef017 FROM ooef_t where ooefent = g_enterprise AND ooef001 = g_site)
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_pjea2_s.l_pjeald_b
           CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
           LET g_pjea2_s.l_pjeald_b_desc = '', g_rtn_fields[1] , ''
           DISPLAY BY NAME g_pjea2_s.l_pjeald_b_desc
           DISPLAY BY NAME g_pjea2_s.l_pjeald_b
           
           LET g_pjea2_s.l_pjea002_b = YEAR(g_today)       #预设年度：现行年度
           LET g_pjea2_s.l_pjea003_b = MONTH(g_today)       #预设期别：现行期别
           SELECT glaald INTO g_pjea2_s.l_pjeald_e FROM glaa_t
            WHERE glaaent = g_enterprise AND glaa014 = 'Y' 
              AND glaacomp = (SELECT UNIQUE ooef017 FROM ooef_t where ooefent = g_enterprise AND ooef001 = g_site)
              
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_pjea2_s.l_pjeald_e
           CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
           LET g_pjea2_s.l_pjeald_e_desc = '', g_rtn_fields[1] , ''    
           DISPLAY BY NAME g_pjea2_s.l_pjeald_e,g_pjea2_s.l_pjeald_e_desc,g_pjea2_s.l_pjea002_e,g_pjea2_s.l_pjea003_e
           
         AFTER FIELD l_pjeald_b
            IF NOT cl_null(g_pjea2_s.l_pjeald_b) THEN
               IF NOT ap_chk_isExist(g_pjea2_s.l_pjeald_b,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00055',0) THEN
                  LET g_pjea2_s.l_pjeald_b = ''
                  LET g_pjea2_s.l_pjeald_b_desc = ''
                  DISPLAY BY NAME g_pjea2_s.l_pjeald_b_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_isExist(g_pjea2_s.l_pjeald_b,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'sub-01302',"agli010") THEN  #agl-00051 #160318-00005#33 by 07900 --mod 
                  LET g_pjea2_s.l_pjeald_b = ''
                  LET g_pjea2_s.l_pjeald_b_desc = ''
                  DISPLAY BY NAME g_pjea2_s.l_pjeald_b_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_ld_chk_authorization(g_user,g_pjea2_s.l_pjeald_b) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_pjea_m.pjeald
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pjea2_s.l_pjeald_b = ''
                  LET g_pjea2_s.l_pjeald_b_desc = ''
                  DISPLAY BY NAME g_pjea2_s.l_pjeald_b_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT apji400_pjeald_pjea002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjea2_s.l_pjeald_b
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjea2_s.l_pjeald_b_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjea2_s.l_pjeald_b_desc

         AFTER FIELD l_pjea002_b
            IF NOT cl_null(g_pjea2_s.l_pjea002_b) THEN
               IF g_pjea2_s.l_pjea002_b <1000 OR g_pjea2_s.l_pjea002_b >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_pjea2_s.l_pjea002_b
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_pjea2_s.l_pjea002_b =''
                  NEXT FIELD l_pjea002_b
               END IF
               SELECT MAX(oogc006) INTO g_oogc006 FROM oogc_t
                WHERE oogcent = g_enterprise
                  AND oogc001 = g_ooef008
                  AND oogc002 = g_ooef009
                  AND oogc015 = g_pjea2_s.l_pjea002_b
               IF cl_null(g_oogc006) THEN LET g_oogc006 = 12 END IF 
               IF g_pjea2_s.l_pjea003_b > g_oogc006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00844'
                  LET g_errparam.extend = g_pjea2_s.l_pjea003_b
                  LET g_errparam.replace[1] =  g_oogc006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  LET g_pjea2_s.l_pjea002_b = ''
                  NEXT FIELD l_pjea002_b
                  DISPLAY BY NAME g_pjea2_s.l_pjea002_b                    
               END IF   
               IF NOT apji400_pjeald_pjea002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF

         AFTER FIELD l_pjea003_b
            IF NOT cl_null(g_pjea2_s.l_pjea003_b) THEN
               SELECT MAX(oogc006) INTO g_oogc006 FROM oogc_t
                WHERE oogcent = g_enterprise
                  AND oogc001 = g_ooef008
                  AND oogc002 = g_ooef009
                  AND oogc015 = g_pjea2_s.l_pjea002_b
               IF cl_null(g_oogc006) THEN LET g_oogc006 = 12 END IF 
               IF g_pjea2_s.l_pjea003_b > g_oogc006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00844'
                  LET g_errparam.extend = g_pjea2_s.l_pjea003_b
                  LET g_errparam.replace[1] =  g_oogc006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  LET g_pjea2_s.l_pjea002_b = ''
                  NEXT FIELD l_pjea003_b
                  DISPLAY BY NAME g_pjea2_s.l_pjea002_b                    
               END IF   
               IF NOT apji400_pjeald_pjea002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
            
         AFTER FIELD l_pjeald_e
            IF NOT cl_null(g_pjea2_s.l_pjeald_e) THEN
               IF NOT ap_chk_isExist(g_pjea2_s.l_pjeald_e,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00055',0) THEN
                  LET g_pjea2_s.l_pjeald_e = ''
                  LET g_pjea2_s.l_pjeald_e_desc = ''
                  DISPLAY BY NAME g_pjea2_s.l_pjeald_e_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_isExist(g_pjea2_s.l_pjeald_e,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'sub-01302',"agli010") THEN  #agl-00051 #160318-00005#33 by 07900 --mod
                  LET g_pjea2_s.l_pjeald_e = ''
                  LET g_pjea2_s.l_pjeald_e_desc = ''
                  DISPLAY BY NAME g_pjea2_s.l_pjeald_e_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_ld_chk_authorization(g_user,g_pjea2_s.l_pjeald_e) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_pjea_m.pjeald
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pjea2_s.l_pjeald_e = ''
                  LET g_pjea2_s.l_pjeald_e_desc = ''
                  DISPLAY BY NAME g_pjea2_s.l_pjeald_e_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT apji400_pjeald_pjea002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
            SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjea2_s.l_pjeald_e

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjea2_s.l_pjeald_e
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjea2_s.l_pjeald_e_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjea2_s.l_pjeald_e_desc

         AFTER FIELD l_pjea002_e
            IF NOT cl_null(g_pjea2_s.l_pjea002_e) THEN
               IF g_pjea2_s.l_pjea002_e <1000 OR g_pjea2_s.l_pjea002_e >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_pjea2_s.l_pjea002_e
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_pjea2_s.l_pjea002_e =''
                  NEXT FIELD l_pjea002_e
               END IF
               SELECT MAX(oogc006) INTO g_oogc006 FROM oogc_t
                WHERE oogcent = g_enterprise
                  AND oogc001 = g_ooef008
                  AND oogc002 = g_ooef009
                  AND oogc015 = g_pjea2_s.l_pjea002_e
               IF cl_null(g_oogc006) THEN LET g_oogc006 = 12 END IF 
               IF g_pjea2_s.l_pjea003_e > g_oogc006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00844'
                  LET g_errparam.extend = g_pjea2_s.l_pjea003_e
                  LET g_errparam.replace[1] =  g_oogc006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  LET g_pjea2_s.l_pjea002_e = ''
                  NEXT FIELD l_pjea002_e
                  DISPLAY BY NAME g_pjea2_s.l_pjea002_e                    
               END IF   
               IF NOT apji400_pjeald_pjea002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF

         AFTER FIELD l_pjea003_e
            IF NOT cl_null(g_pjea2_s.l_pjea003_e) THEN
               SELECT MAX(oogc006) INTO g_oogc006 FROM oogc_t
                WHERE oogcent = g_enterprise
                  AND oogc001 = g_ooef008
                  AND oogc002 = g_ooef009
                  AND oogc015 = g_pjea2_s.l_pjea002_e
               IF cl_null(g_oogc006) THEN LET g_oogc006 = 12 END IF 
               IF g_pjea2_s.l_pjea003_e > g_oogc006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00844'
                  LET g_errparam.extend = g_pjea2_s.l_pjea003_e
                  LET g_errparam.replace[1] =  g_oogc006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  LET g_pjea2_s.l_pjea002_e = ''
                  NEXT FIELD l_pjea002_e
                  DISPLAY BY NAME g_pjea2_s.l_pjea002_e                    
               END IF   
               IF NOT apji400_pjeald_pjea002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
 
        ON ACTION controlp INFIELD l_pjeald_b
            #add-point:ON ACTION controlp INFIELD pjeald
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjea2_s.l_pjeald_b             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_pjea2_s.l_pjeald_b = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjea2_s.l_pjeald_b
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjea2_s.l_pjeald_b_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjea2_s.l_pjeald_b_desc

            DISPLAY g_pjea2_s.l_pjeald_b TO l_pjeald_b              #顯示到畫面上

            NEXT FIELD l_pjeald_b
            
         ON ACTION controlp INFIELD l_pjeald_e
            #add-point:ON ACTION controlp INFIELD pjeald_1
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjea2_s.l_pjeald_e             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_pjea2_s.l_pjeald_e = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjea2_s.l_pjeald_e
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjea2_s.l_pjeald_e_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjea2_s.l_pjeald_e_desc

            DISPLAY g_pjea2_s.l_pjeald_e TO l_pjeald_e              #顯示到畫面上

            NEXT FIELD l_pjeald_e 

         AFTER INPUT
            IF NOT cl_null(g_pjea2_s.l_pjeald_b) AND NOT cl_null(g_pjea2_s.l_pjeald_e) THEN
               SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjea2_s.l_pjeald_b
               SELECT glaa004 INTO l_glaa004_1 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjea2_s.l_pjeald_e
               IF l_glaa004 != l_glaa004_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00110'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD l_pjeald_b
               END IF
            END IF
            
      END INPUT

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG
      
      ON ACTION confirm
         IF NOT apji400_ins_pjea_s02(g_pjea2_s.l_pjeald_b,g_pjea2_s.l_pjea002_b,g_pjea2_s.l_pjea003_b,g_pjea2_s.l_pjeald_e,g_pjea2_s.l_pjea002_e,g_pjea2_s.l_pjea003_e) THEN
            NEXT FIELD l_pjeald_b
         ELSE
            ACCEPT DIALOG
         END IF

      ON ACTION quit
         LET INT_FLAG = TRUE
         EXIT DIALOG


   END DIALOG
   
   #畫面關閉
   CLOSE WINDOW w_apji400_s02
END FUNCTION

################################################################################
# Descriptions...: 整批产生插入资料
################################################################################
PRIVATE FUNCTION apji400_ins_pjea_s01(p_wc,p_wc1)
DEFINE p_wc           STRING
DEFINE p_wc1          STRING
DEFINE l_sql1          STRING
DEFINE l_success      LIKE type_t.chr1
DEFINE l_pjea RECORD  #項目費用分攤科目設定作業
       pjeaent LIKE pjea_t.pjeaent, #企業編號
       pjeald LIKE pjea_t.pjeald, #帳套編號
       pjea002 LIKE pjea_t.pjea002, #年度
       pjea003 LIKE pjea_t.pjea003, #期別
       pjea004 LIKE pjea_t.pjea004, #專案編號
       pjea005 LIKE pjea_t.pjea005, #科目編號
       pjea006 LIKE pjea_t.pjea006, #部門編號
       pjea009 LIKE pjea_t.pjea009, #分攤權數
       pjeaownid LIKE pjea_t.pjeaownid, #資料所屬者
       pjeaowndp LIKE pjea_t.pjeaowndp, #資料所屬部門
       pjeacrtid LIKE pjea_t.pjeacrtid, #資料建立者
       pjeacrtdp LIKE pjea_t.pjeacrtdp, #資料建立部門
       pjeacrtdt LIKE pjea_t.pjeacrtdt, #資料創建日
       pjeamodid LIKE pjea_t.pjeamodid, #資料修改者
       pjeamoddt LIKE pjea_t.pjeamoddt, #最近修改日
       pjeastus LIKE pjea_t.pjeastus  #狀態碼
END RECORD
DEFINE l_n            LIKE type_t.num10  
DEFINE l_glaa004      LIKE glaa_t.glaa004
DEFINE l_n1           LIKE type_t.num10 

#初始化
   LET l_success = 'N'
   INITIALIZE l_pjea.* TO NULL

#啟用事務
   CALL s_transaction_begin()
   
   IF cl_null(p_wc) THEN
      LET p_wc = " 1=1 "
   END IF
   IF cl_null(p_wc1) THEN
      LET p_wc1 = " 1=1 "
   END IF
   
   LET l_pjea.pjeaownid = g_user
   LET l_pjea.pjeaowndp = g_dept
   LET l_pjea.pjeacrtid = g_user
   LET l_pjea.pjeacrtdp = g_dept 
   LET l_pjea.pjeacrtdt = cl_get_current()
   LET l_pjea.pjea004 = ' '
   LET l_pjea.pjea009 = NULL
   
   SELECT UNIQUE glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjea_s.pjeald
   SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjea_s.pjeald
   LET g_pjea_s.l_comp = g_glaacomp
   LET p_wc = cl_replace_str(p_wc,"pjea006","ooeg001")
   LET p_wc1 = cl_replace_str(p_wc1,"pjea005","glac002")
   LET l_sql1 = " SELECT UNIQUE ooeg001 FROM ooeg_t,ooef_t ",
                " WHERE ooefent = ooegent AND ooef001 = ooeg001 ",
                "   AND ooegent = '",g_enterprise,"' AND ooegstus = 'Y'",
                "   AND ((ooeg006 <= '" ,g_today,"' OR ooeg006 IS NULL) AND (ooeg007 IS NULL OR ooeg007 > '",g_today,"'))",    
                "   AND (ooef017 = '",g_pjea_s.l_comp,"' OR ooef017 = 'ALL')",  
                "   AND ",p_wc
   PREPARE ooeg_s01_prep FROM l_sql1
   DECLARE ooeg_s01_curs CURSOR FOR ooeg_s01_prep
  
   LET l_sql1 = " SELECT UNIQUE glac002 FROM glac_t ",
                " WHERE glacent = '",g_enterprise,"' AND glacstus = 'Y'",
                "   AND glac001 = '",l_glaa004,"' AND glac003 != '1' ",
                "   AND glac006 = '1' AND glac007 = '6' AND ",p_wc1

   PREPARE glac_s01_prep FROM l_sql1
   DECLARE glac_s01_curs CURSOR FOR glac_s01_prep
   
   FOREACH ooeg_s01_curs INTO l_pjea.pjea006
   
      FOREACH glac_s01_curs INTO l_pjea.pjea005
   
         IF NOT cl_null(l_pjea.pjea005) THEN
            IF NOT apji400_pjea005_chk(g_pjea_s.pjeald,l_pjea.pjea005) THEN  #檢查會計科目是否存在及非統計類科目及非賬戶性質
               LET l_success = 'N'
               EXIT FOREACH
            END IF
         END IF
           
         IF NOT cl_null(l_pjea.pjea006) THEN
            IF NOT ap_chk_isExist(l_pjea.pjea006,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? ","abm-00006",0) THEN
               LET l_success = 'N'
               EXIT FOREACH
            END IF
            IF NOT ap_chk_isExist(l_pjea.pjea006,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' ","sub-01302","aooi125" ) THEN  #abm-00007 #160318-00005#33 by 07900 --mod
               LET l_success = 'N'
               EXIT FOREACH
            END IF
         END IF    
       
         #先檢查是否已經有存在資料,若有則跳過
         LET l_n = 0           
         SELECT COUNT(*) INTO l_n FROM pjea_t 
          WHERE pjeaent = g_enterprise      
            AND pjeald = g_pjea_s.pjeald
            AND pjea002 = g_pjea_s.pjea002
            AND pjea003 = g_pjea_s.pjea003
            AND pjea005 = l_pjea.pjea005    
            AND pjea006 = l_pjea.pjea006   
         IF l_n > 0 THEN
            CONTINUE FOREACH
         END IF
         #插入數據庫操作
         LET l_success = 'Y' 
         INSERT INTO pjea_t
                  (pjeaent,
                   pjeald,pjea002,pjea003,pjea004,pjea005,pjea006,
                   pjeastus,pjea009,pjeaownid,pjeaowndp,pjeacrtid,pjeacrtdp,pjeacrtdt) 
            VALUES(g_enterprise,
                   g_pjea_s.pjeald,g_pjea_s.pjea002,g_pjea_s.pjea003,l_pjea.pjea004,
                   l_pjea.pjea005,l_pjea.pjea006,'Y',l_pjea.pjea009,
                   l_pjea.pjeaownid,l_pjea.pjeaowndp,l_pjea.pjeacrtid,l_pjea.pjeacrtdp,l_pjea.pjeacrtdt)
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            LET l_success = 'N'
            EXIT FOREACH 
         END IF
      END FOREACH
      IF l_success = 'N' THEN
         EXIT FOREACH
      END IF
   END FOREACH

   #結束事務
   CALL s_transaction_end(l_success,1)
END FUNCTION

################################################################################
# Descriptions...: 檢查會計科目是否存在及非統計類科目及非賬戶性質
################################################################################
PRIVATE FUNCTION apji400_pjea005_chk(p_pjeald,p_pjea005)
   DEFINE p_pjea005    LIKE pjea_t.pjea005
   DEFINE l_glaa004    LIKE glaa_t.glaa004
   DEFINE r_success    LIKE type_t.num5
   DEFINE p_pjeald     LIKE pjea_t.pjeald    
   LET r_success = TRUE
   SELECT UNIQUE glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_pjeald 
   IF NOT cl_null(p_pjea005) THEN
      #檢查是否存在
      IF r_success THEN
         IF NOT ap_chk_isExist(p_pjea005,"SELECT COUNT(*) FROM glac_t WHERE glacent = '"
            ||g_enterprise||"' AND glac001 = '"||l_glaa004||"' AND glac002 = ? ","agl-00141",0 ) THEN
            LET r_success = FALSE
         END IF
      END IF
      #檢查是否是統制科目
      IF r_success THEN
         IF NOT ap_chk_isExist(p_pjea005,"SELECT COUNT(*) FROM glac_t WHERE glacent = '"
            ||g_enterprise||"' AND glac001 = '"||l_glaa004||"' AND glac002 = ? AND glac003 != '1' ","agl-00142",0) THEN
            LET r_success = FALSE
         END IF
      END IF
      #檢查是否是賬戶性質科目
      IF r_success THEN
         IF NOT ap_chk_isExist(p_pjea005,"SELECT COUNT(*) FROM glac_t WHERE glacent = '"
            ||g_enterprise||"' AND glac001 = '"||l_glaa004||"' AND glac002 = ? AND glac006 = '1' ","axc-00057",0) THEN
            LET r_success = FALSE
         END IF
      END IF
      #檢查是否為成本類科目
      IF r_success THEN
         IF NOT ap_chk_isExist(p_pjea005,"SELECT COUNT(*) FROM glac_t WHERE glacent = '"
            ||g_enterprise||"' AND glac001 = '"||l_glaa004||"' AND glac002 = ? AND glac007 = '6' ","axc-00091",0) THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查目的帳套年度期別與來源帳套年度期別不能相等
################################################################################
PRIVATE FUNCTION apji400_pjeald_pjea002_chk()
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   
   IF NOT cl_null(g_pjea2_s.l_pjeald_b) AND NOT cl_null(g_pjea2_s.l_pjea002_b) AND NOT cl_null(g_pjea2_s.l_pjea003_b) 
      AND NOT cl_null(g_pjea2_s.l_pjeald_e) AND NOT cl_null(g_pjea2_s.l_pjea002_e) AND NOT cl_null(g_pjea2_s.l_pjea003_e) THEN
      IF g_pjea2_s.l_pjeald_b = g_pjea2_s.l_pjeald_e AND g_pjea2_s.l_pjea002_b = g_pjea2_s.l_pjea002_e 
         AND g_pjea2_s.l_pjea003_b = g_pjea2_s.l_pjea003_e THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00060'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
      END IF
      
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 整批复制插入资料
################################################################################
PRIVATE FUNCTION apji400_ins_pjea_s02(p_pjeald_b,p_pjea002_b,p_pjea003_b,p_pjeald_e,p_pjea002_e,p_pjea003_e)
DEFINE p_pjeald_b       LIKE pjea_t.pjeald
DEFINE p_pjea002_b      LIKE pjea_t.pjea002
DEFINE p_pjea003_b      LIKE pjea_t.pjea003
DEFINE p_pjeald_e       LIKE pjea_t.pjeald
DEFINE p_pjea002_e      LIKE pjea_t.pjea002
DEFINE p_pjea003_e      LIKE pjea_t.pjea003
DEFINE l_sql            STRING
DEFINE l_success        LIKE type_t.chr1
DEFINE l_pjea RECORD  #項目費用分攤科目設定作業
       pjeaent LIKE pjea_t.pjeaent, #企業編號
       pjeald LIKE pjea_t.pjeald, #帳套編號
       pjea002 LIKE pjea_t.pjea002, #年度
       pjea003 LIKE pjea_t.pjea003, #期別
       pjea004 LIKE pjea_t.pjea004, #專案編號
       pjea005 LIKE pjea_t.pjea005, #科目編號
       pjea006 LIKE pjea_t.pjea006, #部門編號
       pjea009 LIKE pjea_t.pjea009, #分攤權數
       pjeaownid LIKE pjea_t.pjeaownid, #資料所屬者
       pjeaowndp LIKE pjea_t.pjeaowndp, #資料所屬部門
       pjeacrtid LIKE pjea_t.pjeacrtid, #資料建立者
       pjeacrtdp LIKE pjea_t.pjeacrtdp, #資料建立部門
       pjeacrtdt LIKE pjea_t.pjeacrtdt, #資料創建日
       pjeamodid LIKE pjea_t.pjeamodid, #資料修改者
       pjeamoddt LIKE pjea_t.pjeamoddt, #最近修改日
       pjeastus LIKE pjea_t.pjeastus  #狀態碼
END RECORD
DEFINE l_n              LIKE type_t.num10 
DEFINE l_glaacomp       LIKE glaa_t.glaacomp
DEFINE l_glaacomp_1     LIKE glaa_t.glaacomp
DEFINE l_glaa004_1      LIKE glaa_t.glaa004
DEFINE l_glaa004        LIKE glaa_t.glaa004
DEFINE l_n1             LIKE type_t.num10 
DEFINE l_sum            LIKE type_t.num5      #計算分攤權數
DEFINE l_pjea005_t      LIKE pjea_t.pjea005   #科目編號舊值 
DEFINE l_pjea006_t      LIKE pjea_t.pjea006   #部門編號舊值 
DEFINE l_pjea009_t      LIKE pjea_t.pjea009   #分攤權數舊值 
DEFINE l_pjea004        LIKE pjea_t.pjea004   #专案编号
DEFINE l_pjea006        LIKE pjea_t.pjea005   #部門編號
DEFINE l_str            STRING
DEFINE l_cnt_sql        STRING
DEFINE l_cnt            LIKE type_t.num10
DEFINE r_success        LIKE type_t.num5

   #初始化
   LET r_success = TRUE
   LET l_success = 'Y'
   INITIALIZE l_pjea.* TO NULL

   #為空，則RETURN
   IF cl_null(p_pjeald_b) OR cl_null(p_pjea002_b) OR cl_null(p_pjea003_b) OR cl_null(p_pjeald_e) OR cl_null(p_pjea002_e) OR cl_null(p_pjea003_e) THEN
      RETURN
   END IF
    
   
   #检查来源账套与目的账套是否用的同一套科目表
   IF NOT cl_null(g_pjea2_s.l_pjeald_b) AND NOT cl_null(g_pjea2_s.l_pjeald_e) THEN
      SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjea2_s.l_pjeald_b
      SELECT glaa004 INTO l_glaa004_1 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjea2_s.l_pjeald_e
      IF l_glaa004 != l_glaa004_1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00110'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   LET l_sql = " SELECT pjea004,pjea005,pjea006,pjea009 FROM pjea_t ",
               " WHERE pjeaent = '",g_enterprise,"' AND pjeald = '",p_pjeald_b,"'",
               "   AND pjea002 = '",p_pjea002_b,"' AND pjea003 = '",p_pjea003_b, "'",
               "   ORDER BY pjea005,pjea006 "
   PREPARE pjea_s02_prep FROM l_sql
   DECLARE pjea_s02_curs CURSOR FOR pjea_s02_prep
   LET l_cnt = 0
   LET l_cnt_sql = " SELECT COUNT(1) FROM (",l_sql CLIPPED,")"
   PREPARE apji400_pjea_cnt_pre FROM l_cnt_sql
   EXECUTE apji400_pjea_cnt_pre INTO l_cnt
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apj-00123'      #来源帐套+年度+期别未维护项目费用分摊科目！
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #啟用事務
   CALL s_transaction_begin()
   
   CALL cl_showmsg_init()
   LET l_pjea.pjeaownid = g_user
   LET l_pjea.pjeaowndp = g_dept
   LET l_pjea.pjeacrtid = g_user
   LET l_pjea.pjeacrtdp = g_dept 
   LET l_pjea.pjeacrtdt = cl_get_current()
   LET l_pjea.pjea004 = ' '
   LET l_pjea.pjea009 = NULL
   LET l_n1 = 0

   #開始插入操作
   FOREACH pjea_s02_curs INTO l_pjea.pjea004,l_pjea.pjea005,l_pjea.pjea006,l_pjea.pjea009
       
       #前后兩筆部門編號或者會計科目不同
       IF l_pjea.pjea005 != l_pjea005_t OR l_pjea.pjea006 != l_pjea006_t THEN
          LET l_sum = 0
          SELECT SUM(pjea009) INTO l_sum FROM pjea_t 
           WHERE pjeaent = g_enterprise AND pjeald = p_pjeald_e
             AND pjea002 = p_pjea002_e AND pjea003 = p_pjea003_e  
          　AND pjea005 = l_pjea.pjea005 AND pjea006 = l_pjea.pjea006 
          IF cl_null(l_sum) THEN LET l_sum = 0 END IF 
       END IF 
    
       LET l_pjea005_t = l_pjea.pjea005 
       LET l_pjea006_t = l_pjea.pjea006        
       
       #若已經存在，则删除资料在进行新增       
       LET l_n = 0           
       SELECT COUNT(*) INTO l_n FROM pjea_t 
        WHERE pjeaent = g_enterprise   AND pjeald = p_pjeald_e
          AND pjea002 = p_pjea002_e
          AND pjea003 = p_pjea003_e    AND pjea004 = l_pjea.pjea004
          AND pjea005 = l_pjea.pjea005 AND pjea006 = l_pjea.pjea006   

       IF l_n > 0 THEN
          #刪除已存在資料          
          DELETE FROM pjea_t 
           WHERE pjeaent = g_enterprise   AND pjeald = p_pjeald_e
             AND pjea002 = p_pjea002_e
             AND pjea003 = p_pjea003_e    AND pjea004 = l_pjea.pjea004  
             AND pjea005 = l_pjea.pjea005 AND pjea006 = l_pjea.pjea006 
       END IF
       
       IF cl_null(l_pjea.pjea004) THEN LET l_pjea.pjea004 = ' ' END IF 
       LET l_n1 = 1
       #插入數據庫操作
       INSERT INTO pjea_t
                (pjeaent,
                 pjeald,pjea002,pjea003,pjea004,pjea005,pjea006,
                 pjeastus,pjea009,pjeaownid,pjeaowndp,pjeacrtid,pjeacrtdp,pjeacrtdt) 
          VALUES(g_enterprise,
                 p_pjeald_e,p_pjea002_e,p_pjea003_e,l_pjea.pjea004,l_pjea.pjea005,
                 l_pjea.pjea006,'Y',l_pjea.pjea009,
                 l_pjea.pjeaownid,l_pjea.pjeaowndp,l_pjea.pjeacrtid,l_pjea.pjeacrtdp,l_pjea.pjeacrtdt)
       IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
          LET l_success = 'N'
          EXIT FOREACH 
       END IF
#       
#       IF l_sum > 100 THEN
#          LET l_str = p_pjeald_e,"/",p_pjea002_e,"/",p_pjea003_e,"/",l_pjea.pjea005,"/",l_pjea.pjea006
#          CALL cl_errmsg('pjeald,pjea002,pjea003,pjea005,pjea006',l_str,'','axc-00077',1)
#          LET l_success = 'N'
#       END IF
#         
   END FOREACH
   
   IF l_success = 'Y' THEN
      #检查来源账套与目的账套是否用的同一套科目表
      IF NOT cl_null(g_pjea2_s.l_pjeald_b) AND NOT cl_null(g_pjea2_s.l_pjeald_e) THEN
         SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjea2_s.l_pjeald_b
         SELECT glaacomp INTO l_glaacomp_1 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjea2_s.l_pjeald_e
         IF l_glaacomp != l_glaacomp_1 THEN
            
            LET l_sql = " SELECT UNIQUE pjea006 FROM pjea_t,ooef_t ",
                        "  WHERE pjeaent = ooefent AND pjea006 = ooef001 ",
                        "    AND (ooef017 != '",l_glaacomp_1,"' OR ooef017 is null) ",
                        "    AND pjeaent = '",g_enterprise,"' AND pjeald ='",p_pjeald_e,"'",
                        "    AND pjea002 = ",p_pjea002_e," AND pjea003 = ",p_pjea003_e
            PREPARE pjea006_prep FROM l_sql
            DECLARE pjea006_curs CURSOR FOR pjea006_prep
            FOREACH pjea006_curs INTO l_pjea006
               LET l_str = p_pjeald_e,"/",l_pjea.pjea006
               CALL cl_errmsg('pjeald,pjea006',l_str,'','axc-00092',1)
            END FOREACH
            
         END IF
      END IF
   END IF 
   
   CALL cl_err_showmsg()
   
#結束事務
   CALL s_transaction_end(l_success,1)
   RETURN r_success
END FUNCTION

 
{</section>}
 
