#該程式未解開Section, 採用最新樣板產出!
{<section id="adbt700.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2015-06-25 17:09:03), PR版次:0011(2016-10-07 09:18:24)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000098
#+ Filename...: adbt700
#+ Description: 配送排車計劃維護作業
#+ Creator....: 02749(2014-07-31 14:43:24)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="adbt700.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
  #160318-00005#7     2016/03/23    by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
  #160318-00025#24    2016/04/25    BY 07900    校验代码重复错误讯息的修改
  #160818-00017#7     2016/08/24    by 08172    修改删除时重新检查状态
  #160825-00043#1     2016/08/30    by 06137    修正無啟用bpm時，未確認狀態按下出現抽單、提交選項問題
  #160824-00007#66    2016/10/07    by 06137    修正舊值備份寫法
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
PRIVATE type type_g_dbea_m        RECORD
       dbeasite LIKE dbea_t.dbeasite, 
   dbeasite_desc LIKE type_t.chr80, 
   dbeadocdt LIKE dbea_t.dbeadocdt, 
   dbeadocno LIKE dbea_t.dbeadocno, 
   dbeaunit LIKE dbea_t.dbeaunit, 
   dbea001 LIKE dbea_t.dbea001, 
   dbea002 LIKE dbea_t.dbea002, 
   dbea002_desc LIKE type_t.chr80, 
   dbea003 LIKE dbea_t.dbea003, 
   dbea003_desc LIKE type_t.chr80, 
   dbeastus LIKE dbea_t.dbeastus, 
   dbeaownid LIKE dbea_t.dbeaownid, 
   dbeaownid_desc LIKE type_t.chr80, 
   dbeaowndp LIKE dbea_t.dbeaowndp, 
   dbeaowndp_desc LIKE type_t.chr80, 
   dbeacrtid LIKE dbea_t.dbeacrtid, 
   dbeacrtid_desc LIKE type_t.chr80, 
   dbeacrtdp LIKE dbea_t.dbeacrtdp, 
   dbeacrtdp_desc LIKE type_t.chr80, 
   dbeacrtdt LIKE dbea_t.dbeacrtdt, 
   dbeamodid LIKE dbea_t.dbeamodid, 
   dbeamodid_desc LIKE type_t.chr80, 
   dbeamoddt LIKE dbea_t.dbeamoddt, 
   dbeacnfid LIKE dbea_t.dbeacnfid, 
   dbeacnfid_desc LIKE type_t.chr80, 
   dbeacnfdt LIKE dbea_t.dbeacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_dbed_d        RECORD
       dbed001 LIKE dbed_t.dbed001, 
   dbed001_desc LIKE type_t.chr500, 
   dbedsite LIKE dbed_t.dbedsite, 
   dbedunit LIKE dbed_t.dbedunit
       END RECORD
PRIVATE TYPE type_g_dbed2_d RECORD
       dbeb001 LIKE dbeb_t.dbeb001, 
   dbeb001_desc LIKE type_t.chr500, 
   dbeb002 LIKE dbeb_t.dbeb002, 
   dbeb002_desc LIKE type_t.chr500, 
   dbeb003 LIKE dbeb_t.dbeb003, 
   dbeb004 LIKE dbeb_t.dbeb004, 
   dbeb005 LIKE dbeb_t.dbeb005, 
   dbeb005_desc LIKE type_t.chr500, 
   dbeb006 LIKE dbeb_t.dbeb006, 
   dbeb007 LIKE dbeb_t.dbeb007, 
   dbeb008 LIKE dbeb_t.dbeb008, 
   dbeb008_desc LIKE type_t.chr500, 
   dbebsite LIKE dbeb_t.dbebsite, 
   dbebunit LIKE dbeb_t.dbebunit
       END RECORD
PRIVATE TYPE type_g_dbed3_d RECORD
       dbec002 LIKE dbec_t.dbec002, 
   dbec003 LIKE dbec_t.dbec003, 
   dbec004 LIKE dbec_t.dbec004, 
   dbec005 LIKE dbec_t.dbec005, 
   dbec006 LIKE dbec_t.dbec006, 
   dbec006_desc LIKE type_t.chr500, 
   dbec007 LIKE dbec_t.dbec007, 
   dbec008 LIKE dbec_t.dbec008, 
   dbec008_desc LIKE type_t.chr500, 
   dbec009 LIKE dbec_t.dbec009, 
   dbec010 LIKE dbec_t.dbec010, 
   dbec011 LIKE dbec_t.dbec011, 
   dbec012 LIKE dbec_t.dbec012, 
   dbec013 LIKE dbec_t.dbec013, 
   dbec014 LIKE dbec_t.dbec014, 
   dbec015 LIKE dbec_t.dbec015, 
   dbecsite LIKE dbec_t.dbecsite, 
   dbecunit LIKE dbec_t.dbecunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_dbeasite LIKE dbea_t.dbeasite,
   b_dbeasite_desc LIKE type_t.chr80,
      b_dbeadocdt LIKE dbea_t.dbeadocdt,
      b_dbeadocno LIKE dbea_t.dbeadocno,
      b_dbea001 LIKE dbea_t.dbea001,
      b_dbea002 LIKE dbea_t.dbea002,
   b_dbea002_desc LIKE type_t.chr80,
      b_dbea003 LIKE dbea_t.dbea003,
   b_dbea003_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004              LIKE ooef_t.ooef004
DEFINE g_ins_site_flag        LIKE type_t.chr1              #紀錄dbeasite 有無輸入資料, 作為欄位entry控制判斷
DEFINE g_ins_docno_flag       LIKE type_t.chr1              #紀錄dbeadocno 有無輸入資料, 作為欄位entry控制判斷 
#end add-point
       
#模組變數(Module Variables)
DEFINE g_dbea_m          type_g_dbea_m
DEFINE g_dbea_m_t        type_g_dbea_m
DEFINE g_dbea_m_o        type_g_dbea_m
DEFINE g_dbea_m_mask_o   type_g_dbea_m #轉換遮罩前資料
DEFINE g_dbea_m_mask_n   type_g_dbea_m #轉換遮罩後資料
 
   DEFINE g_dbeadocno_t LIKE dbea_t.dbeadocno
 
 
DEFINE g_dbed_d          DYNAMIC ARRAY OF type_g_dbed_d
DEFINE g_dbed_d_t        type_g_dbed_d
DEFINE g_dbed_d_o        type_g_dbed_d
DEFINE g_dbed_d_mask_o   DYNAMIC ARRAY OF type_g_dbed_d #轉換遮罩前資料
DEFINE g_dbed_d_mask_n   DYNAMIC ARRAY OF type_g_dbed_d #轉換遮罩後資料
DEFINE g_dbed2_d          DYNAMIC ARRAY OF type_g_dbed2_d
DEFINE g_dbed2_d_t        type_g_dbed2_d
DEFINE g_dbed2_d_o        type_g_dbed2_d
DEFINE g_dbed2_d_mask_o   DYNAMIC ARRAY OF type_g_dbed2_d #轉換遮罩前資料
DEFINE g_dbed2_d_mask_n   DYNAMIC ARRAY OF type_g_dbed2_d #轉換遮罩後資料
DEFINE g_dbed3_d          DYNAMIC ARRAY OF type_g_dbed3_d
DEFINE g_dbed3_d_t        type_g_dbed3_d
DEFINE g_dbed3_d_o        type_g_dbed3_d
DEFINE g_dbed3_d_mask_o   DYNAMIC ARRAY OF type_g_dbed3_d #轉換遮罩前資料
DEFINE g_dbed3_d_mask_n   DYNAMIC ARRAY OF type_g_dbed3_d #轉換遮罩後資料
 
 
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
 
{<section id="adbt700.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adb","")
 
   #add-point:作業初始化 name="main.init"
   CALL adbt700_create_tmp()
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT dbeasite,'',dbeadocdt,dbeadocno,dbeaunit,dbea001,dbea002,'',dbea003,'', 
       dbeastus,dbeaownid,'',dbeaowndp,'',dbeacrtid,'',dbeacrtdp,'',dbeacrtdt,dbeamodid,'',dbeamoddt, 
       dbeacnfid,'',dbeacnfdt", 
                      " FROM dbea_t",
                      " WHERE dbeaent= ? AND dbeadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adbt700_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.dbeasite,t0.dbeadocdt,t0.dbeadocno,t0.dbeaunit,t0.dbea001,t0.dbea002, 
       t0.dbea003,t0.dbeastus,t0.dbeaownid,t0.dbeaowndp,t0.dbeacrtid,t0.dbeacrtdp,t0.dbeacrtdt,t0.dbeamodid, 
       t0.dbeamoddt,t0.dbeacnfid,t0.dbeacnfdt,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 , 
       t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011",
               " FROM dbea_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.dbeasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.dbea002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.dbea003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.dbeaownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.dbeaowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.dbeacrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.dbeacrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.dbeamodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.dbeacnfid  ",
 
               " WHERE t0.dbeaent = " ||g_enterprise|| " AND t0.dbeadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adbt700_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adbt700 WITH FORM cl_ap_formpath("adb",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adbt700_init()   
 
      #進入選單 Menu (="N")
      CALL adbt700_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adbt700
      
   END IF 
   
   CLOSE adbt700_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adbt700.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adbt700_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
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
      CALL cl_set_combo_scc_part('dbeastus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   LET g_errshow = 1   #校驗訊息彈窗   
   #end add-point
   
   #初始化搜尋條件
   CALL adbt700_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="adbt700.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION adbt700_ui_dialog()
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
   DEFINE l_success LIKE type_t.num5
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
            CALL adbt700_insert()
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
         INITIALIZE g_dbea_m.* TO NULL
         CALL g_dbed_d.clear()
         CALL g_dbed2_d.clear()
         CALL g_dbed3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL adbt700_init()
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
               
               CALL adbt700_fetch('') # reload data
               LET l_ac = 1
               CALL adbt700_ui_detailshow() #Setting the current row 
         
               CALL adbt700_idx_chk()
               #NEXT FIELD dbed001
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_dbed_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL adbt700_idx_chk()
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
               CALL adbt700_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
 
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_dbed2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL adbt700_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               CALL adbt700_b_fill2('3')
 
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
               CALL adbt700_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #第二階單身段落
         DISPLAY ARRAY g_dbed3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL adbt700_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx2 = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL adbt700_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL adbt700_browser_fill("")
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
               CALL adbt700_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL adbt700_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL adbt700_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL adbt700_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL adbt700_set_act_visible()   
            CALL adbt700_set_act_no_visible()
            IF NOT (g_dbea_m.dbeadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " dbeaent = " ||g_enterprise|| " AND",
                                  " dbeadocno = '", g_dbea_m.dbeadocno, "' "
 
               #填到對應位置
               CALL adbt700_browser_fill("")
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
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "dbea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "dbed_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "dbeb_t" 
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
               CALL adbt700_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "dbea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "dbed_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "dbeb_t" 
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
                  CALL adbt700_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL adbt700_fetch("F")
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
               CALL adbt700_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL adbt700_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbt700_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL adbt700_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbt700_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL adbt700_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbt700_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL adbt700_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbt700_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL adbt700_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbt700_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_dbed_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_dbed2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_dbed3_d)
                  LET g_export_id[3]   = "s_detail3"
 
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
               NEXT FIELD dbed001
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
         ON ACTION auto_ins_dbeb
            LET g_action_choice="auto_ins_dbeb"
            IF cl_auth_chk_act("auto_ins_dbeb") THEN
               
               #add-point:ON ACTION auto_ins_dbeb name="menu.auto_ins_dbeb"
               IF adbt700_before_ins_dbeb() THEN               
                  CALL s_transaction_begin()
                  IF adbt700_auto_ins_dbeb() THEN
                     CALL adbt700_dbeb_amount(1) RETURNING l_success
                     CALL s_transaction_end('Y',0)
                  ELSE
                     CALL s_transaction_end('N',0)               
                  END IF
                  CALL adbt700_b_fill()
                  CALL adbt700_b_fill2('3')    
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL adbt700_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#7 -s by 08172
               CALL adbt700_set_act_visible()   
               CALL adbt700_set_act_no_visible()
               #160818-00017#7 -e by 08172 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adbt700_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #160818-00017#7 -s by 08172
               CALL adbt700_set_act_visible()   
               CALL adbt700_set_act_no_visible()
               #160818-00017#7 -e by 08172 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL adbt700_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#7 -s by 08172
               CALL adbt700_set_act_visible()   
               CALL adbt700_set_act_no_visible()
               #160818-00017#7 -e by 08172 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adbt700_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " dbeaent = '",g_enterprise,"' AND dbeadocno = '",g_dbea_m.dbeadocno,"' " #150107-00018#6 Add By Ken 150331
               #END add-point
               &include "erp/adb/adbt700_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " dbeaent = '",g_enterprise,"' AND dbeadocno = '",g_dbea_m.dbeadocno,"' " #150107-00018#6 Add By Ken 150331
               #END add-point
               &include "erp/adb/adbt700_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adbt700_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_aooi130
            LET g_action_choice="prog_aooi130"
            IF cl_auth_chk_act("prog_aooi130") THEN
               
               #add-point:ON ACTION prog_aooi130 name="menu.prog_aooi130"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_dbea_m.dbea002)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL adbt700_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adbt700_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adbt700_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_dbea_m.dbeadocdt)
 
 
 
         
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
 
{<section id="adbt700.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adbt700_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   CALL s_aooi500_sql_where(g_prog,'dbeasite') RETURNING l_where
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
      LET l_sub_sql = " SELECT DISTINCT dbeadocno ",
                      " FROM dbea_t ",
                      " ",
                      " LEFT JOIN dbed_t ON dbedent = dbeaent AND dbeadocno = dbeddocno ", "  ",
                      #add-point:browser_fill段sql(dbed_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN dbeb_t ON dbebent = dbeaent AND dbeadocno = dbebdocno", "  ",
                      #add-point:browser_fill段sql(dbeb_t1) name="browser_fill.cnt.join.dbeb_t1"
                      
                      #end add-point
 
 
                      " LEFT JOIN dbec_t ON dbecent = dbeaent AND dbebdocno = dbecdocno AND dbeb001 = dbec001", "  ",
                      #add-point:browser_fill段sql(dbec_t1) name="browser_fill.cnt.join.dbec_t1"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
                      " ",
 
 
                      " WHERE dbeaent = " ||g_enterprise|| " AND dbedent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("dbea_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT dbeadocno ",
                      " FROM dbea_t ", 
                      "  ",
                      "  ",
                      " WHERE dbeaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("dbea_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql," AND ", l_where
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
      INITIALIZE g_dbea_m.* TO NULL
      CALL g_dbed_d.clear()        
      CALL g_dbed2_d.clear() 
      CALL g_dbed3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.dbeasite,t0.dbeadocdt,t0.dbeadocno,t0.dbea001,t0.dbea002,t0.dbea003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.dbeastus,t0.dbeasite,t0.dbeadocdt,t0.dbeadocno,t0.dbea001,t0.dbea002, 
          t0.dbea003,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM dbea_t t0",
                  "  ",
                  "  LEFT JOIN dbed_t ON dbedent = dbeaent AND dbeadocno = dbeddocno ", "  ", 
                  #add-point:browser_fill段sql(dbed_t1) name="browser_fill.join.dbed_t1"
                  
                  #end add-point
                  "  LEFT JOIN dbeb_t ON dbebent = dbeaent AND dbeadocno = dbebdocno", "  ", 
                  #add-point:browser_fill段sql(dbeb_t1) name="browser_fill.join.dbeb_t1"
                  
                  #end add-point
 
 
                  "  LEFT JOIN dbec_t ON dbecent = dbeaent AND dbebdocno = dbecdocno AND dbeb001 = dbec001", "  ", 
                  #add-point:browser_fill段sql(dbec_t1) name="browser_fill.join.dbec_t1"
                  
                  #end add-point
 
 
                  " ", 
                  " ",                      
 
 
                  " ",
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.dbeasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.dbea002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.dbea003 AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.dbeaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("dbea_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.dbeastus,t0.dbeasite,t0.dbeadocdt,t0.dbeadocno,t0.dbea001,t0.dbea002, 
          t0.dbea003,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM dbea_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.dbeasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.dbea002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.dbea003 AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.dbeaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("dbea_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql," AND ", l_where
   #end add-point
   LET g_sql = g_sql, " ORDER BY dbeadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"dbea_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_dbeasite,g_browser[g_cnt].b_dbeadocdt, 
          g_browser[g_cnt].b_dbeadocno,g_browser[g_cnt].b_dbea001,g_browser[g_cnt].b_dbea002,g_browser[g_cnt].b_dbea003, 
          g_browser[g_cnt].b_dbeasite_desc,g_browser[g_cnt].b_dbea002_desc,g_browser[g_cnt].b_dbea003_desc 
 
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
         CALL adbt700_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_dbeadocno) THEN
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
 
{<section id="adbt700.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION adbt700_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_dbea_m.dbeadocno = g_browser[g_current_idx].b_dbeadocno   
 
   EXECUTE adbt700_master_referesh USING g_dbea_m.dbeadocno INTO g_dbea_m.dbeasite,g_dbea_m.dbeadocdt, 
       g_dbea_m.dbeadocno,g_dbea_m.dbeaunit,g_dbea_m.dbea001,g_dbea_m.dbea002,g_dbea_m.dbea003,g_dbea_m.dbeastus, 
       g_dbea_m.dbeaownid,g_dbea_m.dbeaowndp,g_dbea_m.dbeacrtid,g_dbea_m.dbeacrtdp,g_dbea_m.dbeacrtdt, 
       g_dbea_m.dbeamodid,g_dbea_m.dbeamoddt,g_dbea_m.dbeacnfid,g_dbea_m.dbeacnfdt,g_dbea_m.dbeasite_desc, 
       g_dbea_m.dbea002_desc,g_dbea_m.dbea003_desc,g_dbea_m.dbeaownid_desc,g_dbea_m.dbeaowndp_desc,g_dbea_m.dbeacrtid_desc, 
       g_dbea_m.dbeacrtdp_desc,g_dbea_m.dbeamodid_desc,g_dbea_m.dbeacnfid_desc
   
   CALL adbt700_dbea_t_mask()
   CALL adbt700_show()
      
END FUNCTION
 
{</section>}
 
{<section id="adbt700.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION adbt700_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adbt700_ui_browser_refresh()
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
      IF g_browser[l_i].b_dbeadocno = g_dbea_m.dbeadocno 
 
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
 
{<section id="adbt700.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION adbt700_construct()
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
   INITIALIZE g_dbea_m.* TO NULL
   CALL g_dbed_d.clear()        
   CALL g_dbed2_d.clear() 
   CALL g_dbed3_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON dbeasite,dbeadocdt,dbeadocno,dbeaunit,dbea001,dbea002,dbea003,dbeastus, 
          dbeaownid,dbeaowndp,dbeacrtid,dbeacrtdp,dbeacrtdt,dbeamodid,dbeamoddt,dbeacnfid,dbeacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<dbeacrtdt>>----
         AFTER FIELD dbeacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<dbeamoddt>>----
         AFTER FIELD dbeamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbeacnfdt>>----
         AFTER FIELD dbeacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbeapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.dbeasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeasite
            #add-point:ON ACTION controlp INFIELD dbeasite name="construct.c.dbeasite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'dbeasite',g_dbea_m.dbeasite,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeasite  #顯示到畫面上
            NEXT FIELD dbeasite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeasite
            #add-point:BEFORE FIELD dbeasite name="construct.b.dbeasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeasite
            
            #add-point:AFTER FIELD dbeasite name="construct.a.dbeasite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeadocdt
            #add-point:BEFORE FIELD dbeadocdt name="construct.b.dbeadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeadocdt
            
            #add-point:AFTER FIELD dbeadocdt name="construct.a.dbeadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbeadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeadocdt
            #add-point:ON ACTION controlp INFIELD dbeadocdt name="construct.c.dbeadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.dbeadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeadocno
            #add-point:ON ACTION controlp INFIELD dbeadocno name="construct.c.dbeadocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbeadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeadocno  #顯示到畫面上
            NEXT FIELD dbeadocno                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeadocno
            #add-point:BEFORE FIELD dbeadocno name="construct.b.dbeadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeadocno
            
            #add-point:AFTER FIELD dbeadocno name="construct.a.dbeadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbeaunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeaunit
            #add-point:ON ACTION controlp INFIELD dbeaunit name="construct.c.dbeaunit"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'dbeaunit',g_dbea_m.dbeasite,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO dbeaunit  #顯示到畫面上
            NEXT FIELD dbeaunit 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeaunit
            #add-point:BEFORE FIELD dbeaunit name="construct.b.dbeaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeaunit
            
            #add-point:AFTER FIELD dbeaunit name="construct.a.dbeaunit"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbea001
            #add-point:BEFORE FIELD dbea001 name="construct.b.dbea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbea001
            
            #add-point:AFTER FIELD dbea001 name="construct.a.dbea001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbea001
            #add-point:ON ACTION controlp INFIELD dbea001 name="construct.c.dbea001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.dbea002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbea002
            #add-point:ON ACTION controlp INFIELD dbea002 name="construct.c.dbea002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbea002  #顯示到畫面上
            NEXT FIELD dbea002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbea002
            #add-point:BEFORE FIELD dbea002 name="construct.b.dbea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbea002
            
            #add-point:AFTER FIELD dbea002 name="construct.a.dbea002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbea003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbea003
            #add-point:ON ACTION controlp INFIELD dbea003 name="construct.c.dbea003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbea003  #顯示到畫面上
            NEXT FIELD dbea003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbea003
            #add-point:BEFORE FIELD dbea003 name="construct.b.dbea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbea003
            
            #add-point:AFTER FIELD dbea003 name="construct.a.dbea003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeastus
            #add-point:BEFORE FIELD dbeastus name="construct.b.dbeastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeastus
            
            #add-point:AFTER FIELD dbeastus name="construct.a.dbeastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbeastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeastus
            #add-point:ON ACTION controlp INFIELD dbeastus name="construct.c.dbeastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.dbeaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeaownid
            #add-point:ON ACTION controlp INFIELD dbeaownid name="construct.c.dbeaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeaownid  #顯示到畫面上
            NEXT FIELD dbeaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeaownid
            #add-point:BEFORE FIELD dbeaownid name="construct.b.dbeaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeaownid
            
            #add-point:AFTER FIELD dbeaownid name="construct.a.dbeaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbeaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeaowndp
            #add-point:ON ACTION controlp INFIELD dbeaowndp name="construct.c.dbeaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeaowndp  #顯示到畫面上
            NEXT FIELD dbeaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeaowndp
            #add-point:BEFORE FIELD dbeaowndp name="construct.b.dbeaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeaowndp
            
            #add-point:AFTER FIELD dbeaowndp name="construct.a.dbeaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbeacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeacrtid
            #add-point:ON ACTION controlp INFIELD dbeacrtid name="construct.c.dbeacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeacrtid  #顯示到畫面上
            NEXT FIELD dbeacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeacrtid
            #add-point:BEFORE FIELD dbeacrtid name="construct.b.dbeacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeacrtid
            
            #add-point:AFTER FIELD dbeacrtid name="construct.a.dbeacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbeacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeacrtdp
            #add-point:ON ACTION controlp INFIELD dbeacrtdp name="construct.c.dbeacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeacrtdp  #顯示到畫面上
            NEXT FIELD dbeacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeacrtdp
            #add-point:BEFORE FIELD dbeacrtdp name="construct.b.dbeacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeacrtdp
            
            #add-point:AFTER FIELD dbeacrtdp name="construct.a.dbeacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeacrtdt
            #add-point:BEFORE FIELD dbeacrtdt name="construct.b.dbeacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.dbeamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeamodid
            #add-point:ON ACTION controlp INFIELD dbeamodid name="construct.c.dbeamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeamodid  #顯示到畫面上
            NEXT FIELD dbeamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeamodid
            #add-point:BEFORE FIELD dbeamodid name="construct.b.dbeamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeamodid
            
            #add-point:AFTER FIELD dbeamodid name="construct.a.dbeamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeamoddt
            #add-point:BEFORE FIELD dbeamoddt name="construct.b.dbeamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.dbeacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeacnfid
            #add-point:ON ACTION controlp INFIELD dbeacnfid name="construct.c.dbeacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeacnfid  #顯示到畫面上
            NEXT FIELD dbeacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeacnfid
            #add-point:BEFORE FIELD dbeacnfid name="construct.b.dbeacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeacnfid
            
            #add-point:AFTER FIELD dbeacnfid name="construct.a.dbeacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeacnfdt
            #add-point:BEFORE FIELD dbeacnfdt name="construct.b.dbeacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON dbed001,dbedsite,dbedunit
           FROM s_detail1[1].dbed001,s_detail1[1].dbedsite,s_detail1[1].dbedunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.dbed001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbed001
            #add-point:ON ACTION controlp INFIELD dbed001 name="construct.c.page1.dbed001"
            #此段落由子樣板a08產生
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #開窗c段
            IF s_aooi500_setpoint(g_prog,'dbed001') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'dbed001',g_dbea_m.dbeasite,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()                     #呼叫開窗
            ELSE   
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = '11'
               CALL q_ooed004()
            END IF
            DISPLAY g_qryparam.return1 TO dbeasite  #顯示到畫面上
            NEXT FIELD dbeasite                     #返回原欄位            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbed001
            #add-point:BEFORE FIELD dbed001 name="construct.b.page1.dbed001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbed001
            
            #add-point:AFTER FIELD dbed001 name="construct.a.page1.dbed001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbedsite
            #add-point:BEFORE FIELD dbedsite name="construct.b.page1.dbedsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbedsite
            
            #add-point:AFTER FIELD dbedsite name="construct.a.page1.dbedsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbedsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbedsite
            #add-point:ON ACTION controlp INFIELD dbedsite name="construct.c.page1.dbedsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbedunit
            #add-point:BEFORE FIELD dbedunit name="construct.b.page1.dbedunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbedunit
            
            #add-point:AFTER FIELD dbedunit name="construct.a.page1.dbedunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbedunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbedunit
            #add-point:ON ACTION controlp INFIELD dbedunit name="construct.c.page1.dbedunit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON dbeb001,dbeb002,dbeb003,dbeb004,dbeb005,dbeb006,dbeb007,dbeb008,dbebsite, 
          dbebunit
           FROM s_detail2[1].dbeb001,s_detail2[1].dbeb002,s_detail2[1].dbeb003,s_detail2[1].dbeb004, 
               s_detail2[1].dbeb005,s_detail2[1].dbeb006,s_detail2[1].dbeb007,s_detail2[1].dbeb008,s_detail2[1].dbebsite, 
               s_detail2[1].dbebunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page2.dbeb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeb001
            #add-point:ON ACTION controlp INFIELD dbeb001 name="construct.c.page2.dbeb001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeb001  #顯示到畫面上
            NEXT FIELD dbeb001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeb001
            #add-point:BEFORE FIELD dbeb001 name="construct.b.page2.dbeb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeb001
            
            #add-point:AFTER FIELD dbeb001 name="construct.a.page2.dbeb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbeb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeb002
            #add-point:ON ACTION controlp INFIELD dbeb002 name="construct.c.page2.dbeb002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeb002  #顯示到畫面上
            NEXT FIELD dbeb002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeb002
            #add-point:BEFORE FIELD dbeb002 name="construct.b.page2.dbeb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeb002
            
            #add-point:AFTER FIELD dbeb002 name="construct.a.page2.dbeb002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeb003
            #add-point:BEFORE FIELD dbeb003 name="construct.b.page2.dbeb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeb003
            
            #add-point:AFTER FIELD dbeb003 name="construct.a.page2.dbeb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbeb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeb003
            #add-point:ON ACTION controlp INFIELD dbeb003 name="construct.c.page2.dbeb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeb004
            #add-point:BEFORE FIELD dbeb004 name="construct.b.page2.dbeb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeb004
            
            #add-point:AFTER FIELD dbeb004 name="construct.a.page2.dbeb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbeb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeb004
            #add-point:ON ACTION controlp INFIELD dbeb004 name="construct.c.page2.dbeb004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.dbeb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeb005
            #add-point:ON ACTION controlp INFIELD dbeb005 name="construct.c.page2.dbeb005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeb005  #顯示到畫面上
            NEXT FIELD dbeb005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeb005
            #add-point:BEFORE FIELD dbeb005 name="construct.b.page2.dbeb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeb005
            
            #add-point:AFTER FIELD dbeb005 name="construct.a.page2.dbeb005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeb006
            #add-point:BEFORE FIELD dbeb006 name="construct.b.page2.dbeb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeb006
            
            #add-point:AFTER FIELD dbeb006 name="construct.a.page2.dbeb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbeb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeb006
            #add-point:ON ACTION controlp INFIELD dbeb006 name="construct.c.page2.dbeb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeb007
            #add-point:BEFORE FIELD dbeb007 name="construct.b.page2.dbeb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeb007
            
            #add-point:AFTER FIELD dbeb007 name="construct.a.page2.dbeb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbeb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeb007
            #add-point:ON ACTION controlp INFIELD dbeb007 name="construct.c.page2.dbeb007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.dbeb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeb008
            #add-point:ON ACTION controlp INFIELD dbeb008 name="construct.c.page2.dbeb008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeb008  #顯示到畫面上
            NEXT FIELD dbeb008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeb008
            #add-point:BEFORE FIELD dbeb008 name="construct.b.page2.dbeb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeb008
            
            #add-point:AFTER FIELD dbeb008 name="construct.a.page2.dbeb008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbebsite
            #add-point:BEFORE FIELD dbebsite name="construct.b.page2.dbebsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbebsite
            
            #add-point:AFTER FIELD dbebsite name="construct.a.page2.dbebsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbebsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbebsite
            #add-point:ON ACTION controlp INFIELD dbebsite name="construct.c.page2.dbebsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbebunit
            #add-point:BEFORE FIELD dbebunit name="construct.b.page2.dbebunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbebunit
            
            #add-point:AFTER FIELD dbebunit name="construct.a.page2.dbebunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbebunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbebunit
            #add-point:ON ACTION controlp INFIELD dbebunit name="construct.c.page2.dbebunit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
      CONSTRUCT g_wc2_table3 ON dbec002,dbec003,dbec004,dbec005,dbec006,dbec007,dbec008,dbec009,dbec010, 
          dbec011,dbec012,dbec013,dbec014,dbec015,dbecsite,dbecunit
           FROM s_detail3[1].dbec002,s_detail3[1].dbec003,s_detail3[1].dbec004,s_detail3[1].dbec005, 
               s_detail3[1].dbec006,s_detail3[1].dbec007,s_detail3[1].dbec008,s_detail3[1].dbec009,s_detail3[1].dbec010, 
               s_detail3[1].dbec011,s_detail3[1].dbec012,s_detail3[1].dbec013,s_detail3[1].dbec014,s_detail3[1].dbec015, 
               s_detail3[1].dbecsite,s_detail3[1].dbecunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page3.dbec002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec002
            #add-point:ON ACTION controlp INFIELD dbec002 name="construct.c.page3.dbec002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbec002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbec002  #顯示到畫面上
            NEXT FIELD dbec002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec002
            #add-point:BEFORE FIELD dbec002 name="construct.b.page3.dbec002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec002
            
            #add-point:AFTER FIELD dbec002 name="construct.a.page3.dbec002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbec003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec003
            #add-point:ON ACTION controlp INFIELD dbec003 name="construct.c.page3.dbec003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_mrba001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbec003  #顯示到畫面上
            NEXT FIELD dbec003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec003
            #add-point:BEFORE FIELD dbec003 name="construct.b.page3.dbec003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec003
            
            #add-point:AFTER FIELD dbec003 name="construct.a.page3.dbec003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbec004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec004
            #add-point:ON ACTION controlp INFIELD dbec004 name="construct.c.page3.dbec004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrba061()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbec004  #顯示到畫面上
            NEXT FIELD dbec004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec004
            #add-point:BEFORE FIELD dbec004 name="construct.b.page3.dbec004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec004
            
            #add-point:AFTER FIELD dbec004 name="construct.a.page3.dbec004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec005
            #add-point:BEFORE FIELD dbec005 name="construct.b.page3.dbec005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec005
            
            #add-point:AFTER FIELD dbec005 name="construct.a.page3.dbec005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbec005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec005
            #add-point:ON ACTION controlp INFIELD dbec005 name="construct.c.page3.dbec005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec006
            #add-point:BEFORE FIELD dbec006 name="construct.b.page3.dbec006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec006
            
            #add-point:AFTER FIELD dbec006 name="construct.a.page3.dbec006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbec006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec006
            #add-point:ON ACTION controlp INFIELD dbec006 name="construct.c.page3.dbec006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec007
            #add-point:BEFORE FIELD dbec007 name="construct.b.page3.dbec007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec007
            
            #add-point:AFTER FIELD dbec007 name="construct.a.page3.dbec007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbec007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec007
            #add-point:ON ACTION controlp INFIELD dbec007 name="construct.c.page3.dbec007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec008
            #add-point:BEFORE FIELD dbec008 name="construct.b.page3.dbec008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec008
            
            #add-point:AFTER FIELD dbec008 name="construct.a.page3.dbec008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbec008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec008
            #add-point:ON ACTION controlp INFIELD dbec008 name="construct.c.page3.dbec008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec009
            #add-point:BEFORE FIELD dbec009 name="construct.b.page3.dbec009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec009
            
            #add-point:AFTER FIELD dbec009 name="construct.a.page3.dbec009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbec009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec009
            #add-point:ON ACTION controlp INFIELD dbec009 name="construct.c.page3.dbec009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec010
            #add-point:BEFORE FIELD dbec010 name="construct.b.page3.dbec010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec010
            
            #add-point:AFTER FIELD dbec010 name="construct.a.page3.dbec010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbec010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec010
            #add-point:ON ACTION controlp INFIELD dbec010 name="construct.c.page3.dbec010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec011
            #add-point:BEFORE FIELD dbec011 name="construct.b.page3.dbec011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec011
            
            #add-point:AFTER FIELD dbec011 name="construct.a.page3.dbec011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbec011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec011
            #add-point:ON ACTION controlp INFIELD dbec011 name="construct.c.page3.dbec011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec012
            #add-point:BEFORE FIELD dbec012 name="construct.b.page3.dbec012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec012
            
            #add-point:AFTER FIELD dbec012 name="construct.a.page3.dbec012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbec012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec012
            #add-point:ON ACTION controlp INFIELD dbec012 name="construct.c.page3.dbec012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec013
            #add-point:BEFORE FIELD dbec013 name="construct.b.page3.dbec013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec013
            
            #add-point:AFTER FIELD dbec013 name="construct.a.page3.dbec013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbec013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec013
            #add-point:ON ACTION controlp INFIELD dbec013 name="construct.c.page3.dbec013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.dbec014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec014
            #add-point:ON ACTION controlp INFIELD dbec014 name="construct.c.page3.dbec014"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbec002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbec014  #顯示到畫面上
            NEXT FIELD dbec014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec014
            #add-point:BEFORE FIELD dbec014 name="construct.b.page3.dbec014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec014
            
            #add-point:AFTER FIELD dbec014 name="construct.a.page3.dbec014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec015
            #add-point:BEFORE FIELD dbec015 name="construct.b.page3.dbec015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec015
            
            #add-point:AFTER FIELD dbec015 name="construct.a.page3.dbec015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbec015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec015
            #add-point:ON ACTION controlp INFIELD dbec015 name="construct.c.page3.dbec015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbecsite
            #add-point:BEFORE FIELD dbecsite name="construct.b.page3.dbecsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbecsite
            
            #add-point:AFTER FIELD dbecsite name="construct.a.page3.dbecsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbecsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbecsite
            #add-point:ON ACTION controlp INFIELD dbecsite name="construct.c.page3.dbecsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbecunit
            #add-point:BEFORE FIELD dbecunit name="construct.b.page3.dbecunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbecunit
            
            #add-point:AFTER FIELD dbecunit name="construct.a.page3.dbecunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbecunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbecunit
            #add-point:ON ACTION controlp INFIELD dbecunit name="construct.c.page3.dbecunit"
            
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
            INITIALIZE g_wc2_table2 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "dbea_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "dbed_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "dbeb_t" 
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
 
{<section id="adbt700.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION adbt700_filter()
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
      CONSTRUCT g_wc_filter ON dbeasite,dbeadocdt,dbeadocno,dbea001,dbea002,dbea003
                          FROM s_browse[1].b_dbeasite,s_browse[1].b_dbeadocdt,s_browse[1].b_dbeadocno, 
                              s_browse[1].b_dbea001,s_browse[1].b_dbea002,s_browse[1].b_dbea003
 
         BEFORE CONSTRUCT
               DISPLAY adbt700_filter_parser('dbeasite') TO s_browse[1].b_dbeasite
            DISPLAY adbt700_filter_parser('dbeadocdt') TO s_browse[1].b_dbeadocdt
            DISPLAY adbt700_filter_parser('dbeadocno') TO s_browse[1].b_dbeadocno
            DISPLAY adbt700_filter_parser('dbea001') TO s_browse[1].b_dbea001
            DISPLAY adbt700_filter_parser('dbea002') TO s_browse[1].b_dbea002
            DISPLAY adbt700_filter_parser('dbea003') TO s_browse[1].b_dbea003
      
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
 
      CALL adbt700_filter_show('dbeasite')
   CALL adbt700_filter_show('dbeadocdt')
   CALL adbt700_filter_show('dbeadocno')
   CALL adbt700_filter_show('dbea001')
   CALL adbt700_filter_show('dbea002')
   CALL adbt700_filter_show('dbea003')
 
END FUNCTION
 
{</section>}
 
{<section id="adbt700.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION adbt700_filter_parser(ps_field)
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
 
{<section id="adbt700.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION adbt700_filter_show(ps_field)
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
   LET ls_condition = adbt700_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adbt700.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adbt700_query()
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
   CALL g_dbed_d.clear()
   CALL g_dbed2_d.clear()
   CALL g_dbed3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL adbt700_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL adbt700_browser_fill("")
      CALL adbt700_fetch("")
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
      CALL adbt700_filter_show('dbeasite')
   CALL adbt700_filter_show('dbeadocdt')
   CALL adbt700_filter_show('dbeadocno')
   CALL adbt700_filter_show('dbea001')
   CALL adbt700_filter_show('dbea002')
   CALL adbt700_filter_show('dbea003')
   CALL adbt700_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL adbt700_fetch("F") 
      #顯示單身筆數
      CALL adbt700_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adbt700.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adbt700_fetch(p_flag)
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
   CALL g_dbed3_d.clear()
 
   
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
   
   LET g_dbea_m.dbeadocno = g_browser[g_current_idx].b_dbeadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE adbt700_master_referesh USING g_dbea_m.dbeadocno INTO g_dbea_m.dbeasite,g_dbea_m.dbeadocdt, 
       g_dbea_m.dbeadocno,g_dbea_m.dbeaunit,g_dbea_m.dbea001,g_dbea_m.dbea002,g_dbea_m.dbea003,g_dbea_m.dbeastus, 
       g_dbea_m.dbeaownid,g_dbea_m.dbeaowndp,g_dbea_m.dbeacrtid,g_dbea_m.dbeacrtdp,g_dbea_m.dbeacrtdt, 
       g_dbea_m.dbeamodid,g_dbea_m.dbeamoddt,g_dbea_m.dbeacnfid,g_dbea_m.dbeacnfdt,g_dbea_m.dbeasite_desc, 
       g_dbea_m.dbea002_desc,g_dbea_m.dbea003_desc,g_dbea_m.dbeaownid_desc,g_dbea_m.dbeaowndp_desc,g_dbea_m.dbeacrtid_desc, 
       g_dbea_m.dbeacrtdp_desc,g_dbea_m.dbeamodid_desc,g_dbea_m.dbeacnfid_desc
   
   #遮罩相關處理
   LET g_dbea_m_mask_o.* =  g_dbea_m.*
   CALL adbt700_dbea_t_mask()
   LET g_dbea_m_mask_n.* =  g_dbea_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adbt700_set_act_visible()   
   CALL adbt700_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
   CALL cl_set_act_visible("auto_ins_dbeb",TRUE)
   
   CASE g_dbea_m.dbeastus
      WHEN 'Y'
         CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
         CALL cl_set_act_visible("auto_ins_dbeb",FALSE)
      WHEN 'X'
         CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
         CALL cl_set_act_visible("auto_ins_dbeb",FALSE)      
   END CASE
   #end add-point
   
   #保存單頭舊值
   LET g_dbea_m_t.* = g_dbea_m.*
   LET g_dbea_m_o.* = g_dbea_m.*
   
   LET g_data_owner = g_dbea_m.dbeaownid      
   LET g_data_dept  = g_dbea_m.dbeaowndp
   
   #重新顯示   
   CALL adbt700_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="adbt700.insert" >}
#+ 資料新增
PRIVATE FUNCTION adbt700_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_dbed_d.clear()   
   CALL g_dbed2_d.clear()  
   CALL g_dbed3_d.clear()  
 
 
   INITIALIZE g_dbea_m.* TO NULL             #DEFAULT 設定
   
   LET g_dbeadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_dbea_m.dbeaownid = g_user
      LET g_dbea_m.dbeaowndp = g_dept
      LET g_dbea_m.dbeacrtid = g_user
      LET g_dbea_m.dbeacrtdp = g_dept 
      LET g_dbea_m.dbeacrtdt = cl_get_current()
      LET g_dbea_m.dbeamodid = g_user
      LET g_dbea_m.dbeamoddt = cl_get_current()
      LET g_dbea_m.dbeastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      CALL s_aooi500_default(g_prog,'dbeasite',g_dbea_m.dbeasite)
         RETURNING l_insert,g_dbea_m.dbeasite
      IF l_insert = FALSE THEN
         RETURN
      END IF
      #CALL s_aooi500_default(g_prog,'dbeeunit',g_dbee_m.dbeesite)
      #   RETURNING l_insert,g_dbee_m.dbeeunit
      #IF l_insert = FALSE THEN
      #   RETURN
      #END IF
      LET g_dbea_m.dbeasite_desc = s_desc_get_department_desc(g_dbea_m.dbeasite)
      LET g_dbea_m.dbeadocdt     = g_today
      LET g_dbea_m.dbea001    = g_today
      IF NOT adbt700_org_and_date_rep_chk(1,'a',g_dbea_m.dbeasite,FALSE) THEN
         LET g_dbea_m.dbea001    = NULL
      END IF
      LET g_dbea_m.dbea002       = g_user
      LET g_dbea_m.dbea002_desc  = s_desc_get_person_desc(g_dbea_m.dbea002)
      CALL adbt700_dbea003_default()
      
      CALL s_arti200_get_def_doc_type(g_site,g_prog,'1')
         RETURNING l_success,g_dbea_m.dbeadocno

      #for 單據別開窗時可以在 營運中心切換時，開出正確的資料
      LET g_ooef004 = ''
      SELECT ooef004 INTO g_ooef004 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      IF cl_null(g_ooef004) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00007'
         LET g_errparam.extend = g_site
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_dbea_m_t.* = g_dbea_m.*
      LET g_dbea_m_o.* = g_dbea_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_dbea_m.dbeastus 
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
 
 
 
    
      CALL adbt700_input("a")
      
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
         INITIALIZE g_dbea_m.* TO NULL
         INITIALIZE g_dbed_d TO NULL
         INITIALIZE g_dbed2_d TO NULL
         INITIALIZE g_dbed3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL adbt700_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_dbed_d.clear()
      #CALL g_dbed2_d.clear()
      #CALL g_dbed3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adbt700_set_act_visible()   
   CALL adbt700_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_dbeadocno_t = g_dbea_m.dbeadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " dbeaent = " ||g_enterprise|| " AND",
                      " dbeadocno = '", g_dbea_m.dbeadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adbt700_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE adbt700_cl
   
   CALL adbt700_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE adbt700_master_referesh USING g_dbea_m.dbeadocno INTO g_dbea_m.dbeasite,g_dbea_m.dbeadocdt, 
       g_dbea_m.dbeadocno,g_dbea_m.dbeaunit,g_dbea_m.dbea001,g_dbea_m.dbea002,g_dbea_m.dbea003,g_dbea_m.dbeastus, 
       g_dbea_m.dbeaownid,g_dbea_m.dbeaowndp,g_dbea_m.dbeacrtid,g_dbea_m.dbeacrtdp,g_dbea_m.dbeacrtdt, 
       g_dbea_m.dbeamodid,g_dbea_m.dbeamoddt,g_dbea_m.dbeacnfid,g_dbea_m.dbeacnfdt,g_dbea_m.dbeasite_desc, 
       g_dbea_m.dbea002_desc,g_dbea_m.dbea003_desc,g_dbea_m.dbeaownid_desc,g_dbea_m.dbeaowndp_desc,g_dbea_m.dbeacrtid_desc, 
       g_dbea_m.dbeacrtdp_desc,g_dbea_m.dbeamodid_desc,g_dbea_m.dbeacnfid_desc
   
   
   #遮罩相關處理
   LET g_dbea_m_mask_o.* =  g_dbea_m.*
   CALL adbt700_dbea_t_mask()
   LET g_dbea_m_mask_n.* =  g_dbea_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_dbea_m.dbeasite,g_dbea_m.dbeasite_desc,g_dbea_m.dbeadocdt,g_dbea_m.dbeadocno,g_dbea_m.dbeaunit, 
       g_dbea_m.dbea001,g_dbea_m.dbea002,g_dbea_m.dbea002_desc,g_dbea_m.dbea003,g_dbea_m.dbea003_desc, 
       g_dbea_m.dbeastus,g_dbea_m.dbeaownid,g_dbea_m.dbeaownid_desc,g_dbea_m.dbeaowndp,g_dbea_m.dbeaowndp_desc, 
       g_dbea_m.dbeacrtid,g_dbea_m.dbeacrtid_desc,g_dbea_m.dbeacrtdp,g_dbea_m.dbeacrtdp_desc,g_dbea_m.dbeacrtdt, 
       g_dbea_m.dbeamodid,g_dbea_m.dbeamodid_desc,g_dbea_m.dbeamoddt,g_dbea_m.dbeacnfid,g_dbea_m.dbeacnfid_desc, 
       g_dbea_m.dbeacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_dbea_m.dbeaownid      
   LET g_data_dept  = g_dbea_m.dbeaowndp
   
   #功能已完成,通報訊息中心
   CALL adbt700_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.modify" >}
#+ 資料修改
PRIVATE FUNCTION adbt700_modify()
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
   LET g_dbea_m_t.* = g_dbea_m.*
   LET g_dbea_m_o.* = g_dbea_m.*
   
   IF g_dbea_m.dbeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_dbeadocno_t = g_dbea_m.dbeadocno
 
   CALL s_transaction_begin()
   
   OPEN adbt700_cl USING g_enterprise,g_dbea_m.dbeadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adbt700_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adbt700_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adbt700_master_referesh USING g_dbea_m.dbeadocno INTO g_dbea_m.dbeasite,g_dbea_m.dbeadocdt, 
       g_dbea_m.dbeadocno,g_dbea_m.dbeaunit,g_dbea_m.dbea001,g_dbea_m.dbea002,g_dbea_m.dbea003,g_dbea_m.dbeastus, 
       g_dbea_m.dbeaownid,g_dbea_m.dbeaowndp,g_dbea_m.dbeacrtid,g_dbea_m.dbeacrtdp,g_dbea_m.dbeacrtdt, 
       g_dbea_m.dbeamodid,g_dbea_m.dbeamoddt,g_dbea_m.dbeacnfid,g_dbea_m.dbeacnfdt,g_dbea_m.dbeasite_desc, 
       g_dbea_m.dbea002_desc,g_dbea_m.dbea003_desc,g_dbea_m.dbeaownid_desc,g_dbea_m.dbeaowndp_desc,g_dbea_m.dbeacrtid_desc, 
       g_dbea_m.dbeacrtdp_desc,g_dbea_m.dbeamodid_desc,g_dbea_m.dbeacnfid_desc
   
   #檢查是否允許此動作
   IF NOT adbt700_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_dbea_m_mask_o.* =  g_dbea_m.*
   CALL adbt700_dbea_t_mask()
   LET g_dbea_m_mask_n.* =  g_dbea_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
   
   CALL adbt700_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
    
   WHILE TRUE
      LET g_dbeadocno_t = g_dbea_m.dbeadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_dbea_m.dbeamodid = g_user 
LET g_dbea_m.dbeamoddt = cl_get_current()
LET g_dbea_m.dbeamodid_desc = cl_get_username(g_dbea_m.dbeamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_dbea_m.dbeastus MATCHES "[DR]" THEN
         LET g_dbea_m.dbeastus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL adbt700_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE dbea_t SET (dbeamodid,dbeamoddt) = (g_dbea_m.dbeamodid,g_dbea_m.dbeamoddt)
          WHERE dbeaent = g_enterprise AND dbeadocno = g_dbeadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_dbea_m.* = g_dbea_m_t.*
            CALL adbt700_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_dbea_m.dbeadocno != g_dbea_m_t.dbeadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE dbed_t SET dbeddocno = g_dbea_m.dbeadocno
 
          WHERE dbedent = g_enterprise AND dbeddocno = g_dbea_m_t.dbeadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "dbed_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dbed_t:",SQLERRMESSAGE 
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
         
         UPDATE dbeb_t
            SET dbebdocno = g_dbea_m.dbeadocno
 
          WHERE dbebent = g_enterprise AND
                dbebdocno = g_dbeadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "dbeb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dbeb_t:",SQLERRMESSAGE 
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
         UPDATE dbec_t
            SET dbecdocno = g_dbea_m.dbeadocno
 
          WHERE dbecent = g_enterprise AND
                dbecdocno = g_dbeadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dbec_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dbec_t:",SQLERRMESSAGE 
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
   CALL adbt700_set_act_visible()   
   CALL adbt700_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " dbeaent = " ||g_enterprise|| " AND",
                      " dbeadocno = '", g_dbea_m.dbeadocno, "' "
 
   #填到對應位置
   CALL adbt700_browser_fill("")
 
   CLOSE adbt700_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adbt700_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="adbt700.input" >}
#+ 資料輸入
PRIVATE FUNCTION adbt700_input(p_cmd)
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
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_max_seq              LIKE dbec_t.dbec002   
   DEFINE l_fix_seq              LIKE type_t.chr10
   DEFINE l_seq                  STRING
   DEFINE l_wc                   STRING
   DEFINE l_errno                STRING
   DEFINE l_auto_flag            LIKE type_t.chr1       #單頭是新增時,給Y,便於進到單身編輯前先自動產生配送資訊
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
   DISPLAY BY NAME g_dbea_m.dbeasite,g_dbea_m.dbeasite_desc,g_dbea_m.dbeadocdt,g_dbea_m.dbeadocno,g_dbea_m.dbeaunit, 
       g_dbea_m.dbea001,g_dbea_m.dbea002,g_dbea_m.dbea002_desc,g_dbea_m.dbea003,g_dbea_m.dbea003_desc, 
       g_dbea_m.dbeastus,g_dbea_m.dbeaownid,g_dbea_m.dbeaownid_desc,g_dbea_m.dbeaowndp,g_dbea_m.dbeaowndp_desc, 
       g_dbea_m.dbeacrtid,g_dbea_m.dbeacrtid_desc,g_dbea_m.dbeacrtdp,g_dbea_m.dbeacrtdp_desc,g_dbea_m.dbeacrtdt, 
       g_dbea_m.dbeamodid,g_dbea_m.dbeamodid_desc,g_dbea_m.dbeamoddt,g_dbea_m.dbeacnfid,g_dbea_m.dbeacnfid_desc, 
       g_dbea_m.dbeacnfdt
   
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
   IF p_cmd = 'a' THEN
      LET l_auto_flag = 'Y'
   END IF
   #end add-point 
   LET g_forupd_sql = "SELECT dbed001,dbedsite,dbedunit FROM dbed_t WHERE dbedent=? AND dbeddocno=?  
       AND dbed001=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adbt700_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT dbeb001,dbeb002,dbeb003,dbeb004,dbeb005,dbeb006,dbeb007,dbeb008,dbebsite, 
       dbebunit FROM dbeb_t WHERE dbebent=? AND dbebdocno=? AND dbeb001=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adbt700_bcl2 CURSOR FROM g_forupd_sql
 
 
   
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point 
   LET g_forupd_sql = "SELECT dbec002,dbec003,dbec004,dbec005,dbec006,dbec007,dbec008,dbec009,dbec010, 
       dbec011,dbec012,dbec013,dbec014,dbec015,dbecsite,dbecunit FROM dbec_t WHERE dbecent=? AND dbecdocno=?  
       AND dbec001=? AND dbec002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adbt700_bcl3 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL adbt700_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL adbt700_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_dbea_m.dbeasite,g_dbea_m.dbeadocdt,g_dbea_m.dbeadocno,g_dbea_m.dbeaunit,g_dbea_m.dbea001, 
       g_dbea_m.dbea002,g_dbea_m.dbea003,g_dbea_m.dbeastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   DISPLAY BY NAME g_dbea_m.dbeasite_desc,g_dbea_m.dbea002_desc
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="adbt700.input.head" >}
      #單頭段
      INPUT BY NAME g_dbea_m.dbeasite,g_dbea_m.dbeadocdt,g_dbea_m.dbeadocno,g_dbea_m.dbeaunit,g_dbea_m.dbea001, 
          g_dbea_m.dbea002,g_dbea_m.dbea003,g_dbea_m.dbeastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION auto_ins_dbeb
            LET g_action_choice="auto_ins_dbeb"
            IF cl_auth_chk_act("auto_ins_dbeb") THEN
               
               #add-point:ON ACTION auto_ins_dbeb name="input.master_input.auto_ins_dbeb"
               IF adbt700_before_ins_dbeb() THEN               
                  CALL s_transaction_begin()
                  IF adbt700_auto_ins_dbeb() THEN
                     CALL adbt700_dbeb_amount(1) RETURNING l_success
                     CALL s_transaction_end('Y',0)
                  ELSE
                     CALL s_transaction_end('N',0)               
                  END IF
                  CALL adbt700_b_fill()
                  CALL adbt700_b_fill2('3')    
               END IF
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN adbt700_cl USING g_enterprise,g_dbea_m.dbeadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adbt700_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adbt700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL adbt700_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            LET g_ins_site_flag = ''
            LET g_ins_docno_flag = ''
            LET g_dbea_m_t.* = g_dbea_m.*
            
            CALL adbt700_set_entry(p_cmd)
            CALL adbt700_set_no_entry(p_cmd)
            NEXT FIELD dbeasite
            #end add-point
            CALL adbt700_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeasite
            
            #add-point:AFTER FIELD dbeasite name="input.a.dbeasite"
            LET g_dbea_m.dbeasite_desc = ' '
            DISPLAY BY NAME g_dbea_m.dbeasite_desc
            IF NOT cl_null(g_dbea_m.dbeasite) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbea_m.dbeasite != g_dbea_m_t.dbeasite OR g_dbea_m_t.dbeasite IS NULL )) THEN
                  IF NOT adbt700_dbeasite_chk(p_cmd) THEN
                     LET g_dbea_m.dbeasite = g_dbea_m_t.dbeasite
                     LET g_dbea_m.dbeasite_desc = s_desc_get_department_desc(g_dbea_m.dbeasite)
                     DISPLAY BY NAME g_dbea_m.dbeasite,g_dbea_m.dbeasite_desc
                     NEXT FIELD CURRENT
                  ELSE
                     LET g_ins_site_flag = 'Y'
                  END IF
               END IF
            END IF
            LET g_dbea_m.dbeasite_desc = s_desc_get_department_desc(g_dbea_m.dbeasite)
            DISPLAY BY NAME g_dbea_m.dbeasite,g_dbea_m.dbeasite_desc
            
            CALL adbt700_set_entry(p_cmd)
            CALL adbt700_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeasite
            #add-point:BEFORE FIELD dbeasite name="input.b.dbeasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbeasite
            #add-point:ON CHANGE dbeasite name="input.g.dbeasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeadocdt
            #add-point:BEFORE FIELD dbeadocdt name="input.b.dbeadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeadocdt
            
            #add-point:AFTER FIELD dbeadocdt name="input.a.dbeadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbeadocdt
            #add-point:ON CHANGE dbeadocdt name="input.g.dbeadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeadocno
            #add-point:BEFORE FIELD dbeadocno name="input.b.dbeadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeadocno
            
            #add-point:AFTER FIELD dbeadocno name="input.a.dbeadocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_dbea_m.dbeadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_dbea_m.dbeadocno != g_dbeadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbea_t WHERE "||"dbeaent = '" ||g_enterprise|| "' AND "||"dbeadocno = '"||g_dbea_m.dbeadocno ||"'",'std-00004',0) THEN 
                     LET g_dbea_m.dbeadocno = g_dbeadocno_t
                     NEXT FIELD CURRENT
                  ELSE
                     IF NOT s_aooi200_chk_slip(g_dbea_m.dbeasite,'',g_dbea_m.dbeadocno,g_prog) THEN
                        LET g_dbea_m.dbeadocno = g_dbeadocno_t
                        NEXT FIELD CURRENT
                     END IF                     
                  END IF
               END IF
            END IF
            
            CALL adbt700_set_entry(p_cmd)
            CALL adbt700_set_no_entry(p_cmd)            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbeadocno
            #add-point:ON CHANGE dbeadocno name="input.g.dbeadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeaunit
            #add-point:BEFORE FIELD dbeaunit name="input.b.dbeaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeaunit
            
            #add-point:AFTER FIELD dbeaunit name="input.a.dbeaunit"
            IF NOT cl_null(g_dbea_m.dbeaunit) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbea_m.dbeaunit != g_dbea_m_t.dbeaunit OR g_dbea_m_t.dbeaunit IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,'dbeaunit',g_dbea_m.dbeaunit,g_dbea_m.dbeasite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     LET g_dbea_m.dbeaunit = g_dbea_m_t.dbeaunit
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL adbt700_set_entry(p_cmd)
            CALL adbt700_set_no_entry(p_cmd)            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbeaunit
            #add-point:ON CHANGE dbeaunit name="input.g.dbeaunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbea001
            #add-point:BEFORE FIELD dbea001 name="input.b.dbea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbea001
            
            #add-point:AFTER FIELD dbea001 name="input.a.dbea001"
            IF NOT cl_null(g_dbea_m.dbea001) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbea_m.dbea001 != g_dbea_m_t.dbea001 OR g_dbea_m_t.dbea001 IS NULL )) THEN
                  IF NOT adbt700_org_and_date_rep_chk(1,p_cmd,g_dbea_m.dbeasite,TRUE) THEN
                     LET g_dbea_m.dbea001 = g_dbea_m_t.dbea001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbea001
            #add-point:ON CHANGE dbea001 name="input.g.dbea001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbea002
            
            #add-point:AFTER FIELD dbea002 name="input.a.dbea002"
            LET g_dbea_m.dbea002_desc = ' '
            DISPLAY BY NAME g_dbea_m.dbea002_desc
            IF NOT cl_null(g_dbea_m.dbea002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbea_m.dbea002 != g_dbea_m_t.dbea002 OR g_dbea_m_t.dbea002 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_dbea_m.dbea002
                  #160318-00025#24  by 07900 --add-str
                 LET g_errshow = TRUE #是否開窗                   
                 LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                 #160318-00025#24  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     LET g_dbea_m.dbea002 = g_dbea_m_t.dbea002
                     LET g_dbea_m.dbea002_desc = s_desc_get_person_desc(g_dbea_m.dbea002)
                     DISPLAY BY NAME g_dbea_m.dbea002,g_dbea_m.dbea002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_dbea_m.dbea002_desc = s_desc_get_person_desc(g_dbea_m.dbea002)
            DISPLAY BY NAME g_dbea_m.dbea002_desc
            CALL adbt700_dbea003_default()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbea002
            #add-point:BEFORE FIELD dbea002 name="input.b.dbea002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbea002
            #add-point:ON CHANGE dbea002 name="input.g.dbea002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbea003
            
            #add-point:AFTER FIELD dbea003 name="input.a.dbea003"
            LET g_dbea_m.dbea003_desc = ' '
            DISPLAY BY NAME g_dbea_m.dbea003_desc
            IF NOT cl_null(g_dbea_m.dbea003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbea_m.dbea003 != g_dbea_m_t.dbea003 OR g_dbea_m.dbea003 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_dbea_m.dbea003
                  LET g_chkparam.arg2 = g_today
                  #160318-00025#24  by 07900 --add-str
                 LET g_errshow = TRUE #是否開窗                   
                 LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                 #160318-00025#24  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_dbea_m.dbea003 = g_dbea_m_t.dbea003
                     LET g_dbea_m.dbea003_desc = s_desc_get_department_desc(g_dbea_m.dbea003)
                     DISPLAY BY NAME g_dbea_m.dbea003,g_dbea_m.dbea003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_dbea_m.dbea003_desc = s_desc_get_department_desc(g_dbea_m.dbea003)
            DISPLAY BY NAME g_dbea_m.dbea003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbea003
            #add-point:BEFORE FIELD dbea003 name="input.b.dbea003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbea003
            #add-point:ON CHANGE dbea003 name="input.g.dbea003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeastus
            #add-point:BEFORE FIELD dbeastus name="input.b.dbeastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeastus
            
            #add-point:AFTER FIELD dbeastus name="input.a.dbeastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbeastus
            #add-point:ON CHANGE dbeastus name="input.g.dbeastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.dbeasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeasite
            #add-point:ON ACTION controlp INFIELD dbeasite name="input.c.dbeasite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbea_m.dbeasite    #給予default值
            CALL s_aooi500_q_where(g_prog,'dbeasite',g_dbea_m.dbeasite,'i') #150308-00001#1  By Ken add 'i' 150309
               RETURNING l_wc
            LET g_qryparam.where = l_wc
            CALL q_ooef001_24()
            LET g_dbea_m.dbeasite = g_qryparam.return1              
            LET g_dbea_m.dbeasite_desc = s_desc_get_department_desc(g_dbea_m.dbeasite) 
            DISPLAY BY NAME g_dbea_m.dbeasite,g_dbea_m.dbeasite_desc
            NEXT FIELD dbeasite                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.dbeadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeadocdt
            #add-point:ON ACTION controlp INFIELD dbeadocdt name="input.c.dbeadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.dbeadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeadocno
            #add-point:ON ACTION controlp INFIELD dbeadocno name="input.c.dbeadocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbea_m.dbeadocno             #給予default值
            LET g_ooef004 = ''
            SELECT ooef004 INTO g_ooef004
              FROM ooef_t
             WHERE ooef001 = g_dbea_m.dbeasite
               AND ooefent = g_enterprise
               
            LET g_qryparam.arg1 = g_ooef004 #
            LET g_qryparam.arg2 = g_prog #
            
            CALL q_ooba002_1()             
            LET g_dbea_m.dbeadocno = g_qryparam.return1     
            DISPLAY g_dbea_m.dbeadocno TO dbeadocno            
            NEXT FIELD dbeadocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.dbeaunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeaunit
            #add-point:ON ACTION controlp INFIELD dbeaunit name="input.c.dbeaunit"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbea_m.dbeaunit     
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'dbeaunit',g_dbea_m.dbeasite,'i') #150308-00001#1  By Ken add 'i' 150309
            CALL q_ooef001_24()
            LET g_dbea_m.dbeaunit = g_qryparam.return1
            DISPLAY g_dbea_m.dbeaunit TO dbeaunit 
            NEXT FIELD dbeaunit 
            #END add-point
 
 
         #Ctrlp:input.c.dbea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbea001
            #add-point:ON ACTION controlp INFIELD dbea001 name="input.c.dbea001"
            
            #END add-point
 
 
         #Ctrlp:input.c.dbea002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbea002
            #add-point:ON ACTION controlp INFIELD dbea002 name="input.c.dbea002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbea_m.dbea002 
            CALL q_ooag001()          
            LET g_dbea_m.dbea002 = g_qryparam.return1  
            LET g_dbea_m.dbea002_desc = s_desc_get_person_desc(g_dbea_m.dbea002)
            DISPLAY BY NAME g_dbea_m.dbea002 ,g_dbea_m.dbea002_desc
            NEXT FIELD dbea002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.dbea003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbea003
            #add-point:ON ACTION controlp INFIELD dbea003 name="input.c.dbea003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            LET g_qryparam.default1 = g_dbea_m.dbea003        
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_dbea_m.dbea003 = g_qryparam.return1 
            LET g_dbea_m.dbea003_desc = s_desc_get_department_desc(g_dbea_m.dbea003)
            DISPLAY BY NAME g_dbea_m.dbea003,g_dbea_m.dbea003_desc            
            NEXT FIELD dbea003                       
            #END add-point
 
 
         #Ctrlp:input.c.dbeastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeastus
            #add-point:ON ACTION controlp INFIELD dbeastus name="input.c.dbeastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_dbea_m.dbeadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            LET g_dbea_m.dbeaunit = g_dbea_m.dbeasite
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_dbea_m.dbeasite,g_dbea_m.dbeadocno,g_dbea_m.dbeadocdt,g_prog)
               RETURNING l_success,g_dbea_m.dbeadocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_dbea_m.dbeadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD g_dbea_m.dbeadocno
                  CONTINUE DIALOG
               ELSE
                  LET g_ins_docno_flag = 'Y'
               END IF
               #end add-point
               
               INSERT INTO dbea_t (dbeaent,dbeasite,dbeadocdt,dbeadocno,dbeaunit,dbea001,dbea002,dbea003, 
                   dbeastus,dbeaownid,dbeaowndp,dbeacrtid,dbeacrtdp,dbeacrtdt,dbeamodid,dbeamoddt,dbeacnfid, 
                   dbeacnfdt)
               VALUES (g_enterprise,g_dbea_m.dbeasite,g_dbea_m.dbeadocdt,g_dbea_m.dbeadocno,g_dbea_m.dbeaunit, 
                   g_dbea_m.dbea001,g_dbea_m.dbea002,g_dbea_m.dbea003,g_dbea_m.dbeastus,g_dbea_m.dbeaownid, 
                   g_dbea_m.dbeaowndp,g_dbea_m.dbeacrtid,g_dbea_m.dbeacrtdp,g_dbea_m.dbeacrtdt,g_dbea_m.dbeamodid, 
                   g_dbea_m.dbeamoddt,g_dbea_m.dbeacnfid,g_dbea_m.dbeacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_dbea_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               LET g_dbeadocno_t = g_dbea_m.dbeadocno # 150226-00006#1 by ken 20150304
               IF l_cmd_t <> 'r' AND p_cmd = 'a' THEN
                  CALL s_transaction_end('Y','0')   #單頭資料先做Commit
                  LET p_cmd = 'u'
                  #提供自動開窗輸入發貨組織
                  CALL s_transaction_begin()
                  IF NOT adbt700_auto_ins_dbed(1,p_cmd) THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD dbed001
                     CONTINUE DIALOG 
                  ELSE
                     CALL adbt700_b_fill()
                     CALL s_transaction_end('Y','0')                      
                  END IF               
                  
                  CALL s_transaction_begin()
                  LET l_cnt = adbt700_dbed_cnt()                  
                  IF l_cnt = 0 THEN                      
                     CALL s_transaction_end('N','0')
                     NEXT FIELD dbed001
                  ELSE                         
                     CALL adbt700_auto_ins_dbeb() RETURNING l_success
                     IF NOT l_success THEN
                         CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     ELSE
                        LET g_master_insert = TRUE        #影響自動產生配送資料後, 排車不輸入按放棄時刷新畫面的結果, 標準要版有異動該變數值時應同步調整
                        CALL s_transaction_end('Y','0') 
                     END IF 
                     CALL adbt700_b_fill()
                     CALL adbt700_b_fill2('3')                     
                     NEXT FIELD dbeb001               
                  END IF
               END IF               
               CALL s_transaction_begin()               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL adbt700_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL adbt700_b_fill()
                  CALL adbt700_b_fill2('0')
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
               CALL adbt700_dbea_t_mask_restore('restore_mask_o')
               
               UPDATE dbea_t SET (dbeasite,dbeadocdt,dbeadocno,dbeaunit,dbea001,dbea002,dbea003,dbeastus, 
                   dbeaownid,dbeaowndp,dbeacrtid,dbeacrtdp,dbeacrtdt,dbeamodid,dbeamoddt,dbeacnfid,dbeacnfdt) = (g_dbea_m.dbeasite, 
                   g_dbea_m.dbeadocdt,g_dbea_m.dbeadocno,g_dbea_m.dbeaunit,g_dbea_m.dbea001,g_dbea_m.dbea002, 
                   g_dbea_m.dbea003,g_dbea_m.dbeastus,g_dbea_m.dbeaownid,g_dbea_m.dbeaowndp,g_dbea_m.dbeacrtid, 
                   g_dbea_m.dbeacrtdp,g_dbea_m.dbeacrtdt,g_dbea_m.dbeamodid,g_dbea_m.dbeamoddt,g_dbea_m.dbeacnfid, 
                   g_dbea_m.dbeacnfdt)
                WHERE dbeaent = g_enterprise AND dbeadocno = g_dbeadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "dbea_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL adbt700_dbea_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_dbea_m_t)
               LET g_log2 = util.JSON.stringify(g_dbea_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_dbeadocno_t = g_dbea_m.dbeadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="adbt700.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_dbed_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dbed_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adbt700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_dbed_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
 
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            #已有配送資訊時不可修改發貨組織
            IF g_dbed2_d.getLength() > 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'adb-00292'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD dbec003
            END IF
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
            OPEN adbt700_cl USING g_enterprise,g_dbea_m.dbeadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adbt700_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adbt700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_dbed_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_dbed_d[l_ac].dbed001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_dbed_d_t.* = g_dbed_d[l_ac].*  #BACKUP
               LET g_dbed_d_o.* = g_dbed_d[l_ac].*  #BACKUP
               CALL adbt700_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL adbt700_set_no_entry_b(l_cmd)
               IF NOT adbt700_lock_b("dbed_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbt700_bcl INTO g_dbed_d[l_ac].dbed001,g_dbed_d[l_ac].dbedsite,g_dbed_d[l_ac].dbedunit 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_dbed_d_t.dbed001,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_dbed_d_mask_o[l_ac].* =  g_dbed_d[l_ac].*
                  CALL adbt700_dbed_t_mask()
                  LET g_dbed_d_mask_n[l_ac].* =  g_dbed_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL adbt700_show()
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
            INITIALIZE g_dbed_d[l_ac].* TO NULL 
            INITIALIZE g_dbed_d_t.* TO NULL 
            INITIALIZE g_dbed_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_dbed_d[l_ac].dbedsite = g_dbea_m.dbeasite
            LET g_dbed_d[l_ac].dbedunit = g_dbea_m.dbeasite
            #end add-point
            LET g_dbed_d_t.* = g_dbed_d[l_ac].*     #新輸入資料
            LET g_dbed_d_o.* = g_dbed_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adbt700_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL adbt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dbed_d[li_reproduce_target].* = g_dbed_d[li_reproduce].*
 
               LET g_dbed_d[li_reproduce_target].dbed001 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM dbed_t 
             WHERE dbedent = g_enterprise AND dbeddocno = g_dbea_m.dbeadocno
 
               AND dbed001 = g_dbed_d[l_ac].dbed001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               LET  g_dbed_d[l_ac].dbedunit = g_dbed_d[l_ac].dbed001
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbea_m.dbeadocno
               LET gs_keys[2] = g_dbed_d[g_detail_idx].dbed001
               CALL adbt700_insert_b('dbed_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_dbed_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dbed_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adbt700_b_fill()
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
               LET gs_keys[01] = g_dbea_m.dbeadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_dbed_d_t.dbed001
 
            
               #刪除同層單身
               IF NOT adbt700_delete_b('dbed_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adbt700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT adbt700_key_delete_b(gs_keys,'dbed_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adbt700_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE adbt700_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_dbed_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_dbed_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbed001
            
            #add-point:AFTER FIELD dbed001 name="input.a.page1.dbed001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_dbea_m.dbeadocno IS NOT NULL AND g_dbed_d[g_detail_idx].dbed001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dbea_m.dbeadocno != g_dbeadocno_t OR g_dbed_d[g_detail_idx].dbed001 != g_dbed_d_t.dbed001 OR g_dbed_d_t.dbed001 IS NULL )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbed_t WHERE "||"dbedent = '" ||g_enterprise|| "' AND "||"dbeddocno = '"||g_dbea_m.dbeadocno ||"' AND "|| "dbed001 = '"||g_dbed_d[g_detail_idx].dbed001 ||"'",'std-00004',0) THEN 
                     LET g_dbed_d[l_ac].dbed001 = g_dbed_d_t.dbed001
                     LET g_dbed_d[l_ac].dbed001_desc = s_desc_get_department_desc(g_dbed_d[l_ac].dbed001)
                     NEXT FIELD CURRENT
                  ELSE
                     IF NOT adbt700_dbed001_chk(l_cmd,g_dbed_d[l_ac].dbed001,TRUE) THEN
                        LET g_dbed_d[l_ac].dbed001 = g_dbed_d_t.dbed001
                        LET g_dbed_d[l_ac].dbed001_desc = s_desc_get_department_desc(g_dbed_d[l_ac].dbed001)
                        NEXT FIELD CURRENT
                     END IF                  
                  END IF
               END IF
            END IF
            LET g_dbed_d[l_ac].dbed001_desc = s_desc_get_department_desc(g_dbed_d[l_ac].dbed001)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbed001
            #add-point:BEFORE FIELD dbed001 name="input.b.page1.dbed001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbed001
            #add-point:ON CHANGE dbed001 name="input.g.page1.dbed001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbedsite
            #add-point:BEFORE FIELD dbedsite name="input.b.page1.dbedsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbedsite
            
            #add-point:AFTER FIELD dbedsite name="input.a.page1.dbedsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbedsite
            #add-point:ON CHANGE dbedsite name="input.g.page1.dbedsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbedunit
            #add-point:BEFORE FIELD dbedunit name="input.b.page1.dbedunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbedunit
            
            #add-point:AFTER FIELD dbedunit name="input.a.page1.dbedunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbedunit
            #add-point:ON CHANGE dbedunit name="input.g.page1.dbedunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.dbed001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbed001
            #add-point:ON ACTION controlp INFIELD dbed001 name="input.c.page1.dbed001"
            #此段落由子樣板a07產生            
            #開窗i段
            IF NOT cl_null(g_dbed_d[l_ac].dbed001) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_dbed_d[l_ac].dbed001             #給予default值
               CALL s_aooi500_q_where(g_prog,'dbed001',g_dbea_m.dbeasite,'i') #150308-00001#1  By Ken add 'i' 150309
                  RETURNING l_wc
               LET g_qryparam.where = l_wc
               CALL q_ooef001_24()
               LET g_dbed_d[l_ac].dbed001 = g_qryparam.return1
               LET g_dbed_d[l_ac].dbed001_desc = s_desc_get_department_desc(g_dbed_d[l_ac].dbed001)
               NEXT FIELD dbed001
            ELSE  
               IF adbt700_auto_ins_dbed(2,l_cmd) THEN
                  NEXT FIELD dbed001
               END IF   
            END IF   
                      

            #END add-point
 
 
         #Ctrlp:input.c.page1.dbedsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbedsite
            #add-point:ON ACTION controlp INFIELD dbedsite name="input.c.page1.dbedsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbedunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbedunit
            #add-point:ON ACTION controlp INFIELD dbedunit name="input.c.page1.dbedunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_dbed_d[l_ac].* = g_dbed_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE adbt700_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_dbed_d[l_ac].dbed001 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_dbed_d[l_ac].* = g_dbed_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL adbt700_dbed_t_mask_restore('restore_mask_o')
      
               UPDATE dbed_t SET (dbeddocno,dbed001,dbedsite,dbedunit) = (g_dbea_m.dbeadocno,g_dbed_d[l_ac].dbed001, 
                   g_dbed_d[l_ac].dbedsite,g_dbed_d[l_ac].dbedunit)
                WHERE dbedent = g_enterprise AND dbeddocno = g_dbea_m.dbeadocno 
 
                  AND dbed001 = g_dbed_d_t.dbed001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_dbed_d[l_ac].* = g_dbed_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbed_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_dbed_d[l_ac].* = g_dbed_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbed_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbea_m.dbeadocno
               LET gs_keys_bak[1] = g_dbeadocno_t
               LET gs_keys[2] = g_dbed_d[g_detail_idx].dbed001
               LET gs_keys_bak[2] = g_dbed_d_t.dbed001
               CALL adbt700_update_b('dbed_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL adbt700_dbed_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_dbed_d[g_detail_idx].dbed001 = g_dbed_d_t.dbed001 
 
                  ) THEN
                  LET gs_keys[01] = g_dbea_m.dbeadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_dbed_d_t.dbed001
 
                  CALL adbt700_key_update_b(gs_keys,'dbed_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_dbea_m),util.JSON.stringify(g_dbed_d_t)
               LET g_log2 = util.JSON.stringify(g_dbea_m),util.JSON.stringify(g_dbed_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL adbt700_unlock_b("dbed_t","'1'")
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
               LET g_dbed_d[li_reproduce_target].* = g_dbed_d[li_reproduce].*
 
               LET g_dbed_d[li_reproduce_target].dbed001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_dbed_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_dbed_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
      INPUT ARRAY g_dbed3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
        
         BEFORE INPUT
            #先將上層單身的idx放入g_detail_idx
            LET g_detail_idx_tmp = g_detail_idx
            LET g_detail_idx = g_detail_idx_list[2]
            #檢查上層單身是否為空
            IF g_detail_idx = 0 OR g_dbed2_d.getLength() = 0 THEN
               NEXT FIELD dbeb001
            END IF
            #檢查上層單身是否有資料
            IF cl_null(g_dbed2_d[g_detail_idx].dbeb001) THEN
               NEXT FIELD dbeb001
            END IF
            #add-point:資料輸入前 name="input.body3.before_input2"
            LET l_cnt = 0 
            SELECT COUNT(*) INTO l_cnt
              FROM dbeb_t 
             WHERE dbebent = g_enterprise
               AND dbebdocno = g_dbea_m.dbeadocno
            IF l_cnt = 0 THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM dbed_t
                WHERE dbedent = g_enterprise
                  AND dbeddocno = g_dbea_m.dbeadocno
               IF l_cnt = 0 THEN
                  #尚未輸入配送發貨組織範圍！
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'adb-00367'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  NEXT FIELD dbed001
               ELSE
                  #尚未產生配送資訊，不可輸入預排資訊！
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'adb-00368'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  NEXT FIELD dbea001
               END IF               
            END IF            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dbed3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_dbed3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dbed3_d[l_ac].* TO NULL 
            INITIALIZE g_dbed3_d_t.* TO NULL 
            INITIALIZE g_dbed3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_dbed3_d[l_ac].dbec005 = "0"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            #預設車次----
            LET l_fix_seq = g_dbea_m.dbea001 USING "YYYYMMDD"
            LET l_seq = ''
            LET l_max_seq = ''
            SELECT MAX(dbec002)+1 INTO l_max_seq
              FROM dbec_t
             WHERE dbecent = g_enterprise
               AND dbecdocno = g_dbea_m.dbeadocno
            IF cl_null(l_max_seq) THEN
               LET l_seq = 1
               LET l_seq = l_seq USING "&&&"
            ELSE
               LET l_seq = l_max_seq
               LET l_seq = l_seq.subString(9,11) USING "&&&"
            END IF
            LET g_dbed3_d[l_ac].dbec002 = l_fix_seq || l_seq  

            LET g_dbed3_d[l_ac].dbecsite = g_dbea_m.dbeasite
            LET g_dbed3_d[l_ac].dbecunit = g_dbea_m.dbeasite
            #預設車次----            
            #end add-point
            LET g_dbed3_d_t.* = g_dbed3_d[l_ac].*     #新輸入資料
            LET g_dbed3_d_o.* = g_dbed3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adbt700_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL adbt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dbed3_d[li_reproduce_target].* = g_dbed3_d[li_reproduce].*
 
               LET g_dbed3_d[li_reproduce_target].dbec002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
            
         BEFORE ROW
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET g_detail_idx_list[3] = l_ac
            LET g_current_page = 3
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN adbt700_cl USING g_enterprise,g_dbea_m.dbeadocno
            #(ver:78) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adbt700_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CLOSE adbt700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            #(ver:78) --- end ---
            OPEN adbt700_bcl2 USING g_enterprise,g_dbea_m.dbeadocno,g_dbed2_d[g_detail_idx].dbeb001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adbt700_bcl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adbt700_cl
               CLOSE adbt700_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_dbed3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_dbed3_d[l_ac].dbec002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_dbed3_d_t.* = g_dbed3_d[l_ac].*  #BACKUP
               LET g_dbed3_d_o.* = g_dbed3_d[l_ac].*  #BACKUP
               CALL adbt700_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL adbt700_set_no_entry_b(l_cmd)
               IF NOT adbt700_lock_b("dbec_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbt700_bcl3 INTO g_dbed3_d[l_ac].dbec002,g_dbed3_d[l_ac].dbec003,g_dbed3_d[l_ac].dbec004, 
                      g_dbed3_d[l_ac].dbec005,g_dbed3_d[l_ac].dbec006,g_dbed3_d[l_ac].dbec007,g_dbed3_d[l_ac].dbec008, 
                      g_dbed3_d[l_ac].dbec009,g_dbed3_d[l_ac].dbec010,g_dbed3_d[l_ac].dbec011,g_dbed3_d[l_ac].dbec012, 
                      g_dbed3_d[l_ac].dbec013,g_dbed3_d[l_ac].dbec014,g_dbed3_d[l_ac].dbec015,g_dbed3_d[l_ac].dbecsite, 
                      g_dbed3_d[l_ac].dbecunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_dbed3_d_mask_o[l_ac].* =  g_dbed3_d[l_ac].*
                  CALL adbt700_dbec_t_mask()
                  LET g_dbed3_d_mask_n[l_ac].* =  g_dbed3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL adbt700_show()
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
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
 
               #取得該筆資料key值
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbea_m.dbeadocno
               LET gs_keys[2] = g_dbed2_d[g_detail_idx].dbeb001
               LET gs_keys[3] = g_dbed3_d_t.dbec002
 
 
               #刪除同層單身
               IF NOT adbt700_delete_b('dbec_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adbt700_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point   
               
               CALL s_transaction_end('Y','0')
               CLOSE adbt700_bcl
                  
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               IF NOT adbt700_dbeb_amount(1) THEN
                  CALL s_transaction_end('N','0')  
               END IF  
               #end add-point
 
               LET l_count = g_dbed_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_dbed3_d.getLength() + 1) THEN
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
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            #IF cl_null(g_dbed3_d[l_ac].dbec003) THEN
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = '' 
            #   LET g_errparam.code   = 'adb-00386'
            #   LET g_errparam.popup  = TRUE
            #   CALL cl_err()
            #   NEXT FIELD dbec003               
            #END IF
            #end add-point
    
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM dbec_t 
             WHERE dbecent = g_enterprise AND dbecdocno = g_dbea_m.dbeadocno AND dbec001 = g_dbed2_d[g_detail_idx].dbeb001  
                 AND dbec002 = g_dbed3_d[g_detail_idx2].dbec002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               LET g_dbed3_d[l_ac].dbecunit = g_dbea_m.dbeasite
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbea_m.dbeadocno
               LET gs_keys[2] = g_dbed2_d[g_detail_idx].dbeb001
               LET gs_keys[3] = g_dbed3_d[g_detail_idx2].dbec002
               CALL adbt700_insert_b('dbec_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_dbed_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "dbec_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adbt700_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               IF NOT adbt700_dbeb_amount(1) THEN
                  CALL s_transaction_end('N','0')  
               END IF               
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
               LET g_dbed3_d[l_ac].* = g_dbed3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE adbt700_bcl3
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
               LET g_dbed3_d[l_ac].* = g_dbed3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL adbt700_dbec_t_mask_restore('restore_mask_o')
               
               UPDATE dbec_t SET (dbecdocno,dbec001,dbec002,dbec003,dbec004,dbec005,dbec006,dbec007, 
                   dbec008,dbec009,dbec010,dbec011,dbec012,dbec013,dbec014,dbec015,dbecsite,dbecunit) = (g_dbea_m.dbeadocno, 
                   g_dbed2_d[g_detail_idx].dbeb001,g_dbed3_d[l_ac].dbec002,g_dbed3_d[l_ac].dbec003,g_dbed3_d[l_ac].dbec004, 
                   g_dbed3_d[l_ac].dbec005,g_dbed3_d[l_ac].dbec006,g_dbed3_d[l_ac].dbec007,g_dbed3_d[l_ac].dbec008, 
                   g_dbed3_d[l_ac].dbec009,g_dbed3_d[l_ac].dbec010,g_dbed3_d[l_ac].dbec011,g_dbed3_d[l_ac].dbec012, 
                   g_dbed3_d[l_ac].dbec013,g_dbed3_d[l_ac].dbec014,g_dbed3_d[l_ac].dbec015,g_dbed3_d[l_ac].dbecsite, 
                   g_dbed3_d[l_ac].dbecunit) #自訂欄位頁簽
                WHERE dbecent = g_enterprise AND dbecdocno = g_dbeadocno_t AND dbec001 = g_dbed2_d[g_detail_idx].dbeb001  
                    AND dbec002 = g_dbed3_d_t.dbec002
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_dbed3_d[l_ac].* = g_dbed3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbec_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_dbed3_d[l_ac].* = g_dbed3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbec_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbea_m.dbeadocno
               LET gs_keys_bak[1] = g_dbeadocno_t
               LET gs_keys[2] = g_dbed2_d[g_detail_idx].dbeb001
               LET gs_keys_bak[2] = g_dbed2_d[g_detail_idx].dbeb001
               LET gs_keys[3] = g_dbed3_d[g_detail_idx2].dbec002
               LET gs_keys_bak[3] = g_dbed3_d_t.dbec002
               CALL adbt700_update_b('dbec_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL adbt700_dbec_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_dbea_m),util.JSON.stringify(g_dbed3_d_t)
               LET g_log2 = util.JSON.stringify(g_dbea_m),util.JSON.stringify(g_dbed3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               IF NOT adbt700_dbeb_amount(1) THEN
                  CALL s_transaction_end('N','0')  
               END IF  
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec002
            #add-point:BEFORE FIELD dbec002 name="input.b.page3.dbec002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec002
            
            #add-point:AFTER FIELD dbec002 name="input.a.page3.dbec002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_dbea_m.dbeadocno IS NOT NULL AND g_dbed2_d[g_detail_idx].dbeb001 IS NOT NULL AND g_dbed3_d[g_detail_idx2].dbec002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dbea_m.dbeadocno != g_dbeadocno_t OR g_dbed2_d[g_detail_idx].dbeb001 != g_dbed2_d[g_detail_idx].dbeb001 OR g_dbed3_d[g_detail_idx2].dbec002 != g_dbed3_d_t.dbec002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbec_t WHERE "||"dbecent = '" ||g_enterprise|| "' AND "||"dbecdocno = '"||g_dbea_m.dbeadocno ||"' AND "|| "dbec001 = '"||g_dbed2_d[g_detail_idx].dbeb001 ||"' AND "|| "dbec002 = '"||g_dbed3_d[g_detail_idx2].dbec002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbec002
            #add-point:ON CHANGE dbec002 name="input.g.page3.dbec002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec003
            
            #add-point:AFTER FIELD dbec003 name="input.a.page3.dbec003"
            IF NOT cl_null(g_dbed3_d[l_ac].dbec003) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbed3_d[l_ac].dbec003 != g_dbed3_d_t.dbec003 OR g_dbed3_d_t.dbec003 IS NULL )) THEN   #160824-00007#66 Mark By Ken 161007
               IF (g_dbed3_d[l_ac].dbec003 != g_dbed3_d_o.dbec003 OR g_dbed3_d_o.dbec003 IS NULL ) THEN   #160824-00007#66 Add By Ken 161007
                  IF NOT adbt700_dbec003_chk() THEN
                     #LET g_dbed3_d[l_ac].dbec003 = g_dbed3_d_t.dbec003  #160824-00007#66 Mark By Ken 161007
                     LET g_dbed3_d[l_ac].dbec003 = g_dbed3_d_o.dbec003   #160824-00007#66 Add By Ken 161007
                     NEXT FIELD CURRENT
                  ELSE
                     CALL adbt700_car_default()
                     CALL adbt700_dbeb_amount(2) RETURNING l_success
                  END IF
               END IF
            END IF
            LET g_dbed3_d_o.* = g_dbed3_d[l_ac].*   #160824-00007#66 Add By Ken 161007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec003
            #add-point:BEFORE FIELD dbec003 name="input.b.page3.dbec003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbec003
            #add-point:ON CHANGE dbec003 name="input.g.page3.dbec003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec004
            #add-point:BEFORE FIELD dbec004 name="input.b.page3.dbec004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec004
            
            #add-point:AFTER FIELD dbec004 name="input.a.page3.dbec004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbec004
            #add-point:ON CHANGE dbec004 name="input.g.page3.dbec004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec005
            #add-point:BEFORE FIELD dbec005 name="input.b.page3.dbec005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec005
            
            #add-point:AFTER FIELD dbec005 name="input.a.page3.dbec005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbec005
            #add-point:ON CHANGE dbec005 name="input.g.page3.dbec005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec006
            
            #add-point:AFTER FIELD dbec006 name="input.a.page3.dbec006"
            LET g_dbed3_d[l_ac].dbec006_desc = s_desc_get_unit_desc(g_dbed3_d[l_ac].dbec006)
            DISPLAY BY NAME g_dbed3_d[l_ac].dbec006_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec006
            #add-point:BEFORE FIELD dbec006 name="input.b.page3.dbec006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbec006
            #add-point:ON CHANGE dbec006 name="input.g.page3.dbec006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec007
            #add-point:BEFORE FIELD dbec007 name="input.b.page3.dbec007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec007
            
            #add-point:AFTER FIELD dbec007 name="input.a.page3.dbec007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbec007
            #add-point:ON CHANGE dbec007 name="input.g.page3.dbec007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec008
            
            #add-point:AFTER FIELD dbec008 name="input.a.page3.dbec008"
            LET g_dbed3_d[l_ac].dbec008_desc = s_desc_get_unit_desc(g_dbed3_d[l_ac].dbec008)
            DISPLAY BY NAME g_dbed3_d[l_ac].dbec008_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec008
            #add-point:BEFORE FIELD dbec008 name="input.b.page3.dbec008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbec008
            #add-point:ON CHANGE dbec008 name="input.g.page3.dbec008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec009
            #add-point:BEFORE FIELD dbec009 name="input.b.page3.dbec009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec009
            
            #add-point:AFTER FIELD dbec009 name="input.a.page3.dbec009"
            IF NOT cl_null(g_dbed3_d[l_ac].dbec009) THEN
               IF NOT adbt700_time_chk(1) THEN
                  NEXT FIELD CURRENT
               END IF   
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbec009
            #add-point:ON CHANGE dbec009 name="input.g.page3.dbec009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec010
            #add-point:BEFORE FIELD dbec010 name="input.b.page3.dbec010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec010
            
            #add-point:AFTER FIELD dbec010 name="input.a.page3.dbec010"
            IF NOT cl_null(g_dbed3_d[l_ac].dbec009) THEN
               IF NOT adbt700_time_chk(2) THEN
                  NEXT FIELD CURRENT
               END IF   
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbec010
            #add-point:ON CHANGE dbec010 name="input.g.page3.dbec010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec011
            #add-point:BEFORE FIELD dbec011 name="input.b.page3.dbec011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec011
            
            #add-point:AFTER FIELD dbec011 name="input.a.page3.dbec011"
            IF NOT cl_null(g_dbed3_d[l_ac].dbec009) THEN
               IF NOT adbt700_time_chk(3) THEN
                  NEXT FIELD CURRENT
               END IF   
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbec011
            #add-point:ON CHANGE dbec011 name="input.g.page3.dbec011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec012
            #add-point:BEFORE FIELD dbec012 name="input.b.page3.dbec012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec012
            
            #add-point:AFTER FIELD dbec012 name="input.a.page3.dbec012"
            IF NOT cl_null(g_dbed3_d[l_ac].dbec009) THEN
               IF NOT adbt700_time_chk(4) THEN
                  NEXT FIELD CURRENT
               END IF   
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbec012
            #add-point:ON CHANGE dbec012 name="input.g.page3.dbec012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec013
            #add-point:BEFORE FIELD dbec013 name="input.b.page3.dbec013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec013
            
            #add-point:AFTER FIELD dbec013 name="input.a.page3.dbec013"
            IF NOT cl_null(g_dbed3_d[l_ac].dbec009) THEN
               IF NOT adbt700_time_chk(5) THEN
                  NEXT FIELD CURRENT
               END IF   
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbec013
            #add-point:ON CHANGE dbec013 name="input.g.page3.dbec013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec014
            
            #add-point:AFTER FIELD dbec014 name="input.a.page3.dbec014"
            IF NOT cl_null(g_dbed3_d[l_ac].dbec014) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbed3_d[l_ac].dbec014 != g_dbed3_d_t.dbec014 OR g_dbed3_d_t.dbec014 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_dbea_m.dbeadocno
                  LET g_chkparam.arg2 = g_dbed3_d[l_ac].dbec014
                  IF NOT cl_chk_exist("v_dbec002") THEN
                     LET g_dbed3_d[l_ac].dbec014 = g_dbed3_d_t.dbec014
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec014
            #add-point:BEFORE FIELD dbec014 name="input.b.page3.dbec014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbec014
            #add-point:ON CHANGE dbec014 name="input.g.page3.dbec014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbec015
            #add-point:BEFORE FIELD dbec015 name="input.b.page3.dbec015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbec015
            
            #add-point:AFTER FIELD dbec015 name="input.a.page3.dbec015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbec015
            #add-point:ON CHANGE dbec015 name="input.g.page3.dbec015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbecsite
            #add-point:BEFORE FIELD dbecsite name="input.b.page3.dbecsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbecsite
            
            #add-point:AFTER FIELD dbecsite name="input.a.page3.dbecsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbecsite
            #add-point:ON CHANGE dbecsite name="input.g.page3.dbecsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbecunit
            #add-point:BEFORE FIELD dbecunit name="input.b.page3.dbecunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbecunit
            
            #add-point:AFTER FIELD dbecunit name="input.a.page3.dbecunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbecunit
            #add-point:ON CHANGE dbecunit name="input.g.page3.dbecunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.dbec002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec002
            #add-point:ON ACTION controlp INFIELD dbec002 name="input.c.page3.dbec002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbec003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec003
            #add-point:ON ACTION controlp INFIELD dbec003 name="input.c.page3.dbec003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dbed3_d[l_ac].dbec003             #給予default值
            LET g_qryparam.default2 = "" #g_dbed3_d[l_ac].mrba001 #資源編號/車輛編號
            LET g_qryparam.default3 = "" #g_dbed3_d[l_ac].ooag011 #全名
            #給予arg
            #LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = "mrba100 = '1'" #ken---add 車輛開窗只顯示使用中的車輛編號 需求單號：150226-00006 項次：1
            LET g_qryparam.arg1 = g_dbea_m.dbeasite
            CALL q_mrba001_8()                                #呼叫開窗

            LET g_dbed3_d[l_ac].dbec003 = g_qryparam.return1              
            #LET g_dbed3_d[l_ac].mrba001 = g_qryparam.return2 
            #LET g_dbed3_d[l_ac].ooag011 = g_qryparam.return3 
            DISPLAY g_dbed3_d[l_ac].dbec003 TO dbec003              #
            #DISPLAY g_dbed3_d[l_ac].mrba001 TO mrba001 #資源編號/車輛編號
            #DISPLAY g_dbed3_d[l_ac].ooag011 TO ooag011 #全名
            NEXT FIELD dbec003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.dbec004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec004
            #add-point:ON ACTION controlp INFIELD dbec004 name="input.c.page3.dbec004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbec005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec005
            #add-point:ON ACTION controlp INFIELD dbec005 name="input.c.page3.dbec005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbec006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec006
            #add-point:ON ACTION controlp INFIELD dbec006 name="input.c.page3.dbec006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbec007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec007
            #add-point:ON ACTION controlp INFIELD dbec007 name="input.c.page3.dbec007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbec008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec008
            #add-point:ON ACTION controlp INFIELD dbec008 name="input.c.page3.dbec008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbec009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec009
            #add-point:ON ACTION controlp INFIELD dbec009 name="input.c.page3.dbec009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbec010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec010
            #add-point:ON ACTION controlp INFIELD dbec010 name="input.c.page3.dbec010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbec011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec011
            #add-point:ON ACTION controlp INFIELD dbec011 name="input.c.page3.dbec011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbec012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec012
            #add-point:ON ACTION controlp INFIELD dbec012 name="input.c.page3.dbec012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbec013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec013
            #add-point:ON ACTION controlp INFIELD dbec013 name="input.c.page3.dbec013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbec014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec014
            #add-point:ON ACTION controlp INFIELD dbec014 name="input.c.page3.dbec014"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dbed3_d[l_ac].dbec014   
            LET g_qryparam.arg1 = g_dbea_m.dbeadocno            
            CALL q_dbec002()                             
            LET g_dbed3_d[l_ac].dbec014 = g_qryparam.return1      
            DISPLAY g_dbed3_d[l_ac].dbec014 TO dbec014     
            NEXT FIELD dbec014                        
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbec015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbec015
            #add-point:ON ACTION controlp INFIELD dbec015 name="input.c.page3.dbec015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbecsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbecsite
            #add-point:ON ACTION controlp INFIELD dbecsite name="input.c.page3.dbecsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbecunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbecunit
            #add-point:ON ACTION controlp INFIELD dbecunit name="input.c.page3.dbecunit"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3_after_row name="input.body3.after_row"
            CALL adbt700_dbeb_amount(1) RETURNING l_success  
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_dbed3_d[l_ac].* = g_dbed3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE adbt700_bcl3
               CLOSE adbt700_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL adbt700_unlock_b("dbec_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3_after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point  
 
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_dbed3_d[li_reproduce_target].* = g_dbed3_d[li_reproduce].*
 
               LET g_dbed3_d[li_reproduce_target].dbec002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_dbed3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_dbed3_d.getLength()+1
            END IF
        
      END INPUT
 
      DISPLAY ARRAY g_dbed2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL adbt700_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            CALL adbt700_b_fill2('3')
 
            #add-point:page2, before row動作 name="input.body2.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            CALL adbt700_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
       
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="adbt700.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD dbeadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD dbed001
               WHEN "s_detail2"
                  NEXT FIELD dbeb001
               WHEN "s_detail3"
                  NEXT FIELD dbec002
 
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
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
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
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="adbt700.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adbt700_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL adbt700_b_fill() #單身填充
      CALL adbt700_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL adbt700_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_dbea_m_mask_o.* =  g_dbea_m.*
   CALL adbt700_dbea_t_mask()
   LET g_dbea_m_mask_n.* =  g_dbea_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_dbea_m.dbeasite,g_dbea_m.dbeasite_desc,g_dbea_m.dbeadocdt,g_dbea_m.dbeadocno,g_dbea_m.dbeaunit, 
       g_dbea_m.dbea001,g_dbea_m.dbea002,g_dbea_m.dbea002_desc,g_dbea_m.dbea003,g_dbea_m.dbea003_desc, 
       g_dbea_m.dbeastus,g_dbea_m.dbeaownid,g_dbea_m.dbeaownid_desc,g_dbea_m.dbeaowndp,g_dbea_m.dbeaowndp_desc, 
       g_dbea_m.dbeacrtid,g_dbea_m.dbeacrtid_desc,g_dbea_m.dbeacrtdp,g_dbea_m.dbeacrtdp_desc,g_dbea_m.dbeacrtdt, 
       g_dbea_m.dbeamodid,g_dbea_m.dbeamodid_desc,g_dbea_m.dbeamoddt,g_dbea_m.dbeacnfid,g_dbea_m.dbeacnfid_desc, 
       g_dbea_m.dbeacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_dbea_m.dbeastus 
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
   FOR l_ac = 1 TO g_dbed_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_dbed2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_dbed3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL adbt700_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION adbt700_detail_show()
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
 
{<section id="adbt700.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION adbt700_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE dbea_t.dbeadocno 
   DEFINE l_oldno     LIKE dbea_t.dbeadocno 
 
   DEFINE l_master    RECORD LIKE dbea_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE dbed_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE dbeb_t.* #此變數樣板目前無使用
 
 
   DEFINE l_detail3    RECORD LIKE dbec_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
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
   
   IF g_dbea_m.dbeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_dbeadocno_t = g_dbea_m.dbeadocno
 
    
   LET g_dbea_m.dbeadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_dbea_m.dbeaownid = g_user
      LET g_dbea_m.dbeaowndp = g_dept
      LET g_dbea_m.dbeacrtid = g_user
      LET g_dbea_m.dbeacrtdp = g_dept 
      LET g_dbea_m.dbeacrtdt = cl_get_current()
      LET g_dbea_m.dbeamodid = g_user
      LET g_dbea_m.dbeamoddt = cl_get_current()
      LET g_dbea_m.dbeastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
      CALL s_aooi500_default(g_prog,'dbeasite',g_dbea_m.dbeasite)
         RETURNING l_insert,g_dbea_m.dbeasite
      IF l_insert = FALSE THEN
         RETURN
      END IF
      #CALL s_aooi500_default(g_prog,'dbeeunit',g_dbee_m.dbeesite)
      #   RETURNING l_insert,g_dbee_m.dbeeunit
      #IF l_insert = FALSE THEN
      #   RETURN
      #END IF
      LET g_dbea_m.dbeasite_desc = s_desc_get_department_desc(g_dbea_m.dbeasite)
      LET g_dbea_m.dbeadocdt     = g_today
      LET g_dbea_m.dbea001       = NULL      
      LET g_dbea_m.dbea002       = g_user
      LET g_dbea_m.dbea002_desc  = s_desc_get_person_desc(g_dbea_m.dbea002)
      CALL adbt700_dbea003_default()
      
      CALL s_arti200_get_def_doc_type(g_site,g_prog,'1')
         RETURNING l_success,g_dbea_m.dbeadocno

      #for 單據別開窗時可以在 營運中心切換時，開出正確的資料
      LET g_ooef004 = ''
      SELECT ooef004 INTO g_ooef004 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      IF cl_null(g_ooef004) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00007'
         LET g_errparam.extend = g_site
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF  
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_dbea_m.dbeastus 
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
   
   
   CALL adbt700_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_dbea_m.* TO NULL
      INITIALIZE g_dbed_d TO NULL
      INITIALIZE g_dbed2_d TO NULL
      INITIALIZE g_dbed3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL adbt700_show()
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
   CALL adbt700_set_act_visible()   
   CALL adbt700_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_dbeadocno_t = g_dbea_m.dbeadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " dbeaent = " ||g_enterprise|| " AND",
                      " dbeadocno = '", g_dbea_m.dbeadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adbt700_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL adbt700_idx_chk()
   
   LET g_data_owner = g_dbea_m.dbeaownid      
   LET g_data_dept  = g_dbea_m.dbeaowndp
   
   #功能已完成,通報訊息中心
   CALL adbt700_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="adbt700.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION adbt700_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE dbed_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE dbeb_t.* #此變數樣板目前無使用
 
 
   DEFINE l_detail3    RECORD LIKE dbec_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   WHENEVER ERROR CONTINUE
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE adbt700_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM dbed_t
    WHERE dbedent = g_enterprise AND dbeddocno = g_dbeadocno_t
 
    INTO TEMP adbt700_detail
 
   #將key修正為調整後   
   UPDATE adbt700_detail 
      #更新key欄位
      SET dbeddocno = g_dbea_m.dbeadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO dbed_t SELECT * FROM adbt700_detail
   
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
   DROP TABLE adbt700_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
#複製時,只複製單頭與配送組織範圍
#   #end add-point
#   
#   #CREATE TEMP TABLE
#   SELECT * FROM dbeb_t 
#    WHERE dbebent = g_enterprise AND dbebdocno = g_dbeadocno_t
# 
#    INTO TEMP adbt700_detail
# 
#   #將key修正為調整後   
#   UPDATE adbt700_detail SET dbebdocno = g_dbea_m.dbeadocno
# 
#  
#   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO dbeb_t SELECT * FROM adbt700_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE adbt700_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
#複製時,只複製單頭與配送組織範圍
#   #end add-point
#   
#   #CREATE TEMP TABLE
#   SELECT * FROM dbec_t 
#    WHERE dbecent = g_enterprise AND dbecdocno = g_dbeadocno_t
# 
#    INTO TEMP adbt700_detail
# 
#   #將key修正為調整後   
#   UPDATE adbt700_detail SET dbecdocno = g_dbea_m.dbeadocno
# 
#  
#   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO dbec_t SELECT * FROM adbt700_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE adbt700_detail
   
   LET g_data_owner = g_dbea_m.dbeaownid      
   LET g_data_dept  = g_dbea_m.dbeaowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_dbeadocno_t = g_dbea_m.dbeadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adbt700_delete()
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
   
   IF g_dbea_m.dbeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN adbt700_cl USING g_enterprise,g_dbea_m.dbeadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adbt700_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adbt700_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adbt700_master_referesh USING g_dbea_m.dbeadocno INTO g_dbea_m.dbeasite,g_dbea_m.dbeadocdt, 
       g_dbea_m.dbeadocno,g_dbea_m.dbeaunit,g_dbea_m.dbea001,g_dbea_m.dbea002,g_dbea_m.dbea003,g_dbea_m.dbeastus, 
       g_dbea_m.dbeaownid,g_dbea_m.dbeaowndp,g_dbea_m.dbeacrtid,g_dbea_m.dbeacrtdp,g_dbea_m.dbeacrtdt, 
       g_dbea_m.dbeamodid,g_dbea_m.dbeamoddt,g_dbea_m.dbeacnfid,g_dbea_m.dbeacnfdt,g_dbea_m.dbeasite_desc, 
       g_dbea_m.dbea002_desc,g_dbea_m.dbea003_desc,g_dbea_m.dbeaownid_desc,g_dbea_m.dbeaowndp_desc,g_dbea_m.dbeacrtid_desc, 
       g_dbea_m.dbeacrtdp_desc,g_dbea_m.dbeamodid_desc,g_dbea_m.dbeacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT adbt700_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_dbea_m_mask_o.* =  g_dbea_m.*
   CALL adbt700_dbea_t_mask()
   LET g_dbea_m_mask_n.* =  g_dbea_m.*
   
   CALL adbt700_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adbt700_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_dbeadocno_t = g_dbea_m.dbeadocno
 
 
      DELETE FROM dbea_t
       WHERE dbeaent = g_enterprise AND dbeadocno = g_dbea_m.dbeadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_dbea_m.dbeadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_dbea_m.dbeadocno,g_dbea_m.dbeadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM dbed_t
       WHERE dbedent = g_enterprise AND dbeddocno = g_dbea_m.dbeadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbed_t:",SQLERRMESSAGE 
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
      DELETE FROM dbeb_t
       WHERE dbebent = g_enterprise AND
             dbebdocno = g_dbea_m.dbeadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbeb_t:",SQLERRMESSAGE 
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
      DELETE FROM dbec_t
       WHERE dbecent = g_enterprise AND
             dbecdocno = g_dbea_m.dbeadocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_dbea_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE adbt700_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_dbed_d.clear() 
      CALL g_dbed2_d.clear()       
      CALL g_dbed3_d.clear()       
 
     
      CALL adbt700_ui_browser_refresh()  
      #CALL adbt700_ui_headershow()  
      #CALL adbt700_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL adbt700_browser_fill("")
         CALL adbt700_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE adbt700_cl
 
   #功能已完成,通報訊息中心
   CALL adbt700_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="adbt700.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adbt700_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_dbed_d.clear()
   CALL g_dbed2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF adbt700_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT dbed001,dbedsite,dbedunit ,t1.ooefl003 FROM dbed_t",   
                     " INNER JOIN dbea_t ON dbeaent = " ||g_enterprise|| " AND dbeadocno = dbeddocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
                     " ",
 
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=dbed001 AND t1.ooefl002='"||g_dlang||"' ",
 
                     " WHERE dbedent=? AND dbeddocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY dbed_t.dbed001"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE adbt700_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR adbt700_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_dbea_m.dbeadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_dbea_m.dbeadocno INTO g_dbed_d[l_ac].dbed001,g_dbed_d[l_ac].dbedsite, 
          g_dbed_d[l_ac].dbedunit,g_dbed_d[l_ac].dbed001_desc   #(ver:78)
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
   IF adbt700_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT dbeb001,dbeb002,dbeb003,dbeb004,dbeb005,dbeb006,dbeb007,dbeb008, 
             dbebsite,dbebunit ,t2.dbabl003 ,t3.dbael003 ,t4.oocal003 ,t5.oocal003 FROM dbeb_t",   
                     " INNER JOIN  dbea_t ON dbeaent = " ||g_enterprise|| " AND dbeadocno = dbebdocno ",
 
                     "",
                     " LEFT JOIN dbec_t ON dbebent = dbecent AND dbebdocno = dbecdocno AND dbeb001 = dbec001 ",
                                    " LEFT JOIN dbabl_t t2 ON t2.dbablent="||g_enterprise||" AND t2.dbabl001=dbeb001 AND t2.dbabl002='"||g_dlang||"' ",
               " LEFT JOIN dbael_t t3 ON t3.dbaelent="||g_enterprise||" AND t3.dbael001=dbeb002 AND t3.dbael002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=dbeb005 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=dbeb008 AND t5.oocal002='"||g_dlang||"' ",
 
                     " WHERE dbebent=? AND dbebdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
            IF NOT cl_null(g_wc2_table3) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table3 CLIPPED
   END IF 
 
         
         LET g_sql = g_sql, " ORDER BY dbeb_t.dbeb001"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE adbt700_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR adbt700_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_dbea_m.dbeadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_dbea_m.dbeadocno INTO g_dbed2_d[l_ac].dbeb001,g_dbed2_d[l_ac].dbeb002, 
          g_dbed2_d[l_ac].dbeb003,g_dbed2_d[l_ac].dbeb004,g_dbed2_d[l_ac].dbeb005,g_dbed2_d[l_ac].dbeb006, 
          g_dbed2_d[l_ac].dbeb007,g_dbed2_d[l_ac].dbeb008,g_dbed2_d[l_ac].dbebsite,g_dbed2_d[l_ac].dbebunit, 
          g_dbed2_d[l_ac].dbeb001_desc,g_dbed2_d[l_ac].dbeb002_desc,g_dbed2_d[l_ac].dbeb005_desc,g_dbed2_d[l_ac].dbeb008_desc  
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
   
   CALL g_dbed_d.deleteElement(g_dbed_d.getLength())
   CALL g_dbed2_d.deleteElement(g_dbed2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE adbt700_pb
   FREE adbt700_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_dbed_d.getLength()
      LET g_dbed_d_mask_o[l_ac].* =  g_dbed_d[l_ac].*
      CALL adbt700_dbed_t_mask()
      LET g_dbed_d_mask_n[l_ac].* =  g_dbed_d[l_ac].*
   END FOR
   
   LET g_dbed2_d_mask_o.* =  g_dbed2_d.*
   FOR l_ac = 1 TO g_dbed2_d.getLength()
      LET g_dbed2_d_mask_o[l_ac].* =  g_dbed2_d[l_ac].*
      CALL adbt700_dbeb_t_mask()
      LET g_dbed2_d_mask_n[l_ac].* =  g_dbed2_d[l_ac].*
   END FOR
   LET g_dbed3_d_mask_o.* =  g_dbed3_d.*
   FOR l_ac = 1 TO g_dbed3_d.getLength()
      LET g_dbed3_d_mask_o[l_ac].* =  g_dbed3_d[l_ac].*
      CALL adbt700_dbec_t_mask()
      LET g_dbed3_d_mask_n[l_ac].* =  g_dbed3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="adbt700.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adbt700_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM dbed_t
       WHERE dbedent = g_enterprise AND
         dbeddocno = ps_keys_bak[1] AND dbed001 = ps_keys_bak[2]
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
         CALL g_dbed_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM dbeb_t
       WHERE dbebent = g_enterprise AND
             dbebdocno = ps_keys_bak[1] AND dbeb001 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbeb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_dbed2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM dbec_t
       WHERE dbecent = g_enterprise AND
             dbecdocno = ps_keys_bak[1] AND dbec001 = ps_keys_bak[2] AND dbec002 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'3'" THEN 
         CALL g_dbed3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
 
      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adbt700_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO dbed_t
                  (dbedent,
                   dbeddocno,
                   dbed001
                   ,dbedsite,dbedunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_dbed_d[g_detail_idx].dbedsite,g_dbed_d[g_detail_idx].dbedunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbed_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_dbed_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
 
      #end add-point 
      INSERT INTO dbeb_t
                  (dbebent,
                   dbebdocno,
                   dbeb001
                   ,dbeb002,dbeb003,dbeb004,dbeb005,dbeb006,dbeb007,dbeb008,dbebsite,dbebunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_dbed2_d[g_detail_idx].dbeb002,g_dbed2_d[g_detail_idx].dbeb003,g_dbed2_d[g_detail_idx].dbeb004, 
                       g_dbed2_d[g_detail_idx].dbeb005,g_dbed2_d[g_detail_idx].dbeb006,g_dbed2_d[g_detail_idx].dbeb007, 
                       g_dbed2_d[g_detail_idx].dbeb008,g_dbed2_d[g_detail_idx].dbebsite,g_dbed2_d[g_detail_idx].dbebunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbeb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_dbed2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
 
      #end add-point
   END IF
 
 
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO dbec_t
                  (dbecent,
                   dbecdocno,dbec001,
                   dbec002
                   ,dbec003,dbec004,dbec005,dbec006,dbec007,dbec008,dbec009,dbec010,dbec011,dbec012,dbec013,dbec014,dbec015,dbecsite,dbecunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_dbed3_d[g_detail_idx2].dbec003,g_dbed3_d[g_detail_idx2].dbec004,g_dbed3_d[g_detail_idx2].dbec005, 
                       g_dbed3_d[g_detail_idx2].dbec006,g_dbed3_d[g_detail_idx2].dbec007,g_dbed3_d[g_detail_idx2].dbec008, 
                       g_dbed3_d[g_detail_idx2].dbec009,g_dbed3_d[g_detail_idx2].dbec010,g_dbed3_d[g_detail_idx2].dbec011, 
                       g_dbed3_d[g_detail_idx2].dbec012,g_dbed3_d[g_detail_idx2].dbec013,g_dbed3_d[g_detail_idx2].dbec014, 
                       g_dbed3_d[g_detail_idx2].dbec015,g_dbed3_d[g_detail_idx2].dbecsite,g_dbed3_d[g_detail_idx2].dbecunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'3'" THEN 
         CALL g_dbed3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adbt700_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "dbed_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL adbt700_dbed_t_mask_restore('restore_mask_o')
               
      UPDATE dbed_t 
         SET (dbeddocno,
              dbed001
              ,dbedsite,dbedunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_dbed_d[g_detail_idx].dbedsite,g_dbed_d[g_detail_idx].dbedunit) 
         WHERE dbedent = g_enterprise AND dbeddocno = ps_keys_bak[1] AND dbed001 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbed_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbed_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL adbt700_dbed_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "dbeb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL adbt700_dbeb_t_mask_restore('restore_mask_o')
               
      UPDATE dbeb_t 
         SET (dbebdocno,
              dbeb001
              ,dbeb002,dbeb003,dbeb004,dbeb005,dbeb006,dbeb007,dbeb008,dbebsite,dbebunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_dbed2_d[g_detail_idx].dbeb002,g_dbed2_d[g_detail_idx].dbeb003,g_dbed2_d[g_detail_idx].dbeb004, 
                  g_dbed2_d[g_detail_idx].dbeb005,g_dbed2_d[g_detail_idx].dbeb006,g_dbed2_d[g_detail_idx].dbeb007, 
                  g_dbed2_d[g_detail_idx].dbeb008,g_dbed2_d[g_detail_idx].dbebsite,g_dbed2_d[g_detail_idx].dbebunit)  
 
         WHERE dbebent = g_enterprise AND dbebdocno = ps_keys_bak[1] AND dbeb001 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbeb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbeb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL adbt700_dbeb_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "dbec_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL adbt700_dbec_t_mask_restore('restore_mask_o')
               
      UPDATE dbec_t 
         SET (dbecdocno,dbec001,
              dbec002
              ,dbec003,dbec004,dbec005,dbec006,dbec007,dbec008,dbec009,dbec010,dbec011,dbec012,dbec013,dbec014,dbec015,dbecsite,dbecunit) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_dbed3_d[g_detail_idx2].dbec003,g_dbed3_d[g_detail_idx2].dbec004,g_dbed3_d[g_detail_idx2].dbec005, 
                  g_dbed3_d[g_detail_idx2].dbec006,g_dbed3_d[g_detail_idx2].dbec007,g_dbed3_d[g_detail_idx2].dbec008, 
                  g_dbed3_d[g_detail_idx2].dbec009,g_dbed3_d[g_detail_idx2].dbec010,g_dbed3_d[g_detail_idx2].dbec011, 
                  g_dbed3_d[g_detail_idx2].dbec012,g_dbed3_d[g_detail_idx2].dbec013,g_dbed3_d[g_detail_idx2].dbec014, 
                  g_dbed3_d[g_detail_idx2].dbec015,g_dbed3_d[g_detail_idx2].dbecsite,g_dbed3_d[g_detail_idx2].dbecunit)  
 
         WHERE dbecent = g_enterprise AND dbecdocno = ps_keys_bak[1] AND dbec001 = ps_keys_bak[2] AND dbec002 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbec_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbec_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL adbt700_dbec_t_mask_restore('restore_mask_n')
               
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
 
{<section id="adbt700.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION adbt700_key_update_b(ps_keys_bak,ps_table)
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
   IF ps_table = 'dbeb_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update3"
      
      #end add-point
      
      UPDATE dbec_t 
         SET (dbecdocno,dbec001) 
              = 
             (g_dbea_m.dbeadocno,g_dbed2_d[g_detail_idx].dbeb001) 
         WHERE dbecent = g_enterprise AND
               dbecdocno = ps_keys_bak[1] AND dbec001 = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="key_update_b.m_update3"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbec_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      
      #add-point:update_b段修改後 name="key_update_b.after_update3"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION adbt700_key_delete_b(ps_keys_bak,ps_table)
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
   IF ps_table = 'dbeb_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete3"
      
      #end add-point
      
      DELETE FROM dbec_t 
            WHERE dbecent = g_enterprise AND
                  dbecdocno = ps_keys_bak[1] AND dbec001 = ps_keys_bak[2]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete3"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbec_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
 
       
 
      #add-point:delete_b段修改後 name="key_delete_b.after_delete3"
      
      #end add-point
   END IF
 
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adbt700_lock_b(ps_table,ps_page)
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
   #CALL adbt700_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "dbed_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN adbt700_bcl USING g_enterprise,
                                       g_dbea_m.dbeadocno,g_dbed_d[g_detail_idx].dbed001     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adbt700_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "dbeb_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN adbt700_bcl2 USING g_enterprise,
                                             g_dbea_m.dbeadocno,g_dbed2_d[g_detail_idx].dbeb001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adbt700_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "dbec_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN adbt700_bcl3 USING g_enterprise,
                                             g_dbea_m.dbeadocno,g_dbed2_d[g_detail_idx].dbeb001,
                                             g_dbed3_d[g_detail_idx2].dbec002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adbt700_bcl3:",SQLERRMESSAGE 
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
 
{<section id="adbt700.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adbt700_unlock_b(ps_table,ps_page)
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
      CLOSE adbt700_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE adbt700_bcl2
   END IF
 
 
   
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE adbt700_bcl3
   END IF
 
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="adbt700.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adbt700_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("dbeadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("dbeadocno",TRUE)
      CALL cl_set_comp_entry("dbeadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("dbeasite",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("dbeasite,dbeaunit",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adbt700.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adbt700_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("dbeadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("dbeasite",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("dbeadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("dbeadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF p_cmd = 'a' AND NOT cl_null(g_dbea_m.dbeadocno) AND g_ins_docno_flag = 'Y' THEN
       CALL cl_set_comp_entry("dbeadocno",FALSE)
   END IF   
   
   #aooi500設定的欄位控卡
   IF (NOT s_aooi500_comp_entry(g_prog,'dbeasite') OR g_ins_site_flag = 'Y') THEN
      CALL cl_set_comp_entry("dbeasite",FALSE)
   END IF
   IF NOT s_aooi500_comp_entry(g_prog,'dbeaunit') THEN
      CALL cl_set_comp_entry("dbeaunit",FALSE)
   END IF   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adbt700.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adbt700_set_entry_b(p_cmd)
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
 
{<section id="adbt700.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adbt700_set_no_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("dbeb001,dbeb002,dbeb003,dbeb004,dbeb005,dbeb006,dbeb007,dbeb008",FALSE)
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="adbt700.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION adbt700_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION adbt700_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_dbea_m.dbeastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION adbt700_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION adbt700_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adbt700_default_search()
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
      LET ls_wc = ls_wc, " dbeadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "dbea_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "dbed_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "dbeb_t" 
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
 
{<section id="adbt700.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION adbt700_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_dbea_m.dbeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN adbt700_cl USING g_enterprise,g_dbea_m.dbeadocno
   IF STATUS THEN
      CLOSE adbt700_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adbt700_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE adbt700_master_referesh USING g_dbea_m.dbeadocno INTO g_dbea_m.dbeasite,g_dbea_m.dbeadocdt, 
       g_dbea_m.dbeadocno,g_dbea_m.dbeaunit,g_dbea_m.dbea001,g_dbea_m.dbea002,g_dbea_m.dbea003,g_dbea_m.dbeastus, 
       g_dbea_m.dbeaownid,g_dbea_m.dbeaowndp,g_dbea_m.dbeacrtid,g_dbea_m.dbeacrtdp,g_dbea_m.dbeacrtdt, 
       g_dbea_m.dbeamodid,g_dbea_m.dbeamoddt,g_dbea_m.dbeacnfid,g_dbea_m.dbeacnfdt,g_dbea_m.dbeasite_desc, 
       g_dbea_m.dbea002_desc,g_dbea_m.dbea003_desc,g_dbea_m.dbeaownid_desc,g_dbea_m.dbeaowndp_desc,g_dbea_m.dbeacrtid_desc, 
       g_dbea_m.dbeacrtdp_desc,g_dbea_m.dbeamodid_desc,g_dbea_m.dbeacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT adbt700_action_chk() THEN
      CLOSE adbt700_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_dbea_m.dbeasite,g_dbea_m.dbeasite_desc,g_dbea_m.dbeadocdt,g_dbea_m.dbeadocno,g_dbea_m.dbeaunit, 
       g_dbea_m.dbea001,g_dbea_m.dbea002,g_dbea_m.dbea002_desc,g_dbea_m.dbea003,g_dbea_m.dbea003_desc, 
       g_dbea_m.dbeastus,g_dbea_m.dbeaownid,g_dbea_m.dbeaownid_desc,g_dbea_m.dbeaowndp,g_dbea_m.dbeaowndp_desc, 
       g_dbea_m.dbeacrtid,g_dbea_m.dbeacrtid_desc,g_dbea_m.dbeacrtdp,g_dbea_m.dbeacrtdp_desc,g_dbea_m.dbeacrtdt, 
       g_dbea_m.dbeamodid,g_dbea_m.dbeamodid_desc,g_dbea_m.dbeamoddt,g_dbea_m.dbeacnfid,g_dbea_m.dbeacnfid_desc, 
       g_dbea_m.dbeacnfdt
 
   CASE g_dbea_m.dbeastus
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
         CASE g_dbea_m.dbeastus
            
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
      #160825-00043#1 Add By Ken 160830(S)
      CALL cl_set_act_visible("signing,withdraw,closed",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      #160825-00043#1 Add By Ken 160830(E) 
      CASE g_dbea_m.dbeastus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            RETURN
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)

         WHEN "A"   #已核准
            CALL cl_set_act_visible("confirmed ",TRUE)

         WHEN "R"   #已拒絕
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("invalid,confirmed",TRUE)

            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "D"   #抽單
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("invalid,confirmed",TRUE)

            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "W"   #送簽中
            CALL cl_set_act_visible("withdraw",TRUE)
            
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT adbt700_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE adbt700_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT adbt700_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE adbt700_cl
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
      g_dbea_m.dbeastus = lc_state OR cl_null(lc_state) THEN
      CLOSE adbt700_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   OPEN adbt700_cl USING g_enterprise,g_dbea_m.dbeadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adbt700_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      CLOSE adbt700_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF     
   
   
   CASE
      WHEN lc_state = 'Y'            #確認
         CALL cl_err_collect_init()  
         IF NOT s_adbt700_conf_chk(g_dbea_m.dbeadocno,g_dbea_m.dbeastus) THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()   
            RETURN
         ELSE
            CALL s_transaction_end('Y','0')
            CALL cl_err_collect_show()  
         END IF 
         
         IF cl_ask_confirm('aim-00108') THEN
            CALL cl_err_collect_init()  
            CALL s_transaction_begin()
            IF NOT s_adbt700_conf_upd(g_dbea_m.dbeadocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()   
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()  
            END IF
         ELSE
            LET lc_state = g_dbea_m.dbeastus
         END IF      
         
      WHEN lc_state = 'N'            #取消確認  
         CALL cl_err_collect_init()  
         CALL s_transaction_begin()
         IF NOT s_adbt700_unconf_chk(g_dbea_m.dbeadocno,g_dbea_m.dbeastus) THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()   
            RETURN
         ELSE
            CALL s_transaction_end('Y','0')
            CALL cl_err_collect_show()  
         END IF   
         
         IF cl_ask_confirm('aim-00110') THEN
            CALL cl_err_collect_init()  
            CALL s_transaction_begin()
            IF NOT s_adbt700_unconf_upd(g_dbea_m.dbeadocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()   
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()   
            END IF
         ELSE
            LET lc_state = g_dbea_m.dbeastus 
         END IF
      
      WHEN lc_state = 'X'            #作廢 
         CALL cl_err_collect_init()  
         CALL s_transaction_begin()
         IF NOT s_adbt700_invalid_chk(g_dbea_m.dbeadocno,g_dbea_m.dbeastus) THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()   
            RETURN
         ELSE
            CALL s_transaction_end('Y','0')
            CALL cl_err_collect_show()  
         END IF  
         
         IF cl_ask_confirm('aim-00109') THEN
            CALL cl_err_collect_init()  
            CALL s_transaction_begin()
            IF NOT s_adbt700_invalid_upd(g_dbea_m.dbeadocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()   
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()  
            END IF
         ELSE
            LET lc_state = g_dbea_m.dbeastus 
         END IF
   END CASE
   #end add-point
   
   LET g_dbea_m.dbeamodid = g_user
   LET g_dbea_m.dbeamoddt = cl_get_current()
   LET g_dbea_m.dbeastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE dbea_t 
      SET (dbeastus,dbeamodid,dbeamoddt) 
        = (g_dbea_m.dbeastus,g_dbea_m.dbeamodid,g_dbea_m.dbeamoddt)     
    WHERE dbeaent = g_enterprise AND dbeadocno = g_dbea_m.dbeadocno
 
    
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
      EXECUTE adbt700_master_referesh USING g_dbea_m.dbeadocno INTO g_dbea_m.dbeasite,g_dbea_m.dbeadocdt, 
          g_dbea_m.dbeadocno,g_dbea_m.dbeaunit,g_dbea_m.dbea001,g_dbea_m.dbea002,g_dbea_m.dbea003,g_dbea_m.dbeastus, 
          g_dbea_m.dbeaownid,g_dbea_m.dbeaowndp,g_dbea_m.dbeacrtid,g_dbea_m.dbeacrtdp,g_dbea_m.dbeacrtdt, 
          g_dbea_m.dbeamodid,g_dbea_m.dbeamoddt,g_dbea_m.dbeacnfid,g_dbea_m.dbeacnfdt,g_dbea_m.dbeasite_desc, 
          g_dbea_m.dbea002_desc,g_dbea_m.dbea003_desc,g_dbea_m.dbeaownid_desc,g_dbea_m.dbeaowndp_desc, 
          g_dbea_m.dbeacrtid_desc,g_dbea_m.dbeacrtdp_desc,g_dbea_m.dbeamodid_desc,g_dbea_m.dbeacnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_dbea_m.dbeasite,g_dbea_m.dbeasite_desc,g_dbea_m.dbeadocdt,g_dbea_m.dbeadocno, 
          g_dbea_m.dbeaunit,g_dbea_m.dbea001,g_dbea_m.dbea002,g_dbea_m.dbea002_desc,g_dbea_m.dbea003, 
          g_dbea_m.dbea003_desc,g_dbea_m.dbeastus,g_dbea_m.dbeaownid,g_dbea_m.dbeaownid_desc,g_dbea_m.dbeaowndp, 
          g_dbea_m.dbeaowndp_desc,g_dbea_m.dbeacrtid,g_dbea_m.dbeacrtid_desc,g_dbea_m.dbeacrtdp,g_dbea_m.dbeacrtdp_desc, 
          g_dbea_m.dbeacrtdt,g_dbea_m.dbeamodid,g_dbea_m.dbeamodid_desc,g_dbea_m.dbeamoddt,g_dbea_m.dbeacnfid, 
          g_dbea_m.dbeacnfid_desc,g_dbea_m.dbeacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE adbt700_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adbt700_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adbt700.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION adbt700_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_dbed_d.getLength() THEN
         LET g_detail_idx = g_dbed_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_dbed_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_dbed_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_dbed2_d.getLength() THEN
         LET g_detail_idx = g_dbed2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_dbed2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_dbed2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_dbed3_d.getLength() THEN
         LET g_detail_idx2 = g_dbed3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_dbed3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_dbed3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adbt700_b_fill2(pi_idx)
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
   
   IF adbt700_fill_chk(3) THEN
      IF (pi_idx = 3 OR pi_idx = 0 ) AND g_dbed2_d.getLength() > 0 THEN
               CALL g_dbed3_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[2]
         
         LET g_sql = "SELECT  DISTINCT dbec002,dbec003,dbec004,dbec005,dbec006,dbec007,dbec008,dbec009, 
             dbec010,dbec011,dbec012,dbec013,dbec014,dbec015,dbecsite,dbecunit ,t6.oocal003 ,t7.oocal003 FROM dbec_t", 
                 
                     "",
                                    " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=dbec006 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=dbec008 AND t7.oocal002='"||g_dlang||"' ",
 
                     " WHERE dbecent=? AND dbecdocno=? AND dbec001=?"
         
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  dbec_t.dbec002" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill3"
         
         #end add-point
         
         #先清空資料
               CALL g_dbed3_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE adbt700_pb3 FROM g_sql
         DECLARE b_fill_curs3 CURSOR FOR adbt700_pb3
         
      #  OPEN b_fill_curs3 USING g_enterprise,g_dbea_m.dbeadocno,g_dbed2_d[g_detail_idx].dbeb001   #(ver:78) 
 
         LET l_ac = 1
         FOREACH b_fill_curs3 USING g_enterprise,g_dbea_m.dbeadocno,g_dbed2_d[g_detail_idx].dbeb001 INTO g_dbed3_d[l_ac].dbec002, 
             g_dbed3_d[l_ac].dbec003,g_dbed3_d[l_ac].dbec004,g_dbed3_d[l_ac].dbec005,g_dbed3_d[l_ac].dbec006, 
             g_dbed3_d[l_ac].dbec007,g_dbed3_d[l_ac].dbec008,g_dbed3_d[l_ac].dbec009,g_dbed3_d[l_ac].dbec010, 
             g_dbed3_d[l_ac].dbec011,g_dbed3_d[l_ac].dbec012,g_dbed3_d[l_ac].dbec013,g_dbed3_d[l_ac].dbec014, 
             g_dbed3_d[l_ac].dbec015,g_dbed3_d[l_ac].dbecsite,g_dbed3_d[l_ac].dbecunit,g_dbed3_d[l_ac].dbec006_desc, 
             g_dbed3_d[l_ac].dbec008_desc   #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill3"
            
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
               CALL g_dbed3_d.deleteElement(g_dbed3_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_dbed3_d_mask_o.* =  g_dbed3_d.*
   FOR l_ac = 1 TO g_dbed3_d.getLength()
      LET g_dbed3_d_mask_o[l_ac].* =  g_dbed3_d[l_ac].*
      CALL adbt700_dbec_t_mask()
      LET g_dbed3_d_mask_n[l_ac].* =  g_dbed3_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL adbt700_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION adbt700_fill_chk(ps_idx)
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
 
{<section id="adbt700.status_show" >}
PRIVATE FUNCTION adbt700_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adbt700.mask_functions" >}
&include "erp/adb/adbt700_mask.4gl"
 
{</section>}
 
{<section id="adbt700.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION adbt700_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success  LIKE type_t.num5

   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL adbt700_show()
   CALL adbt700_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_adbt700_conf_chk(g_dbea_m.dbeadocno,g_dbea_m.dbeastus) RETURNING l_success
   IF NOT l_success THEN
      CLOSE adbt700_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_dbea_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_dbed_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_dbed2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_dbed3_d))
 
 
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
   #CALL adbt700_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL adbt700_ui_headershow()
   CALL adbt700_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION adbt700_draw_out()
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
   CALL adbt700_ui_headershow()  
   CALL adbt700_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="adbt700.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION adbt700_set_pk_array()
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
   LET g_pk_array[1].values = g_dbea_m.dbeadocno
   LET g_pk_array[1].column = 'dbeadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adbt700.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="adbt700.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION adbt700_msgcentre_notify(lc_state)
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
   CALL adbt700_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_dbea_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adbt700.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION adbt700_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#7 -s by 08172
   SELECT dbeastus  INTO g_dbea_m.dbeastus
     FROM dbea_t
    WHERE dbeaent = g_enterprise
      AND dbeadocno = g_dbea_m.dbeadocno
   LET g_errno = ''
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_dbea_m.dbeastus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_dbea_m.dbeadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL adbt700_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#7 -e by 08172
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adbt700.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 檢查組織+出貨日期有無重複在配送排車計畫單
# Memo...........:
# Usage..........: CALL adbt700_org_and_date_rep_chk(p_process,p_cmd,p_org_id,p_err_pop)
#                  RETURNING r_success
# Input Parameter: p_process   檢查對象：1.配送組織(dbeasite) 
#                                       2.發貨組織(dbed001)
#                  p_cmd       操作狀態
#                  p_org_id    組織編號
#                  p_err_pop   錯誤訊息是否開窗
# Return code....: r_success
# Date & Author..: 2014/07/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt700_org_and_date_rep_chk(p_process,p_cmd,p_org_id,p_err_pop)
   DEFINE p_process   LIKE type_t.num5
   DEFINE p_cmd       LIKE type_t.chr10
   DEFINE p_org_id    LIKE ooef_t.ooef001
   DEFINE p_err_pop   LIKE type_t.num5   #1.TRUE  0.FALSE
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_errno     STRING
   DEFINE l_sql       STRING
   
   LET r_success = TRUE
   LET l_cnt = ''
   LET l_errno = ''
   LET l_sql = NULL
   
   CASE p_process
      WHEN 1   #1.配送組織(dbea001) 
         #配送組織(%1)在出貨日期(%2)已有配送排車單，不可重複！
         LET l_errno = 'adb-00234'
         LET l_sql = " SELECT COUNT(*) ",
                     "  FROM dbea_t ",
                     " WHERE dbeaent = ", g_enterprise,
                     "   AND dbeasite = '",p_org_id,"' ",
                     "   AND dbea001 = '",g_dbea_m.dbea001,"' ",
                     "   AND dbeastus <> 'X' "
         IF p_cmd = 'u' THEN                     
            LET l_sql = l_sql," AND dbeadocno <> ' ",g_dbea_m.dbeadocno,"' "
         END IF   

      WHEN 2   #2.發貨組織(dbed001)   
         #發貨組織(%1)在出貨日期(%2)已有配送排車單，不可重複！
         LET l_errno = 'adb-00291'
         LET l_sql = " SELECT COUNT(*) ",
                     "  FROM dbed_t,dbea_t ",
                     " WHERE dbedent = dbeaent ",
                     "   AND dbeddocno = dbeadocno ",
                     "   AND dbea001 = '",g_dbea_m.dbea001,"' ",
                     "   AND dbed001 = '",p_org_id,"' ",
                     "   AND dbeastus <> 'X' ",   
                     "   AND dbeddocno <> '",g_dbea_m.dbeadocno,"' "
   END CASE
 
   #DISPLAY "Dup. sql: ",l_sql
   PREPARE adbt700_dup_chk FROM l_sql
   EXECUTE adbt700_dup_chk INTO l_cnt
   IF SQLCA.sqlcode > 0 THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = p_err_pop
      CALL cl_err()         
   END IF   
   
   IF l_cnt > 0 THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = l_errno
      LET g_errparam.popup  = p_err_pop
      LET g_errparam.replace[1] = p_org_id
      LET g_errparam.replace[2] = g_dbea_m.dbea001
      CALL cl_err()         
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 配送組織校驗
# Memo...........: 1.檢查配送組織是否符合aooi500設定
#                  2.檢查配送組織+出貨日期有無重複在配送排車計畫單
# Usage..........: CALL adbt700_dbeasite_chk(p_cmd)
#                  RETURNING r_success
# Input parameter: p_cmd     單身操作狀態
# Return code....: r_success
# Date & Author..: 2014/07/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt700_dbeasite_chk(p_cmd)
   DEFINE p_cmd       LIKE type_t.chr10
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_errno     STRING
   
   LET r_success = TRUE
   
   #1.檢查配送組織是否符合aooi500設定
   CALL s_aooi500_chk(g_prog,'dbeasite',g_dbea_m.dbeasite,g_dbea_m.dbeasite) 
   RETURNING l_success,l_errno
   IF NOT l_success THEN
      LET r_success = FALSE
      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = l_errno
      LET g_errparam.popup  = TRUE
      CALL cl_err()   

      RETURN r_success
   END IF
   
   #2.檢查配送組織+出貨日期有無重複在配送排車計畫單
   IF NOT cl_null(g_dbea_m.dbea001) THEN
      IF NOT adbt700_org_and_date_rep_chk(1,p_cmd,g_dbea_m.dbeasite,TRUE) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 依預排人員自動帶出該員的部門
# Memo...........:
# Usage..........: CALL adbt700_dbea003_default()
# Date & Author..: 2014/07/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt700_dbea003_default()
   #帶出歸屬部門ooag003
   SELECT ooag003 INTO g_dbea_m.dbea003
     FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_dbea_m.dbea002
      
   LET g_dbea_m.dbea003_desc = s_desc_get_department_desc(g_dbea_m.dbea003)
   DISPLAY BY NAME g_dbea_m.dbea003,g_dbea_m.dbea003_desc
END FUNCTION

################################################################################
# Descriptions...: 計算配送資訊的計畫承載容積/體積
# Memo...........:
# Usage..........: CALL adbt700_dbeb_amount(p_cmd)
#                  RETURNING r_success
# Input parameter: p_cmd       操作指令 1.AFTER INSERT/ON ROW CHANGE/BEFORE FIELD
#                                      2.AFTRT FIELD dbec003
# Return Code....: r_success
# Date & Author..: 2014/08/13 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt700_dbeb_amount(p_cmd)
   DEFINE r_success    LIKE type_t.num5
   DEFINE p_cmd        LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_dbeb004    LIKE dbeb_t.dbeb004
   DEFINE l_dbeb007    LIKE dbeb_t.dbeb007  
   DEFINE l_dbeb_idx   LIKE type_t.num5
   DEFINE l_dbec_idx   LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_dbeb004 = 0 
   LET l_dbeb007 = 0
   LET l_dbeb_idx = g_detail_idx   #g_curr_diag.getCurrentRow("s_detail2")
   LET l_dbec_idx = g_detail_idx2  #g_curr_diag.getCurrentRow("s_detail3")
   
   DISPLAY "idx: ",g_detail_idx,"  idx2: ",g_detail_idx2
   #IF l_dbeb_idx = 0 THEN
   #   LET l_dbeb_idx = 1 
   #END IF
   #
   #IF l_dbec_idx = 0 THEN
   #   LET l_dbec_idx = 1 
   #END IF
   
   LET l_sql = "SELECT COALESCE(SUM(dbec005),0),COALESCE(SUM(dbec007),0) ",                
               "  FROM dbec_t ",
               " WHERE dbecent = ",g_enterprise,
               "   AND dbecdocno = '",g_dbea_m.dbeadocno,"' ",
               "   AND dbec001 = '",g_dbed2_d[l_dbeb_idx].dbeb001,"' "
   IF p_cmd = 2 THEN
      LET l_sql = l_sql, " AND dbec003 <> '",g_dbed3_d[l_dbec_idx].dbec002,"' "
   END IF
   
   PREPARE adbt700_amount FROM l_sql   
   EXECUTE adbt700_amount INTO l_dbeb004,l_dbeb007
   IF SQLCA.SQLcode  THEN
      LET r_success = FALSE
      
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dbeb_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   IF p_cmd = 2 THEN
      LET l_dbeb004 = l_dbeb004 + g_dbed3_d[l_dbec_idx].dbec005
      LET l_dbeb007 = l_dbeb007 + g_dbed3_d[l_dbec_idx].dbec007
   END IF
   
   UPDATE dbeb_t
      SET dbeb004 = l_dbeb004,
          dbeb007 = l_dbeb007
    WHERE dbebent = g_enterprise
      AND dbebdocno = g_dbea_m.dbeadocno
      AND dbeb001 = g_dbed2_d[l_dbeb_idx].dbeb001      
   IF SQLCA.SQLcode  THEN
      LET r_success = FALSE
      
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dbeb_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   ELSE      
      LET g_dbed2_d[l_dbeb_idx].dbeb004 = l_dbeb004
      LET g_dbed2_d[l_dbeb_idx].dbeb007 = l_dbeb007
      DISPLAY l_dbeb004 TO g_dbed2_d[l_dbeb_idx].dbeb004
      DISPLAY l_dbeb007 TO g_dbed2_d[l_dbeb_idx].dbeb007      
   END IF 
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 車輛校驗
# Memo...........:
# Usage..........: CALL adbt700_dbec003_chk()
#                  RETURNING r_success
# Return code....: r_success   校驗結果
# Date & Author..: 2014/07/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt700_dbec003_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_rep_flag  LIKE type_t.chr1
   DEFINE l_cnt       LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_rep_flag = ''
   LET l_cnt = 0 
   
   SELECT COUNT(*) INTO l_cnt
     FROM dbec_t
    WHERE dbecent = g_enterprise
      AND dbecdocno = g_dbea_m.dbeadocno 
      AND dbec003 = g_dbed3_d[l_ac].dbec003     
   IF l_cnt > 0 THEN
      #車輛編號已存在於本單，不可重複！
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_dbed3_d[l_ac].dbec003
      LET g_errparam.code   = 'adb-00369'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE   
      RETURN r_success         
   END IF   
   
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_dbed3_d[l_ac].dbec003
   LET g_chkparam.arg2 = g_dbea_m.dbeasite
   #160318-00025#24  by 07900 --add-str
   LET g_errshow = TRUE #是否開窗                   
   LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
   #160318-00025#24  by 07900 --add-end  
   IF cl_chk_exist("v_mrba001_9") THEN
      SELECT UNIQUE 'Y'
        INTO l_rep_flag
        FROM dbec_t,dbeb_t,dbea_t
       WHERE dbecent = dbebent AND dbecdocno = dbebdocno AND dbec001 = dbec001
         AND dbebent = dbeaent AND dbebdocno = dbeadocno
         AND dbeasite = g_dbea_m.dbeasite
         AND dbea001 = g_dbea_m.dbea001         
         AND dbeastus <> 'X'
         AND dbeb001 <> g_dbed2_d[g_detail_idx].dbeb001
         AND dbec003 = g_dbed3_d[l_ac].dbec003       
      IF l_rep_flag = 'Y' THEN
         #車輛不可在同一配送組織+送貨日期中重複！
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 'adb-00236'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE           
      END IF
   ELSE
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 時間欄位檢核
# Memo...........: 備貨時間<到達時間<裝車時間<發車時間<回程時間
# Usage..........: CALL adbt700_time_chk(p_point)
#                  RETURNING r_success  
# Input parameter: p_point   時間欄位：1.備貨時間
#                                     2.到達時間
#                                     3.裝車時間
#                                     4.發車時間
#                                     5.回程時間
# Return Code....: r_success 校驗結果
# Date & Author..: 2014/07/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt700_time_chk(p_point)
   DEFINE p_point   LIKE type_t.num5
   DEFINE r_success LIKE type_t.num5
   DEFINE l_err     LIKE type_t.chr1
   DEFINE l_msg     LIKE type_t.chr10
   DEFINE l_time1   LIKE type_t.chr30
   DEFINE l_time2   LIKE type_t.chr30
   
   LET r_success = TRUE
   LET l_msg = ''
   LET l_time1 = ''
   LET l_time2 = ''
   
   CASE p_point 
      WHEN 1    #備貨時間-------------------------------------------------------------------------------------
         LET l_err = ''
         LET l_time1 = cl_getmsg('adb-00239',g_lang)         
         LET l_msg = 'adb-00237' #%1不可晚於%2  
         CASE 
            WHEN NOT cl_null(g_dbed3_d[l_ac].dbec010) AND g_dbed3_d[l_ac].dbec009 >= g_dbed3_d[l_ac].dbec010 
               LET l_time2 = cl_getmsg('adb-00240',g_lang)
               LET l_err = 'Y'
            WHEN NOT cl_null(g_dbed3_d[l_ac].dbec011) AND g_dbed3_d[l_ac].dbec009 >= g_dbed3_d[l_ac].dbec011 
               LET l_time2 = cl_getmsg('adb-00241',g_lang)
               LET l_err = 'Y'
            WHEN NOT cl_null(g_dbed3_d[l_ac].dbec012) AND g_dbed3_d[l_ac].dbec009 >= g_dbed3_d[l_ac].dbec012 
               LET l_time2 = cl_getmsg('adb-00242',g_lang)
               LET l_err = 'Y'
            WHEN NOT cl_null(g_dbed3_d[l_ac].dbec013) AND g_dbed3_d[l_ac].dbec009 >= g_dbed3_d[l_ac].dbec013 
               LET l_time2 = cl_getmsg('adb-00243',g_lang)
               LET l_err = 'Y'
         END CASE
      WHEN 2    #到達時間-------------------------------------------------------------------------------------
         LET l_err = ''
         LET l_time1 = cl_getmsg('adb-00240',g_lang)
         LET l_msg = 'adb-00237'
         CASE 
           WHEN NOT cl_null(g_dbed3_d[l_ac].dbec011) AND g_dbed3_d[l_ac].dbec010 >= g_dbed3_d[l_ac].dbec011 
               LET l_time2 = cl_getmsg('adb-00241',g_lang)
               LET l_err = 'Y'
            WHEN NOT cl_null(g_dbed3_d[l_ac].dbec012) AND g_dbed3_d[l_ac].dbec010 >= g_dbed3_d[l_ac].dbec012
               LET l_time2 = cl_getmsg('adb-00242',g_lang)
               LET l_err = 'Y'
            WHEN NOT cl_null(g_dbed3_d[l_ac].dbec013) AND g_dbed3_d[l_ac].dbec010 >= g_dbed3_d[l_ac].dbec013
               LET l_time2 = cl_getmsg('adb-00243',g_lang)
               LET l_err = 'Y'
         END CASE      
       
         IF cl_null(l_err) THEN
            IF NOT cl_null(g_dbed3_d[l_ac].dbec009) AND g_dbed3_d[l_ac].dbec009 >= g_dbed3_d[l_ac].dbec010 THEN
               LET l_time2 = cl_getmsg('adb-00239',g_lang)
               LET l_msg = 'adb-00238'   #%1不可早於%2
               LET l_err = 'Y'
            END IF   
         END IF
      WHEN 3    #裝車時間-------------------------------------------------------------------------------------
         LET l_err = ''
         LET l_time1 = cl_getmsg('adb-00241',g_lang)
         LET l_msg = 'adb-00237'
         CASE 
           WHEN NOT cl_null(g_dbed3_d[l_ac].dbec012) AND g_dbed3_d[l_ac].dbec011 >= g_dbed3_d[l_ac].dbec012 
               LET l_time2 = cl_getmsg('adb-00242',g_lang)
               LET l_err = 'Y'
            WHEN NOT cl_null(g_dbed3_d[l_ac].dbec013) AND g_dbed3_d[l_ac].dbec011 >= g_dbed3_d[l_ac].dbec013
               LET l_time2 = cl_getmsg('adb-00243',g_lang)
               LET l_err = 'Y'
         END CASE   

         IF cl_null(l_err) THEN
            LET l_msg = 'adb-00238'
            CASE
               WHEN NOT cl_null(g_dbed3_d[l_ac].dbec009) AND g_dbed3_d[l_ac].dbec009 >= g_dbed3_d[l_ac].dbec011 
                  LET l_time2 = cl_getmsg('adb-00239',g_lang)
                  LET l_err = 'Y'
               WHEN NOT cl_null(g_dbed3_d[l_ac].dbec010) AND g_dbed3_d[l_ac].dbec010 >= g_dbed3_d[l_ac].dbec011 
                  LET l_time2 = cl_getmsg('adb-00240',g_lang)
                  LET l_err = 'Y'                  
            END CASE   
         END IF
      WHEN 4    #發車時間-------------------------------------------------------------------------------------
         LET l_err = ''
         LET l_time1 = cl_getmsg('adb-00242',g_lang)
         LET l_msg = 'adb-00237'
         IF NOT cl_null(g_dbed3_d[l_ac].dbec013) AND g_dbed3_d[l_ac].dbec012 >= g_dbed3_d[l_ac].dbec013 THEN
            LET l_time2 = cl_getmsg('adb-00243',g_lang)
            LET l_err = 'Y'
         END IF

         IF cl_null(l_err) THEN
            LET l_msg = 'adb-00238'  
            CASE
               WHEN NOT cl_null(g_dbed3_d[l_ac].dbec009) AND g_dbed3_d[l_ac].dbec009 >= g_dbed3_d[l_ac].dbec012 
                  LET l_time2 = cl_getmsg('adb-00239',g_lang)
                  LET l_err = 'Y'
               WHEN NOT cl_null(g_dbed3_d[l_ac].dbec010) AND g_dbed3_d[l_ac].dbec010 >= g_dbed3_d[l_ac].dbec012 
                  LET l_time2 = cl_getmsg('adb-00240',g_lang)
                  LET l_err = 'Y' 
               WHEN NOT cl_null(g_dbed3_d[l_ac].dbec011) AND g_dbed3_d[l_ac].dbec011 >= g_dbed3_d[l_ac].dbec012 
                   LET l_time2 = cl_getmsg('adb-00241',g_lang)
                   LET l_err = 'Y'                  
            END CASE   
         END IF      
      WHEN 5    #回程時間-------------------------------------------------------------------------------------
         LET l_err = ''
         LET l_time1 = cl_getmsg('adb-00243',g_lang)
         LET l_msg = 'adb-00238'
         CASE 
            WHEN NOT cl_null(g_dbed3_d[l_ac].dbec009) AND g_dbed3_d[l_ac].dbec009 >= g_dbed3_d[l_ac].dbec013 
               LET l_time2 = cl_getmsg('adb-00239',g_lang)
               LET l_err = 'Y'
            WHEN NOT cl_null(g_dbed3_d[l_ac].dbec010) AND g_dbed3_d[l_ac].dbec010 >= g_dbed3_d[l_ac].dbec013 
               LET l_time2 = cl_getmsg('adb-00240',g_lang)
               LET l_err = 'Y'
            WHEN NOT cl_null(g_dbed3_d[l_ac].dbec011) AND g_dbed3_d[l_ac].dbec011 >= g_dbed3_d[l_ac].dbec013 
               LET l_time2 = cl_getmsg('adb-00241',g_lang)
               LET l_err = 'Y'
            WHEN NOT cl_null(g_dbed3_d[l_ac].dbec012) AND g_dbed3_d[l_ac].dbec012 >= g_dbed3_d[l_ac].dbec013 
               LET l_time2 = cl_getmsg('adb-00242',g_lang)
               LET l_err = 'Y'
         END CASE  
   END CASE
   
   IF l_err = 'Y'  THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = l_msg
      LET g_errparam.popup  = TRUE
      LET g_errparam.replace[1] = l_time1
      LET g_errparam.replace[2] = l_time2
      CALL cl_err() 
   END IF   
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 計算發貨組織範圍
# Memo...........: 用於判斷有無資料存在, 後續有無需要刪除或進行其他控制
# Usage..........: CALL adbt700_dbed_cnt()
#                  RETURNING r_cnt
# Return code....: r_cnt   計算筆數
# Date & Author..: 2014/07/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt700_dbed_cnt()
   DEFINE r_cnt   LIKE type_t.num5
   
   LET r_cnt = 0 
   SELECT COUNT(*) INTO r_cnt
     FROM dbed_t
    WHERE dbedent = g_enterprise
      AND dbeddocno = g_dbea_m.dbeadocno
   
   IF r_cnt = 0 THEN
      LET r_cnt = g_dbed_d.getLength()
   END IF
   
   RETURN r_cnt   
END FUNCTION

################################################################################
# Descriptions...: 發貨組織校驗
# Memo...........: 檢查發貨組織+出貨日期有無重複在配送排車計畫單
# Usage..........: CALL adbt700_dbed001_chk(p_cmd,p_dbed001,p_err_pop)
#                  RETURNING r_success
# Input parameter: p_cmd       單身操作狀態
#                  p_dbed001   發貨組織
#                  p_err_pop   錯誤訊息是否彈窗顯示
# Return code....: r_success
# Date & Author..: 2014/07/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt700_dbed001_chk(p_cmd,p_dbed001,p_err_pop)
   DEFINE p_cmd       LIKE type_t.chr10
   DEFINE p_dbed001   LIKE dbed_t.dbed001
   DEFINE p_err_pop   LIKE type_t.num5   #1.TRUE  0.FALSE
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_errno     STRING

   LET r_success = TRUE
   
   IF s_aooi500_setpoint(g_prog,'dbed001') THEN
      CALL s_aooi500_chk(g_prog,'dbed001',p_dbed001,g_dbea_m.dbeasite) RETURNING l_success,l_errno
      IF NOT l_success THEN
         LET r_success = FALSE
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = p_dbed001
         LET g_errparam.popup  = TRUE 
         CALL cl_err()  
                     
         RETURN r_success
      END IF
   ELSE
      IF p_dbed001 <> g_site THEN
         LET r_success = FALSE
         #作業組織應用未設定，發貨組織須為當前營運組織！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adb-00396'
         LET g_errparam.extend = p_dbed001
         LET g_errparam.popup  = TRUE 
         CALL cl_err()  
                     
         RETURN r_success      
      END IF
   END IF
   
   IF NOT adbt700_org_and_date_rep_chk(2,p_cmd,p_dbed001,p_err_pop) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF   
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生配送訊息前檢核與處理
# Memo...........:
# Usage..........: CALL adbt700_before_ins_dbeb()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2014/07/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt700_before_ins_dbeb()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE l_cnt       LIKE type_t.num5   
   
   LET r_success = TRUE
   
   #檢查有無單號
   IF cl_null(g_dbea_m.dbeadocno) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 'adb-00078'
      LET g_errparam.popup  = TRUE
      CALL cl_err() 
   END IF
   
   #檢查有無發貨組織範圍
   LET l_cnt = adbt700_dbed_cnt()
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 'adb-00244'
      LET g_errparam.popup  = TRUE
      CALL cl_err()  
       LET r_success = FALSE   #160819-00019#1 160824 by lori add      
      RETURN r_success         #160819-00019#1 160824 by lori mod
   END IF 

   #檢查有無已存在的配送資訊
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM dbeb_t
    WHERE dbebent = g_enterprise
      AND dbebdocno = g_dbea_m.dbeadocno
   IF l_cnt > 0 THEN
      IF cl_ask_confirm('adb-00255') THEN
         CALL s_transaction_begin()
         
         DELETE FROM dbeb_t
          WHERE dbebent = g_enterprise
            AND dbebdocno = g_dbea_m.dbeadocno
         IF SQLCA.sqlcode THEN   
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbeb_t" 
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE         
            CALL s_transaction_end('N',0)
            RETURN r_success
         ELSE
            CALL s_transaction_end('Y',0)
         END IF    
      END IF         
   END IF 
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生配送資訊
# Memo...........:
# Usage..........: CALL adbt700_auto_ins_dbeb()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2014/07/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt700_auto_ins_dbeb()
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_tmp      RECORD
      seq            LIKE type_t.num5,      #項次
      slip           LIKE type_t.chr10,     #單據類型
      docno          LIKE xmdk_t.xmdkdocno, #單號
      docseq         LIKE xmdl_t.xmdlseq,   #單據項次
      route          LIKE xmdk_t.xmdk205,   #路線
      point          LIKE dbab_t.dbab002,   #裝載點
      volume         LIKE imaa_t.imaa025,   #體積
      volume_unit    LIKE imaa_t.imaa026,   #體積單位
      inv_unit       LIKE imaf_t.imaf053,   #據點庫存單位
      qty            LIKE xmdl_t.xmdl018,   #數量
      packing_unit   LIKE xmdl_t.xmdl204,   #包裝單位
      weight         LIKE imaa_t.imaa016,   #毛重
      weight_unit    LIKE imaa_t.imaa018,   #重量單位
      item           LIKE imaa_t.imaa001,   #料件編號
      volume_qty     LIKE xmdl_t.xmdl018,   #承載容積數
      weight_qty     LIKE xmdl_t.xmdl018    #承載重量      
                 END RECORD
   DEFINE l_inv_qty       LIKE xmdl_t.xmdl018   #換算後庫存單位的數量
   DEFINE l_volume_para   LIKE type_t.chr30     #容積單位參數
   DEFINE l_weight_para   LIKE type_t.chr30     #重量單位參數
  #DEFINE l_volume_rate   LIKE type_t.num20_6   #sakura mark
  #DEFINE l_weight_rate   LIKE type_t.num20_6   #sakura mark
   DEFINE l_volume_qty    LIKE imaa_t.imaa025   #sakura add
   DEFINE l_weight_qty    LIKE imaa_t.imaa016   #sakura add  
   DEFINE l_sql           STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_err_cnt       LIKE type_t.num5
   DEFINE l_suc_cnt       LIKE type_t.num5
   DEFINE l_slip_type     STRING
   DEFINE l_imaal003      LIKE imaal_t.imaal003
   DEFINE l_imaal004      LIKE imaal_t.imaal004
   DEFINE l_colname_1     STRING
   DEFINE l_colname_2     STRING
   DEFINE l_comment_1     STRING
   DEFINE l_comment_2     STRING
   DEFINE l_cnt           LIKE type_t.num5
   
   SELECT COUNT(*) INTO l_cnt FROM adbt700_tmp
   IF l_cnt > 0 THEN
      DELETE FROM adbt700_tmp
   END IF
   
   LET r_success = TRUE
   
   CALL cl_err_collect_init()
   
   LET g_coll_title[1] = cl_getmsg('adb-00378',g_lang)   #單據類型
#   LET g_coll_title[2] = cl_getmsg('anm-00223',g_lang)  
   LET g_coll_title[2] = cl_getmsg('aap-00153',g_lang)   #單據編號 #160318-00005#7 mod
  
   LET g_coll_title[3] = cl_getmsg('anm-00225',g_lang)   #項次
   LET g_coll_title[4] = cl_getmsg('adb-00383',g_lang)   #商品編號
   LET g_coll_title[5] = cl_getmsg('adb-00384',g_lang)   #品名
   LET g_coll_title[6] = cl_getmsg('adb-00385',g_lang)   #規格
   
   #0.取參數資料
   LET l_volume_para = cl_get_para(g_enterprise,g_site,'E-CIR-0012')  
   LET l_weight_para = cl_get_para(g_enterprise,g_site,'E-CIR-0013') 
   
   #1.取配送資訊來源
   #1.1.來源：出貨單
   LET l_sql = "INSERT INTO adbt700_tmp ",
               "     SELECT (ROW_NUMBER() OVER (ORDER BY xmdl008))+(SELECT COUNT(*) FROM adbt700_tmp) , ", #暫存檔項次
               "            '1',xmdkdocno,xmdlseq, ",                                                      #單據類型/單號/項次
               "            xmdk206,dbab002,imaa025,imaa026,imaf053,xmdl018, ",                            #路線/裝載點/體積/體積單位/據點庫存單位/數量
               "            xmdl204,imaa016,imaa018,xmdl008,0,0 ",                                         #包裝單位/毛重/重量單位/料件編號
               "       FROM xmdl_t, ",
               "            xmdk_t LEFT OUTER JOIN dbab_t ON xmdkent = dbabent AND xmdk206 = dbab001, ",
               "            imaa_t LEFT OUTER JOIN imaf_t ON imaaent = imafent AND imaa001 = imaf001 AND imafsite = 'ALL' ",
               "      WHERE xmdlent = xmdkent ",
               "        AND xmdldocno = xmdkdocno ",
               "        AND xmdlent = imaaent ",
               "        AND xmdl008 = imaa001 ",
               "        AND xmdkent = ",g_enterprise,
               "        AND xmdkstus IN ('Y','S') ",
               "        AND xmdk000 = '1' ",
               "        AND xmdkdocdt = '",g_dbea_m.dbea001,"' ",   #20150213 調整為單據日期=出貨日期
               "        AND xmdk002 IN ('1','2','3') ",
               "        AND EXISTS (SELECT dbed001 FROM dbed_t WHERE dbedent = xmdkent AND dbed001 = xmdksite) "
   PREPARE adbt700_ins_tmp_pre1 FROM l_sql
   EXECUTE adbt700_ins_tmp_pre1
   DISPLAY "Insert adbt700_tmp FROM Shipping Doc.: ",l_sql   
   IF SQLCA.sqlcode THEN   
      LET r_success = FALSE
      
      DISPLAY "Insert adbt700_tmp FROM Shipping Doc. Error!"
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "adbt700_tmp" 
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      
      RETURN r_success
   END IF       
   #1.2.來源：調撥單
   LET l_sql = "INSERT INTO adbt700_tmp ",
               "     SELECT (ROW_NUMBER() OVER (ORDER BY indd002)) + (SELECT COUNT(*) FROM adbt700_tmp) , " ,#暫存檔項次
               "            '2',indcdocno,inddseq, ",            
               "            dbaf001,dbab002,imaa025,imaa026,imaf053,indd021, ",
               "            indd006,imaa016,imaa018,indd002,0,0 ",
               "       FROM indd_t, ",
               "            indc_t, ",
               "            ooef_t LEFT OUTER JOIN (SELECT oofb002,dbafent,dbaf001,dbab002 ",
               "                                      FROM oofb_t, dbaf_t, dbab_t ",
               "                                     WHERE oofbent = dbafent AND oofb022 = dbaf003 ",
               "                                       AND dbafent = dbabent AND dbaf001 = dbab001 ",
               "                                       AND oofb008 = '3'     AND oofb010 = 'Y' ",
               "                                       AND oofbstus = 'Y' ",
               "                                       AND dbaf002 = '1'     AND dbafstus = 'Y' ",
               "                                       AND dbabstus = 'Y') ",
               "                                ON ooefent = dbafent AND ooef012 = oofb002, ",
               "            imaa_t LEFT OUTER JOIN imaf_t ON imaaent = imafent AND imaa001 = imaf001 AND imafsite = 'ALL' ",
               "      WHERE inddent = indcent ",
               "        AND indddocno = indcdocno ",
               "        AND indcent = ooefent ",
               "        AND indc006 = ooef001 ",
               "        AND inddent = imaaent ",
               "        AND indd002 = imaa001 ", 
               "        AND inddent = ",g_enterprise,               
               "        AND indcstus = 'N' ",
               "        AND indcdocdt = '",g_dbea_m.dbea001,"' ",
               "        AND EXISTS (SELECT dbed001 FROM dbed_t WHERE dbedent = indcent AND dbed001 = indc005) "
   PREPARE adbt700_ins_tmp_pre2 FROM l_sql
   EXECUTE adbt700_ins_tmp_pre2
   DISPLAY "Insert adbt700_tmp FROM Moving Doc.: ",l_sql
   IF SQLCA.sqlcode THEN   
      LET r_success = FALSE
      
      DISPLAY "Insert adbt700_tmp FROM Moving Doc. Error!"
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "adbt700_tmp" 
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      
      RETURN r_success
   END IF   
   #2.單位換算
   LET l_err_cnt = 0   
   LET l_sql = "SELECT seq,slip,docno,docseq,route, ",
               "       point,volume,volume_unit,inv_unit,qty, ",    
               "       packing_unit,weight,weight_unit,item,imaal003, ",
               "       imaal004 ",
               "  FROM adbt700_tmp ",
               "       LEFT OUTER JOIN imaal_t ON imaalent = ",g_enterprise," AND item = imaal001 "
   PREPARE adbt700_sel_tmp_pre FROM l_sql
   DECLARE adbt700_sel_tmp_cur CURSOR FOR adbt700_sel_tmp_pre
   FOREACH adbt700_sel_tmp_cur INTO l_tmp.seq,         l_tmp.slip,  l_tmp.docno,      l_tmp.docseq,  l_tmp.route,
                                    l_tmp.point,       l_tmp.volume,l_tmp.volume_unit,l_tmp.inv_unit,l_tmp.qty,
                                    l_tmp.packing_unit,l_tmp.weight,l_tmp.weight_unit,l_tmp.item,    l_imaal003,
                                    l_imaal004                                    
                                    
      IF SQLCA.sqlcode THEN   
         LET r_success = FALSE
         
         DISPLAY "Select adbt700_tmp Error!"
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "foreach:adbt700_sel_tmp_cur_tmp" 
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         RETURN r_success
      END IF
      
      LET l_success = ''
      LET l_inv_qty = 0
     #LET l_volume_rate = 0 #sakura mark
     #LET l_weight_rate = 0 #sakura mark
      LET l_volume_qty = 0  #sakura add
      LET l_weight_qty = 0  #sakura add
      CASE l_tmp.slip 
         WHEN '1'   LET l_slip_type = cl_getmsg('adb-00379',g_lang)
         WHEN '2'   LET l_slip_type = cl_getmsg('adb-00380',g_lang)
      END CASE  

      INITIALIZE g_errparam TO NULL 
      LET g_errparam.popup  = TRUE
      LET g_errparam.coll_vals[1] = l_slip_type
      LET g_errparam.coll_vals[2] = l_tmp.docno
      LET g_errparam.coll_vals[3] = l_tmp.docseq
      LET g_errparam.coll_vals[4] = l_tmp.item
      LET g_errparam.coll_vals[5] = l_imaal003
      LET g_errparam.coll_vals[6] = l_imaal004
      
      IF cl_null(l_tmp.item) THEN
         LET l_err_cnt = l_err_cnt + 1
         LET g_errparam.extend = l_tmp.slip
         LET g_errparam.code   = 'sub-00515'
         CALL cl_err() 
         CONTINUE FOREACH
      END IF
      
      IF cl_null(l_tmp.packing_unit) THEN  
         LET l_err_cnt = l_err_cnt + 1
         LET g_errparam.extend = l_tmp.slip
         LET g_errparam.code   = 'adb-00091'
         CALL cl_err() 
         CONTINUE FOREACH
      END IF
      
      IF cl_null(l_tmp.inv_unit) THEN
         LET l_err_cnt = l_err_cnt + 1
         LET g_errparam.extend = l_tmp.slip
         LET g_errparam.code   = 'adb-00381'
         CALL cl_err() 
         CONTINUE FOREACH      
      END IF
      
      IF cl_null(l_tmp.qty) THEN
         LET l_err_cnt = l_err_cnt + 1
         LET g_errparam.extend = l_tmp.slip
         LET g_errparam.code   = 'sub-00516'
         CALL cl_err() 
         CONTINUE FOREACH          
      END IF

      IF l_tmp.slip = '2' AND cl_null(l_tmp.route) THEN
         LET l_err_cnt = l_err_cnt + 1
         LET g_errparam.extend = l_tmp.slip
         LET g_errparam.code   = 'adb-00395'   #調撥單的撥入組織尚未設定主要出貨地址！
         LET g_errparam.replace[1]  = l_tmp.item
         CALL cl_err() 
         CONTINUE FOREACH           
      END IF
      
      IF cl_null(l_tmp.volume_unit) OR cl_null(l_tmp.volume) THEN
         LET l_err_cnt = l_err_cnt + 1
         LET g_errparam.extend = l_tmp.slip
         LET g_errparam.code   = 'adb-00333'   #商品編號 %1 未設定體積或體積單位！
         LET g_errparam.replace[1]  = l_tmp.item
         CALL cl_err() 
         CONTINUE FOREACH        
      END IF

      IF cl_null(l_tmp.weight_unit) OR cl_null(l_tmp.weight) THEN
         LET l_err_cnt = l_err_cnt + 1
         LET g_errparam.extend = l_tmp.slip
         LET g_errparam.code   = 'adb-00332'   #商品編號 %1 未設定重量或重量單位！
         LET g_errparam.replace[1]  = l_tmp.item
         CALL cl_err()
         CONTINUE FOREACH               
      END IF
 
      #s_aooi250 parameters:料件編號/來源單位/目的單位/數量
      #2.1.庫存數：由包裝單位換算成庫存單位
      CALL s_aooi250_convert_qty(l_tmp.item,l_tmp.packing_unit,l_tmp.inv_unit,l_tmp.qty) RETURNING l_success,l_inv_qty 
      IF l_success THEN      
         #2.2.1.料件的體積單位與車量承載容積單位(參數)的換算率
         
        #141224-00013#15---sakura---mod---str 
        #CALL s_aimi190_get_convert(l_tmp.item,l_tmp.volume_unit,l_volume_para) RETURNING l_success,l_volume_rate
         CALL s_aooi250_convert_qty(l_tmp.item,l_tmp.volume_unit,l_volume_para,l_tmp.volume) RETURNING l_success,l_volume_qty
         IF l_success THEN
            #2.2.2.承載容積數：庫存數量 * 料件體積單位數量 * 體積單位與參數換算率
           #LET l_tmp.volume_qty = l_inv_qty * l_tmp.volume * l_volume_rate
            LET l_tmp.volume_qty = l_inv_qty * l_volume_qty 
        #141224-00013#15---sakura---mod---end
        
         ELSE
            LET l_err_cnt = l_err_cnt + 1
            CONTINUE FOREACH
         END IF
         
         #2.3.1.料件的重量單位與車量承載重量單位(參數)的換算率
         
        #141224-00013#15---sakura---mod---str 
        #CALL s_aimi190_get_convert(l_tmp.item,l_tmp.weight_unit,l_weight_para) RETURNING l_success,l_weight_rate
         CALL s_aooi250_convert_qty(l_tmp.item,l_tmp.weight_unit,l_weight_para,l_tmp.weight) RETURNING l_success,l_weight_qty
         IF l_success THEN
            #2.3.2.承載重量：庫存數量 * 毛重 * 重量單位與參數換算率
           #LET l_tmp.weight_qty = l_inv_qty * l_tmp.weight * l_weight_rate
            LET l_tmp.weight_qty = l_inv_qty * l_weight_qty
        #141224-00013#15---sakura---mod---end
        
         ELSE
            LET l_err_cnt = l_err_cnt + 1
            CONTINUE FOREACH
         END IF 
         
         UPDATE adbt700_tmp
            SET volume_qty = l_tmp.volume_qty,
                weight_qty = l_tmp.weight_qty
          WHERE seq = l_tmp.seq
         IF SQLCA.sqlcode THEN   
            LET l_err_cnt = l_err_cnt + 1
            LET g_errparam.extend = "adbt700_tmp" 
            LET g_errparam.code   = SQLCA.sqlcode
            CALL cl_err()
         END IF
      ELSE
         LET l_err_cnt = l_err_cnt + 1
         CONTINUE FOREACH
      END IF
   END FOREACH
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE 
      CALL cl_err_collect_show()       
      RETURN r_success
   END IF
   
   #3.依路線加總容積/重量後存入預排路線單身檔
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt 
     FROM adbt700_tmp
     
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dbeb_t" 
      LET g_errparam.code   = 'adb-00370'
      LET g_errparam.popup  = FALSE
      CALL cl_err()       
   ELSE
      SELECT COUNT(*) INTO l_cnt
        FROM (SELECT COUNT(route), route, point
                FROM adbt700_tmp
               WHERE COALESCE(route,'-1') <> '-1' 
               GROUP BY route, point)  
      DISPLAY "rep ROWS: ",l_cnt  
   
   
      INSERT INTO dbeb_t(dbebent,dbebsite,dbebdocno,dbeb001,dbeb002,
                         dbeb003,dbeb004 ,dbeb005  ,dbeb006,dbeb007,
                         dbeb008,dbebunit)
           SELECT g_enterprise, g_dbea_m.dbeasite, g_dbea_m.dbeadocno, route, point,
                  SUM(volume_qty), 0, l_volume_para, SUM(weight_qty), 0,
                  l_weight_para, g_dbea_m.dbeasite
             FROM adbt700_tmp
            WHERE COALESCE(route,'-1') <> '-1' 
            GROUP BY route, point
      IF SQLCA.sqlcode THEN   
         LET r_success = FALSE
         
         DISPLAY "Insert dbeb_t Error! "
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbeb_t" 
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         CALL cl_err_collect_show()
         RETURN r_success 
      END IF
      
      LET l_suc_cnt = 0   
      SELECT COUNT(*) INTO l_suc_cnt
        FROM dbeb_t
       WHERE dbebent = g_enterprise 
         AND dbebdocno = g_dbea_m.dbeadocno
      IF l_suc_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbeb_t" 
         LET g_errparam.code   = 'adb-00370'
         LET g_errparam.popup  = FALSE
         CALL cl_err()       
      END IF 
   END IF   

       
   CALL cl_err_collect_show()   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 自動寫入發貨組織範圍
# Memo...........:
# Usage..........: CALL adbt700_auto_ins_dbed(p_process,p_cmd)
#                  RETURNING r_success
# Input parameter: p_process   作業處理：1.單頭輸入後自動開窗 2.發貨組織手動維護開窗
#                  p_cmd       操作指令
# Return code....: r_success   處理結果
# Date & Author..: 2014/07/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt700_auto_ins_dbed(p_process,p_cmd)
   DEFINE p_process     LIKE type_t.num5
   DEFINE p_cmd         LIKE type_t.chr10
   DEFINE r_success     LIKE type_t.num5
   DEFINE tok           base.StringTokenizer
   DEFINE l_str_idx     LIKE type_t.num5
   DEFINE l_dbed001     LIKE dbed_t.dbed001
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_wc          STRING
   DEFINE l_ins_cnt     LIKE type_t.num5
   DEFINE l_err_cnt     LIKE type_t.num5
   DEFINE l_detail_cnt  LIKE type_t.num5
   DEFINE l_ac_t        LIKE type_t.num5
   
   LET r_success = TRUE   
   
   #提供多選開窗
   INITIALIZE g_qryparam.* TO NULL
   LET g_qryparam.state = 'c'
   LET g_qryparam.reqry = FALSE
   IF l_ac > 0 THEN
      LET g_qryparam.default1 = g_dbed_d[l_ac].dbed001             #給予default值
   END IF   
   IF s_aooi500_setpoint(g_prog,'dbed001') THEN
      CALL s_aooi500_q_where(g_prog,'dbed001',g_dbea_m.dbeasite,'i') #150308-00001#1  By Ken add 'i' 150309
         RETURNING l_wc
      LET g_qryparam.where = l_wc
      CALL q_ooef001_24()
   ELSE
      LET g_qryparam.arg1 = g_site
      LET g_qryparam.arg2 = '11'
      CALL q_ooed004()
   END IF

   IF cl_null(g_qryparam.return1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
      
   LET l_ac_t       = l_ac
   LET l_ins_cnt    = 0
   LET l_err_cnt    = 0   
   LET l_detail_cnt = g_dbed_d.getLength()
   LET tok = base.StringTokenizer.create(g_qryparam.return1,"|")
   
   CALL cl_err_collect_init()
   
   WHILE tok.hasMoreTokens()
      LET l_str_idx  = ''
      LET l_dbed001  = ''
      LET l_cnt      = 0
      
      LET l_dbed001 = tok.nextToken()             
      
      IF NOT cl_null(l_dbed001) THEN 
         #檢查本張配送單有無該組織，如果有直接略過
         SELECT COUNT(*) INTO l_cnt
           FROM dbed_t 
          WHERE dbedent = g_enterprise
            AND dbeddocno = g_dbea_m.dbeadocno
            AND dbed001 = l_dbed001
            
         IF l_cnt > 0 THEN
            CONTINUE WHILE
         ELSE   
            IF adbt700_dbed001_chk(p_cmd,l_dbed001,FALSE) THEN
               LET l_ins_cnt = l_ins_cnt + 1
               
               IF p_process = 1 OR (p_process = 2 AND l_ins_cnt > 1) THEN  
                  LET l_ac = l_detail_cnt + l_ins_cnt - 1
                  
                  IF l_ac > 0 THEN
                     LET g_dbed_d[l_ac].dbed001 = l_dbed001
                     LET g_dbed_d[l_ac].dbed001_desc = s_desc_get_department_desc(l_dbed001)
                     LET g_dbed_d[l_ac].dbedunit = l_dbed001
                  END IF
                  
                  #INITIALIZE gs_keys TO NULL
                  #LET gs_keys[1] = g_dbea_m.dbeadocno
                  #LET gs_keys[2] = l_dbed001
                  #CALL adbt700_insert_b('dbed_t',gs_keys,"'1'")               
                  #IF SQLCA.sqlcode THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = SQLCA.sqlcode
                  #   CALL cl_err()                  
                  #   
                  #   CALL g_dbed_d.deleteElement(l_ac)
                  #   LET l_ins_cnt = l_ins_cnt - 1
                  #   LET l_err_cnt = l_err_cnt + 1
                  #   #DISPLAY "Insert dbed_t Error!"   
                  #ELSE
                  #   #DISPLAY "Insert dbed_t Success!"    
                  #END IF
                  
                  INSERT INTO dbed_t
                              (dbedent,
                               dbeddocno,
                               dbed001,
                               dbedsite,
                               dbedunit) 
                        VALUES(g_enterprise,
                               g_dbea_m.dbeadocno,
                               l_dbed001,
                               g_dbea_m.dbeasite,
                               g_dbea_m.dbeasite)  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     CALL cl_err()                  
                     
                     CALL g_dbed_d.deleteElement(l_ac)
                     LET l_ins_cnt = l_ins_cnt - 1
                     LET l_err_cnt = l_err_cnt + 1 
                  END IF                               
               ELSE
                  LET g_dbed_d[l_ac].dbed001 = l_dbed001
                  LET g_dbed_d[l_ac].dbed001_desc = s_desc_get_department_desc(l_dbed001)
                  LET g_dbed_d[l_ac].dbedunit = l_dbed001                  
               END IF  
            END IF    
         END IF   
      END IF
      LET l_ac = l_ac_t         
   END WHILE      
   
   IF l_ins_cnt = 0 AND NOT (l_ins_cnt = 0 AND l_err_cnt = 0 )THEN
      LET r_success = FALSE      
   END IF
   
   CALL cl_err_collect_show()
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 車輛帶值
# Memo...........:
# Usage..........: CALL adbt700_car_default()
# Date & Author..: 2014/07/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt700_car_default()
   SELECT mrba050,mrba059,mrba060,mrba057,mrba058   #車牌號碼/承載容積/承載容積單位/承載重量/承載重量單位
     INTO g_dbed3_d[l_ac].dbec004,g_dbed3_d[l_ac].dbec005,          
          g_dbed3_d[l_ac].dbec006,g_dbed3_d[l_ac].dbec007,
          g_dbed3_d[l_ac].dbec008 
     FROM mrba_t
    WHERE mrbaent = g_enterprise
      AND mrbasite = g_dbea_m.dbeasite
      AND mrba001 = g_dbed3_d[l_ac].dbec003   
      
   LET g_dbed3_d[l_ac].dbec006_desc = s_desc_get_unit_desc(g_dbed3_d[l_ac].dbec006)
   LET g_dbed3_d[l_ac].dbec008_desc = s_desc_get_unit_desc(g_dbed3_d[l_ac].dbec008)       
END FUNCTION

################################################################################
# Descriptions...: 建立暫存檔
# Memo...........: 用於暫存出貨單&調撥單資料
# Usage..........: CALL adbt700_create_tmp()
# Date & Author..: 2014/07/31 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt700_create_tmp()
   WHENEVER ERROR CONTINUE
   
   DROP TABLE adbt700_tmp;
   
   #欄位說明
   #seq----------項次
   #slip---------單據類型
   #docno--------單號
   #docseq-------單據項次
   #route--------路線
   #point--------裝載點
   #volume-------體積
   #volume_unit--體積單位
   #inv_unit-----據點庫存單位
   #qty----------數量
   #packing_unit-包裝單位
   #weight-------毛重
   #weight_unit--毛重單位
   #itme---------料件編號
   #volume_qty---承載容積數
   #weight_qty---承載重量
   
   CREATE TEMP TABLE adbt700_tmp(
      seq             SMALLINT,
      slip            VARCHAR(10),
      docno           VARCHAR(20),
      docseq          INTEGER,
      route           VARCHAR(10),
      point           VARCHAR(10),      
      volume          DECIMAL(20,6),
      volume_unit     VARCHAR(10),
      inv_unit        VARCHAR(10),
      qty             DECIMAL(20,6), 
      packing_unit    VARCHAR(10), 
      weight          DECIMAL(20,6),
      weight_unit     VARCHAR(10),
      item            VARCHAR(40),
      volume_qty      DECIMAL(20,6),
      weight_qty      DECIMAL(20,6));
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'adbt700_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF   
END FUNCTION

 
{</section>}
 
