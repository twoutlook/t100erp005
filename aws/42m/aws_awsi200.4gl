#該程式已解開Section, 不再透過樣板產出!
{<section id="awsi200.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:2,PR版次:2) Build-000133
#+ 
#+ Filename...: awsi200
#+ Description: ETL Job 設定
#+ Creator....: 02669(2015-06-18 16:03:02)
#+ Modifier...: 02669(2015-06-18 16:03:02) -SD/PR- 07673
 
{</section>}
 
{<section id="awsi200.global" >}
#應用 i07 樣板自動產生(Version:24)
#160318-00025#14 2016/04/18 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_wsca_m        RECORD
       wsca001 LIKE wsca_t.wsca001,
   wsca001_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_wsca_d        RECORD
       wsca007 LIKE wsca_t.wsca007, 
   wsca008 LIKE wsca_t.wsca008, 
   wsca002 LIKE wsca_t.wsca002, 
   wsca005 LIKE wsca_t.wsca005,
   wscal009 LIKE wscal_t.wscal009,   
   wsca004 LIKE wsca_t.wsca004,    
   wscastus LIKE wsca_t.wscastus
       END RECORD
PRIVATE TYPE type_g_wsca2_d RECORD
       wsca007 LIKE wsca_t.wsca007, 
   wscaownid LIKE wsca_t.wscaownid, 
   wscaownid_desc LIKE type_t.chr500, 
   wscaowndp LIKE wsca_t.wscaowndp, 
   wscaowndp_desc LIKE type_t.chr500, 
   wscacrtid LIKE wsca_t.wscacrtid, 
   wscacrtid_desc LIKE type_t.chr500, 
   wscacrtdp LIKE wsca_t.wscacrtdp, 
   wscacrtdp_desc LIKE type_t.chr500, 
   wscacrtdt DATETIME YEAR TO SECOND, 
   wscamodid LIKE wsca_t.wscamodid, 
   wscamodid_desc LIKE type_t.chr500, 
   wscamoddt DATETIME YEAR TO SECOND
       END RECORD
 
DEFINE g_detail_multi_table_t    RECORD
      wscal001 LIKE wscal_t.wscal001,
      wscal007 LIKE wscal_t.wscal007,
      wscal008 LIKE wscal_t.wscal008,
      wscal009 LIKE wscal_t.wscal009
      END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_wsca_m          type_g_wsca_m
DEFINE g_wsca_m_t        type_g_wsca_m
DEFINE g_wsca_m_o        type_g_wsca_m
DEFINE g_wsca_m_mask_o   type_g_wsca_m #轉換遮罩前資料
DEFINE g_wsca_m_mask_n   type_g_wsca_m #轉換遮罩後資料
 
   DEFINE g_wsca001_t LIKE wsca_t.wsca001
 
 
DEFINE g_wsca_d          DYNAMIC ARRAY OF type_g_wsca_d
DEFINE g_wsca_d_t        type_g_wsca_d
DEFINE g_wsca_d_o        type_g_wsca_d
DEFINE g_wsca_d_mask_o   DYNAMIC ARRAY OF type_g_wsca_d #轉換遮罩前資料
DEFINE g_wsca_d_mask_n   DYNAMIC ARRAY OF type_g_wsca_d #轉換遮罩後資料
DEFINE g_wsca2_d   DYNAMIC ARRAY OF type_g_wsca2_d
DEFINE g_wsca2_d_t type_g_wsca2_d
DEFINE g_wsca2_d_o type_g_wsca2_d
DEFINE g_wsca2_d_mask_o   DYNAMIC ARRAY OF type_g_wsca2_d #轉換遮罩前資料
DEFINE g_wsca2_d_mask_n   DYNAMIC ARRAY OF type_g_wsca2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_wsca001 LIKE wsca_t.wsca001,
   b_wsca001_desc LIKE type_t.chr80
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
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_is_starting         BOOLEAN                       #判斷程式是否剛剛啟動
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="awsi200.main" >}
#應用 a26 樣板自動產生(Version:4)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define

   #end add-point   
   #add-point:main段define(客製用)

   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aws","")
 
   #add-point:作業初始化

   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = " SELECT wsca001,''", 
                      " FROM wsca_t",
                      " WHERE wsca001=? FOR UPDATE"
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE awsi200_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.wsca001,t1.gzzal003",
               " FROM wsca_t t0",
                              " LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.wsca001 AND t1.gzzal002='"||g_lang||"' ",
 
               " WHERE t0.wsca001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define

   #end add-point
   PREPARE awsi200_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_awsi200 WITH FORM cl_ap_formpath("aws",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL awsi200_init()   
 
      #進入選單 Menu (="N")
      CALL awsi200_ui_dialog() 
      
      #add-point:畫面關閉前

      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_awsi200
      
   END IF 
   
   CLOSE awsi200_cl
   
   
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
{</section>}
 
{<section id="awsi200.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION awsi200_init()
   #add-point:init段define
   LET g_is_starting = TRUE
   #end add-point
   #add-point:init段define
   
   #end add-point   
  
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('wsca008','202') 
   CALL cl_set_combo_scc('wsca004','175') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化
 
   #end add-point
   
   CALL awsi200_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="awsi200.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION awsi200_ui_dialog()
   DEFINE la_param  RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   #add-point:ui_dialog段define
   
   #end add-point  
   #add-point:ui_dialog段define
   
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
   
   #add-point:ui_dialog段before dialog 
   
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_wsca_m.* TO NULL
         CALL g_wsca_d.clear()
         CALL g_wsca2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL awsi200_init()
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
               CALL awsi200_idx_chk()
               CALL awsi200_fetch('') # reload data
               LET g_detail_idx = 1
               CALL awsi200_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_wsca_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL awsi200_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL awsi200_ui_detailshow()
               
               #add-point:page1自定義行為
               
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
               
               
            
 
            #add-point:page1自定義行為
 
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_wsca2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL awsi200_idx_chk()
               CALL awsi200_ui_detailshow()
               
               #add-point:page1自定義行為
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 2
            
            
         
            #add-point:page2自定義行為
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL awsi200_browser_fill("")
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
               CALL awsi200_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL awsi200_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL awsi200_query()
               #add-point:ON ACTION query

               #END add-point
               #應用 a59 樣板自動產生(Version:2)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
               #顯示查詢方案畫面
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
               CALL cl_notice()

               
               LET g_is_starting = FALSE 
                
            END IF
            #end add-point
 
         #應用 a49 樣板自動產生(Version:2)
            #過濾瀏覽頁資料
            ON ACTION filter
               #add-point:filter action
               
               #end add-point
               CALL awsi200_filter()
               EXIT DIALOG
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL awsi200_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL awsi200_idx_chk()
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL awsi200_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL awsi200_idx_chk()
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL awsi200_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL awsi200_idx_chk()
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL awsi200_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL awsi200_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL awsi200_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL awsi200_idx_chk()
            
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
                  LET g_export_node[1] = base.typeInfo.create(g_wsca_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_wsca2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel
                  
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
               NEXT FIELD wsca007
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
               CALL awsi200_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL awsi200_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL awsi200_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL awsi200_modify()
               #add-point:ON ACTION modify
               
               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL awsi200_modify()
               #add-point:ON ACTION modify_detail
               
               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL awsi200_delete()
               #add-point:ON ACTION delete
               
               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL awsi200_insert()
               #add-point:ON ACTION insert
               
               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               
               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL awsi200_reproduce()
               #add-point:ON ACTION reproduce
               
               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL awsi200_query()
               #add-point:ON ACTION query
               
               #END add-point
               #應用 a59 樣板自動產生(Version:2)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
            END IF
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:2)
         #新增相關文件
         ON ACTION related_document
            CALL awsi200_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL awsi200_set_pk_array()
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL awsi200_set_pk_array()
            #add-point:ON ACTION followup
            
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
 
{<section id="awsi200.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION awsi200_browser_search(p_type)
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define
   
   #end add-point
   #add-point:browser_search段define
   
   #end add-point   
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="awsi200.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION awsi200_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define

   #end add-point
   #add-point:browser_fill段define

   #end add-point   
   
   #add-point:browser_fill段動作開始前

   #end add-point    
 
   LET l_searchcol = "wsca001"
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
      LET l_sub_sql = " SELECT UNIQUE wsca001 ",
 
                      " FROM wsca_t ",
                      " ",
                      " LEFT JOIN wscal_t ON wsca001 = wscal001 AND wsca007 = wscal007 AND wscal008 = '",g_dlang,"' "," ",
 
                      " WHERE ",l_wc, " AND ", l_wc2, cl_sql_add_filter("wsca_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE wsca001 ",
 
                      " FROM wsca_t ",
                      " ",
                      " LEFT JOIN wscal_t ON wsca001 = wscal001 AND wsca007 = wscal007 AND wscal008 = '",g_dlang,"' "," ",
                      " WHERE ",l_wc CLIPPED, cl_sql_add_filter("wsca_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前

   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
   
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
      INITIALIZE g_wsca_m.* TO NULL
      CALL g_wsca_d.clear()        
      CALL g_wsca2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.wsca001 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.wsca001,t1.gzzal003",
                " FROM wsca_t t0",
                " ",
                " LEFT JOIN wscal_t ON wsca001 = wscal001 AND wsca007 = wscal007 AND wscal008 = '",g_dlang,"' ",
 
                               " LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.wsca001 AND t1.gzzal002='"||g_lang||"' ",
 
                " WHERE ", l_wc," AND ",l_wc2, cl_sql_add_filter("wsca_t")
 
   #add-point:browser_fill,sql_rank前

   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前

   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"wsca_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   FOREACH browse_cur INTO g_browser[g_cnt].b_wsca001,g_browser[g_cnt].b_wsca001_desc 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'Foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference

      #end add-point  
 
      #遮罩相關處理
      CALL awsi200_browser_mask()
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_browse THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_wsca001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_wsca_m.* TO NULL
      CALL g_wsca_d.clear()
      CALL g_wsca2_d.clear()
 
      #add-point:browser_fill段after_clear

      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL awsi200_fetch('')
   
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
   
   FREE browse_pre
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   #add-point:browser_fill段結束前

   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION awsi200_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point  
   #add-point:ui_headershow段define
   
   #end add-point    
   
   LET g_wsca_m.wsca001 = g_browser[g_current_idx].b_wsca001   
 
   EXECUTE awsi200_master_referesh USING g_wsca_m.wsca001 INTO g_wsca_m.wsca001,g_wsca_m.wsca001_desc 
 
   CALL awsi200_show()
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION awsi200_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   #add-point:ui_detailshow段define
   
   #end add-point
   
   #add-point:ui_detailshow段before
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
      #add-point:ui_detailshow段more
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION awsi200_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point 
   #add-point:ui_browser_refresh段define
   
   #end add-point   
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_wsca001 = g_wsca_m.wsca001 
 
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
 
{<section id="awsi200.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION awsi200_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define
   
   #end add-point 
    #add-point:cs段define
   
   #end add-point    
 
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_wsca_m.* TO NULL
   CALL g_wsca_d.clear()
   CALL g_wsca2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外
   IF g_is_starting = TRUE THEN
      LET g_wc = "1=1"
      LET g_wc2_table1 = "1=1"
   ELSE
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON wsca001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
                 #Ctrlp:construct.c.wsca001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wsca001
            #add-point:ON ACTION controlp INFIELD wsca001
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_gzzd001()                           #呼叫開窗
            CALL q_gzzz001_1()                     #呼叫開窗      
            DISPLAY g_qryparam.return1 TO wsca001  #顯示到畫面上
            NEXT FIELD wsca001                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wsca001
            #add-point:BEFORE FIELD wsca001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wsca001
            
            #add-point:AFTER FIELD wsca001
            
            #END add-point
            
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON wsca007,wsca008,wsca002,wsca005,wsca004,wscastus,wscaownid,wscaowndp, 
          wscacrtid,wscacrtdp,wscacrtdt,wscamodid,wscamoddt
           FROM s_detail1[1].wsca007,s_detail1[1].wsca008,s_detail1[1].wsca002,s_detail1[1].wsca005, 
               s_detail1[1].wsca004,s_detail1[1].wscastus,s_detail2[1].wscaownid,s_detail2[1].wscaowndp, 
               s_detail2[1].wscacrtid,s_detail2[1].wscacrtdp,s_detail2[1].wscacrtdt,s_detail2[1].wscamodid, 
               s_detail2[1].wscamoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:2)
         #共用欄位查詢處理  
         ##----<<wscacrtdt>>----
         AFTER FIELD wscacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<wscamoddt>>----
         AFTER FIELD wscamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<wscacnfdt>>----
         
         #----<<wscapstdt>>----
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wsca007
            #add-point:BEFORE FIELD wsca007
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wsca007
            
            #add-point:AFTER FIELD wsca007
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.wsca007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wsca007
            #add-point:ON ACTION controlp INFIELD wsca007
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wsca008
            #add-point:BEFORE FIELD wsca008
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wsca008
            
            #add-point:AFTER FIELD wsca008
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.wsca008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wsca008
            #add-point:ON ACTION controlp INFIELD wsca008
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wsca002
            #add-point:BEFORE FIELD wsca002
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wsca002
            
            #add-point:AFTER FIELD wsca002
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.wsca002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wsca002
            #add-point:ON ACTION controlp INFIELD wsca002
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wsca005
            #add-point:BEFORE FIELD wsca005
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wsca005
            
            #add-point:AFTER FIELD wsca005
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.wsca005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wsca005
            #add-point:ON ACTION controlp INFIELD wsca005
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wsca004
            #add-point:BEFORE FIELD wsca004
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wsca004
            
            #add-point:AFTER FIELD wsca004
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.wsca004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wsca004
            #add-point:ON ACTION controlp INFIELD wsca004
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wscastus
            #add-point:BEFORE FIELD wscastus
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wscastus
            
            #add-point:AFTER FIELD wscastus
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.wscastus
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wscastus
            #add-point:ON ACTION controlp INFIELD wscastus
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wscaownid
            #add-point:BEFORE FIELD wscaownid
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wscaownid
            
            #add-point:AFTER FIELD wscaownid
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.wscaownid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wscaownid
            #add-point:ON ACTION controlp INFIELD wscaownid
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wscaowndp
            #add-point:BEFORE FIELD wscaowndp
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wscaowndp
            
            #add-point:AFTER FIELD wscaowndp
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.wscaowndp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wscaowndp
            #add-point:ON ACTION controlp INFIELD wscaowndp
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wscacrtid
            #add-point:BEFORE FIELD wscacrtid
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wscacrtid
            
            #add-point:AFTER FIELD wscacrtid
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.wscacrtid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wscacrtid
            #add-point:ON ACTION controlp INFIELD wscacrtid
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wscacrtdp
            #add-point:BEFORE FIELD wscacrtdp
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wscacrtdp
            
            #add-point:AFTER FIELD wscacrtdp
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.wscacrtdp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wscacrtdp
            #add-point:ON ACTION controlp INFIELD wscacrtdp
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wscacrtdt
            #add-point:BEFORE FIELD wscacrtdt
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wscamodid
            #add-point:BEFORE FIELD wscamodid
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wscamodid
            
            #add-point:AFTER FIELD wscamodid
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.wscamodid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wscamodid
            #add-point:ON ACTION controlp INFIELD wscamodid
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wscamoddt
            #add-point:BEFORE FIELD wscamoddt
            
            #END add-point
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog
         
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
   
   #add-point:cs段after_construct
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
 
{<section id="awsi200.filter" >}
#應用 a50 樣板自動產生(Version:5)
#+ filter過濾功能
PRIVATE FUNCTION awsi200_filter()
   #add-point:filter段define
   
   #end add-point   
   #add-point:filter段define
   
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
      CONSTRUCT g_wc_filter ON wsca001
                          FROM s_browse[1].b_wsca001
 
         BEFORE CONSTRUCT
               DISPLAY awsi200_filter_parser('wsca001') TO s_browse[1].b_wsca001
      
         #add-point:filter段cs_ctrl
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog
         
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
 
      CALL awsi200_filter_show('wsca001')
 
END FUNCTION
 
{</section>}
 
{<section id="awsi200.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION awsi200_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define
   
   #end add-point    
   #add-point:filter段define
   
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
 
{<section id="awsi200.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION awsi200_filter_show(ps_field)
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
   LET ls_condition = awsi200_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="awsi200.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION awsi200_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
   #end add-point
   #add-point:query段define
   
   #end add-point   
 
   #add-point:query開始前
   
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
   CALL g_wsca_d.clear()
   CALL g_wsca2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL awsi200_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL awsi200_browser_fill(g_wc)
      CALL awsi200_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL awsi200_browser_fill("F")
   
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
      CALL awsi200_fetch("F") 
   END IF
   
   CALL awsi200_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION awsi200_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
   
   #end add-point
   #add-point:fetch段define
   
   #end add-point   
   
   #add-point:fetch段動作開始前
   
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
   
   LET g_wsca_m.wsca001 = g_browser[g_current_idx].b_wsca001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE awsi200_master_referesh USING g_wsca_m.wsca001 INTO g_wsca_m.wsca001,g_wsca_m.wsca001_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "wsca_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_wsca_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_wsca_m_mask_o.* =  g_wsca_m.*
   CALL awsi200_wsca_t_mask()
   LET g_wsca_m_mask_n.* =  g_wsca_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL awsi200_set_act_visible()
   CALL awsi200_set_act_no_visible()
 
   #保存單頭舊值
   LET g_wsca_m_t.* = g_wsca_m.*
   LET g_wsca_m_o.* = g_wsca_m.*
   
   #重新顯示   
   CALL awsi200_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="awsi200.insert" >}
#+ 資料新增
PRIVATE FUNCTION awsi200_insert()
   #add-point:insert段define

   #end add-point
   #add-point:insert段define

   #end add-point   
   
   #add-point:insert段before

   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_wsca_d.clear()
   CALL g_wsca2_d.clear()
 
 
   INITIALIZE g_wsca_m.* LIKE wsca_t.*             #DEFAULT 設定
   LET g_wsca001_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值

      #end add-point 
 
      CALL awsi200_input("a")
      
      #add-point:單頭輸入後

      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         LET INT_FLAG = 0
         LET g_wsca_m.* = g_wsca_m_t.*
         CALL awsi200_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_wsca_m.* TO NULL
         INITIALIZE g_wsca_d TO NULL
         INITIALIZE g_wsca2_d TO NULL
 
         CALL awsi200_show()
         RETURN
      END IF
    
      #CALL g_wsca_d.clear()
      #CALL g_wsca2_d.clear()
 
      
      #add-point:單頭輸入後2

      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL awsi200_set_act_visible()
   CALL awsi200_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_wsca001_t = g_wsca_m.wsca001
 
   
   #組合新增資料的條件
   LET g_add_browse = " wsca001 = '", g_wsca_m.wsca001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL awsi200_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL awsi200_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE awsi200_master_referesh USING g_wsca_m.wsca001 INTO g_wsca_m.wsca001,g_wsca_m.wsca001_desc 
 
   
   #遮罩相關處理
   LET g_wsca_m_mask_o.* =  g_wsca_m.*
   CALL awsi200_wsca_t_mask()
   LET g_wsca_m_mask_n.* =  g_wsca_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_wsca_m.wsca001,g_wsca_m.wsca001_desc,g_wsca_d[l_ac].wscal009
   
   #功能已完成,通報訊息中心
   CALL awsi200_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.modify" >}
#+ 資料修改
PRIVATE FUNCTION awsi200_modify()
   #add-point:modify段define

   #end add-point  
   #add-point:modify段define

   #end add-point    
   
   IF g_wsca_m.wsca001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_wsca001_t = g_wsca_m.wsca001
 
   CALL s_transaction_begin()
   
   OPEN awsi200_cl USING g_wsca_m.wsca001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN awsi200_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE awsi200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE awsi200_master_referesh USING g_wsca_m.wsca001 INTO g_wsca_m.wsca001,g_wsca_m.wsca001_desc 
 
   
   #遮罩相關處理
   LET g_wsca_m_mask_o.* =  g_wsca_m.*
   CALL awsi200_wsca_t_mask()
   LET g_wsca_m_mask_n.* =  g_wsca_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL awsi200_show()
   
   WHILE TRUE
      LET g_wsca001_t = g_wsca_m.wsca001
 
 
      #add-point:modify段修改前

      #end add-point
      
      CALL awsi200_input("u")     #欄位更改
      
      #add-point:modify段修改後

      #end add-point
       
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_wsca_m.* = g_wsca_m_t.*
         CALL awsi200_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_wsca_m.wsca001 != g_wsca001_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前

         #end add-point
         
         #add-point:單頭(偽)修改中

         #end add-point
         
 
         
         #add-point:單頭(偽)修改後

         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL awsi200_set_act_visible()
   CALL awsi200_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " wsca001 = '", g_wsca_m.wsca001, "' "
 
   #填到對應位置
   CALL awsi200_browser_fill("")
 
   CALL awsi200_idx_chk()
 
   CLOSE awsi200_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL awsi200_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="awsi200.input" >}
#+ 資料輸入
PRIVATE FUNCTION awsi200_input(p_cmd)
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
   #add-point:input段define
   DEFINE  l_max_wsca007         LIKE wsca_t.wsca007
   #end add-point
   #add-point:input段define

   #end add-point   
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_wsca_m.wsca001,g_wsca_m.wsca001_desc
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF  
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = "SELECT wsca007,wsca008,wsca002,wsca005,wsca004,wscastus,wsca007,wscaownid,wscaowndp, 
       wscacrtid,wscacrtdp,wscacrtdt,wscamodid,wscamoddt FROM wsca_t WHERE wsca001=? AND  
       wsca007=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE awsi200_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL awsi200_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL awsi200_set_no_entry(p_cmd)
   #add-point:set_no_entry後

   #end add-point
 
   DISPLAY BY NAME g_wsca_m.wsca001
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前

   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="awsi200.input.head" >}
   
      #單頭段
      INPUT BY NAME g_wsca_m.wsca001 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前

            #end add-point
          
                  #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wsca001
            
            #add-point:AFTER FIELD wsca001
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_wsca_m.wsca001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_wsca_m.wsca001 != g_wsca001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM wsca_t WHERE wsca001 = '"||g_wsca_m.wsca001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_wsca_m.wsca001
            LET g_errshow = TRUE   #160318-00025#14
                  LET g_chkparam.err_str[1] = "aoo-00120:sub-01302|azzi910|",cl_get_progname("azzi910",g_lang,"2"),"|:EXEPROGazzi910"    #160318-00025#14  
            IF NOT cl_chk_exist("v_gzzz001_4") THEN
               NEXT FIELD CURRENT
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wsca001
            #add-point:BEFORE FIELD wsca001

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE wsca001
            #add-point:ON CHANGE wsca001

            #END add-point 
 
 #欄位檢查
                  #Ctrlp:input.c.wsca001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wsca001
            #add-point:ON ACTION controlp INFIELD wsca001
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_wsca_m.wsca001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            #CALL q_gzzd001()                                #呼叫開窗
            CALL q_gzzz001_1()                     #呼叫開窗
            LET g_wsca_m.wsca001 = g_qryparam.return1              

            DISPLAY g_wsca_m.wsca001 TO wsca001              #

            NEXT FIELD wsca001                          #返回原欄位


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
            DISPLAY BY NAME g_wsca_m.wsca001             
 
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前

               #end add-point
            
               #將遮罩欄位還原
               CALL awsi200_wsca_t_mask_restore('restore_mask_o')
            
               UPDATE wsca_t SET (wsca001) = (g_wsca_m.wsca001)
                WHERE wsca001 = g_wsca001_t
 
               #add-point:單頭修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "wsca_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "wsca_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     #資料多語言用-增/改
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_wsca_m.wsca001
               LET gs_keys_bak[1] = g_wsca001_t
               LET gs_keys[2] = g_wsca_d[g_detail_idx].wsca007
               LET gs_keys_bak[2] = g_wsca_d_t.wsca007
               CALL awsi200_update_b('wsca_t',gs_keys,gs_keys_bak,"'1'")
             
                     
 
                     #add-point:單頭修改後

                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_wsca_m_t)
                     #LET g_log2 = util.JSON.stringify(g_wsca_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL awsi200_wsca_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增

               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL awsi200_detail_reproduce()
               END IF
            END IF
 
           LET g_wsca001_t = g_wsca_m.wsca001
 
           
           IF g_wsca_d.getLength() = 0 THEN
              NEXT FIELD wsca007
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="awsi200.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_wsca_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
          ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item
               IF  NOT cl_null(g_wsca_d[l_ac].wsca007) THEN
                  CALL n_wscal(g_wsca_m.wsca001,g_wsca_d[l_ac].wsca007)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_wsca_m.wsca001
                  LET g_ref_fields[2] = g_wsca_d[l_ac].wsca007
                  CALL ap_ref_array2(g_ref_fields," SELECT wscal009 FROM wscal_t WHERE wscal001 = ? AND wscal007 = ? AND wscal008 = '"||g_dlang||"'" ,"") RETURNING g_rtn_fields
                  IF NOT cl_null(g_rtn_fields[1]) THEN
                     LET g_wsca_d[l_ac].wscal009 = g_rtn_fields[1]
                  ELSE
                     CALL ap_ref_array2(g_ref_fields," SELECT wsca002 FROM wsca_t WHERE wsca001 = ? AND wsca007 = ? " ,"") RETURNING g_rtn_fields
                     LET g_wsca_d[l_ac].wscal009 = g_rtn_fields[1]
                  END IF
                  DISPLAY BY NAME g_wsca_d[l_ac].wscal009
               END IF
               #END add-point
            END IF
            
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_wsca_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL awsi200_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row


            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL awsi200_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN awsi200_cl USING g_wsca_m.wsca001                          
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN awsi200_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLOSE awsi200_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_wsca_d[l_ac].wsca007 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_wsca_d_t.* = g_wsca_d[l_ac].*  #BACKUP
               LET g_wsca_d_o.* = g_wsca_d[l_ac].*  #BACKUP
               CALL awsi200_set_entry_b(l_cmd)
               #add-point:set_entry_b後

               #end add-point
               CALL awsi200_set_no_entry_b(l_cmd)
               OPEN awsi200_bcl USING g_wsca_m.wsca001,
 
                                                g_wsca_d_t.wsca007
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN awsi200_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH awsi200_bcl INTO g_wsca_d[l_ac].wsca007,g_wsca_d[l_ac].wsca008,g_wsca_d[l_ac].wsca002, 
                      g_wsca_d[l_ac].wsca005,g_wsca_d[l_ac].wsca004,g_wsca_d[l_ac].wscastus,g_wsca2_d[l_ac].wsca007, 
                      g_wsca2_d[l_ac].wscaownid,g_wsca2_d[l_ac].wscaowndp,g_wsca2_d[l_ac].wscacrtid, 
                      g_wsca2_d[l_ac].wscacrtdp,g_wsca2_d[l_ac].wscacrtdt,g_wsca2_d[l_ac].wscamodid, 
                      g_wsca2_d[l_ac].wscamoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_wsca_d_t.wsca007 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_wsca_d_mask_o[l_ac].* =  g_wsca_d[l_ac].*
                  CALL awsi200_wsca_t_mask()
                  LET g_wsca_d_mask_n[l_ac].* =  g_wsca_d[l_ac].*
                  
                  CALL awsi200_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point
            #其他table資料備份(確定是否更改用)
LET g_detail_multi_table_t.wscal001 = g_wsca_m.wsca001            
LET g_detail_multi_table_t.wscal007 = g_wsca_d[l_ac].wsca007
LET g_detail_multi_table_t.wscal008 = g_dlang
LET g_detail_multi_table_t.wscal009 = g_wsca_d[l_ac].wscal009
            
            #其他table進行lock
                        INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'wscal007'
            LET l_var_keys[01] = g_wsca_d[l_ac].wsca007
            LET l_field_keys[02] = 'wscal008'
            LET l_var_keys[02] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'wscal_t') THEN
               RETURN 
            END IF 
        
         BEFORE INSERT
            
            INITIALIZE g_wsca_d_t.* TO NULL
            INITIALIZE g_wsca_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_wsca_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:4)    
      #公用欄位新增給值  
      LET g_wsca2_d[l_ac].wscaownid = g_user
      LET g_wsca2_d[l_ac].wscaowndp = g_dept
      LET g_wsca2_d[l_ac].wscacrtid = g_user
      LET g_wsca2_d[l_ac].wscacrtdp = g_dept 
      LET g_wsca2_d[l_ac].wscacrtdt = cl_get_current()
      LET g_wsca2_d[l_ac].wscamodid = g_user
      LET g_wsca2_d[l_ac].wscamoddt = cl_get_current()
      LET g_wsca_d[l_ac].wscastus = ''
 
  
            #一般欄位預設值
                  LET g_wsca_d[l_ac].wsca007 = "0"
      LET g_wsca_d[l_ac].wsca008 = "1"
      LET g_wsca_d[l_ac].wsca004 = "1"
      LET g_wsca_d[l_ac].wscastus = "Y"
 
            
            #add-point:modify段before備份
            

            
            #end add-point
            LET g_wsca_d_t.* = g_wsca_d[l_ac].*     #新輸入資料
            LET g_wsca_d_o.* = g_wsca_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL awsi200_set_entry_b(l_cmd)
            #add-point:set_entry_b後

            #end add-point
            CALL awsi200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_wsca_d[li_reproduce_target].* = g_wsca_d[li_reproduce].*
               LET g_wsca2_d[li_reproduce_target].* = g_wsca2_d[li_reproduce].*
 
               LET g_wsca_d[g_wsca_d.getLength()].wsca007 = NULL
 
            END IF
            LET g_detail_multi_table_t.wscal001 = g_wsca_m.wsca001
LET g_detail_multi_table_t.wscal007 = g_wsca_d[l_ac].wsca007
LET g_detail_multi_table_t.wscal008 = g_dlang
LET g_detail_multi_table_t.wscal009 = g_wsca_d[l_ac].wscal009
 
            #add-point:modify段before insert

            SELECT MAX(wsca007) INTO l_max_wsca007 FROM wsca_t WHERE wsca001=g_wsca_m.wsca001        

            IF cl_null(l_max_wsca007) THEN
               LET l_max_wsca007 = 0
            END IF
            
            LET l_max_wsca007 = l_max_wsca007 + 1
            
            #MESSAGE "l_max_wsca007 =",l_max_wsca007
            
            LET g_wsca_d[l_ac].wsca007 = l_max_wsca007
            
            DISPLAY g_wsca_d[l_ac].wsca007 TO s_detail1[l_ac].wsca007
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
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM wsca_t 
             WHERE wsca001 = g_wsca_m.wsca001
 
               AND wsca007 = g_wsca_d[l_ac].wsca007
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前

               #end add-point
               INSERT INTO wsca_t
                           (wsca001,
                            wsca007
                            ,wsca008,wsca002,wsca005,wsca004,wscastus,wscaownid,wscaowndp,wscacrtid,wscacrtdp,wscacrtdt,wscamodid,wscamoddt) 
                     VALUES(g_wsca_m.wsca001,
                            g_wsca_d[l_ac].wsca007
                            ,g_wsca_d[l_ac].wsca008,g_wsca_d[l_ac].wsca002,g_wsca_d[l_ac].wsca005,g_wsca_d[l_ac].wsca004, 
                                g_wsca_d[l_ac].wscastus,g_wsca2_d[l_ac].wscaownid,g_wsca2_d[l_ac].wscaowndp, 
                                g_wsca2_d[l_ac].wscacrtid,g_wsca2_d[l_ac].wscacrtdp,g_wsca2_d[l_ac].wscacrtdt, 
                                g_wsca2_d[l_ac].wscamodid,g_wsca2_d[l_ac].wscamoddt)
               #add-point:單身新增中

               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_wsca_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "wsca_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
            #資料多語言用-增/改
            
         
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後

            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前

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
               IF awsi200_before_delete() THEN 
                  
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE awsi200_bcl
               LET l_count = g_wsca_d.getLength()
            END IF 
            
            #add-point:單身刪除後

            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_wsca_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wsca007
            #add-point:BEFORE FIELD wsca007
 
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wsca007
            
            #add-point:AFTER FIELD wsca007
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_wsca_m.wsca001 IS NOT NULL AND g_wsca_d[g_detail_idx].wsca007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_wsca_m.wsca001 != g_wsca001_t OR g_wsca_d[g_detail_idx].wsca007 != g_wsca_d_t.wsca007)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM wsca_t WHERE wsca001 = '"||g_wsca_m.wsca001 ||"' AND "|| "wsca007 = '"||g_wsca_d[g_detail_idx].wsca007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE wsca007
            #add-point:ON CHANGE wsca007

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wsca008
            #add-point:BEFORE FIELD wsca008

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wsca008
            
            #add-point:AFTER FIELD wsca008

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE wsca008
            #add-point:ON CHANGE wsca008

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wsca002
            #add-point:BEFORE FIELD wsca002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wsca002
            
            #add-point:AFTER FIELD wsca002

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE wsca002
            #add-point:ON CHANGE wsca002

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wsca005
            #add-point:BEFORE FIELD wsca005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wsca005
            
            #add-point:AFTER FIELD wsca005

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE wsca005
            #add-point:ON CHANGE wsca005

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wsca004
            #add-point:BEFORE FIELD wsca004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wsca004
            
            #add-point:AFTER FIELD wsca004

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE wsca004
            #add-point:ON CHANGE wsca004

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wscastus
            #add-point:BEFORE FIELD wscastus

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wscastus
            
            #add-point:AFTER FIELD wscastus

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE wscastus
            #add-point:ON CHANGE wscastus

            #END add-point 
 
 
                  #Ctrlp:input.c.page1.wsca007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wsca007
            #add-point:ON ACTION controlp INFIELD wsca007

            #END add-point
 
         #Ctrlp:input.c.page1.wsca008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wsca008
            #add-point:ON ACTION controlp INFIELD wsca008

            #END add-point
 
         #Ctrlp:input.c.page1.wsca002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wsca002
            #add-point:ON ACTION controlp INFIELD wsca002
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段


            CALL s_awsi200_etl_window("","") RETURNING g_wsca_d[l_ac].wsca002,g_wsca_d[l_ac].wsca005
            
            DISPLAY g_wsca_d[l_ac].wsca002 TO wsca002
            #DISPLAY g_wsca_d[l_ac].wsca005 TO wsca005
            #將ETL JOB 名稱回寫到說明欄位
            LET g_wsca_d[l_ac].wscal009 = g_wsca_d[l_ac].wsca005
            DISPLAY BY NAME g_wsca_d[l_ac].wscal009
            
            NEXT FIELD wsca002                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.wsca005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wsca005
            #add-point:ON ACTION controlp INFIELD wsca005
             
            #END add-point
 
         #Ctrlp:input.c.page1.wsca004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wsca004
            #add-point:ON ACTION controlp INFIELD wsca004

            #END add-point
 
         #Ctrlp:input.c.page1.wscastus
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wscastus
            #add-point:ON ACTION controlp INFIELD wscastus

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_wsca_d[l_ac].* = g_wsca_d_t.*
               CLOSE awsi200_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_wsca_d[l_ac].wsca007 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_wsca_d[l_ac].* = g_wsca_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_wsca2_d[l_ac].wscamodid = g_user 
LET g_wsca2_d[l_ac].wscamoddt = cl_get_current()
LET g_wsca2_d[l_ac].wscamodid_desc = cl_get_username(g_wsca2_d[l_ac].wscamodid)
            
               #add-point:單身修改前

               #end add-point
         
               #將遮罩欄位還原
               CALL awsi200_wsca_t_mask_restore('restore_mask_o')
         
               UPDATE wsca_t SET (wsca001,wsca007,wsca008,wsca002,wsca005,wsca004,wscastus,wscaownid, 
                   wscaowndp,wscacrtid,wscacrtdp,wscacrtdt,wscamodid,wscamoddt) = (g_wsca_m.wsca001, 
                   g_wsca_d[l_ac].wsca007,g_wsca_d[l_ac].wsca008,g_wsca_d[l_ac].wsca002,g_wsca_d[l_ac].wsca005, 
                   g_wsca_d[l_ac].wsca004,g_wsca_d[l_ac].wscastus,g_wsca2_d[l_ac].wscaownid,g_wsca2_d[l_ac].wscaowndp, 
                   g_wsca2_d[l_ac].wscacrtid,g_wsca2_d[l_ac].wscacrtdp,g_wsca2_d[l_ac].wscacrtdt,g_wsca2_d[l_ac].wscamodid, 
                   g_wsca2_d[l_ac].wscamoddt)
                WHERE wsca001 = g_wsca_m.wsca001 
 
                 AND wsca007 = g_wsca_d_t.wsca007 #項次   
 
                 
               #add-point:單身修改中

               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "wsca_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "wsca_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_wsca_m.wsca001
               LET gs_keys_bak[1] = g_wsca001_t
               LET gs_keys[2] = g_wsca_d[g_detail_idx].wsca007
               LET gs_keys_bak[2] = g_wsca_d_t.wsca007
               CALL awsi200_update_b('wsca_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
         INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_wsca_m.wsca001 = g_detail_multi_table_t.wscal001 AND
         g_wsca_d[l_ac].wsca007 = g_detail_multi_table_t.wscal007 AND
         g_wsca_d[l_ac].wscal009 = g_detail_multi_table_t.wscal009 THEN
         ELSE 
            LET l_var_keys[01] = g_wsca_m.wsca001
            LET l_field_keys[01] = 'wscal001'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.wscal001
            LET l_var_keys[02] = g_wsca_d[l_ac].wsca007
            LET l_field_keys[02] = 'wscal007'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.wscal007
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'wscal008'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.wscal008
            LET l_vars[01] = g_wsca_d[l_ac].wscal009
            LET l_fields[01] = 'wscal009'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'wscal_t')
         END IF 
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_wsca_m),util.JSON.stringify(g_wsca_d_t)
                     LET g_log2 = util.JSON.stringify(g_wsca_m),util.JSON.stringify(g_wsca_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL awsi200_wsca_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_wsca_m.wsca001
 
               LET ls_keys[ls_keys.getLength()+1] = g_wsca_d_t.wsca007
 
               CALL awsi200_key_update_b(ls_keys)
               
               #add-point:單身修改後

               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row

            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_wsca_d[l_ac].* = g_wsca_d_t.*
               END IF
               CLOSE awsi200_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
 
            CLOSE awsi200_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_wsca_d.getLength() = 0 THEN
               NEXT FIELD wsca007
            END IF
            #add-point:input段after input 

            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_wsca_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_wsca_d.getLength()+1
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_wsca2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL awsi200_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL awsi200_idx_chk()
            CALL awsi200_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為

         #end add-point
         
      END DISPLAY
 
      
 
      
 
    
      #add-point:input段more_input

      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog

         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD wsca001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD wsca007
               WHEN "s_detail2"
                  NEXT FIELD wsca007_2
 
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
 
 
   
   #add-point:input段after_input

   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION awsi200_show()
   #add-point:show段define

   #end add-point
   #add-point:show段define

   #end add-point
   
   #add-point:show段之前

   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL awsi200_b_fill(g_wc2) #第一階單身填充
      CALL awsi200_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:2)
   CALL awsi200_set_pk_array()
   #add-point:ON ACTION agendum

   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
   
   DISPLAY BY NAME g_wsca_m.wsca001,g_wsca_m.wsca001_desc
 
   CALL awsi200_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後

   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION awsi200_ref_show()
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define
   
   #end add-point
   #add-point:ref_show段define
   
   #end add-point 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference
   
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_wsca_d.getLength()
      #add-point:ref_show段d_reference
      INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_wsca_m.wsca001
   LET g_ref_fields[2] = g_wsca_d[l_ac].wsca007
   CALL ap_ref_array2(g_ref_fields," SELECT wscal009 FROM wscal_t WHERE wscal001 = ? AND wscal007 = ? AND wscal008 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_wsca_d[l_ac].wscal009 = g_rtn_fields[1] 
   DISPLAY BY NAME g_wsca_d[l_ac].wscal009
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_wsca2_d.getLength()
      #add-point:ref_show段d2_reference
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="awsi200.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION awsi200_reproduce()
   DEFINE l_newno     LIKE wsca_t.wsca001 
   DEFINE l_oldno     LIKE wsca_t.wsca001 
 
   DEFINE l_master    RECORD LIKE wsca_t.*
   DEFINE l_detail    RECORD LIKE wsca_t.*
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define

   #end add-point
   #add-point:reproduce段define

   #end add-point
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_wsca_m.wsca001 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_wsca001_t = g_wsca_m.wsca001
 
   
   LET g_wsca_m.wsca001 = ""
 
   LET g_master_insert = FALSE
   CALL awsi200_set_entry('a')
   CALL awsi200_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前

   #end add-point
   
   #清空key欄位的desc
      LET g_wsca_m.wsca001_desc = ''
   DISPLAY BY NAME g_wsca_m.wsca001_desc
 
   
   CALL awsi200_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_wsca_m.* TO NULL
      INITIALIZE g_wsca_d TO NULL
      INITIALIZE g_wsca2_d TO NULL
 
      CALL awsi200_show()
      LET INT_FLAG = 0
      RETURN 
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL awsi200_set_act_visible()
   CALL awsi200_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_wsca001_t = g_wsca_m.wsca001
 
   
   #組合新增資料的條件
   LET g_add_browse = " wsca001 = '", g_wsca_m.wsca001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL awsi200_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL awsi200_idx_chk()
   
   #add-point:完成複製段落後

   #end add-point
   
   #功能已完成,通報訊息中心
   CALL awsi200_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION awsi200_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE wsca_t.*
 
 
   #add-point:delete段define

   #end add-point    
   #add-point:delete段define

   #end add-point 
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE awsi200_detail
   
   #add-point:單身複製前1

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE awsi200_detail AS ",
                "SELECT * FROM wsca_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO awsi200_detail SELECT * FROM wsca_t 
                                         WHERE wsca001 = g_wsca001_t
 
   
   #將key修正為調整後   
   UPDATE awsi200_detail 
      #更新key欄位
      SET wsca001 = g_wsca_m.wsca001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:3)
       , wscaownid = g_user 
       , wscaowndp = g_dept
       , wscacrtid = g_user
       , wscacrtdp = g_dept 
       , wscacrtdt = ld_date
       , wscamodid = g_user
       , wscamoddt = ld_date
      #, wscastus = "Y" 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO wsca_t SELECT * FROM awsi200_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE awsi200_detail
   
   #add-point:單身複製後1

   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_wsca001_t = g_wsca_m.wsca001
 
   
   DROP TABLE awsi200_detail
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.delete" >}
#+ 資料刪除
PRIVATE FUNCTION awsi200_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point     
   #add-point:delete段define

   #end add-point
   
   IF g_wsca_m.wsca001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN awsi200_cl USING g_wsca_m.wsca001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN awsi200_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE awsi200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE awsi200_master_referesh USING g_wsca_m.wsca001 INTO g_wsca_m.wsca001,g_wsca_m.wsca001_desc 
 
   
   #遮罩相關處理
   LET g_wsca_m_mask_o.* =  g_wsca_m.*
   CALL awsi200_wsca_t_mask()
   LET g_wsca_m_mask_n.* =  g_wsca_m.*
   
   CALL awsi200_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL awsi200_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
  
 
      #add-point:單身刪除前

      #end add-point
      
      DELETE FROM wsca_t WHERE wsca001 = g_wsca_m.wsca001
 
                                                               
      #add-point:單身刪除中

      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "wsca_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         LET g_detail_cnt = g_detail_cnt-1
         
         LET g_detail_multi_table_t.wscal001 = g_wsca_m.wsca001
         LET g_detail_multi_table_t.wscal007 = g_wsca_d[l_ac].wsca007
LET g_detail_multi_table_t.wscal008 = g_dlang
LET g_detail_multi_table_t.wscal009 = g_wsca_d[l_ac].wscal009
 
 
 
         INITIALIZE l_var_keys_bak TO NULL 
         INITIALIZE l_field_keys TO NULL 
         LET l_field_keys[01] = 'wscal001'
         LET l_var_keys_bak[01] = g_detail_multi_table_t.wscal001
         CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'wscal_t')
 
 
      END IF
      
  
      #add-point:單身刪除後 

      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除

      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE awsi200_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_wsca_d.clear() 
      CALL g_wsca2_d.clear()       
 
     
      CALL awsi200_ui_browser_refresh()  
      #CALL awsi200_ui_headershow()  
      #CALL awsi200_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL awsi200_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL awsi200_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE awsi200_cl
 
   #功能已完成,通報訊息中心
   CALL awsi200_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="awsi200.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION awsi200_b_fill(p_wc2)
   DEFINE p_wc2      STRING
   #add-point:b_fill段define

   #end add-point     
   #add-point:b_fill段define

   #end add-point
   
   #先清空單身變數內容
   CALL g_wsca_d.clear()
   CALL g_wsca2_d.clear()
 
 
   #add-point:b_fill段sql_before

   #end add-point
   
   LET g_sql = "SELECT  UNIQUE wsca007,wsca008,wsca002,wsca005,wsca004,wscastus,wsca007,wscaownid,wscaowndp, 
       wscacrtid,wscacrtdp,wscacrtdt,wscamodid,wscamoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 , 
       t5.ooag011 FROM wsca_t",   
               "",
               " LEFT JOIN wscal_t ON wsca001 = wscal001 AND wsca007 = wscal007 AND wscal008 = '",g_dlang,"'",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent='"||g_enterprise||"' AND t1.ooag001=wscaownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=wscaowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=wscacrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=wscacrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent='"||g_enterprise||"' AND t5.ooag001=wscamodid  ",
 
               " WHERE wsca001=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("wsca_t")
   END IF
   
   #add-point:b_fill段sql_after

   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF awsi200_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = g_sql, " ORDER BY wsca_t.wsca007"
         #add-point:b_fill段fill_before

         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE awsi200_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR awsi200_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_wsca_m.wsca001
                                               
      FOREACH b_fill_cs INTO g_wsca_d[l_ac].wsca007,g_wsca_d[l_ac].wsca008,g_wsca_d[l_ac].wsca002,g_wsca_d[l_ac].wsca005, 
          g_wsca_d[l_ac].wsca004,g_wsca_d[l_ac].wscastus,g_wsca2_d[l_ac].wsca007,g_wsca2_d[l_ac].wscaownid, 
          g_wsca2_d[l_ac].wscaowndp,g_wsca2_d[l_ac].wscacrtid,g_wsca2_d[l_ac].wscacrtdp,g_wsca2_d[l_ac].wscacrtdt, 
          g_wsca2_d[l_ac].wscamodid,g_wsca2_d[l_ac].wscamoddt,g_wsca2_d[l_ac].wscaownid_desc,g_wsca2_d[l_ac].wscaowndp_desc, 
          g_wsca2_d[l_ac].wscacrtid_desc,g_wsca2_d[l_ac].wscacrtdp_desc,g_wsca2_d[l_ac].wscamodid_desc 
 
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充

         #end add-point
      
         #帶出公用欄位reference值
         
         
         #應用 a12 樣板自動產生(Version:3)
 
 
 
        
         #add-point:單身資料抓取

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
 
            CALL g_wsca_d.deleteElement(g_wsca_d.getLength())
      CALL g_wsca2_d.deleteElement(g_wsca2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more

   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_wsca_d.getLength()
      LET g_wsca_d_mask_o[l_ac].* =  g_wsca_d[l_ac].*
      CALL awsi200_wsca_t_mask()
      LET g_wsca_d_mask_n[l_ac].* =  g_wsca_d[l_ac].*
   END FOR
   
   LET g_wsca2_d_mask_o.* =  g_wsca2_d.*
   FOR l_ac = 1 TO g_wsca2_d.getLength()
      LET g_wsca2_d_mask_o[l_ac].* =  g_wsca2_d[l_ac].*
      CALL awsi200_wsca_t_mask()
      LET g_wsca2_d_mask_n[l_ac].* =  g_wsca2_d[l_ac].*
   END FOR
 
 
   FREE awsi200_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION awsi200_idx_chk()
   #add-point:idx_chk段define
   
   #end add-point  
   #add-point:idx_chk段define
   
   #end add-point
   
   #判定目前選擇的頁面
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_wsca_d.getLength() THEN
         LET g_detail_idx = g_wsca_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_wsca_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_wsca_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_wsca2_d.getLength() THEN
         LET g_detail_idx = g_wsca2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_wsca2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_wsca2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION awsi200_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define
   
   #end add-point
   #add-point:b_fill2段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_wsca_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION awsi200_before_delete()
   #add-point:before_delete段define

   #end add-point 
   #add-point:before_delete段define

   #end add-point 
   #add-point:單筆刪除前

   #end add-point
   
   DELETE FROM wsca_t
    WHERE wsca001 = g_wsca_m.wsca001 AND
 
          wsca007 = g_wsca_d_t.wsca007
 
      
   #add-point:單筆刪除中

   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "wsca_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後

   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="awsi200.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION awsi200_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
   #add-point:delete_b段define
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION awsi200_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define
   
   #end add-point     
   #add-point:insert_b段define
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION awsi200_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   #add-point:update_b段define
   
   #end add-point     
   #add-point:update_b段define
   
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
 
{<section id="awsi200.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION awsi200_key_update_b(ps_keys_bak)
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define
   
   #end add-point
   #add-point:update_b段define
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_wsca_d[l_ac].wsca007 = g_wsca_d_t.wsca007 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION awsi200_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   #add-point:lock_b段define
   
   #end add-point
   
   #先刷新資料
   #CALL awsi200_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="awsi200.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION awsi200_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   #add-point:unlock_b段define
   
   #end add-point
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="awsi200.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION awsi200_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
   #add-point:set_entry段define
   
   #end add-point 
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("wsca001",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="awsi200.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION awsi200_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
   #add-point:set_no_entry段define
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("wsca001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="awsi200.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION awsi200_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   #add-point:set_entry_b段define
   
   #end add-point 
   #add-point:set_entry_b段
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION awsi200_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   #add-point:set_no_entry_b段define
   
   #end add-point
   
   #add-point:set_no_entry_b段
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION awsi200_set_act_visible()
   #add-point:set_act_visible段define
   
   #end add-point
   #add-point:set_act_visible段define
   
   #end add-point
   #add-point:set_act_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="awsi200.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION awsi200_set_act_no_visible()
   #add-point:set_act_no_visible段define
   
   #end add-point
   #add-point:set_act_no_visible段define
   
   #end add-point
   #add-point:set_act_no_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="awsi200.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION awsi200_set_act_visible_b()
   #add-point:set_act_visible_b段define
   
   #end add-point
   #add-point:set_act_visible_b段define
   
   #end add-point
   #add-point:set_act_visible_b段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="awsi200.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION awsi200_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define
   
   #end add-point
   #add-point:set_act_no_visible_b段define
   
   #end add-point
   #add-point:set_act_no_visible_b段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="awsi200.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION awsi200_default_search()
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point 
   #add-point:default_search段define
   
   #end add-point    
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " wsca001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql
   
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
   
   #add-point:default_search段結束前
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="awsi200.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION awsi200_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define
   
   #end add-point
   #add-point:fill_chk段define
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
   
   #add-point:fill_chk段other
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="awsi200.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION awsi200_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define
   
   #end add-point
   #add-point:modify_detail_chk段define
   
   #end add-point
   #add-point:modify_detail_chk段開始前
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "wsca007"
      WHEN "s_detail2"
         LET ls_return = "wsca007_2"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="awsi200.mask_functions" >}
&include "erp/aws/awsi200_mask.4gl"
 
{</section>}
 
{<section id="awsi200.state_change" >}
    
 
{</section>}
 
{<section id="awsi200.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:5)
#+ 給予pk_array內容
PRIVATE FUNCTION awsi200_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_wsca_m.wsca001
   LET g_pk_array[1].column = 'wsca001'
 
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="awsi200.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:3)
PRIVATE FUNCTION awsi200_msgcentre_notify(lc_state)
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define
   
   #end add-point
   #add-point:msgcentre_notify段define
   
   #end add-point   
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL awsi200_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_wsca_m)
 
   #add-point:msgcentre其他通知
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="awsi200.other_function" readonly="Y" >}

 
{</section>}
 
