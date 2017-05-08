#該程式未解開Section, 採用最新樣板產出!
{<section id="amri100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-07-29 00:58:32), PR版次:0008(2016-07-29 01:08:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000201
#+ Filename...: amri100
#+ Description: 資源保修項目設定作業
#+ Creator....: 04543(2014-04-24 17:26:00)
#+ Modifier...: 00593 -SD/PR- 00593
 
{</section>}
 
{<section id="amri100.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#25  2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#23  2016/04/22 BY 07900   校验代码重复错误讯息的修改
#160716-00003#1   2016/07/28 By Sarah   原本使用q_imaa001開窗的通通改成q_imaf001_15,使用v_imaa001校驗的通通改成v_imaf001_14
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
PRIVATE type type_g_mraj_m        RECORD
       mrajsite LIKE mraj_t.mrajsite, 
   mraj001 LIKE mraj_t.mraj001, 
   mraj001_desc LIKE type_t.chr80, 
   mraj002 LIKE mraj_t.mraj002, 
   mraj002_desc LIKE type_t.chr80, 
   mraj003 LIKE mraj_t.mraj003, 
   mraj003_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mraj_d        RECORD
       mrajseq LIKE mraj_t.mrajseq, 
   mraj004 LIKE mraj_t.mraj004, 
   mraj004_desc LIKE type_t.chr500, 
   mraj005 LIKE mraj_t.mraj005, 
   mraj005_desc LIKE type_t.chr500, 
   mraj006 LIKE mraj_t.mraj006, 
   mraj007 LIKE mraj_t.mraj007, 
   mraj008 LIKE mraj_t.mraj008, 
   mraj009 LIKE mraj_t.mraj009, 
   mraj012 LIKE mraj_t.mraj012, 
   mraj013 LIKE mraj_t.mraj013
       END RECORD
PRIVATE TYPE type_g_mraj2_d RECORD
       mrajseq LIKE mraj_t.mrajseq, 
   mrajownid LIKE mraj_t.mrajownid, 
   mrajownid_desc LIKE type_t.chr500, 
   mrajowndp LIKE mraj_t.mrajowndp, 
   mrajowndp_desc LIKE type_t.chr500, 
   mrajcrtid LIKE mraj_t.mrajcrtid, 
   mrajcrtid_desc LIKE type_t.chr500, 
   mrajcrtdp LIKE mraj_t.mrajcrtdp, 
   mrajcrtdp_desc LIKE type_t.chr500, 
   mrajcrtdt DATETIME YEAR TO SECOND, 
   mrajmodid LIKE mraj_t.mrajmodid, 
   mrajmodid_desc LIKE type_t.chr500, 
   mrajmoddt DATETIME YEAR TO SECOND, 
   mrajcnfid LIKE mraj_t.mrajcnfid, 
   mrajcnfid_desc LIKE type_t.chr500, 
   mrajcnfdt DATETIME YEAR TO SECOND, 
   mrajstus LIKE mraj_t.mrajstus
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_mrak_d        RECORD
  mrakseq1      LIKE mrak_t.mrakseq1,
  mrak004       LIKE mrak_t.mrak004,
  mrak004_desc  LIKE type_t.chr500,
  mrak004_desc1 LIKE type_t.chr500,
  mrak005       LIKE mrak_t.mrak005,
  mrak006       LIKE mrak_t.mrak006,
  mrak006_desc  LIKE type_t.chr500,
  mrak007       LIKE mrak_t.mrak007,
  mrak008       LIKE mrak_t.mrak008
                          END RECORD

DEFINE g_mrak_d          DYNAMIC ARRAY OF type_g_mrak_d
DEFINE g_mrak_d_o        type_g_mrak_d
DEFINE g_mrak_d_t        type_g_mrak_d

DEFINE g_rec_b2          LIKE type_t.num5
DEFINE l_ac2             LIKE type_t.num5

DEFINE g_ask_show        LIKE type_t.chr1            #詢問是否show出已輸入單身
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_mraj_m          type_g_mraj_m
DEFINE g_mraj_m_t        type_g_mraj_m
DEFINE g_mraj_m_o        type_g_mraj_m
DEFINE g_mraj_m_mask_o   type_g_mraj_m #轉換遮罩前資料
DEFINE g_mraj_m_mask_n   type_g_mraj_m #轉換遮罩後資料
 
   DEFINE g_mrajsite_t LIKE mraj_t.mrajsite
DEFINE g_mraj001_t LIKE mraj_t.mraj001
DEFINE g_mraj002_t LIKE mraj_t.mraj002
DEFINE g_mraj003_t LIKE mraj_t.mraj003
 
 
DEFINE g_mraj_d          DYNAMIC ARRAY OF type_g_mraj_d
DEFINE g_mraj_d_t        type_g_mraj_d
DEFINE g_mraj_d_o        type_g_mraj_d
DEFINE g_mraj_d_mask_o   DYNAMIC ARRAY OF type_g_mraj_d #轉換遮罩前資料
DEFINE g_mraj_d_mask_n   DYNAMIC ARRAY OF type_g_mraj_d #轉換遮罩後資料
DEFINE g_mraj2_d   DYNAMIC ARRAY OF type_g_mraj2_d
DEFINE g_mraj2_d_t type_g_mraj2_d
DEFINE g_mraj2_d_o type_g_mraj2_d
DEFINE g_mraj2_d_mask_o   DYNAMIC ARRAY OF type_g_mraj2_d #轉換遮罩前資料
DEFINE g_mraj2_d_mask_n   DYNAMIC ARRAY OF type_g_mraj2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_mrajsite LIKE mraj_t.mrajsite,
      b_mraj001 LIKE mraj_t.mraj001,
   b_mraj001_desc LIKE type_t.chr80,
      b_mraj002 LIKE mraj_t.mraj002,
   b_mraj002_desc LIKE type_t.chr80,
      b_mraj003 LIKE mraj_t.mraj003,
   b_mraj003_desc LIKE type_t.chr80
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
 
{<section id="amri100.main" >}
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
   CALL cl_ap_init("amr","")
 
   #add-point:作業初始化 name="main.init"
   LET g_errshow = '1'
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
 
   #end add-point
   LET g_forupd_sql = " SELECT mrajsite,mraj001,'',mraj002,'',mraj003,''", 
                      " FROM mraj_t",
                      " WHERE mrajent= ? AND mrajsite=? AND mraj001=? AND mraj002=? AND mraj003=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   LET g_forupd_sql = "SELECT mrajsite,mraj001,'',mraj002,'',mraj003,''",
                      "  FROM mraj_t LEFT OUTER JOIN mrak_t",
                      "                           ON mrajent = mrakent",
                      "                          AND mrajsite = mraksite",
                      "                          AND mraj001 = mrak001",
                      "                          AND mraj002 = mrak002",
                      "                          AND mraj003 = mrak003",
                      "                          AND mrajseq = mrakseq",                      
                      " WHERE mrajent= ? AND mrajsite=? AND mraj001=? AND mraj002=? AND mraj003=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amri100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mrajsite,t0.mraj001,t0.mraj002,t0.mraj003,t1.oocql004 ,t2.oocql004", 
 
               " FROM mraj_t t0",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='1101' AND t1.oocql002=t0.mraj001 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='1104' AND t2.oocql002=t0.mraj003 AND t2.oocql003='"||g_dlang||"' ",
 
               " WHERE t0.mrajent = " ||g_enterprise|| " AND t0.mrajsite = ? AND t0.mraj001 = ? AND t0.mraj002 = ? AND t0.mraj003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE amri100_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amri100 WITH FORM cl_ap_formpath("amr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amri100_init()   
 
      #進入選單 Menu (="N")
      CALL amri100_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amri100
      
   END IF 
   
   CLOSE amri100_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amri100.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION amri100_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('mraj013','5204') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('mrak007','5213') 
   #end add-point
   
   CALL amri100_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="amri100.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION amri100_ui_dialog()
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
         INITIALIZE g_mraj_m.* TO NULL
         CALL g_mraj_d.clear()
         CALL g_mraj2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL amri100_init()
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
               CALL amri100_idx_chk()
               CALL amri100_fetch('') # reload data
               LET g_detail_idx = 1
               CALL amri100_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_mraj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL amri100_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL amri100_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               CALL amri100_b_fill2('0')
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
        
         DISPLAY ARRAY g_mraj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL amri100_idx_chk()
               CALL amri100_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body2.before_row"
               CALL amri100_b_fill2('0')
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
         DISPLAY ARRAY g_mrak_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b2)  
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac2 = g_detail_idx2
               CALL amri100_ui_detailshow()
                           
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL amri100_browser_fill("")
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
               CALL amri100_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL amri100_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL amri100_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL amri100_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amri100_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL amri100_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amri100_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL amri100_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amri100_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL amri100_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amri100_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL amri100_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amri100_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_mraj_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_mraj2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  CALL g_export_node.clear()
                  LET g_export_node[1] = base.typeInfo.create(g_mraj_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_mrak_d)
                  LET g_export_id[2]   = "s_detail3"
                  LET g_export_node[3] = base.typeInfo.create(g_mraj2_d)
                  LET g_export_id[3]   = "s_detail2"
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
               NEXT FIELD mrajseq
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
               CALL amri100_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL amri100_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL amri100_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL amri100_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL amri100_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL amri100_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amri100_insert()
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
               CALL amri100_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL amri100_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL amri100_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amri100_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amri100_set_pk_array()
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
 
{<section id="amri100.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION amri100_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="amri100.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION amri100_browser_fill(ps_page_action)
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
   
   LET g_wc = g_wc," AND mrajsite = '",g_site,"'"
   #end add-point    
 
   LET l_searchcol = "mrajsite,mraj001,mraj002,mraj003"
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
      LET l_sub_sql = " SELECT DISTINCT mrajsite ",
                      ", mraj001 ",
                      ", mraj002 ",
                      ", mraj003 ",
 
                      " FROM mraj_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE mrajent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mraj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mrajsite ",
                      ", mraj001 ",
                      ", mraj002 ",
                      ", mraj003 ",
 
                      " FROM mraj_t ",
                      " ",
                      " ", 
 
 
                      " WHERE mrajent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mraj_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   
   #加入排除元件
   IF g_wc2 <> " 1=1" OR NOT cl_null(g_wc2) THEN
      #單身有輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE mrajsite,mraj001,mraj002,mraj003",
                      "   FROM mraj_t LEFT OUTER JOIN mrak_t",
                      "     ON mrajent = mrakent",                      
                      "    AND mrajsite = mraksite",
                      "    AND mraj001 = mrak001",
                      "    AND mraj002 = mrak002",
                      "    AND mraj003 = mrak003",
                      "    AND mrajseq = mrakseq",
                      "  WHERE mrajent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mraj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE mrajsite,mraj001,mraj002,mraj003",
                      "   FROM mraj_t",
                      "  WHERE mrajent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("mraj_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
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
      INITIALIZE g_mraj_m.* TO NULL
      CALL g_mraj_d.clear()        
      CALL g_mraj2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mrajsite,t0.mraj001,t0.mraj002,t0.mraj003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.mrajsite,t0.mraj001,t0.mraj002,t0.mraj003,t1.oocql004 ,t2.oocql004", 
 
                " FROM mraj_t t0",
                #" ",
                " ",
 
 
 
                               " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='1101' AND t1.oocql002=t0.mraj001 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='1104' AND t2.oocql002=t0.mraj003 AND t2.oocql003='"||g_dlang||"' ",
 
                " WHERE t0.mrajent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("mraj_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #加入排除元件
   IF g_wc2 <> " 1=1" OR NOT cl_null(g_wc2) THEN
      
      #依照mrajsite,mraj001,'',mraj002,'',mraj003,'' Browser欄位定義(取代原本bs_sql功能)
      LET l_sub_sql  = "SELECT DISTINCT mrajsite,mraj001,'',mraj002,'',mraj003,'' ",
                      "   FROM mraj_t LEFT OUTER JOIN mrak_t",
                      "     ON mrajent = mrakent",                      
                      "    AND mrajsite = mraksite",
                      "    AND mraj001 = mrak001",
                      "    AND mraj002 = mrak002",
                      "    AND mraj003 = mrak003",
                      "    AND mrajseq = mrakseq",
                      "  WHERE mrajent = '" ||g_enterprise|| "' AND ",g_wc, " AND ", g_wc2, cl_sql_add_filter("mraj_t")
   ELSE
      #單身無輸入資料
      LET l_sub_sql  = "SELECT DISTINCT mrajsite,mraj001,'',mraj002,'',mraj003,'' ",
                       "   FROM mraj_t",
                       "  WHERE mrajent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("mraj_t")
   END IF 
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
 
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"mraj_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_mrajsite,g_browser[g_cnt].b_mraj001,g_browser[g_cnt].b_mraj002, 
          g_browser[g_cnt].b_mraj003,g_browser[g_cnt].b_mraj001_desc,g_browser[g_cnt].b_mraj003_desc  
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
      
      CALL amri100_mraj002_ref(g_browser[g_cnt].b_mraj002)
      RETURNING g_browser[g_cnt].b_mraj002_desc
      DISPLAY BY NAME g_browser[g_cnt].b_mraj002_desc
            
         #end add-point  
      
         #遮罩相關處理
         CALL amri100_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_mrajsite) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_mraj_m.* TO NULL
      CALL g_mraj_d.clear()
      CALL g_mraj2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL amri100_fetch('')
   
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
 
{<section id="amri100.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION amri100_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mraj_m.mrajsite = g_browser[g_current_idx].b_mrajsite   
   LET g_mraj_m.mraj001 = g_browser[g_current_idx].b_mraj001   
   LET g_mraj_m.mraj002 = g_browser[g_current_idx].b_mraj002   
   LET g_mraj_m.mraj003 = g_browser[g_current_idx].b_mraj003   
 
   EXECUTE amri100_master_referesh USING g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003 INTO g_mraj_m.mrajsite, 
       g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003,g_mraj_m.mraj001_desc,g_mraj_m.mraj003_desc 
 
   CALL amri100_show()
   
END FUNCTION
 
{</section>}
 
{<section id="amri100.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION amri100_ui_detailshow()
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
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx2)
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="amri100.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION amri100_ui_browser_refresh()
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
      IF g_browser[l_i].b_mrajsite = g_mraj_m.mrajsite 
         AND g_browser[l_i].b_mraj001 = g_mraj_m.mraj001 
         AND g_browser[l_i].b_mraj002 = g_mraj_m.mraj002 
         AND g_browser[l_i].b_mraj003 = g_mraj_m.mraj003 
 
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
 
{<section id="amri100.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION amri100_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_wc3       STRING
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_mraj_m.* TO NULL
   CALL g_mraj_d.clear()
   CALL g_mraj2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   CALL g_mrak_d.clear()
   INITIALIZE l_wc3 TO NULL
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON mrajsite,mraj001,mraj002,mraj002_desc,mraj003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajsite
            #add-point:BEFORE FIELD mrajsite name="construct.b.mrajsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrajsite
            
            #add-point:AFTER FIELD mrajsite name="construct.a.mrajsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrajsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrajsite
            #add-point:ON ACTION controlp INFIELD mrajsite name="construct.c.mrajsite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mraj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj001
            #add-point:ON ACTION controlp INFIELD mraj001 name="construct.c.mraj001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.arg1 = '1101'
            
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mraj001  #顯示到畫面上
            NEXT FIELD mraj001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj001
            #add-point:BEFORE FIELD mraj001 name="construct.b.mraj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj001
            
            #add-point:AFTER FIELD mraj001 name="construct.a.mraj001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mraj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj002
            #add-point:ON ACTION controlp INFIELD mraj002 name="construct.c.mraj002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mraj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mraj002  #顯示到畫面上
            NEXT FIELD mraj002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj002
            #add-point:BEFORE FIELD mraj002 name="construct.b.mraj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj002
            
            #add-point:AFTER FIELD mraj002 name="construct.a.mraj002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj002_desc
            #add-point:BEFORE FIELD mraj002_desc name="construct.b.mraj002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj002_desc
            
            #add-point:AFTER FIELD mraj002_desc name="construct.a.mraj002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mraj002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj002_desc
            #add-point:ON ACTION controlp INFIELD mraj002_desc name="construct.c.mraj002_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mraj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj003
            #add-point:ON ACTION controlp INFIELD mraj003 name="construct.c.mraj003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.arg1 = '1104'
            
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mraj003  #顯示到畫面上
            NEXT FIELD mraj003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj003
            #add-point:BEFORE FIELD mraj003 name="construct.b.mraj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj003
            
            #add-point:AFTER FIELD mraj003 name="construct.a.mraj003"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON mrajseq,mraj004,mraj005,mraj006,mraj007,mraj008,mraj009,mraj012,mraj013, 
          mrajownid,mrajowndp,mrajcrtid,mrajcrtdp,mrajcrtdt,mrajmodid,mrajmoddt,mrajcnfid,mrajcnfdt, 
          mrajstus
           FROM s_detail1[1].mrajseq,s_detail1[1].mraj004,s_detail1[1].mraj005,s_detail1[1].mraj006, 
               s_detail1[1].mraj007,s_detail1[1].mraj008,s_detail1[1].mraj009,s_detail1[1].mraj012,s_detail1[1].mraj013, 
               s_detail2[1].mrajownid,s_detail2[1].mrajowndp,s_detail2[1].mrajcrtid,s_detail2[1].mrajcrtdp, 
               s_detail2[1].mrajcrtdt,s_detail2[1].mrajmodid,s_detail2[1].mrajmoddt,s_detail2[1].mrajcnfid, 
               s_detail2[1].mrajcnfdt,s_detail2[1].mrajstus
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mrajcrtdt>>----
         AFTER FIELD mrajcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mrajmoddt>>----
         AFTER FIELD mrajmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrajcnfdt>>----
         AFTER FIELD mrajcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrajpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajseq
            #add-point:BEFORE FIELD mrajseq name="construct.b.page1.mrajseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrajseq
            
            #add-point:AFTER FIELD mrajseq name="construct.a.page1.mrajseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrajseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrajseq
            #add-point:ON ACTION controlp INFIELD mrajseq name="construct.c.page1.mrajseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mraj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj004
            #add-point:ON ACTION controlp INFIELD mraj004 name="construct.c.page1.mraj004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.arg1 = '1110'
            
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mraj004  #顯示到畫面上
            NEXT FIELD mraj004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj004
            #add-point:BEFORE FIELD mraj004 name="construct.b.page1.mraj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj004
            
            #add-point:AFTER FIELD mraj004 name="construct.a.page1.mraj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mraj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj005
            #add-point:ON ACTION controlp INFIELD mraj005 name="construct.c.page1.mraj005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.arg1 = '1114'
            
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mraj005  #顯示到畫面上
            NEXT FIELD mraj005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj005
            #add-point:BEFORE FIELD mraj005 name="construct.b.page1.mraj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj005
            
            #add-point:AFTER FIELD mraj005 name="construct.a.page1.mraj005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj006
            #add-point:BEFORE FIELD mraj006 name="construct.b.page1.mraj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj006
            
            #add-point:AFTER FIELD mraj006 name="construct.a.page1.mraj006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mraj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj006
            #add-point:ON ACTION controlp INFIELD mraj006 name="construct.c.page1.mraj006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mraj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj007
            #add-point:ON ACTION controlp INFIELD mraj007 name="construct.c.page1.mraj007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mraj007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mraj007  #顯示到畫面上
            NEXT FIELD mraj007                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj007
            #add-point:BEFORE FIELD mraj007 name="construct.b.page1.mraj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj007
            
            #add-point:AFTER FIELD mraj007 name="construct.a.page1.mraj007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj008
            #add-point:BEFORE FIELD mraj008 name="construct.b.page1.mraj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj008
            
            #add-point:AFTER FIELD mraj008 name="construct.a.page1.mraj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mraj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj008
            #add-point:ON ACTION controlp INFIELD mraj008 name="construct.c.page1.mraj008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj009
            #add-point:BEFORE FIELD mraj009 name="construct.b.page1.mraj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj009
            
            #add-point:AFTER FIELD mraj009 name="construct.a.page1.mraj009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mraj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj009
            #add-point:ON ACTION controlp INFIELD mraj009 name="construct.c.page1.mraj009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj012
            #add-point:BEFORE FIELD mraj012 name="construct.b.page1.mraj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj012
            
            #add-point:AFTER FIELD mraj012 name="construct.a.page1.mraj012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mraj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj012
            #add-point:ON ACTION controlp INFIELD mraj012 name="construct.c.page1.mraj012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj013
            #add-point:BEFORE FIELD mraj013 name="construct.b.page1.mraj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj013
            
            #add-point:AFTER FIELD mraj013 name="construct.a.page1.mraj013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mraj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj013
            #add-point:ON ACTION controlp INFIELD mraj013 name="construct.c.page1.mraj013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mrajownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrajownid
            #add-point:ON ACTION controlp INFIELD mrajownid name="construct.c.page2.mrajownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrajownid  #顯示到畫面上
            NEXT FIELD mrajownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajownid
            #add-point:BEFORE FIELD mrajownid name="construct.b.page2.mrajownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrajownid
            
            #add-point:AFTER FIELD mrajownid name="construct.a.page2.mrajownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrajowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrajowndp
            #add-point:ON ACTION controlp INFIELD mrajowndp name="construct.c.page2.mrajowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrajowndp  #顯示到畫面上
            NEXT FIELD mrajowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajowndp
            #add-point:BEFORE FIELD mrajowndp name="construct.b.page2.mrajowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrajowndp
            
            #add-point:AFTER FIELD mrajowndp name="construct.a.page2.mrajowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrajcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrajcrtid
            #add-point:ON ACTION controlp INFIELD mrajcrtid name="construct.c.page2.mrajcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrajcrtid  #顯示到畫面上
            NEXT FIELD mrajcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajcrtid
            #add-point:BEFORE FIELD mrajcrtid name="construct.b.page2.mrajcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrajcrtid
            
            #add-point:AFTER FIELD mrajcrtid name="construct.a.page2.mrajcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrajcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrajcrtdp
            #add-point:ON ACTION controlp INFIELD mrajcrtdp name="construct.c.page2.mrajcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrajcrtdp  #顯示到畫面上
            NEXT FIELD mrajcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajcrtdp
            #add-point:BEFORE FIELD mrajcrtdp name="construct.b.page2.mrajcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrajcrtdp
            
            #add-point:AFTER FIELD mrajcrtdp name="construct.a.page2.mrajcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajcrtdt
            #add-point:BEFORE FIELD mrajcrtdt name="construct.b.page2.mrajcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mrajmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrajmodid
            #add-point:ON ACTION controlp INFIELD mrajmodid name="construct.c.page2.mrajmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrajmodid  #顯示到畫面上
            NEXT FIELD mrajmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajmodid
            #add-point:BEFORE FIELD mrajmodid name="construct.b.page2.mrajmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrajmodid
            
            #add-point:AFTER FIELD mrajmodid name="construct.a.page2.mrajmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajmoddt
            #add-point:BEFORE FIELD mrajmoddt name="construct.b.page2.mrajmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mrajcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrajcnfid
            #add-point:ON ACTION controlp INFIELD mrajcnfid name="construct.c.page2.mrajcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrajcnfid  #顯示到畫面上
            NEXT FIELD mrajcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajcnfid
            #add-point:BEFORE FIELD mrajcnfid name="construct.b.page2.mrajcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrajcnfid
            
            #add-point:AFTER FIELD mrajcnfid name="construct.a.page2.mrajcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajcnfdt
            #add-point:BEFORE FIELD mrajcnfdt name="construct.b.page2.mrajcnfdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajstus
            #add-point:BEFORE FIELD mrajstus name="construct.b.page2.mrajstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrajstus
            
            #add-point:AFTER FIELD mrajstus name="construct.a.page2.mrajstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrajstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrajstus
            #add-point:ON ACTION controlp INFIELD mrajstus name="construct.c.page2.mrajstus"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      CONSTRUCT l_wc3 ON mrakseq1,mrak004,mrak005,
                         mrak006,mrak007,mrak008
           FROM s_detail3[1].mrakseq1,s_detail3[1].mrak004,s_detail3[1].mrak005,
                s_detail3[1].mrak006,s_detail3[1].mrak007,s_detail3[1].mrak008
                      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD mrak004
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#160716-00003#1-s
#           CALL q_imaa001()                       #呼叫開窗
            CALL q_imaf001_15()                    #呼叫開窗
#160716-00003#1-e
            DISPLAY g_qryparam.return1 TO mrak004  #顯示到畫面上
            NEXT FIELD mrak004                     #返回原欄位
                        
         ON ACTION controlp INFIELD mrak006
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrak004  #顯示到畫面上
            NEXT FIELD mrak004                     #返回原欄位
            
      END CONSTRUCT
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
   IF NOT cl_null(l_wc3) OR l_wc3 <> 1=1 THEN
      LET g_wc2_table1 = g_wc2_table1," AND ",l_wc3
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
 
{<section id="amri100.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION amri100_filter()
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
      CONSTRUCT g_wc_filter ON mrajsite,mraj001,mraj002,mraj003
                          FROM s_browse[1].b_mrajsite,s_browse[1].b_mraj001,s_browse[1].b_mraj002,s_browse[1].b_mraj003 
 
 
         BEFORE CONSTRUCT
               DISPLAY amri100_filter_parser('mrajsite') TO s_browse[1].b_mrajsite
            DISPLAY amri100_filter_parser('mraj001') TO s_browse[1].b_mraj001
            DISPLAY amri100_filter_parser('mraj002') TO s_browse[1].b_mraj002
            DISPLAY amri100_filter_parser('mraj003') TO s_browse[1].b_mraj003
      
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
 
      CALL amri100_filter_show('mrajsite')
   CALL amri100_filter_show('mraj001')
   CALL amri100_filter_show('mraj002')
   CALL amri100_filter_show('mraj003')
 
END FUNCTION
 
{</section>}
 
{<section id="amri100.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION amri100_filter_parser(ps_field)
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
 
{<section id="amri100.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION amri100_filter_show(ps_field)
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
   LET ls_condition = amri100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="amri100.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION amri100_query()
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
   CALL g_mraj_d.clear()
   CALL g_mraj2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL amri100_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL amri100_browser_fill(g_wc)
      CALL amri100_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL amri100_browser_fill("F")
   
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
      CALL amri100_fetch("F") 
   END IF
   
   CALL amri100_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="amri100.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION amri100_fetch(p_flag)
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
   
   LET g_mraj_m.mrajsite = g_browser[g_current_idx].b_mrajsite
   LET g_mraj_m.mraj001 = g_browser[g_current_idx].b_mraj001
   LET g_mraj_m.mraj002 = g_browser[g_current_idx].b_mraj002
   LET g_mraj_m.mraj003 = g_browser[g_current_idx].b_mraj003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE amri100_master_referesh USING g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003 INTO g_mraj_m.mrajsite, 
       g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003,g_mraj_m.mraj001_desc,g_mraj_m.mraj003_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "mraj_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_mraj_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_mraj_m_mask_o.* =  g_mraj_m.*
   CALL amri100_mraj_t_mask()
   LET g_mraj_m_mask_n.* =  g_mraj_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL amri100_set_act_visible()
   CALL amri100_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_mraj_m_t.* = g_mraj_m.*
   LET g_mraj_m_o.* = g_mraj_m.*
   
   #重新顯示   
   CALL amri100_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="amri100.insert" >}
#+ 資料新增
PRIVATE FUNCTION amri100_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   CALL g_mrak_d.clear()
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_mraj_d.clear()
   CALL g_mraj2_d.clear()
 
 
   INITIALIZE g_mraj_m.* TO NULL             #DEFAULT 設定
   LET g_mrajsite_t = NULL
   LET g_mraj001_t = NULL
   LET g_mraj002_t = NULL
   LET g_mraj003_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      LET g_mraj_m.mrajsite = g_site
      #end add-point 
 
      CALL amri100_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_mraj_m.* TO NULL
         INITIALIZE g_mraj_d TO NULL
         INITIALIZE g_mraj2_d TO NULL
 
         CALL amri100_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_mraj_m.* = g_mraj_m_t.*
         CALL amri100_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_mraj_d.clear()
      #CALL g_mraj2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      CALL g_mrak_d.clear()
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL amri100_set_act_visible()
   CALL amri100_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_mrajsite_t = g_mraj_m.mrajsite
   LET g_mraj001_t = g_mraj_m.mraj001
   LET g_mraj002_t = g_mraj_m.mraj002
   LET g_mraj003_t = g_mraj_m.mraj003
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrajent = " ||g_enterprise|| " AND",
                      " mrajsite = '", g_mraj_m.mrajsite, "' "
                      ," AND mraj001 = '", g_mraj_m.mraj001, "' "
                      ," AND mraj002 = '", g_mraj_m.mraj002, "' "
                      ," AND mraj003 = '", g_mraj_m.mraj003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amri100_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL amri100_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE amri100_master_referesh USING g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003 INTO g_mraj_m.mrajsite, 
       g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003,g_mraj_m.mraj001_desc,g_mraj_m.mraj003_desc 
 
   
   #遮罩相關處理
   LET g_mraj_m_mask_o.* =  g_mraj_m.*
   CALL amri100_mraj_t_mask()
   LET g_mraj_m_mask_n.* =  g_mraj_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj001_desc,g_mraj_m.mraj002,g_mraj_m.mraj002_desc, 
       g_mraj_m.mraj003,g_mraj_m.mraj003_desc
   
   #功能已完成,通報訊息中心
   CALL amri100_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="amri100.modify" >}
#+ 資料修改
PRIVATE FUNCTION amri100_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_num     LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_mraj_m.mrajsite IS NULL
   OR g_mraj_m.mraj001 IS NULL
   OR g_mraj_m.mraj002 IS NULL
   OR g_mraj_m.mraj003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_mrajsite_t = g_mraj_m.mrajsite
   LET g_mraj001_t = g_mraj_m.mraj001
   LET g_mraj002_t = g_mraj_m.mraj002
   LET g_mraj003_t = g_mraj_m.mraj003
 
   CALL s_transaction_begin()
   
   OPEN amri100_cl USING g_enterprise,g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amri100_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE amri100_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amri100_master_referesh USING g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003 INTO g_mraj_m.mrajsite, 
       g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003,g_mraj_m.mraj001_desc,g_mraj_m.mraj003_desc 
 
   
   #遮罩相關處理
   LET g_mraj_m_mask_o.* =  g_mraj_m.*
   CALL amri100_mraj_t_mask()
   LET g_mraj_m_mask_n.* =  g_mraj_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL amri100_show()
   WHILE TRUE
      LET g_mrajsite_t = g_mraj_m.mrajsite
      LET g_mraj001_t = g_mraj_m.mraj001
      LET g_mraj002_t = g_mraj_m.mraj002
      LET g_mraj003_t = g_mraj_m.mraj003
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL amri100_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_mraj_m.* = g_mraj_m_t.*
         CALL amri100_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_mraj_m.mrajsite != g_mrajsite_t 
      OR g_mraj_m.mraj001 != g_mraj001_t 
      OR g_mraj_m.mraj002 != g_mraj002_t 
      OR g_mraj_m.mraj003 != g_mraj003_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前 name="modify.b_key_update"
         LET l_num = 0
         SELECT COUNT(mrakseq1) INTO l_num
           FROM mrak_t
          WHERE mrakent = g_enterprise AND mraksite = g_mrajsite_t
            AND mrak001 = g_mraj001_t
            AND mrak002 = g_mraj002_t
            AND mrak003 = g_mraj003_t
               
         IF l_num > 0 THEN
            UPDATE mrak_t SET mraksite = g_mraj_m.mrajsite
                                       , mrak001 = g_mraj_m.mraj001
                                       , mrak002 = g_mraj_m.mraj002
                                       , mrak003 = g_mraj_m.mraj003 
             WHERE mrakent = g_enterprise AND mraksite = g_mrajsite_t
               AND mrak001 = g_mraj001_t
               AND mrak002 = g_mraj002_t
               AND mrak003 = g_mraj003_t
                    
            IF SQLCA.sqlcode THEN #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mrak_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            END IF
         END IF
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
   CALL amri100_set_act_visible()
   CALL amri100_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mrajent = " ||g_enterprise|| " AND",
                      " mrajsite = '", g_mraj_m.mrajsite, "' "
                      ," AND mraj001 = '", g_mraj_m.mraj001, "' "
                      ," AND mraj002 = '", g_mraj_m.mraj002, "' "
                      ," AND mraj003 = '", g_mraj_m.mraj003, "' "
 
   #填到對應位置
   CALL amri100_browser_fill("")
 
   CALL amri100_idx_chk()
 
   CLOSE amri100_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amri100_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="amri100.input" >}
#+ 資料輸入
PRIVATE FUNCTION amri100_input(p_cmd)
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
   DEFINE  l_num                 LIKE type_t.num5
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
   DISPLAY BY NAME g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj001_desc,g_mraj_m.mraj002,g_mraj_m.mraj002_desc, 
       g_mraj_m.mraj003,g_mraj_m.mraj003_desc
   
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
   LET g_forupd_sql = "SELECT mrajseq,mraj004,mraj005,mraj006,mraj007,mraj008,mraj009,mraj012,mraj013, 
       mrajseq,mrajownid,mrajowndp,mrajcrtid,mrajcrtdp,mrajcrtdt,mrajmodid,mrajmoddt,mrajcnfid,mrajcnfdt, 
       mrajstus FROM mraj_t WHERE mrajent=? AND mrajsite=? AND mraj001=? AND mraj002=? AND mraj003=?  
       AND mrajseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   LET g_forupd_sql = "SELECT mrakseq1,mrak004,'','',mrak005,mrak006,'',mrak007,mrak008",
                      "  FROM mraj_t LEFT OUTER JOIN mrak_t",                      
                      "    ON mrajent = mrakent",                      
                      "   AND mrajsite = mraksite",
                      "   AND mraj001 = mrak001",
                      "   AND mraj002 = mrak002",
                      "   AND mraj003 = mrak003",
                      "   AND mrajseq = mrakseq",
                      " WHERE mrakent=? AND mraksite=? AND mrak001=? AND mrak002=? AND mrak003=? AND mrakseq=? AND mrakseq1 = ? FOR UPDATE"
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE amri100_bcl2 CURSOR FROM g_forupd_sql      # LOCK CURSOR

   LET g_forupd_sql = "SELECT mrajseq,mraj004,mraj005,mraj006,mraj007,mraj008,mraj009,mraj012,mraj013, 
                       mrajseq,mrajownid,mrajowndp,mrajcrtid,mrajcrtdp,mrajcrtdt,mrajmodid,mrajmoddt,mrajcnfid,mrajcnfdt, 
                       mrajstus",
                       
                      "  FROM mraj_t LEFT OUTER JOIN mrak_t",                      
                      "    ON mrajent = mrakent",                      
                      "   AND mrajsite = mraksite",
                      "   AND mraj001 = mrak001",
                      "   AND mraj002 = mrak002",
                      "   AND mraj003 = mrak003",
                      "   AND mrajseq = mrakseq",
                      " WHERE mrajent=? AND mrajsite=? AND mraj001=? AND mraj002=? AND mraj003=? AND mrajseq=? FOR UPDATE"
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amri100_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL amri100_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL amri100_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="amri100.input.head" >}
   
      #單頭段
      INPUT BY NAME g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003 
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
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajsite
            #add-point:BEFORE FIELD mrajsite name="input.b.mrajsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrajsite
            
            #add-point:AFTER FIELD mrajsite name="input.a.mrajsite"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mraj_m.mrajsite) AND NOT cl_null(g_mraj_m.mraj001) AND NOT cl_null(g_mraj_m.mraj002) AND NOT cl_null(g_mraj_m.mraj003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mraj_m.mrajsite != g_mrajsite_t  OR g_mraj_m.mraj001 != g_mraj001_t  OR g_mraj_m.mraj002 != g_mraj002_t  OR g_mraj_m.mraj003 != g_mraj003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mraj_t WHERE "||"mrajent = '" ||g_enterprise|| "' AND "||"mrajsite = '"||g_mraj_m.mrajsite ||"' AND "|| "mraj001 = '"||g_mraj_m.mraj001 ||"' AND "|| "mraj002 = '"||g_mraj_m.mraj002 ||"' AND "|| "mraj003 = '"||g_mraj_m.mraj003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrajsite
            #add-point:ON CHANGE mrajsite name="input.g.mrajsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj001
            
            #add-point:AFTER FIELD mraj001 name="input.a.mraj001"
            CALL amri100_mraj001_ref()

            IF NOT cl_null(g_mraj_m.mraj001) THEN
               IF NOT s_azzi650_chk_exist('1101',g_mraj_m.mraj001) THEN
                  LET g_mraj_m.mraj001 = g_mraj001_t
                  CALL amri100_mraj001_ref()
                  NEXT FIELD CURRENT
               END IF               
            END IF

            LET g_mraj_m.mraj002 = ''            
            IF NOT cl_null(g_mraj_m.mraj001) THEN
               #有輸入值,則將"資源編號"預設為ALL
               LET g_mraj_m.mraj002 = 'ALL'
            END IF

            DISPLAY BY NAME g_mraj_m.mraj002
            CALL amri100_mraj002_ref(g_mraj_m.mraj002)
            RETURNING g_mraj_m.mraj002_desc
            DISPLAY BY NAME g_mraj_m.mraj002_desc

            CALL amri100_set_entry(p_cmd)
            CALL amri100_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj001
            #add-point:BEFORE FIELD mraj001 name="input.b.mraj001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mraj001
            #add-point:ON CHANGE mraj001 name="input.g.mraj001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj002
            
            #add-point:AFTER FIELD mraj002 name="input.a.mraj002"
            CALL amri100_mraj002_ref(g_mraj_m.mraj002)
            RETURNING g_mraj_m.mraj002_desc
            DISPLAY BY NAME g_mraj_m.mraj002_desc
            
            IF NOT cl_null(g_mraj_m.mraj002) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mraj_m.mraj002
               #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
               #160318-00025#23  by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_mrba001_5") THEN
                  LET g_mraj_m.mraj002 = g_mraj002_t
                  
                  CALL amri100_mraj002_ref(g_mraj_m.mraj002)
                  RETURNING g_mraj_m.mraj002_desc
                  DISPLAY BY NAME g_mraj_m.mraj002_desc
                  
                  NEXT FIELD CURRENT
               END IF               
            END IF 
            
            #此欄有輸入值,則帶出"資源分類"
            LET g_mraj_m.mraj001 = ''            
            IF NOT cl_null(g_mraj_m.mraj002) THEN
               SELECT mrba010 INTO g_mraj_m.mraj001
                 FROM mrba_t
                WHERE mrbaent = g_enterprise
                  AND mrbasite = g_site
                  AND mrba001 = g_mraj_m.mraj002
            END IF
   
            CALL amri100_mraj001_ref()
            DISPLAY BY NAME g_mraj_m.mraj001
            
            CALL amri100_set_entry(p_cmd)
            CALL amri100_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj002
            #add-point:BEFORE FIELD mraj002 name="input.b.mraj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mraj002
            #add-point:ON CHANGE mraj002 name="input.g.mraj002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj003
            
            #add-point:AFTER FIELD mraj003 name="input.a.mraj003"
            CALL amri100_mraj003_ref()

            IF NOT cl_null(g_mraj_m.mraj003) THEN
               IF NOT s_azzi650_chk_exist('1104',g_mraj_m.mraj003) THEN
                  LET g_mraj_m.mraj003 = g_mraj003_t
                  CALL amri100_mraj003_ref()
                  NEXT FIELD CURRENT
               END IF
            
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj003
            #add-point:BEFORE FIELD mraj003 name="input.b.mraj003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mraj003
            #add-point:ON CHANGE mraj003 name="input.g.mraj003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mrajsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrajsite
            #add-point:ON ACTION controlp INFIELD mrajsite name="input.c.mrajsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.mraj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj001
            #add-point:ON ACTION controlp INFIELD mraj001 name="input.c.mraj001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mraj_m.mraj001             #給予default值
            LET g_qryparam.default2 = "" #g_mraj_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '1101'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_mraj_m.mraj001 = g_qryparam.return1              
            #LET g_mraj_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mraj_m.mraj001 TO mraj001              #
            #DISPLAY g_mraj_m.oocq002 TO oocq002 #應用分類碼
            
            CALL amri100_mraj001_ref()
            NEXT FIELD mraj001                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mraj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj002
            #add-point:ON ACTION controlp INFIELD mraj002 name="input.c.mraj002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mraj_m.mraj002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_mrba001_4()                                #呼叫開窗

            LET g_mraj_m.mraj002 = g_qryparam.return1              

            DISPLAY g_mraj_m.mraj002 TO mraj002              #

            CALL amri100_mraj002_ref(g_mraj_m.mraj002)
            RETURNING g_mraj_m.mraj002_desc
            DISPLAY BY NAME g_mraj_m.mraj002_desc
            
            NEXT FIELD mraj002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mraj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj003
            #add-point:ON ACTION controlp INFIELD mraj003 name="input.c.mraj003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mraj_m.mraj003             #給予default值
            LET g_qryparam.default2 = "" #g_mraj_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '1104'
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_mraj_m.mraj003 = g_qryparam.return1              
            #LET g_mraj_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mraj_m.mraj003 TO mraj003              #
            #DISPLAY g_mraj_m.oocq002 TO oocq002 #應用分類碼
            
            CALL amri100_mraj003_ref()
            NEXT FIELD mraj003                          #返回原欄位
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
            DISPLAY BY NAME g_mraj_m.mrajsite             
                            ,g_mraj_m.mraj001   
                            ,g_mraj_m.mraj002   
                            ,g_mraj_m.mraj003   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               LET l_num = 0
               SELECT COUNT(mrakseq1) INTO l_num
                 FROM mrak_t
                WHERE mrakent = g_enterprise AND mraksite = g_mrajsite_t
                  AND mrak001 = g_mraj001_t
                  AND mrak002 = g_mraj002_t
                  AND mrak003 = g_mraj003_t
               
               IF l_num > 0 THEN
                  UPDATE mrak_t SET (mraksite,mrak001,mrak002,mrak003) = 
                                    (g_mraj_m.mrajsite,g_mraj_m.mraj001, 
                                     g_mraj_m.mraj002,g_mraj_m.mraj003)
                   WHERE mrakent = g_enterprise AND mraksite = g_mrajsite_t
                     AND mrak001 = g_mraj001_t
                     AND mrak002 = g_mraj002_t
                     AND mrak003 = g_mraj003_t
                    
                  IF SQLCA.sqlcode THEN #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "mrak_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               #end add-point
            
               #將遮罩欄位還原
               CALL amri100_mraj_t_mask_restore('restore_mask_o')
            
               UPDATE mraj_t SET (mrajsite,mraj001,mraj002,mraj003) = (g_mraj_m.mrajsite,g_mraj_m.mraj001, 
                   g_mraj_m.mraj002,g_mraj_m.mraj003)
                WHERE mrajent = g_enterprise AND mrajsite = g_mrajsite_t
                  AND mraj001 = g_mraj001_t
                  AND mraj002 = g_mraj002_t
                  AND mraj003 = g_mraj003_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mraj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mraj_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mraj_m.mrajsite
               LET gs_keys_bak[1] = g_mrajsite_t
               LET gs_keys[2] = g_mraj_m.mraj001
               LET gs_keys_bak[2] = g_mraj001_t
               LET gs_keys[3] = g_mraj_m.mraj002
               LET gs_keys_bak[3] = g_mraj002_t
               LET gs_keys[4] = g_mraj_m.mraj003
               LET gs_keys_bak[4] = g_mraj003_t
               LET gs_keys[5] = g_mraj_d[g_detail_idx].mrajseq
               LET gs_keys_bak[5] = g_mraj_d_t.mrajseq
               CALL amri100_update_b('mraj_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_mraj_m_t)
                     #LET g_log2 = util.JSON.stringify(g_mraj_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL amri100_mraj_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               IF NOT l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  LET g_ask_show = 'Y'
               END IF
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL amri100_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_mrajsite_t = g_mraj_m.mrajsite
           LET g_mraj001_t = g_mraj_m.mraj001
           LET g_mraj002_t = g_mraj_m.mraj002
           LET g_mraj003_t = g_mraj_m.mraj003
 
           
           IF g_mraj_d.getLength() = 0 THEN
              NEXT FIELD mrajseq
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="amri100.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_mraj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mraj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amri100_b_fill(g_wc2) #test 
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
            CALL amri100_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN amri100_cl USING g_enterprise,g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE amri100_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN amri100_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_mraj_d[l_ac].mrajseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mraj_d_t.* = g_mraj_d[l_ac].*  #BACKUP
               LET g_mraj_d_o.* = g_mraj_d[l_ac].*  #BACKUP
               CALL amri100_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               CALL amri100_set_no_required_b(l_cmd)
               CALL amri100_set_required_b(l_cmd)
               #end add-point
               CALL amri100_set_no_entry_b(l_cmd)
               OPEN amri100_bcl USING g_enterprise,g_mraj_m.mrajsite,
                                                g_mraj_m.mraj001,
                                                g_mraj_m.mraj002,
                                                g_mraj_m.mraj003,
 
                                                g_mraj_d_t.mrajseq
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN amri100_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amri100_bcl INTO g_mraj_d[l_ac].mrajseq,g_mraj_d[l_ac].mraj004,g_mraj_d[l_ac].mraj005, 
                      g_mraj_d[l_ac].mraj006,g_mraj_d[l_ac].mraj007,g_mraj_d[l_ac].mraj008,g_mraj_d[l_ac].mraj009, 
                      g_mraj_d[l_ac].mraj012,g_mraj_d[l_ac].mraj013,g_mraj2_d[l_ac].mrajseq,g_mraj2_d[l_ac].mrajownid, 
                      g_mraj2_d[l_ac].mrajowndp,g_mraj2_d[l_ac].mrajcrtid,g_mraj2_d[l_ac].mrajcrtdp, 
                      g_mraj2_d[l_ac].mrajcrtdt,g_mraj2_d[l_ac].mrajmodid,g_mraj2_d[l_ac].mrajmoddt, 
                      g_mraj2_d[l_ac].mrajcnfid,g_mraj2_d[l_ac].mrajcnfdt,g_mraj2_d[l_ac].mrajstus
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_mraj_d_t.mrajseq,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mraj_d_mask_o[l_ac].* =  g_mraj_d[l_ac].*
                  CALL amri100_mraj_t_mask()
                  LET g_mraj_d_mask_n[l_ac].* =  g_mraj_d[l_ac].*
                  
                  CALL amri100_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL amri100_b_fill2('0')
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_mraj_d_t.* TO NULL
            INITIALIZE g_mraj_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mraj_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mraj2_d[l_ac].mrajownid = g_user
      LET g_mraj2_d[l_ac].mrajowndp = g_dept
      LET g_mraj2_d[l_ac].mrajcrtid = g_user
      LET g_mraj2_d[l_ac].mrajcrtdp = g_dept 
      LET g_mraj2_d[l_ac].mrajcrtdt = cl_get_current()
      LET g_mraj2_d[l_ac].mrajmodid = g_user
      LET g_mraj2_d[l_ac].mrajmoddt = cl_get_current()
      LET g_mraj2_d[l_ac].mrajstus = ''
 
 
  
            #一般欄位預設值
                  LET g_mraj_d[l_ac].mraj013 = "2"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_mraj_d_t.* = g_mraj_d[l_ac].*     #新輸入資料
            LET g_mraj_d_o.* = g_mraj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amri100_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            CALL amri100_set_no_required_b(l_cmd)
            CALL amri100_set_required_b(l_cmd)
            #end add-point
            CALL amri100_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mraj_d[li_reproduce_target].* = g_mraj_d[li_reproduce].*
               LET g_mraj2_d[li_reproduce_target].* = g_mraj2_d[li_reproduce].*
 
               LET g_mraj_d[g_mraj_d.getLength()].mrajseq = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF cl_null(g_mraj_d[l_ac].mrajseq) THEN
               SELECT MAX(mrajseq)+1 INTO g_mraj_d[l_ac].mrajseq
                 FROM mraj_t
                WHERE mrajent = g_enterprise
                  AND mrajsite = g_site
                  AND mraj001 = g_mraj_m.mraj001
                  AND mraj002 = g_mraj_m.mraj002
                  AND mraj003 = g_mraj_m.mraj003
            
               IF cl_null(g_mraj_d[l_ac].mrajseq) THEN
                  LET g_mraj_d[l_ac].mrajseq = 1
               END IF
            END IF
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
            SELECT COUNT(1) INTO l_count FROM mraj_t 
             WHERE mrajent = g_enterprise AND mrajsite = g_mraj_m.mrajsite
               AND mraj001 = g_mraj_m.mraj001
               AND mraj002 = g_mraj_m.mraj002
               AND mraj003 = g_mraj_m.mraj003
 
               AND mrajseq = g_mraj_d[l_ac].mrajseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO mraj_t
                           (mrajent,
                            mrajsite,mraj001,mraj002,mraj003,
                            mrajseq
                            ,mraj004,mraj005,mraj006,mraj007,mraj008,mraj009,mraj012,mraj013,mrajownid,mrajowndp,mrajcrtid,mrajcrtdp,mrajcrtdt,mrajmodid,mrajmoddt,mrajcnfid,mrajcnfdt,mrajstus) 
                     VALUES(g_enterprise,
                            g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003,
                            g_mraj_d[l_ac].mrajseq
                            ,g_mraj_d[l_ac].mraj004,g_mraj_d[l_ac].mraj005,g_mraj_d[l_ac].mraj006,g_mraj_d[l_ac].mraj007, 
                                g_mraj_d[l_ac].mraj008,g_mraj_d[l_ac].mraj009,g_mraj_d[l_ac].mraj012, 
                                g_mraj_d[l_ac].mraj013,g_mraj2_d[l_ac].mrajownid,g_mraj2_d[l_ac].mrajowndp, 
                                g_mraj2_d[l_ac].mrajcrtid,g_mraj2_d[l_ac].mrajcrtdp,g_mraj2_d[l_ac].mrajcrtdt, 
                                g_mraj2_d[l_ac].mrajmodid,g_mraj2_d[l_ac].mrajmoddt,g_mraj2_d[l_ac].mrajcnfid, 
                                g_mraj2_d[l_ac].mrajcnfdt,g_mraj2_d[l_ac].mrajstus)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_mraj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mraj_t:",SQLERRMESSAGE 
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
               IF amri100_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_mraj_m.mrajsite
                  LET gs_keys[gs_keys.getLength()+1] = g_mraj_m.mraj001
                  LET gs_keys[gs_keys.getLength()+1] = g_mraj_m.mraj002
                  LET gs_keys[gs_keys.getLength()+1] = g_mraj_m.mraj003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mraj_d_t.mrajseq
 
 
                  #刪除下層單身
                  IF NOT amri100_key_delete_b(gs_keys,'mraj_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE amri100_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE amri100_bcl
               LET l_count = g_mraj_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_mraj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrajseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mraj_d[l_ac].mrajseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mrajseq
            END IF 
 
 
 
            #add-point:AFTER FIELD mrajseq name="input.a.page1.mrajseq"

            #此段落由子樣板a05產生
            IF  g_mraj_m.mraj001 IS NOT NULL AND g_mraj_m.mraj002 IS NOT NULL AND g_mraj_m.mraj003 IS NOT NULL AND g_mraj_d[g_detail_idx].mrajseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mraj_m.mraj001 != g_mraj001_t OR g_mraj_m.mraj002 != g_mraj002_t OR g_mraj_m.mraj003 != g_mraj003_t OR g_mraj_d[g_detail_idx].mrajseq != g_mraj_d_t.mrajseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mraj_t WHERE "||"mrajent = '" ||g_enterprise|| "' AND "||"mraj001 = '"||g_mraj_m.mraj001 ||"' AND "|| "mraj002 = '"||g_mraj_m.mraj002 ||"' AND "|| "mraj003 = '"||g_mraj_m.mraj003 ||"' AND "|| "mrajseq = '"||g_mraj_d[g_detail_idx].mrajseq ||"'",'std-00004',0) THEN 
                  
                     LET g_mraj_d[l_ac].mrajseq = g_mraj_d_t.mrajseq
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajseq
            #add-point:BEFORE FIELD mrajseq name="input.b.page1.mrajseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrajseq
            #add-point:ON CHANGE mrajseq name="input.g.page1.mrajseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj004
            
            #add-point:AFTER FIELD mraj004 name="input.a.page1.mraj004"
            CALL amri100_mraj004_ref()

            IF NOT cl_null(g_mraj_d[l_ac].mraj004) THEN
               IF g_mraj_d[l_ac].mraj004 <> g_mraj_d_o.mraj004 OR cl_null(g_mraj_d_o.mraj004) THEN
            
                  IF NOT s_azzi650_chk_exist('1110',g_mraj_d[l_ac].mraj004) THEN
                     LET g_mraj_d[l_ac].mraj004 = g_mraj_d_o.mraj004
                     CALL amri100_mraj004_ref()
                     NEXT FIELD CURRENT
                     
                  END IF
               END IF
            END IF
            
            LET g_mraj_d_o.mraj004 = g_mraj_d[l_ac].mraj004
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj004
            #add-point:BEFORE FIELD mraj004 name="input.b.page1.mraj004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mraj004
            #add-point:ON CHANGE mraj004 name="input.g.page1.mraj004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj005
            
            #add-point:AFTER FIELD mraj005 name="input.a.page1.mraj005"
            CALL amri100_mraj005_ref()

            IF NOT cl_null(g_mraj_d[l_ac].mraj005) THEN
               IF g_mraj_d[l_ac].mraj005 <> g_mraj_d_o.mraj005 OR cl_null(g_mraj_d_o.mraj005) THEN
               
                  IF NOT s_azzi650_chk_exist('1114',g_mraj_d[l_ac].mraj005) THEN
                     LET g_mraj_d[l_ac].mraj005 = g_mraj_d_o.mraj005
                     CALL amri100_mraj005_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
                        
            LET g_mraj_d_o.mraj005 = g_mraj_d[l_ac].mraj005
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj005
            #add-point:BEFORE FIELD mraj005 name="input.b.page1.mraj005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mraj005
            #add-point:ON CHANGE mraj005 name="input.g.page1.mraj005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj006
            #add-point:BEFORE FIELD mraj006 name="input.b.page1.mraj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj006
            
            #add-point:AFTER FIELD mraj006 name="input.a.page1.mraj006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mraj006
            #add-point:ON CHANGE mraj006 name="input.g.page1.mraj006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj007
            
            #add-point:AFTER FIELD mraj007 name="input.a.page1.mraj007"
            IF NOT cl_null(g_mraj_d[l_ac].mraj007) THEN
               IF g_mraj_d[l_ac].mraj007 <> g_mraj_d_o.mraj007 OR cl_null(g_mraj_d_o.mraj007) THEN

                  IF g_mraj_m.mraj002 = 'ALL' THEN
                     IF NOT amri100_mraj007_chk() THEN
                        LET g_mraj_d[l_ac].mraj007 = g_mraj_d_o.mraj007
                        NEXT FIELD CURRENT                       
                     END IF           
                  
                  ELSE
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
               
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_mraj_m.mraj002
                     LET g_chkparam.arg2 = g_mraj_d[l_ac].mraj007
                     #160318-00025#23  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
                     #160318-00025#23  by 07900 --add-end  
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_mrbc002") THEN
                        LET g_mraj_d[l_ac].mraj007 = g_mraj_d_o.mraj007
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF

            LET g_mraj_d_o.mraj007 = g_mraj_d[l_ac].mraj007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj007
            #add-point:BEFORE FIELD mraj007 name="input.b.page1.mraj007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mraj007
            #add-point:ON CHANGE mraj007 name="input.g.page1.mraj007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj008
            #add-point:BEFORE FIELD mraj008 name="input.b.page1.mraj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj008
            
            #add-point:AFTER FIELD mraj008 name="input.a.page1.mraj008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mraj008
            #add-point:ON CHANGE mraj008 name="input.g.page1.mraj008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj009
            #add-point:BEFORE FIELD mraj009 name="input.b.page1.mraj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj009
            
            #add-point:AFTER FIELD mraj009 name="input.a.page1.mraj009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mraj009
            #add-point:ON CHANGE mraj009 name="input.g.page1.mraj009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mraj_d[l_ac].mraj012,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mraj012
            END IF 
 
 
 
            #add-point:AFTER FIELD mraj012 name="input.a.page1.mraj012"
            CALL amri100_set_no_required_b(l_cmd)
            CALL amri100_set_required_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj012
            #add-point:BEFORE FIELD mraj012 name="input.b.page1.mraj012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mraj012
            #add-point:ON CHANGE mraj012 name="input.g.page1.mraj012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mraj013
            #add-point:BEFORE FIELD mraj013 name="input.b.page1.mraj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mraj013
            
            #add-point:AFTER FIELD mraj013 name="input.a.page1.mraj013"
            CALL amri100_set_no_required_b(l_cmd)
            CALL amri100_set_required_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mraj013
            #add-point:ON CHANGE mraj013 name="input.g.page1.mraj013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mrajseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrajseq
            #add-point:ON ACTION controlp INFIELD mrajseq name="input.c.page1.mrajseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mraj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj004
            #add-point:ON ACTION controlp INFIELD mraj004 name="input.c.page1.mraj004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mraj_d[l_ac].mraj004             #給予default值
            LET g_qryparam.default2 = "" #g_mraj_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '1110'
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_mraj_d[l_ac].mraj004 = g_qryparam.return1              
            #LET g_mraj_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_mraj_d[l_ac].mraj004 TO mraj004              #
            #DISPLAY g_mraj_d[l_ac].oocq002 TO oocq002 #應用分類碼
            
            CALL amri100_mraj004_ref()
            NEXT FIELD mraj004                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.mraj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj005
            #add-point:ON ACTION controlp INFIELD mraj005 name="input.c.page1.mraj005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mraj_d[l_ac].mraj005             #給予default值
            LET g_qryparam.default2 = "" #g_mraj_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '1114'
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_mraj_d[l_ac].mraj005 = g_qryparam.return1              
            #LET g_mraj_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_mraj_d[l_ac].mraj005 TO mraj005              #
            #DISPLAY g_mraj_d[l_ac].oocq002 TO oocq002 #應用分類碼
            
            CALL amri100_mraj005_ref()
            NEXT FIELD mraj005                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.mraj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj006
            #add-point:ON ACTION controlp INFIELD mraj006 name="input.c.page1.mraj006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mraj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj007
            #add-point:ON ACTION controlp INFIELD mraj007 name="input.c.page1.mraj007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mraj_d[l_ac].mraj007             #給予default值
            
            IF g_mraj_m.mraj002 = 'ALL' THEN
               LET g_qryparam.where = "mrba010 ='",g_mraj_m.mraj001,"'"
            ELSE
               LET g_qryparam.where = "mrba001 ='",g_mraj_m.mraj002,"'"
            END IF

            CALL q_mrbc002_1()                                #呼叫開窗

            LET g_mraj_d[l_ac].mraj007 = g_qryparam.return1              

            DISPLAY g_mraj_d[l_ac].mraj007 TO mraj007

            NEXT FIELD mraj007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mraj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj008
            #add-point:ON ACTION controlp INFIELD mraj008 name="input.c.page1.mraj008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mraj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj009
            #add-point:ON ACTION controlp INFIELD mraj009 name="input.c.page1.mraj009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mraj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj012
            #add-point:ON ACTION controlp INFIELD mraj012 name="input.c.page1.mraj012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mraj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mraj013
            #add-point:ON ACTION controlp INFIELD mraj013 name="input.c.page1.mraj013"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mraj_d[l_ac].* = g_mraj_d_t.*
               CLOSE amri100_bcl
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
               LET g_errparam.extend = g_mraj_d[l_ac].mrajseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_mraj_d[l_ac].* = g_mraj_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_mraj2_d[l_ac].mrajmodid = g_user 
LET g_mraj2_d[l_ac].mrajmoddt = cl_get_current()
LET g_mraj2_d[l_ac].mrajmodid_desc = cl_get_username(g_mraj2_d[l_ac].mrajmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               LET l_num = 0
               SELECT COUNT(mrakseq1) INTO l_num
                 FROM mrak_t
                WHERE mrakent = g_enterprise AND mraksite = g_mraj_m.mrajsite 
                  AND mrak001 = g_mraj_m.mraj001 
                  AND mrak002 = g_mraj_m.mraj002 
                  AND mrak003 = g_mraj_m.mraj003 
                  AND mrakseq = g_mraj_d_t.mrajseq #項次
               
               IF l_num > 0 THEN
                  UPDATE mrak_t SET (mraksite,mrak001,mrak002,mrak003,mrakseq) = 
                                    (g_mraj_m.mrajsite,g_mraj_m.mraj001, 
                                     g_mraj_m.mraj002,g_mraj_m.mraj003,g_mraj_d[l_ac].mrajseq)
                   WHERE mrakent = g_enterprise AND mraksite = g_mraj_m.mrajsite 
                     AND mrak001 = g_mraj_m.mraj001 
                     AND mrak002 = g_mraj_m.mraj002 
                     AND mrak003 = g_mraj_m.mraj003 
                     AND mrakseq = g_mraj_d_t.mrajseq #項次
                    
                  IF SQLCA.sqlcode THEN #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "mrak_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               #end add-point
         
               #將遮罩欄位還原
               CALL amri100_mraj_t_mask_restore('restore_mask_o')
         
               UPDATE mraj_t SET (mrajsite,mraj001,mraj002,mraj003,mrajseq,mraj004,mraj005,mraj006,mraj007, 
                   mraj008,mraj009,mraj012,mraj013,mrajownid,mrajowndp,mrajcrtid,mrajcrtdp,mrajcrtdt, 
                   mrajmodid,mrajmoddt,mrajcnfid,mrajcnfdt,mrajstus) = (g_mraj_m.mrajsite,g_mraj_m.mraj001, 
                   g_mraj_m.mraj002,g_mraj_m.mraj003,g_mraj_d[l_ac].mrajseq,g_mraj_d[l_ac].mraj004,g_mraj_d[l_ac].mraj005, 
                   g_mraj_d[l_ac].mraj006,g_mraj_d[l_ac].mraj007,g_mraj_d[l_ac].mraj008,g_mraj_d[l_ac].mraj009, 
                   g_mraj_d[l_ac].mraj012,g_mraj_d[l_ac].mraj013,g_mraj2_d[l_ac].mrajownid,g_mraj2_d[l_ac].mrajowndp, 
                   g_mraj2_d[l_ac].mrajcrtid,g_mraj2_d[l_ac].mrajcrtdp,g_mraj2_d[l_ac].mrajcrtdt,g_mraj2_d[l_ac].mrajmodid, 
                   g_mraj2_d[l_ac].mrajmoddt,g_mraj2_d[l_ac].mrajcnfid,g_mraj2_d[l_ac].mrajcnfdt,g_mraj2_d[l_ac].mrajstus) 
 
                WHERE mrajent = g_enterprise AND mrajsite = g_mraj_m.mrajsite 
                 AND mraj001 = g_mraj_m.mraj001 
                 AND mraj002 = g_mraj_m.mraj002 
                 AND mraj003 = g_mraj_m.mraj003 
 
                 AND mrajseq = g_mraj_d_t.mrajseq #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mraj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "mraj_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mraj_m.mrajsite
               LET gs_keys_bak[1] = g_mrajsite_t
               LET gs_keys[2] = g_mraj_m.mraj001
               LET gs_keys_bak[2] = g_mraj001_t
               LET gs_keys[3] = g_mraj_m.mraj002
               LET gs_keys_bak[3] = g_mraj002_t
               LET gs_keys[4] = g_mraj_m.mraj003
               LET gs_keys_bak[4] = g_mraj003_t
               LET gs_keys[5] = g_mraj_d[g_detail_idx].mrajseq
               LET gs_keys_bak[5] = g_mraj_d_t.mrajseq
               CALL amri100_update_b('mraj_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_mraj_m),util.JSON.stringify(g_mraj_d_t)
                     LET g_log2 = util.JSON.stringify(g_mraj_m),util.JSON.stringify(g_mraj_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amri100_mraj_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_mraj_m.mrajsite
               LET ls_keys[ls_keys.getLength()+1] = g_mraj_m.mraj001
               LET ls_keys[ls_keys.getLength()+1] = g_mraj_m.mraj002
               LET ls_keys[ls_keys.getLength()+1] = g_mraj_m.mraj003
 
               LET ls_keys[ls_keys.getLength()+1] = g_mraj_d_t.mrajseq
 
               CALL amri100_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE amri100_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mraj_d[l_ac].* = g_mraj_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE amri100_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_mraj_d.getLength() = 0 THEN
               NEXT FIELD mrajseq
            END IF
            #add-point:input段after input  name="input.body.after_input"
            IF cl_null(g_mraj_d[l_ac].mrajseq) THEN
               CALL g_mraj_d.deleteElement(l_ac)
               NEXT FIELD mrajseq
            END IF
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mraj_d[li_reproduce_target].* = g_mraj_d[li_reproduce].*
               LET g_mraj2_d[li_reproduce_target].* = g_mraj2_d[li_reproduce].*
 
               LET g_mraj_d[li_reproduce_target].mrajseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mraj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mraj_d.getLength()+1
            END IF
            
      END INPUT
 
      INPUT ARRAY g_mraj2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL amri100_b_fill(g_wc2) #test 
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
            CALL amri100_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL amri100_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body2.before_row.set_entry_b"
               CALL amri100_set_no_required_b(l_cmd)
               CALL amri100_set_required_b(l_cmd)
               #end add-point
               CALL amri100_set_no_entry_b(l_cmd)
               LET g_mraj2_d_t.* = g_mraj2_d[l_ac].*   #BACKUP  #page1
               LET g_mraj2_d_o.* = g_mraj2_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD mrajseq
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_mraj2_d_t.* TO NULL
            INITIALIZE g_mraj2_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mraj2_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mraj2_d[l_ac].mrajownid = g_user
      LET g_mraj2_d[l_ac].mrajowndp = g_dept
      LET g_mraj2_d[l_ac].mrajcrtid = g_user
      LET g_mraj2_d[l_ac].mrajcrtdp = g_dept 
      LET g_mraj2_d[l_ac].mrajcrtdt = cl_get_current()
      LET g_mraj2_d[l_ac].mrajmodid = g_user
      LET g_mraj2_d[l_ac].mrajmoddt = cl_get_current()
      LET g_mraj2_d[l_ac].mrajstus = ''
 
 
  
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body2.before_insert.before_bak"
            
            #end add-point
            LET g_mraj2_d_t.* = g_mraj2_d[l_ac].*     #新輸入資料
            LET g_mraj2_d_o.* = g_mraj2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amri100_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body2.before_insert.set_entry_b"
            CALL amri100_set_no_required_b(l_cmd)
            CALL amri100_set_required_b(l_cmd)
            #end add-point
            CALL amri100_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mraj_d[li_reproduce_target].* = g_mraj_d[li_reproduce].*
               LET g_mraj2_d[li_reproduce_target].* = g_mraj2_d[li_reproduce].*
 
               LET g_mraj2_d[li_reproduce_target].mrajseq = NULL
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
               IF amri100_before_delete() THEN 
                  
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_mraj_m.mrajsite
                  LET gs_keys[gs_keys.getLength()+1] = g_mraj_m.mraj001
                  LET gs_keys[gs_keys.getLength()+1] = g_mraj_m.mraj002
                  LET gs_keys[gs_keys.getLength()+1] = g_mraj_m.mraj003
                  LET gs_keys[gs_keys.getLength()+1] = g_mraj_d_t.mrajseq
 
                  #刪除下層單身
                  IF NOT amri100_key_delete_b(gs_keys,'mraj_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE amri100_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE amri100_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_mraj2_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body2.after_delete"
               
               #end add-point
                              CALL amri100_delete_b('mraj_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_mraj2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mraj2_d[l_ac].* = g_mraj2_d_t.*
               CLOSE amri100_bcl
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
               LET g_errparam.extend = g_mraj_d[l_ac].mrajseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_mraj2_d[l_ac].* = g_mraj2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_mraj2_d[l_ac].mrajmodid = g_user 
LET g_mraj2_d[l_ac].mrajmoddt = cl_get_current()
LET g_mraj2_d[l_ac].mrajmodid_desc = cl_get_username(g_mraj2_d[l_ac].mrajmodid)
                
               #add-point:單身修改前 name="modify.body2.b_update"
               LET l_num = 0
               SELECT COUNT(mrakseq1) INTO l_num
                 FROM mrak_t
                WHERE mrakent = g_enterprise AND mraksite = g_mraj_m.mrajsite
                  AND mrak001 = g_mraj_m.mraj001
                  AND mrak002 = g_mraj_m.mraj002
                  AND mrak003 = g_mraj_m.mraj003
                  AND mrakseq = g_mraj2_d_t.mrajseq #項次
               
               IF l_num > 0 THEN
                  UPDATE mrak_t SET (mraksite,mrak001,mrak002,mrak003,mrakseq) = 
                                    (g_mraj_m.mrajsite,g_mraj_m.mraj001, 
                                     g_mraj_m.mraj002,g_mraj_m.mraj003,
                                     g_mraj_d[l_ac].mrajseq)  
                   WHERE mrakent = g_enterprise AND mraksite = g_mraj_m.mrajsite
                    AND mrak001 = g_mraj_m.mraj001
                    AND mrak002 = g_mraj_m.mraj002
                    AND mrak003 = g_mraj_m.mraj003
                    AND mrakseq = g_mraj2_d_t.mrajseq #項次
                    
                  IF SQLCA.sqlcode THEN #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "mrak_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               #end add-point
               
               #將遮罩欄位還原
               CALL amri100_mraj_t_mask_restore('restore_mask_o')
                     
               UPDATE mraj_t SET (mrajsite,mraj001,mraj002,mraj003,mrajseq,mraj004,mraj005,mraj006,mraj007, 
                   mraj008,mraj009,mraj012,mraj013,mrajownid,mrajowndp,mrajcrtid,mrajcrtdp,mrajcrtdt, 
                   mrajmodid,mrajmoddt,mrajcnfid,mrajcnfdt,mrajstus) = (g_mraj_m.mrajsite,g_mraj_m.mraj001, 
                   g_mraj_m.mraj002,g_mraj_m.mraj003,g_mraj_d[l_ac].mrajseq,g_mraj_d[l_ac].mraj004,g_mraj_d[l_ac].mraj005, 
                   g_mraj_d[l_ac].mraj006,g_mraj_d[l_ac].mraj007,g_mraj_d[l_ac].mraj008,g_mraj_d[l_ac].mraj009, 
                   g_mraj_d[l_ac].mraj012,g_mraj_d[l_ac].mraj013,g_mraj2_d[l_ac].mrajownid,g_mraj2_d[l_ac].mrajowndp, 
                   g_mraj2_d[l_ac].mrajcrtid,g_mraj2_d[l_ac].mrajcrtdp,g_mraj2_d[l_ac].mrajcrtdt,g_mraj2_d[l_ac].mrajmodid, 
                   g_mraj2_d[l_ac].mrajmoddt,g_mraj2_d[l_ac].mrajcnfid,g_mraj2_d[l_ac].mrajcnfdt,g_mraj2_d[l_ac].mrajstus)  
                   #自訂欄位頁簽
                WHERE mrajent = g_enterprise AND mrajsite = g_mraj_m.mrajsite
                 AND mraj001 = g_mraj_m.mraj001
                 AND mraj002 = g_mraj_m.mraj002
                 AND mraj003 = g_mraj_m.mraj003
                 AND mrajseq = g_mraj2_d_t.mrajseq #項次 
               #add-point:單身修改中 name="modify.body2.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mraj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mraj_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mraj_m.mrajsite
               LET gs_keys_bak[1] = g_mrajsite_t
               LET gs_keys[2] = g_mraj_m.mraj001
               LET gs_keys_bak[2] = g_mraj001_t
               LET gs_keys[3] = g_mraj_m.mraj002
               LET gs_keys_bak[3] = g_mraj002_t
               LET gs_keys[4] = g_mraj_m.mraj003
               LET gs_keys_bak[4] = g_mraj003_t
               LET gs_keys[5] = g_mraj2_d[g_detail_idx].mrajseq
               LET gs_keys_bak[5] = g_mraj2_d_t.mrajseq
               CALL amri100_update_b('mraj_t',gs_keys,gs_keys_bak,"'2'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_mraj_m),util.JSON.stringify(g_mraj2_d_t)
                     LET g_log2 = util.JSON.stringify(g_mraj_m),util.JSON.stringify(g_mraj2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amri100_mraj_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body2.a_update"
 
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrajstus
            #add-point:BEFORE FIELD mrajstus name="input.b.page2.mrajstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrajstus
            
            #add-point:AFTER FIELD mrajstus name="input.a.page2.mrajstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrajstus
            #add-point:ON CHANGE mrajstus name="input.g.page2.mrajstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.mrajstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrajstus
            #add-point:ON ACTION controlp INFIELD mrajstus name="input.c.page2.mrajstus"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body2.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mraj2_d[l_ac].* = g_mraj2_d_t.*
               END IF
               CLOSE amri100_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE amri100_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mraj_d[li_reproduce_target].* = g_mraj_d[li_reproduce].*
               LET g_mraj2_d[li_reproduce_target].* = g_mraj2_d[li_reproduce].*
 
               LET g_mraj2_d[li_reproduce_target].mrajseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mraj2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mraj2_d.getLength()+1
            END IF
      END INPUT
 
      
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      INPUT ARRAY g_mrak_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
       
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
               CALL FGL_SET_ARR_CURR(g_mrak_d.getLength() + 1) 
               LET g_insert = 'N' 
            END IF
 
            CALL amri100_b_fill2('0')
            IF g_rec_b2 != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
            LET l_ac2 = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
                     
            CALL s_transaction_begin()            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN amri100_cl USING g_enterprise,
                                     g_mraj_m.mrajsite
                                     ,g_mraj_m.mraj001
                                     ,g_mraj_m.mraj002
                                     ,g_mraj_m.mraj003
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN amri100_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE amri100_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b2 >= l_ac2 AND g_mrak_d[l_ac2].mrakseq1 IS NOT NULL THEN
               LET l_cmd = 'u'
               LET g_mrak_d_o.* = g_mrak_d[l_ac2].*  #BACKUP
               LET g_mrak_d_t.* = g_mrak_d[l_ac2].*  #BACKUP
               
               CALL amri100_set_entry_b(l_cmd)
               CALL amri100_set_no_required_b(l_cmd)
               CALL amri100_set_required_b(l_cmd)
               CALL amri100_set_no_entry_b(l_cmd)
               
               OPEN amri100_bcl2 USING g_enterprise,g_mraj_m.mrajsite,
                                       g_mraj_m.mraj001,
                                       g_mraj_m.mraj002,
                                       g_mraj_m.mraj003,
                                       g_mraj_d[l_ac].mrajseq,
                                       g_mrak_d_t.mrakseq1
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN amri100_bcl2:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
               #mrakseq1,mrak004,'','',mrak005,mrak006,'',mrak007,mrak008
                  FETCH amri100_bcl2 INTO g_mrak_d[l_ac2].mrakseq1,g_mrak_d[l_ac2].mrak004,g_mrak_d[l_ac2].mrak004_desc, 
                                          g_mrak_d[l_ac2].mrak004_desc1,g_mrak_d[l_ac2].mrak005,g_mrak_d[l_ac2].mrak006,
                                          g_mrak_d[l_ac2].mrak006_desc,g_mrak_d[l_ac2].mrak007, 
                                          g_mrak_d[l_ac2].mrak008
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_mrak_d_t.mrakseq1
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL amri100_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd = 'a'
            END IF

         BEFORE INSERT
            INITIALIZE g_mrak_d_o.* TO NULL
            INITIALIZE g_mrak_d_t.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mrak_d[l_ac2].* TO NULL
            
            #預設資料
            LET g_mrak_d[l_ac2].mrak007 = "1"

            LET g_mrak_d_o.* = g_mrak_d[l_ac2].*     #BACKUP
            LET g_mrak_d_t.* = g_mrak_d[l_ac2].*     #新輸入資料
            CALL cl_show_fld_cont()
            
            CALL amri100_set_entry_b(l_cmd)
            CALL amri100_set_no_required_b(l_cmd)
            CALL amri100_set_required_b(l_cmd)
            CALL amri100_set_no_entry_b(l_cmd)
            
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrak_d[li_reproduce_target].* = g_mrak_d[li_reproduce].*
 
               LET g_mrak_d[g_mrak_d.getLength()].mrakseq1 = NULL
 
            END IF
            
            #add-point:modify段before insert
            IF cl_null(g_mrak_d[l_ac2].mrakseq1) THEN
               SELECT MAX(mrakseq1)+1 INTO g_mrak_d[l_ac2].mrakseq1
                 FROM mrak_t
                WHERE mrakent = g_enterprise
                  AND mraksite = g_site
                  AND mrak001 = g_mraj_m.mraj001
                  AND mrak002 = g_mraj_m.mraj002
                  AND mrak003 = g_mraj_m.mraj003
                  AND mrakseq = g_mraj_d[l_ac].mrajseq
            
               IF cl_null(g_mrak_d[l_ac2].mrakseq1) THEN
                  LET g_mrak_d[l_ac2].mrakseq1 = 1
               END IF
            END IF
            #end add-point  
 
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM mrak_t 
             WHERE mrakent = g_enterprise AND mraksite = g_mraj_m.mrajsite
               AND mrak001 = g_mraj_m.mraj001
               AND mrak002 = g_mraj_m.mraj002
               AND mrak003 = g_mraj_m.mraj003 
               AND mrakseq = g_mraj_d[l_ac].mrajseq
               AND mrakseq1 = g_mrak_d[l_ac2].mrakseq1
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前

               #end add-point
               INSERT INTO mrak_t
                           (mrakent,mraksite,mrak001,
                            mrak002,mrak003,mrakseq,
                            mrakseq1,mrak004,mrak005,
                            mrak006,mrak007,mrak008)
                     VALUES(g_enterprise,g_mraj_m.mrajsite,g_mraj_m.mraj001,
                            g_mraj_m.mraj002,g_mraj_m.mraj003,g_mraj_d[l_ac].mrajseq,
                            g_mrak_d[l_ac2].mrakseq1,g_mrak_d[l_ac2].mrak004,g_mrak_d[l_ac2].mrak005,
                            g_mrak_d[l_ac2].mrak006,g_mrak_d[l_ac2].mrak007,g_mrak_d[l_ac2].mrak008)
                            
               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_mrak_d[l_ac2].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mrak_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR "INSERT O.K"
            END IF            
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_mrak_d.getLength() < l_ac2 THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_mraj_d.deleteElement(l_ac2)
               NEXT FIELD mrakseq1
            END IF
            IF g_mrak_d_t.mrakseq1 IS NOT NULL THEN
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               IF amri100_before_delete2() THEN 
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE amri100_bcl2
               LET l_count = g_mraj_d.getLength()
            END IF 
              
         AFTER DELETE 
 
         AFTER FIELD mrakseq1
            IF g_mraj_m.mraj001 IS NOT NULL AND g_mraj_m.mraj002 IS NOT NULL AND g_mraj_m.mraj003 IS NOT NULL AND g_mraj_d[l_ac].mrajseq IS NOT NULL AND g_mrak_d[l_ac2].mrakseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mraj_m.mraj001 != g_mraj001_t OR g_mraj_m.mraj002 != g_mraj002_t OR g_mraj_m.mraj003 != g_mraj003_t OR g_mraj_d[l_ac].mrajseq != g_mraj_d_t.mrajseq OR g_mrak_d[l_ac].mrakseq1 != g_mrak_d_t.mrakseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrak_t WHERE "||"mrakent = '" ||g_enterprise|| "' AND "||"mraksite = '"||g_site || "' AND "||"mrak001 = '"||g_mraj_m.mraj001 ||"' AND "|| "mrak002 = '"||g_mraj_m.mraj002 ||"' AND "|| "mrak003 = '"||g_mraj_m.mraj003 ||"' AND "|| "mrakseq = '"||g_mraj_d[l_ac].mrajseq ||"' AND "|| "mrakseq1 = '"||g_mrak_d[l_ac2].mrakseq1 ||"'",'std-00004',0) THEN 
                  
                     LET g_mrak_d[l_ac2].mrakseq1 = g_mrak_d_t.mrakseq1
                  
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
 
         AFTER FIELD mrak004
            CALL s_desc_get_item_desc(g_mrak_d[l_ac2].mrak004)
            RETURNING g_mrak_d[l_ac2].mrak004_desc,g_mrak_d[l_ac2].mrak004_desc1
            
            IF NOT cl_null(g_mrak_d[l_ac2].mrak004) THEN
               IF g_mrak_d[l_ac2].mrak004 <> g_mrak_d_o.mrak004 OR cl_null(g_mrak_d_o.mrak004) THEN
               
                  IF g_mrak_d[l_ac2].mrak004 <> g_mrak_d_t.mrak004 OR cl_null(g_mrak_d_t.mrak004) THEN
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrak_t WHERE "||"mrakent = '" ||g_enterprise|| "' AND "||"mrak001 = '"||g_mraj_m.mraj001 ||"' AND "|| "mrak002 = '"||g_mraj_m.mraj002 ||"' AND "|| "mrak003 = '"||g_mraj_m.mraj003 ||"' AND "|| "mrakseq = '"||g_mraj_d[l_ac].mrajseq ||"' AND "||"mrak004 = '"||g_mrak_d[l_ac2].mrak004||"'",'amr-00082',0) THEN
                  
                        LET g_mrak_d[l_ac2].mrak004 = g_mrak_d_o.mrak004
                        
                        CALL s_desc_get_item_desc(g_mrak_d[l_ac2].mrak004)
                        RETURNING g_mrak_d[l_ac2].mrak004_desc,g_mrak_d[l_ac2].mrak004_desc1
            
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrak_d[l_ac2].mrak004

                  #呼叫檢查存在並帶值的library
#160716-00003#1-s
#                 IF NOT cl_chk_exist("v_imaa001") THEN
                  IF NOT cl_chk_exist("v_imaf001_14") THEN
#160716-00003#1-e
                     LET g_mrak_d[l_ac2].mrak004 = g_mrak_d_o.mrak004
                     
                     CALL s_desc_get_item_desc(g_mrak_d[l_ac2].mrak004)
                     RETURNING g_mrak_d[l_ac2].mrak004_desc,g_mrak_d[l_ac2].mrak004_desc1
                     
                     NEXT FIELD CURRENT
                  END IF 
              
                  #預設料件imaa006基礎單位
                  LET g_mrak_d_o.mrak006 = ''
                  SELECT imaa006 INTO g_mrak_d[l_ac2].mrak006
                    FROM imaa_t
                   WHERE imaaent = g_enterprise
                     AND imaa001 = g_mrak_d[l_ac2].mrak004
                  
                  CALL s_desc_get_unit_desc(g_mrak_d[l_ac2].mrak006) RETURNING g_mrak_d[l_ac2].mrak006_desc              
                  
               END IF
            END IF
            
            LET g_mrak_d_o.mrak004 = g_mrak_d[l_ac2].mrak004
            
            IF NOT amri100_mrak004_mrak006_chk() THEN                  
               NEXT FIELD mrak006
            END IF            
 
         AFTER FIELD mrak005
            IF NOT cl_null(g_mrak_d[l_ac2].mrak005) THEN
               IF g_mrak_d[l_ac2].mrak005 <> g_mrak_d_o.mrak005 OR cl_null(g_mrak_d_o.mrak005) THEN
               
                  IF NOT cl_ap_chk_Range(g_mrak_d[l_ac2].mrak005,"0","0","","","azz-00079",1) THEN
                     LET g_mrak_d[l_ac2].mrak005 = g_mrak_d_o.mrak005
                     
                     NEXT FIELD mrak005
                  END IF
                  
               END IF
            END IF
            
            LET g_mrak_d_o.mrak005 = g_mrak_d[l_ac2].mrak005
 
         AFTER FIELD mrak006
            CALL s_desc_get_unit_desc(g_mrak_d[l_ac2].mrak006) RETURNING g_mrak_d[l_ac2].mrak006_desc
            
            IF NOT cl_null(g_mrak_d[l_ac2].mrak006) THEN
               IF g_mrak_d[l_ac2].mrak006 <> g_mrak_d_o.mrak006 OR cl_null(g_mrak_d_o.mrak006) THEN
               
                  IF NOT amri100_mrak004_mrak006_chk() THEN
                     LET g_mrak_d[l_ac2].mrak006 = g_mrak_d_o.mrak006
                     
                     CALL s_desc_get_unit_desc(g_mrak_d[l_ac2].mrak006) RETURNING g_mrak_d[l_ac2].mrak006_desc
                     
                     NEXT FIELD CURRENT
                     
                  END IF
               END IF
            END IF
            
            LET g_mrak_d_o.mrak006 = g_mrak_d[l_ac2].mrak006
 
         ON ACTION controlp INFIELD mrak004
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrak_d[l_ac2].mrak004             #給予default值            
#160716-00003#1-s
#           CALL q_imaa001()                       #呼叫開窗
            CALL q_imaf001_15()                    #呼叫開窗
#160716-00003#1-e
            LET g_mrak_d[l_ac2].mrak004 = g_qryparam.return1              
            DISPLAY g_mrak_d[l_ac2].mrak004 TO mrak004
            CALL s_desc_get_item_desc(g_mrak_d[l_ac2].mrak004)
            RETURNING g_mrak_d[l_ac2].mrak004_desc,g_mrak_d[l_ac2].mrak004_desc1
            DISPLAY BY NAME g_mrak_d[l_ac2].mrak004_desc
            DISPLAY BY NAME g_mrak_d[l_ac2].mrak004_desc1
            NEXT FIELD mrak004                          #返回原欄位
            
         ON ACTION controlp INFIELD mrak006
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrak_d[l_ac2].mrak006             #給予default值
            
            LET g_qryparam.arg1 = g_mrak_d[l_ac2].mrak004
            
            CALL q_imao002()                                #呼叫開窗

            LET g_mrak_d[l_ac2].mrak006 = g_qryparam.return1              

            DISPLAY g_mrak_d[l_ac2].mrak006 TO mrak006

            CALL s_desc_get_unit_desc(g_mrak_d[l_ac2].mrak006)
            RETURNING g_mrak_d[l_ac2].mrak006_desc
            DISPLAY BY NAME g_mrak_d[l_ac2].mrak006_desc

            NEXT FIELD mrak006                          #返回原欄位

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_mrak_d[l_ac2].* = g_mrak_d_t.*
               CLOSE amri100_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_mrak_d[l_ac2].mrakseq1
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_mrak_d[l_ac2].* = g_mrak_d_t.*
            ELSE
            
               UPDATE mrak_t SET (mraksite,mrak001,mrak002,mrak003,
                                  mrakseq,mrakseq1,mrak004,mrak005,
                                  mrak006,mrak007, mrak008) = 
                                 (g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003,
                                  g_mraj_d[l_ac].mrajseq,g_mrak_d[l_ac2].mrakseq1,g_mrak_d[l_ac2].mrak004,g_mrak_d[l_ac2].mrak005, 
                                  g_mrak_d[l_ac2].mrak006,g_mrak_d[l_ac2].mrak007,g_mrak_d[l_ac2].mrak008)
                WHERE mrakent = g_enterprise AND mraksite = g_mraj_m.mrajsite 
                 AND mrak001 = g_mraj_m.mraj001 
                 AND mrak002 = g_mraj_m.mraj002 
                 AND mrak003 = g_mraj_m.mraj003 
                 AND mrakseq = g_mraj_d[l_ac].mrajseq
                 AND mrakseq1 = g_mrak_d_t.mrakseq1 #項次   
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "mrak_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = "mrak_t"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
  
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mraj_m.mrajsite
               LET gs_keys_bak[1] = g_mrajsite_t
               LET gs_keys[2] = g_mraj_m.mraj001
               LET gs_keys_bak[2] = g_mraj001_t
               LET gs_keys[3] = g_mraj_m.mraj002
               LET gs_keys_bak[3] = g_mraj002_t
               LET gs_keys[4] = g_mraj_m.mraj003
               LET gs_keys_bak[4] = g_mraj003_t
               LET gs_keys[5] = g_mraj_d[g_detail_idx].mrajseq
               LET gs_keys_bak[5] = g_mraj_d_t.mrajseq
               CALL amri100_update_b('mrak_t',gs_keys,gs_keys_bak,"'1'")
                     
               END CASE

            END IF
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF cl_null(g_mrak_d[l_ac2].mrakseq1) THEN
               CALL g_mrak_d.deleteElement(l_ac2)
            END IF
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_mrak_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac2
            LET li_reproduce_target = g_mrak_d.getLength()+1
            
      END INPUT
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
            NEXT FIELD mrajsite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mrajseq
               WHEN "s_detail2"
                  NEXT FIELD mrajseq_2
 
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
 
{<section id="amri100.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION amri100_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL amri100_b_fill(g_wc2) #第一階單身填充
      CALL amri100_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL amri100_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj001_desc,g_mraj_m.mraj002,g_mraj_m.mraj002_desc, 
       g_mraj_m.mraj003,g_mraj_m.mraj003_desc
 
   CALL amri100_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="amri100.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION amri100_ref_show()
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
   #排除元件
   CALL amri100_b_fill2('0')
            
   CALL amri100_mraj002_ref(g_mraj_m.mraj002)
   RETURNING g_mraj_m.mraj002_desc
   DISPLAY BY NAME g_mraj_m.mraj002_desc

   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mraj_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_mraj2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
 
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="amri100.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION amri100_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE mraj_t.mrajsite 
   DEFINE l_oldno     LIKE mraj_t.mrajsite 
   DEFINE l_newno02     LIKE mraj_t.mraj001 
   DEFINE l_oldno02     LIKE mraj_t.mraj001 
   DEFINE l_newno03     LIKE mraj_t.mraj002 
   DEFINE l_oldno03     LIKE mraj_t.mraj002 
   DEFINE l_newno04     LIKE mraj_t.mraj003 
   DEFINE l_oldno04     LIKE mraj_t.mraj003 
 
   DEFINE l_master    RECORD LIKE mraj_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mraj_t.* #此變數樣板目前無使用
 
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
 
   IF g_mraj_m.mrajsite IS NULL
      OR g_mraj_m.mraj001 IS NULL
      OR g_mraj_m.mraj002 IS NULL
      OR g_mraj_m.mraj003 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_mrajsite_t = g_mraj_m.mrajsite
   LET g_mraj001_t = g_mraj_m.mraj001
   LET g_mraj002_t = g_mraj_m.mraj002
   LET g_mraj003_t = g_mraj_m.mraj003
 
   
   LET g_mraj_m.mrajsite = ""
   LET g_mraj_m.mraj001 = ""
   LET g_mraj_m.mraj002 = ""
   LET g_mraj_m.mraj003 = ""
 
   LET g_master_insert = FALSE
   CALL amri100_set_entry('a')
   CALL amri100_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_mraj_m.mrajsite = g_site
   
   LET g_mraj_m.mraj001_desc = ''
   DISPLAY BY NAME g_mraj_m.mraj001_desc
   LET g_mraj_m.mraj002_desc = ''
   DISPLAY BY NAME g_mraj_m.mraj002_desc
   LET g_mraj_m.mraj003_desc = ''
   DISPLAY BY NAME g_mraj_m.mraj003_desc
   #end add-point
   
   #清空key欄位的desc
      LET g_mraj_m.mraj001_desc = ''
   DISPLAY BY NAME g_mraj_m.mraj001_desc
   LET g_mraj_m.mraj002_desc = ''
   DISPLAY BY NAME g_mraj_m.mraj002_desc
   LET g_mraj_m.mraj003_desc = ''
   DISPLAY BY NAME g_mraj_m.mraj003_desc
 
   
   CALL amri100_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_mraj_m.* TO NULL
      INITIALIZE g_mraj_d TO NULL
      INITIALIZE g_mraj2_d TO NULL
 
      CALL amri100_show()
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
   CALL amri100_set_act_visible()
   CALL amri100_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_mrajsite_t = g_mraj_m.mrajsite
   LET g_mraj001_t = g_mraj_m.mraj001
   LET g_mraj002_t = g_mraj_m.mraj002
   LET g_mraj003_t = g_mraj_m.mraj003
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrajent = " ||g_enterprise|| " AND",
                      " mrajsite = '", g_mraj_m.mrajsite, "' "
                      ," AND mraj001 = '", g_mraj_m.mraj001, "' "
                      ," AND mraj002 = '", g_mraj_m.mraj002, "' "
                      ," AND mraj003 = '", g_mraj_m.mraj003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amri100_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL amri100_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL amri100_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="amri100.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION amri100_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mraj_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE amri100_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   DROP TABLE amri100_detail2
   
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE amri100_detail2 AS ",
                "SELECT * FROM mrak_t "
   PREPARE repro_tbl2 FROM ls_sql
   EXECUTE repro_tbl2
   FREE repro_tbl2
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mraj_t
    WHERE mrajent = g_enterprise AND mrajsite = g_mrajsite_t
    AND mraj001 = g_mraj001_t
    AND mraj002 = g_mraj002_t
    AND mraj003 = g_mraj003_t
 
       INTO TEMP amri100_detail
   
   #將key修正為調整後   
   UPDATE amri100_detail 
      #更新key欄位
      SET mrajsite = g_mraj_m.mrajsite
          , mraj001 = g_mraj_m.mraj001
          , mraj002 = g_mraj_m.mraj002
          , mraj003 = g_mraj_m.mraj003
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , mrajownid = g_user 
       , mrajowndp = g_dept
       , mrajcrtid = g_user
       , mrajcrtdp = g_dept 
       , mrajcrtdt = ld_date
       , mrajmodid = g_user
       , mrajmoddt = ld_date
      #, mrajstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO mraj_t SELECT * FROM amri100_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO amri100_detail2 SELECT * FROM mrak_t 
                                       WHERE mrakent = g_enterprise AND mraksite = g_mrajsite_t
                                         AND mrak001 = g_mraj001_t
                                         AND mrak002 = g_mraj002_t
                                         AND mrak003 = g_mraj003_t
 
   
   #將key修正為調整後   
   UPDATE amri100_detail2
      #更新key欄位
      SET mraksite = g_mraj_m.mrajsite
          , mrak001 = g_mraj_m.mraj001
          , mrak002 = g_mraj_m.mraj002
          , mrak003 = g_mraj_m.mraj003 
 
   #將資料塞回原table   
   INSERT INTO mrak_t SELECT * FROM amri100_detail2
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE amri100_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   DROP TABLE amri100_detail2
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mrajsite_t = g_mraj_m.mrajsite
   LET g_mraj001_t = g_mraj_m.mraj001
   LET g_mraj002_t = g_mraj_m.mraj002
   LET g_mraj003_t = g_mraj_m.mraj003
 
   
   DROP TABLE amri100_detail
   
END FUNCTION
 
{</section>}
 
{<section id="amri100.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amri100_delete()
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
   
   IF g_mraj_m.mrajsite IS NULL
   OR g_mraj_m.mraj001 IS NULL
   OR g_mraj_m.mraj002 IS NULL
   OR g_mraj_m.mraj003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN amri100_cl USING g_enterprise,g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amri100_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE amri100_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amri100_master_referesh USING g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003 INTO g_mraj_m.mrajsite, 
       g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003,g_mraj_m.mraj001_desc,g_mraj_m.mraj003_desc 
 
   
   #遮罩相關處理
   LET g_mraj_m_mask_o.* =  g_mraj_m.*
   CALL amri100_mraj_t_mask()
   LET g_mraj_m_mask_n.* =  g_mraj_m.*
   
   CALL amri100_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amri100_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      DELETE FROM mrak_t WHERE mrakent = g_enterprise AND mraksite = g_mraj_m.mrajsite
                                                               AND mrak001 = g_mraj_m.mraj001
                                                               AND mrak002 = g_mraj_m.mraj002
                                                               AND mrak003 = g_mraj_m.mraj003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mrak_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF                                                               
      #end add-point
      
      DELETE FROM mraj_t WHERE mrajent = g_enterprise AND mrajsite = g_mraj_m.mrajsite
                                                               AND mraj001 = g_mraj_m.mraj001
                                                               AND mraj002 = g_mraj_m.mraj002
                                                               AND mraj003 = g_mraj_m.mraj003
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mraj_t:",SQLERRMESSAGE 
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
      #   CLOSE amri100_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_mraj_d.clear() 
      CALL g_mraj2_d.clear()       
 
     
      CALL amri100_ui_browser_refresh()  
      #CALL amri100_ui_headershow()  
      #CALL amri100_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL amri100_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL amri100_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE amri100_cl
 
   #功能已完成,通報訊息中心
   CALL amri100_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="amri100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amri100_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE r_success  LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_mraj_d.clear()
   CALL g_mraj2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
 
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT mrajseq,mraj004,mraj005,mraj006,mraj007,mraj008,mraj009,mraj012,mraj013, 
       mrajseq,mrajownid,mrajowndp,mrajcrtid,mrajcrtdp,mrajcrtdt,mrajmodid,mrajmoddt,mrajcnfid,mrajcnfdt, 
       mrajstus,t1.oocql004 ,t2.oocql004 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 , 
       t8.ooag011 FROM mraj_t",   
               "",
               
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='1110' AND t1.oocql002=mraj004 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='1114' AND t2.oocql002=mraj005 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=mrajownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=mrajowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=mrajcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=mrajcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=mrajmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=mrajcnfid  ",
 
               " WHERE mrajent= ? AND mrajsite=? AND mraj001=? AND mraj002=? AND mraj003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("mraj_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
  
   LET g_sql = "SELECT  UNIQUE mrajseq,mraj004,mraj005,mraj006,mraj007,mraj008,mraj009,mraj012,mraj013, 
                               mrajseq,mrajownid,mrajowndp,mrajcrtid,mrajcrtdp,mrajcrtdt,mrajmodid,mrajmoddt,mrajcnfid,mrajcnfdt, 
                               mrajstus,t1.oocql004 ,t2.oocql004 ,t3.oofa011 ,t4.ooefl003 ,t5.oofa011 ,t6.ooefl003 ,t7.oofa011 , 
                               t8.oofa011 FROM mraj_t",
               " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='1110' AND t1.oocql002=mraj004 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent='"||g_enterprise||"' AND t2.oocql001='1114' AND t2.oocql002=mraj005 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t3 ON t3.oofaent='"||g_enterprise||"' AND t3.oofa002='2' AND t3.oofa003=mrajownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=mrajowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t5 ON t5.oofaent='"||g_enterprise||"' AND t5.oofa002='2' AND t5.oofa003=mrajcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent='"||g_enterprise||"' AND t6.ooefl001=mrajcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t7 ON t7.oofaent='"||g_enterprise||"' AND t7.oofa002='2' AND t7.oofa003=mrajmodid  ",
               " LEFT JOIN oofa_t t8 ON t8.oofaent='"||g_enterprise||"' AND t8.oofa002='2' AND t8.oofa003=mrajcnfid  ",                               
                               
               " LEFT OUTER JOIN mrak_t",
               "    ON mrajent = mrakent",                      
               "   AND mrajsite = mraksite",
               "   AND mraj001 = mrak001",
               "   AND mraj002 = mrak002",
               "   AND mraj003 = mrak003",
               "   AND mrajseq = mrakseq",
               " WHERE mrajent= ? AND mrajsite=? AND mraj001=? AND mraj002=? AND mraj003=?"
                  
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("mraj_t")
   END IF
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF amri100_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY mraj_t.mrajseq"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
 
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amri100_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR amri100_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mraj_m.mrajsite,g_mraj_m.mraj001,g_mraj_m.mraj002,g_mraj_m.mraj003 INTO g_mraj_d[l_ac].mrajseq, 
          g_mraj_d[l_ac].mraj004,g_mraj_d[l_ac].mraj005,g_mraj_d[l_ac].mraj006,g_mraj_d[l_ac].mraj007, 
          g_mraj_d[l_ac].mraj008,g_mraj_d[l_ac].mraj009,g_mraj_d[l_ac].mraj012,g_mraj_d[l_ac].mraj013, 
          g_mraj2_d[l_ac].mrajseq,g_mraj2_d[l_ac].mrajownid,g_mraj2_d[l_ac].mrajowndp,g_mraj2_d[l_ac].mrajcrtid, 
          g_mraj2_d[l_ac].mrajcrtdp,g_mraj2_d[l_ac].mrajcrtdt,g_mraj2_d[l_ac].mrajmodid,g_mraj2_d[l_ac].mrajmoddt, 
          g_mraj2_d[l_ac].mrajcnfid,g_mraj2_d[l_ac].mrajcnfdt,g_mraj2_d[l_ac].mrajstus,g_mraj_d[l_ac].mraj004_desc, 
          g_mraj_d[l_ac].mraj005_desc,g_mraj2_d[l_ac].mrajownid_desc,g_mraj2_d[l_ac].mrajowndp_desc, 
          g_mraj2_d[l_ac].mrajcrtid_desc,g_mraj2_d[l_ac].mrajcrtdp_desc,g_mraj2_d[l_ac].mrajmodid_desc, 
          g_mraj2_d[l_ac].mrajcnfid_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         IF g_ask_show = 'Y' THEN
            LET g_ask_show = 'N'
            IF NOT cl_ask_confirm('amr-00050') THEN
               EXIT FOREACH
            END IF
         END IF
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
 
            CALL g_mraj_d.deleteElement(g_mraj_d.getLength())
      CALL g_mraj2_d.deleteElement(g_mraj2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   LET g_ask_show = 'N'
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_mraj_d.getLength()
      LET g_mraj_d_mask_o[l_ac].* =  g_mraj_d[l_ac].*
      CALL amri100_mraj_t_mask()
      LET g_mraj_d_mask_n[l_ac].* =  g_mraj_d[l_ac].*
   END FOR
   
   LET g_mraj2_d_mask_o.* =  g_mraj2_d.*
   FOR l_ac = 1 TO g_mraj2_d.getLength()
      LET g_mraj2_d_mask_o[l_ac].* =  g_mraj2_d[l_ac].*
      CALL amri100_mraj_t_mask()
      LET g_mraj2_d_mask_n[l_ac].* =  g_mraj2_d[l_ac].*
   END FOR
 
 
   FREE amri100_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="amri100.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION amri100_idx_chk()
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
      IF g_detail_idx > g_mraj_d.getLength() THEN
         LET g_detail_idx = g_mraj_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_mraj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mraj_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_mraj2_d.getLength() THEN
         LET g_detail_idx = g_mraj2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mraj2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mraj2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amri100.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION amri100_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
 
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_mraj_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   CALL g_mrak_d.clear()
   
   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
      RETURN
   END IF
      
   LET g_sql = "SELECT UNIQUE mrakseq1,mrak004,'','',mrak005,mrak006,'',mrak007,mrak008",
               "  FROM mraj_t LEFT OUTER JOIN mrak_t",
               "    ON mrajent = mrakent",                      
               "   AND mrajsite = mraksite",
               "   AND mraj001 = mrak001",
               "   AND mraj002 = mrak002",
               "   AND mraj003 = mrak003",
               "   AND mrajseq = mrakseq",
               " WHERE mrakent = ? AND mraksite = ? AND mrak001 = ? AND mrak002 = ? AND mrak003 = ? AND mrakseq = ?"
   
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED
   END IF
   
   LET g_sql = g_sql, " ORDER BY mrak_t.mrakseq1"
   
   PREPARE amri100_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR amri100_pb2

   LET g_cnt = l_ac2
   LET l_ac2 = 1   
   
   OPEN b_fill_cs2 USING g_enterprise,g_mraj_m.mrajsite,g_mraj_m.mraj001,
                         g_mraj_m.mraj002,g_mraj_m.mraj003,g_mraj_d[g_detail_idx].mrajseq
                                        
   FOREACH b_fill_cs2 INTO g_mrak_d[l_ac2].mrakseq1,g_mrak_d[l_ac2].mrak004,g_mrak_d[l_ac2].mrak004_desc, 
                           g_mrak_d[l_ac2].mrak004_desc1,g_mrak_d[l_ac2].mrak005,g_mrak_d[l_ac2].mrak006,
                           g_mrak_d[l_ac2].mrak006_desc,g_mrak_d[l_ac2].mrak007,g_mrak_d[l_ac2].mrak008
                              
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
            
      CALL amri100_ref_show2()            
            
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         EXIT FOREACH
      END IF   
   END FOREACH
      
   LET g_rec_b2 = l_ac2 -1
   LET l_ac2 = g_cnt
   LET g_cnt = 0 
   
   CALL g_mrak_d.deleteElement(g_mrak_d.getLength())
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="amri100.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION amri100_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   DELETE FROM mrak_t
    WHERE mrakent = g_enterprise AND mraksite = g_mraj_m.mrajsite AND
                              mrak001 = g_mraj_m.mraj001 AND
                              mrak002 = g_mraj_m.mraj002 AND
                              mrak003 = g_mraj_m.mraj003 AND
                              mrakseq = g_mraj_d_t.mrajseq
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "mrak_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE 
   END IF
   #end add-point
   
   DELETE FROM mraj_t
    WHERE mrajent = g_enterprise AND mrajsite = g_mraj_m.mrajsite AND
                              mraj001 = g_mraj_m.mraj001 AND
                              mraj002 = g_mraj_m.mraj002 AND
                              mraj003 = g_mraj_m.mraj003 AND
 
          mrajseq = g_mraj_d_t.mrajseq
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "mraj_t:",SQLERRMESSAGE 
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
 
{<section id="amri100.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amri100_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="amri100.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amri100_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="amri100.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amri100_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="amri100.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION amri100_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_mraj_d[l_ac].mrajseq = g_mraj_d_t.mrajseq 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="amri100.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION amri100_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="amri100.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amri100_lock_b(ps_table,ps_page)
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
   #CALL amri100_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="amri100.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amri100_unlock_b(ps_table,ps_page)
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
 
{<section id="amri100.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION amri100_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mrajsite,mraj001,mraj002,mraj003",TRUE)
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
 
{<section id="amri100.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION amri100_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mrajsite,mraj001,mraj002,mraj003",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   IF g_mraj_m.mraj002 = 'ALL' THEN
      CALL cl_set_comp_entry("mraj002",FALSE)
   END IF
   
   IF g_mraj_m.mraj002 <> 'ALL' THEN
      CALL cl_set_comp_entry("mraj001",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amri100.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amri100_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amri100.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amri100_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="amri100.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION amri100_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amri100.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION amri100_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amri100.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION amri100_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amri100.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION amri100_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amri100.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amri100_default_search()
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
      LET ls_wc = ls_wc, " mrajsite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " mraj001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " mraj002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " mraj003 = '", g_argv[04], "' AND "
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
 
{<section id="amri100.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION amri100_fill_chk(ps_idx)
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
 
{<section id="amri100.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION amri100_modify_detail_chk(ps_record)
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
         LET ls_return = "mrajseq"
      WHEN "s_detail2"
         LET ls_return = "mrajseq_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="amri100.mask_functions" >}
&include "erp/amr/amri100_mask.4gl"
 
{</section>}
 
{<section id="amri100.state_change" >}
    
 
{</section>}
 
{<section id="amri100.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amri100_set_pk_array()
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
   LET g_pk_array[1].values = g_mraj_m.mrajsite
   LET g_pk_array[1].column = 'mrajsite'
   LET g_pk_array[2].values = g_mraj_m.mraj001
   LET g_pk_array[2].column = 'mraj001'
   LET g_pk_array[3].values = g_mraj_m.mraj002
   LET g_pk_array[3].column = 'mraj002'
   LET g_pk_array[4].values = g_mraj_m.mraj003
   LET g_pk_array[4].column = 'mraj003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amri100.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION amri100_msgcentre_notify(lc_state)
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
   CALL amri100_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mraj_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amri100.other_function" readonly="Y" >}

PRIVATE FUNCTION amri100_mraj002_ref(p_mraj002)
   DEFINE p_mraj002       LIKE mraj_t.mraj002
   DEFINE r_mraj002_desc  LIKE type_t.chr80
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mraj002
   CALL ap_ref_array2(g_ref_fields,"SELECT mrba004 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mrbasite='"||g_site||"' AND mrba001=?","") RETURNING g_rtn_fields
   LET r_mraj002_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_mraj002_desc
END FUNCTION

PRIVATE FUNCTION amri100_mraj001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mraj_m.mraj001
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mraj_m.mraj001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mraj_m.mraj001_desc
END FUNCTION

PRIVATE FUNCTION amri100_mraj003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mraj_m.mraj003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1104' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mraj_m.mraj003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mraj_m.mraj003_desc
END FUNCTION

PRIVATE FUNCTION amri100_mraj004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mraj_d[l_ac].mraj004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1110' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mraj_d[l_ac].mraj004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mraj_d[l_ac].mraj004_desc
END FUNCTION

PRIVATE FUNCTION amri100_mraj005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mraj_d[l_ac].mraj005
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1114' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mraj_d[l_ac].mraj005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mraj_d[l_ac].mraj005_desc
END FUNCTION

PRIVATE FUNCTION amri100_set_required_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  

   IF NOT cl_null(g_mraj_d[l_ac].mraj012) THEN
      CALL cl_set_comp_required("mraj013",TRUE)
   END IF

   IF NOT cl_null(g_mraj_d[l_ac].mraj013) THEN
      CALL cl_set_comp_required("mraj012",TRUE)
   END IF   
   
END FUNCTION

PRIVATE FUNCTION amri100_mraj007_chk()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_n1          LIKE type_t.num5
   DEFINE l_n2          LIKE type_t.num5
   
   LET r_success = TRUE
   
   LET l_n1 = 0
   SELECT COUNT(mrbc002) INTO l_n1
     FROM mrbc_t,mrba_t
    WHERE mrbcent = mrbaent
      AND mrbcsite = mrbasite
      AND mrbc001 = mrba001
      AND mrbcent = g_enterprise
      AND mrbcsite = g_site
      AND mrbc002 = g_mraj_d[l_ac].mraj007
      AND mrba010 = g_mraj_m.mraj001
   
   IF l_n1 = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amr-00051'
      LET g_errparam.extend = g_mraj_d[l_ac].mraj007
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_n2 = 0
   SELECT COUNT(mrbc002) INTO l_n1
     FROM mrbc_t,mrba_t
    WHERE mrbcent = mrbaent
      AND mrbcsite = mrbasite
      AND mrbc001 = mrba001
      AND mrbcent = g_enterprise
      AND mrbcsite = g_site
      AND mrbc002 = g_mraj_d[l_ac].mraj007
      AND mrba010 = g_mraj_m.mraj001
      AND mrbastus = 'Y'

   IF l_n1 = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-01302'  #160318-00005#25 mod  'amr-00004'
      LET g_errparam.extend = g_mraj_d[l_ac].mraj007
      #160318-00005#25  --add--str
      LET g_errparam.replace[1] ='amrm200'
      LET g_errparam.replace[2] = cl_get_progname('amrm200',g_lang,"2")
      LET g_errparam.exeprog    ='amrm200'
      #160318-00005#25 --add--end
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION amri100_set_no_required_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1 
   
   CALL cl_set_comp_required("mraj012,mraj013",FALSE)
END FUNCTION

PRIVATE FUNCTION amri100_ref_show2()
   CALL s_desc_get_item_desc(g_mrak_d[l_ac2].mrak004)
   RETURNING g_mrak_d[l_ac2].mrak004_desc,g_mrak_d[l_ac2].mrak004_desc1
   DISPLAY BY NAME g_mrak_d[l_ac2].mrak004_desc
   DISPLAY BY NAME g_mrak_d[l_ac2].mrak004_desc1
      
   CALL s_desc_get_unit_desc(g_mrak_d[l_ac2].mrak006)
   RETURNING g_mrak_d[l_ac2].mrak006_desc
   DISPLAY BY NAME g_mrak_d[l_ac2].mrak006_desc
END FUNCTION

PRIVATE FUNCTION amri100_mrak004_mrak006_chk()
   DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF NOT cl_null(g_mrak_d[l_ac2].mrak004) AND
      NOT cl_null(g_mrak_d[l_ac2].mrak006) THEN
      
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
               
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_mrak_d[l_ac2].mrak004
      LET g_chkparam.arg2 = g_mrak_d[l_ac2].mrak006
                  
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_imao002") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF 
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION amri100_before_delete2()
   DELETE FROM mrak_t
   WHERE mrakent = g_enterprise AND mraksite = g_mraj_m.mrajsite AND
                              mrak001 = g_mraj_m.mraj001 AND
                              mrak002 = g_mraj_m.mraj002 AND
                              mrak003 = g_mraj_m.mraj003 AND
                              mrakseq = g_mraj_d_t.mrajseq AND
                              mrakseq1 = g_mrak_d_t.mrakseq1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "mrak_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE 
   END IF
 
   RETURN TRUE
END FUNCTION

 
{</section>}
 
