#該程式未解開Section, 採用最新樣板產出!
{<section id="asrt900.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-05-18 16:51:40), PR版次:0002(2016-12-19 16:00:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: asrt900
#+ Description: 重複性生產當期在製查詢與調整作業
#+ Creator....: 01258(2015-05-04 10:18:52)
#+ Modifier...: 01258 -SD/PR- 01996
 
{</section>}
 
{<section id="asrt900.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#161124-00048#12 2016/12/13 By xujing     整批调整系统RECORD LIKE xxxx_t.* 星号写法
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
PRIVATE type type_g_srda_m        RECORD
       srda000 LIKE srda_t.srda000, 
   srda001 LIKE srda_t.srda001, 
   srda002 LIKE srda_t.srda002, 
   srda002_desc LIKE type_t.chr80, 
   srda003 LIKE srda_t.srda003, 
   srda003_desc LIKE type_t.chr80, 
   srda003_desc_1 LIKE type_t.chr80, 
   srdasite LIKE srda_t.srdasite, 
   srda004 LIKE srda_t.srda004, 
   srda005 LIKE srda_t.srda005, 
   srda005_desc LIKE type_t.chr80, 
   srda006 LIKE srda_t.srda006
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_srdb_d        RECORD
       srdbseq LIKE srdb_t.srdbseq, 
   srdb006 LIKE srdb_t.srdb006, 
   srdb006_desc LIKE type_t.chr500, 
   srdb006_desc_1 LIKE type_t.chr500, 
   srdb007 LIKE srdb_t.srdb007, 
   srdb007_desc LIKE type_t.chr500, 
   inag007 LIKE type_t.chr10, 
   inag007_desc LIKE type_t.chr500, 
   srdb008 LIKE srdb_t.srdb008, 
   srdb009 LIKE srdb_t.srdb009, 
   srdb010 LIKE srdb_t.srdb010, 
   srdb011 LIKE srdb_t.srdb011, 
   srdb012 LIKE srdb_t.srdb012, 
   srdb013 LIKE srdb_t.srdb013
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_srda000 LIKE srda_t.srda000,
      b_srda001 LIKE srda_t.srda001,
      b_srda002 LIKE srda_t.srda002,
   b_srda002_desc LIKE type_t.chr80,
      b_srda003 LIKE srda_t.srda003,
   b_srda003_desc LIKE type_t.chr80,
   b_srda003_desc_1 LIKE type_t.chr80,
      b_srda004 LIKE srda_t.srda004,
      b_srda005 LIKE srda_t.srda005,
   b_srda005_desc LIKE type_t.chr80,
      b_srdasite LIKE srda_t.srdasite,
      b_srda006 LIKE srda_t.srda006
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glav001             LIKE glav_t.glav001
DEFINE g_ld                  LIKE glaa_t.glaald
#end add-point
       
#模組變數(Module Variables)
DEFINE g_srda_m          type_g_srda_m
DEFINE g_srda_m_t        type_g_srda_m
DEFINE g_srda_m_o        type_g_srda_m
DEFINE g_srda_m_mask_o   type_g_srda_m #轉換遮罩前資料
DEFINE g_srda_m_mask_n   type_g_srda_m #轉換遮罩後資料
 
   DEFINE g_srda000_t LIKE srda_t.srda000
DEFINE g_srda001_t LIKE srda_t.srda001
DEFINE g_srda002_t LIKE srda_t.srda002
DEFINE g_srda003_t LIKE srda_t.srda003
DEFINE g_srdasite_t LIKE srda_t.srdasite
DEFINE g_srda004_t LIKE srda_t.srda004
DEFINE g_srda005_t LIKE srda_t.srda005
 
 
DEFINE g_srdb_d          DYNAMIC ARRAY OF type_g_srdb_d
DEFINE g_srdb_d_t        type_g_srdb_d
DEFINE g_srdb_d_o        type_g_srdb_d
DEFINE g_srdb_d_mask_o   DYNAMIC ARRAY OF type_g_srdb_d #轉換遮罩前資料
DEFINE g_srdb_d_mask_n   DYNAMIC ARRAY OF type_g_srdb_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
DEFINE g_wc2_extend          STRING
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
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="asrt900.main" >}
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
   CALL cl_ap_init("asr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT srda000,srda001,srda002,'',srda003,'','',srdasite,srda004,srda005,'', 
       srda006", 
                      " FROM srda_t",
                      " WHERE srdaent= ? AND srdasite=? AND srda000=? AND srda001=? AND srda002=? AND  
                          srda003=? AND srda004=? AND srda005=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt900_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.srda000,t0.srda001,t0.srda002,t0.srda003,t0.srdasite,t0.srda004, 
       t0.srda005,t0.srda006,t1.srza002 ,t2.imaal003 ,t3.imecl005",
               " FROM srda_t t0",
                              " LEFT JOIN srza_t t1 ON t1.srzaent="||g_enterprise||" AND t1.srzasite=t0.srdasite AND t1.srza001=t0.srda002  ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=t0.srda003 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imecl_t t3 ON t3.imeclent="||g_enterprise||" AND t3.imecl003=t0.srda005 AND t3.imecl004='"||g_dlang||"' ",
 
               " WHERE t0.srdaent = " ||g_enterprise|| " AND t0.srdasite = ? AND t0.srda000 = ? AND t0.srda001 = ? AND t0.srda002 = ? AND t0.srda003 = ? AND t0.srda004 = ? AND t0.srda005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE asrt900_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asrt900 WITH FORM cl_ap_formpath("asr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asrt900_init()   
 
      #進入選單 Menu (="N")
      CALL asrt900_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asrt900
      
   END IF 
   
   CLOSE asrt900_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asrt900.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION asrt900_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
   
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #初始化搜尋條件
   CALL asrt900_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="asrt900.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION asrt900_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   #因應查詢方案進行處理
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL asrt900_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_srda_m.* TO NULL
         CALL g_srdb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL asrt900_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
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
               
               CALL asrt900_fetch('') # reload data
               LET l_ac = 1
               CALL asrt900_ui_detailshow() #Setting the current row 
         
               CALL asrt900_idx_chk()
               #NEXT FIELD srdbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_srdb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL asrt900_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL asrt900_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL asrt900_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL asrt900_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL asrt900_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL asrt900_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
 
 
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "srda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "srdb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL asrt900_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "srda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "srdb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL asrt900_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL asrt900_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL asrt900_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL asrt900_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt900_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL asrt900_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt900_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL asrt900_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt900_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL asrt900_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt900_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL asrt900_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt900_idx_chk()
          
         #excel匯出功能          
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
                  LET g_export_node[1] = base.typeInfo.create(g_srdb_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
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
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
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
               NEXT FIELD srdbseq
            END IF
       
         #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
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
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL asrt900_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_srdb012
            LET g_action_choice="modify_srdb012"
            IF cl_auth_chk_act("modify_srdb012") THEN
               
               #add-point:ON ACTION modify_srdb012 name="menu.modify_srdb012"
               CALL asrt900_modify_srdb012()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/asr/asrt900_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/asr/asrt900_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL asrt900_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_srda006
            LET g_action_choice="modify_srda006"
            IF cl_auth_chk_act("modify_srda006") THEN
               
               #add-point:ON ACTION modify_srda006 name="menu.modify_srda006"
               CALL asrt900_modify_srda006()
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL asrt900_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL asrt900_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL asrt900_set_pk_array()
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
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="asrt900.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION asrt900_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT srdasite,srda000,srda001,srda002,srda003,srda004,srda005 ",
                      " FROM srda_t ",
                      " ",
                      " LEFT JOIN srdb_t ON srdbent = srdaent AND srdasite = srdbsite AND srda000 = srdb000 AND srda001 = srdb001 AND srda002 = srdb002 AND srda003 = srdb003 AND srda004 = srdb004 AND srda005 = srdb005 ", "  ",
                      #add-point:browser_fill段sql(srdb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE srdaent = " ||g_enterprise|| " AND srdbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("srda_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT srdasite,srda000,srda001,srda002,srda003,srda004,srda005 ",
                      " FROM srda_t ", 
                      "  ",
                      "  ",
                      " WHERE srdaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("srda_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
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
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_srda_m.* TO NULL
      CALL g_srdb_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.srda000,t0.srda001,t0.srda002,t0.srda003,t0.srda004,t0.srda005,t0.srdasite,t0.srda006 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.srdastus,t0.srda000,t0.srda001,t0.srda002,t0.srda003,t0.srda004, 
          t0.srda005,t0.srdasite,t0.srda006,t1.srza002 ,t2.imaal003 ,t3.imaal004 ,t4.imecl005 ",
                  " FROM srda_t t0",
                  "  ",
                  "  LEFT JOIN srdb_t ON srdbent = srdaent AND srdasite = srdbsite AND srda000 = srdb000 AND srda001 = srdb001 AND srda002 = srdb002 AND srda003 = srdb003 AND srda004 = srdb004 AND srda005 = srdb005 ", "  ", 
                  #add-point:browser_fill段sql(srdb_t1) name="browser_fill.join.srdb_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN srza_t t1 ON t1.srzaent="||g_enterprise||" AND t1.srzasite=t0.srdasite AND t1.srza001=t0.srda002  ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=t0.srda003 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND immal001=t0.srda003 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imecl_t t4 ON t4.imeclent="||g_enterprise||" AND t4.imecl003=t0.srda005 AND t4.imecl004='"||g_dlang||"' ",
 
                  " WHERE t0.srdaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("srda_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.srdastus,t0.srda000,t0.srda001,t0.srda002,t0.srda003,t0.srda004, 
          t0.srda005,t0.srdasite,t0.srda006,t1.srza002 ,t2.imaal003 ,t3.imaal004 ,t4.imecl005 ",
                  " FROM srda_t t0",
                  "  ",
                                 " LEFT JOIN srza_t t1 ON t1.srzaent="||g_enterprise||" AND t1.srzasite=t0.srdasite AND t1.srza001=t0.srda002  ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=t0.srda003 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND immal001=t0.srda003 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imecl_t t4 ON t4.imeclent="||g_enterprise||" AND t4.imecl003=t0.srda005 AND t4.imecl004='"||g_dlang||"' ",
 
                  " WHERE t0.srdaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("srda_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY srdasite,srda000,srda001,srda002,srda003,srda004,srda005 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"srda_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_srda000,g_browser[g_cnt].b_srda001, 
          g_browser[g_cnt].b_srda002,g_browser[g_cnt].b_srda003,g_browser[g_cnt].b_srda004,g_browser[g_cnt].b_srda005, 
          g_browser[g_cnt].b_srdasite,g_browser[g_cnt].b_srda006,g_browser[g_cnt].b_srda002_desc,g_browser[g_cnt].b_srda003_desc, 
          g_browser[g_cnt].b_srda003_desc_1,g_browser[g_cnt].b_srda005_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
         #遮罩相關處理
         CALL asrt900_browser_mask()
      
         
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
   
   IF cl_null(g_browser[g_cnt].b_srdasite) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
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
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="asrt900.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION asrt900_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_srda_m.srdasite = g_browser[g_current_idx].b_srdasite   
   LET g_srda_m.srda000 = g_browser[g_current_idx].b_srda000   
   LET g_srda_m.srda001 = g_browser[g_current_idx].b_srda001   
   LET g_srda_m.srda002 = g_browser[g_current_idx].b_srda002   
   LET g_srda_m.srda003 = g_browser[g_current_idx].b_srda003   
   LET g_srda_m.srda004 = g_browser[g_current_idx].b_srda004   
   LET g_srda_m.srda005 = g_browser[g_current_idx].b_srda005   
 
   EXECUTE asrt900_master_referesh USING g_srda_m.srdasite,g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002, 
       g_srda_m.srda003,g_srda_m.srda004,g_srda_m.srda005 INTO g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002, 
       g_srda_m.srda003,g_srda_m.srdasite,g_srda_m.srda004,g_srda_m.srda005,g_srda_m.srda006,g_srda_m.srda002_desc, 
       g_srda_m.srda003_desc,g_srda_m.srda005_desc
   
   CALL asrt900_srda_t_mask()
   CALL asrt900_show()
      
END FUNCTION
 
{</section>}
 
{<section id="asrt900.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION asrt900_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION asrt900_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_srdasite = g_srda_m.srdasite 
         AND g_browser[l_i].b_srda000 = g_srda_m.srda000 
         AND g_browser[l_i].b_srda001 = g_srda_m.srda001 
         AND g_browser[l_i].b_srda002 = g_srda_m.srda002 
         AND g_browser[l_i].b_srda003 = g_srda_m.srda003 
         AND g_browser[l_i].b_srda004 = g_srda_m.srda004 
         AND g_browser[l_i].b_srda005 = g_srda_m.srda005 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
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
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION asrt900_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_srda_m.* TO NULL
   CALL g_srdb_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON srda000,srda001,srda002,srda003,srdasite,srda004,srda005,srda006
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srda000
            #add-point:BEFORE FIELD srda000 name="construct.b.srda000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srda000
            
            #add-point:AFTER FIELD srda000 name="construct.a.srda000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srda000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srda000
            #add-point:ON ACTION controlp INFIELD srda000 name="construct.c.srda000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srda001
            #add-point:BEFORE FIELD srda001 name="construct.b.srda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srda001
            
            #add-point:AFTER FIELD srda001 name="construct.a.srda001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srda001
            #add-point:ON ACTION controlp INFIELD srda001 name="construct.c.srda001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.srda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srda002
            #add-point:ON ACTION controlp INFIELD srda002 name="construct.c.srda002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_srac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srda002  #顯示到畫面上
            NEXT FIELD srda002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srda002
            #add-point:BEFORE FIELD srda002 name="construct.b.srda002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srda002
            
            #add-point:AFTER FIELD srda002 name="construct.a.srda002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srda003
            #add-point:ON ACTION controlp INFIELD srda003 name="construct.c.srda003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_srac004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srda003  #顯示到畫面上
            NEXT FIELD srda003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srda003
            #add-point:BEFORE FIELD srda003 name="construct.b.srda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srda003
            
            #add-point:AFTER FIELD srda003 name="construct.a.srda003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srdasite
            #add-point:BEFORE FIELD srdasite name="construct.b.srdasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srdasite
            
            #add-point:AFTER FIELD srdasite name="construct.a.srdasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srdasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srdasite
            #add-point:ON ACTION controlp INFIELD srdasite name="construct.c.srdasite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.srda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srda004
            #add-point:ON ACTION controlp INFIELD srda004 name="construct.c.srda004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_srac005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srda004  #顯示到畫面上
            NEXT FIELD srda004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srda004
            #add-point:BEFORE FIELD srda004 name="construct.b.srda004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srda004
            
            #add-point:AFTER FIELD srda004 name="construct.a.srda004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srda005
            #add-point:ON ACTION controlp INFIELD srda005 name="construct.c.srda005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_srac006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srda005  #顯示到畫面上
            NEXT FIELD srda005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srda005
            #add-point:BEFORE FIELD srda005 name="construct.b.srda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srda005
            
            #add-point:AFTER FIELD srda005 name="construct.a.srda005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srda006
            #add-point:BEFORE FIELD srda006 name="construct.b.srda006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srda006
            
            #add-point:AFTER FIELD srda006 name="construct.a.srda006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srda006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srda006
            #add-point:ON ACTION controlp INFIELD srda006 name="construct.c.srda006"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON srdbseq,srdb006,srdb007,srdb008,srdb009,srdb010,srdb011,srdb012,srdb013 
 
           FROM s_detail1[1].srdbseq,s_detail1[1].srdb006,s_detail1[1].srdb007,s_detail1[1].srdb008, 
               s_detail1[1].srdb009,s_detail1[1].srdb010,s_detail1[1].srdb011,s_detail1[1].srdb012,s_detail1[1].srdb013 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srdbseq
            #add-point:BEFORE FIELD srdbseq name="construct.b.page1.srdbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srdbseq
            
            #add-point:AFTER FIELD srdbseq name="construct.a.page1.srdbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srdbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srdbseq
            #add-point:ON ACTION controlp INFIELD srdbseq name="construct.c.page1.srdbseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srdb006
            #add-point:BEFORE FIELD srdb006 name="construct.b.page1.srdb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srdb006
            
            #add-point:AFTER FIELD srdb006 name="construct.a.page1.srdb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srdb006
            #add-point:ON ACTION controlp INFIELD srdb006 name="construct.c.page1.srdb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srdb007
            #add-point:BEFORE FIELD srdb007 name="construct.b.page1.srdb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srdb007
            
            #add-point:AFTER FIELD srdb007 name="construct.a.page1.srdb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srdb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srdb007
            #add-point:ON ACTION controlp INFIELD srdb007 name="construct.c.page1.srdb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srdb008
            #add-point:BEFORE FIELD srdb008 name="construct.b.page1.srdb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srdb008
            
            #add-point:AFTER FIELD srdb008 name="construct.a.page1.srdb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srdb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srdb008
            #add-point:ON ACTION controlp INFIELD srdb008 name="construct.c.page1.srdb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srdb009
            #add-point:BEFORE FIELD srdb009 name="construct.b.page1.srdb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srdb009
            
            #add-point:AFTER FIELD srdb009 name="construct.a.page1.srdb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srdb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srdb009
            #add-point:ON ACTION controlp INFIELD srdb009 name="construct.c.page1.srdb009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srdb010
            #add-point:BEFORE FIELD srdb010 name="construct.b.page1.srdb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srdb010
            
            #add-point:AFTER FIELD srdb010 name="construct.a.page1.srdb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srdb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srdb010
            #add-point:ON ACTION controlp INFIELD srdb010 name="construct.c.page1.srdb010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srdb011
            #add-point:BEFORE FIELD srdb011 name="construct.b.page1.srdb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srdb011
            
            #add-point:AFTER FIELD srdb011 name="construct.a.page1.srdb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srdb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srdb011
            #add-point:ON ACTION controlp INFIELD srdb011 name="construct.c.page1.srdb011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srdb012
            #add-point:BEFORE FIELD srdb012 name="construct.b.page1.srdb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srdb012
            
            #add-point:AFTER FIELD srdb012 name="construct.a.page1.srdb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srdb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srdb012
            #add-point:ON ACTION controlp INFIELD srdb012 name="construct.c.page1.srdb012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srdb013
            #add-point:BEFORE FIELD srdb013 name="construct.b.page1.srdb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srdb013
            
            #add-point:AFTER FIELD srdb013 name="construct.a.page1.srdb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srdb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srdb013
            #add-point:ON ACTION controlp INFIELD srdb013 name="construct.c.page1.srdb013"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "srda_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "srdb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
 
               END CASE
            END FOR
         END IF
    
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
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="asrt900.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION asrt900_filter()
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
      CONSTRUCT g_wc_filter ON srda000,srda001,srda002,srda003,srda004,srda005,srdasite,srda006
                          FROM s_browse[1].b_srda000,s_browse[1].b_srda001,s_browse[1].b_srda002,s_browse[1].b_srda003, 
                              s_browse[1].b_srda004,s_browse[1].b_srda005,s_browse[1].b_srdasite,s_browse[1].b_srda006 
 
 
         BEFORE CONSTRUCT
               DISPLAY asrt900_filter_parser('srda000') TO s_browse[1].b_srda000
            DISPLAY asrt900_filter_parser('srda001') TO s_browse[1].b_srda001
            DISPLAY asrt900_filter_parser('srda002') TO s_browse[1].b_srda002
            DISPLAY asrt900_filter_parser('srda003') TO s_browse[1].b_srda003
            DISPLAY asrt900_filter_parser('srda004') TO s_browse[1].b_srda004
            DISPLAY asrt900_filter_parser('srda005') TO s_browse[1].b_srda005
            DISPLAY asrt900_filter_parser('srdasite') TO s_browse[1].b_srdasite
            DISPLAY asrt900_filter_parser('srda006') TO s_browse[1].b_srda006
      
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
 
      CALL asrt900_filter_show('srda000')
   CALL asrt900_filter_show('srda001')
   CALL asrt900_filter_show('srda002')
   CALL asrt900_filter_show('srda003')
   CALL asrt900_filter_show('srda004')
   CALL asrt900_filter_show('srda005')
   CALL asrt900_filter_show('srdasite')
   CALL asrt900_filter_show('srda006')
 
END FUNCTION
 
{</section>}
 
{<section id="asrt900.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION asrt900_filter_parser(ps_field)
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
 
{<section id="asrt900.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION asrt900_filter_show(ps_field)
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
   LET ls_condition = asrt900_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="asrt900.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION asrt900_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
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
   CALL g_srdb_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL asrt900_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL asrt900_browser_fill("")
      CALL asrt900_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx_list[1] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL asrt900_filter_show('srda000')
   CALL asrt900_filter_show('srda001')
   CALL asrt900_filter_show('srda002')
   CALL asrt900_filter_show('srda003')
   CALL asrt900_filter_show('srda004')
   CALL asrt900_filter_show('srda005')
   CALL asrt900_filter_show('srdasite')
   CALL asrt900_filter_show('srda006')
   CALL asrt900_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL asrt900_fetch("F") 
      #顯示單身筆數
      CALL asrt900_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="asrt900.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION asrt900_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
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
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
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
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_srda_m.srdasite = g_browser[g_current_idx].b_srdasite
   LET g_srda_m.srda000 = g_browser[g_current_idx].b_srda000
   LET g_srda_m.srda001 = g_browser[g_current_idx].b_srda001
   LET g_srda_m.srda002 = g_browser[g_current_idx].b_srda002
   LET g_srda_m.srda003 = g_browser[g_current_idx].b_srda003
   LET g_srda_m.srda004 = g_browser[g_current_idx].b_srda004
   LET g_srda_m.srda005 = g_browser[g_current_idx].b_srda005
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE asrt900_master_referesh USING g_srda_m.srdasite,g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002, 
       g_srda_m.srda003,g_srda_m.srda004,g_srda_m.srda005 INTO g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002, 
       g_srda_m.srda003,g_srda_m.srdasite,g_srda_m.srda004,g_srda_m.srda005,g_srda_m.srda006,g_srda_m.srda002_desc, 
       g_srda_m.srda003_desc,g_srda_m.srda005_desc
   
   #遮罩相關處理
   LET g_srda_m_mask_o.* =  g_srda_m.*
   CALL asrt900_srda_t_mask()
   LET g_srda_m_mask_n.* =  g_srda_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asrt900_set_act_visible()   
   CALL asrt900_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_srda_m_t.* = g_srda_m.*
   LET g_srda_m_o.* = g_srda_m.*
   
   
   #重新顯示   
   CALL asrt900_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="asrt900.insert" >}
#+ 資料新增
PRIVATE FUNCTION asrt900_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_srdb_d.clear()   
 
 
   INITIALIZE g_srda_m.* TO NULL             #DEFAULT 設定
   
   LET g_srdasite_t = NULL
   LET g_srda000_t = NULL
   LET g_srda001_t = NULL
   LET g_srda002_t = NULL
   LET g_srda003_t = NULL
   LET g_srda004_t = NULL
   LET g_srda005_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_srda_m.srda000 = "0"
      LET g_srda_m.srda001 = "0"
      LET g_srda_m.srda006 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_srda_m.srdasite = g_site
      LET g_srda_m.srda000 = ''
      LET g_srda_m.srda001 = ''
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_srda_m_t.* = g_srda_m.*
      LET g_srda_m_o.* = g_srda_m.*
      
      #顯示狀態(stus)圖片
      
    
      CALL asrt900_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
  
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_srda_m.* TO NULL
         INITIALIZE g_srdb_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL asrt900_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_srdb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asrt900_set_act_visible()   
   CALL asrt900_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_srdasite_t = g_srda_m.srdasite
   LET g_srda000_t = g_srda_m.srda000
   LET g_srda001_t = g_srda_m.srda001
   LET g_srda002_t = g_srda_m.srda002
   LET g_srda003_t = g_srda_m.srda003
   LET g_srda004_t = g_srda_m.srda004
   LET g_srda005_t = g_srda_m.srda005
 
   
   #組合新增資料的條件
   LET g_add_browse = " srdaent = " ||g_enterprise|| " AND",
                      " srdasite = '", g_srda_m.srdasite, "' "
                      ," AND srda000 = '", g_srda_m.srda000, "' "
                      ," AND srda001 = '", g_srda_m.srda001, "' "
                      ," AND srda002 = '", g_srda_m.srda002, "' "
                      ," AND srda003 = '", g_srda_m.srda003, "' "
                      ," AND srda004 = '", g_srda_m.srda004, "' "
                      ," AND srda005 = '", g_srda_m.srda005, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   LET g_add_browse = ''
   LET g_wc = " srda000 = ",g_srda_m.srda000," AND srda001 = ",g_srda_m.srda001
   CALL asrt900_browser_fill("F")
   CALL asrt900_fetch("F")
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE asrt900_cl
   
   CALL asrt900_idx_chk()
   IF 1=2 THEN
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL asrt900_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE asrt900_cl
   
   CALL asrt900_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE asrt900_master_referesh USING g_srda_m.srdasite,g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002, 
       g_srda_m.srda003,g_srda_m.srda004,g_srda_m.srda005 INTO g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002, 
       g_srda_m.srda003,g_srda_m.srdasite,g_srda_m.srda004,g_srda_m.srda005,g_srda_m.srda006,g_srda_m.srda002_desc, 
       g_srda_m.srda003_desc,g_srda_m.srda005_desc
   
   
   #遮罩相關處理
   LET g_srda_m_mask_o.* =  g_srda_m.*
   CALL asrt900_srda_t_mask()
   LET g_srda_m_mask_n.* =  g_srda_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002,g_srda_m.srda002_desc,g_srda_m.srda003, 
       g_srda_m.srda003_desc,g_srda_m.srda003_desc_1,g_srda_m.srdasite,g_srda_m.srda004,g_srda_m.srda005, 
       g_srda_m.srda005_desc,g_srda_m.srda006
   
   #add-point:新增結束後 name="insert.after"
   END IF
   #end add-point 
   
   
   #功能已完成,通報訊息中心
   CALL asrt900_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.modify" >}
#+ 資料修改
PRIVATE FUNCTION asrt900_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_srda_m_t.* = g_srda_m.*
   LET g_srda_m_o.* = g_srda_m.*
   
   IF g_srda_m.srdasite IS NULL
   OR g_srda_m.srda000 IS NULL
   OR g_srda_m.srda001 IS NULL
   OR g_srda_m.srda002 IS NULL
   OR g_srda_m.srda003 IS NULL
   OR g_srda_m.srda004 IS NULL
   OR g_srda_m.srda005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_srdasite_t = g_srda_m.srdasite
   LET g_srda000_t = g_srda_m.srda000
   LET g_srda001_t = g_srda_m.srda001
   LET g_srda002_t = g_srda_m.srda002
   LET g_srda003_t = g_srda_m.srda003
   LET g_srda004_t = g_srda_m.srda004
   LET g_srda005_t = g_srda_m.srda005
 
   CALL s_transaction_begin()
   
   OPEN asrt900_cl USING g_enterprise,g_srda_m.srdasite,g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002,g_srda_m.srda003,g_srda_m.srda004,g_srda_m.srda005
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asrt900_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE asrt900_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE asrt900_master_referesh USING g_srda_m.srdasite,g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002, 
       g_srda_m.srda003,g_srda_m.srda004,g_srda_m.srda005 INTO g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002, 
       g_srda_m.srda003,g_srda_m.srdasite,g_srda_m.srda004,g_srda_m.srda005,g_srda_m.srda006,g_srda_m.srda002_desc, 
       g_srda_m.srda003_desc,g_srda_m.srda005_desc
   
   #檢查是否允許此動作
   IF NOT asrt900_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_srda_m_mask_o.* =  g_srda_m.*
   CALL asrt900_srda_t_mask()
   LET g_srda_m_mask_n.* =  g_srda_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL asrt900_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_srdasite_t = g_srda_m.srdasite
      LET g_srda000_t = g_srda_m.srda000
      LET g_srda001_t = g_srda_m.srda001
      LET g_srda002_t = g_srda_m.srda002
      LET g_srda003_t = g_srda_m.srda003
      LET g_srda004_t = g_srda_m.srda004
      LET g_srda005_t = g_srda_m.srda005
 
      
      #寫入修改者/修改日期資訊(單頭)
      
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL asrt900_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
 
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_srda_m.* = g_srda_m_t.*
            CALL asrt900_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_srda_m.srdasite != g_srda_m_t.srdasite
      OR g_srda_m.srda000 != g_srda_m_t.srda000
      OR g_srda_m.srda001 != g_srda_m_t.srda001
      OR g_srda_m.srda002 != g_srda_m_t.srda002
      OR g_srda_m.srda003 != g_srda_m_t.srda003
      OR g_srda_m.srda004 != g_srda_m_t.srda004
      OR g_srda_m.srda005 != g_srda_m_t.srda005
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE srdb_t SET srdbsite = g_srda_m.srdasite
                                       ,srdb000 = g_srda_m.srda000
                                       ,srdb001 = g_srda_m.srda001
                                       ,srdb002 = g_srda_m.srda002
                                       ,srdb003 = g_srda_m.srda003
                                       ,srdb004 = g_srda_m.srda004
                                       ,srdb005 = g_srda_m.srda005
 
          WHERE srdbent = g_enterprise AND srdbsite = g_srda_m_t.srdasite
            AND srdb000 = g_srda_m_t.srda000
            AND srdb001 = g_srda_m_t.srda001
            AND srdb002 = g_srda_m_t.srda002
            AND srdb003 = g_srda_m_t.srda003
            AND srdb004 = g_srda_m_t.srda004
            AND srdb005 = g_srda_m_t.srda005
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "srdb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "srdb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asrt900_set_act_visible()   
   CALL asrt900_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " srdaent = " ||g_enterprise|| " AND",
                      " srdasite = '", g_srda_m.srdasite, "' "
                      ," AND srda000 = '", g_srda_m.srda000, "' "
                      ," AND srda001 = '", g_srda_m.srda001, "' "
                      ," AND srda002 = '", g_srda_m.srda002, "' "
                      ," AND srda003 = '", g_srda_m.srda003, "' "
                      ," AND srda004 = '", g_srda_m.srda004, "' "
                      ," AND srda005 = '", g_srda_m.srda005, "' "
 
   #填到對應位置
   CALL asrt900_browser_fill("")
 
   CLOSE asrt900_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL asrt900_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="asrt900.input" >}
#+ 資料輸入
PRIVATE FUNCTION asrt900_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
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
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE  l_close_dd            LIKE type_t.dat
   DEFINE  l_yy                  LIKE glav_t.glav002
   DEFINE  l_ss                  LIKE glav_t.glav005
   DEFINE  l_mm                  LIKE glav_t.glav006
   DEFINE  l_ww                  LIKE glav_t.glav007
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_comp                LIKE ooef_t.ooef017
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
   DISPLAY BY NAME g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002,g_srda_m.srda002_desc,g_srda_m.srda003, 
       g_srda_m.srda003_desc,g_srda_m.srda003_desc_1,g_srda_m.srdasite,g_srda_m.srda004,g_srda_m.srda005, 
       g_srda_m.srda005_desc,g_srda_m.srda006
   
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
   LET g_forupd_sql = "SELECT srdbseq,srdb006,srdb007,srdb008,srdb009,srdb010,srdb011,srdb012,srdb013  
       FROM srdb_t WHERE srdbent=? AND srdbsite=? AND srdb000=? AND srdb001=? AND srdb002=? AND srdb003=?  
       AND srdb004=? AND srdb005=? AND srdbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   LET g_forupd_sql = "SELECT srdbseq,srdb006,srdb007,srdb008,srdb009,srdb010,srdb011,srdb012,srdb013  
       FROM srdb_t WHERE srdbent=? AND srdbsite =? AND srdb000=? AND srdb001=? AND srdb002=? AND srdb003=? AND srdb004=?  
       AND srdb005=? AND srdbseq=? FOR UPDATE"
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt900_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL asrt900_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL asrt900_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_srda_m.srda000,g_srda_m.srda001
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="asrt900.input.head" >}
      #單頭段
      INPUT BY NAME g_srda_m.srda000,g_srda_m.srda001 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN asrt900_cl USING g_enterprise,g_srda_m.srdasite,g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002,g_srda_m.srda003,g_srda_m.srda004,g_srda_m.srda005
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asrt900_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asrt900_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL asrt900_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            #关账日期
            LET l_close_dd = cl_get_para(g_enterprise,g_site,'S-FIN-6012')                
            #先找出成本关账日期所在年期
            SELECT ooef017 INTO l_comp FROM ooef_t 
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
               
            SELECT glaald,glaa003 INTO g_ld,g_glav001 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = l_comp   
               AND glaa014 = 'Y'
               
            CALL s_fin_date_get_yspw('',g_ld,l_close_dd) RETURNING l_success,l_yy,l_ss,l_mm,l_ww 
            #end add-point
            CALL asrt900_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srda000
            #add-point:BEFORE FIELD srda000 name="input.b.srda000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srda000
            
            #add-point:AFTER FIELD srda000 name="input.a.srda000"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF NOT cl_null(g_srda_m.srda000) AND NOT cl_null(l_close_dd) THEN
               IF g_srda_m.srda000 < l_yy THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_srda_m.srda000 
                  LET g_errparam.code   = "asf-00449"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD srda000
               END IF   
               IF NOT cl_null(g_srda_m.srda001) THEN
                  IF g_srda_m.srda000 = l_yy AND g_srda_m.srda001 <= l_mm THEN
                     LET g_errparam.extend = g_srda_m.srda000 
                     LET g_errparam.code   = "asf-00449"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD srda000
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_srda_m.srda000) AND NOT cl_null(g_srda_m.srda001) THEN
               IF NOT asrt900_gen() THEN
                  NEXT FIELD srda000
               ELSE
                  EXIT DIALOG
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srda000
            #add-point:ON CHANGE srda000 name="input.g.srda000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srda001
            #add-point:BEFORE FIELD srda001 name="input.b.srda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srda001
            
            #add-point:AFTER FIELD srda001 name="input.a.srda001"
            #應用 a05 樣板自動產生(Version:2)
            IF NOT cl_null(g_srda_m.srda001) AND NOT cl_null(g_srda_m.srda000) AND NOT cl_null(l_close_dd) THEN
               IF g_srda_m.srda000 < l_yy THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_srda_m.srda000 
                  LET g_errparam.code   = "asf-00449"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD srda000
               END IF   
               IF g_srda_m.srda000 = l_yy AND g_srda_m.srda001 <= l_mm THEN
                  LET g_errparam.extend = g_srda_m.srda001
                  LET g_errparam.code   = "asf-00449"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD srda001
               END IF
            END IF
            
            IF NOT cl_null(g_srda_m.srda000) AND NOT cl_null(g_srda_m.srda001) THEN
               IF NOT asrt900_gen() THEN
                  NEXT FIELD srda001
               ELSE
                  EXIT DIALOG
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srda001
            #add-point:ON CHANGE srda001 name="input.g.srda001"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.srda000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srda000
            #add-point:ON ACTION controlp INFIELD srda000 name="input.c.srda000"
            
            #END add-point
 
 
         #Ctrlp:input.c.srda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srda001
            #add-point:ON ACTION controlp INFIELD srda001 name="input.c.srda001"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_srda_m.srdasite,g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002,g_srda_m.srda003, 
                g_srda_m.srda004,g_srda_m.srda005
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO srda_t (srdaent,srda000,srda001,srda002,srda003,srdasite,srda004,srda005, 
                   srda006)
               VALUES (g_enterprise,g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002,g_srda_m.srda003, 
                   g_srda_m.srdasite,g_srda_m.srda004,g_srda_m.srda005,g_srda_m.srda006) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_srda_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL asrt900_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL asrt900_b_fill()
                  CALL asrt900_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL asrt900_srda_t_mask_restore('restore_mask_o')
               
               UPDATE srda_t SET (srda000,srda001,srda002,srda003,srdasite,srda004,srda005,srda006) = (g_srda_m.srda000, 
                   g_srda_m.srda001,g_srda_m.srda002,g_srda_m.srda003,g_srda_m.srdasite,g_srda_m.srda004, 
                   g_srda_m.srda005,g_srda_m.srda006)
                WHERE srdaent = g_enterprise AND srdasite = g_srdasite_t
                  AND srda000 = g_srda000_t
                  AND srda001 = g_srda001_t
                  AND srda002 = g_srda002_t
                  AND srda003 = g_srda003_t
                  AND srda004 = g_srda004_t
                  AND srda005 = g_srda005_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "srda_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL asrt900_srda_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_srda_m_t)
               LET g_log2 = util.JSON.stringify(g_srda_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_srdasite_t = g_srda_m.srdasite
            LET g_srda000_t = g_srda_m.srda000
            LET g_srda001_t = g_srda_m.srda001
            LET g_srda002_t = g_srda_m.srda002
            LET g_srda003_t = g_srda_m.srda003
            LET g_srda004_t = g_srda_m.srda004
            LET g_srda005_t = g_srda_m.srda005
 
            
      END INPUT
   
 
{</section>}
 
{<section id="asrt900.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_srdb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_srdb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asrt900_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_srdb_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN asrt900_cl USING g_enterprise,g_srda_m.srdasite,g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002,g_srda_m.srda003,g_srda_m.srda004,g_srda_m.srda005
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asrt900_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asrt900_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_srdb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_srdb_d[l_ac].srdbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_srdb_d_t.* = g_srdb_d[l_ac].*  #BACKUP
               LET g_srdb_d_o.* = g_srdb_d[l_ac].*  #BACKUP
               CALL asrt900_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL asrt900_set_no_entry_b(l_cmd)
               IF NOT asrt900_lock_b("srdb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asrt900_bcl INTO g_srdb_d[l_ac].srdbseq,g_srdb_d[l_ac].srdb006,g_srdb_d[l_ac].srdb007, 
                      g_srdb_d[l_ac].srdb008,g_srdb_d[l_ac].srdb009,g_srdb_d[l_ac].srdb010,g_srdb_d[l_ac].srdb011, 
                      g_srdb_d[l_ac].srdb012,g_srdb_d[l_ac].srdb013
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_srdb_d_t.srdbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_srdb_d_mask_o[l_ac].* =  g_srdb_d[l_ac].*
                  CALL asrt900_srdb_t_mask()
                  LET g_srdb_d_mask_n[l_ac].* =  g_srdb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL asrt900_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_srdb_d[l_ac].* TO NULL 
            INITIALIZE g_srdb_d_t.* TO NULL 
            INITIALIZE g_srdb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_srdb_d[l_ac].srdbseq = "0"
      LET g_srdb_d[l_ac].srdb007 = "0"
      LET g_srdb_d[l_ac].srdb008 = "0"
      LET g_srdb_d[l_ac].srdb009 = "0"
      LET g_srdb_d[l_ac].srdb010 = "0"
      LET g_srdb_d[l_ac].srdb011 = "0"
      LET g_srdb_d[l_ac].srdb012 = "0"
      LET g_srdb_d[l_ac].srdb013 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_srdb_d_t.* = g_srdb_d[l_ac].*     #新輸入資料
            LET g_srdb_d_o.* = g_srdb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asrt900_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL asrt900_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_srdb_d[li_reproduce_target].* = g_srdb_d[li_reproduce].*
 
               LET g_srdb_d[li_reproduce_target].srdbseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM srdb_t 
             WHERE srdbent = g_enterprise AND srdbsite = g_srda_m.srdasite
               AND srdb000 = g_srda_m.srda000
               AND srdb001 = g_srda_m.srda001
               AND srdb002 = g_srda_m.srda002
               AND srdb003 = g_srda_m.srda003
               AND srdb004 = g_srda_m.srda004
               AND srdb005 = g_srda_m.srda005
 
               AND srdbseq = g_srdb_d[l_ac].srdbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srda_m.srdasite
               LET gs_keys[2] = g_srda_m.srda000
               LET gs_keys[3] = g_srda_m.srda001
               LET gs_keys[4] = g_srda_m.srda002
               LET gs_keys[5] = g_srda_m.srda003
               LET gs_keys[6] = g_srda_m.srda004
               LET gs_keys[7] = g_srda_m.srda005
               LET gs_keys[8] = g_srdb_d[g_detail_idx].srdbseq
               CALL asrt900_insert_b('srdb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_srdb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "srdb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asrt900_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_srda_m.srdasite
               LET gs_keys[gs_keys.getLength()+1] = g_srda_m.srda000
               LET gs_keys[gs_keys.getLength()+1] = g_srda_m.srda001
               LET gs_keys[gs_keys.getLength()+1] = g_srda_m.srda002
               LET gs_keys[gs_keys.getLength()+1] = g_srda_m.srda003
               LET gs_keys[gs_keys.getLength()+1] = g_srda_m.srda004
               LET gs_keys[gs_keys.getLength()+1] = g_srda_m.srda005
 
               LET gs_keys[gs_keys.getLength()+1] = g_srdb_d_t.srdbseq
 
            
               #刪除同層單身
               IF NOT asrt900_delete_b('srdb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asrt900_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT asrt900_key_delete_b(gs_keys,'srdb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asrt900_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE asrt900_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_srdb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_srdb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srdb013
            #add-point:BEFORE FIELD srdb013 name="input.b.page1.srdb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srdb013
            
            #add-point:AFTER FIELD srdb013 name="input.a.page1.srdb013"
            IF NOT cl_ap_chk_Range(g_srdb_d[l_ac].srdb013,"0","1","","","azz-00079",1) THEN
               LET g_srdb_d[l_ac].srdb013 = g_srdb_d_t.srdb013
               NEXT FIELD srdb013
            END IF
            IF NOT cl_null(g_srdb_d[l_ac].srdb013) THEN
               LET g_srdb_d[l_ac].srdb011 = (g_srdb_d[l_ac].srdb008 + g_srdb_d[l_ac].srdb009) - g_srdb_d[l_ac].srdb013
               IF g_srdb_d[l_ac].srdb011 < 0 THEN
                  LET g_srdb_d[l_ac].srdb011 = 0
               END IF
            END IF
            
         AFTER FIELD srdb011
            IF NOT cl_ap_chk_Range(g_srdb_d[l_ac].srdb011,"0","1","","","azz-00079",1) THEN
               LET g_srdb_d[l_ac].srdb011 = g_srdb_d_t.srdb011
               NEXT FIELD srdb011
            END IF
            IF NOT cl_null(g_srdb_d[l_ac].srdb011) THEN
               LET g_srdb_d[l_ac].srdb013 = (g_srdb_d[l_ac].srdb008 + g_srdb_d[l_ac].srdb009) - g_srdb_d[l_ac].srdb011
               IF g_srdb_d[l_ac].srdb013 < 0 THEN
                  LET g_srdb_d[l_ac].srdb013 = 0
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srdb013
            #add-point:ON CHANGE srdb013 name="input.g.page1.srdb013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.srdb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srdb013
            #add-point:ON ACTION controlp INFIELD srdb013 name="input.c.page1.srdb013"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_srdb_d[l_ac].* = g_srdb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE asrt900_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_srdb_d[l_ac].srdbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_srdb_d[l_ac].* = g_srdb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL asrt900_srdb_t_mask_restore('restore_mask_o')
      
               UPDATE srdb_t SET (srdbsite,srdb000,srdb001,srdb002,srdb003,srdb004,srdb005,srdbseq,srdb006, 
                   srdb007,srdb008,srdb009,srdb010,srdb011,srdb012,srdb013) = (g_srda_m.srdasite,g_srda_m.srda000, 
                   g_srda_m.srda001,g_srda_m.srda002,g_srda_m.srda003,g_srda_m.srda004,g_srda_m.srda005, 
                   g_srdb_d[l_ac].srdbseq,g_srdb_d[l_ac].srdb006,g_srdb_d[l_ac].srdb007,g_srdb_d[l_ac].srdb008, 
                   g_srdb_d[l_ac].srdb009,g_srdb_d[l_ac].srdb010,g_srdb_d[l_ac].srdb011,g_srdb_d[l_ac].srdb012, 
                   g_srdb_d[l_ac].srdb013)
                WHERE srdbent = g_enterprise AND srdbsite = g_srda_m.srdasite 
                  AND srdb000 = g_srda_m.srda000 
                  AND srdb001 = g_srda_m.srda001 
                  AND srdb002 = g_srda_m.srda002 
                  AND srdb003 = g_srda_m.srda003 
                  AND srdb004 = g_srda_m.srda004 
                  AND srdb005 = g_srda_m.srda005 
 
                  AND srdbseq = g_srdb_d_t.srdbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_srdb_d[l_ac].* = g_srdb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "srdb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_srdb_d[l_ac].* = g_srdb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "srdb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srda_m.srdasite
               LET gs_keys_bak[1] = g_srdasite_t
               LET gs_keys[2] = g_srda_m.srda000
               LET gs_keys_bak[2] = g_srda000_t
               LET gs_keys[3] = g_srda_m.srda001
               LET gs_keys_bak[3] = g_srda001_t
               LET gs_keys[4] = g_srda_m.srda002
               LET gs_keys_bak[4] = g_srda002_t
               LET gs_keys[5] = g_srda_m.srda003
               LET gs_keys_bak[5] = g_srda003_t
               LET gs_keys[6] = g_srda_m.srda004
               LET gs_keys_bak[6] = g_srda004_t
               LET gs_keys[7] = g_srda_m.srda005
               LET gs_keys_bak[7] = g_srda005_t
               LET gs_keys[8] = g_srdb_d[g_detail_idx].srdbseq
               LET gs_keys_bak[8] = g_srdb_d_t.srdbseq
               CALL asrt900_update_b('srdb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL asrt900_srdb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_srdb_d[g_detail_idx].srdbseq = g_srdb_d_t.srdbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_srda_m.srdasite
                  LET gs_keys[gs_keys.getLength()+1] = g_srda_m.srda000
                  LET gs_keys[gs_keys.getLength()+1] = g_srda_m.srda001
                  LET gs_keys[gs_keys.getLength()+1] = g_srda_m.srda002
                  LET gs_keys[gs_keys.getLength()+1] = g_srda_m.srda003
                  LET gs_keys[gs_keys.getLength()+1] = g_srda_m.srda004
                  LET gs_keys[gs_keys.getLength()+1] = g_srda_m.srda005
 
                  LET gs_keys[gs_keys.getLength()+1] = g_srdb_d_t.srdbseq
 
                  CALL asrt900_key_update_b(gs_keys,'srdb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_srda_m),util.JSON.stringify(g_srdb_d_t)
               LET g_log2 = util.JSON.stringify(g_srda_m),util.JSON.stringify(g_srdb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL asrt900_unlock_b("srdb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_srdb_d[li_reproduce_target].* = g_srdb_d[li_reproduce].*
 
               LET g_srdb_d[li_reproduce_target].srdbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_srdb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_srdb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="asrt900.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD srda000
         ELSE
            IF p_cmd = 'b' THEN
               NEXT FIELD srdb011
            END IF
         END IF
         IF 1 =2 THEN
            #end add-point  
            NEXT FIELD srdasite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD srdbseq
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
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
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="asrt900.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION asrt900_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL asrt900_b_fill() #單身填充
      CALL asrt900_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL asrt900_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   SELECT imaal004 INTO g_srda_m.srda003_desc_1 FROM imaal_t
    WHERE imaalent = g_enterprise AND imaal001 = g_srda_m.srda003 AND imaal002 = g_dlang
   CALL s_feature_description(g_srda_m.srda003,g_srda_m.srda005)
        RETURNING l_success,g_srda_m.srda005_desc
   IF NOT l_success THEN
      LET g_srda_m.srda005_desc = ''
   END IF
   #end add-point
   
   #遮罩相關處理
   LET g_srda_m_mask_o.* =  g_srda_m.*
   CALL asrt900_srda_t_mask()
   LET g_srda_m_mask_n.* =  g_srda_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002,g_srda_m.srda002_desc,g_srda_m.srda003, 
       g_srda_m.srda003_desc,g_srda_m.srda003_desc_1,g_srda_m.srdasite,g_srda_m.srda004,g_srda_m.srda005, 
       g_srda_m.srda005_desc,g_srda_m.srda006
   
   #顯示狀態(stus)圖片
   
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_srdb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL asrt900_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION asrt900_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION asrt900_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE srda_t.srdasite 
   DEFINE l_oldno     LIKE srda_t.srdasite 
   DEFINE l_newno02     LIKE srda_t.srda000 
   DEFINE l_oldno02     LIKE srda_t.srda000 
   DEFINE l_newno03     LIKE srda_t.srda001 
   DEFINE l_oldno03     LIKE srda_t.srda001 
   DEFINE l_newno04     LIKE srda_t.srda002 
   DEFINE l_oldno04     LIKE srda_t.srda002 
   DEFINE l_newno05     LIKE srda_t.srda003 
   DEFINE l_oldno05     LIKE srda_t.srda003 
   DEFINE l_newno06     LIKE srda_t.srda004 
   DEFINE l_oldno06     LIKE srda_t.srda004 
   DEFINE l_newno07     LIKE srda_t.srda005 
   DEFINE l_oldno07     LIKE srda_t.srda005 
 
   DEFINE l_master    RECORD LIKE srda_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE srdb_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_srda_m.srdasite IS NULL
   OR g_srda_m.srda000 IS NULL
   OR g_srda_m.srda001 IS NULL
   OR g_srda_m.srda002 IS NULL
   OR g_srda_m.srda003 IS NULL
   OR g_srda_m.srda004 IS NULL
   OR g_srda_m.srda005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_srdasite_t = g_srda_m.srdasite
   LET g_srda000_t = g_srda_m.srda000
   LET g_srda001_t = g_srda_m.srda001
   LET g_srda002_t = g_srda_m.srda002
   LET g_srda003_t = g_srda_m.srda003
   LET g_srda004_t = g_srda_m.srda004
   LET g_srda005_t = g_srda_m.srda005
 
    
   LET g_srda_m.srdasite = ""
   LET g_srda_m.srda000 = ""
   LET g_srda_m.srda001 = ""
   LET g_srda_m.srda002 = ""
   LET g_srda_m.srda003 = ""
   LET g_srda_m.srda004 = ""
   LET g_srda_m.srda005 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
      LET g_srda_m.srda002_desc = ''
   DISPLAY BY NAME g_srda_m.srda002_desc
   LET g_srda_m.srda003_desc = ''
   DISPLAY BY NAME g_srda_m.srda003_desc
   LET g_srda_m.srda003_desc_1 = ''
   DISPLAY BY NAME g_srda_m.srda003_desc_1
   LET g_srda_m.srda005_desc = ''
   DISPLAY BY NAME g_srda_m.srda005_desc
 
   
   CALL asrt900_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_srda_m.* TO NULL
      INITIALIZE g_srdb_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL asrt900_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asrt900_set_act_visible()   
   CALL asrt900_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_srdasite_t = g_srda_m.srdasite
   LET g_srda000_t = g_srda_m.srda000
   LET g_srda001_t = g_srda_m.srda001
   LET g_srda002_t = g_srda_m.srda002
   LET g_srda003_t = g_srda_m.srda003
   LET g_srda004_t = g_srda_m.srda004
   LET g_srda005_t = g_srda_m.srda005
 
   
   #組合新增資料的條件
   LET g_add_browse = " srdaent = " ||g_enterprise|| " AND",
                      " srdasite = '", g_srda_m.srdasite, "' "
                      ," AND srda000 = '", g_srda_m.srda000, "' "
                      ," AND srda001 = '", g_srda_m.srda001, "' "
                      ," AND srda002 = '", g_srda_m.srda002, "' "
                      ," AND srda003 = '", g_srda_m.srda003, "' "
                      ," AND srda004 = '", g_srda_m.srda004, "' "
                      ," AND srda005 = '", g_srda_m.srda005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL asrt900_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL asrt900_idx_chk()
   
   
   #功能已完成,通報訊息中心
   CALL asrt900_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="asrt900.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION asrt900_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE srdb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE asrt900_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM srdb_t
    WHERE srdbent = g_enterprise AND srdbsite = g_srdasite_t
     AND srdb000 = g_srda000_t
     AND srdb001 = g_srda001_t
     AND srdb002 = g_srda002_t
     AND srdb003 = g_srda003_t
     AND srdb004 = g_srda004_t
     AND srdb005 = g_srda005_t
 
    INTO TEMP asrt900_detail
 
   #將key修正為調整後   
   UPDATE asrt900_detail 
      #更新key欄位
      SET srdbsite = g_srda_m.srdasite
          , srdb000 = g_srda_m.srda000
          , srdb001 = g_srda_m.srda001
          , srdb002 = g_srda_m.srda002
          , srdb003 = g_srda_m.srda003
          , srdb004 = g_srda_m.srda004
          , srdb005 = g_srda_m.srda005
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO srdb_t SELECT * FROM asrt900_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE asrt900_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_srdasite_t = g_srda_m.srdasite
   LET g_srda000_t = g_srda_m.srda000
   LET g_srda001_t = g_srda_m.srda001
   LET g_srda002_t = g_srda_m.srda002
   LET g_srda003_t = g_srda_m.srda003
   LET g_srda004_t = g_srda_m.srda004
   LET g_srda005_t = g_srda_m.srda005
 
   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.delete" >}
#+ 資料刪除
PRIVATE FUNCTION asrt900_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_srda_m.srdasite IS NULL
   OR g_srda_m.srda000 IS NULL
   OR g_srda_m.srda001 IS NULL
   OR g_srda_m.srda002 IS NULL
   OR g_srda_m.srda003 IS NULL
   OR g_srda_m.srda004 IS NULL
   OR g_srda_m.srda005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN asrt900_cl USING g_enterprise,g_srda_m.srdasite,g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002,g_srda_m.srda003,g_srda_m.srda004,g_srda_m.srda005
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asrt900_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE asrt900_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE asrt900_master_referesh USING g_srda_m.srdasite,g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002, 
       g_srda_m.srda003,g_srda_m.srda004,g_srda_m.srda005 INTO g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002, 
       g_srda_m.srda003,g_srda_m.srdasite,g_srda_m.srda004,g_srda_m.srda005,g_srda_m.srda006,g_srda_m.srda002_desc, 
       g_srda_m.srda003_desc,g_srda_m.srda005_desc
   
   
   #檢查是否允許此動作
   IF NOT asrt900_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_srda_m_mask_o.* =  g_srda_m.*
   CALL asrt900_srda_t_mask()
   LET g_srda_m_mask_n.* =  g_srda_m.*
   
   CALL asrt900_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asrt900_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_srdasite_t = g_srda_m.srdasite
      LET g_srda000_t = g_srda_m.srda000
      LET g_srda001_t = g_srda_m.srda001
      LET g_srda002_t = g_srda_m.srda002
      LET g_srda003_t = g_srda_m.srda003
      LET g_srda004_t = g_srda_m.srda004
      LET g_srda005_t = g_srda_m.srda005
 
 
      DELETE FROM srda_t
       WHERE srdaent = g_enterprise AND srdasite = g_srda_m.srdasite
         AND srda000 = g_srda_m.srda000
         AND srda001 = g_srda_m.srda001
         AND srda002 = g_srda_m.srda002
         AND srda003 = g_srda_m.srda003
         AND srda004 = g_srda_m.srda004
         AND srda005 = g_srda_m.srda005
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_srda_m.srdasite,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM srdb_t
       WHERE srdbent = g_enterprise AND srdbsite = g_srda_m.srdasite
         AND srdb000 = g_srda_m.srda000
         AND srdb001 = g_srda_m.srda001
         AND srdb002 = g_srda_m.srda002
         AND srdb003 = g_srda_m.srda003
         AND srdb004 = g_srda_m.srda004
         AND srdb005 = g_srda_m.srda005
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srdb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_srda_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE asrt900_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_srdb_d.clear() 
 
     
      CALL asrt900_ui_browser_refresh()  
      #CALL asrt900_ui_headershow()  
      #CALL asrt900_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL asrt900_browser_fill("")
         CALL asrt900_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE asrt900_cl
 
   #功能已完成,通報訊息中心
   CALL asrt900_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="asrt900.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asrt900_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_srdb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF asrt900_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT srdbseq,srdb006,srdb007,srdb008,srdb009,srdb010,srdb011,srdb012, 
             srdb013 ,t1.imaal003 ,t2.imecl005 FROM srdb_t",   
                     " INNER JOIN srda_t ON srdaent = " ||g_enterprise|| " AND srdasite = srdbsite ",
                     " AND srda000 = srdb000 ",
                     " AND srda001 = srdb001 ",
                     " AND srda002 = srdb002 ",
                     " AND srda003 = srdb003 ",
                     " AND srda004 = srdb004 ",
                     " AND srda005 = srdb005 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=srdb006 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imecl_t t2 ON t2.imeclent="||g_enterprise||" AND t2.imecl003=srdb007 AND t2.imecl004='"||g_dlang||"' ",
 
                     " WHERE srdbent=? AND srdbsite=? AND srdb000=? AND srdb001=? AND srdb002=? AND srdb003=? AND srdb004=? AND srdb005=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY srdb_t.srdbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE asrt900_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR asrt900_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_srda_m.srdasite,g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002,g_srda_m.srda003,g_srda_m.srda004,g_srda_m.srda005   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_srda_m.srdasite,g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002, 
          g_srda_m.srda003,g_srda_m.srda004,g_srda_m.srda005 INTO g_srdb_d[l_ac].srdbseq,g_srdb_d[l_ac].srdb006, 
          g_srdb_d[l_ac].srdb007,g_srdb_d[l_ac].srdb008,g_srdb_d[l_ac].srdb009,g_srdb_d[l_ac].srdb010, 
          g_srdb_d[l_ac].srdb011,g_srdb_d[l_ac].srdb012,g_srdb_d[l_ac].srdb013,g_srdb_d[l_ac].srdb006_desc, 
          g_srdb_d[l_ac].srdb007_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         SELECT imaal004 INTO g_srdb_d[l_ac].srdb006_desc_1 FROM imaal_t
          WHERE imaalent = g_enterprise AND imaal001 = g_srdb_d[l_ac].srdb006 AND imaal002 = g_dlang
         SELECT imae081 INTO g_srdb_d[l_ac].inag007 FROM imae_t
          WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = g_srdb_d[l_ac].srdb006
         IF cl_null(g_srdb_d[l_ac].inag007) THEN
            SELECT imaa006 INTO g_srdb_d[l_ac].inag007_desc FROM imaa_t 
             WHERE imaaent = g_enterprise AND imaa001 = g_srdb_d[l_ac].srdb006
         END IF
         SELECT oocal003 INTO g_srdb_d[l_ac].inag007_desc FROM oocal_t 
          WHERE oocalent = g_enterprise AND oocal001 = g_srdb_d[l_ac].inag007 AND oocal002=g_dlang
         CALL s_feature_description(g_srdb_d[l_ac].srdb006,g_srdb_d[l_ac].srdb007)
              RETURNING l_success,g_srdb_d[l_ac].srdb007_desc
         IF NOT l_success THEN
            LET g_srdb_d[l_ac].srdb007_desc = ''
         END IF
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_srdb_d.deleteElement(g_srdb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE asrt900_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_srdb_d.getLength()
      LET g_srdb_d_mask_o[l_ac].* =  g_srdb_d[l_ac].*
      CALL asrt900_srdb_t_mask()
      LET g_srdb_d_mask_n[l_ac].* =  g_srdb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="asrt900.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION asrt900_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM srdb_t
       WHERE srdbent = g_enterprise AND
         srdbsite = ps_keys_bak[1] AND srdb000 = ps_keys_bak[2] AND srdb001 = ps_keys_bak[3] AND srdb002 = ps_keys_bak[4] AND srdb003 = ps_keys_bak[5] AND srdb004 = ps_keys_bak[6] AND srdb005 = ps_keys_bak[7] AND srdbseq = ps_keys_bak[8]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_srdb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION asrt900_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO srdb_t
                  (srdbent,
                   srdbsite,srdb000,srdb001,srdb002,srdb003,srdb004,srdb005,
                   srdbseq
                   ,srdb006,srdb007,srdb008,srdb009,srdb010,srdb011,srdb012,srdb013) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8]
                   ,g_srdb_d[g_detail_idx].srdb006,g_srdb_d[g_detail_idx].srdb007,g_srdb_d[g_detail_idx].srdb008, 
                       g_srdb_d[g_detail_idx].srdb009,g_srdb_d[g_detail_idx].srdb010,g_srdb_d[g_detail_idx].srdb011, 
                       g_srdb_d[g_detail_idx].srdb012,g_srdb_d[g_detail_idx].srdb013)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srdb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_srdb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION asrt900_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
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
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
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
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "srdb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL asrt900_srdb_t_mask_restore('restore_mask_o')
               
      UPDATE srdb_t 
         SET (srdbsite,srdb000,srdb001,srdb002,srdb003,srdb004,srdb005,
              srdbseq
              ,srdb006,srdb007,srdb008,srdb009,srdb010,srdb011,srdb012,srdb013) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8]
              ,g_srdb_d[g_detail_idx].srdb006,g_srdb_d[g_detail_idx].srdb007,g_srdb_d[g_detail_idx].srdb008, 
                  g_srdb_d[g_detail_idx].srdb009,g_srdb_d[g_detail_idx].srdb010,g_srdb_d[g_detail_idx].srdb011, 
                  g_srdb_d[g_detail_idx].srdb012,g_srdb_d[g_detail_idx].srdb013) 
         WHERE srdbent = g_enterprise AND srdbsite = ps_keys_bak[1] AND srdb000 = ps_keys_bak[2] AND srdb001 = ps_keys_bak[3] AND srdb002 = ps_keys_bak[4] AND srdb003 = ps_keys_bak[5] AND srdb004 = ps_keys_bak[6] AND srdb005 = ps_keys_bak[7] AND srdbseq = ps_keys_bak[8]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "srdb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "srdb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL asrt900_srdb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION asrt900_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION asrt900_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION asrt900_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL asrt900_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "srdb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN asrt900_bcl USING g_enterprise,
                                       g_srda_m.srdasite,g_srda_m.srda000,g_srda_m.srda001,g_srda_m.srda002, 
                                           g_srda_m.srda003,g_srda_m.srda004,g_srda_m.srda005,g_srdb_d[g_detail_idx].srdbseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asrt900_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="asrt900.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION asrt900_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE asrt900_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="asrt900.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION asrt900_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("srdasite,srda000,srda001,srda002,srda003,srda004,srda005",TRUE)
      CALL cl_set_comp_entry("",TRUE)
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
 
{<section id="asrt900.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION asrt900_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("srdasite,srda000,srda001,srda002,srda003,srda004,srda005",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asrt900.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION asrt900_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="asrt900.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION asrt900_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      CALL cl_set_comp_entry("srdbseq,srdb006,srdb007,srdb008,srdb009,srdb010,srdb012,inag007",FALSE)
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
 
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="asrt900.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION asrt900_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION asrt900_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION asrt900_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION asrt900_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION asrt900_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " srdasite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " srda000 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " srda001 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " srda002 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " srda003 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " srda004 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " srda005 = '", g_argv[07], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "srda_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "srdb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
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
 
{<section id="asrt900.state_change" >}
   
 
{</section>}
 
{<section id="asrt900.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION asrt900_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_srdb_d.getLength() THEN
         LET g_detail_idx = g_srdb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_srdb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_srdb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asrt900_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL asrt900_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION asrt900_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="asrt900.status_show" >}
PRIVATE FUNCTION asrt900_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asrt900.mask_functions" >}
&include "erp/asr/asrt900_mask.4gl"
 
{</section>}
 
{<section id="asrt900.signature" >}
   
 
{</section>}
 
{<section id="asrt900.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION asrt900_set_pk_array()
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
   LET g_pk_array[1].values = g_srda_m.srdasite
   LET g_pk_array[1].column = 'srdasite'
   LET g_pk_array[2].values = g_srda_m.srda000
   LET g_pk_array[2].column = 'srda000'
   LET g_pk_array[3].values = g_srda_m.srda001
   LET g_pk_array[3].column = 'srda001'
   LET g_pk_array[4].values = g_srda_m.srda002
   LET g_pk_array[4].column = 'srda002'
   LET g_pk_array[5].values = g_srda_m.srda003
   LET g_pk_array[5].column = 'srda003'
   LET g_pk_array[6].values = g_srda_m.srda004
   LET g_pk_array[6].column = 'srda004'
   LET g_pk_array[7].values = g_srda_m.srda005
   LET g_pk_array[7].column = 'srda005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asrt900.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="asrt900.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION asrt900_msgcentre_notify(lc_state)
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
   CALL asrt900_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_srda_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asrt900.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION asrt900_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="asrt900.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt900_gen()
DEFINE r_success              LIKE type_t.num5
DEFINE l_n                    LIKE type_t.num5
DEFINE l_success              LIKE type_t.num5

   LET r_success = FALSE
   
   SELECT COUNT(*) INTO l_n FROM srda_t
    WHERE srdaent = g_enterprise AND srdasite = g_site 
      AND srda000 = g_srda_m.srda000 AND srda001 = g_srda_m.srda001
      
   CALL s_transaction_begin()
   LET l_success = TRUE
   IF l_n > 0 THEN
      IF cl_ask_confirm('asf-00448') THEN
         CALL asrt900_gen_1() RETURNING l_success
      END IF
   ELSE
      CALL asrt900_gen_1() RETURNING l_success
   END IF
   IF l_success THEN
      CALL s_transaction_end('Y','0')
      LET r_success = TRUE
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 产生对应重复性生产当期资料
# Memo...........:
# Usage..........: CALL asrt900_gen_1()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success           LIKE type_t.num5
# Date & Author..: 20150507 By wuxja
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt900_gen_1()
DEFINE r_success                LIKE type_t.num5
DEFINE l_bdate                  LIKE type_t.dat
DEFINE l_edate                  LIKE type_t.dat
DEFINE l_sql                    STRING
#DEFINE l_srab                   RECORD LIKE srab_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srab RECORD  #重覆性生產計畫單身檔
       srabent LIKE srab_t.srabent, #企业编号
       srabsite LIKE srab_t.srabsite, #营运据点
       srab000 LIKE srab_t.srab000, #版本
       srab001 LIKE srab_t.srab001, #生产计划
       srab002 LIKE srab_t.srab002, #年
       srab003 LIKE srab_t.srab003, #月
       srab004 LIKE srab_t.srab004, #料件编号
       srab005 LIKE srab_t.srab005, #BOM特性
       srab006 LIKE srab_t.srab006, #产品特征
       srab007 LIKE srab_t.srab007, #工艺管理
       srab008 LIKE srab_t.srab008, #工艺编号
       srab009 LIKE srab_t.srab009, #日期
       srab010 LIKE srab_t.srab010, #数量
       srab011 LIKE srab_t.srab011, #单位
       srab012 LIKE srab_t.srab012  #重复性工单号码（FOR成本计算）
END RECORD
#161124-00048#12 add(e)
#DEFINE l_srda                   RECORD LIKE srda_t.* #161124-00048#12 mark
#DEFINE l_srdb                   RECORD LIKE srdb_t.* #161124-00048#12 mark
#DEFINE l_sfdd                   RECORD LIKE sfdd_t.* #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srda RECORD  #重複性生產當期在製狀況單頭檔
       srdaent LIKE srda_t.srdaent, #企业编号
       srdasite LIKE srda_t.srdasite, #营运据点
       srda000 LIKE srda_t.srda000, #年度
       srda001 LIKE srda_t.srda001, #期别
       srda002 LIKE srda_t.srda002, #生产计划
       srda003 LIKE srda_t.srda003, #料件编号
       srda004 LIKE srda_t.srda004, #BOM特性
       srda005 LIKE srda_t.srda005, #料件特征
       srda006 LIKE srda_t.srda006, #本期剩余套数
       srdaownid LIKE srda_t.srdaownid, #资料所有者
       srdaowndp LIKE srda_t.srdaowndp, #资料所有部门
       srdacrtid LIKE srda_t.srdacrtid, #资料录入者
       srdacrtdp LIKE srda_t.srdacrtdp, #资料录入部门
       srdacrtdt LIKE srda_t.srdacrtdt, #资料创建日
       srdamodid LIKE srda_t.srdamodid, #资料更改者
       srdamoddt LIKE srda_t.srdamoddt, #最近更改日
       srdacnfid LIKE srda_t.srdacnfid, #资料审核者
       srdacnfdt LIKE srda_t.srdacnfdt, #数据审核日
       srdapstid LIKE srda_t.srdapstid, #资料过账者
       srdapstdt LIKE srda_t.srdapstdt, #资料过账日
       srdastus LIKE srda_t.srdastus  #状态码
END RECORD
DEFINE l_srdb RECORD  #重複性生產當期在製狀況單身檔
       srdbent LIKE srdb_t.srdbent, #企业编号
       srdbsite LIKE srdb_t.srdbsite, #营运据点
       srdbseq LIKE srdb_t.srdbseq, #项次
       srdb000 LIKE srdb_t.srdb000, #年度
       srdb001 LIKE srdb_t.srdb001, #期别
       srdb002 LIKE srdb_t.srdb002, #生产计划
       srdb003 LIKE srdb_t.srdb003, #料件编号
       srdb004 LIKE srdb_t.srdb004, #BOM特性
       srdb005 LIKE srdb_t.srdb005, #产品特征
       srdb006 LIKE srdb_t.srdb006, #元件料号
       srdb007 LIKE srdb_t.srdb007, #产品特征
       srdb008 LIKE srdb_t.srdb008, #上期结存
       srdb009 LIKE srdb_t.srdb009, #本期投入
       srdb010 LIKE srdb_t.srdb010, #本期转出
       srdb011 LIKE srdb_t.srdb011, #调整后本期转出
       srdb012 LIKE srdb_t.srdb012, #本期结存
       srdb013 LIKE srdb_t.srdb013  #调整后本期结存
END RECORD
DEFINE l_sfdd RECORD  #發退料明細檔
       sfddent LIKE sfdd_t.sfddent, #企业编号
       sfddsite LIKE sfdd_t.sfddsite, #营运据点
       sfdddocno LIKE sfdd_t.sfdddocno, #发退料单号
       sfddseq LIKE sfdd_t.sfddseq, #项次
       sfddseq1 LIKE sfdd_t.sfddseq1, #项序
       sfdd001 LIKE sfdd_t.sfdd001, #发退料料号
       sfdd002 LIKE sfdd_t.sfdd002, #替代率
       sfdd003 LIKE sfdd_t.sfdd003, #库位
       sfdd004 LIKE sfdd_t.sfdd004, #储位
       sfdd005 LIKE sfdd_t.sfdd005, #批号
       sfdd006 LIKE sfdd_t.sfdd006, #单位
       sfdd007 LIKE sfdd_t.sfdd007, #数量
       sfdd008 LIKE sfdd_t.sfdd008, #参考单位
       sfdd009 LIKE sfdd_t.sfdd009, #参考单位数量
       sfdd010 LIKE sfdd_t.sfdd010, #库存管理特征
       sfdd011 LIKE sfdd_t.sfdd011, #包装容器
       sfdd012 LIKE sfdd_t.sfdd012, #正负
       sfdd013 LIKE sfdd_t.sfdd013, #产品特征
       sfdd014 LIKE sfdd_t.sfdd014, #备置量
       sfdd015 LIKE sfdd_t.sfdd015  #在拣量
END RECORD
#161124-00048#12 add(e)
DEFINE l_srda000                LIKE srda_t.srda000
DEFINE l_srda001                LIKE srda_t.srda001
DEFINE l_srda006                LIKE srda_t.srda006
DEFINE l_sfda013                LIKE sfda_t.sfda013
DEFINE l_sfda013_1              LIKE sfda_t.sfda013
DEFINE l_sum1                   LIKE sfec_t.sfec009
DEFINE l_sum2                   LIKE sfec_t.sfec009
DEFINE l_sfec008                LIKE sfec_t.sfec008
DEFINE l_sfec009                LIKE sfec_t.sfec009
DEFINE l_sfec009_1              LIKE sfec_t.sfec009
DEFINE l_success                LIKE type_t.num5
DEFINE l_rate                   LIKE srbc_t.srbc005
DEFINE l_imae081                LIKE imae_t.imae081
DEFINE l_n                      LIKE type_t.num5
DEFINE l_n1                     LIKE type_t.num5
DEFINE l_bmba011                LIKE bmba_t.bmba011
DEFINE l_bmba012                LIKE bmba_t.bmba012
DEFINE l_sfda002                LIKE sfda_t.sfda002

   LET r_success = FALSE
   
   #已经存在本期资料，先删除
   DELETE FROM srda_t
    WHERE srdaent = g_enterprise AND srdasite = g_site
      AND srda000 = g_srda_m.srda000 AND srda001 = g_srda_m.srda001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "DELETE srda_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN r_success
   END IF 
   
   DELETE FROM srdb_t
    WHERE srdbent = g_enterprise AND srdbsite = g_site
      AND srdb000 = g_srda_m.srda000 AND srdb001 = g_srda_m.srda001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "DELETE srdb_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN r_success
   END IF 
   
   CALL s_fin_date_get_period_range(g_glav001,g_srda_m.srda000,g_srda_m.srda001)
        RETURNING l_bdate,l_edate
        
   LET l_sql = "SELECT DISTINCT srab001,srab004,srab005,srab006,srab011 FROM sraa_t,srab_t ",
               " WHERE sraaent = srabent AND sraasite = srabsite AND sraa000 = srab000 AND sraa001 = srab001 ",
               "   AND sraa002 = srab002 AND sraa003 = srab003 ",
               "   AND srabent = ",g_enterprise," AND srabsite = '",g_site,"'",
               "   AND srab009 >= '",l_bdate,"' AND srab009 < '",l_edate,"'"
   PREPARE asrt900_gen_pre FROM l_sql
   DECLARE asrt900_gen_cs CURSOR FOR asrt900_gen_pre
   FOREACH asrt900_gen_cs INTO l_srab.srab001,l_srab.srab004,l_srab.srab005,l_srab.srab006,l_srab.srab011
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN r_success
      END IF
      
      LET l_srda.srdaent  = g_enterprise
      LET l_srda.srdasite = g_site
      LET l_srda.srda000  = g_srda_m.srda000
      LET l_srda.srda001  = g_srda_m.srda001
      LET l_srda.srda002  = l_srab.srab001
      LET l_srda.srda003  = l_srab.srab004
      LET l_srda.srda004  = l_srab.srab005
      LET l_srda.srda005  = l_srab.srab006
      LET l_srda.srdaownid= g_user
      LET l_srda.srdaowndp= g_dept
      LET l_srda.srdacrtid= g_user
      LET l_srda.srdacrtdp= g_dept
      LET l_srda.srdacrtdt= cl_get_current()
      LET l_srda.srdastus = 'Y'
      
      #上期剩余套数
      CALL s_fin_date_get_last_period(g_glav001,g_ld,l_srda.srda000,l_srda.srda001)
           RETURNING l_success,l_srda000,l_srda001
      SELECT srda006 INTO l_srda006 FROM srda_t
       WHERE srdaent = g_enterprise AND srdasite = g_site
         AND srda000 = l_srda000 AND srda001 = l_srda001
         AND srda002 = l_srda.srda002 AND srda003 = l_srda.srda003
         AND srda004 = l_srda.srda004 AND srda005 = l_srda.srda005
      IF cl_null(l_srda006) THEN
         LET l_srda006 = 0
      END IF
         
      #当期（发料套数-退料套数）总和
      LET l_sum1 = 0
      SELECT SUM(sfda013) INTO l_sfda013 FROM sfda_t
       WHERE sfdaent = g_enterprise AND sfdasite = g_site AND sfda002 = '16'
         AND sfda009 = l_srda.srda002 AND sfda006 = l_srda.srda003
         AND sfda007 = l_srda.srda004 AND sfda008 = l_srda.srda005
         AND sfda001 >= l_bdate AND sfda001 < l_edate
         AND sfdastus = 'S'
      IF cl_null(l_sfda013) THEN
         LET l_sfda013 = 0 
      END IF      
      SELECT SUM(sfda013) INTO l_sfda013_1 FROM sfda_t
       WHERE sfdaent = g_enterprise AND sfdasite = g_site AND sfda002 = '26'
         AND sfda009 = l_srda.srda002 AND sfda006 = l_srda.srda003
         AND sfda007 = l_srda.srda004 AND sfda008 = l_srda.srda005
         AND sfda001 >= l_bdate AND sfda001 < l_edate
         AND sfdastus = 'S'
      IF cl_null(l_sfda013_1) THEN
         LET l_sfda013_1 = 0 
      END IF 
      LET l_sum1 = l_sfda013 - l_sfda013_1         
               
      #当期入库数量
      LET l_sum2 = 0
      LET l_sql = "SELECT sfec008,sfec009 FROM sfea_t,sfec_t",
                  " WHERE sfeaent=sfecent AND sfeadocno=sfecdocno AND sfeasite=sfecsite ",
                  "   AND sfeaent=",g_enterprise," and sfeasite='",g_site,"' AND sfea001>='",l_bdate,"'",
                  "   AND sfea001<'",l_edate,"' AND sfeastus='S' AND (sfec004 = '1' OR sfec004 = '2') ",   #一般+联产品 
                  "   AND sfea006='",l_srda.srda002,"' AND sfec018='",l_srda.srda003,"'",
                  "   AND sfec019='",l_srda.srda004,"' AND sfec020='",l_srda.srda005,"'"
      PREPARE asrt900_gen_pre1 FROM l_sql
      DECLARE asrt900_gen_cs1 CURSOR FOR asrt900_gen_pre1
      FOREACH asrt900_gen_cs1 INTO l_sfec008,l_sfec009
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            RETURN r_success
         END IF
         #单位转换及数量换算
         IF NOT cl_null(l_sfec008) AND NOT cl_null(l_sfec009) THEN
            CALL s_aimi190_get_convert(l_srda.srda003,l_sfec008,l_srab.srab011) RETURNING l_success,l_rate 
            IF NOT l_success THEN
               RETURN r_success
            END IF             
            LET l_sfec009_1 = l_sfec009 * l_rate
            LET l_sum2 = l_sum2 + l_sfec009_1
         ELSE
            LET l_sum2 = l_sum2 + l_sfec009
         END IF
      END FOREACH      
      
      LET l_srda.srda006 = l_srda006 + l_sum1 - l_sum2
      
#      INSERT INTO srda_t VALUES l_srda.*  #161124-00048#12 mark
      #161124-00048#12 add(s)
      INSERT INTO srda_t(srdaent,srdasite,srda000,srda001,srda002,srda003,srda004,
                         srda005,srda006,srdaownid,srdaowndp,srdacrtid,srdacrtdp,
                         srdacrtdt,srdamodid,srdamoddt,srdacnfid,srdacnfdt,srdapstid,
                         srdapstdt,srdastus) 
                  VALUES(l_srda.srdaent,l_srda.srdasite,l_srda.srda000,l_srda.srda001,l_srda.srda002,l_srda.srda003,l_srda.srda004,
                         l_srda.srda005,l_srda.srda006,l_srda.srdaownid,l_srda.srdaowndp,l_srda.srdacrtid,l_srda.srdacrtdp,
                         l_srda.srdacrtdt,l_srda.srdamodid,l_srda.srdamoddt,l_srda.srdacnfid,l_srda.srdacnfdt,l_srda.srdapstid,
                         l_srda.srdapstdt,l_srda.srdastus)
      #161124-00048#12 add(e)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INS srda_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      
#      LET l_sql = "SELECT sfda002,sfdd_t.* FROM sfda_t,sfdc_t,sfdd_t ",  #161124-00048#12 mark
      #161124-00048#12 add(s)
      LET l_sql = "SELECT sfda002,sfddent,sfddsite,sfdddocno,sfddseq,sfddseq1,sfdd001,",
                  "       sfdd002,sfdd003,sfdd004,sfdd005,sfdd006,sfdd007,sfdd008,sfdd009,",
                  "       sfdd010,sfdd011,sfdd012,sfdd013,sfdd014,sfdd015 ",
                  "  FROM sfda_t,sfdc_t,sfdd_t ",
      #161124-00048#12 add(e)
                  " WHERE sfdaent=sfdcent AND sfdadocno=sfdcdocno AND sfdcent=sfddent AND sfdcdocno=sfdddocno AND sfdcseq=sfddseq ",
                  "   AND sfdaent = ",g_enterprise," AND sfdasite = '",g_site,"' AND (sfda002 = '16' OR sfda002 = '26')",
                  "   AND sfda009 = '",l_srda.srda002,"' AND sfda006 = '",l_srda.srda003,"'",
                  "   AND sfda007 = '",l_srda.srda004,"' AND sfda008 = '",l_srda.srda005,"'",
                  "   AND sfda001 >= '",l_bdate,"' AND sfda001 < '",l_edate,"'",
                  "   AND sfdastus = 'S'"
      PREPARE asrt900_gen_pre2 FROM l_sql
      DECLARE asrt900_gen_cs2 CURSOR FOR asrt900_gen_pre2
      FOREACH asrt900_gen_cs2 INTO l_sfda002,l_sfdd.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            RETURN r_success
         END IF
         
         #抓元件对应发料单位
         SELECT imae081 INTO l_imae081 FROM imae_t 
          WHERE imaeent = g_enterprise AND imaesite = g_site
            AND imae001 = l_sfdd.sfdd001
         IF cl_null(l_imae081) THEN
            SELECT imaa006 INTO l_imae081 FROM imaa_t 
             WHERE imaaent = g_enterprise AND imaa001 = l_sfdd.sfdd001
         END IF
         
         #发料加，退料减
         IF l_sfda002 = '26' THEN
            LET l_sfdd.sfdd007 = l_sfdd.sfdd007 * (-1)
         END IF
         
         #当前元件料号+特征资料是否已经存在于srdb_t中，若存在，则update，反之，新增
         IF cl_null(l_sfdd.sfdd013) THEN
            LET l_sfdd.sfdd013 = ' ' 
         END IF
         SELECT COUNT(*) INTO l_n FROM srdb_t
          WHERE srdbent = g_enterprise AND srdbsite = g_site
            AND srdb000 = l_srda.srda000 AND srdb001 = l_srda.srda001
            AND srdb002 = l_srda.srda002 AND srdb003 = l_srda.srda003
            AND srdb004 = l_srda.srda004 AND srdb005 = l_srda.srda005
            AND srdb006 = l_sfdd.sfdd001 AND srdb007 = l_sfdd.sfdd013 
         IF l_n > 0 THEN
            CALL s_aimi190_get_convert(l_sfdd.sfdd001,l_sfdd.sfdd006,l_imae081) RETURNING l_success,l_rate 
            IF NOT l_success THEN
               RETURN r_success
            END IF
            LET l_srdb.srdb009 = l_sfdd.sfdd007 * l_rate
            UPDATE srdb_t SET srdb009 = srdb009 + l_srdb.srdb009,
                              srdb011 = srdb011 + l_srdb.srdb009,
                              srdb012 = srdb012 + l_srdb.srdb009
             WHERE srdbent = g_enterprise AND srdbsite = g_site
               AND srdb000 = l_srda.srda000 AND srdb001 = l_srda.srda001
               AND srdb002 = l_srda.srda002 AND srdb003 = l_srda.srda003
               AND srdb004 = l_srda.srda004 AND srdb005 = l_srda.srda005
               AND srdb006 = l_sfdd.sfdd001 AND srdb007 = l_sfdd.sfdd013 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "UPD srdb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               RETURN r_success
            END IF           
         ELSE          
            LET l_srdb.srdbent  = g_enterprise
            LET l_srdb.srdbsite = g_site
            LET l_srdb.srdb000  = g_srda_m.srda000
            LET l_srdb.srdb001  = g_srda_m.srda001
            LET l_srdb.srdb002  = l_srab.srab001
            LET l_srdb.srdb003  = l_srab.srab004
            LET l_srdb.srdb004  = l_srab.srab005
            LET l_srdb.srdb005  = l_srab.srab006
            LET l_srdb.srdb006  = l_sfdd.sfdd001
            LET l_srdb.srdb007  = l_sfdd.sfdd013
            IF cl_null(l_srdb.srdb007) THEN
               LET l_srdb.srdb007 = ' '
            END IF
            
            SELECT MAX(srdbseq) INTO l_srdb.srdbseq FROM srdb_t
             WHERE srdbent = g_enterprise AND srdbsite = g_site
               AND srdb000 = l_srdb.srdb000 AND srdb001 = l_srdb.srdb001
               AND srdb002 = l_srda.srda002 AND srdb003 = l_srda.srda003
               AND srdb004 = l_srda.srda004 AND srdb005 = l_srda.srda005
            IF cl_null(l_srdb.srdbseq) THEN
               LET l_srdb.srdbseq = 1
            ELSE
               LET l_srdb.srdbseq = l_srdb.srdbseq + 1
            END IF
               
            SELECT srdb008 INTO l_srdb.srdb008 FROM srdb_t
             WHERE srdbent = g_enterprise AND srdbsite = g_site
               AND srdb000 = l_srda000 AND srdb001 = l_srda001
               AND srdb002 = l_srda.srda002 AND srdb003 = l_srda.srda003
               AND srdb004 = l_srda.srda004 AND srdb005 = l_srda.srda005
               AND srdb006 = l_srdb.srdb006 AND srdb007 = l_srdb.srdb007
            IF cl_null(l_srdb.srdb008) THEN
               LET l_srdb.srdb008 = 0 
            END IF
            
            #抓发料单位，发退料数量与发料单位换算
            CALL s_aimi190_get_convert(l_srdb.srdb006,l_sfdd.sfdd006,l_imae081) RETURNING l_success,l_rate 
            IF NOT l_success THEN
               RETURN r_success
            END IF
            LET l_srdb.srdb009 = l_sfdd.sfdd007 * l_rate
                     
            #QPA分子分母
            DECLARE asrt900_gen_cs3 CURSOR FOR
             SELECT bmba011,bmba012 FROM bmba_t 
              WHERE bmbaent = g_enterprise AND bmbasite = g_site AND bmba001 = l_srdb.srdb003
                AND bmba002 = l_srdb.srdb004 AND bmba003 = l_srdb.srdb006
            FOREACH asrt900_gen_cs3 INTO l_bmba011,l_bmba012
               EXIT FOREACH
            END FOREACH
            #调整本期结存和发料单位转换
            CALL s_aimi190_get_convert(l_srdb.srdb006,l_srab.srab011,l_imae081) RETURNING l_success,l_rate 
            IF NOT l_success THEN
               RETURN r_success
            END IF
            
            LET l_srdb.srdb010 = l_sum2 * l_rate * l_bmba011 / l_bmba012        
            LET l_srdb.srdb012 = l_srdb.srdb008 + l_srdb.srdb009 - l_srdb.srdb010
            LET l_srdb.srdb013 = l_srda.srda006 * l_rate * l_bmba011 / l_bmba012
            LET l_srdb.srdb011 = l_srdb.srdb008 + l_srdb.srdb009 - l_srdb.srdb013
            
#            INSERT INTO srdb_t VALUES l_srdb.* #161124-00048#12 mark
            #161124-00048#12 add(s)
            INSERT INTO srdb_t(srdbent,srdbsite,srdbseq,srdb000,srdb001,srdb002,srdb003,srdb004,
                               srdb005,srdb006,srdb007,srdb008,srdb009,srdb010,srdb011,srdb012,srdb013) 
                        VALUES(l_srdb.srdbent,l_srdb.srdbsite,l_srdb.srdbseq,l_srdb.srdb000,l_srdb.srdb001,l_srdb.srdb002,l_srdb.srdb003,l_srdb.srdb004,
                               l_srdb.srdb005,l_srdb.srdb006,l_srdb.srdb007,l_srdb.srdb008,l_srdb.srdb009,l_srdb.srdb010,l_srdb.srdb011,l_srdb.srdb012,l_srdb.srdb013) 
            #161124-00048#12 add(e)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "INS srdb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               RETURN r_success
            END IF
         END IF
      END FOREACH
      #无单身资料，则删除单头
      SELECT COUNT(*) INTO l_n1 FROM srdb_t 
       WHERE srdbent = g_enterprise AND srdbsite = g_site
         AND srdb000 = l_srda.srda000 AND srdb001 = l_srda.srda001
         AND srdb002 = l_srda.srda002 AND srdb003 = l_srda.srda003
         AND srdb004 = l_srda.srda004 AND srdb005 = l_srda.srda005
      IF l_n1 = 0 THEN
         DELETE FROM srda_t
          WHERE srdaent = g_enterprise AND srdasite = g_site
            AND srda000 = l_srda.srda000 AND srda001 = l_srda.srda001
            AND srda002 = l_srda.srda002 AND srda003 = l_srda.srda003
            AND srda004 = l_srda.srda004 AND srda005 = l_srda.srda005 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "DEL srda_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
      END IF
      
      #调整后本期转出<0,本期转出<0时，则update为0
      UPDATE srdb_t SET srdb011 = 0
       WHERE srdbent = g_enterprise AND srdbsite = g_site
         AND srdb000 = l_srda.srda000 AND srdb001 = l_srda.srda001
         AND srdb002 = l_srda.srda002 AND srdb003 = l_srda.srda003
         AND srdb004 = l_srda.srda004 AND srdb005 = l_srda.srda005
         AND srdb011 < 0
      UPDATE srdb_t SET srdb012 = 0
       WHERE srdbent = g_enterprise AND srdbsite = g_site
         AND srdb000 = l_srda.srda000 AND srdb001 = l_srda.srda001
         AND srdb002 = l_srda.srda002 AND srdb003 = l_srda.srda003
         AND srdb004 = l_srda.srda004 AND srdb005 = l_srda.srda005
         AND srdb012 < 0         
   END FOREACH
   
   #无资料生成，则提示
   SELECT COUNT(*) INTO l_n FROM srda_t
    WHERE srdaent = g_enterprise AND srdasite = g_site
      AND srda000 = g_srda_m.srda000 AND srda001 = g_srda_m.srda001
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asr-00065'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF

   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 本期剩余套数调整
# Memo...........:
# Usage..........: CALL asrt900_modify_srda006()
# Input parameter: 
# Return code....: 
# Date & Author..: 20150518 By wuxja
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt900_modify_srda006()
DEFINE l_close_dd            LIKE type_t.dat
DEFINE l_srda006_t           LIKE srda_t.srda006
DEFINE l_comp                LIKE ooef_t.ooef017
DEFINE l_ld                  LIKE glaa_t.glaald
DEFINE l_n                   LIKE type_t.num5
DEFINE l_success             LIKE type_t.num5

   IF cl_null(g_srda_m.srda000) OR cl_null(g_srda_m.srda001) OR cl_null(g_srda_m.srda002) OR 
      cl_null(g_srda_m.srda003) OR g_srda_m.srda004 IS NULL OR g_srda_m.srda005 IS NULL THEN
      RETURN
   END IF
   
   #不可小于等于关账日期
   LET l_close_dd = cl_get_para(g_enterprise,g_site,'S-FIN-6012') 
   IF cl_get_today() <= l_close_dd THEN
      LET g_errparam.extend = cl_get_today()
      LET g_errparam.code   = "asf-00449"
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   INPUT BY NAME g_srda_m.srda006 ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE INPUT 
         LET l_srda006_t = g_srda_m.srda006
         SELECT ooef017 INTO l_comp FROM ooef_t 
          WHERE ooefent = g_enterprise
            AND ooef001 = g_site
            
         SELECT glaald INTO l_ld FROM glaa_t
          WHERE glaaent  = g_enterprise
            AND glaacomp = l_comp   
            AND glaa014 = 'Y'
            
         SELECT COUNT(*) INTO l_n FROM xccc_t
          WHERE xcccent = g_enterprise AND xccccomp = l_comp
            AND xcccld = l_ld AND xccc004 = g_srda_m.srda000 AND xccc005 = g_srda_m.srda001
      
      AFTER FIELD srda006
         IF cl_null(g_srda_m.srda006) OR g_srda_m.srda006 < 0 THEN
            LET g_errparam.extend = g_srda_m.srda006
            LET g_errparam.code   = "aim-00009"
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            RETURN
         END IF                          
   END INPUT
   
   IF g_srda_m.srda006 != l_srda006_t THEN
      CALL s_transaction_begin()
      IF l_n > 0 THEN
         IF cl_ask_confirm('asr-00064') THEN
            CALL asrt900_modify_srda006_upd() RETURNING l_success
         ELSE
            RETURN
         END IF
      ELSE
         CALL asrt900_modify_srda006_upd() RETURNING l_success
      END IF
      IF l_success THEN
         CALL s_transaction_end('Y','0')
         CALL asrt900_b_fill()
      ELSE
         CALL s_transaction_end('N','0')
      END IF
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: asrt900_modify_srda006_upd()
#                  RETURNING r_success
# Input parameter: 
# Return code....:
# Date & Author..: 20150518 By wuxja
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt900_modify_srda006_upd()
DEFINE r_success                LIKE type_t.num5
#DEFINE l_srdb                   RECORD LIKE srdb_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srdb RECORD  #重複性生產當期在製狀況單身檔
       srdbent LIKE srdb_t.srdbent, #企业编号
       srdbsite LIKE srdb_t.srdbsite, #营运据点
       srdbseq LIKE srdb_t.srdbseq, #项次
       srdb000 LIKE srdb_t.srdb000, #年度
       srdb001 LIKE srdb_t.srdb001, #期别
       srdb002 LIKE srdb_t.srdb002, #生产计划
       srdb003 LIKE srdb_t.srdb003, #料件编号
       srdb004 LIKE srdb_t.srdb004, #BOM特性
       srdb005 LIKE srdb_t.srdb005, #产品特征
       srdb006 LIKE srdb_t.srdb006, #元件料号
       srdb007 LIKE srdb_t.srdb007, #产品特征
       srdb008 LIKE srdb_t.srdb008, #上期结存
       srdb009 LIKE srdb_t.srdb009, #本期投入
       srdb010 LIKE srdb_t.srdb010, #本期转出
       srdb011 LIKE srdb_t.srdb011, #调整后本期转出
       srdb012 LIKE srdb_t.srdb012, #本期结存
       srdb013 LIKE srdb_t.srdb013  #调整后本期结存
END RECORD
#161124-00048#12 add(e)
DEFINE l_bmba011                LIKE bmba_t.bmba011
DEFINE l_bmba012                LIKE bmba_t.bmba012

   LET r_success = FALSE
   
   #更新本期剩余套数
   UPDATE srda_t SET srda006 = g_srda_m.srda006
    WHERE srdaent = g_enterprise AND srdasite = g_site
      AND srda000 = g_srda_m.srda000 AND srda001 = g_srda_m.srda001
      AND srda002 = g_srda_m.srda002 AND srda003 = g_srda_m.srda003
      AND srda004 = g_srda_m.srda004 AND srda005 = g_srda_m.srda005
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "UPDATE srda_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN r_success
   END IF 
   
   DECLARE asrt900_modify_srda006_upd_cs CURSOR FOR
#    SELECT * FROM srdb_t #161124-00048#12 mark
    #161124-00048#12 add(s)
    SELECT srdbent,srdbsite,srdbseq,srdb000,srdb001,srdb002,srdb003,srdb004,
           srdb005,srdb006,srdb007,srdb008,srdb009,srdb010,srdb011,srdb012,srdb013 
      FROM srdb_t
    #161124-00048#12 add(e)
     WHERE srdbent = g_enterprise AND srdbsite = g_site
       AND srdb000 = g_srda_m.srda000 AND srdb001 = g_srda_m.srda001
       AND srdb002 = g_srda_m.srda002 AND srdb003 = g_srda_m.srda003
       AND srdb004 = g_srda_m.srda004 AND srdb005 = g_srda_m.srda005
   FOREACH asrt900_modify_srda006_upd_cs INTO l_srdb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN r_success
      END IF
      #QPA分子分母
      LET l_bmba011 = 1
      LET l_bmba012 = 1
      DECLARE asrt900_modify_srda006_upd_cs1 CURSOR FOR
       SELECT bmba011,bmba012 FROM bmba_t 
        WHERE bmbaent = g_enterprise AND bmbasite = g_site AND bmba001 = l_srdb.srdb003
          AND bmba002 = l_srdb.srdb004 AND bmba003 = l_srdb.srdb006
      FOREACH asrt900_modify_srda006_upd_cs1 INTO l_bmba011,l_bmba012
         EXIT FOREACH
      END FOREACH
      LET l_srdb.srdb013 = g_srda_m.srda006 * l_bmba011 / l_bmba012
      LET l_srdb.srdb011 = l_srdb.srdb008 + l_srdb.srdb009 - l_srdb.srdb013
      IF l_srdb.srdb011 < 0 THEN
         LET l_srdb.srdb011 = 0 
      END IF
      UPDATE srdb_t SET srdb011 = l_srdb.srdb011,srdb013 = l_srdb.srdb013
       WHERE srdbent = g_enterprise AND srdbsite = g_site
         AND srdb000 = g_srda_m.srda000 AND srdb001 = g_srda_m.srda001
         AND srdb002 = g_srda_m.srda002 AND srdb003 = g_srda_m.srda003
         AND srdb004 = g_srda_m.srda004 AND srdb005 = g_srda_m.srda005
         AND srdbseq = l_srdb.srdbseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPDATE srdb_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN r_success
      END IF 
   END FOREACH
   LET r_success = TRUE
   RETURN r_success      
END FUNCTION

################################################################################
# Descriptions...: 元件本期结存调整
# Memo...........:
# Usage..........: CALL asrt900_modify_srdb012()
# Input parameter: 
# Return code....: 
# Date & Author..: 20150518 By wuxja
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt900_modify_srdb012()
DEFINE l_close_dd            LIKE type_t.dat

   IF cl_null(g_srda_m.srda000) OR cl_null(g_srda_m.srda001) OR cl_null(g_srda_m.srda002) OR 
      cl_null(g_srda_m.srda003) OR g_srda_m.srda004 IS NULL OR g_srda_m.srda005 IS NULL OR g_srdb_d.getLength() <= 0 THEN
      RETURN
   END IF
   
   #不可小于等于关账日期
   LET l_close_dd = cl_get_para(g_enterprise,g_site,'S-FIN-6012') 
   IF cl_get_today() <= l_close_dd THEN
      LET g_errparam.extend = cl_get_today()
      LET g_errparam.code   = "asf-00449"
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   CALL asrt900_input('b')
      
END FUNCTION

 
{</section>}
 
