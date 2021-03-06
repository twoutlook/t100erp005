#該程式未解開Section, 採用最新樣板產出!
{<section id="abmt410.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2015-08-12 17:44:35), PR版次:0014(2017-01-13 18:14:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000174
#+ Filename...: abmt410
#+ Description: 料件承認資料維護作業
#+ Creator....: 02295(2014-06-20 11:03:28)
#+ Modifier...: 02574 -SD/PR- 05423
 
{</section>}
 
{<section id="abmt410.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#151125-00015#1  15/11/26 By polly     INSERT前判斷「交易對象料號」為空時給予空白
#151224-00025#1  15/12/29 By tsungyung 手動輸入特徵碼沒有同步新增inam_t[料件產品特徵明細檔](整批修改)
#160314-00009#7  16/03/21 By zhujing   各程式增加产品特征是否需要自动开窗的程式段处理
#160318-00025#27 16/04/29 BY 07900     校验代码重复错误讯息的修改
#160913-00055#1  16/09/18 By lixiang   交易对象栏位开窗调整为q_pmaa001_25
#161221-00064#21 17/01/10 By zhujing   增加pmao000(1-采购，2-销售),用于区分axmi120和apmi120数据显示
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
PRIVATE type type_g_bmif_m        RECORD
       bmif001 LIKE bmif_t.bmif001, 
   bmif004 LIKE bmif_t.bmif004, 
   imaal003a LIKE type_t.chr500, 
   imaal003b LIKE type_t.chr500, 
   imaal004a LIKE type_t.chr500, 
   imaal004b LIKE type_t.chr500, 
   bmif002 LIKE bmif_t.bmif002, 
   bmif002_desc LIKE type_t.chr80, 
   bmif003 LIKE bmif_t.bmif003
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bmif_d        RECORD
       bmif005 LIKE bmif_t.bmif005, 
   bmif005_desc LIKE type_t.chr500, 
   bmif006 LIKE bmif_t.bmif006, 
   bmif007 LIKE bmif_t.bmif007, 
   bmif007_desc LIKE type_t.chr500, 
   bmif008 LIKE bmif_t.bmif008, 
   bmif008_desc LIKE type_t.chr500, 
   bmif008_desc_desc LIKE type_t.chr500, 
   bmif009 LIKE bmif_t.bmif009, 
   bmif009_desc LIKE type_t.chr500, 
   bmif010 LIKE bmif_t.bmif010, 
   bmif011 LIKE bmif_t.bmif011, 
   bmif012 LIKE bmif_t.bmif012, 
   bmif017 LIKE bmif_t.bmif017, 
   bmif018 LIKE bmif_t.bmif018, 
   bmif019 LIKE bmif_t.bmif019, 
   bmif019_desc LIKE type_t.chr500, 
   bmif020 LIKE bmif_t.bmif020, 
   bmif020_desc LIKE type_t.chr500, 
   bmif013 LIKE bmif_t.bmif013, 
   bmif013_desc LIKE type_t.chr500, 
   bmif014 LIKE bmif_t.bmif014, 
   bmif015 LIKE bmif_t.bmif015, 
   bmif016 LIKE bmif_t.bmif016
       END RECORD
PRIVATE TYPE type_g_bmif2_d RECORD
       bmif005 LIKE bmif_t.bmif005, 
   bmif006 LIKE bmif_t.bmif006, 
   bmif007 LIKE bmif_t.bmif007, 
   bmif008 LIKE bmif_t.bmif008, 
   bmifownid LIKE bmif_t.bmifownid, 
   bmifownid_desc LIKE type_t.chr500, 
   bmifowndp LIKE bmif_t.bmifowndp, 
   bmifowndp_desc LIKE type_t.chr500, 
   bmifcrtid LIKE bmif_t.bmifcrtid, 
   bmifcrtid_desc LIKE type_t.chr500, 
   bmifcrtdp LIKE bmif_t.bmifcrtdp, 
   bmifcrtdp_desc LIKE type_t.chr500, 
   bmifcrtdt DATETIME YEAR TO SECOND, 
   bmifmodid LIKE bmif_t.bmifmodid, 
   bmifmodid_desc LIKE type_t.chr500, 
   bmifmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#DEFINE g_e_bas_0011      LIKE type_t.chr1
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_bmif_m          type_g_bmif_m
DEFINE g_bmif_m_t        type_g_bmif_m
DEFINE g_bmif_m_o        type_g_bmif_m
DEFINE g_bmif_m_mask_o   type_g_bmif_m #轉換遮罩前資料
DEFINE g_bmif_m_mask_n   type_g_bmif_m #轉換遮罩後資料
 
   DEFINE g_bmif001_t LIKE bmif_t.bmif001
DEFINE g_bmif004_t LIKE bmif_t.bmif004
DEFINE g_bmif002_t LIKE bmif_t.bmif002
DEFINE g_bmif003_t LIKE bmif_t.bmif003
 
 
DEFINE g_bmif_d          DYNAMIC ARRAY OF type_g_bmif_d
DEFINE g_bmif_d_t        type_g_bmif_d
DEFINE g_bmif_d_o        type_g_bmif_d
DEFINE g_bmif_d_mask_o   DYNAMIC ARRAY OF type_g_bmif_d #轉換遮罩前資料
DEFINE g_bmif_d_mask_n   DYNAMIC ARRAY OF type_g_bmif_d #轉換遮罩後資料
DEFINE g_bmif2_d   DYNAMIC ARRAY OF type_g_bmif2_d
DEFINE g_bmif2_d_t type_g_bmif2_d
DEFINE g_bmif2_d_o type_g_bmif2_d
DEFINE g_bmif2_d_mask_o   DYNAMIC ARRAY OF type_g_bmif2_d #轉換遮罩前資料
DEFINE g_bmif2_d_mask_n   DYNAMIC ARRAY OF type_g_bmif2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_bmif001 LIKE bmif_t.bmif001,
      b_bmif002 LIKE bmif_t.bmif002,
   b_bmif002_desc LIKE type_t.chr80,
      b_bmif003 LIKE bmif_t.bmif003,
      b_bmif004 LIKE bmif_t.bmif004
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
 
{<section id="abmt410.main" >}
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
   CALL cl_ap_init("abm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT bmif001,bmif004,'','','','',bmif002,'',bmif003", 
                      " FROM bmif_t",
                      " WHERE bmifent= ? AND bmif001=? AND bmif002=? AND bmif003=? AND bmif004=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abmt410_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bmif001,t0.bmif004,t0.bmif002,t0.bmif003,t1.oocql004",
               " FROM bmif_t t0",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='221' AND t1.oocql002=t0.bmif002 AND t1.oocql003='"||g_dlang||"' ",
 
               " WHERE t0.bmifent = " ||g_enterprise|| " AND t0.bmif001 = ? AND t0.bmif002 = ? AND t0.bmif003 = ? AND t0.bmif004 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abmt410_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abmt410 WITH FORM cl_ap_formpath("abm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abmt410_init()   
 
      #進入選單 Menu (="N")
      CALL abmt410_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abmt410
      
   END IF 
   
   CLOSE abmt410_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abmt410.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abmt410_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('bmif006','2014') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('bmif006_2','2014','1,2')
   CALL cl_set_combo_scc_part('bmif006','2014','1,2') 
#   CALL cl_get_para(g_enterprise,g_site,'E-BAS-0011') RETURNING g_e_bas_0011
#   IF g_e_bas_0011 = 'Y' THEN 
#      CALL cl_set_act_visible("insert,modify,modify_detail,delete,reproduce",FALSE)
#   END IF   
   #160314-00009#7 zhujing add 2016-3-21---(S)
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("bmif005,bmif005_desc",FALSE)
   END IF
   #160314-00009#7 zhujing add 2016-3-21---(E)
   #end add-point
   
   CALL abmt410_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abmt410.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abmt410_ui_dialog()
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
         INITIALIZE g_bmif_m.* TO NULL
         CALL g_bmif_d.clear()
         CALL g_bmif2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abmt410_init()
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
               CALL abmt410_idx_chk()
               CALL abmt410_fetch('') # reload data
               LET g_detail_idx = 1
               CALL abmt410_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_bmif_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL abmt410_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL abmt410_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_bmif2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL abmt410_idx_chk()
               CALL abmt410_ui_detailshow()
               
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
            CALL abmt410_browser_fill("")
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
               CALL abmt410_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abmt410_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL abmt410_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abmt410_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmt410_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abmt410_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmt410_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abmt410_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmt410_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abmt410_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmt410_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abmt410_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmt410_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_bmif_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_bmif2_d)
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
               NEXT FIELD bmif005
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
               CALL abmt410_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL abmt410_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL abmt410_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abmt410_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abmt410_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abmt410_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = "bmifent =",g_enterprise," AND bmif001 ='",g_bmif_m.bmif001,"'",
                              " AND bmif002 ='",g_bmif_m.bmif002,"' AND bmif003 = '",g_bmif_m.bmif003,"'",
                              " AND bmif004 ='",g_bmif_m.bmif004,"'"
               #END add-point
               &include "erp/abm/abmt410_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = "bmifent =",g_enterprise," AND bmif001 ='",g_bmif_m.bmif001,"'",
                              " AND bmif002 ='",g_bmif_m.bmif002,"' AND bmif003 = '",g_bmif_m.bmif003,"'",
                              " AND bmif004 ='",g_bmif_m.bmif004,"'"
               #END add-point
               &include "erp/abm/abmt410_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abmt410_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abmt410_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abmt410_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abmt410_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abmt410_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abmt410_set_pk_array()
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
 
{<section id="abmt410.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION abmt410_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abmt410.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abmt410_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "bmif001,bmif002,bmif003,bmif004"
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
      LET l_sub_sql = " SELECT DISTINCT bmif001 ",
                      ", bmif002 ",
                      ", bmif003 ",
                      ", bmif004 ",
 
                      " FROM bmif_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE bmifent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bmif_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bmif001 ",
                      ", bmif002 ",
                      ", bmif003 ",
                      ", bmif004 ",
 
                      " FROM bmif_t ",
                      " ",
                      " ", 
 
 
                      " WHERE bmifent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bmif_t")
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
      INITIALIZE g_bmif_m.* TO NULL
      CALL g_bmif_d.clear()        
      CALL g_bmif2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bmif001,t0.bmif002,t0.bmif003,t0.bmif004 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.bmif001,t0.bmif002,t0.bmif003,t0.bmif004,t1.oocql004",
                " FROM bmif_t t0",
                #" ",
                " ",
 
 
 
                               " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='221' AND t1.oocql002=t0.bmif002 AND t1.oocql003='"||g_dlang||"' ",
 
                " WHERE t0.bmifent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("bmif_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"bmif_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_bmif001,g_browser[g_cnt].b_bmif002,g_browser[g_cnt].b_bmif003, 
          g_browser[g_cnt].b_bmif004,g_browser[g_cnt].b_bmif002_desc 
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
         CALL abmt410_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_bmif001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_bmif_m.* TO NULL
      CALL g_bmif_d.clear()
      CALL g_bmif2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL abmt410_fetch('')
   
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
 
{<section id="abmt410.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abmt410_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bmif_m.bmif001 = g_browser[g_current_idx].b_bmif001   
   LET g_bmif_m.bmif002 = g_browser[g_current_idx].b_bmif002   
   LET g_bmif_m.bmif003 = g_browser[g_current_idx].b_bmif003   
   LET g_bmif_m.bmif004 = g_browser[g_current_idx].b_bmif004   
 
   EXECUTE abmt410_master_referesh USING g_bmif_m.bmif001,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif004 INTO g_bmif_m.bmif001, 
       g_bmif_m.bmif004,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif002_desc
   CALL abmt410_show()
   
END FUNCTION
 
{</section>}
 
{<section id="abmt410.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abmt410_ui_detailshow()
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
 
{<section id="abmt410.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abmt410_ui_browser_refresh()
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
      IF g_browser[l_i].b_bmif001 = g_bmif_m.bmif001 
         AND g_browser[l_i].b_bmif002 = g_bmif_m.bmif002 
         AND g_browser[l_i].b_bmif003 = g_bmif_m.bmif003 
         AND g_browser[l_i].b_bmif004 = g_bmif_m.bmif004 
 
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
 
{<section id="abmt410.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abmt410_construct()
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
   INITIALIZE g_bmif_m.* TO NULL
   CALL g_bmif_d.clear()
   CALL g_bmif2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON bmif001,bmif004,bmif002,bmif003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.bmif001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif001
            #add-point:ON ACTION controlp INFIELD bmif001 name="construct.c.bmif001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmif001  #顯示到畫面上
            NEXT FIELD bmif001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif001
            #add-point:BEFORE FIELD bmif001 name="construct.b.bmif001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif001
            
            #add-point:AFTER FIELD bmif001 name="construct.a.bmif001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmif004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif004
            #add-point:ON ACTION controlp INFIELD bmif004 name="construct.c.bmif004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmif004  #顯示到畫面上
            NEXT FIELD bmif004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif004
            #add-point:BEFORE FIELD bmif004 name="construct.b.bmif004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif004
            
            #add-point:AFTER FIELD bmif004 name="construct.a.bmif004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmif002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif002
            #add-point:ON ACTION controlp INFIELD bmif002 name="construct.c.bmif002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "221" 
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmif002  #顯示到畫面上
            NEXT FIELD bmif002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif002
            #add-point:BEFORE FIELD bmif002 name="construct.b.bmif002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif002
            
            #add-point:AFTER FIELD bmif002 name="construct.a.bmif002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif003
            #add-point:BEFORE FIELD bmif003 name="construct.b.bmif003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif003
            
            #add-point:AFTER FIELD bmif003 name="construct.a.bmif003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmif003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif003
            #add-point:ON ACTION controlp INFIELD bmif003 name="construct.c.bmif003"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON bmif005,bmif005_desc,bmif006,bmif007,bmif008,bmif009,bmif010,bmif011, 
          bmif012,bmif017,bmif018,bmif019,bmif020,bmif013,bmif014,bmif015,bmif016,bmifownid,bmifowndp, 
          bmifcrtid,bmifcrtdp,bmifcrtdt,bmifmodid,bmifmoddt
           FROM s_detail1[1].bmif005,s_detail1[1].bmif005_desc,s_detail1[1].bmif006,s_detail1[1].bmif007, 
               s_detail1[1].bmif008,s_detail1[1].bmif009,s_detail1[1].bmif010,s_detail1[1].bmif011,s_detail1[1].bmif012, 
               s_detail1[1].bmif017,s_detail1[1].bmif018,s_detail1[1].bmif019,s_detail1[1].bmif020,s_detail1[1].bmif013, 
               s_detail1[1].bmif014,s_detail1[1].bmif015,s_detail1[1].bmif016,s_detail2[1].bmifownid, 
               s_detail2[1].bmifowndp,s_detail2[1].bmifcrtid,s_detail2[1].bmifcrtdp,s_detail2[1].bmifcrtdt, 
               s_detail2[1].bmifmodid,s_detail2[1].bmifmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bmifcrtdt>>----
         AFTER FIELD bmifcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bmifmoddt>>----
         AFTER FIELD bmifmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bmifcnfdt>>----
         
         #----<<bmifpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif005
            #add-point:BEFORE FIELD bmif005 name="construct.b.page1.bmif005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif005
            
            #add-point:AFTER FIELD bmif005 name="construct.a.page1.bmif005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmif005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif005
            #add-point:ON ACTION controlp INFIELD bmif005 name="construct.c.page1.bmif005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif005_desc
            #add-point:BEFORE FIELD bmif005_desc name="construct.b.page1.bmif005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif005_desc
            
            #add-point:AFTER FIELD bmif005_desc name="construct.a.page1.bmif005_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmif005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif005_desc
            #add-point:ON ACTION controlp INFIELD bmif005_desc name="construct.c.page1.bmif005_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif006
            #add-point:BEFORE FIELD bmif006 name="construct.b.page1.bmif006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif006
            
            #add-point:AFTER FIELD bmif006 name="construct.a.page1.bmif006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmif006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif006
            #add-point:ON ACTION controlp INFIELD bmif006 name="construct.c.page1.bmif006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bmif007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif007
            #add-point:ON ACTION controlp INFIELD bmif007 name="construct.c.page1.bmif007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001()                           #呼叫開窗 #160913-00055#1 
            CALL q_pmaa001_25()        #160913-00055#1 
            DISPLAY g_qryparam.return1 TO bmif007  #顯示到畫面上
            NEXT FIELD bmif007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif007
            #add-point:BEFORE FIELD bmif007 name="construct.b.page1.bmif007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif007
            
            #add-point:AFTER FIELD bmif007 name="construct.a.page1.bmif007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmif008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif008
            #add-point:ON ACTION controlp INFIELD bmif008 name="construct.c.page1.bmif008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmao004_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmif008  #顯示到畫面上
            NEXT FIELD bmif008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif008
            #add-point:BEFORE FIELD bmif008 name="construct.b.page1.bmif008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif008
            
            #add-point:AFTER FIELD bmif008 name="construct.a.page1.bmif008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmif009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif009
            #add-point:ON ACTION controlp INFIELD bmif009 name="construct.c.page1.bmif009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "1116" 
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmif009  #顯示到畫面上
            NEXT FIELD bmif009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif009
            #add-point:BEFORE FIELD bmif009 name="construct.b.page1.bmif009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif009
            
            #add-point:AFTER FIELD bmif009 name="construct.a.page1.bmif009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif010
            #add-point:BEFORE FIELD bmif010 name="construct.b.page1.bmif010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif010
            
            #add-point:AFTER FIELD bmif010 name="construct.a.page1.bmif010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmif010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif010
            #add-point:ON ACTION controlp INFIELD bmif010 name="construct.c.page1.bmif010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif011
            #add-point:BEFORE FIELD bmif011 name="construct.b.page1.bmif011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif011
            
            #add-point:AFTER FIELD bmif011 name="construct.a.page1.bmif011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmif011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif011
            #add-point:ON ACTION controlp INFIELD bmif011 name="construct.c.page1.bmif011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bmif012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif012
            #add-point:ON ACTION controlp INFIELD bmif012 name="construct.c.page1.bmif012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bmia015()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmif012  #顯示到畫面上
            NEXT FIELD bmif012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif012
            #add-point:BEFORE FIELD bmif012 name="construct.b.page1.bmif012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif012
            
            #add-point:AFTER FIELD bmif012 name="construct.a.page1.bmif012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif017
            #add-point:BEFORE FIELD bmif017 name="construct.b.page1.bmif017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif017
            
            #add-point:AFTER FIELD bmif017 name="construct.a.page1.bmif017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmif017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif017
            #add-point:ON ACTION controlp INFIELD bmif017 name="construct.c.page1.bmif017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif018
            #add-point:BEFORE FIELD bmif018 name="construct.b.page1.bmif018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif018
            
            #add-point:AFTER FIELD bmif018 name="construct.a.page1.bmif018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmif018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif018
            #add-point:ON ACTION controlp INFIELD bmif018 name="construct.c.page1.bmif018"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bmif019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif019
            #add-point:ON ACTION controlp INFIELD bmif019 name="construct.c.page1.bmif019"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmif019  #顯示到畫面上
            NEXT FIELD bmif019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif019
            #add-point:BEFORE FIELD bmif019 name="construct.b.page1.bmif019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif019
            
            #add-point:AFTER FIELD bmif019 name="construct.a.page1.bmif019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmif020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif020
            #add-point:ON ACTION controlp INFIELD bmif020 name="construct.c.page1.bmif020"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmif020  #顯示到畫面上
            NEXT FIELD bmif020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif020
            #add-point:BEFORE FIELD bmif020 name="construct.b.page1.bmif020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif020
            
            #add-point:AFTER FIELD bmif020 name="construct.a.page1.bmif020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmif013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif013
            #add-point:ON ACTION controlp INFIELD bmif013 name="construct.c.page1.bmif013"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "210" 
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmif013  #顯示到畫面上
            NEXT FIELD bmif013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif013
            #add-point:BEFORE FIELD bmif013 name="construct.b.page1.bmif013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif013
            
            #add-point:AFTER FIELD bmif013 name="construct.a.page1.bmif013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif014
            #add-point:BEFORE FIELD bmif014 name="construct.b.page1.bmif014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif014
            
            #add-point:AFTER FIELD bmif014 name="construct.a.page1.bmif014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmif014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif014
            #add-point:ON ACTION controlp INFIELD bmif014 name="construct.c.page1.bmif014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif015
            #add-point:BEFORE FIELD bmif015 name="construct.b.page1.bmif015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif015
            
            #add-point:AFTER FIELD bmif015 name="construct.a.page1.bmif015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmif015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif015
            #add-point:ON ACTION controlp INFIELD bmif015 name="construct.c.page1.bmif015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif016
            #add-point:BEFORE FIELD bmif016 name="construct.b.page1.bmif016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif016
            
            #add-point:AFTER FIELD bmif016 name="construct.a.page1.bmif016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmif016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif016
            #add-point:ON ACTION controlp INFIELD bmif016 name="construct.c.page1.bmif016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bmifownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmifownid
            #add-point:ON ACTION controlp INFIELD bmifownid name="construct.c.page2.bmifownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmifownid  #顯示到畫面上
            NEXT FIELD bmifownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmifownid
            #add-point:BEFORE FIELD bmifownid name="construct.b.page2.bmifownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmifownid
            
            #add-point:AFTER FIELD bmifownid name="construct.a.page2.bmifownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bmifowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmifowndp
            #add-point:ON ACTION controlp INFIELD bmifowndp name="construct.c.page2.bmifowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmifowndp  #顯示到畫面上
            NEXT FIELD bmifowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmifowndp
            #add-point:BEFORE FIELD bmifowndp name="construct.b.page2.bmifowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmifowndp
            
            #add-point:AFTER FIELD bmifowndp name="construct.a.page2.bmifowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bmifcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmifcrtid
            #add-point:ON ACTION controlp INFIELD bmifcrtid name="construct.c.page2.bmifcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmifcrtid  #顯示到畫面上
            NEXT FIELD bmifcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmifcrtid
            #add-point:BEFORE FIELD bmifcrtid name="construct.b.page2.bmifcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmifcrtid
            
            #add-point:AFTER FIELD bmifcrtid name="construct.a.page2.bmifcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bmifcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmifcrtdp
            #add-point:ON ACTION controlp INFIELD bmifcrtdp name="construct.c.page2.bmifcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmifcrtdp  #顯示到畫面上
            NEXT FIELD bmifcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmifcrtdp
            #add-point:BEFORE FIELD bmifcrtdp name="construct.b.page2.bmifcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmifcrtdp
            
            #add-point:AFTER FIELD bmifcrtdp name="construct.a.page2.bmifcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmifcrtdt
            #add-point:BEFORE FIELD bmifcrtdt name="construct.b.page2.bmifcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bmifmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmifmodid
            #add-point:ON ACTION controlp INFIELD bmifmodid name="construct.c.page2.bmifmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmifmodid  #顯示到畫面上
            NEXT FIELD bmifmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmifmodid
            #add-point:BEFORE FIELD bmifmodid name="construct.b.page2.bmifmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmifmodid
            
            #add-point:AFTER FIELD bmifmodid name="construct.a.page2.bmifmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmifmoddt
            #add-point:BEFORE FIELD bmifmoddt name="construct.b.page2.bmifmoddt"
            
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
 
{<section id="abmt410.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abmt410_filter()
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
      CONSTRUCT g_wc_filter ON bmif001,bmif002,bmif003,bmif004
                          FROM s_browse[1].b_bmif001,s_browse[1].b_bmif002,s_browse[1].b_bmif003,s_browse[1].b_bmif004 
 
 
         BEFORE CONSTRUCT
               DISPLAY abmt410_filter_parser('bmif001') TO s_browse[1].b_bmif001
            DISPLAY abmt410_filter_parser('bmif002') TO s_browse[1].b_bmif002
            DISPLAY abmt410_filter_parser('bmif003') TO s_browse[1].b_bmif003
            DISPLAY abmt410_filter_parser('bmif004') TO s_browse[1].b_bmif004
      
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
 
      CALL abmt410_filter_show('bmif001')
   CALL abmt410_filter_show('bmif002')
   CALL abmt410_filter_show('bmif003')
   CALL abmt410_filter_show('bmif004')
 
END FUNCTION
 
{</section>}
 
{<section id="abmt410.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abmt410_filter_parser(ps_field)
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
 
{<section id="abmt410.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abmt410_filter_show(ps_field)
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
   LET ls_condition = abmt410_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abmt410.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abmt410_query()
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
   CALL g_bmif_d.clear()
   CALL g_bmif2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL abmt410_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abmt410_browser_fill(g_wc)
      CALL abmt410_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL abmt410_browser_fill("F")
   
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
      CALL abmt410_fetch("F") 
   END IF
   
   CALL abmt410_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="abmt410.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abmt410_fetch(p_flag)
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
   
   LET g_bmif_m.bmif001 = g_browser[g_current_idx].b_bmif001
   LET g_bmif_m.bmif002 = g_browser[g_current_idx].b_bmif002
   LET g_bmif_m.bmif003 = g_browser[g_current_idx].b_bmif003
   LET g_bmif_m.bmif004 = g_browser[g_current_idx].b_bmif004
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abmt410_master_referesh USING g_bmif_m.bmif001,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif004 INTO g_bmif_m.bmif001, 
       g_bmif_m.bmif004,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif002_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bmif_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_bmif_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_bmif_m_mask_o.* =  g_bmif_m.*
   CALL abmt410_bmif_t_mask()
   LET g_bmif_m_mask_n.* =  g_bmif_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abmt410_set_act_visible()
   CALL abmt410_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_bmif_m_t.* = g_bmif_m.*
   LET g_bmif_m_o.* = g_bmif_m.*
   
   #重新顯示   
   CALL abmt410_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abmt410.insert" >}
#+ 資料新增
PRIVATE FUNCTION abmt410_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_bmif_d.clear()
   CALL g_bmif2_d.clear()
 
 
   INITIALIZE g_bmif_m.* TO NULL             #DEFAULT 設定
   LET g_bmif001_t = NULL
   LET g_bmif002_t = NULL
   LET g_bmif003_t = NULL
   LET g_bmif004_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_bmif_m.bmif004 = "ALL"
 
     
      #add-point:單頭預設值 name="insert.default"
      LET g_bmif_m.bmif002 = ' '
      LET g_bmif_m.bmif003 = ' '
      LET g_bmif_m_t.* = g_bmif_m.*
      #end add-point 
 
      CALL abmt410_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_bmif_m.* TO NULL
         INITIALIZE g_bmif_d TO NULL
         INITIALIZE g_bmif2_d TO NULL
 
         CALL abmt410_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bmif_m.* = g_bmif_m_t.*
         CALL abmt410_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_bmif_d.clear()
      #CALL g_bmif2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abmt410_set_act_visible()
   CALL abmt410_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bmif001_t = g_bmif_m.bmif001
   LET g_bmif002_t = g_bmif_m.bmif002
   LET g_bmif003_t = g_bmif_m.bmif003
   LET g_bmif004_t = g_bmif_m.bmif004
 
   
   #組合新增資料的條件
   LET g_add_browse = " bmifent = " ||g_enterprise|| " AND",
                      " bmif001 = '", g_bmif_m.bmif001, "' "
                      ," AND bmif002 = '", g_bmif_m.bmif002, "' "
                      ," AND bmif003 = '", g_bmif_m.bmif003, "' "
                      ," AND bmif004 = '", g_bmif_m.bmif004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abmt410_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL abmt410_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abmt410_master_referesh USING g_bmif_m.bmif001,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif004 INTO g_bmif_m.bmif001, 
       g_bmif_m.bmif004,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif002_desc
   
   #遮罩相關處理
   LET g_bmif_m_mask_o.* =  g_bmif_m.*
   CALL abmt410_bmif_t_mask()
   LET g_bmif_m_mask_n.* =  g_bmif_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bmif_m.bmif001,g_bmif_m.bmif004,g_bmif_m.imaal003a,g_bmif_m.imaal003b,g_bmif_m.imaal004a, 
       g_bmif_m.imaal004b,g_bmif_m.bmif002,g_bmif_m.bmif002_desc,g_bmif_m.bmif003
   
   #功能已完成,通報訊息中心
   CALL abmt410_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abmt410.modify" >}
#+ 資料修改
PRIVATE FUNCTION abmt410_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_bmif_m.bmif001 IS NULL
   OR g_bmif_m.bmif002 IS NULL
   OR g_bmif_m.bmif003 IS NULL
   OR g_bmif_m.bmif004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_bmif001_t = g_bmif_m.bmif001
   LET g_bmif002_t = g_bmif_m.bmif002
   LET g_bmif003_t = g_bmif_m.bmif003
   LET g_bmif004_t = g_bmif_m.bmif004
 
   CALL s_transaction_begin()
   
   OPEN abmt410_cl USING g_enterprise,g_bmif_m.bmif001,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif004
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abmt410_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abmt410_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abmt410_master_referesh USING g_bmif_m.bmif001,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif004 INTO g_bmif_m.bmif001, 
       g_bmif_m.bmif004,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif002_desc
   
   #遮罩相關處理
   LET g_bmif_m_mask_o.* =  g_bmif_m.*
   CALL abmt410_bmif_t_mask()
   LET g_bmif_m_mask_n.* =  g_bmif_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL abmt410_show()
   WHILE TRUE
      LET g_bmif001_t = g_bmif_m.bmif001
      LET g_bmif002_t = g_bmif_m.bmif002
      LET g_bmif003_t = g_bmif_m.bmif003
      LET g_bmif004_t = g_bmif_m.bmif004
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL abmt410_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bmif_m.* = g_bmif_m_t.*
         CALL abmt410_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_bmif_m.bmif001 != g_bmif001_t 
      OR g_bmif_m.bmif002 != g_bmif002_t 
      OR g_bmif_m.bmif003 != g_bmif003_t 
      OR g_bmif_m.bmif004 != g_bmif004_t 
 
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
   CALL abmt410_set_act_visible()
   CALL abmt410_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bmifent = " ||g_enterprise|| " AND",
                      " bmif001 = '", g_bmif_m.bmif001, "' "
                      ," AND bmif002 = '", g_bmif_m.bmif002, "' "
                      ," AND bmif003 = '", g_bmif_m.bmif003, "' "
                      ," AND bmif004 = '", g_bmif_m.bmif004, "' "
 
   #填到對應位置
   CALL abmt410_browser_fill("")
 
   CALL abmt410_idx_chk()
 
   CLOSE abmt410_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abmt410_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="abmt410.input" >}
#+ 資料輸入
PRIVATE FUNCTION abmt410_input(p_cmd)
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
   DEFINE  l_oocq015             LIKE oocq_t.oocq015
   DEFINE  l_bmig010             DATETIME YEAR TO SECOND
   DEFINE  l_bmig018             LIKE bmig_t.bmig018
   DEFINE  l_bmig019             LIKE bmig_t.bmig019   
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
   DISPLAY BY NAME g_bmif_m.bmif001,g_bmif_m.bmif004,g_bmif_m.imaal003a,g_bmif_m.imaal003b,g_bmif_m.imaal004a, 
       g_bmif_m.imaal004b,g_bmif_m.bmif002,g_bmif_m.bmif002_desc,g_bmif_m.bmif003
   
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
   LET g_forupd_sql = "SELECT bmif005,bmif006,bmif007,bmif008,bmif009,bmif010,bmif011,bmif012,bmif017, 
       bmif018,bmif019,bmif020,bmif013,bmif014,bmif015,bmif016,bmif005,bmif006,bmif007,bmif008,bmifownid, 
       bmifowndp,bmifcrtid,bmifcrtdp,bmifcrtdt,bmifmodid,bmifmoddt FROM bmif_t WHERE bmifent=? AND bmif001=?  
       AND bmif002=? AND bmif003=? AND bmif004=? AND bmif005=? AND bmif006=? AND bmif007=? AND bmif008=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abmt410_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abmt410_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abmt410_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_bmif_m.bmif001,g_bmif_m.bmif004,g_bmif_m.bmif002,g_bmif_m.bmif003
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   LET g_errshow = 1 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abmt410.input.head" >}
   
      #單頭段
      INPUT BY NAME g_bmif_m.bmif001,g_bmif_m.bmif004,g_bmif_m.bmif002,g_bmif_m.bmif003 
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
         AFTER FIELD bmif001
            
            #add-point:AFTER FIELD bmif001 name="input.a.bmif001"
            CALL abmt410_imaal_desc(g_bmif_m.bmif001) RETURNING g_bmif_m.imaal003a,g_bmif_m.imaal004a
            DISPLAY BY NAME g_bmif_m.imaal003a,g_bmif_m.imaal004a
            IF NOT cl_null(g_bmif_m.bmif001) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bmif_m.bmif001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaa001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_bmif_m.bmif001 = g_bmif_m_t.bmif001
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmif_m.bmif001) AND NOT cl_null(g_bmif_m.bmif002) AND NOT cl_null(g_bmif_m.bmif003) AND NOT cl_null(g_bmif_m.bmif004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bmif_m.bmif001 != g_bmif001_t  OR g_bmif_m.bmif002 != g_bmif002_t  OR g_bmif_m.bmif003 != g_bmif003_t  OR g_bmif_m.bmif004 != g_bmif004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmif_t WHERE "||"bmifent = '" ||g_enterprise|| "' AND "||"bmif001 = '"||g_bmif_m.bmif001 ||"' AND "|| "bmif002 = '"||g_bmif_m.bmif002 ||"' AND "|| "bmif003 = '"||g_bmif_m.bmif003 ||"' AND "|| "bmif004 = '"||g_bmif_m.bmif004 ||"'",'std-00004',0) THEN 
                     LET g_bmif_m.bmif001 = g_bmif_m_t.bmif001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif001
            #add-point:BEFORE FIELD bmif001 name="input.b.bmif001"
            CALL abmt410_imaal_desc(g_bmif_m.bmif001) RETURNING g_bmif_m.imaal003a,g_bmif_m.imaal004a
            DISPLAY BY NAME g_bmif_m.imaal003a,g_bmif_m.imaal004a
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif001
            #add-point:ON CHANGE bmif001 name="input.g.bmif001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif004
            
            #add-point:AFTER FIELD bmif004 name="input.a.bmif004"
            CALL abmt410_imaal_desc(g_bmif_m.bmif004) RETURNING g_bmif_m.imaal003b,g_bmif_m.imaal004b
            DISPLAY BY NAME g_bmif_m.imaal003b,g_bmif_m.imaal004b
            IF NOT cl_null(g_bmif_m.bmif004) AND g_bmif_m.bmif004 <> 'ALL' THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bmif_m.bmif004
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaa001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_bmif_m.bmif004 = g_bmif_m_t.bmif004
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmif_m.bmif001) AND NOT cl_null(g_bmif_m.bmif002) AND NOT cl_null(g_bmif_m.bmif003) AND NOT cl_null(g_bmif_m.bmif004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bmif_m.bmif001 != g_bmif001_t  OR g_bmif_m.bmif002 != g_bmif002_t  OR g_bmif_m.bmif003 != g_bmif003_t  OR g_bmif_m.bmif004 != g_bmif004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmif_t WHERE "||"bmifent = '" ||g_enterprise|| "' AND "||"bmif001 = '"||g_bmif_m.bmif001 ||"' AND "|| "bmif002 = '"||g_bmif_m.bmif002 ||"' AND "|| "bmif003 = '"||g_bmif_m.bmif003 ||"' AND "|| "bmif004 = '"||g_bmif_m.bmif004 ||"'",'std-00004',0) THEN 
                     LET g_bmif_m.bmif004 = g_bmif_m_t.bmif004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif004
            #add-point:BEFORE FIELD bmif004 name="input.b.bmif004"
            CALL abmt410_imaal_desc(g_bmif_m.bmif004) RETURNING g_bmif_m.imaal003b,g_bmif_m.imaal004b
            DISPLAY BY NAME g_bmif_m.imaal003b,g_bmif_m.imaal004b
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif004
            #add-point:ON CHANGE bmif004 name="input.g.bmif004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif002
            
            #add-point:AFTER FIELD bmif002 name="input.a.bmif002"
            CALL abmt410_oocql004_desc('221',g_bmif_m.bmif002) RETURNING g_bmif_m.bmif002_desc
            DISPLAY BY NAME g_bmif_m.bmif002_desc
           
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmif_m.bmif001) AND NOT cl_null(g_bmif_m.bmif002) AND NOT cl_null(g_bmif_m.bmif003) AND NOT cl_null(g_bmif_m.bmif004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bmif_m.bmif001 != g_bmif001_t  OR g_bmif_m.bmif002 != g_bmif002_t  OR g_bmif_m.bmif003 != g_bmif003_t  OR g_bmif_m.bmif004 != g_bmif004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmif_t WHERE "||"bmifent = '" ||g_enterprise|| "' AND "||"bmif001 = '"||g_bmif_m.bmif001 ||"' AND "|| "bmif002 = '"||g_bmif_m.bmif002 ||"' AND "|| "bmif003 = '"||g_bmif_m.bmif003 ||"' AND "|| "bmif004 = '"||g_bmif_m.bmif004 ||"'",'std-00004',0) THEN 
                     LET g_bmif_m.bmif002 = g_bmif_m_t.bmif002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bmif_m.bmif002) THEN 
               IF NOT s_azzi650_chk_exist('221',g_bmif_m.bmif002) THEN
                  LET g_bmif_m.bmif002 = g_bmif_m_t.bmif002
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_bmif_m.bmif002 = ' '                 
            END IF  

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif002
            #add-point:BEFORE FIELD bmif002 name="input.b.bmif002"
            CALL abmt410_oocql004_desc('221',g_bmif_m.bmif002) RETURNING g_bmif_m.bmif002_desc
            DISPLAY BY NAME g_bmif_m.bmif002_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif002
            #add-point:ON CHANGE bmif002 name="input.g.bmif002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif003
            #add-point:BEFORE FIELD bmif003 name="input.b.bmif003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif003
            
            #add-point:AFTER FIELD bmif003 name="input.a.bmif003"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmif_m.bmif001) AND NOT cl_null(g_bmif_m.bmif002) AND NOT cl_null(g_bmif_m.bmif003) AND NOT cl_null(g_bmif_m.bmif004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bmif_m.bmif001 != g_bmif001_t  OR g_bmif_m.bmif002 != g_bmif002_t  OR g_bmif_m.bmif003 != g_bmif003_t  OR g_bmif_m.bmif004 != g_bmif004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmif_t WHERE "||"bmifent = '" ||g_enterprise|| "' AND "||"bmif001 = '"||g_bmif_m.bmif001 ||"' AND "|| "bmif002 = '"||g_bmif_m.bmif002 ||"' AND "|| "bmif003 = '"||g_bmif_m.bmif003 ||"' AND "|| "bmif004 = '"||g_bmif_m.bmif004 ||"'",'std-00004',0) THEN 
                     LET g_bmif_m.bmif003 = g_bmif_m_t.bmif003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF cl_null(g_bmif_m.bmif003) THEN 
               LET g_bmif_m.bmif003 = ' '
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif003
            #add-point:ON CHANGE bmif003 name="input.g.bmif003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bmif001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif001
            #add-point:ON ACTION controlp INFIELD bmif001 name="input.c.bmif001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmif_m.bmif001             #給予default值
            LET g_qryparam.default2 = "" #g_bmif_m.imaal003 #品名
            LET g_qryparam.default3 = "" #g_bmif_m.imaal004 #規格
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imaa001()                                #呼叫開窗

            LET g_bmif_m.bmif001 = g_qryparam.return1              
            #LET g_bmif_m.imaal003 = g_qryparam.return2 
            #LET g_bmif_m.imaal004 = g_qryparam.return3 
            DISPLAY g_bmif_m.bmif001 TO bmif001              #
            #DISPLAY g_bmif_m.imaal003 TO imaal003 #品名
            #DISPLAY g_bmif_m.imaal004 TO imaal004 #規格
            NEXT FIELD bmif001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bmif004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif004
            #add-point:ON ACTION controlp INFIELD bmif004 name="input.c.bmif004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmif_m.bmif004             #給予default值
            LET g_qryparam.default2 = "" #g_bmif_m.imaal003 #品名
            LET g_qryparam.default3 = "" #g_bmif_m.imaal004 #規格
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imaa001()                                #呼叫開窗

            LET g_bmif_m.bmif004 = g_qryparam.return1              
            #LET g_bmif_m.imaal003 = g_qryparam.return2 
            #LET g_bmif_m.imaal004 = g_qryparam.return3 
            DISPLAY g_bmif_m.bmif004 TO bmif004              #
            #DISPLAY g_bmif_m.imaal003 TO imaal003 #品名
            #DISPLAY g_bmif_m.imaal004 TO imaal004 #規格
            NEXT FIELD bmif004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bmif002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif002
            #add-point:ON ACTION controlp INFIELD bmif002 name="input.c.bmif002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmif_m.bmif002             #給予default值
            LET g_qryparam.default2 = "" #g_bmif_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "221" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_bmif_m.bmif002 = g_qryparam.return1              
            #LET g_bmif_m.oocq002 = g_qryparam.return2 
            DISPLAY g_bmif_m.bmif002 TO bmif002              #
            #DISPLAY g_bmif_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bmif002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bmif003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif003
            #add-point:ON ACTION controlp INFIELD bmif003 name="input.c.bmif003"
            
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
            DISPLAY BY NAME g_bmif_m.bmif001             
                            ,g_bmif_m.bmif002   
                            ,g_bmif_m.bmif003   
                            ,g_bmif_m.bmif004   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
 
               #end add-point
            
               #將遮罩欄位還原
               CALL abmt410_bmif_t_mask_restore('restore_mask_o')
            
               UPDATE bmif_t SET (bmif001,bmif004,bmif002,bmif003) = (g_bmif_m.bmif001,g_bmif_m.bmif004, 
                   g_bmif_m.bmif002,g_bmif_m.bmif003)
                WHERE bmifent = g_enterprise AND bmif001 = g_bmif001_t
                  AND bmif002 = g_bmif002_t
                  AND bmif003 = g_bmif003_t
                  AND bmif004 = g_bmif004_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmif_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmif_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmif_m.bmif001
               LET gs_keys_bak[1] = g_bmif001_t
               LET gs_keys[2] = g_bmif_m.bmif002
               LET gs_keys_bak[2] = g_bmif002_t
               LET gs_keys[3] = g_bmif_m.bmif003
               LET gs_keys_bak[3] = g_bmif003_t
               LET gs_keys[4] = g_bmif_m.bmif004
               LET gs_keys_bak[4] = g_bmif004_t
               LET gs_keys[5] = g_bmif_d[g_detail_idx].bmif005
               LET gs_keys_bak[5] = g_bmif_d_t.bmif005
               LET gs_keys[6] = g_bmif_d[g_detail_idx].bmif006
               LET gs_keys_bak[6] = g_bmif_d_t.bmif006
               LET gs_keys[7] = g_bmif_d[g_detail_idx].bmif007
               LET gs_keys_bak[7] = g_bmif_d_t.bmif007
               LET gs_keys[8] = g_bmif_d[g_detail_idx].bmif008
               LET gs_keys_bak[8] = g_bmif_d_t.bmif008
               CALL abmt410_update_b('bmif_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_bmif_m_t)
                     #LET g_log2 = util.JSON.stringify(g_bmif_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL abmt410_bmif_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               IF cl_null(g_bmif_m.bmif002) THEN LET g_bmif_m.bmif002 = ' ' END IF
               IF cl_null(g_bmif_m.bmif003) THEN LET g_bmif_m.bmif003 = ' ' END IF
               
               IF  NOT cl_null(g_bmif_m.bmif001) AND g_bmif_m.bmif002 IS NOT NULL AND g_bmif_m.bmif003 IS NOT NULL AND NOT cl_null(g_bmif_m.bmif004) THEN 
                  IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bmif_m.bmif001 != g_bmif001_t  OR g_bmif_m.bmif002 != g_bmif002_t  OR g_bmif_m.bmif003 != g_bmif003_t  OR g_bmif_m.bmif004 != g_bmif004_t )) THEN 
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmif_t WHERE "||"bmifent = '" ||g_enterprise|| "' AND "||"bmif001 = '"||g_bmif_m.bmif001 ||"' AND "|| "bmif002 = '"||g_bmif_m.bmif002 ||"' AND "|| "bmif003 = '"||g_bmif_m.bmif003 ||"' AND "|| "bmif004 = '"||g_bmif_m.bmif004 ||"'",'std-00004',0) THEN 
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL abmt410_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_bmif001_t = g_bmif_m.bmif001
           LET g_bmif002_t = g_bmif_m.bmif002
           LET g_bmif003_t = g_bmif_m.bmif003
           LET g_bmif004_t = g_bmif_m.bmif004
 
           
           IF g_bmif_d.getLength() = 0 THEN
              NEXT FIELD bmif005
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="abmt410.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_bmif_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bmif_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abmt410_b_fill(g_wc2) #test 
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
            CALL abmt410_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN abmt410_cl USING g_enterprise,g_bmif_m.bmif001,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif004                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE abmt410_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abmt410_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_bmif_d[l_ac].bmif005 IS NOT NULL
               AND g_bmif_d[l_ac].bmif006 IS NOT NULL
               AND g_bmif_d[l_ac].bmif007 IS NOT NULL
               AND g_bmif_d[l_ac].bmif008 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bmif_d_t.* = g_bmif_d[l_ac].*  #BACKUP
               LET g_bmif_d_o.* = g_bmif_d[l_ac].*  #BACKUP
               CALL abmt410_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL abmt410_set_no_entry_b(l_cmd)
               OPEN abmt410_bcl USING g_enterprise,g_bmif_m.bmif001,
                                                g_bmif_m.bmif002,
                                                g_bmif_m.bmif003,
                                                g_bmif_m.bmif004,
 
                                                g_bmif_d_t.bmif005
                                                ,g_bmif_d_t.bmif006
                                                ,g_bmif_d_t.bmif007
                                                ,g_bmif_d_t.bmif008
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abmt410_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abmt410_bcl INTO g_bmif_d[l_ac].bmif005,g_bmif_d[l_ac].bmif006,g_bmif_d[l_ac].bmif007, 
                      g_bmif_d[l_ac].bmif008,g_bmif_d[l_ac].bmif009,g_bmif_d[l_ac].bmif010,g_bmif_d[l_ac].bmif011, 
                      g_bmif_d[l_ac].bmif012,g_bmif_d[l_ac].bmif017,g_bmif_d[l_ac].bmif018,g_bmif_d[l_ac].bmif019, 
                      g_bmif_d[l_ac].bmif020,g_bmif_d[l_ac].bmif013,g_bmif_d[l_ac].bmif014,g_bmif_d[l_ac].bmif015, 
                      g_bmif_d[l_ac].bmif016,g_bmif2_d[l_ac].bmif005,g_bmif2_d[l_ac].bmif006,g_bmif2_d[l_ac].bmif007, 
                      g_bmif2_d[l_ac].bmif008,g_bmif2_d[l_ac].bmifownid,g_bmif2_d[l_ac].bmifowndp,g_bmif2_d[l_ac].bmifcrtid, 
                      g_bmif2_d[l_ac].bmifcrtdp,g_bmif2_d[l_ac].bmifcrtdt,g_bmif2_d[l_ac].bmifmodid, 
                      g_bmif2_d[l_ac].bmifmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_bmif_d_t.bmif005,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bmif_d_mask_o[l_ac].* =  g_bmif_d[l_ac].*
                  CALL abmt410_bmif_t_mask()
                  LET g_bmif_d_mask_n[l_ac].* =  g_bmif_d[l_ac].*
                  
                  CALL abmt410_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            LET g_bmif_d_o.* = g_bmif_d[l_ac].*
            LET g_bmif_d_t.* = g_bmif_d[l_ac].*
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_bmif_d_t.* TO NULL
            INITIALIZE g_bmif_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bmif_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bmif2_d[l_ac].bmifownid = g_user
      LET g_bmif2_d[l_ac].bmifowndp = g_dept
      LET g_bmif2_d[l_ac].bmifcrtid = g_user
      LET g_bmif2_d[l_ac].bmifcrtdp = g_dept 
      LET g_bmif2_d[l_ac].bmifcrtdt = cl_get_current()
      LET g_bmif2_d[l_ac].bmifmodid = g_user
      LET g_bmif2_d[l_ac].bmifmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
                  LET g_bmif_d[l_ac].bmif006 = "1"
      LET g_bmif_d[l_ac].bmif010 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            LET g_bmif_d[l_ac].bmif011 = g_today
            LET g_bmif_d[l_ac].bmif017 = g_today
            #end add-point
            LET g_bmif_d_t.* = g_bmif_d[l_ac].*     #新輸入資料
            LET g_bmif_d_o.* = g_bmif_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abmt410_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL abmt410_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bmif_d[li_reproduce_target].* = g_bmif_d[li_reproduce].*
               LET g_bmif2_d[li_reproduce_target].* = g_bmif2_d[li_reproduce].*
 
               LET g_bmif_d[g_bmif_d.getLength()].bmif005 = NULL
               LET g_bmif_d[g_bmif_d.getLength()].bmif006 = NULL
               LET g_bmif_d[g_bmif_d.getLength()].bmif007 = NULL
               LET g_bmif_d[g_bmif_d.getLength()].bmif008 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_bmif_d[l_ac].bmif019 = g_user
            LET g_bmif_d[l_ac].bmif020 = g_dept
            CALL abmt410_bmif019_desc()
            CALL abmt410_bmif020_desc()
            LET g_bmif_d_t.* = g_bmif_d[l_ac].*
            LET g_bmif_d_o.* = g_bmif_d[l_ac].*
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
            SELECT COUNT(1) INTO l_count FROM bmif_t 
             WHERE bmifent = g_enterprise AND bmif001 = g_bmif_m.bmif001
               AND bmif002 = g_bmif_m.bmif002
               AND bmif003 = g_bmif_m.bmif003
               AND bmif004 = g_bmif_m.bmif004
 
               AND bmif005 = g_bmif_d[l_ac].bmif005
               AND bmif006 = g_bmif_d[l_ac].bmif006
               AND bmif007 = g_bmif_d[l_ac].bmif007
               AND bmif008 = g_bmif_d[l_ac].bmif008
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               IF cl_null(g_bmif_d[l_ac].bmif008) THEN LET g_bmif_d[l_ac].bmif008 = ' ' END IF   #151125-00015#1 add
               #end add-point
               INSERT INTO bmif_t
                           (bmifent,
                            bmif001,bmif004,bmif002,bmif003,
                            bmif005,bmif006,bmif007,bmif008
                            ,bmif009,bmif010,bmif011,bmif012,bmif017,bmif018,bmif019,bmif020,bmif013,bmif014,bmif015,bmif016,bmifownid,bmifowndp,bmifcrtid,bmifcrtdp,bmifcrtdt,bmifmodid,bmifmoddt) 
                     VALUES(g_enterprise,
                            g_bmif_m.bmif001,g_bmif_m.bmif004,g_bmif_m.bmif002,g_bmif_m.bmif003,
                            g_bmif_d[l_ac].bmif005,g_bmif_d[l_ac].bmif006,g_bmif_d[l_ac].bmif007,g_bmif_d[l_ac].bmif008 
 
                            ,g_bmif_d[l_ac].bmif009,g_bmif_d[l_ac].bmif010,g_bmif_d[l_ac].bmif011,g_bmif_d[l_ac].bmif012, 
                                g_bmif_d[l_ac].bmif017,g_bmif_d[l_ac].bmif018,g_bmif_d[l_ac].bmif019, 
                                g_bmif_d[l_ac].bmif020,g_bmif_d[l_ac].bmif013,g_bmif_d[l_ac].bmif014, 
                                g_bmif_d[l_ac].bmif015,g_bmif_d[l_ac].bmif016,g_bmif2_d[l_ac].bmifownid, 
                                g_bmif2_d[l_ac].bmifowndp,g_bmif2_d[l_ac].bmifcrtid,g_bmif2_d[l_ac].bmifcrtdp, 
                                g_bmif2_d[l_ac].bmifcrtdt,g_bmif2_d[l_ac].bmifmodid,g_bmif2_d[l_ac].bmifmoddt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_bmif_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "bmif_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert"
               IF NOT cl_null(g_bmif2_d[l_ac].bmifmodid) THEN 
                  LET l_bmig018 = g_bmif2_d[l_ac].bmifmodid
                  SELECT ooag003 INTO l_bmig019 FROM ooag_t
                   WHERE ooagent = g_enterprise AND ooag001 = l_bmig018
               ELSE
                  LET l_bmig018 = g_bmif2_d[l_ac].bmifcrtid
                  LET l_bmig019 = g_bmif2_d[l_ac].bmifcrtdp                   
               END IF
               IF NOT cl_null(g_bmif2_d[l_ac].bmifmoddt) THEN 
                  LET l_bmig010 = g_bmif2_d[l_ac].bmifmoddt
               ELSE
                  LET l_bmig010 = g_bmif2_d[l_ac].bmifcrtdt              
               END IF               
               INSERT INTO bmig_t(bmigent,bmig001,bmig002,bmig003,bmig004,bmig005,bmig006,bmig007,bmig008,bmig009,
                                  bmig010,bmig011,bmig012,bmig013,bmig014,bmig015,bmig016,bmig017,bmig018,bmig019)
               VALUES(g_enterprise,g_bmif_m.bmif001,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif004,
                      g_bmif_d[l_ac].bmif005,g_bmif_d[l_ac].bmif006,g_bmif_d[l_ac].bmif007,g_bmif_d[l_ac].bmif008,
                      g_bmif_d[l_ac].bmif009,l_bmig010,g_bmif_d[l_ac].bmif011,g_bmif_d[l_ac].bmif012,
                      g_bmif_d[l_ac].bmif015,g_bmif_d[l_ac].bmif016,'',g_bmif_d[l_ac].bmif017,
                      g_bmif_d[l_ac].bmif018,l_bmig018,l_bmig019)                   
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
               IF abmt410_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_bmif_m.bmif001
                  LET gs_keys[gs_keys.getLength()+1] = g_bmif_m.bmif002
                  LET gs_keys[gs_keys.getLength()+1] = g_bmif_m.bmif003
                  LET gs_keys[gs_keys.getLength()+1] = g_bmif_m.bmif004
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bmif_d_t.bmif005
                  LET gs_keys[gs_keys.getLength()+1] = g_bmif_d_t.bmif006
                  LET gs_keys[gs_keys.getLength()+1] = g_bmif_d_t.bmif007
                  LET gs_keys[gs_keys.getLength()+1] = g_bmif_d_t.bmif008
 
 
                  #刪除下層單身
                  IF NOT abmt410_key_delete_b(gs_keys,'bmif_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE abmt410_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE abmt410_bcl
               LET l_count = g_bmif_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_bmif_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif005
            
            #add-point:AFTER FIELD bmif005 name="input.a.page1.bmif005"
            CALL s_feature_description(g_bmif_m.bmif001,g_bmif_d[l_ac].bmif005) RETURNING g_success,g_bmif_d[l_ac].bmif005_desc
            #此段落由子樣板a05產生
            IF  g_bmif_m.bmif001 IS NOT NULL AND g_bmif_m.bmif002 IS NOT NULL AND g_bmif_m.bmif003 IS NOT NULL AND g_bmif_m.bmif004 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif005 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif006 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif007 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bmif_m.bmif001 != g_bmif001_t OR g_bmif_m.bmif002 != g_bmif002_t OR g_bmif_m.bmif003 != g_bmif003_t OR g_bmif_m.bmif004 != g_bmif004_t OR g_bmif_d[g_detail_idx].bmif005 != g_bmif_d_t.bmif005 OR g_bmif_d[g_detail_idx].bmif006 != g_bmif_d_t.bmif006 OR g_bmif_d[g_detail_idx].bmif007 != g_bmif_d_t.bmif007 OR g_bmif_d[g_detail_idx].bmif008 != g_bmif_d_t.bmif008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmif_t WHERE "||"bmifent = '" ||g_enterprise|| "' AND "||"bmif001 = '"||g_bmif_m.bmif001 ||"' AND "|| "bmif002 = '"||g_bmif_m.bmif002 ||"' AND "|| "bmif003 = '"||g_bmif_m.bmif003 ||"' AND "|| "bmif004 = '"||g_bmif_m.bmif004 ||"' AND "|| "bmif005 = '"||g_bmif_d[g_detail_idx].bmif005 ||"' AND "|| "bmif006 = '"||g_bmif_d[g_detail_idx].bmif006 ||"' AND "|| "bmif007 = '"||g_bmif_d[g_detail_idx].bmif007 ||"' AND "|| "bmif008 = '"||g_bmif_d[g_detail_idx].bmif008 ||"'",'std-00004',0) THEN 
                     LET g_bmif_d[l_ac].bmif005 = g_bmif_d_t.bmif005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bmif_d[l_ac].bmif005) THEN 
               IF NOT s_feature_check(g_bmif_m.bmif001,g_bmif_d[l_ac].bmif005) THEN 
                  LET g_bmif_d[l_ac].bmif005 = g_bmif_d_t.bmif005                 
                  NEXT FIELD CURRENT
               END IF   
               #151224-00025#1 tsungyung --- add start ---
               IF NOT s_feature_direct_input(g_bmif_m.bmif001,g_bmif_d[l_ac].bmif005,g_bmif_d_t.bmif005,'',g_site) THEN
                  NEXT FIELD CURRENT
               END IF   
               #151224-00025#1 tsungyung --- add end   ---               
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bmif_d_o.bmif005 <> g_bmif_d[l_ac].bmif005 OR g_bmif_d_o.bmif005 IS NULL)) THEN 
                  #161221-00064#21 mod-S
#                  CALL abmt410_bmif008_def(g_bmif_m.bmif001,g_bmif_d[l_ac].bmif005) 
                  CALL abmt410_bmif008_def(g_bmif_m.bmif001,g_bmif_d[l_ac].bmif005,g_bmif_d[l_ac].bmif006)     #判断类型
                  #161221-00064#21 mod-E
               END IF
            ELSE  
               LET g_bmif_d[l_ac].bmif005 = ' '            
            END IF
            LET g_bmif_d_o.bmif005 = g_bmif_d[l_ac].bmif005             
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif005
            #add-point:BEFORE FIELD bmif005 name="input.b.page1.bmif005"
            #160314-00009#7 marked by zhujing 2016-3-21-----(S)
#            IF abmt410_imaa005_exists() THEN
            #160314-00009#7 marked by zhujing 2016-3-21-----(E)
            IF s_feature_auto_chk(g_bmif_m.bmif001) THEN    #160314-00009#7 mod by zhujing 2016-3-21
               IF cl_null(g_bmif_d[l_ac].bmif005) THEN
                  CALL s_feature_single(g_bmif_m.bmif001,g_bmif_d[l_ac].bmif005,g_site,'') RETURNING l_success,g_bmif_d[l_ac].bmif005
                  DISPLAY BY NAME g_bmif_d[l_ac].bmif005
               END IF 
               CALL s_feature_description(g_bmif_m.bmif001,g_bmif_d[l_ac].bmif005) RETURNING g_success,g_bmif_d[l_ac].bmif005_desc                  
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif005
            #add-point:ON CHANGE bmif005 name="input.g.page1.bmif005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif005_desc
            #add-point:BEFORE FIELD bmif005_desc name="input.b.page1.bmif005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif005_desc
            
            #add-point:AFTER FIELD bmif005_desc name="input.a.page1.bmif005_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif005_desc
            #add-point:ON CHANGE bmif005_desc name="input.g.page1.bmif005_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif006
            #add-point:BEFORE FIELD bmif006 name="input.b.page1.bmif006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif006
            
            #add-point:AFTER FIELD bmif006 name="input.a.page1.bmif006"
            #此段落由子樣板a05產生
            IF  g_bmif_m.bmif001 IS NOT NULL AND g_bmif_m.bmif002 IS NOT NULL AND g_bmif_m.bmif003 IS NOT NULL AND g_bmif_m.bmif004 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif005 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif006 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif007 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bmif_m.bmif001 != g_bmif001_t OR g_bmif_m.bmif002 != g_bmif002_t OR g_bmif_m.bmif003 != g_bmif003_t OR g_bmif_m.bmif004 != g_bmif004_t OR g_bmif_d[g_detail_idx].bmif005 != g_bmif_d_t.bmif005 OR g_bmif_d[g_detail_idx].bmif006 != g_bmif_d_t.bmif006 OR g_bmif_d[g_detail_idx].bmif007 != g_bmif_d_t.bmif007 OR g_bmif_d[g_detail_idx].bmif008 != g_bmif_d_t.bmif008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmif_t WHERE "||"bmifent = '" ||g_enterprise|| "' AND "||"bmif001 = '"||g_bmif_m.bmif001 ||"' AND "|| "bmif002 = '"||g_bmif_m.bmif002 ||"' AND "|| "bmif003 = '"||g_bmif_m.bmif003 ||"' AND "|| "bmif004 = '"||g_bmif_m.bmif004 ||"' AND "|| "bmif005 = '"||g_bmif_d[g_detail_idx].bmif005 ||"' AND "|| "bmif006 = '"||g_bmif_d[g_detail_idx].bmif006 ||"' AND "|| "bmif007 = '"||g_bmif_d[g_detail_idx].bmif007 ||"' AND "|| "bmif008 = '"||g_bmif_d[g_detail_idx].bmif008 ||"'",'std-00004',0) THEN 
                     LET g_bmif_d[l_ac].bmif006 = g_bmif_d_t.bmif006
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_bmif_d[l_ac].bmif006) AND NOT cl_null(g_bmif_d[l_ac].bmif007) AND g_bmif_d[l_ac].bmif007 <> 'ALL' THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bmif_d[l_ac].bmif007
               
               #呼叫檢查存在並帶值的library
               IF g_bmif_d[l_ac].bmif006 = '1' THEN
                  IF cl_chk_exist("v_pmaa001_1") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_bmif_d[l_ac].bmif007 = ''
                     NEXT FIELD bmif007
                  END IF
               ELSE
                  LET g_chkparam.arg2 = g_site  
                  #160318-00025#27  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
                  #160318-00025#27  by 07900 --add-end                  
                  IF cl_chk_exist("v_pmaa001_3") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_bmif_d[l_ac].bmif007 = ''
                     NEXT FIELD bmif007
                  END IF
               END IF                  
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif006
            #add-point:ON CHANGE bmif006 name="input.g.page1.bmif006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif007
            
            #add-point:AFTER FIELD bmif007 name="input.a.page1.bmif007"
            CALL abmt410_bmif007_desc()
            IF NOT cl_null(g_bmif_d[l_ac].bmif007) AND g_bmif_d[l_ac].bmif007 <> 'ALL' THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bmif_d[l_ac].bmif007
                  
               #呼叫檢查存在並帶值的library
               IF g_bmif_d[l_ac].bmif006 = '1' THEN
                  IF cl_chk_exist("v_pmaa001_1") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_bmif_d[l_ac].bmif007 = g_bmif_d_t.bmif007
                     NEXT FIELD CURRENT
                  END IF
               ELSE   
                  LET g_chkparam.arg2 = g_site
                  #160318-00025#27  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
                  #160318-00025#27  by 07900 --add-end 
                  IF cl_chk_exist("v_pmaa001_3") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_bmif_d[l_ac].bmif007 = g_bmif_d_t.bmif007
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bmif_d[l_ac].bmif007 = 'ALL'                
            END IF 
            #此段落由子樣板a05產生
            IF  g_bmif_m.bmif001 IS NOT NULL AND g_bmif_m.bmif002 IS NOT NULL AND g_bmif_m.bmif003 IS NOT NULL AND g_bmif_m.bmif004 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif005 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif006 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif007 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bmif_m.bmif001 != g_bmif001_t OR g_bmif_m.bmif002 != g_bmif002_t OR g_bmif_m.bmif003 != g_bmif003_t OR g_bmif_m.bmif004 != g_bmif004_t OR g_bmif_d[g_detail_idx].bmif005 != g_bmif_d_t.bmif005 OR g_bmif_d[g_detail_idx].bmif006 != g_bmif_d_t.bmif006 OR g_bmif_d[g_detail_idx].bmif007 != g_bmif_d_t.bmif007 OR g_bmif_d[g_detail_idx].bmif008 != g_bmif_d_t.bmif008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmif_t WHERE "||"bmifent = '" ||g_enterprise|| "' AND "||"bmif001 = '"||g_bmif_m.bmif001 ||"' AND "|| "bmif002 = '"||g_bmif_m.bmif002 ||"' AND "|| "bmif003 = '"||g_bmif_m.bmif003 ||"' AND "|| "bmif004 = '"||g_bmif_m.bmif004 ||"' AND "|| "bmif005 = '"||g_bmif_d[g_detail_idx].bmif005 ||"' AND "|| "bmif006 = '"||g_bmif_d[g_detail_idx].bmif006 ||"' AND "|| "bmif007 = '"||g_bmif_d[g_detail_idx].bmif007 ||"' AND "|| "bmif008 = '"||g_bmif_d[g_detail_idx].bmif008 ||"'",'std-00004',0) THEN 
                     LET g_bmif_d[l_ac].bmif007 = g_bmif_d_t.bmif007
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            SELECT pmao009,pmao010
              INTO g_bmif_d[l_ac].bmif008_desc, g_bmif_d[l_ac].bmif008_desc_desc
              FROM pmao_t
             WHERE pmao001 = g_bmif_d[l_ac].bmif007
               AND pmao002 = g_bmif_m.bmif001
               AND pmao003 = g_bmif_d[l_ac].bmif005
               AND pmao004 = g_bmif_d[l_ac].bmif008 
               AND pmao000 = g_bmif_d[l_ac].bmif006   #161221-00064#21 add               
               AND pmaoent = g_enterprise                      
            DISPLAY BY NAME g_bmif_d[l_ac].bmif008_desc_desc, g_bmif_d[l_ac].bmif008_desc
            CALL abmt410_set_entry_b(l_cmd)
            CALL abmt410_set_no_entry_b(l_cmd)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif007
            #add-point:BEFORE FIELD bmif007 name="input.b.page1.bmif007"
            CALL abmt410_bmif007_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif007
            #add-point:ON CHANGE bmif007 name="input.g.page1.bmif007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif008
            
            #add-point:AFTER FIELD bmif008 name="input.a.page1.bmif008"
            IF g_bmif_d[l_ac].bmif008 IS NOT NULL AND g_bmif_d[l_ac].bmif008 <> ' ' THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bmif_d[l_ac].bmif007
               LET g_chkparam.arg2 = g_bmif_m.bmif001
               LET g_chkparam.arg3 = g_bmif_d[l_ac].bmif005
               LET g_chkparam.arg4 = g_bmif_d[l_ac].bmif008
               #160318-00025#27  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="apm-00397:sub-01302|apmi070|",cl_get_progname("apmi070",g_lang,"2"),"|:EXEPROGapmi070"
               #160318-00025#27  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmao004_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  SELECT pmao009,pmao010
                    INTO g_bmif_d[l_ac].bmif008_desc, g_bmif_d[l_ac].bmif008_desc_desc
                    FROM pmao_t
                   WHERE pmao001 = g_bmif_d[l_ac].bmif007
                     AND pmao002 = g_bmif_m.bmif001
                     AND pmao003 = g_bmif_d[l_ac].bmif005
                     AND pmao004 = g_bmif_d[l_ac].bmif008    
                     AND pmao000 = g_bmif_d[l_ac].bmif006   #161221-00064#21 add               
                     AND pmaoent = g_enterprise                      
                  DISPLAY BY NAME g_bmif_d[l_ac].bmif008_desc_desc, g_bmif_d[l_ac].bmif008_desc   
               ELSE
                  #檢查失敗時後續處理
                  LET g_bmif_d[l_ac].bmif008 = g_bmif_d_t.bmif008
                  LET g_bmif_d[l_ac].bmif008_desc =  g_bmif_d_t.bmif008_desc
               LET g_bmif_d[l_ac].bmif008_desc_desc =  g_bmif_d_t.bmif008_desc_desc
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_bmif_d[l_ac].bmif008 =  ' '  
               LET g_bmif_d[l_ac].bmif008_desc =  ' ' 
               LET g_bmif_d[l_ac].bmif008_desc_desc =  ' '  
               DISPLAY BY NAME g_bmif_d[l_ac].bmif008_desc_desc, g_bmif_d[l_ac].bmif008_desc               
            END IF 


            #此段落由子樣板a05產生
            IF  g_bmif_m.bmif001 IS NOT NULL AND g_bmif_m.bmif002 IS NOT NULL AND g_bmif_m.bmif003 IS NOT NULL AND g_bmif_m.bmif004 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif005 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif006 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif007 IS NOT NULL AND g_bmif_d[g_detail_idx].bmif008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bmif_m.bmif001 != g_bmif001_t OR g_bmif_m.bmif002 != g_bmif002_t OR g_bmif_m.bmif003 != g_bmif003_t OR g_bmif_m.bmif004 != g_bmif004_t OR g_bmif_d[g_detail_idx].bmif005 != g_bmif_d_t.bmif005 OR g_bmif_d[g_detail_idx].bmif006 != g_bmif_d_t.bmif006 OR g_bmif_d[g_detail_idx].bmif007 != g_bmif_d_t.bmif007 OR g_bmif_d[g_detail_idx].bmif008 != g_bmif_d_t.bmif008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmif_t WHERE "||"bmifent = '" ||g_enterprise|| "' AND "||"bmif001 = '"||g_bmif_m.bmif001 ||"' AND "|| "bmif002 = '"||g_bmif_m.bmif002 ||"' AND "|| "bmif003 = '"||g_bmif_m.bmif003 ||"' AND "|| "bmif004 = '"||g_bmif_m.bmif004 ||"' AND "|| "bmif005 = '"||g_bmif_d[g_detail_idx].bmif005 ||"' AND "|| "bmif006 = '"||g_bmif_d[g_detail_idx].bmif006 ||"' AND "|| "bmif007 = '"||g_bmif_d[g_detail_idx].bmif007 ||"' AND "|| "bmif008 = '"||g_bmif_d[g_detail_idx].bmif008 ||"'",'std-00004',0) THEN 
                     LET g_bmif_d[l_ac].bmif008 = g_bmif_d_t.bmif008
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif008
            #add-point:BEFORE FIELD bmif008 name="input.b.page1.bmif008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif008
            #add-point:ON CHANGE bmif008 name="input.g.page1.bmif008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif009
            
            #add-point:AFTER FIELD bmif009 name="input.a.page1.bmif009"
            CALL abmt410_oocql004_desc('1116',g_bmif_d[l_ac].bmif009) RETURNING g_bmif_d[l_ac].bmif009_desc
            DISPLAY BY NAME g_bmif_d[l_ac].bmif009_desc

            IF NOT cl_null(g_bmif_d[l_ac].bmif009) THEN 
               IF NOT s_azzi650_chk_exist('1116',g_bmif_d[l_ac].bmif009) THEN
                  LET g_bmif_d[l_ac].bmif009 = g_bmif_d_t.bmif009
                  NEXT FIELD CURRENT
               END IF
               SELECT oocq015 INTO l_oocq015 FROM oocq_t 
                WHERE oocqent = g_enterprise AND oocq001 = '1116' AND oocq002 = g_bmif_d[l_ac].bmif009
               IF l_oocq015 = 'Y' THEN 
                  LET g_bmif_d[l_ac].bmif010 = 1 
               ELSE
                  LET g_bmif_d[l_ac].bmif010 = 0               
               END IF
            END IF
            CALL abmt410_set_entry_b(l_cmd) 
            CALL abmt410_set_no_entry_b(l_cmd)            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif009
            #add-point:BEFORE FIELD bmif009 name="input.b.page1.bmif009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif009
            #add-point:ON CHANGE bmif009 name="input.g.page1.bmif009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif010
            #add-point:BEFORE FIELD bmif010 name="input.b.page1.bmif010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif010
            
            #add-point:AFTER FIELD bmif010 name="input.a.page1.bmif010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif010
            #add-point:ON CHANGE bmif010 name="input.g.page1.bmif010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif011
            #add-point:BEFORE FIELD bmif011 name="input.b.page1.bmif011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif011
            
            #add-point:AFTER FIELD bmif011 name="input.a.page1.bmif011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif011
            #add-point:ON CHANGE bmif011 name="input.g.page1.bmif011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif012
            #add-point:BEFORE FIELD bmif012 name="input.b.page1.bmif012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif012
            
            #add-point:AFTER FIELD bmif012 name="input.a.page1.bmif012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif012
            #add-point:ON CHANGE bmif012 name="input.g.page1.bmif012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif017
            #add-point:BEFORE FIELD bmif017 name="input.b.page1.bmif017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif017
            
            #add-point:AFTER FIELD bmif017 name="input.a.page1.bmif017"
            IF NOT cl_null(g_bmif_d[l_ac].bmif017) AND NOT cl_null(g_bmif_d[l_ac].bmif018) THEN 
               IF g_bmif_d[l_ac].bmif017 > g_bmif_d[l_ac].bmif018 THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_bmif_d[l_ac].bmif017
                  LET g_errparam.code   = 'abm-00200' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  LET g_bmif_d[l_ac].bmif017 = g_bmif_d_t.bmif017
                  NEXT FIELD CURRENT                  
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif017
            #add-point:ON CHANGE bmif017 name="input.g.page1.bmif017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif018
            #add-point:BEFORE FIELD bmif018 name="input.b.page1.bmif018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif018
            
            #add-point:AFTER FIELD bmif018 name="input.a.page1.bmif018"
            IF NOT cl_null(g_bmif_d[l_ac].bmif017) AND NOT cl_null(g_bmif_d[l_ac].bmif018) THEN 
               IF g_bmif_d[l_ac].bmif017 > g_bmif_d[l_ac].bmif018 THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_bmif_d[l_ac].bmif018
                  LET g_errparam.code   = 'abm-00200' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  LET g_bmif_d[l_ac].bmif018 = g_bmif_d_t.bmif018
                  NEXT FIELD CURRENT                  
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif018
            #add-point:ON CHANGE bmif018 name="input.g.page1.bmif018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif019
            
            #add-point:AFTER FIELD bmif019 name="input.a.page1.bmif019"
            CALL abmt410_bmif019_desc()
            IF NOT cl_null(g_bmif_d[l_ac].bmif019) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bmif_d[l_ac].bmif019
               #160318-00025#27  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#27  by 07900 --add-end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  SELECT ooag003 INTO g_bmif_d[l_ac].bmif020
                    FROM ooag_t
                   WHERE ooagent = g_enterprise
                     AND ooag001 = g_bmif_d[l_ac].bmif019
                  CALL abmt410_bmif020_desc()
               ELSE
                  #檢查失敗時後續處理
                  LET g_bmif_d[l_ac].bmif019 = g_bmif_d_t.bmif019
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif019
            #add-point:BEFORE FIELD bmif019 name="input.b.page1.bmif019"
            CALL abmt410_bmif019_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif019
            #add-point:ON CHANGE bmif019 name="input.g.page1.bmif019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif020
            
            #add-point:AFTER FIELD bmif020 name="input.a.page1.bmif020"
            CALL abmt410_bmif020_desc()
            IF NOT cl_null(g_bmif_d[l_ac].bmif020) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bmif_d[l_ac].bmif020
               LET g_chkparam.arg2 = g_today                
               #160318-00025#27  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#27  by 07900 --add-end 
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_bmif_d[l_ac].bmif020 = g_bmif_d_t.bmif020
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif020
            #add-point:BEFORE FIELD bmif020 name="input.b.page1.bmif020"
            CALL abmt410_bmif020_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif020
            #add-point:ON CHANGE bmif020 name="input.g.page1.bmif020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif013
            
            #add-point:AFTER FIELD bmif013 name="input.a.page1.bmif013"
            CALL abmt410_oocql004_desc('210',g_bmif_d[l_ac].bmif013) RETURNING g_bmif_d[l_ac].bmif013_desc
            DISPLAY BY NAME g_bmif_d[l_ac].bmif013_desc

            IF NOT cl_null(g_bmif_d[l_ac].bmif013) THEN 
               IF NOT s_azzi650_chk_exist('210',g_bmif_d[l_ac].bmif013) THEN
                  LET g_bmif_d[l_ac].bmif013 = g_bmif_d_t.bmif013
                  NEXT FIELD CURRENT
               END IF            
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif013
            #add-point:BEFORE FIELD bmif013 name="input.b.page1.bmif013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif013
            #add-point:ON CHANGE bmif013 name="input.g.page1.bmif013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif014
            #add-point:BEFORE FIELD bmif014 name="input.b.page1.bmif014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif014
            
            #add-point:AFTER FIELD bmif014 name="input.a.page1.bmif014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif014
            #add-point:ON CHANGE bmif014 name="input.g.page1.bmif014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bmif_d[l_ac].bmif015,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD bmif015
            END IF 
 
 
 
            #add-point:AFTER FIELD bmif015 name="input.a.page1.bmif015"
            CALL abmt410_set_entry_b(l_cmd)
            CALL abmt410_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif015
            #add-point:BEFORE FIELD bmif015 name="input.b.page1.bmif015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif015
            #add-point:ON CHANGE bmif015 name="input.g.page1.bmif015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmif016
            #add-point:BEFORE FIELD bmif016 name="input.b.page1.bmif016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmif016
            
            #add-point:AFTER FIELD bmif016 name="input.a.page1.bmif016"
            IF NOT cl_null(g_bmif_d[l_ac].bmif016) THEN 
               IF g_bmif_d[l_ac].bmif016 < g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axc-00067'
                  LET g_errparam.extend = g_bmif_d[l_ac].bmif016
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF 
               IF g_bmif_d[l_ac].bmif016 < g_bmif_d[l_ac].bmif011 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00201'
                  LET g_errparam.extend = g_bmif_d[l_ac].bmif016
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF                
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmif016
            #add-point:ON CHANGE bmif016 name="input.g.page1.bmif016"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bmif005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif005
            #add-point:ON ACTION controlp INFIELD bmif005 name="input.c.page1.bmif005"
            #160314-00009#7 add by zhujing 2016-3-21-----(S)
            IF abmt410_imaa005_exists() THEN
               CALL s_feature_single(g_bmif_m.bmif001,g_bmif_d[l_ac].bmif005,g_site,'') RETURNING l_success,g_bmif_d[l_ac].bmif005
               DISPLAY BY NAME g_bmif_d[l_ac].bmif005
               CALL s_feature_description(g_bmif_m.bmif001,g_bmif_d[l_ac].bmif005) RETURNING g_success,g_bmif_d[l_ac].bmif005_desc                  
            END IF
            #160314-00009#7 add by zhujing 2016-3-21-----(E)
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif005_desc
            #add-point:ON ACTION controlp INFIELD bmif005_desc name="input.c.page1.bmif005_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif006
            #add-point:ON ACTION controlp INFIELD bmif006 name="input.c.page1.bmif006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif007
            #add-point:ON ACTION controlp INFIELD bmif007 name="input.c.page1.bmif007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmif_d[l_ac].bmif007             #給予default值

            #給予arg
            CASE g_bmif_d[l_ac].bmif006
               WHEN '1' 
                  CALL q_pmaa001_3()                                #呼叫開窗
               WHEN '2'
                  LET g_qryparam.arg1 = g_site
                  CALL q_pmaa001_6()
            END CASE      
            LET g_bmif_d[l_ac].bmif007 = g_qryparam.return1              

            DISPLAY g_bmif_d[l_ac].bmif007 TO bmif007              #

            NEXT FIELD bmif007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif008
            #add-point:ON ACTION controlp INFIELD bmif008 name="input.c.page1.bmif008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmif_d[l_ac].bmif008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_bmif_d[l_ac].bmif007
            LET g_qryparam.arg2 = g_bmif_m.bmif001
            LET g_qryparam.arg3 = g_bmif_d[l_ac].bmif005
            
            CALL q_pmao004_1()                                #呼叫開窗

            LET g_bmif_d[l_ac].bmif008 = g_qryparam.return1              

            DISPLAY g_bmif_d[l_ac].bmif008 TO bmif008              #
            SELECT pmao009,pmao010
              INTO g_bmif_d[l_ac].bmif008_desc, g_bmif_d[l_ac].bmif008_desc_desc
              FROM pmao_t
             WHERE pmao001 = g_bmif_d[l_ac].bmif007
               AND pmao002 = g_bmif_m.bmif001
               AND pmao003 = g_bmif_d[l_ac].bmif005
               AND pmao004 = g_bmif_d[l_ac].bmif008    
               AND pmao000 = g_bmif_d[l_ac].bmif006   #161221-00064#21 add               
               AND pmaoent = g_enterprise                      
            DISPLAY BY NAME g_bmif_d[l_ac].bmif008_desc_desc, g_bmif_d[l_ac].bmif008_desc
            NEXT FIELD bmif008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif009
            #add-point:ON ACTION controlp INFIELD bmif009 name="input.c.page1.bmif009"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmif_d[l_ac].bmif009             #給予default值
            LET g_qryparam.default2 = "" #g_bmif_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "1116" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_bmif_d[l_ac].bmif009 = g_qryparam.return1              
            #LET g_bmif_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bmif_d[l_ac].bmif009 TO bmif009              #
            #DISPLAY g_bmif_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bmif009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif010
            #add-point:ON ACTION controlp INFIELD bmif010 name="input.c.page1.bmif010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif011
            #add-point:ON ACTION controlp INFIELD bmif011 name="input.c.page1.bmif011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif012
            #add-point:ON ACTION controlp INFIELD bmif012 name="input.c.page1.bmif012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif017
            #add-point:ON ACTION controlp INFIELD bmif017 name="input.c.page1.bmif017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif018
            #add-point:ON ACTION controlp INFIELD bmif018 name="input.c.page1.bmif018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif019
            #add-point:ON ACTION controlp INFIELD bmif019 name="input.c.page1.bmif019"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmif_d[l_ac].bmif019             #給予default值

            #給予arg
            
            CALL q_ooag001()                                #呼叫開窗

            LET g_bmif_d[l_ac].bmif019 = g_qryparam.return1              

            DISPLAY g_bmif_d[l_ac].bmif019 TO bmif019              #

            NEXT FIELD bmif019                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif020
            #add-point:ON ACTION controlp INFIELD bmif020 name="input.c.page1.bmif020"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmif_d[l_ac].bmif020             #給予default值
            LET g_qryparam.default2 = "" #g_bmif_d[l_ac].ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_today

            
            CALL q_ooeg001()                                #呼叫開窗

            LET g_bmif_d[l_ac].bmif020 = g_qryparam.return1              
            #LET g_bmif_d[l_ac].ooeg001 = g_qryparam.return2 
            DISPLAY g_bmif_d[l_ac].bmif020 TO bmif020              #
            #DISPLAY g_bmif_d[l_ac].ooeg001 TO ooeg001 #部門編號
            NEXT FIELD bmif020                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif013
            #add-point:ON ACTION controlp INFIELD bmif013 name="input.c.page1.bmif013"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmif_d[l_ac].bmif013             #給予default值
            LET g_qryparam.default2 = "" #g_bmif_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "210" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_bmif_d[l_ac].bmif013 = g_qryparam.return1              
            #LET g_bmif_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_bmif_d[l_ac].bmif013 TO bmif013              #
            #DISPLAY g_bmif_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD bmif013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif014
            #add-point:ON ACTION controlp INFIELD bmif014 name="input.c.page1.bmif014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif015
            #add-point:ON ACTION controlp INFIELD bmif015 name="input.c.page1.bmif015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmif016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmif016
            #add-point:ON ACTION controlp INFIELD bmif016 name="input.c.page1.bmif016"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bmif_d[l_ac].* = g_bmif_d_t.*
               CLOSE abmt410_bcl
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
               LET g_errparam.extend = g_bmif_d[l_ac].bmif005 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_bmif_d[l_ac].* = g_bmif_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_bmif2_d[l_ac].bmifmodid = g_user 
LET g_bmif2_d[l_ac].bmifmoddt = cl_get_current()
LET g_bmif2_d[l_ac].bmifmodid_desc = cl_get_username(g_bmif2_d[l_ac].bmifmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL abmt410_bmif_t_mask_restore('restore_mask_o')
         
               UPDATE bmif_t SET (bmif001,bmif002,bmif003,bmif004,bmif005,bmif006,bmif007,bmif008,bmif009, 
                   bmif010,bmif011,bmif012,bmif017,bmif018,bmif019,bmif020,bmif013,bmif014,bmif015,bmif016, 
                   bmifownid,bmifowndp,bmifcrtid,bmifcrtdp,bmifcrtdt,bmifmodid,bmifmoddt) = (g_bmif_m.bmif001, 
                   g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif004,g_bmif_d[l_ac].bmif005,g_bmif_d[l_ac].bmif006, 
                   g_bmif_d[l_ac].bmif007,g_bmif_d[l_ac].bmif008,g_bmif_d[l_ac].bmif009,g_bmif_d[l_ac].bmif010, 
                   g_bmif_d[l_ac].bmif011,g_bmif_d[l_ac].bmif012,g_bmif_d[l_ac].bmif017,g_bmif_d[l_ac].bmif018, 
                   g_bmif_d[l_ac].bmif019,g_bmif_d[l_ac].bmif020,g_bmif_d[l_ac].bmif013,g_bmif_d[l_ac].bmif014, 
                   g_bmif_d[l_ac].bmif015,g_bmif_d[l_ac].bmif016,g_bmif2_d[l_ac].bmifownid,g_bmif2_d[l_ac].bmifowndp, 
                   g_bmif2_d[l_ac].bmifcrtid,g_bmif2_d[l_ac].bmifcrtdp,g_bmif2_d[l_ac].bmifcrtdt,g_bmif2_d[l_ac].bmifmodid, 
                   g_bmif2_d[l_ac].bmifmoddt)
                WHERE bmifent = g_enterprise AND bmif001 = g_bmif_m.bmif001 
                 AND bmif002 = g_bmif_m.bmif002 
                 AND bmif003 = g_bmif_m.bmif003 
                 AND bmif004 = g_bmif_m.bmif004 
 
                 AND bmif005 = g_bmif_d_t.bmif005 #項次   
                 AND bmif006 = g_bmif_d_t.bmif006  
                 AND bmif007 = g_bmif_d_t.bmif007  
                 AND bmif008 = g_bmif_d_t.bmif008  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmif_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "bmif_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmif_m.bmif001
               LET gs_keys_bak[1] = g_bmif001_t
               LET gs_keys[2] = g_bmif_m.bmif002
               LET gs_keys_bak[2] = g_bmif002_t
               LET gs_keys[3] = g_bmif_m.bmif003
               LET gs_keys_bak[3] = g_bmif003_t
               LET gs_keys[4] = g_bmif_m.bmif004
               LET gs_keys_bak[4] = g_bmif004_t
               LET gs_keys[5] = g_bmif_d[g_detail_idx].bmif005
               LET gs_keys_bak[5] = g_bmif_d_t.bmif005
               LET gs_keys[6] = g_bmif_d[g_detail_idx].bmif006
               LET gs_keys_bak[6] = g_bmif_d_t.bmif006
               LET gs_keys[7] = g_bmif_d[g_detail_idx].bmif007
               LET gs_keys_bak[7] = g_bmif_d_t.bmif007
               LET gs_keys[8] = g_bmif_d[g_detail_idx].bmif008
               LET gs_keys_bak[8] = g_bmif_d_t.bmif008
               CALL abmt410_update_b('bmif_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_bmif_m),util.JSON.stringify(g_bmif_d_t)
                     LET g_log2 = util.JSON.stringify(g_bmif_m),util.JSON.stringify(g_bmif_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abmt410_bmif_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_bmif_m.bmif001
               LET ls_keys[ls_keys.getLength()+1] = g_bmif_m.bmif002
               LET ls_keys[ls_keys.getLength()+1] = g_bmif_m.bmif003
               LET ls_keys[ls_keys.getLength()+1] = g_bmif_m.bmif004
 
               LET ls_keys[ls_keys.getLength()+1] = g_bmif_d_t.bmif005
               LET ls_keys[ls_keys.getLength()+1] = g_bmif_d_t.bmif006
               LET ls_keys[ls_keys.getLength()+1] = g_bmif_d_t.bmif007
               LET ls_keys[ls_keys.getLength()+1] = g_bmif_d_t.bmif008
 
               CALL abmt410_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE abmt410_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bmif_d[l_ac].* = g_bmif_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE abmt410_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_bmif_d.getLength() = 0 THEN
               NEXT FIELD bmif005
            END IF
            #add-point:input段after input  name="input.body.after_input"
            CALL abmt410_update_imaa()
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_bmif_d[li_reproduce_target].* = g_bmif_d[li_reproduce].*
               LET g_bmif2_d[li_reproduce_target].* = g_bmif2_d[li_reproduce].*
 
               LET g_bmif_d[li_reproduce_target].bmif005 = NULL
               LET g_bmif_d[li_reproduce_target].bmif006 = NULL
               LET g_bmif_d[li_reproduce_target].bmif007 = NULL
               LET g_bmif_d[li_reproduce_target].bmif008 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bmif_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bmif_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_bmif2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL abmt410_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL abmt410_idx_chk()
            CALL abmt410_ui_detailshow()
        
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
            NEXT FIELD bmif001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bmif005
               WHEN "s_detail2"
                  NEXT FIELD bmif005_2
 
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
 
{<section id="abmt410.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abmt410_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
 
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL abmt410_b_fill(g_wc2) #第一階單身填充
      CALL abmt410_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abmt410_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_bmif_m.bmif001,g_bmif_m.bmif004,g_bmif_m.imaal003a,g_bmif_m.imaal003b,g_bmif_m.imaal004a, 
       g_bmif_m.imaal004b,g_bmif_m.bmif002,g_bmif_m.bmif002_desc,g_bmif_m.bmif003
 
   CALL abmt410_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="abmt410.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION abmt410_ref_show()
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

   CALL abmt410_imaal_desc(g_bmif_m.bmif001) RETURNING g_bmif_m.imaal003a,g_bmif_m.imaal004a
   DISPLAY BY NAME g_bmif_m.imaal003a,g_bmif_m.imaal004a
   CALL abmt410_oocql004_desc('221',g_bmif_m.bmif002) RETURNING g_bmif_m.bmif002_desc
   DISPLAY BY NAME g_bmif_m.bmif002_desc
   CALL abmt410_imaal_desc(g_bmif_m.bmif004) RETURNING g_bmif_m.imaal003b,g_bmif_m.imaal004b
   DISPLAY BY NAME g_bmif_m.imaal003b,g_bmif_m.imaal004b
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_bmif_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      CALL s_feature_description(g_bmif_m.bmif001,g_bmif_d[l_ac].bmif005) RETURNING g_success,g_bmif_d[l_ac].bmif005_desc
      CALL abmt410_bmif007_desc()

      CALL abmt410_oocql004_desc('1116',g_bmif_d[l_ac].bmif009) RETURNING g_bmif_d[l_ac].bmif009_desc
      DISPLAY BY NAME g_bmif_d[l_ac].bmif009_desc

      CALL abmt410_bmif019_desc()

      CALL abmt410_bmif020_desc()

      CALL abmt410_oocql004_desc('210',g_bmif_d[l_ac].bmif013) RETURNING g_bmif_d[l_ac].bmif013_desc
      DISPLAY BY NAME g_bmif_d[l_ac].bmif013_desc

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_bmif2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmif2_d[l_ac].bmifownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_bmif2_d[l_ac].bmifownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmif2_d[l_ac].bmifownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmif2_d[l_ac].bmifowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bmif2_d[l_ac].bmifowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmif2_d[l_ac].bmifowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmif2_d[l_ac].bmifcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_bmif2_d[l_ac].bmifcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmif2_d[l_ac].bmifcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmif2_d[l_ac].bmifcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bmif2_d[l_ac].bmifcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmif2_d[l_ac].bmifcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmif2_d[l_ac].bmifmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_bmif2_d[l_ac].bmifmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmif2_d[l_ac].bmifmodid_desc

      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="abmt410.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abmt410_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE bmif_t.bmif001 
   DEFINE l_oldno     LIKE bmif_t.bmif001 
   DEFINE l_newno02     LIKE bmif_t.bmif002 
   DEFINE l_oldno02     LIKE bmif_t.bmif002 
   DEFINE l_newno03     LIKE bmif_t.bmif003 
   DEFINE l_oldno03     LIKE bmif_t.bmif003 
   DEFINE l_newno04     LIKE bmif_t.bmif004 
   DEFINE l_oldno04     LIKE bmif_t.bmif004 
 
   DEFINE l_master    RECORD LIKE bmif_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bmif_t.* #此變數樣板目前無使用
 
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
 
   IF g_bmif_m.bmif001 IS NULL
      OR g_bmif_m.bmif002 IS NULL
      OR g_bmif_m.bmif003 IS NULL
      OR g_bmif_m.bmif004 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_bmif001_t = g_bmif_m.bmif001
   LET g_bmif002_t = g_bmif_m.bmif002
   LET g_bmif003_t = g_bmif_m.bmif003
   LET g_bmif004_t = g_bmif_m.bmif004
 
   
   LET g_bmif_m.bmif001 = ""
   LET g_bmif_m.bmif002 = ""
   LET g_bmif_m.bmif003 = ""
   LET g_bmif_m.bmif004 = ""
 
   LET g_master_insert = FALSE
   CALL abmt410_set_entry('a')
   CALL abmt410_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_bmif_m.bmif002 = ' '
   LET g_bmif_m.bmif003 = ' '
   LET g_bmif_m_t.* = g_bmif_m.*
   #end add-point
   
   #清空key欄位的desc
      LET g_bmif_m.bmif002_desc = ''
   DISPLAY BY NAME g_bmif_m.bmif002_desc
 
   
   CALL abmt410_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_bmif_m.* TO NULL
      INITIALIZE g_bmif_d TO NULL
      INITIALIZE g_bmif2_d TO NULL
 
      CALL abmt410_show()
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
   CALL abmt410_set_act_visible()
   CALL abmt410_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bmif001_t = g_bmif_m.bmif001
   LET g_bmif002_t = g_bmif_m.bmif002
   LET g_bmif003_t = g_bmif_m.bmif003
   LET g_bmif004_t = g_bmif_m.bmif004
 
   
   #組合新增資料的條件
   LET g_add_browse = " bmifent = " ||g_enterprise|| " AND",
                      " bmif001 = '", g_bmif_m.bmif001, "' "
                      ," AND bmif002 = '", g_bmif_m.bmif002, "' "
                      ," AND bmif003 = '", g_bmif_m.bmif003, "' "
                      ," AND bmif004 = '", g_bmif_m.bmif004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abmt410_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL abmt410_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL abmt410_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="abmt410.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abmt410_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bmif_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abmt410_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bmif_t
    WHERE bmifent = g_enterprise AND bmif001 = g_bmif001_t
    AND bmif002 = g_bmif002_t
    AND bmif003 = g_bmif003_t
    AND bmif004 = g_bmif004_t
 
       INTO TEMP abmt410_detail
   
   #將key修正為調整後   
   UPDATE abmt410_detail 
      #更新key欄位
      SET bmif001 = g_bmif_m.bmif001
          , bmif002 = g_bmif_m.bmif002
          , bmif003 = g_bmif_m.bmif003
          , bmif004 = g_bmif_m.bmif004
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , bmifownid = g_user 
       , bmifowndp = g_dept
       , bmifcrtid = g_user
       , bmifcrtdp = g_dept 
       , bmifcrtdt = ld_date
       , bmifmodid = g_user
       , bmifmoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO bmif_t SELECT * FROM abmt410_detail
   
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
   DROP TABLE abmt410_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bmif001_t = g_bmif_m.bmif001
   LET g_bmif002_t = g_bmif_m.bmif002
   LET g_bmif003_t = g_bmif_m.bmif003
   LET g_bmif004_t = g_bmif_m.bmif004
 
   
   DROP TABLE abmt410_detail
   
END FUNCTION
 
{</section>}
 
{<section id="abmt410.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abmt410_delete()
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
   
   IF g_bmif_m.bmif001 IS NULL
   OR g_bmif_m.bmif002 IS NULL
   OR g_bmif_m.bmif003 IS NULL
   OR g_bmif_m.bmif004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN abmt410_cl USING g_enterprise,g_bmif_m.bmif001,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif004
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abmt410_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abmt410_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abmt410_master_referesh USING g_bmif_m.bmif001,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif004 INTO g_bmif_m.bmif001, 
       g_bmif_m.bmif004,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif002_desc
   
   #遮罩相關處理
   LET g_bmif_m_mask_o.* =  g_bmif_m.*
   CALL abmt410_bmif_t_mask()
   LET g_bmif_m_mask_n.* =  g_bmif_m.*
   
   CALL abmt410_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abmt410_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM bmif_t WHERE bmifent = g_enterprise AND bmif001 = g_bmif_m.bmif001
                                                               AND bmif002 = g_bmif_m.bmif002
                                                               AND bmif003 = g_bmif_m.bmif003
                                                               AND bmif004 = g_bmif_m.bmif004
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      DELETE FROM bmig_t
       WHERE bmigent = g_enterprise 
         AND bmig001 = g_bmif_m.bmif001 
         AND bmig002 = g_bmif_m.bmif002 
         AND bmig003 = g_bmif_m.bmif003 
         AND bmig004 = g_bmif_m.bmif004 
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmif_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
   DELETE FROM bmig_t
    WHERE bmigent = g_enterprise 
      AND bmig001 = g_bmif_m.bmif001 
      AND bmig002 = g_bmif_m.bmif002 
      AND bmig003 = g_bmif_m.bmif003 
      AND bmig004 = g_bmif_m.bmif004 
      AND bmig005 = g_bmif_d_t.bmif005
      AND bmig006 = g_bmif_d_t.bmif006
      AND bmig007 = g_bmif_d_t.bmif007
      AND bmig008 = g_bmif_d_t.bmif008
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE abmt410_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_bmif_d.clear() 
      CALL g_bmif2_d.clear()       
 
     
      CALL abmt410_ui_browser_refresh()  
      #CALL abmt410_ui_headershow()  
      #CALL abmt410_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL abmt410_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL abmt410_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE abmt410_cl
 
   #功能已完成,通報訊息中心
   CALL abmt410_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abmt410.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abmt410_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_bmif_d.clear()
   CALL g_bmif2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT bmif005,bmif006,bmif007,bmif008,bmif009,bmif010,bmif011,bmif012,bmif017, 
       bmif018,bmif019,bmif020,bmif013,bmif014,bmif015,bmif016,bmif005,bmif006,bmif007,bmif008,bmifownid, 
       bmifowndp,bmifcrtid,bmifcrtdp,bmifcrtdt,bmifmodid,bmifmoddt,t1.pmaal003 ,t2.pmao009 ,t3.pmao010 , 
       t4.oocql004 ,t5.ooag011 ,t6.ooefl003 ,t7.oocql004 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooefl003 , 
       t12.ooag011 FROM bmif_t",   
               "",
               
                              " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=bmif007 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmao_t t2 ON t2.pmaoent="||g_enterprise||" AND t2.pmao001=bmif007 AND t2.pmao003=bmif005 AND t2.pmao002=bmif001 AND t2.pmao004=bmif008  ",
               " LEFT JOIN pmao_t t3 ON t3.pmaoent="||g_enterprise||" AND t3.pmao001=bmif007 AND t3.pmao003=bmif005 AND t3.pmao002=bmif001 AND t3.pmao004=bmif008  ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='1116' AND t4.oocql002=bmif009 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=bmif019  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=bmif020 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='210' AND t7.oocql002=bmif013 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=bmifownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=bmifowndp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=bmifcrtid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=bmifcrtdp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=bmifmodid  ",
 
               " WHERE bmifent= ? AND bmif001=? AND bmif002=? AND bmif003=? AND bmif004=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("bmif_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #161221-00064#21 add-S
   LET g_sql = "SELECT  DISTINCT bmif005,bmif006,bmif007,bmif008,bmif009,bmif010,bmif011,bmif012,bmif017, 
       bmif018,bmif019,bmif020,bmif013,bmif014,bmif015,bmif016,bmif005,bmif006,bmif007,bmif008,bmifownid, 
       bmifowndp,bmifcrtid,bmifcrtdp,bmifcrtdt,bmifmodid,bmifmoddt,t1.pmaal003 ,t2.pmao009 ,t3.pmao010 , 
       t4.oocql004 ,t5.ooag011 ,t6.ooefl003 ,t7.oocql004 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooefl003 , 
       t12.ooag011 FROM bmif_t",   
               "",
               
                              " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=bmif007 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmao_t t2 ON t2.pmaoent="||g_enterprise||" AND t2.pmao001=bmif007 AND t2.pmao003=bmif005 AND t2.pmao002=bmif001 AND t2.pmao004=bmif008 AND t2.pmao000 = bmif006  ",
               " LEFT JOIN pmao_t t3 ON t3.pmaoent="||g_enterprise||" AND t3.pmao001=bmif007 AND t3.pmao003=bmif005 AND t3.pmao002=bmif001 AND t3.pmao004=bmif008 AND t3.pmao000 = bmif006 ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='1116' AND t4.oocql002=bmif009 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=bmif019  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=bmif020 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='210' AND t7.oocql002=bmif013 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=bmifownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=bmifowndp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=bmifcrtid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=bmifcrtdp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=bmifmodid  ",
 
               " WHERE bmifent= ? AND bmif001=? AND bmif002=? AND bmif003=? AND bmif004=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("bmif_t")
   END IF
   #161221-00064#21 add-E
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF abmt410_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY bmif_t.bmif005,bmif_t.bmif006,bmif_t.bmif007,bmif_t.bmif008"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abmt410_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abmt410_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bmif_m.bmif001,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif004   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bmif_m.bmif001,g_bmif_m.bmif002,g_bmif_m.bmif003,g_bmif_m.bmif004 INTO g_bmif_d[l_ac].bmif005, 
          g_bmif_d[l_ac].bmif006,g_bmif_d[l_ac].bmif007,g_bmif_d[l_ac].bmif008,g_bmif_d[l_ac].bmif009, 
          g_bmif_d[l_ac].bmif010,g_bmif_d[l_ac].bmif011,g_bmif_d[l_ac].bmif012,g_bmif_d[l_ac].bmif017, 
          g_bmif_d[l_ac].bmif018,g_bmif_d[l_ac].bmif019,g_bmif_d[l_ac].bmif020,g_bmif_d[l_ac].bmif013, 
          g_bmif_d[l_ac].bmif014,g_bmif_d[l_ac].bmif015,g_bmif_d[l_ac].bmif016,g_bmif2_d[l_ac].bmif005, 
          g_bmif2_d[l_ac].bmif006,g_bmif2_d[l_ac].bmif007,g_bmif2_d[l_ac].bmif008,g_bmif2_d[l_ac].bmifownid, 
          g_bmif2_d[l_ac].bmifowndp,g_bmif2_d[l_ac].bmifcrtid,g_bmif2_d[l_ac].bmifcrtdp,g_bmif2_d[l_ac].bmifcrtdt, 
          g_bmif2_d[l_ac].bmifmodid,g_bmif2_d[l_ac].bmifmoddt,g_bmif_d[l_ac].bmif007_desc,g_bmif_d[l_ac].bmif008_desc, 
          g_bmif_d[l_ac].bmif008_desc_desc,g_bmif_d[l_ac].bmif009_desc,g_bmif_d[l_ac].bmif019_desc,g_bmif_d[l_ac].bmif020_desc, 
          g_bmif_d[l_ac].bmif013_desc,g_bmif2_d[l_ac].bmifownid_desc,g_bmif2_d[l_ac].bmifowndp_desc, 
          g_bmif2_d[l_ac].bmifcrtid_desc,g_bmif2_d[l_ac].bmifcrtdp_desc,g_bmif2_d[l_ac].bmifmodid_desc  
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
         LET g_bmif2_d[l_ac].bmif005 = g_bmif_d[l_ac].bmif005 
         LET g_bmif2_d[l_ac].bmif006 = g_bmif_d[l_ac].bmif006
         LET g_bmif2_d[l_ac].bmif007 = g_bmif_d[l_ac].bmif007
         LET g_bmif2_d[l_ac].bmif008 = g_bmif_d[l_ac].bmif008         
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
 
            CALL g_bmif_d.deleteElement(g_bmif_d.getLength())
      CALL g_bmif2_d.deleteElement(g_bmif2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bmif_d.getLength()
      LET g_bmif_d_mask_o[l_ac].* =  g_bmif_d[l_ac].*
      CALL abmt410_bmif_t_mask()
      LET g_bmif_d_mask_n[l_ac].* =  g_bmif_d[l_ac].*
   END FOR
   
   LET g_bmif2_d_mask_o.* =  g_bmif2_d.*
   FOR l_ac = 1 TO g_bmif2_d.getLength()
      LET g_bmif2_d_mask_o[l_ac].* =  g_bmif2_d[l_ac].*
      CALL abmt410_bmif_t_mask()
      LET g_bmif2_d_mask_n[l_ac].* =  g_bmif2_d[l_ac].*
   END FOR
 
 
   FREE abmt410_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="abmt410.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abmt410_idx_chk()
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
      IF g_detail_idx > g_bmif_d.getLength() THEN
         LET g_detail_idx = g_bmif_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_bmif_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bmif_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_bmif2_d.getLength() THEN
         LET g_detail_idx = g_bmif2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bmif2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bmif2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abmt410.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abmt410_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_bmif_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="abmt410.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION abmt410_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM bmif_t
    WHERE bmifent = g_enterprise AND bmif001 = g_bmif_m.bmif001 AND
                              bmif002 = g_bmif_m.bmif002 AND
                              bmif003 = g_bmif_m.bmif003 AND
                              bmif004 = g_bmif_m.bmif004 AND
 
          bmif005 = g_bmif_d_t.bmif005
      AND bmif006 = g_bmif_d_t.bmif006
      AND bmif007 = g_bmif_d_t.bmif007
      AND bmif008 = g_bmif_d_t.bmif008
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bmif_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後 name="delete.body.a_single_delete"
   DELETE FROM bmig_t
    WHERE bmigent = g_enterprise 
      AND bmig001 = g_bmif_m.bmif001 
      AND bmig002 = g_bmif_m.bmif002 
      AND bmig003 = g_bmif_m.bmif003 
      AND bmig004 = g_bmif_m.bmif004 
      AND bmig005 = g_bmif_d_t.bmif005
      AND bmig006 = g_bmif_d_t.bmif006
      AND bmig007 = g_bmif_d_t.bmif007
      AND bmig008 = g_bmif_d_t.bmif008
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "bmig_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE 
   END IF      
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="abmt410.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abmt410_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="abmt410.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abmt410_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="abmt410.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abmt410_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="abmt410.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION abmt410_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_bmif_d[l_ac].bmif005 = g_bmif_d_t.bmif005 
      AND g_bmif_d[l_ac].bmif006 = g_bmif_d_t.bmif006 
      AND g_bmif_d[l_ac].bmif007 = g_bmif_d_t.bmif007 
      AND g_bmif_d[l_ac].bmif008 = g_bmif_d_t.bmif008 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="abmt410.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abmt410_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="abmt410.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abmt410_lock_b(ps_table,ps_page)
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
   #CALL abmt410_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abmt410.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abmt410_unlock_b(ps_table,ps_page)
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
 
{<section id="abmt410.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abmt410_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bmif001,bmif002,bmif003,bmif004",TRUE)
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
 
{<section id="abmt410.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abmt410_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bmif001,bmif002,bmif003,bmif004",FALSE)
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
 
{<section id="abmt410.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abmt410_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CALL cl_set_comp_entry("bmif005,bmif009,bmif015,bmif016",TRUE)
   CALL cl_set_comp_required("bmif011,bmif012,bmif016",FALSE)
   CALL cl_set_comp_entry("bmif008",TRUE)
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abmt410.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abmt410_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_oocq014  LIKE oocq_t.oocq014
   DEFINE l_oocq016  LIKE oocq_t.oocq016
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   IF NOT abmt410_imaa005_exists() THEN 
      CALL cl_set_comp_entry("bmif005",FALSE)
      LET g_bmif_d[l_ac].bmif005 = ' '
   END IF
   IF p_cmd = 'u' THEN 
      CALL cl_set_comp_entry("bmif009",FALSE)
   END IF
   
   SELECT oocq014,oocq016 INTO l_oocq014,l_oocq016 FROM oocq_t 
    WHERE oocqent = g_enterprise AND oocq001 = '1116' AND oocq002 = g_bmif_d[l_ac].bmif009
   IF l_oocq014 = 'Y' THEN
      CALL cl_set_comp_required("bmif011,bmif012",TRUE)
   END IF
   IF l_oocq016 = 'N' THEN
      CALL cl_set_comp_entry("bmif015,bmif016",FALSE)
   END IF 
   IF NOT cl_null(g_bmif_d[l_ac].bmif015) THEN 
      CALL cl_set_comp_required("bmif016",TRUE)
   END IF
   IF g_bmif_d[l_ac].bmif007 = 'ALL' THEN 
      CALL cl_set_comp_entry("bmif008",FALSE)
      LET g_bmif_d[l_ac].bmif008 = ' ' 
   END IF
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="abmt410.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abmt410_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abmt410.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abmt410_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abmt410.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abmt410_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abmt410.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abmt410_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abmt410.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abmt410_default_search()
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
      LET ls_wc = ls_wc, " bmif001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bmif002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bmif003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " bmif004 = '", g_argv[04], "' AND "
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
 
{<section id="abmt410.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abmt410_fill_chk(ps_idx)
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
 
{<section id="abmt410.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION abmt410_modify_detail_chk(ps_record)
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
         LET ls_return = "bmif005"
      WHEN "s_detail2"
         LET ls_return = "bmif005_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="abmt410.mask_functions" >}
&include "erp/abm/abmt410_mask.4gl"
 
{</section>}
 
{<section id="abmt410.state_change" >}
    
 
{</section>}
 
{<section id="abmt410.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abmt410_set_pk_array()
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
   LET g_pk_array[1].values = g_bmif_m.bmif001
   LET g_pk_array[1].column = 'bmif001'
   LET g_pk_array[2].values = g_bmif_m.bmif002
   LET g_pk_array[2].column = 'bmif002'
   LET g_pk_array[3].values = g_bmif_m.bmif003
   LET g_pk_array[3].column = 'bmif003'
   LET g_pk_array[4].values = g_bmif_m.bmif004
   LET g_pk_array[4].column = 'bmif004'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abmt410.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abmt410_msgcentre_notify(lc_state)
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
   CALL abmt410_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bmif_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abmt410.other_function" readonly="Y" >}

PRIVATE FUNCTION abmt410_oocql004_desc(p_oocql001,p_oocql002)
DEFINE p_oocql001    LIKE oocql_t.oocql001,
       p_oocql002    LIKE oocql_t.oocql002
DEFINE r_oocql004    LIKE oocql_t.oocql004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oocql001
   LET g_ref_fields[2] = p_oocql002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_oocql004 = '', g_rtn_fields[1] , ''
   RETURN r_oocql004   
END FUNCTION

PRIVATE FUNCTION abmt410_bmif007_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmif_d[l_ac].bmif007
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bmif_d[l_ac].bmif007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_bmif_d[l_ac].bmif007_desc
END FUNCTION

PRIVATE FUNCTION abmt410_bmif019_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmif_d[l_ac].bmif019
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_bmif_d[l_ac].bmif019_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_bmif_d[l_ac].bmif019_desc
END FUNCTION

PRIVATE FUNCTION abmt410_bmif020_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmif_d[l_ac].bmif020
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bmif_d[l_ac].bmif020_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_bmif_d[l_ac].bmif020_desc
END FUNCTION

PRIVATE FUNCTION abmt410_imaal_desc(p_imaal001)
DEFINE p_imaal001  LIKE imaal_t.imaal001
DEFINE r_imaal003  LIKE imaal_t.imaal003,
       r_imaal004  LIKE imaal_t.imaal004
       
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_imaal001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_imaal003 = '', g_rtn_fields[1] , ''
   LET r_imaal004 = '', g_rtn_fields[2] , ''
   RETURN r_imaal003,r_imaal004
END FUNCTION

PRIVATE FUNCTION abmt410_imaa005_exists()
DEFINE l_imaa005  LIKE imaa_t.imaa005
   IF NOT cl_null(g_bmif_m.bmif001) THEN
      SELECT imaa005 INTO l_imaa005 FROM imaa_t
       WHERE imaaent = g_enterprise AND imaa001 =  g_bmif_m.bmif001
      IF cl_null(l_imaa005) THEN
         RETURN FALSE
      END IF
   ELSE
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#161221-00064#21 添加bmif006(承認類型)判别交易对象料号归属
PRIVATE FUNCTION abmt410_bmif008_def(p_bmif001,p_bmif005,p_bmif006)
DEFINE p_bmif001   LIKE bmif_t.bmif001,
       p_bmif005   LIKE bmif_t.bmif008,
       p_bmif006   LIKE bmif_t.bmif006,   #161221-00064#21 add
       l_success   LIKE type_t.num5     
   
   LET g_bmif_d[l_ac].bmif008 = ' '
   IF NOT cl_null(p_bmif001) AND p_bmif005 IS NOT NULL AND NOT cl_null(g_bmif_d[l_ac].bmif007) THEN
      #161221-00064#21 mod-S
#      CALL s_apmi070_get_pmao004(g_bmif_d[l_ac].bmif007,p_bmif001,p_bmif005) RETURNING l_success,g_bmif_d[l_ac].bmif008
      CALL s_apmi070_get_pmao004_2(g_bmif_d[l_ac].bmif007,p_bmif001,p_bmif005,p_bmif006) RETURNING l_success,g_bmif_d[l_ac].bmif008
      #161221-00064#21 mod-E
   END IF
   DISPLAY BY NAME g_bmif_d[l_ac].bmif008
END FUNCTION

PRIVATE FUNCTION abmt410_update_imaa()
DEFINE l_bmif013  LIKE bmif_t.bmif013
DEFINE l_imaa010  LIKE imaa_t.imaa010

   SELECT MAX(bmif013) INTO l_bmif013
     FROM bmif_t,oocq_t
    WHERE bmifent = oocqent
      AND bmif013 = oocq002
      AND oocq001 = '210'
      AND bmifent = g_enterprise 
      AND bmif001 = g_bmif_m.bmif001 
      AND bmif002 = g_bmif_m.bmif002 
      AND bmif003 = g_bmif_m.bmif003 
      AND bmif004 = g_bmif_m.bmif004
      AND oocqstus = 'Y'      
   
   SELECT imaa010 INTO l_imaa010
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_bmif_m.bmif001
   IF cl_null(l_imaa010) OR l_imaa010 < l_bmif013 THEN 
      UPDATE imaa_t
         SET imaa010 = l_bmif013
       WHERE imaaent = g_enterprise
         AND imaa001 = g_bmif_m.bmif001  
   END IF
END FUNCTION

 
{</section>}
 
