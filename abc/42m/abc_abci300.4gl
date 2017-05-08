#該程式未解開Section, 採用最新樣板產出!
{<section id="abci300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-12-23 09:37:11), PR版次:0001(2017-02-03 17:38:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abci300
#+ Description: 條碼編碼維護作業
#+ Creator....: 04543(2016-12-23 09:37:11)
#+ Modifier...: 04543 -SD/PR- 04543
 
{</section>}
 
{<section id="abci300.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#Memos
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
PRIVATE type type_g_bcba_m        RECORD
       bcba001 LIKE bcba_t.bcba001, 
   bcbal003 LIKE type_t.chr500, 
   bcba002 LIKE bcba_t.bcba002, 
   bcba003 LIKE bcba_t.bcba003, 
   separate LIKE type_t.chr500, 
   bcba004 LIKE bcba_t.bcba004, 
   bcbastus LIKE bcba_t.bcbastus, 
   bcbaownid LIKE bcba_t.bcbaownid, 
   bcbaownid_desc LIKE type_t.chr80, 
   bcbaowndp LIKE bcba_t.bcbaowndp, 
   bcbaowndp_desc LIKE type_t.chr80, 
   bcbacrtid LIKE bcba_t.bcbacrtid, 
   bcbacrtid_desc LIKE type_t.chr80, 
   bcbacrtdp LIKE bcba_t.bcbacrtdp, 
   bcbacrtdp_desc LIKE type_t.chr80, 
   bcbacrtdt LIKE bcba_t.bcbacrtdt, 
   bcbamodid LIKE bcba_t.bcbamodid, 
   bcbamodid_desc LIKE type_t.chr80, 
   bcbamoddt LIKE bcba_t.bcbamoddt, 
   bcbacnfid LIKE bcba_t.bcbacnfid, 
   bcbacnfid_desc LIKE type_t.chr80, 
   bcbacnfdt LIKE bcba_t.bcbacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bcbb_d        RECORD
       bcbbseq LIKE bcbb_t.bcbbseq, 
   bcbb002 LIKE bcbb_t.bcbb002, 
   bcbb003 LIKE bcbb_t.bcbb003, 
   bcbb004 LIKE bcbb_t.bcbb004, 
   bcbb005 LIKE bcbb_t.bcbb005
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_bcba001 LIKE bcba_t.bcba001,
      b_bcba002 LIKE bcba_t.bcba002,
      b_bcbacrtid LIKE bcba_t.bcbacrtid,
   b_bcbacrtid_desc LIKE type_t.chr80,
      b_bcbacrtdp LIKE bcba_t.bcbacrtdp,
   b_bcbacrtdp_desc LIKE type_t.chr80,
      b_bcbacrtdt LIKE bcba_t.bcbacrtdt
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_separate  LIKE type_t.chr500
#end add-point
       
#模組變數(Module Variables)
DEFINE g_bcba_m          type_g_bcba_m
DEFINE g_bcba_m_t        type_g_bcba_m
DEFINE g_bcba_m_o        type_g_bcba_m
DEFINE g_bcba_m_mask_o   type_g_bcba_m #轉換遮罩前資料
DEFINE g_bcba_m_mask_n   type_g_bcba_m #轉換遮罩後資料
 
   DEFINE g_bcba001_t LIKE bcba_t.bcba001
 
 
DEFINE g_bcbb_d          DYNAMIC ARRAY OF type_g_bcbb_d
DEFINE g_bcbb_d_t        type_g_bcbb_d
DEFINE g_bcbb_d_o        type_g_bcbb_d
DEFINE g_bcbb_d_mask_o   DYNAMIC ARRAY OF type_g_bcbb_d #轉換遮罩前資料
DEFINE g_bcbb_d_mask_n   DYNAMIC ARRAY OF type_g_bcbb_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      bcbal001 LIKE bcbal_t.bcbal001,
      bcbal003 LIKE bcbal_t.bcbal003
      END RECORD
 
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
 
{<section id="abci300.main" >}
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
   CALL cl_ap_init("abc","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT bcba001,'',bcba002,bcba003,'',bcba004,bcbastus,bcbaownid,'',bcbaowndp, 
       '',bcbacrtid,'',bcbacrtdp,'',bcbacrtdt,bcbamodid,'',bcbamoddt,bcbacnfid,'',bcbacnfdt", 
                      " FROM bcba_t",
                      " WHERE bcbaent= ? AND bcba001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abci300_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bcba001,t0.bcba002,t0.bcba003,t0.bcba004,t0.bcbastus,t0.bcbaownid, 
       t0.bcbaowndp,t0.bcbacrtid,t0.bcbacrtdp,t0.bcbacrtdt,t0.bcbamodid,t0.bcbamoddt,t0.bcbacnfid,t0.bcbacnfdt, 
       t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011",
               " FROM bcba_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.bcbaownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.bcbaowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.bcbacrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.bcbacrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.bcbamodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.bcbacnfid  ",
 
               " WHERE t0.bcbaent = " ||g_enterprise|| " AND t0.bcba001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abci300_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abci300 WITH FORM cl_ap_formpath("abc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abci300_init()   
 
      #進入選單 Menu (="N")
      CALL abci300_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abci300
      
   END IF 
   
   CLOSE abci300_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abci300.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abci300_init()
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
      CALL cl_set_combo_scc_part('bcbastus','13','N,Y,X')
 
      CALL cl_set_combo_scc('bcba002','16022') 
   CALL cl_set_combo_scc('bcba004','16027') 
   CALL cl_set_combo_scc('bcbb002','16025') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_bcba002','16022') 
   LET g_separate = cl_get_para(g_enterprise,g_site,'S-APP-0008')
   
   #end add-point
   
   #初始化搜尋條件
   CALL abci300_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abci300.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abci300_ui_dialog()
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
            CALL abci300_insert()
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
         INITIALIZE g_bcba_m.* TO NULL
         CALL g_bcbb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abci300_init()
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
               
               CALL abci300_fetch('') # reload data
               LET l_ac = 1
               CALL abci300_ui_detailshow() #Setting the current row 
         
               CALL abci300_idx_chk()
               #NEXT FIELD bcbbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_bcbb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL abci300_idx_chk()
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
               CALL abci300_idx_chk()
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
            CALL abci300_browser_fill("")
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
               CALL abci300_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abci300_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL abci300_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL abci300_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL abci300_set_act_visible()   
            CALL abci300_set_act_no_visible()
            IF NOT (g_bcba_m.bcba001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " bcbaent = " ||g_enterprise|| " AND",
                                  " bcba001 = '", g_bcba_m.bcba001, "' "
 
               #填到對應位置
               CALL abci300_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "bcba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bcbb_t" 
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
               CALL abci300_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "bcba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bcbb_t" 
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
                  CALL abci300_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL abci300_fetch("F")
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
               CALL abci300_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abci300_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abci300_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abci300_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abci300_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abci300_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abci300_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abci300_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abci300_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abci300_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abci300_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_bcbb_d)
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
               NEXT FIELD bcbbseq
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
               CALL abci300_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abci300_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abci300_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abci300_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abci300_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abci300_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abci300_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abci300_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abci300_set_pk_array()
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
 
{<section id="abci300.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abci300_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT bcba001 ",
                      " FROM bcba_t ",
                      " ",
                      " LEFT JOIN bcbb_t ON bcbbent = bcbaent AND bcba001 = bcbb001 ", "  ",
                      #add-point:browser_fill段sql(bcbb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " LEFT JOIN bcbal_t ON bcbalent = "||g_enterprise||" AND bcba001 = bcbal001 AND bcbal002 = '",g_dlang,"' ", 
                      " ", 
 
 
                      " WHERE bcbaent = " ||g_enterprise|| " AND bcbbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bcba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bcba001 ",
                      " FROM bcba_t ", 
                      "  ",
                      "  LEFT JOIN bcbal_t ON bcbalent = "||g_enterprise||" AND bcba001 = bcbal001 AND bcbal002 = '",g_dlang,"' ",
                      " WHERE bcbaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bcba_t")
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
      INITIALIZE g_bcba_m.* TO NULL
      CALL g_bcbb_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bcba001,t0.bcba002,t0.bcbacrtid,t0.bcbacrtdp,t0.bcbacrtdt Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.bcbastus,t0.bcba001,t0.bcba002,t0.bcbacrtid,t0.bcbacrtdp,t0.bcbacrtdt, 
          t1.ooag011 ,t2.ooefl003 ",
                  " FROM bcba_t t0",
                  "  ",
                  "  LEFT JOIN bcbb_t ON bcbbent = bcbaent AND bcba001 = bcbb001 ", "  ", 
                  #add-point:browser_fill段sql(bcbb_t1) name="browser_fill.join.bcbb_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.bcbacrtid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.bcbacrtdp AND t2.ooefl002='"||g_dlang||"' ",
 
               " LEFT JOIN bcbal_t ON bcbalent = "||g_enterprise||" AND bcba001 = bcbal001 AND bcbal002 = '",g_dlang,"' ",
                  " WHERE t0.bcbaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("bcba_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.bcbastus,t0.bcba001,t0.bcba002,t0.bcbacrtid,t0.bcbacrtdp,t0.bcbacrtdt, 
          t1.ooag011 ,t2.ooefl003 ",
                  " FROM bcba_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.bcbacrtid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.bcbacrtdp AND t2.ooefl002='"||g_dlang||"' ",
 
               " LEFT JOIN bcbal_t ON bcbalent = "||g_enterprise||" AND bcba001 = bcbal001 AND bcbal002 = '",g_dlang,"' ",
                  " WHERE t0.bcbaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("bcba_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY bcba001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"bcba_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_bcba001,g_browser[g_cnt].b_bcba002, 
          g_browser[g_cnt].b_bcbacrtid,g_browser[g_cnt].b_bcbacrtdp,g_browser[g_cnt].b_bcbacrtdt,g_browser[g_cnt].b_bcbacrtid_desc, 
          g_browser[g_cnt].b_bcbacrtdp_desc
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
         CALL abci300_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_bcba001) THEN
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
 
{<section id="abci300.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abci300_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bcba_m.bcba001 = g_browser[g_current_idx].b_bcba001   
 
   EXECUTE abci300_master_referesh USING g_bcba_m.bcba001 INTO g_bcba_m.bcba001,g_bcba_m.bcba002,g_bcba_m.bcba003, 
       g_bcba_m.bcba004,g_bcba_m.bcbastus,g_bcba_m.bcbaownid,g_bcba_m.bcbaowndp,g_bcba_m.bcbacrtid,g_bcba_m.bcbacrtdp, 
       g_bcba_m.bcbacrtdt,g_bcba_m.bcbamodid,g_bcba_m.bcbamoddt,g_bcba_m.bcbacnfid,g_bcba_m.bcbacnfdt, 
       g_bcba_m.bcbaownid_desc,g_bcba_m.bcbaowndp_desc,g_bcba_m.bcbacrtid_desc,g_bcba_m.bcbacrtdp_desc, 
       g_bcba_m.bcbamodid_desc,g_bcba_m.bcbacnfid_desc
   
   CALL abci300_bcba_t_mask()
   CALL abci300_show()
      
END FUNCTION
 
{</section>}
 
{<section id="abci300.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abci300_ui_detailshow()
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
 
{<section id="abci300.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abci300_ui_browser_refresh()
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
      IF g_browser[l_i].b_bcba001 = g_bcba_m.bcba001 
 
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
 
{<section id="abci300.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abci300_construct()
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
   INITIALIZE g_bcba_m.* TO NULL
   CALL g_bcbb_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON bcba001,bcbal003,bcba002,bcba003,bcba004,bcbastus,bcbaownid,bcbaowndp, 
          bcbacrtid,bcbacrtdp,bcbacrtdt,bcbamodid,bcbamoddt,bcbacnfid,bcbacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bcbacrtdt>>----
         AFTER FIELD bcbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bcbamoddt>>----
         AFTER FIELD bcbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bcbacnfdt>>----
         AFTER FIELD bcbacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bcbapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcba001
            #add-point:BEFORE FIELD bcba001 name="construct.b.bcba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcba001
            
            #add-point:AFTER FIELD bcba001 name="construct.a.bcba001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcba001
            #add-point:ON ACTION controlp INFIELD bcba001 name="construct.c.bcba001"

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bcba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcba001  #顯示到畫面上

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbal003
            #add-point:BEFORE FIELD bcbal003 name="construct.b.bcbal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbal003
            
            #add-point:AFTER FIELD bcbal003 name="construct.a.bcbal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcbal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbal003
            #add-point:ON ACTION controlp INFIELD bcbal003 name="construct.c.bcbal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcba002
            #add-point:BEFORE FIELD bcba002 name="construct.b.bcba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcba002
            
            #add-point:AFTER FIELD bcba002 name="construct.a.bcba002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcba002
            #add-point:ON ACTION controlp INFIELD bcba002 name="construct.c.bcba002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcba003
            #add-point:BEFORE FIELD bcba003 name="construct.b.bcba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcba003
            
            #add-point:AFTER FIELD bcba003 name="construct.a.bcba003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcba003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcba003
            #add-point:ON ACTION controlp INFIELD bcba003 name="construct.c.bcba003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcba004
            #add-point:BEFORE FIELD bcba004 name="construct.b.bcba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcba004
            
            #add-point:AFTER FIELD bcba004 name="construct.a.bcba004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcba004
            #add-point:ON ACTION controlp INFIELD bcba004 name="construct.c.bcba004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbastus
            #add-point:BEFORE FIELD bcbastus name="construct.b.bcbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbastus
            
            #add-point:AFTER FIELD bcbastus name="construct.a.bcbastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbastus
            #add-point:ON ACTION controlp INFIELD bcbastus name="construct.c.bcbastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bcbaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbaownid
            #add-point:ON ACTION controlp INFIELD bcbaownid name="construct.c.bcbaownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcbaownid  #顯示到畫面上
            NEXT FIELD bcbaownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbaownid
            #add-point:BEFORE FIELD bcbaownid name="construct.b.bcbaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbaownid
            
            #add-point:AFTER FIELD bcbaownid name="construct.a.bcbaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcbaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbaowndp
            #add-point:ON ACTION controlp INFIELD bcbaowndp name="construct.c.bcbaowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcbaowndp  #顯示到畫面上
            NEXT FIELD bcbaowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbaowndp
            #add-point:BEFORE FIELD bcbaowndp name="construct.b.bcbaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbaowndp
            
            #add-point:AFTER FIELD bcbaowndp name="construct.a.bcbaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcbacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbacrtid
            #add-point:ON ACTION controlp INFIELD bcbacrtid name="construct.c.bcbacrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcbacrtid  #顯示到畫面上
            NEXT FIELD bcbacrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbacrtid
            #add-point:BEFORE FIELD bcbacrtid name="construct.b.bcbacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbacrtid
            
            #add-point:AFTER FIELD bcbacrtid name="construct.a.bcbacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcbacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbacrtdp
            #add-point:ON ACTION controlp INFIELD bcbacrtdp name="construct.c.bcbacrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcbacrtdp  #顯示到畫面上
            NEXT FIELD bcbacrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbacrtdp
            #add-point:BEFORE FIELD bcbacrtdp name="construct.b.bcbacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbacrtdp
            
            #add-point:AFTER FIELD bcbacrtdp name="construct.a.bcbacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbacrtdt
            #add-point:BEFORE FIELD bcbacrtdt name="construct.b.bcbacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bcbamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbamodid
            #add-point:ON ACTION controlp INFIELD bcbamodid name="construct.c.bcbamodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcbamodid  #顯示到畫面上
            NEXT FIELD bcbamodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbamodid
            #add-point:BEFORE FIELD bcbamodid name="construct.b.bcbamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbamodid
            
            #add-point:AFTER FIELD bcbamodid name="construct.a.bcbamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbamoddt
            #add-point:BEFORE FIELD bcbamoddt name="construct.b.bcbamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bcbacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbacnfid
            #add-point:ON ACTION controlp INFIELD bcbacnfid name="construct.c.bcbacnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcbacnfid  #顯示到畫面上
            NEXT FIELD bcbacnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbacnfid
            #add-point:BEFORE FIELD bcbacnfid name="construct.b.bcbacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbacnfid
            
            #add-point:AFTER FIELD bcbacnfid name="construct.a.bcbacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbacnfdt
            #add-point:BEFORE FIELD bcbacnfdt name="construct.b.bcbacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON bcbbseq,bcbb002,bcbb003,bcbb004,bcbb005
           FROM s_detail1[1].bcbbseq,s_detail1[1].bcbb002,s_detail1[1].bcbb003,s_detail1[1].bcbb004, 
               s_detail1[1].bcbb005
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbbseq
            #add-point:BEFORE FIELD bcbbseq name="construct.b.page1.bcbbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbbseq
            
            #add-point:AFTER FIELD bcbbseq name="construct.a.page1.bcbbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbbseq
            #add-point:ON ACTION controlp INFIELD bcbbseq name="construct.c.page1.bcbbseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbb002
            #add-point:BEFORE FIELD bcbb002 name="construct.b.page1.bcbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbb002
            
            #add-point:AFTER FIELD bcbb002 name="construct.a.page1.bcbb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbb002
            #add-point:ON ACTION controlp INFIELD bcbb002 name="construct.c.page1.bcbb002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbb003
            #add-point:BEFORE FIELD bcbb003 name="construct.b.page1.bcbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbb003
            
            #add-point:AFTER FIELD bcbb003 name="construct.a.page1.bcbb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcbb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbb003
            #add-point:ON ACTION controlp INFIELD bcbb003 name="construct.c.page1.bcbb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbb004
            #add-point:BEFORE FIELD bcbb004 name="construct.b.page1.bcbb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbb004
            
            #add-point:AFTER FIELD bcbb004 name="construct.a.page1.bcbb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcbb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbb004
            #add-point:ON ACTION controlp INFIELD bcbb004 name="construct.c.page1.bcbb004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbb005
            #add-point:BEFORE FIELD bcbb005 name="construct.b.page1.bcbb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbb005
            
            #add-point:AFTER FIELD bcbb005 name="construct.a.page1.bcbb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcbb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbb005
            #add-point:ON ACTION controlp INFIELD bcbb005 name="construct.c.page1.bcbb005"
            
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
                  WHEN la_wc[li_idx].tableid = "bcba_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "bcbb_t" 
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
 
{<section id="abci300.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abci300_filter()
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
      CONSTRUCT g_wc_filter ON bcba001,bcba002,bcbacrtid,bcbacrtdp,bcbacrtdt
                          FROM s_browse[1].b_bcba001,s_browse[1].b_bcba002,s_browse[1].b_bcbacrtid,s_browse[1].b_bcbacrtdp, 
                              s_browse[1].b_bcbacrtdt
 
         BEFORE CONSTRUCT
               DISPLAY abci300_filter_parser('bcba001') TO s_browse[1].b_bcba001
            DISPLAY abci300_filter_parser('bcba002') TO s_browse[1].b_bcba002
            DISPLAY abci300_filter_parser('bcbacrtid') TO s_browse[1].b_bcbacrtid
            DISPLAY abci300_filter_parser('bcbacrtdp') TO s_browse[1].b_bcbacrtdp
            DISPLAY abci300_filter_parser('bcbacrtdt') TO s_browse[1].b_bcbacrtdt
      
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
 
      CALL abci300_filter_show('bcba001')
   CALL abci300_filter_show('bcba002')
   CALL abci300_filter_show('bcbacrtid')
   CALL abci300_filter_show('bcbacrtdp')
   CALL abci300_filter_show('bcbacrtdt')
 
END FUNCTION
 
{</section>}
 
{<section id="abci300.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abci300_filter_parser(ps_field)
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
 
{<section id="abci300.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abci300_filter_show(ps_field)
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
   LET ls_condition = abci300_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abci300.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abci300_query()
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
   CALL g_bcbb_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL abci300_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abci300_browser_fill("")
      CALL abci300_fetch("")
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
      CALL abci300_filter_show('bcba001')
   CALL abci300_filter_show('bcba002')
   CALL abci300_filter_show('bcbacrtid')
   CALL abci300_filter_show('bcbacrtdp')
   CALL abci300_filter_show('bcbacrtdt')
   CALL abci300_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL abci300_fetch("F") 
      #顯示單身筆數
      CALL abci300_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abci300.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abci300_fetch(p_flag)
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
   
   LET g_bcba_m.bcba001 = g_browser[g_current_idx].b_bcba001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abci300_master_referesh USING g_bcba_m.bcba001 INTO g_bcba_m.bcba001,g_bcba_m.bcba002,g_bcba_m.bcba003, 
       g_bcba_m.bcba004,g_bcba_m.bcbastus,g_bcba_m.bcbaownid,g_bcba_m.bcbaowndp,g_bcba_m.bcbacrtid,g_bcba_m.bcbacrtdp, 
       g_bcba_m.bcbacrtdt,g_bcba_m.bcbamodid,g_bcba_m.bcbamoddt,g_bcba_m.bcbacnfid,g_bcba_m.bcbacnfdt, 
       g_bcba_m.bcbaownid_desc,g_bcba_m.bcbaowndp_desc,g_bcba_m.bcbacrtid_desc,g_bcba_m.bcbacrtdp_desc, 
       g_bcba_m.bcbamodid_desc,g_bcba_m.bcbacnfid_desc
   
   #遮罩相關處理
   LET g_bcba_m_mask_o.* =  g_bcba_m.*
   CALL abci300_bcba_t_mask()
   LET g_bcba_m_mask_n.* =  g_bcba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abci300_set_act_visible()   
   CALL abci300_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_bcba_m_t.* = g_bcba_m.*
   LET g_bcba_m_o.* = g_bcba_m.*
   
   LET g_data_owner = g_bcba_m.bcbaownid      
   LET g_data_dept  = g_bcba_m.bcbaowndp
   
   #重新顯示   
   CALL abci300_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abci300.insert" >}
#+ 資料新增
PRIVATE FUNCTION abci300_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_bcbb_d.clear()   
 
 
   INITIALIZE g_bcba_m.* TO NULL             #DEFAULT 設定
   
   LET g_bcba001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bcba_m.bcbaownid = g_user
      LET g_bcba_m.bcbaowndp = g_dept
      LET g_bcba_m.bcbacrtid = g_user
      LET g_bcba_m.bcbacrtdp = g_dept 
      LET g_bcba_m.bcbacrtdt = cl_get_current()
      LET g_bcba_m.bcbamodid = g_user
      LET g_bcba_m.bcbamoddt = cl_get_current()
      LET g_bcba_m.bcbastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_bcba_m.bcba002 = "1"
      LET g_bcba_m.bcba003 = "1"
      LET g_bcba_m.bcba004 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_bcba_m.separate = g_separate
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_bcba_m_t.* = g_bcba_m.*
      LET g_bcba_m_o.* = g_bcba_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bcba_m.bcbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL abci300_input("a")
      
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
         INITIALIZE g_bcba_m.* TO NULL
         INITIALIZE g_bcbb_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL abci300_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_bcbb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abci300_set_act_visible()   
   CALL abci300_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bcba001_t = g_bcba_m.bcba001
 
   
   #組合新增資料的條件
   LET g_add_browse = " bcbaent = " ||g_enterprise|| " AND",
                      " bcba001 = '", g_bcba_m.bcba001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abci300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE abci300_cl
   
   CALL abci300_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abci300_master_referesh USING g_bcba_m.bcba001 INTO g_bcba_m.bcba001,g_bcba_m.bcba002,g_bcba_m.bcba003, 
       g_bcba_m.bcba004,g_bcba_m.bcbastus,g_bcba_m.bcbaownid,g_bcba_m.bcbaowndp,g_bcba_m.bcbacrtid,g_bcba_m.bcbacrtdp, 
       g_bcba_m.bcbacrtdt,g_bcba_m.bcbamodid,g_bcba_m.bcbamoddt,g_bcba_m.bcbacnfid,g_bcba_m.bcbacnfdt, 
       g_bcba_m.bcbaownid_desc,g_bcba_m.bcbaowndp_desc,g_bcba_m.bcbacrtid_desc,g_bcba_m.bcbacrtdp_desc, 
       g_bcba_m.bcbamodid_desc,g_bcba_m.bcbacnfid_desc
   
   
   #遮罩相關處理
   LET g_bcba_m_mask_o.* =  g_bcba_m.*
   CALL abci300_bcba_t_mask()
   LET g_bcba_m_mask_n.* =  g_bcba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bcba_m.bcba001,g_bcba_m.bcbal003,g_bcba_m.bcba002,g_bcba_m.bcba003,g_bcba_m.separate, 
       g_bcba_m.bcba004,g_bcba_m.bcbastus,g_bcba_m.bcbaownid,g_bcba_m.bcbaownid_desc,g_bcba_m.bcbaowndp, 
       g_bcba_m.bcbaowndp_desc,g_bcba_m.bcbacrtid,g_bcba_m.bcbacrtid_desc,g_bcba_m.bcbacrtdp,g_bcba_m.bcbacrtdp_desc, 
       g_bcba_m.bcbacrtdt,g_bcba_m.bcbamodid,g_bcba_m.bcbamodid_desc,g_bcba_m.bcbamoddt,g_bcba_m.bcbacnfid, 
       g_bcba_m.bcbacnfid_desc,g_bcba_m.bcbacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_bcba_m.bcbaownid      
   LET g_data_dept  = g_bcba_m.bcbaowndp
   
   #功能已完成,通報訊息中心
   CALL abci300_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abci300.modify" >}
#+ 資料修改
PRIVATE FUNCTION abci300_modify()
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
   LET g_bcba_m_t.* = g_bcba_m.*
   LET g_bcba_m_o.* = g_bcba_m.*
   
   IF g_bcba_m.bcba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_bcba001_t = g_bcba_m.bcba001
 
   CALL s_transaction_begin()
   
   OPEN abci300_cl USING g_enterprise,g_bcba_m.bcba001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abci300_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abci300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abci300_master_referesh USING g_bcba_m.bcba001 INTO g_bcba_m.bcba001,g_bcba_m.bcba002,g_bcba_m.bcba003, 
       g_bcba_m.bcba004,g_bcba_m.bcbastus,g_bcba_m.bcbaownid,g_bcba_m.bcbaowndp,g_bcba_m.bcbacrtid,g_bcba_m.bcbacrtdp, 
       g_bcba_m.bcbacrtdt,g_bcba_m.bcbamodid,g_bcba_m.bcbamoddt,g_bcba_m.bcbacnfid,g_bcba_m.bcbacnfdt, 
       g_bcba_m.bcbaownid_desc,g_bcba_m.bcbaowndp_desc,g_bcba_m.bcbacrtid_desc,g_bcba_m.bcbacrtdp_desc, 
       g_bcba_m.bcbamodid_desc,g_bcba_m.bcbacnfid_desc
   
   #檢查是否允許此動作
   IF NOT abci300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bcba_m_mask_o.* =  g_bcba_m.*
   CALL abci300_bcba_t_mask()
   LET g_bcba_m_mask_n.* =  g_bcba_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL abci300_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_bcba001_t = g_bcba_m.bcba001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_bcba_m.bcbamodid = g_user 
LET g_bcba_m.bcbamoddt = cl_get_current()
LET g_bcba_m.bcbamodid_desc = cl_get_username(g_bcba_m.bcbamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL abci300_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE bcba_t SET (bcbamodid,bcbamoddt) = (g_bcba_m.bcbamodid,g_bcba_m.bcbamoddt)
          WHERE bcbaent = g_enterprise AND bcba001 = g_bcba001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_bcba_m.* = g_bcba_m_t.*
            CALL abci300_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_bcba_m.bcba001 != g_bcba_m_t.bcba001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE bcbb_t SET bcbb001 = g_bcba_m.bcba001
 
          WHERE bcbbent = g_enterprise AND bcbb001 = g_bcba_m_t.bcba001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "bcbb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bcbb_t:",SQLERRMESSAGE 
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
   CALL abci300_set_act_visible()   
   CALL abci300_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bcbaent = " ||g_enterprise|| " AND",
                      " bcba001 = '", g_bcba_m.bcba001, "' "
 
   #填到對應位置
   CALL abci300_browser_fill("")
 
   CLOSE abci300_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abci300_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="abci300.input" >}
#+ 資料輸入
PRIVATE FUNCTION abci300_input(p_cmd)
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
   DISPLAY BY NAME g_bcba_m.bcba001,g_bcba_m.bcbal003,g_bcba_m.bcba002,g_bcba_m.bcba003,g_bcba_m.separate, 
       g_bcba_m.bcba004,g_bcba_m.bcbastus,g_bcba_m.bcbaownid,g_bcba_m.bcbaownid_desc,g_bcba_m.bcbaowndp, 
       g_bcba_m.bcbaowndp_desc,g_bcba_m.bcbacrtid,g_bcba_m.bcbacrtid_desc,g_bcba_m.bcbacrtdp,g_bcba_m.bcbacrtdp_desc, 
       g_bcba_m.bcbacrtdt,g_bcba_m.bcbamodid,g_bcba_m.bcbamodid_desc,g_bcba_m.bcbamoddt,g_bcba_m.bcbacnfid, 
       g_bcba_m.bcbacnfid_desc,g_bcba_m.bcbacnfdt
   
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
   LET g_forupd_sql = "SELECT bcbbseq,bcbb002,bcbb003,bcbb004,bcbb005 FROM bcbb_t WHERE bcbbent=? AND  
       bcbb001=? AND bcbbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abci300_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abci300_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abci300_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_bcba_m.bcba001,g_bcba_m.bcbal003,g_bcba_m.bcba002,g_bcba_m.bcba003,g_bcba_m.bcba004, 
       g_bcba_m.bcbastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abci300.input.head" >}
      #單頭段
      INPUT BY NAME g_bcba_m.bcba001,g_bcba_m.bcbal003,g_bcba_m.bcba002,g_bcba_m.bcba003,g_bcba_m.bcba004, 
          g_bcba_m.bcbastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_bcba_m.bcba001)  THEN
                  CALL n_bcbal(g_bcba_m.bcba001)
                  
                  CALL abci300_bcba001_desc()
               END IF

               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN abci300_cl USING g_enterprise,g_bcba_m.bcba001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abci300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abci300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.bcbal001 = g_bcba_m.bcba001
LET g_master_multi_table_t.bcbal003 = g_bcba_m.bcbal003
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.bcbal001 = ''
LET g_master_multi_table_t.bcbal003 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL abci300_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL abci300_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcba001
            #add-point:BEFORE FIELD bcba001 name="input.b.bcba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcba001
            
            #add-point:AFTER FIELD bcba001 name="input.a.bcba001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bcba_m.bcba001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bcba_m.bcba001 != g_bcba001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bcba_t WHERE "||"bcbaent = " ||g_enterprise|| " AND "||"bcba001 = '"||g_bcba_m.bcba001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcba001
            #add-point:ON CHANGE bcba001 name="input.g.bcba001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbal003
            #add-point:BEFORE FIELD bcbal003 name="input.b.bcbal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbal003
            
            #add-point:AFTER FIELD bcbal003 name="input.a.bcbal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcbal003
            #add-point:ON CHANGE bcbal003 name="input.g.bcbal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcba002
            #add-point:BEFORE FIELD bcba002 name="input.b.bcba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcba002
            
            #add-point:AFTER FIELD bcba002 name="input.a.bcba002"
            
            IF NOT cl_null(g_bcba_m.bcba002) THEN
               IF g_bcba_m.bcba002 <> g_bcba_m_o.bcba002 OR cl_null(g_bcba_m_o.bcba002) THEN
                  IF NOT abci300_bcba002_chk() THEN
                     LET g_bcba_m.bcba002 = g_bcba_m_o.bcba002
                  END IF
                  
                  IF g_bcba_m.bcba002 = '3' THEN
                     LET g_bcba_m.bcba003 = 1
                     LET g_bcba_m.bcba004 = '1'
                  END IF
                  
               END IF
            END IF
            
            LET g_bcba_m_o.bcba002 = g_bcba_m.bcba002
            
            CALL abci300_set_entry(p_cmd)
            CALL abci300_set_no_entry(p_cmd)
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcba002
            #add-point:ON CHANGE bcba002 name="input.g.bcba002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcba003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bcba_m.bcba003,"0","0","","","azz-00079",1) THEN
               NEXT FIELD bcba003
            END IF 
 
 
 
            #add-point:AFTER FIELD bcba003 name="input.a.bcba003"
            IF NOT cl_null(g_bcba_m.bcba003) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcba003
            #add-point:BEFORE FIELD bcba003 name="input.b.bcba003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcba003
            #add-point:ON CHANGE bcba003 name="input.g.bcba003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcba004
            #add-point:BEFORE FIELD bcba004 name="input.b.bcba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcba004
            
            #add-point:AFTER FIELD bcba004 name="input.a.bcba004"

            IF g_bcba_m.bcba004 = '1' THEN
               UPDATE bcbb_t
                  SET bcbb005 = 'N'
                WHERE bcbbent = g_enterprise
                  AND bcbb001 = g_bcba_m.bcba001
            END IF
            
            CALL abci300_b_fill()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcba004
            #add-point:ON CHANGE bcba004 name="input.g.bcba004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbastus
            #add-point:BEFORE FIELD bcbastus name="input.b.bcbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbastus
            
            #add-point:AFTER FIELD bcbastus name="input.a.bcbastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcbastus
            #add-point:ON CHANGE bcbastus name="input.g.bcbastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bcba001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcba001
            #add-point:ON ACTION controlp INFIELD bcba001 name="input.c.bcba001"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcbal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbal003
            #add-point:ON ACTION controlp INFIELD bcbal003 name="input.c.bcbal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcba002
            #add-point:ON ACTION controlp INFIELD bcba002 name="input.c.bcba002"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcba003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcba003
            #add-point:ON ACTION controlp INFIELD bcba003 name="input.c.bcba003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcba004
            #add-point:ON ACTION controlp INFIELD bcba004 name="input.c.bcba004"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbastus
            #add-point:ON ACTION controlp INFIELD bcbastus name="input.c.bcbastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_bcba_m.bcba001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO bcba_t (bcbaent,bcba001,bcba002,bcba003,bcba004,bcbastus,bcbaownid,bcbaowndp, 
                   bcbacrtid,bcbacrtdp,bcbacrtdt,bcbamodid,bcbamoddt,bcbacnfid,bcbacnfdt)
               VALUES (g_enterprise,g_bcba_m.bcba001,g_bcba_m.bcba002,g_bcba_m.bcba003,g_bcba_m.bcba004, 
                   g_bcba_m.bcbastus,g_bcba_m.bcbaownid,g_bcba_m.bcbaowndp,g_bcba_m.bcbacrtid,g_bcba_m.bcbacrtdp, 
                   g_bcba_m.bcbacrtdt,g_bcba_m.bcbamodid,g_bcba_m.bcbamoddt,g_bcba_m.bcbacnfid,g_bcba_m.bcbacnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_bcba_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_bcba_m.bcba001 = g_master_multi_table_t.bcbal001 AND
         g_bcba_m.bcbal003 = g_master_multi_table_t.bcbal003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'bcbalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_bcba_m.bcba001
            LET l_field_keys[02] = 'bcbal001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.bcbal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'bcbal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_bcba_m.bcbal003
            LET l_fields[01] = 'bcbal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'bcbal_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL abci300_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL abci300_b_fill()
                  CALL abci300_b_fill2('0')
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
               CALL abci300_bcba_t_mask_restore('restore_mask_o')
               
               UPDATE bcba_t SET (bcba001,bcba002,bcba003,bcba004,bcbastus,bcbaownid,bcbaowndp,bcbacrtid, 
                   bcbacrtdp,bcbacrtdt,bcbamodid,bcbamoddt,bcbacnfid,bcbacnfdt) = (g_bcba_m.bcba001, 
                   g_bcba_m.bcba002,g_bcba_m.bcba003,g_bcba_m.bcba004,g_bcba_m.bcbastus,g_bcba_m.bcbaownid, 
                   g_bcba_m.bcbaowndp,g_bcba_m.bcbacrtid,g_bcba_m.bcbacrtdp,g_bcba_m.bcbacrtdt,g_bcba_m.bcbamodid, 
                   g_bcba_m.bcbamoddt,g_bcba_m.bcbacnfid,g_bcba_m.bcbacnfdt)
                WHERE bcbaent = g_enterprise AND bcba001 = g_bcba001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "bcba_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_bcba_m.bcba001 = g_master_multi_table_t.bcbal001 AND
         g_bcba_m.bcbal003 = g_master_multi_table_t.bcbal003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'bcbalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_bcba_m.bcba001
            LET l_field_keys[02] = 'bcbal001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.bcbal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'bcbal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_bcba_m.bcbal003
            LET l_fields[01] = 'bcbal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'bcbal_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL abci300_bcba_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_bcba_m_t)
               LET g_log2 = util.JSON.stringify(g_bcba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_bcba001_t = g_bcba_m.bcba001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="abci300.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_bcbb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            IF g_bcba_m.bcba002 = '3' THEN
               RETURN
            END IF
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bcbb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abci300_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_bcbb_d.getLength()
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
            OPEN abci300_cl USING g_enterprise,g_bcba_m.bcba001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abci300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abci300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_bcbb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bcbb_d[l_ac].bcbbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bcbb_d_t.* = g_bcbb_d[l_ac].*  #BACKUP
               LET g_bcbb_d_o.* = g_bcbb_d[l_ac].*  #BACKUP
               CALL abci300_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL abci300_set_no_entry_b(l_cmd)
               IF NOT abci300_lock_b("bcbb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abci300_bcl INTO g_bcbb_d[l_ac].bcbbseq,g_bcbb_d[l_ac].bcbb002,g_bcbb_d[l_ac].bcbb003, 
                      g_bcbb_d[l_ac].bcbb004,g_bcbb_d[l_ac].bcbb005
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bcbb_d_t.bcbbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bcbb_d_mask_o[l_ac].* =  g_bcbb_d[l_ac].*
                  CALL abci300_bcbb_t_mask()
                  LET g_bcbb_d_mask_n[l_ac].* =  g_bcbb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL abci300_show()
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
            INITIALIZE g_bcbb_d[l_ac].* TO NULL 
            INITIALIZE g_bcbb_d_t.* TO NULL 
            INITIALIZE g_bcbb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_bcbb_d[l_ac].bcbbseq = "0"
      LET g_bcbb_d[l_ac].bcbb002 = "1"
      LET g_bcbb_d[l_ac].bcbb005 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            LET g_bcbb_d[l_ac].bcbbseq = ''
            SELECT MAX(bcbbseq) + 1 INTO g_bcbb_d[l_ac].bcbbseq
              FROM bcbb_t
             WHERE bcbbent = g_enterprise
               AND bcbb001 = g_bcba_m.bcba001
            
            IF cl_null(g_bcbb_d[l_ac].bcbbseq) THEN
               LET g_bcbb_d[l_ac].bcbbseq = '1'
            END IF

            #end add-point
            LET g_bcbb_d_t.* = g_bcbb_d[l_ac].*     #新輸入資料
            LET g_bcbb_d_o.* = g_bcbb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abci300_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL abci300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bcbb_d[li_reproduce_target].* = g_bcbb_d[li_reproduce].*
 
               LET g_bcbb_d[li_reproduce_target].bcbbseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM bcbb_t 
             WHERE bcbbent = g_enterprise AND bcbb001 = g_bcba_m.bcba001
 
               AND bcbbseq = g_bcbb_d[l_ac].bcbbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bcba_m.bcba001
               LET gs_keys[2] = g_bcbb_d[g_detail_idx].bcbbseq
               CALL abci300_insert_b('bcbb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_bcbb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bcbb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abci300_b_fill()
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
               LET gs_keys[01] = g_bcba_m.bcba001
 
               LET gs_keys[gs_keys.getLength()+1] = g_bcbb_d_t.bcbbseq
 
            
               #刪除同層單身
               IF NOT abci300_delete_b('bcbb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abci300_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT abci300_key_delete_b(gs_keys,'bcbb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abci300_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE abci300_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_bcbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bcbb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbbseq
            #add-point:BEFORE FIELD bcbbseq name="input.b.page1.bcbbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbbseq
            
            #add-point:AFTER FIELD bcbbseq name="input.a.page1.bcbbseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bcba_m.bcba001 IS NOT NULL AND g_bcbb_d[g_detail_idx].bcbbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bcba_m.bcba001 != g_bcba001_t OR g_bcbb_d[g_detail_idx].bcbbseq != g_bcbb_d_t.bcbbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bcbb_t WHERE "||"bcbbent = " ||g_enterprise|| " AND "||"bcbb001 = '"||g_bcba_m.bcba001 ||"' AND "|| "bcbbseq = '"||g_bcbb_d[g_detail_idx].bcbbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcbbseq
            #add-point:ON CHANGE bcbbseq name="input.g.page1.bcbbseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbb002
            #add-point:BEFORE FIELD bcbb002 name="input.b.page1.bcbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbb002
            
            #add-point:AFTER FIELD bcbb002 name="input.a.page1.bcbb002"
            
            IF g_bcbb_d[l_ac].bcbb002 <> g_bcbb_d_o.bcbb002 OR cl_null(g_bcbb_d_o.bcbb002) THEN
               LET g_bcbb_d[l_ac].bcbb003 = ''
               LET g_bcbb_d[l_ac].bcbb004 = ''
            END IF
            
            LET g_bcbb_d_o.bcbb002 = g_bcbb_d[l_ac].bcbb002
            
            CALL abci300_set_entry_b(p_cmd)
            CALL abci300_set_no_entry_b(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcbb002
            #add-point:ON CHANGE bcbb002 name="input.g.page1.bcbb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbb003
            #add-point:BEFORE FIELD bcbb003 name="input.b.page1.bcbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbb003
            
            #add-point:AFTER FIELD bcbb003 name="input.a.page1.bcbb003"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcbb003
            #add-point:ON CHANGE bcbb003 name="input.g.page1.bcbb003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbb004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bcbb_d[l_ac].bcbb004,"0","0","","","azz-00079",1) THEN
               NEXT FIELD bcbb004
            END IF 
 
 
 
            #add-point:AFTER FIELD bcbb004 name="input.a.page1.bcbb004"
            IF NOT cl_null(g_bcbb_d[l_ac].bcbb004) THEN 
               IF NOT abci300_bcbb004_chk() THEN
                  NEXT FIELD bcbb004
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbb004
            #add-point:BEFORE FIELD bcbb004 name="input.b.page1.bcbb004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcbb004
            #add-point:ON CHANGE bcbb004 name="input.g.page1.bcbb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcbb005
            #add-point:BEFORE FIELD bcbb005 name="input.b.page1.bcbb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcbb005
            
            #add-point:AFTER FIELD bcbb005 name="input.a.page1.bcbb005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcbb005
            #add-point:ON CHANGE bcbb005 name="input.g.page1.bcbb005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bcbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbbseq
            #add-point:ON ACTION controlp INFIELD bcbbseq name="input.c.page1.bcbbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bcbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbb002
            #add-point:ON ACTION controlp INFIELD bcbb002 name="input.c.page1.bcbb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bcbb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbb003
            #add-point:ON ACTION controlp INFIELD bcbb003 name="input.c.page1.bcbb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bcbb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbb004
            #add-point:ON ACTION controlp INFIELD bcbb004 name="input.c.page1.bcbb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bcbb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcbb005
            #add-point:ON ACTION controlp INFIELD bcbb005 name="input.c.page1.bcbb005"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bcbb_d[l_ac].* = g_bcbb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abci300_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_bcbb_d[l_ac].bcbbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_bcbb_d[l_ac].* = g_bcbb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL abci300_bcbb_t_mask_restore('restore_mask_o')
      
               UPDATE bcbb_t SET (bcbb001,bcbbseq,bcbb002,bcbb003,bcbb004,bcbb005) = (g_bcba_m.bcba001, 
                   g_bcbb_d[l_ac].bcbbseq,g_bcbb_d[l_ac].bcbb002,g_bcbb_d[l_ac].bcbb003,g_bcbb_d[l_ac].bcbb004, 
                   g_bcbb_d[l_ac].bcbb005)
                WHERE bcbbent = g_enterprise AND bcbb001 = g_bcba_m.bcba001 
 
                  AND bcbbseq = g_bcbb_d_t.bcbbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_bcbb_d[l_ac].* = g_bcbb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bcbb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_bcbb_d[l_ac].* = g_bcbb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bcbb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bcba_m.bcba001
               LET gs_keys_bak[1] = g_bcba001_t
               LET gs_keys[2] = g_bcbb_d[g_detail_idx].bcbbseq
               LET gs_keys_bak[2] = g_bcbb_d_t.bcbbseq
               CALL abci300_update_b('bcbb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL abci300_bcbb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_bcbb_d[g_detail_idx].bcbbseq = g_bcbb_d_t.bcbbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_bcba_m.bcba001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bcbb_d_t.bcbbseq
 
                  CALL abci300_key_update_b(gs_keys,'bcbb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_bcba_m),util.JSON.stringify(g_bcbb_d_t)
               LET g_log2 = util.JSON.stringify(g_bcba_m),util.JSON.stringify(g_bcbb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL abci300_unlock_b("bcbb_t","'1'")
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
               LET g_bcbb_d[li_reproduce_target].* = g_bcbb_d[li_reproduce].*
 
               LET g_bcbb_d[li_reproduce_target].bcbbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bcbb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bcbb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="abci300.input.other" >}
      
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
            NEXT FIELD bcba001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bcbbseq
 
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
 
{<section id="abci300.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abci300_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL abci300_b_fill() #單身填充
      CALL abci300_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abci300_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

   CALL abci300_bcba001_desc()

   LET g_bcba_m.separate = g_separate
   #end add-point
   
   #遮罩相關處理
   LET g_bcba_m_mask_o.* =  g_bcba_m.*
   CALL abci300_bcba_t_mask()
   LET g_bcba_m_mask_n.* =  g_bcba_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bcba_m.bcba001,g_bcba_m.bcbal003,g_bcba_m.bcba002,g_bcba_m.bcba003,g_bcba_m.separate, 
       g_bcba_m.bcba004,g_bcba_m.bcbastus,g_bcba_m.bcbaownid,g_bcba_m.bcbaownid_desc,g_bcba_m.bcbaowndp, 
       g_bcba_m.bcbaowndp_desc,g_bcba_m.bcbacrtid,g_bcba_m.bcbacrtid_desc,g_bcba_m.bcbacrtdp,g_bcba_m.bcbacrtdp_desc, 
       g_bcba_m.bcbacrtdt,g_bcba_m.bcbamodid,g_bcba_m.bcbamodid_desc,g_bcba_m.bcbamoddt,g_bcba_m.bcbacnfid, 
       g_bcba_m.bcbacnfid_desc,g_bcba_m.bcbacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bcba_m.bcbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_bcbb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL abci300_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abci300.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION abci300_detail_show()
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
 
{<section id="abci300.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abci300_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE bcba_t.bcba001 
   DEFINE l_oldno     LIKE bcba_t.bcba001 
 
   DEFINE l_master    RECORD LIKE bcba_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bcbb_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_bcba_m.bcba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_bcba001_t = g_bcba_m.bcba001
 
    
   LET g_bcba_m.bcba001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bcba_m.bcbaownid = g_user
      LET g_bcba_m.bcbaowndp = g_dept
      LET g_bcba_m.bcbacrtid = g_user
      LET g_bcba_m.bcbacrtdp = g_dept 
      LET g_bcba_m.bcbacrtdt = cl_get_current()
      LET g_bcba_m.bcbamodid = g_user
      LET g_bcba_m.bcbamoddt = cl_get_current()
      LET g_bcba_m.bcbastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bcba_m.bcbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL abci300_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_bcba_m.* TO NULL
      INITIALIZE g_bcbb_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL abci300_show()
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
   CALL abci300_set_act_visible()   
   CALL abci300_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bcba001_t = g_bcba_m.bcba001
 
   
   #組合新增資料的條件
   LET g_add_browse = " bcbaent = " ||g_enterprise|| " AND",
                      " bcba001 = '", g_bcba_m.bcba001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abci300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL abci300_idx_chk()
   
   LET g_data_owner = g_bcba_m.bcbaownid      
   LET g_data_dept  = g_bcba_m.bcbaowndp
   
   #功能已完成,通報訊息中心
   CALL abci300_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="abci300.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abci300_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bcbb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abci300_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bcbb_t
    WHERE bcbbent = g_enterprise AND bcbb001 = g_bcba001_t
 
    INTO TEMP abci300_detail
 
   #將key修正為調整後   
   UPDATE abci300_detail 
      #更新key欄位
      SET bcbb001 = g_bcba_m.bcba001
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO bcbb_t SELECT * FROM abci300_detail
   
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
   DROP TABLE abci300_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bcba001_t = g_bcba_m.bcba001
 
   
END FUNCTION
 
{</section>}
 
{<section id="abci300.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abci300_delete()
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
   
   IF g_bcba_m.bcba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.bcbal001 = g_bcba_m.bcba001
LET g_master_multi_table_t.bcbal003 = g_bcba_m.bcbal003
 
   
   CALL s_transaction_begin()
 
   OPEN abci300_cl USING g_enterprise,g_bcba_m.bcba001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abci300_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abci300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abci300_master_referesh USING g_bcba_m.bcba001 INTO g_bcba_m.bcba001,g_bcba_m.bcba002,g_bcba_m.bcba003, 
       g_bcba_m.bcba004,g_bcba_m.bcbastus,g_bcba_m.bcbaownid,g_bcba_m.bcbaowndp,g_bcba_m.bcbacrtid,g_bcba_m.bcbacrtdp, 
       g_bcba_m.bcbacrtdt,g_bcba_m.bcbamodid,g_bcba_m.bcbamoddt,g_bcba_m.bcbacnfid,g_bcba_m.bcbacnfdt, 
       g_bcba_m.bcbaownid_desc,g_bcba_m.bcbaowndp_desc,g_bcba_m.bcbacrtid_desc,g_bcba_m.bcbacrtdp_desc, 
       g_bcba_m.bcbamodid_desc,g_bcba_m.bcbacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT abci300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bcba_m_mask_o.* =  g_bcba_m.*
   CALL abci300_bcba_t_mask()
   LET g_bcba_m_mask_n.* =  g_bcba_m.*
   
   CALL abci300_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abci300_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_bcba001_t = g_bcba_m.bcba001
 
 
      DELETE FROM bcba_t
       WHERE bcbaent = g_enterprise AND bcba001 = g_bcba_m.bcba001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_bcba_m.bcba001,":",SQLERRMESSAGE  
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
      
      DELETE FROM bcbb_t
       WHERE bcbbent = g_enterprise AND bcbb001 = g_bcba_m.bcba001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bcbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_bcba_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE abci300_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_bcbb_d.clear() 
 
     
      CALL abci300_ui_browser_refresh()  
      #CALL abci300_ui_headershow()  
      #CALL abci300_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'bcbalent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.bcbal001
   LET l_field_keys[02] = 'bcbal001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'bcbal_t')
 
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL abci300_browser_fill("")
         CALL abci300_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE abci300_cl
 
   #功能已完成,通報訊息中心
   CALL abci300_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abci300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abci300_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_bcbb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF abci300_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT bcbbseq,bcbb002,bcbb003,bcbb004,bcbb005  FROM bcbb_t",   
                     " INNER JOIN bcba_t ON bcbaent = " ||g_enterprise|| " AND bcba001 = bcbb001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE bcbbent=? AND bcbb001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY bcbb_t.bcbbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abci300_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abci300_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bcba_m.bcba001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bcba_m.bcba001 INTO g_bcbb_d[l_ac].bcbbseq,g_bcbb_d[l_ac].bcbb002, 
          g_bcbb_d[l_ac].bcbb003,g_bcbb_d[l_ac].bcbb004,g_bcbb_d[l_ac].bcbb005   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
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
   
   CALL g_bcbb_d.deleteElement(g_bcbb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE abci300_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_bcbb_d.getLength()
      LET g_bcbb_d_mask_o[l_ac].* =  g_bcbb_d[l_ac].*
      CALL abci300_bcbb_t_mask()
      LET g_bcbb_d_mask_n[l_ac].* =  g_bcbb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="abci300.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abci300_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM bcbb_t
       WHERE bcbbent = g_enterprise AND
         bcbb001 = ps_keys_bak[1] AND bcbbseq = ps_keys_bak[2]
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
         CALL g_bcbb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abci300.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abci300_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO bcbb_t
                  (bcbbent,
                   bcbb001,
                   bcbbseq
                   ,bcbb002,bcbb003,bcbb004,bcbb005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_bcbb_d[g_detail_idx].bcbb002,g_bcbb_d[g_detail_idx].bcbb003,g_bcbb_d[g_detail_idx].bcbb004, 
                       g_bcbb_d[g_detail_idx].bcbb005)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bcbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_bcbb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="abci300.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abci300_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bcbb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL abci300_bcbb_t_mask_restore('restore_mask_o')
               
      UPDATE bcbb_t 
         SET (bcbb001,
              bcbbseq
              ,bcbb002,bcbb003,bcbb004,bcbb005) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_bcbb_d[g_detail_idx].bcbb002,g_bcbb_d[g_detail_idx].bcbb003,g_bcbb_d[g_detail_idx].bcbb004, 
                  g_bcbb_d[g_detail_idx].bcbb005) 
         WHERE bcbbent = g_enterprise AND bcbb001 = ps_keys_bak[1] AND bcbbseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bcbb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bcbb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL abci300_bcbb_t_mask_restore('restore_mask_n')
               
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
 
{<section id="abci300.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION abci300_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="abci300.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abci300_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="abci300.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abci300_lock_b(ps_table,ps_page)
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
   #CALL abci300_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "bcbb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN abci300_bcl USING g_enterprise,
                                       g_bcba_m.bcba001,g_bcbb_d[g_detail_idx].bcbbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abci300_bcl:",SQLERRMESSAGE 
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
 
{<section id="abci300.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abci300_unlock_b(ps_table,ps_page)
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
      CLOSE abci300_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="abci300.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abci300_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bcba001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   CALL cl_set_comp_entry("bcba003,bcba004",TRUE)
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abci300.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abci300_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bcba001",FALSE)
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

   IF g_bcba_m.bcba002 = '3' THEN
      CALL cl_set_comp_entry("bcba003,bcba004",FALSE)
   END IF

   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abci300.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abci300_set_entry_b(p_cmd)
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
   
   CALL cl_set_comp_entry("bcbb003,bcbb004,bcbb005",TRUE)
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="abci300.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abci300_set_no_entry_b(p_cmd)
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
   IF g_bcbb_d[l_ac].bcbb002 <> '2' THEN
      CALL cl_set_comp_entry("bcbb003",FALSE)
   END IF
   
   IF g_bcbb_d[l_ac].bcbb002 = '1'  OR
      g_bcbb_d[l_ac].bcbb002 = '2'  OR
      g_bcbb_d[l_ac].bcbb002 = '11' OR
      g_bcbb_d[l_ac].bcbb002 = '13' OR
      g_bcbb_d[l_ac].bcbb002 = '14' OR
      g_bcbb_d[l_ac].bcbb002 = '16' THEN
      CALL cl_set_comp_entry("bcbb004",FALSE)
   END IF
   
   IF g_bcba_m.bcba004 = '1' THEN
      CALL cl_set_comp_entry("bcbb005",FALSE)
   END IF
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="abci300.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abci300_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abci300.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abci300_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:2)
   IF g_bcba_m.bcbastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF



   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abci300.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abci300_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abci300.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abci300_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abci300.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abci300_default_search()
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
      LET ls_wc = ls_wc, " bcba001 = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "bcba_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "bcbb_t" 
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
 
{<section id="abci300.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION abci300_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_bcba_m.bcba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN abci300_cl USING g_enterprise,g_bcba_m.bcba001
   IF STATUS THEN
      CLOSE abci300_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abci300_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE abci300_master_referesh USING g_bcba_m.bcba001 INTO g_bcba_m.bcba001,g_bcba_m.bcba002,g_bcba_m.bcba003, 
       g_bcba_m.bcba004,g_bcba_m.bcbastus,g_bcba_m.bcbaownid,g_bcba_m.bcbaowndp,g_bcba_m.bcbacrtid,g_bcba_m.bcbacrtdp, 
       g_bcba_m.bcbacrtdt,g_bcba_m.bcbamodid,g_bcba_m.bcbamoddt,g_bcba_m.bcbacnfid,g_bcba_m.bcbacnfdt, 
       g_bcba_m.bcbaownid_desc,g_bcba_m.bcbaowndp_desc,g_bcba_m.bcbacrtid_desc,g_bcba_m.bcbacrtdp_desc, 
       g_bcba_m.bcbamodid_desc,g_bcba_m.bcbacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT abci300_action_chk() THEN
      CLOSE abci300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bcba_m.bcba001,g_bcba_m.bcbal003,g_bcba_m.bcba002,g_bcba_m.bcba003,g_bcba_m.separate, 
       g_bcba_m.bcba004,g_bcba_m.bcbastus,g_bcba_m.bcbaownid,g_bcba_m.bcbaownid_desc,g_bcba_m.bcbaowndp, 
       g_bcba_m.bcbaowndp_desc,g_bcba_m.bcbacrtid,g_bcba_m.bcbacrtid_desc,g_bcba_m.bcbacrtdp,g_bcba_m.bcbacrtdp_desc, 
       g_bcba_m.bcbacrtdt,g_bcba_m.bcbamodid,g_bcba_m.bcbamodid_desc,g_bcba_m.bcbamoddt,g_bcba_m.bcbacnfid, 
       g_bcba_m.bcbacnfid_desc,g_bcba_m.bcbacnfdt
 
   CASE g_bcba_m.bcbastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_bcba_m.bcbastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"

         CASE g_bcba_m.bcbastus
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
               HIDE OPTION "invalid"
            WHEN "X"
               HIDE OPTION "invalid"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "confirmed"
               CLOSE abci300_cl
               CALL s_transaction_end('N','0')
               RETURN
         END CASE

      #end add-point
      
      
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"

            IF NOT abci300_unconf() THEN
               CLOSE abci300_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            IF NOT abci300_conf() THEN
               CLOSE abci300_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_bcba_m.bcbastus = lc_state OR cl_null(lc_state) THEN
      CLOSE abci300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_bcba_m.bcbamodid = g_user
   LET g_bcba_m.bcbamoddt = cl_get_current()
   LET g_bcba_m.bcbastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE bcba_t 
      SET (bcbastus,bcbamodid,bcbamoddt) 
        = (g_bcba_m.bcbastus,g_bcba_m.bcbamodid,g_bcba_m.bcbamoddt)     
    WHERE bcbaent = g_enterprise AND bcba001 = g_bcba_m.bcba001
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE abci300_master_referesh USING g_bcba_m.bcba001 INTO g_bcba_m.bcba001,g_bcba_m.bcba002, 
          g_bcba_m.bcba003,g_bcba_m.bcba004,g_bcba_m.bcbastus,g_bcba_m.bcbaownid,g_bcba_m.bcbaowndp, 
          g_bcba_m.bcbacrtid,g_bcba_m.bcbacrtdp,g_bcba_m.bcbacrtdt,g_bcba_m.bcbamodid,g_bcba_m.bcbamoddt, 
          g_bcba_m.bcbacnfid,g_bcba_m.bcbacnfdt,g_bcba_m.bcbaownid_desc,g_bcba_m.bcbaowndp_desc,g_bcba_m.bcbacrtid_desc, 
          g_bcba_m.bcbacrtdp_desc,g_bcba_m.bcbamodid_desc,g_bcba_m.bcbacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_bcba_m.bcba001,g_bcba_m.bcbal003,g_bcba_m.bcba002,g_bcba_m.bcba003,g_bcba_m.separate, 
          g_bcba_m.bcba004,g_bcba_m.bcbastus,g_bcba_m.bcbaownid,g_bcba_m.bcbaownid_desc,g_bcba_m.bcbaowndp, 
          g_bcba_m.bcbaowndp_desc,g_bcba_m.bcbacrtid,g_bcba_m.bcbacrtid_desc,g_bcba_m.bcbacrtdp,g_bcba_m.bcbacrtdp_desc, 
          g_bcba_m.bcbacrtdt,g_bcba_m.bcbamodid,g_bcba_m.bcbamodid_desc,g_bcba_m.bcbamoddt,g_bcba_m.bcbacnfid, 
          g_bcba_m.bcbacnfid_desc,g_bcba_m.bcbacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE abci300_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abci300_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abci300.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abci300_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_bcbb_d.getLength() THEN
         LET g_detail_idx = g_bcbb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bcbb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bcbb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abci300.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abci300_b_fill2(pi_idx)
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
   
   CALL abci300_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="abci300.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abci300_fill_chk(ps_idx)
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
 
{<section id="abci300.status_show" >}
PRIVATE FUNCTION abci300_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abci300.mask_functions" >}
&include "erp/abc/abci300_mask.4gl"
 
{</section>}
 
{<section id="abci300.signature" >}
   
 
{</section>}
 
{<section id="abci300.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abci300_set_pk_array()
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
   LET g_pk_array[1].values = g_bcba_m.bcba001
   LET g_pk_array[1].column = 'bcba001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abci300.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="abci300.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abci300_msgcentre_notify(lc_state)
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
   CALL abci300_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bcba_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abci300.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION abci300_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abci300.other_function" readonly="Y" >}

PRIVATE FUNCTION abci300_bcba001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bcba_m.bcba001
   CALL ap_ref_array2(g_ref_fields," SELECT bcbal003 FROM bcbal_t WHERE bcbalent = "||g_enterprise||" AND bcbal001 = ? AND bcbal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_bcba_m.bcbal003 = g_rtn_fields[1] 
   DISPLAY g_bcba_m.bcbal003 TO bcbal003
END FUNCTION

PRIVATE FUNCTION abci300_bcba002_chk()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_sql_1       STRING
   DEFINE l_sql_2       STRING
   DEFINE l_cnt         LIKE type_t.num10
   DEFINE l_cnt_1       LIKE type_t.num10
   DEFINE l_cnt_2       LIKE type_t.num10
   
   LET r_success = TRUE

   LET l_sql = "SELECT COUNT(bcbbseq) FROM bcbb_t",
               " WHERE bcbbent = ",g_enterprise,
               "   AND bcbb001 = '",g_bcba_m.bcba001,"'"

   PREPARE abci300_pre01 FROM l_sql
   LET l_cnt = 0
   EXECUTE abci300_pre01 INTO l_cnt
   
   IF l_cnt > 0 THEN
      CASE
         WHEN g_bcba_m.bcba002 = '3'  #3:物料條碼
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = "abc-00021"   #物料條碼不可設定編碼規則！
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            
            LET r_success = FALSE
            RETURN r_success
            
         WHEN g_bcba_m.bcba002 = '1'  #1:批次條碼
            LET l_sql_1 = l_sql," AND bcbb002 = '12'"
            LET l_sql_2 = l_sql," AND bcbb002 = '14'"
            
         WHEN g_bcba_m.bcba002 = '2'  #2:箱條碼
            LET l_sql_1 = l_sql," AND bcbb002 = '12'"
            
      END CASE
   
      PREPARE abci300_pre02 FROM l_sql_1
      LET l_cnt_1 = 0
      EXECUTE abci300_pre02 INTO l_cnt_1

      PREPARE abci300_pre04 FROM l_sql_2
      LET l_cnt_2 = 0
      EXECUTE abci300_pre04 INTO l_cnt_2

      CASE
         WHEN g_bcba_m.bcba002 = '1'  #1:批次條碼
            IF (l_cnt_1 = 0 OR cl_null(l_cnt_1)) AND
               (l_cnt_2 = 0 OR cl_null(l_cnt_2)) THEN
               
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "abc-00028"   #批次條碼必須設定"流水號"或"單號"！
               LET g_errparam.popup  = TRUE
               CALL cl_err()
                        
               LET r_success = FALSE
               RETURN r_success

            END IF
            
            IF l_cnt_1 > 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "abc-00034"   #流水碼不可超過1組！
               LET g_errparam.popup  = TRUE
               CALL cl_err()
                        
               LET r_success = FALSE
               RETURN r_success
            END IF
            
         WHEN g_bcba_m.bcba002 = '2'  #2:箱條碼
            IF l_cnt_1 = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "abc-00020"   #箱條碼必須設定流水號！
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               LET r_success = FALSE
               RETURN r_success
            END IF
            
            IF l_cnt_1 > 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "abc-00034"   #流水碼不可超過1組！
               LET g_errparam.popup  = TRUE
               CALL cl_err()
                        
               LET r_success = FALSE
               RETURN r_success
            END IF
            
      END CASE
   END IF
      
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION abci300_conf()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_cnt         LIKE type_t.num10
   DEFINE l_datetime    DATETIME YEAR TO SECOND
   
   LET r_success = TRUE
   
   IF NOT abci300_bcba002_chk() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF g_bcba_m.bcba002 <> '3' THEN
      LET l_sql = "SELECT COUNT(bcbbseq) FROM bcbb_t",
                  " WHERE bcbbent = ",g_enterprise,
                  "   AND bcbb001 = '",g_bcba_m.bcba001,"'"

      PREPARE abci300_pre05 FROM l_sql
      LET l_cnt = 0
      EXECUTE abci300_pre05 INTO l_cnt
      
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "axm-00261"  #單身未輸入資料，不可確認！
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   IF g_bcba_m.bcba004 = '2' THEN
      LET l_sql = "SELECT COUNT(bcbbseq)",
                  "  FROM bcbb_t",
                  " WHERE bcbbent = ",g_enterprise,
                  "   AND bcbb001 = '",g_bcba_m.bcba001,"'",
                  "   AND bcbb005 = 'Y'"
      PREPARE abci300_pre03 FROM l_sql
      LET l_cnt = 0
      EXECUTE abci300_pre03 INTO l_cnt
      
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "abc-00022"  #自動產生批號時單身必須勾選批號！
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   LET l_datetime = cl_get_current()
   
   UPDATE bcba_t
      SET bcbastus = 'Y',
          bcbacnfid = g_user,
          bcbacnfdt = l_datetime
    WHERE bcbaent = g_enterprise
      AND bcba001 = g_bcba_m.bcba001

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd bcba_t" 
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success
   END IF

   
   RETURN r_success
END FUNCTION

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
PRIVATE FUNCTION abci300_unconf()
   DEFINE r_success     LIKE type_t.num5
   
   LET r_success = TRUE
   
   UPDATE bcba_t
      SET bcbastus = 'N',
          bcbacnfid = '',
          bcbacnfdt = ''
    WHERE bcbaent = g_enterprise
      AND bcba001 = g_bcba_m.bcba001

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd bcba_t" 
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION abci300_bcbb004_chk()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_length      LIKE type_t.num5
   
   LET r_success = TRUE
   
   CASE g_bcbb_d[l_ac].bcbb002
         
      WHEN '3' #3:年
         LET l_length = 4
          
      WHEN '4' #4:月
         LET l_length = 2
         
      WHEN '5' #5:期
         LET l_length = 2
         
      WHEN '6' #6:週
         LET l_length = 2
         
      WHEN '7' #7:日
         LET l_length = 3
         
      WHEN '8' #8:時
         LET l_length = 2
         
      WHEN '9' #9:分
         LET l_length = 2
         
      WHEN '10' #10:秒
         LET l_length = 2
         
      OTHERWISE
         RETURN r_success
   END CASE
   
   IF g_bcbb_d[l_ac].bcbb004 > l_length THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'apr-00186'  #輸入的長度需<=欄位類別的長度！
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
