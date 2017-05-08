#該程式未解開Section, 採用最新樣板產出!
{<section id="apci128.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-06-10 15:07:14), PR版次:0003(2016-04-29 16:12:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000185
#+ Filename...: apci128
#+ Description: POS角色資料維護作業
#+ Creator....: 03247(2014-02-21 09:55:58)
#+ Modifier...: 06189 -SD/PR- 07959
 
{</section>}
 
{<section id="apci128.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#48 2016/04/29 By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
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
PRIVATE type type_g_pcaf_m        RECORD
       pcaf001 LIKE pcaf_t.pcaf001, 
   pcafl003 LIKE pcafl_t.pcafl003, 
   pcaf002 LIKE pcaf_t.pcaf002, 
   pcafpos LIKE type_t.chr500, 
   pcafstamp DATETIME YEAR TO FRACTION(5), 
   pcafunit LIKE pcaf_t.pcafunit, 
   pcafstus LIKE pcaf_t.pcafstus, 
   pcafownid LIKE pcaf_t.pcafownid, 
   pcafownid_desc LIKE type_t.chr80, 
   pcafowndp LIKE pcaf_t.pcafowndp, 
   pcafowndp_desc LIKE type_t.chr80, 
   pcafcrtid LIKE pcaf_t.pcafcrtid, 
   pcafcrtid_desc LIKE type_t.chr80, 
   pcafcrtdp LIKE pcaf_t.pcafcrtdp, 
   pcafcrtdp_desc LIKE type_t.chr80, 
   pcafcrtdt LIKE pcaf_t.pcafcrtdt, 
   pcafmodid LIKE pcaf_t.pcafmodid, 
   pcafmodid_desc LIKE type_t.chr80, 
   pcafmoddt LIKE pcaf_t.pcafmoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pcag_d        RECORD
       pcagstus LIKE pcag_t.pcagstus, 
   pcag002 LIKE pcag_t.pcag002, 
   pcag002_desc LIKE type_t.chr500, 
   pcag003 LIKE pcag_t.pcag003, 
   pcagunit LIKE pcag_t.pcagunit
       END RECORD
PRIVATE TYPE type_g_pcag2_d RECORD
       pcahstus LIKE pcah_t.pcahstus, 
   pcah003 LIKE pcah_t.pcah003, 
   pcah003_desc LIKE type_t.chr500, 
   pcah004 LIKE pcah_t.pcah004, 
   pcahunit LIKE pcah_t.pcahunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_pcaf001 LIKE pcaf_t.pcaf001
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_pcaf_m          type_g_pcaf_m
DEFINE g_pcaf_m_t        type_g_pcaf_m
DEFINE g_pcaf_m_o        type_g_pcaf_m
DEFINE g_pcaf_m_mask_o   type_g_pcaf_m #轉換遮罩前資料
DEFINE g_pcaf_m_mask_n   type_g_pcaf_m #轉換遮罩後資料
 
   DEFINE g_pcaf001_t LIKE pcaf_t.pcaf001
 
 
DEFINE g_pcag_d          DYNAMIC ARRAY OF type_g_pcag_d
DEFINE g_pcag_d_t        type_g_pcag_d
DEFINE g_pcag_d_o        type_g_pcag_d
DEFINE g_pcag_d_mask_o   DYNAMIC ARRAY OF type_g_pcag_d #轉換遮罩前資料
DEFINE g_pcag_d_mask_n   DYNAMIC ARRAY OF type_g_pcag_d #轉換遮罩後資料
DEFINE g_pcag2_d          DYNAMIC ARRAY OF type_g_pcag2_d
DEFINE g_pcag2_d_t        type_g_pcag2_d
DEFINE g_pcag2_d_o        type_g_pcag2_d
DEFINE g_pcag2_d_mask_o   DYNAMIC ARRAY OF type_g_pcag2_d #轉換遮罩前資料
DEFINE g_pcag2_d_mask_n   DYNAMIC ARRAY OF type_g_pcag2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      pcafl001 LIKE pcafl_t.pcafl001,
      pcafl003 LIKE pcafl_t.pcafl003
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
DEFINE g_wc2_table2   STRING
 
 
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
 
{<section id="apci128.main" >}
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
   CALL cl_ap_init("apc","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pcaf001,'',pcaf002,'',pcafstamp,pcafunit,pcafstus,pcafownid,'',pcafowndp, 
       '',pcafcrtid,'',pcafcrtdp,'',pcafcrtdt,pcafmodid,'',pcafmoddt", 
                      " FROM pcaf_t",
                      " WHERE pcafent= ? AND pcaf001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apci128_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pcaf001,t0.pcaf002,t0.pcafstamp,t0.pcafunit,t0.pcafstus,t0.pcafownid, 
       t0.pcafowndp,t0.pcafcrtid,t0.pcafcrtdp,t0.pcafcrtdt,t0.pcafmodid,t0.pcafmoddt,t1.ooag011 ,t2.ooefl003 , 
       t3.ooag011 ,t4.ooefl003 ,t5.ooag011",
               " FROM pcaf_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.pcafownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.pcafowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.pcafcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.pcafcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.pcafmodid  ",
 
               " WHERE t0.pcafent = " ||g_enterprise|| " AND t0.pcaf001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apci128_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apci128 WITH FORM cl_ap_formpath("apc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apci128_init()   
 
      #進入選單 Menu (="N")
      CALL apci128_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apci128
      
   END IF 
   
   CLOSE apci128_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apci128.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apci128_init()
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
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('pcafstus','17','N,Y')
 
      CALL cl_set_combo_scc('pcah004','6026') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #初始化搜尋條件
   CALL apci128_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apci128.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apci128_ui_dialog()
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
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL apci128_insert()
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
         INITIALIZE g_pcaf_m.* TO NULL
         CALL g_pcag_d.clear()
         CALL g_pcag2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apci128_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_pcag_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apci128_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               CALL apci128_b_fill2('2')
 
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
               CALL apci128_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
         #第二階單身段落
         DISPLAY ARRAY g_pcag2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apci128_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL apci128_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL apci128_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
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
               CALL apci128_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apci128_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL apci128_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL apci128_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL apci128_set_act_visible()   
            CALL apci128_set_act_no_visible()
            IF NOT (g_pcaf_m.pcaf001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " pcafent = " ||g_enterprise|| " AND",
                                  " pcaf001 = '", g_pcaf_m.pcaf001, "' "
 
               #填到對應位置
               CALL apci128_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "pcaf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pcag_t" 
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
               CALL apci128_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "pcaf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pcag_t" 
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
                  CALL apci128_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apci128_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apci128_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apci128_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apci128_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apci128_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apci128_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apci128_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apci128_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apci128_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apci128_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apci128_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_pcag_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_pcag2_d)
                  LET g_export_id[2]   = "s_detail2"
 
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
               CALL apci128_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apci128_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apci128_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apci128_insert()
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
               CALL apci128_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apci128_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apci128_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apci128_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apci128_set_pk_array()
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
 
{<section id="apci128.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apci128_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT pcaf001 ",
                      " FROM pcaf_t ",
                      " ",
                      " LEFT JOIN pcag_t ON pcagent = pcafent AND pcaf001 = pcag001 ", "  ",
                      #add-point:browser_fill段sql(pcag_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
                      " LEFT JOIN pcah_t ON pcahent = pcafent AND pcag001 = pcah001 AND pcag002 = pcah002", "  ",
                      #add-point:browser_fill段sql(pcah_t1) name="browser_fill.cnt.join.pcah_t1"
                      
                      #end add-point
 
 
                      " LEFT JOIN pcafl_t ON pcaflent = "||g_enterprise||" AND pcaf001 = pcafl001 AND pcafl002 = '",g_dlang,"' ", 
                      " ", 
 
                      " ",
 
 
                      " WHERE pcafent = " ||g_enterprise|| " AND pcagent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pcaf_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pcaf001 ",
                      " FROM pcaf_t ", 
                      "  ",
                      "  LEFT JOIN pcafl_t ON pcaflent = "||g_enterprise||" AND pcaf001 = pcafl001 AND pcafl002 = '",g_dlang,"' ",
                      " WHERE pcafent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pcaf_t")
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
      INITIALIZE g_pcaf_m.* TO NULL
      CALL g_pcag_d.clear()        
      CALL g_pcag2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pcaf001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pcafstus,t0.pcaf001 ",
                  " FROM pcaf_t t0",
                  "  ",
                  "  LEFT JOIN pcag_t ON pcagent = pcafent AND pcaf001 = pcag001 ", "  ", 
                  #add-point:browser_fill段sql(pcag_t1) name="browser_fill.join.pcag_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN pcah_t ON pcahent = pcafent AND pcag001 = pcah001 AND pcag002 = pcah002", "  ", 
                  #add-point:browser_fill段sql(pcah_t1) name="browser_fill.join.pcah_t1"
                  
                  #end add-point
 
 
                  " ", 
 
                  " ",
 
 
                  
               " LEFT JOIN pcafl_t ON pcaflent = "||g_enterprise||" AND pcaf001 = pcafl001 AND pcafl002 = '",g_dlang,"' ",
                  " WHERE t0.pcafent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("pcaf_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pcafstus,t0.pcaf001 ",
                  " FROM pcaf_t t0",
                  "  ",
                  
               " LEFT JOIN pcafl_t ON pcaflent = "||g_enterprise||" AND pcaf001 = pcafl001 AND pcafl002 = '",g_dlang,"' ",
                  " WHERE t0.pcafent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("pcaf_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY pcaf001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"pcaf_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pcaf001
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
   
   IF cl_null(g_browser[g_cnt].b_pcaf001) THEN
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
 
{<section id="apci128.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apci128_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pcaf_m.pcaf001 = g_browser[g_current_idx].b_pcaf001   
 
   EXECUTE apci128_master_referesh USING g_pcaf_m.pcaf001 INTO g_pcaf_m.pcaf001,g_pcaf_m.pcaf002,g_pcaf_m.pcafstamp, 
       g_pcaf_m.pcafunit,g_pcaf_m.pcafstus,g_pcaf_m.pcafownid,g_pcaf_m.pcafowndp,g_pcaf_m.pcafcrtid, 
       g_pcaf_m.pcafcrtdp,g_pcaf_m.pcafcrtdt,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmoddt,g_pcaf_m.pcafownid_desc, 
       g_pcaf_m.pcafowndp_desc,g_pcaf_m.pcafcrtid_desc,g_pcaf_m.pcafcrtdp_desc,g_pcaf_m.pcafmodid_desc 
 
   
   CALL apci128_pcaf_t_mask()
   CALL apci128_show()
      
END FUNCTION
 
{</section>}
 
{<section id="apci128.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apci128_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apci128.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apci128_ui_browser_refresh()
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
      IF g_browser[l_i].b_pcaf001 = g_pcaf_m.pcaf001 
 
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
 
{<section id="apci128.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apci128_construct()
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
   INITIALIZE g_pcaf_m.* TO NULL
   CALL g_pcag_d.clear()        
   CALL g_pcag2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON pcaf001,pcafl003,pcaf002,pcafpos,pcafstamp,pcafunit,pcafstus,pcafownid, 
          pcafowndp,pcafcrtid,pcafcrtdp,pcafcrtdt,pcafmodid,pcafmoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pcafcrtdt>>----
         AFTER FIELD pcafcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pcafmoddt>>----
         AFTER FIELD pcafmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pcafcnfdt>>----
         
         #----<<pcafpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.pcaf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcaf001
            #add-point:ON ACTION controlp INFIELD pcaf001 name="construct.c.pcaf001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pcaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pcaf001  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO pcafl003 #說明 

            NEXT FIELD pcaf001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcaf001
            #add-point:BEFORE FIELD pcaf001 name="construct.b.pcaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcaf001
            
            #add-point:AFTER FIELD pcaf001 name="construct.a.pcaf001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafl003
            #add-point:BEFORE FIELD pcafl003 name="construct.b.pcafl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafl003
            
            #add-point:AFTER FIELD pcafl003 name="construct.a.pcafl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pcafl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafl003
            #add-point:ON ACTION controlp INFIELD pcafl003 name="construct.c.pcafl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcaf002
            #add-point:BEFORE FIELD pcaf002 name="construct.b.pcaf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcaf002
            
            #add-point:AFTER FIELD pcaf002 name="construct.a.pcaf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pcaf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcaf002
            #add-point:ON ACTION controlp INFIELD pcaf002 name="construct.c.pcaf002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafpos
            #add-point:BEFORE FIELD pcafpos name="construct.b.pcafpos"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafpos
            
            #add-point:AFTER FIELD pcafpos name="construct.a.pcafpos"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pcafpos
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafpos
            #add-point:ON ACTION controlp INFIELD pcafpos name="construct.c.pcafpos"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafstamp
            #add-point:BEFORE FIELD pcafstamp name="construct.b.pcafstamp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafstamp
            
            #add-point:AFTER FIELD pcafstamp name="construct.a.pcafstamp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pcafstamp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafstamp
            #add-point:ON ACTION controlp INFIELD pcafstamp name="construct.c.pcafstamp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafunit
            #add-point:BEFORE FIELD pcafunit name="construct.b.pcafunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafunit
            
            #add-point:AFTER FIELD pcafunit name="construct.a.pcafunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pcafunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafunit
            #add-point:ON ACTION controlp INFIELD pcafunit name="construct.c.pcafunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafstus
            #add-point:BEFORE FIELD pcafstus name="construct.b.pcafstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafstus
            
            #add-point:AFTER FIELD pcafstus name="construct.a.pcafstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pcafstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafstus
            #add-point:ON ACTION controlp INFIELD pcafstus name="construct.c.pcafstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pcafownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafownid
            #add-point:ON ACTION controlp INFIELD pcafownid name="construct.c.pcafownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pcafownid  #顯示到畫面上

            NEXT FIELD pcafownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafownid
            #add-point:BEFORE FIELD pcafownid name="construct.b.pcafownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafownid
            
            #add-point:AFTER FIELD pcafownid name="construct.a.pcafownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pcafowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafowndp
            #add-point:ON ACTION controlp INFIELD pcafowndp name="construct.c.pcafowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pcafowndp  #顯示到畫面上

            NEXT FIELD pcafowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafowndp
            #add-point:BEFORE FIELD pcafowndp name="construct.b.pcafowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafowndp
            
            #add-point:AFTER FIELD pcafowndp name="construct.a.pcafowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pcafcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafcrtid
            #add-point:ON ACTION controlp INFIELD pcafcrtid name="construct.c.pcafcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pcafcrtid  #顯示到畫面上

            NEXT FIELD pcafcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafcrtid
            #add-point:BEFORE FIELD pcafcrtid name="construct.b.pcafcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafcrtid
            
            #add-point:AFTER FIELD pcafcrtid name="construct.a.pcafcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pcafcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafcrtdp
            #add-point:ON ACTION controlp INFIELD pcafcrtdp name="construct.c.pcafcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pcafcrtdp  #顯示到畫面上

            NEXT FIELD pcafcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafcrtdp
            #add-point:BEFORE FIELD pcafcrtdp name="construct.b.pcafcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafcrtdp
            
            #add-point:AFTER FIELD pcafcrtdp name="construct.a.pcafcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafcrtdt
            #add-point:BEFORE FIELD pcafcrtdt name="construct.b.pcafcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pcafmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafmodid
            #add-point:ON ACTION controlp INFIELD pcafmodid name="construct.c.pcafmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pcafmodid  #顯示到畫面上

            NEXT FIELD pcafmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafmodid
            #add-point:BEFORE FIELD pcafmodid name="construct.b.pcafmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafmodid
            
            #add-point:AFTER FIELD pcafmodid name="construct.a.pcafmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafmoddt
            #add-point:BEFORE FIELD pcafmoddt name="construct.b.pcafmoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON pcagstus,pcag002,pcag003,pcagunit
           FROM s_detail1[1].pcagstus,s_detail1[1].pcag002,s_detail1[1].pcag003,s_detail1[1].pcagunit 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pcagcrtdt>>----
 
         #----<<pcagmoddt>>----
         
         #----<<pcagcnfdt>>----
         
         #----<<pcagpstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcagstus
            #add-point:BEFORE FIELD pcagstus name="construct.b.page1.pcagstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcagstus
            
            #add-point:AFTER FIELD pcagstus name="construct.a.page1.pcagstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pcagstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcagstus
            #add-point:ON ACTION controlp INFIELD pcagstus name="construct.c.page1.pcagstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pcag002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcag002
            #add-point:ON ACTION controlp INFIELD pcag002 name="construct.c.page1.pcag002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pcad001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pcag002  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO pcadl003 #說明 

            NEXT FIELD pcag002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcag002
            #add-point:BEFORE FIELD pcag002 name="construct.b.page1.pcag002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcag002
            
            #add-point:AFTER FIELD pcag002 name="construct.a.page1.pcag002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcag003
            #add-point:BEFORE FIELD pcag003 name="construct.b.page1.pcag003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcag003
            
            #add-point:AFTER FIELD pcag003 name="construct.a.page1.pcag003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pcag003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcag003
            #add-point:ON ACTION controlp INFIELD pcag003 name="construct.c.page1.pcag003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcagunit
            #add-point:BEFORE FIELD pcagunit name="construct.b.page1.pcagunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcagunit
            
            #add-point:AFTER FIELD pcagunit name="construct.a.page1.pcagunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pcagunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcagunit
            #add-point:ON ACTION controlp INFIELD pcagunit name="construct.c.page1.pcagunit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON pcahstus,pcah003,pcah004,pcahunit
           FROM s_detail2[1].pcahstus,s_detail2[1].pcah003,s_detail2[1].pcah004,s_detail2[1].pcahunit 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pcahcrtdt>>----
 
         #----<<pcahmoddt>>----
         
         #----<<pcahcnfdt>>----
         
         #----<<pcahpstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcahstus
            #add-point:BEFORE FIELD pcahstus name="construct.b.page2.pcahstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcahstus
            
            #add-point:AFTER FIELD pcahstus name="construct.a.page2.pcahstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pcahstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcahstus
            #add-point:ON ACTION controlp INFIELD pcahstus name="construct.c.page2.pcahstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.pcah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcah003
            #add-point:ON ACTION controlp INFIELD pcah003 name="construct.c.page2.pcah003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pcae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pcah003  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO pcael003 #說明 

            NEXT FIELD pcah003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcah003
            #add-point:BEFORE FIELD pcah003 name="construct.b.page2.pcah003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcah003
            
            #add-point:AFTER FIELD pcah003 name="construct.a.page2.pcah003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcah004
            #add-point:BEFORE FIELD pcah004 name="construct.b.page2.pcah004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcah004
            
            #add-point:AFTER FIELD pcah004 name="construct.a.page2.pcah004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pcah004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcah004
            #add-point:ON ACTION controlp INFIELD pcah004 name="construct.c.page2.pcah004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcahunit
            #add-point:BEFORE FIELD pcahunit name="construct.b.page2.pcahunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcahunit
            
            #add-point:AFTER FIELD pcahunit name="construct.a.page2.pcahunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pcahunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcahunit
            #add-point:ON ACTION controlp INFIELD pcahunit name="construct.c.page2.pcahunit"
            
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
                  WHEN la_wc[li_idx].tableid = "pcaf_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "pcag_t" 
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
 
 
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apci128.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apci128_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_pcag_d.clear()
   CALL g_pcag2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL apci128_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apci128_browser_fill("")
      CALL apci128_fetch("")
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
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL apci128_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL apci128_fetch("F") 
      #顯示單身筆數
      CALL apci128_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apci128.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apci128_fetch(p_flag)
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
   CALL g_pcag2_d.clear()
 
   
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
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_pcaf_m.pcaf001 = g_browser[g_current_idx].b_pcaf001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apci128_master_referesh USING g_pcaf_m.pcaf001 INTO g_pcaf_m.pcaf001,g_pcaf_m.pcaf002,g_pcaf_m.pcafstamp, 
       g_pcaf_m.pcafunit,g_pcaf_m.pcafstus,g_pcaf_m.pcafownid,g_pcaf_m.pcafowndp,g_pcaf_m.pcafcrtid, 
       g_pcaf_m.pcafcrtdp,g_pcaf_m.pcafcrtdt,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmoddt,g_pcaf_m.pcafownid_desc, 
       g_pcaf_m.pcafowndp_desc,g_pcaf_m.pcafcrtid_desc,g_pcaf_m.pcafcrtdp_desc,g_pcaf_m.pcafmodid_desc 
 
   
   #遮罩相關處理
   LET g_pcaf_m_mask_o.* =  g_pcaf_m.*
   CALL apci128_pcaf_t_mask()
   LET g_pcaf_m_mask_n.* =  g_pcaf_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apci128_set_act_visible()   
   CALL apci128_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_pcaf_m_t.* = g_pcaf_m.*
   LET g_pcaf_m_o.* = g_pcaf_m.*
   
   LET g_data_owner = g_pcaf_m.pcafownid      
   LET g_data_dept  = g_pcaf_m.pcafowndp
   
   #重新顯示   
   CALL apci128_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="apci128.insert" >}
#+ 資料新增
PRIVATE FUNCTION apci128_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_pcag_d.clear()   
   CALL g_pcag2_d.clear()  
 
 
   INITIALIZE g_pcaf_m.* TO NULL             #DEFAULT 設定
   
   LET g_pcaf001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pcaf_m.pcafownid = g_user
      LET g_pcaf_m.pcafowndp = g_dept
      LET g_pcaf_m.pcafcrtid = g_user
      LET g_pcaf_m.pcafcrtdp = g_dept 
      LET g_pcaf_m.pcafcrtdt = cl_get_current()
      LET g_pcaf_m.pcafmodid = g_user
      LET g_pcaf_m.pcafmoddt = cl_get_current()
      LET g_pcaf_m.pcafstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_pcaf_m.pcafpos = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_pcaf_m.pcafstus = "Y"
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_pcaf_m_t.* = g_pcaf_m.*
      LET g_pcaf_m_o.* = g_pcaf_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pcaf_m.pcafstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL apci128_input("a")
      
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
         INITIALIZE g_pcaf_m.* TO NULL
         INITIALIZE g_pcag_d TO NULL
         INITIALIZE g_pcag2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL apci128_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_pcag_d.clear()
      #CALL g_pcag2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apci128_set_act_visible()   
   CALL apci128_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pcaf001_t = g_pcaf_m.pcaf001
 
   
   #組合新增資料的條件
   LET g_add_browse = " pcafent = " ||g_enterprise|| " AND",
                      " pcaf001 = '", g_pcaf_m.pcaf001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apci128_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE apci128_cl
   
   CALL apci128_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apci128_master_referesh USING g_pcaf_m.pcaf001 INTO g_pcaf_m.pcaf001,g_pcaf_m.pcaf002,g_pcaf_m.pcafstamp, 
       g_pcaf_m.pcafunit,g_pcaf_m.pcafstus,g_pcaf_m.pcafownid,g_pcaf_m.pcafowndp,g_pcaf_m.pcafcrtid, 
       g_pcaf_m.pcafcrtdp,g_pcaf_m.pcafcrtdt,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmoddt,g_pcaf_m.pcafownid_desc, 
       g_pcaf_m.pcafowndp_desc,g_pcaf_m.pcafcrtid_desc,g_pcaf_m.pcafcrtdp_desc,g_pcaf_m.pcafmodid_desc 
 
   
   
   #遮罩相關處理
   LET g_pcaf_m_mask_o.* =  g_pcaf_m.*
   CALL apci128_pcaf_t_mask()
   LET g_pcaf_m_mask_n.* =  g_pcaf_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pcaf_m.pcaf001,g_pcaf_m.pcafl003,g_pcaf_m.pcaf002,g_pcaf_m.pcafpos,g_pcaf_m.pcafstamp, 
       g_pcaf_m.pcafunit,g_pcaf_m.pcafstus,g_pcaf_m.pcafownid,g_pcaf_m.pcafownid_desc,g_pcaf_m.pcafowndp, 
       g_pcaf_m.pcafowndp_desc,g_pcaf_m.pcafcrtid,g_pcaf_m.pcafcrtid_desc,g_pcaf_m.pcafcrtdp,g_pcaf_m.pcafcrtdp_desc, 
       g_pcaf_m.pcafcrtdt,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmodid_desc,g_pcaf_m.pcafmoddt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_pcaf_m.pcafownid      
   LET g_data_dept  = g_pcaf_m.pcafowndp
   
   #功能已完成,通報訊息中心
   CALL apci128_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apci128.modify" >}
#+ 資料修改
PRIVATE FUNCTION apci128_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
   DEFINE l_wc2_table2   STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_pcaf_m_t.* = g_pcaf_m.*
   LET g_pcaf_m_o.* = g_pcaf_m.*
   
   IF g_pcaf_m.pcaf001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_pcaf001_t = g_pcaf_m.pcaf001
 
   CALL s_transaction_begin()
   
   OPEN apci128_cl USING g_enterprise,g_pcaf_m.pcaf001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apci128_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apci128_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apci128_master_referesh USING g_pcaf_m.pcaf001 INTO g_pcaf_m.pcaf001,g_pcaf_m.pcaf002,g_pcaf_m.pcafstamp, 
       g_pcaf_m.pcafunit,g_pcaf_m.pcafstus,g_pcaf_m.pcafownid,g_pcaf_m.pcafowndp,g_pcaf_m.pcafcrtid, 
       g_pcaf_m.pcafcrtdp,g_pcaf_m.pcafcrtdt,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmoddt,g_pcaf_m.pcafownid_desc, 
       g_pcaf_m.pcafowndp_desc,g_pcaf_m.pcafcrtid_desc,g_pcaf_m.pcafcrtdp_desc,g_pcaf_m.pcafmodid_desc 
 
   
   #檢查是否允許此動作
   IF NOT apci128_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pcaf_m_mask_o.* =  g_pcaf_m.*
   CALL apci128_pcaf_t_mask()
   LET g_pcaf_m_mask_n.* =  g_pcaf_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
   
   CALL apci128_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
    
   WHILE TRUE
      LET g_pcaf001_t = g_pcaf_m.pcaf001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_pcaf_m.pcafmodid = g_user 
LET g_pcaf_m.pcafmoddt = cl_get_current()
LET g_pcaf_m.pcafmodid_desc = cl_get_username(g_pcaf_m.pcafmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL apci128_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE pcaf_t SET (pcafmodid,pcafmoddt) = (g_pcaf_m.pcafmodid,g_pcaf_m.pcafmoddt)
          WHERE pcafent = g_enterprise AND pcaf001 = g_pcaf001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_pcaf_m.* = g_pcaf_m_t.*
            CALL apci128_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_pcaf_m.pcaf001 != g_pcaf_m_t.pcaf001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE pcag_t SET pcag001 = g_pcaf_m.pcaf001
 
          WHERE pcagent = g_enterprise AND pcag001 = g_pcaf_m_t.pcaf001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pcag_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pcag_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         UPDATE pcah_t
            SET pcah001 = g_pcaf_m.pcaf001
 
          WHERE pcahent = g_enterprise AND
                pcah001 = g_pcaf001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pcah_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pcah_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
 
         
         #UPDATE 多語言table key值
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apci128_set_act_visible()   
   CALL apci128_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pcafent = " ||g_enterprise|| " AND",
                      " pcaf001 = '", g_pcaf_m.pcaf001, "' "
 
   #填到對應位置
   CALL apci128_browser_fill("")
 
   CLOSE apci128_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apci128_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="apci128.input" >}
#+ 資料輸入
PRIVATE FUNCTION apci128_input(p_cmd)
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
   DISPLAY BY NAME g_pcaf_m.pcaf001,g_pcaf_m.pcafl003,g_pcaf_m.pcaf002,g_pcaf_m.pcafpos,g_pcaf_m.pcafstamp, 
       g_pcaf_m.pcafunit,g_pcaf_m.pcafstus,g_pcaf_m.pcafownid,g_pcaf_m.pcafownid_desc,g_pcaf_m.pcafowndp, 
       g_pcaf_m.pcafowndp_desc,g_pcaf_m.pcafcrtid,g_pcaf_m.pcafcrtid_desc,g_pcaf_m.pcafcrtdp,g_pcaf_m.pcafcrtdp_desc, 
       g_pcaf_m.pcafcrtdt,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmodid_desc,g_pcaf_m.pcafmoddt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT pcagstus,pcag002,pcag003,pcagunit FROM pcag_t WHERE pcagent=? AND pcag001=?  
       AND pcag002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apci128_bcl CURSOR FROM g_forupd_sql
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT pcahstus,pcah003,pcah004,pcahunit FROM pcah_t WHERE pcahent=? AND pcah001=?  
       AND pcah002=? AND pcah003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apci128_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apci128_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apci128_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_pcaf_m.pcaf001,g_pcaf_m.pcafl003,g_pcaf_m.pcaf002,g_pcaf_m.pcafpos,g_pcaf_m.pcafstamp, 
       g_pcaf_m.pcafunit,g_pcaf_m.pcafstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apci128.input.head" >}
      #單頭段
      INPUT BY NAME g_pcaf_m.pcaf001,g_pcaf_m.pcafl003,g_pcaf_m.pcaf002,g_pcaf_m.pcafpos,g_pcaf_m.pcafstamp, 
          g_pcaf_m.pcafunit,g_pcaf_m.pcafstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
            IF NOT cl_null(g_pcaf_m.pcaf001) THEN
               CALL n_pcafl(g_pcaf_m.pcaf001)   
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_pcaf_m.pcaf001                  
               CALL ap_ref_array2(g_ref_fields," SELECT pcafl003 FROM pcafl_t WHERE pcaflent = '"||g_enterprise||"' AND pcafl001 = ? AND pcafl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_pcaf_m.pcafl003 = g_rtn_fields[1]
               DISPLAY BY NAME g_pcaf_m.pcafl003
            END IF             
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN apci128_cl USING g_enterprise,g_pcaf_m.pcaf001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apci128_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apci128_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.pcafl001 = g_pcaf_m.pcaf001
LET g_master_multi_table_t.pcafl003 = g_pcaf_m.pcafl003
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.pcafl001 = ''
LET g_master_multi_table_t.pcafl003 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL apci128_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL apci128_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcaf001
            #add-point:BEFORE FIELD pcaf001 name="input.b.pcaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcaf001
            
            #add-point:AFTER FIELD pcaf001 name="input.a.pcaf001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_pcaf_m.pcaf001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pcaf_m.pcaf001 != g_pcaf001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pcaf_t WHERE "||"pcafent = '" ||g_enterprise|| "' AND "||"pcaf001 = '"||g_pcaf_m.pcaf001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcaf001
            #add-point:ON CHANGE pcaf001 name="input.g.pcaf001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafl003
            #add-point:BEFORE FIELD pcafl003 name="input.b.pcafl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafl003
            
            #add-point:AFTER FIELD pcafl003 name="input.a.pcafl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcafl003
            #add-point:ON CHANGE pcafl003 name="input.g.pcafl003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcaf002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pcaf_m.pcaf002,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pcaf002
            END IF 
 
 
 
            #add-point:AFTER FIELD pcaf002 name="input.a.pcaf002"
            IF NOT cl_null(g_pcaf_m.pcaf002) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcaf002
            #add-point:BEFORE FIELD pcaf002 name="input.b.pcaf002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcaf002
            #add-point:ON CHANGE pcaf002 name="input.g.pcaf002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafpos
            #add-point:BEFORE FIELD pcafpos name="input.b.pcafpos"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafpos
            
            #add-point:AFTER FIELD pcafpos name="input.a.pcafpos"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcafpos
            #add-point:ON CHANGE pcafpos name="input.g.pcafpos"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafstamp
            #add-point:BEFORE FIELD pcafstamp name="input.b.pcafstamp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafstamp
            
            #add-point:AFTER FIELD pcafstamp name="input.a.pcafstamp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcafstamp
            #add-point:ON CHANGE pcafstamp name="input.g.pcafstamp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafunit
            #add-point:BEFORE FIELD pcafunit name="input.b.pcafunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafunit
            
            #add-point:AFTER FIELD pcafunit name="input.a.pcafunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcafunit
            #add-point:ON CHANGE pcafunit name="input.g.pcafunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcafstus
            #add-point:BEFORE FIELD pcafstus name="input.b.pcafstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcafstus
            
            #add-point:AFTER FIELD pcafstus name="input.a.pcafstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcafstus
            #add-point:ON CHANGE pcafstus name="input.g.pcafstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pcaf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcaf001
            #add-point:ON ACTION controlp INFIELD pcaf001 name="input.c.pcaf001"
            
            #END add-point
 
 
         #Ctrlp:input.c.pcafl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafl003
            #add-point:ON ACTION controlp INFIELD pcafl003 name="input.c.pcafl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.pcaf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcaf002
            #add-point:ON ACTION controlp INFIELD pcaf002 name="input.c.pcaf002"
            
            #END add-point
 
 
         #Ctrlp:input.c.pcafpos
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafpos
            #add-point:ON ACTION controlp INFIELD pcafpos name="input.c.pcafpos"
            
            #END add-point
 
 
         #Ctrlp:input.c.pcafstamp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafstamp
            #add-point:ON ACTION controlp INFIELD pcafstamp name="input.c.pcafstamp"
            
            #END add-point
 
 
         #Ctrlp:input.c.pcafunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafunit
            #add-point:ON ACTION controlp INFIELD pcafunit name="input.c.pcafunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.pcafstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcafstus
            #add-point:ON ACTION controlp INFIELD pcafstus name="input.c.pcafstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_pcaf_m.pcaf001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               LET g_pcaf_m.pcafunit = g_site
               LET g_pcaf_m.pcafstamp = cl_get_current()               
               #end add-point
               
               INSERT INTO pcaf_t (pcafent,pcaf001,pcaf002,pcafstamp,pcafunit,pcafstus,pcafownid,pcafowndp, 
                   pcafcrtid,pcafcrtdp,pcafcrtdt,pcafmodid,pcafmoddt)
               VALUES (g_enterprise,g_pcaf_m.pcaf001,g_pcaf_m.pcaf002,g_pcaf_m.pcafstamp,g_pcaf_m.pcafunit, 
                   g_pcaf_m.pcafstus,g_pcaf_m.pcafownid,g_pcaf_m.pcafowndp,g_pcaf_m.pcafcrtid,g_pcaf_m.pcafcrtdp, 
                   g_pcaf_m.pcafcrtdt,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_pcaf_m:",SQLERRMESSAGE 
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
         IF g_pcaf_m.pcaf001 = g_master_multi_table_t.pcafl001 AND
         g_pcaf_m.pcafl003 = g_master_multi_table_t.pcafl003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'pcaflent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_pcaf_m.pcaf001
            LET l_field_keys[02] = 'pcafl001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.pcafl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'pcafl002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_pcaf_m.pcafl003
            LET l_fields[01] = 'pcafl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pcafl_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apci128_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL apci128_b_fill()
                  CALL apci128_b_fill2('0')
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
               CALL apci128_pcaf_t_mask_restore('restore_mask_o')
               
               UPDATE pcaf_t SET (pcaf001,pcaf002,pcafstamp,pcafunit,pcafstus,pcafownid,pcafowndp,pcafcrtid, 
                   pcafcrtdp,pcafcrtdt,pcafmodid,pcafmoddt) = (g_pcaf_m.pcaf001,g_pcaf_m.pcaf002,g_pcaf_m.pcafstamp, 
                   g_pcaf_m.pcafunit,g_pcaf_m.pcafstus,g_pcaf_m.pcafownid,g_pcaf_m.pcafowndp,g_pcaf_m.pcafcrtid, 
                   g_pcaf_m.pcafcrtdp,g_pcaf_m.pcafcrtdt,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmoddt)
                WHERE pcafent = g_enterprise AND pcaf001 = g_pcaf001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "pcaf_t:",SQLERRMESSAGE 
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
         IF g_pcaf_m.pcaf001 = g_master_multi_table_t.pcafl001 AND
         g_pcaf_m.pcafl003 = g_master_multi_table_t.pcafl003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'pcaflent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_pcaf_m.pcaf001
            LET l_field_keys[02] = 'pcafl001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.pcafl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'pcafl002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_pcaf_m.pcafl003
            LET l_fields[01] = 'pcafl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pcafl_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL apci128_pcaf_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_pcaf_m_t)
               LET g_log2 = util.JSON.stringify(g_pcaf_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_pcaf001_t = g_pcaf_m.pcaf001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="apci128.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_pcag_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pcag_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apci128_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_pcag_d.getLength()
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
            CALL apci128_b_fill2('2')
 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN apci128_cl USING g_enterprise,g_pcaf_m.pcaf001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apci128_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apci128_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_pcag_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pcag_d[l_ac].pcag002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pcag_d_t.* = g_pcag_d[l_ac].*  #BACKUP
               LET g_pcag_d_o.* = g_pcag_d[l_ac].*  #BACKUP
               CALL apci128_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL apci128_set_no_entry_b(l_cmd)
               IF NOT apci128_lock_b("pcag_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apci128_bcl INTO g_pcag_d[l_ac].pcagstus,g_pcag_d[l_ac].pcag002,g_pcag_d[l_ac].pcag003, 
                      g_pcag_d[l_ac].pcagunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_pcag_d_t.pcag002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pcag_d_mask_o[l_ac].* =  g_pcag_d[l_ac].*
                  CALL apci128_pcag_t_mask()
                  LET g_pcag_d_mask_n[l_ac].* =  g_pcag_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apci128_show()
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
            INITIALIZE g_pcag_d[l_ac].* TO NULL 
            INITIALIZE g_pcag_d_t.* TO NULL 
            INITIALIZE g_pcag_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pcag_d[l_ac].pcagstus = 'Y'
 
 
 
            #自定義預設值
                  LET g_pcag_d[l_ac].pcagstus = "Y"
      LET g_pcag_d[l_ac].pcag003 = "Y"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_pcag_d_t.* = g_pcag_d[l_ac].*     #新輸入資料
            LET g_pcag_d_o.* = g_pcag_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apci128_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL apci128_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pcag_d[li_reproduce_target].* = g_pcag_d[li_reproduce].*
 
               LET g_pcag_d[li_reproduce_target].pcag002 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_pcag_d[l_ac].pcagunit = g_site
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
            SELECT COUNT(1) INTO l_count FROM pcag_t 
             WHERE pcagent = g_enterprise AND pcag001 = g_pcaf_m.pcaf001
 
               AND pcag002 = g_pcag_d[l_ac].pcag002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pcaf_m.pcaf001
               LET gs_keys[2] = g_pcag_d[g_detail_idx].pcag002
               CALL apci128_insert_b('pcag_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_pcag_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pcag_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apci128_b_fill()
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
               LET gs_keys[01] = g_pcaf_m.pcaf001
 
               LET gs_keys[gs_keys.getLength()+1] = g_pcag_d_t.pcag002
 
            
               #刪除同層單身
               IF NOT apci128_delete_b('pcag_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apci128_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apci128_key_delete_b(gs_keys,'pcag_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apci128_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE apci128_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_pcag_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pcag_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcagstus
            #add-point:BEFORE FIELD pcagstus name="input.b.page1.pcagstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcagstus
            
            #add-point:AFTER FIELD pcagstus name="input.a.page1.pcagstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcagstus
            #add-point:ON CHANGE pcagstus name="input.g.page1.pcagstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcag002
            
            #add-point:AFTER FIELD pcag002 name="input.a.page1.pcag002"
            IF NOT cl_null(g_pcag_d[l_ac].pcag002) AND l_cmd = 'a' THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pcag_d[l_ac].pcag002

               #160318-00025#48  2016/04/29  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "apc-00008:sub-01302|apci126|",cl_get_progname("apci126",g_lang,"2"),"|:EXEPROGapci126"
               #160318-00025#48  2016/04/29  by pengxin  add(E)  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pcad001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_pcag_d[l_ac].pcag002 = g_pcag_d_t.pcag002
                  LET g_pcag_d[l_ac].pcag002_desc = ""
                  DISPLAY BY NAME g_pcag_d[l_ac].pcag002,g_pcag_d[l_ac].pcag002_desc                  
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #此段落由子樣板a05產生
            IF  g_pcaf_m.pcaf001 IS NOT NULL AND g_pcag_d[g_detail_idx].pcag002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pcaf_m.pcaf001 != g_pcaf001_t OR g_pcag_d[g_detail_idx].pcag002 != g_pcag_d_t.pcag002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pcag_t WHERE "||"pcagent = '" ||g_enterprise|| "' AND "||"pcag001 = '"||g_pcaf_m.pcaf001 ||"' AND "|| "pcag002 = '"||g_pcag_d[g_detail_idx].pcag002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_pcag_d[l_ac].pcag002) THEN
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_pcag_d[l_ac].pcag002                  
               CALL ap_ref_array2(g_ref_fields," SELECT pcadl003 FROM pcadl_t WHERE pcadlent = '"||g_enterprise||"' AND pcadl001 = ? AND pcadl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_pcag_d[l_ac].pcag002_desc = g_rtn_fields[1]
               DISPLAY BY NAME g_pcag_d[l_ac].pcag002_desc
            END IF               


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcag002
            #add-point:BEFORE FIELD pcag002 name="input.b.page1.pcag002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcag002
            #add-point:ON CHANGE pcag002 name="input.g.page1.pcag002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcag003
            #add-point:BEFORE FIELD pcag003 name="input.b.page1.pcag003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcag003
            
            #add-point:AFTER FIELD pcag003 name="input.a.page1.pcag003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcag003
            #add-point:ON CHANGE pcag003 name="input.g.page1.pcag003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcagunit
            #add-point:BEFORE FIELD pcagunit name="input.b.page1.pcagunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcagunit
            
            #add-point:AFTER FIELD pcagunit name="input.a.page1.pcagunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcagunit
            #add-point:ON CHANGE pcagunit name="input.g.page1.pcagunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pcagstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcagstus
            #add-point:ON ACTION controlp INFIELD pcagstus name="input.c.page1.pcagstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pcag002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcag002
            #add-point:ON ACTION controlp INFIELD pcag002 name="input.c.page1.pcag002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pcag_d[l_ac].pcag002             #給予default值
            LET g_qryparam.default2 = g_pcag_d[l_ac].pcag002_desc #說明

            #給予arg

            CALL q_pcad001_2()                                #呼叫開窗

            LET g_pcag_d[l_ac].pcag002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_pcag_d[l_ac].pcag002_desc = g_qryparam.return2 #說明

            DISPLAY g_pcag_d[l_ac].pcag002 TO pcag002              #顯示到畫面上
            DISPLAY g_pcag_d[l_ac].pcag002_desc TO pcag002_desc #說明

            NEXT FIELD pcag002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pcag003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcag003
            #add-point:ON ACTION controlp INFIELD pcag003 name="input.c.page1.pcag003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pcagunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcagunit
            #add-point:ON ACTION controlp INFIELD pcagunit name="input.c.page1.pcagunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pcag_d[l_ac].* = g_pcag_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apci128_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pcag_d[l_ac].pcag002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_pcag_d[l_ac].* = g_pcag_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
      
               #將遮罩欄位還原
               CALL apci128_pcag_t_mask_restore('restore_mask_o')
      
               UPDATE pcag_t SET (pcag001,pcagstus,pcag002,pcag003,pcagunit) = (g_pcaf_m.pcaf001,g_pcag_d[l_ac].pcagstus, 
                   g_pcag_d[l_ac].pcag002,g_pcag_d[l_ac].pcag003,g_pcag_d[l_ac].pcagunit)
                WHERE pcagent = g_enterprise AND pcag001 = g_pcaf_m.pcaf001 
 
                  AND pcag002 = g_pcag_d_t.pcag002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_pcag_d[l_ac].* = g_pcag_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pcag_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_pcag_d[l_ac].* = g_pcag_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pcag_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pcaf_m.pcaf001
               LET gs_keys_bak[1] = g_pcaf001_t
               LET gs_keys[2] = g_pcag_d[g_detail_idx].pcag002
               LET gs_keys_bak[2] = g_pcag_d_t.pcag002
               CALL apci128_update_b('pcag_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL apci128_pcag_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_pcag_d[g_detail_idx].pcag002 = g_pcag_d_t.pcag002 
 
                  ) THEN
                  LET gs_keys[01] = g_pcaf_m.pcaf001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pcag_d_t.pcag002
 
                  CALL apci128_key_update_b(gs_keys,'pcag_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pcaf_m),util.JSON.stringify(g_pcag_d_t)
               LET g_log2 = util.JSON.stringify(g_pcaf_m),util.JSON.stringify(g_pcag_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL apci128_unlock_b("pcag_t","'1'")
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
               LET g_pcag_d[li_reproduce_target].* = g_pcag_d[li_reproduce].*
 
               LET g_pcag_d[li_reproduce_target].pcag002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pcag_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pcag_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
      INPUT ARRAY g_pcag2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
        
         BEFORE INPUT
            #先將上層單身的idx放入g_detail_idx
            LET g_detail_idx_tmp = g_detail_idx
            LET g_detail_idx = g_detail_idx_list[1]
            #檢查上層單身是否為空
            IF g_detail_idx = 0 OR g_pcag_d.getLength() = 0 THEN
               NEXT FIELD pcag002
            END IF
            #檢查上層單身是否有資料
            IF cl_null(g_pcag_d[g_detail_idx].pcag002) THEN
               NEXT FIELD pcag002
            END IF
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pcag2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_pcag2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pcag2_d[l_ac].* TO NULL 
            INITIALIZE g_pcag2_d_t.* TO NULL 
            INITIALIZE g_pcag2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pcag2_d[l_ac].pcahstus = 'Y'
 
 
 
            #自定義預設值(單身2)
                  LET g_pcag2_d[l_ac].pcahstus = "Y"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_pcag2_d_t.* = g_pcag2_d[l_ac].*     #新輸入資料
            LET g_pcag2_d_o.* = g_pcag2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apci128_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL apci128_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pcag2_d[li_reproduce_target].* = g_pcag2_d[li_reproduce].*
 
               LET g_pcag2_d[li_reproduce_target].pcah003 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            LET g_pcag2_d[l_ac].pcahunit = g_site
            #end add-point  
            
         BEFORE ROW
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET g_detail_idx_list[2] = l_ac
            LET g_current_page = 2
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN apci128_cl USING g_enterprise,g_pcaf_m.pcaf001
            #(ver:78) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apci128_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CLOSE apci128_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            #(ver:78) --- end ---
            OPEN apci128_bcl USING g_enterprise,g_pcaf_m.pcaf001,g_pcag_d[g_detail_idx].pcag002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apci128_bcl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apci128_cl
               CLOSE apci128_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_pcag2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pcag2_d[l_ac].pcah003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_pcag2_d_t.* = g_pcag2_d[l_ac].*  #BACKUP
               LET g_pcag2_d_o.* = g_pcag2_d[l_ac].*  #BACKUP
               CALL apci128_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               LET g_pcag_d_t.* = g_pcag_d[g_detail_idx].*
               #end add-point  
               CALL apci128_set_no_entry_b(l_cmd)
               IF NOT apci128_lock_b("pcah_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apci128_bcl2 INTO g_pcag2_d[l_ac].pcahstus,g_pcag2_d[l_ac].pcah003,g_pcag2_d[l_ac].pcah004, 
                      g_pcag2_d[l_ac].pcahunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pcag2_d_mask_o[l_ac].* =  g_pcag2_d[l_ac].*
                  CALL apci128_pcah_t_mask()
                  LET g_pcag2_d_mask_n[l_ac].* =  g_pcag2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apci128_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
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
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
 
               #取得該筆資料key值
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pcaf_m.pcaf001
               LET gs_keys[2] = g_pcag_d[g_detail_idx].pcag002
               LET gs_keys[3] = g_pcag2_d_t.pcah003
 
 
               #刪除同層單身
               IF NOT apci128_delete_b('pcah_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apci128_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point   
               
               CALL s_transaction_end('Y','0')
               CLOSE apci128_bcl
                  
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
 
               LET l_count = g_pcag_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pcag2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
         
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
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
    
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM pcah_t 
             WHERE pcahent = g_enterprise AND pcah001 = g_pcaf_m.pcaf001 AND pcah002 = g_pcag_d[g_detail_idx].pcag002  
                 AND pcah003 = g_pcag2_d[g_detail_idx2].pcah003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pcaf_m.pcaf001
               LET gs_keys[2] = g_pcag_d[g_detail_idx].pcag002
               LET gs_keys[3] = g_pcag2_d[g_detail_idx2].pcah003
               CALL apci128_insert_b('pcah_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_pcag_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pcah_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apci128_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
            #還原g_detail_idx
            LET g_detail_idx = g_detail_idx_tmp
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pcag2_d[l_ac].* = g_pcag2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apci128_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_pcag2_d[l_ac].* = g_pcag2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               #將遮罩欄位還原
               CALL apci128_pcah_t_mask_restore('restore_mask_o')
               
               UPDATE pcah_t SET (pcah001,pcah002,pcahstus,pcah003,pcah004,pcahunit) = (g_pcaf_m.pcaf001, 
                   g_pcag_d[g_detail_idx].pcag002,g_pcag2_d[l_ac].pcahstus,g_pcag2_d[l_ac].pcah003,g_pcag2_d[l_ac].pcah004, 
                   g_pcag2_d[l_ac].pcahunit) #自訂欄位頁簽
                WHERE pcahent = g_enterprise AND pcah001 = g_pcaf001_t AND pcah002 = g_pcag_d[g_detail_idx].pcag002  
                    AND pcah003 = g_pcag2_d_t.pcah003
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_pcag2_d[l_ac].* = g_pcag2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pcah_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_pcag2_d[l_ac].* = g_pcag2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pcah_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pcaf_m.pcaf001
               LET gs_keys_bak[1] = g_pcaf001_t
               LET gs_keys[2] = g_pcag_d[g_detail_idx].pcag002
               LET gs_keys_bak[2] = g_pcag_d[g_detail_idx].pcag002
               LET gs_keys[3] = g_pcag2_d[g_detail_idx2].pcah003
               LET gs_keys_bak[3] = g_pcag2_d_t.pcah003
               CALL apci128_update_b('pcah_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL apci128_pcah_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pcaf_m),util.JSON.stringify(g_pcag2_d_t)
               LET g_log2 = util.JSON.stringify(g_pcaf_m),util.JSON.stringify(g_pcag2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcahstus
            #add-point:BEFORE FIELD pcahstus name="input.b.page2.pcahstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcahstus
            
            #add-point:AFTER FIELD pcahstus name="input.a.page2.pcahstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcahstus
            #add-point:ON CHANGE pcahstus name="input.g.page2.pcahstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcah003
            
            #add-point:AFTER FIELD pcah003 name="input.a.page2.pcah003"
            IF NOT cl_null(g_pcag2_d[l_ac].pcah003) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pcag2_d[l_ac].pcah003
               LET g_chkparam.arg2 = g_pcag_d[g_detail_idx].pcag002

               #160318-00025#48  2016/04/29  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "apc-00014:sub-01302|apci127|",cl_get_progname("apci127",g_lang,"2"),"|:EXEPROGapci127"
               #160318-00025#48  2016/04/29  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pcah003") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #LET  = g_chkparam.return2                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_pcag2_d[l_ac].pcah003 = g_pcag2_d_t.pcah003
                  LET g_pcag2_d[l_ac].pcah003_desc = ""
                  DISPLAY BY NAME g_pcag2_d[l_ac].pcah003,g_pcag2_d[l_ac].pcah003_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #此段落由子樣板a05產生
            IF  g_pcaf_m.pcaf001 IS NOT NULL AND g_pcag_d[g_detail_idx].pcag002 IS NOT NULL AND g_pcag2_d[g_detail_idx2].pcah003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pcaf_m.pcaf001 != g_pcaf001_t OR g_pcag_d[g_detail_idx].pcag002 != g_pcag_d_t.pcag002 OR g_pcag2_d[g_detail_idx2].pcah003 != g_pcag2_d_t.pcah003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pcah_t WHERE "||"pcahent = '" ||g_enterprise|| "' AND "||"pcah001 = '"||g_pcaf_m.pcaf001 ||"' AND "|| "pcah002 = '"||g_pcag_d[g_detail_idx].pcag002 ||"' AND "|| "pcah003 = '"||g_pcag2_d[g_detail_idx2].pcah003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_pcag2_d[l_ac].pcah003) THEN
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_pcag2_d[l_ac].pcah003                 
               CALL ap_ref_array2(g_ref_fields," SELECT pcael003 FROM pcael_t WHERE pcaelent = '"||g_enterprise||"' AND pcael001 = ? AND pcael002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_pcag2_d[l_ac].pcah003_desc = g_rtn_fields[1]
               DISPLAY BY NAME g_pcag2_d[l_ac].pcah003_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcah003
            #add-point:BEFORE FIELD pcah003 name="input.b.page2.pcah003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcah003
            #add-point:ON CHANGE pcah003 name="input.g.page2.pcah003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcah004
            #add-point:BEFORE FIELD pcah004 name="input.b.page2.pcah004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcah004
            
            #add-point:AFTER FIELD pcah004 name="input.a.page2.pcah004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcah004
            #add-point:ON CHANGE pcah004 name="input.g.page2.pcah004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pcahunit
            #add-point:BEFORE FIELD pcahunit name="input.b.page2.pcahunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pcahunit
            
            #add-point:AFTER FIELD pcahunit name="input.a.page2.pcahunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pcahunit
            #add-point:ON CHANGE pcahunit name="input.g.page2.pcahunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.pcahstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcahstus
            #add-point:ON ACTION controlp INFIELD pcahstus name="input.c.page2.pcahstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.pcah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcah003
            #add-point:ON ACTION controlp INFIELD pcah003 name="input.c.page2.pcah003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pcag2_d[l_ac].pcah003             #給予default值
            LET g_qryparam.default2 = g_pcag2_d[l_ac].pcah003_desc #說明

            #給予arg
            LET g_qryparam.arg1 = g_pcag_d[g_detail_idx].pcag002 #

            CALL q_pcae001()                                #呼叫開窗

            LET g_pcag2_d[l_ac].pcah003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_pcag2_d[l_ac].pcah003_desc = g_qryparam.return2 #說明

            DISPLAY g_pcag2_d[l_ac].pcah003 TO pcah003              #顯示到畫面上
            DISPLAY g_pcag2_d[l_ac].pcah003_desc TO pcah003_desc #說明

            NEXT FIELD pcah003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.pcah004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcah004
            #add-point:ON ACTION controlp INFIELD pcah004 name="input.c.page2.pcah004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.pcahunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pcahunit
            #add-point:ON ACTION controlp INFIELD pcahunit name="input.c.page2.pcahunit"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2_after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pcag2_d[l_ac].* = g_pcag2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apci128_bcl2
               CLOSE apci128_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL apci128_unlock_b("pcah_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2_after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point  
 
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_pcag2_d[li_reproduce_target].* = g_pcag2_d[li_reproduce].*
 
               LET g_pcag2_d[li_reproduce_target].pcah003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_pcag2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pcag2_d.getLength()+1
            END IF
        
      END INPUT
 
 
 
 
{</section>}
 
{<section id="apci128.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD pcaf001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pcagstus
               WHEN "s_detail2"
                  NEXT FIELD pcahstus
 
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
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
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
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="apci128.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apci128_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   LET g_pcaf_m.pcafpos = "N"
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL apci128_b_fill() #單身填充
      CALL apci128_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apci128_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pcaf_m.pcaf001
   CALL ap_ref_array2(g_ref_fields," SELECT pcafl003 FROM pcafl_t WHERE pcaflent = '"||g_enterprise||"' AND pcafl001 = ? AND pcafl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_pcaf_m.pcafl003 = g_rtn_fields[1] 
   DISPLAY g_pcaf_m.pcafl003 TO pcafl003
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pcaf_m.pcafownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pcaf_m.pcafownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pcaf_m.pcafownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pcaf_m.pcafowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pcaf_m.pcafowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pcaf_m.pcafowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pcaf_m.pcafcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pcaf_m.pcafcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pcaf_m.pcafcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pcaf_m.pcafcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pcaf_m.pcafcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pcaf_m.pcafcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pcaf_m.pcafmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pcaf_m.pcafmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pcaf_m.pcafmodid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_pcaf_m_mask_o.* =  g_pcaf_m.*
   CALL apci128_pcaf_t_mask()
   LET g_pcaf_m_mask_n.* =  g_pcaf_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pcaf_m.pcaf001,g_pcaf_m.pcafl003,g_pcaf_m.pcaf002,g_pcaf_m.pcafpos,g_pcaf_m.pcafstamp, 
       g_pcaf_m.pcafunit,g_pcaf_m.pcafstus,g_pcaf_m.pcafownid,g_pcaf_m.pcafownid_desc,g_pcaf_m.pcafowndp, 
       g_pcaf_m.pcafowndp_desc,g_pcaf_m.pcafcrtid,g_pcaf_m.pcafcrtid_desc,g_pcaf_m.pcafcrtdp,g_pcaf_m.pcafcrtdp_desc, 
       g_pcaf_m.pcafcrtdt,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmodid_desc,g_pcaf_m.pcafmoddt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pcaf_m.pcafstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_pcag_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_pcag_d[l_ac].pcag002
   CALL ap_ref_array2(g_ref_fields," SELECT pcadl003 FROM pcadl_t WHERE pcadlent = '"||g_enterprise||"' AND pcadl001 = ? AND pcadl002 = '"||g_dlang||"' ","") RETURNING g_rtn_fields 
   LET g_pcag_d[l_ac].pcag002_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_pcag_d[l_ac].pcag002_desc
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_pcag2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_pcag2_d[l_ac].pcah003
   CALL ap_ref_array2(g_ref_fields," SELECT pcael003 FROM pcael_t WHERE pcaelent = '"||g_enterprise||"' AND pcael001 = ? AND pcael002 = '"||g_dlang||"' ","") RETURNING g_rtn_fields 
   LET g_pcag2_d[l_ac].pcah003_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_pcag2_d[l_ac].pcah003_desc
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL apci128_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apci128.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION apci128_detail_show()
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
 
{<section id="apci128.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apci128_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE pcaf_t.pcaf001 
   DEFINE l_oldno     LIKE pcaf_t.pcaf001 
 
   DEFINE l_master    RECORD LIKE pcaf_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pcag_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE pcah_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_pcaf_m.pcaf001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_pcaf001_t = g_pcaf_m.pcaf001
 
    
   LET g_pcaf_m.pcaf001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pcaf_m.pcafownid = g_user
      LET g_pcaf_m.pcafowndp = g_dept
      LET g_pcaf_m.pcafcrtid = g_user
      LET g_pcaf_m.pcafcrtdp = g_dept 
      LET g_pcaf_m.pcafcrtdt = cl_get_current()
      LET g_pcaf_m.pcafmodid = g_user
      LET g_pcaf_m.pcafmoddt = cl_get_current()
      LET g_pcaf_m.pcafstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pcaf_m.pcafstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL apci128_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_pcaf_m.* TO NULL
      INITIALIZE g_pcag_d TO NULL
      INITIALIZE g_pcag2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL apci128_show()
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
   CALL apci128_set_act_visible()   
   CALL apci128_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pcaf001_t = g_pcaf_m.pcaf001
 
   
   #組合新增資料的條件
   LET g_add_browse = " pcafent = " ||g_enterprise|| " AND",
                      " pcaf001 = '", g_pcaf_m.pcaf001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apci128_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL apci128_idx_chk()
   
   LET g_data_owner = g_pcaf_m.pcafownid      
   LET g_data_dept  = g_pcaf_m.pcafowndp
   
   #功能已完成,通報訊息中心
   CALL apci128_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="apci128.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apci128_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pcag_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE pcah_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apci128_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pcag_t
    WHERE pcagent = g_enterprise AND pcag001 = g_pcaf001_t
 
    INTO TEMP apci128_detail
 
   #將key修正為調整後   
   UPDATE apci128_detail 
      #更新key欄位
      SET pcag001 = g_pcaf_m.pcaf001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
      #, pcagstus = "Y" 
 
 
#應用 a13 樣板自動產生(Version:4)
      #, pcahstus = "Y" 
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO pcag_t SELECT * FROM apci128_detail
   
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
   DROP TABLE apci128_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pcah_t 
    WHERE pcahent = g_enterprise AND pcah001 = g_pcaf001_t
 
    INTO TEMP apci128_detail
 
   #將key修正為調整後   
   UPDATE apci128_detail SET pcah001 = g_pcaf_m.pcaf001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO pcah_t SELECT * FROM apci128_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE apci128_detail
   
   LET g_data_owner = g_pcaf_m.pcafownid      
   LET g_data_dept  = g_pcaf_m.pcafowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pcaf001_t = g_pcaf_m.pcaf001
 
   
END FUNCTION
 
{</section>}
 
{<section id="apci128.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apci128_delete()
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
   
   IF g_pcaf_m.pcaf001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.pcafl001 = g_pcaf_m.pcaf001
LET g_master_multi_table_t.pcafl003 = g_pcaf_m.pcafl003
 
   
   CALL s_transaction_begin()
 
   OPEN apci128_cl USING g_enterprise,g_pcaf_m.pcaf001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apci128_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apci128_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apci128_master_referesh USING g_pcaf_m.pcaf001 INTO g_pcaf_m.pcaf001,g_pcaf_m.pcaf002,g_pcaf_m.pcafstamp, 
       g_pcaf_m.pcafunit,g_pcaf_m.pcafstus,g_pcaf_m.pcafownid,g_pcaf_m.pcafowndp,g_pcaf_m.pcafcrtid, 
       g_pcaf_m.pcafcrtdp,g_pcaf_m.pcafcrtdt,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmoddt,g_pcaf_m.pcafownid_desc, 
       g_pcaf_m.pcafowndp_desc,g_pcaf_m.pcafcrtid_desc,g_pcaf_m.pcafcrtdp_desc,g_pcaf_m.pcafmodid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT apci128_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pcaf_m_mask_o.* =  g_pcaf_m.*
   CALL apci128_pcaf_t_mask()
   LET g_pcaf_m_mask_n.* =  g_pcaf_m.*
   
   CALL apci128_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apci128_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_pcaf001_t = g_pcaf_m.pcaf001
 
 
      DELETE FROM pcaf_t
       WHERE pcafent = g_enterprise AND pcaf001 = g_pcaf_m.pcaf001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_pcaf_m.pcaf001,":",SQLERRMESSAGE  
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
      
      DELETE FROM pcag_t
       WHERE pcagent = g_enterprise AND pcag001 = g_pcaf_m.pcaf001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pcag_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM pcah_t
       WHERE pcahent = g_enterprise AND
             pcah001 = g_pcaf_m.pcaf001
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pcah_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pcaf_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE apci128_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_pcag_d.clear() 
      CALL g_pcag2_d.clear()       
 
     
      CALL apci128_ui_browser_refresh()  
      #CALL apci128_ui_headershow()  
      #CALL apci128_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'pcaflent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.pcafl001
   LET l_field_keys[02] = 'pcafl001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'pcafl_t')
 
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL apci128_browser_fill("")
         CALL apci128_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apci128_cl
 
   #功能已完成,通報訊息中心
   CALL apci128_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apci128.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apci128_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_pcag_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF apci128_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pcagstus,pcag002,pcag003,pcagunit ,t1.pcadl003 FROM pcag_t",  
               
                     " INNER JOIN pcaf_t ON pcafent = " ||g_enterprise|| " AND pcaf001 = pcag001 ",
 
                     #"",
                     " LEFT JOIN pcah_t ON pcagent = pcahent AND pcag001 = pcah001 AND pcag002 = pcah002 ",
                     "",
                     #下層單身所需的join條件
                     " ",
 
 
                                    " LEFT JOIN pcadl_t t1 ON t1.pcadlent="||g_enterprise||" AND t1.pcadl001=pcag002 AND t1.pcadl002='"||g_dlang||"' ",
 
                     " WHERE pcagent=? AND pcag001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
            IF NOT cl_null(g_wc2_table2) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table2 CLIPPED
   END IF 
 
         
         LET g_sql = g_sql, " ORDER BY pcag_t.pcag002"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apci128_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apci128_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pcaf_m.pcaf001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pcaf_m.pcaf001 INTO g_pcag_d[l_ac].pcagstus,g_pcag_d[l_ac].pcag002, 
          g_pcag_d[l_ac].pcag003,g_pcag_d[l_ac].pcagunit,g_pcag_d[l_ac].pcag002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         INITIALIZE g_ref_fields TO NULL 
         LET g_ref_fields[1] = g_pcag_d[l_ac].pcag002
         CALL ap_ref_array2(g_ref_fields," SELECT pcadl003 FROM pcadl_t WHERE pcadlent = '"||g_enterprise||"' AND pcadl001 = ? AND pcadl002 = '"||g_dlang||"' ","") RETURNING g_rtn_fields 
         LET g_pcag_d[l_ac].pcag002_desc = g_rtn_fields[1] 
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
   
   CALL g_pcag_d.deleteElement(g_pcag_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE apci128_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_pcag_d.getLength()
      LET g_pcag_d_mask_o[l_ac].* =  g_pcag_d[l_ac].*
      CALL apci128_pcag_t_mask()
      LET g_pcag_d_mask_n[l_ac].* =  g_pcag_d[l_ac].*
   END FOR
   
   LET g_pcag2_d_mask_o.* =  g_pcag2_d.*
   FOR l_ac = 1 TO g_pcag2_d.getLength()
      LET g_pcag2_d_mask_o[l_ac].* =  g_pcag2_d[l_ac].*
      CALL apci128_pcah_t_mask()
      LET g_pcag2_d_mask_n[l_ac].* =  g_pcag2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="apci128.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apci128_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM pcag_t
       WHERE pcagent = g_enterprise AND
         pcag001 = ps_keys_bak[1] AND pcag002 = ps_keys_bak[2]
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
         CALL g_pcag_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM pcah_t
       WHERE pcahent = g_enterprise AND
             pcah001 = ps_keys_bak[1] AND pcah002 = ps_keys_bak[2] AND pcah003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pcah_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_pcag2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apci128.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apci128_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO pcag_t
                  (pcagent,
                   pcag001,
                   pcag002
                   ,pcagstus,pcag003,pcagunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_pcag_d[g_detail_idx].pcagstus,g_pcag_d[g_detail_idx].pcag003,g_pcag_d[g_detail_idx].pcagunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pcag_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_pcag_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO pcah_t
                  (pcahent,
                   pcah001,pcah002,
                   pcah003
                   ,pcahstus,pcah004,pcahunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_pcag2_d[g_detail_idx2].pcahstus,g_pcag2_d[g_detail_idx2].pcah004,g_pcag2_d[g_detail_idx2].pcahunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pcah_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_pcag2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="apci128.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apci128_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pcag_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL apci128_pcag_t_mask_restore('restore_mask_o')
               
      UPDATE pcag_t 
         SET (pcag001,
              pcag002
              ,pcagstus,pcag003,pcagunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_pcag_d[g_detail_idx].pcagstus,g_pcag_d[g_detail_idx].pcag003,g_pcag_d[g_detail_idx].pcagunit)  
 
         WHERE pcagent = g_enterprise AND pcag001 = ps_keys_bak[1] AND pcag002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pcag_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pcag_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apci128_pcag_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pcah_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL apci128_pcah_t_mask_restore('restore_mask_o')
               
      UPDATE pcah_t 
         SET (pcah001,pcah002,
              pcah003
              ,pcahstus,pcah004,pcahunit) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_pcag2_d[g_detail_idx2].pcahstus,g_pcag2_d[g_detail_idx2].pcah004,g_pcag2_d[g_detail_idx2].pcahunit)  
 
         WHERE pcahent = g_enterprise AND pcah001 = ps_keys_bak[1] AND pcah002 = ps_keys_bak[2] AND pcah003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pcah_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pcah_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apci128_pcah_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apci128.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION apci128_key_update_b(ps_keys_bak,ps_table)
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
   
   #如果是上層單身則進行update
   IF ps_table = 'pcag_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update2"
      
      #end add-point
      
      UPDATE pcah_t 
         SET (pcah001,pcah002) 
              = 
             (g_pcaf_m.pcaf001,g_pcag_d[g_detail_idx].pcag002) 
         WHERE pcahent = g_enterprise AND
               pcah001 = ps_keys_bak[1] AND pcah002 = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="key_update_b.m_update2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pcah_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      
      #add-point:update_b段修改後 name="key_update_b.after_update2"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="apci128.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apci128_key_delete_b(ps_keys_bak,ps_table)
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
   
   #如果是上層單身則進行delete
   IF ps_table = 'pcag_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete2"
      
      #end add-point
      
      DELETE FROM pcah_t 
            WHERE pcahent = g_enterprise AND
                  pcah001 = ps_keys_bak[1] AND pcah002 = ps_keys_bak[2]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pcah_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
 
       
 
      #add-point:delete_b段修改後 name="key_delete_b.after_delete2"
      
      #end add-point
   END IF
 
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apci128.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apci128_lock_b(ps_table,ps_page)
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
   #CALL apci128_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "pcag_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apci128_bcl USING g_enterprise,
                                       g_pcaf_m.pcaf001,g_pcag_d[g_detail_idx].pcag002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apci128_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "pcah_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN apci128_bcl2 USING g_enterprise,
                                             g_pcaf_m.pcaf001,g_pcag_d[g_detail_idx].pcag002,
                                             g_pcag2_d[g_detail_idx2].pcah003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apci128_bcl2:",SQLERRMESSAGE 
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
 
{<section id="apci128.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apci128_unlock_b(ps_table,ps_page)
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
      CLOSE apci128_bcl
   END IF
   
 
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apci128_bcl2
   END IF
 
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="apci128.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apci128_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pcaf001",TRUE)
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
 
{<section id="apci128.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apci128_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pcaf001",FALSE)
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
 
{<section id="apci128.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apci128_set_entry_b(p_cmd)
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
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pcag002",TRUE)
   END IF
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="apci128.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apci128_set_no_entry_b(p_cmd)
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
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("pcag002",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="apci128.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apci128_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apci128.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apci128_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apci128.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apci128_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apci128.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apci128_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apci128.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apci128_default_search()
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
      LET ls_wc = ls_wc, " pcaf001 = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "pcaf_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "pcag_t" 
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
 
{<section id="apci128.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION apci128_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_pcaf_m.pcaf001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN apci128_cl USING g_enterprise,g_pcaf_m.pcaf001
   IF STATUS THEN
      CLOSE apci128_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apci128_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE apci128_master_referesh USING g_pcaf_m.pcaf001 INTO g_pcaf_m.pcaf001,g_pcaf_m.pcaf002,g_pcaf_m.pcafstamp, 
       g_pcaf_m.pcafunit,g_pcaf_m.pcafstus,g_pcaf_m.pcafownid,g_pcaf_m.pcafowndp,g_pcaf_m.pcafcrtid, 
       g_pcaf_m.pcafcrtdp,g_pcaf_m.pcafcrtdt,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmoddt,g_pcaf_m.pcafownid_desc, 
       g_pcaf_m.pcafowndp_desc,g_pcaf_m.pcafcrtid_desc,g_pcaf_m.pcafcrtdp_desc,g_pcaf_m.pcafmodid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT apci128_action_chk() THEN
      CLOSE apci128_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pcaf_m.pcaf001,g_pcaf_m.pcafl003,g_pcaf_m.pcaf002,g_pcaf_m.pcafpos,g_pcaf_m.pcafstamp, 
       g_pcaf_m.pcafunit,g_pcaf_m.pcafstus,g_pcaf_m.pcafownid,g_pcaf_m.pcafownid_desc,g_pcaf_m.pcafowndp, 
       g_pcaf_m.pcafowndp_desc,g_pcaf_m.pcafcrtid,g_pcaf_m.pcafcrtid_desc,g_pcaf_m.pcafcrtdp,g_pcaf_m.pcafcrtdp_desc, 
       g_pcaf_m.pcafcrtdt,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmodid_desc,g_pcaf_m.pcafmoddt
 
   CASE g_pcaf_m.pcafstus
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
         CASE g_pcaf_m.pcafstus
            
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
      g_pcaf_m.pcafstus = lc_state OR cl_null(lc_state) THEN
      CLOSE apci128_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_pcaf_m.pcafmodid = g_user
   LET g_pcaf_m.pcafmoddt = cl_get_current()
   LET g_pcaf_m.pcafstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE pcaf_t 
      SET (pcafstus,pcafmodid,pcafmoddt) 
        = (g_pcaf_m.pcafstus,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmoddt)     
    WHERE pcafent = g_enterprise AND pcaf001 = g_pcaf_m.pcaf001
 
    
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
      EXECUTE apci128_master_referesh USING g_pcaf_m.pcaf001 INTO g_pcaf_m.pcaf001,g_pcaf_m.pcaf002, 
          g_pcaf_m.pcafstamp,g_pcaf_m.pcafunit,g_pcaf_m.pcafstus,g_pcaf_m.pcafownid,g_pcaf_m.pcafowndp, 
          g_pcaf_m.pcafcrtid,g_pcaf_m.pcafcrtdp,g_pcaf_m.pcafcrtdt,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmoddt, 
          g_pcaf_m.pcafownid_desc,g_pcaf_m.pcafowndp_desc,g_pcaf_m.pcafcrtid_desc,g_pcaf_m.pcafcrtdp_desc, 
          g_pcaf_m.pcafmodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_pcaf_m.pcaf001,g_pcaf_m.pcafl003,g_pcaf_m.pcaf002,g_pcaf_m.pcafpos,g_pcaf_m.pcafstamp, 
          g_pcaf_m.pcafunit,g_pcaf_m.pcafstus,g_pcaf_m.pcafownid,g_pcaf_m.pcafownid_desc,g_pcaf_m.pcafowndp, 
          g_pcaf_m.pcafowndp_desc,g_pcaf_m.pcafcrtid,g_pcaf_m.pcafcrtid_desc,g_pcaf_m.pcafcrtdp,g_pcaf_m.pcafcrtdp_desc, 
          g_pcaf_m.pcafcrtdt,g_pcaf_m.pcafmodid,g_pcaf_m.pcafmodid_desc,g_pcaf_m.pcafmoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE apci128_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apci128_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apci128.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apci128_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_pcag_d.getLength() THEN
         LET g_detail_idx = g_pcag_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pcag_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pcag_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_pcag2_d.getLength() THEN
         LET g_detail_idx2 = g_pcag2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_pcag2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_pcag2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apci128.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apci128_b_fill2(pi_idx)
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
   
   IF apci128_fill_chk(2) THEN
      IF (pi_idx = 2 OR pi_idx = 0 ) AND g_pcag_d.getLength() > 0 THEN
               CALL g_pcag2_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT pcahstus,pcah003,pcah004,pcahunit ,t2.pcael003 FROM pcah_t",  
                
                     "",
                                    " LEFT JOIN pcael_t t2 ON t2.pcaelent="||g_enterprise||" AND t2.pcael001=pcah003 AND t2.pcael002='"||g_dlang||"' ",
 
                     " WHERE pcahent=? AND pcah001=? AND pcah002=?"
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  pcah_t.pcah003" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill2"
         
         #end add-point
         
         #先清空資料
               CALL g_pcag2_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apci128_pb2 FROM g_sql
         DECLARE b_fill_curs2 CURSOR FOR apci128_pb2
         
      #  OPEN b_fill_curs2 USING g_enterprise,g_pcaf_m.pcaf001,g_pcag_d[g_detail_idx].pcag002   #(ver:78) 
 
         LET l_ac = 1
         FOREACH b_fill_curs2 USING g_enterprise,g_pcaf_m.pcaf001,g_pcag_d[g_detail_idx].pcag002 INTO g_pcag2_d[l_ac].pcahstus, 
             g_pcag2_d[l_ac].pcah003,g_pcag2_d[l_ac].pcah004,g_pcag2_d[l_ac].pcahunit,g_pcag2_d[l_ac].pcah003_desc  
               #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill2"
            INITIALIZE g_ref_fields TO NULL 
            LET g_ref_fields[1] = g_pcag2_d[l_ac].pcah003
            CALL ap_ref_array2(g_ref_fields," SELECT pcael003 FROM pcael_t WHERE pcaelent = '"||g_enterprise||"' AND pcael001 = ? AND pcael002 = '"||g_dlang||"' ","") RETURNING g_rtn_fields 
            LET g_pcag2_d[l_ac].pcah003_desc = g_rtn_fields[1] 
            #end add-point
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
               CALL g_pcag2_d.deleteElement(g_pcag2_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_pcag2_d_mask_o.* =  g_pcag2_d.*
   FOR l_ac = 1 TO g_pcag2_d.getLength()
      LET g_pcag2_d_mask_o[l_ac].* =  g_pcag2_d[l_ac].*
      CALL apci128_pcah_t_mask()
      LET g_pcag2_d_mask_n[l_ac].* =  g_pcag2_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL apci128_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="apci128.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apci128_fill_chk(ps_idx)
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
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apci128.status_show" >}
PRIVATE FUNCTION apci128_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apci128.mask_functions" >}
&include "erp/apc/apci128_mask.4gl"
 
{</section>}
 
{<section id="apci128.signature" >}
   
 
{</section>}
 
{<section id="apci128.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apci128_set_pk_array()
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
   LET g_pk_array[1].values = g_pcaf_m.pcaf001
   LET g_pk_array[1].column = 'pcaf001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apci128.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="apci128.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apci128_msgcentre_notify(lc_state)
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
   CALL apci128_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pcaf_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apci128.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apci128_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apci128.other_function" readonly="Y" >}

 
{</section>}
 
