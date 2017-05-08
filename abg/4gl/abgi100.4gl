#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2015-07-14 16:55:47), PR版次:0009(2017-02-10 15:53:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: abgi100
#+ Description: 預算組織可編製預算細項維護
#+ Creator....: 03080(2015-07-14 16:55:47)
#+ Modifier...: 03080 -SD/PR- 05016
 
{</section>}
 
{<section id="abgi100.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160321-00016#23   2016/03/24  By Jessy         修正azzi920重複定義之錯誤訊息
#161003-00014#4    2016/10/12  By Hans          單身新增的時候自動產生到abgi110 
#161006-00005#9    2016/10/20  By 08732         組織類型與職能開窗調整
#161101-00053#1    2016/11/03  By Hans          新增时，可用预算细项bgaj003开窗，选择一笔资料后，则该笔资料没有存入。
#161105-00004#3    2016/13/13  By Hans          核算項修改
#170110-00007#1    2017/01/12  By Hans          如果相關abgi110/abgi100 執行修改及刪除預算細項之前判斷
#170209-00020#1    170210      By Hans           預算編號開窗不限制不使用預測。

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
PRIVATE type type_g_bgaj_m        RECORD
       bgaj001 LIKE bgaj_t.bgaj001, 
   bgaj001_desc LIKE type_t.chr80, 
   bgaj002 LIKE bgaj_t.bgaj002, 
   bgaj002_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bgaj_d        RECORD
       bgaj003 LIKE bgaj_t.bgaj003, 
   bgaj003_desc LIKE type_t.chr500, 
   bgajstus LIKE bgaj_t.bgajstus
       END RECORD
PRIVATE TYPE type_g_bgaj2_d RECORD
       bgaj003 LIKE bgaj_t.bgaj003, 
   bgajownid LIKE bgaj_t.bgajownid, 
   bgajownid_desc LIKE type_t.chr500, 
   bgajowndp LIKE bgaj_t.bgajowndp, 
   bgajowndp_desc LIKE type_t.chr500, 
   bgajcrtid LIKE bgaj_t.bgajcrtid, 
   bgajcrtid_desc LIKE type_t.chr500, 
   bgajcrtdp LIKE bgaj_t.bgajcrtdp, 
   bgajcrtdp_desc LIKE type_t.chr500, 
   bgajcrtdt DATETIME YEAR TO SECOND, 
   bgajmodid LIKE bgaj_t.bgajmodid, 
   bgajmodid_desc LIKE type_t.chr500, 
   bgajmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE tok                   base.StringTokenizer  
DEFINE g_bgaa                RECORD
                             bgaa002   LIKE bgaa_t.bgaa002,
                             bgaa003   LIKE bgaa_t.bgaa003,
                             bgaa012   LIKE bgaa_t.bgaa012,
                             bgaa009   LIKE bgaa_t.bgaa009,   #現金變動碼參照表
                             bgaa008   LIKE bgaa_t.bgaa008    
                             END RECORD
DEFINE g_glaald              LIKE glaa_t.glaald
DEFINE g_userorga            STRING   #161006-00005#9   add
DEFINE g_wc_orga             STRING   #161006-00005#9   add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_bgaj_m          type_g_bgaj_m
DEFINE g_bgaj_m_t        type_g_bgaj_m
DEFINE g_bgaj_m_o        type_g_bgaj_m
DEFINE g_bgaj_m_mask_o   type_g_bgaj_m #轉換遮罩前資料
DEFINE g_bgaj_m_mask_n   type_g_bgaj_m #轉換遮罩後資料
 
   DEFINE g_bgaj001_t LIKE bgaj_t.bgaj001
DEFINE g_bgaj002_t LIKE bgaj_t.bgaj002
 
 
DEFINE g_bgaj_d          DYNAMIC ARRAY OF type_g_bgaj_d
DEFINE g_bgaj_d_t        type_g_bgaj_d
DEFINE g_bgaj_d_o        type_g_bgaj_d
DEFINE g_bgaj_d_mask_o   DYNAMIC ARRAY OF type_g_bgaj_d #轉換遮罩前資料
DEFINE g_bgaj_d_mask_n   DYNAMIC ARRAY OF type_g_bgaj_d #轉換遮罩後資料
DEFINE g_bgaj2_d   DYNAMIC ARRAY OF type_g_bgaj2_d
DEFINE g_bgaj2_d_t type_g_bgaj2_d
DEFINE g_bgaj2_d_o type_g_bgaj2_d
DEFINE g_bgaj2_d_mask_o   DYNAMIC ARRAY OF type_g_bgaj2_d #轉換遮罩前資料
DEFINE g_bgaj2_d_mask_n   DYNAMIC ARRAY OF type_g_bgaj2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_bgaj001 LIKE bgaj_t.bgaj001,
      b_bgaj002 LIKE bgaj_t.bgaj002
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
 
{<section id="abgi100.main" >}
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
   LET g_forupd_sql = " SELECT bgaj001,'',bgaj002,''", 
                      " FROM bgaj_t",
                      " WHERE bgajent= ? AND bgaj001=? AND bgaj002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   #161006-00005#9  add ---s
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_sons_str() RETURNING g_userorga
   CALL s_fin_get_wc_str(g_userorga) RETURNING g_userorga
   #161006-00005#9  add ---e
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgi100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bgaj001,t0.bgaj002",
               " FROM bgaj_t t0",
               
               " WHERE t0.bgajent = " ||g_enterprise|| " AND t0.bgaj001 = ? AND t0.bgaj002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgi100_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgi100 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgi100_init()   
 
      #進入選單 Menu (="N")
      CALL abgi100_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgi100
      
   END IF 
   
   CLOSE abgi100_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgi100.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgi100_init()
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
   #CALL s_fin_create_account_center_tmp()   #161006-00005#9   mark
   #161006-00005#9  add---s
   CALL s_fin_abg_center_sons_query(g_userorga,'','')
   CALL s_fin_account_center_sons_str() RETURNING g_wc_orga   
   CALL s_fin_get_wc_str(g_wc_orga) RETURNING g_wc_orga        
   #161006-00005#9  add---e
   #end add-point
   
   CALL abgi100_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abgi100.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abgi100_ui_dialog()
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
         INITIALIZE g_bgaj_m.* TO NULL
         CALL g_bgaj_d.clear()
         CALL g_bgaj2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abgi100_init()
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
               CALL abgi100_idx_chk()
               CALL abgi100_fetch('') # reload data
               LET g_detail_idx = 1
               CALL abgi100_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_bgaj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL abgi100_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL abgi100_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_bgaj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL abgi100_idx_chk()
               CALL abgi100_ui_detailshow()
               
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
            CALL abgi100_browser_fill("")
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
               CALL abgi100_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abgi100_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL abgi100_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abgi100_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi100_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abgi100_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi100_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abgi100_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi100_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abgi100_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi100_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abgi100_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi100_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_bgaj_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_bgaj2_d)
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
               NEXT FIELD bgaj003
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
               CALL abgi100_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL abgi100_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL abgi100_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abgi100_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abgi100_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abgi100_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgi100_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abgi100_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abgi100_01
            LET g_action_choice="open_abgi100_01"
            IF cl_auth_chk_act("open_abgi100_01") THEN
               
               #add-point:ON ACTION open_abgi100_01 name="menu.open_abgi100_01"
               CALL abgi100_01(g_bgaj_m.bgaj001)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgi100_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abgi100_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgi100_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgi100_set_pk_array()
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
 
{<section id="abgi100.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION abgi100_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgi100.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abgi100_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "bgaj001,bgaj002"
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
      LET l_sub_sql = " SELECT DISTINCT bgaj001 ",
                      ", bgaj002 ",
 
                      " FROM bgaj_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE bgajent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bgaj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bgaj001 ",
                      ", bgaj002 ",
 
                      " FROM bgaj_t ",
                      " ",
                      " ", 
 
 
                      " WHERE bgajent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bgaj_t")
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
      INITIALIZE g_bgaj_m.* TO NULL
      CALL g_bgaj_d.clear()        
      CALL g_bgaj2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bgaj001,t0.bgaj002 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.bgaj001,t0.bgaj002",
                " FROM bgaj_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.bgajent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("bgaj_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"bgaj_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_bgaj001,g_browser[g_cnt].b_bgaj002 
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
         CALL abgi100_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_bgaj001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_bgaj_m.* TO NULL
      CALL g_bgaj_d.clear()
      CALL g_bgaj2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL abgi100_fetch('')
   
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
 
{<section id="abgi100.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abgi100_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bgaj_m.bgaj001 = g_browser[g_current_idx].b_bgaj001   
   LET g_bgaj_m.bgaj002 = g_browser[g_current_idx].b_bgaj002   
 
   EXECUTE abgi100_master_referesh USING g_bgaj_m.bgaj001,g_bgaj_m.bgaj002 INTO g_bgaj_m.bgaj001,g_bgaj_m.bgaj002 
 
   CALL abgi100_show()
   
END FUNCTION
 
{</section>}
 
{<section id="abgi100.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abgi100_ui_detailshow()
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
 
{<section id="abgi100.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abgi100_ui_browser_refresh()
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
      IF g_browser[l_i].b_bgaj001 = g_bgaj_m.bgaj001 
         AND g_browser[l_i].b_bgaj002 = g_bgaj_m.bgaj002 
 
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
 
{<section id="abgi100.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgi100_construct()
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
   INITIALIZE g_bgaj_m.* TO NULL
   CALL g_bgaj_d.clear()
   CALL g_bgaj2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON bgaj001,bgaj002
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaj001
            #add-point:BEFORE FIELD bgaj001 name="construct.b.bgaj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaj001
            
            #add-point:AFTER FIELD bgaj001 name="construct.a.bgaj001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgaj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaj001
            #add-point:ON ACTION controlp INFIELD bgaj001 name="construct.c.bgaj001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "bgaastus = 'Y'"
            #CALL q_bgaa001()  #170209-00020#1
            CALL q_bgaa001_1() #170209-00020#1
            DISPLAY g_qryparam.return1 TO bgaj001
            NEXT FIELD bgaj001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaj002
            #add-point:BEFORE FIELD bgaj002 name="construct.b.bgaj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaj002
            
            #add-point:AFTER FIELD bgaj002 name="construct.a.bgaj002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgaj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaj002
            #add-point:ON ACTION controlp INFIELD bgaj002 name="construct.c.bgaj002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef205 = 'Y'"           #161006-00005#9   mark
            LET g_qryparam.where = " ooef001 IN ", g_wc_orga   #161006-00005#9   add
            #CALL q_ooef001()                                  #161006-00005#9   mark
            CALL q_ooef001_77()                                #161006-00005#9   add 
            DISPLAY g_qryparam.return1 TO bgaj002
            NEXT FIELD bgaj002
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON bgaj003,bgajstus,bgajownid,bgajowndp,bgajcrtid,bgajcrtdp,bgajcrtdt,bgajmodid, 
          bgajmoddt
           FROM s_detail1[1].bgaj003,s_detail1[1].bgajstus,s_detail2[1].bgajownid,s_detail2[1].bgajowndp, 
               s_detail2[1].bgajcrtid,s_detail2[1].bgajcrtdp,s_detail2[1].bgajcrtdt,s_detail2[1].bgajmodid, 
               s_detail2[1].bgajmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bgajcrtdt>>----
         AFTER FIELD bgajcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bgajmoddt>>----
         AFTER FIELD bgajmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgajcnfdt>>----
         
         #----<<bgajpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaj003
            #add-point:BEFORE FIELD bgaj003 name="construct.b.page1.bgaj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaj003
            
            #add-point:AFTER FIELD bgaj003 name="construct.a.page1.bgaj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgaj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaj003
            #add-point:ON ACTION controlp INFIELD bgaj003 name="construct.c.page1.bgaj003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgae001()
            DISPLAY g_qryparam.return1 TO s_detail1[1].bgaj003
            NEXT FIELD bgaj003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgajstus
            #add-point:BEFORE FIELD bgajstus name="construct.b.page1.bgajstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgajstus
            
            #add-point:AFTER FIELD bgajstus name="construct.a.page1.bgajstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgajstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgajstus
            #add-point:ON ACTION controlp INFIELD bgajstus name="construct.c.page1.bgajstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgajownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgajownid
            #add-point:ON ACTION controlp INFIELD bgajownid name="construct.c.page2.bgajownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgajownid  #顯示到畫面上
            NEXT FIELD bgajownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgajownid
            #add-point:BEFORE FIELD bgajownid name="construct.b.page2.bgajownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgajownid
            
            #add-point:AFTER FIELD bgajownid name="construct.a.page2.bgajownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgajowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgajowndp
            #add-point:ON ACTION controlp INFIELD bgajowndp name="construct.c.page2.bgajowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgajowndp  #顯示到畫面上
            NEXT FIELD bgajowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgajowndp
            #add-point:BEFORE FIELD bgajowndp name="construct.b.page2.bgajowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgajowndp
            
            #add-point:AFTER FIELD bgajowndp name="construct.a.page2.bgajowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgajcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgajcrtid
            #add-point:ON ACTION controlp INFIELD bgajcrtid name="construct.c.page2.bgajcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgajcrtid  #顯示到畫面上
            NEXT FIELD bgajcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgajcrtid
            #add-point:BEFORE FIELD bgajcrtid name="construct.b.page2.bgajcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgajcrtid
            
            #add-point:AFTER FIELD bgajcrtid name="construct.a.page2.bgajcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgajcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgajcrtdp
            #add-point:ON ACTION controlp INFIELD bgajcrtdp name="construct.c.page2.bgajcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgajcrtdp  #顯示到畫面上
            NEXT FIELD bgajcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgajcrtdp
            #add-point:BEFORE FIELD bgajcrtdp name="construct.b.page2.bgajcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgajcrtdp
            
            #add-point:AFTER FIELD bgajcrtdp name="construct.a.page2.bgajcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgajcrtdt
            #add-point:BEFORE FIELD bgajcrtdt name="construct.b.page2.bgajcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgajmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgajmodid
            #add-point:ON ACTION controlp INFIELD bgajmodid name="construct.c.page2.bgajmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgajmodid  #顯示到畫面上
            NEXT FIELD bgajmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgajmodid
            #add-point:BEFORE FIELD bgajmodid name="construct.b.page2.bgajmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgajmodid
            
            #add-point:AFTER FIELD bgajmodid name="construct.a.page2.bgajmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgajmoddt
            #add-point:BEFORE FIELD bgajmoddt name="construct.b.page2.bgajmoddt"
            
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
 
{<section id="abgi100.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abgi100_filter()
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
      CONSTRUCT g_wc_filter ON bgaj001,bgaj002
                          FROM s_browse[1].b_bgaj001,s_browse[1].b_bgaj002
 
         BEFORE CONSTRUCT
               DISPLAY abgi100_filter_parser('bgaj001') TO s_browse[1].b_bgaj001
            DISPLAY abgi100_filter_parser('bgaj002') TO s_browse[1].b_bgaj002
      
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
 
      CALL abgi100_filter_show('bgaj001')
   CALL abgi100_filter_show('bgaj002')
 
END FUNCTION
 
{</section>}
 
{<section id="abgi100.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abgi100_filter_parser(ps_field)
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
 
{<section id="abgi100.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abgi100_filter_show(ps_field)
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
   LET ls_condition = abgi100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abgi100.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abgi100_query()
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
   CALL g_bgaj_d.clear()
   CALL g_bgaj2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL abgi100_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abgi100_browser_fill(g_wc)
      CALL abgi100_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL abgi100_browser_fill("F")
   
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
      CALL abgi100_fetch("F") 
   END IF
   
   CALL abgi100_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="abgi100.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abgi100_fetch(p_flag)
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
   
   LET g_bgaj_m.bgaj001 = g_browser[g_current_idx].b_bgaj001
   LET g_bgaj_m.bgaj002 = g_browser[g_current_idx].b_bgaj002
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abgi100_master_referesh USING g_bgaj_m.bgaj001,g_bgaj_m.bgaj002 INTO g_bgaj_m.bgaj001,g_bgaj_m.bgaj002 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bgaj_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_bgaj_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_bgaj_m_mask_o.* =  g_bgaj_m.*
   CALL abgi100_bgaj_t_mask()
   LET g_bgaj_m_mask_n.* =  g_bgaj_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgi100_set_act_visible()
   CALL abgi100_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_bgaj_m_t.* = g_bgaj_m.*
   LET g_bgaj_m_o.* = g_bgaj_m.*
   
   #重新顯示   
   CALL abgi100_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abgi100.insert" >}
#+ 資料新增
PRIVATE FUNCTION abgi100_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_bgaj_d.clear()
   CALL g_bgaj2_d.clear()
 
 
   INITIALIZE g_bgaj_m.* TO NULL             #DEFAULT 設定
   LET g_bgaj001_t = NULL
   LET g_bgaj002_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL abgi100_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_bgaj_m.* TO NULL
         INITIALIZE g_bgaj_d TO NULL
         INITIALIZE g_bgaj2_d TO NULL
 
         CALL abgi100_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgaj_m.* = g_bgaj_m_t.*
         CALL abgi100_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_bgaj_d.clear()
      #CALL g_bgaj2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgi100_set_act_visible()
   CALL abgi100_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bgaj001_t = g_bgaj_m.bgaj001
   LET g_bgaj002_t = g_bgaj_m.bgaj002
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgajent = " ||g_enterprise|| " AND",
                      " bgaj001 = '", g_bgaj_m.bgaj001, "' "
                      ," AND bgaj002 = '", g_bgaj_m.bgaj002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgi100_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL abgi100_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abgi100_master_referesh USING g_bgaj_m.bgaj001,g_bgaj_m.bgaj002 INTO g_bgaj_m.bgaj001,g_bgaj_m.bgaj002 
 
   
   #遮罩相關處理
   LET g_bgaj_m_mask_o.* =  g_bgaj_m.*
   CALL abgi100_bgaj_t_mask()
   LET g_bgaj_m_mask_n.* =  g_bgaj_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bgaj_m.bgaj001,g_bgaj_m.bgaj001_desc,g_bgaj_m.bgaj002,g_bgaj_m.bgaj002_desc
   
   #功能已完成,通報訊息中心
   CALL abgi100_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abgi100.modify" >}
#+ 資料修改
PRIVATE FUNCTION abgi100_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_bgaj_m.bgaj001 IS NULL
   OR g_bgaj_m.bgaj002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_bgaj001_t = g_bgaj_m.bgaj001
   LET g_bgaj002_t = g_bgaj_m.bgaj002
 
   CALL s_transaction_begin()
   
   OPEN abgi100_cl USING g_enterprise,g_bgaj_m.bgaj001,g_bgaj_m.bgaj002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgi100_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgi100_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgi100_master_referesh USING g_bgaj_m.bgaj001,g_bgaj_m.bgaj002 INTO g_bgaj_m.bgaj001,g_bgaj_m.bgaj002 
 
   
   #遮罩相關處理
   LET g_bgaj_m_mask_o.* =  g_bgaj_m.*
   CALL abgi100_bgaj_t_mask()
   LET g_bgaj_m_mask_n.* =  g_bgaj_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL abgi100_show()
   WHILE TRUE
      LET g_bgaj001_t = g_bgaj_m.bgaj001
      LET g_bgaj002_t = g_bgaj_m.bgaj002
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL abgi100_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgaj_m.* = g_bgaj_m_t.*
         CALL abgi100_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_bgaj_m.bgaj001 != g_bgaj001_t 
      OR g_bgaj_m.bgaj002 != g_bgaj002_t 
 
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
   CALL abgi100_set_act_visible()
   CALL abgi100_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bgajent = " ||g_enterprise|| " AND",
                      " bgaj001 = '", g_bgaj_m.bgaj001, "' "
                      ," AND bgaj002 = '", g_bgaj_m.bgaj002, "' "
 
   #填到對應位置
   CALL abgi100_browser_fill("")
 
   CALL abgi100_idx_chk()
 
   CLOSE abgi100_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgi100_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="abgi100.input" >}
#+ 資料輸入
PRIVATE FUNCTION abgi100_input(p_cmd)
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
   DEFINE l_return         STRING
   DEFINE l_detail_cnt     LIKE type_t.num10
   DEFINE l_bgaj003        LIKE bgaj_t.bgaj003
   DEFINE l_do_auto_ins    DYNAMIC ARRAY OF LIKE type_t.num10
   DEFINE l_bgae006        LIKE bgae_t.bgae006
   DEFINE l_count2         LIKE type_t.num10
   DEFINE l_ac2            LIKE type_t.num10
   DEFINE l_orga           STRING   #161006-00005#9   add
   DEFINE l_bgaa006        LIKE bgaa_t.bgaa006     #170110-00007
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
   DISPLAY BY NAME g_bgaj_m.bgaj001,g_bgaj_m.bgaj001_desc,g_bgaj_m.bgaj002,g_bgaj_m.bgaj002_desc
   
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
   LET g_forupd_sql = "SELECT bgaj003,bgajstus,bgaj003,bgajownid,bgajowndp,bgajcrtid,bgajcrtdp,bgajcrtdt, 
       bgajmodid,bgajmoddt FROM bgaj_t WHERE bgajent=? AND bgaj001=? AND bgaj002=? AND bgaj003=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgi100_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abgi100_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abgi100_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   IF l_cmd_t = 'r' THEN
      CALL cl_set_comp_entry("bgaj001",FALSE)
   END IF
   #end add-point
 
   DISPLAY BY NAME g_bgaj_m.bgaj001,g_bgaj_m.bgaj002
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abgi100.input.head" >}
   
      #單頭段
      INPUT BY NAME g_bgaj_m.bgaj001,g_bgaj_m.bgaj002 
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
         AFTER FIELD bgaj001
            
            #add-point:AFTER FIELD bgaj001 name="input.a.bgaj001"

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_bgaj_m.bgaj001) AND NOT cl_null(g_bgaj_m.bgaj002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgaj_m.bgaj001 != g_bgaj001_t  OR g_bgaj_m.bgaj002 != g_bgaj002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bgaj_t WHERE "||"bgajent = '" ||g_enterprise|| "' AND "||"bgaj001 = '"||g_bgaj_m.bgaj001 ||"' AND "|| "bgaj002 = '"||g_bgaj_m.bgaj002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_bgaj_m.bgaj001_desc = ' '
            DISPLAY BY NAME g_bgaj_m.bgaj001_desc
            IF NOT cl_null(g_bgaj_m.bgaj001) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgaj_m.bgaj001 != g_bgaj_m_t.bgaj001 OR g_bgaj_m_t.bgaj001 IS NULL )) THEN
                  CALL s_fin_budget_chk(g_bgaj_m.bgaj001)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success  THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.popup = TRUE
                     #160321-00016#23 --s add
                     LET g_errparam.replace[1] = 'abgi040'
                     LET g_errparam.replace[2] = cl_get_progname('abgi040',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi040'
                     #160321-00016#23 --e add
                     LET g_errparam.extend = ''
                     CALL cl_err()
                     LET g_bgaj_m.bgaj001 = g_bgaj_m_t.bgaj001
                     LET g_bgaj_m.bgaj001_desc = s_desc_get_budget_desc(g_bgaj_m.bgaj001)
                     DISPLAY BY NAME g_bgaj_m.bgaj001,g_bgaj_m.bgaj001_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_abg_center_sons_query(g_bgaj_m.bgaj001,'','')
                  
                  LET g_bgaj_m.bgaj002 = ''
                  LET g_bgaj_m.bgaj002_desc = ''
                  DISPLAY BY NAME g_bgaj_m.bgaj002,g_bgaj_m.bgaj002_desc    #修改預算編號清空預算組織避免修改成不存在組織樹中的組織
               END IF
            END IF
            LET g_bgaj_m.bgaj001_desc = s_desc_get_budget_desc(g_bgaj_m.bgaj001)
            DISPLAY BY NAME g_bgaj_m.bgaj001,g_bgaj_m.bgaj001_desc
            


           LET g_glaald = NULL
           SELECT glaald INTO g_glaald FROM glaa_t,ooef_t
            WHERE glaaent = g_enterprise
              AND glaacomp = ooef017
              AND glaaent = ooefent
              AND ooef001 = g_bgaj_m.bgaj002
              AND glaa014 = 'Y'
              
           INITIALIZE g_bgaa.* TO NULL
           SELECT bgaa002,bgaa003,bgaa012,bgaa009,bgaa008
             INTO g_bgaa.*
             FROM bgaa_t
            WHERE bgaaent = g_enterprise
              AND bgaa001 = g_bgaj_m.bgaj001
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaj001
            #add-point:BEFORE FIELD bgaj001 name="input.b.bgaj001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaj001
            #add-point:ON CHANGE bgaj001 name="input.g.bgaj001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaj002
            
            #add-point:AFTER FIELD bgaj002 name="input.a.bgaj002"

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_bgaj_m.bgaj001) AND NOT cl_null(g_bgaj_m.bgaj002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgaj_m.bgaj001 != g_bgaj001_t  OR g_bgaj_m.bgaj002 != g_bgaj002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bgaj_t WHERE "||"bgajent = '" ||g_enterprise|| "' AND "||"bgaj001 = '"||g_bgaj_m.bgaj001 ||"' AND "|| "bgaj002 = '"||g_bgaj_m.bgaj002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_bgaj_m.bgaj002_desc = ' '
            DISPLAY BY NAME g_bgaj_m.bgaj002_desc
            IF NOT cl_null(g_bgaj_m.bgaj002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgaj_m.bgaj002 != g_bgaj_m_t.bgaj002 OR g_bgaj_m_t.bgaj002 IS NULL )) THEN
                  CALL abgi100_bgaj002_chk(g_bgaj_m.bgaj002)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgaj_m.bgaj002 = g_bgaj_m_t.bgaj002
                     LET g_bgaj_m.bgaj002_desc =s_desc_get_department_desc(g_bgaj_m.bgaj002)
                     DISPLAY BY NAME g_bgaj_m.bgaj002,g_bgaj_m.bgaj002_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_bgaj_m.bgaj001)THEN
                     CALL s_abg_site_chk(g_bgaj_m.bgaj002)RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgaj_m.bgaj002 = g_bgaj_m_t.bgaj002
                        LET g_bgaj_m.bgaj002_desc =s_desc_get_department_desc(g_bgaj_m.bgaj002)
                        DISPLAY BY NAME g_bgaj_m.bgaj002,g_bgaj_m.bgaj002_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                                    
               END IF
            END IF
            LET g_bgaj_m.bgaj002_desc =s_desc_get_department_desc(g_bgaj_m.bgaj002)
            DISPLAY BY NAME g_bgaj_m.bgaj002,g_bgaj_m.bgaj002_desc

           LET g_glaald = NULL
           SELECT glaald INTO g_glaald FROM glaa_t,ooef_t
            WHERE glaaent = g_enterprise
              AND glaacomp = ooef017
              AND glaaent = ooefent
              AND ooef001 = g_bgaj_m.bgaj002
              AND glaa014 = 'Y'
              
           INITIALIZE g_bgaa.* TO NULL
           SELECT bgaa002,bgaa003,bgaa012,bgaa009,bgaa008
             INTO g_bgaa.*
             FROM bgaa_t
            WHERE bgaaent = g_enterprise
              AND bgaa001 = g_bgaj_m.bgaj001
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaj002
            #add-point:BEFORE FIELD bgaj002 name="input.b.bgaj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaj002
            #add-point:ON CHANGE bgaj002 name="input.g.bgaj002"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgaj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaj001
            #add-point:ON ACTION controlp INFIELD bgaj001 name="input.c.bgaj001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgaj_m.bgaj001
            LET g_qryparam.where = "bgaastus = 'Y'"
           #CALL q_bgaa001()   #170209-00020#1 
            CALL q_bgaa001_1() #170209-00020#1            
            LET g_bgaj_m.bgaj001 = g_qryparam.return1
            DISPLAY BY NAME g_bgaj_m.bgaj001
            NEXT FIELD bgaj001
            #END add-point
 
 
         #Ctrlp:input.c.bgaj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaj002
            #add-point:ON ACTION controlp INFIELD bgaj002 name="input.c.bgaj002"
            #161006-00005#9  add----s
            CALL s_fin_abg_center_sons_query(g_bgaj_m.bgaj002,'','')  
            CALL s_fin_account_center_sons_str() RETURNING l_orga  
            CALL s_fin_get_wc_str(l_orga) RETURNING l_orga
            #161006-00005#9  add----e
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " ooef205 = 'Y'"
            #LET g_qryparam.where = " ooef001 IN (SELECT ooef001 FROM s_fin_tmp1) "       #161006-00005#9   mark
            LET g_qryparam.where = " ooef001 IN ", g_userorga," AND ooef001 IN ", l_orga  #161006-00005#9   add
            LET g_qryparam.default1 = g_bgaj_m.bgaj002
            #CALL q_ooef001()                                                             #161006-00005#9   mark
            CALL q_ooef001_77()                                                           #161006-00005#9   add
            LET g_bgaj_m.bgaj002 = g_qryparam.return1
            NEXT FIELD bgaj002
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
            DISPLAY BY NAME g_bgaj_m.bgaj001             
                            ,g_bgaj_m.bgaj002   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL abgi100_bgaj_t_mask_restore('restore_mask_o')
            
               UPDATE bgaj_t SET (bgaj001,bgaj002) = (g_bgaj_m.bgaj001,g_bgaj_m.bgaj002)
                WHERE bgajent = g_enterprise AND bgaj001 = g_bgaj001_t
                  AND bgaj002 = g_bgaj002_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgaj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgaj_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgaj_m.bgaj001
               LET gs_keys_bak[1] = g_bgaj001_t
               LET gs_keys[2] = g_bgaj_m.bgaj002
               LET gs_keys_bak[2] = g_bgaj002_t
               LET gs_keys[3] = g_bgaj_d[g_detail_idx].bgaj003
               LET gs_keys_bak[3] = g_bgaj_d_t.bgaj003
               CALL abgi100_update_b('bgaj_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_bgaj_m_t)
                     #LET g_log2 = util.JSON.stringify(g_bgaj_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL abgi100_bgaj_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL abgi100_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_bgaj001_t = g_bgaj_m.bgaj001
           LET g_bgaj002_t = g_bgaj_m.bgaj002
 
           
           IF g_bgaj_d.getLength() = 0 THEN
              NEXT FIELD bgaj003
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="abgi100.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_bgaj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bgaj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgi100_b_fill(g_wc2) #test 
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
            CALL abgi100_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN abgi100_cl USING g_enterprise,g_bgaj_m.bgaj001,g_bgaj_m.bgaj002                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE abgi100_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgi100_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_bgaj_d[l_ac].bgaj003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bgaj_d_t.* = g_bgaj_d[l_ac].*  #BACKUP
               LET g_bgaj_d_o.* = g_bgaj_d[l_ac].*  #BACKUP
               CALL abgi100_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL abgi100_set_no_entry_b(l_cmd)
               OPEN abgi100_bcl USING g_enterprise,g_bgaj_m.bgaj001,
                                                g_bgaj_m.bgaj002,
 
                                                g_bgaj_d_t.bgaj003
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgi100_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgi100_bcl INTO g_bgaj_d[l_ac].bgaj003,g_bgaj_d[l_ac].bgajstus,g_bgaj2_d[l_ac].bgaj003, 
                      g_bgaj2_d[l_ac].bgajownid,g_bgaj2_d[l_ac].bgajowndp,g_bgaj2_d[l_ac].bgajcrtid, 
                      g_bgaj2_d[l_ac].bgajcrtdp,g_bgaj2_d[l_ac].bgajcrtdt,g_bgaj2_d[l_ac].bgajmodid, 
                      g_bgaj2_d[l_ac].bgajmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_bgaj_d_t.bgaj003,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bgaj_d_mask_o[l_ac].* =  g_bgaj_d[l_ac].*
                  CALL abgi100_bgaj_t_mask()
                  LET g_bgaj_d_mask_n[l_ac].* =  g_bgaj_d[l_ac].*
                  
                  CALL abgi100_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL l_do_auto_ins.clear()
            IF g_bgaa.bgaa012 = 'Y' THEN
               CALL s_desc_get_account_desc(g_glaald,g_bgaj_d[l_ac].bgaj003) RETURNING g_bgaj_d[l_ac].bgaj003_desc
            ELSE
               LET l_bgae006 = NULL
               SELECT bgaa008 INTO l_bgae006 FROM bgaa_t
                WHERE bgaaent = g_enterprise
                  AND bgaa001 = g_bgaj_m.bgaj001
               CALL s_abg_bgae001_desc(l_bgae006,g_bgaj_d[l_ac].bgaj003)RETURNING g_bgaj_d[l_ac].bgaj003_desc
            ENd IF
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_bgaj_d_t.* TO NULL
            INITIALIZE g_bgaj_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bgaj_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgaj2_d[l_ac].bgajownid = g_user
      LET g_bgaj2_d[l_ac].bgajowndp = g_dept
      LET g_bgaj2_d[l_ac].bgajcrtid = g_user
      LET g_bgaj2_d[l_ac].bgajcrtdp = g_dept 
      LET g_bgaj2_d[l_ac].bgajcrtdt = cl_get_current()
      LET g_bgaj2_d[l_ac].bgajmodid = g_user
      LET g_bgaj2_d[l_ac].bgajmoddt = cl_get_current()
      LET g_bgaj_d[l_ac].bgajstus = ''
 
 
  
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            LET g_bgaj_d[l_ac].bgajstus = 'Y'
            #end add-point
            LET g_bgaj_d_t.* = g_bgaj_d[l_ac].*     #新輸入資料
            LET g_bgaj_d_o.* = g_bgaj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abgi100_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL abgi100_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bgaj_d[li_reproduce_target].* = g_bgaj_d[li_reproduce].*
               LET g_bgaj2_d[li_reproduce_target].* = g_bgaj2_d[li_reproduce].*
 
               LET g_bgaj_d[g_bgaj_d.getLength()].bgaj003 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM bgaj_t 
             WHERE bgajent = g_enterprise AND bgaj001 = g_bgaj_m.bgaj001
               AND bgaj002 = g_bgaj_m.bgaj002
 
               AND bgaj003 = g_bgaj_d[l_ac].bgaj003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO bgaj_t
                           (bgajent,
                            bgaj001,bgaj002,
                            bgaj003
                            ,bgajstus,bgajownid,bgajowndp,bgajcrtid,bgajcrtdp,bgajcrtdt,bgajmodid,bgajmoddt) 
                     VALUES(g_enterprise,
                            g_bgaj_m.bgaj001,g_bgaj_m.bgaj002,
                            g_bgaj_d[l_ac].bgaj003
                            ,g_bgaj_d[l_ac].bgajstus,g_bgaj2_d[l_ac].bgajownid,g_bgaj2_d[l_ac].bgajowndp, 
                                g_bgaj2_d[l_ac].bgajcrtid,g_bgaj2_d[l_ac].bgajcrtdp,g_bgaj2_d[l_ac].bgajcrtdt, 
                                g_bgaj2_d[l_ac].bgajmodid,g_bgaj2_d[l_ac].bgajmoddt)
               #add-point:單身新增中 name="input.body.m_insert"
               IF SQLCA.SQLCODE THEN
               ELSE
                  LET l_ac_t = l_ac
                  IF l_do_auto_ins.getLength() > 0 THEN
                     FOR l_count = 1 TO l_do_auto_ins.getLength()
                        IF NOT cl_null(l_do_auto_ins[l_count]) AND l_do_auto_ins[l_count] > 0 THEN
                           LET l_ac = l_do_auto_ins[l_count]
                           INSERT INTO bgaj_t
                                       (bgajent,
                                        bgaj001,bgaj002,
                                        bgaj003
                                        ,bgajstus,bgajownid,bgajowndp,bgajcrtid,bgajcrtdp,bgajcrtdt,bgajmodid,bgajmoddt) 
                                 VALUES(g_enterprise,
                                        g_bgaj_m.bgaj001,g_bgaj_m.bgaj002,
                                        g_bgaj_d[l_ac].bgaj003
                                        ,g_bgaj_d[l_ac].bgajstus,g_bgaj2_d[l_ac].bgajownid,g_bgaj2_d[l_ac].bgajowndp, 
                                            g_bgaj2_d[l_ac].bgajcrtid,g_bgaj2_d[l_ac].bgajcrtdp,g_bgaj2_d[l_ac].bgajcrtdt, 
                                            g_bgaj2_d[l_ac].bgajmodid,g_bgaj2_d[l_ac].bgajmoddt)    
                           #161003-00014#4       
                           CALL abgi100_ins_bgal(g_bgaj_d[l_ac].bgaj003) RETURNING g_sub_success,g_errno                           
                           IF NOT g_sub_success THEN
                              INITIALIZE g_errparam TO NULL 
                              LET g_errparam.extend = "INSERT INTO bgal_t" 
                              LET g_errparam.code   = SQLCA.sqlcode 
                              LET g_errparam.popup  = TRUE 
                              CALL s_transaction_end('N','0')                    
                              CALL cl_err()
                              CANCEL INSERT              
                           END IF                           
                           IF SQLCA.SQLCODE THEN
                           ELSE
                              LET g_rec_b = g_rec_b + 1
                           END IF
                        END IF
                     END FOR
                     
                     CALL l_do_auto_ins.clear()
                     LET l_ac = l_ac_t
                  END IF
               END IF
               IF l_do_auto_ins.getLength() = 0 THEN               
                  CALL abgi100_ins_bgal(g_bgaj_d[l_ac].bgaj003) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "INSERT INTO bgal_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')                    
                     CALL cl_err()
                     CANCEL INSERT              
                  END IF
               END IF
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_bgaj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "bgaj_t:",SQLERRMESSAGE 
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
               IF abgi100_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_bgaj_m.bgaj001
                  LET gs_keys[gs_keys.getLength()+1] = g_bgaj_m.bgaj002
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bgaj_d_t.bgaj003
 
 
                  #刪除下層單身
                  IF NOT abgi100_key_delete_b(gs_keys,'bgaj_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE abgi100_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE abgi100_bcl
               LET l_count = g_bgaj_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_bgaj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaj003
            
            #add-point:AFTER FIELD bgaj003 name="input.a.page1.bgaj003"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_bgaj_m.bgaj001 IS NOT NULL AND g_bgaj_m.bgaj002 IS NOT NULL AND g_bgaj_d[g_detail_idx].bgaj003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgaj_m.bgaj001 != g_bgaj001_t OR g_bgaj_m.bgaj002 != g_bgaj002_t OR g_bgaj_d[g_detail_idx].bgaj003 != g_bgaj_d_t.bgaj003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bgaj_t WHERE "||"bgajent = '" ||g_enterprise|| "' AND "||"bgaj001 = '"||g_bgaj_m.bgaj001 ||"' AND "|| "bgaj002 = '"||g_bgaj_m.bgaj002 ||"' AND "|| "bgaj003 = '"||g_bgaj_d[g_detail_idx].bgaj003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            #檢查是否存在這次自動產生的編號中
            IF l_do_auto_ins.getLength() > 0 THEN
               FOR l_count = 1 TO l_do_auto_ins.getLength()
                  IF NOT cl_null(l_do_auto_ins[l_count]) AND l_do_auto_ins[l_count] > 0 THEN
                     LET l_ac2 = l_do_auto_ins[l_count]
                     IF g_bgaj_d[l_ac].bgaj003 = g_bgaj_d[l_ac2].bgaj003 THEN
                        INITIALIZE g_errparam.* TO NULL
                        LET g_errparam.code = 'std-00004'
                        LET g_errparam.popup = TRUE
                        LET g_errparam.extend = ''
                        CALL cl_err()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END FOR
            END IF

            LET g_bgaj_d[l_ac].bgaj003_desc = ' '
            DISPLAY BY NAME g_bgaj_d[l_ac].bgaj003_desc
            IF NOT cl_null(g_bgaj_d[l_ac].bgaj003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgaj_d[l_ac].bgaj003 != g_bgaj_d_t.bgaj003 OR g_bgaj_d_t.bgaj003 IS NULL )) THEN
                  IF g_bgaa.bgaa012 = 'Y' THEN
                     #科目檢查
                     CALL s_aap_glac002_chk(g_bgaj_d[l_ac].bgaj003,g_glaald) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        #160321-00016#23 --s add
                        LET g_errparam.replace[1] = 'agli020'
                        LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                        LET g_errparam.exeprog = 'agli020'
                        #160321-00016#23 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgaj_d[l_ac].bgaj003 = g_bgaj_d_t.bgaj003
                        CALL s_desc_get_account_desc(g_glaald,g_bgaj_d[l_ac].bgaj003) RETURNING g_bgaj_d[l_ac].bgaj003_desc
                        DISPLAY BY NAME g_bgaj_d[l_ac].bgaj003,g_bgaj_d[l_ac].bgaj003_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     CALL s_abg_bgae001_chk(g_bgaj_m.bgaj001,'',g_bgaj_d[l_ac].bgaj003,'1')RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgaj_d[l_ac].bgaj003 = g_bgaj_d_t.bgaj003
                        LET l_bgae006 = NULL
                        SELECT bgaa008 INTO l_bgae006 FROM bgaa_t
                         WHERE bgaaent = g_enterprise
                           AND bgaa001 = g_bgaj_m.bgaj001
                        CALL s_abg_bgae001_desc(l_bgae006,g_bgaj_d[l_ac].bgaj003)RETURNING g_bgaj_d[l_ac].bgaj003_desc
                        DISPLAY BY NAME g_bgaj_d[l_ac].bgaj003,g_bgaj_d[l_ac].bgaj003_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            
            IF g_bgaa.bgaa012 = 'Y' THEN
               CALL s_desc_get_account_desc(g_glaald,g_bgaj_d[l_ac].bgaj003) RETURNING g_bgaj_d[l_ac].bgaj003_desc
               DISPLAY BY NAME g_bgaj_d[l_ac].bgaj003,g_bgaj_d[l_ac].bgaj003_desc
            ELSE
               LET l_bgae006 = NULL
               SELECT bgaa008 INTO l_bgae006 FROM bgaa_t
                WHERE bgaaent = g_enterprise
                  AND bgaa001 = g_bgaj_m.bgaj001
               CALL s_abg_bgae001_desc(l_bgae006,g_bgaj_d[l_ac].bgaj003)RETURNING g_bgaj_d[l_ac].bgaj003_desc
               DISPLAY BY NAME g_bgaj_d[l_ac].bgaj003_desc
            ENd IF
            DISPLAY BY NAME g_bgaj_d[l_ac].bgaj003 #161101-00053#1 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaj003
            #add-point:BEFORE FIELD bgaj003 name="input.b.page1.bgaj003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaj003
            #add-point:ON CHANGE bgaj003 name="input.g.page1.bgaj003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaj003_desc
            #add-point:BEFORE FIELD bgaj003_desc name="input.b.page1.bgaj003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaj003_desc
            
            #add-point:AFTER FIELD bgaj003_desc name="input.a.page1.bgaj003_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaj003_desc
            #add-point:ON CHANGE bgaj003_desc name="input.g.page1.bgaj003_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgajstus
            #add-point:BEFORE FIELD bgajstus name="input.b.page1.bgajstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgajstus
            
            #add-point:AFTER FIELD bgajstus name="input.a.page1.bgajstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgajstus
            #add-point:ON CHANGE bgajstus name="input.g.page1.bgajstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bgaj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaj003
            #add-point:ON ACTION controlp INFIELD bgaj003 name="input.c.page1.bgaj003"

            
            ##########
            IF l_cmd = 'u' THEN
               IF g_bgaa.bgaa012 = 'Y' THEN
                  #抓取會計科目
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_bgaj_d[l_ac].bgaj003  #給予default值
                  LET g_qryparam.where = "glac001 = '",g_bgaa.bgaa008,"' AND  glac003 <>'1' "  #glac001(會計科目參照表)/glac003(科>
                  CALL aglt310_04()
                  LET g_bgaj_d[l_ac].bgaj003 = g_qryparam.return1
                  NEXT FIELD bgaj003
               ELSE
                  #此段落由子樣板a07產生            
                  #開窗i段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_bgaj_d[l_ac].bgaj003  #給予default值
                  LET g_qryparam.where = " bgae006 IN (SELECT bgaa008 FROM bgaa_t WHERE bgaaent = ",g_enterprise," ",
                                                        " AND bgaa001 = '",g_bgaj_m.bgaj001,"') AND bgae007 = '1' "
                  CALL q_bgae001()
                  DISPLAY g_qryparam.return1 TO s_detail1[1].bgaj003
                  LET g_bgaj_d[l_ac].bgaj003 = g_qryparam.return1
                  NEXT FIELD bgaj003
               END IF
            ELSE
               IF g_bgaa.bgaa012 = 'Y' THEN
                  #抓取會計科目
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = "glac001 = '",g_bgaa.bgaa008,"' AND  glac003 <>'1' "  #glac001(會計科目參照表)/glac003(科>
                  CALL aglt310_04()
                  LET l_return = g_qryparam.return1
               ELSE
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = " bgae006 IN (SELECT bgaa008 FROM bgaa_t WHERE bgaaent = ",g_enterprise," ",
                                                        " AND bgaa001 = '",g_bgaj_m.bgaj001,"') AND bgae007 = '1' "
                  CALL q_bgae001()
                  LET l_return = g_qryparam.return1                 #將開窗取得的值回傳到變數
               END IF

               IF NOT cl_null(l_return) THEN
                  CALL l_do_auto_ins.clear()
                  LET l_count = 0
                  LET tok = base.StringTokenizer.create(l_return,"|")
                  LET l_detail_cnt = g_bgaj_d.getLength()
                  LET l_ac_t = l_ac
                  WHILE tok.hasMoreTokens()
                     LET l_bgaj003  = tok.nextToken()
                     LET l_cnt = 0

                     #此預算編號 預算組織已經存在過了 就剔除-----s
                     LET l_count2 = NULL
                     SELECT COUNT(1) INTO l_count2 FROM bgaj_t
                      WHERE bgajent = g_enterprise
                        AND bgaj001 = g_bgaj_m.bgaj001
                        AND bgaj002 = g_bgaj_m.bgaj002
                        AND bgaj003 = l_bgaj003
                     IF cl_null(l_count2)THEN LET l_count2 = 0 END IF
                     IF l_count2 > 0 THEN
                        CONTINUE WHILE
                     END IF
                     #此預算編號 預算組織已經存在過了 就剔除-----e
                     
                     LET l_count = l_count + 1                                        
                     IF l_count > 1 THEN
                        LET l_ac = l_detail_cnt + l_count - 1
                        LET g_bgaj_d[l_ac].bgaj003 = l_bgaj003 
                        LET g_bgaj2_d[l_ac].bgajownid = g_user
                        LET g_bgaj2_d[l_ac].bgajowndp = g_dept
                        LET g_bgaj2_d[l_ac].bgajcrtid = g_user
                        LET g_bgaj2_d[l_ac].bgajcrtdp = g_dept 
                        LET g_bgaj2_d[l_ac].bgajcrtdt = cl_get_current()
                        LET g_bgaj2_d[l_ac].bgajmodid = g_user
                        LET g_bgaj2_d[l_ac].bgajmoddt = cl_get_current()
                        LET g_bgaj_d[l_ac].bgajstus = 'Y'
                        
                        IF g_bgaa.bgaa012 = 'Y' THEN
                           CALL s_desc_get_account_desc(g_glaald,g_bgaj_d[l_ac].bgaj003) RETURNING g_bgaj_d[l_ac].bgaj003_desc
                        ELSE
                           LET l_bgae006 = NULL
                           SELECT bgaa008 INTO l_bgae006 FROM bgaa_t
                            WHERE bgaaent = g_enterprise
                              AND bgaa001 = g_bgaj_m.bgaj001
                           CALL s_abg_bgae001_desc(l_bgae006,g_bgaj_d[l_ac].bgaj003)RETURNING g_bgaj_d[l_ac].bgaj003_desc
                        END IF
                        
                        LET l_do_auto_ins[l_count] = l_ac
                     ELSE
                        LET g_bgaj_d[l_ac].bgaj003 = l_bgaj003 
                        LET g_bgaj2_d[l_ac].bgajownid = g_user
                        LET g_bgaj2_d[l_ac].bgajowndp = g_dept
                        LET g_bgaj2_d[l_ac].bgajcrtid = g_user
                        LET g_bgaj2_d[l_ac].bgajcrtdp = g_dept 
                        LET g_bgaj2_d[l_ac].bgajcrtdt = cl_get_current()
                        LET g_bgaj2_d[l_ac].bgajmodid = g_user
                        LET g_bgaj2_d[l_ac].bgajmoddt = cl_get_current()
                        LET g_bgaj_d[l_ac].bgajstus = 'Y'
                        IF g_bgaa.bgaa012 = 'Y' THEN
                           CALL s_desc_get_account_desc(g_glaald,g_bgaj_d[l_ac].bgaj003) RETURNING g_bgaj_d[l_ac].bgaj003_desc
                        ELSE
                           LET l_bgae006 = NULL
                           SELECT bgaa008 INTO l_bgae006 FROM bgaa_t
                            WHERE bgaaent = g_enterprise
                              AND bgaa001 = g_bgaj_m.bgaj001
                           CALL s_abg_bgae001_desc(l_bgae006,g_bgaj_d[l_ac].bgaj003)RETURNING g_bgaj_d[l_ac].bgaj003_desc
                        END IF
                        DISPLAY BY NAME l_bgae006,g_bgaj_d[l_ac].bgaj003
                     END IF
                     LET l_ac = l_ac_t
                  END WHILE
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF
               END IF
            END IF
            ##########
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgaj003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaj003_desc
            #add-point:ON ACTION controlp INFIELD bgaj003_desc name="input.c.page1.bgaj003_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgajstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgajstus
            #add-point:ON ACTION controlp INFIELD bgajstus name="input.c.page1.bgajstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bgaj_d[l_ac].* = g_bgaj_d_t.*
               CLOSE abgi100_bcl
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
               LET g_errparam.extend = g_bgaj_d[l_ac].bgaj003 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_bgaj_d[l_ac].* = g_bgaj_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_bgaj2_d[l_ac].bgajmodid = g_user 
LET g_bgaj2_d[l_ac].bgajmoddt = cl_get_current()
LET g_bgaj2_d[l_ac].bgajmodid_desc = cl_get_username(g_bgaj2_d[l_ac].bgajmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               #170110-00007#1---s---
               SELECT bgaa006 INTO l_bgaa006 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgaj_m.bgaj001
               IF l_bgaa006 ='1' THEN #使用預測
                  LET l_cnt = 0
                  IF l_cnt = 0 THEN # 銷售預算 (abgt340) bgcj049   
                     SELECT COUNT(1) INTO l_cnt FROM bgcj_t
                      WHERE bgcjent = g_enterprise AND bgcj049 = g_bgaj_d_t.bgaj003 AND bgcjstus <> 'X' 
                        AND bgcj002 = g_bgaj_m.bgaj001 AND bgcj007 = g_bgaj_m.bgaj002
                     IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  END IF
                  IF l_cnt = 0 THEN # 採購預算 (abgt510) bgeg049   
                     SELECT COUNT(1) INTO l_cnt FROM bgeg_t
                      WHERE bgegent = g_enterprise AND bgeg049 = g_bgaj_d_t.bgaj003 AND bgegstus <> 'X'
                        AND bgeg002 = g_bgaj_m.bgaj001 AND bgeg007 = g_bgaj_m.bgaj002
                     IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  END IF
                  IF l_cnt = 0 THEN # 費用預算 (abgt610) bgfb009  
                     SELECT COUNT(1) INTO l_cnt FROM bgfb_t
                      WHERE bgfbent = g_enterprise AND bgfb009 = g_bgaj_d_t.bgaj003 AND bgfbstus <> 'X'
                        AND bgfb002 = g_bgaj_m.bgaj001 AND bgfb007 = g_bgaj_m.bgaj002
                     IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  END IF               
                  IF l_cnt = 0 THEN # 人工費用預算 (abgt730) bggo039 /bggo040 
                     SELECT COUNT(1) INTO l_cnt FROM bggo_t
                      WHERE bggoent = g_enterprise AND (bggo039 = g_bgaj_d_t.bgaj003 OR bggo040 = g_bgaj_d_t.bgaj003) AND bggostus <> 'X'
                        AND bggo002 = g_bgaj_m.bgaj001 AND bggo007 = g_bgaj_m.bgaj002
                     IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  END IF                 
                  IF l_cnt = 0 THEN #憑證(abgt030)  bgbb002  
                     SELECT COUNT(1) INTO l_cnt FROM bgbb_t,bgba_t                     
                      WHERE bgbaent = bgbbent AND bgbbent = g_enterprise AND bgbb002 = g_bgaj_d_t.bgaj003 
                        AND bgbadocno = bgbbdocno   AND bgbastus <>'X'
                        AND bgba001 = g_bgaj_m.bgaj001 AND bgba005 = g_bgaj_m.bgaj002
                     IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  END IF                                
               ELSE
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM bgbi_t 
                   WHERE bgbient = g_enterprise AND bgbi005 = g_bgaj_d_t.bgaj003 AND bgbistus <> 'X'
                     AND bgbi002 = g_bgaj_m.bgaj001 AND bgbi004 = g_bgaj_m.bgaj002
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               END IF
               IF l_cnt > 0 THEN
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'abg-00332' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  EXIT DIALOG             
               END IF                              
               #170110-00007#1---e---         
               #end add-point
         
               #將遮罩欄位還原
               CALL abgi100_bgaj_t_mask_restore('restore_mask_o')
         
               UPDATE bgaj_t SET (bgaj001,bgaj002,bgaj003,bgajstus,bgajownid,bgajowndp,bgajcrtid,bgajcrtdp, 
                   bgajcrtdt,bgajmodid,bgajmoddt) = (g_bgaj_m.bgaj001,g_bgaj_m.bgaj002,g_bgaj_d[l_ac].bgaj003, 
                   g_bgaj_d[l_ac].bgajstus,g_bgaj2_d[l_ac].bgajownid,g_bgaj2_d[l_ac].bgajowndp,g_bgaj2_d[l_ac].bgajcrtid, 
                   g_bgaj2_d[l_ac].bgajcrtdp,g_bgaj2_d[l_ac].bgajcrtdt,g_bgaj2_d[l_ac].bgajmodid,g_bgaj2_d[l_ac].bgajmoddt) 
 
                WHERE bgajent = g_enterprise AND bgaj001 = g_bgaj_m.bgaj001 
                 AND bgaj002 = g_bgaj_m.bgaj002 
 
                 AND bgaj003 = g_bgaj_d_t.bgaj003 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgaj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "bgaj_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgaj_m.bgaj001
               LET gs_keys_bak[1] = g_bgaj001_t
               LET gs_keys[2] = g_bgaj_m.bgaj002
               LET gs_keys_bak[2] = g_bgaj002_t
               LET gs_keys[3] = g_bgaj_d[g_detail_idx].bgaj003
               LET gs_keys_bak[3] = g_bgaj_d_t.bgaj003
               CALL abgi100_update_b('bgaj_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_bgaj_m),util.JSON.stringify(g_bgaj_d_t)
                     LET g_log2 = util.JSON.stringify(g_bgaj_m),util.JSON.stringify(g_bgaj_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abgi100_bgaj_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_bgaj_m.bgaj001
               LET ls_keys[ls_keys.getLength()+1] = g_bgaj_m.bgaj002
 
               LET ls_keys[ls_keys.getLength()+1] = g_bgaj_d_t.bgaj003
 
               CALL abgi100_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE abgi100_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bgaj_d[l_ac].* = g_bgaj_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE abgi100_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_bgaj_d.getLength() = 0 THEN
               NEXT FIELD bgaj003
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_bgaj_d[li_reproduce_target].* = g_bgaj_d[li_reproduce].*
               LET g_bgaj2_d[li_reproduce_target].* = g_bgaj2_d[li_reproduce].*
 
               LET g_bgaj_d[li_reproduce_target].bgaj003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bgaj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bgaj_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_bgaj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL abgi100_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL abgi100_idx_chk()
            CALL abgi100_ui_detailshow()
        
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
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            IF l_cmd_t = 'r' THEN
               NEXT FIELD bgaj002
            ELSE
               NEXT FIELD bgaj001
            END IF
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bgaj003
               WHEN "s_detail2"
                  NEXT FIELD bgaj003_2
 
            END CASE
         END IF
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD bgaj001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bgaj003
               WHEN "s_detail2"
                  NEXT FIELD bgaj003_2
 
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
 
{<section id="abgi100.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abgi100_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   LET g_glaald = NULL
   SELECT glaald INTO g_glaald FROM glaa_t,ooef_t
    WHERE glaaent = g_enterprise
      AND glaacomp = ooef017
      AND glaaent = ooefent
      AND ooef001 = g_bgaj_m.bgaj002
      AND glaa014 = 'Y'
      
   INITIALIZE g_bgaa.* TO NULL
   SELECT bgaa002,bgaa003,bgaa012,bgaa009,bgaa008
     INTO g_bgaa.*
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_bgaj_m.bgaj001
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL abgi100_b_fill(g_wc2) #第一階單身填充
      CALL abgi100_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abgi100_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   LET g_bgaj_m.bgaj001_desc = s_desc_get_budget_desc(g_bgaj_m.bgaj001)
   LEt g_bgaj_m.bgaj002_desc =s_desc_get_department_desc(g_bgaj_m.bgaj002)
   CALL s_fin_abg_center_sons_query(g_bgaj_m.bgaj001,'','')
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_bgaj_m.bgaj001,g_bgaj_m.bgaj001_desc,g_bgaj_m.bgaj002,g_bgaj_m.bgaj002_desc
 
   CALL abgi100_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="abgi100.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION abgi100_ref_show()
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
   FOR l_ac = 1 TO g_bgaj_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_bgaj2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="abgi100.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abgi100_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE bgaj_t.bgaj001 
   DEFINE l_oldno     LIKE bgaj_t.bgaj001 
   DEFINE l_newno02     LIKE bgaj_t.bgaj002 
   DEFINE l_oldno02     LIKE bgaj_t.bgaj002 
 
   DEFINE l_master    RECORD LIKE bgaj_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bgaj_t.* #此變數樣板目前無使用
 
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
 
   IF g_bgaj_m.bgaj001 IS NULL
      OR g_bgaj_m.bgaj002 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_bgaj001_t = g_bgaj_m.bgaj001
   LET g_bgaj002_t = g_bgaj_m.bgaj002
 
   
   LET g_bgaj_m.bgaj001 = ""
   LET g_bgaj_m.bgaj002 = ""
 
   LET g_master_insert = FALSE
   CALL abgi100_set_entry('a')
   CALL abgi100_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_bgaj_m.bgaj001 = g_bgaj001_t
   #end add-point
   
   #清空key欄位的desc
      LET g_bgaj_m.bgaj001_desc = ''
   DISPLAY BY NAME g_bgaj_m.bgaj001_desc
   LET g_bgaj_m.bgaj002_desc = ''
   DISPLAY BY NAME g_bgaj_m.bgaj002_desc
 
   
   CALL abgi100_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_bgaj_m.* TO NULL
      INITIALIZE g_bgaj_d TO NULL
      INITIALIZE g_bgaj2_d TO NULL
 
      CALL abgi100_show()
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
   CALL abgi100_set_act_visible()
   CALL abgi100_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bgaj001_t = g_bgaj_m.bgaj001
   LET g_bgaj002_t = g_bgaj_m.bgaj002
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgajent = " ||g_enterprise|| " AND",
                      " bgaj001 = '", g_bgaj_m.bgaj001, "' "
                      ," AND bgaj002 = '", g_bgaj_m.bgaj002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgi100_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL abgi100_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL abgi100_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="abgi100.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abgi100_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bgaj_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abgi100_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bgaj_t
    WHERE bgajent = g_enterprise AND bgaj001 = g_bgaj001_t
    AND bgaj002 = g_bgaj002_t
 
       INTO TEMP abgi100_detail
   
   #將key修正為調整後   
   UPDATE abgi100_detail 
      #更新key欄位
      SET bgaj001 = g_bgaj_m.bgaj001
          , bgaj002 = g_bgaj_m.bgaj002
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , bgajownid = g_user 
       , bgajowndp = g_dept
       , bgajcrtid = g_user
       , bgajcrtdp = g_dept 
       , bgajcrtdt = ld_date
       , bgajmodid = g_user
       , bgajmoddt = ld_date
      #, bgajstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO bgaj_t SELECT * FROM abgi100_detail
   
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
   DROP TABLE abgi100_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bgaj001_t = g_bgaj_m.bgaj001
   LET g_bgaj002_t = g_bgaj_m.bgaj002
 
   
   DROP TABLE abgi100_detail
   
END FUNCTION
 
{</section>}
 
{<section id="abgi100.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abgi100_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_cnt     LIKE type_t.num5  #170110-00007#1
   DEFINE l_bgaa006 LIKE bgaa_t.bgaa006 #170110-00007#1
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_bgaj_m.bgaj001 IS NULL
   OR g_bgaj_m.bgaj002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN abgi100_cl USING g_enterprise,g_bgaj_m.bgaj001,g_bgaj_m.bgaj002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgi100_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgi100_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgi100_master_referesh USING g_bgaj_m.bgaj001,g_bgaj_m.bgaj002 INTO g_bgaj_m.bgaj001,g_bgaj_m.bgaj002 
 
   
   #遮罩相關處理
   LET g_bgaj_m_mask_o.* =  g_bgaj_m.*
   CALL abgi100_bgaj_t_mask()
   LET g_bgaj_m_mask_n.* =  g_bgaj_m.*
   
   CALL abgi100_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgi100_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      #170110-00007#1---s---
      SELECT bgaa006 INTO l_bgaa006 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgaj_m.bgaj001    
      IF l_bgaa006 ='1' THEN #使用預測
         LET l_cnt = 0
         IF l_cnt = 0 THEN # 銷售預算 (abgt340) bgcj049   
            SELECT COUNT(1) INTO l_cnt FROM bgcj_t
             WHERE bgcjent = g_enterprise  AND bgcjstus <> 'X'  
               AND bgcj002 = g_bgaj_m.bgaj001 AND bgcj007 = g_bgaj_m.bgaj002
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         END IF
         IF l_cnt = 0 THEN # 採購預算 (abgt510) bgeg049   
            SELECT COUNT(1) INTO l_cnt FROM bgeg_t
             WHERE bgegent = g_enterprise  AND bgegstus <> 'X' 
               AND bgeg002 = g_bgaj_m.bgaj001 AND bgeg007 = g_bgaj_m.bgaj002
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         END IF
         IF l_cnt = 0 THEN # 費用預算 (abgt610) bgfb009  
            SELECT COUNT(1) INTO l_cnt FROM bgfb_t
             WHERE bgfbent = g_enterprise  AND bgfbstus <> 'X' 
               AND bgfb002 = g_bgaj_m.bgaj001 AND bgfb007 = g_bgaj_m.bgaj002
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         END IF               
         IF l_cnt = 0 THEN # 人工費用預算 (abgt730) bggo039 /bggo040  
            SELECT COUNT(1) INTO l_cnt FROM bggo_t
             WHERE bggoent = g_enterprise AND bggostus <> 'X' 
               AND bggo002 = g_bgaj_m.bgaj001 AND bggo007 = g_bgaj_m.bgaj002
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         END IF                 
         IF l_cnt = 0 THEN #憑證(abgt030)  bgbb002  
            SELECT COUNT(1) INTO l_cnt FROM bgba_t                     
             WHERE bgbaent = g_enterprise  AND bgbastus <>'X' 
               AND bgba001 = g_bgaj_m.bgaj001 AND bgba005 = g_bgaj_m.bgaj002
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         END IF                                
      ELSE
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt FROM bgbi_t 
          WHERE bgbient = g_enterprise  AND bgbistus <> 'X' 
            AND bgbi002 = g_bgaj_m.bgaj001 AND bgbi004 = g_bgaj_m.bgaj002 
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      END IF
      
      IF l_cnt > 0 THEN
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 'abg-00332' 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN            
      END IF                              
      #170110-00007#1---e---
      #end add-point
      
      DELETE FROM bgaj_t WHERE bgajent = g_enterprise AND bgaj001 = g_bgaj_m.bgaj001
                                                               AND bgaj002 = g_bgaj_m.bgaj002
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      #161003-00014#4 ---s---
      DELETE FROM bgal_t WHERE bgalent = g_enterprise
         AND bgal001 = g_bgaj_m.bgaj001 AND bgal002 = g_bgaj_m.bgaj002
      #161003-00014#4 ---e---
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgaj_t:",SQLERRMESSAGE 
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
      #   CLOSE abgi100_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_bgaj_d.clear() 
      CALL g_bgaj2_d.clear()       
 
     
      CALL abgi100_ui_browser_refresh()  
      #CALL abgi100_ui_headershow()  
      #CALL abgi100_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL abgi100_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL abgi100_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE abgi100_cl
 
   #功能已完成,通報訊息中心
   CALL abgi100_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abgi100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgi100_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_bgae006        LIKE bgae_t.bgae006
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_bgaj_d.clear()
   CALL g_bgaj2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT bgaj003,bgajstus,bgaj003,bgajownid,bgajowndp,bgajcrtid,bgajcrtdp,bgajcrtdt, 
       bgajmodid,bgajmoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM bgaj_t", 
          
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=bgajownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=bgajowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=bgajcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=bgajcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=bgajmodid  ",
 
               " WHERE bgajent= ? AND bgaj001=? AND bgaj002=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("bgaj_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF abgi100_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY bgaj_t.bgaj003"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abgi100_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abgi100_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bgaj_m.bgaj001,g_bgaj_m.bgaj002   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bgaj_m.bgaj001,g_bgaj_m.bgaj002 INTO g_bgaj_d[l_ac].bgaj003, 
          g_bgaj_d[l_ac].bgajstus,g_bgaj2_d[l_ac].bgaj003,g_bgaj2_d[l_ac].bgajownid,g_bgaj2_d[l_ac].bgajowndp, 
          g_bgaj2_d[l_ac].bgajcrtid,g_bgaj2_d[l_ac].bgajcrtdp,g_bgaj2_d[l_ac].bgajcrtdt,g_bgaj2_d[l_ac].bgajmodid, 
          g_bgaj2_d[l_ac].bgajmoddt,g_bgaj2_d[l_ac].bgajownid_desc,g_bgaj2_d[l_ac].bgajowndp_desc,g_bgaj2_d[l_ac].bgajcrtid_desc, 
          g_bgaj2_d[l_ac].bgajcrtdp_desc,g_bgaj2_d[l_ac].bgajmodid_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
#         LET l_bgae006 = NULL
#         SELECT bgaa008 INTO l_bgae006 FROM bgaa_t
#          WHERE bgaaent = g_enterprise
#            AND bgaa001 = g_bgaj_m.bgaj001
#         CALL s_abg_bgae001_desc(l_bgae006,g_bgaj_d[l_ac].bgaj003)RETURNING g_bgaj_d[l_ac].bgaj003_desc.
         IF g_bgaa.bgaa012 = 'Y' THEN
            CALL s_desc_get_account_desc(g_glaald,g_bgaj_d[l_ac].bgaj003) RETURNING g_bgaj_d[l_ac].bgaj003_desc
         ELSE
            LET l_bgae006 = NULL
            SELECT bgaa008 INTO l_bgae006 FROM bgaa_t
             WHERE bgaaent = g_enterprise
               AND bgaa001 = g_bgaj_m.bgaj001
            CALL s_abg_bgae001_desc(l_bgae006,g_bgaj_d[l_ac].bgaj003)RETURNING g_bgaj_d[l_ac].bgaj003_desc
         ENd IF
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
 
            CALL g_bgaj_d.deleteElement(g_bgaj_d.getLength())
      CALL g_bgaj2_d.deleteElement(g_bgaj2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bgaj_d.getLength()
      LET g_bgaj_d_mask_o[l_ac].* =  g_bgaj_d[l_ac].*
      CALL abgi100_bgaj_t_mask()
      LET g_bgaj_d_mask_n[l_ac].* =  g_bgaj_d[l_ac].*
   END FOR
   
   LET g_bgaj2_d_mask_o.* =  g_bgaj2_d.*
   FOR l_ac = 1 TO g_bgaj2_d.getLength()
      LET g_bgaj2_d_mask_o[l_ac].* =  g_bgaj2_d[l_ac].*
      CALL abgi100_bgaj_t_mask()
      LET g_bgaj2_d_mask_n[l_ac].* =  g_bgaj2_d[l_ac].*
   END FOR
 
 
   FREE abgi100_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="abgi100.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abgi100_idx_chk()
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
      IF g_detail_idx > g_bgaj_d.getLength() THEN
         LET g_detail_idx = g_bgaj_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_bgaj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgaj_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_bgaj2_d.getLength() THEN
         LET g_detail_idx = g_bgaj2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bgaj2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgaj2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgi100.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgi100_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_bgaj_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="abgi100.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION abgi100_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   DEFINE l_cnt     LIKE type_t.num5  #170110-00007#1
   DEFINE l_bgaa006 LIKE bgaa_t.bgaa006 #170110-00007#1
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   #170110-00007#1---s---
   SELECT bgaa006 INTO l_bgaa006 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgaj_m.bgaj001      
   IF l_bgaa006 ='1' THEN #使用預測
      LET l_cnt = 0
      IF l_cnt = 0 THEN # 銷售預算 (abgt340) bgcj049   
         SELECT COUNT(1) INTO l_cnt FROM bgcj_t
          WHERE bgcjent = g_enterprise AND bgcj049 = g_bgaj_d_t.bgaj003 AND bgcjstus <> 'X' 
            AND bgcj002 = g_bgaj_m.bgaj001 AND bgcj007 = g_bgaj_m.bgaj002
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      END IF
      IF l_cnt = 0 THEN # 採購預算 (abgt510) bgeg049   
         SELECT COUNT(1) INTO l_cnt FROM bgeg_t
          WHERE bgegent = g_enterprise AND bgeg049 = g_bgaj_d_t.bgaj003 AND bgegstus <> 'X'
            AND bgeg002 = g_bgaj_m.bgaj001  AND bgeg007 = g_bgaj_m.bgaj002
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      END IF
      IF l_cnt = 0 THEN # 費用預算 (abgt610) bgfb009  
         SELECT COUNT(1) INTO l_cnt FROM bgfb_t
          WHERE bgfbent = g_enterprise AND bgfb009 = g_bgaj_d_t.bgaj003 AND bgfbstus <> 'X'
            AND bgfb002 = g_bgaj_m.bgaj001 AND bgfb007 = g_bgaj_m.bgaj002
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      END IF               
      IF l_cnt = 0 THEN # 人工費用預算 (abgt730) bggo039 /bggo040  
         SELECT COUNT(1) INTO l_cnt FROM bggo_t
          WHERE bggoent = g_enterprise AND (bggo039 = g_bgaj_d_t.bgaj003 OR bggo040 = g_bgaj_d_t.bgaj003  ) AND bggostus <> 'X'
            AND bggo002 = g_bgaj_m.bgaj001 AND bggo007 = g_bgaj_m.bgaj002
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      END IF                 
      IF l_cnt = 0 THEN #憑證(abgt030)  bgbb002  
         SELECT COUNT(1) INTO l_cnt FROM bgbb_t,bgba_t                     
          WHERE bgbaent = bgbbent AND bgbbent = g_enterprise AND bgbb002 = g_bgaj_d_t.bgaj003 
            AND bgbadocno = bgbbdocno   AND bgbastus <>'X'
            AND bgba001 = g_bgaj_m.bgaj001 AND bgba005 = g_bgaj_m.bgaj002
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      END IF                                
   ELSE
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt FROM bgbi_t 
       WHERE bgbient = g_enterprise AND bgbi005 = g_bgaj_d_t.bgaj003 AND bgbistus <> 'X'
         AND bgbi002 = g_bgaj_m.bgaj001   AND bgbi004 = g_bgaj_m.bgaj002
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   END IF
   IF l_cnt > 0 THEN
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 'abg-00332' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE           
   END IF                              
   #170110-00007#1---e---
   #end add-point
   
   DELETE FROM bgaj_t
    WHERE bgajent = g_enterprise AND bgaj001 = g_bgaj_m.bgaj001 AND
                              bgaj002 = g_bgaj_m.bgaj002 AND
 
          bgaj003 = g_bgaj_d_t.bgaj003
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   #161003-00014#4 ---s---
   DELETE FROM bgal_t WHERE bgalent = g_enterprise
      AND bgal001 = g_bgaj_m.bgaj001 AND bgal002 = g_bgaj_m.bgaj002
      AND bgal003 = g_bgaj_d_t.bgaj003
   #161003-00014#4 ---e---
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bgaj_t:",SQLERRMESSAGE 
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
 
{<section id="abgi100.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abgi100_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="abgi100.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abgi100_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="abgi100.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abgi100_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="abgi100.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION abgi100_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_bgaj_d[l_ac].bgaj003 = g_bgaj_d_t.bgaj003 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgi100.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abgi100_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="abgi100.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abgi100_lock_b(ps_table,ps_page)
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
   #CALL abgi100_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgi100.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abgi100_unlock_b(ps_table,ps_page)
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
 
{<section id="abgi100.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abgi100_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bgaj001,bgaj002",TRUE)
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
 
{<section id="abgi100.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abgi100_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bgaj001,bgaj002",FALSE)
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
 
{<section id="abgi100.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abgi100_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgi100.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abgi100_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="abgi100.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abgi100_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgi100.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abgi100_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgi100.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abgi100_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgi100.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abgi100_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgi100.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abgi100_default_search()
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
      LET ls_wc = ls_wc, " bgaj001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bgaj002 = '", g_argv[02], "' AND "
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
 
{<section id="abgi100.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abgi100_fill_chk(ps_idx)
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
 
{<section id="abgi100.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION abgi100_modify_detail_chk(ps_record)
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
         LET ls_return = "bgaj003"
      WHEN "s_detail2"
         LET ls_return = "bgaj003_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="abgi100.mask_functions" >}
&include "erp/abg/abgi100_mask.4gl"
 
{</section>}
 
{<section id="abgi100.state_change" >}
    
 
{</section>}
 
{<section id="abgi100.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abgi100_set_pk_array()
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
   LET g_pk_array[1].values = g_bgaj_m.bgaj001
   LET g_pk_array[1].column = 'bgaj001'
   LET g_pk_array[2].values = g_bgaj_m.bgaj002
   LET g_pk_array[2].column = 'bgaj002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgi100.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abgi100_msgcentre_notify(lc_state)
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
   CALL abgi100_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bgaj_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgi100.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預算組織檢核
# Memo...........:
# Usage..........: 
# Date & Author..: 150716 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi100_bgaj002_chk(p_ooef001)
   DEFINE p_ooef001   LIKE ooef_t.ooef001
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
      AND ooef001 = p_ooef001
      
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
# Descriptions...: 單身新增的時候自動產生到abgi110
# Memo...........:
# Usage..........: CALL abgi100_insert_bgal(p_bgaj003)
# Date & Author..: 2016/10/12 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi100_ins_bgal(p_bgaj003)
DEFINE l_bgae RECORD  #預算專案檔
       bgaeent LIKE bgae_t.bgaeent, #企業編號
       bgae006 LIKE bgae_t.bgae006, #預算專案參照表號
       bgae001 LIKE bgae_t.bgae001, #預算專案編碼
       bgae007 LIKE bgae_t.bgae007, #類別
       bgae002 LIKE bgae_t.bgae002, #借貸方向
       bgae003 LIKE bgae_t.bgae003, #資產損益別
       bgae004 LIKE bgae_t.bgae004, #計量方式
       bgae005 LIKE bgae_t.bgae005, #所屬預算大類
       bgae008 LIKE bgae_t.bgae008, #費用分類
       bgae009 LIKE bgae_t.bgae009, #起始預算專案
       bgae010 LIKE bgae_t.bgae010, #截止預算專案
       bgae011 LIKE bgae_t.bgae011, #計量方式
       bgae012 LIKE bgae_t.bgae012, #金額來源
       bgae013 LIKE bgae_t.bgae013, #計算公式
       bgae014 LIKE bgae_t.bgae014, #數據格式
       bgae015 LIKE bgae_t.bgae015, #部門
       bgae016 LIKE bgae_t.bgae016, #利潤中心
       bgae017 LIKE bgae_t.bgae017, #區域
       bgae018 LIKE bgae_t.bgae018, #交易客商
       bgae019 LIKE bgae_t.bgae019, #收款客商
       bgae020 LIKE bgae_t.bgae020, #客群
       bgae021 LIKE bgae_t.bgae021, #產品類別
       bgae022 LIKE bgae_t.bgae022, #人員
       bgae023 LIKE bgae_t.bgae023, #專案編號
       bgae024 LIKE bgae_t.bgae024, #WBS
       bgae025 LIKE bgae_t.bgae025, #經營方式
       bgae026 LIKE bgae_t.bgae026, #自由核算項一
       bgae027 LIKE bgae_t.bgae027, #自由核算項二
       bgae028 LIKE bgae_t.bgae028, #自由核算項三
       bgae029 LIKE bgae_t.bgae029, #自由核算項四
       bgae030 LIKE bgae_t.bgae030, #自由核算項五
       bgae031 LIKE bgae_t.bgae031, #自由核算項六
       bgae032 LIKE bgae_t.bgae032, #自由核算項七
       bgae033 LIKE bgae_t.bgae033, #自由核算項八
       bgae034 LIKE bgae_t.bgae034, #自由核算項九
       bgae035 LIKE bgae_t.bgae035, #自由核算項十
       bgae036 LIKE bgae_t.bgae036, #現金類專案
       bgae037 LIKE bgae_t.bgae037, #期別
       bgaeownid LIKE bgae_t.bgaeownid, #資料所有者
       bgaeowndp LIKE bgae_t.bgaeowndp, #資料所屬部門
       bgaecrtid LIKE bgae_t.bgaecrtid, #資料建立者
       bgaecrtdp LIKE bgae_t.bgaecrtdp, #資料建立部門
       bgaecrtdt LIKE bgae_t.bgaecrtdt, #資料創建日
       bgaemodid LIKE bgae_t.bgaemodid, #資料修改者
       bgaemoddt LIKE bgae_t.bgaemoddt, #最近修改日
       bgaestus LIKE bgae_t.bgaestus, #狀態碼
       bgae038 LIKE bgae_t.bgae038, #計算公式說明
       bgae039 LIKE bgae_t.bgae039, #關鍵指標
       bgae040 LIKE bgae_t.bgae040, #渠道
       bgae041 LIKE bgae_t.bgae041 #品牌
END RECORD
DEFINE l_bgal RECORD  #預算專案維護檔
       bgalent LIKE bgal_t.bgalent, #企業編號
       bgalownid LIKE bgal_t.bgalownid, #資料所有者
       bgalowndp LIKE bgal_t.bgalowndp, #資料所屬部門
       bgalcrtid LIKE bgal_t.bgalcrtid, #資料建立者
       bgalcrtdp LIKE bgal_t.bgalcrtdp, #資料建立部門
       bgalcrtdt LIKE bgal_t.bgalcrtdt, #資料創建日
       bgalmodid LIKE bgal_t.bgalmodid, #資料修改者
       bgalmoddt LIKE bgal_t.bgalmoddt, #最近修改日
       bgalstus LIKE bgal_t.bgalstus, #狀態碼
       bgal001 LIKE bgal_t.bgal001, #預算編號
       bgal002 LIKE bgal_t.bgal002, #預算組織
       bgal003 LIKE bgal_t.bgal003, #可用預算專案
       bgal004 LIKE bgal_t.bgal004, #預算期別
       bgal005 LIKE bgal_t.bgal005, #部門
       bgal006 LIKE bgal_t.bgal006, #利潤/成本中心
       bgal007 LIKE bgal_t.bgal007, #區域
       bgal008 LIKE bgal_t.bgal008, #交易客商
       bgal009 LIKE bgal_t.bgal009, #收款客商
       bgal010 LIKE bgal_t.bgal010, #客群
       bgal011 LIKE bgal_t.bgal011, #產品類別
       bgal012 LIKE bgal_t.bgal012, #人員
       bgal013 LIKE bgal_t.bgal013, #專案編號
       bgal014 LIKE bgal_t.bgal014, #WBS
       bgal015 LIKE bgal_t.bgal015, #自由核算項一
       bgal016 LIKE bgal_t.bgal016, #自由核算項二
       bgal017 LIKE bgal_t.bgal017, #自由核算項三
       bgal018 LIKE bgal_t.bgal018, #自由核算項四
       bgal019 LIKE bgal_t.bgal019, #自由核算項五
       bgal020 LIKE bgal_t.bgal020, #自由核算項六
       bgal021 LIKE bgal_t.bgal021, #自由核算項七
       bgal022 LIKE bgal_t.bgal022, #自由核算項八
       bgal023 LIKE bgal_t.bgal023, #自由核算項九
       bgal024 LIKE bgal_t.bgal024, #自由核算項十
       bgal025 LIKE bgal_t.bgal025, #經營方式
       bgal026 LIKE bgal_t.bgal026, #渠道
       bgal027 LIKE bgal_t.bgal027 #品牌
END RECORD

DEFINE p_bgaj003 LIKE bgaj_t.bgaj003 #預算細項
DEFINE l_bgaa008 LIKE bgaa_t.bgaa008 #預算細項參照表
DEFINE r_success LIKE type_t.num5
DEFINE r_errno   LIKE gzze_t.gzze001
DEFINE l_count   LIKE type_t.num5


   LET r_success =TRUE LET r_errno = '' LET l_count = 0
   SELECT COUNT(1) INTO l_count FROM bgal_t 
    WHERE bgalent = g_enterprise AND bgal001 = g_bgaj_t.bgaj001 AND bgal002 = g_bgaj_t.bgaj002 AND bgal003 = g_bgaj_t.bgaj003
   IF l_count > 0 THEN RETURN r_success,r_errno END IF
   
   LET l_bgaa008 = '' INITIALIZE l_bgae.* TO NULL INITIALIZE l_bgal.* TO NULL
   SELECT bgaa008 INTO l_bgaa008 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgaj_m.bgaj001
   
   SELECT bgaeent,bgae006,bgae001,bgae007,bgae002,bgae003,bgae004,bgae005,bgae008,bgae009,bgae010,
          bgae011,bgae012,bgae013,bgae014,bgae015,bgae016,bgae017,bgae018,bgae019,bgae020,bgae021,
          bgae022,bgae023,bgae024,bgae025,bgae026,bgae027,bgae028,bgae029,bgae030,bgae031,bgae032,
          bgae033,bgae034,bgae035,bgae036,bgae037,bgaeownid,bgaeowndp,bgaecrtid,bgaecrtdp,bgaecrtdt,
          bgaemodid,bgaemoddt,bgaestus,bgae038,bgae039,bgae040,bgae041
    INTO l_bgae.*  FROM bgae_t
   WHERE bgaeent = g_enterprise AND bgae006 = l_bgaa008 AND bgae001 = p_bgaj003 
   
      LET l_bgal.bgalent    = g_enterprise
      LET l_bgal.bgalownid  = g_user
      LET l_bgal.bgalowndp  = g_dept
      LET l_bgal.bgalcrtid  = g_user
      LET l_bgal.bgalcrtdp  = g_dept
      LET l_bgal.bgalcrtdt  = cl_get_current()
      LET l_bgal.bgalmodid  = g_user
      LET l_bgal.bgalmoddt  = cl_get_current()
      LET l_bgal.bgalstus   = 'Y'
      LET l_bgal.bgal001    = g_bgaj_m.bgaj001
      LET l_bgal.bgal002    = g_bgaj_m.bgaj002
      LET l_bgal.bgal003    = p_bgaj003
      LET l_bgal.bgal004    = l_bgae.bgae037
      LET l_bgal.bgal005    = l_bgae.bgae015
      LET l_bgal.bgal006    = l_bgae.bgae016
      LET l_bgal.bgal007    = l_bgae.bgae017
      LET l_bgal.bgal008    = l_bgae.bgae018
      LET l_bgal.bgal009    = l_bgae.bgae019
      LET l_bgal.bgal010    = l_bgae.bgae020
      LET l_bgal.bgal011    = l_bgae.bgae021  #產品類別
      LET l_bgal.bgal012    = l_bgae.bgae022
      LET l_bgal.bgal013    = l_bgae.bgae023
      LET l_bgal.bgal014    = l_bgae.bgae024
      LET l_bgal.bgal015    = l_bgae.bgae026　 #自由核算項
      LET l_bgal.bgal016    = l_bgae.bgae027
      LET l_bgal.bgal017    = l_bgae.bgae028
      LET l_bgal.bgal018    = l_bgae.bgae029
      LET l_bgal.bgal019    = l_bgae.bgae030
      LET l_bgal.bgal020    = l_bgae.bgae031
      LET l_bgal.bgal021    = l_bgae.bgae032
      LET l_bgal.bgal022    = l_bgae.bgae033
      LET l_bgal.bgal023    = l_bgae.bgae034
      LET l_bgal.bgal024    = l_bgae.bgae035
      LET l_bgal.bgal025    = l_bgae.bgae025  #經營方式
      LET l_bgal.bgal026    = l_bgae.bgae040  #渠道
      #LET l_bgal.bgal027    = l_bgae.bgae037　#品牌 #161105-00004#3
      LET l_bgal.bgal027    = l_bgae.bgae041 　#品牌 #161105-00004#3

   INSERT INTO bgal_t (bgalent,bgalownid,bgalowndp,bgalcrtid,bgalcrtdp,
                       bgalcrtdt,bgalmodid,bgalmoddt,bgalstus,
                       bgal001,bgal002,bgal003,bgal004,bgal005,
                       bgal006,bgal007,bgal008,bgal009,bgal010,
                       bgal011,bgal012,bgal013,bgal014,bgal015,
                       bgal016,bgal017,bgal018,bgal019,bgal020,
                       bgal021,bgal022,bgal023,bgal024,bgal025,
                       bgal026,bgal027)   
      VALUES( l_bgal.bgalent,l_bgal.bgalownid,l_bgal.bgalowndp,l_bgal.bgalcrtid,l_bgal.bgalcrtdp,
              l_bgal.bgalcrtdt,l_bgal.bgalmodid,l_bgal.bgalmoddt,l_bgal.bgalstus, 
              l_bgal.bgal001,l_bgal.bgal002,l_bgal.bgal003,l_bgal.bgal004,l_bgal.bgal005,  
              l_bgal.bgal006,l_bgal.bgal007,l_bgal.bgal008,l_bgal.bgal009,l_bgal.bgal010,  
              l_bgal.bgal011,l_bgal.bgal012,l_bgal.bgal013,l_bgal.bgal014,l_bgal.bgal015,
              l_bgal.bgal016,l_bgal.bgal017,l_bgal.bgal018,l_bgal.bgal019,l_bgal.bgal020,  
              l_bgal.bgal021,l_bgal.bgal022,l_bgal.bgal023,l_bgal.bgal024,l_bgal.bgal025,  
              l_bgal.bgal026,l_bgal.bgal027  )
   IF SQLCA.SQLcode  THEN
      LET r_errno   = SQLCA.sqlcode 
      LET r_success = FALSE 
   END IF
   
   RETURN r_success,r_errno                              
END FUNCTION

 
{</section>}
 
