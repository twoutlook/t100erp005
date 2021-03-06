#該程式未解開Section, 採用最新樣板產出!
{<section id="agli510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-01-14 17:30:01), PR版次:0004(2016-04-29 18:30:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: agli510
#+ Description: 合併組織結構維護作業
#+ Creator....: 03080(2015-03-10 17:17:54)
#+ Modifier...: 05016 -SD/PR- 03538
 
{</section>}
 
{<section id="agli510.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160114無單 160114  albireo 信:IF 持股比率小於50時預設給N;複製單身選新的一行但按放棄,畫面殘留資料問題修正
#160321-00016#29  160325 By Jessy      修正azzi920重複定義之錯誤訊息
#151113-00002#34  160429 By 03538      1.agli510單身資料存檔時需同時寫入glfj_t 2.寫入時需先判斷glfj_t裡是否有值，無值時才寫入(客戶第一次建立組織檔時)

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
PRIVATE type type_g_gldb_m        RECORD
       gldbld LIKE gldb_t.gldbld, 
   gldbld_desc LIKE type_t.chr80, 
   gldb001 LIKE gldb_t.gldb001, 
   gldb001_desc LIKE type_t.chr80, 
   glda003 LIKE type_t.chr10, 
   glda003_desc LIKE type_t.chr80, 
   gldb002 LIKE gldb_t.gldb002, 
   gldb002_desc LIKE type_t.chr80, 
   gldbstus LIKE gldb_t.gldbstus, 
   gldbownid LIKE gldb_t.gldbownid, 
   gldbownid_desc LIKE type_t.chr80, 
   gldbowndp LIKE gldb_t.gldbowndp, 
   gldbowndp_desc LIKE type_t.chr80, 
   gldbcrtid LIKE gldb_t.gldbcrtid, 
   gldbcrtid_desc LIKE type_t.chr80, 
   gldbcrtdp LIKE gldb_t.gldbcrtdp, 
   gldbcrtdp_desc LIKE type_t.chr80, 
   gldbcrtdt LIKE gldb_t.gldbcrtdt, 
   gldbmodid LIKE gldb_t.gldbmodid, 
   gldbmodid_desc LIKE type_t.chr80, 
   gldbmoddt LIKE gldb_t.gldbmoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gldc_d        RECORD
       gldc002 LIKE gldc_t.gldc002, 
   gldc002_desc LIKE type_t.chr100, 
   gldc003 LIKE gldc_t.gldc003, 
   gldc004 LIKE gldc_t.gldc004, 
   gldc005 LIKE gldc_t.gldc005, 
   gldc006 LIKE gldc_t.gldc006, 
   gldc007 LIKE gldc_t.gldc007, 
   gldc008 LIKE gldc_t.gldc008, 
   gldc009 LIKE gldc_t.gldc009
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_gldb001 LIKE gldb_t.gldb001,
      b_gldbld LIKE gldb_t.gldbld,
      b_gldb002 LIKE gldb_t.gldb002
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#組織樹相關欄位-----s
DEFINE g_tree_idx   LIKE type_t.num10
DEFINE g_tree       DYNAMIC ARRAY OF RECORD
       b_show          LIKE type_t.chr100,    #外顯欄位
       b_pid           LIKE type_t.chr100,    #父節點id
       b_id            LIKE type_t.chr100,    #本身節點id
       b_exp           LIKE type_t.chr100,    #是否展開
       b_hasC          LIKE type_t.num5,      #是否有子節點
       b_isExp         LIKE type_t.num5,      #是否已展開
       b_expcode       LIKE type_t.num5,       #展開值
       b_gldbld        LIKE gldb_t.gldbld,    #跟雙檔g_browser對的KEY1
       b_gldb001       LIKE gldb_t.gldb001   #跟雙檔g_browser對的KEY2
                    END RECORD
DEFINE g_tree_pid   LIKE type_t.chr100
#組織樹相關欄位-----e
#end add-point
       
#模組變數(Module Variables)
DEFINE g_gldb_m          type_g_gldb_m
DEFINE g_gldb_m_t        type_g_gldb_m
DEFINE g_gldb_m_o        type_g_gldb_m
DEFINE g_gldb_m_mask_o   type_g_gldb_m #轉換遮罩前資料
DEFINE g_gldb_m_mask_n   type_g_gldb_m #轉換遮罩後資料
 
   DEFINE g_gldbld_t LIKE gldb_t.gldbld
DEFINE g_gldb001_t LIKE gldb_t.gldb001
 
 
DEFINE g_gldc_d          DYNAMIC ARRAY OF type_g_gldc_d
DEFINE g_gldc_d_t        type_g_gldc_d
DEFINE g_gldc_d_o        type_g_gldc_d
DEFINE g_gldc_d_mask_o   DYNAMIC ARRAY OF type_g_gldc_d #轉換遮罩前資料
DEFINE g_gldc_d_mask_n   DYNAMIC ARRAY OF type_g_gldc_d #轉換遮罩後資料
 
 
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
 
{<section id="agli510.main" >}
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
   LET g_forupd_sql = " SELECT gldbld,'',gldb001,'','','',gldb002,'',gldbstus,gldbownid,'',gldbowndp, 
       '',gldbcrtid,'',gldbcrtdp,'',gldbcrtdt,gldbmodid,'',gldbmoddt", 
                      " FROM gldb_t",
                      " WHERE gldbent= ? AND gldbld=? AND gldb001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agli510_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.gldbld,t0.gldb001,t0.gldb002,t0.gldbstus,t0.gldbownid,t0.gldbowndp, 
       t0.gldbcrtid,t0.gldbcrtdp,t0.gldbcrtdt,t0.gldbmodid,t0.gldbmoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 , 
       t4.ooefl003 ,t5.ooag011",
               " FROM gldb_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.gldbownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.gldbowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.gldbcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.gldbcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.gldbmodid  ",
 
               " WHERE t0.gldbent = " ||g_enterprise|| " AND t0.gldbld = ? AND t0.gldb001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE agli510_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_agli510 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL agli510_init()   
 
      #進入選單 Menu (="N")
      CALL agli510_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_agli510
      
   END IF 
   
   CLOSE agli510_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="agli510.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION agli510_init()
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
      CALL cl_set_combo_scc_part('gldbstus','17','N,Y')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #初始化搜尋條件
   CALL agli510_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="agli510.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION agli510_ui_dialog()
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
            CALL agli510_insert()
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
         INITIALIZE g_gldb_m.* TO NULL
         CALL g_gldc_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL agli510_init()
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
               
               CALL agli510_fetch('') # reload data
               LET l_ac = 1
               CALL agli510_ui_detailshow() #Setting the current row 
         
               CALL agli510_idx_chk()
               #NEXT FIELD gldc002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_gldc_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL agli510_idx_chk()
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
               CALL agli510_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #組織樹ARRAY
         DISPLAY ARRAY g_tree TO s_detail2.* ATTRIBUTES(COUNT=g_tree_idx)
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               CALL agli510_tree_fetch(l_ac)
               LET l_ac = 1
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL agli510_browser_fill("")
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
               CALL agli510_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL agli510_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL agli510_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            #一進程式展全組織樹
            #g_browser先準備好方便點樹fetch雙檔資料
            CALL agli510_grow_tree(' 1=1',' 1=1')    
            LET g_wc = ' 1=1'                        
            LET g_wc2 = ' 1=1'                       
            CALL agli510_browser_fill("")            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL agli510_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL agli510_set_act_visible()   
            CALL agli510_set_act_no_visible()
            IF NOT (g_gldb_m.gldbld IS NULL
              OR g_gldb_m.gldb001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " gldbent = " ||g_enterprise|| " AND",
                                  " gldbld = '", g_gldb_m.gldbld, "' "
                                  ," AND gldb001 = '", g_gldb_m.gldb001, "' "
 
               #填到對應位置
               CALL agli510_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "gldb_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gldc_t" 
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
               CALL agli510_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "gldb_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gldc_t" 
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
                  CALL agli510_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL agli510_fetch("F")
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
               CALL agli510_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL agli510_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli510_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL agli510_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli510_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL agli510_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli510_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL agli510_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli510_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL agli510_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli510_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_gldc_d)
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
               NEXT FIELD gldc002
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
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL agli510_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL agli510_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL agli510_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL agli510_insert()
               #add-point:ON ACTION insert name="menu.insert"
               CALL agli510_b_fill()
               CALL agli510_b_fill2('0')               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL agli510_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               CALL agli510_b_fill()
               CALL agli510_b_fill2('0')
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL agli510_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL agli510_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL agli510_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL agli510_set_pk_array()
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
 
{<section id="agli510.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION agli510_browser_fill(ps_page_action)
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
   #albireo 150423-----s
   #單身蒐尋時  不把為單頭  FLAG='Y'的條件加入
   IF NOT cl_null(l_wc2) AND l_wc2 <> '1=1' THEN
      LET l_wc2 = l_wc2 CLIPPED," AND gldc009 <> 'Y' "
   END IF
   #albireo 150423-----e
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT gldbld,gldb001 ",
                      " FROM gldb_t ",
                      " ",
                      " LEFT JOIN gldc_t ON gldcent = gldbent AND gldbld = gldcld AND gldb001 = gldc001 ", "  ",
                      #add-point:browser_fill段sql(gldc_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE gldbent = " ||g_enterprise|| " AND gldcent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gldb_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gldbld,gldb001 ",
                      " FROM gldb_t ", 
                      "  ",
                      "  ",
                      " WHERE gldbent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("gldb_t")
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
      INITIALIZE g_gldb_m.* TO NULL
      CALL g_gldc_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.gldb001,t0.gldbld,t0.gldb002 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.gldbstus,t0.gldb001,t0.gldbld,t0.gldb002 ",
                  " FROM gldb_t t0",
                  "  ",
                  "  LEFT JOIN gldc_t ON gldcent = gldbent AND gldbld = gldcld AND gldb001 = gldc001 ", "  ", 
                  #add-point:browser_fill段sql(gldc_t1) name="browser_fill.join.gldc_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.gldbent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("gldb_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.gldbstus,t0.gldb001,t0.gldbld,t0.gldb002 ",
                  " FROM gldb_t t0",
                  "  ",
                  
                  " WHERE t0.gldbent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("gldb_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY gldbld,gldb001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"gldb_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_gldb001,g_browser[g_cnt].b_gldbld, 
          g_browser[g_cnt].b_gldb002
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
         CALL agli510_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
      END CASE
 
 
 
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
   
   IF cl_null(g_browser[g_cnt].b_gldbld) THEN
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
 
{<section id="agli510.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION agli510_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_gldb_m.gldbld = g_browser[g_current_idx].b_gldbld   
   LET g_gldb_m.gldb001 = g_browser[g_current_idx].b_gldb001   
 
   EXECUTE agli510_master_referesh USING g_gldb_m.gldbld,g_gldb_m.gldb001 INTO g_gldb_m.gldbld,g_gldb_m.gldb001, 
       g_gldb_m.gldb002,g_gldb_m.gldbstus,g_gldb_m.gldbownid,g_gldb_m.gldbowndp,g_gldb_m.gldbcrtid,g_gldb_m.gldbcrtdp, 
       g_gldb_m.gldbcrtdt,g_gldb_m.gldbmodid,g_gldb_m.gldbmoddt,g_gldb_m.gldbownid_desc,g_gldb_m.gldbowndp_desc, 
       g_gldb_m.gldbcrtid_desc,g_gldb_m.gldbcrtdp_desc,g_gldb_m.gldbmodid_desc
   
   CALL agli510_gldb_t_mask()
   CALL agli510_show()
      
END FUNCTION
 
{</section>}
 
{<section id="agli510.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION agli510_ui_detailshow()
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
 
{<section id="agli510.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION agli510_ui_browser_refresh()
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
      IF g_browser[l_i].b_gldbld = g_gldb_m.gldbld 
         AND g_browser[l_i].b_gldb001 = g_gldb_m.gldb001 
 
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
 
{<section id="agli510.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION agli510_construct()
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
   INITIALIZE g_gldb_m.* TO NULL
   CALL g_gldc_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON gldbld,gldb001,gldb002,gldbstus,gldbownid,gldbowndp,gldbcrtid,gldbcrtdp, 
          gldbcrtdt,gldbmodid,gldbmoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gldbcrtdt>>----
         AFTER FIELD gldbcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gldbmoddt>>----
         AFTER FIELD gldbmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gldbcnfdt>>----
         
         #----<<gldbpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldbld
            #add-point:BEFORE FIELD gldbld name="construct.b.gldbld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldbld
            
            #add-point:AFTER FIELD gldbld name="construct.a.gldbld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldbld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldbld
            #add-point:ON ACTION controlp INFIELD gldbld name="construct.c.gldbld"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO gldbld
            NEXT FIELD gldbld
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldb001
            #add-point:BEFORE FIELD gldb001 name="construct.b.gldb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldb001
            
            #add-point:AFTER FIELD gldb001 name="construct.a.gldb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldb001
            #add-point:ON ACTION controlp INFIELD gldb001 name="construct.c.gldb001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " gldastus = 'Y' "
            CALL q_glda001()
            DISPLAY g_qryparam.return1 TO gldb001
            NEXT FIELD gldb001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldb002
            #add-point:BEFORE FIELD gldb002 name="construct.b.gldb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldb002
            
            #add-point:AFTER FIELD gldb002 name="construct.a.gldb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldb002
            #add-point:ON ACTION controlp INFIELD gldb002 name="construct.c.gldb002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO gldb002
            NEXT FIELD gldb002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldbstus
            #add-point:BEFORE FIELD gldbstus name="construct.b.gldbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldbstus
            
            #add-point:AFTER FIELD gldbstus name="construct.a.gldbstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldbstus
            #add-point:ON ACTION controlp INFIELD gldbstus name="construct.c.gldbstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gldbownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldbownid
            #add-point:ON ACTION controlp INFIELD gldbownid name="construct.c.gldbownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldbownid  #顯示到畫面上
            NEXT FIELD gldbownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldbownid
            #add-point:BEFORE FIELD gldbownid name="construct.b.gldbownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldbownid
            
            #add-point:AFTER FIELD gldbownid name="construct.a.gldbownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldbowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldbowndp
            #add-point:ON ACTION controlp INFIELD gldbowndp name="construct.c.gldbowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldbowndp  #顯示到畫面上
            NEXT FIELD gldbowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldbowndp
            #add-point:BEFORE FIELD gldbowndp name="construct.b.gldbowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldbowndp
            
            #add-point:AFTER FIELD gldbowndp name="construct.a.gldbowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldbcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldbcrtid
            #add-point:ON ACTION controlp INFIELD gldbcrtid name="construct.c.gldbcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldbcrtid  #顯示到畫面上
            NEXT FIELD gldbcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldbcrtid
            #add-point:BEFORE FIELD gldbcrtid name="construct.b.gldbcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldbcrtid
            
            #add-point:AFTER FIELD gldbcrtid name="construct.a.gldbcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldbcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldbcrtdp
            #add-point:ON ACTION controlp INFIELD gldbcrtdp name="construct.c.gldbcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldbcrtdp  #顯示到畫面上
            NEXT FIELD gldbcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldbcrtdp
            #add-point:BEFORE FIELD gldbcrtdp name="construct.b.gldbcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldbcrtdp
            
            #add-point:AFTER FIELD gldbcrtdp name="construct.a.gldbcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldbcrtdt
            #add-point:BEFORE FIELD gldbcrtdt name="construct.b.gldbcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gldbmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldbmodid
            #add-point:ON ACTION controlp INFIELD gldbmodid name="construct.c.gldbmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldbmodid  #顯示到畫面上
            NEXT FIELD gldbmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldbmodid
            #add-point:BEFORE FIELD gldbmodid name="construct.b.gldbmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldbmodid
            
            #add-point:AFTER FIELD gldbmodid name="construct.a.gldbmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldbmoddt
            #add-point:BEFORE FIELD gldbmoddt name="construct.b.gldbmoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON gldc002,gldc003,gldc004,gldc005,gldc006,gldc007,gldc008,gldc009
           FROM s_detail1[1].gldc002,s_detail1[1].gldc003,s_detail1[1].gldc004,s_detail1[1].gldc005, 
               s_detail1[1].gldc006,s_detail1[1].gldc007,s_detail1[1].gldc008,s_detail1[1].gldc009
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc002
            #add-point:BEFORE FIELD gldc002 name="construct.b.page1.gldc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc002
            
            #add-point:AFTER FIELD gldc002 name="construct.a.page1.gldc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc002
            #add-point:ON ACTION controlp INFIELD gldc002 name="construct.c.page1.gldc002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " gldastus = 'Y' "
            CALL q_glda001()
            DISPLAY g_qryparam.return1 TO gldc002
            NEXT FIELD gldc002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc003
            #add-point:BEFORE FIELD gldc003 name="construct.b.page1.gldc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc003
            
            #add-point:AFTER FIELD gldc003 name="construct.a.page1.gldc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc003
            #add-point:ON ACTION controlp INFIELD gldc003 name="construct.c.page1.gldc003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO gldc003
            NEXT FIELD gldc003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc004
            #add-point:BEFORE FIELD gldc004 name="construct.b.page1.gldc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc004
            
            #add-point:AFTER FIELD gldc004 name="construct.a.page1.gldc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc004
            #add-point:ON ACTION controlp INFIELD gldc004 name="construct.c.page1.gldc004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc005
            #add-point:BEFORE FIELD gldc005 name="construct.b.page1.gldc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc005
            
            #add-point:AFTER FIELD gldc005 name="construct.a.page1.gldc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc005
            #add-point:ON ACTION controlp INFIELD gldc005 name="construct.c.page1.gldc005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc006
            #add-point:BEFORE FIELD gldc006 name="construct.b.page1.gldc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc006
            
            #add-point:AFTER FIELD gldc006 name="construct.a.page1.gldc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc006
            #add-point:ON ACTION controlp INFIELD gldc006 name="construct.c.page1.gldc006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc007
            #add-point:BEFORE FIELD gldc007 name="construct.b.page1.gldc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc007
            
            #add-point:AFTER FIELD gldc007 name="construct.a.page1.gldc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc007
            #add-point:ON ACTION controlp INFIELD gldc007 name="construct.c.page1.gldc007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc008
            #add-point:BEFORE FIELD gldc008 name="construct.b.page1.gldc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc008
            
            #add-point:AFTER FIELD gldc008 name="construct.a.page1.gldc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc008
            #add-point:ON ACTION controlp INFIELD gldc008 name="construct.c.page1.gldc008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc009
            #add-point:BEFORE FIELD gldc009 name="construct.b.page1.gldc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc009
            
            #add-point:AFTER FIELD gldc009 name="construct.a.page1.gldc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc009
            #add-point:ON ACTION controlp INFIELD gldc009 name="construct.c.page1.gldc009"
            
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
                  WHEN la_wc[li_idx].tableid = "gldb_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "gldc_t" 
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
   #確定查詢就展樹
   IF INT_FLAG THEN
   ELSE
      CALL agli510_grow_tree(g_wc,g_wc2)
   END IF 
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="agli510.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION agli510_filter()
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
      CONSTRUCT g_wc_filter ON gldb001,gldbld,gldb002
                          FROM s_browse[1].b_gldb001,s_browse[1].b_gldbld,s_browse[1].b_gldb002
 
         BEFORE CONSTRUCT
               DISPLAY agli510_filter_parser('gldb001') TO s_browse[1].b_gldb001
            DISPLAY agli510_filter_parser('gldbld') TO s_browse[1].b_gldbld
            DISPLAY agli510_filter_parser('gldb002') TO s_browse[1].b_gldb002
      
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
 
      CALL agli510_filter_show('gldb001')
   CALL agli510_filter_show('gldbld')
   CALL agli510_filter_show('gldb002')
 
END FUNCTION
 
{</section>}
 
{<section id="agli510.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION agli510_filter_parser(ps_field)
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
 
{<section id="agli510.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION agli510_filter_show(ps_field)
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
   LET ls_condition = agli510_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="agli510.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION agli510_query()
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
   CALL g_gldc_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL agli510_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL agli510_browser_fill("")
      CALL agli510_fetch("")
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
      CALL agli510_filter_show('gldb001')
   CALL agli510_filter_show('gldbld')
   CALL agli510_filter_show('gldb002')
   CALL agli510_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL agli510_fetch("F") 
      #顯示單身筆數
      CALL agli510_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="agli510.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION agli510_fetch(p_flag)
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
   
   LET g_gldb_m.gldbld = g_browser[g_current_idx].b_gldbld
   LET g_gldb_m.gldb001 = g_browser[g_current_idx].b_gldb001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE agli510_master_referesh USING g_gldb_m.gldbld,g_gldb_m.gldb001 INTO g_gldb_m.gldbld,g_gldb_m.gldb001, 
       g_gldb_m.gldb002,g_gldb_m.gldbstus,g_gldb_m.gldbownid,g_gldb_m.gldbowndp,g_gldb_m.gldbcrtid,g_gldb_m.gldbcrtdp, 
       g_gldb_m.gldbcrtdt,g_gldb_m.gldbmodid,g_gldb_m.gldbmoddt,g_gldb_m.gldbownid_desc,g_gldb_m.gldbowndp_desc, 
       g_gldb_m.gldbcrtid_desc,g_gldb_m.gldbcrtdp_desc,g_gldb_m.gldbmodid_desc
   
   #遮罩相關處理
   LET g_gldb_m_mask_o.* =  g_gldb_m.*
   CALL agli510_gldb_t_mask()
   LET g_gldb_m_mask_n.* =  g_gldb_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agli510_set_act_visible()   
   CALL agli510_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_gldb_m_t.* = g_gldb_m.*
   LET g_gldb_m_o.* = g_gldb_m.*
   
   LET g_data_owner = g_gldb_m.gldbownid      
   LET g_data_dept  = g_gldb_m.gldbowndp
   
   #重新顯示   
   CALL agli510_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="agli510.insert" >}
#+ 資料新增
PRIVATE FUNCTION agli510_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_gldc_d.clear()   
 
 
   INITIALIZE g_gldb_m.* TO NULL             #DEFAULT 設定
   
   LET g_gldbld_t = NULL
   LET g_gldb001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gldb_m.gldbownid = g_user
      LET g_gldb_m.gldbowndp = g_dept
      LET g_gldb_m.gldbcrtid = g_user
      LET g_gldb_m.gldbcrtdp = g_dept 
      LET g_gldb_m.gldbcrtdt = cl_get_current()
      LET g_gldb_m.gldbmodid = g_user
      LET g_gldb_m.gldbmoddt = cl_get_current()
      LET g_gldb_m.gldbstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_gldb_m_t.* = g_gldb_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_gldb_m_t.* = g_gldb_m.*
      LET g_gldb_m_o.* = g_gldb_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gldb_m.gldbstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL agli510_input("a")
      
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
         INITIALIZE g_gldb_m.* TO NULL
         INITIALIZE g_gldc_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL agli510_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_gldc_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agli510_set_act_visible()   
   CALL agli510_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gldbld_t = g_gldb_m.gldbld
   LET g_gldb001_t = g_gldb_m.gldb001
 
   
   #組合新增資料的條件
   LET g_add_browse = " gldbent = " ||g_enterprise|| " AND",
                      " gldbld = '", g_gldb_m.gldbld, "' "
                      ," AND gldb001 = '", g_gldb_m.gldb001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agli510_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE agli510_cl
   
   CALL agli510_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE agli510_master_referesh USING g_gldb_m.gldbld,g_gldb_m.gldb001 INTO g_gldb_m.gldbld,g_gldb_m.gldb001, 
       g_gldb_m.gldb002,g_gldb_m.gldbstus,g_gldb_m.gldbownid,g_gldb_m.gldbowndp,g_gldb_m.gldbcrtid,g_gldb_m.gldbcrtdp, 
       g_gldb_m.gldbcrtdt,g_gldb_m.gldbmodid,g_gldb_m.gldbmoddt,g_gldb_m.gldbownid_desc,g_gldb_m.gldbowndp_desc, 
       g_gldb_m.gldbcrtid_desc,g_gldb_m.gldbcrtdp_desc,g_gldb_m.gldbmodid_desc
   
   
   #遮罩相關處理
   LET g_gldb_m_mask_o.* =  g_gldb_m.*
   CALL agli510_gldb_t_mask()
   LET g_gldb_m_mask_n.* =  g_gldb_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gldb_m.gldbld,g_gldb_m.gldbld_desc,g_gldb_m.gldb001,g_gldb_m.gldb001_desc,g_gldb_m.glda003, 
       g_gldb_m.glda003_desc,g_gldb_m.gldb002,g_gldb_m.gldb002_desc,g_gldb_m.gldbstus,g_gldb_m.gldbownid, 
       g_gldb_m.gldbownid_desc,g_gldb_m.gldbowndp,g_gldb_m.gldbowndp_desc,g_gldb_m.gldbcrtid,g_gldb_m.gldbcrtid_desc, 
       g_gldb_m.gldbcrtdp,g_gldb_m.gldbcrtdp_desc,g_gldb_m.gldbcrtdt,g_gldb_m.gldbmodid,g_gldb_m.gldbmodid_desc, 
       g_gldb_m.gldbmoddt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_gldb_m.gldbownid      
   LET g_data_dept  = g_gldb_m.gldbowndp
   
   #功能已完成,通報訊息中心
   CALL agli510_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="agli510.modify" >}
#+ 資料修改
PRIVATE FUNCTION agli510_modify()
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
   LET g_gldb_m_t.* = g_gldb_m.*
   LET g_gldb_m_o.* = g_gldb_m.*
   
   IF g_gldb_m.gldbld IS NULL
   OR g_gldb_m.gldb001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_gldbld_t = g_gldb_m.gldbld
   LET g_gldb001_t = g_gldb_m.gldb001
 
   CALL s_transaction_begin()
   
   OPEN agli510_cl USING g_enterprise,g_gldb_m.gldbld,g_gldb_m.gldb001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agli510_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE agli510_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agli510_master_referesh USING g_gldb_m.gldbld,g_gldb_m.gldb001 INTO g_gldb_m.gldbld,g_gldb_m.gldb001, 
       g_gldb_m.gldb002,g_gldb_m.gldbstus,g_gldb_m.gldbownid,g_gldb_m.gldbowndp,g_gldb_m.gldbcrtid,g_gldb_m.gldbcrtdp, 
       g_gldb_m.gldbcrtdt,g_gldb_m.gldbmodid,g_gldb_m.gldbmoddt,g_gldb_m.gldbownid_desc,g_gldb_m.gldbowndp_desc, 
       g_gldb_m.gldbcrtid_desc,g_gldb_m.gldbcrtdp_desc,g_gldb_m.gldbmodid_desc
   
   #檢查是否允許此動作
   IF NOT agli510_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gldb_m_mask_o.* =  g_gldb_m.*
   CALL agli510_gldb_t_mask()
   LET g_gldb_m_mask_n.* =  g_gldb_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL agli510_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_gldbld_t = g_gldb_m.gldbld
      LET g_gldb001_t = g_gldb_m.gldb001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_gldb_m.gldbmodid = g_user 
LET g_gldb_m.gldbmoddt = cl_get_current()
LET g_gldb_m.gldbmodid_desc = cl_get_username(g_gldb_m.gldbmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL agli510_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE gldb_t SET (gldbmodid,gldbmoddt) = (g_gldb_m.gldbmodid,g_gldb_m.gldbmoddt)
          WHERE gldbent = g_enterprise AND gldbld = g_gldbld_t
            AND gldb001 = g_gldb001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_gldb_m.* = g_gldb_m_t.*
            CALL agli510_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_gldb_m.gldbld != g_gldb_m_t.gldbld
      OR g_gldb_m.gldb001 != g_gldb_m_t.gldb001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE gldc_t SET gldcld = g_gldb_m.gldbld
                                       ,gldc001 = g_gldb_m.gldb001
 
          WHERE gldcent = g_enterprise AND gldcld = g_gldb_m_t.gldbld
            AND gldc001 = g_gldb_m_t.gldb001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "gldc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gldc_t:",SQLERRMESSAGE 
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
   CALL agli510_set_act_visible()   
   CALL agli510_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " gldbent = " ||g_enterprise|| " AND",
                      " gldbld = '", g_gldb_m.gldbld, "' "
                      ," AND gldb001 = '", g_gldb_m.gldb001, "' "
 
   #填到對應位置
   CALL agli510_browser_fill("")
 
   CLOSE agli510_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agli510_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="agli510.input" >}
#+ 資料輸入
PRIVATE FUNCTION agli510_input(p_cmd)
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
   DEFINE l_comp1                LIKE ooef_t.ooef001
   DEFINE l_comp2                LIKE ooef_t.ooef001
   DEFINE l_dummy1               LIKE type_t.chr100
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
   DISPLAY BY NAME g_gldb_m.gldbld,g_gldb_m.gldbld_desc,g_gldb_m.gldb001,g_gldb_m.gldb001_desc,g_gldb_m.glda003, 
       g_gldb_m.glda003_desc,g_gldb_m.gldb002,g_gldb_m.gldb002_desc,g_gldb_m.gldbstus,g_gldb_m.gldbownid, 
       g_gldb_m.gldbownid_desc,g_gldb_m.gldbowndp,g_gldb_m.gldbowndp_desc,g_gldb_m.gldbcrtid,g_gldb_m.gldbcrtid_desc, 
       g_gldb_m.gldbcrtdp,g_gldb_m.gldbcrtdp_desc,g_gldb_m.gldbcrtdt,g_gldb_m.gldbmodid,g_gldb_m.gldbmodid_desc, 
       g_gldb_m.gldbmoddt
   
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
   LET g_forupd_sql = "SELECT gldc002,gldc003,gldc004,gldc005,gldc006,gldc007,gldc008,gldc009 FROM gldc_t  
       WHERE gldcent=? AND gldcld=? AND gldc001=? AND gldc002=? AND gldc003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agli510_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL agli510_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL agli510_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_gldb_m.gldbld,g_gldb_m.gldb001,g_gldb_m.glda003,g_gldb_m.gldb002,g_gldb_m.gldbstus 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="agli510.input.head" >}
      #單頭段
      INPUT BY NAME g_gldb_m.gldbld,g_gldb_m.gldb001,g_gldb_m.glda003,g_gldb_m.gldb002,g_gldb_m.gldbstus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN agli510_cl USING g_enterprise,g_gldb_m.gldbld,g_gldb_m.gldb001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agli510_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agli510_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL agli510_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL agli510_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldbld
            
            #add-point:AFTER FIELD gldbld name="input.a.gldbld"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldb_m.gldbld) AND NOT cl_null(g_gldb_m.gldb001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldb_m.gldbld != g_gldbld_t  OR g_gldb_m.gldb001 != g_gldb001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldb_t WHERE "||"gldbent = '" ||g_enterprise|| "' AND "||"gldbld = '"||g_gldb_m.gldbld ||"' AND "|| "gldb001 = '"||g_gldb_m.gldb001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #合併帳別
            LET g_gldb_m.gldbld_desc = ' '
            DISPLAY BY NAME g_gldb_m.gldbld_desc
            IF NOT cl_null(g_gldb_m.gldbld) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldb_m.gldbld != g_gldb_m_t.gldbld OR g_gldb_m_t.gldbld IS NULL )) THEN
                  CALL s_merge_ld_chk(g_gldb_m.gldbld,g_user,'2')RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#29 --s add
                     IF g_errno = 'sub-01302' THEN
                        LET g_errparam.replace[1] = 'agli010'
                        LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                        LET g_errparam.exeprog = 'agli010'
                     END IF
                     #160321-00016#29 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_gldb_m.gldbld = g_gldb_m_t.gldbld
                     LET g_gldb_m.gldbld_desc = s_desc_get_ld_desc(g_gldb_m.gldbld)
                     DISPLAY BY NAME g_gldb_m.gldbld,g_gldb_m.gldbld_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #albireo 151214-----s
                  #如果原有上層公司編號應清空 
                  #原因是因為上層公司跟合併帳別要互卡但以合併帳套為主
                  LET g_gldb_m.gldb001 = ''
                  LET g_gldb_m.gldb001_desc = ''
                  CALL agli510_glda003(g_gldb_m.gldb001)RETURNING g_gldb_m.glda003,g_gldb_m.glda003_desc
                  DISPLAY BY NAME g_gldb_m.gldb001,g_gldb_m.gldb001_desc
                  DISPLAY BY NAME g_gldb_m.glda003,g_gldb_m.glda003_desc                  
                  #albireo 151214-----e
               END IF
            END IF
            LET g_gldb_m.gldbld_desc = s_desc_get_ld_desc(g_gldb_m.gldbld)
            DISPLAY BY NAME g_gldb_m.gldbld,g_gldb_m.gldbld_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldbld
            #add-point:BEFORE FIELD gldbld name="input.b.gldbld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldbld
            #add-point:ON CHANGE gldbld name="input.g.gldbld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldb001
            
            #add-point:AFTER FIELD gldb001 name="input.a.gldb001"
            #應用 a05 樣板自動產生(Version:2)
            #上層公司

            #確認資料無重複
            IF NOT cl_null(g_gldb_m.gldbld) AND NOT cl_null(g_gldb_m.gldb001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldb_m.gldbld != g_gldbld_t  OR g_gldb_m.gldb001 != g_gldb001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldb_t WHERE "||"gldbent = '" ||g_enterprise|| "' AND "||"gldbld = '"||g_gldb_m.gldbld ||"' AND "|| "gldb001 = '"||g_gldb_m.gldb001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            LET g_gldb_m.gldb001_desc = ' '
            DISPLAY BY NAME g_gldb_m.gldb001_desc
            IF NOT cl_null(g_gldb_m.gldb001) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldb_m.gldb001 != g_gldb_m_t.gldb001 OR g_gldb_m_t.gldb001 IS NULL )) THEN
                  CALL s_merge_glda001_chk(g_gldb_m.gldb001)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_gldb_m.gldb001 = g_gldb_m_t.gldb001
                     LET g_gldb_m.gldb001_desc = s_desc_glda001_desc(g_gldb_m.gldb001)
                     CALL agli510_glda003(g_gldb_m.gldb001)RETURNING g_gldb_m.glda003,g_gldb_m.glda003_desc
                     DISPLAY BY NAME g_gldb_m.gldb001,g_gldb_m.gldb001_desc
                     DISPLAY BY NAME g_gldb_m.glda003,g_gldb_m.glda003_desc
                     NEXT FIELD CURRENT
                  END IF
                  #albireo 160114 mark-----s
#                  #albireo 151214-----s
#                  #與合併帳別聯合檢查
#                  #法人相同就成功
#                  IF NOT cl_null(g_gldb_m.gldbld)THEN
#                     LET l_comp1 = NULL
#                     CALL agli510_glda003(g_gldb_m.gldb001)RETURNING l_comp1,l_dummy1
#                     LET l_comp2 = NULL
#                     SELECT glaacomp INTO l_comp2 FROM glaa_t
#                      WHERE glaaent = g_enterprise
#                        AND glaald = g_gldb_m.gldbld
#                     IF NOT cl_null(l_comp1) AND NOT cl_null(l_comp2)THEN
#                        IF l_comp1 <> l_comp2 THEN
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code = 'agl-00402'
#                           LET g_errparam.extend = ''
#                           LET g_errparam.popup = TRUE
#                           CALL cl_err()
#                           LET g_gldb_m.gldb001 = g_gldb_m_t.gldb001
#                           LET g_gldb_m.gldb001_desc = s_desc_glda001_desc(g_gldb_m.gldb001)
#                           CALL agli510_glda003(g_gldb_m.gldb001)RETURNING g_gldb_m.glda003,g_gldb_m.glda003_desc
#                           DISPLAY BY NAME g_gldb_m.gldb001,g_gldb_m.gldb001_desc
#                           DISPLAY BY NAME g_gldb_m.glda003,g_gldb_m.glda003_desc
#                           NEXT FIELD CURRENT                        
#                        END IF
#                     END IF
#                  END IF
#                  #albireo 151214-----e
                   #會無法組入上層合併用組織(不是同法人)固mark
                   #albrieo 160114 mark-----e
               END IF
            END IF
            CALL agli510_glda003(g_gldb_m.gldb001)RETURNING g_gldb_m.glda003,g_gldb_m.glda003_desc
            LET g_gldb_m.gldb001_desc = s_desc_glda001_desc(g_gldb_m.gldb001)
            DISPLAY BY NAME g_gldb_m.gldb001,g_gldb_m.gldb001_desc
            DISPLAY BY NAME g_gldb_m.glda003,g_gldb_m.glda003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldb001
            #add-point:BEFORE FIELD gldb001 name="input.b.gldb001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldb001
            #add-point:ON CHANGE gldb001 name="input.g.gldb001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glda003
            
            #add-point:AFTER FIELD glda003 name="input.a.glda003"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glda003
            #add-point:BEFORE FIELD glda003 name="input.b.glda003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glda003
            #add-point:ON CHANGE glda003 name="input.g.glda003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldb002
            
            #add-point:AFTER FIELD gldb002 name="input.a.gldb002"
            #個體公司帳別
            LET g_gldb_m.gldb002_desc = ' '
            DISPLAY BY NAME g_gldb_m.gldb002_desc
            IF NOT cl_null(g_gldb_m.gldb002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldb_m.gldb002 != g_gldb_m_t.gldb002 OR g_gldb_m_t.gldb002 IS NULL )) THEN
                  CALL s_merge_ld_chk(g_gldb_m.gldb002,g_user,'1')RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#29 --s add
                     IF g_errno = 'sub-01302' THEN
                        LET g_errparam.replace[1] = 'agli010'
                        LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                        LET g_errparam.exeprog = 'agli010'
                     END IF
                     #160321-00016#29 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_gldb_m.gldb002 = g_gldb_m_t.gldb002
                     LET g_gldb_m.gldb002_desc = s_desc_get_ld_desc(g_gldb_m.gldb002)
                     DISPLAY BY NAME g_gldb_m.gldb002,g_gldb_m.gldb002_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #個體帳必須存在法人中
                  CALL s_merge_ld_with_comp_chk2(g_gldb_m.gldb002,g_gldb_m.gldb001)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_gldb_m.gldb002 = g_gldb_m_t.gldb002
                     LET g_gldb_m.gldb002_desc = s_desc_get_ld_desc(g_gldb_m.gldb002)
                     DISPLAY BY NAME g_gldb_m.gldb002,g_gldb_m.gldb002_desc
                     NEXT FIELD CURRENT
                  END IF                     
               END IF
            END IF
            LET g_gldb_m.gldb002_desc = s_desc_get_ld_desc(g_gldb_m.gldb002)
            DISPLAY BY NAME g_gldb_m.gldb002,g_gldb_m.gldb002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldb002
            #add-point:BEFORE FIELD gldb002 name="input.b.gldb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldb002
            #add-point:ON CHANGE gldb002 name="input.g.gldb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldbstus
            #add-point:BEFORE FIELD gldbstus name="input.b.gldbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldbstus
            
            #add-point:AFTER FIELD gldbstus name="input.a.gldbstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldbstus
            #add-point:ON CHANGE gldbstus name="input.g.gldbstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gldbld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldbld
            #add-point:ON ACTION controlp INFIELD gldbld name="input.c.gldbld"
            #合併帳別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldb_m.gldbld             #給予default值
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            LET g_qryparam.where = " glaald IN (SELECT glaald FROM glaa_t WHERE glaa130 = 'Y') "              #為合併帳別
            CALL q_authorised_ld()
            LET g_gldb_m.gldbld = g_qryparam.return1
            LET g_gldb_m.gldbld_desc = s_desc_get_ld_desc(g_gldb_m.gldbld)
            DISPLAY BY NAME g_gldb_m.gldbld,g_gldb_m.gldbld_desc
            NEXT FIELD gldbld
            #END add-point
 
 
         #Ctrlp:input.c.gldb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldb001
            #add-point:ON ACTION controlp INFIELD gldb001 name="input.c.gldb001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldb_m.gldb001            #給予default值
            LET l_comp2 = NULL
            SELECT glaacomp INTO l_comp2 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = g_gldb_m.gldbld 
               
            LET g_qryparam.where = " gldastus = 'Y' " #,
                                   #" AND glda003 = '",l_comp2,"' "   #合併帳套法人相同的個體公司  #albireo 160114 mark
            CALL q_glda001()
            LET g_gldb_m.gldb001 = g_qryparam.return1
            LET g_gldb_m.gldb001_desc = s_desc_glda001_desc(g_gldb_m.gldb001)
            CALL agli510_glda003(g_gldb_m.gldb001)RETURNING g_gldb_m.glda003,g_gldb_m.glda003_desc
            DISPLAY BY NAME g_gldb_m.gldb001,g_gldb_m.gldb001_desc
            DISPLAY BY NAME g_gldb_m.glda003,g_gldb_m.glda003_desc
            NEXT FIELD gldb001
            #END add-point
 
 
         #Ctrlp:input.c.glda003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glda003
            #add-point:ON ACTION controlp INFIELD glda003 name="input.c.glda003"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldb002
            #add-point:ON ACTION controlp INFIELD gldb002 name="input.c.gldb002"
           #合併帳別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldb_m.gldb002             #給予default值
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            LET g_qryparam.where = " glaacomp = '",g_gldb_m.glda003,"' "
            CALL q_authorised_ld()
            LET g_gldb_m.gldb002 = g_qryparam.return1
            LET g_gldb_m.gldb002_desc = s_desc_get_ld_desc(g_gldb_m.gldb002)
            DISPLAY BY NAME g_gldb_m.gldb002,g_gldb_m.gldb002_desc
            NEXT FIELD gldb002
            #END add-point
 
 
         #Ctrlp:input.c.gldbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldbstus
            #add-point:ON ACTION controlp INFIELD gldbstus name="input.c.gldbstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_gldb_m.gldbld,g_gldb_m.gldb001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO gldb_t (gldbent,gldbld,gldb001,gldb002,gldbstus,gldbownid,gldbowndp,gldbcrtid, 
                   gldbcrtdp,gldbcrtdt,gldbmodid,gldbmoddt)
               VALUES (g_enterprise,g_gldb_m.gldbld,g_gldb_m.gldb001,g_gldb_m.gldb002,g_gldb_m.gldbstus, 
                   g_gldb_m.gldbownid,g_gldb_m.gldbowndp,g_gldb_m.gldbcrtid,g_gldb_m.gldbcrtdp,g_gldb_m.gldbcrtdt, 
                   g_gldb_m.gldbmodid,g_gldb_m.gldbmoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_gldb_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               INSERT INTO gldc_t(gldcent,gldcld,gldc001,
                                  gldc002,gldc003,gldc004,gldc005,gldc006,
                                  gldc007,gldc008,gldc009)
                VALUES(g_enterprise,g_gldb_m.gldbld,g_gldb_m.gldb001,
                       g_gldb_m.gldb001,g_gldb_m.gldb002,100,'Y',0,
                       0,g_today,'Y')
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gldb INSERT gldc" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF                       
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL agli510_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL agli510_b_fill()
                  CALL agli510_b_fill2('0')
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
               CALL agli510_gldb_t_mask_restore('restore_mask_o')
               
               UPDATE gldb_t SET (gldbld,gldb001,gldb002,gldbstus,gldbownid,gldbowndp,gldbcrtid,gldbcrtdp, 
                   gldbcrtdt,gldbmodid,gldbmoddt) = (g_gldb_m.gldbld,g_gldb_m.gldb001,g_gldb_m.gldb002, 
                   g_gldb_m.gldbstus,g_gldb_m.gldbownid,g_gldb_m.gldbowndp,g_gldb_m.gldbcrtid,g_gldb_m.gldbcrtdp, 
                   g_gldb_m.gldbcrtdt,g_gldb_m.gldbmodid,g_gldb_m.gldbmoddt)
                WHERE gldbent = g_enterprise AND gldbld = g_gldbld_t
                  AND gldb001 = g_gldb001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gldb_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL agli510_gldb_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_gldb_m_t)
               LET g_log2 = util.JSON.stringify(g_gldb_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_gldbld_t = g_gldb_m.gldbld
            LET g_gldb001_t = g_gldb_m.gldb001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="agli510.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_gldc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gldc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agli510_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_gldc_d.getLength()
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
            OPEN agli510_cl USING g_enterprise,g_gldb_m.gldbld,g_gldb_m.gldb001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agli510_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agli510_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_gldc_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gldc_d[l_ac].gldc002 IS NOT NULL
               AND g_gldc_d[l_ac].gldc003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gldc_d_t.* = g_gldc_d[l_ac].*  #BACKUP
               LET g_gldc_d_o.* = g_gldc_d[l_ac].*  #BACKUP
               CALL agli510_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL agli510_set_no_entry_b(l_cmd)
               IF NOT agli510_lock_b("gldc_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agli510_bcl INTO g_gldc_d[l_ac].gldc002,g_gldc_d[l_ac].gldc003,g_gldc_d[l_ac].gldc004, 
                      g_gldc_d[l_ac].gldc005,g_gldc_d[l_ac].gldc006,g_gldc_d[l_ac].gldc007,g_gldc_d[l_ac].gldc008, 
                      g_gldc_d[l_ac].gldc009
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gldc_d_t.gldc002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gldc_d_mask_o[l_ac].* =  g_gldc_d[l_ac].*
                  CALL agli510_gldc_t_mask()
                  LET g_gldc_d_mask_n[l_ac].* =  g_gldc_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL agli510_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            LET g_gldc_d[l_ac].gldc002_desc = s_desc_glda001_desc(g_gldc_d[l_ac].gldc002)
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
            INITIALIZE g_gldc_d[l_ac].* TO NULL 
            INITIALIZE g_gldc_d_t.* TO NULL 
            INITIALIZE g_gldc_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_gldc_d[l_ac].gldc004 = "0"
      LET g_gldc_d[l_ac].gldc006 = "0"
      LET g_gldc_d[l_ac].gldc007 = "0"
      LET g_gldc_d[l_ac].gldc009 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_gldc_d[l_ac].gldc004 = 100
            LET g_gldc_d[l_ac].gldc005 = 'Y'
            LET g_gldc_d[l_ac].gldc008 = g_today
            LET g_gldc_d[l_ac].gldc009 = 'N'
            #end add-point
            LET g_gldc_d_t.* = g_gldc_d[l_ac].*     #新輸入資料
            LET g_gldc_d_o.* = g_gldc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agli510_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL agli510_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gldc_d[li_reproduce_target].* = g_gldc_d[li_reproduce].*
 
               LET g_gldc_d[li_reproduce_target].gldc002 = NULL
               LET g_gldc_d[li_reproduce_target].gldc003 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM gldc_t 
             WHERE gldcent = g_enterprise AND gldcld = g_gldb_m.gldbld
               AND gldc001 = g_gldb_m.gldb001
 
               AND gldc002 = g_gldc_d[l_ac].gldc002
               AND gldc003 = g_gldc_d[l_ac].gldc003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldb_m.gldbld
               LET gs_keys[2] = g_gldb_m.gldb001
               LET gs_keys[3] = g_gldc_d[g_detail_idx].gldc002
               LET gs_keys[4] = g_gldc_d[g_detail_idx].gldc003
               CALL agli510_insert_b('gldc_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #151113-00002#34--s
               #首次新增下層公司,寫入持股比例檔
               CALL agli510_ins_glfj(l_ac) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT                  
               END IF
               #151113-00002#34--e
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_gldc_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gldc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agli510_b_fill()
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
               LET gs_keys[01] = g_gldb_m.gldbld
               LET gs_keys[gs_keys.getLength()+1] = g_gldb_m.gldb001
 
               LET gs_keys[gs_keys.getLength()+1] = g_gldc_d_t.gldc002
               LET gs_keys[gs_keys.getLength()+1] = g_gldc_d_t.gldc003
 
            
               #刪除同層單身
               IF NOT agli510_delete_b('gldc_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agli510_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT agli510_key_delete_b(gs_keys,'gldc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agli510_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE agli510_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_gldc_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gldc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc002
            
            #add-point:AFTER FIELD gldc002 name="input.a.page1.gldc002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gldb_m.gldbld IS NOT NULL AND g_gldb_m.gldb001 IS NOT NULL AND g_gldc_d[g_detail_idx].gldc002 IS NOT NULL AND g_gldc_d[g_detail_idx].gldc003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldb_m.gldbld != g_gldbld_t OR g_gldb_m.gldb001 != g_gldb001_t OR g_gldc_d[g_detail_idx].gldc002 != g_gldc_d_t.gldc002 OR g_gldc_d[g_detail_idx].gldc003 != g_gldc_d_t.gldc003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldc_t WHERE "||"gldcent = '" ||g_enterprise|| "' AND "||"gldcld = '"||g_gldb_m.gldbld ||"' AND "|| "gldc001 = '"||g_gldb_m.gldb001 ||"' AND "|| "gldc002 = '"||g_gldc_d[g_detail_idx].gldc002 ||"' AND "|| "gldc003 = '"||g_gldc_d[g_detail_idx].gldc003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #下層公司
            LET g_gldc_d[l_ac].gldc002_desc = ' '
            DISPLAY BY NAME g_gldc_d[l_ac].gldc002_desc
            IF NOT cl_null(g_gldc_d[l_ac].gldc002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldc_d[l_ac].gldc002 != g_gldc_d_t.gldc002 OR g_gldc_d_t.gldc002 IS NULL )) THEN
                  CALL s_merge_glda001_chk(g_gldc_d[l_ac].gldc002)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_gldc_d[l_ac].gldc002 = g_gldc_d_t.gldc002
                     LET g_gldc_d[l_ac].gldc002_desc = s_desc_glda001_desc(g_gldc_d[l_ac].gldc002)
                     DISPLAY BY NAME g_gldc_d[l_ac].gldc002,g_gldc_d[l_ac].gldc002_desc
                     NEXT FIELD CURRENT
                  END IF

                  #同個下層公司單身只能存在一次 
                  LET l_count = NULL
                  SELECT COUNT(*) INTO l_count 
                    FROM gldc_t
                   WHERE gldcent = g_enterprise
                     AND gldcld  = g_gldb_m.gldbld
                     AND gldc001 = g_gldb_m.gldb001
                     AND gldc002 = g_gldc_d[l_ac].gldc002
                     AND gldc009 = 'Y'
                  IF cl_null(l_count)THEN LET l_count = 0 END IF
                  IF l_count > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00317'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_gldc_d[l_ac].gldc002 = g_gldc_d_t.gldc002
                     LET g_gldc_d[l_ac].gldc002_desc = s_desc_glda001_desc(g_gldc_d[l_ac].gldc002)
                     DISPLAY BY NAME g_gldc_d[l_ac].gldc002,g_gldc_d[l_ac].gldc002_desc
                     NEXT FIELD CURRENT
                  END IF

                  #同個下層公司單身只能存在一次 
                  LET l_count = NULL
                  SELECT COUNT(*) INTO l_count 
                    FROM gldc_t
                   WHERE gldcent = g_enterprise
                     AND gldcld  = g_gldb_m.gldbld
                     AND gldc001 = g_gldb_m.gldb001
                     AND gldc002 = g_gldc_d[l_ac].gldc002
                     AND gldc009 = 'N'
                  IF cl_null(l_count)THEN LET l_count = 0 END IF
                  IF l_count > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00337'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_gldc_d[l_ac].gldc002 = g_gldc_d_t.gldc002
                     LET g_gldc_d[l_ac].gldc002_desc = s_desc_glda001_desc(g_gldc_d[l_ac].gldc002)
                     DISPLAY BY NAME g_gldc_d[l_ac].gldc002,g_gldc_d[l_ac].gldc002_desc
                     NEXT FIELD CURRENT
                  END IF 

                  #albireo 151214-----s
                  #檢核成功後預帶對應法人的主帳套出來
                   CALL agli510_glda003(g_gldc_d[l_ac].gldc002)RETURNING l_comp1,l_dummy1
                  CALL s_fin_orga_get_comp_ld(l_comp1) RETURNING g_sub_success,g_errno,l_comp1,g_gldc_d[l_ac].gldc003
                  DISPLAY BY NAME g_gldc_d[l_ac].gldc003
                  #albireo 151214-----e
               END IF
            END IF
            LET g_gldc_d[l_ac].gldc002_desc = s_desc_glda001_desc(g_gldc_d[l_ac].gldc002)
            DISPLAY BY NAME g_gldc_d[l_ac].gldc002,g_gldc_d[l_ac].gldc002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc002
            #add-point:BEFORE FIELD gldc002 name="input.b.page1.gldc002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldc002
            #add-point:ON CHANGE gldc002 name="input.g.page1.gldc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc002_desc
            #add-point:BEFORE FIELD gldc002_desc name="input.b.page1.gldc002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc002_desc
            
            #add-point:AFTER FIELD gldc002_desc name="input.a.page1.gldc002_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldc002_desc
            #add-point:ON CHANGE gldc002_desc name="input.g.page1.gldc002_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc003
            #add-point:BEFORE FIELD gldc003 name="input.b.page1.gldc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc003
            
            #add-point:AFTER FIELD gldc003 name="input.a.page1.gldc003"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gldb_m.gldbld IS NOT NULL AND g_gldb_m.gldb001 IS NOT NULL AND g_gldc_d[g_detail_idx].gldc002 IS NOT NULL AND g_gldc_d[g_detail_idx].gldc003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldb_m.gldbld != g_gldbld_t OR g_gldb_m.gldb001 != g_gldb001_t OR g_gldc_d[g_detail_idx].gldc002 != g_gldc_d_t.gldc002 OR g_gldc_d[g_detail_idx].gldc003 != g_gldc_d_t.gldc003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldc_t WHERE "||"gldcent = '" ||g_enterprise|| "' AND "||"gldcld = '"||g_gldb_m.gldbld ||"' AND "|| "gldc001 = '"||g_gldb_m.gldb001 ||"' AND "|| "gldc002 = '"||g_gldc_d[g_detail_idx].gldc002 ||"' AND "|| "gldc003 = '"||g_gldc_d[g_detail_idx].gldc003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #LET g_gldc_d[l_ac].gldc003_desc = ' '
            #DISPLAY BY NAME g_gldc_d[l_ac].gldc003_desc
            IF NOT cl_null(g_gldc_d[l_ac].gldc003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldc_d[l_ac].gldc003 != g_gldc_d_t.gldc003 OR g_gldc_d_t.gldc003 IS NULL )) THEN
                  CALL s_merge_ld_chk(g_gldc_d[l_ac].gldc003,g_user,'1')RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#29 --s add
                     IF g_errno = 'sub-01302' THEN
                        LET g_errparam.replace[1] = 'agli010'
                        LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                        LET g_errparam.exeprog = 'agli010'
                     END IF
                     #160321-00016#29 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_gldc_d[l_ac].gldc003 = g_gldc_d_t.gldc003
                     #LET g_gldc_d[l_ac].gldc003_desc = s_desc_get_ld_desc(g_gldc_d[l_ac].gldc003)
                     DISPLAY BY NAME g_gldc_d[l_ac].gldc003 #,g_gldc_d[l_ac].gldc003_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #albireo 160114 mark-----s
                  #albireo 151214-----s
#                  #修改單身帳別時檢核與單身公司是否同法人
#                  #個體帳必須存在法人中
#                  CALL s_merge_ld_with_comp_chk2(g_gldc_d[l_ac].gldc003,g_gldc_d[l_ac].gldc002)
#                     RETURNING g_sub_success,g_errno
#                  IF NOT g_sub_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_gldc_d[l_ac].gldc003 = g_gldc_d_t.gldc003
#                     DISPLAY BY NAME g_gldc_d[l_ac].gldc003 
#                     NEXT FIELD CURRENT
#                  END IF                   
#                  #albireo 151214-----e

                  #控卡同法人會無法輸入合併帳套故MARK
                  #albireo 160114 mark-----e
               END IF
            END IF
            #LET g_gldc_d[l_ac].gldc003_desc = s_desc_get_ld_desc(g_gldc_d[l_ac].gldc003)
            #DISPLAY BY NAME g_gldc_d[l_ac].gldc003,g_gldc_d[l_ac].gldc003_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldc003
            #add-point:ON CHANGE gldc003 name="input.g.page1.gldc003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gldc_d[l_ac].gldc004,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD gldc004
            END IF 
 
 
 
            #add-point:AFTER FIELD gldc004 name="input.a.page1.gldc004"
            IF NOT cl_null(g_gldc_d[l_ac].gldc004) THEN 
               IF cl_null(g_gldc_d_t.gldc004) OR (g_gldc_d[l_ac].gldc004 <> g_gldc_d_t.gldc004) THEN
                  IF g_gldc_d[l_ac].gldc004 < 50 THEN
                     LET g_gldc_d[l_ac].gldc005 = 'N'
                     DISPLAY BY NAME g_gldc_d[l_ac].gldc005
                  ELSE
                     LET g_gldc_d[l_ac].gldc005 = 'Y'
                     DISPLAY BY NAME g_gldc_d[l_ac].gldc005
                  END IF
               END IF
            END IF 
            DISPLAY BY NAME g_gldc_d[l_ac].gldc004
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc004
            #add-point:BEFORE FIELD gldc004 name="input.b.page1.gldc004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldc004
            #add-point:ON CHANGE gldc004 name="input.g.page1.gldc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc005
            #add-point:BEFORE FIELD gldc005 name="input.b.page1.gldc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc005
            
            #add-point:AFTER FIELD gldc005 name="input.a.page1.gldc005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldc005
            #add-point:ON CHANGE gldc005 name="input.g.page1.gldc005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gldc_d[l_ac].gldc006,"0","1","","","azz-00079",1) THEN
               NEXT FIELD gldc006
            END IF 
 
 
 
            #add-point:AFTER FIELD gldc006 name="input.a.page1.gldc006"
            IF NOT cl_null(g_gldc_d[l_ac].gldc006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc006
            #add-point:BEFORE FIELD gldc006 name="input.b.page1.gldc006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldc006
            #add-point:ON CHANGE gldc006 name="input.g.page1.gldc006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gldc_d[l_ac].gldc007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD gldc007
            END IF 
 
 
 
            #add-point:AFTER FIELD gldc007 name="input.a.page1.gldc007"
            IF NOT cl_null(g_gldc_d[l_ac].gldc007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc007
            #add-point:BEFORE FIELD gldc007 name="input.b.page1.gldc007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldc007
            #add-point:ON CHANGE gldc007 name="input.g.page1.gldc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc008
            #add-point:BEFORE FIELD gldc008 name="input.b.page1.gldc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc008
            
            #add-point:AFTER FIELD gldc008 name="input.a.page1.gldc008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldc008
            #add-point:ON CHANGE gldc008 name="input.g.page1.gldc008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc009
            #add-point:BEFORE FIELD gldc009 name="input.b.page1.gldc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc009
            
            #add-point:AFTER FIELD gldc009 name="input.a.page1.gldc009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldc009
            #add-point:ON CHANGE gldc009 name="input.g.page1.gldc009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gldc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc002
            #add-point:ON ACTION controlp INFIELD gldc002 name="input.c.page1.gldc002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldc_d[l_ac].gldc002             #給予default值
            LET g_qryparam.where = " gldastus = 'Y' "
            CALL q_glda001()
            LET g_gldc_d[l_ac].gldc002 = g_qryparam.return1
            LET g_gldc_d[l_ac].gldc002_desc = s_desc_glda001_desc(g_gldc_d[l_ac].gldc002)
            DISPLAY BY NAME g_gldc_d[l_ac].gldc002,g_gldc_d[l_ac].gldc002_desc
            NEXT FIELD gldc002
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldc002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc002_desc
            #add-point:ON ACTION controlp INFIELD gldc002_desc name="input.c.page1.gldc002_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc003
            #add-point:ON ACTION controlp INFIELD gldc003 name="input.c.page1.gldc003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldc_d[l_ac].gldc003            #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #CALL agli510_glda003(g_gldc_d[l_ac].gldc002)RETURNING l_comp1,l_dummy1
            #LET g_qryparam.where = "glaacomp = '",l_comp1,"' "
            CALL q_authorised_ld()
            LET  g_gldc_d[l_ac].gldc003 = g_qryparam.return1
            DISPLAY BY NAME g_gldc_d[l_ac].gldc003
            NEXT FIELD gldc003
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc004
            #add-point:ON ACTION controlp INFIELD gldc004 name="input.c.page1.gldc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc005
            #add-point:ON ACTION controlp INFIELD gldc005 name="input.c.page1.gldc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc006
            #add-point:ON ACTION controlp INFIELD gldc006 name="input.c.page1.gldc006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc007
            #add-point:ON ACTION controlp INFIELD gldc007 name="input.c.page1.gldc007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc008
            #add-point:ON ACTION controlp INFIELD gldc008 name="input.c.page1.gldc008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc009
            #add-point:ON ACTION controlp INFIELD gldc009 name="input.c.page1.gldc009"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gldc_d[l_ac].* = g_gldc_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agli510_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gldc_d[l_ac].gldc002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_gldc_d[l_ac].* = g_gldc_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL agli510_gldc_t_mask_restore('restore_mask_o')
      
               UPDATE gldc_t SET (gldcld,gldc001,gldc002,gldc003,gldc004,gldc005,gldc006,gldc007,gldc008, 
                   gldc009) = (g_gldb_m.gldbld,g_gldb_m.gldb001,g_gldc_d[l_ac].gldc002,g_gldc_d[l_ac].gldc003, 
                   g_gldc_d[l_ac].gldc004,g_gldc_d[l_ac].gldc005,g_gldc_d[l_ac].gldc006,g_gldc_d[l_ac].gldc007, 
                   g_gldc_d[l_ac].gldc008,g_gldc_d[l_ac].gldc009)
                WHERE gldcent = g_enterprise AND gldcld = g_gldb_m.gldbld 
                  AND gldc001 = g_gldb_m.gldb001 
 
                  AND gldc002 = g_gldc_d_t.gldc002 #項次   
                  AND gldc003 = g_gldc_d_t.gldc003  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_gldc_d[l_ac].* = g_gldc_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gldc_d[l_ac].* = g_gldc_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldb_m.gldbld
               LET gs_keys_bak[1] = g_gldbld_t
               LET gs_keys[2] = g_gldb_m.gldb001
               LET gs_keys_bak[2] = g_gldb001_t
               LET gs_keys[3] = g_gldc_d[g_detail_idx].gldc002
               LET gs_keys_bak[3] = g_gldc_d_t.gldc002
               LET gs_keys[4] = g_gldc_d[g_detail_idx].gldc003
               LET gs_keys_bak[4] = g_gldc_d_t.gldc003
               CALL agli510_update_b('gldc_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL agli510_gldc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_gldc_d[g_detail_idx].gldc002 = g_gldc_d_t.gldc002 
                  AND g_gldc_d[g_detail_idx].gldc003 = g_gldc_d_t.gldc003 
 
                  ) THEN
                  LET gs_keys[01] = g_gldb_m.gldbld
                  LET gs_keys[gs_keys.getLength()+1] = g_gldb_m.gldb001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gldc_d_t.gldc002
                  LET gs_keys[gs_keys.getLength()+1] = g_gldc_d_t.gldc003
 
                  CALL agli510_key_update_b(gs_keys,'gldc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gldb_m),util.JSON.stringify(g_gldc_d_t)
               LET g_log2 = util.JSON.stringify(g_gldb_m),util.JSON.stringify(g_gldc_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL agli510_unlock_b("gldc_t","'1'")
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
               LET g_gldc_d[li_reproduce_target].* = g_gldc_d[li_reproduce].*
 
               LET g_gldc_d[li_reproduce_target].gldc002 = NULL
               LET g_gldc_d[li_reproduce_target].gldc003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gldc_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gldc_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="agli510.input.other" >}
      
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
            
            #end add-point  
            NEXT FIELD gldbld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gldc002
 
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
 
{<section id="agli510.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION agli510_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL agli510_b_fill() #單身填充
      CALL agli510_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL agli510_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   LET g_gldb_m.gldbld_desc = s_desc_get_ld_desc(g_gldb_m.gldbld)
   LET g_gldb_m.gldb001_desc = s_desc_glda001_desc(g_gldb_m.gldb001)
   CALL agli510_glda003(g_gldb_m.gldb001)RETURNING g_gldb_m.glda003,g_gldb_m.glda003_desc
   LET g_gldb_m.gldb002_desc = s_desc_get_ld_desc(g_gldb_m.gldb002)
   #end add-point
   
   #遮罩相關處理
   LET g_gldb_m_mask_o.* =  g_gldb_m.*
   CALL agli510_gldb_t_mask()
   LET g_gldb_m_mask_n.* =  g_gldb_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gldb_m.gldbld,g_gldb_m.gldbld_desc,g_gldb_m.gldb001,g_gldb_m.gldb001_desc,g_gldb_m.glda003, 
       g_gldb_m.glda003_desc,g_gldb_m.gldb002,g_gldb_m.gldb002_desc,g_gldb_m.gldbstus,g_gldb_m.gldbownid, 
       g_gldb_m.gldbownid_desc,g_gldb_m.gldbowndp,g_gldb_m.gldbowndp_desc,g_gldb_m.gldbcrtid,g_gldb_m.gldbcrtid_desc, 
       g_gldb_m.gldbcrtdp,g_gldb_m.gldbcrtdp_desc,g_gldb_m.gldbcrtdt,g_gldb_m.gldbmodid,g_gldb_m.gldbmodid_desc, 
       g_gldb_m.gldbmoddt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gldb_m.gldbstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gldc_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL agli510_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="agli510.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION agli510_detail_show()
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
 
{<section id="agli510.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION agli510_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE gldb_t.gldbld 
   DEFINE l_oldno     LIKE gldb_t.gldbld 
   DEFINE l_newno02     LIKE gldb_t.gldb001 
   DEFINE l_oldno02     LIKE gldb_t.gldb001 
 
   DEFINE l_master    RECORD LIKE gldb_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE gldc_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_gldb_m.gldbld IS NULL
   OR g_gldb_m.gldb001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_gldbld_t = g_gldb_m.gldbld
   LET g_gldb001_t = g_gldb_m.gldb001
 
    
   LET g_gldb_m.gldbld = ""
   LET g_gldb_m.gldb001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gldb_m.gldbownid = g_user
      LET g_gldb_m.gldbowndp = g_dept
      LET g_gldb_m.gldbcrtid = g_user
      LET g_gldb_m.gldbcrtdp = g_dept 
      LET g_gldb_m.gldbcrtdt = cl_get_current()
      LET g_gldb_m.gldbmodid = g_user
      LET g_gldb_m.gldbmoddt = cl_get_current()
      LET g_gldb_m.gldbstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gldb_m.gldbstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_gldb_m.gldbld_desc = ''
   DISPLAY BY NAME g_gldb_m.gldbld_desc
   LET g_gldb_m.gldb001_desc = ''
   DISPLAY BY NAME g_gldb_m.gldb001_desc
 
   
   CALL agli510_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_gldb_m.* TO NULL
      INITIALIZE g_gldc_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL agli510_show()
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
   CALL agli510_set_act_visible()   
   CALL agli510_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gldbld_t = g_gldb_m.gldbld
   LET g_gldb001_t = g_gldb_m.gldb001
 
   
   #組合新增資料的條件
   LET g_add_browse = " gldbent = " ||g_enterprise|| " AND",
                      " gldbld = '", g_gldb_m.gldbld, "' "
                      ," AND gldb001 = '", g_gldb_m.gldb001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agli510_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL agli510_idx_chk()
   
   LET g_data_owner = g_gldb_m.gldbownid      
   LET g_data_dept  = g_gldb_m.gldbowndp
   
   #功能已完成,通報訊息中心
   CALL agli510_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="agli510.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION agli510_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gldc_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE l_num       LIKE type_t.num5   #151113-00002#34
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   #151113-00002#34--s
   #複製時處理
   FOR l_num = 1 TO g_gldc_d.getLength()
      #首次新增下層公司,寫入持股比例檔
      CALL agli510_ins_glfj(l_num) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         RETURN       
      END IF
   END FOR
   #151113-00002#34--e
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE agli510_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gldc_t
    WHERE gldcent = g_enterprise AND gldcld = g_gldbld_t
     AND gldc001 = g_gldb001_t
 
    INTO TEMP agli510_detail
 
   #將key修正為調整後   
   UPDATE agli510_detail 
      #更新key欄位
      SET gldcld = g_gldb_m.gldbld
          , gldc001 = g_gldb_m.gldb001
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO gldc_t SELECT * FROM agli510_detail
   
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
   DROP TABLE agli510_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
 
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gldbld_t = g_gldb_m.gldbld
   LET g_gldb001_t = g_gldb_m.gldb001
 
   
END FUNCTION
 
{</section>}
 
{<section id="agli510.delete" >}
#+ 資料刪除
PRIVATE FUNCTION agli510_delete()
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
   
   IF g_gldb_m.gldbld IS NULL
   OR g_gldb_m.gldb001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN agli510_cl USING g_enterprise,g_gldb_m.gldbld,g_gldb_m.gldb001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agli510_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE agli510_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agli510_master_referesh USING g_gldb_m.gldbld,g_gldb_m.gldb001 INTO g_gldb_m.gldbld,g_gldb_m.gldb001, 
       g_gldb_m.gldb002,g_gldb_m.gldbstus,g_gldb_m.gldbownid,g_gldb_m.gldbowndp,g_gldb_m.gldbcrtid,g_gldb_m.gldbcrtdp, 
       g_gldb_m.gldbcrtdt,g_gldb_m.gldbmodid,g_gldb_m.gldbmoddt,g_gldb_m.gldbownid_desc,g_gldb_m.gldbowndp_desc, 
       g_gldb_m.gldbcrtid_desc,g_gldb_m.gldbcrtdp_desc,g_gldb_m.gldbmodid_desc
   
   
   #檢查是否允許此動作
   IF NOT agli510_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gldb_m_mask_o.* =  g_gldb_m.*
   CALL agli510_gldb_t_mask()
   LET g_gldb_m_mask_n.* =  g_gldb_m.*
   
   CALL agli510_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agli510_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_gldbld_t = g_gldb_m.gldbld
      LET g_gldb001_t = g_gldb_m.gldb001
 
 
      DELETE FROM gldb_t
       WHERE gldbent = g_enterprise AND gldbld = g_gldb_m.gldbld
         AND gldb001 = g_gldb_m.gldb001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_gldb_m.gldbld,":",SQLERRMESSAGE  
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
      
      DELETE FROM gldc_t
       WHERE gldcent = g_enterprise AND gldcld = g_gldb_m.gldbld
         AND gldc001 = g_gldb_m.gldb001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gldc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_gldb_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE agli510_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_gldc_d.clear() 
 
     
      CALL agli510_ui_browser_refresh()  
      #CALL agli510_ui_headershow()  
      #CALL agli510_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL agli510_browser_fill("")
         CALL agli510_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE agli510_cl
 
   #功能已完成,通報訊息中心
   CALL agli510_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="agli510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION agli510_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_gldc_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF agli510_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gldc002,gldc003,gldc004,gldc005,gldc006,gldc007,gldc008,gldc009  FROM gldc_t", 
                
                     " INNER JOIN gldb_t ON gldbent = " ||g_enterprise|| " AND gldbld = gldcld ",
                     " AND gldb001 = gldc001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE gldcent=? AND gldcld=? AND gldc001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gldc_t.gldc002,gldc_t.gldc003"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agli510_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR agli510_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_gldb_m.gldbld,g_gldb_m.gldb001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_gldb_m.gldbld,g_gldb_m.gldb001 INTO g_gldc_d[l_ac].gldc002, 
          g_gldc_d[l_ac].gldc003,g_gldc_d[l_ac].gldc004,g_gldc_d[l_ac].gldc005,g_gldc_d[l_ac].gldc006, 
          g_gldc_d[l_ac].gldc007,g_gldc_d[l_ac].gldc008,g_gldc_d[l_ac].gldc009   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         IF g_gldc_d[l_ac].gldc009 = 'Y' THEN CONTINUE FOREACH END IF
         LET g_gldc_d[l_ac].gldc002_desc = s_desc_glda001_desc(g_gldc_d[l_ac].gldc002)
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
   
   CALL g_gldc_d.deleteElement(g_gldc_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE agli510_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_gldc_d.getLength()
      LET g_gldc_d_mask_o[l_ac].* =  g_gldc_d[l_ac].*
      CALL agli510_gldc_t_mask()
      LET g_gldc_d_mask_n[l_ac].* =  g_gldc_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="agli510.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION agli510_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM gldc_t
       WHERE gldcent = g_enterprise AND
         gldcld = ps_keys_bak[1] AND gldc001 = ps_keys_bak[2] AND gldc002 = ps_keys_bak[3] AND gldc003 = ps_keys_bak[4]
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
         CALL g_gldc_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="agli510.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION agli510_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO gldc_t
                  (gldcent,
                   gldcld,gldc001,
                   gldc002,gldc003
                   ,gldc004,gldc005,gldc006,gldc007,gldc008,gldc009) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_gldc_d[g_detail_idx].gldc004,g_gldc_d[g_detail_idx].gldc005,g_gldc_d[g_detail_idx].gldc006, 
                       g_gldc_d[g_detail_idx].gldc007,g_gldc_d[g_detail_idx].gldc008,g_gldc_d[g_detail_idx].gldc009) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gldc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_gldc_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="agli510.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION agli510_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gldc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL agli510_gldc_t_mask_restore('restore_mask_o')
               
      UPDATE gldc_t 
         SET (gldcld,gldc001,
              gldc002,gldc003
              ,gldc004,gldc005,gldc006,gldc007,gldc008,gldc009) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_gldc_d[g_detail_idx].gldc004,g_gldc_d[g_detail_idx].gldc005,g_gldc_d[g_detail_idx].gldc006, 
                  g_gldc_d[g_detail_idx].gldc007,g_gldc_d[g_detail_idx].gldc008,g_gldc_d[g_detail_idx].gldc009)  
 
         WHERE gldcent = g_enterprise AND gldcld = ps_keys_bak[1] AND gldc001 = ps_keys_bak[2] AND gldc002 = ps_keys_bak[3] AND gldc003 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gldc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gldc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agli510_gldc_t_mask_restore('restore_mask_n')
               
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
 
{<section id="agli510.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION agli510_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="agli510.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION agli510_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="agli510.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION agli510_lock_b(ps_table,ps_page)
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
   #CALL agli510_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "gldc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN agli510_bcl USING g_enterprise,
                                       g_gldb_m.gldbld,g_gldb_m.gldb001,g_gldc_d[g_detail_idx].gldc002, 
                                           g_gldc_d[g_detail_idx].gldc003     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agli510_bcl:",SQLERRMESSAGE 
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
 
{<section id="agli510.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION agli510_unlock_b(ps_table,ps_page)
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
      CLOSE agli510_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="agli510.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION agli510_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("gldbld",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gldbld,gldb001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("gldb002",TRUE) 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agli510.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION agli510_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gldbld,gldb001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("gldb002",FALSE) 
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("gldbld",FALSE)
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
 
{<section id="agli510.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION agli510_set_entry_b(p_cmd)
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
 
{<section id="agli510.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION agli510_set_no_entry_b(p_cmd)
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
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="agli510.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION agli510_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agli510.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION agli510_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agli510.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION agli510_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agli510.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION agli510_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agli510.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION agli510_default_search()
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
      LET ls_wc = ls_wc, " gldbld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " gldb001 = '", g_argv[02], "' AND "
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
               WHEN la_wc[li_idx].tableid = "gldb_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "gldc_t" 
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
 
{<section id="agli510.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION agli510_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_gldb_m.gldbld IS NULL
      OR g_gldb_m.gldb001 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN agli510_cl USING g_enterprise,g_gldb_m.gldbld,g_gldb_m.gldb001
   IF STATUS THEN
      CLOSE agli510_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agli510_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE agli510_master_referesh USING g_gldb_m.gldbld,g_gldb_m.gldb001 INTO g_gldb_m.gldbld,g_gldb_m.gldb001, 
       g_gldb_m.gldb002,g_gldb_m.gldbstus,g_gldb_m.gldbownid,g_gldb_m.gldbowndp,g_gldb_m.gldbcrtid,g_gldb_m.gldbcrtdp, 
       g_gldb_m.gldbcrtdt,g_gldb_m.gldbmodid,g_gldb_m.gldbmoddt,g_gldb_m.gldbownid_desc,g_gldb_m.gldbowndp_desc, 
       g_gldb_m.gldbcrtid_desc,g_gldb_m.gldbcrtdp_desc,g_gldb_m.gldbmodid_desc
   
 
   #檢查是否允許此動作
   IF NOT agli510_action_chk() THEN
      CLOSE agli510_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gldb_m.gldbld,g_gldb_m.gldbld_desc,g_gldb_m.gldb001,g_gldb_m.gldb001_desc,g_gldb_m.glda003, 
       g_gldb_m.glda003_desc,g_gldb_m.gldb002,g_gldb_m.gldb002_desc,g_gldb_m.gldbstus,g_gldb_m.gldbownid, 
       g_gldb_m.gldbownid_desc,g_gldb_m.gldbowndp,g_gldb_m.gldbowndp_desc,g_gldb_m.gldbcrtid,g_gldb_m.gldbcrtid_desc, 
       g_gldb_m.gldbcrtdp,g_gldb_m.gldbcrtdp_desc,g_gldb_m.gldbcrtdt,g_gldb_m.gldbmodid,g_gldb_m.gldbmodid_desc, 
       g_gldb_m.gldbmoddt
 
   CASE g_gldb_m.gldbstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_gldb_m.gldbstus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.inactive"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_gldb_m.gldbstus = lc_state OR cl_null(lc_state) THEN
      CLOSE agli510_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_gldb_m.gldbmodid = g_user
   LET g_gldb_m.gldbmoddt = cl_get_current()
   LET g_gldb_m.gldbstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE gldb_t 
      SET (gldbstus,gldbmodid,gldbmoddt) 
        = (g_gldb_m.gldbstus,g_gldb_m.gldbmodid,g_gldb_m.gldbmoddt)     
    WHERE gldbent = g_enterprise AND gldbld = g_gldb_m.gldbld
      AND gldb001 = g_gldb_m.gldb001
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE agli510_master_referesh USING g_gldb_m.gldbld,g_gldb_m.gldb001 INTO g_gldb_m.gldbld,g_gldb_m.gldb001, 
          g_gldb_m.gldb002,g_gldb_m.gldbstus,g_gldb_m.gldbownid,g_gldb_m.gldbowndp,g_gldb_m.gldbcrtid, 
          g_gldb_m.gldbcrtdp,g_gldb_m.gldbcrtdt,g_gldb_m.gldbmodid,g_gldb_m.gldbmoddt,g_gldb_m.gldbownid_desc, 
          g_gldb_m.gldbowndp_desc,g_gldb_m.gldbcrtid_desc,g_gldb_m.gldbcrtdp_desc,g_gldb_m.gldbmodid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_gldb_m.gldbld,g_gldb_m.gldbld_desc,g_gldb_m.gldb001,g_gldb_m.gldb001_desc,g_gldb_m.glda003, 
          g_gldb_m.glda003_desc,g_gldb_m.gldb002,g_gldb_m.gldb002_desc,g_gldb_m.gldbstus,g_gldb_m.gldbownid, 
          g_gldb_m.gldbownid_desc,g_gldb_m.gldbowndp,g_gldb_m.gldbowndp_desc,g_gldb_m.gldbcrtid,g_gldb_m.gldbcrtid_desc, 
          g_gldb_m.gldbcrtdp,g_gldb_m.gldbcrtdp_desc,g_gldb_m.gldbcrtdt,g_gldb_m.gldbmodid,g_gldb_m.gldbmodid_desc, 
          g_gldb_m.gldbmoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE agli510_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agli510_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agli510.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION agli510_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_gldc_d.getLength() THEN
         LET g_detail_idx = g_gldc_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gldc_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gldc_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="agli510.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION agli510_b_fill2(pi_idx)
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
   
   CALL agli510_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="agli510.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION agli510_fill_chk(ps_idx)
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
 
{<section id="agli510.status_show" >}
PRIVATE FUNCTION agli510_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="agli510.mask_functions" >}
&include "erp/agl/agli510_mask.4gl"
 
{</section>}
 
{<section id="agli510.signature" >}
   
 
{</section>}
 
{<section id="agli510.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION agli510_set_pk_array()
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
   LET g_pk_array[1].values = g_gldb_m.gldbld
   LET g_pk_array[1].column = 'gldbld'
   LET g_pk_array[2].values = g_gldb_m.gldb001
   LET g_pk_array[2].column = 'gldb001'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agli510.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="agli510.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION agli510_msgcentre_notify(lc_state)
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
   CALL agli510_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gldb_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agli510.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION agli510_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="agli510.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 個體公司對應法人組織與說明
# Memo...........:
# Date & Author..: 150311 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION agli510_glda003(p_glda001)
   DEFINE p_glda001      LIKE glda_t.glda001
   DEFINE r_glda003      LIKE glda_t.glda003
   DEFINE r_glda003_desc LIKE type_t.chr100
   LET r_glda003 = NULL
   SELECT glda003 INTO r_glda003
     FROM glda_t
    WHERE gldaent = g_enterprise
      AND glda001 = p_glda001
   
   LET r_glda003_desc = s_desc_get_department_desc(r_glda003)
   RETURN r_glda003,r_glda003_desc
END FUNCTION

################################################################################
# Descriptions...: 依QBE條件展樹
# Memo...........:
# Date & Author..: 150312 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION agli510_grow_tree(p_wc,p_wc2)
   DEFINE p_wc   STRING
   DEFINE p_wc2  STRING
   DEFINE l_root DYNAMIC ARRAY OF RECORD
                 gldcld  LIKE type_t.chr100,
                 gldc001 LIKE gldc_t.gldc001
                 END RECORD
   DEFINE l_idx  LIKE type_t.num5    #array index
   DEFINE l_sql  STRING
   #從pid串取得實際pid用-----s
   DEFINE l_iddummy  LIKE type_t.num5
   DEFINE l_idroot   LIKE type_t.num5
   DEFINE l_string   STRING   
   DEFINE l_pid      LIKE type_t.num5
   #從pid串取得實際pid用-----e        
   
   DEFINE l_count    LIKE type_t.num5
   

   CALL g_tree.clear()
   #FOREACH 根節點 存成ARRAY 
   #原則:
   #gldc009 = Y類單身
   #但不存在gldc009 = N 類單身
   LET l_sql = 
              " SELECT DISTINCT gldbld,gldb001 FROM gldc_t ,gldb_t  ",
              "  WHERE gldcent = ",g_enterprise," ",
              "    AND gldcent = gldbent ",
              "    AND gldc001 = gldb001 ",
              "    AND gldcld  = gldbld  ",
              "    AND gldbstus = 'Y' ",
              #"    AND gldc009 = 'Y' ",
              "    AND ",p_wc," AND ",p_wc2,
              "    AND (gldcld,gldc001) NOT IN (SELECT gldc003,gldc002 FROM gldc_t ,gldb_t  ",
              "                    WHERE gldcent = gldbent ",
              "                      AND gldcld  = gldbld  ",
              "                      AND gldc001 = gldb001 ",
              "                      AND gldc009 = 'N' ",
              "                      AND gldbstus = 'Y' ",
              "                      AND ",p_wc," AND ",p_wc2,
              "                      AND gldcent = ",g_enterprise," ) "
   PREPARE sel_agli510_rootp1 FROM l_sql
   DECLARE sel_agli510_rootc1 CURSOR FOR sel_agli510_rootp1 
   
   #albireo 150424-----s
   LET l_sql = "SELECT COUNT(*) FROM gldc_t ",
               " WHERE gldcent = ",g_enterprise," ",
               "   AND gldcld = ? AND gldc001 = ? ",
               "   AND gldc009 = 'N' ",
               "   AND ",p_wc2 CLIPPED
   PREPARE sel_gldcp5 FROM l_sql
   #albireo 150424-----e
   
   
   LET l_idx = 1 
   FOREACH sel_agli510_rootc1 INTO l_root[l_idx].*
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF
      #有輸入單身查詢時 根結點忽略無單身資料的根結點-----s
      IF p_wc2.trim() <> '1=1' THEN
         LET l_count = NULL           
         EXECUTE sel_gldcp5 USING l_root[l_idx].gldcld,l_root[l_idx].gldc001
                            INTO l_count
         IF cl_null(l_count)THEN LET l_count = 0  END IF
            
         IF l_count = 0 THEN CONTINUE FOREACH END IF
      END IF
      #有輸入單身查詢時 根結點忽略無單身資料的根結點-----e
      
      LET l_idx = l_idx + 1
   END FOREACH
   CALL l_root.deleteElement(l_idx)
   
   IF l_root.getLength() <= 0 THEN
      RETURN
   END IF
   #用存起來的根節點呼叫遞迴
   LET g_tree_idx = 1
   
   FOR l_idx = 1 TO l_root.getLength()
      LET g_tree_pid = '0'    #代表是起始節點
      CALL agli510_grow_tree_node(l_root[l_idx].gldcld,l_root[l_idx].gldc001,p_wc,p_wc2)
   END FOR

   #如果是最根節點時KEY值會為空
   #此時就要把上層節點的資料KEY給進去
   #方便後續重show畫面
   FOR l_idx = 1 TO g_tree.getLength()
      IF cl_null(g_tree[l_idx].b_gldbld) AND cl_null(g_tree[l_idx].b_gldb001) THEN
         LET l_string = g_tree[l_idx].b_pid
         LET l_iddummy = 1
         LET l_idroot = 0
         WHILE TRUE
            LET l_iddummy = l_string.getIndexOf('.',l_iddummy)
            IF l_iddummy = 0 THEN 
               EXIT WHILE
            ELSE
               LET l_idroot = l_iddummy + 1
            END IF
            LET l_iddummy = l_iddummy + 1
         END WHILE

         LET l_string = l_string.substring(l_idroot,l_string.getLength())
         LET l_pid = l_string
         IF NOT cl_null(l_pid) AND l_pid > 0 THEN 
            LET g_tree[l_idx].b_gldbld = g_tree[l_pid].b_gldbld
            LET g_tree[l_idx].b_gldb001 = g_tree[l_pid].b_gldb001
         END IF
      END IF
   END FOR
   
END FUNCTION

################################################################################
# Descriptions...: 根節點以外往下長節點
# Memo...........:
# Date & Author..: 150312 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION agli510_grow_tree_node(p_ld,p_gldc001,p_wc,p_wc2)
   DEFINE p_ld   LIKE glaa_t.glaald
   DEFINE p_gldc001 LIKE gldc_t.gldc001
   DEFINE l_sql     STRING
   DEFINE p_wc      STRING
   DEFINE p_wc2     STRING
   DEFINE l_node    DYNAMIC ARRAY OF RECORD
                    gldcld  LIKE type_t.chr100,
                    gldc001 LIKE gldc_t.gldc001
                    END RECORD
   DEFINE l_idx     LIKE type_t.num10
   DEFINE l_id      LIKE type_t.chr100
   
   #用傳入的根節點 FOREACH 抓下節點放入l_node
   LET l_sql = "SELECT gldc003,gldc002 FROM gldc_t,gldb_t ",
               " WHERE gldc009 = 'N' ",
               "   AND gldcent = ",g_enterprise," ",
               "   AND gldcld  = '",p_ld,"' ",
               "   AND gldc001 = '",p_gldc001,"' ",
               "   AND gldcent = gldbent ",
               "   AND gldcld  = gldbld ",
               "   AND gldc001 = gldb001 ",
               "   AND ",p_wc," AND ",p_wc2
   PREPARE sel_agli510_nodep1 FROM l_sql
   DECLARE sel_agli510_nodec1 CURSOR FOR sel_agli510_nodep1
          
   CALL l_node.clear()
   LET l_idx = 1    
   FOREACH sel_agli510_nodec1 INTO l_node[l_idx].gldcld,l_node[l_idx].gldc001
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF

      LET l_idx = l_idx + 1
   END FOREACH

   #如果l_idx = 1 代表沒往下的節點
   #          > 1 代表有往下的節點
   #把上層節點給到g_tree去
   #g_tree_idx + 1
   LET g_tree[g_tree_idx].b_show = p_gldc001,'-',s_desc_glda001_desc(p_gldc001)
   LET g_tree[g_tree_idx].b_pid  = g_tree_pid CLIPPED
   LET g_tree[g_tree_idx].b_id   = g_tree_pid CLIPPED,'.',g_tree_idx USING '<<<<<<<<<<<<<<<<'
   LET g_tree[g_tree_idx].b_exp  = 'TRUE'
   LET g_tree[g_tree_idx].b_isExp = FALSE
   LET g_tree[g_tree_idx].b_expcode = FALSE   #每個節點都收起來
   
   IF l_idx = 1 THEN
   ELSE
      LET g_tree[g_tree_idx].b_hasC = TRUE
      LET g_tree[g_tree_idx].b_gldbld = p_ld
      LET g_tree[g_tree_idx].b_gldb001 = p_gldc001
   END IF
   #albireo 150424-----s
   IF g_tree_pid = '0' THEN
      LET g_tree[g_tree_idx].b_hasC = TRUE
      LET g_tree[g_tree_idx].b_gldbld = p_ld
      LET g_tree[g_tree_idx].b_gldb001 = p_gldc001   
   END IF
   #albireo 150424-----e
   LET l_id = g_tree[g_tree_idx].b_id    #自己是誰要記錄
   LET g_tree_idx = g_tree_idx + 1
  
   CALL l_node.deleteElement(l_idx)   

   #FOR 跑遞迴 再往下找節點
   FOR l_idx = 1 TO l_node.getLength()
      LET g_tree_pid = l_id CLIPPED 
      CALL agli510_grow_tree_node(l_node[l_idx].gldcld,l_node[l_idx].gldc001,p_wc,p_wc2)
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 點某個樹節點的處理
# Memo...........:
# Date & Author..: 150312 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION agli510_tree_fetch(p_idx)
   DEFINE p_idx   LIKE type_t.num5
   DEFINE l_target LIKE type_t.num5   #目標g_browser行
   DEFINE l_idx   LIKE type_t.num5

   IF cl_null(p_idx) OR p_idx <= 0 THEN RETURN END IF

   #找目標再g_browser哪一行 
   IF NOT cl_null(g_tree[p_idx].b_gldbld) 
      AND NOT cl_null(g_tree[p_idx].b_gldb001)THEN
      FOR l_idx = 1 TO g_browser.getLength()
         IF g_browser[l_idx].b_gldbld = g_tree[p_idx].b_gldbld
            AND g_browser[l_idx].b_gldb001 = g_tree[p_idx].b_gldb001 THEN
            LET l_target = l_idx
            EXIT FOR
         END IF
      END FOR
   END IF 
   
   LET g_no_ask = TRUE
   LET g_jump = l_target
   CALL agli510_fetch('/')
END FUNCTION

################################################################################
# Descriptions...: 首次新增下層公司時,若尚未存在持股歷史檔,則寫入一筆
# Memo...........:
# Usage..........: CALL agli510_ins_glfj(p_num)
#                  RETURNING r_success
# Input param....: p_num       陣列筆數
# Return code....: r_success   成功否
# Date & Author..: 16/04/29 By 03538(#151113-00002#34)
# Modify.........:
################################################################################
PRIVATE FUNCTION agli510_ins_glfj(p_num)
DEFINE p_num      LIKE type_t.num5
DEFINE l_glfj     RECORD   
   glfjent        LIKE glfj_t.glfjent, 
   glfjld         LIKE glfj_t.glfjld,
   glfj001        LIKE glfj_t.glfj001, 
   glfj002        LIKE glfj_t.glfj002, 
   glfj003        LIKE glfj_t.glfj003, 
   glfj004        LIKE glfj_t.glfj004, 
   glfj005        LIKE glfj_t.glfj005, 
   glfj006        LIKE glfj_t.glfj006, 
   glfj007        LIKE glfj_t.glfj007, 
   glfj008        LIKE glfj_t.glfj008, 
   glfj009        LIKE glfj_t.glfj009, 
   glfj010        LIKE glfj_t.glfj010
                  END RECORD
DEFINE r_success  LIKE type_t.num5
DEFINE l_cnt      LIKE type_t.num5

   LET r_success = TRUE
   LET l_cnt = 0
   
   SELECT COUNT(1) INTO l_cnt
     FROM glfj_t
    WHERE glfjent = g_enterprise    
      AND glfjld  = g_gldb_m.gldbld              #合併帳套
      AND glfj001 = g_gldb_m.gldb001             #上層公司
      AND glfj002 = g_gldb_m.gldb002             #上層公司帳套
      AND glfj003 = g_gldc_d[p_num].gldc002       #下層公司
      AND glfj004 = g_gldc_d[p_num].gldc003       #下層公司帳套
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   #不存在持股比例檔才做寫入
   IF l_cnt = 0 THEN
      LET l_glfj.glfjent = g_enterprise   
      LET l_glfj.glfjld  = g_gldb_m.gldbld           #合併帳套
      LET l_glfj.glfj001 = g_gldb_m.gldb001          #上層公司
      LET l_glfj.glfj002 = g_gldb_m.gldb002          #上層公司帳套
      LET l_glfj.glfj003 = g_gldc_d[p_num].gldc002    #下層公司
      LET l_glfj.glfj004 = g_gldc_d[p_num].gldc003    #下層公司帳套
      LET l_glfj.glfj005 = g_gldc_d[p_num].gldc004    #持股比率
      LET l_glfj.glfj006 = g_gldc_d[p_num].gldc005    #納入合併否
      LET l_glfj.glfj007 = g_gldc_d[p_num].gldc006    #投資股數
      LET l_glfj.glfj008 = g_gldc_d[p_num].gldc007    #股本
      LET l_glfj.glfj009 = g_gldc_d[p_num].gldc008    #異動日期
      LET l_glfj.glfj010 = 'I'                       #異動類型:新增
      
      INSERT INTO glfj_t
            (glfjent,glfjld,
             glfj001,glfj002,glfj003,glfj004,glfj005,
             glfj006,glfj007,glfj008,glfj009,glfj010
             )
      VALUES(l_glfj.glfjent,l_glfj.glfjld,
             l_glfj.glfj001,l_glfj.glfj002,l_glfj.glfj003,l_glfj.glfj004,l_glfj.glfj005,
             l_glfj.glfj006,l_glfj.glfj007,l_glfj.glfj008,l_glfj.glfj009,l_glfj.glfj010
             )
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "ins glfj_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF   
   END IF
   
   RETURN r_success
   
END FUNCTION

 
{</section>}
 
