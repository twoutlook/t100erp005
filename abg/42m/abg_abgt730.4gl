#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt730.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-12-26 15:57:23), PR版次:0001(2016-12-29 17:00:04)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgt730
#+ Description: 人工預算
#+ Creator....: 04152(2016-12-08 19:16:02)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="abgt730.global" >}
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
PRIVATE type type_g_bggm_m        RECORD
       bggm002 LIKE bggm_t.bggm002, 
   bggm002_desc LIKE type_t.chr80, 
   bggm003 LIKE bggm_t.bggm003, 
   bggm008 LIKE bggm_t.bggm008, 
   bggm008_desc LIKE type_t.chr80, 
   bggm001 LIKE bggm_t.bggm001, 
   bggm005 LIKE bggm_t.bggm005, 
   bgaa002 LIKE type_t.chr10, 
   bgaa003 LIKE type_t.chr10, 
   bggm009 LIKE bggm_t.bggm009, 
   bggm004 LIKE bggm_t.bggm004, 
   bggm006 LIKE bggm_t.bggm006, 
   bggm006_desc LIKE type_t.chr80, 
   bggm007 LIKE bggm_t.bggm007, 
   bggmstus LIKE bggm_t.bggmstus, 
   bggmownid LIKE bggm_t.bggmownid, 
   bggmownid_desc LIKE type_t.chr80, 
   bggmowndp LIKE bggm_t.bggmowndp, 
   bggmowndp_desc LIKE type_t.chr80, 
   bggmcrtid LIKE bggm_t.bggmcrtid, 
   bggmcrtid_desc LIKE type_t.chr80, 
   bggmcrtdp LIKE bggm_t.bggmcrtdp, 
   bggmcrtdp_desc LIKE type_t.chr80, 
   bggmcrtdt LIKE bggm_t.bggmcrtdt, 
   bggmmodid LIKE bggm_t.bggmmodid, 
   bggmmodid_desc LIKE type_t.chr80, 
   bggmmoddt LIKE bggm_t.bggmmoddt, 
   bggmcnfid LIKE bggm_t.bggmcnfid, 
   bggmcnfid_desc LIKE type_t.chr80, 
   bggmcnfdt LIKE bggm_t.bggmcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bggn_d        RECORD
       bggnseq LIKE bggn_t.bggnseq, 
   bggn010 LIKE bggn_t.bggn010, 
   bggn010_desc LIKE type_t.chr500, 
   bggn011 LIKE bggn_t.bggn011, 
   bggn011_desc LIKE type_t.chr500, 
   bggn012 LIKE bggn_t.bggn012, 
   bggn012_desc LIKE type_t.chr500, 
   bggn013 LIKE bggn_t.bggn013, 
   bggn013_desc LIKE type_t.chr500, 
   bggn014 LIKE bggn_t.bggn014, 
   bggn014_desc LIKE type_t.chr500, 
   bggn015 LIKE bggn_t.bggn015, 
   bggn015_desc LIKE type_t.chr500, 
   bggn016 LIKE bggn_t.bggn016, 
   bggn016_desc LIKE type_t.chr500, 
   bggn017 LIKE bggn_t.bggn017, 
   bggn017_desc LIKE type_t.chr500, 
   bggn018 LIKE bggn_t.bggn018, 
   bggn018_desc LIKE type_t.chr500, 
   bggn019 LIKE bggn_t.bggn019, 
   bggn019_desc LIKE type_t.chr500, 
   bggn020 LIKE bggn_t.bggn020, 
   bggn020_desc LIKE type_t.chr500, 
   bggn021 LIKE bggn_t.bggn021, 
   bggn021_desc LIKE type_t.chr500, 
   bggn022 LIKE bggn_t.bggn022, 
   bggn022_desc LIKE type_t.chr500, 
   bggn023 LIKE bggn_t.bggn023, 
   bggn023_desc LIKE type_t.chr500, 
   bggn024 LIKE bggn_t.bggn024, 
   bggn024_desc LIKE type_t.chr500, 
   bggn025 LIKE bggn_t.bggn025, 
   bggn025_desc LIKE type_t.chr500, 
   bggn026 LIKE bggn_t.bggn026, 
   bggn026_desc LIKE type_t.chr500, 
   bggn037 LIKE bggn_t.bggn037, 
   bggn038 LIKE bggn_t.bggn038
       END RECORD
PRIVATE TYPE type_g_bggn2_d RECORD
       bggoseq2 LIKE bggo_t.bggoseq2, 
   bggo009 LIKE bggo_t.bggo009, 
   bggo009_desc LIKE type_t.chr500, 
   bggo100 LIKE bggo_t.bggo100, 
   bggo101 LIKE bggo_t.bggo101, 
   bggo036 LIKE bggo_t.bggo036, 
   bggo035 LIKE bggo_t.bggo035, 
   bggo103 LIKE bggo_t.bggo103, 
   bggo104 LIKE bggo_t.bggo104, 
   bggo106 LIKE bggo_t.bggo106, 
   bggo039 LIKE bggo_t.bggo039, 
   bggo039_desc LIKE type_t.chr500, 
   bggo040 LIKE bggo_t.bggo040, 
   bggo040_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_bggm001 LIKE bggm_t.bggm001,
      b_bggm002 LIKE bggm_t.bggm002,
      b_bggm003 LIKE bggm_t.bggm003,
      b_bggm004 LIKE bggm_t.bggm004,
      b_bggm005 LIKE bggm_t.bggm005,
      b_bggm006 LIKE bggm_t.bggm006,
      b_bggm007 LIKE bggm_t.bggm007
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ld              LIKE glaa_t.glaald
DEFINE g_comp            LIKE glaa_t.glaacomp
DEFINE g_ooaa002         LIKE ooaa_t.ooaa002
DEFINE g_max_period      LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_bggm_m          type_g_bggm_m
DEFINE g_bggm_m_t        type_g_bggm_m
DEFINE g_bggm_m_o        type_g_bggm_m
DEFINE g_bggm_m_mask_o   type_g_bggm_m #轉換遮罩前資料
DEFINE g_bggm_m_mask_n   type_g_bggm_m #轉換遮罩後資料
 
   DEFINE g_bggm002_t LIKE bggm_t.bggm002
DEFINE g_bggm003_t LIKE bggm_t.bggm003
DEFINE g_bggm001_t LIKE bggm_t.bggm001
DEFINE g_bggm005_t LIKE bggm_t.bggm005
DEFINE g_bggm004_t LIKE bggm_t.bggm004
DEFINE g_bggm006_t LIKE bggm_t.bggm006
DEFINE g_bggm007_t LIKE bggm_t.bggm007
 
 
DEFINE g_bggn_d          DYNAMIC ARRAY OF type_g_bggn_d
DEFINE g_bggn_d_t        type_g_bggn_d
DEFINE g_bggn_d_o        type_g_bggn_d
DEFINE g_bggn_d_mask_o   DYNAMIC ARRAY OF type_g_bggn_d #轉換遮罩前資料
DEFINE g_bggn_d_mask_n   DYNAMIC ARRAY OF type_g_bggn_d #轉換遮罩後資料
DEFINE g_bggn2_d          DYNAMIC ARRAY OF type_g_bggn2_d
DEFINE g_bggn2_d_t        type_g_bggn2_d
DEFINE g_bggn2_d_o        type_g_bggn2_d
DEFINE g_bggn2_d_mask_o   DYNAMIC ARRAY OF type_g_bggn2_d #轉換遮罩前資料
DEFINE g_bggn2_d_mask_n   DYNAMIC ARRAY OF type_g_bggn2_d #轉換遮罩後資料
 
 
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
 
{<section id="abgt730.main" >}
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
   CALL cl_ap_init("abg","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT bggm002,'',bggm003,bggm008,'',bggm001,bggm005,'','',bggm009,bggm004,bggm006, 
       '',bggm007,bggmstus,bggmownid,'',bggmowndp,'',bggmcrtid,'',bggmcrtdp,'',bggmcrtdt,bggmmodid,'', 
       bggmmoddt,bggmcnfid,'',bggmcnfdt", 
                      " FROM bggm_t",
                      " WHERE bggment= ? AND bggm001=? AND bggm002=? AND bggm003=? AND bggm004=? AND  
                          bggm005=? AND bggm006=? AND bggm007=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt730_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bggm002,t0.bggm003,t0.bggm008,t0.bggm001,t0.bggm005,t0.bggm009,t0.bggm004, 
       t0.bggm006,t0.bggm007,t0.bggmstus,t0.bggmownid,t0.bggmowndp,t0.bggmcrtid,t0.bggmcrtdp,t0.bggmcrtdt, 
       t0.bggmmodid,t0.bggmmoddt,t0.bggmcnfid,t0.bggmcnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 , 
       t5.ooag011 ,t6.ooag011",
               " FROM bggm_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.bggmownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.bggmowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.bggmcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.bggmcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.bggmmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.bggmcnfid  ",
 
               " WHERE t0.bggment = " ||g_enterprise|| " AND t0.bggm001 = ? AND t0.bggm002 = ? AND t0.bggm003 = ? AND t0.bggm004 = ? AND t0.bggm005 = ? AND t0.bggm006 = ? AND t0.bggm007 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgt730_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgt730 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgt730_init()   
 
      #進入選單 Menu (="N")
      CALL abgt730_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgt730
      
   END IF 
   
   CLOSE abgt730_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgt730.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgt730_init()
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
      CALL cl_set_combo_scc_part('bggmstus','13','N,Y,FC,A,D,R,W,X')
 
      CALL cl_set_combo_scc('bggm005','9989') 
   CALL cl_set_combo_scc('bggm004','8963') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #經營方式
   CALL cl_set_combo_scc('bggn024_desc','6013')
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING g_ooaa002
   #end add-point
   
   #初始化搜尋條件
   CALL abgt730_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abgt730.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abgt730_ui_dialog()
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
            CALL abgt730_insert()
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
         INITIALIZE g_bggm_m.* TO NULL
         CALL g_bggn_d.clear()
         CALL g_bggn2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abgt730_init()
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
               
               CALL abgt730_fetch('') # reload data
               LET l_ac = 1
               CALL abgt730_ui_detailshow() #Setting the current row 
         
               CALL abgt730_idx_chk()
               #NEXT FIELD bggnseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_bggn_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL abgt730_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               CALL abgt730_b_fill2('2')
 
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
               CALL abgt730_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
         #第二階單身段落
         DISPLAY ARRAY g_bggn2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL abgt730_idx_chk()
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
               CALL abgt730_idx_chk()
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
            CALL abgt730_browser_fill("")
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
               CALL abgt730_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abgt730_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL abgt730_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL abgt730_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL abgt730_set_act_visible()   
            CALL abgt730_set_act_no_visible()
            IF NOT (g_bggm_m.bggm001 IS NULL
              OR g_bggm_m.bggm002 IS NULL
              OR g_bggm_m.bggm003 IS NULL
              OR g_bggm_m.bggm004 IS NULL
              OR g_bggm_m.bggm005 IS NULL
              OR g_bggm_m.bggm006 IS NULL
              OR g_bggm_m.bggm007 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " bggment = " ||g_enterprise|| " AND",
                                  " bggm001 = '", g_bggm_m.bggm001, "' "
                                  ," AND bggm002 = '", g_bggm_m.bggm002, "' "
                                  ," AND bggm003 = '", g_bggm_m.bggm003, "' "
                                  ," AND bggm004 = '", g_bggm_m.bggm004, "' "
                                  ," AND bggm005 = '", g_bggm_m.bggm005, "' "
                                  ," AND bggm006 = '", g_bggm_m.bggm006, "' "
                                  ," AND bggm007 = '", g_bggm_m.bggm007, "' "
 
               #填到對應位置
               CALL abgt730_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "bggm_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bggn_t" 
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
               CALL abgt730_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "bggm_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bggn_t" 
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
                  CALL abgt730_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL abgt730_fetch("F")
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
               CALL abgt730_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abgt730_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt730_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abgt730_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt730_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abgt730_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt730_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abgt730_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt730_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abgt730_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt730_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_bggn_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_bggn2_d)
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
               NEXT FIELD bggnseq
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
               CALL abgt730_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abgt730_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abgt730_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgt730_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgt730_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abgt730_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgt730_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgt730_set_pk_array()
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
 
{<section id="abgt730.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abgt730_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT bggm001,bggm002,bggm003,bggm004,bggm005,bggm006,bggm007 ",
                      " FROM bggm_t ",
                      " ",
                      " LEFT JOIN bggn_t ON bggnent = bggment AND bggm001 = bggn001 AND bggm002 = bggn002 AND bggm003 = bggn003 AND bggm004 = bggn004 AND bggm005 = bggn005 AND bggm006 = bggn006 AND bggm007 = bggn007 ", "  ",
                      #add-point:browser_fill段sql(bggn_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
                      " LEFT JOIN bggo_t ON bggoent = bggment AND bggn001 = bggo001 AND bggn002 = bggo002 AND bggn003 = bggo003 AND bggn004 = bggo005 AND bggn005 = bggo006 AND bggn006 = bggo007 AND bggn007 = bggo008 AND bggnseq = bggoseq", "  ",
                      #add-point:browser_fill段sql(bggo_t1) name="browser_fill.cnt.join.bggo_t1"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
                      " ",
 
 
                      " WHERE bggment = " ||g_enterprise|| " AND bggnent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bggm_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bggm001,bggm002,bggm003,bggm004,bggm005,bggm006,bggm007 ",
                      " FROM bggm_t ", 
                      "  ",
                      "  ",
                      " WHERE bggment = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bggm_t")
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
      INITIALIZE g_bggm_m.* TO NULL
      CALL g_bggn_d.clear()        
      CALL g_bggn2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bggm001,t0.bggm002,t0.bggm003,t0.bggm004,t0.bggm005,t0.bggm006,t0.bggm007 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.bggmstus,t0.bggm001,t0.bggm002,t0.bggm003,t0.bggm004,t0.bggm005, 
          t0.bggm006,t0.bggm007 ",
                  " FROM bggm_t t0",
                  "  ",
                  "  LEFT JOIN bggn_t ON bggnent = bggment AND bggm001 = bggn001 AND bggm002 = bggn002 AND bggm003 = bggn003 AND bggm004 = bggn004 AND bggm005 = bggn005 AND bggm006 = bggn006 AND bggm007 = bggn007 ", "  ", 
                  #add-point:browser_fill段sql(bggn_t1) name="browser_fill.join.bggn_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN bggo_t ON bggoent = bggment AND bggn001 = bggo001 AND bggn002 = bggo002 AND bggn003 = bggo003 AND bggn004 = bggo005 AND bggn005 = bggo006 AND bggn006 = bggo007 AND bggn007 = bggo008 AND bggnseq = bggoseq", "  ", 
                  #add-point:browser_fill段sql(bggo_t1) name="browser_fill.join.bggo_t1"
                  
                  #end add-point
 
 
                  " ", 
 
                  " ",
 
 
                  
                  " WHERE t0.bggment = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("bggm_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.bggmstus,t0.bggm001,t0.bggm002,t0.bggm003,t0.bggm004,t0.bggm005, 
          t0.bggm006,t0.bggm007 ",
                  " FROM bggm_t t0",
                  "  ",
                  
                  " WHERE t0.bggment = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("bggm_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY bggm001,bggm002,bggm003,bggm004,bggm005,bggm006,bggm007 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"bggm_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_bggm001,g_browser[g_cnt].b_bggm002, 
          g_browser[g_cnt].b_bggm003,g_browser[g_cnt].b_bggm004,g_browser[g_cnt].b_bggm005,g_browser[g_cnt].b_bggm006, 
          g_browser[g_cnt].b_bggm007
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
         CALL abgt730_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "FC"
            LET g_browser[g_cnt].b_statepic = "stus/16/final_confirmed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_bggm001) THEN
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
 
{<section id="abgt730.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abgt730_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bggm_m.bggm001 = g_browser[g_current_idx].b_bggm001   
   LET g_bggm_m.bggm002 = g_browser[g_current_idx].b_bggm002   
   LET g_bggm_m.bggm003 = g_browser[g_current_idx].b_bggm003   
   LET g_bggm_m.bggm004 = g_browser[g_current_idx].b_bggm004   
   LET g_bggm_m.bggm005 = g_browser[g_current_idx].b_bggm005   
   LET g_bggm_m.bggm006 = g_browser[g_current_idx].b_bggm006   
   LET g_bggm_m.bggm007 = g_browser[g_current_idx].b_bggm007   
 
   EXECUTE abgt730_master_referesh USING g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004, 
       g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007 INTO g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm008, 
       g_bggm_m.bggm001,g_bggm_m.bggm005,g_bggm_m.bggm009,g_bggm_m.bggm004,g_bggm_m.bggm006,g_bggm_m.bggm007, 
       g_bggm_m.bggmstus,g_bggm_m.bggmownid,g_bggm_m.bggmowndp,g_bggm_m.bggmcrtid,g_bggm_m.bggmcrtdp, 
       g_bggm_m.bggmcrtdt,g_bggm_m.bggmmodid,g_bggm_m.bggmmoddt,g_bggm_m.bggmcnfid,g_bggm_m.bggmcnfdt, 
       g_bggm_m.bggmownid_desc,g_bggm_m.bggmowndp_desc,g_bggm_m.bggmcrtid_desc,g_bggm_m.bggmcrtdp_desc, 
       g_bggm_m.bggmmodid_desc,g_bggm_m.bggmcnfid_desc
   
   CALL abgt730_bggm_t_mask()
   CALL abgt730_show()
      
END FUNCTION
 
{</section>}
 
{<section id="abgt730.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abgt730_ui_detailshow()
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
 
{<section id="abgt730.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abgt730_ui_browser_refresh()
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
      IF g_browser[l_i].b_bggm001 = g_bggm_m.bggm001 
         AND g_browser[l_i].b_bggm002 = g_bggm_m.bggm002 
         AND g_browser[l_i].b_bggm003 = g_bggm_m.bggm003 
         AND g_browser[l_i].b_bggm004 = g_bggm_m.bggm004 
         AND g_browser[l_i].b_bggm005 = g_bggm_m.bggm005 
         AND g_browser[l_i].b_bggm006 = g_bggm_m.bggm006 
         AND g_browser[l_i].b_bggm007 = g_bggm_m.bggm007 
 
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
 
{<section id="abgt730.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgt730_construct()
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
   DEFINE l_ooef001_str        STRING
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_bggm_m.* TO NULL
   CALL g_bggn_d.clear()        
   CALL g_bggn2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON bggm002,bggm003,bggm008,bggm008_desc,bggm001,bggm005,bggm004,bggm006, 
          bggm007,bggmstus,bggmownid,bggmowndp,bggmcrtid,bggmcrtdp,bggmcrtdt,bggmmodid,bggmmoddt,bggmcnfid, 
          bggmcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bggmcrtdt>>----
         AFTER FIELD bggmcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bggmmoddt>>----
         AFTER FIELD bggmmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bggmcnfdt>>----
         AFTER FIELD bggmcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bggmpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm002
            #add-point:BEFORE FIELD bggm002 name="construct.b.bggm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm002
            
            #add-point:AFTER FIELD bggm002 name="construct.a.bggm002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm002
            #add-point:ON ACTION controlp INFIELD bggm002 name="construct.c.bggm002"
            #預算編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgaa001()
            DISPLAY g_qryparam.return1 TO bggm002
            NEXT FIELD bggm002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm003
            #add-point:BEFORE FIELD bggm003 name="construct.b.bggm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm003
            
            #add-point:AFTER FIELD bggm003 name="construct.a.bggm003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm003
            #add-point:ON ACTION controlp INFIELD bggm003 name="construct.c.bggm003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm008
            #add-point:BEFORE FIELD bggm008 name="construct.b.bggm008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm008
            
            #add-point:AFTER FIELD bggm008 name="construct.a.bggm008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggm008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm008
            #add-point:ON ACTION controlp INFIELD bggm008 name="construct.c.bggm008"
            #管理組織
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgaistus='Y' AND bgai003='",g_user,"' AND (bgai005='06' OR bgai005='00')"
            CALL q_bgai002()
            DISPLAY g_qryparam.return1 TO bggm008
            NEXT FIELD bggm008
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm008_desc
            #add-point:BEFORE FIELD bggm008_desc name="construct.b.bggm008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm008_desc
            
            #add-point:AFTER FIELD bggm008_desc name="construct.a.bggm008_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggm008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm008_desc
            #add-point:ON ACTION controlp INFIELD bggm008_desc name="construct.c.bggm008_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm001
            #add-point:BEFORE FIELD bggm001 name="construct.b.bggm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm001
            
            #add-point:AFTER FIELD bggm001 name="construct.a.bggm001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggm001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm001
            #add-point:ON ACTION controlp INFIELD bggm001 name="construct.c.bggm001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm005
            #add-point:BEFORE FIELD bggm005 name="construct.b.bggm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm005
            
            #add-point:AFTER FIELD bggm005 name="construct.a.bggm005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm005
            #add-point:ON ACTION controlp INFIELD bggm005 name="construct.c.bggm005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm004
            #add-point:BEFORE FIELD bggm004 name="construct.b.bggm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm004
            
            #add-point:AFTER FIELD bggm004 name="construct.a.bggm004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm004
            #add-point:ON ACTION controlp INFIELD bggm004 name="construct.c.bggm004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm006
            #add-point:BEFORE FIELD bggm006 name="construct.b.bggm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm006
            
            #add-point:AFTER FIELD bggm006 name="construct.a.bggm006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggm006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm006
            #add-point:ON ACTION controlp INFIELD bggm006 name="construct.c.bggm006"
            #預算組織
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef205 = 'Y'"
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site('','',g_user,'06') RETURNING l_ooef001_str
            CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_ooef001_str
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO bggm006
            NEXT FIELD bggm006
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm007
            #add-point:BEFORE FIELD bggm007 name="construct.b.bggm007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm007
            
            #add-point:AFTER FIELD bggm007 name="construct.a.bggm007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggm007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm007
            #add-point:ON ACTION controlp INFIELD bggm007 name="construct.c.bggm007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggmstus
            #add-point:BEFORE FIELD bggmstus name="construct.b.bggmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggmstus
            
            #add-point:AFTER FIELD bggmstus name="construct.a.bggmstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggmstus
            #add-point:ON ACTION controlp INFIELD bggmstus name="construct.c.bggmstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bggmownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggmownid
            #add-point:ON ACTION controlp INFIELD bggmownid name="construct.c.bggmownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggmownid  #顯示到畫面上
            NEXT FIELD bggmownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggmownid
            #add-point:BEFORE FIELD bggmownid name="construct.b.bggmownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggmownid
            
            #add-point:AFTER FIELD bggmownid name="construct.a.bggmownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggmowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggmowndp
            #add-point:ON ACTION controlp INFIELD bggmowndp name="construct.c.bggmowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggmowndp  #顯示到畫面上
            NEXT FIELD bggmowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggmowndp
            #add-point:BEFORE FIELD bggmowndp name="construct.b.bggmowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggmowndp
            
            #add-point:AFTER FIELD bggmowndp name="construct.a.bggmowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggmcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggmcrtid
            #add-point:ON ACTION controlp INFIELD bggmcrtid name="construct.c.bggmcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggmcrtid  #顯示到畫面上
            NEXT FIELD bggmcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggmcrtid
            #add-point:BEFORE FIELD bggmcrtid name="construct.b.bggmcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggmcrtid
            
            #add-point:AFTER FIELD bggmcrtid name="construct.a.bggmcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggmcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggmcrtdp
            #add-point:ON ACTION controlp INFIELD bggmcrtdp name="construct.c.bggmcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggmcrtdp  #顯示到畫面上
            NEXT FIELD bggmcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggmcrtdp
            #add-point:BEFORE FIELD bggmcrtdp name="construct.b.bggmcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggmcrtdp
            
            #add-point:AFTER FIELD bggmcrtdp name="construct.a.bggmcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggmcrtdt
            #add-point:BEFORE FIELD bggmcrtdt name="construct.b.bggmcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bggmmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggmmodid
            #add-point:ON ACTION controlp INFIELD bggmmodid name="construct.c.bggmmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggmmodid  #顯示到畫面上
            NEXT FIELD bggmmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggmmodid
            #add-point:BEFORE FIELD bggmmodid name="construct.b.bggmmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggmmodid
            
            #add-point:AFTER FIELD bggmmodid name="construct.a.bggmmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggmmoddt
            #add-point:BEFORE FIELD bggmmoddt name="construct.b.bggmmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bggmcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggmcnfid
            #add-point:ON ACTION controlp INFIELD bggmcnfid name="construct.c.bggmcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggmcnfid  #顯示到畫面上
            NEXT FIELD bggmcnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggmcnfid
            #add-point:BEFORE FIELD bggmcnfid name="construct.b.bggmcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggmcnfid
            
            #add-point:AFTER FIELD bggmcnfid name="construct.a.bggmcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggmcnfdt
            #add-point:BEFORE FIELD bggmcnfdt name="construct.b.bggmcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON bggnseq,bggn010,bggn011,bggn012,bggn013,bggn014,bggn014_desc,bggn015, 
          bggn015_desc,bggn016,bggn016_desc,bggn017,bggn017_desc,bggn018,bggn018_desc,bggn019,bggn019_desc, 
          bggn020,bggn020_desc,bggn021,bggn021_desc,bggn022,bggn022_desc,bggn023,bggn023_desc,bggn024, 
          bggn024_desc,bggn025,bggn025_desc,bggn026,bggn026_desc,bggn037,bggn038
           FROM s_detail1[1].bggnseq,s_detail1[1].bggn010,s_detail1[1].bggn011,s_detail1[1].bggn012, 
               s_detail1[1].bggn013,s_detail1[1].bggn014,s_detail1[1].bggn014_desc,s_detail1[1].bggn015, 
               s_detail1[1].bggn015_desc,s_detail1[1].bggn016,s_detail1[1].bggn016_desc,s_detail1[1].bggn017, 
               s_detail1[1].bggn017_desc,s_detail1[1].bggn018,s_detail1[1].bggn018_desc,s_detail1[1].bggn019, 
               s_detail1[1].bggn019_desc,s_detail1[1].bggn020,s_detail1[1].bggn020_desc,s_detail1[1].bggn021, 
               s_detail1[1].bggn021_desc,s_detail1[1].bggn022,s_detail1[1].bggn022_desc,s_detail1[1].bggn023, 
               s_detail1[1].bggn023_desc,s_detail1[1].bggn024,s_detail1[1].bggn024_desc,s_detail1[1].bggn025, 
               s_detail1[1].bggn025_desc,s_detail1[1].bggn026,s_detail1[1].bggn026_desc,s_detail1[1].bggn037, 
               s_detail1[1].bggn038
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggnseq
            #add-point:BEFORE FIELD bggnseq name="construct.b.page1.bggnseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggnseq
            
            #add-point:AFTER FIELD bggnseq name="construct.a.page1.bggnseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggnseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggnseq
            #add-point:ON ACTION controlp INFIELD bggnseq name="construct.c.page1.bggnseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn010
            #add-point:BEFORE FIELD bggn010 name="construct.b.page1.bggn010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn010
            
            #add-point:AFTER FIELD bggn010 name="construct.a.page1.bggn010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn010
            #add-point:ON ACTION controlp INFIELD bggn010 name="construct.c.page1.bggn010"
            #工資方案
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bggc003()
            DISPLAY g_qryparam.return1 TO bggn010
            NEXT FIELD bggn010
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn011
            #add-point:BEFORE FIELD bggn011 name="construct.b.page1.bggn011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn011
            
            #add-point:AFTER FIELD bggn011 name="construct.a.page1.bggn011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn011
            #add-point:ON ACTION controlp INFIELD bggn011 name="construct.c.page1.bggn011"
            #職級
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = 'abgi710'
            CALL q_bgga002()
            DISPLAY g_qryparam.return1 TO bggn011
            NEXT FIELD bggn011
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn012
            #add-point:BEFORE FIELD bggn012 name="construct.b.page1.bggn012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn012
            
            #add-point:AFTER FIELD bggn012 name="construct.a.page1.bggn012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn012
            #add-point:ON ACTION controlp INFIELD bggn012 name="construct.c.page1.bggn012"
            #職等
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = 'abgi720'
            CALL q_bgga002()
            DISPLAY g_qryparam.return1 TO bggn012
            NEXT FIELD bggn012
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn013
            #add-point:BEFORE FIELD bggn013 name="construct.b.page1.bggn013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn013
            
            #add-point:AFTER FIELD bggn013 name="construct.a.page1.bggn013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn013
            #add-point:ON ACTION controlp INFIELD bggn013 name="construct.c.page1.bggn013"
            #用工性質
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = 'abgi730'
            CALL q_bgga002()
            DISPLAY g_qryparam.return1 TO bggn013
            NEXT FIELD bggn013
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn014
            #add-point:BEFORE FIELD bggn014 name="construct.b.page1.bggn014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn014
            
            #add-point:AFTER FIELD bggn014 name="construct.a.page1.bggn014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn014
            #add-point:ON ACTION controlp INFIELD bggn014 name="construct.c.page1.bggn014"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn014_desc
            #add-point:BEFORE FIELD bggn014_desc name="construct.b.page1.bggn014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn014_desc
            
            #add-point:AFTER FIELD bggn014_desc name="construct.a.page1.bggn014_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn014_desc
            #add-point:ON ACTION controlp INFIELD bggn014_desc name="construct.c.page1.bggn014_desc"
            #人員
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()
            DISPLAY g_qryparam.return1 TO bggn014
            DISPLAY g_qryparam.return1 TO bggn014_desc
            NEXT FIELD bggn014_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn015
            #add-point:BEFORE FIELD bggn015 name="construct.b.page1.bggn015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn015
            
            #add-point:AFTER FIELD bggn015 name="construct.a.page1.bggn015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn015
            #add-point:ON ACTION controlp INFIELD bggn015 name="construct.c.page1.bggn015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn015_desc
            #add-point:BEFORE FIELD bggn015_desc name="construct.b.page1.bggn015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn015_desc
            
            #add-point:AFTER FIELD bggn015_desc name="construct.a.page1.bggn015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn015_desc
            #add-point:ON ACTION controlp INFIELD bggn015_desc name="construct.c.page1.bggn015_desc"
            #部門
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_13()
            DISPLAY g_qryparam.return1 TO bggn015
            DISPLAY g_qryparam.return1 TO bggn015_desc
            NEXT FIELD bggn015_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn016
            #add-point:BEFORE FIELD bggn016 name="construct.b.page1.bggn016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn016
            
            #add-point:AFTER FIELD bggn016 name="construct.a.page1.bggn016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn016
            #add-point:ON ACTION controlp INFIELD bggn016 name="construct.c.page1.bggn016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn016_desc
            #add-point:BEFORE FIELD bggn016_desc name="construct.b.page1.bggn016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn016_desc
            
            #add-point:AFTER FIELD bggn016_desc name="construct.a.page1.bggn016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn016_desc
            #add-point:ON ACTION controlp INFIELD bggn016_desc name="construct.c.page1.bggn016_desc"
            #成本利潤中心
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_10()
            DISPLAY g_qryparam.return1 TO bggn016
            DISPLAY g_qryparam.return1 TO bggn016_desc
            NEXT FIELD bggn016_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn017
            #add-point:BEFORE FIELD bggn017 name="construct.b.page1.bggn017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn017
            
            #add-point:AFTER FIELD bggn017 name="construct.a.page1.bggn017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn017
            #add-point:ON ACTION controlp INFIELD bggn017 name="construct.c.page1.bggn017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn017_desc
            #add-point:BEFORE FIELD bggn017_desc name="construct.b.page1.bggn017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn017_desc
            
            #add-point:AFTER FIELD bggn017_desc name="construct.a.page1.bggn017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn017_desc
            #add-point:ON ACTION controlp INFIELD bggn017_desc name="construct.c.page1.bggn017_desc"
            #區域
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()
            DISPLAY g_qryparam.return1 TO bggn017
            DISPLAY g_qryparam.return1 TO bggn017_desc
            NEXT FIELD bggn017_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn018
            #add-point:BEFORE FIELD bggn018 name="construct.b.page1.bggn018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn018
            
            #add-point:AFTER FIELD bggn018 name="construct.a.page1.bggn018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn018
            #add-point:ON ACTION controlp INFIELD bggn018 name="construct.c.page1.bggn018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn018_desc
            #add-point:BEFORE FIELD bggn018_desc name="construct.b.page1.bggn018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn018_desc
            
            #add-point:AFTER FIELD bggn018_desc name="construct.a.page1.bggn018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn018_desc
            #add-point:ON ACTION controlp INFIELD bggn018_desc name="construct.c.page1.bggn018_desc"
            #收付款客商
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus='Y'"
            CALL q_bgap001()
            DISPLAY g_qryparam.return1 TO bggn018
            DISPLAY g_qryparam.return1 TO bggn018_desc
            NEXT FIELD bggn018_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn019
            #add-point:BEFORE FIELD bggn019 name="construct.b.page1.bggn019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn019
            
            #add-point:AFTER FIELD bggn019 name="construct.a.page1.bggn019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn019
            #add-point:ON ACTION controlp INFIELD bggn019 name="construct.c.page1.bggn019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn019_desc
            #add-point:BEFORE FIELD bggn019_desc name="construct.b.page1.bggn019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn019_desc
            
            #add-point:AFTER FIELD bggn019_desc name="construct.a.page1.bggn019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn019_desc
            #add-point:ON ACTION controlp INFIELD bggn019_desc name="construct.c.page1.bggn019_desc"
            #帳款客商
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus='Y'"
            CALL q_bgap001()
            DISPLAY g_qryparam.return1 TO bggn019
            DISPLAY g_qryparam.return1 TO bggn019_desc
            NEXT FIELD bggn019_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn020
            #add-point:BEFORE FIELD bggn020 name="construct.b.page1.bggn020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn020
            
            #add-point:AFTER FIELD bggn020 name="construct.a.page1.bggn020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn020
            #add-point:ON ACTION controlp INFIELD bggn020 name="construct.c.page1.bggn020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn020_desc
            #add-point:BEFORE FIELD bggn020_desc name="construct.b.page1.bggn020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn020_desc
            
            #add-point:AFTER FIELD bggn020_desc name="construct.a.page1.bggn020_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn020_desc
            #add-point:ON ACTION controlp INFIELD bggn020_desc name="construct.c.page1.bggn020_desc"
            #客群
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO bggn020
            DISPLAY g_qryparam.return1 TO bggn020_desc
            NEXT FIELD bggn020_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn021
            #add-point:BEFORE FIELD bggn021 name="construct.b.page1.bggn021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn021
            
            #add-point:AFTER FIELD bggn021 name="construct.a.page1.bggn021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn021
            #add-point:ON ACTION controlp INFIELD bggn021 name="construct.c.page1.bggn021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn021_desc
            #add-point:BEFORE FIELD bggn021_desc name="construct.b.page1.bggn021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn021_desc
            
            #add-point:AFTER FIELD bggn021_desc name="construct.a.page1.bggn021_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn021_desc
            #add-point:ON ACTION controlp INFIELD bggn021_desc name="construct.c.page1.bggn021_desc"
            #產品類別
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()
            DISPLAY g_qryparam.return1 TO bggn021
            DISPLAY g_qryparam.return1 TO bggn021_desc
            NEXT FIELD bggn021_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn022
            #add-point:BEFORE FIELD bggn022 name="construct.b.page1.bggn022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn022
            
            #add-point:AFTER FIELD bggn022 name="construct.a.page1.bggn022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn022
            #add-point:ON ACTION controlp INFIELD bggn022 name="construct.c.page1.bggn022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn022_desc
            #add-point:BEFORE FIELD bggn022_desc name="construct.b.page1.bggn022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn022_desc
            
            #add-point:AFTER FIELD bggn022_desc name="construct.a.page1.bggn022_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn022_desc
            #add-point:ON ACTION controlp INFIELD bggn022_desc name="construct.c.page1.bggn022_desc"
            #專案編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO bggn022
            DISPLAY g_qryparam.return1 TO bggn022_desc
            NEXT FIELD bggn022_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn023
            #add-point:BEFORE FIELD bggn023 name="construct.b.page1.bggn023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn023
            
            #add-point:AFTER FIELD bggn023 name="construct.a.page1.bggn023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn023
            #add-point:ON ACTION controlp INFIELD bggn023 name="construct.c.page1.bggn023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn023_desc
            #add-point:BEFORE FIELD bggn023_desc name="construct.b.page1.bggn023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn023_desc
            
            #add-point:AFTER FIELD bggn023_desc name="construct.a.page1.bggn023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn023_desc
            #add-point:ON ACTION controlp INFIELD bggn023_desc name="construct.c.page1.bggn023_desc"
            #WBS
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()
            DISPLAY g_qryparam.return1 TO bggn023
            DISPLAY g_qryparam.return1 TO bggn023_desc
            NEXT FIELD bggn023_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn024
            #add-point:BEFORE FIELD bggn024 name="construct.b.page1.bggn024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn024
            
            #add-point:AFTER FIELD bggn024 name="construct.a.page1.bggn024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn024
            #add-point:ON ACTION controlp INFIELD bggn024 name="construct.c.page1.bggn024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn024_desc
            #add-point:BEFORE FIELD bggn024_desc name="construct.b.page1.bggn024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn024_desc
            
            #add-point:AFTER FIELD bggn024_desc name="construct.a.page1.bggn024_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn024_desc
            #add-point:ON ACTION controlp INFIELD bggn024_desc name="construct.c.page1.bggn024_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn025
            #add-point:BEFORE FIELD bggn025 name="construct.b.page1.bggn025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn025
            
            #add-point:AFTER FIELD bggn025 name="construct.a.page1.bggn025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn025
            #add-point:ON ACTION controlp INFIELD bggn025 name="construct.c.page1.bggn025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn025_desc
            #add-point:BEFORE FIELD bggn025_desc name="construct.b.page1.bggn025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn025_desc
            
            #add-point:AFTER FIELD bggn025_desc name="construct.a.page1.bggn025_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn025_desc
            #add-point:ON ACTION controlp INFIELD bggn025_desc name="construct.c.page1.bggn025_desc"
            #通路
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO bggn025
            DISPLAY g_qryparam.return1 TO bggn025_desc
            NEXT FIELD bggn025_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn026
            #add-point:BEFORE FIELD bggn026 name="construct.b.page1.bggn026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn026
            
            #add-point:AFTER FIELD bggn026 name="construct.a.page1.bggn026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn026
            #add-point:ON ACTION controlp INFIELD bggn026 name="construct.c.page1.bggn026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn026_desc
            #add-point:BEFORE FIELD bggn026_desc name="construct.b.page1.bggn026_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn026_desc
            
            #add-point:AFTER FIELD bggn026_desc name="construct.a.page1.bggn026_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn026_desc
            #add-point:ON ACTION controlp INFIELD bggn026_desc name="construct.c.page1.bggn026_desc"
            #品牌
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO bggn026
            DISPLAY g_qryparam.return1 TO bggn026_desc
            NEXT FIELD bggn026_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn037
            #add-point:BEFORE FIELD bggn037 name="construct.b.page1.bggn037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn037
            
            #add-point:AFTER FIELD bggn037 name="construct.a.page1.bggn037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn037
            #add-point:ON ACTION controlp INFIELD bggn037 name="construct.c.page1.bggn037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn038
            #add-point:BEFORE FIELD bggn038 name="construct.b.page1.bggn038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn038
            
            #add-point:AFTER FIELD bggn038 name="construct.a.page1.bggn038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggn038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn038
            #add-point:ON ACTION controlp INFIELD bggn038 name="construct.c.page1.bggn038"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON bggoseq2,bggo009,bggo100,bggo101,bggo036,bggo035,bggo103,bggo104,bggo106, 
          bggo039,bggo040,bggo040_desc
           FROM s_detail2[1].bggoseq2,s_detail2[1].bggo009,s_detail2[1].bggo100,s_detail2[1].bggo101, 
               s_detail2[1].bggo036,s_detail2[1].bggo035,s_detail2[1].bggo103,s_detail2[1].bggo104,s_detail2[1].bggo106, 
               s_detail2[1].bggo039,s_detail2[1].bggo040,s_detail2[1].bggo040_desc
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggoseq2
            #add-point:BEFORE FIELD bggoseq2 name="construct.b.page2.bggoseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggoseq2
            
            #add-point:AFTER FIELD bggoseq2 name="construct.a.page2.bggoseq2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggoseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggoseq2
            #add-point:ON ACTION controlp INFIELD bggoseq2 name="construct.c.page2.bggoseq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo009
            #add-point:BEFORE FIELD bggo009 name="construct.b.page2.bggo009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo009
            
            #add-point:AFTER FIELD bggo009 name="construct.a.page2.bggo009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggo009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo009
            #add-point:ON ACTION controlp INFIELD bggo009 name="construct.c.page2.bggo009"
            #工資項目
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1  = "3401"
            CALL q_bggb002()
            DISPLAY g_qryparam.return1 TO bggo009
            NEXT FIELD bggo009
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo100
            #add-point:BEFORE FIELD bggo100 name="construct.b.page2.bggo100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo100
            
            #add-point:AFTER FIELD bggo100 name="construct.a.page2.bggo100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggo100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo100
            #add-point:ON ACTION controlp INFIELD bggo100 name="construct.c.page2.bggo100"
            #幣別
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO bggo100
            NEXT FIELD bggo100
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo101
            #add-point:BEFORE FIELD bggo101 name="construct.b.page2.bggo101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo101
            
            #add-point:AFTER FIELD bggo101 name="construct.a.page2.bggo101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggo101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo101
            #add-point:ON ACTION controlp INFIELD bggo101 name="construct.c.page2.bggo101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo036
            #add-point:BEFORE FIELD bggo036 name="construct.b.page2.bggo036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo036
            
            #add-point:AFTER FIELD bggo036 name="construct.a.page2.bggo036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggo036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo036
            #add-point:ON ACTION controlp INFIELD bggo036 name="construct.c.page2.bggo036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo035
            #add-point:BEFORE FIELD bggo035 name="construct.b.page2.bggo035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo035
            
            #add-point:AFTER FIELD bggo035 name="construct.a.page2.bggo035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggo035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo035
            #add-point:ON ACTION controlp INFIELD bggo035 name="construct.c.page2.bggo035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo103
            #add-point:BEFORE FIELD bggo103 name="construct.b.page2.bggo103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo103
            
            #add-point:AFTER FIELD bggo103 name="construct.a.page2.bggo103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggo103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo103
            #add-point:ON ACTION controlp INFIELD bggo103 name="construct.c.page2.bggo103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo104
            #add-point:BEFORE FIELD bggo104 name="construct.b.page2.bggo104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo104
            
            #add-point:AFTER FIELD bggo104 name="construct.a.page2.bggo104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggo104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo104
            #add-point:ON ACTION controlp INFIELD bggo104 name="construct.c.page2.bggo104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo106
            #add-point:BEFORE FIELD bggo106 name="construct.b.page2.bggo106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo106
            
            #add-point:AFTER FIELD bggo106 name="construct.a.page2.bggo106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggo106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo106
            #add-point:ON ACTION controlp INFIELD bggo106 name="construct.c.page2.bggo106"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo039
            #add-point:BEFORE FIELD bggo039 name="construct.b.page2.bggo039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo039
            
            #add-point:AFTER FIELD bggo039 name="construct.a.page2.bggo039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggo039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo039
            #add-point:ON ACTION controlp INFIELD bggo039 name="construct.c.page2.bggo039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo040
            #add-point:BEFORE FIELD bggo040 name="construct.b.page2.bggo040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo040
            
            #add-point:AFTER FIELD bggo040 name="construct.a.page2.bggo040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggo040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo040
            #add-point:ON ACTION controlp INFIELD bggo040 name="construct.c.page2.bggo040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo040_desc
            #add-point:BEFORE FIELD bggo040_desc name="construct.b.page2.bggo040_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo040_desc
            
            #add-point:AFTER FIELD bggo040_desc name="construct.a.page2.bggo040_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bggo040_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo040_desc
            #add-point:ON ACTION controlp INFIELD bggo040_desc name="construct.c.page2.bggo040_desc"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         CALL cl_set_comp_visible("bggn014_desc,bggn015_desc,bggn016_desc,bggn017_desc,bggn018_desc",TRUE)
         CALL cl_set_comp_visible("bggn019_desc,bggn020_desc,bggn021_desc,bggn022_desc,bggn023_desc",TRUE)
         CALL cl_set_comp_visible("bggn024_desc,bggn025_desc,bggn026_desc",TRUE)
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
                  WHEN la_wc[li_idx].tableid = "bggm_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "bggn_t" 
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
   LET g_wc2 = cl_replace_str(g_wc2,'_desc',' ')
   LET g_wc2_table1 = cl_replace_str(g_wc2_table1,'_desc',' ')
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abgt730.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abgt730_filter()
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
      CONSTRUCT g_wc_filter ON bggm001,bggm002,bggm003,bggm004,bggm005,bggm006,bggm007
                          FROM s_browse[1].b_bggm001,s_browse[1].b_bggm002,s_browse[1].b_bggm003,s_browse[1].b_bggm004, 
                              s_browse[1].b_bggm005,s_browse[1].b_bggm006,s_browse[1].b_bggm007
 
         BEFORE CONSTRUCT
               DISPLAY abgt730_filter_parser('bggm001') TO s_browse[1].b_bggm001
            DISPLAY abgt730_filter_parser('bggm002') TO s_browse[1].b_bggm002
            DISPLAY abgt730_filter_parser('bggm003') TO s_browse[1].b_bggm003
            DISPLAY abgt730_filter_parser('bggm004') TO s_browse[1].b_bggm004
            DISPLAY abgt730_filter_parser('bggm005') TO s_browse[1].b_bggm005
            DISPLAY abgt730_filter_parser('bggm006') TO s_browse[1].b_bggm006
            DISPLAY abgt730_filter_parser('bggm007') TO s_browse[1].b_bggm007
      
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
 
      CALL abgt730_filter_show('bggm001')
   CALL abgt730_filter_show('bggm002')
   CALL abgt730_filter_show('bggm003')
   CALL abgt730_filter_show('bggm004')
   CALL abgt730_filter_show('bggm005')
   CALL abgt730_filter_show('bggm006')
   CALL abgt730_filter_show('bggm007')
 
END FUNCTION
 
{</section>}
 
{<section id="abgt730.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abgt730_filter_parser(ps_field)
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
 
{<section id="abgt730.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abgt730_filter_show(ps_field)
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
   LET ls_condition = abgt730_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abgt730.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abgt730_query()
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
   CALL g_bggn_d.clear()
   CALL g_bggn2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL abgt730_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abgt730_browser_fill("")
      CALL abgt730_fetch("")
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
      CALL abgt730_filter_show('bggm001')
   CALL abgt730_filter_show('bggm002')
   CALL abgt730_filter_show('bggm003')
   CALL abgt730_filter_show('bggm004')
   CALL abgt730_filter_show('bggm005')
   CALL abgt730_filter_show('bggm006')
   CALL abgt730_filter_show('bggm007')
   CALL abgt730_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL abgt730_fetch("F") 
      #顯示單身筆數
      CALL abgt730_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abgt730.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abgt730_fetch(p_flag)
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
   CALL g_bggn2_d.clear()
 
   
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
   
   LET g_bggm_m.bggm001 = g_browser[g_current_idx].b_bggm001
   LET g_bggm_m.bggm002 = g_browser[g_current_idx].b_bggm002
   LET g_bggm_m.bggm003 = g_browser[g_current_idx].b_bggm003
   LET g_bggm_m.bggm004 = g_browser[g_current_idx].b_bggm004
   LET g_bggm_m.bggm005 = g_browser[g_current_idx].b_bggm005
   LET g_bggm_m.bggm006 = g_browser[g_current_idx].b_bggm006
   LET g_bggm_m.bggm007 = g_browser[g_current_idx].b_bggm007
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abgt730_master_referesh USING g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004, 
       g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007 INTO g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm008, 
       g_bggm_m.bggm001,g_bggm_m.bggm005,g_bggm_m.bggm009,g_bggm_m.bggm004,g_bggm_m.bggm006,g_bggm_m.bggm007, 
       g_bggm_m.bggmstus,g_bggm_m.bggmownid,g_bggm_m.bggmowndp,g_bggm_m.bggmcrtid,g_bggm_m.bggmcrtdp, 
       g_bggm_m.bggmcrtdt,g_bggm_m.bggmmodid,g_bggm_m.bggmmoddt,g_bggm_m.bggmcnfid,g_bggm_m.bggmcnfdt, 
       g_bggm_m.bggmownid_desc,g_bggm_m.bggmowndp_desc,g_bggm_m.bggmcrtid_desc,g_bggm_m.bggmcrtdp_desc, 
       g_bggm_m.bggmmodid_desc,g_bggm_m.bggmcnfid_desc
   
   #遮罩相關處理
   LET g_bggm_m_mask_o.* =  g_bggm_m.*
   CALL abgt730_bggm_t_mask()
   LET g_bggm_m_mask_n.* =  g_bggm_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt730_set_act_visible()   
   CALL abgt730_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_bggm_m_t.* = g_bggm_m.*
   LET g_bggm_m_o.* = g_bggm_m.*
   
   LET g_data_owner = g_bggm_m.bggmownid      
   LET g_data_dept  = g_bggm_m.bggmowndp
   
   #重新顯示   
   CALL abgt730_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt730.insert" >}
#+ 資料新增
PRIVATE FUNCTION abgt730_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_bggn_d.clear()   
   CALL g_bggn2_d.clear()  
 
 
   INITIALIZE g_bggm_m.* TO NULL             #DEFAULT 設定
   
   LET g_bggm001_t = NULL
   LET g_bggm002_t = NULL
   LET g_bggm003_t = NULL
   LET g_bggm004_t = NULL
   LET g_bggm005_t = NULL
   LET g_bggm006_t = NULL
   LET g_bggm007_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bggm_m.bggmownid = g_user
      LET g_bggm_m.bggmowndp = g_dept
      LET g_bggm_m.bggmcrtid = g_user
      LET g_bggm_m.bggmcrtdp = g_dept 
      LET g_bggm_m.bggmcrtdt = cl_get_current()
      LET g_bggm_m.bggmmodid = g_user
      LET g_bggm_m.bggmmoddt = cl_get_current()
      LET g_bggm_m.bggmstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_bggm_m.bggm001 = "20"
      LET g_bggm_m.bggm005 = "1"
      LET g_bggm_m.bggm004 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_bggm_m_t.* = g_bggm_m.*
      LET g_bggm_m_o.* = g_bggm_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bggm_m.bggmstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "FC"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/final_confirmed.png")
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
 
 
 
    
      CALL abgt730_input("a")
      
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
         INITIALIZE g_bggm_m.* TO NULL
         INITIALIZE g_bggn_d TO NULL
         INITIALIZE g_bggn2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL abgt730_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_bggn_d.clear()
      #CALL g_bggn2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt730_set_act_visible()   
   CALL abgt730_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bggm001_t = g_bggm_m.bggm001
   LET g_bggm002_t = g_bggm_m.bggm002
   LET g_bggm003_t = g_bggm_m.bggm003
   LET g_bggm004_t = g_bggm_m.bggm004
   LET g_bggm005_t = g_bggm_m.bggm005
   LET g_bggm006_t = g_bggm_m.bggm006
   LET g_bggm007_t = g_bggm_m.bggm007
 
   
   #組合新增資料的條件
   LET g_add_browse = " bggment = " ||g_enterprise|| " AND",
                      " bggm001 = '", g_bggm_m.bggm001, "' "
                      ," AND bggm002 = '", g_bggm_m.bggm002, "' "
                      ," AND bggm003 = '", g_bggm_m.bggm003, "' "
                      ," AND bggm004 = '", g_bggm_m.bggm004, "' "
                      ," AND bggm005 = '", g_bggm_m.bggm005, "' "
                      ," AND bggm006 = '", g_bggm_m.bggm006, "' "
                      ," AND bggm007 = '", g_bggm_m.bggm007, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt730_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE abgt730_cl
   
   CALL abgt730_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abgt730_master_referesh USING g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004, 
       g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007 INTO g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm008, 
       g_bggm_m.bggm001,g_bggm_m.bggm005,g_bggm_m.bggm009,g_bggm_m.bggm004,g_bggm_m.bggm006,g_bggm_m.bggm007, 
       g_bggm_m.bggmstus,g_bggm_m.bggmownid,g_bggm_m.bggmowndp,g_bggm_m.bggmcrtid,g_bggm_m.bggmcrtdp, 
       g_bggm_m.bggmcrtdt,g_bggm_m.bggmmodid,g_bggm_m.bggmmoddt,g_bggm_m.bggmcnfid,g_bggm_m.bggmcnfdt, 
       g_bggm_m.bggmownid_desc,g_bggm_m.bggmowndp_desc,g_bggm_m.bggmcrtid_desc,g_bggm_m.bggmcrtdp_desc, 
       g_bggm_m.bggmmodid_desc,g_bggm_m.bggmcnfid_desc
   
   
   #遮罩相關處理
   LET g_bggm_m_mask_o.* =  g_bggm_m.*
   CALL abgt730_bggm_t_mask()
   LET g_bggm_m_mask_n.* =  g_bggm_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bggm_m.bggm002,g_bggm_m.bggm002_desc,g_bggm_m.bggm003,g_bggm_m.bggm008,g_bggm_m.bggm008_desc, 
       g_bggm_m.bggm001,g_bggm_m.bggm005,g_bggm_m.bgaa002,g_bggm_m.bgaa003,g_bggm_m.bggm009,g_bggm_m.bggm004, 
       g_bggm_m.bggm006,g_bggm_m.bggm006_desc,g_bggm_m.bggm007,g_bggm_m.bggmstus,g_bggm_m.bggmownid, 
       g_bggm_m.bggmownid_desc,g_bggm_m.bggmowndp,g_bggm_m.bggmowndp_desc,g_bggm_m.bggmcrtid,g_bggm_m.bggmcrtid_desc, 
       g_bggm_m.bggmcrtdp,g_bggm_m.bggmcrtdp_desc,g_bggm_m.bggmcrtdt,g_bggm_m.bggmmodid,g_bggm_m.bggmmodid_desc, 
       g_bggm_m.bggmmoddt,g_bggm_m.bggmcnfid,g_bggm_m.bggmcnfid_desc,g_bggm_m.bggmcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_bggm_m.bggmownid      
   LET g_data_dept  = g_bggm_m.bggmowndp
   
   #功能已完成,通報訊息中心
   CALL abgt730_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abgt730.modify" >}
#+ 資料修改
PRIVATE FUNCTION abgt730_modify()
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
   LET g_bggm_m_t.* = g_bggm_m.*
   LET g_bggm_m_o.* = g_bggm_m.*
   
   IF g_bggm_m.bggm001 IS NULL
   OR g_bggm_m.bggm002 IS NULL
   OR g_bggm_m.bggm003 IS NULL
   OR g_bggm_m.bggm004 IS NULL
   OR g_bggm_m.bggm005 IS NULL
   OR g_bggm_m.bggm006 IS NULL
   OR g_bggm_m.bggm007 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_bggm001_t = g_bggm_m.bggm001
   LET g_bggm002_t = g_bggm_m.bggm002
   LET g_bggm003_t = g_bggm_m.bggm003
   LET g_bggm004_t = g_bggm_m.bggm004
   LET g_bggm005_t = g_bggm_m.bggm005
   LET g_bggm006_t = g_bggm_m.bggm006
   LET g_bggm007_t = g_bggm_m.bggm007
 
   CALL s_transaction_begin()
   
   OPEN abgt730_cl USING g_enterprise,g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt730_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abgt730_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt730_master_referesh USING g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004, 
       g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007 INTO g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm008, 
       g_bggm_m.bggm001,g_bggm_m.bggm005,g_bggm_m.bggm009,g_bggm_m.bggm004,g_bggm_m.bggm006,g_bggm_m.bggm007, 
       g_bggm_m.bggmstus,g_bggm_m.bggmownid,g_bggm_m.bggmowndp,g_bggm_m.bggmcrtid,g_bggm_m.bggmcrtdp, 
       g_bggm_m.bggmcrtdt,g_bggm_m.bggmmodid,g_bggm_m.bggmmoddt,g_bggm_m.bggmcnfid,g_bggm_m.bggmcnfdt, 
       g_bggm_m.bggmownid_desc,g_bggm_m.bggmowndp_desc,g_bggm_m.bggmcrtid_desc,g_bggm_m.bggmcrtdp_desc, 
       g_bggm_m.bggmmodid_desc,g_bggm_m.bggmcnfid_desc
   
   #檢查是否允許此動作
   IF NOT abgt730_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bggm_m_mask_o.* =  g_bggm_m.*
   CALL abgt730_bggm_t_mask()
   LET g_bggm_m_mask_n.* =  g_bggm_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
   
   CALL abgt730_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
    
   WHILE TRUE
      LET g_bggm001_t = g_bggm_m.bggm001
      LET g_bggm002_t = g_bggm_m.bggm002
      LET g_bggm003_t = g_bggm_m.bggm003
      LET g_bggm004_t = g_bggm_m.bggm004
      LET g_bggm005_t = g_bggm_m.bggm005
      LET g_bggm006_t = g_bggm_m.bggm006
      LET g_bggm007_t = g_bggm_m.bggm007
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_bggm_m.bggmmodid = g_user 
LET g_bggm_m.bggmmoddt = cl_get_current()
LET g_bggm_m.bggmmodid_desc = cl_get_username(g_bggm_m.bggmmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL abgt730_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE bggm_t SET (bggmmodid,bggmmoddt) = (g_bggm_m.bggmmodid,g_bggm_m.bggmmoddt)
          WHERE bggment = g_enterprise AND bggm001 = g_bggm001_t
            AND bggm002 = g_bggm002_t
            AND bggm003 = g_bggm003_t
            AND bggm004 = g_bggm004_t
            AND bggm005 = g_bggm005_t
            AND bggm006 = g_bggm006_t
            AND bggm007 = g_bggm007_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_bggm_m.* = g_bggm_m_t.*
            CALL abgt730_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_bggm_m.bggm001 != g_bggm_m_t.bggm001
      OR g_bggm_m.bggm002 != g_bggm_m_t.bggm002
      OR g_bggm_m.bggm003 != g_bggm_m_t.bggm003
      OR g_bggm_m.bggm004 != g_bggm_m_t.bggm004
      OR g_bggm_m.bggm005 != g_bggm_m_t.bggm005
      OR g_bggm_m.bggm006 != g_bggm_m_t.bggm006
      OR g_bggm_m.bggm007 != g_bggm_m_t.bggm007
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE bggn_t SET bggn001 = g_bggm_m.bggm001
                                       ,bggn002 = g_bggm_m.bggm002
                                       ,bggn003 = g_bggm_m.bggm003
                                       ,bggn004 = g_bggm_m.bggm004
                                       ,bggn005 = g_bggm_m.bggm005
                                       ,bggn006 = g_bggm_m.bggm006
                                       ,bggn007 = g_bggm_m.bggm007
 
          WHERE bggnent = g_enterprise AND bggn001 = g_bggm_m_t.bggm001
            AND bggn002 = g_bggm_m_t.bggm002
            AND bggn003 = g_bggm_m_t.bggm003
            AND bggn004 = g_bggm_m_t.bggm004
            AND bggn005 = g_bggm_m_t.bggm005
            AND bggn006 = g_bggm_m_t.bggm006
            AND bggn007 = g_bggm_m_t.bggm007
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "bggn_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bggn_t:",SQLERRMESSAGE 
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
         UPDATE bggo_t
            SET bggo001 = g_bggm_m.bggm001
               ,bggo002 = g_bggm_m.bggm002
               ,bggo003 = g_bggm_m.bggm003
               ,bggo005 = g_bggm_m.bggm004
               ,bggo006 = g_bggm_m.bggm005
               ,bggo007 = g_bggm_m.bggm006
               ,bggo008 = g_bggm_m.bggm007
 
          WHERE bggoent = g_enterprise AND
                bggo001 = g_bggm001_t
            AND bggo002 = g_bggm002_t
            AND bggo003 = g_bggm003_t
            AND bggo005 = g_bggm004_t
            AND bggo006 = g_bggm005_t
            AND bggo007 = g_bggm006_t
            AND bggo008 = g_bggm007_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bggo_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bggo_t:",SQLERRMESSAGE 
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
   CALL abgt730_set_act_visible()   
   CALL abgt730_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bggment = " ||g_enterprise|| " AND",
                      " bggm001 = '", g_bggm_m.bggm001, "' "
                      ," AND bggm002 = '", g_bggm_m.bggm002, "' "
                      ," AND bggm003 = '", g_bggm_m.bggm003, "' "
                      ," AND bggm004 = '", g_bggm_m.bggm004, "' "
                      ," AND bggm005 = '", g_bggm_m.bggm005, "' "
                      ," AND bggm006 = '", g_bggm_m.bggm006, "' "
                      ," AND bggm007 = '", g_bggm_m.bggm007, "' "
 
   #填到對應位置
   CALL abgt730_browser_fill("")
 
   CLOSE abgt730_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt730_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="abgt730.input" >}
#+ 資料輸入
PRIVATE FUNCTION abgt730_input(p_cmd)
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
   DEFINE l_site_str             STRING
   DEFINE l_bggm                 RECORD  #人工預算主檔
             bggm001                LIKE bggm_t.bggm001, #來源作業
             bggm002                LIKE bggm_t.bggm002, #預算編號
             bggm003                LIKE bggm_t.bggm003, #版本
             bggm004                LIKE bggm_t.bggm004, #人工來源
             bggm005                LIKE bggm_t.bggm005, #資料來源
             bggm006                LIKE bggm_t.bggm006, #預算組織
             bggm007                LIKE bggm_t.bggm007, #期別
             bggm008                LIKE bggm_t.bggm008, #管理組織
             bggm009                LIKE bggm_t.bggm009  #預算樣表
                                 END RECORD
   DEFINE l_bggn                 RECORD  #人工預算明細
             bggn001                LIKE bggn_t.bggn001, #資料來源
             bggn002                LIKE bggn_t.bggn002, #預算編號
             bggn003                LIKE bggn_t.bggn003, #版本
             bggn004                LIKE bggn_t.bggn004, #人工來源
             bggn005                LIKE bggn_t.bggn005, #資料來源
             bggn006                LIKE bggn_t.bggn006, #預算組織
             bggn007                LIKE bggn_t.bggn007, #期別
             bggnseq                LIKE bggn_t.bggnseq, #項次
             bggn010                LIKE bggn_t.bggn010, #工資方案
             bggn011                LIKE bggn_t.bggn011, #職級
             bggn012                LIKE bggn_t.bggn012, #職等
             bggn013                LIKE bggn_t.bggn013, #用工屬性
             bggn014                LIKE bggn_t.bggn014, #人員
             bggn015                LIKE bggn_t.bggn015, #部門
             bggn016                LIKE bggn_t.bggn016, #成本利潤中心
             bggn017                LIKE bggn_t.bggn017, #區域
             bggn018                LIKE bggn_t.bggn018, #收付款供應商
             bggn019                LIKE bggn_t.bggn019, #帳款客商
             bggn020                LIKE bggn_t.bggn020, #客群
             bggn021                LIKE bggn_t.bggn021, #產品類別
             bggn022                LIKE bggn_t.bggn022, #專案編號
             bggn023                LIKE bggn_t.bggn023, #WBS
             bggn024                LIKE bggn_t.bggn024, #經營方式
             bggn025                LIKE bggn_t.bggn025, #通路
             bggn026                LIKE bggn_t.bggn026  #品牌
                                 END RECORD
   DEFINE ls_js                  STRING
      DEFINE l_bgaa006           LIKE bgaa_t.bgaa006
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
   DISPLAY BY NAME g_bggm_m.bggm002,g_bggm_m.bggm002_desc,g_bggm_m.bggm003,g_bggm_m.bggm008,g_bggm_m.bggm008_desc, 
       g_bggm_m.bggm001,g_bggm_m.bggm005,g_bggm_m.bgaa002,g_bggm_m.bgaa003,g_bggm_m.bggm009,g_bggm_m.bggm004, 
       g_bggm_m.bggm006,g_bggm_m.bggm006_desc,g_bggm_m.bggm007,g_bggm_m.bggmstus,g_bggm_m.bggmownid, 
       g_bggm_m.bggmownid_desc,g_bggm_m.bggmowndp,g_bggm_m.bggmowndp_desc,g_bggm_m.bggmcrtid,g_bggm_m.bggmcrtid_desc, 
       g_bggm_m.bggmcrtdp,g_bggm_m.bggmcrtdp_desc,g_bggm_m.bggmcrtdt,g_bggm_m.bggmmodid,g_bggm_m.bggmmodid_desc, 
       g_bggm_m.bggmmoddt,g_bggm_m.bggmcnfid,g_bggm_m.bggmcnfid_desc,g_bggm_m.bggmcnfdt
   
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
   LET g_forupd_sql = "SELECT bggnseq,bggn010,bggn011,bggn012,bggn013,bggn014,bggn015,bggn016,bggn017, 
       bggn018,bggn019,bggn020,bggn021,bggn022,bggn023,bggn024,bggn025,bggn026,bggn037,bggn038 FROM  
       bggn_t WHERE bggnent=? AND bggn001=? AND bggn002=? AND bggn003=? AND bggn004=? AND bggn005=?  
       AND bggn006=? AND bggn007=? AND bggnseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt730_bcl CURSOR FROM g_forupd_sql
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT bggoseq2,bggo009,bggo100,bggo101,bggo036,bggo035,bggo103,bggo104,bggo106, 
       bggo039,bggo040 FROM bggo_t WHERE bggoent=? AND bggo001=? AND bggo002=? AND bggo003=? AND bggo005=?  
       AND bggo006=? AND bggo007=? AND bggo008=? AND bggoseq=? AND bggoseq2=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt730_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abgt730_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abgt730_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm008,g_bggm_m.bggm001,g_bggm_m.bggm005, 
       g_bggm_m.bggm006,g_bggm_m.bggm007,g_bggm_m.bggmstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   CALL abgt730_set_all_entery(g_bggm_m.bggm004)
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abgt730.input.head" >}
      #單頭段
      INPUT BY NAME g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm008,g_bggm_m.bggm001,g_bggm_m.bggm005, 
          g_bggm_m.bggm006,g_bggm_m.bggm007,g_bggm_m.bggmstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN abgt730_cl USING g_enterprise,g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abgt730_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abgt730_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL abgt730_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL abgt730_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm002
            
            #add-point:AFTER FIELD bggm002 name="input.a.bggm002"
            #預算編號
            IF  NOT cl_null(g_bggm_m.bggm001) AND NOT cl_null(g_bggm_m.bggm002) AND NOT cl_null(g_bggm_m.bggm003) AND NOT cl_null(g_bggm_m.bggm004) AND NOT cl_null(g_bggm_m.bggm005) AND NOT cl_null(g_bggm_m.bggm006) AND NOT cl_null(g_bggm_m.bggm007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggm_m.bggm001 != g_bggm001_t  OR g_bggm_m.bggm002 != g_bggm002_t  OR g_bggm_m.bggm003 != g_bggm003_t  OR g_bggm_m.bggm004 != g_bggm004_t  OR g_bggm_m.bggm005 != g_bggm005_t  OR g_bggm_m.bggm006 != g_bggm006_t  OR g_bggm_m.bggm007 != g_bggm007_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bggm_t WHERE "||"bggment = " ||g_enterprise|| " AND "||"bggm001 = '"||g_bggm_m.bggm001 ||"' AND "|| "bggm002 = '"||g_bggm_m.bggm002 ||"' AND "|| "bggm003 = '"||g_bggm_m.bggm003 ||"' AND "|| "bggm004 = '"||g_bggm_m.bggm004 ||"' AND "|| "bggm005 = '"||g_bggm_m.bggm005 ||"' AND "|| "bggm006 = '"||g_bggm_m.bggm006 ||"' AND "|| "bggm007 = '"||g_bggm_m.bggm007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_bggm_m.bggm002) THEN
               IF g_bggm_m.bggm002 != g_bggm_m_o.bggm002 OR cl_null(g_bggm_m_o.bggm002) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bggm_m.bggm002
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] = "abg-00008:sub-01302|abgi010|",cl_get_progname("abgi010",g_lang,"2"),"|:EXEPROGabgi010"
                  IF cl_chk_exist("v_bgaa001") THEN
                     #预算编号需是使用预测的(bgaa006=1.使用)
                     SELECT bgaa006 INTO l_bgaa006 FROM bgaa_t
                      WHERE bgaaent=g_enterprise AND bgaa001=g_bggm_m.bggm002
                     IF l_bgaa006 <> '1' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00292'
                        LET g_errparam.extend = g_bggm_m.bggm002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bggm_m.bggm002 = g_bggm_m_o.bggm002
                        CALL s_desc_get_budget_desc(g_bggm_m.bggm002) RETURNING g_bggm_m.bggm002_desc
                        DISPLAY BY NAME g_bggm_m.bggm002_desc
                        NEXT FIELD CURRENT
                     END IF
                     IF NOT cl_null(g_bggm_m.bggm009) THEN
                        CALL s_abg2_bgai002_chk(g_bggm_m.bggm002,g_bggm_m.bggm009,'06')
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_bggm_m.bggm002," + ",g_bggm_m.bggm009
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bggm_m.bggm002 = g_bggm_m_o.bggm002
                           CALL s_desc_get_budget_desc(g_bggm_m.bggm002) RETURNING g_bggm_m.bggm002_desc
                           DISPLAY BY NAME g_bggm_m.bggm002_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_bggm_m.bggm002 = g_bggm_m_o.bggm002
                     CALL s_desc_get_budget_desc(g_bggm_m.bggm002) RETURNING g_bggm_m.bggm002_desc
                     DISPLAY BY NAME g_bggm_m.bggm002_desc
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
            END IF
            LET g_bggm_m_o.* = g_bggm_m.*
            #抓取預算樣表
            IF NOT cl_null(g_bggm_m.bggm008) THEN
               SELECT DISTINCT bgai008 INTO g_bggm_m.bggm009
                 FROM bgai_t
                WHERE bgaient=g_enterprise AND bgai001=g_bggm_m.bggm002 AND bgai002=g_bggm_m.bggm008
               DISPLAY BY NAME g_bggm_m.bggm009
               #核算項欄位隱顯
               CALL abgt730_set_entry_bggm009(g_bggm_m.bggm002,g_bggm_m.bggm008,g_bggm_m.bggm009)
            END IF
            
            #抓取預算週期
            CALL s_abgt340_sel_bgaa(g_bggm_m.bggm002) RETURNING g_bggm_m.bgaa002,g_bggm_m.bgaa003,g_max_period
            DISPLAY BY NAME g_bggm_m.bgaa002,g_bggm_m.bgaa003
            
            CALL s_desc_get_budget_desc(g_bggm_m.bggm002) RETURNING g_bggm_m.bggm002_desc
            DISPLAY BY NAME g_bggm_m.bggm002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm002
            #add-point:BEFORE FIELD bggm002 name="input.b.bggm002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggm002
            #add-point:ON CHANGE bggm002 name="input.g.bggm002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bggm_m.bggm003,"0","0","","","azz-00079",1) THEN
               NEXT FIELD bggm003
            END IF 
 
 
 
            #add-point:AFTER FIELD bggm003 name="input.a.bggm003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bggm_m.bggm001) AND NOT cl_null(g_bggm_m.bggm002) AND NOT cl_null(g_bggm_m.bggm003) AND NOT cl_null(g_bggm_m.bggm004) AND NOT cl_null(g_bggm_m.bggm005) AND NOT cl_null(g_bggm_m.bggm006) AND NOT cl_null(g_bggm_m.bggm007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggm_m.bggm001 != g_bggm001_t  OR g_bggm_m.bggm002 != g_bggm002_t  OR g_bggm_m.bggm003 != g_bggm003_t  OR g_bggm_m.bggm004 != g_bggm004_t  OR g_bggm_m.bggm005 != g_bggm005_t  OR g_bggm_m.bggm006 != g_bggm006_t  OR g_bggm_m.bggm007 != g_bggm007_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bggm_t WHERE "||"bggment = " ||g_enterprise|| " AND "||"bggm001 = '"||g_bggm_m.bggm001 ||"' AND "|| "bggm002 = '"||g_bggm_m.bggm002 ||"' AND "|| "bggm003 = '"||g_bggm_m.bggm003 ||"' AND "|| "bggm004 = '"||g_bggm_m.bggm004 ||"' AND "|| "bggm005 = '"||g_bggm_m.bggm005 ||"' AND "|| "bggm006 = '"||g_bggm_m.bggm006 ||"' AND "|| "bggm007 = '"||g_bggm_m.bggm007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm003
            #add-point:BEFORE FIELD bggm003 name="input.b.bggm003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggm003
            #add-point:ON CHANGE bggm003 name="input.g.bggm003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm008
            
            #add-point:AFTER FIELD bggm008 name="input.a.bggm008"
            #管理組織
            IF NOT cl_null(g_bggm_m.bggm008) THEN
               IF g_bggm_m.bggm008 != g_bggm_m_o.bggm008 OR cl_null(g_bggm_m_o.bggm008) THEN
                  CALL s_abg2_bgai002_chk(g_bggm_m.bggm002,g_bggm_m.bggm008,'06')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bggm_m.bggm008
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggm_m.bggm008 = g_bggm_m_o.bggm008
                     CALL s_desc_get_bgai002_desc(g_bggm_m.bggm002,g_bggm_m.bggm008) RETURNING g_bggm_m.bggm008_desc
                     DISPLAY BY NAME g_bggm_m.bggm008_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bggm_m_o.* = g_bggm_m.*
            
            #抓取預算樣表
            IF NOT cl_null(g_bggm_m.bggm008) THEN
               SELECT DISTINCT bgai008 INTO g_bggm_m.bggm009
                 FROM bgai_t
                WHERE bgaient=g_enterprise AND bgai001=g_bggm_m.bggm002 AND bgai002=g_bggm_m.bggm008
               DISPLAY BY NAME g_bggm_m.bggm009
               #核算項欄位隱顯
               CALL abgt730_set_entry_bggm009(g_bggm_m.bggm002,g_bggm_m.bggm008,g_bggm_m.bggm009)
            END IF
            
            CALL s_desc_get_bgai002_desc(g_bggm_m.bggm002,g_bggm_m.bggm008) RETURNING g_bggm_m.bggm008_desc
            DISPLAY BY NAME g_bggm_m.bggm008_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm008
            #add-point:BEFORE FIELD bggm008 name="input.b.bggm008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggm008
            #add-point:ON CHANGE bggm008 name="input.g.bggm008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm001
            #add-point:BEFORE FIELD bggm001 name="input.b.bggm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm001
            
            #add-point:AFTER FIELD bggm001 name="input.a.bggm001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bggm_m.bggm001) AND NOT cl_null(g_bggm_m.bggm002) AND NOT cl_null(g_bggm_m.bggm003) AND NOT cl_null(g_bggm_m.bggm004) AND NOT cl_null(g_bggm_m.bggm005) AND NOT cl_null(g_bggm_m.bggm006) AND NOT cl_null(g_bggm_m.bggm007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggm_m.bggm001 != g_bggm001_t  OR g_bggm_m.bggm002 != g_bggm002_t  OR g_bggm_m.bggm003 != g_bggm003_t  OR g_bggm_m.bggm004 != g_bggm004_t  OR g_bggm_m.bggm005 != g_bggm005_t  OR g_bggm_m.bggm006 != g_bggm006_t  OR g_bggm_m.bggm007 != g_bggm007_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bggm_t WHERE "||"bggment = " ||g_enterprise|| " AND "||"bggm001 = '"||g_bggm_m.bggm001 ||"' AND "|| "bggm002 = '"||g_bggm_m.bggm002 ||"' AND "|| "bggm003 = '"||g_bggm_m.bggm003 ||"' AND "|| "bggm004 = '"||g_bggm_m.bggm004 ||"' AND "|| "bggm005 = '"||g_bggm_m.bggm005 ||"' AND "|| "bggm006 = '"||g_bggm_m.bggm006 ||"' AND "|| "bggm007 = '"||g_bggm_m.bggm007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggm001
            #add-point:ON CHANGE bggm001 name="input.g.bggm001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm005
            #add-point:BEFORE FIELD bggm005 name="input.b.bggm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm005
            
            #add-point:AFTER FIELD bggm005 name="input.a.bggm005"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bggm_m.bggm001) AND NOT cl_null(g_bggm_m.bggm002) AND NOT cl_null(g_bggm_m.bggm003) AND NOT cl_null(g_bggm_m.bggm004) AND NOT cl_null(g_bggm_m.bggm005) AND NOT cl_null(g_bggm_m.bggm006) AND NOT cl_null(g_bggm_m.bggm007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggm_m.bggm001 != g_bggm001_t  OR g_bggm_m.bggm002 != g_bggm002_t  OR g_bggm_m.bggm003 != g_bggm003_t  OR g_bggm_m.bggm004 != g_bggm004_t  OR g_bggm_m.bggm005 != g_bggm005_t  OR g_bggm_m.bggm006 != g_bggm006_t  OR g_bggm_m.bggm007 != g_bggm007_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bggm_t WHERE "||"bggment = " ||g_enterprise|| " AND "||"bggm001 = '"||g_bggm_m.bggm001 ||"' AND "|| "bggm002 = '"||g_bggm_m.bggm002 ||"' AND "|| "bggm003 = '"||g_bggm_m.bggm003 ||"' AND "|| "bggm004 = '"||g_bggm_m.bggm004 ||"' AND "|| "bggm005 = '"||g_bggm_m.bggm005 ||"' AND "|| "bggm006 = '"||g_bggm_m.bggm006 ||"' AND "|| "bggm007 = '"||g_bggm_m.bggm007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggm005
            #add-point:ON CHANGE bggm005 name="input.g.bggm005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm006
            
            #add-point:AFTER FIELD bggm006 name="input.a.bggm006"
            #預算組織
            IF  NOT cl_null(g_bggm_m.bggm001) AND NOT cl_null(g_bggm_m.bggm002) AND NOT cl_null(g_bggm_m.bggm003) AND NOT cl_null(g_bggm_m.bggm004) AND NOT cl_null(g_bggm_m.bggm005) AND NOT cl_null(g_bggm_m.bggm006) AND NOT cl_null(g_bggm_m.bggm007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggm_m.bggm001 != g_bggm001_t  OR g_bggm_m.bggm002 != g_bggm002_t  OR g_bggm_m.bggm003 != g_bggm003_t  OR g_bggm_m.bggm004 != g_bggm004_t  OR g_bggm_m.bggm005 != g_bggm005_t  OR g_bggm_m.bggm006 != g_bggm006_t  OR g_bggm_m.bggm007 != g_bggm007_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bggm_t WHERE "||"bggment = " ||g_enterprise|| " AND "||"bggm001 = '"||g_bggm_m.bggm001 ||"' AND "|| "bggm002 = '"||g_bggm_m.bggm002 ||"' AND "|| "bggm003 = '"||g_bggm_m.bggm003 ||"' AND "|| "bggm004 = '"||g_bggm_m.bggm004 ||"' AND "|| "bggm005 = '"||g_bggm_m.bggm005 ||"' AND "|| "bggm006 = '"||g_bggm_m.bggm006 ||"' AND "|| "bggm007 = '"||g_bggm_m.bggm007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_bggm_m.bggm006) THEN
               IF g_bggm_m.bggm006 != g_bggm_m_o.bggm006 OR cl_null(g_bggm_m_o.bggm006) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bggm_m.bggm006
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  IF NOT cl_chk_exist("v_ooef001_24") THEN
                     LET g_bggm_m.bggm006 = g_bggm_m_o.bggm006
                     CALL s_desc_get_department_desc(g_bggm_m.bggm006) RETURNING g_bggm_m.bggm006_desc
                     DISPLAY BY NAME g_bggm_m.bggm006_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL s_abg2_bgai004_chk(g_bggm_m.bggm002,'',g_bggm_m.bggm006,'')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bggm_m.bggm006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggm_m.bggm006 = g_bggm_m_o.bggm006
                     CALL s_desc_get_department_desc(g_bggm_m.bggm006) RETURNING g_bggm_m.bggm006_desc
                     DISPLAY BY NAME g_bggm_m.bggm006_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bggm_m_o.* = g_bggm_m.*
            CALL s_fin_orga_get_comp_ld(g_bggm_m.bggm006) RETURNING g_sub_success,g_errno,g_comp,g_ld
            CALL s_desc_get_department_desc(g_bggm_m.bggm006) RETURNING g_bggm_m.bggm006_desc
            DISPLAY BY NAME g_bggm_m.bggm006_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm006
            #add-point:BEFORE FIELD bggm006 name="input.b.bggm006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggm006
            #add-point:ON CHANGE bggm006 name="input.g.bggm006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bggm_m.bggm007,"0","0","13","1","azz-00087",1) THEN
               NEXT FIELD bggm007
            END IF 
 
 
 
            #add-point:AFTER FIELD bggm007 name="input.a.bggm007"
            #期別
            IF  NOT cl_null(g_bggm_m.bggm001) AND NOT cl_null(g_bggm_m.bggm002) AND NOT cl_null(g_bggm_m.bggm003) AND NOT cl_null(g_bggm_m.bggm004) AND NOT cl_null(g_bggm_m.bggm005) AND NOT cl_null(g_bggm_m.bggm006) AND NOT cl_null(g_bggm_m.bggm007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggm_m.bggm001 != g_bggm001_t  OR g_bggm_m.bggm002 != g_bggm002_t  OR g_bggm_m.bggm003 != g_bggm003_t  OR g_bggm_m.bggm004 != g_bggm004_t  OR g_bggm_m.bggm005 != g_bggm005_t  OR g_bggm_m.bggm006 != g_bggm006_t  OR g_bggm_m.bggm007 != g_bggm007_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bggm_t WHERE "||"bggment = " ||g_enterprise|| " AND "||"bggm001 = '"||g_bggm_m.bggm001 ||"' AND "|| "bggm002 = '"||g_bggm_m.bggm002 ||"' AND "|| "bggm003 = '"||g_bggm_m.bggm003 ||"' AND "|| "bggm004 = '"||g_bggm_m.bggm004 ||"' AND "|| "bggm005 = '"||g_bggm_m.bggm005 ||"' AND "|| "bggm006 = '"||g_bggm_m.bggm006 ||"' AND "|| "bggm007 = '"||g_bggm_m.bggm007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_bggm_m.bggm007) THEN
            IF g_bggm_m.bggm007 != g_bggm_m_o.bggm007 OR cl_null(g_bggm_m_o.bggm007) THEN
                  #抓取預算週期的期別是12期還13期
                  LET l_n = 0
                  SELECT COUNT(DISTINCT bgac004) INTO l_n
                    FROM bgac_t
                   WHERE bgacent = g_enterprise
                     AND bgac001 = g_bggm_m.bgaa002
                  IF cl_null(l_n) THEN LET l_n = 0 END IF
                  IF g_bggm_m.bggm007 > l_n THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00267'
                     LET g_errparam.extend = g_bggm_m.bggm007
                     LET g_errparam.replace[1] = l_n
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggm_m.bggm007 = g_bggm_m_o.bggm007
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bggm_m_o.* = g_bggm_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm007
            #add-point:BEFORE FIELD bggm007 name="input.b.bggm007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggm007
            #add-point:ON CHANGE bggm007 name="input.g.bggm007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggmstus
            #add-point:BEFORE FIELD bggmstus name="input.b.bggmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggmstus
            
            #add-point:AFTER FIELD bggmstus name="input.a.bggmstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggmstus
            #add-point:ON CHANGE bggmstus name="input.g.bggmstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bggm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm002
            #add-point:ON ACTION controlp INFIELD bggm002 name="input.c.bggm002"
            #預算編號
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggm_m.bggm002
            LET g_qryparam.where = " bgaastus='Y'"
            CALL q_bgaa001()
            LET g_bggm_m.bggm002 = g_qryparam.return1
            DISPLAY g_bggm_m.bggm002 TO bggm002
            NEXT FIELD bggm002
            #END add-point
 
 
         #Ctrlp:input.c.bggm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm003
            #add-point:ON ACTION controlp INFIELD bggm003 name="input.c.bggm003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bggm008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm008
            #add-point:ON ACTION controlp INFIELD bggm008 name="input.c.bggm008"
            #管理組織
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggm_m.bggm008
            LET g_qryparam.where = " bgaistus='Y' AND bgai003='",g_user,"' AND (bgai005='06' OR bgai005='00') "
            IF NOT cl_null(g_bggm_m.bggm002) THEN
               LET g_qryparam.where = g_qryparam.where," AND bgai001 = '",g_bggm_m.bggm002,"' "
            END IF
            CALL q_bgai002()
            LET g_bggm_m.bggm008 = g_qryparam.return1
            DISPLAY g_bggm_m.bggm008 TO bggm008
            NEXT FIELD bggm008
            #END add-point
 
 
         #Ctrlp:input.c.bggm001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm001
            #add-point:ON ACTION controlp INFIELD bggm001 name="input.c.bggm001"
            
            #END add-point
 
 
         #Ctrlp:input.c.bggm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm005
            #add-point:ON ACTION controlp INFIELD bggm005 name="input.c.bggm005"
            
            #END add-point
 
 
         #Ctrlp:input.c.bggm006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm006
            #add-point:ON ACTION controlp INFIELD bggm006 name="input.c.bggm006"
            #預算組織
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggm_m.bggm006
            LET g_qryparam.where = " ooef001 IN (SELECT bgaj002 FROM bgaj_t ",
                                   "              WHERE bgajent = ooefent AND bgajent = ",g_enterprise,
                                   "                AND bgaj001 = '",g_bggm_m.bggm002,"' AND bgajstus = 'Y') "
            CALL s_abg2_get_budget_site(g_bggm_m.bggm002,'',g_user,'06') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND ooef001 IN ",l_site_str
            CALL q_ooef001()
            LET g_bggm_m.bggm006 = g_qryparam.return1
            DISPLAY g_bggm_m.bggm006 TO bggm006
            NEXT FIELD bggm006
            #END add-point
 
 
         #Ctrlp:input.c.bggm007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm007
            #add-point:ON ACTION controlp INFIELD bggm007 name="input.c.bggm007"
            
            #END add-point
 
 
         #Ctrlp:input.c.bggmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggmstus
            #add-point:ON ACTION controlp INFIELD bggmstus name="input.c.bggmstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005, 
                g_bggm_m.bggm006,g_bggm_m.bggm007
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO bggm_t (bggment,bggm002,bggm003,bggm008,bggm001,bggm005,bggm009,bggm004,bggm006, 
                   bggm007,bggmstus,bggmownid,bggmowndp,bggmcrtid,bggmcrtdp,bggmcrtdt,bggmmodid,bggmmoddt, 
                   bggmcnfid,bggmcnfdt)
               VALUES (g_enterprise,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm008,g_bggm_m.bggm001, 
                   g_bggm_m.bggm005,g_bggm_m.bggm009,g_bggm_m.bggm004,g_bggm_m.bggm006,g_bggm_m.bggm007, 
                   g_bggm_m.bggmstus,g_bggm_m.bggmownid,g_bggm_m.bggmowndp,g_bggm_m.bggmcrtid,g_bggm_m.bggmcrtdp, 
                   g_bggm_m.bggmcrtdt,g_bggm_m.bggmmodid,g_bggm_m.bggmmoddt,g_bggm_m.bggmcnfid,g_bggm_m.bggmcnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_bggm_m:",SQLERRMESSAGE 
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
                  CALL abgt730_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL abgt730_b_fill()
                  CALL abgt730_b_fill2('0')
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
               CALL abgt730_bggm_t_mask_restore('restore_mask_o')
               
               UPDATE bggm_t SET (bggm002,bggm003,bggm008,bggm001,bggm005,bggm009,bggm004,bggm006,bggm007, 
                   bggmstus,bggmownid,bggmowndp,bggmcrtid,bggmcrtdp,bggmcrtdt,bggmmodid,bggmmoddt,bggmcnfid, 
                   bggmcnfdt) = (g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm008,g_bggm_m.bggm001, 
                   g_bggm_m.bggm005,g_bggm_m.bggm009,g_bggm_m.bggm004,g_bggm_m.bggm006,g_bggm_m.bggm007, 
                   g_bggm_m.bggmstus,g_bggm_m.bggmownid,g_bggm_m.bggmowndp,g_bggm_m.bggmcrtid,g_bggm_m.bggmcrtdp, 
                   g_bggm_m.bggmcrtdt,g_bggm_m.bggmmodid,g_bggm_m.bggmmoddt,g_bggm_m.bggmcnfid,g_bggm_m.bggmcnfdt) 
 
                WHERE bggment = g_enterprise AND bggm001 = g_bggm001_t
                  AND bggm002 = g_bggm002_t
                  AND bggm003 = g_bggm003_t
                  AND bggm004 = g_bggm004_t
                  AND bggm005 = g_bggm005_t
                  AND bggm006 = g_bggm006_t
                  AND bggm007 = g_bggm007_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "bggm_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL abgt730_bggm_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_bggm_m_t)
               LET g_log2 = util.JSON.stringify(g_bggm_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_bggm001_t = g_bggm_m.bggm001
            LET g_bggm002_t = g_bggm_m.bggm002
            LET g_bggm003_t = g_bggm_m.bggm003
            LET g_bggm004_t = g_bggm_m.bggm004
            LET g_bggm005_t = g_bggm_m.bggm005
            LET g_bggm006_t = g_bggm_m.bggm006
            LET g_bggm007_t = g_bggm_m.bggm007
 
            
      END INPUT
   
 
{</section>}
 
{<section id="abgt730.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_bggn_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
 
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bggn_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgt730_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_bggn_d.getLength()
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
            CALL abgt730_b_fill2('2')
 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN abgt730_cl USING g_enterprise,g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abgt730_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abgt730_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_bggn_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bggn_d[l_ac].bggnseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bggn_d_t.* = g_bggn_d[l_ac].*  #BACKUP
               LET g_bggn_d_o.* = g_bggn_d[l_ac].*  #BACKUP
               CALL abgt730_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL abgt730_set_no_entry_b(l_cmd)
               IF NOT abgt730_lock_b("bggn_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgt730_bcl INTO g_bggn_d[l_ac].bggnseq,g_bggn_d[l_ac].bggn010,g_bggn_d[l_ac].bggn011, 
                      g_bggn_d[l_ac].bggn012,g_bggn_d[l_ac].bggn013,g_bggn_d[l_ac].bggn014,g_bggn_d[l_ac].bggn015, 
                      g_bggn_d[l_ac].bggn016,g_bggn_d[l_ac].bggn017,g_bggn_d[l_ac].bggn018,g_bggn_d[l_ac].bggn019, 
                      g_bggn_d[l_ac].bggn020,g_bggn_d[l_ac].bggn021,g_bggn_d[l_ac].bggn022,g_bggn_d[l_ac].bggn023, 
                      g_bggn_d[l_ac].bggn024,g_bggn_d[l_ac].bggn025,g_bggn_d[l_ac].bggn026,g_bggn_d[l_ac].bggn037, 
                      g_bggn_d[l_ac].bggn038
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bggn_d_t.bggnseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bggn_d_mask_o[l_ac].* =  g_bggn_d[l_ac].*
                  CALL abgt730_bggn_t_mask()
                  LET g_bggn_d_mask_n[l_ac].* =  g_bggn_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL abgt730_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF g_bggm_m.bggm004 = '2' THEN
               NEXT FIELD bggo104
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
            INITIALIZE g_bggn_d[l_ac].* TO NULL 
            INITIALIZE g_bggn_d_t.* TO NULL 
            INITIALIZE g_bggn_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #第一單身項次
            SELECT MAX(bggnseq)+1 INTO g_bggn_d[l_ac].bggnseq FROM bggn_t
             WHERE bggnent = g_enterprise
               AND bggn001 = g_bggm_m.bggm001
               AND bggn002 = g_bggm_m.bggm002
               AND bggn003 = g_bggm_m.bggm003
               AND bggn004 = g_bggm_m.bggm004
               AND bggn005 = g_bggm_m.bggm005
               AND bggn006 = g_bggm_m.bggm006
               AND bggn007 = g_bggm_m.bggm007
            IF cl_null(g_bggn_d[l_ac].bggnseq) OR g_bggn_d[l_ac].bggnseq = 0 THEN
               LET g_bggn_d[l_ac].bggnseq = 1
            END IF
            #end add-point
            LET g_bggn_d_t.* = g_bggn_d[l_ac].*     #新輸入資料
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abgt730_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL abgt730_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bggn_d[li_reproduce_target].* = g_bggn_d[li_reproduce].*
 
               LET g_bggn_d[li_reproduce_target].bggnseq = NULL
 
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
            #檢查用工人數單身(bggn_t)核算項組合不可重複
            LET l_bggn.bggn001 = g_bggm_m.bggm001
            LET l_bggn.bggn002 = g_bggm_m.bggm002
            LET l_bggn.bggn003 = g_bggm_m.bggm003
            LET l_bggn.bggn004 = g_bggm_m.bggm004
            LET l_bggn.bggn005 = g_bggm_m.bggm005
            LET l_bggn.bggn006 = g_bggm_m.bggm006
            LET l_bggn.bggn007 = g_bggm_m.bggm007
            LET l_bggn.bggnseq = g_bggn_d[l_ac].bggnseq
            LET l_bggn.bggn010 = g_bggn_d[l_ac].bggn010
            LET l_bggn.bggn011 = g_bggn_d[l_ac].bggn011
            LET l_bggn.bggn012 = g_bggn_d[l_ac].bggn012
            LET l_bggn.bggn013 = g_bggn_d[l_ac].bggn013
            LET l_bggn.bggn014 = g_bggn_d[l_ac].bggn014
            LET l_bggn.bggn015 = g_bggn_d[l_ac].bggn015
            LET l_bggn.bggn016 = g_bggn_d[l_ac].bggn016
            LET l_bggn.bggn017 = g_bggn_d[l_ac].bggn017
            LET l_bggn.bggn018 = g_bggn_d[l_ac].bggn018
            LET l_bggn.bggn019 = g_bggn_d[l_ac].bggn019
            LET l_bggn.bggn020 = g_bggn_d[l_ac].bggn020
            LET l_bggn.bggn021 = g_bggn_d[l_ac].bggn021
            LET l_bggn.bggn022 = g_bggn_d[l_ac].bggn022
            LET l_bggn.bggn023 = g_bggn_d[l_ac].bggn023
            LET l_bggn.bggn024 = g_bggn_d[l_ac].bggn024
            LET l_bggn.bggn025 = g_bggn_d[l_ac].bggn025
            LET l_bggn.bggn026 = g_bggn_d[l_ac].bggn026
            LET ls_js = util.JSON.stringify(l_bggn)
            CALL s_abgt730_chk_bggn(ls_js) RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CANCEL INSERT
            END IF
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM bggn_t 
             WHERE bggnent = g_enterprise AND bggn001 = g_bggm_m.bggm001
               AND bggn002 = g_bggm_m.bggm002
               AND bggn003 = g_bggm_m.bggm003
               AND bggn004 = g_bggm_m.bggm004
               AND bggn005 = g_bggm_m.bggm005
               AND bggn006 = g_bggm_m.bggm006
               AND bggn007 = g_bggm_m.bggm007
 
               AND bggnseq = g_bggn_d[l_ac].bggnseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bggm_m.bggm001
               LET gs_keys[2] = g_bggm_m.bggm002
               LET gs_keys[3] = g_bggm_m.bggm003
               LET gs_keys[4] = g_bggm_m.bggm004
               LET gs_keys[5] = g_bggm_m.bggm005
               LET gs_keys[6] = g_bggm_m.bggm006
               LET gs_keys[7] = g_bggm_m.bggm007
               LET gs_keys[8] = g_bggn_d[g_detail_idx].bggnseq
               CALL abgt730_insert_b('bggn_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #狀態給N
               UPDATE bggn_t SET bggnstus = 'N'
                WHERE bggnent = g_enterprise
                  AND bggn001 = g_bggm_m.bggm001
                  AND bggn002 = g_bggm_m.bggm002
                  AND bggn003 = g_bggm_m.bggm003
                  AND bggn004 = g_bggm_m.bggm004
                  AND bggn005 = g_bggm_m.bggm005
                  AND bggn006 = g_bggm_m.bggm006
                  AND bggn007 = g_bggm_m.bggm007
                  AND bggnseq = g_bggn_d[g_detail_idx].bggnseq
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_bggn_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bggn_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abgt730_b_fill()
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
               LET gs_keys[01] = g_bggm_m.bggm001
               LET gs_keys[gs_keys.getLength()+1] = g_bggm_m.bggm002
               LET gs_keys[gs_keys.getLength()+1] = g_bggm_m.bggm003
               LET gs_keys[gs_keys.getLength()+1] = g_bggm_m.bggm004
               LET gs_keys[gs_keys.getLength()+1] = g_bggm_m.bggm005
               LET gs_keys[gs_keys.getLength()+1] = g_bggm_m.bggm006
               LET gs_keys[gs_keys.getLength()+1] = g_bggm_m.bggm007
 
               LET gs_keys[gs_keys.getLength()+1] = g_bggn_d_t.bggnseq
 
            
               #刪除同層單身
               IF NOT abgt730_delete_b('bggn_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abgt730_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT abgt730_key_delete_b(gs_keys,'bggn_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abgt730_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE abgt730_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_bggn_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bggn_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggnseq
            #add-point:BEFORE FIELD bggnseq name="input.b.page1.bggnseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggnseq
            
            #add-point:AFTER FIELD bggnseq name="input.a.page1.bggnseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bggm_m.bggm001 IS NOT NULL AND g_bggm_m.bggm002 IS NOT NULL AND g_bggm_m.bggm003 IS NOT NULL AND g_bggm_m.bggm004 IS NOT NULL AND g_bggm_m.bggm005 IS NOT NULL AND g_bggm_m.bggm006 IS NOT NULL AND g_bggm_m.bggm007 IS NOT NULL AND g_bggn_d[g_detail_idx].bggnseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bggm_m.bggm001 != g_bggm001_t OR g_bggm_m.bggm002 != g_bggm002_t OR g_bggm_m.bggm003 != g_bggm003_t OR g_bggm_m.bggm004 != g_bggm004_t OR g_bggm_m.bggm005 != g_bggm005_t OR g_bggm_m.bggm006 != g_bggm006_t OR g_bggm_m.bggm007 != g_bggm007_t OR g_bggn_d[g_detail_idx].bggnseq != g_bggn_d_t.bggnseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bggn_t WHERE "||"bggnent = " ||g_enterprise|| " AND "||"bggn001 = '"||g_bggm_m.bggm001 ||"' AND "|| "bggn002 = '"||g_bggm_m.bggm002 ||"' AND "|| "bggn003 = '"||g_bggm_m.bggm003 ||"' AND "|| "bggn004 = '"||g_bggm_m.bggm004 ||"' AND "|| "bggn005 = '"||g_bggm_m.bggm005 ||"' AND "|| "bggn006 = '"||g_bggm_m.bggm006 ||"' AND "|| "bggn007 = '"||g_bggm_m.bggm007 ||"' AND "|| "bggnseq = '"||g_bggn_d[g_detail_idx].bggnseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggnseq
            #add-point:ON CHANGE bggnseq name="input.g.page1.bggnseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn010
            
            #add-point:AFTER FIELD bggn010 name="input.a.page1.bggn010"
            #工資方案
            IF NOT cl_null(g_bggn_d[l_ac].bggn010) THEN
               IF g_bggn_d[l_ac].bggn010 != g_bggn_d_o.bggn010 OR cl_null(g_bggn_d_o.bggn010) THEN
                  #檢查是否存在abgi750
                  CALL s_abgt725_chk_bggc003(g_bggm_m.bggm002,g_bggm_m.bggm006,g_bggn_d[l_ac].bggn010)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bggn_d[l_ac].bggn010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn010 = g_bggn_d_o.bggn010
                     CALL s_desc_get_bggbl004_desc(g_bggn_d[l_ac].bggn010) RETURNING g_bggn_d[l_ac].bggn010_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn010_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            CALL s_desc_get_bggbl004_desc(g_bggn_d[l_ac].bggn010) RETURNING g_bggn_d[l_ac].bggn010_desc
            DISPLAY BY NAME g_bggn_d[l_ac].bggn010_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn010
            #add-point:BEFORE FIELD bggn010 name="input.b.page1.bggn010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn010
            #add-point:ON CHANGE bggn010 name="input.g.page1.bggn010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn011
            
            #add-point:AFTER FIELD bggn011 name="input.a.page1.bggn011"
            #職級
            IF NOT cl_null(g_bggn_d[l_ac].bggn011) THEN
               IF g_bggn_d[l_ac].bggn011 != g_bggn_d_o.bggn011 OR cl_null(g_bggn_d_o.bggn011) THEN
                  #檢查是否存在abgi710
                  CALL s_abgt725_chk_bgga002('abgi710',g_bggn_d[l_ac].bggn011)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bggn_d[l_ac].bggn011
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn011 = g_bggn_d_o.bggn011
                     CALL s_desc_get_bggal004_desc('abgi710',g_bggn_d[l_ac].bggn011) RETURNING g_bggn_d[l_ac].bggn011_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn011_desc
                     NEXT FIELD CURRENT
                  END IF                  
               END IF
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            CALL s_desc_get_bggal004_desc('abgi710',g_bggn_d[l_ac].bggn011) RETURNING g_bggn_d[l_ac].bggn011_desc
            DISPLAY BY NAME g_bggn_d[l_ac].bggn011_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn011
            #add-point:BEFORE FIELD bggn011 name="input.b.page1.bggn011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn011
            #add-point:ON CHANGE bggn011 name="input.g.page1.bggn011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn012
            
            #add-point:AFTER FIELD bggn012 name="input.a.page1.bggn012"
            #職等
            IF NOT cl_null(g_bggn_d[l_ac].bggn012) THEN
               IF g_bggn_d[l_ac].bggn012 != g_bggn_d_o.bggn012 OR cl_null(g_bggn_d_o.bggn012) THEN
                  #檢查是否存在abgi710
                  CALL s_abgt725_chk_bgga002('abgi720',g_bggn_d[l_ac].bggn012)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bggn_d[l_ac].bggn012
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn012 = g_bggn_d_o.bggn012
                     CALL s_desc_get_bggal004_desc('abgi720',g_bggn_d[l_ac].bggn012) RETURNING g_bggn_d[l_ac].bggn012_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn012_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            CALL s_desc_get_bggal004_desc('abgi720',g_bggn_d[l_ac].bggn012) RETURNING g_bggn_d[l_ac].bggn012_desc
            DISPLAY BY NAME g_bggn_d[l_ac].bggn012_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn012
            #add-point:BEFORE FIELD bggn012 name="input.b.page1.bggn012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn012
            #add-point:ON CHANGE bggn012 name="input.g.page1.bggn012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn013
            
            #add-point:AFTER FIELD bggn013 name="input.a.page1.bggn013"
            #用工屬性
            IF NOT cl_null(g_bggn_d[l_ac].bggn013) THEN
               IF g_bggn_d[l_ac].bggn013 != g_bggn_d_o.bggn013 OR cl_null(g_bggn_d_o.bggn013) THEN
                  #檢查是否存在abgi710
                  CALL s_abgt725_chk_bgga002('abgi730',g_bggn_d[l_ac].bggn013)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bggn_d[l_ac].bggn013
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn013 = g_bggn_d_o.bggn013
                     CALL s_desc_get_bggal004_desc('abgi730',g_bggn_d[l_ac].bggn013) RETURNING g_bggn_d[l_ac].bggn013_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn013_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            CALL s_desc_get_bggal004_desc('abgi730',g_bggn_d[l_ac].bggn013) RETURNING g_bggn_d[l_ac].bggn013_desc
            DISPLAY BY NAME g_bggn_d[l_ac].bggn013_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn013
            #add-point:BEFORE FIELD bggn013 name="input.b.page1.bggn013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn013
            #add-point:ON CHANGE bggn013 name="input.g.page1.bggn013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn014
            #add-point:BEFORE FIELD bggn014 name="input.b.page1.bggn014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn014
            
            #add-point:AFTER FIELD bggn014 name="input.a.page1.bggn014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn014
            #add-point:ON CHANGE bggn014 name="input.g.page1.bggn014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn014_desc
            #add-point:BEFORE FIELD bggn014_desc name="input.b.page1.bggn014_desc"
            LET g_bggn_d[l_ac].bggn014_desc = g_bggn_d[l_ac].bggn014
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn014_desc
            
            #add-point:AFTER FIELD bggn014_desc name="input.a.page1.bggn014_desc"
            #人員
            IF NOT cl_null(g_bggn_d[l_ac].bggn014_desc) THEN
               IF g_bggn_d[l_ac].bggn014_desc != g_bggn_d_o.bggn014_desc OR cl_null(g_bggn_d_o.bggn014_desc) THEN
                  LET g_bggn_d[l_ac].bggn014 = g_bggn_d[l_ac].bggn014_desc
                  
                  CALL s_employee_chk(g_bggn_d[l_ac].bggn014) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_bggn_d[l_ac].bggn014 = g_bggn_d_o.bggn014
                     LET g_bggn_d[l_ac].bggn014_desc = g_bggn_d_o.bggn014_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn014,g_bggn_d[l_ac].bggn014_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #部门归属法人必须等于预算组织归属法人
                  CALL s_abgt340_comp_chk(1,g_bggn_d[l_ac].bggn014,g_bggm_m.bggm006)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bggn_d[l_ac].bggn014
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn014 = g_bggn_d_o.bggn014
                     LET g_bggn_d[l_ac].bggn014_desc = g_bggn_d_o.bggn014_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn014,g_bggn_d[l_ac].bggn014_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bggn_d[l_ac].bggn014 = ''
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            
            CALL s_desc_get_person_desc(g_bggn_d[l_ac].bggn014) RETURNING g_bggn_d[l_ac].bggn014_desc
            LET g_bggn_d[l_ac].bggn014_desc = s_desc_show1(g_bggn_d[l_ac].bggn014,g_bggn_d[l_ac].bggn014_desc)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn014_desc
            #add-point:ON CHANGE bggn014_desc name="input.g.page1.bggn014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn015
            #add-point:BEFORE FIELD bggn015 name="input.b.page1.bggn015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn015
            
            #add-point:AFTER FIELD bggn015 name="input.a.page1.bggn015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn015
            #add-point:ON CHANGE bggn015 name="input.g.page1.bggn015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn015_desc
            #add-point:BEFORE FIELD bggn015_desc name="input.b.page1.bggn015_desc"
            LET g_bggn_d[l_ac].bggn015_desc = g_bggn_d[l_ac].bggn015
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn015_desc
            
            #add-point:AFTER FIELD bggn015_desc name="input.a.page1.bggn015_desc"
            #部門
            IF NOT cl_null(g_bggn_d[l_ac].bggn015_desc) THEN
               IF g_bggn_d[l_ac].bggn015_desc != g_bggn_d_o.bggn015_desc OR cl_null(g_bggn_d_o.bggn015_desc) THEN
                  LET g_bggn_d[l_ac].bggn015 = g_bggn_d[l_ac].bggn015_desc
                  #部门基础资料检核
                  CALL s_department_chk(g_bggn_d[l_ac].bggn015,g_today) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_bggn_d[l_ac].bggn015 = g_bggn_d_o.bggn015
                     LET g_bggn_d[l_ac].bggn015_desc = g_bggn_d_o.bggn015_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn015,g_bggn_d[l_ac].bggn015_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #部门归属法人必须等于预算组织归属法人
                  CALL s_abgt340_comp_chk(2,g_bggn_d[l_ac].bggn015,g_bggm_m.bggm006)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bggn_d[l_ac].bggn015
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn015 = g_bggn_d_o.bggn015
                     LET g_bggn_d[l_ac].bggn015_desc = g_bggn_d_o.bggn015_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn015,g_bggn_d[l_ac].bggn015_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bggn_d[l_ac].bggn015 = ''
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            
            #抓取部门对应利润中心
            IF cl_null(g_bggn_d[l_ac].bggn016) THEN
               SELECT ooeg004 INTO g_bggn_d[l_ac].bggn016
                 FROM ooeg_t
                WHERE ooegent = g_enterprise AND ooeg001 = g_bggn_d[l_ac].bggn015
               CALL s_desc_get_department_desc(g_bggn_d[l_ac].bggn016) RETURNING g_bggn_d[l_ac].bggn016_desc
               LET g_bggn_d[l_ac].bggn016_desc = s_desc_show1(g_bggn_d[l_ac].bggn016,g_bggn_d[l_ac].bggn016_desc)
            END IF
            
            CALL s_desc_get_department_desc(g_bggn_d[l_ac].bggn015) RETURNING g_bggn_d[l_ac].bggn015_desc
            LET g_bggn_d[l_ac].bggn015_desc = s_desc_show1(g_bggn_d[l_ac].bggn015,g_bggn_d[l_ac].bggn015_desc)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn015_desc
            #add-point:ON CHANGE bggn015_desc name="input.g.page1.bggn015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn016
            #add-point:BEFORE FIELD bggn016 name="input.b.page1.bggn016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn016
            
            #add-point:AFTER FIELD bggn016 name="input.a.page1.bggn016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn016
            #add-point:ON CHANGE bggn016 name="input.g.page1.bggn016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn016_desc
            #add-point:BEFORE FIELD bggn016_desc name="input.b.page1.bggn016_desc"
            LET g_bggn_d[l_ac].bggn016_desc = g_bggn_d[l_ac].bggn016
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn016_desc
            
            #add-point:AFTER FIELD bggn016_desc name="input.a.page1.bggn016_desc"
            #成本利潤中心
            IF NOT cl_null(g_bggn_d[l_ac].bggn016_desc) THEN
               IF g_bggn_d[l_ac].bggn016_desc != g_bggn_d_o.bggn016_desc OR cl_null(g_bggn_d_o.bggn016_desc) THEN
                  LET g_bggn_d[l_ac].bggn016 = g_bggn_d[l_ac].bggn016_desc
                  #利润成本中心资料检核
                  CALL s_voucher_glaq019_chk(g_bggn_d[l_ac].bggn016,g_today) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bggn_d[l_ac].bggn016
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn016 = g_bggn_d_o.bggn016
                     LET g_bggn_d[l_ac].bggn016_desc = g_bggn_d_o.bggn016_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn016,g_bggn_d[l_ac].bggn016_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #部门归属法人必须等于预算组织归属法人
                  CALL s_abgt340_comp_chk(2,g_bggn_d[l_ac].bggn016,g_bggm_m.bggm006)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bggn_d[l_ac].bggn016
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn016 = g_bggn_d_o.bggn016
                     LET g_bggn_d[l_ac].bggn016_desc = g_bggn_d_o.bggn016_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn016,g_bggn_d[l_ac].bggn016_desc
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
            ELSE
               LET g_bggn_d[l_ac].bggn016 = ''
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            
            CALL s_desc_get_department_desc(g_bggn_d[l_ac].bggn016) RETURNING g_bggn_d[l_ac].bggn016_desc
            LET g_bggn_d[l_ac].bggn016_desc = s_desc_show1(g_bggn_d[l_ac].bggn016,g_bggn_d[l_ac].bggn016_desc)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn016_desc
            #add-point:ON CHANGE bggn016_desc name="input.g.page1.bggn016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn017
            #add-point:BEFORE FIELD bggn017 name="input.b.page1.bggn017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn017
            
            #add-point:AFTER FIELD bggn017 name="input.a.page1.bggn017"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn017
            #add-point:ON CHANGE bggn017 name="input.g.page1.bggn017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn017_desc
            #add-point:BEFORE FIELD bggn017_desc name="input.b.page1.bggn017_desc"
            LET g_bggn_d[l_ac].bggn017_desc = g_bggn_d[l_ac].bggn017
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn017_desc
            
            #add-point:AFTER FIELD bggn017_desc name="input.a.page1.bggn017_desc"
            #區域
            IF NOT cl_null(g_bggn_d[l_ac].bggn017_desc) THEN
               IF g_bggn_d[l_ac].bggn017_desc != g_bggn_d_o.bggn017_desc OR cl_null(g_bggn_d_o.bggn017_desc) THEN
                  LET g_bggn_d[l_ac].bggn017 = g_bggn_d[l_ac].bggn017_desc
                  IF NOT s_azzi650_chk_exist('287',g_bggn_d[l_ac].bggn017) THEN
                     LET g_bggn_d[l_ac].bggn017 = g_bggn_d_o.bggn017
                     LET g_bggn_d[l_ac].bggn017_desc = g_bggn_d_o.bggn017_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn017,g_bggn_d[l_ac].bggn017_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bggn_d[l_ac].bggn017 = ''
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            
            CALL s_desc_get_acc_desc('287',g_bggn_d[l_ac].bggn017) RETURNING g_bggn_d[l_ac].bggn017_desc
            LET g_bggn_d[l_ac].bggn017_desc = s_desc_show1(g_bggn_d[l_ac].bggn017,g_bggn_d[l_ac].bggn017_desc)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn017_desc
            #add-point:ON CHANGE bggn017_desc name="input.g.page1.bggn017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn018
            #add-point:BEFORE FIELD bggn018 name="input.b.page1.bggn018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn018
            
            #add-point:AFTER FIELD bggn018 name="input.a.page1.bggn018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn018
            #add-point:ON CHANGE bggn018 name="input.g.page1.bggn018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn018_desc
            #add-point:BEFORE FIELD bggn018_desc name="input.b.page1.bggn018_desc"
            LET g_bggn_d[l_ac].bggn018_desc = g_bggn_d[l_ac].bggn018
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn018_desc
            
            #add-point:AFTER FIELD bggn018_desc name="input.a.page1.bggn018_desc"
            #收付款客商
            IF NOT cl_null(g_bggn_d[l_ac].bggn018_desc) THEN
               IF g_bggn_d[l_ac].bggn018_desc != g_bggn_d_o.bggn018_desc OR cl_null(g_bggn_d_o.bggn018_desc) THEN
                  LET g_bggn_d[l_ac].bggn018 = g_bggn_d[l_ac].bggn018_desc
                  CALL s_abg2_bgap001_chk(g_bggn_d[l_ac].bggn018,g_bggm_m.bggm006)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bggn_d[l_ac].bggn018
                     LET g_errparam.replace[1] = 'abgi150'
                     LET g_errparam.replace[2] = cl_get_progname('abgi150',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn018 = g_bggn_d_o.bggn018
                     LET g_bggn_d[l_ac].bggn018_desc = g_bggn_d_o.bggn018_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn018,g_bggn_d[l_ac].bggn018_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bggn_d[l_ac].bggn018 = ''
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            
            CALL s_desc_get_bgap001_desc(g_bggn_d[l_ac].bggn018) RETURNING g_bggn_d[l_ac].bggn018_desc
            LET g_bggn_d[l_ac].bggn018_desc = s_desc_show1(g_bggn_d[l_ac].bggn018,g_bggn_d[l_ac].bggn018_desc)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn018_desc
            #add-point:ON CHANGE bggn018_desc name="input.g.page1.bggn018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn019
            #add-point:BEFORE FIELD bggn019 name="input.b.page1.bggn019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn019
            
            #add-point:AFTER FIELD bggn019 name="input.a.page1.bggn019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn019
            #add-point:ON CHANGE bggn019 name="input.g.page1.bggn019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn019_desc
            #add-point:BEFORE FIELD bggn019_desc name="input.b.page1.bggn019_desc"
            LET g_bggn_d[l_ac].bggn019_desc = g_bggn_d[l_ac].bggn019
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn019_desc
            
            #add-point:AFTER FIELD bggn019_desc name="input.a.page1.bggn019_desc"
            #收款客商
            IF NOT cl_null(g_bggn_d[l_ac].bggn019_desc) THEN
               IF g_bggn_d[l_ac].bggn019_desc != g_bggn_d_o.bggn019_desc OR cl_null(g_bggn_d_o.bggn019_desc) THEN
                  LET g_bggn_d[l_ac].bggn019 = g_bggn_d[l_ac].bggn019_desc
                  CALL s_abg2_bgap001_chk(g_bggn_d[l_ac].bggn019,g_bggm_m.bggm006)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bggn_d[l_ac].bggn019
                     LET g_errparam.replace[1] = 'abgi150'
                     LET g_errparam.replace[2] = cl_get_progname('abgi150',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn019 = g_bggn_d_o.bggn019
                     LET g_bggn_d[l_ac].bggn019_desc = g_bggn_d_o.bggn019_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn019,g_bggn_d[l_ac].bggn019_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bggn_d[l_ac].bggn019 = ''
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            
            CALL s_desc_get_bgap001_desc(g_bggn_d[l_ac].bggn019) RETURNING g_bggn_d[l_ac].bggn019_desc
            LET g_bggn_d[l_ac].bggn019_desc = s_desc_show1(g_bggn_d[l_ac].bggn019,g_bggn_d[l_ac].bggn019_desc)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn019_desc
            #add-point:ON CHANGE bggn019_desc name="input.g.page1.bggn019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn020
            #add-point:BEFORE FIELD bggn020 name="input.b.page1.bggn020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn020
            
            #add-point:AFTER FIELD bggn020 name="input.a.page1.bggn020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn020
            #add-point:ON CHANGE bggn020 name="input.g.page1.bggn020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn020_desc
            #add-point:BEFORE FIELD bggn020_desc name="input.b.page1.bggn020_desc"
            LET g_bggn_d[l_ac].bggn020_desc = g_bggn_d[l_ac].bggn020
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn020_desc
            
            #add-point:AFTER FIELD bggn020_desc name="input.a.page1.bggn020_desc"
            #客群
            IF NOT cl_null(g_bggn_d[l_ac].bggn020_desc) THEN
               IF g_bggn_d[l_ac].bggn020_desc != g_bggn_d_o.bggn020_desc OR cl_null(g_bggn_d_o.bggn020_desc) THEN
                  LET g_bggn_d[l_ac].bggn020 = g_bggn_d[l_ac].bggn020_desc
                  IF NOT s_azzi650_chk_exist('281',g_bggn_d[l_ac].bggn020) THEN
                     LET g_bggn_d[l_ac].bggn020 = g_bggn_d_o.bggn020
                     LET g_bggn_d[l_ac].bggn020_desc = g_bggn_d_o.bggn020_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn020,g_bggn_d[l_ac].bggn020_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bggn_d[l_ac].bggn020 = ''
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            
            CALL s_desc_get_acc_desc('281',g_bggn_d[l_ac].bggn020) RETURNING g_bggn_d[l_ac].bggn020_desc
            LET g_bggn_d[l_ac].bggn020_desc = s_desc_show1(g_bggn_d[l_ac].bggn020,g_bggn_d[l_ac].bggn020_desc)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn020_desc
            #add-point:ON CHANGE bggn020_desc name="input.g.page1.bggn020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn021
            #add-point:BEFORE FIELD bggn021 name="input.b.page1.bggn021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn021
            
            #add-point:AFTER FIELD bggn021 name="input.a.page1.bggn021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn021
            #add-point:ON CHANGE bggn021 name="input.g.page1.bggn021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn021_desc
            #add-point:BEFORE FIELD bggn021_desc name="input.b.page1.bggn021_desc"
            LET g_bggn_d[l_ac].bggn021_desc = g_bggn_d[l_ac].bggn021
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn021_desc
            
            #add-point:AFTER FIELD bggn021_desc name="input.a.page1.bggn021_desc"
            #產品類別
            IF NOT cl_null(g_bggn_d[l_ac].bggn021_desc) THEN
               IF g_bggn_d[l_ac].bggn021_desc != g_bggn_d_o.bggn021_desc OR cl_null(g_bggn_d_o.bggn021_desc) THEN
                  LET g_bggn_d[l_ac].bggn021 = g_bggn_d[l_ac].bggn021_desc
                  CALL s_voucher_glaq024_chk(g_bggn_d[l_ac].bggn021) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_bggn_d[l_ac].bggn021
                     LET g_errparam.code   = g_errno
                     LET g_errparam.replace[1] = 'arti202'
                     LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                     LET g_errparam.exeprog = 'arti202'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn021 = g_bggn_d_o.bggn021
                     LET g_bggn_d[l_ac].bggn021_desc = g_bggn_d_o.bggn021_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn021,g_bggn_d[l_ac].bggn021_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bggn_d[l_ac].bggn021 = ''
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            
            CALL s_desc_get_rtaxl003_desc(g_bggn_d[l_ac].bggn021) RETURNING g_bggn_d[l_ac].bggn021_desc
            LET g_bggn_d[l_ac].bggn021_desc = s_desc_show1(g_bggn_d[l_ac].bggn021,g_bggn_d[l_ac].bggn021_desc)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn021_desc
            #add-point:ON CHANGE bggn021_desc name="input.g.page1.bggn021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn022
            #add-point:BEFORE FIELD bggn022 name="input.b.page1.bggn022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn022
            
            #add-point:AFTER FIELD bggn022 name="input.a.page1.bggn022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn022
            #add-point:ON CHANGE bggn022 name="input.g.page1.bggn022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn022_desc
            #add-point:BEFORE FIELD bggn022_desc name="input.b.page1.bggn022_desc"
            LET g_bggn_d[l_ac].bggn022_desc = g_bggn_d[l_ac].bggn022
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn022_desc
            
            #add-point:AFTER FIELD bggn022_desc name="input.a.page1.bggn022_desc"
            #專案編號
            IF NOT cl_null(g_bggn_d[l_ac].bggn022_desc) THEN
               IF g_bggn_d[l_ac].bggn022_desc != g_bggn_d_o.bggn022_desc OR cl_null(g_bggn_d_o.bggn022_desc) THEN
                  LET g_bggn_d[l_ac].bggn022 = g_bggn_d[l_ac].bggn022_desc
                  CALL s_aap_project_chk(g_bggn_d[l_ac].bggn022) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                      INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bggn_d[l_ac].bggn022
                     LET g_errparam.replace[1] = 'apjm200'
                     LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                     LET g_errparam.exeprog = 'apjm200'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn022 = g_bggn_d_o.bggn022
                     LET g_bggn_d[l_ac].bggn022_desc = g_bggn_d_o.bggn022_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn022,g_bggn_d[l_ac].bggn022_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bggn_d[l_ac].bggn022 = ''
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            
            CALL s_desc_get_project_desc(g_bggn_d[l_ac].bggn022) RETURNING g_bggn_d[l_ac].bggn022_desc
            LET g_bggn_d[l_ac].bggn022_desc = s_desc_show1(g_bggn_d[l_ac].bggn022,g_bggn_d[l_ac].bggn022_desc)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn022_desc
            #add-point:ON CHANGE bggn022_desc name="input.g.page1.bggn022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn023
            #add-point:BEFORE FIELD bggn023 name="input.b.page1.bggn023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn023
            
            #add-point:AFTER FIELD bggn023 name="input.a.page1.bggn023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn023
            #add-point:ON CHANGE bggn023 name="input.g.page1.bggn023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn023_desc
            #add-point:BEFORE FIELD bggn023_desc name="input.b.page1.bggn023_desc"
            LET g_bggn_d[l_ac].bggn023_desc = g_bggn_d[l_ac].bggn023
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn023_desc
            
            #add-point:AFTER FIELD bggn023_desc name="input.a.page1.bggn023_desc"
            #WBS
            IF NOT cl_null(g_bggn_d[l_ac].bggn023_desc) THEN
               IF g_bggn_d[l_ac].bggn023_desc != g_bggn_d_o.bggn023_desc OR cl_null(g_bggn_d_o.bggn023_desc) THEN
                  LET g_bggn_d[l_ac].bggn023 = g_bggn_d[l_ac].bggn023_desc
                  CALL s_voucher_glaq028_chk(g_bggn_d[l_ac].bggn022,g_bggn_d[l_ac].bggn023)
                  IF NOT cl_null(g_errno) THEN
                      INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn023 = g_bggn_d_o.bggn023
                     LET g_bggn_d[l_ac].bggn023_desc = g_bggn_d_o.bggn023_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn023,g_bggn_d[l_ac].bggn023_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bggn_d[l_ac].bggn023 = ''
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            
            CALL s_desc_get_wbs_desc(g_bggn_d[l_ac].bggn022,g_bggn_d[l_ac].bggn023) RETURNING g_bggn_d[l_ac].bggn023_desc
            LET g_bggn_d[l_ac].bggn023_desc = s_desc_show1(g_bggn_d[l_ac].bggn023,g_bggn_d[l_ac].bggn023_desc)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn023_desc
            #add-point:ON CHANGE bggn023_desc name="input.g.page1.bggn023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn024
            #add-point:BEFORE FIELD bggn024 name="input.b.page1.bggn024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn024
            
            #add-point:AFTER FIELD bggn024 name="input.a.page1.bggn024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn024
            #add-point:ON CHANGE bggn024 name="input.g.page1.bggn024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn024_desc
            #add-point:BEFORE FIELD bggn024_desc name="input.b.page1.bggn024_desc"
            LET g_bggn_d[l_ac].bggn024_desc = g_bggn_d[l_ac].bggn024
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn024_desc
            
            #add-point:AFTER FIELD bggn024_desc name="input.a.page1.bggn024_desc"
            #經營方式
            IF NOT cl_null(g_bggn_d[l_ac].bggn024_desc) THEN
               IF g_bggn_d[l_ac].bggn024_desc != g_bggn_d_o.bggn024_desc OR cl_null(g_bggn_d_o.bggn024_desc) THEN
                  LET g_bggn_d[l_ac].bggn024 = g_bggn_d[l_ac].bggn024_desc
                  CALL s_voucher_glaq051_chk(g_bggn_d[l_ac].bggn024) 
                  IF NOT g_sub_success THEN
                      INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn024 = g_bggn_d_o.bggn024
                     LET g_bggn_d[l_ac].bggn024_desc = g_bggn_d_o.bggn024_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn024,g_bggn_d[l_ac].bggn024_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bggn_d[l_ac].bggn024 = ''
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn024_desc
            #add-point:ON CHANGE bggn024_desc name="input.g.page1.bggn024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn025
            #add-point:BEFORE FIELD bggn025 name="input.b.page1.bggn025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn025
            
            #add-point:AFTER FIELD bggn025 name="input.a.page1.bggn025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn025
            #add-point:ON CHANGE bggn025 name="input.g.page1.bggn025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn025_desc
            #add-point:BEFORE FIELD bggn025_desc name="input.b.page1.bggn025_desc"
            LET g_bggn_d[l_ac].bggn025_desc = g_bggn_d[l_ac].bggn025
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn025_desc
            
            #add-point:AFTER FIELD bggn025_desc name="input.a.page1.bggn025_desc"
            #通路
            IF NOT cl_null(g_bggn_d[l_ac].bggn025_desc) THEN
               IF g_bggn_d[l_ac].bggn025_desc != g_bggn_d_o.bggn025_desc OR cl_null(g_bggn_d_o.bggn025_desc) THEN
                  LET g_bggn_d[l_ac].bggn025 = g_bggn_d[l_ac].bggn025_desc
                  CALL s_voucher_glaq052_chk(g_bggn_d[l_ac].bggn025)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn_d[l_ac].bggn025 = g_bggn_d_o.bggn025
                     LET g_bggn_d[l_ac].bggn025_desc = g_bggn_d_o.bggn025_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn025,g_bggn_d[l_ac].bggn025_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bggn_d[l_ac].bggn025 = ''
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*
            
            CALL s_desc_get_oojdl003_desc(g_bggn_d[l_ac].bggn025) RETURNING g_bggn_d[l_ac].bggn025_desc
            LET g_bggn_d[l_ac].bggn025_desc = s_desc_show1(g_bggn_d[l_ac].bggn025,g_bggn_d[l_ac].bggn025_desc)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn025_desc
            #add-point:ON CHANGE bggn025_desc name="input.g.page1.bggn025_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn026
            #add-point:BEFORE FIELD bggn026 name="input.b.page1.bggn026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn026
            
            #add-point:AFTER FIELD bggn026 name="input.a.page1.bggn026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn026
            #add-point:ON CHANGE bggn026 name="input.g.page1.bggn026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn026_desc
            #add-point:BEFORE FIELD bggn026_desc name="input.b.page1.bggn026_desc"
            LET g_bggn_d[l_ac].bggn026_desc = g_bggn_d[l_ac].bggn026
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn026_desc
            
            #add-point:AFTER FIELD bggn026_desc name="input.a.page1.bggn026_desc"
            #品牌
            IF NOT cl_null(g_bggn_d[l_ac].bggn026_desc) THEN
               IF g_bggn_d[l_ac].bggn026_desc != g_bggn_d_o.bggn026_desc OR cl_null(g_bggn_d_o.bggn026_desc) THEN
                  LET g_bggn_d[l_ac].bggn026 = g_bggn_d[l_ac].bggn026_desc
                  IF NOT s_azzi650_chk_exist('2002',g_bggn_d[l_ac].bggn026) THEN
                     LET g_bggn_d[l_ac].bggn026 = g_bggn_d_o.bggn026
                     LET g_bggn_d[l_ac].bggn026_desc = g_bggn_d_o.bggn026_desc
                     DISPLAY BY NAME g_bggn_d[l_ac].bggn026,g_bggn_d[l_ac].bggn026_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bggn_d[l_ac].bggn026 = ''
            END IF
            LET g_bggn_d_o.* = g_bggn_d[l_ac].*

            CALL s_desc_get_acc_desc('2002',g_bggn_d[l_ac].bggn026) RETURNING g_bggn_d[l_ac].bggn026_desc
            LET g_bggn_d[l_ac].bggn026_desc = s_desc_show1(g_bggn_d[l_ac].bggn026,g_bggn_d[l_ac].bggn026_desc)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn026_desc
            #add-point:ON CHANGE bggn026_desc name="input.g.page1.bggn026_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggn038
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bggn_d[l_ac].bggn038,"0","0","","","azz-00079",1) THEN
               NEXT FIELD bggn038
            END IF 
 
 
 
            #add-point:AFTER FIELD bggn038 name="input.a.page1.bggn038"
            IF NOT cl_null(g_bggn_d[l_ac].bggn038) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggn038
            #add-point:BEFORE FIELD bggn038 name="input.b.page1.bggn038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggn038
            #add-point:ON CHANGE bggn038 name="input.g.page1.bggn038"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bggnseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggnseq
            #add-point:ON ACTION controlp INFIELD bggnseq name="input.c.page1.bggnseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn010
            #add-point:ON ACTION controlp INFIELD bggn010 name="input.c.page1.bggn010"
            #工資方案
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn010
            LET g_qryparam.where = " bggc001 = '",g_bggm_m.bggm002,"' AND bggc002 = '",g_bggm_m.bggm006,"'"
            CALL q_bggc003()
            LET g_bggn_d[l_ac].bggn010 = g_qryparam.return1
            DISPLAY g_bggn_d[l_ac].bggn010 TO bggn010
            NEXT FIELD bggn010
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn011
            #add-point:ON ACTION controlp INFIELD bggn011 name="input.c.page1.bggn011"
            #職級
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn011
            LET g_qryparam.arg1 = 'abgi710'
            LET g_qryparam.where = " bggastus='Y' "
            CALL q_bgga002()
            LET g_bggn_d[l_ac].bggn011 = g_qryparam.return1
            DISPLAY g_bggn_d[l_ac].bggn011 TO bggn011
            NEXT FIELD bggn011
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn012
            #add-point:ON ACTION controlp INFIELD bggn012 name="input.c.page1.bggn012"
            #職等
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn012
            LET g_qryparam.arg1 = 'abgi720'
            LET g_qryparam.where = " bggastus='Y' "
            CALL q_bgga002()
            LET g_bggn_d[l_ac].bggn012 = g_qryparam.return1
            DISPLAY g_bggn_d[l_ac].bggn012 TO bggn012
            NEXT FIELD bggn012
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn013
            #add-point:ON ACTION controlp INFIELD bggn013 name="input.c.page1.bggn013"
            #用工屬性
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn013
            LET g_qryparam.arg1 = 'abgi730'
            LET g_qryparam.where = " bggastus='Y' "
            CALL q_bgga002()
            LET g_bggn_d[l_ac].bggn013 = g_qryparam.return1
            DISPLAY g_bggn_d[l_ac].bggn013 TO bggn013
            NEXT FIELD bggn013
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn014
            #add-point:ON ACTION controlp INFIELD bggn014 name="input.c.page1.bggn014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn014_desc
            #add-point:ON ACTION controlp INFIELD bggn014_desc name="input.c.page1.bggn014_desc"
            #人員
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn014_desc
            LET g_qryparam.where = " ooag004 IN (SELECT ooef001 FROM ooef_t ",
                                   "              WHERE ooefent=",g_enterprise,
                                   "                AND ooef017='",g_comp,"' ",
                                   "             )"
            CALL q_ooag001_8()
            LET g_bggn_d[l_ac].bggn014 = g_qryparam.return1
            LET g_bggn_d[l_ac].bggn014_desc = g_qryparam.return1
            DISPLAY BY NAME g_bggn_d[l_ac].bggn014,g_bggn_d[l_ac].bggn014_desc
            NEXT FIELD bggn014_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn015
            #add-point:ON ACTION controlp INFIELD bggn015 name="input.c.page1.bggn015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn015_desc
            #add-point:ON ACTION controlp INFIELD bggn015_desc name="input.c.page1.bggn015_desc"
            #部門
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn015_desc
            LET g_qryparam.arg1 = g_today
            LET g_qryparam.where = " ooeg009='",g_comp,"' "
            CALL q_ooeg001_13()
            LET g_bggn_d[l_ac].bggn015 = g_qryparam.return1
            LET g_bggn_d[l_ac].bggn015_desc = g_qryparam.return1
            DISPLAY BY NAME g_bggn_d[l_ac].bggn015,g_bggn_d[l_ac].bggn015_desc
            NEXT FIELD bggn015_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn016
            #add-point:ON ACTION controlp INFIELD bggn016 name="input.c.page1.bggn016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn016_desc
            #add-point:ON ACTION controlp INFIELD bggn016_desc name="input.c.page1.bggn016_desc"
            #成本利潤中心
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn016_desc
            LET g_qryparam.arg1 = g_today
            LET g_qryparam.where = " ooeg009='",g_comp,"' "
            CALL q_ooeg001_10()
            LET g_bggn_d[l_ac].bggn016 = g_qryparam.return1
            LET g_bggn_d[l_ac].bggn016_desc = g_qryparam.return1
            DISPLAY BY NAME g_bggn_d[l_ac].bggn016,g_bggn_d[l_ac].bggn016_desc
            NEXT FIELD bggn016_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn017
            #add-point:ON ACTION controlp INFIELD bggn017 name="input.c.page1.bggn017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn017_desc
            #add-point:ON ACTION controlp INFIELD bggn017_desc name="input.c.page1.bggn017_desc"
            #區域
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn017_desc
            CALL q_oocq002_287()
            LET g_bggn_d[l_ac].bggn017 = g_qryparam.return1
            LET g_bggn_d[l_ac].bggn017_desc = g_qryparam.return1
            DISPLAY BY NAME g_bggn_d[l_ac].bggn017,g_bggn_d[l_ac].bggn017_desc
            NEXT FIELD bggn017_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn018
            #add-point:ON ACTION controlp INFIELD bggn018 name="input.c.page1.bggn018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn018_desc
            #add-point:ON ACTION controlp INFIELD bggn018_desc name="input.c.page1.bggn018_desc"
            #收付款客商
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn018_desc
            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus='Y'",
                                   " AND bgap001 IN (SELECT bgaq001 FROM bgaq_t",
                                   "                  WHERE bgaqent=",g_enterprise,
                                   "                    AND bgaqsite='",g_bggm_m.bggm006,"')"
            CALL q_bgap001()
            LET g_bggn_d[l_ac].bggn018 = g_qryparam.return1
            LET g_bggn_d[l_ac].bggn018_desc = g_qryparam.return1
            DISPLAY BY NAME g_bggn_d[l_ac].bggn018,g_bggn_d[l_ac].bggn018_desc
            NEXT FIELD bggn018_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn019
            #add-point:ON ACTION controlp INFIELD bggn019 name="input.c.page1.bggn019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn019_desc
            #add-point:ON ACTION controlp INFIELD bggn019_desc name="input.c.page1.bggn019_desc"
            #收款客商
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn019_desc
            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus='Y'",
                                   " AND bgap001 IN (SELECT bgaq001 FROM bgaq_t",
                                   "                  WHERE bgaqent=",g_enterprise,
                                   "                    AND bgaqsite='",g_bggm_m.bggm006,"')"
            CALL q_bgap001()
            LET g_bggn_d[l_ac].bggn019 = g_qryparam.return1
            LET g_bggn_d[l_ac].bggn019_desc = g_qryparam.return1
            DISPLAY BY NAME g_bggn_d[l_ac].bggn019,g_bggn_d[l_ac].bggn019_desc
            NEXT FIELD bggn019_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn020
            #add-point:ON ACTION controlp INFIELD bggn020 name="input.c.page1.bggn020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn020_desc
            #add-point:ON ACTION controlp INFIELD bggn020_desc name="input.c.page1.bggn020_desc"
            #客群
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn020_desc
            CALL q_oocq002_281()
            LET g_bggn_d[l_ac].bggn020 = g_qryparam.return1
            LET g_bggn_d[l_ac].bggn020_desc = g_qryparam.return1
            DISPLAY BY NAME g_bggn_d[l_ac].bggn020,g_bggn_d[l_ac].bggn020_desc
            NEXT FIELD bggn020_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn021
            #add-point:ON ACTION controlp INFIELD bggn021 name="input.c.page1.bggn021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn021_desc
            #add-point:ON ACTION controlp INFIELD bggn021_desc name="input.c.page1.bggn021_desc"
            #產品類別
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn021_desc
            LET g_qryparam.where = " rtax004='",g_ooaa002,"'"
            CALL q_rtax001_1()
            LET g_bggn_d[l_ac].bggn021 = g_qryparam.return1
            LET g_bggn_d[l_ac].bggn021_desc = g_qryparam.return1
            DISPLAY BY NAME g_bggn_d[l_ac].bggn021,g_bggn_d[l_ac].bggn021_desc
            NEXT FIELD bggn021_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn022
            #add-point:ON ACTION controlp INFIELD bggn022 name="input.c.page1.bggn022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn022_desc
            #add-point:ON ACTION controlp INFIELD bggn022_desc name="input.c.page1.bggn022_desc"
            #專案編號
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn022_desc
            CALL q_pjba001()
            LET g_bggn_d[l_ac].bggn022 = g_qryparam.return1
            LET g_bggn_d[l_ac].bggn022_desc = g_qryparam.return1
            DISPLAY BY NAME g_bggn_d[l_ac].bggn022,g_bggn_d[l_ac].bggn022_desc
            NEXT FIELD bggn022_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn023
            #add-point:ON ACTION controlp INFIELD bggn023 name="input.c.page1.bggn023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn023_desc
            #add-point:ON ACTION controlp INFIELD bggn023_desc name="input.c.page1.bggn023_desc"
            #WBS
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn023_desc
            IF NOT cl_null(g_bggn_d[l_ac].bggn022) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_bggn_d[l_ac].bggn022,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            CALL q_pjbb002()
            LET g_bggn_d[l_ac].bggn023 = g_qryparam.return1
            LET g_bggn_d[l_ac].bggn023_desc = g_qryparam.return1
            DISPLAY BY NAME g_bggn_d[l_ac].bggn023,g_bggn_d[l_ac].bggn023_desc
            NEXT FIELD bggn023_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn024
            #add-point:ON ACTION controlp INFIELD bggn024 name="input.c.page1.bggn024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn024_desc
            #add-point:ON ACTION controlp INFIELD bggn024_desc name="input.c.page1.bggn024_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn025
            #add-point:ON ACTION controlp INFIELD bggn025 name="input.c.page1.bggn025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn025_desc
            #add-point:ON ACTION controlp INFIELD bggn025_desc name="input.c.page1.bggn025_desc"
			   #通路
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn025_desc
            CALL q_oojd001_2()
            LET g_bggn_d[l_ac].bggn025 = g_qryparam.return1
            LET g_bggn_d[l_ac].bggn025_desc = g_qryparam.return1
            DISPLAY BY NAME g_bggn_d[l_ac].bggn025,g_bggn_d[l_ac].bggn025_desc
            NEXT FIELD bggn025_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn026
            #add-point:ON ACTION controlp INFIELD bggn026 name="input.c.page1.bggn026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn026_desc
            #add-point:ON ACTION controlp INFIELD bggn026_desc name="input.c.page1.bggn026_desc"
            #品牌
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn_d[l_ac].bggn026_desc
            CALL q_oocq002_2002()
            LET g_bggn_d[l_ac].bggn026 = g_qryparam.return1
            LET g_bggn_d[l_ac].bggn026_desc = g_qryparam.return1
            DISPLAY BY NAME g_bggn_d[l_ac].bggn026,g_bggn_d[l_ac].bggn026_desc
            NEXT FIELD bggn026_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggn038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggn038
            #add-point:ON ACTION controlp INFIELD bggn038 name="input.c.page1.bggn038"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bggn_d[l_ac].* = g_bggn_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abgt730_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_bggn_d[l_ac].bggnseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_bggn_d[l_ac].* = g_bggn_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               #檢查用工人數單身(bggn_t)核算項組合不可重複
               LET l_bggn.bggn001 = g_bggm_m.bggm001
               LET l_bggn.bggn002 = g_bggm_m.bggm002
               LET l_bggn.bggn003 = g_bggm_m.bggm003
               LET l_bggn.bggn004 = g_bggm_m.bggm004
               LET l_bggn.bggn005 = g_bggm_m.bggm005
               LET l_bggn.bggn006 = g_bggm_m.bggm006
               LET l_bggn.bggn007 = g_bggm_m.bggm007
               LET l_bggn.bggnseq = g_bggn_d[l_ac].bggnseq
               LET l_bggn.bggn010 = g_bggn_d[l_ac].bggn010
               LET l_bggn.bggn011 = g_bggn_d[l_ac].bggn011
               LET l_bggn.bggn012 = g_bggn_d[l_ac].bggn012
               LET l_bggn.bggn013 = g_bggn_d[l_ac].bggn013
               LET l_bggn.bggn014 = g_bggn_d[l_ac].bggn014
               LET l_bggn.bggn015 = g_bggn_d[l_ac].bggn015
               LET l_bggn.bggn016 = g_bggn_d[l_ac].bggn016
               LET l_bggn.bggn017 = g_bggn_d[l_ac].bggn017
               LET l_bggn.bggn018 = g_bggn_d[l_ac].bggn018
               LET l_bggn.bggn019 = g_bggn_d[l_ac].bggn019
               LET l_bggn.bggn020 = g_bggn_d[l_ac].bggn020
               LET l_bggn.bggn021 = g_bggn_d[l_ac].bggn021
               LET l_bggn.bggn022 = g_bggn_d[l_ac].bggn022
               LET l_bggn.bggn023 = g_bggn_d[l_ac].bggn023
               LET l_bggn.bggn024 = g_bggn_d[l_ac].bggn024
               LET l_bggn.bggn025 = g_bggn_d[l_ac].bggn025
               LET l_bggn.bggn026 = g_bggn_d[l_ac].bggn026
               LET ls_js = util.JSON.stringify(l_bggn)
               CALL s_abgt730_chk_bggn(ls_js) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD bggn038
               END IF
               
               #如果核算項沒有輸入就給空值
               IF cl_null(g_bggn_d[l_ac].bggn014) THEN LET g_bggn_d[l_ac].bggn014 = ' ' END IF
               IF cl_null(g_bggn_d[l_ac].bggn015) THEN LET g_bggn_d[l_ac].bggn015 = ' ' END IF
               IF cl_null(g_bggn_d[l_ac].bggn016) THEN LET g_bggn_d[l_ac].bggn016 = ' ' END IF
               IF cl_null(g_bggn_d[l_ac].bggn017) THEN LET g_bggn_d[l_ac].bggn017 = ' ' END IF
               IF cl_null(g_bggn_d[l_ac].bggn018) THEN LET g_bggn_d[l_ac].bggn018 = ' ' END IF
               IF cl_null(g_bggn_d[l_ac].bggn019) THEN LET g_bggn_d[l_ac].bggn019 = ' ' END IF
               IF cl_null(g_bggn_d[l_ac].bggn020) THEN LET g_bggn_d[l_ac].bggn020 = ' ' END IF
               IF cl_null(g_bggn_d[l_ac].bggn021) THEN LET g_bggn_d[l_ac].bggn021 = ' ' END IF
               IF cl_null(g_bggn_d[l_ac].bggn022) THEN LET g_bggn_d[l_ac].bggn022 = ' ' END IF
               IF cl_null(g_bggn_d[l_ac].bggn023) THEN LET g_bggn_d[l_ac].bggn023 = ' ' END IF
               IF cl_null(g_bggn_d[l_ac].bggn024) THEN LET g_bggn_d[l_ac].bggn024 = ' ' END IF
               IF cl_null(g_bggn_d[l_ac].bggn025) THEN LET g_bggn_d[l_ac].bggn025 = ' ' END IF
               IF cl_null(g_bggn_d[l_ac].bggn026) THEN LET g_bggn_d[l_ac].bggn026 = ' ' END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL abgt730_bggn_t_mask_restore('restore_mask_o')
      
               UPDATE bggn_t SET (bggn001,bggn002,bggn003,bggn004,bggn005,bggn006,bggn007,bggnseq,bggn010, 
                   bggn011,bggn012,bggn013,bggn014,bggn015,bggn016,bggn017,bggn018,bggn019,bggn020,bggn021, 
                   bggn022,bggn023,bggn024,bggn025,bggn026,bggn037,bggn038) = (g_bggm_m.bggm001,g_bggm_m.bggm002, 
                   g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007, 
                   g_bggn_d[l_ac].bggnseq,g_bggn_d[l_ac].bggn010,g_bggn_d[l_ac].bggn011,g_bggn_d[l_ac].bggn012, 
                   g_bggn_d[l_ac].bggn013,g_bggn_d[l_ac].bggn014,g_bggn_d[l_ac].bggn015,g_bggn_d[l_ac].bggn016, 
                   g_bggn_d[l_ac].bggn017,g_bggn_d[l_ac].bggn018,g_bggn_d[l_ac].bggn019,g_bggn_d[l_ac].bggn020, 
                   g_bggn_d[l_ac].bggn021,g_bggn_d[l_ac].bggn022,g_bggn_d[l_ac].bggn023,g_bggn_d[l_ac].bggn024, 
                   g_bggn_d[l_ac].bggn025,g_bggn_d[l_ac].bggn026,g_bggn_d[l_ac].bggn037,g_bggn_d[l_ac].bggn038) 
 
                WHERE bggnent = g_enterprise AND bggn001 = g_bggm_m.bggm001 
                  AND bggn002 = g_bggm_m.bggm002 
                  AND bggn003 = g_bggm_m.bggm003 
                  AND bggn004 = g_bggm_m.bggm004 
                  AND bggn005 = g_bggm_m.bggm005 
                  AND bggn006 = g_bggm_m.bggm006 
                  AND bggn007 = g_bggm_m.bggm007 
 
                  AND bggnseq = g_bggn_d_t.bggnseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_bggn_d[l_ac].* = g_bggn_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bggn_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_bggn_d[l_ac].* = g_bggn_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bggn_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bggm_m.bggm001
               LET gs_keys_bak[1] = g_bggm001_t
               LET gs_keys[2] = g_bggm_m.bggm002
               LET gs_keys_bak[2] = g_bggm002_t
               LET gs_keys[3] = g_bggm_m.bggm003
               LET gs_keys_bak[3] = g_bggm003_t
               LET gs_keys[4] = g_bggm_m.bggm004
               LET gs_keys_bak[4] = g_bggm004_t
               LET gs_keys[5] = g_bggm_m.bggm005
               LET gs_keys_bak[5] = g_bggm005_t
               LET gs_keys[6] = g_bggm_m.bggm006
               LET gs_keys_bak[6] = g_bggm006_t
               LET gs_keys[7] = g_bggm_m.bggm007
               LET gs_keys_bak[7] = g_bggm007_t
               LET gs_keys[8] = g_bggn_d[g_detail_idx].bggnseq
               LET gs_keys_bak[8] = g_bggn_d_t.bggnseq
               CALL abgt730_update_b('bggn_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL abgt730_bggn_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_bggn_d[g_detail_idx].bggnseq = g_bggn_d_t.bggnseq 
 
                  ) THEN
                  LET gs_keys[01] = g_bggm_m.bggm001
                  LET gs_keys[gs_keys.getLength()+1] = g_bggm_m.bggm002
                  LET gs_keys[gs_keys.getLength()+1] = g_bggm_m.bggm003
                  LET gs_keys[gs_keys.getLength()+1] = g_bggm_m.bggm004
                  LET gs_keys[gs_keys.getLength()+1] = g_bggm_m.bggm005
                  LET gs_keys[gs_keys.getLength()+1] = g_bggm_m.bggm006
                  LET gs_keys[gs_keys.getLength()+1] = g_bggm_m.bggm007
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bggn_d_t.bggnseq
 
                  CALL abgt730_key_update_b(gs_keys,'bggn_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_bggm_m),util.JSON.stringify(g_bggn_d_t)
               LET g_log2 = util.JSON.stringify(g_bggm_m),util.JSON.stringify(g_bggn_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL abgt730_unlock_b("bggn_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            #是否展第二單身
            LET l_cnt = 0
            SELECT COUNT(1) INTO l_cnt
              FROM bggo_t
             WHERE bggoent = g_enterprise
               AND bggo001 = g_bggm_m.bggm001
               AND bggo002 = g_bggm_m.bggm002
               AND bggo003 = g_bggm_m.bggm003
               AND bggo005 = g_bggm_m.bggm004
               AND bggo006 = g_bggm_m.bggm005
               AND bggo007 = g_bggm_m.bggm006
               AND bggo008 = g_bggm_m.bggm007
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            CALL s_transaction_begin()
            CALL cl_err_collect_init()
            LET l_bggm.bggm001 = g_bggm_m.bggm001
            LET l_bggm.bggm002 = g_bggm_m.bggm002
            LET l_bggm.bggm003 = g_bggm_m.bggm003
            LET l_bggm.bggm004 = g_bggm_m.bggm004
            LET l_bggm.bggm005 = g_bggm_m.bggm005
            LET l_bggm.bggm006 = g_bggm_m.bggm006
            LET l_bggm.bggm007 = g_bggm_m.bggm007
            LET l_bggm.bggm008 = g_bggm_m.bggm008
            LET l_bggm.bggm009 = g_bggm_m.bggm009
            LET ls_js = util.JSON.stringify(l_bggm)
            IF l_cnt > 0 THEN
               IF cl_ask_confirm('axm-00175') THEN
                  CALL s_abgt730_ins_bggo(ls_js) RETURNING g_sub_success
               ELSE
                  #更新核算項
                  CALL s_abgt730_upd_bggo(ls_js) RETURNING g_sub_success
               END IF
            ELSE
               CALL s_abgt730_ins_bggo(ls_js) RETURNING g_sub_success
            END IF
            CALL cl_err_collect_show()
            IF NOT g_sub_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            CALL abgt730_show()
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_bggn_d[li_reproduce_target].* = g_bggn_d[li_reproduce].*
 
               LET g_bggn_d[li_reproduce_target].bggnseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bggn_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bggn_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
      INPUT ARRAY g_bggn2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
        
         BEFORE INPUT
            #先將上層單身的idx放入g_detail_idx
            LET g_detail_idx_tmp = g_detail_idx
            LET g_detail_idx = g_detail_idx_list[1]
            #檢查上層單身是否為空
            IF g_detail_idx = 0 OR g_bggn_d.getLength() = 0 THEN
               NEXT FIELD bggnseq
            END IF
            #檢查上層單身是否有資料
            IF cl_null(g_bggn_d[g_detail_idx].bggnseq) THEN
               NEXT FIELD bggnseq
            END IF
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bggn2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_bggn2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bggn2_d[l_ac].* TO NULL 
            INITIALIZE g_bggn2_d_t.* TO NULL 
            INITIALIZE g_bggn2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_bggn2_d[l_ac].bggo036 = "0"
      LET g_bggn2_d[l_ac].bggo103 = "0"
      LET g_bggn2_d[l_ac].bggo104 = "0"
      LET g_bggn2_d[l_ac].bggo106 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            #第二單身項次
            SELECT MAX(bggoseq2)+1 INTO g_bggn2_d[l_ac].bggoseq2 FROM bggo_t
             WHERE bggoent = g_enterprise
               AND bggo001 = g_bggm_m.bggm001
               AND bggo002 = g_bggm_m.bggm002
               AND bggo003 = g_bggm_m.bggm003
               AND bggo005 = g_bggm_m.bggm004
               AND bggo006 = g_bggm_m.bggm005
               AND bggo007 = g_bggm_m.bggm006
               AND bggo008 = g_bggm_m.bggm007
               AND bggoseq = g_bggn_d[g_detail_idx].bggnseq
            IF cl_null(g_bggn2_d[l_ac].bggoseq2) OR g_bggn2_d[l_ac].bggoseq2 = 0 THEN
               LET g_bggn2_d[l_ac].bggoseq2 = 1
            END IF
            #end add-point
            LET g_bggn2_d_t.* = g_bggn2_d[l_ac].*     #新輸入資料
            LET g_bggn2_d_o.* = g_bggn2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abgt730_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL abgt730_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bggn2_d[li_reproduce_target].* = g_bggn2_d[li_reproduce].*
 
               LET g_bggn2_d[li_reproduce_target].bggoseq2 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
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
            OPEN abgt730_cl USING g_enterprise,g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007
            #(ver:78) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abgt730_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CLOSE abgt730_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            #(ver:78) --- end ---
            OPEN abgt730_bcl USING g_enterprise,g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004, 
                g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007,g_bggn_d[g_detail_idx].bggnseq
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abgt730_bcl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abgt730_cl
               CLOSE abgt730_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_bggn2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bggn2_d[l_ac].bggoseq2 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_bggn2_d_t.* = g_bggn2_d[l_ac].*  #BACKUP
               LET g_bggn2_d_o.* = g_bggn2_d[l_ac].*  #BACKUP
               CALL abgt730_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL abgt730_set_no_entry_b(l_cmd)
               IF NOT abgt730_lock_b("bggo_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgt730_bcl2 INTO g_bggn2_d[l_ac].bggoseq2,g_bggn2_d[l_ac].bggo009,g_bggn2_d[l_ac].bggo100, 
                      g_bggn2_d[l_ac].bggo101,g_bggn2_d[l_ac].bggo036,g_bggn2_d[l_ac].bggo035,g_bggn2_d[l_ac].bggo103, 
                      g_bggn2_d[l_ac].bggo104,g_bggn2_d[l_ac].bggo106,g_bggn2_d[l_ac].bggo039,g_bggn2_d[l_ac].bggo040 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bggn2_d_mask_o[l_ac].* =  g_bggn2_d[l_ac].*
                  CALL abgt730_bggo_t_mask()
                  LET g_bggn2_d_mask_n[l_ac].* =  g_bggn2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL abgt730_show()
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
               LET gs_keys[1] = g_bggm_m.bggm001
               LET gs_keys[2] = g_bggm_m.bggm002
               LET gs_keys[3] = g_bggm_m.bggm003
               LET gs_keys[4] = g_bggm_m.bggm004
               LET gs_keys[5] = g_bggm_m.bggm005
               LET gs_keys[6] = g_bggm_m.bggm006
               LET gs_keys[7] = g_bggm_m.bggm007
               LET gs_keys[8] = g_bggn_d[g_detail_idx].bggnseq
               LET gs_keys[9] = g_bggn2_d_t.bggoseq2
 
 
               #刪除同層單身
               IF NOT abgt730_delete_b('bggo_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abgt730_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point   
               
               CALL s_transaction_end('Y','0')
               CLOSE abgt730_bcl
                  
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
 
               LET l_count = g_bggn_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bggn2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM bggo_t 
             WHERE bggoent = g_enterprise AND bggo001 = g_bggm_m.bggm001 AND bggo002 = g_bggm_m.bggm002  
                 AND bggo003 = g_bggm_m.bggm003 AND bggo005 = g_bggm_m.bggm004 AND bggo006 = g_bggm_m.bggm005  
                 AND bggo007 = g_bggm_m.bggm006 AND bggo008 = g_bggm_m.bggm007 AND bggoseq = g_bggn_d[g_detail_idx].bggnseq  
                 AND bggoseq2 = g_bggn2_d[g_detail_idx2].bggoseq2
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bggm_m.bggm001
               LET gs_keys[2] = g_bggm_m.bggm002
               LET gs_keys[3] = g_bggm_m.bggm003
               LET gs_keys[4] = g_bggm_m.bggm004
               LET gs_keys[5] = g_bggm_m.bggm005
               LET gs_keys[6] = g_bggm_m.bggm006
               LET gs_keys[7] = g_bggm_m.bggm007
               LET gs_keys[8] = g_bggn_d[g_detail_idx].bggnseq
               LET gs_keys[9] = g_bggn2_d[g_detail_idx2].bggoseq2
               CALL abgt730_insert_b('bggo_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_bggn_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "bggo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abgt730_b_fill()
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
               LET g_bggn2_d[l_ac].* = g_bggn2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abgt730_bcl2
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
               LET g_bggn2_d[l_ac].* = g_bggn2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL abgt730_bggo_t_mask_restore('restore_mask_o')
               
               UPDATE bggo_t SET (bggo001,bggo002,bggo003,bggo005,bggo006,bggo007,bggo008,bggoseq,bggoseq2, 
                   bggo009,bggo100,bggo101,bggo036,bggo035,bggo103,bggo104,bggo106,bggo039,bggo040) = (g_bggm_m.bggm001, 
                   g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006, 
                   g_bggm_m.bggm007,g_bggn_d[g_detail_idx].bggnseq,g_bggn2_d[l_ac].bggoseq2,g_bggn2_d[l_ac].bggo009, 
                   g_bggn2_d[l_ac].bggo100,g_bggn2_d[l_ac].bggo101,g_bggn2_d[l_ac].bggo036,g_bggn2_d[l_ac].bggo035, 
                   g_bggn2_d[l_ac].bggo103,g_bggn2_d[l_ac].bggo104,g_bggn2_d[l_ac].bggo106,g_bggn2_d[l_ac].bggo039, 
                   g_bggn2_d[l_ac].bggo040) #自訂欄位頁簽
                WHERE bggoent = g_enterprise AND bggo001 = g_bggm001_t AND bggo002 = g_bggm002_t AND  
                    bggo003 = g_bggm003_t AND bggo005 = g_bggm004_t AND bggo006 = g_bggm005_t AND bggo007  
                    = g_bggm006_t AND bggo008 = g_bggm007_t AND bggoseq = g_bggn_d[g_detail_idx].bggnseq  
                    AND bggoseq2 = g_bggn2_d_t.bggoseq2
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_bggn2_d[l_ac].* = g_bggn2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bggo_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_bggn2_d[l_ac].* = g_bggn2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bggo_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bggm_m.bggm001
               LET gs_keys_bak[1] = g_bggm001_t
               LET gs_keys[2] = g_bggm_m.bggm002
               LET gs_keys_bak[2] = g_bggm002_t
               LET gs_keys[3] = g_bggm_m.bggm003
               LET gs_keys_bak[3] = g_bggm003_t
               LET gs_keys[4] = g_bggm_m.bggm004
               LET gs_keys_bak[4] = g_bggm004_t
               LET gs_keys[5] = g_bggm_m.bggm005
               LET gs_keys_bak[5] = g_bggm005_t
               LET gs_keys[6] = g_bggm_m.bggm006
               LET gs_keys_bak[6] = g_bggm006_t
               LET gs_keys[7] = g_bggm_m.bggm007
               LET gs_keys_bak[7] = g_bggm007_t
               LET gs_keys[8] = g_bggn_d[g_detail_idx].bggnseq
               LET gs_keys_bak[8] = g_bggn_d[g_detail_idx].bggnseq
               LET gs_keys[9] = g_bggn2_d[g_detail_idx2].bggoseq2
               LET gs_keys_bak[9] = g_bggn2_d_t.bggoseq2
               CALL abgt730_update_b('bggo_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abgt730_bggo_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_bggm_m),util.JSON.stringify(g_bggn2_d_t)
               LET g_log2 = util.JSON.stringify(g_bggm_m),util.JSON.stringify(g_bggn2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggoseq2
            #add-point:BEFORE FIELD bggoseq2 name="input.b.page2.bggoseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggoseq2
            
            #add-point:AFTER FIELD bggoseq2 name="input.a.page2.bggoseq2"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bggm_m.bggm001 IS NOT NULL AND g_bggm_m.bggm002 IS NOT NULL AND g_bggm_m.bggm003 IS NOT NULL AND g_bggm_m.bggm004 IS NOT NULL AND g_bggm_m.bggm005 IS NOT NULL AND g_bggm_m.bggm006 IS NOT NULL AND g_bggm_m.bggm007 IS NOT NULL AND g_bggn_d[g_detail_idx].bggnseq IS NOT NULL AND g_bggn2_d[g_detail_idx2].bggoseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bggm_m.bggm001 != g_bggm001_t OR g_bggm_m.bggm002 != g_bggm002_t OR g_bggm_m.bggm003 != g_bggm003_t OR g_bggm_m.bggm004 != g_bggm004_t OR g_bggm_m.bggm005 != g_bggm005_t OR g_bggm_m.bggm006 != g_bggm006_t OR g_bggm_m.bggm007 != g_bggm007_t OR g_bggn_d[g_detail_idx].bggnseq != g_bggn_d[g_detail_idx].bggnseq OR g_bggn2_d[g_detail_idx2].bggoseq2 != g_bggn2_d_t.bggoseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bggo_t WHERE "||"bggoent = " ||g_enterprise|| " AND "||"bggo001 = '"||g_bggm_m.bggm001 ||"' AND "|| "bggo002 = '"||g_bggm_m.bggm002 ||"' AND "|| "bggo003 = '"||g_bggm_m.bggm003 ||"' AND "|| "bggo005 = '"||g_bggm_m.bggm004 ||"' AND "|| "bggo006 = '"||g_bggm_m.bggm005 ||"' AND "|| "bggo007 = '"||g_bggm_m.bggm006 ||"' AND "|| "bggo008 = '"||g_bggm_m.bggm007 ||"' AND "|| "bggoseq = '"||g_bggn_d[g_detail_idx].bggnseq ||"' AND "|| "bggoseq2 = '"||g_bggn2_d[g_detail_idx2].bggoseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggoseq2
            #add-point:ON CHANGE bggoseq2 name="input.g.page2.bggoseq2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo009
            
            #add-point:AFTER FIELD bggo009 name="input.a.page2.bggo009"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo009
            #add-point:BEFORE FIELD bggo009 name="input.b.page2.bggo009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo009
            #add-point:ON CHANGE bggo009 name="input.g.page2.bggo009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo100
            #add-point:BEFORE FIELD bggo100 name="input.b.page2.bggo100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo100
            
            #add-point:AFTER FIELD bggo100 name="input.a.page2.bggo100"
            #幣別
            IF NOT cl_null(g_bggn2_d[l_ac].bggo100) THEN
               IF g_bggn2_d[l_ac].bggo100 != g_bggn2_d_o.bggo100 OR cl_null(g_bggn2_d_o.bggo100) THEN
                  CALL s_aap_ooaj001_chk(g_ld,g_bggn2_d[l_ac].bggo100) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.replace[1] = 'aooi150'
                     LET g_errparam.replace[2] = cl_get_progname('aooi150',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggn2_d[l_ac].bggo100 = g_bggn2_d_o.bggo100
                     NEXT FIELD CURRENT
                  END IF
                  #匯率取預算匯率維護檔abgi200
                  CALL s_abg_get_bg_rate(g_bggm_m.bggm002,g_today,g_bggn2_d[l_ac].bggo100,g_bggm_m.bgaa003) RETURNING g_bggn2_d[l_ac].bggo101
               END IF
            END IF
            LET g_bggn2_d_o.* = g_bggn2_d[l_ac].*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo100
            #add-point:ON CHANGE bggo100 name="input.g.page2.bggo100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo101
            #add-point:BEFORE FIELD bggo101 name="input.b.page2.bggo101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo101
            
            #add-point:AFTER FIELD bggo101 name="input.a.page2.bggo101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo101
            #add-point:ON CHANGE bggo101 name="input.g.page2.bggo101"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo036
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bggn2_d[l_ac].bggo036,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bggo036
            END IF 
 
 
 
            #add-point:AFTER FIELD bggo036 name="input.a.page2.bggo036"
            #薪資基準
            IF NOT cl_null(g_bggn2_d[l_ac].bggo036) THEN
               IF g_bggn2_d[l_ac].bggo036 != g_bggn2_d_o.bggo036 OR cl_null(g_bggn2_d_o.bggo036) THEN
                  CALL s_curr_round(g_bggm_m.bggm006,g_bggn2_d[l_ac].bggo100,g_bggn2_d[l_ac].bggo036,2) RETURNING g_bggn2_d[l_ac].bggo036
                  #重推預算金額=薪資基準*用工人數
                  LET g_bggn2_d[l_ac].bggo103 = g_bggn2_d[l_ac].bggo035 * g_bggn2_d[l_ac].bggo036
                  CALL s_curr_round(g_bggm_m.bggm006,g_bggn2_d[l_ac].bggo100,g_bggn2_d[l_ac].bggo103,2) RETURNING g_bggn2_d[l_ac].bggo103
                  #重推核准金額=預算金額+調整金額
                  LET g_bggn2_d[l_ac].bggo106 = g_bggn2_d[l_ac].bggo103 + g_bggn2_d[l_ac].bggo104
               END IF
            END IF
            LET g_bggn2_d_o.* = g_bggn2_d[l_ac].*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo036
            #add-point:BEFORE FIELD bggo036 name="input.b.page2.bggo036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo036
            #add-point:ON CHANGE bggo036 name="input.g.page2.bggo036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo035
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bggn2_d[l_ac].bggo035,"0","0","","","azz-00079",1) THEN
               NEXT FIELD bggo035
            END IF 
 
 
 
            #add-point:AFTER FIELD bggo035 name="input.a.page2.bggo035"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo035
            #add-point:BEFORE FIELD bggo035 name="input.b.page2.bggo035"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo035
            #add-point:ON CHANGE bggo035 name="input.g.page2.bggo035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo103
            #add-point:BEFORE FIELD bggo103 name="input.b.page2.bggo103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo103
            
            #add-point:AFTER FIELD bggo103 name="input.a.page2.bggo103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo103
            #add-point:ON CHANGE bggo103 name="input.g.page2.bggo103"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo104
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bggn2_d[l_ac].bggo104,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bggo104
            END IF 
 
 
 
            #add-point:AFTER FIELD bggo104 name="input.a.page2.bggo104"
            #本層調整金額
            IF NOT cl_null(g_bggn2_d[l_ac].bggo104) THEN
               IF g_bggn2_d[l_ac].bggo104 != g_bggn2_d_o.bggo104 OR cl_null(g_bggn2_d_o.bggo104) THEN
                  CALL s_curr_round(g_bggm_m.bggm006,g_bggn2_d[l_ac].bggo100,g_bggn2_d[l_ac].bggo104,2) RETURNING g_bggn2_d[l_ac].bggo104
                  #重推核准金額=預算金額+調整金額
                  LET g_bggn2_d[l_ac].bggo106 = g_bggn2_d[l_ac].bggo103 + g_bggn2_d[l_ac].bggo104
               END IF
            END IF
            LET g_bggn2_d_o.* = g_bggn2_d[l_ac].*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo104
            #add-point:BEFORE FIELD bggo104 name="input.b.page2.bggo104"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo104
            #add-point:ON CHANGE bggo104 name="input.g.page2.bggo104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo106
            #add-point:BEFORE FIELD bggo106 name="input.b.page2.bggo106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo106
            
            #add-point:AFTER FIELD bggo106 name="input.a.page2.bggo106"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo106
            #add-point:ON CHANGE bggo106 name="input.g.page2.bggo106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo039
            #add-point:BEFORE FIELD bggo039 name="input.b.page2.bggo039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo039
            
            #add-point:AFTER FIELD bggo039 name="input.a.page2.bggo039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo039
            #add-point:ON CHANGE bggo039 name="input.g.page2.bggo039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo039_desc
            #add-point:BEFORE FIELD bggo039_desc name="input.b.page2.bggo039_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo039_desc
            
            #add-point:AFTER FIELD bggo039_desc name="input.a.page2.bggo039_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo039_desc
            #add-point:ON CHANGE bggo039_desc name="input.g.page2.bggo039_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo040
            #add-point:BEFORE FIELD bggo040 name="input.b.page2.bggo040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo040
            
            #add-point:AFTER FIELD bggo040 name="input.a.page2.bggo040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo040
            #add-point:ON CHANGE bggo040 name="input.g.page2.bggo040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo040_desc
            #add-point:BEFORE FIELD bggo040_desc name="input.b.page2.bggo040_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo040_desc
            
            #add-point:AFTER FIELD bggo040_desc name="input.a.page2.bggo040_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo040_desc
            #add-point:ON CHANGE bggo040_desc name="input.g.page2.bggo040_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.bggoseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggoseq2
            #add-point:ON ACTION controlp INFIELD bggoseq2 name="input.c.page2.bggoseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.bggo009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo009
            #add-point:ON ACTION controlp INFIELD bggo009 name="input.c.page2.bggo009"
            #工資項目
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn2_d[l_ac].bggo009
            LET g_qryparam.arg1  = "3401"
            CALL q_bggb002()
            LET g_bggn2_d[l_ac].bggo009 = g_qryparam.return1
            NEXT FIELD bggo009
            #END add-point
 
 
         #Ctrlp:input.c.page2.bggo100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo100
            #add-point:ON ACTION controlp INFIELD bggo100 name="input.c.page2.bggo100"
            #幣別
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggn2_d[l_ac].bggo100
            CALL q_ooai001()
            LET g_bggn2_d[l_ac].bggo100 = g_qryparam.return1
            DISPLAY g_bggn2_d[l_ac].bggo100 TO bggo100
            NEXT FIELD bggo100
            #END add-point
 
 
         #Ctrlp:input.c.page2.bggo101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo101
            #add-point:ON ACTION controlp INFIELD bggo101 name="input.c.page2.bggo101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.bggo036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo036
            #add-point:ON ACTION controlp INFIELD bggo036 name="input.c.page2.bggo036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.bggo035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo035
            #add-point:ON ACTION controlp INFIELD bggo035 name="input.c.page2.bggo035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.bggo103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo103
            #add-point:ON ACTION controlp INFIELD bggo103 name="input.c.page2.bggo103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.bggo104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo104
            #add-point:ON ACTION controlp INFIELD bggo104 name="input.c.page2.bggo104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.bggo106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo106
            #add-point:ON ACTION controlp INFIELD bggo106 name="input.c.page2.bggo106"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.bggo039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo039
            #add-point:ON ACTION controlp INFIELD bggo039 name="input.c.page2.bggo039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.bggo039_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo039_desc
            #add-point:ON ACTION controlp INFIELD bggo039_desc name="input.c.page2.bggo039_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.bggo040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo040
            #add-point:ON ACTION controlp INFIELD bggo040 name="input.c.page2.bggo040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.bggo040_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo040_desc
            #add-point:ON ACTION controlp INFIELD bggo040_desc name="input.c.page2.bggo040_desc"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2_after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bggn2_d[l_ac].* = g_bggn2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abgt730_bcl2
               CLOSE abgt730_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL abgt730_unlock_b("bggo_t","'2'")
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
               LET g_bggn2_d[li_reproduce_target].* = g_bggn2_d[li_reproduce].*
 
               LET g_bggn2_d[li_reproduce_target].bggoseq2 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_bggn2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bggn2_d.getLength()+1
            END IF
        
      END INPUT
 
 
 
 
{</section>}
 
{<section id="abgt730.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         CALL cl_set_comp_visible("bggn014_desc,bggn015_desc,bggn016_desc,bggn017_desc,bggn018_desc",TRUE)
         CALL cl_set_comp_visible("bggn019_desc,bggn020_desc,bggn021_desc,bggn022_desc,bggn023_desc",TRUE)
         CALL cl_set_comp_visible("bggn024_desc,bggn025_desc,bggn026_desc",TRUE)
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD bggm002
            #end add-point  
            NEXT FIELD bggm001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bggnseq
               WHEN "s_detail2"
                  NEXT FIELD bggoseq2
 
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
 
{<section id="abgt730.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abgt730_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL abgt730_b_fill() #單身填充
      CALL abgt730_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abgt730_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   #預算編號
   CALL s_desc_get_budget_desc(g_bggm_m.bggm002) RETURNING g_bggm_m.bggm002_desc
   #抓取預算週期/預算幣別
   CALL s_abgt340_sel_bgaa(g_bggm_m.bggm002) RETURNING g_bggm_m.bgaa002,g_bggm_m.bgaa003,g_max_period
   #管理組織
   CALL s_desc_get_bgai002_desc(g_bggm_m.bggm002,g_bggm_m.bggm008) RETURNING g_bggm_m.bggm008_desc
   #核算項欄位隱顯
   CALL abgt730_set_entry_bggm009(g_bggm_m.bggm002,g_bggm_m.bggm008,g_bggm_m.bggm009)
   #預算組織
   CALL s_desc_get_department_desc(g_bggm_m.bggm006) RETURNING g_bggm_m.bggm006_desc
   
   CALL s_fin_orga_get_comp_ld(g_bggm_m.bggm006) RETURNING g_sub_success,g_errno,g_comp,g_ld
   #end add-point
   
   #遮罩相關處理
   LET g_bggm_m_mask_o.* =  g_bggm_m.*
   CALL abgt730_bggm_t_mask()
   LET g_bggm_m_mask_n.* =  g_bggm_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bggm_m.bggm002,g_bggm_m.bggm002_desc,g_bggm_m.bggm003,g_bggm_m.bggm008,g_bggm_m.bggm008_desc, 
       g_bggm_m.bggm001,g_bggm_m.bggm005,g_bggm_m.bgaa002,g_bggm_m.bgaa003,g_bggm_m.bggm009,g_bggm_m.bggm004, 
       g_bggm_m.bggm006,g_bggm_m.bggm006_desc,g_bggm_m.bggm007,g_bggm_m.bggmstus,g_bggm_m.bggmownid, 
       g_bggm_m.bggmownid_desc,g_bggm_m.bggmowndp,g_bggm_m.bggmowndp_desc,g_bggm_m.bggmcrtid,g_bggm_m.bggmcrtid_desc, 
       g_bggm_m.bggmcrtdp,g_bggm_m.bggmcrtdp_desc,g_bggm_m.bggmcrtdt,g_bggm_m.bggmmodid,g_bggm_m.bggmmodid_desc, 
       g_bggm_m.bggmmoddt,g_bggm_m.bggmcnfid,g_bggm_m.bggmcnfid_desc,g_bggm_m.bggmcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bggm_m.bggmstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "FC"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/final_confirmed.png")
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
   FOR l_ac = 1 TO g_bggn_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      #工資方案
      CALL s_desc_get_bggbl004_desc(g_bggn_d[l_ac].bggn010) RETURNING g_bggn_d[l_ac].bggn010_desc
      #職級
      CALL s_desc_get_bggal004_desc('abgi710',g_bggn_d[l_ac].bggn011) RETURNING g_bggn_d[l_ac].bggn011_desc
      #職等
      CALL s_desc_get_bggal004_desc('abgi720',g_bggn_d[l_ac].bggn012) RETURNING g_bggn_d[l_ac].bggn012_desc
      #用工屬性
      CALL s_desc_get_bggal004_desc('abgi730',g_bggn_d[l_ac].bggn013) RETURNING g_bggn_d[l_ac].bggn013_desc
      #人員
      CALL s_desc_get_person_desc(g_bggn_d[l_ac].bggn014) RETURNING g_bggn_d[l_ac].bggn014_desc
      LET g_bggn_d[l_ac].bggn014_desc = s_desc_show1(g_bggn_d[l_ac].bggn014,g_bggn_d[l_ac].bggn014_desc)
      #部門
      CALL s_desc_get_department_desc(g_bggn_d[l_ac].bggn015) RETURNING g_bggn_d[l_ac].bggn015_desc
      LET g_bggn_d[l_ac].bggn015_desc = s_desc_show1(g_bggn_d[l_ac].bggn015,g_bggn_d[l_ac].bggn015_desc)
      #成本利潤中心
      CALL s_desc_get_department_desc(g_bggn_d[l_ac].bggn016) RETURNING g_bggn_d[l_ac].bggn016_desc
      LET g_bggn_d[l_ac].bggn016_desc = s_desc_show1(g_bggn_d[l_ac].bggn016,g_bggn_d[l_ac].bggn016_desc)
      #區域
      CALL s_desc_get_acc_desc('287',g_bggn_d[l_ac].bggn017) RETURNING g_bggn_d[l_ac].bggn017_desc
      LET g_bggn_d[l_ac].bggn017_desc = s_desc_show1(g_bggn_d[l_ac].bggn017,g_bggn_d[l_ac].bggn017_desc)
      #收付款客商
      CALL s_desc_get_bgap001_desc(g_bggn_d[l_ac].bggn018) RETURNING g_bggn_d[l_ac].bggn018_desc
      LET g_bggn_d[l_ac].bggn018_desc = s_desc_show1(g_bggn_d[l_ac].bggn018,g_bggn_d[l_ac].bggn018_desc)
      #收款客商
      CALL s_desc_get_bgap001_desc(g_bggn_d[l_ac].bggn019) RETURNING g_bggn_d[l_ac].bggn019_desc
      LET g_bggn_d[l_ac].bggn019_desc = s_desc_show1(g_bggn_d[l_ac].bggn019,g_bggn_d[l_ac].bggn019_desc)
      #客群
      CALL s_desc_get_acc_desc('281',g_bggn_d[l_ac].bggn020) RETURNING g_bggn_d[l_ac].bggn020_desc
      LET g_bggn_d[l_ac].bggn020_desc = s_desc_show1(g_bggn_d[l_ac].bggn020,g_bggn_d[l_ac].bggn020_desc)
      #產品類別
      CALL s_desc_get_rtaxl003_desc(g_bggn_d[l_ac].bggn021) RETURNING g_bggn_d[l_ac].bggn021_desc
      LET g_bggn_d[l_ac].bggn021_desc = s_desc_show1(g_bggn_d[l_ac].bggn021,g_bggn_d[l_ac].bggn021_desc)
      #專案編號
      CALL s_desc_get_project_desc(g_bggn_d[l_ac].bggn022) RETURNING g_bggn_d[l_ac].bggn022_desc
      LET g_bggn_d[l_ac].bggn022_desc = s_desc_show1(g_bggn_d[l_ac].bggn022,g_bggn_d[l_ac].bggn022_desc)
      #WBS
      CALL s_desc_get_wbs_desc(g_bggn_d[l_ac].bggn022,g_bggn_d[l_ac].bggn023) RETURNING g_bggn_d[l_ac].bggn023_desc
      LET g_bggn_d[l_ac].bggn023_desc = s_desc_show1(g_bggn_d[l_ac].bggn023,g_bggn_d[l_ac].bggn023_desc)
      #經營方式
      LET g_bggn_d[l_ac].bggn024_desc = g_bggn_d[l_ac].bggn024
      #通路
      CALL s_desc_get_oojdl003_desc(g_bggn_d[l_ac].bggn025) RETURNING g_bggn_d[l_ac].bggn025_desc
      LET g_bggn_d[l_ac].bggn025_desc = s_desc_show1(g_bggn_d[l_ac].bggn025,g_bggn_d[l_ac].bggn025_desc)
      #品牌
      CALL s_desc_get_acc_desc('2002',g_bggn_d[l_ac].bggn026) RETURNING g_bggn_d[l_ac].bggn026_desc
      LET g_bggn_d[l_ac].bggn026_desc = s_desc_show1(g_bggn_d[l_ac].bggn026,g_bggn_d[l_ac].bggn026_desc)
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_bggn2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
 
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL abgt730_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abgt730.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION abgt730_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
DEFINE l_n           LIKE type_t.num10
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   FOR l_n = 1 TO g_bggn2_d.getLength()
      #工資項目
      CALL s_desc_get_acc_desc('3401',g_bggn2_d[l_n].bggo009) RETURNING g_bggn2_d[l_n].bggo009_desc
      #借方預算細項
      CALL s_desc_get_account_desc(g_ld,g_bggn2_d[l_n].bggo039) RETURNING g_bggn2_d[l_n].bggo039_desc
      LET g_bggn2_d[l_n].bggo039_desc = s_desc_show1(g_bggn2_d[l_n].bggo039,g_bggn2_d[l_n].bggo039_desc)
   END FOR
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abgt730.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abgt730_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE bggm_t.bggm001 
   DEFINE l_oldno     LIKE bggm_t.bggm001 
   DEFINE l_newno02     LIKE bggm_t.bggm002 
   DEFINE l_oldno02     LIKE bggm_t.bggm002 
   DEFINE l_newno03     LIKE bggm_t.bggm003 
   DEFINE l_oldno03     LIKE bggm_t.bggm003 
   DEFINE l_newno04     LIKE bggm_t.bggm004 
   DEFINE l_oldno04     LIKE bggm_t.bggm004 
   DEFINE l_newno05     LIKE bggm_t.bggm005 
   DEFINE l_oldno05     LIKE bggm_t.bggm005 
   DEFINE l_newno06     LIKE bggm_t.bggm006 
   DEFINE l_oldno06     LIKE bggm_t.bggm006 
   DEFINE l_newno07     LIKE bggm_t.bggm007 
   DEFINE l_oldno07     LIKE bggm_t.bggm007 
 
   DEFINE l_master    RECORD LIKE bggm_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bggn_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE bggo_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_bggm_m.bggm001 IS NULL
   OR g_bggm_m.bggm002 IS NULL
   OR g_bggm_m.bggm003 IS NULL
   OR g_bggm_m.bggm004 IS NULL
   OR g_bggm_m.bggm005 IS NULL
   OR g_bggm_m.bggm006 IS NULL
   OR g_bggm_m.bggm007 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_bggm001_t = g_bggm_m.bggm001
   LET g_bggm002_t = g_bggm_m.bggm002
   LET g_bggm003_t = g_bggm_m.bggm003
   LET g_bggm004_t = g_bggm_m.bggm004
   LET g_bggm005_t = g_bggm_m.bggm005
   LET g_bggm006_t = g_bggm_m.bggm006
   LET g_bggm007_t = g_bggm_m.bggm007
 
    
   LET g_bggm_m.bggm001 = ""
   LET g_bggm_m.bggm002 = ""
   LET g_bggm_m.bggm003 = ""
   LET g_bggm_m.bggm004 = ""
   LET g_bggm_m.bggm005 = ""
   LET g_bggm_m.bggm006 = ""
   LET g_bggm_m.bggm007 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bggm_m.bggmownid = g_user
      LET g_bggm_m.bggmowndp = g_dept
      LET g_bggm_m.bggmcrtid = g_user
      LET g_bggm_m.bggmcrtdp = g_dept 
      LET g_bggm_m.bggmcrtdt = cl_get_current()
      LET g_bggm_m.bggmmodid = g_user
      LET g_bggm_m.bggmmoddt = cl_get_current()
      LET g_bggm_m.bggmstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bggm_m.bggmstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "FC"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/final_confirmed.png")
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
      LET g_bggm_m.bggm002_desc = ''
   DISPLAY BY NAME g_bggm_m.bggm002_desc
   LET g_bggm_m.bggm006_desc = ''
   DISPLAY BY NAME g_bggm_m.bggm006_desc
 
   
   CALL abgt730_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_bggm_m.* TO NULL
      INITIALIZE g_bggn_d TO NULL
      INITIALIZE g_bggn2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL abgt730_show()
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
   CALL abgt730_set_act_visible()   
   CALL abgt730_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bggm001_t = g_bggm_m.bggm001
   LET g_bggm002_t = g_bggm_m.bggm002
   LET g_bggm003_t = g_bggm_m.bggm003
   LET g_bggm004_t = g_bggm_m.bggm004
   LET g_bggm005_t = g_bggm_m.bggm005
   LET g_bggm006_t = g_bggm_m.bggm006
   LET g_bggm007_t = g_bggm_m.bggm007
 
   
   #組合新增資料的條件
   LET g_add_browse = " bggment = " ||g_enterprise|| " AND",
                      " bggm001 = '", g_bggm_m.bggm001, "' "
                      ," AND bggm002 = '", g_bggm_m.bggm002, "' "
                      ," AND bggm003 = '", g_bggm_m.bggm003, "' "
                      ," AND bggm004 = '", g_bggm_m.bggm004, "' "
                      ," AND bggm005 = '", g_bggm_m.bggm005, "' "
                      ," AND bggm006 = '", g_bggm_m.bggm006, "' "
                      ," AND bggm007 = '", g_bggm_m.bggm007, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt730_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL abgt730_idx_chk()
   
   LET g_data_owner = g_bggm_m.bggmownid      
   LET g_data_dept  = g_bggm_m.bggmowndp
   
   #功能已完成,通報訊息中心
   CALL abgt730_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="abgt730.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abgt730_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bggn_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE bggo_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abgt730_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bggn_t
    WHERE bggnent = g_enterprise AND bggn001 = g_bggm001_t
     AND bggn002 = g_bggm002_t
     AND bggn003 = g_bggm003_t
     AND bggn004 = g_bggm004_t
     AND bggn005 = g_bggm005_t
     AND bggn006 = g_bggm006_t
     AND bggn007 = g_bggm007_t
 
    INTO TEMP abgt730_detail
 
   #將key修正為調整後   
   UPDATE abgt730_detail 
      #更新key欄位
      SET bggn001 = g_bggm_m.bggm001
          , bggn002 = g_bggm_m.bggm002
          , bggn003 = g_bggm_m.bggm003
          , bggn004 = g_bggm_m.bggm004
          , bggn005 = g_bggm_m.bggm005
          , bggn006 = g_bggm_m.bggm006
          , bggn007 = g_bggm_m.bggm007
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO bggn_t SELECT * FROM abgt730_detail
   
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
   DROP TABLE abgt730_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bggo_t 
    WHERE bggoent = g_enterprise AND bggo001 = g_bggm001_t
    AND bggo002 = g_bggm002_t   
    AND bggo003 = g_bggm003_t   
    AND bggo005 = g_bggm004_t   
    AND bggo006 = g_bggm005_t   
    AND bggo007 = g_bggm006_t   
    AND bggo008 = g_bggm007_t   
 
    INTO TEMP abgt730_detail
 
   #將key修正為調整後   
   UPDATE abgt730_detail SET bggo001 = g_bggm_m.bggm001
                                       , bggo002 = g_bggm_m.bggm002
                                       , bggo003 = g_bggm_m.bggm003
                                       , bggo005 = g_bggm_m.bggm004
                                       , bggo006 = g_bggm_m.bggm005
                                       , bggo007 = g_bggm_m.bggm006
                                       , bggo008 = g_bggm_m.bggm007
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO bggo_t SELECT * FROM abgt730_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE abgt730_detail
   
   LET g_data_owner = g_bggm_m.bggmownid      
   LET g_data_dept  = g_bggm_m.bggmowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bggm001_t = g_bggm_m.bggm001
   LET g_bggm002_t = g_bggm_m.bggm002
   LET g_bggm003_t = g_bggm_m.bggm003
   LET g_bggm004_t = g_bggm_m.bggm004
   LET g_bggm005_t = g_bggm_m.bggm005
   LET g_bggm006_t = g_bggm_m.bggm006
   LET g_bggm007_t = g_bggm_m.bggm007
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt730.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abgt730_delete()
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
   
   IF g_bggm_m.bggm001 IS NULL
   OR g_bggm_m.bggm002 IS NULL
   OR g_bggm_m.bggm003 IS NULL
   OR g_bggm_m.bggm004 IS NULL
   OR g_bggm_m.bggm005 IS NULL
   OR g_bggm_m.bggm006 IS NULL
   OR g_bggm_m.bggm007 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN abgt730_cl USING g_enterprise,g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt730_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abgt730_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt730_master_referesh USING g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004, 
       g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007 INTO g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm008, 
       g_bggm_m.bggm001,g_bggm_m.bggm005,g_bggm_m.bggm009,g_bggm_m.bggm004,g_bggm_m.bggm006,g_bggm_m.bggm007, 
       g_bggm_m.bggmstus,g_bggm_m.bggmownid,g_bggm_m.bggmowndp,g_bggm_m.bggmcrtid,g_bggm_m.bggmcrtdp, 
       g_bggm_m.bggmcrtdt,g_bggm_m.bggmmodid,g_bggm_m.bggmmoddt,g_bggm_m.bggmcnfid,g_bggm_m.bggmcnfdt, 
       g_bggm_m.bggmownid_desc,g_bggm_m.bggmowndp_desc,g_bggm_m.bggmcrtid_desc,g_bggm_m.bggmcrtdp_desc, 
       g_bggm_m.bggmmodid_desc,g_bggm_m.bggmcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT abgt730_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bggm_m_mask_o.* =  g_bggm_m.*
   CALL abgt730_bggm_t_mask()
   LET g_bggm_m_mask_n.* =  g_bggm_m.*
   
   CALL abgt730_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgt730_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_bggm001_t = g_bggm_m.bggm001
      LET g_bggm002_t = g_bggm_m.bggm002
      LET g_bggm003_t = g_bggm_m.bggm003
      LET g_bggm004_t = g_bggm_m.bggm004
      LET g_bggm005_t = g_bggm_m.bggm005
      LET g_bggm006_t = g_bggm_m.bggm006
      LET g_bggm007_t = g_bggm_m.bggm007
 
 
      DELETE FROM bggm_t
       WHERE bggment = g_enterprise AND bggm001 = g_bggm_m.bggm001
         AND bggm002 = g_bggm_m.bggm002
         AND bggm003 = g_bggm_m.bggm003
         AND bggm004 = g_bggm_m.bggm004
         AND bggm005 = g_bggm_m.bggm005
         AND bggm006 = g_bggm_m.bggm006
         AND bggm007 = g_bggm_m.bggm007
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_bggm_m.bggm001,":",SQLERRMESSAGE  
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
      
      DELETE FROM bggn_t
       WHERE bggnent = g_enterprise AND bggn001 = g_bggm_m.bggm001
         AND bggn002 = g_bggm_m.bggm002
         AND bggn003 = g_bggm_m.bggm003
         AND bggn004 = g_bggm_m.bggm004
         AND bggn005 = g_bggm_m.bggm005
         AND bggn006 = g_bggm_m.bggm006
         AND bggn007 = g_bggm_m.bggm007
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bggn_t:",SQLERRMESSAGE 
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
      DELETE FROM bggo_t
       WHERE bggoent = g_enterprise AND
             bggo001 = g_bggm_m.bggm001 AND bggo002 = g_bggm_m.bggm002 AND bggo003 = g_bggm_m.bggm003 AND bggo005 = g_bggm_m.bggm004 AND bggo006 = g_bggm_m.bggm005 AND bggo007 = g_bggm_m.bggm006 AND bggo008 = g_bggm_m.bggm007
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bggo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_bggm_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE abgt730_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_bggn_d.clear() 
      CALL g_bggn2_d.clear()       
 
     
      CALL abgt730_ui_browser_refresh()  
      #CALL abgt730_ui_headershow()  
      #CALL abgt730_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL abgt730_browser_fill("")
         CALL abgt730_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE abgt730_cl
 
   #功能已完成,通報訊息中心
   CALL abgt730_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abgt730.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgt730_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_bggn_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF abgt730_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT bggnseq,bggn010,bggn011,bggn012,bggn013,bggn014,bggn015,bggn016, 
             bggn017,bggn018,bggn019,bggn020,bggn021,bggn022,bggn023,bggn024,bggn025,bggn026,bggn037, 
             bggn038  FROM bggn_t",   
                     " INNER JOIN bggm_t ON bggment = " ||g_enterprise|| " AND bggm001 = bggn001 ",
                     " AND bggm002 = bggn002 ",
                     " AND bggm003 = bggn003 ",
                     " AND bggm004 = bggn004 ",
                     " AND bggm005 = bggn005 ",
                     " AND bggm006 = bggn006 ",
                     " AND bggm007 = bggn007 ",
 
                     #"",
                     " LEFT JOIN bggo_t ON bggnent = bggoent AND bggn001 = bggo001 AND bggn002 = bggo002 AND bggn003 = bggo003 AND bggn004 = bggo005 AND bggn005 = bggo006 AND bggn006 = bggo007 AND bggn007 = bggo008 AND bggnseq = bggoseq ",
                     "",
                     #下層單身所需的join條件
                     " ",
 
 
                     
                     " WHERE bggnent=? AND bggn001=? AND bggn002=? AND bggn003=? AND bggn004=? AND bggn005=? AND bggn006=? AND bggn007=?"
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
 
         
         LET g_sql = g_sql, " ORDER BY bggn_t.bggnseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abgt730_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abgt730_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004, 
          g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007 INTO g_bggn_d[l_ac].bggnseq,g_bggn_d[l_ac].bggn010, 
          g_bggn_d[l_ac].bggn011,g_bggn_d[l_ac].bggn012,g_bggn_d[l_ac].bggn013,g_bggn_d[l_ac].bggn014, 
          g_bggn_d[l_ac].bggn015,g_bggn_d[l_ac].bggn016,g_bggn_d[l_ac].bggn017,g_bggn_d[l_ac].bggn018, 
          g_bggn_d[l_ac].bggn019,g_bggn_d[l_ac].bggn020,g_bggn_d[l_ac].bggn021,g_bggn_d[l_ac].bggn022, 
          g_bggn_d[l_ac].bggn023,g_bggn_d[l_ac].bggn024,g_bggn_d[l_ac].bggn025,g_bggn_d[l_ac].bggn026, 
          g_bggn_d[l_ac].bggn037,g_bggn_d[l_ac].bggn038   #(ver:78)
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
   
   CALL g_bggn_d.deleteElement(g_bggn_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE abgt730_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_bggn_d.getLength()
      LET g_bggn_d_mask_o[l_ac].* =  g_bggn_d[l_ac].*
      CALL abgt730_bggn_t_mask()
      LET g_bggn_d_mask_n[l_ac].* =  g_bggn_d[l_ac].*
   END FOR
   
   LET g_bggn2_d_mask_o.* =  g_bggn2_d.*
   FOR l_ac = 1 TO g_bggn2_d.getLength()
      LET g_bggn2_d_mask_o[l_ac].* =  g_bggn2_d[l_ac].*
      CALL abgt730_bggo_t_mask()
      LET g_bggn2_d_mask_n[l_ac].* =  g_bggn2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="abgt730.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abgt730_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM bggn_t
       WHERE bggnent = g_enterprise AND
         bggn001 = ps_keys_bak[1] AND bggn002 = ps_keys_bak[2] AND bggn003 = ps_keys_bak[3] AND bggn004 = ps_keys_bak[4] AND bggn005 = ps_keys_bak[5] AND bggn006 = ps_keys_bak[6] AND bggn007 = ps_keys_bak[7] AND bggnseq = ps_keys_bak[8]
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
         CALL g_bggn_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM bggo_t
       WHERE bggoent = g_enterprise AND
             bggo001 = ps_keys_bak[1] AND bggo002 = ps_keys_bak[2] AND bggo003 = ps_keys_bak[3] AND bggo005 = ps_keys_bak[4] AND bggo006 = ps_keys_bak[5] AND bggo007 = ps_keys_bak[6] AND bggo008 = ps_keys_bak[7] AND bggoseq = ps_keys_bak[8] AND bggoseq2 = ps_keys_bak[9]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bggo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_bggn2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abgt730.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abgt730_insert_b(ps_table,ps_keys,ps_page)
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
      #如果核算項沒有輸入就給空值
      IF cl_null(g_bggn_d[g_detail_idx].bggn014) THEN LET g_bggn_d[g_detail_idx].bggn014 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn015) THEN LET g_bggn_d[g_detail_idx].bggn015 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn016) THEN LET g_bggn_d[g_detail_idx].bggn016 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn017) THEN LET g_bggn_d[g_detail_idx].bggn017 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn018) THEN LET g_bggn_d[g_detail_idx].bggn018 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn019) THEN LET g_bggn_d[g_detail_idx].bggn019 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn020) THEN LET g_bggn_d[g_detail_idx].bggn020 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn021) THEN LET g_bggn_d[g_detail_idx].bggn021 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn022) THEN LET g_bggn_d[g_detail_idx].bggn022 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn023) THEN LET g_bggn_d[g_detail_idx].bggn023 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn024) THEN LET g_bggn_d[g_detail_idx].bggn024 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn025) THEN LET g_bggn_d[g_detail_idx].bggn025 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn026) THEN LET g_bggn_d[g_detail_idx].bggn026 = ' ' END IF
      #end add-point 
      INSERT INTO bggn_t
                  (bggnent,
                   bggn001,bggn002,bggn003,bggn004,bggn005,bggn006,bggn007,
                   bggnseq
                   ,bggn010,bggn011,bggn012,bggn013,bggn014,bggn015,bggn016,bggn017,bggn018,bggn019,bggn020,bggn021,bggn022,bggn023,bggn024,bggn025,bggn026,bggn037,bggn038) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8]
                   ,g_bggn_d[g_detail_idx].bggn010,g_bggn_d[g_detail_idx].bggn011,g_bggn_d[g_detail_idx].bggn012, 
                       g_bggn_d[g_detail_idx].bggn013,g_bggn_d[g_detail_idx].bggn014,g_bggn_d[g_detail_idx].bggn015, 
                       g_bggn_d[g_detail_idx].bggn016,g_bggn_d[g_detail_idx].bggn017,g_bggn_d[g_detail_idx].bggn018, 
                       g_bggn_d[g_detail_idx].bggn019,g_bggn_d[g_detail_idx].bggn020,g_bggn_d[g_detail_idx].bggn021, 
                       g_bggn_d[g_detail_idx].bggn022,g_bggn_d[g_detail_idx].bggn023,g_bggn_d[g_detail_idx].bggn024, 
                       g_bggn_d[g_detail_idx].bggn025,g_bggn_d[g_detail_idx].bggn026,g_bggn_d[g_detail_idx].bggn037, 
                       g_bggn_d[g_detail_idx].bggn038)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
 
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bggn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_bggn_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      #自由核算項要給空值
      UPDATE bggn_t 
         SET (bggn008,bggn009,
              bggn027,bggn028,bggn029,bggn030,bggn031,
              bggn032,bggn033,bggn034,bggn035,bggn036)
             = 
             (g_bggm_m.bggm008,g_bggm_m.bggm009,
              ' ',' ',' ',' ',' ',
              ' ',' ',' ',' ',' ')
      WHERE bggnent = g_enterprise AND bggn001 = ps_keys[1] AND bggn002 = ps_keys[2]
        AND bggn003 = ps_keys[3] AND bggn004 = ps_keys[4] AND bggn005 = ps_keys[5]
        AND bggn006 = ps_keys[6] AND bggn007 = ps_keys[7] AND bggnseq = ps_keys[8]
      #end add-point 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO bggo_t
                  (bggoent,
                   bggo001,bggo002,bggo003,bggo005,bggo006,bggo007,bggo008,bggoseq,
                   bggoseq2
                   ,bggo009,bggo100,bggo101,bggo036,bggo035,bggo103,bggo104,bggo106,bggo039,bggo040) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9]
                   ,g_bggn2_d[g_detail_idx2].bggo009,g_bggn2_d[g_detail_idx2].bggo100,g_bggn2_d[g_detail_idx2].bggo101, 
                       g_bggn2_d[g_detail_idx2].bggo036,g_bggn2_d[g_detail_idx2].bggo035,g_bggn2_d[g_detail_idx2].bggo103, 
                       g_bggn2_d[g_detail_idx2].bggo104,g_bggn2_d[g_detail_idx2].bggo106,g_bggn2_d[g_detail_idx2].bggo039, 
                       g_bggn2_d[g_detail_idx2].bggo040)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bggo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_bggn2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="abgt730.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abgt730_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bggn_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      #如果核算項沒有輸入就給空值
      IF cl_null(g_bggn_d[g_detail_idx].bggn014) THEN LET g_bggn_d[g_detail_idx].bggn014 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn015) THEN LET g_bggn_d[g_detail_idx].bggn015 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn016) THEN LET g_bggn_d[g_detail_idx].bggn016 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn017) THEN LET g_bggn_d[g_detail_idx].bggn017 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn018) THEN LET g_bggn_d[g_detail_idx].bggn018 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn019) THEN LET g_bggn_d[g_detail_idx].bggn019 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn020) THEN LET g_bggn_d[g_detail_idx].bggn020 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn021) THEN LET g_bggn_d[g_detail_idx].bggn021 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn022) THEN LET g_bggn_d[g_detail_idx].bggn022 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn023) THEN LET g_bggn_d[g_detail_idx].bggn023 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn024) THEN LET g_bggn_d[g_detail_idx].bggn024 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn025) THEN LET g_bggn_d[g_detail_idx].bggn025 = ' ' END IF
      IF cl_null(g_bggn_d[g_detail_idx].bggn026) THEN LET g_bggn_d[g_detail_idx].bggn026 = ' ' END IF
      #end add-point 
      
      #將遮罩欄位還原
      CALL abgt730_bggn_t_mask_restore('restore_mask_o')
               
      UPDATE bggn_t 
         SET (bggn001,bggn002,bggn003,bggn004,bggn005,bggn006,bggn007,
              bggnseq
              ,bggn010,bggn011,bggn012,bggn013,bggn014,bggn015,bggn016,bggn017,bggn018,bggn019,bggn020,bggn021,bggn022,bggn023,bggn024,bggn025,bggn026,bggn037,bggn038) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8]
              ,g_bggn_d[g_detail_idx].bggn010,g_bggn_d[g_detail_idx].bggn011,g_bggn_d[g_detail_idx].bggn012, 
                  g_bggn_d[g_detail_idx].bggn013,g_bggn_d[g_detail_idx].bggn014,g_bggn_d[g_detail_idx].bggn015, 
                  g_bggn_d[g_detail_idx].bggn016,g_bggn_d[g_detail_idx].bggn017,g_bggn_d[g_detail_idx].bggn018, 
                  g_bggn_d[g_detail_idx].bggn019,g_bggn_d[g_detail_idx].bggn020,g_bggn_d[g_detail_idx].bggn021, 
                  g_bggn_d[g_detail_idx].bggn022,g_bggn_d[g_detail_idx].bggn023,g_bggn_d[g_detail_idx].bggn024, 
                  g_bggn_d[g_detail_idx].bggn025,g_bggn_d[g_detail_idx].bggn026,g_bggn_d[g_detail_idx].bggn037, 
                  g_bggn_d[g_detail_idx].bggn038) 
         WHERE bggnent = g_enterprise AND bggn001 = ps_keys_bak[1] AND bggn002 = ps_keys_bak[2] AND bggn003 = ps_keys_bak[3] AND bggn004 = ps_keys_bak[4] AND bggn005 = ps_keys_bak[5] AND bggn006 = ps_keys_bak[6] AND bggn007 = ps_keys_bak[7] AND bggnseq = ps_keys_bak[8]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bggn_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bggn_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL abgt730_bggn_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bggo_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL abgt730_bggo_t_mask_restore('restore_mask_o')
               
      UPDATE bggo_t 
         SET (bggo001,bggo002,bggo003,bggo005,bggo006,bggo007,bggo008,bggoseq,
              bggoseq2
              ,bggo009,bggo100,bggo101,bggo036,bggo035,bggo103,bggo104,bggo106,bggo039,bggo040) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9]
              ,g_bggn2_d[g_detail_idx2].bggo009,g_bggn2_d[g_detail_idx2].bggo100,g_bggn2_d[g_detail_idx2].bggo101, 
                  g_bggn2_d[g_detail_idx2].bggo036,g_bggn2_d[g_detail_idx2].bggo035,g_bggn2_d[g_detail_idx2].bggo103, 
                  g_bggn2_d[g_detail_idx2].bggo104,g_bggn2_d[g_detail_idx2].bggo106,g_bggn2_d[g_detail_idx2].bggo039, 
                  g_bggn2_d[g_detail_idx2].bggo040) 
         WHERE bggoent = g_enterprise AND bggo001 = ps_keys_bak[1] AND bggo002 = ps_keys_bak[2] AND bggo003 = ps_keys_bak[3] AND bggo005 = ps_keys_bak[4] AND bggo006 = ps_keys_bak[5] AND bggo007 = ps_keys_bak[6] AND bggo008 = ps_keys_bak[7] AND bggoseq = ps_keys_bak[8] AND bggoseq2 = ps_keys_bak[9]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bggo_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bggo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL abgt730_bggo_t_mask_restore('restore_mask_n')
               
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
 
{<section id="abgt730.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION abgt730_key_update_b(ps_keys_bak,ps_table)
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
   IF ps_table = 'bggn_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update2"
      
      #end add-point
      
      UPDATE bggo_t 
         SET (bggo001,bggo002,bggo003,bggo005,bggo006,bggo007,bggo008,bggoseq) 
              = 
             (g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006, 
                 g_bggm_m.bggm007,g_bggn_d[g_detail_idx].bggnseq) 
         WHERE bggoent = g_enterprise AND
               bggo001 = ps_keys_bak[1] AND bggo002 = ps_keys_bak[2] AND bggo003 = ps_keys_bak[3] AND bggo005 = ps_keys_bak[4] AND bggo006 = ps_keys_bak[5] AND bggo007 = ps_keys_bak[6] AND bggo008 = ps_keys_bak[7] AND bggoseq = ps_keys_bak[8]
 
      #add-point:update_b段修改中 name="key_update_b.m_update2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bggo_t:",SQLERRMESSAGE 
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
 
{<section id="abgt730.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abgt730_key_delete_b(ps_keys_bak,ps_table)
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
   IF ps_table = 'bggn_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete2"
      
      #end add-point
      
      DELETE FROM bggo_t 
            WHERE bggoent = g_enterprise AND
                  bggo001 = ps_keys_bak[1] AND bggo002 = ps_keys_bak[2] AND bggo003 = ps_keys_bak[3] AND bggo005 = ps_keys_bak[4] AND bggo006 = ps_keys_bak[5] AND bggo007 = ps_keys_bak[6] AND bggo008 = ps_keys_bak[7] AND bggoseq = ps_keys_bak[8]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bggo_t:",SQLERRMESSAGE 
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
 
{<section id="abgt730.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abgt730_lock_b(ps_table,ps_page)
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
   #CALL abgt730_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "bggn_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN abgt730_bcl USING g_enterprise,
                                       g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004, 
                                           g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007,g_bggn_d[g_detail_idx].bggnseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abgt730_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "bggo_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN abgt730_bcl2 USING g_enterprise,
                                             g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004, 
                                                 g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007, 
                                                 g_bggn_d[g_detail_idx].bggnseq,
                                             g_bggn2_d[g_detail_idx2].bggoseq2
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abgt730_bcl2:",SQLERRMESSAGE 
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
 
{<section id="abgt730.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abgt730_unlock_b(ps_table,ps_page)
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
      CLOSE abgt730_bcl
   END IF
   
 
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE abgt730_bcl2
   END IF
 
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="abgt730.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abgt730_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bggm001,bggm002,bggm003,bggm004,bggm005,bggm006,bggm007",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("bggm008",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt730.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abgt730_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bggm001,bggm002,bggm003,bggm004,bggm005,bggm006,bggm007",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("bggm008",FALSE)
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
 
{<section id="abgt730.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abgt730_set_entry_b(p_cmd)
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
 
{<section id="abgt730.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abgt730_set_no_entry_b(p_cmd)
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
 
{<section id="abgt730.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abgt730_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abgt730.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abgt730_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_bggm_m.bggmstus NOT MATCHES "[NDR]" THEN
      CALL cl_set_act_visible('modify,modify_detail,delete',FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abgt730.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abgt730_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abgt730.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abgt730_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abgt730.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abgt730_default_search()
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
      LET ls_wc = ls_wc, " bggm001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bggm002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bggm003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " bggm004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " bggm005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " bggm006 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " bggm007 = '", g_argv[07], "' AND "
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
               WHEN la_wc[li_idx].tableid = "bggm_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "bggn_t" 
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
 
{<section id="abgt730.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION abgt730_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_bggm_m.bggm001 IS NULL
      OR g_bggm_m.bggm002 IS NULL      OR g_bggm_m.bggm003 IS NULL      OR g_bggm_m.bggm004 IS NULL      OR g_bggm_m.bggm005 IS NULL      OR g_bggm_m.bggm006 IS NULL      OR g_bggm_m.bggm007 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN abgt730_cl USING g_enterprise,g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007
   IF STATUS THEN
      CLOSE abgt730_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt730_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE abgt730_master_referesh USING g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004, 
       g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007 INTO g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm008, 
       g_bggm_m.bggm001,g_bggm_m.bggm005,g_bggm_m.bggm009,g_bggm_m.bggm004,g_bggm_m.bggm006,g_bggm_m.bggm007, 
       g_bggm_m.bggmstus,g_bggm_m.bggmownid,g_bggm_m.bggmowndp,g_bggm_m.bggmcrtid,g_bggm_m.bggmcrtdp, 
       g_bggm_m.bggmcrtdt,g_bggm_m.bggmmodid,g_bggm_m.bggmmoddt,g_bggm_m.bggmcnfid,g_bggm_m.bggmcnfdt, 
       g_bggm_m.bggmownid_desc,g_bggm_m.bggmowndp_desc,g_bggm_m.bggmcrtid_desc,g_bggm_m.bggmcrtdp_desc, 
       g_bggm_m.bggmmodid_desc,g_bggm_m.bggmcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT abgt730_action_chk() THEN
      CLOSE abgt730_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bggm_m.bggm002,g_bggm_m.bggm002_desc,g_bggm_m.bggm003,g_bggm_m.bggm008,g_bggm_m.bggm008_desc, 
       g_bggm_m.bggm001,g_bggm_m.bggm005,g_bggm_m.bgaa002,g_bggm_m.bgaa003,g_bggm_m.bggm009,g_bggm_m.bggm004, 
       g_bggm_m.bggm006,g_bggm_m.bggm006_desc,g_bggm_m.bggm007,g_bggm_m.bggmstus,g_bggm_m.bggmownid, 
       g_bggm_m.bggmownid_desc,g_bggm_m.bggmowndp,g_bggm_m.bggmowndp_desc,g_bggm_m.bggmcrtid,g_bggm_m.bggmcrtid_desc, 
       g_bggm_m.bggmcrtdp,g_bggm_m.bggmcrtdp_desc,g_bggm_m.bggmcrtdt,g_bggm_m.bggmmodid,g_bggm_m.bggmmodid_desc, 
       g_bggm_m.bggmmoddt,g_bggm_m.bggmcnfid,g_bggm_m.bggmcnfid_desc,g_bggm_m.bggmcnfdt
 
   CASE g_bggm_m.bggmstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "FC"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/final_confirmed.png")
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
         CASE g_bggm_m.bggmstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "FC"
               HIDE OPTION "final_confirmed"
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
      CALL cl_set_act_visible("signing,withdraw,final_confirmed",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      
      CASE g_bggm_m.bggmstus
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "FC"
            CALL cl_set_act_visible("invalid,confirmed,final_confirmed,unconfirmed",FALSE)
            CALL s_transaction_end('N','0')
            RETURN
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
            CALL s_transaction_end('N','0')
            RETURN
         WHEN "A"   #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         WHEN "W"   #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT abgt730_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE abgt730_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT abgt730_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE abgt730_cl
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
      ON ACTION final_confirmed
         IF cl_auth_chk_act("final_confirmed") THEN
            LET lc_state = "FC"
            #add-point:action控制 name="statechange.final_confirmed"
            
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
      AND lc_state <> "FC"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_bggm_m.bggmstus = lc_state OR cl_null(lc_state) THEN
      CLOSE abgt730_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   IF lc_state = 'Y' THEN
      CALL cl_err_collect_init()
      IF NOT s_abgt730_conf_chk(g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007) THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_abgt730_conf_upd(g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007) THEN
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
   #取消確認
   IF lc_state = 'N' THEN
      CALL cl_err_collect_init()
      IF NOT s_abgt730_unconf_chk(g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007) THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_abgt730_unconf_upd(g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_bggm_m.bggmmodid = g_user
   LET g_bggm_m.bggmmoddt = cl_get_current()
   LET g_bggm_m.bggmstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE bggm_t 
      SET (bggmstus,bggmmodid,bggmmoddt) 
        = (g_bggm_m.bggmstus,g_bggm_m.bggmmodid,g_bggm_m.bggmmoddt)     
    WHERE bggment = g_enterprise AND bggm001 = g_bggm_m.bggm001
      AND bggm002 = g_bggm_m.bggm002      AND bggm003 = g_bggm_m.bggm003      AND bggm004 = g_bggm_m.bggm004      AND bggm005 = g_bggm_m.bggm005      AND bggm006 = g_bggm_m.bggm006      AND bggm007 = g_bggm_m.bggm007
    
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
         WHEN "FC"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/final_confirmed.png")
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
      EXECUTE abgt730_master_referesh USING g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004, 
          g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007 INTO g_bggm_m.bggm002,g_bggm_m.bggm003, 
          g_bggm_m.bggm008,g_bggm_m.bggm001,g_bggm_m.bggm005,g_bggm_m.bggm009,g_bggm_m.bggm004,g_bggm_m.bggm006, 
          g_bggm_m.bggm007,g_bggm_m.bggmstus,g_bggm_m.bggmownid,g_bggm_m.bggmowndp,g_bggm_m.bggmcrtid, 
          g_bggm_m.bggmcrtdp,g_bggm_m.bggmcrtdt,g_bggm_m.bggmmodid,g_bggm_m.bggmmoddt,g_bggm_m.bggmcnfid, 
          g_bggm_m.bggmcnfdt,g_bggm_m.bggmownid_desc,g_bggm_m.bggmowndp_desc,g_bggm_m.bggmcrtid_desc, 
          g_bggm_m.bggmcrtdp_desc,g_bggm_m.bggmmodid_desc,g_bggm_m.bggmcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_bggm_m.bggm002,g_bggm_m.bggm002_desc,g_bggm_m.bggm003,g_bggm_m.bggm008,g_bggm_m.bggm008_desc, 
          g_bggm_m.bggm001,g_bggm_m.bggm005,g_bggm_m.bgaa002,g_bggm_m.bgaa003,g_bggm_m.bggm009,g_bggm_m.bggm004, 
          g_bggm_m.bggm006,g_bggm_m.bggm006_desc,g_bggm_m.bggm007,g_bggm_m.bggmstus,g_bggm_m.bggmownid, 
          g_bggm_m.bggmownid_desc,g_bggm_m.bggmowndp,g_bggm_m.bggmowndp_desc,g_bggm_m.bggmcrtid,g_bggm_m.bggmcrtid_desc, 
          g_bggm_m.bggmcrtdp,g_bggm_m.bggmcrtdp_desc,g_bggm_m.bggmcrtdt,g_bggm_m.bggmmodid,g_bggm_m.bggmmodid_desc, 
          g_bggm_m.bggmmoddt,g_bggm_m.bggmcnfid,g_bggm_m.bggmcnfid_desc,g_bggm_m.bggmcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE abgt730_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt730_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt730.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abgt730_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_bggn_d.getLength() THEN
         LET g_detail_idx = g_bggn_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bggn_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bggn_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_bggn2_d.getLength() THEN
         LET g_detail_idx2 = g_bggn2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_bggn2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_bggn2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt730.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgt730_b_fill2(pi_idx)
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
   
   IF abgt730_fill_chk(2) THEN
      IF (pi_idx = 2 OR pi_idx = 0 ) AND g_bggn_d.getLength() > 0 THEN
               CALL g_bggn2_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT bggoseq2,bggo009,bggo100,bggo101,bggo036,bggo035,bggo103,bggo104, 
             bggo106,bggo039,bggo040  FROM bggo_t",    
                     "",
                     
                     " WHERE bggoent=? AND bggo001=? AND bggo002=? AND bggo003=? AND bggo005=? AND bggo006=? AND bggo007=? AND bggo008=? AND bggoseq=?"
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  bggo_t.bggoseq2" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill2"
         
         #end add-point
         
         #先清空資料
               CALL g_bggn2_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abgt730_pb2 FROM g_sql
         DECLARE b_fill_curs2 CURSOR FOR abgt730_pb2
         
      #  OPEN b_fill_curs2 USING g_enterprise,g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003,g_bggm_m.bggm004, 
      #    g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007,g_bggn_d[g_detail_idx].bggnseq   #(ver:78) 
 
         LET l_ac = 1
         FOREACH b_fill_curs2 USING g_enterprise,g_bggm_m.bggm001,g_bggm_m.bggm002,g_bggm_m.bggm003, 
             g_bggm_m.bggm004,g_bggm_m.bggm005,g_bggm_m.bggm006,g_bggm_m.bggm007,g_bggn_d[g_detail_idx].bggnseq INTO g_bggn2_d[l_ac].bggoseq2, 
             g_bggn2_d[l_ac].bggo009,g_bggn2_d[l_ac].bggo100,g_bggn2_d[l_ac].bggo101,g_bggn2_d[l_ac].bggo036, 
             g_bggn2_d[l_ac].bggo035,g_bggn2_d[l_ac].bggo103,g_bggn2_d[l_ac].bggo104,g_bggn2_d[l_ac].bggo106, 
             g_bggn2_d[l_ac].bggo039,g_bggn2_d[l_ac].bggo040   #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill2"
            
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
               CALL g_bggn2_d.deleteElement(g_bggn2_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_bggn2_d_mask_o.* =  g_bggn2_d.*
   FOR l_ac = 1 TO g_bggn2_d.getLength()
      LET g_bggn2_d_mask_o[l_ac].* =  g_bggn2_d[l_ac].*
      CALL abgt730_bggo_t_mask()
      LET g_bggn2_d_mask_n[l_ac].* =  g_bggn2_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL abgt730_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="abgt730.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abgt730_fill_chk(ps_idx)
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
 
{<section id="abgt730.status_show" >}
PRIVATE FUNCTION abgt730_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt730.mask_functions" >}
&include "erp/abg/abgt730_mask.4gl"
 
{</section>}
 
{<section id="abgt730.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION abgt730_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL abgt730_show()
   CALL abgt730_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_bggm_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_bggn_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_bggn2_d))
 
 
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
   #CALL abgt730_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL abgt730_ui_headershow()
   CALL abgt730_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION abgt730_draw_out()
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
   CALL abgt730_ui_headershow()  
   CALL abgt730_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="abgt730.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abgt730_set_pk_array()
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
   LET g_pk_array[1].values = g_bggm_m.bggm001
   LET g_pk_array[1].column = 'bggm001'
   LET g_pk_array[2].values = g_bggm_m.bggm002
   LET g_pk_array[2].column = 'bggm002'
   LET g_pk_array[3].values = g_bggm_m.bggm003
   LET g_pk_array[3].column = 'bggm003'
   LET g_pk_array[4].values = g_bggm_m.bggm004
   LET g_pk_array[4].column = 'bggm004'
   LET g_pk_array[5].values = g_bggm_m.bggm005
   LET g_pk_array[5].column = 'bggm005'
   LET g_pk_array[6].values = g_bggm_m.bggm006
   LET g_pk_array[6].column = 'bggm006'
   LET g_pk_array[7].values = g_bggm_m.bggm007
   LET g_pk_array[7].column = 'bggm007'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt730.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="abgt730.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abgt730_msgcentre_notify(lc_state)
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
   CALL abgt730_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bggm_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt730.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION abgt730_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abgt730.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 依照人工來源開啟or關閉欄位
# Memo...........:
# Usage..........: CALL abgt730_set_all_entery(p_bggm004)
# Date & Author..: 2016/12/14 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt730_set_all_entery(p_bggm004)
DEFINE p_bggm004     LIKE bggm_t.bggm004

   CALL cl_set_comp_entry("bggn010,bggn011,bggn012,bggn013",TRUE)
   CALL cl_set_comp_entry("bggn014,bggn015,bggn016,bggn017,bggn018",TRUE)
   CALL cl_set_comp_entry("bggn019,bggn020,bggn021,bggn022,bggn023",TRUE)
   CALL cl_set_comp_entry("bggn024,bggn025,bggn026",TRUE)
   CALL cl_set_comp_entry("bggn014_desc,bggn015_desc,bggn016_desc,bggn017_desc,bggn018_desc",TRUE)
   CALL cl_set_comp_entry("bggn019_desc,bggn020_desc,bggn021_desc,bggn022_desc,bggn023_desc",TRUE)
   CALL cl_set_comp_entry("bggn024_desc,bggn025_desc,bggn026_desc",TRUE)
   CALL cl_set_comp_entry("bggn038",TRUE)
   CALL cl_set_comp_entry("bggo100,bggo036,bggo104",TRUE)
   IF p_bggm004 = '2' THEN #2:匯入
      CALL cl_set_comp_entry("bggn010,bggn011,bggn012,bggn013",FALSE)
      CALL cl_set_comp_entry("bggn014,bggn015,bggn016,bggn017,bggn018",FALSE)
      CALL cl_set_comp_entry("bggn019,bggn020,bggn021,bggn022,bggn023",FALSE)
      CALL cl_set_comp_entry("bggn024,bggn025,bggn026",FALSE)
      CALL cl_set_comp_entry("bggn014_desc,bggn015_desc,bggn016_desc,bggn017_desc,bggn018_desc",FALSE)
      CALL cl_set_comp_entry("bggn019_desc,bggn020_desc,bggn021_desc,bggn022_desc,bggn023_desc",FALSE)
      CALL cl_set_comp_entry("bggn024_desc,bggn025_desc,bggn026_desc",FALSE)
      CALL cl_set_comp_entry("bggn038",FALSE)
      CALL cl_set_comp_entry("bggo100,bggo036",FALSE)
   END IF

END FUNCTION

################################################################################
# Descriptions...: 依樣表設置核算項隱顯
# Memo...........:
# Usage..........: CALL abgt730_set_entry_bggm009()
# Date & Author..: 2016/12/21 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt730_set_entry_bggm009(p_bggm002,p_bggm008,p_bggm009)
DEFINE p_bggm002     LIKE bggm_t.bggm002  #預算編號
DEFINE p_bggm008     LIKE bggm_t.bggm008  #管理組織
DEFINE p_bggm009     LIKE bggm_t.bggm009  #樣表編號
DEFINE l_sql         STRING
DEFINE l_bgaw        RECORD
                        bgaw004   LIKE bgaw_t.bgaw004,
                        bgaw005   LIKE bgaw_t.bgaw005
                     END RECORD
DEFINE l_open        STRING
DEFINE l_close       STRING

   #若無樣板則去abgi090取
   IF cl_null(p_bggm009) THEN
      SELECT bgai008 INTO p_bggm009
        FROM bgai_t
       WHERE bgaient = g_enterprise
         AND bgai001 = p_bggm002
         AND bgai002 = p_bggm008
   END IF
   
   LET l_open = ""
   LET l_close = ""
   #預算維度/使用否
   LET l_sql = " SELECT bgaw004,bgaw005",
               "   FROM bgaw_t ",
               "  WHERE bgawent = ",g_enterprise," ",
               "    AND bgaw001 = '",p_bggm009,"' "
   PREPARE abgt730_sel_bgaw_p1 FROM l_sql
   DECLARE abgt730_sel_bgaw_c1 CURSOR FOR abgt730_sel_bgaw_p1
   FOREACH abgt730_sel_bgaw_c1 INTO l_bgaw.*
      IF l_bgaw.bgaw005 = "Y" THEN
         CASE l_bgaw.bgaw004
            WHEN "2"    #部門
               LET l_open = l_open,"bggn015_desc,"
            WHEN "3"    #利潤成本中心
               LET l_open = l_open,"bggn016_desc,"
            WHEN "4"    #區域
               LET l_open = l_open,"bggn017_desc,"
            WHEN "5"    #收付款供應商
               LET l_open = l_open,"bggn018_desc,"
            WHEN "6"    #收款客商
               LET l_open = l_open,"bggn019_desc,"
            WHEN "7"    #客群
               LET l_open = l_open,"bggn020_desc,"
            WHEN "8"    #產品類別
               LET l_open = l_open,"bggn021_desc,"
            WHEN "9"    #經營方式
               LET l_open = l_open,"bggn024_desc,"
            WHEN "10"   #渠道
               LET l_open = l_open,"bggn025_desc,"
            WHEN "11"   #品牌
               LET l_open = l_open,"bggn026_desc,"
            WHEN "12"   #人員
               LET l_open = l_open,"bggn014_desc,"
            WHEN "13"   #專案編號
               LET l_open = l_open,"bggn022_desc,"
            WHEN "14"   #WBS
               LET l_open = l_open,"bggn023_desc,"
         END CASE
      ELSE
         CASE l_bgaw.bgaw004
            WHEN "2"    #部門
               LET l_close = l_close,"bggn015_desc,"
            WHEN "3"    #利潤成本中心
               LET l_close = l_close,"bggn016_desc,"
            WHEN "4"    #區域
               LET l_close = l_close,"bggn017_desc,"
            WHEN "5"    #收付款供應商
               LET l_close = l_close,"bggn018_desc,"
            WHEN "6"    #收款客商
               LET l_close = l_close,"bggn019_desc,"
            WHEN "7"    #客群
               LET l_close = l_close,"bggn020_desc,"
            WHEN "8"    #產品類別
               LET l_close = l_close,"bggn021_desc,"
            WHEN "9"    #經營方式
               LET l_close = l_close,"bggn024_desc,"
            WHEN "10"   #渠道
               LET l_close = l_close,"bggn025_desc,"
            WHEN "11"   #品牌
               LET l_close = l_close,"bggn026_desc,"
            WHEN "12"   #人員
               LET l_close = l_close,"bggn014_desc,"
            WHEN "13"   #專案編號
               LET l_close = l_close,"bggn022_desc,"
            WHEN "14"   #WBS
               LET l_close = l_close,"bggn023_desc,"
         END CASE
      END IF
      
   END FOREACH
   
   LET l_open = l_open.subString(1,l_open.getLength()-1)
   LET l_close = l_close.subString(1,l_close.getLength()-1)
   
   CALL cl_set_comp_visible(l_open,TRUE)
   CALL cl_set_comp_visible(l_close,FALSE)
   
END FUNCTION

 
{</section>}
 
