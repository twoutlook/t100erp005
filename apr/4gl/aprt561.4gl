#該程式未解開Section, 採用最新樣板產出!
{<section id="aprt561.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2014-08-08 17:42:16), PR版次:0009(2016-11-17 11:49:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000191
#+ Filename...: aprt561
#+ Description: 促銷任務量申請作業
#+ Creator....: 02296(2014-04-30 15:46:48)
#+ Modifier...: 03247 -SD/PR- 06814
 
{</section>}
 
{<section id="aprt561.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
# Modify......: NO.160318-00025#33   2016/04/13   By pengxin    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160809-00039#1   2016/08/11  by 08172       按照签核标准隐藏/显示状态
#160816-00068#13  2016/08/22  By 08209       調整transaction
#160818-00017#32  2016/08/25  By 08742       删除修改未重新判断状态码
#160824-00007#153 2016/11/17  By 06814       新舊值處理
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
PRIVATE type type_g_prcg_m        RECORD
       prcgsite LIKE prcg_t.prcgsite, 
   prcgsite_desc LIKE type_t.chr80, 
   prcgdocdt LIKE prcg_t.prcgdocdt, 
   prcgdocno LIKE prcg_t.prcgdocno, 
   prcgdocno_desc LIKE type_t.chr80, 
   prcg001 LIKE prcg_t.prcg001, 
   prcg001_desc LIKE type_t.chr80, 
   prcg002 LIKE prcg_t.prcg002, 
   prcg002_desc LIKE type_t.chr80, 
   prcg005 LIKE prcg_t.prcg005, 
   prcg003 LIKE prcg_t.prcg003, 
   prcg003_desc LIKE type_t.chr80, 
   prcg004 LIKE prcg_t.prcg004, 
   prcg004_desc LIKE type_t.chr80, 
   prcgunit LIKE prcg_t.prcgunit, 
   prcgstus LIKE prcg_t.prcgstus, 
   prcf005 LIKE type_t.chr10, 
   prcf006 LIKE type_t.chr10, 
   prcf007 LIKE type_t.chr10, 
   prcf007_desc LIKE type_t.chr80, 
   prcf008 LIKE type_t.chr10, 
   prcf008_desc LIKE type_t.chr80, 
   prcf009 LIKE type_t.dat, 
   prcf010 LIKE type_t.dat, 
   prcgownid LIKE prcg_t.prcgownid, 
   prcgownid_desc LIKE type_t.chr80, 
   prcgowndp LIKE prcg_t.prcgowndp, 
   prcgowndp_desc LIKE type_t.chr80, 
   prcgcrtid LIKE prcg_t.prcgcrtid, 
   prcgcrtid_desc LIKE type_t.chr80, 
   prcgcrtdp LIKE prcg_t.prcgcrtdp, 
   prcgcrtdp_desc LIKE type_t.chr80, 
   prcgcrtdt LIKE prcg_t.prcgcrtdt, 
   prcgmodid LIKE prcg_t.prcgmodid, 
   prcgmodid_desc LIKE type_t.chr80, 
   prcgmoddt LIKE prcg_t.prcgmoddt, 
   prcgcnfid LIKE prcg_t.prcgcnfid, 
   prcgcnfid_desc LIKE type_t.chr80, 
   prcgcnfdt LIKE prcg_t.prcgcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prch_d        RECORD
       prchseq LIKE prch_t.prchseq, 
   prch001 LIKE prch_t.prch001, 
   prch002 LIKE prch_t.prch002, 
   prch002_desc LIKE type_t.chr500, 
   prch003 LIKE prch_t.prch003, 
   prch003_desc LIKE type_t.chr500, 
   prch004 LIKE prch_t.prch004, 
   prch004_desc LIKE type_t.chr500, 
   prch005 LIKE prch_t.prch005, 
   prch005_desc LIKE type_t.chr500, 
   prch006 LIKE prch_t.prch006, 
   prch006_desc LIKE type_t.chr500, 
   prch007 LIKE prch_t.prch007, 
   prch007_desc LIKE type_t.chr500, 
   prch008 LIKE prch_t.prch008, 
   prch009 LIKE prch_t.prch009, 
   prch010 LIKE prch_t.prch010, 
   prch011 LIKE prch_t.prch011, 
   prch012 LIKE prch_t.prch012, 
   prch013 LIKE prch_t.prch013, 
   prchsite LIKE prch_t.prchsite, 
   prchunit LIKE prch_t.prchunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_prcgsite LIKE prcg_t.prcgsite,
   b_prcgsite_desc LIKE type_t.chr80,
      b_prcgdocdt LIKE prcg_t.prcgdocdt,
      b_prcgdocno LIKE prcg_t.prcgdocno,
      b_prcg001 LIKE prcg_t.prcg001,
   b_prcg001_desc LIKE type_t.chr80,
      b_prcg002 LIKE prcg_t.prcg002,
   b_prcg002_desc LIKE type_t.chr80,
      b_prcg003 LIKE prcg_t.prcg003,
   b_prcg003_desc LIKE type_t.chr80,
      b_prcg004 LIKE prcg_t.prcg004,
   b_prcg004_desc LIKE type_t.chr80,
      b_prcg005 LIKE prcg_t.prcg005
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_wc3                 STRING
DEFINE g_site_flag           LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_prcg_m          type_g_prcg_m
DEFINE g_prcg_m_t        type_g_prcg_m
DEFINE g_prcg_m_o        type_g_prcg_m
DEFINE g_prcg_m_mask_o   type_g_prcg_m #轉換遮罩前資料
DEFINE g_prcg_m_mask_n   type_g_prcg_m #轉換遮罩後資料
 
   DEFINE g_prcgdocno_t LIKE prcg_t.prcgdocno
 
 
DEFINE g_prch_d          DYNAMIC ARRAY OF type_g_prch_d
DEFINE g_prch_d_t        type_g_prch_d
DEFINE g_prch_d_o        type_g_prch_d
DEFINE g_prch_d_mask_o   DYNAMIC ARRAY OF type_g_prch_d #轉換遮罩前資料
DEFINE g_prch_d_mask_n   DYNAMIC ARRAY OF type_g_prch_d #轉換遮罩後資料
 
 
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
 
{<section id="aprt561.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT prcgsite,'',prcgdocdt,prcgdocno,'',prcg001,'',prcg002,'',prcg005,prcg003, 
       '',prcg004,'',prcgunit,prcgstus,'','','','','','','','',prcgownid,'',prcgowndp,'',prcgcrtid,'', 
       prcgcrtdp,'',prcgcrtdt,prcgmodid,'',prcgmoddt,prcgcnfid,'',prcgcnfdt", 
                      " FROM prcg_t",
                      " WHERE prcgent= ? AND prcgdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt561_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.prcgsite,t0.prcgdocdt,t0.prcgdocno,t0.prcg001,t0.prcg002,t0.prcg005, 
       t0.prcg003,t0.prcg004,t0.prcgunit,t0.prcgstus,t0.prcgownid,t0.prcgowndp,t0.prcgcrtid,t0.prcgcrtdp, 
       t0.prcgcrtdt,t0.prcgmodid,t0.prcgmoddt,t0.prcgcnfid,t0.prcgcnfdt,t1.ooefl003 ,t2.prcfl003 ,t3.prcdl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooag011", 
 
               " FROM prcg_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prcgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN prcfl_t t2 ON t2.prcflent="||g_enterprise||" AND t2.prcfl001=t0.prcg001 AND t2.prcfl002='"||g_dlang||"' ",
               " LEFT JOIN prcdl_t t3 ON t3.prcdlent="||g_enterprise||" AND t3.prcdl001=t0.prcg002 AND t3.prcdl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prcg003  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prcg004 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.prcgownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.prcgowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.prcgcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.prcgcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.prcgmodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.prcgcnfid  ",
 
               " WHERE t0.prcgent = " ||g_enterprise|| " AND t0.prcgdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprt561_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprt561 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprt561_init()   
 
      #進入選單 Menu (="N")
      CALL aprt561_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprt561
      
   END IF 
   
   CLOSE aprt561_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprt561.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprt561_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
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
      CALL cl_set_combo_scc_part('prcgstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('prch013','6063') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('prcf005','6027')
   CALL cl_set_combo_scc('prcf006','6571')
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
   
   #初始化搜尋條件
   CALL aprt561_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprt561.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprt561_ui_dialog()
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
            CALL aprt561_insert()
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
         INITIALIZE g_prcg_m.* TO NULL
         CALL g_prch_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aprt561_init()
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
               
               CALL aprt561_fetch('') # reload data
               LET l_ac = 1
               CALL aprt561_ui_detailshow() #Setting the current row 
         
               CALL aprt561_idx_chk()
               #NEXT FIELD prchseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_prch_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt561_idx_chk()
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
               CALL aprt561_idx_chk()
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
            CALL aprt561_browser_fill("")
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
               CALL aprt561_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprt561_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprt561_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aprt561_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aprt561_set_act_visible()   
            CALL aprt561_set_act_no_visible()
            IF NOT (g_prcg_m.prcgdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " prcgent = " ||g_enterprise|| " AND",
                                  " prcgdocno = '", g_prcg_m.prcgdocno, "' "
 
               #填到對應位置
               CALL aprt561_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "prcg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prch_t" 
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
               CALL aprt561_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "prcg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prch_t" 
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
                  CALL aprt561_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aprt561_fetch("F")
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
               CALL aprt561_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aprt561_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt561_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aprt561_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt561_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aprt561_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt561_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aprt561_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt561_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aprt561_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt561_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_prch_d)
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
               NEXT FIELD prchseq
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
               CALL aprt561_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aprt561_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aprt561_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aprt561_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aprt561_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aprt561_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprt561_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprt561_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_prcg_m.prcgdocdt)
 
 
 
         
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
 
{<section id="aprt561.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprt561_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'prcgsite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc  = g_wc.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT prcgdocno ",
                      " FROM prcg_t ",
                      " ",
                      " LEFT JOIN prch_t ON prchent = prcgent AND prcgdocno = prchdocno ", "  ",
                      #add-point:browser_fill段sql(prch_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE prcgent = " ||g_enterprise|| " AND prchent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prcg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT prcgdocno ",
                      " FROM prcg_t ", 
                      "  ",
                      "  ",
                      " WHERE prcgent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("prcg_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE prcgdocno ",
 
                        " FROM prcg_t ",
                              " ",
                              " LEFT JOIN prch_t ON prchent = prcgent AND prcgdocno = prchdocno ",
                       " WHERE prcgent = '" ||g_enterprise|| "' AND prchent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prcg_t")
     IF g_wc3<>" 1=1" THEN
        LET l_sub_sql = " SELECT UNIQUE prcgdocno ",
 
                        " FROM prcg_t ",
                              " LEFT JOIN prcf_t ON prcfent = prcgent AND prcf001 = prcg001 ",
                              " LEFT JOIN prch_t ON prchent = prcgent AND prcgdocno = prchdocno ",
                       " WHERE prcgent = '" ||g_enterprise|| "' AND prchent = '" ||g_enterprise|| "' AND ",l_wc, " AND ",g_wc3," AND ", l_wc2, cl_sql_add_filter("prcg_t")
     END IF     
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE prcgdocno ",
 
                        " FROM prcg_t ", 
                              " ",
                              " ",
                        "WHERE prcgent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("prcg_t")
      IF g_wc3<>" 1=1" THEN
         LET l_sub_sql = " SELECT UNIQUE prcgdocno ",
 
                        " FROM prcg_t ",
                              " LEFT JOIN prcf_t ON prcfent = prcgent AND prcf001 = prcg001 ",
                       " WHERE prcgent = '" ||g_enterprise|| "' AND prcfent = '" ||g_enterprise|| "' AND ",l_wc, " AND ",g_wc3 , cl_sql_add_filter("prcg_t")
      END IF      
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
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
      INITIALIZE g_prcg_m.* TO NULL
      CALL g_prch_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.prcgsite,t0.prcgdocdt,t0.prcgdocno,t0.prcg001,t0.prcg002,t0.prcg003,t0.prcg004,t0.prcg005 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prcgstus,t0.prcgsite,t0.prcgdocdt,t0.prcgdocno,t0.prcg001,t0.prcg002, 
          t0.prcg003,t0.prcg004,t0.prcg005,t1.ooefl003 ,t2.prcfl003 ,t3.prcdl003 ,t4.ooag011 ,t5.ooefl003 ", 
 
                  " FROM prcg_t t0",
                  "  ",
                  "  LEFT JOIN prch_t ON prchent = prcgent AND prcgdocno = prchdocno ", "  ", 
                  #add-point:browser_fill段sql(prch_t1) name="browser_fill.join.prch_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prcgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN prcfl_t t2 ON t2.prcflent="||g_enterprise||" AND t2.prcfl001=t0.prcg001 AND t2.prcfl002='"||g_dlang||"' ",
               " LEFT JOIN prcdl_t t3 ON t3.prcdlent="||g_enterprise||" AND t3.prcdl001=t0.prcg002 AND t3.prcdl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prcg003  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prcg004 AND t5.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.prcgent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("prcg_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prcgstus,t0.prcgsite,t0.prcgdocdt,t0.prcgdocno,t0.prcg001,t0.prcg002, 
          t0.prcg003,t0.prcg004,t0.prcg005,t1.ooefl003 ,t2.prcfl003 ,t3.prcdl003 ,t4.ooag011 ,t5.ooefl003 ", 
 
                  " FROM prcg_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prcgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN prcfl_t t2 ON t2.prcflent="||g_enterprise||" AND t2.prcfl001=t0.prcg001 AND t2.prcfl002='"||g_dlang||"' ",
               " LEFT JOIN prcdl_t t3 ON t3.prcdlent="||g_enterprise||" AND t3.prcdl001=t0.prcg002 AND t3.prcdl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prcg003  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prcg004 AND t5.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.prcgent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("prcg_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY prcgdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照prcgsite,'',prcgdocdt,prcgdocno,prcg001,'',prcg002,'',prcg003,'',prcg004,'',prcg005 Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = " SELECT DISTINCT t0.prcgstus,t0.prcgsite,t0.prcgdocdt,t0.prcgdocno,t0.prcg001,t0.prcg002, 
       t0.prcg003,t0.prcg004,t0.prcg005,t1.ooefl003 ,t2.prcfl003 ,t3.prcdl003 ,t4.ooag011 ,t5.ooefl003 ", 

               " FROM prcg_t t0",
               "  ",
               "  LEFT JOIN prch_t ON prchent = prcgent AND prcgdocno = prchdocno ",
 
 
               "  ",
               "  ",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.prcgsite AND t1.ooefl002='"||g_lang||"' ",
               " LEFT JOIN prcfl_t t2 ON t2.prcflent='"||g_enterprise||"' AND t2.prcfl001=t0.prcg001 AND t2.prcfl002='"||g_lang||"' ",
               " LEFT JOIN prcdl_t t3 ON t3.prcdlent='"||g_enterprise||"' AND t3.prcdl001=t0.prcg002 AND t3.prcdl002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent='"||g_enterprise||"' AND t4.ooag001=t0.prcg003  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t0.prcg004 AND t5.ooefl002='"||g_lang||"' ",
                       " WHERE t0.prcgent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("prcg_t")
      IF g_wc3 <> " 1=1" AND NOT cl_null(g_wc3) THEN
         LET l_sql_rank = " SELECT DISTINCT t0.prcgstus,t0.prcgsite,t0.prcgdocdt,t0.prcgdocno,t0.prcg001,t0.prcg002, 
       t0.prcg003,t0.prcg004,t0.prcg005,t1.ooefl003 ,t2.prcfl003 ,t3.prcdl003 ,t4.ooag011 ,t5.ooefl003 ", 

               " FROM prcg_t t0",
               "  ",
               "  LEFT JOIN prch_t ON prchent = prcgent AND prcgdocno = prchdocno ",
 
 
               "  ",
               "  ",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.prcgsite AND t1.ooefl002='"||g_lang||"' ",
               " LEFT JOIN prcfl_t t2 ON t2.prcflent='"||g_enterprise||"' AND t2.prcfl001=t0.prcg001 AND t2.prcfl002='"||g_lang||"' ",
               " LEFT JOIN prcdl_t t3 ON t3.prcdlent='"||g_enterprise||"' AND t3.prcdl001=t0.prcg002 AND t3.prcdl002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent='"||g_enterprise||"' AND t4.ooag001=t0.prcg003  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t0.prcg004 AND t5.ooefl002='"||g_lang||"' ",
                       " WHERE t0.prcgent = '" ||g_enterprise|| "' AND ",l_wc," AND ",g_wc3," AND ",l_wc2, cl_sql_add_filter("prcg_t")
      END IF      
   ELSE
      #單身無輸入資料
      LET l_sql_rank = " SELECT DISTINCT t0.prcgstus,t0.prcgsite,t0.prcgdocdt,t0.prcgdocno,t0.prcg001,t0.prcg002, 
       t0.prcg003,t0.prcg004,t0.prcg005,t1.ooefl003 ,t2.prcfl003 ,t3.prcdl003 ,t4.ooag011 ,t5.ooefl003 ", 

               " FROM prcg_t t0",
               "  ",
               "  LEFT JOIN prch_t ON prchent = prcgent AND prcgdocno = prchdocno ",
 
 
               "  ",
               "  ",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.prcgsite AND t1.ooefl002='"||g_lang||"' ",
               " LEFT JOIN prcfl_t t2 ON t2.prcflent='"||g_enterprise||"' AND t2.prcfl001=t0.prcg001 AND t2.prcfl002='"||g_lang||"' ",
               " LEFT JOIN prcdl_t t3 ON t3.prcdlent='"||g_enterprise||"' AND t3.prcdl001=t0.prcg002 AND t3.prcdl002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent='"||g_enterprise||"' AND t4.ooag001=t0.prcg003  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t0.prcg004 AND t5.ooefl002='"||g_lang||"' ",
                       " WHERE t0.prcgent = '" ||g_enterprise|| "' AND ", l_wc, cl_sql_add_filter("prcg_t")
      IF g_wc3 <> " 1=1" AND NOT cl_null(g_wc3) THEN
         LET l_sql_rank = " SELECT DISTINCT t0.prcgstus,t0.prcgsite,t0.prcgdocdt,t0.prcgdocno,t0.prcg001,t0.prcg002, 
       t0.prcg003,t0.prcg004,t0.prcg005,t1.ooefl003 ,t2.prcfl003 ,t3.prcdl003 ,t4.ooag011 ,t5.ooefl003 ", 

               " FROM prcg_t t0",
               "  ",
               "  LEFT JOIN prch_t ON prchent = prcgent AND prcgdocno = prchdocno ",
 
 
               "  ",
               "  ",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.prcgsite AND t1.ooefl002='"||g_lang||"' ",
               " LEFT JOIN prcfl_t t2 ON t2.prcflent='"||g_enterprise||"' AND t2.prcfl001=t0.prcg001 AND t2.prcfl002='"||g_lang||"' ",
               " LEFT JOIN prcdl_t t3 ON t3.prcdlent='"||g_enterprise||"' AND t3.prcdl001=t0.prcg002 AND t3.prcdl002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent='"||g_enterprise||"' AND t4.ooag001=t0.prcg003  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t0.prcg004 AND t5.ooefl002='"||g_lang||"' ",
                       " WHERE t0.prcgent = '" ||g_enterprise|| "' AND ",l_wc," AND ",g_wc3, cl_sql_add_filter("prcg_t")
      END IF                 
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= l_sql_rank," ORDER BY prcgdocno ",g_order
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"prcg_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_prcgsite,g_browser[g_cnt].b_prcgdocdt, 
          g_browser[g_cnt].b_prcgdocno,g_browser[g_cnt].b_prcg001,g_browser[g_cnt].b_prcg002,g_browser[g_cnt].b_prcg003, 
          g_browser[g_cnt].b_prcg004,g_browser[g_cnt].b_prcg005,g_browser[g_cnt].b_prcgsite_desc,g_browser[g_cnt].b_prcg001_desc, 
          g_browser[g_cnt].b_prcg002_desc,g_browser[g_cnt].b_prcg003_desc,g_browser[g_cnt].b_prcg004_desc 
 
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
         CALL aprt561_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_prcgdocno) THEN
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
 
{<section id="aprt561.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprt561_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_prcg_m.prcgdocno = g_browser[g_current_idx].b_prcgdocno   
 
   EXECUTE aprt561_master_referesh USING g_prcg_m.prcgdocno INTO g_prcg_m.prcgsite,g_prcg_m.prcgdocdt, 
       g_prcg_m.prcgdocno,g_prcg_m.prcg001,g_prcg_m.prcg002,g_prcg_m.prcg005,g_prcg_m.prcg003,g_prcg_m.prcg004, 
       g_prcg_m.prcgunit,g_prcg_m.prcgstus,g_prcg_m.prcgownid,g_prcg_m.prcgowndp,g_prcg_m.prcgcrtid, 
       g_prcg_m.prcgcrtdp,g_prcg_m.prcgcrtdt,g_prcg_m.prcgmodid,g_prcg_m.prcgmoddt,g_prcg_m.prcgcnfid, 
       g_prcg_m.prcgcnfdt,g_prcg_m.prcgsite_desc,g_prcg_m.prcg001_desc,g_prcg_m.prcg002_desc,g_prcg_m.prcg003_desc, 
       g_prcg_m.prcg004_desc,g_prcg_m.prcgownid_desc,g_prcg_m.prcgowndp_desc,g_prcg_m.prcgcrtid_desc, 
       g_prcg_m.prcgcrtdp_desc,g_prcg_m.prcgmodid_desc,g_prcg_m.prcgcnfid_desc
   
   CALL aprt561_prcg_t_mask()
   CALL aprt561_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aprt561.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprt561_ui_detailshow()
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
 
{<section id="aprt561.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprt561_ui_browser_refresh()
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
      IF g_browser[l_i].b_prcgdocno = g_prcg_m.prcgdocno 
 
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
 
{<section id="aprt561.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprt561_construct()
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
   INITIALIZE g_prcg_m.* TO NULL
   CALL g_prch_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON prcgsite,prcgdocdt,prcgdocno,prcg001,prcg002,prcg005,prcg003,prcg004, 
          prcgunit,prcgstus,prcgownid,prcgowndp,prcgcrtid,prcgcrtdp,prcgcrtdt,prcgmodid,prcgmoddt,prcgcnfid, 
          prcgcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prcgcrtdt>>----
         AFTER FIELD prcgcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prcgmoddt>>----
         AFTER FIELD prcgmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prcgcnfdt>>----
         AFTER FIELD prcgcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prcgpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.prcgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgsite
            #add-point:ON ACTION controlp INFIELD prcgsite name="construct.c.prcgsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prcgsite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prcgsite  #顯示到畫面上
            NEXT FIELD prcgsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgsite
            #add-point:BEFORE FIELD prcgsite name="construct.b.prcgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgsite
            
            #add-point:AFTER FIELD prcgsite name="construct.a.prcgsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgdocdt
            #add-point:BEFORE FIELD prcgdocdt name="construct.b.prcgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgdocdt
            
            #add-point:AFTER FIELD prcgdocdt name="construct.a.prcgdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgdocdt
            #add-point:ON ACTION controlp INFIELD prcgdocdt name="construct.c.prcgdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prcgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgdocno
            #add-point:ON ACTION controlp INFIELD prcgdocno name="construct.c.prcgdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_prcgdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcgdocno  #顯示到畫面上
            NEXT FIELD prcgdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgdocno
            #add-point:BEFORE FIELD prcgdocno name="construct.b.prcgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgdocno
            
            #add-point:AFTER FIELD prcgdocno name="construct.a.prcgdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcg001
            #add-point:ON ACTION controlp INFIELD prcg001 name="construct.c.prcg001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2'
            CALL q_prcf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcg001  #顯示到畫面上
            NEXT FIELD prcg001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcg001
            #add-point:BEFORE FIELD prcg001 name="construct.b.prcg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcg001
            
            #add-point:AFTER FIELD prcg001 name="construct.a.prcg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcg002
            #add-point:ON ACTION controlp INFIELD prcg002 name="construct.c.prcg002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2'
            CALL q_prcd001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcg002  #顯示到畫面上
            NEXT FIELD prcg002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcg002
            #add-point:BEFORE FIELD prcg002 name="construct.b.prcg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcg002
            
            #add-point:AFTER FIELD prcg002 name="construct.a.prcg002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcg005
            #add-point:BEFORE FIELD prcg005 name="construct.b.prcg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcg005
            
            #add-point:AFTER FIELD prcg005 name="construct.a.prcg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcg005
            #add-point:ON ACTION controlp INFIELD prcg005 name="construct.c.prcg005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prcg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcg003
            #add-point:ON ACTION controlp INFIELD prcg003 name="construct.c.prcg003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcg003  #顯示到畫面上
            NEXT FIELD prcg003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcg003
            #add-point:BEFORE FIELD prcg003 name="construct.b.prcg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcg003
            
            #add-point:AFTER FIELD prcg003 name="construct.a.prcg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcg004
            #add-point:ON ACTION controlp INFIELD prcg004 name="construct.c.prcg004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcg004  #顯示到畫面上
            NEXT FIELD prcg004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcg004
            #add-point:BEFORE FIELD prcg004 name="construct.b.prcg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcg004
            
            #add-point:AFTER FIELD prcg004 name="construct.a.prcg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcgunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgunit
            #add-point:ON ACTION controlp INFIELD prcgunit name="construct.c.prcgunit"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcgunit  #顯示到畫面上
            NEXT FIELD prcgunit                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgunit
            #add-point:BEFORE FIELD prcgunit name="construct.b.prcgunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgunit
            
            #add-point:AFTER FIELD prcgunit name="construct.a.prcgunit"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgstus
            #add-point:BEFORE FIELD prcgstus name="construct.b.prcgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgstus
            
            #add-point:AFTER FIELD prcgstus name="construct.a.prcgstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgstus
            #add-point:ON ACTION controlp INFIELD prcgstus name="construct.c.prcgstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prcgownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgownid
            #add-point:ON ACTION controlp INFIELD prcgownid name="construct.c.prcgownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcgownid  #顯示到畫面上
            NEXT FIELD prcgownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgownid
            #add-point:BEFORE FIELD prcgownid name="construct.b.prcgownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgownid
            
            #add-point:AFTER FIELD prcgownid name="construct.a.prcgownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcgowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgowndp
            #add-point:ON ACTION controlp INFIELD prcgowndp name="construct.c.prcgowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcgowndp  #顯示到畫面上
            NEXT FIELD prcgowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgowndp
            #add-point:BEFORE FIELD prcgowndp name="construct.b.prcgowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgowndp
            
            #add-point:AFTER FIELD prcgowndp name="construct.a.prcgowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcgcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgcrtid
            #add-point:ON ACTION controlp INFIELD prcgcrtid name="construct.c.prcgcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcgcrtid  #顯示到畫面上
            NEXT FIELD prcgcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgcrtid
            #add-point:BEFORE FIELD prcgcrtid name="construct.b.prcgcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgcrtid
            
            #add-point:AFTER FIELD prcgcrtid name="construct.a.prcgcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcgcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgcrtdp
            #add-point:ON ACTION controlp INFIELD prcgcrtdp name="construct.c.prcgcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcgcrtdp  #顯示到畫面上
            NEXT FIELD prcgcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgcrtdp
            #add-point:BEFORE FIELD prcgcrtdp name="construct.b.prcgcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgcrtdp
            
            #add-point:AFTER FIELD prcgcrtdp name="construct.a.prcgcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgcrtdt
            #add-point:BEFORE FIELD prcgcrtdt name="construct.b.prcgcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prcgmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgmodid
            #add-point:ON ACTION controlp INFIELD prcgmodid name="construct.c.prcgmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcgmodid  #顯示到畫面上
            NEXT FIELD prcgmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgmodid
            #add-point:BEFORE FIELD prcgmodid name="construct.b.prcgmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgmodid
            
            #add-point:AFTER FIELD prcgmodid name="construct.a.prcgmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgmoddt
            #add-point:BEFORE FIELD prcgmoddt name="construct.b.prcgmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prcgcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgcnfid
            #add-point:ON ACTION controlp INFIELD prcgcnfid name="construct.c.prcgcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcgcnfid  #顯示到畫面上
            NEXT FIELD prcgcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgcnfid
            #add-point:BEFORE FIELD prcgcnfid name="construct.b.prcgcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgcnfid
            
            #add-point:AFTER FIELD prcgcnfid name="construct.a.prcgcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgcnfdt
            #add-point:BEFORE FIELD prcgcnfdt name="construct.b.prcgcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON prchseq,prch001,prch002,prch003,prch004,prch005,prch006,prch007,prch008, 
          prch009,prch010,prch011,prch012,prch013,prchsite,prchunit
           FROM s_detail1[1].prchseq,s_detail1[1].prch001,s_detail1[1].prch002,s_detail1[1].prch003, 
               s_detail1[1].prch004,s_detail1[1].prch005,s_detail1[1].prch006,s_detail1[1].prch007,s_detail1[1].prch008, 
               s_detail1[1].prch009,s_detail1[1].prch010,s_detail1[1].prch011,s_detail1[1].prch012,s_detail1[1].prch013, 
               s_detail1[1].prchsite,s_detail1[1].prchunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prchseq
            #add-point:BEFORE FIELD prchseq name="construct.b.page1.prchseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prchseq
            
            #add-point:AFTER FIELD prchseq name="construct.a.page1.prchseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prchseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prchseq
            #add-point:ON ACTION controlp INFIELD prchseq name="construct.c.page1.prchseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch001
            #add-point:BEFORE FIELD prch001 name="construct.b.page1.prch001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch001
            
            #add-point:AFTER FIELD prch001 name="construct.a.page1.prch001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prch001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch001
            #add-point:ON ACTION controlp INFIELD prch001 name="construct.c.page1.prch001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prch002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch002
            #add-point:ON ACTION controlp INFIELD prch002 name="construct.c.page1.prch002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "1" #客戶性質
            LET g_qryparam.arg2 = "2" #客戶經營類別
            CALL q_pmaa001_12()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prch002  #顯示到畫面上
            NEXT FIELD prch002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch002
            #add-point:BEFORE FIELD prch002 name="construct.b.page1.prch002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch002
            
            #add-point:AFTER FIELD prch002 name="construct.a.page1.prch002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prch003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch003
            #add-point:ON ACTION controlp INFIELD prch003 name="construct.c.page1.prch003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_18()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prch003  #顯示到畫面上
            NEXT FIELD prch003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch003
            #add-point:BEFORE FIELD prch003 name="construct.b.page1.prch003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch003
            
            #add-point:AFTER FIELD prch003 name="construct.a.page1.prch003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prch004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch004
            #add-point:ON ACTION controlp INFIELD prch004 name="construct.c.page1.prch004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbbc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prch004  #顯示到畫面上
            NEXT FIELD prch004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch004
            #add-point:BEFORE FIELD prch004 name="construct.b.page1.prch004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch004
            
            #add-point:AFTER FIELD prch004 name="construct.a.page1.prch004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prch005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch005
            #add-point:ON ACTION controlp INFIELD prch005 name="construct.c.page1.prch005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            CALL q_oojd001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prch005  #顯示到畫面上
            NEXT FIELD prch005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch005
            #add-point:BEFORE FIELD prch005 name="construct.b.page1.prch005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch005
            
            #add-point:AFTER FIELD prch005 name="construct.a.page1.prch005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prch006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch006
            #add-point:ON ACTION controlp INFIELD prch006 name="construct.c.page1.prch006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = 'G'
#            LET g_qryparam.where = " ooef305 = 'Y' "
#            CALL q_ooef001()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'prch006') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'prch006',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef305 = 'Y' "
               CALL q_ooef001()  
            END IF
            DISPLAY g_qryparam.return1 TO prch006  #顯示到畫面上
            NEXT FIELD prch006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch006
            #add-point:BEFORE FIELD prch006 name="construct.b.page1.prch006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch006
            
            #add-point:AFTER FIELD prch006 name="construct.a.page1.prch006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prch007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch007
            #add-point:ON ACTION controlp INFIELD prch007 name="construct.c.page1.prch007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prch007  #顯示到畫面上
            NEXT FIELD prch007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch007
            #add-point:BEFORE FIELD prch007 name="construct.b.page1.prch007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch007
            
            #add-point:AFTER FIELD prch007 name="construct.a.page1.prch007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch008
            #add-point:BEFORE FIELD prch008 name="construct.b.page1.prch008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch008
            
            #add-point:AFTER FIELD prch008 name="construct.a.page1.prch008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prch008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch008
            #add-point:ON ACTION controlp INFIELD prch008 name="construct.c.page1.prch008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch009
            #add-point:BEFORE FIELD prch009 name="construct.b.page1.prch009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch009
            
            #add-point:AFTER FIELD prch009 name="construct.a.page1.prch009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prch009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch009
            #add-point:ON ACTION controlp INFIELD prch009 name="construct.c.page1.prch009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch010
            #add-point:BEFORE FIELD prch010 name="construct.b.page1.prch010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch010
            
            #add-point:AFTER FIELD prch010 name="construct.a.page1.prch010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prch010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch010
            #add-point:ON ACTION controlp INFIELD prch010 name="construct.c.page1.prch010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch011
            #add-point:BEFORE FIELD prch011 name="construct.b.page1.prch011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch011
            
            #add-point:AFTER FIELD prch011 name="construct.a.page1.prch011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prch011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch011
            #add-point:ON ACTION controlp INFIELD prch011 name="construct.c.page1.prch011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch012
            #add-point:BEFORE FIELD prch012 name="construct.b.page1.prch012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch012
            
            #add-point:AFTER FIELD prch012 name="construct.a.page1.prch012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prch012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch012
            #add-point:ON ACTION controlp INFIELD prch012 name="construct.c.page1.prch012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch013
            #add-point:BEFORE FIELD prch013 name="construct.b.page1.prch013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch013
            
            #add-point:AFTER FIELD prch013 name="construct.a.page1.prch013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prch013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch013
            #add-point:ON ACTION controlp INFIELD prch013 name="construct.c.page1.prch013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prchsite
            #add-point:BEFORE FIELD prchsite name="construct.b.page1.prchsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prchsite
            
            #add-point:AFTER FIELD prchsite name="construct.a.page1.prchsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prchsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prchsite
            #add-point:ON ACTION controlp INFIELD prchsite name="construct.c.page1.prchsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prchunit
            #add-point:BEFORE FIELD prchunit name="construct.b.page1.prchunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prchunit
            
            #add-point:AFTER FIELD prchunit name="construct.a.page1.prchunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prchunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prchunit
            #add-point:ON ACTION controlp INFIELD prchunit name="construct.c.page1.prchunit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
       CONSTRUCT BY NAME g_wc3 ON prcf005,prcf006,prcf007,prcf008,prcf009,prcf010
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
         ON ACTION controlp INFIELD prcf007
            #add-point:ON ACTION controlp INFIELD prcgsite
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2100'
            CALL q_oocq002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcf007  #顯示到畫面上
            NEXT FIELD prcf007                     #返回原欄位
    
            #END add-point
 
         
         ON ACTION controlp INFIELD prcf008
            #add-point:ON ACTION controlp INFIELD prcgdocno
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2101'
            CALL q_oocq002()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcf008  #顯示到畫面上
            NEXT FIELD prcf008                     #返回原欄位
   
            #END add-point
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
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "prcg_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prch_t" 
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
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt561.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aprt561_filter()
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
      CONSTRUCT g_wc_filter ON prcgsite,prcgdocdt,prcgdocno,prcg001,prcg002,prcg003,prcg004,prcg005
                          FROM s_browse[1].b_prcgsite,s_browse[1].b_prcgdocdt,s_browse[1].b_prcgdocno, 
                              s_browse[1].b_prcg001,s_browse[1].b_prcg002,s_browse[1].b_prcg003,s_browse[1].b_prcg004, 
                              s_browse[1].b_prcg005
 
         BEFORE CONSTRUCT
               DISPLAY aprt561_filter_parser('prcgsite') TO s_browse[1].b_prcgsite
            DISPLAY aprt561_filter_parser('prcgdocdt') TO s_browse[1].b_prcgdocdt
            DISPLAY aprt561_filter_parser('prcgdocno') TO s_browse[1].b_prcgdocno
            DISPLAY aprt561_filter_parser('prcg001') TO s_browse[1].b_prcg001
            DISPLAY aprt561_filter_parser('prcg002') TO s_browse[1].b_prcg002
            DISPLAY aprt561_filter_parser('prcg003') TO s_browse[1].b_prcg003
            DISPLAY aprt561_filter_parser('prcg004') TO s_browse[1].b_prcg004
            DISPLAY aprt561_filter_parser('prcg005') TO s_browse[1].b_prcg005
      
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
 
      CALL aprt561_filter_show('prcgsite')
   CALL aprt561_filter_show('prcgdocdt')
   CALL aprt561_filter_show('prcgdocno')
   CALL aprt561_filter_show('prcg001')
   CALL aprt561_filter_show('prcg002')
   CALL aprt561_filter_show('prcg003')
   CALL aprt561_filter_show('prcg004')
   CALL aprt561_filter_show('prcg005')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt561.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aprt561_filter_parser(ps_field)
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
 
{<section id="aprt561.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aprt561_filter_show(ps_field)
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
   LET ls_condition = aprt561_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprt561.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprt561_query()
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
   CALL g_prch_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aprt561_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aprt561_browser_fill("")
      CALL aprt561_fetch("")
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
      CALL aprt561_filter_show('prcgsite')
   CALL aprt561_filter_show('prcgdocdt')
   CALL aprt561_filter_show('prcgdocno')
   CALL aprt561_filter_show('prcg001')
   CALL aprt561_filter_show('prcg002')
   CALL aprt561_filter_show('prcg003')
   CALL aprt561_filter_show('prcg004')
   CALL aprt561_filter_show('prcg005')
   CALL aprt561_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aprt561_fetch("F") 
      #顯示單身筆數
      CALL aprt561_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt561.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprt561_fetch(p_flag)
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
   
   LET g_prcg_m.prcgdocno = g_browser[g_current_idx].b_prcgdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aprt561_master_referesh USING g_prcg_m.prcgdocno INTO g_prcg_m.prcgsite,g_prcg_m.prcgdocdt, 
       g_prcg_m.prcgdocno,g_prcg_m.prcg001,g_prcg_m.prcg002,g_prcg_m.prcg005,g_prcg_m.prcg003,g_prcg_m.prcg004, 
       g_prcg_m.prcgunit,g_prcg_m.prcgstus,g_prcg_m.prcgownid,g_prcg_m.prcgowndp,g_prcg_m.prcgcrtid, 
       g_prcg_m.prcgcrtdp,g_prcg_m.prcgcrtdt,g_prcg_m.prcgmodid,g_prcg_m.prcgmoddt,g_prcg_m.prcgcnfid, 
       g_prcg_m.prcgcnfdt,g_prcg_m.prcgsite_desc,g_prcg_m.prcg001_desc,g_prcg_m.prcg002_desc,g_prcg_m.prcg003_desc, 
       g_prcg_m.prcg004_desc,g_prcg_m.prcgownid_desc,g_prcg_m.prcgowndp_desc,g_prcg_m.prcgcrtid_desc, 
       g_prcg_m.prcgcrtdp_desc,g_prcg_m.prcgmodid_desc,g_prcg_m.prcgcnfid_desc
   
   #遮罩相關處理
   LET g_prcg_m_mask_o.* =  g_prcg_m.*
   CALL aprt561_prcg_t_mask()
   LET g_prcg_m_mask_n.* =  g_prcg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt561_set_act_visible()   
   CALL aprt561_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#    IF g_prcg_m.prcgstus = 'Y' THEN
#      CALL cl_set_act_visible("modify,delete", FALSE)
#   ELSE
#      IF g_prcg_m.prcgstus = 'X' THEN
#         CALL cl_set_act_visible("delete,modify", FALSE)
#      ELSE
#         CALL cl_set_act_visible("modify,delete", TRUE)
#      END IF   
#   END IF
   IF g_prcg_m.prcgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prcg_m_t.* = g_prcg_m.*
   LET g_prcg_m_o.* = g_prcg_m.*
   
   LET g_data_owner = g_prcg_m.prcgownid      
   LET g_data_dept  = g_prcg_m.prcgowndp
   
   #重新顯示   
   CALL aprt561_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt561.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprt561_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_prch_d.clear()   
 
 
   INITIALIZE g_prcg_m.* TO NULL             #DEFAULT 設定
   
   LET g_prcgdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prcg_m.prcgownid = g_user
      LET g_prcg_m.prcgowndp = g_dept
      LET g_prcg_m.prcgcrtid = g_user
      LET g_prcg_m.prcgcrtdp = g_dept 
      LET g_prcg_m.prcgcrtdt = cl_get_current()
      LET g_prcg_m.prcgmodid = g_user
      LET g_prcg_m.prcgmoddt = cl_get_current()
      LET g_prcg_m.prcgstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_prcg_m.prcf005 = "1"
      LET g_prcg_m.prcf006 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_prcg_m.prcgstus = "N"
      LET g_prcg_m.prcgdocdt = g_today
#      LET g_prcg_m.prcgsite = g_site
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'prcgsite',g_prcg_m.prcgsite)
         RETURNING l_insert,g_prcg_m.prcgsite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_prcg_m.prcgunit = g_site
      CALL aprt561_prcgsite_ref()
      LET g_prcg_m.prcg003 = g_user
      CALL aprt561_create_prcg004()
      CALL aprt561_prcg003_ref()
      CALL aprt561_prcg004_ref()
      
      #dongsz--add--str---
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_prcg_m.prcgsite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_prcg_m.prcgdocno = r_doctype
      #dongsz--add--end---
      
      LET g_prcg_m_t.* = g_prcg_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_prcg_m_t.* = g_prcg_m.*
      LET g_prcg_m_o.* = g_prcg_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prcg_m.prcgstus 
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
 
 
 
    
      CALL aprt561_input("a")
      
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
         INITIALIZE g_prcg_m.* TO NULL
         INITIALIZE g_prch_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aprt561_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_prch_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt561_set_act_visible()   
   CALL aprt561_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prcgdocno_t = g_prcg_m.prcgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prcgent = " ||g_enterprise|| " AND",
                      " prcgdocno = '", g_prcg_m.prcgdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt561_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aprt561_cl
   
   CALL aprt561_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aprt561_master_referesh USING g_prcg_m.prcgdocno INTO g_prcg_m.prcgsite,g_prcg_m.prcgdocdt, 
       g_prcg_m.prcgdocno,g_prcg_m.prcg001,g_prcg_m.prcg002,g_prcg_m.prcg005,g_prcg_m.prcg003,g_prcg_m.prcg004, 
       g_prcg_m.prcgunit,g_prcg_m.prcgstus,g_prcg_m.prcgownid,g_prcg_m.prcgowndp,g_prcg_m.prcgcrtid, 
       g_prcg_m.prcgcrtdp,g_prcg_m.prcgcrtdt,g_prcg_m.prcgmodid,g_prcg_m.prcgmoddt,g_prcg_m.prcgcnfid, 
       g_prcg_m.prcgcnfdt,g_prcg_m.prcgsite_desc,g_prcg_m.prcg001_desc,g_prcg_m.prcg002_desc,g_prcg_m.prcg003_desc, 
       g_prcg_m.prcg004_desc,g_prcg_m.prcgownid_desc,g_prcg_m.prcgowndp_desc,g_prcg_m.prcgcrtid_desc, 
       g_prcg_m.prcgcrtdp_desc,g_prcg_m.prcgmodid_desc,g_prcg_m.prcgcnfid_desc
   
   
   #遮罩相關處理
   LET g_prcg_m_mask_o.* =  g_prcg_m.*
   CALL aprt561_prcg_t_mask()
   LET g_prcg_m_mask_n.* =  g_prcg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prcg_m.prcgsite,g_prcg_m.prcgsite_desc,g_prcg_m.prcgdocdt,g_prcg_m.prcgdocno,g_prcg_m.prcgdocno_desc, 
       g_prcg_m.prcg001,g_prcg_m.prcg001_desc,g_prcg_m.prcg002,g_prcg_m.prcg002_desc,g_prcg_m.prcg005, 
       g_prcg_m.prcg003,g_prcg_m.prcg003_desc,g_prcg_m.prcg004,g_prcg_m.prcg004_desc,g_prcg_m.prcgunit, 
       g_prcg_m.prcgstus,g_prcg_m.prcf005,g_prcg_m.prcf006,g_prcg_m.prcf007,g_prcg_m.prcf007_desc,g_prcg_m.prcf008, 
       g_prcg_m.prcf008_desc,g_prcg_m.prcf009,g_prcg_m.prcf010,g_prcg_m.prcgownid,g_prcg_m.prcgownid_desc, 
       g_prcg_m.prcgowndp,g_prcg_m.prcgowndp_desc,g_prcg_m.prcgcrtid,g_prcg_m.prcgcrtid_desc,g_prcg_m.prcgcrtdp, 
       g_prcg_m.prcgcrtdp_desc,g_prcg_m.prcgcrtdt,g_prcg_m.prcgmodid,g_prcg_m.prcgmodid_desc,g_prcg_m.prcgmoddt, 
       g_prcg_m.prcgcnfid,g_prcg_m.prcgcnfid_desc,g_prcg_m.prcgcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_prcg_m.prcgownid      
   LET g_data_dept  = g_prcg_m.prcgowndp
   
   #功能已完成,通報訊息中心
   CALL aprt561_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aprt561.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprt561_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   IF g_prcg_m.prcgstus MATCHES "[DR]" THEN 
      let g_prcg_m.prcgstus = "N"
   END IF
   IF g_prcg_m.prcgstus<>'N' THEN
      RETURN
   END IF
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prcg_m_t.* = g_prcg_m.*
   LET g_prcg_m_o.* = g_prcg_m.*
   
   IF g_prcg_m.prcgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_prcgdocno_t = g_prcg_m.prcgdocno
 
   CALL s_transaction_begin()
   
   OPEN aprt561_cl USING g_enterprise,g_prcg_m.prcgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt561_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt561_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt561_master_referesh USING g_prcg_m.prcgdocno INTO g_prcg_m.prcgsite,g_prcg_m.prcgdocdt, 
       g_prcg_m.prcgdocno,g_prcg_m.prcg001,g_prcg_m.prcg002,g_prcg_m.prcg005,g_prcg_m.prcg003,g_prcg_m.prcg004, 
       g_prcg_m.prcgunit,g_prcg_m.prcgstus,g_prcg_m.prcgownid,g_prcg_m.prcgowndp,g_prcg_m.prcgcrtid, 
       g_prcg_m.prcgcrtdp,g_prcg_m.prcgcrtdt,g_prcg_m.prcgmodid,g_prcg_m.prcgmoddt,g_prcg_m.prcgcnfid, 
       g_prcg_m.prcgcnfdt,g_prcg_m.prcgsite_desc,g_prcg_m.prcg001_desc,g_prcg_m.prcg002_desc,g_prcg_m.prcg003_desc, 
       g_prcg_m.prcg004_desc,g_prcg_m.prcgownid_desc,g_prcg_m.prcgowndp_desc,g_prcg_m.prcgcrtid_desc, 
       g_prcg_m.prcgcrtdp_desc,g_prcg_m.prcgmodid_desc,g_prcg_m.prcgcnfid_desc
   
   #檢查是否允許此動作
   IF NOT aprt561_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prcg_m_mask_o.* =  g_prcg_m.*
   CALL aprt561_prcg_t_mask()
   LET g_prcg_m_mask_n.* =  g_prcg_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aprt561_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_prcgdocno_t = g_prcg_m.prcgdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_prcg_m.prcgmodid = g_user 
LET g_prcg_m.prcgmoddt = cl_get_current()
LET g_prcg_m.prcgmodid_desc = cl_get_username(g_prcg_m.prcgmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_prcg_m.prcgstus MATCHES "[DR]" THEN 
         LET g_prcg_m.prcgstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aprt561_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE prcg_t SET (prcgmodid,prcgmoddt) = (g_prcg_m.prcgmodid,g_prcg_m.prcgmoddt)
          WHERE prcgent = g_enterprise AND prcgdocno = g_prcgdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_prcg_m.* = g_prcg_m_t.*
            CALL aprt561_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_prcg_m.prcgdocno != g_prcg_m_t.prcgdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE prch_t SET prchdocno = g_prcg_m.prcgdocno
 
          WHERE prchent = g_enterprise AND prchdocno = g_prcg_m_t.prcgdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prch_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prch_t:",SQLERRMESSAGE 
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
   CALL aprt561_set_act_visible()   
   CALL aprt561_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " prcgent = " ||g_enterprise|| " AND",
                      " prcgdocno = '", g_prcg_m.prcgdocno, "' "
 
   #填到對應位置
   CALL aprt561_browser_fill("")
 
   CLOSE aprt561_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt561_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aprt561.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprt561_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
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
   DISPLAY BY NAME g_prcg_m.prcgsite,g_prcg_m.prcgsite_desc,g_prcg_m.prcgdocdt,g_prcg_m.prcgdocno,g_prcg_m.prcgdocno_desc, 
       g_prcg_m.prcg001,g_prcg_m.prcg001_desc,g_prcg_m.prcg002,g_prcg_m.prcg002_desc,g_prcg_m.prcg005, 
       g_prcg_m.prcg003,g_prcg_m.prcg003_desc,g_prcg_m.prcg004,g_prcg_m.prcg004_desc,g_prcg_m.prcgunit, 
       g_prcg_m.prcgstus,g_prcg_m.prcf005,g_prcg_m.prcf006,g_prcg_m.prcf007,g_prcg_m.prcf007_desc,g_prcg_m.prcf008, 
       g_prcg_m.prcf008_desc,g_prcg_m.prcf009,g_prcg_m.prcf010,g_prcg_m.prcgownid,g_prcg_m.prcgownid_desc, 
       g_prcg_m.prcgowndp,g_prcg_m.prcgowndp_desc,g_prcg_m.prcgcrtid,g_prcg_m.prcgcrtid_desc,g_prcg_m.prcgcrtdp, 
       g_prcg_m.prcgcrtdp_desc,g_prcg_m.prcgcrtdt,g_prcg_m.prcgmodid,g_prcg_m.prcgmodid_desc,g_prcg_m.prcgmoddt, 
       g_prcg_m.prcgcnfid,g_prcg_m.prcgcnfid_desc,g_prcg_m.prcgcnfdt
   
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
   LET g_forupd_sql = "SELECT prchseq,prch001,prch002,prch003,prch004,prch005,prch006,prch007,prch008, 
       prch009,prch010,prch011,prch012,prch013,prchsite,prchunit FROM prch_t WHERE prchent=? AND prchdocno=?  
       AND prchseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt561_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprt561_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aprt561_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prcg_m.prcgsite,g_prcg_m.prcgdocdt,g_prcg_m.prcgdocno,g_prcg_m.prcg001,g_prcg_m.prcg002, 
       g_prcg_m.prcg005,g_prcg_m.prcg003,g_prcg_m.prcg004,g_prcg_m.prcgunit,g_prcg_m.prcgstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001=g_site
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aprt561.input.head" >}
      #單頭段
      INPUT BY NAME g_prcg_m.prcgsite,g_prcg_m.prcgdocdt,g_prcg_m.prcgdocno,g_prcg_m.prcg001,g_prcg_m.prcg002, 
          g_prcg_m.prcg005,g_prcg_m.prcg003,g_prcg_m.prcg004,g_prcg_m.prcgunit,g_prcg_m.prcgstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aprt561_cl USING g_enterprise,g_prcg_m.prcgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt561_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt561_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aprt561_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL aprt561_set_entry(p_cmd)
            CALL aprt561_set_no_entry(p_cmd)
            #end add-point
            CALL aprt561_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgsite
            
            #add-point:AFTER FIELD prcgsite name="input.a.prcgsite"
            IF NOT cl_null(g_prcg_m.prcgsite) THEN
               CALL s_aooi500_chk(g_prog,'prcgsite',g_prcg_m.prcgsite,g_prcg_m.prcgsite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_prcg_m.prcgsite = g_prcg_m_t.prcgsite
                  CALL aprt561_prcgsite_ref()
                  DISPLAY BY NAME g_prcg_m.prcgsite
                  NEXT FIELD CURRENT
               END IF

               LET g_site_flag = TRUE
               CALL aprt561_set_entry(p_cmd)
               CALL aprt561_set_no_entry(p_cmd)
            END IF      
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prcg_m.prcgsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prcg_m.prcgsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prcg_m.prcgsite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgsite
            #add-point:BEFORE FIELD prcgsite name="input.b.prcgsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcgsite
            #add-point:ON CHANGE prcgsite name="input.g.prcgsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgdocdt
            #add-point:BEFORE FIELD prcgdocdt name="input.b.prcgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgdocdt
            
            #add-point:AFTER FIELD prcgdocdt name="input.a.prcgdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcgdocdt
            #add-point:ON CHANGE prcgdocdt name="input.g.prcgdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgdocno
            
            #add-point:AFTER FIELD prcgdocno name="input.a.prcgdocno"
            #此段落由子樣板a05產生
            LET g_prcg_m.prcgdocno_desc = NULL
            DISPLAY BY NAME g_prcg_m.prcgdocno_desc
            IF  NOT cl_null(g_prcg_m.prcgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prcg_m.prcgdocno != g_prcgdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prcg_t WHERE "||"prcgent = '" ||g_enterprise|| "' AND "||"prcgdocno = '"||g_prcg_m.prcgdocno ||"'",'std-00004',1) THEN 
                     LET g_prcg_m.prcgdocno = g_prcg_m_t.prcgdocno
                     CALL aprt561_prcgdocno_ref(p_cmd)
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aooi200_chk_slip(g_site,g_ooef004,g_prcg_m.prcgdocno,g_prog) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_prcg_m.prcgdocno = g_prcg_m_t.prcgdocno
                     CALL aprt561_prcgdocno_ref(p_cmd)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL aprt561_prcgdocno_ref(p_cmd) 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgdocno
            #add-point:BEFORE FIELD prcgdocno name="input.b.prcgdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcgdocno
            #add-point:ON CHANGE prcgdocno name="input.g.prcgdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcg001
            
            #add-point:AFTER FIELD prcg001 name="input.a.prcg001"
            LET g_prcg_m.prcg001_desc = NULL
            DISPLAY BY NAME g_prcg_m.prcg001_desc
            IF NOT cl_null(g_prcg_m.prcg001) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prcg_m.prcg001 != g_prcg_m_t.prcg001 OR g_prcg_m_t.prcg001 IS NULL )) THEN   #160824-00007#153 20161117 mark by beckxie
               IF g_prcg_m.prcg001 != g_prcg_m_o.prcg001 OR cl_null(g_prcg_m_o.prcg001) THEN   #160824-00007#153 20161117 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1=g_prcg_m.prcg001
                  LET g_chkparam.arg2='2'
                  LET g_chkparam.err_str[1] = "apr-00060:sub-01307|aprm201|",cl_get_progname("aprm201",g_lang,"2"),"|:EXEPROGaprm201"  #160318-00025#33  add
                  LET g_chkparam.err_str[2] = "apr-00059:sub-01302|aprm201|",cl_get_progname("aprm201",g_lang,"2"),"|:EXEPROGaprm201"  #160318-00025#33  add
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_prcf001_1") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_prcg_m.prcg001=g_prcg_m_t.prcg001   #160824-00007#153 20161117 mark by beckxie
                     LET g_prcg_m.prcg001=g_prcg_m_o.prcg001   #160824-00007#153 20161117 add by beckxie
                     LET g_prcg_m.prcg002=g_prcg_m_o.prcg002   #160824-00007#153 20161117 add by beckxie
                     CALL aprt561_prcg002_ref()                #160824-00007#153 20161117 add by beckxie
                     CALL aprt561_prcg001_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprt561_create_prcf002()
                  CALL aprt561_prcg002_ref()
               END IF
            END IF 
            CALL aprt561_prcg001_ref()
            LET g_prcg_m_o.* = g_prcg_m.*#160824-00007#153 20161117 add by beckxie

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcg001
            #add-point:BEFORE FIELD prcg001 name="input.b.prcg001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcg001
            #add-point:ON CHANGE prcg001 name="input.g.prcg001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcg002
            
            #add-point:AFTER FIELD prcg002 name="input.a.prcg002"
            LET g_prcg_m.prcg002_desc = NULL
            DISPLAY BY NAME g_prcg_m.prcg002_desc
            IF NOT cl_null(g_prcg_m.prcg002) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prcg_m.prcg002 != g_prcg_m_t.prcg002 OR g_prcg_m_t.prcg002 IS NULL )) THEN   #160824-00007#153 20161117 mark by beckxie
               IF g_prcg_m.prcg002 != g_prcg_m_o.prcg002 OR cl_null(g_prcg_m_o.prcg002) THEN   #160824-00007#153 20161117 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1=g_prcg_m.prcg002
                  LET g_chkparam.err_str[1] = "apr-00004:sub-01302|aprm200|",cl_get_progname("aprm200",g_lang,"2"),"|:EXEPROGaprm200"  #160318-00025#33  add
                  LET g_chkparam.err_str[2] = "apr-00003:sub-01314|aprt200|",cl_get_progname("aprt200",g_lang,"2"),"|:EXEPROGaprt200"  #160318-00025#33  add
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_prcd001") THEN
                  #檢查成功時後續處理 
                  ELSE
                  #檢查失敗時後續處理
                     #LET g_prcg_m.prcg002 = g_prcg_m_t.prcg002   #160824-00007#153 20161117 mark by beckxie 
                     LET g_prcg_m.prcg002 = g_prcg_m_o.prcg002   #160824-00007#153 20161117 add by beckxie
                     CALL aprt561_prcg002_ref()
                     NEXT FIELD CURRENT
                  END IF
            
               END IF
            END IF 
            CALL aprt561_prcg002_ref()
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcg002
            #add-point:BEFORE FIELD prcg002 name="input.b.prcg002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcg002
            #add-point:ON CHANGE prcg002 name="input.g.prcg002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcg005
            #add-point:BEFORE FIELD prcg005 name="input.b.prcg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcg005
            
            #add-point:AFTER FIELD prcg005 name="input.a.prcg005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcg005
            #add-point:ON CHANGE prcg005 name="input.g.prcg005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcg003
            
            #add-point:AFTER FIELD prcg003 name="input.a.prcg003"
            LET g_prcg_m.prcg003_desc = NULL
            DISPLAY BY NAME g_prcg_m.prcg003_desc
            IF NOT cl_null(g_prcg_m.prcg003) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prcg_m.prcg003 != g_prcg_m_t.prcg003 OR g_prcg_m_t.prcg003 IS NULL )) THEN    #160824-00007#153 20161117 mark by beckxie
               IF g_prcg_m.prcg003 != g_prcg_m_o.prcg003 OR cl_null(g_prcg_m_o.prcg003) THEN    #160824-00007#153 20161117 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1=g_prcg_m.prcg003
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#33  add
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_prcg_m.prcg003 = g_prcg_m_t.prcg003   #160824-00007#153 20161117 mark by beckxie
                     LET g_prcg_m.prcg003 = g_prcg_m_o.prcg003    #160824-00007#153 20161117 add by beckxie
                     LET g_prcg_m.prcg004 = g_prcg_m_o.prcg004    #160824-00007#153 20161117 add by beckxie
                     CALL aprt561_prcg004_ref()                   #160824-00007#153 20161117 add by beckxie
                     CALL aprt561_prcg003_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprt561_create_prcg004()
                  CALL aprt561_prcg004_ref()
               END IF

            END IF 
            CALL aprt561_prcg003_ref()

            LET g_prcg_m_o.* = g_prcg_m.*   #160824-00007#153 20161117 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcg003
            #add-point:BEFORE FIELD prcg003 name="input.b.prcg003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcg003
            #add-point:ON CHANGE prcg003 name="input.g.prcg003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcg004
            
            #add-point:AFTER FIELD prcg004 name="input.a.prcg004"
            LET g_prcg_m.prcg004_desc = null
            DISPLAY BY NAME g_prcg_m.prcg004_desc
            IF NOT cl_null(g_prcg_m.prcg004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prcg_m.prcg004 != g_prcg_m_t.prcg004 OR g_prcg_m_t.prcg004 IS NULL )) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prcg_m.prcg004
                  LET g_chkparam.arg2 = g_today
                  LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#33  add
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理 
                  ELSE
                  #檢查失敗時後續處理
                     LET g_prcg_m.prcg004 = g_prcg_m_t.prcg004
                     CALL aprt561_prcg004_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprt561_prcg003_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prcg_m.prcg004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prcg_m.prcg004 = g_prcg_m_t.prcg004
                     CALL aprt561_prcg004_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            CALL aprt561_prcg004_ref()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcg004
            #add-point:BEFORE FIELD prcg004 name="input.b.prcg004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcg004
            #add-point:ON CHANGE prcg004 name="input.g.prcg004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgunit
            #add-point:BEFORE FIELD prcgunit name="input.b.prcgunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgunit
            
            #add-point:AFTER FIELD prcgunit name="input.a.prcgunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcgunit
            #add-point:ON CHANGE prcgunit name="input.g.prcgunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcgstus
            #add-point:BEFORE FIELD prcgstus name="input.b.prcgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcgstus
            
            #add-point:AFTER FIELD prcgstus name="input.a.prcgstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcgstus
            #add-point:ON CHANGE prcgstus name="input.g.prcgstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.prcgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgsite
            #add-point:ON ACTION controlp INFIELD prcgsite name="input.c.prcgsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prcg_m.prcgsite             #給予default值

            #給予arg
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prcgsite',g_prcg_m.prcgsite,'i') #150308-00001#3 150309 pomelo add 'i'
            CALL q_ooef001_24()

            LET g_prcg_m.prcgsite = g_qryparam.return1              

            DISPLAY g_prcg_m.prcgsite TO prcgsite              #
            CALL aprt561_prcgsite_ref()

            NEXT FIELD prcgsite  
            #END add-point
 
 
         #Ctrlp:input.c.prcgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgdocdt
            #add-point:ON ACTION controlp INFIELD prcgdocdt name="input.c.prcgdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.prcgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgdocno
            #add-point:ON ACTION controlp INFIELD prcgdocno name="input.c.prcgdocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prcg_m.prcgdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004 #
            #LET g_qryparam.arg2 = "aprt561" #   #160705-00042#4 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#4 160711 by sakura add
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_prcg_m.prcgdocno = g_qryparam.return1              

            DISPLAY g_prcg_m.prcgdocno TO prcgdocno              #
            CALL aprt561_prcgdocno_ref(p_cmd)
            NEXT FIELD prcgdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prcg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcg001
            #add-point:ON ACTION controlp INFIELD prcg001 name="input.c.prcg001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prcg_m.prcg001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2" #
#            LET g_qryparam.where = "prcf009<='",g_today,"' AND (prcf010 IS NULL OR prcf010>='",g_today,"' )"
            
            CALL q_prcf001()                                #呼叫開窗

            LET g_prcg_m.prcg001 = g_qryparam.return1              

            DISPLAY g_prcg_m.prcg001 TO prcg001              #
            IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prcg_m.prcg001 != g_prcg_m_t.prcg001 OR g_prcg_m_t.prcg001 IS NULL )) THEN
               CALL aprt561_create_prcf002()
               CALL aprt561_prcg002_ref()
            END IF
            CALL aprt561_prcg001_ref()
            NEXT FIELD prcg001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prcg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcg002
            #add-point:ON ACTION controlp INFIELD prcg002 name="input.c.prcg002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prcg_m.prcg002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2" #

            
            CALL q_prcd001_1()                                #呼叫開窗

            LET g_prcg_m.prcg002 = g_qryparam.return1              

            DISPLAY g_prcg_m.prcg002 TO prcg002              #
            CALL aprt561_prcg001_ref()
            NEXT FIELD prcg002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prcg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcg005
            #add-point:ON ACTION controlp INFIELD prcg005 name="input.c.prcg005"
            
            #END add-point
 
 
         #Ctrlp:input.c.prcg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcg003
            #add-point:ON ACTION controlp INFIELD prcg003 name="input.c.prcg003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prcg_m.prcg003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001_4()                                #呼叫開窗

            LET g_prcg_m.prcg003 = g_qryparam.return1              

            DISPLAY g_prcg_m.prcg003 TO prcg003              #
            IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prcg_m.prcg003 != g_prcg_m_t.prcg003 OR g_prcg_m_t.prcg003 IS NULL )) THEN
               CALL aprt561_create_prcg004()
               CALL aprt561_prcg004_ref()
            END IF
            CALL aprt561_prcg003_ref()
            NEXT FIELD prcg003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prcg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcg004
            #add-point:ON ACTION controlp INFIELD prcg004 name="input.c.prcg004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prcg_m.prcg004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #
            IF NOT cl_null(g_prcg_m.prcg004) THEN
               LET g_qryparam.where = "ooeg001 IN ( SELECT ooag003 FROM ooag_t WHERE ooag001='",g_prcg_m.prcg003,"' AND ooagent=",g_enterprise,")"
            END IF
            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_prcg_m.prcg004 = g_qryparam.return1              

            DISPLAY g_prcg_m.prcg004 TO prcg004              #
            CALL aprt561_prcg004_ref()
            NEXT FIELD prcg004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prcgunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgunit
            #add-point:ON ACTION controlp INFIELD prcgunit name="input.c.prcgunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.prcgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcgstus
            #add-point:ON ACTION controlp INFIELD prcgstus name="input.c.prcgstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_prcg_m.prcgdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               IF NOT cl_null(g_prcg_m.prcgdocno) THEN
                  CALL s_aooi200_gen_docno(g_prcg_m.prcgsite,g_prcg_m.prcgdocno,g_prcg_m.prcgdocdt,g_prog) 
                  RETURNING  g_success,g_prcg_m.prcgdocno
                  IF g_success<>'1' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "amm-00001"
                     LET g_errparam.extend = g_prcg_m.prcgdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prcg_m.prcgdocno = g_prcg_m_t.prcgdocno
                     NEXT FIELD prcgdocno
                  ELSE
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prcg_t WHERE "||"prcgent = '" ||g_enterprise|| "' AND "||"prcgdocno = '"||g_prcg_m.prcgdocno ||"'",'std-00004',1) THEN 
                        LET g_prcg_m.prcgdocno = g_prcg_m_t.prcgdocno
                        NEXT FIELD prcgdocno
                     END IF    
                                      
                  END IF
               END IF
               CALL cl_set_comp_entry("prcgdocno",FALSE)
               #end add-point
               
               INSERT INTO prcg_t (prcgent,prcgsite,prcgdocdt,prcgdocno,prcg001,prcg002,prcg005,prcg003, 
                   prcg004,prcgunit,prcgstus,prcgownid,prcgowndp,prcgcrtid,prcgcrtdp,prcgcrtdt,prcgmodid, 
                   prcgmoddt,prcgcnfid,prcgcnfdt)
               VALUES (g_enterprise,g_prcg_m.prcgsite,g_prcg_m.prcgdocdt,g_prcg_m.prcgdocno,g_prcg_m.prcg001, 
                   g_prcg_m.prcg002,g_prcg_m.prcg005,g_prcg_m.prcg003,g_prcg_m.prcg004,g_prcg_m.prcgunit, 
                   g_prcg_m.prcgstus,g_prcg_m.prcgownid,g_prcg_m.prcgowndp,g_prcg_m.prcgcrtid,g_prcg_m.prcgcrtdp, 
                   g_prcg_m.prcgcrtdt,g_prcg_m.prcgmodid,g_prcg_m.prcgmoddt,g_prcg_m.prcgcnfid,g_prcg_m.prcgcnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_prcg_m:",SQLERRMESSAGE 
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
                  CALL aprt561_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aprt561_b_fill()
                  CALL aprt561_b_fill2('0')
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
               CALL aprt561_prcg_t_mask_restore('restore_mask_o')
               
               UPDATE prcg_t SET (prcgsite,prcgdocdt,prcgdocno,prcg001,prcg002,prcg005,prcg003,prcg004, 
                   prcgunit,prcgstus,prcgownid,prcgowndp,prcgcrtid,prcgcrtdp,prcgcrtdt,prcgmodid,prcgmoddt, 
                   prcgcnfid,prcgcnfdt) = (g_prcg_m.prcgsite,g_prcg_m.prcgdocdt,g_prcg_m.prcgdocno,g_prcg_m.prcg001, 
                   g_prcg_m.prcg002,g_prcg_m.prcg005,g_prcg_m.prcg003,g_prcg_m.prcg004,g_prcg_m.prcgunit, 
                   g_prcg_m.prcgstus,g_prcg_m.prcgownid,g_prcg_m.prcgowndp,g_prcg_m.prcgcrtid,g_prcg_m.prcgcrtdp, 
                   g_prcg_m.prcgcrtdt,g_prcg_m.prcgmodid,g_prcg_m.prcgmoddt,g_prcg_m.prcgcnfid,g_prcg_m.prcgcnfdt) 
 
                WHERE prcgent = g_enterprise AND prcgdocno = g_prcgdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "prcg_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aprt561_prcg_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_prcg_m_t)
               LET g_log2 = util.JSON.stringify(g_prcg_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_prcgdocno_t = g_prcg_m.prcgdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aprt561.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prch_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prch_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt561_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_prch_d.getLength()
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
            OPEN aprt561_cl USING g_enterprise,g_prcg_m.prcgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt561_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt561_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prch_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prch_d[l_ac].prchseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prch_d_t.* = g_prch_d[l_ac].*  #BACKUP
               LET g_prch_d_o.* = g_prch_d[l_ac].*  #BACKUP
               CALL aprt561_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aprt561_set_no_entry_b(l_cmd)
               IF NOT aprt561_lock_b("prch_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt561_bcl INTO g_prch_d[l_ac].prchseq,g_prch_d[l_ac].prch001,g_prch_d[l_ac].prch002, 
                      g_prch_d[l_ac].prch003,g_prch_d[l_ac].prch004,g_prch_d[l_ac].prch005,g_prch_d[l_ac].prch006, 
                      g_prch_d[l_ac].prch007,g_prch_d[l_ac].prch008,g_prch_d[l_ac].prch009,g_prch_d[l_ac].prch010, 
                      g_prch_d[l_ac].prch011,g_prch_d[l_ac].prch012,g_prch_d[l_ac].prch013,g_prch_d[l_ac].prchsite, 
                      g_prch_d[l_ac].prchunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_prch_d_t.prchseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prch_d_mask_o[l_ac].* =  g_prch_d[l_ac].*
                  CALL aprt561_prch_t_mask()
                  LET g_prch_d_mask_n[l_ac].* =  g_prch_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt561_show()
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
            INITIALIZE g_prch_d[l_ac].* TO NULL 
            INITIALIZE g_prch_d_t.* TO NULL 
            INITIALIZE g_prch_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_prch_d[l_ac].prch008 = "0"
      LET g_prch_d[l_ac].prch009 = "0"
      LET g_prch_d[l_ac].prch013 = "1"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_prch_d_t.* = g_prch_d[l_ac].*     #新輸入資料
            LET g_prch_d_o.* = g_prch_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt561_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt561_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prch_d[li_reproduce_target].* = g_prch_d[li_reproduce].*
 
               LET g_prch_d[li_reproduce_target].prchseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_prch_d[l_ac].prchsite = g_prcg_m.prcgsite
            LET g_prch_d[l_ac].prchunit = g_prcg_m.prcgunit
            CALL aprt561_create_prchseq()
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
            SELECT COUNT(1) INTO l_count FROM prch_t 
             WHERE prchent = g_enterprise AND prchdocno = g_prcg_m.prcgdocno
 
               AND prchseq = g_prch_d[l_ac].prchseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prcg_m.prcgdocno
               LET gs_keys[2] = g_prch_d[g_detail_idx].prchseq
               CALL aprt561_insert_b('prch_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_prch_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prch_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt561_b_fill()
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
               LET gs_keys[01] = g_prcg_m.prcgdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_prch_d_t.prchseq
 
            
               #刪除同層單身
               IF NOT aprt561_delete_b('prch_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt561_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt561_key_delete_b(gs_keys,'prch_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt561_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt561_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_prch_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prch_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prchseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prch_d[l_ac].prchseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prchseq
            END IF 
 
 
 
            #add-point:AFTER FIELD prchseq name="input.a.page1.prchseq"
            IF NOT cl_null(g_prch_d[l_ac].prchseq) THEN 
            END IF 


            #此段落由子樣板a05產生
            IF  g_prcg_m.prcgdocno IS NOT NULL AND g_prch_d[g_detail_idx].prchseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prcg_m.prcgdocno != g_prcgdocno_t OR g_prch_d[g_detail_idx].prchseq != g_prch_d_t.prchseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prch_t WHERE "||"prchent = '" ||g_enterprise|| "' AND "||"prchdocno = '"||g_prcg_m.prcgdocno ||"' AND "|| "prchseq = '"||g_prch_d[g_detail_idx].prchseq ||"'",'std-00004',1) THEN 
                     LET g_prch_d[l_ac].prchseq = g_prch_d_t.prchseq 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prchseq
            #add-point:BEFORE FIELD prchseq name="input.b.page1.prchseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prchseq
            #add-point:ON CHANGE prchseq name="input.g.page1.prchseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch001
            #add-point:BEFORE FIELD prch001 name="input.b.page1.prch001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch001
            
            #add-point:AFTER FIELD prch001 name="input.a.page1.prch001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prch001
            #add-point:ON CHANGE prch001 name="input.g.page1.prch001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch002
            
            #add-point:AFTER FIELD prch002 name="input.a.page1.prch002"
            LET g_prch_d[l_ac].prch002_desc=null
            DISPLAY g_prch_d[l_ac].prch002_desc TO s_detail1[l_ac].prch002_desc
            IF NOT cl_null(g_prch_d[l_ac].prch002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prch_d[l_ac].prch002 != g_prch_d_t.prch002 OR g_prch_d_t.prch002 IS null)) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prch_d[l_ac].prch002
                  LET g_chkparam.err_str[1] = "apm-00638:sub-01302|adbm200|",cl_get_progname("adbm200",g_lang,"2"),"|:EXEPROGadbm200"  #160318-00025#33  add
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_pmaa001_17") THEN
                  #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prch_d[l_ac].prch002 = g_prch_d_t.prch002
                     CALL aprt561_prch002_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprt561_chk_prch003()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prch_d[l_ac].prch002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prch_d[l_ac].prch002 = g_prch_d_t.prch002
                     CALL aprt561_prch002_ref()
                     NEXT FIELD CURRENT 
                  END IF
               END IF

            END IF 
            CALL aprt561_prch002_ref() 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch002
            #add-point:BEFORE FIELD prch002 name="input.b.page1.prch002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prch002
            #add-point:ON CHANGE prch002 name="input.g.page1.prch002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch003
            
            #add-point:AFTER FIELD prch003 name="input.a.page1.prch003"
            LET g_prch_d[l_ac].prch003_desc=null
            DISPLAY g_prch_d[l_ac].prch003_desc TO s_detail1[l_ac].prch003_desc
            IF NOT cl_null(g_prch_d[l_ac].prch003) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prch_d[l_ac].prch003 != g_prch_d_t.prch003 OR g_prch_d_t.prch003 IS null)) THEN    #160824-00007#153 20161117 mark by beckxie
               IF g_prch_d[l_ac].prch003 != g_prch_d_o.prch003 OR cl_null(g_prch_d_o.prch003) THEN    #160824-00007#153 20161117 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1=g_prch_d[l_ac].prch003
                  LET g_chkparam.err_str[1] = "adb-00285:sub-01302|adbm201|",cl_get_progname("adbm201",g_lang,"2"),"|:EXEPROGadbm201"  #160318-00025#33  add
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_pmaa001_14") THEN
                  #檢查成功時後續處理
                  ELSE
                     #LET g_prch_d[l_ac].prch003 = g_prch_d_t.prch003   #160824-00007#153 20161117 mark by beckxie
                     #160824-00007#153 20161117 add by beckxie---S
                     LET g_prch_d[l_ac].prch003 = g_prch_d_o.prch003
                     LET g_prch_d[l_ac].prch002 = g_prch_d_o.prch002
                     CALL aprt561_prch002_ref()
                     #160824-00007#153 20161117 add by beckxie---E
                     CALL aprt561_prch003_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprt561_chk_prch003()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prch_d[l_ac].prch003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prch_d[l_ac].prch003 = g_prch_d_t.prch003   #160824-00007#153 20161117 mark  by beckxie
                     #160824-00007#153 20161117 add by beckxie---S
                     LET g_prch_d[l_ac].prch003 = g_prch_d_o.prch003
                     LET g_prch_d[l_ac].prch002 = g_prch_d_o.prch002
                     CALL aprt561_prch002_ref()
                     #160824-00007#153 20161117 add by beckxie---E
                     CALL aprt561_prch003_ref()
                     NEXT FIELD CURRENT 
                  END IF
                  CALL aprt561_create_prch002()
               END IF

            END IF 
            CALL aprt561_prch003_ref()
            LET g_prch_d_o.* = g_prch_d[l_ac].*   #160824-00007#153 20161117 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch003
            #add-point:BEFORE FIELD prch003 name="input.b.page1.prch003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prch003
            #add-point:ON CHANGE prch003 name="input.g.page1.prch003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch004
            
            #add-point:AFTER FIELD prch004 name="input.a.page1.prch004"
            LET g_prch_d[l_ac].prch004_desc=null
            DISPLAY g_prch_d[l_ac].prch004_desc
                 TO s_detail1[l_ac].prch004_desc
            IF NOT cl_null(g_prch_d[l_ac].prch004) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prch_d[l_ac].prch004 != g_prch_d_t.prch004 OR g_prch_d_t.prch004 IS null)) THEN    #160824-00007#153 20161117 mark by beckxie
               IF g_prch_d[l_ac].prch004 != g_prch_d_o.prch004 OR cl_null(g_prch_d_o.prch004) THEN    #160824-00007#153 20161117 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1=g_prch_d[l_ac].prch004
                  LET g_chkparam.arg2=g_prcg_m.prcgsite
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_dbbc001_1") THEN
                     #檢查成功時後續處理
                  ELSE
                  #檢查失敗時後續處理
                     #LET g_prch_d[l_ac].prch004 = g_prch_d_t.prch004   #160824-00007#153 20161117 mark by beckxie
                     #160824-00007#153 20161117 add by beckxie---S
                     LET g_prch_d[l_ac].prch004 = g_prch_d_o.prch004   
                     LET g_prch_d[l_ac].prch005 = g_prch_d_o.prch005
                     LET g_prch_d[l_ac].prch006 = g_prch_d_o.prch006
                     LET g_prch_d[l_ac].prch007 = g_prch_d_o.prch007
                     CALL aprt561_prch005_ref()
                     CALL aprt561_prch006_ref()
                     CALL aprt561_prch007_ref()
                     #160824-00007#153 20161117 add by beckxie---E
                     CALL aprt561_prch004_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprt561_create_prch005()
               END IF
              
            END IF 
            CALL aprt561_prch004_ref()
            LET g_prch_d_o.* = g_prch_d[l_ac].*   #160824-00007#153 20161117 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch004
            #add-point:BEFORE FIELD prch004 name="input.b.page1.prch004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prch004
            #add-point:ON CHANGE prch004 name="input.g.page1.prch004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch005
            
            #add-point:AFTER FIELD prch005 name="input.a.page1.prch005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prch_d[l_ac].prch005
            CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prch_d[l_ac].prch005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prch_d[l_ac].prch005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch005
            #add-point:BEFORE FIELD prch005 name="input.b.page1.prch005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prch005
            #add-point:ON CHANGE prch005 name="input.g.page1.prch005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch006
            
            #add-point:AFTER FIELD prch006 name="input.a.page1.prch006"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prch_d[l_ac].prch006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prch_d[l_ac].prch006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prch_d[l_ac].prch006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch006
            #add-point:BEFORE FIELD prch006 name="input.b.page1.prch006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prch006
            #add-point:ON CHANGE prch006 name="input.g.page1.prch006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch007
            
            #add-point:AFTER FIELD prch007 name="input.a.page1.prch007"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prch_d[l_ac].prch007
            CALL ap_ref_array2(g_ref_fields,"SELECT dbbal003 FROM dbbal_t WHERE dbbalent='"||g_enterprise||"' AND dbbal001=? AND dbbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prch_d[l_ac].prch007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prch_d[l_ac].prch007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch007
            #add-point:BEFORE FIELD prch007 name="input.b.page1.prch007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prch007
            #add-point:ON CHANGE prch007 name="input.g.page1.prch007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prch_d[l_ac].prch008,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prch008
            END IF 
 
 
 
            #add-point:AFTER FIELD prch008 name="input.a.page1.prch008"
            IF NOT cl_null(g_prch_d[l_ac].prch008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch008
            #add-point:BEFORE FIELD prch008 name="input.b.page1.prch008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prch008
            #add-point:ON CHANGE prch008 name="input.g.page1.prch008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prch_d[l_ac].prch009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prch009
            END IF 
 
 
 
            #add-point:AFTER FIELD prch009 name="input.a.page1.prch009"
            IF NOT cl_null(g_prch_d[l_ac].prch009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch009
            #add-point:BEFORE FIELD prch009 name="input.b.page1.prch009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prch009
            #add-point:ON CHANGE prch009 name="input.g.page1.prch009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prch_d[l_ac].prch010,"0.000","1","100.000","1","azz-00087",1) THEN 
 
               NEXT FIELD prch010
            END IF 
 
 
 
            #add-point:AFTER FIELD prch010 name="input.a.page1.prch010"
            IF NOT cl_null(g_prch_d[l_ac].prch010) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch010
            #add-point:BEFORE FIELD prch010 name="input.b.page1.prch010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prch010
            #add-point:ON CHANGE prch010 name="input.g.page1.prch010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prch_d[l_ac].prch011,"0.000","1","100.000","1","azz-00087",1) THEN 
 
               NEXT FIELD prch011
            END IF 
 
 
 
            #add-point:AFTER FIELD prch011 name="input.a.page1.prch011"
            IF NOT cl_null(g_prch_d[l_ac].prch011) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch011
            #add-point:BEFORE FIELD prch011 name="input.b.page1.prch011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prch011
            #add-point:ON CHANGE prch011 name="input.g.page1.prch011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prch_d[l_ac].prch012,"0.000","1","100.000","1","azz-00087",1) THEN 
 
               NEXT FIELD prch012
            END IF 
 
 
 
            #add-point:AFTER FIELD prch012 name="input.a.page1.prch012"
            IF NOT cl_null(g_prch_d[l_ac].prch012) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch012
            #add-point:BEFORE FIELD prch012 name="input.b.page1.prch012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prch012
            #add-point:ON CHANGE prch012 name="input.g.page1.prch012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prch013
            #add-point:BEFORE FIELD prch013 name="input.b.page1.prch013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prch013
            
            #add-point:AFTER FIELD prch013 name="input.a.page1.prch013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prch013
            #add-point:ON CHANGE prch013 name="input.g.page1.prch013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prchsite
            #add-point:BEFORE FIELD prchsite name="input.b.page1.prchsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prchsite
            
            #add-point:AFTER FIELD prchsite name="input.a.page1.prchsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prchsite
            #add-point:ON CHANGE prchsite name="input.g.page1.prchsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prchunit
            #add-point:BEFORE FIELD prchunit name="input.b.page1.prchunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prchunit
            
            #add-point:AFTER FIELD prchunit name="input.a.page1.prchunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prchunit
            #add-point:ON CHANGE prchunit name="input.g.page1.prchunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.prchseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prchseq
            #add-point:ON ACTION controlp INFIELD prchseq name="input.c.page1.prchseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prch001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch001
            #add-point:ON ACTION controlp INFIELD prch001 name="input.c.page1.prch001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prch002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch002
            #add-point:ON ACTION controlp INFIELD prch002 name="input.c.page1.prch002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prch_d[l_ac].prch002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1" #客戶性質
            LET g_qryparam.arg2 = "2" #客戶經營類別
            IF NOT cl_null(g_prch_d[l_ac].prch003) THEN
               LET g_qryparam.where = "pmaa001 in (SELECT pmaa006 from pmaa_t where pmaaent=",g_enterprise," AND pmaa001='",g_prch_d[l_ac].prch003,"' ) "#  
            END IF
            
            CALL q_pmaa001_12()                                #呼叫開窗

            LET g_prch_d[l_ac].prch002 = g_qryparam.return1              

            DISPLAY g_prch_d[l_ac].prch002 TO prch002              #
            call aprt561_prch002_ref()
            NEXT FIELD prch002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prch003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch003
            #add-point:ON ACTION controlp INFIELD prch003 name="input.c.page1.prch003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prch_d[l_ac].prch003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            IF NOT cl_null(g_prch_d[l_ac].prch002) THEN
               LET g_qryparam.where = "pmaa006='",g_prch_d[l_ac].prch002,"' "#  
            END IF
            
            CALL q_pmaa001_18()                                #呼叫開窗

            LET g_prch_d[l_ac].prch003 = g_qryparam.return1              

            DISPLAY g_prch_d[l_ac].prch003 TO prch003              #
            CALL aprt561_prch003_ref()
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prch_d[l_ac].prch003 != g_prch_d_t.prch003 OR g_prch_d_t.prch003 IS null)) THEN 
               CALL aprt561_create_prch002()
            END IF   
            NEXT FIELD prch003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prch004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch004
            #add-point:ON ACTION controlp INFIELD prch004 name="input.c.page1.prch004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prch_d[l_ac].prch004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = "dbbc002='",g_prcg_m.prcgsite,"'" #   
            
            CALL q_dbbc001()                                #呼叫開窗

            LET g_prch_d[l_ac].prch004 = g_qryparam.return1              

            DISPLAY g_prch_d[l_ac].prch004 TO prch004              #
            CALL aprt561_prch004_ref()
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prch_d[l_ac].prch004 != g_prch_d_t.prch004 OR g_prch_d_t.prch004 IS null)) THEN 
               CALL aprt561_create_prch005()
            END IF   
            NEXT FIELD prch004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prch005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch005
            #add-point:ON ACTION controlp INFIELD prch005 name="input.c.page1.prch005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prch_d[l_ac].prch005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oojd001()                                #呼叫開窗

            LET g_prch_d[l_ac].prch005 = g_qryparam.return1              

            DISPLAY g_prch_d[l_ac].prch005 TO prch005              #

            NEXT FIELD prch005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prch006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch006
            #add-point:ON ACTION controlp INFIELD prch006 name="input.c.page1.prch006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prch_d[l_ac].prch006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " ooef305 = 'Y' "
            
            CALL q_ooef001()                                #呼叫開窗

            LET g_prch_d[l_ac].prch006 = g_qryparam.return1              

            DISPLAY g_prch_d[l_ac].prch006 TO prch006              #

            NEXT FIELD prch006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prch007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch007
            #add-point:ON ACTION controlp INFIELD prch007 name="input.c.page1.prch007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prch_d[l_ac].prch007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_dbba001()                                #呼叫開窗

            LET g_prch_d[l_ac].prch007 = g_qryparam.return1              

            DISPLAY g_prch_d[l_ac].prch007 TO prch007              #

            NEXT FIELD prch007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prch008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch008
            #add-point:ON ACTION controlp INFIELD prch008 name="input.c.page1.prch008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prch009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch009
            #add-point:ON ACTION controlp INFIELD prch009 name="input.c.page1.prch009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prch010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch010
            #add-point:ON ACTION controlp INFIELD prch010 name="input.c.page1.prch010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prch011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch011
            #add-point:ON ACTION controlp INFIELD prch011 name="input.c.page1.prch011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prch012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch012
            #add-point:ON ACTION controlp INFIELD prch012 name="input.c.page1.prch012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prch013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prch013
            #add-point:ON ACTION controlp INFIELD prch013 name="input.c.page1.prch013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prchsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prchsite
            #add-point:ON ACTION controlp INFIELD prchsite name="input.c.page1.prchsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prchunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prchunit
            #add-point:ON ACTION controlp INFIELD prchunit name="input.c.page1.prchunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prch_d[l_ac].* = g_prch_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt561_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_prch_d[l_ac].prchseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prch_d[l_ac].* = g_prch_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aprt561_prch_t_mask_restore('restore_mask_o')
      
               UPDATE prch_t SET (prchdocno,prchseq,prch001,prch002,prch003,prch004,prch005,prch006, 
                   prch007,prch008,prch009,prch010,prch011,prch012,prch013,prchsite,prchunit) = (g_prcg_m.prcgdocno, 
                   g_prch_d[l_ac].prchseq,g_prch_d[l_ac].prch001,g_prch_d[l_ac].prch002,g_prch_d[l_ac].prch003, 
                   g_prch_d[l_ac].prch004,g_prch_d[l_ac].prch005,g_prch_d[l_ac].prch006,g_prch_d[l_ac].prch007, 
                   g_prch_d[l_ac].prch008,g_prch_d[l_ac].prch009,g_prch_d[l_ac].prch010,g_prch_d[l_ac].prch011, 
                   g_prch_d[l_ac].prch012,g_prch_d[l_ac].prch013,g_prch_d[l_ac].prchsite,g_prch_d[l_ac].prchunit) 
 
                WHERE prchent = g_enterprise AND prchdocno = g_prcg_m.prcgdocno 
 
                  AND prchseq = g_prch_d_t.prchseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prch_d[l_ac].* = g_prch_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prch_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prch_d[l_ac].* = g_prch_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prch_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prcg_m.prcgdocno
               LET gs_keys_bak[1] = g_prcgdocno_t
               LET gs_keys[2] = g_prch_d[g_detail_idx].prchseq
               LET gs_keys_bak[2] = g_prch_d_t.prchseq
               CALL aprt561_update_b('prch_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aprt561_prch_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_prch_d[g_detail_idx].prchseq = g_prch_d_t.prchseq 
 
                  ) THEN
                  LET gs_keys[01] = g_prcg_m.prcgdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_prch_d_t.prchseq
 
                  CALL aprt561_key_update_b(gs_keys,'prch_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prcg_m),util.JSON.stringify(g_prch_d_t)
               LET g_log2 = util.JSON.stringify(g_prcg_m),util.JSON.stringify(g_prch_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aprt561_unlock_b("prch_t","'1'")
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
               LET g_prch_d[li_reproduce_target].* = g_prch_d[li_reproduce].*
 
               LET g_prch_d[li_reproduce_target].prchseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_prch_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prch_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aprt561.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD prcgsite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prchseq
 
               #add-point:input段modify_detail 

               #end add-point  
            END CASE
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD prcgdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prchseq
 
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
 
{<section id="aprt561.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprt561_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aprt561_b_fill() #單身填充
      CALL aprt561_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aprt561_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

            CALL aprt561_prcg001_ref()
            CALL aprt561_prcgdocno_ref('u')
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prcg_m.prcgsite
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prcg_m.prcgsite_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prcg_m.prcgsite_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prcg_m.prcg001
#            CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prcg_m.prcg001_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prcg_m.prcg001_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prcg_m.prcg002
#            CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prcg_m.prcg002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prcg_m.prcg002_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prcg_m.prcg003
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prcg_m.prcg003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prcg_m.prcg003_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prcg_m.prcg004
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prcg_m.prcg004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prcg_m.prcg004_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prcg_m.prcgownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prcg_m.prcgownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prcg_m.prcgownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prcg_m.prcgowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prcg_m.prcgowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prcg_m.prcgowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prcg_m.prcgcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prcg_m.prcgcrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prcg_m.prcgcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prcg_m.prcgcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prcg_m.prcgcrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prcg_m.prcgcrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prcg_m.prcgmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prcg_m.prcgmodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prcg_m.prcgmodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prcg_m.prcgcnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prcg_m.prcgcnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prcg_m.prcgcnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_prcg_m_mask_o.* =  g_prcg_m.*
   CALL aprt561_prcg_t_mask()
   LET g_prcg_m_mask_n.* =  g_prcg_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prcg_m.prcgsite,g_prcg_m.prcgsite_desc,g_prcg_m.prcgdocdt,g_prcg_m.prcgdocno,g_prcg_m.prcgdocno_desc, 
       g_prcg_m.prcg001,g_prcg_m.prcg001_desc,g_prcg_m.prcg002,g_prcg_m.prcg002_desc,g_prcg_m.prcg005, 
       g_prcg_m.prcg003,g_prcg_m.prcg003_desc,g_prcg_m.prcg004,g_prcg_m.prcg004_desc,g_prcg_m.prcgunit, 
       g_prcg_m.prcgstus,g_prcg_m.prcf005,g_prcg_m.prcf006,g_prcg_m.prcf007,g_prcg_m.prcf007_desc,g_prcg_m.prcf008, 
       g_prcg_m.prcf008_desc,g_prcg_m.prcf009,g_prcg_m.prcf010,g_prcg_m.prcgownid,g_prcg_m.prcgownid_desc, 
       g_prcg_m.prcgowndp,g_prcg_m.prcgowndp_desc,g_prcg_m.prcgcrtid,g_prcg_m.prcgcrtid_desc,g_prcg_m.prcgcrtdp, 
       g_prcg_m.prcgcrtdp_desc,g_prcg_m.prcgcrtdt,g_prcg_m.prcgmodid,g_prcg_m.prcgmodid_desc,g_prcg_m.prcgmoddt, 
       g_prcg_m.prcgcnfid,g_prcg_m.prcgcnfid_desc,g_prcg_m.prcgcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prcg_m.prcgstus 
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
   FOR l_ac = 1 TO g_prch_d.getLength()
      #add-point:show段單身reference name="show.body.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prch_d[l_ac].prch002
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prch_d[l_ac].prch002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prch_d[l_ac].prch002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prch_d[l_ac].prch003
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prch_d[l_ac].prch003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prch_d[l_ac].prch003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prch_d[l_ac].prch004
            CALL ap_ref_array2(g_ref_fields,"SELECT dbbcl003 FROM dbbcl_t WHERE dbbclent='"||g_enterprise||"' AND dbbcl001=? AND dbbcl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prch_d[l_ac].prch004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prch_d[l_ac].prch004_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prch_d[l_ac].prch005
            CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prch_d[l_ac].prch005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prch_d[l_ac].prch005_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prch_d[l_ac].prch006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prch_d[l_ac].prch006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prch_d[l_ac].prch006_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prch_d[l_ac].prch007
            CALL ap_ref_array2(g_ref_fields,"SELECT dbbal003 FROM dbbal_t WHERE dbbalent='"||g_enterprise||"' AND dbbal001=? AND dbbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prch_d[l_ac].prch007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prch_d[l_ac].prch007_desc

      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprt561_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprt561.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aprt561_detail_show()
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
 
{<section id="aprt561.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprt561_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE prcg_t.prcgdocno 
   DEFINE l_oldno     LIKE prcg_t.prcgdocno 
 
   DEFINE l_master    RECORD LIKE prcg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE prch_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   IF g_prcg_m.prcgsite<>g_site THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "apr-00309"
      LET g_errparam.extend = g_prcg_m.prcgdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
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
   
   IF g_prcg_m.prcgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_prcgdocno_t = g_prcg_m.prcgdocno
 
    
   LET g_prcg_m.prcgdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prcg_m.prcgownid = g_user
      LET g_prcg_m.prcgowndp = g_dept
      LET g_prcg_m.prcgcrtid = g_user
      LET g_prcg_m.prcgcrtdp = g_dept 
      LET g_prcg_m.prcgcrtdt = cl_get_current()
      LET g_prcg_m.prcgmodid = g_user
      LET g_prcg_m.prcgmoddt = cl_get_current()
      LET g_prcg_m.prcgstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_prcg_m.prcgcnfid = ""
   LET g_prcg_m.prcgcnfdt = ""
   LET g_prcg_m.prcgstus = "N"
   LET g_prcg_m.prcgdocdt = g_today
   LET g_prcg_m.prcgsite = g_site
   CALL aprt561_prcgsite_ref()
   LET g_prcg_m.prcg003 = g_user
   CALL aprt561_create_prcg004()
   CALL aprt561_prcg003_ref()
   CALL aprt561_prcg004_ref()
   
   #dongsz--add--str---
   #預設單據的單別
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_prcg_m.prcgsite,g_prog,'1')
        RETURNING r_success,r_doctype
   LET g_prcg_m.prcgdocno = r_doctype
   #dongsz--add--end---
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prcg_m.prcgstus 
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
      LET g_prcg_m.prcgdocno_desc = ''
   DISPLAY BY NAME g_prcg_m.prcgdocno_desc
 
   
   CALL aprt561_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_prcg_m.* TO NULL
      INITIALIZE g_prch_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aprt561_show()
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
   CALL aprt561_set_act_visible()   
   CALL aprt561_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prcgdocno_t = g_prcg_m.prcgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prcgent = " ||g_enterprise|| " AND",
                      " prcgdocno = '", g_prcg_m.prcgdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt561_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aprt561_idx_chk()
   
   LET g_data_owner = g_prcg_m.prcgownid      
   LET g_data_dept  = g_prcg_m.prcgowndp
   
   #功能已完成,通報訊息中心
   CALL aprt561_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt561.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprt561_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prch_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprt561_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prch_t
    WHERE prchent = g_enterprise AND prchdocno = g_prcgdocno_t
 
    INTO TEMP aprt561_detail
 
   #將key修正為調整後   
   UPDATE aprt561_detail 
      #更新key欄位
      SET prchdocno = g_prcg_m.prcgdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO prch_t SELECT * FROM aprt561_detail
   
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
   DROP TABLE aprt561_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_prcgdocno_t = g_prcg_m.prcgdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprt561.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprt561_delete()
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
   
   IF g_prcg_m.prcgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aprt561_cl USING g_enterprise,g_prcg_m.prcgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt561_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt561_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt561_master_referesh USING g_prcg_m.prcgdocno INTO g_prcg_m.prcgsite,g_prcg_m.prcgdocdt, 
       g_prcg_m.prcgdocno,g_prcg_m.prcg001,g_prcg_m.prcg002,g_prcg_m.prcg005,g_prcg_m.prcg003,g_prcg_m.prcg004, 
       g_prcg_m.prcgunit,g_prcg_m.prcgstus,g_prcg_m.prcgownid,g_prcg_m.prcgowndp,g_prcg_m.prcgcrtid, 
       g_prcg_m.prcgcrtdp,g_prcg_m.prcgcrtdt,g_prcg_m.prcgmodid,g_prcg_m.prcgmoddt,g_prcg_m.prcgcnfid, 
       g_prcg_m.prcgcnfdt,g_prcg_m.prcgsite_desc,g_prcg_m.prcg001_desc,g_prcg_m.prcg002_desc,g_prcg_m.prcg003_desc, 
       g_prcg_m.prcg004_desc,g_prcg_m.prcgownid_desc,g_prcg_m.prcgowndp_desc,g_prcg_m.prcgcrtid_desc, 
       g_prcg_m.prcgcrtdp_desc,g_prcg_m.prcgmodid_desc,g_prcg_m.prcgcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aprt561_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prcg_m_mask_o.* =  g_prcg_m.*
   CALL aprt561_prcg_t_mask()
   LET g_prcg_m_mask_n.* =  g_prcg_m.*
   
   CALL aprt561_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aprt561_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_prcgdocno_t = g_prcg_m.prcgdocno
 
 
      DELETE FROM prcg_t
       WHERE prcgent = g_enterprise AND prcgdocno = g_prcg_m.prcgdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_prcg_m.prcgdocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM prch_t
       WHERE prchent = g_enterprise AND prchdocno = g_prcg_m.prcgdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prch_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_prcg_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aprt561_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_prch_d.clear() 
 
     
      CALL aprt561_ui_browser_refresh()  
      #CALL aprt561_ui_headershow()  
      #CALL aprt561_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aprt561_browser_fill("")
         CALL aprt561_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprt561_cl
 
   #功能已完成,通報訊息中心
   CALL aprt561_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aprt561.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprt561_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_prch_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aprt561_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prchseq,prch001,prch002,prch003,prch004,prch005,prch006,prch007, 
             prch008,prch009,prch010,prch011,prch012,prch013,prchsite,prchunit  FROM prch_t",   
                     " INNER JOIN prcg_t ON prcgent = " ||g_enterprise|| " AND prcgdocno = prchdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE prchent=? AND prchdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prch_t.prchseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt561_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aprt561_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_prcg_m.prcgdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_prcg_m.prcgdocno INTO g_prch_d[l_ac].prchseq,g_prch_d[l_ac].prch001, 
          g_prch_d[l_ac].prch002,g_prch_d[l_ac].prch003,g_prch_d[l_ac].prch004,g_prch_d[l_ac].prch005, 
          g_prch_d[l_ac].prch006,g_prch_d[l_ac].prch007,g_prch_d[l_ac].prch008,g_prch_d[l_ac].prch009, 
          g_prch_d[l_ac].prch010,g_prch_d[l_ac].prch011,g_prch_d[l_ac].prch012,g_prch_d[l_ac].prch013, 
          g_prch_d[l_ac].prchsite,g_prch_d[l_ac].prchunit   #(ver:78)
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
   
   CALL g_prch_d.deleteElement(g_prch_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprt561_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_prch_d.getLength()
      LET g_prch_d_mask_o[l_ac].* =  g_prch_d[l_ac].*
      CALL aprt561_prch_t_mask()
      LET g_prch_d_mask_n[l_ac].* =  g_prch_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aprt561.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprt561_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM prch_t
       WHERE prchent = g_enterprise AND
         prchdocno = ps_keys_bak[1] AND prchseq = ps_keys_bak[2]
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
         CALL g_prch_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt561.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprt561_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO prch_t
                  (prchent,
                   prchdocno,
                   prchseq
                   ,prch001,prch002,prch003,prch004,prch005,prch006,prch007,prch008,prch009,prch010,prch011,prch012,prch013,prchsite,prchunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prch_d[g_detail_idx].prch001,g_prch_d[g_detail_idx].prch002,g_prch_d[g_detail_idx].prch003, 
                       g_prch_d[g_detail_idx].prch004,g_prch_d[g_detail_idx].prch005,g_prch_d[g_detail_idx].prch006, 
                       g_prch_d[g_detail_idx].prch007,g_prch_d[g_detail_idx].prch008,g_prch_d[g_detail_idx].prch009, 
                       g_prch_d[g_detail_idx].prch010,g_prch_d[g_detail_idx].prch011,g_prch_d[g_detail_idx].prch012, 
                       g_prch_d[g_detail_idx].prch013,g_prch_d[g_detail_idx].prchsite,g_prch_d[g_detail_idx].prchunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prch_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_prch_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aprt561.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprt561_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prch_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aprt561_prch_t_mask_restore('restore_mask_o')
               
      UPDATE prch_t 
         SET (prchdocno,
              prchseq
              ,prch001,prch002,prch003,prch004,prch005,prch006,prch007,prch008,prch009,prch010,prch011,prch012,prch013,prchsite,prchunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prch_d[g_detail_idx].prch001,g_prch_d[g_detail_idx].prch002,g_prch_d[g_detail_idx].prch003, 
                  g_prch_d[g_detail_idx].prch004,g_prch_d[g_detail_idx].prch005,g_prch_d[g_detail_idx].prch006, 
                  g_prch_d[g_detail_idx].prch007,g_prch_d[g_detail_idx].prch008,g_prch_d[g_detail_idx].prch009, 
                  g_prch_d[g_detail_idx].prch010,g_prch_d[g_detail_idx].prch011,g_prch_d[g_detail_idx].prch012, 
                  g_prch_d[g_detail_idx].prch013,g_prch_d[g_detail_idx].prchsite,g_prch_d[g_detail_idx].prchunit)  
 
         WHERE prchent = g_enterprise AND prchdocno = ps_keys_bak[1] AND prchseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prch_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prch_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt561_prch_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aprt561.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aprt561_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt561.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aprt561_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt561.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprt561_lock_b(ps_table,ps_page)
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
   #CALL aprt561_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "prch_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprt561_bcl USING g_enterprise,
                                       g_prcg_m.prcgdocno,g_prch_d[g_detail_idx].prchseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt561_bcl:",SQLERRMESSAGE 
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
 
{<section id="aprt561.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprt561_unlock_b(ps_table,ps_page)
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
      CLOSE aprt561_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprt561.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprt561_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("prcgdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("prcgdocno",TRUE)
      CALL cl_set_comp_entry("prcgdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("prcgsite",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt561.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprt561_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("prcgdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("prcgdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("prcgdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'prcgsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("prcgsite",FALSE)
   END IF 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt561.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprt561_set_entry_b(p_cmd)
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
 
{<section id="aprt561.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprt561_set_no_entry_b(p_cmd)
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
 
{<section id="aprt561.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aprt561_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt561.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aprt561_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_prcg_m.prcgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt561.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aprt561_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt561.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aprt561_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt561.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprt561_default_search()
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
      LET ls_wc = ls_wc, " prcgdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "prcg_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prch_t" 
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
 
{<section id="aprt561.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aprt561_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success      LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
#   IF g_prcg_m.prcgstus='X' THEN
#      RETURN
#   END IF
   IF g_prcg_m.prcgstus = 'C' THEN  #結案狀態
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_prcg_m.prcgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aprt561_cl USING g_enterprise,g_prcg_m.prcgdocno
   IF STATUS THEN
      CLOSE aprt561_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt561_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aprt561_master_referesh USING g_prcg_m.prcgdocno INTO g_prcg_m.prcgsite,g_prcg_m.prcgdocdt, 
       g_prcg_m.prcgdocno,g_prcg_m.prcg001,g_prcg_m.prcg002,g_prcg_m.prcg005,g_prcg_m.prcg003,g_prcg_m.prcg004, 
       g_prcg_m.prcgunit,g_prcg_m.prcgstus,g_prcg_m.prcgownid,g_prcg_m.prcgowndp,g_prcg_m.prcgcrtid, 
       g_prcg_m.prcgcrtdp,g_prcg_m.prcgcrtdt,g_prcg_m.prcgmodid,g_prcg_m.prcgmoddt,g_prcg_m.prcgcnfid, 
       g_prcg_m.prcgcnfdt,g_prcg_m.prcgsite_desc,g_prcg_m.prcg001_desc,g_prcg_m.prcg002_desc,g_prcg_m.prcg003_desc, 
       g_prcg_m.prcg004_desc,g_prcg_m.prcgownid_desc,g_prcg_m.prcgowndp_desc,g_prcg_m.prcgcrtid_desc, 
       g_prcg_m.prcgcrtdp_desc,g_prcg_m.prcgmodid_desc,g_prcg_m.prcgcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aprt561_action_chk() THEN
      CLOSE aprt561_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prcg_m.prcgsite,g_prcg_m.prcgsite_desc,g_prcg_m.prcgdocdt,g_prcg_m.prcgdocno,g_prcg_m.prcgdocno_desc, 
       g_prcg_m.prcg001,g_prcg_m.prcg001_desc,g_prcg_m.prcg002,g_prcg_m.prcg002_desc,g_prcg_m.prcg005, 
       g_prcg_m.prcg003,g_prcg_m.prcg003_desc,g_prcg_m.prcg004,g_prcg_m.prcg004_desc,g_prcg_m.prcgunit, 
       g_prcg_m.prcgstus,g_prcg_m.prcf005,g_prcg_m.prcf006,g_prcg_m.prcf007,g_prcg_m.prcf007_desc,g_prcg_m.prcf008, 
       g_prcg_m.prcf008_desc,g_prcg_m.prcf009,g_prcg_m.prcf010,g_prcg_m.prcgownid,g_prcg_m.prcgownid_desc, 
       g_prcg_m.prcgowndp,g_prcg_m.prcgowndp_desc,g_prcg_m.prcgcrtid,g_prcg_m.prcgcrtid_desc,g_prcg_m.prcgcrtdp, 
       g_prcg_m.prcgcrtdp_desc,g_prcg_m.prcgcrtdt,g_prcg_m.prcgmodid,g_prcg_m.prcgmodid_desc,g_prcg_m.prcgmoddt, 
       g_prcg_m.prcgcnfid,g_prcg_m.prcgcnfid_desc,g_prcg_m.prcgcnfdt
 
   CASE g_prcg_m.prcgstus
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
         CASE g_prcg_m.prcgstus
            
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
#      CALL cl_set_act_visible("unconfirmed,invalid,confirmed", true)
#      IF g_prcg_m.prcgstus = 'N' THEN
#         CALL cl_set_act_visible("invalid,confirmed", true)
#         CALL cl_set_act_visible("unconfirmed", FALSE)      
#      END IF
#      IF g_prcg_m.prcgstus = 'Y' THEN
#         CALL cl_set_act_visible("unconfirmed", TRUE)
#         CALL cl_set_act_visible("invalid,confirmed", FALSE)      
#      END IF
#      IF g_prcg_m.prcgstus = 'X' THEN
#         CALL cl_set_act_visible("invalid,confirmed,unconfirmed", FALSE)
#      END IF
#      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("signing,withdraw",FALSE)       #160809-00039#1  by 08172
#      CALL cl_set_act_visible("closed",FALSE)

      CASE g_prcg_m.prcgstus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE) 
          
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)

      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aprt561_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt561_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aprt561_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt561_cl
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
      g_prcg_m.prcgstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aprt561_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   SELECT prcgstus INTO  g_prcg_m.prcgstus FROM prcg_t WHERE prcgdocno = g_prcg_m.prcgdocno
      AND prcgent = g_enterprise
   CASE 
      WHEN lc_state = 'Y' AND g_prcg_m.prcgstus = 'N'            
         CALL s_aprt561_conf_chk(g_prcg_m.prcgdocno,g_prcg_m.prcgstus) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('lib-014') THEN
               CALL s_transaction_begin()
               CALL s_aprt561_conf_upd(g_prcg_m.prcgdocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')               
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
               RETURN
            END IF            
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
            RETURN            
         END IF
                
      WHEN lc_state = 'X' AND g_prcg_m.prcgstus = 'N' 
         CALL s_aprt561_void_chk(g_prcg_m.prcgdocno,g_prcg_m.prcgstus) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_aprt561_void_upd(g_prcg_m.prcgdocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
            RETURN    
         END IF
      WHEN lc_state = 'N' AND g_prcg_m.prcgstus = 'Y' 
         SELECT prcgstus INTO  g_prcg_m.prcgstus FROM prcg_t WHERE prcgdocno = g_prcg_m.prcgdocno
            AND prcgent = g_enterprise
         CALL s_aprt561_unconf_chk(g_prcg_m.prcgdocno,g_prcg_m.prcgstus) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('lib-015') THEN
               CALL s_transaction_begin()
               CALL s_aprt561_unconf_upd(g_prcg_m.prcgdocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
            RETURN    
         END IF
            
      
      OTHERWISE 
         CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
         RETURN     
   END CASE
   #end add-point
   
   LET g_prcg_m.prcgmodid = g_user
   LET g_prcg_m.prcgmoddt = cl_get_current()
   LET g_prcg_m.prcgstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE prcg_t 
      SET (prcgstus,prcgmodid,prcgmoddt) 
        = (g_prcg_m.prcgstus,g_prcg_m.prcgmodid,g_prcg_m.prcgmoddt)     
    WHERE prcgent = g_enterprise AND prcgdocno = g_prcg_m.prcgdocno
 
    
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
      EXECUTE aprt561_master_referesh USING g_prcg_m.prcgdocno INTO g_prcg_m.prcgsite,g_prcg_m.prcgdocdt, 
          g_prcg_m.prcgdocno,g_prcg_m.prcg001,g_prcg_m.prcg002,g_prcg_m.prcg005,g_prcg_m.prcg003,g_prcg_m.prcg004, 
          g_prcg_m.prcgunit,g_prcg_m.prcgstus,g_prcg_m.prcgownid,g_prcg_m.prcgowndp,g_prcg_m.prcgcrtid, 
          g_prcg_m.prcgcrtdp,g_prcg_m.prcgcrtdt,g_prcg_m.prcgmodid,g_prcg_m.prcgmoddt,g_prcg_m.prcgcnfid, 
          g_prcg_m.prcgcnfdt,g_prcg_m.prcgsite_desc,g_prcg_m.prcg001_desc,g_prcg_m.prcg002_desc,g_prcg_m.prcg003_desc, 
          g_prcg_m.prcg004_desc,g_prcg_m.prcgownid_desc,g_prcg_m.prcgowndp_desc,g_prcg_m.prcgcrtid_desc, 
          g_prcg_m.prcgcrtdp_desc,g_prcg_m.prcgmodid_desc,g_prcg_m.prcgcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_prcg_m.prcgsite,g_prcg_m.prcgsite_desc,g_prcg_m.prcgdocdt,g_prcg_m.prcgdocno, 
          g_prcg_m.prcgdocno_desc,g_prcg_m.prcg001,g_prcg_m.prcg001_desc,g_prcg_m.prcg002,g_prcg_m.prcg002_desc, 
          g_prcg_m.prcg005,g_prcg_m.prcg003,g_prcg_m.prcg003_desc,g_prcg_m.prcg004,g_prcg_m.prcg004_desc, 
          g_prcg_m.prcgunit,g_prcg_m.prcgstus,g_prcg_m.prcf005,g_prcg_m.prcf006,g_prcg_m.prcf007,g_prcg_m.prcf007_desc, 
          g_prcg_m.prcf008,g_prcg_m.prcf008_desc,g_prcg_m.prcf009,g_prcg_m.prcf010,g_prcg_m.prcgownid, 
          g_prcg_m.prcgownid_desc,g_prcg_m.prcgowndp,g_prcg_m.prcgowndp_desc,g_prcg_m.prcgcrtid,g_prcg_m.prcgcrtid_desc, 
          g_prcg_m.prcgcrtdp,g_prcg_m.prcgcrtdp_desc,g_prcg_m.prcgcrtdt,g_prcg_m.prcgmodid,g_prcg_m.prcgmodid_desc, 
          g_prcg_m.prcgmoddt,g_prcg_m.prcgcnfid,g_prcg_m.prcgcnfid_desc,g_prcg_m.prcgcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   SELECT prcgstus,prcgcnfid,prcgcnfdt,prcgpstid,prcgpstdt
     INTO g_prcg_m.prcgstus,g_prcg_m.prcgcnfid,g_prcg_m.prcgcnfdt
     FROM prcg_t
    WHERE prcgent = g_enterprise AND prcgdocno = g_prcg_m.prcgdocno
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prcg_m.prcgcnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prcg_m.prcgcnfid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_prcg_m.prcgcnfid_desc
      
   IF g_prcg_m.prcgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aprt561_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt561_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt561.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aprt561_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prch_d.getLength() THEN
         LET g_detail_idx = g_prch_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prch_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prch_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprt561.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprt561_b_fill2(pi_idx)
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
   
   CALL aprt561_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aprt561.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprt561_fill_chk(ps_idx)
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
 
{<section id="aprt561.status_show" >}
PRIVATE FUNCTION aprt561_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprt561.mask_functions" >}
&include "erp/apr/aprt561_mask.4gl"
 
{</section>}
 
{<section id="aprt561.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aprt561_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE  l_success   LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aprt561_show()
   CALL aprt561_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_aprt561_conf_chk(g_prcg_m.prcgdocno,g_prcg_m.prcgstus) RETURNING l_success
   IF l_success THEN
            
   ELSE
      CLOSE aprt561_cl
      CALL s_transaction_end('N','0')
      RETURN   FALSE         
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_prcg_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_prch_d))
 
 
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
   #CALL aprt561_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aprt561_ui_headershow()
   CALL aprt561_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aprt561_draw_out()
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
   CALL aprt561_ui_headershow()  
   CALL aprt561_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aprt561.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aprt561_set_pk_array()
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
   LET g_pk_array[1].values = g_prcg_m.prcgdocno
   LET g_pk_array[1].column = 'prcgdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt561.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aprt561.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aprt561_msgcentre_notify(lc_state)
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
   CALL aprt561_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_prcg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt561.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aprt561_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#32 add-S
   SELECT prcgstus  INTO g_prcg_m.prcgstus
     FROM prcg_t
    WHERE prcgent = g_enterprise
      AND prcgdocno = g_prcg_m.prcgdocno
      
   
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
      LET g_errno = NULL
      CASE g_prcg_m.prcgstus
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
        LET g_errparam.extend = g_prcg_m.prcgdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aprt561_set_act_visible()
        CALL aprt561_set_act_no_visible()
        CALL aprt561_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#32 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt561.other_function" readonly="Y" >}

#display prcgsite
PRIVATE FUNCTION aprt561_prcgsite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prcg_m.prcgsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prcg_m.prcgsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prcg_m.prcgsite_desc
END FUNCTION

#display prcg001
PRIVATE FUNCTION aprt561_prcg001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prcg_m.prcg001
   CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prcg_m.prcg001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prcg_m.prcg001_desc
   
   SELECT prcf005,prcf006,prcf007,prcf008,prcf009,prcf010
     INTO g_prcg_m.prcf005,g_prcg_m.prcf006,g_prcg_m.prcf007,g_prcg_m.prcf008,g_prcg_m.prcf009,g_prcg_m.prcf010
     FROM prcf_t
    WHERE prcfent = g_enterprise AND prcf001 = g_prcg_m.prcg001

   DISPLAY BY NAME g_prcg_m.prcf005,g_prcg_m.prcf006,g_prcg_m.prcf007,g_prcg_m.prcf008,g_prcg_m.prcf009,g_prcg_m.prcf010
   CALL aprt561_prcf007_ref()
   CALL aprt561_prcf008_ref()
END FUNCTION

#display prcg002
PRIVATE FUNCTION aprt561_prcg002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prcg_m.prcg002
   CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prcg_m.prcg002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prcg_m.prcg002_desc
END FUNCTION

##display prcg003
PRIVATE FUNCTION aprt561_prcg003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prcg_m.prcg003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prcg_m.prcg003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prcg_m.prcg003_desc
END FUNCTION

#display prcg004
PRIVATE FUNCTION aprt561_prcg004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prcg_m.prcg004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prcg_m.prcg004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prcg_m.prcg004_desc
END FUNCTION

#create prcf002
PRIVATE FUNCTION aprt561_create_prcf002()
   IF NOT cl_null(g_prcg_m.prcg001) THEN
      SELECT prcf002 INTO g_prcg_m.prcg002
        FROM prcf_t
       WHERE prcfent = g_enterprise AND prcf001 = g_prcg_m.prcg001 
   END IF   
END FUNCTION

#create prcg004
PRIVATE FUNCTION aprt561_create_prcg004()
   SELECT ooag003 INTO g_prcg_m.prcg004 
     FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = g_prcg_m.prcg003
   DISPLAY BY NAME g_prcg_m.prcg004    
END FUNCTION

#create prchseq
PRIVATE FUNCTION aprt561_create_prchseq()
   SELECT max(prchseq)+1 INTO g_prch_d[l_ac].prchseq
     FROM prch_t
    WHERE prchent = g_enterprise AND prchdocno = g_prcg_m.prcgdocno
   IF cl_null(g_prch_d[l_ac].prchseq) OR g_prch_d[l_ac].prchseq=0 THEN
      LET g_prch_d[l_ac].prchseq = 1
   END IF   
END FUNCTION

#display prch002
PRIVATE FUNCTION aprt561_prch002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prch_d[l_ac].prch002
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prch_d[l_ac].prch002_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_prch_d[l_ac].prch002_desc TO s_detail1[l_ac].prch002_desc
END FUNCTION

#display prch003
PRIVATE FUNCTION aprt561_prch003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prch_d[l_ac].prch003
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prch_d[l_ac].prch003_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_prch_d[l_ac].prch003_desc to s_detail1[l_ac].prch003_desc
END FUNCTION

#display prch004
PRIVATE FUNCTION aprt561_prch004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prch_d[l_ac].prch004
   CALL ap_ref_array2(g_ref_fields,"SELECT dbbcl003 FROM dbbcl_t WHERE dbbclent='"||g_enterprise||"' AND dbbcl001=? AND dbbcl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prch_d[l_ac].prch004_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_prch_d[l_ac].prch004_desc TO s_detail1[l_ac].prch004_desc
        
END FUNCTION

##display prch005
PRIVATE FUNCTION aprt561_prch005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prch_d[l_ac].prch005
   CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prch_d[l_ac].prch005_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_prch_d[l_ac].prch005_desc TO s_detail1[l_ac].prch005_desc
END FUNCTION

##display prch006
PRIVATE FUNCTION aprt561_prch006_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prch_d[l_ac].prch006
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prch_d[l_ac].prch006_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_prch_d[l_ac].prch006_desc TO s_detail1[l_ac].prch006_desc
END FUNCTION

##display prch007
PRIVATE FUNCTION aprt561_prch007_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prch_d[l_ac].prch007
   CALL ap_ref_array2(g_ref_fields,"SELECT dbbal003 FROM dbbal_t WHERE dbbalent='"||g_enterprise||"' AND dbbal001=? AND dbbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prch_d[l_ac].prch007_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_prch_d[l_ac].prch007_desc TO s_detail1[l_ac].prch007_desc
END FUNCTION

#create prch002
PRIVATE FUNCTION aprt561_create_prch002()
   IF cl_null(g_prch_d[l_ac].prch002) THEN
      SELECT pmaa006 INTO g_prch_d[l_ac].prch002
        FROM pmaa_t
       WHERE pmaaent = g_enterprise AND pmaa001 = g_prch_d[l_ac].prch003
      DISPLAY g_prch_d[l_ac].prch002 TO s_detail1[l_ac].prch002
      CALL aprt561_prch002_ref()      
   END IF
END FUNCTION

##chk prch002,prch003
PRIVATE FUNCTION aprt561_chk_prch003()
   DEFINE  l_cnt   LIKE type_t.num5
   DEFINE  l_cnt1  LIKE type_t.num5
   LET g_errno = NULL
   LET l_cnt =0
   LET l_cnt1 =0
   IF NOT cl_null(g_prch_d[l_ac].prch002) AND NOT cl_null(g_prch_d[l_ac].prch003) THEN
      SELECT count(*) INTO l_cnt FROM pmaa_t
       WHERE pmaaent = g_enterprise AND pmaa001 = g_prch_d[l_ac].prch003
         AND pmaa006 = g_prch_d[l_ac].prch002
      IF l_cnt <=0 THEN
         LET g_errno = "apr-00272"
      ELSE
         SELECT count(*) INTO l_cnt1 FROM pmaa_t
          WHERE pmaaent = g_enterprise AND pmaa001 = g_prch_d[l_ac].prch003
            AND pmaa006 = g_prch_d[l_ac].prch002 AND pmaastus='Y'
         IF l_cnt1<=0 THEN
            LET g_errno = "apr-00273"
         END IF         
      END IF      
   END IF
END FUNCTION

#display prch005
PRIVATE FUNCTION aprt561_create_prch005()
   SELECT dbbc003,dbbc005,dbbc004 
     INTO g_prch_d[l_ac].prch005,g_prch_d[l_ac].prch006,g_prch_d[l_ac].prch007
     FROM dbbc_t
    WHERE dbbcent = g_enterprise AND dbbc001=g_prch_d[l_ac].prch004
      AND dbbc002 = g_prcg_m.prcgsite
   DISPLAY g_prch_d[l_ac].prch005,g_prch_d[l_ac].prch006,g_prch_d[l_ac].prch007
        TO s_detail1[l_ac].prch005,s_detail1[l_ac].prch006,s_detail1[l_ac].prch007 
   CALL aprt561_prch005_ref()
   CALL aprt561_prch006_ref()
   CALL aprt561_prch007_ref()   
END FUNCTION

#display prcf007
PRIVATE FUNCTION aprt561_prcf007_ref()
   SELECT oocql004 INTO g_prcg_m.prcf007_desc
     FROM oocql_t
    WHERE oocqlent = g_enterprise AND oocql001='2100' AND oocql002 = g_prcg_m.prcf007
      AND oocql003 = g_dlang
   DISPLAY BY NAME g_prcg_m.prcf007_desc      
END FUNCTION

#display prcf008
PRIVATE FUNCTION aprt561_prcf008_ref()
   SELECT oocql004 INTO g_prcg_m.prcf008_desc
     FROM oocql_t
    WHERE oocqlent = g_enterprise AND oocql001='2101' AND oocql002 = g_prcg_m.prcf008
      AND oocql003 = g_dlang
   DISPLAY BY NAME g_prcg_m.prcf008_desc
END FUNCTION

#display prcgdocno
PRIVATE FUNCTION aprt561_prcgdocno_ref(p_cmd)
   DEFINE  l_ooba002   LIKE ooba_t.ooba002
   DEFINE  p_cmd       LIKE type_t.chr1
   DEFINE  l_success   LIKE type_t.num5
   
   IF p_cmd='a' THEN
      SELECT oobxl003 INTO g_prcg_m.prcgdocno_desc
        FROM oobxl_t
       WHERE oobxlent = g_enterprise
         AND oobxl001 = g_prcg_m.prcgdocno  AND oobxl002=g_dlang     
   ELSE
      CALL s_aooi200_get_slip(g_prcg_m.prcgdocno) RETURNING l_success,l_ooba002
      IF l_success=false THEN
      ELSE
         SELECT oobxl003 INTO g_prcg_m.prcgdocno_desc
           FROM oobxl_t
          WHERE oobxlent = g_enterprise
            AND oobxl001 = l_ooba002 AND oobxl002=g_dlang
      END IF
   END IF
   DISPLAY BY NAME g_prcg_m.prcgdocno_desc
END FUNCTION

#chk prcg003,prcg004
PRIVATE FUNCTION aprt561_prcg003_chk()
   DEFINE  l_cnt   LIKE type_t.num5
   LET l_cnt = 0
   LET g_errno = NULL
   IF NOT cl_null(g_prcg_m.prcg003) AND NOT cl_null(g_prcg_m.prcg004) THEN
      SELECT count(*) INTO l_cnt FROM ooag_t
       WHERE ooagent = g_enterprise AND ooag001 = g_prcg_m.prcg003
         AND ooag003 = g_prcg_m.prcg004
      IF l_cnt<=0 THEN
         LET g_errno = "apr-00307"
      END IF      
   END IF
END FUNCTION

 
{</section>}
 
