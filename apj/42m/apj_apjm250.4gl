#該程式未解開Section, 採用最新樣板產出!
{<section id="apjm250.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-09-16 10:39:24), PR版次:0006(2016-09-05 19:14:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000321
#+ Filename...: apjm250
#+ Description: 專案活動
#+ Creator....: 02332(2014-02-20 10:39:24)
#+ Modifier...: 01996 -SD/PR- 05423
 
{</section>}
 
{<section id="apjm250.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#+ Modifier...:   No.160318-00025#31   2016/04/11  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160812-00017#1   2016/08/15 By 06137    在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160905-00007#3   2016/09/05 By zhujing  调整系统中无ENT的SQL条件增加ent
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
PRIVATE type type_g_pjba_m        RECORD
       pjba000 LIKE pjba_t.pjba000, 
   pjba000_desc LIKE type_t.chr80, 
   pjba001 LIKE pjba_t.pjba001, 
   pjba002 LIKE pjba_t.pjba002, 
   pjbal003 LIKE pjbal_t.pjbal003, 
   pjbal004 LIKE pjbal_t.pjbal004, 
   pjba009 LIKE pjba_t.pjba009, 
   pjba003 LIKE pjba_t.pjba003, 
   pjba003_desc LIKE type_t.chr80, 
   pjba004 LIKE pjba_t.pjba004, 
   pjba004_desc LIKE type_t.chr80, 
   pjba005 LIKE pjba_t.pjba005, 
   pjba006 LIKE pjba_t.pjba006, 
   pjba010 LIKE pjba_t.pjba010, 
   pjba010_desc LIKE type_t.chr80, 
   pjba011 LIKE pjba_t.pjba011, 
   pjba012 LIKE pjba_t.pjba012, 
   pjba012_desc LIKE type_t.chr80, 
   pjba013 LIKE pjba_t.pjba013, 
   pjba014 LIKE pjba_t.pjba014, 
   pjba014_desc LIKE type_t.chr80, 
   pjbastus LIKE pjba_t.pjbastus, 
   pjbaownid LIKE pjba_t.pjbaownid, 
   pjbaownid_desc LIKE type_t.chr80, 
   pjbaowndp LIKE pjba_t.pjbaowndp, 
   pjbaowndp_desc LIKE type_t.chr80, 
   pjbacrtid LIKE pjba_t.pjbacrtid, 
   pjbacrtid_desc LIKE type_t.chr80, 
   pjbacrtdp LIKE pjba_t.pjbacrtdp, 
   pjbacrtdp_desc LIKE type_t.chr80, 
   pjbacrtdt LIKE pjba_t.pjbacrtdt, 
   pjbamodid LIKE pjba_t.pjbamodid, 
   pjbamodid_desc LIKE type_t.chr80, 
   pjbamoddt LIKE pjba_t.pjbamoddt, 
   pjbacnfid LIKE pjba_t.pjbacnfid, 
   pjbacnfid_desc LIKE type_t.chr80, 
   pjbacnfdt LIKE pjba_t.pjbacnfdt, 
   date1 LIKE type_t.chr500, 
   pjbm019 LIKE pjbm_t.pjbm019, 
   pjbm021 LIKE pjbm_t.pjbm021, 
   pjbm023 LIKE pjbm_t.pjbm023, 
   date2 LIKE type_t.chr500, 
   pjbm020 LIKE pjbm_t.pjbm020, 
   pjbm022 LIKE pjbm_t.pjbm022, 
   pjbm024 LIKE pjbm_t.pjbm024, 
   pjbm025 LIKE pjbm_t.pjbm025, 
   pjbm026 LIKE pjbm_t.pjbm026, 
   pjbm027 LIKE pjbm_t.pjbm027, 
   pjbm028 LIKE pjbm_t.pjbm028, 
   pjbm028_desc LIKE type_t.chr80, 
   pjbm029 LIKE pjbm_t.pjbm029
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pjbm_d        RECORD
       pjbm002 LIKE pjbm_t.pjbm002, 
   pjbml004 LIKE pjbml_t.pjbml004, 
   pjbml005 LIKE pjbml_t.pjbml005, 
   pjbm003 LIKE pjbm_t.pjbm003, 
   pjbm003_desc LIKE type_t.chr500, 
   pjbm004 LIKE pjbm_t.pjbm004, 
   pjbm004_desc LIKE type_t.chr500, 
   pjbm005 LIKE pjbm_t.pjbm005, 
   pjbm005_desc LIKE type_t.chr500, 
   pjbm006 LIKE pjbm_t.pjbm006, 
   pjbm007 LIKE pjbm_t.pjbm007, 
   pjbm007_desc LIKE type_t.chr500, 
   pjbm008 LIKE pjbm_t.pjbm008, 
   pjbm009 LIKE pjbm_t.pjbm009, 
   pjbm009_desc LIKE type_t.chr500, 
   pjbm010 LIKE pjbm_t.pjbm010, 
   pjbm010_desc LIKE type_t.chr500, 
   pjbm011 LIKE pjbm_t.pjbm011, 
   pjbm011_desc LIKE type_t.chr500, 
   pjbm012 LIKE pjbm_t.pjbm012, 
   pjbm013 LIKE pjbm_t.pjbm013, 
   pjbm013_desc LIKE type_t.chr500, 
   pjbm014 LIKE pjbm_t.pjbm014, 
   pjbm014_desc LIKE type_t.chr500, 
   pjbm015 LIKE pjbm_t.pjbm015, 
   pjbm016 LIKE pjbm_t.pjbm016, 
   pjbm017 LIKE pjbm_t.pjbm017, 
   pjbm018 LIKE pjbm_t.pjbm018
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_pjba000 LIKE pjba_t.pjba000,
   b_pjba000_desc LIKE type_t.chr80,
      b_pjba001 LIKE pjba_t.pjba001
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_err                 STRING
#end add-point
       
#模組變數(Module Variables)
DEFINE g_pjba_m          type_g_pjba_m
DEFINE g_pjba_m_t        type_g_pjba_m
DEFINE g_pjba_m_o        type_g_pjba_m
DEFINE g_pjba_m_mask_o   type_g_pjba_m #轉換遮罩前資料
DEFINE g_pjba_m_mask_n   type_g_pjba_m #轉換遮罩後資料
 
   DEFINE g_pjba001_t LIKE pjba_t.pjba001
 
 
DEFINE g_pjbm_d          DYNAMIC ARRAY OF type_g_pjbm_d
DEFINE g_pjbm_d_t        type_g_pjbm_d
DEFINE g_pjbm_d_o        type_g_pjbm_d
DEFINE g_pjbm_d_mask_o   DYNAMIC ARRAY OF type_g_pjbm_d #轉換遮罩前資料
DEFINE g_pjbm_d_mask_n   DYNAMIC ARRAY OF type_g_pjbm_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      pjbal001 LIKE pjbal_t.pjbal001,
      pjbal003 LIKE pjbal_t.pjbal003,
      pjbal004 LIKE pjbal_t.pjbal004
      END RECORD
DEFINE g_detail_multi_table_t    RECORD
      pjbml001 LIKE pjbml_t.pjbml001,
      pjbml002 LIKE pjbml_t.pjbml002,
      pjbml003 LIKE pjbml_t.pjbml003,
      pjbml004 LIKE pjbml_t.pjbml004,
      pjbml005 LIKE pjbml_t.pjbml005
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
 
{<section id="apjm250.main" >}
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
   CALL cl_ap_init("apj","")
 
   #add-point:作業初始化 name="main.init"
                           
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
                           
   #end add-point
   LET g_forupd_sql = " SELECT pjba000,'',pjba001,pjba002,'','',pjba009,pjba003,'',pjba004,'',pjba005, 
       pjba006,pjba010,'',pjba011,pjba012,'',pjba013,pjba014,'',pjbastus,pjbaownid,'',pjbaowndp,'',pjbacrtid, 
       '',pjbacrtdp,'',pjbacrtdt,pjbamodid,'',pjbamoddt,pjbacnfid,'',pjbacnfdt,'','','','','','','', 
       '','','','','','',''", 
                      " FROM pjba_t",
                      " WHERE pjbaent= ? AND pjba001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
                           
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apjm250_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pjba000,t0.pjba001,t0.pjba002,t0.pjba009,t0.pjba003,t0.pjba004,t0.pjba005, 
       t0.pjba006,t0.pjba010,t0.pjba011,t0.pjba012,t0.pjba013,t0.pjba014,t0.pjbastus,t0.pjbaownid,t0.pjbaowndp, 
       t0.pjbacrtid,t0.pjbacrtdp,t0.pjbacrtdt,t0.pjbamodid,t0.pjbamoddt,t0.pjbacnfid,t0.pjbacnfdt,t1.pjaal003 , 
       t2.pjbal003 ,t3.ooail003 ,t4.oocql004 ,t5.ooag011 ,t6.oocql004 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 , 
       t10.ooefl003 ,t11.ooag011 ,t12.ooag011",
               " FROM pjba_t t0",
                              " LEFT JOIN pjaal_t t1 ON t1.pjaalent="||g_enterprise||" AND t1.pjaal001=t0.pjba000 AND t1.pjaal002='"||g_dlang||"' ",
               " LEFT JOIN pjbal_t t2 ON t2.pjbalent="||g_enterprise||" AND t2.pjbal001=t0.pjba003 AND t2.pjbal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=t0.pjba004 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='8006' AND t4.oocql002=t0.pjba010 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.pjba012  ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='8007' AND t6.oocql002=t0.pjba014 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.pjbaownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.pjbaowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.pjbacrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.pjbacrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.pjbamodid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.pjbacnfid  ",
 
               " WHERE t0.pjbaent = " ||g_enterprise|| " AND t0.pjba001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apjm250_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
                                                      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apjm250 WITH FORM cl_ap_formpath("apj",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apjm250_init()   
 
      #進入選單 Menu (="N")
      CALL apjm250_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
                                                      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apjm250
      
   END IF 
   
   CLOSE apjm250_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
                           
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apjm250.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apjm250_init()
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
      CALL cl_set_combo_scc_part('pjbastus','50','N,Y,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
                              CALL cl_set_combo_scc('pjbm029','16003')
   CALL cl_set_combo_scc('pjbm006','16002')
   #end add-point
   
   #初始化搜尋條件
   CALL apjm250_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apjm250.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apjm250_ui_dialog()
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
               DEFINE l_n     LIKE type_t.num5
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
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
                           
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_pjba_m.* TO NULL
         CALL g_pjbm_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apjm250_init()
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
               
               CALL apjm250_fetch('') # reload data
               LET l_ac = 1
               CALL apjm250_ui_detailshow() #Setting the current row 
         
               CALL apjm250_idx_chk()
               #NEXT FIELD pjbm002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_pjbm_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apjm250_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
                                                                                          DISPLAY g_pjbm_d[l_ac].pjbm017 TO FORMONLY.date1
               DISPLAY g_pjbm_d[l_ac].pjbm018 TO FORMONLY.date2
               CALL apjm250_pjbm(l_ac)
               #add by xujing 20151028
               CALL apjm250_set_act_visible_b()
               CALL apjm250_set_act_no_visible_b()
               #add by xujing 20151028
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
               CALL apjm250_idx_chk()
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
            CALL apjm250_browser_fill("")
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
               CALL apjm250_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apjm250_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL apjm250_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
                                                                                                            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL apjm250_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL apjm250_set_act_visible()   
            CALL apjm250_set_act_no_visible()
            IF NOT (g_pjba_m.pjba001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " pjbaent = " ||g_enterprise|| " AND",
                                  " pjba001 = '", g_pjba_m.pjba001, "' "
 
               #填到對應位置
               CALL apjm250_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "pjba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pjbm_t" 
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
               CALL apjm250_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "pjba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pjbm_t" 
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
                  CALL apjm250_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apjm250_fetch("F")
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
               CALL apjm250_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apjm250_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjm250_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apjm250_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjm250_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apjm250_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjm250_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apjm250_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjm250_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apjm250_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjm250_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_pjbm_d)
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
               NEXT FIELD pjbm002
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
         ON ACTION check_correct
            LET g_action_choice="check_correct"
            IF cl_auth_chk_act("check_correct") THEN
               
               #add-point:ON ACTION check_correct name="menu.check_correct"
                                                                                                                                                      IF l_ac > 0 THEN               
                  CALL s_apjm250_chk_data(g_pjba_m.pjba001) RETURNING g_success,g_errno,g_err
                  IF NOT g_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_err
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "axm-00083"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "axm-00090"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apjm250_modify()
               #add-point:ON ACTION modify name="menu.modify"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apjm250_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION upd_invalid
            LET g_action_choice="upd_invalid"
            IF cl_auth_chk_act("upd_invalid") THEN
               
               #add-point:ON ACTION upd_invalid name="menu.upd_invalid"
                                                                                                         IF l_ac>0 THEN
                  CALL apjm250_pjbm029()
                  IF g_pjba_m.pjbm029 !='0' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apj-00016"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  ELSE
                     IF cl_ask_confirm('apj-00023') THEN
                        CALL s_apjm250_upd_status_9(g_pjba_m.pjba001,g_pjbm_d[l_ac].pjbm002,g_pjba_m.pjbm029) RETURNING g_success,g_errno
                        IF NOT g_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                        ELSE
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "axm-00084"
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                        END IF
                     END IF
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "axm-00090"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
               CALL apjm250_show()  #add by xujing 20151023
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION upd_unfreeze
            LET g_action_choice="upd_unfreeze"
            IF cl_auth_chk_act("upd_unfreeze") THEN
               
               #add-point:ON ACTION upd_unfreeze name="menu.upd_unfreeze"
                                                                                                         IF l_ac>0 THEN
                  CALL apjm250_pjbm029()
                  IF g_pjba_m.pjbm029 !='2' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apj-00018"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  ELSE
                     IF cl_ask_confirm('apj-00021') THEN
                        CALL s_apjm250_upd_status_1(g_pjba_m.pjba001,g_pjbm_d[l_ac].pjbm002,g_pjba_m.pjbm029) RETURNING g_success,g_errno
                        IF NOT g_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                        ELSE
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "axm-00084"
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                        END IF
                     END IF                        
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "axm-00090"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
               CALL apjm250_show() #add by xujing 20151023
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apjm250_query()
               #add-point:ON ACTION query name="menu.query"
                                                                                                                                       
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION upd_freeze
            LET g_action_choice="upd_freeze"
            IF cl_auth_chk_act("upd_freeze") THEN
               
               #add-point:ON ACTION upd_freeze name="menu.upd_freeze"
                                                                                                         IF l_ac>0 THEN
                  CALL apjm250_pjbm029()
                  IF g_pjba_m.pjbm029 != '1' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apj-00017"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  ELSE
                     IF cl_ask_confirm('apj-00024') THEN
                        CALL s_apjm250_upd_status_2(g_pjba_m.pjba001,g_pjbm_d[l_ac].pjbm002,g_pjba_m.pjbm029) RETURNING g_success,g_errno
                        IF NOT g_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                        ELSE
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "axm-00084"
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                        END IF
                     END IF
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "axm-00090"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
               CALL apjm250_show() #add by xujing 20151023
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION upd_unconfirm
            LET g_action_choice="upd_unconfirm"
            IF cl_auth_chk_act("upd_unconfirm") THEN
               
               #add-point:ON ACTION upd_unconfirm name="menu.upd_unconfirm"
                                                                                                         IF l_ac>0 THEN
                  CALL apjm250_pjbm029()
                  IF g_pjba_m.pjbm029 !='1' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apj-00017"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  ELSE
                     IF cl_ask_confirm('apj-00022') THEN
                        CALL s_apjm250_upd_status_0(g_pjba_m.pjba001,g_pjbm_d[l_ac].pjbm002,g_pjba_m.pjbm029) RETURNING g_success,g_errno
                        IF NOT g_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                        ELSE
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "axm-00084"
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                        END IF
                     END IF
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "axm-00090"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
               CALL apjm250_show() #add by xujing 20151023
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION upd_confirm
            LET g_action_choice="upd_confirm"
            IF cl_auth_chk_act("upd_confirm") THEN
               
               #add-point:ON ACTION upd_confirm name="menu.upd_confirm"
                                                                           IF l_ac>0 THEN
                  LET l_n = 0
                  IF NOT cl_null(g_pjbm_d[l_ac].pjbm005) THEN
                     SELECT COUNT(*) INTO l_n 
                       FROM pjbm_t 
                      WHERE pjbm001=g_pjba_m.pjba001 AND pjbment = g_enterprise
                        AND pjbm002 = g_pjbm_d[l_ac].pjbm005
                     IF cl_null(l_n) THEN LET l_n = 0 END IF
                     IF l_n = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "sub-00417"
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        EXIT DIALOG
                     END IF
                  END IF
                  LET l_n = 0
                  IF NOT cl_null(g_pjbm_d[l_ac].pjbm007) THEN
                     SELECT COUNT(*) INTO l_n 
                       FROM pjbm_t 
                      WHERE pjbm001=g_pjba_m.pjba001 AND pjbment = g_enterprise
                        AND pjbm002 = g_pjbm_d[l_ac].pjbm007
                     IF cl_null(l_n) THEN LET l_n = 0 END IF
                     IF l_n = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "sub-00390"
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        EXIT DIALOG
                     END IF
                  END IF
                  CALL apjm250_pjbm029()
                  IF g_pjba_m.pjbm029 !='0' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apj-00016"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  ELSE
                     IF cl_ask_confirm('apj-00025') THEN
                        CALL s_apjm250_upd_status_1(g_pjba_m.pjba001,g_pjbm_d[l_ac].pjbm002,g_pjba_m.pjbm029) RETURNING g_success,g_errno
                        IF NOT g_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                        ELSE
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "axm-00084"
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                        END IF
                     END IF
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "axm-00090"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
               CALL apjm250_show() #add by xujing 20151023
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION upd_uninvalid
            LET g_action_choice="upd_uninvalid"
            IF cl_auth_chk_act("upd_uninvalid") THEN
               
               #add-point:ON ACTION upd_uninvalid name="menu.upd_uninvalid"
                                                                                                         IF l_ac>0 THEN
                  CALL apjm250_pjbm029()
                  IF g_pjba_m.pjbm029 !='9' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apj-00019"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  ELSE
                     IF cl_ask_confirm('apj-00020') THEN
                        CALL s_apjm250_upd_status_0(g_pjba_m.pjba001,g_pjbm_d[l_ac].pjbm002,g_pjba_m.pjbm029) RETURNING g_success,g_errno
                        IF NOT g_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                        ELSE
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "axm-00084"
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                        END IF
                     END IF
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "axm-00090"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
               CALL apjm250_show() #add by xujing 20151023
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apjm250_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apjm250_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apjm250_set_pk_array()
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
 
{<section id="apjm250.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apjm250_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
                              DEFINE l_n               LIKE type_t.num5
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
      LET l_sub_sql = " SELECT DISTINCT pjba001 ",
                      " FROM pjba_t ",
                      " ",
                      " LEFT JOIN pjbm_t ON pjbment = pjbaent AND pjba001 = pjbm001 ", "  ",
                      #add-point:browser_fill段sql(pjbm_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " LEFT JOIN pjbal_t ON pjbalent = "||g_enterprise||" AND pjba001 = pjbal001 AND pjbal002 = '",g_dlang,"' ", 
                      " LEFT JOIN pjbml_t ON pjbmlent = "||g_enterprise||" AND pjba001 = pjbml001 AND pjbm002 = pjbml002 AND pjbml003 = '",g_dlang,"' ", 
 
 
                      " WHERE pjbaent = " ||g_enterprise|| " AND pjbment = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pjba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pjba001 ",
                      " FROM pjba_t ", 
                      "  ",
                      "  LEFT JOIN pjbal_t ON pjbalent = "||g_enterprise||" AND pjba001 = pjbal001 AND pjbal002 = '",g_dlang,"' ",
                      " WHERE pjbaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pjba_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
                              IF g_wc2 = " 1=1" THEN
      LET l_n = 0
      LET l_n = l_wc.getIndexOf('pjbm',1)
      IF l_n > 0 THEN
         LET l_sub_sql =  " SELECT UNIQUE pjba001 ",
                            " FROM pjba_t ",
                              " ",
                              " LEFT JOIN pjbm_t ON pjbment = pjbaent AND pjba001 = pjbm001 ",
                              " LEFT JOIN pjbal_t ON pjba001 = pjbal001 AND pjbal002 = '",g_lang,"' ", 
                              " LEFT JOIN pjbml_t ON pjba001 = pjbml001 AND pjbm002 = pjbml002 AND pjbml003 = '",g_lang,"' ", 
                       " WHERE pjbaent = '" ||g_enterprise|| "' AND pjbment = '" ||g_enterprise|| "' AND ",l_wc
         LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
      END IF
   END IF      
 
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
      INITIALIZE g_pjba_m.* TO NULL
      CALL g_pjbm_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pjba000,t0.pjba001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pjbastus,t0.pjba000,t0.pjba001,t1.pjaal003 ",
                  " FROM pjba_t t0",
                  "  ",
                  "  LEFT JOIN pjbm_t ON pjbment = pjbaent AND pjba001 = pjbm001 ", "  ", 
                  #add-point:browser_fill段sql(pjbm_t1) name="browser_fill.join.pjbm_t1"
                  
                  #end add-point
 
 
                  " LEFT JOIN pjbml_t ON pjbmlent = "||g_enterprise||" AND pjba001 = pjbml001 AND pjbm002 = pjbml002 AND pjbml003 = '",g_dlang,"' ", 
 
 
                                 " LEFT JOIN pjaal_t t1 ON t1.pjaalent="||g_enterprise||" AND t1.pjaal001=t0.pjba000 AND t1.pjaal002='"||g_dlang||"' ",
 
               " LEFT JOIN pjbal_t ON pjbalent = "||g_enterprise||" AND pjba001 = pjbal001 AND pjbal002 = '",g_dlang,"' ",
                  " WHERE t0.pjbaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("pjba_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pjbastus,t0.pjba000,t0.pjba001,t1.pjaal003 ",
                  " FROM pjba_t t0",
                  "  ",
                                 " LEFT JOIN pjaal_t t1 ON t1.pjaalent="||g_enterprise||" AND t1.pjaal001=t0.pjba000 AND t1.pjaal002='"||g_dlang||"' ",
 
               " LEFT JOIN pjbal_t ON pjbalent = "||g_enterprise||" AND pjba001 = pjbal001 AND pjbal002 = '",g_dlang,"' ",
                  " WHERE t0.pjbaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("pjba_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY pjba001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
                              IF g_wc2 = " 1=1" THEN
      LET l_n = 0
      LET l_n = g_wc.getIndexOf('pjbm',1)
      IF l_n > 0 THEN
         LET l_sql_rank = "SELECT DISTINCT pjbastus,pjba000,'',pjba001,t1.pjaal003 DENSE_RANK() OVER(ORDER BY pjba001 ", 
          g_order,") AS RANK ",
                        " FROM pjba_t ",
                              " ",
                              " LEFT JOIN pjbm_t ON pjbment = pjbaent AND pjba001 = pjbm001 ",
 
 
                              " LEFT JOIN pjbal_t ON pjba001 = pjbal001 AND pjbal002 = '",g_lang,"' ",
                              " LEFT JOIN pjbml_t ON pjba001 = pjbml001 AND pjbm002 = pjbml002 AND pjbml003 = '",g_lang,"' ",
                              " LEFT JOIN pjaal_t t1 ON t1.pjaalent='"||g_enterprise||"' AND t1.pjaal001=pjba000 AND t1.pjaal002='"||g_lang||"' ",
                       " ",
                       " WHERE pjbaent = '" ||g_enterprise|| "' AND ",g_wc
#        LET g_sql= "SELECT pjbastus,pjba000,'',pjba001 FROM (",l_sql_rank,") WHERE ",
#             " RANK >= ",1," AND RANK<",1+g_max_browse,
#             " ORDER BY ",l_searchcol," ",g_order
         LET g_sql = l_sql_rank
      END IF
   END IF
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"pjba_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
                           
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pjba000,g_browser[g_cnt].b_pjba001, 
          g_browser[g_cnt].b_pjba000_desc
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
         CALL apjm250_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/valid.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/void.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_pjba001) THEN
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
 
{<section id="apjm250.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apjm250_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
                           
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pjba_m.pjba001 = g_browser[g_current_idx].b_pjba001   
 
   EXECUTE apjm250_master_referesh USING g_pjba_m.pjba001 INTO g_pjba_m.pjba000,g_pjba_m.pjba001,g_pjba_m.pjba002, 
       g_pjba_m.pjba009,g_pjba_m.pjba003,g_pjba_m.pjba004,g_pjba_m.pjba005,g_pjba_m.pjba006,g_pjba_m.pjba010, 
       g_pjba_m.pjba011,g_pjba_m.pjba012,g_pjba_m.pjba013,g_pjba_m.pjba014,g_pjba_m.pjbastus,g_pjba_m.pjbaownid, 
       g_pjba_m.pjbaowndp,g_pjba_m.pjbacrtid,g_pjba_m.pjbacrtdp,g_pjba_m.pjbacrtdt,g_pjba_m.pjbamodid, 
       g_pjba_m.pjbamoddt,g_pjba_m.pjbacnfid,g_pjba_m.pjbacnfdt,g_pjba_m.pjba000_desc,g_pjba_m.pjba003_desc, 
       g_pjba_m.pjba004_desc,g_pjba_m.pjba010_desc,g_pjba_m.pjba012_desc,g_pjba_m.pjba014_desc,g_pjba_m.pjbaownid_desc, 
       g_pjba_m.pjbaowndp_desc,g_pjba_m.pjbacrtid_desc,g_pjba_m.pjbacrtdp_desc,g_pjba_m.pjbamodid_desc, 
       g_pjba_m.pjbacnfid_desc
   
   CALL apjm250_pjba_t_mask()
   CALL apjm250_show()
      
END FUNCTION
 
{</section>}
 
{<section id="apjm250.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apjm250_ui_detailshow()
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
 
{<section id="apjm250.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apjm250_ui_browser_refresh()
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
      IF g_browser[l_i].b_pjba001 = g_pjba_m.pjba001 
 
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
 
{<section id="apjm250.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apjm250_construct()
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
   INITIALIZE g_pjba_m.* TO NULL
   CALL g_pjbm_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON pjba000,pjba001,pjba002,pjbal003,pjbal004,pjba009,pjba003,pjba004,pjba005, 
          pjba006,pjba010,pjba011,pjba012,pjba013,pjba014,pjbastus,pjbaownid,pjbaowndp,pjbacrtid,pjbacrtdp, 
          pjbacrtdt,pjbamodid,pjbamoddt,pjbacnfid,pjbacnfdt,pjbm019,pjbm021,pjbm023,pjbm020,pjbm022, 
          pjbm024,pjbm025,pjbm026,pjbm027,pjbm028,pjbm029
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                                                                                                            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pjbacrtdt>>----
         AFTER FIELD pjbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pjbamoddt>>----
         AFTER FIELD pjbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pjbacnfdt>>----
         AFTER FIELD pjbacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pjbapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.pjba000
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba000
            #add-point:ON ACTION controlp INFIELD pjba000 name="construct.c.pjba000"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pjaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjba000  #顯示到畫面上

            NEXT FIELD pjba000                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba000
            #add-point:BEFORE FIELD pjba000 name="construct.b.pjba000"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba000
            
            #add-point:AFTER FIELD pjba000 name="construct.a.pjba000"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba001
            #add-point:ON ACTION controlp INFIELD pjba001 name="construct.c.pjba001"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjba001  #顯示到畫面上

            NEXT FIELD pjba001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba001
            #add-point:BEFORE FIELD pjba001 name="construct.b.pjba001"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba001
            
            #add-point:AFTER FIELD pjba001 name="construct.a.pjba001"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba002
            #add-point:BEFORE FIELD pjba002 name="construct.b.pjba002"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba002
            
            #add-point:AFTER FIELD pjba002 name="construct.a.pjba002"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba002
            #add-point:ON ACTION controlp INFIELD pjba002 name="construct.c.pjba002"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbal003
            #add-point:BEFORE FIELD pjbal003 name="construct.b.pjbal003"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbal003
            
            #add-point:AFTER FIELD pjbal003 name="construct.a.pjbal003"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbal003
            #add-point:ON ACTION controlp INFIELD pjbal003 name="construct.c.pjbal003"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbal004
            #add-point:BEFORE FIELD pjbal004 name="construct.b.pjbal004"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbal004
            
            #add-point:AFTER FIELD pjbal004 name="construct.a.pjbal004"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbal004
            #add-point:ON ACTION controlp INFIELD pjbal004 name="construct.c.pjbal004"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba009
            #add-point:BEFORE FIELD pjba009 name="construct.b.pjba009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba009
            
            #add-point:AFTER FIELD pjba009 name="construct.a.pjba009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjba009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba009
            #add-point:ON ACTION controlp INFIELD pjba009 name="construct.c.pjba009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pjba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba003
            #add-point:ON ACTION controlp INFIELD pjba003 name="construct.c.pjba003"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjba003  #顯示到畫面上

            NEXT FIELD pjba003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba003
            #add-point:BEFORE FIELD pjba003 name="construct.b.pjba003"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba003
            
            #add-point:AFTER FIELD pjba003 name="construct.a.pjba003"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba004
            #add-point:ON ACTION controlp INFIELD pjba004 name="construct.c.pjba004"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "ALL"
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjba004  #顯示到畫面上

            NEXT FIELD pjba004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba004
            #add-point:BEFORE FIELD pjba004 name="construct.b.pjba004"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba004
            
            #add-point:AFTER FIELD pjba004 name="construct.a.pjba004"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba005
            #add-point:BEFORE FIELD pjba005 name="construct.b.pjba005"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba005
            
            #add-point:AFTER FIELD pjba005 name="construct.a.pjba005"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjba005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba005
            #add-point:ON ACTION controlp INFIELD pjba005 name="construct.c.pjba005"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba006
            #add-point:BEFORE FIELD pjba006 name="construct.b.pjba006"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba006
            
            #add-point:AFTER FIELD pjba006 name="construct.a.pjba006"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjba006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba006
            #add-point:ON ACTION controlp INFIELD pjba006 name="construct.c.pjba006"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.pjba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba010
            #add-point:ON ACTION controlp INFIELD pjba010 name="construct.c.pjba010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjba010  #顯示到畫面上
            NEXT FIELD pjba010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba010
            #add-point:BEFORE FIELD pjba010 name="construct.b.pjba010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba010
            
            #add-point:AFTER FIELD pjba010 name="construct.a.pjba010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba011
            #add-point:BEFORE FIELD pjba011 name="construct.b.pjba011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba011
            
            #add-point:AFTER FIELD pjba011 name="construct.a.pjba011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjba011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba011
            #add-point:ON ACTION controlp INFIELD pjba011 name="construct.c.pjba011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pjba012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba012
            #add-point:ON ACTION controlp INFIELD pjba012 name="construct.c.pjba012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjba012  #顯示到畫面上
            NEXT FIELD pjba012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba012
            #add-point:BEFORE FIELD pjba012 name="construct.b.pjba012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba012
            
            #add-point:AFTER FIELD pjba012 name="construct.a.pjba012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba013
            #add-point:BEFORE FIELD pjba013 name="construct.b.pjba013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba013
            
            #add-point:AFTER FIELD pjba013 name="construct.a.pjba013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjba013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba013
            #add-point:ON ACTION controlp INFIELD pjba013 name="construct.c.pjba013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pjba014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba014
            #add-point:ON ACTION controlp INFIELD pjba014 name="construct.c.pjba014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '8007'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjba014  #顯示到畫面上
            NEXT FIELD pjba014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba014
            #add-point:BEFORE FIELD pjba014 name="construct.b.pjba014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba014
            
            #add-point:AFTER FIELD pjba014 name="construct.a.pjba014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbastus
            #add-point:BEFORE FIELD pjbastus name="construct.b.pjbastus"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbastus
            
            #add-point:AFTER FIELD pjbastus name="construct.a.pjbastus"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbastus
            #add-point:ON ACTION controlp INFIELD pjbastus name="construct.c.pjbastus"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.pjbaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbaownid
            #add-point:ON ACTION controlp INFIELD pjbaownid name="construct.c.pjbaownid"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbaownid  #顯示到畫面上

            NEXT FIELD pjbaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbaownid
            #add-point:BEFORE FIELD pjbaownid name="construct.b.pjbaownid"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbaownid
            
            #add-point:AFTER FIELD pjbaownid name="construct.a.pjbaownid"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbaowndp
            #add-point:ON ACTION controlp INFIELD pjbaowndp name="construct.c.pjbaowndp"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbaowndp  #顯示到畫面上

            NEXT FIELD pjbaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbaowndp
            #add-point:BEFORE FIELD pjbaowndp name="construct.b.pjbaowndp"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbaowndp
            
            #add-point:AFTER FIELD pjbaowndp name="construct.a.pjbaowndp"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbacrtid
            #add-point:ON ACTION controlp INFIELD pjbacrtid name="construct.c.pjbacrtid"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbacrtid  #顯示到畫面上

            NEXT FIELD pjbacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbacrtid
            #add-point:BEFORE FIELD pjbacrtid name="construct.b.pjbacrtid"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbacrtid
            
            #add-point:AFTER FIELD pjbacrtid name="construct.a.pjbacrtid"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbacrtdp
            #add-point:ON ACTION controlp INFIELD pjbacrtdp name="construct.c.pjbacrtdp"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbacrtdp  #顯示到畫面上

            NEXT FIELD pjbacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbacrtdp
            #add-point:BEFORE FIELD pjbacrtdp name="construct.b.pjbacrtdp"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbacrtdp
            
            #add-point:AFTER FIELD pjbacrtdp name="construct.a.pjbacrtdp"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbacrtdt
            #add-point:BEFORE FIELD pjbacrtdt name="construct.b.pjbacrtdt"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.pjbamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbamodid
            #add-point:ON ACTION controlp INFIELD pjbamodid name="construct.c.pjbamodid"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbamodid  #顯示到畫面上

            NEXT FIELD pjbamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbamodid
            #add-point:BEFORE FIELD pjbamodid name="construct.b.pjbamodid"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbamodid
            
            #add-point:AFTER FIELD pjbamodid name="construct.a.pjbamodid"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbamoddt
            #add-point:BEFORE FIELD pjbamoddt name="construct.b.pjbamoddt"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.pjbacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbacnfid
            #add-point:ON ACTION controlp INFIELD pjbacnfid name="construct.c.pjbacnfid"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbacnfid  #顯示到畫面上

            NEXT FIELD pjbacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbacnfid
            #add-point:BEFORE FIELD pjbacnfid name="construct.b.pjbacnfid"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbacnfid
            
            #add-point:AFTER FIELD pjbacnfid name="construct.a.pjbacnfid"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbacnfdt
            #add-point:BEFORE FIELD pjbacnfdt name="construct.b.pjbacnfdt"
                     ON ACTION controlp INFIELD pjbm009           
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbm009  #顯示到畫面上

            NEXT FIELD pjbm009                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm019
            #add-point:BEFORE FIELD pjbm019 name="construct.b.pjbm019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm019
            
            #add-point:AFTER FIELD pjbm019 name="construct.a.pjbm019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbm019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm019
            #add-point:ON ACTION controlp INFIELD pjbm019 name="construct.c.pjbm019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm021
            #add-point:BEFORE FIELD pjbm021 name="construct.b.pjbm021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm021
            
            #add-point:AFTER FIELD pjbm021 name="construct.a.pjbm021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbm021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm021
            #add-point:ON ACTION controlp INFIELD pjbm021 name="construct.c.pjbm021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm023
            #add-point:BEFORE FIELD pjbm023 name="construct.b.pjbm023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm023
            
            #add-point:AFTER FIELD pjbm023 name="construct.a.pjbm023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbm023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm023
            #add-point:ON ACTION controlp INFIELD pjbm023 name="construct.c.pjbm023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm020
            #add-point:BEFORE FIELD pjbm020 name="construct.b.pjbm020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm020
            
            #add-point:AFTER FIELD pjbm020 name="construct.a.pjbm020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbm020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm020
            #add-point:ON ACTION controlp INFIELD pjbm020 name="construct.c.pjbm020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm022
            #add-point:BEFORE FIELD pjbm022 name="construct.b.pjbm022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm022
            
            #add-point:AFTER FIELD pjbm022 name="construct.a.pjbm022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbm022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm022
            #add-point:ON ACTION controlp INFIELD pjbm022 name="construct.c.pjbm022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm024
            #add-point:BEFORE FIELD pjbm024 name="construct.b.pjbm024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm024
            
            #add-point:AFTER FIELD pjbm024 name="construct.a.pjbm024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbm024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm024
            #add-point:ON ACTION controlp INFIELD pjbm024 name="construct.c.pjbm024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm025
            #add-point:BEFORE FIELD pjbm025 name="construct.b.pjbm025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm025
            
            #add-point:AFTER FIELD pjbm025 name="construct.a.pjbm025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbm025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm025
            #add-point:ON ACTION controlp INFIELD pjbm025 name="construct.c.pjbm025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm026
            #add-point:BEFORE FIELD pjbm026 name="construct.b.pjbm026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm026
            
            #add-point:AFTER FIELD pjbm026 name="construct.a.pjbm026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbm026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm026
            #add-point:ON ACTION controlp INFIELD pjbm026 name="construct.c.pjbm026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm027
            #add-point:BEFORE FIELD pjbm027 name="construct.b.pjbm027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm027
            
            #add-point:AFTER FIELD pjbm027 name="construct.a.pjbm027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbm027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm027
            #add-point:ON ACTION controlp INFIELD pjbm027 name="construct.c.pjbm027"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pjbm028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm028
            #add-point:ON ACTION controlp INFIELD pjbm028 name="construct.c.pjbm028"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbm028  #顯示到畫面上
            NEXT FIELD pjbm028                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm028
            #add-point:BEFORE FIELD pjbm028 name="construct.b.pjbm028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm028
            
            #add-point:AFTER FIELD pjbm028 name="construct.a.pjbm028"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm029
            #add-point:BEFORE FIELD pjbm029 name="construct.b.pjbm029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm029
            
            #add-point:AFTER FIELD pjbm029 name="construct.a.pjbm029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbm029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm029
            #add-point:ON ACTION controlp INFIELD pjbm029 name="construct.c.pjbm029"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON pjbm002,pjbml004,pjbml005,pjbm003,pjbm004,pjbm005,pjbm006,pjbm007,pjbm008, 
          pjbm009,pjbm010,pjbm011,pjbm012,pjbm013,pjbm014,pjbm015,pjbm016,pjbm017,pjbm018
           FROM s_detail1[1].pjbm002,s_detail1[1].pjbml004,s_detail1[1].pjbml005,s_detail1[1].pjbm003, 
               s_detail1[1].pjbm004,s_detail1[1].pjbm005,s_detail1[1].pjbm006,s_detail1[1].pjbm007,s_detail1[1].pjbm008, 
               s_detail1[1].pjbm009,s_detail1[1].pjbm010,s_detail1[1].pjbm011,s_detail1[1].pjbm012,s_detail1[1].pjbm013, 
               s_detail1[1].pjbm014,s_detail1[1].pjbm015,s_detail1[1].pjbm016,s_detail1[1].pjbm017,s_detail1[1].pjbm018 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                                                                                                            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.pjbm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm002
            #add-point:ON ACTION controlp INFIELD pjbm002 name="construct.c.page1.pjbm002"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pjbm01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbm002  #顯示到畫面上

            NEXT FIELD pjbm002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm002
            #add-point:BEFORE FIELD pjbm002 name="construct.b.page1.pjbm002"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm002
            
            #add-point:AFTER FIELD pjbm002 name="construct.a.page1.pjbm002"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbml004
            #add-point:BEFORE FIELD pjbml004 name="construct.b.page1.pjbml004"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbml004
            
            #add-point:AFTER FIELD pjbml004 name="construct.a.page1.pjbml004"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbml004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbml004
            #add-point:ON ACTION controlp INFIELD pjbml004 name="construct.c.page1.pjbml004"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbml005
            #add-point:BEFORE FIELD pjbml005 name="construct.b.page1.pjbml005"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbml005
            
            #add-point:AFTER FIELD pjbml005 name="construct.a.page1.pjbml005"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbml005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbml005
            #add-point:ON ACTION controlp INFIELD pjbml005 name="construct.c.page1.pjbml005"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pjbm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm003
            #add-point:ON ACTION controlp INFIELD pjbm003 name="construct.c.page1.pjbm003"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "8004"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbm003  #顯示到畫面上

            NEXT FIELD pjbm003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm003
            #add-point:BEFORE FIELD pjbm003 name="construct.b.page1.pjbm003"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm003
            
            #add-point:AFTER FIELD pjbm003 name="construct.a.page1.pjbm003"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbm004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm004
            #add-point:ON ACTION controlp INFIELD pjbm004 name="construct.c.page1.pjbm004"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_pjba_m.pjba005
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbm004  #顯示到畫面上

            NEXT FIELD pjbm004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm004
            #add-point:BEFORE FIELD pjbm004 name="construct.b.page1.pjbm004"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm004
            
            #add-point:AFTER FIELD pjbm004 name="construct.a.page1.pjbm004"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbm005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm005
            #add-point:ON ACTION controlp INFIELD pjbm005 name="construct.c.page1.pjbm005"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pjbm01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbm005  #顯示到畫面上

            NEXT FIELD pjbm005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm005
            #add-point:BEFORE FIELD pjbm005 name="construct.b.page1.pjbm005"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm005
            
            #add-point:AFTER FIELD pjbm005 name="construct.a.page1.pjbm005"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm006
            #add-point:BEFORE FIELD pjbm006 name="construct.b.page1.pjbm006"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm006
            
            #add-point:AFTER FIELD pjbm006 name="construct.a.page1.pjbm006"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm006
            #add-point:ON ACTION controlp INFIELD pjbm006 name="construct.c.page1.pjbm006"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pjbm007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm007
            #add-point:ON ACTION controlp INFIELD pjbm007 name="construct.c.page1.pjbm007"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pjbm01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbm007  #顯示到畫面上

            NEXT FIELD pjbm007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm007
            #add-point:BEFORE FIELD pjbm007 name="construct.b.page1.pjbm007"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm007
            
            #add-point:AFTER FIELD pjbm007 name="construct.a.page1.pjbm007"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm008
            #add-point:BEFORE FIELD pjbm008 name="construct.b.page1.pjbm008"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm008
            
            #add-point:AFTER FIELD pjbm008 name="construct.a.page1.pjbm008"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbm008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm008
            #add-point:ON ACTION controlp INFIELD pjbm008 name="construct.c.page1.pjbm008"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pjbm009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm009
            #add-point:ON ACTION controlp INFIELD pjbm009 name="construct.c.page1.pjbm009"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbm009  #顯示到畫面上

            NEXT FIELD pjbm009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm009
            #add-point:BEFORE FIELD pjbm009 name="construct.b.page1.pjbm009"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm009
            
            #add-point:AFTER FIELD pjbm009 name="construct.a.page1.pjbm009"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbm010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm010
            #add-point:ON ACTION controlp INFIELD pjbm010 name="construct.c.page1.pjbm010"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_pjba_m.pjba005
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbm010  #顯示到畫面上

            NEXT FIELD pjbm010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm010
            #add-point:BEFORE FIELD pjbm010 name="construct.b.page1.pjbm010"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm010
            
            #add-point:AFTER FIELD pjbm010 name="construct.a.page1.pjbm010"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbm011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm011
            #add-point:ON ACTION controlp INFIELD pjbm011 name="construct.c.page1.pjbm011"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbm011  #顯示到畫面上

            NEXT FIELD pjbm011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm011
            #add-point:BEFORE FIELD pjbm011 name="construct.b.page1.pjbm011"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm011
            
            #add-point:AFTER FIELD pjbm011 name="construct.a.page1.pjbm011"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm012
            #add-point:BEFORE FIELD pjbm012 name="construct.b.page1.pjbm012"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm012
            
            #add-point:AFTER FIELD pjbm012 name="construct.a.page1.pjbm012"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbm012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm012
            #add-point:ON ACTION controlp INFIELD pjbm012 name="construct.c.page1.pjbm012"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pjbm013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm013
            #add-point:ON ACTION controlp INFIELD pjbm013 name="construct.c.page1.pjbm013"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "8005"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbm013  #顯示到畫面上

            NEXT FIELD pjbm013                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm013
            #add-point:BEFORE FIELD pjbm013 name="construct.b.page1.pjbm013"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm013
            
            #add-point:AFTER FIELD pjbm013 name="construct.a.page1.pjbm013"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbm014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm014
            #add-point:ON ACTION controlp INFIELD pjbm014 name="construct.c.page1.pjbm014"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.arg1 = "8005"
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbm014  #顯示到畫面上

            NEXT FIELD pjbm014                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm014
            #add-point:BEFORE FIELD pjbm014 name="construct.b.page1.pjbm014"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm014
            
            #add-point:AFTER FIELD pjbm014 name="construct.a.page1.pjbm014"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm015
            #add-point:BEFORE FIELD pjbm015 name="construct.b.page1.pjbm015"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm015
            
            #add-point:AFTER FIELD pjbm015 name="construct.a.page1.pjbm015"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbm015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm015
            #add-point:ON ACTION controlp INFIELD pjbm015 name="construct.c.page1.pjbm015"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm016
            #add-point:BEFORE FIELD pjbm016 name="construct.b.page1.pjbm016"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm016
            
            #add-point:AFTER FIELD pjbm016 name="construct.a.page1.pjbm016"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbm016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm016
            #add-point:ON ACTION controlp INFIELD pjbm016 name="construct.c.page1.pjbm016"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm017
            #add-point:BEFORE FIELD pjbm017 name="construct.b.page1.pjbm017"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm017
            
            #add-point:AFTER FIELD pjbm017 name="construct.a.page1.pjbm017"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbm017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm017
            #add-point:ON ACTION controlp INFIELD pjbm017 name="construct.c.page1.pjbm017"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm018
            #add-point:BEFORE FIELD pjbm018 name="construct.b.page1.pjbm018"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm018
            
            #add-point:AFTER FIELD pjbm018 name="construct.a.page1.pjbm018"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbm018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm018
            #add-point:ON ACTION controlp INFIELD pjbm018 name="construct.c.page1.pjbm018"
                                                                                                            
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
                  WHEN la_wc[li_idx].tableid = "pjba_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "pjbm_t" 
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
   IF g_wc = " 1=1" THEN 
#      LET g_wc = " pjba000 IN (SELECT pjaa001 FROM pjaa_t WHERE pjaa010='Y' AND pjaastus='Y') " #160905-00007#3 marked
      LET g_wc = " pjba000 IN (SELECT pjaa001 FROM pjaa_t WHERE pjaa010='Y' AND pjaastus='Y' AND pjaaent = ",g_enterprise,") " #160905-00007#3 mod
   ELSE
#      LET g_wc = g_wc," AND pjba000 IN (SELECT pjaa001 FROM pjaa_t WHERE pjaa010='Y' AND pjaastus='Y') " #160905-00007#3 marked
      LET g_wc = g_wc," AND pjba000 IN (SELECT pjaa001 FROM pjaa_t WHERE pjaa010='Y' AND pjaastus='Y' AND pjaaent = ",g_enterprise,") " #160905-00007#3 mod
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apjm250.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION apjm250_filter()
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
      CONSTRUCT g_wc_filter ON pjba000,pjba001
                          FROM s_browse[1].b_pjba000,s_browse[1].b_pjba001
 
         BEFORE CONSTRUCT
               DISPLAY apjm250_filter_parser('pjba000') TO s_browse[1].b_pjba000
            DISPLAY apjm250_filter_parser('pjba001') TO s_browse[1].b_pjba001
      
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
 
      CALL apjm250_filter_show('pjba000')
   CALL apjm250_filter_show('pjba001')
 
END FUNCTION
 
{</section>}
 
{<section id="apjm250.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION apjm250_filter_parser(ps_field)
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
 
{<section id="apjm250.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION apjm250_filter_show(ps_field)
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
   LET ls_condition = apjm250_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apjm250.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apjm250_query()
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
   CALL g_pjbm_d.clear()
 
   
   #add-point:query段other name="query.other"
                           
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL apjm250_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apjm250_browser_fill("")
      CALL apjm250_fetch("")
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
      CALL apjm250_filter_show('pjba000')
   CALL apjm250_filter_show('pjba001')
   CALL apjm250_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL apjm250_fetch("F") 
      #顯示單身筆數
      CALL apjm250_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apjm250.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apjm250_fetch(p_flag)
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
   
   LET g_pjba_m.pjba001 = g_browser[g_current_idx].b_pjba001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apjm250_master_referesh USING g_pjba_m.pjba001 INTO g_pjba_m.pjba000,g_pjba_m.pjba001,g_pjba_m.pjba002, 
       g_pjba_m.pjba009,g_pjba_m.pjba003,g_pjba_m.pjba004,g_pjba_m.pjba005,g_pjba_m.pjba006,g_pjba_m.pjba010, 
       g_pjba_m.pjba011,g_pjba_m.pjba012,g_pjba_m.pjba013,g_pjba_m.pjba014,g_pjba_m.pjbastus,g_pjba_m.pjbaownid, 
       g_pjba_m.pjbaowndp,g_pjba_m.pjbacrtid,g_pjba_m.pjbacrtdp,g_pjba_m.pjbacrtdt,g_pjba_m.pjbamodid, 
       g_pjba_m.pjbamoddt,g_pjba_m.pjbacnfid,g_pjba_m.pjbacnfdt,g_pjba_m.pjba000_desc,g_pjba_m.pjba003_desc, 
       g_pjba_m.pjba004_desc,g_pjba_m.pjba010_desc,g_pjba_m.pjba012_desc,g_pjba_m.pjba014_desc,g_pjba_m.pjbaownid_desc, 
       g_pjba_m.pjbaowndp_desc,g_pjba_m.pjbacrtid_desc,g_pjba_m.pjbacrtdp_desc,g_pjba_m.pjbamodid_desc, 
       g_pjba_m.pjbacnfid_desc
   
   #遮罩相關處理
   LET g_pjba_m_mask_o.* =  g_pjba_m.*
   CALL apjm250_pjba_t_mask()
   LET g_pjba_m_mask_n.* =  g_pjba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apjm250_set_act_visible()   
   CALL apjm250_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
            CALL cl_set_act_visible("statechange", FALSE)               
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
                          
   #end add-point
   
   #保存單頭舊值
   LET g_pjba_m_t.* = g_pjba_m.*
   LET g_pjba_m_o.* = g_pjba_m.*
   
   LET g_data_owner = g_pjba_m.pjbaownid      
   LET g_data_dept  = g_pjba_m.pjbaowndp
   
   #重新顯示   
   CALL apjm250_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="apjm250.insert" >}
#+ 資料新增
PRIVATE FUNCTION apjm250_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
                           
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_pjbm_d.clear()   
 
 
   INITIALIZE g_pjba_m.* TO NULL             #DEFAULT 設定
   
   LET g_pjba001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pjba_m.pjbaownid = g_user
      LET g_pjba_m.pjbaowndp = g_dept
      LET g_pjba_m.pjbacrtid = g_user
      LET g_pjba_m.pjbacrtdp = g_dept 
      LET g_pjba_m.pjbacrtdt = cl_get_current()
      LET g_pjba_m.pjbamodid = g_user
      LET g_pjba_m.pjbamoddt = cl_get_current()
      LET g_pjba_m.pjbastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_pjba_m.pjba002 = "N"
      LET g_pjba_m.pjba009 = "0"
      LET g_pjba_m.pjba011 = "N"
      LET g_pjba_m.pjbastus = "Y"
      LET g_pjba_m.pjbm029 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_pjba_m.pjba009 = 0                                                 
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_pjba_m_t.* = g_pjba_m.*
      LET g_pjba_m_o.* = g_pjba_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pjba_m.pjbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
    
      CALL apjm250_input("a")
      
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
         INITIALIZE g_pjba_m.* TO NULL
         INITIALIZE g_pjbm_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL apjm250_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_pjbm_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apjm250_set_act_visible()   
   CALL apjm250_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pjba001_t = g_pjba_m.pjba001
 
   
   #組合新增資料的條件
   LET g_add_browse = " pjbaent = " ||g_enterprise|| " AND",
                      " pjba001 = '", g_pjba_m.pjba001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apjm250_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE apjm250_cl
   
   CALL apjm250_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apjm250_master_referesh USING g_pjba_m.pjba001 INTO g_pjba_m.pjba000,g_pjba_m.pjba001,g_pjba_m.pjba002, 
       g_pjba_m.pjba009,g_pjba_m.pjba003,g_pjba_m.pjba004,g_pjba_m.pjba005,g_pjba_m.pjba006,g_pjba_m.pjba010, 
       g_pjba_m.pjba011,g_pjba_m.pjba012,g_pjba_m.pjba013,g_pjba_m.pjba014,g_pjba_m.pjbastus,g_pjba_m.pjbaownid, 
       g_pjba_m.pjbaowndp,g_pjba_m.pjbacrtid,g_pjba_m.pjbacrtdp,g_pjba_m.pjbacrtdt,g_pjba_m.pjbamodid, 
       g_pjba_m.pjbamoddt,g_pjba_m.pjbacnfid,g_pjba_m.pjbacnfdt,g_pjba_m.pjba000_desc,g_pjba_m.pjba003_desc, 
       g_pjba_m.pjba004_desc,g_pjba_m.pjba010_desc,g_pjba_m.pjba012_desc,g_pjba_m.pjba014_desc,g_pjba_m.pjbaownid_desc, 
       g_pjba_m.pjbaowndp_desc,g_pjba_m.pjbacrtid_desc,g_pjba_m.pjbacrtdp_desc,g_pjba_m.pjbamodid_desc, 
       g_pjba_m.pjbacnfid_desc
   
   
   #遮罩相關處理
   LET g_pjba_m_mask_o.* =  g_pjba_m.*
   CALL apjm250_pjba_t_mask()
   LET g_pjba_m_mask_n.* =  g_pjba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pjba_m.pjba000,g_pjba_m.pjba000_desc,g_pjba_m.pjba001,g_pjba_m.pjba002,g_pjba_m.pjbal003, 
       g_pjba_m.pjbal004,g_pjba_m.pjba009,g_pjba_m.pjba003,g_pjba_m.pjba003_desc,g_pjba_m.pjba004,g_pjba_m.pjba004_desc, 
       g_pjba_m.pjba005,g_pjba_m.pjba006,g_pjba_m.pjba010,g_pjba_m.pjba010_desc,g_pjba_m.pjba011,g_pjba_m.pjba012, 
       g_pjba_m.pjba012_desc,g_pjba_m.pjba013,g_pjba_m.pjba014,g_pjba_m.pjba014_desc,g_pjba_m.pjbastus, 
       g_pjba_m.pjbaownid,g_pjba_m.pjbaownid_desc,g_pjba_m.pjbaowndp,g_pjba_m.pjbaowndp_desc,g_pjba_m.pjbacrtid, 
       g_pjba_m.pjbacrtid_desc,g_pjba_m.pjbacrtdp,g_pjba_m.pjbacrtdp_desc,g_pjba_m.pjbacrtdt,g_pjba_m.pjbamodid, 
       g_pjba_m.pjbamodid_desc,g_pjba_m.pjbamoddt,g_pjba_m.pjbacnfid,g_pjba_m.pjbacnfid_desc,g_pjba_m.pjbacnfdt, 
       g_pjba_m.date1,g_pjba_m.pjbm019,g_pjba_m.pjbm021,g_pjba_m.pjbm023,g_pjba_m.date2,g_pjba_m.pjbm020, 
       g_pjba_m.pjbm022,g_pjba_m.pjbm024,g_pjba_m.pjbm025,g_pjba_m.pjbm026,g_pjba_m.pjbm027,g_pjba_m.pjbm028, 
       g_pjba_m.pjbm028_desc,g_pjba_m.pjbm029
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_pjba_m.pjbaownid      
   LET g_data_dept  = g_pjba_m.pjbaowndp
   
   #功能已完成,通報訊息中心
   CALL apjm250_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apjm250.modify" >}
#+ 資料修改
PRIVATE FUNCTION apjm250_modify()
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
   LET g_pjba_m_t.* = g_pjba_m.*
   LET g_pjba_m_o.* = g_pjba_m.*
   
   IF g_pjba_m.pjba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_pjba001_t = g_pjba_m.pjba001
 
   CALL s_transaction_begin()
   
   OPEN apjm250_cl USING g_enterprise,g_pjba_m.pjba001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apjm250_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apjm250_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apjm250_master_referesh USING g_pjba_m.pjba001 INTO g_pjba_m.pjba000,g_pjba_m.pjba001,g_pjba_m.pjba002, 
       g_pjba_m.pjba009,g_pjba_m.pjba003,g_pjba_m.pjba004,g_pjba_m.pjba005,g_pjba_m.pjba006,g_pjba_m.pjba010, 
       g_pjba_m.pjba011,g_pjba_m.pjba012,g_pjba_m.pjba013,g_pjba_m.pjba014,g_pjba_m.pjbastus,g_pjba_m.pjbaownid, 
       g_pjba_m.pjbaowndp,g_pjba_m.pjbacrtid,g_pjba_m.pjbacrtdp,g_pjba_m.pjbacrtdt,g_pjba_m.pjbamodid, 
       g_pjba_m.pjbamoddt,g_pjba_m.pjbacnfid,g_pjba_m.pjbacnfdt,g_pjba_m.pjba000_desc,g_pjba_m.pjba003_desc, 
       g_pjba_m.pjba004_desc,g_pjba_m.pjba010_desc,g_pjba_m.pjba012_desc,g_pjba_m.pjba014_desc,g_pjba_m.pjbaownid_desc, 
       g_pjba_m.pjbaowndp_desc,g_pjba_m.pjbacrtid_desc,g_pjba_m.pjbacrtdp_desc,g_pjba_m.pjbamodid_desc, 
       g_pjba_m.pjbacnfid_desc
   
   #檢查是否允許此動作
   IF NOT apjm250_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pjba_m_mask_o.* =  g_pjba_m.*
   CALL apjm250_pjba_t_mask()
   LET g_pjba_m_mask_n.* =  g_pjba_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL apjm250_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_pjba001_t = g_pjba_m.pjba001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_pjba_m.pjbamodid = g_user 
LET g_pjba_m.pjbamoddt = cl_get_current()
LET g_pjba_m.pjbamodid_desc = cl_get_username(g_pjba_m.pjbamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
                                                      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL apjm250_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
                                                      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE pjba_t SET (pjbamodid,pjbamoddt) = (g_pjba_m.pjbamodid,g_pjba_m.pjbamoddt)
          WHERE pjbaent = g_enterprise AND pjba001 = g_pjba001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_pjba_m.* = g_pjba_m_t.*
            CALL apjm250_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_pjba_m.pjba001 != g_pjba_m_t.pjba001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                                                                                 
         #end add-point
         
         #更新單身key值
         UPDATE pjbm_t SET pjbm001 = g_pjba_m.pjba001
 
          WHERE pjbment = g_enterprise AND pjbm001 = g_pjba_m_t.pjba001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                                                                                 
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pjbm_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pjbm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
                                                      UPDATE pjba_t SET pjbamodid = g_user,
                                 pjbamoddt=g_pjba_m.pjbamoddt
          WHERE pjbaent = g_enterprise AND pjba001 = g_pjba_m.pjba001                            
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'pjbmlent'
LET l_new_key[02] = g_pjba_m.pjba001
LET l_old_key[02] = g_pjba001_t
LET l_field_key[02] = 'pjbml001'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'pjbml_t')
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apjm250_set_act_visible()   
   CALL apjm250_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pjbaent = " ||g_enterprise|| " AND",
                      " pjba001 = '", g_pjba_m.pjba001, "' "
 
   #填到對應位置
   CALL apjm250_browser_fill("")
 
   CLOSE apjm250_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apjm250_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="apjm250.input" >}
#+ 資料輸入
PRIVATE FUNCTION apjm250_input(p_cmd)
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
   DEFINE  l_pjaa006             LIKE pjaa_t.pjaa006
   DEFINE  i                     LIKE type_t.num5
   DEFINE  l_msg                 STRING
   DEFINE  l_s                   LIKE type_t.chr1
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
   DISPLAY BY NAME g_pjba_m.pjba000,g_pjba_m.pjba000_desc,g_pjba_m.pjba001,g_pjba_m.pjba002,g_pjba_m.pjbal003, 
       g_pjba_m.pjbal004,g_pjba_m.pjba009,g_pjba_m.pjba003,g_pjba_m.pjba003_desc,g_pjba_m.pjba004,g_pjba_m.pjba004_desc, 
       g_pjba_m.pjba005,g_pjba_m.pjba006,g_pjba_m.pjba010,g_pjba_m.pjba010_desc,g_pjba_m.pjba011,g_pjba_m.pjba012, 
       g_pjba_m.pjba012_desc,g_pjba_m.pjba013,g_pjba_m.pjba014,g_pjba_m.pjba014_desc,g_pjba_m.pjbastus, 
       g_pjba_m.pjbaownid,g_pjba_m.pjbaownid_desc,g_pjba_m.pjbaowndp,g_pjba_m.pjbaowndp_desc,g_pjba_m.pjbacrtid, 
       g_pjba_m.pjbacrtid_desc,g_pjba_m.pjbacrtdp,g_pjba_m.pjbacrtdp_desc,g_pjba_m.pjbacrtdt,g_pjba_m.pjbamodid, 
       g_pjba_m.pjbamodid_desc,g_pjba_m.pjbamoddt,g_pjba_m.pjbacnfid,g_pjba_m.pjbacnfid_desc,g_pjba_m.pjbacnfdt, 
       g_pjba_m.date1,g_pjba_m.pjbm019,g_pjba_m.pjbm021,g_pjba_m.pjbm023,g_pjba_m.date2,g_pjba_m.pjbm020, 
       g_pjba_m.pjbm022,g_pjba_m.pjbm024,g_pjba_m.pjbm025,g_pjba_m.pjbm026,g_pjba_m.pjbm027,g_pjba_m.pjbm028, 
       g_pjba_m.pjbm028_desc,g_pjba_m.pjbm029
   
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
   LET g_forupd_sql = "SELECT pjbm002,pjbm003,pjbm004,pjbm005,pjbm006,pjbm007,pjbm008,pjbm009,pjbm010, 
       pjbm011,pjbm012,pjbm013,pjbm014,pjbm015,pjbm016,pjbm017,pjbm018 FROM pjbm_t WHERE pjbment=? AND  
       pjbm001=? AND pjbm002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
                           
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apjm250_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
                           
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apjm250_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
                           
   #end add-point
   CALL apjm250_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_pjba_m.pjba002,g_pjba_m.pjbal003,g_pjba_m.pjbal004,g_pjba_m.pjba009
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   IF g_pjba_m.pjbastus = 'X' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "apj-00037"
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apjm250.input.head" >}
      #單頭段
      INPUT BY NAME g_pjba_m.pjba002,g_pjba_m.pjbal003,g_pjba_m.pjbal004,g_pjba_m.pjba009 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
                                                                                                                        LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               IF NOT cl_null(g_pjba_m.pjba001) THEN
                  CALL n_pjbal(g_pjba_m.pjba001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_pjba_m.pjba001
                  CALL ap_ref_array2(g_ref_fields," SELECT pjbal003,pjbal004 FROM pjbal_t WHERE pjbalent = '"
                      ||g_enterprise||"' AND pjbal001 = ?  AND pjbal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_pjba_m.pjbal003 = g_rtn_fields[1]
                  LET g_pjba_m.pjbal004 = g_rtn_fields[2]
                  DISPLAY BY NAME g_pjba_m.pjbal003
                  DISPLAY BY NAME g_pjba_m.pjbal004   
               END IF
            END IF
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN apjm250_cl USING g_enterprise,g_pjba_m.pjba001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apjm250_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apjm250_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.pjbal001 = g_pjba_m.pjba001
LET g_master_multi_table_t.pjbal003 = g_pjba_m.pjbal003
LET g_master_multi_table_t.pjbal004 = g_pjba_m.pjbal004
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.pjbal001 = ''
LET g_master_multi_table_t.pjbal003 = ''
LET g_master_multi_table_t.pjbal004 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL apjm250_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
                                                                                                            
            #end add-point
            CALL apjm250_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba002
            #add-point:BEFORE FIELD pjba002 name="input.b.pjba002"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba002
            
            #add-point:AFTER FIELD pjba002 name="input.a.pjba002"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjba002
            #add-point:ON CHANGE pjba002 name="input.g.pjba002"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbal003
            #add-point:BEFORE FIELD pjbal003 name="input.b.pjbal003"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbal003
            
            #add-point:AFTER FIELD pjbal003 name="input.a.pjbal003"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbal003
            #add-point:ON CHANGE pjbal003 name="input.g.pjbal003"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbal004
            #add-point:BEFORE FIELD pjbal004 name="input.b.pjbal004"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbal004
            
            #add-point:AFTER FIELD pjbal004 name="input.a.pjbal004"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbal004
            #add-point:ON CHANGE pjbal004 name="input.g.pjbal004"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba009
            #add-point:BEFORE FIELD pjba009 name="input.b.pjba009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba009
            
            #add-point:AFTER FIELD pjba009 name="input.a.pjba009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjba009
            #add-point:ON CHANGE pjba009 name="input.g.pjba009"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pjba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba002
            #add-point:ON ACTION controlp INFIELD pjba002 name="input.c.pjba002"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.pjbal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbal003
            #add-point:ON ACTION controlp INFIELD pjbal003 name="input.c.pjbal003"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.pjbal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbal004
            #add-point:ON ACTION controlp INFIELD pjbal004 name="input.c.pjbal004"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.pjba009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba009
            #add-point:ON ACTION controlp INFIELD pjba009 name="input.c.pjba009"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_pjba_m.pjba001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                                                                                                                                       
               #end add-point
               
               INSERT INTO pjba_t (pjbaent,pjba000,pjba001,pjba002,pjba009,pjba003,pjba004,pjba005,pjba006, 
                   pjba010,pjba011,pjba012,pjba013,pjba014,pjbastus,pjbaownid,pjbaowndp,pjbacrtid,pjbacrtdp, 
                   pjbacrtdt,pjbamodid,pjbamoddt,pjbacnfid,pjbacnfdt)
               VALUES (g_enterprise,g_pjba_m.pjba000,g_pjba_m.pjba001,g_pjba_m.pjba002,g_pjba_m.pjba009, 
                   g_pjba_m.pjba003,g_pjba_m.pjba004,g_pjba_m.pjba005,g_pjba_m.pjba006,g_pjba_m.pjba010, 
                   g_pjba_m.pjba011,g_pjba_m.pjba012,g_pjba_m.pjba013,g_pjba_m.pjba014,g_pjba_m.pjbastus, 
                   g_pjba_m.pjbaownid,g_pjba_m.pjbaowndp,g_pjba_m.pjbacrtid,g_pjba_m.pjbacrtdp,g_pjba_m.pjbacrtdt, 
                   g_pjba_m.pjbamodid,g_pjba_m.pjbamoddt,g_pjba_m.pjbacnfid,g_pjba_m.pjbacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_pjba_m:",SQLERRMESSAGE 
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
         IF g_pjba_m.pjba001 = g_master_multi_table_t.pjbal001 AND
         g_pjba_m.pjbal003 = g_master_multi_table_t.pjbal003 AND 
         g_pjba_m.pjbal004 = g_master_multi_table_t.pjbal004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'pjbalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_pjba_m.pjba001
            LET l_field_keys[02] = 'pjbal001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.pjbal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'pjbal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_pjba_m.pjbal003
            LET l_fields[01] = 'pjbal003'
            LET l_vars[02] = g_pjba_m.pjbal004
            LET l_fields[02] = 'pjbal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pjbal_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
                                                                                                                                       
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apjm250_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL apjm250_b_fill()
                  CALL apjm250_b_fill2('0')
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
               CALL apjm250_pjba_t_mask_restore('restore_mask_o')
               
               UPDATE pjba_t SET (pjba000,pjba001,pjba002,pjba009,pjba003,pjba004,pjba005,pjba006,pjba010, 
                   pjba011,pjba012,pjba013,pjba014,pjbastus,pjbaownid,pjbaowndp,pjbacrtid,pjbacrtdp, 
                   pjbacrtdt,pjbamodid,pjbamoddt,pjbacnfid,pjbacnfdt) = (g_pjba_m.pjba000,g_pjba_m.pjba001, 
                   g_pjba_m.pjba002,g_pjba_m.pjba009,g_pjba_m.pjba003,g_pjba_m.pjba004,g_pjba_m.pjba005, 
                   g_pjba_m.pjba006,g_pjba_m.pjba010,g_pjba_m.pjba011,g_pjba_m.pjba012,g_pjba_m.pjba013, 
                   g_pjba_m.pjba014,g_pjba_m.pjbastus,g_pjba_m.pjbaownid,g_pjba_m.pjbaowndp,g_pjba_m.pjbacrtid, 
                   g_pjba_m.pjbacrtdp,g_pjba_m.pjbacrtdt,g_pjba_m.pjbamodid,g_pjba_m.pjbamoddt,g_pjba_m.pjbacnfid, 
                   g_pjba_m.pjbacnfdt)
                WHERE pjbaent = g_enterprise AND pjba001 = g_pjba001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "pjba_t:",SQLERRMESSAGE 
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
         IF g_pjba_m.pjba001 = g_master_multi_table_t.pjbal001 AND
         g_pjba_m.pjbal003 = g_master_multi_table_t.pjbal003 AND 
         g_pjba_m.pjbal004 = g_master_multi_table_t.pjbal004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'pjbalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_pjba_m.pjba001
            LET l_field_keys[02] = 'pjbal001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.pjbal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'pjbal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_pjba_m.pjbal003
            LET l_fields[01] = 'pjbal003'
            LET l_vars[02] = g_pjba_m.pjbal004
            LET l_fields[02] = 'pjbal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pjbal_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL apjm250_pjba_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_pjba_m_t)
               LET g_log2 = util.JSON.stringify(g_pjba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                                                                                                                                       
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_pjba001_t = g_pjba_m.pjba001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="apjm250.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_pjbm_d FROM s_detail1.*
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
                                                                                                                        LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               IF NOT cl_null(g_pjbm_d[l_ac].pjbm002) AND NOT cl_null(g_pjba_m.pjba001) THEN
                  CALL n_pjbml(g_pjba_m.pjba001,g_pjbm_d[l_ac].pjbm002)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_pjba_m.pjba001
                  LET g_ref_fields[2] = g_pjbm_d[l_ac].pjbm002
                  CALL ap_ref_array2(g_ref_fields," SELECT pjbml004,pjbml005 FROM pjbml_t WHERE pjbmlent = '"
                      ||g_enterprise||"' AND pjbml001 = ? AND pjbml002 = ? AND pjbml003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_pjbm_d[l_ac].pjbml004 = g_rtn_fields[1]
                  LET g_pjbm_d[l_ac].pjbml005 = g_rtn_fields[2]
                  DISPLAY BY NAME g_pjbm_d[l_ac].pjbml004
                  DISPLAY BY NAME g_pjbm_d[l_ac].pjbml005   
               END IF
            END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pjbm_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apjm250_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_pjbm_d.getLength()
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
            OPEN apjm250_cl USING g_enterprise,g_pjba_m.pjba001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apjm250_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apjm250_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_pjbm_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pjbm_d[l_ac].pjbm002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pjbm_d_t.* = g_pjbm_d[l_ac].*  #BACKUP
               LET g_pjbm_d_o.* = g_pjbm_d[l_ac].*  #BACKUP
               CALL apjm250_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
                                                                                                                                                      CALL apjm250_apjm006_required()
               #end add-point  
               CALL apjm250_set_no_entry_b(l_cmd)
               IF NOT apjm250_lock_b("pjbm_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apjm250_bcl INTO g_pjbm_d[l_ac].pjbm002,g_pjbm_d[l_ac].pjbm003,g_pjbm_d[l_ac].pjbm004, 
                      g_pjbm_d[l_ac].pjbm005,g_pjbm_d[l_ac].pjbm006,g_pjbm_d[l_ac].pjbm007,g_pjbm_d[l_ac].pjbm008, 
                      g_pjbm_d[l_ac].pjbm009,g_pjbm_d[l_ac].pjbm010,g_pjbm_d[l_ac].pjbm011,g_pjbm_d[l_ac].pjbm012, 
                      g_pjbm_d[l_ac].pjbm013,g_pjbm_d[l_ac].pjbm014,g_pjbm_d[l_ac].pjbm015,g_pjbm_d[l_ac].pjbm016, 
                      g_pjbm_d[l_ac].pjbm017,g_pjbm_d[l_ac].pjbm018
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_pjbm_d_t.pjbm002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pjbm_d_mask_o[l_ac].* =  g_pjbm_d[l_ac].*
                  CALL apjm250_pjbm_t_mask()
                  LET g_pjbm_d_mask_n[l_ac].* =  g_pjbm_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apjm250_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF l_ac > 0  AND l_cmd = 'u' THEN
               LET l_s = 'N'
               LET l_msg = NULL
               CALL cl_showmsg_init()
               FOR i=l_ac TO l_n
                   CALL apjm250_pjbm(i)
                   IF g_pjba_m.pjbm029 = '9' THEN
                      LET l_msg = cl_getmsg('apj-00035',g_lang) CLIPPED, ":",g_pjbm_d[i].pjbm002
                      CALL cl_errmsg('','',l_msg,'apj-00036',1)
                      IF i = l_n THEN
                         LET l_s = 'Y'
                      ELSE
                         CONTINUE FOR
                      END IF
                   ELSE
                      EXIT FOR
                   END IF
               END FOR
               CALL cl_showmsg() 
               IF l_s = 'Y' THEN EXIT DIALOG END IF               
               IF NOT cl_null(l_msg) THEN
                  LET l_ac = i 
                  LET g_pjbm_d_t.* = g_pjbm_d[l_ac].*  #BACKUP
                  CALL apjm250_set_entry_b(l_cmd)
               
                  CALL apjm250_set_no_entry_b(l_cmd)
                  IF NOT apjm250_lock_b("pjbm_t","'1'") THEN
                     LET l_lock_sw='Y'
                  ELSE
                
                     LET g_bfill = "N"
                     CALL apjm250_show()
                     LET g_bfill = "Y"
                  
                     CALL cl_show_fld_cont()
                     CALL fgl_set_arr_curr(l_ac)    
                   END IF                    
               END IF 
            END IF  
            IF NOT cl_null(g_pjba_m.pjbm029) AND g_pjba_m.pjbm029 != 0 THEN 
               CALL FGL_SET_ARR_CURR(g_pjbm_d.getLength()+1)  
            END IF               
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.pjbml001 = g_pjba_m.pjba001
LET g_detail_multi_table_t.pjbml002 = g_pjbm_d[l_ac].pjbm002
LET g_detail_multi_table_t.pjbml003 = g_dlang
LET g_detail_multi_table_t.pjbml004 = g_pjbm_d[l_ac].pjbml004
LET g_detail_multi_table_t.pjbml005 = g_pjbm_d[l_ac].pjbml005
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'pjbmlent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'pjbml001'
            LET l_var_keys[02] = g_pjba_m.pjba001
            LET l_field_keys[03] = 'pjbml002'
            LET l_var_keys[03] = g_pjbm_d[l_ac].pjbm002
            LET l_field_keys[04] = 'pjbml003'
            LET l_var_keys[04] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'pjbml_t') THEN
               RETURN 
            END IF 
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pjbm_d[l_ac].* TO NULL 
            INITIALIZE g_pjbm_d_t.* TO NULL 
            INITIALIZE g_pjbm_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_pjbm_d[l_ac].pjbm008 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_pjbm_d_t.* = g_pjbm_d[l_ac].*     #新輸入資料
            LET g_pjbm_d_o.* = g_pjbm_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apjm250_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
                                                                                                            
            #end add-point
            CALL apjm250_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pjbm_d[li_reproduce_target].* = g_pjbm_d[li_reproduce].*
 
               LET g_pjbm_d[li_reproduce_target].pjbm002 = NULL
 
            END IF
            
LET g_detail_multi_table_t.pjbml001 = g_pjba_m.pjba001
LET g_detail_multi_table_t.pjbml002 = g_pjbm_d[l_ac].pjbm002
LET g_detail_multi_table_t.pjbml003 = g_dlang
LET g_detail_multi_table_t.pjbml004 = g_pjbm_d[l_ac].pjbml004
LET g_detail_multi_table_t.pjbml005 = g_pjbm_d[l_ac].pjbml005
 
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
            SELECT COUNT(1) INTO l_count FROM pjbm_t 
             WHERE pjbment = g_enterprise AND pjbm001 = g_pjba_m.pjba001
 
               AND pjbm002 = g_pjbm_d[l_ac].pjbm002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
                                                                                                                                       
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pjba_m.pjba001
               LET gs_keys[2] = g_pjbm_d[g_detail_idx].pjbm002
               CALL apjm250_insert_b('pjbm_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
                                                                                                                                       
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_pjbm_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pjbm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apjm250_b_fill()
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_pjba_m.pjba001 = g_detail_multi_table_t.pjbml001 AND
         g_pjbm_d[l_ac].pjbm002 = g_detail_multi_table_t.pjbml002 AND
         g_pjbm_d[l_ac].pjbml004 = g_detail_multi_table_t.pjbml004 AND
         g_pjbm_d[l_ac].pjbml005 = g_detail_multi_table_t.pjbml005 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'pjbmlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_pjba_m.pjba001
            LET l_field_keys[02] = 'pjbml001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.pjbml001
            LET l_var_keys[03] = g_pjbm_d[l_ac].pjbm002
            LET l_field_keys[03] = 'pjbml002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.pjbml002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'pjbml003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.pjbml003
            LET l_vars[01] = g_pjbm_d[l_ac].pjbml004
            LET l_fields[01] = 'pjbml004'
            LET l_vars[02] = g_pjbm_d[l_ac].pjbml005
            LET l_fields[02] = 'pjbml005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pjbml_t')
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
                                                                                                                                       
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_pjba_m.pjba001
 
               LET gs_keys[gs_keys.getLength()+1] = g_pjbm_d_t.pjbm002
 
            
               #刪除同層單身
               IF NOT apjm250_delete_b('pjbm_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apjm250_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apjm250_key_delete_b(gs_keys,'pjbm_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apjm250_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'pjbmlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'pjbml001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.pjbml001
                  LET l_field_keys[03] = 'pjbml002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.pjbml002
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'pjbml_t')
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
                                                                                                                                       
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE apjm250_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                                                                                                                                                                  
               #end add-point
               LET l_count = g_pjbm_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                                                                                                            
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pjbm_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm002
            #add-point:BEFORE FIELD pjbm002 name="input.b.page1.pjbm002"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm002
            
            #add-point:AFTER FIELD pjbm002 name="input.a.page1.pjbm002"
                                                                                                                        #此段落由子樣板a05產生
            IF  g_pjba_m.pjba001 IS NOT NULL AND g_pjbm_d[g_detail_idx].pjbm002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjbm_d[g_detail_idx].pjbm002 != g_pjbm_d_t.pjbm002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbm_t WHERE "||"pjbment = '" ||g_enterprise|| "' AND "||"pjbm001 = '"||g_pjba_m.pjba001 ||"' AND "|| "pjbm002 = '"||g_pjbm_d[g_detail_idx].pjbm002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_pjbm_d[l_ac].pjbm005 = g_pjbm_d[l_ac].pjbm002 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "axm-00108"
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pjbm_d[l_ac].pjbm002 = g_pjbm_d_t.pjbm002
               NEXT FIELD pjbm002
            END IF
            IF g_pjbm_d[l_ac].pjbm007 = g_pjbm_d[l_ac].pjbm002 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "axm-00109"
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pjbm_d[l_ac].pjbm002 = g_pjbm_d_t.pjbm002
               NEXT FIELD pjbm002
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm002
            #add-point:ON CHANGE pjbm002 name="input.g.page1.pjbm002"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbml004
            #add-point:BEFORE FIELD pjbml004 name="input.b.page1.pjbml004"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbml004
            
            #add-point:AFTER FIELD pjbml004 name="input.a.page1.pjbml004"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbml004
            #add-point:ON CHANGE pjbml004 name="input.g.page1.pjbml004"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbml005
            #add-point:BEFORE FIELD pjbml005 name="input.b.page1.pjbml005"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbml005
            
            #add-point:AFTER FIELD pjbml005 name="input.a.page1.pjbml005"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbml005
            #add-point:ON CHANGE pjbml005 name="input.g.page1.pjbml005"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm003
            
            #add-point:AFTER FIELD pjbm003 name="input.a.page1.pjbm003"
            CALL apjm250_pjbm003_desc()
            IF NOT cl_null(g_pjbm_d[l_ac].pjbm003) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbm_d[l_ac].pjbm003
               LET g_chkparam.err_str[1] = "axm-00065:sub-01302|apji050|",cl_get_progname("apji050",g_lang,"2"),"|:EXEPROGapji050"  #160318-00025#31  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_8004") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbm_d[l_ac].pjbm003 = g_pjbm_d_t.pjbm003
                  CALL apjm250_pjbm003_desc()
                  NEXT FIELD CURRENT
               END IF
            

            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm003
            #add-point:BEFORE FIELD pjbm003 name="input.b.page1.pjbm003"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm003
            #add-point:ON CHANGE pjbm003 name="input.g.page1.pjbm003"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm004
            
            #add-point:AFTER FIELD pjbm004 name="input.a.page1.pjbm004"
                                                                                                                        CALL apjm250_pjbm004_desc()
            IF NOT cl_null(g_pjbm_d[l_ac].pjbm004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbm_d[l_ac].pjbm004
               LET g_chkparam.arg2 = g_pjba_m.pjba005

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbm_d[l_ac].pjbm004 = g_pjbm_d_t.pjbm004
                  CALL apjm250_pjbm004_desc()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm004
            #add-point:BEFORE FIELD pjbm004 name="input.b.page1.pjbm004"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm004
            #add-point:ON CHANGE pjbm004 name="input.g.page1.pjbm004"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm005
            
            #add-point:AFTER FIELD pjbm005 name="input.a.page1.pjbm005"
                                                                                                            IF g_pjbm_d[l_ac].pjbm005 = g_pjbm_d[l_ac].pjbm002 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "axm-00108"
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pjbm_d[l_ac].pjbm005 = g_pjbm_d_t.pjbm005
               NEXT FIELD pjbm005
            END IF
            CALL apjm250_pjbm005_desc()
            CALL apjm250_apjm006_required()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm005
            #add-point:BEFORE FIELD pjbm005 name="input.b.page1.pjbm005"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm005
            #add-point:ON CHANGE pjbm005 name="input.g.page1.pjbm005"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm006
            #add-point:BEFORE FIELD pjbm006 name="input.b.page1.pjbm006"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm006
            
            #add-point:AFTER FIELD pjbm006 name="input.a.page1.pjbm006"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm006
            #add-point:ON CHANGE pjbm006 name="input.g.page1.pjbm006"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm007
            
            #add-point:AFTER FIELD pjbm007 name="input.a.page1.pjbm007"
                                                                                                            IF g_pjbm_d[l_ac].pjbm007 = g_pjbm_d[l_ac].pjbm002 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "axm-00109"
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pjbm_d[l_ac].pjbm007 = g_pjbm_d_t.pjbm007
               NEXT FIELD pjbm007
            END IF
            CALL apjm250_pjbm007_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm007
            #add-point:BEFORE FIELD pjbm007 name="input.b.page1.pjbm007"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm007
            #add-point:ON CHANGE pjbm007 name="input.g.page1.pjbm007"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pjbm_d[l_ac].pjbm008,"0","1","","","azz-00079",1) THEN
               NEXT FIELD pjbm008
            END IF 
 
 
 
            #add-point:AFTER FIELD pjbm008 name="input.a.page1.pjbm008"
                                                                                                                        IF NOT cl_null(g_pjbm_d[l_ac].pjbm008) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm008
            #add-point:BEFORE FIELD pjbm008 name="input.b.page1.pjbm008"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm008
            #add-point:ON CHANGE pjbm008 name="input.g.page1.pjbm008"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm009
            
            #add-point:AFTER FIELD pjbm009 name="input.a.page1.pjbm009"
                                                                                                                        CALL apjm250_pjbm009_desc()
            IF NOT cl_null(g_pjbm_d[l_ac].pjbm009) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbm_d[l_ac].pjbm009
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#31  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbm_d[l_ac].pjbm009 = g_pjbm_d_t.pjbm009
                  CALL apjm250_pjbm009_desc()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL apjm250_pjbm009()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm009
            #add-point:BEFORE FIELD pjbm009 name="input.b.page1.pjbm009"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm009
            #add-point:ON CHANGE pjbm009 name="input.g.page1.pjbm009"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm010
            
            #add-point:AFTER FIELD pjbm010 name="input.a.page1.pjbm010"
                                                                                                                        CALL apjm250_pjbm010_desc()
            IF NOT cl_null(g_pjbm_d[l_ac].pjbm010) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbm_d[l_ac].pjbm010
               LET g_chkparam.arg2 = g_pjba_m.pjba005

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbm_d[l_ac].pjbm010 = g_pjbm_d_t.pjbm010
                  CALL apjm250_pjbm010_desc()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm010
            #add-point:BEFORE FIELD pjbm010 name="input.b.page1.pjbm010"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm010
            #add-point:ON CHANGE pjbm010 name="input.g.page1.pjbm010"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm011
            
            #add-point:AFTER FIELD pjbm011 name="input.a.page1.pjbm011"
                                                                                                                        CALL apjm250_pjbm011_desc()
            IF NOT cl_null(g_pjbm_d[l_ac].pjbm011) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjba_m.pjba001
               LET g_chkparam.arg2 = g_pjbm_d[l_ac].pjbm011
               SELECT pjaa006 INTO l_pjaa006 FROM pjaa_file WHERE pjaa001=g_pjba_m.pjba000 AND pjaaent = g_enterprise
               
               IF l_pjaa006 = '3' THEN   
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_pjbb002_2") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 

                  ELSE
                     #檢查失敗時後續處理
                     LET g_pjbm_d[l_ac].pjbm011 = g_pjbm_d_t.pjbm011
                     CALL apjm250_pjbm011_desc()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_pjbb002_1") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 

                  ELSE
                     #檢查失敗時後續處理
                     LET g_pjbm_d[l_ac].pjbm011 = g_pjbm_d_t.pjbm011
                     CALL apjm250_pjbm011_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            

            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm011
            #add-point:BEFORE FIELD pjbm011 name="input.b.page1.pjbm011"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm011
            #add-point:ON CHANGE pjbm011 name="input.g.page1.pjbm011"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pjbm_d[l_ac].pjbm012,"1","1","100","1","azz-00087",1) THEN
               NEXT FIELD pjbm012
            END IF 
 
 
 
            #add-point:AFTER FIELD pjbm012 name="input.a.page1.pjbm012"
                                                                                                                        IF NOT cl_null(g_pjbm_d[l_ac].pjbm012) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm012
            #add-point:BEFORE FIELD pjbm012 name="input.b.page1.pjbm012"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm012
            #add-point:ON CHANGE pjbm012 name="input.g.page1.pjbm012"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm013
            
            #add-point:AFTER FIELD pjbm013 name="input.a.page1.pjbm013"
                                                                                                                        CALL apjm250_apjm013_desc()
            IF NOT cl_null(g_pjbm_d[l_ac].pjbm013) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbm_d[l_ac].pjbm013
               LET g_chkparam.err_str[1] = "axm-00067:sub-01302|apji060|",cl_get_progname("apji060",g_lang,"2"),"|:EXEPROGapji060"  #160318-00025#31  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_8005") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbm_d[l_ac].pjbm013 = g_pjbm_d_t.pjbm013
                  CALL apjm250_apjm013_desc()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm013
            #add-point:BEFORE FIELD pjbm013 name="input.b.page1.pjbm013"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm013
            #add-point:ON CHANGE pjbm013 name="input.g.page1.pjbm013"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm014
            
            #add-point:AFTER FIELD pjbm014 name="input.a.page1.pjbm014"
                                                                                                                        CALL apjm250_apjm014_desc()
            IF NOT cl_null(g_pjbm_d[l_ac].pjbm014) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbm_d[l_ac].pjbm014
               LET g_chkparam.err_str[1] = "axm-00067:sub-01302|apji060|",cl_get_progname("apji060",g_lang,"2"),"|:EXEPROGapji060"  #160318-00025#31  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_8005") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbm_d[l_ac].pjbm014 = g_pjbm_d_t.pjbm014
                  CALL apjm250_apjm014_desc()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm014
            #add-point:BEFORE FIELD pjbm014 name="input.b.page1.pjbm014"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm014
            #add-point:ON CHANGE pjbm014 name="input.g.page1.pjbm014"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pjbm_d[l_ac].pjbm015,"0","0","","","azz-00079",1) THEN
               NEXT FIELD pjbm015
            END IF 
 
 
 
            #add-point:AFTER FIELD pjbm015 name="input.a.page1.pjbm015"
                                                                                                                        IF NOT cl_null(g_pjbm_d[l_ac].pjbm015) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm015
            #add-point:BEFORE FIELD pjbm015 name="input.b.page1.pjbm015"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm015
            #add-point:ON CHANGE pjbm015 name="input.g.page1.pjbm015"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pjbm_d[l_ac].pjbm016,"0","0","","","azz-00079",1) THEN
               NEXT FIELD pjbm016
            END IF 
 
 
 
            #add-point:AFTER FIELD pjbm016 name="input.a.page1.pjbm016"
                                                                                                                        IF NOT cl_null(g_pjbm_d[l_ac].pjbm016) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm016
            #add-point:BEFORE FIELD pjbm016 name="input.b.page1.pjbm016"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm016
            #add-point:ON CHANGE pjbm016 name="input.g.page1.pjbm016"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm017
            #add-point:BEFORE FIELD pjbm017 name="input.b.page1.pjbm017"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm017
            
            #add-point:AFTER FIELD pjbm017 name="input.a.page1.pjbm017"
                                                                                                            IF NOT cl_null(g_pjbm_d[l_ac].pjbm017) AND NOT cl_null(g_pjbm_d[l_ac].pjbm018) THEN
               IF g_pjbm_d[l_ac].pjbm017 > g_pjbm_d[l_ac].pjbm018 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "axm-00106"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pjbm_d[l_ac].pjbm017 = g_pjbm_d_t.pjbm017
                  NEXT FIELD pjbm017
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm017
            #add-point:ON CHANGE pjbm017 name="input.g.page1.pjbm017"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbm018
            #add-point:BEFORE FIELD pjbm018 name="input.b.page1.pjbm018"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbm018
            
            #add-point:AFTER FIELD pjbm018 name="input.a.page1.pjbm018"
                                                                                                            IF NOT cl_null(g_pjbm_d[l_ac].pjbm017) AND NOT cl_null(g_pjbm_d[l_ac].pjbm018) THEN
               IF g_pjbm_d[l_ac].pjbm017 > g_pjbm_d[l_ac].pjbm018 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "axm-00107"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pjbm_d[l_ac].pjbm018 = g_pjbm_d_t.pjbm018
                  NEXT FIELD pjbm018
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbm018
            #add-point:ON CHANGE pjbm018 name="input.g.page1.pjbm018"
                                                                                                            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pjbm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm002
            #add-point:ON ACTION controlp INFIELD pjbm002 name="input.c.page1.pjbm002"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbml004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbml004
            #add-point:ON ACTION controlp INFIELD pjbml004 name="input.c.page1.pjbml004"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbml005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbml005
            #add-point:ON ACTION controlp INFIELD pjbml005 name="input.c.page1.pjbml005"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm003
            #add-point:ON ACTION controlp INFIELD pjbm003 name="input.c.page1.pjbm003"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.default1 = g_pjbm_d[l_ac].pjbm003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "8004"

            CALL q_oocq002()                                #呼叫開窗

            LET g_pjbm_d[l_ac].pjbm003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbm_d[l_ac].pjbm003 TO pjbm003              #顯示到畫面上

            NEXT FIELD pjbm003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm004
            #add-point:ON ACTION controlp INFIELD pjbm004 name="input.c.page1.pjbm004"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
           
            LET g_qryparam.default1 = g_pjbm_d[l_ac].pjbm004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pjba_m.pjba005

            CALL q_ooeg001()                                #呼叫開窗

            LET g_pjbm_d[l_ac].pjbm004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbm_d[l_ac].pjbm004 TO pjbm004              #顯示到畫面上

            NEXT FIELD pjbm004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm005
            #add-point:ON ACTION controlp INFIELD pjbm005 name="input.c.page1.pjbm005"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbm_d[l_ac].pjbm005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pjba_m.pjba001
            CALL q_pjbm01_1()                                #呼叫開窗

            LET g_pjbm_d[l_ac].pjbm005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbm_d[l_ac].pjbm005 TO pjbm005              #顯示到畫面上

            NEXT FIELD pjbm005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm006
            #add-point:ON ACTION controlp INFIELD pjbm006 name="input.c.page1.pjbm006"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm007
            #add-point:ON ACTION controlp INFIELD pjbm007 name="input.c.page1.pjbm007"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbm_d[l_ac].pjbm007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pjba_m.pjba001
            CALL q_pjbm01_1()                                #呼叫開窗

            LET g_pjbm_d[l_ac].pjbm007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbm_d[l_ac].pjbm007 TO pjbm007              #顯示到畫面上

            NEXT FIELD pjbm007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm008
            #add-point:ON ACTION controlp INFIELD pjbm008 name="input.c.page1.pjbm008"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm009
            #add-point:ON ACTION controlp INFIELD pjbm009 name="input.c.page1.pjbm009"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbm_d[l_ac].pjbm009             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_pjbm_d[l_ac].pjbm009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbm_d[l_ac].pjbm009 TO pjbm009              #顯示到畫面上

            NEXT FIELD pjbm009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm010
            #add-point:ON ACTION controlp INFIELD pjbm010 name="input.c.page1.pjbm010"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbm_d[l_ac].pjbm010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pjba_m.pjba005

            CALL q_ooeg001()                                #呼叫開窗

            LET g_pjbm_d[l_ac].pjbm010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbm_d[l_ac].pjbm010 TO pjbm010              #顯示到畫面上

            NEXT FIELD pjbm010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm011
            #add-point:ON ACTION controlp INFIELD pjbm011 name="input.c.page1.pjbm011"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbm_d[l_ac].pjbm011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pjba_m.pjba001 #

            CALL q_pjbb002_2()                                #呼叫開窗

            LET g_pjbm_d[l_ac].pjbm011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbm_d[l_ac].pjbm011 TO pjbm011              #顯示到畫面上

            NEXT FIELD pjbm011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm012
            #add-point:ON ACTION controlp INFIELD pjbm012 name="input.c.page1.pjbm012"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm013
            #add-point:ON ACTION controlp INFIELD pjbm013 name="input.c.page1.pjbm013"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.default1 = g_pjbm_d[l_ac].pjbm013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "8005"

            CALL q_oocq002()                                #呼叫開窗

            LET g_pjbm_d[l_ac].pjbm013 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbm_d[l_ac].pjbm013 TO pjbm013              #顯示到畫面上

            NEXT FIELD pjbm013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm014
            #add-point:ON ACTION controlp INFIELD pjbm014 name="input.c.page1.pjbm014"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.default1 = g_pjbm_d[l_ac].pjbm014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "8005"

            CALL q_oocq002()                                #呼叫開窗

            LET g_pjbm_d[l_ac].pjbm014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbm_d[l_ac].pjbm014 TO pjbm014              #顯示到畫面上

            NEXT FIELD pjbm014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm015
            #add-point:ON ACTION controlp INFIELD pjbm015 name="input.c.page1.pjbm015"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm016
            #add-point:ON ACTION controlp INFIELD pjbm016 name="input.c.page1.pjbm016"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm017
            #add-point:ON ACTION controlp INFIELD pjbm017 name="input.c.page1.pjbm017"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbm018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbm018
            #add-point:ON ACTION controlp INFIELD pjbm018 name="input.c.page1.pjbm018"
                                                                                                            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pjbm_d[l_ac].* = g_pjbm_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apjm250_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pjbm_d[l_ac].pjbm002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_pjbm_d[l_ac].* = g_pjbm_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
                                                                                          UPDATE pjba_t SET pjbamodid = g_user,
                                 pjbamoddt=g_pjba_m.pjbamoddt
                WHERE pjbaent = g_enterprise AND pjba001 = g_pjba_m.pjba001                                            
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL apjm250_pjbm_t_mask_restore('restore_mask_o')
      
               UPDATE pjbm_t SET (pjbm001,pjbm002,pjbm003,pjbm004,pjbm005,pjbm006,pjbm007,pjbm008,pjbm009, 
                   pjbm010,pjbm011,pjbm012,pjbm013,pjbm014,pjbm015,pjbm016,pjbm017,pjbm018) = (g_pjba_m.pjba001, 
                   g_pjbm_d[l_ac].pjbm002,g_pjbm_d[l_ac].pjbm003,g_pjbm_d[l_ac].pjbm004,g_pjbm_d[l_ac].pjbm005, 
                   g_pjbm_d[l_ac].pjbm006,g_pjbm_d[l_ac].pjbm007,g_pjbm_d[l_ac].pjbm008,g_pjbm_d[l_ac].pjbm009, 
                   g_pjbm_d[l_ac].pjbm010,g_pjbm_d[l_ac].pjbm011,g_pjbm_d[l_ac].pjbm012,g_pjbm_d[l_ac].pjbm013, 
                   g_pjbm_d[l_ac].pjbm014,g_pjbm_d[l_ac].pjbm015,g_pjbm_d[l_ac].pjbm016,g_pjbm_d[l_ac].pjbm017, 
                   g_pjbm_d[l_ac].pjbm018)
                WHERE pjbment = g_enterprise AND pjbm001 = g_pjba_m.pjba001 
 
                  AND pjbm002 = g_pjbm_d_t.pjbm002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                                                                                                      
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_pjbm_d[l_ac].* = g_pjbm_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pjbm_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_pjbm_d[l_ac].* = g_pjbm_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pjbm_t:",SQLERRMESSAGE 
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
         IF g_pjba_m.pjba001 = g_detail_multi_table_t.pjbml001 AND
         g_pjbm_d[l_ac].pjbm002 = g_detail_multi_table_t.pjbml002 AND
         g_pjbm_d[l_ac].pjbml004 = g_detail_multi_table_t.pjbml004 AND
         g_pjbm_d[l_ac].pjbml005 = g_detail_multi_table_t.pjbml005 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'pjbmlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_pjba_m.pjba001
            LET l_field_keys[02] = 'pjbml001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.pjbml001
            LET l_var_keys[03] = g_pjbm_d[l_ac].pjbm002
            LET l_field_keys[03] = 'pjbml002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.pjbml002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'pjbml003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.pjbml003
            LET l_vars[01] = g_pjbm_d[l_ac].pjbml004
            LET l_fields[01] = 'pjbml004'
            LET l_vars[02] = g_pjbm_d[l_ac].pjbml005
            LET l_fields[02] = 'pjbml005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pjbml_t')
         END IF 
 
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pjba_m.pjba001
               LET gs_keys_bak[1] = g_pjba001_t
               LET gs_keys[2] = g_pjbm_d[g_detail_idx].pjbm002
               LET gs_keys_bak[2] = g_pjbm_d_t.pjbm002
               CALL apjm250_update_b('pjbm_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL apjm250_pjbm_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_pjbm_d[g_detail_idx].pjbm002 = g_pjbm_d_t.pjbm002 
 
                  ) THEN
                  LET gs_keys[01] = g_pjba_m.pjba001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pjbm_d_t.pjbm002
 
                  CALL apjm250_key_update_b(gs_keys,'pjbm_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pjba_m),util.JSON.stringify(g_pjbm_d_t)
               LET g_log2 = util.JSON.stringify(g_pjba_m),util.JSON.stringify(g_pjbm_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
                                                                                                                                       
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
                                                                                                                        
            #end add-point
            CALL apjm250_unlock_b("pjbm_t","'1'")
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
               LET g_pjbm_d[li_reproduce_target].* = g_pjbm_d[li_reproduce].*
 
               LET g_pjbm_d[li_reproduce_target].pjbm002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pjbm_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pjbm_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="apjm250.input.other" >}
      
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
            NEXT FIELD pjba001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pjbm002
 
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
 
{<section id="apjm250.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apjm250_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
                           
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
                           
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL apjm250_b_fill() #單身填充
      CALL apjm250_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apjm250_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#                              INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_pjba_m.pjba001
#   CALL ap_ref_array2(g_ref_fields," SELECT pjbal003 FROM pjbal_t WHERE pjbalent = '"||g_enterprise||"' AND pjbal001 = ? AND pjbal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
#   LET g_pjba_m.pjbal003 = g_rtn_fields[1] 
#   DISPLAY g_pjba_m.pjbal003 TO pjbal003
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjba_m.pjba000
#            CALL ap_ref_array2(g_ref_fields,"SELECT pjaal003 FROM pjaal_t WHERE pjaalent='"||g_enterprise||"' AND pjaal001=? AND pjaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pjba_m.pjba000_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjba_m.pjba000_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjba_m.pjba003
#            CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pjba_m.pjba003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjba_m.pjba003_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjba_m.pjba004
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pjba_m.pjba004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjba_m.pjba004_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjba_m.pjbaownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pjba_m.pjbaownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjba_m.pjbaownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjba_m.pjbaowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pjba_m.pjbaowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjba_m.pjbaowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjba_m.pjbacrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pjba_m.pjbacrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjba_m.pjbacrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjba_m.pjbacrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pjba_m.pjbacrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjba_m.pjbacrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjba_m.pjbamodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pjba_m.pjbamodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjba_m.pjbamodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjba_m.pjbacnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pjba_m.pjbacnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjba_m.pjbacnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_pjba_m_mask_o.* =  g_pjba_m.*
   CALL apjm250_pjba_t_mask()
   LET g_pjba_m_mask_n.* =  g_pjba_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pjba_m.pjba000,g_pjba_m.pjba000_desc,g_pjba_m.pjba001,g_pjba_m.pjba002,g_pjba_m.pjbal003, 
       g_pjba_m.pjbal004,g_pjba_m.pjba009,g_pjba_m.pjba003,g_pjba_m.pjba003_desc,g_pjba_m.pjba004,g_pjba_m.pjba004_desc, 
       g_pjba_m.pjba005,g_pjba_m.pjba006,g_pjba_m.pjba010,g_pjba_m.pjba010_desc,g_pjba_m.pjba011,g_pjba_m.pjba012, 
       g_pjba_m.pjba012_desc,g_pjba_m.pjba013,g_pjba_m.pjba014,g_pjba_m.pjba014_desc,g_pjba_m.pjbastus, 
       g_pjba_m.pjbaownid,g_pjba_m.pjbaownid_desc,g_pjba_m.pjbaowndp,g_pjba_m.pjbaowndp_desc,g_pjba_m.pjbacrtid, 
       g_pjba_m.pjbacrtid_desc,g_pjba_m.pjbacrtdp,g_pjba_m.pjbacrtdp_desc,g_pjba_m.pjbacrtdt,g_pjba_m.pjbamodid, 
       g_pjba_m.pjbamodid_desc,g_pjba_m.pjbamoddt,g_pjba_m.pjbacnfid,g_pjba_m.pjbacnfid_desc,g_pjba_m.pjbacnfdt, 
       g_pjba_m.date1,g_pjba_m.pjbm019,g_pjba_m.pjbm021,g_pjba_m.pjbm023,g_pjba_m.date2,g_pjba_m.pjbm020, 
       g_pjba_m.pjbm022,g_pjba_m.pjbm024,g_pjba_m.pjbm025,g_pjba_m.pjbm026,g_pjba_m.pjbm027,g_pjba_m.pjbm028, 
       g_pjba_m.pjbm028_desc,g_pjba_m.pjbm029
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pjba_m.pjbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_pjbm_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
#                                                                  INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjbm_d[l_ac].pjbm003
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8004' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pjbm_d[l_ac].pjbm003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjbm_d[l_ac].pjbm003_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjbm_d[l_ac].pjbm004
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pjbm_d[l_ac].pjbm004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjbm_d[l_ac].pjbm004_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjba_m.pjba001
            LET g_ref_fields[2] = g_pjbm_d[l_ac].pjbm005
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbml004 FROM pjbml_t WHERE pjbmlent='"||g_enterprise||"' AND pjbml001=? AND pjbml002=? AND pjbml003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbm_d[l_ac].pjbm005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbm_d[l_ac].pjbm005_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjba_m.pjba001
            LET g_ref_fields[2] = g_pjbm_d[l_ac].pjbm007
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbml004 FROM pjbml_t WHERE pjbmlent='"||g_enterprise||"' AND pjbml001=? AND pjbml002=? AND pjbml003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbm_d[l_ac].pjbm007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbm_d[l_ac].pjbm007_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjbm_d[l_ac].pjbm009
#            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t,ooag_t WHERE oofaent='"||g_enterprise||"' AND oofa001=ooag002 AND ooag001=? AND ooagent='"||g_enterprise||"' ","") RETURNING g_rtn_fields
#            LET g_pjbm_d[l_ac].pjbm009_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjbm_d[l_ac].pjbm009_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjbm_d[l_ac].pjbm010
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pjbm_d[l_ac].pjbm010_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjbm_d[l_ac].pjbm010_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjba_m.pjba001
            LET g_ref_fields[2] = g_pjbm_d[l_ac].pjbm011
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbm_d[l_ac].pjbm011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbm_d[l_ac].pjbm011_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjbm_d[l_ac].pjbm013
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8005' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pjbm_d[l_ac].pjbm013_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjbm_d[l_ac].pjbm013_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pjbm_d[l_ac].pjbm014
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8005' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pjbm_d[l_ac].pjbm014_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_pjbm_d[l_ac].pjbm014_desc

   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_pjba_m.pjba001
   LET g_ref_fields[2] = g_pjbm_d[l_ac].pjbm002
   CALL ap_ref_array2(g_ref_fields," SELECT pjbml004,pjbml005 FROM pjbml_t WHERE pjbmlent = '"||g_enterprise||"' AND pjbml001 = ? AND pjbml002 = ? AND pjbml003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_pjbm_d[l_ac].pjbml004 = g_rtn_fields[1] 
   LET g_pjbm_d[l_ac].pjbml005 = g_rtn_fields[2] 
   DISPLAY BY NAME g_pjbm_d[l_ac].pjbml004,g_pjbm_d[l_ac].pjbml005
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
               DISPLAY g_pjbm_d[1].pjbm017 TO FORMONLY.date1
   DISPLAY g_pjbm_d[1].pjbm018 TO FORMONLY.date2
   SELECT pjbm019,pjbm020,pjbm021,pjbm022,pjbm023,pjbm024,
          pjbm025,pjbm026,pjbm027,pjbm028,pjbm029
     INTO g_pjba_m.pjbm019,g_pjba_m.pjbm020,g_pjba_m.pjbm021,g_pjba_m.pjbm022,
          g_pjba_m.pjbm023,g_pjba_m.pjbm024,g_pjba_m.pjbm025,g_pjba_m.pjbm026,
          g_pjba_m.pjbm027,g_pjba_m.pjbm028,g_pjba_m.pjbm029          
     FROM pjbm_t 
    WHERE pjbment = g_enterprise 
      AND pjbm001 = g_pjba_m.pjba001
      AND pjbm002 = g_pjbm_d[1].pjbm002
      INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjba_m.pjbm028
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t,ooag_t WHERE oofaent='"||g_enterprise||"' AND oofa001=ooag002 AND ooag001=? AND ooagent='"||g_enterprise||"' ","") RETURNING g_rtn_fields
   LET g_pjba_m.pjbm028_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjba_m.pjbm028_desc
   DISPLAY g_pjba_m.pjbm019 TO pjbm019
   DISPLAY g_pjba_m.pjbm020 TO pjbm020
   DISPLAY g_pjba_m.pjbm021 TO pjbm021
   DISPLAY g_pjba_m.pjbm022 TO pjbm022
   DISPLAY g_pjba_m.pjbm023 TO pjbm023
   DISPLAY g_pjba_m.pjbm024 TO pjbm024
   DISPLAY g_pjba_m.pjbm025 TO pjbm025
   DISPLAY g_pjba_m.pjbm026 TO pjbm026
   DISPLAY g_pjba_m.pjbm027 TO pjbm027
   DISPLAY g_pjba_m.pjbm028 TO pjbm028
   DISPLAY g_pjba_m.pjbm029 TO pjbm029
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL apjm250_detail_show()
 
   #add-point:show段之後 name="show.after"
                           
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apjm250.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION apjm250_detail_show()
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
 
{<section id="apjm250.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apjm250_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE pjba_t.pjba001 
   DEFINE l_oldno     LIKE pjba_t.pjba001 
 
   DEFINE l_master    RECORD LIKE pjba_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pjbm_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_pjba_m.pjba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_pjba001_t = g_pjba_m.pjba001
 
    
   LET g_pjba_m.pjba001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pjba_m.pjbaownid = g_user
      LET g_pjba_m.pjbaowndp = g_dept
      LET g_pjba_m.pjbacrtid = g_user
      LET g_pjba_m.pjbacrtdp = g_dept 
      LET g_pjba_m.pjbacrtdt = cl_get_current()
      LET g_pjba_m.pjbamodid = g_user
      LET g_pjba_m.pjbamoddt = cl_get_current()
      LET g_pjba_m.pjbastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
                           
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pjba_m.pjbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL apjm250_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_pjba_m.* TO NULL
      INITIALIZE g_pjbm_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL apjm250_show()
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
   CALL apjm250_set_act_visible()   
   CALL apjm250_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pjba001_t = g_pjba_m.pjba001
 
   
   #組合新增資料的條件
   LET g_add_browse = " pjbaent = " ||g_enterprise|| " AND",
                      " pjba001 = '", g_pjba_m.pjba001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apjm250_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
                           
   #end add-point
   
   CALL apjm250_idx_chk()
   
   LET g_data_owner = g_pjba_m.pjbaownid      
   LET g_data_dept  = g_pjba_m.pjbaowndp
   
   #功能已完成,通報訊息中心
   CALL apjm250_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="apjm250.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apjm250_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pjbm_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
                           
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apjm250_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
                           
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pjbm_t
    WHERE pjbment = g_enterprise AND pjbm001 = g_pjba001_t
 
    INTO TEMP apjm250_detail
 
   #將key修正為調整後   
   UPDATE apjm250_detail 
      #更新key欄位
      SET pjbm001 = g_pjba_m.pjba001
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO pjbm_t SELECT * FROM apjm250_detail
   
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
   DROP TABLE apjm250_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
                           
   #end add-point
 
 
   
 
   
   #多語言複製段落
      #應用 a38 樣板自動產生(Version:6)
   #單身多語言複製
   DROP TABLE apjm250_detail_lang
   
   #add-point:單身複製前1 name="detail_reproduce.body.lang0.b_insert"
                           
   #end add-point
   
   #CREATE TEMP TABLE & INSERT 
   SELECT * FROM pjbml_t 
    WHERE pjbmlent = g_enterprise AND pjbml001 = g_pjba001_t
 
     INTO TEMP apjm250_detail_lang
 
   #將key修正為調整後   
   UPDATE apjm250_detail_lang 
      #更新key欄位
      SET pjbml001 = g_pjba_m.pjba001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.lang0.b_update"
   
   #end add-point   
  
   #將資料塞回原table   
   INSERT INTO pjbml_t SELECT * FROM apjm250_detail_lang
   
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
   DROP TABLE apjm250_detail_lang
   
   #add-point:單身複製後1 name="detail_reproduce.lang0.table1.a_insert"
                           
   #end add-point
 
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pjba001_t = g_pjba_m.pjba001
 
   
END FUNCTION
 
{</section>}
 
{<section id="apjm250.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apjm250_delete()
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
   
   IF g_pjba_m.pjba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.pjbal001 = g_pjba_m.pjba001
LET g_master_multi_table_t.pjbal003 = g_pjba_m.pjbal003
LET g_master_multi_table_t.pjbal004 = g_pjba_m.pjbal004
 
   
   CALL s_transaction_begin()
 
   OPEN apjm250_cl USING g_enterprise,g_pjba_m.pjba001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apjm250_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apjm250_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apjm250_master_referesh USING g_pjba_m.pjba001 INTO g_pjba_m.pjba000,g_pjba_m.pjba001,g_pjba_m.pjba002, 
       g_pjba_m.pjba009,g_pjba_m.pjba003,g_pjba_m.pjba004,g_pjba_m.pjba005,g_pjba_m.pjba006,g_pjba_m.pjba010, 
       g_pjba_m.pjba011,g_pjba_m.pjba012,g_pjba_m.pjba013,g_pjba_m.pjba014,g_pjba_m.pjbastus,g_pjba_m.pjbaownid, 
       g_pjba_m.pjbaowndp,g_pjba_m.pjbacrtid,g_pjba_m.pjbacrtdp,g_pjba_m.pjbacrtdt,g_pjba_m.pjbamodid, 
       g_pjba_m.pjbamoddt,g_pjba_m.pjbacnfid,g_pjba_m.pjbacnfdt,g_pjba_m.pjba000_desc,g_pjba_m.pjba003_desc, 
       g_pjba_m.pjba004_desc,g_pjba_m.pjba010_desc,g_pjba_m.pjba012_desc,g_pjba_m.pjba014_desc,g_pjba_m.pjbaownid_desc, 
       g_pjba_m.pjbaowndp_desc,g_pjba_m.pjbacrtid_desc,g_pjba_m.pjbacrtdp_desc,g_pjba_m.pjbamodid_desc, 
       g_pjba_m.pjbacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT apjm250_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pjba_m_mask_o.* =  g_pjba_m.*
   CALL apjm250_pjba_t_mask()
   LET g_pjba_m_mask_n.* =  g_pjba_m.*
   
   CALL apjm250_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
                                                      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apjm250_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_pjba001_t = g_pjba_m.pjba001
 
 
      DELETE FROM pjba_t
       WHERE pjbaent = g_enterprise AND pjba001 = g_pjba_m.pjba001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
                                                      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_pjba_m.pjba001,":",SQLERRMESSAGE  
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
      
      DELETE FROM pjbm_t
       WHERE pjbment = g_enterprise AND pjbm001 = g_pjba_m.pjba001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
                                                      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pjbm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
                                                      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pjba_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE apjm250_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_pjbm_d.clear() 
 
     
      CALL apjm250_ui_browser_refresh()  
      #CALL apjm250_ui_headershow()  
      #CALL apjm250_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'pjbalent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.pjbal001
   LET l_field_keys[02] = 'pjbal001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'pjbal_t')
 
      
      #單身多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
         INITIALIZE l_field_keys TO NULL 
         LET l_field_keys[01] = 'pjbmlent'
         LET l_var_keys_bak[01] = g_enterprise
         LET l_field_keys[02] = 'pjbml001'
         LET l_var_keys_bak[02] = g_pjba_m.pjba001
         CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'pjbml_t')
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL apjm250_browser_fill("")
         CALL apjm250_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apjm250_cl
 
   #功能已完成,通報訊息中心
   CALL apjm250_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apjm250.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apjm250_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
                           
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_pjbm_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
                           
   #end add-point
   
   #判斷是否填充
   IF apjm250_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pjbm002,pjbm003,pjbm004,pjbm005,pjbm006,pjbm007,pjbm008,pjbm009, 
             pjbm010,pjbm011,pjbm012,pjbm013,pjbm014,pjbm015,pjbm016,pjbm017,pjbm018 ,t1.oocql004 ,t2.ooefl003 , 
             t5.ooag011 ,t6.ooefl003 ,t8.oocql004 ,t9.oocql004 FROM pjbm_t",   
                     " INNER JOIN pjba_t ON pjbaent = " ||g_enterprise|| " AND pjba001 = pjbm001 ",
 
                     #" LEFT JOIN pjbml_t ON pjbmlent = "||g_enterprise||" AND pjba001 = pjbml001 AND pjbm002 = pjbml002 AND pjbml003 = '",g_dlang,"'",
                     
                     " LEFT JOIN pjbml_t ON pjbmlent = "||g_enterprise||" AND pjba001 = pjbml001 AND pjbm002 = pjbml002 AND pjbml003 = '",g_dlang,"'",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='8004' AND t1.oocql002=pjbm003 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=pjbm004 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=pjbm009  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=pjbm010 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='8005' AND t8.oocql002=pjbm013 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='8005' AND t9.oocql002=pjbm014 AND t9.oocql003='"||g_dlang||"' ",
 
                     " WHERE pjbment=? AND pjbm001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
                                                      
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY pjbm_t.pjbm002"
         
         #add-point:單身填充控制 name="b_fill.sql"
                                                      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apjm250_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apjm250_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pjba_m.pjba001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pjba_m.pjba001 INTO g_pjbm_d[l_ac].pjbm002,g_pjbm_d[l_ac].pjbm003, 
          g_pjbm_d[l_ac].pjbm004,g_pjbm_d[l_ac].pjbm005,g_pjbm_d[l_ac].pjbm006,g_pjbm_d[l_ac].pjbm007, 
          g_pjbm_d[l_ac].pjbm008,g_pjbm_d[l_ac].pjbm009,g_pjbm_d[l_ac].pjbm010,g_pjbm_d[l_ac].pjbm011, 
          g_pjbm_d[l_ac].pjbm012,g_pjbm_d[l_ac].pjbm013,g_pjbm_d[l_ac].pjbm014,g_pjbm_d[l_ac].pjbm015, 
          g_pjbm_d[l_ac].pjbm016,g_pjbm_d[l_ac].pjbm017,g_pjbm_d[l_ac].pjbm018,g_pjbm_d[l_ac].pjbm003_desc, 
          g_pjbm_d[l_ac].pjbm004_desc,g_pjbm_d[l_ac].pjbm009_desc,g_pjbm_d[l_ac].pjbm010_desc,g_pjbm_d[l_ac].pjbm013_desc, 
          g_pjbm_d[l_ac].pjbm014_desc   #(ver:78)
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
   
   CALL g_pjbm_d.deleteElement(g_pjbm_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE apjm250_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_pjbm_d.getLength()
      LET g_pjbm_d_mask_o[l_ac].* =  g_pjbm_d[l_ac].*
      CALL apjm250_pjbm_t_mask()
      LET g_pjbm_d_mask_n[l_ac].* =  g_pjbm_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="apjm250.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apjm250_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM pjbm_t
       WHERE pjbment = g_enterprise AND
         pjbm001 = ps_keys_bak[1] AND pjbm002 = ps_keys_bak[2]
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
         CALL g_pjbm_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
                           
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apjm250.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apjm250_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO pjbm_t
                  (pjbment,
                   pjbm001,
                   pjbm002
                   ,pjbm003,pjbm004,pjbm005,pjbm006,pjbm007,pjbm008,pjbm009,pjbm010,pjbm011,pjbm012,pjbm013,pjbm014,pjbm015,pjbm016,pjbm017,pjbm018) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_pjbm_d[g_detail_idx].pjbm003,g_pjbm_d[g_detail_idx].pjbm004,g_pjbm_d[g_detail_idx].pjbm005, 
                       g_pjbm_d[g_detail_idx].pjbm006,g_pjbm_d[g_detail_idx].pjbm007,g_pjbm_d[g_detail_idx].pjbm008, 
                       g_pjbm_d[g_detail_idx].pjbm009,g_pjbm_d[g_detail_idx].pjbm010,g_pjbm_d[g_detail_idx].pjbm011, 
                       g_pjbm_d[g_detail_idx].pjbm012,g_pjbm_d[g_detail_idx].pjbm013,g_pjbm_d[g_detail_idx].pjbm014, 
                       g_pjbm_d[g_detail_idx].pjbm015,g_pjbm_d[g_detail_idx].pjbm016,g_pjbm_d[g_detail_idx].pjbm017, 
                       g_pjbm_d[g_detail_idx].pjbm018)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
                                                      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pjbm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_pjbm_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
                                                            UPDATE pjbm_t SET pjbm029='0' WHERE pjbment=g_enterprise AND pjbm001=ps_keys[1] AND pjbm002 = ps_keys[2]
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
                           
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="apjm250.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apjm250_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pjbm_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
                                                      
      #end add-point 
      
      #將遮罩欄位還原
      CALL apjm250_pjbm_t_mask_restore('restore_mask_o')
               
      UPDATE pjbm_t 
         SET (pjbm001,
              pjbm002
              ,pjbm003,pjbm004,pjbm005,pjbm006,pjbm007,pjbm008,pjbm009,pjbm010,pjbm011,pjbm012,pjbm013,pjbm014,pjbm015,pjbm016,pjbm017,pjbm018) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_pjbm_d[g_detail_idx].pjbm003,g_pjbm_d[g_detail_idx].pjbm004,g_pjbm_d[g_detail_idx].pjbm005, 
                  g_pjbm_d[g_detail_idx].pjbm006,g_pjbm_d[g_detail_idx].pjbm007,g_pjbm_d[g_detail_idx].pjbm008, 
                  g_pjbm_d[g_detail_idx].pjbm009,g_pjbm_d[g_detail_idx].pjbm010,g_pjbm_d[g_detail_idx].pjbm011, 
                  g_pjbm_d[g_detail_idx].pjbm012,g_pjbm_d[g_detail_idx].pjbm013,g_pjbm_d[g_detail_idx].pjbm014, 
                  g_pjbm_d[g_detail_idx].pjbm015,g_pjbm_d[g_detail_idx].pjbm016,g_pjbm_d[g_detail_idx].pjbm017, 
                  g_pjbm_d[g_detail_idx].pjbm018) 
         WHERE pjbment = g_enterprise AND pjbm001 = ps_keys_bak[1] AND pjbm002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
                                                      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pjbm_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pjbm_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apjm250_pjbm_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
                                                      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'pjbmlent'
LET l_new_key[02] = ps_keys[1] 
LET l_old_key[02] = ps_keys_bak[1] 
LET l_field_key[02] = 'pjbml001'
LET l_new_key[03] = ps_keys[2] 
LET l_old_key[03] = ps_keys_bak[2] 
LET l_field_key[03] = 'pjbml002'
LET l_new_key[04] = g_dlang 
LET l_old_key[04] = g_dlang 
LET l_field_key[04] = 'pjbml003'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'pjbml_t')
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
                           
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apjm250.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION apjm250_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="apjm250.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apjm250_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apjm250.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apjm250_lock_b(ps_table,ps_page)
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
   #CALL apjm250_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "pjbm_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apjm250_bcl USING g_enterprise,
                                       g_pjba_m.pjba001,g_pjbm_d[g_detail_idx].pjbm002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apjm250_bcl:",SQLERRMESSAGE 
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
 
{<section id="apjm250.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apjm250_unlock_b(ps_table,ps_page)
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
      CLOSE apjm250_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
                           
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="apjm250.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apjm250_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
                           
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pjba001",TRUE)
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
 
{<section id="apjm250.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apjm250_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
                           
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pjba001",FALSE)
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
 
{<section id="apjm250.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apjm250_set_entry_b(p_cmd)
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
 
{<section id="apjm250.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apjm250_set_no_entry_b(p_cmd)
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
 
{<section id="apjm250.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apjm250_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apjm250.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apjm250_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apjm250.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apjm250_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
  
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   CALL cl_set_act_visible("modify,modify_detail",TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apjm250.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apjm250_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   IF NOT cl_null( g_pjba_m.pjbm029) AND g_pjba_m.pjbm029 != '0' THEN
      CALL cl_set_act_visible("modify,modify_detail",FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apjm250.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apjm250_default_search()
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
      LET ls_wc = ls_wc, " pjba001 = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "pjba_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "pjbm_t" 
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
   IF g_wc = " 1=1" THEN 
#      LET g_wc = " pjba000 IN (SELECT pjaa001 FROM pjaa_t WHERE pjaa010='Y' AND pjaastus='Y') " #160905-00007#3 marked
      LET g_wc = " pjba000 IN (SELECT pjaa001 FROM pjaa_t WHERE pjaa010='Y' AND pjaastus='Y' AND pjaaent = ",g_enterprise,") " #160905-00007#3 mod
   ELSE
#      LET g_wc = g_wc," AND pjba000 IN (SELECT pjaa001 FROM pjaa_t WHERE pjaa010='Y' AND pjaastus='Y') " #160905-00007#3 marked
      LET g_wc = g_wc," AND pjba000 IN (SELECT pjaa001 FROM pjaa_t WHERE pjaa010='Y' AND pjaastus='Y' AND pjaaent = ",g_enterprise,") " #160905-00007#3 mod
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="apjm250.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION apjm250_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
                           
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
                           
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_pjba_m.pjba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN apjm250_cl USING g_enterprise,g_pjba_m.pjba001
   IF STATUS THEN
      CLOSE apjm250_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apjm250_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE apjm250_master_referesh USING g_pjba_m.pjba001 INTO g_pjba_m.pjba000,g_pjba_m.pjba001,g_pjba_m.pjba002, 
       g_pjba_m.pjba009,g_pjba_m.pjba003,g_pjba_m.pjba004,g_pjba_m.pjba005,g_pjba_m.pjba006,g_pjba_m.pjba010, 
       g_pjba_m.pjba011,g_pjba_m.pjba012,g_pjba_m.pjba013,g_pjba_m.pjba014,g_pjba_m.pjbastus,g_pjba_m.pjbaownid, 
       g_pjba_m.pjbaowndp,g_pjba_m.pjbacrtid,g_pjba_m.pjbacrtdp,g_pjba_m.pjbacrtdt,g_pjba_m.pjbamodid, 
       g_pjba_m.pjbamoddt,g_pjba_m.pjbacnfid,g_pjba_m.pjbacnfdt,g_pjba_m.pjba000_desc,g_pjba_m.pjba003_desc, 
       g_pjba_m.pjba004_desc,g_pjba_m.pjba010_desc,g_pjba_m.pjba012_desc,g_pjba_m.pjba014_desc,g_pjba_m.pjbaownid_desc, 
       g_pjba_m.pjbaowndp_desc,g_pjba_m.pjbacrtid_desc,g_pjba_m.pjbacrtdp_desc,g_pjba_m.pjbamodid_desc, 
       g_pjba_m.pjbacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT apjm250_action_chk() THEN
      CLOSE apjm250_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pjba_m.pjba000,g_pjba_m.pjba000_desc,g_pjba_m.pjba001,g_pjba_m.pjba002,g_pjba_m.pjbal003, 
       g_pjba_m.pjbal004,g_pjba_m.pjba009,g_pjba_m.pjba003,g_pjba_m.pjba003_desc,g_pjba_m.pjba004,g_pjba_m.pjba004_desc, 
       g_pjba_m.pjba005,g_pjba_m.pjba006,g_pjba_m.pjba010,g_pjba_m.pjba010_desc,g_pjba_m.pjba011,g_pjba_m.pjba012, 
       g_pjba_m.pjba012_desc,g_pjba_m.pjba013,g_pjba_m.pjba014,g_pjba_m.pjba014_desc,g_pjba_m.pjbastus, 
       g_pjba_m.pjbaownid,g_pjba_m.pjbaownid_desc,g_pjba_m.pjbaowndp,g_pjba_m.pjbaowndp_desc,g_pjba_m.pjbacrtid, 
       g_pjba_m.pjbacrtid_desc,g_pjba_m.pjbacrtdp,g_pjba_m.pjbacrtdp_desc,g_pjba_m.pjbacrtdt,g_pjba_m.pjbamodid, 
       g_pjba_m.pjbamodid_desc,g_pjba_m.pjbamoddt,g_pjba_m.pjbacnfid,g_pjba_m.pjbacnfid_desc,g_pjba_m.pjbacnfdt, 
       g_pjba_m.date1,g_pjba_m.pjbm019,g_pjba_m.pjbm021,g_pjba_m.pjbm023,g_pjba_m.date2,g_pjba_m.pjbm020, 
       g_pjba_m.pjbm022,g_pjba_m.pjbm024,g_pjba_m.pjbm025,g_pjba_m.pjbm026,g_pjba_m.pjbm027,g_pjba_m.pjbm028, 
       g_pjba_m.pjbm028_desc,g_pjba_m.pjbm029
 
   CASE g_pjba_m.pjbastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_pjba_m.pjbastus
            
            WHEN "N"
               HIDE OPTION "open"
            WHEN "Y"
               HIDE OPTION "valid"
            WHEN "X"
               HIDE OPTION "void"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
                                                      
      #end add-point
      
      
	  
      ON ACTION open
         IF cl_auth_chk_act("open") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.open"
                                                                                 
            #end add-point
         END IF
         EXIT MENU
      ON ACTION valid
         IF cl_auth_chk_act("valid") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.valid"
                                                                                 
            #end add-point
         END IF
         EXIT MENU
      ON ACTION void
         IF cl_auth_chk_act("void") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.void"
                                                                                 
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
                                                      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_pjba_m.pjbastus = lc_state OR cl_null(lc_state) THEN
      CLOSE apjm250_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
               CALL s_transaction_begin()
   IF lc_state = "Y" THEN
      IF g_pjba_m.pjbastus != 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "apj-00026"
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
         RETURN
      END IF
      IF cl_ask_confirm('apj-00030') THEN
         LET g_pjba_m.pjbacnfid = g_user
         LET g_pjba_m.pjbacnfdt = cl_get_current()
         UPDATE pjba_t SET pjbacnfid = g_pjba_m.pjbacnfid,
                           pjbacnfdt = g_pjba_m.pjbacnfdt
          WHERE pjbaent = g_enterprise AND pjba001 = g_pjba_m.pjba001
      ELSE
         CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
         RETURN
      END IF
   END IF
   IF lc_state = "N" THEN
      IF g_pjba_m.pjbastus = 'Y' THEN
         IF cl_ask_confirm('apj-00029') THEN
            LET g_pjba_m.pjbacnfid = g_user
            LET g_pjba_m.pjbacnfdt = cl_get_current()
            UPDATE pjba_t SET pjbacnfid = '',
                              pjbacnfdt = ''
             WHERE pjbaent = g_enterprise AND pjba001 = g_pjba_m.pjba001
         ELSE
            CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
            RETURN
         END IF
      END IF
      IF g_pjba_m.pjbastus = 'X' THEN
         IF cl_ask_confirm('apj-00028') THEN
            LET g_pjba_m.pjbacnfid = g_user
            LET g_pjba_m.pjbacnfdt = cl_get_current()
            UPDATE pjba_t SET pjbacnfid = '',
                              pjbacnfdt = ''
             WHERE pjbaent = g_enterprise AND pjba001 = g_pjba_m.pjba001
         ELSE
            CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
            RETURN
         END IF
      END IF
   END IF
   IF lc_state = "X" THEN
      IF g_pjba_m.pjbastus != 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "apj-00027"
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
         RETURN
      END IF
      IF NOT cl_ask_confirm('apj-00028') THEN
         CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
         RETURN
      END IF
   END IF
   #end add-point
   
   LET g_pjba_m.pjbamodid = g_user
   LET g_pjba_m.pjbamoddt = cl_get_current()
   LET g_pjba_m.pjbastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE pjba_t 
      SET (pjbastus,pjbamodid,pjbamoddt) 
        = (g_pjba_m.pjbastus,g_pjba_m.pjbamodid,g_pjba_m.pjbamoddt)     
    WHERE pjbaent = g_enterprise AND pjba001 = g_pjba_m.pjba001
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE apjm250_master_referesh USING g_pjba_m.pjba001 INTO g_pjba_m.pjba000,g_pjba_m.pjba001, 
          g_pjba_m.pjba002,g_pjba_m.pjba009,g_pjba_m.pjba003,g_pjba_m.pjba004,g_pjba_m.pjba005,g_pjba_m.pjba006, 
          g_pjba_m.pjba010,g_pjba_m.pjba011,g_pjba_m.pjba012,g_pjba_m.pjba013,g_pjba_m.pjba014,g_pjba_m.pjbastus, 
          g_pjba_m.pjbaownid,g_pjba_m.pjbaowndp,g_pjba_m.pjbacrtid,g_pjba_m.pjbacrtdp,g_pjba_m.pjbacrtdt, 
          g_pjba_m.pjbamodid,g_pjba_m.pjbamoddt,g_pjba_m.pjbacnfid,g_pjba_m.pjbacnfdt,g_pjba_m.pjba000_desc, 
          g_pjba_m.pjba003_desc,g_pjba_m.pjba004_desc,g_pjba_m.pjba010_desc,g_pjba_m.pjba012_desc,g_pjba_m.pjba014_desc, 
          g_pjba_m.pjbaownid_desc,g_pjba_m.pjbaowndp_desc,g_pjba_m.pjbacrtid_desc,g_pjba_m.pjbacrtdp_desc, 
          g_pjba_m.pjbamodid_desc,g_pjba_m.pjbacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_pjba_m.pjba000,g_pjba_m.pjba000_desc,g_pjba_m.pjba001,g_pjba_m.pjba002,g_pjba_m.pjbal003, 
          g_pjba_m.pjbal004,g_pjba_m.pjba009,g_pjba_m.pjba003,g_pjba_m.pjba003_desc,g_pjba_m.pjba004, 
          g_pjba_m.pjba004_desc,g_pjba_m.pjba005,g_pjba_m.pjba006,g_pjba_m.pjba010,g_pjba_m.pjba010_desc, 
          g_pjba_m.pjba011,g_pjba_m.pjba012,g_pjba_m.pjba012_desc,g_pjba_m.pjba013,g_pjba_m.pjba014, 
          g_pjba_m.pjba014_desc,g_pjba_m.pjbastus,g_pjba_m.pjbaownid,g_pjba_m.pjbaownid_desc,g_pjba_m.pjbaowndp, 
          g_pjba_m.pjbaowndp_desc,g_pjba_m.pjbacrtid,g_pjba_m.pjbacrtid_desc,g_pjba_m.pjbacrtdp,g_pjba_m.pjbacrtdp_desc, 
          g_pjba_m.pjbacrtdt,g_pjba_m.pjbamodid,g_pjba_m.pjbamodid_desc,g_pjba_m.pjbamoddt,g_pjba_m.pjbacnfid, 
          g_pjba_m.pjbacnfid_desc,g_pjba_m.pjbacnfdt,g_pjba_m.date1,g_pjba_m.pjbm019,g_pjba_m.pjbm021, 
          g_pjba_m.pjbm023,g_pjba_m.date2,g_pjba_m.pjbm020,g_pjba_m.pjbm022,g_pjba_m.pjbm024,g_pjba_m.pjbm025, 
          g_pjba_m.pjbm026,g_pjba_m.pjbm027,g_pjba_m.pjbm028,g_pjba_m.pjbm028_desc,g_pjba_m.pjbm029
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
            
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
                           
   #end add-point  
 
   CLOSE apjm250_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apjm250_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apjm250.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apjm250_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
                           
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_pjbm_d.getLength() THEN
         LET g_detail_idx = g_pjbm_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pjbm_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pjbm_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
                           
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apjm250.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apjm250_b_fill2(pi_idx)
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
   
   CALL apjm250_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="apjm250.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apjm250_fill_chk(ps_idx)
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
 
{<section id="apjm250.status_show" >}
PRIVATE FUNCTION apjm250_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apjm250.mask_functions" >}
&include "erp/apj/apjm250_mask.4gl"
 
{</section>}
 
{<section id="apjm250.signature" >}
   
 
{</section>}
 
{<section id="apjm250.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apjm250_set_pk_array()
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
   LET g_pk_array[1].values = g_pjba_m.pjba001
   LET g_pk_array[1].column = 'pjba001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apjm250.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="apjm250.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apjm250_msgcentre_notify(lc_state)
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
   CALL apjm250_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pjba_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apjm250.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apjm250_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apjm250.other_function" readonly="Y" >}

PRIVATE FUNCTION apjm250_pjbm003_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjbm_d[l_ac].pjbm003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8004' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbm_d[l_ac].pjbm003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbm_d[l_ac].pjbm003_desc
END FUNCTION

PRIVATE FUNCTION apjm250_pjbm004_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjbm_d[l_ac].pjbm004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbm_d[l_ac].pjbm004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbm_d[l_ac].pjbm004_desc
END FUNCTION

PRIVATE FUNCTION apjm250_pjbm005_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjba_m.pjba001
   LET g_ref_fields[2] = g_pjbm_d[l_ac].pjbm005
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbml004 FROM pjbml_t WHERE pjbmlent='"||g_enterprise||"' AND pjbml001=? AND pjbml002=? AND pjbml003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbm_d[l_ac].pjbm005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbm_d[l_ac].pjbm005_desc
END FUNCTION

PRIVATE FUNCTION apjm250_pjbm007_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjba_m.pjba001
   LET g_ref_fields[2] = g_pjbm_d[l_ac].pjbm007
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbml004 FROM pjbml_t WHERE pjbmlent='"||g_enterprise||"' AND pjbml001=? AND pjbml002=? AND pjbml003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbm_d[l_ac].pjbm007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbm_d[l_ac].pjbm007_desc
END FUNCTION

PRIVATE FUNCTION apjm250_pjbm009_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjbm_d[l_ac].pjbm009
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t,ooag_t WHERE oofaent='"||g_enterprise||"' AND oofa001=ooag002 AND ooag001=? AND ooagent='"||g_enterprise||"' ","") RETURNING g_rtn_fields
   LET g_pjbm_d[l_ac].pjbm009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbm_d[l_ac].pjbm009_desc
END FUNCTION

PRIVATE FUNCTION apjm250_pjbm010_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjbm_d[l_ac].pjbm010
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbm_d[l_ac].pjbm010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbm_d[l_ac].pjbm010_desc
END FUNCTION

PRIVATE FUNCTION apjm250_pjbm011_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjba_m.pjba001
   LET g_ref_fields[2] = g_pjbm_d[l_ac].pjbm011
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbm_d[l_ac].pjbm011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbm_d[l_ac].pjbm011_desc
END FUNCTION

PRIVATE FUNCTION apjm250_apjm013_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjbm_d[l_ac].pjbm013
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8005' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbm_d[l_ac].pjbm013_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbm_d[l_ac].pjbm013_desc
END FUNCTION

PRIVATE FUNCTION apjm250_apjm014_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjbm_d[l_ac].pjbm014
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8005' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbm_d[l_ac].pjbm014_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbm_d[l_ac].pjbm014_desc
END FUNCTION

PRIVATE FUNCTION apjm250_pjbm029()
   SELECT pjbm029 INTO g_pjba_m.pjbm029 
     FROM pjbm_t 
    WHERE pjbment = g_enterprise 
      AND pjbm001 = g_pjba_m.pjba001
      AND pjbm002 = g_pjbm_d[l_ac].pjbm002
END FUNCTION

PRIVATE FUNCTION apjm250_apjm006_required()
   IF NOT cl_null(g_pjbm_d[l_ac].pjbm005) THEN
      CALL cl_set_comp_entry("pjbm006", TRUE)
      CALL cl_set_comp_required("pjbm006", TRUE)
   ELSE
      LET g_pjbm_d[l_ac].pjbm006 = ''
      CALL cl_set_comp_entry("pjbm006", FALSE)
      CALL cl_set_comp_required("pjbm006", FALSE)
   END IF
END FUNCTION

PRIVATE FUNCTION apjm250_pjbm009()
   IF NOT cl_null(g_pjbm_d[l_ac].pjbm009) AND cl_null(g_pjbm_d[l_ac].pjbm010) THEN
      SELECT ooag003 INTO g_pjbm_d[l_ac].pjbm010 
        FROM ooag_t 
       WHERE ooagent = g_enterprise AND ooag001 = g_pjbm_d[l_ac].pjbm009
      CALL apjm250_pjbm010_desc()
   END IF
END FUNCTION

PRIVATE FUNCTION apjm250_pjbm(p_i)
   DEFINE p_i   LIKE type_t.num5 
   SELECT pjbm019,pjbm020,pjbm021,pjbm022,pjbm023,pjbm024,
          pjbm025,pjbm026,pjbm027,pjbm028,pjbm029
     INTO g_pjba_m.pjbm019,g_pjba_m.pjbm020,g_pjba_m.pjbm021,g_pjba_m.pjbm022,
          g_pjba_m.pjbm023,g_pjba_m.pjbm024,g_pjba_m.pjbm025,g_pjba_m.pjbm026,
          g_pjba_m.pjbm027,g_pjba_m.pjbm028,g_pjba_m.pjbm029          
     FROM pjbm_t 
    WHERE pjbment = g_enterprise 
      AND pjbm001 = g_pjba_m.pjba001
      AND pjbm002 = g_pjbm_d[p_i].pjbm002
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjba_m.pjbm028
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t,ooag_t WHERE oofaent='"||g_enterprise||"' AND oofa001=ooag002 AND ooag001=? AND ooagent='"||g_enterprise||"' ","") RETURNING g_rtn_fields
   LET g_pjba_m.pjbm028_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjba_m.pjbm028_desc
   DISPLAY g_pjba_m.pjbm019 TO pjbm019
   DISPLAY g_pjba_m.pjbm020 TO pjbm020
   DISPLAY g_pjba_m.pjbm021 TO pjbm021
   DISPLAY g_pjba_m.pjbm022 TO pjbm022
   DISPLAY g_pjba_m.pjbm023 TO pjbm023
   DISPLAY g_pjba_m.pjbm024 TO pjbm024
   DISPLAY g_pjba_m.pjbm025 TO pjbm025
   DISPLAY g_pjba_m.pjbm026 TO pjbm026
   DISPLAY g_pjba_m.pjbm027 TO pjbm027
   DISPLAY g_pjba_m.pjbm028 TO pjbm028
   DISPLAY g_pjba_m.pjbm029 TO pjbm029

END FUNCTION

 
{</section>}
 
