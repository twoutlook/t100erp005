#該程式未解開Section, 採用最新樣板產出!
{<section id="axri014.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2015-04-21 11:29:04), PR版次:0009(2016-12-01 10:21:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000352
#+ Filename...: axri014
#+ Description: 帳齡及備抵呆帳提列設定作業
#+ Creator....: 02291(2013-11-13 14:14:09)
#+ Modifier...: 01727 -SD/PR- 02481
 
{</section>}
 
{<section id="axri014.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00005#50     2016/03/29    by pengxin    將重複內容的錯誤訊息置換為公用錯誤訊息
#161101-00009#1      2016/11/01    By 01727      复制时程序会down出
#161128-00061#3      2016/12/01    by 02481      标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_xrad_m        RECORD
       xrad001 LIKE xrad_t.xrad001, 
   xradl003 LIKE xradl_t.xradl003, 
   xrad004 LIKE xrad_t.xrad004, 
   xradstus LIKE xrad_t.xradstus, 
   xradownid LIKE xrad_t.xradownid, 
   xradownid_desc LIKE type_t.chr80, 
   xradowndp LIKE xrad_t.xradowndp, 
   xradowndp_desc LIKE type_t.chr80, 
   xradcrtid LIKE xrad_t.xradcrtid, 
   xradcrtid_desc LIKE type_t.chr80, 
   xradcrtdp LIKE xrad_t.xradcrtdp, 
   xradcrtdp_desc LIKE type_t.chr80, 
   xradcrtdt LIKE xrad_t.xradcrtdt, 
   xradmodid LIKE xrad_t.xradmodid, 
   xradmodid_desc LIKE type_t.chr80, 
   xradmoddt LIKE xrad_t.xradmoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xrae_d        RECORD
       xrae002 LIKE xrae_t.xrae002, 
   xrae003 LIKE xrae_t.xrae003, 
   xrae004 LIKE xrae_t.xrae004, 
   xrae005 LIKE xrae_t.xrae005
       END RECORD
PRIVATE TYPE type_g_xrae2_d RECORD
       xraf002 LIKE xraf_t.xraf002, 
   xraf002_desc LIKE type_t.chr500, 
   xraf003 LIKE xraf_t.xraf003, 
   xraf004 LIKE xraf_t.xraf004, 
   xraf005 LIKE xraf_t.xraf005, 
   xraf006 LIKE xraf_t.xraf006, 
   xraf007 LIKE xraf_t.xraf007, 
   xraf008 LIKE xraf_t.xraf008, 
   xraf009 LIKE xraf_t.xraf009, 
   xraf010 LIKE xraf_t.xraf010, 
   xraf011 LIKE xraf_t.xraf011, 
   xraf012 LIKE xraf_t.xraf012, 
   xraf013 LIKE xraf_t.xraf013, 
   xraf014 LIKE xraf_t.xraf014, 
   xraf015 LIKE xraf_t.xraf015, 
   xraf016 LIKE xraf_t.xraf016, 
   xraf017 LIKE xraf_t.xraf017, 
   xraf018 LIKE xraf_t.xraf018, 
   xraf019 LIKE xraf_t.xraf019, 
   xraf020 LIKE xraf_t.xraf020, 
   xraf021 LIKE xraf_t.xraf021, 
   xraf022 LIKE xraf_t.xraf022, 
   total_1 LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xrad001 LIKE xrad_t.xrad001,
   b_xrad001_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
PRIVATE type type_g_xrae_s        RECORD
       xrae001 LIKE type_t.chr80,
       xrae002_2 LIKE xrae_t.xrae002,
       xrae003_2 LIKE xrae_t.xrae003,
       xrae005 LIKE xrae_t.xrae005
       END RECORD
DEFINE g_xrae_s        type_g_xrae_s          {#ADP版次:1#}
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xrad_m          type_g_xrad_m
DEFINE g_xrad_m_t        type_g_xrad_m
DEFINE g_xrad_m_o        type_g_xrad_m
DEFINE g_xrad_m_mask_o   type_g_xrad_m #轉換遮罩前資料
DEFINE g_xrad_m_mask_n   type_g_xrad_m #轉換遮罩後資料
 
   DEFINE g_xrad001_t LIKE xrad_t.xrad001
 
 
DEFINE g_xrae_d          DYNAMIC ARRAY OF type_g_xrae_d
DEFINE g_xrae_d_t        type_g_xrae_d
DEFINE g_xrae_d_o        type_g_xrae_d
DEFINE g_xrae_d_mask_o   DYNAMIC ARRAY OF type_g_xrae_d #轉換遮罩前資料
DEFINE g_xrae_d_mask_n   DYNAMIC ARRAY OF type_g_xrae_d #轉換遮罩後資料
DEFINE g_xrae2_d          DYNAMIC ARRAY OF type_g_xrae2_d
DEFINE g_xrae2_d_t        type_g_xrae2_d
DEFINE g_xrae2_d_o        type_g_xrae2_d
DEFINE g_xrae2_d_mask_o   DYNAMIC ARRAY OF type_g_xrae2_d #轉換遮罩前資料
DEFINE g_xrae2_d_mask_n   DYNAMIC ARRAY OF type_g_xrae2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      xradl001 LIKE xradl_t.xradl001,
      xradl003 LIKE xradl_t.xradl003
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
 
{<section id="axri014.main" >}
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
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xrad001,'',xrad004,xradstus,xradownid,'',xradowndp,'',xradcrtid,'',xradcrtdp, 
       '',xradcrtdt,xradmodid,'',xradmoddt", 
                      " FROM xrad_t",
                      " WHERE xradent= ? AND xrad001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axri014_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xrad001,t0.xrad004,t0.xradstus,t0.xradownid,t0.xradowndp,t0.xradcrtid, 
       t0.xradcrtdp,t0.xradcrtdt,t0.xradmodid,t0.xradmoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 , 
       t5.ooag011",
               " FROM xrad_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.xradownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xradowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.xradcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.xradcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.xradmodid  ",
 
               " WHERE t0.xradent = " ||g_enterprise|| " AND t0.xrad001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axri014_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axri014 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axri014_init()   
 
      #進入選單 Menu (="N")
      CALL axri014_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axri014
      
   END IF 
   
   CLOSE axri014_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axri014.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axri014_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_sql      STRING
   DEFINE l_str      STRING 
   DEFINE l_gzcb002  LIKE gzcb_t.gzcb002  
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
      CALL cl_set_combo_scc_part('xradstus','17','N,Y')
 
      CALL cl_set_combo_scc('xrad004','8312') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8312' AND gzcb003 = 'Y'"
   PREPARE xrad004_pre FROM l_sql
   DECLARE xrad004_cur CURSOR FOR xrad004_pre
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH xrad004_cur INTO l_gzcb002
      IF cl_null(l_str) THEN LET l_str = l_gzcb002 CONTINUE FOREACH END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH

   CALL cl_set_combo_scc_part('xrad004','8312',l_str)
   #end add-point
   
   #初始化搜尋條件
   CALL axri014_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axri014.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axri014_ui_dialog()
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
            CALL axri014_insert()
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
         INITIALIZE g_xrad_m.* TO NULL
         CALL g_xrae_d.clear()
         CALL g_xrae2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axri014_init()
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
               
               CALL axri014_fetch('') # reload data
               LET l_ac = 1
               CALL axri014_ui_detailshow() #Setting the current row 
         
               CALL axri014_idx_chk()
               #NEXT FIELD xrae002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_xrae_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axri014_idx_chk()
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
               CALL axri014_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_xrae2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axri014_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL axri014_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL axri014_browser_fill("")
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
               CALL axri014_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axri014_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axri014_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
 
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL axri014_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL axri014_set_act_visible()   
            CALL axri014_set_act_no_visible()
            IF NOT (g_xrad_m.xrad001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " xradent = " ||g_enterprise|| " AND",
                                  " xrad001 = '", g_xrad_m.xrad001, "' "
 
               #填到對應位置
               CALL axri014_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "xrad_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrae_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xraf_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL axri014_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "xrad_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrae_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xraf_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL axri014_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axri014_fetch("F")
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
               CALL axri014_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axri014_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axri014_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axri014_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axri014_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axri014_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axri014_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axri014_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axri014_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axri014_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axri014_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xrae_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xrae2_d)
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
               NEXT FIELD xrae002
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
               CALL axri014_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axri014_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axri014_s01
            LET g_action_choice="open_axri014_s01"
            IF cl_auth_chk_act("open_axri014_s01") THEN
               
               #add-point:ON ACTION open_axri014_s01 name="menu.open_axri014_s01"
               CALL axri014_s01(g_xrad_m.xrad001)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axri014_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axri014_insert()
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
               CALL axri014_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axri014_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axri014_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axri014_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axri014_set_pk_array()
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
 
{<section id="axri014.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axri014_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT xrad001 ",
                      " FROM xrad_t ",
                      " ",
                      " LEFT JOIN xrae_t ON xraeent = xradent AND xrad001 = xrae001 ", "  ",
                      #add-point:browser_fill段sql(xrae_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN xraf_t ON xrafent = xradent AND xrad001 = xraf001", "  ",
                      #add-point:browser_fill段sql(xraf_t1) name="browser_fill.cnt.join.xraf_t1"
                      
                      #end add-point
 
 
 
                      " LEFT JOIN xradl_t ON xradlent = "||g_enterprise||" AND xrad001 = xradl001 AND xradl002 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE xradent = " ||g_enterprise|| " AND xraeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xrad_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xrad001 ",
                      " FROM xrad_t ", 
                      "  ",
                      "  LEFT JOIN xradl_t ON xradlent = "||g_enterprise||" AND xrad001 = xradl001 AND xradl002 = '",g_dlang,"' ",
                      " WHERE xradent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xrad_t")
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
      INITIALIZE g_xrad_m.* TO NULL
      CALL g_xrae_d.clear()        
      CALL g_xrae2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xrad001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xradstus,t0.xrad001 ",
                  " FROM xrad_t t0",
                  "  ",
                  "  LEFT JOIN xrae_t ON xraeent = xradent AND xrad001 = xrae001 ", "  ", 
                  #add-point:browser_fill段sql(xrae_t1) name="browser_fill.join.xrae_t1"
                  
                  #end add-point
                  "  LEFT JOIN xraf_t ON xrafent = xradent AND xrad001 = xraf001", "  ", 
                  #add-point:browser_fill段sql(xraf_t1) name="browser_fill.join.xraf_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                  
               " LEFT JOIN xradl_t ON xradlent = "||g_enterprise||" AND xrad001 = xradl001 AND xradl002 = '",g_dlang,"' ",
                  " WHERE t0.xradent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xrad_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xradstus,t0.xrad001 ",
                  " FROM xrad_t t0",
                  "  ",
                  
               " LEFT JOIN xradl_t ON xradlent = "||g_enterprise||" AND xrad001 = xradl001 AND xradl002 = '",g_dlang,"' ",
                  " WHERE t0.xradent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xrad_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY xrad001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xrad_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xrad001
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         IF NOT cl_null(g_browser[g_cnt].b_xrad001) THEN
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_browser[g_cnt].b_xrad001
            CALL ap_ref_array2(g_ref_fields," SELECT xradl003 FROM xradl_t WHERE xradlent = '"||g_enterprise||"' AND xradl001 = ? AND xradl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
            LET g_browser[g_cnt].b_xrad001_desc = g_rtn_fields[1] 
         END IF
         #end add-point
      
         #遮罩相關處理
         CALL axri014_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_xrad001) THEN
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
 
{<section id="axri014.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axri014_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xrad_m.xrad001 = g_browser[g_current_idx].b_xrad001   
 
   EXECUTE axri014_master_referesh USING g_xrad_m.xrad001 INTO g_xrad_m.xrad001,g_xrad_m.xrad004,g_xrad_m.xradstus, 
       g_xrad_m.xradownid,g_xrad_m.xradowndp,g_xrad_m.xradcrtid,g_xrad_m.xradcrtdp,g_xrad_m.xradcrtdt, 
       g_xrad_m.xradmodid,g_xrad_m.xradmoddt,g_xrad_m.xradownid_desc,g_xrad_m.xradowndp_desc,g_xrad_m.xradcrtid_desc, 
       g_xrad_m.xradcrtdp_desc,g_xrad_m.xradmodid_desc
   
   CALL axri014_xrad_t_mask()
   CALL axri014_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axri014.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axri014_ui_detailshow()
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
 
{<section id="axri014.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axri014_ui_browser_refresh()
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
      IF g_browser[l_i].b_xrad001 = g_xrad_m.xrad001 
 
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
 
{<section id="axri014.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axri014_construct()
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
   INITIALIZE g_xrad_m.* TO NULL
   CALL g_xrae_d.clear()        
   CALL g_xrae2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xrad001,xradl003,xrad004,xradstus,xradownid,xradowndp,xradcrtid,xradcrtdp, 
          xradcrtdt,xradmodid,xradmoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xradcrtdt>>----
         AFTER FIELD xradcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xradmoddt>>----
         AFTER FIELD xradmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xradcnfdt>>----
         
         #----<<xradpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.xrad001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrad001
            #add-point:ON ACTION controlp INFIELD xrad001 name="construct.c.xrad001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
           #CALL q_xrad001_1()                           #呼叫開窗
            CALL axri014_01()
            DISPLAY g_qryparam.return1 TO xrad001  #顯示到畫面上

            NEXT FIELD xrad001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrad001
            #add-point:BEFORE FIELD xrad001 name="construct.b.xrad001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrad001
            
            #add-point:AFTER FIELD xrad001 name="construct.a.xrad001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xradl003
            #add-point:BEFORE FIELD xradl003 name="construct.b.xradl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xradl003
            
            #add-point:AFTER FIELD xradl003 name="construct.a.xradl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xradl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xradl003
            #add-point:ON ACTION controlp INFIELD xradl003 name="construct.c.xradl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrad004
            #add-point:BEFORE FIELD xrad004 name="construct.b.xrad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrad004
            
            #add-point:AFTER FIELD xrad004 name="construct.a.xrad004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrad004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrad004
            #add-point:ON ACTION controlp INFIELD xrad004 name="construct.c.xrad004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xradstus
            #add-point:BEFORE FIELD xradstus name="construct.b.xradstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xradstus
            
            #add-point:AFTER FIELD xradstus name="construct.a.xradstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xradstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xradstus
            #add-point:ON ACTION controlp INFIELD xradstus name="construct.c.xradstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xradownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xradownid
            #add-point:ON ACTION controlp INFIELD xradownid name="construct.c.xradownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xradownid  #顯示到畫面上

            NEXT FIELD xradownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xradownid
            #add-point:BEFORE FIELD xradownid name="construct.b.xradownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xradownid
            
            #add-point:AFTER FIELD xradownid name="construct.a.xradownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xradowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xradowndp
            #add-point:ON ACTION controlp INFIELD xradowndp name="construct.c.xradowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xradowndp  #顯示到畫面上

            NEXT FIELD xradowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xradowndp
            #add-point:BEFORE FIELD xradowndp name="construct.b.xradowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xradowndp
            
            #add-point:AFTER FIELD xradowndp name="construct.a.xradowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xradcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xradcrtid
            #add-point:ON ACTION controlp INFIELD xradcrtid name="construct.c.xradcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xradcrtid  #顯示到畫面上

            NEXT FIELD xradcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xradcrtid
            #add-point:BEFORE FIELD xradcrtid name="construct.b.xradcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xradcrtid
            
            #add-point:AFTER FIELD xradcrtid name="construct.a.xradcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xradcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xradcrtdp
            #add-point:ON ACTION controlp INFIELD xradcrtdp name="construct.c.xradcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xradcrtdp  #顯示到畫面上

            NEXT FIELD xradcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xradcrtdp
            #add-point:BEFORE FIELD xradcrtdp name="construct.b.xradcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xradcrtdp
            
            #add-point:AFTER FIELD xradcrtdp name="construct.a.xradcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xradcrtdt
            #add-point:BEFORE FIELD xradcrtdt name="construct.b.xradcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xradmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xradmodid
            #add-point:ON ACTION controlp INFIELD xradmodid name="construct.c.xradmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xradmodid  #顯示到畫面上

            NEXT FIELD xradmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xradmodid
            #add-point:BEFORE FIELD xradmodid name="construct.b.xradmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xradmodid
            
            #add-point:AFTER FIELD xradmodid name="construct.a.xradmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xradmoddt
            #add-point:BEFORE FIELD xradmoddt name="construct.b.xradmoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xrae002,xrae003,xrae004,xrae005
           FROM s_detail1[1].xrae002,s_detail1[1].xrae003,s_detail1[1].xrae004,s_detail1[1].xrae005
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrae002
            #add-point:BEFORE FIELD xrae002 name="construct.b.page1.xrae002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrae002
            
            #add-point:AFTER FIELD xrae002 name="construct.a.page1.xrae002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrae002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrae002
            #add-point:ON ACTION controlp INFIELD xrae002 name="construct.c.page1.xrae002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrae003
            #add-point:BEFORE FIELD xrae003 name="construct.b.page1.xrae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrae003
            
            #add-point:AFTER FIELD xrae003 name="construct.a.page1.xrae003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrae003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrae003
            #add-point:ON ACTION controlp INFIELD xrae003 name="construct.c.page1.xrae003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrae004
            #add-point:BEFORE FIELD xrae004 name="construct.b.page1.xrae004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrae004
            
            #add-point:AFTER FIELD xrae004 name="construct.a.page1.xrae004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrae004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrae004
            #add-point:ON ACTION controlp INFIELD xrae004 name="construct.c.page1.xrae004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrae005
            #add-point:BEFORE FIELD xrae005 name="construct.b.page1.xrae005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrae005
            
            #add-point:AFTER FIELD xrae005 name="construct.a.page1.xrae005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrae005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrae005
            #add-point:ON ACTION controlp INFIELD xrae005 name="construct.c.page1.xrae005"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON xraf002,xraf003,xraf004,xraf005,xraf006,xraf007,xraf008,xraf009,xraf010, 
          xraf011,xraf012,xraf013,xraf014,xraf015,xraf016,xraf017,xraf018,xraf019,xraf020,xraf021,xraf022, 
          total_1
           FROM s_detail2[1].xraf002,s_detail2[1].xraf003,s_detail2[1].xraf004,s_detail2[1].xraf005, 
               s_detail2[1].xraf006,s_detail2[1].xraf007,s_detail2[1].xraf008,s_detail2[1].xraf009,s_detail2[1].xraf010, 
               s_detail2[1].xraf011,s_detail2[1].xraf012,s_detail2[1].xraf013,s_detail2[1].xraf014,s_detail2[1].xraf015, 
               s_detail2[1].xraf016,s_detail2[1].xraf017,s_detail2[1].xraf018,s_detail2[1].xraf019,s_detail2[1].xraf020, 
               s_detail2[1].xraf021,s_detail2[1].xraf022,s_detail2[1].total_1
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page2.xraf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf002
            #add-point:ON ACTION controlp INFIELD xraf002 name="construct.c.page2.xraf002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_xmaj001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO xraf002  #顯示到畫面上

            NEXT FIELD xraf002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf002
            #add-point:BEFORE FIELD xraf002 name="construct.b.page2.xraf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf002
            
            #add-point:AFTER FIELD xraf002 name="construct.a.page2.xraf002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf003
            #add-point:BEFORE FIELD xraf003 name="construct.b.page2.xraf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf003
            
            #add-point:AFTER FIELD xraf003 name="construct.a.page2.xraf003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf003
            #add-point:ON ACTION controlp INFIELD xraf003 name="construct.c.page2.xraf003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf004
            #add-point:BEFORE FIELD xraf004 name="construct.b.page2.xraf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf004
            
            #add-point:AFTER FIELD xraf004 name="construct.a.page2.xraf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf004
            #add-point:ON ACTION controlp INFIELD xraf004 name="construct.c.page2.xraf004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf005
            #add-point:BEFORE FIELD xraf005 name="construct.b.page2.xraf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf005
            
            #add-point:AFTER FIELD xraf005 name="construct.a.page2.xraf005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf005
            #add-point:ON ACTION controlp INFIELD xraf005 name="construct.c.page2.xraf005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf006
            #add-point:BEFORE FIELD xraf006 name="construct.b.page2.xraf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf006
            
            #add-point:AFTER FIELD xraf006 name="construct.a.page2.xraf006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf006
            #add-point:ON ACTION controlp INFIELD xraf006 name="construct.c.page2.xraf006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf007
            #add-point:BEFORE FIELD xraf007 name="construct.b.page2.xraf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf007
            
            #add-point:AFTER FIELD xraf007 name="construct.a.page2.xraf007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf007
            #add-point:ON ACTION controlp INFIELD xraf007 name="construct.c.page2.xraf007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf008
            #add-point:BEFORE FIELD xraf008 name="construct.b.page2.xraf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf008
            
            #add-point:AFTER FIELD xraf008 name="construct.a.page2.xraf008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf008
            #add-point:ON ACTION controlp INFIELD xraf008 name="construct.c.page2.xraf008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf009
            #add-point:BEFORE FIELD xraf009 name="construct.b.page2.xraf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf009
            
            #add-point:AFTER FIELD xraf009 name="construct.a.page2.xraf009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf009
            #add-point:ON ACTION controlp INFIELD xraf009 name="construct.c.page2.xraf009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf010
            #add-point:BEFORE FIELD xraf010 name="construct.b.page2.xraf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf010
            
            #add-point:AFTER FIELD xraf010 name="construct.a.page2.xraf010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf010
            #add-point:ON ACTION controlp INFIELD xraf010 name="construct.c.page2.xraf010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf011
            #add-point:BEFORE FIELD xraf011 name="construct.b.page2.xraf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf011
            
            #add-point:AFTER FIELD xraf011 name="construct.a.page2.xraf011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf011
            #add-point:ON ACTION controlp INFIELD xraf011 name="construct.c.page2.xraf011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf012
            #add-point:BEFORE FIELD xraf012 name="construct.b.page2.xraf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf012
            
            #add-point:AFTER FIELD xraf012 name="construct.a.page2.xraf012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf012
            #add-point:ON ACTION controlp INFIELD xraf012 name="construct.c.page2.xraf012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf013
            #add-point:BEFORE FIELD xraf013 name="construct.b.page2.xraf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf013
            
            #add-point:AFTER FIELD xraf013 name="construct.a.page2.xraf013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf013
            #add-point:ON ACTION controlp INFIELD xraf013 name="construct.c.page2.xraf013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf014
            #add-point:BEFORE FIELD xraf014 name="construct.b.page2.xraf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf014
            
            #add-point:AFTER FIELD xraf014 name="construct.a.page2.xraf014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf014
            #add-point:ON ACTION controlp INFIELD xraf014 name="construct.c.page2.xraf014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf015
            #add-point:BEFORE FIELD xraf015 name="construct.b.page2.xraf015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf015
            
            #add-point:AFTER FIELD xraf015 name="construct.a.page2.xraf015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf015
            #add-point:ON ACTION controlp INFIELD xraf015 name="construct.c.page2.xraf015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf016
            #add-point:BEFORE FIELD xraf016 name="construct.b.page2.xraf016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf016
            
            #add-point:AFTER FIELD xraf016 name="construct.a.page2.xraf016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf016
            #add-point:ON ACTION controlp INFIELD xraf016 name="construct.c.page2.xraf016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf017
            #add-point:BEFORE FIELD xraf017 name="construct.b.page2.xraf017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf017
            
            #add-point:AFTER FIELD xraf017 name="construct.a.page2.xraf017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf017
            #add-point:ON ACTION controlp INFIELD xraf017 name="construct.c.page2.xraf017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf018
            #add-point:BEFORE FIELD xraf018 name="construct.b.page2.xraf018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf018
            
            #add-point:AFTER FIELD xraf018 name="construct.a.page2.xraf018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf018
            #add-point:ON ACTION controlp INFIELD xraf018 name="construct.c.page2.xraf018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf019
            #add-point:BEFORE FIELD xraf019 name="construct.b.page2.xraf019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf019
            
            #add-point:AFTER FIELD xraf019 name="construct.a.page2.xraf019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf019
            #add-point:ON ACTION controlp INFIELD xraf019 name="construct.c.page2.xraf019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf020
            #add-point:BEFORE FIELD xraf020 name="construct.b.page2.xraf020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf020
            
            #add-point:AFTER FIELD xraf020 name="construct.a.page2.xraf020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf020
            #add-point:ON ACTION controlp INFIELD xraf020 name="construct.c.page2.xraf020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf021
            #add-point:BEFORE FIELD xraf021 name="construct.b.page2.xraf021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf021
            
            #add-point:AFTER FIELD xraf021 name="construct.a.page2.xraf021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf021
            #add-point:ON ACTION controlp INFIELD xraf021 name="construct.c.page2.xraf021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf022
            #add-point:BEFORE FIELD xraf022 name="construct.b.page2.xraf022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf022
            
            #add-point:AFTER FIELD xraf022 name="construct.a.page2.xraf022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xraf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf022
            #add-point:ON ACTION controlp INFIELD xraf022 name="construct.c.page2.xraf022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD total_1
            #add-point:BEFORE FIELD total_1 name="construct.b.page2.total_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD total_1
            
            #add-point:AFTER FIELD total_1 name="construct.a.page2.total_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.total_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD total_1
            #add-point:ON ACTION controlp INFIELD total_1 name="construct.c.page2.total_1"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         LET g_xrae2_d[1].xraf002 = ""
         DISPLAY ARRAY g_xrae2_d TO s_detail2.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
            INITIALIZE g_wc2_table2 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "xrad_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xrae_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xraf_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
 
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
 
{<section id="axri014.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION axri014_filter()
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
      CONSTRUCT g_wc_filter ON xrad001
                          FROM s_browse[1].b_xrad001
 
         BEFORE CONSTRUCT
               DISPLAY axri014_filter_parser('xrad001') TO s_browse[1].b_xrad001
      
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
 
      CALL axri014_filter_show('xrad001')
 
END FUNCTION
 
{</section>}
 
{<section id="axri014.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION axri014_filter_parser(ps_field)
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
 
{<section id="axri014.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION axri014_filter_show(ps_field)
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
   LET ls_condition = axri014_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axri014.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axri014_query()
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
   CALL g_xrae_d.clear()
   CALL g_xrae2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axri014_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axri014_browser_fill("")
      CALL axri014_fetch("")
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
      CALL axri014_filter_show('xrad001')
   CALL axri014_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL axri014_fetch("F") 
      #顯示單身筆數
      CALL axri014_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axri014.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axri014_fetch(p_flag)
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
   
   LET g_xrad_m.xrad001 = g_browser[g_current_idx].b_xrad001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axri014_master_referesh USING g_xrad_m.xrad001 INTO g_xrad_m.xrad001,g_xrad_m.xrad004,g_xrad_m.xradstus, 
       g_xrad_m.xradownid,g_xrad_m.xradowndp,g_xrad_m.xradcrtid,g_xrad_m.xradcrtdp,g_xrad_m.xradcrtdt, 
       g_xrad_m.xradmodid,g_xrad_m.xradmoddt,g_xrad_m.xradownid_desc,g_xrad_m.xradowndp_desc,g_xrad_m.xradcrtid_desc, 
       g_xrad_m.xradcrtdp_desc,g_xrad_m.xradmodid_desc
   
   #遮罩相關處理
   LET g_xrad_m_mask_o.* =  g_xrad_m.*
   CALL axri014_xrad_t_mask()
   LET g_xrad_m_mask_n.* =  g_xrad_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axri014_set_act_visible()   
   CALL axri014_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xrad_m_t.* = g_xrad_m.*
   LET g_xrad_m_o.* = g_xrad_m.*
   
   LET g_data_owner = g_xrad_m.xradownid      
   LET g_data_dept  = g_xrad_m.xradowndp
   
   #重新顯示   
   CALL axri014_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axri014.insert" >}
#+ 資料新增
PRIVATE FUNCTION axri014_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xrae_d.clear()   
   CALL g_xrae2_d.clear()  
 
 
   INITIALIZE g_xrad_m.* TO NULL             #DEFAULT 設定
   
   LET g_xrad001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xrad_m.xradownid = g_user
      LET g_xrad_m.xradowndp = g_dept
      LET g_xrad_m.xradcrtid = g_user
      LET g_xrad_m.xradcrtdp = g_dept 
      LET g_xrad_m.xradcrtdt = cl_get_current()
      LET g_xrad_m.xradmodid = g_user
      LET g_xrad_m.xradmoddt = cl_get_current()
      LET g_xrad_m.xradstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_xrad_m.xrad004 = "1"
      LET g_xrad_m.xradstus = "Y"
 
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xrad_m_t.* = g_xrad_m.*
      LET g_xrad_m_o.* = g_xrad_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrad_m.xradstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL axri014_input("a")
      
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
         INITIALIZE g_xrad_m.* TO NULL
         INITIALIZE g_xrae_d TO NULL
         INITIALIZE g_xrae2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL axri014_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xrae_d.clear()
      #CALL g_xrae2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axri014_set_act_visible()   
   CALL axri014_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xrad001_t = g_xrad_m.xrad001
 
   
   #組合新增資料的條件
   LET g_add_browse = " xradent = " ||g_enterprise|| " AND",
                      " xrad001 = '", g_xrad_m.xrad001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axri014_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axri014_cl
   
   CALL axri014_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axri014_master_referesh USING g_xrad_m.xrad001 INTO g_xrad_m.xrad001,g_xrad_m.xrad004,g_xrad_m.xradstus, 
       g_xrad_m.xradownid,g_xrad_m.xradowndp,g_xrad_m.xradcrtid,g_xrad_m.xradcrtdp,g_xrad_m.xradcrtdt, 
       g_xrad_m.xradmodid,g_xrad_m.xradmoddt,g_xrad_m.xradownid_desc,g_xrad_m.xradowndp_desc,g_xrad_m.xradcrtid_desc, 
       g_xrad_m.xradcrtdp_desc,g_xrad_m.xradmodid_desc
   
   
   #遮罩相關處理
   LET g_xrad_m_mask_o.* =  g_xrad_m.*
   CALL axri014_xrad_t_mask()
   LET g_xrad_m_mask_n.* =  g_xrad_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xrad_m.xrad001,g_xrad_m.xradl003,g_xrad_m.xrad004,g_xrad_m.xradstus,g_xrad_m.xradownid, 
       g_xrad_m.xradownid_desc,g_xrad_m.xradowndp,g_xrad_m.xradowndp_desc,g_xrad_m.xradcrtid,g_xrad_m.xradcrtid_desc, 
       g_xrad_m.xradcrtdp,g_xrad_m.xradcrtdp_desc,g_xrad_m.xradcrtdt,g_xrad_m.xradmodid,g_xrad_m.xradmodid_desc, 
       g_xrad_m.xradmoddt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_xrad_m.xradownid      
   LET g_data_dept  = g_xrad_m.xradowndp
   
   #功能已完成,通報訊息中心
   CALL axri014_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axri014.modify" >}
#+ 資料修改
PRIVATE FUNCTION axri014_modify()
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
   LET g_xrad_m_t.* = g_xrad_m.*
   LET g_xrad_m_o.* = g_xrad_m.*
   
   IF g_xrad_m.xrad001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xrad001_t = g_xrad_m.xrad001
 
   CALL s_transaction_begin()
   
   OPEN axri014_cl USING g_enterprise,g_xrad_m.xrad001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axri014_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axri014_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axri014_master_referesh USING g_xrad_m.xrad001 INTO g_xrad_m.xrad001,g_xrad_m.xrad004,g_xrad_m.xradstus, 
       g_xrad_m.xradownid,g_xrad_m.xradowndp,g_xrad_m.xradcrtid,g_xrad_m.xradcrtdp,g_xrad_m.xradcrtdt, 
       g_xrad_m.xradmodid,g_xrad_m.xradmoddt,g_xrad_m.xradownid_desc,g_xrad_m.xradowndp_desc,g_xrad_m.xradcrtid_desc, 
       g_xrad_m.xradcrtdp_desc,g_xrad_m.xradmodid_desc
   
   #檢查是否允許此動作
   IF NOT axri014_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xrad_m_mask_o.* =  g_xrad_m.*
   CALL axri014_xrad_t_mask()
   LET g_xrad_m_mask_n.* =  g_xrad_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL axri014_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_xrad001_t = g_xrad_m.xrad001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_xrad_m.xradmodid = g_user 
LET g_xrad_m.xradmoddt = cl_get_current()
LET g_xrad_m.xradmodid_desc = cl_get_username(g_xrad_m.xradmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL axri014_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE xrad_t SET (xradmodid,xradmoddt) = (g_xrad_m.xradmodid,g_xrad_m.xradmoddt)
          WHERE xradent = g_enterprise AND xrad001 = g_xrad001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xrad_m.* = g_xrad_m_t.*
            CALL axri014_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xrad_m.xrad001 != g_xrad_m_t.xrad001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE xrae_t SET xrae001 = g_xrad_m.xrad001
 
          WHERE xraeent = g_enterprise AND xrae001 = g_xrad_m_t.xrad001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xrae_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrae_t:",SQLERRMESSAGE 
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
         
         UPDATE xraf_t
            SET xraf001 = g_xrad_m.xrad001
 
          WHERE xrafent = g_enterprise AND
                xraf001 = g_xrad001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xraf_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xraf_t:",SQLERRMESSAGE 
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
   CALL axri014_set_act_visible()   
   CALL axri014_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xradent = " ||g_enterprise|| " AND",
                      " xrad001 = '", g_xrad_m.xrad001, "' "
 
   #填到對應位置
   CALL axri014_browser_fill("")
 
   CLOSE axri014_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axri014_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="axri014.input" >}
#+ 資料輸入
PRIVATE FUNCTION axri014_input(p_cmd)
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
   DEFINE  l_sql           STRING
   DEFINE  l_n1            LIKE type_t.num5 
   DEFINE  l_total         LIKE type_t.num10 
   DEFINE  l_n2            LIKE type_t.num5
   DEFINE  l_n3            LIKE type_t.num5
   DEFINE  l_xrae005       LIKE xrae_t.xrae005
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
   DISPLAY BY NAME g_xrad_m.xrad001,g_xrad_m.xradl003,g_xrad_m.xrad004,g_xrad_m.xradstus,g_xrad_m.xradownid, 
       g_xrad_m.xradownid_desc,g_xrad_m.xradowndp,g_xrad_m.xradowndp_desc,g_xrad_m.xradcrtid,g_xrad_m.xradcrtid_desc, 
       g_xrad_m.xradcrtdp,g_xrad_m.xradcrtdp_desc,g_xrad_m.xradcrtdt,g_xrad_m.xradmodid,g_xrad_m.xradmodid_desc, 
       g_xrad_m.xradmoddt
   
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
   LET g_forupd_sql = "SELECT xrae002,xrae003,xrae004,xrae005 FROM xrae_t WHERE xraeent=? AND xrae001=?  
       AND xrae002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axri014_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT xraf002,xraf003,xraf004,xraf005,xraf006,xraf007,xraf008,xraf009,xraf010, 
       xraf011,xraf012,xraf013,xraf014,xraf015,xraf016,xraf017,xraf018,xraf019,xraf020,xraf021,xraf022  
       FROM xraf_t WHERE xrafent=? AND xraf001=? AND xraf002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axri014_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axri014_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axri014_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xrad_m.xrad001,g_xrad_m.xradl003,g_xrad_m.xrad004,g_xrad_m.xradstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axri014.input.head" >}
      #單頭段
      INPUT BY NAME g_xrad_m.xrad001,g_xrad_m.xradl003,g_xrad_m.xrad004,g_xrad_m.xradstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_xrad_m.xrad001)  THEN
                  CALL n_xradl(g_xrad_m.xrad001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_xrad_m.xrad001
                  CALL ap_ref_array2(g_ref_fields," SELECT xradl003 FROM xradl_t WHERE xradlent = '"
                      ||g_enterprise||"' AND xradl001 = ? AND xradl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_xrad_m.xradl003= g_rtn_fields[1]

                  DISPLAY BY NAME g_xrad_m.xradl003
               END IF
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axri014_cl USING g_enterprise,g_xrad_m.xrad001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axri014_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axri014_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.xradl001 = g_xrad_m.xrad001
LET g_master_multi_table_t.xradl003 = g_xrad_m.xradl003
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.xradl001 = ''
LET g_master_multi_table_t.xradl003 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL axri014_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            #161101-00009#1 Mark ---(S)---
           #IF l_cmd_t = 'r' THEN
           #   LET g_xrad_m.xrad001 = ''
           #   LET g_xrad_m.xradl003 = ''
           #   CALL cl_set_comp_entry("xrad002,xrad003,xrad004,xradstauts",FALSE) 
           #   CALL cl_set_comp_entry("xrae002,xrae003,xrae004,xrae005",FALSE)
           #   CALL cl_set_comp_entry("xraf002,xraf003,xraf004,xraf005,xraf006,xraf007,xraf008,xraf009,xraf010",FALSE)  
           #   CALL cl_set_comp_entry("xraf011,xraf012,xraf013,xraf014,xraf015,xraf016,xraf017,xraf018,xraf019,xraf020",FALSE)
           #   CALL cl_set_comp_entry("xraf021,xraf022,total_1",FALSE)
           #ELSE
           #   CALL cl_set_comp_entry("xrad002,xrad003,xrad004,xradstauts",TRUE) 
           #   CALL cl_set_comp_entry("xrae002,xrae003,xrae004,xrae005",TRUE)
           #   CALL cl_set_comp_entry("xraf002,xraf003,xraf004,xraf005,xraf006,xraf007,xraf008,xraf009,xraf010",TRUE)  
           #   CALL cl_set_comp_entry("xraf011,xraf012,xraf013,xraf014,xraf015,xraf016,xraf017,xraf018,xraf019,xraf020",TRUE)
           #   CALL cl_set_comp_entry("xraf021,xraf022,total_1",TRUE)              
           #END IF
            #161101-00009#1 Mark ---(E)---
            #end add-point
            CALL axri014_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrad001
            #add-point:BEFORE FIELD xrad001 name="input.b.xrad001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrad001
            
            #add-point:AFTER FIELD xrad001 name="input.a.xrad001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xrad_m.xrad001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xrad_m.xrad001 != g_xrad001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrad_t WHERE "||"xradent = '" ||g_enterprise|| "' AND "||"xrad001 = '"||g_xrad_m.xrad001 ||"'",'std-00004',0) THEN 
                     LET g_xrad_m.xrad001 = ''
                     LET g_xrad_m.xradl003 = ''
                     DISPLAY BY NAME g_xrad_m.xradl003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrad001
            #add-point:ON CHANGE xrad001 name="input.g.xrad001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xradl003
            #add-point:BEFORE FIELD xradl003 name="input.b.xradl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xradl003
            
            #add-point:AFTER FIELD xradl003 name="input.a.xradl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xradl003
            #add-point:ON CHANGE xradl003 name="input.g.xradl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrad004
            #add-point:BEFORE FIELD xrad004 name="input.b.xrad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrad004
            
            #add-point:AFTER FIELD xrad004 name="input.a.xrad004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrad004
            #add-point:ON CHANGE xrad004 name="input.g.xrad004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xradstus
            #add-point:BEFORE FIELD xradstus name="input.b.xradstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xradstus
            
            #add-point:AFTER FIELD xradstus name="input.a.xradstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xradstus
            #add-point:ON CHANGE xradstus name="input.g.xradstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xrad001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrad001
            #add-point:ON ACTION controlp INFIELD xrad001 name="input.c.xrad001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xradl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xradl003
            #add-point:ON ACTION controlp INFIELD xradl003 name="input.c.xradl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrad004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrad004
            #add-point:ON ACTION controlp INFIELD xrad004 name="input.c.xrad004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xradstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xradstus
            #add-point:ON ACTION controlp INFIELD xradstus name="input.c.xradstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xrad_m.xrad001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO xrad_t (xradent,xrad001,xrad004,xradstus,xradownid,xradowndp,xradcrtid,xradcrtdp, 
                   xradcrtdt,xradmodid,xradmoddt)
               VALUES (g_enterprise,g_xrad_m.xrad001,g_xrad_m.xrad004,g_xrad_m.xradstus,g_xrad_m.xradownid, 
                   g_xrad_m.xradowndp,g_xrad_m.xradcrtid,g_xrad_m.xradcrtdp,g_xrad_m.xradcrtdt,g_xrad_m.xradmodid, 
                   g_xrad_m.xradmoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xrad_m:",SQLERRMESSAGE 
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
         IF g_xrad_m.xrad001 = g_master_multi_table_t.xradl001 AND
         g_xrad_m.xradl003 = g_master_multi_table_t.xradl003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'xradlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_xrad_m.xrad001
            LET l_field_keys[02] = 'xradl001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.xradl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'xradl002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_xrad_m.xradl003
            LET l_fields[01] = 'xradl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xradl_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axri014_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axri014_b_fill()
                  CALL axri014_b_fill2('0')
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
               CALL axri014_xrad_t_mask_restore('restore_mask_o')
               
               UPDATE xrad_t SET (xrad001,xrad004,xradstus,xradownid,xradowndp,xradcrtid,xradcrtdp,xradcrtdt, 
                   xradmodid,xradmoddt) = (g_xrad_m.xrad001,g_xrad_m.xrad004,g_xrad_m.xradstus,g_xrad_m.xradownid, 
                   g_xrad_m.xradowndp,g_xrad_m.xradcrtid,g_xrad_m.xradcrtdp,g_xrad_m.xradcrtdt,g_xrad_m.xradmodid, 
                   g_xrad_m.xradmoddt)
                WHERE xradent = g_enterprise AND xrad001 = g_xrad001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xrad_t:",SQLERRMESSAGE 
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
         IF g_xrad_m.xrad001 = g_master_multi_table_t.xradl001 AND
         g_xrad_m.xradl003 = g_master_multi_table_t.xradl003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'xradlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_xrad_m.xrad001
            LET l_field_keys[02] = 'xradl001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.xradl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'xradl002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_xrad_m.xradl003
            LET l_fields[01] = 'xradl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xradl_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL axri014_xrad_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xrad_m_t)
               LET g_log2 = util.JSON.stringify(g_xrad_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xrad001_t = g_xrad_m.xrad001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axri014.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xrae_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xrae_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axri014_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xrae_d.getLength()
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
            OPEN axri014_cl USING g_enterprise,g_xrad_m.xrad001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axri014_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axri014_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xrae_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xrae_d[l_ac].xrae002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xrae_d_t.* = g_xrae_d[l_ac].*  #BACKUP
               LET g_xrae_d_o.* = g_xrae_d[l_ac].*  #BACKUP
               CALL axri014_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL axri014_set_no_entry_b(l_cmd)
               IF NOT axri014_lock_b("xrae_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axri014_bcl INTO g_xrae_d[l_ac].xrae002,g_xrae_d[l_ac].xrae003,g_xrae_d[l_ac].xrae004, 
                      g_xrae_d[l_ac].xrae005
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xrae_d_t.xrae002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrae_d_mask_o[l_ac].* =  g_xrae_d[l_ac].*
                  CALL axri014_xrae_t_mask()
                  LET g_xrae_d_mask_n[l_ac].* =  g_xrae_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axri014_show()
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
            INITIALIZE g_xrae_d[l_ac].* TO NULL 
            INITIALIZE g_xrae_d_t.* TO NULL 
            INITIALIZE g_xrae_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_xrae_d_t.* = g_xrae_d[l_ac].*     #新輸入資料
            LET g_xrae_d_o.* = g_xrae_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axri014_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL axri014_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrae_d[li_reproduce_target].* = g_xrae_d[li_reproduce].*
 
               LET g_xrae_d[li_reproduce_target].xrae002 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF l_cmd = 'a' THEN
                LET g_xrae_d[l_ac].xrae002 = ARR_COUNT()
                IF g_rec_b = 1 THEN
                   LET g_xrae_d[l_ac].xrae003 = 0
                ELSE
                   LET g_xrae_d[l_ac].xrae003 = g_xrae_d[l_ac-1].xrae004 + 1
                END IF
                CALL axri014_xrae002_chk()
            END IF
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
            SELECT COUNT(1) INTO l_count FROM xrae_t 
             WHERE xraeent = g_enterprise AND xrae001 = g_xrad_m.xrad001
 
               AND xrae002 = g_xrae_d[l_ac].xrae002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               CALL axri014_xrae002_chk()
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrad_m.xrad001
               LET gs_keys[2] = g_xrae_d[g_detail_idx].xrae002
               CALL axri014_insert_b('xrae_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xrae_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrae_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axri014_b_fill()
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
               LET gs_keys[01] = g_xrad_m.xrad001
 
               LET gs_keys[gs_keys.getLength()+1] = g_xrae_d_t.xrae002
 
            
               #刪除同層單身
               IF NOT axri014_delete_b('xrae_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axri014_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axri014_key_delete_b(gs_keys,'xrae_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axri014_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
                            
                      
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axri014_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_xrae_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xrae_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrae002
            #add-point:BEFORE FIELD xrae002 name="input.b.page1.xrae002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrae002
            
            #add-point:AFTER FIELD xrae002 name="input.a.page1.xrae002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xrad_m.xrad001) AND NOT cl_null(g_xrae_d[g_detail_idx].xrae002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xrad_m.xrad001 != g_xrad001_t OR g_xrae_d[g_detail_idx].xrae002 != g_xrae_d_t.xrae002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrae_t WHERE "||"xraeent = '" ||g_enterprise|| "' AND "||"xrae001 = '"||g_xrad_m.xrad001 ||"' AND "|| "xrae002 = '"||g_xrae_d[g_detail_idx].xrae002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF               
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrae002
            #add-point:ON CHANGE xrae002 name="input.g.page1.xrae002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrae003
            #add-point:BEFORE FIELD xrae003 name="input.b.page1.xrae003"
            IF g_xrae_d[l_ac].xrae002 >20 OR g_xrae_d[l_ac].xrae002 < 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00007'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xrae002
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrae003
            
            #add-point:AFTER FIELD xrae003 name="input.a.page1.xrae003"
            IF g_xrae_d[l_ac].xrae002 != 1 THEN   
               IF g_xrae_d[l_ac].xrae003 <= g_xrae_d[l_ac-1].xrae004 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00041'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD xrae003
               END IF
            END IF
            IF g_xrae_d[l_ac].xrae003 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aim-00009'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xrae003
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrae003
            #add-point:ON CHANGE xrae003 name="input.g.page1.xrae003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrae004
            #add-point:BEFORE FIELD xrae004 name="input.b.page1.xrae004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrae004
            
            #add-point:AFTER FIELD xrae004 name="input.a.page1.xrae004"
            IF NOT cl_null(g_xrae_d[l_ac].xrae002) AND NOT cl_null(g_xrae_d[l_ac].xrae003) AND cl_null(g_xrae_d[l_ac].xrae004) THEN
               LET g_xrae_d[l_ac].xrae004 = 9999
            END IF
            IF g_xrae_d[l_ac].xrae004 <= g_xrae_d[l_ac].xrae003 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00040'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xrae004
            END IF
            IF g_xrae_d[l_ac].xrae004 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aim-00009'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xrae004
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrae004
            #add-point:ON CHANGE xrae004 name="input.g.page1.xrae004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrae005
            #add-point:BEFORE FIELD xrae005 name="input.b.page1.xrae005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrae005
            
            #add-point:AFTER FIELD xrae005 name="input.a.page1.xrae005"
            IF g_xrae_d[l_ac].xrae005 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00096'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xrae005
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrae005
            #add-point:ON CHANGE xrae005 name="input.g.page1.xrae005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xrae002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrae002
            #add-point:ON ACTION controlp INFIELD xrae002 name="input.c.page1.xrae002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrae003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrae003
            #add-point:ON ACTION controlp INFIELD xrae003 name="input.c.page1.xrae003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrae004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrae004
            #add-point:ON ACTION controlp INFIELD xrae004 name="input.c.page1.xrae004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrae005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrae005
            #add-point:ON ACTION controlp INFIELD xrae005 name="input.c.page1.xrae005"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xrae_d[l_ac].* = g_xrae_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axri014_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xrae_d[l_ac].xrae002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xrae_d[l_ac].* = g_xrae_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL axri014_xrae_t_mask_restore('restore_mask_o')
      
               UPDATE xrae_t SET (xrae001,xrae002,xrae003,xrae004,xrae005) = (g_xrad_m.xrad001,g_xrae_d[l_ac].xrae002, 
                   g_xrae_d[l_ac].xrae003,g_xrae_d[l_ac].xrae004,g_xrae_d[l_ac].xrae005)
                WHERE xraeent = g_enterprise AND xrae001 = g_xrad_m.xrad001 
 
                  AND xrae002 = g_xrae_d_t.xrae002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xrae_d[l_ac].* = g_xrae_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrae_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xrae_d[l_ac].* = g_xrae_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrae_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrad_m.xrad001
               LET gs_keys_bak[1] = g_xrad001_t
               LET gs_keys[2] = g_xrae_d[g_detail_idx].xrae002
               LET gs_keys_bak[2] = g_xrae_d_t.xrae002
               CALL axri014_update_b('xrae_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL axri014_xrae_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xrae_d[g_detail_idx].xrae002 = g_xrae_d_t.xrae002 
 
                  ) THEN
                  LET gs_keys[01] = g_xrad_m.xrad001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xrae_d_t.xrae002
 
                  CALL axri014_key_update_b(gs_keys,'xrae_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xrad_m),util.JSON.stringify(g_xrae_d_t)
               LET g_log2 = util.JSON.stringify(g_xrad_m),util.JSON.stringify(g_xrae_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            LET l_sql = " UPDATE xrae_t SET xrae002 = (xrae002 - 1) ",
                        "  WHERE xraeent = '",g_enterprise,"' AND xrae001 = '",g_xrad_m.xrad001,"'",
                        "    AND xrae002 > '",g_xrae_d_t.xrae002,"'"
            PREPARE xrae_upd FROM l_sql
            EXECUTE xrae_upd  
            CALL axri014_b_fill()
            #end add-point
            CALL axri014_unlock_b("xrae_t","'1'")
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
               LET g_xrae_d[li_reproduce_target].* = g_xrae_d[li_reproduce].*
 
               LET g_xrae_d[li_reproduce_target].xrae002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrae_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrae_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_xrae2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xrae2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axri014_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xrae2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            CALL axri014_xraf_title()
           #2015/04/21 Mark ---(S)---
           #IF g_rec_b = l_ac AND g_rec_b<>1 THEN
           #   EXIT DIALOG
           #END IF
           #2015/04/21 Mark ---(E)---
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xrae2_d[l_ac].* TO NULL 
            INITIALIZE g_xrae2_d_t.* TO NULL 
            INITIALIZE g_xrae2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_xrae2_d_t.* = g_xrae2_d[l_ac].*     #新輸入資料
            LET g_xrae2_d_o.* = g_xrae2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axri014_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL axri014_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrae2_d[li_reproduce_target].* = g_xrae2_d[li_reproduce].*
 
               LET g_xrae2_d[li_reproduce_target].xraf002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            IF l_cmd = 'a' AND l_cmd_t <>'r' THEN
               SELECT COUNT(*) INTO l_n2 FROM xrae_t
                WHERE xraeent = g_enterprise AND xrae001 = g_xrad_m.xrad001
               FOR l_n3 = 3 TO l_n2 +2
                  SELECT xrae005 INTO l_xrae005 FROM xrae_t
                   WHERE xraeent = g_enterprise AND xrae001 = g_xrad_m.xrad001 AND xrae002 = l_n3-2
                  CASE l_n3-2
                     WHEN 1  LET g_xrae2_d[l_ac].xraf003 = l_xrae005
                     WHEN 2  LET g_xrae2_d[l_ac].xraf004 = l_xrae005
                     WHEN 3  LET g_xrae2_d[l_ac].xraf005 = l_xrae005
                     WHEN 4  LET g_xrae2_d[l_ac].xraf006 = l_xrae005
                     WHEN 5  LET g_xrae2_d[l_ac].xraf007 = l_xrae005
                     WHEN 6  LET g_xrae2_d[l_ac].xraf008 = l_xrae005
                     WHEN 7  LET g_xrae2_d[l_ac].xraf009 = l_xrae005
                     WHEN 8  LET g_xrae2_d[l_ac].xraf010 = l_xrae005
                     WHEN 9  LET g_xrae2_d[l_ac].xraf011 = l_xrae005
                     WHEN 10 LET g_xrae2_d[l_ac].xraf012 = l_xrae005
                     WHEN 13 LET g_xrae2_d[l_ac].xraf013 = l_xrae005
                     WHEN 14 LET g_xrae2_d[l_ac].xraf014 = l_xrae005
                     WHEN 15 LET g_xrae2_d[l_ac].xraf015 = l_xrae005
                     WHEN 16 LET g_xrae2_d[l_ac].xraf016 = l_xrae005
                     WHEN 17 LET g_xrae2_d[l_ac].xraf017 = l_xrae005
                     WHEN 18 LET g_xrae2_d[l_ac].xraf018 = l_xrae005
                     WHEN 19 LET g_xrae2_d[l_ac].xraf019 = l_xrae005
                     WHEN 20 LET g_xrae2_d[l_ac].xraf020 = l_xrae005
                     WHEN 19 LET g_xrae2_d[l_ac].xraf021 = l_xrae005
                     WHEN 20 LET g_xrae2_d[l_ac].xraf022 = l_xrae005
                  END CASE
               END FOR
            END IF
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axri014_cl USING g_enterprise,g_xrad_m.xrad001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axri014_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axri014_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xrae2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xrae2_d[l_ac].xraf002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xrae2_d_t.* = g_xrae2_d[l_ac].*  #BACKUP
               LET g_xrae2_d_o.* = g_xrae2_d[l_ac].*  #BACKUP
               CALL axri014_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
              #IF g_rec_b = l_ac AND g_rec_b<>1 THEN
              #   EXIT DIALOG
              #END IF
               #end add-point  
               CALL axri014_set_no_entry_b(l_cmd)
               IF NOT axri014_lock_b("xraf_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axri014_bcl2 INTO g_xrae2_d[l_ac].xraf002,g_xrae2_d[l_ac].xraf003,g_xrae2_d[l_ac].xraf004, 
                      g_xrae2_d[l_ac].xraf005,g_xrae2_d[l_ac].xraf006,g_xrae2_d[l_ac].xraf007,g_xrae2_d[l_ac].xraf008, 
                      g_xrae2_d[l_ac].xraf009,g_xrae2_d[l_ac].xraf010,g_xrae2_d[l_ac].xraf011,g_xrae2_d[l_ac].xraf012, 
                      g_xrae2_d[l_ac].xraf013,g_xrae2_d[l_ac].xraf014,g_xrae2_d[l_ac].xraf015,g_xrae2_d[l_ac].xraf016, 
                      g_xrae2_d[l_ac].xraf017,g_xrae2_d[l_ac].xraf018,g_xrae2_d[l_ac].xraf019,g_xrae2_d[l_ac].xraf020, 
                      g_xrae2_d[l_ac].xraf021,g_xrae2_d[l_ac].xraf022
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrae2_d_mask_o[l_ac].* =  g_xrae2_d[l_ac].*
                  CALL axri014_xraf_t_mask()
                  LET g_xrae2_d_mask_n[l_ac].* =  g_xrae2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axri014_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
           #IF g_rec_b = l_ac AND g_rec_b<>1 THEN
           #   EXIT DIALOG
           #END IF
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
               LET gs_keys[01] = g_xrad_m.xrad001
               LET gs_keys[gs_keys.getLength()+1] = g_xrae2_d_t.xraf002
            
               #刪除同層單身
               IF NOT axri014_delete_b('xraf_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axri014_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axri014_key_delete_b(gs_keys,'xraf_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axri014_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axri014_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_xrae_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xrae2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM xraf_t 
             WHERE xrafent = g_enterprise AND xraf001 = g_xrad_m.xrad001
               AND xraf002 = g_xrae2_d[l_ac].xraf002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrad_m.xrad001
               LET gs_keys[2] = g_xrae2_d[g_detail_idx].xraf002
               CALL axri014_insert_b('xraf_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xrae_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xraf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axri014_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xrae2_d[l_ac].* = g_xrae2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axri014_bcl2
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
               LET g_xrae2_d[l_ac].* = g_xrae2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
 
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL axri014_xraf_t_mask_restore('restore_mask_o')
                              
               UPDATE xraf_t SET (xraf001,xraf002,xraf003,xraf004,xraf005,xraf006,xraf007,xraf008,xraf009, 
                   xraf010,xraf011,xraf012,xraf013,xraf014,xraf015,xraf016,xraf017,xraf018,xraf019,xraf020, 
                   xraf021,xraf022) = (g_xrad_m.xrad001,g_xrae2_d[l_ac].xraf002,g_xrae2_d[l_ac].xraf003, 
                   g_xrae2_d[l_ac].xraf004,g_xrae2_d[l_ac].xraf005,g_xrae2_d[l_ac].xraf006,g_xrae2_d[l_ac].xraf007, 
                   g_xrae2_d[l_ac].xraf008,g_xrae2_d[l_ac].xraf009,g_xrae2_d[l_ac].xraf010,g_xrae2_d[l_ac].xraf011, 
                   g_xrae2_d[l_ac].xraf012,g_xrae2_d[l_ac].xraf013,g_xrae2_d[l_ac].xraf014,g_xrae2_d[l_ac].xraf015, 
                   g_xrae2_d[l_ac].xraf016,g_xrae2_d[l_ac].xraf017,g_xrae2_d[l_ac].xraf018,g_xrae2_d[l_ac].xraf019, 
                   g_xrae2_d[l_ac].xraf020,g_xrae2_d[l_ac].xraf021,g_xrae2_d[l_ac].xraf022) #自訂欄位頁簽 
 
                WHERE xrafent = g_enterprise AND xraf001 = g_xrad_m.xrad001
                  AND xraf002 = g_xrae2_d_t.xraf002 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xrae2_d[l_ac].* = g_xrae2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xraf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xrae2_d[l_ac].* = g_xrae2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xraf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrad_m.xrad001
               LET gs_keys_bak[1] = g_xrad001_t
               LET gs_keys[2] = g_xrae2_d[g_detail_idx].xraf002
               LET gs_keys_bak[2] = g_xrae2_d_t.xraf002
               CALL axri014_update_b('xraf_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axri014_xraf_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xrae2_d[g_detail_idx].xraf002 = g_xrae2_d_t.xraf002 
                  ) THEN
                  LET gs_keys[01] = g_xrad_m.xrad001
                  LET gs_keys[gs_keys.getLength()+1] = g_xrae2_d_t.xraf002
                  CALL axri014_key_update_b(gs_keys,'xraf_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xrad_m),util.JSON.stringify(g_xrae2_d_t)
               LET g_log2 = util.JSON.stringify(g_xrad_m),util.JSON.stringify(g_xrae2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf002
            
            #add-point:AFTER FIELD xraf002 name="input.a.page2.xraf002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xrad_m.xrad001) AND NOT cl_null(g_xrae2_d[g_detail_idx].xraf002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xrad_m.xrad001 != g_xrad001_t OR g_xrae2_d[g_detail_idx].xraf002 != g_xrae2_d_t.xraf002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xraf_t WHERE "||"xrafent = '" ||g_enterprise|| "' AND "||"xraf001 = '"||g_xrad_m.xrad001 ||"' AND "|| "xraf002 = '"||g_xrae2_d[g_detail_idx].xraf002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #IF NOT axri014_xraf002_chk(g_xrae2_d[g_detail_idx].xraf002) THEN
               #   LET g_xrae2_d[g_detail_idx].xraf002 = ''
               #   LET g_xrae2_d[g_detail_idx].xraf002_desc = ''
               #   DISPLAY g_xrae2_d[g_detail_idx].xraf002 TO xraf002
               #   NEXT FIELD xraf002
               #END IF
               #INITIALIZE g_ref_fields TO NULL
               #LET g_ref_fields[1] = g_xrae2_d[l_ac].xraf002
               #CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2054' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
               #LET g_xrae2_d[l_ac].xraf002_desc = '', g_rtn_fields[1] , ''
               #DISPLAY BY NAME g_xrae2_d[l_ac].xraf002_desc
            END IF

            IF NOT cl_null(g_xrae2_d[l_ac].xraf002) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xrae2_d[l_ac].xraf002

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xmaj001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xrae2_d[l_ac].xraf002 = g_xrae2_d_t.xraf002
                  CALL axri014_xraf002_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL axri014_xraf002_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf002
            #add-point:BEFORE FIELD xraf002 name="input.b.page2.xraf002"
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf002
            #add-point:ON CHANGE xraf002 name="input.g.page2.xraf002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf003
            #add-point:BEFORE FIELD xraf003 name="input.b.page2.xraf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf003
            
            #add-point:AFTER FIELD xraf003 name="input.a.page2.xraf003"
            IF g_xrae2_d[l_ac].xraf003 > 100 OR g_xrae2_d[l_ac].xraf003 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf003
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf003
            #add-point:ON CHANGE xraf003 name="input.g.page2.xraf003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf004
            #add-point:BEFORE FIELD xraf004 name="input.b.page2.xraf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf004
            
            #add-point:AFTER FIELD xraf004 name="input.a.page2.xraf004"
            IF g_xrae2_d[l_ac].xraf004 > 100 OR g_xrae2_d[l_ac].xraf004 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf004
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf004
            #add-point:ON CHANGE xraf004 name="input.g.page2.xraf004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf005
            #add-point:BEFORE FIELD xraf005 name="input.b.page2.xraf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf005
            
            #add-point:AFTER FIELD xraf005 name="input.a.page2.xraf005"
            IF g_xrae2_d[l_ac].xraf005 > 100 OR g_xrae2_d[l_ac].xraf005 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf005
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf005
            #add-point:ON CHANGE xraf005 name="input.g.page2.xraf005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf006
            #add-point:BEFORE FIELD xraf006 name="input.b.page2.xraf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf006
            
            #add-point:AFTER FIELD xraf006 name="input.a.page2.xraf006"
            IF g_xrae2_d[l_ac].xraf006 > 100 OR g_xrae2_d[l_ac].xraf006 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf006
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf006
            #add-point:ON CHANGE xraf006 name="input.g.page2.xraf006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf007
            #add-point:BEFORE FIELD xraf007 name="input.b.page2.xraf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf007
            
            #add-point:AFTER FIELD xraf007 name="input.a.page2.xraf007"
            IF g_xrae2_d[l_ac].xraf007 > 100 OR g_xrae2_d[l_ac].xraf007 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf007
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf007
            #add-point:ON CHANGE xraf007 name="input.g.page2.xraf007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf008
            #add-point:BEFORE FIELD xraf008 name="input.b.page2.xraf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf008
            
            #add-point:AFTER FIELD xraf008 name="input.a.page2.xraf008"
            IF g_xrae2_d[l_ac].xraf008 > 100 OR g_xrae2_d[l_ac].xraf008 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf008
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf008
            #add-point:ON CHANGE xraf008 name="input.g.page2.xraf008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf009
            #add-point:BEFORE FIELD xraf009 name="input.b.page2.xraf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf009
            
            #add-point:AFTER FIELD xraf009 name="input.a.page2.xraf009"
            IF g_xrae2_d[l_ac].xraf009 > 100 OR g_xrae2_d[l_ac].xraf009 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf009
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf009
            #add-point:ON CHANGE xraf009 name="input.g.page2.xraf009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf010
            #add-point:BEFORE FIELD xraf010 name="input.b.page2.xraf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf010
            
            #add-point:AFTER FIELD xraf010 name="input.a.page2.xraf010"
            IF g_xrae2_d[l_ac].xraf010 > 100 OR g_xrae2_d[l_ac].xraf010 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf010
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf010
            #add-point:ON CHANGE xraf010 name="input.g.page2.xraf010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf011
            #add-point:BEFORE FIELD xraf011 name="input.b.page2.xraf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf011
            
            #add-point:AFTER FIELD xraf011 name="input.a.page2.xraf011"
            IF g_xrae2_d[l_ac].xraf011 > 100 OR g_xrae2_d[l_ac].xraf011 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf011
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf011
            #add-point:ON CHANGE xraf011 name="input.g.page2.xraf011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf012
            #add-point:BEFORE FIELD xraf012 name="input.b.page2.xraf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf012
            
            #add-point:AFTER FIELD xraf012 name="input.a.page2.xraf012"
            IF g_xrae2_d[l_ac].xraf012 > 100 OR g_xrae2_d[l_ac].xraf012 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf012
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf012
            #add-point:ON CHANGE xraf012 name="input.g.page2.xraf012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf013
            #add-point:BEFORE FIELD xraf013 name="input.b.page2.xraf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf013
            
            #add-point:AFTER FIELD xraf013 name="input.a.page2.xraf013"
            IF g_xrae2_d[l_ac].xraf013 > 100 OR g_xrae2_d[l_ac].xraf013 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf013
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf013
            #add-point:ON CHANGE xraf013 name="input.g.page2.xraf013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf014
            #add-point:BEFORE FIELD xraf014 name="input.b.page2.xraf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf014
            
            #add-point:AFTER FIELD xraf014 name="input.a.page2.xraf014"
            IF g_xrae2_d[l_ac].xraf014 > 100 OR g_xrae2_d[l_ac].xraf014 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf014
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf014
            #add-point:ON CHANGE xraf014 name="input.g.page2.xraf014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf015
            #add-point:BEFORE FIELD xraf015 name="input.b.page2.xraf015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf015
            
            #add-point:AFTER FIELD xraf015 name="input.a.page2.xraf015"
            IF g_xrae2_d[l_ac].xraf015 > 100 OR g_xrae2_d[l_ac].xraf015 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf015
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf015
            #add-point:ON CHANGE xraf015 name="input.g.page2.xraf015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf016
            #add-point:BEFORE FIELD xraf016 name="input.b.page2.xraf016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf016
            
            #add-point:AFTER FIELD xraf016 name="input.a.page2.xraf016"
            IF g_xrae2_d[l_ac].xraf016 > 100 OR g_xrae2_d[l_ac].xraf016 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf016
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf016
            #add-point:ON CHANGE xraf016 name="input.g.page2.xraf016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf017
            #add-point:BEFORE FIELD xraf017 name="input.b.page2.xraf017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf017
            
            #add-point:AFTER FIELD xraf017 name="input.a.page2.xraf017"
            IF g_xrae2_d[l_ac].xraf017 > 100 OR g_xrae2_d[l_ac].xraf017 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf017
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf017
            #add-point:ON CHANGE xraf017 name="input.g.page2.xraf017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf018
            #add-point:BEFORE FIELD xraf018 name="input.b.page2.xraf018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf018
            
            #add-point:AFTER FIELD xraf018 name="input.a.page2.xraf018"
            IF g_xrae2_d[l_ac].xraf018 > 100 OR g_xrae2_d[l_ac].xraf018 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf018
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf018
            #add-point:ON CHANGE xraf018 name="input.g.page2.xraf018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf019
            #add-point:BEFORE FIELD xraf019 name="input.b.page2.xraf019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf019
            
            #add-point:AFTER FIELD xraf019 name="input.a.page2.xraf019"
            IF g_xrae2_d[l_ac].xraf019 > 100 OR g_xrae2_d[l_ac].xraf019 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf019
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf019
            #add-point:ON CHANGE xraf019 name="input.g.page2.xraf019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf020
            #add-point:BEFORE FIELD xraf020 name="input.b.page2.xraf020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf020
            
            #add-point:AFTER FIELD xraf020 name="input.a.page2.xraf020"
            IF g_xrae2_d[l_ac].xraf020 > 100 OR g_xrae2_d[l_ac].xraf020 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf020
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf020
            #add-point:ON CHANGE xraf020 name="input.g.page2.xraf020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf021
            #add-point:BEFORE FIELD xraf021 name="input.b.page2.xraf021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf021
            
            #add-point:AFTER FIELD xraf021 name="input.a.page2.xraf021"
            IF g_xrae2_d[l_ac].xraf021 > 100 OR g_xrae2_d[l_ac].xraf021 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf021
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf021
            #add-point:ON CHANGE xraf021 name="input.g.page2.xraf021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xraf022
            #add-point:BEFORE FIELD xraf022 name="input.b.page2.xraf022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xraf022
            
            #add-point:AFTER FIELD xraf022 name="input.a.page2.xraf022"
            IF g_xrae2_d[l_ac].xraf022 > 100 OR g_xrae2_d[l_ac].xraf022 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00043'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xraf022
            END IF
            IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
            IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
            LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                          + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                          + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                          + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
            LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&','%'
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xraf022
            #add-point:ON CHANGE xraf022 name="input.g.page2.xraf022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD total_1
            #add-point:BEFORE FIELD total_1 name="input.b.page2.total_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD total_1
            
            #add-point:AFTER FIELD total_1 name="input.a.page2.total_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE total_1
            #add-point:ON CHANGE total_1 name="input.g.page2.total_1"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.xraf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf002
            #add-point:ON ACTION controlp INFIELD xraf002 name="input.c.page2.xraf002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrae2_d[l_ac].xraf002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = ''

            CALL q_xmaj001()                                #呼叫開窗

            LET g_xrae2_d[l_ac].xraf002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xrae2_d[l_ac].xraf002 TO xraf002              #顯示到畫面上
            CALL axri014_xraf002_desc()
            NEXT FIELD xraf002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf003
            #add-point:ON ACTION controlp INFIELD xraf003 name="input.c.page2.xraf003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf004
            #add-point:ON ACTION controlp INFIELD xraf004 name="input.c.page2.xraf004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf005
            #add-point:ON ACTION controlp INFIELD xraf005 name="input.c.page2.xraf005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf006
            #add-point:ON ACTION controlp INFIELD xraf006 name="input.c.page2.xraf006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf007
            #add-point:ON ACTION controlp INFIELD xraf007 name="input.c.page2.xraf007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf008
            #add-point:ON ACTION controlp INFIELD xraf008 name="input.c.page2.xraf008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf009
            #add-point:ON ACTION controlp INFIELD xraf009 name="input.c.page2.xraf009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf010
            #add-point:ON ACTION controlp INFIELD xraf010 name="input.c.page2.xraf010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf011
            #add-point:ON ACTION controlp INFIELD xraf011 name="input.c.page2.xraf011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf012
            #add-point:ON ACTION controlp INFIELD xraf012 name="input.c.page2.xraf012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf013
            #add-point:ON ACTION controlp INFIELD xraf013 name="input.c.page2.xraf013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf014
            #add-point:ON ACTION controlp INFIELD xraf014 name="input.c.page2.xraf014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf015
            #add-point:ON ACTION controlp INFIELD xraf015 name="input.c.page2.xraf015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf016
            #add-point:ON ACTION controlp INFIELD xraf016 name="input.c.page2.xraf016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf017
            #add-point:ON ACTION controlp INFIELD xraf017 name="input.c.page2.xraf017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf018
            #add-point:ON ACTION controlp INFIELD xraf018 name="input.c.page2.xraf018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf019
            #add-point:ON ACTION controlp INFIELD xraf019 name="input.c.page2.xraf019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf020
            #add-point:ON ACTION controlp INFIELD xraf020 name="input.c.page2.xraf020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf021
            #add-point:ON ACTION controlp INFIELD xraf021 name="input.c.page2.xraf021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xraf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xraf022
            #add-point:ON ACTION controlp INFIELD xraf022 name="input.c.page2.xraf022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.total_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD total_1
            #add-point:ON ACTION controlp INFIELD total_1 name="input.c.page2.total_1"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xrae2_d[l_ac].* = g_xrae2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axri014_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axri014_unlock_b("xraf_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xrae2_d[li_reproduce_target].* = g_xrae2_d[li_reproduce].*
 
               LET g_xrae2_d[li_reproduce_target].xraf002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrae2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrae2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="axri014.input.other" >}
      
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
            NEXT FIELD xrad001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xrae002
               WHEN "s_detail2"
                  NEXT FIELD xraf002
 
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
 
{<section id="axri014.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axri014_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_total   LIKE type_t.num10
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axri014_b_fill() #單身填充
      CALL axri014_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axri014_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrad_m.xrad001
   CALL ap_ref_array2(g_ref_fields," SELECT xradl003 FROM xradl_t WHERE xradlent = '"||g_enterprise||"' AND xradl001 = ? AND xradl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_xrad_m.xradl003 = g_rtn_fields[1] 
   DISPLAY g_xrad_m.xradl003 TO xradl003
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrad_m.xradownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xrad_m.xradownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrad_m.xradownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrad_m.xradowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrad_m.xradowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrad_m.xradowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrad_m.xradcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xrad_m.xradcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrad_m.xradcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrad_m.xradcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrad_m.xradcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrad_m.xradcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrad_m.xradmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xrad_m.xradmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrad_m.xradmodid_desc

    CALL axri014_xraf_title()

   #end add-point
   
   #遮罩相關處理
   LET g_xrad_m_mask_o.* =  g_xrad_m.*
   CALL axri014_xrad_t_mask()
   LET g_xrad_m_mask_n.* =  g_xrad_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xrad_m.xrad001,g_xrad_m.xradl003,g_xrad_m.xrad004,g_xrad_m.xradstus,g_xrad_m.xradownid, 
       g_xrad_m.xradownid_desc,g_xrad_m.xradowndp,g_xrad_m.xradowndp_desc,g_xrad_m.xradcrtid,g_xrad_m.xradcrtid_desc, 
       g_xrad_m.xradcrtdp,g_xrad_m.xradcrtdp_desc,g_xrad_m.xradcrtdt,g_xrad_m.xradmodid,g_xrad_m.xradmodid_desc, 
       g_xrad_m.xradmoddt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrad_m.xradstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xrae_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xrae2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
 
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axri014_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axri014.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axri014_detail_show()
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
 
{<section id="axri014.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axri014_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xrad_t.xrad001 
   DEFINE l_oldno     LIKE xrad_t.xrad001 
 
   DEFINE l_master    RECORD LIKE xrad_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xrae_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xraf_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_xrad_m.xrad001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xrad001_t = g_xrad_m.xrad001
 
    
   LET g_xrad_m.xrad001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xrad_m.xradownid = g_user
      LET g_xrad_m.xradowndp = g_dept
      LET g_xrad_m.xradcrtid = g_user
      LET g_xrad_m.xradcrtdp = g_dept 
      LET g_xrad_m.xradcrtdt = cl_get_current()
      LET g_xrad_m.xradmodid = g_user
      LET g_xrad_m.xradmoddt = cl_get_current()
      LET g_xrad_m.xradstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrad_m.xradstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL axri014_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xrad_m.* TO NULL
      INITIALIZE g_xrae_d TO NULL
      INITIALIZE g_xrae2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL axri014_show()
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
   CALL axri014_set_act_visible()   
   CALL axri014_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xrad001_t = g_xrad_m.xrad001
 
   
   #組合新增資料的條件
   LET g_add_browse = " xradent = " ||g_enterprise|| " AND",
                      " xrad001 = '", g_xrad_m.xrad001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axri014_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL axri014_idx_chk()
   
   LET g_data_owner = g_xrad_m.xradownid      
   LET g_data_dept  = g_xrad_m.xradowndp
   
   #功能已完成,通報訊息中心
   CALL axri014_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="axri014.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axri014_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xrae_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xraf_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE l_n   LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axri014_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   LET g_xrad001_t = g_xrad_m_t.xrad001
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xrae_t
    WHERE xraeent = g_enterprise AND xrae001 = g_xrad001_t
 
    INTO TEMP axri014_detail
 
   #將key修正為調整後   
   UPDATE axri014_detail 
      #更新key欄位
      SET xrae001 = g_xrad_m.xrad001
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xrae_t SELECT * FROM axri014_detail
   
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
   DROP TABLE axri014_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xraf_t 
    WHERE xrafent = g_enterprise AND xraf001 = g_xrad001_t
 
    INTO TEMP axri014_detail
 
   #將key修正為調整後   
   UPDATE axri014_detail SET xraf001 = g_xrad_m.xrad001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xraf_t SELECT * FROM axri014_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   SELECT COUNT(*) INTO l_n from axri014_detail
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axri014_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xrad001_t = g_xrad_m.xrad001
 
   
END FUNCTION
 
{</section>}
 
{<section id="axri014.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axri014_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_n             LIKE type_t.num10  
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_xrad_m.xrad001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.xradl001 = g_xrad_m.xrad001
LET g_master_multi_table_t.xradl003 = g_xrad_m.xradl003
 
   
   CALL s_transaction_begin()
 
   OPEN axri014_cl USING g_enterprise,g_xrad_m.xrad001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axri014_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axri014_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axri014_master_referesh USING g_xrad_m.xrad001 INTO g_xrad_m.xrad001,g_xrad_m.xrad004,g_xrad_m.xradstus, 
       g_xrad_m.xradownid,g_xrad_m.xradowndp,g_xrad_m.xradcrtid,g_xrad_m.xradcrtdp,g_xrad_m.xradcrtdt, 
       g_xrad_m.xradmodid,g_xrad_m.xradmoddt,g_xrad_m.xradownid_desc,g_xrad_m.xradowndp_desc,g_xrad_m.xradcrtid_desc, 
       g_xrad_m.xradcrtdp_desc,g_xrad_m.xradmodid_desc
   
   
   #檢查是否允許此動作
   IF NOT axri014_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xrad_m_mask_o.* =  g_xrad_m.*
   CALL axri014_xrad_t_mask()
   LET g_xrad_m_mask_n.* =  g_xrad_m.*
   
   CALL axri014_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM glcb_t WHERE glcbent = g_enterprise AND glcb003 = g_xrad_m.xrad001
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axr-00044'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axri014_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xrad001_t = g_xrad_m.xrad001
 
 
      DELETE FROM xrad_t
       WHERE xradent = g_enterprise AND xrad001 = g_xrad_m.xrad001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xrad_m.xrad001,":",SQLERRMESSAGE  
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
      
      DELETE FROM xrae_t
       WHERE xraeent = g_enterprise AND xrae001 = g_xrad_m.xrad001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrae_t:",SQLERRMESSAGE 
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
      DELETE FROM xraf_t
       WHERE xrafent = g_enterprise AND
             xraf001 = g_xrad_m.xrad001
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xraf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      END IF
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xrad_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE axri014_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xrae_d.clear() 
      CALL g_xrae2_d.clear()       
 
     
      CALL axri014_ui_browser_refresh()  
      #CALL axri014_ui_headershow()  
      #CALL axri014_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'xradlent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.xradl001
   LET l_field_keys[02] = 'xradl001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xradl_t')
 
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL axri014_browser_fill("")
         CALL axri014_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axri014_cl
 
   #功能已完成,通報訊息中心
   CALL axri014_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axri014.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axri014_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_total    LIKE type_t.num10
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_xrae_d.clear()
   CALL g_xrae2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF axri014_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xrae002,xrae003,xrae004,xrae005  FROM xrae_t",   
                     " INNER JOIN xrad_t ON xradent = " ||g_enterprise|| " AND xrad001 = xrae001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE xraeent=? AND xrae001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xrae_t.xrae002"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axri014_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axri014_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xrad_m.xrad001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xrad_m.xrad001 INTO g_xrae_d[l_ac].xrae002,g_xrae_d[l_ac].xrae003, 
          g_xrae_d[l_ac].xrae004,g_xrae_d[l_ac].xrae005   #(ver:78)
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
    
   #判斷是否填充
   IF axri014_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xraf002,xraf003,xraf004,xraf005,xraf006,xraf007,xraf008,xraf009, 
             xraf010,xraf011,xraf012,xraf013,xraf014,xraf015,xraf016,xraf017,xraf018,xraf019,xraf020, 
             xraf021,xraf022 ,t1.oocql004 FROM xraf_t",   
                     " INNER JOIN  xrad_t ON xradent = " ||g_enterprise|| " AND xrad001 = xraf001 ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='2054' AND t1.oocql002=xraf002 AND t1.oocql003='"||g_dlang||"' ",
 
                     " WHERE xrafent=? AND xraf001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xraf_t.xraf002"
         
         #add-point:單身填充控制 name="b_fill.sql2"
        
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axri014_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR axri014_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_xrad_m.xrad001   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_xrad_m.xrad001 INTO g_xrae2_d[l_ac].xraf002,g_xrae2_d[l_ac].xraf003, 
          g_xrae2_d[l_ac].xraf004,g_xrae2_d[l_ac].xraf005,g_xrae2_d[l_ac].xraf006,g_xrae2_d[l_ac].xraf007, 
          g_xrae2_d[l_ac].xraf008,g_xrae2_d[l_ac].xraf009,g_xrae2_d[l_ac].xraf010,g_xrae2_d[l_ac].xraf011, 
          g_xrae2_d[l_ac].xraf012,g_xrae2_d[l_ac].xraf013,g_xrae2_d[l_ac].xraf014,g_xrae2_d[l_ac].xraf015, 
          g_xrae2_d[l_ac].xraf016,g_xrae2_d[l_ac].xraf017,g_xrae2_d[l_ac].xraf018,g_xrae2_d[l_ac].xraf019, 
          g_xrae2_d[l_ac].xraf020,g_xrae2_d[l_ac].xraf021,g_xrae2_d[l_ac].xraf022,g_xrae2_d[l_ac].xraf002_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         CALL axri014_xraf002_desc()
         IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
         IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
         LET l_total = g_xrae2_d[l_ac].xraf003 + g_xrae2_d[l_ac].xraf004 + g_xrae2_d[l_ac].xraf005 + g_xrae2_d[l_ac].xraf006 + g_xrae2_d[l_ac].xraf007 + g_xrae2_d[l_ac].xraf008
                                       + g_xrae2_d[l_ac].xraf009 + g_xrae2_d[l_ac].xraf010 + g_xrae2_d[l_ac].xraf011 + g_xrae2_d[l_ac].xraf012 + g_xrae2_d[l_ac].xraf013 + g_xrae2_d[l_ac].xraf014
                                       + g_xrae2_d[l_ac].xraf015 + g_xrae2_d[l_ac].xraf016 + g_xrae2_d[l_ac].xraf017 + g_xrae2_d[l_ac].xraf018 + g_xrae2_d[l_ac].xraf019 + g_xrae2_d[l_ac].xraf020
                                       + g_xrae2_d[l_ac].xraf021 + g_xrae2_d[l_ac].xraf022
         LET g_xrae2_d[l_ac].total_1 = l_total USING '##&.&&'
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
#   SELECT SUM(xraf003),SUM(xraf004),SUM(xraf005),SUM(xraf006),SUM(xraf007),SUM(xraf008),SUM(xraf009),
#          SUM(xraf010),SUM(xraf011),SUM(xraf012),SUM(xraf013),SUM(xraf014),SUM(xraf015),SUM(xraf016),
#          SUM(xraf017),SUM(xraf018),SUM(xraf019),SUM(xraf020),SUM(xraf021),SUM(xraf022)
#     INTO g_xrae2_d[l_ac].xraf003,g_xrae2_d[l_ac].xraf004,g_xrae2_d[l_ac].xraf005,g_xrae2_d[l_ac].xraf006,
#          g_xrae2_d[l_ac].xraf007,g_xrae2_d[l_ac].xraf008,g_xrae2_d[l_ac].xraf009,g_xrae2_d[l_ac].xraf010,
#          g_xrae2_d[l_ac].xraf011,g_xrae2_d[l_ac].xraf012,g_xrae2_d[l_ac].xraf013,g_xrae2_d[l_ac].xraf014,
#          g_xrae2_d[l_ac].xraf015,g_xrae2_d[l_ac].xraf016,g_xrae2_d[l_ac].xraf017,g_xrae2_d[l_ac].xraf018,
#          g_xrae2_d[l_ac].xraf019,g_xrae2_d[l_ac].xraf020,g_xrae2_d[l_ac].xraf021,g_xrae2_d[l_ac].xraf022          
#     FROM xraf_t
#    WHERE xrafent = g_enterprise AND xraf001 = g_xrad_m.xrad001
#   IF l_ac<> 1 THEN
#      IF cl_null(g_xrae2_d[l_ac].xraf003) THEN LET g_xrae2_d[l_ac].xraf003 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf004) THEN LET g_xrae2_d[l_ac].xraf004 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf005) THEN LET g_xrae2_d[l_ac].xraf005 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf006) THEN LET g_xrae2_d[l_ac].xraf006 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf007) THEN LET g_xrae2_d[l_ac].xraf007 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf008) THEN LET g_xrae2_d[l_ac].xraf008 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf009) THEN LET g_xrae2_d[l_ac].xraf009 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf010) THEN LET g_xrae2_d[l_ac].xraf010 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf011) THEN LET g_xrae2_d[l_ac].xraf011 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf012) THEN LET g_xrae2_d[l_ac].xraf012 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf013) THEN LET g_xrae2_d[l_ac].xraf013 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf014) THEN LET g_xrae2_d[l_ac].xraf014 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf015) THEN LET g_xrae2_d[l_ac].xraf015 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf016) THEN LET g_xrae2_d[l_ac].xraf016 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf017) THEN LET g_xrae2_d[l_ac].xraf017 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf018) THEN LET g_xrae2_d[l_ac].xraf018 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf019) THEN LET g_xrae2_d[l_ac].xraf019 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf020) THEN LET g_xrae2_d[l_ac].xraf020 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf021) THEN LET g_xrae2_d[l_ac].xraf021 = 0 END IF
#      IF cl_null(g_xrae2_d[l_ac].xraf022) THEN LET g_xrae2_d[l_ac].xraf022 = 0 END IF
#      CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xrae2_d[l_ac].xraf002
#      LET g_xrae2_d[l_ac+1].xraf003 = g_xrae2_d[l_ac].xraf003
#   END IF
   
   
   #end add-point
   
   CALL g_xrae_d.deleteElement(g_xrae_d.getLength())
   CALL g_xrae2_d.deleteElement(g_xrae2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axri014_pb
   FREE axri014_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xrae_d.getLength()
      LET g_xrae_d_mask_o[l_ac].* =  g_xrae_d[l_ac].*
      CALL axri014_xrae_t_mask()
      LET g_xrae_d_mask_n[l_ac].* =  g_xrae_d[l_ac].*
   END FOR
   
   LET g_xrae2_d_mask_o.* =  g_xrae2_d.*
   FOR l_ac = 1 TO g_xrae2_d.getLength()
      LET g_xrae2_d_mask_o[l_ac].* =  g_xrae2_d[l_ac].*
      CALL axri014_xraf_t_mask()
      LET g_xrae2_d_mask_n[l_ac].* =  g_xrae2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="axri014.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axri014_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM xrae_t
       WHERE xraeent = g_enterprise AND
         xrae001 = ps_keys_bak[1] AND xrae002 = ps_keys_bak[2]
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
         CALL g_xrae_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM xraf_t
       WHERE xrafent = g_enterprise AND
             xraf001 = ps_keys_bak[1] AND xraf002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xraf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xrae2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axri014.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axri014_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO xrae_t
                  (xraeent,
                   xrae001,
                   xrae002
                   ,xrae003,xrae004,xrae005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xrae_d[g_detail_idx].xrae003,g_xrae_d[g_detail_idx].xrae004,g_xrae_d[g_detail_idx].xrae005) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrae_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xrae_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO xraf_t
                  (xrafent,
                   xraf001,
                   xraf002
                   ,xraf003,xraf004,xraf005,xraf006,xraf007,xraf008,xraf009,xraf010,xraf011,xraf012,xraf013,xraf014,xraf015,xraf016,xraf017,xraf018,xraf019,xraf020,xraf021,xraf022) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xrae2_d[g_detail_idx].xraf003,g_xrae2_d[g_detail_idx].xraf004,g_xrae2_d[g_detail_idx].xraf005, 
                       g_xrae2_d[g_detail_idx].xraf006,g_xrae2_d[g_detail_idx].xraf007,g_xrae2_d[g_detail_idx].xraf008, 
                       g_xrae2_d[g_detail_idx].xraf009,g_xrae2_d[g_detail_idx].xraf010,g_xrae2_d[g_detail_idx].xraf011, 
                       g_xrae2_d[g_detail_idx].xraf012,g_xrae2_d[g_detail_idx].xraf013,g_xrae2_d[g_detail_idx].xraf014, 
                       g_xrae2_d[g_detail_idx].xraf015,g_xrae2_d[g_detail_idx].xraf016,g_xrae2_d[g_detail_idx].xraf017, 
                       g_xrae2_d[g_detail_idx].xraf018,g_xrae2_d[g_detail_idx].xraf019,g_xrae2_d[g_detail_idx].xraf020, 
                       g_xrae2_d[g_detail_idx].xraf021,g_xrae2_d[g_detail_idx].xraf022)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xraf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xrae2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axri014.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axri014_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xrae_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL axri014_xrae_t_mask_restore('restore_mask_o')
               
      UPDATE xrae_t 
         SET (xrae001,
              xrae002
              ,xrae003,xrae004,xrae005) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xrae_d[g_detail_idx].xrae003,g_xrae_d[g_detail_idx].xrae004,g_xrae_d[g_detail_idx].xrae005)  
 
         WHERE xraeent = g_enterprise AND xrae001 = ps_keys_bak[1] AND xrae002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrae_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrae_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axri014_xrae_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xraf_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL axri014_xraf_t_mask_restore('restore_mask_o')
               
      UPDATE xraf_t 
         SET (xraf001,
              xraf002
              ,xraf003,xraf004,xraf005,xraf006,xraf007,xraf008,xraf009,xraf010,xraf011,xraf012,xraf013,xraf014,xraf015,xraf016,xraf017,xraf018,xraf019,xraf020,xraf021,xraf022) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xrae2_d[g_detail_idx].xraf003,g_xrae2_d[g_detail_idx].xraf004,g_xrae2_d[g_detail_idx].xraf005, 
                  g_xrae2_d[g_detail_idx].xraf006,g_xrae2_d[g_detail_idx].xraf007,g_xrae2_d[g_detail_idx].xraf008, 
                  g_xrae2_d[g_detail_idx].xraf009,g_xrae2_d[g_detail_idx].xraf010,g_xrae2_d[g_detail_idx].xraf011, 
                  g_xrae2_d[g_detail_idx].xraf012,g_xrae2_d[g_detail_idx].xraf013,g_xrae2_d[g_detail_idx].xraf014, 
                  g_xrae2_d[g_detail_idx].xraf015,g_xrae2_d[g_detail_idx].xraf016,g_xrae2_d[g_detail_idx].xraf017, 
                  g_xrae2_d[g_detail_idx].xraf018,g_xrae2_d[g_detail_idx].xraf019,g_xrae2_d[g_detail_idx].xraf020, 
                  g_xrae2_d[g_detail_idx].xraf021,g_xrae2_d[g_detail_idx].xraf022) 
         WHERE xrafent = g_enterprise AND xraf001 = ps_keys_bak[1] AND xraf002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xraf_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xraf_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axri014_xraf_t_mask_restore('restore_mask_n')
 
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
 
{<section id="axri014.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axri014_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="axri014.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axri014_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axri014.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axri014_lock_b(ps_table,ps_page)
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
   #CALL axri014_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "xrae_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axri014_bcl USING g_enterprise,
                                       g_xrad_m.xrad001,g_xrae_d[g_detail_idx].xrae002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axri014_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "xraf_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axri014_bcl2 USING g_enterprise,
                                             g_xrad_m.xrad001,g_xrae2_d[g_detail_idx].xraf002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axri014_bcl2:",SQLERRMESSAGE 
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
 
{<section id="axri014.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axri014_unlock_b(ps_table,ps_page)
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
      CLOSE axri014_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axri014_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axri014.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axri014_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xrad001",TRUE)
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
 
{<section id="axri014.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axri014_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xrad001",FALSE)
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
 
{<section id="axri014.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axri014_set_entry_b(p_cmd)
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
 
{<section id="axri014.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axri014_set_no_entry_b(p_cmd)
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
 
{<section id="axri014.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axri014_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axri014.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axri014_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axri014.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axri014_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axri014.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axri014_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axri014.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axri014_default_search()
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
      LET ls_wc = ls_wc, " xrad001 = '", g_argv[01], "' AND "
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
         INITIALIZE g_wc2_table2 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "xrad_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xrae_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xraf_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
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
 
{<section id="axri014.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION axri014_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_n      LIKE type_t.num10
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xrad_m.xrad001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN axri014_cl USING g_enterprise,g_xrad_m.xrad001
   IF STATUS THEN
      CLOSE axri014_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axri014_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE axri014_master_referesh USING g_xrad_m.xrad001 INTO g_xrad_m.xrad001,g_xrad_m.xrad004,g_xrad_m.xradstus, 
       g_xrad_m.xradownid,g_xrad_m.xradowndp,g_xrad_m.xradcrtid,g_xrad_m.xradcrtdp,g_xrad_m.xradcrtdt, 
       g_xrad_m.xradmodid,g_xrad_m.xradmoddt,g_xrad_m.xradownid_desc,g_xrad_m.xradowndp_desc,g_xrad_m.xradcrtid_desc, 
       g_xrad_m.xradcrtdp_desc,g_xrad_m.xradmodid_desc
   
 
   #檢查是否允許此動作
   IF NOT axri014_action_chk() THEN
      CLOSE axri014_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xrad_m.xrad001,g_xrad_m.xradl003,g_xrad_m.xrad004,g_xrad_m.xradstus,g_xrad_m.xradownid, 
       g_xrad_m.xradownid_desc,g_xrad_m.xradowndp,g_xrad_m.xradowndp_desc,g_xrad_m.xradcrtid,g_xrad_m.xradcrtid_desc, 
       g_xrad_m.xradcrtdp,g_xrad_m.xradcrtdp_desc,g_xrad_m.xradcrtdt,g_xrad_m.xradmodid,g_xrad_m.xradmodid_desc, 
       g_xrad_m.xradmoddt
 
   CASE g_xrad_m.xradstus
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
         CASE g_xrad_m.xradstus
            
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
         LET l_n = 0
         SELECT COUNT(*) INTO l_n FROM glcb_t WHERE glcbent = g_enterprise AND glcb003 = g_xrad_m.xrad001
         IF l_n > 0 THEN
            IF cl_ask_confirm('axr-00045') THEN
            ELSE
               RETURN
            END IF
         END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
         CALL cl_ask_pressanykey('axr-00046')
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
      g_xrad_m.xradstus = lc_state OR cl_null(lc_state) THEN
      CLOSE axri014_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_xrad_m.xradmodid = g_user
   LET g_xrad_m.xradmoddt = cl_get_current()
   LET g_xrad_m.xradstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xrad_t 
      SET (xradstus,xradmodid,xradmoddt) 
        = (g_xrad_m.xradstus,g_xrad_m.xradmodid,g_xrad_m.xradmoddt)     
    WHERE xradent = g_enterprise AND xrad001 = g_xrad_m.xrad001
 
    
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
      EXECUTE axri014_master_referesh USING g_xrad_m.xrad001 INTO g_xrad_m.xrad001,g_xrad_m.xrad004, 
          g_xrad_m.xradstus,g_xrad_m.xradownid,g_xrad_m.xradowndp,g_xrad_m.xradcrtid,g_xrad_m.xradcrtdp, 
          g_xrad_m.xradcrtdt,g_xrad_m.xradmodid,g_xrad_m.xradmoddt,g_xrad_m.xradownid_desc,g_xrad_m.xradowndp_desc, 
          g_xrad_m.xradcrtid_desc,g_xrad_m.xradcrtdp_desc,g_xrad_m.xradmodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xrad_m.xrad001,g_xrad_m.xradl003,g_xrad_m.xrad004,g_xrad_m.xradstus,g_xrad_m.xradownid, 
          g_xrad_m.xradownid_desc,g_xrad_m.xradowndp,g_xrad_m.xradowndp_desc,g_xrad_m.xradcrtid,g_xrad_m.xradcrtid_desc, 
          g_xrad_m.xradcrtdp,g_xrad_m.xradcrtdp_desc,g_xrad_m.xradcrtdt,g_xrad_m.xradmodid,g_xrad_m.xradmodid_desc, 
          g_xrad_m.xradmoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE axri014_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axri014_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axri014.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axri014_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xrae_d.getLength() THEN
         LET g_detail_idx = g_xrae_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xrae_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xrae_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xrae2_d.getLength() THEN
         LET g_detail_idx = g_xrae2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xrae2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xrae2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axri014.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axri014_b_fill2(pi_idx)
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
   
   CALL axri014_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="axri014.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axri014_fill_chk(ps_idx)
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
 
{<section id="axri014.status_show" >}
PRIVATE FUNCTION axri014_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axri014.mask_functions" >}
&include "erp/axr/axri014_mask.4gl"
 
{</section>}
 
{<section id="axri014.signature" >}
   
 
{</section>}
 
{<section id="axri014.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axri014_set_pk_array()
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
   LET g_pk_array[1].values = g_xrad_m.xrad001
   LET g_pk_array[1].column = 'xrad001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axri014.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axri014.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axri014_msgcentre_notify(lc_state)
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
   CALL axri014_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xrad_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axri014.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axri014_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axri014.other_function" readonly="Y" >}
#
PRIVATE FUNCTION axri014_s01(p_xrad001)
   DEFINE p_xrad001      LIKE xrad_t.xrad001
   DEFINE l_xradl003     LIKE type_t.chr80
   
   OPEN WINDOW w_axri014_s01 WITH FORM cl_ap_formpath("axr","axri014_s01")
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_xrae_s.xrae001,g_xrae_s.xrae002_2,g_xrae_s.xrae003_2,g_xrae_s.xrae005
         BEFORE INPUT
           LET g_xrae_s.xrae001 = p_xrad001
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_xrae_s.xrae001
           CALL ap_ref_array2(g_ref_fields," SELECT xradl003 FROM xradl_t WHERE xradlent = '"||g_enterprise||"' AND xradl001 = ? AND xradl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
           LET l_xradl003 = g_xrae_s.xrae001
           LET g_xrae_s.xrae001 = g_xrae_s.xrae001,'(',g_rtn_fields[1],')'
           DISPLAY BY NAME g_xrae_s.xrae001 
          #LET g_xrae_s.xrae001 = l_xradl003
           
         AFTER FIELD xrae002_2
            IF g_xrae_s.xrae002_2 >20 OR g_xrae_s.xrae002_2 < 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00007'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xrae002_2
            END IF

         AFTER FIELD xrae003_2
            IF g_xrae_s.xrae003_2 >365 OR g_xrae_s.xrae003_2 < 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00042'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xrae003_2
            END IF

         AFTER FIELD xrae005
            IF g_xrae_s.xrae005 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00096'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD xrae005
            END IF


         AFTER INPUT
            CALL axri014_xrae(p_xrad001,g_xrae_s.xrae002_2,g_xrae_s.xrae003_2,g_xrae_s.xrae005)

      END INPUT

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG
      
      ON ACTION produce
         ACCEPT DIALOG

      ON ACTION off
         LET INT_FLAG = TRUE
         EXIT DIALOG


   END DIALOG

   



      #畫面關閉
      CLOSE WINDOW w_axri014_s01
END FUNCTION
#段次欄位檢查
PRIVATE FUNCTION axri014_xrae002_chk()
DEFINE l_xrae002    LIKE xrae_t.xrae002

   SELECT MAX(xrae002) INTO l_xrae002 FROM xrae_t WHERE xrae001 = g_xrad_m.xrad001 AND xraeent = g_enterprise
   
   IF l_xrae002 > 20 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00038'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   
END FUNCTION
#信評等級設定欄位Title帶值
PRIVATE FUNCTION axri014_xraf_title()
DEFINE l_n        LIKE type_t.num5
DEFINE l_n1       LIKE type_t.num5
DEFINE l_n2       LIKE type_t.num5
DEFINE l_n3       LIKE type_t.num5
DEFINE l_field    STRING
DEFINE l_str      STRING
DEFINE l_xrae003  LIKE xrae_t.xrae003
DEFINE l_xrae004  LIKE xrae_t.xrae004

   CALL cl_set_comp_visible('xraf003,xraf004,xraf005,xraf006,xraf007,xraf008,xraf009,xraf010,xraf011,xraf012',TRUE)
   CALL cl_set_comp_visible('xraf013,xraf014,xraf015,xraf016,xraf017,xraf018,xraf019,xraf020,xraf021,xraf022',TRUE)
   SELECT COUNT(*) INTO l_n FROM xrae_t
    WHERE xraeent = g_enterprise AND xrae001 = g_xrad_m.xrad001
   FOR l_n1 = 3 TO l_n +2
      LET l_field = ''
      IF l_n1 < 10 THEN         
         LET l_field = 0,l_n1 USING '<<'   
      ELSE
         LET l_field = l_n1 USING '<<'
      END IF   
      LET l_field = l_field.trim()
      LET l_field = "xraf0",l_field       
      LET l_field = l_field.trim()
      SELECT xrae003,xrae004 INTO l_xrae003,l_xrae004 FROM xrae_t
       WHERE xraeent = g_enterprise AND xrae001 = g_xrad_m.xrad001 AND xrae002 = l_n1-2
      LET l_str = l_xrae003||'~'||l_xrae004||'天'||'期(%)'
      CALL cl_set_comp_att_text(l_field,l_str)
   END FOR
 
   LET l_n3 = l_n +3
   FOR l_n2 = l_n3 TO 22
       LET l_field = ''
      IF l_n2 < 10 THEN         
         LET l_field = 0,l_n2 USING '<<'   
      ELSE
         LET l_field = l_n2 USING '<<'
      END IF   
      LET l_field = l_field.trim()
      LET l_field = "xraf0",l_field
      LET l_field = l_field.trim()
      
      CALL cl_set_comp_visible(l_field,FALSE)
   END FOR 
END FUNCTION
#
PRIVATE FUNCTION axri014_xrae(p_xrad001,p_xrae002,p_xrae003,p_xrae005)
   DEFINE p_xrad001 LIKE xrad_t.xrad001   #賬齡類型編號
   DEFINE p_xrae002 LIKE xrae_t.xrae002   #產生段次數
   DEFINE p_xrae003 LIKE xrae_t.xrae003   #間隔天數
   DEFINE p_xrae005 LIKE xrae_t.xrae005   #預設還帳準備提利率
   DEFINE l_success LIKE type_t.chr1
   #161128-00061#3-----modify--begin----------
   #DEFINE l_xrae    RECORD LIKE xrae_t.*
   DEFINE l_xrae RECORD  #帳齡類型天數分段檔
       xraeent LIKE xrae_t.xraeent, #企業編號
       xrae001 LIKE xrae_t.xrae001, #帳齡類型編號
       xrae002 LIKE xrae_t.xrae002, #分段序號
       xrae003 LIKE xrae_t.xrae003, #起始天數
       xrae004 LIKE xrae_t.xrae004, #截止天數
       xrae005 LIKE xrae_t.xrae005  #慣用壞帳提列率
       END RECORD

   #161128-00061#3-----modify--end----------
   DEFINE l_n       LIKE type_t.num10  

#初始化
   LET l_success = 'Y'
   INITIALIZE l_xrae.* TO NULL

  #為空，則RETURN
   IF cl_null(p_xrad001) OR cl_null(p_xrae002) OR cl_null(p_xrae003) OR cl_null(p_xrae005) THEN
      RETURN
   END IF

#啟用事務
   CALL s_transaction_begin()

   #開始插入操作
      FOR l_n = 1 TO p_xrae002
        LET l_xrae.xrae002 = l_n 
        IF l_n = 1 THEN 
           LET l_xrae.xrae003 = 0
           LET l_xrae.xrae004 = p_xrae003
           LET l_xrae.xrae005 = p_xrae005
        ELSE
           LET l_xrae.xrae003 = l_xrae.xrae004 + 1 
           LET l_xrae.xrae004 = l_xrae.xrae003 + p_xrae003 - 1
           LET l_xrae.xrae005 = p_xrae005
        END IF
        
        #插入數據庫操作
         INSERT INTO xrae_t(xraeent,xrae001,xrae002,xrae003,xrae004,xrae005)
                  VALUES(g_enterprise,p_xrad001,l_xrae.xrae002,l_xrae.xrae003,l_xrae.xrae004,p_xrae005)
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
           #CALL cl_err("ins xrae_t",SQLCA.sqlcode,1)
            LET l_success = 'N'
            EXIT FOR 
         END IF
      END FOR

      #更新最後一筆資料的截止天數为9999
      UPDATE xrae_t SET xrae004 = 9999
       WHERE xraeent = g_enterprise
         AND xrae001 = p_xrad001
         AND xrae002 = l_xrae.xrae002

#結束事務
   CALL s_transaction_end(l_success,1)
END FUNCTION
#有效性及存在性檢查
PRIVATE FUNCTION axri014_xraf002_chk(p_xraf002)
   DEFINE p_xraf002 LIKE xraf_t.xraf002
   DEFINE r_success LIKE type_t.num5

   LET r_success = TRUE

   IF r_success THEN
      IF NOT ap_chk_isExist(p_xraf002,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '"
#         ||g_enterprise||"'  AND oocq001 = '2054' AND oocq002 = ? ",'apm-00056',0 ) THEN    #160318-00005#50  mark
         ||g_enterprise||"'  AND oocq001 = '2054' AND oocq002 = ? ",'sub-01303','apmi051') THEN     #160318-00005#50  add
         LET r_success = FALSE
      END IF
   END IF
   IF r_success THEN
      IF NOT ap_chk_isExist(p_xraf002,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '"
#         ||g_enterprise||"'  AND oocq001 = '2054' AND oocq002 = ? AND oocqstus = 'Y' ",'apm-00057',0 ) THEN   #160318-00005#50  mark
         ||g_enterprise||"'  AND oocq001 = '2054' AND oocq002 = ? AND oocqstus = 'Y' ",'sub-01302','apmi051') THEN    #160318-00005#50  add
         LET r_success = FALSE
      END IF
   END IF

   RETURN r_success
END FUNCTION
# 信評等級說明
PRIVATE FUNCTION axri014_xraf002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrae2_d[l_ac].xraf002
   CALL ap_ref_array2(g_ref_fields,"SELECT xmajl003 FROM xmajl_t WHERE xmajlent='"||g_enterprise||"' AND xmajl001=?  AND xmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrae2_d[l_ac].xraf002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xrae2_d[l_ac].xraf002_desc
END FUNCTION

 
{</section>}
 
