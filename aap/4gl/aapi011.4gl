#該程式未解開Section, 採用最新樣板產出!
{<section id="aapi011.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2016-05-18 10:37:48), PR版次:0014(2016-11-25 14:26:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000214
#+ Filename...: aapi011
#+ Description: 應付帳款類別依帳套設定科目作業
#+ Creator....: 05016(2014-10-02 14:51:04)
#+ Modifier...: 03538 -SD/PR- 04152
 
{</section>}
 
{<section id="aapi011.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#150916-00015#1  2015/12/07 By Xiaozg   1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#160318-00005#2  2016/03/18 By Jessy    修正azzi920重複定義之錯誤訊息
#160321-00016#19 2016/03/30 By Jessy    將重複內容的錯誤訊息置換為公用錯誤訊息
#160726-00020#7  2016/07/29 By 08171    新舊值處理
#160812-00027#5  2016/08/15 By 06821    全面盤點應付程式帳套權限控管
#161014-00053#1  2016/10/17 By 08171    帳套權限控管調整
#161028-00046#1  2016/11/04 By dorishsu 修正aapi011/axir011共用glab_t,二邊資料互相誤刪的問題
#161108-00017#1  2016/11/08 By Reanna   程式中INSERT INTO 有星號作整批調整
#161125-00021#1  2016/11/25 By Reanna   增加自定義欄位
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
PRIVATE type type_g_glab_m        RECORD
       glab002 LIKE glab_t.glab002, 
   glab002_desc LIKE type_t.chr80, 
   glabld LIKE glab_t.glabld, 
   glabld_desc LIKE type_t.chr80, 
   glaa014 LIKE type_t.chr1, 
   glaa008 LIKE type_t.chr1, 
   glab001 LIKE glab_t.glab001, 
   glaacomp LIKE type_t.chr10, 
   glaacomp_desc LIKE type_t.chr80, 
   glaa004 LIKE type_t.chr5, 
   glaa004_desc LIKE type_t.chr80, 
   glab010 LIKE glab_t.glab010
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_glab_d        RECORD
       glab003 LIKE glab_t.glab003, 
   glab003_desc LIKE type_t.chr500, 
   glab005 LIKE glab_t.glab005, 
   glab005_desc LIKE type_t.chr500, 
   glab011 LIKE glab_t.glab011, 
   gzcb002 LIKE type_t.chr500, 
   gzcb014 LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_glab2_d        RECORD
       glab003_2 LIKE glab_t.glab003,
   glab003_2_desc LIKE type_t.chr80,    
   glab005_2 LIKE glab_t.glab005,
   glab005_2_desc LIKE type_t.chr80,
   glab011_2 LIKE glab_t.glab011,
   gzcb002_2 LIKE type_t.chr500, 
   gzcb014_2 LIKE type_t.chr500
       END RECORD
DEFINE g_rec_b2           LIKE type_t.num5          
DEFINE g_glab2_d          DYNAMIC ARRAY OF type_g_glab2_d
DEFINE g_glab2_d_t        type_g_glab2_d  
DEFINE l_ac2              LIKE type_t.num5
DEFINE g_glab010_comm     LIKE type_t.chr500 #glab010說明
DEFINE g_wc_cs_ld         STRING             #160812-00027#5 add 查詢時帳套權限範圍 #161014-00053#1 mark
DEFINE g_wc_glabld        STRING             #160812-00027#5 add 新增時帳套權限範圍 #161014-00053#1 mark
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_glab_m          type_g_glab_m
DEFINE g_glab_m_t        type_g_glab_m
DEFINE g_glab_m_o        type_g_glab_m
DEFINE g_glab_m_mask_o   type_g_glab_m #轉換遮罩前資料
DEFINE g_glab_m_mask_n   type_g_glab_m #轉換遮罩後資料
 
   DEFINE g_glab002_t LIKE glab_t.glab002
DEFINE g_glabld_t LIKE glab_t.glabld
DEFINE g_glab001_t LIKE glab_t.glab001
 
 
DEFINE g_glab_d          DYNAMIC ARRAY OF type_g_glab_d
DEFINE g_glab_d_t        type_g_glab_d
DEFINE g_glab_d_o        type_g_glab_d
DEFINE g_glab_d_mask_o   DYNAMIC ARRAY OF type_g_glab_d #轉換遮罩前資料
DEFINE g_glab_d_mask_n   DYNAMIC ARRAY OF type_g_glab_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_glab001 LIKE glab_t.glab001,
      b_glab002 LIKE glab_t.glab002,
   b_glab002_desc LIKE type_t.chr80,
      b_glabld LIKE glab_t.glabld,
   b_glabld_desc LIKE type_t.chr80
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
 
{<section id="aapi011.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT glab002,'',glabld,'','','',glab001,'','','','',glab010", 
                      " FROM glab_t",
                      " WHERE glabent= ? AND glabld=? AND glab001=? AND glab002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapi011_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.glab002,t0.glabld,t0.glab001,t0.glab010",
               " FROM glab_t t0",
               
               " WHERE t0.glabent = " ||g_enterprise|| " AND t0.glabld = ? AND t0.glab001 = ? AND t0.glab002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
 
   #end add-point
   PREPARE aapi011_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapi011 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapi011_init()   
 
      #進入選單 Menu (="N")
      CALL aapi011_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapi011
      
   END IF 
   
   CLOSE aapi011_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapi011.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapi011_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
 
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('glab011','8315') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
  
   CALL cl_set_combo_scc('glab011_2','8315')
   CALL cl_set_combo_scc('glab003','8504')          
   CALL cl_set_combo_scc('glab003_2','8504') 
   LET g_glab_m.glab001 = "13"
   CALL cl_getmsg("ais-00168",g_dlang) RETURNING g_glab010_comm
   CALL s_hint_show_set_comments('glab010',g_glab010_comm)
   #160812-00027#5 --s add
   #帳套權限相關預設範圍
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld     
   CALL s_fin_get_wc_str(g_wc_cs_ld) RETURNING g_wc_cs_ld  
   CALL s_fin_account_center_sons_query('3',g_site,g_today,'1')   
   CALL s_fin_account_center_ld_str() RETURNING g_wc_glabld
   CALL s_fin_get_wc_str(g_wc_glabld) RETURNING g_wc_glabld  
   #160812-00027#5 --e add
   #end add-point
   
   CALL aapi011_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aapi011.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aapi011_ui_dialog()
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
         INITIALIZE g_glab_m.* TO NULL
         CALL g_glab_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapi011_init()
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
               CALL aapi011_idx_chk()
               CALL aapi011_fetch('') # reload data
               LET g_detail_idx = 1
               CALL aapi011_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_glab_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL aapi011_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aapi011_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               CALL s_hint_show_set_comments('glab010',g_glab010_comm)
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
         DISPLAY ARRAY g_glab2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2)
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac2 = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL aapi011_ui_detailshow()
               CALL s_hint_show_set_comments('glab010',g_glab010_comm)
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               DISPLAY g_rec_b2 TO FORMONLY.cnt
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL aapi011_browser_fill("")
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
               CALL aapi011_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aapi011_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
   
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aapi011_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aapi011_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapi011_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aapi011_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapi011_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aapi011_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapi011_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aapi011_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapi011_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aapi011_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapi011_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_glab_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[2] = base.typeInfo.CREATE(g_glab2_d)
                  LET g_export_id[2]   = "s_detail2"
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
               NEXT FIELD glab003
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
               CALL aapi011_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aapi011_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL aapi011_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aapi011_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aapi011_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aapi011_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapi011_insert()
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
               CALL aapi011_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapi011_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aapi011_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapi011_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapi011_set_pk_array()
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
 
{<section id="aapi011.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION aapi011_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
 
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapi011.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aapi011_browser_fill(ps_page_action)
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
   DEFINE l_ld_str          STRING #161014-00053#1 add
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   #161014-00053#1--s add
   CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str  
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","glabld") 
   LET l_wc = l_wc," AND ",l_ld_str
   #161014-00053#1--e add
   #end add-point    
 
   LET l_searchcol = "glabld,glab001,glab002"
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
      LET l_sub_sql = " SELECT DISTINCT glabld ",
                      ", glab001 ",
                      ", glab002 ",
 
                      " FROM glab_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE glabent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("glab_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT glabld ",
                      ", glab001 ",
                      ", glab002 ",
 
                      " FROM glab_t ",
                      " ",
                      " ", 
 
 
                      " WHERE glabent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("glab_t")
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
      INITIALIZE g_glab_m.* TO NULL
      CALL g_glab_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.glab001,t0.glab002,t0.glabld Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.glab001,t0.glab002,t0.glabld,t1.faacl003 ,t2.glaal002",
                " FROM glab_t t0",
                #" ",
                " ",
 
 
 
                               " LEFT JOIN faacl_t t1 ON t1.faaclent="||g_enterprise||" AND t1.faacl001=t0.glab002 AND faac002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.glabld AND t2.glaal001='"||g_dlang||"' ",
 
                " WHERE t0.glabent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("glab_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   LET g_sql =  "  SELECT DISTINCT glab001,glab002,glabld,oocql004,glaal002 ",
                "     FROM glab_t ",
                "     LEFT JOIN oocql_t ON glabent = oocqlent AND oocql001 = '3211' AND oocql002 = glab002 AND oocql003 = '",g_lang,"' ",
                "     LEFT JOIN glaal_t ON glaalent = glabent AND glaalld = glabld  AND glaal001 = '",g_lang,"' ",
                "    WHERE glab001 = '13' AND glabent = '",g_enterprise,"'                                      ", 
                "      AND glab002 IN (SELECT oocq002 FROM oocq_t WHERE oocqent = '",g_enterprise,"'"," AND oocq001 = '3211' AND oocqstus = 'Y')", 
                "      AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("glab_t") 
                         
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"glab_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_glab001,g_browser[g_cnt].b_glab002,g_browser[g_cnt].b_glabld, 
          g_browser[g_cnt].b_glab002_desc,g_browser[g_cnt].b_glabld_desc 
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
         CALL aapi011_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_glabld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_glab_m.* TO NULL
      CALL g_glab_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL aapi011_fetch('')
   
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
 
{<section id="aapi011.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aapi011_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_glab_m.glabld = g_browser[g_current_idx].b_glabld   
   LET g_glab_m.glab001 = g_browser[g_current_idx].b_glab001   
   LET g_glab_m.glab002 = g_browser[g_current_idx].b_glab002   
 
   EXECUTE aapi011_master_referesh USING g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002 INTO g_glab_m.glab002, 
       g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab010
   CALL aapi011_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aapi011.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aapi011_ui_detailshow()
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
 
{<section id="aapi011.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aapi011_ui_browser_refresh()
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
      IF g_browser[l_i].b_glabld = g_glab_m.glabld 
         AND g_browser[l_i].b_glab001 = g_glab_m.glab001 
         AND g_browser[l_i].b_glab002 = g_glab_m.glab002 
 
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
 
{<section id="aapi011.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapi011_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_ld_str          STRING #161014-00053#1 add
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_glab_m.* TO NULL
   CALL g_glab_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON glab002,glab002_desc,glabld,glabld_desc,glab001,glaacomp_desc,glaa004_desc, 
          glab010
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            CALL s_hint_show_set_comments('glab010',g_glab010_comm)
            #end add-point 
            
                 #Ctrlp:construct.c.glab002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab002
            #add-point:ON ACTION controlp INFIELD glab002 name="construct.c.glab002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3211"
            CALL q_oocq002()                           
            DISPLAY g_qryparam.return1 TO glab002  
            NEXT FIELD glab002                     
   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab002
            #add-point:BEFORE FIELD glab002 name="construct.b.glab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab002
            
            #add-point:AFTER FIELD glab002 name="construct.a.glab002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab002_desc
            #add-point:BEFORE FIELD glab002_desc name="construct.b.glab002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab002_desc
            
            #add-point:AFTER FIELD glab002_desc name="construct.a.glab002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glab002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab002_desc
            #add-point:ON ACTION controlp INFIELD glab002_desc name="construct.c.glab002_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glabld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glabld
            #add-point:ON ACTION controlp INFIELD glabld name="construct.c.glabld"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str  #161014-00053#1 add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160812-00027#5 --s add
			   LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #LET g_qryparam.where = " glaald IN ",g_wc_cs_ld   #161014-00053#1 mark
            LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')"   #161014-00053#1 add
            CALL q_authorised_ld() 
            #160812-00027#5 --e add
            #CALL q_glaald_03()                   #呼叫開窗       #160812-00027#5 mark
            DISPLAY g_qryparam.return1 TO glabld  #顯示到畫面上
            NEXT FIELD glabld                     #返回原欄位
   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glabld
            #add-point:BEFORE FIELD glabld name="construct.b.glabld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glabld
            
            #add-point:AFTER FIELD glabld name="construct.a.glabld"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glabld_desc
            #add-point:BEFORE FIELD glabld_desc name="construct.b.glabld_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glabld_desc
            
            #add-point:AFTER FIELD glabld_desc name="construct.a.glabld_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glabld_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glabld_desc
            #add-point:ON ACTION controlp INFIELD glabld_desc name="construct.c.glabld_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab001
            #add-point:BEFORE FIELD glab001 name="construct.b.glab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab001
            
            #add-point:AFTER FIELD glab001 name="construct.a.glab001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glab001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab001
            #add-point:ON ACTION controlp INFIELD glab001 name="construct.c.glab001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="construct.b.glaacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="construct.a.glaacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="construct.c.glaacomp"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp_desc
            #add-point:BEFORE FIELD glaacomp_desc name="construct.b.glaacomp_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp_desc
            
            #add-point:AFTER FIELD glaacomp_desc name="construct.a.glaacomp_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaacomp_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp_desc
            #add-point:ON ACTION controlp INFIELD glaacomp_desc name="construct.c.glaacomp_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa004
            #add-point:BEFORE FIELD glaa004 name="construct.b.glaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa004
            
            #add-point:AFTER FIELD glaa004 name="construct.a.glaa004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa004
            #add-point:ON ACTION controlp INFIELD glaa004 name="construct.c.glaa004"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa004_desc
            #add-point:BEFORE FIELD glaa004_desc name="construct.b.glaa004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa004_desc
            
            #add-point:AFTER FIELD glaa004_desc name="construct.a.glaa004_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa004_desc
            #add-point:ON ACTION controlp INFIELD glaa004_desc name="construct.c.glaa004_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab010
            #add-point:BEFORE FIELD glab010 name="construct.b.glab010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab010
            
            #add-point:AFTER FIELD glab010 name="construct.a.glab010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glab010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab010
            #add-point:ON ACTION controlp INFIELD glab010 name="construct.c.glab010"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON glab003,glab005,glab005_desc,glab011,gzcb002,gzcb014
           FROM s_detail1[1].glab003,s_detail1[1].glab005,s_detail1[1].glab005_desc,s_detail1[1].glab011, 
               s_detail1[1].gzcb002,s_detail1[1].gzcb014
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #Ctrlp:construct.c.page1.glab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab003
            #add-point:ON ACTION controlp INFIELD glab003 name="construct.c.page1.glab003"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab003
            #add-point:BEFORE FIELD glab003 name="construct.b.page1.glab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab003
            
            #add-point:AFTER FIELD glab003 name="construct.a.page1.glab003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005
            #add-point:ON ACTION controlp INFIELD glab005 name="construct.c.page1.glab005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glac002()                           
            DISPLAY g_qryparam.return1 TO glab005  
            NEXT FIELD glab005                     
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005
            #add-point:BEFORE FIELD glab005 name="construct.b.page1.glab005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005
            
            #add-point:AFTER FIELD glab005 name="construct.a.page1.glab005"
          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005_desc
            #add-point:BEFORE FIELD glab005_desc name="construct.b.page1.glab005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005_desc
            
            #add-point:AFTER FIELD glab005_desc name="construct.a.page1.glab005_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glab005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005_desc
            #add-point:ON ACTION controlp INFIELD glab005_desc name="construct.c.page1.glab005_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab011
            #add-point:BEFORE FIELD glab011 name="construct.b.page1.glab011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab011
            
            #add-point:AFTER FIELD glab011 name="construct.a.page1.glab011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glab011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab011
            #add-point:ON ACTION controlp INFIELD glab011 name="construct.c.page1.glab011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzcb002
            #add-point:BEFORE FIELD gzcb002 name="construct.b.page1.gzcb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzcb002
            
            #add-point:AFTER FIELD gzcb002 name="construct.a.page1.gzcb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzcb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzcb002
            #add-point:ON ACTION controlp INFIELD gzcb002 name="construct.c.page1.gzcb002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzcb014
            #add-point:BEFORE FIELD gzcb014 name="construct.b.page1.gzcb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzcb014
            
            #add-point:AFTER FIELD gzcb014 name="construct.a.page1.gzcb014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzcb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzcb014
            #add-point:ON ACTION controlp INFIELD gzcb014 name="construct.c.page1.gzcb014"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         CALL s_hint_show_set_comments('glab010',g_glab010_comm)
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
   CALL s_hint_show_set_comments('glab010',g_glab010_comm)
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
 
{<section id="aapi011.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aapi011_filter()
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
      CONSTRUCT g_wc_filter ON glab001,glab002,glabld
                          FROM s_browse[1].b_glab001,s_browse[1].b_glab002,s_browse[1].b_glabld
 
         BEFORE CONSTRUCT
               DISPLAY aapi011_filter_parser('glab001') TO s_browse[1].b_glab001
            DISPLAY aapi011_filter_parser('glab002') TO s_browse[1].b_glab002
            DISPLAY aapi011_filter_parser('glabld') TO s_browse[1].b_glabld
      
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
 
      CALL aapi011_filter_show('glab001')
   CALL aapi011_filter_show('glab002')
   CALL aapi011_filter_show('glabld')
 
END FUNCTION
 
{</section>}
 
{<section id="aapi011.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aapi011_filter_parser(ps_field)
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
 
{<section id="aapi011.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aapi011_filter_show(ps_field)
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
   LET ls_condition = aapi011_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapi011.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aapi011_query()
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
   CALL g_glab_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aapi011_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aapi011_browser_fill(g_wc)
      CALL aapi011_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL aapi011_browser_fill("F")
   
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
      CALL aapi011_fetch("F") 
   END IF
   
   CALL aapi011_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aapi011.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aapi011_fetch(p_flag)
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
   
   LET g_glab_m.glabld = g_browser[g_current_idx].b_glabld
   LET g_glab_m.glab001 = g_browser[g_current_idx].b_glab001
   LET g_glab_m.glab002 = g_browser[g_current_idx].b_glab002
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aapi011_master_referesh USING g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002 INTO g_glab_m.glab002, 
       g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab010
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_glab_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_glab_m_mask_o.* =  g_glab_m.*
   CALL aapi011_glab_t_mask()
   LET g_glab_m_mask_n.* =  g_glab_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aapi011_set_act_visible()
   CALL aapi011_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_glab_m_t.* = g_glab_m.*
   LET g_glab_m_o.* = g_glab_m.*
   
   #重新顯示   
   CALL aapi011_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aapi011.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapi011_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_glab_d.clear()
 
 
   INITIALIZE g_glab_m.* TO NULL             #DEFAULT 設定
   LET g_glabld_t = NULL
   LET g_glab001_t = NULL
   LET g_glab002_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_glab_m.glab002 = "30"
      LET g_glab_m.glaa008 = "N"
      LET g_glab_m.glab001 = "90"
 
     
      #add-point:單頭預設值 name="insert.default"
      LET g_glab_m.glaa014 = "N"
      LET g_glab_m.glab001 = "13"
      LET g_glab_m.glab002 = ""
      #end add-point 
 
      CALL aapi011_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_glab_m.* TO NULL
         INITIALIZE g_glab_d TO NULL
 
         CALL aapi011_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_glab_m.* = g_glab_m_t.*
         CALL aapi011_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_glab_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aapi011_set_act_visible()
   CALL aapi011_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_glabld_t = g_glab_m.glabld
   LET g_glab001_t = g_glab_m.glab001
   LET g_glab002_t = g_glab_m.glab002
 
   
   #組合新增資料的條件
   LET g_add_browse = " glabent = " ||g_enterprise|| " AND",
                      " glabld = '", g_glab_m.glabld, "' "
                      ," AND glab001 = '", g_glab_m.glab001, "' "
                      ," AND glab002 = '", g_glab_m.glab002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapi011_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL aapi011_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aapi011_master_referesh USING g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002 INTO g_glab_m.glab002, 
       g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab010
   
   #遮罩相關處理
   LET g_glab_m_mask_o.* =  g_glab_m.*
   CALL aapi011_glab_t_mask()
   LET g_glab_m_mask_n.* =  g_glab_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_glab_m.glab002,g_glab_m.glab002_desc,g_glab_m.glabld,g_glab_m.glabld_desc,g_glab_m.glaa014, 
       g_glab_m.glaa008,g_glab_m.glab001,g_glab_m.glaacomp,g_glab_m.glaacomp_desc,g_glab_m.glaa004,g_glab_m.glaa004_desc, 
       g_glab_m.glab010
   
   #功能已完成,通報訊息中心
   CALL aapi011_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aapi011.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapi011_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_glab_m.glabld IS NULL
   OR g_glab_m.glab001 IS NULL
   OR g_glab_m.glab002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_glabld_t = g_glab_m.glabld
   LET g_glab001_t = g_glab_m.glab001
   LET g_glab002_t = g_glab_m.glab002
 
   CALL s_transaction_begin()
   
   OPEN aapi011_cl USING g_enterprise,g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapi011_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aapi011_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapi011_master_referesh USING g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002 INTO g_glab_m.glab002, 
       g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab010
   
   #遮罩相關處理
   LET g_glab_m_mask_o.* =  g_glab_m.*
   CALL aapi011_glab_t_mask()
   LET g_glab_m_mask_n.* =  g_glab_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL aapi011_show()
   WHILE TRUE
      LET g_glabld_t = g_glab_m.glabld
      LET g_glab001_t = g_glab_m.glab001
      LET g_glab002_t = g_glab_m.glab002
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL aapi011_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_glab_m.* = g_glab_m_t.*
         CALL aapi011_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_glab_m.glabld != g_glabld_t 
      OR g_glab_m.glab001 != g_glab001_t 
      OR g_glab_m.glab002 != g_glab002_t 
 
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
   CALL aapi011_set_act_visible()
   CALL aapi011_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " glabent = " ||g_enterprise|| " AND",
                      " glabld = '", g_glab_m.glabld, "' "
                      ," AND glab001 = '", g_glab_m.glab001, "' "
                      ," AND glab002 = '", g_glab_m.glab002, "' "
 
   #填到對應位置
   CALL aapi011_browser_fill("")
 
   CALL aapi011_idx_chk()
 
   CLOSE aapi011_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapi011_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="aapi011.input" >}
#+ 資料輸入
PRIVATE FUNCTION aapi011_input(p_cmd)
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
   #ADD BY XZG20151203 B
   DEFINE l_sql                  STRING
   DEFINE l_glaa004              LIKE  glaa_t.glaa004 
   DEFINE l_ld_str               STRING #161014-00053#1 add
   #ADD BY XZG20151203 e

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
   DISPLAY BY NAME g_glab_m.glab002,g_glab_m.glab002_desc,g_glab_m.glabld,g_glab_m.glabld_desc,g_glab_m.glaa014, 
       g_glab_m.glaa008,g_glab_m.glab001,g_glab_m.glaacomp,g_glab_m.glaacomp_desc,g_glab_m.glaa004,g_glab_m.glaa004_desc, 
       g_glab_m.glab010
   
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
   LET g_forupd_sql = "SELECT glab003,glab005,glab011 FROM glab_t WHERE glabent=? AND glabld=? AND glab001=?  
       AND glab002=? AND glab003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapi011_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aapi011_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
 
   #end add-point
   CALL aapi011_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
 
   #end add-point
 
   DISPLAY BY NAME g_glab_m.glab002,g_glab_m.glabld,g_glab_m.glaa014,g_glab_m.glaa008,g_glab_m.glab001, 
       g_glab_m.glaacomp,g_glab_m.glaa004,g_glab_m.glab010
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aapi011.input.head" >}
   
      #單頭段
      INPUT BY NAME g_glab_m.glab002,g_glab_m.glabld,g_glab_m.glaa014,g_glab_m.glaa008,g_glab_m.glab001, 
          g_glab_m.glaacomp,g_glab_m.glaa004,g_glab_m.glab010 
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
         AFTER FIELD glab002
            
            #add-point:AFTER FIELD glab002 name="input.a.glab002"
            IF NOT cl_null(g_glab_m.glab002) THEN
               IF NOT ap_chk_isExist(g_glab_m.glab002,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3211' ",'aap-00001',1) THEN  
                  LET g_glab_m.glab002 = g_glab_m_t.glab002
                  NEXT FIELD CURRENT
               END IF
              
               IF NOT ap_chk_isExist(g_glab_m.glab002,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3211' AND oocqstus = 'Y' ",'sub-01302','aapi010') THEN   #160318-00005#2 add
               #IF NOT ap_chk_isExist(g_glab_m.glab002,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3211' AND oocqstus = 'Y' ",'aap-00002',1) THEN          #160318-00005#2 mark
                  LET g_glab_m.glab002 = g_glab_m_t.glab002
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_acc_desc(3211,g_glab_m.glab002) RETURNING g_glab_m.glab002_desc            
            DISPLAY BY NAME g_glab_m.glab002 ,g_glab_m.glab002_desc       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab002
            #add-point:BEFORE FIELD glab002 name="input.b.glab002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab002
            #add-point:ON CHANGE glab002 name="input.g.glab002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glabld
            
            #add-point:AFTER FIELD glabld name="input.a.glabld"
            LET g_glab_m.glabld_desc = ''
            IF NOT cl_null(g_glab_m.glabld) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_glab_m.glabld != g_glab_m_t.glabld OR g_glab_m_t.glabld IS NULL )) THEN #160726-00020#7 Mark
               IF g_glab_m.glabld != g_glab_m_o.glabld OR #160726-00020#7
                  cl_null(g_glab_m_o.glabld) THEN         #160726-00020#7 
                   #CALL s_fin_account_center_with_ld_chk('',g_glab_m.glabld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno          #160812-00027#5 mark
                   #CALL s_fin_account_center_with_ld_chk(g_site,g_glab_m.glabld,g_user,'3','Y',g_wc_glabld,g_today) RETURNING g_sub_success,g_errno  #160812-00027#5 add  #161014-00053#1 mark
                   CALL s_fin_ld_chk(g_glab_m.glabld,g_user,'Y')RETURNING g_sub_success,g_errno  #161014-00053#1 add
                   IF NOT g_sub_success THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = g_errno
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      #161014-00053#1 --s add
                      LET g_errparam.replace[1] = 'agli010'
                      LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                      LET g_errparam.exeprog = 'agli010'
                      #161014-00053#1 --e add
                      #LET g_glab_m.glabld =''        #160726-00020#7 Mark
                      #LET g_glab_m.glabld_desc = ''  #160726-00020#7 Mark
                      LET g_glab_m.glabld = g_glab_m_o.glabld                                 #160726-00020#7
                      CALL s_desc_get_ld_desc(g_glab_m.glabld) RETURNING g_glab_m.glabld_desc #160726-00020#7
                      DISPLAY BY NAME g_glab_m.glabld_desc
                      NEXT FIELD CURRENT
                   END IF
               END IF
               LET g_glab_m_o.glabld = g_glab_m.glabld #160726-00020#7
            END IF
            SELECT glaa004,glaa008,glaacomp,glaa014 
              INTO g_glab_m.glaa004,g_glab_m.glaa008,g_glab_m.glaacomp,g_glab_m.glaa014
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = g_glab_m.glabld
            CALL s_desc_get_ld_desc(g_glab_m.glabld) RETURNING g_glab_m.glabld_desc
            CALL s_desc_get_department_desc(g_glab_m.glaacomp)RETURNING g_glab_m.glaacomp_desc
            DISPLAY BY NAME g_glab_m.glabld_desc,g_glab_m.glaacomp_desc
               
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glabld
            #add-point:BEFORE FIELD glabld name="input.b.glabld"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glabld
            #add-point:ON CHANGE glabld name="input.g.glabld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa014
            #add-point:BEFORE FIELD glaa014 name="input.b.glaa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa014
            
            #add-point:AFTER FIELD glaa014 name="input.a.glaa014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa014
            #add-point:ON CHANGE glaa014 name="input.g.glaa014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa008
            #add-point:BEFORE FIELD glaa008 name="input.b.glaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa008
            
            #add-point:AFTER FIELD glaa008 name="input.a.glaa008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa008
            #add-point:ON CHANGE glaa008 name="input.g.glaa008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab001
            #add-point:BEFORE FIELD glab001 name="input.b.glab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab001
            
            #add-point:AFTER FIELD glab001 name="input.a.glab001"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab001
            #add-point:ON CHANGE glab001 name="input.g.glab001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="input.a.glaacomp"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="input.b.glaacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaacomp
            #add-point:ON CHANGE glaacomp name="input.g.glaacomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa004
            
            #add-point:AFTER FIELD glaa004 name="input.a.glaa004"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa004
            #add-point:BEFORE FIELD glaa004 name="input.b.glaa004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa004
            #add-point:ON CHANGE glaa004 name="input.g.glaa004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab010
            #add-point:BEFORE FIELD glab010 name="input.b.glab010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab010
            
            #add-point:AFTER FIELD glab010 name="input.a.glab010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab010
            #add-point:ON CHANGE glab010 name="input.g.glab010"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glab002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab002
            #add-point:ON ACTION controlp INFIELD glab002 name="input.c.glab002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glab_m.glab002                
            LET g_qryparam.arg1 = "3211" 
            CALL q_oocq002()                                
            LET g_glab_m.glab002 = g_qryparam.return1 
            CALL s_desc_get_acc_desc(3211,g_glab_m.glab002) RETURNING g_glab_m.glab002_desc            
            DISPLAY BY NAME g_glab_m.glab002 ,g_glab_m.glab002_desc              
            NEXT FIELD glab002   
            #END add-point
 
 
         #Ctrlp:input.c.glabld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glabld
            #add-point:ON ACTION controlp INFIELD glabld name="input.c.glabld"
            CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str  #161014-00053#1 add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glab_m.glabld             
            #LET g_qryparam.where = " ((glaa008 ='Y' AND glaa014!='Y') OR (glaa014='Y'))"                   #160812-00027#5 mark
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_glabld CLIPPED   #160812-00027#5 add
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')"   #161014-00053#1 add
            CALL q_authorised_ld()                                
            LET g_glab_m.glabld = g_qryparam.return1   
            CALL s_desc_get_ld_desc(g_glab_m.glabld)RETURNING g_glab_m.glabld_desc             
            DISPLAY BY NAME g_glab_m.glabld, g_glab_m.glabld_desc              
            NEXT FIELD glabld
            #END add-point
 
 
         #Ctrlp:input.c.glaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa014
            #add-point:ON ACTION controlp INFIELD glaa014 name="input.c.glaa014"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa008
            #add-point:ON ACTION controlp INFIELD glaa008 name="input.c.glaa008"
            
            #END add-point
 
 
         #Ctrlp:input.c.glab001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab001
            #add-point:ON ACTION controlp INFIELD glab001 name="input.c.glab001"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="input.c.glaacomp"
 
            #END add-point
 
 
         #Ctrlp:input.c.glaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa004
            #add-point:ON ACTION controlp INFIELD glaa004 name="input.c.glaa004"
 
            #END add-point
 
 
         #Ctrlp:input.c.glab010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab010
            #add-point:ON ACTION controlp INFIELD glab010 name="input.c.glab010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glab_m.glab010  
            LET g_qryparam.where = "dzeb001 IN ('apca_t','apcb_t')"            
            CALL q_dzeb002_10()          
            IF NOT cl_null(g_glab_m.glab010) AND NOT cl_null(g_qryparam.return1) THEN     
               CALL aapi011_apca010_str(g_qryparam.return1)RETURNING g_qryparam.return1            
               LET g_glab_m.glab010 = g_glab_m.glab010,",@",g_qryparam.return1 
            ELSE          
               IF NOT cl_null(g_qryparam.return1)THEN            
                  LET g_glab_m.glab010 = "@",aapi011_apca010_str(g_qryparam.return1)
               END IF
            END IF               
            DISPLAY BY NAME g_glab_m.glab010              
            NEXT FIELD glab010   
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
            DISPLAY BY NAME g_glab_m.glabld             
                            ,g_glab_m.glab001   
                            ,g_glab_m.glab002   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL aapi011_glab_t_mask_restore('restore_mask_o')
            
               UPDATE glab_t SET (glab002,glabld,glab001,glab010) = (g_glab_m.glab002,g_glab_m.glabld, 
                   g_glab_m.glab001,g_glab_m.glab010)
                WHERE glabent = g_enterprise AND glabld = g_glabld_t
                  AND glab001 = g_glab001_t
                  AND glab002 = g_glab002_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glab_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glab_m.glabld
               LET gs_keys_bak[1] = g_glabld_t
               LET gs_keys[2] = g_glab_m.glab001
               LET gs_keys_bak[2] = g_glab001_t
               LET gs_keys[3] = g_glab_m.glab002
               LET gs_keys_bak[3] = g_glab002_t
               LET gs_keys[4] = g_glab_d[g_detail_idx].glab003
               LET gs_keys_bak[4] = g_glab_d_t.glab003
               CALL aapi011_update_b('glab_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
         
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_glab_m_t)
                     #LET g_log2 = util.JSON.stringify(g_glab_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL aapi011_glab_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aapi011_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_glabld_t = g_glab_m.glabld
           LET g_glab001_t = g_glab_m.glab001
           LET g_glab002_t = g_glab_m.glab002
 
           
           IF g_glab_d.getLength() = 0 THEN
              NEXT FIELD glab003
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="aapi011.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_glab_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glab_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapi011_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            CALL aapi011_b_upd()
            CALL aapi011_b_fill(g_wc2)
            CALL aapi011_b2_fill()
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
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
            CALL aapi011_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN aapi011_cl USING g_enterprise,g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE aapi011_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aapi011_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_glab_d[l_ac].glab003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_glab_d_t.* = g_glab_d[l_ac].*  #BACKUP
               LET g_glab_d_o.* = g_glab_d[l_ac].*  #BACKUP
               CALL aapi011_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
              
               #end add-point
               CALL aapi011_set_no_entry_b(l_cmd)
               OPEN aapi011_bcl USING g_enterprise,g_glab_m.glabld,
                                                g_glab_m.glab001,
                                                g_glab_m.glab002,
 
                                                g_glab_d_t.glab003
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aapi011_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapi011_bcl INTO g_glab_d[l_ac].glab003,g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab011 
 
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_glab_d_t.glab003,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glab_d_mask_o[l_ac].* =  g_glab_d[l_ac].*
                  CALL aapi011_glab_t_mask()
                  LET g_glab_d_mask_n[l_ac].* =  g_glab_d[l_ac].*
                  
                  CALL aapi011_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL s_hint_show_set_comments('glab010',g_glab010_comm)
            #end add-point  
            
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_glab_d_t.* TO NULL
            INITIALIZE g_glab_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glab_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_glab_d[l_ac].glab003 = "8504"
      LET g_glab_d[l_ac].glab011 = "1"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_glab_d_t.* = g_glab_d[l_ac].*     #新輸入資料
            LET g_glab_d_o.* = g_glab_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapi011_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL aapi011_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glab_d[li_reproduce_target].* = g_glab_d[li_reproduce].*
 
               LET g_glab_d[g_glab_d.getLength()].glab003 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_glab_m.glab001 = '13' 
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
            SELECT COUNT(1) INTO l_count FROM glab_t 
             WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld
               AND glab001 = g_glab_m.glab001
               AND glab002 = g_glab_m.glab002
 
               AND glab003 = g_glab_d[l_ac].glab003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
              
               #end add-point
               INSERT INTO glab_t
                           (glabent,
                            glab002,glabld,glab001,glab010,
                            glab003
                            ,glab005,glab011) 
                     VALUES(g_enterprise,
                            g_glab_m.glab002,g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab010,
                            g_glab_d[l_ac].glab003
                            ,g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab011)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_glab_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
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
               IF aapi011_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_glab_m.glabld
                  LET gs_keys[gs_keys.getLength()+1] = g_glab_m.glab001
                  LET gs_keys[gs_keys.getLength()+1] = g_glab_m.glab002
 
                  LET gs_keys[gs_keys.getLength()+1] = g_glab_d_t.glab003
 
 
                  #刪除下層單身
                  IF NOT aapi011_key_delete_b(gs_keys,'glab_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aapi011_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aapi011_bcl
               LET l_count = g_glab_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_glab_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab003
            
            #add-point:AFTER FIELD glab003 name="input.a.page1.glab003"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab003
            #add-point:BEFORE FIELD glab003 name="input.b.page1.glab003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab003
            #add-point:ON CHANGE glab003 name="input.g.page1.glab003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab003_desc
            #add-point:BEFORE FIELD glab003_desc name="input.b.page1.glab003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab003_desc
            
            #add-point:AFTER FIELD glab003_desc name="input.a.page1.glab003_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab003_desc
            #add-point:ON CHANGE glab003_desc name="input.g.page1.glab003_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005
            
            #add-point:AFTER FIELD glab005 name="input.a.page1.glab005"
            LET g_glab_d[l_ac].glab005_desc = ''
            IF NOT cl_null(g_glab_d[l_ac].glab005) THEN
#  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_glab_m.glabld,g_glab_d[l_ac].glab005,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_glab_m.glabld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_glab_d[l_ac].glab005
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_glab_d[l_ac].glab005
                LET g_qryparam.arg3 = g_glab_m.glabld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_glab_d[l_ac].glab005 = g_qryparam.return1                        
                CALL s_desc_get_account_desc(g_glab_m.glabld,g_glab_d[l_ac].glab005)  RETURNING g_glab_d[l_ac].glab005_desc
                DISPLAY BY NAME g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab005_desc
               
             END IF
             IF NOT s_aglt310_lc_subject(g_glab_m.glabld,g_glab_d[l_ac].glab005,'N') THEN
                   LET g_glab_d[l_ac].glab005 = ''
                  LET g_glab_d[l_ac].glab005_desc = ''
                  DISPLAY BY NAME g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab005_desc
                  NEXT FIELD CURRENT
             END IF
 #  150916-00015#1 END

               CALL s_aap_glac002_chk(g_glab_d[l_ac].glab005,g_glab_m.glabld) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160321-00016#19 --s add
                  LET g_errparam.replace[1] = 'agli020'
                  LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                  LET g_errparam.exeprog = 'agli020'
                  #160321-00016#19 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_glab_d[l_ac].glab005 = ''
                  LET g_glab_d[l_ac].glab005_desc = ''
                  DISPLAY BY NAME g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab005_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_account_desc(g_glab_m.glabld,g_glab_d[l_ac].glab005)  RETURNING g_glab_d[l_ac].glab005_desc
            DISPLAY BY NAME g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab005_desc
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005
            #add-point:BEFORE FIELD glab005 name="input.b.page1.glab005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab005
            #add-point:ON CHANGE glab005 name="input.g.page1.glab005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005_desc
            #add-point:BEFORE FIELD glab005_desc name="input.b.page1.glab005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005_desc
            
            #add-point:AFTER FIELD glab005_desc name="input.a.page1.glab005_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab005_desc
            #add-point:ON CHANGE glab005_desc name="input.g.page1.glab005_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab011
            #add-point:BEFORE FIELD glab011 name="input.b.page1.glab011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab011
            
            #add-point:AFTER FIELD glab011 name="input.a.page1.glab011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab011
            #add-point:ON CHANGE glab011 name="input.g.page1.glab011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzcb002
            #add-point:BEFORE FIELD gzcb002 name="input.b.page1.gzcb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzcb002
            
            #add-point:AFTER FIELD gzcb002 name="input.a.page1.gzcb002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzcb002
            #add-point:ON CHANGE gzcb002 name="input.g.page1.gzcb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzcb014
            #add-point:BEFORE FIELD gzcb014 name="input.b.page1.gzcb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzcb014
            
            #add-point:AFTER FIELD gzcb014 name="input.a.page1.gzcb014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzcb014
            #add-point:ON CHANGE gzcb014 name="input.g.page1.gzcb014"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.glab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab003
            #add-point:ON ACTION controlp INFIELD glab003 name="input.c.page1.glab003"
  
            #END add-point
 
 
         #Ctrlp:input.c.page1.glab003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab003_desc
            #add-point:ON ACTION controlp INFIELD glab003_desc name="input.c.page1.glab003_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005
            #add-point:ON ACTION controlp INFIELD glab005 name="input.c.page1.glab005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glab_d[l_ac].glab005             
            LET g_qryparam.where = " glac003 <> '1' AND glac001 = '",g_glab_m.glaa004,"'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_glab_m.glabld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()                                
            LET g_glab_d[l_ac].glab005 = g_qryparam.return1                        
            CALL s_desc_get_account_desc(g_glab_m.glabld,g_glab_d[l_ac].glab005)  RETURNING g_glab_d[l_ac].glab005_desc
            DISPLAY BY NAME g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab005_desc
            NEXT FIELD glab005                          
            #END add-point
 
 
         #Ctrlp:input.c.page1.glab005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005_desc
            #add-point:ON ACTION controlp INFIELD glab005_desc name="input.c.page1.glab005_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glab011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab011
            #add-point:ON ACTION controlp INFIELD glab011 name="input.c.page1.glab011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzcb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzcb002
            #add-point:ON ACTION controlp INFIELD gzcb002 name="input.c.page1.gzcb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzcb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzcb014
            #add-point:ON ACTION controlp INFIELD gzcb014 name="input.c.page1.gzcb014"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glab_d[l_ac].* = g_glab_d_t.*
               CLOSE aapi011_bcl
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
               LET g_errparam.extend = g_glab_d[l_ac].glab003 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_glab_d[l_ac].* = g_glab_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL aapi011_glab_t_mask_restore('restore_mask_o')
         
               UPDATE glab_t SET (glabld,glab001,glab002,glab003,glab005,glab011) = (g_glab_m.glabld, 
                   g_glab_m.glab001,g_glab_m.glab002,g_glab_d[l_ac].glab003,g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab011) 
 
                WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld 
                 AND glab001 = g_glab_m.glab001 
                 AND glab002 = g_glab_m.glab002 
 
                 AND glab003 = g_glab_d_t.glab003 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glab_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "glab_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glab_m.glabld
               LET gs_keys_bak[1] = g_glabld_t
               LET gs_keys[2] = g_glab_m.glab001
               LET gs_keys_bak[2] = g_glab001_t
               LET gs_keys[3] = g_glab_m.glab002
               LET gs_keys_bak[3] = g_glab002_t
               LET gs_keys[4] = g_glab_d[g_detail_idx].glab003
               LET gs_keys_bak[4] = g_glab_d_t.glab003
               CALL aapi011_update_b('glab_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_glab_m),util.JSON.stringify(g_glab_d_t)
                     LET g_log2 = util.JSON.stringify(g_glab_m),util.JSON.stringify(g_glab_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapi011_glab_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_glab_m.glabld
               LET ls_keys[ls_keys.getLength()+1] = g_glab_m.glab001
               LET ls_keys[ls_keys.getLength()+1] = g_glab_m.glab002
 
               LET ls_keys[ls_keys.getLength()+1] = g_glab_d_t.glab003
 
               CALL aapi011_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE aapi011_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glab_d[l_ac].* = g_glab_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE aapi011_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_glab_d.getLength() = 0 THEN
               NEXT FIELD glab003
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glab_d[li_reproduce_target].* = g_glab_d[li_reproduce].*
 
               LET g_glab_d[li_reproduce_target].glab003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_glab_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glab_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      INPUT ARRAY g_glab2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
      
         BEFORE INPUT
            CALL aapi011_b_upd()
            CALL aapi011_b2_fill()
            CALL aapi011_b_fill(g_wc2)
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac2 = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac2 TO FORMONLY.idx
            CALL s_hint_show_set_comments('glab010',g_glab010_comm)
         CALL s_transaction_begin()
         
         AFTER FIELD glab005_2
         LET g_glab2_d[l_ac2].glab005_2_desc = ''
         IF NOT cl_null(g_glab2_d[l_ac2].glab005_2) THEN
 #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_glab_m.glabld,g_glab2_d[l_ac2].glab005_2,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_glab_m.glabld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_glab2_d[l_ac2].glab005_2
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_glab2_d[l_ac2].glab005_2
                LET g_qryparam.arg3 = g_glab_m.glabld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                
               LET g_glab2_d[l_ac2].glab005_2 = g_qryparam.return1  
               CALL s_desc_get_account_desc(g_glab_m.glabld,g_glab2_d[l_ac2].glab005_2)  RETURNING g_glab2_d[l_ac2].glab005_2_desc
               DISPLAY BY NAME g_glab2_d[l_ac2].glab005_2,g_glab2_d[l_ac2].glab005_2_desc                                 
             
             END IF
             IF NOT s_aglt310_lc_subject(g_glab_m.glabld,g_glab2_d[l_ac2].glab005_2,'N') THEN
                   LET g_glab2_d[l_ac2].glab005_2 = ''
               CALL s_desc_get_account_desc(g_glab_m.glabld,g_glab2_d[l_ac2].glab005_2)RETURNING g_glab2_d[l_ac2].glab005_2_desc
               DISPLAY BY NAME g_glab2_d[l_ac2].glab005_2,g_glab2_d[l_ac2].glab005_2_desc
               NEXT FIELD CURRENT
             END IF
 #  150916-00015#1 END
            CALL s_aap_glac002_chk(g_glab2_d[l_ac2].glab005_2,g_glab_m.glabld) RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = ''
               #160321-00016#19 --s add
               LET g_errparam.replace[1] = 'agli020'
               LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
               LET g_errparam.exeprog = 'agli020'
               #160321-00016#19 --e add
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_glab2_d[l_ac2].glab005_2 = ''
               CALL s_desc_get_account_desc(g_glab_m.glabld,g_glab2_d[l_ac2].glab005_2)RETURNING g_glab2_d[l_ac2].glab005_2_desc
               DISPLAY BY NAME g_glab2_d[l_ac2].glab005_2,g_glab2_d[l_ac2].glab005_2_desc
               NEXT FIELD CURRENT
            END IF
         END IF
         CALL s_desc_get_account_desc(g_glab_m.glabld,g_glab2_d[l_ac2].glab005_2)  RETURNING g_glab2_d[l_ac2].glab005_2_desc
         DISPLAY BY NAME g_glab2_d[l_ac2].glab005_2,g_glab2_d[l_ac2].glab005_2_desc
                     
         ON ACTION controlp INFIELD glab005_2
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glab2_d[l_ac2].glab005_2             
            LET g_qryparam.where = " glac003 <> '1' AND glac001 = '",g_glab_m.glaa004,"'",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_glab_m.glabld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()                                
            LET g_glab2_d[l_ac2].glab005_2 = g_qryparam.return1  
            CALL s_desc_get_account_desc(g_glab_m.glabld,g_glab2_d[l_ac2].glab005_2)  RETURNING g_glab2_d[l_ac2].glab005_2_desc
            DISPLAY BY NAME g_glab2_d[l_ac2].glab005_2,g_glab2_d[l_ac2].glab005_2_desc                                 
            NEXT FIELD glab005_2     
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_glab2_d[l_ac2].* = g_glab2_d_t.*
               CLOSE aapi011_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF 
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_glab2_d[l_ac2].glab003_2
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_glab2_d[l_ac2].* = g_glab2_d_t.*
            ELSE
               UPDATE glab_t SET (glabld,glab001,glab002,glab003,glab005,glab011) = (g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002,g_glab2_d[l_ac2].glab003_2,g_glab2_d[l_ac2].glab005_2,g_glab2_d[l_ac2].glab011_2)
                WHERE glabent = g_enterprise 
                  AND glabld = g_glab_m.glabld
                  AND glab001 = g_glab_m.glab001
                  AND glab002 = g_glab_m.glab002
                  AND glab003 = g_glab2_d[l_ac2].glab003_2
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "glab_t"
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               END IF
                CALL s_transaction_end('Y','0')
          END IF
     
      END INPUT
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD glab002
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD glab003
               WHEN "s_detail2"
                  NEXT FIELD glab003_2 
            END CASE
         END IF
          
         CALL s_hint_show_set_comments('glab010',g_glab010_comm)
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD glabld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD glab003
 
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
  # CALL aapi011_set_act_visible()
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapi011.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aapi011_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL aapi011_b_fill(g_wc2) #第一階單身填充
      CALL aapi011_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aapi011_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   #帳套說明
   CALL s_desc_get_ld_desc(g_glab_m.glabld)RETURNING g_glab_m.glabld_desc
   #帳務類型
   CALL s_desc_get_acc_desc(3211,g_glab_m.glab002) RETURNING g_glab_m.glab002_desc
   
   SELECT glaa004,glaa008,glaacomp,glaa014 
     INTO g_glab_m.glaa004,g_glab_m.glaa008,g_glab_m.glaacomp,g_glab_m.glaa014
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_glab_m.glabld
   CALL s_desc_get_department_desc(g_glab_m.glaacomp) RETURNING g_glab_m.glaacomp_desc 
   CALL aapi011_b2_fill()
  
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_glab_m.glab002,g_glab_m.glab002_desc,g_glab_m.glabld,g_glab_m.glabld_desc,g_glab_m.glaa014, 
       g_glab_m.glaa008,g_glab_m.glab001,g_glab_m.glaacomp,g_glab_m.glaacomp_desc,g_glab_m.glaa004,g_glab_m.glaa004_desc, 
       g_glab_m.glab010
 
   CALL aapi011_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   CALL s_hint_show_set_comments('glab010',g_glab010_comm)
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="aapi011.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION aapi011_ref_show()
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
   FOR l_ac = 1 TO g_glab_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="aapi011.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aapi011_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE glab_t.glabld 
   DEFINE l_oldno     LIKE glab_t.glabld 
   DEFINE l_newno02     LIKE glab_t.glab001 
   DEFINE l_oldno02     LIKE glab_t.glab001 
   DEFINE l_newno03     LIKE glab_t.glab002 
   DEFINE l_oldno03     LIKE glab_t.glab002 
 
   DEFINE l_master    RECORD LIKE glab_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE glab_t.* #此變數樣板目前無使用
 
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
 
   IF g_glab_m.glabld IS NULL
      OR g_glab_m.glab001 IS NULL
      OR g_glab_m.glab002 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_glabld_t = g_glab_m.glabld
   LET g_glab001_t = g_glab_m.glab001
   LET g_glab002_t = g_glab_m.glab002
 
   
   LET g_glab_m.glabld = ""
   LET g_glab_m.glab001 = ""
   LET g_glab_m.glab002 = ""
 
   LET g_master_insert = FALSE
   CALL aapi011_set_entry('a')
   CALL aapi011_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
  
   #end add-point
   
   #清空key欄位的desc
      LET g_glab_m.glab002_desc = ''
   DISPLAY BY NAME g_glab_m.glab002_desc
   LET g_glab_m.glabld_desc = ''
   DISPLAY BY NAME g_glab_m.glabld_desc
 
   
   CALL aapi011_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_glab_m.* TO NULL
      INITIALIZE g_glab_d TO NULL
 
      CALL aapi011_show()
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
   CALL aapi011_set_act_visible()
   CALL aapi011_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_glabld_t = g_glab_m.glabld
   LET g_glab001_t = g_glab_m.glab001
   LET g_glab002_t = g_glab_m.glab002
 
   
   #組合新增資料的條件
   LET g_add_browse = " glabent = " ||g_enterprise|| " AND",
                      " glabld = '", g_glab_m.glabld, "' "
                      ," AND glab001 = '", g_glab_m.glab001, "' "
                      ," AND glab002 = '", g_glab_m.glab002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapi011_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL aapi011_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL aapi011_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="aapi011.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aapi011_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE glab_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aapi011_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   LET g_glab_m.glab001 = '13' 
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM glab_t
    WHERE glabent = g_enterprise AND glabld = g_glabld_t
    AND glab001 = g_glab001_t
    AND glab002 = g_glab002_t
 
       INTO TEMP aapi011_detail
   
   #將key修正為調整後   
   UPDATE aapi011_detail 
      #更新key欄位
      SET glabld = g_glab_m.glabld
          , glab001 = g_glab_m.glab001
          , glab002 = g_glab_m.glab002
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO glab_t SELECT * FROM aapi011_detail
   
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
   DROP TABLE aapi011_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_glabld_t = g_glab_m.glabld
   LET g_glab001_t = g_glab_m.glab001
   LET g_glab002_t = g_glab_m.glab002
 
   
   DROP TABLE aapi011_detail
   
END FUNCTION
 
{</section>}
 
{<section id="aapi011.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapi011_delete()
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
   
   IF g_glab_m.glabld IS NULL
   OR g_glab_m.glab001 IS NULL
   OR g_glab_m.glab002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN aapi011_cl USING g_enterprise,g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapi011_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aapi011_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapi011_master_referesh USING g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002 INTO g_glab_m.glab002, 
       g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab010
   
   #遮罩相關處理
   LET g_glab_m_mask_o.* =  g_glab_m.*
   CALL aapi011_glab_t_mask()
   LET g_glab_m_mask_n.* =  g_glab_m.*
   
   CALL aapi011_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapi011_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
 
#      #end add-point
#      
#      DELETE FROM glab_t WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld
#                                                               AND glab001 = g_glab_m.glab001
#                                                               AND glab002 = g_glab_m.glab002
# 
#                                                               
#      #add-point:單身刪除中 name="delete.body.m_delete"
      #161028-00046#1---add---str--
      #將上面sql剛性結構區塊註解,改用底下sql
      DELETE FROM glab_t WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld
                                                               AND glab001 = g_glab_m.glab001
                                                               AND glab002 = g_glab_m.glab002
                                                               AND glab003 LIKE '8504%'
      #161028-00046#1---add---end--
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
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
      #   CLOSE aapi011_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_glab_d.clear() 
 
     
      CALL aapi011_ui_browser_refresh()  
      #CALL aapi011_ui_headershow()  
      #CALL aapi011_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL aapi011_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL aapi011_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE aapi011_cl
 
   #功能已完成,通報訊息中心
   CALL aapi011_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aapi011.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapi011_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_glab_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT glab003,glab005,glab011 FROM glab_t",   
               "",
               
               
               " WHERE glabent= ? AND glabld=? AND glab001=? AND glab002=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("glab_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT glab003,glab005,glab011 FROM glab_t WHERE glabent= ? AND glabld=? AND glab001=? AND glab002=?"
   LET g_sql = g_sql," AND glab003 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8504' AND gzcb003 = '1') "
   
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("glab_t")
   END IF
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF aapi011_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY glab_t.glab003"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
      LET g_glab_m.glab001 = 13
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapi011_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aapi011_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002 INTO g_glab_d[l_ac].glab003, 
          g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab011   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL s_desc_gzcbl004_desc(8504,g_glab_d[l_ac].glab003) RETURNING g_glab_d[l_ac].glab003_desc
         #會計科目
         CALL s_desc_get_account_desc(g_glab_m.glabld,g_glab_d[l_ac].glab005)  RETURNING g_glab_d[l_ac].glab005_desc
         
         #會計科目
         LET g_glab_d[l_ac].gzcb002 = g_glab_d[l_ac].glab003
         #會科備註
         SELECT gzcb014 INTO g_glab_d[l_ac].gzcb014
           FROM gzcb_t 
          WHERE gzcb001 = '8504'
            AND gzcb002 = g_glab_d[l_ac].glab003
         
         
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
 
            CALL g_glab_d.deleteElement(g_glab_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_glab_d.getLength()
      LET g_glab_d_mask_o[l_ac].* =  g_glab_d[l_ac].*
      CALL aapi011_glab_t_mask()
      LET g_glab_d_mask_n[l_ac].* =  g_glab_d[l_ac].*
   END FOR
   
 
 
   FREE aapi011_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="aapi011.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aapi011_idx_chk()
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
      IF g_detail_idx > g_glab_d.getLength() THEN
         LET g_detail_idx = g_glab_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_glab_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glab_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapi011.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapi011_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_glab_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aapi011.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION aapi011_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM glab_t
    WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld AND
                              glab001 = g_glab_m.glab001 AND
                              glab002 = g_glab_m.glab002 AND
 
          glab003 = g_glab_d_t.glab003
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
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
 
{<section id="aapi011.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapi011_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="aapi011.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapi011_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="aapi011.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapi011_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="aapi011.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION aapi011_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_glab_d[l_ac].glab003 = g_glab_d_t.glab003 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapi011.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aapi011_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aapi011.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapi011_lock_b(ps_table,ps_page)
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
   #CALL aapi011_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapi011.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapi011_unlock_b(ps_table,ps_page)
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
 
{<section id="aapi011.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aapi011_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("glabld,glab001,glab002",TRUE)
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
 
{<section id="aapi011.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aapi011_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("glabld,glab001,glab002",FALSE)
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
 
{<section id="aapi011.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapi011_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
 
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
 
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapi011.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapi011_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
  
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
  
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aapi011.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aapi011_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
 
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapi011.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aapi011_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
 
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
 
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapi011.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aapi011_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapi011.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aapi011_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapi011.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapi011_default_search()
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
      LET ls_wc = ls_wc, " glabld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glab001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " glab002 = '", g_argv[03], "' AND "
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
 
{<section id="aapi011.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aapi011_fill_chk(ps_idx)
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
 
{<section id="aapi011.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION aapi011_modify_detail_chk(ps_record)
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
         LET ls_return = "glab003"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aapi011.mask_functions" >}
&include "erp/aap/aapi011_mask.4gl"
 
{</section>}
 
{<section id="aapi011.state_change" >}
    
 
{</section>}
 
{<section id="aapi011.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapi011_set_pk_array()
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
   LET g_pk_array[1].values = g_glab_m.glabld
   LET g_pk_array[1].column = 'glabld'
   LET g_pk_array[2].values = g_glab_m.glab001
   LET g_pk_array[2].column = 'glab001'
   LET g_pk_array[3].values = g_glab_m.glab002
   LET g_pk_array[3].column = 'glab002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapi011.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aapi011_msgcentre_notify(lc_state)
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
   CALL aapi011_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_glab_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapi011.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 第二單身填充
# Memo...........:
# Usage..........: CALL aapi011_b2_fill()
# Date & Author..: 2014/10/07 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapi011_b2_fill()
DEFINE p_wc2     STRING

   CALL g_glab2_d.clear()

   LET g_sql = "  SELECT glab003,'',glab005,'',glab011                      ",
               "    FROM glab_t                                             ",
               "   WHERE glabent = '",g_enterprise,"'                       ", 
               "     AND glabld  = '",g_glab_m.glabld,"'                    ",
               "     AND glab001 ='13' AND glab002= '",g_glab_m.glab002,"'  ",
               "     AND glab003 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8504' AND gzcb003 = '2') ", 
               "   ORDER BY glab003                                         "
               
   PREPARE aapi011_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR aapi011_pb2
   LET g_cnt = l_ac2
   LET l_ac2 = 1
   FOREACH b_fill_cs2 INTO g_glab2_d[l_ac2].glab003_2,g_glab2_d[l_ac2].glab003_2_desc,
                           g_glab2_d[l_ac2].glab005_2,g_glab2_d[l_ac2].glab005_2_desc,
                           g_glab2_d[l_ac2].glab011_2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      CALL s_desc_gzcbl004_desc(8504,g_glab2_d[l_ac2].glab003_2) RETURNING g_glab2_d[l_ac2].glab003_2_desc
      CALL s_desc_get_account_desc(g_glab_m.glabld,g_glab2_d[l_ac2].glab005_2)  RETURNING g_glab2_d[l_ac2].glab005_2_desc
      #會計科目
      LET g_glab2_d[l_ac2].gzcb002_2 = g_glab2_d[l_ac2].glab003_2
      #會科備註
      SELECT gzcb014 INTO g_glab2_d[l_ac2].gzcb014_2
        FROM gzcb_t 
       WHERE gzcb001 = '8504'
         AND gzcb002 = g_glab2_d[l_ac2].glab003_2
     


      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_glab2_d.deleteElement(l_ac2)
   LET g_rec_b2=l_ac2-1
   DISPLAY g_rec_b2 TO FORMONLY.cnt
   LET l_ac2 = g_cnt
   LET g_cnt = 0
   FREE aapi011_pb2
END FUNCTION

################################################################################
# Descriptions...: 單身資料的更新同步
# Memo...........:
# Usage..........: CALL aapi011_b_upd()
# Date & Author..: 2014/10/03 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapi011_b_upd()
#DEFINE l_glab       RECORD LIKE glab_t.*  #161108-00017#1 mark
#161108-00017#1 add ------
DEFINE l_glab       RECORD  #帳套應用會計科目設定檔
          glabent      LIKE glab_t.glabent,   #企業編號
          glabld       LIKE glab_t.glabld,    #帳套
          glab001      LIKE glab_t.glab001,   #設定類型
          glab002      LIKE glab_t.glab002,   #分類碼
          glab003      LIKE glab_t.glab003,   #分類碼值
          glab004      LIKE glab_t.glab004,   #科目參照表編號
          glab005      LIKE glab_t.glab005,   #會計科目編號一
          glab006      LIKE glab_t.glab006,   #會計科目編號二
          glab007      LIKE glab_t.glab007,   #會計科目編號三
          glab008      LIKE glab_t.glab008,   #會計科目編號四
          glab009      LIKE glab_t.glab009,   #會計科目編號五
          glab010      LIKE glab_t.glab010,   #其他設定值
          glab011      LIKE glab_t.glab011,   #科目彙總方式
          #161125-00021#1 add ------
          glabud001    LIKE glab_t.glabud001, #自定義欄位(文字)001
          glabud002    LIKE glab_t.glabud002, #自定義欄位(文字)002
          glabud003    LIKE glab_t.glabud003, #自定義欄位(文字)003
          glabud004    LIKE glab_t.glabud004, #自定義欄位(文字)004
          glabud005    LIKE glab_t.glabud005, #自定義欄位(文字)005
          glabud006    LIKE glab_t.glabud006, #自定義欄位(文字)006
          glabud007    LIKE glab_t.glabud007, #自定義欄位(文字)007
          glabud008    LIKE glab_t.glabud008, #自定義欄位(文字)008
          glabud009    LIKE glab_t.glabud009, #自定義欄位(文字)009
          glabud010    LIKE glab_t.glabud010, #自定義欄位(文字)010
          glabud011    LIKE glab_t.glabud011, #自定義欄位(數字)011
          glabud012    LIKE glab_t.glabud012, #自定義欄位(數字)012
          glabud013    LIKE glab_t.glabud013, #自定義欄位(數字)013
          glabud014    LIKE glab_t.glabud014, #自定義欄位(數字)014
          glabud015    LIKE glab_t.glabud015, #自定義欄位(數字)015
          glabud016    LIKE glab_t.glabud016, #自定義欄位(數字)016
          glabud017    LIKE glab_t.glabud017, #自定義欄位(數字)017
          glabud018    LIKE glab_t.glabud018, #自定義欄位(數字)018
          glabud019    LIKE glab_t.glabud019, #自定義欄位(數字)019
          glabud020    LIKE glab_t.glabud020, #自定義欄位(數字)020
          glabud021    LIKE glab_t.glabud021, #自定義欄位(日期時間)021
          glabud022    LIKE glab_t.glabud022, #自定義欄位(日期時間)022
          glabud023    LIKE glab_t.glabud023, #自定義欄位(日期時間)023
          glabud024    LIKE glab_t.glabud024, #自定義欄位(日期時間)024
          glabud025    LIKE glab_t.glabud025, #自定義欄位(日期時間)025
          glabud026    LIKE glab_t.glabud026, #自定義欄位(日期時間)026
          glabud027    LIKE glab_t.glabud027, #自定義欄位(日期時間)027
          glabud028    LIKE glab_t.glabud028, #自定義欄位(日期時間)028
          glabud029    LIKE glab_t.glabud029, #自定義欄位(日期時間)029
          glabud030    LIKE glab_t.glabud030, #自定義欄位(日期時間)030
          #161125-00021#1 add end---
          glab012      LIKE glab_t.glab012,   #会计科目编号六
          glab013      LIKE glab_t.glab013,   #會計科目編號七
          glab014      LIKE glab_t.glab014,   #代收銀據點
          glab015      LIKE glab_t.glab015,   #據點帳套
          glab016      LIKE glab_t.glab016    #代收銀收款科目(流通)
                    END RECORD
#161108-00017#1 add end---
DEFINE l_sql        STRING
DEFINE l_success    LIKE type_t.chr1


   SELECT glaa004 INTO l_glab.glab004
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glab_m.glabld

   LET l_glab.glabent = g_enterprise
   LET l_glab.glabld  = g_glab_m.glabld
   LET l_glab.glab002 = g_glab_m.glab002
   LET l_glab.glab001 = '13'
   LET l_glab.glab005 = ''
   LET l_glab.glab006 = ''
   LET l_glab.glab007 = ''
   LET l_glab.glab008 = ''
   LET l_glab.glab009 = ''
   LET l_glab.glab010 = ''
   LET l_glab.glab011 = '1'

   CALL s_transaction_begin()
   LET l_sql = " DELETE FROM glab_t WHERE glabent = '",g_enterprise,"'",
              "   AND glabld = '",g_glab_m.glabld,"' AND glab002 = '",g_glab_m.glab002,"' AND glab001 ='13' ",
              "   AND glab003 NOT IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 ='8504')"
             ,"   AND glab003 LIKE '8504%' "   #161028-00046#1 add 
   PREPARE glab_del FROM l_sql
   EXECUTE glab_del
   
   LET l_success = 'Y'
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 ='8504' ",
               "   AND gzcb002 NOT IN (SELECT glab003 FROM glab_t WHERE glabent = '",g_enterprise,"'",
               "   AND glabld = '",g_glab_m.glabld,"' AND glab002 = '",g_glab_m.glab002,"' AND glab001 ='13')"
   PREPARE glab_ins_pre FROM l_sql
   DECLARE glab_ins CURSOR FOR glab_ins_pre
   FOREACH glab_ins INTO l_glab.glab003
      #INSERT INTO glab_t VALUES l_glab.*  #161108-00017#1 mark
      #161108-00017#1 add ------
      INSERT INTO glab_t (glabent,glabld,
                          glab001,glab002,glab003,glab004,glab005,
                          glab006,glab007,glab008,glab009,glab010,
                          glab011,
                          #161125-00021#1 add ------
                          glabud001,glabud002,glabud003,glabud004,glabud005,
                          glabud006,glabud007,glabud008,glabud009,glabud010,
                          glabud011,glabud012,glabud013,glabud014,glabud015,
                          glabud016,glabud017,glabud018,glabud019,glabud020,
                          glabud021,glabud022,glabud023,glabud024,glabud025,
                          glabud026,glabud027,glabud028,glabud029,glabud030,
                          #161125-00021#1 add end---
                          glab012,glab013,glab014,glab015,glab016
                          )
      VALUES (l_glab.glabent,l_glab.glabld,
              l_glab.glab001,l_glab.glab002,l_glab.glab003,l_glab.glab004,l_glab.glab005,
              l_glab.glab006,l_glab.glab007,l_glab.glab008,l_glab.glab009,l_glab.glab010,
              l_glab.glab011,
              #161125-00021#1 add ------
              l_glab.glabud001,l_glab.glabud002,l_glab.glabud003,l_glab.glabud004,l_glab.glabud005,
              l_glab.glabud006,l_glab.glabud007,l_glab.glabud008,l_glab.glabud009,l_glab.glabud010,
              l_glab.glabud011,l_glab.glabud012,l_glab.glabud013,l_glab.glabud014,l_glab.glabud015,
              l_glab.glabud016,l_glab.glabud017,l_glab.glabud018,l_glab.glabud019,l_glab.glabud020,
              l_glab.glabud021,l_glab.glabud022,l_glab.glabud023,l_glab.glabud024,l_glab.glabud025,
              l_glab.glabud026,l_glab.glabud027,l_glab.glabud028,l_glab.glabud029,l_glab.glabud030,
              #161125-00021#1 add end---
              l_glab.glab012,l_glab.glab013,l_glab.glab014,l_glab.glab015,l_glab.glab016
              )
      #161108-00017#1 add end---
      IF SQLCA.SQLcode THEN
         LET l_success = 'N'
         EXIT FOREACH
      END IF
   END FOREACH
   
   IF l_success = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "glab_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF

END FUNCTION

################################################################################
# Descriptions...: 重組 apca010的字串
# Memo...........:
# Usage..........: CALL aapi011_apca010_str()
# Date & Author..: 2014/12/08 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapi011_apca010_str(p_wc)
   DEFINE tok            base.stringtokenizer
   DEFINE p_wc           STRING
   
   
   WHENEVER ERROR CONTINUE
   LET p_wc = cl_replace_str(p_wc,"|",",@")
   RETURN p_wc
   
   
END FUNCTION

 
{</section>}
 
