#該程式未解開Section, 採用最新樣板產出!
{<section id="amht204.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2016-07-27 10:50:18), PR版次:0010(2016-10-14 16:06:21)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: amht204
#+ Description: 場地申請維護作業
#+ Creator....: 04226(2016-03-03 11:37:37)
#+ Modifier...: 08172 -SD/PR- 06814
 
{</section>}
 
{<section id="amht204.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#+ Modifier...:   No.160318-00025#30   2016/04/19 BY pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#+ Modifier...:   NO.160816-00068#8    2016/08/17 By 08209    調整transaction
#160604-00009#163 2016/07/25   by 08172     添加区域管理参数
#160818-00017#20  2016/08/29   By 08742     删除修改未重新判断状态码
#160824-00007#84  2016/10/14   By 06814     新舊值備份
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
PRIVATE type type_g_mhba_m        RECORD
       mhbasite LIKE mhba_t.mhbasite, 
   mhbasite_desc LIKE type_t.chr80, 
   mhbadocdt LIKE mhba_t.mhbadocdt, 
   mhbadocno LIKE mhba_t.mhbadocno, 
   mhba000 LIKE mhba_t.mhba000, 
   mhba006 LIKE mhba_t.mhba006, 
   mhba004 LIKE mhba_t.mhba004, 
   mhba004_desc LIKE type_t.chr80, 
   mhba005 LIKE mhba_t.mhba005, 
   mhba005_desc LIKE type_t.chr80, 
   mhba001 LIKE mhba_t.mhba001, 
   mhba001_desc LIKE type_t.chr80, 
   mhba002 LIKE mhba_t.mhba002, 
   mhba002_desc LIKE type_t.chr80, 
   mhba003 LIKE mhba_t.mhba003, 
   mhba003_desc LIKE type_t.chr80, 
   mhbaunit LIKE mhba_t.mhbaunit, 
   mhbastus LIKE mhba_t.mhbastus, 
   mhbaownid LIKE mhba_t.mhbaownid, 
   mhbaownid_desc LIKE type_t.chr80, 
   mhbaowndp LIKE mhba_t.mhbaowndp, 
   mhbaowndp_desc LIKE type_t.chr80, 
   mhbacrtid LIKE mhba_t.mhbacrtid, 
   mhbacrtid_desc LIKE type_t.chr80, 
   mhbacrtdp LIKE mhba_t.mhbacrtdp, 
   mhbacrtdp_desc LIKE type_t.chr80, 
   mhbacrtdt LIKE mhba_t.mhbacrtdt, 
   mhbamodid LIKE mhba_t.mhbamodid, 
   mhbamodid_desc LIKE type_t.chr80, 
   mhbamoddt LIKE mhba_t.mhbamoddt, 
   mhbacnfid LIKE mhba_t.mhbacnfid, 
   mhbacnfid_desc LIKE type_t.chr80, 
   mhbacnfdt LIKE mhba_t.mhbacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mhbb_d        RECORD
       mhbbacti LIKE mhbb_t.mhbbacti, 
   mhbbsite LIKE mhbb_t.mhbbsite, 
   mhbb004 LIKE mhbb_t.mhbb004, 
   mhbbl003 LIKE mhbbl_t.mhbbl003, 
   mhbbl004 LIKE mhbbl_t.mhbbl004, 
   mhbb009 LIKE mhbb_t.mhbb009, 
   mhbb005 LIKE mhbb_t.mhbb005, 
   mhbb006 LIKE mhbb_t.mhbb006, 
   mhbb007 LIKE mhbb_t.mhbb007, 
   mhbb010 LIKE mhbb_t.mhbb010, 
   mhbb010_desc LIKE type_t.chr500, 
   mhbb008 LIKE mhbb_t.mhbb008, 
   mhbb001 LIKE mhbb_t.mhbb001, 
   mhbb001_desc LIKE type_t.chr500, 
   mhbb002 LIKE mhbb_t.mhbb002, 
   mhbb002_desc LIKE type_t.chr500, 
   mhbb003 LIKE mhbb_t.mhbb003, 
   mhbb003_desc LIKE type_t.chr500, 
   mhbbunit LIKE mhbb_t.mhbbunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mhbasite LIKE mhba_t.mhbasite,
   b_mhbasite_desc LIKE type_t.chr80,
      b_mhbadocdt LIKE mhba_t.mhbadocdt,
      b_mhbadocno LIKE mhba_t.mhbadocno,
      b_mhba000 LIKE mhba_t.mhba000,
      b_mhba004 LIKE mhba_t.mhba004,
   b_mhba004_desc LIKE type_t.chr80,
      b_mhba005 LIKE mhba_t.mhba005,
   b_mhba005_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag      LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_mhba_m          type_g_mhba_m
DEFINE g_mhba_m_t        type_g_mhba_m
DEFINE g_mhba_m_o        type_g_mhba_m
DEFINE g_mhba_m_mask_o   type_g_mhba_m #轉換遮罩前資料
DEFINE g_mhba_m_mask_n   type_g_mhba_m #轉換遮罩後資料
 
   DEFINE g_mhbadocno_t LIKE mhba_t.mhbadocno
 
 
DEFINE g_mhbb_d          DYNAMIC ARRAY OF type_g_mhbb_d
DEFINE g_mhbb_d_t        type_g_mhbb_d
DEFINE g_mhbb_d_o        type_g_mhbb_d
DEFINE g_mhbb_d_mask_o   DYNAMIC ARRAY OF type_g_mhbb_d #轉換遮罩前資料
DEFINE g_mhbb_d_mask_n   DYNAMIC ARRAY OF type_g_mhbb_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_detail_multi_table_t    RECORD
      mhbbldocno LIKE mhbbl_t.mhbbldocno,
      mhbbl001 LIKE mhbbl_t.mhbbl001,
      mhbbl002 LIKE mhbbl_t.mhbbl002,
      mhbbl003 LIKE mhbbl_t.mhbbl003,
      mhbbl004 LIKE mhbbl_t.mhbbl004
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
 
{<section id="amht204.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amh","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mhbasite,'',mhbadocdt,mhbadocno,mhba000,mhba006,mhba004,'',mhba005,'', 
       mhba001,'',mhba002,'',mhba003,'',mhbaunit,mhbastus,mhbaownid,'',mhbaowndp,'',mhbacrtid,'',mhbacrtdp, 
       '',mhbacrtdt,mhbamodid,'',mhbamoddt,mhbacnfid,'',mhbacnfdt", 
                      " FROM mhba_t",
                      " WHERE mhbaent= ? AND mhbadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amht204_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mhbasite,t0.mhbadocdt,t0.mhbadocno,t0.mhba000,t0.mhba006,t0.mhba004, 
       t0.mhba005,t0.mhba001,t0.mhba002,t0.mhba003,t0.mhbaunit,t0.mhbastus,t0.mhbaownid,t0.mhbaowndp, 
       t0.mhbacrtid,t0.mhbacrtdp,t0.mhbacrtdt,t0.mhbamodid,t0.mhbamoddt,t0.mhbacnfid,t0.mhbacnfdt,t1.ooefl003 , 
       t2.ooag011 ,t3.ooefl003 ,t4.mhaal003 ,t5.mhabl004 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooefl003 , 
       t11.ooag011 ,t12.ooag011",
               " FROM mhba_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mhbasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.mhba004  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mhba005 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhaal_t t4 ON t4.mhaalent="||g_enterprise||" AND t4.mhaal001=t0.mhba001 AND t4.mhaal002='"||g_dlang||"' ",
               " LEFT JOIN mhabl_t t5 ON t5.mhablent="||g_enterprise||" AND t5.mhabl001=t0.mhba001 AND t5.mhabl002=t0.mhba002 AND t5.mhabl003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.mhbaownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.mhbaowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.mhbacrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.mhbacrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.mhbamodid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.mhbacnfid  ",
 
               " WHERE t0.mhbaent = " ||g_enterprise|| " AND t0.mhbadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE amht204_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amht204 WITH FORM cl_ap_formpath("amh",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amht204_init()   
 
      #進入選單 Menu (="N")
      CALL amht204_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amht204
      
   END IF 
   
   CLOSE amht204_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   CALL s_aooi390_drop_tmp_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amht204.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION amht204_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success     LIKE type_t.num5
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
      CALL cl_set_combo_scc_part('mhbastus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('mhba000','32') 
   CALL cl_set_combo_scc('mhbb008','6020') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #160421-00013#1 160428 by sakura add(S)
   CALL s_asti800_set_comp_format("mhbb005",g_site,'2')
   CALL s_asti800_set_comp_format("mhbb006",g_site,'2')
   CALL s_asti800_set_comp_format("mhbb007",g_site,'2')
   #160421-00013#1 160428 by sakura add(E)   
   LET g_errshow = 1
   CALL cl_set_combo_scc('b_mhba000','32') 
   LET l_success = ''
   CALL s_aooi500_create_temp() RETURNING l_success
   LET l_success = ''
   CALL s_aooi390_cre_tmp_table() RETURNING l_success
   #end add-point
   
   #初始化搜尋條件
   CALL amht204_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="amht204.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION amht204_ui_dialog()
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
            CALL amht204_insert()
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
         INITIALIZE g_mhba_m.* TO NULL
         CALL g_mhbb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL amht204_init()
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
               
               CALL amht204_fetch('') # reload data
               LET l_ac = 1
               CALL amht204_ui_detailshow() #Setting the current row 
         
               CALL amht204_idx_chk()
               #NEXT FIELD mhbb004
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mhbb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amht204_idx_chk()
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
               CALL amht204_idx_chk()
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
            CALL amht204_browser_fill("")
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
               CALL amht204_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL amht204_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL amht204_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL amht204_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL amht204_set_act_visible()   
            CALL amht204_set_act_no_visible()
            IF NOT (g_mhba_m.mhbadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mhbaent = " ||g_enterprise|| " AND",
                                  " mhbadocno = '", g_mhba_m.mhbadocno, "' "
 
               #填到對應位置
               CALL amht204_browser_fill("")
            END IF
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "mhba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mhbb_t" 
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
               CALL amht204_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "mhba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mhbb_t" 
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
                  CALL amht204_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL amht204_fetch("F")
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
               CALL amht204_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL amht204_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht204_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL amht204_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht204_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL amht204_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht204_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL amht204_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht204_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL amht204_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht204_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mhbb_d)
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
               NEXT FIELD mhbb004
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
               CALL amht204_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL amht204_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL amht204_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amht204_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amh/amht204_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amh/amht204_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL amht204_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL amht204_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_mhba004
            LET g_action_choice="prog_mhba004"
            IF cl_auth_chk_act("prog_mhba004") THEN
               
               #add-point:ON ACTION prog_mhba004 name="menu.prog_mhba004"
               #應用 a45 樣板自動產生(Version:3)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_mhba_m.mhba004)
 



               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL amht204_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amht204_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amht204_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mhba_m.mhbadocdt)
 
 
 
         
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
 
{<section id="amht204.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION amht204_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT mhbadocno ",
                      " FROM mhba_t ",
                      " ",
                      " LEFT JOIN mhbb_t ON mhbbent = mhbaent AND mhbadocno = mhbbdocno ", "  ",
                      #add-point:browser_fill段sql(mhbb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " LEFT JOIN mhbbl_t ON mhbblent = "||g_enterprise||" AND mhbadocno = mhbbldocno AND mhbb004 = mhbbl001 AND mhbbl002 = '",g_dlang,"' ", 
 
 
                      " WHERE mhbaent = " ||g_enterprise|| " AND mhbbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mhba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mhbadocno ",
                      " FROM mhba_t ", 
                      "  ",
                      "  ",
                      " WHERE mhbaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mhba_t")
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
      INITIALIZE g_mhba_m.* TO NULL
      CALL g_mhbb_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mhbasite,t0.mhbadocdt,t0.mhbadocno,t0.mhba000,t0.mhba004,t0.mhba005 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mhbastus,t0.mhbasite,t0.mhbadocdt,t0.mhbadocno,t0.mhba000,t0.mhba004, 
          t0.mhba005,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM mhba_t t0",
                  "  ",
                  "  LEFT JOIN mhbb_t ON mhbbent = mhbaent AND mhbadocno = mhbbdocno ", "  ", 
                  #add-point:browser_fill段sql(mhbb_t1) name="browser_fill.join.mhbb_t1"
                  
                  #end add-point
 
 
                  " LEFT JOIN mhbbl_t ON mhbblent = "||g_enterprise||" AND mhbadocno = mhbbldocno AND mhbb004 = mhbbl001 AND mhbbl002 = '",g_dlang,"' ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mhbasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.mhba004  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mhba005 AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.mhbaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mhba_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mhbastus,t0.mhbasite,t0.mhbadocdt,t0.mhbadocno,t0.mhba000,t0.mhba004, 
          t0.mhba005,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM mhba_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mhbasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.mhba004  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mhba005 AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.mhbaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mhba_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mhbadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mhba_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mhbasite,g_browser[g_cnt].b_mhbadocdt, 
          g_browser[g_cnt].b_mhbadocno,g_browser[g_cnt].b_mhba000,g_browser[g_cnt].b_mhba004,g_browser[g_cnt].b_mhba005, 
          g_browser[g_cnt].b_mhbasite_desc,g_browser[g_cnt].b_mhba004_desc,g_browser[g_cnt].b_mhba005_desc 
 
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
         CALL amht204_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
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
   
   IF cl_null(g_browser[g_cnt].b_mhbadocno) THEN
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
 
{<section id="amht204.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION amht204_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mhba_m.mhbadocno = g_browser[g_current_idx].b_mhbadocno   
 
   EXECUTE amht204_master_referesh USING g_mhba_m.mhbadocno INTO g_mhba_m.mhbasite,g_mhba_m.mhbadocdt, 
       g_mhba_m.mhbadocno,g_mhba_m.mhba000,g_mhba_m.mhba006,g_mhba_m.mhba004,g_mhba_m.mhba005,g_mhba_m.mhba001, 
       g_mhba_m.mhba002,g_mhba_m.mhba003,g_mhba_m.mhbaunit,g_mhba_m.mhbastus,g_mhba_m.mhbaownid,g_mhba_m.mhbaowndp, 
       g_mhba_m.mhbacrtid,g_mhba_m.mhbacrtdp,g_mhba_m.mhbacrtdt,g_mhba_m.mhbamodid,g_mhba_m.mhbamoddt, 
       g_mhba_m.mhbacnfid,g_mhba_m.mhbacnfdt,g_mhba_m.mhbasite_desc,g_mhba_m.mhba004_desc,g_mhba_m.mhba005_desc, 
       g_mhba_m.mhba001_desc,g_mhba_m.mhba002_desc,g_mhba_m.mhbaownid_desc,g_mhba_m.mhbaowndp_desc,g_mhba_m.mhbacrtid_desc, 
       g_mhba_m.mhbacrtdp_desc,g_mhba_m.mhbamodid_desc,g_mhba_m.mhbacnfid_desc
   
   CALL amht204_mhba_t_mask()
   CALL amht204_show()
      
END FUNCTION
 
{</section>}
 
{<section id="amht204.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION amht204_ui_detailshow()
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
 
{<section id="amht204.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION amht204_ui_browser_refresh()
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
      IF g_browser[l_i].b_mhbadocno = g_mhba_m.mhbadocno 
 
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
 
{<section id="amht204.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION amht204_construct()
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
   INITIALIZE g_mhba_m.* TO NULL
   CALL g_mhbb_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON mhbasite,mhbadocdt,mhbadocno,mhba000,mhba006,mhba004,mhba005,mhba001, 
          mhba002,mhba003,mhbaunit,mhbastus,mhbaownid,mhbaowndp,mhbacrtid,mhbacrtdp,mhbacrtdt,mhbamodid, 
          mhbamoddt,mhbacnfid,mhbacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mhbacrtdt>>----
         AFTER FIELD mhbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mhbamoddt>>----
         AFTER FIELD mhbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mhbacnfdt>>----
         AFTER FIELD mhbacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mhbapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.mhbasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbasite
            #add-point:ON ACTION controlp INFIELD mhbasite name="construct.c.mhbasite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhbasite',g_site,'ｃ')
            CALL q_ooef001_24()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbasite  #顯示到畫面上
            NEXT FIELD mhbasite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbasite
            #add-point:BEFORE FIELD mhbasite name="construct.b.mhbasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbasite
            
            #add-point:AFTER FIELD mhbasite name="construct.a.mhbasite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbadocdt
            #add-point:BEFORE FIELD mhbadocdt name="construct.b.mhbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbadocdt
            
            #add-point:AFTER FIELD mhbadocdt name="construct.a.mhbadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbadocdt
            #add-point:ON ACTION controlp INFIELD mhbadocdt name="construct.c.mhbadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbadocno
            #add-point:ON ACTION controlp INFIELD mhbadocno name="construct.c.mhbadocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhbadocno()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbadocno  #顯示到畫面上
            NEXT FIELD mhbadocno                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbadocno
            #add-point:BEFORE FIELD mhbadocno name="construct.b.mhbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbadocno
            
            #add-point:AFTER FIELD mhbadocno name="construct.a.mhbadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhba000
            #add-point:BEFORE FIELD mhba000 name="construct.b.mhba000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhba000
            
            #add-point:AFTER FIELD mhba000 name="construct.a.mhba000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhba000
            #add-point:ON ACTION controlp INFIELD mhba000 name="construct.c.mhba000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhba006
            #add-point:BEFORE FIELD mhba006 name="construct.b.mhba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhba006
            
            #add-point:AFTER FIELD mhba006 name="construct.a.mhba006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhba006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhba006
            #add-point:ON ACTION controlp INFIELD mhba006 name="construct.c.mhba006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhba004
            #add-point:ON ACTION controlp INFIELD mhba004 name="construct.c.mhba004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhba004  #顯示到畫面上
            NEXT FIELD mhba004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhba004
            #add-point:BEFORE FIELD mhba004 name="construct.b.mhba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhba004
            
            #add-point:AFTER FIELD mhba004 name="construct.a.mhba004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhba005
            #add-point:ON ACTION controlp INFIELD mhba005 name="construct.c.mhba005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhba005  #顯示到畫面上
            NEXT FIELD mhba005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhba005
            #add-point:BEFORE FIELD mhba005 name="construct.b.mhba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhba005
            
            #add-point:AFTER FIELD mhba005 name="construct.a.mhba005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhba001
            #add-point:ON ACTION controlp INFIELD mhba001 name="construct.c.mhba001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhba001  #顯示到畫面上
            NEXT FIELD mhba001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhba001
            #add-point:BEFORE FIELD mhba001 name="construct.b.mhba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhba001
            
            #add-point:AFTER FIELD mhba001 name="construct.a.mhba001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhba002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhba002
            #add-point:ON ACTION controlp INFIELD mhba002 name="construct.c.mhba002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhba002  #顯示到畫面上
            NEXT FIELD mhba002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhba002
            #add-point:BEFORE FIELD mhba002 name="construct.b.mhba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhba002
            
            #add-point:AFTER FIELD mhba002 name="construct.a.mhba002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhba003
            #add-point:ON ACTION controlp INFIELD mhba003 name="construct.c.mhba003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhac003()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhba003  #顯示到畫面上
            NEXT FIELD mhba003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhba003
            #add-point:BEFORE FIELD mhba003 name="construct.b.mhba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhba003
            
            #add-point:AFTER FIELD mhba003 name="construct.a.mhba003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbaunit
            #add-point:BEFORE FIELD mhbaunit name="construct.b.mhbaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbaunit
            
            #add-point:AFTER FIELD mhbaunit name="construct.a.mhbaunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbaunit
            #add-point:ON ACTION controlp INFIELD mhbaunit name="construct.c.mhbaunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbastus
            #add-point:BEFORE FIELD mhbastus name="construct.b.mhbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbastus
            
            #add-point:AFTER FIELD mhbastus name="construct.a.mhbastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbastus
            #add-point:ON ACTION controlp INFIELD mhbastus name="construct.c.mhbastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbaownid
            #add-point:ON ACTION controlp INFIELD mhbaownid name="construct.c.mhbaownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbaownid  #顯示到畫面上
            NEXT FIELD mhbaownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbaownid
            #add-point:BEFORE FIELD mhbaownid name="construct.b.mhbaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbaownid
            
            #add-point:AFTER FIELD mhbaownid name="construct.a.mhbaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbaowndp
            #add-point:ON ACTION controlp INFIELD mhbaowndp name="construct.c.mhbaowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbaowndp  #顯示到畫面上
            NEXT FIELD mhbaowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbaowndp
            #add-point:BEFORE FIELD mhbaowndp name="construct.b.mhbaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbaowndp
            
            #add-point:AFTER FIELD mhbaowndp name="construct.a.mhbaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbacrtid
            #add-point:ON ACTION controlp INFIELD mhbacrtid name="construct.c.mhbacrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbacrtid  #顯示到畫面上
            NEXT FIELD mhbacrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbacrtid
            #add-point:BEFORE FIELD mhbacrtid name="construct.b.mhbacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbacrtid
            
            #add-point:AFTER FIELD mhbacrtid name="construct.a.mhbacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbacrtdp
            #add-point:ON ACTION controlp INFIELD mhbacrtdp name="construct.c.mhbacrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbacrtdp  #顯示到畫面上
            NEXT FIELD mhbacrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbacrtdp
            #add-point:BEFORE FIELD mhbacrtdp name="construct.b.mhbacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbacrtdp
            
            #add-point:AFTER FIELD mhbacrtdp name="construct.a.mhbacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbacrtdt
            #add-point:BEFORE FIELD mhbacrtdt name="construct.b.mhbacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbamodid
            #add-point:ON ACTION controlp INFIELD mhbamodid name="construct.c.mhbamodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbamodid  #顯示到畫面上
            NEXT FIELD mhbamodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbamodid
            #add-point:BEFORE FIELD mhbamodid name="construct.b.mhbamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbamodid
            
            #add-point:AFTER FIELD mhbamodid name="construct.a.mhbamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbamoddt
            #add-point:BEFORE FIELD mhbamoddt name="construct.b.mhbamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbacnfid
            #add-point:ON ACTION controlp INFIELD mhbacnfid name="construct.c.mhbacnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbacnfid  #顯示到畫面上
            NEXT FIELD mhbacnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbacnfid
            #add-point:BEFORE FIELD mhbacnfid name="construct.b.mhbacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbacnfid
            
            #add-point:AFTER FIELD mhbacnfid name="construct.a.mhbacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbacnfdt
            #add-point:BEFORE FIELD mhbacnfdt name="construct.b.mhbacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mhbbacti,mhbbsite,mhbb004,mhbbl003,mhbbl004,mhbb009,mhbb005,mhbb006, 
          mhbb007,mhbb010,mhbb008,mhbb001,mhbb002,mhbb003,mhbbunit
           FROM s_detail1[1].mhbbacti,s_detail1[1].mhbbsite,s_detail1[1].mhbb004,s_detail1[1].mhbbl003, 
               s_detail1[1].mhbbl004,s_detail1[1].mhbb009,s_detail1[1].mhbb005,s_detail1[1].mhbb006, 
               s_detail1[1].mhbb007,s_detail1[1].mhbb010,s_detail1[1].mhbb008,s_detail1[1].mhbb001,s_detail1[1].mhbb002, 
               s_detail1[1].mhbb003,s_detail1[1].mhbbunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbbacti
            #add-point:BEFORE FIELD mhbbacti name="construct.b.page1.mhbbacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbbacti
            
            #add-point:AFTER FIELD mhbbacti name="construct.a.page1.mhbbacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbbacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbbacti
            #add-point:ON ACTION controlp INFIELD mhbbacti name="construct.c.page1.mhbbacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbbsite
            #add-point:BEFORE FIELD mhbbsite name="construct.b.page1.mhbbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbbsite
            
            #add-point:AFTER FIELD mhbbsite name="construct.a.page1.mhbbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbbsite
            #add-point:ON ACTION controlp INFIELD mhbbsite name="construct.c.page1.mhbbsite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb004
            #add-point:ON ACTION controlp INFIELD mhbb004 name="construct.c.page1.mhbb004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbb004  #顯示到畫面上
            NEXT FIELD mhbb004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb004
            #add-point:BEFORE FIELD mhbb004 name="construct.b.page1.mhbb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb004
            
            #add-point:AFTER FIELD mhbb004 name="construct.a.page1.mhbb004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbbl003
            #add-point:BEFORE FIELD mhbbl003 name="construct.b.page1.mhbbl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbbl003
            
            #add-point:AFTER FIELD mhbbl003 name="construct.a.page1.mhbbl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbbl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbbl003
            #add-point:ON ACTION controlp INFIELD mhbbl003 name="construct.c.page1.mhbbl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbbl004
            #add-point:BEFORE FIELD mhbbl004 name="construct.b.page1.mhbbl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbbl004
            
            #add-point:AFTER FIELD mhbbl004 name="construct.a.page1.mhbbl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbbl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbbl004
            #add-point:ON ACTION controlp INFIELD mhbbl004 name="construct.c.page1.mhbbl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb009
            #add-point:BEFORE FIELD mhbb009 name="construct.b.page1.mhbb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb009
            
            #add-point:AFTER FIELD mhbb009 name="construct.a.page1.mhbb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb009
            #add-point:ON ACTION controlp INFIELD mhbb009 name="construct.c.page1.mhbb009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb005
            #add-point:BEFORE FIELD mhbb005 name="construct.b.page1.mhbb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb005
            
            #add-point:AFTER FIELD mhbb005 name="construct.a.page1.mhbb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb005
            #add-point:ON ACTION controlp INFIELD mhbb005 name="construct.c.page1.mhbb005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb006
            #add-point:BEFORE FIELD mhbb006 name="construct.b.page1.mhbb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb006
            
            #add-point:AFTER FIELD mhbb006 name="construct.a.page1.mhbb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb006
            #add-point:ON ACTION controlp INFIELD mhbb006 name="construct.c.page1.mhbb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb007
            #add-point:BEFORE FIELD mhbb007 name="construct.b.page1.mhbb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb007
            
            #add-point:AFTER FIELD mhbb007 name="construct.a.page1.mhbb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb007
            #add-point:ON ACTION controlp INFIELD mhbb007 name="construct.c.page1.mhbb007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb010
            #add-point:ON ACTION controlp INFIELD mhbb010 name="construct.c.page1.mhbb010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2145'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbb010  #顯示到畫面上
            NEXT FIELD mhbb010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb010
            #add-point:BEFORE FIELD mhbb010 name="construct.b.page1.mhbb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb010
            
            #add-point:AFTER FIELD mhbb010 name="construct.a.page1.mhbb010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb008
            #add-point:BEFORE FIELD mhbb008 name="construct.b.page1.mhbb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb008
            
            #add-point:AFTER FIELD mhbb008 name="construct.a.page1.mhbb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb008
            #add-point:ON ACTION controlp INFIELD mhbb008 name="construct.c.page1.mhbb008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhbb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb001
            #add-point:ON ACTION controlp INFIELD mhbb001 name="construct.c.page1.mhbb001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbb001  #顯示到畫面上
            NEXT FIELD mhbb001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb001
            #add-point:BEFORE FIELD mhbb001 name="construct.b.page1.mhbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb001
            
            #add-point:AFTER FIELD mhbb001 name="construct.a.page1.mhbb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb002
            #add-point:ON ACTION controlp INFIELD mhbb002 name="construct.c.page1.mhbb002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbb002  #顯示到畫面上
            NEXT FIELD mhbb002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb002
            #add-point:BEFORE FIELD mhbb002 name="construct.b.page1.mhbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb002
            
            #add-point:AFTER FIELD mhbb002 name="construct.a.page1.mhbb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb003
            #add-point:ON ACTION controlp INFIELD mhbb003 name="construct.c.page1.mhbb003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhac003()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbb003  #顯示到畫面上
            NEXT FIELD mhbb003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb003
            #add-point:BEFORE FIELD mhbb003 name="construct.b.page1.mhbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb003
            
            #add-point:AFTER FIELD mhbb003 name="construct.a.page1.mhbb003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbbunit
            #add-point:BEFORE FIELD mhbbunit name="construct.b.page1.mhbbunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbbunit
            
            #add-point:AFTER FIELD mhbbunit name="construct.a.page1.mhbbunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbbunit
            #add-point:ON ACTION controlp INFIELD mhbbunit name="construct.c.page1.mhbbunit"
            
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
                  WHEN la_wc[li_idx].tableid = "mhba_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mhbb_t" 
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
 
{<section id="amht204.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION amht204_filter()
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
      CONSTRUCT g_wc_filter ON mhbasite,mhbadocdt,mhbadocno,mhba000,mhba004,mhba005
                          FROM s_browse[1].b_mhbasite,s_browse[1].b_mhbadocdt,s_browse[1].b_mhbadocno, 
                              s_browse[1].b_mhba000,s_browse[1].b_mhba004,s_browse[1].b_mhba005
 
         BEFORE CONSTRUCT
               DISPLAY amht204_filter_parser('mhbasite') TO s_browse[1].b_mhbasite
            DISPLAY amht204_filter_parser('mhbadocdt') TO s_browse[1].b_mhbadocdt
            DISPLAY amht204_filter_parser('mhbadocno') TO s_browse[1].b_mhbadocno
            DISPLAY amht204_filter_parser('mhba000') TO s_browse[1].b_mhba000
            DISPLAY amht204_filter_parser('mhba004') TO s_browse[1].b_mhba004
            DISPLAY amht204_filter_parser('mhba005') TO s_browse[1].b_mhba005
      
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
 
      CALL amht204_filter_show('mhbasite')
   CALL amht204_filter_show('mhbadocdt')
   CALL amht204_filter_show('mhbadocno')
   CALL amht204_filter_show('mhba000')
   CALL amht204_filter_show('mhba004')
   CALL amht204_filter_show('mhba005')
 
END FUNCTION
 
{</section>}
 
{<section id="amht204.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION amht204_filter_parser(ps_field)
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
 
{<section id="amht204.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION amht204_filter_show(ps_field)
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
   LET ls_condition = amht204_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="amht204.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION amht204_query()
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
   CALL g_mhbb_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL amht204_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL amht204_browser_fill("")
      CALL amht204_fetch("")
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
      CALL amht204_filter_show('mhbasite')
   CALL amht204_filter_show('mhbadocdt')
   CALL amht204_filter_show('mhbadocno')
   CALL amht204_filter_show('mhba000')
   CALL amht204_filter_show('mhba004')
   CALL amht204_filter_show('mhba005')
   CALL amht204_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL amht204_fetch("F") 
      #顯示單身筆數
      CALL amht204_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amht204.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION amht204_fetch(p_flag)
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
   
   LET g_mhba_m.mhbadocno = g_browser[g_current_idx].b_mhbadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE amht204_master_referesh USING g_mhba_m.mhbadocno INTO g_mhba_m.mhbasite,g_mhba_m.mhbadocdt, 
       g_mhba_m.mhbadocno,g_mhba_m.mhba000,g_mhba_m.mhba006,g_mhba_m.mhba004,g_mhba_m.mhba005,g_mhba_m.mhba001, 
       g_mhba_m.mhba002,g_mhba_m.mhba003,g_mhba_m.mhbaunit,g_mhba_m.mhbastus,g_mhba_m.mhbaownid,g_mhba_m.mhbaowndp, 
       g_mhba_m.mhbacrtid,g_mhba_m.mhbacrtdp,g_mhba_m.mhbacrtdt,g_mhba_m.mhbamodid,g_mhba_m.mhbamoddt, 
       g_mhba_m.mhbacnfid,g_mhba_m.mhbacnfdt,g_mhba_m.mhbasite_desc,g_mhba_m.mhba004_desc,g_mhba_m.mhba005_desc, 
       g_mhba_m.mhba001_desc,g_mhba_m.mhba002_desc,g_mhba_m.mhbaownid_desc,g_mhba_m.mhbaowndp_desc,g_mhba_m.mhbacrtid_desc, 
       g_mhba_m.mhbacrtdp_desc,g_mhba_m.mhbamodid_desc,g_mhba_m.mhbacnfid_desc
   
   #遮罩相關處理
   LET g_mhba_m_mask_o.* =  g_mhba_m.*
   CALL amht204_mhba_t_mask()
   LET g_mhba_m_mask_n.* =  g_mhba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amht204_set_act_visible()   
   CALL amht204_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mhba_m_t.* = g_mhba_m.*
   LET g_mhba_m_o.* = g_mhba_m.*
   
   LET g_data_owner = g_mhba_m.mhbaownid      
   LET g_data_dept  = g_mhba_m.mhbaowndp
   
   #重新顯示   
   CALL amht204_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="amht204.insert" >}
#+ 資料新增
PRIVATE FUNCTION amht204_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_doctype  LIKE rtai_t.rtai004
   DEFINE l_insert   LIKE type_t.num5
   DEFINE  l_cnt                 LIKE type_t.num10
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mhbb_d.clear()   
 
 
   INITIALIZE g_mhba_m.* TO NULL             #DEFAULT 設定
   
   LET g_mhbadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mhba_m.mhbaownid = g_user
      LET g_mhba_m.mhbaowndp = g_dept
      LET g_mhba_m.mhbacrtid = g_user
      LET g_mhba_m.mhbacrtdp = g_dept 
      LET g_mhba_m.mhbacrtdt = cl_get_current()
      LET g_mhba_m.mhbamodid = g_user
      LET g_mhba_m.mhbamoddt = cl_get_current()
      LET g_mhba_m.mhbastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mhba_m.mhba000 = "I"
 
  
      #add-point:單頭預設值 name="insert.default"
      #營運組織
      CALL s_aooi500_default(g_prog,'mhbasite',g_mhba_m.mhbasite)
         RETURNING l_insert,g_mhba_m.mhbasite
      IF NOT l_insert THEN
         RETURN
      END IF
      CALL s_desc_get_department_desc(g_mhba_m.mhbasite) RETURNING g_mhba_m.mhbasite_desc
      DISPLAY BY NAME g_mhba_m.mhbasite_desc
      
      #單據日期
      LET g_mhba_m.mhbadocdt = g_today
      
      #單別
      CALL s_arti200_get_def_doc_type(g_mhba_m.mhbasite,g_prog,'1')
         RETURNING l_success,l_doctype
      LET g_mhba_m.mhbadocno = l_doctype
      DISPLAY BY NAME g_mhba_m.mhbadocno
      
      #業務人員
      LET g_mhba_m.mhba004 = g_user
      CALL s_desc_get_person_desc(g_mhba_m.mhba004) RETURNING g_mhba_m.mhba004_desc
      DISPLAY BY NAME g_mhba_m.mhba004_desc
      
      #部門
      LET g_mhba_m.mhba005 = g_dept
      CALL s_desc_get_department_desc(g_mhba_m.mhba005) RETURNING g_mhba_m.mhba005_desc
      DISPLAY BY NAME g_mhba_m.mhba005_desc
      
      LET g_site_flag = FALSE
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mhba_m_t.* = g_mhba_m.*
      LET g_mhba_m_o.* = g_mhba_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mhba_m.mhbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL amht204_input("a")
      
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
         INITIALIZE g_mhba_m.* TO NULL
         INITIALIZE g_mhbb_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL amht204_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mhbb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amht204_set_act_visible()   
   CALL amht204_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mhbadocno_t = g_mhba_m.mhbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mhbaent = " ||g_enterprise|| " AND",
                      " mhbadocno = '", g_mhba_m.mhbadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amht204_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE amht204_cl
   
   CALL amht204_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE amht204_master_referesh USING g_mhba_m.mhbadocno INTO g_mhba_m.mhbasite,g_mhba_m.mhbadocdt, 
       g_mhba_m.mhbadocno,g_mhba_m.mhba000,g_mhba_m.mhba006,g_mhba_m.mhba004,g_mhba_m.mhba005,g_mhba_m.mhba001, 
       g_mhba_m.mhba002,g_mhba_m.mhba003,g_mhba_m.mhbaunit,g_mhba_m.mhbastus,g_mhba_m.mhbaownid,g_mhba_m.mhbaowndp, 
       g_mhba_m.mhbacrtid,g_mhba_m.mhbacrtdp,g_mhba_m.mhbacrtdt,g_mhba_m.mhbamodid,g_mhba_m.mhbamoddt, 
       g_mhba_m.mhbacnfid,g_mhba_m.mhbacnfdt,g_mhba_m.mhbasite_desc,g_mhba_m.mhba004_desc,g_mhba_m.mhba005_desc, 
       g_mhba_m.mhba001_desc,g_mhba_m.mhba002_desc,g_mhba_m.mhbaownid_desc,g_mhba_m.mhbaowndp_desc,g_mhba_m.mhbacrtid_desc, 
       g_mhba_m.mhbacrtdp_desc,g_mhba_m.mhbamodid_desc,g_mhba_m.mhbacnfid_desc
   
   
   #遮罩相關處理
   LET g_mhba_m_mask_o.* =  g_mhba_m.*
   CALL amht204_mhba_t_mask()
   LET g_mhba_m_mask_n.* =  g_mhba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mhba_m.mhbasite,g_mhba_m.mhbasite_desc,g_mhba_m.mhbadocdt,g_mhba_m.mhbadocno,g_mhba_m.mhba000, 
       g_mhba_m.mhba006,g_mhba_m.mhba004,g_mhba_m.mhba004_desc,g_mhba_m.mhba005,g_mhba_m.mhba005_desc, 
       g_mhba_m.mhba001,g_mhba_m.mhba001_desc,g_mhba_m.mhba002,g_mhba_m.mhba002_desc,g_mhba_m.mhba003, 
       g_mhba_m.mhba003_desc,g_mhba_m.mhbaunit,g_mhba_m.mhbastus,g_mhba_m.mhbaownid,g_mhba_m.mhbaownid_desc, 
       g_mhba_m.mhbaowndp,g_mhba_m.mhbaowndp_desc,g_mhba_m.mhbacrtid,g_mhba_m.mhbacrtid_desc,g_mhba_m.mhbacrtdp, 
       g_mhba_m.mhbacrtdp_desc,g_mhba_m.mhbacrtdt,g_mhba_m.mhbamodid,g_mhba_m.mhbamodid_desc,g_mhba_m.mhbamoddt, 
       g_mhba_m.mhbacnfid,g_mhba_m.mhbacnfid_desc,g_mhba_m.mhbacnfdt
   
   #add-point:新增結束後 name="insert.after"
   #add by geza 20160615(S)
   #单身没有数据直接删除单头的资料   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM mhbb_t
    WHERE mhbbent = g_enterprise
      AND mhbbdocno = g_mhba_m.mhbadocno
   IF l_cnt <= 0 THEN
      CALL s_transaction_begin()
      DELETE FROM mhba_t WHERE mhbaent=g_enterprise AND mhbadocno=g_mhba_m.mhbadocno 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "DELETE mhba_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0') 
      ELSE
         CALL s_transaction_end('Y','0')
         CALL amht204_browser_fill("")        
      END IF
   END IF  
   #add by geza 20160615(E)
   #end add-point 
   
   LET g_data_owner = g_mhba_m.mhbaownid      
   LET g_data_dept  = g_mhba_m.mhbaowndp
   
   #功能已完成,通報訊息中心
   CALL amht204_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="amht204.modify" >}
#+ 資料修改
PRIVATE FUNCTION amht204_modify()
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
   LET g_mhba_m_t.* = g_mhba_m.*
   LET g_mhba_m_o.* = g_mhba_m.*
   
   IF g_mhba_m.mhbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mhbadocno_t = g_mhba_m.mhbadocno
 
   CALL s_transaction_begin()
   
   OPEN amht204_cl USING g_enterprise,g_mhba_m.mhbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amht204_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amht204_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amht204_master_referesh USING g_mhba_m.mhbadocno INTO g_mhba_m.mhbasite,g_mhba_m.mhbadocdt, 
       g_mhba_m.mhbadocno,g_mhba_m.mhba000,g_mhba_m.mhba006,g_mhba_m.mhba004,g_mhba_m.mhba005,g_mhba_m.mhba001, 
       g_mhba_m.mhba002,g_mhba_m.mhba003,g_mhba_m.mhbaunit,g_mhba_m.mhbastus,g_mhba_m.mhbaownid,g_mhba_m.mhbaowndp, 
       g_mhba_m.mhbacrtid,g_mhba_m.mhbacrtdp,g_mhba_m.mhbacrtdt,g_mhba_m.mhbamodid,g_mhba_m.mhbamoddt, 
       g_mhba_m.mhbacnfid,g_mhba_m.mhbacnfdt,g_mhba_m.mhbasite_desc,g_mhba_m.mhba004_desc,g_mhba_m.mhba005_desc, 
       g_mhba_m.mhba001_desc,g_mhba_m.mhba002_desc,g_mhba_m.mhbaownid_desc,g_mhba_m.mhbaowndp_desc,g_mhba_m.mhbacrtid_desc, 
       g_mhba_m.mhbacrtdp_desc,g_mhba_m.mhbamodid_desc,g_mhba_m.mhbacnfid_desc
   
   #檢查是否允許此動作
   IF NOT amht204_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mhba_m_mask_o.* =  g_mhba_m.*
   CALL amht204_mhba_t_mask()
   LET g_mhba_m_mask_n.* =  g_mhba_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   LET g_site_flag = TRUE
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL amht204_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_mhbadocno_t = g_mhba_m.mhbadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mhba_m.mhbamodid = g_user 
LET g_mhba_m.mhbamoddt = cl_get_current()
LET g_mhba_m.mhbamodid_desc = cl_get_username(g_mhba_m.mhbamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL amht204_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mhba_t SET (mhbamodid,mhbamoddt) = (g_mhba_m.mhbamodid,g_mhba_m.mhbamoddt)
          WHERE mhbaent = g_enterprise AND mhbadocno = g_mhbadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mhba_m.* = g_mhba_m_t.*
            CALL amht204_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mhba_m.mhbadocno != g_mhba_m_t.mhbadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mhbb_t SET mhbbdocno = g_mhba_m.mhbadocno
 
          WHERE mhbbent = g_enterprise AND mhbbdocno = g_mhba_m_t.mhbadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mhbb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mhbb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'mhbblent'
LET l_new_key[02] = g_mhba_m.mhbadocno
LET l_old_key[02] = g_mhbadocno_t
LET l_field_key[02] = 'mhbbldocno'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'mhbbl_t')
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amht204_set_act_visible()   
   CALL amht204_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mhbaent = " ||g_enterprise|| " AND",
                      " mhbadocno = '", g_mhba_m.mhbadocno, "' "
 
   #填到對應位置
   CALL amht204_browser_fill("")
 
   CLOSE amht204_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amht204_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="amht204.input" >}
#+ 資料輸入
PRIVATE FUNCTION amht204_input(p_cmd)
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
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_sql                 STRING
   DEFINE  l_where               STRING
   DEFINE  l_oofg_return         DYNAMIC ARRAY OF RECORD
           oofg019               LIKE oofg_t.oofg019,  #field
           oofg020               LIKE oofg_t.oofg020   #value
                                 END RECORD
   DEFINE  l_area                LIKE type_t.chr1   #160604-00009#163
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
   DISPLAY BY NAME g_mhba_m.mhbasite,g_mhba_m.mhbasite_desc,g_mhba_m.mhbadocdt,g_mhba_m.mhbadocno,g_mhba_m.mhba000, 
       g_mhba_m.mhba006,g_mhba_m.mhba004,g_mhba_m.mhba004_desc,g_mhba_m.mhba005,g_mhba_m.mhba005_desc, 
       g_mhba_m.mhba001,g_mhba_m.mhba001_desc,g_mhba_m.mhba002,g_mhba_m.mhba002_desc,g_mhba_m.mhba003, 
       g_mhba_m.mhba003_desc,g_mhba_m.mhbaunit,g_mhba_m.mhbastus,g_mhba_m.mhbaownid,g_mhba_m.mhbaownid_desc, 
       g_mhba_m.mhbaowndp,g_mhba_m.mhbaowndp_desc,g_mhba_m.mhbacrtid,g_mhba_m.mhbacrtid_desc,g_mhba_m.mhbacrtdp, 
       g_mhba_m.mhbacrtdp_desc,g_mhba_m.mhbacrtdt,g_mhba_m.mhbamodid,g_mhba_m.mhbamodid_desc,g_mhba_m.mhbamoddt, 
       g_mhba_m.mhbacnfid,g_mhba_m.mhbacnfid_desc,g_mhba_m.mhbacnfdt
   
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
   LET g_forupd_sql = "SELECT mhbbacti,mhbbsite,mhbb004,mhbb009,mhbb005,mhbb006,mhbb007,mhbb010,mhbb008, 
       mhbb001,mhbb002,mhbb003,mhbbunit FROM mhbb_t WHERE mhbbent=? AND mhbbdocno=? AND mhbb004=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amht204_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL amht204_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL amht204_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mhba_m.mhbasite,g_mhba_m.mhbadocdt,g_mhba_m.mhbadocno,g_mhba_m.mhba000,g_mhba_m.mhba006, 
       g_mhba_m.mhba004,g_mhba_m.mhba005,g_mhba_m.mhba001,g_mhba_m.mhba002,g_mhba_m.mhba003,g_mhba_m.mhbaunit, 
       g_mhba_m.mhbastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="amht204.input.head" >}
      #單頭段
      INPUT BY NAME g_mhba_m.mhbasite,g_mhba_m.mhbadocdt,g_mhba_m.mhbadocno,g_mhba_m.mhba000,g_mhba_m.mhba006, 
          g_mhba_m.mhba004,g_mhba_m.mhba005,g_mhba_m.mhba001,g_mhba_m.mhba002,g_mhba_m.mhba003,g_mhba_m.mhbaunit, 
          g_mhba_m.mhbastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN amht204_cl USING g_enterprise,g_mhba_m.mhbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amht204_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amht204_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL amht204_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL amht204_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbasite
            
            #add-point:AFTER FIELD mhbasite name="input.a.mhbasite"
            LET g_mhba_m.mhbasite_desc = ' '
            DISPLAY BY NAME g_mhba_m.mhbasite_desc
            IF cl_null(g_mhba_m.mhbasite) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'sub-00507'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET g_mhba_m.mhbasite = g_mhba_m_t.mhbasite
               CALL s_desc_get_department_desc(g_mhba_m.mhbasite)
                  RETURNING g_mhba_m.mhbasite_desc
               DISPLAY BY NAME g_mhba_m.mhbasite_desc
               NEXT FIELD CURRENT
            ELSE
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mhba_m.mhbasite != g_mhba_m_t.mhbasite OR g_mhba_m_t.mhbasite IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,'mhbasite',g_mhba_m.mhbasite,g_mhba_m.mhbasite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     
                     LET g_mhba_m.mhbasite = g_mhba_m_t.mhbasite
                     CALL s_desc_get_department_desc(g_mhba_m.mhbasite)
                        RETURNING g_mhba_m.mhbasite_desc
                     DISPLAY BY NAME g_mhba_m.mhbasite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_site_flag = TRUE
            CALL s_desc_get_department_desc(g_mhba_m.mhbasite)
               RETURNING g_mhba_m.mhbasite_desc
            DISPLAY BY NAME g_mhba_m.mhbasite_desc
            CALL amht204_set_entry(p_cmd)
            CALL amht204_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbasite
            #add-point:BEFORE FIELD mhbasite name="input.b.mhbasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbasite
            #add-point:ON CHANGE mhbasite name="input.g.mhbasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbadocdt
            #add-point:BEFORE FIELD mhbadocdt name="input.b.mhbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbadocdt
            
            #add-point:AFTER FIELD mhbadocdt name="input.a.mhbadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbadocdt
            #add-point:ON CHANGE mhbadocdt name="input.g.mhbadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbadocno
            #add-point:BEFORE FIELD mhbadocno name="input.b.mhbadocno"
            LET l_ooef004 = ''
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_mhba_m.mhbasite
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbadocno
            
            #add-point:AFTER FIELD mhbadocno name="input.a.mhbadocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_mhba_m.mhbadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mhba_m.mhbadocno != g_mhbadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhba_t WHERE "||"mhbaent = '" ||g_enterprise|| "' AND "||"mhbadocno = '"||g_mhba_m.mhbadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT s_aooi200_chk_slip(g_mhba_m.mhbasite,'',g_mhba_m.mhbadocno,g_prog) THEN
                     LET g_mhba_m.mhbadocno = g_mhbadocno_t
                     NEXT FIELD CURRENT   
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbadocno
            #add-point:ON CHANGE mhbadocno name="input.g.mhbadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhba000
            #add-point:BEFORE FIELD mhba000 name="input.b.mhba000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhba000
            
            #add-point:AFTER FIELD mhba000 name="input.a.mhba000"
            IF NOT cl_null(g_mhba_m.mhba000) THEN
               IF g_mhba_m.mhba000 != g_mhba_m_o.mhba000 OR cl_null(g_mhba_m_o.mhba000) THEN
                  #mark by geza 20160615 #160604-00009#27(S)
#                  LET l_cnt = 0
#                  SELECT COUNT(1) INTO l_cnt
#                    FROM mhba_t
#                   WHERE mhbaent = g_enterprise
#                     AND mhbadocno != g_mhba_m.mhbadocno
#                     AND mhbastus = 'N'
#                     AND mhba000 = g_mhba_m.mhba000
#                  IF l_cnt >= 1 THEN 
#                     # 已經存在一筆以上作業類型%1的未確認單據！
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = "amh-00635"
#                     LET g_errparam.extend = ""
#                     LET g_errparam.popup = TRUE
#                     LET g_errparam.replace[1] = g_mhba_m.mhba000
#                     CALL cl_err()
#                     NEXT FIELD CURRENT
#                  END IF
                  #mark by geza 20160615 #160604-00009#27(E)
                  IF g_mhba_m.mhba000 = 'I' THEN
                     LET g_mhba_m.mhba006 = ''
                  END IF
               END IF
            END IF
            CALL amht204_set_entry(p_cmd)
            CALL amht204_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhba000
            #add-point:ON CHANGE mhba000 name="input.g.mhba000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhba006
            #add-point:BEFORE FIELD mhba006 name="input.b.mhba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhba006
            
            #add-point:AFTER FIELD mhba006 name="input.a.mhba006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhba006
            #add-point:ON CHANGE mhba006 name="input.g.mhba006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhba004
            
            #add-point:AFTER FIELD mhba004 name="input.a.mhba004"
            LET g_mhba_m.mhba004_desc = ''
            DISPLAY BY NAME g_mhba_m.mhba004_desc
            IF NOT cl_null(g_mhba_m.mhba004) THEN
               IF g_mhba_m.mhba004 != g_mhba_m_o.mhba004 OR cl_null(g_mhba_m_o.mhba004) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhba_m.mhba004
                  #160318-00025#36  2016/04/19  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#36  2016/04/19  by pengxin  add(E)
                  IF cl_chk_exist("v_ooag001") THEN
                     CALL amht204_mhba004_def(g_mhba_m.mhba004) RETURNING g_mhba_m.mhba005
                     CALL s_desc_get_person_desc(g_mhba_m.mhba005) RETURNING g_mhba_m.mhba005_desc
                     DISPLAY BY NAME g_mhba_m.mhba005_desc   
                  ELSE
                     LET g_mhba_m.mhba004 = g_mhba_m_o.mhba004
                     CALL s_desc_get_person_desc(g_mhba_m.mhba004) RETURNING g_mhba_m.mhba004_desc
                     DISPLAY BY NAME g_mhba_m.mhba004_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_mhba_m.mhba004) RETURNING g_mhba_m.mhba004_desc
            DISPLAY BY NAME g_mhba_m.mhba004_desc
            LET g_mhba_m_o.mhba004 = g_mhba_m.mhba004
            LET g_mhba_m_o.mhba005 = g_mhba_m.mhba005
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhba004
            #add-point:BEFORE FIELD mhba004 name="input.b.mhba004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhba004
            #add-point:ON CHANGE mhba004 name="input.g.mhba004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhba005
            
            #add-point:AFTER FIELD mhba005 name="input.a.mhba005"
            LET g_mhba_m.mhba005_desc = ''
            DISPLAY BY NAME g_mhba_m.mhba005_desc
            IF NOT cl_null(g_mhba_m.mhba005) THEN
               IF g_mhba_m.mhba005 != g_mhba_m_o.mhba005 OR cl_null(g_mhba_m_o.mhba005) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhba_m.mhba005
                  LET g_chkparam.arg2 = g_mhba_m.mhbadocdt
                  #160318-00025#36  2016/04/19  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#36  2016/04/19  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_mhba_m.mhba005 = g_mhba_m_t.mhba005
                     CALL s_desc_get_department_desc(g_mhba_m.mhba005) RETURNING g_mhba_m.mhba005_desc
                     DISPLAY BY NAME g_mhba_m.mhba005_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_mhba_m.mhba005) RETURNING g_mhba_m.mhba005_desc
            DISPLAY BY NAME g_mhba_m.mhba005_desc
            LET g_mhba_m_o.mhba005 = g_mhba_m.mhba005
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhba005
            #add-point:BEFORE FIELD mhba005 name="input.b.mhba005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhba005
            #add-point:ON CHANGE mhba005 name="input.g.mhba005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhba001
            
            #add-point:AFTER FIELD mhba001 name="input.a.mhba001"
            LET g_mhba_m.mhba001_desc = ''
            DISPLAY BY NAME g_mhba_m.mhba001_desc
            IF cl_null(g_mhba_m.mhba001) THEN
               LET g_mhba_m.mhba002 = ''
               LET g_mhba_m.mhba002_desc = ''
               LET g_mhba_m.mhba003 = ''
               LET g_mhba_m.mhba003_desc = ''
               DISPLAY BY NAME g_mhba_m.mhba002,g_mhba_m.mhba002_desc,
                               g_mhba_m.mhba003,g_mhba_m.mhba003_desc
            ELSE
               IF g_mhba_m.mhba001 != g_mhba_m_o.mhba001 OR cl_null(g_mhba_m_o.mhba001) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhba_m.mhba001
                  LET g_chkparam.arg2 = g_mhba_m.mhbasite
                  IF NOT cl_chk_exist("v_mhaa001") THEN
                     LET g_mhba_m.mhba001 = g_mhba_m_o.mhba001
                     CALL amht204_mhaal003(g_mhba_m.mhba001) RETURNING g_mhba_m.mhba001_desc
                     DISPLAY BY NAME g_mhba_m.mhba001_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_mhba_m.mhba002 = ''
                  LET g_mhba_m.mhba002_desc = ''
                  LET g_mhba_m.mhba003 = ''
                  LET g_mhba_m.mhba003_desc = ''
                  DISPLAY BY NAME g_mhba_m.mhba002,g_mhba_m.mhba002_desc,
                                  g_mhba_m.mhba003,g_mhba_m.mhba003_desc
               END IF
            END IF
            CALL amht204_mhaal003(g_mhba_m.mhba001) RETURNING g_mhba_m.mhba001_desc
            DISPLAY BY NAME g_mhba_m.mhba001_desc
            LET g_mhba_m_o.mhba001 = g_mhba_m.mhba001
            LET g_mhba_m_o.mhba002 = g_mhba_m.mhba002
            LET g_mhba_m_o.mhba003 = g_mhba_m.mhba003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhba001
            #add-point:BEFORE FIELD mhba001 name="input.b.mhba001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhba001
            #add-point:ON CHANGE mhba001 name="input.g.mhba001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhba002
            
            #add-point:AFTER FIELD mhba002 name="input.a.mhba002"
            LET g_mhba_m.mhba002_desc = ''
            DISPLAY BY NAME g_mhba_m.mhba002_desc
            IF cl_null(g_mhba_m.mhba002) THEN
               LET g_mhba_m.mhba003 = ''
               LET g_mhba_m.mhba003_desc = ''
               DISPLAY BY NAME g_mhba_m.mhba003,g_mhba_m.mhba003_desc
            ELSE
               IF g_mhba_m.mhba002 != g_mhba_m_o.mhba002 OR cl_null(g_mhba_m_o.mhba002) THEN
                  IF cl_null(g_mhba_m.mhba001) THEN
                     LET g_mhba_m.mhba002 = ''
                     LET g_mhba_m_o.mhba002 = g_mhba_m.mhba002
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amh-00645'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD mhba001
                  END IF
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhba_m.mhba002
                  LET g_chkparam.arg2 = g_mhba_m.mhba001
                  IF NOT cl_chk_exist("v_mhab002") THEN
                     LET g_mhba_m.mhba002 = g_mhba_m_o.mhba002
                     CALL amht204_mhabl004(g_mhba_m.mhba001,g_mhba_m.mhba002) RETURNING g_mhba_m.mhba002_desc
                     DISPLAY BY NAME g_mhba_m.mhba002_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_mhba_m.mhba003 = ''
                  LET g_mhba_m.mhba003_desc = ''
                  DISPLAY BY NAME g_mhba_m.mhba003,g_mhba_m.mhba003_desc
               END IF
            END IF
            CALL amht204_mhabl004(g_mhba_m.mhba001,g_mhba_m.mhba002) RETURNING g_mhba_m.mhba002_desc
            DISPLAY BY NAME g_mhba_m.mhba002_desc
            LET g_mhba_m_o.mhba002 = g_mhba_m.mhba002
            LET g_mhba_m_o.mhba003 = g_mhba_m.mhba003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhba002
            #add-point:BEFORE FIELD mhba002 name="input.b.mhba002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhba002
            #add-point:ON CHANGE mhba002 name="input.g.mhba002"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhba003
            
            #add-point:AFTER FIELD mhba003 name="input.a.mhba003"
            LET g_mhba_m.mhba003_desc = ''
            DISPLAY BY NAME g_mhba_m.mhba003_desc
            IF cl_null(g_mhba_m.mhba003) THEN
               LET g_mhba_m.mhba003 = ' '
            ELSE
               IF g_mhba_m.mhba003 != g_mhba_m_o.mhba003 OR cl_null(g_mhba_m_o.mhba003) THEN
                  IF cl_null(g_mhba_m.mhba001) THEN
                     LET g_mhba_m.mhba003 = ''
                     LET g_mhba_m_o.mhba003 = g_mhba_m.mhba003
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amh-00645'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD mhba001
                  END IF
                  IF cl_null(g_mhba_m.mhba002) THEN
                     LET g_mhba_m.mhba003 = ''
                     LET g_mhba_m_o.mhba003 = g_mhba_m.mhba003
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amh-00646'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD mhba002
                  END IF
                  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhba_m.mhba003
                  LET g_chkparam.arg2 = g_mhba_m.mhba001
                  LET g_chkparam.arg3 = g_mhba_m.mhba002
                  
                  IF NOT cl_chk_exist("v_mhac003") THEN
                     LET g_mhba_m.mhba003 = g_mhba_m_o.mhba003
                     CALL amht204_mhacl005(g_mhba_m.mhba001,g_mhba_m.mhba002,g_mhba_m.mhba003)
                        RETURNING g_mhba_m.mhba003_desc
                     DISPLAY BY NAME g_mhba_m.mhba003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL amht204_mhacl005(g_mhba_m.mhba001,g_mhba_m.mhba002,g_mhba_m.mhba003)
               RETURNING g_mhba_m.mhba003_desc
            DISPLAY BY NAME g_mhba_m.mhba003_desc
            LET g_mhba_m_o.mhba003 = g_mhba_m.mhba003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhba003
            #add-point:BEFORE FIELD mhba003 name="input.b.mhba003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhba003
            #add-point:ON CHANGE mhba003 name="input.g.mhba003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbaunit
            #add-point:BEFORE FIELD mhbaunit name="input.b.mhbaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbaunit
            
            #add-point:AFTER FIELD mhbaunit name="input.a.mhbaunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbaunit
            #add-point:ON CHANGE mhbaunit name="input.g.mhbaunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbastus
            #add-point:BEFORE FIELD mhbastus name="input.b.mhbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbastus
            
            #add-point:AFTER FIELD mhbastus name="input.a.mhbastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbastus
            #add-point:ON CHANGE mhbastus name="input.g.mhbastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mhbasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbasite
            #add-point:ON ACTION controlp INFIELD mhbasite name="input.c.mhbasite"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhba_m.mhbasite
            
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhbasite',g_site,'i')
            CALL q_ooef001_24()
            LET g_mhba_m.mhbasite = g_qryparam.return1  
            DISPLAY g_mhba_m.mhbasite TO mhbasite
            CALL s_desc_get_department_desc(g_mhba_m.mhbasite)
               RETURNING g_mhba_m.mhbasite_desc
            DISPLAY BY NAME g_mhba_m.mhbasite_desc
            NEXT FIELD mhbasite
            #END add-point
 
 
         #Ctrlp:input.c.mhbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbadocdt
            #add-point:ON ACTION controlp INFIELD mhbadocdt name="input.c.mhbadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbadocno
            #add-point:ON ACTION controlp INFIELD mhbadocno name="input.c.mhbadocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhba_m.mhbadocno
            
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = g_prog
            CALL q_ooba002_1()
            LET g_mhba_m.mhbadocno = g_qryparam.return1 
            DISPLAY g_mhba_m.mhbadocno TO mhbadocno
            NEXT FIELD mhbadocno
            #END add-point
 
 
         #Ctrlp:input.c.mhba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhba000
            #add-point:ON ACTION controlp INFIELD mhba000 name="input.c.mhba000"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhba006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhba006
            #add-point:ON ACTION controlp INFIELD mhba006 name="input.c.mhba006"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhba004
            #add-point:ON ACTION controlp INFIELD mhba004 name="input.c.mhba004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhba_m.mhba004
            
            CALL q_ooag001()
            LET g_mhba_m.mhba004 = g_qryparam.return1
            DISPLAY g_mhba_m.mhba004 TO mhba004
            CALL s_desc_get_person_desc(g_mhba_m.mhba004)
               RETURNING g_mhba_m.mhba004_desc
            DISPLAY BY NAME g_mhba_m.mhba004_desc
            NEXT FIELD mhba004
            #END add-point
 
 
         #Ctrlp:input.c.mhba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhba005
            #add-point:ON ACTION controlp INFIELD mhba005 name="input.c.mhba005"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhba_m.mhba005
            
            LET g_qryparam.arg1 = g_mhba_m.mhbadocdt
            CALL q_ooeg001()                                #呼叫開窗
 
            LET g_mhba_m.mhba005 = g_qryparam.return1
            DISPLAY g_mhba_m.mhba005 TO mhba005
            CALL s_desc_get_department_desc(g_mhba_m.mhba005)
               RETURNING g_mhba_m.mhba005_desc
            DISPLAY BY NAME g_mhba_m.mhba005_desc
            NEXT FIELD mhba005
            #END add-point
 
 
         #Ctrlp:input.c.mhba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhba001
            #add-point:ON ACTION controlp INFIELD mhba001 name="input.c.mhba001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhba_m.mhba001
            
            LET g_qryparam.where = " mhaasite = '",g_mhba_m.mhbasite,"'"
            CALL q_mhaa001()
            LET g_mhba_m.mhba001 = g_qryparam.return1
            DISPLAY g_mhba_m.mhba001 TO mhba001
            CALL amht204_mhaal003(g_mhba_m.mhba001) RETURNING g_mhba_m.mhba001_desc
            DISPLAY BY NAME g_mhba_m.mhba001_desc
            NEXT FIELD mhba001
            #END add-point
 
 
         #Ctrlp:input.c.mhba002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhba002
            #add-point:ON ACTION controlp INFIELD mhba002 name="input.c.mhba002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            IF cl_null(g_mhba_m.mhba001) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amh-00645'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD mhba001
            END IF
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhba_m.mhba002
            
            LET g_qryparam.where = "mhab001='",g_mhba_m.mhba001,"'"
            CALL q_mhab002()
            LET g_mhba_m.mhba002 = g_qryparam.return1
            DISPLAY g_mhba_m.mhba002 TO mhba002
            CALL amht204_mhabl004(g_mhba_m.mhba001,g_mhba_m.mhba002) RETURNING g_mhba_m.mhba002_desc
            DISPLAY BY NAME g_mhba_m.mhba002_desc
            NEXT FIELD mhba002
            #END add-point
 
 
         #Ctrlp:input.c.mhba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhba003
            #add-point:ON ACTION controlp INFIELD mhba003 name="input.c.mhba003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            IF cl_null(g_mhba_m.mhba001) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amh-00645'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD mhba001
            END IF
            IF cl_null(g_mhba_m.mhba002) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amh-00646'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD mhba002
            END IF
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhba_m.mhba003
            
            LET g_qryparam.where = "     mhac001 = '",g_mhba_m.mhba001,"'",
                                   " AND mhac002 = '",g_mhba_m.mhba002,"'"
            CALL q_mhac003()
            LET g_mhba_m.mhba003 = g_qryparam.return1 
            DISPLAY g_mhba_m.mhba003 TO mhba003
            CALL amht204_mhacl005(g_mhba_m.mhba001,g_mhba_m.mhba002,g_mhba_m.mhba003) RETURNING g_mhba_m.mhba003_desc
            DISPLAY BY NAME g_mhba_m.mhba003_desc
            NEXT FIELD mhba003
            #END add-point
 
 
         #Ctrlp:input.c.mhbaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbaunit
            #add-point:ON ACTION controlp INFIELD mhbaunit name="input.c.mhbaunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbastus
            #add-point:ON ACTION controlp INFIELD mhbastus name="input.c.mhbastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mhba_m.mhbadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
 
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               LET g_mhba_m.mhbaunit = g_mhba_m.mhbasite
               IF cl_null(g_mhba_m.mhba003) THEN
                  LET g_mhba_m.mhba003 = ' '
               END IF
               #mark by geza 20160615 #160604-00009#27(S)
#               LET l_cnt = 0
#               SELECT COUNT(1) INTO l_cnt
#                 FROM mhba_t
#                WHERE mhbaent = g_enterprise
#                  AND mhbadocno != g_mhba_m.mhbadocno
#                  AND mhbastus = 'N'
#                  AND mhba000 = g_mhba_m.mhba000
#               IF l_cnt >= 1 THEN 
#                  # 已經存在一筆以上作業類型%1的未確認單據！
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = "amh-00635"
#                  LET g_errparam.extend = ""
#                  LET g_errparam.popup = TRUE
#                  LET g_errparam.replace[1] = g_mhba_m.mhba000
#                  CALL cl_err()
#                  NEXT FIELD CURRENT
#               END IF
               #mark by geza 20160615 #160604-00009#27(E)
               CALL s_aooi200_gen_docno(g_mhba_m.mhbasite,g_mhba_m.mhbadocno,g_mhba_m.mhbadocdt,g_prog)
                  RETURNING l_success,g_mhba_m.mhbadocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_mhba_m.mhbadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD mhbadocno           
               END IF
               #end add-point
               
               INSERT INTO mhba_t (mhbaent,mhbasite,mhbadocdt,mhbadocno,mhba000,mhba006,mhba004,mhba005, 
                   mhba001,mhba002,mhba003,mhbaunit,mhbastus,mhbaownid,mhbaowndp,mhbacrtid,mhbacrtdp, 
                   mhbacrtdt,mhbamodid,mhbamoddt,mhbacnfid,mhbacnfdt)
               VALUES (g_enterprise,g_mhba_m.mhbasite,g_mhba_m.mhbadocdt,g_mhba_m.mhbadocno,g_mhba_m.mhba000, 
                   g_mhba_m.mhba006,g_mhba_m.mhba004,g_mhba_m.mhba005,g_mhba_m.mhba001,g_mhba_m.mhba002, 
                   g_mhba_m.mhba003,g_mhba_m.mhbaunit,g_mhba_m.mhbastus,g_mhba_m.mhbaownid,g_mhba_m.mhbaowndp, 
                   g_mhba_m.mhbacrtid,g_mhba_m.mhbacrtdp,g_mhba_m.mhbacrtdt,g_mhba_m.mhbamodid,g_mhba_m.mhbamoddt, 
                   g_mhba_m.mhbacnfid,g_mhba_m.mhbacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mhba_m:",SQLERRMESSAGE 
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
                  CALL amht204_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL amht204_b_fill()
                  CALL amht204_b_fill2('0')
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
               CALL amht204_mhba_t_mask_restore('restore_mask_o')
               
               UPDATE mhba_t SET (mhbasite,mhbadocdt,mhbadocno,mhba000,mhba006,mhba004,mhba005,mhba001, 
                   mhba002,mhba003,mhbaunit,mhbastus,mhbaownid,mhbaowndp,mhbacrtid,mhbacrtdp,mhbacrtdt, 
                   mhbamodid,mhbamoddt,mhbacnfid,mhbacnfdt) = (g_mhba_m.mhbasite,g_mhba_m.mhbadocdt, 
                   g_mhba_m.mhbadocno,g_mhba_m.mhba000,g_mhba_m.mhba006,g_mhba_m.mhba004,g_mhba_m.mhba005, 
                   g_mhba_m.mhba001,g_mhba_m.mhba002,g_mhba_m.mhba003,g_mhba_m.mhbaunit,g_mhba_m.mhbastus, 
                   g_mhba_m.mhbaownid,g_mhba_m.mhbaowndp,g_mhba_m.mhbacrtid,g_mhba_m.mhbacrtdp,g_mhba_m.mhbacrtdt, 
                   g_mhba_m.mhbamodid,g_mhba_m.mhbamoddt,g_mhba_m.mhbacnfid,g_mhba_m.mhbacnfdt)
                WHERE mhbaent = g_enterprise AND mhbadocno = g_mhbadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mhba_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL amht204_mhba_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mhba_m_t)
               LET g_log2 = util.JSON.stringify(g_mhba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mhbadocno_t = g_mhba_m.mhbadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="amht204.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mhbb_d FROM s_detail1.*
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
               IF NOT cl_null(g_mhbb_d[l_ac].mhbb004)  THEN
                  CALL n_mhbbl(g_mhba_m.mhbadocno,g_mhbb_d[l_ac].mhbb004)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mhba_m.mhbadocno
                  LET g_ref_fields[2] = g_mhbb_d[l_ac].mhbb004

                  CALL ap_ref_array2(g_ref_fields," SELECT mhbbl003,mhbbl004 FROM mhbbl_t WHERE mhbblent = '"
                      ||g_enterprise||"' AND mhbbldocno = ?  AND mhbbl001 = ?  AND mhbbl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_mhbb_d[l_ac].mhbbl003 = g_rtn_fields[1]
                  LET g_mhbb_d[l_ac].mhbbl004 = g_rtn_fields[2]

                  DISPLAY BY NAME g_mhbb_d[l_ac].mhbbl003
                  DISPLAY BY NAME g_mhbb_d[l_ac].mhbbl004
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mhbb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amht204_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mhbb_d.getLength()
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
            OPEN amht204_cl USING g_enterprise,g_mhba_m.mhbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amht204_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amht204_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mhbb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mhbb_d[l_ac].mhbb004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mhbb_d_t.* = g_mhbb_d[l_ac].*  #BACKUP
               LET g_mhbb_d_o.* = g_mhbb_d[l_ac].*  #BACKUP
               CALL amht204_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL amht204_set_no_entry_b(l_cmd)
               IF NOT amht204_lock_b("mhbb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amht204_bcl INTO g_mhbb_d[l_ac].mhbbacti,g_mhbb_d[l_ac].mhbbsite,g_mhbb_d[l_ac].mhbb004, 
                      g_mhbb_d[l_ac].mhbb009,g_mhbb_d[l_ac].mhbb005,g_mhbb_d[l_ac].mhbb006,g_mhbb_d[l_ac].mhbb007, 
                      g_mhbb_d[l_ac].mhbb010,g_mhbb_d[l_ac].mhbb008,g_mhbb_d[l_ac].mhbb001,g_mhbb_d[l_ac].mhbb002, 
                      g_mhbb_d[l_ac].mhbb003,g_mhbb_d[l_ac].mhbbunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mhbb_d_t.mhbb004,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mhbb_d_mask_o[l_ac].* =  g_mhbb_d[l_ac].*
                  CALL amht204_mhbb_t_mask()
                  LET g_mhbb_d_mask_n[l_ac].* =  g_mhbb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amht204_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.mhbbldocno = g_mhba_m.mhbadocno
LET g_detail_multi_table_t.mhbbl001 = g_mhbb_d[l_ac].mhbb004
LET g_detail_multi_table_t.mhbbl002 = g_dlang
LET g_detail_multi_table_t.mhbbl003 = g_mhbb_d[l_ac].mhbbl003
LET g_detail_multi_table_t.mhbbl004 = g_mhbb_d[l_ac].mhbbl004
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'mhbblent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'mhbbldocno'
            LET l_var_keys[02] = g_mhba_m.mhbadocno
            LET l_field_keys[03] = 'mhbbl001'
            LET l_var_keys[03] = g_mhbb_d[l_ac].mhbb004
            LET l_field_keys[04] = 'mhbbl002'
            LET l_var_keys[04] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'mhbbl_t') THEN
               RETURN 
            END IF 
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mhbb_d[l_ac].* TO NULL 
            INITIALIZE g_mhbb_d_t.* TO NULL 
            INITIALIZE g_mhbb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_mhbb_d[l_ac].mhbbacti = "Y"
      LET g_mhbb_d[l_ac].mhbb009 = "1"
      LET g_mhbb_d[l_ac].mhbb005 = "0"
      LET g_mhbb_d[l_ac].mhbb008 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_mhbb_d[l_ac].mhbbsite = g_mhba_m.mhbasite
            LET g_mhbb_d[l_ac].mhbbunit = g_mhbb_d[l_ac].mhbbsite
            LET g_mhbb_d[l_ac].mhbb001 = g_mhba_m.mhba001
            
            LET g_mhbb_d[l_ac].mhbb002 = g_mhba_m.mhba002
            IF cl_null(g_mhba_m.mhba003) THEN
               LET g_mhbb_d[l_ac].mhbb003 = ' '
            ELSE
               LET g_mhbb_d[l_ac].mhbb003 = g_mhba_m.mhba003
               CALL amht204_mhacl005(g_mhbb_d[l_ac].mhbb001,g_mhbb_d[l_ac].mhbb002,g_mhbb_d[l_ac].mhbb003)
                  RETURNING g_mhbb_d[l_ac].mhbb003_desc
            END IF
            CALL amht204_mhaal003(g_mhbb_d[l_ac].mhbb001)
               RETURNING g_mhbb_d[l_ac].mhbb001_desc
            CALL amht204_mhabl004(g_mhbb_d[l_ac].mhbb001,g_mhbb_d[l_ac].mhbb002)
               RETURNING g_mhbb_d[l_ac].mhbb002_desc
            #160604-00009#163 -s by 08172
            LET l_area = cl_get_para(g_enterprise,g_mhba_m.mhbasite,'S-CIR-2034')
            IF l_area = 'Y' THEN
               CALL cl_set_comp_required("mhbb003",TRUE)
            ELSE
               CALL cl_set_comp_required("mhbb003",FALSE)
            END IF
            #160604-00009#163 -e by 08172
            #end add-point
            LET g_mhbb_d_t.* = g_mhbb_d[l_ac].*     #新輸入資料
            LET g_mhbb_d_o.* = g_mhbb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amht204_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL amht204_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mhbb_d[li_reproduce_target].* = g_mhbb_d[li_reproduce].*
 
               LET g_mhbb_d[li_reproduce_target].mhbb004 = NULL
 
            END IF
            
LET g_detail_multi_table_t.mhbbldocno = g_mhba_m.mhbadocno
LET g_detail_multi_table_t.mhbbl001 = g_mhbb_d[l_ac].mhbb004
LET g_detail_multi_table_t.mhbbl002 = g_dlang
LET g_detail_multi_table_t.mhbbl003 = g_mhbb_d[l_ac].mhbbl003
LET g_detail_multi_table_t.mhbbl004 = g_mhbb_d[l_ac].mhbbl004
 
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
            SELECT COUNT(1) INTO l_count FROM mhbb_t 
             WHERE mhbbent = g_enterprise AND mhbbdocno = g_mhba_m.mhbadocno
 
               AND mhbb004 = g_mhbb_d[l_ac].mhbb004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               IF cl_null(g_mhbb_d[l_ac].mhbb003) THEN
                  LET g_mhbb_d[l_ac].mhbb003 = ' '
               END IF
               
               IF g_mhba_m.mhba000 = 'I' THEN
                  CALL s_aooi390_get_auto_no('10',g_mhbb_d[l_ac].mhbb004)
                     RETURNING l_success, g_mhbb_d[l_ac].mhbb004
                  
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL s_aooi390_oofi_upd('10',g_mhbb_d[l_ac].mhbb004) RETURNING l_success
               END IF
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhba_m.mhbadocno
               LET gs_keys[2] = g_mhbb_d[g_detail_idx].mhbb004
               CALL amht204_insert_b('mhbb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               LET l_sql = " INSERT INTO mhbbl_t(mhbblent, mhbbldocno, mhbbl001, mhbbl002,",
                           "                     mhbbl003, mhbbl004)",
                           " SELECT mhadlent, '",g_mhba_m.mhbadocno,"', mhadl004, mhadl005,",
                           "        mhadl006, mhadl007",
                           "   FROM mhadl_t",
                           "  WHERE mhadlent = ",g_enterprise,
                           "    AND mhadl001 = '",g_mhbb_d[l_ac].mhbb001,"'",
                           "    AND mhadl002 = '",g_mhbb_d[l_ac].mhbb002,"'",
                           "    AND mhadl003 = '",g_mhbb_d[l_ac].mhbb003,"'",
                           "    AND mhadl004 = '",g_mhbb_d[l_ac].mhbb004,"'"
               PREPARE amht204_ins_mhbbl FROM l_sql
               EXECUTE amht204_ins_mhbbl
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "Ins mhbbl_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT
               END IF
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mhbb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mhbb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amht204_b_fill()
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhba_m.mhbadocno = g_detail_multi_table_t.mhbbldocno AND
         g_mhbb_d[l_ac].mhbb004 = g_detail_multi_table_t.mhbbl001 AND
         g_mhbb_d[l_ac].mhbbl003 = g_detail_multi_table_t.mhbbl003 AND
         g_mhbb_d[l_ac].mhbbl004 = g_detail_multi_table_t.mhbbl004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhbblent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhba_m.mhbadocno
            LET l_field_keys[02] = 'mhbbldocno'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhbbldocno
            LET l_var_keys[03] = g_mhbb_d[l_ac].mhbb004
            LET l_field_keys[03] = 'mhbbl001'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhbbl001
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'mhbbl002'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhbbl002
            LET l_vars[01] = g_mhbb_d[l_ac].mhbbl003
            LET l_fields[01] = 'mhbbl003'
            LET l_vars[02] = g_mhbb_d[l_ac].mhbbl004
            LET l_fields[02] = 'mhbbl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhbbl_t')
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
               #更新自動編碼最大流水號檔
               IF NOT cl_null(g_mhbb_d[l_ac].mhbb004) AND g_mhba_m.mhba000 = 'I' THEN
                  IF NOT s_aooi390_oofi_del('10',g_mhbb_d[l_ac].mhbb004) THEN
                     CANCEL DELETE
                  END IF
               END IF
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_mhba_m.mhbadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mhbb_d_t.mhbb004
 
            
               #刪除同層單身
               IF NOT amht204_delete_b('mhbb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amht204_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amht204_key_delete_b(gs_keys,'mhbb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amht204_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'mhbblent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'mhbbldocno'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.mhbbldocno
                  LET l_field_keys[03] = 'mhbbl001'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.mhbbl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mhbbl_t')
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE amht204_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mhbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mhbb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbbacti
            #add-point:BEFORE FIELD mhbbacti name="input.b.page1.mhbbacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbbacti
            
            #add-point:AFTER FIELD mhbbacti name="input.a.page1.mhbbacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbbacti
            #add-point:ON CHANGE mhbbacti name="input.g.page1.mhbbacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbbsite
            #add-point:BEFORE FIELD mhbbsite name="input.b.page1.mhbbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbbsite
            
            #add-point:AFTER FIELD mhbbsite name="input.a.page1.mhbbsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbbsite
            #add-point:ON CHANGE mhbbsite name="input.g.page1.mhbbsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb004
            #add-point:BEFORE FIELD mhbb004 name="input.b.page1.mhbb004"
            IF p_cmd = 'a' AND g_mhba_m.mhba000 = 'I' AND cl_null(g_mhbb_d[l_ac].mhbb004) THEN
               CALL s_aooi390_gen('10') RETURNING l_success,g_mhbb_d[l_ac].mhbb004,l_oofg_return
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb004
            
            #add-point:AFTER FIELD mhbb004 name="input.a.page1.mhbb004"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_mhba_m.mhbadocno IS NOT NULL AND g_mhbb_d[g_detail_idx].mhbb004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhba_m.mhbadocno != g_mhbadocno_t OR g_mhbb_d[g_detail_idx].mhbb004 != g_mhbb_d_t.mhbb004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhbb_t WHERE "||"mhbbent = '" ||g_enterprise|| "' AND "||"mhbbdocno = '"||g_mhba_m.mhbadocno ||"' AND "|| "mhbb004 = '"||g_mhbb_d[g_detail_idx].mhbb004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF g_mhba_m.mhba000 = 'I' THEN
                     IF NOT s_aooi390_chk('10',g_mhbb_d[l_ac].mhbb004) THEN
                        LET g_mhbb_d[l_ac].mhbb004 = g_mhbb_d_o.mhbb004
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_mhbb_d[l_ac].mhbb004) THEN
               IF g_mhbb_d[l_ac].mhbb004 != g_mhbb_d_o.mhbb004 OR cl_null(g_mhbb_d_o.mhbb004) THEN
                  IF NOT amht204_mhbb004_chk() THEN
                     LET g_mhbb_d[l_ac].mhbb004 = g_mhbb_d_o.mhbb004
                     CALL amht204_mhbb004_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL amht204_mhbb004_def()
               END IF
            END IF
            LET g_mhbb_d_o.* = g_mhbb_d[l_ac].*   #160824-00007#84 20161014 add by beckxie
            CALL amht204_mhbb004_ref()
            #add by geza 20160622 #160604-00009#27(S)
            CALL amht204_set_entry_b(l_cmd)
            CALL amht204_set_no_entry_b(l_cmd)
            #add by geza 20160622 #160604-00009#27(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbb004
            #add-point:ON CHANGE mhbb004 name="input.g.page1.mhbb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbbl003
            #add-point:BEFORE FIELD mhbbl003 name="input.b.page1.mhbbl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbbl003
            
            #add-point:AFTER FIELD mhbbl003 name="input.a.page1.mhbbl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbbl003
            #add-point:ON CHANGE mhbbl003 name="input.g.page1.mhbbl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbbl004
            #add-point:BEFORE FIELD mhbbl004 name="input.b.page1.mhbbl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbbl004
            
            #add-point:AFTER FIELD mhbbl004 name="input.a.page1.mhbbl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbbl004
            #add-point:ON CHANGE mhbbl004 name="input.g.page1.mhbbl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb009
            #add-point:BEFORE FIELD mhbb009 name="input.b.page1.mhbb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb009
            
            #add-point:AFTER FIELD mhbb009 name="input.a.page1.mhbb009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbb009
            #add-point:ON CHANGE mhbb009 name="input.g.page1.mhbb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb005
            #add-point:BEFORE FIELD mhbb005 name="input.b.page1.mhbb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb005
            
            #add-point:AFTER FIELD mhbb005 name="input.a.page1.mhbb005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbb005
            #add-point:ON CHANGE mhbb005 name="input.g.page1.mhbb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb006
            #add-point:BEFORE FIELD mhbb006 name="input.b.page1.mhbb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb006
            
            #add-point:AFTER FIELD mhbb006 name="input.a.page1.mhbb006"
            IF NOT cl_null(g_mhbb_d[l_ac].mhbb006) THEN
               IF g_mhbb_d[l_ac].mhbb006 ! = g_mhbb_d_o.mhbb006 OR cl_null(g_mhbb_d_o.mhbb006) THEN
                  IF cl_null(g_mhbb_d[l_ac].mhbb006) OR g_mhbb_d[l_ac].mhbb006 <= 0 THEN
                     #此場地編號%1的測量面積為空或<=0！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amh-00651'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = g_mhbb_d[l_ac].mhbb004
                     CALL cl_err()
                     LET g_mhbb_d[l_ac].mhbb005 = g_mhbb_d_o.mhbb005
                     LET g_mhbb_d[l_ac].mhbb006 = g_mhbb_d_o.mhbb006
                     LET g_mhbb_d[l_ac].mhbb007 = g_mhbb_d_o.mhbb007
                     NEXT FIELD CURRENT
                  END IF
                  CALL amht204_area_cal(1)
                  IF NOT amht204_area_chk() THEN
                     LET g_mhbb_d[l_ac].mhbb005 = g_mhbb_d_o.mhbb005
                     LET g_mhbb_d[l_ac].mhbb006 = g_mhbb_d_o.mhbb006
                     LET g_mhbb_d[l_ac].mhbb007 = g_mhbb_d_o.mhbb007
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mhbb_d_o.mhbb005 = g_mhbb_d[l_ac].mhbb005
            LET g_mhbb_d_o.mhbb006 = g_mhbb_d[l_ac].mhbb006
            LET g_mhbb_d_o.mhbb007 = g_mhbb_d[l_ac].mhbb007
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbb006
            #add-point:ON CHANGE mhbb006 name="input.g.page1.mhbb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb007
            #add-point:BEFORE FIELD mhbb007 name="input.b.page1.mhbb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb007
            
            #add-point:AFTER FIELD mhbb007 name="input.a.page1.mhbb007"
            IF NOT cl_null(g_mhbb_d[l_ac].mhbb007) THEN
               IF g_mhbb_d[l_ac].mhbb007 ! = g_mhbb_d_o.mhbb007 OR cl_null(g_mhbb_d_o.mhbb007) THEN
                  IF cl_null(g_mhbb_d[l_ac].mhbb007) OR g_mhbb_d[l_ac].mhbb007 <= 0 THEN
                     #此場地編號%1的經營面積為空或<=0！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amh-00652'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = g_mhbb_d[l_ac].mhbb004
                     CALL cl_err()
                     LET g_mhbb_d[l_ac].mhbb005 = g_mhbb_d_o.mhbb005
                     LET g_mhbb_d[l_ac].mhbb006 = g_mhbb_d_o.mhbb006
                     LET g_mhbb_d[l_ac].mhbb007 = g_mhbb_d_o.mhbb007
                     NEXT FIELD CURRENT
                  END IF
                  CALL amht204_area_cal(2)
                  IF NOT amht204_area_chk() THEN
                     LET g_mhbb_d[l_ac].mhbb005 = g_mhbb_d_o.mhbb005
                     LET g_mhbb_d[l_ac].mhbb006 = g_mhbb_d_o.mhbb006
                     LET g_mhbb_d[l_ac].mhbb007 = g_mhbb_d_o.mhbb007
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mhbb_d_o.mhbb005 = g_mhbb_d[l_ac].mhbb005
            LET g_mhbb_d_o.mhbb006 = g_mhbb_d[l_ac].mhbb006
            LET g_mhbb_d_o.mhbb007 = g_mhbb_d[l_ac].mhbb007
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbb007
            #add-point:ON CHANGE mhbb007 name="input.g.page1.mhbb007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb010
            
            #add-point:AFTER FIELD mhbb010 name="input.a.page1.mhbb010"
            IF NOT cl_null(g_mhbb_d[l_ac].mhbb010) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mhbb_d[l_ac].mhbb010 != g_mhbb_d_o.mhbb010 OR g_mhbb_d_O.mhbb010 IS NULL )) THEN
                  #應用 a17 樣板自動產生(Version:3)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  IF NOT s_azzi650_chk_exist('2145',g_mhbb_d[l_ac].mhbb010) THEN
                     LET g_mhbb_d_o.mhbb010 = g_mhbb_d[l_ac].mhbb010
                     CALL s_desc_get_acc_desc('2145',g_mhbb_d[l_ac].mhbb010)  RETURNING g_mhbb_d[l_ac].mhbb010_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF   
            END IF 
            CALL s_desc_get_acc_desc('2145',g_mhbb_d[l_ac].mhbb010)  RETURNING g_mhbb_d[l_ac].mhbb010_desc
            DISPLAY BY NAME g_mhbb_d[l_ac].mhbb010_desc
            LET g_mhbb_d_o.mhbb010 = g_mhbb_d[l_ac].mhbb010
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb010
            #add-point:BEFORE FIELD mhbb010 name="input.b.page1.mhbb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbb010
            #add-point:ON CHANGE mhbb010 name="input.g.page1.mhbb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb008
            #add-point:BEFORE FIELD mhbb008 name="input.b.page1.mhbb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb008
            
            #add-point:AFTER FIELD mhbb008 name="input.a.page1.mhbb008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbb008
            #add-point:ON CHANGE mhbb008 name="input.g.page1.mhbb008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb001
            
            #add-point:AFTER FIELD mhbb001 name="input.a.page1.mhbb001"
            LET g_mhbb_d[l_ac].mhbb001_desc = ''
            DISPLAY BY NAME g_mhbb_d[l_ac].mhbb001_desc
            IF cl_null(g_mhbb_d[l_ac].mhbb001) THEN
               LET g_mhbb_d[l_ac].mhbb002 = ''
               LET g_mhbb_d[l_ac].mhbb002_desc = ''
               LET g_mhbb_d[l_ac].mhbb003 = ''
               LET g_mhbb_d[l_ac].mhbb003_desc = ''
               DISPLAY BY NAME g_mhbb_d[l_ac].mhbb002,g_mhbb_d[l_ac].mhbb002_desc,
                               g_mhbb_d[l_ac].mhbb003,g_mhbb_d[l_ac].mhbb003_desc
            ELSE
               IF g_mhbb_d[l_ac].mhbb001 != g_mhbb_d_o.mhbb001 OR cl_null(g_mhbb_d_o.mhbb001) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhbb_d[l_ac].mhbb001
                  LET g_chkparam.arg2 = g_mhba_m.mhbasite
                  IF NOT cl_chk_exist("v_mhaa001") THEN
                     LET g_mhbb_d[l_ac].mhbb001 = g_mhbb_d_o.mhbb001
                     CALL amht204_mhaal003(g_mhbb_d[l_ac].mhbb001) RETURNING g_mhbb_d[l_ac].mhbb001_desc
                     DISPLAY BY NAME g_mhbb_d[l_ac].mhbb001_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #場地
                  IF NOT cl_null(g_mhbb_d[l_ac].mhbb004) THEN
                     IF NOT amht204_mhbb004_chk() THEN
                        LET g_mhbb_d[l_ac].mhbb001 = g_mhbb_d_o.mhbb001
                        CALL amht204_mhaal003(g_mhbb_d[l_ac].mhbb001) RETURNING g_mhbb_d[l_ac].mhbb001_desc
                        DISPLAY BY NAME g_mhbb_d[l_ac].mhbb001_desc
                        NEXT FIELD CURRENT
                     END IF
                     #CALL amht204_mhbb004_def()  #160606-00034#1 20160613 mark by beckxie
                  END IF
                  
                  LET g_mhbb_d[l_ac].mhbb002 = ''
                  LET g_mhbb_d[l_ac].mhbb002_desc = ''
                  LET g_mhbb_d[l_ac].mhbb003 = ''
                  LET g_mhbb_d[l_ac].mhbb003_desc = ''
                  DISPLAY BY NAME g_mhbb_d[l_ac].mhbb002,g_mhbb_d[l_ac].mhbb002_desc,
                                  g_mhbb_d[l_ac].mhbb003,g_mhbb_d[l_ac].mhbb003_desc
               END IF
            END IF
            #160706-00011#1 20160706 add by beckxie---S
            CALL amht204_area_cal(1)
            IF NOT amht204_area_chk() THEN
               LET g_mhbb_d[l_ac].mhbb005 = g_mhbb_d_o.mhbb005
               LET g_mhbb_d[l_ac].mhbb006 = g_mhbb_d_o.mhbb006
               LET g_mhbb_d[l_ac].mhbb007 = g_mhbb_d_o.mhbb007
               NEXT FIELD CURRENT
            END IF
            #160706-00011#1 20160706 add by beckxie---E
            
            CALL amht204_mhaal003(g_mhbb_d[l_ac].mhbb001) RETURNING g_mhbb_d[l_ac].mhbb001_desc
            DISPLAY BY NAME g_mhbb_d[l_ac].mhbb001_desc
            LET g_mhbb_d_o.mhbb001 = g_mhbb_d[l_ac].mhbb001
            LET g_mhbb_d_o.mhbb002 = g_mhbb_d[l_ac].mhbb002
            LET g_mhbb_d_o.mhbb003 = g_mhbb_d[l_ac].mhbb003
            LET g_mhbb_d_o.mhbb005 = g_mhbb_d[l_ac].mhbb005
            LET g_mhbb_d_o.mhbb006 = g_mhbb_d[l_ac].mhbb006
            LET g_mhbb_d_o.mhbb007 = g_mhbb_d[l_ac].mhbb007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb001
            #add-point:BEFORE FIELD mhbb001 name="input.b.page1.mhbb001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbb001
            #add-point:ON CHANGE mhbb001 name="input.g.page1.mhbb001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb002
            
            #add-point:AFTER FIELD mhbb002 name="input.a.page1.mhbb002"
            LET g_mhbb_d[l_ac].mhbb002_desc = ''
            DISPLAY BY NAME g_mhbb_d[l_ac].mhbb002_desc
            IF cl_null(g_mhbb_d[l_ac].mhbb002) THEN
               LET g_mhbb_d[l_ac].mhbb003 = ''
               LET g_mhbb_d[l_ac].mhbb003_desc = ''
               DISPLAY BY NAME g_mhbb_d[l_ac].mhbb003,g_mhbb_d[l_ac].mhbb003_desc
            ELSE
               IF g_mhbb_d[l_ac].mhbb002 != g_mhbb_d_o.mhbb002 OR cl_null(g_mhbb_d_o.mhbb002) THEN
                  IF cl_null(g_mhbb_d[l_ac].mhbb001) THEN
                     LET g_mhbb_d[l_ac].mhbb002 = ''
                     LET g_mhbb_d_o.mhbb002  = g_mhbb_d[l_ac].mhbb002
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amh-00645'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD mhbb001
                  END IF
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhbb_d[l_ac].mhbb002
                  LET g_chkparam.arg2 = g_mhbb_d[l_ac].mhbb001
                  IF NOT cl_chk_exist("v_mhab002") THEN
                     LET g_mhbb_d[l_ac].mhbb002 = g_mhbb_d_o.mhbb002
                     CALL amht204_mhabl004(g_mhbb_d[l_ac].mhbb001,g_mhbb_d[l_ac].mhbb002) RETURNING g_mhbb_d[l_ac].mhbb002_desc
                     DISPLAY BY NAME g_mhbb_d[l_ac].mhbb002_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #場地
                  IF NOT cl_null(g_mhbb_d[l_ac].mhbb004) THEN
                     IF NOT amht204_mhbb004_chk() THEN
                        LET g_mhbb_d[l_ac].mhbb002 = g_mhbb_d_o.mhbb002
                        CALL amht204_mhabl004(g_mhbb_d[l_ac].mhbb001,g_mhbb_d[l_ac].mhbb002) RETURNING g_mhbb_d[l_ac].mhbb002_desc
                        DISPLAY BY NAME g_mhbb_d[l_ac].mhbb002_desc
                        NEXT FIELD CURRENT
                     END IF
                     #CALL amht204_mhbb004_def()  #160606-00034#1 20160613 mark by beckxie
                  END IF
                  
                  LET g_mhbb_d[l_ac].mhbb003 = ''
                  LET g_mhbb_d[l_ac].mhbb003_desc = ''
                  DISPLAY BY NAME g_mhbb_d[l_ac].mhbb003,g_mhbb_d[l_ac].mhbb003_desc
               END IF
            END IF
            #160706-00011#1 20160706 add by beckxie---S
            CALL amht204_area_cal(1)
            IF NOT amht204_area_chk() THEN
               LET g_mhbb_d[l_ac].mhbb005 = g_mhbb_d_o.mhbb005
               LET g_mhbb_d[l_ac].mhbb006 = g_mhbb_d_o.mhbb006
               LET g_mhbb_d[l_ac].mhbb007 = g_mhbb_d_o.mhbb007
               NEXT FIELD CURRENT
            END IF
            #160706-00011#1 20160706 add by beckxie---E
            CALL amht204_mhabl004(g_mhbb_d[l_ac].mhbb001,g_mhbb_d[l_ac].mhbb002) RETURNING g_mhbb_d[l_ac].mhbb002_desc
            DISPLAY BY NAME g_mhbb_d[l_ac].mhbb002_desc
            LET g_mhbb_d_o.mhbb002 = g_mhbb_d[l_ac].mhbb002
            LET g_mhbb_d_o.mhbb003 = g_mhbb_d[l_ac].mhbb003
            LET g_mhbb_d_o.mhbb005 = g_mhbb_d[l_ac].mhbb005
            LET g_mhbb_d_o.mhbb006 = g_mhbb_d[l_ac].mhbb006
            LET g_mhbb_d_o.mhbb007 = g_mhbb_d[l_ac].mhbb007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb002
            #add-point:BEFORE FIELD mhbb002 name="input.b.page1.mhbb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbb002
            #add-point:ON CHANGE mhbb002 name="input.g.page1.mhbb002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbb003
            
            #add-point:AFTER FIELD mhbb003 name="input.a.page1.mhbb003"
            LET g_mhbb_d[l_ac].mhbb003_desc = ''
            DISPLAY BY NAME g_mhbb_d[l_ac].mhbb003_desc
            IF cl_null(g_mhbb_d[l_ac].mhbb003) THEN
#               LET g_mhbb_d[l_ac].mhbb003 = ' '     #160604-00009#163  by 08172
               LET g_mhbb_d[l_ac].mhbb003 = ''       #160604-00009#163  by 08172
            ELSE
               IF g_mhbb_d[l_ac].mhbb003 != g_mhbb_d_o.mhbb003 OR cl_null(g_mhbb_d_o.mhbb003) THEN
                  IF cl_null(g_mhbb_d[l_ac].mhbb001) THEN
                     LET g_mhbb_d[l_ac].mhbb002 = ''
                     LET g_mhbb_d_o.mhbb002  = g_mhbb_d[l_ac].mhbb002
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amh-00645'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD mhbb001
                  END IF
                  IF cl_null(g_mhbb_d[l_ac].mhbb002) THEN
                     LET g_mhbb_d[l_ac].mhbb002 = ''
                     LET g_mhbb_d_o.mhbb002  = g_mhbb_d[l_ac].mhbb002
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amh-00646'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD mhbb002
                  END IF
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhbb_d[l_ac].mhbb003
                  LET g_chkparam.arg2 = g_mhbb_d[l_ac].mhbb001
                  LET g_chkparam.arg3 = g_mhbb_d[l_ac].mhbb002
                  
                  IF NOT cl_chk_exist("v_mhac003") THEN
                     LET g_mhbb_d[l_ac].mhbb003 = g_mhbb_d_o.mhbb003
                     CALL amht204_mhacl005(g_mhbb_d[l_ac].mhbb001,g_mhbb_d[l_ac].mhbb002,g_mhbb_d[l_ac].mhbb003)
                        RETURNING g_mhbb_d[l_ac].mhbb003_desc
                     DISPLAY BY NAME g_mhbb_d[l_ac].mhbb003_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #場地
                  IF NOT cl_null(g_mhbb_d[l_ac].mhbb004) THEN
                     IF NOT amht204_mhbb004_chk() THEN
                        LET g_mhbb_d[l_ac].mhbb003 = g_mhbb_d_o.mhbb003
                        CALL amht204_mhacl005(g_mhbb_d[l_ac].mhbb001,g_mhbb_d[l_ac].mhbb002,g_mhbb_d[l_ac].mhbb003)
                           RETURNING g_mhbb_d[l_ac].mhbb003_desc
                        DISPLAY BY NAME g_mhbb_d[l_ac].mhbb003_desc
                        NEXT FIELD CURRENT
                     END IF
                     #CALL amht204_mhbb004_def()  #160606-00034#1 20160613 mark by beckxie
                  END IF
               END IF
            END IF
            CALL amht204_mhacl005(g_mhbb_d[l_ac].mhbb001,g_mhbb_d[l_ac].mhbb002,g_mhbb_d[l_ac].mhbb003)
               RETURNING g_mhbb_d[l_ac].mhbb003_desc
            DISPLAY BY NAME g_mhbb_d[l_ac].mhbb003_desc
            LET g_mhbb_d_o.mhbb003 = g_mhbb_d[l_ac].mhbb003
            LET g_mhbb_d_o.mhbb005 = g_mhbb_d[l_ac].mhbb005
            LET g_mhbb_d_o.mhbb006 = g_mhbb_d[l_ac].mhbb006
            LET g_mhbb_d_o.mhbb007 = g_mhbb_d[l_ac].mhbb007
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbb003
            #add-point:BEFORE FIELD mhbb003 name="input.b.page1.mhbb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbb003
            #add-point:ON CHANGE mhbb003 name="input.g.page1.mhbb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbbunit
            #add-point:BEFORE FIELD mhbbunit name="input.b.page1.mhbbunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbbunit
            
            #add-point:AFTER FIELD mhbbunit name="input.a.page1.mhbbunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbbunit
            #add-point:ON CHANGE mhbbunit name="input.g.page1.mhbbunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mhbbacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbbacti
            #add-point:ON ACTION controlp INFIELD mhbbacti name="input.c.page1.mhbbacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbbsite
            #add-point:ON ACTION controlp INFIELD mhbbsite name="input.c.page1.mhbbsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb004
            #add-point:ON ACTION controlp INFIELD mhbb004 name="input.c.page1.mhbb004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            IF g_mhba_m.mhba000 = 'U' THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_mhbb_d[l_ac].mhbb004
               
               LET l_where = " mhadsite = '",g_mhba_m.mhbasite,"'"
               #樓棟
               IF NOT cl_null(g_mhba_m.mhba001) THEN
                  LET l_where = l_where," AND mhad001 = '",g_mhba_m.mhba001,"'"
               END IF
               #樓層
               IF NOT cl_null(g_mhba_m.mhba002) THEN
                  LET l_where = l_where," AND mhad002 = '",g_mhba_m.mhba002,"'"
               END IF
               #區域
               IF NOT cl_null(g_mhba_m.mhba003) THEN
                  LET l_where = l_where," AND mhad003 = '",g_mhba_m.mhba003,"'"
               END IF
               LET g_qryparam.where = l_where
               CALL q_mhad001()
               LET g_mhbb_d[l_ac].mhbb004 = g_qryparam.return1
               DISPLAY g_mhbb_d[l_ac].mhbb004 TO mhbb004
               CALL amht204_mhbb004_ref()
            END IF
            NEXT FIELD mhbb004
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbbl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbbl003
            #add-point:ON ACTION controlp INFIELD mhbbl003 name="input.c.page1.mhbbl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbbl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbbl004
            #add-point:ON ACTION controlp INFIELD mhbbl004 name="input.c.page1.mhbbl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb009
            #add-point:ON ACTION controlp INFIELD mhbb009 name="input.c.page1.mhbb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb005
            #add-point:ON ACTION controlp INFIELD mhbb005 name="input.c.page1.mhbb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb006
            #add-point:ON ACTION controlp INFIELD mhbb006 name="input.c.page1.mhbb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb007
            #add-point:ON ACTION controlp INFIELD mhbb007 name="input.c.page1.mhbb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb010
            #add-point:ON ACTION controlp INFIELD mhbb010 name="input.c.page1.mhbb010"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbb_d[l_ac].mhbb010             #給予default值
            LET g_qryparam.default2 = "" #g_mhbb_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2145" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mhbb_d[l_ac].mhbb010 = g_qryparam.return1              
            #LET g_mhbb_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_mhbb_d[l_ac].mhbb010 TO mhbb010              #
            CALL s_desc_get_acc_desc('2145',g_mhbb_d[l_ac].mhbb010)  RETURNING g_mhbb_d[l_ac].mhbb010_desc
            #DISPLAY g_mhbb_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mhbb010                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb008
            #add-point:ON ACTION controlp INFIELD mhbb008 name="input.c.page1.mhbb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb001
            #add-point:ON ACTION controlp INFIELD mhbb001 name="input.c.page1.mhbb001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhbb_d[l_ac].mhbb001
            
            LET l_where = " mhaasite='",g_mhba_m.mhbasite,"'"
            IF g_mhba_m.mhba000 = 'U' AND NOT cl_null(g_mhbb_d[l_ac].mhbb004) THEN
               LET l_where = l_where, "AND EXISTS(SELECT 1",
                                      "             FROM mhad_t",
                                      "            WHERE mhadent = mhaaent",
                                      "              AND mhadsite = mhaasite",
                                      "              AND mhad004 = '",g_mhbb_d[l_ac].mhbb004,"')"
            END IF
            LET g_qryparam.where = l_where
            CALL q_mhaa001()
            LET g_mhbb_d[l_ac].mhbb001 = g_qryparam.return1
            DISPLAY g_mhbb_d[l_ac].mhbb001 TO mhbb001
            CALL amht204_mhaal003(g_mhbb_d[l_ac].mhbb001) RETURNING g_mhbb_d[l_ac].mhbb001_desc
            DISPLAY BY NAME g_mhbb_d[l_ac].mhbb001_desc
            NEXT FIELD mhbb001
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb002
            #add-point:ON ACTION controlp INFIELD mhbb002 name="input.c.page1.mhbb002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            IF cl_null(g_mhbb_d[l_ac].mhbb001) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amh-00645'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD mhbb001
            END IF
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhbb_d[l_ac].mhbb002 
            
            LET g_qryparam.where = "mhab001='",g_mhbb_d[l_ac].mhbb001,"'"
            CALL q_mhab002()
            LET g_mhbb_d[l_ac].mhbb002 = g_qryparam.return1
            DISPLAY g_mhbb_d[l_ac].mhbb002 TO mhbb002
            CALL amht204_mhabl004(g_mhbb_d[l_ac].mhbb001,g_mhbb_d[l_ac].mhbb002) RETURNING g_mhbb_d[l_ac].mhbb002_desc
            DISPLAY BY NAME g_mhbb_d[l_ac].mhbb002_desc
            NEXT FIELD mhbb002
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbb003
            #add-point:ON ACTION controlp INFIELD mhbb003 name="input.c.page1.mhbb003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            IF cl_null(g_mhbb_d[l_ac].mhbb001) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amh-00645'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD mhba001
            END IF
            IF cl_null(g_mhbb_d[l_ac].mhbb002) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amh-00646'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD mhba002
            END IF
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhbb_d[l_ac].mhbb003
            
            LET g_qryparam.where = "     mhac001 = '",g_mhbb_d[l_ac].mhbb001,"'",
                                   " AND mhac002 = '",g_mhbb_d[l_ac].mhbb002,"'"
            CALL q_mhac003()
            LET g_mhbb_d[l_ac].mhbb003 = g_qryparam.return1
            DISPLAY g_mhbb_d[l_ac].mhbb003 TO mhbb003
            CALL amht204_mhacl005(g_mhbb_d[l_ac].mhbb001,g_mhbb_d[l_ac].mhbb002,g_mhbb_d[l_ac].mhbb003)
               RETURNING g_mhbb_d[l_ac].mhbb003_desc
            DISPLAY BY NAME g_mhbb_d[l_ac].mhbb003_desc
            NEXT FIELD mhbb003
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbbunit
            #add-point:ON ACTION controlp INFIELD mhbbunit name="input.c.page1.mhbbunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mhbb_d[l_ac].* = g_mhbb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amht204_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mhbb_d[l_ac].mhbb004 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mhbb_d[l_ac].* = g_mhbb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL amht204_mhbb_t_mask_restore('restore_mask_o')
      
               UPDATE mhbb_t SET (mhbbdocno,mhbbacti,mhbbsite,mhbb004,mhbb009,mhbb005,mhbb006,mhbb007, 
                   mhbb010,mhbb008,mhbb001,mhbb002,mhbb003,mhbbunit) = (g_mhba_m.mhbadocno,g_mhbb_d[l_ac].mhbbacti, 
                   g_mhbb_d[l_ac].mhbbsite,g_mhbb_d[l_ac].mhbb004,g_mhbb_d[l_ac].mhbb009,g_mhbb_d[l_ac].mhbb005, 
                   g_mhbb_d[l_ac].mhbb006,g_mhbb_d[l_ac].mhbb007,g_mhbb_d[l_ac].mhbb010,g_mhbb_d[l_ac].mhbb008, 
                   g_mhbb_d[l_ac].mhbb001,g_mhbb_d[l_ac].mhbb002,g_mhbb_d[l_ac].mhbb003,g_mhbb_d[l_ac].mhbbunit) 
 
                WHERE mhbbent = g_enterprise AND mhbbdocno = g_mhba_m.mhbadocno 
 
                  AND mhbb004 = g_mhbb_d_t.mhbb004 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mhbb_d[l_ac].* = g_mhbb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhbb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mhbb_d[l_ac].* = g_mhbb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhbb_t:",SQLERRMESSAGE 
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
         IF g_mhba_m.mhbadocno = g_detail_multi_table_t.mhbbldocno AND
         g_mhbb_d[l_ac].mhbb004 = g_detail_multi_table_t.mhbbl001 AND
         g_mhbb_d[l_ac].mhbbl003 = g_detail_multi_table_t.mhbbl003 AND
         g_mhbb_d[l_ac].mhbbl004 = g_detail_multi_table_t.mhbbl004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhbblent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhba_m.mhbadocno
            LET l_field_keys[02] = 'mhbbldocno'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhbbldocno
            LET l_var_keys[03] = g_mhbb_d[l_ac].mhbb004
            LET l_field_keys[03] = 'mhbbl001'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhbbl001
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'mhbbl002'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhbbl002
            LET l_vars[01] = g_mhbb_d[l_ac].mhbbl003
            LET l_fields[01] = 'mhbbl003'
            LET l_vars[02] = g_mhbb_d[l_ac].mhbbl004
            LET l_fields[02] = 'mhbbl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhbbl_t')
         END IF 
 
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhba_m.mhbadocno
               LET gs_keys_bak[1] = g_mhbadocno_t
               LET gs_keys[2] = g_mhbb_d[g_detail_idx].mhbb004
               LET gs_keys_bak[2] = g_mhbb_d_t.mhbb004
               CALL amht204_update_b('mhbb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL amht204_mhbb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mhbb_d[g_detail_idx].mhbb004 = g_mhbb_d_t.mhbb004 
 
                  ) THEN
                  LET gs_keys[01] = g_mhba_m.mhbadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mhbb_d_t.mhbb004
 
                  CALL amht204_key_update_b(gs_keys,'mhbb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mhba_m),util.JSON.stringify(g_mhbb_d_t)
               LET g_log2 = util.JSON.stringify(g_mhba_m),util.JSON.stringify(g_mhbb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL amht204_unlock_b("mhbb_t","'1'")
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
               LET g_mhbb_d[li_reproduce_target].* = g_mhbb_d[li_reproduce].*
 
               LET g_mhbb_d[li_reproduce_target].mhbb004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mhbb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mhbb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="amht204.input.other" >}
      
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
            NEXT FIELD mhbasite
            #end add-point  
            NEXT FIELD mhbadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mhbbacti
 
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
 
{<section id="amht204.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION amht204_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_sql     STRING
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL amht204_b_fill() #單身填充
      CALL amht204_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL amht204_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   LET l_sql = "SELECT mhbbl003,mhbbl004",
               "  FROM mhbbl_t",
               " WHERE mhbblent = ",g_enterprise,
               "   AND mhbbldocno = ?",
               "   AND mhbbl001 = ?",
               "   AND mhbbl002 = '",g_dlang,"'"
   PREPARE amht204_sel_mhbbl FROM l_sql
   #end add-point
   
   #遮罩相關處理
   LET g_mhba_m_mask_o.* =  g_mhba_m.*
   CALL amht204_mhba_t_mask()
   LET g_mhba_m_mask_n.* =  g_mhba_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mhba_m.mhbasite,g_mhba_m.mhbasite_desc,g_mhba_m.mhbadocdt,g_mhba_m.mhbadocno,g_mhba_m.mhba000, 
       g_mhba_m.mhba006,g_mhba_m.mhba004,g_mhba_m.mhba004_desc,g_mhba_m.mhba005,g_mhba_m.mhba005_desc, 
       g_mhba_m.mhba001,g_mhba_m.mhba001_desc,g_mhba_m.mhba002,g_mhba_m.mhba002_desc,g_mhba_m.mhba003, 
       g_mhba_m.mhba003_desc,g_mhba_m.mhbaunit,g_mhba_m.mhbastus,g_mhba_m.mhbaownid,g_mhba_m.mhbaownid_desc, 
       g_mhba_m.mhbaowndp,g_mhba_m.mhbaowndp_desc,g_mhba_m.mhbacrtid,g_mhba_m.mhbacrtid_desc,g_mhba_m.mhbacrtdp, 
       g_mhba_m.mhbacrtdp_desc,g_mhba_m.mhbacrtdt,g_mhba_m.mhbamodid,g_mhba_m.mhbamodid_desc,g_mhba_m.mhbamoddt, 
       g_mhba_m.mhbacnfid,g_mhba_m.mhbacnfid_desc,g_mhba_m.mhbacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mhba_m.mhbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mhbb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      EXECUTE amht204_sel_mhbbl USING g_mhba_m.mhbadocno,g_mhbb_d[l_ac].mhbb004
         INTO g_mhbb_d[l_ac].mhbbl003,g_mhbb_d[l_ac].mhbbl004
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL amht204_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="amht204.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION amht204_detail_show()
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
 
{<section id="amht204.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION amht204_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mhba_t.mhbadocno 
   DEFINE l_oldno     LIKE mhba_t.mhbadocno 
 
   DEFINE l_master    RECORD LIKE mhba_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mhbb_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_mhba_m.mhbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mhbadocno_t = g_mhba_m.mhbadocno
 
    
   LET g_mhba_m.mhbadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mhba_m.mhbaownid = g_user
      LET g_mhba_m.mhbaowndp = g_dept
      LET g_mhba_m.mhbacrtid = g_user
      LET g_mhba_m.mhbacrtdp = g_dept 
      LET g_mhba_m.mhbacrtdt = cl_get_current()
      LET g_mhba_m.mhbamodid = g_user
      LET g_mhba_m.mhbamoddt = cl_get_current()
      LET g_mhba_m.mhbastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
 
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mhba_m.mhbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL amht204_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mhba_m.* TO NULL
      INITIALIZE g_mhbb_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL amht204_show()
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
   CALL amht204_set_act_visible()   
   CALL amht204_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mhbadocno_t = g_mhba_m.mhbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mhbaent = " ||g_enterprise|| " AND",
                      " mhbadocno = '", g_mhba_m.mhbadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amht204_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL amht204_idx_chk()
   
   LET g_data_owner = g_mhba_m.mhbaownid      
   LET g_data_dept  = g_mhba_m.mhbaowndp
   
   #功能已完成,通報訊息中心
   CALL amht204_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="amht204.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION amht204_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mhbb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE amht204_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mhbb_t
    WHERE mhbbent = g_enterprise AND mhbbdocno = g_mhbadocno_t
 
    INTO TEMP amht204_detail
 
   #將key修正為調整後   
   UPDATE amht204_detail 
      #更新key欄位
      SET mhbbdocno = g_mhba_m.mhbadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mhbb_t SELECT * FROM amht204_detail
   
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
   DROP TABLE amht204_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
      #應用 a38 樣板自動產生(Version:6)
   #單身多語言複製
   DROP TABLE amht204_detail_lang
   
   #add-point:單身複製前1 name="detail_reproduce.body.lang0.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE & INSERT 
   SELECT * FROM mhbbl_t 
    WHERE mhbblent = g_enterprise AND mhbbldocno = g_mhbadocno_t
 
     INTO TEMP amht204_detail_lang
 
   #將key修正為調整後   
   UPDATE amht204_detail_lang 
      #更新key欄位
      SET mhbbldocno = g_mhba_m.mhbadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.lang0.b_update"
   
   #end add-point   
  
   #將資料塞回原table   
   INSERT INTO mhbbl_t SELECT * FROM amht204_detail_lang
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.lang0.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE amht204_detail_lang
   
   #add-point:單身複製後1 name="detail_reproduce.lang0.table1.a_insert"
   
   #end add-point
 
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mhbadocno_t = g_mhba_m.mhbadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="amht204.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amht204_delete()
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
   
   IF g_mhba_m.mhbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN amht204_cl USING g_enterprise,g_mhba_m.mhbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amht204_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amht204_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amht204_master_referesh USING g_mhba_m.mhbadocno INTO g_mhba_m.mhbasite,g_mhba_m.mhbadocdt, 
       g_mhba_m.mhbadocno,g_mhba_m.mhba000,g_mhba_m.mhba006,g_mhba_m.mhba004,g_mhba_m.mhba005,g_mhba_m.mhba001, 
       g_mhba_m.mhba002,g_mhba_m.mhba003,g_mhba_m.mhbaunit,g_mhba_m.mhbastus,g_mhba_m.mhbaownid,g_mhba_m.mhbaowndp, 
       g_mhba_m.mhbacrtid,g_mhba_m.mhbacrtdp,g_mhba_m.mhbacrtdt,g_mhba_m.mhbamodid,g_mhba_m.mhbamoddt, 
       g_mhba_m.mhbacnfid,g_mhba_m.mhbacnfdt,g_mhba_m.mhbasite_desc,g_mhba_m.mhba004_desc,g_mhba_m.mhba005_desc, 
       g_mhba_m.mhba001_desc,g_mhba_m.mhba002_desc,g_mhba_m.mhbaownid_desc,g_mhba_m.mhbaowndp_desc,g_mhba_m.mhbacrtid_desc, 
       g_mhba_m.mhbacrtdp_desc,g_mhba_m.mhbamodid_desc,g_mhba_m.mhbacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT amht204_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mhba_m_mask_o.* =  g_mhba_m.*
   CALL amht204_mhba_t_mask()
   LET g_mhba_m_mask_n.* =  g_mhba_m.*
   
   CALL amht204_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amht204_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mhbadocno_t = g_mhba_m.mhbadocno
 
 
      DELETE FROM mhba_t
       WHERE mhbaent = g_enterprise AND mhbadocno = g_mhba_m.mhbadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mhba_m.mhbadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_mhba_m.mhbadocno,g_mhba_m.mhbadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM mhbb_t
       WHERE mhbbent = g_enterprise AND mhbbdocno = g_mhba_m.mhbadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mhbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mhba_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE amht204_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mhbb_d.clear() 
 
     
      CALL amht204_ui_browser_refresh()  
      #CALL amht204_ui_headershow()  
      #CALL amht204_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
         INITIALIZE l_field_keys TO NULL 
         LET l_field_keys[01] = 'mhbblent'
         LET l_var_keys_bak[01] = g_enterprise
         LET l_field_keys[02] = 'mhbbldocno'
         LET l_var_keys_bak[02] = g_mhba_m.mhbadocno
         CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mhbbl_t')
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL amht204_browser_fill("")
         CALL amht204_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE amht204_cl
 
   #功能已完成,通報訊息中心
   CALL amht204_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="amht204.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amht204_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mhbb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF amht204_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mhbbacti,mhbbsite,mhbb004,mhbb009,mhbb005,mhbb006,mhbb007,mhbb010, 
             mhbb008,mhbb001,mhbb002,mhbb003,mhbbunit ,t1.oocql004 ,t2.mhaal003 ,t3.mhabl004 ,t4.mhacl005 FROM mhbb_t", 
                
                     " INNER JOIN mhba_t ON mhbaent = " ||g_enterprise|| " AND mhbadocno = mhbbdocno ",
 
                     #" LEFT JOIN mhbbl_t ON mhbblent = "||g_enterprise||" AND mhbadocno = mhbbldocno AND mhbb004 = mhbbl001 AND mhbbl002 = '",g_dlang,"'",
                     
                     " LEFT JOIN mhbbl_t ON mhbblent = "||g_enterprise||" AND mhbadocno = mhbbldocno AND mhbb004 = mhbbl001 AND mhbbl002 = '",g_dlang,"'",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='2145' AND t1.oocql002=mhbb010 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN mhaal_t t2 ON t2.mhaalent="||g_enterprise||" AND t2.mhaal001=mhbb001 AND t2.mhaal002='"||g_dlang||"' ",
               " LEFT JOIN mhabl_t t3 ON t3.mhablent="||g_enterprise||" AND t3.mhabl001=mhbb001 AND t3.mhabl002=mhbb002 AND t3.mhabl003='"||g_dlang||"' ",
               " LEFT JOIN mhacl_t t4 ON t4.mhaclent="||g_enterprise||" AND t4.mhacl001=mhbb001 AND t4.mhacl002=mhbb002 AND t4.mhacl003=mhbb003 AND t4.mhacl004='"||g_dlang||"' ",
 
                     " WHERE mhbbent=? AND mhbbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mhbb_t.mhbb004"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amht204_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR amht204_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mhba_m.mhbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mhba_m.mhbadocno INTO g_mhbb_d[l_ac].mhbbacti,g_mhbb_d[l_ac].mhbbsite, 
          g_mhbb_d[l_ac].mhbb004,g_mhbb_d[l_ac].mhbb009,g_mhbb_d[l_ac].mhbb005,g_mhbb_d[l_ac].mhbb006, 
          g_mhbb_d[l_ac].mhbb007,g_mhbb_d[l_ac].mhbb010,g_mhbb_d[l_ac].mhbb008,g_mhbb_d[l_ac].mhbb001, 
          g_mhbb_d[l_ac].mhbb002,g_mhbb_d[l_ac].mhbb003,g_mhbb_d[l_ac].mhbbunit,g_mhbb_d[l_ac].mhbb010_desc, 
          g_mhbb_d[l_ac].mhbb001_desc,g_mhbb_d[l_ac].mhbb002_desc,g_mhbb_d[l_ac].mhbb003_desc   #(ver:78) 
 
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
   
   CALL g_mhbb_d.deleteElement(g_mhbb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE amht204_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mhbb_d.getLength()
      LET g_mhbb_d_mask_o[l_ac].* =  g_mhbb_d[l_ac].*
      CALL amht204_mhbb_t_mask()
      LET g_mhbb_d_mask_n[l_ac].* =  g_mhbb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="amht204.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amht204_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM mhbb_t
       WHERE mhbbent = g_enterprise AND
         mhbbdocno = ps_keys_bak[1] AND mhbb004 = ps_keys_bak[2]
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
         CALL g_mhbb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amht204.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amht204_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mhbb_t
                  (mhbbent,
                   mhbbdocno,
                   mhbb004
                   ,mhbbacti,mhbbsite,mhbb009,mhbb005,mhbb006,mhbb007,mhbb010,mhbb008,mhbb001,mhbb002,mhbb003,mhbbunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mhbb_d[g_detail_idx].mhbbacti,g_mhbb_d[g_detail_idx].mhbbsite,g_mhbb_d[g_detail_idx].mhbb009, 
                       g_mhbb_d[g_detail_idx].mhbb005,g_mhbb_d[g_detail_idx].mhbb006,g_mhbb_d[g_detail_idx].mhbb007, 
                       g_mhbb_d[g_detail_idx].mhbb010,g_mhbb_d[g_detail_idx].mhbb008,g_mhbb_d[g_detail_idx].mhbb001, 
                       g_mhbb_d[g_detail_idx].mhbb002,g_mhbb_d[g_detail_idx].mhbb003,g_mhbb_d[g_detail_idx].mhbbunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mhbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mhbb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="amht204.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amht204_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mhbb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL amht204_mhbb_t_mask_restore('restore_mask_o')
               
      UPDATE mhbb_t 
         SET (mhbbdocno,
              mhbb004
              ,mhbbacti,mhbbsite,mhbb009,mhbb005,mhbb006,mhbb007,mhbb010,mhbb008,mhbb001,mhbb002,mhbb003,mhbbunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mhbb_d[g_detail_idx].mhbbacti,g_mhbb_d[g_detail_idx].mhbbsite,g_mhbb_d[g_detail_idx].mhbb009, 
                  g_mhbb_d[g_detail_idx].mhbb005,g_mhbb_d[g_detail_idx].mhbb006,g_mhbb_d[g_detail_idx].mhbb007, 
                  g_mhbb_d[g_detail_idx].mhbb010,g_mhbb_d[g_detail_idx].mhbb008,g_mhbb_d[g_detail_idx].mhbb001, 
                  g_mhbb_d[g_detail_idx].mhbb002,g_mhbb_d[g_detail_idx].mhbb003,g_mhbb_d[g_detail_idx].mhbbunit)  
 
         WHERE mhbbent = g_enterprise AND mhbbdocno = ps_keys_bak[1] AND mhbb004 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhbb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhbb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amht204_mhbb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'mhbblent'
LET l_new_key[02] = ps_keys[1] 
LET l_old_key[02] = ps_keys_bak[1] 
LET l_field_key[02] = 'mhbbldocno'
LET l_new_key[03] = ps_keys[2] 
LET l_old_key[03] = ps_keys_bak[2] 
LET l_field_key[03] = 'mhbbl001'
LET l_new_key[04] = g_dlang 
LET l_old_key[04] = g_dlang 
LET l_field_key[04] = 'mhbbl002'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'mhbbl_t')
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amht204.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION amht204_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="amht204.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION amht204_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="amht204.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amht204_lock_b(ps_table,ps_page)
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
   #CALL amht204_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mhbb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN amht204_bcl USING g_enterprise,
                                       g_mhba_m.mhbadocno,g_mhbb_d[g_detail_idx].mhbb004     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amht204_bcl:",SQLERRMESSAGE 
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
 
{<section id="amht204.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amht204_unlock_b(ps_table,ps_page)
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
      CLOSE amht204_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="amht204.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION amht204_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mhbadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mhbadocno",TRUE)
      CALL cl_set_comp_entry("mhbadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("mhbasite",TRUE)
      CALL cl_set_comp_entry("mhbadocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("mhba000",TRUE)
   CALL cl_set_comp_entry("mhba001",TRUE)
   CALL cl_set_comp_entry("mhba002",TRUE)
   CALL cl_set_comp_entry("mhba003",TRUE)
   CALL cl_set_comp_entry("mhba006",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amht204.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION amht204_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt   LIKE type_t.num10
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mhbadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("mhbasite",FALSE)
      CALL cl_set_comp_entry("mhbadocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mhbadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mhbadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #營運組織
   IF NOT s_aooi500_comp_entry(g_prog,'mhbasite') OR g_site_flag THEN
      CALL cl_set_comp_entry("mhbasite",FALSE)
   END IF
   
   IF g_mhba_m.mhba000 = 'I' THEN
      CALL cl_set_comp_entry("mhba006",FALSE)
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM mhbb_t
    WHERE mhbbent = g_enterprise
      AND mhbbdocno = g_mhba_m.mhbadocno
   IF l_cnt >= 1 THEN
      CALL cl_set_comp_entry("mhba000",FALSE)
      CALL cl_set_comp_entry("mhba001",FALSE)
      CALL cl_set_comp_entry("mhba002",FALSE)
      CALL cl_set_comp_entry("mhba003",FALSE)
      CALL cl_set_comp_entry("mhba006",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amht204.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amht204_set_entry_b(p_cmd)
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
   #CALL cl_set_comp_entry("mhbbacti",FALSE) #mark by geza 20160614 #160604-00009#27
   CALL cl_set_comp_entry("mhbbacti",TRUE) #add by geza 20160614 #160604-00009#27
   CALL cl_set_comp_entry("mhbbl003",TRUE)
   CALL cl_set_comp_entry("mhbbl004",TRUE)
   CALL cl_set_comp_entry("mhbb001",TRUE)
   CALL cl_set_comp_entry("mhbb002",TRUE)
   CALL cl_set_comp_entry("mhbb003",TRUE)
   CALL cl_set_comp_entry("mhbb006",TRUE)
   CALL cl_set_comp_entry("mhbb007",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="amht204.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amht204_set_no_entry_b(p_cmd)
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
   IF g_mhba_m.mhba000 = 'U' THEN
      CALL cl_set_comp_entry("mhbbl003",FALSE)
      CALL cl_set_comp_entry("mhbbl004",FALSE)
   END IF
   #樓棟
   IF NOT cl_null(g_mhba_m.mhba001) THEN
      CALL cl_set_comp_entry("mhbb001",FALSE)
   END IF
   #樓層
   IF NOT cl_null(g_mhba_m.mhba002) THEN
      CALL cl_set_comp_entry("mhbb002",FALSE)
   END IF
   #mark by geza 20160627 #160604-00009#100(S)
   #區域
#   IF NOT cl_null(g_mhba_m.mhba003) THEN
#      CALL cl_set_comp_entry("mhbb003",FALSE)
#   END IF
   #mark by geza 20160627 #160604-00009#100(E)
   #面積
   IF g_mhba_m.mhba000 = 'U' THEN
      IF cl_null(g_mhba_m.mhba006) THEN
         IF g_mhbb_d[l_ac].mhbb008 = '1' THEN
            CALL cl_set_comp_entry("mhbbacti",FALSE) #mark by geza 20160614 #160604-00009#27
            #CALL cl_set_comp_entry("mhbb006",FALSE) #mark by geza 20160614 #160604-00009#27
            #CALL cl_set_comp_entry("mhbb007",FALSE) #mark by geza 20160614 #160604-00009#27
            CALL cl_set_comp_entry("mhbb001",FALSE)
            CALL cl_set_comp_entry("mhbb002",FALSE)
            #CALL cl_set_comp_entry("mhbb003",FALSE)#mark by geza 20160627 #160604-00009#100
         END IF
      ELSE
         IF g_mhbb_d[l_ac].mhbb008 = '0' THEN
            CALL cl_set_comp_entry("mhbbacti",FALSE) #mark by geza 20160614 #160604-00009#27
            CALL cl_set_comp_entry("mhbb001",FALSE)
            CALL cl_set_comp_entry("mhbb002",FALSE)
            #CALL cl_set_comp_entry("mhbb003",FALSE)#mark by geza 20160627 #160604-00009#100
         END IF
      END IF
   END IF
   #add by geza 20160622 #160604-00009#27(S)
#   IF g_mhbb_d[l_ac].mhbb008 = '1' THEN
#      CALL cl_set_comp_entry("mhbbacti",FALSE)
#   END IF
   #add by geza 20160622 #160604-00009#27(E)
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="amht204.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION amht204_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("reproduce",TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amht204.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION amht204_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:2)
   IF g_mhba_m.mhbastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   CALL cl_set_act_visible("reproduce",FALSE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amht204.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION amht204_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amht204.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION amht204_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amht204.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amht204_default_search()
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
      LET ls_wc = ls_wc, " mhbadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "mhba_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mhbb_t" 
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
 
{<section id="amht204.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION amht204_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_mhba_m.mhbastus = 'Y' OR g_mhba_m.mhbastus = 'X' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mhba_m.mhbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN amht204_cl USING g_enterprise,g_mhba_m.mhbadocno
   IF STATUS THEN
      CLOSE amht204_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amht204_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE amht204_master_referesh USING g_mhba_m.mhbadocno INTO g_mhba_m.mhbasite,g_mhba_m.mhbadocdt, 
       g_mhba_m.mhbadocno,g_mhba_m.mhba000,g_mhba_m.mhba006,g_mhba_m.mhba004,g_mhba_m.mhba005,g_mhba_m.mhba001, 
       g_mhba_m.mhba002,g_mhba_m.mhba003,g_mhba_m.mhbaunit,g_mhba_m.mhbastus,g_mhba_m.mhbaownid,g_mhba_m.mhbaowndp, 
       g_mhba_m.mhbacrtid,g_mhba_m.mhbacrtdp,g_mhba_m.mhbacrtdt,g_mhba_m.mhbamodid,g_mhba_m.mhbamoddt, 
       g_mhba_m.mhbacnfid,g_mhba_m.mhbacnfdt,g_mhba_m.mhbasite_desc,g_mhba_m.mhba004_desc,g_mhba_m.mhba005_desc, 
       g_mhba_m.mhba001_desc,g_mhba_m.mhba002_desc,g_mhba_m.mhbaownid_desc,g_mhba_m.mhbaowndp_desc,g_mhba_m.mhbacrtid_desc, 
       g_mhba_m.mhbacrtdp_desc,g_mhba_m.mhbamodid_desc,g_mhba_m.mhbacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT amht204_action_chk() THEN
      CLOSE amht204_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mhba_m.mhbasite,g_mhba_m.mhbasite_desc,g_mhba_m.mhbadocdt,g_mhba_m.mhbadocno,g_mhba_m.mhba000, 
       g_mhba_m.mhba006,g_mhba_m.mhba004,g_mhba_m.mhba004_desc,g_mhba_m.mhba005,g_mhba_m.mhba005_desc, 
       g_mhba_m.mhba001,g_mhba_m.mhba001_desc,g_mhba_m.mhba002,g_mhba_m.mhba002_desc,g_mhba_m.mhba003, 
       g_mhba_m.mhba003_desc,g_mhba_m.mhbaunit,g_mhba_m.mhbastus,g_mhba_m.mhbaownid,g_mhba_m.mhbaownid_desc, 
       g_mhba_m.mhbaowndp,g_mhba_m.mhbaowndp_desc,g_mhba_m.mhbacrtid,g_mhba_m.mhbacrtid_desc,g_mhba_m.mhbacrtdp, 
       g_mhba_m.mhbacrtdp_desc,g_mhba_m.mhbacrtdt,g_mhba_m.mhbamodid,g_mhba_m.mhbamodid_desc,g_mhba_m.mhbamoddt, 
       g_mhba_m.mhbacnfid,g_mhba_m.mhbacnfid_desc,g_mhba_m.mhbacnfdt
 
   CASE g_mhba_m.mhbastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_mhba_m.mhbastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      #open皆改為unconfirmed
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)

      CASE g_mhba_m.mhbastus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)

         #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"
            CALL cl_set_act_visible("confirmed ",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid",FALSE)

        #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT amht204_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE amht204_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT amht204_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE amht204_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
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
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_mhba_m.mhbastus = lc_state OR cl_null(lc_state) THEN
      CLOSE amht204_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()

   OPEN amht204_cl USING g_enterprise,g_mhba_m.mhbadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amht204_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE amht204_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   CALL cl_err_collect_init()
   IF lc_state = 'Y' THEN
      IF NOT s_amht204_conf_chk(g_mhba_m.mhbadocno) THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
         RETURN
      ELSE 
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
            RETURN
         ELSE
            IF NOT s_amht204_conf_upd(g_mhba_m.mhbadocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   
   IF lc_state = 'X' THEN
      IF NOT s_amht204_invalid_chk(g_mhba_m.mhbadocno) THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
            RETURN
         ELSE
            IF NOT s_amht204_invalid_upd(g_mhba_m.mhbadocno)  THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_mhba_m.mhbamodid = g_user
   LET g_mhba_m.mhbamoddt = cl_get_current()
   LET g_mhba_m.mhbastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mhba_t 
      SET (mhbastus,mhbamodid,mhbamoddt) 
        = (g_mhba_m.mhbastus,g_mhba_m.mhbamodid,g_mhba_m.mhbamoddt)     
    WHERE mhbaent = g_enterprise AND mhbadocno = g_mhba_m.mhbadocno
 
    
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
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE amht204_master_referesh USING g_mhba_m.mhbadocno INTO g_mhba_m.mhbasite,g_mhba_m.mhbadocdt, 
          g_mhba_m.mhbadocno,g_mhba_m.mhba000,g_mhba_m.mhba006,g_mhba_m.mhba004,g_mhba_m.mhba005,g_mhba_m.mhba001, 
          g_mhba_m.mhba002,g_mhba_m.mhba003,g_mhba_m.mhbaunit,g_mhba_m.mhbastus,g_mhba_m.mhbaownid,g_mhba_m.mhbaowndp, 
          g_mhba_m.mhbacrtid,g_mhba_m.mhbacrtdp,g_mhba_m.mhbacrtdt,g_mhba_m.mhbamodid,g_mhba_m.mhbamoddt, 
          g_mhba_m.mhbacnfid,g_mhba_m.mhbacnfdt,g_mhba_m.mhbasite_desc,g_mhba_m.mhba004_desc,g_mhba_m.mhba005_desc, 
          g_mhba_m.mhba001_desc,g_mhba_m.mhba002_desc,g_mhba_m.mhbaownid_desc,g_mhba_m.mhbaowndp_desc, 
          g_mhba_m.mhbacrtid_desc,g_mhba_m.mhbacrtdp_desc,g_mhba_m.mhbamodid_desc,g_mhba_m.mhbacnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mhba_m.mhbasite,g_mhba_m.mhbasite_desc,g_mhba_m.mhbadocdt,g_mhba_m.mhbadocno, 
          g_mhba_m.mhba000,g_mhba_m.mhba006,g_mhba_m.mhba004,g_mhba_m.mhba004_desc,g_mhba_m.mhba005, 
          g_mhba_m.mhba005_desc,g_mhba_m.mhba001,g_mhba_m.mhba001_desc,g_mhba_m.mhba002,g_mhba_m.mhba002_desc, 
          g_mhba_m.mhba003,g_mhba_m.mhba003_desc,g_mhba_m.mhbaunit,g_mhba_m.mhbastus,g_mhba_m.mhbaownid, 
          g_mhba_m.mhbaownid_desc,g_mhba_m.mhbaowndp,g_mhba_m.mhbaowndp_desc,g_mhba_m.mhbacrtid,g_mhba_m.mhbacrtid_desc, 
          g_mhba_m.mhbacrtdp,g_mhba_m.mhbacrtdp_desc,g_mhba_m.mhbacrtdt,g_mhba_m.mhbamodid,g_mhba_m.mhbamodid_desc, 
          g_mhba_m.mhbamoddt,g_mhba_m.mhbacnfid,g_mhba_m.mhbacnfid_desc,g_mhba_m.mhbacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE amht204_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amht204_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amht204.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION amht204_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mhbb_d.getLength() THEN
         LET g_detail_idx = g_mhbb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mhbb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mhbb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amht204.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION amht204_b_fill2(pi_idx)
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
   
   CALL amht204_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="amht204.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION amht204_fill_chk(ps_idx)
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
 
{<section id="amht204.status_show" >}
PRIVATE FUNCTION amht204_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amht204.mask_functions" >}
&include "erp/amh/amht204_mask.4gl"
 
{</section>}
 
{<section id="amht204.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION amht204_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL amht204_show()
   CALL amht204_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   IF NOT s_amht204_conf_chk(g_mhba_m.mhbadocno) THEN
      CLOSE amht204_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_mhba_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_mhbb_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL amht204_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL amht204_ui_headershow()
   CALL amht204_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION amht204_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL amht204_ui_headershow()  
   CALL amht204_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="amht204.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amht204_set_pk_array()
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
   LET g_pk_array[1].values = g_mhba_m.mhbadocno
   LET g_pk_array[1].column = 'mhbadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amht204.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="amht204.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION amht204_msgcentre_notify(lc_state)
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
   CALL amht204_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mhba_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amht204.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION amht204_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#20 add-S
   SELECT mhbastus  INTO g_mhba_m.mhbastus
     FROM mhba_t
    WHERE mhbaent = g_enterprise
      AND mhbadocno = g_mhba_m.mhbadocno

   IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mhba_m.mhbastus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_mhba_m.mhbadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL amht204_set_act_visible()
        CALL amht204_set_act_no_visible()
        CALL amht204_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#20 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amht204.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取部門
# Memo...........:
# Usage..........: CALL amht204_mhba004_def(p_ooag001)
#                  RETURNING  r_ooag003
# Input parameter: p_ooag001      員工編號
# Return code....: r_ooag003      部門編號
# Date & Author..: 2016/03/03 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION amht204_mhba004_def(p_ooag001)
DEFINE p_ooag001        LIKE ooag_t.ooag001
DEFINE r_ooag003        LIKE ooag_t.ooag003

   WHENEVER ERROR CONTINUE

   LET r_ooag003 = ''
   SELECT ooag003 INTO r_ooag003
     FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = p_ooag001

   RETURN r_ooag003
END FUNCTION

################################################################################
# Descriptions...: 樓棟說明
# Memo...........:
# Usage..........: CALL amht204_mhaal003(p_mhaal001)
#                  RETURNING r_mhaal003
# Input parameter: p_mhaal001     樓棟編號
# Return code....: r_mhaal003     樓棟說明
# Date & Author..: 2016/03/03 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION amht204_mhaal003(p_mhaal001)
DEFINE p_mhaal001        LIKE mhaal_t.mhaal001
DEFINE r_mhaal003        LIKE mhaal_t.mhaal003

   LET r_mhaal003 = ''
   
   SELECT mhaal003 INTO r_mhaal003
     FROM mhaal_t
    WHERE mhaalent = g_enterprise
      AND mhaal001 = p_mhaal001
      AND mhaal002 = g_dlang
      
   RETURN r_mhaal003
END FUNCTION

################################################################################
# Descriptions...: 樓層說明
# Memo...........:
# Usage..........: CALL amht204_mhabl004(p_mhabl001,p_mhabl002)
#                  RETURNING r_mhabl004
# Input parameter: p_mhabl001     樓棟編號
#                : p_mhabl002     樓層編號
# Return code....: r_mhabl004     樓層說明
# Date & Author..: 2016/03/03 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION amht204_mhabl004(p_mhabl001,p_mhabl002)
DEFINE p_mhabl001        LIKE mhabl_t.mhabl001
DEFINE p_mhabl002        LIKE mhabl_t.mhabl002
DEFINE r_mhabl004        LIKE mhabl_t.mhabl004

   LET r_mhabl004 = ''
   
   SELECT mhabl004 INTO r_mhabl004
     FROM mhabl_t
    WHERE mhablent = g_enterprise
      AND mhabl001 = p_mhabl001
      AND mhabl002 = p_mhabl002
      AND mhabl003 = g_dlang
   
   RETURN r_mhabl004
END FUNCTION

################################################################################
# Descriptions...: 區域說明
# Memo...........:
# Usage..........: CALL amht204_mhacl005(p_mhacl001,p_mhacl002,p_mhacl003)
#                  RETURNING r_mhacl005
# Input parameter: p_mhacl001     樓棟編號
#                : p_mhacl002     樓層編號
#                : p_mhacl003     區域編號
# Return code....: r_mhacl005     區域說明
# Date & Author..: 2016/03/03 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION amht204_mhacl005(p_mhacl001,p_mhacl002,p_mhacl003)
DEFINE p_mhacl001        LIKE mhacl_t.mhacl001
DEFINE p_mhacl002        LIKE mhacl_t.mhacl002
DEFINE p_mhacl003        LIKE mhacl_t.mhacl003
DEFINE r_mhacl005        LIKE mhacl_t.mhacl005

   LET r_mhacl005 = ''
   
   SELECT mhacl005 INTO r_mhacl005
     FROM mhacl_t
    WHERE mhaclent = g_enterprise
      AND mhacl001 = p_mhacl001
      AND mhacl002 = p_mhacl002
      AND mhacl003 = p_mhacl003
      AND mhacl004 = g_dlang
   
   RETURN r_mhacl005
END FUNCTION

################################################################################
# Descriptions...: 場地檢查
# Memo...........:
# Usage..........: CALL amht204_mhbb004_chk()
#                     RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2016/03/07 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION amht204_mhbb004_chk()
DEFINE r_success         LIKE type_t.num5
DEFINE l_mhadsite        LIKE mhad_t.mhadsite
DEFINE l_cnt             LIKE type_t.num10
DEFINE l_msg             LIKE type_t.chr10
DEFINE l_where           STRING
DEFINE l_sql             STRING

   LET r_success = TRUE
   
   IF g_mhba_m.mhba000 = 'I' THEN
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM mhad_t
       WHERE mhadent = g_enterprise
         AND mhad004 = g_mhbb_d[l_ac].mhbb004
      IF l_cnt >= 1 THEN
         #新增的場地編號%1已經存在場地基本資料檔中！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "amh-00625"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_mhbb_d[l_ac].mhbb004
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM mhbb_t,mhba_t
       WHERE mhbaent = mhbbent
         AND mhbadocno = mhbbdocno
         AND mhbastus = 'N'
         AND mhbaent = g_enterprise
         AND mhbb004 = g_mhbb_d[l_ac].mhbb004
      IF l_cnt >= 1 THEN
         #新增的場地編號已經存在未確認場地申請檔中！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "amh-00626"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_mhbb_d[l_ac].mhbb004
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM mhad_t
       WHERE mhadent = g_enterprise
         AND mhad004 = g_mhbb_d[l_ac].mhbb004
      IF l_cnt = 0 THEN
         #修改的場地編號不存在場地基本資料檔中！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "amh-00647"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM mhbb_t,mhba_t
       WHERE mhbaent = mhbbent
         AND mhbadocno = mhbbdocno
         AND mhbastus = 'N'
         AND mhbaent = g_enterprise
         AND mhbb004 = g_mhbb_d[l_ac].mhbb004
         AND mhbadocno <> g_mhba_m.mhbadocno #160606-00034#1 20160613 add by beckxie
      IF l_cnt >= 1 THEN
         #場地編號%1尚在申請新增場地單中且未確認，不可申請修改!
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "amh-00644"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_mhbb_d[l_ac].mhbb004
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_cnt = 0
      LET l_sql = "SELECT COUNT(1)",
                  "  FROM mhad_t",
                  " WHERE mhadent = ",g_enterprise,
                  "   AND mhad004 = '",g_mhbb_d[l_ac].mhbb004,"'"
      #樓棟
      IF NOT cl_null(g_mhba_m.mhba001) THEN
         LET l_sql = l_sql," AND mhad001 = '",g_mhba_m.mhba001,"'"
         #輸入的場地編號%1不存在場地基本資料中屬於樓棟%2！
         LET l_msg = 'amh-00648'
      END IF
      #樓層
      IF NOT cl_null(g_mhba_m.mhba002) THEN
         LET l_sql = l_sql," AND mhad002 = '",g_mhba_m.mhba002,"'"
         #輸入的場地編號%1不存在場地基本資料中屬於樓棟%2+樓層%3！
         LET l_msg = 'amh-00649'
      END IF
      #區域
      IF NOT cl_null(g_mhba_m.mhba003) THEN
         LET l_sql = l_sql," AND mhad003 = '",g_mhba_m.mhba003,"'"
         #輸入的場地編號%1不存在場地基本資料中屬於樓棟%2+樓層%3+區域%4！
         LET l_msg = 'amh-00650'
      END IF
      PREPARE amht204_mhbb004_chk FROM l_sql
      LET l_cnt = 0
      EXECUTE amht204_mhbb004_chk INTO l_cnt
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_msg
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_mhbb_d[l_ac].mhbb004
         LET g_errparam.replace[2] = g_mhba_m.mhba001
         LET g_errparam.replace[3] = g_mhba_m.mhba002
         LET g_errparam.replace[4] = g_mhba_m.mhba003   
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 場地說明
# Memo...........:
# Usage..........: CALL amht204_mhbb004_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/03/07 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION amht204_mhbb004_ref()

   LET g_mhbb_d[l_ac].mhbbl003 = ''
   LET g_mhbb_d[l_ac].mhbbl004 = ''
   
   IF g_mhba_m.mhba000 = 'I' THEN
      SELECT mhbbl003,mhbbl004
        INTO g_mhbb_d[l_ac].mhbbl003,g_mhbb_d[l_ac].mhbbl004
        FROM mhbbl_t
       WHERE mhbblent = g_enterprise
         AND mhbbldocno = g_mhba_m.mhbadocno
         AND mhbbl001 = g_mhbb_d[l_ac].mhbb004
         AND mhbbl002 = g_dlang
   ELSE
      SELECT mhadl006,mhadl007
        INTO g_mhbb_d[l_ac].mhbbl003,g_mhbb_d[l_ac].mhbbl004
        FROM mhadl_t
       WHERE mhadlent = g_enterprise
         AND mhadl001 = g_mhbb_d[l_ac].mhbb001
         AND mhadl002 = g_mhbb_d[l_ac].mhbb002
         AND mhadl003 = g_mhbb_d[l_ac].mhbb003
         AND mhadl004 = g_mhbb_d[l_ac].mhbb004
         AND mhadl005 = g_dlang
   END IF
   
   DISPLAY BY NAME g_mhbb_d[l_ac].mhbbl003,g_mhbb_d[l_ac].mhbbl004
END FUNCTION

################################################################################
# Descriptions...: 場地帶出預設值
# Memo...........:
# Usage..........: CALL amht204_mhbb004_def()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/03/07 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION amht204_mhbb004_def()
DEFINE l_mhbb003         LIKE mhbb_t.mhbb003
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_sql             STRING

   IF g_mhba_m.mhba000 = 'I' THEN
      IF g_mhbb_d[l_ac].mhbb006 = 0 AND g_mhbb_d[l_ac].mhbb007 > 0 THEN
         CALL amht204_area_cal(2)
      ELSE
         CALL amht204_area_cal(1)
      END IF
      RETURN
   END IF
   
   LET g_mhbb_d[l_ac].mhbb005 = 0
   LET g_mhbb_d[l_ac].mhbb006 = ''
   LET g_mhbb_d[l_ac].mhbb007 = ''
   LET g_mhbb_d[l_ac].mhbb008 = ''
   LET g_mhbb_d[l_ac].mhbb009 = ''
   LET g_mhbb_d[l_ac].mhbbunit = ''
   LET g_mhbb_d[l_ac].mhbbl003 = ''
   LET g_mhbb_d[l_ac].mhbbl004 = ''
   
   
   IF cl_null(g_mhbb_d[l_ac].mhbb003) THEN
      LET l_mhbb003 = ' '
   ELSE
      LET l_mhbb003 = g_mhbb_d[l_ac].mhbb003
   END IF
   
   IF cl_null(g_mhbb_d[l_ac].mhbb001) OR cl_null(g_mhbb_d[l_ac].mhbb002) THEN
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM mhad_t
       WHERE mhadent = g_enterprise
         AND mhad004 = g_mhbb_d[l_ac].mhbb004
      IF l_cnt >=2 THEN
         RETURN
      END IF
      
      SELECT mhad001, mhad002, mhad003,
             mhad005, mhad006, mhad007,
             mhad008, mhad009, mhadunit,
             mhad010, mhadstus #add by geza 20160614 #160604-00009#27
        INTO g_mhbb_d[l_ac].mhbb001, g_mhbb_d[l_ac].mhbb002, g_mhbb_d[l_ac].mhbb003,
             g_mhbb_d[l_ac].mhbb005, g_mhbb_d[l_ac].mhbb006, g_mhbb_d[l_ac].mhbb007,
             g_mhbb_d[l_ac].mhbb008, g_mhbb_d[l_ac].mhbb009, g_mhbb_d[l_ac].mhbbunit,
             g_mhbb_d[l_ac].mhbb010, g_mhbb_d[l_ac].mhbbacti #add by geza 20160614 #160604-00009#27
        FROM mhad_t
       WHERE mhadent = g_enterprise
         AND mhad004 = g_mhbb_d[l_ac].mhbb004
      
      #add by geza 20160614 #160604-00009#27(S)
      #场地等级
      CALL s_desc_get_acc_desc('2145',g_mhbb_d[l_ac].mhbb010)  RETURNING g_mhbb_d[l_ac].mhbb010_desc
            DISPLAY BY NAME g_mhbb_d[l_ac].mhbb010_desc
      #add by geza 20160614 #160604-00009#27(E)
      #樓棟
      CALL amht204_mhaal003(g_mhbb_d[l_ac].mhbb001)
         RETURNING g_mhbb_d[l_ac].mhbb001_desc
      
      #樓層
      CALL amht204_mhabl004(g_mhbb_d[l_ac].mhbb001,g_mhbb_d[l_ac].mhbb002)
         RETURNING g_mhbb_d[l_ac].mhbb002_desc
      
      #區域
      CALL amht204_mhacl005(g_mhbb_d[l_ac].mhbb001,g_mhbb_d[l_ac].mhbb002,g_mhbb_d[l_ac].mhbb003)
         RETURNING g_mhbb_d[l_ac].mhbb003_desc
   ELSE
      SELECT mhad005, mhad006, mhad007,
             mhad008, mhad009, mhadunit,
             mhad010, mhadstus #add by geza 20160614 #160604-00009#27
        INTO g_mhbb_d[l_ac].mhbb005, g_mhbb_d[l_ac].mhbb006, g_mhbb_d[l_ac].mhbb007,
             g_mhbb_d[l_ac].mhbb008, g_mhbb_d[l_ac].mhbb009, g_mhbb_d[l_ac].mhbbunit,
             g_mhbb_d[l_ac].mhbb010, g_mhbb_d[l_ac].mhbbacti  #add by geza 20160614 #160604-00009#27
        FROM mhad_t
       WHERE mhadent = g_enterprise
         AND mhad001 = g_mhbb_d[l_ac].mhbb001
         AND mhad002 = g_mhbb_d[l_ac].mhbb002
         AND mhad003 = l_mhbb003
         AND mhad004 = g_mhbb_d[l_ac].mhbb004
      #add by geza 20160614 #160604-00009#27(S)
      #场地等级
      CALL s_desc_get_acc_desc('2145',g_mhbb_d[l_ac].mhbb010)  RETURNING g_mhbb_d[l_ac].mhbb010_desc
            DISPLAY BY NAME g_mhbb_d[l_ac].mhbb010_desc
      #add by geza 20160614 #160604-00009#27(E)
   END IF
   
   IF cl_null(g_mhbb_d[l_ac].mhbb009) THEN
      LET g_mhbb_d[l_ac].mhbb009 = 1
   ELSE
      LET g_mhbb_d[l_ac].mhbb009 = g_mhbb_d[l_ac].mhbb009 + 1
   END IF
   
   IF cl_null(g_mhbb_d[l_ac].mhbbunit) THEN
      LET g_mhbb_d[l_ac].mhbbunit = g_mhbb_d[l_ac].mhbbsite
   END IF
   
   SELECT mhadl006, mhadl007
     INTO g_mhbb_d[l_ac].mhbbl003, g_mhbb_d[l_ac].mhbbl004
     FROM mhadl_t
    WHERE mhadlent = g_enterprise
      AND mhadl001 = g_mhbb_d[l_ac].mhbb001
      AND mhadl002 = g_mhbb_d[l_ac].mhbb002
      AND mhadl003 = l_mhbb003
      AND mhadl004 = g_mhbb_d[l_ac].mhbb004
      AND mhadl005 = g_dlang
   
END FUNCTION

################################################################################
# Descriptions...: 面積計算
# Memo...........:
# Usage..........: CALL amht204_area_cal(p_type)
# Input parameter: p_type         1.測量面積 2.經營面積
# Return code....: 無
# Date & Author..: 2016/03/08 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION amht204_area_cal(p_type)
DEFINE p_type            LIKE type_t.num5
DEFINE l_mhab            RECORD
       mhab008           LIKE mhab_t.mhab008,   #建築公攤率
       mhab009           LIKE mhab_t.mhab009    #公攤系數
                         END RECORD
   
   #當樓棟或樓層欄位值為空，無法計算
   IF cl_null(g_mhbb_d[l_ac].mhbb001) OR cl_null(g_mhbb_d[l_ac].mhbb002) THEN
      RETURN
   END IF
   
   INITIALIZE l_mhab.* TO NULL
   SELECT mhab008,mhab009
     INTO l_mhab.mhab008, l_mhab.mhab009
     FROM mhab_t
    WHERE mhabent = g_enterprise
      AND mhab001 = g_mhbb_d[l_ac].mhbb001
      AND mhab002 = g_mhbb_d[l_ac].mhbb002
   
   IF cl_null(l_mhab.mhab008) THEN
      LET l_mhab.mhab008 = 0
   END IF
   
   IF cl_null(l_mhab.mhab009) THEN
      LET l_mhab.mhab009 = 0
   END IF
   
   IF p_type = 1 THEN
      #測量面積
      #建築面積(mhbb005) = 測量面積(mhbb006) * (1+建築公攤率(mhab008)/100)
      #經營面積(mhbb007) = 測量面積(mhbb006) * 公攤系數(mhab009)
      LET g_mhbb_d[l_ac].mhbb005 = g_mhbb_d[l_ac].mhbb006 * (1 + l_mhab.mhab008/100)
      LET g_mhbb_d[l_ac].mhbb007 = g_mhbb_d[l_ac].mhbb006 * l_mhab.mhab009
   ELSE
      #經營面積
      #測量面積(mhbb006) = 經營面積(mhbb007) / 公攤系數(mhab009)
      #建築面積(mhbb005) = 測量面積(mhbb006) * (1+建築公攤率(mhab008)/100)
      IF l_mhab.mhab009 = 0 THEN
         LET g_mhbb_d[l_ac].mhbb006 = 0
      ELSE
         LET g_mhbb_d[l_ac].mhbb006 = g_mhbb_d[l_ac].mhbb007 / l_mhab.mhab009
      END IF
      LET g_mhbb_d[l_ac].mhbb005 = g_mhbb_d[l_ac].mhbb006 * (1 + l_mhab.mhab008/100)
   END IF
   DISPLAY BY NAME g_mhbb_d[l_ac].mhbb005,g_mhbb_d[l_ac].mhbb006,
                   g_mhbb_d[l_ac].mhbb007
END FUNCTION

################################################################################
# Descriptions...: 面積檢查
# Memo...........:
# Usage..........: CALL amht204_area_chk()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2016/03/08 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION amht204_area_chk()
DEFINE r_success         LIKE type_t.num5
DEFINE l_mhaa            RECORD
       mhaa005           LIKE mhab_t.mhab005,   #圖紙建築面積
       mhaa006           LIKE mhab_t.mhab006    #圖紙測量面積
                         END RECORD
DEFINE l_mhab            RECORD
       mhab006           LIKE mhab_t.mhab006,   #圖紙建築面積
       mhab007           LIKE mhab_t.mhab007    #圖紙測量面積
                         END RECORD
DEFINE l_sum             RECORD
       mhbb005           LIKE mhbb_t.mhbb005,   #建築面積
       mhbb006           LIKE mhbb_t.mhbb006,   #測量面積
       mhbb007           LIKE mhbb_t.mhbb007    #經營面積
                         END RECORD
DEFINE l_mhad            RECORD
       mhad005           LIKE mhad_t.mhad005,   #建築面積
       mhad006           LIKE mhad_t.mhad006,   #測量面積
       mhad007           LIKE mhad_t.mhad007    #經營面積
                         END RECORD
DEFINE l_mhbb            RECORD
       mhbb005           LIKE mhbb_t.mhbb005,   #建築面積
       mhbb006           LIKE mhbb_t.mhbb006,   #測量面積
       mhbb007           LIKE mhbb_t.mhbb007    #經營面積
                         END RECORD
DEFINE l_sql             RECORD
       mhbb              STRING,
       mhad              STRING,
       mhbb_sql          STRING,
       mhad_sql          STRING,
       mhbb002           STRING,
       mhbb001           STRING
                         END RECORD

   LET r_success = TRUE
   INITIALIZE l_sql.* TO NULL
   
   LET l_sql.mhbb = "SELECT SUM(COALESCE(mhbb005,0)),SUM(COALESCE(mhbb006,0)),SUM(COALESCE(mhbb07,0))",
                    "  FROM mhbb_t",
                    " WHERE mhbbent = ",g_enterprise,
                    "   AND mhbbdocno = '",g_mhba_m.mhbadocno,"'",
                    "   AND mhbbacti = 'Y'",
                    "   AND mhbb004 <> '",g_mhbb_d[l_ac].mhbb004,"'"
   LET l_sql.mhad = "SELECT SUM(COALESCE(mhad005,0)),SUM(COALESCE(mhad006,0)),SUM(COALESCE(mhad07,0))",
                    "  FROM mhad_t",
                    " WHERE mhadent = ",g_enterprise,
                    "   AND mhadstus = 'Y'"
   INITIALIZE l_mhbb.* TO NULL
   INITIALIZE l_mhad.* TO NULL
   
   #樓棟樓層
   IF NOT cl_null(g_mhbb_d[l_ac].mhbb002) THEN
      LET l_sql.mhbb002 = l_sql.mhbb,
                          " AND mhbb001 = '",g_mhbb_d[l_ac].mhbb001,"'",
                          " AND mhbb002 = '",g_mhbb_d[l_ac].mhbb002,"'"
      PREPARE amht204_sum_mhbb FROM l_sql.mhbb002
      EXECUTE amht204_sum_mhbb
         INTO l_mhbb.mhbb005, l_mhbb.mhbb006, l_mhbb.mhbb007
      
      #主檔面積總額
      LET l_sql.mhad_sql = l_sql.mhad,
                           " AND mhad001 = '",g_mhbb_d[l_ac].mhbb001,"'",
                           " AND mhad002 = '",g_mhbb_d[l_ac].mhbb002,"'",
                           " AND NOT EXISTS(SELECT 1",
                           "                  FROM mhbb_t",
                           "                 WHERE mhbbnet = mhadent",
                           "                   AND mhbb001 = mhad001",
                           "                   AND mhbb002 = mhad002",
                           "                   AND mhbb003 = mhad003",
                           "                   AND mhbb004 = mhad004",
                           "                   AND mhbbdocno = '",g_mhba_m.mhbadocno,"')"
      PREPARE amht204_sum_mhad FROM l_sql.mhad_sql
      EXECUTE amht204_sum_mhad INTO l_mhad.mhad005, l_mhad.mhad006, l_mhad.mhad007
      LET l_sum.mhbb005 = l_mhbb.mhbb005 + l_mhad.mhad005 + g_mhbb_d[l_ac].mhbb005  #建築面積
      LET l_sum.mhbb006 = l_mhbb.mhbb006 + l_mhad.mhad006 + g_mhbb_d[l_ac].mhbb006  #測量面積
      LET l_sum.mhbb007 = l_mhbb.mhbb007 + l_mhad.mhad007 + g_mhbb_d[l_ac].mhbb007  #經營面積
      
      #樓棟樓層紙圖面積
      INITIALIZE l_mhab.* TO NULL
      SELECT mhab006, mhab007
        INTO l_mhab.mhab006, l_mhab.mhab007
        FROM mhab_t
       WHERE mhabent = g_enterprise
         AND mhab001 = g_mhbb_d[l_ac].mhbb001
         AND mhab002 = g_mhbb_d[l_ac].mhbb002
      IF cl_null(l_mhab.mhab006) THEN LET l_mhab.mhab006 = 0 END IF
      IF cl_null(l_mhab.mhab007) THEN LET l_mhab.mhab007 = 0 END IF
      
      IF l_sum.mhbb005 > l_mhab.mhab006 THEN
         #樓棟%1樓層%2的建築面積%3 > 圖紙建築面積%4！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amh-00631'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_mhbb_d[l_ac].mhbb001
         LET g_errparam.replace[2] = g_mhbb_d[l_ac].mhbb002
         LET g_errparam.replace[3] = l_sum.mhbb005
         LET g_errparam.replace[4] = l_mhab.mhab006
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      IF l_sum.mhbb006 > l_mhab.mhab007 THEN
         #樓棟%1樓層%2的測量面積%3 > 圖紙測量面積%4！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amh-00632'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_mhbb_d[l_ac].mhbb001
         LET g_errparam.replace[2] = g_mhbb_d[l_ac].mhbb002
         LET g_errparam.replace[3] = l_sum.mhbb006
         LET g_errparam.replace[4] = l_mhab.mhab007
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   INITIALIZE l_mhbb.* TO NULL
   INITIALIZE l_mhad.* TO NULL
   #樓棟
   IF NOT cl_null(g_mhbb_d[l_ac].mhbb001) THEN
      LET l_sql.mhbb001 = l_sql.mhbb," AND mhbb001 = '",g_mhbb_d[l_ac].mhbb001,"'"
      PREPARE amht204_sum_mhbb1 FROM l_sql.mhbb001
      EXECUTE amht204_sum_mhbb1
         INTO l_mhbb.mhbb005, l_mhbb.mhbb006, l_mhbb.mhbb007
         
      #主檔面積總額
      LET l_sql.mhad_sql = l_sql.mhad,
                           " AND mhad001 = '",g_mhbb_d[l_ac].mhbb001,"'",
                           " AND NOT EXISTS(SELECT 1",
                           "                  FROM mhbb_t",
                           "                 WHERE mhbbnet = mhadent",
                           "                   AND mhbb001 = mhad001",
                           "                   AND mhbb002 = mhad002",
                           "                   AND mhbb003 = mhad003",
                           "                   AND mhbb004 = mhad004",
                           "                   AND mhbbdocno = '",g_mhba_m.mhbadocno,"')"
      PREPARE amht204_sum_mhad1 FROM l_sql.mhad_sql
      EXECUTE amht204_sum_mhad1 INTO l_mhad.mhad005, l_mhad.mhad006, l_mhad.mhad007
      LET l_sum.mhbb005 = l_mhbb.mhbb005 + l_mhad.mhad005 + g_mhbb_d[l_ac].mhbb005  #建築面積
      LET l_sum.mhbb006 = l_mhbb.mhbb006 + l_mhad.mhad006 + g_mhbb_d[l_ac].mhbb006  #測量面積
      LET l_sum.mhbb007 = l_mhbb.mhbb007 + l_mhad.mhad007 + g_mhbb_d[l_ac].mhbb007  #經營面積
      
      #樓棟紙圖面積
      INITIALIZE l_mhaa.* TO NULL
      SELECT mhaa005, mhaa006
        INTO l_mhaa.mhaa005, l_mhaa.mhaa006
        FROM mhaa_t
       WHERE mhaaent = g_enterprise
         AND mhaa001 = g_mhbb_d[l_ac].mhbb001
      IF cl_null(l_mhaa.mhaa005) THEN LET l_mhaa.mhaa005 = 0 END IF
      IF cl_null(l_mhaa.mhaa006) THEN LET l_mhaa.mhaa006 = 0 END IF
      
      IF l_sum.mhbb005 > l_mhaa.mhaa005 THEN
         #樓棟%1的建築面積%2 > 圖紙建築面積%3！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amh-00631'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_mhbb_d[l_ac].mhbb001
         LET g_errparam.replace[2] = l_sum.mhbb005
         LET g_errparam.replace[3] = l_mhaa.mhaa005
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      IF l_sum.mhbb006 > l_mhaa.mhaa006 THEN
         #樓棟%1的測量面積%2 > 圖紙測量面積%3！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amh-00632'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_mhbb_d[l_ac].mhbb001
         LET g_errparam.replace[2] = l_sum.mhbb006
         LET g_errparam.replace[3] = l_mhaa.mhaa006
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
