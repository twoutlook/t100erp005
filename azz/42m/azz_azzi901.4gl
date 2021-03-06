#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi901.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0029(2016-03-03 10:30:47), PR版次:0029(2017-03-03 11:45:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000445
#+ Filename...: azzi901
#+ Description: 子程式及元件基本資料設定作業
#+ Creator....: 00845(2013-08-14 15:46:13)
#+ Modifier...: 01856 -SD/PR- 01856
 
{</section>}
 
{<section id="azzi901.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160520-00015 #1 2016/05/23 by jrg542 修正行業別元件歸屬行業別判別有誤，並調整行業只有主程式(azzi900)才可以引用的問題
#160531-00004 #1 2016/05/21 by jrg542 調整行業子程式及行業元件命名方式只要規格編號字段出現『_ph_』或『_ph』就視為合法的資料
#160615-00001 #1 2016/06/15 by jrg542 設計器說topstd不可以新增子畫面
#160711-00014 #1 2016/07/11 by jrg542 刪除註冊資料先檢查子畫面設計資料
#160721-00020 #1 2016/07/23 by jrg542 azzi900 azzi901 針對要想刪不想要的子畫面資料，會出現已存在設計資料不可刪除
#161117-00018 #1 2016/11/17 by jrg542 客製不管控 INSERT INTO gzdh_t
#161123-00050 #2 2016/11/23 by jrg542 複製時，子畫面不用複製
#160921-00012 #2 2017/01/16 by jrg542 azzi901增加報表元件可選的程式產生類型
#170303-00017 #1 2017/03/03 by jrg542 補修正X類報表類 配合報表組 G類 X類 程式產生類型(gzde005) 舊有資料顯示
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
PRIVATE type type_g_gzde_m        RECORD
       gzde001 LIKE gzde_t.gzde001, 
   gzdel003 LIKE gzdel_t.gzdel003, 
   gzdel004 LIKE gzdel_t.gzdel004, 
   gzde002 LIKE gzde_t.gzde002, 
   gzde008 LIKE gzde_t.gzde008, 
   gzde009 LIKE gzde_t.gzde009, 
   gzde005 LIKE gzde_t.gzde005, 
   gzde003 LIKE gzde_t.gzde003, 
   gzde006 LIKE gzde_t.gzde006, 
   gzdestus LIKE gzde_t.gzdestus, 
   gzde007 LIKE gzde_t.gzde007, 
   gzdeownid LIKE gzde_t.gzdeownid, 
   gzdeownid_desc LIKE type_t.chr80, 
   gzdeowndp LIKE gzde_t.gzdeowndp, 
   gzdeowndp_desc LIKE type_t.chr80, 
   gzdecrtid LIKE gzde_t.gzdecrtid, 
   gzdecrtid_desc LIKE type_t.chr80, 
   gzdecrtdp LIKE gzde_t.gzdecrtdp, 
   gzdecrtdp_desc LIKE type_t.chr80, 
   gzdecrtdt LIKE gzde_t.gzdecrtdt, 
   gzdemodid LIKE gzde_t.gzdemodid, 
   gzdemodid_desc LIKE type_t.chr80, 
   gzdemoddt LIKE gzde_t.gzdemoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gzdf_d        RECORD
       gzdf002 LIKE gzdf_t.gzdf002, 
   gzdfl003 LIKE gzdfl_t.gzdfl003, 
   gzdf003 LIKE gzdf_t.gzdf003
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_gzde001 LIKE gzde_t.gzde001,
   b_gzde001_desc LIKE type_t.chr80,
      b_gzde002 LIKE gzde_t.gzde002,
      b_gzde003 LIKE gzde_t.gzde003
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE lc_chk_sec        LIKE type_t.chr1
DEFINE g_gzdh            RECORD
       gzdhownid         LIKE gzdh_t.gzdhownid,
       gzdhowndp         LIKE gzdh_t.gzdhowndp,
       gzdhcrtid         LIKE gzdh_t.gzdhcrtid,
       gzdhcrtdp         LIKE gzdh_t.gzdhcrtdp,
       gzdhcrtdt         LIKE gzdh_t.gzdhcrtdt,
       gzdhmodid         LIKE gzdh_t.gzdhmodid,
       gzdhmoddt         LIKE gzdh_t.gzdhmoddt,
       gzdhstus          LIKE gzdh_t.gzdhstus,
       gzdh001           LIKE gzdh_t.gzdh001,
       gzdh002           LIKE gzdh_t.gzdh002
                         END RECORD
#end add-point
       
#模組變數(Module Variables)
DEFINE g_gzde_m          type_g_gzde_m
DEFINE g_gzde_m_t        type_g_gzde_m
DEFINE g_gzde_m_o        type_g_gzde_m
DEFINE g_gzde_m_mask_o   type_g_gzde_m #轉換遮罩前資料
DEFINE g_gzde_m_mask_n   type_g_gzde_m #轉換遮罩後資料
 
   DEFINE g_gzde001_t LIKE gzde_t.gzde001
 
 
DEFINE g_gzdf_d          DYNAMIC ARRAY OF type_g_gzdf_d
DEFINE g_gzdf_d_t        type_g_gzdf_d
DEFINE g_gzdf_d_o        type_g_gzdf_d
DEFINE g_gzdf_d_mask_o   DYNAMIC ARRAY OF type_g_gzdf_d #轉換遮罩前資料
DEFINE g_gzdf_d_mask_n   DYNAMIC ARRAY OF type_g_gzdf_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      gzdel001 LIKE gzdel_t.gzdel001,
      gzdel003 LIKE gzdel_t.gzdel003,
      gzdel004 LIKE gzdel_t.gzdel004
      END RECORD
DEFINE g_detail_multi_table_t    RECORD
      gzdfl001 LIKE gzdfl_t.gzdfl001,
      gzdfl002 LIKE gzdfl_t.gzdfl002,
      gzdfl003 LIKE gzdfl_t.gzdfl003
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
 
{<section id="azzi901.main" >}
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
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT gzde001,'','',gzde002,gzde008,gzde009,gzde005,gzde003,gzde006,gzdestus, 
       gzde007,gzdeownid,'',gzdeowndp,'',gzdecrtid,'',gzdecrtdp,'',gzdecrtdt,gzdemodid,'',gzdemoddt", 
        
                      " FROM gzde_t",
                      " WHERE gzde001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi901_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.gzde001,t0.gzde002,t0.gzde008,t0.gzde009,t0.gzde005,t0.gzde003,t0.gzde006, 
       t0.gzdestus,t0.gzde007,t0.gzdeownid,t0.gzdeowndp,t0.gzdecrtid,t0.gzdecrtdp,t0.gzdecrtdt,t0.gzdemodid, 
       t0.gzdemoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011",
               " FROM gzde_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.gzdeownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.gzdeowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.gzdecrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.gzdecrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.gzdemodid  ",
 
               " WHERE  t0.gzde001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE azzi901_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi901 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzi901_init()   
 
      #進入選單 Menu (="N")
      CALL azzi901_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzi901
      
   END IF 
   
   CLOSE azzi901_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="azzi901.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzi901_init()
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
      CALL cl_set_combo_scc_part('gzdestus','17','N,Y')
 
      CALL cl_set_combo_scc('gzde005','99') 
   CALL cl_set_combo_scc('gzde003','91') 
   CALL cl_set_combo_scc('gzde006','79') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_gzde003','91')
   IF FGL_GETENV("DGENV") = "s" THEN
      CALL cl_set_combo_module_reg("gzde002",1)
      CALL cl_set_combo_module_reg("b_gzde002",1)
   ELSE
      CALL cl_set_combo_module("gzde002",1)
      CALL cl_set_combo_module("b_gzde002",1)
   END IF  
   CALL cl_set_combo_industry("gzde009")   
   LET lc_chk_sec = "N"
   CALL azzi901_set_combo_gzde006('gzde006')    #160921-00012 #2 
   #end add-point
   
   #初始化搜尋條件
   CALL azzi901_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="azzi901.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION azzi901_ui_dialog()
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
            CALL azzi901_insert()
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
         INITIALIZE g_gzde_m.* TO NULL
         CALL g_gzdf_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL azzi901_init()
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
               
               CALL azzi901_fetch('') # reload data
               LET l_ac = 1
               CALL azzi901_ui_detailshow() #Setting the current row 
         
               CALL azzi901_idx_chk()
               #NEXT FIELD gzdf002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_gzdf_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL azzi901_idx_chk()
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
               CALL azzi901_idx_chk()
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
            CALL azzi901_browser_fill("")
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
               CALL azzi901_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL azzi901_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL azzi901_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL azzi901_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL azzi901_set_act_visible()   
            CALL azzi901_set_act_no_visible()
            IF NOT (g_gzde_m.gzde001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " ",
                                  " gzde001 = '", g_gzde_m.gzde001, "' "
 
               #填到對應位置
               CALL azzi901_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "gzde_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gzdf_t" 
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
               CALL azzi901_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "gzde_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gzdf_t" 
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
                  CALL azzi901_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL azzi901_fetch("F")
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
               CALL azzi901_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL azzi901_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi901_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL azzi901_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi901_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL azzi901_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi901_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL azzi901_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi901_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL azzi901_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi901_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_gzdf_d)
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
               NEXT FIELD gzdf002
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
               CALL azzi901_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL azzi901_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi901_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi901_insert()
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
               CALL azzi901_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi901_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL azzi901_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi901_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi901_set_pk_array()
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
 
{<section id="azzi901.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION azzi901_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT gzde001 ",
                      " FROM gzde_t ",
                      " ",
                      " LEFT JOIN gzdf_t ON gzde001 = gzdf001 ", "  ",
                      #add-point:browser_fill段sql(gzdf_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " LEFT JOIN gzdel_t ON gzde001 = gzdel001 AND gzdel002 = '",g_dlang,"' ", 
                      " LEFT JOIN gzdfl_t ON gzdf002 = gzdfl001 AND gzdfl002 = '",g_dlang,"' ", 
 
 
                      " WHERE   ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gzde_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gzde001 ",
                      " FROM gzde_t ", 
                      "  ",
                      "  LEFT JOIN gzdel_t ON gzde001 = gzdel001 AND gzdel002 = '",g_dlang,"' ",
                      " WHERE  ",l_wc CLIPPED, cl_sql_add_filter("gzde_t")
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
      INITIALIZE g_gzde_m.* TO NULL
      CALL g_gzdf_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.gzde001,t0.gzde002,t0.gzde003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.gzdestus,t0.gzde001,t0.gzde002,t0.gzde003,t1.gzdel003 ",
                  " FROM gzde_t t0",
                  "  ",
                  "  LEFT JOIN gzdf_t ON gzde001 = gzdf001 ", "  ", 
                  #add-point:browser_fill段sql(gzdf_t1) name="browser_fill.join.gzdf_t1"
                  
                  #end add-point
 
 
                  " LEFT JOIN gzdfl_t ON gzdf002 = gzdfl001 AND gzdfl002 = '",g_dlang,"' ", 
 
 
                                 " LEFT JOIN gzdel_t t1 ON t1.gzdel001=t0.gzde001 AND t1.gzdel002='"||g_lang||"' ",
 
                  " WHERE  ",l_wc," AND ",l_wc2, cl_sql_add_filter("gzde_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.gzdestus,t0.gzde001,t0.gzde002,t0.gzde003,t1.gzdel003 ",
                  " FROM gzde_t t0",
                  "  ",
                                 " LEFT JOIN gzdel_t t1 ON t1.gzdel001=t0.gzde001 AND t1.gzdel002='"||g_lang||"' ",
 
                  " WHERE  ",l_wc, cl_sql_add_filter("gzde_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY gzde001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzde_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_gzde001,g_browser[g_cnt].b_gzde002, 
          g_browser[g_cnt].b_gzde003,g_browser[g_cnt].b_gzde001_desc
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
         CALL azzi901_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_gzde001) THEN
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
 
{<section id="azzi901.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION azzi901_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_gzde_m.gzde001 = g_browser[g_current_idx].b_gzde001   
 
   EXECUTE azzi901_master_referesh USING g_gzde_m.gzde001 INTO g_gzde_m.gzde001,g_gzde_m.gzde002,g_gzde_m.gzde008, 
       g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus,g_gzde_m.gzde007, 
       g_gzde_m.gzdeownid,g_gzde_m.gzdeowndp,g_gzde_m.gzdecrtid,g_gzde_m.gzdecrtdp,g_gzde_m.gzdecrtdt, 
       g_gzde_m.gzdemodid,g_gzde_m.gzdemoddt,g_gzde_m.gzdeownid_desc,g_gzde_m.gzdeowndp_desc,g_gzde_m.gzdecrtid_desc, 
       g_gzde_m.gzdecrtdp_desc,g_gzde_m.gzdemodid_desc
   
   CALL azzi901_gzde_t_mask()
   CALL azzi901_show()
      
END FUNCTION
 
{</section>}
 
{<section id="azzi901.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION azzi901_ui_detailshow()
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
 
{<section id="azzi901.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION azzi901_ui_browser_refresh()
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
      IF g_browser[l_i].b_gzde001 = g_gzde_m.gzde001 
 
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
 
{<section id="azzi901.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi901_construct()
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
   DEFINE ls_where    STRING
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_gzde_m.* TO NULL
   CALL g_gzdf_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON gzde001,gzdel003,gzdel004,gzde002,gzde008,gzde009,gzde005,gzde003,gzde006, 
          gzdestus,gzdeownid,gzdeowndp,gzdecrtid,gzdecrtdp,gzdecrtdt,gzdemodid,gzdemoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            CALL azzi901_set_combo_gzde006("gzde006")     #160921-00012 #2
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gzdecrtdt>>----
         AFTER FIELD gzdecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gzdemoddt>>----
         AFTER FIELD gzdemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzdecnfdt>>----
         
         #----<<gzdepstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.gzde001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzde001
            #add-point:ON ACTION controlp INFIELD gzde001 name="construct.c.gzde001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_gzde001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzde001  #顯示到畫面上

            NEXT FIELD gzde001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzde001
            #add-point:BEFORE FIELD gzde001 name="construct.b.gzde001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzde001
            
            #add-point:AFTER FIELD gzde001 name="construct.a.gzde001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdel003
            #add-point:BEFORE FIELD gzdel003 name="construct.b.gzdel003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdel003
            
            #add-point:AFTER FIELD gzdel003 name="construct.a.gzdel003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzdel003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdel003
            #add-point:ON ACTION controlp INFIELD gzdel003 name="construct.c.gzdel003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdel004
            #add-point:BEFORE FIELD gzdel004 name="construct.b.gzdel004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdel004
            
            #add-point:AFTER FIELD gzdel004 name="construct.a.gzdel004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzdel004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdel004
            #add-point:ON ACTION controlp INFIELD gzdel004 name="construct.c.gzdel004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzde002
            #add-point:BEFORE FIELD gzde002 name="construct.b.gzde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzde002
            
            #add-point:AFTER FIELD gzde002 name="construct.a.gzde002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzde002
            #add-point:ON ACTION controlp INFIELD gzde002 name="construct.c.gzde002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzde008
            #add-point:BEFORE FIELD gzde008 name="construct.b.gzde008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzde008
            
            #add-point:AFTER FIELD gzde008 name="construct.a.gzde008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzde008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzde008
            #add-point:ON ACTION controlp INFIELD gzde008 name="construct.c.gzde008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzde009
            #add-point:BEFORE FIELD gzde009 name="construct.b.gzde009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzde009
            
            #add-point:AFTER FIELD gzde009 name="construct.a.gzde009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzde009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzde009
            #add-point:ON ACTION controlp INFIELD gzde009 name="construct.c.gzde009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzde005
            #add-point:BEFORE FIELD gzde005 name="construct.b.gzde005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzde005
            
            #add-point:AFTER FIELD gzde005 name="construct.a.gzde005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzde005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzde005
            #add-point:ON ACTION controlp INFIELD gzde005 name="construct.c.gzde005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzde003
            #add-point:BEFORE FIELD gzde003 name="construct.b.gzde003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzde003
            
            #add-point:AFTER FIELD gzde003 name="construct.a.gzde003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzde003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzde003
            #add-point:ON ACTION controlp INFIELD gzde003 name="construct.c.gzde003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzde006
            #add-point:BEFORE FIELD gzde006 name="construct.b.gzde006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzde006
            
            #add-point:AFTER FIELD gzde006 name="construct.a.gzde006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzde006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzde006
            #add-point:ON ACTION controlp INFIELD gzde006 name="construct.c.gzde006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdestus
            #add-point:BEFORE FIELD gzdestus name="construct.b.gzdestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdestus
            
            #add-point:AFTER FIELD gzdestus name="construct.a.gzdestus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzdestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdestus
            #add-point:ON ACTION controlp INFIELD gzdestus name="construct.c.gzdestus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gzdeownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdeownid
            #add-point:ON ACTION controlp INFIELD gzdeownid name="construct.c.gzdeownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzdeownid  #顯示到畫面上

            NEXT FIELD gzdeownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdeownid
            #add-point:BEFORE FIELD gzdeownid name="construct.b.gzdeownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdeownid
            
            #add-point:AFTER FIELD gzdeownid name="construct.a.gzdeownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzdeowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdeowndp
            #add-point:ON ACTION controlp INFIELD gzdeowndp name="construct.c.gzdeowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzdeowndp  #顯示到畫面上

            NEXT FIELD gzdeowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdeowndp
            #add-point:BEFORE FIELD gzdeowndp name="construct.b.gzdeowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdeowndp
            
            #add-point:AFTER FIELD gzdeowndp name="construct.a.gzdeowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzdecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdecrtid
            #add-point:ON ACTION controlp INFIELD gzdecrtid name="construct.c.gzdecrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzdecrtid  #顯示到畫面上

            NEXT FIELD gzdecrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdecrtid
            #add-point:BEFORE FIELD gzdecrtid name="construct.b.gzdecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdecrtid
            
            #add-point:AFTER FIELD gzdecrtid name="construct.a.gzdecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzdecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdecrtdp
            #add-point:ON ACTION controlp INFIELD gzdecrtdp name="construct.c.gzdecrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzdecrtdp  #顯示到畫面上

            NEXT FIELD gzdecrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdecrtdp
            #add-point:BEFORE FIELD gzdecrtdp name="construct.b.gzdecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdecrtdp
            
            #add-point:AFTER FIELD gzdecrtdp name="construct.a.gzdecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdecrtdt
            #add-point:BEFORE FIELD gzdecrtdt name="construct.b.gzdecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gzdemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdemodid
            #add-point:ON ACTION controlp INFIELD gzdemodid name="construct.c.gzdemodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzdemodid  #顯示到畫面上

            NEXT FIELD gzdemodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdemodid
            #add-point:BEFORE FIELD gzdemodid name="construct.b.gzdemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdemodid
            
            #add-point:AFTER FIELD gzdemodid name="construct.a.gzdemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdemoddt
            #add-point:BEFORE FIELD gzdemoddt name="construct.b.gzdemoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON gzdf002,gzdfl003,gzdf003
           FROM s_detail1[1].gzdf002,s_detail1[1].gzdfl003,s_detail1[1].gzdf003
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdf002
            #add-point:BEFORE FIELD gzdf002 name="construct.b.page1.gzdf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdf002
            
            #add-point:AFTER FIELD gzdf002 name="construct.a.page1.gzdf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzdf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdf002
            #add-point:ON ACTION controlp INFIELD gzdf002 name="construct.c.page1.gzdf002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdfl003
            #add-point:BEFORE FIELD gzdfl003 name="construct.b.page1.gzdfl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdfl003
            
            #add-point:AFTER FIELD gzdfl003 name="construct.a.page1.gzdfl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzdfl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdfl003
            #add-point:ON ACTION controlp INFIELD gzdfl003 name="construct.c.page1.gzdfl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdf003
            #add-point:BEFORE FIELD gzdf003 name="construct.b.page1.gzdf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdf003
            
            #add-point:AFTER FIELD gzdf003 name="construct.a.page1.gzdf003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzdf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdf003
            #add-point:ON ACTION controlp INFIELD gzdf003 name="construct.c.page1.gzdf003"
            
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
                  WHEN la_wc[li_idx].tableid = "gzde_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "gzdf_t" 
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
   IF NOT cl_null(ls_where) THEN 
      #行業對應的標準報表元件
      #只能以indus_mod_notify 為單獨查詢條件，在可以進行 query
      IF g_wc.getIndexOf("indus_mod_notify",1) AND NOT g_wc.getIndexOf("and",1) THEN
         LET g_wc = ls_where
      END IF 
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzi901.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION azzi901_filter()
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
      CONSTRUCT g_wc_filter ON gzde001,gzde002,gzde003
                          FROM s_browse[1].b_gzde001,s_browse[1].b_gzde002,s_browse[1].b_gzde003
 
         BEFORE CONSTRUCT
               DISPLAY azzi901_filter_parser('gzde001') TO s_browse[1].b_gzde001
            DISPLAY azzi901_filter_parser('gzde002') TO s_browse[1].b_gzde002
            DISPLAY azzi901_filter_parser('gzde003') TO s_browse[1].b_gzde003
      
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
 
      CALL azzi901_filter_show('gzde001')
   CALL azzi901_filter_show('gzde002')
   CALL azzi901_filter_show('gzde003')
 
END FUNCTION
 
{</section>}
 
{<section id="azzi901.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION azzi901_filter_parser(ps_field)
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
 
{<section id="azzi901.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION azzi901_filter_show(ps_field)
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
   LET ls_condition = azzi901_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="azzi901.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION azzi901_query()
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
   CALL g_gzdf_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL azzi901_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL azzi901_browser_fill("")
      CALL azzi901_fetch("")
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
      CALL azzi901_filter_show('gzde001')
   CALL azzi901_filter_show('gzde002')
   CALL azzi901_filter_show('gzde003')
   CALL azzi901_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL azzi901_fetch("F") 
      #顯示單身筆數
      CALL azzi901_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzi901.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION azzi901_fetch(p_flag)
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
   
   LET g_gzde_m.gzde001 = g_browser[g_current_idx].b_gzde001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE azzi901_master_referesh USING g_gzde_m.gzde001 INTO g_gzde_m.gzde001,g_gzde_m.gzde002,g_gzde_m.gzde008, 
       g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus,g_gzde_m.gzde007, 
       g_gzde_m.gzdeownid,g_gzde_m.gzdeowndp,g_gzde_m.gzdecrtid,g_gzde_m.gzdecrtdp,g_gzde_m.gzdecrtdt, 
       g_gzde_m.gzdemodid,g_gzde_m.gzdemoddt,g_gzde_m.gzdeownid_desc,g_gzde_m.gzdeowndp_desc,g_gzde_m.gzdecrtid_desc, 
       g_gzde_m.gzdecrtdp_desc,g_gzde_m.gzdemodid_desc
   
   #遮罩相關處理
   LET g_gzde_m_mask_o.* =  g_gzde_m.*
   CALL azzi901_gzde_t_mask()
   LET g_gzde_m_mask_n.* =  g_gzde_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi901_set_act_visible()   
   CALL azzi901_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_gzde_m_t.* = g_gzde_m.*
   LET g_gzde_m_o.* = g_gzde_m.*
   
   LET g_data_owner = g_gzde_m.gzdeownid      
   LET g_data_dept  = g_gzde_m.gzdeowndp
   
   #重新顯示   
   CALL azzi901_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="azzi901.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi901_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE ls_msg   STRING 
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_gzdf_d.clear()   
 
 
   INITIALIZE g_gzde_m.* TO NULL             #DEFAULT 設定
   
   LET g_gzde001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   #設計器說topstd不可以新增
   IF g_account = "topstd" THEN
      #給錯誤訊息 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = "azz-00303" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF 
   # azzi901 為新增實體的4gl程式檔案用，新增後就會立即產生檔案。若只是要設定共用作業代號 (如配置 ACC應用作業)，請至azzi910註冊作業即可。
   #請問是否要進行新增？
   #  -按下否  離開
   #   按下是  進行 _insert( ) 後續動作
   #INSERT gzza_t 後，複製一個空樣板檔案過來，複製名稱即為註冊名稱，避免 rebuild 時發生 link 錯誤
   LET ls_msg = cl_getmsg("azz-00336",g_dlang)
   LET ls_msg = ls_msg,"\n",cl_getmsg("azz-00335",g_dlang)

   IF NOT cl_ask_promp(ls_msg) THEN 
      RETURN
   END IF
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gzde_m.gzdeownid = g_user
      LET g_gzde_m.gzdeowndp = g_dept
      LET g_gzde_m.gzdecrtid = g_user
      LET g_gzde_m.gzdecrtdp = g_dept 
      LET g_gzde_m.gzdecrtdt = cl_get_current()
      LET g_gzde_m.gzdemodid = g_user
      LET g_gzde_m.gzdemoddt = cl_get_current()
      LET g_gzde_m.gzdestus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_gzde_m.gzde008 = "s"
      LET g_gzde_m.gzde009 = "sd"
      LET g_gzde_m.gzdestus = "Y"
      LET g_gzde_m.gzde007 = "Y"
 
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_gzde_m_t.* = g_gzde_m.*
      LET g_gzde_m_o.* = g_gzde_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gzde_m.gzdestus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL azzi901_input("a")
      
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
         INITIALIZE g_gzde_m.* TO NULL
         INITIALIZE g_gzdf_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL azzi901_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_gzdf_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi901_set_act_visible()   
   CALL azzi901_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gzde001_t = g_gzde_m.gzde001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzde001 = '", g_gzde_m.gzde001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi901_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE azzi901_cl
   
   CALL azzi901_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE azzi901_master_referesh USING g_gzde_m.gzde001 INTO g_gzde_m.gzde001,g_gzde_m.gzde002,g_gzde_m.gzde008, 
       g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus,g_gzde_m.gzde007, 
       g_gzde_m.gzdeownid,g_gzde_m.gzdeowndp,g_gzde_m.gzdecrtid,g_gzde_m.gzdecrtdp,g_gzde_m.gzdecrtdt, 
       g_gzde_m.gzdemodid,g_gzde_m.gzdemoddt,g_gzde_m.gzdeownid_desc,g_gzde_m.gzdeowndp_desc,g_gzde_m.gzdecrtid_desc, 
       g_gzde_m.gzdecrtdp_desc,g_gzde_m.gzdemodid_desc
   
   
   #遮罩相關處理
   LET g_gzde_m_mask_o.* =  g_gzde_m.*
   CALL azzi901_gzde_t_mask()
   LET g_gzde_m_mask_n.* =  g_gzde_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzde_m.gzde001,g_gzde_m.gzdel003,g_gzde_m.gzdel004,g_gzde_m.gzde002,g_gzde_m.gzde008, 
       g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus,g_gzde_m.gzde007, 
       g_gzde_m.gzdeownid,g_gzde_m.gzdeownid_desc,g_gzde_m.gzdeowndp,g_gzde_m.gzdeowndp_desc,g_gzde_m.gzdecrtid, 
       g_gzde_m.gzdecrtid_desc,g_gzde_m.gzdecrtdp,g_gzde_m.gzdecrtdp_desc,g_gzde_m.gzdecrtdt,g_gzde_m.gzdemodid, 
       g_gzde_m.gzdemodid_desc,g_gzde_m.gzdemoddt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_gzde_m.gzdeownid      
   LET g_data_dept  = g_gzde_m.gzdeowndp
   
   #功能已完成,通報訊息中心
   CALL azzi901_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi901.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi901_modify()
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
   LET g_gzde_m_t.* = g_gzde_m.*
   LET g_gzde_m_o.* = g_gzde_m.*
   
   IF g_gzde_m.gzde001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_gzde001_t = g_gzde_m.gzde001
 
   CALL s_transaction_begin()
   
   OPEN azzi901_cl USING g_gzde_m.gzde001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi901_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE azzi901_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi901_master_referesh USING g_gzde_m.gzde001 INTO g_gzde_m.gzde001,g_gzde_m.gzde002,g_gzde_m.gzde008, 
       g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus,g_gzde_m.gzde007, 
       g_gzde_m.gzdeownid,g_gzde_m.gzdeowndp,g_gzde_m.gzdecrtid,g_gzde_m.gzdecrtdp,g_gzde_m.gzdecrtdt, 
       g_gzde_m.gzdemodid,g_gzde_m.gzdemoddt,g_gzde_m.gzdeownid_desc,g_gzde_m.gzdeowndp_desc,g_gzde_m.gzdecrtid_desc, 
       g_gzde_m.gzdecrtdp_desc,g_gzde_m.gzdemodid_desc
   
   #檢查是否允許此動作
   IF NOT azzi901_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gzde_m_mask_o.* =  g_gzde_m.*
   CALL azzi901_gzde_t_mask()
   LET g_gzde_m_mask_n.* =  g_gzde_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL azzi901_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_gzde001_t = g_gzde_m.gzde001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_gzde_m.gzdemodid = g_user 
LET g_gzde_m.gzdemoddt = cl_get_current()
LET g_gzde_m.gzdemodid_desc = cl_get_username(g_gzde_m.gzdemodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL azzi901_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE gzde_t SET (gzdemodid,gzdemoddt) = (g_gzde_m.gzdemodid,g_gzde_m.gzdemoddt)
          WHERE  gzde001 = g_gzde001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_gzde_m.* = g_gzde_m_t.*
            CALL azzi901_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_gzde_m.gzde001 != g_gzde_m_t.gzde001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE gzdf_t SET gzdf001 = g_gzde_m.gzde001
 
          WHERE  gzdf001 = g_gzde_m_t.gzde001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "gzdf_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzdf_t:",SQLERRMESSAGE 
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
   CALL azzi901_set_act_visible()   
   CALL azzi901_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzde001 = '", g_gzde_m.gzde001, "' "
 
   #填到對應位置
   CALL azzi901_browser_fill("")
 
   CLOSE azzi901_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL azzi901_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="azzi901.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzi901_input(p_cmd)
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
   DEFINE  li_cnt                LIKE type_t.num5 
   DEFINE  ls_file,ls_template   STRING
   DEFINE  ls_count              LIKE type_t.num5
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
   DISPLAY BY NAME g_gzde_m.gzde001,g_gzde_m.gzdel003,g_gzde_m.gzdel004,g_gzde_m.gzde002,g_gzde_m.gzde008, 
       g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus,g_gzde_m.gzde007, 
       g_gzde_m.gzdeownid,g_gzde_m.gzdeownid_desc,g_gzde_m.gzdeowndp,g_gzde_m.gzdeowndp_desc,g_gzde_m.gzdecrtid, 
       g_gzde_m.gzdecrtid_desc,g_gzde_m.gzdecrtdp,g_gzde_m.gzdecrtdp_desc,g_gzde_m.gzdecrtdt,g_gzde_m.gzdemodid, 
       g_gzde_m.gzdemodid_desc,g_gzde_m.gzdemoddt
   
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
   LET g_forupd_sql = "SELECT gzdf002,gzdf003 FROM gzdf_t WHERE gzdf001=? AND gzdf002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi901_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL azzi901_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL azzi901_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_gzde_m.gzde001,g_gzde_m.gzdel003,g_gzde_m.gzdel004,g_gzde_m.gzde002,g_gzde_m.gzde008, 
       g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="azzi901.input.head" >}
      #單頭段
      INPUT BY NAME g_gzde_m.gzde001,g_gzde_m.gzdel003,g_gzde_m.gzdel004,g_gzde_m.gzde002,g_gzde_m.gzde008, 
          g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF  NOT cl_null(g_gzde_m.gzde001) THEN
                   CALL n_gzdel(g_gzde_m.gzde001)
                   INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_gzde_m.gzde001
               CALL ap_ref_array2(g_ref_fields,"SELECT gzdel003,gzdel004 FROM gzdel_t WHERE gzdel001=? AND gzdel002='"||g_lang||"'","") RETURNING g_rtn_fields
                   LET g_gzde_m.gzdel003 = g_rtn_fields[1]
                   LET g_gzde_m.gzdel004 = g_rtn_fields[2]
                   DISPLAY BY NAME g_gzde_m.gzdel003
                   DISPLAY BY NAME g_gzde_m.gzdel004
                END IF
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN azzi901_cl USING g_gzde_m.gzde001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN azzi901_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE azzi901_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.gzdel001 = g_gzde_m.gzde001
LET g_master_multi_table_t.gzdel003 = g_gzde_m.gzdel003
LET g_master_multi_table_t.gzdel004 = g_gzde_m.gzdel004
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.gzdel001 = ''
LET g_master_multi_table_t.gzdel003 = ''
LET g_master_multi_table_t.gzdel004 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL azzi901_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL azzi901_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzde001
            #add-point:BEFORE FIELD gzde001 name="input.b.gzde001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzde001
            
            #add-point:AFTER FIELD gzde001 name="input.a.gzde001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gzde_m.gzde001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzde_m.gzde001 != g_gzde001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzde_t WHERE "||"gzde001 = '"||g_gzde_m.gzde001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT azzi901_check_gzde001() THEN
                     IF g_argv[1] IS NULL OR g_argv[1] <> "debug" THEN                  
                        NEXT FIELD gzde001
                     END IF 
                  END IF
               END IF
            END IF
 

           #若是曾經刪除過的程式代號，不可再拿來使用
           LET ls_count = 0
           SELECT COUNT(1) INTO ls_count FROM gzdh_t
            WHERE gzdh002 = g_gzde_m.gzde001
           IF ls_count > 0 THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = "azz-00364"
              LET g_errparam.code   = "azz-00364"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              NEXT FIELD gzde001
           END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzde001
            #add-point:ON CHANGE gzde001 name="input.g.gzde001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdel003
            #add-point:BEFORE FIELD gzdel003 name="input.b.gzdel003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdel003
            
            #add-point:AFTER FIELD gzdel003 name="input.a.gzdel003"
            IF NOT cl_null(g_gzde_m.gzdel003) THEN
               IF NOT cl_chk_tworcn(g_lang,g_gzde_m.gzdel003,20) THEN
                  NEXT FIELD gzdel003
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzdel003
            #add-point:ON CHANGE gzdel003 name="input.g.gzdel003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdel004
            #add-point:BEFORE FIELD gzdel004 name="input.b.gzdel004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdel004
            
            #add-point:AFTER FIELD gzdel004 name="input.a.gzdel004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzdel004
            #add-point:ON CHANGE gzdel004 name="input.g.gzdel004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzde002
            #add-point:BEFORE FIELD gzde002 name="input.b.gzde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzde002
            
            #add-point:AFTER FIELD gzde002 name="input.a.gzde002"
               IF NOT azzi901_check_gzde001() THEN 
                  NEXT FIELD gzde002
               END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzde002
            #add-point:ON CHANGE gzde002 name="input.g.gzde002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzde008
            #add-point:BEFORE FIELD gzde008 name="input.b.gzde008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzde008
            
            #add-point:AFTER FIELD gzde008 name="input.a.gzde008"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzde008
            #add-point:ON CHANGE gzde008 name="input.g.gzde008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzde009
            #add-point:BEFORE FIELD gzde009 name="input.b.gzde009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzde009
            
            #add-point:AFTER FIELD gzde009 name="input.a.gzde009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzde009
            #add-point:ON CHANGE gzde009 name="input.g.gzde009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzde005
            #add-point:BEFORE FIELD gzde005 name="input.b.gzde005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzde005
            
            #add-point:AFTER FIELD gzde005 name="input.a.gzde005"
            IF NOT azzi901_check_gzde001() THEN 
                  
            END IF 
              

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzde005
            #add-point:ON CHANGE gzde005 name="input.g.gzde005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzde003
            #add-point:BEFORE FIELD gzde003 name="input.b.gzde003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzde003
            
            #add-point:AFTER FIELD gzde003 name="input.a.gzde003"
            IF NOT azzi901_check_gzde001() THEN 
               NEXT FIELD gzde003    
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzde003
            #add-point:ON CHANGE gzde003 name="input.g.gzde003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzde006
            #add-point:BEFORE FIELD gzde006 name="input.b.gzde006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzde006
            
            #add-point:AFTER FIELD gzde006 name="input.a.gzde006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzde006
            #add-point:ON CHANGE gzde006 name="input.g.gzde006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdestus
            #add-point:BEFORE FIELD gzdestus name="input.b.gzdestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdestus
            
            #add-point:AFTER FIELD gzdestus name="input.a.gzdestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzdestus
            #add-point:ON CHANGE gzdestus name="input.g.gzdestus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gzde001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzde001
            #add-point:ON ACTION controlp INFIELD gzde001 name="input.c.gzde001"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzdel003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdel003
            #add-point:ON ACTION controlp INFIELD gzdel003 name="input.c.gzdel003"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzdel004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdel004
            #add-point:ON ACTION controlp INFIELD gzdel004 name="input.c.gzdel004"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzde002
            #add-point:ON ACTION controlp INFIELD gzde002 name="input.c.gzde002"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzde008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzde008
            #add-point:ON ACTION controlp INFIELD gzde008 name="input.c.gzde008"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzde009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzde009
            #add-point:ON ACTION controlp INFIELD gzde009 name="input.c.gzde009"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzde005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzde005
            #add-point:ON ACTION controlp INFIELD gzde005 name="input.c.gzde005"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzde003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzde003
            #add-point:ON ACTION controlp INFIELD gzde003 name="input.c.gzde003"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzde006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzde006
            #add-point:ON ACTION controlp INFIELD gzde006 name="input.c.gzde006"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzdestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdestus
            #add-point:ON ACTION controlp INFIELD gzdestus name="input.c.gzdestus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_gzde_m.gzde001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
               IF azzi901_chk_dgenv() THEN
                 #160520-00015 #1 add                    
                 #Begin:20160520 by Hiko : 不論甚麼類型, 都新增到gzzb_t.
                 #IF g_gzde_m.gzde003 = 'S' OR g_gzde_m.gzde003 = "X" OR g_gzde_m.gzde003 = "G" THEN
                 #   IF g_gzde_m.gzde001[1,1] <> 'b' THEN
                 #      IF p_cmd = 'a' THEN
                 #         CALL azzi901_ins_gzzb(1) #a/c/d/e
                 #      END IF
                 #   ELSE
                 #      #規格類別 X/G && 行業別 <> sd #b
                 #      IF (g_gzde_m.gzde003 = "X" OR g_gzde_m.gzde003 = "G" ) AND g_gzde_m.gzde009 <> "sd" THEN
                 #         CALL azzi901_ins_gzzb(2)
                 #      END IF
                 #   END IF
                 #END IF
                  IF p_cmd = 'a' THEN
                     CALL azzi901_ins_gzzb(1)
                  END IF
                  #End:20160520
                  #160520-00015 #1 end   
              END IF

            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO gzde_t (gzde001,gzde002,gzde008,gzde009,gzde005,gzde003,gzde006,gzdestus, 
                   gzde007,gzdeownid,gzdeowndp,gzdecrtid,gzdecrtdp,gzdecrtdt,gzdemodid,gzdemoddt)
               VALUES (g_gzde_m.gzde001,g_gzde_m.gzde002,g_gzde_m.gzde008,g_gzde_m.gzde009,g_gzde_m.gzde005, 
                   g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus,g_gzde_m.gzde007,g_gzde_m.gzdeownid, 
                   g_gzde_m.gzdeowndp,g_gzde_m.gzdecrtid,g_gzde_m.gzdecrtdp,g_gzde_m.gzdecrtdt,g_gzde_m.gzdemodid, 
                   g_gzde_m.gzdemoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_gzde_m:",SQLERRMESSAGE 
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
         IF g_gzde_m.gzde001 = g_master_multi_table_t.gzdel001 AND
         g_gzde_m.gzdel003 = g_master_multi_table_t.gzdel003 AND 
         g_gzde_m.gzdel004 = g_master_multi_table_t.gzdel004  THEN
         ELSE 
            LET l_var_keys[01] = g_gzde_m.gzde001
            LET l_field_keys[01] = 'gzdel001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.gzdel001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gzdel002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_gzde_m.gzdel003
            LET l_fields[01] = 'gzdel003'
            LET l_vars[02] = g_gzde_m.gzdel004
            LET l_fields[02] = 'gzdel004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzdel_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
                  #新增模組link的程式
                  SELECT COUNT(*) INTO l_count FROM gzzn_t
                    WHERE  gzzn001 = g_gzde_m.gzde002
                    AND gzzn002 = g_gzde_m.gzde001

                  IF l_count = 0 THEN 
                     INSERT INTO gzzn_t(gzzn001,gzzn002,gzzn003,gzzn004)
                        VALUES(g_gzde_m.gzde002,g_gzde_m.gzde001,'Y','N')

                     RUN " r.l " || DOWNSHIFT(g_gzde_m.gzde002) WITHOUT WAITING   
                  END IF
                  #ADZ 模組不複製一個空樣板檔案
                  IF g_gzde_m.gzde002 = "ADZ" THEN 
                  ELSE 
                     #INSERT gzza_t 後，複製一個空樣板檔案過來，複製名稱即為註冊名稱，避免 rebuild 時發生 link 錯誤
                     LET ls_file = os.path.join(os.path.join(FGL_GETENV(UPSHIFT(g_gzde_m.gzde002)),"4gl"),g_gzde_m.gzde001||".4gl")
                     LET ls_template = os.Path.join(os.path.join(FGL_GETENV("ERP"),"mdl"),"code_empty_m.template") 
                     CALL s_azzi900_copy_template(ls_file,ls_template)
                  END IF 
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL azzi901_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL azzi901_b_fill()
                  CALL azzi901_b_fill2('0')
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
               CALL azzi901_gzde_t_mask_restore('restore_mask_o')
               
               UPDATE gzde_t SET (gzde001,gzde002,gzde008,gzde009,gzde005,gzde003,gzde006,gzdestus,gzde007, 
                   gzdeownid,gzdeowndp,gzdecrtid,gzdecrtdp,gzdecrtdt,gzdemodid,gzdemoddt) = (g_gzde_m.gzde001, 
                   g_gzde_m.gzde002,g_gzde_m.gzde008,g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003, 
                   g_gzde_m.gzde006,g_gzde_m.gzdestus,g_gzde_m.gzde007,g_gzde_m.gzdeownid,g_gzde_m.gzdeowndp, 
                   g_gzde_m.gzdecrtid,g_gzde_m.gzdecrtdp,g_gzde_m.gzdecrtdt,g_gzde_m.gzdemodid,g_gzde_m.gzdemoddt) 
 
                WHERE  gzde001 = g_gzde001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gzde_t:",SQLERRMESSAGE 
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
         IF g_gzde_m.gzde001 = g_master_multi_table_t.gzdel001 AND
         g_gzde_m.gzdel003 = g_master_multi_table_t.gzdel003 AND 
         g_gzde_m.gzdel004 = g_master_multi_table_t.gzdel004  THEN
         ELSE 
            LET l_var_keys[01] = g_gzde_m.gzde001
            LET l_field_keys[01] = 'gzdel001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.gzdel001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gzdel002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_gzde_m.gzdel003
            LET l_fields[01] = 'gzdel003'
            LET l_vars[02] = g_gzde_m.gzdel004
            LET l_fields[02] = 'gzdel004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzdel_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL azzi901_gzde_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_gzde_m_t)
               LET g_log2 = util.JSON.stringify(g_gzde_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_gzde001_t = g_gzde_m.gzde001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="azzi901.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_gzdf_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.detail_input.page1.update_item"
             IF  NOT cl_null(g_gzdf_d[l_ac].gzdf002) THEN
                  CALL n_gzdfl(g_gzdf_d[l_ac].gzdf002) 
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_gzdf_d[l_ac].gzdf002
                  CALL ap_ref_array2(g_ref_fields," SELECT gzdfl003 FROM gzdfl_t WHERE gzdfl001 = ? AND gzdfl002 = '"||g_lang||"'","") RETURNING g_rtn_fields
                  LET g_gzdf_d[l_ac].gzdfl003 = g_rtn_fields[1]
                  DISPLAY BY NAME g_gzdf_d[l_ac].gzdfl003
               END IF    
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzdf_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi901_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_gzdf_d.getLength()
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
            OPEN azzi901_cl USING g_gzde_m.gzde001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN azzi901_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE azzi901_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_gzdf_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gzdf_d[l_ac].gzdf002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzdf_d_t.* = g_gzdf_d[l_ac].*  #BACKUP
               LET g_gzdf_d_o.* = g_gzdf_d[l_ac].*  #BACKUP
               CALL azzi901_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL azzi901_set_no_entry_b(l_cmd)
               IF NOT azzi901_lock_b("gzdf_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi901_bcl INTO g_gzdf_d[l_ac].gzdf002,g_gzdf_d[l_ac].gzdf003
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gzdf_d_t.gzdf002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzdf_d_mask_o[l_ac].* =  g_gzdf_d[l_ac].*
                  CALL azzi901_gzdf_t_mask()
                  LET g_gzdf_d_mask_n[l_ac].* =  g_gzdf_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL azzi901_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.gzdfl001 = g_gzdf_d[l_ac].gzdf002
LET g_detail_multi_table_t.gzdfl002 = g_dlang
LET g_detail_multi_table_t.gzdfl003 = g_gzdf_d[l_ac].gzdfl003
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'gzdfl001'
            LET l_var_keys[01] = g_gzdf_d[l_ac].gzdf002
            LET l_field_keys[02] = 'gzdfl002'
            LET l_var_keys[02] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'gzdfl_t') THEN
               RETURN 
            END IF 
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzdf_d[l_ac].* TO NULL 
            INITIALIZE g_gzdf_d_t.* TO NULL 
            INITIALIZE g_gzdf_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #160615-00001 #1 start
            #設計器說topstd不可以新增
            IF g_account = "topstd" THEN
               #給錯誤訊息 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = "azz-00303" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
            #160615-00001 #1 end
            LET g_gzdf_d[l_ac].gzdf003 = FGL_GETENV("DGENV")
            #end add-point
            LET g_gzdf_d_t.* = g_gzdf_d[l_ac].*     #新輸入資料
            LET g_gzdf_d_o.* = g_gzdf_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi901_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL azzi901_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzdf_d[li_reproduce_target].* = g_gzdf_d[li_reproduce].*
 
               LET g_gzdf_d[li_reproduce_target].gzdf002 = NULL
 
            END IF
            
LET g_detail_multi_table_t.gzdfl001 = g_gzdf_d[l_ac].gzdf002
LET g_detail_multi_table_t.gzdfl002 = g_dlang
LET g_detail_multi_table_t.gzdfl003 = g_gzdf_d[l_ac].gzdfl003
 
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
            SELECT COUNT(1) INTO l_count FROM gzdf_t 
             WHERE  gzdf001 = g_gzde_m.gzde001
 
               AND gzdf002 = g_gzdf_d[l_ac].gzdf002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzde_m.gzde001
               LET gs_keys[2] = g_gzdf_d[g_detail_idx].gzdf002
               CALL azzi901_insert_b('gzdf_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_gzdf_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzdf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi901_b_fill()
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_gzdf_d[l_ac].gzdf002 = g_detail_multi_table_t.gzdfl001 AND
         g_gzdf_d[l_ac].gzdfl003 = g_detail_multi_table_t.gzdfl003 THEN
         ELSE 
            LET l_var_keys[01] = g_gzdf_d[l_ac].gzdf002
            LET l_field_keys[01] = 'gzdfl001'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.gzdfl001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gzdfl002'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.gzdfl002
            LET l_vars[01] = g_gzdf_d[l_ac].gzdfl003
            LET l_fields[01] = 'gzdfl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzdfl_t')
         END IF 
 
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
               #160721-00020 #1 
               SELECT COUNT(*) INTO ls_count FROM gzdf_t WHERE gzdf002 = g_gzdf_d[l_ac].gzdf002 
               IF ls_count = 1 THEN 
               
                  IF s_azzi900_cnt_dzax(g_gzdf_d[l_ac].gzdf002) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code   = "azz-00333"
                     LET g_errparam.popup  = TRUE
                     LET g_errparam.replace[1] = g_gzdf_d[l_ac].gzdf002
                     CALL cl_err()
                     CANCEL DELETE
                  END IF
               END IF 
               #160721-00020 #1                
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
               LET gs_keys[01] = g_gzde_m.gzde001
 
               LET gs_keys[gs_keys.getLength()+1] = g_gzdf_d_t.gzdf002
 
            
               #刪除同層單身
               IF NOT azzi901_delete_b('gzdf_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi901_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT azzi901_key_delete_b(gs_keys,'gzdf_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi901_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'gzdfl001'
                  LET l_var_keys_bak[01] = g_detail_multi_table_t.gzdfl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'gzdfl_t')
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE azzi901_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_gzdf_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gzdf_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdf002
            #add-point:BEFORE FIELD gzdf002 name="input.b.page1.gzdf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdf002
            
            #add-point:AFTER FIELD gzdf002 name="input.a.page1.gzdf002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gzde_m.gzde001) AND NOT cl_null(g_gzdf_d[l_ac].gzdf002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzde_m.gzde001 != g_gzde001_t OR g_gzdf_d[l_ac].gzdf002 != g_gzdf_d_t.gzdf002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzdf_t WHERE "||"gzdf001 = '"||g_gzde_m.gzde001 ||"' AND "|| "gzdf002 = '"||g_gzdf_d[l_ac].gzdf002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #修改時
               IF l_cmd = 'u' AND (g_gzdf_d[l_ac].gzdf002 != g_gzdf_d_t.gzdf002) THEN
                     CALL azzi901_check_gzdf002_2(g_gzdf_d_t.gzdf002)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        NEXT FIELD gzdf002
                     END IF
               END IF
               #新增時
               IF l_cmd = 'a' THEN 
                  CALL s_azzi900_check_gzdf002(g_gzde_m.gzde001,g_gzdf_d[l_ac].gzdf002,"2")
              
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD gzdf002
                  END IF 
                  #環境變數
#                  IF FGL_GETENV("DGENV") = "s" THEN 
#                     LET g_gzdf_d[l_ac].gzdf003 = "s"
#                  ELSE 
#                     LET g_gzdf_d[l_ac].gzdf003 = "c"   
#                  END IF 
               END IF #end if l_cmd = 'a'  
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzdf002
            #add-point:ON CHANGE gzdf002 name="input.g.page1.gzdf002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdfl003
            #add-point:BEFORE FIELD gzdfl003 name="input.b.page1.gzdfl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdfl003
            
            #add-point:AFTER FIELD gzdfl003 name="input.a.page1.gzdfl003"
            IF NOT cl_null(g_gzdf_d[l_ac].gzdfl003) THEN
               IF NOT cl_chk_tworcn(g_lang,g_gzdf_d[l_ac].gzdfl003,20) THEN
                  NEXT FIELD gzdfl003
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzdfl003
            #add-point:ON CHANGE gzdfl003 name="input.g.page1.gzdfl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzdf003
            #add-point:BEFORE FIELD gzdf003 name="input.b.page1.gzdf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzdf003
            
            #add-point:AFTER FIELD gzdf003 name="input.a.page1.gzdf003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzdf003
            #add-point:ON CHANGE gzdf003 name="input.g.page1.gzdf003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gzdf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdf002
            #add-point:ON ACTION controlp INFIELD gzdf002 name="input.c.page1.gzdf002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzdfl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdfl003
            #add-point:ON ACTION controlp INFIELD gzdfl003 name="input.c.page1.gzdfl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzdf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzdf003
            #add-point:ON ACTION controlp INFIELD gzdf003 name="input.c.page1.gzdf003"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gzdf_d[l_ac].* = g_gzdf_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE azzi901_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gzdf_d[l_ac].gzdf002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_gzdf_d[l_ac].* = g_gzdf_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL azzi901_gzdf_t_mask_restore('restore_mask_o')
      
               UPDATE gzdf_t SET (gzdf001,gzdf002,gzdf003) = (g_gzde_m.gzde001,g_gzdf_d[l_ac].gzdf002, 
                   g_gzdf_d[l_ac].gzdf003)
                WHERE  gzdf001 = g_gzde_m.gzde001 
 
                  AND gzdf002 = g_gzdf_d_t.gzdf002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_gzdf_d[l_ac].* = g_gzdf_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzdf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gzdf_d[l_ac].* = g_gzdf_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzdf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_gzdf_d[l_ac].gzdf002 = g_detail_multi_table_t.gzdfl001 AND
         g_gzdf_d[l_ac].gzdfl003 = g_detail_multi_table_t.gzdfl003 THEN
         ELSE 
            LET l_var_keys[01] = g_gzdf_d[l_ac].gzdf002
            LET l_field_keys[01] = 'gzdfl001'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.gzdfl001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gzdfl002'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.gzdfl002
            LET l_vars[01] = g_gzdf_d[l_ac].gzdfl003
            LET l_fields[01] = 'gzdfl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzdfl_t')
         END IF 
 
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzde_m.gzde001
               LET gs_keys_bak[1] = g_gzde001_t
               LET gs_keys[2] = g_gzdf_d[g_detail_idx].gzdf002
               LET gs_keys_bak[2] = g_gzdf_d_t.gzdf002
               CALL azzi901_update_b('gzdf_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL azzi901_gzdf_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_gzdf_d[g_detail_idx].gzdf002 = g_gzdf_d_t.gzdf002 
 
                  ) THEN
                  LET gs_keys[01] = g_gzde_m.gzde001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gzdf_d_t.gzdf002
 
                  CALL azzi901_key_update_b(gs_keys,'gzdf_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gzde_m),util.JSON.stringify(g_gzdf_d_t)
               LET g_log2 = util.JSON.stringify(g_gzde_m),util.JSON.stringify(g_gzdf_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL azzi901_unlock_b("gzdf_t","'1'")
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
               LET g_gzdf_d[li_reproduce_target].* = g_gzdf_d[li_reproduce].*
 
               LET g_gzdf_d[li_reproduce_target].gzdf002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gzdf_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gzdf_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="azzi901.input.other" >}
      
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
            NEXT FIELD gzde001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gzdf002
 
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
 
{<section id="azzi901.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION azzi901_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL azzi901_b_fill() #單身填充
      CALL azzi901_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL azzi901_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gzde_m.gzde001
   CALL ap_ref_array2(g_ref_fields," SELECT gzdel003,gzdel004 FROM gzdel_t WHERE gzdel001 = ? AND gzdel002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_gzde_m.gzdel003 = g_rtn_fields[1] 
   LET g_gzde_m.gzdel004 = g_rtn_fields[2] 
   DISPLAY BY NAME g_gzde_m.gzdel003,g_gzde_m.gzdel004
   
   #160921-00012 start
   #配合報表組 G類 X類 程式產生類型(gzde005) 舊有資料顯示方式調整     #17/01/18
   CASE 
      WHEN g_gzde_m.gzde005 = "G"
         IF g_gzde_m.gzde006 <> "1" THEN 
            LET g_gzde_m.gzde006 = "1"
         END IF 

      WHEN g_gzde_m.gzde005 = "X"
         #IF g_gzde_m.gzde006 <> "1" OR g_gzde_m.gzde006 <> "2" THEN      #170303-00017 
         IF g_gzde_m.gzde006 <> "1" AND g_gzde_m.gzde006 <> "2" THEN      #170303-00017
            LET g_gzde_m.gzde006 = "1"
         END IF 
      OTHERWISE 
   END CASE
   #160921-00012 end   
   #end add-point
   
   #遮罩相關處理
   LET g_gzde_m_mask_o.* =  g_gzde_m.*
   CALL azzi901_gzde_t_mask()
   LET g_gzde_m_mask_n.* =  g_gzde_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzde_m.gzde001,g_gzde_m.gzdel003,g_gzde_m.gzdel004,g_gzde_m.gzde002,g_gzde_m.gzde008, 
       g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus,g_gzde_m.gzde007, 
       g_gzde_m.gzdeownid,g_gzde_m.gzdeownid_desc,g_gzde_m.gzdeowndp,g_gzde_m.gzdeowndp_desc,g_gzde_m.gzdecrtid, 
       g_gzde_m.gzdecrtid_desc,g_gzde_m.gzdecrtdp,g_gzde_m.gzdecrtdp_desc,g_gzde_m.gzdecrtdt,g_gzde_m.gzdemodid, 
       g_gzde_m.gzdemodid_desc,g_gzde_m.gzdemoddt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gzde_m.gzdestus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gzdf_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_gzdf_d[l_ac].gzdf002
   CALL ap_ref_array2(g_ref_fields," SELECT gzdfl003 FROM gzdfl_t WHERE gzdfl001 = ? AND gzdfl002 = '"||g_lang||"'","") RETURNING g_rtn_fields
   LET g_gzdf_d[l_ac].gzdfl003 = g_rtn_fields[1]
   DISPLAY BY NAME g_gzdf_d[l_ac].gzdfl003
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   #確認是否是安全機制
   LET lc_chk_sec = s_azzi900_chk_security(g_gzde_m.gzde001,g_gzde_m.gzde002)   
   DISPLAY lc_chk_sec TO chk_sec 
   
   #顯示報表元件
   #行業對應的標準報表元件
#   LET g_gzde_m.indus_mod_notify = ""
#   IF g_gzde_m.gzde003 = 'S' OR g_gzde_m.gzde003 = "X" OR g_gzde_m.gzde003 = "G" THEN
#      IF g_gzde_m.gzde009 <> "sd" AND cl_null(g_gzde_m.indus_mod_notify) THEN 
#         SELECT gzzb001 INTO g_gzde_m.indus_mod_notify FROM gzzb_t
#          WHERE gzzb002 = g_gzde_m.gzde009
#           AND  gzzb003 = g_gzde_m.gzde001
#      END IF
#      DISPLAY BY NAME g_gzde_m.indus_mod_notify
#   END IF 
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL azzi901_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzi901.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION azzi901_detail_show()
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
 
{<section id="azzi901.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION azzi901_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE gzde_t.gzde001 
   DEFINE l_oldno     LIKE gzde_t.gzde001 
 
   DEFINE l_master    RECORD LIKE gzde_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE gzdf_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_gzde_m.gzde001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_gzde001_t = g_gzde_m.gzde001
 
    
   LET g_gzde_m.gzde001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gzde_m.gzdeownid = g_user
      LET g_gzde_m.gzdeowndp = g_dept
      LET g_gzde_m.gzdecrtid = g_user
      LET g_gzde_m.gzdecrtdp = g_dept 
      LET g_gzde_m.gzdecrtdt = cl_get_current()
      LET g_gzde_m.gzdemodid = g_user
      LET g_gzde_m.gzdemoddt = cl_get_current()
      LET g_gzde_m.gzdestus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_gzde_m.gzdestus = "Y"
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gzde_m.gzdestus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL azzi901_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_gzde_m.* TO NULL
      INITIALIZE g_gzdf_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL azzi901_show()
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
   CALL azzi901_set_act_visible()   
   CALL azzi901_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gzde001_t = g_gzde_m.gzde001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzde001 = '", g_gzde_m.gzde001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi901_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL azzi901_idx_chk()
   
   LET g_data_owner = g_gzde_m.gzdeownid      
   LET g_data_dept  = g_gzde_m.gzdeowndp
   
   #功能已完成,通報訊息中心
   CALL azzi901_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="azzi901.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION azzi901_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gzdf_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE azzi901_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gzdf_t
    WHERE  gzdf001 = g_gzde001_t
 
    INTO TEMP azzi901_detail
 
   #將key修正為調整後   
   UPDATE azzi901_detail 
      #更新key欄位
      SET gzdf001 = g_gzde_m.gzde001
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO gzdf_t SELECT * FROM azzi901_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   DELETE FROM gzdf_t WHERE gzdf001 = g_gzde_m.gzde001      #161123-00050 add
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE azzi901_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
      #應用 a38 樣板自動產生(Version:6)
   #單身多語言複製
   DROP TABLE azzi901_detail_lang
   
   #add-point:單身複製前1 name="detail_reproduce.body.lang0.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE & INSERT 
   SELECT * FROM gzdfl_t 
    WHERE  gzdfl001 = g_gzde001_t
 
     INTO TEMP azzi901_detail_lang
 
   #將key修正為調整後   
   UPDATE azzi901_detail_lang 
      #更新key欄位
      SET gzdfl001 = g_gzde_m.gzde001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.lang0.b_update"
 
   #end add-point   
  
   #將資料塞回原table   
   INSERT INTO gzdfl_t SELECT * FROM azzi901_detail_lang
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.lang0.table1.m_insert"
   DELETE FROM gzdfl_t WHERE gzdfl001 = g_gzde_m.gzde001    #161123-00050 
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE azzi901_detail_lang
   
   #add-point:單身複製後1 name="detail_reproduce.lang0.table1.a_insert"
   
   #end add-point
 
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gzde001_t = g_gzde_m.gzde001
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi901.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi901_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE ls_msg      STRING 
   DEFINE li_cnt      LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_gzde_m.gzde001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.gzdel001 = g_gzde_m.gzde001
LET g_master_multi_table_t.gzdel003 = g_gzde_m.gzdel003
LET g_master_multi_table_t.gzdel004 = g_gzde_m.gzdel004
 
   
   CALL s_transaction_begin()
 
   OPEN azzi901_cl USING g_gzde_m.gzde001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi901_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE azzi901_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi901_master_referesh USING g_gzde_m.gzde001 INTO g_gzde_m.gzde001,g_gzde_m.gzde002,g_gzde_m.gzde008, 
       g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus,g_gzde_m.gzde007, 
       g_gzde_m.gzdeownid,g_gzde_m.gzdeowndp,g_gzde_m.gzdecrtid,g_gzde_m.gzdecrtdp,g_gzde_m.gzdecrtdt, 
       g_gzde_m.gzdemodid,g_gzde_m.gzdemoddt,g_gzde_m.gzdeownid_desc,g_gzde_m.gzdeowndp_desc,g_gzde_m.gzdecrtid_desc, 
       g_gzde_m.gzdecrtdp_desc,g_gzde_m.gzdemodid_desc
   
   
   #檢查是否允許此動作
   IF NOT azzi901_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gzde_m_mask_o.* =  g_gzde_m.*
   CALL azzi901_gzde_t_mask()
   LET g_gzde_m_mask_n.* =  g_gzde_m.*
   
   CALL azzi901_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      #先檢查 dzax_t dzax001是否存在該程式設計資料
       #存在時，顯示提示：系統內仍存在程式 %1 的設計資料，刪除程式設定資料前應該先行移除設計資料(adzp063)。
        #是:進行 _delete( )後續動作
        #完成刪除後，刪除目錄(順便檢查客制目錄一起刪除)下的4gl/42m(注意檔名是azz_azzi900.42m及azz_azzi900.4gl)/42r 
       #160711-00014 #1 start
       IF g_gzdf_d.getLength() > 0 THEN 
          FOR li_cnt = 1 TO g_gzdf_d.getLength()
              IF s_azzi900_cnt_dzax(g_gzdf_d[li_cnt].gzdf002) THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code   = "azz-00333"
                 LET g_errparam.popup  = TRUE
                 LET g_errparam.replace[1] = g_gzdf_d[li_cnt].gzdf002
                 CALL cl_err()
                 RETURN
              END IF 
          END FOR 
       END IF 
       #160711-00014 #1 end 
       
       IF s_azzi900_cnt_dzax(g_gzde_m.gzde001) THEN 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = "azz-00333"
          LET g_errparam.popup  = TRUE
          LET g_errparam.replace[1] = g_gzde_m.gzde001
          CALL cl_err()
          RETURN
       END IF
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzi901_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_gzde001_t = g_gzde_m.gzde001
 
 
      DELETE FROM gzde_t
       WHERE  gzde001 = g_gzde_m.gzde001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_gzde_m.gzde001,":",SQLERRMESSAGE  
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
      
      DELETE FROM gzdf_t
       WHERE  gzdf001 = g_gzde_m.gzde001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzdf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      #delete 模組link 的程式
      DELETE FROM gzzn_t
         WHERE  gzzn001 = g_gzde_m.gzde002 
           AND  gzzn002 = g_gzde_m.gzde001
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "gzdf_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
     #子程式、G:報表元件-GeneroReport類、X:報表元件-XTRAGRID類
      IF g_gzde_m.gzde003 = 'S' OR g_gzde_m.gzde003 = "X" OR g_gzde_m.gzde003 = "G" THEN 

          IF g_gzde_m.gzde001[1,1] <> 'b' THEN 
             DELETE FROM gzzb_t
              WHERE gzzb001 = g_gzde_m.gzde001 
          ELSE 
             
            SELECT COUNT(*) INTO li_cnt FROM gzzb_t
             WHERE gzzb003 = g_gzde_m.gzde001  
              AND  gzzb002 = g_gzde_m.gzde009  
             IF li_cnt > 0 THEN 
                DELETE FROM gzzb_t
                 WHERE gzzb003 = g_gzde_m.gzde001 
                  AND  gzzb002 = g_gzde_m.gzde009 
             END IF 
          END IF  
      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "gzzb_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()
            CALL s_transaction_end('N','0')
         RETURN
      END IF                 
    END IF 
    
     #刪除子畫面規格編 多語言
      FOR li_cnt = 1 TO g_gzdf_d.getLength()
          DELETE  from gzdfl_t
             WHERE gzdfl001 =  g_gzdf_d[li_cnt].gzdf002
          
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "gzdfl_t"
             LET g_errparam.popup = FALSE
             CALL cl_err()
 
             CALL s_transaction_end('N','0')
             RETURN
          END IF    
      END FOR 
      
      RUN " r.l " || DOWNSHIFT(g_gzde_m.gzde002) WITHOUT WAITING    

      #完成刪除後，刪除目錄(順便檢查客制目錄一起刪除)下的4gl/42m(注意檔名是azz_azzi900_01.42m及azz_azzi900_01.4gl)/42r 
      CALL s_azzi900_del_file("S",g_gzde_m.gzde001,g_gzde_m.gzde002,g_gzde_m.gzde008)
#客製不管控 
IF FGL_GETENV("DGENV") <> "c" THEN  #161117-00018 add       
      #資料刪除後，需紀錄此程式代號已被用過，不可再拿來使用
      #因為若日後有人再拿此程式代號來使用，但客戶家該程式已改為客製，
      #這樣可能會造成客戶家上patch時程式合併的問題
      LET g_gzdh.gzdhownid = g_user
      LET g_gzdh.gzdhowndp = g_dept
      LET g_gzdh.gzdhcrtid = g_user
      LET g_gzdh.gzdhcrtdp = g_dept
      LET g_gzdh.gzdhcrtdt = cl_get_current()
      LET g_gzdh.gzdhmodid = g_user
      LET g_gzdh.gzdhmoddt = cl_get_current()
      LET g_gzdh.gzdhstus = "Y"
      LET g_gzdh.gzdh001 = "azzi901"
      LET g_gzdh.gzdh002 = g_gzde_m.gzde001
      DELETE FROM gzdh_t WHERE gzdh001=g_gzdh.gzdh001 AND gzdh002=g_gzdh.gzdh002
      INSERT INTO gzdh_t (gzdhownid,gzdhowndp,gzdhcrtid,gzdhcrtdp,gzdhcrtdt,
                          gzdhmodid,gzdhmoddt,gzdhstus,gzdh001,gzdh002)
                  VALUES (g_gzdh.gzdhownid,g_gzdh.gzdhowndp,g_gzdh.gzdhcrtid,g_gzdh.gzdhcrtdp,g_gzdh.gzdhcrtdt,
                          g_gzdh.gzdhmodid,g_gzdh.gzdhmoddt,g_gzdh.gzdhstus,g_gzdh.gzdh001,g_gzdh.gzdh002)

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "g_gzdh"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
END IF     #161117-00018 add      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_gzde_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE azzi901_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_gzdf_d.clear() 
 
     
      CALL azzi901_ui_browser_refresh()  
      #CALL azzi901_ui_headershow()  
      #CALL azzi901_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_master_multi_table_t.gzdel001
   LET l_field_keys[01] = 'gzdel001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'gzdel_t')
 
      
      #單身多語言刪除
      #該單身多語言並無串接到單頭的key值, 若要刪除所有單身請於add-point中自行撰寫!
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
 
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL azzi901_browser_fill("")
         CALL azzi901_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE azzi901_cl
 
   #功能已完成,通報訊息中心
   CALL azzi901_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="azzi901.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi901_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_gzdf_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF azzi901_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gzdf002,gzdf003  FROM gzdf_t",   
                     " INNER JOIN gzde_t ON  gzde001 = gzdf001 ",
 
                     #" LEFT JOIN gzdfl_t ON gzdf002 = gzdfl001 AND gzdfl002 = '",g_dlang,"'",
                     
                     " LEFT JOIN gzdfl_t ON gzdf002 = gzdfl001 AND gzdfl002 = '",g_dlang,"'",
                     #下層單身所需的join條件
 
                     
                     " WHERE gzdf001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gzdf_t.gzdf002"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE azzi901_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR azzi901_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_gzde_m.gzde001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_gzde_m.gzde001 INTO g_gzdf_d[l_ac].gzdf002,g_gzdf_d[l_ac].gzdf003    
          #(ver:78)
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
   
   CALL g_gzdf_d.deleteElement(g_gzdf_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE azzi901_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_gzdf_d.getLength()
      LET g_gzdf_d_mask_o[l_ac].* =  g_gzdf_d[l_ac].*
      CALL azzi901_gzdf_t_mask()
      LET g_gzdf_d_mask_n[l_ac].* =  g_gzdf_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="azzi901.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi901_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM gzdf_t
       WHERE 
         gzdf001 = ps_keys_bak[1] AND gzdf002 = ps_keys_bak[2]
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
         CALL g_gzdf_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="azzi901.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi901_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO gzdf_t
                  (
                   gzdf001,
                   gzdf002
                   ,gzdf003) 
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_gzdf_d[g_detail_idx].gzdf003)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzdf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_gzdf_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="azzi901.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi901_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gzdf_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL azzi901_gzdf_t_mask_restore('restore_mask_o')
               
      UPDATE gzdf_t 
         SET (gzdf001,
              gzdf002
              ,gzdf003) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gzdf_d[g_detail_idx].gzdf003) 
         WHERE  gzdf001 = ps_keys_bak[1] AND gzdf002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzdf_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzdf_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL azzi901_gzdf_t_mask_restore('restore_mask_n')
               
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
 
{<section id="azzi901.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION azzi901_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="azzi901.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION azzi901_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="azzi901.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi901_lock_b(ps_table,ps_page)
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
   #CALL azzi901_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "gzdf_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN azzi901_bcl USING 
                                       g_gzde_m.gzde001,g_gzdf_d[g_detail_idx].gzdf002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi901_bcl:",SQLERRMESSAGE 
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
 
{<section id="azzi901.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi901_unlock_b(ps_table,ps_page)
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
      CLOSE azzi901_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="azzi901.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION azzi901_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gzde001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("gzde006",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi901.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION azzi901_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gzde001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("gzde006",FALSE)
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
 
{<section id="azzi901.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi901_set_entry_b(p_cmd)
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
 
{<section id="azzi901.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi901_set_no_entry_b(p_cmd)
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
 
{<section id="azzi901.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION azzi901_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi901.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION azzi901_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi901.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION azzi901_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi901.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION azzi901_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi901.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi901_default_search()
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
      LET ls_wc = ls_wc, " gzde001 = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "gzde_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "gzdf_t" 
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
 
{<section id="azzi901.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION azzi901_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_gzde_m.gzde001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN azzi901_cl USING g_gzde_m.gzde001
   IF STATUS THEN
      CLOSE azzi901_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi901_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE azzi901_master_referesh USING g_gzde_m.gzde001 INTO g_gzde_m.gzde001,g_gzde_m.gzde002,g_gzde_m.gzde008, 
       g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus,g_gzde_m.gzde007, 
       g_gzde_m.gzdeownid,g_gzde_m.gzdeowndp,g_gzde_m.gzdecrtid,g_gzde_m.gzdecrtdp,g_gzde_m.gzdecrtdt, 
       g_gzde_m.gzdemodid,g_gzde_m.gzdemoddt,g_gzde_m.gzdeownid_desc,g_gzde_m.gzdeowndp_desc,g_gzde_m.gzdecrtid_desc, 
       g_gzde_m.gzdecrtdp_desc,g_gzde_m.gzdemodid_desc
   
 
   #檢查是否允許此動作
   IF NOT azzi901_action_chk() THEN
      CLOSE azzi901_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzde_m.gzde001,g_gzde_m.gzdel003,g_gzde_m.gzdel004,g_gzde_m.gzde002,g_gzde_m.gzde008, 
       g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus,g_gzde_m.gzde007, 
       g_gzde_m.gzdeownid,g_gzde_m.gzdeownid_desc,g_gzde_m.gzdeowndp,g_gzde_m.gzdeowndp_desc,g_gzde_m.gzdecrtid, 
       g_gzde_m.gzdecrtid_desc,g_gzde_m.gzdecrtdp,g_gzde_m.gzdecrtdp_desc,g_gzde_m.gzdecrtdt,g_gzde_m.gzdemodid, 
       g_gzde_m.gzdemodid_desc,g_gzde_m.gzdemoddt
 
   CASE g_gzde_m.gzdestus
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
         CASE g_gzde_m.gzdestus
            
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
      g_gzde_m.gzdestus = lc_state OR cl_null(lc_state) THEN
      CLOSE azzi901_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_gzde_m.gzdemodid = g_user
   LET g_gzde_m.gzdemoddt = cl_get_current()
   LET g_gzde_m.gzdestus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE gzde_t 
      SET (gzdestus,gzdemodid,gzdemoddt) 
        = (g_gzde_m.gzdestus,g_gzde_m.gzdemodid,g_gzde_m.gzdemoddt)     
    WHERE  gzde001 = g_gzde_m.gzde001
 
    
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
      EXECUTE azzi901_master_referesh USING g_gzde_m.gzde001 INTO g_gzde_m.gzde001,g_gzde_m.gzde002, 
          g_gzde_m.gzde008,g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus, 
          g_gzde_m.gzde007,g_gzde_m.gzdeownid,g_gzde_m.gzdeowndp,g_gzde_m.gzdecrtid,g_gzde_m.gzdecrtdp, 
          g_gzde_m.gzdecrtdt,g_gzde_m.gzdemodid,g_gzde_m.gzdemoddt,g_gzde_m.gzdeownid_desc,g_gzde_m.gzdeowndp_desc, 
          g_gzde_m.gzdecrtid_desc,g_gzde_m.gzdecrtdp_desc,g_gzde_m.gzdemodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_gzde_m.gzde001,g_gzde_m.gzdel003,g_gzde_m.gzdel004,g_gzde_m.gzde002,g_gzde_m.gzde008, 
          g_gzde_m.gzde009,g_gzde_m.gzde005,g_gzde_m.gzde003,g_gzde_m.gzde006,g_gzde_m.gzdestus,g_gzde_m.gzde007, 
          g_gzde_m.gzdeownid,g_gzde_m.gzdeownid_desc,g_gzde_m.gzdeowndp,g_gzde_m.gzdeowndp_desc,g_gzde_m.gzdecrtid, 
          g_gzde_m.gzdecrtid_desc,g_gzde_m.gzdecrtdp,g_gzde_m.gzdecrtdp_desc,g_gzde_m.gzdecrtdt,g_gzde_m.gzdemodid, 
          g_gzde_m.gzdemodid_desc,g_gzde_m.gzdemoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE azzi901_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL azzi901_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi901.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION azzi901_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_gzdf_d.getLength() THEN
         LET g_detail_idx = g_gzdf_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzdf_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzdf_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi901.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzi901_b_fill2(pi_idx)
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
   
   CALL azzi901_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="azzi901.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION azzi901_fill_chk(ps_idx)
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
 
{<section id="azzi901.status_show" >}
PRIVATE FUNCTION azzi901_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi901.mask_functions" >}
&include "erp/azz/azzi901_mask.4gl"
 
{</section>}
 
{<section id="azzi901.signature" >}
   
 
{</section>}
 
{<section id="azzi901.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi901_set_pk_array()
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
   LET g_pk_array[1].values = g_gzde_m.gzde001
   LET g_pk_array[1].column = 'gzde001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi901.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="azzi901.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION azzi901_msgcentre_notify(lc_state)
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
   CALL azzi901_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gzde_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi901.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION azzi901_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="azzi901.other_function" readonly="Y" >}

####################################################
#+ 檢核 gzde001
####################################################
PRIVATE FUNCTION azzi901_check_gzde001()
   DEFINE ls_temp         STRING
   DEFINE ls_end_code     STRING
   DEFINE ls_chk_num      STRING  
   DEFINE ls_chk_prog     STRING 
   DEFINE ls_sql          STRING
   DEFINE li_cnt          LIKE type_t.num5
   DEFINE li_pos          LIKE type_t.num5
   DEFINE ls_module       STRING 
   DEFINE li_chk          LIKE type_t.num5
   DEFINE li_chk_ind      LIKE type_t.num5
   DEFINE lc_first_code   LIKE type_t.chr1
   
   LET g_errno = NULL
   LET ls_temp = g_gzde_m.gzde001
   LET ls_temp = ls_temp.trim()
   LET g_gzde_m.gzde001 = ls_temp
   LET li_pos = ls_temp.getIndexOf("_",1)

   IF li_pos = 0 THEN 
      #程式名稱_NN：最右側三碼固定為 底線 + 兩碼數字流水號
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "azz-00001"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      #不符合命名規則
      RETURN FALSE 
   END IF

   #取程式名稱第一碼到 第一個underline 之前
   LET ls_temp = ls_temp.subString(1,li_pos-1)
   #azzi900_01    #子程式 例外:sadzi888_07 (歸屬 adz)
   #azzi900_ic_01 #行業別程式
   #s_azzi900_ic  #行業元件
   #aiti001_x00   #X:報表元件-Xtragrid類
   #cl_set        #lib 元件
   #s_azzi900     #sub 元件
   #cq_azzi900    #客製qry 元件
   #wssp001_01/cwssp001_01/wssp100_ph/bwssp600_ph_01    #wss 
   #不符合命名規則 ex  wss_abcde
   #msfi100_01    #Light 可以在平台註冊
   
  IF azzi901_chk_dgenv() THEN 
  #標準s
     LET li_chk = FALSE 
     IF ls_temp = "ccl" OR ls_temp = "cs" OR ls_temp = "cq" OR 
        ls_temp.subString(1,1) MATCHES  "[cde]" THEN 
        IF NOT ls_temp.subString(1,2) = "cl" THEN 
           LET li_chk = TRUE
        END IF 
     END IF 
     IF li_chk THEN 
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = "azz-00180"
        LET g_errparam.extend = ""
        LET g_errparam.popup = TRUE
        LET g_errparam.replace[1] = g_gzde_m.gzde001
        CALL cl_err()
        #標準開發環境下，不可以建置客製程式 (%1)
        RETURN FALSE 
     END IF  

     #限制azzi901新增 lib/sub之類子程式時，名稱不可以含有error字樣
     IF ls_temp = "cl" OR ls_temp = "s" THEN 
        LET ls_chk_prog = g_gzde_m.gzde001
        IF ls_chk_prog.getIndexOf("error",li_pos) THEN 
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = "azz-00331" #新增lib/sub之類子程式時，名稱不可以含有error字樣
           LET g_errparam.popup = TRUE
           CALL cl_err()
           RETURN FALSE   
        END IF 
     END IF    
  ELSE 
  #客製c
     LET li_chk = FALSE
     IF ls_temp = "bcl" OR ls_temp = "cl" OR ls_temp = "bs" OR ls_temp = "s" OR  
        ls_temp.subString(1,1) MATCHES "[abm]" THEN 
        LET li_chk = TRUE
     END IF   
     IF li_chk THEN 
        #客製開發環境下，不可以建置標準程式 (%1)
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = "azz-00176"
        LET g_errparam.popup = TRUE
        LET g_errparam.replace[1] = g_gzde_m.gzde001
        CALL cl_err()
        RETURN FALSE 
     END IF 
  END IF    

   CASE 
      WHEN ls_temp = "cl" OR ls_temp = "s" OR ls_temp = "bcl" OR ls_temp = "bs" 
         #cl / s / bcl /  bs   開頭者不管制 (表示為 library或 SUB元件)
         LET g_gzde_m.gzde003 = "B"  # B(元件-LIB/SUB) 

          IF ls_temp = "cl" OR ls_temp = "s" THEN
             #160531-00004 #1 start          
             #Begin:20160527 by Hiko : sub的檢查要能夠支持'_ph_'與'_ph'
             #LET li_pos = s_azzp191_find_underline_pos(g_gzde_m.gzde001)
             ##行業別的元件 只能出現在行業環境
             #LET ls_chk_num = g_gzde_m.gzde001[li_pos+1,LENGTH(g_gzde_m.gzde001)]
             
             ##行業代碼
             #IF li_pos > 0 AND ls_chk_num.getLength() = 2  THEN 
             #    #檢查行業代碼是否存在
             #   IF s_azzi900_chk_industry(ls_chk_num) THEN 
             #      INITIALIZE g_errparam TO NULL
             #      LET g_errparam.code = "azz-00172" #行業代碼 (%1) 不存在，請先檢視行業別設定
             #      LET g_errparam.extend = NULL
             #      LET g_errparam.popup = TRUE
             #      LET g_errparam.replace[1] = g_gzde_m.gzde001              
             #      CALL cl_err()           
             #      RETURN FALSE
             #   END IF
             LET ls_chk_num = azzi901_chk_ind_sub(g_gzde_m.gzde001, g_gzde_m.gzde001)
             IF NOT cl_null(ls_chk_num) THEN #NULL表示沒有找到行業代號.
             #End:20160527 by Hiko
             #160531-00004 #1 end
                #檢查行業代碼不可以為sd
                IF ls_chk_num = "sd" THEN 
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = "azz-00179"
                   LET g_errparam.extend = ""               
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
                   RETURN FALSE  
                END IF
                #檢查在指定區域才可以設置指定的行業編號
                IF NOT cl_chk_in_industry(ls_chk_num) THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = "azz-00378"
                   LET g_errparam.extend = ""
                   LET g_errparam.replace[1] = ls_chk_num
                   LET g_errparam.replace[2] = FGL_GETENV("TOPIND")
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   RETURN FALSE
                ELSE
                   #160520-00015 #1 add
                   LET g_gzde_m.gzde009 = ls_chk_num                    
                END IF

             ELSE
                #一般元件 
                #行業的開發環境,不可以讓他建立標準程式
                IF FGL_GETENV("TOPIND") IS NOT NULL AND FGL_GETENV("TOPIND") <> "sd" THEN  
                   IF FGL_GETENV("DGENV") IS NOT NULL AND FGL_GETENV("DGENV") = "s" THEN
                      INITIALIZE g_errparam TO NULL
                      #LET g_errparam.code = "azz-00378"
                      LET g_errparam.code = "adz-00818"
                      LET g_errparam.extend = ""
                      LET g_errparam.replace[1] = g_gzde_m.gzde001
                      #LET g_errparam.replace[2] = FGL_GETENV("TOPIND")
                      LET g_errparam.popup = TRUE
                      CALL cl_err() 
                      RETURN FALSE
                   END IF  
                END IF
             END IF
         END IF 
         #歸屬模組 gzde002 取前三碼
         LET ls_temp = g_gzde_m.gzde001[1,3]

      WHEN ls_temp = "ccl" OR ls_temp = "cs" OR ls_temp = "cq"
         #ccl / cs / cq 者，檢查DGENV 是否等於c，若不等於c，顯示錯誤訊息『標準開發環境下，不可以建置客製程式 (%1)』      
         #當前三碼為 cwss 檢查DGENV 是否等於c，若不等於c，顯示錯誤訊息『標準開發環境下，不可以建置客製程式 (%1)』
 
         #歸屬模組 gzde002 取前三碼
         LET ls_temp = g_gzde_m.gzde001[1,3]  
         #行業別的元件 只能出現在行業環境
         LET ls_chk_num = g_gzde_m.gzde001[li_pos+1,LENGTH(g_gzde_m.gzde001)]
         #取underline位置 
         LET li_pos = s_azzp191_find_underline_pos(ls_chk_num)
         #標準環境不可有 行業別元件
         #有 _xx #表示有符合 s_xxxx_ic
         IF li_pos > 0 THEN
            #行業的開發環境,不可以讓他建立標準程式
            IF FGL_GETENV("TOPIND") IS NOT NULL AND FGL_GETENV("TOPIND") <> "sd" THEN  
               IF FGL_GETENV("DGENV") IS NOT NULL AND FGL_GETENV("DGENV") = "s" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00378"
                  LET g_errparam.extend = ""
                  LET g_errparam.replace[1] = "sd"
                  LET g_errparam.replace[2] = FGL_GETENV("TOPIND")
                  LET g_errparam.popup = TRUE
                  CALL cl_err() 
                  RETURN FALSE
               END IF  
            END IF
         END IF
      OTHERWISE  
        ##(表示為子程式)  #要符合 "mmmkxxx_NN" 底線流水號 
        #去除最後一個 underline 後，取出主要程式名稱部分， 
        #A.檢查必須在gzza001存在，若不存在，顯示錯誤訊息『子程式(%1)的依附主程式%2目前並未註冊，請先進行主程式開發』

        #例如：axmt410_ic_01，去除最後一個 underline 則為 axmt410_ic ，若檢查不存在，錯誤訊息呈現如下
        #子程式(axmt410_ic_01) 的依附主程式axmt410_ic 目前並未註冊，請先進行主程式開發
        
        #取最後一個underline位置
        LET li_pos = s_azzp191_find_underline_pos(g_gzde_m.gzde001)
        #如果不存在 underline的要報錯
        IF li_pos = 0 THEN 
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = "azz-00066"   #程式名稱_NN：最右側三碼固定為 底線 + 兩碼數字流水號
           LET g_errparam.popup = TRUE
           CALL cl_err()
           RETURN FALSE 
        END IF

        #取程式名稱最後一個 underline 到最後
        LET ls_end_code = g_gzde_m.gzde001[li_pos+1,LENGTH(g_gzde_m.gzde001)]
        #ls_temp則是最後一個underline前面的字串
        LET ls_temp = g_gzde_m.gzde001[1,li_pos - 1]

        #ls_temp要符合 "mmmkxxx_NN" 底線流水號 (表示為行業別子程式)
        IF ls_temp.getIndexOf("_",1) THEN
           #161111-00060 start
           #取第5碼
           LET ls_chk_num = ls_temp.subString(5,5)
           #客製模組 開放第5碼
           IF ls_chk_num MATCHES "[01-9]" OR ls_chk_num MATCHES "[a-z]" THEN 
              #不是客製模組 第5碼 是要流水號不是英文字 
              IF NOT lc_first_code MATCHES "[cden]" THEN 
                 IF ls_chk_num MATCHES "[a-z]" THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = "azz-00001"
                    LET g_errparam.extend = ""
                    LET g_errparam.popup = FALSE
                    CALL cl_err()
                    RETURN FALSE 
                 END IF 
              END IF 
           ELSE 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "azz-00419"
            LET g_errparam.extend = ""
            LET g_errparam.popup = FALSE
            CALL cl_err()
            RETURN FALSE 
           END IF
           #161111-00060 end 
           
           #檢查程式流水號字段
           #LET ls_chk_num = ls_temp.subString(ls_temp.getIndexOf("_",1)-3,ls_temp.getIndexOf("_",1)-1) #161111-00060 mark
           LET ls_chk_num = ls_temp.subString(ls_temp.getIndexOf("_",1)-2,ls_temp.getIndexOf("_",1)-1)  #161111-00060 add
           #IF NOT ls_chk_num MATCHES '[01-9][01-9][01-9]' THEN                                         #161111-00060 mark
           IF NOT ls_chk_num MATCHES '[01-9][01-9]' THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = "azz-00001"
              LET g_errparam.popup = FALSE
              CALL cl_err()
              RETURN FALSE   
           END IF

           #檢查行業別
           LET ls_chk_num = ls_temp.subString(ls_temp.getIndexOf("_",1)+1,ls_temp.getLength())
           LET li_chk_ind = FALSE 
           IF NOT s_azzi900_check_industry(ls_chk_num) THEN
              #160531-00004 #1 start
              #Begin:20160527 by Hiko
              #為了讓延伸標準子程式aiti100_01的註冊資料aiti100_01_ph也能通過, 所以就抓取最後一個under line到最後的字串, 判斷是否為正常的行業代號.
              LET ls_chk_num = ls_end_code
              #IF NOT s_azzi900_check_industry(ls_chk_num) THEN
              IF s_azzi900_check_industry(ls_chk_num) THEN
                 #行業子程式要依附在標準子程式 ，先確認是否行業子程式
                 LET li_chk_ind = TRUE  
              ELSE 
              #End:20160527 by Hiko
              #160531-00004 #1 end
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = "azz-00172"
                 LET g_errparam.extend = NULL
                 LET g_errparam.popup = TRUE
                 LET g_errparam.replace[1] = ls_chk_num              
                 CALL cl_err()
                 RETURN FALSE           
              END IF
           END IF
           
           #16/02/15 start 加入行業主機環境判規則
           #檢查行業代碼不可以為sd
           IF ls_chk_num = "sd" THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = "azz-00179"
              LET g_errparam.extend = ""               
              LET g_errparam.popup = FALSE
              CALL cl_err()
              RETURN FALSE  
           END IF

           #檢查在指定區域才可以設置指定的行業編號
           IF NOT cl_chk_in_industry(ls_chk_num) THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = "azz-00378"
              LET g_errparam.extend = ""
              LET g_errparam.replace[1] = ls_chk_num
              LET g_errparam.replace[2] = FGL_GETENV("TOPIND")
              LET g_errparam.popup = TRUE
              CALL cl_err()
              RETURN FALSE
           END IF
           #16/02/15 end 
           LET g_gzde_m.gzde009 = ls_chk_num 
        ELSE
           #ls_temp要符合 "mmmkxxx" 底線流水號 (表示為一般子程式)
           #161111-00060 start
           #取第5碼
           LET ls_chk_num = ls_temp.subString(5,5)
           #客製模組 開放第5碼
           IF ls_chk_num MATCHES "[01-9]" OR ls_chk_num MATCHES "[a-z]" THEN 
              #不是客製模組 第5碼 是要流水號不是英文字 
              IF NOT lc_first_code MATCHES "[cden]" THEN 
                 IF ls_chk_num MATCHES "[a-z]" THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = "azz-00001"
                    LET g_errparam.extend = ""
                    LET g_errparam.popup = FALSE
                    CALL cl_err()
                    RETURN FALSE 
                 END IF 
              END IF 
           ELSE 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "azz-00419"
            LET g_errparam.extend = ""
            LET g_errparam.popup = FALSE
            CALL cl_err()
            RETURN FALSE 
           END IF
           #161111-00060 end 
           
           #檢查主程式流水號字段
           #LET ls_chk_num = ls_temp.subString(ls_temp.getLength()-2,ls_temp.getLength()) #161111-00060 mark
           LET ls_chk_num = ls_temp.subString(ls_temp.getLength()-1,ls_temp.getLength())  #161111-00060 add
           #IF NOT ls_chk_num MATCHES '[01-9][01-9][01-9]' THEN                           #161111-00060 mark 
           IF NOT ls_chk_num MATCHES '[01-9][01-9]' THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = "azz-00001"
              LET g_errparam.popup = FALSE
              CALL cl_err()
              RETURN FALSE   
           END IF

           #16/02/16 start 加入行業主機環境判規則
           #行業的開發環境,不可以讓他建立標準程式
           IF FGL_GETENV("TOPIND") IS NOT NULL AND FGL_GETENV("TOPIND") <> "sd" THEN  
              IF FGL_GETENV("DGENV") IS NOT NULL AND FGL_GETENV("DGENV") = "s" THEN
                INITIALIZE g_errparam TO NULL
                
                #LET g_errparam.code = "azz-00378"
                LET g_errparam.code = "adz-00818"
                LET g_errparam.extend = ""
                LET g_errparam.replace[1] = g_gzde_m.gzde001
                #LET g_errparam.replace[2] = FGL_GETENV("TOPIND")
                LET g_errparam.popup = TRUE
                CALL cl_err() 
                RETURN FALSE
              END IF  
           END IF
           
           #T100 light 平台
           IF FGL_GETENV("ERPID") IS NOT NULL AND FGL_GETENV("ERPID") = "T100EXT" THEN 
              IF FGL_GETENV("DGENV") IS NOT NULL AND FGL_GETENV("DGENV") = "s" THEN
                 #不可以註冊a開頭標準程式
                 IF lc_first_code MATCHES "[a]" THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = "azz-00381"
                    LET g_errparam.extend = ""
                    LET g_errparam.popup = TRUE 
                    CALL cl_err()
                    RETURN FALSE
                 END IF 
              END IF 
            END IF
           #16/02/16 end 
        END IF

        #15/06/02 sadz開頭 視為adz的子程式
        IF ls_temp.subString(1,4) = "sadz" THEN 
           LET ls_temp = g_gzde_m.gzde001[1,4]
        ELSE  
           #檢查程式類別
           IF cl_chk_progtype(UPSHIFT(ls_temp.subString(4,4))) THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = "azz-00001"
              LET g_errparam.popup = FALSE
              CALL cl_err() 
              RETURN FALSE 
           END IF
         
        
          #要符合 "NN" 底線流水號  
          #若為2碼則必須符合兩碼都是數字，若不符合，顯示訊息為『子程式 (%1) 命名未符合最後兩碼需使用數字流水號的規則』
          #若為3碼則必須符合第一碼是x或g，後兩碼是數字，若不符合，顯示訊息為『報表元件(%1)命名未符合 _xNN 或 _gNN 的命名規則』
          #16/05/30 若為2碼，判斷是否是行業代碼 
          CASE 
             #尾碼2碼
             WHEN ls_end_code.getLength() = 2
               #160531-00004 #1 start
                IF li_chk_ind THEN 
                   #是行業代碼略過 
                ELSE
                   IF NOT ls_end_code MATCHES '[01-9][01-9]' THEN 
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = "azz-00183" #子程式(%1)命名未符合最後兩碼需使用數字流水號的規則
                      LET g_errparam.popup = TRUE
                      LET g_errparam.replace[1] = g_gzde_m.gzde001
                      CALL cl_err()
                      RETURN FALSE   
                    END IF                       
                END IF 
                #160531-00004 #1 end
                #160531-00004 #1 mark
#                --IF NOT ls_end_code MATCHES '[01-9][01-9]' THEN 
#                   --INITIALIZE g_errparam TO NULL
#                   --LET g_errparam.code = "azz-00183" #子程式(%1)命名未符合最後兩碼需使用數字流水號的規則
#                   --LET g_errparam.popup = TRUE
#                   --LET g_errparam.replace[1] = g_gzde_m.gzde001
#                   --CALL cl_err()
#                   --RETURN FALSE   
#                --END IF
                #160531-00004 #1 mark
        
            #尾碼3碼     
            WHEN ls_end_code.getLength() = 3
               IF ls_end_code.subString(1,1)  MATCHES '[xg]' THEN
                  IF NOT ls_end_code MATCHES '[xg][01-9][01-9]' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "azz-00184"   #報表元件(%1)命名未符合 _xNN 或 _gNN 的命名規則
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = g_gzde_m.gzde001
                     CALL cl_err()
                     RETURN FALSE
                  END IF
               ELSE 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00184"    #報表元件(%1)命名未符合 _xNN 或 _gNN 的命名規則
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_gzde_m.gzde001
                  CALL cl_err()
                  RETURN FALSE
               END IF 

            OTHERWISE 
               #其他
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "azz-00001"   #不符合命名規則
               LET g_errparam.popup = FALSE
               CALL cl_err()
               RETURN FALSE
          END CASE 

          LET ls_module =  ls_temp.subString(1,3)
          #檢查歸屬模組是否存在 gzzj_t(模組編號明細表)
          IF NOT s_azzi900_chk_gzzj(UPSHIFT(ls_module)) THEN
             LET li_chk = FALSE 
             IF lc_first_code = 'b' THEN 
                LET ls_module =  'a',ls_temp.subString(2,3)
                LET li_chk = s_azzi900_chk_gzzj(UPSHIFT(ls_module))  
             END IF 
             IF NOT li_chk THEN 
               #則顯示錯誤訊息：『程式編號 (%1) 無法確認歸屬模組，請重新確認』
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "azz-00171"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = g_gzde_m.gzde001
               CALL cl_err()
               RETURN FALSE    
             END IF 
         END IF
          
        #判斷 整合服務管理模組  WSS
        LET ls_temp = g_gzde_m.gzde001[1,li_pos - 1]
        IF ls_temp.subString(1,3) = "wss" OR ls_temp.subString(1,4) = "cwss" THEN 
           #確認gzza001(主程式) 是否存在 如果存在取出module 組出實體檔案路徑判斷實體檔案是否存在
           LET ls_module = s_azzi900_chk_azzi700_prog(ls_temp)  
        ELSE 
           #確認gzza001(主程式) 是否存在 如果存在取出module 組出實體檔案路徑判斷實體檔案是否存在
           LET ls_module = s_azzi900_chk_prog(ls_temp)
           #預檢:如果是c/d開頭的，則當ls_module不存在時，先切換ls_temp為a或b開頭
           IF cl_null(ls_module) AND (ls_temp.subString(1,1) MATCHES '[cd]' ) THEN
              #不管c/d都先換成a開頭試驗看看
              LET ls_temp = "a",ls_temp.subString(2,ls_temp.getLength())
              LET ls_module = s_azzi900_chk_prog(ls_temp)
              #如果還是沒有再換成b看看 (沒有就報錯了)
              IF cl_null(ls_module) THEN
                 LET ls_temp = "b",ls_temp.subString(2,ls_temp.getLength())
                 LET ls_module = s_azzi900_chk_prog(ls_temp)
              END IF
           END IF

           #16/05/30
           #行業子程式要先檢查標準子程式是否存在gzde001(子程式)，如果存在取出module 組出實體檔案路徑判斷實體檔案是否存在
           IF li_chk_ind THEN 
              LET ls_temp = g_gzde_m.gzde001[1,li_pos - 1]
              LET ls_module = s_azzi900_chk_sub_prog(ls_temp)
                  IF cl_null(ls_module) AND (ls_temp.subString(1,1) MATCHES '[cd]' ) THEN
                               #不管c/d都先換成a開頭試驗看看
                  LET ls_temp = "a",ls_temp.subString(2,ls_temp.getLength())
                  LET ls_module = s_azzi900_chk_prog(ls_temp)
                  #如果還是沒有再換成b看看 (沒有就報錯了)
                  IF cl_null(ls_module) THEN
                     LET ls_temp = "b",ls_temp.subString(2,ls_temp.getLength())
                     LET ls_module = s_azzi900_chk_prog(ls_temp)
                  END IF 
              END IF

           END IF 
        END IF
        #子程式註冊前要先確認主程式存在
        IF cl_null(ls_module) THEN 
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = "azz-00181"
           LET g_errparam.popup = TRUE
           LET g_errparam.replace[1] = g_gzde_m.gzde001
           LET ls_temp = g_gzde_m.gzde001[1,li_pos - 1]
           LET g_errparam.replace[2] = ls_temp
           CALL cl_err()
           #子程式(%1)的依附主程式(%2)目前並未註冊，請先進行主程式開發
           RETURN FALSE 
        END IF 
          
        #B.檢查必須實體檔案存在，若不存在，顯示錯誤訊息『子程式(%1)的依附主程式%2目前實體檔案不存在，請先進行主程式開發』 
        LET ls_temp = os.Path.join(os.Path.join(FGL_GETENV(UPSHIFT(ls_module)),"4gl"),ls_temp||".4gl")

        IF NOT os.Path.exists(ls_temp) THEN 
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = "azz-00182"
           LET g_errparam.popup = TRUE
           LET g_errparam.replace[1] = g_gzde_m.gzde001
           LET ls_temp = g_gzde_m.gzde001[1,li_pos - 1]
           LET g_errparam.replace[2] = ls_temp
           CALL cl_err()
           RETURN FALSE 
        END IF
        #歸屬模組 gzde002 取前三碼
        LET ls_temp = g_gzde_m.gzde001[1,3]
        END IF #END IF "sadz"
   END CASE #END CASE 外層

   #符合下列情況優先調整：cl_ / bcl 改為 LIB  且 ccl 改為 CLIB
   #s_ / bs_ 改為 SUB 且 cs_ 改為 CSUB
   #wss / bws 改為 WSS 且 cws 改為 CWSS
   #若為A/C/E 開頭，取前 3 碼存檔
   #若為 B/D 開頭，則查詢前三碼是否存在 gzzj001，若不存在，B改為 A 開頭，D改為C開頭存放

   #規格類別 gzde003
   #A.取前三碼等於 cl_ / bcl /ccl / s_ / bs_ / cs_ / cq_ 設定為 B
   #B.取前三碼等於 wss 的設定為 W
   #C.取倒數第 4 – 3 碼，為 _x 設定為 X
   #D.取倒數第 4 – 3 碼，為 _g 設定為 G
   #E.剩餘的，指定為 S 

   CASE 
      WHEN ls_temp = "cl_" OR ls_temp = "bcl" OR ls_temp = "ccl" 
           LET g_gzde_m.gzde003 = "B"
           IF ls_temp = "ccl" THEN 
              LET g_gzde_m.gzde002 = "CLIB"
           ELSE 
              LET g_gzde_m.gzde002 = "LIB"   
           END IF 
      WHEN ls_temp.subString(1,2) = "s_" OR ls_temp = "bs_"  OR ls_temp = "cs_"
           LET g_gzde_m.gzde003 = "B"
           IF ls_temp = "cs_" THEN 
              LET g_gzde_m.gzde002 = "CSUB"
           ELSE 
              LET g_gzde_m.gzde002 = "SUB"   
           END IF
      WHEN ls_temp = "cq_"
           LET g_gzde_m.gzde003 = "B"
           IF ls_temp = "cq_" THEN 
              LET g_gzde_m.gzde002 = "CQRY"
           ELSE 
              LET g_gzde_m.gzde002 = "QRY"   
           END IF
      WHEN ls_temp = "wss" OR ls_temp = "bws" 
           LET g_gzde_m.gzde005 = "W"
           LET g_gzde_m.gzde003 = "W"
           IF ls_temp = "wss" THEN 
              LET g_gzde_m.gzde002 = "WSS"
              LET g_gzde_m.gzde006 = "a"
           ELSE 
              LET g_gzde_m.gzde002 = "CWSS"   
           END IF 
      WHEN ls_temp = "sadz" #sadz 屬於 ADZ模組
         LET g_gzde_m.gzde003 = "S"  #子程式
         LET g_gzde_m.gzde005 = UPSHIFT(g_gzde_m.gzde001[5,5])  #程式類別
         LET g_gzde_m.gzde002 = UPSHIFT(g_gzde_m.gzde001[2,4])  #歸屬模組
         LET g_gzde_m.gzde006 = "a" 
           
      OTHERWISE 
         LET g_gzde_m.gzde003 = "S"  #子程式
         LET g_gzde_m.gzde005 = UPSHIFT(g_gzde_m.gzde001[4,4])  #程式類別
         CASE 
            WHEN ls_temp.subString(1,1) MATCHES '[bd]'
            
               LET g_gzde_m.gzde002 = UPSHIFT(ls_temp)
               #檢查gzzj 模組編號是否存在
               IF NOT s_azzi900_chk_gzzj(UPSHIFT(ls_temp)) THEN 
                  #不存在進行轉換 
                  IF ls_temp.subString(1,1) MATCHES '[b]' THEN 
                     LET g_gzde_m.gzde002 = "A",UPSHIFT(ls_temp.subString(2,3))              
                  ELSE
                     LET g_gzde_m.gzde002 = "C",UPSHIFT(ls_temp.subString(2,3))
                  END IF
            END IF
            
            OTHERWISE 
               LET g_gzde_m.gzde002 = UPSHIFT(ls_temp)     
         END CASE         
   END CASE 

   #排除
   IF ls_temp = "sadz" THEN 
   ELSE 
      IF ls_end_code.subString(1,1) MATCHES '[xg]' THEN   
         LET g_gzde_m.gzde006 = "a" 
         IF ls_end_code.subString(1,1) MATCHES '[x]' THEN 
            LET g_gzde_m.gzde003 = "X"
            LET g_gzde_m.gzde005 = "X" 
            CALL cl_set_combo_scc('gzde006','253')     #160921-00012 #2 
            LET g_gzde_m.gzde006 = "2" #xg預設為2       #160921-00012 #2  
         ELSE
            LET g_gzde_m.gzde003 = "G"
            LET g_gzde_m.gzde005 = "G"
            CALL cl_set_combo_scc('gzde006','254')     #160921-00012 #2
            LET g_gzde_m.gzde006 = "1" #gr預設為1       #160921-00012 #2
         END IF
      ELSE 
         CALL cl_set_combo_scc('gzde006','79')   
      END IF 
   END IF  

   #160921-00012 #2 start
   #元件 最後一碼不可以有特殊字元 !,%,#,$,@,=,?,/,(,),.,
   #&,',\",<,>,!,%,#,$,@,=,?,/,(,),[,],{,},.,+,*,_
   IF g_gzde_m.gzde003 = "B" THEN 
      LET lc_first_code = g_gzde_m.gzde001[LENGTH(g_gzde_m.gzde001),LENGTH(g_gzde_m.gzde001)]
      DISPLAY "lc_first_code:",lc_first_code
      #A-Z0-9_\u4e00-\u9fa5 
      CASE 
         WHEN lc_first_code MATCHES '[a-z]'
           DISPLAY "有特殊字元 [a-z]"
         WHEN lc_first_code MATCHES '[01-9]'
            DISPLAY "有特殊字元 [01-9]"
         WHEN lc_first_code MATCHES '[_]'
           DISPLAY "有特殊字元 [_]"
         OTHERWISE    
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = "azz-00398"
           LET g_errparam.popup = TRUE
           LET g_errparam.replace[1] = g_gzde_m.gzde001
           CALL cl_err()
           RETURN FALSE   
      END CASE  
   END IF 
   ##160921-00012 #2 end

   #確認dgenv 標準或客製
   LET g_gzde_m.gzde008 = FGL_GETENV("DGENV")
   RETURN TRUE 
END FUNCTION

####################################################
#+ 檢核gzdf002  規格編號 + _sXX  (2碼流水號)
####################################################
PRIVATE FUNCTION azzi901_check_gzdf002()
   DEFINE ls_temp         STRING
   DEFINE ls_chk_str      STRING 
   DEFINE ls_chk_spec_no  STRING        #規格編號
   LET ls_temp = g_gzdf_d[l_ac].gzdf002
   LET ls_temp = ls_temp.trim()

   LET ls_chk_str = ls_temp.subString(ls_temp.getLength()-3,ls_temp.getLength())
   LET ls_chk_spec_no = ls_temp.subString(1,ls_temp.getLength()-4)
   LET g_errno = NULL
   
   # _sXX  (2碼流水號)
   IF NOT ls_chk_str MATCHES '[_][a-z][01-9][01-9]' THEN 
      LET g_errno = "azz-00068" 
      RETURN  
   END IF
 
   #規格編號   
   LET ls_chk_spec_no = ls_chk_spec_no.trim()
   IF ls_chk_spec_no != g_gzde_m.gzde001 THEN 
      LET g_errno = "azz-00068" 
      RETURN  
   END IF 
   
END FUNCTION

################################################################################
# Descriptions...: 檢核客製模組
# Memo...........:
# Usage..........: CALL azzi901_chk_gzde008()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi901_chk_gzde008()


   IF FGL_GETENV("DGENV") = 's' THEN 
      LET g_gzde_m.gzde008 = 's' 
   END IF 
   
   IF FGL_GETENV("DGENV") = 'c' THEN
      LET g_gzde_m.gzde008 = 'c' 
   END IF 

END FUNCTION

################################################################################
# Descriptions...: 確認標準/客製
# Memo...........:
# Usage..........: CALL azzi901_chk_dgenv()
#                  RETURNING TRUE/FALSE
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi901_chk_dgenv()
   DEFINE li_chk LIKE type_t.num5

   IF FGL_GETENV("DGENV") = 's' THEN
      LET li_chk = TRUE 
   ELSE 
      LET li_chk = FALSE 
   END IF 
   RETURN li_chk
END FUNCTION

################################################################################
# Descriptions...: 標準環境 標準子畫面，在客戶家不可以修改
# Memo...........:
# Usage..........: CALL azzi901_check_gzdf002_2(ps_gzdf002_old)
#                  RETURNING 回传参数
# Input parameter: ps_gzdf002_old
# Return code....: 
# Date & Author..: 2014/12/23 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi901_check_gzdf002_2(ps_gzdf002_old)
   DEFINE ps_gzdf002_old  STRING
   DEFINE ls_chk_str      STRING

   #取程式名稱第一碼到 第一個underline 之前
   LET ls_chk_str = ps_gzdf002_old.subString(1,ps_gzdf002_old.getIndexOf("_",1))

   CASE 
      #標準子畫面 開頭是 a、b、wss、cl、bcl(行業別 cl)、bs(行業別 s) 
      WHEN ls_chk_str = "cl_" OR ls_chk_str = "s_" OR ls_chk_str = "bcl_" OR ls_chk_str = "bs_" OR
           ls_chk_str.subString(1,1) = "a" OR ls_chk_str.subString(1,1) = "b" 

           IF FGL_GETENV("DGENV") = "c" THEN 
              #標準環境 標準子畫面，在客戶家不可以修改
                 LET g_errno = "azz-00293" 
              RETURN
          END IF
   END CASE 
END FUNCTION

################################################################################
# Descriptions...: 額外insert gzzb
# Memo...........:
# Usage..........: CALL azzi901_ins_gzzb(pi_num)
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/01/19 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi901_ins_gzzb(pi_num)
   DEFINE pi_num        LIKE type_t.num5
   DEFINE li_pos        LIKE type_t.num5
   DEFINE pc_gzzb001    LIKE gzzb_t.gzzb001  #程式編號
   DEFINE pc_gzzb002    LIKE gzzb_t.gzzb002  #行業編號
   DEFINE pc_gzzb003    LIKE gzzb_t.gzzb003  #程式編號(標準)
   DEFINE li_cnt        LIKE type_t.num5
   
   #標準行業
   LET pc_gzzb002 = g_gzde_m.gzde009
   CASE 
      #子程式 X:報表元件 G:報表元件 
      #開頭不是b的(a/c/d/e)
      WHEN pi_num = 1 #a/c/d/e and p_cmd = 'a' (新增時)
          #160520-00015 #1 add
          #Begin:20160520 by Hiko:因為只有主程式才有機會引用, 所以azzi901的gzzb001就預設等於gzzb003即可.
          #IF g_gzde_m.gzde009 = "sd" THEN
          #   LET pc_gzzb001 = g_gzde_m.gzde001
          #   LET pc_gzzb003 = g_gzde_m.gzde001
          #ELSE
          #   #行業別
          #   LET li_pos = s_azzp191_find_underline_pos(g_gzde_m.gzde001)
          #   LET pc_gzzb001 = g_gzde_m.gzde001
          #   LET pc_gzzb003 = g_gzde_m.gzde001[1,li_pos-1]
          #END IF
           LET pc_gzzb001 = g_gzde_m.gzde001
           LET pc_gzzb003 = g_gzde_m.gzde001
           #End:20160520 by Hiko
          #160520-00015 #1 end 
           INSERT INTO gzzb_t (gzzb001,gzzb002,gzzb003)
            VALUES (pc_gzzb001,pc_gzzb002,pc_gzzb003)   
                          
      #開頭是b的   
      #規格類別 X/G && 行業別 <> sd 
#      WHEN pi_num = 2 #規格類別 X/G && 行業別 <> sd 
#      
#           LET pc_gzzb001 = g_gzde_m.indus_mod_notify
#           LET pc_gzzb003 = g_gzde_m.gzde001
#           SELECT COUNT(*) INTO li_cnt FROM gzzb_t
#            WHERE gzzb002 = pc_gzzb002
#             AND  gzzb003 = pc_gzzb003 
#
#          # 規格編號+標準行業 = count (表示報表參考)  
#          #li_cnt > 1 delete gzzb_t 
#          #           行業對應的標準報表元件 
#          #           g_gzde_m.indus_mod_notify is not null insert gzzb_t       
#          #li_cnt = 1 delete gzzb_t
#          #           行業對應的標準報表元件
#          #           g_gzde_m.indus_mod_notify is not null update gzzb_t 
#          #           g_gzde_m.indus_mod_notify is null delete gzzb_t 
#          #li_cnt < 1 insert gzzb_t 
#          #           行業對應的標準報表元件
#          #           g_gzde_m.indus_mod_notify is not null insert gzzb_t           
#           CASE 
#              WHEN li_cnt > 1 
#                   DELETE FROM gzzb_t
#                    WHERE gzzb002 = pc_gzzb002 
#                     AND gzzb003 = pc_gzzb003 
#                   IF NOT cl_null(g_gzde_m.indus_mod_notify) THEN 
#                      INSERT INTO gzzb_t (gzzb001,gzzb002,gzzb003)
#                       VALUES (pc_gzzb001,pc_gzzb002,pc_gzzb003) 
#                   END IF 
#                   
#              WHEN li_cnt = 1
#                   IF cl_null(g_gzde_m.indus_mod_notify) THEN 
#                      DELETE FROM gzzb_t
#                       WHERE gzzb002 = pc_gzzb002 
#                        AND gzzb003 = pc_gzzb003 
#                   ELSE
#                      UPDATE gzzb_t SET gzzb001 = pc_gzzb001,gzzb002 = pc_gzzb002,gzzb003 = pc_gzzb003
#                       WHERE gzzb002 = pc_gzzb002
#                        AND gzzb003 = pc_gzzb003 
#                   END IF 
#                    
#              WHEN li_cnt < 1
#                   IF NOT cl_null(g_gzde_m.indus_mod_notify) THEN
#                      INSERT INTO gzzb_t (gzzb001,gzzb002,gzzb003)
#                       VALUES (pc_gzzb001,pc_gzzb002,pc_gzzb003)  
#                   END IF                  
#           END CASE  
      END CASE 
   
      IF SQLCA.sqlcode THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzzb_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE    
         CALL cl_err()
      END IF
END FUNCTION

################################################################################
# Descriptions...: 組gzzb where 條件
# Memo...........:
# Usage..........: CALL azzi901_get_gzzb_sql_where(ps_result)
#                  RETURNING 回传参数
# Input parameter: ps_result 
# Return code....: 
# Date & Author..: 2015/02/04 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi901_get_gzzb_sql_where(ps_result)
   DEFINE ps_result  STRING 
   DEFINE l_token    base.StringTokenizer
   DEFINE ls_text    STRING
   DEFINE ls_sql     STRING
   DEFINE lc_gzzb003 LIKE gzzb_t.gzzb003 
   DEFINE ls_where   STRING

   #ex:aapr110_g01|aapq930_g01|aapr130_x01|aapr300_g01
   LET l_token = base.StringTokenizer.create(ps_result,"|")
   LET ls_text = " gzzb001 IN ("
   WHILE l_token.hasMoreTokens()
      LET ls_text = ls_text,"'",l_token.nextToken(),"'",","
   END WHILE
   LET ls_text = ls_text.subString(1,ls_text.getLength()-1),")"
  
   LET ls_sql = "SELECT gzzb003 FROM gzzb_t " ,
                " WHERE  ",ls_text ,
                "  AND gzzb002 <> 'sd' "
   DECLARE azzi901_get_gzzb_cs CURSOR  FROM ls_sql 

   FOREACH azzi901_get_gzzb_cs INTO lc_gzzb003
      LET ls_where = ls_where ,"'",lc_gzzb003,"',"
   END FOREACH 
   IF cl_null(ls_where) THEN 
   ELSE
      LET ls_where = ls_where.subString(1,ls_where.getLength()-1)
      LET ls_where = " gzde001 IN (",ls_where,")"   
   END IF 
   RETURN ls_where
END FUNCTION

################################################################################
# Descriptions...: 檢核應用元件的命名是否符合行業編號(sxxx_ph_xxx或sxxx_xxx_ph都可以)
# Memo...........:
# Usage..........: CALL azzi901_chk_ind_sub(p_prog,p_temp)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 2016/05/31 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi901_chk_ind_sub(p_prog,p_temp)
   DEFINE p_prog STRING,
          p_temp STRING
   DEFINE li_pos SMALLINT,
          ls_chk_num STRING

   LET li_pos = s_azzp191_find_underline_pos(p_temp) #從字串後面開始取得底線(_)
   IF li_pos > 0 THEN
      #行業別的元件 只能出現在行業環境
      LET ls_chk_num = p_temp.subString(li_pos+1, p_temp.getLength()) #取得底線(_)到字串最後

      #行業代碼
      IF ls_chk_num.getLength() = 2 THEN 
         #檢查行業代碼是否存在
         IF NOT s_azzi900_check_industry(ls_chk_num) THEN #表示不是行業代號:此function的回傳比較奇怪, 已經反映.
            LET p_temp = p_temp.subString(1,li_pos-1)
            LET ls_chk_num = azzi901_chk_ind_sub(p_prog, p_temp)          
         END IF 
      ELSE
         #若不是兩碼, 還是繼續檢查.
         LET p_temp = p_temp.subString(1,li_pos-1)
         LET ls_chk_num = azzi901_chk_ind_sub(p_prog, p_temp)          
      END IF 
   ELSE
      #找不到行業代碼略過
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code = "azz-00172" #行業代碼 (%1) 不存在，請先檢視行業別設定
      #LET g_errparam.extend = NULL
      #LET g_errparam.popup = TRUE
      #LET g_errparam.replace[1] = p_prog              
      #CALL cl_err()           
   END IF

   RETURN ls_chk_num
END FUNCTION

################################################################################
# Descriptions...: gzde006 設定 combobox 
# Memo...........:
# Usage..........: CALL azzi901_set_combo_gzde006(ps_field_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 2017/01/16 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi901_set_combo_gzde006(ps_field_name)
   DEFINE ps_values      STRING
   DEFINE ps_items       STRING
   DEFINE ps_field_name  STRING
   DEFINE pc_gzca001     LIKE gzca_t.gzca001      #系統分類碼
   DEFINE pc_gzcb002     LIKE gzcb_t.gzcb002      #系統分類值
   DEFINE pc_gzcbl004    LIKE gzcbl_t.gzcbl004    #說明
   DEFINE pa_array DYNAMIC ARRAY OF RECORD
             value       STRING,
             label_tag   STRING,
             label       STRING
                   END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE li_cnt2 LIKE type_t.num5

   DECLARE p_scc_item_cs CURSOR FOR
    SELECT gzcb002, gzcbl004
      FROM gzcb_t LEFT JOIN gzcbl_t ON gzcb002 = gzcbl002
                                    AND gzcb001 = gzcbl001
                                    AND (gzcb001 = '79' OR gzcb001 = '253' OR gzcb001 = '254' )
                                    AND gzcbl003 = g_dlang
      WHERE gzcb001 IN (SELECT gzcb001
                          FROM gzcb_t
                          WHERE (gzcb001 =  '79' OR gzcb001 = '253' OR gzcb001 = '254' ))
      ORDER BY gzcb001
    IF SQLCA.SQLCODE THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code =  "lib-00068"
       LET g_errparam.extend = "gzcb_t"
       LET g_errparam.popup = TRUE
       CALL cl_err()
    ELSE
       #將選項填入陣列
       LET li_cnt = 1
         FOREACH p_scc_item_cs INTO pc_gzcb002, pc_gzcbl004
           #比對 重複就不放進陣列
           FOR li_cnt2 = 1 TO pa_array.getLength()
               IF pc_gzcb002 = pa_array[li_cnt2].value AND pc_gzcbl004 = pa_array[li_cnt2].label THEN 
                  CONTINUE FOREACH 
               END IF 
           END FOR 
           LET pa_array[li_cnt].value = pc_gzcb002 CLIPPED
           LET pa_array[li_cnt].label = pc_gzcbl004 CLIPPED
           LET li_cnt = li_cnt + 1
         END FOREACH
         CALL cl_set_combo_detail(ps_field_name, pa_array)
    END IF
    CLOSE p_scc_item_cs
    FREE p_scc_item_cs
END FUNCTION

 
{</section>}
 
