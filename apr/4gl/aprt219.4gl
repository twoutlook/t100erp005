#該程式未解開Section, 採用最新樣板產出!
{<section id="aprt219.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2015-12-16 20:27:12), PR版次:0008(2016-11-14 14:08:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: aprt219
#+ Description: 全場促銷申請單
#+ Creator....: 01251(2015-12-16 19:37:50)
#+ Modifier...: 01251 -SD/PR- 02481
 
{</section>}
 
{<section id="aprt219.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#+ Modifier...:   No.160318-00005#41  2016/03/24   by pengxin  修正azzi920重复定义之错误讯息
#+ Modifier...:   No.160318-00025#32  2016/04/12   by pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#  Modify.....:   NO.160816-00068#13  2016/08/17   By 08209    調整transaction
# Modify......:   NO.160818-00017#31  2016/08/30   By 08742    删除修改未重新判断状态码
#160905-00007#13  20160905 by geza     sql加上ent条件
#  Modify.....:   NO.160824-00007#146  2016/11/01  By 06137    修正舊值備份寫法
# Modify......:   NO.161111-00028#2    2016/11/14  By 02481     标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_prda_m        RECORD
       prdasite LIKE prda_t.prdasite, 
   prdasite_desc LIKE type_t.chr80, 
   prdadocdt LIKE prda_t.prdadocdt, 
   prdadocno LIKE prda_t.prdadocno, 
   prda000 LIKE prda_t.prda000, 
   prda001 LIKE prda_t.prda001, 
   prda002 LIKE prda_t.prda002, 
   prdal002 LIKE prdal_t.prdal002, 
   prda006 LIKE prda_t.prda006, 
   prda006_desc LIKE type_t.chr80, 
   prda007 LIKE prda_t.prda007, 
   prda007_desc LIKE type_t.chr80, 
   prda027 LIKE prda_t.prda027, 
   prdastus LIKE prda_t.prdastus, 
   prda034 LIKE prda_t.prda034, 
   l_prdd003_1 LIKE type_t.dat, 
   l_prdd004_1 LIKE type_t.dat, 
   prda026 LIKE prda_t.prda026, 
   l_prdb005_1 LIKE type_t.num20_6, 
   prda033 LIKE prda_t.prda033, 
   prda033_desc LIKE type_t.chr80, 
   prda008 LIKE prda_t.prda008, 
   prda008_desc LIKE type_t.chr80, 
   prda009 LIKE prda_t.prda009, 
   prda009_desc LIKE type_t.chr80, 
   prda023 LIKE prda_t.prda023, 
   prda003 LIKE prda_t.prda003, 
   prda028 LIKE prda_t.prda028, 
   prda038 LIKE prda_t.prda038, 
   prda011 LIKE prda_t.prda011, 
   prda015 LIKE prda_t.prda015, 
   prda020 LIKE prda_t.prda020, 
   prda012 LIKE prda_t.prda012, 
   prda016 LIKE prda_t.prda016, 
   prda014 LIKE prda_t.prda014, 
   prda013 LIKE prda_t.prda013, 
   prda010 LIKE prda_t.prda010, 
   prda017 LIKE prda_t.prda017, 
   prda024 LIKE prda_t.prda024, 
   prda018 LIKE prda_t.prda018, 
   prda025 LIKE prda_t.prda025, 
   prda019 LIKE prda_t.prda019, 
   prda032 LIKE prda_t.prda032, 
   prda021 LIKE prda_t.prda021, 
   prda022 LIKE prda_t.prda022, 
   prda029 LIKE prda_t.prda029, 
   prda030 LIKE prda_t.prda030, 
   prda031 LIKE prda_t.prda031, 
   prda037 LIKE prda_t.prda037, 
   prda098 LIKE prda_t.prda098, 
   prda101 LIKE prda_t.prda101, 
   prda102 LIKE prda_t.prda102, 
   prda103 LIKE prda_t.prda103, 
   prdaunit LIKE prda_t.prdaunit, 
   prdaunit_desc LIKE type_t.chr80, 
   prdaacti LIKE prda_t.prdaacti, 
   prda004 LIKE prda_t.prda004, 
   prda004_desc LIKE type_t.chr80, 
   prda005 LIKE prda_t.prda005, 
   prda005_desc LIKE type_t.chr80, 
   prdaownid LIKE prda_t.prdaownid, 
   prdaownid_desc LIKE type_t.chr80, 
   prdaowndp LIKE prda_t.prdaowndp, 
   prdaowndp_desc LIKE type_t.chr80, 
   prdacrtid LIKE prda_t.prdacrtid, 
   prdacrtid_desc LIKE type_t.chr80, 
   prdacrtdp LIKE prda_t.prdacrtdp, 
   prdacrtdp_desc LIKE type_t.chr80, 
   prdacrtdt LIKE prda_t.prdacrtdt, 
   prdamodid LIKE prda_t.prdamodid, 
   prdamodid_desc LIKE type_t.chr80, 
   prdamoddt LIKE prda_t.prdamoddt, 
   prdacnfid LIKE prda_t.prdacnfid, 
   prdacnfid_desc LIKE type_t.chr80, 
   prdacnfdt LIKE prda_t.prdacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prde_d        RECORD
       prdeacti LIKE prde_t.prdeacti, 
   prde003 LIKE prde_t.prde003, 
   prde004 LIKE prde_t.prde004, 
   prde004_desc LIKE type_t.chr500, 
   prde002 LIKE prde_t.prde002, 
   prde001 LIKE prde_t.prde001, 
   prdesite LIKE prde_t.prdesite, 
   prdeunit LIKE prde_t.prdeunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_prdadocno LIKE prda_t.prdadocno,
      b_prdasite LIKE prda_t.prdasite,
   b_prdasite_desc LIKE type_t.chr80,
      b_prdadocdt LIKE prda_t.prdadocdt,
      b_prda000 LIKE prda_t.prda000,
      b_prda001 LIKE prda_t.prda001,
      b_prda002 LIKE prda_t.prda002,
      b_prda006 LIKE prda_t.prda006,
   b_prda006_desc LIKE type_t.chr80,
      b_prda007 LIKE prda_t.prda007,
   b_prda007_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag           LIKE type_t.num5
DEFINE l_success             LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_prda_m          type_g_prda_m
DEFINE g_prda_m_t        type_g_prda_m
DEFINE g_prda_m_o        type_g_prda_m
DEFINE g_prda_m_mask_o   type_g_prda_m #轉換遮罩前資料
DEFINE g_prda_m_mask_n   type_g_prda_m #轉換遮罩後資料
 
   DEFINE g_prdadocno_t LIKE prda_t.prdadocno
 
 
DEFINE g_prde_d          DYNAMIC ARRAY OF type_g_prde_d
DEFINE g_prde_d_t        type_g_prde_d
DEFINE g_prde_d_o        type_g_prde_d
DEFINE g_prde_d_mask_o   DYNAMIC ARRAY OF type_g_prde_d #轉換遮罩前資料
DEFINE g_prde_d_mask_n   DYNAMIC ARRAY OF type_g_prde_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      prdaldocno LIKE prdal_t.prdaldocno,
      prdal002 LIKE prdal_t.prdal002
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
 
{<section id="aprt219.main" >}
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
   CALL cl_ap_init("apr","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_aooi390_cre_tmp_table() RETURNING l_success
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT prdasite,'',prdadocdt,prdadocno,prda000,prda001,prda002,'',prda006,'', 
       prda007,'',prda027,prdastus,prda034,'','',prda026,'',prda033,'',prda008,'',prda009,'',prda023, 
       prda003,prda028,prda038,prda011,prda015,prda020,prda012,prda016,prda014,prda013,prda010,prda017, 
       prda024,prda018,prda025,prda019,prda032,prda021,prda022,prda029,prda030,prda031,prda037,prda098, 
       prda101,prda102,prda103,prdaunit,'',prdaacti,prda004,'',prda005,'',prdaownid,'',prdaowndp,'', 
       prdacrtid,'',prdacrtdp,'',prdacrtdt,prdamodid,'',prdamoddt,prdacnfid,'',prdacnfdt", 
                      " FROM prda_t",
                      " WHERE prdaent= ? AND prdadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt219_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.prdasite,t0.prdadocdt,t0.prdadocno,t0.prda000,t0.prda001,t0.prda002, 
       t0.prda006,t0.prda007,t0.prda027,t0.prdastus,t0.prda034,t0.prda026,t0.prda033,t0.prda008,t0.prda009, 
       t0.prda023,t0.prda003,t0.prda028,t0.prda038,t0.prda011,t0.prda015,t0.prda020,t0.prda012,t0.prda016, 
       t0.prda014,t0.prda013,t0.prda010,t0.prda017,t0.prda024,t0.prda018,t0.prda025,t0.prda019,t0.prda032, 
       t0.prda021,t0.prda022,t0.prda029,t0.prda030,t0.prda031,t0.prda037,t0.prda098,t0.prda101,t0.prda102, 
       t0.prda103,t0.prdaunit,t0.prdaacti,t0.prda004,t0.prda005,t0.prdaownid,t0.prdaowndp,t0.prdacrtid, 
       t0.prdacrtdp,t0.prdacrtdt,t0.prdamodid,t0.prdamoddt,t0.prdacnfid,t0.prdacnfdt,t1.ooefl003 ,t2.oocql004 , 
       t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011",
               " FROM prda_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prdasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='2135' AND t2.oocql002=t0.prda033 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.prdaunit AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prdaownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prdaowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.prdacrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.prdacrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.prdamodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.prdacnfid  ",
 
               " WHERE t0.prdaent = " ||g_enterprise|| " AND t0.prdadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprt219_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprt219 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprt219_init()   
 
      #進入選單 Menu (="N")
      CALL aprt219_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprt219
      
   END IF 
   
   CLOSE aprt219_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   CALL s_aooi390_drop_tmp_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprt219.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprt219_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
DEFINE l_success LIKE type_t.num5

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
      CALL cl_set_combo_scc_part('prdastus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('prda026','6566') 
   CALL cl_set_combo_scc('prda017','6561') 
   CALL cl_set_combo_scc('prda018','6562') 
   CALL cl_set_combo_scc('prda019','6714') 
   CALL cl_set_combo_scc('prda021','6563') 
   CALL cl_set_combo_scc('prde003','6560') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('prda000','32') 
   CALL cl_set_combo_scc('b_prda000','32')      
   CALL cl_set_combo_scc('prde003','6560') 
   CALL cl_set_combo_scc('prda026','6566')    

   CALL s_aooi500_create_temp() RETURNING l_success
   CALL s_aooi390_drop_tmp_table()
   #end add-point
   
   #初始化搜尋條件
   CALL aprt219_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprt219.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprt219_ui_dialog()
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
            CALL aprt219_insert()
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
         INITIALIZE g_prda_m.* TO NULL
         CALL g_prde_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aprt219_init()
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
               
               CALL aprt219_fetch('') # reload data
               LET l_ac = 1
               CALL aprt219_ui_detailshow() #Setting the current row 
         
               CALL aprt219_idx_chk()
               #NEXT FIELD prde002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_prde_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt219_idx_chk()
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
               CALL aprt219_idx_chk()
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
            CALL aprt219_browser_fill("")
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
               CALL aprt219_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprt219_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprt219_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aprt219_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aprt219_set_act_visible()   
            CALL aprt219_set_act_no_visible()
            IF NOT (g_prda_m.prdadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " prdaent = " ||g_enterprise|| " AND",
                                  " prdadocno = '", g_prda_m.prdadocno, "' "
 
               #填到對應位置
               CALL aprt219_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "prda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prde_t" 
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
               CALL aprt219_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "prda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prde_t" 
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
                  CALL aprt219_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aprt219_fetch("F")
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
               CALL aprt219_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aprt219_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt219_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aprt219_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt219_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aprt219_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt219_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aprt219_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt219_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aprt219_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt219_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_prde_d)
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
               NEXT FIELD prde002
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
               CALL aprt219_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aprt219_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aprt219_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aprt219_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/apr/aprt219_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/apr/aprt219_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aprt219_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aprt219_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprt219_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprt219_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_prda_m.prdadocdt)
 
 
 
         
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
 
{<section id="aprt219.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprt219_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'prdasite') RETURNING l_where
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
   LET l_wc = l_wc CLIPPED," AND prda003 = '1' AND prda098='1' AND prda103='",g_prog,"'"
   LET g_wc = g_wc CLIPPED," AND prda003 = '1' AND prda098='1' AND prda103='",g_prog,"'"
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT prdadocno ",
                      " FROM prda_t ",
                      " ",
                      " LEFT JOIN prde_t ON prdeent = prdaent AND prdadocno = prdedocno ", "  ",
                      #add-point:browser_fill段sql(prde_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " LEFT JOIN prdal_t ON prdalent = "||g_enterprise||" AND prdadocno = prdaldocno AND prdal001 = '",g_dlang,"' ", 
                      " ", 
 
 
                      " WHERE prdaent = " ||g_enterprise|| " AND prdeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prda_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT prdadocno ",
                      " FROM prda_t ", 
                      "  ",
                      "  LEFT JOIN prdal_t ON prdalent = "||g_enterprise||" AND prdadocno = prdaldocno AND prdal001 = '",g_dlang,"' ",
                      " WHERE prdaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("prda_t")
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
      INITIALIZE g_prda_m.* TO NULL
      CALL g_prde_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.prdadocno,t0.prdasite,t0.prdadocdt,t0.prda000,t0.prda001,t0.prda002,t0.prda006,t0.prda007 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prdastus,t0.prdadocno,t0.prdasite,t0.prdadocdt,t0.prda000,t0.prda001, 
          t0.prda002,t0.prda006,t0.prda007,t1.ooefl003 ,t2.prcfl003 ,t3.prcdl003 ",
                  " FROM prda_t t0",
                  "  ",
                  "  LEFT JOIN prde_t ON prdeent = prdaent AND prdadocno = prdedocno ", "  ", 
                  #add-point:browser_fill段sql(prde_t1) name="browser_fill.join.prde_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prdasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN prcfl_t t2 ON t2.prcflent="||g_enterprise||" AND t2.prcfl001=t0.prda006 AND t2.prcfl002='"||g_dlang||"' ",
               " LEFT JOIN prcdl_t t3 ON t3.prcdlent="||g_enterprise||" AND t3.prcdl001=t0.prda007 AND t3.prcdl002='"||g_dlang||"' ",
 
               " LEFT JOIN prdal_t ON prdalent = "||g_enterprise||" AND prdadocno = prdaldocno AND prdal001 = '",g_dlang,"' ",
                  " WHERE t0.prdaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("prda_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prdastus,t0.prdadocno,t0.prdasite,t0.prdadocdt,t0.prda000,t0.prda001, 
          t0.prda002,t0.prda006,t0.prda007,t1.ooefl003 ,t2.prcfl003 ,t3.prcdl003 ",
                  " FROM prda_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prdasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN prcfl_t t2 ON t2.prcflent="||g_enterprise||" AND t2.prcfl001=t0.prda006 AND t2.prcfl002='"||g_dlang||"' ",
               " LEFT JOIN prcdl_t t3 ON t3.prcdlent="||g_enterprise||" AND t3.prcdl001=t0.prda007 AND t3.prcdl002='"||g_dlang||"' ",
 
               " LEFT JOIN prdal_t ON prdalent = "||g_enterprise||" AND prdadocno = prdaldocno AND prdal001 = '",g_dlang,"' ",
                  " WHERE t0.prdaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("prda_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY prdadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"prda_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_prdadocno,g_browser[g_cnt].b_prdasite, 
          g_browser[g_cnt].b_prdadocdt,g_browser[g_cnt].b_prda000,g_browser[g_cnt].b_prda001,g_browser[g_cnt].b_prda002, 
          g_browser[g_cnt].b_prda006,g_browser[g_cnt].b_prda007,g_browser[g_cnt].b_prdasite_desc,g_browser[g_cnt].b_prda006_desc, 
          g_browser[g_cnt].b_prda007_desc
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
         CALL aprt219_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_prdadocno) THEN
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
 
{<section id="aprt219.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprt219_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_prda_m.prdadocno = g_browser[g_current_idx].b_prdadocno   
 
   EXECUTE aprt219_master_referesh USING g_prda_m.prdadocno INTO g_prda_m.prdasite,g_prda_m.prdadocdt, 
       g_prda_m.prdadocno,g_prda_m.prda000,g_prda_m.prda001,g_prda_m.prda002,g_prda_m.prda006,g_prda_m.prda007, 
       g_prda_m.prda027,g_prda_m.prdastus,g_prda_m.prda034,g_prda_m.prda026,g_prda_m.prda033,g_prda_m.prda008, 
       g_prda_m.prda009,g_prda_m.prda023,g_prda_m.prda003,g_prda_m.prda028,g_prda_m.prda038,g_prda_m.prda011, 
       g_prda_m.prda015,g_prda_m.prda020,g_prda_m.prda012,g_prda_m.prda016,g_prda_m.prda014,g_prda_m.prda013, 
       g_prda_m.prda010,g_prda_m.prda017,g_prda_m.prda024,g_prda_m.prda018,g_prda_m.prda025,g_prda_m.prda019, 
       g_prda_m.prda032,g_prda_m.prda021,g_prda_m.prda022,g_prda_m.prda029,g_prda_m.prda030,g_prda_m.prda031, 
       g_prda_m.prda037,g_prda_m.prda098,g_prda_m.prda101,g_prda_m.prda102,g_prda_m.prda103,g_prda_m.prdaunit, 
       g_prda_m.prdaacti,g_prda_m.prda004,g_prda_m.prda005,g_prda_m.prdaownid,g_prda_m.prdaowndp,g_prda_m.prdacrtid, 
       g_prda_m.prdacrtdp,g_prda_m.prdacrtdt,g_prda_m.prdamodid,g_prda_m.prdamoddt,g_prda_m.prdacnfid, 
       g_prda_m.prdacnfdt,g_prda_m.prdasite_desc,g_prda_m.prda033_desc,g_prda_m.prdaunit_desc,g_prda_m.prdaownid_desc, 
       g_prda_m.prdaowndp_desc,g_prda_m.prdacrtid_desc,g_prda_m.prdacrtdp_desc,g_prda_m.prdamodid_desc, 
       g_prda_m.prdacnfid_desc
   
   CALL aprt219_prda_t_mask()
   CALL aprt219_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aprt219.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprt219_ui_detailshow()
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
 
{<section id="aprt219.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprt219_ui_browser_refresh()
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
      IF g_browser[l_i].b_prdadocno = g_prda_m.prdadocno 
 
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
 
{<section id="aprt219.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprt219_construct()
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
   INITIALIZE g_prda_m.* TO NULL
   CALL g_prde_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON prdasite,prdadocdt,prdadocno,prda000,prda001,prda002,prdal002,prda006, 
          prda007,prda027,prdastus,prda034,prda026,prda033,prda008,prda009,prda023,prda003,prda028,prda038, 
          prda011,prda015,prda020,prda012,prda016,prda014,prda013,prda010,prda017,prda024,prda018,prda025, 
          prda019,prda032,prda021,prda022,prda029,prda030,prda031,prda037,prda098,prda101,prda102,prda103, 
          prdaunit,prdaacti,prda004,prda005,prdaownid,prdaowndp,prdacrtid,prdacrtdp,prdacrtdt,prdamodid, 
          prdamoddt,prdacnfid,prdacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prdacrtdt>>----
         AFTER FIELD prdacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prdamoddt>>----
         AFTER FIELD prdamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdacnfdt>>----
         AFTER FIELD prdacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdasite
            #add-point:BEFORE FIELD prdasite name="construct.b.prdasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdasite
            
            #add-point:AFTER FIELD prdasite name="construct.a.prdasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdasite
            #add-point:ON ACTION controlp INFIELD prdasite name="construct.c.prdasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prdasite',g_site,'c') 
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdasite  #顯示到畫面上
            NEXT FIELD prdasite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdadocdt
            #add-point:BEFORE FIELD prdadocdt name="construct.b.prdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdadocdt
            
            #add-point:AFTER FIELD prdadocdt name="construct.a.prdadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdadocdt
            #add-point:ON ACTION controlp INFIELD prdadocdt name="construct.c.prdadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdadocno
            #add-point:ON ACTION controlp INFIELD prdadocno name="construct.c.prdadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
			   LET g_qryparam.arg2 = '1'            
            LET g_qryparam.where = " prda103='",g_prog,"'"
            CALL q_prdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdadocno  #顯示到畫面上
            NEXT FIELD prdadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdadocno
            #add-point:BEFORE FIELD prdadocno name="construct.b.prdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdadocno
            
            #add-point:AFTER FIELD prdadocno name="construct.a.prdadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda000
            #add-point:BEFORE FIELD prda000 name="construct.b.prda000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda000
            
            #add-point:AFTER FIELD prda000 name="construct.a.prda000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda000
            #add-point:ON ACTION controlp INFIELD prda000 name="construct.c.prda000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda001
            #add-point:BEFORE FIELD prda001 name="construct.b.prda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda001
            
            #add-point:AFTER FIELD prda001 name="construct.a.prda001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda001
            #add-point:ON ACTION controlp INFIELD prda001 name="construct.c.prda001"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
			   LET g_qryparam.arg2 = '1'
            LET g_qryparam.where = " prda103='",g_prog,"'"			   
            CALL q_prda001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prda001  #顯示到畫面上

            NEXT FIELD prda001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda002
            #add-point:BEFORE FIELD prda002 name="construct.b.prda002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda002
            
            #add-point:AFTER FIELD prda002 name="construct.a.prda002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda002
            #add-point:ON ACTION controlp INFIELD prda002 name="construct.c.prda002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdal002
            #add-point:BEFORE FIELD prdal002 name="construct.b.prdal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdal002
            
            #add-point:AFTER FIELD prdal002 name="construct.a.prdal002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdal002
            #add-point:ON ACTION controlp INFIELD prdal002 name="construct.c.prdal002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda006
            #add-point:BEFORE FIELD prda006 name="construct.b.prda006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda006
            
            #add-point:AFTER FIELD prda006 name="construct.a.prda006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda006
            #add-point:ON ACTION controlp INFIELD prda006 name="construct.c.prda006"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
            CALL q_prcf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prda006  #顯示到畫面上

            NEXT FIELD prda006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda007
            #add-point:BEFORE FIELD prda007 name="construct.b.prda007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda007
            
            #add-point:AFTER FIELD prda007 name="construct.a.prda007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda007
            #add-point:ON ACTION controlp INFIELD prda007 name="construct.c.prda007"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
            CALL q_prcd001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prda007  #顯示到畫面上

            NEXT FIELD prda007                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda027
            #add-point:BEFORE FIELD prda027 name="construct.b.prda027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda027
            
            #add-point:AFTER FIELD prda027 name="construct.a.prda027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda027
            #add-point:ON ACTION controlp INFIELD prda027 name="construct.c.prda027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdastus
            #add-point:BEFORE FIELD prdastus name="construct.b.prdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdastus
            
            #add-point:AFTER FIELD prdastus name="construct.a.prdastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdastus
            #add-point:ON ACTION controlp INFIELD prdastus name="construct.c.prdastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda034
            #add-point:BEFORE FIELD prda034 name="construct.b.prda034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda034
            
            #add-point:AFTER FIELD prda034 name="construct.a.prda034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda034
            #add-point:ON ACTION controlp INFIELD prda034 name="construct.c.prda034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda026
            #add-point:BEFORE FIELD prda026 name="construct.b.prda026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda026
            
            #add-point:AFTER FIELD prda026 name="construct.a.prda026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda026
            #add-point:ON ACTION controlp INFIELD prda026 name="construct.c.prda026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda033
            #add-point:BEFORE FIELD prda033 name="construct.b.prda033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda033
            
            #add-point:AFTER FIELD prda033 name="construct.a.prda033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda033
            #add-point:ON ACTION controlp INFIELD prda033 name="construct.c.prda033"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2135'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prda033  #顯示到畫面上
            NEXT FIELD prda033                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda008
            #add-point:BEFORE FIELD prda008 name="construct.b.prda008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda008
            
            #add-point:AFTER FIELD prda008 name="construct.a.prda008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda008
            #add-point:ON ACTION controlp INFIELD prda008 name="construct.c.prda008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2100'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prda008  #顯示到畫面上
            NEXT FIELD prda008                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda009
            #add-point:BEFORE FIELD prda009 name="construct.b.prda009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda009
            
            #add-point:AFTER FIELD prda009 name="construct.a.prda009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda009
            #add-point:ON ACTION controlp INFIELD prda009 name="construct.c.prda009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2101'
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO prda009  #顯示到畫面上
            NEXT FIELD prda009                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda023
            #add-point:BEFORE FIELD prda023 name="construct.b.prda023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda023
            
            #add-point:AFTER FIELD prda023 name="construct.a.prda023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda023
            #add-point:ON ACTION controlp INFIELD prda023 name="construct.c.prda023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda003
            #add-point:BEFORE FIELD prda003 name="construct.b.prda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda003
            
            #add-point:AFTER FIELD prda003 name="construct.a.prda003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda003
            #add-point:ON ACTION controlp INFIELD prda003 name="construct.c.prda003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda028
            #add-point:BEFORE FIELD prda028 name="construct.b.prda028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda028
            
            #add-point:AFTER FIELD prda028 name="construct.a.prda028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda028
            #add-point:ON ACTION controlp INFIELD prda028 name="construct.c.prda028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda038
            #add-point:BEFORE FIELD prda038 name="construct.b.prda038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda038
            
            #add-point:AFTER FIELD prda038 name="construct.a.prda038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda038
            #add-point:ON ACTION controlp INFIELD prda038 name="construct.c.prda038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda011
            #add-point:BEFORE FIELD prda011 name="construct.b.prda011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda011
            
            #add-point:AFTER FIELD prda011 name="construct.a.prda011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda011
            #add-point:ON ACTION controlp INFIELD prda011 name="construct.c.prda011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda015
            #add-point:BEFORE FIELD prda015 name="construct.b.prda015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda015
            
            #add-point:AFTER FIELD prda015 name="construct.a.prda015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda015
            #add-point:ON ACTION controlp INFIELD prda015 name="construct.c.prda015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda020
            #add-point:BEFORE FIELD prda020 name="construct.b.prda020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda020
            
            #add-point:AFTER FIELD prda020 name="construct.a.prda020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda020
            #add-point:ON ACTION controlp INFIELD prda020 name="construct.c.prda020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda012
            #add-point:BEFORE FIELD prda012 name="construct.b.prda012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda012
            
            #add-point:AFTER FIELD prda012 name="construct.a.prda012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda012
            #add-point:ON ACTION controlp INFIELD prda012 name="construct.c.prda012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda016
            #add-point:BEFORE FIELD prda016 name="construct.b.prda016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda016
            
            #add-point:AFTER FIELD prda016 name="construct.a.prda016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda016
            #add-point:ON ACTION controlp INFIELD prda016 name="construct.c.prda016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda014
            #add-point:BEFORE FIELD prda014 name="construct.b.prda014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda014
            
            #add-point:AFTER FIELD prda014 name="construct.a.prda014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda014
            #add-point:ON ACTION controlp INFIELD prda014 name="construct.c.prda014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda013
            #add-point:BEFORE FIELD prda013 name="construct.b.prda013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda013
            
            #add-point:AFTER FIELD prda013 name="construct.a.prda013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda013
            #add-point:ON ACTION controlp INFIELD prda013 name="construct.c.prda013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda010
            #add-point:BEFORE FIELD prda010 name="construct.b.prda010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda010
            
            #add-point:AFTER FIELD prda010 name="construct.a.prda010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda010
            #add-point:ON ACTION controlp INFIELD prda010 name="construct.c.prda010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda017
            #add-point:BEFORE FIELD prda017 name="construct.b.prda017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda017
            
            #add-point:AFTER FIELD prda017 name="construct.a.prda017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda017
            #add-point:ON ACTION controlp INFIELD prda017 name="construct.c.prda017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda024
            #add-point:BEFORE FIELD prda024 name="construct.b.prda024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda024
            
            #add-point:AFTER FIELD prda024 name="construct.a.prda024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda024
            #add-point:ON ACTION controlp INFIELD prda024 name="construct.c.prda024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda018
            #add-point:BEFORE FIELD prda018 name="construct.b.prda018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda018
            
            #add-point:AFTER FIELD prda018 name="construct.a.prda018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda018
            #add-point:ON ACTION controlp INFIELD prda018 name="construct.c.prda018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda025
            #add-point:BEFORE FIELD prda025 name="construct.b.prda025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda025
            
            #add-point:AFTER FIELD prda025 name="construct.a.prda025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda025
            #add-point:ON ACTION controlp INFIELD prda025 name="construct.c.prda025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda019
            #add-point:BEFORE FIELD prda019 name="construct.b.prda019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda019
            
            #add-point:AFTER FIELD prda019 name="construct.a.prda019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda019
            #add-point:ON ACTION controlp INFIELD prda019 name="construct.c.prda019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda032
            #add-point:BEFORE FIELD prda032 name="construct.b.prda032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda032
            
            #add-point:AFTER FIELD prda032 name="construct.a.prda032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda032
            #add-point:ON ACTION controlp INFIELD prda032 name="construct.c.prda032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda021
            #add-point:BEFORE FIELD prda021 name="construct.b.prda021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda021
            
            #add-point:AFTER FIELD prda021 name="construct.a.prda021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda021
            #add-point:ON ACTION controlp INFIELD prda021 name="construct.c.prda021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda022
            #add-point:BEFORE FIELD prda022 name="construct.b.prda022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda022
            
            #add-point:AFTER FIELD prda022 name="construct.a.prda022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda022
            #add-point:ON ACTION controlp INFIELD prda022 name="construct.c.prda022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda029
            #add-point:BEFORE FIELD prda029 name="construct.b.prda029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda029
            
            #add-point:AFTER FIELD prda029 name="construct.a.prda029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda029
            #add-point:ON ACTION controlp INFIELD prda029 name="construct.c.prda029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda030
            #add-point:BEFORE FIELD prda030 name="construct.b.prda030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda030
            
            #add-point:AFTER FIELD prda030 name="construct.a.prda030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda030
            #add-point:ON ACTION controlp INFIELD prda030 name="construct.c.prda030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda031
            #add-point:BEFORE FIELD prda031 name="construct.b.prda031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda031
            
            #add-point:AFTER FIELD prda031 name="construct.a.prda031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda031
            #add-point:ON ACTION controlp INFIELD prda031 name="construct.c.prda031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda037
            #add-point:BEFORE FIELD prda037 name="construct.b.prda037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda037
            
            #add-point:AFTER FIELD prda037 name="construct.a.prda037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda037
            #add-point:ON ACTION controlp INFIELD prda037 name="construct.c.prda037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda098
            #add-point:BEFORE FIELD prda098 name="construct.b.prda098"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda098
            
            #add-point:AFTER FIELD prda098 name="construct.a.prda098"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda098
            #add-point:ON ACTION controlp INFIELD prda098 name="construct.c.prda098"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda101
            #add-point:BEFORE FIELD prda101 name="construct.b.prda101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda101
            
            #add-point:AFTER FIELD prda101 name="construct.a.prda101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda101
            #add-point:ON ACTION controlp INFIELD prda101 name="construct.c.prda101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda102
            #add-point:BEFORE FIELD prda102 name="construct.b.prda102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda102
            
            #add-point:AFTER FIELD prda102 name="construct.a.prda102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda102
            #add-point:ON ACTION controlp INFIELD prda102 name="construct.c.prda102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda103
            #add-point:BEFORE FIELD prda103 name="construct.b.prda103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda103
            
            #add-point:AFTER FIELD prda103 name="construct.a.prda103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda103
            #add-point:ON ACTION controlp INFIELD prda103 name="construct.c.prda103"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prdaunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdaunit
            #add-point:ON ACTION controlp INFIELD prdaunit name="construct.c.prdaunit"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdaunit  #顯示到畫面上
            NEXT FIELD prdaunit                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdaunit
            #add-point:BEFORE FIELD prdaunit name="construct.b.prdaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdaunit
            
            #add-point:AFTER FIELD prdaunit name="construct.a.prdaunit"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdaacti
            #add-point:BEFORE FIELD prdaacti name="construct.b.prdaacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdaacti
            
            #add-point:AFTER FIELD prdaacti name="construct.a.prdaacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdaacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdaacti
            #add-point:ON ACTION controlp INFIELD prdaacti name="construct.c.prdaacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda004
            #add-point:BEFORE FIELD prda004 name="construct.b.prda004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda004
            
            #add-point:AFTER FIELD prda004 name="construct.a.prda004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda004
            #add-point:ON ACTION controlp INFIELD prda004 name="construct.c.prda004"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prda004  #顯示到畫面上

            NEXT FIELD prda004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda005
            #add-point:BEFORE FIELD prda005 name="construct.b.prda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda005
            
            #add-point:AFTER FIELD prda005 name="construct.a.prda005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda005
            #add-point:ON ACTION controlp INFIELD prda005 name="construct.c.prda005"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO prda005  #顯示到畫面上

            NEXT FIELD prda005                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.prdaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdaownid
            #add-point:ON ACTION controlp INFIELD prdaownid name="construct.c.prdaownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdaownid  #顯示到畫面上
            NEXT FIELD prdaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdaownid
            #add-point:BEFORE FIELD prdaownid name="construct.b.prdaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdaownid
            
            #add-point:AFTER FIELD prdaownid name="construct.a.prdaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdaowndp
            #add-point:ON ACTION controlp INFIELD prdaowndp name="construct.c.prdaowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdaowndp  #顯示到畫面上
            NEXT FIELD prdaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdaowndp
            #add-point:BEFORE FIELD prdaowndp name="construct.b.prdaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdaowndp
            
            #add-point:AFTER FIELD prdaowndp name="construct.a.prdaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdacrtid
            #add-point:ON ACTION controlp INFIELD prdacrtid name="construct.c.prdacrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdacrtid  #顯示到畫面上
            NEXT FIELD prdacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdacrtid
            #add-point:BEFORE FIELD prdacrtid name="construct.b.prdacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdacrtid
            
            #add-point:AFTER FIELD prdacrtid name="construct.a.prdacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdacrtdp
            #add-point:ON ACTION controlp INFIELD prdacrtdp name="construct.c.prdacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdacrtdp  #顯示到畫面上
            NEXT FIELD prdacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdacrtdp
            #add-point:BEFORE FIELD prdacrtdp name="construct.b.prdacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdacrtdp
            
            #add-point:AFTER FIELD prdacrtdp name="construct.a.prdacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdacrtdt
            #add-point:BEFORE FIELD prdacrtdt name="construct.b.prdacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prdamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdamodid
            #add-point:ON ACTION controlp INFIELD prdamodid name="construct.c.prdamodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdamodid  #顯示到畫面上
            NEXT FIELD prdamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdamodid
            #add-point:BEFORE FIELD prdamodid name="construct.b.prdamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdamodid
            
            #add-point:AFTER FIELD prdamodid name="construct.a.prdamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdamoddt
            #add-point:BEFORE FIELD prdamoddt name="construct.b.prdamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prdacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdacnfid
            #add-point:ON ACTION controlp INFIELD prdacnfid name="construct.c.prdacnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdacnfid  #顯示到畫面上
            NEXT FIELD prdacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdacnfid
            #add-point:BEFORE FIELD prdacnfid name="construct.b.prdacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdacnfid
            
            #add-point:AFTER FIELD prdacnfid name="construct.a.prdacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdacnfdt
            #add-point:BEFORE FIELD prdacnfdt name="construct.b.prdacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON prdeacti,prde003,prde004,prde002,prde001,prdesite,prdeunit
           FROM s_detail1[1].prdeacti,s_detail1[1].prde003,s_detail1[1].prde004,s_detail1[1].prde002, 
               s_detail1[1].prde001,s_detail1[1].prdesite,s_detail1[1].prdeunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdeacti
            #add-point:BEFORE FIELD prdeacti name="construct.b.page1.prdeacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdeacti
            
            #add-point:AFTER FIELD prdeacti name="construct.a.page1.prdeacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prdeacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdeacti
            #add-point:ON ACTION controlp INFIELD prdeacti name="construct.c.page1.prdeacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prde003
            #add-point:BEFORE FIELD prde003 name="construct.b.page1.prde003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prde003
            
            #add-point:AFTER FIELD prde003 name="construct.a.page1.prde003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prde003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prde003
            #add-point:ON ACTION controlp INFIELD prde003 name="construct.c.page1.prde003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prde004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prde004
            #add-point:ON ACTION controlp INFIELD prde004 name="construct.c.page1.prde004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
			   LET g_qryparam.arg2 = '1'
            CALL q_prde004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prde004  #顯示到畫面上

            NEXT FIELD prde004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prde004
            #add-point:BEFORE FIELD prde004 name="construct.b.page1.prde004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prde004
            
            #add-point:AFTER FIELD prde004 name="construct.a.page1.prde004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prde002
            #add-point:BEFORE FIELD prde002 name="construct.b.page1.prde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prde002
            
            #add-point:AFTER FIELD prde002 name="construct.a.page1.prde002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prde002
            #add-point:ON ACTION controlp INFIELD prde002 name="construct.c.page1.prde002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prde001
            #add-point:BEFORE FIELD prde001 name="construct.b.page1.prde001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prde001
            
            #add-point:AFTER FIELD prde001 name="construct.a.page1.prde001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prde001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prde001
            #add-point:ON ACTION controlp INFIELD prde001 name="construct.c.page1.prde001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdesite
            #add-point:BEFORE FIELD prdesite name="construct.b.page1.prdesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdesite
            
            #add-point:AFTER FIELD prdesite name="construct.a.page1.prdesite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prdesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdesite
            #add-point:ON ACTION controlp INFIELD prdesite name="construct.c.page1.prdesite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdeunit
            #add-point:BEFORE FIELD prdeunit name="construct.b.page1.prdeunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdeunit
            
            #add-point:AFTER FIELD prdeunit name="construct.a.page1.prdeunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prdeunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdeunit
            #add-point:ON ACTION controlp INFIELD prdeunit name="construct.c.page1.prdeunit"
            
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
                  WHEN la_wc[li_idx].tableid = "prda_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prde_t" 
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
 
{<section id="aprt219.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aprt219_filter()
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
      CONSTRUCT g_wc_filter ON prdadocno,prdasite,prdadocdt,prda000,prda001,prda002,prda006,prda007
                          FROM s_browse[1].b_prdadocno,s_browse[1].b_prdasite,s_browse[1].b_prdadocdt, 
                              s_browse[1].b_prda000,s_browse[1].b_prda001,s_browse[1].b_prda002,s_browse[1].b_prda006, 
                              s_browse[1].b_prda007
 
         BEFORE CONSTRUCT
               DISPLAY aprt219_filter_parser('prdadocno') TO s_browse[1].b_prdadocno
            DISPLAY aprt219_filter_parser('prdasite') TO s_browse[1].b_prdasite
            DISPLAY aprt219_filter_parser('prdadocdt') TO s_browse[1].b_prdadocdt
            DISPLAY aprt219_filter_parser('prda000') TO s_browse[1].b_prda000
            DISPLAY aprt219_filter_parser('prda001') TO s_browse[1].b_prda001
            DISPLAY aprt219_filter_parser('prda002') TO s_browse[1].b_prda002
            DISPLAY aprt219_filter_parser('prda006') TO s_browse[1].b_prda006
            DISPLAY aprt219_filter_parser('prda007') TO s_browse[1].b_prda007
      
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
 
      CALL aprt219_filter_show('prdadocno')
   CALL aprt219_filter_show('prdasite')
   CALL aprt219_filter_show('prdadocdt')
   CALL aprt219_filter_show('prda000')
   CALL aprt219_filter_show('prda001')
   CALL aprt219_filter_show('prda002')
   CALL aprt219_filter_show('prda006')
   CALL aprt219_filter_show('prda007')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt219.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aprt219_filter_parser(ps_field)
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
 
{<section id="aprt219.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aprt219_filter_show(ps_field)
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
   LET ls_condition = aprt219_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprt219.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprt219_query()
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
   CALL g_prde_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aprt219_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aprt219_browser_fill("")
      CALL aprt219_fetch("")
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
      CALL aprt219_filter_show('prdadocno')
   CALL aprt219_filter_show('prdasite')
   CALL aprt219_filter_show('prdadocdt')
   CALL aprt219_filter_show('prda000')
   CALL aprt219_filter_show('prda001')
   CALL aprt219_filter_show('prda002')
   CALL aprt219_filter_show('prda006')
   CALL aprt219_filter_show('prda007')
   CALL aprt219_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aprt219_fetch("F") 
      #顯示單身筆數
      CALL aprt219_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt219.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprt219_fetch(p_flag)
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
   
   LET g_prda_m.prdadocno = g_browser[g_current_idx].b_prdadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aprt219_master_referesh USING g_prda_m.prdadocno INTO g_prda_m.prdasite,g_prda_m.prdadocdt, 
       g_prda_m.prdadocno,g_prda_m.prda000,g_prda_m.prda001,g_prda_m.prda002,g_prda_m.prda006,g_prda_m.prda007, 
       g_prda_m.prda027,g_prda_m.prdastus,g_prda_m.prda034,g_prda_m.prda026,g_prda_m.prda033,g_prda_m.prda008, 
       g_prda_m.prda009,g_prda_m.prda023,g_prda_m.prda003,g_prda_m.prda028,g_prda_m.prda038,g_prda_m.prda011, 
       g_prda_m.prda015,g_prda_m.prda020,g_prda_m.prda012,g_prda_m.prda016,g_prda_m.prda014,g_prda_m.prda013, 
       g_prda_m.prda010,g_prda_m.prda017,g_prda_m.prda024,g_prda_m.prda018,g_prda_m.prda025,g_prda_m.prda019, 
       g_prda_m.prda032,g_prda_m.prda021,g_prda_m.prda022,g_prda_m.prda029,g_prda_m.prda030,g_prda_m.prda031, 
       g_prda_m.prda037,g_prda_m.prda098,g_prda_m.prda101,g_prda_m.prda102,g_prda_m.prda103,g_prda_m.prdaunit, 
       g_prda_m.prdaacti,g_prda_m.prda004,g_prda_m.prda005,g_prda_m.prdaownid,g_prda_m.prdaowndp,g_prda_m.prdacrtid, 
       g_prda_m.prdacrtdp,g_prda_m.prdacrtdt,g_prda_m.prdamodid,g_prda_m.prdamoddt,g_prda_m.prdacnfid, 
       g_prda_m.prdacnfdt,g_prda_m.prdasite_desc,g_prda_m.prda033_desc,g_prda_m.prdaunit_desc,g_prda_m.prdaownid_desc, 
       g_prda_m.prdaowndp_desc,g_prda_m.prdacrtid_desc,g_prda_m.prdacrtdp_desc,g_prda_m.prdamodid_desc, 
       g_prda_m.prdacnfid_desc
   
   #遮罩相關處理
   LET g_prda_m_mask_o.* =  g_prda_m.*
   CALL aprt219_prda_t_mask()
   LET g_prda_m_mask_n.* =  g_prda_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt219_set_act_visible()   
   CALL aprt219_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prda_m_t.* = g_prda_m.*
   LET g_prda_m_o.* = g_prda_m.*
   
   LET g_data_owner = g_prda_m.prdaownid      
   LET g_data_dept  = g_prda_m.prdaowndp
   
   #重新顯示   
   CALL aprt219_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt219.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprt219_insert()
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
   CALL g_prde_d.clear()   
 
 
   INITIALIZE g_prda_m.* TO NULL             #DEFAULT 設定
   
   LET g_prdadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prda_m.prdaownid = g_user
      LET g_prda_m.prdaowndp = g_dept
      LET g_prda_m.prdacrtid = g_user
      LET g_prda_m.prdacrtdp = g_dept 
      LET g_prda_m.prdacrtdt = cl_get_current()
      LET g_prda_m.prdamodid = g_user
      LET g_prda_m.prdamoddt = cl_get_current()
      LET g_prda_m.prdastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_prda_m.prda034 = "N"
      LET g_prda_m.l_prdb005_1 = "100"
      LET g_prda_m.prda037 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_prda_m.prda000 = "I"
      LET g_prda_m.prdaacti = "Y"
      LET g_prda_m.prdastus = "N"
      LET g_prda_m.prda010 = "Y" #全场促销
      LET g_prda_m.prda011 = "N"
      LET g_prda_m.prda012 = "N"
      LET g_prda_m.prda013 = "N"
      LET g_prda_m.prda038 = "N"
      LET g_prda_m.prda024 = "2"
      LET g_prda_m.prda025 = "1"
      LET g_prda_m.prda026 = "3"
      LET g_prda_m.prda037 = "0"  
      LET g_prda_m.prdadocdt = g_today
      LET g_prda_m.prda003 = '1'
      LET g_prda_m.prda004 = g_user
      LET g_prda_m.prda005 = g_dept
      LET g_prda_m.prda002 = 1
      LET g_prda_m.prda098 = '1'
      LET g_prda_m.prda103 = g_prog    
      LET g_prda_m.l_prdd003_1 = g_today
      LET g_prda_m.l_prdd004_1 = g_today

      #aooi500設置site      
      LET g_site_flag = FALSE      
      CALL s_aooi500_default(g_prog,'prdasite',g_prda_m.prdasite)
         RETURNING l_insert,g_prda_m.prdasite
      IF NOT l_insert THEN
         RETURN
      END IF     
      LET g_prda_m.prdaunit = g_prda_m.prdasite 
      
      #預設單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_prda_m.prdasite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_prda_m.prdadocno = r_doctype 
     
      INITIALIZE g_prda_m_o.* TO NULL      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_prda_m_t.* = g_prda_m.*
      LET g_prda_m_o.* = g_prda_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prda_m.prdastus 
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
 
 
 
    
      CALL aprt219_input("a")
      
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
         INITIALIZE g_prda_m.* TO NULL
         INITIALIZE g_prde_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aprt219_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_prde_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt219_set_act_visible()   
   CALL aprt219_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prdadocno_t = g_prda_m.prdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prdaent = " ||g_enterprise|| " AND",
                      " prdadocno = '", g_prda_m.prdadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt219_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aprt219_cl
   
   CALL aprt219_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aprt219_master_referesh USING g_prda_m.prdadocno INTO g_prda_m.prdasite,g_prda_m.prdadocdt, 
       g_prda_m.prdadocno,g_prda_m.prda000,g_prda_m.prda001,g_prda_m.prda002,g_prda_m.prda006,g_prda_m.prda007, 
       g_prda_m.prda027,g_prda_m.prdastus,g_prda_m.prda034,g_prda_m.prda026,g_prda_m.prda033,g_prda_m.prda008, 
       g_prda_m.prda009,g_prda_m.prda023,g_prda_m.prda003,g_prda_m.prda028,g_prda_m.prda038,g_prda_m.prda011, 
       g_prda_m.prda015,g_prda_m.prda020,g_prda_m.prda012,g_prda_m.prda016,g_prda_m.prda014,g_prda_m.prda013, 
       g_prda_m.prda010,g_prda_m.prda017,g_prda_m.prda024,g_prda_m.prda018,g_prda_m.prda025,g_prda_m.prda019, 
       g_prda_m.prda032,g_prda_m.prda021,g_prda_m.prda022,g_prda_m.prda029,g_prda_m.prda030,g_prda_m.prda031, 
       g_prda_m.prda037,g_prda_m.prda098,g_prda_m.prda101,g_prda_m.prda102,g_prda_m.prda103,g_prda_m.prdaunit, 
       g_prda_m.prdaacti,g_prda_m.prda004,g_prda_m.prda005,g_prda_m.prdaownid,g_prda_m.prdaowndp,g_prda_m.prdacrtid, 
       g_prda_m.prdacrtdp,g_prda_m.prdacrtdt,g_prda_m.prdamodid,g_prda_m.prdamoddt,g_prda_m.prdacnfid, 
       g_prda_m.prdacnfdt,g_prda_m.prdasite_desc,g_prda_m.prda033_desc,g_prda_m.prdaunit_desc,g_prda_m.prdaownid_desc, 
       g_prda_m.prdaowndp_desc,g_prda_m.prdacrtid_desc,g_prda_m.prdacrtdp_desc,g_prda_m.prdamodid_desc, 
       g_prda_m.prdacnfid_desc
   
   
   #遮罩相關處理
   LET g_prda_m_mask_o.* =  g_prda_m.*
   CALL aprt219_prda_t_mask()
   LET g_prda_m_mask_n.* =  g_prda_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prda_m.prdasite,g_prda_m.prdasite_desc,g_prda_m.prdadocdt,g_prda_m.prdadocno,g_prda_m.prda000, 
       g_prda_m.prda001,g_prda_m.prda002,g_prda_m.prdal002,g_prda_m.prda006,g_prda_m.prda006_desc,g_prda_m.prda007, 
       g_prda_m.prda007_desc,g_prda_m.prda027,g_prda_m.prdastus,g_prda_m.prda034,g_prda_m.l_prdd003_1, 
       g_prda_m.l_prdd004_1,g_prda_m.prda026,g_prda_m.l_prdb005_1,g_prda_m.prda033,g_prda_m.prda033_desc, 
       g_prda_m.prda008,g_prda_m.prda008_desc,g_prda_m.prda009,g_prda_m.prda009_desc,g_prda_m.prda023, 
       g_prda_m.prda003,g_prda_m.prda028,g_prda_m.prda038,g_prda_m.prda011,g_prda_m.prda015,g_prda_m.prda020, 
       g_prda_m.prda012,g_prda_m.prda016,g_prda_m.prda014,g_prda_m.prda013,g_prda_m.prda010,g_prda_m.prda017, 
       g_prda_m.prda024,g_prda_m.prda018,g_prda_m.prda025,g_prda_m.prda019,g_prda_m.prda032,g_prda_m.prda021, 
       g_prda_m.prda022,g_prda_m.prda029,g_prda_m.prda030,g_prda_m.prda031,g_prda_m.prda037,g_prda_m.prda098, 
       g_prda_m.prda101,g_prda_m.prda102,g_prda_m.prda103,g_prda_m.prdaunit,g_prda_m.prdaunit_desc,g_prda_m.prdaacti, 
       g_prda_m.prda004,g_prda_m.prda004_desc,g_prda_m.prda005,g_prda_m.prda005_desc,g_prda_m.prdaownid, 
       g_prda_m.prdaownid_desc,g_prda_m.prdaowndp,g_prda_m.prdaowndp_desc,g_prda_m.prdacrtid,g_prda_m.prdacrtid_desc, 
       g_prda_m.prdacrtdp,g_prda_m.prdacrtdp_desc,g_prda_m.prdacrtdt,g_prda_m.prdamodid,g_prda_m.prdamodid_desc, 
       g_prda_m.prdamoddt,g_prda_m.prdacnfid,g_prda_m.prdacnfid_desc,g_prda_m.prdacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_prda_m.prdaownid      
   LET g_data_dept  = g_prda_m.prdaowndp
   
   #功能已完成,通報訊息中心
   CALL aprt219_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aprt219.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprt219_modify()
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
   LET g_prda_m_t.* = g_prda_m.*
   LET g_prda_m_o.* = g_prda_m.*
   
   IF g_prda_m.prdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_prdadocno_t = g_prda_m.prdadocno
 
   CALL s_transaction_begin()
   
   OPEN aprt219_cl USING g_enterprise,g_prda_m.prdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt219_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt219_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt219_master_referesh USING g_prda_m.prdadocno INTO g_prda_m.prdasite,g_prda_m.prdadocdt, 
       g_prda_m.prdadocno,g_prda_m.prda000,g_prda_m.prda001,g_prda_m.prda002,g_prda_m.prda006,g_prda_m.prda007, 
       g_prda_m.prda027,g_prda_m.prdastus,g_prda_m.prda034,g_prda_m.prda026,g_prda_m.prda033,g_prda_m.prda008, 
       g_prda_m.prda009,g_prda_m.prda023,g_prda_m.prda003,g_prda_m.prda028,g_prda_m.prda038,g_prda_m.prda011, 
       g_prda_m.prda015,g_prda_m.prda020,g_prda_m.prda012,g_prda_m.prda016,g_prda_m.prda014,g_prda_m.prda013, 
       g_prda_m.prda010,g_prda_m.prda017,g_prda_m.prda024,g_prda_m.prda018,g_prda_m.prda025,g_prda_m.prda019, 
       g_prda_m.prda032,g_prda_m.prda021,g_prda_m.prda022,g_prda_m.prda029,g_prda_m.prda030,g_prda_m.prda031, 
       g_prda_m.prda037,g_prda_m.prda098,g_prda_m.prda101,g_prda_m.prda102,g_prda_m.prda103,g_prda_m.prdaunit, 
       g_prda_m.prdaacti,g_prda_m.prda004,g_prda_m.prda005,g_prda_m.prdaownid,g_prda_m.prdaowndp,g_prda_m.prdacrtid, 
       g_prda_m.prdacrtdp,g_prda_m.prdacrtdt,g_prda_m.prdamodid,g_prda_m.prdamoddt,g_prda_m.prdacnfid, 
       g_prda_m.prdacnfdt,g_prda_m.prdasite_desc,g_prda_m.prda033_desc,g_prda_m.prdaunit_desc,g_prda_m.prdaownid_desc, 
       g_prda_m.prdaowndp_desc,g_prda_m.prdacrtid_desc,g_prda_m.prdacrtdp_desc,g_prda_m.prdamodid_desc, 
       g_prda_m.prdacnfid_desc
   
   #檢查是否允許此動作
   IF NOT aprt219_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prda_m_mask_o.* =  g_prda_m.*
   CALL aprt219_prda_t_mask()
   LET g_prda_m_mask_n.* =  g_prda_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aprt219_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_prdadocno_t = g_prda_m.prdadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_prda_m.prdamodid = g_user 
LET g_prda_m.prdamoddt = cl_get_current()
LET g_prda_m.prdamodid_desc = cl_get_username(g_prda_m.prdamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aprt219_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE prda_t SET (prdamodid,prdamoddt) = (g_prda_m.prdamodid,g_prda_m.prdamoddt)
          WHERE prdaent = g_enterprise AND prdadocno = g_prdadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_prda_m.* = g_prda_m_t.*
            CALL aprt219_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_prda_m.prdadocno != g_prda_m_t.prdadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE prde_t SET prdedocno = g_prda_m.prdadocno
 
          WHERE prdeent = g_enterprise AND prdedocno = g_prda_m_t.prdadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prde_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prde_t:",SQLERRMESSAGE 
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
   CALL aprt219_set_act_visible()   
   CALL aprt219_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " prdaent = " ||g_enterprise|| " AND",
                      " prdadocno = '", g_prda_m.prdadocno, "' "
 
   #填到對應位置
   CALL aprt219_browser_fill("")
 
   CLOSE aprt219_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt219_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aprt219.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprt219_input(p_cmd)
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
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_prda001             LIKE prda_t.prda001
   DEFINE  l_n1                  LIKE type_t.num5
   DEFINE  l_prda002             LIKE type_t.num5 
   DEFINE  l_str                 STRING   
   DEFINE l_oofg_return   DYNAMIC ARRAY OF RECORD
         oofg019       LIKE oofg_t.oofg019,  #field
         oofg020       LIKE oofg_t.oofg020   #value
                        END RECORD   
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
   DISPLAY BY NAME g_prda_m.prdasite,g_prda_m.prdasite_desc,g_prda_m.prdadocdt,g_prda_m.prdadocno,g_prda_m.prda000, 
       g_prda_m.prda001,g_prda_m.prda002,g_prda_m.prdal002,g_prda_m.prda006,g_prda_m.prda006_desc,g_prda_m.prda007, 
       g_prda_m.prda007_desc,g_prda_m.prda027,g_prda_m.prdastus,g_prda_m.prda034,g_prda_m.l_prdd003_1, 
       g_prda_m.l_prdd004_1,g_prda_m.prda026,g_prda_m.l_prdb005_1,g_prda_m.prda033,g_prda_m.prda033_desc, 
       g_prda_m.prda008,g_prda_m.prda008_desc,g_prda_m.prda009,g_prda_m.prda009_desc,g_prda_m.prda023, 
       g_prda_m.prda003,g_prda_m.prda028,g_prda_m.prda038,g_prda_m.prda011,g_prda_m.prda015,g_prda_m.prda020, 
       g_prda_m.prda012,g_prda_m.prda016,g_prda_m.prda014,g_prda_m.prda013,g_prda_m.prda010,g_prda_m.prda017, 
       g_prda_m.prda024,g_prda_m.prda018,g_prda_m.prda025,g_prda_m.prda019,g_prda_m.prda032,g_prda_m.prda021, 
       g_prda_m.prda022,g_prda_m.prda029,g_prda_m.prda030,g_prda_m.prda031,g_prda_m.prda037,g_prda_m.prda098, 
       g_prda_m.prda101,g_prda_m.prda102,g_prda_m.prda103,g_prda_m.prdaunit,g_prda_m.prdaunit_desc,g_prda_m.prdaacti, 
       g_prda_m.prda004,g_prda_m.prda004_desc,g_prda_m.prda005,g_prda_m.prda005_desc,g_prda_m.prdaownid, 
       g_prda_m.prdaownid_desc,g_prda_m.prdaowndp,g_prda_m.prdaowndp_desc,g_prda_m.prdacrtid,g_prda_m.prdacrtid_desc, 
       g_prda_m.prdacrtdp,g_prda_m.prdacrtdp_desc,g_prda_m.prdacrtdt,g_prda_m.prdamodid,g_prda_m.prdamodid_desc, 
       g_prda_m.prdamoddt,g_prda_m.prdacnfid,g_prda_m.prdacnfid_desc,g_prda_m.prdacnfdt
   
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
   LET g_forupd_sql = "SELECT prdeacti,prde003,prde004,prde002,prde001,prdesite,prdeunit FROM prde_t  
       WHERE prdeent=? AND prdedocno=? AND prde002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt219_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprt219_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aprt219_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prda_m.prdasite,g_prda_m.prdadocdt,g_prda_m.prdadocno,g_prda_m.prda000,g_prda_m.prda001, 
       g_prda_m.prda002,g_prda_m.prdal002,g_prda_m.prda006,g_prda_m.prda007,g_prda_m.prda027,g_prda_m.prdastus, 
       g_prda_m.prda034,g_prda_m.l_prdd003_1,g_prda_m.l_prdd004_1,g_prda_m.prda026,g_prda_m.l_prdb005_1, 
       g_prda_m.prda033,g_prda_m.prda008,g_prda_m.prda009,g_prda_m.prda023,g_prda_m.prda003,g_prda_m.prda028, 
       g_prda_m.prda038,g_prda_m.prda011,g_prda_m.prda015,g_prda_m.prda020,g_prda_m.prda012,g_prda_m.prda016, 
       g_prda_m.prda014,g_prda_m.prda013,g_prda_m.prda010,g_prda_m.prda017,g_prda_m.prda024,g_prda_m.prda018, 
       g_prda_m.prda025,g_prda_m.prda019,g_prda_m.prda032,g_prda_m.prda021,g_prda_m.prda022,g_prda_m.prda029, 
       g_prda_m.prda030,g_prda_m.prda031,g_prda_m.prda037,g_prda_m.prda098,g_prda_m.prda101,g_prda_m.prda102, 
       g_prda_m.prda103,g_prda_m.prdaunit,g_prda_m.prdaacti,g_prda_m.prda004,g_prda_m.prda005
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aprt219.input.head" >}
      #單頭段
      INPUT BY NAME g_prda_m.prdasite,g_prda_m.prdadocdt,g_prda_m.prdadocno,g_prda_m.prda000,g_prda_m.prda001, 
          g_prda_m.prda002,g_prda_m.prdal002,g_prda_m.prda006,g_prda_m.prda007,g_prda_m.prda027,g_prda_m.prdastus, 
          g_prda_m.prda034,g_prda_m.l_prdd003_1,g_prda_m.l_prdd004_1,g_prda_m.prda026,g_prda_m.l_prdb005_1, 
          g_prda_m.prda033,g_prda_m.prda008,g_prda_m.prda009,g_prda_m.prda023,g_prda_m.prda003,g_prda_m.prda028, 
          g_prda_m.prda038,g_prda_m.prda011,g_prda_m.prda015,g_prda_m.prda020,g_prda_m.prda012,g_prda_m.prda016, 
          g_prda_m.prda014,g_prda_m.prda013,g_prda_m.prda010,g_prda_m.prda017,g_prda_m.prda024,g_prda_m.prda018, 
          g_prda_m.prda025,g_prda_m.prda019,g_prda_m.prda032,g_prda_m.prda021,g_prda_m.prda022,g_prda_m.prda029, 
          g_prda_m.prda030,g_prda_m.prda031,g_prda_m.prda037,g_prda_m.prda098,g_prda_m.prda101,g_prda_m.prda102, 
          g_prda_m.prda103,g_prda_m.prdaunit,g_prda_m.prdaacti,g_prda_m.prda004,g_prda_m.prda005 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               CALL n_prdal(g_prda_m.prdadocno)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prda_m.prdadocno
               CALL ap_ref_array2(g_ref_fields," SELECT prdal002 FROM prdal_t WHERE prdalent = '"||g_enterprise||"' AND prdaldocno = ? AND prdal001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prda_m.prdal002 = g_rtn_fields[1]
               DISPLAY BY NAME g_prda_m.prdal002
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aprt219_cl USING g_enterprise,g_prda_m.prdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt219_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt219_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.prdaldocno = g_prda_m.prdadocno
LET g_master_multi_table_t.prdal002 = g_prda_m.prdal002
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.prdaldocno = ''
LET g_master_multi_table_t.prdal002 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aprt219_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aprt219_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdasite
            
            #add-point:AFTER FIELD prdasite name="input.a.prdasite"
            IF NOT cl_null(g_prda_m.prdasite) THEN
               CALL s_aooi500_chk(g_prog,'prcasite',g_prda_m.prdasite,g_prda_m.prdasite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF              
            LET g_site_flag = TRUE            
            CALL aprt219_set_entry(p_cmd)
            CALL aprt219_set_no_entry(p_cmd)
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prdasite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prdasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prdasite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdasite
            #add-point:BEFORE FIELD prdasite name="input.b.prdasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdasite
            #add-point:ON CHANGE prdasite name="input.g.prdasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdadocdt
            #add-point:BEFORE FIELD prdadocdt name="input.b.prdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdadocdt
            
            #add-point:AFTER FIELD prdadocdt name="input.a.prdadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdadocdt
            #add-point:ON CHANGE prdadocdt name="input.g.prdadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdadocno
            #add-point:BEFORE FIELD prdadocno name="input.b.prdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdadocno
            
            #add-point:AFTER FIELD prdadocno name="input.a.prdadocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_prda_m.prdadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prda_m.prdadocno != g_prdadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prda_t WHERE "||"prdaent = '" ||g_enterprise|| "' AND "||"prdadocno = '"||g_prda_m.prdadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_prda_m.prdadocno) THEN 
               CALL s_aooi200_chk_docno(g_prda_m.prdasite,g_prda_m.prdadocno,g_prda_m.prdadocdt,g_prog) RETURNING l_success #sakura add
               IF NOT l_success THEN
                  LET g_prda_m.prdadocno = g_prdadocno_t
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdadocno
            #add-point:ON CHANGE prdadocno name="input.g.prdadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda000
            #add-point:BEFORE FIELD prda000 name="input.b.prda000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda000
            
            #add-point:AFTER FIELD prda000 name="input.a.prda000"
            IF NOT cl_null(g_prda_m.prda000) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prda_m.prda000 != g_prda_m_t.prda000 )) THEN     #160824-00007#146 Mark By ken 161101
               IF (g_prda_m.prda000 != g_prda_m_o.prda000 ) THEN        #160824-00007#146 Add By ken 161101
                  IF g_prda_m.prda000 != g_prda_m_o.prda000 OR cl_null(g_prda_m_o.prda000) THEN
                     CALL aprt219_prda000_init()
                  END IF
               END IF
               IF g_prda_m.prda000 = 'I' THEN
                  LET g_prda_m.prda002 = 1
               ELSE
                  IF NOT cl_null(g_prda_m.prda001) THEN
                     SELECT MAX(to_number(prdl002)) +1 INTO l_prda002
                       FROM prdl_t
                      WHERE prdlent = g_enterprise
                        AND prdl001 = g_prda_m.prda001
                     IF cl_null(l_prda002) THEN
                        LET g_prda_m.prda002 = 1
                     ELSE
                        LET g_prda_m.prda002 = l_prda002
                     END IF
                  END IF
               END IF               
            END IF
            LET g_prda_m_o.* = g_prda_m.*
            CALL aprt219_set_entry(p_cmd)
            CALL aprt219_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda000
            #add-point:ON CHANGE prda000 name="input.g.prda000"
            CALL aprt219_set_entry(p_cmd)
            CALL aprt219_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda001
            #add-point:BEFORE FIELD prda001 name="input.b.prda001"
            IF g_prda_m.prda000 = 'I' AND p_cmd = 'a' AND cl_null(g_prda_m.prda001) THEN
               LET l_n1 = 0
               SELECT COUNT(*) INTO l_n1
                 FROM oofg_t
                WHERE oofgent = g_enterprise
                  AND oofg002 = '21'
                  AND oofgstus = 'Y'
               IF l_n1 > 0 THEN
                  CALL s_aooi390_gen('21') RETURNING l_success,l_prda001,l_oofg_return
                  LET g_action_choice = ''
                  IF l_success THEN
                     LET g_prda_m.prda001 = l_prda001
                  END IF 
                  IF NOT cl_null(g_prda_m.prda001) THEN
                     CALL aprt219_chk_prda001()
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_prda_m.prda001
                        #160318-00005#41 --s add
                        CASE g_errno
                           WHEN 'sub-01307'
                              LET g_errparam.replace[1] = 'aprm211'
                              LET g_errparam.replace[2] = cl_get_progname('aprm211',g_lang,"2")
                              LET g_errparam.exeprog = 'aprm211'
                           WHEN 'sub-01302'
                              LET g_errparam.replace[1] = 'aprm211'
                              LET g_errparam.replace[2] = cl_get_progname('aprm211',g_lang,"2")
                              LET g_errparam.exeprog = 'aprm211'
                           WHEN 'sub-01315'
                              LET g_errparam.replace[1] = 'aprm211'
                              LET g_errparam.replace[2] = cl_get_progname('aprm211',g_lang,"2")
                              LET g_errparam.exeprog = 'aprm211'
                           WHEN 'sub-01319'
                              LET g_errparam.replace[1] = 'aprm211'
                              LET g_errparam.replace[2] = cl_get_progname('aprm211',g_lang,"2")
                              LET g_errparam.exeprog = 'aprm211'
                           OTHERWISE
                        END CASE
                        #160318-00005#41 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prda_m.prda001 = g_prda_m_t.prda001
                        NEXT FIELD prda001
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda001
            
            #add-point:AFTER FIELD prda001 name="input.a.prda001"
            IF NOT cl_null(g_prda_m.prda001) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prda_m.prda001 != g_prda_m_t.prda001 )) THEN    #160824-00007#146 Mark By ken 161101
               IF (g_prda_m.prda001 != g_prda_m_o.prda001 ) THEN     #160824-00007#146 Add By ken 161101
                  CALL aprt219_chk_prda001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prda_m.prda001
                     #160318-00005#41 --s add
                     CASE g_errno
                        WHEN 'sub-01307'
                           LET g_errparam.replace[1] = 'aprm211'
                           LET g_errparam.replace[2] = cl_get_progname('aprm211',g_lang,"2")
                           LET g_errparam.exeprog = 'aprm211'
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aprm211'
                           LET g_errparam.replace[2] = cl_get_progname('aprm211',g_lang,"2")
                           LET g_errparam.exeprog = 'aprm211'
                        WHEN 'sub-01315'
                           LET g_errparam.replace[1] = 'aprm211'
                           LET g_errparam.replace[2] = cl_get_progname('aprm211',g_lang,"2")
                           LET g_errparam.exeprog = 'aprm211'
                        WHEN 'sub-01319'
                           LET g_errparam.replace[1] = 'aprm211'
                           LET g_errparam.replace[2] = cl_get_progname('aprm211',g_lang,"2")
                           LET g_errparam.exeprog = 'aprm211'
                        OTHERWISE
                     END CASE
                     #160318-00005#41 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prda_m.prda001 = g_prda_m_t.prda001  #160824-00007#146 Mark By ken 161101
                     LET g_prda_m.prda001 = g_prda_m_o.prda001   #160824-00007#146 Add By ken 161101
                     NEXT FIELD prda001
                  END IF
                  IF NOT s_aooi390_chk('21',g_prda_m.prda001) THEN
                     LET g_prda_m.prda001 = g_prda_m_t.prda001
                     NEXT FIELD CURRENT
                  END IF
                  IF g_prda_m.prda000 = 'U' THEN
                     LET l_n1 = 0
                     SELECT COUNT(*) INTO l_n1
                       FROM prda_t
                      WHERE prdaent = g_enterprise
                        AND prda001 = g_prda_m.prda001
                        AND prdastus = 'N'
                     IF l_n1 > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00262'
                        LET g_errparam.extend = g_prda_m.prda001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_prda_m.prda001 = g_prda_m_t.prda001  #160824-00007#146 Mark By ken 161101
                        LET g_prda_m.prda001 = g_prda_m_o.prda001   #160824-00007#146 Add By ken 161101
                        NEXT FIELD prda001
                     END IF  
                  END IF
                  IF g_prda_m.prda001 != g_prda_m_o.prda001 OR cl_null(g_prda_m_o.prda001) THEN
                     CALL aprt219_prda001_init()
                  END IF
               END IF
               IF g_prda_m.prda000 = 'U' THEN
                  SELECT MAX(to_number(prdl002)) +1 INTO l_prda002
                    FROM prdl_t
                   WHERE prdlent = g_enterprise
                     AND prdl001 = g_prda_m.prda001
                  IF cl_null(l_prda002) THEN
                     LET g_prda_m.prda002 = 1
                  ELSE
                     LET g_prda_m.prda002 = l_prda002
                  END IF
               END IF
            END IF
            LET g_prda_m_o.* = g_prda_m.*
            CALL aprt219_set_entry(p_cmd)
            CALL aprt219_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda001
            #add-point:ON CHANGE prda001 name="input.g.prda001"
            CALL aprt219_set_entry(p_cmd)
            CALL aprt219_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda002
            #add-point:BEFORE FIELD prda002 name="input.b.prda002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda002
            
            #add-point:AFTER FIELD prda002 name="input.a.prda002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda002
            #add-point:ON CHANGE prda002 name="input.g.prda002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdal002
            #add-point:BEFORE FIELD prdal002 name="input.b.prdal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdal002
            
            #add-point:AFTER FIELD prdal002 name="input.a.prdal002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdal002
            #add-point:ON CHANGE prdal002 name="input.g.prdal002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda006
            
            #add-point:AFTER FIELD prda006 name="input.a.prda006"
            IF NOT cl_null(g_prda_m.prda006) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prda_m.prda006 != g_prda_m_t.prda006 )) THEN   #160824-00007#146 Mark By ken 161101
               IF (g_prda_m.prda006 != g_prda_m_o.prda006 ) THEN    #160824-00007#146 Add By ken 161101
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prda_m.prda006
                  LET g_chkparam.arg2 = '1'
                  LET g_chkparam.err_str[1] = "apr-00060:sub-01307|aprm201|",cl_get_progname("aprm201",g_lang,"2"),"|:EXEPROGaprm201"  #160318-00025#32  add
                  LET g_chkparam.err_str[2] = "apr-00059:sub-01302|aprm201|",cl_get_progname("aprm201",g_lang,"2"),"|:EXEPROGaprm201"  #160318-00025#32  add
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_prcf001_1") THEN
                     #LET g_prda_m.prda006 = g_prda_m_t.prda006   #160824-00007#146 Mark By ken 161101
                     LET g_prda_m.prda006 = g_prda_m_o.prda006    #160824-00007#146 Add By ken 161101
                     NEXT FIELD CURRENT
                  END IF
                  SELECT prcf002,prcf007,prcf008,prcf009,prcf010
                    INTO g_prda_m.prda007,g_prda_m.prda008,g_prda_m.prda009,g_prda_m.l_prdd003_1,g_prda_m.l_prdd004_1
                    FROM prcf_t
                   WHERE prcfent = g_enterprise
                     AND prcf001 = g_prda_m.prda006                  
               END IF 
            END IF
                       
            IF cl_null(g_prda_m.prda007) AND cl_null(g_prda_m.prda006) THEN
               LET g_prda_m.prda008 = ''
               LET g_prda_m.prda009 = '' 
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda006
            CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda006_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda007
            CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda007_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda008
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2100' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda008_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda009_desc             
            LET g_prda_m_o.* = g_prda_m.*    #160824-00007#146 Add By ken 161101
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda006
            #add-point:BEFORE FIELD prda006 name="input.b.prda006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda006
            #add-point:ON CHANGE prda006 name="input.g.prda006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda007
            
            #add-point:AFTER FIELD prda007 name="input.a.prda007"
            IF NOT cl_null(g_prda_m.prda007) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prda_m.prda007 != g_prda_m_t.prda007 )) THEN    #160824-00007#146 Mark By ken 161101
               IF (g_prda_m.prda007 != g_prda_m_o.prda007 ) THEN   #160824-00007#146 Add By ken 161101
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prda_m.prda007
                  LET g_chkparam.arg2 = '1'
                  LET g_chkparam.err_str[1] = "apr-00004:sub-01302|aprm200|",cl_get_progname("aprm200",g_lang,"2"),"|:EXEPROGaprm200"  #160318-00025#32  add
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_prcd001_1") THEN
                     #LET g_prda_m.prda007 = g_prda_m_t.prda007  #160824-00007#146 Mark By ken 161101
                     LET g_prda_m.prda007 = g_prda_m_o.prda007   #160824-00007#146 Add By ken 161101
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF cl_null(g_prda_m.prda006) THEN
                    SELECT prcd002,prcd003,prcd004,prcd005 
                      INTO g_prda_m.prda008,g_prda_m.prda009,g_prda_m.l_prdd003_1,g_prda_m.l_prdd004_1
                      FROM prcd_t
                     WHERE prcdent = g_enterprise
                       AND prcd001 = g_prda_m.prda007
                  END IF
                  
                  IF NOT cl_null(g_prda_m.prda006) THEN 
                     LET l_count = ''
                     SELECT COUNT(*) INTO l_count
                       FROM prcf_t
                      WHERE prcfent = g_enterprise
                        AND prcf001 = g_prda_m.prda006 
                        AND prcf002=g_prda_m.prda007
                     IF cl_null(l_count) OR l_count=0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00065'
                        LET g_errparam.extend = g_prda_m.prda007
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_prda_m.prda007 = g_prda_m_t.prda007  #160824-00007#146 Mark By ken 161101
                        LET g_prda_m.prda007 = g_prda_m_o.prda007   #160824-00007#146 Add By ken 161101
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               
               END IF 
            END IF

            IF cl_null(g_prda_m.prda007) AND cl_null(g_prda_m.prda006) THEN
               LET g_prda_m.prda008 = ''
               LET g_prda_m.prda009 = '' 
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda007
            CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda007_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda008
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2100' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda008_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda009_desc             
            LET g_prda_m_o.* = g_prda_m.*    #160824-00007#146 Add By ken 161101
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda007
            #add-point:BEFORE FIELD prda007 name="input.b.prda007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda007
            #add-point:ON CHANGE prda007 name="input.g.prda007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda027
            #add-point:BEFORE FIELD prda027 name="input.b.prda027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda027
            
            #add-point:AFTER FIELD prda027 name="input.a.prda027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda027
            #add-point:ON CHANGE prda027 name="input.g.prda027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdastus
            #add-point:BEFORE FIELD prdastus name="input.b.prdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdastus
            
            #add-point:AFTER FIELD prdastus name="input.a.prdastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdastus
            #add-point:ON CHANGE prdastus name="input.g.prdastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda034
            #add-point:BEFORE FIELD prda034 name="input.b.prda034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda034
            
            #add-point:AFTER FIELD prda034 name="input.a.prda034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda034
            #add-point:ON CHANGE prda034 name="input.g.prda034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_prdd003_1
            #add-point:BEFORE FIELD l_prdd003_1 name="input.b.l_prdd003_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_prdd003_1
            
            #add-point:AFTER FIELD l_prdd003_1 name="input.a.l_prdd003_1"
            IF NOT cl_null(g_prda_m.l_prdd003_1) AND NOT cl_null(g_prda_m.l_prdd004_1) THEN
               IF g_prda_m.l_prdd003_1 > g_prda_m.l_prdd004_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00080'
                  LET g_errparam.extend = g_prda_m.l_prdd003_1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prda_m.l_prdd003_1 = g_prda_m_t.l_prdd003_1
                  NEXT FIELD l_prdd003_1
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_prdd003_1
            #add-point:ON CHANGE l_prdd003_1 name="input.g.l_prdd003_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_prdd004_1
            #add-point:BEFORE FIELD l_prdd004_1 name="input.b.l_prdd004_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_prdd004_1
            
            #add-point:AFTER FIELD l_prdd004_1 name="input.a.l_prdd004_1"
            IF NOT cl_null(g_prda_m.l_prdd003_1) AND NOT cl_null(g_prda_m.l_prdd004_1) THEN
               IF g_prda_m.l_prdd003_1 > g_prda_m.l_prdd004_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00081'
                  LET g_errparam.extend = g_prda_m.l_prdd003_1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prda_m.l_prdd004_1 = g_prda_m_t.l_prdd004_1
                  NEXT FIELD l_prdd004_1
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_prdd004_1
            #add-point:ON CHANGE l_prdd004_1 name="input.g.l_prdd004_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda026
            #add-point:BEFORE FIELD prda026 name="input.b.prda026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda026
            
            #add-point:AFTER FIELD prda026 name="input.a.prda026"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda026
            #add-point:ON CHANGE prda026 name="input.g.prda026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_prdb005_1
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prda_m.l_prdb005_1,"0","1","","","azz-00079",1) THEN
               NEXT FIELD l_prdb005_1
            END IF 
 
 
 
            #add-point:AFTER FIELD l_prdb005_1 name="input.a.l_prdb005_1"
            IF NOT cl_null(g_prda_m.l_prdb005_1) THEN 
               IF g_prda_m.l_prdb005_1 < 0 OR g_prda_m.l_prdb005_1 > 100 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00077'
                  LET g_errparam.extend = g_prda_m.l_prdb005_1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  LET g_prda_m.l_prdb005_1 = g_prda_m_t.l_prdb005_1
                  NEXT FIELD l_prdb005_1
               END IF            
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_prdb005_1
            #add-point:BEFORE FIELD l_prdb005_1 name="input.b.l_prdb005_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_prdb005_1
            #add-point:ON CHANGE l_prdb005_1 name="input.g.l_prdb005_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda033
            
            #add-point:AFTER FIELD prda033 name="input.a.prda033"

            IF NOT cl_null(g_prda_m.prda033) THEN 
            #應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = "2135"
               LET g_chkparam.arg2 = g_prda_m.prda033
               LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"  #160318-00025#32  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_01") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                   LET g_prda_m.prda033 = g_prda_m_t.prda033
                  NEXT FIELD CURRENT
               END IF          

            END IF 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda033
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2135' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda033_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda033_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda033
            #add-point:BEFORE FIELD prda033 name="input.b.prda033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda033
            #add-point:ON CHANGE prda033 name="input.g.prda033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda008
            
            #add-point:AFTER FIELD prda008 name="input.a.prda008"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda008
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND '2100'=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda008_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda008
            #add-point:BEFORE FIELD prda008 name="input.b.prda008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda008
            #add-point:ON CHANGE prda008 name="input.g.prda008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda009
            
            #add-point:AFTER FIELD prda009 name="input.a.prda009"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND '2101'=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda009_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda009
            #add-point:BEFORE FIELD prda009 name="input.b.prda009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda009
            #add-point:ON CHANGE prda009 name="input.g.prda009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda023
            #add-point:BEFORE FIELD prda023 name="input.b.prda023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda023
            
            #add-point:AFTER FIELD prda023 name="input.a.prda023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda023
            #add-point:ON CHANGE prda023 name="input.g.prda023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda003
            #add-point:BEFORE FIELD prda003 name="input.b.prda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda003
            
            #add-point:AFTER FIELD prda003 name="input.a.prda003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda003
            #add-point:ON CHANGE prda003 name="input.g.prda003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda028
            #add-point:BEFORE FIELD prda028 name="input.b.prda028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda028
            
            #add-point:AFTER FIELD prda028 name="input.a.prda028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda028
            #add-point:ON CHANGE prda028 name="input.g.prda028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda038
            #add-point:BEFORE FIELD prda038 name="input.b.prda038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda038
            
            #add-point:AFTER FIELD prda038 name="input.a.prda038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda038
            #add-point:ON CHANGE prda038 name="input.g.prda038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda011
            #add-point:BEFORE FIELD prda011 name="input.b.prda011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda011
            
            #add-point:AFTER FIELD prda011 name="input.a.prda011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda011
            #add-point:ON CHANGE prda011 name="input.g.prda011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda015
            #add-point:BEFORE FIELD prda015 name="input.b.prda015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda015
            
            #add-point:AFTER FIELD prda015 name="input.a.prda015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda015
            #add-point:ON CHANGE prda015 name="input.g.prda015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda020
            #add-point:BEFORE FIELD prda020 name="input.b.prda020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda020
            
            #add-point:AFTER FIELD prda020 name="input.a.prda020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda020
            #add-point:ON CHANGE prda020 name="input.g.prda020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda012
            #add-point:BEFORE FIELD prda012 name="input.b.prda012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda012
            
            #add-point:AFTER FIELD prda012 name="input.a.prda012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda012
            #add-point:ON CHANGE prda012 name="input.g.prda012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda016
            #add-point:BEFORE FIELD prda016 name="input.b.prda016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda016
            
            #add-point:AFTER FIELD prda016 name="input.a.prda016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda016
            #add-point:ON CHANGE prda016 name="input.g.prda016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda014
            #add-point:BEFORE FIELD prda014 name="input.b.prda014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda014
            
            #add-point:AFTER FIELD prda014 name="input.a.prda014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda014
            #add-point:ON CHANGE prda014 name="input.g.prda014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda013
            #add-point:BEFORE FIELD prda013 name="input.b.prda013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda013
            
            #add-point:AFTER FIELD prda013 name="input.a.prda013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda013
            #add-point:ON CHANGE prda013 name="input.g.prda013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda010
            #add-point:BEFORE FIELD prda010 name="input.b.prda010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda010
            
            #add-point:AFTER FIELD prda010 name="input.a.prda010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda010
            #add-point:ON CHANGE prda010 name="input.g.prda010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda017
            #add-point:BEFORE FIELD prda017 name="input.b.prda017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda017
            
            #add-point:AFTER FIELD prda017 name="input.a.prda017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda017
            #add-point:ON CHANGE prda017 name="input.g.prda017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda024
            #add-point:BEFORE FIELD prda024 name="input.b.prda024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda024
            
            #add-point:AFTER FIELD prda024 name="input.a.prda024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda024
            #add-point:ON CHANGE prda024 name="input.g.prda024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda018
            #add-point:BEFORE FIELD prda018 name="input.b.prda018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda018
            
            #add-point:AFTER FIELD prda018 name="input.a.prda018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda018
            #add-point:ON CHANGE prda018 name="input.g.prda018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda025
            #add-point:BEFORE FIELD prda025 name="input.b.prda025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda025
            
            #add-point:AFTER FIELD prda025 name="input.a.prda025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda025
            #add-point:ON CHANGE prda025 name="input.g.prda025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda019
            #add-point:BEFORE FIELD prda019 name="input.b.prda019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda019
            
            #add-point:AFTER FIELD prda019 name="input.a.prda019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda019
            #add-point:ON CHANGE prda019 name="input.g.prda019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda032
            #add-point:BEFORE FIELD prda032 name="input.b.prda032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda032
            
            #add-point:AFTER FIELD prda032 name="input.a.prda032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda032
            #add-point:ON CHANGE prda032 name="input.g.prda032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda021
            #add-point:BEFORE FIELD prda021 name="input.b.prda021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda021
            
            #add-point:AFTER FIELD prda021 name="input.a.prda021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda021
            #add-point:ON CHANGE prda021 name="input.g.prda021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prda_m.prda022,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prda022
            END IF 
 
 
 
            #add-point:AFTER FIELD prda022 name="input.a.prda022"
            IF NOT cl_null(g_prda_m.prda022) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda022
            #add-point:BEFORE FIELD prda022 name="input.b.prda022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda022
            #add-point:ON CHANGE prda022 name="input.g.prda022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda029
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prda_m.prda029,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD prda029
            END IF 
 
 
 
            #add-point:AFTER FIELD prda029 name="input.a.prda029"
            IF NOT cl_null(g_prda_m.prda029) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda029
            #add-point:BEFORE FIELD prda029 name="input.b.prda029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda029
            #add-point:ON CHANGE prda029 name="input.g.prda029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda030
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prda_m.prda030,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD prda030
            END IF 
 
 
 
            #add-point:AFTER FIELD prda030 name="input.a.prda030"
            IF NOT cl_null(g_prda_m.prda030) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda030
            #add-point:BEFORE FIELD prda030 name="input.b.prda030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda030
            #add-point:ON CHANGE prda030 name="input.g.prda030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda031
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prda_m.prda031,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD prda031
            END IF 
 
 
 
            #add-point:AFTER FIELD prda031 name="input.a.prda031"
            IF NOT cl_null(g_prda_m.prda031) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda031
            #add-point:BEFORE FIELD prda031 name="input.b.prda031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda031
            #add-point:ON CHANGE prda031 name="input.g.prda031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda037
            #add-point:BEFORE FIELD prda037 name="input.b.prda037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda037
            
            #add-point:AFTER FIELD prda037 name="input.a.prda037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda037
            #add-point:ON CHANGE prda037 name="input.g.prda037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda098
            #add-point:BEFORE FIELD prda098 name="input.b.prda098"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda098
            
            #add-point:AFTER FIELD prda098 name="input.a.prda098"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda098
            #add-point:ON CHANGE prda098 name="input.g.prda098"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda101
            #add-point:BEFORE FIELD prda101 name="input.b.prda101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda101
            
            #add-point:AFTER FIELD prda101 name="input.a.prda101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda101
            #add-point:ON CHANGE prda101 name="input.g.prda101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda102
            #add-point:BEFORE FIELD prda102 name="input.b.prda102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda102
            
            #add-point:AFTER FIELD prda102 name="input.a.prda102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda102
            #add-point:ON CHANGE prda102 name="input.g.prda102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda103
            #add-point:BEFORE FIELD prda103 name="input.b.prda103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda103
            
            #add-point:AFTER FIELD prda103 name="input.a.prda103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda103
            #add-point:ON CHANGE prda103 name="input.g.prda103"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdaunit
            
            #add-point:AFTER FIELD prdaunit name="input.a.prdaunit"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prdaunit
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prdaunit_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prdaunit_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdaunit
            #add-point:BEFORE FIELD prdaunit name="input.b.prdaunit"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdaunit
            #add-point:ON CHANGE prdaunit name="input.g.prdaunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdaacti
            #add-point:BEFORE FIELD prdaacti name="input.b.prdaacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdaacti
            
            #add-point:AFTER FIELD prdaacti name="input.a.prdaacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdaacti
            #add-point:ON CHANGE prdaacti name="input.g.prdaacti"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda004
            
            #add-point:AFTER FIELD prda004 name="input.a.prda004"
            IF NOT cl_null(g_prda_m.prda004) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prda_m.prda004
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#32  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooag001") THEN
                  #LET g_prda_m.prda004 = g_prda_m_t.prda004  #160824-00007#146 Mark By ken 161101
                  LET g_prda_m.prda004 = g_prda_m_o.prda004   #160824-00007#146 Add By ken 161101
                  NEXT FIELD CURRENT
               END IF
               SELECT ooag003 INTO g_prda_m.prda005
                 FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooag001 = g_prda_m.prda004
            END IF 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prda_m.prda004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda004_desc            
            LET g_prda_m_o.* = g_prda_m.*    #160824-00007#146 Add By ken 161101
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda004
            #add-point:BEFORE FIELD prda004 name="input.b.prda004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda004
            #add-point:ON CHANGE prda004 name="input.g.prda004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prda005
            
            #add-point:AFTER FIELD prda005 name="input.a.prda005"
            IF NOT cl_null(g_prda_m.prda005) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prda_m.prda005
               LET g_chkparam.arg2 = g_prda_m.prdadocdt
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#32  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  #LET g_prda_m.prda005 = g_prda_m_t.prda005  #160824-00007#146 Mark By ken 161101
                  LET g_prda_m.prda005 = g_prda_m_o.prda005   #160824-00007#146 Add By ken 161101
                  NEXT FIELD CURRENT
               END IF
            END IF            
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda005_desc
            LET g_prda_m_o.* = g_prda_m.*    #160824-00007#146 Add By ken 161101
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prda005
            #add-point:BEFORE FIELD prda005 name="input.b.prda005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prda005
            #add-point:ON CHANGE prda005 name="input.g.prda005"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.prdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdasite
            #add-point:ON ACTION controlp INFIELD prdasite name="input.c.prdasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prda_m.prdasite             #給予default值

            #給予arg
            
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prdasite',g_prda_m.prdasite,'i') 
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_prda_m.prdasite = g_qryparam.return1              

            DISPLAY g_prda_m.prdasite TO prdasite              #

            CALL s_desc_get_department_desc(g_prda_m.prdasite)
               RETURNING g_prda_m.prdasite_desc
            DISPLAY BY NAME g_prda_m.prdasite,g_prda_m.prdasite_desc
            
            NEXT FIELD prdasite                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.prdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdadocdt
            #add-point:ON ACTION controlp INFIELD prdadocdt name="input.c.prdadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdadocno
            #add-point:ON ACTION controlp INFIELD prdadocno name="input.c.prdadocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prda_m.prdadocno             #給予default值

            #給予arg
            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
            LET g_qryparam.arg1 = l_ooef004 #參照表編號
            LET g_qryparam.arg2 = g_prog #作业代号

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_prda_m.prdadocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prda_m.prdadocno TO prdadocno              #顯示到畫面上

            NEXT FIELD prdadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prda000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda000
            #add-point:ON ACTION controlp INFIELD prda000 name="input.c.prda000"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda001
            #add-point:ON ACTION controlp INFIELD prda001 name="input.c.prda001"
            IF g_prda_m.prda000 = 'U' THEN
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
			   
               LET g_qryparam.default1 = g_prda_m.prda001             #給予default值
			   
               #給予arg
               LET g_qryparam.arg1 = '1'
               LET g_qryparam.arg2 = '1'
               LET g_qryparam.where = " prdlunit = '",g_site,"'"," AND prdl103='",g_prog,"'"
               CALL q_prdl001()                                #呼叫開窗
			   
               LET g_prda_m.prda001 = g_qryparam.return1              #將開窗取得的值回傳到變數
			   
               DISPLAY g_prda_m.prda001 TO prda001              #顯示到畫面上
			   
               NEXT FIELD prda001                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.prda002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda002
            #add-point:ON ACTION controlp INFIELD prda002 name="input.c.prda002"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdal002
            #add-point:ON ACTION controlp INFIELD prdal002 name="input.c.prdal002"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda006
            #add-point:ON ACTION controlp INFIELD prda006 name="input.c.prda006"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prda_m.prda006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '1'
            CALL q_prcf001()                                #呼叫開窗

            LET g_prda_m.prda006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prda_m.prda006 TO prda006              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda006
            CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda006_desc
                       
            NEXT FIELD prda006                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.prda007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda007
            #add-point:ON ACTION controlp INFIELD prda007 name="input.c.prda007"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prda_m.prda007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '1'
            CALL q_prcd001_1()                                #呼叫開窗

            LET g_prda_m.prda007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prda_m.prda007 TO prda007              #顯示到畫面上
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda007
            CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda007_desc         
            
            NEXT FIELD prda007                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.prda027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda027
            #add-point:ON ACTION controlp INFIELD prda027 name="input.c.prda027"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdastus
            #add-point:ON ACTION controlp INFIELD prdastus name="input.c.prdastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda034
            #add-point:ON ACTION controlp INFIELD prda034 name="input.c.prda034"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_prdd003_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_prdd003_1
            #add-point:ON ACTION controlp INFIELD l_prdd003_1 name="input.c.l_prdd003_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_prdd004_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_prdd004_1
            #add-point:ON ACTION controlp INFIELD l_prdd004_1 name="input.c.l_prdd004_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda026
            #add-point:ON ACTION controlp INFIELD prda026 name="input.c.prda026"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_prdb005_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_prdb005_1
            #add-point:ON ACTION controlp INFIELD l_prdb005_1 name="input.c.l_prdb005_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda033
            #add-point:ON ACTION controlp INFIELD prda033 name="input.c.prda033"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prda_m.prda033             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "2135" #s

            CALL q_oocq002()                                #呼叫開窗

            LET g_prda_m.prda033 = g_qryparam.return1   
            DISPLAY g_prda_m.prda033 TO prda033 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda033
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2135' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda033_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda033_desc
            
            NEXT FIELD prda033                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.prda008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda008
            #add-point:ON ACTION controlp INFIELD prda008 name="input.c.prda008"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda009
            #add-point:ON ACTION controlp INFIELD prda009 name="input.c.prda009"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda023
            #add-point:ON ACTION controlp INFIELD prda023 name="input.c.prda023"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda003
            #add-point:ON ACTION controlp INFIELD prda003 name="input.c.prda003"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda028
            #add-point:ON ACTION controlp INFIELD prda028 name="input.c.prda028"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda038
            #add-point:ON ACTION controlp INFIELD prda038 name="input.c.prda038"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda011
            #add-point:ON ACTION controlp INFIELD prda011 name="input.c.prda011"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda015
            #add-point:ON ACTION controlp INFIELD prda015 name="input.c.prda015"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda020
            #add-point:ON ACTION controlp INFIELD prda020 name="input.c.prda020"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda012
            #add-point:ON ACTION controlp INFIELD prda012 name="input.c.prda012"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda016
            #add-point:ON ACTION controlp INFIELD prda016 name="input.c.prda016"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda014
            #add-point:ON ACTION controlp INFIELD prda014 name="input.c.prda014"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda013
            #add-point:ON ACTION controlp INFIELD prda013 name="input.c.prda013"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda010
            #add-point:ON ACTION controlp INFIELD prda010 name="input.c.prda010"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda017
            #add-point:ON ACTION controlp INFIELD prda017 name="input.c.prda017"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda024
            #add-point:ON ACTION controlp INFIELD prda024 name="input.c.prda024"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda018
            #add-point:ON ACTION controlp INFIELD prda018 name="input.c.prda018"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda025
            #add-point:ON ACTION controlp INFIELD prda025 name="input.c.prda025"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda019
            #add-point:ON ACTION controlp INFIELD prda019 name="input.c.prda019"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda032
            #add-point:ON ACTION controlp INFIELD prda032 name="input.c.prda032"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda021
            #add-point:ON ACTION controlp INFIELD prda021 name="input.c.prda021"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda022
            #add-point:ON ACTION controlp INFIELD prda022 name="input.c.prda022"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda029
            #add-point:ON ACTION controlp INFIELD prda029 name="input.c.prda029"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda030
            #add-point:ON ACTION controlp INFIELD prda030 name="input.c.prda030"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda031
            #add-point:ON ACTION controlp INFIELD prda031 name="input.c.prda031"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda037
            #add-point:ON ACTION controlp INFIELD prda037 name="input.c.prda037"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda098
            #add-point:ON ACTION controlp INFIELD prda098 name="input.c.prda098"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda101
            #add-point:ON ACTION controlp INFIELD prda101 name="input.c.prda101"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda102
            #add-point:ON ACTION controlp INFIELD prda102 name="input.c.prda102"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda103
            #add-point:ON ACTION controlp INFIELD prda103 name="input.c.prda103"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdaunit
            #add-point:ON ACTION controlp INFIELD prdaunit name="input.c.prdaunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdaacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdaacti
            #add-point:ON ACTION controlp INFIELD prdaacti name="input.c.prdaacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.prda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda004
            #add-point:ON ACTION controlp INFIELD prda004 name="input.c.prda004"
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prda_m.prda004             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_prda_m.prda004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prda_m.prda004 TO prda004              #顯示到畫面上
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prda_m.prda004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda004_desc
            
            NEXT FIELD prda004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.prda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prda005
            #add-point:ON ACTION controlp INFIELD prda005 name="input.c.prda005"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prda_m.prda005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_prda_m.prdadocdt #

            CALL q_ooeg001()                                #呼叫開窗

            LET g_prda_m.prda005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prda_m.prda005 TO prda005              #顯示到畫面上
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prda_m.prda005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prda_m.prda005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prda_m.prda005_desc

            NEXT FIELD prda005                          #返回原欄位
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_prda_m.prdadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_prda_m.prdasite,g_prda_m.prdadocno,g_prda_m.prdadocdt,g_prog) RETURNING l_success,g_prda_m.prdadocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_prda_m.prdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prda_m.prdadocno = g_prdadocno_t
                  NEXT FIELD prdadocno
               END IF
               LET g_prda_m.prdaunit = g_prda_m.prdasite 
               IF g_prda_m.prda000 = 'I' THEN  #5  新增类型才自动编号   
                  CALL s_aooi390_get_auto_no('21',g_prda_m.prda001) RETURNING l_success,g_prda_m.prda001
                  
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF
                  
                  #判断自动编出来的号里面有&，不能编号           
                  LET l_str = g_prda_m.prda001
                  IF l_str.getIndexOf('&',1) > 0 THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF         
                  
                  CALL s_aooi390_oofi_upd('21',g_prda_m.prda001) RETURNING l_success  #add by geza 20150601增加編碼功能
               END IF
               #end add-point
               
               INSERT INTO prda_t (prdaent,prdasite,prdadocdt,prdadocno,prda000,prda001,prda002,prda006, 
                   prda007,prda027,prdastus,prda034,prda026,prda033,prda008,prda009,prda023,prda003, 
                   prda028,prda038,prda011,prda015,prda020,prda012,prda016,prda014,prda013,prda010,prda017, 
                   prda024,prda018,prda025,prda019,prda032,prda021,prda022,prda029,prda030,prda031,prda037, 
                   prda098,prda101,prda102,prda103,prdaunit,prdaacti,prda004,prda005,prdaownid,prdaowndp, 
                   prdacrtid,prdacrtdp,prdacrtdt,prdamodid,prdamoddt,prdacnfid,prdacnfdt)
               VALUES (g_enterprise,g_prda_m.prdasite,g_prda_m.prdadocdt,g_prda_m.prdadocno,g_prda_m.prda000, 
                   g_prda_m.prda001,g_prda_m.prda002,g_prda_m.prda006,g_prda_m.prda007,g_prda_m.prda027, 
                   g_prda_m.prdastus,g_prda_m.prda034,g_prda_m.prda026,g_prda_m.prda033,g_prda_m.prda008, 
                   g_prda_m.prda009,g_prda_m.prda023,g_prda_m.prda003,g_prda_m.prda028,g_prda_m.prda038, 
                   g_prda_m.prda011,g_prda_m.prda015,g_prda_m.prda020,g_prda_m.prda012,g_prda_m.prda016, 
                   g_prda_m.prda014,g_prda_m.prda013,g_prda_m.prda010,g_prda_m.prda017,g_prda_m.prda024, 
                   g_prda_m.prda018,g_prda_m.prda025,g_prda_m.prda019,g_prda_m.prda032,g_prda_m.prda021, 
                   g_prda_m.prda022,g_prda_m.prda029,g_prda_m.prda030,g_prda_m.prda031,g_prda_m.prda037, 
                   g_prda_m.prda098,g_prda_m.prda101,g_prda_m.prda102,g_prda_m.prda103,g_prda_m.prdaunit, 
                   g_prda_m.prdaacti,g_prda_m.prda004,g_prda_m.prda005,g_prda_m.prdaownid,g_prda_m.prdaowndp, 
                   g_prda_m.prdacrtid,g_prda_m.prdacrtdp,g_prda_m.prdacrtdt,g_prda_m.prdamodid,g_prda_m.prdamoddt, 
                   g_prda_m.prdacnfid,g_prda_m.prdacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_prda_m:",SQLERRMESSAGE 
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
         IF g_prda_m.prdadocno = g_master_multi_table_t.prdaldocno AND
         g_prda_m.prdal002 = g_master_multi_table_t.prdal002  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'prdalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_prda_m.prdadocno
            LET l_field_keys[02] = 'prdaldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.prdaldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'prdal001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_prda_m.prdal002
            LET l_fields[01] = 'prdal002'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'prdal_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               #新增日期資料
               INSERT INTO prdd_t(prddent,prddunit,prddsite,prdddocno,prdd001,prdd002,prdd003,prdd004,prdd005,prdd006,prddacti)
                           VALUES(g_enterprise,g_prda_m.prdasite,g_prda_m.prdasite,g_prda_m.prdadocno,g_prda_m.prda001,1,g_prda_m.l_prdd003_1,g_prda_m.l_prdd004_1,'00:00:00','23:59:59','Y')               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "ins_prdd"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF  
               #條件檔----只寫一筆條件檔資料
               INSERT INTO prdh_t(prdhent,prdhunit,prdhsite,prdhdocno,prdh000,prdh001,prdh002,prdh003,prdh008,prdh009,prdhacti)
                           VALUES(g_enterprise,g_prda_m.prdasite,g_prda_m.prdasite,g_prda_m.prdadocno,'1',g_prda_m.prda001,1,'0','0',g_prda_m.prda024,'Y') 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "ins_prdd"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #對象檔--散客
               IF g_prda_m.prda026 = '1'  OR g_prda_m.prda026 = '3'  THEN
                  #散客
                  IF NOT cl_null(g_prda_m.l_prdb005_1) THEN
                     INSERT INTO prdb_t(prdbent,prdbunit,prdbsite,prdbdocno,prdb001,prdb002,prdb003,prdb004,prdb005,prdbacti)
                                 VALUES(g_enterprise,g_prda_m.prdasite,g_prda_m.prdasite,g_prda_m.prdadocno,g_prda_m.prda001,1,'1',1,g_prda_m.l_prdb005_1,'Y')         
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ins_prdd"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                     
                  END IF
               END IF
               #對象檔--會員
               IF g_prda_m.prda026 = '2'  OR g_prda_m.prda026 = '3'  THEN
                  #會員
                  IF NOT cl_null(g_prda_m.l_prdb005_1) THEN
                     INSERT INTO prdb_t(prdbent,prdbunit,prdbsite,prdbdocno,prdb001,prdb002,prdb003,prdb004,prdb005,prdbacti)
                                 VALUES(g_enterprise,g_prda_m.prdasite,g_prda_m.prdasite,g_prda_m.prdadocno,g_prda_m.prda001,2,'2',1,g_prda_m.l_prdb005_1,'Y')         
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ins_prdd"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                     
                  END IF
               END IF                    
               
               #規則修改
               IF g_prda_m.prda000 = 'U' THEN  
                   #INS促銷規則申請生效組織資料檔
                   INSERT INTO prde_t(prdedocno,prdeent,prdeunit,prdesite,prde001,prde002,prde003,prde004,prdeacti)
                   SELECT g_prda_m.prdadocno,prdpent,prdpunit,prdpsite,prdp001,prdp002,prdp003,prdp004,prdpstus
                     FROM prdp_t
                    WHERE prdpent = g_enterprise
                      AND prdp001 = g_prda_m.prda001                                          
                      
                  CALL aprt219_b_fill()
               END IF                                                     

               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aprt219_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aprt219_b_fill()
                  CALL aprt219_b_fill2('0')
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
               CALL aprt219_prda_t_mask_restore('restore_mask_o')
               
               UPDATE prda_t SET (prdasite,prdadocdt,prdadocno,prda000,prda001,prda002,prda006,prda007, 
                   prda027,prdastus,prda034,prda026,prda033,prda008,prda009,prda023,prda003,prda028, 
                   prda038,prda011,prda015,prda020,prda012,prda016,prda014,prda013,prda010,prda017,prda024, 
                   prda018,prda025,prda019,prda032,prda021,prda022,prda029,prda030,prda031,prda037,prda098, 
                   prda101,prda102,prda103,prdaunit,prdaacti,prda004,prda005,prdaownid,prdaowndp,prdacrtid, 
                   prdacrtdp,prdacrtdt,prdamodid,prdamoddt,prdacnfid,prdacnfdt) = (g_prda_m.prdasite, 
                   g_prda_m.prdadocdt,g_prda_m.prdadocno,g_prda_m.prda000,g_prda_m.prda001,g_prda_m.prda002, 
                   g_prda_m.prda006,g_prda_m.prda007,g_prda_m.prda027,g_prda_m.prdastus,g_prda_m.prda034, 
                   g_prda_m.prda026,g_prda_m.prda033,g_prda_m.prda008,g_prda_m.prda009,g_prda_m.prda023, 
                   g_prda_m.prda003,g_prda_m.prda028,g_prda_m.prda038,g_prda_m.prda011,g_prda_m.prda015, 
                   g_prda_m.prda020,g_prda_m.prda012,g_prda_m.prda016,g_prda_m.prda014,g_prda_m.prda013, 
                   g_prda_m.prda010,g_prda_m.prda017,g_prda_m.prda024,g_prda_m.prda018,g_prda_m.prda025, 
                   g_prda_m.prda019,g_prda_m.prda032,g_prda_m.prda021,g_prda_m.prda022,g_prda_m.prda029, 
                   g_prda_m.prda030,g_prda_m.prda031,g_prda_m.prda037,g_prda_m.prda098,g_prda_m.prda101, 
                   g_prda_m.prda102,g_prda_m.prda103,g_prda_m.prdaunit,g_prda_m.prdaacti,g_prda_m.prda004, 
                   g_prda_m.prda005,g_prda_m.prdaownid,g_prda_m.prdaowndp,g_prda_m.prdacrtid,g_prda_m.prdacrtdp, 
                   g_prda_m.prdacrtdt,g_prda_m.prdamodid,g_prda_m.prdamoddt,g_prda_m.prdacnfid,g_prda_m.prdacnfdt) 
 
                WHERE prdaent = g_enterprise AND prdadocno = g_prdadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "prda_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               #更新日期資料
                UPDATE prdd_t SET prdd001 = g_prda_m.prda001,
                                  prdd003 = g_prda_m.l_prdd003_1,
                                  prdd004 = g_prda_m.l_prdd004_1,
                                  prddacti = 'Y'
                WHERE prddent = g_enterprise
                  AND prdddocno = g_prda_m.prdadocno
                  AND prdd002 = 1                 
                IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "upd_prdd"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF  
               
               #更新對象檔
               #更新方式--直接刪除舊資料，然後再根據對象類型新增
               
               #直接刪除舊資料
               DELETE FROM prdb_t WHERE prdbent=g_enterprise AND prdbdocno=g_prda_m.prdadocno
               
               #對象檔--散客
               IF g_prda_m.prda026 = '1'  OR g_prda_m.prda026 = '3'  THEN
                  #散客
                  IF NOT cl_null(g_prda_m.l_prdb005_1) THEN
                     INSERT INTO prdb_t(prdbent,prdbunit,prdbsite,prdbdocno,prdb001,prdb002,prdb003,prdb004,prdb005,prdbacti)
                                 VALUES(g_enterprise,g_prda_m.prdasite,g_prda_m.prdasite,g_prda_m.prdadocno,g_prda_m.prda001,1,'1',1,g_prda_m.l_prdb005_1,'Y')         
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ins_prdd"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                     
                  END IF
               END IF
               #對象檔--會員
               IF g_prda_m.prda026 = '2'  OR g_prda_m.prda026 = '3'  THEN
                  #會員
                  IF NOT cl_null(g_prda_m.l_prdb005_1) THEN
                     INSERT INTO prdb_t(prdbent,prdbunit,prdbsite,prdbdocno,prdb001,prdb002,prdb003,prdb004,prdb005,prdbacti)
                                 VALUES(g_enterprise,g_prda_m.prdasite,g_prda_m.prdasite,g_prda_m.prdadocno,g_prda_m.prda001,2,'2',1,g_prda_m.l_prdb005_1,'Y')         
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ins_prdd"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                     
                  END IF
               END IF                
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_prda_m.prdadocno = g_master_multi_table_t.prdaldocno AND
         g_prda_m.prdal002 = g_master_multi_table_t.prdal002  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'prdalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_prda_m.prdadocno
            LET l_field_keys[02] = 'prdaldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.prdaldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'prdal001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_prda_m.prdal002
            LET l_fields[01] = 'prdal002'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'prdal_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL aprt219_prda_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_prda_m_t)
               LET g_log2 = util.JSON.stringify(g_prda_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_prdadocno_t = g_prda_m.prdadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aprt219.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prde_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prde_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt219_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_prde_d.getLength()
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
            OPEN aprt219_cl USING g_enterprise,g_prda_m.prdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt219_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt219_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prde_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prde_d[l_ac].prde002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prde_d_t.* = g_prde_d[l_ac].*  #BACKUP
               LET g_prde_d_o.* = g_prde_d[l_ac].*  #BACKUP
               CALL aprt219_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aprt219_set_no_entry_b(l_cmd)
               IF NOT aprt219_lock_b("prde_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt219_bcl INTO g_prde_d[l_ac].prdeacti,g_prde_d[l_ac].prde003,g_prde_d[l_ac].prde004, 
                      g_prde_d[l_ac].prde002,g_prde_d[l_ac].prde001,g_prde_d[l_ac].prdesite,g_prde_d[l_ac].prdeunit 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_prde_d_t.prde002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prde_d_mask_o[l_ac].* =  g_prde_d[l_ac].*
                  CALL aprt219_prde_t_mask()
                  LET g_prde_d_mask_n[l_ac].* =  g_prde_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt219_show()
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
            INITIALIZE g_prde_d[l_ac].* TO NULL 
            INITIALIZE g_prde_d_t.* TO NULL 
            INITIALIZE g_prde_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            SELECT MAX(prde002)+1 INTO g_prde_d[l_ac].prde002
              FROM prde_t
             WHERE prdeent = g_enterprise
               AND prdedocno = g_prda_m.prdadocno
            IF cl_null(g_prde_d[l_ac].prde002) THEN
               LET g_prde_d[l_ac].prde002 = 1
            END IF
            LET g_prde_d[l_ac].prde001 = g_prda_m.prda001
            LET g_prde_d[l_ac].prdeunit =  g_prda_m.prdasite
            LET g_prde_d[l_ac].prdesite = g_prda_m.prdasite
            LET g_prde_d[l_ac].prdeacti ='Y'
            LET g_prde_d[l_ac].prde003 ='2'
            #end add-point
            LET g_prde_d_t.* = g_prde_d[l_ac].*     #新輸入資料
            LET g_prde_d_o.* = g_prde_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt219_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt219_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prde_d[li_reproduce_target].* = g_prde_d[li_reproduce].*
 
               LET g_prde_d[li_reproduce_target].prde002 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM prde_t 
             WHERE prdeent = g_enterprise AND prdedocno = g_prda_m.prdadocno
 
               AND prde002 = g_prde_d[l_ac].prde002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prda_m.prdadocno
               LET gs_keys[2] = g_prde_d[g_detail_idx].prde002
               CALL aprt219_insert_b('prde_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_prde_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt219_b_fill()
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
               LET gs_keys[01] = g_prda_m.prdadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_prde_d_t.prde002
 
            
               #刪除同層單身
               IF NOT aprt219_delete_b('prde_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt219_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt219_key_delete_b(gs_keys,'prde_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt219_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt219_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_prde_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prde_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdeacti
            #add-point:BEFORE FIELD prdeacti name="input.b.page1.prdeacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdeacti
            
            #add-point:AFTER FIELD prdeacti name="input.a.page1.prdeacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdeacti
            #add-point:ON CHANGE prdeacti name="input.g.page1.prdeacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prde003
            #add-point:BEFORE FIELD prde003 name="input.b.page1.prde003"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prde003
            
            #add-point:AFTER FIELD prde003 name="input.a.page1.prde003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prde003
            #add-point:ON CHANGE prde003 name="input.g.page1.prde003"
            LET g_prde_d[l_ac].prde004 = ''
            LET g_prde_d[l_ac].prde004_desc = ''
            LET g_prde_d_t.prde004 = ''
            DISPLAY BY NAME g_prde_d[l_ac].prde004
            DISPLAY BY NAME g_prde_d[l_ac].prde004_desc
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prde004
            
            #add-point:AFTER FIELD prde004 name="input.a.page1.prde004"

            IF NOT cl_null(g_prde_d[l_ac].prde004) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND ((g_prde_d[l_ac].prde004 <>　g_prde_d_t.prde004) OR cl_null(g_prde_d_t.prde004))) THEN
                  IF NOT ap_chk_notDup(g_prde_d[l_ac].prde004,"SELECT COUNT(*) FROM prde_t WHERE "||"prdeent = '" ||g_enterprise|| "' AND "||"prdedocno = '"||g_prda_m.prdadocno ||"' AND "||"prde002 <> '"||g_prde_d[l_ac].prde002 ||"' AND "||"prde004 = '"||g_prde_d[l_ac].prde004 ||"' ",'std-00004',1) THEN
                     LET g_prde_d[l_ac].prde004 = g_prde_d_t.prde004                  
                     NEXT FIELD CURRENT
                  END IF
                  IF g_prde_d[l_ac].prde003 = '2' THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_prde_d[l_ac].prde004
                     LET g_chkparam.arg2 = '8'
                     LET g_chkparam.arg3 = g_site
                     IF NOT cl_chk_exist("v_ooed004") THEN
                        LET g_prde_d[l_ac].prde004 = g_prde_d_t.prde004
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL aprt219_chk_prde004() RETURNING l_errno
                  IF NOT cl_null(l_errno) THEN
                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno         #160318-00005#41  mark
                     LET g_errparam.code = l_errno          #160318-00005#41  add
                     LET g_errparam.extend = g_prde_d[l_ac].prde004
                     #160318-00005#41 --s add
                     LET g_errparam.replace[1] = 'arti201'
                     LET g_errparam.replace[2] = cl_get_progname('arti201',g_lang,"2")
                     LET g_errparam.exeprog = 'arti201'
                     #160318-00005#41 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prde_d[l_ac].prde004 = g_prde_d_t.prde004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF g_prde_d[l_ac].prde003 = '1' THEN
               SELECT rtaal003 INTO g_prde_d[l_ac].prde004_desc
                 FROM rtaal_t
                WHERE rtaalent = g_enterprise
                  AND rtaal001 = g_prde_d[l_ac].prde004
                  AND rtaal002 = g_dlang
            ELSE
               SELECT ooefl003 INTO g_prde_d[l_ac].prde004_desc
                 FROM ooefl_t
                WHERE ooeflent = g_enterprise
                  AND ooefl001 = g_prde_d[l_ac].prde004
                  AND ooefl002 = g_dlang
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prde004
            #add-point:BEFORE FIELD prde004 name="input.b.page1.prde004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prde004
            #add-point:ON CHANGE prde004 name="input.g.page1.prde004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prde002
            #add-point:BEFORE FIELD prde002 name="input.b.page1.prde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prde002
            
            #add-point:AFTER FIELD prde002 name="input.a.page1.prde002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_prda_m.prdadocno IS NOT NULL AND g_prde_d[g_detail_idx].prde002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prda_m.prdadocno != g_prdadocno_t OR g_prde_d[g_detail_idx].prde002 != g_prde_d_t.prde002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prde_t WHERE "||"prdeent = '" ||g_enterprise|| "' AND "||"prdedocno = '"||g_prda_m.prdadocno ||"' AND "|| "prde002 = '"||g_prde_d[g_detail_idx].prde002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prde002
            #add-point:ON CHANGE prde002 name="input.g.page1.prde002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prde001
            #add-point:BEFORE FIELD prde001 name="input.b.page1.prde001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prde001
            
            #add-point:AFTER FIELD prde001 name="input.a.page1.prde001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prde001
            #add-point:ON CHANGE prde001 name="input.g.page1.prde001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdesite
            #add-point:BEFORE FIELD prdesite name="input.b.page1.prdesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdesite
            
            #add-point:AFTER FIELD prdesite name="input.a.page1.prdesite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdesite
            #add-point:ON CHANGE prdesite name="input.g.page1.prdesite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdeunit
            #add-point:BEFORE FIELD prdeunit name="input.b.page1.prdeunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdeunit
            
            #add-point:AFTER FIELD prdeunit name="input.a.page1.prdeunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdeunit
            #add-point:ON CHANGE prdeunit name="input.g.page1.prdeunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.prdeacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdeacti
            #add-point:ON ACTION controlp INFIELD prdeacti name="input.c.page1.prdeacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prde003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prde003
            #add-point:ON ACTION controlp INFIELD prde003 name="input.c.page1.prde003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prde004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prde004
            #add-point:ON ACTION controlp INFIELD prde004 name="input.c.page1.prde004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_prde_d[l_ac].prde004   #給予default值
            #給予arg
            IF g_prde_d[l_ac].prde003 = '1' THEN
               LET g_qryparam.arg1 = '4'
               LET g_qryparam.arg2 = g_site
               LET g_qryparam.arg3 = '8'
               CALL q_rtaa001_5()
            ELSE
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = '8'
               CALL q_ooed004()                                #呼叫開窗
            END IF

            LET g_prde_d[l_ac].prde004  = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_prde_d[l_ac].prde004  TO prde004         #顯示到畫面上
            
            IF g_prde_d[l_ac].prde003 = '1' THEN
               SELECT rtaal003 INTO g_prde_d[l_ac].prde004_desc
                 FROM rtaal_t
                WHERE rtaalent = g_enterprise
                  AND rtaal001 = g_prde_d[l_ac].prde004
                  AND rtaal002 = g_dlang
            ELSE
               SELECT ooefl003 INTO g_prde_d[l_ac].prde004_desc
                 FROM ooefl_t
                WHERE ooeflent = g_enterprise
                  AND ooefl001 = g_prde_d[l_ac].prde004
                  AND ooefl002 = g_dlang
            END IF
            
            NEXT FIELD prde004                                 #返回原欄位 
            #END add-point
 
 
         #Ctrlp:input.c.page1.prde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prde002
            #add-point:ON ACTION controlp INFIELD prde002 name="input.c.page1.prde002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prde001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prde001
            #add-point:ON ACTION controlp INFIELD prde001 name="input.c.page1.prde001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prdesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdesite
            #add-point:ON ACTION controlp INFIELD prdesite name="input.c.page1.prdesite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prdeunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdeunit
            #add-point:ON ACTION controlp INFIELD prdeunit name="input.c.page1.prdeunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prde_d[l_ac].* = g_prde_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt219_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_prde_d[l_ac].prde002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prde_d[l_ac].* = g_prde_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aprt219_prde_t_mask_restore('restore_mask_o')
      
               UPDATE prde_t SET (prdedocno,prdeacti,prde003,prde004,prde002,prde001,prdesite,prdeunit) = (g_prda_m.prdadocno, 
                   g_prde_d[l_ac].prdeacti,g_prde_d[l_ac].prde003,g_prde_d[l_ac].prde004,g_prde_d[l_ac].prde002, 
                   g_prde_d[l_ac].prde001,g_prde_d[l_ac].prdesite,g_prde_d[l_ac].prdeunit)
                WHERE prdeent = g_enterprise AND prdedocno = g_prda_m.prdadocno 
 
                  AND prde002 = g_prde_d_t.prde002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prde_d[l_ac].* = g_prde_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prde_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prde_d[l_ac].* = g_prde_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prde_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prda_m.prdadocno
               LET gs_keys_bak[1] = g_prdadocno_t
               LET gs_keys[2] = g_prde_d[g_detail_idx].prde002
               LET gs_keys_bak[2] = g_prde_d_t.prde002
               CALL aprt219_update_b('prde_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aprt219_prde_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_prde_d[g_detail_idx].prde002 = g_prde_d_t.prde002 
 
                  ) THEN
                  LET gs_keys[01] = g_prda_m.prdadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_prde_d_t.prde002
 
                  CALL aprt219_key_update_b(gs_keys,'prde_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prda_m),util.JSON.stringify(g_prde_d_t)
               LET g_log2 = util.JSON.stringify(g_prda_m),util.JSON.stringify(g_prde_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aprt219_unlock_b("prde_t","'1'")
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
               LET g_prde_d[li_reproduce_target].* = g_prde_d[li_reproduce].*
 
               LET g_prde_d[li_reproduce_target].prde002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_prde_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prde_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aprt219.input.other" >}
      
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
            NEXT FIELD prdadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prdeacti
 
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
 
{<section id="aprt219.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprt219_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aprt219_b_fill() #單身填充
      CALL aprt219_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aprt219_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prdasite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prda_m.prdasite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prdasite_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prdadocno
   CALL ap_ref_array2(g_ref_fields," SELECT prdal002 FROM prdal_t WHERE prdalent = '"||g_enterprise||"' AND prdaldocno = ? AND prdal001 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_prda_m.prdal002 = g_rtn_fields[1] 
   DISPLAY g_prda_m.prdal002 TO prdal002

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prda004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prda_m.prda004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prda004_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prda005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prda_m.prda005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prda005_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prda006
   CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prda_m.prda006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prda006_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prda007
   CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prda_m.prda007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prda007_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prda008
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2100' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prda_m.prda008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prda008_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prda009
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prda_m.prda009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prda009_desc   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prda033
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2135' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prda_m.prda033_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prda033_desc   
   
   #時間設置資料只會有一筆，組別為1
   SELECT prdd003,prdd004 
     INTO g_prda_m.l_prdd003_1,g_prda_m.l_prdd004_1
     FROM prdd_t
    WHERE prddent = g_enterprise
      AND prdddocno = g_prda_m.prdadocno
      AND prdd002 = 1 
   
   #对象資料只會有一种：促销方式为折扣，且折扣率都一样
   SELECT DISTINCT prdb005 INTO g_prda_m.l_prdb005_1
     FROM prdb_t
    WHERE prdbent=g_enterprise
      AND prdbdocno=g_prda_m.prdadocno  
   #end add-point
   
   #遮罩相關處理
   LET g_prda_m_mask_o.* =  g_prda_m.*
   CALL aprt219_prda_t_mask()
   LET g_prda_m_mask_n.* =  g_prda_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prda_m.prdasite,g_prda_m.prdasite_desc,g_prda_m.prdadocdt,g_prda_m.prdadocno,g_prda_m.prda000, 
       g_prda_m.prda001,g_prda_m.prda002,g_prda_m.prdal002,g_prda_m.prda006,g_prda_m.prda006_desc,g_prda_m.prda007, 
       g_prda_m.prda007_desc,g_prda_m.prda027,g_prda_m.prdastus,g_prda_m.prda034,g_prda_m.l_prdd003_1, 
       g_prda_m.l_prdd004_1,g_prda_m.prda026,g_prda_m.l_prdb005_1,g_prda_m.prda033,g_prda_m.prda033_desc, 
       g_prda_m.prda008,g_prda_m.prda008_desc,g_prda_m.prda009,g_prda_m.prda009_desc,g_prda_m.prda023, 
       g_prda_m.prda003,g_prda_m.prda028,g_prda_m.prda038,g_prda_m.prda011,g_prda_m.prda015,g_prda_m.prda020, 
       g_prda_m.prda012,g_prda_m.prda016,g_prda_m.prda014,g_prda_m.prda013,g_prda_m.prda010,g_prda_m.prda017, 
       g_prda_m.prda024,g_prda_m.prda018,g_prda_m.prda025,g_prda_m.prda019,g_prda_m.prda032,g_prda_m.prda021, 
       g_prda_m.prda022,g_prda_m.prda029,g_prda_m.prda030,g_prda_m.prda031,g_prda_m.prda037,g_prda_m.prda098, 
       g_prda_m.prda101,g_prda_m.prda102,g_prda_m.prda103,g_prda_m.prdaunit,g_prda_m.prdaunit_desc,g_prda_m.prdaacti, 
       g_prda_m.prda004,g_prda_m.prda004_desc,g_prda_m.prda005,g_prda_m.prda005_desc,g_prda_m.prdaownid, 
       g_prda_m.prdaownid_desc,g_prda_m.prdaowndp,g_prda_m.prdaowndp_desc,g_prda_m.prdacrtid,g_prda_m.prdacrtid_desc, 
       g_prda_m.prdacrtdp,g_prda_m.prdacrtdp_desc,g_prda_m.prdacrtdt,g_prda_m.prdamodid,g_prda_m.prdamodid_desc, 
       g_prda_m.prdamoddt,g_prda_m.prdacnfid,g_prda_m.prdacnfid_desc,g_prda_m.prdacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prda_m.prdastus 
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
   FOR l_ac = 1 TO g_prde_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      IF g_prde_d[l_ac].prde003 = '1' THEN
         SELECT rtaal003 INTO g_prde_d[l_ac].prde004_desc
           FROM rtaal_t
          WHERE rtaalent = g_enterprise
            AND rtaal001 = g_prde_d[l_ac].prde004
            AND rtaal002 = g_dlang
      ELSE
         SELECT ooefl003 INTO g_prde_d[l_ac].prde004_desc
           FROM ooefl_t
          WHERE ooeflent = g_enterprise
            AND ooefl001 = g_prde_d[l_ac].prde004
            AND ooefl002 = g_dlang
      END IF
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprt219_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprt219.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aprt219_detail_show()
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
 
{<section id="aprt219.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprt219_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE prda_t.prdadocno 
   DEFINE l_oldno     LIKE prda_t.prdadocno 
 
   DEFINE l_master    RECORD LIKE prda_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE prde_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_prda_m.prdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_prdadocno_t = g_prda_m.prdadocno
 
    
   LET g_prda_m.prdadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prda_m.prdaownid = g_user
      LET g_prda_m.prdaowndp = g_dept
      LET g_prda_m.prdacrtid = g_user
      LET g_prda_m.prdacrtdp = g_dept 
      LET g_prda_m.prdacrtdt = cl_get_current()
      LET g_prda_m.prdamodid = g_user
      LET g_prda_m.prdamoddt = cl_get_current()
      LET g_prda_m.prdastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prda_m.prdastus 
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
   
   
   CALL aprt219_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_prda_m.* TO NULL
      INITIALIZE g_prde_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aprt219_show()
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
   CALL aprt219_set_act_visible()   
   CALL aprt219_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prdadocno_t = g_prda_m.prdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prdaent = " ||g_enterprise|| " AND",
                      " prdadocno = '", g_prda_m.prdadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt219_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aprt219_idx_chk()
   
   LET g_data_owner = g_prda_m.prdaownid      
   LET g_data_dept  = g_prda_m.prdaowndp
   
   #功能已完成,通報訊息中心
   CALL aprt219_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt219.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprt219_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prde_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprt219_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prde_t
    WHERE prdeent = g_enterprise AND prdedocno = g_prdadocno_t
 
    INTO TEMP aprt219_detail
 
   #將key修正為調整後   
   UPDATE aprt219_detail 
      #更新key欄位
      SET prdedocno = g_prda_m.prdadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO prde_t SELECT * FROM aprt219_detail
   
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
   DROP TABLE aprt219_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_prdadocno_t = g_prda_m.prdadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprt219.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprt219_delete()
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
   
   IF g_prda_m.prdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.prdaldocno = g_prda_m.prdadocno
LET g_master_multi_table_t.prdal002 = g_prda_m.prdal002
 
   
   CALL s_transaction_begin()
 
   OPEN aprt219_cl USING g_enterprise,g_prda_m.prdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt219_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt219_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt219_master_referesh USING g_prda_m.prdadocno INTO g_prda_m.prdasite,g_prda_m.prdadocdt, 
       g_prda_m.prdadocno,g_prda_m.prda000,g_prda_m.prda001,g_prda_m.prda002,g_prda_m.prda006,g_prda_m.prda007, 
       g_prda_m.prda027,g_prda_m.prdastus,g_prda_m.prda034,g_prda_m.prda026,g_prda_m.prda033,g_prda_m.prda008, 
       g_prda_m.prda009,g_prda_m.prda023,g_prda_m.prda003,g_prda_m.prda028,g_prda_m.prda038,g_prda_m.prda011, 
       g_prda_m.prda015,g_prda_m.prda020,g_prda_m.prda012,g_prda_m.prda016,g_prda_m.prda014,g_prda_m.prda013, 
       g_prda_m.prda010,g_prda_m.prda017,g_prda_m.prda024,g_prda_m.prda018,g_prda_m.prda025,g_prda_m.prda019, 
       g_prda_m.prda032,g_prda_m.prda021,g_prda_m.prda022,g_prda_m.prda029,g_prda_m.prda030,g_prda_m.prda031, 
       g_prda_m.prda037,g_prda_m.prda098,g_prda_m.prda101,g_prda_m.prda102,g_prda_m.prda103,g_prda_m.prdaunit, 
       g_prda_m.prdaacti,g_prda_m.prda004,g_prda_m.prda005,g_prda_m.prdaownid,g_prda_m.prdaowndp,g_prda_m.prdacrtid, 
       g_prda_m.prdacrtdp,g_prda_m.prdacrtdt,g_prda_m.prdamodid,g_prda_m.prdamoddt,g_prda_m.prdacnfid, 
       g_prda_m.prdacnfdt,g_prda_m.prdasite_desc,g_prda_m.prda033_desc,g_prda_m.prdaunit_desc,g_prda_m.prdaownid_desc, 
       g_prda_m.prdaowndp_desc,g_prda_m.prdacrtid_desc,g_prda_m.prdacrtdp_desc,g_prda_m.prdamodid_desc, 
       g_prda_m.prdacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aprt219_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prda_m_mask_o.* =  g_prda_m.*
   CALL aprt219_prda_t_mask()
   LET g_prda_m_mask_n.* =  g_prda_m.*
   
   CALL aprt219_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aprt219_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_prdadocno_t = g_prda_m.prdadocno
 
 
      DELETE FROM prda_t
       WHERE prdaent = g_enterprise AND prdadocno = g_prda_m.prdadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_prda_m.prdadocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM prde_t
       WHERE prdeent = g_enterprise AND prdedocno = g_prda_m.prdadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      DELETE FROM prdh_t 
       WHERE prdhent = g_enterprise
         AND prdhdocno = g_prda_m.prdadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdh_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF  
      
      DELETE FROM prdb_t 
       WHERE prdbent = g_enterprise
         AND prdbdocno = g_prda_m.prdadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF  
      DELETE FROM prdd_t 
       WHERE prddent = g_enterprise
         AND prdddocno = g_prda_m.prdadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdd_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF   


      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_prda_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aprt219_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_prde_d.clear() 
 
     
      CALL aprt219_ui_browser_refresh()  
      #CALL aprt219_ui_headershow()  
      #CALL aprt219_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'prdalent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.prdaldocno
   LET l_field_keys[02] = 'prdaldocno'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'prdal_t')
 
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aprt219_browser_fill("")
         CALL aprt219_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprt219_cl
 
   #功能已完成,通報訊息中心
   CALL aprt219_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aprt219.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprt219_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_prde_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aprt219_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prdeacti,prde003,prde004,prde002,prde001,prdesite,prdeunit ,t1.ooefl003 FROM prde_t", 
                
                     " INNER JOIN prda_t ON prdaent = " ||g_enterprise|| " AND prdadocno = prdedocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=prde004 AND t1.ooefl002='"||g_dlang||"' ",
 
                     " WHERE prdeent=? AND prdedocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         LET g_sql = g_sql CLIPPED, " AND prda103='", g_prog,"'"
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prde_t.prde002"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt219_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aprt219_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_prda_m.prdadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_prda_m.prdadocno INTO g_prde_d[l_ac].prdeacti,g_prde_d[l_ac].prde003, 
          g_prde_d[l_ac].prde004,g_prde_d[l_ac].prde002,g_prde_d[l_ac].prde001,g_prde_d[l_ac].prdesite, 
          g_prde_d[l_ac].prdeunit,g_prde_d[l_ac].prde004_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         IF g_prde_d[l_ac].prde003 = '1' THEN
            SELECT rtaal003 INTO g_prde_d[l_ac].prde004_desc
              FROM rtaal_t
             WHERE rtaalent = g_enterprise
               AND rtaal001 = g_prde_d[l_ac].prde004
               AND rtaal002 = g_dlang
         ELSE
            SELECT ooefl003 INTO g_prde_d[l_ac].prde004_desc
              FROM ooefl_t
             WHERE ooeflent = g_enterprise
               AND ooefl001 = g_prde_d[l_ac].prde004
               AND ooefl002 = g_dlang
         END IF
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
   
   CALL g_prde_d.deleteElement(g_prde_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprt219_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_prde_d.getLength()
      LET g_prde_d_mask_o[l_ac].* =  g_prde_d[l_ac].*
      CALL aprt219_prde_t_mask()
      LET g_prde_d_mask_n[l_ac].* =  g_prde_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aprt219.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprt219_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM prde_t
       WHERE prdeent = g_enterprise AND
         prdedocno = ps_keys_bak[1] AND prde002 = ps_keys_bak[2]
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
         CALL g_prde_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt219.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprt219_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO prde_t
                  (prdeent,
                   prdedocno,
                   prde002
                   ,prdeacti,prde003,prde004,prde001,prdesite,prdeunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prde_d[g_detail_idx].prdeacti,g_prde_d[g_detail_idx].prde003,g_prde_d[g_detail_idx].prde004, 
                       g_prde_d[g_detail_idx].prde001,g_prde_d[g_detail_idx].prdesite,g_prde_d[g_detail_idx].prdeunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_prde_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aprt219.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprt219_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prde_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aprt219_prde_t_mask_restore('restore_mask_o')
               
      UPDATE prde_t 
         SET (prdedocno,
              prde002
              ,prdeacti,prde003,prde004,prde001,prdesite,prdeunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prde_d[g_detail_idx].prdeacti,g_prde_d[g_detail_idx].prde003,g_prde_d[g_detail_idx].prde004, 
                  g_prde_d[g_detail_idx].prde001,g_prde_d[g_detail_idx].prdesite,g_prde_d[g_detail_idx].prdeunit)  
 
         WHERE prdeent = g_enterprise AND prdedocno = ps_keys_bak[1] AND prde002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prde_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prde_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt219_prde_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aprt219.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aprt219_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt219.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aprt219_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt219.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprt219_lock_b(ps_table,ps_page)
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
   #CALL aprt219_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "prde_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprt219_bcl USING g_enterprise,
                                       g_prda_m.prdadocno,g_prde_d[g_detail_idx].prde002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt219_bcl:",SQLERRMESSAGE 
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
 
{<section id="aprt219.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprt219_unlock_b(ps_table,ps_page)
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
      CLOSE aprt219_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprt219.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprt219_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("prdadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("prdadocno",TRUE)
      CALL cl_set_comp_entry("prdadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("prdadocdt",TRUE)
      CALL cl_set_comp_entry("prdasite",TRUE) 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("prda000,prda001",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt219.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprt219_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("prdadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("prdadocdt",FALSE)
      CALL cl_set_comp_entry("prda000,prda001",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("prdadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("prdadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_prda_m.prda000 = 'I' THEN
      CALL cl_set_comp_entry("prdaacti",FALSE)
      LET g_prda_m.prdaacti = 'Y'
   END IF
   
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("prdasite",FALSE)
      CALL cl_set_comp_entry("prdadocno",FALSE)
      CALL cl_set_comp_entry("prdadocdt",FALSE)
   END IF
   
   IF NOT s_aooi500_comp_entry(g_prog,'prdasite') OR g_site_flag THEN
      CALL cl_set_comp_entry("prdasite",FALSE)
   END IF    
   
   IF NOT s_aooi500_comp_entry(g_prog,'prdasite') OR g_site_flag THEN
      CALL cl_set_comp_entry("prdasite",FALSE)
   END IF 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt219.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprt219_set_entry_b(p_cmd)
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
 
{<section id="aprt219.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprt219_set_no_entry_b(p_cmd)
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
 
{<section id="aprt219.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aprt219_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt219.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aprt219_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_prda_m.prdastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF

   IF g_prda_m.prdastus = 'N' AND g_prda_m.prdaunit = g_site THEN
      CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
   ELSE
      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
   END IF

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt219.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aprt219_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt219.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aprt219_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt219.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprt219_default_search()
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
      LET ls_wc = ls_wc, " prdadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "prda_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prde_t" 
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
 
{<section id="aprt219.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aprt219_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_time   DATETIME YEAR TO SECOND
   DEFINE l_prdl001     LIKE prdl_t.prdl001
   DEFINE l_prdlstus    LIKE prdl_t.prdlstus
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_prda_m.prdastus = 'Y' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_prda_m.prdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aprt219_cl USING g_enterprise,g_prda_m.prdadocno
   IF STATUS THEN
      CLOSE aprt219_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt219_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aprt219_master_referesh USING g_prda_m.prdadocno INTO g_prda_m.prdasite,g_prda_m.prdadocdt, 
       g_prda_m.prdadocno,g_prda_m.prda000,g_prda_m.prda001,g_prda_m.prda002,g_prda_m.prda006,g_prda_m.prda007, 
       g_prda_m.prda027,g_prda_m.prdastus,g_prda_m.prda034,g_prda_m.prda026,g_prda_m.prda033,g_prda_m.prda008, 
       g_prda_m.prda009,g_prda_m.prda023,g_prda_m.prda003,g_prda_m.prda028,g_prda_m.prda038,g_prda_m.prda011, 
       g_prda_m.prda015,g_prda_m.prda020,g_prda_m.prda012,g_prda_m.prda016,g_prda_m.prda014,g_prda_m.prda013, 
       g_prda_m.prda010,g_prda_m.prda017,g_prda_m.prda024,g_prda_m.prda018,g_prda_m.prda025,g_prda_m.prda019, 
       g_prda_m.prda032,g_prda_m.prda021,g_prda_m.prda022,g_prda_m.prda029,g_prda_m.prda030,g_prda_m.prda031, 
       g_prda_m.prda037,g_prda_m.prda098,g_prda_m.prda101,g_prda_m.prda102,g_prda_m.prda103,g_prda_m.prdaunit, 
       g_prda_m.prdaacti,g_prda_m.prda004,g_prda_m.prda005,g_prda_m.prdaownid,g_prda_m.prdaowndp,g_prda_m.prdacrtid, 
       g_prda_m.prdacrtdp,g_prda_m.prdacrtdt,g_prda_m.prdamodid,g_prda_m.prdamoddt,g_prda_m.prdacnfid, 
       g_prda_m.prdacnfdt,g_prda_m.prdasite_desc,g_prda_m.prda033_desc,g_prda_m.prdaunit_desc,g_prda_m.prdaownid_desc, 
       g_prda_m.prdaowndp_desc,g_prda_m.prdacrtid_desc,g_prda_m.prdacrtdp_desc,g_prda_m.prdamodid_desc, 
       g_prda_m.prdacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aprt219_action_chk() THEN
      CLOSE aprt219_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prda_m.prdasite,g_prda_m.prdasite_desc,g_prda_m.prdadocdt,g_prda_m.prdadocno,g_prda_m.prda000, 
       g_prda_m.prda001,g_prda_m.prda002,g_prda_m.prdal002,g_prda_m.prda006,g_prda_m.prda006_desc,g_prda_m.prda007, 
       g_prda_m.prda007_desc,g_prda_m.prda027,g_prda_m.prdastus,g_prda_m.prda034,g_prda_m.l_prdd003_1, 
       g_prda_m.l_prdd004_1,g_prda_m.prda026,g_prda_m.l_prdb005_1,g_prda_m.prda033,g_prda_m.prda033_desc, 
       g_prda_m.prda008,g_prda_m.prda008_desc,g_prda_m.prda009,g_prda_m.prda009_desc,g_prda_m.prda023, 
       g_prda_m.prda003,g_prda_m.prda028,g_prda_m.prda038,g_prda_m.prda011,g_prda_m.prda015,g_prda_m.prda020, 
       g_prda_m.prda012,g_prda_m.prda016,g_prda_m.prda014,g_prda_m.prda013,g_prda_m.prda010,g_prda_m.prda017, 
       g_prda_m.prda024,g_prda_m.prda018,g_prda_m.prda025,g_prda_m.prda019,g_prda_m.prda032,g_prda_m.prda021, 
       g_prda_m.prda022,g_prda_m.prda029,g_prda_m.prda030,g_prda_m.prda031,g_prda_m.prda037,g_prda_m.prda098, 
       g_prda_m.prda101,g_prda_m.prda102,g_prda_m.prda103,g_prda_m.prdaunit,g_prda_m.prdaunit_desc,g_prda_m.prdaacti, 
       g_prda_m.prda004,g_prda_m.prda004_desc,g_prda_m.prda005,g_prda_m.prda005_desc,g_prda_m.prdaownid, 
       g_prda_m.prdaownid_desc,g_prda_m.prdaowndp,g_prda_m.prdaowndp_desc,g_prda_m.prdacrtid,g_prda_m.prdacrtid_desc, 
       g_prda_m.prdacrtdp,g_prda_m.prdacrtdp_desc,g_prda_m.prdacrtdt,g_prda_m.prdamodid,g_prda_m.prdamodid_desc, 
       g_prda_m.prdamoddt,g_prda_m.prdacnfid,g_prda_m.prdacnfid_desc,g_prda_m.prdacnfdt
 
   CASE g_prda_m.prdastus
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
         CASE g_prda_m.prdastus
            
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
      IF g_prda_m.prdastus <> 'N' THEN
         CALL cl_set_act_visible("invalid", FALSE)
      END IF
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_prda_m.prdastus
         WHEN "N"
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
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
            IF NOT aprt219_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt219_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aprt219_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt219_cl
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
             IF NOT cl_ask_confirm('aim-00109') THEN
                CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
                RETURN
             END IF
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
      g_prda_m.prdastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aprt219_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   IF lc_state = 'Y' THEN
      CALL s_aprt211_conf_chk(g_prda_m.prdadocno,g_prda_m.prdastus) RETURNING l_success,g_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = g_prda_m.prdadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_aprt211_conf_upd(g_prda_m.prdadocno,g_prda_m.prdastus) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               SELECT prdl001,prdlstus INTO l_prdl001,l_prdlstus
                 FROM prdl_t
                WHERE prdlent=g_enterprise
                  AND prdl001=g_prda_m.prda001
               CALL s_aprm211_release_chk(l_prdl001,l_prdlstus) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = l_prdl001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  IF cl_ask_confirm('amm-00178') THEN
                     CALL s_aprm211_release_upd(l_prdl001,l_prdlstus) RETURNING l_success
                     IF NOT l_success THEN
                        CALL s_transaction_end('N','0')
                        RETURN                                         
                     END IF
                  END IF
               END IF                
            END IF            
         END IF
         
      END IF
   END IF
   LET l_time = cl_get_current()
   IF (lc_state = 'Y' AND g_prda_m.prdastus = 'X') OR lc_state = 'X' OR lc_state = 'N'  THEN
      UPDATE prda_t SET prdamodid = g_user,
                        prdamoddt = l_time
       WHERE prdaent = g_enterprise 
         AND prdadocno = g_prda_m.prdadocno
   END IF
   #end add-point
   
   LET g_prda_m.prdamodid = g_user
   LET g_prda_m.prdamoddt = cl_get_current()
   LET g_prda_m.prdastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE prda_t 
      SET (prdastus,prdamodid,prdamoddt) 
        = (g_prda_m.prdastus,g_prda_m.prdamodid,g_prda_m.prdamoddt)     
    WHERE prdaent = g_enterprise AND prdadocno = g_prda_m.prdadocno
 
    
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
      EXECUTE aprt219_master_referesh USING g_prda_m.prdadocno INTO g_prda_m.prdasite,g_prda_m.prdadocdt, 
          g_prda_m.prdadocno,g_prda_m.prda000,g_prda_m.prda001,g_prda_m.prda002,g_prda_m.prda006,g_prda_m.prda007, 
          g_prda_m.prda027,g_prda_m.prdastus,g_prda_m.prda034,g_prda_m.prda026,g_prda_m.prda033,g_prda_m.prda008, 
          g_prda_m.prda009,g_prda_m.prda023,g_prda_m.prda003,g_prda_m.prda028,g_prda_m.prda038,g_prda_m.prda011, 
          g_prda_m.prda015,g_prda_m.prda020,g_prda_m.prda012,g_prda_m.prda016,g_prda_m.prda014,g_prda_m.prda013, 
          g_prda_m.prda010,g_prda_m.prda017,g_prda_m.prda024,g_prda_m.prda018,g_prda_m.prda025,g_prda_m.prda019, 
          g_prda_m.prda032,g_prda_m.prda021,g_prda_m.prda022,g_prda_m.prda029,g_prda_m.prda030,g_prda_m.prda031, 
          g_prda_m.prda037,g_prda_m.prda098,g_prda_m.prda101,g_prda_m.prda102,g_prda_m.prda103,g_prda_m.prdaunit, 
          g_prda_m.prdaacti,g_prda_m.prda004,g_prda_m.prda005,g_prda_m.prdaownid,g_prda_m.prdaowndp, 
          g_prda_m.prdacrtid,g_prda_m.prdacrtdp,g_prda_m.prdacrtdt,g_prda_m.prdamodid,g_prda_m.prdamoddt, 
          g_prda_m.prdacnfid,g_prda_m.prdacnfdt,g_prda_m.prdasite_desc,g_prda_m.prda033_desc,g_prda_m.prdaunit_desc, 
          g_prda_m.prdaownid_desc,g_prda_m.prdaowndp_desc,g_prda_m.prdacrtid_desc,g_prda_m.prdacrtdp_desc, 
          g_prda_m.prdamodid_desc,g_prda_m.prdacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_prda_m.prdasite,g_prda_m.prdasite_desc,g_prda_m.prdadocdt,g_prda_m.prdadocno, 
          g_prda_m.prda000,g_prda_m.prda001,g_prda_m.prda002,g_prda_m.prdal002,g_prda_m.prda006,g_prda_m.prda006_desc, 
          g_prda_m.prda007,g_prda_m.prda007_desc,g_prda_m.prda027,g_prda_m.prdastus,g_prda_m.prda034, 
          g_prda_m.l_prdd003_1,g_prda_m.l_prdd004_1,g_prda_m.prda026,g_prda_m.l_prdb005_1,g_prda_m.prda033, 
          g_prda_m.prda033_desc,g_prda_m.prda008,g_prda_m.prda008_desc,g_prda_m.prda009,g_prda_m.prda009_desc, 
          g_prda_m.prda023,g_prda_m.prda003,g_prda_m.prda028,g_prda_m.prda038,g_prda_m.prda011,g_prda_m.prda015, 
          g_prda_m.prda020,g_prda_m.prda012,g_prda_m.prda016,g_prda_m.prda014,g_prda_m.prda013,g_prda_m.prda010, 
          g_prda_m.prda017,g_prda_m.prda024,g_prda_m.prda018,g_prda_m.prda025,g_prda_m.prda019,g_prda_m.prda032, 
          g_prda_m.prda021,g_prda_m.prda022,g_prda_m.prda029,g_prda_m.prda030,g_prda_m.prda031,g_prda_m.prda037, 
          g_prda_m.prda098,g_prda_m.prda101,g_prda_m.prda102,g_prda_m.prda103,g_prda_m.prdaunit,g_prda_m.prdaunit_desc, 
          g_prda_m.prdaacti,g_prda_m.prda004,g_prda_m.prda004_desc,g_prda_m.prda005,g_prda_m.prda005_desc, 
          g_prda_m.prdaownid,g_prda_m.prdaownid_desc,g_prda_m.prdaowndp,g_prda_m.prdaowndp_desc,g_prda_m.prdacrtid, 
          g_prda_m.prdacrtid_desc,g_prda_m.prdacrtdp,g_prda_m.prdacrtdp_desc,g_prda_m.prdacrtdt,g_prda_m.prdamodid, 
          g_prda_m.prdamodid_desc,g_prda_m.prdamoddt,g_prda_m.prdacnfid,g_prda_m.prdacnfid_desc,g_prda_m.prdacnfdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aprt219_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt219_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt219.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aprt219_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prde_d.getLength() THEN
         LET g_detail_idx = g_prde_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prde_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prde_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprt219.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprt219_b_fill2(pi_idx)
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
   
   CALL aprt219_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aprt219.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprt219_fill_chk(ps_idx)
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
 
{<section id="aprt219.status_show" >}
PRIVATE FUNCTION aprt219_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprt219.mask_functions" >}
&include "erp/apr/aprt219_mask.4gl"
 
{</section>}
 
{<section id="aprt219.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aprt219_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aprt219_show()
   CALL aprt219_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_aprt211_conf_chk(g_prda_m.prdadocno,g_prda_m.prdastus) RETURNING l_success,g_errno
   IF NOT l_success THEN
      CLOSE aprt219_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_prda_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_prde_d))
 
 
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
   #CALL aprt219_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aprt219_ui_headershow()
   CALL aprt219_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aprt219_draw_out()
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
   CALL aprt219_ui_headershow()  
   CALL aprt219_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aprt219.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aprt219_set_pk_array()
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
   LET g_pk_array[1].values = g_prda_m.prdadocno
   LET g_pk_array[1].column = 'prdadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt219.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aprt219.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aprt219_msgcentre_notify(lc_state)
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
   CALL aprt219_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_prda_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt219.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aprt219_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#31 add-S
   SELECT prdastus  INTO g_prda_m.prdastus
     FROM prda_t
    WHERE prdaent = g_enterprise
      AND prdadocno = g_prda_m.prdadocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_prda_m.prdastus
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
        LET g_errparam.extend = g_prda_m.prdadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aprt219_set_act_visible()
        CALL aprt219_set_act_no_visible()
        CALL aprt219_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#31 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt219.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預設單頭資料
# Memo...........:
# Usage..........: CALL aprt219_prda000_init()
# Input parameter: 
# Return code....: 
# Date & Author..: 20151215 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt219_prda000_init()
   IF cl_null(g_prda_m.prda001) THEN
      RETURN
   END IF
   INITIALIZE g_prda_m.prdasite,g_prda_m.prdadocdt,g_prda_m.prdadocno,g_prda_m.prda000,g_prda_m.prda001, 
          g_prda_m.prda002,g_prda_m.prdal002,g_prda_m.prda006,g_prda_m.prda007,g_prda_m.prda027,g_prda_m.prdastus, 
          g_prda_m.prda038,g_prda_m.l_prdd003_1,g_prda_m.l_prdd004_1,g_prda_m.prda024,g_prda_m.prda025, 
          g_prda_m.prda033,g_prda_m.prda008,g_prda_m.prda009,g_prda_m.prda010,g_prda_m.prda011,g_prda_m.prda003, 
          g_prda_m.prda013,g_prda_m.prda012,g_prda_m.prda103,g_prda_m.prda015,g_prda_m.prda016,g_prda_m.prda017, 
          g_prda_m.prda014,g_prda_m.prda018,g_prda_m.prda021,g_prda_m.prda019,g_prda_m.prda022,g_prda_m.prda020, 
          g_prda_m.prda023,g_prda_m.prda029,g_prda_m.prda026,g_prda_m.prda030,g_prda_m.prda028,g_prda_m.prda032, 
          g_prda_m.prda037,g_prda_m.prda034,g_prda_m.prda031,g_prda_m.prda101,g_prda_m.prda098,g_prda_m.prda102, 
          g_prda_m.prdaacti,g_prda_m.prdaunit,g_prda_m.prda004,g_prda_m.prda005  TO NULL
       
   LET g_prda_m.prdaacti = "Y"
   LET g_prda_m.prdastus = "N"
   LET g_prda_m.prda010 = "Y"
   LET g_prda_m.prda011 = "N"
   LET g_prda_m.prda012 = "N"
   LET g_prda_m.prda013 = "N"
   LET g_prda_m.prda024 = "2"
   LET g_prda_m.prda025 = "1"
   LET g_prda_m.prda026 = "3"
   LET g_prda_m.prda003 = '1'
   LET g_prda_m.prda004 = g_user
   LET g_prda_m.prda005 = g_dept
   LET g_prda_m.prda002 = 1
   LET g_prda_m.prda098 = '1'
   LET g_prda_m.prda038 = "N"
   LET g_prda_m.prda037 = 0
   LET g_prda_m.prda034 = "N"
   
   CALL aprt219_desc()
   
   DISPLAY BY NAME g_prda_m.prdasite,g_prda_m.prdadocdt,g_prda_m.prdadocno,g_prda_m.prda000,g_prda_m.prda001, 
          g_prda_m.prda002,g_prda_m.prdal002,g_prda_m.prda006,g_prda_m.prda007,g_prda_m.prda027,g_prda_m.prdastus, 
          g_prda_m.prda038,g_prda_m.l_prdd003_1,g_prda_m.l_prdd004_1,g_prda_m.prda024,g_prda_m.prda025, 
          g_prda_m.prda033,g_prda_m.prda008,g_prda_m.prda009,g_prda_m.prda010,g_prda_m.prda011,g_prda_m.prda003, 
          g_prda_m.prda013,g_prda_m.prda012,g_prda_m.prda103,g_prda_m.prda015,g_prda_m.prda016,g_prda_m.prda017, 
          g_prda_m.prda014,g_prda_m.prda018,g_prda_m.prda021,g_prda_m.prda019,g_prda_m.prda022,g_prda_m.prda020, 
          g_prda_m.prda023,g_prda_m.prda029,g_prda_m.prda026,g_prda_m.prda030,g_prda_m.prda028,g_prda_m.prda032, 
          g_prda_m.prda037,g_prda_m.prda034,g_prda_m.prda031,g_prda_m.prda101,g_prda_m.prda098,g_prda_m.prda102, 
          g_prda_m.prdaacti,g_prda_m.prdaunit,g_prda_m.prda004,g_prda_m.prda005
   
END FUNCTION

################################################################################
# Descriptions...: 單頭說明欄位帶值
# Memo...........:
# Usage..........: CALL aprt219_desc()
# Input parameter: 
# Return code....: 
# Date & Author..: 20151215 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt219_desc()

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prdasite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prda_m.prdasite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prdasite_desc
   

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prda006
   CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prda_m.prda006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prda006_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prda007
   CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prda_m.prda007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prda007_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prda004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prda_m.prda004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prda004_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prda005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prda_m.prda005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prda005_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prda008
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2100' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prda_m.prda008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prda008_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prda033
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2135' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prda_m.prda033_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prda033_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prda_m.prda009
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prda_m.prda009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prda_m.prda009_desc
   
END FUNCTION

################################################################################
# Descriptions...: 規則編號檢查
# Memo...........:
# Usage..........: CALL aprt219_chk_prda001()
# Input parameter: 
# Return code....: 
# Date & Author..: 2151215 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt219_chk_prda001()
DEFINE l_n              LIKE type_t.num5
DEFINE l_prdlstus       LIKE prdl_t.prdlstus
DEFINE l_prdlunit       LIKE prdl_t.prdlunit



   LET g_errno = ""
   
   IF g_prda_m.prda000 = 'I' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM prdl_t
       WHERE prdlent = g_enterprise
         AND prdl001 = g_prda_m.prda001
      IF l_n > 0 THEN
#         LET g_errno = 'apr-00080'    #160318-00005#41 mark
         LET g_errno = 'sub-01319'     #160318-00005#41 add
         RETURN
      END IF
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM prda_t
       WHERE prdaent = g_enterprise
         AND prda001 = g_prda_m.prda001
         AND prdadocno <> g_prda_m.prdadocno
      IF l_n > 0 THEN
         LET g_errno = 'apr-00305'
         RETURN
      END IF
   END IF
   
   IF g_prda_m.prda000 = 'U' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM prdl_t
       WHERE prdlent = g_enterprise
         AND prdl001 = g_prda_m.prda001
         AND prdl003 = '1'
         AND prdl098 = '1'
      IF l_n = 0 THEN
#         LET g_errno = 'apr-00081'    #160318-00005#41 mark
         LET g_errno = 'sub-01319'     #160318-00005#41 add
         RETURN
      END IF
      LET l_prdlstus = ''
      SELECT prdlstus INTO l_prdlstus
        FROM prdl_t
       WHERE prdlent = g_enterprise
         AND prdl001 = g_prda_m.prda001
         AND prdl003 = '1'
         AND prdl098 = '1'
      IF l_prdlstus = 'X' THEN
#         LET g_errno = 'apr-00082'    #160318-00005#41 mark
         LET g_errno = 'sub-01307'     #160318-00005#41 add
         RETURN
      END IF
      IF l_prdlstus = 'N' THEN
#         LET g_errno = 'apr-00083'     #160318-00005#41 mark
         LET g_errno = 'sub-01302'      #160318-00005#41 add
         RETURN
      END IF
      LET l_prdlunit = ''
      SELECT prdlunit INTO l_prdlunit
        FROM prdl_t
       WHERE prdlent = g_enterprise
         AND prdl001 = g_prda_m.prda001
         AND prdl003 = '1'
         AND prdl098 = '1'
      IF l_prdlunit <> g_site THEN
#         LET g_errno = 'apr-00247'    #160318-00005#41 mark
         LET g_errno = 'sub-01315'     #160318-00005#41 add
         RETURN
      END IF
      
     #檢查是不是當前程式產生的規則編號      
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM prdl_t
       WHERE prdlent = g_enterprise
         AND prdl001 = g_prda_m.prda001
         AND prdl003 = '1'
         AND prdl098 = '1'
         AND prdl103=g_prog
      IF l_n = 0 THEN
#         LET g_errno = 'apr-00081'     #160318-00005#41 mark
         LET g_errno = 'sub-01319'     #160318-00005#41 add
         RETURN
      END IF    
      
   END IF
   

   
   
   
END FUNCTION

################################################################################
# Descriptions...: 預設單頭資料
# Memo...........:
# Usage..........: CALL aprt219_prda001_init()
# Input parameter: 
# Return code....: 
# Date & Author..: 20151215 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt219_prda001_init()
#DEFINE l_prdl               RECORD LIKE prdl_t.* #161111-00028#2--mark
#161111-00028#2---add---begin----------
DEFINE l_prdl RECORD  #促銷規則單頭資料檔
       prdlent LIKE prdl_t.prdlent, #企業編號
       prdlunit LIKE prdl_t.prdlunit, #應用組織
       prdlsite LIKE prdl_t.prdlsite, #營運據點
       prdl001 LIKE prdl_t.prdl001, #規則編號
       prdl002 LIKE prdl_t.prdl002, #規則版本
       prdl003 LIKE prdl_t.prdl003, #規則類型
       prdl004 LIKE prdl_t.prdl004, #申請人員
       prdl005 LIKE prdl_t.prdl005, #申請部門
       prdl006 LIKE prdl_t.prdl006, #促銷方案
       prdl007 LIKE prdl_t.prdl007, #活動計劃
       prdl008 LIKE prdl_t.prdl008, #檔期類型
       prdl009 LIKE prdl_t.prdl009, #活動等級
       prdl010 LIKE prdl_t.prdl010, #全稱促銷
       prdl011 LIKE prdl_t.prdl011, #款別限制
       prdl012 LIKE prdl_t.prdl012, #折扣卡
       prdl013 LIKE prdl_t.prdl013, #日期高階設定
       prdl014 LIKE prdl_t.prdl014, #組合總額/量
       prdl015 LIKE prdl_t.prdl015, #滿額分段否
       prdl016 LIKE prdl_t.prdl016, #參加換贈
       prdl017 LIKE prdl_t.prdl017, #換贈方式
       prdl018 LIKE prdl_t.prdl018, #計算方式
       prdl019 LIKE prdl_t.prdl019, #換贈設定模式
       prdl020 LIKE prdl_t.prdl020, #兼容換贈
       prdl021 LIKE prdl_t.prdl021, #換贈商品條件
       prdl022 LIKE prdl_t.prdl022, #限定換贈種類
       prdl023 LIKE prdl_t.prdl023, #限定換贈總數
       prdl024 LIKE prdl_t.prdl024, #促銷方式
       prdl025 LIKE prdl_t.prdl025, #入機方式
       prdl026 LIKE prdl_t.prdl026, #參與對象
       prdl027 LIKE prdl_t.prdl027, #促銷優先級
       prdl028 LIKE prdl_t.prdl028, #返利標準
       prdl029 LIKE prdl_t.prdl029, #達成任務量返利率
       prdl030 LIKE prdl_t.prdl030, #超出任務量返利率
       prdl031 LIKE prdl_t.prdl031, #承擔比例
       prdl032 LIKE prdl_t.prdl032, #物返方式
       prdl098 LIKE prdl_t.prdl098, #營運業態
       prdl099 LIKE prdl_t.prdl099, #發佈否
       prdl100 LIKE prdl_t.prdl100, #發佈日期
       prdlstus LIKE prdl_t.prdlstus, #狀態碼
       prdlownid LIKE prdl_t.prdlownid, #資料所有者
       prdlowndp LIKE prdl_t.prdlowndp, #資料所有部門
       prdlcrtid LIKE prdl_t.prdlcrtid, #資料建立者
       prdlcrtdp LIKE prdl_t.prdlcrtdp, #資料建立部門
       prdlcrtdt LIKE prdl_t.prdlcrtdt, #資料創建日
       prdlmodid LIKE prdl_t.prdlmodid, #資料修改者
       prdlmoddt LIKE prdl_t.prdlmoddt, #最近修改日
       prdlcnfid LIKE prdl_t.prdlcnfid, #資料確認者
       prdlcnfdt LIKE prdl_t.prdlcnfdt, #資料確認日
       prdl033 LIKE prdl_t.prdl033, #活動類型
       prdl034 LIKE prdl_t.prdl034, #是否列印
       prdldocno LIKE prdl_t.prdldocno, #單號
       prdl037 LIKE prdl_t.prdl037, #會員總達成次數
       prdl038 LIKE prdl_t.prdl038, #疊加否
       prdl103 LIKE prdl_t.prdl103, #來源程式
       prdl039 LIKE prdl_t.prdl039, #高階優惠方式
       prdl040 LIKE prdl_t.prdl040, #換贈依會員折扣後金額
       prdl041 LIKE prdl_t.prdl041, #換贈累計方式
       prdl042 LIKE prdl_t.prdl042 #當天銷售積分否
       END RECORD
#161111-00028#2-----add--end-------------

   IF cl_null(g_prda_m.prda000) OR cl_null(g_prda_m.prda001) THEN
      RETURN
   END IF 
   IF g_prda_m.prda000 = 'U' THEN
    #SELECT * INTO l_prdl.*   #161111-00028#2--mark
    #161111-00028#2--add---begin------------
     SELECT prdlent,prdlunit,prdlsite,prdl001,prdl002,prdl003,prdl004,prdl005,prdl006,prdl007,prdl008,
       prdl009,prdl010,prdl011,prdl012,prdl013,prdl014,prdl015,prdl016,prdl017,prdl018,prdl019,prdl020,prdl021,
       prdl022,prdl023,prdl024,prdl025,prdl026,prdl027,prdl028,prdl029,prdl030,prdl031,prdl032,prdl098,prdl099,
       prdl100,prdlstus,prdlownid,prdlowndp,prdlcrtid,prdlcrtdp,prdlcrtdt,prdlmodid,prdlmoddt,prdlcnfid,
       prdlcnfdt,prdl033,prdl034,prdldocno,prdl037,prdl038,prdl103,prdl039,prdl040,prdl041,prdl042 INTO l_prdl.*
     #161111-00028#2--add---end--------------
        FROM prdl_t
       WHERE prdlent = g_enterprise
         AND prdl001 = g_prda_m.prda001
      LET g_prda_m.prda001 = l_prdl.prdl001 
      LET g_prda_m.prda003 = l_prdl.prdl003
      LET g_prda_m.prda004 = l_prdl.prdl004
      LET g_prda_m.prda005 = l_prdl.prdl005
      LET g_prda_m.prda006 = l_prdl.prdl006
      LET g_prda_m.prda007 = l_prdl.prdl007
      LET g_prda_m.prda033 = l_prdl.prdl033 
      LET g_prda_m.prda008 = l_prdl.prdl008
      LET g_prda_m.prda009 = l_prdl.prdl009
      LET g_prda_m.prda010 = l_prdl.prdl010
      LET g_prda_m.prda011 = l_prdl.prdl011
      LET g_prda_m.prda012 = l_prdl.prdl012 
      LET g_prda_m.prda013 = l_prdl.prdl013 
      LET g_prda_m.prda024 = l_prdl.prdl024 
      LET g_prda_m.prda025 = l_prdl.prdl025 
      LET g_prda_m.prda026 = l_prdl.prdl026 
      LET g_prda_m.prda027 = l_prdl.prdl027 
      LET g_prda_m.prda098 = l_prdl.prdl098
      LET g_prda_m.prda037 = l_prdl.prdl037  
      LET g_prda_m.prda038 = l_prdl.prdl038    
      LET g_prda_m.prda034 = l_prdl.prdl034        
      IF l_prdl.prdlstus = 'X' THEN
         LET g_prda_m.prdaacti = 'N'
      ELSE
         LET g_prda_m.prdaacti = 'Y'
      END IF
      SELECT prdll003 INTO  g_prda_m.prdal002
        FROM prdll_t
       WHERE prdllent = g_enterprise
         AND prdll001 = g_prda_m.prda001
         AND prdll002 =  g_dlang
      IF g_prda_m.prda013 = 'N' THEN
         SELECT prdo003,prdo004
           INTO g_prda_m.l_prdd003_1,g_prda_m.l_prdd004_1
           FROM prdo_t
          WHERE prdoent = g_enterprise
            AND prdo001 = g_prda_m.prda001
            AND prdo002 = 1
      END IF
   END IF
   CALL aprt219_desc()
   DISPLAY BY NAME g_prda_m.prdasite,g_prda_m.prdadocdt,g_prda_m.prdadocno,g_prda_m.prda000,g_prda_m.prda001, 
          g_prda_m.prda002,g_prda_m.prdal002,g_prda_m.prda006,g_prda_m.prda007,g_prda_m.prda027,g_prda_m.prdastus, 
          g_prda_m.prda038,g_prda_m.l_prdd003_1,g_prda_m.l_prdd004_1,g_prda_m.prda024,g_prda_m.prda025, 
          g_prda_m.prda033,g_prda_m.prda008,g_prda_m.prda009,g_prda_m.prda010,g_prda_m.prda011,g_prda_m.prda003, 
          g_prda_m.prda013,g_prda_m.prda012,g_prda_m.prda103,g_prda_m.prda015,g_prda_m.prda016,g_prda_m.prda017, 
          g_prda_m.prda014,g_prda_m.prda018,g_prda_m.prda021,g_prda_m.prda019,g_prda_m.prda022,g_prda_m.prda020, 
          g_prda_m.prda023,g_prda_m.prda029,g_prda_m.prda026,g_prda_m.prda030,g_prda_m.prda028,g_prda_m.prda032, 
          g_prda_m.prda037,g_prda_m.prda034,g_prda_m.prda031,g_prda_m.prda101,g_prda_m.prda098,g_prda_m.prda102, 
          g_prda_m.prdaacti,g_prda_m.prdaunit,g_prda_m.prda004,g_prda_m.prda005
    
END FUNCTION

################################################################################
# Descriptions...: 門店、店群檢查
# Memo...........:
# Usage..........: CALL aprt219_chk_prde004()
#                  RETURNING r_errno
# Input parameter: 
# Return code....: r_errno  錯誤信息代碼
# Date & Author..: 20151215 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt219_chk_prde004()
DEFINE l_n       LIKE type_t.num5
DEFINE l_sql     STRING
DEFINE r_errno   LIKE type_t.chr10


   LET r_errno = ''
   IF g_prde_d[l_ac].prde003 = '1' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM rtaa_t
       WHERE rtaaent = g_enterprise
         AND rtaa001 = g_prde_d[l_ac].prde004
      IF l_n = 0 THEN
         LET r_errno = 'apr-00006'
         RETURN r_errno
      END IF
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM rtaa_t
       WHERE rtaaent = g_enterprise
         AND rtaa001 = g_prde_d[l_ac].prde004
         AND rtaastus = 'Y'
      IF l_n = 0 THEN
#         LET r_errno = 'apr-00007'    #160318-00005#41 mark
         LET r_errno = 'sub-01302'     #160318-00005#41 add
         RETURN r_errno
      END IF
      LET l_n = 0  
      SELECT COUNT(*) INTO l_n
        FROM rtaa_t,rtak_t
       WHERE rtaaent = g_enterprise
         AND rtaa001 = g_prde_d[l_ac].prde004
         AND rtaastus = 'Y'
         AND rtakent=rtaaent
         AND rtak001=rtaa001
         AND rtak002='4'
         AND rtak003='Y'   
      IF l_n = 0 THEN
         LET r_errno = 'apr-00008'
         RETURN r_errno
      END IF
      LET l_n = 0
      LET l_sql = "SELECT COUNT(*) ",
                  "  FROM rtaa_t,rtab_t,rtak_t",
                  " WHERE rtaaent = '",g_enterprise,"'",
                  "   AND rtaa001 = '",g_prde_d[l_ac].prde004,"'",
                  "   AND rtaastus = 'Y'",
                  "   AND rtakent=rtaaent",
                  "   AND rtak001=rtaa001",
                  "   AND rtak002='4'",
                  "   AND rtak003='Y'",     
                  "   AND rtaaent = rtabent",
                  "   AND rtaa001 = rtab001",
                  "   AND rtab002 NOT IN (SELECT ooed004 FROM ooed_t ",
                  "                    START WITH ooed005 = '",g_site,"'",
                  "                      AND ooed001='8'",
                  "                      AND ooed006<= '",g_today,"'",
                  "                      AND (ooed007>= '",g_today,"' OR ooed007 IS NULL)",
                  "                    CONNECT BY  nocycle PRIOR ooed004=ooed005 ",
                  "                      AND ooed001='8' ",
                  "                      AND ooed006<= '",g_today,"'",
                  "                      AND (ooed007>= '",g_today,"' OR ooed007 IS NULL)",
                  #"                    UNION SELECT ooed004 FROM ooed_t WHERE ooed004 = '",g_site,"' )" #mark by geza 20160905 #160905-00007#5
                  "                    UNION SELECT ooed004 FROM ooed_t WHERE ooedent = ",g_enterprise," AND ooed004 = '",g_site,"' )" #add by geza 20160905 #160905-00007#5  
      PREPARE aprt219_sel_rtaa_pr FROM l_sql
      EXECUTE aprt219_sel_rtaa_pr INTO l_n
      IF l_n > 0 THEN
         LET r_errno = 'apr-00066'
         RETURN r_errno
      END IF
   END IF
   IF g_prde_d[l_ac].prde003 = '1' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM rtab_t
       WHERE rtabent = g_enterprise
         AND rtab002 IN (SELECT prde004 FROM prde_t
                          WHERE prdeent = g_enterprise
                            AND prdedocno = g_prda_m.prdadocno
                            AND prde002 <> g_prde_d[l_ac].prde002
                            AND prde003 = '2')
         AND rtab001 = g_prde_d[l_ac].prde004
      IF l_n > 0 THEN
         LET r_errno = 'apr-00014'
         RETURN r_errno
      END IF
   END IF
   IF g_prde_d[l_ac].prde003 = '2' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM prde_t
       WHERE prdeent = g_enterprise
         AND prdedocno = g_prda_m.prdadocno
         AND prde002 <> g_prde_d[l_ac].prde002
         AND prde004 IN (SELECT rtab001 FROM rtab_t
                          WHERE rtabent = g_enterprise
                            AND rtab002 = g_prde_d[l_ac].prde004)
         AND prde003 = '1'
      IF l_n > 0 THEN
         LET r_errno = 'apr-00013'
         RETURN r_errno
      END IF
   END IF
   
   RETURN r_errno   
   
END FUNCTION

 
{</section>}
 
