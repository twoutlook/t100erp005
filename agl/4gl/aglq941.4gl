#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq941.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-06-24 14:23:51), PR版次:0001(2016-06-28 21:33:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000022
#+ Filename...: aglq941
#+ Description: 合併現金流量表直接法資料查詢及上傳作業
#+ Creator....: 06821(2016-06-24 11:01:47)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="aglq941.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
 
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
PRIVATE type type_g_glef_m        RECORD
       glefld LIKE glef_t.glefld, 
   glefld_desc LIKE type_t.chr80, 
   glef001 LIKE glef_t.glef001, 
   glef001_desc LIKE type_t.chr80, 
   glef004 LIKE glef_t.glef004, 
   glef005 LIKE glef_t.glef005, 
   glef009 LIKE glef_t.glef009, 
   glef012 LIKE glef_t.glef012, 
   glef015 LIKE glef_t.glef015
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_glef_d        RECORD
       glef006 LIKE glef_t.glef006, 
   glef006_desc LIKE type_t.chr100, 
   l_glef011_1 LIKE type_t.num20_6, 
   l_glef011_2 LIKE type_t.num20_6, 
   l_glef011_3 LIKE type_t.num20_6, 
   l_glef011_4 LIKE type_t.num20_6, 
   l_glef011_5 LIKE type_t.num20_6, 
   l_glef011_6 LIKE type_t.num20_6, 
   l_glef011_7 LIKE type_t.num20_6, 
   l_glef011_8 LIKE type_t.num20_6, 
   l_glef011_9 LIKE type_t.num20_6, 
   l_glef011_10 LIKE type_t.num20_6, 
   l_glef011_11 LIKE type_t.num20_6, 
   l_glef011_12 LIKE type_t.num20_6, 
   l_glef011_13 LIKE type_t.num20_6, 
   l_glef011_14 LIKE type_t.num20_6, 
   l_glef011_15 LIKE type_t.num20_6, 
   l_glef011_16 LIKE type_t.num20_6, 
   l_glef011_17 LIKE type_t.num20_6, 
   l_glef011_18 LIKE type_t.num20_6, 
   l_glef011_19 LIKE type_t.num20_6, 
   l_glef011_20 LIKE type_t.num20_6, 
   l_gleg008 LIKE type_t.num20_6, 
   l_gleh009 LIKE type_t.num20_6, 
   l_sum LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_glef2_d RECORD
       glef006 LIKE glef_t.glef006, 
   glef006_desc_2 LIKE type_t.chr500, 
   l_glef011_1_1 LIKE type_t.num20_6, 
   l_glef011_2_1 LIKE type_t.num20_6, 
   l_glef011_3_1 LIKE type_t.num20_6, 
   l_glef011_4_1 LIKE type_t.num20_6, 
   l_glef011_5_1 LIKE type_t.num20_6, 
   l_glef011_6_1 LIKE type_t.num20_6, 
   l_glef011_7_1 LIKE type_t.num20_6, 
   l_glef011_8_1 LIKE type_t.num20_6, 
   l_glef011_9_1 LIKE type_t.num20_6, 
   l_glef011_10_1 LIKE type_t.num20_6, 
   l_glef011_11_1 LIKE type_t.num20_6, 
   l_glef011_12_1 LIKE type_t.num20_6, 
   l_glef011_13_1 LIKE type_t.num20_6, 
   l_glef011_14_1 LIKE type_t.num20_6, 
   l_glef011_15_1 LIKE type_t.num20_6, 
   l_glef011_16_1 LIKE type_t.num20_6, 
   l_glef011_17_1 LIKE type_t.num20_6, 
   l_glef011_18_1 LIKE type_t.num20_6, 
   l_glef011_19_1 LIKE type_t.num20_6, 
   l_glef011_20_1 LIKE type_t.num20_6, 
   l_gleg010 LIKE type_t.num20_6, 
   l_gleh011 LIKE type_t.num20_6, 
   l_sum_2 LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_glef3_d RECORD
       glef006 LIKE glef_t.glef006, 
   glef006_desc_3 LIKE type_t.chr500, 
   l_glef011_1_2 LIKE type_t.num20_6, 
   l_glef011_2_2 LIKE type_t.num20_6, 
   l_glef011_3_2 LIKE type_t.num20_6, 
   l_glef011_4_2 LIKE type_t.num20_6, 
   l_glef011_5_2 LIKE type_t.num20_6, 
   l_glef011_6_2 LIKE type_t.num20_6, 
   l_glef011_7_2 LIKE type_t.num20_6, 
   l_glef011_8_2 LIKE type_t.num20_6, 
   l_glef011_9_2 LIKE type_t.num20_6, 
   l_glef011_10_2 LIKE type_t.num20_6, 
   l_glef011_11_2 LIKE type_t.num20_6, 
   l_glef011_12_2 LIKE type_t.num20_6, 
   l_glef011_13_2 LIKE type_t.num20_6, 
   l_glef011_14_2 LIKE type_t.num20_6, 
   l_glef011_15_2 LIKE type_t.num20_6, 
   l_glef011_16_2 LIKE type_t.num20_6, 
   l_glef011_17_2 LIKE type_t.num20_6, 
   l_glef011_18_2 LIKE type_t.num20_6, 
   l_glef011_19_2 LIKE type_t.num20_6, 
   l_glef011_20_2 LIKE type_t.num20_6, 
   l_gleg012 LIKE type_t.num20_6, 
   l_gleh013 LIKE type_t.num20_6, 
   l_sum_3 LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_glef_m          type_g_glef_m
DEFINE g_glef_m_t        type_g_glef_m
DEFINE g_glef_m_o        type_g_glef_m
DEFINE g_glef_m_mask_o   type_g_glef_m #轉換遮罩前資料
DEFINE g_glef_m_mask_n   type_g_glef_m #轉換遮罩後資料
 
   DEFINE g_glefld_t LIKE glef_t.glefld
DEFINE g_glef001_t LIKE glef_t.glef001
DEFINE g_glef004_t LIKE glef_t.glef004
DEFINE g_glef005_t LIKE glef_t.glef005
 
 
DEFINE g_glef_d          DYNAMIC ARRAY OF type_g_glef_d
DEFINE g_glef_d_t        type_g_glef_d
DEFINE g_glef_d_o        type_g_glef_d
DEFINE g_glef_d_mask_o   DYNAMIC ARRAY OF type_g_glef_d #轉換遮罩前資料
DEFINE g_glef_d_mask_n   DYNAMIC ARRAY OF type_g_glef_d #轉換遮罩後資料
DEFINE g_glef2_d   DYNAMIC ARRAY OF type_g_glef2_d
DEFINE g_glef2_d_t type_g_glef2_d
DEFINE g_glef2_d_o type_g_glef2_d
DEFINE g_glef2_d_mask_o   DYNAMIC ARRAY OF type_g_glef2_d #轉換遮罩前資料
DEFINE g_glef2_d_mask_n   DYNAMIC ARRAY OF type_g_glef2_d #轉換遮罩後資料
DEFINE g_glef3_d   DYNAMIC ARRAY OF type_g_glef3_d
DEFINE g_glef3_d_t type_g_glef3_d
DEFINE g_glef3_d_o type_g_glef3_d
DEFINE g_glef3_d_mask_o   DYNAMIC ARRAY OF type_g_glef3_d #轉換遮罩前資料
DEFINE g_glef3_d_mask_n   DYNAMIC ARRAY OF type_g_glef3_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_glefld LIKE glef_t.glefld,
      b_glef001 LIKE glef_t.glef001,
      b_glef004 LIKE glef_t.glef004,
      b_glef005 LIKE glef_t.glef005
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
 
{<section id="aglq941.main" >}
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
   CALL cl_ap_init("agl","")
 
   #add-point:作業初始化 name="main.init"
 
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT glefld,'',glef001,'',glef004,glef005,glef009,glef012,glef015", 
                      " FROM glef_t",
                      " WHERE glefent= ? AND glefld=? AND glef001=? AND glef004=? AND glef005=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq941_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.glefld,t0.glef001,t0.glef004,t0.glef005,t0.glef009,t0.glef012,t0.glef015", 
 
               " FROM glef_t t0",
               
               " WHERE t0.glefent = " ||g_enterprise|| " AND t0.glefld = ? AND t0.glef001 = ? AND t0.glef004 = ? AND t0.glef005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq941_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq941 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq941_init()   
 
      #進入選單 Menu (="N")
      CALL aglq941_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq941
      
   END IF 
   
   CLOSE aglq941_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq941.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglq941_init()
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
   
   CALL aglq941_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aglq941.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aglq941_ui_dialog()
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
         INITIALIZE g_glef_m.* TO NULL
         CALL g_glef_d.clear()
         CALL g_glef2_d.clear()
         CALL g_glef3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aglq941_init()
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
               CALL aglq941_idx_chk()
               CALL aglq941_fetch('') # reload data
               LET g_detail_idx = 1
               CALL aglq941_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_glef_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL aglq941_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aglq941_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_glef2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aglq941_idx_chk()
               CALL aglq941_ui_detailshow()
               
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
         DISPLAY ARRAY g_glef3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aglq941_idx_chk()
               CALL aglq941_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body3.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 3
            
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL aglq941_browser_fill("")
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
               CALL aglq941_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aglq941_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
 
               #end add-point
               CALL aglq941_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aglq941_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq941_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aglq941_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq941_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aglq941_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq941_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aglq941_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq941_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aglq941_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq941_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_glef_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_glef2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_glef3_d)
                  LET g_export_id[3]   = "s_detail3"
 
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
               NEXT FIELD glef006
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
               CALL aglq941_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aglq941_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL aglq941_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aglq941_01
            LET g_action_choice="open_aglq941_01"
            IF cl_auth_chk_act("open_aglq941_01") THEN
               
               #add-point:ON ACTION open_aglq941_01 name="menu.open_aglq941_01"
               CALL aglq941_ins_glen()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq941_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aglq941_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aglq941_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aglq941_set_pk_array()
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
 
{<section id="aglq941.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION aglq941_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglq941.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aglq941_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "glefld,glef001,glef004,glef005"
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
      LET l_sub_sql = " SELECT DISTINCT glefld ",
                      ", glef001 ",
                      ", glef004 ",
                      ", glef005 ",
 
                      " FROM glef_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE glefent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("glef_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT glefld ",
                      ", glef001 ",
                      ", glef004 ",
                      ", glef005 ",
 
                      " FROM glef_t ",
                      " ",
                      " ", 
 
 
                      " WHERE glefent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("glef_t")
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
      INITIALIZE g_glef_m.* TO NULL
      CALL g_glef_d.clear()        
      CALL g_glef2_d.clear() 
      CALL g_glef3_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.glefld,t0.glef001,t0.glef004,t0.glef005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.glefld,t0.glef001,t0.glef004,t0.glef005",
                " FROM glef_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.glefent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("glef_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
 
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"glef_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_glefld,g_browser[g_cnt].b_glef001,g_browser[g_cnt].b_glef004, 
          g_browser[g_cnt].b_glef005 
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
         CALL aglq941_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_glefld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_glef_m.* TO NULL
      CALL g_glef_d.clear()
      CALL g_glef2_d.clear()
      CALL g_glef3_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL aglq941_fetch('')
   
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
   CALL cl_set_act_visible("mainhidden", FALSE)
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aglq941_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_glef_m.glefld = g_browser[g_current_idx].b_glefld   
   LET g_glef_m.glef001 = g_browser[g_current_idx].b_glef001   
   LET g_glef_m.glef004 = g_browser[g_current_idx].b_glef004   
   LET g_glef_m.glef005 = g_browser[g_current_idx].b_glef005   
 
   EXECUTE aglq941_master_referesh USING g_glef_m.glefld,g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005 INTO g_glef_m.glefld, 
       g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005,g_glef_m.glef009,g_glef_m.glef012,g_glef_m.glef015 
 
   CALL aglq941_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aglq941_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aglq941_ui_browser_refresh()
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
      IF g_browser[l_i].b_glefld = g_glef_m.glefld 
         AND g_browser[l_i].b_glef001 = g_glef_m.glef001 
         AND g_browser[l_i].b_glef004 = g_glef_m.glef004 
         AND g_browser[l_i].b_glef005 = g_glef_m.glef005 
 
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
 
{<section id="aglq941.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq941_construct()
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
   INITIALIZE g_glef_m.* TO NULL
   CALL g_glef_d.clear()
   CALL g_glef2_d.clear()
   CALL g_glef3_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   CALL aglq941_filter_show2('glef006',FALSE)   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON glefld,glef001,glef004,glef005,glef009,glef012,glef015
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glefld
            #add-point:BEFORE FIELD glefld name="construct.b.glefld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glefld
            
            #add-point:AFTER FIELD glefld name="construct.a.glefld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glefld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glefld
            #add-point:ON ACTION controlp INFIELD glefld name="construct.c.glefld"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL                                                
            LET g_qryparam.state = 'c'                                                     
            LET g_qryparam.reqry = FALSE                                                   
            LET g_qryparam.default1 = g_glef_m.glefld                                     
            LET g_qryparam.arg1 = g_user                                 #人員權限         
            LET g_qryparam.arg2 = g_dept                                 #部門權限         
            LET g_qryparam.where = " glaald IN (SELECT DISTINCT gldbld FROM gldb_t ",              
                                   "             WHERE gldbstus = 'Y' ",                                    
                                   "               AND gldbent = '",g_enterprise,"') "                                               
            CALL q_authorised_ld()                                                         
            DISPLAY g_qryparam.return1 TO glefld                        
            NEXT FIELD glefld
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef001
            #add-point:BEFORE FIELD glef001 name="construct.b.glef001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef001
            
            #add-point:AFTER FIELD glef001 name="construct.a.glef001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glef001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef001
            #add-point:ON ACTION controlp INFIELD glef001 name="construct.c.glef001"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glef_m.glef001
            LET g_qryparam.where = " gldc009 = 'Y' AND gldbstus = 'Y' " 
            CALL q_gldc001()    
            DISPLAY g_qryparam.return1 TO glef001
            NEXT FIELD glef001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef004
            #add-point:BEFORE FIELD glef004 name="construct.b.glef004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef004
            
            #add-point:AFTER FIELD glef004 name="construct.a.glef004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glef004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef004
            #add-point:ON ACTION controlp INFIELD glef004 name="construct.c.glef004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef005
            #add-point:BEFORE FIELD glef005 name="construct.b.glef005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef005
            
            #add-point:AFTER FIELD glef005 name="construct.a.glef005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glef005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef005
            #add-point:ON ACTION controlp INFIELD glef005 name="construct.c.glef005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef009
            #add-point:BEFORE FIELD glef009 name="construct.b.glef009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef009
            
            #add-point:AFTER FIELD glef009 name="construct.a.glef009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glef009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef009
            #add-point:ON ACTION controlp INFIELD glef009 name="construct.c.glef009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO glef009
            NEXT FIELD glef009
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef012
            #add-point:BEFORE FIELD glef012 name="construct.b.glef012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef012
            
            #add-point:AFTER FIELD glef012 name="construct.a.glef012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glef012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef012
            #add-point:ON ACTION controlp INFIELD glef012 name="construct.c.glef012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO glef012
            NEXT FIELD glef012
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef015
            #add-point:BEFORE FIELD glef015 name="construct.b.glef015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef015
            
            #add-point:AFTER FIELD glef015 name="construct.a.glef015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glef015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef015
            #add-point:ON ACTION controlp INFIELD glef015 name="construct.c.glef015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO glef015
            NEXT FIELD glef015
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON glef006
           FROM s_detail1[1].glef006
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef006
            #add-point:BEFORE FIELD glef006 name="construct.b.page1.glef006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef006
            
            #add-point:AFTER FIELD glef006 name="construct.a.page1.glef006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glef006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef006
            #add-point:ON ACTION controlp INFIELD glef006 name="construct.c.page1.glef006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO glef006  #顯示到畫面上
            NEXT FIELD glef006
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         LET l_ac = 1
         LET g_glef_d[1].glef006 = ''
         DISPLAY ARRAY g_glef_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
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
 
{<section id="aglq941.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aglq941_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   CALL aglq941_filter2()
   RETURN
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
      CONSTRUCT g_wc_filter ON glefld,glef001,glef004,glef005
                          FROM s_browse[1].b_glefld,s_browse[1].b_glef001,s_browse[1].b_glef004,s_browse[1].b_glef005 
 
 
         BEFORE CONSTRUCT
               DISPLAY aglq941_filter_parser('glefld') TO s_browse[1].b_glefld
            DISPLAY aglq941_filter_parser('glef001') TO s_browse[1].b_glef001
            DISPLAY aglq941_filter_parser('glef004') TO s_browse[1].b_glef004
            DISPLAY aglq941_filter_parser('glef005') TO s_browse[1].b_glef005
      
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
 
      CALL aglq941_filter_show('glefld')
   CALL aglq941_filter_show('glef001')
   CALL aglq941_filter_show('glef004')
   CALL aglq941_filter_show('glef005')
 
END FUNCTION
 
{</section>}
 
{<section id="aglq941.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq941_filter_parser(ps_field)
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
 
{<section id="aglq941.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aglq941_filter_show(ps_field)
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
   LET ls_condition = aglq941_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq941.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aglq941_query()
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
   CALL g_glef_d.clear()
   CALL g_glef2_d.clear()
   CALL g_glef3_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aglq941_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aglq941_browser_fill(g_wc)
      CALL aglq941_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL aglq941_browser_fill("F")
   
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
      CALL aglq941_fetch("F") 
   END IF
   
   CALL aglq941_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aglq941_fetch(p_flag)
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
   
   LET g_glef_m.glefld = g_browser[g_current_idx].b_glefld
   LET g_glef_m.glef001 = g_browser[g_current_idx].b_glef001
   LET g_glef_m.glef004 = g_browser[g_current_idx].b_glef004
   LET g_glef_m.glef005 = g_browser[g_current_idx].b_glef005
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aglq941_master_referesh USING g_glef_m.glefld,g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005 INTO g_glef_m.glefld, 
       g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005,g_glef_m.glef009,g_glef_m.glef012,g_glef_m.glef015 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "glef_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_glef_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_glef_m_mask_o.* =  g_glef_m.*
   CALL aglq941_glef_t_mask()
   LET g_glef_m_mask_n.* =  g_glef_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglq941_set_act_visible()
   CALL aglq941_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_glef_m_t.* = g_glef_m.*
   LET g_glef_m_o.* = g_glef_m.*
   
   #重新顯示   
   CALL aglq941_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aglq941.insert" >}
#+ 資料新增
PRIVATE FUNCTION aglq941_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_glef_d.clear()
   CALL g_glef2_d.clear()
   CALL g_glef3_d.clear()
 
 
   INITIALIZE g_glef_m.* TO NULL             #DEFAULT 設定
   LET g_glefld_t = NULL
   LET g_glef001_t = NULL
   LET g_glef004_t = NULL
   LET g_glef005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL aglq941_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_glef_m.* TO NULL
         INITIALIZE g_glef_d TO NULL
         INITIALIZE g_glef2_d TO NULL
         INITIALIZE g_glef3_d TO NULL
 
         CALL aglq941_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_glef_m.* = g_glef_m_t.*
         CALL aglq941_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_glef_d.clear()
      #CALL g_glef2_d.clear()
      #CALL g_glef3_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglq941_set_act_visible()
   CALL aglq941_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_glefld_t = g_glef_m.glefld
   LET g_glef001_t = g_glef_m.glef001
   LET g_glef004_t = g_glef_m.glef004
   LET g_glef005_t = g_glef_m.glef005
 
   
   #組合新增資料的條件
   LET g_add_browse = " glefent = " ||g_enterprise|| " AND",
                      " glefld = '", g_glef_m.glefld, "' "
                      ," AND glef001 = '", g_glef_m.glef001, "' "
                      ," AND glef004 = '", g_glef_m.glef004, "' "
                      ," AND glef005 = '", g_glef_m.glef005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglq941_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL aglq941_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aglq941_master_referesh USING g_glef_m.glefld,g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005 INTO g_glef_m.glefld, 
       g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005,g_glef_m.glef009,g_glef_m.glef012,g_glef_m.glef015 
 
   
   #遮罩相關處理
   LET g_glef_m_mask_o.* =  g_glef_m.*
   CALL aglq941_glef_t_mask()
   LET g_glef_m_mask_n.* =  g_glef_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_glef_m.glefld,g_glef_m.glefld_desc,g_glef_m.glef001,g_glef_m.glef001_desc,g_glef_m.glef004, 
       g_glef_m.glef005,g_glef_m.glef009,g_glef_m.glef012,g_glef_m.glef015
   
   #功能已完成,通報訊息中心
   CALL aglq941_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.modify" >}
#+ 資料修改
PRIVATE FUNCTION aglq941_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_glef_m.glefld IS NULL
   OR g_glef_m.glef001 IS NULL
   OR g_glef_m.glef004 IS NULL
   OR g_glef_m.glef005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_glefld_t = g_glef_m.glefld
   LET g_glef001_t = g_glef_m.glef001
   LET g_glef004_t = g_glef_m.glef004
   LET g_glef005_t = g_glef_m.glef005
 
   CALL s_transaction_begin()
   
   OPEN aglq941_cl USING g_enterprise,g_glef_m.glefld,g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglq941_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aglq941_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglq941_master_referesh USING g_glef_m.glefld,g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005 INTO g_glef_m.glefld, 
       g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005,g_glef_m.glef009,g_glef_m.glef012,g_glef_m.glef015 
 
   
   #遮罩相關處理
   LET g_glef_m_mask_o.* =  g_glef_m.*
   CALL aglq941_glef_t_mask()
   LET g_glef_m_mask_n.* =  g_glef_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL aglq941_show()
   WHILE TRUE
      LET g_glefld_t = g_glef_m.glefld
      LET g_glef001_t = g_glef_m.glef001
      LET g_glef004_t = g_glef_m.glef004
      LET g_glef005_t = g_glef_m.glef005
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL aglq941_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_glef_m.* = g_glef_m_t.*
         CALL aglq941_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_glef_m.glefld != g_glefld_t 
      OR g_glef_m.glef001 != g_glef001_t 
      OR g_glef_m.glef004 != g_glef004_t 
      OR g_glef_m.glef005 != g_glef005_t 
 
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
   CALL aglq941_set_act_visible()
   CALL aglq941_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " glefent = " ||g_enterprise|| " AND",
                      " glefld = '", g_glef_m.glefld, "' "
                      ," AND glef001 = '", g_glef_m.glef001, "' "
                      ," AND glef004 = '", g_glef_m.glef004, "' "
                      ," AND glef005 = '", g_glef_m.glef005, "' "
 
   #填到對應位置
   CALL aglq941_browser_fill("")
 
   CALL aglq941_idx_chk()
 
   CLOSE aglq941_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aglq941_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="aglq941.input" >}
#+ 資料輸入
PRIVATE FUNCTION aglq941_input(p_cmd)
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
   DISPLAY BY NAME g_glef_m.glefld,g_glef_m.glefld_desc,g_glef_m.glef001,g_glef_m.glef001_desc,g_glef_m.glef004, 
       g_glef_m.glef005,g_glef_m.glef009,g_glef_m.glef012,g_glef_m.glef015
   
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
   LET g_forupd_sql = "SELECT glef006,glef006,glef006 FROM glef_t WHERE glefent=? AND glefld=? AND glef001=?  
       AND glef004=? AND glef005=? AND glef006=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq941_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aglq941_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aglq941_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_glef_m.glefld,g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005,g_glef_m.glef009, 
       g_glef_m.glef012,g_glef_m.glef015
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aglq941.input.head" >}
   
      #單頭段
      INPUT BY NAME g_glef_m.glefld,g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005,g_glef_m.glef009, 
          g_glef_m.glef012,g_glef_m.glef015 
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
         AFTER FIELD glefld
            
            #add-point:AFTER FIELD glefld name="input.a.glefld"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glefld
            #add-point:BEFORE FIELD glefld name="input.b.glefld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glefld
            #add-point:ON CHANGE glefld name="input.g.glefld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef001
            
            #add-point:AFTER FIELD glef001 name="input.a.glef001"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef001
            #add-point:BEFORE FIELD glef001 name="input.b.glef001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glef001
            #add-point:ON CHANGE glef001 name="input.g.glef001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef004
            #add-point:BEFORE FIELD glef004 name="input.b.glef004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef004
            
            #add-point:AFTER FIELD glef004 name="input.a.glef004"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glef004
            #add-point:ON CHANGE glef004 name="input.g.glef004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef005
            #add-point:BEFORE FIELD glef005 name="input.b.glef005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef005
            
            #add-point:AFTER FIELD glef005 name="input.a.glef005"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glef005
            #add-point:ON CHANGE glef005 name="input.g.glef005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef009
            #add-point:BEFORE FIELD glef009 name="input.b.glef009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef009
            
            #add-point:AFTER FIELD glef009 name="input.a.glef009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glef009
            #add-point:ON CHANGE glef009 name="input.g.glef009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef012
            #add-point:BEFORE FIELD glef012 name="input.b.glef012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef012
            
            #add-point:AFTER FIELD glef012 name="input.a.glef012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glef012
            #add-point:ON CHANGE glef012 name="input.g.glef012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef015
            #add-point:BEFORE FIELD glef015 name="input.b.glef015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef015
            
            #add-point:AFTER FIELD glef015 name="input.a.glef015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glef015
            #add-point:ON CHANGE glef015 name="input.g.glef015"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glefld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glefld
            #add-point:ON ACTION controlp INFIELD glefld name="input.c.glefld"
            
            #END add-point
 
 
         #Ctrlp:input.c.glef001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef001
            #add-point:ON ACTION controlp INFIELD glef001 name="input.c.glef001"
            
            #END add-point
 
 
         #Ctrlp:input.c.glef004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef004
            #add-point:ON ACTION controlp INFIELD glef004 name="input.c.glef004"
            
            #END add-point
 
 
         #Ctrlp:input.c.glef005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef005
            #add-point:ON ACTION controlp INFIELD glef005 name="input.c.glef005"
            
            #END add-point
 
 
         #Ctrlp:input.c.glef009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef009
            #add-point:ON ACTION controlp INFIELD glef009 name="input.c.glef009"
            
            #END add-point
 
 
         #Ctrlp:input.c.glef012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef012
            #add-point:ON ACTION controlp INFIELD glef012 name="input.c.glef012"
            
            #END add-point
 
 
         #Ctrlp:input.c.glef015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef015
            #add-point:ON ACTION controlp INFIELD glef015 name="input.c.glef015"
            
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
            DISPLAY BY NAME g_glef_m.glefld             
                            ,g_glef_m.glef001   
                            ,g_glef_m.glef004   
                            ,g_glef_m.glef005   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL aglq941_glef_t_mask_restore('restore_mask_o')
            
               UPDATE glef_t SET (glefld,glef001,glef004,glef005,glef009,glef012,glef015) = (g_glef_m.glefld, 
                   g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005,g_glef_m.glef009,g_glef_m.glef012, 
                   g_glef_m.glef015)
                WHERE glefent = g_enterprise AND glefld = g_glefld_t
                  AND glef001 = g_glef001_t
                  AND glef004 = g_glef004_t
                  AND glef005 = g_glef005_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glef_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glef_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glef_m.glefld
               LET gs_keys_bak[1] = g_glefld_t
               LET gs_keys[2] = g_glef_m.glef001
               LET gs_keys_bak[2] = g_glef001_t
               LET gs_keys[3] = g_glef_m.glef004
               LET gs_keys_bak[3] = g_glef004_t
               LET gs_keys[4] = g_glef_m.glef005
               LET gs_keys_bak[4] = g_glef005_t
               LET gs_keys[5] = g_glef_d[g_detail_idx].glef006
               LET gs_keys_bak[5] = g_glef_d_t.glef006
               CALL aglq941_update_b('glef_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_glef_m_t)
                     #LET g_log2 = util.JSON.stringify(g_glef_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL aglq941_glef_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aglq941_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_glefld_t = g_glef_m.glefld
           LET g_glef001_t = g_glef_m.glef001
           LET g_glef004_t = g_glef_m.glef004
           LET g_glef005_t = g_glef_m.glef005
 
           
           IF g_glef_d.getLength() = 0 THEN
              NEXT FIELD glef006
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="aglq941.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_glef_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glef_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aglq941_b_fill(g_wc2) #test 
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
            CALL aglq941_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN aglq941_cl USING g_enterprise,g_glef_m.glefld,g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE aglq941_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aglq941_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_glef_d[l_ac].glef006 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_glef_d_t.* = g_glef_d[l_ac].*  #BACKUP
               LET g_glef_d_o.* = g_glef_d[l_ac].*  #BACKUP
               CALL aglq941_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL aglq941_set_no_entry_b(l_cmd)
               OPEN aglq941_bcl USING g_enterprise,g_glef_m.glefld,
                                                g_glef_m.glef001,
                                                g_glef_m.glef004,
                                                g_glef_m.glef005,
 
                                                g_glef_d_t.glef006
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aglq941_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aglq941_bcl INTO g_glef_d[l_ac].glef006,g_glef2_d[l_ac].glef006,g_glef3_d[l_ac].glef006 
 
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_glef_d_t.glef006,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glef_d_mask_o[l_ac].* =  g_glef_d[l_ac].*
                  CALL aglq941_glef_t_mask()
                  LET g_glef_d_mask_n[l_ac].* =  g_glef_d[l_ac].*
                  
                  CALL aglq941_ref_show()
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
            INITIALIZE g_glef_d_t.* TO NULL
            INITIALIZE g_glef_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glef_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_glef_d[l_ac].l_glef011_1 = "0"
      LET g_glef_d[l_ac].l_glef011_2 = "0"
      LET g_glef_d[l_ac].l_glef011_3 = "0"
      LET g_glef_d[l_ac].l_glef011_4 = "0"
      LET g_glef_d[l_ac].l_glef011_5 = "0"
      LET g_glef_d[l_ac].l_glef011_6 = "0"
      LET g_glef_d[l_ac].l_glef011_7 = "0"
      LET g_glef_d[l_ac].l_glef011_8 = "0"
      LET g_glef_d[l_ac].l_glef011_9 = "0"
      LET g_glef_d[l_ac].l_glef011_10 = "0"
      LET g_glef_d[l_ac].l_glef011_11 = "0"
      LET g_glef_d[l_ac].l_glef011_12 = "0"
      LET g_glef_d[l_ac].l_glef011_13 = "0"
      LET g_glef_d[l_ac].l_glef011_14 = "0"
      LET g_glef_d[l_ac].l_glef011_15 = "0"
      LET g_glef_d[l_ac].l_glef011_16 = "0"
      LET g_glef_d[l_ac].l_glef011_17 = "0"
      LET g_glef_d[l_ac].l_glef011_18 = "0"
      LET g_glef_d[l_ac].l_glef011_19 = "0"
      LET g_glef_d[l_ac].l_glef011_20 = "0"
      LET g_glef_d[l_ac].l_gleg008 = "0"
      LET g_glef_d[l_ac].l_gleh009 = "0"
      LET g_glef_d[l_ac].l_sum = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_glef_d_t.* = g_glef_d[l_ac].*     #新輸入資料
            LET g_glef_d_o.* = g_glef_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglq941_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL aglq941_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glef_d[li_reproduce_target].* = g_glef_d[li_reproduce].*
               LET g_glef2_d[li_reproduce_target].* = g_glef2_d[li_reproduce].*
               LET g_glef3_d[li_reproduce_target].* = g_glef3_d[li_reproduce].*
 
               LET g_glef_d[g_glef_d.getLength()].glef006 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM glef_t 
             WHERE glefent = g_enterprise AND glefld = g_glef_m.glefld
               AND glef001 = g_glef_m.glef001
               AND glef004 = g_glef_m.glef004
               AND glef005 = g_glef_m.glef005
 
               AND glef006 = g_glef_d[l_ac].glef006
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO glef_t
                           (glefent,
                            glefld,glef001,glef004,glef005,glef009,glef012,glef015,
                            glef006
                            ) 
                     VALUES(g_enterprise,
                            g_glef_m.glefld,g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005,g_glef_m.glef009,g_glef_m.glef012,g_glef_m.glef015,
                            g_glef_d[l_ac].glef006
                            )
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_glef_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "glef_t:",SQLERRMESSAGE 
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
               IF aglq941_before_delete() THEN 
                  
 
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_glef_m.glefld
                  LET gs_keys[gs_keys.getLength()+1] = g_glef_m.glef001
                  LET gs_keys[gs_keys.getLength()+1] = g_glef_m.glef004
                  LET gs_keys[gs_keys.getLength()+1] = g_glef_m.glef005
 
                  LET gs_keys[gs_keys.getLength()+1] = g_glef_d_t.glef006
 
 
                  #刪除下層單身
                  IF NOT aglq941_key_delete_b(gs_keys,'glef_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglq941_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglq941_bcl
               LET l_count = g_glef_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_glef_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef006
            
            #add-point:AFTER FIELD glef006 name="input.a.page1.glef006"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef006
            #add-point:BEFORE FIELD glef006 name="input.b.page1.glef006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glef006
            #add-point:ON CHANGE glef006 name="input.g.page1.glef006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef006_desc
            #add-point:BEFORE FIELD glef006_desc name="input.b.page1.glef006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef006_desc
            
            #add-point:AFTER FIELD glef006_desc name="input.a.page1.glef006_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glef006_desc
            #add-point:ON CHANGE glef006_desc name="input.g.page1.glef006_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_1
            #add-point:BEFORE FIELD l_glef011_1 name="input.b.page1.l_glef011_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_1
            
            #add-point:AFTER FIELD l_glef011_1 name="input.a.page1.l_glef011_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_1
            #add-point:ON CHANGE l_glef011_1 name="input.g.page1.l_glef011_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_2
            #add-point:BEFORE FIELD l_glef011_2 name="input.b.page1.l_glef011_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_2
            
            #add-point:AFTER FIELD l_glef011_2 name="input.a.page1.l_glef011_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_2
            #add-point:ON CHANGE l_glef011_2 name="input.g.page1.l_glef011_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_3
            #add-point:BEFORE FIELD l_glef011_3 name="input.b.page1.l_glef011_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_3
            
            #add-point:AFTER FIELD l_glef011_3 name="input.a.page1.l_glef011_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_3
            #add-point:ON CHANGE l_glef011_3 name="input.g.page1.l_glef011_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_4
            #add-point:BEFORE FIELD l_glef011_4 name="input.b.page1.l_glef011_4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_4
            
            #add-point:AFTER FIELD l_glef011_4 name="input.a.page1.l_glef011_4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_4
            #add-point:ON CHANGE l_glef011_4 name="input.g.page1.l_glef011_4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_5
            #add-point:BEFORE FIELD l_glef011_5 name="input.b.page1.l_glef011_5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_5
            
            #add-point:AFTER FIELD l_glef011_5 name="input.a.page1.l_glef011_5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_5
            #add-point:ON CHANGE l_glef011_5 name="input.g.page1.l_glef011_5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_6
            #add-point:BEFORE FIELD l_glef011_6 name="input.b.page1.l_glef011_6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_6
            
            #add-point:AFTER FIELD l_glef011_6 name="input.a.page1.l_glef011_6"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_6
            #add-point:ON CHANGE l_glef011_6 name="input.g.page1.l_glef011_6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_7
            #add-point:BEFORE FIELD l_glef011_7 name="input.b.page1.l_glef011_7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_7
            
            #add-point:AFTER FIELD l_glef011_7 name="input.a.page1.l_glef011_7"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_7
            #add-point:ON CHANGE l_glef011_7 name="input.g.page1.l_glef011_7"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_8
            #add-point:BEFORE FIELD l_glef011_8 name="input.b.page1.l_glef011_8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_8
            
            #add-point:AFTER FIELD l_glef011_8 name="input.a.page1.l_glef011_8"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_8
            #add-point:ON CHANGE l_glef011_8 name="input.g.page1.l_glef011_8"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_9
            #add-point:BEFORE FIELD l_glef011_9 name="input.b.page1.l_glef011_9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_9
            
            #add-point:AFTER FIELD l_glef011_9 name="input.a.page1.l_glef011_9"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_9
            #add-point:ON CHANGE l_glef011_9 name="input.g.page1.l_glef011_9"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_10
            #add-point:BEFORE FIELD l_glef011_10 name="input.b.page1.l_glef011_10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_10
            
            #add-point:AFTER FIELD l_glef011_10 name="input.a.page1.l_glef011_10"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_10
            #add-point:ON CHANGE l_glef011_10 name="input.g.page1.l_glef011_10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_11
            #add-point:BEFORE FIELD l_glef011_11 name="input.b.page1.l_glef011_11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_11
            
            #add-point:AFTER FIELD l_glef011_11 name="input.a.page1.l_glef011_11"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_11
            #add-point:ON CHANGE l_glef011_11 name="input.g.page1.l_glef011_11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_12
            #add-point:BEFORE FIELD l_glef011_12 name="input.b.page1.l_glef011_12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_12
            
            #add-point:AFTER FIELD l_glef011_12 name="input.a.page1.l_glef011_12"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_12
            #add-point:ON CHANGE l_glef011_12 name="input.g.page1.l_glef011_12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_13
            #add-point:BEFORE FIELD l_glef011_13 name="input.b.page1.l_glef011_13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_13
            
            #add-point:AFTER FIELD l_glef011_13 name="input.a.page1.l_glef011_13"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_13
            #add-point:ON CHANGE l_glef011_13 name="input.g.page1.l_glef011_13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_14
            #add-point:BEFORE FIELD l_glef011_14 name="input.b.page1.l_glef011_14"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_14
            
            #add-point:AFTER FIELD l_glef011_14 name="input.a.page1.l_glef011_14"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_14
            #add-point:ON CHANGE l_glef011_14 name="input.g.page1.l_glef011_14"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_15
            #add-point:BEFORE FIELD l_glef011_15 name="input.b.page1.l_glef011_15"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_15
            
            #add-point:AFTER FIELD l_glef011_15 name="input.a.page1.l_glef011_15"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_15
            #add-point:ON CHANGE l_glef011_15 name="input.g.page1.l_glef011_15"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_16
            #add-point:BEFORE FIELD l_glef011_16 name="input.b.page1.l_glef011_16"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_16
            
            #add-point:AFTER FIELD l_glef011_16 name="input.a.page1.l_glef011_16"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_16
            #add-point:ON CHANGE l_glef011_16 name="input.g.page1.l_glef011_16"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_17
            #add-point:BEFORE FIELD l_glef011_17 name="input.b.page1.l_glef011_17"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_17
            
            #add-point:AFTER FIELD l_glef011_17 name="input.a.page1.l_glef011_17"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_17
            #add-point:ON CHANGE l_glef011_17 name="input.g.page1.l_glef011_17"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_18
            #add-point:BEFORE FIELD l_glef011_18 name="input.b.page1.l_glef011_18"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_18
            
            #add-point:AFTER FIELD l_glef011_18 name="input.a.page1.l_glef011_18"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_18
            #add-point:ON CHANGE l_glef011_18 name="input.g.page1.l_glef011_18"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_19
            #add-point:BEFORE FIELD l_glef011_19 name="input.b.page1.l_glef011_19"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_19
            
            #add-point:AFTER FIELD l_glef011_19 name="input.a.page1.l_glef011_19"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_19
            #add-point:ON CHANGE l_glef011_19 name="input.g.page1.l_glef011_19"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_20
            #add-point:BEFORE FIELD l_glef011_20 name="input.b.page1.l_glef011_20"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_20
            
            #add-point:AFTER FIELD l_glef011_20 name="input.a.page1.l_glef011_20"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_20
            #add-point:ON CHANGE l_glef011_20 name="input.g.page1.l_glef011_20"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gleg008
            #add-point:BEFORE FIELD l_gleg008 name="input.b.page1.l_gleg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gleg008
            
            #add-point:AFTER FIELD l_gleg008 name="input.a.page1.l_gleg008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gleg008
            #add-point:ON CHANGE l_gleg008 name="input.g.page1.l_gleg008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gleh009
            #add-point:BEFORE FIELD l_gleh009 name="input.b.page1.l_gleh009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gleh009
            
            #add-point:AFTER FIELD l_gleh009 name="input.a.page1.l_gleh009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gleh009
            #add-point:ON CHANGE l_gleh009 name="input.g.page1.l_gleh009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sum
            #add-point:BEFORE FIELD l_sum name="input.b.page1.l_sum"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sum
            
            #add-point:AFTER FIELD l_sum name="input.a.page1.l_sum"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_sum
            #add-point:ON CHANGE l_sum name="input.g.page1.l_sum"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.glef006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef006
            #add-point:ON ACTION controlp INFIELD glef006 name="input.c.page1.glef006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glef006_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef006_desc
            #add-point:ON ACTION controlp INFIELD glef006_desc name="input.c.page1.glef006_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_1
            #add-point:ON ACTION controlp INFIELD l_glef011_1 name="input.c.page1.l_glef011_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_2
            #add-point:ON ACTION controlp INFIELD l_glef011_2 name="input.c.page1.l_glef011_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_3
            #add-point:ON ACTION controlp INFIELD l_glef011_3 name="input.c.page1.l_glef011_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_4
            #add-point:ON ACTION controlp INFIELD l_glef011_4 name="input.c.page1.l_glef011_4"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_5
            #add-point:ON ACTION controlp INFIELD l_glef011_5 name="input.c.page1.l_glef011_5"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_6
            #add-point:ON ACTION controlp INFIELD l_glef011_6 name="input.c.page1.l_glef011_6"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_7
            #add-point:ON ACTION controlp INFIELD l_glef011_7 name="input.c.page1.l_glef011_7"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_8
            #add-point:ON ACTION controlp INFIELD l_glef011_8 name="input.c.page1.l_glef011_8"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_9
            #add-point:ON ACTION controlp INFIELD l_glef011_9 name="input.c.page1.l_glef011_9"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_10
            #add-point:ON ACTION controlp INFIELD l_glef011_10 name="input.c.page1.l_glef011_10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_11
            #add-point:ON ACTION controlp INFIELD l_glef011_11 name="input.c.page1.l_glef011_11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_12
            #add-point:ON ACTION controlp INFIELD l_glef011_12 name="input.c.page1.l_glef011_12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_13
            #add-point:ON ACTION controlp INFIELD l_glef011_13 name="input.c.page1.l_glef011_13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_14
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_14
            #add-point:ON ACTION controlp INFIELD l_glef011_14 name="input.c.page1.l_glef011_14"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_15
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_15
            #add-point:ON ACTION controlp INFIELD l_glef011_15 name="input.c.page1.l_glef011_15"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_16
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_16
            #add-point:ON ACTION controlp INFIELD l_glef011_16 name="input.c.page1.l_glef011_16"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_17
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_17
            #add-point:ON ACTION controlp INFIELD l_glef011_17 name="input.c.page1.l_glef011_17"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_18
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_18
            #add-point:ON ACTION controlp INFIELD l_glef011_18 name="input.c.page1.l_glef011_18"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_19
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_19
            #add-point:ON ACTION controlp INFIELD l_glef011_19 name="input.c.page1.l_glef011_19"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_glef011_20
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_20
            #add-point:ON ACTION controlp INFIELD l_glef011_20 name="input.c.page1.l_glef011_20"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_gleg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gleg008
            #add-point:ON ACTION controlp INFIELD l_gleg008 name="input.c.page1.l_gleg008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_gleh009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gleh009
            #add-point:ON ACTION controlp INFIELD l_gleh009 name="input.c.page1.l_gleh009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_sum
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sum
            #add-point:ON ACTION controlp INFIELD l_sum name="input.c.page1.l_sum"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glef_d[l_ac].* = g_glef_d_t.*
               CLOSE aglq941_bcl
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
               LET g_errparam.extend = g_glef_d[l_ac].glef006 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_glef_d[l_ac].* = g_glef_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL aglq941_glef_t_mask_restore('restore_mask_o')
         
               UPDATE glef_t SET (glefld,glef001,glef004,glef005,glef006) = (g_glef_m.glefld,g_glef_m.glef001, 
                   g_glef_m.glef004,g_glef_m.glef005,g_glef_d[l_ac].glef006)
                WHERE glefent = g_enterprise AND glefld = g_glef_m.glefld 
                 AND glef001 = g_glef_m.glef001 
                 AND glef004 = g_glef_m.glef004 
                 AND glef005 = g_glef_m.glef005 
 
                 AND glef006 = g_glef_d_t.glef006 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glef_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "glef_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glef_m.glefld
               LET gs_keys_bak[1] = g_glefld_t
               LET gs_keys[2] = g_glef_m.glef001
               LET gs_keys_bak[2] = g_glef001_t
               LET gs_keys[3] = g_glef_m.glef004
               LET gs_keys_bak[3] = g_glef004_t
               LET gs_keys[4] = g_glef_m.glef005
               LET gs_keys_bak[4] = g_glef005_t
               LET gs_keys[5] = g_glef_d[g_detail_idx].glef006
               LET gs_keys_bak[5] = g_glef_d_t.glef006
               CALL aglq941_update_b('glef_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_glef_m),util.JSON.stringify(g_glef_d_t)
                     LET g_log2 = util.JSON.stringify(g_glef_m),util.JSON.stringify(g_glef_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglq941_glef_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_glef_m.glefld
               LET ls_keys[ls_keys.getLength()+1] = g_glef_m.glef001
               LET ls_keys[ls_keys.getLength()+1] = g_glef_m.glef004
               LET ls_keys[ls_keys.getLength()+1] = g_glef_m.glef005
 
               LET ls_keys[ls_keys.getLength()+1] = g_glef_d_t.glef006
 
               CALL aglq941_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE aglq941_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glef_d[l_ac].* = g_glef_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE aglq941_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_glef_d.getLength() = 0 THEN
               NEXT FIELD glef006
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glef_d[li_reproduce_target].* = g_glef_d[li_reproduce].*
               LET g_glef2_d[li_reproduce_target].* = g_glef2_d[li_reproduce].*
               LET g_glef3_d[li_reproduce_target].* = g_glef3_d[li_reproduce].*
 
               LET g_glef_d[li_reproduce_target].glef006 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_glef_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glef_d.getLength()+1
            END IF
            
      END INPUT
 
      INPUT ARRAY g_glef2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL aglq941_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 2
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
 
         BEFORE ROW 
            #add-point:before row name="input.body2.before_row2"
            
            #end add-point
            LET l_cmd = ''
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()               #returns the current row
            IF l_ac > g_rec_b THEN              #不可超過最後一筆
               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
            END IF
           
            LET l_lock_sw = 'N'                  #DEFAULT
            LET l_n = ARR_COUNT()                #the number of rows containing  
            
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq941_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL aglq941_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body2.before_row.set_entry_b"
               
               #end add-point
               CALL aglq941_set_no_entry_b(l_cmd)
               LET g_glef2_d_t.* = g_glef2_d[l_ac].*   #BACKUP  #page1
               LET g_glef2_d_o.* = g_glef2_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD glef006
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_glef2_d_t.* TO NULL
            INITIALIZE g_glef2_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glef2_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_glef2_d[l_ac].l_glef011_1_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_2_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_3_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_4_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_5_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_6_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_7_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_8_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_9_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_10_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_11_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_12_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_13_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_14_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_15_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_16_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_17_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_18_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_19_1 = "0"
      LET g_glef2_d[l_ac].l_glef011_20_1 = "0"
      LET g_glef2_d[l_ac].l_gleg010 = "0"
      LET g_glef2_d[l_ac].l_gleh011 = "0"
      LET g_glef2_d[l_ac].l_sum_2 = "0"
 
            
            #add-point:modify段before備份 name="input.body2.before_insert.before_bak"
            
            #end add-point
            LET g_glef2_d_t.* = g_glef2_d[l_ac].*     #新輸入資料
            LET g_glef2_d_o.* = g_glef2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglq941_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body2.before_insert.set_entry_b"
            
            #end add-point
            CALL aglq941_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glef_d[li_reproduce_target].* = g_glef_d[li_reproduce].*
               LET g_glef2_d[li_reproduce_target].* = g_glef2_d[li_reproduce].*
               LET g_glef3_d[li_reproduce_target].* = g_glef3_d[li_reproduce].*
 
               LET g_glef2_d[li_reproduce_target].glef006 = NULL
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
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
               IF aglq941_before_delete() THEN 
                  
 
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_glef_m.glefld
                  LET gs_keys[gs_keys.getLength()+1] = g_glef_m.glef001
                  LET gs_keys[gs_keys.getLength()+1] = g_glef_m.glef004
                  LET gs_keys[gs_keys.getLength()+1] = g_glef_m.glef005
                  LET gs_keys[gs_keys.getLength()+1] = g_glef_d_t.glef006
 
                  #刪除下層單身
                  IF NOT aglq941_key_delete_b(gs_keys,'glef_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglq941_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglq941_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_glef2_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body2.after_delete"
               
               #end add-point
                              CALL aglq941_delete_b('glef_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_glef2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glef2_d[l_ac].* = g_glef2_d_t.*
               CLOSE aglq941_bcl
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
               LET g_errparam.extend = g_glef_d[l_ac].glef006 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_glef2_d[l_ac].* = g_glef2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前 name="modify.body2.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aglq941_glef_t_mask_restore('restore_mask_o')
                     
               UPDATE glef_t SET (glefld,glef001,glef004,glef005,glef006) = (g_glef_m.glefld,g_glef_m.glef001, 
                   g_glef_m.glef004,g_glef_m.glef005,g_glef_d[l_ac].glef006) #自訂欄位頁簽
                WHERE glefent = g_enterprise AND glefld = g_glef_m.glefld
                 AND glef001 = g_glef_m.glef001
                 AND glef004 = g_glef_m.glef004
                 AND glef005 = g_glef_m.glef005
                 AND glef006 = g_glef2_d_t.glef006 #項次 
               #add-point:單身修改中 name="modify.body2.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glef_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glef_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glef_m.glefld
               LET gs_keys_bak[1] = g_glefld_t
               LET gs_keys[2] = g_glef_m.glef001
               LET gs_keys_bak[2] = g_glef001_t
               LET gs_keys[3] = g_glef_m.glef004
               LET gs_keys_bak[3] = g_glef004_t
               LET gs_keys[4] = g_glef_m.glef005
               LET gs_keys_bak[4] = g_glef005_t
               LET gs_keys[5] = g_glef2_d[g_detail_idx].glef006
               LET gs_keys_bak[5] = g_glef2_d_t.glef006
               CALL aglq941_update_b('glef_t',gs_keys,gs_keys_bak,"'2'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_glef_m),util.JSON.stringify(g_glef2_d_t)
                     LET g_log2 = util.JSON.stringify(g_glef_m),util.JSON.stringify(g_glef2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglq941_glef_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef006_desc_2
            #add-point:BEFORE FIELD glef006_desc_2 name="input.b.page2.glef006_desc_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef006_desc_2
            
            #add-point:AFTER FIELD glef006_desc_2 name="input.a.page2.glef006_desc_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glef006_desc_2
            #add-point:ON CHANGE glef006_desc_2 name="input.g.page2.glef006_desc_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_1_1
            #add-point:BEFORE FIELD l_glef011_1_1 name="input.b.page2.l_glef011_1_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_1_1
            
            #add-point:AFTER FIELD l_glef011_1_1 name="input.a.page2.l_glef011_1_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_1_1
            #add-point:ON CHANGE l_glef011_1_1 name="input.g.page2.l_glef011_1_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_2_1
            #add-point:BEFORE FIELD l_glef011_2_1 name="input.b.page2.l_glef011_2_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_2_1
            
            #add-point:AFTER FIELD l_glef011_2_1 name="input.a.page2.l_glef011_2_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_2_1
            #add-point:ON CHANGE l_glef011_2_1 name="input.g.page2.l_glef011_2_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_3_1
            #add-point:BEFORE FIELD l_glef011_3_1 name="input.b.page2.l_glef011_3_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_3_1
            
            #add-point:AFTER FIELD l_glef011_3_1 name="input.a.page2.l_glef011_3_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_3_1
            #add-point:ON CHANGE l_glef011_3_1 name="input.g.page2.l_glef011_3_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_4_1
            #add-point:BEFORE FIELD l_glef011_4_1 name="input.b.page2.l_glef011_4_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_4_1
            
            #add-point:AFTER FIELD l_glef011_4_1 name="input.a.page2.l_glef011_4_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_4_1
            #add-point:ON CHANGE l_glef011_4_1 name="input.g.page2.l_glef011_4_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_5_1
            #add-point:BEFORE FIELD l_glef011_5_1 name="input.b.page2.l_glef011_5_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_5_1
            
            #add-point:AFTER FIELD l_glef011_5_1 name="input.a.page2.l_glef011_5_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_5_1
            #add-point:ON CHANGE l_glef011_5_1 name="input.g.page2.l_glef011_5_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_6_1
            #add-point:BEFORE FIELD l_glef011_6_1 name="input.b.page2.l_glef011_6_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_6_1
            
            #add-point:AFTER FIELD l_glef011_6_1 name="input.a.page2.l_glef011_6_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_6_1
            #add-point:ON CHANGE l_glef011_6_1 name="input.g.page2.l_glef011_6_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_7_1
            #add-point:BEFORE FIELD l_glef011_7_1 name="input.b.page2.l_glef011_7_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_7_1
            
            #add-point:AFTER FIELD l_glef011_7_1 name="input.a.page2.l_glef011_7_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_7_1
            #add-point:ON CHANGE l_glef011_7_1 name="input.g.page2.l_glef011_7_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_8_1
            #add-point:BEFORE FIELD l_glef011_8_1 name="input.b.page2.l_glef011_8_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_8_1
            
            #add-point:AFTER FIELD l_glef011_8_1 name="input.a.page2.l_glef011_8_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_8_1
            #add-point:ON CHANGE l_glef011_8_1 name="input.g.page2.l_glef011_8_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_9_1
            #add-point:BEFORE FIELD l_glef011_9_1 name="input.b.page2.l_glef011_9_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_9_1
            
            #add-point:AFTER FIELD l_glef011_9_1 name="input.a.page2.l_glef011_9_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_9_1
            #add-point:ON CHANGE l_glef011_9_1 name="input.g.page2.l_glef011_9_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_10_1
            #add-point:BEFORE FIELD l_glef011_10_1 name="input.b.page2.l_glef011_10_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_10_1
            
            #add-point:AFTER FIELD l_glef011_10_1 name="input.a.page2.l_glef011_10_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_10_1
            #add-point:ON CHANGE l_glef011_10_1 name="input.g.page2.l_glef011_10_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_11_1
            #add-point:BEFORE FIELD l_glef011_11_1 name="input.b.page2.l_glef011_11_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_11_1
            
            #add-point:AFTER FIELD l_glef011_11_1 name="input.a.page2.l_glef011_11_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_11_1
            #add-point:ON CHANGE l_glef011_11_1 name="input.g.page2.l_glef011_11_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_12_1
            #add-point:BEFORE FIELD l_glef011_12_1 name="input.b.page2.l_glef011_12_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_12_1
            
            #add-point:AFTER FIELD l_glef011_12_1 name="input.a.page2.l_glef011_12_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_12_1
            #add-point:ON CHANGE l_glef011_12_1 name="input.g.page2.l_glef011_12_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_13_1
            #add-point:BEFORE FIELD l_glef011_13_1 name="input.b.page2.l_glef011_13_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_13_1
            
            #add-point:AFTER FIELD l_glef011_13_1 name="input.a.page2.l_glef011_13_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_13_1
            #add-point:ON CHANGE l_glef011_13_1 name="input.g.page2.l_glef011_13_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_14_1
            #add-point:BEFORE FIELD l_glef011_14_1 name="input.b.page2.l_glef011_14_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_14_1
            
            #add-point:AFTER FIELD l_glef011_14_1 name="input.a.page2.l_glef011_14_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_14_1
            #add-point:ON CHANGE l_glef011_14_1 name="input.g.page2.l_glef011_14_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_15_1
            #add-point:BEFORE FIELD l_glef011_15_1 name="input.b.page2.l_glef011_15_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_15_1
            
            #add-point:AFTER FIELD l_glef011_15_1 name="input.a.page2.l_glef011_15_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_15_1
            #add-point:ON CHANGE l_glef011_15_1 name="input.g.page2.l_glef011_15_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_16_1
            #add-point:BEFORE FIELD l_glef011_16_1 name="input.b.page2.l_glef011_16_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_16_1
            
            #add-point:AFTER FIELD l_glef011_16_1 name="input.a.page2.l_glef011_16_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_16_1
            #add-point:ON CHANGE l_glef011_16_1 name="input.g.page2.l_glef011_16_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_17_1
            #add-point:BEFORE FIELD l_glef011_17_1 name="input.b.page2.l_glef011_17_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_17_1
            
            #add-point:AFTER FIELD l_glef011_17_1 name="input.a.page2.l_glef011_17_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_17_1
            #add-point:ON CHANGE l_glef011_17_1 name="input.g.page2.l_glef011_17_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_18_1
            #add-point:BEFORE FIELD l_glef011_18_1 name="input.b.page2.l_glef011_18_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_18_1
            
            #add-point:AFTER FIELD l_glef011_18_1 name="input.a.page2.l_glef011_18_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_18_1
            #add-point:ON CHANGE l_glef011_18_1 name="input.g.page2.l_glef011_18_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_19_1
            #add-point:BEFORE FIELD l_glef011_19_1 name="input.b.page2.l_glef011_19_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_19_1
            
            #add-point:AFTER FIELD l_glef011_19_1 name="input.a.page2.l_glef011_19_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_19_1
            #add-point:ON CHANGE l_glef011_19_1 name="input.g.page2.l_glef011_19_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_20_1
            #add-point:BEFORE FIELD l_glef011_20_1 name="input.b.page2.l_glef011_20_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_20_1
            
            #add-point:AFTER FIELD l_glef011_20_1 name="input.a.page2.l_glef011_20_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_20_1
            #add-point:ON CHANGE l_glef011_20_1 name="input.g.page2.l_glef011_20_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gleg010
            #add-point:BEFORE FIELD l_gleg010 name="input.b.page2.l_gleg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gleg010
            
            #add-point:AFTER FIELD l_gleg010 name="input.a.page2.l_gleg010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gleg010
            #add-point:ON CHANGE l_gleg010 name="input.g.page2.l_gleg010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gleh011
            #add-point:BEFORE FIELD l_gleh011 name="input.b.page2.l_gleh011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gleh011
            
            #add-point:AFTER FIELD l_gleh011 name="input.a.page2.l_gleh011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gleh011
            #add-point:ON CHANGE l_gleh011 name="input.g.page2.l_gleh011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sum_2
            #add-point:BEFORE FIELD l_sum_2 name="input.b.page2.l_sum_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sum_2
            
            #add-point:AFTER FIELD l_sum_2 name="input.a.page2.l_sum_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_sum_2
            #add-point:ON CHANGE l_sum_2 name="input.g.page2.l_sum_2"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.glef006_desc_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef006_desc_2
            #add-point:ON ACTION controlp INFIELD glef006_desc_2 name="input.c.page2.glef006_desc_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_1_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_1_1
            #add-point:ON ACTION controlp INFIELD l_glef011_1_1 name="input.c.page2.l_glef011_1_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_2_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_2_1
            #add-point:ON ACTION controlp INFIELD l_glef011_2_1 name="input.c.page2.l_glef011_2_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_3_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_3_1
            #add-point:ON ACTION controlp INFIELD l_glef011_3_1 name="input.c.page2.l_glef011_3_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_4_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_4_1
            #add-point:ON ACTION controlp INFIELD l_glef011_4_1 name="input.c.page2.l_glef011_4_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_5_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_5_1
            #add-point:ON ACTION controlp INFIELD l_glef011_5_1 name="input.c.page2.l_glef011_5_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_6_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_6_1
            #add-point:ON ACTION controlp INFIELD l_glef011_6_1 name="input.c.page2.l_glef011_6_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_7_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_7_1
            #add-point:ON ACTION controlp INFIELD l_glef011_7_1 name="input.c.page2.l_glef011_7_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_8_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_8_1
            #add-point:ON ACTION controlp INFIELD l_glef011_8_1 name="input.c.page2.l_glef011_8_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_9_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_9_1
            #add-point:ON ACTION controlp INFIELD l_glef011_9_1 name="input.c.page2.l_glef011_9_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_10_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_10_1
            #add-point:ON ACTION controlp INFIELD l_glef011_10_1 name="input.c.page2.l_glef011_10_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_11_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_11_1
            #add-point:ON ACTION controlp INFIELD l_glef011_11_1 name="input.c.page2.l_glef011_11_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_12_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_12_1
            #add-point:ON ACTION controlp INFIELD l_glef011_12_1 name="input.c.page2.l_glef011_12_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_13_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_13_1
            #add-point:ON ACTION controlp INFIELD l_glef011_13_1 name="input.c.page2.l_glef011_13_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_14_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_14_1
            #add-point:ON ACTION controlp INFIELD l_glef011_14_1 name="input.c.page2.l_glef011_14_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_15_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_15_1
            #add-point:ON ACTION controlp INFIELD l_glef011_15_1 name="input.c.page2.l_glef011_15_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_16_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_16_1
            #add-point:ON ACTION controlp INFIELD l_glef011_16_1 name="input.c.page2.l_glef011_16_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_17_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_17_1
            #add-point:ON ACTION controlp INFIELD l_glef011_17_1 name="input.c.page2.l_glef011_17_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_18_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_18_1
            #add-point:ON ACTION controlp INFIELD l_glef011_18_1 name="input.c.page2.l_glef011_18_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_19_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_19_1
            #add-point:ON ACTION controlp INFIELD l_glef011_19_1 name="input.c.page2.l_glef011_19_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glef011_20_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_20_1
            #add-point:ON ACTION controlp INFIELD l_glef011_20_1 name="input.c.page2.l_glef011_20_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gleg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gleg010
            #add-point:ON ACTION controlp INFIELD l_gleg010 name="input.c.page2.l_gleg010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gleh011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gleh011
            #add-point:ON ACTION controlp INFIELD l_gleh011 name="input.c.page2.l_gleh011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_sum_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sum_2
            #add-point:ON ACTION controlp INFIELD l_sum_2 name="input.c.page2.l_sum_2"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body2.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glef2_d[l_ac].* = g_glef2_d_t.*
               END IF
               CLOSE aglq941_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE aglq941_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glef_d[li_reproduce_target].* = g_glef_d[li_reproduce].*
               LET g_glef2_d[li_reproduce_target].* = g_glef2_d[li_reproduce].*
               LET g_glef3_d[li_reproduce_target].* = g_glef3_d[li_reproduce].*
 
               LET g_glef2_d[li_reproduce_target].glef006 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_glef2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glef2_d.getLength()+1
            END IF
      END INPUT
      INPUT ARRAY g_glef3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL aglq941_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 3
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
 
         BEFORE ROW 
            #add-point:before row name="input.body3.before_row2"
            
            #end add-point
            LET l_cmd = ''
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()               #returns the current row
            IF l_ac > g_rec_b THEN              #不可超過最後一筆
               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
            END IF
           
            LET l_lock_sw = 'N'                  #DEFAULT
            LET l_n = ARR_COUNT()                #the number of rows containing  
            
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq941_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL aglq941_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body3.before_row.set_entry_b"
               
               #end add-point
               CALL aglq941_set_no_entry_b(l_cmd)
               LET g_glef3_d_t.* = g_glef3_d[l_ac].*   #BACKUP  #page1
               LET g_glef3_d_o.* = g_glef3_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD glef006
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_glef3_d_t.* TO NULL
            INITIALIZE g_glef3_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glef3_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_glef3_d[l_ac].l_glef011_1_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_2_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_3_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_4_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_5_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_6_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_7_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_8_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_9_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_10_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_11_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_12_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_13_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_14_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_15_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_16_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_17_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_18_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_19_2 = "0"
      LET g_glef3_d[l_ac].l_glef011_20_2 = "0"
      LET g_glef3_d[l_ac].l_gleg012 = "0"
      LET g_glef3_d[l_ac].l_gleh013 = "0"
      LET g_glef3_d[l_ac].l_sum_3 = "0"
 
            
            #add-point:modify段before備份 name="input.body3.before_insert.before_bak"
            
            #end add-point
            LET g_glef3_d_t.* = g_glef3_d[l_ac].*     #新輸入資料
            LET g_glef3_d_o.* = g_glef3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglq941_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body3.before_insert.set_entry_b"
            
            #end add-point
            CALL aglq941_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glef_d[li_reproduce_target].* = g_glef_d[li_reproduce].*
               LET g_glef2_d[li_reproduce_target].* = g_glef2_d[li_reproduce].*
               LET g_glef3_d[li_reproduce_target].* = g_glef3_d[li_reproduce].*
 
               LET g_glef3_d[li_reproduce_target].glef006 = NULL
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
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
               IF aglq941_before_delete() THEN 
                  
 
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_glef_m.glefld
                  LET gs_keys[gs_keys.getLength()+1] = g_glef_m.glef001
                  LET gs_keys[gs_keys.getLength()+1] = g_glef_m.glef004
                  LET gs_keys[gs_keys.getLength()+1] = g_glef_m.glef005
                  LET gs_keys[gs_keys.getLength()+1] = g_glef_d_t.glef006
 
                  #刪除下層單身
                  IF NOT aglq941_key_delete_b(gs_keys,'glef_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglq941_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglq941_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_glef3_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL aglq941_delete_b('glef_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_glef3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glef3_d[l_ac].* = g_glef3_d_t.*
               CLOSE aglq941_bcl
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
               LET g_errparam.extend = g_glef_d[l_ac].glef006 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_glef3_d[l_ac].* = g_glef3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前 name="modify.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aglq941_glef_t_mask_restore('restore_mask_o')
                     
               UPDATE glef_t SET (glefld,glef001,glef004,glef005,glef006) = (g_glef_m.glefld,g_glef_m.glef001, 
                   g_glef_m.glef004,g_glef_m.glef005,g_glef_d[l_ac].glef006) #自訂欄位頁簽
                WHERE glefent = g_enterprise AND glefld = g_glef_m.glefld
                 AND glef001 = g_glef_m.glef001
                 AND glef004 = g_glef_m.glef004
                 AND glef005 = g_glef_m.glef005
                 AND glef006 = g_glef3_d_t.glef006 #項次 
               #add-point:單身修改中 name="modify.body3.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glef_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glef_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glef_m.glefld
               LET gs_keys_bak[1] = g_glefld_t
               LET gs_keys[2] = g_glef_m.glef001
               LET gs_keys_bak[2] = g_glef001_t
               LET gs_keys[3] = g_glef_m.glef004
               LET gs_keys_bak[3] = g_glef004_t
               LET gs_keys[4] = g_glef_m.glef005
               LET gs_keys_bak[4] = g_glef005_t
               LET gs_keys[5] = g_glef3_d[g_detail_idx].glef006
               LET gs_keys_bak[5] = g_glef3_d_t.glef006
               CALL aglq941_update_b('glef_t',gs_keys,gs_keys_bak,"'3'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_glef_m),util.JSON.stringify(g_glef3_d_t)
                     LET g_log2 = util.JSON.stringify(g_glef_m),util.JSON.stringify(g_glef3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglq941_glef_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef006_desc_3
            #add-point:BEFORE FIELD glef006_desc_3 name="input.b.page3.glef006_desc_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef006_desc_3
            
            #add-point:AFTER FIELD glef006_desc_3 name="input.a.page3.glef006_desc_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glef006_desc_3
            #add-point:ON CHANGE glef006_desc_3 name="input.g.page3.glef006_desc_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_1_2
            #add-point:BEFORE FIELD l_glef011_1_2 name="input.b.page3.l_glef011_1_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_1_2
            
            #add-point:AFTER FIELD l_glef011_1_2 name="input.a.page3.l_glef011_1_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_1_2
            #add-point:ON CHANGE l_glef011_1_2 name="input.g.page3.l_glef011_1_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_2_2
            #add-point:BEFORE FIELD l_glef011_2_2 name="input.b.page3.l_glef011_2_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_2_2
            
            #add-point:AFTER FIELD l_glef011_2_2 name="input.a.page3.l_glef011_2_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_2_2
            #add-point:ON CHANGE l_glef011_2_2 name="input.g.page3.l_glef011_2_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_3_2
            #add-point:BEFORE FIELD l_glef011_3_2 name="input.b.page3.l_glef011_3_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_3_2
            
            #add-point:AFTER FIELD l_glef011_3_2 name="input.a.page3.l_glef011_3_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_3_2
            #add-point:ON CHANGE l_glef011_3_2 name="input.g.page3.l_glef011_3_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_4_2
            #add-point:BEFORE FIELD l_glef011_4_2 name="input.b.page3.l_glef011_4_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_4_2
            
            #add-point:AFTER FIELD l_glef011_4_2 name="input.a.page3.l_glef011_4_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_4_2
            #add-point:ON CHANGE l_glef011_4_2 name="input.g.page3.l_glef011_4_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_5_2
            #add-point:BEFORE FIELD l_glef011_5_2 name="input.b.page3.l_glef011_5_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_5_2
            
            #add-point:AFTER FIELD l_glef011_5_2 name="input.a.page3.l_glef011_5_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_5_2
            #add-point:ON CHANGE l_glef011_5_2 name="input.g.page3.l_glef011_5_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_6_2
            #add-point:BEFORE FIELD l_glef011_6_2 name="input.b.page3.l_glef011_6_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_6_2
            
            #add-point:AFTER FIELD l_glef011_6_2 name="input.a.page3.l_glef011_6_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_6_2
            #add-point:ON CHANGE l_glef011_6_2 name="input.g.page3.l_glef011_6_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_7_2
            #add-point:BEFORE FIELD l_glef011_7_2 name="input.b.page3.l_glef011_7_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_7_2
            
            #add-point:AFTER FIELD l_glef011_7_2 name="input.a.page3.l_glef011_7_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_7_2
            #add-point:ON CHANGE l_glef011_7_2 name="input.g.page3.l_glef011_7_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_8_2
            #add-point:BEFORE FIELD l_glef011_8_2 name="input.b.page3.l_glef011_8_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_8_2
            
            #add-point:AFTER FIELD l_glef011_8_2 name="input.a.page3.l_glef011_8_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_8_2
            #add-point:ON CHANGE l_glef011_8_2 name="input.g.page3.l_glef011_8_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_9_2
            #add-point:BEFORE FIELD l_glef011_9_2 name="input.b.page3.l_glef011_9_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_9_2
            
            #add-point:AFTER FIELD l_glef011_9_2 name="input.a.page3.l_glef011_9_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_9_2
            #add-point:ON CHANGE l_glef011_9_2 name="input.g.page3.l_glef011_9_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_10_2
            #add-point:BEFORE FIELD l_glef011_10_2 name="input.b.page3.l_glef011_10_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_10_2
            
            #add-point:AFTER FIELD l_glef011_10_2 name="input.a.page3.l_glef011_10_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_10_2
            #add-point:ON CHANGE l_glef011_10_2 name="input.g.page3.l_glef011_10_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_11_2
            #add-point:BEFORE FIELD l_glef011_11_2 name="input.b.page3.l_glef011_11_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_11_2
            
            #add-point:AFTER FIELD l_glef011_11_2 name="input.a.page3.l_glef011_11_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_11_2
            #add-point:ON CHANGE l_glef011_11_2 name="input.g.page3.l_glef011_11_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_12_2
            #add-point:BEFORE FIELD l_glef011_12_2 name="input.b.page3.l_glef011_12_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_12_2
            
            #add-point:AFTER FIELD l_glef011_12_2 name="input.a.page3.l_glef011_12_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_12_2
            #add-point:ON CHANGE l_glef011_12_2 name="input.g.page3.l_glef011_12_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_13_2
            #add-point:BEFORE FIELD l_glef011_13_2 name="input.b.page3.l_glef011_13_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_13_2
            
            #add-point:AFTER FIELD l_glef011_13_2 name="input.a.page3.l_glef011_13_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_13_2
            #add-point:ON CHANGE l_glef011_13_2 name="input.g.page3.l_glef011_13_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_14_2
            #add-point:BEFORE FIELD l_glef011_14_2 name="input.b.page3.l_glef011_14_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_14_2
            
            #add-point:AFTER FIELD l_glef011_14_2 name="input.a.page3.l_glef011_14_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_14_2
            #add-point:ON CHANGE l_glef011_14_2 name="input.g.page3.l_glef011_14_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_15_2
            #add-point:BEFORE FIELD l_glef011_15_2 name="input.b.page3.l_glef011_15_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_15_2
            
            #add-point:AFTER FIELD l_glef011_15_2 name="input.a.page3.l_glef011_15_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_15_2
            #add-point:ON CHANGE l_glef011_15_2 name="input.g.page3.l_glef011_15_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_16_2
            #add-point:BEFORE FIELD l_glef011_16_2 name="input.b.page3.l_glef011_16_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_16_2
            
            #add-point:AFTER FIELD l_glef011_16_2 name="input.a.page3.l_glef011_16_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_16_2
            #add-point:ON CHANGE l_glef011_16_2 name="input.g.page3.l_glef011_16_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_17_2
            #add-point:BEFORE FIELD l_glef011_17_2 name="input.b.page3.l_glef011_17_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_17_2
            
            #add-point:AFTER FIELD l_glef011_17_2 name="input.a.page3.l_glef011_17_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_17_2
            #add-point:ON CHANGE l_glef011_17_2 name="input.g.page3.l_glef011_17_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_18_2
            #add-point:BEFORE FIELD l_glef011_18_2 name="input.b.page3.l_glef011_18_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_18_2
            
            #add-point:AFTER FIELD l_glef011_18_2 name="input.a.page3.l_glef011_18_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_18_2
            #add-point:ON CHANGE l_glef011_18_2 name="input.g.page3.l_glef011_18_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_19_2
            #add-point:BEFORE FIELD l_glef011_19_2 name="input.b.page3.l_glef011_19_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_19_2
            
            #add-point:AFTER FIELD l_glef011_19_2 name="input.a.page3.l_glef011_19_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_19_2
            #add-point:ON CHANGE l_glef011_19_2 name="input.g.page3.l_glef011_19_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glef011_20_2
            #add-point:BEFORE FIELD l_glef011_20_2 name="input.b.page3.l_glef011_20_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glef011_20_2
            
            #add-point:AFTER FIELD l_glef011_20_2 name="input.a.page3.l_glef011_20_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glef011_20_2
            #add-point:ON CHANGE l_glef011_20_2 name="input.g.page3.l_glef011_20_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gleg012
            #add-point:BEFORE FIELD l_gleg012 name="input.b.page3.l_gleg012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gleg012
            
            #add-point:AFTER FIELD l_gleg012 name="input.a.page3.l_gleg012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gleg012
            #add-point:ON CHANGE l_gleg012 name="input.g.page3.l_gleg012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gleh013
            #add-point:BEFORE FIELD l_gleh013 name="input.b.page3.l_gleh013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gleh013
            
            #add-point:AFTER FIELD l_gleh013 name="input.a.page3.l_gleh013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gleh013
            #add-point:ON CHANGE l_gleh013 name="input.g.page3.l_gleh013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sum_3
            #add-point:BEFORE FIELD l_sum_3 name="input.b.page3.l_sum_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sum_3
            
            #add-point:AFTER FIELD l_sum_3 name="input.a.page3.l_sum_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_sum_3
            #add-point:ON CHANGE l_sum_3 name="input.g.page3.l_sum_3"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.glef006_desc_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef006_desc_3
            #add-point:ON ACTION controlp INFIELD glef006_desc_3 name="input.c.page3.glef006_desc_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_1_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_1_2
            #add-point:ON ACTION controlp INFIELD l_glef011_1_2 name="input.c.page3.l_glef011_1_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_2_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_2_2
            #add-point:ON ACTION controlp INFIELD l_glef011_2_2 name="input.c.page3.l_glef011_2_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_3_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_3_2
            #add-point:ON ACTION controlp INFIELD l_glef011_3_2 name="input.c.page3.l_glef011_3_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_4_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_4_2
            #add-point:ON ACTION controlp INFIELD l_glef011_4_2 name="input.c.page3.l_glef011_4_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_5_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_5_2
            #add-point:ON ACTION controlp INFIELD l_glef011_5_2 name="input.c.page3.l_glef011_5_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_6_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_6_2
            #add-point:ON ACTION controlp INFIELD l_glef011_6_2 name="input.c.page3.l_glef011_6_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_7_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_7_2
            #add-point:ON ACTION controlp INFIELD l_glef011_7_2 name="input.c.page3.l_glef011_7_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_8_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_8_2
            #add-point:ON ACTION controlp INFIELD l_glef011_8_2 name="input.c.page3.l_glef011_8_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_9_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_9_2
            #add-point:ON ACTION controlp INFIELD l_glef011_9_2 name="input.c.page3.l_glef011_9_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_10_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_10_2
            #add-point:ON ACTION controlp INFIELD l_glef011_10_2 name="input.c.page3.l_glef011_10_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_11_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_11_2
            #add-point:ON ACTION controlp INFIELD l_glef011_11_2 name="input.c.page3.l_glef011_11_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_12_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_12_2
            #add-point:ON ACTION controlp INFIELD l_glef011_12_2 name="input.c.page3.l_glef011_12_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_13_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_13_2
            #add-point:ON ACTION controlp INFIELD l_glef011_13_2 name="input.c.page3.l_glef011_13_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_14_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_14_2
            #add-point:ON ACTION controlp INFIELD l_glef011_14_2 name="input.c.page3.l_glef011_14_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_15_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_15_2
            #add-point:ON ACTION controlp INFIELD l_glef011_15_2 name="input.c.page3.l_glef011_15_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_16_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_16_2
            #add-point:ON ACTION controlp INFIELD l_glef011_16_2 name="input.c.page3.l_glef011_16_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_17_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_17_2
            #add-point:ON ACTION controlp INFIELD l_glef011_17_2 name="input.c.page3.l_glef011_17_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_18_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_18_2
            #add-point:ON ACTION controlp INFIELD l_glef011_18_2 name="input.c.page3.l_glef011_18_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_19_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_19_2
            #add-point:ON ACTION controlp INFIELD l_glef011_19_2 name="input.c.page3.l_glef011_19_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glef011_20_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glef011_20_2
            #add-point:ON ACTION controlp INFIELD l_glef011_20_2 name="input.c.page3.l_glef011_20_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gleg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gleg012
            #add-point:ON ACTION controlp INFIELD l_gleg012 name="input.c.page3.l_gleg012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gleh013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gleh013
            #add-point:ON ACTION controlp INFIELD l_gleh013 name="input.c.page3.l_gleh013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_sum_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sum_3
            #add-point:ON ACTION controlp INFIELD l_sum_3 name="input.c.page3.l_sum_3"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body3.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glef3_d[l_ac].* = g_glef3_d_t.*
               END IF
               CLOSE aglq941_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE aglq941_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glef_d[li_reproduce_target].* = g_glef_d[li_reproduce].*
               LET g_glef2_d[li_reproduce_target].* = g_glef2_d[li_reproduce].*
               LET g_glef3_d[li_reproduce_target].* = g_glef3_d[li_reproduce].*
 
               LET g_glef3_d[li_reproduce_target].glef006 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_glef3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glef3_d.getLength()+1
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
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
         CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD glefld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD glef006
               WHEN "s_detail2"
                  NEXT FIELD glef006_2
               WHEN "s_detail3"
                  NEXT FIELD glef006_3
 
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
   CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aglq941_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL aglq941_b_fill(g_wc2) #第一階單身填充
      CALL aglq941_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aglq941_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
 
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_glef_m.glefld,g_glef_m.glefld_desc,g_glef_m.glef001,g_glef_m.glef001_desc,g_glef_m.glef004, 
       g_glef_m.glef005,g_glef_m.glef009,g_glef_m.glef012,g_glef_m.glef015
 
   CALL aglq941_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   CALL aglq941_ld_visible()
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION aglq941_ref_show()
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
   LET g_glef_m.glefld_desc  = s_desc_get_ld_desc(g_glef_m.glefld)
   LET g_glef_m.glef001_desc = s_desc_glda001_desc(g_glef_m.glef001)
   DISPLAY BY NAME g_glef_m.glefld_desc,g_glef_m.glef001_desc
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_glef_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_glef2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
 
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_glef3_d.getLength()
      #add-point:ref_show段d3_reference name="ref_show.body3.reference"
 
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   CALL g_glef_d.deleteElement(l_ac)
   CALL g_glef2_d.deleteElement(l_ac)
   CALL g_glef3_d.deleteElement(l_ac)
   LET l_ac = l_ac-1
   DISPLAY BY NAME g_glef_d[l_ac].glef006,g_glef_d[l_ac].glef006_desc,g_glef_d[l_ac].l_glef011_1,g_glef_d[l_ac].l_glef011_2,
                   g_glef_d[l_ac].l_glef011_3,g_glef_d[l_ac].l_glef011_4,g_glef_d[l_ac].l_glef011_5,g_glef_d[l_ac].l_glef011_6, 
                   g_glef_d[l_ac].l_glef011_7,g_glef_d[l_ac].l_glef011_8,g_glef_d[l_ac].l_glef011_9,g_glef_d[l_ac].l_glef011_10,  
                   g_glef_d[l_ac].l_glef011_11,g_glef_d[l_ac].l_glef011_12,g_glef_d[l_ac].l_glef011_13,g_glef_d[l_ac].l_glef011_14,
                   g_glef_d[l_ac].l_glef011_15,g_glef_d[l_ac].l_glef011_16,g_glef_d[l_ac].l_glef011_17,g_glef_d[l_ac].l_glef011_18,  
                   g_glef_d[l_ac].l_glef011_19,g_glef_d[l_ac].l_glef011_20,g_glef_d[l_ac].l_gleg008,g_glef_d[l_ac].l_gleh009,
                   g_glef_d[l_ac].l_sum,g_glef2_d[l_ac].glef006,g_glef2_d[l_ac].glef006_desc_2,g_glef2_d[l_ac].l_glef011_1_1,
                   g_glef2_d[l_ac].l_glef011_2_1,g_glef2_d[l_ac].l_glef011_3_1,g_glef2_d[l_ac].l_glef011_4_1,g_glef2_d[l_ac].l_glef011_5_1, 
                   g_glef2_d[l_ac].l_glef011_6_1,g_glef2_d[l_ac].l_glef011_7_1,g_glef2_d[l_ac].l_glef011_8_1,g_glef2_d[l_ac].l_glef011_9_1, 
                   g_glef2_d[l_ac].l_glef011_10_1,g_glef2_d[l_ac].l_glef011_11_1,g_glef2_d[l_ac].l_glef011_12_1,g_glef2_d[l_ac].l_glef011_13_1,
                   g_glef2_d[l_ac].l_glef011_14_1,g_glef2_d[l_ac].l_glef011_15_1,g_glef2_d[l_ac].l_glef011_16_1,g_glef2_d[l_ac].l_glef011_17_1,
                   g_glef2_d[l_ac].l_glef011_18_1,g_glef2_d[l_ac].l_glef011_19_1,g_glef2_d[l_ac].l_glef011_20_1,g_glef2_d[l_ac].l_gleg010,     
                   g_glef2_d[l_ac].l_gleh011,g_glef2_d[l_ac].l_sum_2,g_glef3_d[l_ac].glef006,g_glef3_d[l_ac].glef006_desc_3,
                   g_glef3_d[l_ac].l_glef011_1_2,g_glef3_d[l_ac].l_glef011_2_2,g_glef3_d[l_ac].l_glef011_3_2,g_glef3_d[l_ac].l_glef011_4_2, 
                   g_glef3_d[l_ac].l_glef011_5_2,g_glef3_d[l_ac].l_glef011_6_2,g_glef3_d[l_ac].l_glef011_7_2,g_glef3_d[l_ac].l_glef011_8_2, 
                   g_glef3_d[l_ac].l_glef011_9_2,g_glef3_d[l_ac].l_glef011_10_2,g_glef3_d[l_ac].l_glef011_11_2,g_glef3_d[l_ac].l_glef011_12_2,
                   g_glef3_d[l_ac].l_glef011_13_2,g_glef3_d[l_ac].l_glef011_14_2,g_glef3_d[l_ac].l_glef011_15_2,g_glef3_d[l_ac].l_glef011_16_2,
                   g_glef3_d[l_ac].l_glef011_17_2,g_glef3_d[l_ac].l_glef011_18_2,g_glef3_d[l_ac].l_glef011_19_2,g_glef3_d[l_ac].l_glef011_20_2,
                   g_glef3_d[l_ac].l_gleg012,g_glef3_d[l_ac].l_gleh013,g_glef3_d[l_ac].l_sum_3 
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="aglq941.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aglq941_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE glef_t.glefld 
   DEFINE l_oldno     LIKE glef_t.glefld 
   DEFINE l_newno02     LIKE glef_t.glef001 
   DEFINE l_oldno02     LIKE glef_t.glef001 
   DEFINE l_newno03     LIKE glef_t.glef004 
   DEFINE l_oldno03     LIKE glef_t.glef004 
   DEFINE l_newno04     LIKE glef_t.glef005 
   DEFINE l_oldno04     LIKE glef_t.glef005 
 
   DEFINE l_master    RECORD LIKE glef_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE glef_t.* #此變數樣板目前無使用
 
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
 
   IF g_glef_m.glefld IS NULL
      OR g_glef_m.glef001 IS NULL
      OR g_glef_m.glef004 IS NULL
      OR g_glef_m.glef005 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_glefld_t = g_glef_m.glefld
   LET g_glef001_t = g_glef_m.glef001
   LET g_glef004_t = g_glef_m.glef004
   LET g_glef005_t = g_glef_m.glef005
 
   
   LET g_glef_m.glefld = ""
   LET g_glef_m.glef001 = ""
   LET g_glef_m.glef004 = ""
   LET g_glef_m.glef005 = ""
 
   LET g_master_insert = FALSE
   CALL aglq941_set_entry('a')
   CALL aglq941_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_glef_m.glefld_desc = ''
   DISPLAY BY NAME g_glef_m.glefld_desc
   LET g_glef_m.glef001_desc = ''
   DISPLAY BY NAME g_glef_m.glef001_desc
 
   
   CALL aglq941_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_glef_m.* TO NULL
      INITIALIZE g_glef_d TO NULL
      INITIALIZE g_glef2_d TO NULL
      INITIALIZE g_glef3_d TO NULL
 
      CALL aglq941_show()
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
   CALL aglq941_set_act_visible()
   CALL aglq941_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_glefld_t = g_glef_m.glefld
   LET g_glef001_t = g_glef_m.glef001
   LET g_glef004_t = g_glef_m.glef004
   LET g_glef005_t = g_glef_m.glef005
 
   
   #組合新增資料的條件
   LET g_add_browse = " glefent = " ||g_enterprise|| " AND",
                      " glefld = '", g_glef_m.glefld, "' "
                      ," AND glef001 = '", g_glef_m.glef001, "' "
                      ," AND glef004 = '", g_glef_m.glef004, "' "
                      ," AND glef005 = '", g_glef_m.glef005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglq941_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL aglq941_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL aglq941_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aglq941_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE glef_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aglq941_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM glef_t
    WHERE glefent = g_enterprise AND glefld = g_glefld_t
    AND glef001 = g_glef001_t
    AND glef004 = g_glef004_t
    AND glef005 = g_glef005_t
 
       INTO TEMP aglq941_detail
   
   #將key修正為調整後   
   UPDATE aglq941_detail 
      #更新key欄位
      SET glefld = g_glef_m.glefld
          , glef001 = g_glef_m.glef001
          , glef004 = g_glef_m.glef004
          , glef005 = g_glef_m.glef005
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO glef_t SELECT * FROM aglq941_detail
   
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
   DROP TABLE aglq941_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_glefld_t = g_glef_m.glefld
   LET g_glef001_t = g_glef_m.glef001
   LET g_glef004_t = g_glef_m.glef004
   LET g_glef005_t = g_glef_m.glef005
 
   
   DROP TABLE aglq941_detail
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aglq941_delete()
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
   
   IF g_glef_m.glefld IS NULL
   OR g_glef_m.glef001 IS NULL
   OR g_glef_m.glef004 IS NULL
   OR g_glef_m.glef005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN aglq941_cl USING g_enterprise,g_glef_m.glefld,g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglq941_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aglq941_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglq941_master_referesh USING g_glef_m.glefld,g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005 INTO g_glef_m.glefld, 
       g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005,g_glef_m.glef009,g_glef_m.glef012,g_glef_m.glef015 
 
   
   #遮罩相關處理
   LET g_glef_m_mask_o.* =  g_glef_m.*
   CALL aglq941_glef_t_mask()
   LET g_glef_m_mask_n.* =  g_glef_m.*
   
   CALL aglq941_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aglq941_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM glef_t WHERE glefent = g_enterprise AND glefld = g_glef_m.glefld
                                                               AND glef001 = g_glef_m.glef001
                                                               AND glef004 = g_glef_m.glef004
                                                               AND glef005 = g_glef_m.glef005
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glef_t:",SQLERRMESSAGE 
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
      #   CLOSE aglq941_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_glef_d.clear() 
      CALL g_glef2_d.clear()       
      CALL g_glef3_d.clear()       
 
     
      CALL aglq941_ui_browser_refresh()  
      #CALL aglq941_ui_headershow()  
      #CALL aglq941_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL aglq941_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL aglq941_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE aglq941_cl
 
   #功能已完成,通報訊息中心
   CALL aglq941_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aglq941.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq941_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql            STRING  
   DEFINE l_idx            LIKE type_t.num10

   DEFINE l_ac1            LIKE type_t.num10
   DEFINE l_n              LIKE type_t.num10
   DEFINE l_glef           DYNAMIC ARRAY OF RECORD  #agli510 下層公司
            glef002        LIKE glef_t.glef002   
                           END RECORD 
   DEFINE l_glef_tit       DYNAMIC ARRAY OF RECORD  #agli510 下層公司
            glef002        LIKE glef_t.glef002,     #下層公司
            glef011        LIKE glef_t.glef011,     #金額(記帳幣)
            glef014        LIKE glef_t.glef014,     #金額(功能幣)
            glef017        LIKE glef_t.glef017      #金額(報告幣)
                           END RECORD  
   DEFINE l_gleg008        LIKE gleg_t.gleg008 
   DEFINE l_gleg010        LIKE gleg_t.gleg010 
   DEFINE l_gleg012        LIKE gleg_t.gleg012 
   DEFINE l_gleg0081       LIKE gleg_t.gleg008
   DEFINE l_gleg0101       LIKE gleg_t.gleg010
   DEFINE l_gleg0121       LIKE gleg_t.gleg012  
   DEFINE l_glef002_desc   LIKE type_t.chr500
   DEFINE l_m0             LIKE type_t.num10
   DEFINE l_m1             LIKE type_t.num10
   DEFINE l_msg1           STRING
   DEFINE l_msg2           STRING 
   DEFINE l_msg2_1         STRING 
   DEFINE l_msg2_2         STRING 
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   #CALL aglq941_ins_tmp()
   #end add-point
   
   #先清空單身變數內容
   CALL g_glef_d.clear()
   CALL g_glef2_d.clear()
   CALL g_glef3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT glef006,glef006,glef006 FROM glef_t",   
               "",
               
               
               " WHERE glefent= ? AND glefld=? AND glef001=? AND glef004=? AND glef005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("glef_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   CALL l_glef.clear()
   #撈出該上層公司下一階的下層公司----------------------------
   LET l_sql = "SELECT gldc002 FROM gldc_t,gldb_t ",
               " WHERE gldc009 = 'N' ",
               "   AND gldcent = ",g_enterprise,"       ",
               "   AND gldcld  = '",g_glef_m.glefld,"'  ",
               "   AND gldc001 = '",g_glef_m.glef001,"' ",
               "   AND gldcent = gldbent  ",
               "   AND gldcld  = gldbld   ",
               "   AND gldc001 = gldb001  ",
               " ORDER BY gldc002 "
   PREPARE aglq941_gldc002p1 FROM l_sql
   DECLARE aglq941_gldc002c1 CURSOR FOR aglq941_gldc002p1 
   LET l_idx = 1
   FOREACH aglq941_gldc002c1 INTO l_glef[l_idx].glef002
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF
      LET l_idx = l_idx + 1
   END FOREACH
   LET l_idx = l_idx - 1
   
   #各下層公司於該現金變動碼金額----------------------------
   LET l_sql = "SELECT glef002,SUM(glef011),SUM(glef014),SUM(glef017) ",
               "  FROM glef_t ",
               " WHERE glefent = '",g_enterprise,"' ",     
               "   AND glefld = '",g_glef_m.glefld,"' ",                       
               "   AND glef001 = '",g_glef_m.glef001,"' ",
               "   AND glef004 = '",g_glef_m.glef004,"' ",
               "   AND glef005 = '",g_glef_m.glef005,"' ",
               "   AND glef006 = ? ", #現金變動碼
               " GROUP BY glef002 ",
               " ORDER BY glef002 "
   PREPARE aglq941_glef011p1 FROM l_sql
   DECLARE aglq941_glef011c1 CURSOR FOR aglq941_glef011p1 

   #來源公司_直接法[抵銷]金額計算----------------------------
   LET l_sql = " SELECT COALESCE(SUM(CASE gleg015 WHEN '+' THEN gleg008 ELSE gleg008*-1 END),0), ",
               "        COALESCE(SUM(CASE gleg015 WHEN '+' THEN gleg010 ELSE gleg010*-1 END),0), ",
               "        COALESCE(SUM(CASE gleg015 WHEN '+' THEN gleg012 ELSE gleg012*-1 END),0)  ",
               "   FROM gleg_t  ",
               "  WHERE glegent = '",g_enterprise,"' ",
               "    AND glegld  = '",g_glef_m.glefld,"' ",
               "    AND gleg001 = '",g_glef_m.glef001,"' ",
               "    AND gleg002 = '",g_glef_m.glef004,"' ",
               "    AND gleg003 = '",g_glef_m.glef005,"' ",
               "    AND gleg005 = ? ",
               "    AND glegstus = 'Y'  "
   PREPARE aglq941_gleg008p1 FROM l_sql
   DECLARE aglq941_gleg008c1 CURSOR FOR aglq941_gleg008p1 
   
   #對沖公司_直接法[抵銷]金額計算----------------------------
   LET l_sql = " SELECT COALESCE(SUM(CASE gleg015 WHEN '+' THEN gleg008 ELSE gleg008*-1 END),0), ",
               "        COALESCE(SUM(CASE gleg015 WHEN '+' THEN gleg010 ELSE gleg010*-1 END),0), ",
               "        COALESCE(SUM(CASE gleg015 WHEN '+' THEN gleg012 ELSE gleg012*-1 END),0)  ",
               "   FROM gleg_t  ",
               "  WHERE glegent = '",g_enterprise,"' ",
               "    AND glegld  = '",g_glef_m.glefld,"' ",
               "    AND gleg001 = '",g_glef_m.glef001,"' ",
               "    AND gleg002 = '",g_glef_m.glef004,"' ",
               "    AND gleg003 = '",g_glef_m.glef005,"' ",
               "    AND gleg014 = ? ",
               "    AND glegstus = 'Y'  "
   PREPARE aglq941_gleg008p2 FROM l_sql
   DECLARE aglq941_gleg008c2 CURSOR FOR aglq941_gleg008p2
   
   #直接法[調整]金額計算----------------------------
   LET l_sql = " SELECT COALESCE(SUM(CASE gleh007 WHEN '+' THEN gleh009 ELSE gleh009*-1 END),0), ",
               "        COALESCE(SUM(CASE gleh007 WHEN '+' THEN gleh011 ELSE gleh011*-1 END),0), ",
               "        COALESCE(SUM(CASE gleh007 WHEN '+' THEN gleh013 ELSE gleh013*-1 END),0)  ",
               "   FROM gleh_t  ",
               "  WHERE glehent = '",g_enterprise,"' ",
               "    AND glehld  = '",g_glef_m.glefld,"' ",
               "    AND gleh001 = '",g_glef_m.glef001,"' ",
               "    AND gleh003 = '",g_glef_m.glef004,"' ",
               "    AND gleh004 = '",g_glef_m.glef005,"' ",
               "    AND gleh005 = ? ",
               "    AND glehstus = 'Y' "
   PREPARE aglq941_gleh009p1 FROM l_sql
   DECLARE aglq941_gleh009c1 CURSOR FOR aglq941_gleh009p1

   #撈出該上層公司之現金變動碼----------------------------
   LET g_sql = "SELECT DISTINCT glef006, ",
               "       (SELECT nmail004 FROM nmail_t WHERE nmailent = ",g_enterprise," ",
               "           AND nmail001 = (SELECT glaa005 FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_glef_m.glefld,"' ) ",
               "           AND nmail002 = glef006 AND nmail003 = '",g_dlang,"'), ",
               "       0,0,0,0,0,0,0,0,0,0, ",
               "       0,0,0,0,0,0,0,0,0,0, ",
               "       0,0,0,",
               "       glef006, ",
               "       (SELECT nmail004 FROM nmail_t WHERE nmailent = ",g_enterprise," ",
               "           AND nmail001 = (SELECT glaa005 FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_glef_m.glefld,"' ) ",
               "           AND nmail002 = glef006 AND nmail003 = '",g_dlang,"'), ",
               "       0,0,0,0,0,0,0, ",
               "       0,0,0,0,0,0,0,0,0,0,  ",
               "       0,0,0,0,0,0,",
               "       glef006, ",
               "       (SELECT nmail004 FROM nmail_t WHERE nmailent = ",g_enterprise," ",
               "           AND nmail001 = (SELECT glaa005 FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_glef_m.glefld,"' ) ",
               "           AND nmail002 = glef006 AND nmail003 = '",g_dlang,"'), ",
               "       0,0,0,0, ",
               "       0,0,0,0,0,0,0,0,0,0, ",
               "       0,0,0,0,0,0,0,0,0 ",
               "  FROM glef_t ",
               " WHERE glefent = '",g_enterprise,"' ",     
               "   AND glefld = '",g_glef_m.glefld,"' ",                       
               "   AND glef001 = '",g_glef_m.glef001,"' ",
               "   AND glef004 = '",g_glef_m.glef004,"' ",
               "   AND glef005 = '",g_glef_m.glef005,"' "
   PREPARE aglq941_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aglq941_pb1
   
   LET g_cnt = l_ac
   LET l_ac = 1
                                            
   FOREACH b_fill_curs1 INTO g_glef_d[l_ac].glef006,g_glef_d[l_ac].glef006_desc,g_glef_d[l_ac].l_glef011_1,g_glef_d[l_ac].l_glef011_2,
                             g_glef_d[l_ac].l_glef011_3,g_glef_d[l_ac].l_glef011_4,g_glef_d[l_ac].l_glef011_5,g_glef_d[l_ac].l_glef011_6, 
                             g_glef_d[l_ac].l_glef011_7,g_glef_d[l_ac].l_glef011_8,g_glef_d[l_ac].l_glef011_9,g_glef_d[l_ac].l_glef011_10,  
                             g_glef_d[l_ac].l_glef011_11,g_glef_d[l_ac].l_glef011_12,g_glef_d[l_ac].l_glef011_13,g_glef_d[l_ac].l_glef011_14,
                             g_glef_d[l_ac].l_glef011_15,g_glef_d[l_ac].l_glef011_16,g_glef_d[l_ac].l_glef011_17,g_glef_d[l_ac].l_glef011_18,  
                             g_glef_d[l_ac].l_glef011_19,g_glef_d[l_ac].l_glef011_20,g_glef_d[l_ac].l_gleg008,g_glef_d[l_ac].l_gleh009,
                             g_glef_d[l_ac].l_sum,g_glef2_d[l_ac].glef006,g_glef2_d[l_ac].glef006_desc_2,g_glef2_d[l_ac].l_glef011_1_1,
                             g_glef2_d[l_ac].l_glef011_2_1,g_glef2_d[l_ac].l_glef011_3_1,g_glef2_d[l_ac].l_glef011_4_1,g_glef2_d[l_ac].l_glef011_5_1, 
                             g_glef2_d[l_ac].l_glef011_6_1,g_glef2_d[l_ac].l_glef011_7_1,g_glef2_d[l_ac].l_glef011_8_1,g_glef2_d[l_ac].l_glef011_9_1, 
                             g_glef2_d[l_ac].l_glef011_10_1,g_glef2_d[l_ac].l_glef011_11_1,g_glef2_d[l_ac].l_glef011_12_1,g_glef2_d[l_ac].l_glef011_13_1,
                             g_glef2_d[l_ac].l_glef011_14_1,g_glef2_d[l_ac].l_glef011_15_1,g_glef2_d[l_ac].l_glef011_16_1,g_glef2_d[l_ac].l_glef011_17_1,
                             g_glef2_d[l_ac].l_glef011_18_1,g_glef2_d[l_ac].l_glef011_19_1,g_glef2_d[l_ac].l_glef011_20_1,g_glef2_d[l_ac].l_gleg010,     
                             g_glef2_d[l_ac].l_gleh011,g_glef2_d[l_ac].l_sum_2,g_glef3_d[l_ac].glef006,g_glef3_d[l_ac].glef006_desc_3,
                             g_glef3_d[l_ac].l_glef011_1_2,g_glef3_d[l_ac].l_glef011_2_2,g_glef3_d[l_ac].l_glef011_3_2,g_glef3_d[l_ac].l_glef011_4_2, 
                             g_glef3_d[l_ac].l_glef011_5_2,g_glef3_d[l_ac].l_glef011_6_2,g_glef3_d[l_ac].l_glef011_7_2,g_glef3_d[l_ac].l_glef011_8_2, 
                             g_glef3_d[l_ac].l_glef011_9_2,g_glef3_d[l_ac].l_glef011_10_2,g_glef3_d[l_ac].l_glef011_11_2,g_glef3_d[l_ac].l_glef011_12_2,
                             g_glef3_d[l_ac].l_glef011_13_2,g_glef3_d[l_ac].l_glef011_14_2,g_glef3_d[l_ac].l_glef011_15_2,g_glef3_d[l_ac].l_glef011_16_2,
                             g_glef3_d[l_ac].l_glef011_17_2,g_glef3_d[l_ac].l_glef011_18_2,g_glef3_d[l_ac].l_glef011_19_2,g_glef3_d[l_ac].l_glef011_20_2,
                             g_glef3_d[l_ac].l_gleg012,g_glef3_d[l_ac].l_gleh013,g_glef3_d[l_ac].l_sum_3       
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
                        
      #add-point:b_fill段資料填充 name="b_fill.fill"

      CALL l_glef_tit.clear()
      LET l_ac1 = 1
      FOREACH aglq941_glef011c1 USING g_glef_d[l_ac].glef006 INTO l_glef_tit[l_ac1].*
         IF SQLCA.sqlcode THEN
            EXIT FOREACH
         END IF 
         
         FOR l_n = 1 TO l_idx 
            IF l_glef_tit[l_ac1].glef002 = l_glef[l_n].glef002 THEN
               CASE l_n 
                  WHEN 1
                     LET g_glef_d[l_ac].l_glef011_1   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_1_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_1_2 = l_glef_tit[l_ac1].glef017
                  WHEN 2
                     LET g_glef_d[l_ac].l_glef011_2   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_2_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_2_2 = l_glef_tit[l_ac1].glef017
                  WHEN 3
                     LET g_glef_d[l_ac].l_glef011_3   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_3_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_3_2 = l_glef_tit[l_ac1].glef017
                  WHEN 4
                     LET g_glef_d[l_ac].l_glef011_4   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_4_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_4_2 = l_glef_tit[l_ac1].glef017
                  WHEN 5
                     LET g_glef_d[l_ac].l_glef011_5   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_5_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_5_2 = l_glef_tit[l_ac1].glef017
                  WHEN 6
                     LET g_glef_d[l_ac].l_glef011_6   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_6_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_6_2 = l_glef_tit[l_ac1].glef017
                  WHEN 7
                     LET g_glef_d[l_ac].l_glef011_7   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_7_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_7_2 = l_glef_tit[l_ac1].glef017
                  WHEN 8
                     LET g_glef_d[l_ac].l_glef011_8   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_8_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_8_2 = l_glef_tit[l_ac1].glef017
                  WHEN 9
                     LET g_glef_d[l_ac].l_glef011_9   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_9_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_9_2 = l_glef_tit[l_ac1].glef017
                  WHEN 10
                     LET g_glef_d[l_ac].l_glef011_10   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_10_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_10_2 = l_glef_tit[l_ac1].glef017
                  WHEN 11
                     LET g_glef_d[l_ac].l_glef011_11   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_11_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_11_2 = l_glef_tit[l_ac1].glef017
                  WHEN 12
                     LET g_glef_d[l_ac].l_glef011_12   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_12_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_12_2 = l_glef_tit[l_ac1].glef017
                  WHEN 13
                     LET g_glef_d[l_ac].l_glef011_13   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_13_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_13_2 = l_glef_tit[l_ac1].glef017
                  WHEN 14                          
                     LET g_glef_d[l_ac].l_glef011_14   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_14_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_14_2 = l_glef_tit[l_ac1].glef017
                  WHEN 15                          
                     LET g_glef_d[l_ac].l_glef011_15   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_15_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_15_2 = l_glef_tit[l_ac1].glef017
                  WHEN 16                          
                     LET g_glef_d[l_ac].l_glef011_16   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_16_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_16_2 = l_glef_tit[l_ac1].glef017
                  WHEN 17                          
                     LET g_glef_d[l_ac].l_glef011_17   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_17_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_17_2 = l_glef_tit[l_ac1].glef017
                  WHEN 18                          
                     LET g_glef_d[l_ac].l_glef011_18   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_18_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_18_2 = l_glef_tit[l_ac1].glef017
                  WHEN 19                          
                     LET g_glef_d[l_ac].l_glef011_19   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_19_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_19_2 = l_glef_tit[l_ac1].glef017
                  WHEN 20                          
                     LET g_glef_d[l_ac].l_glef011_20   = l_glef_tit[l_ac1].glef011
                     LET g_glef2_d[l_ac].l_glef011_20_1 = l_glef_tit[l_ac1].glef014
                     LET g_glef3_d[l_ac].l_glef011_20_2 = l_glef_tit[l_ac1].glef017
               END CASE
               LET l_ac1 = l_ac1 + 1 
            END IF 
         END FOR
      END FOREACH  

      IF cl_null(g_glef_d[l_ac].l_glef011_1)    THEN LET g_glef_d[l_ac].l_glef011_1 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_2)    THEN LET g_glef_d[l_ac].l_glef011_2 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_3)    THEN LET g_glef_d[l_ac].l_glef011_3 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_4)    THEN LET g_glef_d[l_ac].l_glef011_4 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_5)    THEN LET g_glef_d[l_ac].l_glef011_5 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_6)    THEN LET g_glef_d[l_ac].l_glef011_6 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_7)    THEN LET g_glef_d[l_ac].l_glef011_7 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_8)    THEN LET g_glef_d[l_ac].l_glef011_8 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_9)    THEN LET g_glef_d[l_ac].l_glef011_9 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_10)   THEN LET g_glef_d[l_ac].l_glef011_10 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_11)   THEN LET g_glef_d[l_ac].l_glef011_11 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_12)   THEN LET g_glef_d[l_ac].l_glef011_12 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_13)   THEN LET g_glef_d[l_ac].l_glef011_13 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_14)   THEN LET g_glef_d[l_ac].l_glef011_14 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_15)   THEN LET g_glef_d[l_ac].l_glef011_15 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_16)   THEN LET g_glef_d[l_ac].l_glef011_16 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_17)   THEN LET g_glef_d[l_ac].l_glef011_17 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_18)   THEN LET g_glef_d[l_ac].l_glef011_18 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_19)   THEN LET g_glef_d[l_ac].l_glef011_19 = 0 END IF
      IF cl_null(g_glef_d[l_ac].l_glef011_20)   THEN LET g_glef_d[l_ac].l_glef011_20 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_1_1)  THEN LET g_glef2_d[l_ac].l_glef011_1_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_2_1)  THEN LET g_glef2_d[l_ac].l_glef011_2_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_3_1)  THEN LET g_glef2_d[l_ac].l_glef011_3_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_4_1)  THEN LET g_glef2_d[l_ac].l_glef011_4_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_5_1)  THEN LET g_glef2_d[l_ac].l_glef011_5_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_6_1)  THEN LET g_glef2_d[l_ac].l_glef011_6_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_7_1)  THEN LET g_glef2_d[l_ac].l_glef011_7_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_8_1)  THEN LET g_glef2_d[l_ac].l_glef011_8_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_9_1)  THEN LET g_glef2_d[l_ac].l_glef011_9_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_10_1) THEN LET g_glef2_d[l_ac].l_glef011_10_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_11_1) THEN LET g_glef2_d[l_ac].l_glef011_11_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_12_1) THEN LET g_glef2_d[l_ac].l_glef011_12_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_13_1) THEN LET g_glef2_d[l_ac].l_glef011_13_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_14_1) THEN LET g_glef2_d[l_ac].l_glef011_14_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_15_1) THEN LET g_glef2_d[l_ac].l_glef011_15_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_16_1) THEN LET g_glef2_d[l_ac].l_glef011_16_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_17_1) THEN LET g_glef2_d[l_ac].l_glef011_17_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_18_1) THEN LET g_glef2_d[l_ac].l_glef011_18_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_19_1) THEN LET g_glef2_d[l_ac].l_glef011_19_1 = 0 END IF
      IF cl_null(g_glef2_d[l_ac].l_glef011_20_1) THEN LET g_glef2_d[l_ac].l_glef011_20_1 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_1_2)  THEN LET g_glef3_d[l_ac].l_glef011_1_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_2_2)  THEN LET g_glef3_d[l_ac].l_glef011_2_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_3_2)  THEN LET g_glef3_d[l_ac].l_glef011_3_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_4_2)  THEN LET g_glef3_d[l_ac].l_glef011_4_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_5_2)  THEN LET g_glef3_d[l_ac].l_glef011_5_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_6_2)  THEN LET g_glef3_d[l_ac].l_glef011_6_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_7_2)  THEN LET g_glef3_d[l_ac].l_glef011_7_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_8_2)  THEN LET g_glef3_d[l_ac].l_glef011_8_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_9_2)  THEN LET g_glef3_d[l_ac].l_glef011_9_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_10_2) THEN LET g_glef3_d[l_ac].l_glef011_10_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_11_2) THEN LET g_glef3_d[l_ac].l_glef011_11_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_12_2) THEN LET g_glef3_d[l_ac].l_glef011_12_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_13_2) THEN LET g_glef3_d[l_ac].l_glef011_13_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_14_2) THEN LET g_glef3_d[l_ac].l_glef011_14_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_15_2) THEN LET g_glef3_d[l_ac].l_glef011_15_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_16_2) THEN LET g_glef3_d[l_ac].l_glef011_16_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_17_2) THEN LET g_glef3_d[l_ac].l_glef011_17_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_18_2) THEN LET g_glef3_d[l_ac].l_glef011_18_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_19_2) THEN LET g_glef3_d[l_ac].l_glef011_19_2 = 0 END IF
      IF cl_null(g_glef3_d[l_ac].l_glef011_20_2) THEN LET g_glef3_d[l_ac].l_glef011_20_2 = 0 END IF
        
      #計算來源公司抵銷金額
      LET l_gleg008 = 0
      LET l_gleg010 = 0
      LET l_gleg012 = 0
      EXECUTE aglq941_gleg008c1 USING g_glef_d[l_ac].glef006 INTO l_gleg008,l_gleg010,l_gleg012
      
      #計算對沖公司抵銷金額
      LET l_gleg0081 = 0
      LET l_gleg0101 = 0
      LET l_gleg0121 = 0
      EXECUTE aglq941_gleg008c2 USING g_glef_d[l_ac].glef006 INTO l_gleg0081,l_gleg0101,l_gleg0121
     
      #抵銷金額
      LET g_glef_d[l_ac].l_gleg008 = l_gleg008 + l_gleg0081
      LET g_glef2_d[l_ac].l_gleg010 = l_gleg010 + l_gleg0101
      LET g_glef3_d[l_ac].l_gleg012 = l_gleg012 + l_gleg0121
     
      #計算公司調整金額
      EXECUTE aglq941_gleh009c1 USING g_glef_d[l_ac].glef006 INTO g_glef_d[l_ac].l_gleh009,g_glef2_d[l_ac].l_gleh011,g_glef3_d[l_ac].l_gleh013

      LET g_glef_d[l_ac].l_sum = g_glef_d[l_ac].l_glef011_1 + g_glef_d[l_ac].l_glef011_2 + g_glef_d[l_ac].l_glef011_3 + g_glef_d[l_ac].l_glef011_4 +
                                 g_glef_d[l_ac].l_glef011_5 + g_glef_d[l_ac].l_glef011_6 + g_glef_d[l_ac].l_glef011_7 + g_glef_d[l_ac].l_glef011_8 +
                                 g_glef_d[l_ac].l_glef011_9 + g_glef_d[l_ac].l_glef011_10 + g_glef_d[l_ac].l_glef011_11 + g_glef_d[l_ac].l_glef011_12 + 
                                 g_glef_d[l_ac].l_glef011_13 + g_glef_d[l_ac].l_glef011_14 + g_glef_d[l_ac].l_glef011_15 + g_glef_d[l_ac].l_glef011_16 + 
                                 g_glef_d[l_ac].l_glef011_17 + g_glef_d[l_ac].l_glef011_18 + g_glef_d[l_ac].l_glef011_19 + g_glef_d[l_ac].l_glef011_20 + 
                                 g_glef_d[l_ac].l_gleg008 + g_glef_d[l_ac].l_gleh009
 
      LET g_glef2_d[l_ac].l_sum_2 = g_glef2_d[l_ac].l_glef011_1_1 + g_glef2_d[l_ac].l_glef011_2_1 + g_glef2_d[l_ac].l_glef011_3_1 + g_glef2_d[l_ac].l_glef011_4_1 +
                                    g_glef2_d[l_ac].l_glef011_5_1 + g_glef2_d[l_ac].l_glef011_6_1 + g_glef2_d[l_ac].l_glef011_7_1 + g_glef2_d[l_ac].l_glef011_8_1 + 
                                    g_glef2_d[l_ac].l_glef011_9_1 + g_glef2_d[l_ac].l_glef011_10_1 +g_glef2_d[l_ac].l_glef011_11_1 +g_glef2_d[l_ac].l_glef011_12_1 +
                                    g_glef2_d[l_ac].l_glef011_13_1 + g_glef2_d[l_ac].l_glef011_14_1 + g_glef2_d[l_ac].l_glef011_15_1 + g_glef2_d[l_ac].l_glef011_16_1 + 
                                    g_glef2_d[l_ac].l_glef011_17_1 + g_glef2_d[l_ac].l_glef011_18_1 + g_glef2_d[l_ac].l_glef011_19_1 + g_glef2_d[l_ac].l_glef011_20_1 + 
                                    g_glef2_d[l_ac].l_gleg010 + g_glef2_d[l_ac].l_gleh011
      
      LET g_glef3_d[l_ac].l_sum_3 = g_glef3_d[l_ac].l_glef011_1_2 + g_glef3_d[l_ac].l_glef011_2_2 + g_glef3_d[l_ac].l_glef011_3_2 + g_glef3_d[l_ac].l_glef011_4_2 + 
                                    g_glef3_d[l_ac].l_glef011_5_2 + g_glef3_d[l_ac].l_glef011_6_2 + g_glef3_d[l_ac].l_glef011_7_2 + g_glef3_d[l_ac].l_glef011_8_2 + 
                                    g_glef3_d[l_ac].l_glef011_9_2 + g_glef3_d[l_ac].l_glef011_10_2 + g_glef3_d[l_ac].l_glef011_11_2 + g_glef3_d[l_ac].l_glef011_12_2 + 
                                    g_glef3_d[l_ac].l_glef011_13_2 + g_glef3_d[l_ac].l_glef011_14_2 + g_glef3_d[l_ac].l_glef011_15_2 + g_glef3_d[l_ac].l_glef011_16_2 + 
                                    g_glef3_d[l_ac].l_glef011_17_2 + g_glef3_d[l_ac].l_glef011_18_2 + g_glef3_d[l_ac].l_glef011_19_2 + g_glef3_d[l_ac].l_glef011_20_2 + 
                                    g_glef3_d[l_ac].l_gleg012 + g_glef3_d[l_ac].l_gleh013 

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

   CALL g_glef_d.deleteElement(l_ac)
   CALL g_glef2_d.deleteElement(l_ac)
   CALL g_glef3_d.deleteElement(l_ac)

   #CALL g_glef_d.deleteElement(g_glef_d.getLength())
   #CALL g_glef2_d.deleteElement(g_glef2_d.getLength())
   #CALL g_glef3_d.deleteElement(g_glef3_d.getLength())
   
   #add-point:b_fill段more name="b_fill.more"
   #欄位隱顯
   FOR l_m0 = 1 TO l_idx
      LET l_glef002_desc = ''
      SELECT gldal003 INTO l_glef002_desc
        FROM gldal_t
       WHERE gldalent = g_enterprise
         AND gldal001 = l_glef[l_m0].glef002
         AND gldal002 = g_dlang
   
       LET l_msg1= l_glef002_desc CLIPPED
       LET l_msg2= "l_glef011_",l_m0 USING "<<<<<"
       LET l_msg2_1= l_msg2 CLIPPED,"_1" 
       LET l_msg2_2= l_msg2 CLIPPED,"_2" 
       CALL cl_set_comp_visible(l_msg2,TRUE)
       CALL cl_set_comp_visible(l_msg2_1,TRUE)
       CALL cl_set_comp_visible(l_msg2_2,TRUE)
       CALL cl_set_comp_att_text(l_msg2,l_msg1 CLIPPED)
       CALL cl_set_comp_att_text(l_msg2_1,l_msg1 CLIPPED)
       CALL cl_set_comp_att_text(l_msg2_2,l_msg1 CLIPPED)
   END FOR
   
   FOR l_m1 = l_idx + 1 TO 20
       LET l_msg2= "l_glef011_",l_m1 USING "<<<<<"
       LET l_msg2_1= l_msg2 CLIPPED,"_1" 
       LET l_msg2_2= l_msg2 CLIPPED,"_2" 
       CALL cl_set_comp_visible(l_msg2,FALSE)
       CALL cl_set_comp_visible(l_msg2_1,FALSE)
       CALL cl_set_comp_visible(l_msg2_2,FALSE)
   END FOR
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_glef_d.getLength()
      LET g_glef_d_mask_o[l_ac].* =  g_glef_d[l_ac].*
      CALL aglq941_glef_t_mask()
      LET g_glef_d_mask_n[l_ac].* =  g_glef_d[l_ac].*
   END FOR
   
   LET g_glef2_d_mask_o.* =  g_glef2_d.*
   FOR l_ac = 1 TO g_glef2_d.getLength()
      LET g_glef2_d_mask_o[l_ac].* =  g_glef2_d[l_ac].*
      CALL aglq941_glef_t_mask()
      LET g_glef2_d_mask_n[l_ac].* =  g_glef2_d[l_ac].*
   END FOR
   LET g_glef3_d_mask_o.* =  g_glef3_d.*
   FOR l_ac = 1 TO g_glef3_d.getLength()
      LET g_glef3_d_mask_o[l_ac].* =  g_glef3_d[l_ac].*
      CALL aglq941_glef_t_mask()
      LET g_glef3_d_mask_n[l_ac].* =  g_glef3_d[l_ac].*
   END FOR
   
   FREE aglq941_pb1  
   RETURN
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF aglq941_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY glef_t.glef006"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
 
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aglq941_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aglq941_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_glef_m.glefld,g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_glef_m.glefld,g_glef_m.glef001,g_glef_m.glef004,g_glef_m.glef005 INTO g_glef_d[l_ac].glef006, 
          g_glef2_d[l_ac].glef006,g_glef3_d[l_ac].glef006   #(ver:49)
                             
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
 
            CALL g_glef_d.deleteElement(g_glef_d.getLength())
      CALL g_glef2_d.deleteElement(g_glef2_d.getLength())
      CALL g_glef3_d.deleteElement(g_glef3_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_glef_d.getLength()
      LET g_glef_d_mask_o[l_ac].* =  g_glef_d[l_ac].*
      CALL aglq941_glef_t_mask()
      LET g_glef_d_mask_n[l_ac].* =  g_glef_d[l_ac].*
   END FOR
   
   LET g_glef2_d_mask_o.* =  g_glef2_d.*
   FOR l_ac = 1 TO g_glef2_d.getLength()
      LET g_glef2_d_mask_o[l_ac].* =  g_glef2_d[l_ac].*
      CALL aglq941_glef_t_mask()
      LET g_glef2_d_mask_n[l_ac].* =  g_glef2_d[l_ac].*
   END FOR
   LET g_glef3_d_mask_o.* =  g_glef3_d.*
   FOR l_ac = 1 TO g_glef3_d.getLength()
      LET g_glef3_d_mask_o[l_ac].* =  g_glef3_d[l_ac].*
      CALL aglq941_glef_t_mask()
      LET g_glef3_d_mask_n[l_ac].* =  g_glef3_d[l_ac].*
   END FOR
 
 
   FREE aglq941_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aglq941_idx_chk()
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
      IF g_detail_idx > g_glef_d.getLength() THEN
         LET g_detail_idx = g_glef_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_glef_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glef_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_glef2_d.getLength() THEN
         LET g_detail_idx = g_glef2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_glef2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glef2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_glef3_d.getLength() THEN
         LET g_detail_idx = g_glef3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_glef3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glef3_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq941_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_glef_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION aglq941_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM glef_t
    WHERE glefent = g_enterprise AND glefld = g_glef_m.glefld AND
                              glef001 = g_glef_m.glef001 AND
                              glef004 = g_glef_m.glef004 AND
                              glef005 = g_glef_m.glef005 AND
 
          glef006 = g_glef_d_t.glef006
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "glef_t:",SQLERRMESSAGE 
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
 
{<section id="aglq941.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aglq941_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="aglq941.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aglq941_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="aglq941.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aglq941_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="aglq941.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION aglq941_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_glef_d[l_ac].glef006 = g_glef_d_t.glef006 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aglq941_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aglq941.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aglq941_lock_b(ps_table,ps_page)
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
   #CALL aglq941_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglq941.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aglq941_unlock_b(ps_table,ps_page)
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
 
{<section id="aglq941.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aglq941_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("glefld,glef001,glef004,glef005",TRUE)
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
 
{<section id="aglq941.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aglq941_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("glefld,glef001,glef004,glef005",FALSE)
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
 
{<section id="aglq941.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aglq941_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aglq941_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aglq941_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq941.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aglq941_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq941.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aglq941_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq941.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aglq941_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq941.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aglq941_default_search()
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
      LET ls_wc = ls_wc, " glefld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glef001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " glef004 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " glef005 = '", g_argv[04], "' AND "
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
 
{<section id="aglq941.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aglq941_fill_chk(ps_idx)
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
 
{<section id="aglq941.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION aglq941_modify_detail_chk(ps_record)
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
         LET ls_return = "glef006"
      WHEN "s_detail2"
         LET ls_return = "glef006_2"
      WHEN "s_detail3"
         LET ls_return = "glef006_3"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aglq941.mask_functions" >}
&include "erp/agl/aglq941_mask.4gl"
 
{</section>}
 
{<section id="aglq941.state_change" >}
    
 
{</section>}
 
{<section id="aglq941.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aglq941_set_pk_array()
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
   LET g_pk_array[1].values = g_glef_m.glefld
   LET g_pk_array[1].column = 'glefld'
   LET g_pk_array[2].values = g_glef_m.glef001
   LET g_pk_array[2].column = 'glef001'
   LET g_pk_array[3].values = g_glef_m.glef004
   LET g_pk_array[3].column = 'glef004'
   LET g_pk_array[4].values = g_glef_m.glef005
   LET g_pk_array[4].column = 'glef005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglq941.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aglq941_msgcentre_notify(lc_state)
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
   CALL aglq941_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_glef_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglq941.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 依帳套設定隱顯其他本位幣頁籤
# Memo...........: 
# Usage..........: aglq941_ld_visible()
# Date & Author..: 160624 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq941_ld_visible()
   DEFINE l_glaa RECORD 
                 glaa001 LIKE glaa_t.glaa001,
                 glaa015 LIKE glaa_t.glaa015,
                 glaa016 LIKE glaa_t.glaa016,
                 glaa019 LIKE glaa_t.glaa019,
                 glaa020 LIKE glaa_t.glaa020                 
                 END RECORD
                 
   IF cl_null(g_glef_m.glefld)THEN RETURN END IF
   INITIALIZE l_glaa.* TO NULL        
   SELECT glaa001,glaa015,glaa016,glaa019,glaa020 INTO l_glaa.*
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_glef_m.glefld
      
   CALL cl_set_comp_visible('lbl_glef012,glef012,page_1',TRUE)
   CALL cl_set_comp_visible('lbl_glef015,glef015,page_2',TRUE)
   LET g_glef_m.glef009 = l_glaa.glaa001
   DISPLAY BY NAME g_glef_m.glef009
   IF l_glaa.glaa015 = 'N' THEN
      CALL cl_set_comp_visible('lbl_glef012,glef012,page_1',FALSE)
   ELSE
      LET g_glef_m.glef012 = l_glaa.glaa016
      DISPLAY BY NAME g_glef_m.glef012
   END IF
   
   IF l_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('lbl_glef015,glef015,page_2',FALSE)
   ELSE
      LET g_glef_m.glef015 = l_glaa.glaa020
      DISPLAY BY NAME g_glef_m.glef015      
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 二次查詢
# Memo...........: 
# Usage..........: aglq941_filter2()
# Date & Author..: 160624 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq941_filter2()
     
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF 
   LET INT_FLAG = 0
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
   LET l_ac = 1
   LET g_glef_d[l_ac].glef006 =''
   DISPLAY ARRAY g_glef_d TO s_detail1.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT g_wc_filter ON glef006 FROM s_detail1[1].glef006
         BEFORE CONSTRUCT
         CALL aglq941_get_title('glef006')
         ON ACTION controlp INFIELD glef006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO glef006  #顯示到畫面上
            NEXT FIELD glef006
         END CONSTRUCT
 
      BEFORE DIALOG
      
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
   CALL aglq941_filter_show2('glef006',TRUE)
END FUNCTION

################################################################################
# Descriptions...: 依條件顯示欄位頭
# Memo...........: p_work=T,查詢條件記載在欄位頭
#                  p_work=F,還原欄位頭名稱         
# Date & Author..: 160624 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq941_filter_show2(ps_field,p_work)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   DEFINE p_work           BOOLEAN
   
   LET ls_name = 'glef_t.',ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF  ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
   
   #顯示資料組合
   IF p_work THEN
      LET ls_condition = aglq941_filter_parser(ps_field)
      IF NOT cl_null(ls_condition) THEN
         LET ls_title = ls_title, '※', ls_condition, '※'
      END IF
   END IF
   
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
   
END FUNCTION

################################################################################
# Descriptions...: 取得欄位TITLE的搜尋條件
# Memo...........:
# Date & Author..: 160624 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq941_get_title(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE r_search         STRING
   DEFINE ls_name          STRING
   
   LET ls_name = 'glef_t.',ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   
   IF  ls_title.getIndexOf('※',1) > 0 THEN
      LEt r_search = ls_title.subString(ls_title.getIndexOf('※',1)+1,ls_title.getLength()-1)
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
      CALL lnode_item.setAttribute("text",ls_title)
   ELSE
      LET r_search = ''
   END IF
   LET g_glef_d[1].glef006 = r_search.trim()
   DISPLAY g_glef_d[1].glef006 TO s_detail1[1].glef006
END FUNCTION

################################################################################
# Descriptions...: 資料上傳
# Memo...........:
# Usage..........: CALL aglq941_ins_glen()
# Date & Author..: 160628 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq941_ins_glen()
DEFINE l_sql         STRING
DEFINE l_i           LIKE type_t.num5
DEFINE l_glef001     LIKE glef_t.glef001
DEFINE l_glen        RECORD 
         glenent	   LIKE glen_t.glenent,	     #企業編號
         glenld	   LIKE glen_t.glenld,	     #合併帳套
         glen001	   LIKE glen_t.glen001,	     #上層公司
         glen002	   LIKE glen_t.glen002,	     #帳套
         glen003	   LIKE glen_t.glen003,	     #年度
         glen004	   LIKE glen_t.glen004,	     #期別
         glen005	   LIKE glen_t.glen005,	     #現金變動碼
         glen006	   LIKE glen_t.glen006,	     #幣別(記帳幣)
         glen007	   LIKE glen_t.glen007,	     #金額(記帳幣)
         glen008	   LIKE glen_t.glen008,	     #幣別(功能幣)
         glen009	   LIKE glen_t.glen009,	     #金額(功能幣)
         glen010	   LIKE glen_t.glen010,	     #幣別(報告幣)
         glen011	   LIKE glen_t.glen011	     #金額(報告幣)
                     END RECORD 
DEFINE r_success     LIKE type_t.num5

   IF cl_null(g_glef_m.glefld) OR cl_null(g_glef_m.glef001) OR
      cl_null(g_glef_m.glef004) OR cl_null(g_glef_m.glef005) THEN
      RETURN 
   END IF

   LET r_success = TRUE
   CALL s_transaction_begin()
   CALL cl_err_collect_init()

   INITIALIZE l_glen.* TO NULL

   #個體公司帳別
   LET l_glef001=''
   CALL s_merge_get_gl_ld(g_glef_m.glefld,g_glef_m.glef001) RETURNING l_glef001

   #因可重覆執行,寫入前先刪除資料
   DELETE FROM glen_t 
    WHERE glenent = g_enterprise 
      AND glenld = g_glef_m.glefld  
      AND glen001 = g_glef_m.glef001
      AND glen003 = g_glef_m.glef004
      AND glen004 = g_glef_m.glef005

   LET l_i = 1
   FOR l_i = 1 TO g_glef_d.getLength() 
      LET l_glen.glenent = g_enterprise
      LET l_glen.glenld  = g_glef_m.glefld 
      LET l_glen.glen001 = g_glef_m.glef001
      LET l_glen.glen002 = l_glef001
      LET l_glen.glen003 = g_glef_m.glef004
      LET l_glen.glen004 = g_glef_m.glef005
      LET l_glen.glen005 = g_glef_d[l_i].glef006
      LET l_glen.glen006 = g_glef_m.glef009
      LET l_glen.glen007 = g_glef_d[l_i].l_sum
      LET l_glen.glen008 = g_glef_m.glef012
      LET l_glen.glen009 = g_glef2_d[l_i].l_sum_2
      LET l_glen.glen010 = g_glef_m.glef015
      LET l_glen.glen011 = g_glef3_d[l_i].l_sum_3

      INSERT INTO glen_t(glenent,glenld,glen001,glen002,glen003,
                         glen004,glen005,glen006,glen007,glen008,
                         glen009,glen010,glen011)
           VALUES(l_glen.*)
           
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins_glen wrong!!"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOR
      END IF
   END FOR

   IF r_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'azz-00322'   #產生成功
      LET g_errparam.extend = g_glef_m.glefld,"+",g_glef_m.glef001,"+",g_glef_m.glef004,"+",g_glef_m.glef005 
      LET g_errparam.popup = TRUE
      CALL cl_err()  
      CALL s_transaction_end('Y','0') 
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00146'   #產生失敗
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()  
      CALL s_transaction_end('N','0')       
   END IF
   CALL cl_err_collect_show()
   
   RETURN

END FUNCTION

 
{</section>}
 
