#該程式未解開Section, 採用最新樣板產出!
{<section id="amrt100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2016-07-29 02:12:49), PR版次:0010(2016-08-26 10:30:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000210
#+ Filename...: amrt100
#+ Description: 資源保養維護作業
#+ Creator....: 04543(2014-04-29 19:29:02)
#+ Modifier...: 00593 -SD/PR- 08742
 
{</section>}
 
{<section id="amrt100.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#23  2016/04/22  BY 07900      校验代码重复错误讯息的修改
#160716-00003#1   2016/07/28  By Sarah      原本使用q_imaa001開窗的通通改成q_imaf001_15,使用v_imaa001校驗的通通改成v_imaf001_14
#160812-00017#5   2016/08/15  By 06137      在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#23  2016/08/25  By 08742      删除修改未重新判断状态码
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
PRIVATE type type_g_mrda_m        RECORD
       mrdasite LIKE mrda_t.mrdasite, 
   mrdadocno LIKE mrda_t.mrdadocno, 
   mrdadocno_desc LIKE type_t.chr80, 
   mrdadocdt LIKE mrda_t.mrdadocdt, 
   mrda001 LIKE mrda_t.mrda001, 
   mrda001_desc LIKE type_t.chr80, 
   mrda002 LIKE mrda_t.mrda002, 
   mrda002_desc LIKE type_t.chr80, 
   mrda012 LIKE mrda_t.mrda012, 
   mrdastus LIKE mrda_t.mrdastus, 
   mrda003 LIKE mrda_t.mrda003, 
   mrda003_desc LIKE type_t.chr80, 
   mrda004 LIKE mrda_t.mrda004, 
   mrda004_desc LIKE type_t.chr80, 
   mrda005 LIKE mrda_t.mrda005, 
   mrda005_desc LIKE type_t.chr80, 
   mrda006 LIKE mrda_t.mrda006, 
   mrda006_desc LIKE type_t.chr80, 
   mrda007 LIKE mrda_t.mrda007, 
   mrda007_desc LIKE type_t.chr80, 
   mrda008 LIKE mrda_t.mrda008, 
   mrda009 LIKE mrda_t.mrda009, 
   mrda010 LIKE mrda_t.mrda010, 
   mrda011 LIKE mrda_t.mrda011, 
   mrdaownid LIKE mrda_t.mrdaownid, 
   mrdaownid_desc LIKE type_t.chr80, 
   mrdaowndp LIKE mrda_t.mrdaowndp, 
   mrdaowndp_desc LIKE type_t.chr80, 
   mrdacrtid LIKE mrda_t.mrdacrtid, 
   mrdacrtid_desc LIKE type_t.chr80, 
   mrdacrtdp LIKE mrda_t.mrdacrtdp, 
   mrdacrtdp_desc LIKE type_t.chr80, 
   mrdacrtdt LIKE mrda_t.mrdacrtdt, 
   mrdamodid LIKE mrda_t.mrdamodid, 
   mrdamodid_desc LIKE type_t.chr80, 
   mrdamoddt LIKE mrda_t.mrdamoddt, 
   mrdacnfid LIKE mrda_t.mrdacnfid, 
   mrdacnfid_desc LIKE type_t.chr80, 
   mrdacnfdt LIKE mrda_t.mrdacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mrdb_d        RECORD
       mrdbsite LIKE mrdb_t.mrdbsite, 
   mrdbseq LIKE mrdb_t.mrdbseq, 
   mrdb001 LIKE mrdb_t.mrdb001, 
   mrdb001_desc LIKE type_t.chr500, 
   mrdb002 LIKE mrdb_t.mrdb002, 
   mrdb002_desc LIKE type_t.chr500, 
   mrdb003 LIKE mrdb_t.mrdb003, 
   mrdb004 LIKE mrdb_t.mrdb004, 
   mrdb015 LIKE mrdb_t.mrdb015, 
   mrdb016 LIKE mrdb_t.mrdb016, 
   mrdb005 LIKE mrdb_t.mrdb005, 
   mrdb005_desc LIKE type_t.chr500, 
   mrdb014 LIKE mrdb_t.mrdb014, 
   mrdb006 LIKE mrdb_t.mrdb006, 
   mrdb007 LIKE mrdb_t.mrdb007, 
   mrdb012 LIKE mrdb_t.mrdb012, 
   mrdb012_desc LIKE type_t.chr500, 
   mrdb013 LIKE mrdb_t.mrdb013
       END RECORD
PRIVATE TYPE type_g_mrdb2_d RECORD
       mrdesite LIKE mrde_t.mrdesite, 
   mrdeseq1 LIKE mrde_t.mrdeseq1, 
   mrde001 LIKE mrde_t.mrde001, 
   mrde001_desc LIKE type_t.chr500, 
   mrde001_desc1 LIKE type_t.chr500, 
   mrde004 LIKE mrde_t.mrde004, 
   mrde002 LIKE mrde_t.mrde002, 
   mrde003 LIKE mrde_t.mrde003, 
   mrde003_desc LIKE type_t.chr500, 
   mrde005 LIKE mrde_t.mrde005
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mrdadocno LIKE mrda_t.mrdadocno,
      b_mrdadocdt LIKE mrda_t.mrdadocdt,
      b_mrda001 LIKE mrda_t.mrda001,
   b_mrda001_desc LIKE type_t.chr80,
      b_mrda002 LIKE mrda_t.mrda002,
   b_mrda002_desc LIKE type_t.chr80,
      b_mrda003 LIKE mrda_t.mrda003,
   b_mrda003_desc LIKE type_t.chr80,
      b_mrda006 LIKE mrda_t.mrda006,
   b_mrda006_desc LIKE type_t.chr80,
      b_mrdacrtid LIKE mrda_t.mrdacrtid,
   b_mrdacrtid_desc LIKE type_t.chr80,
      b_mrdacrtdt LIKE mrda_t.mrdacrtdt,
      b_mrdamodid LIKE mrda_t.mrdamodid,
   b_mrdamodid_desc LIKE type_t.chr80,
      b_mrdamoddt LIKE mrda_t.mrdamoddt
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_mrda_m          type_g_mrda_m
DEFINE g_mrda_m_t        type_g_mrda_m
DEFINE g_mrda_m_o        type_g_mrda_m
DEFINE g_mrda_m_mask_o   type_g_mrda_m #轉換遮罩前資料
DEFINE g_mrda_m_mask_n   type_g_mrda_m #轉換遮罩後資料
 
   DEFINE g_mrdadocno_t LIKE mrda_t.mrdadocno
 
 
DEFINE g_mrdb_d          DYNAMIC ARRAY OF type_g_mrdb_d
DEFINE g_mrdb_d_t        type_g_mrdb_d
DEFINE g_mrdb_d_o        type_g_mrdb_d
DEFINE g_mrdb_d_mask_o   DYNAMIC ARRAY OF type_g_mrdb_d #轉換遮罩前資料
DEFINE g_mrdb_d_mask_n   DYNAMIC ARRAY OF type_g_mrdb_d #轉換遮罩後資料
DEFINE g_mrdb2_d          DYNAMIC ARRAY OF type_g_mrdb2_d
DEFINE g_mrdb2_d_t        type_g_mrdb2_d
DEFINE g_mrdb2_d_o        type_g_mrdb2_d
DEFINE g_mrdb2_d_mask_o   DYNAMIC ARRAY OF type_g_mrdb2_d #轉換遮罩前資料
DEFINE g_mrdb2_d_mask_n   DYNAMIC ARRAY OF type_g_mrdb2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
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
 
{<section id="amrt100.main" >}
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
   CALL cl_ap_init("amr","")
 
   #add-point:作業初始化 name="main.init"
   LET g_errshow = '1'
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mrdasite,mrdadocno,'',mrdadocdt,mrda001,'',mrda002,'',mrda012,mrdastus, 
       mrda003,'',mrda004,'',mrda005,'',mrda006,'',mrda007,'',mrda008,mrda009,mrda010,mrda011,mrdaownid, 
       '',mrdaowndp,'',mrdacrtid,'',mrdacrtdp,'',mrdacrtdt,mrdamodid,'',mrdamoddt,mrdacnfid,'',mrdacnfdt", 
        
                      " FROM mrda_t",
                      " WHERE mrdaent= ? AND mrdadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mrdasite,t0.mrdadocno,t0.mrdadocdt,t0.mrda001,t0.mrda002,t0.mrda012, 
       t0.mrdastus,t0.mrda003,t0.mrda004,t0.mrda005,t0.mrda006,t0.mrda007,t0.mrda008,t0.mrda009,t0.mrda010, 
       t0.mrda011,t0.mrdaownid,t0.mrdaowndp,t0.mrdacrtid,t0.mrdacrtdp,t0.mrdacrtdt,t0.mrdamodid,t0.mrdamoddt, 
       t0.mrdacnfid,t0.mrdacnfdt,t1.ooag011 ,t2.ooefl003 ,t3.oocql004 ,t4.mraal003 ,t5.oocql004 ,t6.oocql004 , 
       t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooefl003 ,t11.ooag011 ,t12.ooag011",
               " FROM mrda_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrda001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrda002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='1104' AND t3.oocql002=t0.mrda004 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN mraal_t t4 ON t4.mraalent="||g_enterprise||" AND t4.mraal001=t0.mrda005 AND t4.mraal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='1101' AND t5.oocql002=t0.mrda006 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='1102' AND t6.oocql002=t0.mrda007 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.mrdaownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.mrdaowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.mrdacrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.mrdacrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.mrdamodid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.mrdacnfid  ",
 
               " WHERE t0.mrdaent = " ||g_enterprise|| " AND t0.mrdadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE amrt100_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amrt100 WITH FORM cl_ap_formpath("amr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amrt100_init()   
 
      #進入選單 Menu (="N")
      CALL amrt100_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amrt100
      
   END IF 
   
   CLOSE amrt100_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amrt100.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION amrt100_init()
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
      CALL cl_set_combo_scc_part('mrdastus','13','N,1,2,3,A,D,R,W')
 
      CALL cl_set_combo_scc('mrda008','5203') 
   CALL cl_set_combo_scc('mrda011','5204') 
   CALL cl_set_combo_scc('mrdb016','5204') 
   CALL cl_set_combo_scc('mrde005','5213') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #初始化搜尋條件
   CALL amrt100_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="amrt100.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION amrt100_ui_dialog()
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
   DEFINE l_success  LIKE type_t.num5
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
            CALL amrt100_insert()
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
         INITIALIZE g_mrda_m.* TO NULL
         CALL g_mrdb_d.clear()
         CALL g_mrdb2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL amrt100_init()
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
               
               CALL amrt100_fetch('') # reload data
               LET l_ac = 1
               CALL amrt100_ui_detailshow() #Setting the current row 
         
               CALL amrt100_idx_chk()
               #NEXT FIELD mrdbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mrdb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrt100_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               CALL amrt100_b_fill2('2')
 
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
               CALL amrt100_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
         #第二階單身段落
         DISPLAY ARRAY g_mrdb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrt100_idx_chk()
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
               CALL amrt100_idx_chk()
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
            CALL amrt100_browser_fill("")
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
               CALL amrt100_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL amrt100_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL amrt100_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL amrt100_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL amrt100_set_act_visible()   
            CALL amrt100_set_act_no_visible()
            IF NOT (g_mrda_m.mrdadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mrdaent = " ||g_enterprise|| " AND",
                                  " mrdadocno = '", g_mrda_m.mrdadocno, "' "
 
               #填到對應位置
               CALL amrt100_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "mrda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mrdb_t" 
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
               CALL amrt100_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "mrda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mrdb_t" 
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
                  CALL amrt100_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL amrt100_fetch("F")
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
               CALL amrt100_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL amrt100_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt100_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL amrt100_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt100_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL amrt100_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt100_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL amrt100_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt100_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL amrt100_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt100_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mrdb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_mrdb2_d)
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
               NEXT FIELD mrdbseq
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
               CALL amrt100_modify()
               #add-point:ON ACTION modify name="menu.modify"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL amrt100_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL amrt100_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amrt100_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION amrt100_batch_produce
            LET g_action_choice="amrt100_batch_produce"
            IF cl_auth_chk_act("amrt100_batch_produce") THEN
               
               #add-point:ON ACTION amrt100_batch_produce name="menu.amrt100_batch_produce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amr/amrt100_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amr/amrt100_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL amrt100_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL amrt100_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION generate_amrt300
            LET g_action_choice="generate_amrt300"
            IF cl_auth_chk_act("generate_amrt300") THEN
               
               #add-point:ON ACTION generate_amrt300 name="menu.generate_amrt300"
               IF g_mrda_m.mrdastus = '3' AND cl_null(g_mrda_m.mrda012) THEN                  
                  CALL s_transaction_begin()
                  IF amrt100_wait_fix_input() THEN                     
                     #產生維修工單
                     CALL s_amrt100_gen_amrt300(g_mrda_m.mrda012,g_mrda_m.mrda003)
                          RETURNING l_success,g_mrda_m.mrda012
                     IF NOT l_success THEN
                        UPDATE mrda_t
                           SET mrda012 = ''
                         WHERE mrdaent = g_enterprise
                           AND mrdadocno = g_mrda_m.mrdadocno
                        CALL s_transaction_end('N','0')
                        RETURN
                     ELSE
                        UPDATE mrda_t
                           SET mrda012 = g_mrda_m.mrda012
                         WHERE mrdaent = g_enterprise
                           AND mrdadocno = g_mrda_m.mrdadocno
                        CALL s_transaction_end('Y','0')
                     END IF
                     DISPLAY BY NAME g_mrda_m.mrda012
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_amrt300
            LET g_action_choice="prog_amrt300"
            IF cl_auth_chk_act("prog_amrt300") THEN
               
               #add-point:ON ACTION prog_amrt300 name="menu.prog_amrt300"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'amrt300'
               LET la_param.param[1] = g_mrda_m.mrda012
               LET la_param.param[2] = g_mrda_m.mrdasite
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL amrt100_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amrt100_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amrt100_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mrda_m.mrdadocdt)
 
 
 
         
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
 
{<section id="amrt100.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION amrt100_browser_fill(ps_page_action)
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
   LET l_wc = l_wc," AND mrdasite = '",g_site,"'"
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT mrdadocno ",
                      " FROM mrda_t ",
                      " ",
                      " LEFT JOIN mrdb_t ON mrdbent = mrdaent AND mrdadocno = mrdbdocno ", "  ",
                      #add-point:browser_fill段sql(mrdb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
                      " LEFT JOIN mrde_t ON mrdeent = mrdaent AND mrdbdocno = mrdedocno AND mrdbseq = mrdeseq", "  ",
                      #add-point:browser_fill段sql(mrde_t1) name="browser_fill.cnt.join.mrde_t1"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
                      " ",
 
 
                      " WHERE mrdaent = " ||g_enterprise|| " AND mrdbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mrda_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mrdadocno ",
                      " FROM mrda_t ", 
                      "  ",
                      "  ",
                      " WHERE mrdaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mrda_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   LET g_wc = g_wc," AND mrdasite = '",g_site,"'"
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
      INITIALIZE g_mrda_m.* TO NULL
      CALL g_mrdb_d.clear()        
      CALL g_mrdb2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mrdadocno,t0.mrdadocdt,t0.mrda001,t0.mrda002,t0.mrda003,t0.mrda006,t0.mrdacrtid,t0.mrdacrtdt,t0.mrdamodid,t0.mrdamoddt Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mrdastus,t0.mrdadocno,t0.mrdadocdt,t0.mrda001,t0.mrda002,t0.mrda003, 
          t0.mrda006,t0.mrdacrtid,t0.mrdacrtdt,t0.mrdamodid,t0.mrdamoddt,t1.ooag011 ,t2.ooefl003 ,t3.oocql004 , 
          t4.ooag011 ,t5.ooag011 ",
                  " FROM mrda_t t0",
                  "  ",
                  "  LEFT JOIN mrdb_t ON mrdbent = mrdaent AND mrdadocno = mrdbdocno ", "  ", 
                  #add-point:browser_fill段sql(mrdb_t1) name="browser_fill.join.mrdb_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN mrde_t ON mrdeent = mrdaent AND mrdbdocno = mrdedocno AND mrdbseq = mrdeseq", "  ", 
                  #add-point:browser_fill段sql(mrde_t1) name="browser_fill.join.mrde_t1"
                  
                  #end add-point
 
 
                  " ", 
 
                  " ",
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrda001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrda002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='1101' AND t3.oocql002=t0.mrda006 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mrdacrtid  ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.mrdamodid  ",
 
                  " WHERE t0.mrdaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mrda_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mrdastus,t0.mrdadocno,t0.mrdadocdt,t0.mrda001,t0.mrda002,t0.mrda003, 
          t0.mrda006,t0.mrdacrtid,t0.mrdacrtdt,t0.mrdamodid,t0.mrdamoddt,t1.ooag011 ,t2.ooefl003 ,t3.oocql004 , 
          t4.ooag011 ,t5.ooag011 ",
                  " FROM mrda_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrda001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrda002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='1101' AND t3.oocql002=t0.mrda006 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mrdacrtid  ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.mrdamodid  ",
 
                  " WHERE t0.mrdaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mrda_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mrdadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mrda_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mrdadocno,g_browser[g_cnt].b_mrdadocdt, 
          g_browser[g_cnt].b_mrda001,g_browser[g_cnt].b_mrda002,g_browser[g_cnt].b_mrda003,g_browser[g_cnt].b_mrda006, 
          g_browser[g_cnt].b_mrdacrtid,g_browser[g_cnt].b_mrdacrtdt,g_browser[g_cnt].b_mrdamodid,g_browser[g_cnt].b_mrdamoddt, 
          g_browser[g_cnt].b_mrda001_desc,g_browser[g_cnt].b_mrda002_desc,g_browser[g_cnt].b_mrda006_desc, 
          g_browser[g_cnt].b_mrdacrtid_desc,g_browser[g_cnt].b_mrdamodid_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      CALL amrt100_mrda003_ref(g_browser[g_cnt].b_mrda003) RETURNING g_browser[g_cnt].b_mrda003_desc
      DISPLAY BY NAME g_browser[g_cnt].b_mrda003_desc
      
      CALL amrt100_mrda006_ref(g_browser[g_cnt].b_mrda006) RETURNING g_browser[g_cnt].b_mrda006_desc
      DISPLAY BY NAME g_browser[g_cnt].b_mrda006_desc
         #end add-point
      
         #遮罩相關處理
         CALL amrt100_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "1"
            LET g_browser[g_cnt].b_statepic = "stus/16/checked.png"
         WHEN "2"
            LET g_browser[g_cnt].b_statepic = "stus/16/completed.png"
         WHEN "3"
            LET g_browser[g_cnt].b_statepic = "stus/16/wait_fix.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_mrdadocno) THEN
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
 
{<section id="amrt100.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION amrt100_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mrda_m.mrdadocno = g_browser[g_current_idx].b_mrdadocno   
 
   EXECUTE amrt100_master_referesh USING g_mrda_m.mrdadocno INTO g_mrda_m.mrdasite,g_mrda_m.mrdadocno, 
       g_mrda_m.mrdadocdt,g_mrda_m.mrda001,g_mrda_m.mrda002,g_mrda_m.mrda012,g_mrda_m.mrdastus,g_mrda_m.mrda003, 
       g_mrda_m.mrda004,g_mrda_m.mrda005,g_mrda_m.mrda006,g_mrda_m.mrda007,g_mrda_m.mrda008,g_mrda_m.mrda009, 
       g_mrda_m.mrda010,g_mrda_m.mrda011,g_mrda_m.mrdaownid,g_mrda_m.mrdaowndp,g_mrda_m.mrdacrtid,g_mrda_m.mrdacrtdp, 
       g_mrda_m.mrdacrtdt,g_mrda_m.mrdamodid,g_mrda_m.mrdamoddt,g_mrda_m.mrdacnfid,g_mrda_m.mrdacnfdt, 
       g_mrda_m.mrda001_desc,g_mrda_m.mrda002_desc,g_mrda_m.mrda004_desc,g_mrda_m.mrda005_desc,g_mrda_m.mrda006_desc, 
       g_mrda_m.mrda007_desc,g_mrda_m.mrdaownid_desc,g_mrda_m.mrdaowndp_desc,g_mrda_m.mrdacrtid_desc, 
       g_mrda_m.mrdacrtdp_desc,g_mrda_m.mrdamodid_desc,g_mrda_m.mrdacnfid_desc
   
   CALL amrt100_mrda_t_mask()
   CALL amrt100_show()
      
END FUNCTION
 
{</section>}
 
{<section id="amrt100.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION amrt100_ui_detailshow()
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
 
{<section id="amrt100.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION amrt100_ui_browser_refresh()
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
      IF g_browser[l_i].b_mrdadocno = g_mrda_m.mrdadocno 
 
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
 
{<section id="amrt100.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION amrt100_construct()
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
   INITIALIZE g_mrda_m.* TO NULL
   CALL g_mrdb_d.clear()        
   CALL g_mrdb2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON mrdasite,mrdadocno,mrdadocno_desc,mrdadocdt,mrda001,mrda002,mrda012, 
          mrdastus,mrda003,mrda003_desc,mrda004,mrda005,mrda006,mrda007,mrda008,mrda009,mrda010,mrda011, 
          mrdaownid,mrdaowndp,mrdacrtid,mrdacrtdp,mrdacrtdt,mrdamodid,mrdamoddt,mrdacnfid,mrdacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mrdacrtdt>>----
         AFTER FIELD mrdacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mrdamoddt>>----
         AFTER FIELD mrdamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrdacnfdt>>----
         AFTER FIELD mrdacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrdapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdasite
            #add-point:BEFORE FIELD mrdasite name="construct.b.mrdasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdasite
            
            #add-point:AFTER FIELD mrdasite name="construct.a.mrdasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdasite
            #add-point:ON ACTION controlp INFIELD mrdasite name="construct.c.mrdasite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdadocno
            #add-point:ON ACTION controlp INFIELD mrdadocno name="construct.c.mrdadocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdadocno  #顯示到畫面上
            NEXT FIELD mrdadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdadocno
            #add-point:BEFORE FIELD mrdadocno name="construct.b.mrdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdadocno
            
            #add-point:AFTER FIELD mrdadocno name="construct.a.mrdadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdadocno_desc
            #add-point:BEFORE FIELD mrdadocno_desc name="construct.b.mrdadocno_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdadocno_desc
            
            #add-point:AFTER FIELD mrdadocno_desc name="construct.a.mrdadocno_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdadocno_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdadocno_desc
            #add-point:ON ACTION controlp INFIELD mrdadocno_desc name="construct.c.mrdadocno_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdadocdt
            #add-point:BEFORE FIELD mrdadocdt name="construct.b.mrdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdadocdt
            
            #add-point:AFTER FIELD mrdadocdt name="construct.a.mrdadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdadocdt
            #add-point:ON ACTION controlp INFIELD mrdadocdt name="construct.c.mrdadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrda001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda001
            #add-point:ON ACTION controlp INFIELD mrda001 name="construct.c.mrda001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrda001  #顯示到畫面上
            NEXT FIELD mrda001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda001
            #add-point:BEFORE FIELD mrda001 name="construct.b.mrda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda001
            
            #add-point:AFTER FIELD mrda001 name="construct.a.mrda001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda002
            #add-point:ON ACTION controlp INFIELD mrda002 name="construct.c.mrda002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrda002  #顯示到畫面上
            NEXT FIELD mrda002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda002
            #add-point:BEFORE FIELD mrda002 name="construct.b.mrda002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda002
            
            #add-point:AFTER FIELD mrda002 name="construct.a.mrda002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrda012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda012
            #add-point:ON ACTION controlp INFIELD mrda012 name="construct.c.mrda012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrdhdocno()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrda012  #顯示到畫面上
            NEXT FIELD mrda012                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda012
            #add-point:BEFORE FIELD mrda012 name="construct.b.mrda012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda012
            
            #add-point:AFTER FIELD mrda012 name="construct.a.mrda012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdastus
            #add-point:BEFORE FIELD mrdastus name="construct.b.mrdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdastus
            
            #add-point:AFTER FIELD mrdastus name="construct.a.mrdastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdastus
            #add-point:ON ACTION controlp INFIELD mrdastus name="construct.c.mrdastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda003
            #add-point:ON ACTION controlp INFIELD mrda003 name="construct.c.mrda003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrba001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrda003  #顯示到畫面上
            NEXT FIELD mrda003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda003
            #add-point:BEFORE FIELD mrda003 name="construct.b.mrda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda003
            
            #add-point:AFTER FIELD mrda003 name="construct.a.mrda003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda003_desc
            #add-point:BEFORE FIELD mrda003_desc name="construct.b.mrda003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda003_desc
            
            #add-point:AFTER FIELD mrda003_desc name="construct.a.mrda003_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrda003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda003_desc
            #add-point:ON ACTION controlp INFIELD mrda003_desc name="construct.c.mrda003_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda004
            #add-point:ON ACTION controlp INFIELD mrda004 name="construct.c.mrda004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.arg1 = '1104'
            
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrda004  #顯示到畫面上
            NEXT FIELD mrda004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda004
            #add-point:BEFORE FIELD mrda004 name="construct.b.mrda004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda004
            
            #add-point:AFTER FIELD mrda004 name="construct.a.mrda004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda005
            #add-point:ON ACTION controlp INFIELD mrda005 name="construct.c.mrda005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mraa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrda005  #顯示到畫面上
            NEXT FIELD mrda005                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda005
            #add-point:BEFORE FIELD mrda005 name="construct.b.mrda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda005
            
            #add-point:AFTER FIELD mrda005 name="construct.a.mrda005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrda006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda006
            #add-point:ON ACTION controlp INFIELD mrda006 name="construct.c.mrda006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            #給予arg
            LET g_qryparam.arg1 = "1101"
            
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrda006  #顯示到畫面上
            NEXT FIELD mrda006                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda006
            #add-point:BEFORE FIELD mrda006 name="construct.b.mrda006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda006
            
            #add-point:AFTER FIELD mrda006 name="construct.a.mrda006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrda007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda007
            #add-point:ON ACTION controlp INFIELD mrda007 name="construct.c.mrda007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            #給予arg
            LET g_qryparam.arg1 = "1102"
            
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrda007  #顯示到畫面上
            NEXT FIELD mrda007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda007
            #add-point:BEFORE FIELD mrda007 name="construct.b.mrda007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda007
            
            #add-point:AFTER FIELD mrda007 name="construct.a.mrda007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda008
            #add-point:BEFORE FIELD mrda008 name="construct.b.mrda008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda008
            
            #add-point:AFTER FIELD mrda008 name="construct.a.mrda008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrda008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda008
            #add-point:ON ACTION controlp INFIELD mrda008 name="construct.c.mrda008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda009
            #add-point:BEFORE FIELD mrda009 name="construct.b.mrda009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda009
            
            #add-point:AFTER FIELD mrda009 name="construct.a.mrda009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrda009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda009
            #add-point:ON ACTION controlp INFIELD mrda009 name="construct.c.mrda009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda010
            #add-point:BEFORE FIELD mrda010 name="construct.b.mrda010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda010
            
            #add-point:AFTER FIELD mrda010 name="construct.a.mrda010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrda010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda010
            #add-point:ON ACTION controlp INFIELD mrda010 name="construct.c.mrda010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda011
            #add-point:BEFORE FIELD mrda011 name="construct.b.mrda011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda011
            
            #add-point:AFTER FIELD mrda011 name="construct.a.mrda011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrda011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda011
            #add-point:ON ACTION controlp INFIELD mrda011 name="construct.c.mrda011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdaownid
            #add-point:ON ACTION controlp INFIELD mrdaownid name="construct.c.mrdaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdaownid  #顯示到畫面上
            NEXT FIELD mrdaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdaownid
            #add-point:BEFORE FIELD mrdaownid name="construct.b.mrdaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdaownid
            
            #add-point:AFTER FIELD mrdaownid name="construct.a.mrdaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdaowndp
            #add-point:ON ACTION controlp INFIELD mrdaowndp name="construct.c.mrdaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdaowndp  #顯示到畫面上
            NEXT FIELD mrdaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdaowndp
            #add-point:BEFORE FIELD mrdaowndp name="construct.b.mrdaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdaowndp
            
            #add-point:AFTER FIELD mrdaowndp name="construct.a.mrdaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdacrtid
            #add-point:ON ACTION controlp INFIELD mrdacrtid name="construct.c.mrdacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdacrtid  #顯示到畫面上
            NEXT FIELD mrdacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdacrtid
            #add-point:BEFORE FIELD mrdacrtid name="construct.b.mrdacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdacrtid
            
            #add-point:AFTER FIELD mrdacrtid name="construct.a.mrdacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdacrtdp
            #add-point:ON ACTION controlp INFIELD mrdacrtdp name="construct.c.mrdacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdacrtdp  #顯示到畫面上
            NEXT FIELD mrdacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdacrtdp
            #add-point:BEFORE FIELD mrdacrtdp name="construct.b.mrdacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdacrtdp
            
            #add-point:AFTER FIELD mrdacrtdp name="construct.a.mrdacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdacrtdt
            #add-point:BEFORE FIELD mrdacrtdt name="construct.b.mrdacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdamodid
            #add-point:ON ACTION controlp INFIELD mrdamodid name="construct.c.mrdamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdamodid  #顯示到畫面上
            NEXT FIELD mrdamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdamodid
            #add-point:BEFORE FIELD mrdamodid name="construct.b.mrdamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdamodid
            
            #add-point:AFTER FIELD mrdamodid name="construct.a.mrdamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdamoddt
            #add-point:BEFORE FIELD mrdamoddt name="construct.b.mrdamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdacnfid
            #add-point:ON ACTION controlp INFIELD mrdacnfid name="construct.c.mrdacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdacnfid  #顯示到畫面上
            NEXT FIELD mrdacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdacnfid
            #add-point:BEFORE FIELD mrdacnfid name="construct.b.mrdacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdacnfid
            
            #add-point:AFTER FIELD mrdacnfid name="construct.a.mrdacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdacnfdt
            #add-point:BEFORE FIELD mrdacnfdt name="construct.b.mrdacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mrdbsite,mrdbseq,mrdb001,mrdb002,mrdb003,mrdb004,mrdb015,mrdb016,mrdb005, 
          mrdb005_desc,mrdb014,mrdb006,mrdb007,mrdb012,mrdb013
           FROM s_detail1[1].mrdbsite,s_detail1[1].mrdbseq,s_detail1[1].mrdb001,s_detail1[1].mrdb002, 
               s_detail1[1].mrdb003,s_detail1[1].mrdb004,s_detail1[1].mrdb015,s_detail1[1].mrdb016,s_detail1[1].mrdb005, 
               s_detail1[1].mrdb005_desc,s_detail1[1].mrdb014,s_detail1[1].mrdb006,s_detail1[1].mrdb007, 
               s_detail1[1].mrdb012,s_detail1[1].mrdb013
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdbsite
            #add-point:BEFORE FIELD mrdbsite name="construct.b.page1.mrdbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdbsite
            
            #add-point:AFTER FIELD mrdbsite name="construct.a.page1.mrdbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdbsite
            #add-point:ON ACTION controlp INFIELD mrdbsite name="construct.c.page1.mrdbsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdbseq
            #add-point:BEFORE FIELD mrdbseq name="construct.b.page1.mrdbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdbseq
            
            #add-point:AFTER FIELD mrdbseq name="construct.a.page1.mrdbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdbseq
            #add-point:ON ACTION controlp INFIELD mrdbseq name="construct.c.page1.mrdbseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrdb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb001
            #add-point:ON ACTION controlp INFIELD mrdb001 name="construct.c.page1.mrdb001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.arg1 = "1110"
            
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdb001  #顯示到畫面上
            NEXT FIELD mrdb001                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb001
            #add-point:BEFORE FIELD mrdb001 name="construct.b.page1.mrdb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb001
            
            #add-point:AFTER FIELD mrdb001 name="construct.a.page1.mrdb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb002
            #add-point:ON ACTION controlp INFIELD mrdb002 name="construct.c.page1.mrdb002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            #給予arg
            LET g_qryparam.arg1 = "1114"
            
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdb002  #顯示到畫面上
            NEXT FIELD mrdb002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb002
            #add-point:BEFORE FIELD mrdb002 name="construct.b.page1.mrdb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb002
            
            #add-point:AFTER FIELD mrdb002 name="construct.a.page1.mrdb002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb003
            #add-point:BEFORE FIELD mrdb003 name="construct.b.page1.mrdb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb003
            
            #add-point:AFTER FIELD mrdb003 name="construct.a.page1.mrdb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb003
            #add-point:ON ACTION controlp INFIELD mrdb003 name="construct.c.page1.mrdb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb004
            #add-point:BEFORE FIELD mrdb004 name="construct.b.page1.mrdb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb004
            
            #add-point:AFTER FIELD mrdb004 name="construct.a.page1.mrdb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb004
            #add-point:ON ACTION controlp INFIELD mrdb004 name="construct.c.page1.mrdb004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb015
            #add-point:BEFORE FIELD mrdb015 name="construct.b.page1.mrdb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb015
            
            #add-point:AFTER FIELD mrdb015 name="construct.a.page1.mrdb015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb015
            #add-point:ON ACTION controlp INFIELD mrdb015 name="construct.c.page1.mrdb015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb016
            #add-point:BEFORE FIELD mrdb016 name="construct.b.page1.mrdb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb016
            
            #add-point:AFTER FIELD mrdb016 name="construct.a.page1.mrdb016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb016
            #add-point:ON ACTION controlp INFIELD mrdb016 name="construct.c.page1.mrdb016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrdb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb005
            #add-point:ON ACTION controlp INFIELD mrdb005 name="construct.c.page1.mrdb005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrbc002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdb005  #顯示到畫面上
            NEXT FIELD mrdb005                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb005
            #add-point:BEFORE FIELD mrdb005 name="construct.b.page1.mrdb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb005
            
            #add-point:AFTER FIELD mrdb005 name="construct.a.page1.mrdb005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb005_desc
            #add-point:BEFORE FIELD mrdb005_desc name="construct.b.page1.mrdb005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb005_desc
            
            #add-point:AFTER FIELD mrdb005_desc name="construct.a.page1.mrdb005_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdb005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb005_desc
            #add-point:ON ACTION controlp INFIELD mrdb005_desc name="construct.c.page1.mrdb005_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb014
            #add-point:BEFORE FIELD mrdb014 name="construct.b.page1.mrdb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb014
            
            #add-point:AFTER FIELD mrdb014 name="construct.a.page1.mrdb014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb014
            #add-point:ON ACTION controlp INFIELD mrdb014 name="construct.c.page1.mrdb014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb006
            #add-point:BEFORE FIELD mrdb006 name="construct.b.page1.mrdb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb006
            
            #add-point:AFTER FIELD mrdb006 name="construct.a.page1.mrdb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb006
            #add-point:ON ACTION controlp INFIELD mrdb006 name="construct.c.page1.mrdb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb007
            #add-point:BEFORE FIELD mrdb007 name="construct.b.page1.mrdb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb007
            
            #add-point:AFTER FIELD mrdb007 name="construct.a.page1.mrdb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb007
            #add-point:ON ACTION controlp INFIELD mrdb007 name="construct.c.page1.mrdb007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrdb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb012
            #add-point:ON ACTION controlp INFIELD mrdb012 name="construct.c.page1.mrdb012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            #給予arg
            LET g_qryparam.arg1 = "1106"
            
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdb012  #顯示到畫面上
            NEXT FIELD mrdb012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb012
            #add-point:BEFORE FIELD mrdb012 name="construct.b.page1.mrdb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb012
            
            #add-point:AFTER FIELD mrdb012 name="construct.a.page1.mrdb012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb013
            #add-point:BEFORE FIELD mrdb013 name="construct.b.page1.mrdb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb013
            
            #add-point:AFTER FIELD mrdb013 name="construct.a.page1.mrdb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb013
            #add-point:ON ACTION controlp INFIELD mrdb013 name="construct.c.page1.mrdb013"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON mrdeseq1,mrde001,mrde001_desc,mrde001_desc1,mrde004,mrde002,mrde003, 
          mrde005
           FROM s_detail2[1].mrdeseq1,s_detail2[1].mrde001,s_detail2[1].mrde001_desc,s_detail2[1].mrde001_desc1, 
               s_detail2[1].mrde004,s_detail2[1].mrde002,s_detail2[1].mrde003,s_detail2[1].mrde005
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdeseq1
            #add-point:BEFORE FIELD mrdeseq1 name="construct.b.page2.mrdeseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdeseq1
            
            #add-point:AFTER FIELD mrdeseq1 name="construct.a.page2.mrdeseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrdeseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdeseq1
            #add-point:ON ACTION controlp INFIELD mrdeseq1 name="construct.c.page2.mrdeseq1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mrde001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrde001
            #add-point:ON ACTION controlp INFIELD mrde001 name="construct.c.page2.mrde001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#160716-00003#1-s
#           CALL q_imaa001()                       #呼叫開窗
            CALL q_imaf001_15()                    #呼叫開窗
#160716-00003#1-e
            DISPLAY g_qryparam.return1 TO mrde001  #顯示到畫面上
            NEXT FIELD mrde001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrde001
            #add-point:BEFORE FIELD mrde001 name="construct.b.page2.mrde001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrde001
            
            #add-point:AFTER FIELD mrde001 name="construct.a.page2.mrde001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrde001_desc
            #add-point:BEFORE FIELD mrde001_desc name="construct.b.page2.mrde001_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrde001_desc
            
            #add-point:AFTER FIELD mrde001_desc name="construct.a.page2.mrde001_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrde001_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrde001_desc
            #add-point:ON ACTION controlp INFIELD mrde001_desc name="construct.c.page2.mrde001_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrde001_desc1
            #add-point:BEFORE FIELD mrde001_desc1 name="construct.b.page2.mrde001_desc1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrde001_desc1
            
            #add-point:AFTER FIELD mrde001_desc1 name="construct.a.page2.mrde001_desc1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrde001_desc1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrde001_desc1
            #add-point:ON ACTION controlp INFIELD mrde001_desc1 name="construct.c.page2.mrde001_desc1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrde004
            #add-point:BEFORE FIELD mrde004 name="construct.b.page2.mrde004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrde004
            
            #add-point:AFTER FIELD mrde004 name="construct.a.page2.mrde004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrde004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrde004
            #add-point:ON ACTION controlp INFIELD mrde004 name="construct.c.page2.mrde004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrde002
            #add-point:BEFORE FIELD mrde002 name="construct.b.page2.mrde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrde002
            
            #add-point:AFTER FIELD mrde002 name="construct.a.page2.mrde002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrde002
            #add-point:ON ACTION controlp INFIELD mrde002 name="construct.c.page2.mrde002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mrde003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrde003
            #add-point:ON ACTION controlp INFIELD mrde003 name="construct.c.page2.mrde003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrde003  #顯示到畫面上
            NEXT FIELD mrde003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrde003
            #add-point:BEFORE FIELD mrde003 name="construct.b.page2.mrde003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrde003
            
            #add-point:AFTER FIELD mrde003 name="construct.a.page2.mrde003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrde005
            #add-point:BEFORE FIELD mrde005 name="construct.b.page2.mrde005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrde005
            
            #add-point:AFTER FIELD mrde005 name="construct.a.page2.mrde005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrde005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrde005
            #add-point:ON ACTION controlp INFIELD mrde005 name="construct.c.page2.mrde005"
            
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
                  WHEN la_wc[li_idx].tableid = "mrda_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mrdb_t" 
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
 
{<section id="amrt100.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION amrt100_filter()
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
      CONSTRUCT g_wc_filter ON mrdadocno,mrdadocdt,mrda001,mrda002,mrda003,mrda006,mrdacrtid,mrdacrtdt, 
          mrdamodid,mrdamoddt
                          FROM s_browse[1].b_mrdadocno,s_browse[1].b_mrdadocdt,s_browse[1].b_mrda001, 
                              s_browse[1].b_mrda002,s_browse[1].b_mrda003,s_browse[1].b_mrda006,s_browse[1].b_mrdacrtid, 
                              s_browse[1].b_mrdacrtdt,s_browse[1].b_mrdamodid,s_browse[1].b_mrdamoddt 
 
 
         BEFORE CONSTRUCT
               DISPLAY amrt100_filter_parser('mrdadocno') TO s_browse[1].b_mrdadocno
            DISPLAY amrt100_filter_parser('mrdadocdt') TO s_browse[1].b_mrdadocdt
            DISPLAY amrt100_filter_parser('mrda001') TO s_browse[1].b_mrda001
            DISPLAY amrt100_filter_parser('mrda002') TO s_browse[1].b_mrda002
            DISPLAY amrt100_filter_parser('mrda003') TO s_browse[1].b_mrda003
            DISPLAY amrt100_filter_parser('mrda006') TO s_browse[1].b_mrda006
            DISPLAY amrt100_filter_parser('mrdacrtid') TO s_browse[1].b_mrdacrtid
            DISPLAY amrt100_filter_parser('mrdacrtdt') TO s_browse[1].b_mrdacrtdt
            DISPLAY amrt100_filter_parser('mrdamodid') TO s_browse[1].b_mrdamodid
            DISPLAY amrt100_filter_parser('mrdamoddt') TO s_browse[1].b_mrdamoddt
      
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
 
      CALL amrt100_filter_show('mrdadocno')
   CALL amrt100_filter_show('mrdadocdt')
   CALL amrt100_filter_show('mrda001')
   CALL amrt100_filter_show('mrda002')
   CALL amrt100_filter_show('mrda003')
   CALL amrt100_filter_show('mrda006')
   CALL amrt100_filter_show('mrdacrtid')
   CALL amrt100_filter_show('mrdacrtdt')
   CALL amrt100_filter_show('mrdamodid')
   CALL amrt100_filter_show('mrdamoddt')
 
END FUNCTION
 
{</section>}
 
{<section id="amrt100.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION amrt100_filter_parser(ps_field)
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
 
{<section id="amrt100.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION amrt100_filter_show(ps_field)
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
   LET ls_condition = amrt100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="amrt100.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION amrt100_query()
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
   CALL g_mrdb_d.clear()
   CALL g_mrdb2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL amrt100_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL amrt100_browser_fill("")
      CALL amrt100_fetch("")
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
      CALL amrt100_filter_show('mrdadocno')
   CALL amrt100_filter_show('mrdadocdt')
   CALL amrt100_filter_show('mrda001')
   CALL amrt100_filter_show('mrda002')
   CALL amrt100_filter_show('mrda003')
   CALL amrt100_filter_show('mrda006')
   CALL amrt100_filter_show('mrdacrtid')
   CALL amrt100_filter_show('mrdacrtdt')
   CALL amrt100_filter_show('mrdamodid')
   CALL amrt100_filter_show('mrdamoddt')
   CALL amrt100_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL amrt100_fetch("F") 
      #顯示單身筆數
      CALL amrt100_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amrt100.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION amrt100_fetch(p_flag)
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
   CALL g_mrdb2_d.clear()
 
   
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
   
   LET g_mrda_m.mrdadocno = g_browser[g_current_idx].b_mrdadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE amrt100_master_referesh USING g_mrda_m.mrdadocno INTO g_mrda_m.mrdasite,g_mrda_m.mrdadocno, 
       g_mrda_m.mrdadocdt,g_mrda_m.mrda001,g_mrda_m.mrda002,g_mrda_m.mrda012,g_mrda_m.mrdastus,g_mrda_m.mrda003, 
       g_mrda_m.mrda004,g_mrda_m.mrda005,g_mrda_m.mrda006,g_mrda_m.mrda007,g_mrda_m.mrda008,g_mrda_m.mrda009, 
       g_mrda_m.mrda010,g_mrda_m.mrda011,g_mrda_m.mrdaownid,g_mrda_m.mrdaowndp,g_mrda_m.mrdacrtid,g_mrda_m.mrdacrtdp, 
       g_mrda_m.mrdacrtdt,g_mrda_m.mrdamodid,g_mrda_m.mrdamoddt,g_mrda_m.mrdacnfid,g_mrda_m.mrdacnfdt, 
       g_mrda_m.mrda001_desc,g_mrda_m.mrda002_desc,g_mrda_m.mrda004_desc,g_mrda_m.mrda005_desc,g_mrda_m.mrda006_desc, 
       g_mrda_m.mrda007_desc,g_mrda_m.mrdaownid_desc,g_mrda_m.mrdaowndp_desc,g_mrda_m.mrdacrtid_desc, 
       g_mrda_m.mrdacrtdp_desc,g_mrda_m.mrdamodid_desc,g_mrda_m.mrdacnfid_desc
   
   #遮罩相關處理
   LET g_mrda_m_mask_o.* =  g_mrda_m.*
   CALL amrt100_mrda_t_mask()
   LET g_mrda_m_mask_n.* =  g_mrda_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrt100_set_act_visible()   
   CALL amrt100_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mrda_m_t.* = g_mrda_m.*
   LET g_mrda_m_o.* = g_mrda_m.*
   
   LET g_data_owner = g_mrda_m.mrdaownid      
   LET g_data_dept  = g_mrda_m.mrdaowndp
   
   #重新顯示   
   CALL amrt100_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt100.insert" >}
#+ 資料新增
PRIVATE FUNCTION amrt100_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mrdb_d.clear()   
   CALL g_mrdb2_d.clear()  
 
 
   INITIALIZE g_mrda_m.* TO NULL             #DEFAULT 設定
   
   LET g_mrdadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrda_m.mrdaownid = g_user
      LET g_mrda_m.mrdaowndp = g_dept
      LET g_mrda_m.mrdacrtid = g_user
      LET g_mrda_m.mrdacrtdp = g_dept 
      LET g_mrda_m.mrdacrtdt = cl_get_current()
      LET g_mrda_m.mrdamodid = g_user
      LET g_mrda_m.mrdamoddt = cl_get_current()
      LET g_mrda_m.mrdastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mrda_m.mrda008 = "1"
      LET g_mrda_m.mrda011 = "2"
 
  
      #add-point:單頭預設值 name="insert.default"
      
      LET g_mrda_m.mrdastus = 'N'
      LET g_mrda_m.mrdasite = g_site
      LET g_mrda_m.mrdadocdt = g_today
      LET g_mrda_m.mrda001 = g_user
      CALL amrt100_mrda001_ref()
      LET g_mrda_m.mrda002 = g_dept
      CALL amrt100_mrda002_ref()
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mrda_m_t.* = g_mrda_m.*
      LET g_mrda_m_o.* = g_mrda_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrda_m.mrdastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "1"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/checked.png")
         WHEN "2"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/completed.png")
         WHEN "3"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/wait_fix.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
    
      CALL amrt100_input("a")
      
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
         INITIALIZE g_mrda_m.* TO NULL
         INITIALIZE g_mrdb_d TO NULL
         INITIALIZE g_mrdb2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL amrt100_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mrdb_d.clear()
      #CALL g_mrdb2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrt100_set_act_visible()   
   CALL amrt100_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mrdadocno_t = g_mrda_m.mrdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrdaent = " ||g_enterprise|| " AND",
                      " mrdadocno = '", g_mrda_m.mrdadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amrt100_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE amrt100_cl
   
   CALL amrt100_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE amrt100_master_referesh USING g_mrda_m.mrdadocno INTO g_mrda_m.mrdasite,g_mrda_m.mrdadocno, 
       g_mrda_m.mrdadocdt,g_mrda_m.mrda001,g_mrda_m.mrda002,g_mrda_m.mrda012,g_mrda_m.mrdastus,g_mrda_m.mrda003, 
       g_mrda_m.mrda004,g_mrda_m.mrda005,g_mrda_m.mrda006,g_mrda_m.mrda007,g_mrda_m.mrda008,g_mrda_m.mrda009, 
       g_mrda_m.mrda010,g_mrda_m.mrda011,g_mrda_m.mrdaownid,g_mrda_m.mrdaowndp,g_mrda_m.mrdacrtid,g_mrda_m.mrdacrtdp, 
       g_mrda_m.mrdacrtdt,g_mrda_m.mrdamodid,g_mrda_m.mrdamoddt,g_mrda_m.mrdacnfid,g_mrda_m.mrdacnfdt, 
       g_mrda_m.mrda001_desc,g_mrda_m.mrda002_desc,g_mrda_m.mrda004_desc,g_mrda_m.mrda005_desc,g_mrda_m.mrda006_desc, 
       g_mrda_m.mrda007_desc,g_mrda_m.mrdaownid_desc,g_mrda_m.mrdaowndp_desc,g_mrda_m.mrdacrtid_desc, 
       g_mrda_m.mrdacrtdp_desc,g_mrda_m.mrdamodid_desc,g_mrda_m.mrdacnfid_desc
   
   
   #遮罩相關處理
   LET g_mrda_m_mask_o.* =  g_mrda_m.*
   CALL amrt100_mrda_t_mask()
   LET g_mrda_m_mask_n.* =  g_mrda_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrda_m.mrdasite,g_mrda_m.mrdadocno,g_mrda_m.mrdadocno_desc,g_mrda_m.mrdadocdt,g_mrda_m.mrda001, 
       g_mrda_m.mrda001_desc,g_mrda_m.mrda002,g_mrda_m.mrda002_desc,g_mrda_m.mrda012,g_mrda_m.mrdastus, 
       g_mrda_m.mrda003,g_mrda_m.mrda003_desc,g_mrda_m.mrda004,g_mrda_m.mrda004_desc,g_mrda_m.mrda005, 
       g_mrda_m.mrda005_desc,g_mrda_m.mrda006,g_mrda_m.mrda006_desc,g_mrda_m.mrda007,g_mrda_m.mrda007_desc, 
       g_mrda_m.mrda008,g_mrda_m.mrda009,g_mrda_m.mrda010,g_mrda_m.mrda011,g_mrda_m.mrdaownid,g_mrda_m.mrdaownid_desc, 
       g_mrda_m.mrdaowndp,g_mrda_m.mrdaowndp_desc,g_mrda_m.mrdacrtid,g_mrda_m.mrdacrtid_desc,g_mrda_m.mrdacrtdp, 
       g_mrda_m.mrdacrtdp_desc,g_mrda_m.mrdacrtdt,g_mrda_m.mrdamodid,g_mrda_m.mrdamodid_desc,g_mrda_m.mrdamoddt, 
       g_mrda_m.mrdacnfid,g_mrda_m.mrdacnfid_desc,g_mrda_m.mrdacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_mrda_m.mrdaownid      
   LET g_data_dept  = g_mrda_m.mrdaowndp
   
   #功能已完成,通報訊息中心
   CALL amrt100_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="amrt100.modify" >}
#+ 資料修改
PRIVATE FUNCTION amrt100_modify()
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
   LET g_mrda_m_t.* = g_mrda_m.*
   LET g_mrda_m_o.* = g_mrda_m.*
   
   IF g_mrda_m.mrdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mrdadocno_t = g_mrda_m.mrdadocno
 
   CALL s_transaction_begin()
   
   OPEN amrt100_cl USING g_enterprise,g_mrda_m.mrdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt100_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amrt100_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amrt100_master_referesh USING g_mrda_m.mrdadocno INTO g_mrda_m.mrdasite,g_mrda_m.mrdadocno, 
       g_mrda_m.mrdadocdt,g_mrda_m.mrda001,g_mrda_m.mrda002,g_mrda_m.mrda012,g_mrda_m.mrdastus,g_mrda_m.mrda003, 
       g_mrda_m.mrda004,g_mrda_m.mrda005,g_mrda_m.mrda006,g_mrda_m.mrda007,g_mrda_m.mrda008,g_mrda_m.mrda009, 
       g_mrda_m.mrda010,g_mrda_m.mrda011,g_mrda_m.mrdaownid,g_mrda_m.mrdaowndp,g_mrda_m.mrdacrtid,g_mrda_m.mrdacrtdp, 
       g_mrda_m.mrdacrtdt,g_mrda_m.mrdamodid,g_mrda_m.mrdamoddt,g_mrda_m.mrdacnfid,g_mrda_m.mrdacnfdt, 
       g_mrda_m.mrda001_desc,g_mrda_m.mrda002_desc,g_mrda_m.mrda004_desc,g_mrda_m.mrda005_desc,g_mrda_m.mrda006_desc, 
       g_mrda_m.mrda007_desc,g_mrda_m.mrdaownid_desc,g_mrda_m.mrdaowndp_desc,g_mrda_m.mrdacrtid_desc, 
       g_mrda_m.mrdacrtdp_desc,g_mrda_m.mrdamodid_desc,g_mrda_m.mrdacnfid_desc
   
   #檢查是否允許此動作
   IF NOT amrt100_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mrda_m_mask_o.* =  g_mrda_m.*
   CALL amrt100_mrda_t_mask()
   LET g_mrda_m_mask_n.* =  g_mrda_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
   
   CALL amrt100_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
    
   WHILE TRUE
      LET g_mrdadocno_t = g_mrda_m.mrdadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mrda_m.mrdamodid = g_user 
LET g_mrda_m.mrdamoddt = cl_get_current()
LET g_mrda_m.mrdamodid_desc = cl_get_username(g_mrda_m.mrdamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_mrda_m.mrdastus MATCHES "[DR]" THEN 
         LET g_mrda_m.mrdastus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL amrt100_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mrda_t SET (mrdamodid,mrdamoddt) = (g_mrda_m.mrdamodid,g_mrda_m.mrdamoddt)
          WHERE mrdaent = g_enterprise AND mrdadocno = g_mrdadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mrda_m.* = g_mrda_m_t.*
            CALL amrt100_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mrda_m.mrdadocno != g_mrda_m_t.mrdadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mrdb_t SET mrdbdocno = g_mrda_m.mrdadocno
 
          WHERE mrdbent = g_enterprise AND mrdbdocno = g_mrda_m_t.mrdadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mrdb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdb_t:",SQLERRMESSAGE 
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
         UPDATE mrde_t
            SET mrdedocno = g_mrda_m.mrdadocno
 
          WHERE mrdeent = g_enterprise AND
                mrdedocno = g_mrdadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrde_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrde_t:",SQLERRMESSAGE 
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
   CALL amrt100_set_act_visible()   
   CALL amrt100_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mrdaent = " ||g_enterprise|| " AND",
                      " mrdadocno = '", g_mrda_m.mrdadocno, "' "
 
   #填到對應位置
   CALL amrt100_browser_fill("")
 
   CLOSE amrt100_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amrt100_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="amrt100.input" >}
#+ 資料輸入
PRIVATE FUNCTION amrt100_input(p_cmd)
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
   DEFINE l_flag                 LIKE type_t.num5
   DEFINE l_ooef004              LIKE ooef_t.ooef004
   DEFINE l_time                 LIKE type_t.num15_3
   DEFINE l_mrdb015              LIKE mrdb_t.mrdb015
   DEFINE l_mrdb016              LIKE mrdb_t.mrdb016
   DEFINE l_mrda012_t            LIKE mrda_t.mrda012
   DEFINE l_where                STRING  #160204-00004#5 20160223 s983961--add
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
   DISPLAY BY NAME g_mrda_m.mrdasite,g_mrda_m.mrdadocno,g_mrda_m.mrdadocno_desc,g_mrda_m.mrdadocdt,g_mrda_m.mrda001, 
       g_mrda_m.mrda001_desc,g_mrda_m.mrda002,g_mrda_m.mrda002_desc,g_mrda_m.mrda012,g_mrda_m.mrdastus, 
       g_mrda_m.mrda003,g_mrda_m.mrda003_desc,g_mrda_m.mrda004,g_mrda_m.mrda004_desc,g_mrda_m.mrda005, 
       g_mrda_m.mrda005_desc,g_mrda_m.mrda006,g_mrda_m.mrda006_desc,g_mrda_m.mrda007,g_mrda_m.mrda007_desc, 
       g_mrda_m.mrda008,g_mrda_m.mrda009,g_mrda_m.mrda010,g_mrda_m.mrda011,g_mrda_m.mrdaownid,g_mrda_m.mrdaownid_desc, 
       g_mrda_m.mrdaowndp,g_mrda_m.mrdaowndp_desc,g_mrda_m.mrdacrtid,g_mrda_m.mrdacrtid_desc,g_mrda_m.mrdacrtdp, 
       g_mrda_m.mrdacrtdp_desc,g_mrda_m.mrdacrtdt,g_mrda_m.mrdamodid,g_mrda_m.mrdamodid_desc,g_mrda_m.mrdamoddt, 
       g_mrda_m.mrdacnfid,g_mrda_m.mrdacnfid_desc,g_mrda_m.mrdacnfdt
   
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
   LET g_forupd_sql = "SELECT mrdbsite,mrdbseq,mrdb001,mrdb002,mrdb003,mrdb004,mrdb015,mrdb016,mrdb005, 
       mrdb014,mrdb006,mrdb007,mrdb012,mrdb013 FROM mrdb_t WHERE mrdbent=? AND mrdbdocno=? AND mrdbseq=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt100_bcl CURSOR FROM g_forupd_sql
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT mrdesite,mrdeseq1,mrde001,mrde004,mrde002,mrde003,mrde005 FROM mrde_t  
       WHERE mrdeent=? AND mrdedocno=? AND mrdeseq=? AND mrdeseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt100_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL amrt100_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   CALL amrt100_set_no_required(p_cmd)
   CALL amrt100_set_required(p_cmd)
   #end add-point
   CALL amrt100_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mrda_m.mrdasite,g_mrda_m.mrdadocno,g_mrda_m.mrdadocdt,g_mrda_m.mrda001,g_mrda_m.mrda002, 
       g_mrda_m.mrda012,g_mrda_m.mrdastus,g_mrda_m.mrda003,g_mrda_m.mrda004,g_mrda_m.mrda005,g_mrda_m.mrda006, 
       g_mrda_m.mrda007,g_mrda_m.mrda008,g_mrda_m.mrda009,g_mrda_m.mrda010,g_mrda_m.mrda011
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   IF g_mrda_m.mrdastus = '1' THEN  #校驗中
      LET l_allow_delete = FALSE
   END IF
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="amrt100.input.head" >}
      #單頭段
      INPUT BY NAME g_mrda_m.mrdasite,g_mrda_m.mrdadocno,g_mrda_m.mrdadocdt,g_mrda_m.mrda001,g_mrda_m.mrda002, 
          g_mrda_m.mrda012,g_mrda_m.mrdastus,g_mrda_m.mrda003,g_mrda_m.mrda004,g_mrda_m.mrda005,g_mrda_m.mrda006, 
          g_mrda_m.mrda007,g_mrda_m.mrda008,g_mrda_m.mrda009,g_mrda_m.mrda010,g_mrda_m.mrda011 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN amrt100_cl USING g_enterprise,g_mrda_m.mrdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt100_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt100_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL amrt100_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL amrt100_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdasite
            #add-point:BEFORE FIELD mrdasite name="input.b.mrdasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdasite
            
            #add-point:AFTER FIELD mrdasite name="input.a.mrdasite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdasite
            #add-point:ON CHANGE mrdasite name="input.g.mrdasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdadocno
            
            #add-point:AFTER FIELD mrdadocno name="input.a.mrdadocno"
            CALL s_aooi200_get_slip_desc(g_mrda_m.mrdadocno) RETURNING g_mrda_m.mrdadocno_desc
            DISPLAY BY NAME g_mrda_m.mrdadocno_desc

            IF cl_null(g_mrda_m.mrdadocno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'sub-00324'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD CURRENT
            END IF
            
            IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mrda_m.mrdadocno != g_mrdadocno_t )) THEN 
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrda_t WHERE "||"mrdaent = '" ||g_enterprise|| "' AND "||"mrdadocno = '"||g_mrda_m.mrdadocno ||"'",'std-00004',0) THEN 
                  LET g_mrda_m.mrdadocno = g_mrda_m_t.mrdadocno

                  CALL s_aooi200_get_slip_desc(g_mrda_m.mrdadocno) RETURNING g_mrda_m.mrdadocno_desc
                  DISPLAY BY NAME g_mrda_m.mrdadocno_desc

                  NEXT FIELD CURRENT
               END IF
            END IF
               
            #檢查單別
            IF NOT s_aooi200_chk_slip(g_site,'',g_mrda_m.mrdadocno,g_prog) THEN
               LET g_mrda_m.mrdadocno = g_mrda_m_t.mrdadocno

               CALL s_aooi200_get_slip_desc(g_mrda_m.mrdadocno) RETURNING g_mrda_m.mrdadocno_desc
               DISPLAY BY NAME g_mrda_m.mrdadocno_desc

               NEXT FIELD CURRENT
            END IF            
                      
            #檢核輸入的單據別是否可以被key人員對應的控制組使用,'6' 為生管控制組類型
            CALL s_control_chk_doc('1',g_mrda_m.mrdadocno,'6',g_user,g_dept,'','') RETURNING l_success,l_flag
            IF l_success THEN
               IF NOT l_flag THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00015'
                  LET g_errparam.extend = g_mrda_m.mrdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_mrda_m.mrdadocno = g_mrda_m_t.mrdadocno

                  CALL s_aooi200_get_slip_desc(g_mrda_m.mrdadocno) RETURNING g_mrda_m.mrdadocno_desc
                  DISPLAY BY NAME g_mrda_m.mrdadocno_desc

                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_mrda_m.mrdadocno = g_mrda_m_t.mrdadocno

               CALL s_aooi200_get_slip_desc(g_mrda_m.mrdadocno) RETURNING g_mrda_m.mrdadocno_desc
               DISPLAY BY NAME g_mrda_m.mrdadocno_desc
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdadocno
            #add-point:BEFORE FIELD mrdadocno name="input.b.mrdadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdadocno
            #add-point:ON CHANGE mrdadocno name="input.g.mrdadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdadocdt
            #add-point:BEFORE FIELD mrdadocdt name="input.b.mrdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdadocdt
            
            #add-point:AFTER FIELD mrdadocdt name="input.a.mrdadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdadocdt
            #add-point:ON CHANGE mrdadocdt name="input.g.mrdadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda001
            
            #add-point:AFTER FIELD mrda001 name="input.a.mrda001"
            CALL amrt100_mrda001_ref()
            IF NOT cl_null(g_mrda_m.mrda001) THEN
               IF g_mrda_m.mrda001 <> g_mrda_m_o.mrda001 OR cl_null(g_mrda_m_o.mrda001) THEN

                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrda_m.mrda001
                  #160318-00025#23  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#23  by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     LET g_mrda_m.mrda001 = g_mrda_m_o.mrda001
                     CALL amrt100_mrda001_ref()
                     NEXT FIELD CURRENT
                  END IF
                     
                  #帶出歸屬部門ooag003
                  LET g_mrda_m_o.mrda002 = ''
                  SELECT ooag003 INTO g_mrda_m.mrda002
                    FROM ooag_t
                   WHERE ooagent = g_enterprise
                     AND ooag001 = g_mrda_m.mrda001
                  DISPLAY BY NAME g_mrda_m.mrda002
                  CALL amrt100_mrda002_ref()
               END IF
            END IF 


            LET g_mrda_m_o.mrda001 = g_mrda_m.mrda001
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda001
            #add-point:BEFORE FIELD mrda001 name="input.b.mrda001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrda001
            #add-point:ON CHANGE mrda001 name="input.g.mrda001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda002
            
            #add-point:AFTER FIELD mrda002 name="input.a.mrda002"
            CALL amrt100_mrda002_ref()
            IF NOT cl_null(g_mrda_m.mrda002) THEN
               IF g_mrda_m.mrda002 <> g_mrda_m_o.mrda002 OR cl_null(g_mrda_m_o.mrda002) THEN
                  
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrda_m.mrda002
                  
                  IF NOT cl_null(g_mrda_m.mrdadocdt) THEN
                     LET g_chkparam.arg2 = g_mrda_m.mrdadocdt
                  ELSE
                     LET g_chkparam.arg2 = g_today
                  END IF                  
                  #160318-00025#23  by 07900 --add-str
                 LET g_errshow = TRUE #是否開窗                   
                 LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                 #160318-00025#23  by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_mrda_m.mrda002 = g_mrda_m_o.mrda002
                     CALL amrt100_mrda002_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF         
            END IF 

            LET g_mrda_m_o.mrda002 = g_mrda_m.mrda002
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda002
            #add-point:BEFORE FIELD mrda002 name="input.b.mrda002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrda002
            #add-point:ON CHANGE mrda002 name="input.g.mrda002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda012
            
            #add-point:AFTER FIELD mrda012 name="input.a.mrda012"
            IF NOT cl_null(g_mrda_m.mrda012) THEN
               IF NOT s_aooi200_chk_slip(g_site,'',g_mrda_m.mrda012,'amrt300') THEN
                  LET g_mrda_m.mrda012 = l_mrda012_t
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET l_mrda012_t = g_mrda_m.mrda012
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda012
            #add-point:BEFORE FIELD mrda012 name="input.b.mrda012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrda012
            #add-point:ON CHANGE mrda012 name="input.g.mrda012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdastus
            #add-point:BEFORE FIELD mrdastus name="input.b.mrdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdastus
            
            #add-point:AFTER FIELD mrdastus name="input.a.mrdastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdastus
            #add-point:ON CHANGE mrdastus name="input.g.mrdastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda003
            
            #add-point:AFTER FIELD mrda003 name="input.a.mrda003"
            CALL amrt100_mrda003_ref(g_mrda_m.mrda003) RETURNING g_mrda_m.mrda003_desc
            DISPLAY BY NAME g_mrda_m.mrda003_desc
               
            IF NOT cl_null(g_mrda_m.mrda003) THEN
               IF g_mrda_m.mrda003 <> g_mrda_m_o.mrda003 OR cl_null(g_mrda_m_o.mrda003) THEN
            
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrda_m.mrda003
                   #160318-00025#23  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
                  #160318-00025#23  by 07900 --add-end   
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_mrba001_5") THEN
                     LET g_mrda_m.mrda003 = g_mrda_m_o.mrda003
                     
                     CALL amrt100_mrda003_ref(g_mrda_m.mrda003) RETURNING g_mrda_m.mrda003_desc
                     DISPLAY BY NAME g_mrda_m.mrda003_desc
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            LET g_mrda_m_o.mrda003 = g_mrda_m.mrda003

            CALL amrt100_mrda006_mrda007_default()
            CALL amrt100_mrda009_default()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda003
            #add-point:BEFORE FIELD mrda003 name="input.b.mrda003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrda003
            #add-point:ON CHANGE mrda003 name="input.g.mrda003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda004
            
            #add-point:AFTER FIELD mrda004 name="input.a.mrda004"
            CALL amrt100_mrda004_ref()
            IF NOT cl_null(g_mrda_m.mrda004) THEN
               IF g_mrda_m.mrda004 <> g_mrda_m_o.mrda004 OR cl_null(g_mrda_m_o.mrda004) THEN
            
                  IF NOT s_azzi650_chk_exist('1104',g_mrda_m.mrda004) THEN
                     LET g_mrda_m.mrda004 = g_mrda_m_o.mrda004
                     CALL amrt100_mrda004_ref()
                  
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            LET g_mrda_m_o.mrda004 = g_mrda_m.mrda004
            
            CALL amrt100_mrda009_default()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda004
            #add-point:BEFORE FIELD mrda004 name="input.b.mrda004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrda004
            #add-point:ON CHANGE mrda004 name="input.g.mrda004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda005
            
            #add-point:AFTER FIELD mrda005 name="input.a.mrda005"
            CALL amrt100_mrda005_ref()
            IF NOT cl_null(g_mrda_m.mrda005) THEN
               IF g_mrda_m.mrda005 <> g_mrda_m_o.mrda005 OR cl_null(g_mrda_m_o.mrda005) THEN
               
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrda_m.mrda005
                  #160318-00025#23  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="amr-00009:sub-01302|amri007|",cl_get_progname("amri007",g_lang,"2"),"|:EXEPROGamri007"
                  #160318-00025#23  by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_mraa001") THEN
                     LET g_mrda_m.mrda005 = g_mrda_m_o.mrda005
                     CALL amrt100_mrda005_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            LET g_mrda_m_o.mrda005 = g_mrda_m.mrda005
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda005
            #add-point:BEFORE FIELD mrda005 name="input.b.mrda005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrda005
            #add-point:ON CHANGE mrda005 name="input.g.mrda005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda006
            
            #add-point:AFTER FIELD mrda006 name="input.a.mrda006"
#            CALL amrt100_mrda006_ref(g_mrda_m.mrda006) RETURNING g_mrda_m.mrda006_desc
#            DISPLAY BY NAME g_mrda_m.mrda006_desc
#
#            IF NOT cl_null(g_mrda_m.mrda006) THEN
#               IF NOT s_azzi650_chk_exist('1101',g_mrda_m.mrda006) THEN
#                  LET g_mrda_m.mrda006 = g_mrda_m_t.mrda006
#
#                  CALL amrt100_mrda006_ref(g_mrda_m.mrda006) RETURNING g_mrda_m.mrda006_desc
#                  DISPLAY BY NAME g_mrda_m.mrda006_desc
#                  
#                  NEXT FIELD CURRENT
#               END IF
#            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda006
            #add-point:BEFORE FIELD mrda006 name="input.b.mrda006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrda006
            #add-point:ON CHANGE mrda006 name="input.g.mrda006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda007
            
            #add-point:AFTER FIELD mrda007 name="input.a.mrda007"
#            CALL amrt100_mrda007_ref()
#            IF NOT cl_null(g_mrda_m.mrda007) THEN
#               IF NOT s_azzi650_chk_exist('1102',g_mrda_m.mrda007) THEN
#                  LET g_mrda_m.mrda007 = g_mrda_m_t.mrda007
#                  CALL amrt100_mrda007_ref()
#                  NEXT FIELD CURRENT
#               END IF
#            END IF
#
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda007
            #add-point:BEFORE FIELD mrda007 name="input.b.mrda007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrda007
            #add-point:ON CHANGE mrda007 name="input.g.mrda007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda008
            #add-point:BEFORE FIELD mrda008 name="input.b.mrda008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda008
            
            #add-point:AFTER FIELD mrda008 name="input.a.mrda008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrda008
            #add-point:ON CHANGE mrda008 name="input.g.mrda008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda009
            #add-point:BEFORE FIELD mrda009 name="input.b.mrda009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda009
            
            #add-point:AFTER FIELD mrda009 name="input.a.mrda009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrda009
            #add-point:ON CHANGE mrda009 name="input.g.mrda009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrda_m.mrda010,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrda010
            END IF 
 
 
 
            #add-point:AFTER FIELD mrda010 name="input.a.mrda010"
            CALL amrt100_set_no_required(p_cmd)
            CALL amrt100_set_required(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda010
            #add-point:BEFORE FIELD mrda010 name="input.b.mrda010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrda010
            #add-point:ON CHANGE mrda010 name="input.g.mrda010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrda011
            #add-point:BEFORE FIELD mrda011 name="input.b.mrda011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrda011
            
            #add-point:AFTER FIELD mrda011 name="input.a.mrda011"
            CALL amrt100_set_no_required(p_cmd)
            CALL amrt100_set_required(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrda011
            #add-point:ON CHANGE mrda011 name="input.g.mrda011"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mrdasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdasite
            #add-point:ON ACTION controlp INFIELD mrdasite name="input.c.mrdasite"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdadocno
            #add-point:ON ACTION controlp INFIELD mrdadocno name="input.c.mrdadocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrda_m.mrdadocno  #給予default值            
            #給予arg
            CALL s_aooi100_sel_ooef004(g_site)
                 RETURNING l_success,l_ooef004             
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = g_prog                        
            CALL q_ooba002_1()                            #呼叫開窗
            LET g_mrda_m.mrdadocno = g_qryparam.return1
            DISPLAY g_mrda_m.mrdadocno TO mrdadocno
            CALL s_aooi200_get_slip_desc(g_mrda_m.mrdadocno) RETURNING g_mrda_m.mrdadocno_desc
            DISPLAY BY NAME g_mrda_m.mrdadocno_desc   
            NEXT FIELD mrdadocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mrdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdadocdt
            #add-point:ON ACTION controlp INFIELD mrdadocdt name="input.c.mrdadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrda001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda001
            #add-point:ON ACTION controlp INFIELD mrda001 name="input.c.mrda001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrda_m.mrda001             #給予default值
            
            CALL q_ooag001()                                #呼叫開窗

            LET g_mrda_m.mrda001 = g_qryparam.return1              

            DISPLAY g_mrda_m.mrda001 TO mrda001              #

            CALL amrt100_mrda001_ref()
            NEXT FIELD mrda001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda002
            #add-point:ON ACTION controlp INFIELD mrda002 name="input.c.mrda002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrda_m.mrda002             #給予default值
            LET g_qryparam.default2 = ""
            
            #給予arg
            IF NOT cl_null(g_mrda_m.mrdadocdt) THEN
               LET g_qryparam.arg1 = g_mrda_m.mrdadocdt
            ELSE
               LET g_qryparam.arg1 = g_today
            END IF      
            
            CALL q_ooeg001()                                #呼叫開窗

            LET g_mrda_m.mrda002 = g_qryparam.return1              
            #LET g_mrda_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_mrda_m.mrda002 TO mrda002              #
           
            CALL amrt100_mrda002_ref()
            NEXT FIELD mrda002                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.mrda012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda012
            #add-point:ON ACTION controlp INFIELD mrda012 name="input.c.mrda012"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrda_m.mrda012  #給予default值
            #給予arg
            CALL s_aooi100_sel_ooef004(g_site)
                 RETURNING l_success,l_ooef004
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = 'amrt300'
            CALL q_ooba002_1()                          #呼叫開窗
            LET g_mrda_m.mrda012 = g_qryparam.return1
            DISPLAY g_mrda_m.mrda012 TO mrda012
            NEXT FIELD mrda012                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mrdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdastus
            #add-point:ON ACTION controlp INFIELD mrdastus name="input.c.mrdastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda003
            #add-point:ON ACTION controlp INFIELD mrda003 name="input.c.mrda003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrda_m.mrda003             #給予default值
            
            CALL q_mrba001_4()                                #呼叫開窗

            LET g_mrda_m.mrda003 = g_qryparam.return1              

            DISPLAY g_mrda_m.mrda003 TO mrda003              #

            CALL amrt100_mrda003_ref(g_mrda_m.mrda003) RETURNING g_mrda_m.mrda003_desc
            DISPLAY BY NAME g_mrda_m.mrda003_desc

            NEXT FIELD mrda003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda004
            #add-point:ON ACTION controlp INFIELD mrda004 name="input.c.mrda004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrda_m.mrda004             #給予default值
            LET g_qryparam.default2 = ""
            
            #給予arg
            LET g_qryparam.arg1 = '1104'
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_mrda_m.mrda004 = g_qryparam.return1              
            DISPLAY g_mrda_m.mrda004 TO mrda004            
            
            CALL amrt100_mrda004_ref()
            NEXT FIELD mrda004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda005
            #add-point:ON ACTION controlp INFIELD mrda005 name="input.c.mrda005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrda_m.mrda005             #給予default值
            
            CALL q_mraa001()                                #呼叫開窗

            LET g_mrda_m.mrda005 = g_qryparam.return1              

            DISPLAY g_mrda_m.mrda005 TO mrda005              #

            CALL amrt100_mrda005_ref()
            NEXT FIELD mrda005                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.mrda006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda006
            #add-point:ON ACTION controlp INFIELD mrda006 name="input.c.mrda006"
#            #此段落由子樣板a07產生            
#            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_mrda_m.mrda006             #給予default值
#            LET g_qryparam.default2 = ""
#            
#            #給予arg
#            LET g_qryparam.arg1 = "1101"
#            
#            CALL q_oocq002()                                #呼叫開窗
#
#            LET g_mrda_m.mrda006 = g_qryparam.return1              
#            DISPLAY g_mrda_m.mrda006 TO mrda006              #
#            
#            CALL amrt100_mrda006_ref(g_mrda_m.mrda006) RETURNING g_mrda_m.mrda006_desc
#            DISPLAY BY NAME g_mrda_m.mrda006_desc
#            NEXT FIELD mrda006                          #返回原欄位
#
#
            #END add-point
 
 
         #Ctrlp:input.c.mrda007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda007
            #add-point:ON ACTION controlp INFIELD mrda007 name="input.c.mrda007"
#            #此段落由子樣板a07產生            
#            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_mrda_m.mrda007             #給予default值
#            LET g_qryparam.default2 = "" 
#            #給予arg
#            LET g_qryparam.arg1 = "1102"
#           
#            CALL q_oocq002()                                #呼叫開窗
#
#            LET g_mrda_m.mrda007 = g_qryparam.return1              
#
#            DISPLAY g_mrda_m.mrda007 TO mrda007              #
#
#            CALL amrt100_mrda007_ref()
#            NEXT FIELD mrda007                          #返回原欄位
#
#
            #END add-point
 
 
         #Ctrlp:input.c.mrda008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda008
            #add-point:ON ACTION controlp INFIELD mrda008 name="input.c.mrda008"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrda009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda009
            #add-point:ON ACTION controlp INFIELD mrda009 name="input.c.mrda009"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrda010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda010
            #add-point:ON ACTION controlp INFIELD mrda010 name="input.c.mrda010"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrda011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrda011
            #add-point:ON ACTION controlp INFIELD mrda011 name="input.c.mrda011"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mrda_m.mrdadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #自動產生單號
               CALL s_aooi200_gen_docno(g_site,g_mrda_m.mrdadocno,g_mrda_m.mrdadocdt,g_prog)
               RETURNING l_success,g_mrda_m.mrdadocno
               IF l_success = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_mrda_m.mrdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD mrdadocno
               END IF
               DISPLAY BY NAME g_mrda_m.mrdadocno
               #end add-point
               
               INSERT INTO mrda_t (mrdaent,mrdasite,mrdadocno,mrdadocdt,mrda001,mrda002,mrda012,mrdastus, 
                   mrda003,mrda004,mrda005,mrda006,mrda007,mrda008,mrda009,mrda010,mrda011,mrdaownid, 
                   mrdaowndp,mrdacrtid,mrdacrtdp,mrdacrtdt,mrdamodid,mrdamoddt,mrdacnfid,mrdacnfdt)
               VALUES (g_enterprise,g_mrda_m.mrdasite,g_mrda_m.mrdadocno,g_mrda_m.mrdadocdt,g_mrda_m.mrda001, 
                   g_mrda_m.mrda002,g_mrda_m.mrda012,g_mrda_m.mrdastus,g_mrda_m.mrda003,g_mrda_m.mrda004, 
                   g_mrda_m.mrda005,g_mrda_m.mrda006,g_mrda_m.mrda007,g_mrda_m.mrda008,g_mrda_m.mrda009, 
                   g_mrda_m.mrda010,g_mrda_m.mrda011,g_mrda_m.mrdaownid,g_mrda_m.mrdaowndp,g_mrda_m.mrdacrtid, 
                   g_mrda_m.mrdacrtdp,g_mrda_m.mrdacrtdt,g_mrda_m.mrdamodid,g_mrda_m.mrdamoddt,g_mrda_m.mrdacnfid, 
                   g_mrda_m.mrdacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mrda_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               IF l_cmd_t <> 'r' OR p_cmd <> 'a' THEN
                  IF NOT amrt100_detail_default() THEN 
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
               END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL amrt100_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL amrt100_b_fill()
                  CALL amrt100_b_fill2('0')
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
               CALL amrt100_mrda_t_mask_restore('restore_mask_o')
               
               UPDATE mrda_t SET (mrdasite,mrdadocno,mrdadocdt,mrda001,mrda002,mrda012,mrdastus,mrda003, 
                   mrda004,mrda005,mrda006,mrda007,mrda008,mrda009,mrda010,mrda011,mrdaownid,mrdaowndp, 
                   mrdacrtid,mrdacrtdp,mrdacrtdt,mrdamodid,mrdamoddt,mrdacnfid,mrdacnfdt) = (g_mrda_m.mrdasite, 
                   g_mrda_m.mrdadocno,g_mrda_m.mrdadocdt,g_mrda_m.mrda001,g_mrda_m.mrda002,g_mrda_m.mrda012, 
                   g_mrda_m.mrdastus,g_mrda_m.mrda003,g_mrda_m.mrda004,g_mrda_m.mrda005,g_mrda_m.mrda006, 
                   g_mrda_m.mrda007,g_mrda_m.mrda008,g_mrda_m.mrda009,g_mrda_m.mrda010,g_mrda_m.mrda011, 
                   g_mrda_m.mrdaownid,g_mrda_m.mrdaowndp,g_mrda_m.mrdacrtid,g_mrda_m.mrdacrtdp,g_mrda_m.mrdacrtdt, 
                   g_mrda_m.mrdamodid,g_mrda_m.mrdamoddt,g_mrda_m.mrdacnfid,g_mrda_m.mrdacnfdt)
                WHERE mrdaent = g_enterprise AND mrdadocno = g_mrdadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mrda_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL amrt100_mrda_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mrda_m_t)
               LET g_log2 = util.JSON.stringify(g_mrda_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mrdadocno_t = g_mrda_m.mrdadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="amrt100.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mrdb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrdb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amrt100_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mrdb_d.getLength()
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
            CALL amrt100_b_fill2('2')
 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN amrt100_cl USING g_enterprise,g_mrda_m.mrdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt100_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt100_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mrdb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mrdb_d[l_ac].mrdbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mrdb_d_t.* = g_mrdb_d[l_ac].*  #BACKUP
               LET g_mrdb_d_o.* = g_mrdb_d[l_ac].*  #BACKUP
               CALL amrt100_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               CALL amrt100_set_no_required_b(l_cmd)
               CALL amrt100_set_required_b(l_cmd)
               #end add-point  
               CALL amrt100_set_no_entry_b(l_cmd)
               IF NOT amrt100_lock_b("mrdb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrt100_bcl INTO g_mrdb_d[l_ac].mrdbsite,g_mrdb_d[l_ac].mrdbseq,g_mrdb_d[l_ac].mrdb001, 
                      g_mrdb_d[l_ac].mrdb002,g_mrdb_d[l_ac].mrdb003,g_mrdb_d[l_ac].mrdb004,g_mrdb_d[l_ac].mrdb015, 
                      g_mrdb_d[l_ac].mrdb016,g_mrdb_d[l_ac].mrdb005,g_mrdb_d[l_ac].mrdb014,g_mrdb_d[l_ac].mrdb006, 
                      g_mrdb_d[l_ac].mrdb007,g_mrdb_d[l_ac].mrdb012,g_mrdb_d[l_ac].mrdb013
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mrdb_d_t.mrdbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrdb_d_mask_o[l_ac].* =  g_mrdb_d[l_ac].*
                  CALL amrt100_mrdb_t_mask()
                  LET g_mrdb_d_mask_n[l_ac].* =  g_mrdb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrt100_show()
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
            INITIALIZE g_mrdb_d[l_ac].* TO NULL 
            INITIALIZE g_mrdb_d_t.* TO NULL 
            INITIALIZE g_mrdb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_mrdb_d_t.* = g_mrdb_d[l_ac].*     #新輸入資料
            LET g_mrdb_d_o.* = g_mrdb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrt100_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            LET g_mrdb_d[l_ac].mrdbsite = g_site
            LET g_mrdb_d[l_ac].mrdb004 = 'N'
            
            CALL amrt100_set_no_required_b(l_cmd)
            CALL amrt100_set_required_b(l_cmd)
            #end add-point
            CALL amrt100_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrdb_d[li_reproduce_target].* = g_mrdb_d[li_reproduce].*
 
               LET g_mrdb_d[li_reproduce_target].mrdbseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF cl_null(g_mrdb_d[l_ac].mrdbseq) THEN
               SELECT MAX(mrdbseq)+1
                 INTO g_mrdb_d[l_ac].mrdbseq
                 FROM mrdb_t
                WHERE mrdbent = g_enterprise
                  AND mrdbdocno = g_mrda_m.mrdadocno 
                  
               IF cl_null(g_mrdb_d[l_ac].mrdbseq) THEN
                 LET g_mrdb_d[l_ac].mrdbseq = 1
               END IF
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
            SELECT COUNT(1) INTO l_count FROM mrdb_t 
             WHERE mrdbent = g_enterprise AND mrdbdocno = g_mrda_m.mrdadocno
 
               AND mrdbseq = g_mrdb_d[l_ac].mrdbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrda_m.mrdadocno
               LET gs_keys[2] = g_mrdb_d[g_detail_idx].mrdbseq
               CALL amrt100_insert_b('mrdb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mrdb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrt100_b_fill()
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
               LET gs_keys[01] = g_mrda_m.mrdadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mrdb_d_t.mrdbseq
 
            
               #刪除同層單身
               IF NOT amrt100_delete_b('mrdb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt100_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amrt100_key_delete_b(gs_keys,'mrdb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt100_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE amrt100_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mrdb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mrdb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdbsite
            #add-point:BEFORE FIELD mrdbsite name="input.b.page1.mrdbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdbsite
            
            #add-point:AFTER FIELD mrdbsite name="input.a.page1.mrdbsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdbsite
            #add-point:ON CHANGE mrdbsite name="input.g.page1.mrdbsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdbseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdb_d[l_ac].mrdbseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrdbseq
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdbseq name="input.a.page1.mrdbseq"

            #此段落由子樣板a05產生
            IF  g_mrda_m.mrdadocno IS NOT NULL AND g_mrdb_d[g_detail_idx].mrdbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrda_m.mrdadocno != g_mrdadocno_t OR g_mrdb_d[g_detail_idx].mrdbseq != g_mrdb_d_t.mrdbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrdb_t WHERE "||"mrdbent = '" ||g_enterprise|| "' AND "||"mrdbdocno = '"||g_mrda_m.mrdadocno ||"' AND "|| "mrdbseq = '"||g_mrdb_d[g_detail_idx].mrdbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdbseq
            #add-point:BEFORE FIELD mrdbseq name="input.b.page1.mrdbseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdbseq
            #add-point:ON CHANGE mrdbseq name="input.g.page1.mrdbseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb001
            
            #add-point:AFTER FIELD mrdb001 name="input.a.page1.mrdb001"
            CALL amrt100_mrdb001_ref()
            IF NOT cl_null(g_mrdb_d[l_ac].mrdb001) THEN
               IF g_mrdb_d[l_ac].mrdb001 <> g_mrdb_d_o.mrdb001 THEN
               
                  IF NOT s_azzi650_chk_exist('1110',g_mrdb_d[l_ac].mrdb001) THEN
                     LET g_mrdb_d[l_ac].mrdb001 = g_mrdb_d_o.mrdb001
                     CALL amrt100_mrdb001_ref()
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
            END IF

            LET g_mrdb_d_o.mrdb001 = g_mrdb_d[l_ac].mrdb001
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb001
            #add-point:BEFORE FIELD mrdb001 name="input.b.page1.mrdb001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdb001
            #add-point:ON CHANGE mrdb001 name="input.g.page1.mrdb001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb002
            
            #add-point:AFTER FIELD mrdb002 name="input.a.page1.mrdb002"
            CALL amrt100_mrdb002_ref()
            IF NOT cl_null(g_mrdb_d[l_ac].mrdb002) THEN
               IF g_mrdb_d[l_ac].mrdb002 <> g_mrdb_d_o.mrdb002 OR cl_null(g_mrdb_d_o.mrdb002) THEN
            
                  IF NOT s_azzi650_chk_exist('1114',g_mrdb_d[l_ac].mrdb002) THEN
                     LET g_mrdb_d[l_ac].mrdb002 = g_mrdb_d_o.mrdb002
                     CALL amrt100_mrdb002_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_mrdb_d_o.mrdb002 = g_mrdb_d[l_ac].mrdb002
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb002
            #add-point:BEFORE FIELD mrdb002 name="input.b.page1.mrdb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdb002
            #add-point:ON CHANGE mrdb002 name="input.g.page1.mrdb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb003
            #add-point:BEFORE FIELD mrdb003 name="input.b.page1.mrdb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb003
            
            #add-point:AFTER FIELD mrdb003 name="input.a.page1.mrdb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdb003
            #add-point:ON CHANGE mrdb003 name="input.g.page1.mrdb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb004
            #add-point:BEFORE FIELD mrdb004 name="input.b.page1.mrdb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb004
            
            #add-point:AFTER FIELD mrdb004 name="input.a.page1.mrdb004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdb004
            #add-point:ON CHANGE mrdb004 name="input.g.page1.mrdb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdb_d[l_ac].mrdb015,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mrdb015
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdb015 name="input.a.page1.mrdb015"
            CALL amrt100_set_no_required_b(l_cmd)
            CALL amrt100_set_required_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb015
            #add-point:BEFORE FIELD mrdb015 name="input.b.page1.mrdb015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdb015
            #add-point:ON CHANGE mrdb015 name="input.g.page1.mrdb015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb016
            #add-point:BEFORE FIELD mrdb016 name="input.b.page1.mrdb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb016
            
            #add-point:AFTER FIELD mrdb016 name="input.a.page1.mrdb016"
            CALL amrt100_set_no_required_b(l_cmd)
            CALL amrt100_set_required_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdb016
            #add-point:ON CHANGE mrdb016 name="input.g.page1.mrdb016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb005
            
            #add-point:AFTER FIELD mrdb005 name="input.a.page1.mrdb005"
            CALL amrt100_mrdb005_ref()
            
            IF NOT cl_null(g_mrdb_d[l_ac].mrdb005) THEN
               IF g_mrdb_d[l_ac].mrdb005 <> g_mrdb_d_o.mrdb005 OR cl_null(g_mrdb_d_o.mrdb005) THEN
            
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrda_m.mrda003
                  LET g_chkparam.arg2 = g_mrdb_d[l_ac].mrdb005
                  #160318-00025#23  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
                  #160318-00025#23  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_mrbc002") THEN
                     LET g_mrdb_d[l_ac].mrdb005 = g_mrdb_d_o.mrdb005
                     CALL amrt100_mrdb005_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            LET g_mrdb_d_o.mrdb005 = g_mrdb_d[l_ac].mrdb005

            CALL amrt100_set_no_required_b(l_cmd)
            CALL amrt100_set_required_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb005
            #add-point:BEFORE FIELD mrdb005 name="input.b.page1.mrdb005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdb005
            #add-point:ON CHANGE mrdb005 name="input.g.page1.mrdb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb005_desc
            #add-point:BEFORE FIELD mrdb005_desc name="input.b.page1.mrdb005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb005_desc
            
            #add-point:AFTER FIELD mrdb005_desc name="input.a.page1.mrdb005_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdb005_desc
            #add-point:ON CHANGE mrdb005_desc name="input.g.page1.mrdb005_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb014
            #add-point:BEFORE FIELD mrdb014 name="input.b.page1.mrdb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb014
            
            #add-point:AFTER FIELD mrdb014 name="input.a.page1.mrdb014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdb014
            #add-point:ON CHANGE mrdb014 name="input.g.page1.mrdb014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb006
            #add-point:BEFORE FIELD mrdb006 name="input.b.page1.mrdb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb006
            
            #add-point:AFTER FIELD mrdb006 name="input.a.page1.mrdb006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdb006
            #add-point:ON CHANGE mrdb006 name="input.g.page1.mrdb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb007
            #add-point:BEFORE FIELD mrdb007 name="input.b.page1.mrdb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb007
            
            #add-point:AFTER FIELD mrdb007 name="input.a.page1.mrdb007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdb007
            #add-point:ON CHANGE mrdb007 name="input.g.page1.mrdb007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb012
            
            #add-point:AFTER FIELD mrdb012 name="input.a.page1.mrdb012"
            CALL amrt100_mrdb012_ref()
            IF NOT cl_null(g_mrdb_d[l_ac].mrdb012) THEN
               IF g_mrdb_d[l_ac].mrdb012 <> g_mrdb_d_o.mrdb012 OR cl_null(g_mrdb_d_o.mrdb012) THEN
            
                  IF NOT s_azzi650_chk_exist('1106',g_mrdb_d[l_ac].mrdb012) THEN
                     LET g_mrdb_d[l_ac].mrdb012 = g_mrdb_d_o.mrdb012
                     CALL amrt100_mrdb012_ref()
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
            END IF

            LET g_mrdb_d_o.mrdb012 = g_mrdb_d[l_ac].mrdb012
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb012
            #add-point:BEFORE FIELD mrdb012 name="input.b.page1.mrdb012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdb012
            #add-point:ON CHANGE mrdb012 name="input.g.page1.mrdb012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdb013
            #add-point:BEFORE FIELD mrdb013 name="input.b.page1.mrdb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdb013
            
            #add-point:AFTER FIELD mrdb013 name="input.a.page1.mrdb013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdb013
            #add-point:ON CHANGE mrdb013 name="input.g.page1.mrdb013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mrdbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdbsite
            #add-point:ON ACTION controlp INFIELD mrdbsite name="input.c.page1.mrdbsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdbseq
            #add-point:ON ACTION controlp INFIELD mrdbseq name="input.c.page1.mrdbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb001
            #add-point:ON ACTION controlp INFIELD mrdb001 name="input.c.page1.mrdb001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrdb_d[l_ac].mrdb001             #給予default值
            LET g_qryparam.default2 = ""
            
            #給予arg
            LET g_qryparam.arg1 = "1110"
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_mrdb_d[l_ac].mrdb001 = g_qryparam.return1              
            DISPLAY g_mrdb_d[l_ac].mrdb001 TO mrdb001              #
            
            CALL amrt100_mrdb001_ref()
            NEXT FIELD mrdb001                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb002
            #add-point:ON ACTION controlp INFIELD mrdb002 name="input.c.page1.mrdb002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrdb_d[l_ac].mrdb002             #給予default值
            LET g_qryparam.default2 = "" 
            #給予arg
            LET g_qryparam.arg1 = "1114"
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_mrdb_d[l_ac].mrdb002 = g_qryparam.return1              
            DISPLAY g_mrdb_d[l_ac].mrdb002 TO mrdb002              #
            
            CALL amrt100_mrdb002_ref()
            NEXT FIELD mrdb002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb003
            #add-point:ON ACTION controlp INFIELD mrdb003 name="input.c.page1.mrdb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb004
            #add-point:ON ACTION controlp INFIELD mrdb004 name="input.c.page1.mrdb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb015
            #add-point:ON ACTION controlp INFIELD mrdb015 name="input.c.page1.mrdb015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb016
            #add-point:ON ACTION controlp INFIELD mrdb016 name="input.c.page1.mrdb016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb005
            #add-point:ON ACTION controlp INFIELD mrdb005 name="input.c.page1.mrdb005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrdb_d[l_ac].mrdb005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_mrda_m.mrda003 
            
            CALL q_mrbc002_2()                                #呼叫開窗

            LET g_mrdb_d[l_ac].mrdb005 = g_qryparam.return1              

            DISPLAY g_mrdb_d[l_ac].mrdb005 TO mrdb005              #

            CALL amrt100_mrdb005_ref()
            NEXT FIELD mrdb005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdb005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb005_desc
            #add-point:ON ACTION controlp INFIELD mrdb005_desc name="input.c.page1.mrdb005_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb014
            #add-point:ON ACTION controlp INFIELD mrdb014 name="input.c.page1.mrdb014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb006
            #add-point:ON ACTION controlp INFIELD mrdb006 name="input.c.page1.mrdb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb007
            #add-point:ON ACTION controlp INFIELD mrdb007 name="input.c.page1.mrdb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb012
            #add-point:ON ACTION controlp INFIELD mrdb012 name="input.c.page1.mrdb012"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrdb_d[l_ac].mrdb012             #給予default值
            LET g_qryparam.default2 = "" 
            #給予arg
            LET g_qryparam.arg1 = "1106" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_mrdb_d[l_ac].mrdb012 = g_qryparam.return1              
            DISPLAY g_mrdb_d[l_ac].mrdb012 TO mrdb012 
            
            CALL amrt100_mrdb012_ref()
            NEXT FIELD mrdb012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdb013
            #add-point:ON ACTION controlp INFIELD mrdb013 name="input.c.page1.mrdb013"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mrdb_d[l_ac].* = g_mrdb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrt100_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mrdb_d[l_ac].mrdbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mrdb_d[l_ac].* = g_mrdb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL amrt100_mrdb_t_mask_restore('restore_mask_o')
      
               UPDATE mrdb_t SET (mrdbdocno,mrdbsite,mrdbseq,mrdb001,mrdb002,mrdb003,mrdb004,mrdb015, 
                   mrdb016,mrdb005,mrdb014,mrdb006,mrdb007,mrdb012,mrdb013) = (g_mrda_m.mrdadocno,g_mrdb_d[l_ac].mrdbsite, 
                   g_mrdb_d[l_ac].mrdbseq,g_mrdb_d[l_ac].mrdb001,g_mrdb_d[l_ac].mrdb002,g_mrdb_d[l_ac].mrdb003, 
                   g_mrdb_d[l_ac].mrdb004,g_mrdb_d[l_ac].mrdb015,g_mrdb_d[l_ac].mrdb016,g_mrdb_d[l_ac].mrdb005, 
                   g_mrdb_d[l_ac].mrdb014,g_mrdb_d[l_ac].mrdb006,g_mrdb_d[l_ac].mrdb007,g_mrdb_d[l_ac].mrdb012, 
                   g_mrdb_d[l_ac].mrdb013)
                WHERE mrdbent = g_enterprise AND mrdbdocno = g_mrda_m.mrdadocno 
 
                  AND mrdbseq = g_mrdb_d_t.mrdbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mrdb_d[l_ac].* = g_mrdb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrdb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mrdb_d[l_ac].* = g_mrdb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrdb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrda_m.mrdadocno
               LET gs_keys_bak[1] = g_mrdadocno_t
               LET gs_keys[2] = g_mrdb_d[g_detail_idx].mrdbseq
               LET gs_keys_bak[2] = g_mrdb_d_t.mrdbseq
               CALL amrt100_update_b('mrdb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL amrt100_mrdb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mrdb_d[g_detail_idx].mrdbseq = g_mrdb_d_t.mrdbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_mrda_m.mrdadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mrdb_d_t.mrdbseq
 
                  CALL amrt100_key_update_b(gs_keys,'mrdb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrda_m),util.JSON.stringify(g_mrdb_d_t)
               LET g_log2 = util.JSON.stringify(g_mrda_m),util.JSON.stringify(g_mrdb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL amrt100_unlock_b("mrdb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            #將單身"預計時間"合計回寫至單頭"保養花費時間"
            LET g_sql = "SELECT mrdb015,mrdb016",
                        "  FROM mrdb_t",
                        " WHERE mrdbent = '",g_enterprise,"'",
                        "   AND mrdbdocno = ?"
                        
            PREPARE amrt100_count FROM g_sql
            DECLARE amrt100_count_cs CURSOR FOR amrt100_count
            
            OPEN amrt100_count_cs USING g_mrda_m.mrdadocno
      
            LET l_time = 0
            LET l_success = TRUE            
            FOREACH amrt100_count_cs INTO l_mrdb015,l_mrdb016
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_success = FALSE
                  EXIT FOREACH
               END IF

               CASE l_mrdb016
                  WHEN '1'   #秒
                     LET l_time = l_time + (l_mrdb015)
                  WHEN '2'   #分
                     LET l_time = l_time + (l_mrdb015 * 60)
                  WHEN '3'   #小時
                     LET l_time = l_time + (l_mrdb015 * 3600)
                  WHEN '4'   #天
                     LET l_time = l_time + (l_mrdb015 * 86400)
               END CASE

            END FOREACH
            
            FREE amrt100_count
            CLOSE amrt100_count_cs
            
            IF l_success THEN
               IF cl_null(g_mrda_m.mrda011) THEN
                  LET g_mrda_m.mrda011 = '2'
               END IF
               
               CASE g_mrda_m.mrda011
                  WHEN '1'   #秒
                     LET g_mrda_m.mrda010 = l_time
                  WHEN '2'   #分
                     LET g_mrda_m.mrda010 = l_time / 60
                  WHEN '3'   #小時
                     LET g_mrda_m.mrda010 = l_time / 3600
                  WHEN '4'   #天
                     LET g_mrda_m.mrda010 = l_time / 86400               
               END CASE
               
               UPDATE mrda_t
                  SET mrda010 = g_mrda_m.mrda010,
                      mrda011 = g_mrda_m.mrda011
                WHERE mrdaent = g_enterprise
                  AND mrdadocno = g_mrda_m.mrdadocno
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "mrda_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
               
               DISPLAY BY NAME g_mrda_m.mrda010
               DISPLAY BY NAME g_mrda_m.mrda011
            END IF
              
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mrdb_d[li_reproduce_target].* = g_mrdb_d[li_reproduce].*
 
               LET g_mrdb_d[li_reproduce_target].mrdbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrdb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrdb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
      INPUT ARRAY g_mrdb2_d FROM s_detail2.*
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
            IF g_detail_idx = 0 OR g_mrdb_d.getLength() = 0 THEN
               NEXT FIELD mrdbseq
            END IF
            #檢查上層單身是否有資料
            IF cl_null(g_mrdb_d[g_detail_idx].mrdbseq) THEN
               NEXT FIELD mrdbseq
            END IF
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrdb2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mrdb2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mrdb2_d[l_ac].* TO NULL 
            INITIALIZE g_mrdb2_d_t.* TO NULL 
            INITIALIZE g_mrdb2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_mrdb2_d[l_ac].mrde005 = "1"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_mrdb2_d_t.* = g_mrdb2_d[l_ac].*     #新輸入資料
            LET g_mrdb2_d_o.* = g_mrdb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrt100_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            LET g_mrdb2_d[l_ac].mrdesite = g_site
            
            CALL amrt100_set_no_required_b(l_cmd)
            CALL amrt100_set_required_b(l_cmd)
            #end add-point
            CALL amrt100_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrdb2_d[li_reproduce_target].* = g_mrdb2_d[li_reproduce].*
 
               LET g_mrdb2_d[li_reproduce_target].mrdeseq1 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            IF cl_null(g_mrdb2_d[l_ac].mrdeseq1) THEN
               SELECT MAX(mrdeseq1)+1
                 INTO g_mrdb2_d[l_ac].mrdeseq1
                 FROM mrde_t
                WHERE mrdeent = g_enterprise
                  AND mrdedocno = g_mrda_m.mrdadocno
                  AND mrdeseq = g_mrdb_d[g_detail_idx].mrdbseq
                  
               IF cl_null(g_mrdb2_d[l_ac].mrdeseq1) THEN
                 LET g_mrdb2_d[l_ac].mrdeseq1 = 1
               END IF
            END IF
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
            OPEN amrt100_cl USING g_enterprise,g_mrda_m.mrdadocno
            #(ver:78) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt100_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CLOSE amrt100_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            #(ver:78) --- end ---
            OPEN amrt100_bcl USING g_enterprise,g_mrda_m.mrdadocno,g_mrdb_d[g_detail_idx].mrdbseq
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt100_bcl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt100_cl
               CLOSE amrt100_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mrdb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mrdb2_d[l_ac].mrdeseq1 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mrdb2_d_t.* = g_mrdb2_d[l_ac].*  #BACKUP
               LET g_mrdb2_d_o.* = g_mrdb2_d[l_ac].*  #BACKUP
               CALL amrt100_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               CALL amrt100_set_no_required_b(l_cmd)
               CALL amrt100_set_required_b(l_cmd)
               #end add-point  
               CALL amrt100_set_no_entry_b(l_cmd)
               IF NOT amrt100_lock_b("mrde_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrt100_bcl2 INTO g_mrdb2_d[l_ac].mrdesite,g_mrdb2_d[l_ac].mrdeseq1,g_mrdb2_d[l_ac].mrde001, 
                      g_mrdb2_d[l_ac].mrde004,g_mrdb2_d[l_ac].mrde002,g_mrdb2_d[l_ac].mrde003,g_mrdb2_d[l_ac].mrde005 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrdb2_d_mask_o[l_ac].* =  g_mrdb2_d[l_ac].*
                  CALL amrt100_mrde_t_mask()
                  LET g_mrdb2_d_mask_n[l_ac].* =  g_mrdb2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrt100_show()
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
               LET gs_keys[1] = g_mrda_m.mrdadocno
               LET gs_keys[2] = g_mrdb_d[g_detail_idx].mrdbseq
               LET gs_keys[3] = g_mrdb2_d_t.mrdeseq1
 
 
               #刪除同層單身
               IF NOT amrt100_delete_b('mrde_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt100_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point   
               
               CALL s_transaction_end('Y','0')
               CLOSE amrt100_bcl
                  
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
 
               LET l_count = g_mrdb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mrdb2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM mrde_t 
             WHERE mrdeent = g_enterprise AND mrdedocno = g_mrda_m.mrdadocno AND mrdeseq = g_mrdb_d[g_detail_idx].mrdbseq  
                 AND mrdeseq1 = g_mrdb2_d[g_detail_idx2].mrdeseq1
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrda_m.mrdadocno
               LET gs_keys[2] = g_mrdb_d[g_detail_idx].mrdbseq
               LET gs_keys[3] = g_mrdb2_d[g_detail_idx2].mrdeseq1
               CALL amrt100_insert_b('mrde_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mrdb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mrde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrt100_b_fill()
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
               LET g_mrdb2_d[l_ac].* = g_mrdb2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrt100_bcl2
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
               LET g_mrdb2_d[l_ac].* = g_mrdb2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL amrt100_mrde_t_mask_restore('restore_mask_o')
               
               UPDATE mrde_t SET (mrdedocno,mrdeseq,mrdesite,mrdeseq1,mrde001,mrde004,mrde002,mrde003, 
                   mrde005) = (g_mrda_m.mrdadocno,g_mrdb_d[g_detail_idx].mrdbseq,g_mrdb2_d[l_ac].mrdesite, 
                   g_mrdb2_d[l_ac].mrdeseq1,g_mrdb2_d[l_ac].mrde001,g_mrdb2_d[l_ac].mrde004,g_mrdb2_d[l_ac].mrde002, 
                   g_mrdb2_d[l_ac].mrde003,g_mrdb2_d[l_ac].mrde005) #自訂欄位頁簽
                WHERE mrdeent = g_enterprise AND mrdedocno = g_mrdadocno_t AND mrdeseq = g_mrdb_d[g_detail_idx].mrdbseq  
                    AND mrdeseq1 = g_mrdb2_d_t.mrdeseq1
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mrdb2_d[l_ac].* = g_mrdb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrde_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mrdb2_d[l_ac].* = g_mrdb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrde_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrda_m.mrdadocno
               LET gs_keys_bak[1] = g_mrdadocno_t
               LET gs_keys[2] = g_mrdb_d[g_detail_idx].mrdbseq
               LET gs_keys_bak[2] = g_mrdb_d[g_detail_idx].mrdbseq
               LET gs_keys[3] = g_mrdb2_d[g_detail_idx2].mrdeseq1
               LET gs_keys_bak[3] = g_mrdb2_d_t.mrdeseq1
               CALL amrt100_update_b('mrde_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amrt100_mrde_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrda_m),util.JSON.stringify(g_mrdb2_d_t)
               LET g_log2 = util.JSON.stringify(g_mrda_m),util.JSON.stringify(g_mrdb2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdeseq1
            #add-point:BEFORE FIELD mrdeseq1 name="input.b.page2.mrdeseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdeseq1
            
            #add-point:AFTER FIELD mrdeseq1 name="input.a.page2.mrdeseq1"
            #此段落由子樣板a05產生
            IF  g_mrda_m.mrdadocno IS NOT NULL AND g_mrdb_d[g_detail_idx].mrdbseq IS NOT NULL AND g_mrdb2_d[g_detail_idx2].mrdeseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrda_m.mrdadocno != g_mrdadocno_t OR g_mrdb_d[g_detail_idx].mrdbseq != g_mrdb_d[g_detail_idx].mrdbseq OR g_mrdb2_d[g_detail_idx2].mrdeseq1 != g_mrdb2_d_t.mrdeseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrde_t WHERE "||"mrdeent = '" ||g_enterprise|| "' AND "||"mrdedocno = '"||g_mrda_m.mrdadocno ||"' AND "|| "mrdeseq = '"||g_mrdb_d[g_detail_idx].mrdbseq ||"' AND "|| "mrdeseq1 = '"||g_mrdb2_d[g_detail_idx2].mrdeseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdeseq1
            #add-point:ON CHANGE mrdeseq1 name="input.g.page2.mrdeseq1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrde001
            
            #add-point:AFTER FIELD mrde001 name="input.a.page2.mrde001"
            CALL s_desc_get_item_desc(g_mrdb2_d[l_ac].mrde001) RETURNING g_mrdb2_d[l_ac].mrde001_desc,g_mrdb2_d[l_ac].mrde001_desc1
            
            IF NOT cl_null(g_mrdb2_d[l_ac].mrde001) THEN 
               IF g_mrdb2_d[l_ac].mrde001 <> g_mrdb2_d_o.mrde001 OR cl_null(g_mrdb2_d_o.mrde001) THEN
               
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrdb2_d[l_ac].mrde001                     
                  #呼叫檢查存在並帶值的library
#160716-00003#1-s
#                 IF NOT cl_chk_exist("v_imaa001") THEN
                  IF NOT cl_chk_exist("v_imaf001_14") THEN
#160716-00003#1-e
                     LET g_mrdb2_d[l_ac].mrde001 = g_mrdb2_d_o.mrde001                     
                     CALL s_desc_get_item_desc(g_mrdb2_d[l_ac].mrde001) RETURNING g_mrdb2_d[l_ac].mrde001_desc,g_mrdb2_d[l_ac].mrde001_desc1                       
                     NEXT FIELD CURRENT
                  END IF

                  #預設料件imaa006基礎單位
                  LET g_mrdb2_d_o.mrde003 = ''
                  SELECT imaa006 INTO g_mrdb2_d[l_ac].mrde003
                    FROM imaa_t
                   WHERE imaaent = g_enterprise
                     AND imaa001 = g_mrdb2_d[l_ac].mrde001
                  
                  CALL s_desc_get_unit_desc(g_mrdb2_d[l_ac].mrde003) RETURNING g_mrdb2_d[l_ac].mrde003_desc  

               END IF
            END IF 

            LET g_mrdb2_d_o.mrde001 = g_mrdb2_d[l_ac].mrde001
            
            IF NOT amrt100_mrde001_mrde003_chk() THEN
               NEXT FIELD mrde003
            END IF            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrde001
            #add-point:BEFORE FIELD mrde001 name="input.b.page2.mrde001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrde001
            #add-point:ON CHANGE mrde001 name="input.g.page2.mrde001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrde001_desc
            #add-point:BEFORE FIELD mrde001_desc name="input.b.page2.mrde001_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrde001_desc
            
            #add-point:AFTER FIELD mrde001_desc name="input.a.page2.mrde001_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrde001_desc
            #add-point:ON CHANGE mrde001_desc name="input.g.page2.mrde001_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrde001_desc1
            #add-point:BEFORE FIELD mrde001_desc1 name="input.b.page2.mrde001_desc1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrde001_desc1
            
            #add-point:AFTER FIELD mrde001_desc1 name="input.a.page2.mrde001_desc1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrde001_desc1
            #add-point:ON CHANGE mrde001_desc1 name="input.g.page2.mrde001_desc1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrde004
            #add-point:BEFORE FIELD mrde004 name="input.b.page2.mrde004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrde004
            
            #add-point:AFTER FIELD mrde004 name="input.a.page2.mrde004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrde004
            #add-point:ON CHANGE mrde004 name="input.g.page2.mrde004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrde002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdb2_d[l_ac].mrde002,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mrde002
            END IF 
 
 
 
            #add-point:AFTER FIELD mrde002 name="input.a.page2.mrde002"
            IF NOT cl_null(g_mrdb2_d[l_ac].mrde002) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrde002
            #add-point:BEFORE FIELD mrde002 name="input.b.page2.mrde002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrde002
            #add-point:ON CHANGE mrde002 name="input.g.page2.mrde002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrde003
            
            #add-point:AFTER FIELD mrde003 name="input.a.page2.mrde003"
            CALL s_desc_get_unit_desc(g_mrdb2_d[l_ac].mrde003) RETURNING g_mrdb2_d[l_ac].mrde003_desc
            
            IF NOT cl_null(g_mrdb2_d[l_ac].mrde003) THEN 
               IF g_mrdb2_d[l_ac].mrde003 <> g_mrdb2_d_o.mrde003 OR cl_null(g_mrdb2_d_o.mrde003) THEN
               
                  IF NOT amrt100_mrde001_mrde003_chk() THEN
                     LET g_mrdb2_d[l_ac].mrde003 = g_mrdb2_d_o.mrde003
                     
                     CALL s_desc_get_unit_desc(g_mrdb2_d[l_ac].mrde003) RETURNING g_mrdb2_d[l_ac].mrde003_desc
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 

            LET g_mrdb2_d_o.mrde003 = g_mrdb2_d[l_ac].mrde003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrde003
            #add-point:BEFORE FIELD mrde003 name="input.b.page2.mrde003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrde003
            #add-point:ON CHANGE mrde003 name="input.g.page2.mrde003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrde005
            #add-point:BEFORE FIELD mrde005 name="input.b.page2.mrde005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrde005
            
            #add-point:AFTER FIELD mrde005 name="input.a.page2.mrde005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrde005
            #add-point:ON CHANGE mrde005 name="input.g.page2.mrde005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.mrdeseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdeseq1
            #add-point:ON ACTION controlp INFIELD mrdeseq1 name="input.c.page2.mrdeseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrde001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrde001
            #add-point:ON ACTION controlp INFIELD mrde001 name="input.c.page2.mrde001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdb2_d[l_ac].mrde001             #給予default值
            LET g_qryparam.default2 = ""        #g_mrdb2_d[l_ac].imaal003 #品名
            LET g_qryparam.default3 = ""        #g_mrdb2_d[l_ac].imaal004 #規格           
#160716-00003#1-s
#           CALL q_imaa001()                    #呼叫開窗
            CALL q_imaf001_15()                 #呼叫開窗
#160716-00003#1-e
            LET g_mrdb2_d[l_ac].mrde001 = g_qryparam.return1
            DISPLAY g_mrdb2_d[l_ac].mrde001 TO mrde001            
            CALL s_desc_get_item_desc(g_mrdb2_d[l_ac].mrde001)
            RETURNING g_mrdb2_d[l_ac].mrde001_desc,g_mrdb2_d[l_ac].mrde001_desc1
            DISPLAY BY NAME g_mrdb2_d[l_ac].mrde001_desc
            DISPLAY BY NAME g_mrdb2_d[l_ac].mrde001_desc1            
            NEXT FIELD mrde001                  #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrde001_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrde001_desc
            #add-point:ON ACTION controlp INFIELD mrde001_desc name="input.c.page2.mrde001_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrde001_desc1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrde001_desc1
            #add-point:ON ACTION controlp INFIELD mrde001_desc1 name="input.c.page2.mrde001_desc1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrde004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrde004
            #add-point:ON ACTION controlp INFIELD mrde004 name="input.c.page2.mrde004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrde002
            #add-point:ON ACTION controlp INFIELD mrde002 name="input.c.page2.mrde002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrde003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrde003
            #add-point:ON ACTION controlp INFIELD mrde003 name="input.c.page2.mrde003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrdb2_d[l_ac].mrde003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_mrdb2_d[l_ac].mrde001

            
            CALL q_imao002()                                #呼叫開窗

            LET g_mrdb2_d[l_ac].mrde003 = g_qryparam.return1              

            DISPLAY g_mrdb2_d[l_ac].mrde003 TO mrde003              #

            CALL s_desc_get_unit_desc(g_mrdb2_d[l_ac].mrde003)
            RETURNING g_mrdb2_d[l_ac].mrde003_desc
            DISPLAY BY NAME g_mrdb2_d[l_ac].mrde003_desc

            NEXT FIELD mrde003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.mrde005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrde005
            #add-point:ON ACTION controlp INFIELD mrde005 name="input.c.page2.mrde005"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2_after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mrdb2_d[l_ac].* = g_mrdb2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrt100_bcl2
               CLOSE amrt100_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL amrt100_unlock_b("mrde_t","'2'")
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
               LET g_mrdb2_d[li_reproduce_target].* = g_mrdb2_d[li_reproduce].*
 
               LET g_mrdb2_d[li_reproduce_target].mrdeseq1 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrdb2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrdb2_d.getLength()+1
            END IF
        
      END INPUT
 
 
 
 
{</section>}
 
{<section id="amrt100.input.other" >}
      
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
            NEXT FIELD mrdadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mrdbsite
               WHEN "s_detail2"
                  NEXT FIELD mrdesite
 
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
 
{<section id="amrt100.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION amrt100_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL amrt100_b_fill() #單身填充
      CALL amrt100_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL amrt100_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

            CALL s_aooi200_get_slip_desc(g_mrda_m.mrdadocno) RETURNING g_mrda_m.mrdadocno_desc
            DISPLAY BY NAME g_mrda_m.mrdadocno_desc
            
            CALL amrt100_mrda003_ref(g_mrda_m.mrda003) RETURNING g_mrda_m.mrda003_desc
            DISPLAY BY NAME g_mrda_m.mrda003_desc

   #end add-point
   
   #遮罩相關處理
   LET g_mrda_m_mask_o.* =  g_mrda_m.*
   CALL amrt100_mrda_t_mask()
   LET g_mrda_m_mask_n.* =  g_mrda_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mrda_m.mrdasite,g_mrda_m.mrdadocno,g_mrda_m.mrdadocno_desc,g_mrda_m.mrdadocdt,g_mrda_m.mrda001, 
       g_mrda_m.mrda001_desc,g_mrda_m.mrda002,g_mrda_m.mrda002_desc,g_mrda_m.mrda012,g_mrda_m.mrdastus, 
       g_mrda_m.mrda003,g_mrda_m.mrda003_desc,g_mrda_m.mrda004,g_mrda_m.mrda004_desc,g_mrda_m.mrda005, 
       g_mrda_m.mrda005_desc,g_mrda_m.mrda006,g_mrda_m.mrda006_desc,g_mrda_m.mrda007,g_mrda_m.mrda007_desc, 
       g_mrda_m.mrda008,g_mrda_m.mrda009,g_mrda_m.mrda010,g_mrda_m.mrda011,g_mrda_m.mrdaownid,g_mrda_m.mrdaownid_desc, 
       g_mrda_m.mrdaowndp,g_mrda_m.mrdaowndp_desc,g_mrda_m.mrdacrtid,g_mrda_m.mrdacrtid_desc,g_mrda_m.mrdacrtdp, 
       g_mrda_m.mrdacrtdp_desc,g_mrda_m.mrdacrtdt,g_mrda_m.mrdamodid,g_mrda_m.mrdamodid_desc,g_mrda_m.mrdamoddt, 
       g_mrda_m.mrdacnfid,g_mrda_m.mrdacnfid_desc,g_mrda_m.mrdacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrda_m.mrdastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "1"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/checked.png")
         WHEN "2"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/completed.png")
         WHEN "3"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/wait_fix.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mrdb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"

            CALL amrt100_mrdb005_ref()

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_mrdb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
            CALL s_desc_get_item_desc(g_mrdb2_d[l_ac].mrde001)
            RETURNING g_mrdb2_d[l_ac].mrde001_desc,g_mrdb2_d[l_ac].mrde001_desc1
            DISPLAY BY NAME g_mrdb2_d[l_ac].mrde001_desc
            DISPLAY BY NAME g_mrdb2_d[l_ac].mrde001_desc1
            
            CALL s_desc_get_unit_desc(g_mrdb2_d[l_ac].mrde003)
            RETURNING g_mrdb2_d[l_ac].mrde003_desc
            DISPLAY BY NAME g_mrdb2_d[l_ac].mrde003_desc
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL amrt100_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="amrt100.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION amrt100_detail_show()
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
 
{<section id="amrt100.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION amrt100_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mrda_t.mrdadocno 
   DEFINE l_oldno     LIKE mrda_t.mrdadocno 
 
   DEFINE l_master    RECORD LIKE mrda_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mrdb_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE mrde_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_mrda_m.mrdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mrdadocno_t = g_mrda_m.mrdadocno
 
    
   LET g_mrda_m.mrdadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrda_m.mrdaownid = g_user
      LET g_mrda_m.mrdaowndp = g_dept
      LET g_mrda_m.mrdacrtid = g_user
      LET g_mrda_m.mrdacrtdp = g_dept 
      LET g_mrda_m.mrdacrtdt = cl_get_current()
      LET g_mrda_m.mrdamodid = g_user
      LET g_mrda_m.mrdamoddt = cl_get_current()
      LET g_mrda_m.mrdastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
      LET g_mrda_m.mrda009 = g_mrda_m.mrdadocdt
      LET g_mrda_m.mrdadocdt = g_today
      LET g_mrda_m.mrda001 = g_user
      LET g_mrda_m.mrda002 = g_dept      
      LET g_mrda_m.mrda012 = ''
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrda_m.mrdastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "1"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/checked.png")
         WHEN "2"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/completed.png")
         WHEN "3"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/wait_fix.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_mrda_m.mrdadocno_desc = ''
   DISPLAY BY NAME g_mrda_m.mrdadocno_desc
 
   
   CALL amrt100_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mrda_m.* TO NULL
      INITIALIZE g_mrdb_d TO NULL
      INITIALIZE g_mrdb2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL amrt100_show()
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
   CALL amrt100_set_act_visible()   
   CALL amrt100_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mrdadocno_t = g_mrda_m.mrdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrdaent = " ||g_enterprise|| " AND",
                      " mrdadocno = '", g_mrda_m.mrdadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amrt100_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL amrt100_idx_chk()
   
   LET g_data_owner = g_mrda_m.mrdaownid      
   LET g_data_dept  = g_mrda_m.mrdaowndp
   
   #功能已完成,通報訊息中心
   CALL amrt100_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="amrt100.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION amrt100_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mrdb_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE mrde_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE amrt100_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrdb_t
    WHERE mrdbent = g_enterprise AND mrdbdocno = g_mrdadocno_t
 
    INTO TEMP amrt100_detail
 
   #將key修正為調整後   
   UPDATE amrt100_detail 
      #更新key欄位
      SET mrdbdocno = g_mrda_m.mrdadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   UPDATE amrt100_detail 
      SET mrdb004 = 'N'  #完成否
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mrdb_t SELECT * FROM amrt100_detail
   
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
   DROP TABLE amrt100_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrde_t 
    WHERE mrdeent = g_enterprise AND mrdedocno = g_mrdadocno_t
 
    INTO TEMP amrt100_detail
 
   #將key修正為調整後   
   UPDATE amrt100_detail SET mrdedocno = g_mrda_m.mrdadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO mrde_t SELECT * FROM amrt100_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE amrt100_detail
   
   LET g_data_owner = g_mrda_m.mrdaownid      
   LET g_data_dept  = g_mrda_m.mrdaowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   CALL amrt100_b_fill()
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mrdadocno_t = g_mrda_m.mrdadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="amrt100.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amrt100_delete()
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
   
   IF g_mrda_m.mrdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN amrt100_cl USING g_enterprise,g_mrda_m.mrdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt100_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amrt100_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amrt100_master_referesh USING g_mrda_m.mrdadocno INTO g_mrda_m.mrdasite,g_mrda_m.mrdadocno, 
       g_mrda_m.mrdadocdt,g_mrda_m.mrda001,g_mrda_m.mrda002,g_mrda_m.mrda012,g_mrda_m.mrdastus,g_mrda_m.mrda003, 
       g_mrda_m.mrda004,g_mrda_m.mrda005,g_mrda_m.mrda006,g_mrda_m.mrda007,g_mrda_m.mrda008,g_mrda_m.mrda009, 
       g_mrda_m.mrda010,g_mrda_m.mrda011,g_mrda_m.mrdaownid,g_mrda_m.mrdaowndp,g_mrda_m.mrdacrtid,g_mrda_m.mrdacrtdp, 
       g_mrda_m.mrdacrtdt,g_mrda_m.mrdamodid,g_mrda_m.mrdamoddt,g_mrda_m.mrdacnfid,g_mrda_m.mrdacnfdt, 
       g_mrda_m.mrda001_desc,g_mrda_m.mrda002_desc,g_mrda_m.mrda004_desc,g_mrda_m.mrda005_desc,g_mrda_m.mrda006_desc, 
       g_mrda_m.mrda007_desc,g_mrda_m.mrdaownid_desc,g_mrda_m.mrdaowndp_desc,g_mrda_m.mrdacrtid_desc, 
       g_mrda_m.mrdacrtdp_desc,g_mrda_m.mrdamodid_desc,g_mrda_m.mrdacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT amrt100_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mrda_m_mask_o.* =  g_mrda_m.*
   CALL amrt100_mrda_t_mask()
   LET g_mrda_m_mask_n.* =  g_mrda_m.*
   
   CALL amrt100_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amrt100_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mrdadocno_t = g_mrda_m.mrdadocno
 
 
      DELETE FROM mrda_t
       WHERE mrdaent = g_enterprise AND mrdadocno = g_mrda_m.mrdadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mrda_m.mrdadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #140526---add---start---
      IF NOT s_aooi200_del_docno(g_mrda_m.mrdadocno,g_mrda_m.mrdadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #140526---add---end---
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM mrdb_t
       WHERE mrdbent = g_enterprise AND mrdbdocno = g_mrda_m.mrdadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdb_t:",SQLERRMESSAGE 
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
      DELETE FROM mrde_t
       WHERE mrdeent = g_enterprise AND
             mrdedocno = g_mrda_m.mrdadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mrda_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE amrt100_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mrdb_d.clear() 
      CALL g_mrdb2_d.clear()       
 
     
      CALL amrt100_ui_browser_refresh()  
      #CALL amrt100_ui_headershow()  
      #CALL amrt100_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL amrt100_browser_fill("")
         CALL amrt100_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE amrt100_cl
 
   #功能已完成,通報訊息中心
   CALL amrt100_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="amrt100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amrt100_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mrdb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF amrt100_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mrdbsite,mrdbseq,mrdb001,mrdb002,mrdb003,mrdb004,mrdb015,mrdb016, 
             mrdb005,mrdb014,mrdb006,mrdb007,mrdb012,mrdb013 ,t1.oocql004 ,t2.oocql004 ,t3.oocql004 FROM mrdb_t", 
                
                     " INNER JOIN mrda_t ON mrdaent = " ||g_enterprise|| " AND mrdadocno = mrdbdocno ",
 
                     #"",
                     " LEFT JOIN mrde_t ON mrdbent = mrdeent AND mrdbdocno = mrdedocno AND mrdbseq = mrdeseq ",
                     "",
                     #下層單身所需的join條件
                     " ",
 
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='1110' AND t1.oocql002=mrdb001 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='1114' AND t2.oocql002=mrdb002 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='1106' AND t3.oocql002=mrdb012 AND t3.oocql003='"||g_dlang||"' ",
 
                     " WHERE mrdbent=? AND mrdbdocno=?"
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
 
         
         LET g_sql = g_sql, " ORDER BY mrdb_t.mrdbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrt100_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR amrt100_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mrda_m.mrdadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mrda_m.mrdadocno INTO g_mrdb_d[l_ac].mrdbsite,g_mrdb_d[l_ac].mrdbseq, 
          g_mrdb_d[l_ac].mrdb001,g_mrdb_d[l_ac].mrdb002,g_mrdb_d[l_ac].mrdb003,g_mrdb_d[l_ac].mrdb004, 
          g_mrdb_d[l_ac].mrdb015,g_mrdb_d[l_ac].mrdb016,g_mrdb_d[l_ac].mrdb005,g_mrdb_d[l_ac].mrdb014, 
          g_mrdb_d[l_ac].mrdb006,g_mrdb_d[l_ac].mrdb007,g_mrdb_d[l_ac].mrdb012,g_mrdb_d[l_ac].mrdb013, 
          g_mrdb_d[l_ac].mrdb001_desc,g_mrdb_d[l_ac].mrdb002_desc,g_mrdb_d[l_ac].mrdb012_desc   #(ver:78) 
 
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
   
   CALL g_mrdb_d.deleteElement(g_mrdb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE amrt100_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mrdb_d.getLength()
      LET g_mrdb_d_mask_o[l_ac].* =  g_mrdb_d[l_ac].*
      CALL amrt100_mrdb_t_mask()
      LET g_mrdb_d_mask_n[l_ac].* =  g_mrdb_d[l_ac].*
   END FOR
   
   LET g_mrdb2_d_mask_o.* =  g_mrdb2_d.*
   FOR l_ac = 1 TO g_mrdb2_d.getLength()
      LET g_mrdb2_d_mask_o[l_ac].* =  g_mrdb2_d[l_ac].*
      CALL amrt100_mrde_t_mask()
      LET g_mrdb2_d_mask_n[l_ac].* =  g_mrdb2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="amrt100.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amrt100_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM mrdb_t
       WHERE mrdbent = g_enterprise AND
         mrdbdocno = ps_keys_bak[1] AND mrdbseq = ps_keys_bak[2]
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
         CALL g_mrdb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM mrde_t
       WHERE mrdeent = g_enterprise AND
             mrdedocno = ps_keys_bak[1] AND mrdeseq = ps_keys_bak[2] AND mrdeseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_mrdb2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrt100.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amrt100_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mrdb_t
                  (mrdbent,
                   mrdbdocno,
                   mrdbseq
                   ,mrdbsite,mrdb001,mrdb002,mrdb003,mrdb004,mrdb015,mrdb016,mrdb005,mrdb014,mrdb006,mrdb007,mrdb012,mrdb013) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mrdb_d[g_detail_idx].mrdbsite,g_mrdb_d[g_detail_idx].mrdb001,g_mrdb_d[g_detail_idx].mrdb002, 
                       g_mrdb_d[g_detail_idx].mrdb003,g_mrdb_d[g_detail_idx].mrdb004,g_mrdb_d[g_detail_idx].mrdb015, 
                       g_mrdb_d[g_detail_idx].mrdb016,g_mrdb_d[g_detail_idx].mrdb005,g_mrdb_d[g_detail_idx].mrdb014, 
                       g_mrdb_d[g_detail_idx].mrdb006,g_mrdb_d[g_detail_idx].mrdb007,g_mrdb_d[g_detail_idx].mrdb012, 
                       g_mrdb_d[g_detail_idx].mrdb013)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mrdb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO mrde_t
                  (mrdeent,
                   mrdedocno,mrdeseq,
                   mrdeseq1
                   ,mrdesite,mrde001,mrde004,mrde002,mrde003,mrde005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_mrdb2_d[g_detail_idx2].mrdesite,g_mrdb2_d[g_detail_idx2].mrde001,g_mrdb2_d[g_detail_idx2].mrde004, 
                       g_mrdb2_d[g_detail_idx2].mrde002,g_mrdb2_d[g_detail_idx2].mrde003,g_mrdb2_d[g_detail_idx2].mrde005) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_mrdb2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="amrt100.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amrt100_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mrdb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL amrt100_mrdb_t_mask_restore('restore_mask_o')
               
      UPDATE mrdb_t 
         SET (mrdbdocno,
              mrdbseq
              ,mrdbsite,mrdb001,mrdb002,mrdb003,mrdb004,mrdb015,mrdb016,mrdb005,mrdb014,mrdb006,mrdb007,mrdb012,mrdb013) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mrdb_d[g_detail_idx].mrdbsite,g_mrdb_d[g_detail_idx].mrdb001,g_mrdb_d[g_detail_idx].mrdb002, 
                  g_mrdb_d[g_detail_idx].mrdb003,g_mrdb_d[g_detail_idx].mrdb004,g_mrdb_d[g_detail_idx].mrdb015, 
                  g_mrdb_d[g_detail_idx].mrdb016,g_mrdb_d[g_detail_idx].mrdb005,g_mrdb_d[g_detail_idx].mrdb014, 
                  g_mrdb_d[g_detail_idx].mrdb006,g_mrdb_d[g_detail_idx].mrdb007,g_mrdb_d[g_detail_idx].mrdb012, 
                  g_mrdb_d[g_detail_idx].mrdb013) 
         WHERE mrdbent = g_enterprise AND mrdbdocno = ps_keys_bak[1] AND mrdbseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrt100_mrdb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mrde_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL amrt100_mrde_t_mask_restore('restore_mask_o')
               
      UPDATE mrde_t 
         SET (mrdedocno,mrdeseq,
              mrdeseq1
              ,mrdesite,mrde001,mrde004,mrde002,mrde003,mrde005) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_mrdb2_d[g_detail_idx2].mrdesite,g_mrdb2_d[g_detail_idx2].mrde001,g_mrdb2_d[g_detail_idx2].mrde004, 
                  g_mrdb2_d[g_detail_idx2].mrde002,g_mrdb2_d[g_detail_idx2].mrde003,g_mrdb2_d[g_detail_idx2].mrde005)  
 
         WHERE mrdeent = g_enterprise AND mrdedocno = ps_keys_bak[1] AND mrdeseq = ps_keys_bak[2] AND mrdeseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrde_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrde_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrt100_mrde_t_mask_restore('restore_mask_n')
               
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
 
{<section id="amrt100.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION amrt100_key_update_b(ps_keys_bak,ps_table)
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
   IF ps_table = 'mrdb_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update2"
      
      #end add-point
      
      UPDATE mrde_t 
         SET (mrdedocno,mrdeseq) 
              = 
             (g_mrda_m.mrdadocno,g_mrdb_d[g_detail_idx].mrdbseq) 
         WHERE mrdeent = g_enterprise AND
               mrdedocno = ps_keys_bak[1] AND mrdeseq = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="key_update_b.m_update2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrde_t:",SQLERRMESSAGE 
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
 
{<section id="amrt100.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION amrt100_key_delete_b(ps_keys_bak,ps_table)
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
   IF ps_table = 'mrdb_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete2"
      
      #end add-point
      
      DELETE FROM mrde_t 
            WHERE mrdeent = g_enterprise AND
                  mrdedocno = ps_keys_bak[1] AND mrdeseq = ps_keys_bak[2]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrde_t:",SQLERRMESSAGE 
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
 
{<section id="amrt100.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amrt100_lock_b(ps_table,ps_page)
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
   #CALL amrt100_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mrdb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN amrt100_bcl USING g_enterprise,
                                       g_mrda_m.mrdadocno,g_mrdb_d[g_detail_idx].mrdbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrt100_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "mrde_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN amrt100_bcl2 USING g_enterprise,
                                             g_mrda_m.mrdadocno,g_mrdb_d[g_detail_idx].mrdbseq,
                                             g_mrdb2_d[g_detail_idx2].mrdeseq1
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrt100_bcl2:",SQLERRMESSAGE 
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
 
{<section id="amrt100.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amrt100_unlock_b(ps_table,ps_page)
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
      CLOSE amrt100_bcl
   END IF
   
 
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE amrt100_bcl2
   END IF
 
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="amrt100.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION amrt100_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mrdadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mrdadocno",TRUE)
      CALL cl_set_comp_entry("mrdadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("mrdadocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("mrda001,mrda002,mrda003,mrda004,mrda005,mrda008,mrda010,mrda011",TRUE)   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt100.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION amrt100_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mrdadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("mrdadocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mrdadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mrdadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_mrda_m.mrdastus = '1' THEN  #校驗中
      CALL cl_set_comp_entry("mrda001,mrda002,mrda003,mrda004,mrda005,mrda008,mrda010,mrda011",FALSE)
   END IF
   CALL cl_set_comp_entry("mrda012",FALSE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt100.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amrt100_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("mrdb004,mrdb006,mrdb007,mrdb012,mrdb015,mrdb016",TRUE)
   CALL cl_set_comp_entry("mrdbseq,mrdb001,mrdb002,mrdb003,mrdb005,mrdb014",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="amrt100.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amrt100_set_no_entry_b(p_cmd)
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
   
   CASE g_mrda_m.mrdastus   
   WHEN 'N' #未確認
      CALL cl_set_comp_entry("mrdb004,mrdb006,mrdb007,mrdb012,mrdb015,mrdb016",FALSE)
   WHEN '1' #校驗中
      IF p_cmd = 'u' THEN
         CALL cl_set_comp_entry("mrdbseq,mrdb001,mrdb002,mrdb003,mrdb005,mrdb014",FALSE)
      END IF
   END CASE
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="amrt100.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION amrt100_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   CALL cl_set_act_visible("amrt100_batch_produce",TRUE)
   CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
   CALL cl_set_act_visible("generate_amrt300",TRUE)
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt100.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION amrt100_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"

   CALL cl_set_act_visible("amrt100_batch_produce",FALSE)   #待SA規格完成繼續
   
   CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
   
   CASE g_mrda_m.mrdastus
      WHEN 'N' #未確認
         CALL cl_set_act_visible("generate_amrt300",FALSE)
      WHEN '1' #保校中
         CALL cl_set_act_visible("delete,generate_amrt300",FALSE)
      WHEN '2' #已完校
         CALL cl_set_act_visible("modify,delete,modify_detail,generate_amrt300",FALSE)
      WHEN '3' #轉維修
         CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
      WHEN 'D' #抽單
         CALL cl_set_act_visible("generate_amrt300",FALSE)
      WHEN 'R' #已拒絕
         CALL cl_set_act_visible("generate_amrt300",FALSE)
      WHEN 'A' #已核准
         CALL cl_set_act_visible("modify,delete,modify_detail,generate_amrt300",FALSE)
      WHEN 'W' #送簽中
         CALL cl_set_act_visible("modify,delete,modify_detail,generate_amrt300",FALSE)  
   END CASE

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt100.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION amrt100_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt100.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION amrt100_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt100.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amrt100_default_search()
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
      LET ls_wc = ls_wc, " mrdadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "mrda_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mrdb_t" 
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
 
{<section id="amrt100.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION amrt100_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mrda_m.mrdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN amrt100_cl USING g_enterprise,g_mrda_m.mrdadocno
   IF STATUS THEN
      CLOSE amrt100_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt100_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE amrt100_master_referesh USING g_mrda_m.mrdadocno INTO g_mrda_m.mrdasite,g_mrda_m.mrdadocno, 
       g_mrda_m.mrdadocdt,g_mrda_m.mrda001,g_mrda_m.mrda002,g_mrda_m.mrda012,g_mrda_m.mrdastus,g_mrda_m.mrda003, 
       g_mrda_m.mrda004,g_mrda_m.mrda005,g_mrda_m.mrda006,g_mrda_m.mrda007,g_mrda_m.mrda008,g_mrda_m.mrda009, 
       g_mrda_m.mrda010,g_mrda_m.mrda011,g_mrda_m.mrdaownid,g_mrda_m.mrdaowndp,g_mrda_m.mrdacrtid,g_mrda_m.mrdacrtdp, 
       g_mrda_m.mrdacrtdt,g_mrda_m.mrdamodid,g_mrda_m.mrdamoddt,g_mrda_m.mrdacnfid,g_mrda_m.mrdacnfdt, 
       g_mrda_m.mrda001_desc,g_mrda_m.mrda002_desc,g_mrda_m.mrda004_desc,g_mrda_m.mrda005_desc,g_mrda_m.mrda006_desc, 
       g_mrda_m.mrda007_desc,g_mrda_m.mrdaownid_desc,g_mrda_m.mrdaowndp_desc,g_mrda_m.mrdacrtid_desc, 
       g_mrda_m.mrdacrtdp_desc,g_mrda_m.mrdamodid_desc,g_mrda_m.mrdacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT amrt100_action_chk() THEN
      CLOSE amrt100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrda_m.mrdasite,g_mrda_m.mrdadocno,g_mrda_m.mrdadocno_desc,g_mrda_m.mrdadocdt,g_mrda_m.mrda001, 
       g_mrda_m.mrda001_desc,g_mrda_m.mrda002,g_mrda_m.mrda002_desc,g_mrda_m.mrda012,g_mrda_m.mrdastus, 
       g_mrda_m.mrda003,g_mrda_m.mrda003_desc,g_mrda_m.mrda004,g_mrda_m.mrda004_desc,g_mrda_m.mrda005, 
       g_mrda_m.mrda005_desc,g_mrda_m.mrda006,g_mrda_m.mrda006_desc,g_mrda_m.mrda007,g_mrda_m.mrda007_desc, 
       g_mrda_m.mrda008,g_mrda_m.mrda009,g_mrda_m.mrda010,g_mrda_m.mrda011,g_mrda_m.mrdaownid,g_mrda_m.mrdaownid_desc, 
       g_mrda_m.mrdaowndp,g_mrda_m.mrdaowndp_desc,g_mrda_m.mrdacrtid,g_mrda_m.mrdacrtid_desc,g_mrda_m.mrdacrtdp, 
       g_mrda_m.mrdacrtdp_desc,g_mrda_m.mrdacrtdt,g_mrda_m.mrdamodid,g_mrda_m.mrdamodid_desc,g_mrda_m.mrdamoddt, 
       g_mrda_m.mrdacnfid,g_mrda_m.mrdacnfid_desc,g_mrda_m.mrdacnfdt
 
   CASE g_mrda_m.mrdastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "1"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/checked.png")
      WHEN "2"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/completed.png")
      WHEN "3"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/wait_fix.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_mrda_m.mrdastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "1"
               HIDE OPTION "checked"
            WHEN "2"
               HIDE OPTION "completed"
            WHEN "3"
               HIDE OPTION "wait_fix"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
         #提交和抽單一開始先無條件關
         CALL cl_set_act_visible("signing,withdraw",FALSE)
         
         CASE g_mrda_m.mrdastus
            WHEN "N"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "completed"
               HIDE OPTION "wait_fix"
               #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
               IF cl_bpm_chk() THEN
                  CALL cl_set_act_visible("signing",TRUE)
                  CALL cl_set_act_visible("checked",FALSE)
               END IF
            WHEN "1"
               HIDE OPTION "checked"
               #此單據不做取消確認功能
               HIDE OPTION "unconfirmed"
            WHEN "2"
               HIDE OPTION "completed"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "wait_fix"
               #已完校後不顯示任何功能
               HIDE OPTION "checked"
               CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
               RETURN         
            WHEN "3"
               HIDE OPTION "wait_fix"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "completed"     
               #轉維修後不顯示任何功能
               HIDE OPTION "checked"
               CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
               RETURN  
            #已核准只能顯示保校中;其餘應用功能皆隱藏
            WHEN "A"     
               CALL cl_set_act_visible("checked ",TRUE)  
               CALL cl_set_act_visible("unconfirmed,completed,wait_fix",FALSE)         
            #隱藏全部應用功能，直到修改後變成'N'
            WHEN "R"   
               CALL cl_set_act_visible("unconfirmed,checked,completed,wait_fix",FALSE)
            WHEN "D"  
               CALL cl_set_act_visible("unconfirmed,checked,completed,wait_fix",FALSE)
            #送簽中只能顯示抽單;其餘應用功能皆隱藏
            WHEN "W"   
               CALL cl_set_act_visible("withdraw",TRUE)  
               CALL cl_set_act_visible("unconfirmed,checked,completed,wait_fix",FALSE)
                                 
         END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT amrt100_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE amrt100_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT amrt100_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE amrt100_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION checked
         IF cl_auth_chk_act("checked") THEN
            LET lc_state = "1"
            #add-point:action控制 name="statechange.checked"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION completed
         IF cl_auth_chk_act("completed") THEN
            LET lc_state = "2"
            #add-point:action控制 name="statechange.completed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION wait_fix
         IF cl_auth_chk_act("wait_fix") THEN
            LET lc_state = "3"
            #add-point:action控制 name="statechange.wait_fix"
            
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
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "1"
      AND lc_state <> "2"
      AND lc_state <> "3"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      ) OR 
      g_mrda_m.mrdastus = lc_state OR cl_null(lc_state) THEN
      CLOSE amrt100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   #取消確認
   IF lc_state = 'N' THEN      
      CALL s_amrt100_unconf_upd(g_mrda_m.mrdadocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         CALL s_transaction_end('Y','0')
      END IF
   END IF

   #轉校驗
   IF lc_state = '1' THEN
      CALL s_amrt100_checked_chk(g_mrda_m.mrdadocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN
      ELSE
         CALL s_amrt100_checked_upd(g_mrda_m.mrdadocno) RETURNING l_success
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_transaction_end('Y','0')
         END IF
      END IF
   END IF
   
   #已完校
   IF lc_state = '2' THEN
      CALL s_amrt100_completed_upd(g_mrda_m.mrdadocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         CALL s_transaction_end('Y','0')
      END IF
   END IF   

   #轉維修
   IF lc_state = '3' THEN
      CALL s_amrt100_wait_fix_chk(g_mrda_m.mrdadocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF cl_ask_confirm('amr-00108') THEN   #是否自動生成維修工單？
            CALL s_transaction_begin()
            IF NOT amrt100_wait_fix_input() THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
         CALL s_amrt100_wait_fix_upd(g_mrda_m.mrdadocno,g_mrda_m.mrda012) RETURNING l_success
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_transaction_end('Y','0')
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_mrda_m.mrdamodid = g_user
   LET g_mrda_m.mrdamoddt = cl_get_current()
   LET g_mrda_m.mrdastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mrda_t 
      SET (mrdastus,mrdamodid,mrdamoddt) 
        = (g_mrda_m.mrdastus,g_mrda_m.mrdamodid,g_mrda_m.mrdamoddt)     
    WHERE mrdaent = g_enterprise AND mrdadocno = g_mrda_m.mrdadocno
 
    
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
         WHEN "1"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/checked.png")
         WHEN "2"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/completed.png")
         WHEN "3"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/wait_fix.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE amrt100_master_referesh USING g_mrda_m.mrdadocno INTO g_mrda_m.mrdasite,g_mrda_m.mrdadocno, 
          g_mrda_m.mrdadocdt,g_mrda_m.mrda001,g_mrda_m.mrda002,g_mrda_m.mrda012,g_mrda_m.mrdastus,g_mrda_m.mrda003, 
          g_mrda_m.mrda004,g_mrda_m.mrda005,g_mrda_m.mrda006,g_mrda_m.mrda007,g_mrda_m.mrda008,g_mrda_m.mrda009, 
          g_mrda_m.mrda010,g_mrda_m.mrda011,g_mrda_m.mrdaownid,g_mrda_m.mrdaowndp,g_mrda_m.mrdacrtid, 
          g_mrda_m.mrdacrtdp,g_mrda_m.mrdacrtdt,g_mrda_m.mrdamodid,g_mrda_m.mrdamoddt,g_mrda_m.mrdacnfid, 
          g_mrda_m.mrdacnfdt,g_mrda_m.mrda001_desc,g_mrda_m.mrda002_desc,g_mrda_m.mrda004_desc,g_mrda_m.mrda005_desc, 
          g_mrda_m.mrda006_desc,g_mrda_m.mrda007_desc,g_mrda_m.mrdaownid_desc,g_mrda_m.mrdaowndp_desc, 
          g_mrda_m.mrdacrtid_desc,g_mrda_m.mrdacrtdp_desc,g_mrda_m.mrdamodid_desc,g_mrda_m.mrdacnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mrda_m.mrdasite,g_mrda_m.mrdadocno,g_mrda_m.mrdadocno_desc,g_mrda_m.mrdadocdt, 
          g_mrda_m.mrda001,g_mrda_m.mrda001_desc,g_mrda_m.mrda002,g_mrda_m.mrda002_desc,g_mrda_m.mrda012, 
          g_mrda_m.mrdastus,g_mrda_m.mrda003,g_mrda_m.mrda003_desc,g_mrda_m.mrda004,g_mrda_m.mrda004_desc, 
          g_mrda_m.mrda005,g_mrda_m.mrda005_desc,g_mrda_m.mrda006,g_mrda_m.mrda006_desc,g_mrda_m.mrda007, 
          g_mrda_m.mrda007_desc,g_mrda_m.mrda008,g_mrda_m.mrda009,g_mrda_m.mrda010,g_mrda_m.mrda011, 
          g_mrda_m.mrdaownid,g_mrda_m.mrdaownid_desc,g_mrda_m.mrdaowndp,g_mrda_m.mrdaowndp_desc,g_mrda_m.mrdacrtid, 
          g_mrda_m.mrdacrtid_desc,g_mrda_m.mrdacrtdp,g_mrda_m.mrdacrtdp_desc,g_mrda_m.mrdacrtdt,g_mrda_m.mrdamodid, 
          g_mrda_m.mrdamodid_desc,g_mrda_m.mrdamoddt,g_mrda_m.mrdacnfid,g_mrda_m.mrdacnfid_desc,g_mrda_m.mrdacnfdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE amrt100_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amrt100_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt100.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION amrt100_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mrdb_d.getLength() THEN
         LET g_detail_idx = g_mrdb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mrdb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mrdb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_mrdb2_d.getLength() THEN
         LET g_detail_idx2 = g_mrdb2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_mrdb2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_mrdb2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amrt100.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION amrt100_b_fill2(pi_idx)
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
   
   IF amrt100_fill_chk(2) THEN
      IF (pi_idx = 2 OR pi_idx = 0 ) AND g_mrdb_d.getLength() > 0 THEN
               CALL g_mrdb2_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT mrdesite,mrdeseq1,mrde001,mrde004,mrde002,mrde003,mrde005 ,t4.oocal003 FROM mrde_t", 
                 
                     "",
                                    " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=mrde003 AND t4.oocal002='"||g_dlang||"' ",
 
                     " WHERE mrdeent=? AND mrdedocno=? AND mrdeseq=?"
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  mrde_t.mrdeseq1" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill2"
         
         #end add-point
         
         #先清空資料
               CALL g_mrdb2_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrt100_pb2 FROM g_sql
         DECLARE b_fill_curs2 CURSOR FOR amrt100_pb2
         
      #  OPEN b_fill_curs2 USING g_enterprise,g_mrda_m.mrdadocno,g_mrdb_d[g_detail_idx].mrdbseq   #(ver:78) 
 
         LET l_ac = 1
         FOREACH b_fill_curs2 USING g_enterprise,g_mrda_m.mrdadocno,g_mrdb_d[g_detail_idx].mrdbseq INTO g_mrdb2_d[l_ac].mrdesite, 
             g_mrdb2_d[l_ac].mrdeseq1,g_mrdb2_d[l_ac].mrde001,g_mrdb2_d[l_ac].mrde004,g_mrdb2_d[l_ac].mrde002, 
             g_mrdb2_d[l_ac].mrde003,g_mrdb2_d[l_ac].mrde005,g_mrdb2_d[l_ac].mrde003_desc   #(ver:78) 
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill2"
            CALL s_desc_get_item_desc(g_mrdb2_d[l_ac].mrde001)
            RETURNING g_mrdb2_d[l_ac].mrde001_desc,g_mrdb2_d[l_ac].mrde001_desc1
            
            CALL s_desc_get_unit_desc(g_mrdb2_d[l_ac].mrde003)
            RETURNING g_mrdb2_d[l_ac].mrde003_desc

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
               CALL g_mrdb2_d.deleteElement(g_mrdb2_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_mrdb2_d_mask_o.* =  g_mrdb2_d.*
   FOR l_ac = 1 TO g_mrdb2_d.getLength()
      LET g_mrdb2_d_mask_o[l_ac].* =  g_mrdb2_d[l_ac].*
      CALL amrt100_mrde_t_mask()
      LET g_mrdb2_d_mask_n[l_ac].* =  g_mrdb2_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL amrt100_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="amrt100.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION amrt100_fill_chk(ps_idx)
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
 
{<section id="amrt100.status_show" >}
PRIVATE FUNCTION amrt100_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amrt100.mask_functions" >}
&include "erp/amr/amrt100_mask.4gl"
 
{</section>}
 
{<section id="amrt100.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION amrt100_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL amrt100_show()
   CALL amrt100_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #確認前檢核段
   IF NOT s_amrt100_checked_chk(g_mrda_m.mrdadocno) THEN
      CLOSE amrt100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_mrda_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_mrdb_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_mrdb2_d))
 
 
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
   #CALL amrt100_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL amrt100_ui_headershow()
   CALL amrt100_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION amrt100_draw_out()
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
   CALL amrt100_ui_headershow()  
   CALL amrt100_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="amrt100.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amrt100_set_pk_array()
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
   LET g_pk_array[1].values = g_mrda_m.mrdadocno
   LET g_pk_array[1].column = 'mrdadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt100.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="amrt100.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION amrt100_msgcentre_notify(lc_state)
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
   CALL amrt100_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mrda_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt100.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION amrt100_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#23 add-S
   SELECT mrdastus  INTO g_mrda_m.mrdastus
     FROM mrda_t
    WHERE mrdaent = g_enterprise
      AND mrdadocno = g_mrda_m.mrdadocno

   IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mrda_m.mrdastus
        WHEN '1'
           LET g_errno = 'sub-01352'
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN '2'
           LET g_errno = 'amr-00067'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN '3'
           LET g_errno = 'amr-00068'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_mrda_m.mrdadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL amrt100_set_act_visible()
        CALL amrt100_set_act_no_visible()
        CALL amrt100_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#23 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrt100.other_function" readonly="Y" >}

PRIVATE FUNCTION amrt100_mrda001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrda_m.mrda001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_mrda_m.mrda001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrda_m.mrda001_desc
END FUNCTION

PRIVATE FUNCTION amrt100_mrda003_ref(p_mrda003)
   DEFINE p_mrda003       LIKE mrda_t.mrda003
   DEFINE r_mrda003_desc  LIKE type_t.chr80
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrda003
   CALL ap_ref_array2(g_ref_fields,"SELECT mrba004 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mrbasite='"||g_site||"' AND mrba001=?","") RETURNING g_rtn_fields
   LET r_mrda003_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_mrda003_desc
END FUNCTION

PRIVATE FUNCTION amrt100_mrda002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrda_m.mrda002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrda_m.mrda002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrda_m.mrda002_desc
END FUNCTION

PRIVATE FUNCTION amrt100_mrda004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrda_m.mrda004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1104' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrda_m.mrda004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrda_m.mrda004_desc
END FUNCTION

PRIVATE FUNCTION amrt100_mrda005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrda_m.mrda005
   CALL ap_ref_array2(g_ref_fields,"SELECT mraal003 FROM mraal_t WHERE mraalent='"||g_enterprise||"' AND mraal001=? AND mraal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrda_m.mrda005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrda_m.mrda005_desc
END FUNCTION

PRIVATE FUNCTION amrt100_mrda006_ref(p_mrda006)
   DEFINE p_mrda006       LIKE mrda_t.mrda006
   DEFINE r_mrda006_desc  LIKE type_t.chr80
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrda006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_mrda006_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_mrda006_desc
END FUNCTION

PRIVATE FUNCTION amrt100_mrda007_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrda_m.mrda007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1102' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrda_m.mrda007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrda_m.mrda007_desc
END FUNCTION

PRIVATE FUNCTION amrt100_mrda009_default()
   LET g_mrda_m.mrda009 = ''
   
   SELECT MAX(mrdadocdt) INTO g_mrda_m.mrda009
     FROM mrda_t
    WHERE mrdaent = g_enterprise
      AND mrdasite = g_site
      AND mrda003 = g_mrda_m.mrda003
      AND mrda004 = g_mrda_m.mrda004
      
   DISPLAY BY NAME g_mrda_m.mrda009
END FUNCTION

PRIVATE FUNCTION amrt100_set_required(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1

   IF NOT cl_null(g_mrda_m.mrda010) THEN
      CALL cl_set_comp_required("mrda011",TRUE)
   END IF

   IF NOT cl_null(g_mrda_m.mrda011) THEN
      CALL cl_set_comp_required("mrda010",TRUE)
   END IF
   
END FUNCTION

PRIVATE FUNCTION amrt100_set_no_required(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   
   CALL cl_set_comp_required("mrda010,mrda011",FALSE)
END FUNCTION

PRIVATE FUNCTION amrt100_mrdb001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrdb_d[l_ac].mrdb001
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1110' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrdb_d[l_ac].mrdb001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrdb_d[l_ac].mrdb001_desc
END FUNCTION

PRIVATE FUNCTION amrt100_mrdb002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrdb_d[l_ac].mrdb002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1114' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrdb_d[l_ac].mrdb002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrdb_d[l_ac].mrdb002_desc
END FUNCTION

PRIVATE FUNCTION amrt100_set_required_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   
   IF NOT cl_null(g_mrdb_d[l_ac].mrdb015) THEN
      CALL cl_set_comp_required("mrdb016",TRUE)
   END IF
   
   IF NOT cl_null(g_mrdb_d[l_ac].mrdb016) THEN
      CALL cl_set_comp_required("mrdb015",TRUE)
   END IF
   
   IF NOT cl_null(g_mrdb_d[l_ac].mrdb005) THEN
      CALL cl_set_comp_required("mrdb006",TRUE)
   END IF
   
END FUNCTION

PRIVATE FUNCTION amrt100_set_no_required_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   
   CALL cl_set_comp_required("mrdb015,mrdb016,mrdb005,mrdb006",FALSE)
END FUNCTION

PRIVATE FUNCTION amrt100_mrdb012_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrdb_d[l_ac].mrdb012
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1106' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrdb_d[l_ac].mrdb012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrdb_d[l_ac].mrdb012_desc
END FUNCTION

PRIVATE FUNCTION amrt100_mrda006_mrda007_default()
   LET g_mrda_m.mrda006 = ''
   LET g_mrda_m.mrda007 = ''

   SELECT mrba010,mrba011
     INTO g_mrda_m.mrda006,g_mrda_m.mrda007
     FROM mrba_t
    WHERE mrbaent = g_enterprise
      AND mrbasite = g_site
      AND mrba001 = g_mrda_m.mrda003
          
   CALL amrt100_mrda006_ref(g_mrda_m.mrda006) RETURNING g_mrda_m.mrda006_desc
   DISPLAY BY NAME g_mrda_m.mrda006_desc
   
   CALL amrt100_mrda007_ref()
END FUNCTION

PRIVATE FUNCTION amrt100_mrdb005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrda_m.mrda003
   LET g_ref_fields[2] = g_mrdb_d[l_ac].mrdb005
   CALL ap_ref_array2(g_ref_fields,"SELECT mrbc003 FROM mrbc_t WHERE mrbcent='"||g_enterprise||"' AND mrbcsite='"||g_site||"' AND mrbc001=? AND mrbc002=?","") RETURNING g_rtn_fields
   LET g_mrdb_d[l_ac].mrdb005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrdb_d[l_ac].mrdb005_desc
END FUNCTION

PRIVATE FUNCTION amrt100_mrde001_mrde003_chk()
   DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF NOT cl_null(g_mrdb2_d[l_ac].mrde001) AND
      NOT cl_null(g_mrdb2_d[l_ac].mrde003) THEN
      
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
               
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_mrdb2_d[l_ac].mrde001
      LET g_chkparam.arg2 = g_mrdb2_d[l_ac].mrde003
                  
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_imao002") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF 
   END IF
   
   RETURN r_success              
   
END FUNCTION

################################################################################
# Descriptions...: 由amri100產生單身
# Memo...........:
# Usage..........: CALL amrt100_detail_default()
#                  
# Input parameter: 
#                : 
# Return code....: r_success   執行結果
#                : 
# Date & Author..: 140507 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION amrt100_detail_default()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_num         LIKE type_t.num5
   DEFINE l_mrdb     RECORD
             mrdbseq    LIKE mrdb_t.mrdbseq,
             mrdb001    LIKE mrdb_t.mrdb001,
             mrdb002    LIKE mrdb_t.mrdb002,
             mrdb003    LIKE mrdb_t.mrdb003,
             mrdb004    LIKE mrdb_t.mrdb004,
             mrdb005    LIKE mrdb_t.mrdb005,
             mrdb014    LIKE mrdb_t.mrdb014,
             mrdb015    LIKE mrdb_t.mrdb015,             
             mrdb016    LIKE mrdb_t.mrdb016
                     END RECORD
   DEFINE l_mrde     RECORD
             mrdeseq1   LIKE mrde_t.mrdeseq1,
             mrde001    LIKE mrde_t.mrde001,
             mrde002    LIKE mrde_t.mrde002,
             mrde003    LIKE mrde_t.mrde003,
             mrde004    LIKE mrde_t.mrde004,
             mrde005    LIKE mrde_t.mrde005
                     END RECORD
   
   LET r_success = TRUE
   
   LET g_sql = "SELECT mrajseq,mraj004,mraj005,mraj006,mraj007,mraj009,mraj012,mraj013",
               "  FROM mraj_t",
               " WHERE mrajent = '",g_enterprise,"'",
               "   AND mrajsite = '",g_site,"'",
               "   AND mraj001 = ?",
               "   AND mraj002 = ?",
               "   AND mraj003 = ?"
   PREPARE amrt100_detail_pre1 FROM g_sql
   DECLARE amrt100_detail_cur1 CURSOR FOR amrt100_detail_pre1
      
   LET g_sql = "SELECT mrakseq1,mrak004,mrak005,mrak006,mrak007,mrak008",
               "  FROM mrak_t",
               " WHERE mrakent = '",g_enterprise,"'",
               "   AND mraksite = '",g_site,"'",
               "   AND mrak001 = ?",
               "   AND mrak002 = ?",
               "   AND mrak003 = ?",
               "   AND mrakseq = ?"
   PREPARE amrt100_detail_pre2 FROM g_sql
   DECLARE amrt100_detail_cur2 CURSOR FOR amrt100_detail_pre2
      
   LET l_num = 0
   
   #依單頭"資源編號"+"保修類型"於amri100所設定之保修項目,產生單身資料
   INITIALIZE l_mrdb.* TO NULL
   OPEN amrt100_detail_cur1 USING g_mrda_m.mrda006,g_mrda_m.mrda003,g_mrda_m.mrda004   
   FOREACH amrt100_detail_cur1 INTO l_mrdb.mrdbseq,l_mrdb.mrdb001,l_mrdb.mrdb002,l_mrdb.mrdb003,l_mrdb.mrdb005,l_mrdb.mrdb014,l_mrdb.mrdb015,l_mrdb.mrdb016
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF      
      
      INSERT INTO mrdb_t(mrdbent,mrdbsite,mrdbdocno,mrdbseq,
                         mrdb001,mrdb002,mrdb003,mrdb004,mrdb005,
                         mrdb014,mrdb015,mrdb016)
      VALUES(g_enterprise,g_site,g_mrda_m.mrdadocno,l_mrdb.mrdbseq,
             l_mrdb.mrdb001,l_mrdb.mrdb002,l_mrdb.mrdb003,'N',l_mrdb.mrdb005,
             l_mrdb.mrdb014,l_mrdb.mrdb015,l_mrdb.mrdb016)
             
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mrdb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF       
      
      INITIALIZE l_mrde.* TO NULL
      OPEN amrt100_detail_cur2 USING g_mrda_m.mrda006,g_mrda_m.mrda003,g_mrda_m.mrda004,l_mrdb.mrdbseq
      FOREACH amrt100_detail_cur2 INTO l_mrde.mrdeseq1,l_mrde.mrde001,l_mrde.mrde002,l_mrde.mrde003,l_mrde.mrde005,l_mrde.mrde004
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF 

         INSERT INTO mrde_t(mrdeent,mrdesite,mrdedocno,mrdeseq,
                            mrdeseq1,mrde001,mrde002,mrde003,mrde004,mrde005)
         VALUES(g_enterprise,g_site,g_mrda_m.mrdadocno,l_mrdb.mrdbseq,
                l_mrde.mrdeseq1,l_mrde.mrde001,l_mrde.mrde002,l_mrde.mrde003,l_mrde.mrde004,l_mrde.mrde005)
                
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mrdb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF           
      END FOREACH
      
      IF r_success = FALSE THEN
         EXIT FOREACH
      END IF
      
      LET l_num  = l_num + 1   
   END FOREACH
   
   #若"資源編號"+"保修類型"未於amri100改以"資源分類"+"保修類型"於amri100所設定之保修項目,產生單身資料
   IF l_num = 0 AND r_success = TRUE THEN
      INITIALIZE l_mrdb.* TO NULL
      OPEN amrt100_detail_cur1 USING g_mrda_m.mrda006,'ALL',g_mrda_m.mrda004
      FOREACH amrt100_detail_cur1 INTO l_mrdb.mrdbseq,l_mrdb.mrdb001,l_mrdb.mrdb002,l_mrdb.mrdb003,l_mrdb.mrdb005,l_mrdb.mrdb014,l_mrdb.mrdb015,l_mrdb.mrdb016
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF      
      
         INSERT INTO mrdb_t(mrdbent,mrdbsite,mrdbdocno,mrdbseq,
                            mrdb001,mrdb002,mrdb003,mrdb004,mrdb005,
                            mrdb014,mrdb015,mrdb016)
         VALUES(g_enterprise,g_site,g_mrda_m.mrdadocno,l_mrdb.mrdbseq,
                l_mrdb.mrdb001,l_mrdb.mrdb002,l_mrdb.mrdb003,'N',l_mrdb.mrdb005,
                l_mrdb.mrdb014,l_mrdb.mrdb015,l_mrdb.mrdb016)
             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mrdb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF       
      
         INITIALIZE l_mrde.* TO NULL
         OPEN amrt100_detail_cur2 USING g_mrda_m.mrda006,'ALL',g_mrda_m.mrda004,l_mrdb.mrdbseq
         FOREACH amrt100_detail_cur2 INTO l_mrde.mrdeseq1,l_mrde.mrde001,l_mrde.mrde002,l_mrde.mrde003,l_mrde.mrde005,l_mrde.mrde004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

               LET r_success = FALSE
               EXIT FOREACH
            END IF 

            INSERT INTO mrde_t(mrdeent,mrdesite,mrdedocno,mrdeseq,
                               mrdeseq1,mrde001,mrde002,mrde003,mrde004,mrde005)
            VALUES(g_enterprise,g_site,g_mrda_m.mrdadocno,l_mrdb.mrdbseq,
                   l_mrde.mrdeseq1,l_mrde.mrde001,l_mrde.mrde002,l_mrde.mrde003,l_mrde.mrde004,l_mrde.mrde005)
                
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mrdb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

               LET r_success = FALSE
               EXIT FOREACH
            END IF           
         END FOREACH
      
         IF r_success = FALSE THEN
            EXIT FOREACH
         END IF
      
         LET l_num  = l_num + 1  
      END FOREACH         
   END IF
   
   CALL amrt100_b_fill()
   LET g_rec_b = g_mrdb_d.getLength()
   
   CLOSE amrt100_detail_cur1
   FREE amrt100_detail_pre1
   CLOSE amrt100_detail_cur2
   FREE amrt100_detail_pre2

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 轉維修前需先輸入維修工單單別
# Memo...........:
# Usage..........: CALL amrt100_wait_fix_input()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success   處理狀況(TRUE:成功 FALSE:失敗)
# Date & Author..: 15/06/28 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION amrt100_wait_fix_input()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_mrda012_t     LIKE mrda_t.mrda012
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_ooef004              LIKE ooef_t.ooef004
   
   LET r_success = TRUE
   LET l_mrda012_t = g_mrda_m.mrda012
   CALL cl_set_comp_entry("mrda012",TRUE)
   
   INPUT BY NAME g_mrda_m.mrda012 ATTRIBUTE(WITHOUT DEFAULTS)

      BEFORE INPUT
         CALL cl_set_comp_required("mrda012",TRUE)

      AFTER FIELD mrda012
         IF NOT cl_null(g_mrda_m.mrda012) THEN
            IF NOT s_aooi200_chk_slip(g_site,'',g_mrda_m.mrda012,'amrt300') THEN
               LET g_mrda_m.mrda012 = l_mrda012_t
               NEXT FIELD CURRENT
            END IF
            LET l_mrda012_t = g_mrda_m.mrda012
         END IF

      ON ACTION controlp INFIELD mrda012
         #add-point:ON ACTION controlp INFIELD mrda012
         #應用 a07 樣板自動產生(Version:2)   
         #開窗i段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_mrda_m.mrda012  #給予default值
         #給予arg
         CALL s_aooi100_sel_ooef004(g_site)
              RETURNING l_success,l_ooef004
         LET g_qryparam.arg1 = l_ooef004
         LET g_qryparam.arg2 = 'amrt300'
         CALL q_ooba002_1()                          #呼叫開窗
         LET g_mrda_m.mrda012 = g_qryparam.return1
         DISPLAY g_mrda_m.mrda012 TO mrda012
         NEXT FIELD mrda012                          #返回原欄位
         
     AFTER INPUT
         IF INT_FLAG THEN
            EXIT INPUT
         END IF

         ON ACTION accept
            ACCEPT INPUT

         ON ACTION cancel
            LET INT_FLAG = TRUE
            EXIT INPUT

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT INPUT

         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT INPUT

   END INPUT

   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      LET r_success = FALSE
      RETURN r_success
   END IF

   #回寫資源維修單號
   UPDATE mrda_t
      SET mrda012 = g_mrda_m.mrda012
    WHERE mrdaent = g_enterprise
      AND mrdadocno = g_mrda_m.mrdadocno

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success

END FUNCTION

 
{</section>}
 
