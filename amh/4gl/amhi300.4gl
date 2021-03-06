#該程式未解開Section, 採用最新樣板產出!
{<section id="amhi300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-11-05 16:47:52), PR版次:0005(2016-10-19 16:39:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: amhi300
#+ Description: 專櫃資料維護作業
#+ Creator....: 06189(2015-04-03 13:44:36)
#+ Modifier...: 02003 -SD/PR- 06814
 
{</section>}
 
{<section id="amhi300.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#30  2016/04/08 by 07959   將重複內容的錯誤訊息置換為公用錯誤訊息
#161006-00008#2   2016/10/19 by 06814   aooi500邏輯修正
#161006-00008#7   2016/10/19 By 06137   組織類型與職能開窗清單調整
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
PRIVATE type type_g_mhae_m        RECORD
       mhaesite LIKE mhae_t.mhaesite, 
   mhaesite_desc LIKE type_t.chr80, 
   mhae020 LIKE mhae_t.mhae020, 
   mhae020_desc LIKE type_t.chr80, 
   mhae021 LIKE mhae_t.mhae021, 
   mhae021_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mhae_d        RECORD
       mhaestus LIKE mhae_t.mhaestus, 
   mhae001 LIKE mhae_t.mhae001, 
   mhael023 LIKE mhael_t.mhael023, 
   mhael024 LIKE mhael_t.mhael024, 
   mhae002 LIKE mhae_t.mhae002, 
   mhae002_desc LIKE type_t.chr500, 
   mhae003 LIKE mhae_t.mhae003, 
   mhae006 LIKE mhae_t.mhae006, 
   mhae006_desc LIKE type_t.chr500, 
   mhae004 LIKE mhae_t.mhae004, 
   mhae004_desc LIKE type_t.chr500, 
   mhae005 LIKE mhae_t.mhae005, 
   mhae007 LIKE mhae_t.mhae007, 
   mhae007_desc LIKE type_t.chr500, 
   mhae007_desc_1 LIKE type_t.chr500, 
   mhae008 LIKE mhae_t.mhae008, 
   mhae008_desc LIKE type_t.chr500, 
   mhae008_desc_1 LIKE type_t.chr500, 
   mhae009 LIKE mhae_t.mhae009, 
   mhae009_desc LIKE type_t.chr500, 
   mhae010 LIKE mhae_t.mhae010, 
   mhae010_desc LIKE type_t.chr500, 
   mhae011 LIKE mhae_t.mhae011, 
   mhae011_desc LIKE type_t.chr500, 
   mhae012 LIKE mhae_t.mhae012, 
   mhae012_desc LIKE type_t.chr500, 
   mhae013 LIKE mhae_t.mhae013, 
   mhae014 LIKE mhae_t.mhae014, 
   mhae014_desc LIKE type_t.chr500, 
   mhae015 LIKE mhae_t.mhae015, 
   mhae016 LIKE mhae_t.mhae016, 
   mhae017 LIKE mhae_t.mhae017, 
   mhae018 LIKE mhae_t.mhae018, 
   mhae018_desc LIKE type_t.chr500, 
   mhae022 LIKE mhae_t.mhae022, 
   mhae019 LIKE mhae_t.mhae019, 
   mhae023 LIKE type_t.chr20, 
   mhae024 LIKE type_t.num15_3, 
   mhae025 LIKE type_t.num15_3, 
   mhae026 LIKE type_t.chr500, 
   mhae027 LIKE type_t.chr10, 
   mhae027_desc LIKE type_t.chr500, 
   mhae028 LIKE type_t.chr20, 
   mhae028_desc LIKE type_t.chr500, 
   mhae029 LIKE type_t.chr1, 
   mhae030 LIKE type_t.chr10, 
   mhae030_desc LIKE type_t.chr500, 
   mhae031 LIKE type_t.chr10, 
   mhae031_desc LIKE type_t.chr500, 
   mhae032 LIKE type_t.chr10, 
   mhae032_desc LIKE type_t.chr500, 
   mhae033 LIKE type_t.chr10, 
   mhae033_desc LIKE type_t.chr500, 
   mhae034 LIKE type_t.chr10, 
   mhae034_desc LIKE type_t.chr500, 
   mhae035 LIKE type_t.chr1, 
   mhae036 LIKE type_t.chr10, 
   mhae036_desc LIKE type_t.chr500, 
   mhae037 LIKE type_t.chr1, 
   mhae038 LIKE type_t.chr1, 
   mhae039 LIKE mhae_t.mhae039
       END RECORD
PRIVATE TYPE type_g_mhae2_d RECORD
       mhae001 LIKE mhae_t.mhae001, 
   mhaeownid LIKE mhae_t.mhaeownid, 
   mhaeownid_desc LIKE type_t.chr500, 
   mhaeowndp LIKE mhae_t.mhaeowndp, 
   mhaeowndp_desc LIKE type_t.chr500, 
   mhaecrtid LIKE mhae_t.mhaecrtid, 
   mhaecrtid_desc LIKE type_t.chr500, 
   mhaecrtdp LIKE mhae_t.mhaecrtdp, 
   mhaecrtdp_desc LIKE type_t.chr500, 
   mhaecrtdt DATETIME YEAR TO SECOND, 
   mhaemodid LIKE mhae_t.mhaemodid, 
   mhaemodid_desc LIKE type_t.chr500, 
   mhaemoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag   LIKE type_t.num5        
#end add-point
 
DEFINE g_detail_multi_table_t    RECORD
      mhael001 LIKE mhael_t.mhael001,
      mhael020 LIKE mhael_t.mhael020,
      mhael021 LIKE mhael_t.mhael021,
      mhael022 LIKE mhael_t.mhael022,
      mhael023 LIKE mhael_t.mhael023,
      mhael024 LIKE mhael_t.mhael024
      END RECORD
 
#模組變數(Module Variables)
DEFINE g_mhae_m          type_g_mhae_m
DEFINE g_mhae_m_t        type_g_mhae_m
DEFINE g_mhae_m_o        type_g_mhae_m
DEFINE g_mhae_m_mask_o   type_g_mhae_m #轉換遮罩前資料
DEFINE g_mhae_m_mask_n   type_g_mhae_m #轉換遮罩後資料
 
   DEFINE g_mhaesite_t LIKE mhae_t.mhaesite
DEFINE g_mhae020_t LIKE mhae_t.mhae020
DEFINE g_mhae021_t LIKE mhae_t.mhae021
 
 
DEFINE g_mhae_d          DYNAMIC ARRAY OF type_g_mhae_d
DEFINE g_mhae_d_t        type_g_mhae_d
DEFINE g_mhae_d_o        type_g_mhae_d
DEFINE g_mhae_d_mask_o   DYNAMIC ARRAY OF type_g_mhae_d #轉換遮罩前資料
DEFINE g_mhae_d_mask_n   DYNAMIC ARRAY OF type_g_mhae_d #轉換遮罩後資料
DEFINE g_mhae2_d   DYNAMIC ARRAY OF type_g_mhae2_d
DEFINE g_mhae2_d_t type_g_mhae2_d
DEFINE g_mhae2_d_o type_g_mhae2_d
DEFINE g_mhae2_d_mask_o   DYNAMIC ARRAY OF type_g_mhae2_d #轉換遮罩前資料
DEFINE g_mhae2_d_mask_n   DYNAMIC ARRAY OF type_g_mhae2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_mhaesite LIKE mhae_t.mhaesite,
   b_mhaesite_desc LIKE type_t.chr80,
      b_mhae020 LIKE mhae_t.mhae020,
   b_mhae020_desc LIKE type_t.chr80,
      b_mhae021 LIKE mhae_t.mhae021,
   b_mhae021_desc LIKE type_t.chr80
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
 
{<section id="amhi300.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amh","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mhaesite,'',mhae020,'',mhae021,''", 
                      " FROM mhae_t",
                      " WHERE mhaeent= ? AND mhaesite=? AND mhae020=? AND mhae021=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amhi300_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mhaesite,t0.mhae020,t0.mhae021,t1.ooefl003 ,t2.mhaal003 ,t3.mhabl004", 
 
               " FROM mhae_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mhaesite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhaal_t t2 ON t2.mhaalent="||g_enterprise||" AND t2.mhaal001=t0.mhae020 AND t2.mhaal002='"||g_dlang||"' ",
               " LEFT JOIN mhabl_t t3 ON t3.mhablent="||g_enterprise||" AND t3.mhabl001=t0.mhae020 AND t3.mhabl002=t0.mhae021 AND t3.mhabl003='"||g_dlang||"' ",
 
               " WHERE t0.mhaeent = " ||g_enterprise|| " AND t0.mhaesite = ? AND t0.mhae020 = ? AND t0.mhae021 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE amhi300_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amhi300 WITH FORM cl_ap_formpath("amh",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amhi300_init()   
 
      #進入選單 Menu (="N")
      CALL amhi300_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amhi300
      
   END IF 
   
   CLOSE amhi300_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amhi300.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION amhi300_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('mhaestus','50','N,Y,X')
 
      CALL cl_set_combo_scc('mhae003','6013') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('mhae003','6013')
   CALL cl_set_combo_scc('mhae015','6201')
   CALL cl_set_combo_scc('mhae005','6776')
   CALL cl_set_combo_scc('mhae029','6786')
   CALL cl_set_combo_scc('mhae038','6202') 
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
   
   CALL amhi300_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="amhi300.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION amhi300_ui_dialog()
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
         INITIALIZE g_mhae_m.* TO NULL
         CALL g_mhae_d.clear()
         CALL g_mhae2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL amhi300_init()
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
               CALL amhi300_idx_chk()
               CALL amhi300_fetch('') # reload data
               LET g_detail_idx = 1
               CALL amhi300_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_mhae_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL amhi300_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL amhi300_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_mhae2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL amhi300_idx_chk()
               CALL amhi300_ui_detailshow()
               
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
            CALL amhi300_browser_fill("")
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
               CALL amhi300_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL amhi300_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL amhi300_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL amhi300_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amhi300_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL amhi300_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amhi300_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL amhi300_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amhi300_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL amhi300_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amhi300_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL amhi300_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amhi300_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_mhae_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_mhae2_d)
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
               NEXT FIELD mhae001
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
               CALL amhi300_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL amhi300_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL amhi300_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL amhi300_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL amhi300_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL amhi300_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amhi300_insert()
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL amhi300_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL amhi300_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amhi300_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amhi300_set_pk_array()
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
 
{<section id="amhi300.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION amhi300_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="amhi300.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION amhi300_browser_fill(ps_page_action)
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
   DEFINE l_where           STRING
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   #CALL s_aooi500_sql_where(g_prog,'mhabsite') RETURNING l_where   #161006-00008#2 20161017 mark by beckxie
   #161006-00008#2 20161017 add by beckxie---S
   CALL s_aooi500_sql_where(g_prog,'mhaesite') RETURNING l_where
   IF cl_null(g_wc) THEN
      LET g_wc = l_where
   ELSE
      LET g_wc = g_wc , " AND ",l_where 
   END IF
   #161006-00008#2 20161017 add by beckxie---S
   #end add-point    
 
   LET l_searchcol = "mhaesite,mhae020,mhae021"
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
      LET l_sub_sql = " SELECT DISTINCT mhaesite ",
                      ", mhae020 ",
                      ", mhae021 ",
 
                      " FROM mhae_t ",
                      " ",
                      " LEFT JOIN mhael_t ON mhaelent = "||g_enterprise||" AND mhaelsite = '"||g_site||"' AND mhae001 = mhael001 AND mhae020 = mhael020 AND mhae021 = mhael021 AND mhael022 = '",g_dlang,"' ", 
 
 
 
                      " WHERE mhaeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mhae_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mhaesite ",
                      ", mhae020 ",
                      ", mhae021 ",
 
                      " FROM mhae_t ",
                      " ",
                      " LEFT JOIN mhael_t ON mhaelent = "||g_enterprise||" AND mhaelsite = '"||g_site||"' AND mhae001 = mhael001 AND mhae020 = mhael020 AND mhae021 = mhael021 AND mhael022 = '",g_dlang,"' ", 
 
 
                      " WHERE mhaeent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mhae_t")
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
      INITIALIZE g_mhae_m.* TO NULL
      CALL g_mhae_d.clear()        
      CALL g_mhae2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mhaesite,t0.mhae020,t0.mhae021 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.mhaesite,t0.mhae020,t0.mhae021,t1.ooefl003 ,t2.mhaal003 ,t3.mhabl004", 
 
                " FROM mhae_t t0",
                #" ",
                " LEFT JOIN mhael_t ON mhaelent = "||g_enterprise||" AND mhaelsite = '"||g_site||"' AND mhae001 = mhael001 AND mhae020 = mhael020 AND mhae021 = mhael021 AND mhael022 = '",g_dlang,"' ",
 
 
 
                               " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mhaesite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhaal_t t2 ON t2.mhaalent="||g_enterprise||" AND t2.mhaal001=t0.mhae020 AND t2.mhaal002='"||g_dlang||"' ",
               " LEFT JOIN mhabl_t t3 ON t3.mhablent="||g_enterprise||" AND t3.mhabl001=t0.mhae020 AND t3.mhabl002=t0.mhae021 AND t3.mhabl003='"||g_dlang||"' ",
 
                " WHERE t0.mhaeent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("mhae_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"mhae_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_mhaesite,g_browser[g_cnt].b_mhae020,g_browser[g_cnt].b_mhae021, 
          g_browser[g_cnt].b_mhaesite_desc,g_browser[g_cnt].b_mhae020_desc,g_browser[g_cnt].b_mhae021_desc  
 
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
         CALL amhi300_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_mhaesite) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_mhae_m.* TO NULL
      CALL g_mhae_d.clear()
      CALL g_mhae2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL amhi300_fetch('')
   
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
 
{<section id="amhi300.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION amhi300_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mhae_m.mhaesite = g_browser[g_current_idx].b_mhaesite   
   LET g_mhae_m.mhae020 = g_browser[g_current_idx].b_mhae020   
   LET g_mhae_m.mhae021 = g_browser[g_current_idx].b_mhae021   
 
   EXECUTE amhi300_master_referesh USING g_mhae_m.mhaesite,g_mhae_m.mhae020,g_mhae_m.mhae021 INTO g_mhae_m.mhaesite, 
       g_mhae_m.mhae020,g_mhae_m.mhae021,g_mhae_m.mhaesite_desc,g_mhae_m.mhae020_desc,g_mhae_m.mhae021_desc 
 
   CALL amhi300_show()
   
END FUNCTION
 
{</section>}
 
{<section id="amhi300.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION amhi300_ui_detailshow()
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
 
{<section id="amhi300.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION amhi300_ui_browser_refresh()
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
      IF g_browser[l_i].b_mhaesite = g_mhae_m.mhaesite 
         AND g_browser[l_i].b_mhae020 = g_mhae_m.mhae020 
         AND g_browser[l_i].b_mhae021 = g_mhae_m.mhae021 
 
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
 
{<section id="amhi300.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION amhi300_construct()
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
   INITIALIZE g_mhae_m.* TO NULL
   CALL g_mhae_d.clear()
   CALL g_mhae2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON mhaesite,mhae020,mhae021
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.mhaesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaesite
            #add-point:ON ACTION controlp INFIELD mhaesite name="construct.c.mhaesite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhaesite',g_site,'c')   
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhaesite  #顯示到畫面上
            NEXT FIELD mhaesite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaesite
            #add-point:BEFORE FIELD mhaesite name="construct.b.mhaesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaesite
            
            #add-point:AFTER FIELD mhaesite name="construct.a.mhaesite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhae020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae020
            #add-point:ON ACTION controlp INFIELD mhae020 name="construct.c.mhae020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae020  #顯示到畫面上
            NEXT FIELD mhae020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae020
            #add-point:BEFORE FIELD mhae020 name="construct.b.mhae020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae020
            
            #add-point:AFTER FIELD mhae020 name="construct.a.mhae020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhae021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae021
            #add-point:ON ACTION controlp INFIELD mhae021 name="construct.c.mhae021"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae021  #顯示到畫面上
            NEXT FIELD mhae021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae021
            #add-point:BEFORE FIELD mhae021 name="construct.b.mhae021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae021
            
            #add-point:AFTER FIELD mhae021 name="construct.a.mhae021"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON mhaestus,mhae001,mhael023,mhael024,mhae002,mhae003,mhae006,mhae004,mhae005, 
          mhae007,mhae008,mhae009,mhae010,mhae011,mhae012,mhae013,mhae014,mhae015,mhae016,mhae017,mhae018, 
          mhae022,mhae019,mhae023,mhae024,mhae025,mhae026,mhae027,mhae028,mhae029,mhae030,mhae031,mhae032, 
          mhae033,mhae034,mhae035,mhae036,mhae037,mhae038,mhae039,mhaeownid,mhaeowndp,mhaecrtid,mhaecrtdp, 
          mhaecrtdt,mhaemodid,mhaemoddt
           FROM s_detail1[1].mhaestus,s_detail1[1].mhae001,s_detail1[1].mhael023,s_detail1[1].mhael024, 
               s_detail1[1].mhae002,s_detail1[1].mhae003,s_detail1[1].mhae006,s_detail1[1].mhae004,s_detail1[1].mhae005, 
               s_detail1[1].mhae007,s_detail1[1].mhae008,s_detail1[1].mhae009,s_detail1[1].mhae010,s_detail1[1].mhae011, 
               s_detail1[1].mhae012,s_detail1[1].mhae013,s_detail1[1].mhae014,s_detail1[1].mhae015,s_detail1[1].mhae016, 
               s_detail1[1].mhae017,s_detail1[1].mhae018,s_detail1[1].mhae022,s_detail1[1].mhae019,s_detail1[1].mhae023, 
               s_detail1[1].mhae024,s_detail1[1].mhae025,s_detail1[1].mhae026,s_detail1[1].mhae027,s_detail1[1].mhae028, 
               s_detail1[1].mhae029,s_detail1[1].mhae030,s_detail1[1].mhae031,s_detail1[1].mhae032,s_detail1[1].mhae033, 
               s_detail1[1].mhae034,s_detail1[1].mhae035,s_detail1[1].mhae036,s_detail1[1].mhae037,s_detail1[1].mhae038, 
               s_detail1[1].mhae039,s_detail2[1].mhaeownid,s_detail2[1].mhaeowndp,s_detail2[1].mhaecrtid, 
               s_detail2[1].mhaecrtdp,s_detail2[1].mhaecrtdt,s_detail2[1].mhaemodid,s_detail2[1].mhaemoddt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mhaecrtdt>>----
         AFTER FIELD mhaecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mhaemoddt>>----
         AFTER FIELD mhaemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mhaecnfdt>>----
         
         #----<<mhaepstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaestus
            #add-point:BEFORE FIELD mhaestus name="construct.b.page1.mhaestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaestus
            
            #add-point:AFTER FIELD mhaestus name="construct.a.page1.mhaestus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhaestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaestus
            #add-point:ON ACTION controlp INFIELD mhaestus name="construct.c.page1.mhaestus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae001
            #add-point:BEFORE FIELD mhae001 name="construct.b.page1.mhae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae001
            
            #add-point:AFTER FIELD mhae001 name="construct.a.page1.mhae001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae001
            #add-point:ON ACTION controlp INFIELD mhae001 name="construct.c.page1.mhae001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae001  #顯示到畫面上
            NEXT FIELD mhae001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhael023
            #add-point:BEFORE FIELD mhael023 name="construct.b.page1.mhael023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhael023
            
            #add-point:AFTER FIELD mhael023 name="construct.a.page1.mhael023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhael023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhael023
            #add-point:ON ACTION controlp INFIELD mhael023 name="construct.c.page1.mhael023"
             INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stfa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae023  #顯示到畫面上
            NEXT FIELD mhae023  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhael024
            #add-point:BEFORE FIELD mhael024 name="construct.b.page1.mhael024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhael024
            
            #add-point:AFTER FIELD mhael024 name="construct.a.page1.mhael024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhael024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhael024
            #add-point:ON ACTION controlp INFIELD mhael024 name="construct.c.page1.mhael024"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhae002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae002
            #add-point:ON ACTION controlp INFIELD mhae002 name="construct.c.page1.mhae002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2126'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae002  #顯示到畫面上
            NEXT FIELD mhae002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae002
            #add-point:BEFORE FIELD mhae002 name="construct.b.page1.mhae002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae002
            
            #add-point:AFTER FIELD mhae002 name="construct.a.page1.mhae002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae003
            #add-point:BEFORE FIELD mhae003 name="construct.b.page1.mhae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae003
            
            #add-point:AFTER FIELD mhae003 name="construct.a.page1.mhae003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae003
            #add-point:ON ACTION controlp INFIELD mhae003 name="construct.c.page1.mhae003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhae006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae006
            #add-point:ON ACTION controlp INFIELD mhae006 name="construct.c.page1.mhae006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae006  #顯示到畫面上
            NEXT FIELD mhae006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae006
            #add-point:BEFORE FIELD mhae006 name="construct.b.page1.mhae006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae006
            
            #add-point:AFTER FIELD mhae006 name="construct.a.page1.mhae006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae004
            #add-point:ON ACTION controlp INFIELD mhae004 name="construct.c.page1.mhae004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae004  #顯示到畫面上
            NEXT FIELD mhae004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae004
            #add-point:BEFORE FIELD mhae004 name="construct.b.page1.mhae004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae004
            
            #add-point:AFTER FIELD mhae004 name="construct.a.page1.mhae004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae005
            #add-point:BEFORE FIELD mhae005 name="construct.b.page1.mhae005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae005
            
            #add-point:AFTER FIELD mhae005 name="construct.a.page1.mhae005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae005
            #add-point:ON ACTION controlp INFIELD mhae005 name="construct.c.page1.mhae005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhae007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae007
            #add-point:ON ACTION controlp INFIELD mhae007 name="construct.c.page1.mhae007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_oodb002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae007  #顯示到畫面上
            NEXT FIELD mhae007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae007
            #add-point:BEFORE FIELD mhae007 name="construct.b.page1.mhae007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae007
            
            #add-point:AFTER FIELD mhae007 name="construct.a.page1.mhae007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae008
            #add-point:ON ACTION controlp INFIELD mhae008 name="construct.c.page1.mhae008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_oodb002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae008  #顯示到畫面上
            NEXT FIELD mhae008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae008
            #add-point:BEFORE FIELD mhae008 name="construct.b.page1.mhae008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae008
            
            #add-point:AFTER FIELD mhae008 name="construct.a.page1.mhae008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae009
            #add-point:ON ACTION controlp INFIELD mhae009 name="construct.c.page1.mhae009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae009  #顯示到畫面上
            NEXT FIELD mhae009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae009
            #add-point:BEFORE FIELD mhae009 name="construct.b.page1.mhae009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae009
            
            #add-point:AFTER FIELD mhae009 name="construct.a.page1.mhae009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae010
            #add-point:ON ACTION controlp INFIELD mhae010 name="construct.c.page1.mhae010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae010  #顯示到畫面上
            NEXT FIELD mhae010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae010
            #add-point:BEFORE FIELD mhae010 name="construct.b.page1.mhae010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae010
            
            #add-point:AFTER FIELD mhae010 name="construct.a.page1.mhae010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae011
            #add-point:BEFORE FIELD mhae011 name="construct.b.page1.mhae011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae011
            
            #add-point:AFTER FIELD mhae011 name="construct.a.page1.mhae011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae011
            #add-point:ON ACTION controlp INFIELD mhae011 name="construct.c.page1.mhae011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "  rtax005 > 0 " 
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae011  #顯示到畫面上
            NEXT FIELD mhae011
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae012
            #add-point:BEFORE FIELD mhae012 name="construct.b.page1.mhae012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae012
            
            #add-point:AFTER FIELD mhae012 name="construct.a.page1.mhae012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae012
            #add-point:ON ACTION controlp INFIELD mhae012 name="construct.c.page1.mhae012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax005 > 0 " 
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae012  #顯示到畫面上
            NEXT FIELD mhae012
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae013
            #add-point:BEFORE FIELD mhae013 name="construct.b.page1.mhae013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae013
            
            #add-point:AFTER FIELD mhae013 name="construct.a.page1.mhae013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae013
            #add-point:ON ACTION controlp INFIELD mhae013 name="construct.c.page1.mhae013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhae014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae014
            #add-point:ON ACTION controlp INFIELD mhae014 name="construct.c.page1.mhae014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2127'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae014  #顯示到畫面上
            NEXT FIELD mhae014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae014
            #add-point:BEFORE FIELD mhae014 name="construct.b.page1.mhae014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae014
            
            #add-point:AFTER FIELD mhae014 name="construct.a.page1.mhae014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae015
            #add-point:BEFORE FIELD mhae015 name="construct.b.page1.mhae015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae015
            
            #add-point:AFTER FIELD mhae015 name="construct.a.page1.mhae015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae015
            #add-point:ON ACTION controlp INFIELD mhae015 name="construct.c.page1.mhae015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae016
            #add-point:BEFORE FIELD mhae016 name="construct.b.page1.mhae016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae016
            
            #add-point:AFTER FIELD mhae016 name="construct.a.page1.mhae016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae016
            #add-point:ON ACTION controlp INFIELD mhae016 name="construct.c.page1.mhae016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae017
            #add-point:BEFORE FIELD mhae017 name="construct.b.page1.mhae017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae017
            
            #add-point:AFTER FIELD mhae017 name="construct.a.page1.mhae017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae017
            #add-point:ON ACTION controlp INFIELD mhae017 name="construct.c.page1.mhae017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhae018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae018
            #add-point:ON ACTION controlp INFIELD mhae018 name="construct.c.page1.mhae018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae018  #顯示到畫面上
            NEXT FIELD mhae018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae018
            #add-point:BEFORE FIELD mhae018 name="construct.b.page1.mhae018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae018
            
            #add-point:AFTER FIELD mhae018 name="construct.a.page1.mhae018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae022
            #add-point:BEFORE FIELD mhae022 name="construct.b.page1.mhae022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae022
            
            #add-point:AFTER FIELD mhae022 name="construct.a.page1.mhae022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae022
            #add-point:ON ACTION controlp INFIELD mhae022 name="construct.c.page1.mhae022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae019
            #add-point:BEFORE FIELD mhae019 name="construct.b.page1.mhae019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae019
            
            #add-point:AFTER FIELD mhae019 name="construct.a.page1.mhae019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae019
            #add-point:ON ACTION controlp INFIELD mhae019 name="construct.c.page1.mhae019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae023
            #add-point:BEFORE FIELD mhae023 name="construct.b.page1.mhae023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae023
            
            #add-point:AFTER FIELD mhae023 name="construct.a.page1.mhae023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae023
            #add-point:ON ACTION controlp INFIELD mhae023 name="construct.c.page1.mhae023"
            #add by dengdd 151214(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stfa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae023  #顯示到畫面上
            NEXT FIELD mhae023  #返回原欄位
            #add by dengdd 151214(E)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae024
            #add-point:BEFORE FIELD mhae024 name="construct.b.page1.mhae024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae024
            
            #add-point:AFTER FIELD mhae024 name="construct.a.page1.mhae024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae024
            #add-point:ON ACTION controlp INFIELD mhae024 name="construct.c.page1.mhae024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae025
            #add-point:BEFORE FIELD mhae025 name="construct.b.page1.mhae025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae025
            
            #add-point:AFTER FIELD mhae025 name="construct.a.page1.mhae025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae025
            #add-point:ON ACTION controlp INFIELD mhae025 name="construct.c.page1.mhae025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae026
            #add-point:BEFORE FIELD mhae026 name="construct.b.page1.mhae026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae026
            
            #add-point:AFTER FIELD mhae026 name="construct.a.page1.mhae026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae026
            #add-point:ON ACTION controlp INFIELD mhae026 name="construct.c.page1.mhae026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae027
            #add-point:BEFORE FIELD mhae027 name="construct.b.page1.mhae027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae027
            
            #add-point:AFTER FIELD mhae027 name="construct.a.page1.mhae027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae027
            #add-point:ON ACTION controlp INFIELD mhae027 name="construct.c.page1.mhae027"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae027  #顯示到畫面上
            NEXT FIELD mhae027 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae028
            #add-point:BEFORE FIELD mhae028 name="construct.b.page1.mhae028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae028
            
            #add-point:AFTER FIELD mhae028 name="construct.a.page1.mhae028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae028
            #add-point:ON ACTION controlp INFIELD mhae028 name="construct.c.page1.mhae028"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae028  #顯示到畫面上
            NEXT FIELD mhae028 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae029
            #add-point:BEFORE FIELD mhae029 name="construct.b.page1.mhae029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae029
            
            #add-point:AFTER FIELD mhae029 name="construct.a.page1.mhae029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae029
            #add-point:ON ACTION controlp INFIELD mhae029 name="construct.c.page1.mhae029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae030
            #add-point:BEFORE FIELD mhae030 name="construct.b.page1.mhae030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae030
            
            #add-point:AFTER FIELD mhae030 name="construct.a.page1.mhae030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae030
            #add-point:ON ACTION controlp INFIELD mhae030 name="construct.c.page1.mhae030"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae030  #顯示到畫面上
            NEXT FIELD mhae030 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae031
            #add-point:BEFORE FIELD mhae031 name="construct.b.page1.mhae031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae031
            
            #add-point:AFTER FIELD mhae031 name="construct.a.page1.mhae031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae031
            #add-point:ON ACTION controlp INFIELD mhae031 name="construct.c.page1.mhae031"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooib002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae031  #顯示到畫面上
            NEXT FIELD mhae031 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae032
            #add-point:BEFORE FIELD mhae032 name="construct.b.page1.mhae032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae032
            
            #add-point:AFTER FIELD mhae032 name="construct.a.page1.mhae032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae032
            #add-point:ON ACTION controlp INFIELD mhae032 name="construct.c.page1.mhae032"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae032  #顯示到畫面上
            NEXT FIELD mhae032 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae033
            #add-point:BEFORE FIELD mhae033 name="construct.b.page1.mhae033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae033
            
            #add-point:AFTER FIELD mhae033 name="construct.a.page1.mhae033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae033
            #add-point:ON ACTION controlp INFIELD mhae033 name="construct.c.page1.mhae033"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2060"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae033  #顯示到畫面上
            NEXT FIELD mhae033 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae034
            #add-point:BEFORE FIELD mhae034 name="construct.b.page1.mhae034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae034
            
            #add-point:AFTER FIELD mhae034 name="construct.a.page1.mhae034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae034
            #add-point:ON ACTION controlp INFIELD mhae034 name="construct.c.page1.mhae034"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161006-00008#7 Add By Ken 161019(S)
            IF s_aooi500_setpoint(g_prog,'mhae034') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhae034',g_site,'c')
               CALL q_ooef001_24()                   
            ELSE
               CALL q_ooef001_23() 
            END IF
            #161006-00008#7 Add By Ken 161019(E)            
            #CALL q_ooef001_23()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae034  #顯示到畫面上
            NEXT FIELD mhae034 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae035
            #add-point:BEFORE FIELD mhae035 name="construct.b.page1.mhae035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae035
            
            #add-point:AFTER FIELD mhae035 name="construct.a.page1.mhae035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae035
            #add-point:ON ACTION controlp INFIELD mhae035 name="construct.c.page1.mhae035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae036
            #add-point:BEFORE FIELD mhae036 name="construct.b.page1.mhae036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae036
            
            #add-point:AFTER FIELD mhae036 name="construct.a.page1.mhae036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae036
            #add-point:ON ACTION controlp INFIELD mhae036 name="construct.c.page1.mhae036"
            #開窗c段
            #----str---add by dengdd 150921----------------------
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae036  #顯示到畫面上
            NEXT FIELD mhae036                    #返回原欄位
            #----end---add by dengdd 150921----------------------
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae037
            #add-point:BEFORE FIELD mhae037 name="construct.b.page1.mhae037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae037
            
            #add-point:AFTER FIELD mhae037 name="construct.a.page1.mhae037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae037
            #add-point:ON ACTION controlp INFIELD mhae037 name="construct.c.page1.mhae037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae038
            #add-point:BEFORE FIELD mhae038 name="construct.b.page1.mhae038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae038
            
            #add-point:AFTER FIELD mhae038 name="construct.a.page1.mhae038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae038
            #add-point:ON ACTION controlp INFIELD mhae038 name="construct.c.page1.mhae038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae039
            #add-point:BEFORE FIELD mhae039 name="construct.b.page1.mhae039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae039
            
            #add-point:AFTER FIELD mhae039 name="construct.a.page1.mhae039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhae039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae039
            #add-point:ON ACTION controlp INFIELD mhae039 name="construct.c.page1.mhae039"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mhaeownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaeownid
            #add-point:ON ACTION controlp INFIELD mhaeownid name="construct.c.page2.mhaeownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhaeownid  #顯示到畫面上
            NEXT FIELD mhaeownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaeownid
            #add-point:BEFORE FIELD mhaeownid name="construct.b.page2.mhaeownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaeownid
            
            #add-point:AFTER FIELD mhaeownid name="construct.a.page2.mhaeownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mhaeowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaeowndp
            #add-point:ON ACTION controlp INFIELD mhaeowndp name="construct.c.page2.mhaeowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhaeowndp  #顯示到畫面上
            NEXT FIELD mhaeowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaeowndp
            #add-point:BEFORE FIELD mhaeowndp name="construct.b.page2.mhaeowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaeowndp
            
            #add-point:AFTER FIELD mhaeowndp name="construct.a.page2.mhaeowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mhaecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaecrtid
            #add-point:ON ACTION controlp INFIELD mhaecrtid name="construct.c.page2.mhaecrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhaecrtid  #顯示到畫面上
            NEXT FIELD mhaecrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaecrtid
            #add-point:BEFORE FIELD mhaecrtid name="construct.b.page2.mhaecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaecrtid
            
            #add-point:AFTER FIELD mhaecrtid name="construct.a.page2.mhaecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mhaecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaecrtdp
            #add-point:ON ACTION controlp INFIELD mhaecrtdp name="construct.c.page2.mhaecrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhaecrtdp  #顯示到畫面上
            NEXT FIELD mhaecrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaecrtdp
            #add-point:BEFORE FIELD mhaecrtdp name="construct.b.page2.mhaecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaecrtdp
            
            #add-point:AFTER FIELD mhaecrtdp name="construct.a.page2.mhaecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaecrtdt
            #add-point:BEFORE FIELD mhaecrtdt name="construct.b.page2.mhaecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mhaemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaemodid
            #add-point:ON ACTION controlp INFIELD mhaemodid name="construct.c.page2.mhaemodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhaemodid  #顯示到畫面上
            NEXT FIELD mhaemodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaemodid
            #add-point:BEFORE FIELD mhaemodid name="construct.b.page2.mhaemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaemodid
            
            #add-point:AFTER FIELD mhaemodid name="construct.a.page2.mhaemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaemoddt
            #add-point:BEFORE FIELD mhaemoddt name="construct.b.page2.mhaemoddt"
            
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
 
{<section id="amhi300.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION amhi300_filter()
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
      CONSTRUCT g_wc_filter ON mhaesite,mhae020,mhae021
                          FROM s_browse[1].b_mhaesite,s_browse[1].b_mhae020,s_browse[1].b_mhae021
 
         BEFORE CONSTRUCT
               DISPLAY amhi300_filter_parser('mhaesite') TO s_browse[1].b_mhaesite
            DISPLAY amhi300_filter_parser('mhae020') TO s_browse[1].b_mhae020
            DISPLAY amhi300_filter_parser('mhae021') TO s_browse[1].b_mhae021
      
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
 
      CALL amhi300_filter_show('mhaesite')
   CALL amhi300_filter_show('mhae020')
   CALL amhi300_filter_show('mhae021')
 
END FUNCTION
 
{</section>}
 
{<section id="amhi300.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION amhi300_filter_parser(ps_field)
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
 
{<section id="amhi300.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION amhi300_filter_show(ps_field)
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
   LET ls_condition = amhi300_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="amhi300.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION amhi300_query()
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
   CALL g_mhae_d.clear()
   CALL g_mhae2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL amhi300_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL amhi300_browser_fill(g_wc)
      CALL amhi300_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL amhi300_browser_fill("F")
   
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
      CALL amhi300_fetch("F") 
   END IF
   
   CALL amhi300_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="amhi300.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION amhi300_fetch(p_flag)
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
   
   LET g_mhae_m.mhaesite = g_browser[g_current_idx].b_mhaesite
   LET g_mhae_m.mhae020 = g_browser[g_current_idx].b_mhae020
   LET g_mhae_m.mhae021 = g_browser[g_current_idx].b_mhae021
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE amhi300_master_referesh USING g_mhae_m.mhaesite,g_mhae_m.mhae020,g_mhae_m.mhae021 INTO g_mhae_m.mhaesite, 
       g_mhae_m.mhae020,g_mhae_m.mhae021,g_mhae_m.mhaesite_desc,g_mhae_m.mhae020_desc,g_mhae_m.mhae021_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "mhae_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_mhae_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_mhae_m_mask_o.* =  g_mhae_m.*
   CALL amhi300_mhae_t_mask()
   LET g_mhae_m_mask_n.* =  g_mhae_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL amhi300_set_act_visible()
   CALL amhi300_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_mhae_m_t.* = g_mhae_m.*
   LET g_mhae_m_o.* = g_mhae_m.*
   
   #重新顯示   
   CALL amhi300_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="amhi300.insert" >}
#+ 資料新增
PRIVATE FUNCTION amhi300_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert      LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_mhae_d.clear()
   CALL g_mhae2_d.clear()
 
 
   INITIALIZE g_mhae_m.* TO NULL             #DEFAULT 設定
   LET g_mhaesite_t = NULL
   LET g_mhae020_t = NULL
   LET g_mhae021_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      CALL s_aooi500_default(g_prog,'mhaesite',g_mhae_m.mhaesite) RETURNING l_insert,g_mhae_m.mhaesite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_site_flag = FALSE
      CALL amhi300_mhaesite_ref()
      #end add-point 
 
      CALL amhi300_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_mhae_m.* TO NULL
         INITIALIZE g_mhae_d TO NULL
         INITIALIZE g_mhae2_d TO NULL
 
         CALL amhi300_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_mhae_m.* = g_mhae_m_t.*
         CALL amhi300_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_mhae_d.clear()
      #CALL g_mhae2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL amhi300_set_act_visible()
   CALL amhi300_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_mhaesite_t = g_mhae_m.mhaesite
   LET g_mhae020_t = g_mhae_m.mhae020
   LET g_mhae021_t = g_mhae_m.mhae021
 
   
   #組合新增資料的條件
   LET g_add_browse = " mhaeent = " ||g_enterprise|| " AND",
                      " mhaesite = '", g_mhae_m.mhaesite, "' "
                      ," AND mhae020 = '", g_mhae_m.mhae020, "' "
                      ," AND mhae021 = '", g_mhae_m.mhae021, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amhi300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL amhi300_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE amhi300_master_referesh USING g_mhae_m.mhaesite,g_mhae_m.mhae020,g_mhae_m.mhae021 INTO g_mhae_m.mhaesite, 
       g_mhae_m.mhae020,g_mhae_m.mhae021,g_mhae_m.mhaesite_desc,g_mhae_m.mhae020_desc,g_mhae_m.mhae021_desc 
 
   
   #遮罩相關處理
   LET g_mhae_m_mask_o.* =  g_mhae_m.*
   CALL amhi300_mhae_t_mask()
   LET g_mhae_m_mask_n.* =  g_mhae_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mhae_m.mhaesite,g_mhae_m.mhaesite_desc,g_mhae_m.mhae020,g_mhae_m.mhae020_desc,g_mhae_m.mhae021, 
       g_mhae_m.mhae021_desc
   
   #功能已完成,通報訊息中心
   CALL amhi300_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="amhi300.modify" >}
#+ 資料修改
PRIVATE FUNCTION amhi300_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_mhae_m.mhaesite IS NULL
   OR g_mhae_m.mhae020 IS NULL
   OR g_mhae_m.mhae021 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_mhaesite_t = g_mhae_m.mhaesite
   LET g_mhae020_t = g_mhae_m.mhae020
   LET g_mhae021_t = g_mhae_m.mhae021
 
   CALL s_transaction_begin()
   
   OPEN amhi300_cl USING g_enterprise,g_mhae_m.mhaesite,g_mhae_m.mhae020,g_mhae_m.mhae021
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amhi300_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE amhi300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amhi300_master_referesh USING g_mhae_m.mhaesite,g_mhae_m.mhae020,g_mhae_m.mhae021 INTO g_mhae_m.mhaesite, 
       g_mhae_m.mhae020,g_mhae_m.mhae021,g_mhae_m.mhaesite_desc,g_mhae_m.mhae020_desc,g_mhae_m.mhae021_desc 
 
   
   #遮罩相關處理
   LET g_mhae_m_mask_o.* =  g_mhae_m.*
   CALL amhi300_mhae_t_mask()
   LET g_mhae_m_mask_n.* =  g_mhae_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL amhi300_show()
   WHILE TRUE
      LET g_mhaesite_t = g_mhae_m.mhaesite
      LET g_mhae020_t = g_mhae_m.mhae020
      LET g_mhae021_t = g_mhae_m.mhae021
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL amhi300_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_mhae_m.* = g_mhae_m_t.*
         CALL amhi300_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_mhae_m.mhaesite != g_mhaesite_t 
      OR g_mhae_m.mhae020 != g_mhae020_t 
      OR g_mhae_m.mhae021 != g_mhae021_t 
 
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
   CALL amhi300_set_act_visible()
   CALL amhi300_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mhaeent = " ||g_enterprise|| " AND",
                      " mhaesite = '", g_mhae_m.mhaesite, "' "
                      ," AND mhae020 = '", g_mhae_m.mhae020, "' "
                      ," AND mhae021 = '", g_mhae_m.mhae021, "' "
 
   #填到對應位置
   CALL amhi300_browser_fill("")
 
   CALL amhi300_idx_chk()
 
   CLOSE amhi300_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amhi300_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="amhi300.input" >}
#+ 資料輸入
PRIVATE FUNCTION amhi300_input(p_cmd)
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
   DEFINE l_mhae002          LIKE type_t.num20   
   DEFINE l_ooef019          LIKE ooef_t.ooef019
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_errno            LIKE type_t.chr10
   DEFINE mhae020_old        LIKE mhae_t.mhae020
   DEFINE  l_sys2             LIKE type_t.num5         #add by dengdd 150921   
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
   DISPLAY BY NAME g_mhae_m.mhaesite,g_mhae_m.mhaesite_desc,g_mhae_m.mhae020,g_mhae_m.mhae020_desc,g_mhae_m.mhae021, 
       g_mhae_m.mhae021_desc
   
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
   LET g_forupd_sql = "SELECT mhaestus,mhae001,mhae002,mhae003,mhae006,mhae004,mhae005,mhae007,mhae008, 
       mhae009,mhae010,mhae011,mhae012,mhae013,mhae014,mhae015,mhae016,mhae017,mhae018,mhae022,mhae019, 
       mhae023,mhae024,mhae025,mhae026,mhae027,mhae028,mhae029,mhae030,mhae031,mhae032,mhae033,mhae034, 
       mhae035,mhae036,mhae037,mhae038,mhae039,mhae001,mhaeownid,mhaeowndp,mhaecrtid,mhaecrtdp,mhaecrtdt, 
       mhaemodid,mhaemoddt FROM mhae_t WHERE mhaeent=? AND mhaesite=? AND mhae020=? AND mhae021=? AND  
       mhae001=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amhi300_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL amhi300_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL amhi300_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_mhae_m.mhaesite,g_mhae_m.mhae020,g_mhae_m.mhae021
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="amhi300.input.head" >}
   
      #單頭段
      INPUT BY NAME g_mhae_m.mhaesite,g_mhae_m.mhae020,g_mhae_m.mhae021 
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
         AFTER FIELD mhaesite
            
            #add-point:AFTER FIELD mhaesite name="input.a.mhaesite"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_mhae_m.mhaesite) THEN 
               
               CALL s_aooi500_chk(g_prog,'mhaesite',g_mhae_m.mhaesite,g_mhae_m.mhaesite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_mhae_m.mhaesite
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_mhae_m.mhaesite = g_mhae_m_t.mhaesite
                  CALL s_desc_get_department_desc(g_mhae_m.mhaesite) RETURNING g_mhae_m.mhaesite_desc
                  DISPLAY BY NAME g_mhae_m.mhaesite,g_mhae_m.mhaesite_desc
                  NEXT FIELD CURRENT
               END IF

               LET g_site_flag = TRUE
               CALL amhi300_set_entry(p_cmd)
               CALL amhi300_set_no_entry(p_cmd)
            END IF
            CALL amhi300_mhaesite_ref()
            IF NOT cl_null(g_mhae_m.mhaesite) AND NOT cl_null(g_mhae_m.mhae020)  AND NOT cl_null(g_mhae_m.mhae021) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mhae_m.mhaesite != g_mhaesite_t OR g_mhae_m.mhae020 != g_mhae020_t OR g_mhae_m.mhae021 != g_mhae021_t)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhae_t WHERE "||"mhaeent = '" ||g_enterprise|| "' AND "||"mhaesite = '"||g_mhae_m.mhaesite ||"' AND "||"mhae020 = '"||g_mhae_m.mhae020 ||"'AND "||"mhae021 = '"||g_mhae_m.mhae021 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaesite
            #add-point:BEFORE FIELD mhaesite name="input.b.mhaesite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhaesite
            #add-point:ON CHANGE mhaesite name="input.g.mhaesite"
            LET  g_mhae_m.mhae020 =''
            LET  g_mhae_m.mhae021 =''
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae020
            
            #add-point:AFTER FIELD mhae020 name="input.a.mhae020"
            IF NOT cl_null(g_mhae_m.mhae020) THEN
               #應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhae_m.mhae020
               LET g_chkparam.arg2 = g_mhae_m.mhaesite
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mhaa001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               LET mhae020_old = g_mhae_m.mhae020
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((g_mhae_m.mhae020 != mhae020_old ) OR (g_mhae_m.mhae020 != g_mhae_m_t.mhae020 ))) THEN 
                  IF NOT cl_null(g_mhae_m.mhae021) THEN 
                     LET l_cnt = 0 
                     SELECT COUNT(*) INTO l_cnt
                       FROM mhab_t 
                      WHERE mhabent = g_enterprise
                        AND mhab001 = g_mhae_m.mhae020
                        AND mhab002 = g_mhae_m.mhae021   
                        
                      IF l_cnt = 0 THEN 
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "" 
                         LET g_errparam.code   = "amh-00005"
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         LET  g_mhae_m.mhae021 =''
                         NEXT FIELD CURRENT
                      END IF                      
                  END IF 
               END IF
            
            

            END IF 
            CALL amhi300_mhae020_ref()
            IF NOT cl_null(g_mhae_m.mhaesite) AND NOT cl_null(g_mhae_m.mhae020)  AND NOT cl_null(g_mhae_m.mhae021) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mhae_m.mhaesite != g_mhaesite_t OR g_mhae_m.mhae020 != g_mhae020_t OR g_mhae_m.mhae021 != g_mhae021_t)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhae_t WHERE "||"mhaeent = '" ||g_enterprise|| "' AND "||"mhaesite = '"||g_mhae_m.mhaesite ||"' AND "||"mhae020 = '"||g_mhae_m.mhae020 ||"'AND "||"mhae021 = '"||g_mhae_m.mhae021 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae020
            #add-point:BEFORE FIELD mhae020 name="input.b.mhae020"
#            IF cl_null(g_mhae_m.mhaesite) THEN 
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "" 
#               LET g_errparam.code   = "amh-00027" 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               NEXT FIELD mhaesite
#            END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae020
            #add-point:ON CHANGE mhae020 name="input.g.mhae020"
            LET  g_mhae_m.mhae021 =''
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae021
            
            #add-point:AFTER FIELD mhae021 name="input.a.mhae021"
            IF NOT cl_null(g_mhae_m.mhae021) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mhae_m.mhaesite != g_mhaesite_t OR g_mhae_m.mhae020 != g_mhae020_t OR g_mhae_m.mhae021 != g_mhae021_t)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhae_t WHERE "||"mhaeent = '" ||g_enterprise|| "' AND "||"mhaesite = '"||g_mhae_m.mhaesite ||"' AND "||"mhae020 = '"||g_mhae_m.mhae020 ||"'AND "||"mhae021 = '"||g_mhae_m.mhae021 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
               #應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhae_m.mhae021
               LET g_chkparam.arg2 = g_mhae_m.mhae020
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mhab002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL amhi300_mhae021_ref()
            IF NOT cl_null(g_mhae_m.mhaesite) AND NOT cl_null(g_mhae_m.mhae020)  AND NOT cl_null(g_mhae_m.mhae021) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mhae_m.mhaesite != g_mhaesite_t OR g_mhae_m.mhae020 != g_mhae020_t OR g_mhae_m.mhae021 != g_mhae021_t)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhae_t WHERE "||"mhaeent = '" ||g_enterprise|| "' AND "||"mhaesite = '"||g_mhae_m.mhaesite ||"' AND "||"mhae020 = '"||g_mhae_m.mhae020 ||"'AND "||"mhae021 = '"||g_mhae_m.mhae021 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae021
            #add-point:BEFORE FIELD mhae021 name="input.b.mhae021"
#            IF cl_null(g_mhae_m.mhaesite) THEN 
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "" 
#               LET g_errparam.code   = "amh-00027" 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               NEXT FIELD mhaesite
#            END IF
#            IF cl_null(g_mhae_m.mhae020) THEN 
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "" 
#               LET g_errparam.code   = "amh-00028" 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               NEXT FIELD mhae020
#            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae021
            #add-point:ON CHANGE mhae021 name="input.g.mhae021"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mhaesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaesite
            #add-point:ON ACTION controlp INFIELD mhaesite name="input.c.mhaesite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_m.mhaesite             #給予default值

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhaesite',g_mhae_m.mhaesite,'i')

            CALL q_ooef001_24()                                #呼叫開窗

            LET g_mhae_m.mhaesite = g_qryparam.return1              

            DISPLAY g_mhae_m.mhaesite TO mhaesite              #
            CALL amhi300_mhaesite_ref()
            NEXT FIELD mhaesite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mhae020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae020
            #add-point:ON ACTION controlp INFIELD mhae020 name="input.c.mhae020"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_m.mhae020             #給予default值

            LET g_qryparam.where = "mhaasite ='",g_mhae_m.mhaesite,"' "


            CALL q_mhaa001()                                #呼叫開窗

            LET g_mhae_m.mhae020 = g_qryparam.return1              

            DISPLAY g_mhae_m.mhae020 TO mhae020              #
            CALL amhi300_mhae020_ref()
            NEXT FIELD mhae020                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mhae021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae021
            #add-point:ON ACTION controlp INFIELD mhae021 name="input.c.mhae021"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_m.mhae021             #給予default值

            LET g_qryparam.where = "mhabsite ='",g_mhae_m.mhaesite,"' AND  ","mhab001 ='",g_mhae_m.mhae020,"' "


            CALL q_mhab002()                                #呼叫開窗

            LET g_mhae_m.mhae021 = g_qryparam.return1              

            DISPLAY g_mhae_m.mhae021 TO mhae021              #
            CALL amhi300_mhae021_ref()
            NEXT FIELD mhae021                          #返回原欄位


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
            DISPLAY BY NAME g_mhae_m.mhaesite             
                            ,g_mhae_m.mhae020   
                            ,g_mhae_m.mhae021   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL amhi300_mhae_t_mask_restore('restore_mask_o')
            
               UPDATE mhae_t SET (mhaesite,mhae020,mhae021) = (g_mhae_m.mhaesite,g_mhae_m.mhae020,g_mhae_m.mhae021) 
 
                WHERE mhaeent = g_enterprise AND mhaesite = g_mhaesite_t
                  AND mhae020 = g_mhae020_t
                  AND mhae021 = g_mhae021_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhae_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhae_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhae_m.mhaesite
               LET gs_keys_bak[1] = g_mhaesite_t
               LET gs_keys[2] = g_mhae_m.mhae020
               LET gs_keys_bak[2] = g_mhae020_t
               LET gs_keys[3] = g_mhae_m.mhae021
               LET gs_keys_bak[3] = g_mhae021_t
               LET gs_keys[4] = g_mhae_d[g_detail_idx].mhae001
               LET gs_keys_bak[4] = g_mhae_d_t.mhae001
               CALL amhi300_update_b('mhae_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_mhae_m_t)
                     #LET g_log2 = util.JSON.stringify(g_mhae_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL amhi300_mhae_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL amhi300_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_mhaesite_t = g_mhae_m.mhaesite
           LET g_mhae020_t = g_mhae_m.mhae020
           LET g_mhae021_t = g_mhae_m.mhae021
 
           
           IF g_mhae_d.getLength() = 0 THEN
              NEXT FIELD mhae001
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="amhi300.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_mhae_d FROM s_detail1.*
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
               IF NOT cl_null(g_mhae_d[l_ac].mhae001) THEN
                  CALL n_mhael(g_mhae_m.mhaesite,g_mhae_d[l_ac].mhae001,g_mhae_m.mhae020,g_mhae_m.mhae021)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mhae_m.mhaesite
                  LET g_ref_fields[2] = g_mhae_d[l_ac].mhae001
                  LET g_ref_fields[3] = g_mhae_m.mhae020
                  LET g_ref_fields[4] = g_mhae_m.mhae021
                  CALL ap_ref_array2(g_ref_fields," SELECT mhael023,mhael024 FROM mhael_t WHERE mhaelent = '"||g_enterprise||"' AND mhaelsite = ? AND mhael001 = ? AND mhael020 = ? AND mhael021 = ? AND mhael022 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_mhae_d[l_ac].mhael023 = g_rtn_fields[1]
                  LET g_mhae_d[l_ac].mhael024 = g_rtn_fields[2]
                  DISPLAY BY NAME g_mhae_d[l_ac].mhael023,g_mhae_d[l_ac].mhael024
               END IF
               #END add-point
            END IF
 
 
 
 
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mhae_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amhi300_b_fill(g_wc2) #test 
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
            CALL amhi300_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN amhi300_cl USING g_enterprise,g_mhae_m.mhaesite,g_mhae_m.mhae020,g_mhae_m.mhae021                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE amhi300_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN amhi300_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_mhae_d[l_ac].mhae001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mhae_d_t.* = g_mhae_d[l_ac].*  #BACKUP
               LET g_mhae_d_o.* = g_mhae_d[l_ac].*  #BACKUP
               CALL amhi300_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL amhi300_set_no_entry_b(l_cmd)
               OPEN amhi300_bcl USING g_enterprise,g_mhae_m.mhaesite,
                                                g_mhae_m.mhae020,
                                                g_mhae_m.mhae021,
 
                                                g_mhae_d_t.mhae001
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN amhi300_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amhi300_bcl INTO g_mhae_d[l_ac].mhaestus,g_mhae_d[l_ac].mhae001,g_mhae_d[l_ac].mhae002, 
                      g_mhae_d[l_ac].mhae003,g_mhae_d[l_ac].mhae006,g_mhae_d[l_ac].mhae004,g_mhae_d[l_ac].mhae005, 
                      g_mhae_d[l_ac].mhae007,g_mhae_d[l_ac].mhae008,g_mhae_d[l_ac].mhae009,g_mhae_d[l_ac].mhae010, 
                      g_mhae_d[l_ac].mhae011,g_mhae_d[l_ac].mhae012,g_mhae_d[l_ac].mhae013,g_mhae_d[l_ac].mhae014, 
                      g_mhae_d[l_ac].mhae015,g_mhae_d[l_ac].mhae016,g_mhae_d[l_ac].mhae017,g_mhae_d[l_ac].mhae018, 
                      g_mhae_d[l_ac].mhae022,g_mhae_d[l_ac].mhae019,g_mhae_d[l_ac].mhae023,g_mhae_d[l_ac].mhae024, 
                      g_mhae_d[l_ac].mhae025,g_mhae_d[l_ac].mhae026,g_mhae_d[l_ac].mhae027,g_mhae_d[l_ac].mhae028, 
                      g_mhae_d[l_ac].mhae029,g_mhae_d[l_ac].mhae030,g_mhae_d[l_ac].mhae031,g_mhae_d[l_ac].mhae032, 
                      g_mhae_d[l_ac].mhae033,g_mhae_d[l_ac].mhae034,g_mhae_d[l_ac].mhae035,g_mhae_d[l_ac].mhae036, 
                      g_mhae_d[l_ac].mhae037,g_mhae_d[l_ac].mhae038,g_mhae_d[l_ac].mhae039,g_mhae2_d[l_ac].mhae001, 
                      g_mhae2_d[l_ac].mhaeownid,g_mhae2_d[l_ac].mhaeowndp,g_mhae2_d[l_ac].mhaecrtid, 
                      g_mhae2_d[l_ac].mhaecrtdp,g_mhae2_d[l_ac].mhaecrtdt,g_mhae2_d[l_ac].mhaemodid, 
                      g_mhae2_d[l_ac].mhaemoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_mhae_d_t.mhae001,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mhae_d_mask_o[l_ac].* =  g_mhae_d[l_ac].*
                  CALL amhi300_mhae_t_mask()
                  LET g_mhae_d_mask_n[l_ac].* =  g_mhae_d[l_ac].*
                  
                  CALL amhi300_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            
LET g_detail_multi_table_t.mhael001 = g_mhae_d[l_ac].mhae001
LET g_detail_multi_table_t.mhael020 = g_mhae_m.mhae020
LET g_detail_multi_table_t.mhael021 = g_mhae_m.mhae021
LET g_detail_multi_table_t.mhael022 = g_dlang
LET g_detail_multi_table_t.mhael023 = g_mhae_d[l_ac].mhael023
LET g_detail_multi_table_t.mhael024 = g_mhae_d[l_ac].mhael024
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_mhae_d_t.* TO NULL
            INITIALIZE g_mhae_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mhae_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mhae2_d[l_ac].mhaeownid = g_user
      LET g_mhae2_d[l_ac].mhaeowndp = g_dept
      LET g_mhae2_d[l_ac].mhaecrtid = g_user
      LET g_mhae2_d[l_ac].mhaecrtdp = g_dept 
      LET g_mhae2_d[l_ac].mhaecrtdt = cl_get_current()
      LET g_mhae2_d[l_ac].mhaemodid = g_user
      LET g_mhae2_d[l_ac].mhaemoddt = cl_get_current()
      LET g_mhae_d[l_ac].mhaestus = ''
 
 
  
            #一般欄位預設值
                  LET g_mhae_d[l_ac].mhaestus = "Y"
      LET g_mhae_d[l_ac].mhae015 = "2"
      LET g_mhae_d[l_ac].mhae016 = "Y"
      LET g_mhae_d[l_ac].mhae024 = "0"
      LET g_mhae_d[l_ac].mhae025 = "0"
      LET g_mhae_d[l_ac].mhae039 = "N"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            LET g_mhae_d[l_ac].mhae035='Y'           #add by dengdd 150921
            LET g_mhae_d[l_ac].mhae037='Y'           #add by dengdd 150921
            #end add-point
            LET g_mhae_d_t.* = g_mhae_d[l_ac].*     #新輸入資料
            LET g_mhae_d_o.* = g_mhae_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amhi300_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL amhi300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mhae_d[li_reproduce_target].* = g_mhae_d[li_reproduce].*
               LET g_mhae2_d[li_reproduce_target].* = g_mhae2_d[li_reproduce].*
 
               LET g_mhae_d[g_mhae_d.getLength()].mhae001 = NULL
 
            END IF
            
LET g_detail_multi_table_t.mhael001 = g_mhae_d[l_ac].mhae001
LET g_detail_multi_table_t.mhael020 = g_mhae_m.mhae020
LET g_detail_multi_table_t.mhael021 = g_mhae_m.mhae021
LET g_detail_multi_table_t.mhael022 = g_dlang
LET g_detail_multi_table_t.mhael023 = g_mhae_d[l_ac].mhael023
LET g_detail_multi_table_t.mhael024 = g_mhae_d[l_ac].mhael024
 
 
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
            SELECT COUNT(1) INTO l_count FROM mhae_t 
             WHERE mhaeent = g_enterprise AND mhaesite = g_mhae_m.mhaesite
               AND mhae020 = g_mhae_m.mhae020
               AND mhae021 = g_mhae_m.mhae021
 
               AND mhae001 = g_mhae_d[l_ac].mhae001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO mhae_t
                           (mhaeent,
                            mhaesite,mhae020,mhae021,
                            mhae001
                            ,mhaestus,mhae002,mhae003,mhae006,mhae004,mhae005,mhae007,mhae008,mhae009,mhae010,mhae011,mhae012,mhae013,mhae014,mhae015,mhae016,mhae017,mhae018,mhae022,mhae019,mhae023,mhae024,mhae025,mhae026,mhae027,mhae028,mhae029,mhae030,mhae031,mhae032,mhae033,mhae034,mhae035,mhae036,mhae037,mhae038,mhae039,mhaeownid,mhaeowndp,mhaecrtid,mhaecrtdp,mhaecrtdt,mhaemodid,mhaemoddt) 
                     VALUES(g_enterprise,
                            g_mhae_m.mhaesite,g_mhae_m.mhae020,g_mhae_m.mhae021,
                            g_mhae_d[l_ac].mhae001
                            ,g_mhae_d[l_ac].mhaestus,g_mhae_d[l_ac].mhae002,g_mhae_d[l_ac].mhae003,g_mhae_d[l_ac].mhae006, 
                                g_mhae_d[l_ac].mhae004,g_mhae_d[l_ac].mhae005,g_mhae_d[l_ac].mhae007, 
                                g_mhae_d[l_ac].mhae008,g_mhae_d[l_ac].mhae009,g_mhae_d[l_ac].mhae010, 
                                g_mhae_d[l_ac].mhae011,g_mhae_d[l_ac].mhae012,g_mhae_d[l_ac].mhae013, 
                                g_mhae_d[l_ac].mhae014,g_mhae_d[l_ac].mhae015,g_mhae_d[l_ac].mhae016, 
                                g_mhae_d[l_ac].mhae017,g_mhae_d[l_ac].mhae018,g_mhae_d[l_ac].mhae022, 
                                g_mhae_d[l_ac].mhae019,g_mhae_d[l_ac].mhae023,g_mhae_d[l_ac].mhae024, 
                                g_mhae_d[l_ac].mhae025,g_mhae_d[l_ac].mhae026,g_mhae_d[l_ac].mhae027, 
                                g_mhae_d[l_ac].mhae028,g_mhae_d[l_ac].mhae029,g_mhae_d[l_ac].mhae030, 
                                g_mhae_d[l_ac].mhae031,g_mhae_d[l_ac].mhae032,g_mhae_d[l_ac].mhae033, 
                                g_mhae_d[l_ac].mhae034,g_mhae_d[l_ac].mhae035,g_mhae_d[l_ac].mhae036, 
                                g_mhae_d[l_ac].mhae037,g_mhae_d[l_ac].mhae038,g_mhae_d[l_ac].mhae039, 
                                g_mhae2_d[l_ac].mhaeownid,g_mhae2_d[l_ac].mhaeowndp,g_mhae2_d[l_ac].mhaecrtid, 
                                g_mhae2_d[l_ac].mhaecrtdp,g_mhae2_d[l_ac].mhaecrtdt,g_mhae2_d[l_ac].mhaemodid, 
                                g_mhae2_d[l_ac].mhaemoddt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_mhae_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mhae_t:",SQLERRMESSAGE 
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
         IF g_mhae_d[l_ac].mhae001 = g_detail_multi_table_t.mhael001 AND
         g_mhae_m.mhae020 = g_detail_multi_table_t.mhael020 AND
         g_mhae_m.mhae021 = g_detail_multi_table_t.mhael021 AND
         g_mhae_d[l_ac].mhael023 = g_detail_multi_table_t.mhael023 AND
         g_mhae_d[l_ac].mhael024 = g_detail_multi_table_t.mhael024 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhaelent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_site
            LET l_field_keys[02] = 'mhaelsite'
            LET l_var_keys_bak[02] = g_site
            LET l_var_keys[03] = g_mhae_d[l_ac].mhae001
            LET l_field_keys[03] = 'mhael001'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhael001
            LET l_var_keys[04] = g_mhae_m.mhae020
            LET l_field_keys[04] = 'mhael020'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhael020
            LET l_var_keys[05] = g_mhae_m.mhae021
            LET l_field_keys[05] = 'mhael021'
            LET l_var_keys_bak[05] = g_detail_multi_table_t.mhael021
            LET l_var_keys[06] = g_dlang
            LET l_field_keys[06] = 'mhael022'
            LET l_var_keys_bak[06] = g_detail_multi_table_t.mhael022
            LET l_vars[01] = g_mhae_d[l_ac].mhael023
            LET l_fields[01] = 'mhael023'
            LET l_vars[02] = g_mhae_d[l_ac].mhael024
            LET l_fields[02] = 'mhael024'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhael_t')
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
               IF amhi300_before_delete() THEN 
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'mhaelent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'mhaelsite'
                  LET l_var_keys_bak[02] = g_site
                  LET l_field_keys[03] = 'mhael001'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.mhael001
                  LET l_field_keys[04] = 'mhael020'
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.mhael020
                  LET l_field_keys[05] = 'mhael021'
                  LET l_var_keys_bak[05] = g_detail_multi_table_t.mhael021
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mhael_t')
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_mhae_m.mhaesite
                  LET gs_keys[gs_keys.getLength()+1] = g_mhae_m.mhae020
                  LET gs_keys[gs_keys.getLength()+1] = g_mhae_m.mhae021
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mhae_d_t.mhae001
 
 
                  #刪除下層單身
                  IF NOT amhi300_key_delete_b(gs_keys,'mhae_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE amhi300_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE amhi300_bcl
               LET l_count = g_mhae_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_mhae_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaestus
            #add-point:BEFORE FIELD mhaestus name="input.b.page1.mhaestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaestus
            
            #add-point:AFTER FIELD mhaestus name="input.a.page1.mhaestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhaestus
            #add-point:ON CHANGE mhaestus name="input.g.page1.mhaestus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae001
            #add-point:BEFORE FIELD mhae001 name="input.b.page1.mhae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae001
            
            #add-point:AFTER FIELD mhae001 name="input.a.page1.mhae001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_mhae_m.mhaesite IS NOT NULL AND g_mhae_d[g_detail_idx].mhae001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhae_d[g_detail_idx].mhae001 != g_mhae_d_t.mhae001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhae_t WHERE "||"mhaeent = '" ||g_enterprise|| "' AND "||"  "|| "mhae001 = '"||g_mhae_d[g_detail_idx].mhae001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  #add by yangxf ---start---
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM stea_t 
                   WHERE steaent = g_enterprise 
                     AND stea005 = g_mhae_d[l_ac].mhae001 
                  IF l_n > 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00252'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF 
                  #add by yangxf ----end----
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae001
            #add-point:ON CHANGE mhae001 name="input.g.page1.mhae001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhael023
            #add-point:BEFORE FIELD mhael023 name="input.b.page1.mhael023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhael023
            
            #add-point:AFTER FIELD mhael023 name="input.a.page1.mhael023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhael023
            #add-point:ON CHANGE mhael023 name="input.g.page1.mhael023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhael024
            #add-point:BEFORE FIELD mhael024 name="input.b.page1.mhael024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhael024
            
            #add-point:AFTER FIELD mhael024 name="input.a.page1.mhael024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhael024
            #add-point:ON CHANGE mhael024 name="input.g.page1.mhael024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae002
            
            #add-point:AFTER FIELD mhae002 name="input.a.page1.mhae002"
            #检查装柜类型有效性
            IF NOT cl_null(g_mhae_d[l_ac].mhae002) THEN 
               LET l_cnt = 0
               SELECT COUNT(*) 
                 INTO l_cnt  
                 FROM oocq_t 
                WHERE oocqent = g_enterprise 
                  AND oocq001 = '2126' 
                  AND oocq002 = g_mhae_d[l_ac].mhae002               
               IF l_cnt = 0 THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "amh-00025" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               ELSE 
                  LET l_cnt = 0
                  SELECT COUNT(*) 
                    INTO l_cnt  
                    FROM oocq_t 
                   WHERE oocqent = g_enterprise 
                     AND oocq001 = '2126' 
                     AND oocq002 = g_mhae_d[l_ac].mhae002  
                     AND oocqstus = 'Y' 
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "amh-00026" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF                    
               END IF
            END IF              
#            LET l_mhae002 = g_mhae_d[l_ac].mhae002           
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = l_mhae002
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2126' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mhae_d[l_ac].mhae002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mhae_d[l_ac].mhae002_desc
            CALL amhi300_mhae002_ref()
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae002
            #add-point:BEFORE FIELD mhae002 name="input.b.page1.mhae002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae002
            #add-point:ON CHANGE mhae002 name="input.g.page1.mhae002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae003
            #add-point:BEFORE FIELD mhae003 name="input.b.page1.mhae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae003
            
            #add-point:AFTER FIELD mhae003 name="input.a.page1.mhae003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae003
            #add-point:ON CHANGE mhae003 name="input.g.page1.mhae003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae006
            
            #add-point:AFTER FIELD mhae006 name="input.a.page1.mhae006"
            IF NOT cl_null(g_mhae_d[l_ac].mhae006) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhae_d[l_ac].mhae006

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_12") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae006
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mhae_d[l_ac].mhae006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mhae_d[l_ac].mhae006_desc
            CALL amhi300_mhae006_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae006
            #add-point:BEFORE FIELD mhae006 name="input.b.page1.mhae006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae006
            #add-point:ON CHANGE mhae006 name="input.g.page1.mhae006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae004
            
            #add-point:AFTER FIELD mhae004 name="input.a.page1.mhae004"
            IF NOT cl_null(g_mhae_d[l_ac].mhae004) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhae_d[l_ac].mhae004

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae004
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mhae_d[l_ac].mhae004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mhae_d[l_ac].mhae004_desc
            CALL amhi300_mhae004_ref()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae004
            #add-point:BEFORE FIELD mhae004 name="input.b.page1.mhae004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae004
            #add-point:ON CHANGE mhae004 name="input.g.page1.mhae004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae005
            #add-point:BEFORE FIELD mhae005 name="input.b.page1.mhae005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae005
            
            #add-point:AFTER FIELD mhae005 name="input.a.page1.mhae005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae005
            #add-point:ON CHANGE mhae005 name="input.g.page1.mhae005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae007
            
            #add-point:AFTER FIELD mhae007 name="input.a.page1.mhae007"
            IF NOT cl_null(g_mhae_d[l_ac].mhae007) THEN 
               #應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhae_m.mhaesite
               LET g_chkparam.arg2 = g_mhae_d[l_ac].mhae007
               LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"#要執行的建議程式待補 #160318-00025#30  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            
#            SELECT ooef019 INTO l_ooef019
#              FROM ooef_t
#             WHERE ooef001 = g_mhae_m.mhaesite
#               AND ooefent = g_enterprise
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae007
#            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"' AND oodbl001='"||l_ooef019||"'","") RETURNING g_rtn_fields
#            LET g_mhae_d[l_ac].mhae007_desc = '', g_rtn_fields[1] , ''
#            DISPLAY  BY NAME g_mhae_d[l_ac].mhae007_desc
#               
#            SELECT oodb006 INTO g_mhae_d[l_ac].mhae007_desc_1 FROM oodb_t
#             WHERE oodbent = g_enterprise AND oodb002 = g_mhae_d[l_ac].mhae007 AND oodb004='1'
#            DISPLAY  BY NAME g_mhae_d[l_ac].mhae007_desc_1
            CALL amhi300_mhae007_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae007
            #add-point:BEFORE FIELD mhae007 name="input.b.page1.mhae007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae007
            #add-point:ON CHANGE mhae007 name="input.g.page1.mhae007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae007_desc
            #add-point:BEFORE FIELD mhae007_desc name="input.b.page1.mhae007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae007_desc
            
            #add-point:AFTER FIELD mhae007_desc name="input.a.page1.mhae007_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae007_desc
            #add-point:ON CHANGE mhae007_desc name="input.g.page1.mhae007_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae007_desc_1
            #add-point:BEFORE FIELD mhae007_desc_1 name="input.b.page1.mhae007_desc_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae007_desc_1
            
            #add-point:AFTER FIELD mhae007_desc_1 name="input.a.page1.mhae007_desc_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae007_desc_1
            #add-point:ON CHANGE mhae007_desc_1 name="input.g.page1.mhae007_desc_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae008
            
            #add-point:AFTER FIELD mhae008 name="input.a.page1.mhae008"
            IF NOT cl_null(g_mhae_d[l_ac].mhae008) THEN 
               #應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhae_m.mhaesite
               LET g_chkparam.arg2 = g_mhae_d[l_ac].mhae008
               LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"#要執行的建議程式待補 #160318-00025#30  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF             
#            SELECT ooef019 INTO l_ooef019
#              FROM ooef_t
#             WHERE ooef001 = g_mhae_m.mhaesite
#               AND ooefent = g_enterprise
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae008
#            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"' AND oodbl001='"||l_ooef019||"'","") RETURNING g_rtn_fields
#            LET g_mhae_d[l_ac].mhae008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY  BY NAME g_mhae_d[l_ac].mhae008_desc
#               
#            SELECT oodb006 INTO g_mhae_d[l_ac].mhae008_desc_1 FROM oodb_t
#             WHERE oodbent = g_enterprise AND oodb002 = g_mhae_d[l_ac].mhae008 AND oodb004='1'
#            DISPLAY  BY NAME g_mhae_d[l_ac].mhae008_desc_1
            CALL amhi300_mhae008_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae008
            #add-point:BEFORE FIELD mhae008 name="input.b.page1.mhae008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae008
            #add-point:ON CHANGE mhae008 name="input.g.page1.mhae008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae008_desc
            #add-point:BEFORE FIELD mhae008_desc name="input.b.page1.mhae008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae008_desc
            
            #add-point:AFTER FIELD mhae008_desc name="input.a.page1.mhae008_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae008_desc
            #add-point:ON CHANGE mhae008_desc name="input.g.page1.mhae008_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae008_desc_1
            #add-point:BEFORE FIELD mhae008_desc_1 name="input.b.page1.mhae008_desc_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae008_desc_1
            
            #add-point:AFTER FIELD mhae008_desc_1 name="input.a.page1.mhae008_desc_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae008_desc_1
            #add-point:ON CHANGE mhae008_desc_1 name="input.g.page1.mhae008_desc_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae009
            
            #add-point:AFTER FIELD mhae009 name="input.a.page1.mhae009"
            IF NOT cl_null(g_mhae_d[l_ac].mhae009) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhae_d[l_ac].mhae009

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_2002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae009
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mhae_d[l_ac].mhae009_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mhae_d[l_ac].mhae009_desc
            CALL amhi300_mhae009_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae009
            #add-point:BEFORE FIELD mhae009 name="input.b.page1.mhae009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae009
            #add-point:ON CHANGE mhae009 name="input.g.page1.mhae009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae010
            
            #add-point:AFTER FIELD mhae010 name="input.a.page1.mhae010"
             IF NOT cl_null(g_mhae_d[l_ac].mhae010) THEN 
               #應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhae_d[l_ac].mhae010

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtax001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae010
#            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mhae_d[l_ac].mhae010_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mhae_d[l_ac].mhae010_desc
#
#            #带出经营种类
#            SELECT rtax003 INTO  g_mhae_d[l_ac].mhae011  FROM rtax_t 
#            WHERE rtaxent = g_enterprise AND rtax001 = g_mhae_d[l_ac].mhae010
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae011
#            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mhae_d[l_ac].mhae011_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mhae_d[l_ac].mhae011_desc
#            
#            #带出经营大类
#            SELECT rtax003 INTO  g_mhae_d[l_ac].mhae012  FROM rtax_t 
#            WHERE rtaxent = g_enterprise AND rtax001 = g_mhae_d[l_ac].mhae011
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae012
#            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mhae_d[l_ac].mhae012_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mhae_d[l_ac].mhae012_desc
            CALL amhi300_mhae010_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae010
            #add-point:BEFORE FIELD mhae010 name="input.b.page1.mhae010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae010
            #add-point:ON CHANGE mhae010 name="input.g.page1.mhae010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae011
            
            #add-point:AFTER FIELD mhae011 name="input.a.page1.mhae011"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae011
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhae_d[l_ac].mhae011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhae_d[l_ac].mhae011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae011
            #add-point:BEFORE FIELD mhae011 name="input.b.page1.mhae011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae011
            #add-point:ON CHANGE mhae011 name="input.g.page1.mhae011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae012
            
            #add-point:AFTER FIELD mhae012 name="input.a.page1.mhae012"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae012
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhae_d[l_ac].mhae012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhae_d[l_ac].mhae012_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae012
            #add-point:BEFORE FIELD mhae012 name="input.b.page1.mhae012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae012
            #add-point:ON CHANGE mhae012 name="input.g.page1.mhae012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae013
            #add-point:BEFORE FIELD mhae013 name="input.b.page1.mhae013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae013
            
            #add-point:AFTER FIELD mhae013 name="input.a.page1.mhae013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae013
            #add-point:ON CHANGE mhae013 name="input.g.page1.mhae013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae014
            
            #add-point:AFTER FIELD mhae014 name="input.a.page1.mhae014"
            IF NOT cl_null(g_mhae_d[l_ac].mhae014) THEN 
               LET l_cnt = 0
               SELECT COUNT(*) 
                 INTO l_cnt  
                 FROM oocq_t 
                WHERE oocqent = g_enterprise 
                  AND oocq001 = '2127' 
                  AND oocq002 = g_mhae_d[l_ac].mhae014               
               IF l_cnt = 0 THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "amh-00047" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               ELSE 
                  LET l_cnt = 0
                  SELECT COUNT(*) 
                    INTO l_cnt  
                    FROM oocq_t 
                   WHERE oocqent = g_enterprise 
                     AND oocq001 = '2127' 
                     AND oocq002 = g_mhae_d[l_ac].mhae014  
                     AND oocqstus = 'Y' 
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "amh-00048" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF                    
               END IF
            END IF  
            CALL amhi300_mhae014_ref()            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae014
            #add-point:BEFORE FIELD mhae014 name="input.b.page1.mhae014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae014
            #add-point:ON CHANGE mhae014 name="input.g.page1.mhae014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae015
            #add-point:BEFORE FIELD mhae015 name="input.b.page1.mhae015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae015
            
            #add-point:AFTER FIELD mhae015 name="input.a.page1.mhae015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae015
            #add-point:ON CHANGE mhae015 name="input.g.page1.mhae015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae016
            #add-point:BEFORE FIELD mhae016 name="input.b.page1.mhae016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae016
            
            #add-point:AFTER FIELD mhae016 name="input.a.page1.mhae016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae016
            #add-point:ON CHANGE mhae016 name="input.g.page1.mhae016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae017
            #add-point:BEFORE FIELD mhae017 name="input.b.page1.mhae017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae017
            
            #add-point:AFTER FIELD mhae017 name="input.a.page1.mhae017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae017
            #add-point:ON CHANGE mhae017 name="input.g.page1.mhae017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae018
            
            #add-point:AFTER FIELD mhae018 name="input.a.page1.mhae018"
            IF NOT cl_null(g_mhae_d[l_ac].mhae018) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhae_d[l_ac].mhae018

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL amhi300_mhae018_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae018
            #add-point:BEFORE FIELD mhae018 name="input.b.page1.mhae018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae018
            #add-point:ON CHANGE mhae018 name="input.g.page1.mhae018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhae_d[l_ac].mhae022,"0.00","1","100.00","1","azz-00087",1) THEN 
 
               NEXT FIELD mhae022
            END IF 
 
 
 
            #add-point:AFTER FIELD mhae022 name="input.a.page1.mhae022"
            IF NOT cl_null(g_mhae_d[l_ac].mhae022) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae022
            #add-point:BEFORE FIELD mhae022 name="input.b.page1.mhae022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae022
            #add-point:ON CHANGE mhae022 name="input.g.page1.mhae022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae019
            #add-point:BEFORE FIELD mhae019 name="input.b.page1.mhae019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae019
            
            #add-point:AFTER FIELD mhae019 name="input.a.page1.mhae019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae019
            #add-point:ON CHANGE mhae019 name="input.g.page1.mhae019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae023
            #add-point:BEFORE FIELD mhae023 name="input.b.page1.mhae023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae023
            
            #add-point:AFTER FIELD mhae023 name="input.a.page1.mhae023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae023
            #add-point:ON CHANGE mhae023 name="input.g.page1.mhae023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae024
            #add-point:BEFORE FIELD mhae024 name="input.b.page1.mhae024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae024
            
            #add-point:AFTER FIELD mhae024 name="input.a.page1.mhae024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae024
            #add-point:ON CHANGE mhae024 name="input.g.page1.mhae024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae025
            #add-point:BEFORE FIELD mhae025 name="input.b.page1.mhae025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae025
            
            #add-point:AFTER FIELD mhae025 name="input.a.page1.mhae025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae025
            #add-point:ON CHANGE mhae025 name="input.g.page1.mhae025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae026
            #add-point:BEFORE FIELD mhae026 name="input.b.page1.mhae026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae026
            
            #add-point:AFTER FIELD mhae026 name="input.a.page1.mhae026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae026
            #add-point:ON CHANGE mhae026 name="input.g.page1.mhae026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae027
            
            #add-point:AFTER FIELD mhae027 name="input.a.page1.mhae027"
           IF s_aooi500_setpoint(g_prog,'mhae027') THEN
               CALL s_aooi500_chk(g_prog,'mhae027',g_mhae_d[l_ac].mhae027,g_mhae_m.mhaesite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_mhae_d[l_ac].mhae027
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  
                  LET g_mhae_d[l_ac].mhae027 = g_mhae_d_t.mhae027  
                  CALL amhi300_mhae027_ref()
                  NEXT FIELD CURRENT
               END IF
            
            ELSE
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_chkparam.arg1 = g_mhae_d[l_ac].mhae027
               IF NOT cl_chk_exist("v_ooef001_1") THEN
                  LET g_mhae_d[l_ac].mhae028 =g_mhae_d_t.mhae028
                  CALL amhi300_mhae027_ref()
                  NEXT FIELD mhae027
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae027
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhae_d[l_ac].mhae027_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhae_d[l_ac].mhae027_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae027
            #add-point:BEFORE FIELD mhae027 name="input.b.page1.mhae027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae027
            #add-point:ON CHANGE mhae027 name="input.g.page1.mhae027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae028
            
            #add-point:AFTER FIELD mhae028 name="input.a.page1.mhae028"
            IF NOT cl_null(g_mhae_d[l_ac].mhae028) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_chkparam.arg1 = g_mhae_d[l_ac].mhae028
               IF NOT cl_chk_exist("v_ooag001") THEN
                  LET g_mhae_d[l_ac].mhae028 =g_mhae_d_t.mhae028
                  CALL amhi300_mhae028_ref()
                  NEXT FIELD mhae028
               END IF             
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae028
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mhae_d[l_ac].mhae028_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhae_d[l_ac].mhae028_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae028
            #add-point:BEFORE FIELD mhae028 name="input.b.page1.mhae028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae028
            #add-point:ON CHANGE mhae028 name="input.g.page1.mhae028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae029
            #add-point:BEFORE FIELD mhae029 name="input.b.page1.mhae029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae029
            
            #add-point:AFTER FIELD mhae029 name="input.a.page1.mhae029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae029
            #add-point:ON CHANGE mhae029 name="input.g.page1.mhae029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae030
            
            #add-point:AFTER FIELD mhae030 name="input.a.page1.mhae030"
            IF NOT cl_null(g_mhae_d[l_ac].mhae030) THEN
                LET g_errshow = '1'
                INITIALIZE g_chkparam.* TO NULL
                LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
                LET g_chkparam.arg1 = g_mhae_m.mhaesite
                LET g_chkparam.arg2 = g_mhae_d[l_ac].mhae030
                LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"#要執行的建議程式待補 #160318-00025#30  add
                IF NOT cl_chk_exist("v_ooaj002") THEN
                   LET g_mhae_d[l_ac].mhae030 = g_mhae_d_t.mhae030
                   CALL amhi300_mhae030_ref()
                   NEXT FIELD mhae030
                END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae030
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhae_d[l_ac].mhae030_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhae_d[l_ac].mhae030_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae030
            #add-point:BEFORE FIELD mhae030 name="input.b.page1.mhae030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae030
            #add-point:ON CHANGE mhae030 name="input.g.page1.mhae030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae031
            
            #add-point:AFTER FIELD mhae031 name="input.a.page1.mhae031"
            IF NOT cl_null(g_mhae_d[l_ac].mhae031) THEN
                INITIALIZE g_chkparam.* TO NULL
                LET g_errshow = '1'
                LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
                LET g_chkparam.arg1 = g_mhae_d[l_ac].mhae031            
                LET g_chkparam.err_str[1] = "apm-00186:sub-01302|aooi716|",cl_get_progname("aooi716",g_lang,"2"),"|:EXEPROGaooi716"#要執行的建議程式待補 #160318-00025#30  add
                IF NOT cl_chk_exist("v_ooib002") THEN
                      LET g_mhae_d[l_ac].mhae031 = g_mhae_d_t.mhae031
                      CALL amhi300_mhae031_ref()
                      NEXT FIELD mhae031
                END IF
                INITIALIZE g_ref_fields TO NULL
                LET g_ref_fields[1] = g_mhae_d[l_ac].mhae031
                CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
                LET g_mhae_d[l_ac].mhae031_desc = '', g_rtn_fields[1] , ''
                DISPLAY BY NAME g_mhae_d[l_ac].mhae031_desc
            END IF                
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae031
            #add-point:BEFORE FIELD mhae031 name="input.b.page1.mhae031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae031
            #add-point:ON CHANGE mhae031 name="input.g.page1.mhae031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae032
            
            #add-point:AFTER FIELD mhae032 name="input.a.page1.mhae032"
            IF NOT cl_null(g_mhae_d[l_ac].mhae032) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_chkparam.arg1 = g_mhae_d[l_ac].mhae032          
               IF NOT cl_chk_exist("v_staa001") THEN
                     LET g_mhae_d[l_ac].mhae032 = g_mhae_d_t.mhae032 
                     CALL amhi300_mhae032_ref()
                     NEXT FIELD mhae032
               END IF
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_mhae_d[l_ac].mhae032
               CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_mhae_d[l_ac].mhae032_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_mhae_d[l_ac].mhae032_desc
          END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae032
            #add-point:BEFORE FIELD mhae032 name="input.b.page1.mhae032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae032
            #add-point:ON CHANGE mhae032 name="input.g.page1.mhae032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae033
            
            #add-point:AFTER FIELD mhae033 name="input.a.page1.mhae033"
            
            IF NOT cl_null(g_mhae_d[l_ac].mhae033) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_chkparam.arg1 = g_mhae_d[l_ac].mhae033           
               IF NOT cl_chk_exist("v_oocq002_2060") THEN
                  LET g_mhae_d[l_ac].mhae033 = g_mhae_d_t.mhae033
                  CALL amhi300_mhae033_ref()
                  NEXT FIELD mhae033
               END IF            
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae033
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhae_d[l_ac].mhae033_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhae_d[l_ac].mhae033_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae033
            #add-point:BEFORE FIELD mhae033 name="input.b.page1.mhae033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae033
            #add-point:ON CHANGE mhae033 name="input.g.page1.mhae033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae034
            
            #add-point:AFTER FIELD mhae034 name="input.a.page1.mhae034"
            IF NOT cl_null(g_mhae_d[l_ac].mhae034) THEN

               IF s_aooi500_setpoint(g_prog,'mhae034') THEN
                  CALL s_aooi500_chk(g_prog,'mhae034',g_mhae_d[l_ac].mhae034,g_mhae_m.mhaesite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_mhae_d[l_ac].mhae034
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     
                     LET g_mhae_d[l_ac].mhae034= g_mhae_d_t.mhae034
                     CALL amhi300_mhae034_ref()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = '1'
                  LET g_chkparam.arg1 = g_mhae_d[l_ac].mhae034               
                  IF NOT cl_chk_exist("v_ooef001_31") THEN
                     LET g_mhae_d[l_ac].mhae034 = g_mhae_d_t.mhae034
                     CALL amhi300_mhae034_ref()
                     NEXT FIELD mhae034
                  END IF
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae034
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhae_d[l_ac].mhae034_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhae_d[l_ac].mhae034_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae034
            #add-point:BEFORE FIELD mhae034 name="input.b.page1.mhae034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae034
            #add-point:ON CHANGE mhae034 name="input.g.page1.mhae034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae035
            #add-point:BEFORE FIELD mhae035 name="input.b.page1.mhae035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae035
            
            #add-point:AFTER FIELD mhae035 name="input.a.page1.mhae035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae035
            #add-point:ON CHANGE mhae035 name="input.g.page1.mhae035"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae036
            
            #add-point:AFTER FIELD mhae036 name="input.a.page1.mhae036"
            IF NOT cl_null(g_mhae_d[l_ac].mhae036) THEN                            
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
               LET g_chkparam.arg1 = g_mhae_d[l_ac].mhae036
               CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys2
               LET g_chkparam.arg2 = l_sys2
               LET g_chkparam.err_str[1] = "ast-00215:sub-01302|arti202|",cl_get_progname("arti202",g_lang,"2"),"|:EXEPROGarti202"#要執行的建議程式待補 #160318-00025#30  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_rtax001_2") THEN
                  LET g_mhae_d[l_ac].mhae036 = g_mhae_d_t.mhae036
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mhae_d[l_ac].mhae036
                  CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_mhae_d[l_ac].mhae036_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_mhae_d[l_ac].mhae036_desc
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF         
           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhae_d[l_ac].mhae036
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhae_d[l_ac].mhae036_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhae_d[l_ac].mhae036_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae036
            #add-point:BEFORE FIELD mhae036 name="input.b.page1.mhae036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae036
            #add-point:ON CHANGE mhae036 name="input.g.page1.mhae036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae037
            #add-point:BEFORE FIELD mhae037 name="input.b.page1.mhae037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae037
            
            #add-point:AFTER FIELD mhae037 name="input.a.page1.mhae037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae037
            #add-point:ON CHANGE mhae037 name="input.g.page1.mhae037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae038
            #add-point:BEFORE FIELD mhae038 name="input.b.page1.mhae038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae038
            
            #add-point:AFTER FIELD mhae038 name="input.a.page1.mhae038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae038
            #add-point:ON CHANGE mhae038 name="input.g.page1.mhae038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae039
            #add-point:BEFORE FIELD mhae039 name="input.b.page1.mhae039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae039
            
            #add-point:AFTER FIELD mhae039 name="input.a.page1.mhae039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhae039
            #add-point:ON CHANGE mhae039 name="input.g.page1.mhae039"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mhaestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaestus
            #add-point:ON ACTION controlp INFIELD mhaestus name="input.c.page1.mhaestus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae001
            #add-point:ON ACTION controlp INFIELD mhae001 name="input.c.page1.mhae001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhael023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhael023
            #add-point:ON ACTION controlp INFIELD mhael023 name="input.c.page1.mhael023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhael024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhael024
            #add-point:ON ACTION controlp INFIELD mhael024 name="input.c.page1.mhael024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae002
            #add-point:ON ACTION controlp INFIELD mhae002 name="input.c.page1.mhae002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae002             #給予default值
            LET g_qryparam.default2 = "" #g_mhae_d[l_ac].oocql004 #說明
            #給予arg
             LET g_qryparam.arg1 = '2126'


            CALL q_oocq002()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae002 = g_qryparam.return1              
            #LET g_mhae_d[l_ac].oocql004 = g_qryparam.return2 
            DISPLAY g_mhae_d[l_ac].mhae002 TO mhae002              #
            CALL amhi300_mhae002_ref()
            #DISPLAY g_mhae_d[l_ac].oocql004 TO oocql004 #說明
            NEXT FIELD mhae002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae003
            #add-point:ON ACTION controlp INFIELD mhae003 name="input.c.page1.mhae003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae006
            #add-point:ON ACTION controlp INFIELD mhae006 name="input.c.page1.mhae006"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae006             #給予default值

            #給予arg
            LET g_qryparam.where = "pmaa002 = '1' AND pmaastus = 'Y'"


            CALL q_pmaa001_5()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae006 = g_qryparam.return1              

            DISPLAY g_mhae_d[l_ac].mhae006 TO mhae006              #
            CALL amhi300_mhae006_ref()
            NEXT FIELD mhae006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae004
            #add-point:ON ACTION controlp INFIELD mhae004 name="input.c.page1.mhae004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooeg001_9()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae004 = g_qryparam.return1              

            DISPLAY g_mhae_d[l_ac].mhae004 TO mhae004              #
            CALL amhi300_mhae004_ref()
            NEXT FIELD mhae004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae005
            #add-point:ON ACTION controlp INFIELD mhae005 name="input.c.page1.mhae005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae007
            #add-point:ON ACTION controlp INFIELD mhae007 name="input.c.page1.mhae007"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_mhae_m.mhaesite


            CALL q_oodb002_3()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae007 = g_qryparam.return1              

            DISPLAY g_mhae_d[l_ac].mhae007 TO mhae007              #
            CALL amhi300_mhae007_ref()
            NEXT FIELD mhae007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae007_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae007_desc
            #add-point:ON ACTION controlp INFIELD mhae007_desc name="input.c.page1.mhae007_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae007_desc_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae007_desc_1
            #add-point:ON ACTION controlp INFIELD mhae007_desc_1 name="input.c.page1.mhae007_desc_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae008
            #add-point:ON ACTION controlp INFIELD mhae008 name="input.c.page1.mhae008"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_mhae_m.mhaesite


            CALL q_oodb002_3()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae008 = g_qryparam.return1              

            DISPLAY g_mhae_d[l_ac].mhae008 TO mhae008              #
            CALL amhi300_mhae008_ref()
            NEXT FIELD mhae008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae008_desc
            #add-point:ON ACTION controlp INFIELD mhae008_desc name="input.c.page1.mhae008_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae008_desc_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae008_desc_1
            #add-point:ON ACTION controlp INFIELD mhae008_desc_1 name="input.c.page1.mhae008_desc_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae009
            #add-point:ON ACTION controlp INFIELD mhae009 name="input.c.page1.mhae009"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae009             #給予default值
            LET g_qryparam.default2 = "" #g_mhae_d[l_ac].oocql004 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_oocq002_2002()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae009 = g_qryparam.return1              
            #LET g_mhae_d[l_ac].oocql004 = g_qryparam.return2 
            DISPLAY g_mhae_d[l_ac].mhae009 TO mhae009              #
            #DISPLAY g_mhae_d[l_ac].oocql004 TO oocql004 #說明
            CALL amhi300_mhae009_ref()
            NEXT FIELD mhae009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae010
            #add-point:ON ACTION controlp INFIELD mhae010 name="input.c.page1.mhae010"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_rtax001()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae010 = g_qryparam.return1              

            DISPLAY g_mhae_d[l_ac].mhae010 TO mhae010              #

            NEXT FIELD mhae010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae011
            #add-point:ON ACTION controlp INFIELD mhae011 name="input.c.page1.mhae011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae012
            #add-point:ON ACTION controlp INFIELD mhae012 name="input.c.page1.mhae012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae013
            #add-point:ON ACTION controlp INFIELD mhae013 name="input.c.page1.mhae013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae014
            #add-point:ON ACTION controlp INFIELD mhae014 name="input.c.page1.mhae014"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae014             #給予default值
            LET g_qryparam.default2 = "" #g_mhae_d[l_ac].oocql004 #說明
            #給予arg
            LET g_qryparam.arg1 = '2127'


            CALL q_oocq002()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae014 = g_qryparam.return1              
            #LET g_mhae_d[l_ac].oocql004 = g_qryparam.return2 
            DISPLAY g_mhae_d[l_ac].mhae014 TO mhae014              #
            #DISPLAY g_mhae_d[l_ac].oocql004 TO oocql004 #說明
            CALL amhi300_mhae014_ref()
            NEXT FIELD mhae014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae015
            #add-point:ON ACTION controlp INFIELD mhae015 name="input.c.page1.mhae015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae016
            #add-point:ON ACTION controlp INFIELD mhae016 name="input.c.page1.mhae016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae017
            #add-point:ON ACTION controlp INFIELD mhae017 name="input.c.page1.mhae017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae018
            #add-point:ON ACTION controlp INFIELD mhae018 name="input.c.page1.mhae018"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooag001()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae018 = g_qryparam.return1              

            DISPLAY g_mhae_d[l_ac].mhae018 TO mhae018              #
            CALL amhi300_mhae018_ref()
            NEXT FIELD mhae018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae022
            #add-point:ON ACTION controlp INFIELD mhae022 name="input.c.page1.mhae022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae019
            #add-point:ON ACTION controlp INFIELD mhae019 name="input.c.page1.mhae019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae023
            #add-point:ON ACTION controlp INFIELD mhae023 name="input.c.page1.mhae023"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stfa001()             #呼叫開窗
            LET g_mhae_d[l_ac].mhae023 = g_qryparam.return1 
            DISPLAY g_mhae_d[l_ac].mhae018 TO mhae023  #顯示到畫面上
            NEXT FIELD mhae023  #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae024
            #add-point:ON ACTION controlp INFIELD mhae024 name="input.c.page1.mhae024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae025
            #add-point:ON ACTION controlp INFIELD mhae025 name="input.c.page1.mhae025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae026
            #add-point:ON ACTION controlp INFIELD mhae026 name="input.c.page1.mhae026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae027
            #add-point:ON ACTION controlp INFIELD mhae027 name="input.c.page1.mhae027"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae027             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooef001_2()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae027 = g_qryparam.return1              

            DISPLAY g_mhae_d[l_ac].mhae027 TO mhae027              #
            CALL amhi300_mhae027_ref()
            NEXT FIELD mhae027   
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae028
            #add-point:ON ACTION controlp INFIELD mhae028 name="input.c.page1.mhae028"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae028             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooag001()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae028 = g_qryparam.return1              

            DISPLAY g_mhae_d[l_ac].mhae028 TO mhae028              #
            CALL amhi300_mhae028_ref()
            NEXT FIELD mhae028 
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae029
            #add-point:ON ACTION controlp INFIELD mhae029 name="input.c.page1.mhae029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae030
            #add-point:ON ACTION controlp INFIELD mhae030 name="input.c.page1.mhae030"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae030             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site #s


            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae030 = g_qryparam.return1              

            DISPLAY g_mhae_d[l_ac].mhae030 TO mhae030              #
            CALL amhi300_mhae030_ref()
            NEXT FIELD mhae030 
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae031
            #add-point:ON ACTION controlp INFIELD mhae031 name="input.c.page1.mhae031"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooib002_1()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae031 = g_qryparam.return1              

            DISPLAY g_mhae_d[l_ac].mhae031 TO mhae031              #
            CALL amhi300_mhae031_ref()
            NEXT FIELD mhae031 
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae032
            #add-point:ON ACTION controlp INFIELD mhae032 name="input.c.page1.mhae032"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae032             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_staa001()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae032 = g_qryparam.return1              

            DISPLAY g_mhae_d[l_ac].mhae032 TO mhae032              #
            CALL amhi300_mhae032_ref()
            NEXT FIELD mhae032
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae033
            #add-point:ON ACTION controlp INFIELD mhae033 name="input.c.page1.mhae033"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae033             #給予default值
            LET g_qryparam.default2 = "" 
            #給予arg
            LET g_qryparam.arg1 = "2060" #s


            CALL q_oocq002()                                #呼叫開窗

            LET g_mhae_d[l_ac].mhae033 = g_qryparam.return1              

            DISPLAY g_mhae_d[l_ac].mhae033 TO mhae033              #
            CALL amhi300_mhae033_ref()
            NEXT FIELD mhae033
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae034
            #add-point:ON ACTION controlp INFIELD mhae034 name="input.c.page1.mhae034"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhae_d[l_ac].mhae034             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            #161006-00008#7 Add By Ken 161019(S)
            IF s_aooi500_setpoint(g_prog,'mhae034') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhae034',g_mhae_m.mhaesite,'i')
               CALL q_ooef001_24()                   
            ELSE
               CALL q_ooef001_23() 
            END IF
            #161006-00008#7 Add By Ken 161019(E)
            #CALL q_ooef001_23()                                #呼叫開窗  #161006-00008#7 Mark By Ken 161019(S)

            LET g_mhae_d[l_ac].mhae034 = g_qryparam.return1              

            DISPLAY g_mhae_d[l_ac].mhae034 TO mhae034              #
            CALL amhi300_mhae034_ref()
            NEXT FIELD mhae034
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae035
            #add-point:ON ACTION controlp INFIELD mhae035 name="input.c.page1.mhae035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae036
            #add-point:ON ACTION controlp INFIELD mhae036 name="input.c.page1.mhae036"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
	         CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys2 #取得品類層級
            LET g_qryparam.arg1 = l_sys2 #
            CALL q_rtax001_3()                  #呼叫開窗
            LET g_mhae_d[l_ac].mhae036 = g_qryparam.return1
            DISPLAY g_mhae_d[l_ac].mhae036 TO mhae036  #顯示到畫面上
            NEXT FIELD mhae036                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae037
            #add-point:ON ACTION controlp INFIELD mhae037 name="input.c.page1.mhae037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae038
            #add-point:ON ACTION controlp INFIELD mhae038 name="input.c.page1.mhae038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhae039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae039
            #add-point:ON ACTION controlp INFIELD mhae039 name="input.c.page1.mhae039"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mhae_d[l_ac].* = g_mhae_d_t.*
               CLOSE amhi300_bcl
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
               LET g_errparam.extend = g_mhae_d[l_ac].mhae001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_mhae_d[l_ac].* = g_mhae_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_mhae2_d[l_ac].mhaemodid = g_user 
LET g_mhae2_d[l_ac].mhaemoddt = cl_get_current()
LET g_mhae2_d[l_ac].mhaemodid_desc = cl_get_username(g_mhae2_d[l_ac].mhaemodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL amhi300_mhae_t_mask_restore('restore_mask_o')
         
               UPDATE mhae_t SET (mhaesite,mhae020,mhae021,mhaestus,mhae001,mhae002,mhae003,mhae006, 
                   mhae004,mhae005,mhae007,mhae008,mhae009,mhae010,mhae011,mhae012,mhae013,mhae014,mhae015, 
                   mhae016,mhae017,mhae018,mhae022,mhae019,mhae023,mhae024,mhae025,mhae026,mhae027,mhae028, 
                   mhae029,mhae030,mhae031,mhae032,mhae033,mhae034,mhae035,mhae036,mhae037,mhae038,mhae039, 
                   mhaeownid,mhaeowndp,mhaecrtid,mhaecrtdp,mhaecrtdt,mhaemodid,mhaemoddt) = (g_mhae_m.mhaesite, 
                   g_mhae_m.mhae020,g_mhae_m.mhae021,g_mhae_d[l_ac].mhaestus,g_mhae_d[l_ac].mhae001, 
                   g_mhae_d[l_ac].mhae002,g_mhae_d[l_ac].mhae003,g_mhae_d[l_ac].mhae006,g_mhae_d[l_ac].mhae004, 
                   g_mhae_d[l_ac].mhae005,g_mhae_d[l_ac].mhae007,g_mhae_d[l_ac].mhae008,g_mhae_d[l_ac].mhae009, 
                   g_mhae_d[l_ac].mhae010,g_mhae_d[l_ac].mhae011,g_mhae_d[l_ac].mhae012,g_mhae_d[l_ac].mhae013, 
                   g_mhae_d[l_ac].mhae014,g_mhae_d[l_ac].mhae015,g_mhae_d[l_ac].mhae016,g_mhae_d[l_ac].mhae017, 
                   g_mhae_d[l_ac].mhae018,g_mhae_d[l_ac].mhae022,g_mhae_d[l_ac].mhae019,g_mhae_d[l_ac].mhae023, 
                   g_mhae_d[l_ac].mhae024,g_mhae_d[l_ac].mhae025,g_mhae_d[l_ac].mhae026,g_mhae_d[l_ac].mhae027, 
                   g_mhae_d[l_ac].mhae028,g_mhae_d[l_ac].mhae029,g_mhae_d[l_ac].mhae030,g_mhae_d[l_ac].mhae031, 
                   g_mhae_d[l_ac].mhae032,g_mhae_d[l_ac].mhae033,g_mhae_d[l_ac].mhae034,g_mhae_d[l_ac].mhae035, 
                   g_mhae_d[l_ac].mhae036,g_mhae_d[l_ac].mhae037,g_mhae_d[l_ac].mhae038,g_mhae_d[l_ac].mhae039, 
                   g_mhae2_d[l_ac].mhaeownid,g_mhae2_d[l_ac].mhaeowndp,g_mhae2_d[l_ac].mhaecrtid,g_mhae2_d[l_ac].mhaecrtdp, 
                   g_mhae2_d[l_ac].mhaecrtdt,g_mhae2_d[l_ac].mhaemodid,g_mhae2_d[l_ac].mhaemoddt)
                WHERE mhaeent = g_enterprise AND mhaesite = g_mhae_m.mhaesite 
                 AND mhae020 = g_mhae_m.mhae020 
                 AND mhae021 = g_mhae_m.mhae021 
 
                 AND mhae001 = g_mhae_d_t.mhae001 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhae_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "mhae_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhae_m.mhaesite
               LET gs_keys_bak[1] = g_mhaesite_t
               LET gs_keys[2] = g_mhae_m.mhae020
               LET gs_keys_bak[2] = g_mhae020_t
               LET gs_keys[3] = g_mhae_m.mhae021
               LET gs_keys_bak[3] = g_mhae021_t
               LET gs_keys[4] = g_mhae_d[g_detail_idx].mhae001
               LET gs_keys_bak[4] = g_mhae_d_t.mhae001
               CALL amhi300_update_b('mhae_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhae_d[l_ac].mhae001 = g_detail_multi_table_t.mhael001 AND
         g_mhae_m.mhae020 = g_detail_multi_table_t.mhael020 AND
         g_mhae_m.mhae021 = g_detail_multi_table_t.mhael021 AND
         g_mhae_d[l_ac].mhael023 = g_detail_multi_table_t.mhael023 AND
         g_mhae_d[l_ac].mhael024 = g_detail_multi_table_t.mhael024 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhaelent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_site
            LET l_field_keys[02] = 'mhaelsite'
            LET l_var_keys_bak[02] = g_site
            LET l_var_keys[03] = g_mhae_d[l_ac].mhae001
            LET l_field_keys[03] = 'mhael001'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhael001
            LET l_var_keys[04] = g_mhae_m.mhae020
            LET l_field_keys[04] = 'mhael020'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhael020
            LET l_var_keys[05] = g_mhae_m.mhae021
            LET l_field_keys[05] = 'mhael021'
            LET l_var_keys_bak[05] = g_detail_multi_table_t.mhael021
            LET l_var_keys[06] = g_dlang
            LET l_field_keys[06] = 'mhael022'
            LET l_var_keys_bak[06] = g_detail_multi_table_t.mhael022
            LET l_vars[01] = g_mhae_d[l_ac].mhael023
            LET l_fields[01] = 'mhael023'
            LET l_vars[02] = g_mhae_d[l_ac].mhael024
            LET l_fields[02] = 'mhael024'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhael_t')
         END IF 
 
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_mhae_m),util.JSON.stringify(g_mhae_d_t)
                     LET g_log2 = util.JSON.stringify(g_mhae_m),util.JSON.stringify(g_mhae_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amhi300_mhae_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_mhae_m.mhaesite
               LET ls_keys[ls_keys.getLength()+1] = g_mhae_m.mhae020
               LET ls_keys[ls_keys.getLength()+1] = g_mhae_m.mhae021
 
               LET ls_keys[ls_keys.getLength()+1] = g_mhae_d_t.mhae001
 
               CALL amhi300_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE amhi300_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mhae_d[l_ac].* = g_mhae_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE amhi300_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_mhae_d.getLength() = 0 THEN
               NEXT FIELD mhae001
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mhae_d[li_reproduce_target].* = g_mhae_d[li_reproduce].*
               LET g_mhae2_d[li_reproduce_target].* = g_mhae2_d[li_reproduce].*
 
               LET g_mhae_d[li_reproduce_target].mhae001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mhae_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mhae_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_mhae2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL amhi300_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL amhi300_idx_chk()
            CALL amhi300_ui_detailshow()
        
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
            NEXT FIELD mhaesite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mhaestus
               WHEN "s_detail2"
                  NEXT FIELD mhae001_2
 
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
 
{<section id="amhi300.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION amhi300_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL amhi300_b_fill(g_wc2) #第一階單身填充
      CALL amhi300_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL amhi300_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_mhae_m.mhaesite,g_mhae_m.mhaesite_desc,g_mhae_m.mhae020,g_mhae_m.mhae020_desc,g_mhae_m.mhae021, 
       g_mhae_m.mhae021_desc
 
   CALL amhi300_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="amhi300.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION amhi300_ref_show()
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
   FOR l_ac = 1 TO g_mhae_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"

   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_mhae_d[l_ac].mhae001
   CALL ap_ref_array2(g_ref_fields," SELECT mhael023,mhael024 FROM mhael_t WHERE mhaelent = '"||g_enterprise||"' AND mhael001 = ? AND mhael022 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_mhae_d[l_ac].mhael023 = g_rtn_fields[1] 
   LET g_mhae_d[l_ac].mhael024 = g_rtn_fields[2] 
   DISPLAY BY NAME g_mhae_d[l_ac].mhael023,g_mhae_d[l_ac].mhael024
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_mhae2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="amhi300.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION amhi300_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE mhae_t.mhaesite 
   DEFINE l_oldno     LIKE mhae_t.mhaesite 
   DEFINE l_newno02     LIKE mhae_t.mhae020 
   DEFINE l_oldno02     LIKE mhae_t.mhae020 
   DEFINE l_newno03     LIKE mhae_t.mhae021 
   DEFINE l_oldno03     LIKE mhae_t.mhae021 
 
   DEFINE l_master    RECORD LIKE mhae_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mhae_t.* #此變數樣板目前無使用
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_insert      LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_mhae_m.mhaesite IS NULL
      OR g_mhae_m.mhae020 IS NULL
      OR g_mhae_m.mhae021 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_mhaesite_t = g_mhae_m.mhaesite
   LET g_mhae020_t = g_mhae_m.mhae020
   LET g_mhae021_t = g_mhae_m.mhae021
 
   
   LET g_mhae_m.mhaesite = ""
   LET g_mhae_m.mhae020 = ""
   LET g_mhae_m.mhae021 = ""
 
   LET g_master_insert = FALSE
   CALL amhi300_set_entry('a')
   CALL amhi300_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   CALL s_aooi500_default(g_prog,'mhaesite',g_mhae_m.mhaesite) RETURNING l_insert,g_mhae_m.mhaesite
   IF NOT l_insert THEN
      RETURN
   END IF
   LET g_site_flag = FALSE
   CALL amhi300_mhaesite_ref()
   LET g_mhae_m.mhae020 = ''
   LET g_mhae_m.mhae021 = ''
   #end add-point
   
   #清空key欄位的desc
      LET g_mhae_m.mhaesite_desc = ''
   DISPLAY BY NAME g_mhae_m.mhaesite_desc
   LET g_mhae_m.mhae020_desc = ''
   DISPLAY BY NAME g_mhae_m.mhae020_desc
   LET g_mhae_m.mhae021_desc = ''
   DISPLAY BY NAME g_mhae_m.mhae021_desc
 
   
   CALL amhi300_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_mhae_m.* TO NULL
      INITIALIZE g_mhae_d TO NULL
      INITIALIZE g_mhae2_d TO NULL
 
      CALL amhi300_show()
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
   CALL amhi300_set_act_visible()
   CALL amhi300_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_mhaesite_t = g_mhae_m.mhaesite
   LET g_mhae020_t = g_mhae_m.mhae020
   LET g_mhae021_t = g_mhae_m.mhae021
 
   
   #組合新增資料的條件
   LET g_add_browse = " mhaeent = " ||g_enterprise|| " AND",
                      " mhaesite = '", g_mhae_m.mhaesite, "' "
                      ," AND mhae020 = '", g_mhae_m.mhae020, "' "
                      ," AND mhae021 = '", g_mhae_m.mhae021, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amhi300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL amhi300_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL amhi300_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="amhi300.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION amhi300_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mhae_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE amhi300_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mhae_t
    WHERE mhaeent = g_enterprise AND mhaesite = g_mhaesite_t
    AND mhae020 = g_mhae020_t
    AND mhae021 = g_mhae021_t
 
       INTO TEMP amhi300_detail
   
   #將key修正為調整後   
   UPDATE amhi300_detail 
      #更新key欄位
      SET mhaesite = g_mhae_m.mhaesite
          , mhae020 = g_mhae_m.mhae020
          , mhae021 = g_mhae_m.mhae021
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , mhaeownid = g_user 
       , mhaeowndp = g_dept
       , mhaecrtid = g_user
       , mhaecrtdp = g_dept 
       , mhaecrtdt = ld_date
       , mhaemodid = g_user
       , mhaemoddt = ld_date
      #, mhaestus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO mhae_t SELECT * FROM amhi300_detail
   
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
   DROP TABLE amhi300_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
      #應用 a38 樣板自動產生(Version:6)
   #單身多語言複製
   DROP TABLE amhi300_detail_lang
   
   #add-point:單身複製前1 name="detail_reproduce.body.lang0.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE & INSERT 
   SELECT * FROM mhael_t 
    WHERE mhaelent = g_enterprise AND mhael001 = g_mhaesite_t
      AND mhael020 = g_mhae020_t      AND mhael021 = g_mhae021_t
     INTO TEMP amhi300_detail_lang
 
   #將key修正為調整後   
   UPDATE amhi300_detail_lang 
      #更新key欄位
      SET mhael001 = g_mhae_m.mhaesite
          , mhael020 = g_mhae_m.mhae020          , mhael021 = g_mhae_m.mhae021
  
   #add-point:單身修改前 name="detail_reproduce.body.lang0.b_update"
   
   #end add-point   
  
   #將資料塞回原table   
   INSERT INTO mhael_t SELECT * FROM amhi300_detail_lang
   
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
   DROP TABLE amhi300_detail_lang
   
   #add-point:單身複製後1 name="detail_reproduce.lang0.table1.a_insert"
   
   #end add-point
 
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mhaesite_t = g_mhae_m.mhaesite
   LET g_mhae020_t = g_mhae_m.mhae020
   LET g_mhae021_t = g_mhae_m.mhae021
 
   
   DROP TABLE amhi300_detail
   
END FUNCTION
 
{</section>}
 
{<section id="amhi300.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amhi300_delete()
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
   
   IF g_mhae_m.mhaesite IS NULL
   OR g_mhae_m.mhae020 IS NULL
   OR g_mhae_m.mhae021 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN amhi300_cl USING g_enterprise,g_mhae_m.mhaesite,g_mhae_m.mhae020,g_mhae_m.mhae021
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amhi300_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE amhi300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amhi300_master_referesh USING g_mhae_m.mhaesite,g_mhae_m.mhae020,g_mhae_m.mhae021 INTO g_mhae_m.mhaesite, 
       g_mhae_m.mhae020,g_mhae_m.mhae021,g_mhae_m.mhaesite_desc,g_mhae_m.mhae020_desc,g_mhae_m.mhae021_desc 
 
   
   #遮罩相關處理
   LET g_mhae_m_mask_o.* =  g_mhae_m.*
   CALL amhi300_mhae_t_mask()
   LET g_mhae_m_mask_n.* =  g_mhae_m.*
   
   CALL amhi300_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amhi300_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM mhae_t WHERE mhaeent = g_enterprise AND mhaesite = g_mhae_m.mhaesite
                                                               AND mhae020 = g_mhae_m.mhae020
                                                               AND mhae021 = g_mhae_m.mhae021
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mhae_t:",SQLERRMESSAGE 
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
         LET l_field_keys[01] = 'mhaelent'
         LET l_var_keys_bak[01] = g_enterprise
         LET l_field_keys[02] = 'mhaelsite'
         LET l_var_keys_bak[02] = g_site
         LET l_field_keys[03] = 'mhael020'
         LET l_var_keys_bak[03] = g_detail_multi_table_t.mhael020
         LET l_field_keys[03] = 'mhael021'
         LET l_var_keys_bak[03] = g_detail_multi_table_t.mhael021
         CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mhael_t')
 
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE amhi300_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_mhae_d.clear() 
      CALL g_mhae2_d.clear()       
 
     
      CALL amhi300_ui_browser_refresh()  
      #CALL amhi300_ui_headershow()  
      #CALL amhi300_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL amhi300_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL amhi300_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE amhi300_cl
 
   #功能已完成,通報訊息中心
   CALL amhi300_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="amhi300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amhi300_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_mhae_d.clear()
   CALL g_mhae2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT mhaestus,mhae001,mhae002,mhae003,mhae006,mhae004,mhae005,mhae007,mhae008, 
       mhae009,mhae010,mhae011,mhae012,mhae013,mhae014,mhae015,mhae016,mhae017,mhae018,mhae022,mhae019, 
       mhae023,mhae024,mhae025,mhae026,mhae027,mhae028,mhae029,mhae030,mhae031,mhae032,mhae033,mhae034, 
       mhae035,mhae036,mhae037,mhae038,mhae039,mhae001,mhaeownid,mhaeowndp,mhaecrtid,mhaecrtdp,mhaecrtdt, 
       mhaemodid,mhaemoddt,t1.oocql004 ,t2.pmaal004 ,t3.ooefl003 ,t4.oocql004 ,t5.rtaxl003 ,t6.rtaxl003 , 
       t7.rtaxl003 ,t8.oocql004 ,t9.ooag011 ,t10.ooefl003 ,t11.ooag011 ,t12.ooail003 ,t13.ooibl004 , 
       t14.staal003 ,t15.oocql004 ,t16.ooefl003 ,t17.rtaxl003 ,t18.ooag011 ,t19.ooefl003 ,t20.ooag011 , 
       t21.ooefl003 ,t22.ooag011 FROM mhae_t",   
               " LEFT JOIN mhael_t ON mhaelent = "||g_enterprise||" AND mhaelsite = '"||g_site||"' AND mhae001 = mhael001 AND mhae020 = mhael020 AND mhae021 = mhael021 AND mhael022 = '",g_dlang,"'",
               
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='2126' AND t1.oocql002=mhae002 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=mhae006 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=mhae004 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='2002' AND t4.oocql002=mhae009 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t5 ON t5.rtaxlent="||g_enterprise||" AND t5.rtaxl001=mhae010 AND t5.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t6 ON t6.rtaxlent="||g_enterprise||" AND t6.rtaxl001=mhae011 AND t6.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t7 ON t7.rtaxlent="||g_enterprise||" AND t7.rtaxl001=mhae012 AND t7.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='2127' AND t8.oocql002=mhae014 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=mhae018  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=mhae027 AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=mhae028  ",
               " LEFT JOIN ooail_t t12 ON t12.ooailent="||g_enterprise||" AND t12.ooail001=mhae030 AND t12.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t13 ON t13.ooiblent="||g_enterprise||" AND t13.ooibl002=mhae031 AND t13.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN staal_t t14 ON t14.staalent="||g_enterprise||" AND t14.staal001=mhae032 AND t14.staal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t15 ON t15.oocqlent="||g_enterprise||" AND t15.oocql001='2060' AND t15.oocql002=mhae033 AND t15.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t16 ON t16.ooeflent="||g_enterprise||" AND t16.ooefl001=mhae034 AND t16.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t17 ON t17.rtaxlent="||g_enterprise||" AND t17.rtaxl001=mhae036 AND t17.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t18 ON t18.ooagent="||g_enterprise||" AND t18.ooag001=mhaeownid  ",
               " LEFT JOIN ooefl_t t19 ON t19.ooeflent="||g_enterprise||" AND t19.ooefl001=mhaeowndp AND t19.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t20 ON t20.ooagent="||g_enterprise||" AND t20.ooag001=mhaecrtid  ",
               " LEFT JOIN ooefl_t t21 ON t21.ooeflent="||g_enterprise||" AND t21.ooefl001=mhaecrtdp AND t21.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t22 ON t22.ooagent="||g_enterprise||" AND t22.ooag001=mhaemodid  ",
 
               " WHERE mhaeent= ? AND mhaesite=? AND mhae020=? AND mhae021=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("mhae_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
#   LET g_sql = "SELECT  UNIQUE mhaestus,mhae001,mhae002,mhae003,mhae006,mhae004,mhae005,mhae007,mhae008, 
#       mhae009,mhae010,mhae011,mhae012,mhae013,mhae014,mhae015,mhae016,mhae017,mhae018,mhae019,mhae001, 
#       mhaeownid,mhaeowndp,mhaecrtid,mhaecrtdp,mhaecrtdt,mhaemodid,mhaemoddt,t1.oocql004 ,t2.pmaal004 , 
#       t3.ooefl003 ,t4.oocql004 ,t5.rtaxl003 ,t6.rtaxl003 ,t7.rtaxl003 ,t8.oocql004 ,t9.ooag011 ,t10.ooag011 , 
#       t11.ooefl003 ,t12.ooag011 ,t13.ooefl003 ,t14.ooag011 FROM mhae_t",   
#               " LEFT JOIN mhael_t ON mhaelent = '"||g_enterprise||"' AND mhae001 = mhael001 AND mhael002 = '",g_dlang,"'",
#               
#                              " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='2126' AND t1.oocql002=mhae002 AND t1.oocql003='"||g_dlang||"' ",
#               " LEFT JOIN pmaal_t t2 ON t2.pmaalent='"||g_enterprise||"' AND t2.pmaal001=mhae006 AND t2.pmaal002='"||g_dlang||"' ",
#               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=mhae004 AND t3.ooefl002='"||g_dlang||"' ",
#               " LEFT JOIN oocql_t t4 ON t4.oocqlent='"||g_enterprise||"' AND t4.oocql001='2002' AND t4.oocql002=mhae009 AND t4.oocql003='"||g_dlang||"' ",
#               " LEFT JOIN rtaxl_t t5 ON t5.rtaxlent='"||g_enterprise||"' AND t5.rtaxl001=mhae010 AND t5.rtaxl002='"||g_dlang||"' ",
#               " LEFT JOIN rtaxl_t t6 ON t6.rtaxlent='"||g_enterprise||"' AND t6.rtaxl001=mhae011 AND t6.rtaxl002='"||g_dlang||"' ",
#               " LEFT JOIN rtaxl_t t7 ON t7.rtaxlent='"||g_enterprise||"' AND t7.rtaxl001=mhae012 AND t7.rtaxl002='"||g_dlang||"' ",
#               " LEFT JOIN oocql_t t8 ON t8.oocqlent='"||g_enterprise||"' AND t8.oocql001='2127' AND t8.oocql002=mhae014 AND t8.oocql003='"||g_dlang||"' ",
#               " LEFT JOIN ooag_t t9 ON t9.ooagent='"||g_enterprise||"' AND t9.ooag001=mhae018  ",
#               " LEFT JOIN ooag_t t10 ON t10.ooagent='"||g_enterprise||"' AND t10.ooag001=mhaeownid  ",
#               " LEFT JOIN ooefl_t t11 ON t11.ooeflent='"||g_enterprise||"' AND t11.ooefl001=mhaeowndp AND t11.ooefl002='"||g_dlang||"' ",
#               " LEFT JOIN ooag_t t12 ON t12.ooagent='"||g_enterprise||"' AND t12.ooag001=mhaecrtid  ",
#               " LEFT JOIN ooefl_t t13 ON t13.ooeflent='"||g_enterprise||"' AND t13.ooefl001=mhaecrtdp AND t13.ooefl002='"||g_dlang||"' ",
#               " LEFT JOIN ooag_t t14 ON t14.ooagent='"||g_enterprise||"' AND t14.ooag001=mhaemodid  ",
# 
#               " WHERE mhaeent= ? AND mhaesite=? AND mhae020 = '"||g_mhae_m.mhae020||"' AND  mhae021 = '"||g_mhae_m.mhae021||"'"  
# 
#   IF NOT cl_null(g_wc2_table1) THEN
#      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("mhae_t")
#   END IF
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF amhi300_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY mhae_t.mhae001"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amhi300_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR amhi300_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mhae_m.mhaesite,g_mhae_m.mhae020,g_mhae_m.mhae021   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mhae_m.mhaesite,g_mhae_m.mhae020,g_mhae_m.mhae021 INTO g_mhae_d[l_ac].mhaestus, 
          g_mhae_d[l_ac].mhae001,g_mhae_d[l_ac].mhae002,g_mhae_d[l_ac].mhae003,g_mhae_d[l_ac].mhae006, 
          g_mhae_d[l_ac].mhae004,g_mhae_d[l_ac].mhae005,g_mhae_d[l_ac].mhae007,g_mhae_d[l_ac].mhae008, 
          g_mhae_d[l_ac].mhae009,g_mhae_d[l_ac].mhae010,g_mhae_d[l_ac].mhae011,g_mhae_d[l_ac].mhae012, 
          g_mhae_d[l_ac].mhae013,g_mhae_d[l_ac].mhae014,g_mhae_d[l_ac].mhae015,g_mhae_d[l_ac].mhae016, 
          g_mhae_d[l_ac].mhae017,g_mhae_d[l_ac].mhae018,g_mhae_d[l_ac].mhae022,g_mhae_d[l_ac].mhae019, 
          g_mhae_d[l_ac].mhae023,g_mhae_d[l_ac].mhae024,g_mhae_d[l_ac].mhae025,g_mhae_d[l_ac].mhae026, 
          g_mhae_d[l_ac].mhae027,g_mhae_d[l_ac].mhae028,g_mhae_d[l_ac].mhae029,g_mhae_d[l_ac].mhae030, 
          g_mhae_d[l_ac].mhae031,g_mhae_d[l_ac].mhae032,g_mhae_d[l_ac].mhae033,g_mhae_d[l_ac].mhae034, 
          g_mhae_d[l_ac].mhae035,g_mhae_d[l_ac].mhae036,g_mhae_d[l_ac].mhae037,g_mhae_d[l_ac].mhae038, 
          g_mhae_d[l_ac].mhae039,g_mhae2_d[l_ac].mhae001,g_mhae2_d[l_ac].mhaeownid,g_mhae2_d[l_ac].mhaeowndp, 
          g_mhae2_d[l_ac].mhaecrtid,g_mhae2_d[l_ac].mhaecrtdp,g_mhae2_d[l_ac].mhaecrtdt,g_mhae2_d[l_ac].mhaemodid, 
          g_mhae2_d[l_ac].mhaemoddt,g_mhae_d[l_ac].mhae002_desc,g_mhae_d[l_ac].mhae006_desc,g_mhae_d[l_ac].mhae004_desc, 
          g_mhae_d[l_ac].mhae009_desc,g_mhae_d[l_ac].mhae010_desc,g_mhae_d[l_ac].mhae011_desc,g_mhae_d[l_ac].mhae012_desc, 
          g_mhae_d[l_ac].mhae014_desc,g_mhae_d[l_ac].mhae018_desc,g_mhae_d[l_ac].mhae027_desc,g_mhae_d[l_ac].mhae028_desc, 
          g_mhae_d[l_ac].mhae030_desc,g_mhae_d[l_ac].mhae031_desc,g_mhae_d[l_ac].mhae032_desc,g_mhae_d[l_ac].mhae033_desc, 
          g_mhae_d[l_ac].mhae034_desc,g_mhae_d[l_ac].mhae036_desc,g_mhae2_d[l_ac].mhaeownid_desc,g_mhae2_d[l_ac].mhaeowndp_desc, 
          g_mhae2_d[l_ac].mhaecrtid_desc,g_mhae2_d[l_ac].mhaecrtdp_desc,g_mhae2_d[l_ac].mhaemodid_desc  
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
         CALL amhi300_mhae007_ref()
         CALL amhi300_mhae008_ref()
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
 
            CALL g_mhae_d.deleteElement(g_mhae_d.getLength())
      CALL g_mhae2_d.deleteElement(g_mhae2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_mhae_d.getLength()
      LET g_mhae_d_mask_o[l_ac].* =  g_mhae_d[l_ac].*
      CALL amhi300_mhae_t_mask()
      LET g_mhae_d_mask_n[l_ac].* =  g_mhae_d[l_ac].*
   END FOR
   
   LET g_mhae2_d_mask_o.* =  g_mhae2_d.*
   FOR l_ac = 1 TO g_mhae2_d.getLength()
      LET g_mhae2_d_mask_o[l_ac].* =  g_mhae2_d[l_ac].*
      CALL amhi300_mhae_t_mask()
      LET g_mhae2_d_mask_n[l_ac].* =  g_mhae2_d[l_ac].*
   END FOR
 
 
   FREE amhi300_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="amhi300.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION amhi300_idx_chk()
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
      IF g_detail_idx > g_mhae_d.getLength() THEN
         LET g_detail_idx = g_mhae_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_mhae_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mhae_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_mhae2_d.getLength() THEN
         LET g_detail_idx = g_mhae2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mhae2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mhae2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amhi300.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION amhi300_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_mhae_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="amhi300.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION amhi300_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM mhae_t
    WHERE mhaeent = g_enterprise AND mhaesite = g_mhae_m.mhaesite AND
                              mhae020 = g_mhae_m.mhae020 AND
                              mhae021 = g_mhae_m.mhae021 AND
 
          mhae001 = g_mhae_d_t.mhae001
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "mhae_t:",SQLERRMESSAGE 
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
 
{<section id="amhi300.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amhi300_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="amhi300.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amhi300_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="amhi300.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amhi300_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="amhi300.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION amhi300_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_mhae_d[l_ac].mhae001 = g_mhae_d_t.mhae001 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="amhi300.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION amhi300_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="amhi300.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amhi300_lock_b(ps_table,ps_page)
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
   #CALL amhi300_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="amhi300.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amhi300_unlock_b(ps_table,ps_page)
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
 
{<section id="amhi300.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION amhi300_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mhaesite,mhae020,mhae021",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("mhae020",TRUE)
   CALL cl_set_comp_entry("mhae021",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amhi300.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION amhi300_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE  l_cnt         LIKE type_t.num10
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mhaesite,mhae020,mhae021",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'mhaesite') OR g_site_flag THEN
      CALL cl_set_comp_entry("mhaesite",FALSE)
   END IF
   #单身有资料关闭楼栋楼层栏位
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM mhae_t 
    WHERE mhaeent = g_enterprise 
      AND mhae020 = g_mhae_m.mhae020
      AND mhae021 = g_mhae_m.mhae021
      AND mhae001 IS NOT NULL
   IF  l_cnt > 0 THEN
      CALL cl_set_comp_entry("mhae020",FALSE)
      CALL cl_set_comp_entry("mhae021",FALSE)
   END IF 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amhi300.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amhi300_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amhi300.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amhi300_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="amhi300.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION amhi300_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amhi300.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION amhi300_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amhi300.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION amhi300_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amhi300.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION amhi300_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amhi300.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amhi300_default_search()
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
      LET ls_wc = ls_wc, " mhaesite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " mhae020 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " mhae021 = '", g_argv[03], "' AND "
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
 
{<section id="amhi300.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION amhi300_fill_chk(ps_idx)
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
 
{<section id="amhi300.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION amhi300_modify_detail_chk(ps_record)
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
         LET ls_return = "mhaestus"
      WHEN "s_detail2"
         LET ls_return = "mhae001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="amhi300.mask_functions" >}
&include "erp/amh/amhi300_mask.4gl"
 
{</section>}
 
{<section id="amhi300.state_change" >}
    
 
{</section>}
 
{<section id="amhi300.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amhi300_set_pk_array()
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
   LET g_pk_array[1].values = g_mhae_m.mhaesite
   LET g_pk_array[1].column = 'mhaesite'
   LET g_pk_array[2].values = g_mhae_m.mhae020
   LET g_pk_array[2].column = 'mhae020'
   LET g_pk_array[3].values = g_mhae_m.mhae021
   LET g_pk_array[3].column = 'mhae021'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amhi300.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION amhi300_msgcentre_notify(lc_state)
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
   CALL amhi300_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mhae_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amhi300.other_function" readonly="Y" >}

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae002_ref()
      
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhae_d[l_ac].mhae002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2126' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae002_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae006_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhae_d[l_ac].mhae006
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae006_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhae_d[l_ac].mhae004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae004_desc
END FUNCTION

################################################################################
 
################################################################################
PRIVATE FUNCTION amhi300_mhae007_ref()
   DEFINE l_ooef019          LIKE ooef_t.ooef019
   SELECT ooef019 INTO l_ooef019
     FROM ooef_t
    WHERE ooef001 = g_mhae_m.mhaesite
      AND ooefent = g_enterprise
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhae_d[l_ac].mhae007
   CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"' AND oodbl001='"||l_ooef019||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae007_desc = '', g_rtn_fields[1] , ''
   DISPLAY  BY NAME g_mhae_d[l_ac].mhae007_desc
      
   SELECT oodb006 INTO g_mhae_d[l_ac].mhae007_desc_1 FROM oodb_t
    WHERE oodbent = g_enterprise AND oodb002 = g_mhae_d[l_ac].mhae007 AND oodb004='1'
   DISPLAY  BY NAME g_mhae_d[l_ac].mhae007_desc_1
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae009_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhae_d[l_ac].mhae009
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae009_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae010_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhae_d[l_ac].mhae010
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae010_desc
  
   #带出经营种类
   SELECT rtax003 INTO  g_mhae_d[l_ac].mhae011  FROM rtax_t 
   WHERE rtaxent = g_enterprise AND rtax001 = g_mhae_d[l_ac].mhae010
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhae_d[l_ac].mhae011
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae011_desc
   
   #带出经营大类
   SELECT rtax003 INTO  g_mhae_d[l_ac].mhae012  FROM rtax_t 
   WHERE rtaxent = g_enterprise AND rtax001 = g_mhae_d[l_ac].mhae011
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhae_d[l_ac].mhae012
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae012_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae008_ref()
   DEFINE l_ooef019          LIKE ooef_t.ooef019
   SELECT ooef019 INTO l_ooef019
     FROM ooef_t
    WHERE ooef001 = g_mhae_m.mhaesite
      AND ooefent = g_enterprise
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhae_d[l_ac].mhae008
   CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"' AND oodbl001='"||l_ooef019||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae008_desc = '', g_rtn_fields[1] , ''
   DISPLAY  BY NAME g_mhae_d[l_ac].mhae008_desc
      
   SELECT oodb006 INTO g_mhae_d[l_ac].mhae008_desc_1 FROM oodb_t
    WHERE oodbent = g_enterprise AND oodb002 = g_mhae_d[l_ac].mhae008 AND oodb004='1'
   DISPLAY  BY NAME g_mhae_d[l_ac].mhae008_desc_1
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae018_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhae_d[l_ac].mhae018
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae018_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae018_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhaesite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhae_m.mhaesite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_m.mhaesite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_m.mhaesite_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae020_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhae_m.mhae020
   CALL ap_ref_array2(g_ref_fields,"SELECT mhaal003 FROM mhaal_t WHERE mhaalent='"||g_enterprise||"' AND mhaal001=? AND mhaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_m.mhae020_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_m.mhae020_desc
END FUNCTION

################################################################################
 
################################################################################
PRIVATE FUNCTION amhi300_mhae021_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhae_m.mhae020
   LET g_ref_fields[2] = g_mhae_m.mhae021
   CALL ap_ref_array2(g_ref_fields,"SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=? AND mhabl002=? AND mhabl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_m.mhae021_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_m.mhae021_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae014_ref()
  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =g_mhae_d[l_ac].mhae014
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2127' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae014_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae014_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL amhi300_mhae027_ref()
# Date & Author..: 2015/9/14 By dengdd
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi300_mhae027_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =g_mhae_d[l_ac].mhae027
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=?  AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae027_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae027_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae028_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =g_mhae_d[l_ac].mhae028
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae028_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae028_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae030_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =g_mhae_d[l_ac].mhae030
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae030_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae030_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae031_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =g_mhae_d[l_ac].mhae031
   CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae031_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae031_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae032_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =g_mhae_d[l_ac].mhae032
   CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae032_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae032_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae033_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =g_mhae_d[l_ac].mhae033
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2060' AND oocql002= ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae033_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae033_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae034_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =g_mhae_d[l_ac].mhae034
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND oocql001='2060' AND oocql002= ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae034_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae034_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION amhi300_mhae036_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =g_mhae_d[l_ac].mhae036
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001= ? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhae_d[l_ac].mhae036_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhae_d[l_ac].mhae036_desc
END FUNCTION

 
{</section>}
 
