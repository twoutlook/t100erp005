#該程式未解開Section, 採用最新樣板產出!
{<section id="aini002.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2016-12-22 14:47:22), PR版次:0014(2016-12-31 16:54:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000372
#+ Filename...: aini002
#+ Description: 庫位/儲位資料維護作業
#+ Creator....: 01588(2013-07-30 14:39:48)
#+ Modifier...: 01258 -SD/PR- 01258
 
{</section>}
 
{<section id="aini002.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151223-00002#1    2016/1/125 By lixiang #庫否可用否="Y"時，儲位才可為"Y"跟"N",MRP可用否同樣；防止出現庫存不可用，但儲位庫存還是可用庫存
#160318-00005#21   2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160812-00017#1 16/08/15 By 06137    在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160905-00007#4   2016/09/05  by 08172       调整系统中无ENT的SQL条件增加ent
#160913-00055#2    2016/09/18  By lixiang  开供应商调整为q_pmaa001，去掉手动加的限定条件,开客户调整为q_pmaa001_13
#161124-00048#3    2016/12/08  By 08734    星号整批调整
#161212-00043#1    2016/12/22  By wuxja    在储位维护里加个状态码栏位来实现有效失效储位，失效时需判断无库存量的储位才可以失效
#161231-00011#1    2016/12/31  By wuxja    新增单身时库存可用否。MRP可用否依单头带入
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
PRIVATE type type_g_inaa_m        RECORD
       inaa001 LIKE inaa_t.inaa001, 
   inaa001_desc LIKE type_t.chr80, 
   inaa001_desc_desc LIKE type_t.chr80, 
   inaa005 LIKE inaa_t.inaa005, 
   inaa005_desc LIKE type_t.chr80, 
   inaa006 LIKE inaa_t.inaa006, 
   inaa007 LIKE inaa_t.inaa007, 
   inaa008 LIKE inaa_t.inaa008, 
   inaa009 LIKE inaa_t.inaa009, 
   inaa010 LIKE inaa_t.inaa010, 
   inaa014 LIKE inaa_t.inaa014, 
   inaa015 LIKE inaa_t.inaa015, 
   inaa017 LIKE inaa_t.inaa017, 
   inaa011 LIKE inaa_t.inaa011, 
   inaa012 LIKE inaa_t.inaa012, 
   inaa013 LIKE inaa_t.inaa013, 
   inaastus LIKE inaa_t.inaastus, 
   inaaownid LIKE inaa_t.inaaownid, 
   inaaownid_desc LIKE type_t.chr80, 
   inaaowndp LIKE inaa_t.inaaowndp, 
   inaaowndp_desc LIKE type_t.chr80, 
   inaacrtid LIKE inaa_t.inaacrtid, 
   inaacrtid_desc LIKE type_t.chr80, 
   inaacrtdp LIKE inaa_t.inaacrtdp, 
   inaacrtdp_desc LIKE type_t.chr80, 
   inaacrtdt LIKE inaa_t.inaacrtdt, 
   inaamodid LIKE inaa_t.inaamodid, 
   inaamodid_desc LIKE type_t.chr80, 
   inaamoddt LIKE inaa_t.inaamoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_inab_d        RECORD
       inabstus LIKE inab_t.inabstus, 
   inab002 LIKE inab_t.inab002, 
   inab003 LIKE inab_t.inab003, 
   inab004 LIKE inab_t.inab004, 
   inab005 LIKE inab_t.inab005, 
   inab006 LIKE inab_t.inab006, 
   inab007 LIKE inab_t.inab007, 
   inab008 LIKE inab_t.inab008
       END RECORD
PRIVATE TYPE type_g_inab3_d RECORD
       inab002 LIKE inab_t.inab002, 
   inabownid LIKE inab_t.inabownid, 
   inabownid_desc LIKE type_t.chr500, 
   inabowndp LIKE inab_t.inabowndp, 
   inabowndp_desc LIKE type_t.chr500, 
   inabcrtid LIKE inab_t.inabcrtid, 
   inabcrtid_desc LIKE type_t.chr500, 
   inabcrtdp LIKE inab_t.inabcrtdp, 
   inabcrtdp_desc LIKE type_t.chr500, 
   inabcrtdt DATETIME YEAR TO SECOND, 
   inabmodid LIKE inab_t.inabmodid, 
   inabmodid_desc LIKE type_t.chr500, 
   inabmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_inaa001 LIKE inaa_t.inaa001,
   b_inaa001_desc LIKE type_t.chr80,
   b_inaa001_desc_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_inab2_d RECORD
   inac003      LIKE inac_t.inac003, 
   inac003_desc LIKE oocql_t.oocql004
       END RECORD

#模組變數(Module Variables)
DEFINE g_inab2_d   DYNAMIC ARRAY OF type_g_inab2_d
DEFINE g_inab2_d_t type_g_inab2_d
DEFINE g_rec_b2              LIKE type_t.num5           
DEFINE l_ac2                 LIKE type_t.num5
DEFINE l_ac2_t               LIKE type_t.num5

DEFINE  g_flag          LIKE type_t.num5 
DEFINE  g_flag2         LIKE type_t.num5 
#end add-point
       
#模組變數(Module Variables)
DEFINE g_inaa_m          type_g_inaa_m
DEFINE g_inaa_m_t        type_g_inaa_m
DEFINE g_inaa_m_o        type_g_inaa_m
DEFINE g_inaa_m_mask_o   type_g_inaa_m #轉換遮罩前資料
DEFINE g_inaa_m_mask_n   type_g_inaa_m #轉換遮罩後資料
 
   DEFINE g_inaa001_t LIKE inaa_t.inaa001
 
 
DEFINE g_inab_d          DYNAMIC ARRAY OF type_g_inab_d
DEFINE g_inab_d_t        type_g_inab_d
DEFINE g_inab_d_o        type_g_inab_d
DEFINE g_inab_d_mask_o   DYNAMIC ARRAY OF type_g_inab_d #轉換遮罩前資料
DEFINE g_inab_d_mask_n   DYNAMIC ARRAY OF type_g_inab_d #轉換遮罩後資料
DEFINE g_inab3_d          DYNAMIC ARRAY OF type_g_inab3_d
DEFINE g_inab3_d_t        type_g_inab3_d
DEFINE g_inab3_d_o        type_g_inab3_d
DEFINE g_inab3_d_mask_o   DYNAMIC ARRAY OF type_g_inab3_d #轉換遮罩前資料
DEFINE g_inab3_d_mask_n   DYNAMIC ARRAY OF type_g_inab3_d #轉換遮罩後資料
 
 
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
 
{<section id="aini002.main" >}
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
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   #LET l_ac = 1
   LET g_flag = FALSE
   LET g_flag2 = FALSE
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT inaa001,'','',inaa005,'',inaa006,inaa007,inaa008,inaa009,inaa010,inaa014, 
       inaa015,inaa017,inaa011,inaa012,inaa013,inaastus,inaaownid,'',inaaowndp,'',inaacrtid,'',inaacrtdp, 
       '',inaacrtdt,inaamodid,'',inaamoddt", 
                      " FROM inaa_t",
                      " WHERE inaaent= ? AND inaasite= ? AND inaa001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aini002_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.inaa001,t0.inaa005,t0.inaa006,t0.inaa007,t0.inaa008,t0.inaa009,t0.inaa010, 
       t0.inaa014,t0.inaa015,t0.inaa017,t0.inaa011,t0.inaa012,t0.inaa013,t0.inaastus,t0.inaaownid,t0.inaaowndp, 
       t0.inaacrtid,t0.inaacrtdp,t0.inaacrtdt,t0.inaamodid,t0.inaamoddt,t1.inayl003 ,t2.inayl004 ,t3.ooefl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011",
               " FROM inaa_t t0",
                              " LEFT JOIN inayl_t t1 ON t1.inaylent="||g_enterprise||" AND t1.inayl001=t0.inaa001 AND t1.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t2 ON t2.inaylent="||g_enterprise||" AND t2.inayl001=t0.inaa001 AND t2.inayl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.inaa005 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.inaaownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.inaaowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.inaacrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.inaacrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.inaamodid  ",
 
               " WHERE t0.inaaent = " ||g_enterprise|| " AND t0.inaasite = ? AND t0.inaa001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aini002_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aini002 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aini002_init()   
 
      #進入選單 Menu (="N")
      CALL aini002_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aini002
      
   END IF 
   
   CLOSE aini002_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aini002.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aini002_init()
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
      CALL cl_set_combo_scc_part('inaastus','17','N,Y')
 
      CALL cl_set_combo_scc('inaa007','2050') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_comp_visible("inab008",FALSE)
   #end add-point
   
   #初始化搜尋條件
   CALL aini002_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aini002.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aini002_ui_dialog()
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
   DEFINE  l_inaa004       LIKE inaa_t.inaa004
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
            CALL aini002_insert()
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
         INITIALIZE g_inaa_m.* TO NULL
         CALL g_inab_d.clear()
         CALL g_inab3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aini002_init()
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
               
               CALL aini002_fetch('') # reload data
               LET l_ac = 1
               CALL aini002_ui_detailshow() #Setting the current row 
         
               CALL aini002_idx_chk()
               #NEXT FIELD inab002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_inab_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aini002_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               CALL aini002_inac_fill()
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL aini002_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_inab3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aini002_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 2
               #顯示單身筆數
               CALL aini002_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_inab2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) 
    
            BEFORE ROW
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac2
          
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 1
               
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aini002_browser_fill("")
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
               CALL aini002_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aini002_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aini002_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aini002_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aini002_set_act_visible()   
            CALL aini002_set_act_no_visible()
            IF NOT (g_inaa_m.inaa001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " inaaent = " ||g_enterprise|| " AND inaasite = '" ||g_site|| "' AND",
                                  " inaa001 = '", g_inaa_m.inaa001, "' "
 
               #填到對應位置
               CALL aini002_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "inaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "inab_t" 
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
               CALL aini002_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "inaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "inab_t" 
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
                  CALL aini002_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aini002_fetch("F")
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
               CALL aini002_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aini002_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aini002_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aini002_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aini002_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aini002_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aini002_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aini002_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aini002_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aini002_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aini002_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_inab_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_inab3_d)
                  LET g_export_id[2]   = "s_detail3"
 
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
               NEXT FIELD inab002
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
               CALL aini002_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aini002_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aini002_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aini002_insert()
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
               CALL aini002_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aini002_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aooi350_01
            LET g_action_choice="aooi350_01"
            IF cl_auth_chk_act("aooi350_01") THEN
               
               #add-point:ON ACTION aooi350_01 name="menu.aooi350_01"
               LET l_inaa004 = ''
               SELECT inaa004 INTO l_inaa004 FROM inaa_t 
                  WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_m.inaa001
               CALL aooi350_01(l_inaa004)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aooi350_02
            LET g_action_choice="aooi350_02"
            IF cl_auth_chk_act("aooi350_02") THEN
               
               #add-point:ON ACTION aooi350_02 name="menu.aooi350_02"
               LET l_inaa004 = ''
               SELECT inaa004 INTO l_inaa004 FROM inaa_t 
                  WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_m.inaa001
               CALL aooi350_02(l_inaa004)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aini002_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aini002_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aini002_set_pk_array()
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
 
{<section id="aini002.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aini002_browser_fill(ps_page_action)
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
   CALL g_inab2_d.clear() 
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT inaa001 ",
                      " FROM inaa_t ",
                      " ",
                      " LEFT JOIN inab_t ON inabent = inaaent AND inabsite = inaasite AND inaa001 = inab001 ", "  ",
                      #add-point:browser_fill段sql(inab_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE inaaent = " ||g_enterprise|| " AND inaasite = '" ||g_site|| "' AND inabent = " ||g_enterprise|| " AND inabsite = '" ||g_site|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("inaa_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT inaa001 ",
                      " FROM inaa_t ", 
                      "  ",
                      "  ",
                      " WHERE inaaent = " ||g_enterprise|| " AND inaasite = '" ||g_site|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("inaa_t")
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
      INITIALIZE g_inaa_m.* TO NULL
      CALL g_inab_d.clear()        
      CALL g_inab3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.inaa001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.inaastus,t0.inaa001,t1.inayl003 ,t2.inayl004 ",
                  " FROM inaa_t t0",
                  "  ",
                  "  LEFT JOIN inab_t ON inabent = inaaent AND inabsite = inaasite AND inaa001 = inab001 ", "  ", 
                  #add-point:browser_fill段sql(inab_t1) name="browser_fill.join.inab_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN inayl_t t1 ON t1.inaylent="||g_enterprise||" AND t1.inayl001=t0.inaa001 AND t1.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t2 ON t2.inaylent="||g_enterprise||" AND t2.inayl001=t0.inaa001 AND t2.inayl002='"||g_dlang||"' ",
 
                  " WHERE t0.inaaent = " ||g_enterprise|| " AND t0.inaasite = '" ||g_site|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("inaa_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.inaastus,t0.inaa001,t1.inayl003 ,t2.inayl004 ",
                  " FROM inaa_t t0",
                  "  ",
                                 " LEFT JOIN inayl_t t1 ON t1.inaylent="||g_enterprise||" AND t1.inayl001=t0.inaa001 AND t1.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t2 ON t2.inaylent="||g_enterprise||" AND t2.inayl001=t0.inaa001 AND t2.inayl002='"||g_dlang||"' ",
 
                  " WHERE t0.inaaent = " ||g_enterprise|| " AND t0.inaasite = '" ||g_site|| "' AND ",l_wc, cl_sql_add_filter("inaa_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY inaa001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"inaa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_inaa001,g_browser[g_cnt].b_inaa001_desc, 
          g_browser[g_cnt].b_inaa001_desc_desc
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
         CALL aini002_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_inaa001) THEN
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
 
{<section id="aini002.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aini002_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_inaa_m.inaa001 = g_browser[g_current_idx].b_inaa001   
 
   EXECUTE aini002_master_referesh USING g_site,g_inaa_m.inaa001 INTO g_inaa_m.inaa001,g_inaa_m.inaa005, 
       g_inaa_m.inaa006,g_inaa_m.inaa007,g_inaa_m.inaa008,g_inaa_m.inaa009,g_inaa_m.inaa010,g_inaa_m.inaa014, 
       g_inaa_m.inaa015,g_inaa_m.inaa017,g_inaa_m.inaa011,g_inaa_m.inaa012,g_inaa_m.inaa013,g_inaa_m.inaastus, 
       g_inaa_m.inaaownid,g_inaa_m.inaaowndp,g_inaa_m.inaacrtid,g_inaa_m.inaacrtdp,g_inaa_m.inaacrtdt, 
       g_inaa_m.inaamodid,g_inaa_m.inaamoddt,g_inaa_m.inaa001_desc,g_inaa_m.inaa001_desc_desc,g_inaa_m.inaa005_desc, 
       g_inaa_m.inaaownid_desc,g_inaa_m.inaaowndp_desc,g_inaa_m.inaacrtid_desc,g_inaa_m.inaacrtdp_desc, 
       g_inaa_m.inaamodid_desc
   
   CALL aini002_inaa_t_mask()
   CALL aini002_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aini002.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aini002_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aini002.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aini002_ui_browser_refresh()
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
      IF g_browser[l_i].b_inaa001 = g_inaa_m.inaa001 
 
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
 
{<section id="aini002.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aini002_construct()
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
   INITIALIZE g_inaa_m.* TO NULL
   CALL g_inab_d.clear()        
   CALL g_inab3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   CALL g_inab2_d.clear() 
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON inaa001,inaa005,inaa006,inaa007,inaa008,inaa009,inaa010,inaa014,inaa015, 
          inaa017,inaa011,inaa012,inaa013,inaastus,inaaownid,inaaowndp,inaacrtid,inaacrtdp,inaacrtdt, 
          inaamodid,inaamoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<inaacrtdt>>----
         AFTER FIELD inaacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<inaamoddt>>----
         AFTER FIELD inaamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inaacnfdt>>----
         
         #----<<inaapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.inaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa001
            #add-point:ON ACTION controlp INFIELD inaa001 name="construct.c.inaa001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_inay001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaa001  #顯示到畫面上

            NEXT FIELD inaa001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa001
            #add-point:BEFORE FIELD inaa001 name="construct.b.inaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa001
            
            #add-point:AFTER FIELD inaa001 name="construct.a.inaa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa005
            #add-point:ON ACTION controlp INFIELD inaa005 name="construct.c.inaa005"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_inaa005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaa005  #顯示到畫面上

            NEXT FIELD inaa005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa005
            #add-point:BEFORE FIELD inaa005 name="construct.b.inaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa005
            
            #add-point:AFTER FIELD inaa005 name="construct.a.inaa005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa006
            #add-point:BEFORE FIELD inaa006 name="construct.b.inaa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa006
            
            #add-point:AFTER FIELD inaa006 name="construct.a.inaa006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa006
            #add-point:ON ACTION controlp INFIELD inaa006 name="construct.c.inaa006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa007
            #add-point:BEFORE FIELD inaa007 name="construct.b.inaa007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa007
            
            #add-point:AFTER FIELD inaa007 name="construct.a.inaa007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa007
            #add-point:ON ACTION controlp INFIELD inaa007 name="construct.c.inaa007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa008
            #add-point:BEFORE FIELD inaa008 name="construct.b.inaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa008
            
            #add-point:AFTER FIELD inaa008 name="construct.a.inaa008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa008
            #add-point:ON ACTION controlp INFIELD inaa008 name="construct.c.inaa008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa009
            #add-point:BEFORE FIELD inaa009 name="construct.b.inaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa009
            
            #add-point:AFTER FIELD inaa009 name="construct.a.inaa009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa009
            #add-point:ON ACTION controlp INFIELD inaa009 name="construct.c.inaa009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa010
            #add-point:BEFORE FIELD inaa010 name="construct.b.inaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa010
            
            #add-point:AFTER FIELD inaa010 name="construct.a.inaa010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaa010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa010
            #add-point:ON ACTION controlp INFIELD inaa010 name="construct.c.inaa010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa014
            #add-point:BEFORE FIELD inaa014 name="construct.b.inaa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa014
            
            #add-point:AFTER FIELD inaa014 name="construct.a.inaa014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa014
            #add-point:ON ACTION controlp INFIELD inaa014 name="construct.c.inaa014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa015
            #add-point:BEFORE FIELD inaa015 name="construct.b.inaa015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa015
            
            #add-point:AFTER FIELD inaa015 name="construct.a.inaa015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaa015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa015
            #add-point:ON ACTION controlp INFIELD inaa015 name="construct.c.inaa015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa017
            #add-point:BEFORE FIELD inaa017 name="construct.b.inaa017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa017
            
            #add-point:AFTER FIELD inaa017 name="construct.a.inaa017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaa017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa017
            #add-point:ON ACTION controlp INFIELD inaa017 name="construct.c.inaa017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa011
            #add-point:BEFORE FIELD inaa011 name="construct.b.inaa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa011
            
            #add-point:AFTER FIELD inaa011 name="construct.a.inaa011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa011
            #add-point:ON ACTION controlp INFIELD inaa011 name="construct.c.inaa011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa012
            #add-point:BEFORE FIELD inaa012 name="construct.b.inaa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa012
            
            #add-point:AFTER FIELD inaa012 name="construct.a.inaa012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa012
            #add-point:ON ACTION controlp INFIELD inaa012 name="construct.c.inaa012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa013
            #add-point:BEFORE FIELD inaa013 name="construct.b.inaa013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa013
            
            #add-point:AFTER FIELD inaa013 name="construct.a.inaa013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa013
            #add-point:ON ACTION controlp INFIELD inaa013 name="construct.c.inaa013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaastus
            #add-point:BEFORE FIELD inaastus name="construct.b.inaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaastus
            
            #add-point:AFTER FIELD inaastus name="construct.a.inaastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaastus
            #add-point:ON ACTION controlp INFIELD inaastus name="construct.c.inaastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inaaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaaownid
            #add-point:ON ACTION controlp INFIELD inaaownid name="construct.c.inaaownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaaownid  #顯示到畫面上

            NEXT FIELD inaaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaaownid
            #add-point:BEFORE FIELD inaaownid name="construct.b.inaaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaaownid
            
            #add-point:AFTER FIELD inaaownid name="construct.a.inaaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaaowndp
            #add-point:ON ACTION controlp INFIELD inaaowndp name="construct.c.inaaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaaowndp  #顯示到畫面上

            NEXT FIELD inaaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaaowndp
            #add-point:BEFORE FIELD inaaowndp name="construct.b.inaaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaaowndp
            
            #add-point:AFTER FIELD inaaowndp name="construct.a.inaaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaacrtid
            #add-point:ON ACTION controlp INFIELD inaacrtid name="construct.c.inaacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaacrtid  #顯示到畫面上

            NEXT FIELD inaacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaacrtid
            #add-point:BEFORE FIELD inaacrtid name="construct.b.inaacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaacrtid
            
            #add-point:AFTER FIELD inaacrtid name="construct.a.inaacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaacrtdp
            #add-point:ON ACTION controlp INFIELD inaacrtdp name="construct.c.inaacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaacrtdp  #顯示到畫面上

            NEXT FIELD inaacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaacrtdp
            #add-point:BEFORE FIELD inaacrtdp name="construct.b.inaacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaacrtdp
            
            #add-point:AFTER FIELD inaacrtdp name="construct.a.inaacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaacrtdt
            #add-point:BEFORE FIELD inaacrtdt name="construct.b.inaacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inaamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaamodid
            #add-point:ON ACTION controlp INFIELD inaamodid name="construct.c.inaamodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaamodid  #顯示到畫面上

            NEXT FIELD inaamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaamodid
            #add-point:BEFORE FIELD inaamodid name="construct.b.inaamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaamodid
            
            #add-point:AFTER FIELD inaamodid name="construct.a.inaamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaamoddt
            #add-point:BEFORE FIELD inaamoddt name="construct.b.inaamoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON inabstus,inab002,inab003,inab004,inab005,inab006,inab007,inab008,inab002_2, 
          inabownid,inabowndp,inabcrtid,inabcrtdp,inabcrtdt,inabmodid,inabmoddt
           FROM s_detail1[1].inabstus,s_detail1[1].inab002,s_detail1[1].inab003,s_detail1[1].inab004, 
               s_detail1[1].inab005,s_detail1[1].inab006,s_detail1[1].inab007,s_detail1[1].inab008,s_detail3[1].inab002_2, 
               s_detail3[1].inabownid,s_detail3[1].inabowndp,s_detail3[1].inabcrtid,s_detail3[1].inabcrtdp, 
               s_detail3[1].inabcrtdt,s_detail3[1].inabmodid,s_detail3[1].inabmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<inabcrtdt>>----
         AFTER FIELD inabcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<inabmoddt>>----
         AFTER FIELD inabmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inabcnfdt>>----
         
         #----<<inabpstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inabstus
            #add-point:BEFORE FIELD inabstus name="construct.b.page1.inabstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inabstus
            
            #add-point:AFTER FIELD inabstus name="construct.a.page1.inabstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inabstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inabstus
            #add-point:ON ACTION controlp INFIELD inabstus name="construct.c.page1.inabstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inab002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab002
            #add-point:ON ACTION controlp INFIELD inab002 name="construct.c.page1.inab002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_inab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inab002  #顯示到畫面上

            NEXT FIELD inab002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab002
            #add-point:BEFORE FIELD inab002 name="construct.b.page1.inab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab002
            
            #add-point:AFTER FIELD inab002 name="construct.a.page1.inab002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab003
            #add-point:BEFORE FIELD inab003 name="construct.b.page1.inab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab003
            
            #add-point:AFTER FIELD inab003 name="construct.a.page1.inab003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab003
            #add-point:ON ACTION controlp INFIELD inab003 name="construct.c.page1.inab003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab004
            #add-point:BEFORE FIELD inab004 name="construct.b.page1.inab004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab004
            
            #add-point:AFTER FIELD inab004 name="construct.a.page1.inab004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inab004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab004
            #add-point:ON ACTION controlp INFIELD inab004 name="construct.c.page1.inab004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab005
            #add-point:BEFORE FIELD inab005 name="construct.b.page1.inab005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab005
            
            #add-point:AFTER FIELD inab005 name="construct.a.page1.inab005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inab005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab005
            #add-point:ON ACTION controlp INFIELD inab005 name="construct.c.page1.inab005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab006
            #add-point:BEFORE FIELD inab006 name="construct.b.page1.inab006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab006
            
            #add-point:AFTER FIELD inab006 name="construct.a.page1.inab006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inab006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab006
            #add-point:ON ACTION controlp INFIELD inab006 name="construct.c.page1.inab006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab007
            #add-point:BEFORE FIELD inab007 name="construct.b.page1.inab007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab007
            
            #add-point:AFTER FIELD inab007 name="construct.a.page1.inab007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inab007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab007
            #add-point:ON ACTION controlp INFIELD inab007 name="construct.c.page1.inab007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab008
            #add-point:BEFORE FIELD inab008 name="construct.b.page1.inab008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab008
            
            #add-point:AFTER FIELD inab008 name="construct.a.page1.inab008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inab008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab008
            #add-point:ON ACTION controlp INFIELD inab008 name="construct.c.page1.inab008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.inab002_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab002_2
            #add-point:ON ACTION controlp INFIELD inab002_2 name="construct.c.page3.inab002_2"
#此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_inab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inab002_2  #顯示到畫面上

            NEXT FIELD inab002_2                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab002_2
            #add-point:BEFORE FIELD inab002_2 name="construct.b.page3.inab002_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab002_2
            
            #add-point:AFTER FIELD inab002_2 name="construct.a.page3.inab002_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.inabownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inabownid
            #add-point:ON ACTION controlp INFIELD inabownid name="construct.c.page3.inabownid"
#此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inabownid  #顯示到畫面上

            NEXT FIELD inabownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inabownid
            #add-point:BEFORE FIELD inabownid name="construct.b.page3.inabownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inabownid
            
            #add-point:AFTER FIELD inabownid name="construct.a.page3.inabownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.inabowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inabowndp
            #add-point:ON ACTION controlp INFIELD inabowndp name="construct.c.page3.inabowndp"
#此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inabowndp  #顯示到畫面上

            NEXT FIELD inabowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inabowndp
            #add-point:BEFORE FIELD inabowndp name="construct.b.page3.inabowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inabowndp
            
            #add-point:AFTER FIELD inabowndp name="construct.a.page3.inabowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.inabcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inabcrtid
            #add-point:ON ACTION controlp INFIELD inabcrtid name="construct.c.page3.inabcrtid"
#此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inabcrtid  #顯示到畫面上

            NEXT FIELD inabcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inabcrtid
            #add-point:BEFORE FIELD inabcrtid name="construct.b.page3.inabcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inabcrtid
            
            #add-point:AFTER FIELD inabcrtid name="construct.a.page3.inabcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.inabcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inabcrtdp
            #add-point:ON ACTION controlp INFIELD inabcrtdp name="construct.c.page3.inabcrtdp"
#此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inabcrtdp  #顯示到畫面上

            NEXT FIELD inabcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inabcrtdp
            #add-point:BEFORE FIELD inabcrtdp name="construct.b.page3.inabcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inabcrtdp
            
            #add-point:AFTER FIELD inabcrtdp name="construct.a.page3.inabcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inabcrtdt
            #add-point:BEFORE FIELD inabcrtdt name="construct.b.page3.inabcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.inabmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inabmodid
            #add-point:ON ACTION controlp INFIELD inabmodid name="construct.c.page3.inabmodid"
#此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inabmodid  #顯示到畫面上

            NEXT FIELD inabmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inabmodid
            #add-point:BEFORE FIELD inabmodid name="construct.b.page3.inabmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inabmodid
            
            #add-point:AFTER FIELD inabmodid name="construct.a.page3.inabmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inabmoddt
            #add-point:BEFORE FIELD inabmoddt name="construct.b.page3.inabmoddt"
            
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
                  WHEN la_wc[li_idx].tableid = "inaa_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "inab_t" 
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
 
{<section id="aini002.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aini002_filter()
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
      CONSTRUCT g_wc_filter ON inaa001
                          FROM s_browse[1].b_inaa001
 
         BEFORE CONSTRUCT
               DISPLAY aini002_filter_parser('inaa001') TO s_browse[1].b_inaa001
      
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
 
      CALL aini002_filter_show('inaa001')
 
END FUNCTION
 
{</section>}
 
{<section id="aini002.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aini002_filter_parser(ps_field)
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
 
{<section id="aini002.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aini002_filter_show(ps_field)
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
   LET ls_condition = aini002_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aini002.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aini002_query()
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
   CALL g_inab_d.clear()
   CALL g_inab3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aini002_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aini002_browser_fill("")
      CALL aini002_fetch("")
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
      CALL aini002_filter_show('inaa001')
   CALL aini002_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aini002_fetch("F") 
      #顯示單身筆數
      CALL aini002_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aini002.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aini002_fetch(p_flag)
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
   
   LET g_inaa_m.inaa001 = g_browser[g_current_idx].b_inaa001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aini002_master_referesh USING g_site,g_inaa_m.inaa001 INTO g_inaa_m.inaa001,g_inaa_m.inaa005, 
       g_inaa_m.inaa006,g_inaa_m.inaa007,g_inaa_m.inaa008,g_inaa_m.inaa009,g_inaa_m.inaa010,g_inaa_m.inaa014, 
       g_inaa_m.inaa015,g_inaa_m.inaa017,g_inaa_m.inaa011,g_inaa_m.inaa012,g_inaa_m.inaa013,g_inaa_m.inaastus, 
       g_inaa_m.inaaownid,g_inaa_m.inaaowndp,g_inaa_m.inaacrtid,g_inaa_m.inaacrtdp,g_inaa_m.inaacrtdt, 
       g_inaa_m.inaamodid,g_inaa_m.inaamoddt,g_inaa_m.inaa001_desc,g_inaa_m.inaa001_desc_desc,g_inaa_m.inaa005_desc, 
       g_inaa_m.inaaownid_desc,g_inaa_m.inaaowndp_desc,g_inaa_m.inaacrtid_desc,g_inaa_m.inaacrtdp_desc, 
       g_inaa_m.inaamodid_desc
   
   #遮罩相關處理
   LET g_inaa_m_mask_o.* =  g_inaa_m.*
   CALL aini002_inaa_t_mask()
   LET g_inaa_m_mask_n.* =  g_inaa_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aini002_set_act_visible()   
   CALL aini002_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_inaa_m_t.* = g_inaa_m.*
   LET g_inaa_m_o.* = g_inaa_m.*
   
   LET g_data_owner = g_inaa_m.inaaownid      
   LET g_data_dept  = g_inaa_m.inaaowndp
   
   #重新顯示   
   CALL aini002_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aini002.insert" >}
#+ 資料新增
PRIVATE FUNCTION aini002_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success    LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_inab_d.clear()   
   CALL g_inab3_d.clear()  
 
 
   INITIALIZE g_inaa_m.* TO NULL             #DEFAULT 設定
   
   LET g_inaa001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inaa_m.inaaownid = g_user
      LET g_inaa_m.inaaowndp = g_dept
      LET g_inaa_m.inaacrtid = g_user
      LET g_inaa_m.inaacrtdp = g_dept 
      LET g_inaa_m.inaacrtdt = cl_get_current()
      LET g_inaa_m.inaamodid = g_user
      LET g_inaa_m.inaamoddt = cl_get_current()
      LET g_inaa_m.inaastus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_inaa_m.inaa007 = "1"
      LET g_inaa_m.inaa008 = "Y"
      LET g_inaa_m.inaa009 = "Y"
      LET g_inaa_m.inaa010 = "Y"
      LET g_inaa_m.inaa014 = "N"
      LET g_inaa_m.inaa015 = "N"
      LET g_inaa_m.inaa017 = "N"
      LET g_inaa_m.inaa011 = "N"
      LET g_inaa_m.inaa012 = "N"
      LET g_inaa_m.inaastus = "Y"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL g_inab2_d.clear() 
      #tag二進制碼初始化
      CALL s_aooi310_init_tagb('1') RETURNING l_success,g_inaa_m.inaa013
      
      LET g_inaa_m_t.* = g_inaa_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_inaa_m_t.* = g_inaa_m.*
      LET g_inaa_m_o.* = g_inaa_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inaa_m.inaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL aini002_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      CALL g_inab2_d.clear() 
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
         INITIALIZE g_inaa_m.* TO NULL
         INITIALIZE g_inab_d TO NULL
         INITIALIZE g_inab3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aini002_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_inab_d.clear()
      #CALL g_inab3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aini002_set_act_visible()   
   CALL aini002_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_inaa001_t = g_inaa_m.inaa001
 
   
   #組合新增資料的條件
   LET g_add_browse = " inaaent = " ||g_enterprise|| " AND inaasite = '" ||g_site|| "' AND",
                      " inaa001 = '", g_inaa_m.inaa001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aini002_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aini002_cl
   
   CALL aini002_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aini002_master_referesh USING g_site,g_inaa_m.inaa001 INTO g_inaa_m.inaa001,g_inaa_m.inaa005, 
       g_inaa_m.inaa006,g_inaa_m.inaa007,g_inaa_m.inaa008,g_inaa_m.inaa009,g_inaa_m.inaa010,g_inaa_m.inaa014, 
       g_inaa_m.inaa015,g_inaa_m.inaa017,g_inaa_m.inaa011,g_inaa_m.inaa012,g_inaa_m.inaa013,g_inaa_m.inaastus, 
       g_inaa_m.inaaownid,g_inaa_m.inaaowndp,g_inaa_m.inaacrtid,g_inaa_m.inaacrtdp,g_inaa_m.inaacrtdt, 
       g_inaa_m.inaamodid,g_inaa_m.inaamoddt,g_inaa_m.inaa001_desc,g_inaa_m.inaa001_desc_desc,g_inaa_m.inaa005_desc, 
       g_inaa_m.inaaownid_desc,g_inaa_m.inaaowndp_desc,g_inaa_m.inaacrtid_desc,g_inaa_m.inaacrtdp_desc, 
       g_inaa_m.inaamodid_desc
   
   
   #遮罩相關處理
   LET g_inaa_m_mask_o.* =  g_inaa_m.*
   CALL aini002_inaa_t_mask()
   LET g_inaa_m_mask_n.* =  g_inaa_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_inaa_m.inaa001,g_inaa_m.inaa001_desc,g_inaa_m.inaa001_desc_desc,g_inaa_m.inaa005, 
       g_inaa_m.inaa005_desc,g_inaa_m.inaa006,g_inaa_m.inaa007,g_inaa_m.inaa008,g_inaa_m.inaa009,g_inaa_m.inaa010, 
       g_inaa_m.inaa014,g_inaa_m.inaa015,g_inaa_m.inaa017,g_inaa_m.inaa011,g_inaa_m.inaa012,g_inaa_m.inaa013, 
       g_inaa_m.inaastus,g_inaa_m.inaaownid,g_inaa_m.inaaownid_desc,g_inaa_m.inaaowndp,g_inaa_m.inaaowndp_desc, 
       g_inaa_m.inaacrtid,g_inaa_m.inaacrtid_desc,g_inaa_m.inaacrtdp,g_inaa_m.inaacrtdp_desc,g_inaa_m.inaacrtdt, 
       g_inaa_m.inaamodid,g_inaa_m.inaamodid_desc,g_inaa_m.inaamoddt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_inaa_m.inaaownid      
   LET g_data_dept  = g_inaa_m.inaaowndp
   
   #功能已完成,通報訊息中心
   CALL aini002_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aini002.modify" >}
#+ 資料修改
PRIVATE FUNCTION aini002_modify()
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
   LET g_inaa_m_t.* = g_inaa_m.*
   LET g_inaa_m_o.* = g_inaa_m.*
   
   IF g_inaa_m.inaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_inaa001_t = g_inaa_m.inaa001
 
   CALL s_transaction_begin()
   
   OPEN aini002_cl USING g_enterprise, g_site,g_inaa_m.inaa001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aini002_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aini002_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aini002_master_referesh USING g_site,g_inaa_m.inaa001 INTO g_inaa_m.inaa001,g_inaa_m.inaa005, 
       g_inaa_m.inaa006,g_inaa_m.inaa007,g_inaa_m.inaa008,g_inaa_m.inaa009,g_inaa_m.inaa010,g_inaa_m.inaa014, 
       g_inaa_m.inaa015,g_inaa_m.inaa017,g_inaa_m.inaa011,g_inaa_m.inaa012,g_inaa_m.inaa013,g_inaa_m.inaastus, 
       g_inaa_m.inaaownid,g_inaa_m.inaaowndp,g_inaa_m.inaacrtid,g_inaa_m.inaacrtdp,g_inaa_m.inaacrtdt, 
       g_inaa_m.inaamodid,g_inaa_m.inaamoddt,g_inaa_m.inaa001_desc,g_inaa_m.inaa001_desc_desc,g_inaa_m.inaa005_desc, 
       g_inaa_m.inaaownid_desc,g_inaa_m.inaaowndp_desc,g_inaa_m.inaacrtid_desc,g_inaa_m.inaacrtdp_desc, 
       g_inaa_m.inaamodid_desc
   
   #檢查是否允許此動作
   IF NOT aini002_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_inaa_m_mask_o.* =  g_inaa_m.*
   CALL aini002_inaa_t_mask()
   LET g_inaa_m_mask_n.* =  g_inaa_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aini002_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_inaa001_t = g_inaa_m.inaa001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_inaa_m.inaamodid = g_user 
LET g_inaa_m.inaamoddt = cl_get_current()
LET g_inaa_m.inaamodid_desc = cl_get_username(g_inaa_m.inaamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aini002_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE inaa_t SET (inaamodid,inaamoddt) = (g_inaa_m.inaamodid,g_inaa_m.inaamoddt)
          WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_inaa_m.* = g_inaa_m_t.*
            CALL aini002_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_inaa_m.inaa001 != g_inaa_m_t.inaa001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE inab_t SET inab001 = g_inaa_m.inaa001
 
          WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_m_t.inaa001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "inab_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inab_t:",SQLERRMESSAGE 
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
   CALL aini002_set_act_visible()   
   CALL aini002_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " inaaent = " ||g_enterprise|| " AND inaasite = '" ||g_site|| "' AND",
                      " inaa001 = '", g_inaa_m.inaa001, "' "
 
   #填到對應位置
   CALL aini002_browser_fill("")
 
   CLOSE aini002_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aini002_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aini002.input" >}
#+ 資料輸入
PRIVATE FUNCTION aini002_input(p_cmd)
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
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_ac2_t         LIKE type_t.num5                #未取消的ARRAY CNT 
   DEFINE  l_inaa004       LIKE inaa_t.inaa004
   #DEFINE  l_inaa013       LIKE inaa_t.inaa013
   DEFINE  l_inac003       STRING
   DEFINE  l_inaccrtdt     DATETIME YEAR TO SECOND
   DEFINE  l_inacmoddt     DATETIME YEAR TO SECOND
   DEFINE  l_allow_insert2 LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete2 LIKE type_t.num5                #可刪除否
   DEFINE  l_inab002       LIKE inab_t.inab002
   DEFINE  l_n1            LIKE type_t.num10
   DEFINE  l_n2            LIKE type_t.num10
   DEFINE  l_n3            LIKE type_t.num10    #161212-00043#1 add
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
   DISPLAY BY NAME g_inaa_m.inaa001,g_inaa_m.inaa001_desc,g_inaa_m.inaa001_desc_desc,g_inaa_m.inaa005, 
       g_inaa_m.inaa005_desc,g_inaa_m.inaa006,g_inaa_m.inaa007,g_inaa_m.inaa008,g_inaa_m.inaa009,g_inaa_m.inaa010, 
       g_inaa_m.inaa014,g_inaa_m.inaa015,g_inaa_m.inaa017,g_inaa_m.inaa011,g_inaa_m.inaa012,g_inaa_m.inaa013, 
       g_inaa_m.inaastus,g_inaa_m.inaaownid,g_inaa_m.inaaownid_desc,g_inaa_m.inaaowndp,g_inaa_m.inaaowndp_desc, 
       g_inaa_m.inaacrtid,g_inaa_m.inaacrtid_desc,g_inaa_m.inaacrtdp,g_inaa_m.inaacrtdp_desc,g_inaa_m.inaacrtdt, 
       g_inaa_m.inaamodid,g_inaa_m.inaamodid_desc,g_inaa_m.inaamoddt
   
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
   LET g_forupd_sql = "SELECT inabstus,inab002,inab003,inab004,inab005,inab006,inab007,inab008,inab002, 
       inabownid,inabowndp,inabcrtid,inabcrtdp,inabcrtdt,inabmodid,inabmoddt FROM inab_t WHERE inabent=?  
       AND inabsite=? AND inab001=? AND inab002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   LET g_forupd_sql = "SELECT inabstus,inab002,inab003,inab004,inab005,inab006,inab007,inab008, ",
                      "   inab002,inabownid,inabowndp,inabcrtid,inabcrtdp,inabcrtdt,inabmodid,inabmoddt FROM inab_t WHERE  ",
                      "  inabent=? AND inabsite= ? AND inab001=? AND inab002=? FOR UPDATE"
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aini002_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aini002_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aini002_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_inaa_m.inaa001,g_inaa_m.inaa005,g_inaa_m.inaa006,g_inaa_m.inaa007,g_inaa_m.inaa008, 
       g_inaa_m.inaa009,g_inaa_m.inaa010,g_inaa_m.inaa014,g_inaa_m.inaa015,g_inaa_m.inaa011,g_inaa_m.inaa012, 
       g_inaa_m.inaa013,g_inaa_m.inaastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   #當單頭的[C:儲位管理]選擇"5:不使用儲位管理"時，則單身不可以新增儲位資料
   IF g_inaa_m.inaa007 = '5' THEN
      LET l_allow_insert = FALSE
      LET l_allow_delete = FALSE
   END IF
   
   LET l_allow_insert2 = cl_auth_detail_input("insert")
   LET l_allow_delete2 = cl_auth_detail_input("delete")
   
   LET g_forupd_sql = "SELECT inac003,'' FROM inac_t WHERE inacent=? AND inacsite=? AND inac001=? AND inac002 = ? AND inac003=? FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aini002_bcl2 CURSOR FROM g_forupd_sql

   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aini002.input.head" >}
      #單頭段
      INPUT BY NAME g_inaa_m.inaa001,g_inaa_m.inaa005,g_inaa_m.inaa006,g_inaa_m.inaa007,g_inaa_m.inaa008, 
          g_inaa_m.inaa009,g_inaa_m.inaa010,g_inaa_m.inaa014,g_inaa_m.inaa015,g_inaa_m.inaa011,g_inaa_m.inaa012, 
          g_inaa_m.inaa013,g_inaa_m.inaastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aini002_cl USING g_enterprise, g_site,g_inaa_m.inaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aini002_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aini002_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aini002_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            IF l_cmd_t = 'r' THEN
               LET g_inaa_m.inaa001 = ''
               LET g_inaa_m.inaastus = 'Y'
               DISPLAY BY NAME g_inaa_m.inaa001,g_inaa_m.inaastus
            END IF
            #end add-point
            CALL aini002_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa001
            
            #add-point:AFTER FIELD inaa001 name="input.a.inaa001"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_inaa_m.inaa001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_inaa_m.inaa001 != g_inaa001_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inaa_t WHERE "||"inaaent = '" ||g_enterprise|| "' AND "||"inaasite = '"||g_site ||"' AND "|| "inaa001 = '"||g_inaa_m.inaa001 ||"'",'std-00004',0) THEN 
                     LET g_inaa_m.inaa001 = g_inaa_m_t.inaa001
                     CALL aini002_inaa001_desc()
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_inaa_m.inaa001,"SELECT COUNT(*) FROM inay_t WHERE inayent = '" ||g_enterprise||"' AND inay001 = ? ","ain-00307",1 ) THEN
                     LET g_inaa_m.inaa001 = g_inaa_m_t.inaa001
                     CALL aini002_inaa001_desc()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aini002_inaa001_desc()
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa001
            #add-point:BEFORE FIELD inaa001 name="input.b.inaa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa001
            #add-point:ON CHANGE inaa001 name="input.g.inaa001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa005
            
            #add-point:AFTER FIELD inaa005 name="input.a.inaa005"
            CALL aini002_inaa005_ref(g_inaa_m.inaa005) RETURNING g_inaa_m.inaa005_desc
            DISPLAY BY NAME g_inaa_m.inaa005_desc
            IF NOT cl_null(g_inaa_m.inaa005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_inaa_m.inaa005 != g_inaa_m_t.inaa005 OR cl_null(g_inaa_m_t.inaa005))) THEN 
                  IF NOT ap_chk_isExist(g_inaa_m.inaa005,"SELECT COUNT(*) FROM ooea_t WHERE ooeaent = '" ||g_enterprise||"' AND ooea001 = ? ","aoo-00094",1 ) THEN
                     LET g_inaa_m.inaa005 = g_inaa_m_t.inaa005
                     CALL aini002_inaa005_ref(g_inaa_m.inaa005) RETURNING g_inaa_m.inaa005_desc
                     DISPLAY BY NAME g_inaa_m.inaa005_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_inaa_m.inaa005,"SELECT COUNT(*) FROM ooea_t WHERE ooeaent = '" ||g_enterprise||"' AND ooea001 = ? AND ooeastus = 'Y' ","sub-01302",'aooi125') THEN#160318-00005#21 mod  #"aoo-00095",1 ) THEN
                     LET g_inaa_m.inaa005 = g_inaa_m_t.inaa005
                     CALL aini002_inaa005_ref(g_inaa_m.inaa005) RETURNING g_inaa_m.inaa005_desc
                     DISPLAY BY NAME g_inaa_m.inaa005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa005
            #add-point:BEFORE FIELD inaa005 name="input.b.inaa005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa005
            #add-point:ON CHANGE inaa005 name="input.g.inaa005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa006
            #add-point:BEFORE FIELD inaa006 name="input.b.inaa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa006
            
            #add-point:AFTER FIELD inaa006 name="input.a.inaa006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa006
            #add-point:ON CHANGE inaa006 name="input.g.inaa006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa007
            #add-point:BEFORE FIELD inaa007 name="input.b.inaa007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa007
            
            #add-point:AFTER FIELD inaa007 name="input.a.inaa007"
            IF g_inaa_m.inaa007 = '5' THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM inab_t 
                  WHERE inabent = g_enterprise AND inabsite = g_site 
                    AND inab001 = g_inaa_m.inaa001 AND inab002 <> ' '
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00003'
                  LET g_errparam.extend = g_inaa_m.inaa001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_inaa_m.inaa007 = g_inaa_m_t.inaa007
                  NEXT FIELD CURRENT
               END IF
            END IF
            IF g_inaa_m.inaa007 = '5' THEN
               LET l_allow_insert = FALSE
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa007
            #add-point:ON CHANGE inaa007 name="input.g.inaa007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa008
            #add-point:BEFORE FIELD inaa008 name="input.b.inaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa008
            
            #add-point:AFTER FIELD inaa008 name="input.a.inaa008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa008
            #add-point:ON CHANGE inaa008 name="input.g.inaa008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa009
            #add-point:BEFORE FIELD inaa009 name="input.b.inaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa009
            
            #add-point:AFTER FIELD inaa009 name="input.a.inaa009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa009
            #add-point:ON CHANGE inaa009 name="input.g.inaa009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa010
            #add-point:BEFORE FIELD inaa010 name="input.b.inaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa010
            
            #add-point:AFTER FIELD inaa010 name="input.a.inaa010"
            IF g_inaa_m.inaa010 != g_inaa_m_t.inaa010 AND g_inaa_m.inaa010 = 'N' THEN
               LET l_n1 = 0
               LET l_n2 = 0
               SELECT COUNT(*) INTO l_n1 FROM xcck_t WHERE xcckent = g_enterprise AND xccksite = g_site AND xcck015 = g_inaa_m.inaa001 AND xcckstus <>'X'
               SELECT COUNT(*) INTO l_n2 FROM inaj_t WHERE inajent = g_enterprise AND inajsite = g_site AND inaj008 = g_inaa_m.inaa001
               #该库位已存在库存交易明细且已经结算过成本，不可改为非成本库！
               IF l_n1 > 0 AND l_n2 > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00506'
                  LET g_errparam.extend = g_inaa_m.inaa001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_inaa_m.inaa010 = g_inaa_m_t.inaa010
                  NEXT FIELD inaa010
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa010
            #add-point:ON CHANGE inaa010 name="input.g.inaa010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa014
            #add-point:BEFORE FIELD inaa014 name="input.b.inaa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa014
            
            #add-point:AFTER FIELD inaa014 name="input.a.inaa014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa014
            #add-point:ON CHANGE inaa014 name="input.g.inaa014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa015
            #add-point:BEFORE FIELD inaa015 name="input.b.inaa015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa015
            
            #add-point:AFTER FIELD inaa015 name="input.a.inaa015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa015
            #add-point:ON CHANGE inaa015 name="input.g.inaa015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa011
            #add-point:BEFORE FIELD inaa011 name="input.b.inaa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa011
            
            #add-point:AFTER FIELD inaa011 name="input.a.inaa011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa011
            #add-point:ON CHANGE inaa011 name="input.g.inaa011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa012
            #add-point:BEFORE FIELD inaa012 name="input.b.inaa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa012
            
            #add-point:AFTER FIELD inaa012 name="input.a.inaa012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa012
            #add-point:ON CHANGE inaa012 name="input.g.inaa012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa013
            #add-point:BEFORE FIELD inaa013 name="input.b.inaa013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa013
            
            #add-point:AFTER FIELD inaa013 name="input.a.inaa013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa013
            #add-point:ON CHANGE inaa013 name="input.g.inaa013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaastus
            #add-point:BEFORE FIELD inaastus name="input.b.inaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaastus
            
            #add-point:AFTER FIELD inaastus name="input.a.inaastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaastus
            #add-point:ON CHANGE inaastus name="input.g.inaastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.inaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa001
            #add-point:ON ACTION controlp INFIELD inaa001 name="input.c.inaa001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inaa_m.inaa001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inay001()                                #呼叫開窗

            LET g_inaa_m.inaa001 = g_qryparam.return1              

            DISPLAY g_inaa_m.inaa001 TO inaa001              #
           
            CALL aini002_inaa001_desc()
                     
            NEXT FIELD inaa001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa005
            #add-point:ON ACTION controlp INFIELD inaa005 name="input.c.inaa005"
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inaa_m.inaa005             #給予default值

            #給予arg

            CALL q_ooea001()                                #呼叫開窗

            LET g_inaa_m.inaa005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_inaa_m.inaa005 TO inaa005              #顯示到畫面上
            CALL aini002_inaa005_ref(g_inaa_m.inaa005) RETURNING g_inaa_m.inaa005_desc
            DISPLAY BY NAME g_inaa_m.inaa005_desc

            NEXT FIELD inaa005                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.inaa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa006
            #add-point:ON ACTION controlp INFIELD inaa006 name="input.c.inaa006"
            
            #END add-point
 
 
         #Ctrlp:input.c.inaa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa007
            #add-point:ON ACTION controlp INFIELD inaa007 name="input.c.inaa007"
            
            #END add-point
 
 
         #Ctrlp:input.c.inaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa008
            #add-point:ON ACTION controlp INFIELD inaa008 name="input.c.inaa008"
            
            #END add-point
 
 
         #Ctrlp:input.c.inaa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa009
            #add-point:ON ACTION controlp INFIELD inaa009 name="input.c.inaa009"
            
            #END add-point
 
 
         #Ctrlp:input.c.inaa010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa010
            #add-point:ON ACTION controlp INFIELD inaa010 name="input.c.inaa010"
            
            #END add-point
 
 
         #Ctrlp:input.c.inaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa014
            #add-point:ON ACTION controlp INFIELD inaa014 name="input.c.inaa014"
            
            #END add-point
 
 
         #Ctrlp:input.c.inaa015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa015
            #add-point:ON ACTION controlp INFIELD inaa015 name="input.c.inaa015"
            
            #END add-point
 
 
         #Ctrlp:input.c.inaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa011
            #add-point:ON ACTION controlp INFIELD inaa011 name="input.c.inaa011"
            
            #END add-point
 
 
         #Ctrlp:input.c.inaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa012
            #add-point:ON ACTION controlp INFIELD inaa012 name="input.c.inaa012"
            
            #END add-point
 
 
         #Ctrlp:input.c.inaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa013
            #add-point:ON ACTION controlp INFIELD inaa013 name="input.c.inaa013"
            
            #END add-point
 
 
         #Ctrlp:input.c.inaastus
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaastus
            #add-point:ON ACTION controlp INFIELD inaastus name="input.c.inaastus"
        
        ON ACTION aooi350_01
            LET g_action_choice="aooi350_01"
            IF cl_auth_chk_act("aooi350_01") THEN 
               LET l_inaa004 = ''
               SELECT inaa004 INTO l_inaa004 FROM inaa_t 
                  WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_m.inaa001
               CALL aooi350_01(l_inaa004)
            END IF

         ON ACTION aooi350_02
            LET g_action_choice="aooi350_02"
            IF cl_auth_chk_act("aooi350_02") THEN 
               LET l_inaa004 = ''
               SELECT inaa004 INTO l_inaa004 FROM inaa_t 
                  WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_m.inaa001
               CALL aooi350_02(l_inaa004)
            END IF
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_inaa_m.inaa001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO inaa_t (inaaent, inaasite,inaa001,inaa005,inaa006,inaa007,inaa008,inaa009, 
                   inaa010,inaa014,inaa015,inaa017,inaa011,inaa012,inaa013,inaastus,inaaownid,inaaowndp, 
                   inaacrtid,inaacrtdp,inaacrtdt,inaamodid,inaamoddt)
               VALUES (g_enterprise, g_site,g_inaa_m.inaa001,g_inaa_m.inaa005,g_inaa_m.inaa006,g_inaa_m.inaa007, 
                   g_inaa_m.inaa008,g_inaa_m.inaa009,g_inaa_m.inaa010,g_inaa_m.inaa014,g_inaa_m.inaa015, 
                   g_inaa_m.inaa017,g_inaa_m.inaa011,g_inaa_m.inaa012,g_inaa_m.inaa013,g_inaa_m.inaastus, 
                   g_inaa_m.inaaownid,g_inaa_m.inaaowndp,g_inaa_m.inaacrtid,g_inaa_m.inaacrtdp,g_inaa_m.inaacrtdt, 
                   g_inaa_m.inaamodid,g_inaa_m.inaamoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_inaa_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               LET l_success = ''
               LET l_inaa004 = ''
               CALL s_aooi350_ins_oofa('8',g_inaa_m.inaa001,'') RETURNING l_success,l_inaa004
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofa_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CONTINUE DIALOG
               ELSE
                  LET l_success = ''
                  #LET l_inaa013 = ''
                  #tag二進制碼初始化
                  #CALL s_aooi310_init_tagb('1') RETURNING l_success,g_inaa_m.inaa013
                  #IF NOT l_success THEN
                  #   CALL cl_err("gen inaa013",SQLCA.sqlcode,1)  
                  #   CONTINUE DIALOG
                  #ELSE
                     UPDATE inaa_t SET inaa004 = l_inaa004,inaa013 = g_inaa_m.inaa013 ,inaa016='N'
                      WHERE inaaent = g_enterprise AND  inaasite = g_site AND inaa001 = g_inaa_m.inaa001
                     IF SQLCA.SQLcode  THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "inaa_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CONTINUE DIALOG
                     END IF
                  #END IF
               END IF
               
               LET l_success = ''
               CALL aini002_inab_insert() RETURNING l_success #新增儲位基本資料
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "inab_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CONTINUE DIALOG
               END IF
               CALL s_transaction_end('Y','0')
               
               LET p_cmd = 'u'
               #新增的時候，儲位管理設為'5'，需重新進入input
               IF g_inaa_m.inaa007 = '5' THEN
                  LET g_flag2 = TRUE
                  EXIT DIALOG
               ELSE
                  LET g_flag2 = FALSE
               END IF
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aini002_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aini002_b_fill()
                  CALL aini002_b_fill2('0')
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
               CALL aini002_inaa_t_mask_restore('restore_mask_o')
               
               UPDATE inaa_t SET (inaa001,inaa005,inaa006,inaa007,inaa008,inaa009,inaa010,inaa014,inaa015, 
                   inaa017,inaa011,inaa012,inaa013,inaastus,inaaownid,inaaowndp,inaacrtid,inaacrtdp, 
                   inaacrtdt,inaamodid,inaamoddt) = (g_inaa_m.inaa001,g_inaa_m.inaa005,g_inaa_m.inaa006, 
                   g_inaa_m.inaa007,g_inaa_m.inaa008,g_inaa_m.inaa009,g_inaa_m.inaa010,g_inaa_m.inaa014, 
                   g_inaa_m.inaa015,g_inaa_m.inaa017,g_inaa_m.inaa011,g_inaa_m.inaa012,g_inaa_m.inaa013, 
                   g_inaa_m.inaastus,g_inaa_m.inaaownid,g_inaa_m.inaaowndp,g_inaa_m.inaacrtid,g_inaa_m.inaacrtdp, 
                   g_inaa_m.inaacrtdt,g_inaa_m.inaamodid,g_inaa_m.inaamoddt)
                WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inaa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aini002_inaa_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_inaa_m_t)
               LET g_log2 = util.JSON.stringify(g_inaa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                  
               IF ((g_inaa_m.inaa006 != g_inaa_m_t.inaa006 OR cl_null(g_inaa_m_t.inaa006)) AND NOT cl_null(g_inaa_m.inaa006)) OR (cl_null(g_inaa_m.inaa006) AND NOT cl_null(g_inaa_m_t.inaa006)) THEN
                  UPDATE inab_t SET (inab005,inabmodid,inabmoddt) = (g_inaa_m.inaa006,g_inaa_m.inaamodid,g_inaa_m.inaamoddt)
                    WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_m.inaa001
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                
                     CALL s_transaction_end('N','0')
                  END IF
                  CALL aini002_b_fill()
               END IF
               IF g_inaa_m.inaa008 != g_inaa_m_t.inaa008 THEN
                  UPDATE inab_t SET (inab006,inabmodid,inabmoddt) = (g_inaa_m.inaa008,g_inaa_m.inaamodid,g_inaa_m.inaamoddt)
                    WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_m.inaa001
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                
                     CALL s_transaction_end('N','0')
                  END IF
                  CALL aini002_b_fill()
               END IF
               IF g_inaa_m.inaa009 != g_inaa_m_t.inaa009 THEN
                  UPDATE inab_t SET (inab007,inabmodid,inabmoddt) = (g_inaa_m.inaa009,g_inaa_m.inaamodid,g_inaa_m.inaamoddt)
                    WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_m.inaa001
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                
                     CALL s_transaction_end('N','0')
                  END IF
                  CALL aini002_b_fill()
               END IF
                  
               UPDATE inag_t SET (inag010,inag011) = (g_inaa_m.inaa008,g_inaa_m.inaa009)
                WHERE inagent = g_enterprise AND inagsite = g_site AND inag004 = g_inaa_m.inaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "inag_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                
                  CALL s_transaction_end('N','0')
               END IF
               
               CALL s_transaction_end('Y','0')
               #修改的時候，儲位管理由其他值改為'5'，需重新進入input
               IF g_inaa_m.inaa007 = '5' AND g_inaa_m.inaa007 <> g_inaa_m_t.inaa007 THEN
                  LET g_flag2 = TRUE
                  EXIT DIALOG
               ELSE
                   LET g_flag2 = FALSE   
               END IF
               #修改的時候，儲位管理由'5'改為其他值，需重新進入input
               IF g_inaa_m_t.inaa007 = '5' AND g_inaa_m.inaa007 <> g_inaa_m_t.inaa007 THEN
                  LET g_flag2 = TRUE
                  EXIT DIALOG
               ELSE
                   LET g_flag2 = FALSE   
               END IF                  
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_inaa001_t = g_inaa_m.inaa001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aini002.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_inab_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inab_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aini002_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_inab_d.getLength()
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
            OPEN aini002_cl USING g_enterprise, g_site,g_inaa_m.inaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aini002_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aini002_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_inab_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_inab_d[l_ac].inab002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_inab_d_t.* = g_inab_d[l_ac].*  #BACKUP
               LET g_inab_d_o.* = g_inab_d[l_ac].*  #BACKUP
               CALL aini002_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aini002_set_no_entry_b(l_cmd)
               IF NOT aini002_lock_b("inab_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aini002_bcl INTO g_inab_d[l_ac].inabstus,g_inab_d[l_ac].inab002,g_inab_d[l_ac].inab003, 
                      g_inab_d[l_ac].inab004,g_inab_d[l_ac].inab005,g_inab_d[l_ac].inab006,g_inab_d[l_ac].inab007, 
                      g_inab_d[l_ac].inab008,g_inab3_d[l_ac].inab002,g_inab3_d[l_ac].inabownid,g_inab3_d[l_ac].inabowndp, 
                      g_inab3_d[l_ac].inabcrtid,g_inab3_d[l_ac].inabcrtdp,g_inab3_d[l_ac].inabcrtdt, 
                      g_inab3_d[l_ac].inabmodid,g_inab3_d[l_ac].inabmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_inab_d_t.inab002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_inab_d_mask_o[l_ac].* =  g_inab_d[l_ac].*
                  CALL aini002_inab_t_mask()
                  LET g_inab_d_mask_n[l_ac].* =  g_inab_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aini002_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF l_cmd = 'a' AND cl_null(g_inab_d[l_ac].inab002) THEN
               NEXT FIELD inab002            
            END IF
            
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
            INITIALIZE g_inab_d[l_ac].* TO NULL 
            INITIALIZE g_inab_d_t.* TO NULL 
            INITIALIZE g_inab_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inab3_d[l_ac].inabownid = g_user
      LET g_inab3_d[l_ac].inabowndp = g_dept
      LET g_inab3_d[l_ac].inabcrtid = g_user
      LET g_inab3_d[l_ac].inabcrtdp = g_dept 
      LET g_inab3_d[l_ac].inabcrtdt = cl_get_current()
      LET g_inab3_d[l_ac].inabmodid = g_user
      LET g_inab3_d[l_ac].inabmoddt = cl_get_current()
      LET g_inab_d[l_ac].inabstus = 'Y'
 
 
 
            #自定義預設值
                  LET g_inab_d[l_ac].inabstus = "Y"
      LET g_inab_d[l_ac].inab006 = "Y"
      LET g_inab_d[l_ac].inab007 = "Y"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #161231-00011#1 add   --begin--
            LET g_inab_d[l_ac].inab006 = g_inaa_m.inaa008
            LET g_inab_d[l_ac].inab007 = g_inaa_m.inaa009
            #161231-00011#1 add   --end--
            #end add-point
            LET g_inab_d_t.* = g_inab_d[l_ac].*     #新輸入資料
            LET g_inab_d_o.* = g_inab_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aini002_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aini002_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inab_d[li_reproduce_target].* = g_inab_d[li_reproduce].*
               LET g_inab3_d[li_reproduce_target].* = g_inab3_d[li_reproduce].*
 
               LET g_inab_d[li_reproduce_target].inab002 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_inab_d[l_ac].inabstus = "Y"
             CALL s_aooi310_init_tagb('1') RETURNING l_success,g_inab_d[l_ac].inab008
             CALL g_inab3_d.clear()
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
            SELECT COUNT(1) INTO l_count FROM inab_t 
             WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_m.inaa001
 
               AND inab002 = g_inab_d[l_ac].inab002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_m.inaa001
               LET gs_keys[2] = g_inab_d[g_detail_idx].inab002
               CALL aini002_insert_b('inab_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_inab_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inab_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aini002_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #產生tag二進制碼
               LET l_success = ''
               CALL aini002_upd_tagb(g_inaa_m.inaa001,g_inab_d[l_ac].inab002) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0') 
               END IF
               DISPLAY BY NAME g_inab_d[l_ac].inab008
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
                        
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM inag_t WHERE inagent = g_enterprise AND inagsite = g_site AND inag004 = g_inaa_m.inaa001 AND inag005 = g_inab_d[l_ac].inab002
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00004'
                  LET g_errparam.extend = g_inab_d[l_ac].inab002
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_inaa_m.inaa001
 
               LET gs_keys[gs_keys.getLength()+1] = g_inab_d_t.inab002
 
            
               #刪除同層單身
               IF NOT aini002_delete_b('inab_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aini002_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aini002_key_delete_b(gs_keys,'inab_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aini002_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aini002_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  DELETE FROM inac_t
                     WHERE inacent = g_enterprise AND inacsite = g_site AND inac001 = g_inaa_m.inaa001 
                       AND inac002 = g_inab_d_t.inab002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE   
                  END IF                     
                  LET l_success = ''
                  CALL aini002_upd_tagb(g_inaa_m.inaa001,g_inab_d_t.inab002) RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0') 
                     CANCEL DELETE 
                  END IF
                  DISPLAY BY NAME g_inab_d[l_ac].inab008
               #end add-point
               LET l_count = g_inab_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_inab_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inabstus
            #add-point:BEFORE FIELD inabstus name="input.b.page1.inabstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inabstus
            
            #add-point:AFTER FIELD inabstus name="input.a.page1.inabstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inabstus
            #add-point:ON CHANGE inabstus name="input.g.page1.inabstus"
            #161212-00043#1  add   --begin--
            IF NOT cl_null(g_inaa_m.inaa001) AND g_inab_d[l_ac].inab002 IS NOT NULL THEN
               IF g_inab_d[l_ac].inabstus = 'N' THEN 
                  LET l_n3 = 0
                  SELECT COUNT(*) INTO l_n3 FROM inag_t WHERE inagent = g_enterprise AND inagsite = g_site
                    AND inag004 = g_inaa_m.inaa001 AND inag005 = g_inab_d[l_ac].inab002 AND (inag008 <> 0)
                  IF l_n3 > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00865'
                     LET g_errparam.extend = g_inab_d[l_ac].inab002
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET g_inab_d[l_ac].inabstus = g_inab_d_t.inabstus
                     NEXT FIELD inabstus
                  END IF
               END IF
            END IF
            #161212-00043#1  add   --end--
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab002
            #add-point:BEFORE FIELD inab002 name="input.b.page1.inab002"
            LET g_inab_d_t.inab002 = g_inab_d[l_ac].inab002
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab002
            
            #add-point:AFTER FIELD inab002 name="input.a.page1.inab002"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_inaa_m.inaa001) AND g_inab_d[l_ac].inab002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_inaa_m.inaa001 != g_inaa001_t OR g_inab_d[l_ac].inab002 != g_inab_d_t.inab002))) THEN 
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM inag_t WHERE inagent = g_enterprise AND inagsite = g_site AND inag004 = g_inaa_m.inaa001 AND inag005 = g_inab_d[l_ac].inab002
                  IF l_n > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00004'
                     LET g_errparam.extend = g_inab_d[l_ac].inab002
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     LET g_inab_d[l_ac].inab002 = g_inab_d_t.inab002
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inab_t WHERE "||"inabent = '" ||g_enterprise|| "' AND inabsite = '" ||g_site|| "' AND "||"inab001 = '"||g_site ||"' AND "|| "inabsite = '"||g_inaa_m.inaa001 ||"' AND "|| "inab002 = '"||g_inab_d[l_ac].inab002 ||"'",'std-00004',0) THEN 
                     LET g_inab_d[l_ac].inab002 = g_inab_d_t.inab002
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT aini002_inab002_chk(g_inab_d[l_ac].inab002) THEN
                     LET g_inab_d[l_ac].inab002 = g_inab_d_t.inab002
                     NEXT FIELD CURRENT
                  END IF         
               END IF  
               IF l_cmd = 'a' THEN
                  IF g_inab_d[l_ac].inab002 != g_inab_d_t.inab002 AND NOT cl_null(g_inab_d_t.inab002) THEN
                     DELETE FROM inac_t WHERE inacent = g_enterprise AND inac001 = g_inaa_m.inaa001 AND inac002 = g_inab_d_t.inab002
                  END IF
                  CALL aini002_inac_init(g_inaa_m.inaa001,g_inab_d[l_ac].inab002) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_inab_d[l_ac].inab002 = g_inab_d_t.inab002
                     NEXT FIELD CURRENT
                  END IF
                  
                  #更新当前储位的tag二进位码
                  LET g_inab_d[l_ac].inab008 = g_inaa_m.inaa013
                  CALL aini002_inac_fill()
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inab002
            #add-point:ON CHANGE inab002 name="input.g.page1.inab002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab003
            #add-point:BEFORE FIELD inab003 name="input.b.page1.inab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab003
            
            #add-point:AFTER FIELD inab003 name="input.a.page1.inab003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inab003
            #add-point:ON CHANGE inab003 name="input.g.page1.inab003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab004
            #add-point:BEFORE FIELD inab004 name="input.b.page1.inab004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab004
            
            #add-point:AFTER FIELD inab004 name="input.a.page1.inab004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inab004
            #add-point:ON CHANGE inab004 name="input.g.page1.inab004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab005
            #add-point:BEFORE FIELD inab005 name="input.b.page1.inab005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab005
            
            #add-point:AFTER FIELD inab005 name="input.a.page1.inab005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inab005
            #add-point:ON CHANGE inab005 name="input.g.page1.inab005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab006
            #add-point:BEFORE FIELD inab006 name="input.b.page1.inab006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab006
            
            #add-point:AFTER FIELD inab006 name="input.a.page1.inab006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inab006
            #add-point:ON CHANGE inab006 name="input.g.page1.inab006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab007
            #add-point:BEFORE FIELD inab007 name="input.b.page1.inab007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab007
            
            #add-point:AFTER FIELD inab007 name="input.a.page1.inab007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inab007
            #add-point:ON CHANGE inab007 name="input.g.page1.inab007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab008
            #add-point:BEFORE FIELD inab008 name="input.b.page1.inab008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab008
            
            #add-point:AFTER FIELD inab008 name="input.a.page1.inab008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inab008
            #add-point:ON CHANGE inab008 name="input.g.page1.inab008"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.inabstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inabstus
            #add-point:ON ACTION controlp INFIELD inabstus name="input.c.page1.inabstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inab002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab002
            #add-point:ON ACTION controlp INFIELD inab002 name="input.c.page1.inab002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inab_d[l_ac].inab002            #給予default值

            #輸入的庫位在[T:庫位基本資料檔].[C:儲位管理]='3'(依供應商編號)
            #則輸入的儲位編號必須存在[T:交易對象主檔]中，且[T:交易對象主檔].[C:交易對象類型]='1' or '3' 
            IF g_inaa_m.inaa007 = '3' THEN
               #LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 ='3') "   #160913-00055#2
               CALL q_pmaa001()
               LET g_inab_d[l_ac].inab002 = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_inab_d[l_ac].inab002 TO inab002
            END IF
            
            #輸入的庫位在[T:庫位基本資料檔].[C:儲位管理]='4'(依客戶編號)
            #則輸入的儲位編號必須存在[T:交易對象主檔]中，且[T:交易對象主檔].[C:交易對象類型]='2' or '3'
            IF g_inaa_m.inaa007 = '4' THEN
               #LET g_qryparam.where = " (pmaa002 = '2' OR pmaa002 ='3') "    #160913-00055#2
               #CALL q_pmaa001()   #160913-00055#2
               CALL q_pmaa001_13() #160913-00055#2
               LET g_inab_d[l_ac].inab002 = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_inab_d[l_ac].inab002 TO inab002
            END IF       
 
            NEXT FIELD inab002
            #END add-point
 
 
         #Ctrlp:input.c.page1.inab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab003
            #add-point:ON ACTION controlp INFIELD inab003 name="input.c.page1.inab003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inab004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab004
            #add-point:ON ACTION controlp INFIELD inab004 name="input.c.page1.inab004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inab005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab005
            #add-point:ON ACTION controlp INFIELD inab005 name="input.c.page1.inab005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inab006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab006
            #add-point:ON ACTION controlp INFIELD inab006 name="input.c.page1.inab006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inab007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab007
            #add-point:ON ACTION controlp INFIELD inab007 name="input.c.page1.inab007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inab008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab008
            #add-point:ON ACTION controlp INFIELD inab008 name="input.c.page1.inab008"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_inab_d[l_ac].* = g_inab_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aini002_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_inab_d[l_ac].inab002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_inab_d[l_ac].* = g_inab_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               #161212-00043#1 add  --begin--
               IF NOT cl_null(g_inaa_m.inaa001) AND g_inab_d[l_ac].inab002 IS NOT NULL THEN
                  IF g_inab_d[l_ac].inabstus = 'N' THEN 
                     LET l_n3 = 0
                     SELECT COUNT(*) INTO l_n3 FROM inag_t WHERE inagent = g_enterprise AND inagsite = g_site
                       AND inag004 = g_inaa_m.inaa001 AND inag005 = g_inab_d[l_ac].inab002 AND (inag008 <> 0)
                     IF l_n3 > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ain-00865'
                        LET g_errparam.extend = g_inab_d[l_ac].inab002
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                        LET g_inab_d[l_ac].inabstus = g_inab_d_t.inabstus
                        NEXT FIELD inabstus
                     END IF
                  END IF
               END IF
               #161212-00043#1 add  --end--
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               LET g_inab3_d[l_ac].inabmodid = g_user 
LET g_inab3_d[l_ac].inabmoddt = cl_get_current()
LET g_inab3_d[l_ac].inabmodid_desc = cl_get_username(g_inab3_d[l_ac].inabmodid)
      
               #將遮罩欄位還原
               CALL aini002_inab_t_mask_restore('restore_mask_o')
      
               UPDATE inab_t SET (inab001,inabstus,inab002,inab003,inab004,inab005,inab006,inab007,inab008, 
                   inabownid,inabowndp,inabcrtid,inabcrtdp,inabcrtdt,inabmodid,inabmoddt) = (g_inaa_m.inaa001, 
                   g_inab_d[l_ac].inabstus,g_inab_d[l_ac].inab002,g_inab_d[l_ac].inab003,g_inab_d[l_ac].inab004, 
                   g_inab_d[l_ac].inab005,g_inab_d[l_ac].inab006,g_inab_d[l_ac].inab007,g_inab_d[l_ac].inab008, 
                   g_inab3_d[l_ac].inabownid,g_inab3_d[l_ac].inabowndp,g_inab3_d[l_ac].inabcrtid,g_inab3_d[l_ac].inabcrtdp, 
                   g_inab3_d[l_ac].inabcrtdt,g_inab3_d[l_ac].inabmodid,g_inab3_d[l_ac].inabmoddt)
                WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_m.inaa001 
 
                  AND inab002 = g_inab_d_t.inab002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_inab_d[l_ac].* = g_inab_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inab_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_inab_d[l_ac].* = g_inab_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inab_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_m.inaa001
               LET gs_keys_bak[1] = g_inaa001_t
               LET gs_keys[2] = g_inab_d[g_detail_idx].inab002
               LET gs_keys_bak[2] = g_inab_d_t.inab002
               CALL aini002_update_b('inab_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aini002_inab_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_inab_d[g_detail_idx].inab002 = g_inab_d_t.inab002 
 
                  ) THEN
                  LET gs_keys[01] = g_inaa_m.inaa001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_inab_d_t.inab002
 
                  CALL aini002_key_update_b(gs_keys,'inab_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_inaa_m),util.JSON.stringify(g_inab_d_t)
               LET g_log2 = util.JSON.stringify(g_inaa_m),util.JSON.stringify(g_inab_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               UPDATE inag_t SET (inag010,inag011) = (g_inab_d[l_ac].inab006,g_inab_d[l_ac].inab007)
                WHERE inagent = g_enterprise AND inagsite = g_site 
                  AND inag004 = g_inaa_m.inaa001 AND inag005 = g_inab_d[l_ac].inab002
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "inag_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  CALL s_transaction_end('N','0')
               END IF
               LET l_success = ''
               CALL aini002_upd_tagb(g_inaa_m.inaa001,g_inab_d[l_ac].inab002) RETURNING l_success
               IF NOT l_success THEN
                  LET g_inab_d[l_ac].* = g_inab_d_t.*
                  CALL s_transaction_end('N','0') 
               ELSE
                  #當儲位為' '時，揀貨優先序、庫存可用否、MRP可用否有修改時，單頭及單身所有資料都要一併更新
                  IF g_inab_d[l_ac].inab002 = ' ' THEN
                     IF (g_inab_d[l_ac].inab005 != g_inab_d_t.inab005 OR cl_null(g_inab_d_t.inab005)) OR (cl_null(g_inab_d[l_ac].inab005 AND NOT cl_null(g_inab_d_t.inab005))) THEN
                        UPDATE inaa_t SET inaa006 = g_inab_d[l_ac].inab005 WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_m.inaa001
                        IF SQLCA.SQLcode  THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "inaa_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
  
                           LET g_inab_d[l_ac].* = g_inab_d_t.*
                           CALL s_transaction_end('N','0') 
                        END IF
                        UPDATE inab_t SET inab005 = g_inab_d[l_ac].inab005 WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_m.inaa001
                        IF SQLCA.SQLcode  THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "inab_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
 
                           LET g_inab_d[l_ac].* = g_inab_d_t.*                 
                           CALL s_transaction_end('N','0') 
                        END IF
                     END IF
                     IF g_inab_d[l_ac].inab006 != g_inab_d_t.inab006 THEN
                        UPDATE inaa_t SET inaa008 = g_inab_d[l_ac].inab006 WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_m.inaa001
                        IF SQLCA.SQLcode  THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "inaa_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
  
                           LET g_inab_d[l_ac].* = g_inab_d_t.*
                           CALL s_transaction_end('N','0') 
                        END IF
                        UPDATE inab_t SET inab006 = g_inab_d[l_ac].inab006 WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_m.inaa001
                        IF SQLCA.SQLcode  THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "inab_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
 
                           LET g_inab_d[l_ac].* = g_inab_d_t.*                 
                           CALL s_transaction_end('N','0') 
                        END IF
                     END IF
                     IF g_inab_d[l_ac].inab007 != g_inab_d_t.inab007 THEN
                        UPDATE inaa_t SET inaa009 = g_inab_d[l_ac].inab007 WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_m.inaa001
                        IF SQLCA.SQLcode  THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "inaa_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
  
                           LET g_inab_d[l_ac].* = g_inab_d_t.*
                           CALL s_transaction_end('N','0') 
                        END IF
                        UPDATE inab_t SET inab007 = g_inab_d[l_ac].inab007 WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_m.inaa001
                        IF SQLCA.SQLcode  THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "inab_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
 
                           LET g_inab_d[l_ac].* = g_inab_d_t.*                 
                           CALL s_transaction_end('N','0') 
                        END IF
                     END IF
                  END IF
               END IF
               #CALL aini002_show()
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aini002_unlock_b("inab_t","'1'")
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
               LET g_inab_d[li_reproduce_target].* = g_inab_d[li_reproduce].*
               LET g_inab3_d[li_reproduce_target].* = g_inab3_d[li_reproduce].*
 
               LET g_inab_d[li_reproduce_target].inab002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_inab_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_inab_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_inab3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            
            CALL aini002_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_inab3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_inab3_d[l_ac].* TO NULL 
            INITIALIZE g_inab3_d_t.* TO NULL 
            INITIALIZE g_inab3_d_o.* TO NULL 
            #公用欄位給值(單身2)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inab3_d[l_ac].inabownid = g_user
      LET g_inab3_d[l_ac].inabowndp = g_dept
      LET g_inab3_d[l_ac].inabcrtid = g_user
      LET g_inab3_d[l_ac].inabcrtdp = g_dept 
      LET g_inab3_d[l_ac].inabcrtdt = cl_get_current()
      LET g_inab3_d[l_ac].inabmodid = g_user
      LET g_inab3_d[l_ac].inabmoddt = cl_get_current()
      LET g_inab_d[l_ac].inabstus = 'Y'
 
 
 
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_inab3_d_t.* = g_inab3_d[l_ac].*     #新輸入資料
            LET g_inab3_d_o.* = g_inab3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aini002_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL aini002_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inab_d[li_reproduce_target].* = g_inab_d[li_reproduce].*
               LET g_inab3_d[li_reproduce_target].* = g_inab3_d[li_reproduce].*
 
               LET g_inab3_d[li_reproduce_target].inab002 = NULL
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
            OPEN aini002_cl USING g_enterprise, g_site,g_inaa_m.inaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aini002_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aini002_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_inab3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_inab3_d[l_ac].inab002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_inab3_d_t.* = g_inab3_d[l_ac].*  #BACKUP
               LET g_inab3_d_o.* = g_inab3_d[l_ac].*  #BACKUP
               CALL aini002_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL aini002_set_no_entry_b(l_cmd)
               IF NOT aini002_lock_b("inab_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aini002_bcl INTO g_inab_d[l_ac].inabstus,g_inab_d[l_ac].inab002,g_inab_d[l_ac].inab003, 
                      g_inab_d[l_ac].inab004,g_inab_d[l_ac].inab005,g_inab_d[l_ac].inab006,g_inab_d[l_ac].inab007, 
                      g_inab_d[l_ac].inab008,g_inab3_d[l_ac].inab002,g_inab3_d[l_ac].inabownid,g_inab3_d[l_ac].inabowndp, 
                      g_inab3_d[l_ac].inabcrtid,g_inab3_d[l_ac].inabcrtdp,g_inab3_d[l_ac].inabcrtdt, 
                      g_inab3_d[l_ac].inabmodid,g_inab3_d[l_ac].inabmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_inab3_d_mask_o[l_ac].* =  g_inab3_d[l_ac].*
                  CALL aini002_inab_t_mask()
                  LET g_inab3_d_mask_n[l_ac].* =  g_inab3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aini002_show()
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
               LET gs_keys[01] = g_inaa_m.inaa001
               LET gs_keys[gs_keys.getLength()+1] = g_inab3_d_t.inab002
            
               #刪除同層單身
               IF NOT aini002_delete_b('inab_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aini002_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aini002_key_delete_b(gs_keys,'inab_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aini002_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身2刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aini002_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_inab_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_inab3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM inab_t 
             WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_m.inaa001
               AND inab002 = g_inab3_d[l_ac].inab002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_m.inaa001
               LET gs_keys[2] = g_inab3_d[g_detail_idx].inab002
               CALL aini002_insert_b('inab_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_inab_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "inab_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aini002_b_fill()
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
               LET g_inab3_d[l_ac].* = g_inab3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aini002_bcl
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
               LET g_inab3_d[l_ac].* = g_inab3_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               LET g_inab3_d[l_ac].inabmodid = g_user 
LET g_inab3_d[l_ac].inabmoddt = cl_get_current()
LET g_inab3_d[l_ac].inabmodid_desc = cl_get_username(g_inab3_d[l_ac].inabmodid)
               
               #將遮罩欄位還原
               CALL aini002_inab_t_mask_restore('restore_mask_o')
                              
               UPDATE inab_t SET (inab001,inabstus,inab002,inab003,inab004,inab005,inab006,inab007,inab008, 
                   inabownid,inabowndp,inabcrtid,inabcrtdp,inabcrtdt,inabmodid,inabmoddt) = (g_inaa_m.inaa001, 
                   g_inab_d[l_ac].inabstus,g_inab_d[l_ac].inab002,g_inab_d[l_ac].inab003,g_inab_d[l_ac].inab004, 
                   g_inab_d[l_ac].inab005,g_inab_d[l_ac].inab006,g_inab_d[l_ac].inab007,g_inab_d[l_ac].inab008, 
                   g_inab3_d[l_ac].inabownid,g_inab3_d[l_ac].inabowndp,g_inab3_d[l_ac].inabcrtid,g_inab3_d[l_ac].inabcrtdp, 
                   g_inab3_d[l_ac].inabcrtdt,g_inab3_d[l_ac].inabmodid,g_inab3_d[l_ac].inabmoddt) #自訂欄位頁簽 
 
                WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_m.inaa001
                  AND inab002 = g_inab3_d_t.inab002 #項次 
                  
               #add-point:單身page2修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_inab3_d[l_ac].* = g_inab3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inab_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_inab3_d[l_ac].* = g_inab3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inab_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_m.inaa001
               LET gs_keys_bak[1] = g_inaa001_t
               LET gs_keys[2] = g_inab3_d[g_detail_idx].inab002
               LET gs_keys_bak[2] = g_inab3_d_t.inab002
               CALL aini002_update_b('inab_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aini002_inab_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_inab3_d[g_detail_idx].inab002 = g_inab3_d_t.inab002 
                  ) THEN
                  LET gs_keys[01] = g_inaa_m.inaa001
                  LET gs_keys[gs_keys.getLength()+1] = g_inab3_d_t.inab002
                  CALL aini002_key_update_b(gs_keys,'inab_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_inaa_m),util.JSON.stringify(g_inab3_d_t)
               LET g_log2 = util.JSON.stringify(g_inaa_m),util.JSON.stringify(g_inab3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inab002_2
            #add-point:BEFORE FIELD inab002_2 name="input.b.page3.inab002_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inab002_2
            
            #add-point:AFTER FIELD inab002_2 name="input.a.page3.inab002_2"
            #此段落由子樣板a05產生
            IF  g_inaa_m.inaa001 IS NOT NULL AND g_inab3_d[g_detail_idx].inab002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inaa_m.inaa001 != g_inaa001_t OR g_inab3_d[g_detail_idx].inab002 != g_inab3_d_t.inab002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inab_t WHERE "||"inabent = '" ||g_enterprise|| "' AND inabsite = '" ||g_site|| "' AND "||"inab001 = '"||g_inaa_m.inaa001 ||"' AND "|| "inab002 = '"||g_inab3_d[g_detail_idx].inab002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inab002_2
            #add-point:ON CHANGE inab002_2 name="input.g.page3.inab002_2"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.inab002_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inab002_2
            #add-point:ON ACTION controlp INFIELD inab002_2 name="input.c.page3.inab002_2"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_inab3_d[l_ac].* = g_inab3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aini002_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aini002_unlock_b("inab_t","'2'")
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
               LET g_inab_d[li_reproduce_target].* = g_inab_d[li_reproduce].*
               LET g_inab3_d[li_reproduce_target].* = g_inab3_d[li_reproduce].*
 
               LET g_inab3_d[li_reproduce_target].inab002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_inab3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_inab3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aini002.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      INPUT ARRAY g_inab2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert2, #此頁面insert功能由產生器控制, 手動之設定無效!
                 DELETE ROW = l_allow_delete2,
                 APPEND ROW = l_allow_insert2)
                 
     
         BEFORE INPUT
           IF l_ac < 1 OR cl_null(l_ac) THEN
              RETURN
           END IF
           IF cl_null(g_inab_d[l_ac].inab002) THEN
              NEXT FIELD inab002
           END IF
           
           IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inab2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
           LET g_detail_cnt = g_inab2_d.getLength()
           
            
         BEFORE INSERT
            
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_inab2_d[l_ac2].* TO NULL 
            
            LET g_inab2_d_t.* = g_inab2_d[l_ac2].*     #新輸入資料
            CALL cl_show_fld_cont()
            
         BEFORE ROW 
            LET p_cmd = ''
            LET l_ac2 = ARR_CURR()
            LET g_detail_idx2 = l_ac2
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_inab3_d.getLength()
            
            IF g_detail_cnt >= l_ac2 
               AND NOT cl_null(g_inab2_d[l_ac2].inac003) 
               AND g_inab_d[l_ac].inab002 IS NOT NULL
               AND NOT cl_null(g_inaa_m.inaa001)
            THEN 
               LET l_cmd='u'
               LET g_inab2_d_t.* = g_inab2_d[l_ac2].*  #BACKUP
               OPEN aini002_bcl2 USING g_enterprise, g_site,g_inaa_m.inaa001,g_inab_d[l_ac].inab002,g_inab2_d[l_ac2].inac003

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "aini001_bcl2"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH aini002_bcl2 INTO g_inab2_d[l_ac2].inac003,g_inab2_d[l_ac2].inac003_desc
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  CALL aini002_inac003_ref(g_inab2_d[l_ac2].inac003) RETURNING g_inab2_d[l_ac2].inac003_desc
                  CALL cl_show_fld_cont()
                  #CALL aini002_inac_fill()
               END IF
            ELSE
               LET l_cmd='a'
            END IF

         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac2-1)
               CALL g_inab2_d.deleteElement(l_ac2)
               NEXT FIELD inac003
            END IF
            IF NOT cl_null(g_inab2_d[l_ac2].inac003) THEN
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
               
               DELETE FROM inac_t
                WHERE inacent = g_enterprise AND inacsite = g_site 
                   AND inac001 = g_inaa_m.inaa001
                   AND inac002 = g_inab_d[l_ac].inab002
                   AND inac003 = g_inab2_d_t.inac003

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "inaa_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  #產生tag二進制碼
                  LET l_success = ''
                  #LET l_inaa013 = ''
                  IF l_ac < 1 OR cl_null(l_ac) THEN
                     LET l_inab002 = ' '
                  ELSE
                     LET l_inab002 = g_inab_d[l_ac].inab002
                  END IF
                  #LET l_inab002 = g_inab_d_t.inab002
                  IF cl_null(l_inab002) THEN
                     LET l_inab002 = ' '
                  END IF
                  CALL aini002_upd_tagb(g_inaa_m.inaa001,l_inab002) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_inab_d[l_ac].* = g_inab_d_t.*
                    CANCEL DELETE 
                  END IF
                  DISPLAY BY NAME g_inab_d[l_ac].inab008
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  CALL s_transaction_end('Y','0')
               END IF 
               #CALL aini002_show()
               CLOSE aini002_bcl2
               LET l_count = g_inab2_d.getLength()
            END IF 

         AFTER INSERT    
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
            SELECT COUNT(*) INTO l_count FROM inac_t 
             WHERE inacent = g_enterprise AND inacsite = g_site 
                   AND inac001 = g_inaa_m.inaa001
                   AND inac002 = g_inab_d[l_ac].inab002
                   AND inac003 = g_inab2_d[l_ac2].inac003

                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
            
               LET l_inaccrtdt = cl_get_current()
               IF l_ac < 1 OR cl_null(l_ac) THEN
                  LET l_inab002 = ' '
               ELSE
                  LET l_inab002 = g_inab_d[l_ac].inab002
               END IF
               #LET l_inab002 = g_inab_d_t.inab002
               IF cl_null(l_inab002) THEN
                  LET l_inab002 = ' '
               END IF
               #IF cl_null(g_inab_d[l_ac].inab002) THEN
               #   LET g_inab_d[l_ac].inab002 = ' '
               #END IF
               INSERT INTO inac_t (inacent,inacsite,inac001,inac002,inac003,inacstus,inacownid,inacowndp,inaccrtid,inaccrtdp,inaccrtdt) 
                VALUES (g_enterprise,g_site,g_inaa_m.inaa001,l_inab002,g_inab2_d[l_ac2].inac003,'Y',g_user,g_dept,g_user,g_dept,l_inaccrtdt)

            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_inab2_d[l_ac2].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "inac_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #產生tag二進制碼
               LET l_success = ''
               #LET l_inaa013 = ''
               CALL aini002_upd_tagb(g_inaa_m.inaa001,l_inab002) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0') 
               END IF
               DISPLAY BY NAME g_inab_d[l_ac].inab008
        
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_inab2_d[l_ac2].* = g_inab2_d_t.*
               CLOSE aini002_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_inab2_d[l_ac2].* = g_inab2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身3)
               LET l_inacmoddt = cl_get_current()
               UPDATE inac_t SET (inac003,inacmodid,inacmoddt) = (g_inab2_d[l_ac2].inac003,g_user,l_inacmoddt)
                WHERE inacent = g_enterprise AND inacsite = g_site 
                   AND inac001 = g_inaa_m.inaa001
                   AND inac002 = g_inab_d[l_ac].inab002
                   AND inac003 = g_inab2_d_t.inac003

                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_inab2_d[l_ac2].* = g_inab2_d_t.*
               END IF

               #產生tag二進制碼
               IF l_ac < 1 OR cl_null(l_ac) THEN
                  LET l_inab002 = ' '
               ELSE
                  LET l_inab002 = g_inab_d[l_ac].inab002
               END IF
               #LET l_inab002 = g_inab_d_t.inab002
               IF cl_null(l_inab002) THEN
                  LET l_inab002 = ' '
               END IF
               #IF cl_null(g_inab_d[l_ac].inab002) THEN
               #   LET g_inab_d[l_ac].inab002 = ' '
               #END IF
               LET l_success = ''
               CALL aini002_upd_tagb(g_inaa_m.inaa001,l_inab002) RETURNING l_success
               IF NOT l_success THEN
                  LET g_inab2_d[l_ac2].* = g_inab2_d_t.*
                  CALL s_transaction_end('N','0') 
               END IF
               DISPLAY BY NAME g_inab_d[l_ac].inab008
               #end add-point
            END IF
         

         AFTER FIELD inac003
            CALL aini002_inac003_ref(g_inab2_d[l_ac2].inac003) RETURNING g_inab2_d[l_ac2].inac003_desc
            DISPLAY BY NAME g_inab2_d[l_ac2].inac003_desc

            IF  NOT cl_null(g_inaa_m.inaa001) AND NOT cl_null(g_inab2_d[l_ac2].inac003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inab2_d[l_ac2].inac003 != g_inab2_d_t.inac003)) THEN 
                  IF NOT aini002_inac003_chk(g_inab2_d[l_ac2].inac003) THEN
                     LET g_inab2_d[l_ac2].inac003 = g_inab2_d_t.inac003
                     CALL aini002_inac003_ref(g_inab2_d[l_ac2].inac003) RETURNING g_inab2_d[l_ac2].inac003_desc
                     DISPLAY BY NAME g_inab2_d[l_ac2].inac003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

 
         ON ACTION controlp INFIELD inac003
            #add-point:ON ACTION controlp INFIELD inac003
#此段落由子樣板a07產生            
            #開窗i段
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = "c"
               LET g_qryparam.where = " oocqstus = 'Y' AND oocq002 NOT IN (SELECT inac003 FROM inac_t WHERE inac001 = '",g_inaa_m.inaa001,"' AND inac002 = '",g_inab_d[l_ac].inab002,"') "
            ELSE
               LET g_qryparam.state = "i"
            END IF
            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inab2_d[l_ac2].inac003             #給予default值

            LET g_qryparam.arg1 = "220" #應用分類

            CALL q_oocq002_1()                                #呼叫開窗

            LET g_qryparam.where = " "
            IF l_cmd = 'a' THEN
               LET l_inac003 = g_qryparam.return1              #將開窗取得的值回傳到變數
               IF NOT cl_null(l_inac003) THEN
                  IF l_ac < 1 OR cl_null(l_ac) THEN
                     LET l_inab002 = ' '
                  ELSE
                     LET l_inab002 = g_inab_d[l_ac].inab002
                  END IF
                  #LET l_inab002 = g_inab_d_t.inab002
                  IF cl_null(l_inab002) THEN
                     LET l_inab002 = ' '
                  END IF
                  #IF cl_null(g_inab_d[l_ac].inab002) THEN
                  #   LET g_inab_d[l_ac].inab002 = ' '
                  #END IF
                  CALL aini002_inac_insert(l_inac003,g_inaa_m.inaa001,l_inab002) RETURNING l_success
                  IF l_success THEN
                     CALL aini002_inac_fill()
                     LET g_flag = TRUE
                     EXIT DIALOG
                  ELSE
                     LET g_flag = FALSE
                     NEXT FIELD inac003
                  END IF
               END IF             
            ELSE
               LET g_inab2_d[l_ac2].inac003 = g_qryparam.return1
               DISPLAY g_inab2_d[l_ac2].inac003 TO inac003              #顯示到畫面上
               CALL aini002_inac003_ref(g_inab2_d[l_ac2].inac003) RETURNING g_inab2_d[l_ac2].inac003_desc
               DISPLAY BY NAME g_inab2_d[l_ac2].inac003_desc
               NEXT FIELD inac003
            END IF

         AFTER ROW
            LET l_ac2 = ARR_CURR()
            LET l_ac2_t = l_ac2
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_inab2_d[l_ac2].* = g_inab2_d_t.*
               END IF
               CLOSE aini002_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            CLOSE aini002_bcl2
            CALL s_transaction_end('Y','0')

      END INPUT
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF NOT cl_null(l_ac) AND l_ac > 0 THEN
            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
         END IF
         IF g_flag2 THEN
            LET g_flag2 = FALSE
            NEXT FIELD inab002
         END IF
         IF g_flag THEN
            LET g_flag = FALSE
            NEXT FIELD inac003
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2',"))      
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD inaa001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD inabstus
               WHEN "s_detail3"
                  NEXT FIELD inab002_2
 
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
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
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
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   IF INT_FLAG THEN
      CALL s_transaction_end('N','0')
   END IF
   #判儲位管理是否有其他值改為'5'，，若是，則需重新進入input，儲位管理單身不可新增
   #判儲位管理是否由'5'改為其他值，若是，則需重新進入input，儲位管理單身可新增
   IF g_flag2 THEN  
      CALL aini002_input('u')
   END IF
   IF g_flag THEN  #判斷庫存管理標籤是否新增成功，成功新增，需重新進入input，狀態變為'u'
      CALL aini002_input('u')
   END IF
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aini002.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aini002_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
 
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aini002_b_fill() #單身填充
      CALL aini002_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aini002_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL aini002_inaa005_ref(g_inaa_m.inaa005) RETURNING g_inaa_m.inaa005_desc
   DISPLAY BY NAME g_inaa_m.inaa005_desc
           
           INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inaa_m.inaaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inaa_m.inaaownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inaa_m.inaaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inaa_m.inaaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inaa_m.inaaowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inaa_m.inaaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inaa_m.inaacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inaa_m.inaacrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inaa_m.inaacrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inaa_m.inaacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inaa_m.inaacrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inaa_m.inaacrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inaa_m.inaamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inaa_m.inaamodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inaa_m.inaamodid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_inaa_m_mask_o.* =  g_inaa_m.*
   CALL aini002_inaa_t_mask()
   LET g_inaa_m_mask_n.* =  g_inaa_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_inaa_m.inaa001,g_inaa_m.inaa001_desc,g_inaa_m.inaa001_desc_desc,g_inaa_m.inaa005, 
       g_inaa_m.inaa005_desc,g_inaa_m.inaa006,g_inaa_m.inaa007,g_inaa_m.inaa008,g_inaa_m.inaa009,g_inaa_m.inaa010, 
       g_inaa_m.inaa014,g_inaa_m.inaa015,g_inaa_m.inaa017,g_inaa_m.inaa011,g_inaa_m.inaa012,g_inaa_m.inaa013, 
       g_inaa_m.inaastus,g_inaa_m.inaaownid,g_inaa_m.inaaownid_desc,g_inaa_m.inaaowndp,g_inaa_m.inaaowndp_desc, 
       g_inaa_m.inaacrtid,g_inaa_m.inaacrtid_desc,g_inaa_m.inaacrtdp,g_inaa_m.inaacrtdp_desc,g_inaa_m.inaacrtdt, 
       g_inaa_m.inaamodid,g_inaa_m.inaamodid_desc,g_inaa_m.inaamoddt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inaa_m.inaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_inab_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_inab3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inab3_d[l_ac].inabownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inab3_d[l_ac].inabownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inab3_d[l_ac].inabownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inab3_d[l_ac].inabowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inab3_d[l_ac].inabowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inab3_d[l_ac].inabowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inab3_d[l_ac].inabcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inab3_d[l_ac].inabcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inab3_d[l_ac].inabcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inab3_d[l_ac].inabcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inab3_d[l_ac].inabcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inab3_d[l_ac].inabcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inab3_d[l_ac].inabmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inab3_d[l_ac].inabmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inab3_d[l_ac].inabmodid_desc

      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aini002_detail_show()
 
   #add-point:show段之後 name="show.after"
   IF ARR_CURR() > g_inab_d.getLength() THEN   #防止会有空白行
      LET l_ac = 1
   #ELSE
   #   LET l_ac = ARR_CURR()
   END IF
   IF l_ac < 1 OR cl_null(l_ac) THEN
      LET l_ac = 1
   END IF
   CALL aini002_inac_fill() #單身填充 
   CALL cl_show_fld_cont()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aini002.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aini002_detail_show()
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
 
{<section id="aini002.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aini002_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE inaa_t.inaa001 
   DEFINE l_oldno     LIKE inaa_t.inaa001 
 
   DEFINE l_master    RECORD LIKE inaa_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE inab_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   #DEFINE l_detai2    RECORD LIKE inac_t.*   #161124-00048#3    2016/12/08  By 08734 mark
   #161124-00048#3    2016/12/08  By 08734 add(S)
   DEFINE l_detai2 RECORD  #庫位/儲位庫存標籤檔
       inacent LIKE inac_t.inacent, #企业编号
       inacsite LIKE inac_t.inacsite, #营运据点
       inac001 LIKE inac_t.inac001, #库位编号
       inac002 LIKE inac_t.inac002, #储位编号
       inac003 LIKE inac_t.inac003, #标签编号
       inacstus LIKE inac_t.inacstus, #状态码
       inacownid LIKE inac_t.inacownid, #资料所有者
       inacowndp LIKE inac_t.inacowndp, #资料所有部门
       inaccrtid LIKE inac_t.inaccrtid, #资料录入者
       inaccrtdp LIKE inac_t.inaccrtdp, #资料录入部门
       inaccrtdt LIKE inac_t.inaccrtdt, #资料创建日
       inacmodid LIKE inac_t.inacmodid, #资料更改者
       inacmoddt LIKE inac_t.inacmoddt #最近更改日
END RECORD   
#161124-00048#3    2016/12/08  By 08734 add(E)
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_inaa004   LIKE inaa_t.inaa004
   DEFINE l_n         LIKE type_t.num5
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
   
   IF g_inaa_m.inaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_inaa001_t = g_inaa_m.inaa001
 
    
   LET g_inaa_m.inaa001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inaa_m.inaaownid = g_user
      LET g_inaa_m.inaaowndp = g_dept
      LET g_inaa_m.inaacrtid = g_user
      LET g_inaa_m.inaacrtdp = g_dept 
      LET g_inaa_m.inaacrtdt = cl_get_current()
      LET g_inaa_m.inaamodid = g_user
      LET g_inaa_m.inaamoddt = cl_get_current()
      LET g_inaa_m.inaastus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inaa_m.inaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_inaa_m.inaa001_desc = ''
   DISPLAY BY NAME g_inaa_m.inaa001_desc
   LET g_inaa_m.inaa001_desc_desc = ''
   DISPLAY BY NAME g_inaa_m.inaa001_desc_desc
 
   
   CALL aini002_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_inaa_m.* TO NULL
      INITIALIZE g_inab_d TO NULL
      INITIALIZE g_inab3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aini002_show()
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
   CALL aini002_set_act_visible()   
   CALL aini002_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_inaa001_t = g_inaa_m.inaa001
 
   
   #組合新增資料的條件
   LET g_add_browse = " inaaent = " ||g_enterprise|| " AND inaasite = '" ||g_site|| "' AND",
                      " inaa001 = '", g_inaa_m.inaa001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aini002_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aini002_idx_chk()
   
   LET g_data_owner = g_inaa_m.inaaownid      
   LET g_data_dept  = g_inaa_m.inaaowndp
   
   #功能已完成,通報訊息中心
   CALL aini002_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aini002.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aini002_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE inab_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aini002_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM inab_t
    WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa001_t
 
    INTO TEMP aini002_detail
 
   #將key修正為調整後   
   UPDATE aini002_detail 
      #更新key欄位
      SET inab001 = g_inaa_m.inaa001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , inabownid = g_user 
       , inabowndp = g_dept
       , inabcrtid = g_user
       , inabcrtdp = g_dept 
       , inabcrtdt = ld_date
       , inabmodid = g_user
       , inabmoddt = ld_date
      #, inabstus = "Y" 
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO inab_t SELECT * FROM aini002_detail
   
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
   DROP TABLE aini002_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_inaa001_t = g_inaa_m.inaa001
 
   
END FUNCTION
 
{</section>}
 
{<section id="aini002.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aini002_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_success       LIKE type_t.num5
   DEFINE l_n        LIKE type_t.num5
   DEFINE l_inaa004  LIKE inaa_t.inaa004
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_inaa_m.inaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aini002_cl USING g_enterprise, g_site,g_inaa_m.inaa001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aini002_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aini002_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aini002_master_referesh USING g_site,g_inaa_m.inaa001 INTO g_inaa_m.inaa001,g_inaa_m.inaa005, 
       g_inaa_m.inaa006,g_inaa_m.inaa007,g_inaa_m.inaa008,g_inaa_m.inaa009,g_inaa_m.inaa010,g_inaa_m.inaa014, 
       g_inaa_m.inaa015,g_inaa_m.inaa017,g_inaa_m.inaa011,g_inaa_m.inaa012,g_inaa_m.inaa013,g_inaa_m.inaastus, 
       g_inaa_m.inaaownid,g_inaa_m.inaaowndp,g_inaa_m.inaacrtid,g_inaa_m.inaacrtdp,g_inaa_m.inaacrtdt, 
       g_inaa_m.inaamodid,g_inaa_m.inaamoddt,g_inaa_m.inaa001_desc,g_inaa_m.inaa001_desc_desc,g_inaa_m.inaa005_desc, 
       g_inaa_m.inaaownid_desc,g_inaa_m.inaaowndp_desc,g_inaa_m.inaacrtid_desc,g_inaa_m.inaacrtdp_desc, 
       g_inaa_m.inaamodid_desc
   
   
   #檢查是否允許此動作
   IF NOT aini002_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_inaa_m_mask_o.* =  g_inaa_m.*
   CALL aini002_inaa_t_mask()
   LET g_inaa_m_mask_n.* =  g_inaa_m.*
   
   CALL aini002_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM inag_t WHERE inagent = g_enterprise AND inagsite = g_site AND inag004 = g_inaa_m.inaa001
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00001'
         LET g_errparam.extend = g_inaa_m.inaa001
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN
      END IF
      
      LET l_inaa004 = ''
      SELECT inaa004 INTO l_inaa004 FROM inaa_t 
        WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_m.inaa001

      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aini002_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_inaa001_t = g_inaa_m.inaa001
 
 
      DELETE FROM inaa_t
       WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_m.inaa001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_inaa_m.inaa001,":",SQLERRMESSAGE  
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
      
      DELETE FROM inab_t
       WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_m.inaa001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      LET l_success = ''
      IF NOT cl_null(l_inaa004) THEN
         CALL s_aooi350_del(l_inaa004) RETURNING l_success
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "oofa_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      
      DELETE FROM inac_t
       WHERE inacent = g_enterprise AND inacsite = g_site AND inac001 = g_inaa_m.inaa001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "inac_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      CALL g_inab2_d.clear() 
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_inaa_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aini002_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_inab_d.clear() 
      CALL g_inab3_d.clear()       
 
     
      CALL aini002_ui_browser_refresh()  
      #CALL aini002_ui_headershow()  
      #CALL aini002_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aini002_browser_fill("")
         CALL aini002_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aini002_cl
 
   #功能已完成,通報訊息中心
   CALL aini002_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aini002.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aini002_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_inab_d.clear()
   CALL g_inab3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_inab2_d.clear()
   #end add-point
   
   #判斷是否填充
   IF aini002_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT inabstus,inab002,inab003,inab004,inab005,inab006,inab007,inab008, 
             inab002,inabownid,inabowndp,inabcrtid,inabcrtdp,inabcrtdt,inabmodid,inabmoddt ,t1.ooag011 , 
             t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM inab_t",   
                     " INNER JOIN inaa_t ON inaaent = " ||g_enterprise|| " AND inaasite = '" ||g_site|| "' AND inaa001 = inab001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=inabownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=inabowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=inabcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=inabcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=inabmodid  ",
 
                     " WHERE inabent=? AND inabsite=? AND inab001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         #儲位空格的那筆資料不顯示
         LET g_sql = g_sql CLIPPED, " AND inab002 <> ' ' "  #add by lixiang 2015/07/09
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY inab_t.inab002"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aini002_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aini002_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise, g_site,g_inaa_m.inaa001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise, g_site,g_inaa_m.inaa001 INTO g_inab_d[l_ac].inabstus,g_inab_d[l_ac].inab002, 
          g_inab_d[l_ac].inab003,g_inab_d[l_ac].inab004,g_inab_d[l_ac].inab005,g_inab_d[l_ac].inab006, 
          g_inab_d[l_ac].inab007,g_inab_d[l_ac].inab008,g_inab3_d[l_ac].inab002,g_inab3_d[l_ac].inabownid, 
          g_inab3_d[l_ac].inabowndp,g_inab3_d[l_ac].inabcrtid,g_inab3_d[l_ac].inabcrtdp,g_inab3_d[l_ac].inabcrtdt, 
          g_inab3_d[l_ac].inabmodid,g_inab3_d[l_ac].inabmoddt,g_inab3_d[l_ac].inabownid_desc,g_inab3_d[l_ac].inabowndp_desc, 
          g_inab3_d[l_ac].inabcrtid_desc,g_inab3_d[l_ac].inabcrtdp_desc,g_inab3_d[l_ac].inabmodid_desc  
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
   
   CALL g_inab_d.deleteElement(g_inab_d.getLength())
   CALL g_inab3_d.deleteElement(g_inab3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aini002_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_inab_d.getLength()
      LET g_inab_d_mask_o[l_ac].* =  g_inab_d[l_ac].*
      CALL aini002_inab_t_mask()
      LET g_inab_d_mask_n[l_ac].* =  g_inab_d[l_ac].*
   END FOR
   
   LET g_inab3_d_mask_o.* =  g_inab3_d.*
   FOR l_ac = 1 TO g_inab3_d.getLength()
      LET g_inab3_d_mask_o[l_ac].* =  g_inab3_d[l_ac].*
      CALL aini002_inab_t_mask()
      LET g_inab3_d_mask_n[l_ac].* =  g_inab3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aini002.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aini002_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM inab_t
       WHERE inabent = g_enterprise AND inabsite = g_site AND
         inab001 = ps_keys_bak[1] AND inab002 = ps_keys_bak[2]
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
         CALL g_inab_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_inab3_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aini002.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aini002_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO inab_t
                  (inabent, inabsite,
                   inab001,
                   inab002
                   ,inabstus,inab003,inab004,inab005,inab006,inab007,inab008,inabownid,inabowndp,inabcrtid,inabcrtdp,inabcrtdt,inabmodid,inabmoddt) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2]
                   ,g_inab_d[g_detail_idx].inabstus,g_inab_d[g_detail_idx].inab003,g_inab_d[g_detail_idx].inab004, 
                       g_inab_d[g_detail_idx].inab005,g_inab_d[g_detail_idx].inab006,g_inab_d[g_detail_idx].inab007, 
                       g_inab_d[g_detail_idx].inab008,g_inab3_d[g_detail_idx].inabownid,g_inab3_d[g_detail_idx].inabowndp, 
                       g_inab3_d[g_detail_idx].inabcrtid,g_inab3_d[g_detail_idx].inabcrtdp,g_inab3_d[g_detail_idx].inabcrtdt, 
                       g_inab3_d[g_detail_idx].inabmodid,g_inab3_d[g_detail_idx].inabmoddt)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_inab_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_inab3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aini002.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aini002_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "inab_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aini002_inab_t_mask_restore('restore_mask_o')
               
      UPDATE inab_t 
         SET (inab001,
              inab002
              ,inabstus,inab003,inab004,inab005,inab006,inab007,inab008,inabownid,inabowndp,inabcrtid,inabcrtdp,inabcrtdt,inabmodid,inabmoddt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_inab_d[g_detail_idx].inabstus,g_inab_d[g_detail_idx].inab003,g_inab_d[g_detail_idx].inab004, 
                  g_inab_d[g_detail_idx].inab005,g_inab_d[g_detail_idx].inab006,g_inab_d[g_detail_idx].inab007, 
                  g_inab_d[g_detail_idx].inab008,g_inab3_d[g_detail_idx].inabownid,g_inab3_d[g_detail_idx].inabowndp, 
                  g_inab3_d[g_detail_idx].inabcrtid,g_inab3_d[g_detail_idx].inabcrtdp,g_inab3_d[g_detail_idx].inabcrtdt, 
                  g_inab3_d[g_detail_idx].inabmodid,g_inab3_d[g_detail_idx].inabmoddt) 
         WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = ps_keys_bak[1] AND inab002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inab_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inab_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aini002_inab_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aini002.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aini002_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aini002.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aini002_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aini002.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aini002_lock_b(ps_table,ps_page)
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
   #CALL aini002_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "inab_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aini002_bcl USING g_enterprise, g_site,
                                       g_inaa_m.inaa001,g_inab_d[g_detail_idx].inab002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aini002_bcl:",SQLERRMESSAGE 
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
 
{<section id="aini002.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aini002_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aini002_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aini002.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aini002_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("inaa001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   #新增的時候不會存在庫存交易，所以inaa011,inaa012開啟錄入
   CALL cl_set_comp_entry("inaa011,inaa012,inab002,inaa010",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aini002.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aini002_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_n     LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("inaa001",FALSE)
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
   #如果存在庫存交易，inab002,inaa011,inaa012不允許修改
   LET l_n = 0  
   SELECT COUNT(*) INTO l_n FROM inaj_t 
     WHERE inajent = g_enterprise AND inajsite = g_site AND inaj008 = g_inaa_m.inaa001
   IF l_n > 0 THEN
      CALL cl_set_comp_entry("inaa011,inaa012,inab002",FALSE)
   END IF
   
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM xcck_t WHERE xcckent = g_enterprise AND xccksite = g_site AND xcck015 = g_inaa_m.inaa001 AND xcckstus <>'X'
   #该库位已经结算过成本
   IF l_n > 0 THEN
      CALL cl_set_comp_entry("inaa010",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aini002.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aini002_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("inab002",TRUE)
   CALL cl_set_comp_entry("inab005,inab006,inab007",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aini002.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aini002_set_no_entry_b(p_cmd)
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
       CALL cl_set_comp_entry("inab002",FALSE)
   END IF
   
   #當儲位為' '時，揀貨優先序、庫存可用否、MRP可用否有修改時，單頭及單身所有資料都要一併更新
   IF g_inab_d[l_ac].inab002 = ' ' THEN
      CALL cl_set_comp_entry("inab005,inab006,inab007",FALSE)
   END IF
   
   #151223-00002#1 add by lixiang ---begin---
   #庫否可用否="Y"時，儲位才可為"Y"跟"N",MRP可用否同樣；防止出現庫存不可用，但儲位庫存還是可用庫存
   IF g_inaa_m.inaa008 = 'N' THEN
      CALL cl_set_comp_entry("inab006",FALSE)
   END IF
   IF g_inaa_m.inaa009 = 'N' THEN
      CALL cl_set_comp_entry("inab007",FALSE)
   END IF
   #151223-00002#1 add by lixiang ---end---
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aini002.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aini002_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aini002.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aini002_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aini002.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aini002_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aini002.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aini002_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aini002.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aini002_default_search()
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
      LET ls_wc = ls_wc, " inaa001 = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "inaa_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "inab_t" 
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
 
{<section id="aini002.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aini002_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_n  LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_inaa_m.inaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aini002_cl USING g_enterprise, g_site,g_inaa_m.inaa001
   IF STATUS THEN
      CLOSE aini002_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aini002_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aini002_master_referesh USING g_site,g_inaa_m.inaa001 INTO g_inaa_m.inaa001,g_inaa_m.inaa005, 
       g_inaa_m.inaa006,g_inaa_m.inaa007,g_inaa_m.inaa008,g_inaa_m.inaa009,g_inaa_m.inaa010,g_inaa_m.inaa014, 
       g_inaa_m.inaa015,g_inaa_m.inaa017,g_inaa_m.inaa011,g_inaa_m.inaa012,g_inaa_m.inaa013,g_inaa_m.inaastus, 
       g_inaa_m.inaaownid,g_inaa_m.inaaowndp,g_inaa_m.inaacrtid,g_inaa_m.inaacrtdp,g_inaa_m.inaacrtdt, 
       g_inaa_m.inaamodid,g_inaa_m.inaamoddt,g_inaa_m.inaa001_desc,g_inaa_m.inaa001_desc_desc,g_inaa_m.inaa005_desc, 
       g_inaa_m.inaaownid_desc,g_inaa_m.inaaowndp_desc,g_inaa_m.inaacrtid_desc,g_inaa_m.inaacrtdp_desc, 
       g_inaa_m.inaamodid_desc
   
 
   #檢查是否允許此動作
   IF NOT aini002_action_chk() THEN
      CLOSE aini002_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_inaa_m.inaa001,g_inaa_m.inaa001_desc,g_inaa_m.inaa001_desc_desc,g_inaa_m.inaa005, 
       g_inaa_m.inaa005_desc,g_inaa_m.inaa006,g_inaa_m.inaa007,g_inaa_m.inaa008,g_inaa_m.inaa009,g_inaa_m.inaa010, 
       g_inaa_m.inaa014,g_inaa_m.inaa015,g_inaa_m.inaa017,g_inaa_m.inaa011,g_inaa_m.inaa012,g_inaa_m.inaa013, 
       g_inaa_m.inaastus,g_inaa_m.inaaownid,g_inaa_m.inaaownid_desc,g_inaa_m.inaaowndp,g_inaa_m.inaaowndp_desc, 
       g_inaa_m.inaacrtid,g_inaa_m.inaacrtid_desc,g_inaa_m.inaacrtdp,g_inaa_m.inaacrtdp_desc,g_inaa_m.inaacrtdt, 
       g_inaa_m.inaamodid,g_inaa_m.inaamodid_desc,g_inaa_m.inaamoddt
 
   CASE g_inaa_m.inaastus
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
         CASE g_inaa_m.inaastus
            
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
         SELECT COUNT(*) INTO l_n FROM inag_t WHERE inagent = g_enterprise AND inagsite = g_site 
           AND inag004 = g_inaa_m.inaa001 AND (inag008 <> 0)
         IF l_n > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00006'
            LET g_errparam.extend = g_inaa_m.inaa001
            LET g_errparam.popup = FALSE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
            RETURN 
         END IF
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
      g_inaa_m.inaastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aini002_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_inaa_m.inaamodid = g_user
   LET g_inaa_m.inaamoddt = cl_get_current()
   LET g_inaa_m.inaastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE inaa_t 
      SET (inaastus,inaamodid,inaamoddt) 
        = (g_inaa_m.inaastus,g_inaa_m.inaamodid,g_inaa_m.inaamoddt)     
    WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_m.inaa001
 
    
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
      EXECUTE aini002_master_referesh USING g_site,g_inaa_m.inaa001 INTO g_inaa_m.inaa001,g_inaa_m.inaa005, 
          g_inaa_m.inaa006,g_inaa_m.inaa007,g_inaa_m.inaa008,g_inaa_m.inaa009,g_inaa_m.inaa010,g_inaa_m.inaa014, 
          g_inaa_m.inaa015,g_inaa_m.inaa017,g_inaa_m.inaa011,g_inaa_m.inaa012,g_inaa_m.inaa013,g_inaa_m.inaastus, 
          g_inaa_m.inaaownid,g_inaa_m.inaaowndp,g_inaa_m.inaacrtid,g_inaa_m.inaacrtdp,g_inaa_m.inaacrtdt, 
          g_inaa_m.inaamodid,g_inaa_m.inaamoddt,g_inaa_m.inaa001_desc,g_inaa_m.inaa001_desc_desc,g_inaa_m.inaa005_desc, 
          g_inaa_m.inaaownid_desc,g_inaa_m.inaaowndp_desc,g_inaa_m.inaacrtid_desc,g_inaa_m.inaacrtdp_desc, 
          g_inaa_m.inaamodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_inaa_m.inaa001,g_inaa_m.inaa001_desc,g_inaa_m.inaa001_desc_desc,g_inaa_m.inaa005, 
          g_inaa_m.inaa005_desc,g_inaa_m.inaa006,g_inaa_m.inaa007,g_inaa_m.inaa008,g_inaa_m.inaa009, 
          g_inaa_m.inaa010,g_inaa_m.inaa014,g_inaa_m.inaa015,g_inaa_m.inaa017,g_inaa_m.inaa011,g_inaa_m.inaa012, 
          g_inaa_m.inaa013,g_inaa_m.inaastus,g_inaa_m.inaaownid,g_inaa_m.inaaownid_desc,g_inaa_m.inaaowndp, 
          g_inaa_m.inaaowndp_desc,g_inaa_m.inaacrtid,g_inaa_m.inaacrtid_desc,g_inaa_m.inaacrtdp,g_inaa_m.inaacrtdp_desc, 
          g_inaa_m.inaacrtdt,g_inaa_m.inaamodid,g_inaa_m.inaamodid_desc,g_inaa_m.inaamoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   UPDATE inab_t SET (inabstus,inabmodid,inabmoddt) = (lc_state,g_inaa_m.inaamodid,g_inaa_m.inaamoddt)
     WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_m.inaa001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "inab_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      CALL s_transaction_end('N','0')
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aini002_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aini002_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aini002.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aini002_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_inab_d.getLength() THEN
         LET g_detail_idx = g_inab_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_inab_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_inab_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_inab3_d.getLength() THEN
         LET g_detail_idx = g_inab3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_inab3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_inab3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aini002.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aini002_b_fill2(pi_idx)
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
   
   CALL aini002_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aini002.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aini002_fill_chk(ps_idx)
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
 
{<section id="aini002.status_show" >}
PRIVATE FUNCTION aini002_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aini002.mask_functions" >}
&include "erp/ain/aini002_mask.4gl"
 
{</section>}
 
{<section id="aini002.signature" >}
   
 
{</section>}
 
{<section id="aini002.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aini002_set_pk_array()
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
   LET g_pk_array[1].values = g_inaa_m.inaa001
   LET g_pk_array[1].column = 'inaa001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aini002.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aini002.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aini002_msgcentre_notify(lc_state)
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
   CALL aini002_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_inaa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aini002.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aini002_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aini002.other_function" readonly="Y" >}

PRIVATE FUNCTION aini002_inac003_ref(p_inac003)
DEFINE p_inac003      LIKE inac_t.inac003
DEFINE r_inac003_desc LIKE oocql_t.oocql004

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_inac003
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='220' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_inac003_desc = g_rtn_fields[1]
      RETURN r_inac003_desc
      
END FUNCTION

PRIVATE FUNCTION aini002_inac003_chk(p_inac003)
DEFINE p_inac003      LIKE inac_t.inac003
DEFINE r_success      LIKE type_t.num5

      LET r_success = TRUE
      IF NOT cl_null(p_inac003) THEN 
         IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inac_t WHERE "||"inacent = '" ||g_enterprise|| "' AND inacsite = '" ||g_site|| "' AND inac001 = '"||g_inaa_m.inaa001 || "' AND inac002 = '"||g_inab_d[l_ac].inab002||"' AND inac003 = '"||p_inac003||"'",'std-00004',0) THEN 
            LET r_success = FALSE
            RETURN r_success
         END IF 
         
         IF NOT ap_chk_isExist(p_inac003,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '220' AND oocq002 = ? ","sub-01303",'aini003') THEN#160318-00005#21 mod  #"ain-00008",1 ) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         IF NOT ap_chk_isExist(p_inac003,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '220' AND oocq002 = ? AND oocqstus = 'Y' ",'sub-01302','aini003') THEN#160318-00005#21 mod  #"ain-00009",1 ) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      RETURN r_success
      
END FUNCTION

PRIVATE FUNCTION aini002_inac_insert(p_inac003,p_inaa001,p_inab002)
DEFINE p_inac003   STRING
DEFINE p_inaa001   LIKE inaa_t.inaa001
DEFINE p_inab002   LIKE inab_t.inab002
DEFINE bst         base.StringTokenizer
DEFINE l_inac003   LIKE inac_t.inac003
DEFINE r_success   LIKE type_t.num5
DEFINE l_inaccrtdt DATETIME YEAR TO SECOND
#DEFINE l_inaa013   LIKE inaa_t.inaa013
DEFINE l_oocr003   LIKE oocr_t.oocr003
DEFINE l_success   LIKE type_t.num5

      LET r_success = TRUE
      
      IF cl_null(p_inab002) THEN
         LET p_inab002 = ' '
      END IF
      CALL s_transaction_begin()  
      CALL cl_showmsg_init()
      LET l_inaccrtdt = cl_get_current()
      LET bst= base.StringTokenizer.create(p_inac003,'|')
      WHILE bst.hasMoreTokens()
         LET l_inac003 = bst.nextToken()
         INSERT INTO inac_t
                  (inacent, inacsite,inac001,inac002,inac003,inacstus,
                   inacownid,inacowndp,inaccrtid,inaccrtdp,inaccrtdt
                   ) 
            VALUES(g_enterprise, g_site,p_inaa001,p_inab002,l_inac003,'Y',
                   g_user,g_dept,g_user,g_dept,l_inaccrtdt
                   )
         IF SQLCA.sqlcode THEN
            IF SQLCA.sqlcode = '-268' THEN   #重复的标签编号，跳过
               CONTINUE WHILE
            ELSE
               CALL cl_errmsg(l_inac003,'inac_t','',SQLCA.sqlcode,1)
               #CALL cl_err("inac_t",SQLCA.sqlcode,0)
               LET r_success = FALSE
            END IF
         END IF 
         #關聯標籤同步新增
         DECLARE oocr003_cs CURSOR FOR 
            SELECT oocr003 FROM oocr_t 
            WHERE oocrent = g_enterprise AND oocr001 = '220' AND oocr002 = l_inac003 AND oocrstus = 'Y'
              AND oocr003 NOT IN (SELECT inac003 FROM inac_t WHERE inacent = g_enterprise AND inac001 = g_inaa_m.inaa001 AND inac002 = g_inab_d[l_ac].inab002) #160905-00007#4 by 08172 add ent
         FOREACH oocr003_cs INTO l_oocr003
            INSERT INTO inac_t
                  (inacent, inacsite,inac001,inac002,inac003,inacstus,
                   inacownid,inacowndp,inaccrtid,inaccrtdp,inaccrtdt
                   ) 
            VALUES(g_enterprise, g_site,p_inaa001,p_inab002,l_oocr003,'Y',
                   g_user,g_dept,g_user,g_dept,l_inaccrtdt
                   )
            IF SQLCA.sqlcode THEN
               CALL cl_errmsg(l_oocr003,'inac_t','',SQLCA.sqlcode,1)
               #CALL cl_err("inac_t",SQLCA.sqlcode,0)
               LET r_success = FALSE
               CONTINUE FOREACH
            END IF
         END FOREACH
      END WHILE
      #產生tag二進制碼
      LET l_success = ''
      CALL aini002_upd_tagb(p_inaa001,p_inab002) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
      END IF
      IF r_success THEN
         CALL s_transaction_end('Y','0')
      ELSE
         CALL s_transaction_end('N','0')
      END IF
      
      DISPLAY BY NAME g_inab_d[l_ac].inab008
      #CALL cl_showmsg()
      CALL cl_err_showmsg()
      
      RETURN r_success
      
END FUNCTION

PRIVATE FUNCTION aini002_inac_fill()
DEFINE p_inaa001  LIKE inaa_t.inaa001
DEFINE l_ac3      LIKE type_t.num5

   CALL g_inab2_d.clear()

   LET g_sql = "SELECT  UNIQUE inac003,'' FROM inac_t",  
               " WHERE inacent=? AND inacsite=? AND inac001=? AND inac002 = ? "

   LET g_sql = g_sql, " ORDER BY inac003 " 
                      
   PREPARE aini002_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR aini002_pb3
   
   OPEN b_fill_curs3 USING g_enterprise, g_site,g_inaa_m.inaa001,g_inab_d[l_ac].inab002

   LET l_ac3 = 1
   FOREACH b_fill_curs3 INTO g_inab2_d[l_ac3].inac003,g_inab2_d[l_ac3].inac003_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL aini002_inac003_ref(g_inab2_d[l_ac3].inac003) RETURNING g_inab2_d[l_ac3].inac003_desc

      LET l_ac3 = l_ac3 + 1
      IF l_ac3 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH

   CALL g_inab2_d.deleteElement(g_inab2_d.getLength())   
   
END FUNCTION

PRIVATE FUNCTION aini002_inab_insert()
#DEFINE l_inab         RECORD LIKE inab_t.*  #161124-00048#3 2016/12/08 By 08734 mark
#161124-00048#3 2016/12/08 By 08734 add(S)
DEFINE l_inab RECORD  #儲位基本資料檔
       inabent LIKE inab_t.inabent, #企业编号
       inabsite LIKE inab_t.inabsite, #营运据点
       inab001 LIKE inab_t.inab001, #库位编号
       inab002 LIKE inab_t.inab002, #储位编号
       inab003 LIKE inab_t.inab003, #储位名称
       inab004 LIKE inab_t.inab004, #助记码
       inab005 LIKE inab_t.inab005, #拣料优先级
       inab006 LIKE inab_t.inab006, #库存可用否
       inab007 LIKE inab_t.inab007, #MRP可用否
       inab008 LIKE inab_t.inab008, #Tag二进位码
       inabstus LIKE inab_t.inabstus, #状态码
       inabownid LIKE inab_t.inabownid, #资料所有者
       inabowndp LIKE inab_t.inabowndp, #资料所有部门
       inabcrtid LIKE inab_t.inabcrtid, #资料录入者
       inabcrtdp LIKE inab_t.inabcrtdp, #资料录入部门
       inabcrtdt LIKE inab_t.inabcrtdt, #资料创建日
       inabmodid LIKE inab_t.inabmodid, #资料更改者
       inabmoddt LIKE inab_t.inabmoddt #最近更改日
END RECORD
#161124-00048#3 2016/12/08 By 08734 add(E)
DEFINE r_success      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
#DEFINE l_inaa013      LIKE inaa_t.inaa013
DEFINE l_inabcrtdt    DATETIME YEAR TO SECOND

      LET r_success = TRUE
      
      LET l_inab.inabent = g_enterprise
      LET l_inab.inabsite = g_site
      LET l_inab.inab001 = g_inaa_m.inaa001
      LET l_inab.inab002 =  ' '
      #20151102 by stellar modify ----- (S)
#      LET l_inab.inab003 = g_inaa_m.inaa001_desc
#      LET l_inab.inab004 = g_inaa_m.inaa001_desc_desc
      LET l_inab.inab003 = ''
      LET l_inab.inab004 = ''
      #20151102 by stellar modify ----- (E)
      LET l_inab.inab005 = g_inaa_m.inaa006
      LET l_inab.inab006 = g_inaa_m.inaa008
      LET l_inab.inab007 = g_inaa_m.inaa009
      LET l_success = ''
      #LET l_inaa013 = ''
      #tag二進制碼初始化
      #CALL s_aooi310_init_tagb('1') RETURNING l_success,l_inaa013
      #IF NOT l_success THEN
      #   CALL cl_err("gen inaa013",SQLCA.sqlcode,1)  
      #   CALL s_transaction_end('N','0') 
      #ELSE
         LET l_inab.inab008 = g_inaa_m.inaa013
      #END IF
      LET l_inab.inabstus = g_inaa_m.inaastus
      LET l_inab.inabownid = g_user
      LET l_inab.inabowndp = g_dept
      LET l_inab.inabcrtid = g_user
      LET l_inab.inabcrtdp = g_dept
      LET l_inabcrtdt = cl_get_current()
      LET l_inab.inabmodid = NULL
      LET l_inab.inabmoddt = NULL
      
      INSERT INTO inab_t
                  (inabent, inabsite,
                   inab001,inab002
                   ,inabstus,inab003,inab004,inab005,inab006,inab007,inab008,inabownid,inabowndp,inabcrtid,inabcrtdp,inabcrtdt,inabmodid,inabmoddt) 
            VALUES(l_inab.inabent, l_inab.inabsite,
                   l_inab.inab001,l_inab.inab002,
                   l_inab.inabstus,l_inab.inab003,l_inab.inab004,l_inab.inab005,l_inab.inab006,l_inab.inab007,l_inab.inab008,l_inab.inabownid,l_inab.inabowndp,l_inab.inabcrtid,l_inab.inabcrtdp,l_inabcrtdt,l_inab.inabmodid,l_inab.inabmoddt)
      
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE 
         RETURN r_success
      END IF     
      RETURN r_success
      
END FUNCTION

PRIVATE FUNCTION aini002_inab002_chk(p_inab002)
DEFINE p_inab002    LIKE inab_t.inab002
DEFINE r_success    LIKE type_t.num5

       LET r_success = TRUE
       
       #輸入的庫位在[T:庫位基本資料檔].[C:儲位管理]='3'(依供應商編號)
       #則輸入的儲位編號必須存在[T:交易對象主檔]中，且[T:交易對象主檔].[C:交易對象類型]='1' or '3' 
       IF g_inaa_m.inaa007 = '3' THEN
          IF NOT ap_chk_isExist(p_inab002,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND (pmaa002 = '1' OR pmaa002 = '3') ","apm-00024",1 ) THEN
             LET r_success = FALSE
             RETURN r_success  
          END IF
          IF NOT ap_chk_isExist(p_inab002,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND (pmaa002 = '1' OR pmaa002 = '3') AND pmaastus = 'Y' ","apm-00200",1 ) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       #輸入的庫位在[T:庫位基本資料檔].[C:儲位管理]='4'(依客戶編號)
       #則輸入的儲位編號必須存在[T:交易對象主檔]中，且[T:交易對象主檔].[C:交易對象類型]='2' or '3'
       IF g_inaa_m.inaa007 = '4' THEN
          IF NOT ap_chk_isExist(p_inab002,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND (pmaa002 = '2' OR pmaa002 = '3') ","apm-00026",1 ) THEN
             LET r_success = FALSE
             RETURN r_success  
          END IF
          IF NOT ap_chk_isExist(p_inab002,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND (pmaa002 = '2' OR pmaa002 = '3') AND pmaastus = 'Y' ","sub-01302",'axmm200') THEN#160318-00005#21 mod#"apm-00201",1 ) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       RETURN r_success
       
END FUNCTION
################################################################################
# Descriptions...: 複製聯絡地址
# Memo...........:
# Usage..........: CALL aini002_oofb_insert(p_oofb002_f,p_oofb002_t)
#                  RETURNING r_success 
# Input parameter: p_oofb002_f  來源聯絡對象識別碼
#                  p_oofb002_t  目的聯絡對象識別碼
# Return code....: r_success  TRUE/FALSE
################################################################################
PRIVATE FUNCTION aini002_oofb_insert(p_oofb002_f,p_oofb002_t)
DEFINE p_oofb002_f    LIKE oofb_t.oofb002    #來源联络对象识别码
DEFINE p_oofb002_t    LIKE oofb_t.oofb002    #目的聯絡對象識別碼
DEFINE r_success      LIKE type_t.num5       #处理状态
DEFINE l_sql          STRING
DEFINE l_date         LIKE oofb_t.oofb018    #当日
#DEFINE l_oofb         RECORD LIKE oofb_t.*  #161124-00048#3 2016/12/08 By 08734 mark
#161124-00048#3 2016/12/08 By 08734 add(S)
DEFINE l_oofb RECORD  #聯絡地址檔
       oofbstus LIKE oofb_t.oofbstus, #状态码
       oofbent LIKE oofb_t.oofbent, #企业编号
       oofb001 LIKE oofb_t.oofb001, #联络地址识别码
       oofb002 LIKE oofb_t.oofb002, #联络对象识别码
       oofb003 LIKE oofb_t.oofb003, #联络对象编号一
       oofb004 LIKE oofb_t.oofb004, #联络对象编号二
       oofb005 LIKE oofb_t.oofb005, #联络对象编号三
       oofb006 LIKE oofb_t.oofb006, #联络对象编号四
       oofb007 LIKE oofb_t.oofb007, #联络对象编号五
       oofb008 LIKE oofb_t.oofb008, #地址类型
       oofb009 LIKE oofb_t.oofb009, #地址应用分类
       oofb010 LIKE oofb_t.oofb010, #主要联络地址
       oofb011 LIKE oofb_t.oofb011, #简要说明
       oofb012 LIKE oofb_t.oofb012, #国家/地区
       oofb013 LIKE oofb_t.oofb013, #邮政编号
       oofb014 LIKE oofb_t.oofb014, #州/省/直辖市
       oofb015 LIKE oofb_t.oofb015, #县/市
       oofb016 LIKE oofb_t.oofb016, #行政区域
       oofb017 LIKE oofb_t.oofb017, #地址
       oofb018 LIKE oofb_t.oofb018, #失效日期
       oofbownid LIKE oofb_t.oofbownid, #资料所有者
       oofbowndp LIKE oofb_t.oofbowndp, #资料所有部门
       oofbcrtid LIKE oofb_t.oofbcrtid, #资料录入者
       oofbcrtdp LIKE oofb_t.oofbcrtdp, #资料录入部门
       oofbcrtdt LIKE oofb_t.oofbcrtdt, #资料创建日
       oofbmodid LIKE oofb_t.oofbmodid, #资料更改者
       oofbmoddt LIKE oofb_t.oofbmoddt, #最近更改日
       oofb019 LIKE oofb_t.oofb019, #简要编号
       oofb020 LIKE oofb_t.oofb020, #经度
       oofb021 LIKE oofb_t.oofb021, #维度
       oofb022 LIKE oofb_t.oofb022, #收货站点
       oofb023 LIKE oofb_t.oofb023 #联络对象类型
END RECORD
#161124-00048#3 2016/12/08 By 08734 add(E)
DEFINE l_count        LIKE type_t.num10      #记录赋值成功笔数
DEFINE l_success      LIKE type_t.num5
DEFINE l_wc           STRING

   LET r_success = TRUE
   LET l_count = 0

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #当日
   LET l_date = cl_get_current()

   #将来源联络对象识别码的联络地址取出
   #LET l_sql = "SELECT * FROM oofb_t  ",  #161124-00048#3 2016/12/08 By 08734 mark
   LET l_sql = "SELECT oofbstus,oofbent,oofb001,oofb002,oofb003,oofb004,oofb005,oofb006,oofb007,oofb008,oofb009,oofb010,oofb011,oofb012,oofb013,oofb014,oofb015,oofb016,oofb017,oofb018,oofbownid,oofbowndp,oofbcrtid,oofbcrtdp,oofbcrtdt,oofbmodid,oofbmoddt,oofb019,oofb020,oofb021,oofb022,oofb023 FROM oofb_t  ",  #161124-00048#3 2016/12/08 By 08734 add
               " WHERE oofb002='",p_oofb002_f,"' ",
               "   AND oofbent=",g_enterprise,
               "   AND (oofb018 is null or oofb018 >'",l_date,"') ",   #失效日期                                  
               "   AND oofbstus='Y' "                                    #状态码        
   PREPARE aini002_ins_oofb_p FROM l_sql
   DECLARE aini002_ins_oofb_c CURSOR FOR aini002_ins_oofb_p
   FOREACH aini002_ins_oofb_c INTO l_oofb.*
       IF SQLCA.sqlcode  THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "oofb_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
       END IF

       LET l_oofb.oofbmodid= ''         #资料修改者
       LET l_oofb.oofbmoddt= ''         #最近修改日
       LET l_oofb.oofbownid= g_user     #资料所有者
       LET l_oofb.oofbowndp= g_dept     #资料所有部门
       LET l_oofb.oofbcrtid= g_user     #资料建立者
       LET l_oofb.oofbcrtdp= g_dept     #资料建立部门
       LET l_oofb.oofbcrtdt= cl_get_current()    #资料创建日
       LET l_oofb.oofbstus = 'Y'        #资料状态码
       LET l_oofb.oofb018 = ''          #失效日期
       LET l_oofb.oofb002 = p_oofb002_t #联络对象识别码  

       #产生联络地址识别码
       LET l_wc = " oofbent = ",g_enterprise
       CALL s_aooi350_get_idno('oofb001','oofb_t',l_wc)
          RETURNING l_success,l_oofb.oofb001
       IF NOT l_success THEN
          LET r_success = FALSE
          LET l_count = 0
          EXIT FOREACH
       END IF

       #插入联络地址识别档
       #INSERT INTO oofb_t VALUES (l_oofb.*)  #161124-00048#3 2016/12/08 By 08734 mark
       INSERT INTO oofb_t(oofbstus,oofbent,oofb001,oofb002,oofb003,oofb004,oofb005,oofb006,oofb007,oofb008,oofb009,oofb010,oofb011,oofb012,oofb013,oofb014,oofb015,oofb016,oofb017,oofb018,oofbownid,oofbowndp,oofbcrtid,oofbcrtdp,oofbcrtdt,oofbmodid,oofbmoddt,oofb019,oofb020,oofb021,oofb022,oofb023)   #161124-00048#3 2016/12/08 By 08734 add
          VALUES (l_oofb.oofbstus,l_oofb.oofbent,l_oofb.oofb001,l_oofb.oofb002,l_oofb.oofb003,l_oofb.oofb004,l_oofb.oofb005,l_oofb.oofb006,l_oofb.oofb007,l_oofb.oofb008,l_oofb.oofb009,l_oofb.oofb010,l_oofb.oofb011,l_oofb.oofb012,l_oofb.oofb013,l_oofb.oofb014,l_oofb.oofb015,l_oofb.oofb016,l_oofb.oofb017,l_oofb.oofb018,l_oofb.oofbownid,l_oofb.oofbowndp,l_oofb.oofbcrtid,l_oofb.oofbcrtdp,l_oofb.oofbcrtdt,l_oofb.oofbmodid,l_oofb.oofbmoddt,l_oofb.oofb019,l_oofb.oofb020,l_oofb.oofb021,l_oofb.oofb022,l_oofb.oofb023)
       IF SQLCA.sqlcode  THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "oofb_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          LET l_count = 0
          EXIT FOREACH
       END IF
       LET l_count = l_count + 1

   END FOREACH

   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 複製通訊方式
# Memo...........:
# Usage..........: CALL aini002_oofc_insert(p_oofc002_f,p_oofc002_t)
#                  RETURNING r_success 
# Input parameter: p_oofc002_f  來源聯絡對象識別碼
#                  p_oofc002_t  目的聯絡對象識別碼
# Return code....: r_success  TRUE/FALSE
################################################################################
PRIVATE FUNCTION aini002_oofc_insert(p_oofc002_f,p_oofc002_t)
DEFINE p_oofc002_f    LIKE oofc_t.oofc002    #來源联络对象识别码
DEFINE p_oofc002_t    LIKE oofc_t.oofc002    #目的联络对象识别码
DEFINE r_success      LIKE type_t.num5       #处理状态
DEFINE l_sql          STRING
DEFINE l_date         LIKE oofc_t.oofc013    #当日
#DEFINE l_oofc         RECORD LIKE oofc_t.*  #161124-00048#3 2016/12/08 By 08734 mark
#161124-00048#3 2016/12/08 By 08734 add(S)
DEFINE l_oofc RECORD  #通訊方式檔
       oofcstus LIKE oofc_t.oofcstus, #状态码
       oofcent LIKE oofc_t.oofcent, #企业编号
       oofc001 LIKE oofc_t.oofc001, #通信方式识别码
       oofc002 LIKE oofc_t.oofc002, #联络对象识别码
       oofc003 LIKE oofc_t.oofc003, #联络对象编号一
       oofc004 LIKE oofc_t.oofc004, #联络对象编号二
       oofc005 LIKE oofc_t.oofc005, #联络对象编号三
       oofc006 LIKE oofc_t.oofc006, #联络对象编号四
       oofc007 LIKE oofc_t.oofc007, #联络对象编号五
       oofc008 LIKE oofc_t.oofc008, #通信类型
       oofc009 LIKE oofc_t.oofc009, #通信应用分类
       oofc010 LIKE oofc_t.oofc010, #主要通信方式
       oofc011 LIKE oofc_t.oofc011, #简要说明
       oofc012 LIKE oofc_t.oofc012, #通信内容
       oofc013 LIKE oofc_t.oofc013, #失效日期
       oofcownid LIKE oofc_t.oofcownid, #资料所有者
       oofcowndp LIKE oofc_t.oofcowndp, #资料所有部门
       oofccrtid LIKE oofc_t.oofccrtid, #资料录入者
       oofccrtdp LIKE oofc_t.oofccrtdp, #资料录入部门
       oofccrtdt LIKE oofc_t.oofccrtdt, #资料创建日
       oofcmodid LIKE oofc_t.oofcmodid, #资料更改者
       oofcmoddt LIKE oofc_t.oofcmoddt, #最近更改日
       oofc014 LIKE oofc_t.oofc014, #简要编号
       oofc015 LIKE oofc_t.oofc015, #寄发邮件
       oofc016 LIKE oofc_t.oofc016 #联络对象类型
END RECORD
#161124-00048#3 2016/12/08 By 08734 add(E)
DEFINE l_count        LIKE type_t.num10      #记录赋值成功笔数
DEFINE l_success      LIKE type_t.num5
DEFINE l_wc           STRING

   LET r_success = TRUE
   LET l_count = 0

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #将来源联络对象识别码的通訊方式取出
   #LET l_sql = "SELECT * FROM oofc_t  ",  #161124-00048#3 2016/12/08 By 08734 mark
   LET l_sql = "SELECT oofcstus,oofcent,oofc001,oofc002,oofc003,oofc004,oofc005,oofc006,oofc007,oofc008,oofc009,oofc010,oofc011,oofc012,oofc013,oofcownid,oofcowndp,oofccrtid,oofccrtdp,oofccrtdt,oofcmodid,oofcmoddt,oofc014,oofc015,oofc016 FROM oofc_t  ",  #161124-00048#3 2016/12/08 By 08734 add
               " WHERE oofc002='",p_oofc002_f,"' ",
               "   AND oofcent=",g_enterprise,
               "   AND (oofc013 is null or oofc013 >'",l_date,"') ",   #失效日期                                  
               "   AND oofcstus='Y' "                                    #状态码        
   PREPARE aini002_insert_oofc_p FROM l_sql
   DECLARE aini002_insert_oofc_c CURSOR FOR aini002_insert_oofc_p
   FOREACH aini002_insert_oofc_c INTO l_oofc.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "oofc_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
       END IF

       LET l_oofc.oofcmodid= ''         #资料修改者
       LET l_oofc.oofcmoddt= ''         #最近修改日
       LET l_oofc.oofcownid= g_user     #资料所有者
       LET l_oofc.oofcowndp= g_dept     #资料所有部门
       LET l_oofc.oofccrtid= g_user     #资料建立者
       LET l_oofc.oofccrtdp= g_dept     #资料建立部门
       LET l_oofc.oofccrtdt= cl_get_current()    #资料创建日
       LET l_oofc.oofcstus = 'Y'        #资料状态码
       LET l_oofc.oofc013 = ''          #失效日期
       LET l_oofc.oofc002 = p_oofc002_t   #联络对象识别码  

       #产生通訊方式识别码 
       LET l_wc = " oofcent = ",g_enterprise
       CALL s_aooi350_get_idno('oofc001','oofc_t',l_wc)
          RETURNING l_success,l_oofc.oofc001
       IF NOT l_success THEN
          LET r_success = FALSE
          LET l_count = 0
          EXIT FOREACH
       END IF

       #插入通訊方式识别档
       #INSERT INTO oofc_t VALUES (l_oofc.*)  #161124-00048#3 2016/12/08 By 08734 mark
       INSERT INTO oofc_t(oofcstus,oofcent,oofc001,oofc002,oofc003,oofc004,oofc005,oofc006,oofc007,oofc008,oofc009,oofc010,oofc011,oofc012,oofc013,oofcownid,oofcowndp,oofccrtid,oofccrtdp,oofccrtdt,oofcmodid,oofcmoddt,oofc014,oofc015,oofc016)  #161124-00048#3 2016/12/08 By 08734 add
          VALUES (l_oofc.oofcstus,l_oofc.oofcent,l_oofc.oofc001,l_oofc.oofc002,l_oofc.oofc003,l_oofc.oofc004,l_oofc.oofc005,l_oofc.oofc006,l_oofc.oofc007,l_oofc.oofc008,l_oofc.oofc009,l_oofc.oofc010,l_oofc.oofc011,l_oofc.oofc012,l_oofc.oofc013,l_oofc.oofcownid,l_oofc.oofcowndp,l_oofc.oofccrtid,l_oofc.oofccrtdp,l_oofc.oofccrtdt,l_oofc.oofcmodid,l_oofc.oofcmoddt,l_oofc.oofc014,l_oofc.oofc015,l_oofc.oofc016)
       IF SQLCA.sqlcode  THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "oofc_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          LET l_count = 0
          EXIT FOREACH
       END IF
       LET l_count = l_count + 1

   END FOREACH

   RETURN r_success

END FUNCTION

PRIVATE FUNCTION aini002_inaa005_ref(p_inaa005)
DEFINE p_inaa005      LIKE inaa_t.inaa005
DEFINE r_inaa005_desc LIKE ooefl_t.ooefl003
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_inaa005
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_inaa005_desc = '', g_rtn_fields[1] , ''
      RETURN r_inaa005_desc
            
END FUNCTION

PRIVATE FUNCTION aini002_upd_tagb(p_inaa001,p_inab002)
DEFINE p_inaa001    LIKE inaa_t.inaa001
DEFINE p_inab002    LIKE inab_t.inab002
DEFINE r_success    LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
 
       #检查:应在事物中的
       IF NOT s_transaction_chk('Y',1) THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
       IF cl_null(p_inab002) THEN
          LET p_inab002 = ' '
       END IF
       
       LET r_success = TRUE
       LET l_success = ''
       #LET l_inaa013 = ''
       CALL s_aooi310_gen_tagb(p_inaa001,p_inab002,'2') RETURNING l_success,g_inaa_m.inaa013
       IF NOT l_success THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "gen inaa013"
          LET g_errparam.popup = TRUE
          CALL cl_err()
  
          LET r_success = FALSE
          RETURN r_success          
       ELSE
          #IF p_inab002 = ' ' THEN
          #   UPDATE inaa_t SET inaa013 = g_inaa_m.inaa013 WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = p_inaa001
          #   IF SQLCA.SQLcode  THEN
          #      INITIALIZE g_errparam TO NULL
          #      LET g_errparam.code = SQLCA.sqlcode
          #      LET g_errparam.extend = "inaa_t"
          #      LET g_errparam.popup = TRUE
          #      CALL cl_err()
          #
          #      LET r_success = FALSE
          #      RETURN r_success
          #   END IF
          #END IF
          ##儲位為' '的tag二進位碼應與單頭的一致
          #UPDATE inab_t SET inab008 = g_inaa_m.inaa013 WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = p_inaa001 AND inab002 = ' '
          #IF SQLCA.SQLcode  THEN
          #   INITIALIZE g_errparam TO NULL
          #  LET g_errparam.code = SQLCA.sqlcode
          #  LET g_errparam.extend = "inab_t"
          #  LET g_errparam.popup = TRUE
          #  CALL cl_err()
          # 
          #   CALL s_transaction_end('N','0') 
          #END IF
          
          UPDATE inab_t SET inab008 = g_inaa_m.inaa013 WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = p_inaa001 AND inab002 = p_inab002
          IF SQLCA.SQLcode  THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "inab_t"
             LET g_errparam.popup = TRUE
             CALL cl_err()
  
             LET r_success = FALSE
             RETURN r_success 
          END IF
          
          UPDATE inag_t SET inag023 = g_inaa_m.inaa013 WHERE inagent = g_enterprise AND inagsite = g_site AND inag004 = p_inaa001 AND inag005 = p_inab002
          IF SQLCA.SQLcode  THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "inag_t"
             LET g_errparam.popup = TRUE
             CALL cl_err()
  
             LET r_success = FALSE
             RETURN r_success
          END IF
          
          UPDATE inah_t SET inah011 = g_inaa_m.inaa013 WHERE inahent = g_enterprise AND inahsite = g_site AND inah004 = p_inaa001 AND inah005 = p_inab002
          IF SQLCA.SQLcode  THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "inah_t"
             LET g_errparam.popup = TRUE
             CALL cl_err()
  
             LET r_success = FALSE
             RETURN r_success
          END IF
          
          UPDATE inai_t SET inai013 = g_inaa_m.inaa013 WHERE inaient = g_enterprise AND inaisite = g_site AND inai004 = p_inaa001 AND inai005 = p_inab002
          IF SQLCA.SQLcode  THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "inai_t"
             LET g_errparam.popup = TRUE
             CALL cl_err()
  
             LET r_success = FALSE
             RETURN r_success 
          END IF
       END IF
       RETURN r_success 
       
END FUNCTION
#新增儲位編號時，帶出當前庫位的管理標籤
PRIVATE FUNCTION aini002_inac_init(p_inaa001,p_inab002)
DEFINE p_inaa001    LIKE inaa_t.inaa001
DEFINE p_inab002    LIKE inab_t.inab002
DEFINE l_inac003    LIKE inac_t.inac003
DEFINE l_inaccrtdt  DATETIME YEAR TO SECOND
DEFINE r_success    LIKE type_t.num5

      LET r_success = TRUE

      #检查:应在事物中的
      IF NOT s_transaction_chk('Y',1) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_inaccrtdt = cl_get_current()
      
      DECLARE inac_c CURSOR FOR 
         SELECT inac003 FROM inac_t WHERE inacent = g_enterprise AND inac001 = p_inaa001 AND inac002 = ' ' AND inacsite = g_site
      FOREACH inac_c INTO l_inac003
         INSERT INTO inac_t
                  (inacent, inacsite,inac001,inac002,inac003,inacstus,
                   inacownid,inacowndp,inaccrtid,inaccrtdp,inaccrtdt
                   ) 
            VALUES(g_enterprise, g_site,p_inaa001,p_inab002,l_inac003,'Y',
                   g_user,g_dept,g_user,g_dept,l_inaccrtdt
                   )
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "inac_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success      
         END IF
         
      END FOREACH   
      RETURN r_success
      
END FUNCTION

################################################################################
# Descriptions...: 抓取库位名称显示
################################################################################
PRIVATE FUNCTION aini002_inaa001_desc()

INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inaa_m.inaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT inayl003,inayl004 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inaa_m.inaa001_desc = '', g_rtn_fields[1] , ''
   LET g_inaa_m.inaa001_desc_desc = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_inaa_m.inaa001_desc
   DISPLAY BY NAME g_inaa_m.inaa001_desc_desc
END FUNCTION

 
{</section>}
 
