#該程式未解開Section, 採用最新樣板產出!
{<section id="apmi810.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2016-05-12 18:37:14), PR版次:0010(2016-09-05 18:13:22)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000465
#+ Filename...: apmi810
#+ Description: 供應商績效評核項目設定維護作業
#+ Creator....: 02296(2013-08-06 09:47:35)
#+ Modifier...: 02159 -SD/PR- 01727
 
{</section>}
 
{<section id="apmi810.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00005#34  2016/03/18   By Hans  將重複內容的錯誤訊息置換為公用錯誤訊息  
#160318-00025#47  2016/04/29   By 07959 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160905-00007#11  2016/09/05   By 01727 调整系统中无ENT的SQL条件增加ent
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
PRIVATE type type_g_pmcc_m        RECORD
       pmcc001 LIKE pmcc_t.pmcc001, 
   pmcc002 LIKE pmcc_t.pmcc002, 
   pmcc002_desc LIKE type_t.chr80, 
   pmcc003 LIKE pmcc_t.pmcc003, 
   pmcc004 LIKE pmcc_t.pmcc004, 
   ooff013 LIKE ooff_t.ooff013, 
   pmccstus LIKE pmcc_t.pmccstus, 
   pmccownid LIKE pmcc_t.pmccownid, 
   pmccownid_desc LIKE type_t.chr80, 
   pmccowndp LIKE pmcc_t.pmccowndp, 
   pmccowndp_desc LIKE type_t.chr80, 
   pmcccrtid LIKE pmcc_t.pmcccrtid, 
   pmcccrtid_desc LIKE type_t.chr80, 
   pmcccrtdp LIKE pmcc_t.pmcccrtdp, 
   pmcccrtdp_desc LIKE type_t.chr80, 
   pmcccrtdt LIKE pmcc_t.pmcccrtdt, 
   pmccmodid LIKE pmcc_t.pmccmodid, 
   pmccmodid_desc LIKE type_t.chr80, 
   pmccmoddt LIKE pmcc_t.pmccmoddt, 
   pmcc005 LIKE pmcc_t.pmcc005, 
   pmcc006 LIKE pmcc_t.pmcc006
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pmcd_d        RECORD
       pmcd003 LIKE pmcd_t.pmcd003, 
   pmcd004 LIKE pmcd_t.pmcd004
       END RECORD
PRIVATE TYPE type_g_pmcd3_d RECORD
       pmce003 LIKE pmce_t.pmce003, 
   pmce003_desc LIKE type_t.chr500, 
   pmce004 LIKE pmce_t.pmce004, 
   pmce004_desc LIKE type_t.chr500, 
   pmce005 LIKE pmce_t.pmce005
       END RECORD
PRIVATE TYPE type_g_pmcd4_d RECORD
       pmcf003 LIKE pmcf_t.pmcf003, 
   pmcf003_desc LIKE type_t.chr500, 
   pmcf004 LIKE pmcf_t.pmcf004, 
   pmcf005 LIKE pmcf_t.pmcf005, 
   pmcf006 LIKE pmcf_t.pmcf006, 
   pmcf006_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_pmcc001 LIKE pmcc_t.pmcc001,
      b_pmcc002 LIKE pmcc_t.pmcc002
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_pmcg_d RECORD
       pmcg004 LIKE pmcg_t.pmcg004, 
       pmcg005 LIKE pmcg_t.pmcg005, 
       pmcg006 LIKE pmcg_t.pmcg006, 
       pmcg007 LIKE pmcg_t.pmcg007
       END RECORD
DEFINE g_pmcg_d   DYNAMIC ARRAY OF type_g_pmcg_d
DEFINE g_pmcg_d_t type_g_pmcg_d
DEFINE g_wc_table4    STRING                        #第2個單身table所使用的g_wc
DEFINE g_wc3          STRING 
DEFINE g_rec_b2               LIKE type_t.num5           
DEFINE l_ac2                  LIKE type_t.num5
DEFINE g_ac_t                 LIKE type_t.num5
DEFINE l_gzsz008              LIKE gzsz_t.gzsz008
DEFINE g_touch                LIKE type_t.num5   #150915-00006#1 20150915 add by beckxie
#end add-point
       
#模組變數(Module Variables)
DEFINE g_pmcc_m          type_g_pmcc_m
DEFINE g_pmcc_m_t        type_g_pmcc_m
DEFINE g_pmcc_m_o        type_g_pmcc_m
DEFINE g_pmcc_m_mask_o   type_g_pmcc_m #轉換遮罩前資料
DEFINE g_pmcc_m_mask_n   type_g_pmcc_m #轉換遮罩後資料
 
   DEFINE g_pmcc001_t LIKE pmcc_t.pmcc001
DEFINE g_pmcc002_t LIKE pmcc_t.pmcc002
 
 
DEFINE g_pmcd_d          DYNAMIC ARRAY OF type_g_pmcd_d
DEFINE g_pmcd_d_t        type_g_pmcd_d
DEFINE g_pmcd_d_o        type_g_pmcd_d
DEFINE g_pmcd_d_mask_o   DYNAMIC ARRAY OF type_g_pmcd_d #轉換遮罩前資料
DEFINE g_pmcd_d_mask_n   DYNAMIC ARRAY OF type_g_pmcd_d #轉換遮罩後資料
DEFINE g_pmcd3_d          DYNAMIC ARRAY OF type_g_pmcd3_d
DEFINE g_pmcd3_d_t        type_g_pmcd3_d
DEFINE g_pmcd3_d_o        type_g_pmcd3_d
DEFINE g_pmcd3_d_mask_o   DYNAMIC ARRAY OF type_g_pmcd3_d #轉換遮罩前資料
DEFINE g_pmcd3_d_mask_n   DYNAMIC ARRAY OF type_g_pmcd3_d #轉換遮罩後資料
DEFINE g_pmcd4_d          DYNAMIC ARRAY OF type_g_pmcd4_d
DEFINE g_pmcd4_d_t        type_g_pmcd4_d
DEFINE g_pmcd4_d_o        type_g_pmcd4_d
DEFINE g_pmcd4_d_mask_o   DYNAMIC ARRAY OF type_g_pmcd4_d #轉換遮罩前資料
DEFINE g_pmcd4_d_mask_n   DYNAMIC ARRAY OF type_g_pmcd4_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
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
 
{<section id="apmi810.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化 name="main.init"
 
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
 
   #end add-point
   LET g_forupd_sql = " SELECT pmcc001,pmcc002,'',pmcc003,pmcc004,'',pmccstus,pmccownid,'',pmccowndp, 
       '',pmcccrtid,'',pmcccrtdp,'',pmcccrtdt,pmccmodid,'',pmccmoddt,pmcc005,pmcc006", 
                      " FROM pmcc_t",
                      " WHERE pmccent= ? AND pmcc001=? AND pmcc002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmi810_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmcc001,t0.pmcc002,t0.pmcc003,t0.pmcc004,t0.pmccstus,t0.pmccownid, 
       t0.pmccowndp,t0.pmcccrtid,t0.pmcccrtdp,t0.pmcccrtdt,t0.pmccmodid,t0.pmccmoddt,t0.pmcc005,t0.pmcc006, 
       t1.rtaxl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011",
               " FROM pmcc_t t0",
                              " LEFT JOIN rtaxl_t t1 ON t1.rtaxlent="||g_enterprise||" AND t1.rtaxl001=t0.pmcc002 AND t1.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.pmccownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.pmccowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.pmcccrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.pmcccrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.pmccmodid  ",
 
               " WHERE t0.pmccent = " ||g_enterprise|| " AND t0.pmcc001 = ? AND t0.pmcc002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmi810_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmi810 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmi810_init()   
 
      #進入選單 Menu (="N")
      CALL apmi810_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmi810
      
   END IF 
   
   CLOSE apmi810_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmi810.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmi810_init()
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
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('pmccstus','17','N,Y')
 
      CALL cl_set_combo_scc('pmcd003','6001') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_comp_visible("pmcg004",false)
   #end add-point
   
   #初始化搜尋條件
   CALL apmi810_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apmi810.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apmi810_ui_dialog()
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
            CALL apmi810_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   LET g_touch = 1   #150915-00006#1 20150915 add by beckxie
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_pmcc_m.* TO NULL
         CALL g_pmcd_d.clear()
         CALL g_pmcd3_d.clear()
         CALL g_pmcd4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmi810_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_pmcd_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmi810_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               IF NOT cl_null(l_ac)  AND l_ac!=0 THEN
                  CALL apmi810_b_fill_2()
               END IF
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
               CALL apmi810_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_pmcd3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmi810_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body3.before_row"
 
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 2
               #顯示單身筆數
               CALL apmi810_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
        
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_pmcd4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmi810_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 3
               #顯示單身筆數
               CALL apmi810_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_pmcg_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               CALL apmi810_idx_chk()
               #add-point:page1, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               CALL apmi810_idx_chk()
               LET g_current_page = 4
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL apmi810_browser_fill("")
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
               CALL apmi810_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apmi810_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL apmi810_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
 
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL apmi810_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL apmi810_set_act_visible()   
            CALL apmi810_set_act_no_visible()
            IF NOT (g_pmcc_m.pmcc001 IS NULL
              OR g_pmcc_m.pmcc002 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " pmccent = " ||g_enterprise|| " AND",
                                  " pmcc001 = '", g_pmcc_m.pmcc001, "' "
                                  ," AND pmcc002 = '", g_pmcc_m.pmcc002, "' "
 
               #填到對應位置
               CALL apmi810_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "pmcc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmcd_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmce_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "pmcf_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL apmi810_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "pmcc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmcd_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmce_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "pmcf_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL apmi810_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmi810_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apmi810_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmi810_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apmi810_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmi810_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apmi810_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmi810_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apmi810_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmi810_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apmi810_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmi810_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_pmcd_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_pmcd3_d)
                  LET g_export_id[2]   = "s_detail3"
                  LET g_export_node[3] = base.typeInfo.create(g_pmcd4_d)
                  LET g_export_id[3]   = "s_detail4"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[4] = base.typeInfo.create(g_pmcg_d)
                  LET g_export_id[4]   = "s_detail2"
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
               CALL apmi810_modify()
               #add-point:ON ACTION modify name="menu.modify"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apmi810_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmi810_delete()
               #add-point:ON ACTION delete name="menu.delete"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmi810_insert()
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
               CALL apmi810_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmi810_query()
               #add-point:ON ACTION query name="menu.query"
 
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page2
            LET g_action_choice="touch_page2"
            IF cl_auth_chk_act("touch_page2") THEN
               
               #add-point:ON ACTION touch_page2 name="menu.touch_page2"
               LET g_touch = 2   #150915-00006#1 20150915 add by beckxie
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page1
            LET g_action_choice="touch_page1"
            IF cl_auth_chk_act("touch_page1") THEN
               
               #add-point:ON ACTION touch_page1 name="menu.touch_page1"
               LET g_touch = 1   #150915-00006#1 20150915 add by beckxie
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page4
            LET g_action_choice="touch_page4"
            IF cl_auth_chk_act("touch_page4") THEN
               
               #add-point:ON ACTION touch_page4 name="menu.touch_page4"
               LET g_touch = 4   #150915-00006#1 20150915 add by beckxie
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page3
            LET g_action_choice="touch_page3"
            IF cl_auth_chk_act("touch_page3") THEN
               
               #add-point:ON ACTION touch_page3 name="menu.touch_page3"
               LET g_touch = 3   #150915-00006#1 20150915 add by beckxie
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_pmcc002
            LET g_action_choice="prog_pmcc002"
            IF cl_auth_chk_act("prog_pmcc002") THEN
               
               #add-point:ON ACTION prog_pmcc002 name="menu.prog_pmcc002"
 
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmi810_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmi810_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmi810_set_pk_array()
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
 
{<section id="apmi810.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apmi810_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
    CALL g_pmcg_d.clear()
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
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE pmcc001 ",
                                    ",pmcc002 ",
                        " FROM pmcc_t ",
                              " LEFT JOIN pmcd_t ON pmcdent = pmccent AND pmcc001 = pmcd001 AND pmcc002 = pmcd002 ",
                              " LEFT JOIN pmce_t ON pmceent = pmccent AND pmcc001 = pmce001 AND pmcc002 = pmce002",
                              " LEFT JOIN pmcf_t ON pmcfent = pmccent AND pmcc001 = pmcf001 AND pmcc002 = pmcf002",
                       " WHERE pmccent = '" ||g_enterprise|| "' AND pmcdent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2
      IF g_wc_table4 <> " 1=1" THEN
         LET l_sub_sql = " SELECT UNIQUE pmcc001 ",
                                    ",pmcc002 ",
                        " FROM pmcc_t ",
                              " LEFT JOIN (SELECT pmcd_t.*,pmcg_t.* FROM pmcd_t LEFT JOIN pmcg_t ON pmcgent=pmcdent AND",
                              "  pmcg001=pmcd001 AND pmcg002=pmcd002 AND pmcg003=pmcd003 WHERE ",g_wc_table4 clipped,
                              ") pmcd_t ON pmcdent = pmccent AND pmcc001 = pmcd001 AND pmcc002 = pmcd002 ",
                              " LEFT JOIN pmce_t ON pmceent = pmccent AND pmcc001 = pmce001 AND pmcc002 = pmce002",
                              " LEFT JOIN pmcf_t ON pmcfent = pmccent AND pmcc001 = pmcf001 AND pmcc002 = pmcf002",
                       " WHERE pmccent = '" ||g_enterprise|| "' AND pmcdent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2
      END IF
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE pmcc001 ",
                                    ",pmcc002 ",
                        " FROM pmcc_t ", 
                        "WHERE pmccent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED
      
      IF g_wc_table4 <> " 1=1" THEN
         LET l_sub_sql = " SELECT UNIQUE pmcc001 ",
                                    ",pmcc002 ",
                        " FROM pmcc_t ",
                              " LEFT JOIN (SELECT pmcd_t.*,pmcg_t.* FROM pmcd_t LEFT JOIN pmcg_t ON pmcgent=pmcdent AND",
                              "  pmcg001=pmcd001 AND pmcg002=pmcd002 AND pmcg003=pmcd003 WHERE ",g_wc_table4 clipped,
                              ") pmcd_t ON pmcdent = pmccent AND pmcc001 = pmcd001 AND pmcc002 = pmcd002 ",
                              " LEFT JOIN pmce_t ON pmceent = pmccent AND pmcc001 = pmce001 AND pmcc002 = pmce002",
                              " LEFT JOIN pmcf_t ON pmcfent = pmccent AND pmcc001 = pmcf001 AND pmcc002 = pmcf002",
                       " WHERE pmccent = '" ||g_enterprise|| "' AND pmcdent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED
      END IF
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   PREPARE header_cnt_pre4 FROM g_sql
   EXECUTE header_cnt_pre4 INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre4
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   
   #LET g_page_action = ps_page_action          # KEEP ACTION
   
   IF ps_page_action = "F" OR
      ps_page_action = "P" OR
      ps_page_action = "N" OR
      ps_page_action = "L" THEN
      LET g_page_action = ps_page_action
   END IF
   
   CASE ps_page_action
      WHEN "F" 
         LET g_pagestart = 1
          
      WHEN "P"  
         LET g_pagestart = g_pagestart - 1
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF
          
      WHEN "N"  
         LET g_pagestart = g_pagestart + 1
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt MOD 1) + 1
            WHILE g_pagestart > g_browser_cnt 
               LET g_pagestart = g_pagestart - 1
            END WHILE
         END IF
      
      WHEN "L"  
         LET g_pagestart = g_browser_cnt - (g_browser_cnt MOD 1) + 1
         WHILE g_pagestart > g_browser_cnt 
            LET g_pagestart = g_pagestart - 1
         END WHILE
         
      WHEN '/'
         LET g_pagestart = g_jump
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = 1
         END IF
         
   END CASE
  
   #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照pmcc001,pmcc002 Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT pmccstus,pmcc001,pmcc002,DENSE_RANK() OVER(ORDER BY pmcc001,pmcc002 ",g_order,") AS RANK ",
                        " FROM pmcc_t ",
                              " ",
                              " LEFT JOIN pmcd_t ON pmcdent = pmccent AND pmcc001 = pmcd001 AND pmcc002 = pmcd002",
                              " LEFT JOIN pmce_t ON pmceent = pmccent AND pmcc001 = pmce001 AND pmcc002 = pmce002",
                              " LEFT JOIN pmcf_t ON pmcfent = pmccent AND pmcc001 = pmcf001 AND pmcc002 = pmcf002",
                       " WHERE pmccent = '" ||g_enterprise|| "' AND ",g_wc," AND ",g_wc2
      IF g_wc_table4 <> " 1=1" THEN
         LET l_sub_sql = "SELECT DISTINCT pmccstus,pmcc001,pmcc002,DENSE_RANK() OVER(ORDER BY pmcc001,pmcc002 ",g_order,") AS RANK ",
                          " FROM pmcc_t ",
                              " LEFT JOIN (SELECT pmcd_t.*,pmcg_t.* FROM pmcd_t LEFT JOIN pmcg_t ON pmcgent=pmcdent AND",
                              "  pmcg001=pmcd001 AND pmcg002=pmcd002 AND pmcg003=pmcd003 WHERE ",g_wc_table4 clipped,
                              ") pmcd_t ON pmcdent = pmccent AND pmcc001 = pmcd001 AND pmcc002 = pmcd002 ",
                              " LEFT JOIN pmce_t ON pmceent = pmccent AND pmcc001 = pmce001 AND pmcc002 = pmce002",
                              " LEFT JOIN pmcf_t ON pmcfent = pmccent AND pmcc001 = pmcf001 AND pmcc002 = pmcf002",
                       " WHERE pmccent = '" ||g_enterprise|| "' AND ",g_wc," AND ",g_wc2
      END IF
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT pmccstus,pmcc001,pmcc002,DENSE_RANK() OVER(ORDER BY pmcc001,pmcc002 ",g_order,") AS RANK ",
                       " FROM pmcc_t ",
                       " WHERE pmccent = '" ||g_enterprise|| "' AND ", g_wc
      IF g_wc_table4 <> " 1=1" THEN
         LET l_sub_sql = "SELECT DISTINCT pmccstus,pmcc001,pmcc002,DENSE_RANK() OVER(ORDER BY pmcc001,pmcc002 ",g_order,") AS RANK ",
                          " FROM pmcc_t ",
                              " LEFT JOIN (SELECT pmcd_t.*,pmcg_t.* FROM pmcd_t LEFT JOIN pmcg_t ON pmcgent=pmcdent AND",
                              "  pmcg001=pmcd001 AND pmcg002=pmcd002 AND pmcg003=pmcd003 WHERE ",g_wc_table4 clipped,
                              ") pmcd_t ON pmcdent = pmccent AND pmcc001 = pmcd001 AND pmcc002 = pmcd002 ",
                              " LEFT JOIN pmce_t ON pmceent = pmccent AND pmcc001 = pmce001 AND pmcc002 = pmce002",
                              " LEFT JOIN pmcf_t ON pmcfent = pmccent AND pmcc001 = pmcf001 AND pmcc002 = pmcf002",
                       " WHERE pmccent = '" ||g_enterprise|| "' AND ", g_wc
      END IF
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT pmccstus,pmcc001,pmcc002 FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
#              " ORDER BY ",l_searchcol," ",g_order
              " ORDER BY pmcc001,pmcc002 ",g_order
			   
   PREPARE browse_pre4 FROM g_sql
   DECLARE browse_cur4 CURSOR FOR browse_pre4
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur4 INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmcc001,g_browser[g_cnt].b_pmcc002#,g_browser[g_cnt].rank   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
  
            #此段落由子樣板a24產生
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/valid.png"


      END CASE


      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   FREE browse_pre4
   RETURN
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT pmcc001,pmcc002 ",
                      " FROM pmcc_t ",
                      " ",
                      " LEFT JOIN pmcd_t ON pmcdent = pmccent AND pmcc001 = pmcd001 AND pmcc002 = pmcd002 ", "  ",
                      #add-point:browser_fill段sql(pmcd_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN pmce_t ON pmceent = pmccent AND pmcc001 = pmce001 AND pmcc002 = pmce002", "  ",
                      #add-point:browser_fill段sql(pmce_t1) name="browser_fill.cnt.join.pmce_t1"
                      
                      #end add-point
 
                      " LEFT JOIN pmcf_t ON pmcfent = pmccent AND pmcc001 = pmcf001 AND pmcc002 = pmcf002", "  ",
                      #add-point:browser_fill段sql(pmcf_t1) name="browser_fill.cnt.join.pmcf_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE pmccent = " ||g_enterprise|| " AND pmcdent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pmcc_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pmcc001,pmcc002 ",
                      " FROM pmcc_t ", 
                      "  ",
                      "  ",
                      " WHERE pmccent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pmcc_t")
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
      INITIALIZE g_pmcc_m.* TO NULL
      CALL g_pmcd_d.clear()        
      CALL g_pmcd3_d.clear() 
      CALL g_pmcd4_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pmcc001,t0.pmcc002 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmccstus,t0.pmcc001,t0.pmcc002 ",
                  " FROM pmcc_t t0",
                  "  ",
                  "  LEFT JOIN pmcd_t ON pmcdent = pmccent AND pmcc001 = pmcd001 AND pmcc002 = pmcd002 ", "  ", 
                  #add-point:browser_fill段sql(pmcd_t1) name="browser_fill.join.pmcd_t1"
                  
                  #end add-point
                  "  LEFT JOIN pmce_t ON pmceent = pmccent AND pmcc001 = pmce001 AND pmcc002 = pmce002", "  ", 
                  #add-point:browser_fill段sql(pmce_t1) name="browser_fill.join.pmce_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN pmcf_t ON pmcfent = pmccent AND pmcc001 = pmcf001 AND pmcc002 = pmcf002", "  ", 
                  #add-point:browser_fill段sql(pmcf_t1) name="browser_fill.join.pmcf_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
 
 
                  
                  " WHERE t0.pmccent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("pmcc_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmccstus,t0.pmcc001,t0.pmcc002 ",
                  " FROM pmcc_t t0",
                  "  ",
                  
                  " WHERE t0.pmccent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("pmcc_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY pmcc001,pmcc002 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
 
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmcc_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmcc001,g_browser[g_cnt].b_pmcc002 
 
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
   
   IF cl_null(g_browser[g_cnt].b_pmcc001) THEN
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
 
{<section id="apmi810.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apmi810_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
 
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pmcc_m.pmcc001 = g_browser[g_current_idx].b_pmcc001   
   LET g_pmcc_m.pmcc002 = g_browser[g_current_idx].b_pmcc002   
 
   EXECUTE apmi810_master_referesh USING g_pmcc_m.pmcc001,g_pmcc_m.pmcc002 INTO g_pmcc_m.pmcc001,g_pmcc_m.pmcc002, 
       g_pmcc_m.pmcc003,g_pmcc_m.pmcc004,g_pmcc_m.pmccstus,g_pmcc_m.pmccownid,g_pmcc_m.pmccowndp,g_pmcc_m.pmcccrtid, 
       g_pmcc_m.pmcccrtdp,g_pmcc_m.pmcccrtdt,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmoddt,g_pmcc_m.pmcc005, 
       g_pmcc_m.pmcc006,g_pmcc_m.pmcc002_desc,g_pmcc_m.pmccownid_desc,g_pmcc_m.pmccowndp_desc,g_pmcc_m.pmcccrtid_desc, 
       g_pmcc_m.pmcccrtdp_desc,g_pmcc_m.pmccmodid_desc
   
   CALL apmi810_pmcc_t_mask()
   CALL apmi810_show()
      
END FUNCTION
 
{</section>}
 
{<section id="apmi810.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apmi810_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
 
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
 
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
 
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmi810.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmi810_ui_browser_refresh()
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
      IF g_browser[l_i].b_pmcc001 = g_pmcc_m.pmcc001 
         AND g_browser[l_i].b_pmcc002 = g_pmcc_m.pmcc002 
 
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
 
{<section id="apmi810.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmi810_construct()
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
   CALL g_pmcg_d.clear()
   INITIALIZE g_wc_table4 TO NULL
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_pmcc_m.* TO NULL
   CALL g_pmcd_d.clear()        
   CALL g_pmcd3_d.clear() 
   CALL g_pmcd4_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
 
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON pmcc001,pmcc002,pmcc003,pmcc004,pmccstus,pmccownid,pmccowndp,pmcccrtid, 
          pmcccrtdp,pmcccrtdt,pmccmodid,pmccmoddt,pmcc005,pmcc006
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
 
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pmcccrtdt>>----
         AFTER FIELD pmcccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pmccmoddt>>----
         AFTER FIELD pmccmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmcccnfdt>>----
         
         #----<<pmccpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.pmcc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc001
            #add-point:ON ACTION controlp INFIELD pmcc001 name="construct.c.pmcc001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_pmcc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcc001  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO pmcc001 #評核期別 
               #DISPLAY g_qryparam.return3 TO pmcc002 #評核品類 

            NEXT FIELD pmcc001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc001
            #add-point:BEFORE FIELD pmcc001 name="construct.b.pmcc001"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc001
            
            #add-point:AFTER FIELD pmcc001 name="construct.a.pmcc001"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc002
            #add-point:ON ACTION controlp INFIELD pmcc002 name="construct.c.pmcc002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            SELECT gzsz008 INTO l_gzsz008 FROM gzsz_t 
             WHERE gzsz001 = 'ooaa_t' AND gzsz002 = 'E-CIR-0001'
            LET g_qryparam.arg1 = l_gzsz008
            CALL q_rtax001_3()                           #呼叫開窗
            LET g_qryparam.arg1 = null
            DISPLAY g_qryparam.return1 TO pmcc002  #顯示到畫面上

            NEXT FIELD pmcc002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc002
            #add-point:BEFORE FIELD pmcc002 name="construct.b.pmcc002"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc002
            
            #add-point:AFTER FIELD pmcc002 name="construct.a.pmcc002"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc003
            #add-point:BEFORE FIELD pmcc003 name="construct.b.pmcc003"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc003
            
            #add-point:AFTER FIELD pmcc003 name="construct.a.pmcc003"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc003
            #add-point:ON ACTION controlp INFIELD pmcc003 name="construct.c.pmcc003"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc004
            #add-point:BEFORE FIELD pmcc004 name="construct.b.pmcc004"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc004
            
            #add-point:AFTER FIELD pmcc004 name="construct.a.pmcc004"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc004
            #add-point:ON ACTION controlp INFIELD pmcc004 name="construct.c.pmcc004"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmccstus
            #add-point:BEFORE FIELD pmccstus name="construct.b.pmccstus"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmccstus
            
            #add-point:AFTER FIELD pmccstus name="construct.a.pmccstus"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmccstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmccstus
            #add-point:ON ACTION controlp INFIELD pmccstus name="construct.c.pmccstus"
 
            #END add-point
 
 
         #Ctrlp:construct.c.pmccownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmccownid
            #add-point:ON ACTION controlp INFIELD pmccownid name="construct.c.pmccownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmccownid  #顯示到畫面上

            NEXT FIELD pmccownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmccownid
            #add-point:BEFORE FIELD pmccownid name="construct.b.pmccownid"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmccownid
            
            #add-point:AFTER FIELD pmccownid name="construct.a.pmccownid"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmccowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmccowndp
            #add-point:ON ACTION controlp INFIELD pmccowndp name="construct.c.pmccowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmccowndp  #顯示到畫面上

            NEXT FIELD pmccowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmccowndp
            #add-point:BEFORE FIELD pmccowndp name="construct.b.pmccowndp"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmccowndp
            
            #add-point:AFTER FIELD pmccowndp name="construct.a.pmccowndp"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcccrtid
            #add-point:ON ACTION controlp INFIELD pmcccrtid name="construct.c.pmcccrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcccrtid  #顯示到畫面上

            NEXT FIELD pmcccrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcccrtid
            #add-point:BEFORE FIELD pmcccrtid name="construct.b.pmcccrtid"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcccrtid
            
            #add-point:AFTER FIELD pmcccrtid name="construct.a.pmcccrtid"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcccrtdp
            #add-point:ON ACTION controlp INFIELD pmcccrtdp name="construct.c.pmcccrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcccrtdp  #顯示到畫面上

            NEXT FIELD pmcccrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcccrtdp
            #add-point:BEFORE FIELD pmcccrtdp name="construct.b.pmcccrtdp"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcccrtdp
            
            #add-point:AFTER FIELD pmcccrtdp name="construct.a.pmcccrtdp"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcccrtdt
            #add-point:BEFORE FIELD pmcccrtdt name="construct.b.pmcccrtdt"
 
            #END add-point
 
 
         #Ctrlp:construct.c.pmccmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmccmodid
            #add-point:ON ACTION controlp INFIELD pmccmodid name="construct.c.pmccmodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmccmodid  #顯示到畫面上

            NEXT FIELD pmccmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmccmodid
            #add-point:BEFORE FIELD pmccmodid name="construct.b.pmccmodid"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmccmodid
            
            #add-point:AFTER FIELD pmccmodid name="construct.a.pmccmodid"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmccmoddt
            #add-point:BEFORE FIELD pmccmoddt name="construct.b.pmccmoddt"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc005
            #add-point:BEFORE FIELD pmcc005 name="construct.b.pmcc005"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc005
            
            #add-point:AFTER FIELD pmcc005 name="construct.a.pmcc005"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc005
            #add-point:ON ACTION controlp INFIELD pmcc005 name="construct.c.pmcc005"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc006
            #add-point:BEFORE FIELD pmcc006 name="construct.b.pmcc006"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc006
            
            #add-point:AFTER FIELD pmcc006 name="construct.a.pmcc006"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc006
            #add-point:ON ACTION controlp INFIELD pmcc006 name="construct.c.pmcc006"
 
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON pmcd003,pmcd004
           FROM s_detail1[1].pmcd003,s_detail1[1].pmcd004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
 
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcd003
            #add-point:BEFORE FIELD pmcd003 name="construct.b.page1.pmcd003"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcd003
            
            #add-point:AFTER FIELD pmcd003 name="construct.a.page1.pmcd003"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcd003
            #add-point:ON ACTION controlp INFIELD pmcd003 name="construct.c.page1.pmcd003"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcd004
            #add-point:BEFORE FIELD pmcd004 name="construct.b.page1.pmcd004"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcd004
            
            #add-point:AFTER FIELD pmcd004 name="construct.a.page1.pmcd004"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcd004
            #add-point:ON ACTION controlp INFIELD pmcd004 name="construct.c.page1.pmcd004"
 
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON pmce003,pmce004,pmce005
           FROM s_detail3[1].pmce003,s_detail3[1].pmce004,s_detail3[1].pmce005
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
 
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page3.pmce003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmce003
            #add-point:ON ACTION controlp INFIELD pmce003 name="construct.c.page3.pmce003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '2052'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmce003  #顯示到畫面上

            NEXT FIELD pmce003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmce003
            #add-point:BEFORE FIELD pmce003 name="construct.b.page3.pmce003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmce003
            
            #add-point:AFTER FIELD pmce003 name="construct.a.page3.pmce003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmce004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmce004
            #add-point:ON ACTION controlp INFIELD pmce004 name="construct.c.page3.pmce004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmce004  #顯示到畫面上

            NEXT FIELD pmce004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmce004
            #add-point:BEFORE FIELD pmce004 name="construct.b.page3.pmce004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmce004
            
            #add-point:AFTER FIELD pmce004 name="construct.a.page3.pmce004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmce005
            #add-point:BEFORE FIELD pmce005 name="construct.b.page3.pmce005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmce005
            
            #add-point:AFTER FIELD pmce005 name="construct.a.page3.pmce005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmce005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmce005
            #add-point:ON ACTION controlp INFIELD pmce005 name="construct.c.page3.pmce005"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON pmcf003,pmcf004,pmcf005,pmcf006
           FROM s_detail4[1].pmcf003,s_detail4[1].pmcf004,s_detail4[1].pmcf005,s_detail4[1].pmcf006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
 
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page4.pmcf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcf003
            #add-point:ON ACTION controlp INFIELD pmcf003 name="construct.c.page4.pmcf003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcf003  #顯示到畫面上

            NEXT FIELD pmcf003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcf003
            #add-point:BEFORE FIELD pmcf003 name="construct.b.page4.pmcf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcf003
            
            #add-point:AFTER FIELD pmcf003 name="construct.a.page4.pmcf003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcf004
            #add-point:BEFORE FIELD pmcf004 name="construct.b.page4.pmcf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcf004
            
            #add-point:AFTER FIELD pmcf004 name="construct.a.page4.pmcf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.pmcf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcf004
            #add-point:ON ACTION controlp INFIELD pmcf004 name="construct.c.page4.pmcf004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcf005
            #add-point:BEFORE FIELD pmcf005 name="construct.b.page4.pmcf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcf005
            
            #add-point:AFTER FIELD pmcf005 name="construct.a.page4.pmcf005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.pmcf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcf005
            #add-point:ON ACTION controlp INFIELD pmcf005 name="construct.c.page4.pmcf005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.pmcf006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcf006
            #add-point:ON ACTION controlp INFIELD pmcf006 name="construct.c.page4.pmcf006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcf006  #顯示到畫面上

            NEXT FIELD pmcf006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcf006
            #add-point:BEFORE FIELD pmcf006 name="construct.b.page4.pmcf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcf006
            
            #add-point:AFTER FIELD pmcf006 name="construct.a.page4.pmcf006"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      CONSTRUCT g_wc_table4 ON pmcg004,pmcg005,pmcg006,pmcg007
           FROM s_detail2[1].pmcg004,s_detail2[1].pmcg005,s_detail2[1].pmcg006,s_detail2[1].pmcg007
                      
         BEFORE CONSTRUCT
#            CALL cl_qbe_display_condition(lc_qbe_sn)
      END CONSTRUCT      
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
            INITIALIZE g_wc2_table2 TO NULL
 
            INITIALIZE g_wc2_table3 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "pmcc_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "pmcd_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "pmce_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "pmcf_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
 
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
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
 
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmi810.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmi810_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL g_pmcg_d.clear() 
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
   CALL g_pmcd_d.clear()
   CALL g_pmcd3_d.clear()
   CALL g_pmcd4_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL apmi810_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmi810_browser_fill("")
      CALL apmi810_fetch("")
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
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL apmi810_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL apmi810_fetch("F") 
      #顯示單身筆數
      CALL apmi810_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmi810.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmi810_fetch(p_flag)
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
   
   LET g_pmcc_m.pmcc001 = g_browser[g_current_idx].b_pmcc001
   LET g_pmcc_m.pmcc002 = g_browser[g_current_idx].b_pmcc002
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apmi810_master_referesh USING g_pmcc_m.pmcc001,g_pmcc_m.pmcc002 INTO g_pmcc_m.pmcc001,g_pmcc_m.pmcc002, 
       g_pmcc_m.pmcc003,g_pmcc_m.pmcc004,g_pmcc_m.pmccstus,g_pmcc_m.pmccownid,g_pmcc_m.pmccowndp,g_pmcc_m.pmcccrtid, 
       g_pmcc_m.pmcccrtdp,g_pmcc_m.pmcccrtdt,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmoddt,g_pmcc_m.pmcc005, 
       g_pmcc_m.pmcc006,g_pmcc_m.pmcc002_desc,g_pmcc_m.pmccownid_desc,g_pmcc_m.pmccowndp_desc,g_pmcc_m.pmcccrtid_desc, 
       g_pmcc_m.pmcccrtdp_desc,g_pmcc_m.pmccmodid_desc
   
   #遮罩相關處理
   LET g_pmcc_m_mask_o.* =  g_pmcc_m.*
   CALL apmi810_pmcc_t_mask()
   LET g_pmcc_m_mask_n.* =  g_pmcc_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmi810_set_act_visible()   
   CALL apmi810_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
 
   #end add-point
   
   #保存單頭舊值
   LET g_pmcc_m_t.* = g_pmcc_m.*
   LET g_pmcc_m_o.* = g_pmcc_m.*
   
   LET g_data_owner = g_pmcc_m.pmccownid      
   LET g_data_dept  = g_pmcc_m.pmccowndp
   
   #重新顯示   
   CALL apmi810_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="apmi810.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmi810_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   CALL g_pmcg_d.clear()
   INITIALIZE g_pmcc_m.* TO NULL
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_pmcd_d.clear()   
   CALL g_pmcd3_d.clear()  
   CALL g_pmcd4_d.clear()  
 
 
   INITIALIZE g_pmcc_m.* TO NULL             #DEFAULT 設定
   
   LET g_pmcc001_t = NULL
   LET g_pmcc002_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmcc_m.pmccownid = g_user
      LET g_pmcc_m.pmccowndp = g_dept
      LET g_pmcc_m.pmcccrtid = g_user
      LET g_pmcc_m.pmcccrtdp = g_dept 
      LET g_pmcc_m.pmcccrtdt = cl_get_current()
      LET g_pmcc_m.pmccmodid = g_user
      LET g_pmcc_m.pmccmoddt = cl_get_current()
      LET g_pmcc_m.pmccstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_pmcc_m.pmcc005 = "50"
      LET g_pmcc_m.pmcc006 = "50"
 
  
      #add-point:單頭預設值 name="insert.default"
      
      SELECT trunc(sysdate,'month') INTO g_pmcc_m.pmcc003 FROM dual
      SELECT trunc(last_day(sysdate)) INTO g_pmcc_m.pmcc004 FROM dual
      LET g_pmcc_m.pmccstus = "Y" 
      LET g_pmcc_m_t.* = g_pmcc_m.*       
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_pmcc_m_t.* = g_pmcc_m.*
      LET g_pmcc_m_o.* = g_pmcc_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmcc_m.pmccstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL apmi810_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      CALL g_pmcg_d.clear()
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
         INITIALIZE g_pmcc_m.* TO NULL
         INITIALIZE g_pmcd_d TO NULL
         INITIALIZE g_pmcd3_d TO NULL
         INITIALIZE g_pmcd4_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL apmi810_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_pmcd_d.clear()
      #CALL g_pmcd3_d.clear()
      #CALL g_pmcd4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmi810_set_act_visible()   
   CALL apmi810_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmcc001_t = g_pmcc_m.pmcc001
   LET g_pmcc002_t = g_pmcc_m.pmcc002
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmccent = " ||g_enterprise|| " AND",
                      " pmcc001 = '", g_pmcc_m.pmcc001, "' "
                      ," AND pmcc002 = '", g_pmcc_m.pmcc002, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmi810_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE apmi810_cl
   
   CALL apmi810_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmi810_master_referesh USING g_pmcc_m.pmcc001,g_pmcc_m.pmcc002 INTO g_pmcc_m.pmcc001,g_pmcc_m.pmcc002, 
       g_pmcc_m.pmcc003,g_pmcc_m.pmcc004,g_pmcc_m.pmccstus,g_pmcc_m.pmccownid,g_pmcc_m.pmccowndp,g_pmcc_m.pmcccrtid, 
       g_pmcc_m.pmcccrtdp,g_pmcc_m.pmcccrtdt,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmoddt,g_pmcc_m.pmcc005, 
       g_pmcc_m.pmcc006,g_pmcc_m.pmcc002_desc,g_pmcc_m.pmccownid_desc,g_pmcc_m.pmccowndp_desc,g_pmcc_m.pmcccrtid_desc, 
       g_pmcc_m.pmcccrtdp_desc,g_pmcc_m.pmccmodid_desc
   
   
   #遮罩相關處理
   LET g_pmcc_m_mask_o.* =  g_pmcc_m.*
   CALL apmi810_pmcc_t_mask()
   LET g_pmcc_m_mask_n.* =  g_pmcc_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,g_pmcc_m.pmcc002_desc,g_pmcc_m.pmcc003,g_pmcc_m.pmcc004, 
       g_pmcc_m.ooff013,g_pmcc_m.pmccstus,g_pmcc_m.pmccownid,g_pmcc_m.pmccownid_desc,g_pmcc_m.pmccowndp, 
       g_pmcc_m.pmccowndp_desc,g_pmcc_m.pmcccrtid,g_pmcc_m.pmcccrtid_desc,g_pmcc_m.pmcccrtdp,g_pmcc_m.pmcccrtdp_desc, 
       g_pmcc_m.pmcccrtdt,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmodid_desc,g_pmcc_m.pmccmoddt,g_pmcc_m.pmcc005, 
       g_pmcc_m.pmcc006
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_pmcc_m.pmccownid      
   LET g_data_dept  = g_pmcc_m.pmccowndp
   
   #功能已完成,通報訊息中心
   CALL apmi810_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmi810.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmi810_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
 
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_pmcc_m_t.* = g_pmcc_m.*
   LET g_pmcc_m_o.* = g_pmcc_m.*
   
   IF g_pmcc_m.pmcc001 IS NULL
   OR g_pmcc_m.pmcc002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_pmcc001_t = g_pmcc_m.pmcc001
   LET g_pmcc002_t = g_pmcc_m.pmcc002
 
   CALL s_transaction_begin()
   
   OPEN apmi810_cl USING g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmi810_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmi810_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmi810_master_referesh USING g_pmcc_m.pmcc001,g_pmcc_m.pmcc002 INTO g_pmcc_m.pmcc001,g_pmcc_m.pmcc002, 
       g_pmcc_m.pmcc003,g_pmcc_m.pmcc004,g_pmcc_m.pmccstus,g_pmcc_m.pmccownid,g_pmcc_m.pmccowndp,g_pmcc_m.pmcccrtid, 
       g_pmcc_m.pmcccrtdp,g_pmcc_m.pmcccrtdt,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmoddt,g_pmcc_m.pmcc005, 
       g_pmcc_m.pmcc006,g_pmcc_m.pmcc002_desc,g_pmcc_m.pmccownid_desc,g_pmcc_m.pmccowndp_desc,g_pmcc_m.pmcccrtid_desc, 
       g_pmcc_m.pmcccrtdp_desc,g_pmcc_m.pmccmodid_desc
   
   #檢查是否允許此動作
   IF NOT apmi810_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmcc_m_mask_o.* =  g_pmcc_m.*
   CALL apmi810_pmcc_t_mask()
   LET g_pmcc_m_mask_n.* =  g_pmcc_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
 
   
   CALL apmi810_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
 
    
   WHILE TRUE
      LET g_pmcc001_t = g_pmcc_m.pmcc001
      LET g_pmcc002_t = g_pmcc_m.pmcc002
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_pmcc_m.pmccmodid = g_user 
LET g_pmcc_m.pmccmoddt = cl_get_current()
LET g_pmcc_m.pmccmodid_desc = cl_get_username(g_pmcc_m.pmccmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
 
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL apmi810_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
 
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE pmcc_t SET (pmccmodid,pmccmoddt) = (g_pmcc_m.pmccmodid,g_pmcc_m.pmccmoddt)
          WHERE pmccent = g_enterprise AND pmcc001 = g_pmcc001_t
            AND pmcc002 = g_pmcc002_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_pmcc_m.* = g_pmcc_m_t.*
            CALL apmi810_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_pmcc_m.pmcc001 != g_pmcc_m_t.pmcc001
      OR g_pmcc_m.pmcc002 != g_pmcc_m_t.pmcc002
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
 
         #end add-point
         
         #更新單身key值
         UPDATE pmcd_t SET pmcd001 = g_pmcc_m.pmcc001
                                       ,pmcd002 = g_pmcc_m.pmcc002
 
          WHERE pmcdent = g_enterprise AND pmcd001 = g_pmcc_m_t.pmcc001
            AND pmcd002 = g_pmcc_m_t.pmcc002
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
 
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pmcd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmcd_t:",SQLERRMESSAGE 
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
         
         UPDATE pmce_t
            SET pmce001 = g_pmcc_m.pmcc001
               ,pmce002 = g_pmcc_m.pmcc002
 
          WHERE pmceent = g_enterprise AND
                pmce001 = g_pmcc001_t
            AND pmce002 = g_pmcc002_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
 
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pmce_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmce_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
 
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
 
         #end add-point
         
         UPDATE pmcf_t
            SET pmcf001 = g_pmcc_m.pmcc001
               ,pmcf002 = g_pmcc_m.pmcc002
 
          WHERE pmcfent = g_enterprise AND
                pmcf001 = g_pmcc001_t
            AND pmcf002 = g_pmcc002_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
 
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pmcf_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmcf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
 
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmi810_set_act_visible()   
   CALL apmi810_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmccent = " ||g_enterprise|| " AND",
                      " pmcc001 = '", g_pmcc_m.pmcc001, "' "
                      ," AND pmcc002 = '", g_pmcc_m.pmcc002, "' "
 
   #填到對應位置
   CALL apmi810_browser_fill("")
 
   CLOSE apmi810_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmi810_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="apmi810.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmi810_input(p_cmd)
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
   DEFINE  l_count1        LIKE type_t.num5
   DEFINE  l_pmcc002       LIKE pmcc_t.pmcc002
   DEFINE  l_pmcd004       LIKE pmcd_t.pmcd004
   DEFINE  l_pmce005       LIKE pmce_t.pmce005 
   DEFINE  l_success       like type_t.num5
   DEFINE  l_gzsz008       LIKE gzsz_t.gzsz008   
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
   DISPLAY BY NAME g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,g_pmcc_m.pmcc002_desc,g_pmcc_m.pmcc003,g_pmcc_m.pmcc004, 
       g_pmcc_m.ooff013,g_pmcc_m.pmccstus,g_pmcc_m.pmccownid,g_pmcc_m.pmccownid_desc,g_pmcc_m.pmccowndp, 
       g_pmcc_m.pmccowndp_desc,g_pmcc_m.pmcccrtid,g_pmcc_m.pmcccrtid_desc,g_pmcc_m.pmcccrtdp,g_pmcc_m.pmcccrtdp_desc, 
       g_pmcc_m.pmcccrtdt,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmodid_desc,g_pmcc_m.pmccmoddt,g_pmcc_m.pmcc005, 
       g_pmcc_m.pmcc006
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
 
   #end add-point 
   LET g_forupd_sql = "SELECT pmcd003,pmcd004 FROM pmcd_t WHERE pmcdent=? AND pmcd001=? AND pmcd002=?  
       AND pmcd003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmi810_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
 
   #end add-point    
   LET g_forupd_sql = "SELECT pmce003,pmce004,pmce005 FROM pmce_t WHERE pmceent=? AND pmce001=? AND  
       pmce002=? AND pmce003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmi810_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
 
   #end add-point    
   LET g_forupd_sql = "SELECT pmcf003,pmcf004,pmcf005,pmcf006 FROM pmcf_t WHERE pmcfent=? AND pmcf001=?  
       AND pmcf002=? AND pmcf003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmi810_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apmi810_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apmi810_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,g_pmcc_m.pmcc003,g_pmcc_m.pmcc004,g_pmcc_m.pmccstus, 
       g_pmcc_m.pmcc005,g_pmcc_m.pmcc006
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_forupd_sql = "SELECT pmcg004,pmcg005,pmcg006,pmcg007 FROM pmcg_t WHERE pmcgent=? AND pmcg001=? AND pmcg002=? AND pmcg003=? AND pmcg004=?  FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE apmi810_bcl4 CURSOR FROM g_forupd_sql
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apmi810.input.head" >}
      #單頭段
      INPUT BY NAME g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,g_pmcc_m.pmcc003,g_pmcc_m.pmcc004,g_pmcc_m.pmccstus, 
          g_pmcc_m.pmcc005,g_pmcc_m.pmcc006 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN apmi810_cl USING g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmi810_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmi810_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL apmi810_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL apmi810_set_entry(p_cmd)
            CALL apmi810_set_no_entry(p_cmd)
            LET  g_pmcc001_t=g_pmcc_m.pmcc001  
            LET  g_pmcc002_t=g_pmcc_m.pmcc002 
            #end add-point
            CALL apmi810_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc001
            #add-point:BEFORE FIELD pmcc001 name="input.b.pmcc001"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc001
            
            #add-point:AFTER FIELD pmcc001 name="input.a.pmcc001"
            #此段落由子樣板a05產生
            
            IF  NOT cl_null(g_pmcc_m.pmcc001) AND NOT cl_null(g_pmcc_m.pmcc002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_pmcc_m.pmcc001 != g_pmcc001_t  OR g_pmcc_m.pmcc002 != g_pmcc002_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmcc_t WHERE "||"pmccent = '" ||g_enterprise|| "' AND "||"pmcc001 = '"||g_pmcc_m.pmcc001 ||"' AND "|| "pmcc002 = '"||g_pmcc_m.pmcc002 ||"'",'std-00004',0) THEN 
                     LET g_pmcc_m.pmcc001=g_pmcc_m_t.pmcc001 
                     NEXT FIELD CURRENT
                  END IF
                  CALL apmi810_chk_pmcc002()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_pmcc_m.pmcc002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pmcc_m.pmcc001 = g_pmcc_m_t.pmcc001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcc001
            #add-point:ON CHANGE pmcc001 name="input.g.pmcc001"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc002
            
            #add-point:AFTER FIELD pmcc002 name="input.a.pmcc002"
            #此段落由子樣板a05產生
            LET g_pmcc_m.pmcc002_desc = NULL
            DISPLAY BY NAME g_pmcc_m.pmcc002_desc
            IF  NOT cl_null(g_pmcc_m.pmcc001) AND NOT cl_null(g_pmcc_m.pmcc002) THEN 
               IF g_pmcc_m.pmcc002 ='ALL' OR g_pmcc_m.pmcc002='all' THEN
                  LET g_pmcc_m.pmcc002 = 'ALL'
               END IF
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_pmcc_m.pmcc001 != g_pmcc001_t  OR g_pmcc_m.pmcc002 != g_pmcc_m_t.pmcc002 or g_pmcc_m_t.pmcc002 is null))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmcc_t WHERE "||"pmccent = '" ||g_enterprise|| "' AND "||"pmcc001 = '"||g_pmcc_m.pmcc001 ||"' AND "|| "pmcc002 = '"||g_pmcc_m.pmcc002 ||"'",'std-00004',0) THEN 
                     LET g_pmcc_m.pmcc002 = g_pmcc_m_t.pmcc002
                     NEXT FIELD CURRENT
                  END IF
                  CALL apmi810_chk_pmcc002()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_pmcc_m.pmcc002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pmcc_m.pmcc002 = g_pmcc_m_t.pmcc002
                     CALL apmi810_display_pmcc002(g_pmcc_m.pmcc002)
                     NEXT FIELD pmcc002
                  END IF                  
               END IF
            END IF
#            IF  NOT cl_null(g_pmcc_m.pmcc002) THEN
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND ( g_pmcc_m.pmcc002 != g_pmcc_m_t.pmcc002 OR g_pmcc_m_t.pmcc002 IS NULL ))) THEN 
#                  CALL apmi810_pmcc002(g_pmcc_m.pmcc002)
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_pmcc_m.pmcc002
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()

#                     LET g_pmcc_m.pmcc002 = g_pmcc_m_t.pmcc002
#                     CALL apmi810_display_pmcc002(g_pmcc_m.pmcc002)
#                     NEXT FIELD pmcc002
#                  END IF
#                  CALL apmi810_chk_pmcc002()
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_pmcc_m.pmcc002
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()

#                     LET g_pmcc_m.pmcc002 = g_pmcc_m_t.pmcc002
#                     CALL apmi810_display_pmcc002(g_pmcc_m.pmcc002)
#                     NEXT FIELD pmcc002
#                  END IF
#               END IF
#            END IF 
            IF NOT cl_null(g_pmcc_m.pmcc002) AND g_pmcc_m.pmcc002 <> 'ALL' THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               SELECT gzsz008 INTO l_gzsz008 FROM gzsz_t 
                WHERE gzsz001 = 'ooaa_t' AND gzsz002 = 'E-CIR-0001'
               LET g_chkparam.arg1 = g_pmcc_m.pmcc002
               LET g_chkparam.arg2 = l_gzsz008
               #160318-00025#47  2016/04/29  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "ast-00215:sub-01302|arti202|",cl_get_progname("arti202",g_lang,"2"),"|:EXEPROGarti202"
               #160318-00025#47  2016/04/29  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtax001_2") THEN

               ELSE
                  #檢查失敗時後續處理
                  LET g_pmcc_m.pmcc002 = g_pmcc_m_t.pmcc002
                  CALL apmi810_display_pmcc002(g_pmcc_m.pmcc002)
                  NEXT FIELD CURRENT
               END IF
            END IF              
            CALL apmi810_display_pmcc002(g_pmcc_m.pmcc002)


            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc002
            #add-point:BEFORE FIELD pmcc002 name="input.b.pmcc002"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcc002
            #add-point:ON CHANGE pmcc002 name="input.g.pmcc002"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc003
            #add-point:BEFORE FIELD pmcc003 name="input.b.pmcc003"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc003
            
            #add-point:AFTER FIELD pmcc003 name="input.a.pmcc003"
            IF  NOT cl_null(g_pmcc_m.pmcc003) AND NOT cl_null(g_pmcc_m.pmcc004) THEN 
               IF g_pmcc_m.pmcc003>g_pmcc_m.pmcc004 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "apm-00059"
                  LET g_errparam.extend = g_pmcc_m.pmcc003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pmcc_m.pmcc003 = g_pmcc_m_t.pmcc003
                  NEXT FIELD pmcc003
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcc003
            #add-point:ON CHANGE pmcc003 name="input.g.pmcc003"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc004
            #add-point:BEFORE FIELD pmcc004 name="input.b.pmcc004"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc004
            
            #add-point:AFTER FIELD pmcc004 name="input.a.pmcc004"
            IF  NOT cl_null(g_pmcc_m.pmcc003) AND NOT cl_null(g_pmcc_m.pmcc004) THEN 
               IF g_pmcc_m.pmcc003>g_pmcc_m.pmcc004 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "apm-00059"
                  LET g_errparam.extend = g_pmcc_m.pmcc004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pmcc_m.pmcc004 = g_pmcc_m_t.pmcc004
                  NEXT FIELD pmcc004
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcc004
            #add-point:ON CHANGE pmcc004 name="input.g.pmcc004"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmccstus
            #add-point:BEFORE FIELD pmccstus name="input.b.pmccstus"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmccstus
            
            #add-point:AFTER FIELD pmccstus name="input.a.pmccstus"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmccstus
            #add-point:ON CHANGE pmccstus name="input.g.pmccstus"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmcc_m.pmcc005,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD pmcc005
            END IF 
 
 
 
            #add-point:AFTER FIELD pmcc005 name="input.a.pmcc005"
            
            IF cl_null(g_pmcc_m.pmcc005) THEN
               LET g_pmcc_m.pmcc005 = 0  
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc005
            #add-point:BEFORE FIELD pmcc005 name="input.b.pmcc005"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcc005
            #add-point:ON CHANGE pmcc005 name="input.g.pmcc005"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmcc_m.pmcc006,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmcc006
            END IF 
 
 
 
            #add-point:AFTER FIELD pmcc006 name="input.a.pmcc006"
           
            IF cl_null(g_pmcc_m.pmcc006) THEN
               LET g_pmcc_m.pmcc006 = 0  
            END IF            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc006
            #add-point:BEFORE FIELD pmcc006 name="input.b.pmcc006"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcc006
            #add-point:ON CHANGE pmcc006 name="input.g.pmcc006"
 
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmcc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc001
            #add-point:ON ACTION controlp INFIELD pmcc001 name="input.c.pmcc001"
 
            #END add-point
 
 
         #Ctrlp:input.c.pmcc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc002
            #add-point:ON ACTION controlp INFIELD pmcc002 name="input.c.pmcc002"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcc_m.pmcc002             #給予default值

            #給予arg
            SELECT gzsz008 INTO l_gzsz008 FROM gzsz_t 
             WHERE gzsz001 = 'ooaa_t' AND gzsz002 = 'E-CIR-0001'
            LET g_qryparam.arg1 = l_gzsz008
            CALL q_rtax001_3()                                #呼叫開窗
            LET g_qryparam.arg1 = null
            LET g_pmcc_m.pmcc002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmcc_m.pmcc002 TO pmcc002              #顯示到畫面上
            CALL apmi810_display_pmcc002(g_pmcc_m.pmcc002)
            NEXT FIELD pmcc002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmcc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc003
            #add-point:ON ACTION controlp INFIELD pmcc003 name="input.c.pmcc003"
 
            #END add-point
 
 
         #Ctrlp:input.c.pmcc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc004
            #add-point:ON ACTION controlp INFIELD pmcc004 name="input.c.pmcc004"
 
            #END add-point
 
 
         #Ctrlp:input.c.pmccstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmccstus
            #add-point:ON ACTION controlp INFIELD pmccstus name="input.c.pmccstus"
 
            #END add-point
 
 
         #Ctrlp:input.c.pmcc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc005
            #add-point:ON ACTION controlp INFIELD pmcc005 name="input.c.pmcc005"
 
            #END add-point
 
 
         #Ctrlp:input.c.pmcc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc006
            #add-point:ON ACTION controlp INFIELD pmcc006 name="input.c.pmcc006"
                  
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_pmcc_m.pmcc001,g_pmcc_m.pmcc002
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                  IF g_pmcc_m.pmcc005+g_pmcc_m.pmcc006<>100 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apm-00062"
                     LET g_errparam.extend = g_pmcc_m.pmcc005||"+"||g_pmcc_m.pmcc006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD pmcc005
                  END IF
                                  
               #end add-point
               
               INSERT INTO pmcc_t (pmccent,pmcc001,pmcc002,pmcc003,pmcc004,pmccstus,pmccownid,pmccowndp, 
                   pmcccrtid,pmcccrtdp,pmcccrtdt,pmccmodid,pmccmoddt,pmcc005,pmcc006)
               VALUES (g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,g_pmcc_m.pmcc003,g_pmcc_m.pmcc004, 
                   g_pmcc_m.pmccstus,g_pmcc_m.pmccownid,g_pmcc_m.pmccowndp,g_pmcc_m.pmcccrtid,g_pmcc_m.pmcccrtdp, 
                   g_pmcc_m.pmcccrtdt,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmoddt,g_pmcc_m.pmcc005,g_pmcc_m.pmcc006)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_pmcc_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
 
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
                  SELECT count(*) INTO l_count1 FROM ooff_t WHERE ooff001 = '5' AND ooff002=g_pmcc_m.pmcc001
                     AND ooff003 = g_pmcc_m.pmcc002 AND ooff012='4' AND ooffent=g_enterprise
                  IF l_count1>0 THEN
                     UPDATE ooff_t SET ooff013 = g_pmcc_m.ooff013
                      WHERE ooff001 = '5' AND ooff002=g_pmcc_m.pmcc001
                        AND ooff003 = g_pmcc_m.pmcc002 AND ooffent=g_enterprise
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CONTINUE DIALOG
                     END IF
                  ELSE
                     INSERT INTO ooff_t(ooffent,ooff001,ooff002,ooff003,ooff004,ooff005,ooff006,ooff007,ooff008,ooff009,
                                        ooff010,ooff011,ooff012,ooff013 )  
                     values(g_enterprise,'5',g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,' ',' ',' ',' ',' ',' ',' ',' ','4',g_pmcc_m.ooff013 )
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CONTINUE DIALOG
                     END IF                        
                  END IF 
                  CALL apmi810_insert_pmcd003() RETURNING g_success
                  IF g_success<>1 THEN
                     CONTINUE DIALOG
                  END IF                  
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apmi810_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL apmi810_b_fill()
                  CALL apmi810_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
              
               IF (g_pmcc_m.pmcc005+g_pmcc_m.pmcc006)<>100 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "apm-00062"
                  LET g_errparam.extend = g_pmcc_m.pmcc005||"+"||g_pmcc_m.pmcc006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD pmcc005
               END IF
               #end add-point
               
               #將遮罩欄位還原
               CALL apmi810_pmcc_t_mask_restore('restore_mask_o')
               
               UPDATE pmcc_t SET (pmcc001,pmcc002,pmcc003,pmcc004,pmccstus,pmccownid,pmccowndp,pmcccrtid, 
                   pmcccrtdp,pmcccrtdt,pmccmodid,pmccmoddt,pmcc005,pmcc006) = (g_pmcc_m.pmcc001,g_pmcc_m.pmcc002, 
                   g_pmcc_m.pmcc003,g_pmcc_m.pmcc004,g_pmcc_m.pmccstus,g_pmcc_m.pmccownid,g_pmcc_m.pmccowndp, 
                   g_pmcc_m.pmcccrtid,g_pmcc_m.pmcccrtdp,g_pmcc_m.pmcccrtdt,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmoddt, 
                   g_pmcc_m.pmcc005,g_pmcc_m.pmcc006)
                WHERE pmccent = g_enterprise AND pmcc001 = g_pmcc001_t
                  AND pmcc002 = g_pmcc002_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "pmcc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
 
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL apmi810_pmcc_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_pmcc_m_t)
               LET g_log2 = util.JSON.stringify(g_pmcc_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                  SELECT count(*) INTO l_count1 FROM ooff_t WHERE ooff001 = '5' AND ooff002=g_pmcc_m.pmcc001
                     AND ooff003 = g_pmcc_m.pmcc002 AND ooff012='4' AND ooffent=g_enterprise
                  IF l_count1>0 THEN
                     UPDATE ooff_t SET ooff013 = g_pmcc_m.ooff013
                      WHERE ooff001 = '5' AND ooff002=g_pmcc_m.pmcc001
                        AND ooff003 = g_pmcc_m.pmcc002 AND ooffent=g_enterprise
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CALL s_transaction_end('N','0')
                        RETURN
                     END IF
                  ELSE
                     INSERT INTO ooff_t(ooffent,ooff001,ooff002,ooff003,ooff004,ooff005,ooff006,ooff007,ooff008,ooff009,
                                        ooff010,ooff011,ooff012,ooff013 )  
                     values(g_enterprise,'5',g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,' ',' ',' ',' ',' ',' ',' ',' ','4',g_pmcc_m.ooff013 )
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CALL s_transaction_end('N','0')
                        RETURN
                     END IF                     
                  END IF  
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_pmcc001_t = g_pmcc_m.pmcc001
            LET g_pmcc002_t = g_pmcc_m.pmcc002
 
            
      END INPUT
   
 
{</section>}
 
{<section id="apmi810.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_pmcd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmcd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmi810_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_pmcd_d.getLength()
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
            OPEN apmi810_cl USING g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmi810_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmi810_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_pmcd_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pmcd_d[l_ac].pmcd003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pmcd_d_t.* = g_pmcd_d[l_ac].*  #BACKUP
               LET g_pmcd_d_o.* = g_pmcd_d[l_ac].*  #BACKUP
               CALL apmi810_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL apmi810_set_no_entry_b(l_cmd)
               IF NOT apmi810_lock_b("pmcd_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmi810_bcl INTO g_pmcd_d[l_ac].pmcd003,g_pmcd_d[l_ac].pmcd004
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_pmcd_d_t.pmcd003,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pmcd_d_mask_o[l_ac].* =  g_pmcd_d[l_ac].*
                  CALL apmi810_pmcd_t_mask()
                  LET g_pmcd_d_mask_n[l_ac].* =  g_pmcd_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apmi810_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL apmi810_b_fill_2()
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
            INITIALIZE g_pmcd_d[l_ac].* TO NULL 
            INITIALIZE g_pmcd_d_t.* TO NULL 
            INITIALIZE g_pmcd_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_pmcd_d[l_ac].pmcd004 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_pmcd_d_t.* = g_pmcd_d[l_ac].*     #新輸入資料
            LET g_pmcd_d_o.* = g_pmcd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmi810_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL apmi810_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmcd_d[li_reproduce_target].* = g_pmcd_d[li_reproduce].*
 
               LET g_pmcd_d[li_reproduce_target].pmcd003 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM pmcd_t 
             WHERE pmcdent = g_enterprise AND pmcd001 = g_pmcc_m.pmcc001
               AND pmcd002 = g_pmcc_m.pmcc002
 
               AND pmcd003 = g_pmcd_d[l_ac].pmcd003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
 
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmcc_m.pmcc001
               LET gs_keys[2] = g_pmcc_m.pmcc002
               LET gs_keys[3] = g_pmcd_d[g_detail_idx].pmcd003
               CALL apmi810_insert_b('pmcd_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
 
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_pmcd_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmcd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apmi810_b_fill()
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
               LET gs_keys[01] = g_pmcc_m.pmcc001
               LET gs_keys[gs_keys.getLength()+1] = g_pmcc_m.pmcc002
 
               LET gs_keys[gs_keys.getLength()+1] = g_pmcd_d_t.pmcd003
 
            
               #刪除同層單身
               IF NOT apmi810_delete_b('pmcd_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmi810_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apmi810_key_delete_b(gs_keys,'pmcd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmi810_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
 
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE apmi810_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
 
               #end add-point
               LET l_count = g_pmcd_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
 
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pmcd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcd003
            #add-point:BEFORE FIELD pmcd003 name="input.b.page1.pmcd003"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcd003
            
            #add-point:AFTER FIELD pmcd003 name="input.a.page1.pmcd003"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_pmcc_m.pmcc001) AND NOT cl_null(g_pmcc_m.pmcc002) AND NOT cl_null(g_pmcd_d[l_ac].pmcd003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_pmcc_m.pmcc001 != g_pmcc001_t OR g_pmcc_m.pmcc002 != g_pmcc002_t OR g_pmcd_d[l_ac].pmcd003 != g_pmcd_d_t.pmcd003))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmcd_t WHERE "||"pmcdent = '" ||g_enterprise|| "' AND "||"pmcd001 = '"||g_pmcc_m.pmcc001 ||"' AND "|| "pmcd002 = '"||g_pmcc_m.pmcc002 ||"' AND "|| "pmcd003 = '"||g_pmcd_d[l_ac].pmcd003 ||"'",'std-00004',0) THEN 
                     LET g_pmcd_d[l_ac].pmcd003 = g_pmcd_d_t.pmcd003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcd003
            #add-point:ON CHANGE pmcd003 name="input.g.page1.pmcd003"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcd004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmcd_d[l_ac].pmcd004,"0.000","1","100.000","1","azz-00087",1) THEN 
 
               NEXT FIELD pmcd004
            END IF 
 
 
 
            #add-point:AFTER FIELD pmcd004 name="input.a.page1.pmcd004"
            IF cl_null(g_pmcd_d[l_ac].pmcd004) THEN 
               LET g_pmcd_d[l_ac].pmcd004 = 0
            END IF
             

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcd004
            #add-point:BEFORE FIELD pmcd004 name="input.b.page1.pmcd004"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcd004
            #add-point:ON CHANGE pmcd004 name="input.g.page1.pmcd004"
 
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pmcd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcd003
            #add-point:ON ACTION controlp INFIELD pmcd003 name="input.c.page1.pmcd003"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmcd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcd004
            #add-point:ON ACTION controlp INFIELD pmcd004 name="input.c.page1.pmcd004"
 
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pmcd_d[l_ac].* = g_pmcd_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmi810_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pmcd_d[l_ac].pmcd003 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_pmcd_d[l_ac].* = g_pmcd_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
 
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL apmi810_pmcd_t_mask_restore('restore_mask_o')
      
               UPDATE pmcd_t SET (pmcd001,pmcd002,pmcd003,pmcd004) = (g_pmcc_m.pmcc001,g_pmcc_m.pmcc002, 
                   g_pmcd_d[l_ac].pmcd003,g_pmcd_d[l_ac].pmcd004)
                WHERE pmcdent = g_enterprise AND pmcd001 = g_pmcc_m.pmcc001 
                  AND pmcd002 = g_pmcc_m.pmcc002 
 
                  AND pmcd003 = g_pmcd_d_t.pmcd003 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
 
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_pmcd_d[l_ac].* = g_pmcd_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmcd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_pmcd_d[l_ac].* = g_pmcd_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmcd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmcc_m.pmcc001
               LET gs_keys_bak[1] = g_pmcc001_t
               LET gs_keys[2] = g_pmcc_m.pmcc002
               LET gs_keys_bak[2] = g_pmcc002_t
               LET gs_keys[3] = g_pmcd_d[g_detail_idx].pmcd003
               LET gs_keys_bak[3] = g_pmcd_d_t.pmcd003
               CALL apmi810_update_b('pmcd_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL apmi810_pmcd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_pmcd_d[g_detail_idx].pmcd003 = g_pmcd_d_t.pmcd003 
 
                  ) THEN
                  LET gs_keys[01] = g_pmcc_m.pmcc001
                  LET gs_keys[gs_keys.getLength()+1] = g_pmcc_m.pmcc002
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pmcd_d_t.pmcd003
 
                  CALL apmi810_key_update_b(gs_keys,'pmcd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pmcc_m),util.JSON.stringify(g_pmcd_d_t)
               LET g_log2 = util.JSON.stringify(g_pmcc_m),util.JSON.stringify(g_pmcd_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
 
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL apmi810_unlock_b("pmcd_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            LET l_pmcd004 = 0 
            SELECT sum(nvl(pmcd004,0)) INTO l_pmcd004 FROM pmcd_t WHERE pmcdent = g_enterprise AND pmcd001 = g_pmcc_m.pmcc001
               AND pmcd002 = g_pmcc_m.pmcc002   
            IF l_pmcd004!=100 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "apm-00172"
               LET g_errparam.extend = l_pmcd004
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               NEXT FIELD pmcd004                      
            END IF
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_pmcd_d[li_reproduce_target].* = g_pmcd_d[li_reproduce].*
 
               LET g_pmcd_d[li_reproduce_target].pmcd003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pmcd_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pmcd_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_pmcd3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmcd3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmi810_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_pmcd3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmcd3_d[l_ac].* TO NULL 
            INITIALIZE g_pmcd3_d_t.* TO NULL 
            INITIALIZE g_pmcd3_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_pmcd3_d[l_ac].pmce005 = "0"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_pmcd3_d_t.* = g_pmcd3_d[l_ac].*     #新輸入資料
            LET g_pmcd3_d_o.* = g_pmcd3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmi810_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL apmi810_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmcd3_d[li_reproduce_target].* = g_pmcd3_d[li_reproduce].*
 
               LET g_pmcd3_d[li_reproduce_target].pmce003 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
 
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
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
            OPEN apmi810_cl USING g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmi810_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmi810_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_pmcd3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pmcd3_d[l_ac].pmce003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_pmcd3_d_t.* = g_pmcd3_d[l_ac].*  #BACKUP
               LET g_pmcd3_d_o.* = g_pmcd3_d[l_ac].*  #BACKUP
               CALL apmi810_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL apmi810_set_no_entry_b(l_cmd)
               IF NOT apmi810_lock_b("pmce_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmi810_bcl2 INTO g_pmcd3_d[l_ac].pmce003,g_pmcd3_d[l_ac].pmce004,g_pmcd3_d[l_ac].pmce005 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pmcd3_d_mask_o[l_ac].* =  g_pmcd3_d[l_ac].*
                  CALL apmi810_pmce_t_mask()
                  LET g_pmcd3_d_mask_n[l_ac].* =  g_pmcd3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apmi810_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
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
               
               #add-point:單身2刪除前 name="input.body3.b_delete"
 
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_pmcc_m.pmcc001
               LET gs_keys[gs_keys.getLength()+1] = g_pmcc_m.pmcc002
               LET gs_keys[gs_keys.getLength()+1] = g_pmcd3_d_t.pmce003
            
               #刪除同層單身
               IF NOT apmi810_delete_b('pmce_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmi810_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apmi810_key_delete_b(gs_keys,'pmce_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmi810_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body3.m_delete"
 
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE apmi810_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body3.a_delete"
 
               #end add-point
               LET l_count = g_pmcd_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
 
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pmcd3_d.getLength() + 1) THEN
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
               
            #add-point:單身2新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM pmce_t 
             WHERE pmceent = g_enterprise AND pmce001 = g_pmcc_m.pmcc001
               AND pmce002 = g_pmcc_m.pmcc002
               AND pmce003 = g_pmcd3_d[l_ac].pmce003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body3.b_insert"
 
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmcc_m.pmcc001
               LET gs_keys[2] = g_pmcc_m.pmcc002
               LET gs_keys[3] = g_pmcd3_d[g_detail_idx].pmce003
               CALL apmi810_insert_b('pmce_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body3.a_insert"
 
               #end add-point
            ELSE    
               INITIALIZE g_pmcd_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "pmce_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apmi810_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
 
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pmcd3_d[l_ac].* = g_pmcd3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmi810_bcl2
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
               LET g_pmcd3_d[l_ac].* = g_pmcd3_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body3.b_update"
 
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL apmi810_pmce_t_mask_restore('restore_mask_o')
                              
               UPDATE pmce_t SET (pmce001,pmce002,pmce003,pmce004,pmce005) = (g_pmcc_m.pmcc001,g_pmcc_m.pmcc002, 
                   g_pmcd3_d[l_ac].pmce003,g_pmcd3_d[l_ac].pmce004,g_pmcd3_d[l_ac].pmce005) #自訂欄位頁簽 
 
                WHERE pmceent = g_enterprise AND pmce001 = g_pmcc_m.pmcc001
                  AND pmce002 = g_pmcc_m.pmcc002
                  AND pmce003 = g_pmcd3_d_t.pmce003 #項次 
                  
               #add-point:單身page2修改中 name="input.body3.m_update"
 
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_pmcd3_d[l_ac].* = g_pmcd3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmce_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_pmcd3_d[l_ac].* = g_pmcd3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmce_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmcc_m.pmcc001
               LET gs_keys_bak[1] = g_pmcc001_t
               LET gs_keys[2] = g_pmcc_m.pmcc002
               LET gs_keys_bak[2] = g_pmcc002_t
               LET gs_keys[3] = g_pmcd3_d[g_detail_idx].pmce003
               LET gs_keys_bak[3] = g_pmcd3_d_t.pmce003
               CALL apmi810_update_b('pmce_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL apmi810_pmce_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_pmcd3_d[g_detail_idx].pmce003 = g_pmcd3_d_t.pmce003 
                  ) THEN
                  LET gs_keys[01] = g_pmcc_m.pmcc001
                  LET gs_keys[gs_keys.getLength()+1] = g_pmcc_m.pmcc002
                  LET gs_keys[gs_keys.getLength()+1] = g_pmcd3_d_t.pmce003
                  CALL apmi810_key_update_b(gs_keys,'pmce_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pmcc_m),util.JSON.stringify(g_pmcd3_d_t)
               LET g_log2 = util.JSON.stringify(g_pmcc_m),util.JSON.stringify(g_pmcd3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body3.a_update"
 
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmce003
            
            #add-point:AFTER FIELD pmce003 name="input.a.page3.pmce003"
            #此段落由子樣板a05產生
            IF  g_pmcc_m.pmcc001 IS NOT NULL AND g_pmcc_m.pmcc002 IS NOT NULL AND g_pmcd3_d[g_detail_idx].pmce003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmcc_m.pmcc001 != g_pmcc001_t OR g_pmcc_m.pmcc002 != g_pmcc002_t OR g_pmcd3_d[g_detail_idx].pmce003 != g_pmcd3_d_t.pmce003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmce_t WHERE "||"pmceent = '" ||g_enterprise|| "' AND "||"pmce001 = '"||g_pmcc_m.pmcc001 ||"' AND "|| "pmce002 = '"||g_pmcc_m.pmcc002 ||"' AND "|| "pmce003 = '"||g_pmcd3_d[g_detail_idx].pmce003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmce003
            #add-point:BEFORE FIELD pmce003 name="input.b.page3.pmce003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmce003
            #add-point:ON CHANGE pmce003 name="input.g.page3.pmce003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmce004
            
            #add-point:AFTER FIELD pmce004 name="input.a.page3.pmce004"
            LET g_pmcd3_d[l_ac].pmce004_desc = NULL
            DISPLAY BY NAME g_pmcd3_d[l_ac].pmce004_desc
            IF  NOT cl_null(g_pmcd3_d[l_ac].pmce004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmcd3_d[l_ac].pmce004 != g_pmcd3_d_t.pmce004 OR g_pmcd3_d_t.pmce004 IS NULL )) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmcd3_d[l_ac].pmce004
                  let g_chkparam.arg2 = g_today

                  #160318-00025#47  2016/04/29  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#47  2016/04/29  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooeg001_3") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     let g_pmcd3_d[l_ac].pmce004 = g_pmcd3_d_t.pmce004 
                     CALL apmi810_display_pmce004()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            CALL apmi810_display_pmce004()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmce004
            #add-point:BEFORE FIELD pmce004 name="input.b.page3.pmce004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmce004
            #add-point:ON CHANGE pmce004 name="input.g.page3.pmce004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmce005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmcd3_d[l_ac].pmce005,"0.000","1","100.000","0","azz-00087",1)  
                THEN
               NEXT FIELD pmce005
            END IF 
 
 
 
            #add-point:AFTER FIELD pmce005 name="input.a.page3.pmce005"
            IF NOT cl_null(g_pmcd3_d[l_ac].pmce005) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmce005
            #add-point:BEFORE FIELD pmce005 name="input.b.page3.pmce005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmce005
            #add-point:ON CHANGE pmce005 name="input.g.page3.pmce005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.pmce003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmce003
            #add-point:ON ACTION controlp INFIELD pmce003 name="input.c.page3.pmce003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcd3_d[l_ac].pmce003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2052" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmcd3_d[l_ac].pmce003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmcd3_d[l_ac].pmce003 TO pmce003              #顯示到畫面上

            NEXT FIELD pmce003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.pmce004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmce004
            #add-point:ON ACTION controlp INFIELD pmce004 name="input.c.page3.pmce004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcd3_d[l_ac].pmce004             #給予default值
            LET g_qryparam.arg1 = g_today
            #給予arg

            CALL q_ooeg001()                                #呼叫開窗

            LET g_pmcd3_d[l_ac].pmce004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmcd3_d[l_ac].pmce004 TO pmce004              #顯示到畫面上
            call apmi810_display_pmce004()
            NEXT FIELD pmce004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.pmce005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmce005
            #add-point:ON ACTION controlp INFIELD pmce005 name="input.c.page3.pmce005"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pmcd3_d[l_ac].* = g_pmcd3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmi810_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL apmi810_unlock_b("pmce_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
 
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_pmcd3_d[li_reproduce_target].* = g_pmcd3_d[li_reproduce].*
 
               LET g_pmcd3_d[li_reproduce_target].pmce003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_pmcd3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pmcd3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_pmcd4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmcd4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmi810_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_pmcd4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmcd4_d[l_ac].* TO NULL 
            INITIALIZE g_pmcd4_d_t.* TO NULL 
            INITIALIZE g_pmcd4_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_pmcd4_d_t.* = g_pmcd4_d[l_ac].*     #新輸入資料
            LET g_pmcd4_d_o.* = g_pmcd4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmi810_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL apmi810_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmcd4_d[li_reproduce_target].* = g_pmcd4_d[li_reproduce].*
 
               LET g_pmcd4_d[li_reproduce_target].pmcf003 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body4.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN apmi810_cl USING g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmi810_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmi810_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_pmcd4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pmcd4_d[l_ac].pmcf003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_pmcd4_d_t.* = g_pmcd4_d[l_ac].*  #BACKUP
               LET g_pmcd4_d_o.* = g_pmcd4_d[l_ac].*  #BACKUP
               CALL apmi810_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL apmi810_set_no_entry_b(l_cmd)
               IF NOT apmi810_lock_b("pmcf_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmi810_bcl3 INTO g_pmcd4_d[l_ac].pmcf003,g_pmcd4_d[l_ac].pmcf004,g_pmcd4_d[l_ac].pmcf005, 
                      g_pmcd4_d[l_ac].pmcf006
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pmcd4_d_mask_o[l_ac].* =  g_pmcd4_d[l_ac].*
                  CALL apmi810_pmcf_t_mask()
                  LET g_pmcd4_d_mask_n[l_ac].* =  g_pmcd4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apmi810_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body4.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body4.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body4.b_delete_ask"
               
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
               
               #add-point:單身3刪除前 name="input.body4.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_pmcc_m.pmcc001
               LET gs_keys[gs_keys.getLength()+1] = g_pmcc_m.pmcc002
               LET gs_keys[gs_keys.getLength()+1] = g_pmcd4_d_t.pmcf003
            
               #刪除同層單身
               IF NOT apmi810_delete_b('pmcf_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmi810_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apmi810_key_delete_b(gs_keys,'pmcf_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmi810_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE apmi810_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_pmcd_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pmcd4_d.getLength() + 1) THEN
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
               
            #add-point:單身3新增前 name="input.body4.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM pmcf_t 
             WHERE pmcfent = g_enterprise AND pmcf001 = g_pmcc_m.pmcc001
               AND pmcf002 = g_pmcc_m.pmcc002
               AND pmcf003 = g_pmcd4_d[l_ac].pmcf003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmcc_m.pmcc001
               LET gs_keys[2] = g_pmcc_m.pmcc002
               LET gs_keys[3] = g_pmcd4_d[g_detail_idx].pmcf003
               CALL apmi810_insert_b('pmcf_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_pmcd_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "pmcf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apmi810_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pmcd4_d[l_ac].* = g_pmcd4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmi810_bcl3
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
               LET g_pmcd4_d[l_ac].* = g_pmcd4_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL apmi810_pmcf_t_mask_restore('restore_mask_o')
                              
               UPDATE pmcf_t SET (pmcf001,pmcf002,pmcf003,pmcf004,pmcf005,pmcf006) = (g_pmcc_m.pmcc001, 
                   g_pmcc_m.pmcc002,g_pmcd4_d[l_ac].pmcf003,g_pmcd4_d[l_ac].pmcf004,g_pmcd4_d[l_ac].pmcf005, 
                   g_pmcd4_d[l_ac].pmcf006) #自訂欄位頁簽
                WHERE pmcfent = g_enterprise AND pmcf001 = g_pmcc_m.pmcc001
                  AND pmcf002 = g_pmcc_m.pmcc002
                  AND pmcf003 = g_pmcd4_d_t.pmcf003 #項次 
                  
               #add-point:單身page3修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_pmcd4_d[l_ac].* = g_pmcd4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmcf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_pmcd4_d[l_ac].* = g_pmcd4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmcf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmcc_m.pmcc001
               LET gs_keys_bak[1] = g_pmcc001_t
               LET gs_keys[2] = g_pmcc_m.pmcc002
               LET gs_keys_bak[2] = g_pmcc002_t
               LET gs_keys[3] = g_pmcd4_d[g_detail_idx].pmcf003
               LET gs_keys_bak[3] = g_pmcd4_d_t.pmcf003
               CALL apmi810_update_b('pmcf_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL apmi810_pmcf_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_pmcd4_d[g_detail_idx].pmcf003 = g_pmcd4_d_t.pmcf003 
                  ) THEN
                  LET gs_keys[01] = g_pmcc_m.pmcc001
                  LET gs_keys[gs_keys.getLength()+1] = g_pmcc_m.pmcc002
                  LET gs_keys[gs_keys.getLength()+1] = g_pmcd4_d_t.pmcf003
                  CALL apmi810_key_update_b(gs_keys,'pmcf_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pmcc_m),util.JSON.stringify(g_pmcd4_d_t)
               LET g_log2 = util.JSON.stringify(g_pmcc_m),util.JSON.stringify(g_pmcd4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcf003
            
            #add-point:AFTER FIELD pmcf003 name="input.a.page4.pmcf003"
            #此段落由子樣板a05產生
            LET g_pmcd4_d[l_ac].pmcf003_desc = NULL
            DISPLAY BY NAME g_pmcd4_d[l_ac].pmcf003_desc
            IF  g_pmcc_m.pmcc001 IS NOT NULL AND g_pmcc_m.pmcc002 IS NOT NULL AND g_pmcd4_d[g_detail_idx].pmcf003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmcc_m.pmcc001 != g_pmcc001_t OR g_pmcc_m.pmcc002 != g_pmcc002_t OR g_pmcd4_d[g_detail_idx].pmcf003 != g_pmcd4_d_t.pmcf003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmcf_t WHERE "||"pmcfent = '" ||g_enterprise|| "' AND "||"pmcf001 = '"||g_pmcc_m.pmcc001 ||"' AND "|| "pmcf002 = '"||g_pmcc_m.pmcc002 ||"' AND "|| "pmcf003 = '"||g_pmcd4_d[g_detail_idx].pmcf003 ||"'",'std-00004',0) THEN 
                     LET g_pmcd4_d[l_ac].pmcf003 = g_pmcd4_d_t.pmcf003
                     CALL apmi810_display_pmcf003()
                     NEXT FIELD CURRENT
                  END IF
                  CALL apmi810_chk_pmcf003()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_pmcd4_d[l_ac].pmcf003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pmcd4_d[l_ac].pmcf003 = g_pmcd4_d_t.pmcf003
                     CALL apmi810_display_pmcf003()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmi810_display_pmcf003()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcf003
            #add-point:BEFORE FIELD pmcf003 name="input.b.page4.pmcf003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcf003
            #add-point:ON CHANGE pmcf003 name="input.g.page4.pmcf003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcf004
            #add-point:BEFORE FIELD pmcf004 name="input.b.page4.pmcf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcf004
            
            #add-point:AFTER FIELD pmcf004 name="input.a.page4.pmcf004"
            IF  g_pmcd4_d[l_ac].pmcf004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_pmcd4_d[l_ac].pmcf004 != g_pmcd4_d_t.pmcf004 or g_pmcd4_d_t.pmcf004 is null)) THEN 
                  CALL apmi810_pmcf005() returning l_success,g_errno
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_pmcd4_d[l_ac].pmcf004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pmcd4_d[l_ac].pmcf004 = g_pmcd4_d_t.pmcf004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcf004
            #add-point:ON CHANGE pmcf004 name="input.g.page4.pmcf004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcf005
            #add-point:BEFORE FIELD pmcf005 name="input.b.page4.pmcf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcf005
            
            #add-point:AFTER FIELD pmcf005 name="input.a.page4.pmcf005"
            IF  g_pmcd4_d[l_ac].pmcf005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_pmcd4_d[l_ac].pmcf005 != g_pmcd4_d_t.pmcf005 or g_pmcd4_d_t.pmcf005 is null)) THEN 
                  CALL apmi810_pmcf005() returning l_success,g_errno
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_pmcd4_d[l_ac].pmcf005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pmcd4_d[l_ac].pmcf005 = g_pmcd4_d_t.pmcf005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcf005
            #add-point:ON CHANGE pmcf005 name="input.g.page4.pmcf005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcf006
            
            #add-point:AFTER FIELD pmcf006 name="input.a.page4.pmcf006"
            LET g_pmcd4_d[l_ac].pmcf006_desc = NULL
            DISPLAY BY NAME g_pmcd4_d[l_ac].pmcf006_desc
            IF  g_pmcd4_d[l_ac].pmcf006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_pmcd4_d[l_ac].pmcf006 != g_pmcd4_d_t.pmcf006 or g_pmcd4_d_t.pmcf006 is null)) THEN 
                  CALL apmi810_pmcf006()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_pmcd4_d[l_ac].pmcf006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pmcd4_d[l_ac].pmcf006 = g_pmcd4_d_t.pmcf006
                     CALL apmi810_display_pmcf006()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmi810_display_pmcf006()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcf006
            #add-point:BEFORE FIELD pmcf006 name="input.b.page4.pmcf006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcf006
            #add-point:ON CHANGE pmcf006 name="input.g.page4.pmcf006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.pmcf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcf003
            #add-point:ON ACTION controlp INFIELD pmcf003 name="input.c.page4.pmcf003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcd4_d[l_ac].pmcf003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2053" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmcd4_d[l_ac].pmcf003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmcd4_d[l_ac].pmcf003 TO pmcf003              #顯示到畫面上
            call apmi810_display_pmcf003()
            NEXT FIELD pmcf003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.pmcf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcf004
            #add-point:ON ACTION controlp INFIELD pmcf004 name="input.c.page4.pmcf004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.pmcf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcf005
            #add-point:ON ACTION controlp INFIELD pmcf005 name="input.c.page4.pmcf005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.pmcf006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcf006
            #add-point:ON ACTION controlp INFIELD pmcf006 name="input.c.page4.pmcf006"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcd4_d[l_ac].pmcf006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2054" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmcd4_d[l_ac].pmcf006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmcd4_d[l_ac].pmcf006 TO pmcf006              #顯示到畫面上
            call apmi810_display_pmcf006()
            NEXT FIELD pmcf006                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pmcd4_d[l_ac].* = g_pmcd4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmi810_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL apmi810_unlock_b("pmcf_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_pmcd4_d[li_reproduce_target].* = g_pmcd4_d[li_reproduce].*
 
               LET g_pmcd4_d[li_reproduce_target].pmcf003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_pmcd4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pmcd4_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="apmi810.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      INPUT ARRAY g_pmcg_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmcg_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 

            CALL apmi810_b_fill()
            CALL apmi810_b_fill_2()
            LET g_rec_b2 = g_pmcg_d.getLength()
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac2 = ARR_CURR()
            LET g_detail_idx = l_ac2
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac2 TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN apmi810_cl USING g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002


            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN apmi810_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE apmi810_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b2 = g_pmcg_d.getLength()
            
            IF g_rec_b2 >= l_ac2 
               AND NOT cl_null(g_pmcg_d[l_ac2].pmcg004) 

            THEN
               LET l_cmd='u'
	           LET g_pmcg_d_t.* = g_pmcg_d[l_ac2].*  #BACKUP
               CALL apmi810_set_entry_b(l_cmd)
               CALL apmi810_set_no_entry_b(l_cmd)
               OPEN apmi810_bcl4 USING g_enterprise,
                                       g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,g_pmcd_d[l_ac].pmcd003,g_pmcg_d[l_ac2].pmcg004
                                       
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "apmi810_bcl4"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmi810_bcl4 INTO g_pmcg_d[l_ac2].pmcg004,g_pmcg_d[l_ac2].pmcg005,g_pmcg_d[l_ac2].pmcg006,g_pmcg_d[l_ac2].pmcg007
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_pmcg_d_t.pmcg004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL apmi810_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmcg_d[l_ac2].* TO NULL 
            LET g_pmcg_d_t.* = g_pmcg_d[l_ac2].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmi810_set_entry_b(l_cmd)
            CALL apmi810_set_no_entry_b(l_cmd)
            #公用欄位給值(單身)
            
            
            #add-point:modify段before insert

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
            SELECT COUNT(*) INTO l_count FROM pmcg_t 
             WHERE pmcgent = g_enterprise AND pmcg001 = g_pmcc_m.pmcc001
               AND pmcg002 = g_pmcc_m.pmcc002
               AND pmcg003 = g_pmcd_d[l_ac].pmcd003
               AND pmcg004 = g_pmcg_d[l_ac2].pmcg004 

                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmcc_m.pmcc001
               LET gs_keys[2] = g_pmcc_m.pmcc002
               LET gs_keys[3] = g_pmcd_d[l_ac].pmcd003
               INSERT INTO pmcg_t
                  (pmcgent,pmcg001,pmcg002,pmcg003,pmcg004,pmcg005,pmcg006,pmcg007) 
               VALUES(g_enterprise,
                   g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,g_pmcd_d[l_ac].pmcd003
                   ,g_pmcg_d[l_ac2].pmcg004,g_pmcg_d[l_ac2].pmcg005,g_pmcg_d[l_ac2].pmcg006,
                   g_pmcg_d[l_ac2].pmcg007)

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pmcg_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

               END IF
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_pmcg_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmcg_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b2 = g_rec_b2 + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_pmcg_d[l_ac2].pmcg004) 

               THEN 
               
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
               
               DELETE FROM pmcg_t
                WHERE pmcgent = g_enterprise AND pmcg001 = g_pmcc_m.pmcc001 
                  AND pmcg002 = g_pmcc_m.pmcc002 AND pmcg003 = g_pmcd_d[l_ac].pmcd003
                  AND pmcg004 = g_pmcg_d[l_ac2].pmcg004  
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmcg_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b2 = g_rec_b2-1
                  
                  #add-point:單身刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE apmi810_bcl4
               LET l_count = g_pmcg_d.getLength()
            END IF 
            
            INITIALIZE gs_keys TO NULL 
            LET gs_keys[1] = g_pmcc_m.pmcc001
            LET gs_keys[2] = g_pmcc_m.pmcc002
            LET gs_keys[3] = g_pmcd_d[l_ac].pmcd003

              
         AFTER DELETE 
            DELETE FROM pmcg_t
             WHERE pmcgent = g_enterprise AND pmcg001 = g_pmcc_m.pmcc001 
               AND pmcg002 = g_pmcc_m.pmcc002 AND pmcg003 = g_pmcd_d[l_ac].pmcd003
               AND pmcg004 = g_pmcg_d_t.pmcg004  
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmcg_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
            END IF
 
         #----<<pmcg003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmcg004


         #此段落由子樣板a02產生
         AFTER FIELD pmcg004
            
            #add-point:AFTER FIELD pmcg004
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_pmcc_m.pmcc001) AND NOT cl_null(g_pmcc_m.pmcc002) AND NOT cl_null(g_pmcg_d[l_ac2].pmcg004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_pmcc_m.pmcc001 != g_pmcc001_t OR g_pmcc_m.pmcc002 != g_pmcc002_t OR g_pmcg_d[l_ac2].pmcg004 != g_pmcg_d_t.pmcg004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmcg_t WHERE "||"pmcgent = '" ||g_enterprise|| "' AND "||"pmcg001 = '"||g_pmcc_m.pmcc001 ||"' AND "|| "pmcg002 = '"||g_pmcc_m.pmcc002 ||"' AND "|| "pmcg003 = '"||g_pmcd_d[l_ac].pmcd003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            

         #此段落由子樣板a04產生
         ON CHANGE pmcg004
            #add-point:ON CHANGE pmcg004

            #END add-point

         #----<<pmcg004>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmcg005
            #此段落由子樣板a15產生


            #add-point:AFTER FIELD pmcg005
            LET g_success = 1
            LET g_errno = NULL
            CALL apmi810_pmcg005()  RETURNING  g_success,g_errno 
            IF g_success<> TRUE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_pmcg_d[l_ac2].pmcg005||'-'||g_pmcg_d[l_ac2].pmcg006
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pmcg_d[l_ac2].pmcg005 = g_pmcg_d_t.pmcg005
               NEXT FIELD pmcg005
            END IF            
            #END add-point
            

         #此段落由子樣板a01產生
         BEFORE FIELD pmcg005
            #add-point:BEFORE FIELD pmcg005
            CALL apmi810_pmcg004()
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmcg005
            #add-point:ON CHANGE pmcg005

            #END add-point

         AFTER FIELD pmcg006
            #此段落由子樣板a15產生


            #add-point:AFTER FIELD pmcg006
            LET g_success = 1
            LET g_errno = NULL
            CALL apmi810_pmcg005()  RETURNING  g_success,g_errno 
            IF g_success<> TRUE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_pmcg_d[l_ac2].pmcg005||'-'||g_pmcg_d[l_ac2].pmcg006
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pmcg_d[l_ac2].pmcg006 = g_pmcg_d_t.pmcg006
               NEXT FIELD pmcg006
            END IF

            #END add-point
            

         #此段落由子樣板a01產生
         BEFORE FIELD pmcg006
            #add-point:BEFORE FIELD pmcg006

            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmcg006
            #add-point:ON CHANGE pmcg006

            #END add-point
         
         AFTER FIELD pmcg007
            #此段落由子樣板a15產生

            IF NOT cl_ap_chk_Range(g_pmcg_d[l_ac2].pmcg007,"0.000","1","100.000","1","azz-00087",1) THEN
               LET g_pmcg_d[l_ac2].pmcg007=g_pmcg_d_t.pmcg007
               NEXT FIELD pmcg007
            END IF
            

         #此段落由子樣板a01產生
         BEFORE FIELD pmcg007
            #add-point:BEFORE FIELD pmcg007

            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmcg007
            #add-point:ON CHANGE pmcg007

            #END add-point

 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pmcg_d[l_ac2].* = g_pmcg_d_t.*
               CLOSE apmi810_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_pmcg_d[l_ac2].pmcg004
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pmcg_d[l_ac2].* = g_pmcg_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               
               UPDATE pmcg_t SET (pmcg001,pmcg002,pmcg003,pmcg004,pmcg005,pmcg006,pmcg007) = 
                                 (g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,g_pmcd_d[l_ac].pmcd003,
                                  g_pmcg_d[l_ac2].pmcg004,g_pmcg_d[l_ac2].pmcg005,g_pmcg_d[l_ac2].pmcg006,
                                  g_pmcg_d[l_ac2].pmcg007)
                WHERE pmcgent = g_enterprise AND pmcg001 = g_pmcc_m.pmcc001 
                  AND pmcg002 = g_pmcc_m.pmcc002 
                  AND pmcg003 = g_pmcd_d[l_ac].pmcd003 #項次
                  AND pmcg004 = g_pmcg_d[l_ac2].pmcg004   
    
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmcg_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_pmcg_d[l_ac2].* = g_pmcg_d_t.*
               ELSE
                  INITIALIZE gs_keys TO NULL 
                  LET gs_keys[1] = g_pmcc_m.pmcc001
                  LET gs_keys_bak[1] = g_pmcc001_t 
                  LET gs_keys[2] = g_pmcc_m.pmcc002
                  LET gs_keys_bak[2] = g_pmcc002_t 
                  LET gs_keys[3] = g_pmcd_d[l_ac].pmcd003
                  LET gs_keys_bak[3] = g_pmcd_d_t.pmcd003
                  LET gs_keys[4] = g_pmcg_d[l_ac2].pmcg004
                  LET gs_keys_bak[4] = g_pmcg_d_t.pmcg004
                  CALL apmi810_update_pmcg('pmcg_t',gs_keys,gs_keys_bak,"'1'")
                  
               END IF
 
            END IF
            
         AFTER ROW
            LET l_ac2 = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pmcg_d[l_ac2].* = g_pmcg_d_t.*
               END IF
               CLOSE apmi810_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            CLOSE apmi810_bcl4
            CALL s_transaction_end('Y','0')
            
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
              
      END INPUT
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'3',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD pmcc001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pmcd003
               WHEN "s_detail3"
                  NEXT FIELD pmce003
               WHEN "s_detail4"
                  NEXT FIELD pmcf003
 
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
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
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
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
 
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="apmi810.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apmi810_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_msg     STRING
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
 
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL apmi810_b_fill() #單身填充
      CALL apmi810_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apmi810_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL apmi810_b_fill_2() 
   SELECT ooff013 INTO g_pmcc_m.ooff013 FROM ooff_t
    WHERE ooffent = g_enterprise AND ooff001='5' AND ooff002=g_pmcc_m.pmcc001
      AND ooff003 = g_pmcc_m.pmcc002 AND ooff012='4'
   DISPLAY BY NAME g_pmcc_m.ooff013 
   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmcc_m.pmcc002
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmcc_m.pmcc002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmcc_m.pmcc002_desc
            IF g_pmcc_m.pmcc002 ='ALL' OR g_pmcc_m.pmcc002='all' THEN
               CALL cl_getmsg('apm-00058',g_dlang) RETURNING g_pmcc_m.pmcc002_desc
               DISPLAY BY NAME g_pmcc_m.pmcc002_desc
            END IF

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcc_m.pmccownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pmcc_m.pmccownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pmcc_m.pmccownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcc_m.pmccowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmcc_m.pmccowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pmcc_m.pmccowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcc_m.pmcccrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pmcc_m.pmcccrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pmcc_m.pmcccrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcc_m.pmcccrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmcc_m.pmcccrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pmcc_m.pmcccrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcc_m.pmccmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pmcc_m.pmccmodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pmcc_m.pmccmodid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_pmcc_m_mask_o.* =  g_pmcc_m.*
   CALL apmi810_pmcc_t_mask()
   LET g_pmcc_m_mask_n.* =  g_pmcc_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,g_pmcc_m.pmcc002_desc,g_pmcc_m.pmcc003,g_pmcc_m.pmcc004, 
       g_pmcc_m.ooff013,g_pmcc_m.pmccstus,g_pmcc_m.pmccownid,g_pmcc_m.pmccownid_desc,g_pmcc_m.pmccowndp, 
       g_pmcc_m.pmccowndp_desc,g_pmcc_m.pmcccrtid,g_pmcc_m.pmcccrtid_desc,g_pmcc_m.pmcccrtdp,g_pmcc_m.pmcccrtdp_desc, 
       g_pmcc_m.pmcccrtdt,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmodid_desc,g_pmcc_m.pmccmoddt,g_pmcc_m.pmcc005, 
       g_pmcc_m.pmcc006
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmcc_m.pmccstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_pmcd_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_pmcd3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
            call apmi810_display_pmce004()
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcd3_d[l_ac].pmce003
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2052' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmcd3_d[l_ac].pmce003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pmcd3_d[l_ac].pmce003_desc            
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_pmcd4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcd4_d[l_ac].pmcf003
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2053' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmcd4_d[l_ac].pmcf003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pmcd4_d[l_ac].pmcf003_desc
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcd4_d[l_ac].pmcf006
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2054' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmcd4_d[l_ac].pmcf006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pmcd4_d[l_ac].pmcf006_desc 
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL apmi810_detail_show()
 
   #add-point:show段之後 name="show.after"
   LET  g_ac_t = l_ac
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmi810.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION apmi810_detail_show()
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
 
{<section id="apmi810.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmi810_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE pmcc_t.pmcc001 
   DEFINE l_oldno     LIKE pmcc_t.pmcc001 
   DEFINE l_newno02     LIKE pmcc_t.pmcc002 
   DEFINE l_oldno02     LIKE pmcc_t.pmcc002 
 
   DEFINE l_master    RECORD LIKE pmcc_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pmcd_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE pmce_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE pmcf_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_detail4   RECORD LIKE pmcg_t.*
   DEFINE l_count1    LIKE type_t.num5
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_pmcc_m.pmcc001 IS NULL
   OR g_pmcc_m.pmcc002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_pmcc001_t = g_pmcc_m.pmcc001
   LET g_pmcc002_t = g_pmcc_m.pmcc002
 
    
   LET g_pmcc_m.pmcc001 = ""
   LET g_pmcc_m.pmcc002 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmcc_m.pmccownid = g_user
      LET g_pmcc_m.pmccowndp = g_dept
      LET g_pmcc_m.pmcccrtid = g_user
      LET g_pmcc_m.pmcccrtdp = g_dept 
      LET g_pmcc_m.pmcccrtdt = cl_get_current()
      LET g_pmcc_m.pmccmodid = g_user
      LET g_pmcc_m.pmccmoddt = cl_get_current()
      LET g_pmcc_m.pmccstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmcc_m.pmccstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_pmcc_m.pmcc002_desc = ''
   DISPLAY BY NAME g_pmcc_m.pmcc002_desc
 
   
   CALL apmi810_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_pmcc_m.* TO NULL
      INITIALIZE g_pmcd_d TO NULL
      INITIALIZE g_pmcd3_d TO NULL
      INITIALIZE g_pmcd4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL apmi810_show()
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
   CALL apmi810_set_act_visible()   
   CALL apmi810_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmcc001_t = g_pmcc_m.pmcc001
   LET g_pmcc002_t = g_pmcc_m.pmcc002
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmccent = " ||g_enterprise|| " AND",
                      " pmcc001 = '", g_pmcc_m.pmcc001, "' "
                      ," AND pmcc002 = '", g_pmcc_m.pmcc002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmi810_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
 
   #end add-point
   
   CALL apmi810_idx_chk()
   
   LET g_data_owner = g_pmcc_m.pmccownid      
   LET g_data_dept  = g_pmcc_m.pmccowndp
   
   #功能已完成,通報訊息中心
   CALL apmi810_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="apmi810.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apmi810_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pmcd_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE pmce_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE pmcf_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apmi810_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmcd_t
    WHERE pmcdent = g_enterprise AND pmcd001 = g_pmcc001_t
     AND pmcd002 = g_pmcc002_t
 
    INTO TEMP apmi810_detail
 
   #將key修正為調整後   
   UPDATE apmi810_detail 
      #更新key欄位
      SET pmcd001 = g_pmcc_m.pmcc001
          , pmcd002 = g_pmcc_m.pmcc002
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO pmcd_t SELECT * FROM apmi810_detail
   
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
   DROP TABLE apmi810_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmce_t 
    WHERE pmceent = g_enterprise AND pmce001 = g_pmcc001_t
      AND pmce002 = g_pmcc002_t   
 
    INTO TEMP apmi810_detail
 
   #將key修正為調整後   
   UPDATE apmi810_detail SET pmce001 = g_pmcc_m.pmcc001
                                       , pmce002 = g_pmcc_m.pmcc002
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO pmce_t SELECT * FROM apmi810_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE apmi810_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmcf_t 
    WHERE pmcfent = g_enterprise AND pmcf001 = g_pmcc001_t
      AND pmcf002 = g_pmcc002_t   
 
    INTO TEMP apmi810_detail
 
   #將key修正為調整後   
   UPDATE apmi810_detail SET pmcf001 = g_pmcc_m.pmcc001
                                       , pmcf002 = g_pmcc_m.pmcc002
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO pmcf_t SELECT * FROM apmi810_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE apmi810_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pmcc001_t = g_pmcc_m.pmcc001
   LET g_pmcc002_t = g_pmcc_m.pmcc002
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmi810.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apmi810_delete()
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
   
   IF g_pmcc_m.pmcc001 IS NULL
   OR g_pmcc_m.pmcc002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN apmi810_cl USING g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmi810_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmi810_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmi810_master_referesh USING g_pmcc_m.pmcc001,g_pmcc_m.pmcc002 INTO g_pmcc_m.pmcc001,g_pmcc_m.pmcc002, 
       g_pmcc_m.pmcc003,g_pmcc_m.pmcc004,g_pmcc_m.pmccstus,g_pmcc_m.pmccownid,g_pmcc_m.pmccowndp,g_pmcc_m.pmcccrtid, 
       g_pmcc_m.pmcccrtdp,g_pmcc_m.pmcccrtdt,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmoddt,g_pmcc_m.pmcc005, 
       g_pmcc_m.pmcc006,g_pmcc_m.pmcc002_desc,g_pmcc_m.pmccownid_desc,g_pmcc_m.pmccowndp_desc,g_pmcc_m.pmcccrtid_desc, 
       g_pmcc_m.pmcccrtdp_desc,g_pmcc_m.pmccmodid_desc
   
   
   #檢查是否允許此動作
   IF NOT apmi810_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmcc_m_mask_o.* =  g_pmcc_m.*
   CALL apmi810_pmcc_t_mask()
   LET g_pmcc_m_mask_n.* =  g_pmcc_m.*
   
   CALL apmi810_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
 
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmi810_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_pmcc001_t = g_pmcc_m.pmcc001
      LET g_pmcc002_t = g_pmcc_m.pmcc002
 
 
      DELETE FROM pmcc_t
       WHERE pmccent = g_enterprise AND pmcc001 = g_pmcc_m.pmcc001
         AND pmcc002 = g_pmcc_m.pmcc002
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
 
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_pmcc_m.pmcc001,":",SQLERRMESSAGE  
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
      
      DELETE FROM pmcd_t
       WHERE pmcdent = g_enterprise AND pmcd001 = g_pmcc_m.pmcc001
         AND pmcd002 = g_pmcc_m.pmcc002
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
 
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      DELETE FROM pmcg_t
       WHERE pmcgent = g_enterprise AND pmcg001 = g_pmcc_m.pmcc001
         AND pmcg002 = g_pmcc_m.pmcc002
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmcg_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
 
      #end add-point
      DELETE FROM pmce_t
       WHERE pmceent = g_enterprise AND
             pmce001 = g_pmcc_m.pmcc001 AND pmce002 = g_pmcc_m.pmcc002
      #add-point:單身刪除中 name="delete.body.m_delete2"
 
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmce_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
 
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
 
      #end add-point
      DELETE FROM pmcf_t
       WHERE pmcfent = g_enterprise AND
             pmcf001 = g_pmcc_m.pmcc001 AND pmcf002 = g_pmcc_m.pmcc002
      #add-point:單身刪除中 name="delete.body.m_delete3"
 
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmcf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      CALL g_pmcg_d.clear()
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pmcc_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE apmi810_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_pmcd_d.clear() 
      CALL g_pmcd3_d.clear()       
      CALL g_pmcd4_d.clear()       
 
     
      CALL apmi810_ui_browser_refresh()  
      #CALL apmi810_ui_headershow()  
      #CALL apmi810_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL apmi810_browser_fill("")
         CALL apmi810_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apmi810_cl
 
   #功能已完成,通報訊息中心
   CALL apmi810_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apmi810.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmi810_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   CALL g_pmcg_d.clear()
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_pmcd_d.clear()
   CALL g_pmcd3_d.clear()
   CALL g_pmcd4_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
 
   #end add-point
   
   #判斷是否填充
   IF apmi810_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pmcd003,pmcd004  FROM pmcd_t",   
                     " INNER JOIN pmcc_t ON pmccent = " ||g_enterprise|| " AND pmcc001 = pmcd001 ",
                     " AND pmcc002 = pmcd002 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE pmcdent=? AND pmcd001=? AND pmcd002=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY pmcd_t.pmcd003"
         
         #add-point:單身填充控制 name="b_fill.sql"
 
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmi810_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apmi810_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002 INTO g_pmcd_d[l_ac].pmcd003, 
          g_pmcd_d[l_ac].pmcd004   #(ver:78)
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
   IF apmi810_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pmce003,pmce004,pmce005 ,t1.oocql004 ,t2.ooefl003 FROM pmce_t", 
                
                     " INNER JOIN  pmcc_t ON pmccent = " ||g_enterprise|| " AND pmcc001 = pmce001 ",
                     " AND pmcc002 = pmce002 ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='2052' AND t1.oocql002=pmce003 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=pmce004 AND t2.ooefl002='"||g_dlang||"' ",
 
                     " WHERE pmceent=? AND pmce001=? AND pmce002=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY pmce_t.pmce003"
         
         #add-point:單身填充控制 name="b_fill.sql2"
   
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmi810_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR apmi810_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002 INTO g_pmcd3_d[l_ac].pmce003, 
          g_pmcd3_d[l_ac].pmce004,g_pmcd3_d[l_ac].pmce005,g_pmcd3_d[l_ac].pmce003_desc,g_pmcd3_d[l_ac].pmce004_desc  
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
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_pmcd3_d[l_ac].pmce004
#      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_pmcd3_d[l_ac].pmce004_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_pmcd3_d[l_ac].pmce004_desc 
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
 
   #判斷是否填充
   IF apmi810_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pmcf003,pmcf004,pmcf005,pmcf006 ,t3.oocql004 ,t4.oocql004 FROM pmcf_t", 
                
                     " INNER JOIN  pmcc_t ON pmccent = " ||g_enterprise|| " AND pmcc001 = pmcf001 ",
                     " AND pmcc002 = pmcf002 ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='2053' AND t3.oocql002=pmcf003 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='2054' AND t4.oocql002=pmcf006 AND t4.oocql003='"||g_dlang||"' ",
 
                     " WHERE pmcfent=? AND pmcf001=? AND pmcf002=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY pmcf_t.pmcf003"
         
         #add-point:單身填充控制 name="b_fill.sql3"
 
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmi810_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR apmi810_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002 INTO g_pmcd4_d[l_ac].pmcf003, 
          g_pmcd4_d[l_ac].pmcf004,g_pmcd4_d[l_ac].pmcf005,g_pmcd4_d[l_ac].pmcf006,g_pmcd4_d[l_ac].pmcf003_desc, 
          g_pmcd4_d[l_ac].pmcf006_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
 
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
   
   #end add-point
   
   CALL g_pmcd_d.deleteElement(g_pmcd_d.getLength())
   CALL g_pmcd3_d.deleteElement(g_pmcd3_d.getLength())
   CALL g_pmcd4_d.deleteElement(g_pmcd4_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE apmi810_pb
   FREE apmi810_pb2
 
   FREE apmi810_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_pmcd_d.getLength()
      LET g_pmcd_d_mask_o[l_ac].* =  g_pmcd_d[l_ac].*
      CALL apmi810_pmcd_t_mask()
      LET g_pmcd_d_mask_n[l_ac].* =  g_pmcd_d[l_ac].*
   END FOR
   
   LET g_pmcd3_d_mask_o.* =  g_pmcd3_d.*
   FOR l_ac = 1 TO g_pmcd3_d.getLength()
      LET g_pmcd3_d_mask_o[l_ac].* =  g_pmcd3_d[l_ac].*
      CALL apmi810_pmce_t_mask()
      LET g_pmcd3_d_mask_n[l_ac].* =  g_pmcd3_d[l_ac].*
   END FOR
   LET g_pmcd4_d_mask_o.* =  g_pmcd4_d.*
   FOR l_ac = 1 TO g_pmcd4_d.getLength()
      LET g_pmcd4_d_mask_o[l_ac].* =  g_pmcd4_d[l_ac].*
      CALL apmi810_pmcf_t_mask()
      LET g_pmcd4_d_mask_n[l_ac].* =  g_pmcd4_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="apmi810.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apmi810_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM pmcd_t
       WHERE pmcdent = g_enterprise AND
         pmcd001 = ps_keys_bak[1] AND pmcd002 = ps_keys_bak[2] AND pmcd003 = ps_keys_bak[3]
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
         CALL g_pmcd_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
 
      #end add-point    
      DELETE FROM pmce_t
       WHERE pmceent = g_enterprise AND
             pmce001 = ps_keys_bak[1] AND pmce002 = ps_keys_bak[2] AND pmce003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
 
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmce_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_pmcd3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
 
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
 
      #end add-point    
      DELETE FROM pmcf_t
       WHERE pmcfent = g_enterprise AND
             pmcf001 = ps_keys_bak[1] AND pmcf002 = ps_keys_bak[2] AND pmcf003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
 
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmcf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_pmcd4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
 
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmi810.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apmi810_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO pmcd_t
                  (pmcdent,
                   pmcd001,pmcd002,
                   pmcd003
                   ,pmcd004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_pmcd_d[g_detail_idx].pmcd004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
 
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_pmcd_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
 
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
 
      #end add-point 
      INSERT INTO pmce_t
                  (pmceent,
                   pmce001,pmce002,
                   pmce003
                   ,pmce004,pmce005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_pmcd3_d[g_detail_idx].pmce004,g_pmcd3_d[g_detail_idx].pmce005)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
 
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmce_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_pmcd3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
 
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
 
      #end add-point 
      INSERT INTO pmcf_t
                  (pmcfent,
                   pmcf001,pmcf002,
                   pmcf003
                   ,pmcf004,pmcf005,pmcf006) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_pmcd4_d[g_detail_idx].pmcf004,g_pmcd4_d[g_detail_idx].pmcf005,g_pmcd4_d[g_detail_idx].pmcf006) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
 
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmcf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_pmcd4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
 
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="apmi810.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apmi810_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pmcd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
 
      #end add-point 
      
      #將遮罩欄位還原
      CALL apmi810_pmcd_t_mask_restore('restore_mask_o')
               
      UPDATE pmcd_t 
         SET (pmcd001,pmcd002,
              pmcd003
              ,pmcd004) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_pmcd_d[g_detail_idx].pmcd004) 
         WHERE pmcdent = g_enterprise AND pmcd001 = ps_keys_bak[1] AND pmcd002 = ps_keys_bak[2] AND pmcd003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
 
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmcd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmcd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apmi810_pmcd_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
 
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pmce_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
 
      #end add-point  
      
      #將遮罩欄位還原
      CALL apmi810_pmce_t_mask_restore('restore_mask_o')
               
      UPDATE pmce_t 
         SET (pmce001,pmce002,
              pmce003
              ,pmce004,pmce005) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_pmcd3_d[g_detail_idx].pmce004,g_pmcd3_d[g_detail_idx].pmce005) 
         WHERE pmceent = g_enterprise AND pmce001 = ps_keys_bak[1] AND pmce002 = ps_keys_bak[2] AND pmce003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
 
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmce_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmce_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apmi810_pmce_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
 
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pmcf_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
 
      #end add-point  
      
      #將遮罩欄位還原
      CALL apmi810_pmcf_t_mask_restore('restore_mask_o')
               
      UPDATE pmcf_t 
         SET (pmcf001,pmcf002,
              pmcf003
              ,pmcf004,pmcf005,pmcf006) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_pmcd4_d[g_detail_idx].pmcf004,g_pmcd4_d[g_detail_idx].pmcf005,g_pmcd4_d[g_detail_idx].pmcf006)  
 
         WHERE pmcfent = g_enterprise AND pmcf001 = ps_keys_bak[1] AND pmcf002 = ps_keys_bak[2] AND pmcf003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update3"
 
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmcf_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmcf_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apmi810_pmcf_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
 
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmi810.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION apmi810_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="apmi810.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apmi810_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apmi810.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apmi810_lock_b(ps_table,ps_page)
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
   #CALL apmi810_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "pmcd_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apmi810_bcl USING g_enterprise,
                                       g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,g_pmcd_d[g_detail_idx].pmcd003  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmi810_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "pmce_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN apmi810_bcl2 USING g_enterprise,
                                             g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,g_pmcd3_d[g_detail_idx].pmce003 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmi810_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "pmcf_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN apmi810_bcl3 USING g_enterprise,
                                             g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,g_pmcd4_d[g_detail_idx].pmcf003 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmi810_bcl3:",SQLERRMESSAGE 
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
 
{<section id="apmi810.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apmi810_unlock_b(ps_table,ps_page)
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
      CLOSE apmi810_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apmi810_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apmi810_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="apmi810.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmi810_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
 
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pmcc001,pmcc002",TRUE)
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
 
{<section id="apmi810.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmi810_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
 
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pmcc001,pmcc002",FALSE)
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
 
{<section id="apmi810.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apmi810_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pmcf003",true) 
   END IF
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
 
{<section id="apmi810.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apmi810_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("pmcf003",FALSE) 
   END IF
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
 
{<section id="apmi810.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmi810_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmi810.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmi810_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmi810.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apmi810_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmi810.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apmi810_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmi810.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmi810_default_search()
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
      LET ls_wc = ls_wc, " pmcc001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " pmcc002 = '", g_argv[02], "' AND "
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
 
         INITIALIZE g_wc2_table3 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "pmcc_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "pmcd_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "pmce_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "pmcf_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
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
 
{<section id="apmi810.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION apmi810_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
 
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
 
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_pmcc_m.pmcc001 IS NULL
      OR g_pmcc_m.pmcc002 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN apmi810_cl USING g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002
   IF STATUS THEN
      CLOSE apmi810_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmi810_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE apmi810_master_referesh USING g_pmcc_m.pmcc001,g_pmcc_m.pmcc002 INTO g_pmcc_m.pmcc001,g_pmcc_m.pmcc002, 
       g_pmcc_m.pmcc003,g_pmcc_m.pmcc004,g_pmcc_m.pmccstus,g_pmcc_m.pmccownid,g_pmcc_m.pmccowndp,g_pmcc_m.pmcccrtid, 
       g_pmcc_m.pmcccrtdp,g_pmcc_m.pmcccrtdt,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmoddt,g_pmcc_m.pmcc005, 
       g_pmcc_m.pmcc006,g_pmcc_m.pmcc002_desc,g_pmcc_m.pmccownid_desc,g_pmcc_m.pmccowndp_desc,g_pmcc_m.pmcccrtid_desc, 
       g_pmcc_m.pmcccrtdp_desc,g_pmcc_m.pmccmodid_desc
   
 
   #檢查是否允許此動作
   IF NOT apmi810_action_chk() THEN
      CLOSE apmi810_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,g_pmcc_m.pmcc002_desc,g_pmcc_m.pmcc003,g_pmcc_m.pmcc004, 
       g_pmcc_m.ooff013,g_pmcc_m.pmccstus,g_pmcc_m.pmccownid,g_pmcc_m.pmccownid_desc,g_pmcc_m.pmccowndp, 
       g_pmcc_m.pmccowndp_desc,g_pmcc_m.pmcccrtid,g_pmcc_m.pmcccrtid_desc,g_pmcc_m.pmcccrtdp,g_pmcc_m.pmcccrtdp_desc, 
       g_pmcc_m.pmcccrtdt,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmodid_desc,g_pmcc_m.pmccmoddt,g_pmcc_m.pmcc005, 
       g_pmcc_m.pmcc006
 
   CASE g_pmcc_m.pmccstus
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
         CASE g_pmcc_m.pmccstus
            
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
      g_pmcc_m.pmccstus = lc_state OR cl_null(lc_state) THEN
      CLOSE apmi810_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
 
   #end add-point
   
   LET g_pmcc_m.pmccmodid = g_user
   LET g_pmcc_m.pmccmoddt = cl_get_current()
   LET g_pmcc_m.pmccstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE pmcc_t 
      SET (pmccstus,pmccmodid,pmccmoddt) 
        = (g_pmcc_m.pmccstus,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmoddt)     
    WHERE pmccent = g_enterprise AND pmcc001 = g_pmcc_m.pmcc001
      AND pmcc002 = g_pmcc_m.pmcc002
    
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
      EXECUTE apmi810_master_referesh USING g_pmcc_m.pmcc001,g_pmcc_m.pmcc002 INTO g_pmcc_m.pmcc001, 
          g_pmcc_m.pmcc002,g_pmcc_m.pmcc003,g_pmcc_m.pmcc004,g_pmcc_m.pmccstus,g_pmcc_m.pmccownid,g_pmcc_m.pmccowndp, 
          g_pmcc_m.pmcccrtid,g_pmcc_m.pmcccrtdp,g_pmcc_m.pmcccrtdt,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmoddt, 
          g_pmcc_m.pmcc005,g_pmcc_m.pmcc006,g_pmcc_m.pmcc002_desc,g_pmcc_m.pmccownid_desc,g_pmcc_m.pmccowndp_desc, 
          g_pmcc_m.pmcccrtid_desc,g_pmcc_m.pmcccrtdp_desc,g_pmcc_m.pmccmodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,g_pmcc_m.pmcc002_desc,g_pmcc_m.pmcc003,g_pmcc_m.pmcc004, 
          g_pmcc_m.ooff013,g_pmcc_m.pmccstus,g_pmcc_m.pmccownid,g_pmcc_m.pmccownid_desc,g_pmcc_m.pmccowndp, 
          g_pmcc_m.pmccowndp_desc,g_pmcc_m.pmcccrtid,g_pmcc_m.pmcccrtid_desc,g_pmcc_m.pmcccrtdp,g_pmcc_m.pmcccrtdp_desc, 
          g_pmcc_m.pmcccrtdt,g_pmcc_m.pmccmodid,g_pmcc_m.pmccmodid_desc,g_pmcc_m.pmccmoddt,g_pmcc_m.pmcc005, 
          g_pmcc_m.pmcc006
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
 
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
 
   #end add-point  
 
   CLOSE apmi810_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmi810_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmi810.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apmi810_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_pmcd_d.getLength() THEN
         LET g_detail_idx = g_pmcd_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmcd_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmcg_d.getLength() TO FORMONLY.cnt
   END IF
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_pmcd_d.getLength() THEN
         LET g_detail_idx = g_pmcd_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmcd_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmcd_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_pmcd3_d.getLength() THEN
         LET g_detail_idx = g_pmcd3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmcd3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmcd3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_pmcd4_d.getLength() THEN
         LET g_detail_idx = g_pmcd4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmcd4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmcd4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   #150915-00006#1 20150915 add by beckxie---S
   CASE g_touch
     WHEN 1
        CALL gfrm_curr.ensureFieldVisible("pmcd_t.pmcd003")
     WHEN 2
        CALL gfrm_curr.ensureFieldVisible("pmce_t.pmce003")
     WHEN 3
        CALL gfrm_curr.ensureFieldVisible("pmcc_t.pmcc005")
     WHEN 4
        CALL gfrm_curr.ensureFieldVisible("pmcf_t.pmcf003")
   END CASE
   #150915-00006#1 20150915 add by beckxie---E
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmi810.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmi810_b_fill2(pi_idx)
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
   
   CALL apmi810_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="apmi810.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apmi810_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apmi810.status_show" >}
PRIVATE FUNCTION apmi810_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmi810.mask_functions" >}
&include "erp/apm/apmi810_mask.4gl"
 
{</section>}
 
{<section id="apmi810.signature" >}
   
 
{</section>}
 
{<section id="apmi810.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmi810_set_pk_array()
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
   LET g_pk_array[1].values = g_pmcc_m.pmcc001
   LET g_pk_array[1].column = 'pmcc001'
   LET g_pk_array[2].values = g_pmcc_m.pmcc002
   LET g_pk_array[2].column = 'pmcc002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmi810.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="apmi810.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmi810_msgcentre_notify(lc_state)
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
   CALL apmi810_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmcc_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmi810.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apmi810_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmi810.other_function" readonly="Y" >}
#+fill
PRIVATE FUNCTION apmi810_b_fill_2()
   CALL g_pmcg_d.clear()
   
   LET g_sql = "SELECT  UNIQUE pmcg004,pmcg005,pmcg006,pmcg007 FROM pmcg_t",    
               " WHERE pmcgent=? AND pmcg001=? AND pmcg002=? AND pmcg003=? " 
 
   IF NOT cl_null(g_wc_table4) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc_table4 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY pmcg_t.pmcg004"
   
   PREPARE apmi810_pb4 FROM g_sql
   DECLARE b_fill_cs4 CURSOR FOR apmi810_pb4
 
   LET g_cnt = l_ac2
   LET l_ac2 = 1
   IF (cl_null(l_ac) OR l_ac=0 )THEN
      LET l_ac=1
   END IF
 
   OPEN b_fill_cs4 USING g_enterprise,g_pmcc_m.pmcc001
                         ,g_pmcc_m.pmcc002,g_pmcd_d[l_ac].pmcd003


                                            
   FOREACH b_fill_cs4 INTO g_pmcg_d[l_ac2].pmcg004,g_pmcg_d[l_ac2].pmcg005,g_pmcg_d[l_ac2].pmcg006,g_pmcg_d[l_ac2].pmcg007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
 
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH

   CALL g_pmcg_d.deleteElement(g_pmcg_d.getLength())

   LET l_ac2 = g_cnt
   LET g_cnt = 0  
   
   FREE apmi810_pb4
END FUNCTION

#+update pmcg
PRIVATE FUNCTION apmi810_update_pmcg(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN   
   
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
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN

      #end add-point     
      UPDATE pmcg_t 
         SET (pmcg001,pmcg002,pmcg003,pmcg004,pmcg005,pmcg006,pmcg07) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_key[4],g_pmcg_d[l_ac2].pmcg005,g_pmcg_d[l_ac2].pmcg006,g_pmcg_d[l_ac2].pmcg007) 
         WHERE pmcg001 = ps_keys_bak[1] AND pmcg002 = ps_keys_bak[2] AND pmcg003 = ps_keys_bak[3] 
           AND pmcg004 = ps_keys_bak[4]         
           AND pmcgent = g_enterprise   #160905-00007#11 Add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE
         
      END IF 
      RETURN
   END IF
END FUNCTION
#+chk 品類
PRIVATE FUNCTION apmi810_pmcc002(p_pmcc002)
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5
   DEFINE   p_pmcc002 LIKE pmcc_t.pmcc002
   LET l_cnt=0
   LET l_cnt1=0
   LET g_errno = NULL
   IF p_pmcc002 ='ALL' OR p_pmcc002='all' THEN
      LET g_pmcc_m.pmcc002 = 'ALL'
   ELSE
      SELECT count(*) INTO l_cnt FROM rtax_t WHERE rtax001=p_pmcc002 AND rtaxent=g_enterprise
      IF l_cnt<=0 THEN
         LET g_errno = "art-00002"
      ELSE
         SELECT count(*) INTO l_cnt1 FROM rtax_t WHERE rtax001=p_pmcc002 AND rtaxent=g_enterprise
            AND rtaxstus='Y'  
         IF l_cnt1<=0 THEN
            LET g_errno="art-00048"
         END IF      
      END IF
   END IF
END FUNCTION
#+ display
PRIVATE FUNCTION apmi810_display_pmcc002(p_pmcc002)
   DEFINE l_msg   STRING
   DEFINE p_pmcc002 LIKE pmcc_t.pmcc002   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmcc002
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmcc_m.pmcc002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmcc_m.pmcc002_desc
   IF p_pmcc002 ='ALL' OR p_pmcc002='all' THEN
      CALL cl_getmsg('apm-00058',g_dlang) RETURNING l_msg
      DISPLAY l_msg TO pmcc002_desc
   END IF
END FUNCTION
#+chk pmcd003
PRIVATE FUNCTION apmi810_insert_pmcd003()
   DEFINE l_sql    STRING
   DEFINE l_oocq002    LIKE oocq_t.oocq002
   DEFINE l_oocq004    LIKE oocq_t.oocq004
   DEFINE l_gzcb001    LIKE gzcb_t.gzcb001
   DEFINE l_gzcb002    LIKE gzcb_t.gzcb002
   DEFINE l_oocq_count LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_gzcb_count LIKE type_t.num5
   DEFINE l_oocq_count2 LIKE type_t.num5
   DEFINE l_pmcd004    LIKE pmcd_t.pmcd004
   DEFINE l_pmce005    LIKE pmce_t.pmce005
   
   DEFINE l_success    LIKE type_t.num5
   LET l_success = 1
   SELECT count(*) INTO l_gzcb_count FROM gzcb_t WHERE gzcb001='6001'
   IF cl_null(l_gzcb_count) OR l_gzcb_count=0 THEN
      LET l_gzcb_count = 1
   END IF
   SELECT ROUND(100/l_gzcb_count,0) INTO l_pmcd004 FROM dual
   LET l_sql = "SELECT gzcb001,gzcb002 FROM gzcb_t WHERE gzcb001='6001'   ORDER BY gzcb002 "
   PREPARE l_sql_pre FROM l_sql
   DECLARE l_sql_cs CURSOR FOR l_sql_pre
   LET l_cnt=1
   FOREACH l_sql_cs INTO l_gzcb001,l_gzcb002
      IF l_cnt =l_gzcb_count THEN
         LET l_pmcd004=100-l_pmcd004*(l_gzcb_count-1)
      END IF
      INSERT INTO pmcd_t(pmcdent,pmcd001,pmcd002,pmcd003,pmcd004) 
      VALUES (g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,l_gzcb002,l_pmcd004)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "gzcb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN 0
      ELSE
         
      END IF 
      LET l_gzcb001 = NULL
      LET l_gzcb002 = NULL
      LET l_cnt = l_cnt+1      
   END FOREACH
   
   SELECT count(*) INTO l_oocq_count FROM oocq_t WHERE oocq001 = '2052' AND oocqent = g_enterprise
   IF cl_null(l_oocq_count) OR l_oocq_count=0 THEN
      LET l_oocq_count = 1
   END IF
   SELECT round(100/l_oocq_count) INTO l_pmce005 FROM dual
   LET l_cnt=1
   LET l_sql = "SELECT oocq002,oocq004 FROM oocq_t WHERE oocq001 = '2052' AND oocqent = ",g_enterprise clipped,"  ORDER BY oocq002 "
   PREPARE l_sql_pre2 FROM l_sql
   DECLARE l_sql_cs2 CURSOR FOR l_sql_pre2
   FOREACH l_sql_cs2 INTO l_oocq002,l_oocq004
      IF l_cnt =l_gzcb_count THEN
         LET l_pmce005=100-l_pmce005*(l_oocq_count-1)
      END IF
      INSERT INTO pmce_t(pmceent,pmce001,pmce002,pmce003,pmce004,pmce005) 
      VALUES (g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,l_oocq002,l_oocq004,l_pmce005)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmce_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN 0
      ELSE
         
      END IF 
      LET l_oocq002 = NULL
      LET l_oocq004 = NULL
      LET l_cnt = l_cnt+1      
   END FOREACH
   
   LET l_sql = "SELECT oocq002,oocq004 FROM oocq_t WHERE oocq001 = '2053' AND oocqent = ",g_enterprise clipped,"  ORDER BY oocq002 "
   PREPARE l_sql_pre3 FROM l_sql
   DECLARE l_sql_cs3 CURSOR FOR l_sql_pre3
   FOREACH l_sql_cs3 INTO l_oocq002,l_oocq004
      INSERT INTO pmcf_t(pmcfent,pmcf001,pmcf002,pmcf003) 
      VALUES (g_enterprise,g_pmcc_m.pmcc001,g_pmcc_m.pmcc002,l_oocq002)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmcf_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN 0
      ELSE
         
      END IF 
      LET l_oocq002 = NULL
      LET l_oocq004 = NULL       
   END FOREACH
   RETURN l_success
END FUNCTION
#+create pmcg004
PRIVATE FUNCTION apmi810_pmcg004()
   IF (cl_null(g_pmcg_d[l_ac2].pmcg004) OR g_pmcg_d[l_ac2].pmcg004=0) THEN
      SELECT MAX(pmcg004)+1 INTO g_pmcg_d[l_ac2].pmcg004 FROM pmcg_t
       WHERE pmcg001 = g_pmcc_m.pmcc001 AND pmcgent = g_enterprise
         AND pmcg002 = g_pmcc_m.pmcc002 AND pmcg003 = g_pmcd_d[l_ac].pmcd003
   END IF
   IF (cl_null(g_pmcg_d[l_ac2].pmcg004) OR g_pmcg_d[l_ac2].pmcg004=0) THEN
      LET g_pmcg_d[l_ac2].pmcg004 = 1
   END IF
END FUNCTION
#+chk pmcg005
PRIVATE FUNCTION apmi810_pmcg005()
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE l_cnt1   LIKE type_t.num5
   LET l_cnt = 0
   LET l_cnt1 = 0 
   let g_errno = null   
   IF NOT cl_null(g_pmcg_d[l_ac2].pmcg005) AND NOT cl_null(g_pmcg_d[l_ac2].pmcg006) THEN
      if g_pmcg_d[l_ac2].pmcg005 > g_pmcg_d[l_ac2].pmcg006 then
         let g_errno = "apm-00060"
         RETURN FALSE,g_errno
      end if
         
      IF g_pmcg_d_t.pmcg005 IS NULL THEN
         
         LET l_cnt = 0
         IF g_pmcg_d_t.pmcg006 IS NOT NULL THEN
         SELECT count(*) INTO l_cnt FROM pmcg_t
          WHERE pmcg001=g_pmcc_m.pmcc001 AND pmcg002 = g_pmcc_m.pmcc002 AND pmcgent = g_enterprise
            AND ((pmcg005 BETWEEN g_pmcg_d[l_ac2].pmcg005 AND g_pmcg_d[l_ac2].pmcg006)  OR
            (pmcg006  BETWEEN g_pmcg_d[l_ac2].pmcg005 AND g_pmcg_d[l_ac2].pmcg006))
            AND pmcg003 = g_pmcd_d[l_ac].pmcd003 AND pmcg006!=g_pmcg_d_t.pmcg006
         ELSE
            SELECT count(*) INTO l_cnt FROM pmcg_t
             WHERE pmcg001=g_pmcc_m.pmcc001 AND pmcg002 = g_pmcc_m.pmcc002 AND pmcgent = g_enterprise
               AND ((pmcg005 BETWEEN g_pmcg_d[l_ac2].pmcg005 AND g_pmcg_d[l_ac2].pmcg006)  OR
               (pmcg006  BETWEEN g_pmcg_d[l_ac2].pmcg005 AND g_pmcg_d[l_ac2].pmcg006))
               AND pmcg003 = g_pmcd_d[l_ac].pmcd003
         END IF         
         IF l_cnt>0 THEN
            let g_errno = "apm-00061"
            RETURN FALSE,g_errno
         END IF
         IF g_pmcg_d_t.pmcg006 IS NOT NULL THEN
         SELECT count(*) INTO l_cnt FROM pmcg_t
          WHERE pmcg001=g_pmcc_m.pmcc001 AND pmcg002 = g_pmcc_m.pmcc002 AND pmcgent = g_enterprise
            AND ((g_pmcg_d[l_ac2].pmcg005 BETWEEN pmcg005 AND pmcg006)  OR
            (g_pmcg_d[l_ac2].pmcg006  BETWEEN pmcg005 AND pmcg006))
            AND pmcg003 = g_pmcd_d[l_ac].pmcd003 AND pmcg006!=g_pmcg_d_t.pmcg006
         ELSE
            SELECT count(*) INTO l_cnt FROM pmcg_t
             WHERE pmcg001=g_pmcc_m.pmcc001 AND pmcg002 = g_pmcc_m.pmcc002 AND pmcgent = g_enterprise
               AND ((g_pmcg_d[l_ac2].pmcg005 BETWEEN pmcg005 AND pmcg006)  OR
            (g_pmcg_d[l_ac2].pmcg006  BETWEEN pmcg005 AND pmcg006))
               AND pmcg003 = g_pmcd_d[l_ac].pmcd003
         END IF         
         IF l_cnt>0 THEN
            let g_errno = "apm-00061"
            RETURN FALSE,g_errno
         END IF
      END IF
      
      IF (not cl_null(g_pmcg_d[l_ac2].pmcg005) AND g_pmcg_d_t.pmcg005>g_pmcg_d[l_ac2].pmcg005) THEN
         
         LET l_cnt = 0         
         SELECT count(*) INTO l_cnt FROM pmcg_t
          WHERE pmcg001=g_pmcc_m.pmcc001 AND pmcg002 = g_pmcc_m.pmcc002 AND pmcgent = g_enterprise
            AND ((pmcg005 BETWEEN g_pmcg_d[l_ac2].pmcg005 AND g_pmcg_d[l_ac2].pmcg006)  OR
            (pmcg006  BETWEEN g_pmcg_d[l_ac2].pmcg005 AND g_pmcg_d[l_ac2].pmcg006))
            AND (pmcg005 != g_pmcg_d_t.pmcg005 OR pmcg006 != g_pmcg_d_t.pmcg006) 
            AND pmcg003 = g_pmcd_d[l_ac].pmcd003
         IF l_cnt>0 THEN
            LET g_errno = "apm-00061"
            RETURN FALSE,g_errno
         END IF         
      END IF
      
      IF g_pmcg_d_t.pmcg006 IS NULL  THEN
         
         LET l_cnt = 0
         IF g_pmcg_d_t.pmcg005 IS NOT NULL THEN
         SELECT count(*) INTO l_cnt FROM pmcg_t
          WHERE pmcg001=g_pmcc_m.pmcc001 AND pmcg002 = g_pmcc_m.pmcc002 AND pmcgent = g_enterprise
            AND ((pmcg005 BETWEEN g_pmcg_d[l_ac2].pmcg005 AND g_pmcg_d[l_ac2].pmcg006)  OR
            (pmcg006  BETWEEN g_pmcg_d[l_ac2].pmcg005 AND g_pmcg_d[l_ac2].pmcg006))
            AND pmcg003 = g_pmcd_d[l_ac].pmcd003 AND pmcg005 ! = g_pmcg_d_t.pmcg005
         ELSE
            SELECT count(*) INTO l_cnt FROM pmcg_t
             WHERE pmcg001=g_pmcc_m.pmcc001 AND pmcg002 = g_pmcc_m.pmcc002 AND pmcgent = g_enterprise
               AND ((pmcg005 BETWEEN g_pmcg_d[l_ac2].pmcg005 AND g_pmcg_d[l_ac2].pmcg006)  OR
               (pmcg006  BETWEEN g_pmcg_d[l_ac2].pmcg005 AND g_pmcg_d[l_ac2].pmcg006))
               AND pmcg003 = g_pmcd_d[l_ac].pmcd003
         END IF          
         IF l_cnt>0 THEN
            let g_errno = "apm-00061"
            RETURN FALSE,g_errno
         END IF
         IF g_pmcg_d_t.pmcg005 IS NOT NULL THEN
         SELECT count(*) INTO l_cnt FROM pmcg_t
          WHERE pmcg001=g_pmcc_m.pmcc001 AND pmcg002 = g_pmcc_m.pmcc002 AND pmcgent = g_enterprise
            AND ((g_pmcg_d[l_ac2].pmcg005 BETWEEN pmcg005 AND pmcg006)  OR
            (g_pmcg_d[l_ac2].pmcg006  BETWEEN pmcg005 AND pmcg006))
            AND pmcg003 = g_pmcd_d[l_ac].pmcd003 AND pmcg005 ! = g_pmcg_d_t.pmcg005
         ELSE
            SELECT count(*) INTO l_cnt FROM pmcg_t
             WHERE pmcg001=g_pmcc_m.pmcc001 AND pmcg002 = g_pmcc_m.pmcc002 AND pmcgent = g_enterprise
               AND ((g_pmcg_d[l_ac2].pmcg005 BETWEEN pmcg005 AND pmcg006)  OR
            (g_pmcg_d[l_ac2].pmcg006  BETWEEN pmcg005 AND pmcg006))
               AND pmcg003 = g_pmcd_d[l_ac].pmcd003
         END IF          
         IF l_cnt>0 THEN
            let g_errno = "apm-00061"
            RETURN FALSE,g_errno
         END IF
      END IF
      IF (not cl_null(g_pmcg_d[l_ac2].pmcg006) AND g_pmcg_d_t.pmcg006<g_pmcg_d[l_ac2].pmcg006) THEN
         LET l_cnt = 0
         SELECT count(*) INTO l_cnt FROM pmcg_t
          WHERE pmcg001=g_pmcc_m.pmcc001 AND pmcg002 = g_pmcc_m.pmcc002 AND pmcgent = g_enterprise
            AND ((pmcg005 BETWEEN g_pmcg_d[l_ac2].pmcg005 AND g_pmcg_d[l_ac2].pmcg006)  OR
            (pmcg006  BETWEEN g_pmcg_d[l_ac2].pmcg005 AND g_pmcg_d[l_ac2].pmcg006))
            AND (pmcg005 != g_pmcg_d_t.pmcg005 OR pmcg006 != g_pmcg_d_t.pmcg006) 
            AND pmcg003 = g_pmcd_d[l_ac].pmcd003
         IF l_cnt>0 THEN
            let g_errno = "apm-00061"
            RETURN FALSE,g_errno
         END IF         
      END IF
   END IF
   RETURN TRUE,g_errno
END FUNCTION
#+ chk pmce004
PRIVATE FUNCTION apmi810_pmce004()
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5
   LET l_cnt=0
   LET l_cnt1=0
   LET g_errno = NULL
   SELECT count(*) INTO l_cnt FROM ooeg_t WHERE ooeg001=g_pmcd3_d[l_ac].pmce004 AND ooegent=g_enterprise
      and ooea016='Y'
   IF l_cnt<=0 THEN
      LET g_errno = "aim-00058"
   ELSE
      SELECT count(*) INTO l_cnt1 FROM ooeg_t WHERE ooeg001=g_pmcd3_d[l_ac].pmce004 AND ooegent=g_enterprise
         AND ooegstus = 'Y'  
      IF l_cnt1<=0 THEN
         #LET g_errno="aim-00059" #160318-00005#34
          LET g_errno="sub-01302" #160318-00005#34 
      END IF      
   END IF 
END FUNCTION
#+ chk pmcf005
PRIVATE FUNCTION apmi810_pmcf005()
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE l_cnt1   LIKE type_t.num5
   LET l_cnt = 0
   LET l_cnt1 = 0 
   let g_errno = null   
   IF NOT cl_null(g_pmcd4_d[l_ac].pmcf004) AND NOT cl_null(g_pmcd4_d[l_ac].pmcf005) THEN
      if g_pmcd4_d[l_ac].pmcf004 > g_pmcd4_d[l_ac].pmcf005 then
         let g_errno = "apm-00063"
         RETURN FALSE,g_errno
      end if
         
      IF g_pmcd4_d_t.pmcf004 IS NULL THEN
         
         LET l_cnt = 0
         IF g_pmcd4_d_t.pmcf005 IS NOT NULL THEN
         SELECT count(*) INTO l_cnt FROM pmcf_t
          WHERE pmcf001=g_pmcc_m.pmcc001 AND pmcf002 = g_pmcc_m.pmcc002 AND pmcfent = g_enterprise
            AND ((pmcf004 BETWEEN g_pmcd4_d[l_ac].pmcf004 AND g_pmcd4_d[l_ac].pmcf005)  OR
            (pmcf005  BETWEEN g_pmcd4_d[l_ac].pmcf004 AND g_pmcd4_d[l_ac].pmcf005))
             AND pmcf005!=g_pmcd4_d_t.pmcf005
         ELSE
            SELECT count(*) INTO l_cnt FROM pmcf_t
             WHERE pmcf001=g_pmcc_m.pmcc001 AND pmcf002 = g_pmcc_m.pmcc002 AND pmcfent = g_enterprise
               AND ((pmcf004 BETWEEN g_pmcd4_d[l_ac].pmcf004 AND g_pmcd4_d[l_ac].pmcf005)  OR
               (pmcf005  BETWEEN g_pmcd4_d[l_ac].pmcf004 AND g_pmcd4_d[l_ac].pmcf005))
         END IF         
         IF l_cnt>0 THEN
            let g_errno = "apm-00064"
            RETURN FALSE,g_errno
         END IF
         IF g_pmcd4_d_t.pmcf005 IS NOT NULL THEN
         SELECT count(*) INTO l_cnt FROM pmcf_t
          WHERE pmcf001=g_pmcc_m.pmcc001 AND pmcf002 = g_pmcc_m.pmcc002 AND pmcfent = g_enterprise
            AND ((g_pmcd4_d[l_ac].pmcf004 BETWEEN pmcf004 AND pmcf005)  OR
            (g_pmcd4_d[l_ac].pmcf005  BETWEEN pmcf004 AND pmcf005))
             AND pmcf005!=g_pmcd4_d_t.pmcf005
         ELSE
            SELECT count(*) INTO l_cnt FROM pmcf_t
             WHERE pmcf001=g_pmcc_m.pmcc001 AND pmcf002 = g_pmcc_m.pmcc002 AND pmcfent = g_enterprise
               AND ((g_pmcd4_d[l_ac].pmcf004 BETWEEN pmcf004 AND pmcf005)  OR
            (g_pmcd4_d[l_ac].pmcf005  BETWEEN pmcf004 AND pmcf005))
         END IF         
         IF l_cnt>0 THEN
            let g_errno = "apm-00064"
            RETURN FALSE,g_errno
         END IF
      END IF
      
      IF (not cl_null(g_pmcd4_d[l_ac].pmcf004) AND g_pmcd4_d_t.pmcf004>g_pmcd4_d[l_ac].pmcf004) THEN
         
         LET l_cnt = 0         
         SELECT count(*) INTO l_cnt FROM pmcf_t
          WHERE pmcf001=g_pmcc_m.pmcc001 AND pmcf002 = g_pmcc_m.pmcc002 AND pmcfent = g_enterprise
            AND ((pmcf004 BETWEEN g_pmcd4_d[l_ac].pmcf004 AND g_pmcd4_d[l_ac].pmcf005)  OR
            (pmcf005  BETWEEN g_pmcd4_d[l_ac].pmcf004 AND g_pmcd4_d[l_ac].pmcf005))
            AND (pmcf004 != g_pmcd4_d_t.pmcf004 OR pmcf005 != g_pmcd4_d_t.pmcf005) 
         IF l_cnt>0 THEN
            LET g_errno = "apm-00064"
            RETURN FALSE,g_errno
         END IF         
      END IF
      
      IF g_pmcd4_d_t.pmcf005 IS NULL  THEN
         
         LET l_cnt = 0
         IF g_pmcd4_d_t.pmcf004 IS NOT NULL THEN
         SELECT count(*) INTO l_cnt FROM pmcf_t
          WHERE pmcf001=g_pmcc_m.pmcc001 AND pmcf002 = g_pmcc_m.pmcc002 AND pmcfent = g_enterprise
            AND ((pmcf004 BETWEEN g_pmcd4_d[l_ac].pmcf004 AND g_pmcd4_d[l_ac].pmcf005)  OR
            (pmcf005  BETWEEN g_pmcd4_d[l_ac].pmcf004 AND g_pmcd4_d[l_ac].pmcf005))
            AND pmcf004 ! = g_pmcd4_d_t.pmcf004
         ELSE
            SELECT count(*) INTO l_cnt FROM pmcf_t
             WHERE pmcf001=g_pmcc_m.pmcc001 AND pmcf002 = g_pmcc_m.pmcc002 AND pmcfent = g_enterprise
               AND ((pmcf004 BETWEEN g_pmcd4_d[l_ac].pmcf004 AND g_pmcd4_d[l_ac].pmcf005)  OR
               (pmcf005  BETWEEN g_pmcd4_d[l_ac].pmcf004 AND g_pmcd4_d[l_ac].pmcf005))
             
         END IF          
         IF l_cnt>0 THEN
            let g_errno = "apm-00064"
            RETURN FALSE,g_errno
         END IF
         IF g_pmcd4_d_t.pmcf004 IS NOT NULL THEN
         SELECT count(*) INTO l_cnt FROM pmcf_t
          WHERE pmcf001=g_pmcc_m.pmcc001 AND pmcf002 = g_pmcc_m.pmcc002 AND pmcfent = g_enterprise
            AND ((g_pmcd4_d[l_ac].pmcf004 BETWEEN pmcf004 AND pmcf005)  OR
            (g_pmcd4_d[l_ac].pmcf005  BETWEEN pmcf004 AND pmcf005))
             AND pmcf004 ! = g_pmcd4_d_t.pmcf004
         ELSE
            SELECT count(*) INTO l_cnt FROM pmcf_t
             WHERE pmcf001=g_pmcc_m.pmcc001 AND pmcf002 = g_pmcc_m.pmcc002 AND pmcfent = g_enterprise
               AND ((g_pmcd4_d[l_ac].pmcf004 BETWEEN pmcf004 AND pmcf005)  OR
            (g_pmcd4_d[l_ac].pmcf005  BETWEEN pmcf004 AND pmcf005))
         END IF          
         IF l_cnt>0 THEN
            let g_errno = "apm-00064"
            RETURN FALSE,g_errno
         END IF
      END IF
      IF (not cl_null(g_pmcd4_d[l_ac].pmcf005) AND g_pmcd4_d_t.pmcf005<g_pmcd4_d[l_ac].pmcf005) THEN
         LET l_cnt = 0
         SELECT count(*) INTO l_cnt FROM pmcf_t
          WHERE pmcf001=g_pmcc_m.pmcc001 AND pmcf002 = g_pmcc_m.pmcc002 AND pmcfent = g_enterprise
            AND ((pmcf004 BETWEEN g_pmcd4_d[l_ac].pmcf004 AND g_pmcd4_d[l_ac].pmcf005)  OR
            (pmcf005  BETWEEN g_pmcd4_d[l_ac].pmcf004 AND g_pmcd4_d[l_ac].pmcf005))
            AND (pmcf004 != g_pmcd4_d_t.pmcf004 OR pmcf005 != g_pmcd4_d_t.pmcf005) 
            
         IF l_cnt>0 THEN
            let g_errno = "apm-00064"
            RETURN FALSE,g_errno
         END IF         
      END IF
   END IF
   RETURN TRUE,g_errno

END FUNCTION
#+chk pmcf006
PRIVATE FUNCTION apmi810_pmcf006()
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5
   LET l_cnt=0
   LET l_cnt1=0
   LET g_errno = NULL
   SELECT count(*) INTO l_cnt FROM oocq_t WHERE oocq002=g_pmcd4_d[l_ac].pmcf006 AND oocqent=g_enterprise
      and oocq001 = '2054'
   IF l_cnt<=0 THEN
      LET g_errno = "amm-00013"
   ELSE
      SELECT count(*) INTO l_cnt1 FROM oocq_t WHERE oocq002=g_pmcd4_d[l_ac].pmcf006 AND oocqent=g_enterprise
      and oocq001 = '2054' AND oocqstus = 'Y'  
      IF l_cnt1<=0 THEN
         LET g_errno="amm-00014"
      END IF      
   END IF 
END FUNCTION
#+ display
PRIVATE FUNCTION apmi810_display_pmce004()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmcd3_d[l_ac].pmce004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmcd3_d[l_ac].pmce004_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_pmcd3_d[l_ac].pmce004_desc TO s_detail3[l_ac].pmce004_desc
END FUNCTION
#chk pmcf003
PRIVATE FUNCTION apmi810_chk_pmcf003()
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5 
   LET g_errno = null
   SELECT COUNT(*) INTO l_cnt  FROM oocq_t WHERE oocq001='2053' AND oocq002 =g_pmcd4_d[l_ac].pmcf003
      AND oocqent = g_enterprise
   IF l_cnt <= 0 THEN
      LET g_errno = "amm-00013"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  FROM oocq_t WHERE oocq001='2053' AND oocq002 =g_pmcd4_d[l_ac].pmcf003
         AND oocqent = g_enterprise 
         AND oocqstus='Y'
      IF l_cnt1 <= 0 THEN
         LET g_errno = "amm-00014"
      END IF         
   END IF
END FUNCTION
#display pmcf003
PRIVATE FUNCTION apmi810_display_pmcf003()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmcd4_d[l_ac].pmcf003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2053' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmcd4_d[l_ac].pmcf003_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_pmcd4_d[l_ac].pmcf003_desc to s_detail4[l_ac].pmcf003_desc
            
   
END FUNCTION

PRIVATE FUNCTION apmi810_chk_pmcc002()
   DEFINE   l_cnt   LIKE type_t.num5
   LET l_cnt=0
   LET g_errno = NULL
   
   IF cl_null(g_errno) THEN
      IF NOT cl_null(g_pmcc_m.pmcc001) AND NOT cl_null(g_pmcc_m.pmcc002) THEN
         IF g_pmcc_m.pmcc002 = "ALL" THEN
            SELECT COUNT(*) INTO l_cnt
              FROM pmcc_t
             WHERE pmccent = g_enterprise
               AND pmcc001 = g_pmcc_m.pmcc001
               AND pmcc002 <> "ALL"
            IF l_cnt > 0 THEN
               LET g_errno="apm-00461"
            END IF
         ELSE 
            SELECT COUNT(*) INTO l_cnt
              FROM pmcc_t
             WHERE pmccent = g_enterprise
               AND pmcc001 = g_pmcc_m.pmcc001
               AND pmcc002 = "ALL"
            IF l_cnt > 0 THEN
               LET g_errno="apm-00461"
            END IF   
         END IF
      END IF
   END IF
END FUNCTION
#display pmcf006
PRIVATE FUNCTION apmi810_display_pmcf006()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmcd4_d[l_ac].pmcf006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2054' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmcd4_d[l_ac].pmcf006_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_pmcd4_d[l_ac].pmcf006_desc to s_detail4[l_ac].pmcf006_desc
END FUNCTION

 
{</section>}
 
