#該程式未解開Section, 採用最新樣板產出!
{<section id="arti705.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2015-01-15 20:23:21), PR版次:0008(2016-10-28 13:55:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000204
#+ Filename...: arti705
#+ Description: 自動補貨配送商品依品類設定配送單日
#+ Creator....: 02749(2014-03-27 16:00:28)
#+ Modifier...: 02159 -SD/PR- 08742
 
{</section>}
 
{<section id="arti705.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#41  2016/04/25  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160905-00007#14  2016/09/05  By 07900    调整系统中无ENT的SQL条件增加ent
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
PRIVATE type type_g_rtkb_m        RECORD
       rtkb001 LIKE rtkb_t.rtkb001, 
   rtkb002 LIKE rtkb_t.rtkb002, 
   rtkb002_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_rtkb_d        RECORD
       rtkbstus LIKE rtkb_t.rtkbstus, 
   rtkb003 LIKE rtkb_t.rtkb003, 
   rtkb003_desc LIKE type_t.chr500, 
   rtkb004 LIKE rtkb_t.rtkb004, 
   rtkb005 LIKE rtkb_t.rtkb005, 
   rtkb006 LIKE rtkb_t.rtkb006, 
   rtkb007 LIKE rtkb_t.rtkb007, 
   rtkb007_desc LIKE type_t.chr500, 
   rtkb008 LIKE rtkb_t.rtkb008, 
   rtkb009 LIKE rtkb_t.rtkb009, 
   rtkbunit LIKE rtkb_t.rtkbunit
       END RECORD
PRIVATE TYPE type_g_rtkb2_d RECORD
       rtkb003 LIKE rtkb_t.rtkb003, 
   rtkbownid LIKE rtkb_t.rtkbownid, 
   rtkbownid_desc LIKE type_t.chr500, 
   rtkbowndp LIKE rtkb_t.rtkbowndp, 
   rtkbowndp_desc LIKE type_t.chr500, 
   rtkbcrtid LIKE rtkb_t.rtkbcrtid, 
   rtkbcrtid_desc LIKE type_t.chr500, 
   rtkbcrtdp LIKE rtkb_t.rtkbcrtdp, 
   rtkbcrtdp_desc LIKE type_t.chr500, 
   rtkbcrtdt DATETIME YEAR TO SECOND, 
   rtkbmodid LIKE rtkb_t.rtkbmodid, 
   rtkbmodid_desc LIKE type_t.chr500, 
   rtkbmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE tok                   base.StringTokenizer #sakura add 141230-00008#2
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_rtkb_m          type_g_rtkb_m
DEFINE g_rtkb_m_t        type_g_rtkb_m
DEFINE g_rtkb_m_o        type_g_rtkb_m
DEFINE g_rtkb_m_mask_o   type_g_rtkb_m #轉換遮罩前資料
DEFINE g_rtkb_m_mask_n   type_g_rtkb_m #轉換遮罩後資料
 
   DEFINE g_rtkb001_t LIKE rtkb_t.rtkb001
DEFINE g_rtkb002_t LIKE rtkb_t.rtkb002
 
 
DEFINE g_rtkb_d          DYNAMIC ARRAY OF type_g_rtkb_d
DEFINE g_rtkb_d_t        type_g_rtkb_d
DEFINE g_rtkb_d_o        type_g_rtkb_d
DEFINE g_rtkb_d_mask_o   DYNAMIC ARRAY OF type_g_rtkb_d #轉換遮罩前資料
DEFINE g_rtkb_d_mask_n   DYNAMIC ARRAY OF type_g_rtkb_d #轉換遮罩後資料
DEFINE g_rtkb2_d   DYNAMIC ARRAY OF type_g_rtkb2_d
DEFINE g_rtkb2_d_t type_g_rtkb2_d
DEFINE g_rtkb2_d_o type_g_rtkb2_d
DEFINE g_rtkb2_d_mask_o   DYNAMIC ARRAY OF type_g_rtkb2_d #轉換遮罩前資料
DEFINE g_rtkb2_d_mask_n   DYNAMIC ARRAY OF type_g_rtkb2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_rtkb001 LIKE rtkb_t.rtkb001,
      b_rtkb002 LIKE rtkb_t.rtkb002
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
 
{<section id="arti705.main" >}
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
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT rtkb001,rtkb002,''", 
                      " FROM rtkb_t",
                      " WHERE rtkbent= ? AND rtkb001=? AND rtkb002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE arti705_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.rtkb001,t0.rtkb002,t1.rtaal003",
               " FROM rtkb_t t0",
                              " LEFT JOIN rtaal_t t1 ON t1.rtaalent="||g_enterprise||" AND t1.rtaal001=t0.rtkb002 AND t1.rtaal002='"||g_dlang||"' ",
 
               " WHERE t0.rtkbent = " ||g_enterprise|| " AND t0.rtkb001 = ? AND t0.rtkb002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE arti705_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_arti705 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL arti705_init()   
 
      #進入選單 Menu (="N")
      CALL arti705_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_arti705
      
   END IF 
   
   CLOSE arti705_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="arti705.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION arti705_init()
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
   
      CALL cl_set_combo_scc('rtkb001','6030') 
   CALL cl_set_combo_scc('rtkb004','6019') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   CALL cl_set_combo_scc_part('rtkb004','6019','1,2')
   LET g_errshow = '1'
   #end add-point
   
   CALL arti705_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="arti705.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION arti705_ui_dialog()
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
         INITIALIZE g_rtkb_m.* TO NULL
         CALL g_rtkb_d.clear()
         CALL g_rtkb2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL arti705_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_rtkb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL arti705_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL arti705_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_rtkb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL arti705_idx_chk()
               CALL arti705_ui_detailshow()
               
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
            CALL arti705_browser_fill("")
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
               CALL arti705_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL arti705_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            CALL arti705_rtkb001_comm_visable(g_rtkb_m.rtkb001)
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL arti705_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL arti705_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL arti705_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL arti705_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL arti705_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL arti705_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL arti705_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL arti705_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL arti705_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL arti705_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_rtkb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_rtkb2_d)
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
               NEXT FIELD rtkb003
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
               CALL arti705_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL arti705_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL arti705_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL arti705_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL arti705_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL arti705_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL arti705_insert()
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
               CALL arti705_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL arti705_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL arti705_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL arti705_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL arti705_set_pk_array()
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
 
{<section id="arti705.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION arti705_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="arti705.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION arti705_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "rtkb001,rtkb002"
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
      LET l_sub_sql = " SELECT DISTINCT rtkb001 ",
                      ", rtkb002 ",
 
                      " FROM rtkb_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE rtkbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("rtkb_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT rtkb001 ",
                      ", rtkb002 ",
 
                      " FROM rtkb_t ",
                      " ",
                      " ", 
 
 
                      " WHERE rtkbent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("rtkb_t")
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
      INITIALIZE g_rtkb_m.* TO NULL
      CALL g_rtkb_d.clear()        
      CALL g_rtkb2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.rtkb001,t0.rtkb002 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.rtkb001,t0.rtkb002",
                " FROM rtkb_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.rtkbent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("rtkb_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtkb_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_rtkb001,g_browser[g_cnt].b_rtkb002 
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
   
   IF cl_null(g_browser[g_cnt].b_rtkb001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_rtkb_m.* TO NULL
      CALL g_rtkb_d.clear()
      CALL g_rtkb2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL arti705_fetch('')
   
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
 
{<section id="arti705.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION arti705_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_rtkb_m.rtkb001 = g_browser[g_current_idx].b_rtkb001   
   LET g_rtkb_m.rtkb002 = g_browser[g_current_idx].b_rtkb002   
 
   EXECUTE arti705_master_referesh USING g_rtkb_m.rtkb001,g_rtkb_m.rtkb002 INTO g_rtkb_m.rtkb001,g_rtkb_m.rtkb002, 
       g_rtkb_m.rtkb002_desc
   CALL arti705_show()
   
END FUNCTION
 
{</section>}
 
{<section id="arti705.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION arti705_ui_detailshow()
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
 
{<section id="arti705.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION arti705_ui_browser_refresh()
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
      IF g_browser[l_i].b_rtkb001 = g_rtkb_m.rtkb001 
         AND g_browser[l_i].b_rtkb002 = g_rtkb_m.rtkb002 
 
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
 
{<section id="arti705.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION arti705_construct()
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
   INITIALIZE g_rtkb_m.* TO NULL
   CALL g_rtkb_d.clear()
   CALL g_rtkb2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON rtkb001,rtkb002
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb001
            #add-point:BEFORE FIELD rtkb001 name="construct.b.rtkb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb001
            
            #add-point:AFTER FIELD rtkb001 name="construct.a.rtkb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtkb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb001
            #add-point:ON ACTION controlp INFIELD rtkb001 name="construct.c.rtkb001"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb002
            #add-point:BEFORE FIELD rtkb002 name="construct.b.rtkb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb002
            
            #add-point:AFTER FIELD rtkb002 name="construct.a.rtkb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtkb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb002
            #add-point:ON ACTION controlp INFIELD rtkb002 name="construct.c.rtkb002"
            IF s_aooi500_setpoint(g_prog,'rtkb002') THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtkb002',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO rtkb002          #顯示到畫面上
               NEXT FIELD rtkb002                             #返回原欄位  
            ELSE
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " ooef304 = 'Y' "
               CALL q_ooef001() 
               DISPLAY g_qryparam.return1 TO rtkb002
            END IF
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON rtkbstus,rtkb003,rtkb004,rtkb005,rtkb006,rtkb007,rtkb008,rtkb009,rtkbunit, 
          rtkbownid,rtkbowndp,rtkbcrtid,rtkbcrtdp,rtkbcrtdt,rtkbmodid,rtkbmoddt
           FROM s_detail1[1].rtkbstus,s_detail1[1].rtkb003,s_detail1[1].rtkb004,s_detail1[1].rtkb005, 
               s_detail1[1].rtkb006,s_detail1[1].rtkb007,s_detail1[1].rtkb008,s_detail1[1].rtkb009,s_detail1[1].rtkbunit, 
               s_detail2[1].rtkbownid,s_detail2[1].rtkbowndp,s_detail2[1].rtkbcrtid,s_detail2[1].rtkbcrtdp, 
               s_detail2[1].rtkbcrtdt,s_detail2[1].rtkbmodid,s_detail2[1].rtkbmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtkbcrtdt>>----
         AFTER FIELD rtkbcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtkbmoddt>>----
         AFTER FIELD rtkbmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtkbcnfdt>>----
         
         #----<<rtkbpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkbstus
            #add-point:BEFORE FIELD rtkbstus name="construct.b.page1.rtkbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkbstus
            
            #add-point:AFTER FIELD rtkbstus name="construct.a.page1.rtkbstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkbstus
            #add-point:ON ACTION controlp INFIELD rtkbstus name="construct.c.page1.rtkbstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtkb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb003
            #add-point:ON ACTION controlp INFIELD rtkb003 name="construct.c.page1.rtkb003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkb003  #顯示到畫面上
            NEXT FIELD rtkb003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb003
            #add-point:BEFORE FIELD rtkb003 name="construct.b.page1.rtkb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb003
            
            #add-point:AFTER FIELD rtkb003 name="construct.a.page1.rtkb003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb004
            #add-point:BEFORE FIELD rtkb004 name="construct.b.page1.rtkb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb004
            
            #add-point:AFTER FIELD rtkb004 name="construct.a.page1.rtkb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb004
            #add-point:ON ACTION controlp INFIELD rtkb004 name="construct.c.page1.rtkb004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb005
            #add-point:BEFORE FIELD rtkb005 name="construct.b.page1.rtkb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb005
            
            #add-point:AFTER FIELD rtkb005 name="construct.a.page1.rtkb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb005
            #add-point:ON ACTION controlp INFIELD rtkb005 name="construct.c.page1.rtkb005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb006
            #add-point:BEFORE FIELD rtkb006 name="construct.b.page1.rtkb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb006
            
            #add-point:AFTER FIELD rtkb006 name="construct.a.page1.rtkb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb006
            #add-point:ON ACTION controlp INFIELD rtkb006 name="construct.c.page1.rtkb006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtkb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb007
            #add-point:ON ACTION controlp INFIELD rtkb007 name="construct.c.page1.rtkb007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkb007  #顯示到畫面上
            NEXT FIELD rtkb007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb007
            #add-point:BEFORE FIELD rtkb007 name="construct.b.page1.rtkb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb007
            
            #add-point:AFTER FIELD rtkb007 name="construct.a.page1.rtkb007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb008
            #add-point:BEFORE FIELD rtkb008 name="construct.b.page1.rtkb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb008
            
            #add-point:AFTER FIELD rtkb008 name="construct.a.page1.rtkb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb008
            #add-point:ON ACTION controlp INFIELD rtkb008 name="construct.c.page1.rtkb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb009
            #add-point:BEFORE FIELD rtkb009 name="construct.b.page1.rtkb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb009
            
            #add-point:AFTER FIELD rtkb009 name="construct.a.page1.rtkb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb009
            #add-point:ON ACTION controlp INFIELD rtkb009 name="construct.c.page1.rtkb009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkbunit
            #add-point:BEFORE FIELD rtkbunit name="construct.b.page1.rtkbunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkbunit
            
            #add-point:AFTER FIELD rtkbunit name="construct.a.page1.rtkbunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkbunit
            #add-point:ON ACTION controlp INFIELD rtkbunit name="construct.c.page1.rtkbunit"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtkbownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkbownid
            #add-point:ON ACTION controlp INFIELD rtkbownid name="construct.c.page2.rtkbownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkbownid  #顯示到畫面上
            NEXT FIELD rtkbownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkbownid
            #add-point:BEFORE FIELD rtkbownid name="construct.b.page2.rtkbownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkbownid
            
            #add-point:AFTER FIELD rtkbownid name="construct.a.page2.rtkbownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtkbowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkbowndp
            #add-point:ON ACTION controlp INFIELD rtkbowndp name="construct.c.page2.rtkbowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkbowndp  #顯示到畫面上
            NEXT FIELD rtkbowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkbowndp
            #add-point:BEFORE FIELD rtkbowndp name="construct.b.page2.rtkbowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkbowndp
            
            #add-point:AFTER FIELD rtkbowndp name="construct.a.page2.rtkbowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtkbcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkbcrtid
            #add-point:ON ACTION controlp INFIELD rtkbcrtid name="construct.c.page2.rtkbcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkbcrtid  #顯示到畫面上
            NEXT FIELD rtkbcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkbcrtid
            #add-point:BEFORE FIELD rtkbcrtid name="construct.b.page2.rtkbcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkbcrtid
            
            #add-point:AFTER FIELD rtkbcrtid name="construct.a.page2.rtkbcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtkbcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkbcrtdp
            #add-point:ON ACTION controlp INFIELD rtkbcrtdp name="construct.c.page2.rtkbcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkbcrtdp  #顯示到畫面上
            NEXT FIELD rtkbcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkbcrtdp
            #add-point:BEFORE FIELD rtkbcrtdp name="construct.b.page2.rtkbcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkbcrtdp
            
            #add-point:AFTER FIELD rtkbcrtdp name="construct.a.page2.rtkbcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkbcrtdt
            #add-point:BEFORE FIELD rtkbcrtdt name="construct.b.page2.rtkbcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtkbmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkbmodid
            #add-point:ON ACTION controlp INFIELD rtkbmodid name="construct.c.page2.rtkbmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkbmodid  #顯示到畫面上
            NEXT FIELD rtkbmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkbmodid
            #add-point:BEFORE FIELD rtkbmodid name="construct.b.page2.rtkbmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkbmodid
            
            #add-point:AFTER FIELD rtkbmodid name="construct.a.page2.rtkbmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkbmoddt
            #add-point:BEFORE FIELD rtkbmoddt name="construct.b.page2.rtkbmoddt"
            
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
 
{<section id="arti705.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION arti705_query()
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
   CALL g_rtkb_d.clear()
   CALL g_rtkb2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL arti705_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL arti705_browser_fill(g_wc)
      CALL arti705_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL arti705_browser_fill("F")
   
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
      CALL arti705_fetch("F") 
   END IF
   
   CALL arti705_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="arti705.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION arti705_fetch(p_flag)
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
   
   #CALL arti705_browser_fill(p_flag)
   
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
   
   LET g_rtkb_m.rtkb001 = g_browser[g_current_idx].b_rtkb001
   LET g_rtkb_m.rtkb002 = g_browser[g_current_idx].b_rtkb002
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE arti705_master_referesh USING g_rtkb_m.rtkb001,g_rtkb_m.rtkb002 INTO g_rtkb_m.rtkb001,g_rtkb_m.rtkb002, 
       g_rtkb_m.rtkb002_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "rtkb_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_rtkb_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_rtkb_m_mask_o.* =  g_rtkb_m.*
   CALL arti705_rtkb_t_mask()
   LET g_rtkb_m_mask_n.* =  g_rtkb_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL arti705_set_act_visible()
   CALL arti705_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_rtkb_m_t.* = g_rtkb_m.*
   LET g_rtkb_m_o.* = g_rtkb_m.*
   
   #重新顯示   
   CALL arti705_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="arti705.insert" >}
#+ 資料新增
PRIVATE FUNCTION arti705_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_rtkb_d.clear()
   CALL g_rtkb2_d.clear()
 
 
   INITIALIZE g_rtkb_m.* TO NULL             #DEFAULT 設定
   LET g_rtkb001_t = NULL
   LET g_rtkb002_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_rtkb_m.rtkb001 = "2"
 
     
      #add-point:單頭預設值 name="insert.default"
      LET g_rtkb_m_t.* = g_rtkb_m.*
      #end add-point 
 
      CALL arti705_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_rtkb_m.* TO NULL
         INITIALIZE g_rtkb_d TO NULL
         INITIALIZE g_rtkb2_d TO NULL
 
         CALL arti705_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_rtkb_m.* = g_rtkb_m_t.*
         CALL arti705_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_rtkb_d.clear()
      #CALL g_rtkb2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL arti705_set_act_visible()
   CALL arti705_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_rtkb001_t = g_rtkb_m.rtkb001
   LET g_rtkb002_t = g_rtkb_m.rtkb002
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtkbent = " ||g_enterprise|| " AND",
                      " rtkb001 = '", g_rtkb_m.rtkb001, "' "
                      ," AND rtkb002 = '", g_rtkb_m.rtkb002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL arti705_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL arti705_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE arti705_master_referesh USING g_rtkb_m.rtkb001,g_rtkb_m.rtkb002 INTO g_rtkb_m.rtkb001,g_rtkb_m.rtkb002, 
       g_rtkb_m.rtkb002_desc
   
   #遮罩相關處理
   LET g_rtkb_m_mask_o.* =  g_rtkb_m.*
   CALL arti705_rtkb_t_mask()
   LET g_rtkb_m_mask_n.* =  g_rtkb_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtkb_m.rtkb001,g_rtkb_m.rtkb002,g_rtkb_m.rtkb002_desc
   
   #功能已完成,通報訊息中心
   CALL arti705_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="arti705.modify" >}
#+ 資料修改
PRIVATE FUNCTION arti705_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_rtkb_m.rtkb001 IS NULL
   OR g_rtkb_m.rtkb002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_rtkb001_t = g_rtkb_m.rtkb001
   LET g_rtkb002_t = g_rtkb_m.rtkb002
 
   CALL s_transaction_begin()
   
   OPEN arti705_cl USING g_enterprise,g_rtkb_m.rtkb001,g_rtkb_m.rtkb002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN arti705_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE arti705_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE arti705_master_referesh USING g_rtkb_m.rtkb001,g_rtkb_m.rtkb002 INTO g_rtkb_m.rtkb001,g_rtkb_m.rtkb002, 
       g_rtkb_m.rtkb002_desc
   
   #遮罩相關處理
   LET g_rtkb_m_mask_o.* =  g_rtkb_m.*
   CALL arti705_rtkb_t_mask()
   LET g_rtkb_m_mask_n.* =  g_rtkb_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL arti705_show()
   WHILE TRUE
      LET g_rtkb001_t = g_rtkb_m.rtkb001
      LET g_rtkb002_t = g_rtkb_m.rtkb002
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL arti705_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_rtkb_m.* = g_rtkb_m_t.*
         CALL arti705_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_rtkb_m.rtkb001 != g_rtkb001_t 
      OR g_rtkb_m.rtkb002 != g_rtkb002_t 
 
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
   CALL arti705_set_act_visible()
   CALL arti705_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " rtkbent = " ||g_enterprise|| " AND",
                      " rtkb001 = '", g_rtkb_m.rtkb001, "' "
                      ," AND rtkb002 = '", g_rtkb_m.rtkb002, "' "
 
   #填到對應位置
   CALL arti705_browser_fill("")
 
   CALL arti705_idx_chk()
 
   CLOSE arti705_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL arti705_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="arti705.input" >}
#+ 資料輸入
PRIVATE FUNCTION arti705_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
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
   DISPLAY BY NAME g_rtkb_m.rtkb001,g_rtkb_m.rtkb002,g_rtkb_m.rtkb002_desc
   
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
   LET g_forupd_sql = "SELECT rtkbstus,rtkb003,rtkb004,rtkb005,rtkb006,rtkb007,rtkb008,rtkb009,rtkbunit, 
       rtkb003,rtkbownid,rtkbowndp,rtkbcrtid,rtkbcrtdp,rtkbcrtdt,rtkbmodid,rtkbmoddt FROM rtkb_t WHERE  
       rtkbent=? AND rtkb001=? AND rtkb002=? AND rtkb003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE arti705_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL arti705_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL arti705_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_rtkb_m.rtkb001,g_rtkb_m.rtkb002
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="arti705.input.head" >}
   
      #單頭段
      INPUT BY NAME g_rtkb_m.rtkb001,g_rtkb_m.rtkb002 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            CALL arti705_set_entry(p_cmd)
            CALL arti705_set_no_entry(p_cmd)
            CALL arti705_rtkb001_comm_visable(g_rtkb_m.rtkb001)
            CALL arti705_set_rtkb002_title()
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb001
            #add-point:BEFORE FIELD rtkb001 name="input.b.rtkb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb001
            
            #add-point:AFTER FIELD rtkb001 name="input.a.rtkb001"
            #此段落由子樣板a05產生
           #IF  NOT cl_null(g_rtkb_m.rtkb001) AND NOT cl_null(g_rtkb_m.rtkb002) THEN 
           #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rtkb_m.rtkb001 != g_rtkb001_t  OR g_rtkb_m.rtkb002 != g_rtkb002_t )) THEN 
           #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtkb_t WHERE "||"rtkbent = '" ||g_enterprise|| "' AND "||"rtkb001 = '"||g_rtkb_m.rtkb001 ||"' AND "|| "rtkb002 = '"||g_rtkb_m.rtkb002 ||"'",'std-00004',0) THEN 
           #         NEXT FIELD CURRENT
           #      END IF
           #   END IF
           #END IF
           IF NOT cl_null(g_rtkb_m.rtkb001) 
              AND (p_cmd = 'a' OR ( p_cmd = 'u' AND g_rtkb_m.rtkb001 != g_rtkb001_t)) THEN  
               CALL arti705_rtkb001_comm_visable(g_rtkb_m.rtkb001)
           END IF
           IF g_rtkb_m.rtkb001 != g_rtkb001_t THEN
              LET g_rtkb_m.rtkb002 = NULL
              LET g_rtkb_m.rtkb002_desc = NULL
              DISPLAY BY NAME g_rtkb_m.rtkb002,g_rtkb_m.rtkb002_desc
           END IF           
           CALL arti705_set_rtkb002_title()
           LET g_rtkb001_t = g_rtkb_m.rtkb001
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkb001
            #add-point:ON CHANGE rtkb001 name="input.g.rtkb001"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb002
            
            #add-point:AFTER FIELD rtkb002 name="input.a.rtkb002"
            LET g_rtkb_m.rtkb002_desc = NULL
            DISPLAY BY NAME g_rtkb_m.rtkb002_desc
            IF NOT cl_null(g_rtkb_m.rtkb002)
               AND (p_cmd = 'a' OR ( p_cmd = 'u' AND g_rtkb_m.rtkb002 != g_rtkb002_t)) THEN
               IF NOT arti705_rtkb002_chk(g_rtkb_m.rtkb002) THEN
                  LET g_rtkb_m.rtkb002 = g_rtkb_m_t.rtkb002
                  LET g_rtkb_m.rtkb002_desc = arti705_rtkb002_ref(g_rtkb_m.rtkb002)
                  DISPLAY BY NAME g_rtkb_m.rtkb002_desc
               END IF
               LET g_rtkb_m.rtkb002_desc = arti705_rtkb002_ref(g_rtkb_m.rtkb002)
               DISPLAY BY NAME g_rtkb_m.rtkb002_desc
            END IF
            LET g_rtkb_m.rtkb002_desc = arti705_rtkb002_ref(g_rtkb_m.rtkb002)
            DISPLAY BY NAME g_rtkb_m.rtkb002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb002
            #add-point:BEFORE FIELD rtkb002 name="input.b.rtkb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkb002
            #add-point:ON CHANGE rtkb002 name="input.g.rtkb002"
 
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rtkb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb001
            #add-point:ON ACTION controlp INFIELD rtkb001 name="input.c.rtkb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtkb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb002
            #add-point:ON ACTION controlp INFIELD rtkb002 name="input.c.rtkb002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtkb_m.rtkb002
            
            CASE g_rtkb_m.rtkb001
               WHEN '1'         
                  LET g_qryparam.arg1 = '2'
                  CALL q_rtaa001_4()
               WHEN '2' 
                  IF s_aooi500_setpoint(g_prog,'rtkb002') THEN  
                     LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtkb002',g_site,'i') #150308-00001#1  By Ken add 'i' 150309
                     CALL q_ooef001_24()
                  ELSE                  
                     LET g_qryparam.where = " ooef304 = 'Y' "
                     CALL q_ooef001()       
                  END IF                  
            END CASE
            
            LET g_rtkb_m.rtkb002  = g_qryparam.return1    
            DISPLAY g_rtkb_m.rtkb002 TO rtkb002      
            
            LET g_rtkb_m.rtkb002_desc = arti705_rtkb002_ref(g_rtkb_m.rtkb002)
            DISPLAY BY NAME g_rtkb_m.rtkb002_desc            
            NEXT FIELD rtkb002       
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
            DISPLAY BY NAME g_rtkb_m.rtkb001             
                            ,g_rtkb_m.rtkb002   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL arti705_rtkb_t_mask_restore('restore_mask_o')
            
               UPDATE rtkb_t SET (rtkb001,rtkb002) = (g_rtkb_m.rtkb001,g_rtkb_m.rtkb002)
                WHERE rtkbent = g_enterprise AND rtkb001 = g_rtkb001_t
                  AND rtkb002 = g_rtkb002_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtkb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtkb_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtkb_m.rtkb001
               LET gs_keys_bak[1] = g_rtkb001_t
               LET gs_keys[2] = g_rtkb_m.rtkb002
               LET gs_keys_bak[2] = g_rtkb002_t
               LET gs_keys[3] = g_rtkb_d[g_detail_idx].rtkb003
               LET gs_keys_bak[3] = g_rtkb_d_t.rtkb003
               CALL arti705_update_b('rtkb_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_rtkb_m_t)
                     #LET g_log2 = util.JSON.stringify(g_rtkb_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL arti705_rtkb_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL arti705_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_rtkb001_t = g_rtkb_m.rtkb001
           LET g_rtkb002_t = g_rtkb_m.rtkb002
 
           
           IF g_rtkb_d.getLength() = 0 THEN
              NEXT FIELD rtkb003
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="arti705.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_rtkb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtkb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL arti705_b_fill(g_wc2) #test 
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
            CALL arti705_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN arti705_cl USING g_enterprise,g_rtkb_m.rtkb001,g_rtkb_m.rtkb002                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE arti705_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN arti705_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_rtkb_d[l_ac].rtkb003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtkb_d_t.* = g_rtkb_d[l_ac].*  #BACKUP
               LET g_rtkb_d_o.* = g_rtkb_d[l_ac].*  #BACKUP
               CALL arti705_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL arti705_set_no_entry_b(l_cmd)
               OPEN arti705_bcl USING g_enterprise,g_rtkb_m.rtkb001,
                                                g_rtkb_m.rtkb002,
 
                                                g_rtkb_d_t.rtkb003
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN arti705_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH arti705_bcl INTO g_rtkb_d[l_ac].rtkbstus,g_rtkb_d[l_ac].rtkb003,g_rtkb_d[l_ac].rtkb004, 
                      g_rtkb_d[l_ac].rtkb005,g_rtkb_d[l_ac].rtkb006,g_rtkb_d[l_ac].rtkb007,g_rtkb_d[l_ac].rtkb008, 
                      g_rtkb_d[l_ac].rtkb009,g_rtkb_d[l_ac].rtkbunit,g_rtkb2_d[l_ac].rtkb003,g_rtkb2_d[l_ac].rtkbownid, 
                      g_rtkb2_d[l_ac].rtkbowndp,g_rtkb2_d[l_ac].rtkbcrtid,g_rtkb2_d[l_ac].rtkbcrtdp, 
                      g_rtkb2_d[l_ac].rtkbcrtdt,g_rtkb2_d[l_ac].rtkbmodid,g_rtkb2_d[l_ac].rtkbmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_rtkb_d_t.rtkb003,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtkb_d_mask_o[l_ac].* =  g_rtkb_d[l_ac].*
                  CALL arti705_rtkb_t_mask()
                  LET g_rtkb_d_mask_n[l_ac].* =  g_rtkb_d[l_ac].*
                  
                  CALL arti705_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL arti705_set_entry_b(l_cmd)
            CALL arti705_set_no_entry_b(l_cmd)
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_rtkb_d_t.* TO NULL
            INITIALIZE g_rtkb_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rtkb_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtkb2_d[l_ac].rtkbownid = g_user
      LET g_rtkb2_d[l_ac].rtkbowndp = g_dept
      LET g_rtkb2_d[l_ac].rtkbcrtid = g_user
      LET g_rtkb2_d[l_ac].rtkbcrtdp = g_dept 
      LET g_rtkb2_d[l_ac].rtkbcrtdt = cl_get_current()
      LET g_rtkb2_d[l_ac].rtkbmodid = g_user
      LET g_rtkb2_d[l_ac].rtkbmoddt = cl_get_current()
      LET g_rtkb_d[l_ac].rtkbstus = ''
 
 
  
            #一般欄位預設值
                  LET g_rtkb_d[l_ac].rtkbstus = "Y"
      LET g_rtkb_d[l_ac].rtkb008 = "0"
      LET g_rtkb_d[l_ac].rtkb009 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_rtkb_d_t.* = g_rtkb_d[l_ac].*     #新輸入資料
            LET g_rtkb_d_o.* = g_rtkb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL arti705_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL arti705_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtkb_d[li_reproduce_target].* = g_rtkb_d[li_reproduce].*
               LET g_rtkb2_d[li_reproduce_target].* = g_rtkb2_d[li_reproduce].*
 
               LET g_rtkb_d[g_rtkb_d.getLength()].rtkb003 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_rtkb_d[l_ac].rtkbunit = g_site
            LET g_rtkb_d_t.* = g_rtkb_d[l_ac].*
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
            SELECT COUNT(1) INTO l_count FROM rtkb_t 
             WHERE rtkbent = g_enterprise AND rtkb001 = g_rtkb_m.rtkb001
               AND rtkb002 = g_rtkb_m.rtkb002
 
               AND rtkb003 = g_rtkb_d[l_ac].rtkb003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO rtkb_t
                           (rtkbent,
                            rtkb001,rtkb002,
                            rtkb003
                            ,rtkbstus,rtkb004,rtkb005,rtkb006,rtkb007,rtkb008,rtkb009,rtkbunit,rtkbownid,rtkbowndp,rtkbcrtid,rtkbcrtdp,rtkbcrtdt,rtkbmodid,rtkbmoddt) 
                     VALUES(g_enterprise,
                            g_rtkb_m.rtkb001,g_rtkb_m.rtkb002,
                            g_rtkb_d[l_ac].rtkb003
                            ,g_rtkb_d[l_ac].rtkbstus,g_rtkb_d[l_ac].rtkb004,g_rtkb_d[l_ac].rtkb005,g_rtkb_d[l_ac].rtkb006, 
                                g_rtkb_d[l_ac].rtkb007,g_rtkb_d[l_ac].rtkb008,g_rtkb_d[l_ac].rtkb009, 
                                g_rtkb_d[l_ac].rtkbunit,g_rtkb2_d[l_ac].rtkbownid,g_rtkb2_d[l_ac].rtkbowndp, 
                                g_rtkb2_d[l_ac].rtkbcrtid,g_rtkb2_d[l_ac].rtkbcrtdp,g_rtkb2_d[l_ac].rtkbcrtdt, 
                                g_rtkb2_d[l_ac].rtkbmodid,g_rtkb2_d[l_ac].rtkbmoddt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_rtkb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "rtkb_t:",SQLERRMESSAGE 
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
               IF arti705_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_rtkb_m.rtkb001
                  LET gs_keys[gs_keys.getLength()+1] = g_rtkb_m.rtkb002
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rtkb_d_t.rtkb003
 
 
                  #刪除下層單身
                  IF NOT arti705_key_delete_b(gs_keys,'rtkb_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE arti705_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE arti705_bcl
               LET l_count = g_rtkb_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_rtkb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkbstus
            #add-point:BEFORE FIELD rtkbstus name="input.b.page1.rtkbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkbstus
            
            #add-point:AFTER FIELD rtkbstus name="input.a.page1.rtkbstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkbstus
            #add-point:ON CHANGE rtkbstus name="input.g.page1.rtkbstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb003
            
            #add-point:AFTER FIELD rtkb003 name="input.a.page1.rtkb003"
                        #此段落由子樣板a05產生
            IF  g_rtkb_m.rtkb001 IS NOT NULL AND g_rtkb_m.rtkb002 IS NOT NULL AND g_rtkb_d[g_detail_idx].rtkb003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtkb_m.rtkb001 != g_rtkb001_t OR g_rtkb_m.rtkb002 != g_rtkb002_t OR g_rtkb_d[g_detail_idx].rtkb003 != g_rtkb_d_t.rtkb003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtkb_t WHERE "||"rtkbent = '" ||g_enterprise|| "' AND "||"rtkb001 = '"||g_rtkb_m.rtkb001 ||"' AND "|| "rtkb002 = '"||g_rtkb_m.rtkb002 ||"' AND "|| "rtkb003 = '"||g_rtkb_d[g_detail_idx].rtkb003 ||"'",'std-00004',0) THEN 
                     LET g_rtkb_d[l_ac].rtkb003 = g_rtkb_d_t.rtkb003              
                     LET g_rtkb_d[l_ac].rtkb003_desc = arti705_rtkb003_ref(g_rtkb_d[l_ac].rtkb003)
                     NEXT FIELD CURRENT
                  END IF
                  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtkb_d[l_ac].rtkb003
                  IF NOT cl_chk_exist("v_rtax001_1") THEN
                     LET g_rtkb_d[l_ac].rtkb003 = g_rtkb_d_t.rtkb003              
                     LET g_rtkb_d[l_ac].rtkb003_desc = arti705_rtkb003_ref(g_rtkb_d[l_ac].rtkb003)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_rtkb_d[l_ac].rtkb003_desc = arti705_rtkb003_ref(g_rtkb_d[l_ac].rtkb003)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb003
            #add-point:BEFORE FIELD rtkb003 name="input.b.page1.rtkb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkb003
            #add-point:ON CHANGE rtkb003 name="input.g.page1.rtkb003"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb004
            #add-point:BEFORE FIELD rtkb004 name="input.b.page1.rtkb004"
            CALL arti705_set_entry_b(l_cmd)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb004
            
            #add-point:AFTER FIELD rtkb004 name="input.a.page1.rtkb004"
            IF g_rtkb_d[l_ac].rtkb004 = '1' THEN
               LET g_rtkb_d[l_ac].rtkb006 = NULL
            END IF
            IF g_rtkb_d[l_ac].rtkb004 = '2' THEN
               LET g_rtkb_d[l_ac].rtkb005 = NULL
            END IF
            CALL arti705_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkb004
            #add-point:ON CHANGE rtkb004 name="input.g.page1.rtkb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb005
            #add-point:BEFORE FIELD rtkb005 name="input.b.page1.rtkb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb005
            
            #add-point:AFTER FIELD rtkb005 name="input.a.page1.rtkb005"
            IF NOT arti701_01_show_day('2',g_rtkb_d[l_ac].rtkb005) THEN
               LET g_rtkb_d[l_ac].rtkb005 = g_rtkb_d_t.rtkb005
               NEXT FIELD CURRENT
            ELSE                                                 
               LET g_rtkb_d[l_ac].rtkb005 = arti701_01_day_chk() #ken---add 需求單號：150107-00019 項次：2
            END IF
            LET g_rtkb_d[l_ac].rtkb008 = arti705_rtkb008_chk(g_rtkb_d[l_ac].rtkb004,g_rtkb_d[l_ac].rtkb005) #sakura add 141230-00008#2
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkb005
            #add-point:ON CHANGE rtkb005 name="input.g.page1.rtkb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb006
            #add-point:BEFORE FIELD rtkb006 name="input.b.page1.rtkb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb006
            
            #add-point:AFTER FIELD rtkb006 name="input.a.page1.rtkb006"
            IF NOT arti701_02_show_week('2',g_rtkb_d[l_ac].rtkb006) THEN
               LET g_rtkb_d[l_ac].rtkb006 = g_rtkb_d_t.rtkb006
               NEXT FIELD CURRENT
            ELSE                                                 
               LET g_rtkb_d[l_ac].rtkb006 = arti701_02_week_chk() #ken---add 需求單號：150107-00019 項次：2              
            END IF
            LET g_rtkb_d[l_ac].rtkb008 = arti705_rtkb008_chk(g_rtkb_d[l_ac].rtkb004,g_rtkb_d[l_ac].rtkb006) #sakura add 141230-00008#2
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkb006
            #add-point:ON CHANGE rtkb006 name="input.g.page1.rtkb006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb007
            
            #add-point:AFTER FIELD rtkb007 name="input.a.page1.rtkb007"
            IF NOT cl_null(g_rtkb_d[l_ac].rtkb007) 
               AND (l_cmd = 'a' OR (l_cmd = 'u' OR g_rtkb_d_t.rtkb007 != g_rtkb_d[l_ac].rtkb007 OR cl_null(g_rtkb_d_t.rtkb007))) THEN
               INITIALIZE g_chkparam.* TO NULL 
               LET g_chkparam.arg1 = '274'
               LET g_chkparam.arg2 = g_rtkb_d[l_ac].rtkb007
#               LET g_chkparam.err_str[1] = "aoo-00099:aim-00092"            #160318-00005#42 mark
               LET g_chkparam.err_str[1] = "aoo-00099:sub-01303|aooi715|",cl_get_progname('aooi715',g_lang,"2"),"|:EXEPROGaooi715" #160318-00005#42 add
               #160318-00025#41  2016/04/25  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
               #160318-00025#41  2016/04/25  by pengxin  add(E)
               IF NOT cl_chk_exist("v_oocq002_1") THEN  
                  LET g_rtkb_d[l_ac].rtkb007 = g_rtkb_d_t.rtkb007
                  LET g_rtkb_d[l_ac].rtkb007_desc = arti705_rtkb007_ref(g_rtkb_d[l_ac].rtkb007)
                  NEXT FIELD CURRENT
               END IF 
            END IF               
            LET g_rtkb_d[l_ac].rtkb007_desc = arti705_rtkb007_ref(g_rtkb_d[l_ac].rtkb007)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb007
            #add-point:BEFORE FIELD rtkb007 name="input.b.page1.rtkb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkb007
            #add-point:ON CHANGE rtkb007 name="input.g.page1.rtkb007"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtkb_d[l_ac].rtkb008,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtkb008
            END IF 
 
 
 
            #add-point:AFTER FIELD rtkb008 name="input.a.page1.rtkb008"
            IF NOT cl_null(g_rtkb_d[l_ac].rtkb008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb008
            #add-point:BEFORE FIELD rtkb008 name="input.b.page1.rtkb008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkb008
            #add-point:ON CHANGE rtkb008 name="input.g.page1.rtkb008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkb009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtkb_d[l_ac].rtkb009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtkb009
            END IF 
 
 
 
            #add-point:AFTER FIELD rtkb009 name="input.a.page1.rtkb009"
            IF NOT cl_null(g_rtkb_d[l_ac].rtkb009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkb009
            #add-point:BEFORE FIELD rtkb009 name="input.b.page1.rtkb009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkb009
            #add-point:ON CHANGE rtkb009 name="input.g.page1.rtkb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkbunit
            #add-point:BEFORE FIELD rtkbunit name="input.b.page1.rtkbunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkbunit
            
            #add-point:AFTER FIELD rtkbunit name="input.a.page1.rtkbunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkbunit
            #add-point:ON CHANGE rtkbunit name="input.g.page1.rtkbunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtkbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkbstus
            #add-point:ON ACTION controlp INFIELD rtkbstus name="input.c.page1.rtkbstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb003
            #add-point:ON ACTION controlp INFIELD rtkb003 name="input.c.page1.rtkb003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtkb_d[l_ac].rtkb003             #給予default值
            CALL q_rtax001()                                #呼叫開窗
            LET g_rtkb_d[l_ac].rtkb003 = g_qryparam.return1 
            DISPLAY g_rtkb_d[l_ac].rtkb003 TO rtkb003              #
            
            LET g_rtkb_d[l_ac].rtkb003_desc = arti705_rtkb003_ref(g_rtkb_d[l_ac].rtkb003)
            DISPLAY BY NAME g_rtkb_d[l_ac].rtkb003_desc
            
            NEXT FIELD rtkb003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb004
            #add-point:ON ACTION controlp INFIELD rtkb004 name="input.c.page1.rtkb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb005
            #add-point:ON ACTION controlp INFIELD rtkb005 name="input.c.page1.rtkb005"
            CALL arti701_01(g_rtkb_d[l_ac].rtkb005) RETURNING l_success,g_rtkb_d[l_ac].rtkb005
            IF NOT l_success  OR INT_FLAG THEN
               LET g_rtkb_d[l_ac].rtkb005 = g_rtkb_d_t.rtkb005
            END IF
            DISPLAY g_rtkb_d[l_ac].rtkb005 TO rtkb005  
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb006
            #add-point:ON ACTION controlp INFIELD rtkb006 name="input.c.page1.rtkb006"
            CALL arti701_02(g_rtkb_d[l_ac].rtkb006) RETURNING l_success,g_rtkb_d[l_ac].rtkb006
            IF NOT l_success  OR INT_FLAG THEN
               LET g_rtkb_d[l_ac].rtkb006 = g_rtkb_d_t.rtkb006
            END IF
            DISPLAY g_rtkb_d[l_ac].rtkb006 TO rtkb006  
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb007
            #add-point:ON ACTION controlp INFIELD rtkb007 name="input.c.page1.rtkb007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtkb_d[l_ac].rtkb007             #給予default值
            LET g_qryparam.arg1 = "274" 
            CALL q_oocq002()                                #呼叫開窗
            LET g_rtkb_d[l_ac].rtkb007 = g_qryparam.return1              
            DISPLAY g_rtkb_d[l_ac].rtkb007 TO rtkb007              #

            LET g_rtkb_d[l_ac].rtkb007_desc = arti705_rtkb007_ref(g_rtkb_d[l_ac].rtkb007)
            DISPLAY BY NAME g_rtkb_d[l_ac].rtkb007_desc
      
            NEXT FIELD rtkb007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb008
            #add-point:ON ACTION controlp INFIELD rtkb008 name="input.c.page1.rtkb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkb009
            #add-point:ON ACTION controlp INFIELD rtkb009 name="input.c.page1.rtkb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkbunit
            #add-point:ON ACTION controlp INFIELD rtkbunit name="input.c.page1.rtkbunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rtkb_d[l_ac].* = g_rtkb_d_t.*
               CLOSE arti705_bcl
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
               LET g_errparam.extend = g_rtkb_d[l_ac].rtkb003 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_rtkb_d[l_ac].* = g_rtkb_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_rtkb2_d[l_ac].rtkbmodid = g_user 
LET g_rtkb2_d[l_ac].rtkbmoddt = cl_get_current()
LET g_rtkb2_d[l_ac].rtkbmodid_desc = cl_get_username(g_rtkb2_d[l_ac].rtkbmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL arti705_rtkb_t_mask_restore('restore_mask_o')
         
               UPDATE rtkb_t SET (rtkb001,rtkb002,rtkbstus,rtkb003,rtkb004,rtkb005,rtkb006,rtkb007,rtkb008, 
                   rtkb009,rtkbunit,rtkbownid,rtkbowndp,rtkbcrtid,rtkbcrtdp,rtkbcrtdt,rtkbmodid,rtkbmoddt) = (g_rtkb_m.rtkb001, 
                   g_rtkb_m.rtkb002,g_rtkb_d[l_ac].rtkbstus,g_rtkb_d[l_ac].rtkb003,g_rtkb_d[l_ac].rtkb004, 
                   g_rtkb_d[l_ac].rtkb005,g_rtkb_d[l_ac].rtkb006,g_rtkb_d[l_ac].rtkb007,g_rtkb_d[l_ac].rtkb008, 
                   g_rtkb_d[l_ac].rtkb009,g_rtkb_d[l_ac].rtkbunit,g_rtkb2_d[l_ac].rtkbownid,g_rtkb2_d[l_ac].rtkbowndp, 
                   g_rtkb2_d[l_ac].rtkbcrtid,g_rtkb2_d[l_ac].rtkbcrtdp,g_rtkb2_d[l_ac].rtkbcrtdt,g_rtkb2_d[l_ac].rtkbmodid, 
                   g_rtkb2_d[l_ac].rtkbmoddt)
                WHERE rtkbent = g_enterprise AND rtkb001 = g_rtkb_m.rtkb001 
                 AND rtkb002 = g_rtkb_m.rtkb002 
 
                 AND rtkb003 = g_rtkb_d_t.rtkb003 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtkb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "rtkb_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtkb_m.rtkb001
               LET gs_keys_bak[1] = g_rtkb001_t
               LET gs_keys[2] = g_rtkb_m.rtkb002
               LET gs_keys_bak[2] = g_rtkb002_t
               LET gs_keys[3] = g_rtkb_d[g_detail_idx].rtkb003
               LET gs_keys_bak[3] = g_rtkb_d_t.rtkb003
               CALL arti705_update_b('rtkb_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_rtkb_m),util.JSON.stringify(g_rtkb_d_t)
                     LET g_log2 = util.JSON.stringify(g_rtkb_m),util.JSON.stringify(g_rtkb_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL arti705_rtkb_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_rtkb_m.rtkb001
               LET ls_keys[ls_keys.getLength()+1] = g_rtkb_m.rtkb002
 
               LET ls_keys[ls_keys.getLength()+1] = g_rtkb_d_t.rtkb003
 
               CALL arti705_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE arti705_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_rtkb_d[l_ac].* = g_rtkb_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE arti705_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_rtkb_d.getLength() = 0 THEN
               NEXT FIELD rtkb003
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_rtkb_d[li_reproduce_target].* = g_rtkb_d[li_reproduce].*
               LET g_rtkb2_d[li_reproduce_target].* = g_rtkb2_d[li_reproduce].*
 
               LET g_rtkb_d[li_reproduce_target].rtkb003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtkb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtkb_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_rtkb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL arti705_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL arti705_idx_chk()
            CALL arti705_ui_detailshow()
        
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
            NEXT FIELD rtkb001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD rtkbstus
               WHEN "s_detail2"
                  NEXT FIELD rtkb003_2
 
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
 
{<section id="arti705.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION arti705_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL arti705_b_fill(g_wc2) #第一階單身填充
      CALL arti705_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL arti705_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_rtkb_m.rtkb001,g_rtkb_m.rtkb002,g_rtkb_m.rtkb002_desc
 
   CALL arti705_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   CALL arti705_set_rtkb002_title()
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="arti705.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION arti705_ref_show()
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
   LET g_rtkb_m.rtkb002_desc = arti705_rtkb002_ref(g_rtkb_m.rtkb002) 
   DISPLAY g_rtkb_m.rtkb002_desc TO rtkb002_desc
   CALL arti705_rtkb001_comm_visable(g_rtkb_m.rtkb001)
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_rtkb_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"

      LET g_rtkb_d[l_ac].rtkb003_desc = arti705_rtkb003_ref(g_rtkb_d[l_ac].rtkb003)
      DISPLAY BY NAME g_rtkb_d[l_ac].rtkb003_desc

      LET g_rtkb_d[l_ac].rtkb007_desc = arti705_rtkb007_ref(g_rtkb_d[l_ac].rtkb007)
      DISPLAY BY NAME g_rtkb_d[l_ac].rtkb007_desc
      
     
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_rtkb2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      LET g_rtkb2_d[l_ac].rtkbmodid_desc = arti705_user_ref(g_rtkb2_d[l_ac].rtkbmodid)
      DISPLAY BY NAME g_rtkb2_d[l_ac].rtkbmodid_desc
      
      LET g_rtkb2_d[l_ac].rtkbownid_desc = arti705_user_ref(g_rtkb2_d[l_ac].rtkbownid)
      DISPLAY BY NAME g_rtkb2_d[l_ac].rtkbownid_desc      
      
      LET g_rtkb2_d[l_ac].rtkbowndp_desc = arti705_dp_ref(g_rtkb2_d[l_ac].rtkbowndp)
      DISPLAY BY NAME g_rtkb2_d[l_ac].rtkbowndp_desc        
      
      LET g_rtkb2_d[l_ac].rtkbcrtid_desc = arti705_user_ref(g_rtkb2_d[l_ac].rtkbcrtid)
      DISPLAY BY NAME g_rtkb2_d[l_ac].rtkbcrtid_desc
      
      LET g_rtkb2_d[l_ac].rtkbcrtdp_desc = arti705_dp_ref(g_rtkb2_d[l_ac].rtkbcrtdp)
      DISPLAY BY NAME g_rtkb2_d[l_ac].rtkbcrtdp_desc   
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="arti705.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION arti705_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE rtkb_t.rtkb001 
   DEFINE l_oldno     LIKE rtkb_t.rtkb001 
   DEFINE l_newno02     LIKE rtkb_t.rtkb002 
   DEFINE l_oldno02     LIKE rtkb_t.rtkb002 
 
   DEFINE l_master    RECORD LIKE rtkb_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE rtkb_t.* #此變數樣板目前無使用
 
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
 
   IF g_rtkb_m.rtkb001 IS NULL
      OR g_rtkb_m.rtkb002 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_rtkb001_t = g_rtkb_m.rtkb001
   LET g_rtkb002_t = g_rtkb_m.rtkb002
 
   
   LET g_rtkb_m.rtkb001 = ""
   LET g_rtkb_m.rtkb002 = ""
 
   LET g_master_insert = FALSE
   CALL arti705_set_entry('a')
   CALL arti705_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_rtkb_m.rtkb001 = "2"
   LET g_rtkb_m.rtkb002_desc = NULL
   DISPLAY BY NAME g_rtkb_m.rtkb001, g_rtkb_m.rtkb002_desc
   #end add-point
   
   #清空key欄位的desc
      LET g_rtkb_m.rtkb002_desc = ''
   DISPLAY BY NAME g_rtkb_m.rtkb002_desc
 
   
   CALL arti705_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_rtkb_m.* TO NULL
      INITIALIZE g_rtkb_d TO NULL
      INITIALIZE g_rtkb2_d TO NULL
 
      CALL arti705_show()
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
   CALL arti705_set_act_visible()
   CALL arti705_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_rtkb001_t = g_rtkb_m.rtkb001
   LET g_rtkb002_t = g_rtkb_m.rtkb002
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtkbent = " ||g_enterprise|| " AND",
                      " rtkb001 = '", g_rtkb_m.rtkb001, "' "
                      ," AND rtkb002 = '", g_rtkb_m.rtkb002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL arti705_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL arti705_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL arti705_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="arti705.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION arti705_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE rtkb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE arti705_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtkb_t
    WHERE rtkbent = g_enterprise AND rtkb001 = g_rtkb001_t
    AND rtkb002 = g_rtkb002_t
 
       INTO TEMP arti705_detail
   
   #將key修正為調整後   
   UPDATE arti705_detail 
      #更新key欄位
      SET rtkb001 = g_rtkb_m.rtkb001
          , rtkb002 = g_rtkb_m.rtkb002
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , rtkbownid = g_user 
       , rtkbowndp = g_dept
       , rtkbcrtid = g_user
       , rtkbcrtdp = g_dept 
       , rtkbcrtdt = ld_date
       , rtkbmodid = g_user
       , rtkbmoddt = ld_date
      #, rtkbstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO rtkb_t SELECT * FROM arti705_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   UPDATE rtkb_t
      SET rtkbunit = g_site
    WHERE rtkb001 = g_rtkb_m.rtkb001 AND rtkb002 = g_rtkb_m.rtkb002 AND rtkbent = g_enterprise   #160905-00007#14 add  rtkbent = g_enterprise
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE arti705_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rtkb001_t = g_rtkb_m.rtkb001
   LET g_rtkb002_t = g_rtkb_m.rtkb002
 
   
   DROP TABLE arti705_detail
   
END FUNCTION
 
{</section>}
 
{<section id="arti705.delete" >}
#+ 資料刪除
PRIVATE FUNCTION arti705_delete()
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
   
   IF g_rtkb_m.rtkb001 IS NULL
   OR g_rtkb_m.rtkb002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN arti705_cl USING g_enterprise,g_rtkb_m.rtkb001,g_rtkb_m.rtkb002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN arti705_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE arti705_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE arti705_master_referesh USING g_rtkb_m.rtkb001,g_rtkb_m.rtkb002 INTO g_rtkb_m.rtkb001,g_rtkb_m.rtkb002, 
       g_rtkb_m.rtkb002_desc
   
   #遮罩相關處理
   LET g_rtkb_m_mask_o.* =  g_rtkb_m.*
   CALL arti705_rtkb_t_mask()
   LET g_rtkb_m_mask_n.* =  g_rtkb_m.*
   
   CALL arti705_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL arti705_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM rtkb_t WHERE rtkbent = g_enterprise AND rtkb001 = g_rtkb_m.rtkb001
                                                               AND rtkb002 = g_rtkb_m.rtkb002
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtkb_t:",SQLERRMESSAGE 
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
      #   CLOSE arti705_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_rtkb_d.clear() 
      CALL g_rtkb2_d.clear()       
 
     
      CALL arti705_ui_browser_refresh()  
      #CALL arti705_ui_headershow()  
      #CALL arti705_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL arti705_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL arti705_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE arti705_cl
 
   #功能已完成,通報訊息中心
   CALL arti705_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="arti705.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION arti705_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_rtkb_d.clear()
   CALL g_rtkb2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT rtkbstus,rtkb003,rtkb004,rtkb005,rtkb006,rtkb007,rtkb008,rtkb009,rtkbunit, 
       rtkb003,rtkbownid,rtkbowndp,rtkbcrtid,rtkbcrtdp,rtkbcrtdt,rtkbmodid,rtkbmoddt,t1.rtaxl003 ,t2.oocql004 , 
       t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 FROM rtkb_t",   
               "",
               
                              " LEFT JOIN rtaxl_t t1 ON t1.rtaxlent="||g_enterprise||" AND t1.rtaxl001=rtkb003 AND t1.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='274' AND t2.oocql002=rtkb007 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=rtkbownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=rtkbowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=rtkbcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=rtkbcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=rtkbmodid  ",
 
               " WHERE rtkbent= ? AND rtkb001=? AND rtkb002=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("rtkb_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF arti705_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY rtkb_t.rtkb003"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE arti705_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR arti705_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_rtkb_m.rtkb001,g_rtkb_m.rtkb002   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_rtkb_m.rtkb001,g_rtkb_m.rtkb002 INTO g_rtkb_d[l_ac].rtkbstus, 
          g_rtkb_d[l_ac].rtkb003,g_rtkb_d[l_ac].rtkb004,g_rtkb_d[l_ac].rtkb005,g_rtkb_d[l_ac].rtkb006, 
          g_rtkb_d[l_ac].rtkb007,g_rtkb_d[l_ac].rtkb008,g_rtkb_d[l_ac].rtkb009,g_rtkb_d[l_ac].rtkbunit, 
          g_rtkb2_d[l_ac].rtkb003,g_rtkb2_d[l_ac].rtkbownid,g_rtkb2_d[l_ac].rtkbowndp,g_rtkb2_d[l_ac].rtkbcrtid, 
          g_rtkb2_d[l_ac].rtkbcrtdp,g_rtkb2_d[l_ac].rtkbcrtdt,g_rtkb2_d[l_ac].rtkbmodid,g_rtkb2_d[l_ac].rtkbmoddt, 
          g_rtkb_d[l_ac].rtkb003_desc,g_rtkb_d[l_ac].rtkb007_desc,g_rtkb2_d[l_ac].rtkbownid_desc,g_rtkb2_d[l_ac].rtkbowndp_desc, 
          g_rtkb2_d[l_ac].rtkbcrtid_desc,g_rtkb2_d[l_ac].rtkbcrtdp_desc,g_rtkb2_d[l_ac].rtkbmodid_desc  
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
 
            CALL g_rtkb_d.deleteElement(g_rtkb_d.getLength())
      CALL g_rtkb2_d.deleteElement(g_rtkb2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtkb_d.getLength()
      LET g_rtkb_d_mask_o[l_ac].* =  g_rtkb_d[l_ac].*
      CALL arti705_rtkb_t_mask()
      LET g_rtkb_d_mask_n[l_ac].* =  g_rtkb_d[l_ac].*
   END FOR
   
   LET g_rtkb2_d_mask_o.* =  g_rtkb2_d.*
   FOR l_ac = 1 TO g_rtkb2_d.getLength()
      LET g_rtkb2_d_mask_o[l_ac].* =  g_rtkb2_d[l_ac].*
      CALL arti705_rtkb_t_mask()
      LET g_rtkb2_d_mask_n[l_ac].* =  g_rtkb2_d[l_ac].*
   END FOR
 
 
   FREE arti705_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="arti705.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION arti705_idx_chk()
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
      IF g_detail_idx > g_rtkb_d.getLength() THEN
         LET g_detail_idx = g_rtkb_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_rtkb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtkb_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_rtkb2_d.getLength() THEN
         LET g_detail_idx = g_rtkb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtkb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtkb2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="arti705.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION arti705_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_rtkb_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="arti705.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION arti705_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM rtkb_t
    WHERE rtkbent = g_enterprise AND rtkb001 = g_rtkb_m.rtkb001 AND
                              rtkb002 = g_rtkb_m.rtkb002 AND
 
          rtkb003 = g_rtkb_d_t.rtkb003
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "rtkb_t:",SQLERRMESSAGE 
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
 
{<section id="arti705.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION arti705_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="arti705.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION arti705_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="arti705.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION arti705_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="arti705.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION arti705_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_rtkb_d[l_ac].rtkb003 = g_rtkb_d_t.rtkb003 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti705.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION arti705_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="arti705.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION arti705_lock_b(ps_table,ps_page)
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
   #CALL arti705_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="arti705.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION arti705_unlock_b(ps_table,ps_page)
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
 
{<section id="arti705.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION arti705_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("rtkb001,rtkb002",TRUE)
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
 
{<section id="arti705.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION arti705_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt   LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("rtkb001,rtkb002",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM rtkb_t
    WHERE rtkbent = g_enterprise AND rtkb001 = g_rtkb_m.rtkb001 AND rtkb002 = g_rtkb_m.rtkb002
   IF l_cnt > 0 THEN
      CALL cl_set_comp_entry("rtkb001,rtkb002",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="arti705.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION arti705_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CALL cl_set_comp_entry('rtkb005,rtkb006',TRUE) 
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="arti705.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION arti705_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   CASE g_rtkb_d[l_ac].rtkb004 
      WHEN '1'
         CALL cl_set_comp_entry('rtkb006',FALSE)      
      WHEN '2'
         CALL cl_set_comp_entry('rtkb005',FALSE)      
   END CASE 
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="arti705.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION arti705_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="arti705.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION arti705_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="arti705.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION arti705_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="arti705.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION arti705_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="arti705.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION arti705_default_search()
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
      LET ls_wc = ls_wc, " rtkb001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " rtkb002 = '", g_argv[02], "' AND "
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
 
{<section id="arti705.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION arti705_fill_chk(ps_idx)
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
 
{<section id="arti705.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION arti705_modify_detail_chk(ps_record)
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
         LET ls_return = "rtkbstus"
      WHEN "s_detail2"
         LET ls_return = "rtkb003_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="arti705.mask_functions" >}
&include "erp/art/arti705_mask.4gl"
 
{</section>}
 
{<section id="arti705.state_change" >}
    
 
{</section>}
 
{<section id="arti705.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION arti705_set_pk_array()
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
   LET g_pk_array[1].values = g_rtkb_m.rtkb001
   LET g_pk_array[1].column = 'rtkb001'
   LET g_pk_array[2].values = g_rtkb_m.rtkb002
   LET g_pk_array[2].column = 'rtkb002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="arti705.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION arti705_msgcentre_notify(lc_state)
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
   CALL arti705_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_rtkb_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="arti705.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 資料類型說明標籤隱藏否
# Memo...........:
# Usage..........: CALL arti705_rtkb001_comm_visable(p_rtkb001)
# Input parameter: p_rtkb001   資料類型
# Return code....: 
# Date & Author..: 2014/03/29 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION arti705_rtkb001_comm_visable(p_rtkb001)
   DEFINE p_rtkb001   LIKE rtkb_t.rtkb001
   
   IF p_rtkb001 = '2' THEN
      CALL cl_set_comp_visible('rtkb001_comment',TRUE)      
   ELSE
      CALL cl_set_comp_visible('rtkb001_comment',FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 取店群/門店說明
# Memo...........:
# Usage..........: CALL arti705_rtkb002_ref(p_rtkb002)
#                : RETURN r_rtkb002_desc
# Input parameter: p_rtkb002        店群門店編號
# Return code....: r_rtkb002_desc   店群門店說明
# Date & Author..: 2014/03/30 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION arti705_rtkb002_ref(p_rtkb002)
   DEFINE p_rtkb002        LIKE rtkb_t.rtkb002
   DEFINE r_rtkb002_desc   LIKE rtaal_t.rtaal003   
   
   LET r_rtkb002_desc = NULL
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_rtkb002
   CASE g_rtkb_m.rtkb001
      WHEN '1'
         CALL ap_ref_array2(g_ref_fields,"SELECT rtaal003 FROM rtaal_t WHERE rtaalent='"||g_enterprise||"' AND rtaal001=? AND rtaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      WHEN '2'
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   END CASE
   
   LET r_rtkb002_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_rtkb002_desc   
END FUNCTION
################################################################################
# Descriptions...: 取送貨時段说明
# Memo...........:
# Usage..........: CALL arti705_rtkb007_ref(p_rtkb007)
#                  RETURNING r_rtkb007_desc
# Input parameter: p_rtkb007      取送貨時段
# Return code....: r_rtkb007_desc 取送貨時段说明  
# Date & Author..: 2014/03/30 By Lori
# Modify.........:
################################################################################
PUBLIC FUNCTION arti705_rtkb007_ref(p_rtkb007)
   DEFINE p_rtkb007        LIKE rtkb_t.rtkb007
   DEFINE r_rtkb007_desc   LIKE oocql_t.oocql004
   
   LET r_rtkb007_desc = NULL  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = '274'
   LET g_ref_fields[2] = p_rtkb007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_rtkb007_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_rtkb007_desc
END FUNCTION

################################################################################
# Descriptions...: 取品類说明
# Memo...........:
# Usage..........: CALL arti705_rtkb003_ref(p_rtkb003)
#                  RETURNING r_rtkv003_desc
# Input parameter: p_rtkb003        品類編號
# Return code....: r_rtkv003_desc   品類說明
# Date & Author..: 2014/03/30 By Lori
# Modify.........:
################################################################################
PUBLIC FUNCTION arti705_rtkb003_ref(p_rtkb003)
   DEFINE p_rtkb003        LIKE rtkb_t.rtkb003
   DEFINE r_rtkb003_desc   LIKE rtaxl_t.rtaxl003
   
   LET r_rtkb003_desc = NULL
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_rtkb003
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_rtkb003_desc = '', g_rtn_fields[1] , ''

   RETURN r_rtkb003_desc
END FUNCTION

################################################################################
# Descriptions...: 根據設定類型動態顯示店群/門店編號的Title
# Memo...........:
# Usage..........: CALL arti705_set_rtkb002_title()
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/04/07 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION arti705_set_rtkb002_title()
   DEFINE l_gzze003   LIKE gzze_t.gzze003
   
   IF g_rtkb_m.rtkb001 = '1' THEN
      LET l_gzze003 = cl_getmsg('art-00311',g_dlang)
   END IF
   IF g_rtkb_m.rtkb001 = '2' THEN
      LET l_gzze003 = cl_getmsg('art-00310',g_dlang)
   END IF 
   CALL cl_set_comp_att_text('rtkb002',l_gzze003)
END FUNCTION

################################################################################
# Descriptions...: 店群/門店編號校驗
# Memo...........:
# Usage..........: CALL arti705_rtkb002_chk(p_rtkb002)
#                  RETURNING r_success
# Input parameter: p_rtkb002   店群/門店編號
# Return code....: r_success   確認狀態
# Date & Author..: 2014/03/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION arti705_rtkb002_chk(p_rtkb002)
   DEFINE p_rtkb002   LIKE rtkb_t.rtkb002
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_errno     LIKE type_t.chr10
   
   LET r_success = TRUE
   
   INITIALIZE g_chkparam.* TO NULL   
   
   CASE g_rtkb_m.rtkb001 
      WHEN '1'   #店群
         LET g_chkparam.arg1 = p_rtkb002
         LET g_chkparam.arg2 = '2'
         #160318-00025#41  2016/04/25  by pengxin  add(S)
         LET g_errshow = TRUE #是否開窗 
         LET g_chkparam.err_str[1] = "art-00049:sub-01302|arti201|",cl_get_progname("arti201",g_lang,"2"),"|:EXEPROGarti201"
         #160318-00025#41  2016/04/25  by pengxin  add(E)
         IF cl_chk_exist("v_rtaa001_2") THEN
            LET r_success = TRUE
         ELSE
            LET r_success = FALSE
         END IF
      WHEN '2'    #門店
         LET g_chkparam.arg1 = p_rtkb002
         IF p_rtkb002 <> 'ALL' THEN
            IF s_aooi500_setpoint(g_prog,'rtkb002') THEN
               CALL s_aooi500_chk(g_prog,'rtkb002',p_rtkb002,g_site)
                RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = p_rtkb002
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET r_success = FALSE
               ELSE
                  LET r_success = TRUE
               END IF
            ELSE
               IF cl_chk_exist("v_ooef001_35") THEN
                  LET r_success = TRUE
               ELSE
                  LET r_success = FALSE
               END IF
            END IF
         END IF   
   END CASE   
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取人員说明
# Memo...........:
# Usage..........: CALL arti705_user_ref(p_userid)
#                  RETURNING r_rtkamodid_desc
# Input parameter: p_userid        人員編號
# Return code....: r_userid_desc   人員名稱
# Date & Author..: 2014/04/07 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION arti705_user_ref(p_userid)
   DEFINE p_userid        LIKE rtka_t.rtkamodid
   DEFINE r_userid_desc   LIKE oofa_t.oofa011
   
   LET r_userid_desc = NULL
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_userid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET r_userid_desc = g_rtn_fields[1]
   
   RETURN r_userid_desc
END FUNCTION

################################################################################
# Descriptions...: 取部門说明
# Memo...........:
# Usage..........: CALL arti705_dp_ref(p_dpid)
#                  RETURNING r_dpid_desc
# Input parameter: p_dpid        部門編號
# Return code....: r_dpid_desc   部門名稱
# Date & Author..: 2014/04/07 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION arti705_dp_ref(p_dpid)
   DEFINE p_dpid        LIKE rtka_t.rtkaowndp
   DEFINE r_dpid_desc   LIKE ooefl_t.ooefl003
   
   LET r_dpid_desc = NULL
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_dpid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_dpid_desc = g_rtn_fields[1]
      
   RETURN r_dpid_desc
END FUNCTION

################################################################################
# Descriptions...: 系統預設帶出訂單週期(天)
# Memo...........: 計算規則：
#                : 訂單日類型：1(日) 用30/選取天數 取整數                  
#                : 訂單日類型：2(週) 用7/選取天數 取整數
# Usage..........: CALL arti705_rtkb008_chk(p_rtkb004,p_rtkb)
#                  RETURNING r_rtkb008
# Input parameter: p_rtkb004   訂單日類型(1：日;2：週)
#                : p_rtkb      日、週 傳入欄位值
# Return code....: r_rtkb008   訂單週期(天)
# Date & Author..: 2015-01-13 By Sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION arti705_rtkb008_chk(p_rtkb004,p_rtkb)
   DEFINE p_rtkb004        LIKE rtkb_t.rtkb004
   DEFINE p_rtkb           STRING
   DEFINE l_cnt            LIKE rtkb_t.rtkb005
   DEFINE l_count          LIKE type_t.num5
   DEFINE r_rtkb008        LIKE rtkb_t.rtkb008
   
   IF NOT cl_null(p_rtkb) THEN
      LET l_count = 0
      LET tok = base.StringTokenizer.create(p_rtkb,",")
      WHILE tok.hasMoreTokens()
         LET l_cnt  = tok.nextToken()
         LET l_count = l_count + 1
      END WHILE  
   END IF
   
   IF p_rtkb004 = 1 THEN
     LET r_rtkb008 = 30 / l_count
   ELSE
      LET r_rtkb008 = 7 / l_count
   END IF
   RETURN r_rtkb008
END FUNCTION

 
{</section>}
 
