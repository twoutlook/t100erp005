#該程式未解開Section, 採用最新樣板產出!
{<section id="acrm350.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-03-09 10:06:39), PR版次:0007(2016-10-26 23:20:42)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000129
#+ Filename...: acrm350
#+ Description: 業務員工作日報維護作業
#+ Creator....: 02749(2014-04-24 13:51:01)
#+ Modifier...: 06137 -SD/PR- 02481
 
{</section>}
 
{<section id="acrm350.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#27    16/04/29     BY 07900     校验代码重复错误讯息的修改
#161024-00025#6     2016/10/26   By 02481     aooi500规范调整
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
PRIVATE type type_g_crad_m        RECORD
       crad001 LIKE crad_t.crad001, 
   crad001_desc LIKE type_t.chr80, 
   crad002 LIKE crad_t.crad002, 
   crad003 LIKE crad_t.crad003, 
   crad003_desc LIKE type_t.chr80, 
   crad004 LIKE crad_t.crad004, 
   cradunit LIKE crad_t.cradunit, 
   cradunit_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_crad_d        RECORD
       cradstus LIKE crad_t.cradstus, 
   crad005 LIKE crad_t.crad005, 
   crad006 LIKE crad_t.crad006, 
   crad006_desc LIKE type_t.chr500, 
   crad007 LIKE crad_t.crad007
       END RECORD
PRIVATE TYPE type_g_crad2_d RECORD
       crad005 LIKE crad_t.crad005, 
   cradownid LIKE crad_t.cradownid, 
   cradownid_desc LIKE type_t.chr500, 
   cradowndp LIKE crad_t.cradowndp, 
   cradowndp_desc LIKE type_t.chr500, 
   cradcrtid LIKE crad_t.cradcrtid, 
   cradcrtid_desc LIKE type_t.chr500, 
   cradcrtdp LIKE crad_t.cradcrtdp, 
   cradcrtdp_desc LIKE type_t.chr500, 
   cradcrtdt DATETIME YEAR TO SECOND, 
   cradmodid LIKE crad_t.cradmodid, 
   cradmodid_desc LIKE type_t.chr500, 
   cradmoddt DATETIME YEAR TO SECOND, 
   cradcnfid LIKE crad_t.cradcnfid, 
   cradcnfid_desc LIKE type_t.chr500, 
   cradcnfdt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_crad_m          type_g_crad_m
DEFINE g_crad_m_t        type_g_crad_m
DEFINE g_crad_m_o        type_g_crad_m
DEFINE g_crad_m_mask_o   type_g_crad_m #轉換遮罩前資料
DEFINE g_crad_m_mask_n   type_g_crad_m #轉換遮罩後資料
 
   DEFINE g_crad001_t LIKE crad_t.crad001
DEFINE g_crad002_t LIKE crad_t.crad002
DEFINE g_crad003_t LIKE crad_t.crad003
 
 
DEFINE g_crad_d          DYNAMIC ARRAY OF type_g_crad_d
DEFINE g_crad_d_t        type_g_crad_d
DEFINE g_crad_d_o        type_g_crad_d
DEFINE g_crad_d_mask_o   DYNAMIC ARRAY OF type_g_crad_d #轉換遮罩前資料
DEFINE g_crad_d_mask_n   DYNAMIC ARRAY OF type_g_crad_d #轉換遮罩後資料
DEFINE g_crad2_d   DYNAMIC ARRAY OF type_g_crad2_d
DEFINE g_crad2_d_t type_g_crad2_d
DEFINE g_crad2_d_o type_g_crad2_d
DEFINE g_crad2_d_mask_o   DYNAMIC ARRAY OF type_g_crad2_d #轉換遮罩前資料
DEFINE g_crad2_d_mask_n   DYNAMIC ARRAY OF type_g_crad2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_crad001 LIKE crad_t.crad001,
      b_crad002 LIKE crad_t.crad002,
      b_crad003 LIKE crad_t.crad003
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
 
{<section id="acrm350.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("acr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT crad001,'',crad002,crad003,'',crad004,cradunit,''", 
                      " FROM crad_t",
                      " WHERE cradent= ? AND crad001=? AND crad002=? AND crad003=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE acrm350_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.crad001,t0.crad002,t0.crad003,t0.crad004,t0.cradunit,t1.ooag011 , 
       t2.craal003 ,t3.ooefl003",
               " FROM crad_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.crad001  ",
               " LEFT JOIN craal_t t2 ON t2.craalent="||g_enterprise||" AND t2.craal001=t0.crad003 AND t2.craal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.cradunit AND t3.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.cradent = " ||g_enterprise|| " AND t0.crad001 = ? AND t0.crad002 = ? AND t0.crad003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE acrm350_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrm350 WITH FORM cl_ap_formpath("acr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL acrm350_init()   
 
      #進入選單 Menu (="N")
      CALL acrm350_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_acrm350
      
   END IF 
   
   CLOSE acrm350_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="acrm350.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION acrm350_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('cradstus','50','N,Y,X')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   LET g_errshow = '1'
   #end add-point
   
   CALL acrm350_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="acrm350.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION acrm350_ui_dialog()
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
         INITIALIZE g_crad_m.* TO NULL
         CALL g_crad_d.clear()
         CALL g_crad2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL acrm350_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_crad_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL acrm350_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL acrm350_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_crad2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL acrm350_idx_chk()
               CALL acrm350_ui_detailshow()
               
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
            CALL acrm350_browser_fill("")
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
               CALL acrm350_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL acrm350_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL acrm350_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL acrm350_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL acrm350_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL acrm350_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL acrm350_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL acrm350_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL acrm350_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL acrm350_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL acrm350_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL acrm350_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_crad_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_crad2_d)
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
               NEXT FIELD crad005
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
               CALL acrm350_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL acrm350_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL acrm350_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL acrm350_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL acrm350_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL acrm350_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL acrm350_insert()
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
               CALL acrm350_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL acrm350_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL acrm350_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL acrm350_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL acrm350_set_pk_array()
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
 
{<section id="acrm350.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION acrm350_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="acrm350.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION acrm350_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "crad001,crad002,crad003"
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
      LET l_sub_sql = " SELECT DISTINCT crad001 ",
                      ", crad002 ",
                      ", crad003 ",
 
                      " FROM crad_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE cradent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("crad_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT crad001 ",
                      ", crad002 ",
                      ", crad003 ",
 
                      " FROM crad_t ",
                      " ",
                      " ", 
 
 
                      " WHERE cradent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("crad_t")
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
      INITIALIZE g_crad_m.* TO NULL
      CALL g_crad_d.clear()        
      CALL g_crad2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.crad001,t0.crad002,t0.crad003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.crad001,t0.crad002,t0.crad003",
                " FROM crad_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.cradent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("crad_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"crad_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_crad001,g_browser[g_cnt].b_crad002,g_browser[g_cnt].b_crad003  
 
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
   
   IF cl_null(g_browser[g_cnt].b_crad001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_crad_m.* TO NULL
      CALL g_crad_d.clear()
      CALL g_crad2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL acrm350_fetch('')
   
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
 
{<section id="acrm350.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION acrm350_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_crad_m.crad001 = g_browser[g_current_idx].b_crad001   
   LET g_crad_m.crad002 = g_browser[g_current_idx].b_crad002   
   LET g_crad_m.crad003 = g_browser[g_current_idx].b_crad003   
 
   EXECUTE acrm350_master_referesh USING g_crad_m.crad001,g_crad_m.crad002,g_crad_m.crad003 INTO g_crad_m.crad001, 
       g_crad_m.crad002,g_crad_m.crad003,g_crad_m.crad004,g_crad_m.cradunit,g_crad_m.crad001_desc,g_crad_m.crad003_desc, 
       g_crad_m.cradunit_desc
   CALL acrm350_show()
   
END FUNCTION
 
{</section>}
 
{<section id="acrm350.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION acrm350_ui_detailshow()
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
 
{<section id="acrm350.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION acrm350_ui_browser_refresh()
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
      IF g_browser[l_i].b_crad001 = g_crad_m.crad001 
         AND g_browser[l_i].b_crad002 = g_crad_m.crad002 
         AND g_browser[l_i].b_crad003 = g_crad_m.crad003 
 
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
 
{<section id="acrm350.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION acrm350_construct()
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
   INITIALIZE g_crad_m.* TO NULL
   CALL g_crad_d.clear()
   CALL g_crad2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON crad001,crad002,crad003,crad004,cradunit
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.crad001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crad001
            #add-point:ON ACTION controlp INFIELD crad001 name="construct.c.crad001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crad001  #顯示到畫面上
            NEXT FIELD crad001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crad001
            #add-point:BEFORE FIELD crad001 name="construct.b.crad001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crad001
            
            #add-point:AFTER FIELD crad001 name="construct.a.crad001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crad002
            #add-point:BEFORE FIELD crad002 name="construct.b.crad002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crad002
            
            #add-point:AFTER FIELD crad002 name="construct.a.crad002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.crad002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crad002
            #add-point:ON ACTION controlp INFIELD crad002 name="construct.c.crad002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.crad003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crad003
            #add-point:ON ACTION controlp INFIELD crad003 name="construct.c.crad003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_craa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crad003  #顯示到畫面上
            NEXT FIELD crad003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crad003
            #add-point:BEFORE FIELD crad003 name="construct.b.crad003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crad003
            
            #add-point:AFTER FIELD crad003 name="construct.a.crad003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crad004
            #add-point:BEFORE FIELD crad004 name="construct.b.crad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crad004
            
            #add-point:AFTER FIELD crad004 name="construct.a.crad004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.crad004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crad004
            #add-point:ON ACTION controlp INFIELD crad004 name="construct.c.crad004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cradunit
            #add-point:BEFORE FIELD cradunit name="construct.b.cradunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cradunit
            
            #add-point:AFTER FIELD cradunit name="construct.a.cradunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.cradunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cradunit
            #add-point:ON ACTION controlp INFIELD cradunit name="construct.c.cradunit"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'cradunit',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO cradunit          #顯示到畫面上
            NEXT FIELD cradunit                             #返回原欄位  
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON cradstus,crad005,crad006,crad007,cradownid,cradowndp,cradcrtid,cradcrtdp, 
          cradcrtdt,cradmodid,cradmoddt,cradcnfid,cradcnfdt
           FROM s_detail1[1].cradstus,s_detail1[1].crad005,s_detail1[1].crad006,s_detail1[1].crad007, 
               s_detail2[1].cradownid,s_detail2[1].cradowndp,s_detail2[1].cradcrtid,s_detail2[1].cradcrtdp, 
               s_detail2[1].cradcrtdt,s_detail2[1].cradmodid,s_detail2[1].cradmoddt,s_detail2[1].cradcnfid, 
               s_detail2[1].cradcnfdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<cradcrtdt>>----
         AFTER FIELD cradcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<cradmoddt>>----
         AFTER FIELD cradmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<cradcnfdt>>----
         AFTER FIELD cradcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<cradpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cradstus
            #add-point:BEFORE FIELD cradstus name="construct.b.page1.cradstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cradstus
            
            #add-point:AFTER FIELD cradstus name="construct.a.page1.cradstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.cradstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cradstus
            #add-point:ON ACTION controlp INFIELD cradstus name="construct.c.page1.cradstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crad005
            #add-point:BEFORE FIELD crad005 name="construct.b.page1.crad005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crad005
            
            #add-point:AFTER FIELD crad005 name="construct.a.page1.crad005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.crad005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crad005
            #add-point:ON ACTION controlp INFIELD crad005 name="construct.c.page1.crad005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.crad006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crad006
            #add-point:ON ACTION controlp INFIELD crad006 name="construct.c.page1.crad006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2110" 
            CALL q_oocq002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crad006  #顯示到畫面上
            NEXT FIELD crad006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crad006
            #add-point:BEFORE FIELD crad006 name="construct.b.page1.crad006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crad006
            
            #add-point:AFTER FIELD crad006 name="construct.a.page1.crad006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crad007
            #add-point:BEFORE FIELD crad007 name="construct.b.page1.crad007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crad007
            
            #add-point:AFTER FIELD crad007 name="construct.a.page1.crad007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.crad007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crad007
            #add-point:ON ACTION controlp INFIELD crad007 name="construct.c.page1.crad007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.cradownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cradownid
            #add-point:ON ACTION controlp INFIELD cradownid name="construct.c.page2.cradownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO cradownid  #顯示到畫面上
            NEXT FIELD cradownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cradownid
            #add-point:BEFORE FIELD cradownid name="construct.b.page2.cradownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cradownid
            
            #add-point:AFTER FIELD cradownid name="construct.a.page2.cradownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.cradowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cradowndp
            #add-point:ON ACTION controlp INFIELD cradowndp name="construct.c.page2.cradowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO cradowndp  #顯示到畫面上
            NEXT FIELD cradowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cradowndp
            #add-point:BEFORE FIELD cradowndp name="construct.b.page2.cradowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cradowndp
            
            #add-point:AFTER FIELD cradowndp name="construct.a.page2.cradowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.cradcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cradcrtid
            #add-point:ON ACTION controlp INFIELD cradcrtid name="construct.c.page2.cradcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO cradcrtid  #顯示到畫面上
            NEXT FIELD cradcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cradcrtid
            #add-point:BEFORE FIELD cradcrtid name="construct.b.page2.cradcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cradcrtid
            
            #add-point:AFTER FIELD cradcrtid name="construct.a.page2.cradcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.cradcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cradcrtdp
            #add-point:ON ACTION controlp INFIELD cradcrtdp name="construct.c.page2.cradcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO cradcrtdp  #顯示到畫面上
            NEXT FIELD cradcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cradcrtdp
            #add-point:BEFORE FIELD cradcrtdp name="construct.b.page2.cradcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cradcrtdp
            
            #add-point:AFTER FIELD cradcrtdp name="construct.a.page2.cradcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cradcrtdt
            #add-point:BEFORE FIELD cradcrtdt name="construct.b.page2.cradcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.cradmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cradmodid
            #add-point:ON ACTION controlp INFIELD cradmodid name="construct.c.page2.cradmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO cradmodid  #顯示到畫面上
            NEXT FIELD cradmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cradmodid
            #add-point:BEFORE FIELD cradmodid name="construct.b.page2.cradmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cradmodid
            
            #add-point:AFTER FIELD cradmodid name="construct.a.page2.cradmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cradmoddt
            #add-point:BEFORE FIELD cradmoddt name="construct.b.page2.cradmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.cradcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cradcnfid
            #add-point:ON ACTION controlp INFIELD cradcnfid name="construct.c.page2.cradcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO cradcnfid  #顯示到畫面上
            NEXT FIELD cradcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cradcnfid
            #add-point:BEFORE FIELD cradcnfid name="construct.b.page2.cradcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cradcnfid
            
            #add-point:AFTER FIELD cradcnfid name="construct.a.page2.cradcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cradcnfdt
            #add-point:BEFORE FIELD cradcnfdt name="construct.b.page2.cradcnfdt"
            
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
 
{<section id="acrm350.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION acrm350_query()
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
   CALL g_crad_d.clear()
   CALL g_crad2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL acrm350_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL acrm350_browser_fill(g_wc)
      CALL acrm350_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL acrm350_browser_fill("F")
   
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
      CALL acrm350_fetch("F") 
   END IF
   
   CALL acrm350_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="acrm350.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION acrm350_fetch(p_flag)
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
   
   #CALL acrm350_browser_fill(p_flag)
   
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
   
   LET g_crad_m.crad001 = g_browser[g_current_idx].b_crad001
   LET g_crad_m.crad002 = g_browser[g_current_idx].b_crad002
   LET g_crad_m.crad003 = g_browser[g_current_idx].b_crad003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE acrm350_master_referesh USING g_crad_m.crad001,g_crad_m.crad002,g_crad_m.crad003 INTO g_crad_m.crad001, 
       g_crad_m.crad002,g_crad_m.crad003,g_crad_m.crad004,g_crad_m.cradunit,g_crad_m.crad001_desc,g_crad_m.crad003_desc, 
       g_crad_m.cradunit_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "crad_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_crad_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_crad_m_mask_o.* =  g_crad_m.*
   CALL acrm350_crad_t_mask()
   LET g_crad_m_mask_n.* =  g_crad_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL acrm350_set_act_visible()
   CALL acrm350_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_crad_m_t.* = g_crad_m.*
   LET g_crad_m_o.* = g_crad_m.*
   
   #重新顯示   
   CALL acrm350_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="acrm350.insert" >}
#+ 資料新增
PRIVATE FUNCTION acrm350_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert     LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_crad_d.clear()
   CALL g_crad2_d.clear()
 
 
   INITIALIZE g_crad_m.* TO NULL             #DEFAULT 設定
   LET g_crad001_t = NULL
   LET g_crad002_t = NULL
   LET g_crad003_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      LET g_crad_m.crad001 = g_user
      LET g_crad_m.crad001_desc = s_desc_get_person_desc(g_crad_m.crad001)
      LET g_crad_m.crad002 = g_today
      
      CALL s_aooi500_default(g_prog,'cradunit',g_site)
       RETURNING l_insert,g_crad_m.cradunit
      IF NOT l_insert THEN
        RETURN
      END IF      
      LET g_crad_m.cradunit_desc = acrm350_get_org_ref(g_crad_m.cradunit)     
      LET g_crad_m_t.* = g_crad_m.*
      #end add-point 
 
      CALL acrm350_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
 
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_crad_m.* TO NULL
         INITIALIZE g_crad_d TO NULL
         INITIALIZE g_crad2_d TO NULL
 
         CALL acrm350_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_crad_m.* = g_crad_m_t.*
         CALL acrm350_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_crad_d.clear()
      #CALL g_crad2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL acrm350_set_act_visible()
   CALL acrm350_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_crad001_t = g_crad_m.crad001
   LET g_crad002_t = g_crad_m.crad002
   LET g_crad003_t = g_crad_m.crad003
 
   
   #組合新增資料的條件
   LET g_add_browse = " cradent = " ||g_enterprise|| " AND",
                      " crad001 = '", g_crad_m.crad001, "' "
                      ," AND crad002 = '", g_crad_m.crad002, "' "
                      ," AND crad003 = '", g_crad_m.crad003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL acrm350_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL acrm350_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE acrm350_master_referesh USING g_crad_m.crad001,g_crad_m.crad002,g_crad_m.crad003 INTO g_crad_m.crad001, 
       g_crad_m.crad002,g_crad_m.crad003,g_crad_m.crad004,g_crad_m.cradunit,g_crad_m.crad001_desc,g_crad_m.crad003_desc, 
       g_crad_m.cradunit_desc
   
   #遮罩相關處理
   LET g_crad_m_mask_o.* =  g_crad_m.*
   CALL acrm350_crad_t_mask()
   LET g_crad_m_mask_n.* =  g_crad_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_crad_m.crad001,g_crad_m.crad001_desc,g_crad_m.crad002,g_crad_m.crad003,g_crad_m.crad003_desc, 
       g_crad_m.crad004,g_crad_m.cradunit,g_crad_m.cradunit_desc
   
   #功能已完成,通報訊息中心
   CALL acrm350_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="acrm350.modify" >}
#+ 資料修改
PRIVATE FUNCTION acrm350_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_crad_m.crad001 IS NULL
   OR g_crad_m.crad002 IS NULL
   OR g_crad_m.crad003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_crad001_t = g_crad_m.crad001
   LET g_crad002_t = g_crad_m.crad002
   LET g_crad003_t = g_crad_m.crad003
 
   CALL s_transaction_begin()
   
   OPEN acrm350_cl USING g_enterprise,g_crad_m.crad001,g_crad_m.crad002,g_crad_m.crad003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN acrm350_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE acrm350_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE acrm350_master_referesh USING g_crad_m.crad001,g_crad_m.crad002,g_crad_m.crad003 INTO g_crad_m.crad001, 
       g_crad_m.crad002,g_crad_m.crad003,g_crad_m.crad004,g_crad_m.cradunit,g_crad_m.crad001_desc,g_crad_m.crad003_desc, 
       g_crad_m.cradunit_desc
   
   #遮罩相關處理
   LET g_crad_m_mask_o.* =  g_crad_m.*
   CALL acrm350_crad_t_mask()
   LET g_crad_m_mask_n.* =  g_crad_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL acrm350_show()
   WHILE TRUE
      LET g_crad001_t = g_crad_m.crad001
      LET g_crad002_t = g_crad_m.crad002
      LET g_crad003_t = g_crad_m.crad003
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL acrm350_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_crad_m.* = g_crad_m_t.*
         CALL acrm350_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_crad_m.crad001 != g_crad001_t 
      OR g_crad_m.crad002 != g_crad002_t 
      OR g_crad_m.crad003 != g_crad003_t 
 
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
   CALL acrm350_set_act_visible()
   CALL acrm350_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " cradent = " ||g_enterprise|| " AND",
                      " crad001 = '", g_crad_m.crad001, "' "
                      ," AND crad002 = '", g_crad_m.crad002, "' "
                      ," AND crad003 = '", g_crad_m.crad003, "' "
 
   #填到對應位置
   CALL acrm350_browser_fill("")
 
   CALL acrm350_idx_chk()
 
   CLOSE acrm350_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL acrm350_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="acrm350.input" >}
#+ 資料輸入
PRIVATE FUNCTION acrm350_input(p_cmd)
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
   DEFINE l_errno                LIKE type_t.chr10
   DEFINE l_success              LIKE type_t.num5
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
   DISPLAY BY NAME g_crad_m.crad001,g_crad_m.crad001_desc,g_crad_m.crad002,g_crad_m.crad003,g_crad_m.crad003_desc, 
       g_crad_m.crad004,g_crad_m.cradunit,g_crad_m.cradunit_desc
   
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
   LET g_forupd_sql = "SELECT cradstus,crad005,crad006,crad007,crad005,cradownid,cradowndp,cradcrtid, 
       cradcrtdp,cradcrtdt,cradmodid,cradmoddt,cradcnfid,cradcnfdt FROM crad_t WHERE cradent=? AND crad001=?  
       AND crad002=? AND crad003=? AND crad005=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE acrm350_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL acrm350_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL acrm350_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_crad_m.crad001,g_crad_m.crad002,g_crad_m.crad003,g_crad_m.crad004,g_crad_m.cradunit 
 
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="acrm350.input.head" >}
   
      #單頭段
      INPUT BY NAME g_crad_m.crad001,g_crad_m.crad002,g_crad_m.crad003,g_crad_m.crad004,g_crad_m.cradunit  
 
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
         AFTER FIELD crad001
            
            #add-point:AFTER FIELD crad001 name="input.a.crad001"
            IF NOT cl_null(g_crad_m.crad001) THEN 
#此段落由子樣板a19產生
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_crad_m.crad001 != g_crad001_t) ) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_crad_m.crad001  
                  #160318-00025#27  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#27  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1 
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_crad_m.crad001 = g_crad001_t
                     LET g_crad_m.crad001_desc = s_desc_get_person_desc(g_crad_m.crad001)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            
            LET g_crad_m.crad001_desc = s_desc_get_person_desc(g_crad_m.crad001)
            DISPLAY BY NAME g_crad_m.crad001_desc

            #此段落由子樣板a05產生
            #IF  NOT cl_null(g_crad_m.crad001) AND NOT cl_null(g_crad_m.crad002) AND NOT cl_null(g_crad_m.crad003) AND NOT cl_null(g_crad_m.crad004) THEN 
            #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_crad_m.crad001 != g_crad001_t  OR g_crad_m.crad002 != g_crad002_t  OR g_crad_m.crad003 != g_crad003_t  OR g_crad_m.crad004 != g_crad004_t )) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM crad_t WHERE "||"cradent = '" ||g_enterprise|| "' AND "||"crad001 = '"||g_crad_m.crad001 ||"' AND "|| "crad002 = '"||g_crad_m.crad002 ||"' AND "|| "crad003 = '"||g_crad_m.crad003 ||"' AND "|| "crad004 = '"||g_crad_m.crad004 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crad001
            #add-point:BEFORE FIELD crad001 name="input.b.crad001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crad001
            #add-point:ON CHANGE crad001 name="input.g.crad001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crad002
            #add-point:BEFORE FIELD crad002 name="input.b.crad002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crad002
            
            #add-point:AFTER FIELD crad002 name="input.a.crad002"
            #此段落由子樣板a05產生
            #IF  NOT cl_null(g_crad_m.crad001) AND NOT cl_null(g_crad_m.crad002) AND NOT cl_null(g_crad_m.crad003) AND NOT cl_null(g_crad_m.crad004) THEN 
            #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_crad_m.crad001 != g_crad001_t  OR g_crad_m.crad002 != g_crad002_t  OR g_crad_m.crad003 != g_crad003_t  OR g_crad_m.crad004 != g_crad004_t )) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM crad_t WHERE "||"cradent = '" ||g_enterprise|| "' AND "||"crad001 = '"||g_crad_m.crad001 ||"' AND "|| "crad002 = '"||g_crad_m.crad002 ||"' AND "|| "crad003 = '"||g_crad_m.crad003 ||"' AND "|| "crad004 = '"||g_crad_m.crad004 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crad002
            #add-point:ON CHANGE crad002 name="input.g.crad002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crad003
            
            #add-point:AFTER FIELD crad003 name="input.a.crad003"
            LET g_crad_m.crad003_desc = ' '
            DISPLAY BY NAME g_crad_m.crad003_desc
            IF NOT cl_null(g_crad_m.crad003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_crad_m.crad003 != g_crad_m_t.crad003 OR g_crad_m_t.crad003 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_crad_m.crad003
                  IF NOT cl_chk_exist("v_craa001") THEN
                     LET g_crad_m.crad003 = g_crad_m_t.crad003
                     LET g_crad_m.crad003_desc = acrm350_get_crad003_ref(g_crad_m.crad003)
                     DISPLAY BY NAME g_crad_m.crad003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_crad_m.crad003_desc = acrm350_get_crad003_ref(g_crad_m.crad003)
            DISPLAY BY NAME g_crad_m.crad003_desc

            #此段落由子樣板a05產生
            #IF  NOT cl_null(g_crad_m.crad001) AND NOT cl_null(g_crad_m.crad002) AND NOT cl_null(g_crad_m.crad003) AND NOT cl_null(g_crad_m.crad004) THEN 
            #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_crad_m.crad001 != g_crad001_t  OR g_crad_m.crad002 != g_crad002_t  OR g_crad_m.crad003 != g_crad003_t  OR g_crad_m.crad004 != g_crad004_t )) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM crad_t WHERE "||"cradent = '" ||g_enterprise|| "' AND "||"crad001 = '"||g_crad_m.crad001 ||"' AND "|| "crad002 = '"||g_crad_m.crad002 ||"' AND "|| "crad003 = '"||g_crad_m.crad003 ||"' AND "|| "crad004 = '"||g_crad_m.crad004 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crad003
            #add-point:BEFORE FIELD crad003 name="input.b.crad003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crad003
            #add-point:ON CHANGE crad003 name="input.g.crad003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crad004
            #add-point:BEFORE FIELD crad004 name="input.b.crad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crad004
            
            #add-point:AFTER FIELD crad004 name="input.a.crad004"
            #此段落由子樣板a05產生
            #IF  NOT cl_null(g_crad_m.crad001) AND NOT cl_null(g_crad_m.crad002) AND NOT cl_null(g_crad_m.crad003) AND NOT cl_null(g_crad_m.crad004) THEN 
            #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_crad_m.crad001 != g_crad001_t  OR g_crad_m.crad002 != g_crad002_t  OR g_crad_m.crad003 != g_crad003_t  OR g_crad_m.crad004 != g_crad004_t )) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM crad_t WHERE "||"cradent = '" ||g_enterprise|| "' AND "||"crad001 = '"||g_crad_m.crad001 ||"' AND "|| "crad002 = '"||g_crad_m.crad002 ||"' AND "|| "crad003 = '"||g_crad_m.crad003 ||"' AND "|| "crad004 = '"||g_crad_m.crad004 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF

            IF NOT cl_null(g_crad_m.crad001) AND (p_cmd = 'a' OR ( p_cmd = 'u' AND g_crad_m.crad004 != g_crad_m_t.crad004)) THEN
               IF g_crad_m.crad004 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00026'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crad004
            #add-point:ON CHANGE crad004 name="input.g.crad004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cradunit
            
            #add-point:AFTER FIELD cradunit name="input.a.cradunit"
            LET g_crad_m.cradunit_desc = NULL
            DISPLAY BY NAME g_crad_m.cradunit_desc
            IF NOT cl_null(g_crad_m.cradunit) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_crad_m.cradunit != g_crad_m_t.cradunit OR g_crad_m_t.cradunit IS null)) THEN
                  CALL s_aooi500_chk(g_prog,'cradunit',g_crad_m.cradunit,g_site)
                   RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_crad_m.cradunit
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_crad_m.cradunit = g_crad_m_t.cradunit
                     LET g_crad_m.cradunit_desc = acrm350_get_org_ref(g_crad_m.cradunit)
                     DISPLAY BY NAME g_crad_m.cradunit_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_crad_m.cradunit_desc = acrm350_get_org_ref(g_crad_m.cradunit)
            DISPLAY BY NAME g_crad_m.cradunit_desc    

            CALL acrm350_set_entry(p_cmd)      #161024-00025#6--ADD
            CALL acrm350_set_no_entry(p_cmd)   #161024-00025#6--ADD
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cradunit
            #add-point:BEFORE FIELD cradunit name="input.b.cradunit"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE cradunit
            #add-point:ON CHANGE cradunit name="input.g.cradunit"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.crad001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crad001
            #add-point:ON ACTION controlp INFIELD crad001 name="input.c.crad001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_crad_m.crad001             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_ooag001()                                #呼叫開窗
            LET g_crad_m.crad001 = g_qryparam.return1       
            DISPLAY g_crad_m.crad001 TO crad001              #

            LET g_crad_m.crad001_desc = s_desc_get_person_desc(g_crad_m.crad001)
            DISPLAY BY NAME g_crad_m.crad001_desc
            
            NEXT FIELD crad001                          #返回原欄位            
            #END add-point
 
 
         #Ctrlp:input.c.crad002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crad002
            #add-point:ON ACTION controlp INFIELD crad002 name="input.c.crad002"
            
            #END add-point
 
 
         #Ctrlp:input.c.crad003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crad003
            #add-point:ON ACTION controlp INFIELD crad003 name="input.c.crad003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_crad_m.crad003             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #            
            CALL q_craa001()                                #呼叫開窗
            LET g_crad_m.crad003 = g_qryparam.return1            
            DISPLAY g_crad_m.crad003 TO crad003              #

            LET g_crad_m.crad003_desc = acrm350_get_crad003_ref(g_crad_m.crad003)
            DISPLAY BY NAME g_crad_m.crad003_desc
            
            NEXT FIELD crad003                          #返回原欄位            
            #END add-point
 
 
         #Ctrlp:input.c.crad004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crad004
            #add-point:ON ACTION controlp INFIELD crad004 name="input.c.crad004"
            
            #END add-point
 
 
         #Ctrlp:input.c.cradunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cradunit
            #add-point:ON ACTION controlp INFIELD cradunit name="input.c.cradunit"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_crad_m.cradunit
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'cradunit',g_site,'i') #150308-00001#1  By Ken add 'i' 150309
            CALL q_ooef001_24()
            LET g_crad_m.cradunit = g_qryparam.return1           #將開窗取得的值回傳到變數
            DISPLAY g_crad_m.cradunit TO cradunit                #顯示到畫面上
            LET g_crad_m.cradunit_desc = acrm350_get_org_ref(g_crad_m.cradunit)
            DISPLAY BY NAME g_crad_m.cradunit_desc
            NEXT FIELD cradunit                                  #返回原欄位          
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
            DISPLAY BY NAME g_crad_m.crad001             
                            ,g_crad_m.crad002   
                            ,g_crad_m.crad003   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL acrm350_crad_t_mask_restore('restore_mask_o')
            
               UPDATE crad_t SET (crad001,crad002,crad003,crad004,cradunit) = (g_crad_m.crad001,g_crad_m.crad002, 
                   g_crad_m.crad003,g_crad_m.crad004,g_crad_m.cradunit)
                WHERE cradent = g_enterprise AND crad001 = g_crad001_t
                  AND crad002 = g_crad002_t
                  AND crad003 = g_crad003_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "crad_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "crad_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_crad_m.crad001
               LET gs_keys_bak[1] = g_crad001_t
               LET gs_keys[2] = g_crad_m.crad002
               LET gs_keys_bak[2] = g_crad002_t
               LET gs_keys[3] = g_crad_m.crad003
               LET gs_keys_bak[3] = g_crad003_t
               LET gs_keys[4] = g_crad_d[g_detail_idx].crad005
               LET gs_keys_bak[4] = g_crad_d_t.crad005
               CALL acrm350_update_b('crad_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_crad_m_t)
                     #LET g_log2 = util.JSON.stringify(g_crad_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL acrm350_crad_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL acrm350_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_crad001_t = g_crad_m.crad001
           LET g_crad002_t = g_crad_m.crad002
           LET g_crad003_t = g_crad_m.crad003
 
           
           IF g_crad_d.getLength() = 0 THEN
              NEXT FIELD crad005
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="acrm350.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_crad_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_crad_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL acrm350_b_fill(g_wc2) #test 
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
            CALL acrm350_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN acrm350_cl USING g_enterprise,g_crad_m.crad001,g_crad_m.crad002,g_crad_m.crad003                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE acrm350_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN acrm350_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_crad_d[l_ac].crad005 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_crad_d_t.* = g_crad_d[l_ac].*  #BACKUP
               LET g_crad_d_o.* = g_crad_d[l_ac].*  #BACKUP
               CALL acrm350_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL acrm350_set_no_entry_b(l_cmd)
               OPEN acrm350_bcl USING g_enterprise,g_crad_m.crad001,
                                                g_crad_m.crad002,
                                                g_crad_m.crad003,
 
                                                g_crad_d_t.crad005
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN acrm350_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH acrm350_bcl INTO g_crad_d[l_ac].cradstus,g_crad_d[l_ac].crad005,g_crad_d[l_ac].crad006, 
                      g_crad_d[l_ac].crad007,g_crad2_d[l_ac].crad005,g_crad2_d[l_ac].cradownid,g_crad2_d[l_ac].cradowndp, 
                      g_crad2_d[l_ac].cradcrtid,g_crad2_d[l_ac].cradcrtdp,g_crad2_d[l_ac].cradcrtdt, 
                      g_crad2_d[l_ac].cradmodid,g_crad2_d[l_ac].cradmoddt,g_crad2_d[l_ac].cradcnfid, 
                      g_crad2_d[l_ac].cradcnfdt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_crad_d_t.crad005,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_crad_d_mask_o[l_ac].* =  g_crad_d[l_ac].*
                  CALL acrm350_crad_t_mask()
                  LET g_crad_d_mask_n[l_ac].* =  g_crad_d[l_ac].*
                  
                  CALL acrm350_ref_show()
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
            INITIALIZE g_crad_d_t.* TO NULL
            INITIALIZE g_crad_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_crad_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_crad2_d[l_ac].cradownid = g_user
      LET g_crad2_d[l_ac].cradowndp = g_dept
      LET g_crad2_d[l_ac].cradcrtid = g_user
      LET g_crad2_d[l_ac].cradcrtdp = g_dept 
      LET g_crad2_d[l_ac].cradcrtdt = cl_get_current()
      LET g_crad2_d[l_ac].cradmodid = g_user
      LET g_crad2_d[l_ac].cradmoddt = cl_get_current()
      LET g_crad_d[l_ac].cradstus = ''
 
 
  
            #一般欄位預設值
                  LET g_crad_d[l_ac].cradstus = "Y"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_crad_d_t.* = g_crad_d[l_ac].*     #新輸入資料
            LET g_crad_d_o.* = g_crad_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL acrm350_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL acrm350_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_crad_d[li_reproduce_target].* = g_crad_d[li_reproduce].*
               LET g_crad2_d[li_reproduce_target].* = g_crad2_d[li_reproduce].*
 
               LET g_crad_d[g_crad_d.getLength()].crad005 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_crad_d[l_ac].crad005 = acrm350_get_crad005(g_crad_m.crad001,g_crad_m.crad002,g_crad_m.crad003)
            LET g_crad_d_t.* = g_crad_d[l_ac].*
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
            SELECT COUNT(1) INTO l_count FROM crad_t 
             WHERE cradent = g_enterprise AND crad001 = g_crad_m.crad001
               AND crad002 = g_crad_m.crad002
               AND crad003 = g_crad_m.crad003
 
               AND crad005 = g_crad_d[l_ac].crad005
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO crad_t
                           (cradent,
                            crad001,crad002,crad003,crad004,cradunit,
                            crad005
                            ,cradstus,crad006,crad007,cradownid,cradowndp,cradcrtid,cradcrtdp,cradcrtdt,cradmodid,cradmoddt,cradcnfid,cradcnfdt) 
                     VALUES(g_enterprise,
                            g_crad_m.crad001,g_crad_m.crad002,g_crad_m.crad003,g_crad_m.crad004,g_crad_m.cradunit,
                            g_crad_d[l_ac].crad005
                            ,g_crad_d[l_ac].cradstus,g_crad_d[l_ac].crad006,g_crad_d[l_ac].crad007,g_crad2_d[l_ac].cradownid, 
                                g_crad2_d[l_ac].cradowndp,g_crad2_d[l_ac].cradcrtid,g_crad2_d[l_ac].cradcrtdp, 
                                g_crad2_d[l_ac].cradcrtdt,g_crad2_d[l_ac].cradmodid,g_crad2_d[l_ac].cradmoddt, 
                                g_crad2_d[l_ac].cradcnfid,g_crad2_d[l_ac].cradcnfdt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_crad_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "crad_t:",SQLERRMESSAGE 
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
               IF acrm350_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_crad_m.crad001
                  LET gs_keys[gs_keys.getLength()+1] = g_crad_m.crad002
                  LET gs_keys[gs_keys.getLength()+1] = g_crad_m.crad003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_crad_d_t.crad005
 
 
                  #刪除下層單身
                  IF NOT acrm350_key_delete_b(gs_keys,'crad_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE acrm350_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE acrm350_bcl
               LET l_count = g_crad_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_crad_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD cradstus
            #add-point:BEFORE FIELD cradstus name="input.b.page1.cradstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD cradstus
            
            #add-point:AFTER FIELD cradstus name="input.a.page1.cradstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE cradstus
            #add-point:ON CHANGE cradstus name="input.g.page1.cradstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crad005
            #add-point:BEFORE FIELD crad005 name="input.b.page1.crad005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crad005
            
            #add-point:AFTER FIELD crad005 name="input.a.page1.crad005"
            #此段落由子樣板a05產生
            IF  g_crad_m.crad001 IS NOT NULL AND g_crad_m.crad002 IS NOT NULL AND g_crad_m.crad003 IS NOT NULL AND g_crad_m.crad004 IS NOT NULL AND g_crad_d[g_detail_idx].crad005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_crad_m.crad001 != g_crad001_t OR g_crad_m.crad002 != g_crad002_t OR g_crad_m.crad003 != g_crad003_t OR g_crad_d[g_detail_idx].crad005 != g_crad_d_t.crad005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM crad_t WHERE "||"cradent = '" ||g_enterprise|| "' AND "||"crad001 = '"||g_crad_m.crad001 ||"' AND "|| "crad002 = '"||g_crad_m.crad002 ||"' AND "|| "crad003 = '"||g_crad_m.crad003 ||"' AND "|| "crad004 = '"||g_crad_m.crad004 ||"' AND "|| "crad005 = '"||g_crad_d[g_detail_idx].crad005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crad005
            #add-point:ON CHANGE crad005 name="input.g.page1.crad005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crad006
            
            #add-point:AFTER FIELD crad006 name="input.a.page1.crad006"
            IF NOT cl_null(g_crad_d[l_ac].crad006) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_crad_d[l_ac].crad006!= g_crad_d_t.crad006) THEN   
                  IF s_azzi650_chk_exist('2110',g_crad_d[l_ac].crad006    ) THEN
                  ELSE
                     LET g_crad_d[l_ac].crad006= g_crad_d_t.crad006
                     LET g_crad_d[l_ac].crad006_desc = acrm350_get_crad006_ref(g_crad_d[l_ac].crad006)
                     NEXT FIELD CURRENT
                  END IF
               END IF   
               LET g_crad_d[l_ac].crad006_desc = acrm350_get_crad006_ref(g_crad_d[l_ac].crad006)
               DISPLAY BY NAME g_crad_d[l_ac].crad006_desc
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crad006
            #add-point:BEFORE FIELD crad006 name="input.b.page1.crad006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crad006
            #add-point:ON CHANGE crad006 name="input.g.page1.crad006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crad007
            #add-point:BEFORE FIELD crad007 name="input.b.page1.crad007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crad007
            
            #add-point:AFTER FIELD crad007 name="input.a.page1.crad007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crad007
            #add-point:ON CHANGE crad007 name="input.g.page1.crad007"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.cradstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD cradstus
            #add-point:ON ACTION controlp INFIELD cradstus name="input.c.page1.cradstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.crad005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crad005
            #add-point:ON ACTION controlp INFIELD crad005 name="input.c.page1.crad005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.crad006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crad006
            #add-point:ON ACTION controlp INFIELD crad006 name="input.c.page1.crad006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_crad_d[l_ac].crad006             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "2110" #
            CALL q_oocq002_1()                                #呼叫開窗
            LET g_crad_d[l_ac].crad006 = g_qryparam.return1     
            DISPLAY g_crad_d[l_ac].crad006 TO crad006              #

            LET g_crad_d[l_ac].crad006_desc = acrm350_get_crad006_ref(g_crad_d[l_ac].crad006)
            DISPLAY BY NAME g_crad_d[l_ac].crad006_desc
            
            NEXT FIELD crad006                          #返回原欄位            
            #END add-point
 
 
         #Ctrlp:input.c.page1.crad007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crad007
            #add-point:ON ACTION controlp INFIELD crad007 name="input.c.page1.crad007"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_crad_d[l_ac].* = g_crad_d_t.*
               CLOSE acrm350_bcl
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
               LET g_errparam.extend = g_crad_d[l_ac].crad005 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_crad_d[l_ac].* = g_crad_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_crad2_d[l_ac].cradmodid = g_user 
LET g_crad2_d[l_ac].cradmoddt = cl_get_current()
LET g_crad2_d[l_ac].cradmodid_desc = cl_get_username(g_crad2_d[l_ac].cradmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL acrm350_crad_t_mask_restore('restore_mask_o')
         
               UPDATE crad_t SET (crad001,crad002,crad003,cradstus,crad005,crad006,crad007,cradownid, 
                   cradowndp,cradcrtid,cradcrtdp,cradcrtdt,cradmodid,cradmoddt,cradcnfid,cradcnfdt) = (g_crad_m.crad001, 
                   g_crad_m.crad002,g_crad_m.crad003,g_crad_d[l_ac].cradstus,g_crad_d[l_ac].crad005, 
                   g_crad_d[l_ac].crad006,g_crad_d[l_ac].crad007,g_crad2_d[l_ac].cradownid,g_crad2_d[l_ac].cradowndp, 
                   g_crad2_d[l_ac].cradcrtid,g_crad2_d[l_ac].cradcrtdp,g_crad2_d[l_ac].cradcrtdt,g_crad2_d[l_ac].cradmodid, 
                   g_crad2_d[l_ac].cradmoddt,g_crad2_d[l_ac].cradcnfid,g_crad2_d[l_ac].cradcnfdt)
                WHERE cradent = g_enterprise AND crad001 = g_crad_m.crad001 
                 AND crad002 = g_crad_m.crad002 
                 AND crad003 = g_crad_m.crad003 
 
                 AND crad005 = g_crad_d_t.crad005 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "crad_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "crad_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_crad_m.crad001
               LET gs_keys_bak[1] = g_crad001_t
               LET gs_keys[2] = g_crad_m.crad002
               LET gs_keys_bak[2] = g_crad002_t
               LET gs_keys[3] = g_crad_m.crad003
               LET gs_keys_bak[3] = g_crad003_t
               LET gs_keys[4] = g_crad_d[g_detail_idx].crad005
               LET gs_keys_bak[4] = g_crad_d_t.crad005
               CALL acrm350_update_b('crad_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_crad_m),util.JSON.stringify(g_crad_d_t)
                     LET g_log2 = util.JSON.stringify(g_crad_m),util.JSON.stringify(g_crad_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL acrm350_crad_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_crad_m.crad001
               LET ls_keys[ls_keys.getLength()+1] = g_crad_m.crad002
               LET ls_keys[ls_keys.getLength()+1] = g_crad_m.crad003
 
               LET ls_keys[ls_keys.getLength()+1] = g_crad_d_t.crad005
 
               CALL acrm350_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE acrm350_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_crad_d[l_ac].* = g_crad_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE acrm350_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_crad_d.getLength() = 0 THEN
               NEXT FIELD crad005
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_crad_d[li_reproduce_target].* = g_crad_d[li_reproduce].*
               LET g_crad2_d[li_reproduce_target].* = g_crad2_d[li_reproduce].*
 
               LET g_crad_d[li_reproduce_target].crad005 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_crad_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_crad_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_crad2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL acrm350_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL acrm350_idx_chk()
            CALL acrm350_ui_detailshow()
        
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
            NEXT FIELD crad001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD cradstus
               WHEN "s_detail2"
                  NEXT FIELD crad005_2
 
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
 
{<section id="acrm350.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION acrm350_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL acrm350_b_fill(g_wc2) #第一階單身填充
      CALL acrm350_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL acrm350_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_crad_m.crad001,g_crad_m.crad001_desc,g_crad_m.crad002,g_crad_m.crad003,g_crad_m.crad003_desc, 
       g_crad_m.crad004,g_crad_m.cradunit,g_crad_m.cradunit_desc
 
   CALL acrm350_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="acrm350.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION acrm350_ref_show()
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
   LET g_crad_m.crad001_desc = s_desc_get_person_desc(g_crad_m.crad001)
   DISPLAY BY NAME g_crad_m.crad001_desc
   
   LET g_crad_m.crad003_desc = acrm350_get_crad003_ref(g_crad_m.crad003)
   DISPLAY BY NAME g_crad_m.crad003_desc
   
   LET g_crad_m.cradunit_desc = acrm350_get_org_ref(g_crad_m.cradunit)
   DISPLAY BY NAME g_crad_m.cradunit_desc
   
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_crad_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"

       LET g_crad_d[l_ac].crad006_desc = acrm350_get_crad006_ref(g_crad_d[l_ac].crad006)
       DISPLAY BY NAME g_crad_d[l_ac].crad006_desc

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_crad2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"

      LET g_crad2_d[l_ac].cradownid_desc = s_desc_get_person_desc(g_crad2_d[l_ac].cradownid)
      DISPLAY BY NAME g_crad2_d[l_ac].cradownid_desc

      LET g_crad2_d[l_ac].cradowndp_desc = acrm350_get_org_ref(g_crad2_d[l_ac].cradowndp)
      DISPLAY BY NAME g_crad2_d[l_ac].cradowndp_desc

      LET g_crad2_d[l_ac].cradcrtid_desc = s_desc_get_person_desc(g_crad2_d[l_ac].cradcrtid)
      DISPLAY BY NAME g_crad2_d[l_ac].cradcrtid_desc

      LET g_crad2_d[l_ac].cradcrtdp_desc = acrm350_get_org_ref(g_crad2_d[l_ac].cradcrtdp)
      DISPLAY BY NAME g_crad2_d[l_ac].cradcrtdp_desc

      LET g_crad2_d[l_ac].cradmodid_desc = s_desc_get_person_desc(g_crad2_d[l_ac].cradmodid)
      DISPLAY BY NAME g_crad2_d[l_ac].cradmodid_desc

      LET g_crad2_d[l_ac].cradcnfid_desc = acrm350_get_org_ref(g_crad2_d[l_ac].cradcnfid)
      DISPLAY BY NAME g_crad2_d[l_ac].cradcnfid_desc

      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="acrm350.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION acrm350_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE crad_t.crad001 
   DEFINE l_oldno     LIKE crad_t.crad001 
   DEFINE l_newno02     LIKE crad_t.crad002 
   DEFINE l_oldno02     LIKE crad_t.crad002 
   DEFINE l_newno03     LIKE crad_t.crad003 
   DEFINE l_oldno03     LIKE crad_t.crad003 
 
   DEFINE l_master    RECORD LIKE crad_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE crad_t.* #此變數樣板目前無使用
 
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
 
   IF g_crad_m.crad001 IS NULL
      OR g_crad_m.crad002 IS NULL
      OR g_crad_m.crad003 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_crad001_t = g_crad_m.crad001
   LET g_crad002_t = g_crad_m.crad002
   LET g_crad003_t = g_crad_m.crad003
 
   
   LET g_crad_m.crad001 = ""
   LET g_crad_m.crad002 = ""
   LET g_crad_m.crad003 = ""
 
   LET g_master_insert = FALSE
   CALL acrm350_set_entry('a')
   CALL acrm350_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_crad_m.crad001_desc = ''
   DISPLAY BY NAME g_crad_m.crad001_desc
   LET g_crad_m.crad003_desc = ''
   DISPLAY BY NAME g_crad_m.crad003_desc
   LET g_crad_m.cradunit = g_site
   LET g_crad_m.cradunit_desc = acrm350_get_org_ref(g_crad_m.cradunit)
   DISPLAY BY NAME g_crad_m.cradunit,g_crad_m.cradunit_desc
   #end add-point
   
   #清空key欄位的desc
      LET g_crad_m.crad001_desc = ''
   DISPLAY BY NAME g_crad_m.crad001_desc
   LET g_crad_m.crad003_desc = ''
   DISPLAY BY NAME g_crad_m.crad003_desc
 
   
   CALL acrm350_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_crad_m.* TO NULL
      INITIALIZE g_crad_d TO NULL
      INITIALIZE g_crad2_d TO NULL
 
      CALL acrm350_show()
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
   CALL acrm350_set_act_visible()
   CALL acrm350_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_crad001_t = g_crad_m.crad001
   LET g_crad002_t = g_crad_m.crad002
   LET g_crad003_t = g_crad_m.crad003
 
   
   #組合新增資料的條件
   LET g_add_browse = " cradent = " ||g_enterprise|| " AND",
                      " crad001 = '", g_crad_m.crad001, "' "
                      ," AND crad002 = '", g_crad_m.crad002, "' "
                      ," AND crad003 = '", g_crad_m.crad003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL acrm350_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL acrm350_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
 
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL acrm350_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="acrm350.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION acrm350_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE crad_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE acrm350_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM crad_t
    WHERE cradent = g_enterprise AND crad001 = g_crad001_t
    AND crad002 = g_crad002_t
    AND crad003 = g_crad003_t
 
       INTO TEMP acrm350_detail
   
   #將key修正為調整後   
   UPDATE acrm350_detail 
      #更新key欄位
      SET crad001 = g_crad_m.crad001
          , crad002 = g_crad_m.crad002
          , crad003 = g_crad_m.crad003
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , cradownid = g_user 
       , cradowndp = g_dept
       , cradcrtid = g_user
       , cradcrtdp = g_dept 
       , cradcrtdt = ld_date
       , cradmodid = g_user
       , cradmoddt = ld_date
      #, cradstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO crad_t SELECT * FROM acrm350_detail
   
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
   DROP TABLE acrm350_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_crad001_t = g_crad_m.crad001
   LET g_crad002_t = g_crad_m.crad002
   LET g_crad003_t = g_crad_m.crad003
 
   
   DROP TABLE acrm350_detail
   
END FUNCTION
 
{</section>}
 
{<section id="acrm350.delete" >}
#+ 資料刪除
PRIVATE FUNCTION acrm350_delete()
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
   
   IF g_crad_m.crad001 IS NULL
   OR g_crad_m.crad002 IS NULL
   OR g_crad_m.crad003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN acrm350_cl USING g_enterprise,g_crad_m.crad001,g_crad_m.crad002,g_crad_m.crad003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN acrm350_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE acrm350_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE acrm350_master_referesh USING g_crad_m.crad001,g_crad_m.crad002,g_crad_m.crad003 INTO g_crad_m.crad001, 
       g_crad_m.crad002,g_crad_m.crad003,g_crad_m.crad004,g_crad_m.cradunit,g_crad_m.crad001_desc,g_crad_m.crad003_desc, 
       g_crad_m.cradunit_desc
   
   #遮罩相關處理
   LET g_crad_m_mask_o.* =  g_crad_m.*
   CALL acrm350_crad_t_mask()
   LET g_crad_m_mask_n.* =  g_crad_m.*
   
   CALL acrm350_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL acrm350_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM crad_t WHERE cradent = g_enterprise AND crad001 = g_crad_m.crad001
                                                               AND crad002 = g_crad_m.crad002
                                                               AND crad003 = g_crad_m.crad003
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "crad_t:",SQLERRMESSAGE 
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
      #   CLOSE acrm350_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_crad_d.clear() 
      CALL g_crad2_d.clear()       
 
     
      CALL acrm350_ui_browser_refresh()  
      #CALL acrm350_ui_headershow()  
      #CALL acrm350_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL acrm350_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL acrm350_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE acrm350_cl
 
   #功能已完成,通報訊息中心
   CALL acrm350_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="acrm350.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION acrm350_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_crad_d.clear()
   CALL g_crad2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT cradstus,crad005,crad006,crad007,crad005,cradownid,cradowndp,cradcrtid, 
       cradcrtdp,cradcrtdt,cradmodid,cradmoddt,cradcnfid,cradcnfdt,t1.oocql004 ,t2.ooag011 ,t3.ooefl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooag011 FROM crad_t",   
               "",
               
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='2110' AND t1.oocql002=crad006 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=cradownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=cradowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=cradcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=cradcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=cradmodid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=cradcnfid  ",
 
               " WHERE cradent= ? AND crad001=? AND crad002=? AND crad003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("crad_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF acrm350_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY crad_t.crad005"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE acrm350_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR acrm350_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_crad_m.crad001,g_crad_m.crad002,g_crad_m.crad003   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_crad_m.crad001,g_crad_m.crad002,g_crad_m.crad003 INTO g_crad_d[l_ac].cradstus, 
          g_crad_d[l_ac].crad005,g_crad_d[l_ac].crad006,g_crad_d[l_ac].crad007,g_crad2_d[l_ac].crad005, 
          g_crad2_d[l_ac].cradownid,g_crad2_d[l_ac].cradowndp,g_crad2_d[l_ac].cradcrtid,g_crad2_d[l_ac].cradcrtdp, 
          g_crad2_d[l_ac].cradcrtdt,g_crad2_d[l_ac].cradmodid,g_crad2_d[l_ac].cradmoddt,g_crad2_d[l_ac].cradcnfid, 
          g_crad2_d[l_ac].cradcnfdt,g_crad_d[l_ac].crad006_desc,g_crad2_d[l_ac].cradownid_desc,g_crad2_d[l_ac].cradowndp_desc, 
          g_crad2_d[l_ac].cradcrtid_desc,g_crad2_d[l_ac].cradcrtdp_desc,g_crad2_d[l_ac].cradmodid_desc, 
          g_crad2_d[l_ac].cradcnfid_desc   #(ver:49)
                             
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
 
            CALL g_crad_d.deleteElement(g_crad_d.getLength())
      CALL g_crad2_d.deleteElement(g_crad2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_crad_d.getLength()
      LET g_crad_d_mask_o[l_ac].* =  g_crad_d[l_ac].*
      CALL acrm350_crad_t_mask()
      LET g_crad_d_mask_n[l_ac].* =  g_crad_d[l_ac].*
   END FOR
   
   LET g_crad2_d_mask_o.* =  g_crad2_d.*
   FOR l_ac = 1 TO g_crad2_d.getLength()
      LET g_crad2_d_mask_o[l_ac].* =  g_crad2_d[l_ac].*
      CALL acrm350_crad_t_mask()
      LET g_crad2_d_mask_n[l_ac].* =  g_crad2_d[l_ac].*
   END FOR
 
 
   FREE acrm350_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="acrm350.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION acrm350_idx_chk()
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
      IF g_detail_idx > g_crad_d.getLength() THEN
         LET g_detail_idx = g_crad_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_crad_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_crad_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_crad2_d.getLength() THEN
         LET g_detail_idx = g_crad2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_crad2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_crad2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="acrm350.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION acrm350_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_crad_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="acrm350.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION acrm350_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM crad_t
    WHERE cradent = g_enterprise AND crad001 = g_crad_m.crad001 AND
                              crad002 = g_crad_m.crad002 AND
                              crad003 = g_crad_m.crad003 AND
 
          crad005 = g_crad_d_t.crad005
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "crad_t:",SQLERRMESSAGE 
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
 
{<section id="acrm350.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION acrm350_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="acrm350.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION acrm350_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="acrm350.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION acrm350_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="acrm350.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION acrm350_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_crad_d[l_ac].crad005 = g_crad_d_t.crad005 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="acrm350.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION acrm350_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="acrm350.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION acrm350_lock_b(ps_table,ps_page)
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
   #CALL acrm350_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="acrm350.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION acrm350_unlock_b(ps_table,ps_page)
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
 
{<section id="acrm350.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION acrm350_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("crad001,crad002,crad003",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("cradunit",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="acrm350.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION acrm350_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("crad001,crad002,crad003",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'cradunit') THEN
      CALL cl_set_comp_entry("cradunit",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="acrm350.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION acrm350_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="acrm350.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION acrm350_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="acrm350.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION acrm350_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrm350.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION acrm350_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrm350.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION acrm350_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrm350.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION acrm350_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrm350.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION acrm350_default_search()
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
      LET ls_wc = ls_wc, " crad001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " crad002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " crad003 = '", g_argv[03], "' AND "
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
 
{<section id="acrm350.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION acrm350_fill_chk(ps_idx)
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
 
{<section id="acrm350.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION acrm350_modify_detail_chk(ps_record)
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
         LET ls_return = "cradstus"
      WHEN "s_detail2"
         LET ls_return = "crad005_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="acrm350.mask_functions" >}
&include "erp/acr/acrm350_mask.4gl"
 
{</section>}
 
{<section id="acrm350.state_change" >}
    
 
{</section>}
 
{<section id="acrm350.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION acrm350_set_pk_array()
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
   LET g_pk_array[1].values = g_crad_m.crad001
   LET g_pk_array[1].column = 'crad001'
   LET g_pk_array[2].values = g_crad_m.crad002
   LET g_pk_array[2].column = 'crad002'
   LET g_pk_array[3].values = g_crad_m.crad003
   LET g_pk_array[3].column = 'crad003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="acrm350.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION acrm350_msgcentre_notify(lc_state)
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
   CALL acrm350_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_crad_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="acrm350.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取項次
# Memo...........:
# Usage..........: CALL acrm350_get_crad005(p_crad001,p_crad002,p_crad003)
#                  RETURNING r_crad005
# Input parameter: p_crad001   業務人員
#                  p_crad002   日報日期
#                  p_crad003   潛客編號
# Return code....: r_crad005   項次
# Date & Author..: 2014/04/23 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION acrm350_get_crad005(p_crad001,p_crad002,p_crad003)
   DEFINE p_crad001   LIKE crad_t.crad001
   DEFINE p_crad002   LIKE crad_t.crad002
   DEFINE p_crad003   LIKE crad_t.crad003
   DEFINE r_crad005   LIKE crad_t.crad005
   
   LET r_crad005 = NULL
   
   SELECT MAX(crad005)+1 INTO r_crad005
     FROM crad_t
    WHERE cradent =  g_enterprise AND crad001 = p_crad001
      AND crad002 = p_crad002 AND crad003 = p_crad003
      
   IF cl_null(r_crad005) THEN
      LET r_crad005 = 1
   END IF
   
   RETURN r_crad005
END FUNCTION

################################################################################
# Descriptions...: 組織說明
# Memo...........:
# Usage..........: CALL acrm350_get_org_ref(p_org_id)
#                  RETURNING r_org_desc
# Input parameter: p_org_id    組織編號
# Return code....: r_org_desc  組織說明
# Date & Author..: 2014/04/24 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION acrm350_get_org_ref(p_org_id)
   DEFINE p_org_id     LIKE crac_t.cracunit
   DEFINE r_org_desc   LIKE ooefl_t.ooefl003
   
   LET r_org_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_org_id
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_org_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_org_desc
END FUNCTION

################################################################################
# Descriptions...: 潛客名稱
# Memo...........:
# Usage..........: CALL acrm350_get_crad003_ref(p_crad003)
#                  RETURNING r_crac001_desc
# Input parameter: p_crad003        潛客編號
# Return code....: r_crad003_desc   潛客說明
# Date & Author..: 2014/04/24 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION acrm350_get_crad003_ref(p_crad003)
   DEFINE p_crad003        LIKE crad_t.crad003
   DEFINE r_crad003_desc   LIKE craal_t.craal004
   
   LET r_crad003_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_crad003
   CALL ap_ref_array2(g_ref_fields,"SELECT craal004 FROM craal_t WHERE craalent='"||g_enterprise||"' AND craal001=? AND craal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_crad003_desc = '', g_rtn_fields[1] , ''

   RETURN r_crad003_desc
END FUNCTION

################################################################################
# Descriptions...: 日報類型說明
# Memo...........:
# Usage..........: CALL acrm350_get_crad006_ref(p_crad006)
#                  RETURNING r_crad006_desc
# Input parameter: p_crad006       日報類型編碼
# Return code....: r_crad006_desc  日報類型說明 
# Date & Author..: 2014/04/24 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION acrm350_get_crad006_ref(p_crad006)
   DEFINE p_crad006      LIKE crad_t.crad006
   DEFINE r_crad006_desc LIKE oocql_t.oocql004
   
   LET r_crad006_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_crad006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2110' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_crad006_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_crad006_desc
END FUNCTION

 
{</section>}
 