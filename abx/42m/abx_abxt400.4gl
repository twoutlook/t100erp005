#該程式未解開Section, 採用最新樣板產出!
{<section id="abxt400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-10-26 14:52:36), PR版次:0003(2017-02-09 17:31:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abxt400
#+ Description: 放行單管制作業
#+ Creator....: 02294(2016-10-26 14:52:36)
#+ Modifier...: 02294 -SD/PR- 08734
 
{</section>}
 
{<section id="abxt400.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#170117-00003#1    2017/01/17   By lixiang 查询出来的资料区分营运据点
#170207-00018#1    2017/02/09   By 08734   ROWNUM整批调整
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
PRIVATE type type_g_bxea_m        RECORD
       bxeasite LIKE bxea_t.bxeasite, 
   bxeadocno LIKE bxea_t.bxeadocno, 
   bxeadocno_desc LIKE type_t.chr80, 
   bxeadocdt LIKE bxea_t.bxeadocdt, 
   bxea001 LIKE bxea_t.bxea001, 
   bxea002 LIKE bxea_t.bxea002, 
   bxea002_desc LIKE type_t.chr80, 
   bxea003 LIKE bxea_t.bxea003, 
   bxea003_desc LIKE type_t.chr80, 
   bxeastus LIKE bxea_t.bxeastus, 
   bxea004 LIKE bxea_t.bxea004, 
   bxea005 LIKE bxea_t.bxea005, 
   bxea006 LIKE bxea_t.bxea006, 
   bxea007 LIKE bxea_t.bxea007, 
   bxea008 LIKE bxea_t.bxea008, 
   bxea008_desc LIKE type_t.chr80, 
   bxea009 LIKE bxea_t.bxea009, 
   bxea010 LIKE bxea_t.bxea010, 
   bxea010_desc LIKE type_t.chr80, 
   bxea011 LIKE bxea_t.bxea011, 
   bxea012 LIKE bxea_t.bxea012, 
   bxea013 LIKE bxea_t.bxea013, 
   bxea014 LIKE bxea_t.bxea014, 
   bxea015 LIKE bxea_t.bxea015, 
   bxea016 LIKE bxea_t.bxea016, 
   oofb017 LIKE type_t.chr500, 
   bxea017 LIKE bxea_t.bxea017, 
   bxea018 LIKE bxea_t.bxea018, 
   bxea019 LIKE bxea_t.bxea019, 
   bxea020 LIKE bxea_t.bxea020, 
   bxeaownid LIKE bxea_t.bxeaownid, 
   bxeaownid_desc LIKE type_t.chr80, 
   bxeaowndp LIKE bxea_t.bxeaowndp, 
   bxeaowndp_desc LIKE type_t.chr80, 
   bxeacrtid LIKE bxea_t.bxeacrtid, 
   bxeacrtid_desc LIKE type_t.chr80, 
   bxeacrtdp LIKE bxea_t.bxeacrtdp, 
   bxeacrtdp_desc LIKE type_t.chr80, 
   bxeacrtdt LIKE bxea_t.bxeacrtdt, 
   bxeamodid LIKE bxea_t.bxeamodid, 
   bxeamodid_desc LIKE type_t.chr80, 
   bxeamoddt LIKE bxea_t.bxeamoddt, 
   bxeacnfid LIKE bxea_t.bxeacnfid, 
   bxeacnfid_desc LIKE type_t.chr80, 
   bxeacnfdt LIKE bxea_t.bxeacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bxeb_d        RECORD
       bxebsite LIKE bxeb_t.bxebsite, 
   bxebseq LIKE bxeb_t.bxebseq, 
   bxeb001 LIKE bxeb_t.bxeb001, 
   bxeb002 LIKE bxeb_t.bxeb002, 
   bxeb003 LIKE bxeb_t.bxeb003, 
   bxeb003_desc LIKE type_t.chr500, 
   bxeb003_desc_1 LIKE type_t.chr500, 
   iman012 LIKE type_t.chr500, 
   bxeb004 LIKE bxeb_t.bxeb004, 
   bxeb004_desc LIKE type_t.chr500, 
   bxeb005 LIKE bxeb_t.bxeb005, 
   bxeb006 LIKE bxeb_t.bxeb006, 
   bxeb006_desc LIKE type_t.chr500, 
   bxeb007 LIKE bxeb_t.bxeb007, 
   bxeb008 LIKE bxeb_t.bxeb008, 
   bxeb009 LIKE bxeb_t.bxeb009
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_bxeadocno LIKE bxea_t.bxeadocno,
      b_bxeadocdt LIKE bxea_t.bxeadocdt,
      b_bxea001 LIKE bxea_t.bxea001,
      b_bxea002 LIKE bxea_t.bxea002,
   b_bxea002_desc LIKE type_t.chr80,
      b_bxea003 LIKE bxea_t.bxea003,
   b_bxea003_desc LIKE type_t.chr80,
      b_bxea004 LIKE bxea_t.bxea004,
      b_bxea010 LIKE bxea_t.bxea010,
   b_bxea010_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_flag        LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_bxea_m          type_g_bxea_m
DEFINE g_bxea_m_t        type_g_bxea_m
DEFINE g_bxea_m_o        type_g_bxea_m
DEFINE g_bxea_m_mask_o   type_g_bxea_m #轉換遮罩前資料
DEFINE g_bxea_m_mask_n   type_g_bxea_m #轉換遮罩後資料
 
   DEFINE g_bxeadocno_t LIKE bxea_t.bxeadocno
 
 
DEFINE g_bxeb_d          DYNAMIC ARRAY OF type_g_bxeb_d
DEFINE g_bxeb_d_t        type_g_bxeb_d
DEFINE g_bxeb_d_o        type_g_bxeb_d
DEFINE g_bxeb_d_mask_o   DYNAMIC ARRAY OF type_g_bxeb_d #轉換遮罩前資料
DEFINE g_bxeb_d_mask_n   DYNAMIC ARRAY OF type_g_bxeb_d #轉換遮罩後資料
 
 
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
 
{<section id="abxt400.main" >}
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
   CALL cl_ap_init("abx","")
 
   #add-point:作業初始化 name="main.init"
   CALL abxt400_02_create_temp_table()
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT bxeasite,bxeadocno,'',bxeadocdt,bxea001,bxea002,'',bxea003,'',bxeastus, 
       bxea004,bxea005,bxea006,bxea007,bxea008,'',bxea009,bxea010,'',bxea011,bxea012,bxea013,bxea014, 
       bxea015,bxea016,'',bxea017,bxea018,bxea019,bxea020,bxeaownid,'',bxeaowndp,'',bxeacrtid,'',bxeacrtdp, 
       '',bxeacrtdt,bxeamodid,'',bxeamoddt,bxeacnfid,'',bxeacnfdt", 
                      " FROM bxea_t",
                      " WHERE bxeaent= ? AND bxeadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abxt400_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bxeasite,t0.bxeadocno,t0.bxeadocdt,t0.bxea001,t0.bxea002,t0.bxea003, 
       t0.bxeastus,t0.bxea004,t0.bxea005,t0.bxea006,t0.bxea007,t0.bxea008,t0.bxea009,t0.bxea010,t0.bxea011, 
       t0.bxea012,t0.bxea013,t0.bxea014,t0.bxea015,t0.bxea016,t0.bxea017,t0.bxea018,t0.bxea019,t0.bxea020, 
       t0.bxeaownid,t0.bxeaowndp,t0.bxeacrtid,t0.bxeacrtdp,t0.bxeacrtdt,t0.bxeamodid,t0.bxeamoddt,t0.bxeacnfid, 
       t0.bxeacnfdt,t1.ooag011 ,t2.ooefl003 ,t3.pmaal004 ,t4.oocql004 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 , 
       t8.ooefl003 ,t9.ooag011 ,t10.ooag011",
               " FROM bxea_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.bxea002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.bxea003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.bxea008 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='1130' AND t4.oocql002=t0.bxea010 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.bxeaownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.bxeaowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.bxeacrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.bxeacrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.bxeamodid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.bxeacnfid  ",
 
               " WHERE t0.bxeaent = " ||g_enterprise|| " AND t0.bxeadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abxt400_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abxt400 WITH FORM cl_ap_formpath("abx",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abxt400_init()   
 
      #進入選單 Menu (="N")
      CALL abxt400_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abxt400
      
   END IF 
   
   CLOSE abxt400_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL abxt400_02_drop_temp_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abxt400.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abxt400_init()
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
      CALL cl_set_combo_scc_part('bxeastus','13','A,D,N,R,W,Y,X,B')
 
      CALL cl_set_combo_scc('bxea005','4081') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_flag = FALSE
   #end add-point
   
   #初始化搜尋條件
   CALL abxt400_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abxt400.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abxt400_ui_dialog()
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
   DEFINE  l_n                   LIKE type_t.num10 
   DEFINE l_success              LIKE type_t.num5   
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
            CALL abxt400_insert()
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
         INITIALIZE g_bxea_m.* TO NULL
         CALL g_bxeb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abxt400_init()
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
               
               CALL abxt400_fetch('') # reload data
               LET l_ac = 1
               CALL abxt400_ui_detailshow() #Setting the current row 
         
               CALL abxt400_idx_chk()
               #NEXT FIELD bxebseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_bxeb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL abxt400_idx_chk()
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
               CALL abxt400_idx_chk()
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
            CALL abxt400_browser_fill("")
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
               CALL abxt400_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abxt400_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL abxt400_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL abxt400_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL abxt400_set_act_visible()   
            CALL abxt400_set_act_no_visible()
            IF NOT (g_bxea_m.bxeadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " bxeaent = " ||g_enterprise|| " AND",
                                  " bxeadocno = '", g_bxea_m.bxeadocno, "' "
 
               #填到對應位置
               CALL abxt400_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "bxea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bxeb_t" 
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
               CALL abxt400_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "bxea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bxeb_t" 
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
                  CALL abxt400_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL abxt400_fetch("F")
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
               CALL abxt400_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abxt400_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abxt400_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abxt400_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abxt400_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abxt400_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abxt400_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abxt400_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abxt400_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abxt400_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abxt400_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_bxeb_d)
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
               NEXT FIELD bxebseq
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
               CALL abxt400_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abxt400_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abxt400_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abxt400_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/abx/abxt400_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/abx/abxt400_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION regen_bxeb
            LET g_action_choice="regen_bxeb"
            IF cl_auth_chk_act("regen_bxeb") THEN
               
               #add-point:ON ACTION regen_bxeb name="menu.regen_bxeb"
               IF NOT cl_null(g_bxea_m.bxea006) AND g_bxea_m.bxea005 MATCHES '[12345]' THEN
                  LET l_n = 0 
                  SELECT COUNT(1) INTO l_n FROM bxeb_t
                    WHERE bxebent = g_enterprise AND bxebdocno = g_bxea_m.bxeadocno
                  IF l_n > 0 THEN
                     IF cl_ask_confirm('aap-00366') THEN   #是否删除单身并重新产生?
                        CALL s_transaction_begin()
                        DELETE FROM bxeb_t WHERE bxebent = g_enterprise AND bxebdocno = g_bxea_m.bxeadocno
                        CALL abxt400_gen_bxeb()  #自動產生單身
                        CALL abxt400_b_fill()
                        LET g_rec_b = g_bxeb_d.getLength()
                        IF g_rec_b > 0 THEN
                           CALL s_transaction_end('Y','0')
                        ELSE
                           CALL s_transaction_end('N','0')
                        END IF
                     END IF
                  ELSE
                     CALL s_transaction_begin()
                     CALL abxt400_gen_bxeb()  #自動產生單身
                     CALL abxt400_b_fill()
                     LET g_rec_b = g_bxeb_d.getLength()
                     IF g_rec_b > 0 THEN
                        CALL s_transaction_end('Y','0')
                     ELSE
                        CALL s_transaction_end('N','0')
                     END IF
                  END IF 
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abxt400_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abxt400_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abxt400_02
            LET g_action_choice="open_abxt400_02"
            IF cl_auth_chk_act("open_abxt400_02") THEN
               
               #add-point:ON ACTION open_abxt400_02 name="menu.open_abxt400_02"
               #1.單頭「資料來源」= 2.出貨單，且「來源單號」= NULL時，才可點選
               IF g_bxea_m.bxea005 = '2' AND cl_null(g_bxea_m.bxea006) THEN
                  LET l_n = 0 
                  SELECT COUNT(1) INTO l_n FROM bxeb_t
                    WHERE bxebent = g_enterprise AND bxebdocno = g_bxea_m.bxeadocno
                  IF l_n > 0 THEN
                     IF cl_ask_confirm('aap-00366') THEN   #是否删除单身并重新产生?
                        CALL s_transaction_begin()
                        DELETE FROM bxeb_t WHERE bxebent = g_enterprise AND bxebdocno = g_bxea_m.bxeadocno
                        CALL abxt400_02(g_bxea_m.bxeadocno) RETURNING l_success  #自動產生單身
                        CALL abxt400_b_fill()
                        LET g_rec_b = g_bxeb_d.getLength()
                        IF g_rec_b > 0 THEN
                           CALL s_transaction_end('Y','0')
                        ELSE
                           CALL s_transaction_end('N','0')
                        END IF
                     END IF
                  ELSE
                     CALL s_transaction_begin()
                     CALL abxt400_02(g_bxea_m.bxeadocno) RETURNING l_success  #自動產生單身
                     CALL abxt400_b_fill()
                     LET g_rec_b = g_bxeb_d.getLength()
                     IF g_rec_b > 0 THEN
                        CALL s_transaction_end('Y','0')
                     ELSE
                        CALL s_transaction_end('N','0')
                     END IF
                  END IF 
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abxt400_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abxt400_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abxt400_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_bxea_m.bxeadocdt)
 
 
 
         
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
 
{<section id="abxt400.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abxt400_browser_fill(ps_page_action)
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
   #170117-00003#1---s
   IF cl_null(g_wc) THEN
      LET g_wc = " bxeasite = '",g_site,"' "
   ELSE
      LET g_wc = g_wc," AND bxeasite = '",g_site,"' "
   END IF
   #170117-00003#1---e
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
      LET l_sub_sql = " SELECT DISTINCT bxeadocno ",
                      " FROM bxea_t ",
                      " ",
                      " LEFT JOIN bxeb_t ON bxebent = bxeaent AND bxeadocno = bxebdocno ", "  ",
                      #add-point:browser_fill段sql(bxeb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE bxeaent = " ||g_enterprise|| " AND bxebent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bxea_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bxeadocno ",
                      " FROM bxea_t ", 
                      "  ",
                      "  ",
                      " WHERE bxeaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bxea_t")
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
      INITIALIZE g_bxea_m.* TO NULL
      CALL g_bxeb_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bxeadocno,t0.bxeadocdt,t0.bxea001,t0.bxea002,t0.bxea003,t0.bxea004,t0.bxea010 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.bxeastus,t0.bxeadocno,t0.bxeadocdt,t0.bxea001,t0.bxea002,t0.bxea003, 
          t0.bxea004,t0.bxea010,t1.ooag011 ,t2.ooefl003 ,t3.oocql004 ",
                  " FROM bxea_t t0",
                  "  ",
                  "  LEFT JOIN bxeb_t ON bxebent = bxeaent AND bxeadocno = bxebdocno ", "  ", 
                  #add-point:browser_fill段sql(bxeb_t1) name="browser_fill.join.bxeb_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.bxea002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.bxea003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='1130' AND t3.oocql002=t0.bxea010 AND t3.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.bxeaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("bxea_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.bxeastus,t0.bxeadocno,t0.bxeadocdt,t0.bxea001,t0.bxea002,t0.bxea003, 
          t0.bxea004,t0.bxea010,t1.ooag011 ,t2.ooefl003 ,t3.oocql004 ",
                  " FROM bxea_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.bxea002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.bxea003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='1130' AND t3.oocql002=t0.bxea010 AND t3.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.bxeaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("bxea_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY bxeadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"bxea_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_bxeadocno,g_browser[g_cnt].b_bxeadocdt, 
          g_browser[g_cnt].b_bxea001,g_browser[g_cnt].b_bxea002,g_browser[g_cnt].b_bxea003,g_browser[g_cnt].b_bxea004, 
          g_browser[g_cnt].b_bxea010,g_browser[g_cnt].b_bxea002_desc,g_browser[g_cnt].b_bxea003_desc, 
          g_browser[g_cnt].b_bxea010_desc
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
         CALL abxt400_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         WHEN "B"
            LET g_browser[g_cnt].b_statepic = "stus/16/close_a_case.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_bxeadocno) THEN
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
 
{<section id="abxt400.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abxt400_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bxea_m.bxeadocno = g_browser[g_current_idx].b_bxeadocno   
 
   EXECUTE abxt400_master_referesh USING g_bxea_m.bxeadocno INTO g_bxea_m.bxeasite,g_bxea_m.bxeadocno, 
       g_bxea_m.bxeadocdt,g_bxea_m.bxea001,g_bxea_m.bxea002,g_bxea_m.bxea003,g_bxea_m.bxeastus,g_bxea_m.bxea004, 
       g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea009,g_bxea_m.bxea010, 
       g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013,g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016, 
       g_bxea_m.bxea017,g_bxea_m.bxea018,g_bxea_m.bxea019,g_bxea_m.bxea020,g_bxea_m.bxeaownid,g_bxea_m.bxeaowndp, 
       g_bxea_m.bxeacrtid,g_bxea_m.bxeacrtdp,g_bxea_m.bxeacrtdt,g_bxea_m.bxeamodid,g_bxea_m.bxeamoddt, 
       g_bxea_m.bxeacnfid,g_bxea_m.bxeacnfdt,g_bxea_m.bxea002_desc,g_bxea_m.bxea003_desc,g_bxea_m.bxea008_desc, 
       g_bxea_m.bxea010_desc,g_bxea_m.bxeaownid_desc,g_bxea_m.bxeaowndp_desc,g_bxea_m.bxeacrtid_desc, 
       g_bxea_m.bxeacrtdp_desc,g_bxea_m.bxeamodid_desc,g_bxea_m.bxeacnfid_desc
   
   CALL abxt400_bxea_t_mask()
   CALL abxt400_show()
      
END FUNCTION
 
{</section>}
 
{<section id="abxt400.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abxt400_ui_detailshow()
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
 
{<section id="abxt400.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abxt400_ui_browser_refresh()
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
      IF g_browser[l_i].b_bxeadocno = g_bxea_m.bxeadocno 
 
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
 
{<section id="abxt400.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abxt400_construct()
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
   INITIALIZE g_bxea_m.* TO NULL
   CALL g_bxeb_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON bxeasite,bxeadocno,bxeadocdt,bxea001,bxea002,bxea003,bxeastus,bxea004, 
          bxea005,bxea006,bxea007,bxea008,bxea009,bxea010,bxea011,bxea012,bxea013,bxea014,bxea015,bxea016, 
          bxea017,bxea018,bxea019,bxea020,bxeaownid,bxeaowndp,bxeacrtid,bxeacrtdp,bxeacrtdt,bxeamodid, 
          bxeamoddt,bxeacnfid,bxeacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bxeacrtdt>>----
         AFTER FIELD bxeacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bxeamoddt>>----
         AFTER FIELD bxeamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bxeacnfdt>>----
         AFTER FIELD bxeacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bxeapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeasite
            #add-point:BEFORE FIELD bxeasite name="construct.b.bxeasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeasite
            
            #add-point:AFTER FIELD bxeasite name="construct.a.bxeasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxeasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeasite
            #add-point:ON ACTION controlp INFIELD bxeasite name="construct.c.bxeasite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bxeadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeadocno
            #add-point:ON ACTION controlp INFIELD bxeadocno name="construct.c.bxeadocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bxeadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxeadocno  #顯示到畫面上
            NEXT FIELD bxeadocno                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeadocno
            #add-point:BEFORE FIELD bxeadocno name="construct.b.bxeadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeadocno
            
            #add-point:AFTER FIELD bxeadocno name="construct.a.bxeadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeadocdt
            #add-point:BEFORE FIELD bxeadocdt name="construct.b.bxeadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeadocdt
            
            #add-point:AFTER FIELD bxeadocdt name="construct.a.bxeadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxeadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeadocdt
            #add-point:ON ACTION controlp INFIELD bxeadocdt name="construct.c.bxeadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea001
            #add-point:BEFORE FIELD bxea001 name="construct.b.bxea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea001
            
            #add-point:AFTER FIELD bxea001 name="construct.a.bxea001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea001
            #add-point:ON ACTION controlp INFIELD bxea001 name="construct.c.bxea001"
 
            #END add-point
 
 
         #Ctrlp:construct.c.bxea002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea002
            #add-point:ON ACTION controlp INFIELD bxea002 name="construct.c.bxea002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxea002  #顯示到畫面上
            NEXT FIELD bxea002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea002
            #add-point:BEFORE FIELD bxea002 name="construct.b.bxea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea002
            
            #add-point:AFTER FIELD bxea002 name="construct.a.bxea002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea003
            #add-point:ON ACTION controlp INFIELD bxea003 name="construct.c.bxea003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxea003  #顯示到畫面上
            NEXT FIELD bxea003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea003
            #add-point:BEFORE FIELD bxea003 name="construct.b.bxea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea003
            
            #add-point:AFTER FIELD bxea003 name="construct.a.bxea003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeastus
            #add-point:BEFORE FIELD bxeastus name="construct.b.bxeastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeastus
            
            #add-point:AFTER FIELD bxeastus name="construct.a.bxeastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxeastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeastus
            #add-point:ON ACTION controlp INFIELD bxeastus name="construct.c.bxeastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea004
            #add-point:BEFORE FIELD bxea004 name="construct.b.bxea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea004
            
            #add-point:AFTER FIELD bxea004 name="construct.a.bxea004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea004
            #add-point:ON ACTION controlp INFIELD bxea004 name="construct.c.bxea004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea005
            #add-point:BEFORE FIELD bxea005 name="construct.b.bxea005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea005
            
            #add-point:AFTER FIELD bxea005 name="construct.a.bxea005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea005
            #add-point:ON ACTION controlp INFIELD bxea005 name="construct.c.bxea005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea006
            #add-point:BEFORE FIELD bxea006 name="construct.b.bxea006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea006
            
            #add-point:AFTER FIELD bxea006 name="construct.a.bxea006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea006
            #add-point:ON ACTION controlp INFIELD bxea006 name="construct.c.bxea006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bxea006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxea006  #顯示到畫面上
            NEXT FIELD bxea006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea007
            #add-point:BEFORE FIELD bxea007 name="construct.b.bxea007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea007
            
            #add-point:AFTER FIELD bxea007 name="construct.a.bxea007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea007
            #add-point:ON ACTION controlp INFIELD bxea007 name="construct.c.bxea007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bxea007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxea007  #顯示到畫面上
            NEXT FIELD bxea007                     #返回原欄位
    

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea008
            #add-point:BEFORE FIELD bxea008 name="construct.b.bxea008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea008
            
            #add-point:AFTER FIELD bxea008 name="construct.a.bxea008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea008
            #add-point:ON ACTION controlp INFIELD bxea008 name="construct.c.bxea008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxea008  #顯示到畫面上
            NEXT FIELD bxea008                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea009
            #add-point:BEFORE FIELD bxea009 name="construct.b.bxea009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea009
            
            #add-point:AFTER FIELD bxea009 name="construct.a.bxea009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea009
            #add-point:ON ACTION controlp INFIELD bxea009 name="construct.c.bxea009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bxda001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxea009  #顯示到畫面上
            NEXT FIELD bxea009                     #返回原欄位
    



            #END add-point
 
 
         #Ctrlp:construct.c.bxea010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea010
            #add-point:ON ACTION controlp INFIELD bxea010 name="construct.c.bxea010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1130'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxea010  #顯示到畫面上
            NEXT FIELD bxea010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea010
            #add-point:BEFORE FIELD bxea010 name="construct.b.bxea010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea010
            
            #add-point:AFTER FIELD bxea010 name="construct.a.bxea010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea011
            #add-point:BEFORE FIELD bxea011 name="construct.b.bxea011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea011
            
            #add-point:AFTER FIELD bxea011 name="construct.a.bxea011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea011
            #add-point:ON ACTION controlp INFIELD bxea011 name="construct.c.bxea011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea012
            #add-point:BEFORE FIELD bxea012 name="construct.b.bxea012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea012
            
            #add-point:AFTER FIELD bxea012 name="construct.a.bxea012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea012
            #add-point:ON ACTION controlp INFIELD bxea012 name="construct.c.bxea012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea013
            #add-point:BEFORE FIELD bxea013 name="construct.b.bxea013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea013
            
            #add-point:AFTER FIELD bxea013 name="construct.a.bxea013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea013
            #add-point:ON ACTION controlp INFIELD bxea013 name="construct.c.bxea013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea014
            #add-point:BEFORE FIELD bxea014 name="construct.b.bxea014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea014
            
            #add-point:AFTER FIELD bxea014 name="construct.a.bxea014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea014
            #add-point:ON ACTION controlp INFIELD bxea014 name="construct.c.bxea014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea015
            #add-point:BEFORE FIELD bxea015 name="construct.b.bxea015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea015
            
            #add-point:AFTER FIELD bxea015 name="construct.a.bxea015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea015
            #add-point:ON ACTION controlp INFIELD bxea015 name="construct.c.bxea015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bxea016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea016
            #add-point:ON ACTION controlp INFIELD bxea016 name="construct.c.bxea016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oofb019_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxea016  #顯示到畫面上
            NEXT FIELD bxea016                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea016
            #add-point:BEFORE FIELD bxea016 name="construct.b.bxea016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea016
            
            #add-point:AFTER FIELD bxea016 name="construct.a.bxea016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea017
            #add-point:BEFORE FIELD bxea017 name="construct.b.bxea017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea017
            
            #add-point:AFTER FIELD bxea017 name="construct.a.bxea017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea017
            #add-point:ON ACTION controlp INFIELD bxea017 name="construct.c.bxea017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea018
            #add-point:BEFORE FIELD bxea018 name="construct.b.bxea018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea018
            
            #add-point:AFTER FIELD bxea018 name="construct.a.bxea018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea018
            #add-point:ON ACTION controlp INFIELD bxea018 name="construct.c.bxea018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea019
            #add-point:BEFORE FIELD bxea019 name="construct.b.bxea019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea019
            
            #add-point:AFTER FIELD bxea019 name="construct.a.bxea019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea019
            #add-point:ON ACTION controlp INFIELD bxea019 name="construct.c.bxea019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea020
            #add-point:BEFORE FIELD bxea020 name="construct.b.bxea020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea020
            
            #add-point:AFTER FIELD bxea020 name="construct.a.bxea020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxea020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea020
            #add-point:ON ACTION controlp INFIELD bxea020 name="construct.c.bxea020"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bxeaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeaownid
            #add-point:ON ACTION controlp INFIELD bxeaownid name="construct.c.bxeaownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxeaownid  #顯示到畫面上
            NEXT FIELD bxeaownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeaownid
            #add-point:BEFORE FIELD bxeaownid name="construct.b.bxeaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeaownid
            
            #add-point:AFTER FIELD bxeaownid name="construct.a.bxeaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxeaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeaowndp
            #add-point:ON ACTION controlp INFIELD bxeaowndp name="construct.c.bxeaowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxeaowndp  #顯示到畫面上
            NEXT FIELD bxeaowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeaowndp
            #add-point:BEFORE FIELD bxeaowndp name="construct.b.bxeaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeaowndp
            
            #add-point:AFTER FIELD bxeaowndp name="construct.a.bxeaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxeacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeacrtid
            #add-point:ON ACTION controlp INFIELD bxeacrtid name="construct.c.bxeacrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxeacrtid  #顯示到畫面上
            NEXT FIELD bxeacrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeacrtid
            #add-point:BEFORE FIELD bxeacrtid name="construct.b.bxeacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeacrtid
            
            #add-point:AFTER FIELD bxeacrtid name="construct.a.bxeacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxeacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeacrtdp
            #add-point:ON ACTION controlp INFIELD bxeacrtdp name="construct.c.bxeacrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxeacrtdp  #顯示到畫面上
            NEXT FIELD bxeacrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeacrtdp
            #add-point:BEFORE FIELD bxeacrtdp name="construct.b.bxeacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeacrtdp
            
            #add-point:AFTER FIELD bxeacrtdp name="construct.a.bxeacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeacrtdt
            #add-point:BEFORE FIELD bxeacrtdt name="construct.b.bxeacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bxeamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeamodid
            #add-point:ON ACTION controlp INFIELD bxeamodid name="construct.c.bxeamodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxeamodid  #顯示到畫面上
            NEXT FIELD bxeamodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeamodid
            #add-point:BEFORE FIELD bxeamodid name="construct.b.bxeamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeamodid
            
            #add-point:AFTER FIELD bxeamodid name="construct.a.bxeamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeamoddt
            #add-point:BEFORE FIELD bxeamoddt name="construct.b.bxeamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bxeacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeacnfid
            #add-point:ON ACTION controlp INFIELD bxeacnfid name="construct.c.bxeacnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxeacnfid  #顯示到畫面上
            NEXT FIELD bxeacnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeacnfid
            #add-point:BEFORE FIELD bxeacnfid name="construct.b.bxeacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeacnfid
            
            #add-point:AFTER FIELD bxeacnfid name="construct.a.bxeacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeacnfdt
            #add-point:BEFORE FIELD bxeacnfdt name="construct.b.bxeacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON bxebsite,bxebseq,bxeb001,bxeb002,bxeb003,bxeb004,bxeb005,bxeb006,bxeb007, 
          bxeb008,bxeb009
           FROM s_detail1[1].bxebsite,s_detail1[1].bxebseq,s_detail1[1].bxeb001,s_detail1[1].bxeb002, 
               s_detail1[1].bxeb003,s_detail1[1].bxeb004,s_detail1[1].bxeb005,s_detail1[1].bxeb006,s_detail1[1].bxeb007, 
               s_detail1[1].bxeb008,s_detail1[1].bxeb009
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxebsite
            #add-point:BEFORE FIELD bxebsite name="construct.b.page1.bxebsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxebsite
            
            #add-point:AFTER FIELD bxebsite name="construct.a.page1.bxebsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bxebsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxebsite
            #add-point:ON ACTION controlp INFIELD bxebsite name="construct.c.page1.bxebsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxebseq
            #add-point:BEFORE FIELD bxebseq name="construct.b.page1.bxebseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxebseq
            
            #add-point:AFTER FIELD bxebseq name="construct.a.page1.bxebseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bxebseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxebseq
            #add-point:ON ACTION controlp INFIELD bxebseq name="construct.c.page1.bxebseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb001
            #add-point:BEFORE FIELD bxeb001 name="construct.b.page1.bxeb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb001
            
            #add-point:AFTER FIELD bxeb001 name="construct.a.page1.bxeb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bxeb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb001
            #add-point:ON ACTION controlp INFIELD bxeb001 name="construct.c.page1.bxeb001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bxeb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxeb001  #顯示到畫面上
            NEXT FIELD bxeb001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb002
            #add-point:BEFORE FIELD bxeb002 name="construct.b.page1.bxeb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb002
            
            #add-point:AFTER FIELD bxeb002 name="construct.a.page1.bxeb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bxeb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb002
            #add-point:ON ACTION controlp INFIELD bxeb002 name="construct.c.page1.bxeb002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bxeb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb003
            #add-point:ON ACTION controlp INFIELD bxeb003 name="construct.c.page1.bxeb003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxeb003  #顯示到畫面上
            NEXT FIELD bxeb003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb003
            #add-point:BEFORE FIELD bxeb003 name="construct.b.page1.bxeb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb003
            
            #add-point:AFTER FIELD bxeb003 name="construct.a.page1.bxeb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bxeb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb004
            #add-point:ON ACTION controlp INFIELD bxeb004 name="construct.c.page1.bxeb004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxeb004  #顯示到畫面上
            NEXT FIELD bxeb004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb004
            #add-point:BEFORE FIELD bxeb004 name="construct.b.page1.bxeb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb004
            
            #add-point:AFTER FIELD bxeb004 name="construct.a.page1.bxeb004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb005
            #add-point:BEFORE FIELD bxeb005 name="construct.b.page1.bxeb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb005
            
            #add-point:AFTER FIELD bxeb005 name="construct.a.page1.bxeb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bxeb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb005
            #add-point:ON ACTION controlp INFIELD bxeb005 name="construct.c.page1.bxeb005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bxeb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb006
            #add-point:ON ACTION controlp INFIELD bxeb006 name="construct.c.page1.bxeb006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxeb006  #顯示到畫面上
            NEXT FIELD bxeb006                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb006
            #add-point:BEFORE FIELD bxeb006 name="construct.b.page1.bxeb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb006
            
            #add-point:AFTER FIELD bxeb006 name="construct.a.page1.bxeb006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb007
            #add-point:BEFORE FIELD bxeb007 name="construct.b.page1.bxeb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb007
            
            #add-point:AFTER FIELD bxeb007 name="construct.a.page1.bxeb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bxeb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb007
            #add-point:ON ACTION controlp INFIELD bxeb007 name="construct.c.page1.bxeb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb008
            #add-point:BEFORE FIELD bxeb008 name="construct.b.page1.bxeb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb008
            
            #add-point:AFTER FIELD bxeb008 name="construct.a.page1.bxeb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bxeb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb008
            #add-point:ON ACTION controlp INFIELD bxeb008 name="construct.c.page1.bxeb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb009
            #add-point:BEFORE FIELD bxeb009 name="construct.b.page1.bxeb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb009
            
            #add-point:AFTER FIELD bxeb009 name="construct.a.page1.bxeb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bxeb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb009
            #add-point:ON ACTION controlp INFIELD bxeb009 name="construct.c.page1.bxeb009"
            
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
                  WHEN la_wc[li_idx].tableid = "bxea_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "bxeb_t" 
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
 
{<section id="abxt400.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abxt400_filter()
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
      CONSTRUCT g_wc_filter ON bxeadocno,bxeadocdt,bxea001,bxea002,bxea003,bxea004,bxea010
                          FROM s_browse[1].b_bxeadocno,s_browse[1].b_bxeadocdt,s_browse[1].b_bxea001, 
                              s_browse[1].b_bxea002,s_browse[1].b_bxea003,s_browse[1].b_bxea004,s_browse[1].b_bxea010 
 
 
         BEFORE CONSTRUCT
               DISPLAY abxt400_filter_parser('bxeadocno') TO s_browse[1].b_bxeadocno
            DISPLAY abxt400_filter_parser('bxeadocdt') TO s_browse[1].b_bxeadocdt
            DISPLAY abxt400_filter_parser('bxea001') TO s_browse[1].b_bxea001
            DISPLAY abxt400_filter_parser('bxea002') TO s_browse[1].b_bxea002
            DISPLAY abxt400_filter_parser('bxea003') TO s_browse[1].b_bxea003
            DISPLAY abxt400_filter_parser('bxea004') TO s_browse[1].b_bxea004
            DISPLAY abxt400_filter_parser('bxea010') TO s_browse[1].b_bxea010
      
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
 
      CALL abxt400_filter_show('bxeadocno')
   CALL abxt400_filter_show('bxeadocdt')
   CALL abxt400_filter_show('bxea001')
   CALL abxt400_filter_show('bxea002')
   CALL abxt400_filter_show('bxea003')
   CALL abxt400_filter_show('bxea004')
   CALL abxt400_filter_show('bxea010')
 
END FUNCTION
 
{</section>}
 
{<section id="abxt400.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abxt400_filter_parser(ps_field)
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
 
{<section id="abxt400.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abxt400_filter_show(ps_field)
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
   LET ls_condition = abxt400_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abxt400.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abxt400_query()
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
   CALL g_bxeb_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL abxt400_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abxt400_browser_fill("")
      CALL abxt400_fetch("")
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
      CALL abxt400_filter_show('bxeadocno')
   CALL abxt400_filter_show('bxeadocdt')
   CALL abxt400_filter_show('bxea001')
   CALL abxt400_filter_show('bxea002')
   CALL abxt400_filter_show('bxea003')
   CALL abxt400_filter_show('bxea004')
   CALL abxt400_filter_show('bxea010')
   CALL abxt400_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL abxt400_fetch("F") 
      #顯示單身筆數
      CALL abxt400_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abxt400.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abxt400_fetch(p_flag)
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
   
   LET g_bxea_m.bxeadocno = g_browser[g_current_idx].b_bxeadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abxt400_master_referesh USING g_bxea_m.bxeadocno INTO g_bxea_m.bxeasite,g_bxea_m.bxeadocno, 
       g_bxea_m.bxeadocdt,g_bxea_m.bxea001,g_bxea_m.bxea002,g_bxea_m.bxea003,g_bxea_m.bxeastus,g_bxea_m.bxea004, 
       g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea009,g_bxea_m.bxea010, 
       g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013,g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016, 
       g_bxea_m.bxea017,g_bxea_m.bxea018,g_bxea_m.bxea019,g_bxea_m.bxea020,g_bxea_m.bxeaownid,g_bxea_m.bxeaowndp, 
       g_bxea_m.bxeacrtid,g_bxea_m.bxeacrtdp,g_bxea_m.bxeacrtdt,g_bxea_m.bxeamodid,g_bxea_m.bxeamoddt, 
       g_bxea_m.bxeacnfid,g_bxea_m.bxeacnfdt,g_bxea_m.bxea002_desc,g_bxea_m.bxea003_desc,g_bxea_m.bxea008_desc, 
       g_bxea_m.bxea010_desc,g_bxea_m.bxeaownid_desc,g_bxea_m.bxeaowndp_desc,g_bxea_m.bxeacrtid_desc, 
       g_bxea_m.bxeacrtdp_desc,g_bxea_m.bxeamodid_desc,g_bxea_m.bxeacnfid_desc
   
   #遮罩相關處理
   LET g_bxea_m_mask_o.* =  g_bxea_m.*
   CALL abxt400_bxea_t_mask()
   LET g_bxea_m_mask_n.* =  g_bxea_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abxt400_set_act_visible()   
   CALL abxt400_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_bxea_m_t.* = g_bxea_m.*
   LET g_bxea_m_o.* = g_bxea_m.*
   
   LET g_data_owner = g_bxea_m.bxeaownid      
   LET g_data_dept  = g_bxea_m.bxeaowndp
   
   #重新顯示   
   CALL abxt400_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="abxt400.insert" >}
#+ 資料新增
PRIVATE FUNCTION abxt400_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
 
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_bxeb_d.clear()   
 
 
   INITIALIZE g_bxea_m.* TO NULL             #DEFAULT 設定
   
   LET g_bxeadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bxea_m.bxeaownid = g_user
      LET g_bxea_m.bxeaowndp = g_dept
      LET g_bxea_m.bxeacrtid = g_user
      LET g_bxea_m.bxeacrtdp = g_dept 
      LET g_bxea_m.bxeacrtdt = cl_get_current()
      LET g_bxea_m.bxeamodid = g_user
      LET g_bxea_m.bxeamoddt = cl_get_current()
      LET g_bxea_m.bxeastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_bxea_m.bxeastus = "N"
      LET g_bxea_m.bxea005 = "1"
      LET g_bxea_m.bxea015 = "0"
      LET g_bxea_m.bxea019 = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_bxea_m.bxeasite = g_site
      LET g_bxea_m.bxeadocdt = g_today
      LET g_bxea_m.bxea002 = g_user
      CALL s_desc_get_person_desc(g_bxea_m.bxea002) RETURNING g_bxea_m.bxea002_desc
      DISPLAY BY NAME g_bxea_m.bxea002_desc
      
      LET g_bxea_m.bxea003 = g_dept
      CALL s_desc_get_department_desc(g_bxea_m.bxea003) RETURNING g_bxea_m.bxea003_desc
      DISPLAY BY NAME g_bxea_m.bxea003_desc
      
      LET g_bxea_m.bxea004 = g_today

      DISPLAY BY NAME g_bxea_m.bxeasite,g_bxea_m.bxeadocdt,g_bxea_m.bxea002,g_bxea_m.bxea003,g_bxea_m.bxea004
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_bxea_m_t.* = g_bxea_m.*
      LET g_bxea_m_o.* = g_bxea_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bxea_m.bxeastus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "B"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/close_a_case.png")
         
      END CASE
 
 
 
    
      CALL abxt400_input("a")
      
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
         INITIALIZE g_bxea_m.* TO NULL
         INITIALIZE g_bxeb_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL abxt400_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_bxeb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abxt400_set_act_visible()   
   CALL abxt400_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bxeadocno_t = g_bxea_m.bxeadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " bxeaent = " ||g_enterprise|| " AND",
                      " bxeadocno = '", g_bxea_m.bxeadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abxt400_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE abxt400_cl
   
   CALL abxt400_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abxt400_master_referesh USING g_bxea_m.bxeadocno INTO g_bxea_m.bxeasite,g_bxea_m.bxeadocno, 
       g_bxea_m.bxeadocdt,g_bxea_m.bxea001,g_bxea_m.bxea002,g_bxea_m.bxea003,g_bxea_m.bxeastus,g_bxea_m.bxea004, 
       g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea009,g_bxea_m.bxea010, 
       g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013,g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016, 
       g_bxea_m.bxea017,g_bxea_m.bxea018,g_bxea_m.bxea019,g_bxea_m.bxea020,g_bxea_m.bxeaownid,g_bxea_m.bxeaowndp, 
       g_bxea_m.bxeacrtid,g_bxea_m.bxeacrtdp,g_bxea_m.bxeacrtdt,g_bxea_m.bxeamodid,g_bxea_m.bxeamoddt, 
       g_bxea_m.bxeacnfid,g_bxea_m.bxeacnfdt,g_bxea_m.bxea002_desc,g_bxea_m.bxea003_desc,g_bxea_m.bxea008_desc, 
       g_bxea_m.bxea010_desc,g_bxea_m.bxeaownid_desc,g_bxea_m.bxeaowndp_desc,g_bxea_m.bxeacrtid_desc, 
       g_bxea_m.bxeacrtdp_desc,g_bxea_m.bxeamodid_desc,g_bxea_m.bxeacnfid_desc
   
   
   #遮罩相關處理
   LET g_bxea_m_mask_o.* =  g_bxea_m.*
   CALL abxt400_bxea_t_mask()
   LET g_bxea_m_mask_n.* =  g_bxea_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bxea_m.bxeasite,g_bxea_m.bxeadocno,g_bxea_m.bxeadocno_desc,g_bxea_m.bxeadocdt,g_bxea_m.bxea001, 
       g_bxea_m.bxea002,g_bxea_m.bxea002_desc,g_bxea_m.bxea003,g_bxea_m.bxea003_desc,g_bxea_m.bxeastus, 
       g_bxea_m.bxea004,g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea008_desc, 
       g_bxea_m.bxea009,g_bxea_m.bxea010,g_bxea_m.bxea010_desc,g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013, 
       g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016,g_bxea_m.oofb017,g_bxea_m.bxea017,g_bxea_m.bxea018, 
       g_bxea_m.bxea019,g_bxea_m.bxea020,g_bxea_m.bxeaownid,g_bxea_m.bxeaownid_desc,g_bxea_m.bxeaowndp, 
       g_bxea_m.bxeaowndp_desc,g_bxea_m.bxeacrtid,g_bxea_m.bxeacrtid_desc,g_bxea_m.bxeacrtdp,g_bxea_m.bxeacrtdp_desc, 
       g_bxea_m.bxeacrtdt,g_bxea_m.bxeamodid,g_bxea_m.bxeamodid_desc,g_bxea_m.bxeamoddt,g_bxea_m.bxeacnfid, 
       g_bxea_m.bxeacnfid_desc,g_bxea_m.bxeacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_bxea_m.bxeaownid      
   LET g_data_dept  = g_bxea_m.bxeaowndp
   
   #功能已完成,通報訊息中心
   CALL abxt400_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abxt400.modify" >}
#+ 資料修改
PRIVATE FUNCTION abxt400_modify()
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
   LET g_bxea_m_t.* = g_bxea_m.*
   LET g_bxea_m_o.* = g_bxea_m.*
   
   IF g_bxea_m.bxeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_bxeadocno_t = g_bxea_m.bxeadocno
 
   CALL s_transaction_begin()
   
   OPEN abxt400_cl USING g_enterprise,g_bxea_m.bxeadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abxt400_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abxt400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abxt400_master_referesh USING g_bxea_m.bxeadocno INTO g_bxea_m.bxeasite,g_bxea_m.bxeadocno, 
       g_bxea_m.bxeadocdt,g_bxea_m.bxea001,g_bxea_m.bxea002,g_bxea_m.bxea003,g_bxea_m.bxeastus,g_bxea_m.bxea004, 
       g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea009,g_bxea_m.bxea010, 
       g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013,g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016, 
       g_bxea_m.bxea017,g_bxea_m.bxea018,g_bxea_m.bxea019,g_bxea_m.bxea020,g_bxea_m.bxeaownid,g_bxea_m.bxeaowndp, 
       g_bxea_m.bxeacrtid,g_bxea_m.bxeacrtdp,g_bxea_m.bxeacrtdt,g_bxea_m.bxeamodid,g_bxea_m.bxeamoddt, 
       g_bxea_m.bxeacnfid,g_bxea_m.bxeacnfdt,g_bxea_m.bxea002_desc,g_bxea_m.bxea003_desc,g_bxea_m.bxea008_desc, 
       g_bxea_m.bxea010_desc,g_bxea_m.bxeaownid_desc,g_bxea_m.bxeaowndp_desc,g_bxea_m.bxeacrtid_desc, 
       g_bxea_m.bxeacrtdp_desc,g_bxea_m.bxeamodid_desc,g_bxea_m.bxeacnfid_desc
   
   #檢查是否允許此動作
   IF NOT abxt400_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bxea_m_mask_o.* =  g_bxea_m.*
   CALL abxt400_bxea_t_mask()
   LET g_bxea_m_mask_n.* =  g_bxea_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL abxt400_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_bxeadocno_t = g_bxea_m.bxeadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_bxea_m.bxeamodid = g_user 
LET g_bxea_m.bxeamoddt = cl_get_current()
LET g_bxea_m.bxeamodid_desc = cl_get_username(g_bxea_m.bxeamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL abxt400_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE bxea_t SET (bxeamodid,bxeamoddt) = (g_bxea_m.bxeamodid,g_bxea_m.bxeamoddt)
          WHERE bxeaent = g_enterprise AND bxeadocno = g_bxeadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_bxea_m.* = g_bxea_m_t.*
            CALL abxt400_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_bxea_m.bxeadocno != g_bxea_m_t.bxeadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE bxeb_t SET bxebdocno = g_bxea_m.bxeadocno
 
          WHERE bxebent = g_enterprise AND bxebdocno = g_bxea_m_t.bxeadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "bxeb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bxeb_t:",SQLERRMESSAGE 
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
   CALL abxt400_set_act_visible()   
   CALL abxt400_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bxeaent = " ||g_enterprise|| " AND",
                      " bxeadocno = '", g_bxea_m.bxeadocno, "' "
 
   #填到對應位置
   CALL abxt400_browser_fill("")
 
   CLOSE abxt400_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abxt400_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="abxt400.input" >}
#+ 資料輸入
PRIVATE FUNCTION abxt400_input(p_cmd)
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
   DEFINE l_slip                 LIKE oobx_t.oobx001
   DEFINE l_sfaa010              LIKE sfaa_t.sfaa010
   DEFINE l_sfaadocdt            LIKE sfaa_t.sfaadocdt
   DEFINE l_sfaa012              LIKE sfaa_t.sfaa012
   DEFINE l_sfaa013              LIKE sfaa_t.sfaa013
   DEFINE l_bxda006              LIKE bxda_t.bxda006
   DEFINE l_imaa006              LIKE imaa_t.imaa006
   DEFINE l_oofa001              LIKE oofa_t.oofa001
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE l_bxeb003              LIKE bxeb_t.bxeb003
   DEFINE l_bxeb004              LIKE bxeb_t.bxeb004
   DEFINE l_bxeb005              LIKE bxeb_t.bxeb005
   DEFINE l_bxeb006              LIKE bxeb_t.bxeb006
   DEFINE l_bxeb007              LIKE bxeb_t.bxeb007
   DEFINE l_bxeb008              LIKE bxeb_t.bxeb008
   DEFINE l_bxeb009              LIKE bxeb_t.bxeb009
   DEFINE l_iman012              LIKE iman_t.iman012
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
   DISPLAY BY NAME g_bxea_m.bxeasite,g_bxea_m.bxeadocno,g_bxea_m.bxeadocno_desc,g_bxea_m.bxeadocdt,g_bxea_m.bxea001, 
       g_bxea_m.bxea002,g_bxea_m.bxea002_desc,g_bxea_m.bxea003,g_bxea_m.bxea003_desc,g_bxea_m.bxeastus, 
       g_bxea_m.bxea004,g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea008_desc, 
       g_bxea_m.bxea009,g_bxea_m.bxea010,g_bxea_m.bxea010_desc,g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013, 
       g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016,g_bxea_m.oofb017,g_bxea_m.bxea017,g_bxea_m.bxea018, 
       g_bxea_m.bxea019,g_bxea_m.bxea020,g_bxea_m.bxeaownid,g_bxea_m.bxeaownid_desc,g_bxea_m.bxeaowndp, 
       g_bxea_m.bxeaowndp_desc,g_bxea_m.bxeacrtid,g_bxea_m.bxeacrtid_desc,g_bxea_m.bxeacrtdp,g_bxea_m.bxeacrtdp_desc, 
       g_bxea_m.bxeacrtdt,g_bxea_m.bxeamodid,g_bxea_m.bxeamodid_desc,g_bxea_m.bxeamoddt,g_bxea_m.bxeacnfid, 
       g_bxea_m.bxeacnfid_desc,g_bxea_m.bxeacnfdt
   
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
   LET g_forupd_sql = "SELECT bxebsite,bxebseq,bxeb001,bxeb002,bxeb003,bxeb004,bxeb005,bxeb006,bxeb007, 
       bxeb008,bxeb009 FROM bxeb_t WHERE bxebent=? AND bxebdocno=? AND bxebseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abxt400_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abxt400_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abxt400_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_bxea_m.bxeasite,g_bxea_m.bxeadocno,g_bxea_m.bxeadocdt,g_bxea_m.bxea001,g_bxea_m.bxea002, 
       g_bxea_m.bxea003,g_bxea_m.bxeastus,g_bxea_m.bxea004,g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007, 
       g_bxea_m.bxea008,g_bxea_m.bxea009,g_bxea_m.bxea010,g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013, 
       g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016,g_bxea_m.bxea017,g_bxea_m.bxea018,g_bxea_m.bxea019, 
       g_bxea_m.bxea020
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   
   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abxt400.input.head" >}
      #單頭段
      INPUT BY NAME g_bxea_m.bxeasite,g_bxea_m.bxeadocno,g_bxea_m.bxeadocdt,g_bxea_m.bxea001,g_bxea_m.bxea002, 
          g_bxea_m.bxea003,g_bxea_m.bxeastus,g_bxea_m.bxea004,g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007, 
          g_bxea_m.bxea008,g_bxea_m.bxea009,g_bxea_m.bxea010,g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013, 
          g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016,g_bxea_m.bxea017,g_bxea_m.bxea018,g_bxea_m.bxea019, 
          g_bxea_m.bxea020 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN abxt400_cl USING g_enterprise,g_bxea_m.bxeadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abxt400_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abxt400_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL abxt400_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL abxt400_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeasite
            #add-point:BEFORE FIELD bxeasite name="input.b.bxeasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeasite
            
            #add-point:AFTER FIELD bxeasite name="input.a.bxeasite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxeasite
            #add-point:ON CHANGE bxeasite name="input.g.bxeasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeadocno
            
            #add-point:AFTER FIELD bxeadocno name="input.a.bxeadocno"

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            CALL s_aooi200_get_slip_desc(g_bxea_m.bxeadocno) RETURNING g_bxea_m.bxeadocno_desc
            DISPLAY BY NAME g_bxea_m.bxeadocno_desc
            IF NOT cl_null(g_bxea_m.bxeadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bxea_m.bxeadocno != g_bxeadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bxea_t WHERE "||"bxeaent = " ||g_enterprise|| " AND "||"bxeadocno = '"||g_bxea_m.bxeadocno ||"'",'std-00004',0) THEN 
                     LET g_bxea_m.bxeadocno = g_bxeadocno_t
                     CALL s_aooi200_get_slip_desc(g_bxea_m.bxeadocno) RETURNING g_bxea_m.bxeadocno_desc
                     DISPLAY BY NAME g_bxea_m.bxeadocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT s_aooi200_chk_docno(g_site,g_bxea_m.bxeadocno,g_bxea_m.bxeadocdt,g_prog) THEN
                     LET g_bxea_m.bxeadocno = g_bxeadocno_t
                     CALL s_aooi200_get_slip_desc(g_bxea_m.bxeadocno) RETURNING g_bxea_m.bxeadocno_desc
                     DISPLAY BY NAME g_bxea_m.bxeadocno_desc
                     NEXT FIELD CURRENT   
                  END IF
                  
                  CALL abxt400_get_col_default()   #取得欄位預設值

               END IF
               
               #若放行申請單號的單據別參數為保稅，則自動預設應返日期=出區日期+半年
               IF cl_get_doc_para(g_enterprise,g_site,g_bxea_m.bxeadocno,'D-MFG-0083') = '1' THEN
                  LET g_bxea_m.bxea013 = s_date_get_date(g_bxea_m.bxea004,6,0)
                  DISPLAY BY NAME g_bxea_m.bxea013
               END IF
            END IF
            
            CALL abxt400_set_entry(p_cmd)
            CALL abxt400_set_no_entry(p_cmd)


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeadocno
            #add-point:BEFORE FIELD bxeadocno name="input.b.bxeadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxeadocno
            #add-point:ON CHANGE bxeadocno name="input.g.bxeadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeadocdt
            #add-point:BEFORE FIELD bxeadocdt name="input.b.bxeadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeadocdt
            
            #add-point:AFTER FIELD bxeadocdt name="input.a.bxeadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxeadocdt
            #add-point:ON CHANGE bxeadocdt name="input.g.bxeadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea001
            #add-point:BEFORE FIELD bxea001 name="input.b.bxea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea001
            
            #add-point:AFTER FIELD bxea001 name="input.a.bxea001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea001
            #add-point:ON CHANGE bxea001 name="input.g.bxea001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea002
            
            #add-point:AFTER FIELD bxea002 name="input.a.bxea002"
            CALL s_desc_get_person_desc(g_bxea_m.bxea002) RETURNING g_bxea_m.bxea002_desc
            DISPLAY BY NAME g_bxea_m.bxea002_desc
            
            IF NOT cl_null(g_bxea_m.bxea002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bxea_m.bxea002 != g_bxea_m.bxea002 OR cl_null(g_bxea_m.bxea002))) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bxea_m.bxea002

                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                     #檢查成功時後續處理
                     SELECT ooag003 INTO g_bxea_m.bxea003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_bxea_m.bxea002
                     CALL s_desc_get_person_desc(g_bxea_m.bxea003) RETURNING g_bxea_m.bxea003_desc
                     DISPLAY BY NAME g_bxea_m.bxea003_desc   
                  ELSE
                     #檢查失敗時後續處理
                     LET g_bxea_m.bxea002 = g_bxea_m_t.bxea002
                     CALL s_desc_get_person_desc(g_bxea_m.bxea002) RETURNING g_bxea_m.bxea002_desc
                     DISPLAY BY NAME g_bxea_m.bxea002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea002
            #add-point:BEFORE FIELD bxea002 name="input.b.bxea002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea002
            #add-point:ON CHANGE bxea002 name="input.g.bxea002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea003
            
            #add-point:AFTER FIELD bxea003 name="input.a.bxea003"
            CALL s_desc_get_department_desc(g_bxea_m.bxea003) RETURNING g_bxea_m.bxea003_desc
            DISPLAY BY NAME g_bxea_m.bxea003_desc 
            
            IF NOT cl_null(g_bxea_m.bxea003) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bxea_m.bxea003
               LET g_chkparam.arg2 = g_bxea_m.bxeadocdt
               LET g_chkparam.arg3 = g_site
               LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooeg001_9") THEN
                  LET g_bxea_m.bxea003 = g_bxea_m_t.bxea003
                  CALL s_desc_get_department_desc(g_bxea_m.bxea003) RETURNING g_bxea_m.bxea003_desc
                  DISPLAY BY NAME g_bxea_m.bxea003_desc 
                  NEXT FIELD CURRENT
               END IF    
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea003
            #add-point:BEFORE FIELD bxea003 name="input.b.bxea003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea003
            #add-point:ON CHANGE bxea003 name="input.g.bxea003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeastus
            #add-point:BEFORE FIELD bxeastus name="input.b.bxeastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeastus
            
            #add-point:AFTER FIELD bxeastus name="input.a.bxeastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxeastus
            #add-point:ON CHANGE bxeastus name="input.g.bxeastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea004
            #add-point:BEFORE FIELD bxea004 name="input.b.bxea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea004
            
            #add-point:AFTER FIELD bxea004 name="input.a.bxea004"
            IF NOT cl_null(g_bxea_m.bxea004) THEN
               #若放行申請單號的單據別參數為保稅，則自動預設應返日期=出區日期+半年 
               CALL s_aooi200_get_slip(g_bxea_m.bxeadocno) RETURNING l_success,l_slip
               IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-MFG-0083') = '1' AND g_bxea_m.bxea005 <> '2' THEN
                  LET g_bxea_m.bxea013 = s_date_get_date(g_bxea_m.bxea004,6,0)
                  DISPLAY BY NAME g_bxea_m.bxea013
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea004
            #add-point:ON CHANGE bxea004 name="input.g.bxea004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea005
            #add-point:BEFORE FIELD bxea005 name="input.b.bxea005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea005
            
            #add-point:AFTER FIELD bxea005 name="input.a.bxea005"
            IF g_bxea_m.bxea005 <> g_bxea_m_o.bxea005 OR cl_null(g_bxea_m_o.bxea005) THEN
               LET g_bxea_m.bxea006 = ''
               LET g_bxea_m.bxea007 = ''
               LET g_bxea_m.bxea008 = ''
               LET g_bxea_m.bxea008_desc = ''
               LET g_bxea_m.bxea009 = ''
               LET g_bxea_m.bxea016 = ''
               LET g_bxea_m.oofb017 = ''
               DISPLAY BY NAME g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea008_desc,g_bxea_m.bxea009,g_bxea_m.bxea016,g_bxea_m.oofb017
            END IF
            IF g_bxea_m.bxea005 = '2' THEN
               LET g_bxea_m.bxea013 = ''
               DISPLAY BY NAME g_bxea_m.bxea013
            ELSE
               #若放行申請單號的單據別參數為保稅，則自動預設應返日期=出區日期+半年
               IF cl_get_doc_para(g_enterprise,g_site,g_bxea_m.bxeadocno,'D-MFG-0083') = '1' AND cl_null(g_bxea_m.bxea013) THEN
                  LET g_bxea_m.bxea013 = s_date_get_date(g_bxea_m.bxea004,6,0)
                  DISPLAY BY NAME g_bxea_m.bxea013
               END IF
            END IF
            LET g_bxea_m_o.bxea005 = g_bxea_m.bxea005
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea005
            #add-point:ON CHANGE bxea005 name="input.g.bxea005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea006
            #add-point:BEFORE FIELD bxea006 name="input.b.bxea006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea006
            
            #add-point:AFTER FIELD bxea006 name="input.a.bxea006"
            IF NOT cl_null(g_bxea_m.bxea006) THEN
               IF NOT abxt400_bxea006_chk(g_bxea_m.bxea006) THEN
                  LET g_bxea_m.bxea006 = g_bxea_m_t.bxea006
                  NEXT FIELD bxea006
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea006
            #add-point:ON CHANGE bxea006 name="input.g.bxea006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea007
            #add-point:BEFORE FIELD bxea007 name="input.b.bxea007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea007
            
            #add-point:AFTER FIELD bxea007 name="input.a.bxea007"
            IF NOT cl_null(g_bxea_m.bxea007) THEN
               IF g_bxea_m.bxea005 MATCHES '[135]' THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bxea_m.bxea007
                   
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_sfaadocno_8") THEN
                     LET g_bxea_m.bxea007 = g_bxea_m_t.bxea007
                     NEXT FIELD bxea007
                  END IF
                  SELECT sfaa037 INTO g_bxea_m.bxea009 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = g_bxea_m.bxea007
                  DISPLAY BY NAME g_bxea_m.bxea009
               END IF
               
               IF g_bxea_m.bxea005 MATCHES '[2]' THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bxea_m.bxea007
                  LET g_chkparam.where = " xmdasite = '",g_site,"' "
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_xmdadocno_1") THEN
                     LET g_bxea_m.bxea007 = g_bxea_m_t.bxea007
                     NEXT FIELD bxea007
                  END IF
               END IF
               IF NOT cl_null(g_bxea_m.bxea009) THEN
                  IF NOT abxt400_bxea009_chk() THEN
                     LET g_bxea_m.bxea009 = ''
                     NEXT FIELD bxea009
                  END IF
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea007
            #add-point:ON CHANGE bxea007 name="input.g.bxea007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea008
            
            #add-point:AFTER FIELD bxea008 name="input.a.bxea008"
            CALL s_desc_get_trading_partner_abbr_desc(g_bxea_m.bxea008) RETURNING g_bxea_m.bxea008_desc
            DISPLAY BY NAME g_bxea_m.bxea008_desc
            IF NOT cl_null(g_bxea_m.bxea008) AND (g_bxea_m.bxea008 <> g_bxea_m_o.bxea008 OR cl_null(g_bxea_m_o.bxea008)) THEN
               IF g_bxea_m.bxea005 MATCHES '[135]' THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bxea_m.bxea008
                   
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pmaa001_27") THEN
                     LET g_bxea_m.bxea008 = g_bxea_m_o.bxea008
                     CALL s_desc_get_trading_partner_abbr_desc(g_bxea_m.bxea008) RETURNING g_bxea_m.bxea008_desc
                     DISPLAY BY NAME g_bxea_m.bxea008_desc
                     NEXT FIELD bxea008
                  END IF
               END IF
               
               IF g_bxea_m.bxea005 MATCHES '[2]' THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bxea_m.bxea008
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pmaa001_7") THEN
                     LET g_bxea_m.bxea008 = g_bxea_m_o.bxea008
                     CALL s_desc_get_trading_partner_abbr_desc(g_bxea_m.bxea008) RETURNING g_bxea_m.bxea008_desc
                     DISPLAY BY NAME g_bxea_m.bxea008_desc
                     NEXT FIELD bxea008
                  END IF
               END IF
               IF g_bxea_m.bxea005 MATCHES '[46]' THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bxea_m.bxea008
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pmaa001_2") THEN
                     LET g_bxea_m.bxea008 = g_bxea_m_o.bxea008
                     CALL s_desc_get_trading_partner_abbr_desc(g_bxea_m.bxea008) RETURNING g_bxea_m.bxea008_desc
                     DISPLAY BY NAME g_bxea_m.bxea008_desc
                     NEXT FIELD bxea008
                  END IF
               END IF
              
               #主要出貨地址
               SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 ='3' AND oofa003 = g_bxea_m.bxea008
               SELECT oofb019 INTO g_bxea_m.bxea016 FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = l_oofa001 AND oofb008 = '3' AND oofb010 = 'Y'
               IF NOT cl_null(g_bxea_m.bxea016) THEN
                  CALL s_aooi350_get_address(l_oofa001,g_bxea_m.bxea016,g_lang) RETURNING l_success,g_bxea_m.oofb017
               END IF
               DISPLAY BY NAME g_bxea_m.bxea016,g_bxea_m.oofb017

            END IF 
            LET g_bxea_m_o.bxea008 = g_bxea_m.bxea008
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea008
            #add-point:BEFORE FIELD bxea008 name="input.b.bxea008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea008
            #add-point:ON CHANGE bxea008 name="input.g.bxea008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea009
            #add-point:BEFORE FIELD bxea009 name="input.b.bxea009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea009
            
            #add-point:AFTER FIELD bxea009 name="input.a.bxea009"
            IF NOT cl_null(g_bxea_m.bxea009) THEN  
               LET l_n = 0
               SELECT COUNT(bxda001) INTO l_n FROM bxda_t 
                  WHERE bxdaent = g_enterprise AND bxdasite = g_site AND bxda001 = g_bxea_m.bxea009 
                    AND bxda003 = g_bxea_m.bxea008 AND bxdastus = 'Y'
               IF l_n = 0 OR cl_null(l_n) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_bxea_m.bxea009
                  LET g_errparam.code   = 'abx-00041'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  LET g_bxea_m.bxea009 = g_bxea_m_t.bxea009
                  NEXT FIELD bxea009
               END IF
               IF NOT cl_null(g_bxea_m.bxea007) THEN
                  IF NOT abxt400_bxea009_chk() THEN
                     LET g_bxea_m.bxea009 = g_bxea_m_t.bxea009
                     NEXT FIELD bxea009
                  END IF
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea009
            #add-point:ON CHANGE bxea009 name="input.g.bxea009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea010
            
            #add-point:AFTER FIELD bxea010 name="input.a.bxea010"
            CALL s_desc_get_acc_desc("1130",g_bxea_m.bxea010) RETURNING g_bxea_m.bxea010_desc
            DISPLAY BY NAME g_bxea_m.bxea010_desc  
            IF NOT cl_null(g_bxea_m.bxea010) THEN
               IF NOT s_azzi650_chk_exist('1130',g_bxea_m.bxea010) THEN
                  LET g_bxea_m.bxea010 = g_bxea_m_t.bxea010
                  CALL s_desc_get_acc_desc("1130",g_bxea_m.bxea010) RETURNING g_bxea_m.bxea010_desc
                  DISPLAY BY NAME g_bxea_m.bxea010_desc  
                  NEXT FIELD CURRENT                                    
               END IF
            END IF     
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea010
            #add-point:BEFORE FIELD bxea010 name="input.b.bxea010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea010
            #add-point:ON CHANGE bxea010 name="input.g.bxea010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea011
            #add-point:BEFORE FIELD bxea011 name="input.b.bxea011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea011
            
            #add-point:AFTER FIELD bxea011 name="input.a.bxea011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea011
            #add-point:ON CHANGE bxea011 name="input.g.bxea011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea012
            #add-point:BEFORE FIELD bxea012 name="input.b.bxea012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea012
            
            #add-point:AFTER FIELD bxea012 name="input.a.bxea012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea012
            #add-point:ON CHANGE bxea012 name="input.g.bxea012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea013
            #add-point:BEFORE FIELD bxea013 name="input.b.bxea013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea013
            
            #add-point:AFTER FIELD bxea013 name="input.a.bxea013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea013
            #add-point:ON CHANGE bxea013 name="input.g.bxea013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea014
            #add-point:BEFORE FIELD bxea014 name="input.b.bxea014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea014
            
            #add-point:AFTER FIELD bxea014 name="input.a.bxea014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea014
            #add-point:ON CHANGE bxea014 name="input.g.bxea014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxea_m.bxea015,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD bxea015
            END IF 
 
 
 
            #add-point:AFTER FIELD bxea015 name="input.a.bxea015"
            IF NOT cl_null(g_bxea_m.bxea015) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea015
            #add-point:BEFORE FIELD bxea015 name="input.b.bxea015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea015
            #add-point:ON CHANGE bxea015 name="input.g.bxea015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea016
            
            #add-point:AFTER FIELD bxea016 name="input.a.bxea016"
            LET g_bxea_m.oofb017 = ''
            DISPLAY BY NAME g_bxea_m.oofb017
            
            IF NOT cl_null(g_bxea_m.bxea016) THEN 
#此段落由子樣板a19產生
               SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 ='3' AND oofa003 = g_bxea_m.bxea008
               
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = l_oofa001
               LET g_chkparam.arg2 = g_bxea_m.bxea016

               LET g_chkparam.err_str[1] ="anm-00025:sub-01302|aooi350|",cl_get_progname("aooi350",g_lang,"2"),"|:EXEPROGaooi350"
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oofb019_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #組合地址
                  CALL s_aooi350_get_address(l_oofa001,g_bxea_m.bxea016,g_lang) RETURNING l_success,g_bxea_m.oofb017
                  DISPLAY BY NAME g_bxea_m.oofb017

               ELSE
                  #檢查失敗時後續處理
                  LET g_bxea_m.bxea016 = g_bxea_m_t.bxea016            
                  #組合地址
                  CALL s_aooi350_get_address(l_oofa001,g_bxea_m.bxea016,g_lang) RETURNING l_success,g_bxea_m.oofb017
                  DISPLAY BY NAME g_bxea_m.oofb017   
                  NEXT FIELD CURRENT
               END IF
           
            END IF 
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea016
            #add-point:BEFORE FIELD bxea016 name="input.b.bxea016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea016
            #add-point:ON CHANGE bxea016 name="input.g.bxea016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea017
            #add-point:BEFORE FIELD bxea017 name="input.b.bxea017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea017
            
            #add-point:AFTER FIELD bxea017 name="input.a.bxea017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea017
            #add-point:ON CHANGE bxea017 name="input.g.bxea017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea018
            #add-point:BEFORE FIELD bxea018 name="input.b.bxea018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea018
            
            #add-point:AFTER FIELD bxea018 name="input.a.bxea018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea018
            #add-point:ON CHANGE bxea018 name="input.g.bxea018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea019
            #add-point:BEFORE FIELD bxea019 name="input.b.bxea019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea019
            
            #add-point:AFTER FIELD bxea019 name="input.a.bxea019"
            IF g_bxea_m.bxea019 = 'Y' THEN
               #不可存在非保税料件
               SELECT COUNT(1) INTO l_n FROM bxeb_t,iman_t 
                  WHERE bxebent = imanent AND bxeb003 = iman001
                    AND imanent = g_enterprise AND imansite = g_site AND iman012 = 'N'
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_bxea_m.bxea019
                  LET g_errparam.code   = 'abx-00045'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  LET g_bxea_m.bxea019 = g_bxea_m_t.bxea019
                  NEXT FIELD bxea019
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea019
            #add-point:ON CHANGE bxea019 name="input.g.bxea019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxea020
            #add-point:BEFORE FIELD bxea020 name="input.b.bxea020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxea020
            
            #add-point:AFTER FIELD bxea020 name="input.a.bxea020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxea020
            #add-point:ON CHANGE bxea020 name="input.g.bxea020"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bxeasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeasite
            #add-point:ON ACTION controlp INFIELD bxeasite name="input.c.bxeasite"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxeadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeadocno
            #add-point:ON ACTION controlp INFIELD bxeadocno name="input.c.bxeadocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bxea_m.bxeadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = g_prog
 
            CALL q_ooba002_1()                                #呼叫開窗
 
            LET g_bxea_m.bxeadocno = g_qryparam.return1              

            DISPLAY g_bxea_m.bxeadocno TO bxeadocno              #
            CALL s_aooi200_get_slip_desc(g_bxea_m.bxeadocno) RETURNING g_bxea_m.bxeadocno_desc
            DISPLAY BY NAME g_bxea_m.bxeadocno_desc

            NEXT FIELD bxeadocno                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bxeadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeadocdt
            #add-point:ON ACTION controlp INFIELD bxeadocdt name="input.c.bxeadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea001
            #add-point:ON ACTION controlp INFIELD bxea001 name="input.c.bxea001"
 
            #END add-point
 
 
         #Ctrlp:input.c.bxea002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea002
            #add-point:ON ACTION controlp INFIELD bxea002 name="input.c.bxea002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bxea_m.bxea002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_bxea_m.bxea002 = g_qryparam.return1              

            DISPLAY g_bxea_m.bxea002 TO bxea002              #
            CALL s_desc_get_person_desc(g_bxea_m.bxea002) RETURNING g_bxea_m.bxea002_desc
            DISPLAY BY NAME g_bxea_m.bxea002_desc

            NEXT FIELD bxea002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bxea003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea003
            #add-point:ON ACTION controlp INFIELD bxea003 name="input.c.bxea003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bxea_m.bxea003             #給予default值
            LET g_qryparam.default2 = "" #g_bxea_m.ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_bxea_m.bxeadocdt   #s

 
            CALL q_ooeg001()                                #呼叫開窗
 
            LET g_bxea_m.bxea003 = g_qryparam.return1         
            DISPLAY g_bxea_m.bxea003 TO bxea003              #
            CALL s_desc_get_department_desc(g_bxea_m.bxea003) RETURNING g_bxea_m.bxea003_desc
            DISPLAY BY NAME g_bxea_m.bxea003_desc
            NEXT FIELD bxea003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bxeastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeastus
            #add-point:ON ACTION controlp INFIELD bxeastus name="input.c.bxeastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea004
            #add-point:ON ACTION controlp INFIELD bxea004 name="input.c.bxea004"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxea005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea005
            #add-point:ON ACTION controlp INFIELD bxea005 name="input.c.bxea005"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxea006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea006
            #add-point:ON ACTION controlp INFIELD bxea006 name="input.c.bxea006"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bxea_m.bxea006             #給予default值
            CASE g_bxea_m.bxea005
               WHEN '1' #1.發料單時，須存在於已確認或已過帳的發料單
                  LET g_qryparam.where = " sfda002 IN ('11','12','13','14','15') AND sfdastus IN ('Y','S') "
                  CALL q_sfdadocno()
                  
               WHEN '2' #2.出貨單時，須存在於已確認或已過帳的出貨單         
                  LET g_qryparam.where = " xmdk000 IN ( '1','2','3') "
                  CALL q_xmdkdocno_1()
               WHEN '3' #3.進料驗退單時，須存在於已確認或已過帳的採購驗退單
                  LET g_qryparam.arg1 = " ('5','10','11') "
                  CALL q_pmdsdocno()
               WHEN '4' #4.雜項發料單時，須存在於aint301已確認或已過帳資料         
                  LET g_qryparam.where = " inba001 = '1' AND inbastus IN ('Y','S') "
                  CALL q_inbadocno()
               WHEN '5' #5.倉退單時，須存在於已確認或已過帳的倉退單
                  LET g_qryparam.arg1 = " ('7','14','15') "
                  CALL q_pmdsdocno()
            END CASE
            
            LET g_bxea_m.bxea006 = g_qryparam.return1         
            DISPLAY g_bxea_m.bxea006 TO bxea006              #

            NEXT FIELD bxea006                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bxea007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea007
            #add-point:ON ACTION controlp INFIELD bxea007 name="input.c.bxea007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bxea_m.bxea007             #給予default值
            CASE g_bxea_m.bxea005
               WHEN '1' #1.資料來源是1.3.5時，須存在於已發出的工單
                  LET g_qryparam.arg1 = " S "
                  CALL q_sfaadocno_1()
                  
               WHEN '2' #2.資料來源是2時，須存在於已確認的訂單內       
                  CALL q_xmdadocno_1()
               WHEN '3' #3.資料來源是1.3.5時，須存在於已發出的工單
                  LET g_qryparam.arg1 = " S "
                  CALL q_sfaadocno_1()
               WHEN '5' #5.資料來源是1.3.5時，須存在於已發出的工單
                  LET g_qryparam.arg1 = " S "
                  CALL q_sfaadocno_1()
            END CASE
            
            LET g_bxea_m.bxea007 = g_qryparam.return1         
            DISPLAY g_bxea_m.bxea007 TO bxea007              #

            NEXT FIELD bxea007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bxea008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea008
            #add-point:ON ACTION controlp INFIELD bxea008 name="input.c.bxea008"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bxea_m.bxea008             #給予default值
            CASE g_bxea_m.bxea005
               WHEN '1' #1.資料來源是1.3.5時，須存在於供應商、交易對象
                  CALL q_pmaa001()
               WHEN '2' #2.須存在於客戶、交易對象    
                  LET g_qryparam.where = " pmaastus = 'Y' "
                  CALL q_pmaa001_7()
               WHEN '3' #3.資料來源是1.3.5時，須存在於供應商、交易對象
                  CALL q_pmaa001()
               WHEN '4' #4.資料來源是4,6時，須存在於供應商、客戶、交易對象
                  LET g_qryparam.where = " pmaastus = 'Y' "
                  CALL q_pmaa001_5()
               WHEN '5' #5.資料來源是1.3.5時，須存在於供應商、交易對象
                  CALL q_pmaa001()
               WHEN '6' #4.資料來源是4,6時，須存在於供應商、客戶、交易對象
                  LET g_qryparam.where = " pmaastus = 'Y' "
                  CALL q_pmaa001_5()
            END CASE
            
            LET g_bxea_m.bxea008 = g_qryparam.return1         
            DISPLAY g_bxea_m.bxea008 TO bxea008              #
            CALL s_desc_get_trading_partner_abbr_desc(g_bxea_m.bxea008) RETURNING g_bxea_m.bxea008_desc
            DISPLAY BY NAME g_bxea_m.bxea008_desc  

            NEXT FIELD bxea008                          #返回原欄位
 
            #END add-point
 
 
         #Ctrlp:input.c.bxea009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea009
            #add-point:ON ACTION controlp INFIELD bxea009 name="input.c.bxea009"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bxea_m.bxea009             #給予default值
            LET g_qryparam.where = " 1=1 "
            IF NOT cl_null(g_bxea_m.bxea008) THEN
               LET g_qryparam.where = " bxda003 = '",g_bxea_m.bxea008,"' "
            END IF
            IF g_bxea_m.bxea005 = '1' THEN
               IF NOT cl_null(g_bxea_m.bxea007) THEN
                  SELECT sfaa010,sfaadocdt,sfaa012,sfaa013 INTO l_sfaa010,l_sfaadocdt,l_sfaa012,l_sfaa013
                     FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = g_bxea_m.bxea007
                  IF NOT cl_null(l_sfaa010) AND NOT cl_null(l_sfaadocdt) THEN
                     SELECT imaa006 INTO l_imaa006 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_sfaa010
                     IF l_imaa006 <> l_sfaa013 THEN
                        CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,l_sfaa012)
                           RETURNING l_success,l_sfaa012
                     END IF
                     LET g_qryparam.where = g_qryparam.where ," AND bxda006-bxda007 > ",l_sfaa012 ," AND bxda004 <= '",l_sfaadocdt,"' AND (bxda005 IS NULL OR bxda005 > '",l_sfaadocdt,"' )"
                  END IF
               END IF
            END IF
 
            CALL q_bxda001()                                #呼叫開窗
 
            LET g_bxea_m.bxea009 = g_qryparam.return1              
           
            DISPLAY g_bxea_m.bxea009 TO bxea009              #

            NEXT FIELD bxea009                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bxea010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea010
            #add-point:ON ACTION controlp INFIELD bxea010 name="input.c.bxea010"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bxea_m.bxea010             #給予default值
            LET g_qryparam.default2 = "" #g_bxea_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "1130" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_bxea_m.bxea010 = g_qryparam.return1              
           
            DISPLAY g_bxea_m.bxea010 TO bxea010              #
           
            CALL s_desc_get_acc_desc("1130",g_bxea_m.bxea010) RETURNING g_bxea_m.bxea010_desc
            DISPLAY BY NAME g_bxea_m.bxea010_desc  
            NEXT FIELD bxea010                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bxea011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea011
            #add-point:ON ACTION controlp INFIELD bxea011 name="input.c.bxea011"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxea012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea012
            #add-point:ON ACTION controlp INFIELD bxea012 name="input.c.bxea012"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxea013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea013
            #add-point:ON ACTION controlp INFIELD bxea013 name="input.c.bxea013"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxea014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea014
            #add-point:ON ACTION controlp INFIELD bxea014 name="input.c.bxea014"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxea015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea015
            #add-point:ON ACTION controlp INFIELD bxea015 name="input.c.bxea015"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxea016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea016
            #add-point:ON ACTION controlp INFIELD bxea016 name="input.c.bxea016"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bxea_m.bxea016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oofb019_1()                                #呼叫開窗
 
            LET g_bxea_m.bxea016 = g_qryparam.return1              

            DISPLAY g_bxea_m.bxea016 TO bxea016              #
            #呼叫地址組合應用元件
            IF NOT cl_null(g_bxea_m.bxea008) AND (NOT cl_null(g_bxea_m.bxea016)) THEN
               LET l_oofa001 = ''
               SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '3' AND oofa003 = g_bxea_m.bxea008
               CALL s_aooi350_get_address(l_oofa001,g_bxea_m.bxea016,g_lang) RETURNING l_success,g_bxea_m.oofb017
               DISPLAY BY NAME g_bxea_m.oofb017
            END IF

            NEXT FIELD bxea016                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bxea017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea017
            #add-point:ON ACTION controlp INFIELD bxea017 name="input.c.bxea017"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxea018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea018
            #add-point:ON ACTION controlp INFIELD bxea018 name="input.c.bxea018"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxea019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea019
            #add-point:ON ACTION controlp INFIELD bxea019 name="input.c.bxea019"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxea020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxea020
            #add-point:ON ACTION controlp INFIELD bxea020 name="input.c.bxea020"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_bxea_m.bxeadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_site,g_bxea_m.bxeadocno,g_bxea_m.bxeadocdt,g_prog) RETURNING l_success,g_bxea_m.bxeadocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_bxea_m.bxeadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD bxeadocno           
               END IF
               #end add-point
               
               INSERT INTO bxea_t (bxeaent,bxeasite,bxeadocno,bxeadocdt,bxea001,bxea002,bxea003,bxeastus, 
                   bxea004,bxea005,bxea006,bxea007,bxea008,bxea009,bxea010,bxea011,bxea012,bxea013,bxea014, 
                   bxea015,bxea016,bxea017,bxea018,bxea019,bxea020,bxeaownid,bxeaowndp,bxeacrtid,bxeacrtdp, 
                   bxeacrtdt,bxeamodid,bxeamoddt,bxeacnfid,bxeacnfdt)
               VALUES (g_enterprise,g_bxea_m.bxeasite,g_bxea_m.bxeadocno,g_bxea_m.bxeadocdt,g_bxea_m.bxea001, 
                   g_bxea_m.bxea002,g_bxea_m.bxea003,g_bxea_m.bxeastus,g_bxea_m.bxea004,g_bxea_m.bxea005, 
                   g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea009,g_bxea_m.bxea010, 
                   g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013,g_bxea_m.bxea014,g_bxea_m.bxea015, 
                   g_bxea_m.bxea016,g_bxea_m.bxea017,g_bxea_m.bxea018,g_bxea_m.bxea019,g_bxea_m.bxea020, 
                   g_bxea_m.bxeaownid,g_bxea_m.bxeaowndp,g_bxea_m.bxeacrtid,g_bxea_m.bxeacrtdp,g_bxea_m.bxeacrtdt, 
                   g_bxea_m.bxeamodid,g_bxea_m.bxeamoddt,g_bxea_m.bxeacnfid,g_bxea_m.bxeacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_bxea_m:",SQLERRMESSAGE 
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
                  CALL abxt400_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL abxt400_b_fill()
                  CALL abxt400_b_fill2('0')
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
               CALL abxt400_bxea_t_mask_restore('restore_mask_o')
               
               UPDATE bxea_t SET (bxeasite,bxeadocno,bxeadocdt,bxea001,bxea002,bxea003,bxeastus,bxea004, 
                   bxea005,bxea006,bxea007,bxea008,bxea009,bxea010,bxea011,bxea012,bxea013,bxea014,bxea015, 
                   bxea016,bxea017,bxea018,bxea019,bxea020,bxeaownid,bxeaowndp,bxeacrtid,bxeacrtdp,bxeacrtdt, 
                   bxeamodid,bxeamoddt,bxeacnfid,bxeacnfdt) = (g_bxea_m.bxeasite,g_bxea_m.bxeadocno, 
                   g_bxea_m.bxeadocdt,g_bxea_m.bxea001,g_bxea_m.bxea002,g_bxea_m.bxea003,g_bxea_m.bxeastus, 
                   g_bxea_m.bxea004,g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008, 
                   g_bxea_m.bxea009,g_bxea_m.bxea010,g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013, 
                   g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016,g_bxea_m.bxea017,g_bxea_m.bxea018, 
                   g_bxea_m.bxea019,g_bxea_m.bxea020,g_bxea_m.bxeaownid,g_bxea_m.bxeaowndp,g_bxea_m.bxeacrtid, 
                   g_bxea_m.bxeacrtdp,g_bxea_m.bxeacrtdt,g_bxea_m.bxeamodid,g_bxea_m.bxeamoddt,g_bxea_m.bxeacnfid, 
                   g_bxea_m.bxeacnfdt)
                WHERE bxeaent = g_enterprise AND bxeadocno = g_bxeadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "bxea_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL abxt400_bxea_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_bxea_m_t)
               LET g_log2 = util.JSON.stringify(g_bxea_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_bxeadocno_t = g_bxea_m.bxeadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="abxt400.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_bxeb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bxeb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abxt400_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_bxeb_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            LET l_n = 0 
            SELECT COUNT(1) INTO l_n FROM bxeb_t
              WHERE bxebent = g_enterprise AND bxebdocno = g_bxea_m.bxeadocno
            IF l_n = 0 OR cl_null(l_n) THEN
               IF g_bxea_m.bxea005 <> '6' AND NOT cl_null(g_bxea_m.bxea006) THEN
                  IF cl_ask_confirm('axm-00013') THEN
                     CALL s_transaction_begin()
                  
                     CALL abxt400_gen_bxeb()  #自動產生單身
                     CALL abxt400_b_fill()
                     LET g_rec_b = g_bxeb_d.getLength()
                     IF g_rec_b > 0 THEN
                        CALL s_transaction_end('Y','0')
                        LET g_flag = TRUE
                        EXIT DIALOG
                     ELSE
                        CALL s_transaction_end('N','0')
                        LET g_flag = FALSE
                        NEXT FIELD bxeb001
                     END IF
                  END IF
               END IF
               IF g_bxea_m.bxea005 = '2' AND cl_null(g_bxea_m.bxea006) THEN
                  CALL s_transaction_begin()
                  CALL abxt400_02(g_bxea_m.bxeadocno) RETURNING l_success  #自動產生單身
                  CALL abxt400_b_fill()
                  LET g_rec_b = g_bxeb_d.getLength()
                  IF g_rec_b > 0 THEN
                     CALL s_transaction_end('Y','0')
                     LET g_flag = TRUE
                     EXIT DIALOG
                  ELSE
                     CALL s_transaction_end('N','0')
                     LET g_flag = FALSE
                     NEXT FIELD bxeb001
                  END IF
               END IF
            END IF
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
            OPEN abxt400_cl USING g_enterprise,g_bxea_m.bxeadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abxt400_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abxt400_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_bxeb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bxeb_d[l_ac].bxebseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bxeb_d_t.* = g_bxeb_d[l_ac].*  #BACKUP
               LET g_bxeb_d_o.* = g_bxeb_d[l_ac].*  #BACKUP
               CALL abxt400_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               CALL abxt400_set_no_required_b()
               CALL abxt400_set_required_b()
               #end add-point  
               CALL abxt400_set_no_entry_b(l_cmd)
               IF NOT abxt400_lock_b("bxeb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abxt400_bcl INTO g_bxeb_d[l_ac].bxebsite,g_bxeb_d[l_ac].bxebseq,g_bxeb_d[l_ac].bxeb001, 
                      g_bxeb_d[l_ac].bxeb002,g_bxeb_d[l_ac].bxeb003,g_bxeb_d[l_ac].bxeb004,g_bxeb_d[l_ac].bxeb005, 
                      g_bxeb_d[l_ac].bxeb006,g_bxeb_d[l_ac].bxeb007,g_bxeb_d[l_ac].bxeb008,g_bxeb_d[l_ac].bxeb009 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bxeb_d_t.bxebseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bxeb_d_mask_o[l_ac].* =  g_bxeb_d[l_ac].*
                  CALL abxt400_bxeb_t_mask()
                  LET g_bxeb_d_mask_n[l_ac].* =  g_bxeb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL abxt400_show()
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
            INITIALIZE g_bxeb_d[l_ac].* TO NULL 
            INITIALIZE g_bxeb_d_t.* TO NULL 
            INITIALIZE g_bxeb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_bxeb_d[l_ac].bxeb005 = "0"
      LET g_bxeb_d[l_ac].bxeb007 = "0"
      LET g_bxeb_d[l_ac].bxeb009 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_bxeb_d[l_ac].bxebsite = g_site
            #項次加1
            SELECT MAX(bxebseq)+1 INTO g_bxeb_d[l_ac].bxebseq FROM bxeb_t
              WHERE bxebent = g_enterprise AND bxebdocno = g_bxea_m.bxeadocno
            IF cl_null(g_bxeb_d[l_ac].bxebseq) OR g_bxeb_d[l_ac].bxebseq = 0 THEN
               LET g_bxeb_d[l_ac].bxebseq = 1
            END IF
            IF NOT cl_null(g_bxea_m.bxea006) THEN
               LET g_bxeb_d[l_ac].bxeb001 = g_bxea_m.bxea006
            END IF
            #end add-point
            LET g_bxeb_d_t.* = g_bxeb_d[l_ac].*     #新輸入資料
            LET g_bxeb_d_o.* = g_bxeb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abxt400_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            CALL abxt400_set_no_required_b()
            CALL abxt400_set_required_b()
            #end add-point
            CALL abxt400_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bxeb_d[li_reproduce_target].* = g_bxeb_d[li_reproduce].*
 
               LET g_bxeb_d[li_reproduce_target].bxebseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM bxeb_t 
             WHERE bxebent = g_enterprise AND bxebdocno = g_bxea_m.bxeadocno
 
               AND bxebseq = g_bxeb_d[l_ac].bxebseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bxea_m.bxeadocno
               LET gs_keys[2] = g_bxeb_d[g_detail_idx].bxebseq
               CALL abxt400_insert_b('bxeb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_bxeb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bxeb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abxt400_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #單頭的「資料來源」= 2.出貨單時，單身異動時，更新出貨單單身欄位「放行狀態」
               IF g_bxea_m.bxea005 = '2' THEN 
                  IF NOT s_abxt400_upd_xmdl(g_bxeb_d[l_ac].bxeb001,g_bxeb_d[l_ac].bxeb002,g_bxeb_d[l_ac].bxeb004,g_bxeb_d[l_ac].bxeb005,g_bxeb_d_t.bxeb005,'a') THEN
                     CALL s_transaction_end('N','0')                    
                     CANCEL INSERT
                  END IF
               END IF
               #資料來源=1.發料單時,更新bxda_t的已核銷數量及工單的保稅核銷否
               IF g_bxea_m.bxea005 = '1' THEN 
                  IF NOT s_abxt400_upd_bxda(g_bxea_m.bxeadocno,g_bxeb_d[l_ac].bxeb001,g_bxeb_d[l_ac].bxeb002,'a') THEN
                     CALL s_transaction_end('N','0')                    
                     CANCEL INSERT
                  END IF
               END IF
               
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
               #單頭的「資料來源」= 2.出貨單時，單身異動時，更新出貨單單身欄位「放行狀態」
               IF g_bxea_m.bxea005 = '2' THEN 
                  IF NOT s_abxt400_upd_xmdl(g_bxeb_d[l_ac].bxeb001,g_bxeb_d[l_ac].bxeb002,g_bxeb_d[l_ac].bxeb004,g_bxeb_d[l_ac].bxeb005,g_bxeb_d_t.bxeb005,'d') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE abxt400_bcl
                     CANCEL DELETE                   
                  END IF
               END IF
               #資料來源=1.發料單時,更新bxda_t的已核銷數量及工單的保稅核銷否
               IF g_bxea_m.bxea005 = '1' THEN 
                  IF NOT s_abxt400_upd_bxda(g_bxea_m.bxeadocno,g_bxeb_d[l_ac].bxeb001,g_bxeb_d[l_ac].bxeb002,'d') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE abxt400_bcl
                     CANCEL DELETE  
                  END IF
               END IF
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_bxea_m.bxeadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_bxeb_d_t.bxebseq
 
            
               #刪除同層單身
               IF NOT abxt400_delete_b('bxeb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abxt400_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT abxt400_key_delete_b(gs_keys,'bxeb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abxt400_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE abxt400_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_bxeb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bxeb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxebsite
            #add-point:BEFORE FIELD bxebsite name="input.b.page1.bxebsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxebsite
            
            #add-point:AFTER FIELD bxebsite name="input.a.page1.bxebsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxebsite
            #add-point:ON CHANGE bxebsite name="input.g.page1.bxebsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxebseq
            #add-point:BEFORE FIELD bxebseq name="input.b.page1.bxebseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxebseq
            
            #add-point:AFTER FIELD bxebseq name="input.a.page1.bxebseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bxea_m.bxeadocno IS NOT NULL AND g_bxeb_d[g_detail_idx].bxebseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bxea_m.bxeadocno != g_bxeadocno_t OR g_bxeb_d[g_detail_idx].bxebseq != g_bxeb_d_t.bxebseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bxeb_t WHERE "||"bxebent = " ||g_enterprise|| " AND "||"bxebdocno = '"||g_bxea_m.bxeadocno ||"' AND "|| "bxebseq = '"||g_bxeb_d[g_detail_idx].bxebseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxebseq
            #add-point:ON CHANGE bxebseq name="input.g.page1.bxebseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb001
            #add-point:BEFORE FIELD bxeb001 name="input.b.page1.bxeb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb001
            
            #add-point:AFTER FIELD bxeb001 name="input.a.page1.bxeb001"
            IF NOT cl_null(g_bxeb_d[l_ac].bxeb001) THEN
               IF g_bxeb_d[l_ac].bxeb001 <> g_bxeb_d_o.bxeb001 OR cl_null(g_bxeb_d_o.bxeb001) THEN
                  IF NOT abxt400_bxea006_chk(g_bxeb_d[l_ac].bxeb001) THEN
                     LET g_bxeb_d[l_ac].bxeb001 = g_bxeb_d_o.bxeb001
                     NEXT FIELD bxeb001
                  END IF
                  IF NOT cl_null(g_bxeb_d[l_ac].bxeb002) THEN
                     IF NOT abxt400_bxeb002_chk() THEN
                        LET g_bxeb_d[l_ac].bxeb001 = g_bxeb_d_o.bxeb001
                        NEXT FIELD bxeb001
                     END IF
                  END IF
               END IF
            END IF
            LET g_bxeb_d_o.bxeb001 = g_bxeb_d[l_ac].bxeb001
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxeb001
            #add-point:ON CHANGE bxeb001 name="input.g.page1.bxeb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb002
            #add-point:BEFORE FIELD bxeb002 name="input.b.page1.bxeb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb002
            
            #add-point:AFTER FIELD bxeb002 name="input.a.page1.bxeb002"
            IF NOT cl_null(g_bxeb_d[l_ac].bxeb002) THEN
               IF g_bxeb_d[l_ac].bxeb002 <> g_bxeb_d_o.bxeb002 OR cl_null(g_bxeb_d_o.bxeb002) THEN
                  IF NOT cl_null(g_bxeb_d[l_ac].bxeb001) THEN
                     IF NOT abxt400_bxeb002_chk() THEN
                        LET g_bxeb_d[l_ac].bxeb002 = g_bxeb_d_o.bxeb002
                        NEXT FIELD bxeb002
                     END IF
                  END IF
               END IF
            END IF
            LET g_bxeb_d_o.bxeb002 = g_bxeb_d[l_ac].bxeb002
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxeb002
            #add-point:ON CHANGE bxeb002 name="input.g.page1.bxeb002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb003
            
            #add-point:AFTER FIELD bxeb003 name="input.a.page1.bxeb003"
            CALL s_desc_get_item_desc(g_bxeb_d[l_ac].bxeb003) RETURNING g_bxeb_d[l_ac].bxeb003_desc,g_bxeb_d[l_ac].bxeb003_desc_1
            DISPLAY BY NAME g_bxeb_d[l_ac].bxeb003_desc,g_bxeb_d[l_ac].bxeb003_desc_1
            IF NOT cl_null(g_bxeb_d[l_ac].bxeb003) THEN
               IF g_bxeb_d[l_ac].bxeb003 <> g_bxeb_d_o.bxeb003 OR cl_null(g_bxeb_d_o.bxeb003) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bxeb_d[l_ac].bxeb003
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_imaa001") THEN
                     IF NOT cl_chk_exist("v_imaf001_14") THEN
                        LET g_bxeb_d[l_ac].bxeb003 = g_bxeb_d_o.bxeb003
                        CALL s_desc_get_item_desc(g_bxeb_d[l_ac].bxeb003) RETURNING g_bxeb_d[l_ac].bxeb003_desc,g_bxeb_d[l_ac].bxeb003_desc_1
                        DISPLAY BY NAME g_bxeb_d[l_ac].bxeb003_desc,g_bxeb_d[l_ac].bxeb003_desc_1
                        NEXT FIELD bxeb003
                     END IF
                  END IF
                   #單頭的「單身僅存保稅品否」有勾選時，料號若不為保稅品，則顯示錯誤
                  IF g_bxea_m.bxea019 = 'Y' THEN
                     SELECT iman012 INTO g_bxeb_d[l_ac].iman012 FROM iman_t WHERE imanent = g_enterprise AND imansite = g_site AND iman001 = g_bxeb_d[l_ac].bxeb003
                     IF g_bxeb_d[l_ac].iman012 <> 'Y' OR cl_null(g_bxeb_d[l_ac].iman012) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_bxea_m.bxea009
                        LET g_errparam.code   = 'abx-00049'
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err() 
                        LET g_bxeb_d[l_ac].bxeb003 = g_bxeb_d_o.bxeb003
                        LET g_bxeb_d[l_ac].iman012 = g_bxeb_d_t.iman012
                        CALL s_desc_get_item_desc(g_bxeb_d[l_ac].bxeb003) RETURNING g_bxeb_d[l_ac].bxeb003_desc,g_bxeb_d[l_ac].bxeb003_desc_1
                        DISPLAY BY NAME g_bxeb_d[l_ac].bxeb003_desc,g_bxeb_d[l_ac].bxeb003_desc_1
                        NEXT FIELD bxeb003
                     END IF
                  END IF
               END IF
            END IF
            LET g_bxeb_d_o.bxeb003 = g_bxeb_d[l_ac].bxeb003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb003
            #add-point:BEFORE FIELD bxeb003 name="input.b.page1.bxeb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxeb003
            #add-point:ON CHANGE bxeb003 name="input.g.page1.bxeb003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb004
            
            #add-point:AFTER FIELD bxeb004 name="input.a.page1.bxeb004"
            CALL s_desc_get_unit_desc(g_bxeb_d[l_ac].bxeb004) RETURNING g_bxeb_d[l_ac].bxeb004_desc
            DISPLAY BY NAME g_bxeb_d[l_ac].bxeb004_desc
            IF NOT cl_null(g_bxeb_d[l_ac].bxeb004) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bxeb_d[l_ac].bxeb003
               LET g_chkparam.arg2 = g_bxeb_d[l_ac].bxeb004
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imao002") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_bxeb_d[l_ac].bxeb004 = g_bxeb_d_t.bxeb004
                  CALL s_desc_get_unit_desc(g_bxeb_d[l_ac].bxeb004) RETURNING g_bxeb_d[l_ac].bxeb004_desc
                  DISPLAY BY NAME g_bxeb_d[l_ac].bxeb004_desc
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_bxeb_d[l_ac].bxeb005) THEN 
                  CALL s_aooi250_take_decimals(g_bxeb_d[l_ac].bxeb004,g_bxeb_d[l_ac].bxeb005)
                     RETURNING l_success,g_bxeb_d[l_ac].bxeb005
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb004
            #add-point:BEFORE FIELD bxeb004 name="input.b.page1.bxeb004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxeb004
            #add-point:ON CHANGE bxeb004 name="input.g.page1.bxeb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxeb_d[l_ac].bxeb005,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD bxeb005
            END IF 
 
 
 
            #add-point:AFTER FIELD bxeb005 name="input.a.page1.bxeb005"
            IF NOT cl_null(g_bxeb_d[l_ac].bxeb005) THEN 
               IF g_bxeb_d[l_ac].bxeb005 <> g_bxeb_d_o.bxeb005 OR cl_null(g_bxeb_d_o.bxeb005) THEN
                  IF NOT cl_null(g_bxeb_d[l_ac].bxeb001) AND NOT cl_null(g_bxeb_d[l_ac].bxeb002) THEN
                     CALL s_abxt400_get_bxeb(g_bxea_m.bxeadocno,g_bxea_m.bxea005,g_bxeb_d[l_ac].bxebseq,g_bxeb_d[l_ac].bxeb001,g_bxeb_d[l_ac].bxeb002)
                        RETURNING l_bxeb003,l_bxeb004,l_bxeb005,l_bxeb006,l_bxeb007,l_bxeb008,l_bxeb009,l_iman012
                     IF g_bxeb_d[l_ac].bxeb005 > l_bxeb005 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_bxeb_d[l_ac].bxeb005
                        LET g_errparam.code   = 'abx-00050'
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err() 
                        LET g_bxeb_d[l_ac].bxeb005 = g_bxeb_d_o.bxeb005
                        NEXT FIELD bxeb005
                     END IF
                  END IF
                  
                  IF NOT cl_null(g_bxeb_d[l_ac].bxeb004) THEN
                     CALL s_aooi250_take_decimals(g_bxeb_d[l_ac].bxeb004,g_bxeb_d[l_ac].bxeb005)
                         RETURNING l_success,g_bxeb_d[l_ac].bxeb005
                  END IF
                  
                  IF NOT cl_null(g_bxeb_d[l_ac].bxeb007) AND NOT cl_null(g_bxeb_d[l_ac].bxeb008) THEN
                     LET g_bxeb_d[l_ac].bxeb009 = g_bxeb_d[l_ac].bxeb005 * g_bxeb_d[l_ac].bxeb007 * g_bxeb_d[l_ac].bxeb008
                     #呼叫幣別取位應用元件對金額作取位(依單頭幣別做取位基準)
                     CALL s_curr_round(g_site,g_bxeb_d[l_ac].bxeb006,g_bxeb_d[l_ac].bxeb009 ,'2') RETURNING g_bxeb_d[l_ac].bxeb009 
                     LET g_bxeb_d_o.bxeb009 = g_bxeb_d[l_ac].bxeb009
                  END IF
               END IF
            END IF 
            LET g_bxeb_d_o.bxeb005 = g_bxeb_d[l_ac].bxeb005
 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb005
            #add-point:BEFORE FIELD bxeb005 name="input.b.page1.bxeb005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxeb005
            #add-point:ON CHANGE bxeb005 name="input.g.page1.bxeb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb006
            
            #add-point:AFTER FIELD bxeb006 name="input.a.page1.bxeb006"
            CALL s_desc_get_currency_desc(g_bxeb_d[l_ac].bxeb006) RETURNING g_bxeb_d[l_ac].bxeb006_desc
            DISPLAY BY NAME g_bxeb_d[l_ac].bxeb006_desc
            IF NOT cl_null(g_bxeb_d[l_ac].bxeb006) THEN 
               IF g_bxeb_d[l_ac].bxeb006 <> g_bxeb_d_o.bxeb006 OR cl_null(g_bxeb_d_o.bxeb006) THEN
#應用 a17 樣板自動產生(Version:3)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_bxeb_d[l_ac].bxeb006
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooaj002") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     LET g_bxeb_d[l_ac].bxeb006 = g_bxeb_d_t.bxeb006
                     CALL s_desc_get_currency_desc(g_bxeb_d[l_ac].bxeb006) RETURNING g_bxeb_d[l_ac].bxeb006_desc
                     DISPLAY BY NAME g_bxeb_d[l_ac].bxeb006_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #輸入值與aooi100的主幣別編號(ooef016)取得匯率(取位)
                  SELECT ooef016 INTO l_bxeb006 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
                  IF g_bxeb_d[l_ac].bxeb006 <> l_bxeb006 THEN
                     CALL s_aooi160_get_exrate('1',g_site,g_today,g_bxeb_d[l_ac].bxeb006,l_bxeb006,0,'1') RETURNING g_bxeb_d[l_ac].bxeb008
                  ELSE
                     LET g_bxeb_d[l_ac].bxeb008 = 1
                  END IF
                  LET g_bxeb_d_o.bxeb008 = g_bxeb_d[l_ac].bxeb008
                  
                  IF NOT cl_null(g_bxeb_d[l_ac].bxeb007) THEN
                     #呼叫幣別取位應用元件對單價作取位(依單頭幣別做取位基準)
                     CALL s_curr_round(g_site,g_bxeb_d[l_ac].bxeb006,g_bxeb_d[l_ac].bxeb007,'1') RETURNING g_bxeb_d[l_ac].bxeb007
                     LET g_bxeb_d_o.bxeb007 = g_bxeb_d[l_ac].bxeb007
                  END IF
                  
                  IF NOT cl_null(g_bxeb_d[l_ac].bxeb007) AND NOT cl_null(g_bxeb_d[l_ac].bxeb008) THEN
                     LET g_bxeb_d[l_ac].bxeb009 = g_bxeb_d[l_ac].bxeb005 * g_bxeb_d[l_ac].bxeb007 * g_bxeb_d[l_ac].bxeb008
                     #呼叫幣別取位應用元件對金額作取位(依單頭幣別做取位基準)
                     CALL s_curr_round(g_site,g_bxeb_d[l_ac].bxeb006,g_bxeb_d[l_ac].bxeb009 ,'2') RETURNING g_bxeb_d[l_ac].bxeb009 
                     LET g_bxeb_d_o.bxeb009 = g_bxeb_d[l_ac].bxeb009
                  END IF
               END IF


            END IF 
            LET g_bxeb_d_o.bxeb006 = g_bxeb_d[l_ac].bxeb006

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb006
            #add-point:BEFORE FIELD bxeb006 name="input.b.page1.bxeb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxeb006
            #add-point:ON CHANGE bxeb006 name="input.g.page1.bxeb006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxeb_d[l_ac].bxeb007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD bxeb007
            END IF 
 
 
 
            #add-point:AFTER FIELD bxeb007 name="input.a.page1.bxeb007"
            IF NOT cl_null(g_bxeb_d[l_ac].bxeb007) THEN 
               IF g_bxeb_d[l_ac].bxeb007 <> g_bxeb_d_o.bxeb007 OR cl_null(g_bxeb_d_o.bxeb007) THEN
                  IF NOT cl_null(g_bxeb_d[l_ac].bxeb006) THEN
                     #呼叫幣別取位應用元件對單價作取位(依單頭幣別做取位基準)
                     CALL s_curr_round(g_site,g_bxeb_d[l_ac].bxeb006,g_bxeb_d[l_ac].bxeb007,'1') RETURNING g_bxeb_d[l_ac].bxeb007
                  END IF
                  
                  IF NOT cl_null(g_bxeb_d[l_ac].bxeb005) AND NOT cl_null(g_bxeb_d[l_ac].bxeb008) THEN
                     LET g_bxeb_d[l_ac].bxeb009 = g_bxeb_d[l_ac].bxeb005 * g_bxeb_d[l_ac].bxeb007 * g_bxeb_d[l_ac].bxeb008
                     #呼叫幣別取位應用元件對金額作取位(依單頭幣別做取位基準)
                     CALL s_curr_round(g_site,g_bxeb_d[l_ac].bxeb006,g_bxeb_d[l_ac].bxeb009 ,'2') RETURNING g_bxeb_d[l_ac].bxeb009 
                     LET g_bxeb_d_o.bxeb009 = g_bxeb_d[l_ac].bxeb009
                  END IF
               END IF
            END IF 
            LET g_bxeb_d_o.bxeb007 = g_bxeb_d[l_ac].bxeb007

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb007
            #add-point:BEFORE FIELD bxeb007 name="input.b.page1.bxeb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxeb007
            #add-point:ON CHANGE bxeb007 name="input.g.page1.bxeb007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxeb_d[l_ac].bxeb008,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD bxeb008
            END IF 
 
 
 
            #add-point:AFTER FIELD bxeb008 name="input.a.page1.bxeb008"
            IF NOT cl_null(g_bxeb_d[l_ac].bxeb008) THEN 
               IF g_bxeb_d[l_ac].bxeb008 <> g_bxeb_d_o.bxeb008 OR cl_null(g_bxeb_d_o.bxeb008) THEN
                  
                  CALL s_curr_round(g_site,g_bxeb_d[l_ac].bxeb006,g_bxeb_d[l_ac].bxeb008 ,'3') RETURNING g_bxeb_d[l_ac].bxeb008
                  
                  IF NOT cl_null(g_bxeb_d[l_ac].bxeb005) AND NOT cl_null(g_bxeb_d[l_ac].bxeb008) THEN
                     LET g_bxeb_d[l_ac].bxeb009 = g_bxeb_d[l_ac].bxeb005 * g_bxeb_d[l_ac].bxeb007 * g_bxeb_d[l_ac].bxeb008
                     #呼叫幣別取位應用元件對金額作取位(依單頭幣別做取位基準)
                     CALL s_curr_round(g_site,g_bxeb_d[l_ac].bxeb006,g_bxeb_d[l_ac].bxeb009 ,'2') RETURNING g_bxeb_d[l_ac].bxeb009 
                     LET g_bxeb_d_o.bxeb009 = g_bxeb_d[l_ac].bxeb009
                  END IF
               END IF
            END IF 
            LET g_bxeb_d_o.bxeb008 = g_bxeb_d[l_ac].bxeb008

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb008
            #add-point:BEFORE FIELD bxeb008 name="input.b.page1.bxeb008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxeb008
            #add-point:ON CHANGE bxeb008 name="input.g.page1.bxeb008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxeb009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxeb_d[l_ac].bxeb009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD bxeb009
            END IF 
 
 
 
            #add-point:AFTER FIELD bxeb009 name="input.a.page1.bxeb009"
            IF NOT cl_null(g_bxeb_d[l_ac].bxeb009) THEN 
               IF g_bxeb_d[l_ac].bxeb009 <> g_bxeb_d_o.bxeb009 OR cl_null(g_bxeb_d_o.bxeb009) THEN
                  IF NOT cl_null(g_bxeb_d[l_ac].bxeb006) THEN
                     #呼叫幣別取位應用元件對金額作取位(依單頭幣別做取位基準)
                     CALL s_curr_round(g_site,g_bxeb_d[l_ac].bxeb006,g_bxeb_d[l_ac].bxeb009 ,'2') RETURNING g_bxeb_d[l_ac].bxeb009 
                  END IF
               END IF
            END IF 
            LET g_bxeb_d_o.bxeb009 = g_bxeb_d[l_ac].bxeb009

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxeb009
            #add-point:BEFORE FIELD bxeb009 name="input.b.page1.bxeb009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxeb009
            #add-point:ON CHANGE bxeb009 name="input.g.page1.bxeb009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bxebsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxebsite
            #add-point:ON ACTION controlp INFIELD bxebsite name="input.c.page1.bxebsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bxebseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxebseq
            #add-point:ON ACTION controlp INFIELD bxebseq name="input.c.page1.bxebseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bxeb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb001
            #add-point:ON ACTION controlp INFIELD bxeb001 name="input.c.page1.bxeb001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bxeb_d[l_ac].bxeb001            #給予default值
            CASE g_bxea_m.bxea005
               WHEN '1' #1.發料單時，須存在於已確認或已過帳的發料單
                  LET g_qryparam.where = " sfda002 IN ('11','12','13','14','15') AND sfdastus IN ('Y','S') "
                  CALL q_sfdadocno()
                  
               WHEN '2' #2.出貨單時，須存在於已確認或已過帳的出貨單         
                  LET g_qryparam.where = " xmdk000 IN ( '1','2','3') "
                  CALL q_xmdkdocno_1()
               WHEN '3' #3.進料驗退單時，須存在於已確認或已過帳的採購驗退單
                  LET g_qryparam.arg1 = " ('5','10','11') "
                  CALL q_pmdsdocno()
               WHEN '4' #4.雜項發料單時，須存在於aint301已確認或已過帳資料         
                  LET g_qryparam.where = " inba001 = '1' AND inbastus IN ('Y','S') "
                  CALL q_inbadocno()
               WHEN '5' #5.倉退單時，須存在於已確認或已過帳的倉退單
                  LET g_qryparam.arg1 = " ('7','14','15') "
                  CALL q_pmdsdocno()
            END CASE
            
            LET g_bxeb_d[l_ac].bxeb001 = g_qryparam.return1         
            DISPLAY g_bxeb_d[l_ac].bxeb001 TO bxeb001              #

            NEXT FIELD bxeb001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bxeb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb002
            #add-point:ON ACTION controlp INFIELD bxeb002 name="input.c.page1.bxeb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bxeb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb003
            #add-point:ON ACTION controlp INFIELD bxeb003 name="input.c.page1.bxeb003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bxeb_d[l_ac].bxeb003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            
            IF g_bxea_m.bxea019 = 'Y' THEN
               LET g_qryparam.where = " imaf001 IN (SELECT iman001 FROM iman_t WHERE imanent = ",g_enterprise," AND imansite = '",g_site,"' AND iman012 ='Y' ) "
            END IF
            
            CALL q_imaf001_15()                                #呼叫開窗
 
            LET g_bxeb_d[l_ac].bxeb003 = g_qryparam.return1              

            DISPLAY g_bxeb_d[l_ac].bxeb003 TO bxeb003              #
            CALL s_desc_get_item_desc(g_bxeb_d[l_ac].bxeb003) RETURNING g_bxeb_d[l_ac].bxeb003_desc,g_bxeb_d[l_ac].bxeb003_desc_1
            DISPLAY BY NAME g_bxeb_d[l_ac].bxeb003_desc,g_bxeb_d[l_ac].bxeb003_desc_1

            NEXT FIELD bxeb003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bxeb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb004
            #add-point:ON ACTION controlp INFIELD bxeb004 name="input.c.page1.bxeb004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bxeb_d[l_ac].bxeb004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_bxeb_d[l_ac].bxeb003

 
            CALL q_imao002()                                #呼叫開窗
 
            LET g_bxeb_d[l_ac].bxeb004 = g_qryparam.return1              

            DISPLAY g_bxeb_d[l_ac].bxeb004 TO bxeb004              #
            CALL s_desc_get_unit_desc(g_bxeb_d[l_ac].bxeb004) RETURNING g_bxeb_d[l_ac].bxeb004_desc
            DISPLAY BY NAME g_bxeb_d[l_ac].bxeb004_desc

            NEXT FIELD bxeb004                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bxeb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb005
            #add-point:ON ACTION controlp INFIELD bxeb005 name="input.c.page1.bxeb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bxeb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb006
            #add-point:ON ACTION controlp INFIELD bxeb006 name="input.c.page1.bxeb006"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bxeb_d[l_ac].bxeb006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site

 
            CALL q_ooaj002_1()                                #呼叫開窗
 
            LET g_bxeb_d[l_ac].bxeb006 = g_qryparam.return1              

            DISPLAY g_bxeb_d[l_ac].bxeb006 TO bxeb006              #
            CALL s_desc_get_currency_desc(g_bxeb_d[l_ac].bxeb006) RETURNING g_bxeb_d[l_ac].bxeb006_desc
            DISPLAY BY NAME g_bxeb_d[l_ac].bxeb006_desc

            NEXT FIELD bxeb006                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bxeb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb007
            #add-point:ON ACTION controlp INFIELD bxeb007 name="input.c.page1.bxeb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bxeb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb008
            #add-point:ON ACTION controlp INFIELD bxeb008 name="input.c.page1.bxeb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bxeb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxeb009
            #add-point:ON ACTION controlp INFIELD bxeb009 name="input.c.page1.bxeb009"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bxeb_d[l_ac].* = g_bxeb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abxt400_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_bxeb_d[l_ac].bxebseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_bxeb_d[l_ac].* = g_bxeb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL abxt400_bxeb_t_mask_restore('restore_mask_o')
      
               UPDATE bxeb_t SET (bxebdocno,bxebsite,bxebseq,bxeb001,bxeb002,bxeb003,bxeb004,bxeb005, 
                   bxeb006,bxeb007,bxeb008,bxeb009) = (g_bxea_m.bxeadocno,g_bxeb_d[l_ac].bxebsite,g_bxeb_d[l_ac].bxebseq, 
                   g_bxeb_d[l_ac].bxeb001,g_bxeb_d[l_ac].bxeb002,g_bxeb_d[l_ac].bxeb003,g_bxeb_d[l_ac].bxeb004, 
                   g_bxeb_d[l_ac].bxeb005,g_bxeb_d[l_ac].bxeb006,g_bxeb_d[l_ac].bxeb007,g_bxeb_d[l_ac].bxeb008, 
                   g_bxeb_d[l_ac].bxeb009)
                WHERE bxebent = g_enterprise AND bxebdocno = g_bxea_m.bxeadocno 
 
                  AND bxebseq = g_bxeb_d_t.bxebseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_bxeb_d[l_ac].* = g_bxeb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bxeb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_bxeb_d[l_ac].* = g_bxeb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bxeb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bxea_m.bxeadocno
               LET gs_keys_bak[1] = g_bxeadocno_t
               LET gs_keys[2] = g_bxeb_d[g_detail_idx].bxebseq
               LET gs_keys_bak[2] = g_bxeb_d_t.bxebseq
               CALL abxt400_update_b('bxeb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL abxt400_bxeb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_bxeb_d[g_detail_idx].bxebseq = g_bxeb_d_t.bxebseq 
 
                  ) THEN
                  LET gs_keys[01] = g_bxea_m.bxeadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bxeb_d_t.bxebseq
 
                  CALL abxt400_key_update_b(gs_keys,'bxeb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_bxea_m),util.JSON.stringify(g_bxeb_d_t)
               LET g_log2 = util.JSON.stringify(g_bxea_m),util.JSON.stringify(g_bxeb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               #單頭的「資料來源」= 2.出貨單時，單身異動時，更新出貨單單身欄位「放行狀態」
               IF g_bxea_m.bxea005 = '2' THEN 
                  IF NOT s_abxt400_upd_xmdl(g_bxeb_d[l_ac].bxeb001,g_bxeb_d[l_ac].bxeb002,g_bxeb_d[l_ac].bxeb004,g_bxeb_d[l_ac].bxeb005,g_bxeb_d_t.bxeb005,'u') THEN
                     CALL s_transaction_end('N','0')                    
                  END IF
               END IF
               #資料來源=1.發料單時,更新bxda_t的已核銷數量及工單的保稅核銷否
               IF g_bxea_m.bxea005 = '1' THEN 
                  IF NOT s_abxt400_upd_bxda(g_bxea_m.bxeadocno,g_bxeb_d[l_ac].bxeb001,g_bxeb_d[l_ac].bxeb002,'u') THEN
                     CALL s_transaction_end('N','0')  
                  END IF
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL abxt400_unlock_b("bxeb_t","'1'")
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
               LET g_bxeb_d[li_reproduce_target].* = g_bxeb_d[li_reproduce].*
 
               LET g_bxeb_d[li_reproduce_target].bxebseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bxeb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bxeb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="abxt400.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF g_flag THEN
            LET g_flag = FALSE
            NEXT FIELD bxeb001
         END IF 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD bxeadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bxebsite
 
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
   IF g_flag THEN
      CALL abxt400_input('u')
   END IF  
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="abxt400.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abxt400_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_oofa001    LIKE oofa_t.oofa001   
   DEFINE l_success    LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL abxt400_b_fill() #單身填充
      CALL abxt400_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abxt400_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   IF NOT cl_null(g_bxea_m.bxeadocno) THEN
      CALL s_aooi200_get_slip_desc(g_bxea_m.bxeadocno) RETURNING g_bxea_m.bxeadocno_desc
      DISPLAY BY NAME g_bxea_m.bxeadocno_desc
   END IF
   
   #呼叫地址組合應用元件
   LET g_bxea_m.oofb017 = ''
   IF NOT cl_null(g_bxea_m.bxea008) AND (NOT cl_null(g_bxea_m.bxea016)) THEN
      LET l_oofa001 = ''
      SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '3' AND oofa003 = g_bxea_m.bxea008
      CALL s_aooi350_get_address(l_oofa001,g_bxea_m.bxea016,g_lang) RETURNING l_success,g_bxea_m.oofb017     
   END IF
   DISPLAY BY NAME g_bxea_m.oofb017         
   #end add-point
   
   #遮罩相關處理
   LET g_bxea_m_mask_o.* =  g_bxea_m.*
   CALL abxt400_bxea_t_mask()
   LET g_bxea_m_mask_n.* =  g_bxea_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bxea_m.bxeasite,g_bxea_m.bxeadocno,g_bxea_m.bxeadocno_desc,g_bxea_m.bxeadocdt,g_bxea_m.bxea001, 
       g_bxea_m.bxea002,g_bxea_m.bxea002_desc,g_bxea_m.bxea003,g_bxea_m.bxea003_desc,g_bxea_m.bxeastus, 
       g_bxea_m.bxea004,g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea008_desc, 
       g_bxea_m.bxea009,g_bxea_m.bxea010,g_bxea_m.bxea010_desc,g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013, 
       g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016,g_bxea_m.oofb017,g_bxea_m.bxea017,g_bxea_m.bxea018, 
       g_bxea_m.bxea019,g_bxea_m.bxea020,g_bxea_m.bxeaownid,g_bxea_m.bxeaownid_desc,g_bxea_m.bxeaowndp, 
       g_bxea_m.bxeaowndp_desc,g_bxea_m.bxeacrtid,g_bxea_m.bxeacrtid_desc,g_bxea_m.bxeacrtdp,g_bxea_m.bxeacrtdp_desc, 
       g_bxea_m.bxeacrtdt,g_bxea_m.bxeamodid,g_bxea_m.bxeamodid_desc,g_bxea_m.bxeamoddt,g_bxea_m.bxeacnfid, 
       g_bxea_m.bxeacnfid_desc,g_bxea_m.bxeacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bxea_m.bxeastus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "B"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/close_a_case.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_bxeb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL abxt400_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abxt400.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION abxt400_detail_show()
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
 
{<section id="abxt400.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abxt400_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE bxea_t.bxeadocno 
   DEFINE l_oldno     LIKE bxea_t.bxeadocno 
 
   DEFINE l_master    RECORD LIKE bxea_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bxeb_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_bxea_m.bxeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_bxeadocno_t = g_bxea_m.bxeadocno
 
    
   LET g_bxea_m.bxeadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bxea_m.bxeaownid = g_user
      LET g_bxea_m.bxeaowndp = g_dept
      LET g_bxea_m.bxeacrtid = g_user
      LET g_bxea_m.bxeacrtdp = g_dept 
      LET g_bxea_m.bxeacrtdt = cl_get_current()
      LET g_bxea_m.bxeamodid = g_user
      LET g_bxea_m.bxeamoddt = cl_get_current()
      LET g_bxea_m.bxeastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_bxea_m.bxeasite =g_site
   LET g_bxea_m.bxeadocdt =g_today
   LET g_bxea_m.bxea002 =g_user
   LET g_bxea_m.bxea003 =g_dept
   LET g_bxea_m.bxea001 = ''
   LET g_bxea_m.bxea014 = ''
   CALL s_desc_get_person_desc(g_bxea_m.bxea002) RETURNING g_bxea_m.bxea002_desc
   DISPLAY BY NAME g_bxea_m.bxea002_desc

   CALL s_desc_get_department_desc(g_bxea_m.bxea003) RETURNING g_bxea_m.bxea003_desc
   DISPLAY BY NAME g_bxea_m.bxea003_desc
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bxea_m.bxeastus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "B"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/close_a_case.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_bxea_m.bxeadocno_desc = ''
   DISPLAY BY NAME g_bxea_m.bxeadocno_desc
 
   
   CALL abxt400_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_bxea_m.* TO NULL
      INITIALIZE g_bxeb_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL abxt400_show()
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
   CALL abxt400_set_act_visible()   
   CALL abxt400_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bxeadocno_t = g_bxea_m.bxeadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " bxeaent = " ||g_enterprise|| " AND",
                      " bxeadocno = '", g_bxea_m.bxeadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abxt400_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL abxt400_idx_chk()
   
   LET g_data_owner = g_bxea_m.bxeaownid      
   LET g_data_dept  = g_bxea_m.bxeaowndp
   
   #功能已完成,通報訊息中心
   CALL abxt400_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="abxt400.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abxt400_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bxeb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abxt400_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bxeb_t
    WHERE bxebent = g_enterprise AND bxebdocno = g_bxeadocno_t
 
    INTO TEMP abxt400_detail
 
   #將key修正為調整後   
   UPDATE abxt400_detail 
      #更新key欄位
      SET bxebdocno = g_bxea_m.bxeadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO bxeb_t SELECT * FROM abxt400_detail
   
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
   DROP TABLE abxt400_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bxeadocno_t = g_bxea_m.bxeadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="abxt400.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abxt400_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_bxeb001       LIKE bxeb_t.bxeb001
   DEFINE  l_bxeb002       LIKE bxeb_t.bxeb002
   DEFINE  l_bxeb004       LIKE bxeb_t.bxeb004
   DEFINE  l_bxeb005       LIKE bxeb_t.bxeb005
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_bxea_m.bxeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN abxt400_cl USING g_enterprise,g_bxea_m.bxeadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abxt400_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abxt400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abxt400_master_referesh USING g_bxea_m.bxeadocno INTO g_bxea_m.bxeasite,g_bxea_m.bxeadocno, 
       g_bxea_m.bxeadocdt,g_bxea_m.bxea001,g_bxea_m.bxea002,g_bxea_m.bxea003,g_bxea_m.bxeastus,g_bxea_m.bxea004, 
       g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea009,g_bxea_m.bxea010, 
       g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013,g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016, 
       g_bxea_m.bxea017,g_bxea_m.bxea018,g_bxea_m.bxea019,g_bxea_m.bxea020,g_bxea_m.bxeaownid,g_bxea_m.bxeaowndp, 
       g_bxea_m.bxeacrtid,g_bxea_m.bxeacrtdp,g_bxea_m.bxeacrtdt,g_bxea_m.bxeamodid,g_bxea_m.bxeamoddt, 
       g_bxea_m.bxeacnfid,g_bxea_m.bxeacnfdt,g_bxea_m.bxea002_desc,g_bxea_m.bxea003_desc,g_bxea_m.bxea008_desc, 
       g_bxea_m.bxea010_desc,g_bxea_m.bxeaownid_desc,g_bxea_m.bxeaowndp_desc,g_bxea_m.bxeacrtid_desc, 
       g_bxea_m.bxeacrtdp_desc,g_bxea_m.bxeamodid_desc,g_bxea_m.bxeacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT abxt400_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bxea_m_mask_o.* =  g_bxea_m.*
   CALL abxt400_bxea_t_mask()
   LET g_bxea_m_mask_n.* =  g_bxea_m.*
   
   CALL abxt400_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abxt400_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_bxeadocno_t = g_bxea_m.bxeadocno
 
 
      DELETE FROM bxea_t
       WHERE bxeaent = g_enterprise AND bxeadocno = g_bxea_m.bxeadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_bxea_m.bxeadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_bxea_m.bxeadocno,g_bxea_m.bxeadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      DECLARE upd_xmdl CURSOR FOR
         SELECT bxeb001,bxeb002,bxeb004,bxeb005 FROM bxeb_t WHERE bxebent = g_enterprise AND bxebdocno = g_bxea_m.bxeadocno
      #單頭的「資料來源」= 2.出貨單時，單身異動時，更新出貨單單身欄位「放行狀態」
      IF g_bxea_m.bxea005 = '2' THEN 
         FOREACH upd_xmdl INTO l_bxeb001,l_bxeb002,l_bxeb004,l_bxeb005
            IF NOT s_abxt400_upd_xmdl(l_bxeb001,l_bxeb002,l_bxeb004,l_bxeb005,0,'d') THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF    
         END FOREACH
      END IF
      
      #資料來源=1.發料單時,更新bxda_t的已核銷數量及工單的保稅核銷否
      IF g_bxea_m.bxea005 = '1' THEN 
         FOREACH upd_xmdl INTO l_bxeb001,l_bxeb002,l_bxeb004,l_bxeb005
            IF NOT s_abxt400_upd_bxda(g_bxea_m.bxeadocno,l_bxeb001,l_bxeb002,'d') THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF    
         END FOREACH
      END IF
      #end add-point
      
      DELETE FROM bxeb_t
       WHERE bxebent = g_enterprise AND bxebdocno = g_bxea_m.bxeadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bxeb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_bxea_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE abxt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_bxeb_d.clear() 
 
     
      CALL abxt400_ui_browser_refresh()  
      #CALL abxt400_ui_headershow()  
      #CALL abxt400_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL abxt400_browser_fill("")
         CALL abxt400_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE abxt400_cl
 
   #功能已完成,通報訊息中心
   CALL abxt400_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abxt400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abxt400_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_bxeb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF abxt400_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT bxebsite,bxebseq,bxeb001,bxeb002,bxeb003,bxeb004,bxeb005,bxeb006, 
             bxeb007,bxeb008,bxeb009 ,t1.imaal003 ,t2.oocal003 ,t3.ooail003 FROM bxeb_t",   
                     " INNER JOIN bxea_t ON bxeaent = " ||g_enterprise|| " AND bxeadocno = bxebdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=bxeb003 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=bxeb004 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=bxeb006 AND t3.ooail002='"||g_dlang||"' ",
 
                     " WHERE bxebent=? AND bxebdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY bxeb_t.bxebseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abxt400_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abxt400_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bxea_m.bxeadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bxea_m.bxeadocno INTO g_bxeb_d[l_ac].bxebsite,g_bxeb_d[l_ac].bxebseq, 
          g_bxeb_d[l_ac].bxeb001,g_bxeb_d[l_ac].bxeb002,g_bxeb_d[l_ac].bxeb003,g_bxeb_d[l_ac].bxeb004, 
          g_bxeb_d[l_ac].bxeb005,g_bxeb_d[l_ac].bxeb006,g_bxeb_d[l_ac].bxeb007,g_bxeb_d[l_ac].bxeb008, 
          g_bxeb_d[l_ac].bxeb009,g_bxeb_d[l_ac].bxeb003_desc,g_bxeb_d[l_ac].bxeb004_desc,g_bxeb_d[l_ac].bxeb006_desc  
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
         CALL s_desc_get_item_desc(g_bxeb_d[l_ac].bxeb003) RETURNING g_bxeb_d[l_ac].bxeb003_desc,g_bxeb_d[l_ac].bxeb003_desc_1
            DISPLAY BY NAME g_bxeb_d[l_ac].bxeb003_desc,g_bxeb_d[l_ac].bxeb003_desc_1
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
   
   CALL g_bxeb_d.deleteElement(g_bxeb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE abxt400_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_bxeb_d.getLength()
      LET g_bxeb_d_mask_o[l_ac].* =  g_bxeb_d[l_ac].*
      CALL abxt400_bxeb_t_mask()
      LET g_bxeb_d_mask_n[l_ac].* =  g_bxeb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="abxt400.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abxt400_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM bxeb_t
       WHERE bxebent = g_enterprise AND
         bxebdocno = ps_keys_bak[1] AND bxebseq = ps_keys_bak[2]
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
         CALL g_bxeb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abxt400.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abxt400_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO bxeb_t
                  (bxebent,
                   bxebdocno,
                   bxebseq
                   ,bxebsite,bxeb001,bxeb002,bxeb003,bxeb004,bxeb005,bxeb006,bxeb007,bxeb008,bxeb009) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_bxeb_d[g_detail_idx].bxebsite,g_bxeb_d[g_detail_idx].bxeb001,g_bxeb_d[g_detail_idx].bxeb002, 
                       g_bxeb_d[g_detail_idx].bxeb003,g_bxeb_d[g_detail_idx].bxeb004,g_bxeb_d[g_detail_idx].bxeb005, 
                       g_bxeb_d[g_detail_idx].bxeb006,g_bxeb_d[g_detail_idx].bxeb007,g_bxeb_d[g_detail_idx].bxeb008, 
                       g_bxeb_d[g_detail_idx].bxeb009)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bxeb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_bxeb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="abxt400.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abxt400_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bxeb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL abxt400_bxeb_t_mask_restore('restore_mask_o')
               
      UPDATE bxeb_t 
         SET (bxebdocno,
              bxebseq
              ,bxebsite,bxeb001,bxeb002,bxeb003,bxeb004,bxeb005,bxeb006,bxeb007,bxeb008,bxeb009) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_bxeb_d[g_detail_idx].bxebsite,g_bxeb_d[g_detail_idx].bxeb001,g_bxeb_d[g_detail_idx].bxeb002, 
                  g_bxeb_d[g_detail_idx].bxeb003,g_bxeb_d[g_detail_idx].bxeb004,g_bxeb_d[g_detail_idx].bxeb005, 
                  g_bxeb_d[g_detail_idx].bxeb006,g_bxeb_d[g_detail_idx].bxeb007,g_bxeb_d[g_detail_idx].bxeb008, 
                  g_bxeb_d[g_detail_idx].bxeb009) 
         WHERE bxebent = g_enterprise AND bxebdocno = ps_keys_bak[1] AND bxebseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bxeb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bxeb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL abxt400_bxeb_t_mask_restore('restore_mask_n')
               
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
 
{<section id="abxt400.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION abxt400_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="abxt400.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abxt400_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="abxt400.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abxt400_lock_b(ps_table,ps_page)
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
   #CALL abxt400_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "bxeb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN abxt400_bcl USING g_enterprise,
                                       g_bxea_m.bxeadocno,g_bxeb_d[g_detail_idx].bxebseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abxt400_bcl:",SQLERRMESSAGE 
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
 
{<section id="abxt400.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abxt400_unlock_b(ps_table,ps_page)
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
      CLOSE abxt400_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="abxt400.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abxt400_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   DEFINE l_fields STRING
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("bxeadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bxeadocno",TRUE)
      CALL cl_set_comp_entry("bxeadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   #依單據別設定判斷欄位是否需要做輸入控制
   IF NOT cl_null(g_bxea_m.bxeadocno) THEN
      LET l_fields = ''
      CALL s_aooi200_get_doc_fields(g_site,'1',g_bxea_m.bxeadocno) RETURNING l_fields
      CALL cl_set_comp_entry(l_fields,TRUE)
   END IF
   
   CALL cl_set_comp_entry("bxea005,bxea006",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abxt400.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abxt400_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_fields STRING
   DEFINE l_n      LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bxeadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("bxeadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("bxeadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #依單據別設定判斷欄位是否需要做輸入控制
   IF NOT cl_null(g_bxea_m.bxeadocno) THEN
      LET l_fields = ''
      CALL s_aooi200_get_doc_fields(g_site,'1',g_bxea_m.bxeadocno) RETURNING l_fields
      CALL cl_set_comp_entry(l_fields,FALSE)
   END IF
   
   #若單身有維護資料，且有維護來源單號，則數據源欄位不可修改
   SELECT COUNT(1) INTO l_n FROM bxeb_t WHERE bxebent = g_enterprise AND bxebdocno = g_bxea_m.bxeadocno AND bxeb001 IS NOT NULL
   IF l_n > 0 THEN
      CALL cl_set_comp_entry("bxea005,bxea006",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abxt400.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abxt400_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("bxeb001,bxeb002,bxeb003,bxeb004",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="abxt400.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abxt400_set_no_entry_b(p_cmd)
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
   IF NOT cl_null(g_bxea_m.bxea006) THEN
      CALL cl_set_comp_entry("bxeb001",FALSE)
   END IF
   IF g_bxea_m.bxea005 = '6' THEN
      CALL cl_set_comp_entry("bxeb001,bxeb002",FALSE)
   END IF
   
   IF g_bxea_m.bxea005 <> '6' THEN
      CALL cl_set_comp_entry("bxeb003,bxeb004",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="abxt400.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abxt400_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("open_abxt400_02", TRUE)
   CALL cl_set_act_visible("regen_bxeb", TRUE)
   CALL cl_set_act_visible("reproduce", TRUE) 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abxt400.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abxt400_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:2)
   IF g_bxea_m.bxeastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
      CALL cl_set_act_visible("open_abxt400_02", FALSE)
      CALL cl_set_act_visible("regen_bxeb", FALSE)
   END IF

   #1.單頭「資料來源」= 2.出貨單，且「來源單號」= NULL時，才可點選
   IF g_bxea_m.bxea005 <> '2' OR NOT cl_null(g_bxea_m.bxea006) THEN
      CALL cl_set_act_visible("open_abxt400_02", FALSE)
   END IF
   
   IF cl_null(g_bxea_m.bxea006) THEN
      CALL cl_set_act_visible("regen_bxeb", FALSE)
   END IF
   
   #没有来源资料的情况下，才可以复制
   IF g_bxea_m.bxea005 <> '6' OR NOT cl_null(g_bxea_m.bxea006) THEN
      CALL cl_set_act_visible("reproduce", FALSE) 
   END IF
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abxt400.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abxt400_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abxt400.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abxt400_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abxt400.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abxt400_default_search()
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
      LET ls_wc = ls_wc, " bxeadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "bxea_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "bxeb_t" 
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
 
{<section id="abxt400.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION abxt400_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_state   LIKE type_t.chr5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_bxea_m.bxeastus = 'X' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_bxea_m.bxeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN abxt400_cl USING g_enterprise,g_bxea_m.bxeadocno
   IF STATUS THEN
      CLOSE abxt400_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abxt400_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE abxt400_master_referesh USING g_bxea_m.bxeadocno INTO g_bxea_m.bxeasite,g_bxea_m.bxeadocno, 
       g_bxea_m.bxeadocdt,g_bxea_m.bxea001,g_bxea_m.bxea002,g_bxea_m.bxea003,g_bxea_m.bxeastus,g_bxea_m.bxea004, 
       g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea009,g_bxea_m.bxea010, 
       g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013,g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016, 
       g_bxea_m.bxea017,g_bxea_m.bxea018,g_bxea_m.bxea019,g_bxea_m.bxea020,g_bxea_m.bxeaownid,g_bxea_m.bxeaowndp, 
       g_bxea_m.bxeacrtid,g_bxea_m.bxeacrtdp,g_bxea_m.bxeacrtdt,g_bxea_m.bxeamodid,g_bxea_m.bxeamoddt, 
       g_bxea_m.bxeacnfid,g_bxea_m.bxeacnfdt,g_bxea_m.bxea002_desc,g_bxea_m.bxea003_desc,g_bxea_m.bxea008_desc, 
       g_bxea_m.bxea010_desc,g_bxea_m.bxeaownid_desc,g_bxea_m.bxeaowndp_desc,g_bxea_m.bxeacrtid_desc, 
       g_bxea_m.bxeacrtdp_desc,g_bxea_m.bxeamodid_desc,g_bxea_m.bxeacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT abxt400_action_chk() THEN
      CLOSE abxt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bxea_m.bxeasite,g_bxea_m.bxeadocno,g_bxea_m.bxeadocno_desc,g_bxea_m.bxeadocdt,g_bxea_m.bxea001, 
       g_bxea_m.bxea002,g_bxea_m.bxea002_desc,g_bxea_m.bxea003,g_bxea_m.bxea003_desc,g_bxea_m.bxeastus, 
       g_bxea_m.bxea004,g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea008_desc, 
       g_bxea_m.bxea009,g_bxea_m.bxea010,g_bxea_m.bxea010_desc,g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013, 
       g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016,g_bxea_m.oofb017,g_bxea_m.bxea017,g_bxea_m.bxea018, 
       g_bxea_m.bxea019,g_bxea_m.bxea020,g_bxea_m.bxeaownid,g_bxea_m.bxeaownid_desc,g_bxea_m.bxeaowndp, 
       g_bxea_m.bxeaowndp_desc,g_bxea_m.bxeacrtid,g_bxea_m.bxeacrtid_desc,g_bxea_m.bxeacrtdp,g_bxea_m.bxeacrtdp_desc, 
       g_bxea_m.bxeacrtdt,g_bxea_m.bxeamodid,g_bxea_m.bxeamodid_desc,g_bxea_m.bxeamoddt,g_bxea_m.bxeacnfid, 
       g_bxea_m.bxeacnfid_desc,g_bxea_m.bxeacnfdt
 
   CASE g_bxea_m.bxeastus
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      WHEN "B"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/close_a_case.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_bxea_m.bxeastus
            
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
            WHEN "B"
               HIDE OPTION "close_a_case"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed,close_a_case,unclose_a_case",TRUE)
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      
      CASE g_bxea_m.bxeastus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,close_a_case,unclose_a_case",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
            
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,close_a_case,unclose_a_case",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,close_a_case,unclose_a_case",FALSE)
   

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,close_a_case,unclose_a_case",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,unclose_a_case",FALSE)
            
         WHEN "C"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,close_a_case,unclose_a_case",FALSE)

         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,close_a_case,unclose_a_case",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,close_a_case,unclose_a_case",FALSE)
             
         WHEN "B"   #銷案
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,close_a_case",FALSE)


      END CASE
      
      LET l_state = ''
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT abxt400_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE abxt400_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT abxt400_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE abxt400_cl
            RETURN
         END IF
 
 
 
	  
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
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
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
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION close_a_case
         IF cl_auth_chk_act("close_a_case") THEN
            LET lc_state = "B"
            #add-point:action控制 name="statechange.close_a_case"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      ON ACTION unclose_a_case
         IF cl_auth_chk_act("unnclose_a_case") THEN
            LET lc_state = "Y"
            LET l_state = "UB"
            #add-point:action控制 name="statechange.close_a_case"

            #end add-point
         END IF
         EXIT MENU
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "A" 
      AND lc_state <> "D"
      AND lc_state <> "N"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "Y"
      AND lc_state <> "X"
      AND lc_state <> "B"
      ) OR 
      g_bxea_m.bxeastus = lc_state OR cl_null(lc_state) THEN
      CLOSE abxt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   IF lc_state = 'Y' AND cl_null(l_state) THEN
      CALL s_abxt400_conf_chk(g_bxea_m.bxeadocno) RETURNING l_success
      IF NOT l_success THEN
         CLOSE abxt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CLOSE abxt400_cl
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_abxt400_conf_upd(g_bxea_m.bxeadocno) RETURNING l_success
            IF NOT l_success THEN
               CLOSE abxt400_cl  
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   IF lc_state = 'N' THEN
      CALL s_abxt400_unconf_chk(g_bxea_m.bxeadocno) RETURNING l_success
      IF NOT l_success THEN
         CLOSE abxt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            CLOSE abxt400_cl
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_abxt400_unconf_upd(g_bxea_m.bxeadocno) RETURNING l_success
            IF NOT l_success THEN
               CLOSE abxt400_cl  
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   IF lc_state = 'X' THEN
      CALL s_abxt400_invalid_chk(g_bxea_m.bxeadocno) RETURNING l_success
      IF NOT l_success THEN
         CLOSE abxt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CLOSE abxt400_cl
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_abxt400_invalid_upd(g_bxea_m.bxeadocno) RETURNING l_success
            IF NOT l_success THEN
               CLOSE abxt400_cl  
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   #銷案
   IF lc_state = 'B' THEN
      CALL s_abxt400_close_case_chk(g_bxea_m.bxeadocno) RETURNING l_success
      IF NOT l_success THEN
         CLOSE abxt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('abx-00051') THEN
            CLOSE abxt400_cl
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            IF NOT abxt400_upd_bxea014() THEN
               CLOSE abxt400_cl
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_abxt400_close_case_upd(g_bxea_m.bxeadocno) RETURNING l_success
               IF NOT l_success THEN
                  CLOSE abxt400_cl 
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
      END IF
   END IF
   #取消銷案
   IF l_state = 'UB' THEN
      CALL s_abxt400_unclose_case_chk(g_bxea_m.bxeadocno) RETURNING l_success
      IF NOT l_success THEN
         CLOSE abxt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('abx-00052') THEN
            CLOSE abxt400_cl
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_abxt400_unclose_case_upd(g_bxea_m.bxeadocno) RETURNING l_success
            IF NOT l_success THEN
               CLOSE abxt400_cl  
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   
   #因為取消銷案時，狀態碼應給'Y',而不是更新為'UB'
   SELECT bxeastus INTO lc_state FROM bxea_t WHERE bxeaent = g_enterprise AND bxeadocno = g_bxea_m.bxeadocno
   #end add-point
   
   LET g_bxea_m.bxeamodid = g_user
   LET g_bxea_m.bxeamoddt = cl_get_current()
   LET g_bxea_m.bxeastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE bxea_t 
      SET (bxeastus,bxeamodid,bxeamoddt) 
        = (g_bxea_m.bxeastus,g_bxea_m.bxeamodid,g_bxea_m.bxeamoddt)     
    WHERE bxeaent = g_enterprise AND bxeadocno = g_bxea_m.bxeadocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "B"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/close_a_case.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE abxt400_master_referesh USING g_bxea_m.bxeadocno INTO g_bxea_m.bxeasite,g_bxea_m.bxeadocno, 
          g_bxea_m.bxeadocdt,g_bxea_m.bxea001,g_bxea_m.bxea002,g_bxea_m.bxea003,g_bxea_m.bxeastus,g_bxea_m.bxea004, 
          g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea009,g_bxea_m.bxea010, 
          g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013,g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016, 
          g_bxea_m.bxea017,g_bxea_m.bxea018,g_bxea_m.bxea019,g_bxea_m.bxea020,g_bxea_m.bxeaownid,g_bxea_m.bxeaowndp, 
          g_bxea_m.bxeacrtid,g_bxea_m.bxeacrtdp,g_bxea_m.bxeacrtdt,g_bxea_m.bxeamodid,g_bxea_m.bxeamoddt, 
          g_bxea_m.bxeacnfid,g_bxea_m.bxeacnfdt,g_bxea_m.bxea002_desc,g_bxea_m.bxea003_desc,g_bxea_m.bxea008_desc, 
          g_bxea_m.bxea010_desc,g_bxea_m.bxeaownid_desc,g_bxea_m.bxeaowndp_desc,g_bxea_m.bxeacrtid_desc, 
          g_bxea_m.bxeacrtdp_desc,g_bxea_m.bxeamodid_desc,g_bxea_m.bxeacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_bxea_m.bxeasite,g_bxea_m.bxeadocno,g_bxea_m.bxeadocno_desc,g_bxea_m.bxeadocdt, 
          g_bxea_m.bxea001,g_bxea_m.bxea002,g_bxea_m.bxea002_desc,g_bxea_m.bxea003,g_bxea_m.bxea003_desc, 
          g_bxea_m.bxeastus,g_bxea_m.bxea004,g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008, 
          g_bxea_m.bxea008_desc,g_bxea_m.bxea009,g_bxea_m.bxea010,g_bxea_m.bxea010_desc,g_bxea_m.bxea011, 
          g_bxea_m.bxea012,g_bxea_m.bxea013,g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016,g_bxea_m.oofb017, 
          g_bxea_m.bxea017,g_bxea_m.bxea018,g_bxea_m.bxea019,g_bxea_m.bxea020,g_bxea_m.bxeaownid,g_bxea_m.bxeaownid_desc, 
          g_bxea_m.bxeaowndp,g_bxea_m.bxeaowndp_desc,g_bxea_m.bxeacrtid,g_bxea_m.bxeacrtid_desc,g_bxea_m.bxeacrtdp, 
          g_bxea_m.bxeacrtdp_desc,g_bxea_m.bxeacrtdt,g_bxea_m.bxeamodid,g_bxea_m.bxeamodid_desc,g_bxea_m.bxeamoddt, 
          g_bxea_m.bxeacnfid,g_bxea_m.bxeacnfid_desc,g_bxea_m.bxeacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE abxt400_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abxt400_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abxt400.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abxt400_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_bxeb_d.getLength() THEN
         LET g_detail_idx = g_bxeb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bxeb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bxeb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abxt400.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abxt400_b_fill2(pi_idx)
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
   
   CALL abxt400_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="abxt400.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abxt400_fill_chk(ps_idx)
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
 
{<section id="abxt400.status_show" >}
PRIVATE FUNCTION abxt400_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abxt400.mask_functions" >}
&include "erp/abx/abxt400_mask.4gl"
 
{</section>}
 
{<section id="abxt400.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION abxt400_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL abxt400_show()
   CALL abxt400_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_bxea_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_bxeb_d))
 
 
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
   #CALL abxt400_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL abxt400_ui_headershow()
   CALL abxt400_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION abxt400_draw_out()
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
   CALL abxt400_ui_headershow()  
   CALL abxt400_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="abxt400.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abxt400_set_pk_array()
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
   LET g_pk_array[1].values = g_bxea_m.bxeadocno
   LET g_pk_array[1].column = 'bxeadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abxt400.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="abxt400.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abxt400_msgcentre_notify(lc_state)
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
   CALL abxt400_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bxea_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abxt400.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION abxt400_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abxt400.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取得單據別設定的欄位預設值
# Memo...........: 需搭配單據別aooi200的設定
# Usage..........: CALL abxt400_get_col_default()
# Date & Author..: 2016/10/24 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION abxt400_get_col_default()
DEFINE l_oofa001    LIKE oofa_t.oofa001   
DEFINE l_success    LIKE type_t.num5

   LET g_bxea_m.bxeadocdt = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxeadocdt',g_bxea_m.bxeadocdt)
   LET g_bxea_m.bxea001 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea001',g_bxea_m.bxea001)
   LET g_bxea_m.bxea002 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea002',g_bxea_m.bxea002)
   LET g_bxea_m.bxea003 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea003',g_bxea_m.bxea003)
   LET g_bxea_m.bxea004 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea004',g_bxea_m.bxea004)
   LET g_bxea_m.bxea005 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea005',g_bxea_m.bxea005)
   LET g_bxea_m.bxea006 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea006',g_bxea_m.bxea006)
   LET g_bxea_m.bxea007 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea007',g_bxea_m.bxea007)
   LET g_bxea_m.bxea008 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea008',g_bxea_m.bxea008)
   LET g_bxea_m.bxea009 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea009',g_bxea_m.bxea009)
   LET g_bxea_m.bxea010 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea010',g_bxea_m.bxea010)
   LET g_bxea_m.bxea011 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea011',g_bxea_m.bxea011)
   LET g_bxea_m.bxea012 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea012',g_bxea_m.bxea012)
   LET g_bxea_m.bxea013 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea013',g_bxea_m.bxea013)
   LET g_bxea_m.bxea014 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea033',g_bxea_m.bxea014)
   LET g_bxea_m.bxea015 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea015',g_bxea_m.bxea015)
   LET g_bxea_m.bxea016 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea016',g_bxea_m.bxea016)
   LET g_bxea_m.bxea017 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea017',g_bxea_m.bxea017)
   LET g_bxea_m.bxea018 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea018',g_bxea_m.bxea018)
   LET g_bxea_m.bxea019 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea019',g_bxea_m.bxea019)
   LET g_bxea_m.bxea020 = s_aooi200_get_doc_default(g_site,'1',g_bxea_m.bxeadocno,'bxea020',g_bxea_m.bxea020)

   DISPLAY BY NAME g_bxea_m.bxea001,g_bxea_m.bxeadocdt,g_bxea_m.bxea002,g_bxea_m.bxea004, 
     g_bxea_m.bxea003,g_bxea_m.bxea005,g_bxea_m.bxea006,g_bxea_m.bxea007,g_bxea_m.bxea008, 
     g_bxea_m.bxea009,g_bxea_m.bxea010,g_bxea_m.bxea011,g_bxea_m.bxea012,g_bxea_m.bxea013, 
     g_bxea_m.bxea014,g_bxea_m.bxea015,g_bxea_m.bxea016,g_bxea_m.bxea017,g_bxea_m.bxea018,g_bxea_m.bxea019, 
     g_bxea_m.bxea020
     
   CALL s_desc_get_person_desc(g_bxea_m.bxea002) RETURNING g_bxea_m.bxea002_desc
   DISPLAY BY NAME g_bxea_m.bxea002_desc

   CALL s_desc_get_department_desc(g_bxea_m.bxea003) RETURNING g_bxea_m.bxea003_desc
   DISPLAY BY NAME g_bxea_m.bxea003_desc
        
   CALL s_desc_get_trading_partner_abbr_desc(g_bxea_m.bxea008) RETURNING g_bxea_m.bxea008_desc
   DISPLAY BY NAME g_bxea_m.bxea008_desc  
   
   CALL s_desc_get_acc_desc("1130",g_bxea_m.bxea010) RETURNING g_bxea_m.bxea010_desc
   DISPLAY BY NAME g_bxea_m.bxea010_desc  
   
   #呼叫地址組合應用元件
   IF NOT cl_null(g_bxea_m.bxea008) AND (NOT cl_null(g_bxea_m.bxea016)) THEN
      LET l_oofa001 = ''
      SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '3' AND oofa003 = g_bxea_m.bxea008
      CALL s_aooi350_get_address(l_oofa001,g_bxea_m.bxea016,g_lang) RETURNING l_success,g_bxea_m.oofb017
      DISPLAY BY NAME g_bxea_m.oofb017
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 來源單號的檢核
# Memo...........:
# Usage..........: CALL abxt400_bxea006_chk(p_bxea006)
#                  RETURNING r_success
# Date & Author..: 2016/10/27 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION abxt400_bxea006_chk(p_bxea006)
DEFINE p_bxea006    LIKE bxea_t.bxea006
DEFINE r_success    LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_oofa001    LIKE oofa_t.oofa001
DEFINE l_pmdt001    LIKE pmdt_t.pmdt001

    LET r_success = TRUE
    IF cl_null(g_bxea_m.bxea005) OR cl_null(p_bxea006) THEN
       RETURN r_success
    END IF

    CASE g_bxea_m.bxea005
       WHEN '1' #1.發料單時，須存在於已確認或已過帳的發料單
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
          
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = p_bxea006
           
          #呼叫檢查存在並帶值的library
          IF NOT cl_chk_exist("v_sfdacono") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
          
          #抓取sfdc_t第一筆工單單號預設給工單/訂單單號欄位，抓取工單的核准文號(sfaa037)預設給畫面上的核准文號，
          #再用工單單號串非作廢的採購單(用工單到採購單找，資料來源類型=4.工單，來源單號=工單單號)，抓取供應商並抓取供應商的主要出貨地址到後面欄位「到達地址」顯示
          #170207-00018#1    2017/02/09   By 08734 mark(S)
          #SELECT sfdc001 INTO g_bxea_m.bxea007 FROM sfdc_t
          #   WHERE sfdcent = g_enterprise AND sfdcdocno = p_bxea006 AND sfdc001 IS NOT NULL AND ROWNUM =1
          #   ORDER BY sfdcseq
          #170207-00018#1    2017/02/09   By 08734 mark(E)
          #170207-00018#1    2017/02/09   By 08734 add(S)
          SELECT A.sfdc001 INTO g_bxea_m.bxea007 FROM (SELECT sfdc001 FROM sfdc_t
             WHERE sfdcent = g_enterprise AND sfdcdocno = p_bxea006 AND sfdc001 IS NOT NULL
             ORDER BY sfdcseq) A
          WHERE  ROWNUM =1
          #170207-00018#1    2017/02/09   By 08734 add(E)
          IF NOT cl_null(g_bxea_m.bxea007) THEN
             SELECT sfaa037 INTO g_bxea_m.bxea009 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = g_bxea_m.bxea007
             
             SELECT pmdl004 INTO g_bxea_m.bxea008 FROM pmdl_t,pmdp_t
                WHERE pmdlent = pmdpent AND pmdldocno = pmdpdocno AND pmdlent = g_enterprise AND pmdp003 = g_bxea_m.bxea007 AND ROWNUM =1
                  AND pmdl007 = '4' AND pmdlstus = 'Y' 
             IF NOT cl_null(g_bxea_m.bxea008) THEN
                #主要出貨地址
                SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 ='3' AND oofa003 = g_bxea_m.bxea008
                SELECT oofb019 INTO g_bxea_m.bxea016 FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = l_oofa001 AND oofb008 = '3' AND oofb010 = 'Y'
                IF NOT cl_null(g_bxea_m.bxea016) THEN
                   CALL s_aooi350_get_address(l_oofa001,g_bxea_m.bxea016,g_lang) RETURNING l_success,g_bxea_m.oofb017
                END IF
             END IF
             DISPLAY BY NAME g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea009,g_bxea_m.bxea016,g_bxea_m.oofb017
          END IF
          
       WHEN '2' #2.出貨單時，須存在於已確認或已過帳的出貨單         
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
          
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = p_bxea006
           
          #呼叫檢查存在並帶值的library
          IF NOT cl_chk_exist("v_xmdkdocno_9") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
          
          #出貨單單頭的訂單單號、客戶編號及送貨地址
          SELECT xmdk006,xmdk007,xmdk021 INTO g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea016 FROM xmdk_t
             WHERE xmdkent = g_enterprise AND xmdkdocno = p_bxea006 
          IF NOT cl_null(g_bxea_m.bxea008) THEN
             #主要出貨地址
             SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 ='3' AND oofa003 = g_bxea_m.bxea008
             IF NOT cl_null(g_bxea_m.bxea016) THEN
                CALL s_aooi350_get_address(l_oofa001,g_bxea_m.bxea016,g_lang) RETURNING l_success,g_bxea_m.oofb017
             END IF
          END IF
          DISPLAY BY NAME g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea009,g_bxea_m.bxea016,g_bxea_m.oofb017
       WHEN '3' #3.進料驗退單時，須存在於已確認或已過帳的採購驗退單
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
          
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = p_bxea006
           
          #呼叫檢查存在並帶值的library
          IF NOT cl_chk_exist("v_pmdsdocno_14") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
          #抓取驗退單的採購供應商，並回抓採購單單頭的工單單號；用供應商抓取供應商的主要出貨地址
          #170207-00018#1    2017/02/09   By 08734 mark(S)
          #SELECT pmdt001 INTO l_pmdt001 FROM pmdt_t 
          #   WHERE pmdtent = g_enterprise AND pmdtdocno = p_bxea006 AND pmdt001 IS NOT NULL AND ROWNUM =1
          #   ORDER BY pmdtseq
          #170207-00018#1    2017/02/09   By 08734 mark(E) 
          #170207-00018#1    2017/02/09   By 08734 add(S)          
          SELECT B.pmdt001 INTO l_pmdt001 FROM (SELECT pmdt001  FROM pmdt_t 
             WHERE pmdtent = g_enterprise AND pmdtdocno = p_bxea006 AND pmdt001 IS NOT NULL 
             ORDER BY pmdtseq) B
          WHERE ROWNUM =1
          #170207-00018#1    2017/02/09   By 08734 add(E)
          IF NOT cl_null(l_pmdt001) THEN  
             SELECT pmdl008 INTO g_bxea_m.bxea007 FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = l_pmdt001 AND pmdl007 = '4'
             IF NOT cl_null(g_bxea_m.bxea007) THEN
                SELECT sfaa037 INTO g_bxea_m.bxea009 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = g_bxea_m.bxea007
             END IF
          END IF
          
          SELECT pmds007 INTO g_bxea_m.bxea008 FROM pmds_t
             WHERE pmdsent = g_enterprise AND pmdsdocno = g_bxea_m.bxea007
          IF NOT cl_null(g_bxea_m.bxea008) THEN
             #主要出貨地址
             SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 ='3' AND oofa003 = g_bxea_m.bxea008
             SELECT oofb019 INTO g_bxea_m.bxea016 FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = l_oofa001 AND oofb008 = '3' AND oofb010 = 'Y'
             IF NOT cl_null(g_bxea_m.bxea016) THEN
                CALL s_aooi350_get_address(l_oofa001,g_bxea_m.bxea016,g_lang) RETURNING l_success,g_bxea_m.oofb017
             END IF
          END IF
          DISPLAY BY NAME g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea009,g_bxea_m.bxea016,g_bxea_m.oofb017
       WHEN '4' #4.雜項發料單時，須存在於aint301已確認或已過帳資料         
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
          
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = p_bxea006
           
          #呼叫檢查存在並帶值的library
          IF NOT cl_chk_exist("v_inbadocno_8") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       WHEN '5' #5.倉退單時，須存在於已確認或已過帳的倉退單
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
          
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = p_bxea006
           
          #呼叫檢查存在並帶值的library
          IF NOT cl_chk_exist("v_pmdsdocno_15") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
          #抓取倉退單的採購供應商，並回抓採購單單頭的工單單號；用供應商抓取供應商的主要出貨地址
          #170207-00018#1    2017/02/09   By 08734 mark(S)
          #SELECT pmdt001 INTO l_pmdt001 FROM pmdt_t 
          #   WHERE pmdtent = g_enterprise AND pmdtdocno = p_bxea006 AND pmdt001 IS NOT NULL AND ROWNUM =1
          #   ORDER BY pmdtseq
          #170207-00018#1    2017/02/09   By 08734 mark(E)   
          #170207-00018#1    2017/02/09   By 08734 add(S)          
          SELECT B.pmdt001 INTO l_pmdt001 FROM (SELECT pmdt001  FROM pmdt_t 
             WHERE pmdtent = g_enterprise AND pmdtdocno = p_bxea006 AND pmdt001 IS NOT NULL 
             ORDER BY pmdtseq) B
          WHERE ROWNUM =1
          #170207-00018#1    2017/02/09   By 08734 add(E)
          IF NOT cl_null(l_pmdt001) THEN  
             SELECT pmdl008 INTO g_bxea_m.bxea007 FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = l_pmdt001 AND pmdl007 = '4'
             IF NOT cl_null(g_bxea_m.bxea007) THEN
                SELECT sfaa037 INTO g_bxea_m.bxea009 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = g_bxea_m.bxea007
             END IF
          END IF
          
          SELECT pmds007 INTO g_bxea_m.bxea008 FROM pmds_t
             WHERE pmdsent = g_enterprise AND pmdsdocno = g_bxea_m.bxea007
          IF NOT cl_null(g_bxea_m.bxea008) THEN
             #主要出貨地址
             SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 ='3' AND oofa003 = g_bxea_m.bxea008
             SELECT oofb019 INTO g_bxea_m.bxea016 FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = l_oofa001 AND oofb008 = '3' AND oofb010 = 'Y'
             IF NOT cl_null(g_bxea_m.bxea016) THEN
                CALL s_aooi350_get_address(l_oofa001,g_bxea_m.bxea016,g_lang) RETURNING l_success,g_bxea_m.oofb017
             END IF
          END IF
          DISPLAY BY NAME g_bxea_m.bxea007,g_bxea_m.bxea008,g_bxea_m.bxea009,g_bxea_m.bxea016,g_bxea_m.oofb017
    END CASE
    
    RETURN r_success
    
END FUNCTION

#
PRIVATE FUNCTION abxt400_bxea009_chk()
DEFINE r_success    LIKE type_t.num5
DEFINE l_sfaa010    LIKE sfaa_t.sfaa010
DEFINE l_sfaadocdt  LIKE sfaa_t.sfaadocdt
DEFINE l_sfaa012    LIKE sfaa_t.sfaa012
DEFINE l_sfaa013    LIKE sfaa_t.sfaa013
DEFINE l_bxda006    LIKE bxda_t.bxda006
DEFINE l_imaa006    LIKE imaa_t.imaa006
DEFINE l_oofa001    LIKE oofa_t.oofa001
DEFINE  l_n         LIKE type_t.num10
DEFINE l_success    LIKE type_t.num5

    LET r_success = TRUE
    
    IF cl_null(g_bxea_m.bxea005) OR cl_null(g_bxea_m.bxea007) OR cl_null(g_bxea_m.bxea009) THEN
       RETURN r_success
    END IF
    
    IF g_bxea_m.bxea005 = '1' THEN
       IF NOT cl_null(g_bxea_m.bxea007) THEN
          SELECT sfaa010,sfaadocdt,sfaa012,sfaa013 INTO l_sfaa010,l_sfaadocdt,l_sfaa012,l_sfaa013
             FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = g_bxea_m.bxea007
          IF NOT cl_null(l_sfaa010) AND NOT cl_null(l_sfaadocdt) THEN
             LET l_n = 0
             SELECT COUNT(1),SUM(bxda006-bxda007) INTO l_n,l_bxda006 FROM bxda_t 
             WHERE bxdaent = g_enterprise AND bxdasite = g_site AND bxda001 = g_bxea_m.bxea009 
               AND bxda002 = l_sfaa010 AND bxdastus = 'Y' 
               AND bxda004 <= l_sfaadocdt AND (bxda005 IS NULL OR bxda005 > l_sfaadocdt)
             IF l_n = 0 OR cl_null(l_n) THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = g_bxea_m.bxea009
                LET g_errparam.code   = 'abx-00042'
                LET g_errparam.popup  = TRUE 
                CALL cl_err() 
                LET r_success = FALSE
                RETURN r_success
             END IF 
             SELECT imaa006 INTO l_imaa006 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_sfaa010
             IF l_imaa006 <> l_sfaa013 THEN
                CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,l_sfaa012)
                   RETURNING l_success,l_sfaa012
             END IF
             IF l_sfaa012 > l_bxda006 THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = g_bxea_m.bxea009
                LET g_errparam.code   = 'abx-00043'
                LET g_errparam.popup  = TRUE 
                CALL cl_err() 
                LET r_success = FALSE
                RETURN r_success
             END IF
          END IF
       END IF
    END IF
    
    RETURN r_success
    
END FUNCTION

PRIVATE FUNCTION abxt400_set_required_b()
    
    IF g_bxea_m.bxea005 <> '6' THEN
       CALL cl_set_comp_required("bxeb001,bxeb002",TRUE)
    END IF
END FUNCTION

PRIVATE FUNCTION abxt400_set_no_required_b()

    CALL cl_set_comp_required("bxeb001,bxeb002",FALSE)
    
END FUNCTION

#来源项次检查
PRIVATE FUNCTION abxt400_bxeb002_chk()
DEFINE r_success   LIKE type_t.num5
DEFINE l_n         LIKE type_t.num5
DEFINE l_bxeb004_1 LIKE bxeb_t.bxeb004
DEFINE l_bxeb005_1 LIKE bxeb_t.bxeb005
DEFINE l_success   LIKE type_t.num5
DEFINE l_bxeb003   LIKE bxeb_t.bxeb003
DEFINE l_bxeb004   LIKE bxeb_t.bxeb004
DEFINE l_bxeb005   LIKE bxeb_t.bxeb005
DEFINE l_bxeb006   LIKE bxeb_t.bxeb006
DEFINE l_bxeb007   LIKE bxeb_t.bxeb007
DEFINE l_bxeb008   LIKE bxeb_t.bxeb008
DEFINE l_bxeb009   LIKE bxeb_t.bxeb009
DEFINE l_iman012   LIKE iman_t.iman012

   LET r_success = TRUE
   IF cl_null(g_bxeb_d[l_ac].bxeb001) OR cl_null(g_bxeb_d[l_ac].bxeb002) THEN
      RETURN r_success
   END IF     
   
   LET l_bxeb003 = ''
   LET l_bxeb004 = ''
   LET l_bxeb005 = ''
   LET l_bxeb006 = ''
   LET l_bxeb007 = ''
   LET l_bxeb008 = ''
   LET l_bxeb009 = ''
   
   #來源單號+來源項次都有值時，檢查在該筆申請單號內，不可重複
   LET l_n = 0
   SELECT COUNT(1) INTO l_n FROM bxeb_t 
       WHERE bxebent = g_enterprise AND bxebdocno = g_bxea_m.bxeadocno AND bxeb001 = g_bxeb_d[l_ac].bxeb001 AND bxeb002 = g_bxeb_d[l_ac].bxeb002
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_bxeb_d[l_ac].bxeb002
      LET g_errparam.code   = 'abx-00046'
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DECLARE bxeb_cs CURSOR FOR 
      SELECT bxeb004,SUM(bxeb005) FROM bxeb_t,bxea_t 
         WHERE bxeaent = bxebent AND bxeadocno = bxebdocno 
           AND bxebent = g_enterprise AND bxeb001 = g_bxeb_d[l_ac].bxeb001 AND bxeb002 = g_bxeb_d[l_ac].bxeb002
           AND (bxebdocno <> g_bxea_m.bxeadocno OR bxebseq <> g_bxeb_d[l_ac].bxebseq)
           AND bxeastus <> 'X'
         GROUP BY bxeb004

   LET l_n = 0
   CASE g_bxea_m.bxea005
   #1來源是1.發料單時，來源單號須存在於已確認或已過帳的發料單，來源單號+來源項次都有值時，
   #   抓取料號(sfdc004)、單位(sfdc006)、保稅否(iman012)、最近採購單價(imai021)、幣別(ooef016)，
   #   數量=實際數量(sfdc008)-已存在其他申請單數量(小心單位)，匯率=1，台幣金額=數量*單價*匯率
      WHEN '1'
         SELECT COUNT(1),sfdc004,sfdc006,SUM(sfdc008) INTO l_n,l_bxeb003,l_bxeb004,l_bxeb005 FROM sfdc_t 
            WHERE sfdcent = g_enterprise AND sfdcsite = g_site AND sfdcdocno = g_bxeb_d[l_ac].bxeb001 AND sfdcseq = g_bxeb_d[l_ac].bxeb002
            GROUP BY sfdc004,sfdc006
         IF l_n = 0 OR cl_null(l_n) THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = g_bxeb_d[l_ac].bxeb001
            LET g_errparam.code   = 'ain-00526'
            LET g_errparam.popup  = TRUE 
            CALL cl_err() 
            LET r_success = FALSE
            RETURN r_success
         END IF
         SELECT imai021 INTO l_bxeb007 FROM imai_t WHERE imaient = g_enterprise AND imaisite = g_site AND imai001 = l_bxeb003
         IF cl_null(l_bxeb007) THEN
            LET l_bxeb007 = 0
         END IF

         SELECT ooef016 INTO l_bxeb006 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
         LET l_bxeb008 = 1

   #2來源是2.出貨單時，須存在於已確認或已過帳的出貨單，來源單號+來源項次都有值時，
   #   抓取料號(xmdl008)、單位(xmdl021)、保稅否(iman012)、單價(xmdl024)、幣別(xmdk016)、匯率(xmdk017)，
   #   數量=計價數量(xmdl022)-已存在其他申請單數量(小心單位)，台幣金額=數量*單價*匯率
      WHEN '2'
         SELECT COUNT(1),xmdl008,xmdl021,SUM(xmdl022),xmdl024,xmdk016,xmdk017
              INTO l_n,l_bxeb003,l_bxeb004,l_bxeb005,l_bxeb007,l_bxeb006,l_bxeb008
            FROM xmdl_t,xmdk_t
            WHERE xmdlent = xmdkent AND xmdldocno = xmdkdocno
              AND xmdlent = g_enterprise AND xmdlsite = g_site AND xmdldocno = g_bxeb_d[l_ac].bxeb001 AND xmdlseq = g_bxeb_d[l_ac].bxeb002
            GROUP BY xmdl008,xmdl021,xmdl024,xmdk016,xmdk017
         IF l_n = 0 OR cl_null(l_n) THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = g_bxeb_d[l_ac].bxeb001
            LET g_errparam.code   = 'ain-00526'
            LET g_errparam.popup  = TRUE 
            CALL cl_err() 
            LET r_success = FALSE
            RETURN r_success
         END IF
         
   #3來源是3.進料驗退單時，須存在於已確認或已過帳的採購驗退單，來源單號+來源項次都有值時，
   #   抓取料號(pmdt006)、單位(pmdt023)、保稅否(iman012)、單價(pmdt036)、幣別(pmds037)、匯率(pmds038)，
   #   數量=計價數量(pmdt024)-已存在其他申請單數量(小心單位)，台幣金額=數量*單價*匯率
      WHEN '3'
         SELECT COUNT(1),pmdt006,pmdt023,SUM(pmdt024),pmdt036,pmds037,pmds038
              INTO l_n,l_bxeb003,l_bxeb004,l_bxeb005,l_bxeb007,l_bxeb006,l_bxeb008
            FROM pmds_t,pmdt_t
            WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno
              AND pmdtent = g_enterprise AND pmdtsite = g_site AND pmdtdocno = g_bxeb_d[l_ac].bxeb001 AND pmdtseq = g_bxeb_d[l_ac].bxeb002
            GROUP BY pmdt006,pmdt023,pmdt036,pmds037,pmds038
         IF l_n = 0 OR cl_null(l_n) THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = g_bxeb_d[l_ac].bxeb001
            LET g_errparam.code   = 'ain-00526'
            LET g_errparam.popup  = TRUE 
            CALL cl_err() 
            LET r_success = FALSE
            RETURN r_success
         END IF
        
   #4來源是4.雜項發料單時，須存在於aint301已確認或已過帳資料，來源單號+來源項次都有值時，
   #   抓取料號(inbb001)、單位(inbb010)、保稅否(iman012)、最近採購單價(imai021)、幣別(ooef016)，
   #   數量=實際數量(inbb012)-已存在其他申請單數量(小心單位)，匯率=1，台幣金額=數量*單價*匯率
      WHEN '4'
         SELECT COUNT(1),inbb001,inbb010,SUM(inbb012) INTO l_n,l_bxeb003,l_bxeb004,l_bxeb005 FROM sfdc_t 
            WHERE inbbent = g_enterprise AND inbbsite = g_site AND inbbdocno = g_bxeb_d[l_ac].bxeb001 AND inbbseq = g_bxeb_d[l_ac].bxeb002
            GROUP BY inbb001,inbb010
         IF l_n = 0 OR cl_null(l_n) THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = g_bxeb_d[l_ac].bxeb001
            LET g_errparam.code   = 'ain-00526'
            LET g_errparam.popup  = TRUE 
            CALL cl_err() 
            LET r_success = FALSE
            RETURN r_success
         END IF
         SELECT imai021 INTO l_bxeb007 FROM imai_t WHERE imaient = g_enterprise AND imaisite = g_site AND imai001 = l_bxeb003
         IF cl_null(l_bxeb007) THEN
            LET l_bxeb007 = 0
         END IF

         SELECT ooef016 INTO l_bxeb006 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
         LET l_bxeb008 = 1
   
   #5來源是5.倉退單時，檢查與資料抓取，都跟3.3來源為3.進料驗退單一樣
      WHEN '5'
         SELECT COUNT(1),pmdt006,pmdt023,SUM(pmdt024),pmdt036,pmds037,pmds038
              INTO l_n,l_bxeb003,l_bxeb004,l_bxeb005,l_bxeb007,l_bxeb006,l_bxeb008
            FROM pmds_t,pmdt_t
            WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno
              AND pmdtent = g_enterprise AND pmdtsite = g_site AND pmdtdocno = g_bxeb_d[l_ac].bxeb001 AND pmdtseq = g_bxeb_d[l_ac].bxeb002
            GROUP BY pmdt006,pmdt023,pmdt036,pmds037,pmds038
         IF l_n = 0 OR cl_null(l_n) THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = g_bxeb_d[l_ac].bxeb001
            LET g_errparam.code   = 'ain-00526'
            LET g_errparam.popup  = TRUE 
            CALL cl_err() 
            LET r_success = FALSE
            RETURN r_success
         END IF
         
   END CASE
      
   FOREACH bxeb_cs INTO l_bxeb004_1,l_bxeb005_1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      IF l_bxeb004_1 <> l_bxeb004 THEN
         CALL s_aooi250_convert_qty(l_bxeb003,l_bxeb004_1,l_bxeb004,l_bxeb005_1)
            RETURNING l_success,l_bxeb005_1
      END IF
      IF cl_null(l_bxeb005_1) THEN
         LET l_bxeb005_1 = 0
      END IF
      LET l_bxeb005 =  l_bxeb005 - l_bxeb005_1
   END FOREACH
   
   IF l_bxeb005 < = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_bxeb_d[l_ac].bxeb001
      LET g_errparam.code   = 'abx-00047'
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   SELECT iman012 INTO l_iman012 FROM iman_t WHERE imanent = g_enterprise AND imansite = g_site AND iman001 = l_bxeb003
   #單頭的「單身僅存保稅品否」有勾選時，料號若不為保稅品，則顯示錯誤
   IF g_bxea_m.bxea019 = 'Y' AND l_iman012 <> 'Y' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = l_bxeb003
      LET g_errparam.code   = 'abx-00048'
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET g_bxeb_d[l_ac].iman012 = l_iman012
   
   LET g_bxeb_d[l_ac].bxeb003 = l_bxeb003
   LET g_bxeb_d[l_ac].bxeb004 = l_bxeb004
   LET g_bxeb_d[l_ac].bxeb005 = l_bxeb005
   LET g_bxeb_d[l_ac].bxeb006 = l_bxeb006
   LET g_bxeb_d[l_ac].bxeb007 = l_bxeb007
   LET g_bxeb_d[l_ac].bxeb008 = l_bxeb008
   LET g_bxeb_d[l_ac].bxeb009 = l_bxeb009
   
   CALL s_aooi250_take_decimals(g_bxeb_d[l_ac].bxeb004,g_bxeb_d[l_ac].bxeb005)
        RETURNING l_success,g_bxeb_d[l_ac].bxeb005
    
   IF cl_null(g_bxeb_d[l_ac].bxeb007) THEN
      LET g_bxeb_d[l_ac].bxeb007 = 0
   END IF
   #呼叫幣別取位應用元件對單價作取位(依單頭幣別做取位基準)
   CALL s_curr_round(g_site,g_bxeb_d[l_ac].bxeb006,g_bxeb_d[l_ac].bxeb007,'1') RETURNING g_bxeb_d[l_ac].bxeb007
    
   LET g_bxeb_d[l_ac].bxeb009 = g_bxeb_d[l_ac].bxeb005 * g_bxeb_d[l_ac].bxeb007 * g_bxeb_d[l_ac].bxeb008
   #呼叫幣別取位應用元件對金額作取位(依單頭幣別做取位基準)
   CALL s_curr_round(g_site,g_bxeb_d[l_ac].bxeb006,g_bxeb_d[l_ac].bxeb009 ,'2') RETURNING g_bxeb_d[l_ac].bxeb009 

   RETURN r_success
   
END FUNCTION

#单头输入后，自动产生单身
PRIVATE FUNCTION abxt400_gen_bxeb()
DEFINE l_sql       STRING
DEFINE l_bxeb001   LIKE bxeb_t.bxeb001
DEFINE l_bxeb002   LIKE bxeb_t.bxeb002
DEFINE l_bxeb003   LIKE bxeb_t.bxeb003
DEFINE l_bxeb004   LIKE bxeb_t.bxeb004
DEFINE l_bxeb005   LIKE bxeb_t.bxeb005
DEFINE l_bxeb006   LIKE bxeb_t.bxeb006
DEFINE l_bxeb007   LIKE bxeb_t.bxeb007
DEFINE l_bxeb008   LIKE bxeb_t.bxeb008
DEFINE l_bxeb009   LIKE bxeb_t.bxeb009
DEFINE l_iman012   LIKE iman_t.iman012
DEFINE l_bxebseq   LIKE bxeb_t.bxebseq

    IF cl_null(g_bxea_m.bxea006) OR g_bxea_m.bxea005 = '6' THEN
       RETURN
    END IF

    #單頭的「單身僅存保稅品否」有勾選時，料號若不為保稅品，則顯示錯誤
    IF g_bxea_m.bxea019 = 'Y' THEN
       CASE g_bxea_m.bxea005
          WHEN '1'
             LET l_sql = " SELECT sfdcdocno,sfdcseq FROM sfdc_t,iman_t ",
                         "    WHERE sfdcent = imanent AND sfdc004 = iman001 AND imansite = '",g_site,"' AND iman012 ='Y' ",
                         "      AND sfdcent = ",g_enterprise," AND sfdcdocno = '",g_bxea_m.bxea006,"' "
          WHEN '2'
             LET l_sql = " SELECT xmdldocno,xmdlseq FROM xmdl_t,iman_t ",
                         "    WHERE xmdlent = imanent AND xmdl008 = iman001 AND imansite = '",g_site,"' AND iman012 ='Y' ",
                         "     AND xmdlent = ",g_enterprise," AND xmdldocno = '",g_bxea_m.bxea006,"' "
          WHEN '3'
             LET l_sql = " SELECT pmdtdocno,pmdtseq FROM pmdt_t ,iman_t",
                         "    WHERE pmdtent = imanent AND pmdt006 = iman001 AND imansite = '",g_site,"' AND iman012 ='Y' ",
                         "      AND pmdtent = ",g_enterprise," AND pmdtdocno = '",g_bxea_m.bxea006,"' "
          WHEN '4'
             LET l_sql = " SELECT inbbdocno,inbbseq FROM inbb_t,iman_t ",
                         "    WHERE inbbent = imanent AND inbb001 = iman001 AND imansite = '",g_site,"' AND iman012 ='Y' ",
                         "      AND inbbent = ",g_enterprise," AND inbbdocno = '",g_bxea_m.bxea006,"' "
          WHEN '5'
             LET l_sql = " SELECT pmdtdocno,pmdtseq FROM pmdt_t ,iman_t",
                         "    WHERE pmdtent = imanent AND pmdt006 = iman001 AND imansite = '",g_site,"' AND iman012 ='Y' ",
                         "      AND pmdtent = ",g_enterprise," AND pmdtdocno = '",g_bxea_m.bxea006,"' "
       END CASE
    ELSE
       CASE g_bxea_m.bxea005
          WHEN '1'
             LET l_sql = " SELECT sfdcdocno,sfdcseq FROM sfdc_t WHERE sfdcent = ",g_enterprise," AND sfdcdocno = '",g_bxea_m.bxea006,"' "
          WHEN '2'
             LET l_sql = " SELECT xmdldocno,xmdlseq FROM xmdl_t WHERE xmdlent = ",g_enterprise," AND xmdldocno = '",g_bxea_m.bxea006,"' "
          WHEN '3'
             LET l_sql = " SELECT pmdtdocno,pmdtseq FROM pmdt_t WHERE pmdtent = ",g_enterprise," AND pmdtdocno = '",g_bxea_m.bxea006,"' "
          WHEN '4'
             LET l_sql = " SELECT inbbdocno,inbbseq FROM inbb_t WHERE inbbent = ",g_enterprise," AND inbbdocno = '",g_bxea_m.bxea006,"' "
          WHEN '5'
             LET l_sql = " SELECT pmdtdocno,pmdtseq FROM pmdt_t WHERE pmdtent = ",g_enterprise," AND pmdtdocno = '",g_bxea_m.bxea006,"' "
       END CASE
    END IF
    
    PREPARE abxt400_gen_pre FROM l_sql
    DECLARE abxt400_gen_cs CURSOR FOR abxt400_gen_pre
    
    FOREACH abxt400_gen_cs INTO l_bxeb001,l_bxeb002
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
         
       CALL s_abxt400_get_bxeb(g_bxea_m.bxeadocno,g_bxea_m.bxea005,'',l_bxeb001,l_bxeb002) 
          RETURNING l_bxeb003,l_bxeb004,l_bxeb005,l_bxeb006,l_bxeb007,l_bxeb008,l_bxeb009,l_iman012
       IF l_bxeb005 = 0 THEN
          CONTINUE FOREACH
       END IF
       #項次加1
       SELECT MAX(bxebseq)+1 INTO l_bxebseq FROM bxeb_t
         WHERE bxebent = g_enterprise AND bxebdocno = g_bxea_m.bxeadocno
       IF cl_null(l_bxebseq) OR l_bxebseq = 0 THEN
          LET l_bxebseq = 1
       END IF
       
       INSERT INTO bxeb_t
                  (bxebent,bxebdocno,bxebseq,bxebsite,bxeb001,bxeb002,
                   bxeb003,bxeb004,bxeb005,bxeb006,bxeb007,bxeb008,bxeb009) 
            VALUES(g_enterprise,g_bxea_m.bxeadocno,l_bxebseq,g_site,
                   l_bxeb001,l_bxeb002,l_bxeb003,l_bxeb004,l_bxeb005, 
                   l_bxeb006,l_bxeb007,l_bxeb008,l_bxeb009)
       
       #單頭的「資料來源」= 2.出貨單時，單身異動時，更新出貨單單身欄位「放行狀態」
       IF g_bxea_m.bxea005 = '2' THEN 
          IF NOT s_abxt400_upd_xmdl(l_bxeb001,l_bxeb002,l_bxeb004,l_bxeb005,0,'a') THEN
             
          END IF
       END IF  
       #資料來源=1.發料單時,更新bxda_t的已核銷數量及工單的保稅核銷否
       IF g_bxea_m.bxea005 = '1' THEN 
          IF NOT s_abxt400_upd_bxda(g_bxea_m.bxeadocno,l_bxeb001,l_bxeb002,'a') THEN
             
          END IF
       END IF        
    END FOREACH
    
       
   
END FUNCTION

#銷案時，維護銷案日期
PRIVATE FUNCTION abxt400_upd_bxea014()
DEFINE r_success   LIKE type_t.num5
DEFINE l_bxeamoddt LIKE bxea_t.bxeamoddt
DEFINE l_sql       STRING

   LET r_success = TRUE
   
   IF g_bxea_m.bxeadocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CALL cl_set_comp_entry("bxea014",TRUE)
   
   LET g_bxea_m_t.* = g_bxea_m.*
   
   INPUT BY NAME g_bxea_m.bxea014 WITHOUT DEFAULTS
             
      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            LET r_success = FALSE
            RETURN r_success
         END IF

      AFTER FIELD bxea014
         

   END INPUT
   
   IF INT_FLAG OR g_bxea_m.bxea014 IS NULL THEN
      LET INT_FLAG = 0
      LET r_success = FALSE
      RETURN r_success
   END IF

   LET l_bxeamoddt = cl_get_current()

   UPDATE bxea_t SET bxea014 = g_bxea_m.bxea014,
                     bxeamodid = g_user,
                     bxeamoddt = l_bxeamoddt
     WHERE bxeaent = g_enterprise AND bxeadocno = g_bxea_m.bxeadocno

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "g_bxea_m"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success 
   END IF
   
   CALL cl_set_comp_entry("bxea014",FALSE)
   
   RETURN r_success
   
END FUNCTION

 
{</section>}
 
