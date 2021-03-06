#該程式未解開Section, 採用最新樣板產出!
{<section id="apji115.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-10-09 15:45:49), PR版次:0005(2016-12-14 16:16:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000044
#+ Filename...: apji115
#+ Description: 專案成本要素分攤設定作業
#+ Creator....: 05423(2015-09-02 11:03:19)
#+ Modifier...: 05423 -SD/PR- 08734
 
{</section>}
 
{<section id="apji115.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#150916-00015#1   2015/12/7  By Xiaozg   1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#160318-00005#33  2016/03/27 By 07900    重复错误信息修改
#160318-00025#8   2016/04/20 By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160905-00007#3   2016/09/05 By zhujing  调整系统中无ENT的SQL条件增加ent
#161124-00048#14  2016/12/14 By 08734    星号整批调整
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
PRIVATE type type_g_pjbx_m        RECORD
       pjbx001 LIKE pjbx_t.pjbx001, 
   pjbxld LIKE pjbx_t.pjbxld, 
   pjbxld_desc LIKE type_t.chr80, 
   pjbx002 LIKE pjbx_t.pjbx002, 
   pjbx003 LIKE pjbx_t.pjbx003, 
   pjbx004 LIKE pjbx_t.pjbx004, 
   pjbx004_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pjbx_d        RECORD
       pjbxstus LIKE pjbx_t.pjbxstus, 
   pjbx005 LIKE pjbx_t.pjbx005, 
   l_pjbx005_desc LIKE type_t.chr500, 
   pjbx006 LIKE pjbx_t.pjbx006, 
   pjbx006_desc LIKE type_t.chr500, 
   pjbx008 LIKE pjbx_t.pjbx008, 
   pjbx009 LIKE pjbx_t.pjbx009
       END RECORD
PRIVATE TYPE type_g_pjbx2_d RECORD
       pjbx005 LIKE pjbx_t.pjbx005, 
   pjbx006 LIKE pjbx_t.pjbx006, 
   pjbxownid LIKE pjbx_t.pjbxownid, 
   pjbxownid_desc LIKE type_t.chr500, 
   pjbxowndp LIKE pjbx_t.pjbxowndp, 
   pjbxowndp_desc LIKE type_t.chr500, 
   pjbxcrtid LIKE pjbx_t.pjbxcrtid, 
   pjbxcrtid_desc LIKE type_t.chr500, 
   pjbxcrtdp LIKE pjbx_t.pjbxcrtdp, 
   pjbxcrtdp_desc LIKE type_t.chr500, 
   pjbxcrtdt DATETIME YEAR TO SECOND, 
   pjbxmodid LIKE pjbx_t.pjbxmodid, 
   pjbxmodid_desc LIKE type_t.chr500, 
   pjbxmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_pjbx_s        RECORD
   pjbx001              LIKE pjbx_t.pjbx001,
   pjbxld               LIKE pjbx_t.pjbxld,
   pjbxld_desc          LIKE type_t.chr50,
   pjbx002              LIKE pjbx_t.pjbx002,
   pjbx003              LIKE pjbx_t.pjbx003,
   pjbx004              LIKE pjbx_t.pjbx004,
   pjbx004_desc         LIKE type_t.chr50,
   pjbx005              LIKE pjbx_t.pjbx005,
   pjbx006              LIKE pjbx_t.pjbx006,
   l_comp               LIKE glaa_t.glaacomp,
   glaa004              LIKE glaa_t.glaa004
END RECORD
DEFINE g_pjbx_s        type_g_pjbx_s         
TYPE type_g_pjbx2_s        RECORD
  l_pjbxld_b       LIKE pjbx_t.pjbxld,
  l_pjbxld_b_desc  LIKE type_t.chr80,
  l_pjbx002_b      LIKE pjbx_t.pjbx002,
  l_pjbx003_b      LIKE pjbx_t.pjbx003,
  l_pjbxld_e       LIKE type_t.chr80,
  l_pjbxld_e_desc  LIKE type_t.chr80,
  l_pjbx002_e      LIKE type_t.num5,
  l_pjbx003_e      LIKE type_t.num5
END RECORD
DEFINE g_pjbx2_s        type_g_pjbx2_s        
TYPE type_g_pjbx3_s        RECORD
  pjbx001      LIKE pjbx_t.pjbx001,
  pjbx002      LIKE pjbx_t.pjbx002,
  pjbx003      LIKE pjbx_t.pjbx003 
END RECORD
DEFINE g_pjbx3_s        type_g_pjbx3_s  
DEFINE g_glaacomp       LIKE glaa_t.glaacomp
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_pjbx_m          type_g_pjbx_m
DEFINE g_pjbx_m_t        type_g_pjbx_m
DEFINE g_pjbx_m_o        type_g_pjbx_m
DEFINE g_pjbx_m_mask_o   type_g_pjbx_m #轉換遮罩前資料
DEFINE g_pjbx_m_mask_n   type_g_pjbx_m #轉換遮罩後資料
 
   DEFINE g_pjbx001_t LIKE pjbx_t.pjbx001
DEFINE g_pjbxld_t LIKE pjbx_t.pjbxld
DEFINE g_pjbx002_t LIKE pjbx_t.pjbx002
DEFINE g_pjbx003_t LIKE pjbx_t.pjbx003
DEFINE g_pjbx004_t LIKE pjbx_t.pjbx004
 
 
DEFINE g_pjbx_d          DYNAMIC ARRAY OF type_g_pjbx_d
DEFINE g_pjbx_d_t        type_g_pjbx_d
DEFINE g_pjbx_d_o        type_g_pjbx_d
DEFINE g_pjbx_d_mask_o   DYNAMIC ARRAY OF type_g_pjbx_d #轉換遮罩前資料
DEFINE g_pjbx_d_mask_n   DYNAMIC ARRAY OF type_g_pjbx_d #轉換遮罩後資料
DEFINE g_pjbx2_d   DYNAMIC ARRAY OF type_g_pjbx2_d
DEFINE g_pjbx2_d_t type_g_pjbx2_d
DEFINE g_pjbx2_d_o type_g_pjbx2_d
DEFINE g_pjbx2_d_mask_o   DYNAMIC ARRAY OF type_g_pjbx2_d #轉換遮罩前資料
DEFINE g_pjbx2_d_mask_n   DYNAMIC ARRAY OF type_g_pjbx2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_pjbx001 LIKE pjbx_t.pjbx001,
   b_pjbx001_desc LIKE type_t.chr80,
      b_pjbxld LIKE pjbx_t.pjbxld,
   b_pjbxld_desc LIKE type_t.chr80,
      b_pjbx002 LIKE pjbx_t.pjbx002,
      b_pjbx003 LIKE pjbx_t.pjbx003,
      b_pjbx004 LIKE pjbx_t.pjbx004,
   b_p_pjbx004_desc LIKE type_t.chr80
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
 
{<section id="apji115.main" >}
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
   LET g_errshow = '1'    
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pjbx001,pjbxld,'',pjbx002,pjbx003,pjbx004,''", 
                      " FROM pjbx_t",
                      " WHERE pjbxent= ? AND pjbxld=? AND pjbx001=? AND pjbx002=? AND pjbx003=? AND  
                          pjbx004=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apji115_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pjbx001,t0.pjbxld,t0.pjbx002,t0.pjbx003,t0.pjbx004,t1.glaal002 , 
       t2.pjbal003",
               " FROM pjbx_t t0",
                              " LEFT JOIN glaal_t t1 ON t1.glaalent="||g_enterprise||" AND t1.glaalld=t0.pjbxld AND t1.glaal001='"||g_dlang||"' ",
               " LEFT JOIN pjbal_t t2 ON t2.pjbalent="||g_enterprise||" AND t2.pjbal001=t0.pjbx004 AND t2.pjbal002='"||g_dlang||"' ",
 
               " WHERE t0.pjbxent = " ||g_enterprise|| " AND t0.pjbxld = ? AND t0.pjbx001 = ? AND t0.pjbx002 = ? AND t0.pjbx003 = ? AND t0.pjbx004 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apji115_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apji115 WITH FORM cl_ap_formpath("apj",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apji115_init()   
 
      #進入選單 Menu (="N")
      CALL apji115_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apji115
      
   END IF 
   
   CLOSE apji115_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apji115.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apji115_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('pjbx001','8908') 
   CALL cl_set_combo_scc('pjbx008','8910') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_act_visible("gen_pjbx009",FALSE)
   #end add-point
   
   CALL apji115_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apji115.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apji115_ui_dialog()
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
         INITIALIZE g_pjbx_m.* TO NULL
         CALL g_pjbx_d.clear()
         CALL g_pjbx2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apji115_init()
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
               CALL apji115_idx_chk()
               CALL apji115_fetch('') # reload data
               LET g_detail_idx = 1
               CALL apji115_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_pjbx_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL apji115_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apji115_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_pjbx2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL apji115_idx_chk()
               CALL apji115_ui_detailshow()
               
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
            CALL apji115_browser_fill("")
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
               CALL apji115_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apji115_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL apji115_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apji115_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apji115_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apji115_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apji115_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apji115_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apji115_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apji115_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apji115_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apji115_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apji115_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_pjbx_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_pjbx2_d)
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
               NEXT FIELD pjbx005
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
               CALL apji115_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL apji115_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL apji115_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apji115_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apji115_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION auto_reproduce
            LET g_action_choice="auto_reproduce"
            IF cl_auth_chk_act("auto_reproduce") THEN
               
               #add-point:ON ACTION auto_reproduce name="menu.auto_reproduce"
               CALL apji115_s02()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apji115_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apji115_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_pjbx009
            LET g_action_choice="gen_pjbx009"
            IF cl_auth_chk_act("gen_pjbx009") THEN
               
               #add-point:ON ACTION gen_pjbx009 name="menu.gen_pjbx009"
               CALL apji115_s03()
               CALL apji115_show()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apji115_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apji115_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION auto_gen
            LET g_action_choice="auto_gen"
            IF cl_auth_chk_act("auto_gen") THEN
               
               #add-point:ON ACTION auto_gen name="menu.auto_gen"
               CALL apji115_s01()
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apji115_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apji115_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apji115_set_pk_array()
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
 
{<section id="apji115.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION apji115_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apji115.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apji115_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "pjbxld,pjbx001,pjbx002,pjbx003,pjbx004"
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
      LET l_sub_sql = " SELECT DISTINCT pjbxld ",
                      ", pjbx001 ",
                      ", pjbx002 ",
                      ", pjbx003 ",
                      ", pjbx004 ",
 
                      " FROM pjbx_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE pjbxent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pjbx_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pjbxld ",
                      ", pjbx001 ",
                      ", pjbx002 ",
                      ", pjbx003 ",
                      ", pjbx004 ",
 
                      " FROM pjbx_t ",
                      " ",
                      " ", 
 
 
                      " WHERE pjbxent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pjbx_t")
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
      INITIALIZE g_pjbx_m.* TO NULL
      CALL g_pjbx_d.clear()        
      CALL g_pjbx2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pjbx001,t0.pjbxld,t0.pjbx002,t0.pjbx003,t0.pjbx004 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.pjbx001,t0.pjbxld,t0.pjbx002,t0.pjbx003,t0.pjbx004,t1.gzcbl004 , 
       t2.glaal002",
                " FROM pjbx_t t0",
                #" ",
                " ",
 
 
 
                               " LEFT JOIN gzcbl_t t1 ON t1.gzcbl001='8908' AND t1.gzcbl002=t0.pjbx001 AND t1.gzcbl003='"||g_lang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.pjbxld AND t2.glaal001='"||g_dlang||"' ",
 
                " WHERE t0.pjbxent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("pjbx_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"pjbx_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_pjbx001,g_browser[g_cnt].b_pjbxld,g_browser[g_cnt].b_pjbx002, 
          g_browser[g_cnt].b_pjbx003,g_browser[g_cnt].b_pjbx004,g_browser[g_cnt].b_pjbx001_desc,g_browser[g_cnt].b_pjbxld_desc  
 
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
         CALL apji115_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_pjbxld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_pjbx_m.* TO NULL
      CALL g_pjbx_d.clear()
      CALL g_pjbx2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL apji115_fetch('')
   
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
 
{<section id="apji115.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apji115_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pjbx_m.pjbxld = g_browser[g_current_idx].b_pjbxld   
   LET g_pjbx_m.pjbx001 = g_browser[g_current_idx].b_pjbx001   
   LET g_pjbx_m.pjbx002 = g_browser[g_current_idx].b_pjbx002   
   LET g_pjbx_m.pjbx003 = g_browser[g_current_idx].b_pjbx003   
   LET g_pjbx_m.pjbx004 = g_browser[g_current_idx].b_pjbx004   
 
   EXECUTE apji115_master_referesh USING g_pjbx_m.pjbxld,g_pjbx_m.pjbx001,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003, 
       g_pjbx_m.pjbx004 INTO g_pjbx_m.pjbx001,g_pjbx_m.pjbxld,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003,g_pjbx_m.pjbx004, 
       g_pjbx_m.pjbxld_desc,g_pjbx_m.pjbx004_desc
   CALL apji115_show()
   
END FUNCTION
 
{</section>}
 
{<section id="apji115.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apji115_ui_detailshow()
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
 
{<section id="apji115.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apji115_ui_browser_refresh()
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
      IF g_browser[l_i].b_pjbxld = g_pjbx_m.pjbxld 
         AND g_browser[l_i].b_pjbx001 = g_pjbx_m.pjbx001 
         AND g_browser[l_i].b_pjbx002 = g_pjbx_m.pjbx002 
         AND g_browser[l_i].b_pjbx003 = g_pjbx_m.pjbx003 
         AND g_browser[l_i].b_pjbx004 = g_pjbx_m.pjbx004 
 
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
 
{<section id="apji115.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apji115_construct()
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
   INITIALIZE g_pjbx_m.* TO NULL
   CALL g_pjbx_d.clear()
   CALL g_pjbx2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON pjbx001,pjbxld,pjbx002,pjbx003,pjbx004
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx001
            #add-point:BEFORE FIELD pjbx001 name="construct.b.pjbx001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx001
            
            #add-point:AFTER FIELD pjbx001 name="construct.a.pjbx001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbx001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx001
            #add-point:ON ACTION controlp INFIELD pjbx001 name="construct.c.pjbx001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pjbxld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbxld
            #add-point:ON ACTION controlp INFIELD pjbxld name="construct.c.pjbxld"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbxld  #顯示到畫面上
            NEXT FIELD pjbxld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbxld
            #add-point:BEFORE FIELD pjbxld name="construct.b.pjbxld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbxld
            
            #add-point:AFTER FIELD pjbxld name="construct.a.pjbxld"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx002
            #add-point:BEFORE FIELD pjbx002 name="construct.b.pjbx002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx002
            
            #add-point:AFTER FIELD pjbx002 name="construct.a.pjbx002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbx002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx002
            #add-point:ON ACTION controlp INFIELD pjbx002 name="construct.c.pjbx002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx003
            #add-point:BEFORE FIELD pjbx003 name="construct.b.pjbx003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx003
            
            #add-point:AFTER FIELD pjbx003 name="construct.a.pjbx003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbx003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx003
            #add-point:ON ACTION controlp INFIELD pjbx003 name="construct.c.pjbx003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pjbx004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx004
            #add-point:ON ACTION controlp INFIELD pjbx004 name="construct.c.pjbx004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbx004  #顯示到畫面上
            NEXT FIELD pjbx004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx004
            #add-point:BEFORE FIELD pjbx004 name="construct.b.pjbx004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx004
            
            #add-point:AFTER FIELD pjbx004 name="construct.a.pjbx004"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON pjbxstus,pjbx005,pjbx006,pjbx008,pjbx009,pjbxownid,pjbxowndp,pjbxcrtid, 
          pjbxcrtdp,pjbxcrtdt,pjbxmodid,pjbxmoddt
           FROM s_detail1[1].pjbxstus,s_detail1[1].pjbx005,s_detail1[1].pjbx006,s_detail1[1].pjbx008, 
               s_detail1[1].pjbx009,s_detail2[1].pjbxownid,s_detail2[1].pjbxowndp,s_detail2[1].pjbxcrtid, 
               s_detail2[1].pjbxcrtdp,s_detail2[1].pjbxcrtdt,s_detail2[1].pjbxmodid,s_detail2[1].pjbxmoddt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pjbxcrtdt>>----
         AFTER FIELD pjbxcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pjbxmoddt>>----
         AFTER FIELD pjbxmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pjbxcnfdt>>----
         
         #----<<pjbxpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbxstus
            #add-point:BEFORE FIELD pjbxstus name="construct.b.page1.pjbxstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbxstus
            
            #add-point:AFTER FIELD pjbxstus name="construct.a.page1.pjbxstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbxstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbxstus
            #add-point:ON ACTION controlp INFIELD pjbxstus name="construct.c.page1.pjbxstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pjbx005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx005
            #add-point:ON ACTION controlp INFIELD pjbx005 name="construct.c.page1.pjbx005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 != '1' AND glac006 = '1' "
            CALL q_glac002_5()
            DISPLAY g_qryparam.return1 TO pjbx005  #顯示到畫面上
            NEXT FIELD pjbx005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx005
            #add-point:BEFORE FIELD pjbx005 name="construct.b.page1.pjbx005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx005
            
            #add-point:AFTER FIELD pjbx005 name="construct.a.page1.pjbx005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbx006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx006
            #add-point:ON ACTION controlp INFIELD pjbx006 name="construct.c.page1.pjbx006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_71()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbx006  #顯示到畫面上
            NEXT FIELD pjbx006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx006
            #add-point:BEFORE FIELD pjbx006 name="construct.b.page1.pjbx006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx006
            
            #add-point:AFTER FIELD pjbx006 name="construct.a.page1.pjbx006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx008
            #add-point:BEFORE FIELD pjbx008 name="construct.b.page1.pjbx008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx008
            
            #add-point:AFTER FIELD pjbx008 name="construct.a.page1.pjbx008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbx008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx008
            #add-point:ON ACTION controlp INFIELD pjbx008 name="construct.c.page1.pjbx008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx009
            #add-point:BEFORE FIELD pjbx009 name="construct.b.page1.pjbx009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx009
            
            #add-point:AFTER FIELD pjbx009 name="construct.a.page1.pjbx009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbx009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx009
            #add-point:ON ACTION controlp INFIELD pjbx009 name="construct.c.page1.pjbx009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.pjbxownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbxownid
            #add-point:ON ACTION controlp INFIELD pjbxownid name="construct.c.page2.pjbxownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbxownid  #顯示到畫面上
            NEXT FIELD pjbxownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbxownid
            #add-point:BEFORE FIELD pjbxownid name="construct.b.page2.pjbxownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbxownid
            
            #add-point:AFTER FIELD pjbxownid name="construct.a.page2.pjbxownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pjbxowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbxowndp
            #add-point:ON ACTION controlp INFIELD pjbxowndp name="construct.c.page2.pjbxowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbxowndp  #顯示到畫面上
            NEXT FIELD pjbxowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbxowndp
            #add-point:BEFORE FIELD pjbxowndp name="construct.b.page2.pjbxowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbxowndp
            
            #add-point:AFTER FIELD pjbxowndp name="construct.a.page2.pjbxowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pjbxcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbxcrtid
            #add-point:ON ACTION controlp INFIELD pjbxcrtid name="construct.c.page2.pjbxcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbxcrtid  #顯示到畫面上
            NEXT FIELD pjbxcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbxcrtid
            #add-point:BEFORE FIELD pjbxcrtid name="construct.b.page2.pjbxcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbxcrtid
            
            #add-point:AFTER FIELD pjbxcrtid name="construct.a.page2.pjbxcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pjbxcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbxcrtdp
            #add-point:ON ACTION controlp INFIELD pjbxcrtdp name="construct.c.page2.pjbxcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbxcrtdp  #顯示到畫面上
            NEXT FIELD pjbxcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbxcrtdp
            #add-point:BEFORE FIELD pjbxcrtdp name="construct.b.page2.pjbxcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbxcrtdp
            
            #add-point:AFTER FIELD pjbxcrtdp name="construct.a.page2.pjbxcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbxcrtdt
            #add-point:BEFORE FIELD pjbxcrtdt name="construct.b.page2.pjbxcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.pjbxmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbxmodid
            #add-point:ON ACTION controlp INFIELD pjbxmodid name="construct.c.page2.pjbxmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbxmodid  #顯示到畫面上
            NEXT FIELD pjbxmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbxmodid
            #add-point:BEFORE FIELD pjbxmodid name="construct.b.page2.pjbxmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbxmodid
            
            #add-point:AFTER FIELD pjbxmodid name="construct.a.page2.pjbxmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbxmoddt
            #add-point:BEFORE FIELD pjbxmoddt name="construct.b.page2.pjbxmoddt"
            
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
 
{<section id="apji115.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION apji115_filter()
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
      CONSTRUCT g_wc_filter ON pjbx001,pjbxld,pjbx002,pjbx003,pjbx004
                          FROM s_browse[1].b_pjbx001,s_browse[1].b_pjbxld,s_browse[1].b_pjbx002,s_browse[1].b_pjbx003, 
                              s_browse[1].b_pjbx004
 
         BEFORE CONSTRUCT
               DISPLAY apji115_filter_parser('pjbx001') TO s_browse[1].b_pjbx001
            DISPLAY apji115_filter_parser('pjbxld') TO s_browse[1].b_pjbxld
            DISPLAY apji115_filter_parser('pjbx002') TO s_browse[1].b_pjbx002
            DISPLAY apji115_filter_parser('pjbx003') TO s_browse[1].b_pjbx003
            DISPLAY apji115_filter_parser('pjbx004') TO s_browse[1].b_pjbx004
      
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
 
      CALL apji115_filter_show('pjbx001')
   CALL apji115_filter_show('pjbxld')
   CALL apji115_filter_show('pjbx002')
   CALL apji115_filter_show('pjbx003')
   CALL apji115_filter_show('pjbx004')
 
END FUNCTION
 
{</section>}
 
{<section id="apji115.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION apji115_filter_parser(ps_field)
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
 
{<section id="apji115.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION apji115_filter_show(ps_field)
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
   LET ls_condition = apji115_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apji115.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apji115_query()
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
   CALL g_pjbx_d.clear()
   CALL g_pjbx2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL apji115_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apji115_browser_fill(g_wc)
      CALL apji115_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL apji115_browser_fill("F")
   
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
      CALL apji115_fetch("F") 
   END IF
   
   CALL apji115_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="apji115.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apji115_fetch(p_flag)
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
   
   LET g_pjbx_m.pjbxld = g_browser[g_current_idx].b_pjbxld
   LET g_pjbx_m.pjbx001 = g_browser[g_current_idx].b_pjbx001
   LET g_pjbx_m.pjbx002 = g_browser[g_current_idx].b_pjbx002
   LET g_pjbx_m.pjbx003 = g_browser[g_current_idx].b_pjbx003
   LET g_pjbx_m.pjbx004 = g_browser[g_current_idx].b_pjbx004
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apji115_master_referesh USING g_pjbx_m.pjbxld,g_pjbx_m.pjbx001,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003, 
       g_pjbx_m.pjbx004 INTO g_pjbx_m.pjbx001,g_pjbx_m.pjbxld,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003,g_pjbx_m.pjbx004, 
       g_pjbx_m.pjbxld_desc,g_pjbx_m.pjbx004_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "pjbx_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_pjbx_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_pjbx_m_mask_o.* =  g_pjbx_m.*
   CALL apji115_pjbx_t_mask()
   LET g_pjbx_m_mask_n.* =  g_pjbx_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apji115_set_act_visible()
   CALL apji115_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_pjbx_m_t.* = g_pjbx_m.*
   LET g_pjbx_m_o.* = g_pjbx_m.*
   
   #重新顯示   
   CALL apji115_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="apji115.insert" >}
#+ 資料新增
PRIVATE FUNCTION apji115_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_pjbx_d.clear()
   CALL g_pjbx2_d.clear()
 
 
   INITIALIZE g_pjbx_m.* TO NULL             #DEFAULT 設定
   LET g_pjbxld_t = NULL
   LET g_pjbx001_t = NULL
   LET g_pjbx002_t = NULL
   LET g_pjbx003_t = NULL
   LET g_pjbx004_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_pjbx_m.pjbx001 = "1"
 
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL apji115_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_pjbx_m.* TO NULL
         INITIALIZE g_pjbx_d TO NULL
         INITIALIZE g_pjbx2_d TO NULL
 
         CALL apji115_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pjbx_m.* = g_pjbx_m_t.*
         CALL apji115_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_pjbx_d.clear()
      #CALL g_pjbx2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apji115_set_act_visible()
   CALL apji115_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pjbxld_t = g_pjbx_m.pjbxld
   LET g_pjbx001_t = g_pjbx_m.pjbx001
   LET g_pjbx002_t = g_pjbx_m.pjbx002
   LET g_pjbx003_t = g_pjbx_m.pjbx003
   LET g_pjbx004_t = g_pjbx_m.pjbx004
 
   
   #組合新增資料的條件
   LET g_add_browse = " pjbxent = " ||g_enterprise|| " AND",
                      " pjbxld = '", g_pjbx_m.pjbxld, "' "
                      ," AND pjbx001 = '", g_pjbx_m.pjbx001, "' "
                      ," AND pjbx002 = '", g_pjbx_m.pjbx002, "' "
                      ," AND pjbx003 = '", g_pjbx_m.pjbx003, "' "
                      ," AND pjbx004 = '", g_pjbx_m.pjbx004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apji115_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL apji115_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apji115_master_referesh USING g_pjbx_m.pjbxld,g_pjbx_m.pjbx001,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003, 
       g_pjbx_m.pjbx004 INTO g_pjbx_m.pjbx001,g_pjbx_m.pjbxld,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003,g_pjbx_m.pjbx004, 
       g_pjbx_m.pjbxld_desc,g_pjbx_m.pjbx004_desc
   
   #遮罩相關處理
   LET g_pjbx_m_mask_o.* =  g_pjbx_m.*
   CALL apji115_pjbx_t_mask()
   LET g_pjbx_m_mask_n.* =  g_pjbx_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pjbx_m.pjbx001,g_pjbx_m.pjbxld,g_pjbx_m.pjbxld_desc,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003, 
       g_pjbx_m.pjbx004,g_pjbx_m.pjbx004_desc
   
   #功能已完成,通報訊息中心
   CALL apji115_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apji115.modify" >}
#+ 資料修改
PRIVATE FUNCTION apji115_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_pjbx_m.pjbxld IS NULL
   OR g_pjbx_m.pjbx001 IS NULL
   OR g_pjbx_m.pjbx002 IS NULL
   OR g_pjbx_m.pjbx003 IS NULL
   OR g_pjbx_m.pjbx004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_pjbxld_t = g_pjbx_m.pjbxld
   LET g_pjbx001_t = g_pjbx_m.pjbx001
   LET g_pjbx002_t = g_pjbx_m.pjbx002
   LET g_pjbx003_t = g_pjbx_m.pjbx003
   LET g_pjbx004_t = g_pjbx_m.pjbx004
 
   CALL s_transaction_begin()
   
   OPEN apji115_cl USING g_enterprise,g_pjbx_m.pjbxld,g_pjbx_m.pjbx001,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003,g_pjbx_m.pjbx004
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apji115_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE apji115_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apji115_master_referesh USING g_pjbx_m.pjbxld,g_pjbx_m.pjbx001,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003, 
       g_pjbx_m.pjbx004 INTO g_pjbx_m.pjbx001,g_pjbx_m.pjbxld,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003,g_pjbx_m.pjbx004, 
       g_pjbx_m.pjbxld_desc,g_pjbx_m.pjbx004_desc
   
   #遮罩相關處理
   LET g_pjbx_m_mask_o.* =  g_pjbx_m.*
   CALL apji115_pjbx_t_mask()
   LET g_pjbx_m_mask_n.* =  g_pjbx_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL apji115_show()
   WHILE TRUE
      LET g_pjbxld_t = g_pjbx_m.pjbxld
      LET g_pjbx001_t = g_pjbx_m.pjbx001
      LET g_pjbx002_t = g_pjbx_m.pjbx002
      LET g_pjbx003_t = g_pjbx_m.pjbx003
      LET g_pjbx004_t = g_pjbx_m.pjbx004
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL apji115_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pjbx_m.* = g_pjbx_m_t.*
         CALL apji115_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_pjbx_m.pjbxld != g_pjbxld_t 
      OR g_pjbx_m.pjbx001 != g_pjbx001_t 
      OR g_pjbx_m.pjbx002 != g_pjbx002_t 
      OR g_pjbx_m.pjbx003 != g_pjbx003_t 
      OR g_pjbx_m.pjbx004 != g_pjbx004_t 
 
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
   CALL apji115_set_act_visible()
   CALL apji115_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pjbxent = " ||g_enterprise|| " AND",
                      " pjbxld = '", g_pjbx_m.pjbxld, "' "
                      ," AND pjbx001 = '", g_pjbx_m.pjbx001, "' "
                      ," AND pjbx002 = '", g_pjbx_m.pjbx002, "' "
                      ," AND pjbx003 = '", g_pjbx_m.pjbx003, "' "
                      ," AND pjbx004 = '", g_pjbx_m.pjbx004, "' "
 
   #填到對應位置
   CALL apji115_browser_fill("")
 
   CALL apji115_idx_chk()
 
   CLOSE apji115_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apji115_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="apji115.input" >}
#+ 資料輸入
PRIVATE FUNCTION apji115_input(p_cmd)
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
   DEFINE l_pjbx009              LIKE pjbx_t.pjbx009
   #ADD BY XZG20151203 B
   DEFINE l_sql                  STRING
   
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
   DISPLAY BY NAME g_pjbx_m.pjbx001,g_pjbx_m.pjbxld,g_pjbx_m.pjbxld_desc,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003, 
       g_pjbx_m.pjbx004,g_pjbx_m.pjbx004_desc
   
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
   LET g_forupd_sql = "SELECT pjbxstus,pjbx005,pjbx006,pjbx008,pjbx009,pjbx005,pjbx006,pjbxownid,pjbxowndp, 
       pjbxcrtid,pjbxcrtdp,pjbxcrtdt,pjbxmodid,pjbxmoddt FROM pjbx_t WHERE pjbxent=? AND pjbxld=? AND  
       pjbx001=? AND pjbx002=? AND pjbx003=? AND pjbx004=? AND pjbx005=? AND pjbx006=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apji115_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apji115_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apji115_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_pjbx_m.pjbx001,g_pjbx_m.pjbxld,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003,g_pjbx_m.pjbx004 
 
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apji115.input.head" >}
   
      #單頭段
      INPUT BY NAME g_pjbx_m.pjbx001,g_pjbx_m.pjbxld,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003,g_pjbx_m.pjbx004  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            LET g_pjbx_m.pjbx001 = '1'    #预设分摊类型：1.人工
            LET g_pjbx_m.pjbx002 = YEAR(g_today)
            LET g_pjbx_m.pjbx003 = MONTH(g_today)
            CALL s_ld_bookno()  RETURNING l_success,g_pjbx_m.pjbxld  #预设帐别编号：所在营运据点归属法人对应主账套编号 
            IF l_success = FALSE THEN
               LET g_pjbx_m.pjbxld =""
            END IF 
#            CALL s_ld_chk_authorization(g_user,g_pjbx_m.pjbxld ) RETURNING l_pass
#            IF l_pass = FALSE THEN
#               LET g_pjbx_m.pjbxld =""
#            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbx_m.pjbxld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbx_m.pjbxld_desc=g_rtn_fields[1]
            DISPLAY g_pjbx_m.pjbxld_desc TO pjbxld_desc
           
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx001
            #add-point:BEFORE FIELD pjbx001 name="input.b.pjbx001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx001
            
            #add-point:AFTER FIELD pjbx001 name="input.a.pjbx001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_pjbx_m.pjbxld) AND NOT cl_null(g_pjbx_m.pjbx001) AND NOT cl_null(g_pjbx_m.pjbx002) AND NOT cl_null(g_pjbx_m.pjbx003) AND NOT cl_null(g_pjbx_m.pjbx004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjbx_m.pjbxld != g_pjbxld_t  OR g_pjbx_m.pjbx001 != g_pjbx001_t  OR g_pjbx_m.pjbx002 != g_pjbx002_t  OR g_pjbx_m.pjbx003 != g_pjbx003_t  OR g_pjbx_m.pjbx004 != g_pjbx004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbx_t WHERE "||"pjbxent = '" ||g_enterprise|| "' AND "||"pjbxld = '"||g_pjbx_m.pjbxld ||"' AND "|| "pjbx001 = '"||g_pjbx_m.pjbx001 ||"' AND "|| "pjbx002 = '"||g_pjbx_m.pjbx002 ||"' AND "|| "pjbx003 = '"||g_pjbx_m.pjbx003 ||"' AND "|| "pjbx004 = '"||g_pjbx_m.pjbx004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbx001
            #add-point:ON CHANGE pjbx001 name="input.g.pjbx001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbxld
            
            #add-point:AFTER FIELD pjbxld name="input.a.pjbxld"
            IF NOT cl_null(g_pjbx_m.pjbxld) THEN 
               IF l_cmd_t = 'r' THEN
                  SELECT glaa004 INTO l_glaa004_t FROM glaa_t WHERE glaaent=g_enterprise AND glaald = g_pjbx_m_t.pjbxld
                  SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald = g_pjbx_m.pjbxld
                  IF l_glaa004_t != l_glaa004 THEN
                     LET g_pjbx_m.pjbxld = ''
                     LET g_pjbx_m.pjbxld_desc = ''
                     DISPLAY BY NAME g_pjbx_m.pjbxld_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00138'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD pjbxld
                  END IF
               END IF
               IF NOT ap_chk_isExist(g_pjbx_m.pjbxld,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00055',0) THEN
                  IF p_cmd = 'a' THEN
                     LET g_pjbx_m.pjbxld = ''
                     LET g_pjbx_m.pjbxld_desc = ''
                  ELSE
                     LET g_pjbx_m.pjbxld = g_pjbx_m_t.pjbxld
                     LET g_pjbx_m.pjbxld_desc = g_pjbx_m_t.pjbxld_desc
                  END IF
                  DISPLAY BY NAME g_pjbx_m.pjbxld_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_isExist(g_pjbx_m.pjbxld,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'sub-01302',"agli010") THEN  #agl-00051 #160318-00005#33 by 07900 --mod
                  IF p_cmd = 'a' THEN
                     LET g_pjbx_m.pjbxld = ''
                     LET g_pjbx_m.pjbxld_desc = ''
                  ELSE
                     LET g_pjbx_m.pjbxld = g_pjbx_m_t.pjbxld
                     LET g_pjbx_m.pjbxld_desc = g_pjbx_m_t.pjbxld_desc
                  END IF
                  DISPLAY BY NAME g_pjbx_m.pjbxld_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_ld_chk_authorization(g_user,g_pjbx_m.pjbxld) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_pjbx_m.pjbxld
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  IF p_cmd = 'a' THEN
                     LET g_pjbx_m.pjbxld = ''
                     LET g_pjbx_m.pjbxld_desc = ''
                  ELSE
                     LET g_pjbx_m.pjbxld = g_pjbx_m_t.pjbxld
                     LET g_pjbx_m.pjbxld_desc = g_pjbx_m_t.pjbxld_desc
                  END IF
                  DISPLAY BY NAME g_pjbx_m.pjbxld_desc
                  NEXT FIELD CURRENT
               END IF
               SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx_m.pjbxld
            END IF

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_pjbx_m.pjbxld) AND NOT cl_null(g_pjbx_m.pjbx001) AND NOT cl_null(g_pjbx_m.pjbx002) AND NOT cl_null(g_pjbx_m.pjbx003) AND NOT cl_null(g_pjbx_m.pjbx004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjbx_m.pjbxld != g_pjbxld_t  OR g_pjbx_m.pjbx001 != g_pjbx001_t  OR g_pjbx_m.pjbx002 != g_pjbx002_t  OR g_pjbx_m.pjbx003 != g_pjbx003_t  OR g_pjbx_m.pjbx004 != g_pjbx004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbx_t WHERE "||"pjbxent = '" ||g_enterprise|| "' AND "||"pjbxld = '"||g_pjbx_m.pjbxld ||"' AND "|| "pjbx001 = '"||g_pjbx_m.pjbx001 ||"' AND "|| "pjbx002 = '"||g_pjbx_m.pjbx002 ||"' AND "|| "pjbx003 = '"||g_pjbx_m.pjbx003 ||"' AND "|| "pjbx004 = '"||g_pjbx_m.pjbx004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbx_m.pjbxld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbx_m.pjbxld_desc=g_rtn_fields[1]
            DISPLAY g_pjbx_m.pjbxld_desc TO pjbxld_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbxld
            #add-point:BEFORE FIELD pjbxld name="input.b.pjbxld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbxld
            #add-point:ON CHANGE pjbxld name="input.g.pjbxld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx002
            #add-point:BEFORE FIELD pjbx002 name="input.b.pjbx002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx002
            
            #add-point:AFTER FIELD pjbx002 name="input.a.pjbx002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_pjbx_m.pjbxld) AND NOT cl_null(g_pjbx_m.pjbx001) AND NOT cl_null(g_pjbx_m.pjbx002) AND NOT cl_null(g_pjbx_m.pjbx003) AND NOT cl_null(g_pjbx_m.pjbx004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjbx_m.pjbxld != g_pjbxld_t  OR g_pjbx_m.pjbx001 != g_pjbx001_t  OR g_pjbx_m.pjbx002 != g_pjbx002_t  OR g_pjbx_m.pjbx003 != g_pjbx003_t  OR g_pjbx_m.pjbx004 != g_pjbx004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbx_t WHERE "||"pjbxent = '" ||g_enterprise|| "' AND "||"pjbxld = '"||g_pjbx_m.pjbxld ||"' AND "|| "pjbx001 = '"||g_pjbx_m.pjbx001 ||"' AND "|| "pjbx002 = '"||g_pjbx_m.pjbx002 ||"' AND "|| "pjbx003 = '"||g_pjbx_m.pjbx003 ||"' AND "|| "pjbx004 = '"||g_pjbx_m.pjbx004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_pjbx_m.pjbx002) THEN
               IF g_pjbx_m.pjbx002 <1000 OR g_pjbx_m.pjbx002 >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_pjbx_m.pjbx002
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_pjbx_m.pjbx002 =''
                  NEXT FIELD pjbx002
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbx002
            #add-point:ON CHANGE pjbx002 name="input.g.pjbx002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx003
            #add-point:BEFORE FIELD pjbx003 name="input.b.pjbx003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx003
            
            #add-point:AFTER FIELD pjbx003 name="input.a.pjbx003"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_pjbx_m.pjbxld) AND NOT cl_null(g_pjbx_m.pjbx001) AND NOT cl_null(g_pjbx_m.pjbx002) AND NOT cl_null(g_pjbx_m.pjbx003) AND NOT cl_null(g_pjbx_m.pjbx004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjbx_m.pjbxld != g_pjbxld_t  OR g_pjbx_m.pjbx001 != g_pjbx001_t  OR g_pjbx_m.pjbx002 != g_pjbx002_t  OR g_pjbx_m.pjbx003 != g_pjbx003_t  OR g_pjbx_m.pjbx004 != g_pjbx004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbx_t WHERE "||"pjbxent = '" ||g_enterprise|| "' AND "||"pjbxld = '"||g_pjbx_m.pjbxld ||"' AND "|| "pjbx001 = '"||g_pjbx_m.pjbx001 ||"' AND "|| "pjbx002 = '"||g_pjbx_m.pjbx002 ||"' AND "|| "pjbx003 = '"||g_pjbx_m.pjbx003 ||"' AND "|| "pjbx004 = '"||g_pjbx_m.pjbx004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_pjbx_m.pjbx003) THEN
               IF (g_pjbx_m.pjbx003 < 1) OR (g_pjbx_m.pjbx003 > 12) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00127'
                  LET g_errparam.extend = g_pjbx_m.pjbx003
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_pjbx_m.pjbx003 = ''
                  NEXT FIELD pjbx003
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbx003
            #add-point:ON CHANGE pjbx003 name="input.g.pjbx003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx004
            
            #add-point:AFTER FIELD pjbx004 name="input.a.pjbx004"
            IF NOT cl_null(g_pjbx_m.pjbx004) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbx_m.pjbx004
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"
               #160318-00025#8--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjba001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbx_m.pjbx004 = g_pjbx_m_t.pjbx004
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbx_m.pjbx004
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbx_m.pjbx004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbx_m.pjbx004_desc

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_pjbx_m.pjbxld) AND NOT cl_null(g_pjbx_m.pjbx001) AND NOT cl_null(g_pjbx_m.pjbx002) AND NOT cl_null(g_pjbx_m.pjbx003) AND NOT cl_null(g_pjbx_m.pjbx004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjbx_m.pjbxld != g_pjbxld_t  OR g_pjbx_m.pjbx001 != g_pjbx001_t  OR g_pjbx_m.pjbx002 != g_pjbx002_t  OR g_pjbx_m.pjbx003 != g_pjbx003_t  OR g_pjbx_m.pjbx004 != g_pjbx004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbx_t WHERE "||"pjbxent = '" ||g_enterprise|| "' AND "||"pjbxld = '"||g_pjbx_m.pjbxld ||"' AND "|| "pjbx001 = '"||g_pjbx_m.pjbx001 ||"' AND "|| "pjbx002 = '"||g_pjbx_m.pjbx002 ||"' AND "|| "pjbx003 = '"||g_pjbx_m.pjbx003 ||"' AND "|| "pjbx004 = '"||g_pjbx_m.pjbx004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx004
            #add-point:BEFORE FIELD pjbx004 name="input.b.pjbx004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbx004
            #add-point:ON CHANGE pjbx004 name="input.g.pjbx004"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pjbx001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx001
            #add-point:ON ACTION controlp INFIELD pjbx001 name="input.c.pjbx001"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjbxld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbxld
            #add-point:ON ACTION controlp INFIELD pjbxld name="input.c.pjbxld"
            SELECT glaa004 INTO l_glaa004_t FROM glaa_t WHERE glaaent=g_enterprise AND glaald = g_pjbx_m_t.pjbxld
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbx_m.pjbxld             #給予default值
            IF l_cmd_t = 'r' THEN
               LET g_qryparam.where = " glaa004 = '",l_glaa004_t,"'"
            ELSE
               LET g_qryparam.where = NULL
            END IF

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_pjbx_m.pjbxld = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbx_m.pjbxld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbx_m.pjbxld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbx_m.pjbxld_desc

            DISPLAY g_pjbx_m.pjbxld TO pjbxld              #顯示到畫面上

            NEXT FIELD pjbxld                          #返回原欄位
            LET g_qryparam.where = NULL


            #END add-point
 
 
         #Ctrlp:input.c.pjbx002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx002
            #add-point:ON ACTION controlp INFIELD pjbx002 name="input.c.pjbx002"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjbx003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx003
            #add-point:ON ACTION controlp INFIELD pjbx003 name="input.c.pjbx003"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjbx004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx004
            #add-point:ON ACTION controlp INFIELD pjbx004 name="input.c.pjbx004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbx_m.pjbx004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_pjba001()                                #呼叫開窗

            LET g_pjbx_m.pjbx004 = g_qryparam.return1              

            DISPLAY g_pjbx_m.pjbx004 TO pjbx004              #

            NEXT FIELD pjbx004                          #返回原欄位


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
            DISPLAY BY NAME g_pjbx_m.pjbxld             
                            ,g_pjbx_m.pjbx001   
                            ,g_pjbx_m.pjbx002   
                            ,g_pjbx_m.pjbx003   
                            ,g_pjbx_m.pjbx004   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL apji115_pjbx_t_mask_restore('restore_mask_o')
            
               UPDATE pjbx_t SET (pjbx001,pjbxld,pjbx002,pjbx003,pjbx004) = (g_pjbx_m.pjbx001,g_pjbx_m.pjbxld, 
                   g_pjbx_m.pjbx002,g_pjbx_m.pjbx003,g_pjbx_m.pjbx004)
                WHERE pjbxent = g_enterprise AND pjbxld = g_pjbxld_t
                  AND pjbx001 = g_pjbx001_t
                  AND pjbx002 = g_pjbx002_t
                  AND pjbx003 = g_pjbx003_t
                  AND pjbx004 = g_pjbx004_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pjbx_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pjbx_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pjbx_m.pjbxld
               LET gs_keys_bak[1] = g_pjbxld_t
               LET gs_keys[2] = g_pjbx_m.pjbx001
               LET gs_keys_bak[2] = g_pjbx001_t
               LET gs_keys[3] = g_pjbx_m.pjbx002
               LET gs_keys_bak[3] = g_pjbx002_t
               LET gs_keys[4] = g_pjbx_m.pjbx003
               LET gs_keys_bak[4] = g_pjbx003_t
               LET gs_keys[5] = g_pjbx_m.pjbx004
               LET gs_keys_bak[5] = g_pjbx004_t
               LET gs_keys[6] = g_pjbx_d[g_detail_idx].pjbx005
               LET gs_keys_bak[6] = g_pjbx_d_t.pjbx005
               LET gs_keys[7] = g_pjbx_d[g_detail_idx].pjbx006
               LET gs_keys_bak[7] = g_pjbx_d_t.pjbx006
               CALL apji115_update_b('pjbx_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_pjbx_m_t)
                     #LET g_log2 = util.JSON.stringify(g_pjbx_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL apji115_pjbx_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apji115_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_pjbxld_t = g_pjbx_m.pjbxld
           LET g_pjbx001_t = g_pjbx_m.pjbx001
           LET g_pjbx002_t = g_pjbx_m.pjbx002
           LET g_pjbx003_t = g_pjbx_m.pjbx003
           LET g_pjbx004_t = g_pjbx_m.pjbx004
 
           
           IF g_pjbx_d.getLength() = 0 THEN
              NEXT FIELD pjbx005
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="apji115.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_pjbx_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pjbx_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apji115_b_fill(g_wc2) #test 
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
            CALL apji115_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN apji115_cl USING g_enterprise,g_pjbx_m.pjbxld,g_pjbx_m.pjbx001,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003,g_pjbx_m.pjbx004                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE apji115_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN apji115_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_pjbx_d[l_ac].pjbx005 IS NOT NULL
               AND g_pjbx_d[l_ac].pjbx006 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pjbx_d_t.* = g_pjbx_d[l_ac].*  #BACKUP
               LET g_pjbx_d_o.* = g_pjbx_d[l_ac].*  #BACKUP
               CALL apji115_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL apji115_set_no_entry_b(l_cmd)
               OPEN apji115_bcl USING g_enterprise,g_pjbx_m.pjbxld,
                                                g_pjbx_m.pjbx001,
                                                g_pjbx_m.pjbx002,
                                                g_pjbx_m.pjbx003,
                                                g_pjbx_m.pjbx004,
 
                                                g_pjbx_d_t.pjbx005
                                                ,g_pjbx_d_t.pjbx006
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN apji115_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apji115_bcl INTO g_pjbx_d[l_ac].pjbxstus,g_pjbx_d[l_ac].pjbx005,g_pjbx_d[l_ac].pjbx006, 
                      g_pjbx_d[l_ac].pjbx008,g_pjbx_d[l_ac].pjbx009,g_pjbx2_d[l_ac].pjbx005,g_pjbx2_d[l_ac].pjbx006, 
                      g_pjbx2_d[l_ac].pjbxownid,g_pjbx2_d[l_ac].pjbxowndp,g_pjbx2_d[l_ac].pjbxcrtid, 
                      g_pjbx2_d[l_ac].pjbxcrtdp,g_pjbx2_d[l_ac].pjbxcrtdt,g_pjbx2_d[l_ac].pjbxmodid, 
                      g_pjbx2_d[l_ac].pjbxmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_pjbx_d_t.pjbx005,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pjbx_d_mask_o[l_ac].* =  g_pjbx_d[l_ac].*
                  CALL apji115_pjbx_t_mask()
                  LET g_pjbx_d_mask_n[l_ac].* =  g_pjbx_d[l_ac].*
                  
                  CALL apji115_ref_show()
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
            INITIALIZE g_pjbx_d_t.* TO NULL
            INITIALIZE g_pjbx_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pjbx_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pjbx2_d[l_ac].pjbxownid = g_user
      LET g_pjbx2_d[l_ac].pjbxowndp = g_dept
      LET g_pjbx2_d[l_ac].pjbxcrtid = g_user
      LET g_pjbx2_d[l_ac].pjbxcrtdp = g_dept 
      LET g_pjbx2_d[l_ac].pjbxcrtdt = cl_get_current()
      LET g_pjbx2_d[l_ac].pjbxmodid = g_user
      LET g_pjbx2_d[l_ac].pjbxmoddt = cl_get_current()
      LET g_pjbx_d[l_ac].pjbxstus = ''
 
 
  
            #一般欄位預設值
                  LET g_pjbx_d[l_ac].pjbxstus = "Y"
      LET g_pjbx_d[l_ac].pjbx009 = "100"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            LET g_pjbx_d[l_ac].pjbx008 = "A"
            #end add-point
            LET g_pjbx_d_t.* = g_pjbx_d[l_ac].*     #新輸入資料
            LET g_pjbx_d_o.* = g_pjbx_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apji115_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL apji115_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pjbx_d[li_reproduce_target].* = g_pjbx_d[li_reproduce].*
               LET g_pjbx2_d[li_reproduce_target].* = g_pjbx2_d[li_reproduce].*
 
               LET g_pjbx_d[g_pjbx_d.getLength()].pjbx005 = NULL
               LET g_pjbx_d[g_pjbx_d.getLength()].pjbx006 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM pjbx_t 
             WHERE pjbxent = g_enterprise AND pjbxld = g_pjbx_m.pjbxld
               AND pjbx001 = g_pjbx_m.pjbx001
               AND pjbx002 = g_pjbx_m.pjbx002
               AND pjbx003 = g_pjbx_m.pjbx003
               AND pjbx004 = g_pjbx_m.pjbx004
 
               AND pjbx005 = g_pjbx_d[l_ac].pjbx005
               AND pjbx006 = g_pjbx_d[l_ac].pjbx006
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO pjbx_t
                           (pjbxent,
                            pjbx001,pjbxld,pjbx002,pjbx003,pjbx004,
                            pjbx005,pjbx006
                            ,pjbxstus,pjbx008,pjbx009,pjbxownid,pjbxowndp,pjbxcrtid,pjbxcrtdp,pjbxcrtdt,pjbxmodid,pjbxmoddt) 
                     VALUES(g_enterprise,
                            g_pjbx_m.pjbx001,g_pjbx_m.pjbxld,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003,g_pjbx_m.pjbx004,
                            g_pjbx_d[l_ac].pjbx005,g_pjbx_d[l_ac].pjbx006
                            ,g_pjbx_d[l_ac].pjbxstus,g_pjbx_d[l_ac].pjbx008,g_pjbx_d[l_ac].pjbx009,g_pjbx2_d[l_ac].pjbxownid, 
                                g_pjbx2_d[l_ac].pjbxowndp,g_pjbx2_d[l_ac].pjbxcrtid,g_pjbx2_d[l_ac].pjbxcrtdp, 
                                g_pjbx2_d[l_ac].pjbxcrtdt,g_pjbx2_d[l_ac].pjbxmodid,g_pjbx2_d[l_ac].pjbxmoddt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_pjbx_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "pjbx_t:",SQLERRMESSAGE 
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
               IF apji115_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_pjbx_m.pjbxld
                  LET gs_keys[gs_keys.getLength()+1] = g_pjbx_m.pjbx001
                  LET gs_keys[gs_keys.getLength()+1] = g_pjbx_m.pjbx002
                  LET gs_keys[gs_keys.getLength()+1] = g_pjbx_m.pjbx003
                  LET gs_keys[gs_keys.getLength()+1] = g_pjbx_m.pjbx004
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pjbx_d_t.pjbx005
                  LET gs_keys[gs_keys.getLength()+1] = g_pjbx_d_t.pjbx006
 
 
                  #刪除下層單身
                  IF NOT apji115_key_delete_b(gs_keys,'pjbx_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE apji115_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE apji115_bcl
               LET l_count = g_pjbx_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_pjbx_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbxstus
            #add-point:BEFORE FIELD pjbxstus name="input.b.page1.pjbxstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbxstus
            
            #add-point:AFTER FIELD pjbxstus name="input.a.page1.pjbxstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbxstus
            #add-point:ON CHANGE pjbxstus name="input.g.page1.pjbxstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx005
            
            #add-point:AFTER FIELD pjbx005 name="input.a.page1.pjbx005"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_pjbx_m.pjbxld IS NOT NULL AND g_pjbx_m.pjbx001 IS NOT NULL AND g_pjbx_m.pjbx002 IS NOT NULL AND g_pjbx_m.pjbx003 IS NOT NULL AND g_pjbx_m.pjbx004 IS NOT NULL AND g_pjbx_d[g_detail_idx].pjbx005 IS NOT NULL AND g_pjbx_d[g_detail_idx].pjbx006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjbx_m.pjbxld != g_pjbxld_t OR g_pjbx_m.pjbx001 != g_pjbx001_t OR g_pjbx_m.pjbx002 != g_pjbx002_t OR g_pjbx_m.pjbx003 != g_pjbx003_t OR g_pjbx_m.pjbx004 != g_pjbx004_t OR g_pjbx_d[g_detail_idx].pjbx005 != g_pjbx_d_t.pjbx005 OR g_pjbx_d[g_detail_idx].pjbx006 != g_pjbx_d_t.pjbx006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbx_t WHERE "||"pjbxent = '" ||g_enterprise|| "' AND "||"pjbxld = '"||g_pjbx_m.pjbxld ||"' AND "|| "pjbx001 = '"||g_pjbx_m.pjbx001 ||"' AND "|| "pjbx002 = '"||g_pjbx_m.pjbx002 ||"' AND "|| "pjbx003 = '"||g_pjbx_m.pjbx003 ||"' AND "|| "pjbx004 = '"||g_pjbx_m.pjbx004 ||"' AND "|| "pjbx005 = '"||g_pjbx_d[g_detail_idx].pjbx005 ||"' AND "|| "pjbx006 = '"||g_pjbx_d[g_detail_idx].pjbx006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_pjbx_d[g_detail_idx].pjbx005  <> g_pjbx_d_t.pjbx005 OR cl_null(g_pjbx_d_t.pjbx005) THEN
               IF NOT cl_null(g_pjbx_d[g_detail_idx].pjbx005) THEN 
                  #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511203
              LET l_sql = "AND glac007 = '5'"
              IF  s_aglt310_getlike_lc_subject(g_pjbx_m.pjbxld,g_pjbx_d[g_detail_idx].pjbx005,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_pjbx_m.pjbxld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_pjbx_d[g_detail_idx].pjbx005
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_pjbx_d[g_detail_idx].pjbx005
                LET g_qryparam.arg3 = g_pjbx_m.pjbxld
                LET g_qryparam.arg4 = "1 AND glac007 = '5'"
                CALL q_glac002_6()
                LET g_pjbx_d[g_detail_idx].pjbx005 = g_qryparam.return1
                    SELECT glacl004 INTO g_pjbx_d[l_ac].l_pjbx005_desc
                  FROM glacl_t 
                 WHERE glaclent = g_enterprise  AND glacl002 = g_pjbx2_d[l_ac].pjbx005 AND glacl003 = g_dlang
                 AND glacl001 = l_glac001
                DISPLAY g_pjbx_d[l_ac].pjbx005 TO pjbx005             #顯示到畫面上
                DISPLAY BY NAME g_pjbx_d[l_ac].l_pjbx005_desc
                
              END IF
               IF NOT s_aglt310_lc_subject(g_pjbx_m.pjbxld,g_pjbx_d[g_detail_idx].pjbx005,'N') THEN
                     LET g_pjbx_d[g_detail_idx].pjbx005 = g_pjbx_d_t.pjbx005
                     NEXT FIELD CURRENT 
               END IF
 #  150916-00015#1 END
               #應用 a17 樣板自動產生(Version:2)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  SELECT UNIQUE glaa004 INTO l_glac001 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx_m.pjbxld
                  INITIALIZE g_chkparam.* TO NULL
   
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = l_glac001
                  LET g_chkparam.arg2 = g_pjbx_d[g_detail_idx].pjbx005
                  #160318-00025#8--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
                  #160318-00025#8--add--end  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_glac002_1") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     LET g_pjbx_d[g_detail_idx].pjbx005 = g_pjbx_d_t.pjbx005
                     NEXT FIELD CURRENT
                  END IF
                  SELECT glacl004 INTO g_pjbx_d[g_detail_idx].l_pjbx005_desc
                    FROM glacl_t 
                   WHERE glaclent = g_enterprise  AND glacl002 = g_pjbx_d[g_detail_idx].pjbx005 AND glacl003 = g_dlang
                     AND glacl001 = l_glac001
               END IF 
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx005
            #add-point:BEFORE FIELD pjbx005 name="input.b.page1.pjbx005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbx005
            #add-point:ON CHANGE pjbx005 name="input.g.page1.pjbx005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx006
            
            #add-point:AFTER FIELD pjbx006 name="input.a.page1.pjbx006"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_pjbx_m.pjbxld IS NOT NULL AND g_pjbx_m.pjbx001 IS NOT NULL AND g_pjbx_m.pjbx002 IS NOT NULL AND g_pjbx_m.pjbx003 IS NOT NULL AND g_pjbx_m.pjbx004 IS NOT NULL AND g_pjbx_d[g_detail_idx].pjbx005 IS NOT NULL AND g_pjbx_d[g_detail_idx].pjbx006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjbx_m.pjbxld != g_pjbxld_t OR g_pjbx_m.pjbx001 != g_pjbx001_t OR g_pjbx_m.pjbx002 != g_pjbx002_t OR g_pjbx_m.pjbx003 != g_pjbx003_t OR g_pjbx_m.pjbx004 != g_pjbx004_t OR g_pjbx_d[g_detail_idx].pjbx005 != g_pjbx_d_t.pjbx005 OR g_pjbx_d[g_detail_idx].pjbx006 != g_pjbx_d_t.pjbx006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbx_t WHERE "||"pjbxent = '" ||g_enterprise|| "' AND "||"pjbxld = '"||g_pjbx_m.pjbxld ||"' AND "|| "pjbx001 = '"||g_pjbx_m.pjbx001 ||"' AND "|| "pjbx002 = '"||g_pjbx_m.pjbx002 ||"' AND "|| "pjbx003 = '"||g_pjbx_m.pjbx003 ||"' AND "|| "pjbx004 = '"||g_pjbx_m.pjbx004 ||"' AND "|| "pjbx005 = '"||g_pjbx_d[g_detail_idx].pjbx005 ||"' AND "|| "pjbx006 = '"||g_pjbx_d[g_detail_idx].pjbx006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_pjbx_d[l_ac].pjbx006) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbx_d[l_ac].pjbx006
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#8--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_14") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbx_d[l_ac].pjbx006 = g_pjbx_d_t.pjbx006
                  NEXT FIELD CURRENT
               END IF
               SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx_m.pjbxld
               IF NOT ap_chk_isExist(g_pjbx_d[l_ac].pjbx006,"SELECT COUNT(*) FROM ooeg_t,ooef_t WHERE ooegent = ooefent AND ooeg001 = ooef001 AND ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND (ooef017 = '"||g_glaacomp||"' OR ooef017 = 'ALL') AND ooegstus = 'Y' ","axc-00092",1 ) THEN  #fengmy150313
                   LET g_pjbx_d[l_ac].pjbx006 = ''
                   LET g_pjbx_d[l_ac].pjbx006_desc = ''
                   DISPLAY BY NAME g_pjbx_d[l_ac].pjbx006_desc
                   NEXT FIELD pjbx006
               END IF

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbx_d[l_ac].pjbx006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbx_d[l_ac].pjbx006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbx_d[l_ac].pjbx006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx006
            #add-point:BEFORE FIELD pjbx006 name="input.b.page1.pjbx006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbx006
            #add-point:ON CHANGE pjbx006 name="input.g.page1.pjbx006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx008
            #add-point:BEFORE FIELD pjbx008 name="input.b.page1.pjbx008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx008
            
            #add-point:AFTER FIELD pjbx008 name="input.a.page1.pjbx008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbx008
            #add-point:ON CHANGE pjbx008 name="input.g.page1.pjbx008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbx009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pjbx_d[l_ac].pjbx009,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD pjbx009
            END IF 
 
 
 
            #add-point:AFTER FIELD pjbx009 name="input.a.page1.pjbx009"
            IF NOT cl_null(g_pjbx_d[l_ac].pjbx009) THEN 
               #按照帳別+年度+期別+科目編號+部門編號，分攤權數不能超過100%
               SELECT SUM(pjbx009) INTO l_pjbx009 FROM pjbx_t
                WHERE pjbxent = g_enterprise AND pjbxld = = g_pjbx_m.pjbxld
                  AND pjbx002 = g_pjbx_m.pjbx002 AND pjbx003 = g_pjbx_m.pjbx003
                  AND pjbx005 = g_pjbx_d[l_ac].pjbx005 AND pjbx006 = g_pjbx_d[l_ac].pjbx006 
               
               IF l_cmd = 'a' THEN
                  IF l_pjbx009 + g_pjbx_d[l_ac].pjbx009 > 100 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00077'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD pjbx009
                  END IF
               ELSE
                  IF g_pjbx_d[l_ac].pjbx005 != g_pjbx_d_t.pjbx005 OR g_pjbx_d[l_ac].pjbx006 != g_pjbx_d_t.pjbx006 THEN
                     SELECT SUM(pjbx009) INTO l_pjbx009 FROM pjbx_t
                      WHERE pjbxent = g_enterprise AND pjbxld = = g_pjbx_m.pjbxld
                        AND pjbx002 = g_pjbx_m.pjbx002 AND pjbx003 = g_pjbx_m.pjbx003
                        AND pjbx005 = g_pjbx_d[l_ac].pjbx005 AND pjbx006 = g_pjbx_d[l_ac].pjbx006 
                        
                     IF l_pjbx009 + g_pjbx_d[l_ac].pjbx009 > 100 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'axc-00077'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                        NEXT FIELD pjbx009
                     END IF
                  ELSE
                     IF l_pjbx009 - g_pjbx_d_t.pjbx009 + g_pjbx_d[l_ac].pjbx009 > 100 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'axc-00077'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                        NEXT FIELD pjbx009
                     END IF
                  END IF
               END IF               
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbx009
            #add-point:BEFORE FIELD pjbx009 name="input.b.page1.pjbx009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbx009
            #add-point:ON CHANGE pjbx009 name="input.g.page1.pjbx009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pjbxstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbxstus
            #add-point:ON ACTION controlp INFIELD pjbxstus name="input.c.page1.pjbxstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbx005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx005
            #add-point:ON ACTION controlp INFIELD pjbx005 name="input.c.page1.pjbx005"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbx_d[l_ac].pjbx005             #給予default值
            SELECT UNIQUE glaa004 INTO l_glac001 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx_m.pjbxld
            LET g_qryparam.where = " glac001 = '",l_glac001,"' AND glac003 != '1' AND glac006 = '1' AND glac007 = '5'",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_pjbx_m.pjbxld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg

           #CALL aglt310_04()
            CALL q_glac002_5()
            LET g_pjbx_d[l_ac].pjbx005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            
            SELECT glacl004 INTO g_pjbx_d[l_ac].l_pjbx005_desc
              FROM glacl_t 
             WHERE glaclent = g_enterprise  AND glacl002 = g_pjbx2_d[l_ac].pjbx005 AND glacl003 = g_dlang
             AND glacl001 = l_glac001
            DISPLAY g_pjbx_d[l_ac].pjbx005 TO pjbx005             #顯示到畫面上
            DISPLAY BY NAME g_pjbx_d[l_ac].l_pjbx005_desc
            LET g_qryparam.where = ""
            NEXT FIELD pjbx005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbx006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx006
            #add-point:ON ACTION controlp INFIELD pjbx006 name="input.c.page1.pjbx006"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pjbx_d[l_ac].pjbx006             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_glaacomp
            CALL q_ooeg001_71()                                #呼叫開窗  
            LET g_pjbx_d[l_ac].pjbx006 = g_qryparam.return1              #將開窗取得的值回傳到變數
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbx_d[l_ac].pjbx006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbx_d[l_ac].pjbx006_desc = '', g_rtn_fields[1] , ''
            
            NEXT FIELD pjbx006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbx008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx008
            #add-point:ON ACTION controlp INFIELD pjbx008 name="input.c.page1.pjbx008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbx009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbx009
            #add-point:ON ACTION controlp INFIELD pjbx009 name="input.c.page1.pjbx009"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pjbx_d[l_ac].* = g_pjbx_d_t.*
               CLOSE apji115_bcl
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
               LET g_errparam.extend = g_pjbx_d[l_ac].pjbx005 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_pjbx_d[l_ac].* = g_pjbx_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_pjbx2_d[l_ac].pjbxmodid = g_user 
LET g_pjbx2_d[l_ac].pjbxmoddt = cl_get_current()
LET g_pjbx2_d[l_ac].pjbxmodid_desc = cl_get_username(g_pjbx2_d[l_ac].pjbxmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL apji115_pjbx_t_mask_restore('restore_mask_o')
         
               UPDATE pjbx_t SET (pjbxld,pjbx001,pjbx002,pjbx003,pjbx004,pjbxstus,pjbx005,pjbx006,pjbx008, 
                   pjbx009,pjbxownid,pjbxowndp,pjbxcrtid,pjbxcrtdp,pjbxcrtdt,pjbxmodid,pjbxmoddt) = (g_pjbx_m.pjbxld, 
                   g_pjbx_m.pjbx001,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003,g_pjbx_m.pjbx004,g_pjbx_d[l_ac].pjbxstus, 
                   g_pjbx_d[l_ac].pjbx005,g_pjbx_d[l_ac].pjbx006,g_pjbx_d[l_ac].pjbx008,g_pjbx_d[l_ac].pjbx009, 
                   g_pjbx2_d[l_ac].pjbxownid,g_pjbx2_d[l_ac].pjbxowndp,g_pjbx2_d[l_ac].pjbxcrtid,g_pjbx2_d[l_ac].pjbxcrtdp, 
                   g_pjbx2_d[l_ac].pjbxcrtdt,g_pjbx2_d[l_ac].pjbxmodid,g_pjbx2_d[l_ac].pjbxmoddt)
                WHERE pjbxent = g_enterprise AND pjbxld = g_pjbx_m.pjbxld 
                 AND pjbx001 = g_pjbx_m.pjbx001 
                 AND pjbx002 = g_pjbx_m.pjbx002 
                 AND pjbx003 = g_pjbx_m.pjbx003 
                 AND pjbx004 = g_pjbx_m.pjbx004 
 
                 AND pjbx005 = g_pjbx_d_t.pjbx005 #項次   
                 AND pjbx006 = g_pjbx_d_t.pjbx006  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pjbx_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "pjbx_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pjbx_m.pjbxld
               LET gs_keys_bak[1] = g_pjbxld_t
               LET gs_keys[2] = g_pjbx_m.pjbx001
               LET gs_keys_bak[2] = g_pjbx001_t
               LET gs_keys[3] = g_pjbx_m.pjbx002
               LET gs_keys_bak[3] = g_pjbx002_t
               LET gs_keys[4] = g_pjbx_m.pjbx003
               LET gs_keys_bak[4] = g_pjbx003_t
               LET gs_keys[5] = g_pjbx_m.pjbx004
               LET gs_keys_bak[5] = g_pjbx004_t
               LET gs_keys[6] = g_pjbx_d[g_detail_idx].pjbx005
               LET gs_keys_bak[6] = g_pjbx_d_t.pjbx005
               LET gs_keys[7] = g_pjbx_d[g_detail_idx].pjbx006
               LET gs_keys_bak[7] = g_pjbx_d_t.pjbx006
               CALL apji115_update_b('pjbx_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_pjbx_m),util.JSON.stringify(g_pjbx_d_t)
                     LET g_log2 = util.JSON.stringify(g_pjbx_m),util.JSON.stringify(g_pjbx_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL apji115_pjbx_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_pjbx_m.pjbxld
               LET ls_keys[ls_keys.getLength()+1] = g_pjbx_m.pjbx001
               LET ls_keys[ls_keys.getLength()+1] = g_pjbx_m.pjbx002
               LET ls_keys[ls_keys.getLength()+1] = g_pjbx_m.pjbx003
               LET ls_keys[ls_keys.getLength()+1] = g_pjbx_m.pjbx004
 
               LET ls_keys[ls_keys.getLength()+1] = g_pjbx_d_t.pjbx005
               LET ls_keys[ls_keys.getLength()+1] = g_pjbx_d_t.pjbx006
 
               CALL apji115_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE apji115_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pjbx_d[l_ac].* = g_pjbx_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE apji115_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_pjbx_d.getLength() = 0 THEN
               NEXT FIELD pjbx005
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_pjbx_d[li_reproduce_target].* = g_pjbx_d[li_reproduce].*
               LET g_pjbx2_d[li_reproduce_target].* = g_pjbx2_d[li_reproduce].*
 
               LET g_pjbx_d[li_reproduce_target].pjbx005 = NULL
               LET g_pjbx_d[li_reproduce_target].pjbx006 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pjbx_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pjbx_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_pjbx2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL apji115_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL apji115_idx_chk()
            CALL apji115_ui_detailshow()
        
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
            NEXT FIELD pjbxld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pjbxstus
               WHEN "s_detail2"
                  NEXT FIELD pjbx005_2
 
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
 
{<section id="apji115.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apji115_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL apji115_b_fill(g_wc2) #第一階單身填充
      CALL apji115_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apji115_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_pjbx_m.pjbx001,g_pjbx_m.pjbxld,g_pjbx_m.pjbxld_desc,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003, 
       g_pjbx_m.pjbx004,g_pjbx_m.pjbx004_desc
 
   CALL apji115_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="apji115.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION apji115_ref_show()
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
   LET g_ref_fields[1] = g_pjbx_m.pjbxld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbx_m.pjbxld_desc=g_rtn_fields[1]
   DISPLAY g_pjbx_m.pjbxld_desc TO pjbxld_desc
   
   #专案编号
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjbx_m.pjbx004
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbx_m.pjbx004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbx_m.pjbx004_desc
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_pjbx_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      #会计科目说明
      SELECT UNIQUE glaa004 INTO l_glac001 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx_m.pjbxld
      SELECT glacl004 INTO g_pjbx_d[l_ac].l_pjbx005_desc
        FROM glacl_t 
       WHERE glaclent = g_enterprise  AND glacl002 = g_pjbx_d[l_ac].pjbx005 AND glacl003 = g_dlang
       AND glacl001 = l_glac001
      #部门说明
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_pjbx_d[l_ac].pjbx006
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_pjbx_d[l_ac].pjbx006_desc = '', g_rtn_fields[1] , ''
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_pjbx2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
#      #会计科目说明
#      SELECT UNIQUE glaa004 INTO l_glac001 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx_m.pjbxld
#      SELECT glacl004 INTO g_pjbx2_d[l_ac].l_pjbx005_2_desc
#        FROM glacl_t 
#       WHERE glaclent = g_enterprise  AND glacl002 = g_pjbx2_d[l_ac].pjbx005 AND glacl003 = g_dlang
#       AND glacl001 = l_glac001
#      #部门说明
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_pjbx2_d[l_ac].pjbx006
#      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_pjbx2_d[l_ac].pjbx006_2_desc = '', g_rtn_fields[1] , ''
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="apji115.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apji115_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE pjbx_t.pjbxld 
   DEFINE l_oldno     LIKE pjbx_t.pjbxld 
   DEFINE l_newno02     LIKE pjbx_t.pjbx001 
   DEFINE l_oldno02     LIKE pjbx_t.pjbx001 
   DEFINE l_newno03     LIKE pjbx_t.pjbx002 
   DEFINE l_oldno03     LIKE pjbx_t.pjbx002 
   DEFINE l_newno04     LIKE pjbx_t.pjbx003 
   DEFINE l_oldno04     LIKE pjbx_t.pjbx003 
   DEFINE l_newno05     LIKE pjbx_t.pjbx004 
   DEFINE l_oldno05     LIKE pjbx_t.pjbx004 
 
   DEFINE l_master    RECORD LIKE pjbx_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pjbx_t.* #此變數樣板目前無使用
 
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
 
   IF g_pjbx_m.pjbxld IS NULL
      OR g_pjbx_m.pjbx001 IS NULL
      OR g_pjbx_m.pjbx002 IS NULL
      OR g_pjbx_m.pjbx003 IS NULL
      OR g_pjbx_m.pjbx004 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_pjbxld_t = g_pjbx_m.pjbxld
   LET g_pjbx001_t = g_pjbx_m.pjbx001
   LET g_pjbx002_t = g_pjbx_m.pjbx002
   LET g_pjbx003_t = g_pjbx_m.pjbx003
   LET g_pjbx004_t = g_pjbx_m.pjbx004
 
   
   LET g_pjbx_m.pjbxld = ""
   LET g_pjbx_m.pjbx001 = ""
   LET g_pjbx_m.pjbx002 = ""
   LET g_pjbx_m.pjbx003 = ""
   LET g_pjbx_m.pjbx004 = ""
 
   LET g_master_insert = FALSE
   CALL apji115_set_entry('a')
   CALL apji115_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_pjbx_m.pjbxld_desc = ''
   DISPLAY BY NAME g_pjbx_m.pjbxld_desc
   LET g_pjbx_m.pjbx004_desc = ''
   DISPLAY BY NAME g_pjbx_m.pjbx004_desc
 
   
   CALL apji115_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_pjbx_m.* TO NULL
      INITIALIZE g_pjbx_d TO NULL
      INITIALIZE g_pjbx2_d TO NULL
 
      CALL apji115_show()
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
   CALL apji115_set_act_visible()
   CALL apji115_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pjbxld_t = g_pjbx_m.pjbxld
   LET g_pjbx001_t = g_pjbx_m.pjbx001
   LET g_pjbx002_t = g_pjbx_m.pjbx002
   LET g_pjbx003_t = g_pjbx_m.pjbx003
   LET g_pjbx004_t = g_pjbx_m.pjbx004
 
   
   #組合新增資料的條件
   LET g_add_browse = " pjbxent = " ||g_enterprise|| " AND",
                      " pjbxld = '", g_pjbx_m.pjbxld, "' "
                      ," AND pjbx001 = '", g_pjbx_m.pjbx001, "' "
                      ," AND pjbx002 = '", g_pjbx_m.pjbx002, "' "
                      ," AND pjbx003 = '", g_pjbx_m.pjbx003, "' "
                      ," AND pjbx004 = '", g_pjbx_m.pjbx004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apji115_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL apji115_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL apji115_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="apji115.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apji115_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pjbx_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apji115_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pjbx_t
    WHERE pjbxent = g_enterprise AND pjbxld = g_pjbxld_t
    AND pjbx001 = g_pjbx001_t
    AND pjbx002 = g_pjbx002_t
    AND pjbx003 = g_pjbx003_t
    AND pjbx004 = g_pjbx004_t
 
       INTO TEMP apji115_detail
   
   #將key修正為調整後   
   UPDATE apji115_detail 
      #更新key欄位
      SET pjbxld = g_pjbx_m.pjbxld
          , pjbx001 = g_pjbx_m.pjbx001
          , pjbx002 = g_pjbx_m.pjbx002
          , pjbx003 = g_pjbx_m.pjbx003
          , pjbx004 = g_pjbx_m.pjbx004
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , pjbxownid = g_user 
       , pjbxowndp = g_dept
       , pjbxcrtid = g_user
       , pjbxcrtdp = g_dept 
       , pjbxcrtdt = ld_date
       , pjbxmodid = g_user
       , pjbxmoddt = ld_date
      #, pjbxstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO pjbx_t SELECT * FROM apji115_detail
   
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
   DROP TABLE apji115_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pjbxld_t = g_pjbx_m.pjbxld
   LET g_pjbx001_t = g_pjbx_m.pjbx001
   LET g_pjbx002_t = g_pjbx_m.pjbx002
   LET g_pjbx003_t = g_pjbx_m.pjbx003
   LET g_pjbx004_t = g_pjbx_m.pjbx004
 
   
   DROP TABLE apji115_detail
   
END FUNCTION
 
{</section>}
 
{<section id="apji115.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apji115_delete()
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
   
   IF g_pjbx_m.pjbxld IS NULL
   OR g_pjbx_m.pjbx001 IS NULL
   OR g_pjbx_m.pjbx002 IS NULL
   OR g_pjbx_m.pjbx003 IS NULL
   OR g_pjbx_m.pjbx004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN apji115_cl USING g_enterprise,g_pjbx_m.pjbxld,g_pjbx_m.pjbx001,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003,g_pjbx_m.pjbx004
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apji115_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE apji115_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apji115_master_referesh USING g_pjbx_m.pjbxld,g_pjbx_m.pjbx001,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003, 
       g_pjbx_m.pjbx004 INTO g_pjbx_m.pjbx001,g_pjbx_m.pjbxld,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003,g_pjbx_m.pjbx004, 
       g_pjbx_m.pjbxld_desc,g_pjbx_m.pjbx004_desc
   
   #遮罩相關處理
   LET g_pjbx_m_mask_o.* =  g_pjbx_m.*
   CALL apji115_pjbx_t_mask()
   LET g_pjbx_m_mask_n.* =  g_pjbx_m.*
   
   CALL apji115_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apji115_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM pjbx_t WHERE pjbxent = g_enterprise AND pjbxld = g_pjbx_m.pjbxld
                                                               AND pjbx001 = g_pjbx_m.pjbx001
                                                               AND pjbx002 = g_pjbx_m.pjbx002
                                                               AND pjbx003 = g_pjbx_m.pjbx003
                                                               AND pjbx004 = g_pjbx_m.pjbx004
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pjbx_t:",SQLERRMESSAGE 
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
      #   CLOSE apji115_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_pjbx_d.clear() 
      CALL g_pjbx2_d.clear()       
 
     
      CALL apji115_ui_browser_refresh()  
      #CALL apji115_ui_headershow()  
      #CALL apji115_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL apji115_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL apji115_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE apji115_cl
 
   #功能已完成,通報訊息中心
   CALL apji115_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apji115.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apji115_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_pjbx_d.clear()
   CALL g_pjbx2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT pjbxstus,pjbx005,pjbx006,pjbx008,pjbx009,pjbx005,pjbx006,pjbxownid, 
       pjbxowndp,pjbxcrtid,pjbxcrtdp,pjbxcrtdt,pjbxmodid,pjbxmoddt,t1.ooefl004 ,t2.ooag011 ,t3.ooefl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 FROM pjbx_t",   
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=pjbx006 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=pjbxownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=pjbxowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=pjbxcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=pjbxcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=pjbxmodid  ",
 
               " WHERE pjbxent= ? AND pjbxld=? AND pjbx001=? AND pjbx002=? AND pjbx003=? AND pjbx004=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("pjbx_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF apji115_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY pjbx_t.pjbx005,pjbx_t.pjbx006"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apji115_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apji115_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pjbx_m.pjbxld,g_pjbx_m.pjbx001,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003,g_pjbx_m.pjbx004   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pjbx_m.pjbxld,g_pjbx_m.pjbx001,g_pjbx_m.pjbx002,g_pjbx_m.pjbx003, 
          g_pjbx_m.pjbx004 INTO g_pjbx_d[l_ac].pjbxstus,g_pjbx_d[l_ac].pjbx005,g_pjbx_d[l_ac].pjbx006, 
          g_pjbx_d[l_ac].pjbx008,g_pjbx_d[l_ac].pjbx009,g_pjbx2_d[l_ac].pjbx005,g_pjbx2_d[l_ac].pjbx006, 
          g_pjbx2_d[l_ac].pjbxownid,g_pjbx2_d[l_ac].pjbxowndp,g_pjbx2_d[l_ac].pjbxcrtid,g_pjbx2_d[l_ac].pjbxcrtdp, 
          g_pjbx2_d[l_ac].pjbxcrtdt,g_pjbx2_d[l_ac].pjbxmodid,g_pjbx2_d[l_ac].pjbxmoddt,g_pjbx_d[l_ac].pjbx006_desc, 
          g_pjbx2_d[l_ac].pjbxownid_desc,g_pjbx2_d[l_ac].pjbxowndp_desc,g_pjbx2_d[l_ac].pjbxcrtid_desc, 
          g_pjbx2_d[l_ac].pjbxcrtdp_desc,g_pjbx2_d[l_ac].pjbxmodid_desc   #(ver:49)
                             
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
 
            CALL g_pjbx_d.deleteElement(g_pjbx_d.getLength())
      CALL g_pjbx2_d.deleteElement(g_pjbx2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_pjbx_d.getLength()
      LET g_pjbx_d_mask_o[l_ac].* =  g_pjbx_d[l_ac].*
      CALL apji115_pjbx_t_mask()
      LET g_pjbx_d_mask_n[l_ac].* =  g_pjbx_d[l_ac].*
   END FOR
   
   LET g_pjbx2_d_mask_o.* =  g_pjbx2_d.*
   FOR l_ac = 1 TO g_pjbx2_d.getLength()
      LET g_pjbx2_d_mask_o[l_ac].* =  g_pjbx2_d[l_ac].*
      CALL apji115_pjbx_t_mask()
      LET g_pjbx2_d_mask_n[l_ac].* =  g_pjbx2_d[l_ac].*
   END FOR
 
 
   FREE apji115_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="apji115.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apji115_idx_chk()
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
      IF g_detail_idx > g_pjbx_d.getLength() THEN
         LET g_detail_idx = g_pjbx_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_pjbx_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pjbx_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_pjbx2_d.getLength() THEN
         LET g_detail_idx = g_pjbx2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pjbx2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pjbx2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apji115.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apji115_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_pjbx_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apji115.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION apji115_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM pjbx_t
    WHERE pjbxent = g_enterprise AND pjbxld = g_pjbx_m.pjbxld AND
                              pjbx001 = g_pjbx_m.pjbx001 AND
                              pjbx002 = g_pjbx_m.pjbx002 AND
                              pjbx003 = g_pjbx_m.pjbx003 AND
                              pjbx004 = g_pjbx_m.pjbx004 AND
 
          pjbx005 = g_pjbx_d_t.pjbx005
      AND pjbx006 = g_pjbx_d_t.pjbx006
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "pjbx_t:",SQLERRMESSAGE 
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
 
{<section id="apji115.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apji115_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="apji115.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apji115_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="apji115.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apji115_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="apji115.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION apji115_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_pjbx_d[l_ac].pjbx005 = g_pjbx_d_t.pjbx005 
      AND g_pjbx_d[l_ac].pjbx006 = g_pjbx_d_t.pjbx006 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="apji115.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apji115_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apji115.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apji115_lock_b(ps_table,ps_page)
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
   #CALL apji115_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apji115.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apji115_unlock_b(ps_table,ps_page)
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
 
{<section id="apji115.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apji115_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pjbxld,pjbx001,pjbx002,pjbx003,pjbx004",TRUE)
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
 
{<section id="apji115.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apji115_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pjbxld,pjbx001,pjbx002,pjbx003,pjbx004",FALSE)
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
 
{<section id="apji115.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apji115_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apji115.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apji115_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="apji115.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apji115_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   IF g_browser.getLength() > 0 THEN
      CALL cl_set_act_visible("gen_pjbx009", TRUE)
   END IF
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apji115.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apji115_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   IF g_browser.getLength() = 0 THEN
      CALL cl_set_act_visible("gen_pjbx009", FALSE)
   END IF
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apji115.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apji115_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apji115.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apji115_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apji115.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apji115_default_search()
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
      LET ls_wc = ls_wc, " pjbxld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " pjbx001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " pjbx002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " pjbx003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " pjbx004 = '", g_argv[05], "' AND "
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
 
{<section id="apji115.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apji115_fill_chk(ps_idx)
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
 
{<section id="apji115.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION apji115_modify_detail_chk(ps_record)
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
         LET ls_return = "pjbxstus"
      WHEN "s_detail2"
         LET ls_return = "pjbx005_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="apji115.mask_functions" >}
&include "erp/apj/apji115_mask.4gl"
 
{</section>}
 
{<section id="apji115.state_change" >}
    
 
{</section>}
 
{<section id="apji115.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apji115_set_pk_array()
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
   LET g_pk_array[1].values = g_pjbx_m.pjbxld
   LET g_pk_array[1].column = 'pjbxld'
   LET g_pk_array[2].values = g_pjbx_m.pjbx001
   LET g_pk_array[2].column = 'pjbx001'
   LET g_pk_array[3].values = g_pjbx_m.pjbx002
   LET g_pk_array[3].column = 'pjbx002'
   LET g_pk_array[4].values = g_pjbx_m.pjbx003
   LET g_pk_array[4].column = 'pjbx003'
   LET g_pk_array[5].values = g_pjbx_m.pjbx004
   LET g_pk_array[5].column = 'pjbx004'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apji115.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apji115_msgcentre_notify(lc_state)
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
   CALL apji115_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pjbx_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apji115.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 整批產生
# Memo...........:
# Usage..........: CALL apji115_s01()
# Date & Author..: 2015-9-8 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION apji115_s01()
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
   OPEN WINDOW w_apji115_s01 WITH FORM cl_ap_formpath("apj","apji115_s01")
   
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
         INPUT BY NAME g_pjbx_s.pjbx001,g_pjbx_s.pjbxld,g_pjbx_s.pjbx002,g_pjbx_s.pjbx003,g_pjbx_s.pjbx004  
         ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               CALL cl_set_combo_scc('pjbx001','8908') 
               LET g_pjbx_s.pjbx001 = '1'    #预设分摊类型：1.人工
               LET g_pjbx_s.pjbx002 = YEAR(g_today)       #预设年度：现行年度
               LET g_pjbx_s.pjbx003 = MONTH(g_today)       #预设期别：现行期别
               CALL s_ld_bookno()  RETURNING l_success,g_pjbx_s.pjbxld  #预设帐别编号：所在营运据点归属法人对应主账套编号 
               IF l_success = FALSE THEN
                  LET g_pjbx_s.pjbxld =""
               END IF 
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_pjbx_s.pjbxld
               CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_pjbx_s.pjbxld_desc=g_rtn_fields[1]
               DISPLAY g_pjbx_s.pjbxld_desc TO pjbxld_desc
   
            AFTER FIELD pjbx001
   
            #應用 a02 樣板自動產生(Version:1)
            AFTER FIELD pjbxld
               
               #add-point:AFTER FIELD pjbxld
               IF NOT cl_null(g_pjbx_s.pjbxld) THEN 
               #應用 a17 樣板自動產生(Version:2)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pjbx_s.pjbxld
                  #160318-00025#8--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
                  #160318-00025#8--add--end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_glaald") THEN
                     #檢查成功時後續處理
                     SELECT glaa004,glaacomp INTO g_pjbx_s.glaa004,g_pjbx_s.l_comp
                        FROM glaa_t
                       WHERE glaaent = g_enterprise
                         AND glaald  = g_pjbx_s.pjbxld
                         AND glaastus = 'Y'
                         AND (glaa008  = 'Y' OR glaa014 ='Y')
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF 
   
            #應用 a02 樣板自動產生(Version:1)
            AFTER FIELD pjbx002
               #應用 a15 樣板自動產生(Version:2)
               #確認欄位值在特定區間內
               IF NOT cl_null(g_pjbx_s.pjbx002) THEN
                  IF g_pjbx_s.pjbx002 <1000 OR g_pjbx_s.pjbx002 >9999 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00113'
                     LET g_errparam.extend = g_pjbx_s.pjbx002
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
   
                     LET g_pjbx_s.pjbx002 =''
                     NEXT FIELD pjbx002
                  END IF
               END IF
    
            #應用 a02 樣板自動產生(Version:1)
            AFTER FIELD pjbx003
               #應用 a15 樣板自動產生(Version:2)
               #確認欄位值在特定區間內
               IF NOT cl_null(g_pjbx_s.pjbx003) THEN
                  IF (g_pjbx_s.pjbx003 < 1) OR (g_pjbx_s.pjbx003 > 12) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00127'
                     LET g_errparam.extend = g_pjbx_s.pjbx003
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
   
                     LET g_pjbx_s.pjbx003 = ''
                     NEXT FIELD pjbx003
                  END IF
               END IF
            
            #應用 a02 樣板自動產生(Version:1)
            AFTER FIELD pjbx004
               
               #add-point:AFTER FIELD pjbx004
               IF NOT cl_null(g_pjbx_s.pjbx004) THEN 
                  #應用 a17 樣板自動產生(Version:2)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pjbx_s.pjbx004
                  #160318-00025#8--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"
                  #160318-00025#8--add--end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_pjba001") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF 
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_pjbx_s.pjbx004
               CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_pjbx_s.pjbx004_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_pjbx_s.pjbx004_desc
   
               
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD pjbx001
            
            #Ctrlp:input.c.pjbxld
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD pjbxld
               #add-point:ON ACTION controlp INFIELD pjbxld
               #應用 a07 樣板自動產生(Version:2)   
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_pjbx_s.pjbxld             #給予default值
               #給予arg
               LET g_qryparam.arg1 = "" #
               CALL q_glaa()                                #呼叫開窗
               LET g_pjbx_s.pjbxld = g_qryparam.return1        
               DISPLAY g_pjbx_s.pjbxld TO pjbxld              #
               NEXT FIELD pjbxld                          #返回原欄位
    
            #Ctrlp:input.c.pjbx002
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD pjbx002
               
            #Ctrlp:input.c.pjbx003
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD pjbx003
               
            #Ctrlp:input.c.pjbx004
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD pjbx004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
   
               LET g_qryparam.default1 = g_pjbx_s.pjbx004             #給予default值
   
               LET g_qryparam.arg1 = "" #
               CALL q_pjba001()                                #呼叫開窗
               LET g_pjbx_s.pjbx004 = g_qryparam.return1              
   
               DISPLAY g_pjbx_s.pjbx004 TO pjbx004              #
   
               NEXT FIELD pjbx004                          #返回原欄位
   
            AFTER INPUT
            
         END INPUT
             
         CONSTRUCT BY NAME l_wc ON pjbx006
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
               
            #----<<pjbx006>>----
            #Ctrlp:construct.c.page1.pjbx006
            ON ACTION controlp INFIELD pjbx006
               #add-point:ON ACTION controlp INFIELD pjbx006
               #此段落由子樣板a08產生
               #開窗c段
   			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   			   LET g_qryparam.reqry = FALSE
   			   LET g_qryparam.arg1 = g_glaacomp
#   			   LET g_qryparam.where = " (ooef017 = '",g_pjbx_s.l_comp,"' OR ooef017 = 'ALL') " 
               CALL q_ooeg001_71()                           
               DISPLAY g_qryparam.return1 TO pjbx006  #顯示到畫面上
   
               NEXT FIELD pjbx006                     #返回原欄位
               
         END CONSTRUCT
         
         CONSTRUCT BY NAME l_wc1 ON pjbx005
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
               
            ON ACTION controlp INFIELD pjbx005
               #add-point:ON ACTION controlp INFIELD pjbx005
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " glac003 != '1' AND glac006 = '1' "
   
               #給予arg
               CALL q_glac002_5()
               DISPLAY g_qryparam.return1 TO pjbx005  #顯示到畫面上
               NEXT FIELD pjbx005 
         END CONSTRUCT  
             
         ON ACTION accept
            CALL apji115_ins_pjbx_s01(l_wc,l_wc1)
             
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
   CLOSE WINDOW w_apji115_s01
END FUNCTION

################################################################################
# Descriptions...: 整批複製
# Memo...........:
# Usage..........: CALL apji115_auto_reproduce()
# Input parameter: 传入参数变量1   传入参数变量说明1
# Date & Author..: 2015-9-8 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION apji115_s02()
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_glaa004     LIKE glaa_t.glaa004
   DEFINE l_glaa004_1   LIKE glaa_t.glaa004
   
   OPEN WINDOW w_apji115_s02 WITH FORM cl_ap_formpath("apj","apji115_s02")
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_pjbx2_s.l_pjbxld_b,g_pjbx2_s.l_pjbx002_b,g_pjbx2_s.l_pjbx003_b,g_pjbx2_s.l_pjbxld_e,g_pjbx2_s.l_pjbx002_e,g_pjbx2_s.l_pjbx003_e
         BEFORE INPUT
           LET g_pjbx2_s.l_pjbxld_b = g_pjbx_m.pjbxld
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_pjbx2_s.l_pjbxld_b
           CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
           LET g_pjbx2_s.l_pjbxld_b_desc = '', g_rtn_fields[1] , ''
           DISPLAY BY NAME g_pjbx2_s.l_pjbxld_b_desc
           DISPLAY BY NAME g_pjbx2_s.l_pjbxld_b
           
           LET g_pjbx2_s.l_pjbx002_b = YEAR(g_today)       #预设年度：现行年度
           LET g_pjbx2_s.l_pjbx003_b = MONTH(g_today)       #预设期别：现行期别
           SELECT glaald INTO g_pjbx2_s.l_pjbxld_e FROM glaa_t
            WHERE glaaent = g_enterprise AND glaa014 = 'Y' 
              AND glaacomp = (SELECT UNIQUE ooef017 FROM ooef_t where ooefent = g_enterprise AND ooef001 = g_site)
              
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_pjbx2_s.l_pjbxld_e
           CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
           LET g_pjbx2_s.l_pjbxld_e_desc = '', g_rtn_fields[1] , ''    
           DISPLAY BY NAME g_pjbx2_s.l_pjbxld_e,g_pjbx2_s.l_pjbxld_e_desc,g_pjbx2_s.l_pjbx002_e,g_pjbx2_s.l_pjbx003_e
           
         AFTER FIELD l_pjbxld_b
            IF NOT cl_null(g_pjbx2_s.l_pjbxld_b) THEN
               IF NOT ap_chk_isExist(g_pjbx2_s.l_pjbxld_b,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00055',0) THEN
                  LET g_pjbx2_s.l_pjbxld_b = ''
                  LET g_pjbx2_s.l_pjbxld_b_desc = ''
                  DISPLAY BY NAME g_pjbx2_s.l_pjbxld_b_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_isExist(g_pjbx2_s.l_pjbxld_b,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'sub-01302',"agli010") THEN  #agl-00051 #160318-00005#33 by 07900 --mod 
                  LET g_pjbx2_s.l_pjbxld_b = ''
                  LET g_pjbx2_s.l_pjbxld_b_desc = ''
                  DISPLAY BY NAME g_pjbx2_s.l_pjbxld_b_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_ld_chk_authorization(g_user,g_pjbx2_s.l_pjbxld_b) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_pjbx_m.pjbxld
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pjbx2_s.l_pjbxld_b = ''
                  LET g_pjbx2_s.l_pjbxld_b_desc = ''
                  DISPLAY BY NAME g_pjbx2_s.l_pjbxld_b_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT apji115_pjbxld_pjbx002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbx2_s.l_pjbxld_b
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbx2_s.l_pjbxld_b_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbx2_s.l_pjbxld_b_desc

         AFTER FIELD l_pjbx002_b
            IF NOT cl_null(g_pjbx2_s.l_pjbx002_b) THEN
               IF g_pjbx2_s.l_pjbx002_b <1000 OR g_pjbx2_s.l_pjbx002_b >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_pjbx2_s.l_pjbx002_b
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_pjbx2_s.l_pjbx002_b =''
                  NEXT FIELD l_pjbx002_b
               END IF
               IF NOT apji115_pjbxld_pjbx002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF

         AFTER FIELD l_pjbx003_b
            IF NOT cl_null(g_pjbx2_s.l_pjbx003_b) THEN
               IF (g_pjbx2_s.l_pjbx003_b < 1) OR (g_pjbx2_s.l_pjbx003_b > 12) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00127'
                  LET g_errparam.extend = g_pjbx2_s.l_pjbx003_b
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_pjbx2_s.l_pjbx003_b = ''
                  NEXT FIELD l_pjbx003_b
               END IF
               IF NOT apji115_pjbxld_pjbx002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
            
         AFTER FIELD l_pjbxld_e
            IF NOT cl_null(g_pjbx2_s.l_pjbxld_e) THEN
               IF NOT ap_chk_isExist(g_pjbx2_s.l_pjbxld_e,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00055',0) THEN
                  LET g_pjbx2_s.l_pjbxld_e = ''
                  LET g_pjbx2_s.l_pjbxld_e_desc = ''
                  DISPLAY BY NAME g_pjbx2_s.l_pjbxld_e_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_isExist(g_pjbx2_s.l_pjbxld_e,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'sub-01302',"agli010") THEN  #agl-00051 #160318-00005#33 by 07900 --mod
                  LET g_pjbx2_s.l_pjbxld_e = ''
                  LET g_pjbx2_s.l_pjbxld_e_desc = ''
                  DISPLAY BY NAME g_pjbx2_s.l_pjbxld_e_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_ld_chk_authorization(g_user,g_pjbx2_s.l_pjbxld_e) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_pjbx_m.pjbxld
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pjbx2_s.l_pjbxld_e = ''
                  LET g_pjbx2_s.l_pjbxld_e_desc = ''
                  DISPLAY BY NAME g_pjbx2_s.l_pjbxld_e_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT apji115_pjbxld_pjbx002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
            SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx2_s.l_pjbxld_e

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbx2_s.l_pjbxld_e
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbx2_s.l_pjbxld_e_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbx2_s.l_pjbxld_e_desc

         AFTER FIELD l_pjbx002_e
            IF NOT cl_null(g_pjbx2_s.l_pjbx002_e) THEN
               IF g_pjbx2_s.l_pjbx002_e <1000 OR g_pjbx2_s.l_pjbx002_e >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_pjbx2_s.l_pjbx002_e
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_pjbx2_s.l_pjbx002_e =''
                  NEXT FIELD l_pjbx002_e
               END IF
               IF NOT apji115_pjbxld_pjbx002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF

         AFTER FIELD l_pjbx003_e
            IF NOT cl_null(g_pjbx2_s.l_pjbx003_e) THEN
               IF (g_pjbx2_s.l_pjbx003_e < 1) OR (g_pjbx2_s.l_pjbx003_e > 12) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00127'
                  LET g_errparam.extend = g_pjbx2_s.l_pjbx003_e
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_pjbx2_s.l_pjbx003_e = ''
                  NEXT FIELD l_pjbx003_e
               END IF
               IF NOT apji115_pjbxld_pjbx002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
 
        ON ACTION controlp INFIELD l_pjbxld_b
            #add-point:ON ACTION controlp INFIELD pjbxld
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbx2_s.l_pjbxld_b             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_pjbx2_s.l_pjbxld_b = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbx2_s.l_pjbxld_b
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbx2_s.l_pjbxld_b_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbx2_s.l_pjbxld_b_desc

            DISPLAY g_pjbx2_s.l_pjbxld_b TO l_pjbxld_b              #顯示到畫面上

            NEXT FIELD l_pjbxld_b
            
         ON ACTION controlp INFIELD l_pjbxld_e
            #add-point:ON ACTION controlp INFIELD pjbxld_1
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbx2_s.l_pjbxld_e             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_pjbx2_s.l_pjbxld_e = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbx2_s.l_pjbxld_e
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbx2_s.l_pjbxld_e_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbx2_s.l_pjbxld_e_desc

            DISPLAY g_pjbx2_s.l_pjbxld_e TO l_pjbxld_e              #顯示到畫面上

            NEXT FIELD l_pjbxld_e 

         AFTER INPUT
            IF NOT cl_null(g_pjbx2_s.l_pjbxld_b) AND NOT cl_null(g_pjbx2_s.l_pjbxld_e) THEN
               SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx2_s.l_pjbxld_b
               SELECT glaa004 INTO l_glaa004_1 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx2_s.l_pjbxld_e
               IF l_glaa004 != l_glaa004_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00110'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD l_pjbxld_b
               END IF
            END IF
            CALL apji115_ins_pjbx_s02(g_pjbx2_s.l_pjbxld_b,g_pjbx2_s.l_pjbx002_b,g_pjbx2_s.l_pjbx003_b,g_pjbx2_s.l_pjbxld_e,g_pjbx2_s.l_pjbx002_e,g_pjbx2_s.l_pjbx003_e)

      END INPUT

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG
      
      ON ACTION confirm
         ACCEPT DIALOG

      ON ACTION quit
         LET INT_FLAG = TRUE
         EXIT DIALOG


   END DIALOG
   
   #畫面關閉
   CLOSE WINDOW w_apji115_s02
END FUNCTION

################################################################################
# Descriptions...: 整批產生
# Memo...........:
# Usage..........: CALL apji115_pjbx_ins(p_wc,p_wc1)
# Date & Author..: 2015-9-15 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION apji115_ins_pjbx_s01(p_wc,p_wc1)
DEFINE p_wc           STRING
DEFINE p_wc1          STRING
DEFINE l_sql1          STRING
DEFINE l_success      LIKE type_t.chr1
#DEFINE l_pjbx         RECORD LIKE pjbx_t.*  #161124-00048#14  2016/12/14  By 08734  mark
#161124-00048#14  2016/12/14  By 08734  add(S)
DEFINE l_pjbx RECORD  #專案成本要素分攤設定檔
       pjbxent LIKE pjbx_t.pjbxent, #企业编号
       pjbxld LIKE pjbx_t.pjbxld, #账套编号
       pjbx001 LIKE pjbx_t.pjbx001, #分摊类型
       pjbx002 LIKE pjbx_t.pjbx002, #年度
       pjbx003 LIKE pjbx_t.pjbx003, #期别
       pjbx004 LIKE pjbx_t.pjbx004, #项目编号
       pjbx005 LIKE pjbx_t.pjbx005, #科目编号
       pjbx006 LIKE pjbx_t.pjbx006, #部门编号
       pjbx008 LIKE pjbx_t.pjbx008, #部门属性
       pjbx009 LIKE pjbx_t.pjbx009, #分摊权数
       pjbxownid LIKE pjbx_t.pjbxownid, #资料所有者
       pjbxowndp LIKE pjbx_t.pjbxowndp, #资料所有部门
       pjbxcrtid LIKE pjbx_t.pjbxcrtid, #资料录入者
       pjbxcrtdp LIKE pjbx_t.pjbxcrtdp, #资料录入部门
       pjbxcrtdt LIKE pjbx_t.pjbxcrtdt, #资料创建日
       pjbxmodid LIKE pjbx_t.pjbxmodid, #资料更改者
       pjbxmoddt LIKE pjbx_t.pjbxmoddt, #最近更改日
       pjbxstus LIKE pjbx_t.pjbxstus #状态码
END RECORD
#161124-00048#14  2016/12/14  By 08734  add(E)
DEFINE l_n            LIKE type_t.num10  
DEFINE l_glaa004      LIKE glaa_t.glaa004
DEFINE l_n1           LIKE type_t.num10 

#初始化
   LET l_success = 'N'
   INITIALIZE l_pjbx.* TO NULL

#啟用事務
   CALL s_transaction_begin()
   
   IF cl_null(p_wc) THEN
      LET p_wc = " 1=1 "
   END IF
   IF cl_null(p_wc1) THEN
      LET p_wc1 = " 1=1 "
   END IF
   
   LET l_pjbx.pjbxownid = g_user
   LET l_pjbx.pjbxowndp = g_dept
   LET l_pjbx.pjbxcrtid = g_user
   LET l_pjbx.pjbxcrtdp = g_dept 
   LET l_pjbx.pjbxcrtdt = cl_get_current()
   LET l_pjbx.pjbx009 = 100  
   
   SELECT UNIQUE glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx_s.pjbxld
   SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx_s.pjbxld
   LET g_pjbx_s.l_comp = g_glaacomp
   LET p_wc = cl_replace_str(p_wc,"pjbx006","ooeg001")
   LET p_wc1 = cl_replace_str(p_wc1,"pjbx005","glac002")
   LET l_sql1 = " SELECT UNIQUE ooeg001 FROM ooeg_t,ooef_t ",
                " WHERE ooefent = ooegent AND ooef001 = ooeg001 ",
                "   AND ooegent = '",g_enterprise,"' AND ooegstus = 'Y'",
                "   AND ((ooeg006 <= '" ,g_today,"' OR ooeg006 IS NULL) AND (ooeg007 IS NULL OR ooeg007 > '",g_today,"'))",    
                "   AND (ooef017 = '",g_pjbx_s.l_comp,"' OR ooef017 = 'ALL')",  
                "   AND ",p_wc
   PREPARE ooeg_s01_prep FROM l_sql1
   DECLARE ooeg_s01_curs CURSOR FOR ooeg_s01_prep
  
   LET l_sql1 = " SELECT UNIQUE glac002 FROM glac_t ",
                " WHERE glacent = '",g_enterprise,"' AND glacstus = 'Y'",
                "   AND glac001 = '",l_glaa004,"' AND glac003 != '1' ",
                "   AND glac006 = '1' AND glac007 = '5' AND ",p_wc1

   PREPARE glac_s01_prep FROM l_sql1
   DECLARE glac_s01_curs CURSOR FOR glac_s01_prep
   
   FOREACH ooeg_s01_curs INTO l_pjbx.pjbx006
   
      FOREACH glac_s01_curs INTO l_pjbx.pjbx005
   
         IF NOT cl_null(l_pjbx.pjbx005) THEN
            IF NOT apji115_pjbx005_chk(g_pjbx_s.pjbxld,l_pjbx.pjbx005) THEN  #檢查會計科目是否存在及非統計類科目及非賬戶性質
               LET l_success = 'N'
               EXIT FOREACH
            END IF
         END IF
           
         IF NOT cl_null(l_pjbx.pjbx006) THEN
            IF NOT ap_chk_isExist(l_pjbx.pjbx006,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? ","abm-00006",0) THEN
               LET l_success = 'N'
               EXIT FOREACH
            END IF
            IF NOT ap_chk_isExist(l_pjbx.pjbx006,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' ","sub-01302","aooi125" ) THEN  #abm-00007 #160318-00005#33 by 07900 --mod
               LET l_success = 'N'
               EXIT FOREACH
            END IF
         END IF    
       
         #先檢查是否已經有存在資料,若有則跳過
         LET l_n = 0           
         SELECT COUNT(*) INTO l_n FROM pjbx_t 
          WHERE pjbxent = g_enterprise      
            AND pjbxld = g_pjbx_s.pjbxld
            AND pjbx001 = g_pjbx_s.pjbx001 
            AND pjbx002 = g_pjbx_s.pjbx002
            AND pjbx003 = g_pjbx_s.pjbx003 
            AND pjbx004 = g_pjbx_s.pjbx004
            AND pjbx005 = l_pjbx.pjbx005    
            AND pjbx006 = l_pjbx.pjbx006   
         IF l_n > 0 THEN
            CONTINUE FOREACH
         END IF
         IF cl_null(g_pjbx_s.pjbx004) THEN LET g_pjbx_s.pjbx004 = ' ' END IF  
         #插入數據庫操作
         LET l_success = 'Y' 
         INSERT INTO pjbx_t
                  (pjbxent,
                   pjbx001,pjbxld,pjbx002,pjbx003,pjbx004,pjbx005,pjbx006,
                   pjbxstus,pjbx009,pjbxownid,pjbxowndp,pjbxcrtid,pjbxcrtdp,pjbxcrtdt) 
            VALUES(g_enterprise,
                   g_pjbx_s.pjbx001,g_pjbx_s.pjbxld,g_pjbx_s.pjbx002,g_pjbx_s.pjbx003,g_pjbx_s.pjbx004,
                   l_pjbx.pjbx005,l_pjbx.pjbx006,'Y',l_pjbx.pjbx009,
                   l_pjbx.pjbxownid,l_pjbx.pjbxowndp,l_pjbx.pjbxcrtid,l_pjbx.pjbxcrtdp,l_pjbx.pjbxcrtdt)
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
#檢查會計科目是否存在及非統計類科目及非賬戶性質
################################################################################
PRIVATE FUNCTION apji115_pjbx005_chk(p_ld,p_pjbx005)
   DEFINE p_pjbx005    LIKE pjbx_t.pjbx005
   DEFINE l_glaa004    LIKE glaa_t.glaa004
   DEFINE r_success    LIKE type_t.num5
   DEFINE p_ld         LIKE pjbx_t.pjbxld    
   LET r_success = TRUE
   SELECT UNIQUE glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_ld 
   IF NOT cl_null(p_pjbx005) THEN
      #檢查是否存在
      IF r_success THEN
         IF NOT ap_chk_isExist(p_pjbx005,"SELECT COUNT(*) FROM glac_t WHERE glacent = '"
            ||g_enterprise||"' AND glac001 = '"||l_glaa004||"' AND glac002 = ? ","agl-00141",0 ) THEN
            LET r_success = FALSE
         END IF
      END IF
      #檢查是否是統制科目
      IF r_success THEN
         IF NOT ap_chk_isExist(p_pjbx005,"SELECT COUNT(*) FROM glac_t WHERE glacent = '"
            ||g_enterprise||"' AND glac001 = '"||l_glaa004||"' AND glac002 = ? AND glac003 != '1' ","agl-00142",0) THEN
            LET r_success = FALSE
         END IF
      END IF
      #檢查是否是賬戶性質科目
      IF r_success THEN
         IF NOT ap_chk_isExist(p_pjbx005,"SELECT COUNT(*) FROM glac_t WHERE glacent = '"
            ||g_enterprise||"' AND glac001 = '"||l_glaa004||"' AND glac002 = ? AND glac006 = '1' ","axc-00057",0) THEN
            LET r_success = FALSE
         END IF
      END IF
      #檢查是否為成本類科目
      IF r_success THEN
         IF NOT ap_chk_isExist(p_pjbx005,"SELECT COUNT(*) FROM glac_t WHERE glacent = '"
            ||g_enterprise||"' AND glac001 = '"||l_glaa004||"' AND glac002 = ? AND glac007 = '5' ","axc-00091",0) THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   RETURN r_success
END FUNCTION

################################################################################
#檢查目的帳套年度期別與來源帳套年度期別不能相等
################################################################################
PRIVATE FUNCTION apji115_pjbxld_pjbx002_chk()
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   
   IF NOT cl_null(g_pjbx2_s.l_pjbxld_b) AND NOT cl_null(g_pjbx2_s.l_pjbx002_b) AND NOT cl_null(g_pjbx2_s.l_pjbx003_b) 
      AND NOT cl_null(g_pjbx2_s.l_pjbxld_e) AND NOT cl_null(g_pjbx2_s.l_pjbx002_e) AND NOT cl_null(g_pjbx2_s.l_pjbx003_e) THEN
      IF g_pjbx2_s.l_pjbxld_b = g_pjbx2_s.l_pjbxld_e AND g_pjbx2_s.l_pjbx002_b = g_pjbx2_s.l_pjbx002_e 
         AND g_pjbx2_s.l_pjbx003_b = g_pjbx2_s.l_pjbx003_e THEN
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
#整批复制插入pjbx_t
################################################################################
PRIVATE FUNCTION apji115_ins_pjbx_s02(p_pjbxld_b,p_pjbx002_b,p_pjbx003_b,p_pjbxld_e,p_pjbx002_e,p_pjbx003_e)
DEFINE p_pjbxld_b       LIKE pjbx_t.pjbxld
DEFINE p_pjbx002_b      LIKE pjbx_t.pjbx002
DEFINE p_pjbx003_b      LIKE pjbx_t.pjbx003
DEFINE p_pjbxld_e       LIKE pjbx_t.pjbxld
DEFINE p_pjbx002_e      LIKE pjbx_t.pjbx002
DEFINE p_pjbx003_e      LIKE pjbx_t.pjbx003
DEFINE l_sql            STRING
DEFINE l_success        LIKE type_t.chr1
#DEFINE l_pjbx           RECORD LIKE pjbx_t.*  #161124-00048#14  2016/12/14  By 08734  mark
#161124-00048#14  2016/12/14  By 08734  add(S)
DEFINE l_pjbx RECORD  #專案成本要素分攤設定檔
       pjbxent LIKE pjbx_t.pjbxent, #企业编号
       pjbxld LIKE pjbx_t.pjbxld, #账套编号
       pjbx001 LIKE pjbx_t.pjbx001, #分摊类型
       pjbx002 LIKE pjbx_t.pjbx002, #年度
       pjbx003 LIKE pjbx_t.pjbx003, #期别
       pjbx004 LIKE pjbx_t.pjbx004, #项目编号
       pjbx005 LIKE pjbx_t.pjbx005, #科目编号
       pjbx006 LIKE pjbx_t.pjbx006, #部门编号
       pjbx008 LIKE pjbx_t.pjbx008, #部门属性
       pjbx009 LIKE pjbx_t.pjbx009, #分摊权数
       pjbxownid LIKE pjbx_t.pjbxownid, #资料所有者
       pjbxowndp LIKE pjbx_t.pjbxowndp, #资料所有部门
       pjbxcrtid LIKE pjbx_t.pjbxcrtid, #资料录入者
       pjbxcrtdp LIKE pjbx_t.pjbxcrtdp, #资料录入部门
       pjbxcrtdt LIKE pjbx_t.pjbxcrtdt, #资料创建日
       pjbxmodid LIKE pjbx_t.pjbxmodid, #资料更改者
       pjbxmoddt LIKE pjbx_t.pjbxmoddt, #最近更改日
       pjbxstus LIKE pjbx_t.pjbxstus #状态码
END RECORD
#161124-00048#14  2016/12/14  By 08734  add(E)
DEFINE l_n              LIKE type_t.num10 
DEFINE l_glaacomp       LIKE glaa_t.glaacomp
DEFINE l_glaacomp_1     LIKE glaa_t.glaacomp
DEFINE l_glaa004_1      LIKE glaa_t.glaa004
DEFINE l_glaa004        LIKE glaa_t.glaa004
DEFINE l_n1             LIKE type_t.num10 
DEFINE l_sum            LIKE type_t.num5      #計算分攤權數
DEFINE l_pjbx005_t      LIKE pjbx_t.pjbx005   #科目編號舊值 
DEFINE l_pjbx006_t      LIKE pjbx_t.pjbx006   #部門編號舊值 
DEFINE l_pjbx009_t      LIKE pjbx_t.pjbx009   #分攤權數舊值 
DEFINE l_pjbx004        LIKE pjbx_t.pjbx004   #专案编号
DEFINE l_pjbx006        LIKE pjbx_t.pjbx005   #部門編號
DEFINE l_str            STRING

   #初始化
   LET l_success = 'Y'
   INITIALIZE l_pjbx.* TO NULL

   #為空，則RETURN
   IF cl_null(p_pjbxld_b) OR cl_null(p_pjbx002_b) OR cl_null(p_pjbx003_b) OR cl_null(p_pjbxld_e) OR cl_null(p_pjbx002_e) OR cl_null(p_pjbx003_e) THEN
      RETURN
   END IF
    
   
   #检查来源账套与目的账套是否用的同一套科目表
   IF NOT cl_null(g_pjbx2_s.l_pjbxld_b) AND NOT cl_null(g_pjbx2_s.l_pjbxld_e) THEN
      SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx2_s.l_pjbxld_b
      SELECT glaa004 INTO l_glaa004_1 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx2_s.l_pjbxld_e
      IF l_glaa004 != l_glaa004_1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00110'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
   END IF

#啟用事務
   CALL s_transaction_begin()
   
   CALL cl_showmsg_init()
   LET l_pjbx.pjbxownid = g_user
   LET l_pjbx.pjbxowndp = g_dept
   LET l_pjbx.pjbxcrtid = g_user
   LET l_pjbx.pjbxcrtdp = g_dept 
   LET l_pjbx.pjbxcrtdt = cl_get_current()
   LET l_n1 = 0

   #開始插入操作
   LET l_sql = " SELECT pjbx001,pjbx004,pjbx005,pjbx006,pjbx008,pjbx009 FROM pjbx_t ",
               " WHERE pjbxent = '",g_enterprise,"' AND pjbxld = '",p_pjbxld_b,"'",
               "   AND pjbx002 = '",p_pjbx002_b,"' AND pjbx003 = '",p_pjbx003_b, "'",
               "   ORDER BY pjbx005,pjbx006 "
   PREPARE pjbx_s02_prep FROM l_sql
   DECLARE pjbx_s02_curs CURSOR FOR pjbx_s02_prep
   
   FOREACH pjbx_s02_curs INTO l_pjbx.pjbx001,l_pjbx.pjbx004,l_pjbx.pjbx005,l_pjbx.pjbx006,
                              l_pjbx.pjbx008,l_pjbx.pjbx009
       
       #前后兩筆部門編號或者會計科目不同
       IF l_pjbx.pjbx005 != l_pjbx005_t OR l_pjbx.pjbx006 != l_pjbx006_t THEN
          LET l_sum = 0
          SELECT SUM(pjbx009) INTO l_sum FROM pjbx_t 
           WHERE pjbxent = g_enterprise AND pjbxld = p_pjbxld_e
             AND pjbx002 = p_pjbx002_e AND pjbx003 = p_pjbx003_e  
          　AND pjbx005 = l_pjbx.pjbx005 AND pjbx006 = l_pjbx.pjbx006 
          IF cl_null(l_sum) THEN LET l_sum = 0 END IF 
       END IF 
    
       LET l_pjbx005_t = l_pjbx.pjbx005 
       LET l_pjbx006_t = l_pjbx.pjbx006        
       
       #若已經存在，则删除资料在进行新增       
       LET l_n = 0           
       SELECT COUNT(*) INTO l_n FROM pjbx_t 
        WHERE pjbxent = g_enterprise   AND pjbxld = p_pjbxld_e
          AND pjbx001 = l_pjbx.pjbx001 AND pjbx002 = p_pjbx002_e
          AND pjbx003 = p_pjbx003_e    AND pjbx004 = l_pjbx.pjbx004
          AND pjbx005 = l_pjbx.pjbx005 AND pjbx006 = l_pjbx.pjbx006   

       IF l_n > 0 THEN
          #取分攤權數pjbx009舊值
          SELECT pjbx009 INTO l_pjbx009_t FROM pjbx_t 
           WHERE pjbxent = g_enterprise   AND pjbxld = p_pjbxld_e 
             AND pjbx002 = p_pjbx002_e
             AND pjbx003 = p_pjbx003_e   
             AND pjbx005 = l_pjbx.pjbx005 AND pjbx006 = l_pjbx.pjbx006
          
          #刪除已存在資料          
          DELETE FROM pjbx_t 
           WHERE pjbxent = g_enterprise   AND pjbxld = p_pjbxld_e
             AND pjbx001 = l_pjbx.pjbx001 AND pjbx002 = p_pjbx002_e
             AND pjbx003 = p_pjbx003_e    AND pjbx004 = l_pjbx.pjbx004  
             AND pjbx005 = l_pjbx.pjbx005 AND pjbx006 = l_pjbx.pjbx006 
             
          LET l_sum = l_sum - l_pjbx009_t   #若資料已存在，減去已存在的分攤權數
       END IF
       
       LET l_sum = l_sum + l_pjbx.pjbx009  #累計分攤權數
       IF cl_null(l_pjbx.pjbx004) THEN LET l_pjbx.pjbx004 = ' ' END IF  #fengmy150108 add
       LET l_n1 = 1
       #插入數據庫操作
       INSERT INTO pjbx_t
                (pjbxent,
                 pjbx001,pjbxld,pjbx002,pjbx003,pjbx004,pjbx005,pjbx006,
                 pjbxstus,pjbx008,pjbx009,pjbxownid,pjbxowndp,pjbxcrtid,pjbxcrtdp,pjbxcrtdt) 
          VALUES(g_enterprise,
                 l_pjbx.pjbx001,p_pjbxld_e,p_pjbx002_e,p_pjbx003_e,l_pjbx.pjbx004,l_pjbx.pjbx005,
                 l_pjbx.pjbx006,'Y',l_pjbx.pjbx008,l_pjbx.pjbx009,
                 l_pjbx.pjbxownid,l_pjbx.pjbxowndp,l_pjbx.pjbxcrtid,l_pjbx.pjbxcrtdp,l_pjbx.pjbxcrtdt)
       IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
          LET l_success = 'N'
          EXIT FOREACH 
       END IF
       
       IF l_sum > 100 THEN
          LET l_str = p_pjbxld_e,"/",p_pjbx002_e,"/",p_pjbx003_e,"/",l_pjbx.pjbx005,"/",l_pjbx.pjbx006
          CALL cl_errmsg('pjbxld,pjbx002,pjbx003,pjbx005,pjbx006',l_str,'','axc-00077',1)
          LET l_success = 'N'
       END IF
         
   END FOREACH
   
   IF l_success = 'Y' THEN
      #检查来源账套与目的账套是否用的同一套科目表
      IF NOT cl_null(g_pjbx2_s.l_pjbxld_b) AND NOT cl_null(g_pjbx2_s.l_pjbxld_e) THEN
         SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx2_s.l_pjbxld_b
         SELECT glaacomp INTO l_glaacomp_1 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbx2_s.l_pjbxld_e
         IF l_glaacomp != l_glaacomp_1 THEN
#            LET l_sql = " SELECT UNIQUE pjbx004 FROM pjbx_t,ooef_t ",
#                        "  WHERE pjbxent = ooefent AND pjbx004 = ooef001 ",
#                        "    AND (ooef017 != '",l_glaacomp_1,"' OR ooef017 is null) ",
#                        "    AND pjbxent = '",g_enterprise,"' AND pjbxld ='",p_pjbxld_e,"'",
#                        "    AND pjbx002 = ",p_pjbx002_e," AND pjbx003 = ",p_pjbx003_e
#            PREPARE pjbx004_prep FROM l_sql
#            DECLARE pjbx004_curs CURSOR FOR pjbx004_prep
#            FOREACH pjbx004_curs INTO l_pjbx004
#               LET l_str = p_pjbxld_e,"/",l_pjbx.pjbx004
#               CALL cl_errmsg('pjbxld,pjbx004',l_str,'','axc-00092',1)
#            END FOREACH
            
            LET l_sql = " SELECT UNIQUE pjbx006 FROM pjbx_t,ooef_t ",
                        "  WHERE pjbxent = ooefent AND pjbx006 = ooef001 ",
                        "    AND (ooef017 != '",l_glaacomp_1,"' OR ooef017 is null) ",
                        "    AND pjbxent = '",g_enterprise,"' AND pjbxld ='",p_pjbxld_e,"'",
                        "    AND pjbx002 = ",p_pjbx002_e," AND pjbx003 = ",p_pjbx003_e
            PREPARE pjbx006_prep FROM l_sql
            DECLARE pjbx006_curs CURSOR FOR pjbx006_prep
            FOREACH pjbx006_curs INTO l_pjbx006
               LET l_str = p_pjbxld_e,"/",l_pjbx.pjbx006
               CALL cl_errmsg('pjbxld,pjbx006',l_str,'','axc-00092',1)
            END FOREACH
            
         END IF
      END IF
   END IF 
   
   CALL cl_err_showmsg()
   
#結束事務
   CALL s_transaction_end(l_success,1)
END FUNCTION

################################################################################
# Descriptions...: 依報工產生分攤權數
# Memo...........:
# Usage..........: CALL apji115_s03()
# Modify.........:
################################################################################
PRIVATE FUNCTION apji115_s03()
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_str           STRING 
   DEFINE lwin_curr       ui.Window
   DEFINE lfrm_curr       ui.Form
   DEFINE ls_path   STRING
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_year         LIKE pjbx_t.pjbx002
   DEFINE l_period       LIKE pjbx_t.pjbx003
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_apji115_s03 WITH FORM cl_ap_formpath("apj","apji115_s03")
   
   CREATE TEMP TABLE apji115_s03_tmp
   (
      ooeg001    VARCHAR(40)
   );
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
         INPUT BY NAME g_pjbx3_s.pjbx001,g_pjbx3_s.pjbx002,g_pjbx3_s.pjbx003
         ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               CALL cl_set_combo_scc('pjbx001','8908') 
               LET g_pjbx3_s.pjbx001 = '1'    #预设分摊类型：1.人工
#               LET g_pjbx3_s.pjbx002 = YEAR(g_today)       #预设年度：现行年度     2015-10-28 zj marked
               LET l_year = cl_get_para(g_enterprise,g_site,'S-FIN-6010')   #2015-10-28 zj add
               LET g_pjbx3_s.pjbx002 = l_year
#               LET g_pjbx3_s.pjbx003 = MONTH(g_today)      #预设期别：现行期别     2015-10-28 zj marked
               LET l_period = cl_get_para(g_enterprise,g_site,'S-FIN-6011')   #2015-10-28 zj add
               LET g_pjbx3_s.pjbx003 = l_period
               DISPLAY BY NAME g_pjbx3_s.pjbx001
               DISPLAY BY NAME g_pjbx3_s.pjbx002
               DISPLAY BY NAME g_pjbx3_s.pjbx003
               
            AFTER FIELD pjbx001
   
            #應用 a02 樣板自動產生(Version:1)
            AFTER FIELD pjbx002
               #應用 a15 樣板自動產生(Version:2)
               #確認欄位值在特定區間內
               IF NOT cl_null(g_pjbx3_s.pjbx002) THEN
                  IF g_pjbx3_s.pjbx002 <1000 OR g_pjbx3_s.pjbx002 >9999 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00113'
                     LET g_errparam.extend = g_pjbx3_s.pjbx002
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
   
                     LET g_pjbx3_s.pjbx002 =''
                     NEXT FIELD pjbx002
                  END IF
               END IF
    
            #應用 a02 樣板自動產生(Version:1)
            AFTER FIELD pjbx003
               #應用 a15 樣板自動產生(Version:2)
               #確認欄位值在特定區間內
               IF NOT cl_null(g_pjbx3_s.pjbx003) THEN
                  IF (g_pjbx3_s.pjbx003 < 1) OR (g_pjbx3_s.pjbx003 > 12) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00127'
                     LET g_errparam.extend = g_pjbx3_s.pjbx003
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
   
                     LET g_pjbx3_s.pjbx003 = ''
                     NEXT FIELD pjbx003
                  END IF
               END IF 
                           
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD pjbx001
            
            #Ctrlp:input.c.pjbx002
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD pjbx002
               
            #Ctrlp:input.c.pjbx003
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD pjbx003
               
            AFTER INPUT
            
         END INPUT
             
         ON ACTION accept
            CALL apji115_upd_pjbx_s03()
             
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
   DROP TABLE apji115_s03_tmp
   #畫面關閉
   CLOSE WINDOW w_apji115_s03

END FUNCTION

################################################################################
#1.更新pjbx_t所屬分攤類型的分攤權數=0
#2.計算分攤權數
#   FOREACH BY pjbx_t.專案編號
#       FOREACH pjbx_t.部門
#          抓取部門及其下階部門年度期別的報工資料(pjby_t)
#          部門分攤權數 = 100/sum(專案總工時)*該專案部門總工時
#          Update pjbx_t 的分攤權數 = 部門分攤權數/該專案部門的會科個數
#          更新完後，計算該專案部門的分攤權數加總是否為100，餘額部份更新在第一筆
#       END FOREACH
#   END FOREACH
################################################################################
PRIVATE FUNCTION apji115_upd_pjbx_s03()
DEFINE l_sql         STRING
DEFINE l_sql2        STRING
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_sum         LIKE type_t.num10
DEFINE l_pjby201     LIKE pjby_t.pjby201     #专案工时
DEFINE l_pjby201_sum LIKE pjby_t.pjby201     #專案工時总
DEFINE l_pjbx004     LIKE pjbx_t.pjbx004     #专案编号       2015-10-28 zj add
DEFINE l_pjbx005     LIKE pjbx_t.pjbx005     #会计科目
DEFINE l_pjbx006     LIKE pjbx_t.pjbx006     #部門編號
DEFINE l_pjbx009     LIKE pjbx_t.pjbx009     #分摊权数
DEFINE l_pjbx009_t   LIKE pjbx_t.pjbx009     #分摊权数
DEFINE l_success     LIKE type_t.num5
DEFINE l_sum_g       LIKE type_t.num5        #记录每一笔分摊权数
DEFINE l_pjbxmoddt   LIKE pjbx_t.pjbxmoddt

WHENEVER ERROR CONTINUE
   LET l_success = TRUE

   #1.更新pjbx_t畫面條件的分攤權數為0
   LET l_cnt = 0
   LET l_sum_g = 0
   #1-1根據分攤類型抓出所有資料
   SELECT COUNT(*) INTO l_cnt
     FROM pjbx_t
    WHERE pjbx001 = g_pjbx3_s.pjbx001
      AND pjbxent = g_enterprise
      AND pjbx002 = g_pjbx3_s.pjbx002           #2015-10-28 zj add
      AND pjbx003 = g_pjbx3_s.pjbx003           #2015-10-28 zj add
      AND pjbxstus = 'Y'
   #若無值，return
   IF cl_null(l_cnt) OR l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apj-00055'         #未查詢到該分壇類型+年度+期別的資料！
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN
   END IF
   #啟用事務
   CALL s_transaction_begin()
   #若有值，update pjbx009 = 0
   UPDATE pjbx_t
      SET pjbx009 = 0
    WHERE pjbx001 = g_pjbx3_s.pjbx001
      AND pjbxent = g_enterprise
      AND pjbx002 = g_pjbx3_s.pjbx002           #2015-10-28 zj add
      AND pjbx003 = g_pjbx3_s.pjbx003           #2015-10-28 zj add
      AND pjbxstus = 'Y'
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE pjbx_t:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN
   END IF
   LET l_pjbxmoddt = cl_get_current()
   #2.計算分攤權數
   #2-1 FOREACH DISTINCT 專案編號pjbx004，專案總工時SUM(pjby201)
   #2015-10-28 zj mod 计算为当月所有专案，而不是当前画面的专案
   #2015-10-30 zj marked ：更改为先统计部门总工时，再抓取部門投入於各工案的工時為何，再分摊-------(S)
#   LET l_sql = " SELECT DISTINCT pjby004,SUM(COALESCE(pjby201,0)) ",
#               " FROM pjby_t ",
#               " WHERE pjbyent = ",g_enterprise,
#               "   AND TO_CHAR(pjby001,'YYYY') = ",g_pjbx3_s.pjbx002," AND TO_CHAR(pjby001,'MM') = ",g_pjbx3_s.pjbx003," ",
##               "   AND pjby004 = '",g_pjbx_m.pjbx004,"' ",                            #2015-10-28 zj marked
#               "   AND pjby004 IN ",                                 #2015-10-28 zj add----(s)
#               "   (SELECT pjbx004 FROM pjbx_t WHERE pjbx001 = '",g_pjbx3_s.pjbx001 ,"' ",
#               "   AND pjbxent = ",g_enterprise,
#               "   AND pjbx002 = ",g_pjbx3_s.pjbx002,
#               "   AND pjbx003 = ",g_pjbx3_s.pjbx003,
#               "   AND pjbxstus = 'Y') ",                             #2015-10-28 zj add----(e)
#               "   AND pjbystus = 'Y' ",
#               " GROUP BY pjby004 ",            #2015-10-28 zj add
#               " ORDER BY pjby004 "             #2015-10-28 zj add
##               "   AND pjbysite = '",g_site,"' "
#   PREPARE s03_pjbx004_pre FROM l_sql
#   DECLARE s03_pjbx004_cur CURSOR FOR s03_pjbx004_pre   
#   FOREACH s03_pjbx004_cur INTO l_pjbx004,l_pjby201_sum        #2015-10-28 zj mod
   #2015-10-30 zj marked ：更改为先统计部门总工时，再抓取部門投入於各工案的工時為何，再分摊-------(E)
   #2015-10-30 zj add ：更改为先统计部门总工时，再抓取部門投入於各工案的工時為何，再分摊-------(S)
   LET l_sql = " SELECT DISTINCT pjby003 FROM pjby_t ",
               " WHERE pjbyent = ",g_enterprise,
               " AND TO_CHAR(pjby001,'YYYY') = ",g_pjbx3_s.pjbx002," AND TO_CHAR(pjby001,'MM') = ",g_pjbx3_s.pjbx003," ",
               " AND pjby003 IN (SELECT pjbx006 FROM pjbx_t WHERE pjbx001 = '",g_pjbx3_s.pjbx001 ,"' ",
               "   AND pjbxent = ",g_enterprise,
               "   AND pjbx002 = ",g_pjbx3_s.pjbx002,
               "   AND pjbx003 = ",g_pjbx3_s.pjbx003,
               "   AND pjbxstus = 'Y') ",                             
               "   AND pjbystus = 'Y' "
   PREPARE s03_pjby003_pre FROM l_sql
   DECLARE s03_pjby003_cur CURSOR FOR s03_pjby003_pre
   FOREACH s03_pjby003_cur INTO l_pjbx006
      CALL apji115_get_pjby201(l_pjbx006,' ') RETURNING l_pjby201,l_cnt　      #获取下阶部门，统计总工时
      #根据部门编号，抓取专案总工时l_pjby201_sum
      LET l_sql2 = " SELECT DISTINCT pjby004,SUM(COALESCE(pjby201,0)) ",
                   " FROM pjby_t ",
                   " WHERE pjbyent = ",g_enterprise,
                   "   AND TO_CHAR(pjby001,'YYYY') = ",g_pjbx3_s.pjbx002," AND TO_CHAR(pjby001,'MM') = ",g_pjbx3_s.pjbx003," ",
                   "   AND pjby004 IN ",                                 #2015-10-28 zj add----(s)
                   "   (SELECT pjbx004 FROM pjbx_t WHERE pjbx001 = '",g_pjbx3_s.pjbx001 ,"' ",
                   "   AND pjbxent = ",g_enterprise,
                   "   AND pjbx002 = ",g_pjbx3_s.pjbx002,
                   "   AND pjbx003 = ",g_pjbx3_s.pjbx003,
                   "   AND pjbxstus = 'Y') ",                             #2015-10-28 zj add----(e)
                   "   AND pjby003 = '",l_pjbx006 CLIPPED,"' ",
                   "   AND pjbystus = 'Y' ",
                   " GROUP BY pjby004 ",            #2015-10-28 zj add
                   " ORDER BY pjby004 "             #2015-10-28 zj add
      LET l_sum_g = 0                               #2015-11-2 zj add
      PREPARE s03_pjby004_pre FROM l_sql2
      DECLARE s03_pjby004_cur CURSOR FOR s03_pjby004_pre   
      FOREACH s03_pjby004_cur INTO l_pjbx004,l_pjby201_sum
   #2015-10-30 zj add ：更改为先统计部门总工时，再抓取部門投入於各工案的工時為何，再分摊-------(E)
#   FOREACH s03_pjbx004_cur INTO l_pjby201_sum
   #2-1-1 FOREACH DISTINCT 部門pjbx006
      #2015-10-30 zj mod ：更改为先统计部门总工时，再抓取部門投入於各工案的工時為何，再分摊-------(S)
#         LET l_sum_g = 0                                          #2015-10-28 zj add
         IF l_pjby201_sum = 0 OR cl_null(l_pjby201_sum) THEN  #专案总工时为0
            #该专案编号未维护报工工时资料！
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apj-00061'         
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            LET l_success = FALSE
            CONTINUE FOREACH
   #         RETURN                                               #2015-10-28 zj marked 报工时数为0，只提示，不强制离开
         END IF
         #2015-10-30 zj marked ：更改为先统计部门总工时，再抓取部門投入於各工案的工時為何，再分摊-------(S)
#      LET l_sql2 = " SELECT DISTINCT pjbx006 ",
#                   "   FROM pjbx_t ",
#                   "  WHERE pjbx001 = '",g_pjbx3_s.pjbx001 CLIPPED,"' AND pjbxent = ",g_enterprise,
#                   "    AND pjbx002 = '",g_pjbx3_s.pjbx002 CLIPPED,"' AND pjbx003 = '",g_pjbx3_s.pjbx003 CLIPPED,"' ",
#                   "    AND pjbxstus = 'Y' ",
##                   "    AND pjbx004 = '",g_pjbx_m.pjbx004,"' "
#                   "    AND pjbx004 = '",l_pjbx004,"' "        #2015-10-28 zj mod
#      PREPARE s03_pjbx006_pre FROM l_sql2
#      DECLARE s03_pjbx006_cur CURSOR FOR s03_pjbx006_pre   
#      FOREACH s03_pjbx006_cur INTO l_pjbx006
#      #2-1-1-1 抓取部門及下階部門年度期別的報工資料
##         CALL apji115_get_pjby201(l_pjbx006,g_pjbx_m.pjbx004) RETURNING l_pjby201,l_cnt　
#         CALL apji115_get_pjby201(l_pjbx006,l_pjbx004) RETURNING l_pjby201,l_cnt　      #2015-10-28 zj mod
         #2015-10-30 zj marked ：更改为先统计部门总工时，再抓取部門投入於各工案的工時為何，再分摊-------(E)
         #部門分攤權數 = 100/sum(專案總工時)*該專案部門總工時(该专案中此部门的总工时)
#         LET l_pjbx009_t = l_pjby201/l_pjby201_sum*100        #2015-10-30 zj marked
         LET l_pjbx009_t = l_pjby201_sum/l_pjby201*100         #2015-10-30 zj mod 当前部门专案工时/当前部门总工时
         #2015-10-30 zj mod ：更改为先统计部门总工时，再抓取部門投入於各工案的工時為何，再分摊-------(E)
         #Update pjbx_t 的分攤權數 = 部門分攤權數/該專案部門的會科個數
#         SELECT COUNT(pjbx005) INTO l_cnt       #计算会计科目个数
#           FROM pjbx_t                    
#          WHERE pjbx001 = g_pjbx3_s.pjbx001
#            AND pjbx002 = g_pjbx3_s.pjbx002
#            AND pjbx003 = g_pjbx3_s.pjbx003
#            AND pjbx004 = g_pjbx_m.pjbx004
#            AND pjbx006 = l_pjbx006
#         LET l_pjbx009 = l_pjbx009_t/l_cnt        #计算分摊权数：部门分摊权数/该部门会计科目个数---marked by zj 2015-10-22
         LET l_pjbx009 = l_pjbx009_t               #计算分摊权数：部门分摊权数  部门会科权数=部门分摊权数
         UPDATE pjbx_t
            SET pjbx009 = l_pjbx009
              , pjbxmodid = g_user
              , pjbxmoddt = l_pjbxmoddt
          WHERE pjbx001 = g_pjbx3_s.pjbx001
            AND pjbx002 = g_pjbx3_s.pjbx002
            AND pjbx003 = g_pjbx3_s.pjbx003
#            AND pjbx004 = g_pjbx_m.pjbx004
            AND pjbx004 = l_pjbx004                      #2015-10-28 zj mod
            AND pjbxstus = 'Y'      #下层部门包含在更新列表中
            AND pjbx006 IN (SELECT ooeg001 FROM apji115_s03_tmp)
              
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "UPDATE pjbx_t:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            LET l_success = FALSE
            RETURN
         END IF
         LET l_sum_g = l_sum_g + l_pjbx009 
         #更新完後，計算該專案部門的分攤權數加總是否為其比例，差額部份更新在第一筆
#         SELECT SUM(pjbx009) INTO l_sum
#           FROM pjbx_t
#          WHERE pjbx001 = g_pjbx3_s.pjbx001
#            AND pjbx002 = g_pjbx3_s.pjbx002
#            AND pjbx003 = g_pjbx3_s.pjbx003
#            AND pjbx004 = g_pjbx_m.pjbx004
#            AND pjbxstus = 'Y'
#            AND pjbx006 = l_pjbx006
#         IF l_sum <> l_pjbx009_t THEN
#            LET l_sum = l_pjbx009_t - l_sum
#            #选出第一笔，给他的pjbx009重新赋值，加上剩余的分摊权数
#            SELECT pjbx005,pjbx009
#              INTO l_pjbx005,l_pjbx009
#              FROM pjbx_t
#             WHERE pjbx001 = g_pjbx3_s.pjbx001
#               AND pjbx002 = g_pjbx3_s.pjbx002
#               AND pjbx003 = g_pjbx3_s.pjbx003
#               AND pjbx004 = g_pjbx_m.pjbx004
#               AND pjbxstus = 'Y'
#               AND pjbx006 = l_pjbx006
#               AND rownum = 1
#            #更新
#            LET l_pjbx009 = l_pjbx009 + l_sum
#            UPDATE pjbx_t
#               SET pjbx009 = l_pjbx009#重新计算
#                 , pjbxmodid = g_user
#                 , pjbxmoddt = g_today
#             WHERE pjbx001 = g_pjbx3_s.pjbx001
#               AND pjbx002 = g_pjbx3_s.pjbx002
#               AND pjbx003 = g_pjbx3_s.pjbx003
#               AND pjbx004 = g_pjbx_m.pjbx004
#               AND pjbxstus = 'Y'
#               AND pjbx005 = l_pjbx005
#               AND pjbx006 = l_pjbx006
#               AND rownum = 1
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = "UPDATE pjbx_t:"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               LET l_success = FALSE
#               CALL s_transaction_end('N','0')
#               RETURN
#            END IF
               
#        END IF
      END FOREACH 
      #更新完後，計算該專案的分攤權數加總是否為100，差額部份更新在第一筆
#      SELECT SUM(pjbx009) INTO l_sum
#        FROM pjbx_t
#       WHERE pjbx001 = g_pjbx3_s.pjbx001
#         AND pjbx002 = g_pjbx3_s.pjbx002
#         AND pjbx003 = g_pjbx3_s.pjbx003
#         AND pjbx004 = g_pjbx_m.pjbx004
#         AND pjbxstus = 'Y'
#       ORDER BY pjbx006
      LET l_sum = 0
#      LET l_sum_g = l_sum_g + 1                          
      IF l_sum_g <> 100 THEN
         LET l_sum = 100 - l_sum_g - 1                   #2015-10-28 zj mod
#         LET l_sum_g = 0                                 #2015-10-28 zj add
         #选出第一笔，给他的pjbx009重新赋值，加上剩余的分摊权数
#         SELECT pjbx005,pjbx009
#           INTO l_pjbx005,l_pjbx009
         SELECT pjbx006,pjbx009
           INTO l_pjbx006,l_pjbx009
           FROM pjbx_t
          WHERE pjbx001 = g_pjbx3_s.pjbx001
            AND pjbx002 = g_pjbx3_s.pjbx002
            AND pjbx003 = g_pjbx3_s.pjbx003
#            AND pjbx004 = g_pjbx_m.pjbx004
            AND pjbx004 = l_pjbx004                      #2015-10-28 zj mod
            AND pjbxent = g_enterprise       #160905-00007#3 add
            AND pjbxstus = 'Y'
            AND rownum = 1
         #更新
         LET l_pjbx009 = l_pjbx009 + l_sum
         UPDATE pjbx_t
            SET pjbx009 = l_pjbx009#重新计算
              , pjbxmodid = g_user
              , pjbxmoddt = l_pjbxmoddt
          WHERE pjbx001 = g_pjbx3_s.pjbx001
            AND pjbx002 = g_pjbx3_s.pjbx002
            AND pjbxent = g_enterprise       #160905-00007#3 add
            AND pjbx003 = g_pjbx3_s.pjbx003
#            AND pjbx004 = g_pjbx_m.pjbx004
            AND pjbx004 = l_pjbx004                      #2015-10-28 zj mod
#            AND pjbx005 = l_pjbx005
            AND pjbxstus = 'Y'
            AND pjbx006 = l_pjbx006
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "UPDATE pjbx_t:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            CALL s_transaction_end('N','0')
            RETURN
         END IF
               
      END IF
   END FOREACH
   #执行成功
   IF l_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00217'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      #結束事務
      CALL s_transaction_end('Y','0')
   END IF
END FUNCTION

################################################################################
# Descriptions...: 获取部门年度期别的报工总工时
# Date & Author..: 2015-9-25 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION apji115_get_pjby201(p_pjbx006,p_pjbx004)
DEFINE p_pjbx006     LIKE pjbx_t.pjbx006
DEFINE p_pjbx004     LIKE pjbx_t.pjbx004
DEFINE l_pjbx005     LIKE pjbx_t.pjbx005
DEFINE l_pjby201     LIKE pjby_t.pjby201
DEFINE l_sum         LIKE type_t.num10
DEFINE l_sql         STRING
DEFINE l_sql2        STRING
DEFINE l_cnt         LIKE type_t.num10

   LET l_sum = 0
   LET l_cnt = 0
   DELETE FROM apji115_s03_tmp;
   #抓部门及其下阶部门
   LET l_sql = " SELECT ooeg001 ",
               "   FROM ooeg_t ",
               "  WHERE ooeg001 IN (",
               " SELECT pjby003 ",
               "   FROM pjby_t ",
               "  WHERE pjbyent = ",g_enterprise,
               "    AND TO_CHAR(pjby001,'YYYY') = ",g_pjbx3_s.pjbx002," AND TO_CHAR(pjby001,'MM') = ",g_pjbx3_s.pjbx003," ",
#               "    AND pjby004 = '",p_pjbx004,"' ",                   #2015-10-30 zhujing marked 先抓部门，后专案
#               "    AND pjbystus = 'Y'  AND pjbysite = '",g_site,"' )",
               "    AND pjbystus = 'Y' )",
               " START WITH ooeg001 = '",p_pjbx006,"' ",
               " CONNECT BY PRIOR ooeg001 = ooeg002 "
   PREPARE s03_ooeg001_pre FROM l_sql
   DECLARE s03_ooeg001_cur CURSOR FOR s03_ooeg001_pre   
   FOREACH s03_ooeg001_cur INTO p_pjbx006
      SELECT SUM(COALESCE(pjby201,0)) INTO l_pjby201
        FROM pjby_t
       WHERE TO_CHAR(pjby001,'YYYY') = g_pjbx3_s.pjbx002
         AND TO_CHAR(pjby001,'MM') = g_pjbx3_s.pjbx003
         AND pjby003 = p_pjbx006
#         AND pjby004 = p_pjbx004                                       #2015-10-30 zhujing marked 先抓部门，后专案
         AND pjbyent = g_enterprise
         AND pjbystus = 'Y'
      IF SQLCA.sqlcode OR cl_null(l_pjby201) THEN
         LET l_pjby201 = 0
      END IF
#      SELECT COUNT(pjbx005) INTO l_pjbx005       #计算会计科目个数       #2015-10-30 zhujing marked 所有会科都是同样分摊权数
#        FROM pjbx_t                    
#       WHERE pjbx001 = g_pjbx3_s.pjbx001
#         AND pjbx002 = g_pjbx3_s.pjbx002
#         AND pjbx003 = g_pjbx3_s.pjbx003
#         AND pjbx004 = p_pjbx004
#         AND pjbx006 = p_pjbx006

      LET l_sum = l_sum + l_pjby201 
#      LET l_cnt = l_cnt + l_pjbx005                                    #2015-10-30 zhujing marked 所有会科都是同样分摊权数
      LET l_sql2 = " INSERT INTO apji115_s03_tmp (ooeg001) VALUES('",p_pjbx006,"' )"
      PREPARE apji115_s03_pre FROM l_sql2
      EXECUTE apji115_s03_pre
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT apji115_s03_tmp:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
   END FOREACH
   RETURN l_sum,l_cnt
END FUNCTION

 
{</section>}
 
