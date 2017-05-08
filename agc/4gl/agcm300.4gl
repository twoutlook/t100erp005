#該程式未解開Section, 採用最新樣板產出!
{<section id="agcm300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0025(2016-10-21 14:01:22), PR版次:0025(2016-10-31 14:00:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000454
#+ Filename...: agcm300
#+ Description: 券種基本資料維護作業
#+ Creator....: 01726(2013-11-19 14:29:34)
#+ Modifier...: 00700 -SD/PR- 06814
 
{</section>}
 
{<section id="agcm300.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160215-00002#2   2016/02/18  by sakura   新增"已開發票禮券稅別"欄位
#160318-00005#12  2016/03/25  by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#42  2016/04/25  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160728-00006#2   2016/07/29  by 08172    新增生效日期
#160818-00017#14  2016/08/25  by 08172    修改删除时重新检查状态
#160728-00006#17  2016/08/03  by liyan    單頭增加是否不規則編號，當勾選時開始結束券號不需錄入，固定編號長度不可小於0
#160728-00006#37  2016/08/29  by 08172    新增时，允许找零默认给N，并清空找零方式
#160905-00007#2   2016/09/05  by 08742    调整系统中无ENT的SQL条件增加ent,count(*) --> count(1)
#160819-00054#29  2016/10/21  By rainy    增加 與其它券種同時使用(gcaf044)/參加促銷金額(gcaf045)
#161024-00025#7   2016/10/25  by 08742    组织开窗调整
#161024-00025#1   2016/10/24  By dongsz   gcaj002增加aooi500逻辑管控
#160824-00007#97  2016/10/31  By 06814    新舊值相關處理
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
PRIVATE type type_g_gcaf_m        RECORD
       gcaf001 LIKE gcaf_t.gcaf001, 
   gcaf002 LIKE gcaf_t.gcaf002, 
   gcafl003 LIKE gcafl_t.gcafl003, 
   gcafl004 LIKE gcafl_t.gcafl004, 
   gcaf003 LIKE gcaf_t.gcaf003, 
   gcaf004 LIKE gcaf_t.gcaf004, 
   gcafunit LIKE gcaf_t.gcafunit, 
   gcafunit_desc LIKE type_t.chr80, 
   gcafstus LIKE gcaf_t.gcafstus, 
   gcaf005 LIKE gcaf_t.gcaf005, 
   gcaf006 LIKE gcaf_t.gcaf006, 
   gcaf007 LIKE gcaf_t.gcaf007, 
   gcaf008 LIKE gcaf_t.gcaf008, 
   gcaf009 LIKE gcaf_t.gcaf009, 
   gcaf010 LIKE gcaf_t.gcaf010, 
   gcaf011 LIKE gcaf_t.gcaf011, 
   gcaf012 LIKE gcaf_t.gcaf012, 
   gcaf012_desc LIKE type_t.chr80, 
   gcaf013 LIKE gcaf_t.gcaf013, 
   gcaf013_desc LIKE type_t.chr80, 
   gcaf041 LIKE gcaf_t.gcaf041, 
   gcaf041_desc LIKE type_t.chr80, 
   gcaf015 LIKE gcaf_t.gcaf015, 
   gcaf043 LIKE gcaf_t.gcaf043, 
   gcaf037 LIKE gcaf_t.gcaf037, 
   gcaf038 LIKE gcaf_t.gcaf038, 
   gcaf039 LIKE gcaf_t.gcaf039, 
   gcaf016 LIKE gcaf_t.gcaf016, 
   gcaf017 LIKE gcaf_t.gcaf017, 
   gcaf042 LIKE gcaf_t.gcaf042, 
   gcaf018 LIKE gcaf_t.gcaf018, 
   gcaf019 LIKE gcaf_t.gcaf019, 
   gcaf020 LIKE gcaf_t.gcaf020, 
   gcaf021 LIKE gcaf_t.gcaf021, 
   gcaf022 LIKE gcaf_t.gcaf022, 
   gcaf023 LIKE gcaf_t.gcaf023, 
   gcaf034 LIKE gcaf_t.gcaf034, 
   gcaf035 LIKE gcaf_t.gcaf035, 
   gcaf036 LIKE gcaf_t.gcaf036, 
   gcaf024 LIKE gcaf_t.gcaf024, 
   gcaf025 LIKE gcaf_t.gcaf025, 
   gcaf031 LIKE gcaf_t.gcaf031, 
   gcaf031_desc LIKE type_t.chr80, 
   gcaf040 LIKE type_t.chr500, 
   gcaf026 LIKE gcaf_t.gcaf026, 
   gcaf032 LIKE gcaf_t.gcaf032, 
   gcaf033 LIKE gcaf_t.gcaf033, 
   gcaf044 LIKE gcaf_t.gcaf044, 
   gcaf045 LIKE gcaf_t.gcaf045, 
   gcafownid LIKE gcaf_t.gcafownid, 
   gcafownid_desc LIKE type_t.chr80, 
   gcafowndp LIKE gcaf_t.gcafowndp, 
   gcafowndp_desc LIKE type_t.chr80, 
   gcafcrtid LIKE gcaf_t.gcafcrtid, 
   gcafcrtid_desc LIKE type_t.chr80, 
   gcafcrtdp LIKE gcaf_t.gcafcrtdp, 
   gcafcrtdp_desc LIKE type_t.chr80, 
   gcafcrtdt LIKE gcaf_t.gcafcrtdt, 
   gcafmodid LIKE gcaf_t.gcafmodid, 
   gcafmodid_desc LIKE type_t.chr80, 
   gcafmoddt LIKE gcaf_t.gcafmoddt, 
   gcafcnfid LIKE gcaf_t.gcafcnfid, 
   gcafcnfid_desc LIKE type_t.chr80, 
   gcafcnfdt LIKE gcaf_t.gcafcnfdt, 
   gcaf027 LIKE gcaf_t.gcaf027, 
   gcaf028 LIKE gcaf_t.gcaf028, 
   gcaf029 LIKE gcaf_t.gcaf029, 
   gcaf030 LIKE gcaf_t.gcaf030
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gcag_d        RECORD
       gcag002 LIKE gcag_t.gcag002, 
   gcag003 LIKE gcag_t.gcag003, 
   gcag004 LIKE gcag_t.gcag004, 
   gcag005 LIKE gcag_t.gcag005, 
   gcag006 LIKE gcag_t.gcag006, 
   gcagstus LIKE gcag_t.gcagstus
       END RECORD
PRIVATE TYPE type_g_gcag2_d RECORD
       gcah002 LIKE gcah_t.gcah002, 
   gcah003 LIKE gcah_t.gcah003, 
   gcah003_desc LIKE type_t.chr500, 
   gcahstus LIKE gcah_t.gcahstus
       END RECORD
PRIVATE TYPE type_g_gcag3_d RECORD
       gcai002 LIKE gcai_t.gcai002, 
   gcai003 LIKE gcai_t.gcai003, 
   gcai004 LIKE gcai_t.gcai004, 
   gcai005 LIKE gcai_t.gcai005, 
   gcai006 LIKE gcai_t.gcai006, 
   gcai007 LIKE gcai_t.gcai007, 
   gcai008 LIKE gcai_t.gcai008, 
   gcaistus LIKE gcai_t.gcaistus
       END RECORD
PRIVATE TYPE type_g_gcag4_d RECORD
       gcaj002 LIKE gcaj_t.gcaj002, 
   gcaj002_desc LIKE type_t.chr500, 
   gcaj003 LIKE gcaj_t.gcaj003, 
   gcajstus LIKE gcaj_t.gcajstus
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_gcaf001 LIKE gcaf_t.gcaf001
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag           LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_gcaf_m          type_g_gcaf_m
DEFINE g_gcaf_m_t        type_g_gcaf_m
DEFINE g_gcaf_m_o        type_g_gcaf_m
DEFINE g_gcaf_m_mask_o   type_g_gcaf_m #轉換遮罩前資料
DEFINE g_gcaf_m_mask_n   type_g_gcaf_m #轉換遮罩後資料
 
   DEFINE g_gcaf001_t LIKE gcaf_t.gcaf001
 
 
DEFINE g_gcag_d          DYNAMIC ARRAY OF type_g_gcag_d
DEFINE g_gcag_d_t        type_g_gcag_d
DEFINE g_gcag_d_o        type_g_gcag_d
DEFINE g_gcag_d_mask_o   DYNAMIC ARRAY OF type_g_gcag_d #轉換遮罩前資料
DEFINE g_gcag_d_mask_n   DYNAMIC ARRAY OF type_g_gcag_d #轉換遮罩後資料
DEFINE g_gcag2_d          DYNAMIC ARRAY OF type_g_gcag2_d
DEFINE g_gcag2_d_t        type_g_gcag2_d
DEFINE g_gcag2_d_o        type_g_gcag2_d
DEFINE g_gcag2_d_mask_o   DYNAMIC ARRAY OF type_g_gcag2_d #轉換遮罩前資料
DEFINE g_gcag2_d_mask_n   DYNAMIC ARRAY OF type_g_gcag2_d #轉換遮罩後資料
DEFINE g_gcag3_d          DYNAMIC ARRAY OF type_g_gcag3_d
DEFINE g_gcag3_d_t        type_g_gcag3_d
DEFINE g_gcag3_d_o        type_g_gcag3_d
DEFINE g_gcag3_d_mask_o   DYNAMIC ARRAY OF type_g_gcag3_d #轉換遮罩前資料
DEFINE g_gcag3_d_mask_n   DYNAMIC ARRAY OF type_g_gcag3_d #轉換遮罩後資料
DEFINE g_gcag4_d          DYNAMIC ARRAY OF type_g_gcag4_d
DEFINE g_gcag4_d_t        type_g_gcag4_d
DEFINE g_gcag4_d_o        type_g_gcag4_d
DEFINE g_gcag4_d_mask_o   DYNAMIC ARRAY OF type_g_gcag4_d #轉換遮罩前資料
DEFINE g_gcag4_d_mask_n   DYNAMIC ARRAY OF type_g_gcag4_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      gcafl001 LIKE gcafl_t.gcafl001,
      gcafl003 LIKE gcafl_t.gcafl003,
      gcafl004 LIKE gcafl_t.gcafl004
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
DEFINE g_wc2_table4   STRING
 
 
 
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
 
{<section id="agcm300.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("agc","")
 
   #add-point:作業初始化 name="main.init"
               
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
               
   #end add-point
   LET g_forupd_sql = " SELECT gcaf001,gcaf002,'','',gcaf003,gcaf004,gcafunit,'',gcafstus,gcaf005,gcaf006, 
       gcaf007,gcaf008,gcaf009,gcaf010,gcaf011,gcaf012,'',gcaf013,'',gcaf041,'',gcaf015,gcaf043,gcaf037, 
       gcaf038,gcaf039,gcaf016,gcaf017,gcaf042,gcaf018,gcaf019,gcaf020,gcaf021,gcaf022,gcaf023,gcaf034, 
       gcaf035,gcaf036,gcaf024,gcaf025,gcaf031,'','',gcaf026,gcaf032,gcaf033,gcaf044,gcaf045,gcafownid, 
       '',gcafowndp,'',gcafcrtid,'',gcafcrtdp,'',gcafcrtdt,gcafmodid,'',gcafmoddt,gcafcnfid,'',gcafcnfdt, 
       gcaf027,gcaf028,gcaf029,gcaf030", 
                      " FROM gcaf_t",
                      " WHERE gcafent= ? AND gcaf001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
               
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agcm300_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.gcaf001,t0.gcaf002,t0.gcaf003,t0.gcaf004,t0.gcafunit,t0.gcafstus, 
       t0.gcaf005,t0.gcaf006,t0.gcaf007,t0.gcaf008,t0.gcaf009,t0.gcaf010,t0.gcaf011,t0.gcaf012,t0.gcaf013, 
       t0.gcaf041,t0.gcaf015,t0.gcaf043,t0.gcaf037,t0.gcaf038,t0.gcaf039,t0.gcaf016,t0.gcaf017,t0.gcaf042, 
       t0.gcaf018,t0.gcaf019,t0.gcaf020,t0.gcaf021,t0.gcaf022,t0.gcaf023,t0.gcaf034,t0.gcaf035,t0.gcaf036, 
       t0.gcaf024,t0.gcaf025,t0.gcaf031,t0.gcaf040,t0.gcaf026,t0.gcaf032,t0.gcaf033,t0.gcaf044,t0.gcaf045, 
       t0.gcafownid,t0.gcafowndp,t0.gcafcrtid,t0.gcafcrtdp,t0.gcafcrtdt,t0.gcafmodid,t0.gcafmoddt,t0.gcafcnfid, 
       t0.gcafcnfdt,t0.gcaf027,t0.gcaf028,t0.gcaf029,t0.gcaf030,t1.ooefl003 ,t2.oocql004 ,t3.imaal003 , 
       t4.ooial003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooag011",
               " FROM gcaf_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.gcafunit AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='2071' AND t2.oocql002=t0.gcaf012 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=t0.gcaf013 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooial_t t4 ON t4.ooialent="||g_enterprise||" AND t4.ooial001=t0.gcaf031 AND t4.ooial002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.gcafownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.gcafowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.gcafcrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.gcafcrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.gcafmodid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.gcafcnfid  ",
 
               " WHERE t0.gcafent = " ||g_enterprise|| " AND t0.gcaf001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE agcm300_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
                              
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_agcm300 WITH FORM cl_ap_formpath("agc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL agcm300_init()   
 
      #進入選單 Menu (="N")
      CALL agcm300_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
                              
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_agcm300
      
   END IF 
   
   CLOSE agcm300_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309  
   CALL s_aooi390_drop_tmp_table()                     #add by geza #160224-00027#1     添加編碼功能       
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="agcm300.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION agcm300_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309              
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
   LET g_detail_idx_list[4] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('gcafstus','50','N,Y,X')
 
      CALL cl_set_combo_scc('gcaf003','6522') 
   CALL cl_set_combo_scc('gcaf004','6523') 
   CALL cl_set_combo_scc('gcaf017','6524') 
   CALL cl_set_combo_scc('gcaf018','6525') 
   CALL cl_set_combo_scc('gcaf022','6526') 
   CALL cl_set_combo_scc('gcaf024','6527') 
   CALL cl_set_combo_scc('gcaf025','6528') 
   CALL cl_set_combo_scc('gcaf032','6021') 
   CALL cl_set_combo_scc('gcaf029','6529') 
   CALL cl_set_combo_scc('gcaf030','6530') 
   CALL cl_set_combo_scc('gcah002','6517') 
   CALL cl_set_combo_scc('gcai007','6520') 
   CALL cl_set_combo_scc('gcai008','30') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL agcm300_set_combo()
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309   
   CALL cl_set_combo_scc('gcaf033','6778') 
   CALL cl_set_combo_scc('gcaf040','6886')  #added BY LANJJ 2015-12-24
   CALL s_aooi390_cre_tmp_table() RETURNING l_success  #add by geza #160224-00027#1     添加編碼功能
   #end add-point
   
   #初始化搜尋條件
   CALL agcm300_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="agcm300.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION agcm300_ui_dialog()
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
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL agcm300_insert()
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
         INITIALIZE g_gcaf_m.* TO NULL
         CALL g_gcag_d.clear()
         CALL g_gcag2_d.clear()
         CALL g_gcag3_d.clear()
         CALL g_gcag4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL agcm300_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_gcag_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL agcm300_idx_chk()
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
               CALL agcm300_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
                                                                           
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                                                            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_gcag2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL agcm300_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
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
               CALL agcm300_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
                                                                           
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
                                                            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_gcag3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL agcm300_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
                                                                           
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL agcm300_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
                                                                           
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
                                                            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_gcag4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL agcm300_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body4.before_row"
                                                                           
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL agcm300_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
                                                                           
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
                                                            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
                                             
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL agcm300_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
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
               CALL agcm300_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL agcm300_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL agcm300_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL agcm300_set_act_visible()
            CALL agcm300_set_act_no_visible()   #150424-00018#1 150529 add by beckxie
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL agcm300_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL agcm300_set_act_visible()   
            CALL agcm300_set_act_no_visible()
            IF NOT (g_gcaf_m.gcaf001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " gcafent = " ||g_enterprise|| " AND",
                                  " gcaf001 = '", g_gcaf_m.gcaf001, "' "
 
               #填到對應位置
               CALL agcm300_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "gcaf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gcag_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gcah_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "gcai_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "gcaj_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL agcm300_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "gcaf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gcag_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gcah_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "gcai_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "gcaj_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL agcm300_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL agcm300_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL agcm300_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agcm300_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL agcm300_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agcm300_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL agcm300_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agcm300_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL agcm300_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agcm300_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL agcm300_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agcm300_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_gcag_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_gcag2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_gcag3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_gcag4_d)
                  LET g_export_id[4]   = "s_detail4"
 
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
         ON ACTION effect_site
            LET g_action_choice="effect_site"
            IF cl_auth_chk_act("effect_site") THEN
               
               #add-point:ON ACTION effect_site name="menu.effect_site"
                                                                                          CALL agcm300_01("agcm300",g_gcaf_m.gcaf001)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL agcm300_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#14 -s by 08172
               CALL agcm300_set_act_visible()   
               CALL agcm300_set_act_no_visible()
               #160818-00017#14 -e by 08172                                                             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL agcm300_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #160818-00017#14 -s by 08172
               CALL agcm300_set_act_visible()   
               CALL agcm300_set_act_no_visible()
               #160818-00017#14 -e by 08172                                                                 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL agcm300_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#14 -s by 08172
               CALL agcm300_set_act_visible()   
               CALL agcm300_set_act_no_visible()
               #160818-00017#14 -e by 08172                                                                 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL agcm300_insert()
               #add-point:ON ACTION insert name="menu.insert"
                                                                           
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION denomination_set
            LET g_action_choice="denomination_set"
            IF cl_auth_chk_act("denomination_set") THEN
               
               #add-point:ON ACTION denomination_set name="menu.denomination_set"
                                                                                          CALL agcm300_02(g_gcaf_m.gcaf001,g_gcaf_m.gcafunit)
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
               CALL agcm300_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
                                                                           
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL agcm300_query()
               #add-point:ON ACTION query name="menu.query"
 
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION remark
            LET g_action_choice="remark"
            IF cl_auth_chk_act("remark") THEN
               
               #add-point:ON ACTION remark name="menu.remark"
                                                                                          CALL aooi360_02('99','agcm300',g_gcaf_m.gcaf001,'','','','','','','','','')
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delivery_set
            LET g_action_choice="delivery_set"
            IF cl_auth_chk_act("delivery_set") THEN
               
               #add-point:ON ACTION delivery_set name="menu.delivery_set"
                                                                                          CALL agcm300_03(g_gcaf_m.gcaf001,g_gcaf_m.gcafunit)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL agcm300_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL agcm300_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL agcm300_set_pk_array()
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
 
{<section id="agcm300.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION agcm300_browser_fill(ps_page_action)
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
   #150414-00002#1 20150515 geza add(S)
   IF g_wc = "1=2" THEN
      LET g_wc = " 1=1"
   END IF 
   #150414-00002#1 20150515 geza add(E)   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT gcaf001 ",
                      " FROM gcaf_t ",
                      " ",
                      " LEFT JOIN gcag_t ON gcagent = gcafent AND gcaf001 = gcag001 ", "  ",
                      #add-point:browser_fill段sql(gcag_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN gcah_t ON gcahent = gcafent AND gcaf001 = gcah001", "  ",
                      #add-point:browser_fill段sql(gcah_t1) name="browser_fill.cnt.join.gcah_t1"
                      
                      #end add-point
 
                      " LEFT JOIN gcai_t ON gcaient = gcafent AND gcaf001 = gcai001", "  ",
                      #add-point:browser_fill段sql(gcai_t1) name="browser_fill.cnt.join.gcai_t1"
                      
                      #end add-point
 
                      " LEFT JOIN gcaj_t ON gcajent = gcafent AND gcaf001 = gcaj001", "  ",
                      #add-point:browser_fill段sql(gcaj_t1) name="browser_fill.cnt.join.gcaj_t1"
                      
                      #end add-point
 
 
 
                      " LEFT JOIN gcafl_t ON gcaflent = "||g_enterprise||" AND gcaf001 = gcafl001 AND gcafl002 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE gcafent = " ||g_enterprise|| " AND gcagent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gcaf_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gcaf001 ",
                      " FROM gcaf_t ", 
                      "  ",
                      "  LEFT JOIN gcafl_t ON gcaflent = "||g_enterprise||" AND gcaf001 = gcafl001 AND gcafl002 = '",g_dlang,"' ",
                      " WHERE gcafent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("gcaf_t")
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
      INITIALIZE g_gcaf_m.* TO NULL
      CALL g_gcag_d.clear()        
      CALL g_gcag2_d.clear() 
      CALL g_gcag3_d.clear() 
      CALL g_gcag4_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.gcaf001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.gcafstus,t0.gcaf001 ",
                  " FROM gcaf_t t0",
                  "  ",
                  "  LEFT JOIN gcag_t ON gcagent = gcafent AND gcaf001 = gcag001 ", "  ", 
                  #add-point:browser_fill段sql(gcag_t1) name="browser_fill.join.gcag_t1"
                  
                  #end add-point
                  "  LEFT JOIN gcah_t ON gcahent = gcafent AND gcaf001 = gcah001", "  ", 
                  #add-point:browser_fill段sql(gcah_t1) name="browser_fill.join.gcah_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN gcai_t ON gcaient = gcafent AND gcaf001 = gcai001", "  ", 
                  #add-point:browser_fill段sql(gcai_t1) name="browser_fill.join.gcai_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN gcaj_t ON gcajent = gcafent AND gcaf001 = gcaj001", "  ", 
                  #add-point:browser_fill段sql(gcaj_t1) name="browser_fill.join.gcaj_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                  
               " LEFT JOIN gcafl_t ON gcaflent = "||g_enterprise||" AND gcaf001 = gcafl001 AND gcafl002 = '",g_dlang,"' ",
                  " WHERE t0.gcafent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("gcaf_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.gcafstus,t0.gcaf001 ",
                  " FROM gcaf_t t0",
                  "  ",
                  
               " LEFT JOIN gcafl_t ON gcaflent = "||g_enterprise||" AND gcaf001 = gcafl001 AND gcafl002 = '",g_dlang,"' ",
                  " WHERE t0.gcafent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("gcaf_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
 
   #end add-point
   LET g_sql = g_sql, " ORDER BY gcaf001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
               
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"gcaf_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
               
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_gcaf001
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
   
   IF cl_null(g_browser[g_cnt].b_gcaf001) THEN
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
   #150414-00002#1 20150515 geza add(S)
   CALL agcm300_set_act_visible()
   CALL agcm300_set_act_no_visible()   #150424-00018#1 150529 add by beckxie 
   #150414-00002#1 20150515 geza add(E)    
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION agcm300_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
               
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_gcaf_m.gcaf001 = g_browser[g_current_idx].b_gcaf001   
 
   EXECUTE agcm300_master_referesh USING g_gcaf_m.gcaf001 INTO g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcaf003, 
       g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005,g_gcaf_m.gcaf006,g_gcaf_m.gcaf007, 
       g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011,g_gcaf_m.gcaf012,g_gcaf_m.gcaf013, 
       g_gcaf_m.gcaf041,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037,g_gcaf_m.gcaf038,g_gcaf_m.gcaf039, 
       g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020, 
       g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035,g_gcaf_m.gcaf036, 
       g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf040,g_gcaf_m.gcaf026,g_gcaf_m.gcaf032, 
       g_gcaf_m.gcaf033,g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcafownid,g_gcaf_m.gcafowndp,g_gcaf_m.gcafcrtid, 
       g_gcaf_m.gcafcrtdp,g_gcaf_m.gcafcrtdt,g_gcaf_m.gcafmodid,g_gcaf_m.gcafmoddt,g_gcaf_m.gcafcnfid, 
       g_gcaf_m.gcafcnfdt,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028,g_gcaf_m.gcaf029,g_gcaf_m.gcaf030,g_gcaf_m.gcafunit_desc, 
       g_gcaf_m.gcaf012_desc,g_gcaf_m.gcaf013_desc,g_gcaf_m.gcaf031_desc,g_gcaf_m.gcafownid_desc,g_gcaf_m.gcafowndp_desc, 
       g_gcaf_m.gcafcrtid_desc,g_gcaf_m.gcafcrtdp_desc,g_gcaf_m.gcafmodid_desc,g_gcaf_m.gcafcnfid_desc 
 
   
   CALL agcm300_gcaf_t_mask()
   CALL agcm300_show()
      
END FUNCTION
 
{</section>}
 
{<section id="agcm300.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION agcm300_ui_detailshow()
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
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
               
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION agcm300_ui_browser_refresh()
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
      IF g_browser[l_i].b_gcaf001 = g_gcaf_m.gcaf001 
 
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
 
{<section id="agcm300.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION agcm300_construct()
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
   INITIALIZE g_gcaf_m.* TO NULL
   CALL g_gcag_d.clear()        
   CALL g_gcag2_d.clear() 
   CALL g_gcag3_d.clear() 
   CALL g_gcag4_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
                  CALL agcm300_gcaf018_desc()
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON gcaf001,gcaf002,gcafl003,gcafl004,gcaf003,gcaf004,gcafunit,gcafstus, 
          gcaf005,gcaf006,gcaf007,gcaf008,gcaf009,gcaf010,gcaf011,gcaf012,gcaf013,gcaf041,gcaf041_desc, 
          gcaf015,gcaf043,gcaf037,gcaf038,gcaf039,gcaf016,gcaf017,gcaf042,gcaf018,gcaf019,gcaf020,gcaf021, 
          gcaf022,gcaf023,gcaf034,gcaf035,gcaf036,gcaf024,gcaf025,gcaf031,gcaf026,gcaf032,gcaf033,gcaf044, 
          gcaf045,gcafownid,gcafowndp,gcafcrtid,gcafcrtdp,gcafcrtdt,gcafmodid,gcafmoddt,gcafcnfid,gcafcnfdt, 
          gcaf027,gcaf028,gcaf029,gcaf030
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                                                            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gcafcrtdt>>----
         AFTER FIELD gcafcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gcafmoddt>>----
         AFTER FIELD gcafmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gcafcnfdt>>----
         AFTER FIELD gcafcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gcafpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.gcaf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf001
            #add-point:ON ACTION controlp INFIELD gcaf001 name="construct.c.gcaf001"
                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_gcaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcaf001  #顯示到畫面上

            NEXT FIELD gcaf001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf001
            #add-point:BEFORE FIELD gcaf001 name="construct.b.gcaf001"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf001
            
            #add-point:AFTER FIELD gcaf001 name="construct.a.gcaf001"
                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf002
            #add-point:BEFORE FIELD gcaf002 name="construct.b.gcaf002"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf002
            
            #add-point:AFTER FIELD gcaf002 name="construct.a.gcaf002"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf002
            #add-point:ON ACTION controlp INFIELD gcaf002 name="construct.c.gcaf002"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafl003
            #add-point:BEFORE FIELD gcafl003 name="construct.b.gcafl003"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcafl003
            
            #add-point:AFTER FIELD gcafl003 name="construct.a.gcafl003"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcafl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcafl003
            #add-point:ON ACTION controlp INFIELD gcafl003 name="construct.c.gcafl003"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafl004
            #add-point:BEFORE FIELD gcafl004 name="construct.b.gcafl004"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcafl004
            
            #add-point:AFTER FIELD gcafl004 name="construct.a.gcafl004"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcafl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcafl004
            #add-point:ON ACTION controlp INFIELD gcafl004 name="construct.c.gcafl004"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf003
            #add-point:BEFORE FIELD gcaf003 name="construct.b.gcaf003"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf003
            
            #add-point:AFTER FIELD gcaf003 name="construct.a.gcaf003"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf003
            #add-point:ON ACTION controlp INFIELD gcaf003 name="construct.c.gcaf003"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf004
            #add-point:BEFORE FIELD gcaf004 name="construct.b.gcaf004"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf004
            
            #add-point:AFTER FIELD gcaf004 name="construct.a.gcaf004"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf004
            #add-point:ON ACTION controlp INFIELD gcaf004 name="construct.c.gcaf004"
                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.gcafunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcafunit
            #add-point:ON ACTION controlp INFIELD gcafunit name="construct.c.gcafunit"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			  #LET g_qryparam.where = " ooef201 = 'Y' "
           #CALL q_ooef001()                        #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcafunit',g_site,'c') #150308-00001#2  By sakura add 'c'
            CALL q_ooef001_24()                     #呼叫開窗 
            DISPLAY g_qryparam.return1 TO gcafunit  #顯示到畫面上
            NEXT FIELD gcafunit                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafunit
            #add-point:BEFORE FIELD gcafunit name="construct.b.gcafunit"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcafunit
            
            #add-point:AFTER FIELD gcafunit name="construct.a.gcafunit"
                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafstus
            #add-point:BEFORE FIELD gcafstus name="construct.b.gcafstus"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcafstus
            
            #add-point:AFTER FIELD gcafstus name="construct.a.gcafstus"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcafstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcafstus
            #add-point:ON ACTION controlp INFIELD gcafstus name="construct.c.gcafstus"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf005
            #add-point:BEFORE FIELD gcaf005 name="construct.b.gcaf005"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf005
            
            #add-point:AFTER FIELD gcaf005 name="construct.a.gcaf005"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf005
            #add-point:ON ACTION controlp INFIELD gcaf005 name="construct.c.gcaf005"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf006
            #add-point:BEFORE FIELD gcaf006 name="construct.b.gcaf006"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf006
            
            #add-point:AFTER FIELD gcaf006 name="construct.a.gcaf006"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf006
            #add-point:ON ACTION controlp INFIELD gcaf006 name="construct.c.gcaf006"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf007
            #add-point:BEFORE FIELD gcaf007 name="construct.b.gcaf007"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf007
            
            #add-point:AFTER FIELD gcaf007 name="construct.a.gcaf007"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf007
            #add-point:ON ACTION controlp INFIELD gcaf007 name="construct.c.gcaf007"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf008
            #add-point:BEFORE FIELD gcaf008 name="construct.b.gcaf008"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf008
            
            #add-point:AFTER FIELD gcaf008 name="construct.a.gcaf008"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf008
            #add-point:ON ACTION controlp INFIELD gcaf008 name="construct.c.gcaf008"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf009
            #add-point:BEFORE FIELD gcaf009 name="construct.b.gcaf009"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf009
            
            #add-point:AFTER FIELD gcaf009 name="construct.a.gcaf009"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf009
            #add-point:ON ACTION controlp INFIELD gcaf009 name="construct.c.gcaf009"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf010
            #add-point:BEFORE FIELD gcaf010 name="construct.b.gcaf010"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf010
            
            #add-point:AFTER FIELD gcaf010 name="construct.a.gcaf010"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf010
            #add-point:ON ACTION controlp INFIELD gcaf010 name="construct.c.gcaf010"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf011
            #add-point:BEFORE FIELD gcaf011 name="construct.b.gcaf011"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf011
            
            #add-point:AFTER FIELD gcaf011 name="construct.a.gcaf011"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf011
            #add-point:ON ACTION controlp INFIELD gcaf011 name="construct.c.gcaf011"
                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.gcaf012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf012
            #add-point:ON ACTION controlp INFIELD gcaf012 name="construct.c.gcaf012"
                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2071" #
			LET g_qryparam.where = " oocq019 = '40' "
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcaf012  #顯示到畫面上

            NEXT FIELD gcaf012                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf012
            #add-point:BEFORE FIELD gcaf012 name="construct.b.gcaf012"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf012
            
            #add-point:AFTER FIELD gcaf012 name="construct.a.gcaf012"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf013
            #add-point:ON ACTION controlp INFIELD gcaf013 name="construct.c.gcaf013"
                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_gcaf013()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcaf013  #顯示到畫面上

            NEXT FIELD gcaf013                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf013
            #add-point:BEFORE FIELD gcaf013 name="construct.b.gcaf013"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf013
            
            #add-point:AFTER FIELD gcaf013 name="construct.a.gcaf013"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf041
            #add-point:ON ACTION controlp INFIELD gcaf041 name="construct.c.gcaf041"
            #160215-00002#2(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.arg1 = g_gcaf_m.gcafunit   #160422-00001#1 160503 by sakura mark
            LET g_qryparam.arg1 = g_site               #160422-00001#1 160503 by sakura add
            CALL q_oodb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcaf041  #顯示到畫面上
            #160215-00002#2(E)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf041
            #add-point:BEFORE FIELD gcaf041 name="construct.b.gcaf041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf041
            
            #add-point:AFTER FIELD gcaf041 name="construct.a.gcaf041"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf041_desc
            #add-point:BEFORE FIELD gcaf041_desc name="construct.b.gcaf041_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf041_desc
            
            #add-point:AFTER FIELD gcaf041_desc name="construct.a.gcaf041_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf041_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf041_desc
            #add-point:ON ACTION controlp INFIELD gcaf041_desc name="construct.c.gcaf041_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf015
            #add-point:BEFORE FIELD gcaf015 name="construct.b.gcaf015"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf015
            
            #add-point:AFTER FIELD gcaf015 name="construct.a.gcaf015"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf015
            #add-point:ON ACTION controlp INFIELD gcaf015 name="construct.c.gcaf015"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf043
            #add-point:BEFORE FIELD gcaf043 name="construct.b.gcaf043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf043
            
            #add-point:AFTER FIELD gcaf043 name="construct.a.gcaf043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf043
            #add-point:ON ACTION controlp INFIELD gcaf043 name="construct.c.gcaf043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf037
            #add-point:BEFORE FIELD gcaf037 name="construct.b.gcaf037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf037
            
            #add-point:AFTER FIELD gcaf037 name="construct.a.gcaf037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf037
            #add-point:ON ACTION controlp INFIELD gcaf037 name="construct.c.gcaf037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf038
            #add-point:BEFORE FIELD gcaf038 name="construct.b.gcaf038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf038
            
            #add-point:AFTER FIELD gcaf038 name="construct.a.gcaf038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf038
            #add-point:ON ACTION controlp INFIELD gcaf038 name="construct.c.gcaf038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf039
            #add-point:BEFORE FIELD gcaf039 name="construct.b.gcaf039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf039
            
            #add-point:AFTER FIELD gcaf039 name="construct.a.gcaf039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf039
            #add-point:ON ACTION controlp INFIELD gcaf039 name="construct.c.gcaf039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf016
            #add-point:BEFORE FIELD gcaf016 name="construct.b.gcaf016"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf016
            
            #add-point:AFTER FIELD gcaf016 name="construct.a.gcaf016"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf016
            #add-point:ON ACTION controlp INFIELD gcaf016 name="construct.c.gcaf016"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf017
            #add-point:BEFORE FIELD gcaf017 name="construct.b.gcaf017"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf017
            
            #add-point:AFTER FIELD gcaf017 name="construct.a.gcaf017"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf017
            #add-point:ON ACTION controlp INFIELD gcaf017 name="construct.c.gcaf017"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf042
            #add-point:BEFORE FIELD gcaf042 name="construct.b.gcaf042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf042
            
            #add-point:AFTER FIELD gcaf042 name="construct.a.gcaf042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf042
            #add-point:ON ACTION controlp INFIELD gcaf042 name="construct.c.gcaf042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf018
            #add-point:BEFORE FIELD gcaf018 name="construct.b.gcaf018"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf018
            
            #add-point:AFTER FIELD gcaf018 name="construct.a.gcaf018"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf018
            #add-point:ON ACTION controlp INFIELD gcaf018 name="construct.c.gcaf018"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf019
            #add-point:BEFORE FIELD gcaf019 name="construct.b.gcaf019"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf019
            
            #add-point:AFTER FIELD gcaf019 name="construct.a.gcaf019"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf019
            #add-point:ON ACTION controlp INFIELD gcaf019 name="construct.c.gcaf019"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf020
            #add-point:BEFORE FIELD gcaf020 name="construct.b.gcaf020"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf020
            
            #add-point:AFTER FIELD gcaf020 name="construct.a.gcaf020"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf020
            #add-point:ON ACTION controlp INFIELD gcaf020 name="construct.c.gcaf020"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf021
            #add-point:BEFORE FIELD gcaf021 name="construct.b.gcaf021"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf021
            
            #add-point:AFTER FIELD gcaf021 name="construct.a.gcaf021"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf021
            #add-point:ON ACTION controlp INFIELD gcaf021 name="construct.c.gcaf021"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf022
            #add-point:BEFORE FIELD gcaf022 name="construct.b.gcaf022"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf022
            
            #add-point:AFTER FIELD gcaf022 name="construct.a.gcaf022"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf022
            #add-point:ON ACTION controlp INFIELD gcaf022 name="construct.c.gcaf022"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf023
            #add-point:BEFORE FIELD gcaf023 name="construct.b.gcaf023"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf023
            
            #add-point:AFTER FIELD gcaf023 name="construct.a.gcaf023"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf023
            #add-point:ON ACTION controlp INFIELD gcaf023 name="construct.c.gcaf023"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf034
            #add-point:BEFORE FIELD gcaf034 name="construct.b.gcaf034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf034
            
            #add-point:AFTER FIELD gcaf034 name="construct.a.gcaf034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf034
            #add-point:ON ACTION controlp INFIELD gcaf034 name="construct.c.gcaf034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf035
            #add-point:BEFORE FIELD gcaf035 name="construct.b.gcaf035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf035
            
            #add-point:AFTER FIELD gcaf035 name="construct.a.gcaf035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf035
            #add-point:ON ACTION controlp INFIELD gcaf035 name="construct.c.gcaf035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf036
            #add-point:BEFORE FIELD gcaf036 name="construct.b.gcaf036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf036
            
            #add-point:AFTER FIELD gcaf036 name="construct.a.gcaf036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf036
            #add-point:ON ACTION controlp INFIELD gcaf036 name="construct.c.gcaf036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf024
            #add-point:BEFORE FIELD gcaf024 name="construct.b.gcaf024"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf024
            
            #add-point:AFTER FIELD gcaf024 name="construct.a.gcaf024"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf024
            #add-point:ON ACTION controlp INFIELD gcaf024 name="construct.c.gcaf024"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf025
            #add-point:BEFORE FIELD gcaf025 name="construct.b.gcaf025"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf025
            
            #add-point:AFTER FIELD gcaf025 name="construct.a.gcaf025"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf025
            #add-point:ON ACTION controlp INFIELD gcaf025 name="construct.c.gcaf025"
                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.gcaf031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf031
            #add-point:ON ACTION controlp INFIELD gcaf031 name="construct.c.gcaf031"
                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.where = "ooiastus = 'Y' AND ooia002 = '40'" 
            LET g_qryparam.reqry = FALSE
#            CALL q_ooia001()                           #呼叫開窗          #mark by yangxf      
            CALL q_ooia001_03()   
            DISPLAY g_qryparam.return1 TO gcaf031  #顯示到畫面上

            NEXT FIELD gcaf031                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf031
            #add-point:BEFORE FIELD gcaf031 name="construct.b.gcaf031"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf031
            
            #add-point:AFTER FIELD gcaf031 name="construct.a.gcaf031"
                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf026
            #add-point:BEFORE FIELD gcaf026 name="construct.b.gcaf026"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf026
            
            #add-point:AFTER FIELD gcaf026 name="construct.a.gcaf026"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf026
            #add-point:ON ACTION controlp INFIELD gcaf026 name="construct.c.gcaf026"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf032
            #add-point:BEFORE FIELD gcaf032 name="construct.b.gcaf032"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf032
            
            #add-point:AFTER FIELD gcaf032 name="construct.a.gcaf032"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf032
            #add-point:ON ACTION controlp INFIELD gcaf032 name="construct.c.gcaf032"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf033
            #add-point:BEFORE FIELD gcaf033 name="construct.b.gcaf033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf033
            
            #add-point:AFTER FIELD gcaf033 name="construct.a.gcaf033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf033
            #add-point:ON ACTION controlp INFIELD gcaf033 name="construct.c.gcaf033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf044
            #add-point:BEFORE FIELD gcaf044 name="construct.b.gcaf044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf044
            
            #add-point:AFTER FIELD gcaf044 name="construct.a.gcaf044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf044
            #add-point:ON ACTION controlp INFIELD gcaf044 name="construct.c.gcaf044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf045
            #add-point:BEFORE FIELD gcaf045 name="construct.b.gcaf045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf045
            
            #add-point:AFTER FIELD gcaf045 name="construct.a.gcaf045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf045
            #add-point:ON ACTION controlp INFIELD gcaf045 name="construct.c.gcaf045"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gcafownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcafownid
            #add-point:ON ACTION controlp INFIELD gcafownid name="construct.c.gcafownid"
                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcafownid  #顯示到畫面上

            NEXT FIELD gcafownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafownid
            #add-point:BEFORE FIELD gcafownid name="construct.b.gcafownid"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcafownid
            
            #add-point:AFTER FIELD gcafownid name="construct.a.gcafownid"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcafowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcafowndp
            #add-point:ON ACTION controlp INFIELD gcafowndp name="construct.c.gcafowndp"
                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcafowndp  #顯示到畫面上

            NEXT FIELD gcafowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafowndp
            #add-point:BEFORE FIELD gcafowndp name="construct.b.gcafowndp"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcafowndp
            
            #add-point:AFTER FIELD gcafowndp name="construct.a.gcafowndp"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcafcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcafcrtid
            #add-point:ON ACTION controlp INFIELD gcafcrtid name="construct.c.gcafcrtid"
                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcafcrtid  #顯示到畫面上

            NEXT FIELD gcafcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafcrtid
            #add-point:BEFORE FIELD gcafcrtid name="construct.b.gcafcrtid"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcafcrtid
            
            #add-point:AFTER FIELD gcafcrtid name="construct.a.gcafcrtid"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcafcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcafcrtdp
            #add-point:ON ACTION controlp INFIELD gcafcrtdp name="construct.c.gcafcrtdp"
                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcafcrtdp  #顯示到畫面上

            NEXT FIELD gcafcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafcrtdp
            #add-point:BEFORE FIELD gcafcrtdp name="construct.b.gcafcrtdp"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcafcrtdp
            
            #add-point:AFTER FIELD gcafcrtdp name="construct.a.gcafcrtdp"
                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafcrtdt
            #add-point:BEFORE FIELD gcafcrtdt name="construct.b.gcafcrtdt"
                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.gcafmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcafmodid
            #add-point:ON ACTION controlp INFIELD gcafmodid name="construct.c.gcafmodid"
                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcafmodid  #顯示到畫面上

            NEXT FIELD gcafmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafmodid
            #add-point:BEFORE FIELD gcafmodid name="construct.b.gcafmodid"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcafmodid
            
            #add-point:AFTER FIELD gcafmodid name="construct.a.gcafmodid"
                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafmoddt
            #add-point:BEFORE FIELD gcafmoddt name="construct.b.gcafmoddt"
                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.gcafcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcafcnfid
            #add-point:ON ACTION controlp INFIELD gcafcnfid name="construct.c.gcafcnfid"
                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcafcnfid  #顯示到畫面上

            NEXT FIELD gcafcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafcnfid
            #add-point:BEFORE FIELD gcafcnfid name="construct.b.gcafcnfid"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcafcnfid
            
            #add-point:AFTER FIELD gcafcnfid name="construct.a.gcafcnfid"
                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafcnfdt
            #add-point:BEFORE FIELD gcafcnfdt name="construct.b.gcafcnfdt"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf027
            #add-point:BEFORE FIELD gcaf027 name="construct.b.gcaf027"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf027
            
            #add-point:AFTER FIELD gcaf027 name="construct.a.gcaf027"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf027
            #add-point:ON ACTION controlp INFIELD gcaf027 name="construct.c.gcaf027"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf028
            #add-point:BEFORE FIELD gcaf028 name="construct.b.gcaf028"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf028
            
            #add-point:AFTER FIELD gcaf028 name="construct.a.gcaf028"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf028
            #add-point:ON ACTION controlp INFIELD gcaf028 name="construct.c.gcaf028"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf029
            #add-point:BEFORE FIELD gcaf029 name="construct.b.gcaf029"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf029
            
            #add-point:AFTER FIELD gcaf029 name="construct.a.gcaf029"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf029
            #add-point:ON ACTION controlp INFIELD gcaf029 name="construct.c.gcaf029"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf030
            #add-point:BEFORE FIELD gcaf030 name="construct.b.gcaf030"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf030
            
            #add-point:AFTER FIELD gcaf030 name="construct.a.gcaf030"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcaf030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf030
            #add-point:ON ACTION controlp INFIELD gcaf030 name="construct.c.gcaf030"
                                                            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON gcag002,gcag003,gcag004,gcag005,gcag006,gcagstus
           FROM s_detail1[1].gcag002,s_detail1[1].gcag003,s_detail1[1].gcag004,s_detail1[1].gcag005, 
               s_detail1[1].gcag006,s_detail1[1].gcagstus
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                                                            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gcagcrtdt>>----
 
         #----<<gcagmoddt>>----
         
         #----<<gcagcnfdt>>----
         
         #----<<gcagpstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcag002
            #add-point:BEFORE FIELD gcag002 name="construct.b.page1.gcag002"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcag002
            
            #add-point:AFTER FIELD gcag002 name="construct.a.page1.gcag002"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcag002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcag002
            #add-point:ON ACTION controlp INFIELD gcag002 name="construct.c.page1.gcag002"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcag003
            #add-point:BEFORE FIELD gcag003 name="construct.b.page1.gcag003"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcag003
            
            #add-point:AFTER FIELD gcag003 name="construct.a.page1.gcag003"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcag003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcag003
            #add-point:ON ACTION controlp INFIELD gcag003 name="construct.c.page1.gcag003"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcag004
            #add-point:BEFORE FIELD gcag004 name="construct.b.page1.gcag004"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcag004
            
            #add-point:AFTER FIELD gcag004 name="construct.a.page1.gcag004"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcag004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcag004
            #add-point:ON ACTION controlp INFIELD gcag004 name="construct.c.page1.gcag004"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcag005
            #add-point:BEFORE FIELD gcag005 name="construct.b.page1.gcag005"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcag005
            
            #add-point:AFTER FIELD gcag005 name="construct.a.page1.gcag005"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcag005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcag005
            #add-point:ON ACTION controlp INFIELD gcag005 name="construct.c.page1.gcag005"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcag006
            #add-point:BEFORE FIELD gcag006 name="construct.b.page1.gcag006"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcag006
            
            #add-point:AFTER FIELD gcag006 name="construct.a.page1.gcag006"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcag006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcag006
            #add-point:ON ACTION controlp INFIELD gcag006 name="construct.c.page1.gcag006"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcagstus
            #add-point:BEFORE FIELD gcagstus name="construct.b.page1.gcagstus"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcagstus
            
            #add-point:AFTER FIELD gcagstus name="construct.a.page1.gcagstus"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcagstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcagstus
            #add-point:ON ACTION controlp INFIELD gcagstus name="construct.c.page1.gcagstus"
                                                            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON gcah002,gcah003,gcah003_desc,gcahstus
           FROM s_detail2[1].gcah002,s_detail2[1].gcah003,s_detail2[1].gcah003_desc,s_detail2[1].gcahstus 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
                                                            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gcahcrtdt>>----
 
         #----<<gcahmoddt>>----
         
         #----<<gcahcnfdt>>----
         
         #----<<gcahpstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcah002
            #add-point:BEFORE FIELD gcah002 name="construct.b.page2.gcah002"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcah002
            
            #add-point:AFTER FIELD gcah002 name="construct.a.page2.gcah002"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gcah002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcah002
            #add-point:ON ACTION controlp INFIELD gcah002 name="construct.c.page2.gcah002"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcah003
            #add-point:BEFORE FIELD gcah003 name="construct.b.page2.gcah003"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcah003
            
            #add-point:AFTER FIELD gcah003 name="construct.a.page2.gcah003"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gcah003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcah003
            #add-point:ON ACTION controlp INFIELD gcah003 name="construct.c.page2.gcah003"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcah003_desc
            #add-point:BEFORE FIELD gcah003_desc name="construct.b.page2.gcah003_desc"
                                                                        NEXT FIELD gcahstus
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcah003_desc
            
            #add-point:AFTER FIELD gcah003_desc name="construct.a.page2.gcah003_desc"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gcah003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcah003_desc
            #add-point:ON ACTION controlp INFIELD gcah003_desc name="construct.c.page2.gcah003_desc"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcahstus
            #add-point:BEFORE FIELD gcahstus name="construct.b.page2.gcahstus"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcahstus
            
            #add-point:AFTER FIELD gcahstus name="construct.a.page2.gcahstus"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gcahstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcahstus
            #add-point:ON ACTION controlp INFIELD gcahstus name="construct.c.page2.gcahstus"
                                                            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON gcai002,gcai003,gcai004,gcai005,gcai006,gcai007,gcai008,gcaistus
           FROM s_detail3[1].gcai002,s_detail3[1].gcai003,s_detail3[1].gcai004,s_detail3[1].gcai005, 
               s_detail3[1].gcai006,s_detail3[1].gcai007,s_detail3[1].gcai008,s_detail3[1].gcaistus
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
                                                            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gcaicrtdt>>----
 
         #----<<gcaimoddt>>----
         
         #----<<gcaicnfdt>>----
         
         #----<<gcaipstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcai002
            #add-point:BEFORE FIELD gcai002 name="construct.b.page3.gcai002"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcai002
            
            #add-point:AFTER FIELD gcai002 name="construct.a.page3.gcai002"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gcai002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcai002
            #add-point:ON ACTION controlp INFIELD gcai002 name="construct.c.page3.gcai002"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcai003
            #add-point:BEFORE FIELD gcai003 name="construct.b.page3.gcai003"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcai003
            
            #add-point:AFTER FIELD gcai003 name="construct.a.page3.gcai003"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gcai003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcai003
            #add-point:ON ACTION controlp INFIELD gcai003 name="construct.c.page3.gcai003"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcai004
            #add-point:BEFORE FIELD gcai004 name="construct.b.page3.gcai004"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcai004
            
            #add-point:AFTER FIELD gcai004 name="construct.a.page3.gcai004"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gcai004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcai004
            #add-point:ON ACTION controlp INFIELD gcai004 name="construct.c.page3.gcai004"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcai005
            #add-point:BEFORE FIELD gcai005 name="construct.b.page3.gcai005"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcai005
            
            #add-point:AFTER FIELD gcai005 name="construct.a.page3.gcai005"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gcai005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcai005
            #add-point:ON ACTION controlp INFIELD gcai005 name="construct.c.page3.gcai005"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcai006
            #add-point:BEFORE FIELD gcai006 name="construct.b.page3.gcai006"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcai006
            
            #add-point:AFTER FIELD gcai006 name="construct.a.page3.gcai006"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gcai006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcai006
            #add-point:ON ACTION controlp INFIELD gcai006 name="construct.c.page3.gcai006"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcai007
            #add-point:BEFORE FIELD gcai007 name="construct.b.page3.gcai007"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcai007
            
            #add-point:AFTER FIELD gcai007 name="construct.a.page3.gcai007"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gcai007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcai007
            #add-point:ON ACTION controlp INFIELD gcai007 name="construct.c.page3.gcai007"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcai008
            #add-point:BEFORE FIELD gcai008 name="construct.b.page3.gcai008"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcai008
            
            #add-point:AFTER FIELD gcai008 name="construct.a.page3.gcai008"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gcai008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcai008
            #add-point:ON ACTION controlp INFIELD gcai008 name="construct.c.page3.gcai008"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaistus
            #add-point:BEFORE FIELD gcaistus name="construct.b.page3.gcaistus"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaistus
            
            #add-point:AFTER FIELD gcaistus name="construct.a.page3.gcaistus"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gcaistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaistus
            #add-point:ON ACTION controlp INFIELD gcaistus name="construct.c.page3.gcaistus"
                                                            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON gcaj002,gcaj003,gcajstus
           FROM s_detail4[1].gcaj002,s_detail4[1].gcaj003,s_detail4[1].gcajstus
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
                                                            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gcajcrtdt>>----
 
         #----<<gcajmoddt>>----
         
         #----<<gcajcnfdt>>----
         
         #----<<gcajpstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page4.gcaj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaj002
            #add-point:ON ACTION controlp INFIELD gcaj002 name="construct.c.page4.gcaj002"
                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   #161024-00025#1--dongsz add--s
			   #判断aooi500是否有设定
            IF s_aooi500_setpoint(g_prog,'gcaj002') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcaj002',g_site,'c') 
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001()
            END IF
            #161024-00025#1--dongsz add--e
            #161024-00025#1--dongsz mark--s
#			   LET g_qryparam.where = " ooef201 = 'Y' "
#            CALL q_ooef001()                           #呼叫開窗
            #161024-00025#1--dongsz mark--e
            DISPLAY g_qryparam.return1 TO gcaj002  #顯示到畫面上

            NEXT FIELD gcaj002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaj002
            #add-point:BEFORE FIELD gcaj002 name="construct.b.page4.gcaj002"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaj002
            
            #add-point:AFTER FIELD gcaj002 name="construct.a.page4.gcaj002"
                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaj003
            #add-point:BEFORE FIELD gcaj003 name="construct.b.page4.gcaj003"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaj003
            
            #add-point:AFTER FIELD gcaj003 name="construct.a.page4.gcaj003"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gcaj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaj003
            #add-point:ON ACTION controlp INFIELD gcaj003 name="construct.c.page4.gcaj003"
                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcajstus
            #add-point:BEFORE FIELD gcajstus name="construct.b.page4.gcajstus"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcajstus
            
            #add-point:AFTER FIELD gcajstus name="construct.a.page4.gcajstus"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gcajstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcajstus
            #add-point:ON ACTION controlp INFIELD gcajstus name="construct.c.page4.gcajstus"
                                                            
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
 
            INITIALIZE g_wc2_table3 TO NULL
 
            INITIALIZE g_wc2_table4 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "gcaf_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "gcag_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "gcah_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "gcai_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "gcaj_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
 
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
 
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
               
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION agcm300_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
               
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_gcag_d.clear()
   CALL g_gcag2_d.clear()
   CALL g_gcag3_d.clear()
   CALL g_gcag4_d.clear()
 
   
   #add-point:query段other name="query.other"
               
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL agcm300_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL agcm300_browser_fill("")
      CALL agcm300_fetch("")
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
   LET g_detail_idx_list[4] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL agcm300_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL agcm300_fetch("F") 
      #顯示單身筆數
      CALL agcm300_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION agcm300_fetch(p_flag)
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
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_gcaf_m.gcaf001 = g_browser[g_current_idx].b_gcaf001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE agcm300_master_referesh USING g_gcaf_m.gcaf001 INTO g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcaf003, 
       g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005,g_gcaf_m.gcaf006,g_gcaf_m.gcaf007, 
       g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011,g_gcaf_m.gcaf012,g_gcaf_m.gcaf013, 
       g_gcaf_m.gcaf041,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037,g_gcaf_m.gcaf038,g_gcaf_m.gcaf039, 
       g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020, 
       g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035,g_gcaf_m.gcaf036, 
       g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf040,g_gcaf_m.gcaf026,g_gcaf_m.gcaf032, 
       g_gcaf_m.gcaf033,g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcafownid,g_gcaf_m.gcafowndp,g_gcaf_m.gcafcrtid, 
       g_gcaf_m.gcafcrtdp,g_gcaf_m.gcafcrtdt,g_gcaf_m.gcafmodid,g_gcaf_m.gcafmoddt,g_gcaf_m.gcafcnfid, 
       g_gcaf_m.gcafcnfdt,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028,g_gcaf_m.gcaf029,g_gcaf_m.gcaf030,g_gcaf_m.gcafunit_desc, 
       g_gcaf_m.gcaf012_desc,g_gcaf_m.gcaf013_desc,g_gcaf_m.gcaf031_desc,g_gcaf_m.gcafownid_desc,g_gcaf_m.gcafowndp_desc, 
       g_gcaf_m.gcafcrtid_desc,g_gcaf_m.gcafcrtdp_desc,g_gcaf_m.gcafmodid_desc,g_gcaf_m.gcafcnfid_desc 
 
   
   #遮罩相關處理
   LET g_gcaf_m_mask_o.* =  g_gcaf_m.*
   CALL agcm300_gcaf_t_mask()
   LET g_gcaf_m_mask_n.* =  g_gcaf_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agcm300_set_act_visible()   
   CALL agcm300_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   IF g_gcaf_m.gcafstus = 'Y' OR g_gcaf_m.gcafstus = 'X' THEN
      #CALL cl_set_act_visible('modify,delete,reproduce',FALSE)    #150521-00030#2
      CALL cl_set_act_visible('modify,delete',FALSE)
   ELSE
      #CALL cl_set_act_visible('modify,delete,reproduce',TRUE)     #150521-00030#2
      CALL cl_set_act_visible('modify,delete',TRUE)
   END IF
   CALL agcm300_set_act_visible()
   CALL agcm300_set_act_no_visible()   #150424-00018#1 150529 add by beckxie
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
               
   #end add-point
   
   #保存單頭舊值
   LET g_gcaf_m_t.* = g_gcaf_m.*
   LET g_gcaf_m_o.* = g_gcaf_m.*
   
   LET g_data_owner = g_gcaf_m.gcafownid      
   LET g_data_dept  = g_gcaf_m.gcafowndp
   
   #重新顯示   
   CALL agcm300_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300.insert" >}
#+ 資料新增
PRIVATE FUNCTION agcm300_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert      LIKE type_t.num5               
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_gcag_d.clear()   
   CALL g_gcag2_d.clear()  
   CALL g_gcag3_d.clear()  
   CALL g_gcag4_d.clear()  
 
 
   INITIALIZE g_gcaf_m.* TO NULL             #DEFAULT 設定
   
   LET g_gcaf001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gcaf_m.gcafownid = g_user
      LET g_gcaf_m.gcafowndp = g_dept
      LET g_gcaf_m.gcafcrtid = g_user
      LET g_gcaf_m.gcafcrtdp = g_dept 
      LET g_gcaf_m.gcafcrtdt = cl_get_current()
      LET g_gcaf_m.gcafmodid = g_user
      LET g_gcaf_m.gcafmoddt = cl_get_current()
      LET g_gcaf_m.gcafstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_gcaf_m.gcaf002 = "0"
      LET g_gcaf_m.gcaf003 = "1"
      LET g_gcaf_m.gcaf004 = "1"
      LET g_gcaf_m.gcafstus = "N"
      LET g_gcaf_m.gcaf015 = "Y"
      LET g_gcaf_m.gcaf043 = "N"
      LET g_gcaf_m.gcaf037 = "N"
      LET g_gcaf_m.gcaf038 = "N"
      LET g_gcaf_m.gcaf039 = "100"
      LET g_gcaf_m.gcaf016 = "Y"
      LET g_gcaf_m.gcaf017 = "1"
      LET g_gcaf_m.gcaf018 = "1"
      LET g_gcaf_m.gcaf021 = "Y"
      LET g_gcaf_m.gcaf022 = "1"
      LET g_gcaf_m.gcaf024 = "1"
      LET g_gcaf_m.gcaf025 = "1"
      LET g_gcaf_m.gcaf026 = "N"
      LET g_gcaf_m.gcaf032 = "1"
      LET g_gcaf_m.gcaf033 = "1"
      LET g_gcaf_m.gcaf044 = "Y"
      LET g_gcaf_m.gcaf045 = "N"
      LET g_gcaf_m.gcaf027 = "Y"
      LET g_gcaf_m.gcaf028 = "Y"
      LET g_gcaf_m.gcaf029 = "0"
      LET g_gcaf_m.gcaf030 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      INITIALIZE g_gcaf_m_t.* TO NULL
     #LET g_gcaf_m.gcafunit = g_site
      CALL s_aooi500_default(g_prog,'gcafunit',g_gcaf_m.gcafunit)
         RETURNING l_insert,g_gcaf_m.gcafunit
      IF l_insert = FALSE THEN
         RETURN
      END IF
      LET g_site_flag = FALSE
      CALL agcm300_gcafunit_ref()
      ################add by huangtao 150513-00012#1 begin
      LET g_gcaf_m.gcaf017 = '0'
      ################end
      ##################
      LET g_gcaf_m.gcaf034 = 'N'
      LET g_gcaf_m.gcaf036 = 'N'
      ##################
      #160728-00006#37 -s by 08172
      LET g_gcaf_m.gcaf021 = 'N'
      LET g_gcaf_m.gcaf022 = ''
      #160728-00006#37 -e by 08172
      LET g_gcaf_m_t.* = g_gcaf_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_gcaf_m_t.* = g_gcaf_m.*
      LET g_gcaf_m_o.* = g_gcaf_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gcaf_m.gcafstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
    
      CALL agcm300_input("a")
      
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
         INITIALIZE g_gcaf_m.* TO NULL
         INITIALIZE g_gcag_d TO NULL
         INITIALIZE g_gcag2_d TO NULL
         INITIALIZE g_gcag3_d TO NULL
         INITIALIZE g_gcag4_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL agcm300_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_gcag_d.clear()
      #CALL g_gcag2_d.clear()
      #CALL g_gcag3_d.clear()
      #CALL g_gcag4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agcm300_set_act_visible()   
   CALL agcm300_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gcaf001_t = g_gcaf_m.gcaf001
 
   
   #組合新增資料的條件
   LET g_add_browse = " gcafent = " ||g_enterprise|| " AND",
                      " gcaf001 = '", g_gcaf_m.gcaf001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agcm300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE agcm300_cl
   
   CALL agcm300_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE agcm300_master_referesh USING g_gcaf_m.gcaf001 INTO g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcaf003, 
       g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005,g_gcaf_m.gcaf006,g_gcaf_m.gcaf007, 
       g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011,g_gcaf_m.gcaf012,g_gcaf_m.gcaf013, 
       g_gcaf_m.gcaf041,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037,g_gcaf_m.gcaf038,g_gcaf_m.gcaf039, 
       g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020, 
       g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035,g_gcaf_m.gcaf036, 
       g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf040,g_gcaf_m.gcaf026,g_gcaf_m.gcaf032, 
       g_gcaf_m.gcaf033,g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcafownid,g_gcaf_m.gcafowndp,g_gcaf_m.gcafcrtid, 
       g_gcaf_m.gcafcrtdp,g_gcaf_m.gcafcrtdt,g_gcaf_m.gcafmodid,g_gcaf_m.gcafmoddt,g_gcaf_m.gcafcnfid, 
       g_gcaf_m.gcafcnfdt,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028,g_gcaf_m.gcaf029,g_gcaf_m.gcaf030,g_gcaf_m.gcafunit_desc, 
       g_gcaf_m.gcaf012_desc,g_gcaf_m.gcaf013_desc,g_gcaf_m.gcaf031_desc,g_gcaf_m.gcafownid_desc,g_gcaf_m.gcafowndp_desc, 
       g_gcaf_m.gcafcrtid_desc,g_gcaf_m.gcafcrtdp_desc,g_gcaf_m.gcafmodid_desc,g_gcaf_m.gcafcnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_gcaf_m_mask_o.* =  g_gcaf_m.*
   CALL agcm300_gcaf_t_mask()
   LET g_gcaf_m_mask_n.* =  g_gcaf_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcafl003,g_gcaf_m.gcafl004,g_gcaf_m.gcaf003, 
       g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafunit_desc,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005, 
       g_gcaf_m.gcaf006,g_gcaf_m.gcaf007,g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011, 
       g_gcaf_m.gcaf012,g_gcaf_m.gcaf012_desc,g_gcaf_m.gcaf013,g_gcaf_m.gcaf013_desc,g_gcaf_m.gcaf041, 
       g_gcaf_m.gcaf041_desc,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037,g_gcaf_m.gcaf038,g_gcaf_m.gcaf039, 
       g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020, 
       g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035,g_gcaf_m.gcaf036, 
       g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf031_desc,g_gcaf_m.gcaf040,g_gcaf_m.gcaf026, 
       g_gcaf_m.gcaf032,g_gcaf_m.gcaf033,g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcafownid,g_gcaf_m.gcafownid_desc, 
       g_gcaf_m.gcafowndp,g_gcaf_m.gcafowndp_desc,g_gcaf_m.gcafcrtid,g_gcaf_m.gcafcrtid_desc,g_gcaf_m.gcafcrtdp, 
       g_gcaf_m.gcafcrtdp_desc,g_gcaf_m.gcafcrtdt,g_gcaf_m.gcafmodid,g_gcaf_m.gcafmodid_desc,g_gcaf_m.gcafmoddt, 
       g_gcaf_m.gcafcnfid,g_gcaf_m.gcafcnfid_desc,g_gcaf_m.gcafcnfdt,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028, 
       g_gcaf_m.gcaf029,g_gcaf_m.gcaf030
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_gcaf_m.gcafownid      
   LET g_data_dept  = g_gcaf_m.gcafowndp
   
   #功能已完成,通報訊息中心
   CALL agcm300_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300.modify" >}
#+ 資料修改
PRIVATE FUNCTION agcm300_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
   DEFINE l_wc2_table4   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
               
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_gcaf_m_t.* = g_gcaf_m.*
   LET g_gcaf_m_o.* = g_gcaf_m.*
   
   IF g_gcaf_m.gcaf001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_gcaf001_t = g_gcaf_m.gcaf001
 
   CALL s_transaction_begin()
   
   OPEN agcm300_cl USING g_enterprise,g_gcaf_m.gcaf001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agcm300_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE agcm300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agcm300_master_referesh USING g_gcaf_m.gcaf001 INTO g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcaf003, 
       g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005,g_gcaf_m.gcaf006,g_gcaf_m.gcaf007, 
       g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011,g_gcaf_m.gcaf012,g_gcaf_m.gcaf013, 
       g_gcaf_m.gcaf041,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037,g_gcaf_m.gcaf038,g_gcaf_m.gcaf039, 
       g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020, 
       g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035,g_gcaf_m.gcaf036, 
       g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf040,g_gcaf_m.gcaf026,g_gcaf_m.gcaf032, 
       g_gcaf_m.gcaf033,g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcafownid,g_gcaf_m.gcafowndp,g_gcaf_m.gcafcrtid, 
       g_gcaf_m.gcafcrtdp,g_gcaf_m.gcafcrtdt,g_gcaf_m.gcafmodid,g_gcaf_m.gcafmoddt,g_gcaf_m.gcafcnfid, 
       g_gcaf_m.gcafcnfdt,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028,g_gcaf_m.gcaf029,g_gcaf_m.gcaf030,g_gcaf_m.gcafunit_desc, 
       g_gcaf_m.gcaf012_desc,g_gcaf_m.gcaf013_desc,g_gcaf_m.gcaf031_desc,g_gcaf_m.gcafownid_desc,g_gcaf_m.gcafowndp_desc, 
       g_gcaf_m.gcafcrtid_desc,g_gcaf_m.gcafcrtdp_desc,g_gcaf_m.gcafmodid_desc,g_gcaf_m.gcafcnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT agcm300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gcaf_m_mask_o.* =  g_gcaf_m.*
   CALL agcm300_gcaf_t_mask()
   LET g_gcaf_m_mask_n.* =  g_gcaf_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
   #LET l_wc2_table4 = g_wc2_table4
   #LET l_wc2_table4 = " 1=1"
 
 
 
   
   CALL agcm300_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
 
 
    
   WHILE TRUE
      LET g_gcaf001_t = g_gcaf_m.gcaf001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_gcaf_m.gcafmodid = g_user 
LET g_gcaf_m.gcafmoddt = cl_get_current()
LET g_gcaf_m.gcafmodid_desc = cl_get_username(g_gcaf_m.gcafmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
                              
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL agcm300_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
                              
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE gcaf_t SET (gcafmodid,gcafmoddt) = (g_gcaf_m.gcafmodid,g_gcaf_m.gcafmoddt)
          WHERE gcafent = g_enterprise AND gcaf001 = g_gcaf001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_gcaf_m.* = g_gcaf_m_t.*
            CALL agcm300_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_gcaf_m.gcaf001 != g_gcaf_m_t.gcaf001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                                             
         #end add-point
         
         #更新單身key值
         UPDATE gcag_t SET gcag001 = g_gcaf_m.gcaf001
 
          WHERE gcagent = g_enterprise AND gcag001 = g_gcaf_m_t.gcaf001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                                             
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "gcag_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gcag_t:",SQLERRMESSAGE 
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
         
         UPDATE gcah_t
            SET gcah001 = g_gcaf_m.gcaf001
 
          WHERE gcahent = g_enterprise AND
                gcah001 = g_gcaf001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
                                             
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "gcah_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gcah_t:",SQLERRMESSAGE 
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
         
         UPDATE gcai_t
            SET gcai001 = g_gcaf_m.gcaf001
 
          WHERE gcaient = g_enterprise AND
                gcai001 = g_gcaf001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
                                             
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "gcai_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gcai_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
                                             
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update4"
                                             
         #end add-point
         
         UPDATE gcaj_t
            SET gcaj001 = g_gcaf_m.gcaf001
 
          WHERE gcajent = g_enterprise AND
                gcaj001 = g_gcaf001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
                                             
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "gcaj_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gcaj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
                                             
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agcm300_set_act_visible()   
   CALL agcm300_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " gcafent = " ||g_enterprise|| " AND",
                      " gcaf001 = '", g_gcaf_m.gcaf001, "' "
 
   #填到對應位置
   CALL agcm300_browser_fill("")
 
   CLOSE agcm300_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agcm300_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="agcm300.input" >}
#+ 資料輸入
PRIVATE FUNCTION agcm300_input(p_cmd)
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
   DEFINE  l_oocq009             LIKE oocq_t.oocq009
   DEFINE  l_no                  LIKE type_t.chr10
   DEFINE  l_ooia002             LIKE ooia_t.ooia002   
   DEFINE  l_str                 STRING 
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   #add by geza 20160225--(S)
   DEFINE l_oofg_return   DYNAMIC ARRAY OF RECORD
         oofg019       LIKE oofg_t.oofg019,  #field
         oofg020       LIKE oofg_t.oofg020   #value
                        END RECORD
   #add by geza 20160225--(E)
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
   DISPLAY BY NAME g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcafl003,g_gcaf_m.gcafl004,g_gcaf_m.gcaf003, 
       g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafunit_desc,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005, 
       g_gcaf_m.gcaf006,g_gcaf_m.gcaf007,g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011, 
       g_gcaf_m.gcaf012,g_gcaf_m.gcaf012_desc,g_gcaf_m.gcaf013,g_gcaf_m.gcaf013_desc,g_gcaf_m.gcaf041, 
       g_gcaf_m.gcaf041_desc,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037,g_gcaf_m.gcaf038,g_gcaf_m.gcaf039, 
       g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020, 
       g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035,g_gcaf_m.gcaf036, 
       g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf031_desc,g_gcaf_m.gcaf040,g_gcaf_m.gcaf026, 
       g_gcaf_m.gcaf032,g_gcaf_m.gcaf033,g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcafownid,g_gcaf_m.gcafownid_desc, 
       g_gcaf_m.gcafowndp,g_gcaf_m.gcafowndp_desc,g_gcaf_m.gcafcrtid,g_gcaf_m.gcafcrtid_desc,g_gcaf_m.gcafcrtdp, 
       g_gcaf_m.gcafcrtdp_desc,g_gcaf_m.gcafcrtdt,g_gcaf_m.gcafmodid,g_gcaf_m.gcafmodid_desc,g_gcaf_m.gcafmoddt, 
       g_gcaf_m.gcafcnfid,g_gcaf_m.gcafcnfid_desc,g_gcaf_m.gcafcnfdt,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028, 
       g_gcaf_m.gcaf029,g_gcaf_m.gcaf030
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
               
   #end add-point 
   LET g_forupd_sql = "SELECT gcag002,gcag003,gcag004,gcag005,gcag006,gcagstus FROM gcag_t WHERE gcagent=?  
       AND gcag001=? AND gcag002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
               
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agcm300_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
               
   #end add-point    
   LET g_forupd_sql = "SELECT gcah002,gcah003,gcahstus FROM gcah_t WHERE gcahent=? AND gcah001=? AND  
       gcah002=? AND gcah003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
               
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agcm300_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
               
   #end add-point    
   LET g_forupd_sql = "SELECT gcai002,gcai003,gcai004,gcai005,gcai006,gcai007,gcai008,gcaistus FROM  
       gcai_t WHERE gcaient=? AND gcai001=? AND gcai002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
               
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agcm300_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
               
   #end add-point    
   LET g_forupd_sql = "SELECT gcaj002,gcaj003,gcajstus FROM gcaj_t WHERE gcajent=? AND gcaj001=? AND  
       gcaj002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
               
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agcm300_bcl4 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
               
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL agcm300_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
               
   #end add-point
   CALL agcm300_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcafl003,g_gcaf_m.gcafl004,g_gcaf_m.gcaf003, 
       g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005,g_gcaf_m.gcaf006,g_gcaf_m.gcaf007, 
       g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011,g_gcaf_m.gcaf012,g_gcaf_m.gcaf013, 
       g_gcaf_m.gcaf041,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037,g_gcaf_m.gcaf038,g_gcaf_m.gcaf039, 
       g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020, 
       g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035,g_gcaf_m.gcaf036, 
       g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf026,g_gcaf_m.gcaf032,g_gcaf_m.gcaf033, 
       g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028,g_gcaf_m.gcaf029,g_gcaf_m.gcaf030 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
               
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="agcm300.input.head" >}
      #單頭段
      INPUT BY NAME g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcafl003,g_gcaf_m.gcafl004,g_gcaf_m.gcaf003, 
          g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005,g_gcaf_m.gcaf006,g_gcaf_m.gcaf007, 
          g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011,g_gcaf_m.gcaf012,g_gcaf_m.gcaf013, 
          g_gcaf_m.gcaf041,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037,g_gcaf_m.gcaf038,g_gcaf_m.gcaf039, 
          g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020, 
          g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035,g_gcaf_m.gcaf036, 
          g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf026,g_gcaf_m.gcaf032,g_gcaf_m.gcaf033, 
          g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028,g_gcaf_m.gcaf029,g_gcaf_m.gcaf030  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
                                                                           IF NOT cl_null(g_gcaf_m.gcaf001) THEN
                  CALL n_gcafl(g_gcaf_m.gcaf001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_gcaf_m.gcaf001
                  #CALL ap_ref_array2(g_ref_fields," SELECT gcafl003,gcafl004 FROM gcafl_t WHERE gcafl001 = ? AND gcafl002 = '"||g_lang||"'","") RETURNING g_rtn_fields  #160905-00007#12  mark
                  CALL ap_ref_array2(g_ref_fields," SELECT gcafl003,gcafl004 FROM gcafl_t WHERE gcafl001 = ? AND gcaflent='"||g_enterprise||"' AND gcafl002 = '"||g_lang||"'","") RETURNING g_rtn_fields    #160905-00007#12 add 
                  LET g_gcaf_m.gcafl003 = g_rtn_fields[1]
                  LET g_gcaf_m.gcafl004 = g_rtn_fields[2]
                  DISPLAY BY NAME g_gcaf_m.gcafl003
                  DISPLAY BY NAME g_gcaf_m.gcafl004
               END IF
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN agcm300_cl USING g_enterprise,g_gcaf_m.gcaf001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agcm300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agcm300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.gcafl001 = g_gcaf_m.gcaf001
LET g_master_multi_table_t.gcafl003 = g_gcaf_m.gcafl003
LET g_master_multi_table_t.gcafl004 = g_gcaf_m.gcafl004
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.gcafl001 = ''
LET g_master_multi_table_t.gcafl003 = ''
LET g_master_multi_table_t.gcafl004 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL agcm300_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
                                                                        IF l_cmd_t = 'r' THEN
               LET g_gcaf_m.gcaf001 = ''
               DISPLAY BY NAME g_gcaf_m.gcaf001
            END IF
            CALL cl_set_comp_entry("gcaf010,gcaf011",TRUE)  #add by liyan 160728-00006#17
            #end add-point
            CALL agcm300_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf001
            #add-point:BEFORE FIELD gcaf001 name="input.b.gcaf001"
            #add by geza 20160225(S)
            #增加编号功能
            IF p_cmd = 'a' AND cl_null(g_gcaf_m.gcaf001) THEN    
               CALL s_aooi390_gen('33') RETURNING l_success,g_gcaf_m.gcaf001,l_oofg_return
               DISPLAY BY NAME g_gcaf_m.gcaf001
            END IF      
            #add by geza 20160225--(E)                                                 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf001
            
            #add-point:AFTER FIELD gcaf001 name="input.a.gcaf001"
                                                                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_gcaf_m.gcaf001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gcaf_m.gcaf001 != g_gcaf001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM gcaf_t WHERE "||"gcafent = '" ||g_enterprise|| "' AND "||"gcaf001 = '"||g_gcaf_m.gcaf001 ||"'",'std-00004',0) THEN  #160905-00007#2 count(*) --> count(1)
                     LET g_gcaf_m.gcaf001 = g_gcaf_m_t.gcaf001
                     DISPLAY BY NAME g_gcaf_m.gcaf001
                     NEXT FIELD CURRENT
                  END IF
                  #add by geza 20160225--(S)
                  #檢核如果編碼有異動，需刪除自動編碼新增的oofi最大碼
                  IF NOT s_aooi390_chk('33',g_gcaf_m.gcaf001) THEN
                     LET g_gcaf_m.gcaf001 = g_gcaf_m_t.gcaf001
                     NEXT FIELD CURRENT
                  END IF
                  #add by geza 20160225--(E)
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf001
            #add-point:ON CHANGE gcaf001 name="input.g.gcaf001"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf002
            #add-point:BEFORE FIELD gcaf002 name="input.b.gcaf002"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf002
            
            #add-point:AFTER FIELD gcaf002 name="input.a.gcaf002"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf002
            #add-point:ON CHANGE gcaf002 name="input.g.gcaf002"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafl003
            #add-point:BEFORE FIELD gcafl003 name="input.b.gcafl003"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcafl003
            
            #add-point:AFTER FIELD gcafl003 name="input.a.gcafl003"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcafl003
            #add-point:ON CHANGE gcafl003 name="input.g.gcafl003"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafl004
            #add-point:BEFORE FIELD gcafl004 name="input.b.gcafl004"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcafl004
            
            #add-point:AFTER FIELD gcafl004 name="input.a.gcafl004"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcafl004
            #add-point:ON CHANGE gcafl004 name="input.g.gcafl004"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf003
            #add-point:BEFORE FIELD gcaf003 name="input.b.gcaf003"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf003
            
            #add-point:AFTER FIELD gcaf003 name="input.a.gcaf003"
                                                                        IF NOT cl_null(g_gcaf_m.gcaf003) THEN
               #IF p_cmd = 'u' AND (g_gcaf_m.gcaf003 <> g_gcaf_m_t.gcaf003) THEN   #160824-00007#97 20161031 mark by beckxie
               IF (g_gcaf_m.gcaf003 <> g_gcaf_m_o.gcaf003) OR cl_null(g_gcaf_m_o.gcaf003)THEN   #160824-00007#97 20161031 add by beckxie
                  IF NOT agcm300_gcaf003_chk('a') THEN
                     #LET g_gcaf_m.gcaf003 = g_gcaf_m_t.gcaf003   #160824-00007#97 20161031 mark by beckxie
                     #160824-00007#97 20161031 add by beckxie---S
                     LET g_gcaf_m.gcaf003 = g_gcaf_m_o.gcaf003
                     LET g_gcaf_m.gcaf021 = g_gcaf_m_o.gcaf021
                     LET g_gcaf_m.gcaf022 = g_gcaf_m_o.gcaf022
                     LET g_gcaf_m.gcaf023 = g_gcaf_m_o.gcaf023
                     DISPLAY BY NAME g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023
                     #160824-00007#97 20161031 add by beckxie---E
                     DISPLAY BY NAME g_gcaf_m.gcaf003
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL agcm300_gcaf015_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaf_m.gcaf003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_gcaf_m.gcaf003 = g_gcaf_m_t.gcaf003   #160824-00007#97 20161031 mark by beckxie
                  #160824-00007#97 20161031 add by beckxie---S
                  LET g_gcaf_m.gcaf003 = g_gcaf_m_o.gcaf003
                  LET g_gcaf_m.gcaf021 = g_gcaf_m_o.gcaf021
                  LET g_gcaf_m.gcaf022 = g_gcaf_m_o.gcaf022
                  LET g_gcaf_m.gcaf023 = g_gcaf_m_o.gcaf023
                  DISPLAY BY NAME g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023
                  #160824-00007#97 20161031 add by beckxie---E
                  DISPLAY BY NAME g_gcaf_m.gcaf003
                  NEXT FIELD CURRENT
               END IF
               #mark by geza 20150615(S)
#               IF g_gcaf_m.gcaf003 <> '4' THEN
#                  LET g_gcaf_m.gcaf029 = '0'
#                  LET g_gcaf_m.gcaf030 = '0'
#                  DISPLAY BY NAME g_gcaf_m.gcaf029,g_gcaf_m.gcaf030
#               END IF
               #mark by geza 20150615(E)
               #dongsz--add--str---
               IF g_gcaf_m.gcaf003 = '4' THEN
                  LET g_gcaf_m.gcaf021 = 'N'
                  LET g_gcaf_m.gcaf022 = ""
                  LET g_gcaf_m.gcaf023 = ""
               END IF
               #dongsz--add--end---
            END IF
            CALL agcm300_set_entry(p_cmd)
            CALL agcm300_set_no_entry(p_cmd)
            CALL agcm300_set_act_visible()
            CALL agcm300_set_act_no_visible()   #150424-00018#1 150529 add by beckxie
            LET g_gcaf_m_o.* = g_gcaf_m.*       #160824-00007#97 20161031 add by beckxie
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf003
            #add-point:ON CHANGE gcaf003 name="input.g.gcaf003"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf004
            #add-point:BEFORE FIELD gcaf004 name="input.b.gcaf004"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf004
            
            #add-point:AFTER FIELD gcaf004 name="input.a.gcaf004"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf004
            #add-point:ON CHANGE gcaf004 name="input.g.gcaf004"
                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcafunit
            
            #add-point:AFTER FIELD gcafunit name="input.a.gcafunit"
            LET g_gcaf_m.gcafunit_desc = ''
            DISPLAY BY NAME g_gcaf_m.gcafunit_desc
           #IF NOT cl_null(g_gcaf_m.gcafunit) THEN
           #   INITIALIZE g_chkparam.* TO NULL
           #   LET g_errshow = '1'
           #   LET g_chkparam.arg1 = g_gcaf_m.gcafunit
           #   LET g_chkparam.arg2 = '8'
           #   LET g_chkparam.arg3 = g_site
           #   IF NOT cl_chk_exist("v_ooed004") THEN
           #      LET g_gcaf_m.gcafunit = g_gcaf_m_t.gcafunit
           #      CALL agcm300_gcafunit_ref()
           #      NEXT FIELD CURRENT
           #   END IF
           #END IF
           #CALL agcm300_gcafunit_ref()
            IF NOT cl_null(g_gcaf_m.gcafunit) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gcaf_m.gcafunit != g_gcaf_m_t.gcafunit OR g_gcaf_m_t.gcafunit IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,'gcafunit',g_gcaf_m.gcafunit,g_gcaf_m.gcafunit)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_gcaf_m.gcafunit = g_gcaf_m_t.gcafunit
                     CALL s_desc_get_department_desc(g_gcaf_m.gcafunit) RETURNING g_gcaf_m.gcafunit_desc
                     DISPLAY BY NAME g_gcaf_m.gcafunit_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_site_flag = TRUE
            CALL s_desc_get_department_desc(g_gcaf_m.gcafunit) RETURNING g_gcaf_m.gcafunit_desc
            DISPLAY BY NAME g_gcaf_m.gcafunit_desc
            CALL agcm300_set_entry(p_cmd)
            CALL agcm300_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafunit
            #add-point:BEFORE FIELD gcafunit name="input.b.gcafunit"
                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcafunit
            #add-point:ON CHANGE gcafunit name="input.g.gcafunit"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcafstus
            #add-point:BEFORE FIELD gcafstus name="input.b.gcafstus"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcafstus
            
            #add-point:AFTER FIELD gcafstus name="input.a.gcafstus"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcafstus
            #add-point:ON CHANGE gcafstus name="input.g.gcafstus"
                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gcaf_m.gcaf005,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD gcaf005
            END IF 
 
 
 
            #add-point:AFTER FIELD gcaf005 name="input.a.gcaf005"
                                                                        IF NOT cl_null(g_gcaf_m.gcaf005) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf005
            #add-point:BEFORE FIELD gcaf005 name="input.b.gcaf005"
                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf005
            #add-point:ON CHANGE gcaf005 name="input.g.gcaf005"
                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gcaf_m.gcaf006,"0.000","0","30.000","1","azz-00087",1) THEN
               NEXT FIELD gcaf006
            END IF 
 
 
 
            #add-point:AFTER FIELD gcaf006 name="input.a.gcaf006"
                                                                        IF NOT cl_null(g_gcaf_m.gcaf006) THEN 
               CALL agcm300_gcaf006_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaf_m.gcaf006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcaf_m.gcaf006 = g_gcaf_m_t.gcaf006
                  DISPLAY BY NAME g_gcaf_m.gcaf006
                  CALL agcm300_gcaf009_init()
                  NEXT FIELD CURRENT
               END IF
               CALL agcm300_gcaf015_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaf_m.gcaf006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcaf_m.gcaf006 = g_gcaf_m_t.gcaf006
                  DISPLAY BY NAME g_gcaf_m.gcaf006
                  CALL agcm300_gcaf009_init()
                  NEXT FIELD CURRENT
               END IF
               CALL agcm300_gcaf015_init()
               IF NOT cl_null(g_errno) THEN
                  IF NOT cl_ask_confirm('agc-00083') THEN
                     LET g_gcaf_m.gcaf006 = g_gcaf_m_t.gcaf006
                     DISPLAY BY NAME g_gcaf_m.gcaf006
                     CALL agcm300_gcaf009_init()
                     NEXT FIELD CURRENT
                  ELSE
                     LET g_gcaf_m.gcaf015 = 'N'
                     DISPLAY BY NAME g_gcaf_m.gcaf015
                  END IF
               END IF
               CALL agcm300_gcaf009_init()
               CALL agcm300_gcaf010_init()
               #add by yangxf ---start--20151217
               IF NOT s_agct300_gcaa010_gcaa011_chk(g_gcaf_m.gcaf001,g_gcaf_m.gcaf006,g_gcaf_m.gcaf007,g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011) THEN 
                  LET g_gcaf_m.gcaf010 = ''
                  LET g_gcaf_m.gcaf011 = ''
               END IF 
               #add by yangxf ----end----20151217
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf006
            #add-point:BEFORE FIELD gcaf006 name="input.b.gcaf006"
            IF cl_null(g_gcaf_m.gcaf001) THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agc-00120'
               LET g_errparam.extend = g_gcaf_m.gcaf001
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD gcaf001
            END IF                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf006
            #add-point:ON CHANGE gcaf006 name="input.g.gcaf006"
                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gcaf_m.gcaf007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD gcaf007
            END IF 
 
 
 
            #add-point:AFTER FIELD gcaf007 name="input.a.gcaf007"
                                                                        IF NOT cl_null(g_gcaf_m.gcaf007) THEN 
               CALL agcm300_gcaf007_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaf_m.gcaf007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcaf_m.gcaf007 = g_gcaf_m_t.gcaf007
                  DISPLAY BY NAME g_gcaf_m.gcaf007
                  CALL agcm300_gcaf009_init()
                  NEXT FIELD CURRENT
               END IF
               CALL agcm300_gcaf015_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaf_m.gcaf007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcaf_m.gcaf007 = g_gcaf_m_t.gcaf007
                  DISPLAY BY NAME g_gcaf_m.gcaf007
                  CALL agcm300_gcaf009_init()
                  NEXT FIELD CURRENT
               END IF
               CALL agcm300_gcaf015_init()
               IF NOT cl_null(g_errno) THEN
                  IF NOT cl_ask_confirm('agc-00083') THEN
                     LET g_gcaf_m.gcaf007 = g_gcaf_m_t.gcaf007
                     DISPLAY BY NAME g_gcaf_m.gcaf007
                     CALL agcm300_gcaf009_init()
                     NEXT FIELD CURRENT
                  ELSE
                     LET g_gcaf_m.gcaf015 = 'N'
                     DISPLAY BY NAME g_gcaf_m.gcaf015
                  END IF
               END IF
               CALL agcm300_gcaf009_init()
               CALL agcm300_gcaf010_init()
               #add by yangxf ---start--20151217
               IF NOT s_agct300_gcaa010_gcaa011_chk(g_gcaf_m.gcaf001,g_gcaf_m.gcaf006,g_gcaf_m.gcaf007,g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011) THEN 
                  LET g_gcaf_m.gcaf010 = ''
                  LET g_gcaf_m.gcaf011 = ''
               END IF 
               #add by yangxf ----end----20151217
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf007
            #add-point:BEFORE FIELD gcaf007 name="input.b.gcaf007"
                                                                        IF cl_null(g_gcaf_m.gcaf006) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agc-00019'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 #请先录入[券号总码长]
               NEXT FIELD gcaf006
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf007
            #add-point:ON CHANGE gcaf007 name="input.g.gcaf007"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf008
            #add-point:BEFORE FIELD gcaf008 name="input.b.gcaf008"
                                                                        IF cl_null(g_gcaf_m.gcaf006) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agc-00019'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 #请先录入[券号总码长]
               NEXT FIELD gcaf006
            END IF
            IF cl_null(g_gcaf_m.gcaf007) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agc-00020'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 #请先录入[券号固定代码长度]
               NEXT FIELD gcaf007
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf008
            
            #add-point:AFTER FIELD gcaf008 name="input.a.gcaf008"
            #IF NOT cl_null(g_gcaf_m.gcaf008) THEN   #160615-00028#4 160623 by sakura mark
               CALL agcm300_gcaf008_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaf_m.gcaf008
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcaf_m.gcaf008 = g_gcaf_m_t.gcaf008
                  DISPLAY BY NAME g_gcaf_m.gcaf008
                  NEXT FIELD CURRENT
               END IF
               CALL agcm300_gcaf010_init()
               #add by yangxf ---start--20151217
               IF NOT s_agct300_gcaa010_gcaa011_chk(g_gcaf_m.gcaf001,g_gcaf_m.gcaf006,g_gcaf_m.gcaf007,g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011) THEN 
                  LET g_gcaf_m.gcaf010 = ''
                  LET g_gcaf_m.gcaf011 = ''
               END IF 
               #add by yangxf ----end----20151217
            #END IF   #160615-00028#4 160623 by sakura mark
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf008
            #add-point:ON CHANGE gcaf008 name="input.g.gcaf008"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf009
            #add-point:BEFORE FIELD gcaf009 name="input.b.gcaf009"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf009
            
            #add-point:AFTER FIELD gcaf009 name="input.a.gcaf009"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf009
            #add-point:ON CHANGE gcaf009 name="input.g.gcaf009"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf010
            #add-point:BEFORE FIELD gcaf010 name="input.b.gcaf010"
                                                                        IF cl_null(g_gcaf_m.gcaf006) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agc-00019'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 #请先录入[券号总码长]
               NEXT FIELD gcaf006
            END IF
            IF cl_null(g_gcaf_m.gcaf007) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agc-00020'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #请先录入[券号固定代码长度]
               NEXT FIELD gcaf007
            END IF
            #160615-00028#4 160623 by sakura mark(E)
            #IF cl_null(g_gcaf_m.gcaf008) THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'agc-00021'
            #   LET g_errparam.extend = ''
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   #请先录入[券号固定代码]
            #   NEXT FIELD gcaf008
            #END IF
            #160615-00028#4 160623 by sakura mark(E)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf010
            
            #add-point:AFTER FIELD gcaf010 name="input.a.gcaf010"
                                                                        IF NOT cl_null(g_gcaf_m.gcaf010) THEN
               CALL agcm300_gcaf010_chk(g_gcaf_m.gcaf010)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaf_m.gcaf010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcaf_m.gcaf010 = g_gcaf_m_t.gcaf010
                  DISPLAY BY NAME g_gcaf_m.gcaf010
                  NEXT FIELD gcaf010
               END IF
               #add by yangxf ---start--20151217
               IF NOT s_agct300_gcaa010_gcaa011_chk(g_gcaf_m.gcaf001,g_gcaf_m.gcaf006,g_gcaf_m.gcaf007,g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011) THEN 
                  NEXT FIELD CURRENT
               END IF 
               #add by yangxf ----end----20151217
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf010
            #add-point:ON CHANGE gcaf010 name="input.g.gcaf010"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf011
            #add-point:BEFORE FIELD gcaf011 name="input.b.gcaf011"
                                                                        IF cl_null(g_gcaf_m.gcaf006) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agc-00019'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 #请先录入[券号总码长]
               NEXT FIELD gcaf006
            END IF
            IF cl_null(g_gcaf_m.gcaf007) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agc-00020'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 #请先录入[券号固定代码长度]
               NEXT FIELD gcaf007
            END IF
            #160615-00028#4 160623 by sakura mark(S)
            #IF cl_null(g_gcaf_m.gcaf008) THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'agc-00021'
            #   LET g_errparam.extend = ''
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   #请先录入[券号固定代码]
            #   NEXT FIELD gcaf008
            #END IF
            #160615-00028#4 160623 by sakura mark(E)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf011
            
            #add-point:AFTER FIELD gcaf011 name="input.a.gcaf011"
                                                                        IF NOT cl_null(g_gcaf_m.gcaf011) THEN
               CALL agcm300_gcaf010_chk(g_gcaf_m.gcaf011)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaf_m.gcaf011
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcaf_m.gcaf011 = g_gcaf_m_t.gcaf011
                  DISPLAY BY NAME g_gcaf_m.gcaf011
                  NEXT FIELD gcaf011
               END IF
               #add by yangxf ---start--20151217
               IF NOT s_agct300_gcaa010_gcaa011_chk(g_gcaf_m.gcaf001,g_gcaf_m.gcaf006,g_gcaf_m.gcaf007,g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011) THEN 
                  NEXT FIELD CURRENT
               END IF 
               #add by yangxf ----end----20151217
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf011
            #add-point:ON CHANGE gcaf011 name="input.g.gcaf011"
                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf012
            
            #add-point:AFTER FIELD gcaf012 name="input.a.gcaf012"
                                                                        LET g_gcaf_m.gcaf012_desc = ''
            DISPLAY BY NAME g_gcaf_m.gcaf012_desc
            IF NOT cl_null(g_gcaf_m.gcaf012) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gcaf_m.gcaf012 != g_gcaf_m_t.gcaf012 OR cl_null(g_gcaf_m_t.gcaf012))) THEN
                  CALL agcm300_gcaf012_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcaf_m.gcaf012
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcaf_m.gcaf012 = g_gcaf_m_t.gcaf012
                     DISPLAY BY NAME g_gcaf_m.gcaf012
                     CALL agcm300_gcaf012_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL agcm300_currency_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcaf_m.gcaf012
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcaf_m.gcaf012 = g_gcaf_m_t.gcaf012
                     DISPLAY BY NAME g_gcaf_m.gcaf012
                     CALL agcm300_gcaf012_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL agcm300_gcaf012_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf012
            #add-point:BEFORE FIELD gcaf012 name="input.b.gcaf012"
                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf012
            #add-point:ON CHANGE gcaf012 name="input.g.gcaf012"
                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf013
            
            #add-point:AFTER FIELD gcaf013 name="input.a.gcaf013"
                                                                        LET g_gcaf_m.gcaf013_desc = ''
            DISPLAY BY NAME g_gcaf_m.gcaf013_desc
            IF NOT cl_null(g_gcaf_m.gcaf013) THEN
               CALL agcm300_gcaf013_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaf_m.gcaf013
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcaf_m.gcaf013 = g_gcaf_m_t.gcaf013
                  DISPLAY BY NAME g_gcaf_m.gcaf013
                  CALL agcm300_gcaf013_ref()
                  #160215-00002#2(S)
                  CALL s_agcm300_gcaa041_chk(g_gcaf_m.gcafunit,g_gcaf_m.gcaf013) RETURNING g_gcaf_m.gcaf041
                  CALL s_desc_get_tax_desc1(g_gcaf_m.gcafunit,g_gcaf_m.gcaf041) RETURNING g_gcaf_m.gcaf041_desc
                  DISPLAY BY NAME g_gcaf_m.gcaf041_desc
                  #160215-00002#2(E)                  
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL agcm300_gcaf013_ref()
            #160215-00002#2(S)
            CALL s_agcm300_gcaa041_chk(g_gcaf_m.gcafunit,g_gcaf_m.gcaf013) RETURNING g_gcaf_m.gcaf041
            CALL s_desc_get_tax_desc1(g_gcaf_m.gcafunit,g_gcaf_m.gcaf041) RETURNING g_gcaf_m.gcaf041_desc
            DISPLAY BY NAME g_gcaf_m.gcaf041_desc
            #160215-00002#2(E)            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf013
            #add-point:BEFORE FIELD gcaf013 name="input.b.gcaf013"
                                                                        IF cl_null(g_gcaf_m.gcafunit) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agc-00030'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 #請先錄入制定組織
               NEXT FIELD gcafunit
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf013
            #add-point:ON CHANGE gcaf013 name="input.g.gcaf013"
                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf041
            
            #add-point:AFTER FIELD gcaf041 name="input.a.gcaf041"
            #160215-00002#2(S)
            LET g_gcaf_m.gcaf041_desc = ''
            DISPLAY BY NAME g_gcaf_m.gcaf041_desc
            IF NOT cl_null(g_gcaf_m.gcaf041) THEN
               IF g_gcaf_m.gcaf041 != g_gcaf_m_o.gcaf041 OR cl_null(g_gcaf_m_o.gcaf041) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_gcaf_m.gcafunit
                  LET g_chkparam.arg2 = g_gcaf_m.gcaf041
                  #160318-00025#42  2016/04/25  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  #160318-00025#42  2016/04/25  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_oodb002") THEN
                     LET g_gcaf_m.gcaf041 = g_gcaf_m_o.gcaf041
                     CALL s_desc_get_tax_desc1(g_gcaf_m.gcafunit,g_gcaf_m.gcaf041) RETURNING g_gcaf_m.gcaf041_desc
                     DISPLAY BY NAME g_gcaf_m.gcaf041_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_gcaf_m_o.gcaf041 = g_gcaf_m.gcaf041
            CALL s_desc_get_tax_desc1(g_gcaf_m.gcafunit,g_gcaf_m.gcaf041) RETURNING g_gcaf_m.gcaf041_desc
            DISPLAY BY NAME g_gcaf_m.gcaf041_desc
            #160215-00002#2(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf041
            #add-point:BEFORE FIELD gcaf041 name="input.b.gcaf041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf041
            #add-point:ON CHANGE gcaf041 name="input.g.gcaf041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf015
            #add-point:BEFORE FIELD gcaf015 name="input.b.gcaf015"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf015
            
            #add-point:AFTER FIELD gcaf015 name="input.a.gcaf015"
                                                                        IF NOT cl_null(g_gcaf_m.gcaf015) THEN
               CALL agcm300_gcaf015_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaf_m.gcaf015
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcaf_m.gcaf015 = g_gcaf_m_t.gcaf015
                  DISPLAY BY NAME g_gcaf_m.gcaf015
                  NEXT FIELD CURRENT
               END IF
               CALL agcm300_gcaf015_init()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaf_m.gcaf015
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcaf_m.gcaf015 = g_gcaf_m_t.gcaf015
                  DISPLAY BY NAME g_gcaf_m.gcaf015
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf015
            #add-point:ON CHANGE gcaf015 name="input.g.gcaf015"
            CALL agcm300_set_entry(p_cmd)       #150825-00006#4--dongsz add
            CALL agcm300_set_no_entry(p_cmd)    #150825-00006#4--dongsz add                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf043
            #add-point:BEFORE FIELD gcaf043 name="input.b.gcaf043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf043
            
            #add-point:AFTER FIELD gcaf043 name="input.a.gcaf043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf043
            #add-point:ON CHANGE gcaf043 name="input.g.gcaf043"
            #add by liyan 160728-00006--str--
            IF g_gcaf_m.gcaf043='Y' THEN
               let g_gcaf_m.gcaf010=''
               let g_gcaf_m.gcaf011=''
               CALL cl_set_comp_entry("gcaf010,gcaf011",FALSE)
               IF cl_null(g_gcaf_m.gcaf007) OR g_gcaf_m.gcaf007='0' THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agc-00220'
                  LET g_errparam.extend =""
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD gcaf007
               END IF 
            ELSE
               CALL cl_set_comp_entry("gcaf010,gcaf011",TRUE)
            END IF                
            #add by liyan 160728-00006--end-- 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf037
            #add-point:BEFORE FIELD gcaf037 name="input.b.gcaf037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf037
            
            #add-point:AFTER FIELD gcaf037 name="input.a.gcaf037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf037
            #add-point:ON CHANGE gcaf037 name="input.g.gcaf037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf038
            #add-point:BEFORE FIELD gcaf038 name="input.b.gcaf038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf038
            
            #add-point:AFTER FIELD gcaf038 name="input.a.gcaf038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf038
            #add-point:ON CHANGE gcaf038 name="input.g.gcaf038"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf039
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gcaf_m.gcaf039,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD gcaf039
            END IF 
 
 
 
            #add-point:AFTER FIELD gcaf039 name="input.a.gcaf039"
            IF NOT cl_null(g_gcaf_m.gcaf039) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf039
            #add-point:BEFORE FIELD gcaf039 name="input.b.gcaf039"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf039
            #add-point:ON CHANGE gcaf039 name="input.g.gcaf039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf016
            #add-point:BEFORE FIELD gcaf016 name="input.b.gcaf016"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf016
            
            #add-point:AFTER FIELD gcaf016 name="input.a.gcaf016"
                                                                        IF NOT cl_null(g_gcaf_m.gcaf016) THEN
               IF g_gcaf_m.gcaf016 = 'N' THEN
                  LET g_gcaf_m.gcaf017 = ''
                  LET g_gcaf_m.gcaf018 = ''
                  LET g_gcaf_m.gcaf019 = ''
                  LET g_gcaf_m.gcaf020 = ''
               ELSE
                  IF cl_null(g_gcaf_m.gcaf017) OR cl_null(g_gcaf_m.gcaf018) THEN
                     LET g_gcaf_m.gcaf017 = '0'
                     LET g_gcaf_m.gcaf018 = '1'
                     LET g_gcaf_m.gcaf018 = ''
                     LET g_gcaf_m.gcaf018 = ''
                  END IF
               END IF
               DISPLAY BY NAME g_gcaf_m.gcaf017,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020
            END IF
            CALL agcm300_set_entry(p_cmd)
            CALL agcm300_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf016
            #add-point:ON CHANGE gcaf016 name="input.g.gcaf016"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf017
            #add-point:BEFORE FIELD gcaf017 name="input.b.gcaf017"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf017
            
            #add-point:AFTER FIELD gcaf017 name="input.a.gcaf017"
                                                                        IF NOT cl_null(g_gcaf_m.gcaf017) THEN
               IF NOT agcm300_gcaf017_chk() THEN
                  LET g_gcaf_m.gcaf017 = g_gcaf_m_t.gcaf017
                  DISPLAY BY NAME g_gcaf_m.gcaf017
                  NEXT FIELD CURRENT
               END IF
            END IF
            #160728-00006#2 -s by 08172
            IF g_gcaf_m.gcaf017 = '0' THEN
               CALL cl_set_combo_scc_part('gcaf018','6525','1')
               LET g_gcaf_m.gcaf018 = '1'
            ELSE
               LET g_gcaf_m.gcaf042 = ''
               CALL cl_set_combo_scc_part('gcaf018','6525','2,3')
               LET g_gcaf_m.gcaf018 = '2'
            END IF
            #160728-00006#2 -s by 08172 
            CALL agcm300_gcaf018_desc()
            CALL agcm300_set_entry(p_cmd)
            CALL agcm300_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf017
            #add-point:ON CHANGE gcaf017 name="input.g.gcaf017"
            #160728-00006#2 -s by 08172
            IF g_gcaf_m.gcaf017 = '0' THEN
               CALL cl_set_combo_scc_part('gcaf018','6525','1')
               LET g_gcaf_m.gcaf018 = '1'
            ELSE
               LET g_gcaf_m.gcaf042 = ''
               CALL cl_set_combo_scc_part('gcaf018','6525','2,3')
               LET g_gcaf_m.gcaf018 = '2'
            END IF
            CALL agcm300_set_entry(p_cmd)
            CALL agcm300_set_no_entry(p_cmd)
            #160728-00006#2 -s by 08172                                                 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf042
            #add-point:BEFORE FIELD gcaf042 name="input.b.gcaf042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf042
            
            #add-point:AFTER FIELD gcaf042 name="input.a.gcaf042"
            #160728-00006#2 -s by 08172
            IF NOT cl_null(g_gcaf_m.gcaf042) AND NOT cl_null(g_gcaf_m.gcaf019) THEN
               IF g_gcaf_m.gcaf042 > g_gcaf_m.gcaf019 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00080'
                  LET g_errparam.extend = g_gcaf_m.gcaf042
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_gcaf_m.gcaf042 = g_gcaf_m_t.gcaf042
                  NEXT FIELD CURRENT
               END IF 
            END IF
            #160728-00006#2 -e by 08172
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf042
            #add-point:ON CHANGE gcaf042 name="input.g.gcaf042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf018
            #add-point:BEFORE FIELD gcaf018 name="input.b.gcaf018"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf018
            
            #add-point:AFTER FIELD gcaf018 name="input.a.gcaf018"
                                                                        IF NOT cl_null(g_gcaf_m.gcaf018) THEN
               CALL agcm300_gcaf018_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaf_m.gcaf018
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcaf_m.gcaf018 = g_gcaf_m_t.gcaf018
                  DISPLAY BY NAME g_gcaf_m.gcaf018
                  CALL agcm300_gcaf018_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL agcm300_gcaf018_desc()
            CALL agcm300_set_entry(p_cmd)
            CALL agcm300_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf018
            #add-point:ON CHANGE gcaf018 name="input.g.gcaf018"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf019
            #add-point:BEFORE FIELD gcaf019 name="input.b.gcaf019"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf019
            
            #add-point:AFTER FIELD gcaf019 name="input.a.gcaf019"
            #160728-00006#2 -s by 08172
            IF NOT cl_null(g_gcaf_m.gcaf042) AND NOT cl_null(g_gcaf_m.gcaf019) THEN
               IF g_gcaf_m.gcaf042 > g_gcaf_m.gcaf019 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00081'
                  LET g_errparam.extend = g_gcaf_m.gcaf019
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_gcaf_m.gcaf019 = g_gcaf_m_t.gcaf019
                  NEXT FIELD CURRENT
               END IF 
            END IF
            #160728-00006#2 -e by 08172                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf019
            #add-point:ON CHANGE gcaf019 name="input.g.gcaf019"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf020
            #add-point:BEFORE FIELD gcaf020 name="input.b.gcaf020"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf020
            
            #add-point:AFTER FIELD gcaf020 name="input.a.gcaf020"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf020
            #add-point:ON CHANGE gcaf020 name="input.g.gcaf020"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf021
            #add-point:BEFORE FIELD gcaf021 name="input.b.gcaf021"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf021
            
            #add-point:AFTER FIELD gcaf021 name="input.a.gcaf021"
                                                                        IF NOT cl_null(g_gcaf_m.gcaf021) AND g_gcaf_m.gcaf021 = 'N' THEN
               LET g_gcaf_m.gcaf022 = ''
               LET g_gcaf_m.gcaf023 = ''
               DISPLAY BY NAME g_gcaf_m.gcaf022,g_gcaf_m.gcaf023
            END IF
            CALL agcm300_set_entry(p_cmd)
            CALL agcm300_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf021
            #add-point:ON CHANGE gcaf021 name="input.g.gcaf021"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf022
            #add-point:BEFORE FIELD gcaf022 name="input.b.gcaf022"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf022
            
            #add-point:AFTER FIELD gcaf022 name="input.a.gcaf022"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf022
            #add-point:ON CHANGE gcaf022 name="input.g.gcaf022"
                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf023
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gcaf_m.gcaf023,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD gcaf023
            END IF 
 
 
 
            #add-point:AFTER FIELD gcaf023 name="input.a.gcaf023"
                                                                        IF NOT cl_null(g_gcaf_m.gcaf023) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf023
            #add-point:BEFORE FIELD gcaf023 name="input.b.gcaf023"
                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf023
            #add-point:ON CHANGE gcaf023 name="input.g.gcaf023"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf034
            #add-point:BEFORE FIELD gcaf034 name="input.b.gcaf034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf034
            
            #add-point:AFTER FIELD gcaf034 name="input.a.gcaf034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf034
            #add-point:ON CHANGE gcaf034 name="input.g.gcaf034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf035
            #add-point:BEFORE FIELD gcaf035 name="input.b.gcaf035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf035
            
            #add-point:AFTER FIELD gcaf035 name="input.a.gcaf035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf035
            #add-point:ON CHANGE gcaf035 name="input.g.gcaf035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf036
            #add-point:BEFORE FIELD gcaf036 name="input.b.gcaf036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf036
            
            #add-point:AFTER FIELD gcaf036 name="input.a.gcaf036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf036
            #add-point:ON CHANGE gcaf036 name="input.g.gcaf036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf024
            #add-point:BEFORE FIELD gcaf024 name="input.b.gcaf024"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf024
            
            #add-point:AFTER FIELD gcaf024 name="input.a.gcaf024"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf024
            #add-point:ON CHANGE gcaf024 name="input.g.gcaf024"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf025
            #add-point:BEFORE FIELD gcaf025 name="input.b.gcaf025"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf025
            
            #add-point:AFTER FIELD gcaf025 name="input.a.gcaf025"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf025
            #add-point:ON CHANGE gcaf025 name="input.g.gcaf025"
                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf031
            
            #add-point:AFTER FIELD gcaf031 name="input.a.gcaf031"
            LET g_gcaf_m.gcaf031_desc = ' ' 
            DISPLAY BY NAME g_gcaf_m.gcaf031_desc 
            IF NOT cl_null(g_gcaf_m.gcaf031) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gcaf_m.gcaf031 != g_gcaf_m_t.gcaf031 OR 
                                                   g_gcaf_m_t.gcaf031 IS NULL )) THEN 
               
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_gcaf_m.gcaf031
                     
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooia001") THEN
                     LET g_gcaf_m.gcaf031 = g_gcaf_m_t.gcaf031  
                     CALL agcm300_gcaf031_ref() 
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_money_chk('1',g_gcaf_m.gcafunit,g_gcaf_m.gcaf031) RETURNING l_success,g_errno,l_no,l_ooia002
                  IF NOT l_success THEN
                     #檢查失敗時後續處理
                     LET g_gcaf_m.gcaf031 = g_gcaf_m_t.gcaf031
                     LET g_gcaf_m.gcaf031_desc = g_gcaf_m_t.gcaf031_desc 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                  
                     DISPLAY BY NAME g_gcaf_m.gcaf031,g_gcaf_m.gcaf031_desc
                     NEXT FIELD CURRENT
                  END IF 
                  IF l_ooia002 <> '40' THEN
                     LET g_gcaf_m.gcaf031 = g_gcaf_m_t.gcaf031
                     LET g_gcaf_m.gcaf031_desc = g_gcaf_m_t.gcaf031_desc 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'ade-00069'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                  
                     DISPLAY BY NAME g_gcaf_m.gcaf031,g_gcaf_m.gcaf031_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL agcm300_currency_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcaf_m.gcaf031
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcaf_m.gcaf031 = g_gcaf_m_t.gcaf031  
                     CALL agcm300_gcaf031_ref() 
                     NEXT FIELD CURRENT
                  END IF
               END IF 
            END IF 
            CALL agcm300_gcaf031_ref() 

            CALL agcm300_get_gcaf040(g_gcaf_m.gcaf031) RETURNING g_gcaf_m.gcaf040  #added by lanjj 2016-04-06
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf031
            #add-point:BEFORE FIELD gcaf031 name="input.b.gcaf031"
                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf031
            #add-point:ON CHANGE gcaf031 name="input.g.gcaf031"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf026
            #add-point:BEFORE FIELD gcaf026 name="input.b.gcaf026"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf026
            
            #add-point:AFTER FIELD gcaf026 name="input.a.gcaf026"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf026
            #add-point:ON CHANGE gcaf026 name="input.g.gcaf026"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf032
            #add-point:BEFORE FIELD gcaf032 name="input.b.gcaf032"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf032
            
            #add-point:AFTER FIELD gcaf032 name="input.a.gcaf032"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf032
            #add-point:ON CHANGE gcaf032 name="input.g.gcaf032"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf033
            #add-point:BEFORE FIELD gcaf033 name="input.b.gcaf033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf033
            
            #add-point:AFTER FIELD gcaf033 name="input.a.gcaf033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf033
            #add-point:ON CHANGE gcaf033 name="input.g.gcaf033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf044
            #add-point:BEFORE FIELD gcaf044 name="input.b.gcaf044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf044
            
            #add-point:AFTER FIELD gcaf044 name="input.a.gcaf044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf044
            #add-point:ON CHANGE gcaf044 name="input.g.gcaf044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf045
            #add-point:BEFORE FIELD gcaf045 name="input.b.gcaf045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf045
            
            #add-point:AFTER FIELD gcaf045 name="input.a.gcaf045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf045
            #add-point:ON CHANGE gcaf045 name="input.g.gcaf045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf027
            #add-point:BEFORE FIELD gcaf027 name="input.b.gcaf027"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf027
            
            #add-point:AFTER FIELD gcaf027 name="input.a.gcaf027"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf027
            #add-point:ON CHANGE gcaf027 name="input.g.gcaf027"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf028
            #add-point:BEFORE FIELD gcaf028 name="input.b.gcaf028"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf028
            
            #add-point:AFTER FIELD gcaf028 name="input.a.gcaf028"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf028
            #add-point:ON CHANGE gcaf028 name="input.g.gcaf028"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf029
            #add-point:BEFORE FIELD gcaf029 name="input.b.gcaf029"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf029
            
            #add-point:AFTER FIELD gcaf029 name="input.a.gcaf029"
            #mark by geza 20150818(S)
#            IF NOT cl_null(g_gcaf_m.gcaf029) THEN
#               IF g_gcaf_m.gcaf029 = '0' THEN
#                  LET g_gcaf_m.gcaf030 = '0'
#                  DISPLAY BY NAME g_gcaf_m.gcaf030
#               END IF
#            END IF
#            CALL agcm300_set_entry(p_cmd)
#            CALL agcm300_set_no_entry(p_cmd)
            #mark by geza 20150818(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf029
            #add-point:ON CHANGE gcaf029 name="input.g.gcaf029"
            #add by geza 20150818(S)
            IF NOT cl_null(g_gcaf_m.gcaf029) THEN
               IF g_gcaf_m.gcaf029 = '0' THEN
                  LET g_gcaf_m.gcaf030 = '0'
                  DISPLAY BY NAME g_gcaf_m.gcaf030
               END IF
            END IF
            CALL agcm300_set_entry(p_cmd)
            CALL agcm300_set_no_entry(p_cmd)
            IF NOT cl_null(g_gcaf_m.gcaf029) AND NOT cl_null(g_gcaf_m.gcaf030) THEN
               IF g_gcaf_m.gcaf029 != '0' AND g_gcaf_m.gcaf030 = '0' THEN
                  NEXT FIELD gcaf030
               END IF
            END IF
            #add by geza 20150818(E)                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaf030
            #add-point:BEFORE FIELD gcaf030 name="input.b.gcaf030"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaf030
            
            #add-point:AFTER FIELD gcaf030 name="input.a.gcaf030"
                                                                        IF NOT cl_null(g_gcaf_m.gcaf030) THEN
               CALL agcm300_gcaf030_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaf_m.gcaf030
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcaf_m.gcaf030 = g_gcaf_m_t.gcaf030
                  DISPLAY BY NAME g_gcaf_m.gcaf030
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaf030
            #add-point:ON CHANGE gcaf030 name="input.g.gcaf030"
                                                            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gcaf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf001
            #add-point:ON ACTION controlp INFIELD gcaf001 name="input.c.gcaf001"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf002
            #add-point:ON ACTION controlp INFIELD gcaf002 name="input.c.gcaf002"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcafl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcafl003
            #add-point:ON ACTION controlp INFIELD gcafl003 name="input.c.gcafl003"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcafl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcafl004
            #add-point:ON ACTION controlp INFIELD gcafl004 name="input.c.gcafl004"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf003
            #add-point:ON ACTION controlp INFIELD gcaf003 name="input.c.gcaf003"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf004
            #add-point:ON ACTION controlp INFIELD gcaf004 name="input.c.gcaf004"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcafunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcafunit
            #add-point:ON ACTION controlp INFIELD gcafunit name="input.c.gcafunit"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gcaf_m.gcafunit     #給予default值
            #給予arg
           #LET g_qryparam.arg1 = g_site #
           #LET g_qryparam.arg2 = '8'
           #CALL q_ooed004()                                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcafunit',g_gcaf_m.gcafunit,'i') #150308-00001#2  By sakura add 'i'
            CALL q_ooef001_24()
            LET g_gcaf_m.gcafunit = g_qryparam.return1      #將開窗取得的值回傳到變數
            DISPLAY g_gcaf_m.gcafunit TO gcafunit           #顯示到畫面上
            CALL s_desc_get_department_desc(g_gcaf_m.gcafunit) RETURNING g_gcaf_m.gcafunit_desc
            DISPLAY BY NAME g_gcaf_m.gcafunit_desc
            NEXT FIELD gcafunit                             #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.gcafstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcafstus
            #add-point:ON ACTION controlp INFIELD gcafstus name="input.c.gcafstus"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf005
            #add-point:ON ACTION controlp INFIELD gcaf005 name="input.c.gcaf005"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf006
            #add-point:ON ACTION controlp INFIELD gcaf006 name="input.c.gcaf006"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf007
            #add-point:ON ACTION controlp INFIELD gcaf007 name="input.c.gcaf007"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf008
            #add-point:ON ACTION controlp INFIELD gcaf008 name="input.c.gcaf008"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf009
            #add-point:ON ACTION controlp INFIELD gcaf009 name="input.c.gcaf009"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf010
            #add-point:ON ACTION controlp INFIELD gcaf010 name="input.c.gcaf010"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf011
            #add-point:ON ACTION controlp INFIELD gcaf011 name="input.c.gcaf011"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf012
            #add-point:ON ACTION controlp INFIELD gcaf012 name="input.c.gcaf012"
                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcaf_m.gcaf012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2071" #
			LET g_qryparam.where = " oocq019 = '40' "

            CALL q_oocq002()                                #呼叫開窗

            LET g_gcaf_m.gcaf012 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcaf_m.gcaf012 TO gcaf012              #顯示到畫面上
            
            CALL agcm300_gcaf012_ref()

            NEXT FIELD gcaf012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.gcaf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf013
            #add-point:ON ACTION controlp INFIELD gcaf013 name="input.c.gcaf013"
                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcaf_m.gcaf013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_gcaf_m.gcafunit #

            CALL q_rtdx001_1()                                #呼叫開窗

            LET g_gcaf_m.gcaf013 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcaf_m.gcaf013 TO gcaf013              #顯示到畫面上
            
            CALL agcm300_gcaf013_ref()

            NEXT FIELD gcaf013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.gcaf041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf041
            #add-point:ON ACTION controlp INFIELD gcaf041 name="input.c.gcaf041"
            #160215-00002#2(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gcaf_m.gcaf041             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_gcaf_m.gcafunit
            CALL q_oodb002_1()                                #呼叫開窗
            LET g_gcaf_m.gcaf041 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_gcaf_m.gcaf041 TO gcaf041              #顯示到畫面上
            CALL s_desc_get_tax_desc1(g_gcaf_m.gcafunit,g_gcaf_m.gcaf041) RETURNING g_gcaf_m.gcaf041_desc
            DISPLAY BY NAME g_gcaf_m.gcaf041_desc           
            NEXT FIELD gcaf041                          #返回原欄位
            #160215-00002#2(E)
            #END add-point
 
 
         #Ctrlp:input.c.gcaf015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf015
            #add-point:ON ACTION controlp INFIELD gcaf015 name="input.c.gcaf015"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf043
            #add-point:ON ACTION controlp INFIELD gcaf043 name="input.c.gcaf043"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf037
            #add-point:ON ACTION controlp INFIELD gcaf037 name="input.c.gcaf037"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf038
            #add-point:ON ACTION controlp INFIELD gcaf038 name="input.c.gcaf038"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf039
            #add-point:ON ACTION controlp INFIELD gcaf039 name="input.c.gcaf039"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf016
            #add-point:ON ACTION controlp INFIELD gcaf016 name="input.c.gcaf016"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf017
            #add-point:ON ACTION controlp INFIELD gcaf017 name="input.c.gcaf017"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf042
            #add-point:ON ACTION controlp INFIELD gcaf042 name="input.c.gcaf042"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf018
            #add-point:ON ACTION controlp INFIELD gcaf018 name="input.c.gcaf018"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf019
            #add-point:ON ACTION controlp INFIELD gcaf019 name="input.c.gcaf019"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf020
            #add-point:ON ACTION controlp INFIELD gcaf020 name="input.c.gcaf020"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf021
            #add-point:ON ACTION controlp INFIELD gcaf021 name="input.c.gcaf021"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf022
            #add-point:ON ACTION controlp INFIELD gcaf022 name="input.c.gcaf022"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf023
            #add-point:ON ACTION controlp INFIELD gcaf023 name="input.c.gcaf023"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf034
            #add-point:ON ACTION controlp INFIELD gcaf034 name="input.c.gcaf034"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf035
            #add-point:ON ACTION controlp INFIELD gcaf035 name="input.c.gcaf035"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf036
            #add-point:ON ACTION controlp INFIELD gcaf036 name="input.c.gcaf036"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf024
            #add-point:ON ACTION controlp INFIELD gcaf024 name="input.c.gcaf024"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf025
            #add-point:ON ACTION controlp INFIELD gcaf025 name="input.c.gcaf025"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf031
            #add-point:ON ACTION controlp INFIELD gcaf031 name="input.c.gcaf031"
                                                                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
#            LET g_qryparam.where = "ooiastus = 'Y' AND ooia002 = '40'"    #mark by yangxf
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcaf_m.gcaf031             #給予default值
#            CALL q_ooia001()              #呼叫開窗                 #mark by yangxf
            #add by yangxf ---
            CALL s_money_where(g_gcaf_m.gcafunit) RETURNING l_str
            LET g_qryparam.where = l_str," AND ooia002 = '40' "                  
            CALL q_ooia001_03()   
            #add by yangxf ---
            LET g_gcaf_m.gcaf031 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_gcaf_m.gcaf031 TO gcaf031                    #顯示到畫面上 
            CALL agcm300_gcaf031_ref() 
            NEXT FIELD gcaf031                                     #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.gcaf026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf026
            #add-point:ON ACTION controlp INFIELD gcaf026 name="input.c.gcaf026"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf032
            #add-point:ON ACTION controlp INFIELD gcaf032 name="input.c.gcaf032"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf033
            #add-point:ON ACTION controlp INFIELD gcaf033 name="input.c.gcaf033"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf044
            #add-point:ON ACTION controlp INFIELD gcaf044 name="input.c.gcaf044"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf045
            #add-point:ON ACTION controlp INFIELD gcaf045 name="input.c.gcaf045"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf027
            #add-point:ON ACTION controlp INFIELD gcaf027 name="input.c.gcaf027"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf028
            #add-point:ON ACTION controlp INFIELD gcaf028 name="input.c.gcaf028"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf029
            #add-point:ON ACTION controlp INFIELD gcaf029 name="input.c.gcaf029"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.gcaf030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaf030
            #add-point:ON ACTION controlp INFIELD gcaf030 name="input.c.gcaf030"
                                                            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_gcaf_m.gcaf001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #add by geza 20160225(S)
               #券种自动编号
               CALL s_aooi390_get_auto_no('33',g_gcaf_m.gcaf001) RETURNING l_success,g_gcaf_m.gcaf001
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF  
               CALL s_aooi390_oofi_upd('33',g_gcaf_m.gcaf001) RETURNING l_success   
               #add by geza 20160225(E)                                                            
               #end add-point
               
               INSERT INTO gcaf_t (gcafent,gcaf001,gcaf002,gcaf003,gcaf004,gcafunit,gcafstus,gcaf005, 
                   gcaf006,gcaf007,gcaf008,gcaf009,gcaf010,gcaf011,gcaf012,gcaf013,gcaf041,gcaf015,gcaf043, 
                   gcaf037,gcaf038,gcaf039,gcaf016,gcaf017,gcaf042,gcaf018,gcaf019,gcaf020,gcaf021,gcaf022, 
                   gcaf023,gcaf034,gcaf035,gcaf036,gcaf024,gcaf025,gcaf031,gcaf040,gcaf026,gcaf032,gcaf033, 
                   gcaf044,gcaf045,gcafownid,gcafowndp,gcafcrtid,gcafcrtdp,gcafcrtdt,gcafmodid,gcafmoddt, 
                   gcafcnfid,gcafcnfdt,gcaf027,gcaf028,gcaf029,gcaf030)
               VALUES (g_enterprise,g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcaf003,g_gcaf_m.gcaf004, 
                   g_gcaf_m.gcafunit,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005,g_gcaf_m.gcaf006,g_gcaf_m.gcaf007, 
                   g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011,g_gcaf_m.gcaf012, 
                   g_gcaf_m.gcaf013,g_gcaf_m.gcaf041,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037, 
                   g_gcaf_m.gcaf038,g_gcaf_m.gcaf039,g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042, 
                   g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020,g_gcaf_m.gcaf021,g_gcaf_m.gcaf022, 
                   g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035,g_gcaf_m.gcaf036,g_gcaf_m.gcaf024, 
                   g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf040,g_gcaf_m.gcaf026,g_gcaf_m.gcaf032, 
                   g_gcaf_m.gcaf033,g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcafownid,g_gcaf_m.gcafowndp, 
                   g_gcaf_m.gcafcrtid,g_gcaf_m.gcafcrtdp,g_gcaf_m.gcafcrtdt,g_gcaf_m.gcafmodid,g_gcaf_m.gcafmoddt, 
                   g_gcaf_m.gcafcnfid,g_gcaf_m.gcafcnfdt,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028,g_gcaf_m.gcaf029, 
                   g_gcaf_m.gcaf030) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_gcaf_m:",SQLERRMESSAGE 
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
         IF g_gcaf_m.gcaf001 = g_master_multi_table_t.gcafl001 AND
         g_gcaf_m.gcafl003 = g_master_multi_table_t.gcafl003 AND 
         g_gcaf_m.gcafl004 = g_master_multi_table_t.gcafl004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'gcaflent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_gcaf_m.gcaf001
            LET l_field_keys[02] = 'gcafl001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.gcafl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'gcafl002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_gcaf_m.gcafl003
            LET l_fields[01] = 'gcafl003'
            LET l_vars[02] = g_gcaf_m.gcafl004
            LET l_fields[02] = 'gcafl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gcafl_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
                                                                                             IF l_cmd_t = 'r' THEN
                     #复制子作业资料
                     #生效组织(mmap_t)
                     INSERT INTO mmap_t (mmapent,mmap001,mmap002,mmap003,mmap004,mmap005,mmap006,mmap007,mmapstus)
                     SELECT g_enterprise,'agcm300',g_gcaf_m.gcaf001,mmap003,mmap004,mmap005,mmap006,mmap007,mmapstus
                       FROM mmap_t
                      WHERE mmapent = g_enterprise AND mmap001 = 'agcm300' AND mmap002 = g_gcaf_m_t.gcaf001
                      
                     #发行面额(gcar_t)
                     INSERT INTO gcar_t (gcarent,gcar001,gcar002,gcar003,gcar004,gcar005,gcarstus)
                     SELECT g_enterprise,g_gcaf_m.gcaf001,gcar002,gcar003,gcar004,gcar005,gcarstus
                       FROM gcar_t
                      WHERE gcarent = g_enterprise AND gcar001 = g_gcaf_m_t.gcaf001
                      
                     #提货商品(gcas_t)
                     IF g_gcaf_m.gcaf003 = '3' THEN
                        INSERT INTO gcas_t (gcasent,gcas001,gcas002,gcas003,gcas004,gcas005,gcas006,gcas007,gcas008,gcasstus)
                        SELECT g_enterprise,g_gcaf_m.gcaf001,gcas002,gcas003,gcas004,gcas005,gcas006,gcas007,gcas008,gcasstus
                          FROM gcas_t
                         WHERE gcasent = g_enterprise AND gcas001 = g_gcaf_m_t.gcaf001
                     END IF
                  ELSE
                     #券单位金额
                     SELECT oocq009 INTO l_oocq009 
                       FROM oocq_t 
                      WHERE oocqent = g_enterprise AND oocq001 = '2071' AND oocq002 = g_gcaf_m.gcaf012
                     #写入券面额明细档
                     INSERT INTO gcar_t (gcarent,gcar001,gcar002,gcar003,gcar004,gcar005,gcarstus)
                     VALUES (g_enterprise,g_gcaf_m.gcaf001,g_gcaf_m.gcaf012,g_gcaf_m.gcaf013,'',l_oocq009,'Y')
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "g_gcaf_m"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CONTINUE DIALOG
                     END IF
                  END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL agcm300_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL agcm300_b_fill()
                  CALL agcm300_b_fill2('0')
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
               CALL agcm300_gcaf_t_mask_restore('restore_mask_o')
               
               UPDATE gcaf_t SET (gcaf001,gcaf002,gcaf003,gcaf004,gcafunit,gcafstus,gcaf005,gcaf006, 
                   gcaf007,gcaf008,gcaf009,gcaf010,gcaf011,gcaf012,gcaf013,gcaf041,gcaf015,gcaf043,gcaf037, 
                   gcaf038,gcaf039,gcaf016,gcaf017,gcaf042,gcaf018,gcaf019,gcaf020,gcaf021,gcaf022,gcaf023, 
                   gcaf034,gcaf035,gcaf036,gcaf024,gcaf025,gcaf031,gcaf040,gcaf026,gcaf032,gcaf033,gcaf044, 
                   gcaf045,gcafownid,gcafowndp,gcafcrtid,gcafcrtdp,gcafcrtdt,gcafmodid,gcafmoddt,gcafcnfid, 
                   gcafcnfdt,gcaf027,gcaf028,gcaf029,gcaf030) = (g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcaf003, 
                   g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005,g_gcaf_m.gcaf006, 
                   g_gcaf_m.gcaf007,g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011, 
                   g_gcaf_m.gcaf012,g_gcaf_m.gcaf013,g_gcaf_m.gcaf041,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043, 
                   g_gcaf_m.gcaf037,g_gcaf_m.gcaf038,g_gcaf_m.gcaf039,g_gcaf_m.gcaf016,g_gcaf_m.gcaf017, 
                   g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020,g_gcaf_m.gcaf021, 
                   g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035,g_gcaf_m.gcaf036, 
                   g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf040,g_gcaf_m.gcaf026, 
                   g_gcaf_m.gcaf032,g_gcaf_m.gcaf033,g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcafownid, 
                   g_gcaf_m.gcafowndp,g_gcaf_m.gcafcrtid,g_gcaf_m.gcafcrtdp,g_gcaf_m.gcafcrtdt,g_gcaf_m.gcafmodid, 
                   g_gcaf_m.gcafmoddt,g_gcaf_m.gcafcnfid,g_gcaf_m.gcafcnfdt,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028, 
                   g_gcaf_m.gcaf029,g_gcaf_m.gcaf030)
                WHERE gcafent = g_enterprise AND gcaf001 = g_gcaf001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gcaf_t:",SQLERRMESSAGE 
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
         IF g_gcaf_m.gcaf001 = g_master_multi_table_t.gcafl001 AND
         g_gcaf_m.gcafl003 = g_master_multi_table_t.gcafl003 AND 
         g_gcaf_m.gcafl004 = g_master_multi_table_t.gcafl004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'gcaflent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_gcaf_m.gcaf001
            LET l_field_keys[02] = 'gcafl001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.gcafl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'gcafl002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_gcaf_m.gcafl003
            LET l_fields[01] = 'gcafl003'
            LET l_vars[02] = g_gcaf_m.gcafl004
            LET l_fields[02] = 'gcafl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gcafl_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL agcm300_gcaf_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_gcaf_m_t)
               LET g_log2 = util.JSON.stringify(g_gcaf_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                                                                                          IF NOT agcm300_gcaf003_chk('d') THEN
                  CALL s_transaction_end('N','0')
               END IF
               IF g_gcaf_m.gcaf012 <> g_gcaf_m_t.gcaf012 THEN
                  DELETE FROM gcar_t WHERE gcarent = g_enterprise AND gcar001 = g_gcaf_m.gcaf001 AND gcar002 = g_gcaf_m_t.gcaf012
                  DELETE FROM gcar_t WHERE gcarent = g_enterprise AND gcar001 = g_gcaf_m.gcaf001 AND gcar002 = g_gcaf_m.gcaf012
                  #券单位金额
                  SELECT oocq009 INTO l_oocq009 
                    FROM oocq_t 
                   WHERE oocqent = g_enterprise AND oocq001 = '2071' AND oocq002 = g_gcaf_m.gcaf012
                  #写入券面额明细档
                  INSERT INTO gcar_t (gcarent,gcar001,gcar002,gcar003,gcar004,gcar005,gcarstus)
                  VALUES (g_enterprise,g_gcaf_m.gcaf001,g_gcaf_m.gcaf012,g_gcaf_m.gcaf013,'',l_oocq009,'Y')
               END IF
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_gcaf001_t = g_gcaf_m.gcaf001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="agcm300.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_gcag_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gcag_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agcm300_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_gcag_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            #mark by geza 20150615(S)
#            IF cl_null(g_gcaf_m.gcaf003) OR g_gcaf_m.gcaf003 <> '4' THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'agc-00050'
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = FALSE
#               CALL cl_err()
# #非折价券不可设定折价券限定信息
#               NEXT FIELD gcai003
#            END IF
#            IF cl_null(g_gcaf_m.gcaf029) OR g_gcaf_m.gcaf029 = '0' THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'agc-00051'
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = FALSE
#               CALL cl_err()
# #
#               NEXT FIELD gcah002
#            END IF
            #mark by geza 20150615(E)
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
            OPEN agcm300_cl USING g_enterprise,g_gcaf_m.gcaf001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agcm300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agcm300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_gcag_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gcag_d[l_ac].gcag002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gcag_d_t.* = g_gcag_d[l_ac].*  #BACKUP
               LET g_gcag_d_o.* = g_gcag_d[l_ac].*  #BACKUP
               CALL agcm300_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
                                                                           
               #end add-point  
               CALL agcm300_set_no_entry_b(l_cmd)
               IF NOT agcm300_lock_b("gcag_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agcm300_bcl INTO g_gcag_d[l_ac].gcag002,g_gcag_d[l_ac].gcag003,g_gcag_d[l_ac].gcag004, 
                      g_gcag_d[l_ac].gcag005,g_gcag_d[l_ac].gcag006,g_gcag_d[l_ac].gcagstus
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gcag_d_t.gcag002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gcag_d_mask_o[l_ac].* =  g_gcag_d[l_ac].*
                  CALL agcm300_gcag_t_mask()
                  LET g_gcag_d_mask_n[l_ac].* =  g_gcag_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL agcm300_show()
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
            INITIALIZE g_gcag_d[l_ac].* TO NULL 
            INITIALIZE g_gcag_d_t.* TO NULL 
            INITIALIZE g_gcag_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gcag_d[l_ac].gcagstus = 'N'
 
 
 
            #自定義預設值
                  LET g_gcag_d[l_ac].gcagstus = "Y"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_gcag_d_t.* = g_gcag_d[l_ac].*     #新輸入資料
            LET g_gcag_d_o.* = g_gcag_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agcm300_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
                                                            
            #end add-point
            CALL agcm300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gcag_d[li_reproduce_target].* = g_gcag_d[li_reproduce].*
 
               LET g_gcag_d[li_reproduce_target].gcag002 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
                                                                        CALL agcm300_gcag002_init()
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
            SELECT COUNT(1) INTO l_count FROM gcag_t 
             WHERE gcagent = g_enterprise AND gcag001 = g_gcaf_m.gcaf001
 
               AND gcag002 = g_gcag_d[l_ac].gcag002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
                                                                           
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcaf_m.gcaf001
               LET gs_keys[2] = g_gcag_d[g_detail_idx].gcag002
               CALL agcm300_insert_b('gcag_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
                                                                           
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_gcag_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gcag_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agcm300_b_fill()
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
               LET gs_keys[01] = g_gcaf_m.gcaf001
 
               LET gs_keys[gs_keys.getLength()+1] = g_gcag_d_t.gcag002
 
            
               #刪除同層單身
               IF NOT agcm300_delete_b('gcag_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agcm300_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT agcm300_key_delete_b(gs_keys,'gcag_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agcm300_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
                                                                           
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE agcm300_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                                                                                          
               #end add-point
               LET l_count = g_gcag_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                                                            
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gcag_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcag002
            #add-point:BEFORE FIELD gcag002 name="input.b.page1.gcag002"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcag002
            
            #add-point:AFTER FIELD gcag002 name="input.a.page1.gcag002"
                                                                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_gcaf_m.gcaf001) AND NOT cl_null(g_gcag_d[g_detail_idx].gcag002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcaf_m.gcaf001 != g_gcaf001_t OR g_gcag_d[g_detail_idx].gcag002 != g_gcag_d_t.gcag002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM gcag_t WHERE "||"gcagent = '" ||g_enterprise|| "' AND "||"gcag001 = '"||g_gcaf_m.gcaf001 ||"' AND "|| "gcag002 = '"||g_gcag_d[g_detail_idx].gcag002 ||"'",'std-00004',0) THEN  #160905-00007#2 count(*) --> count(1) 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcag002
            #add-point:ON CHANGE gcag002 name="input.g.page1.gcag002"
                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcag003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gcag_d[l_ac].gcag003,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD gcag003
            END IF 
 
 
 
            #add-point:AFTER FIELD gcag003 name="input.a.page1.gcag003"
                                                                        IF NOT cl_null(g_gcag_d[l_ac].gcag003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcag_d[l_ac].gcag003 != g_gcag_d_t.gcag003)) THEN
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt   #160905-00007#2 count(*) --> count(1)
                    FROM gcag_t
                   WHERE gcagent = g_enterprise AND gcag001 = g_gcaf_m.gcaf001 AND gcag003 = g_gcag_d[l_ac].gcag003
                  IF l_cnt > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agc-00047'
                     LET g_errparam.extend = g_gcag_d[l_ac].gcag003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 #同一券种下消费数量满/额满不可重复
                     LET g_gcag_d[l_ac].gcag003 = g_gcag_d_t.gcag003
                     DISPLAY BY NAME g_gcag_d[l_ac].gcag003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcag003
            #add-point:BEFORE FIELD gcag003 name="input.b.page1.gcag003"
                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcag003
            #add-point:ON CHANGE gcag003 name="input.g.page1.gcag003"
                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcag004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gcag_d[l_ac].gcag004,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD gcag004
            END IF 
 
 
 
            #add-point:AFTER FIELD gcag004 name="input.a.page1.gcag004"
                                                                        IF NOT cl_null(g_gcag_d[l_ac].gcag004) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcag004
            #add-point:BEFORE FIELD gcag004 name="input.b.page1.gcag004"
                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcag004
            #add-point:ON CHANGE gcag004 name="input.g.page1.gcag004"
                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcag005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gcag_d[l_ac].gcag005,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD gcag005
            END IF 
 
 
 
            #add-point:AFTER FIELD gcag005 name="input.a.page1.gcag005"
                                                                        IF NOT cl_null(g_gcag_d[l_ac].gcag005) THEN 
               CALL agcm300_gcag005_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcag_d[l_ac].gcag005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcag_d[l_ac].gcag005 = g_gcag_d_t.gcag005
                  DISPLAY BY NAME g_gcag_d[l_ac].gcag005
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcag005
            #add-point:BEFORE FIELD gcag005 name="input.b.page1.gcag005"
                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcag005
            #add-point:ON CHANGE gcag005 name="input.g.page1.gcag005"
                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcag006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gcag_d[l_ac].gcag006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD gcag006
            END IF 
 
 
 
            #add-point:AFTER FIELD gcag006 name="input.a.page1.gcag006"
                                                                        IF NOT cl_null(g_gcag_d[l_ac].gcag006) THEN 
               CALL agcm300_gcag005_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcag_d[l_ac].gcag006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcag_d[l_ac].gcag006 = g_gcag_d_t.gcag006
                  DISPLAY BY NAME g_gcag_d[l_ac].gcag006
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcag006
            #add-point:BEFORE FIELD gcag006 name="input.b.page1.gcag006"
                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcag006
            #add-point:ON CHANGE gcag006 name="input.g.page1.gcag006"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcagstus
            #add-point:BEFORE FIELD gcagstus name="input.b.page1.gcagstus"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcagstus
            
            #add-point:AFTER FIELD gcagstus name="input.a.page1.gcagstus"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcagstus
            #add-point:ON CHANGE gcagstus name="input.g.page1.gcagstus"
                                                            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gcag002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcag002
            #add-point:ON ACTION controlp INFIELD gcag002 name="input.c.page1.gcag002"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcag003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcag003
            #add-point:ON ACTION controlp INFIELD gcag003 name="input.c.page1.gcag003"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcag004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcag004
            #add-point:ON ACTION controlp INFIELD gcag004 name="input.c.page1.gcag004"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcag005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcag005
            #add-point:ON ACTION controlp INFIELD gcag005 name="input.c.page1.gcag005"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcag006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcag006
            #add-point:ON ACTION controlp INFIELD gcag006 name="input.c.page1.gcag006"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcagstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcagstus
            #add-point:ON ACTION controlp INFIELD gcagstus name="input.c.page1.gcagstus"
                                                            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gcag_d[l_ac].* = g_gcag_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agcm300_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gcag_d[l_ac].gcag002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_gcag_d[l_ac].* = g_gcag_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
                                                                           
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
      
               #將遮罩欄位還原
               CALL agcm300_gcag_t_mask_restore('restore_mask_o')
      
               UPDATE gcag_t SET (gcag001,gcag002,gcag003,gcag004,gcag005,gcag006,gcagstus) = (g_gcaf_m.gcaf001, 
                   g_gcag_d[l_ac].gcag002,g_gcag_d[l_ac].gcag003,g_gcag_d[l_ac].gcag004,g_gcag_d[l_ac].gcag005, 
                   g_gcag_d[l_ac].gcag006,g_gcag_d[l_ac].gcagstus)
                WHERE gcagent = g_enterprise AND gcag001 = g_gcaf_m.gcaf001 
 
                  AND gcag002 = g_gcag_d_t.gcag002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                                                                           
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_gcag_d[l_ac].* = g_gcag_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcag_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gcag_d[l_ac].* = g_gcag_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcag_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcaf_m.gcaf001
               LET gs_keys_bak[1] = g_gcaf001_t
               LET gs_keys[2] = g_gcag_d[g_detail_idx].gcag002
               LET gs_keys_bak[2] = g_gcag_d_t.gcag002
               CALL agcm300_update_b('gcag_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL agcm300_gcag_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_gcag_d[g_detail_idx].gcag002 = g_gcag_d_t.gcag002 
 
                  ) THEN
                  LET gs_keys[01] = g_gcaf_m.gcaf001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gcag_d_t.gcag002
 
                  CALL agcm300_key_update_b(gs_keys,'gcag_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gcaf_m),util.JSON.stringify(g_gcag_d_t)
               LET g_log2 = util.JSON.stringify(g_gcaf_m),util.JSON.stringify(g_gcag_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
                                                                           
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
                                                            
            #end add-point
            CALL agcm300_unlock_b("gcag_t","'1'")
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
               LET g_gcag_d[li_reproduce_target].* = g_gcag_d[li_reproduce].*
 
               LET g_gcag_d[li_reproduce_target].gcag002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gcag_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gcag_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_gcag2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gcag2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agcm300_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_gcag2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            #mark by geza 20150615(S)
#            IF cl_null(g_gcaf_m.gcaf003) OR g_gcaf_m.gcaf003 <> '4' THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'agc-00050'
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = FALSE
#               CALL cl_err()
# #非折价券不可设定折价券限定信息
#               NEXT FIELD gcai003
#            END IF
            #mark by geza 20150615(E)
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gcag2_d[l_ac].* TO NULL 
            INITIALIZE g_gcag2_d_t.* TO NULL 
            INITIALIZE g_gcag2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gcag2_d[l_ac].gcahstus = 'N'
 
 
 
            #自定義預設值(單身2)
                  LET g_gcag2_d[l_ac].gcah002 = "4"
      LET g_gcag2_d[l_ac].gcahstus = "Y"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_gcag2_d_t.* = g_gcag2_d[l_ac].*     #新輸入資料
            LET g_gcag2_d_o.* = g_gcag2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agcm300_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
                                                            
            #end add-point
            CALL agcm300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gcag2_d[li_reproduce_target].* = g_gcag2_d[li_reproduce].*
 
               LET g_gcag2_d[li_reproduce_target].gcah002 = NULL
               LET g_gcag2_d[li_reproduce_target].gcah003 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
                                                            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
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
            OPEN agcm300_cl USING g_enterprise,g_gcaf_m.gcaf001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agcm300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agcm300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_gcag2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gcag2_d[l_ac].gcah002 IS NOT NULL
               AND g_gcag2_d[l_ac].gcah003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_gcag2_d_t.* = g_gcag2_d[l_ac].*  #BACKUP
               LET g_gcag2_d_o.* = g_gcag2_d[l_ac].*  #BACKUP
               CALL agcm300_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
                                                                           
               #end add-point  
               CALL agcm300_set_no_entry_b(l_cmd)
               IF NOT agcm300_lock_b("gcah_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agcm300_bcl2 INTO g_gcag2_d[l_ac].gcah002,g_gcag2_d[l_ac].gcah003,g_gcag2_d[l_ac].gcahstus 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gcag2_d_mask_o[l_ac].* =  g_gcag2_d[l_ac].*
                  CALL agcm300_gcah_t_mask()
                  LET g_gcag2_d_mask_n[l_ac].* =  g_gcag2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL agcm300_show()
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
               LET gs_keys[01] = g_gcaf_m.gcaf001
               LET gs_keys[gs_keys.getLength()+1] = g_gcag2_d_t.gcah002
               LET gs_keys[gs_keys.getLength()+1] = g_gcag2_d_t.gcah003
            
               #刪除同層單身
               IF NOT agcm300_delete_b('gcah_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agcm300_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT agcm300_key_delete_b(gs_keys,'gcah_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agcm300_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
                                                                           
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE agcm300_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
                                                                                          
               #end add-point
               LET l_count = g_gcag_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
                                                            
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gcag2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM gcah_t 
             WHERE gcahent = g_enterprise AND gcah001 = g_gcaf_m.gcaf001
               AND gcah002 = g_gcag2_d[l_ac].gcah002
               AND gcah003 = g_gcag2_d[l_ac].gcah003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
                                                                           
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcaf_m.gcaf001
               LET gs_keys[2] = g_gcag2_d[g_detail_idx].gcah002
               LET gs_keys[3] = g_gcag2_d[g_detail_idx].gcah003
               CALL agcm300_insert_b('gcah_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
                                                                           
               #end add-point
            ELSE    
               INITIALIZE g_gcag_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gcah_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agcm300_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
                                                                           
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gcag2_d[l_ac].* = g_gcag2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agcm300_bcl2
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
               LET g_gcag2_d[l_ac].* = g_gcag2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
                                                                           
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               #將遮罩欄位還原
               CALL agcm300_gcah_t_mask_restore('restore_mask_o')
                              
               UPDATE gcah_t SET (gcah001,gcah002,gcah003,gcahstus) = (g_gcaf_m.gcaf001,g_gcag2_d[l_ac].gcah002, 
                   g_gcag2_d[l_ac].gcah003,g_gcag2_d[l_ac].gcahstus) #自訂欄位頁簽
                WHERE gcahent = g_enterprise AND gcah001 = g_gcaf_m.gcaf001
                  AND gcah002 = g_gcag2_d_t.gcah002 #項次 
                  AND gcah003 = g_gcag2_d_t.gcah003
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
                                                                           
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_gcag2_d[l_ac].* = g_gcag2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcah_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gcag2_d[l_ac].* = g_gcag2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcah_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcaf_m.gcaf001
               LET gs_keys_bak[1] = g_gcaf001_t
               LET gs_keys[2] = g_gcag2_d[g_detail_idx].gcah002
               LET gs_keys_bak[2] = g_gcag2_d_t.gcah002
               LET gs_keys[3] = g_gcag2_d[g_detail_idx].gcah003
               LET gs_keys_bak[3] = g_gcag2_d_t.gcah003
               CALL agcm300_update_b('gcah_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL agcm300_gcah_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_gcag2_d[g_detail_idx].gcah002 = g_gcag2_d_t.gcah002 
                  AND g_gcag2_d[g_detail_idx].gcah003 = g_gcag2_d_t.gcah003 
                  ) THEN
                  LET gs_keys[01] = g_gcaf_m.gcaf001
                  LET gs_keys[gs_keys.getLength()+1] = g_gcag2_d_t.gcah002
                  LET gs_keys[gs_keys.getLength()+1] = g_gcag2_d_t.gcah003
                  CALL agcm300_key_update_b(gs_keys,'gcah_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gcaf_m),util.JSON.stringify(g_gcag2_d_t)
               LET g_log2 = util.JSON.stringify(g_gcaf_m),util.JSON.stringify(g_gcag2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
                                                                           
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcah002
            #add-point:BEFORE FIELD gcah002 name="input.b.page2.gcah002"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcah002
            
            #add-point:AFTER FIELD gcah002 name="input.a.page2.gcah002"
                                                                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_gcaf_m.gcaf001) AND NOT cl_null(g_gcag2_d[g_detail_idx].gcah002) AND NOT cl_null(g_gcag2_d[g_detail_idx].gcah003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcaf_m.gcaf001 != g_gcaf001_t OR g_gcag2_d[g_detail_idx].gcah002 != g_gcag2_d_t.gcah002 OR g_gcag2_d[g_detail_idx].gcah003 != g_gcag2_d_t.gcah003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM gcah_t WHERE "||"gcahent = '" ||g_enterprise|| "' AND "||"gcah001 = '"||g_gcaf_m.gcaf001 ||"' AND "|| "gcah002 = '"||g_gcag2_d[g_detail_idx].gcah002 ||"' AND "|| "gcah003 = '"||g_gcag2_d[g_detail_idx].gcah003 ||"'",'std-00004',0) THEN  #160905-00007#2 count(*) --> count(1) 
                     LET g_gcag2_d[l_ac].gcah002 = g_gcag2_d_t.gcah002
                     DISPLAY BY NAME g_gcag2_d[l_ac].gcah002
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT agcm300_gcah003_chk() THEN
                     LET g_gcag2_d[l_ac].gcah002 = g_gcag2_d_t.gcah002
                     DISPLAY BY NAME g_gcag2_d[l_ac].gcah002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcah002
            #add-point:ON CHANGE gcah002 name="input.g.page2.gcah002"
                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcah003
            
            #add-point:AFTER FIELD gcah003 name="input.a.page2.gcah003"
                                                                        LET g_gcag2_d[l_ac].gcah003_desc = ''
            DISPLAY BY NAME g_gcag2_d[l_ac].gcah003
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gcaf_m.gcaf001) AND NOT cl_null(g_gcag2_d[g_detail_idx].gcah002) AND NOT cl_null(g_gcag2_d[g_detail_idx].gcah003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcaf_m.gcaf001 != g_gcaf001_t OR g_gcag2_d[g_detail_idx].gcah002 != g_gcag2_d_t.gcah002 OR g_gcag2_d[g_detail_idx].gcah003 != g_gcag2_d_t.gcah003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM gcah_t WHERE "||"gcahent = '" ||g_enterprise|| "' AND "||"gcah001 = '"||g_gcaf_m.gcaf001 ||"' AND "|| "gcah002 = '"||g_gcag2_d[g_detail_idx].gcah002 ||"' AND "|| "gcah003 = '"||g_gcag2_d[g_detail_idx].gcah003 ||"'",'std-00004',0) THEN  #160905-00007#2 count(*) --> count(1) 
                     LET g_gcag2_d[l_ac].gcah003 = g_gcag2_d_t.gcah003
                     DISPLAY BY NAME g_gcag2_d[l_ac].gcah003
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT agcm300_gcah003_chk() THEN
                     LET g_gcag2_d[l_ac].gcah003 = g_gcag2_d_t.gcah003
                     DISPLAY BY NAME g_gcag2_d[l_ac].gcah003
                     CALL agcm300_gcah003_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL agcm300_gcah003_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcah003
            #add-point:BEFORE FIELD gcah003 name="input.b.page2.gcah003"
                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcah003
            #add-point:ON CHANGE gcah003 name="input.g.page2.gcah003"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcah003_desc
            #add-point:BEFORE FIELD gcah003_desc name="input.b.page2.gcah003_desc"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcah003_desc
            
            #add-point:AFTER FIELD gcah003_desc name="input.a.page2.gcah003_desc"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcah003_desc
            #add-point:ON CHANGE gcah003_desc name="input.g.page2.gcah003_desc"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcahstus
            #add-point:BEFORE FIELD gcahstus name="input.b.page2.gcahstus"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcahstus
            
            #add-point:AFTER FIELD gcahstus name="input.a.page2.gcahstus"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcahstus
            #add-point:ON CHANGE gcahstus name="input.g.page2.gcahstus"
                                                            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.gcah002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcah002
            #add-point:ON ACTION controlp INFIELD gcah002 name="input.c.page2.gcah002"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gcah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcah003
            #add-point:ON ACTION controlp INFIELD gcah003 name="input.c.page2.gcah003"
                                                            			IF NOT cl_null(g_gcag2_d[l_ac].gcah002) THEN
			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_gcag2_d[l_ac].gcah003   #給予default值
               CALL agcm300_gcah003_ctp()                          #呼叫開窗
               LET g_gcag2_d[l_ac].gcah003 = g_qryparam.return1    #將開窗取得的值回傳到變數
               DISPLAY BY NAME g_gcag2_d[l_ac].gcah003             #顯示到畫面上
               CALL agcm300_gcah003_ref()                          #說明
               NEXT FIELD gcah003                                  #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.gcah003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcah003_desc
            #add-point:ON ACTION controlp INFIELD gcah003_desc name="input.c.page2.gcah003_desc"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gcahstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcahstus
            #add-point:ON ACTION controlp INFIELD gcahstus name="input.c.page2.gcahstus"
                                                            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
                                                            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gcag2_d[l_ac].* = g_gcag2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agcm300_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL agcm300_unlock_b("gcah_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
                                                            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gcag2_d[li_reproduce_target].* = g_gcag2_d[li_reproduce].*
 
               LET g_gcag2_d[li_reproduce_target].gcah002 = NULL
               LET g_gcag2_d[li_reproduce_target].gcah003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_gcag2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gcag2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_gcag3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gcag3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agcm300_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_gcag3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
                                                            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gcag3_d[l_ac].* TO NULL 
            INITIALIZE g_gcag3_d_t.* TO NULL 
            INITIALIZE g_gcag3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gcag3_d[l_ac].gcaistus = 'N'
 
 
 
            #自定義預設值(單身3)
                  LET g_gcag3_d[l_ac].gcaistus = "Y"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            ###################add by huangtao 150204-00001#38 begin
            LET g_gcag3_d[l_ac].gcai005 = "00:00:00"
            LET g_gcag3_d[l_ac].gcai006 = "23:59:59"
            ####################end 
            #end add-point
            LET g_gcag3_d_t.* = g_gcag3_d[l_ac].*     #新輸入資料
            LET g_gcag3_d_o.* = g_gcag3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agcm300_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
                                                            
            #end add-point
            CALL agcm300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gcag3_d[li_reproduce_target].* = g_gcag3_d[li_reproduce].*
 
               LET g_gcag3_d[li_reproduce_target].gcai002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
                                                                        CALL agcm300_gcai002_init()
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN agcm300_cl USING g_enterprise,g_gcaf_m.gcaf001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agcm300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agcm300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_gcag3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gcag3_d[l_ac].gcai002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_gcag3_d_t.* = g_gcag3_d[l_ac].*  #BACKUP
               LET g_gcag3_d_o.* = g_gcag3_d[l_ac].*  #BACKUP
               CALL agcm300_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
                                                                           
               #end add-point  
               CALL agcm300_set_no_entry_b(l_cmd)
               IF NOT agcm300_lock_b("gcai_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agcm300_bcl3 INTO g_gcag3_d[l_ac].gcai002,g_gcag3_d[l_ac].gcai003,g_gcag3_d[l_ac].gcai004, 
                      g_gcag3_d[l_ac].gcai005,g_gcag3_d[l_ac].gcai006,g_gcag3_d[l_ac].gcai007,g_gcag3_d[l_ac].gcai008, 
                      g_gcag3_d[l_ac].gcaistus
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gcag3_d_mask_o[l_ac].* =  g_gcag3_d[l_ac].*
                  CALL agcm300_gcai_t_mask()
                  LET g_gcag3_d_mask_n[l_ac].* =  g_gcag3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL agcm300_show()
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
               LET gs_keys[01] = g_gcaf_m.gcaf001
               LET gs_keys[gs_keys.getLength()+1] = g_gcag3_d_t.gcai002
            
               #刪除同層單身
               IF NOT agcm300_delete_b('gcai_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agcm300_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT agcm300_key_delete_b(gs_keys,'gcai_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agcm300_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
                                                                           
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE agcm300_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
                                                                                          
               #end add-point
               LET l_count = g_gcag_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
                                                            
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gcag3_d.getLength() + 1) THEN
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
                                                            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM gcai_t 
             WHERE gcaient = g_enterprise AND gcai001 = g_gcaf_m.gcaf001
               AND gcai002 = g_gcag3_d[l_ac].gcai002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
                                                                           
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcaf_m.gcaf001
               LET gs_keys[2] = g_gcag3_d[g_detail_idx].gcai002
               CALL agcm300_insert_b('gcai_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
                                                                           
               #end add-point
            ELSE    
               INITIALIZE g_gcag_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gcai_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agcm300_b_fill()
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
               LET g_gcag3_d[l_ac].* = g_gcag3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agcm300_bcl3
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
               LET g_gcag3_d[l_ac].* = g_gcag3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
                                                                           
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               #將遮罩欄位還原
               CALL agcm300_gcai_t_mask_restore('restore_mask_o')
                              
               UPDATE gcai_t SET (gcai001,gcai002,gcai003,gcai004,gcai005,gcai006,gcai007,gcai008,gcaistus) = (g_gcaf_m.gcaf001, 
                   g_gcag3_d[l_ac].gcai002,g_gcag3_d[l_ac].gcai003,g_gcag3_d[l_ac].gcai004,g_gcag3_d[l_ac].gcai005, 
                   g_gcag3_d[l_ac].gcai006,g_gcag3_d[l_ac].gcai007,g_gcag3_d[l_ac].gcai008,g_gcag3_d[l_ac].gcaistus)  
                   #自訂欄位頁簽
                WHERE gcaient = g_enterprise AND gcai001 = g_gcaf_m.gcaf001
                  AND gcai002 = g_gcag3_d_t.gcai002 #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
                                                                           
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_gcag3_d[l_ac].* = g_gcag3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcai_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gcag3_d[l_ac].* = g_gcag3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcai_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcaf_m.gcaf001
               LET gs_keys_bak[1] = g_gcaf001_t
               LET gs_keys[2] = g_gcag3_d[g_detail_idx].gcai002
               LET gs_keys_bak[2] = g_gcag3_d_t.gcai002
               CALL agcm300_update_b('gcai_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL agcm300_gcai_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_gcag3_d[g_detail_idx].gcai002 = g_gcag3_d_t.gcai002 
                  ) THEN
                  LET gs_keys[01] = g_gcaf_m.gcaf001
                  LET gs_keys[gs_keys.getLength()+1] = g_gcag3_d_t.gcai002
                  CALL agcm300_key_update_b(gs_keys,'gcai_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gcaf_m),util.JSON.stringify(g_gcag3_d_t)
               LET g_log2 = util.JSON.stringify(g_gcaf_m),util.JSON.stringify(g_gcag3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
                                                                           
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcai002
            #add-point:BEFORE FIELD gcai002 name="input.b.page3.gcai002"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcai002
            
            #add-point:AFTER FIELD gcai002 name="input.a.page3.gcai002"
                                                                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_gcaf_m.gcaf001) AND NOT cl_null(g_gcag3_d[g_detail_idx].gcai002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcaf_m.gcaf001 != g_gcaf001_t OR g_gcag3_d[g_detail_idx].gcai002 != g_gcag3_d_t.gcai002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM gcai_t WHERE "||"gcaient = '" ||g_enterprise|| "' AND "||"gcai001 = '"||g_gcaf_m.gcaf001 ||"' AND "|| "gcai002 = '"||g_gcag3_d[g_detail_idx].gcai002 ||"'",'std-00004',0) THEN  #160905-00007#2 count(*) --> count(1)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcai002
            #add-point:ON CHANGE gcai002 name="input.g.page3.gcai002"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcai003
            #add-point:BEFORE FIELD gcai003 name="input.b.page3.gcai003"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcai003
            
            #add-point:AFTER FIELD gcai003 name="input.a.page3.gcai003"
                                                                        IF NOT cl_null(g_gcag3_d[l_ac].gcai003) THEN
               CALL agcm300_gcai003_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcag3_d[l_ac].gcai003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcag3_d[l_ac].gcai003 = g_gcag3_d_t.gcai003
                  DISPLAY BY NAME g_gcag3_d[l_ac].gcai003
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcai003
            #add-point:ON CHANGE gcai003 name="input.g.page3.gcai003"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcai004
            #add-point:BEFORE FIELD gcai004 name="input.b.page3.gcai004"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcai004
            
            #add-point:AFTER FIELD gcai004 name="input.a.page3.gcai004"
                                                                        IF NOT cl_null(g_gcag3_d[l_ac].gcai004) THEN
               CALL agcm300_gcai003_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcag3_d[l_ac].gcai004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcag3_d[l_ac].gcai004 = g_gcag3_d_t.gcai004
                  DISPLAY BY NAME g_gcag3_d[l_ac].gcai004
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcai004
            #add-point:ON CHANGE gcai004 name="input.g.page3.gcai004"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcai005
            #add-point:BEFORE FIELD gcai005 name="input.b.page3.gcai005"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcai005
            
            #add-point:AFTER FIELD gcai005 name="input.a.page3.gcai005"
                                                                        IF NOT cl_null(g_gcag3_d[l_ac].gcai005) THEN
               CALL agcm300_gcai005_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcag3_d[l_ac].gcai005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcag3_d[l_ac].gcai005 = g_gcag3_d_t.gcai005
                  DISPLAY BY NAME g_gcag3_d[l_ac].gcai005
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcai005
            #add-point:ON CHANGE gcai005 name="input.g.page3.gcai005"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcai006
            #add-point:BEFORE FIELD gcai006 name="input.b.page3.gcai006"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcai006
            
            #add-point:AFTER FIELD gcai006 name="input.a.page3.gcai006"
                                                                        IF NOT cl_null(g_gcag3_d[l_ac].gcai006) THEN
               CALL agcm300_gcai005_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcag3_d[l_ac].gcai006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcag3_d[l_ac].gcai006 = g_gcag3_d_t.gcai006
                  DISPLAY BY NAME g_gcag3_d[l_ac].gcai006
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcai006
            #add-point:ON CHANGE gcai006 name="input.g.page3.gcai006"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcai007
            #add-point:BEFORE FIELD gcai007 name="input.b.page3.gcai007"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcai007
            
            #add-point:AFTER FIELD gcai007 name="input.a.page3.gcai007"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcai007
            #add-point:ON CHANGE gcai007 name="input.g.page3.gcai007"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcai008
            #add-point:BEFORE FIELD gcai008 name="input.b.page3.gcai008"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcai008
            
            #add-point:AFTER FIELD gcai008 name="input.a.page3.gcai008"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcai008
            #add-point:ON CHANGE gcai008 name="input.g.page3.gcai008"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaistus
            #add-point:BEFORE FIELD gcaistus name="input.b.page3.gcaistus"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaistus
            
            #add-point:AFTER FIELD gcaistus name="input.a.page3.gcaistus"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaistus
            #add-point:ON CHANGE gcaistus name="input.g.page3.gcaistus"
                                                            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.gcai002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcai002
            #add-point:ON ACTION controlp INFIELD gcai002 name="input.c.page3.gcai002"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gcai003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcai003
            #add-point:ON ACTION controlp INFIELD gcai003 name="input.c.page3.gcai003"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gcai004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcai004
            #add-point:ON ACTION controlp INFIELD gcai004 name="input.c.page3.gcai004"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gcai005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcai005
            #add-point:ON ACTION controlp INFIELD gcai005 name="input.c.page3.gcai005"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gcai006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcai006
            #add-point:ON ACTION controlp INFIELD gcai006 name="input.c.page3.gcai006"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gcai007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcai007
            #add-point:ON ACTION controlp INFIELD gcai007 name="input.c.page3.gcai007"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gcai008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcai008
            #add-point:ON ACTION controlp INFIELD gcai008 name="input.c.page3.gcai008"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gcaistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaistus
            #add-point:ON ACTION controlp INFIELD gcaistus name="input.c.page3.gcaistus"
                                                            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
                                                            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gcag3_d[l_ac].* = g_gcag3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agcm300_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL agcm300_unlock_b("gcai_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
                                                            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gcag3_d[li_reproduce_target].* = g_gcag3_d[li_reproduce].*
 
               LET g_gcag3_d[li_reproduce_target].gcai002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_gcag3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gcag3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_gcag4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gcag4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agcm300_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_gcag4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
                                                            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gcag4_d[l_ac].* TO NULL 
            INITIALIZE g_gcag4_d_t.* TO NULL 
            INITIALIZE g_gcag4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gcag4_d[l_ac].gcajstus = 'N'
 
 
 
            #自定義預設值(單身4)
                  LET g_gcag4_d[l_ac].gcaj003 = "N"
      LET g_gcag4_d[l_ac].gcajstus = "Y"
 
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_gcag4_d_t.* = g_gcag4_d[l_ac].*     #新輸入資料
            LET g_gcag4_d_o.* = g_gcag4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agcm300_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
                                                            
            #end add-point
            CALL agcm300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gcag4_d[li_reproduce_target].* = g_gcag4_d[li_reproduce].*
 
               LET g_gcag4_d[li_reproduce_target].gcaj002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
                                                            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body4.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[4] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 4
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN agcm300_cl USING g_enterprise,g_gcaf_m.gcaf001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agcm300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agcm300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_gcag4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gcag4_d[l_ac].gcaj002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_gcag4_d_t.* = g_gcag4_d[l_ac].*  #BACKUP
               LET g_gcag4_d_o.* = g_gcag4_d[l_ac].*  #BACKUP
               CALL agcm300_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
                                                                           
               #end add-point  
               CALL agcm300_set_no_entry_b(l_cmd)
               IF NOT agcm300_lock_b("gcaj_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agcm300_bcl4 INTO g_gcag4_d[l_ac].gcaj002,g_gcag4_d[l_ac].gcaj003,g_gcag4_d[l_ac].gcajstus 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gcag4_d_mask_o[l_ac].* =  g_gcag4_d[l_ac].*
                  CALL agcm300_gcaj_t_mask()
                  LET g_gcag4_d_mask_n[l_ac].* =  g_gcag4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL agcm300_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body4.before_row"
                                                            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body4.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body4.b_delete_ask"
               
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
               
               #add-point:單身4刪除前 name="input.body4.b_delete"
                                                                           
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_gcaf_m.gcaf001
               LET gs_keys[gs_keys.getLength()+1] = g_gcag4_d_t.gcaj002
            
               #刪除同層單身
               IF NOT agcm300_delete_b('gcaj_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agcm300_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT agcm300_key_delete_b(gs_keys,'gcaj_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agcm300_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
                                                                           
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE agcm300_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
                                                                                          
               #end add-point
               LET l_count = g_gcag_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
                                                            
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gcag4_d.getLength() + 1) THEN
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
               
            #add-point:單身4新增前 name="input.body4.b_a_insert"
                                                            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM gcaj_t 
             WHERE gcajent = g_enterprise AND gcaj001 = g_gcaf_m.gcaf001
               AND gcaj002 = g_gcag4_d[l_ac].gcaj002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
                                                                           
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcaf_m.gcaf001
               LET gs_keys[2] = g_gcag4_d[g_detail_idx].gcaj002
               CALL agcm300_insert_b('gcaj_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
                                                                           
               #end add-point
            ELSE    
               INITIALIZE g_gcag_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gcaj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agcm300_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
                                                                           
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gcag4_d[l_ac].* = g_gcag4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agcm300_bcl4
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
               LET g_gcag4_d[l_ac].* = g_gcag4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
                                                                           
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               #將遮罩欄位還原
               CALL agcm300_gcaj_t_mask_restore('restore_mask_o')
                              
               UPDATE gcaj_t SET (gcaj001,gcaj002,gcaj003,gcajstus) = (g_gcaf_m.gcaf001,g_gcag4_d[l_ac].gcaj002, 
                   g_gcag4_d[l_ac].gcaj003,g_gcag4_d[l_ac].gcajstus) #自訂欄位頁簽
                WHERE gcajent = g_enterprise AND gcaj001 = g_gcaf_m.gcaf001
                  AND gcaj002 = g_gcag4_d_t.gcaj002 #項次 
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
                                                                           
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_gcag4_d[l_ac].* = g_gcag4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcaj_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gcag4_d[l_ac].* = g_gcag4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcaj_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcaf_m.gcaf001
               LET gs_keys_bak[1] = g_gcaf001_t
               LET gs_keys[2] = g_gcag4_d[g_detail_idx].gcaj002
               LET gs_keys_bak[2] = g_gcag4_d_t.gcaj002
               CALL agcm300_update_b('gcaj_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL agcm300_gcaj_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_gcag4_d[g_detail_idx].gcaj002 = g_gcag4_d_t.gcaj002 
                  ) THEN
                  LET gs_keys[01] = g_gcaf_m.gcaf001
                  LET gs_keys[gs_keys.getLength()+1] = g_gcag4_d_t.gcaj002
                  CALL agcm300_key_update_b(gs_keys,'gcaj_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gcaf_m),util.JSON.stringify(g_gcag4_d_t)
               LET g_log2 = util.JSON.stringify(g_gcaf_m),util.JSON.stringify(g_gcag4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
                                                                           
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaj002
            
            #add-point:AFTER FIELD gcaj002 name="input.a.page4.gcaj002"
                                                                        LET g_gcag4_d[l_ac].gcaj002_desc = ''
            DISPLAY BY NAME g_gcag4_d[l_ac].gcaj002_desc
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gcaf_m.gcaf001) AND NOT cl_null(g_gcag4_d[g_detail_idx].gcaj002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcaf_m.gcaf001 != g_gcaf001_t OR g_gcag4_d[g_detail_idx].gcaj002 != g_gcag4_d_t.gcaj002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM gcaj_t WHERE "||"gcajent = '" ||g_enterprise|| "' AND "||"gcaj001 = '"||g_gcaf_m.gcaf001 ||"' AND "|| "gcaj002 = '"||g_gcag4_d[g_detail_idx].gcaj002 ||"'",'std-00004',0) THEN  #160905-00007#2 count(*) --> count(1)
                     LET g_gcag4_d[l_ac].gcaj002 = g_gcag4_d_t.gcaj002
                     DISPLAY BY NAME g_gcag4_d[l_ac].gcaj002
                     CALL agcm300_gcaj002_ref()
                     NEXT FIELD CURRENT
                  END IF
                  #161024-00025#1--dongsz mark--s
#                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_errshow = '1'
#                  LET g_chkparam.arg1 = g_gcag4_d[l_ac].gcaj002
#                  IF NOT cl_chk_exist("v_ooef001_20") THEN
#                     LET g_gcag4_d[l_ac].gcaj002 = g_gcag4_d_t.gcaj002
#                     DISPLAY BY NAME g_gcag4_d[l_ac].gcaj002
#                     CALL agcm300_gcaj002_ref()
#                     NEXT FIELD CURRENT
#                  END IF
                  #161024-00025#1--dongsz mark--e
                  #161024-00025#1--dongsz add--s
                  IF s_aooi500_setpoint(g_prog,'gcaj002') THEN
                     CALL s_aooi500_chk(g_prog,'gcaj002',g_gcag4_d[l_ac].gcaj002,g_gcaf_m.gcafunit)
                        RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_gcag4_d[l_ac].gcaj002 = g_gcag4_d_t.gcaj002
                        DISPLAY BY NAME g_gcag4_d[l_ac].gcaj002
                        CALL agcm300_gcaj002_ref()
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_errshow = '1'
                     LET g_chkparam.arg1 = g_gcag4_d[l_ac].gcaj002
                     IF NOT cl_chk_exist("v_ooef001_20") THEN
                        LET g_gcag4_d[l_ac].gcaj002 = g_gcag4_d_t.gcaj002
                        DISPLAY BY NAME g_gcag4_d[l_ac].gcaj002
                        CALL agcm300_gcaj002_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #161024-00025#1--dongsz add--e
               END IF
            END IF
            CALL agcm300_gcaj002_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaj002
            #add-point:BEFORE FIELD gcaj002 name="input.b.page4.gcaj002"
                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaj002
            #add-point:ON CHANGE gcaj002 name="input.g.page4.gcaj002"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaj003
            #add-point:BEFORE FIELD gcaj003 name="input.b.page4.gcaj003"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaj003
            
            #add-point:AFTER FIELD gcaj003 name="input.a.page4.gcaj003"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaj003
            #add-point:ON CHANGE gcaj003 name="input.g.page4.gcaj003"
                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcajstus
            #add-point:BEFORE FIELD gcajstus name="input.b.page4.gcajstus"
                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcajstus
            
            #add-point:AFTER FIELD gcajstus name="input.a.page4.gcajstus"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcajstus
            #add-point:ON CHANGE gcajstus name="input.g.page4.gcajstus"
                                                            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.gcaj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaj002
            #add-point:ON ACTION controlp INFIELD gcaj002 name="input.c.page4.gcaj002"
                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcag4_d[l_ac].gcaj002             #給予default值

            #161024-00025#1--dongsz add--s
			   #判断aooi500是否有设定
            IF s_aooi500_setpoint(g_prog,'gcaj002') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcaj002',g_gcaf_m.gcafunit,'i') 
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001()
            END IF
            #161024-00025#1--dongsz add--e
            #161024-00025#1--dongsz mark--s
#			   LET g_qryparam.where = " ooef201 = 'Y' "
#            CALL q_ooef001()                                #呼叫開窗
            #161024-00025#1--dongsz mark--e

            LET g_gcag4_d[l_ac].gcaj002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcag4_d[l_ac].gcaj002 TO gcaj002              #顯示到畫面上
            
            CALL agcm300_gcaj002_ref()

            NEXT FIELD gcaj002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.gcaj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaj003
            #add-point:ON ACTION controlp INFIELD gcaj003 name="input.c.page4.gcaj003"
                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page4.gcajstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcajstus
            #add-point:ON ACTION controlp INFIELD gcajstus name="input.c.page4.gcajstus"
                                                            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
                                                            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gcag4_d[l_ac].* = g_gcag4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agcm300_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL agcm300_unlock_b("gcaj_t","'4'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page4 after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
                                                            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gcag4_d[li_reproduce_target].* = g_gcag4_d[li_reproduce].*
 
               LET g_gcag4_d[li_reproduce_target].gcaj002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_gcag4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gcag4_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="agcm300.input.other" >}
      
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
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'4',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD gcaf001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gcag002
               WHEN "s_detail2"
                  NEXT FIELD gcah002
               WHEN "s_detail3"
                  NEXT FIELD gcai002
               WHEN "s_detail4"
                  NEXT FIELD gcaj002
 
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
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
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
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
               
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION agcm300_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
               
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
               
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL agcm300_b_fill() #單身填充
      CALL agcm300_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL agcm300_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
                  INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcaf_m.gcaf001
   CALL ap_ref_array2(g_ref_fields," SELECT gcafl003,gcafl004 FROM gcafl_t WHERE gcaflent = '"||g_enterprise||"' AND gcafl001 = ? AND gcafl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_gcaf_m.gcafl003 = g_rtn_fields[1] 
   LET g_gcaf_m.gcafl004 = g_rtn_fields[2] 
   DISPLAY g_gcaf_m.gcafl003 TO gcafl003
   DISPLAY g_gcaf_m.gcafl004 TO gcafl004
   #160215-00002#2(S)
   CALL s_desc_get_tax_desc1(g_gcaf_m.gcafunit,g_gcaf_m.gcaf041) RETURNING g_gcaf_m.gcaf041_desc
   DISPLAY BY NAME g_gcaf_m.gcaf041_desc
   #160215-00002#2(E)   
#   
#   CALL agcm300_gcafunit_ref()
#   
#   CALL agcm300_gcaf012_ref()
#   
#   CALL agcm300_gcaf013_ref()
#   
#   CALL agcm300_gcaf018_desc()
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcaf_m.gcafownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_gcaf_m.gcafownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcaf_m.gcafownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcaf_m.gcafowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_gcaf_m.gcafowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcaf_m.gcafowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcaf_m.gcafcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_gcaf_m.gcafcrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcaf_m.gcafcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcaf_m.gcafcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_gcaf_m.gcafcrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcaf_m.gcafcrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcaf_m.gcafmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_gcaf_m.gcafmodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcaf_m.gcafmodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcaf_m.gcafcnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_gcaf_m.gcafcnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcaf_m.gcafcnfid_desc
#            
#   CALL agcm300_gcaf031_ref() 

   #end add-point
   
   #遮罩相關處理
   LET g_gcaf_m_mask_o.* =  g_gcaf_m.*
   CALL agcm300_gcaf_t_mask()
   LET g_gcaf_m_mask_n.* =  g_gcaf_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcafl003,g_gcaf_m.gcafl004,g_gcaf_m.gcaf003, 
       g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafunit_desc,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005, 
       g_gcaf_m.gcaf006,g_gcaf_m.gcaf007,g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011, 
       g_gcaf_m.gcaf012,g_gcaf_m.gcaf012_desc,g_gcaf_m.gcaf013,g_gcaf_m.gcaf013_desc,g_gcaf_m.gcaf041, 
       g_gcaf_m.gcaf041_desc,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037,g_gcaf_m.gcaf038,g_gcaf_m.gcaf039, 
       g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020, 
       g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035,g_gcaf_m.gcaf036, 
       g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf031_desc,g_gcaf_m.gcaf040,g_gcaf_m.gcaf026, 
       g_gcaf_m.gcaf032,g_gcaf_m.gcaf033,g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcafownid,g_gcaf_m.gcafownid_desc, 
       g_gcaf_m.gcafowndp,g_gcaf_m.gcafowndp_desc,g_gcaf_m.gcafcrtid,g_gcaf_m.gcafcrtid_desc,g_gcaf_m.gcafcrtdp, 
       g_gcaf_m.gcafcrtdp_desc,g_gcaf_m.gcafcrtdt,g_gcaf_m.gcafmodid,g_gcaf_m.gcafmodid_desc,g_gcaf_m.gcafmoddt, 
       g_gcaf_m.gcafcnfid,g_gcaf_m.gcafcnfid_desc,g_gcaf_m.gcafcnfdt,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028, 
       g_gcaf_m.gcaf029,g_gcaf_m.gcaf030
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gcaf_m.gcafstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gcag_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
                              
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_gcag2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
                                    CALL agcm300_gcah003_ref()
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_gcag3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
                              
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_gcag4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
#                                    CALL agcm300_gcaj002_ref()
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
               
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL agcm300_detail_show()
 
   #add-point:show段之後 name="show.after"
               
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION agcm300_detail_show()
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
 
{<section id="agcm300.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION agcm300_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE gcaf_t.gcaf001 
   DEFINE l_oldno     LIKE gcaf_t.gcaf001 
 
   DEFINE l_master    RECORD LIKE gcaf_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE gcag_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE gcah_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE gcai_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE gcaj_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
               
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_gcaf_m.gcaf001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_gcaf001_t = g_gcaf_m.gcaf001
 
    
   LET g_gcaf_m.gcaf001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gcaf_m.gcafownid = g_user
      LET g_gcaf_m.gcafowndp = g_dept
      LET g_gcaf_m.gcafcrtid = g_user
      LET g_gcaf_m.gcafcrtdp = g_dept 
      LET g_gcaf_m.gcafcrtdt = cl_get_current()
      LET g_gcaf_m.gcafmodid = g_user
      LET g_gcaf_m.gcafmoddt = cl_get_current()
      LET g_gcaf_m.gcafstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
               
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gcaf_m.gcafstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL agcm300_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_gcaf_m.* TO NULL
      INITIALIZE g_gcag_d TO NULL
      INITIALIZE g_gcag2_d TO NULL
      INITIALIZE g_gcag3_d TO NULL
      INITIALIZE g_gcag4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL agcm300_show()
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
   CALL agcm300_set_act_visible()   
   CALL agcm300_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gcaf001_t = g_gcaf_m.gcaf001
 
   
   #組合新增資料的條件
   LET g_add_browse = " gcafent = " ||g_enterprise|| " AND",
                      " gcaf001 = '", g_gcaf_m.gcaf001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agcm300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
               
   #end add-point
   
   CALL agcm300_idx_chk()
   
   LET g_data_owner = g_gcaf_m.gcafownid      
   LET g_data_dept  = g_gcaf_m.gcafowndp
   
   #功能已完成,通報訊息中心
   CALL agcm300_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION agcm300_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gcag_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE gcah_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE gcai_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE gcaj_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
               
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE agcm300_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
               
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gcag_t
    WHERE gcagent = g_enterprise AND gcag001 = g_gcaf001_t
 
    INTO TEMP agcm300_detail
 
   #將key修正為調整後   
   UPDATE agcm300_detail 
      #更新key欄位
      SET gcag001 = g_gcaf_m.gcaf001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
      #, gcagstus = "Y" 
 
 
#應用 a13 樣板自動產生(Version:4)
      #, gcahstus = "Y" 
 
 
#應用 a13 樣板自動產生(Version:4)
      #, gcaistus = "Y" 
 
 
#應用 a13 樣板自動產生(Version:4)
      #, gcajstus = "Y" 
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO gcag_t SELECT * FROM agcm300_detail
   
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
   DROP TABLE agcm300_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
               
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
               
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gcah_t 
    WHERE gcahent = g_enterprise AND gcah001 = g_gcaf001_t
 
    INTO TEMP agcm300_detail
 
   #將key修正為調整後   
   UPDATE agcm300_detail SET gcah001 = g_gcaf_m.gcaf001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO gcah_t SELECT * FROM agcm300_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
               
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE agcm300_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
               
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
               
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gcai_t 
    WHERE gcaient = g_enterprise AND gcai001 = g_gcaf001_t
 
    INTO TEMP agcm300_detail
 
   #將key修正為調整後   
   UPDATE agcm300_detail SET gcai001 = g_gcaf_m.gcaf001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO gcai_t SELECT * FROM agcm300_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
               
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE agcm300_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
               
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
               
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gcaj_t 
    WHERE gcajent = g_enterprise AND gcaj001 = g_gcaf001_t
 
    INTO TEMP agcm300_detail
 
   #將key修正為調整後   
   UPDATE agcm300_detail SET gcaj001 = g_gcaf_m.gcaf001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO gcaj_t SELECT * FROM agcm300_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
               
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE agcm300_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
               
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gcaf001_t = g_gcaf_m.gcaf001
 
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300.delete" >}
#+ 資料刪除
PRIVATE FUNCTION agcm300_delete()
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
   
   IF g_gcaf_m.gcaf001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.gcafl001 = g_gcaf_m.gcaf001
LET g_master_multi_table_t.gcafl003 = g_gcaf_m.gcafl003
LET g_master_multi_table_t.gcafl004 = g_gcaf_m.gcafl004
 
   
   CALL s_transaction_begin()
 
   OPEN agcm300_cl USING g_enterprise,g_gcaf_m.gcaf001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agcm300_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE agcm300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agcm300_master_referesh USING g_gcaf_m.gcaf001 INTO g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcaf003, 
       g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005,g_gcaf_m.gcaf006,g_gcaf_m.gcaf007, 
       g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011,g_gcaf_m.gcaf012,g_gcaf_m.gcaf013, 
       g_gcaf_m.gcaf041,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037,g_gcaf_m.gcaf038,g_gcaf_m.gcaf039, 
       g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020, 
       g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035,g_gcaf_m.gcaf036, 
       g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf040,g_gcaf_m.gcaf026,g_gcaf_m.gcaf032, 
       g_gcaf_m.gcaf033,g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcafownid,g_gcaf_m.gcafowndp,g_gcaf_m.gcafcrtid, 
       g_gcaf_m.gcafcrtdp,g_gcaf_m.gcafcrtdt,g_gcaf_m.gcafmodid,g_gcaf_m.gcafmoddt,g_gcaf_m.gcafcnfid, 
       g_gcaf_m.gcafcnfdt,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028,g_gcaf_m.gcaf029,g_gcaf_m.gcaf030,g_gcaf_m.gcafunit_desc, 
       g_gcaf_m.gcaf012_desc,g_gcaf_m.gcaf013_desc,g_gcaf_m.gcaf031_desc,g_gcaf_m.gcafownid_desc,g_gcaf_m.gcafowndp_desc, 
       g_gcaf_m.gcafcrtid_desc,g_gcaf_m.gcafcrtdp_desc,g_gcaf_m.gcafmodid_desc,g_gcaf_m.gcafcnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT agcm300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gcaf_m_mask_o.* =  g_gcaf_m.*
   CALL agcm300_gcaf_t_mask()
   LET g_gcaf_m_mask_n.* =  g_gcaf_m.*
   
   CALL agcm300_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
                              
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agcm300_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_gcaf001_t = g_gcaf_m.gcaf001
 
 
      DELETE FROM gcaf_t
       WHERE gcafent = g_enterprise AND gcaf001 = g_gcaf_m.gcaf001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
                              
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_gcaf_m.gcaf001,":",SQLERRMESSAGE  
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
      
      DELETE FROM gcag_t
       WHERE gcagent = g_enterprise AND gcag001 = g_gcaf_m.gcaf001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
                              
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcag_t:",SQLERRMESSAGE 
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
      DELETE FROM gcah_t
       WHERE gcahent = g_enterprise AND
             gcah001 = g_gcaf_m.gcaf001
      #add-point:單身刪除中 name="delete.body.m_delete2"
                              
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcah_t:",SQLERRMESSAGE 
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
      DELETE FROM gcai_t
       WHERE gcaient = g_enterprise AND
             gcai001 = g_gcaf_m.gcaf001
      #add-point:單身刪除中 name="delete.body.m_delete3"
                              
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcai_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
                              
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete4"
                              
      #end add-point
      DELETE FROM gcaj_t
       WHERE gcajent = g_enterprise AND
             gcaj001 = g_gcaf_m.gcaf001
      #add-point:單身刪除中 name="delete.body.m_delete4"
                              
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcaj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
                                    #删除生效据点
      DELETE FROM mmap_t
       WHERE mmapent = g_enterprise AND mmap001 = 'agcm300' AND mmap002 = g_gcaf_m.gcaf001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del mmap_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #删除发行面额
      DELETE FROM gcar_t
       WHERE gcarent = g_enterprise AND gcar001 = g_gcaf_m.gcaf001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del gcar_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
       
      #删除提货商品
      DELETE FROM gcas_t
       WHERE gcasent = g_enterprise AND gcas001 = g_gcaf_m.gcaf001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del gcas_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #删除备注
      IF NOT s_aooi360_del('99','agcm300',g_gcaf_m.gcaf001,'','','','','','','','','4') THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_gcaf_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE agcm300_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_gcag_d.clear() 
      CALL g_gcag2_d.clear()       
      CALL g_gcag3_d.clear()       
      CALL g_gcag4_d.clear()       
 
     
      CALL agcm300_ui_browser_refresh()  
      #CALL agcm300_ui_headershow()  
      #CALL agcm300_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'gcaflent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.gcafl001
   LET l_field_keys[02] = 'gcafl001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'gcafl_t')
 
      
      #單身多語言刪除
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL agcm300_browser_fill("")
         CALL agcm300_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE agcm300_cl
 
   #功能已完成,通報訊息中心
   CALL agcm300_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="agcm300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION agcm300_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"

   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
 
   #end add-point
   
   #清空第一階單身
   CALL g_gcag_d.clear()
   CALL g_gcag2_d.clear()
   CALL g_gcag3_d.clear()
   CALL g_gcag4_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
               
   #end add-point
   
   #判斷是否填充
   IF agcm300_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gcag002,gcag003,gcag004,gcag005,gcag006,gcagstus  FROM gcag_t", 
                
                     " INNER JOIN gcaf_t ON gcafent = " ||g_enterprise|| " AND gcaf001 = gcag001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE gcagent=? AND gcag001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
                              
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gcag_t.gcag002"
         
         #add-point:單身填充控制 name="b_fill.sql"
                              
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agcm300_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR agcm300_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_gcaf_m.gcaf001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_gcaf_m.gcaf001 INTO g_gcag_d[l_ac].gcag002,g_gcag_d[l_ac].gcag003, 
          g_gcag_d[l_ac].gcag004,g_gcag_d[l_ac].gcag005,g_gcag_d[l_ac].gcag006,g_gcag_d[l_ac].gcagstus  
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
    
   #判斷是否填充
   IF agcm300_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gcah002,gcah003,gcahstus  FROM gcah_t",   
                     " INNER JOIN  gcaf_t ON gcafent = " ||g_enterprise|| " AND gcaf001 = gcah001 ",
 
                     "",
                     
                     
                     " WHERE gcahent=? AND gcah001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
                              
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gcah_t.gcah002,gcah_t.gcah003"
         
         #add-point:單身填充控制 name="b_fill.sql2"
                              
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agcm300_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR agcm300_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_gcaf_m.gcaf001   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_gcaf_m.gcaf001 INTO g_gcag2_d[l_ac].gcah002,g_gcag2_d[l_ac].gcah003, 
          g_gcag2_d[l_ac].gcahstus   #(ver:78)
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
 
   #判斷是否填充
   IF agcm300_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gcai002,gcai003,gcai004,gcai005,gcai006,gcai007,gcai008,gcaistus  FROM gcai_t", 
                
                     " INNER JOIN  gcaf_t ON gcafent = " ||g_enterprise|| " AND gcaf001 = gcai001 ",
 
                     "",
                     
                     
                     " WHERE gcaient=? AND gcai001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
                              
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gcai_t.gcai002"
         
         #add-point:單身填充控制 name="b_fill.sql3"
                              
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agcm300_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR agcm300_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_gcaf_m.gcaf001   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_gcaf_m.gcaf001 INTO g_gcag3_d[l_ac].gcai002,g_gcag3_d[l_ac].gcai003, 
          g_gcag3_d[l_ac].gcai004,g_gcag3_d[l_ac].gcai005,g_gcag3_d[l_ac].gcai006,g_gcag3_d[l_ac].gcai007, 
          g_gcag3_d[l_ac].gcai008,g_gcag3_d[l_ac].gcaistus   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
                                             
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
 
   #判斷是否填充
   IF agcm300_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gcaj002,gcaj003,gcajstus ,t1.ooefl003 FROM gcaj_t",   
                     " INNER JOIN  gcaf_t ON gcafent = " ||g_enterprise|| " AND gcaf001 = gcaj001 ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=gcaj002 AND t1.ooefl002='"||g_dlang||"' ",
 
                     " WHERE gcajent=? AND gcaj001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
                              
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gcaj_t.gcaj002"
         
         #add-point:單身填充控制 name="b_fill.sql4"
                              
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agcm300_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR agcm300_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise,g_gcaf_m.gcaf001   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise,g_gcaf_m.gcaf001 INTO g_gcag4_d[l_ac].gcaj002,g_gcag4_d[l_ac].gcaj003, 
          g_gcag4_d[l_ac].gcajstus,g_gcag4_d[l_ac].gcaj002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill4.fill"
                                             
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
   
   CALL g_gcag_d.deleteElement(g_gcag_d.getLength())
   CALL g_gcag2_d.deleteElement(g_gcag2_d.getLength())
   CALL g_gcag3_d.deleteElement(g_gcag3_d.getLength())
   CALL g_gcag4_d.deleteElement(g_gcag4_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE agcm300_pb
   FREE agcm300_pb2
 
   FREE agcm300_pb3
 
   FREE agcm300_pb4
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_gcag_d.getLength()
      LET g_gcag_d_mask_o[l_ac].* =  g_gcag_d[l_ac].*
      CALL agcm300_gcag_t_mask()
      LET g_gcag_d_mask_n[l_ac].* =  g_gcag_d[l_ac].*
   END FOR
   
   LET g_gcag2_d_mask_o.* =  g_gcag2_d.*
   FOR l_ac = 1 TO g_gcag2_d.getLength()
      LET g_gcag2_d_mask_o[l_ac].* =  g_gcag2_d[l_ac].*
      CALL agcm300_gcah_t_mask()
      LET g_gcag2_d_mask_n[l_ac].* =  g_gcag2_d[l_ac].*
   END FOR
   LET g_gcag3_d_mask_o.* =  g_gcag3_d.*
   FOR l_ac = 1 TO g_gcag3_d.getLength()
      LET g_gcag3_d_mask_o[l_ac].* =  g_gcag3_d[l_ac].*
      CALL agcm300_gcai_t_mask()
      LET g_gcag3_d_mask_n[l_ac].* =  g_gcag3_d[l_ac].*
   END FOR
   LET g_gcag4_d_mask_o.* =  g_gcag4_d.*
   FOR l_ac = 1 TO g_gcag4_d.getLength()
      LET g_gcag4_d_mask_o[l_ac].* =  g_gcag4_d[l_ac].*
      CALL agcm300_gcaj_t_mask()
      LET g_gcag4_d_mask_n[l_ac].* =  g_gcag4_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION agcm300_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM gcag_t
       WHERE gcagent = g_enterprise AND
         gcag001 = ps_keys_bak[1] AND gcag002 = ps_keys_bak[2]
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
         CALL g_gcag_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
                              
      #end add-point    
      DELETE FROM gcah_t
       WHERE gcahent = g_enterprise AND
             gcah001 = ps_keys_bak[1] AND gcah002 = ps_keys_bak[2] AND gcah003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
                              
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcah_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_gcag2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
                              
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
                              
      #end add-point    
      DELETE FROM gcai_t
       WHERE gcaient = g_enterprise AND
             gcai001 = ps_keys_bak[1] AND gcai002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
                              
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcai_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_gcag3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
                              
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
                              
      #end add-point    
      DELETE FROM gcaj_t
       WHERE gcajent = g_enterprise AND
             gcaj001 = ps_keys_bak[1] AND gcaj002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
                              
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcaj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_gcag4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
                              
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
               
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION agcm300_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO gcag_t
                  (gcagent,
                   gcag001,
                   gcag002
                   ,gcag003,gcag004,gcag005,gcag006,gcagstus) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_gcag_d[g_detail_idx].gcag003,g_gcag_d[g_detail_idx].gcag004,g_gcag_d[g_detail_idx].gcag005, 
                       g_gcag_d[g_detail_idx].gcag006,g_gcag_d[g_detail_idx].gcagstus)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
                              
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcag_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_gcag_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
                              
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
                              
      #end add-point 
      INSERT INTO gcah_t
                  (gcahent,
                   gcah001,
                   gcah002,gcah003
                   ,gcahstus) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_gcag2_d[g_detail_idx].gcahstus)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
                              
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcah_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_gcag2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
                              
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
                              
      #end add-point 
      INSERT INTO gcai_t
                  (gcaient,
                   gcai001,
                   gcai002
                   ,gcai003,gcai004,gcai005,gcai006,gcai007,gcai008,gcaistus) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_gcag3_d[g_detail_idx].gcai003,g_gcag3_d[g_detail_idx].gcai004,g_gcag3_d[g_detail_idx].gcai005, 
                       g_gcag3_d[g_detail_idx].gcai006,g_gcag3_d[g_detail_idx].gcai007,g_gcag3_d[g_detail_idx].gcai008, 
                       g_gcag3_d[g_detail_idx].gcaistus)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
                              
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcai_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_gcag3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
                              
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
                              
      #end add-point 
      INSERT INTO gcaj_t
                  (gcajent,
                   gcaj001,
                   gcaj002
                   ,gcaj003,gcajstus) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_gcag4_d[g_detail_idx].gcaj003,g_gcag4_d[g_detail_idx].gcajstus)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
                              
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcaj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_gcag4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
                              
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
               
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION agcm300_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gcag_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
                              
      #end add-point 
      
      #將遮罩欄位還原
      CALL agcm300_gcag_t_mask_restore('restore_mask_o')
               
      UPDATE gcag_t 
         SET (gcag001,
              gcag002
              ,gcag003,gcag004,gcag005,gcag006,gcagstus) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gcag_d[g_detail_idx].gcag003,g_gcag_d[g_detail_idx].gcag004,g_gcag_d[g_detail_idx].gcag005, 
                  g_gcag_d[g_detail_idx].gcag006,g_gcag_d[g_detail_idx].gcagstus) 
         WHERE gcagent = g_enterprise AND gcag001 = ps_keys_bak[1] AND gcag002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
                              
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcag_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcag_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agcm300_gcag_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
                              
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gcah_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
                              
      #end add-point  
      
      #將遮罩欄位還原
      CALL agcm300_gcah_t_mask_restore('restore_mask_o')
               
      UPDATE gcah_t 
         SET (gcah001,
              gcah002,gcah003
              ,gcahstus) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_gcag2_d[g_detail_idx].gcahstus) 
         WHERE gcahent = g_enterprise AND gcah001 = ps_keys_bak[1] AND gcah002 = ps_keys_bak[2] AND gcah003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
                              
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcah_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcah_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agcm300_gcah_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
                              
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gcai_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
                              
      #end add-point  
      
      #將遮罩欄位還原
      CALL agcm300_gcai_t_mask_restore('restore_mask_o')
               
      UPDATE gcai_t 
         SET (gcai001,
              gcai002
              ,gcai003,gcai004,gcai005,gcai006,gcai007,gcai008,gcaistus) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gcag3_d[g_detail_idx].gcai003,g_gcag3_d[g_detail_idx].gcai004,g_gcag3_d[g_detail_idx].gcai005, 
                  g_gcag3_d[g_detail_idx].gcai006,g_gcag3_d[g_detail_idx].gcai007,g_gcag3_d[g_detail_idx].gcai008, 
                  g_gcag3_d[g_detail_idx].gcaistus) 
         WHERE gcaient = g_enterprise AND gcai001 = ps_keys_bak[1] AND gcai002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
                              
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcai_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcai_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agcm300_gcai_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
                              
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gcaj_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
                              
      #end add-point  
      
      #將遮罩欄位還原
      CALL agcm300_gcaj_t_mask_restore('restore_mask_o')
               
      UPDATE gcaj_t 
         SET (gcaj001,
              gcaj002
              ,gcaj003,gcajstus) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gcag4_d[g_detail_idx].gcaj003,g_gcag4_d[g_detail_idx].gcajstus) 
         WHERE gcajent = g_enterprise AND gcaj001 = ps_keys_bak[1] AND gcaj002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update4"
                              
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcaj_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcaj_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agcm300_gcaj_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update4"
                              
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
               
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION agcm300_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="agcm300.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION agcm300_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="agcm300.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION agcm300_lock_b(ps_table,ps_page)
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
   #CALL agcm300_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "gcag_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN agcm300_bcl USING g_enterprise,
                                       g_gcaf_m.gcaf001,g_gcag_d[g_detail_idx].gcag002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agcm300_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "gcah_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN agcm300_bcl2 USING g_enterprise,
                                             g_gcaf_m.gcaf001,g_gcag2_d[g_detail_idx].gcah002,g_gcag2_d[g_detail_idx].gcah003 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agcm300_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "gcai_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN agcm300_bcl3 USING g_enterprise,
                                             g_gcaf_m.gcaf001,g_gcag3_d[g_detail_idx].gcai002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agcm300_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "gcaj_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN agcm300_bcl4 USING g_enterprise,
                                             g_gcaf_m.gcaf001,g_gcag4_d[g_detail_idx].gcaj002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agcm300_bcl4:",SQLERRMESSAGE 
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
 
{<section id="agcm300.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION agcm300_unlock_b(ps_table,ps_page)
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
      CLOSE agcm300_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE agcm300_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE agcm300_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE agcm300_bcl4
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
               
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION agcm300_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
               
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gcaf001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
                              
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
                  CALL cl_set_comp_entry("gcaf017",TRUE)
   CALL cl_set_comp_entry("gcaf018",TRUE)
   CALL cl_set_comp_entry("gcaf019",TRUE)
   CALL cl_set_comp_entry("gcaf020",TRUE)
   CALL cl_set_comp_entry("gcaf021",TRUE)     #dongsz add
   CALL cl_set_comp_entry("gcaf022",TRUE)
   CALL cl_set_comp_entry("gcaf023",TRUE)
   CALL cl_set_comp_entry("gcaf029",TRUE)
   CALL cl_set_comp_entry("gcaf030",TRUE)
   CALL cl_set_comp_entry("gcaf037",TRUE)      #150825-00006#4--dongsz add
   CALL cl_set_comp_entry("gcaf042",TRUE)   #160728-00006#2  by 08172
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION agcm300_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_n     LIKE type_t.num5        
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gcaf001",FALSE)
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
                  IF cl_null(g_gcaf_m.gcaf018) OR g_gcaf_m.gcaf018 <> '1' THEN
      CALL cl_set_comp_entry("gcaf019",FALSE)
   END IF
   #mark by geza 20150615(S)
#   IF cl_null(g_gcaf_m.gcaf003) OR g_gcaf_m.gcaf003 <> '4' THEN
#      CALL cl_set_comp_entry("gcaf029",FALSE)
#      CALL cl_set_comp_entry("gcaf030",FALSE)
#   END IF
   #mark by geza 20150615(S)
   IF cl_null(g_gcaf_m.gcaf018) OR g_gcaf_m.gcaf018 = '1' THEN
      CALL cl_set_comp_entry("gcaf020",FALSE)
   END IF
   IF cl_null(g_gcaf_m.gcaf021) OR g_gcaf_m.gcaf021 = 'N' THEN
      CALL cl_set_comp_entry("gcaf022",FALSE)
      CALL cl_set_comp_entry("gcaf023",FALSE)
   END IF
   IF cl_null(g_gcaf_m.gcaf029) OR g_gcaf_m.gcaf029 = '0' THEN
      CALL cl_set_comp_entry("gcaf030",FALSE)
   END IF
   IF cl_null(g_gcaf_m.gcaf016) OR g_gcaf_m.gcaf016 = 'N' THEN
      CALL cl_set_comp_entry("gcaf017",FALSE)
      CALL cl_set_comp_entry("gcaf018",FALSE)
      CALL cl_set_comp_entry("gcaf019",FALSE)
      CALL cl_set_comp_entry("gcaf020",FALSE)
      CALL cl_set_comp_entry("gcaf042",FALSE)   #160728-00006#2  by 08172
   END IF
   #160728-00006#2 -s by 08172
   IF g_gcaf_m.gcaf017 <> '0' THEN
      CALL cl_set_comp_entry("gcaf042",FALSE)   
   END IF
   #160728-00006#2 -e by 08172
   #dongsz--add--str---
   IF g_gcaf_m.gcaf003 = '4' THEN
      CALL cl_set_comp_entry("gcaf021",FALSE)
      CALL cl_set_comp_entry("gcaf022",FALSE)
      CALL cl_set_comp_entry("gcaf023",FALSE)
   END IF
   #dongsz--add--end---
   #150825-00006#4--add by dongsz--s
   IF g_gcaf_m.gcaf015 = 'N' AND p_cmd = 'a' THEN
      LET g_gcaf_m.gcaf037 = 'N'
      CALL cl_set_comp_entry("gcaf037",FALSE)
   END IF
   #150825-00006#4--add by dongsz--e
   #20151110--dongsz add--str---
   #存在券明细，则不允许修改使用校验码否栏位
   IF NOT cl_null(g_gcaf_m.gcaf001) AND p_cmd = 'u' THEN
      LET l_n = 0
      SELECT COUNT(1) INTO l_n   #160905-00007#2 count(*) --> count(1)
        FROM gcao_t 
       WHERE gcaoent = g_enterprise
         AND gcao002 = g_gcaf_m.gcaf001
      IF l_n > 0 THEN
         CALL cl_set_comp_entry("gcaf037",FALSE)
      END IF
   END IF
   #20151110--dongsz add--end---
   #aooi500設定的欄位控卡   
   IF NOT s_aooi500_comp_entry(g_prog,'gcafunit') OR g_site_flag THEN
      CALL cl_set_comp_entry("gcafunit",FALSE)
   END IF   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION agcm300_set_entry_b(p_cmd)
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
 
{<section id="agcm300.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION agcm300_set_no_entry_b(p_cmd)
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
 
{<section id="agcm300.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION agcm300_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   #150424-00018#1 150529 add by beckxie
   CALL cl_set_act_visible("insert,modify,modify_detail,reproduce,delete,statechange",TRUE)
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agcm300.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION agcm300_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   #160303-00009#1 20160304 add by beckxie---S
   IF g_gcaf_m.gcafstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #160303-00009#1 20160304 add by beckxie---E
   IF NOT cl_null(g_gcaf_m.gcaf003) AND g_gcaf_m.gcaf003 = '3' THEN
      CALL cl_set_act_visible('delivery_set',TRUE)
   ELSE
      CALL cl_set_act_visible('delivery_set',FALSE)
   END IF
   #150424-00018#1 150529 add by beckxie---S
   IF cl_get_para(g_enterprise,g_site,'E-CIR-0033')='Y' THEN
      CALL cl_set_act_visible("insert,modify,modify_detail,reproduce,delete,statechange",FALSE)
   END IF
   #150424-00018#1 150529 add by beckxie---E
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agcm300.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION agcm300_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agcm300.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION agcm300_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agcm300.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION agcm300_default_search()
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
      LET ls_wc = ls_wc, " gcaf001 = '", g_argv[01], "' AND "
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
 
         INITIALIZE g_wc2_table3 TO NULL
 
         INITIALIZE g_wc2_table4 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "gcaf_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "gcag_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "gcah_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "gcai_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "gcaj_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
            END IF
 
            IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
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
 
{<section id="agcm300.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION agcm300_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
                  DEFINE l_success   LIKE type_t.num5
   DEFINE l_errno     LIKE type_t.chr10
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
               
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_gcaf_m.gcaf001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN agcm300_cl USING g_enterprise,g_gcaf_m.gcaf001
   IF STATUS THEN
      CLOSE agcm300_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agcm300_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE agcm300_master_referesh USING g_gcaf_m.gcaf001 INTO g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcaf003, 
       g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005,g_gcaf_m.gcaf006,g_gcaf_m.gcaf007, 
       g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011,g_gcaf_m.gcaf012,g_gcaf_m.gcaf013, 
       g_gcaf_m.gcaf041,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037,g_gcaf_m.gcaf038,g_gcaf_m.gcaf039, 
       g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020, 
       g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035,g_gcaf_m.gcaf036, 
       g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf040,g_gcaf_m.gcaf026,g_gcaf_m.gcaf032, 
       g_gcaf_m.gcaf033,g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcafownid,g_gcaf_m.gcafowndp,g_gcaf_m.gcafcrtid, 
       g_gcaf_m.gcafcrtdp,g_gcaf_m.gcafcrtdt,g_gcaf_m.gcafmodid,g_gcaf_m.gcafmoddt,g_gcaf_m.gcafcnfid, 
       g_gcaf_m.gcafcnfdt,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028,g_gcaf_m.gcaf029,g_gcaf_m.gcaf030,g_gcaf_m.gcafunit_desc, 
       g_gcaf_m.gcaf012_desc,g_gcaf_m.gcaf013_desc,g_gcaf_m.gcaf031_desc,g_gcaf_m.gcafownid_desc,g_gcaf_m.gcafowndp_desc, 
       g_gcaf_m.gcafcrtid_desc,g_gcaf_m.gcafcrtdp_desc,g_gcaf_m.gcafmodid_desc,g_gcaf_m.gcafcnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT agcm300_action_chk() THEN
      CLOSE agcm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcafl003,g_gcaf_m.gcafl004,g_gcaf_m.gcaf003, 
       g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafunit_desc,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005, 
       g_gcaf_m.gcaf006,g_gcaf_m.gcaf007,g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011, 
       g_gcaf_m.gcaf012,g_gcaf_m.gcaf012_desc,g_gcaf_m.gcaf013,g_gcaf_m.gcaf013_desc,g_gcaf_m.gcaf041, 
       g_gcaf_m.gcaf041_desc,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037,g_gcaf_m.gcaf038,g_gcaf_m.gcaf039, 
       g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019,g_gcaf_m.gcaf020, 
       g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035,g_gcaf_m.gcaf036, 
       g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf031_desc,g_gcaf_m.gcaf040,g_gcaf_m.gcaf026, 
       g_gcaf_m.gcaf032,g_gcaf_m.gcaf033,g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcafownid,g_gcaf_m.gcafownid_desc, 
       g_gcaf_m.gcafowndp,g_gcaf_m.gcafowndp_desc,g_gcaf_m.gcafcrtid,g_gcaf_m.gcafcrtid_desc,g_gcaf_m.gcafcrtdp, 
       g_gcaf_m.gcafcrtdp_desc,g_gcaf_m.gcafcrtdt,g_gcaf_m.gcafmodid,g_gcaf_m.gcafmodid_desc,g_gcaf_m.gcafmoddt, 
       g_gcaf_m.gcafcnfid,g_gcaf_m.gcafcnfid_desc,g_gcaf_m.gcafcnfdt,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028, 
       g_gcaf_m.gcaf029,g_gcaf_m.gcaf030
 
   CASE g_gcaf_m.gcafstus
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
         CASE g_gcaf_m.gcafstus
            
            WHEN "N"
               HIDE OPTION "open"
            WHEN "Y"
               HIDE OPTION "valid"
            WHEN "X"
               HIDE OPTION "void"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
                                       CASE g_gcaf_m.gcafstus
            WHEN "Y"
               HIDE OPTION "invalid"
         END CASE
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
      g_gcaf_m.gcafstus = lc_state OR cl_null(lc_state) THEN
      CLOSE agcm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
                  CALL s_transaction_begin()
   IF lc_state = 'Y' AND g_gcaf_m.gcafstus = 'N' THEN
      CALL s_agcm300_conf_chk(g_gcaf_m.gcaf001,g_gcaf_m.gcafstus) RETURNING l_success,l_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = g_gcaf_m.gcaf001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN 
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_agcm300_conf_upd(g_gcaf_m.gcaf001) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
      END IF
   END IF
   IF lc_state = 'N' AND g_gcaf_m.gcafstus = 'Y' THEN
      CALL s_agcm300_unconf_chk(g_gcaf_m.gcaf001,g_gcaf_m.gcafstus) RETURNING l_success,l_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = g_gcaf_m.gcaf001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN 
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_agcm300_unconf_upd(g_gcaf_m.gcaf001) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
      END IF
   END IF
   IF lc_state = 'X' AND g_gcaf_m.gcafstus = 'N' THEN
      CALL s_agcm300_void_chk(g_gcaf_m.gcaf001,g_gcaf_m.gcafstus) RETURNING l_success,l_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = g_gcaf_m.gcaf001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('art-00039') THEN 
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_agcm300_void_upd(g_gcaf_m.gcaf001) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
      END IF
   END IF
   IF lc_state = 'N' AND g_gcaf_m.gcafstus = 'X' THEN
      CALL s_agcm300_valid_chk(g_gcaf_m.gcaf001,g_gcaf_m.gcafstus) RETURNING l_success,l_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = g_gcaf_m.gcaf001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('art-00038') THEN 
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_agcm300_valid_upd(g_gcaf_m.gcaf001) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_gcaf_m.gcafmodid = g_user
   LET g_gcaf_m.gcafmoddt = cl_get_current()
   LET g_gcaf_m.gcafstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE gcaf_t 
      SET (gcafstus,gcafmodid,gcafmoddt) 
        = (g_gcaf_m.gcafstus,g_gcaf_m.gcafmodid,g_gcaf_m.gcafmoddt)     
    WHERE gcafent = g_enterprise AND gcaf001 = g_gcaf_m.gcaf001
 
    
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
      EXECUTE agcm300_master_referesh USING g_gcaf_m.gcaf001 INTO g_gcaf_m.gcaf001,g_gcaf_m.gcaf002, 
          g_gcaf_m.gcaf003,g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005,g_gcaf_m.gcaf006, 
          g_gcaf_m.gcaf007,g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011,g_gcaf_m.gcaf012, 
          g_gcaf_m.gcaf013,g_gcaf_m.gcaf041,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037,g_gcaf_m.gcaf038, 
          g_gcaf_m.gcaf039,g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019, 
          g_gcaf_m.gcaf020,g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035, 
          g_gcaf_m.gcaf036,g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf040,g_gcaf_m.gcaf026, 
          g_gcaf_m.gcaf032,g_gcaf_m.gcaf033,g_gcaf_m.gcaf044,g_gcaf_m.gcaf045,g_gcaf_m.gcafownid,g_gcaf_m.gcafowndp, 
          g_gcaf_m.gcafcrtid,g_gcaf_m.gcafcrtdp,g_gcaf_m.gcafcrtdt,g_gcaf_m.gcafmodid,g_gcaf_m.gcafmoddt, 
          g_gcaf_m.gcafcnfid,g_gcaf_m.gcafcnfdt,g_gcaf_m.gcaf027,g_gcaf_m.gcaf028,g_gcaf_m.gcaf029,g_gcaf_m.gcaf030, 
          g_gcaf_m.gcafunit_desc,g_gcaf_m.gcaf012_desc,g_gcaf_m.gcaf013_desc,g_gcaf_m.gcaf031_desc,g_gcaf_m.gcafownid_desc, 
          g_gcaf_m.gcafowndp_desc,g_gcaf_m.gcafcrtid_desc,g_gcaf_m.gcafcrtdp_desc,g_gcaf_m.gcafmodid_desc, 
          g_gcaf_m.gcafcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_gcaf_m.gcaf001,g_gcaf_m.gcaf002,g_gcaf_m.gcafl003,g_gcaf_m.gcafl004,g_gcaf_m.gcaf003, 
          g_gcaf_m.gcaf004,g_gcaf_m.gcafunit,g_gcaf_m.gcafunit_desc,g_gcaf_m.gcafstus,g_gcaf_m.gcaf005, 
          g_gcaf_m.gcaf006,g_gcaf_m.gcaf007,g_gcaf_m.gcaf008,g_gcaf_m.gcaf009,g_gcaf_m.gcaf010,g_gcaf_m.gcaf011, 
          g_gcaf_m.gcaf012,g_gcaf_m.gcaf012_desc,g_gcaf_m.gcaf013,g_gcaf_m.gcaf013_desc,g_gcaf_m.gcaf041, 
          g_gcaf_m.gcaf041_desc,g_gcaf_m.gcaf015,g_gcaf_m.gcaf043,g_gcaf_m.gcaf037,g_gcaf_m.gcaf038, 
          g_gcaf_m.gcaf039,g_gcaf_m.gcaf016,g_gcaf_m.gcaf017,g_gcaf_m.gcaf042,g_gcaf_m.gcaf018,g_gcaf_m.gcaf019, 
          g_gcaf_m.gcaf020,g_gcaf_m.gcaf021,g_gcaf_m.gcaf022,g_gcaf_m.gcaf023,g_gcaf_m.gcaf034,g_gcaf_m.gcaf035, 
          g_gcaf_m.gcaf036,g_gcaf_m.gcaf024,g_gcaf_m.gcaf025,g_gcaf_m.gcaf031,g_gcaf_m.gcaf031_desc, 
          g_gcaf_m.gcaf040,g_gcaf_m.gcaf026,g_gcaf_m.gcaf032,g_gcaf_m.gcaf033,g_gcaf_m.gcaf044,g_gcaf_m.gcaf045, 
          g_gcaf_m.gcafownid,g_gcaf_m.gcafownid_desc,g_gcaf_m.gcafowndp,g_gcaf_m.gcafowndp_desc,g_gcaf_m.gcafcrtid, 
          g_gcaf_m.gcafcrtid_desc,g_gcaf_m.gcafcrtdp,g_gcaf_m.gcafcrtdp_desc,g_gcaf_m.gcafcrtdt,g_gcaf_m.gcafmodid, 
          g_gcaf_m.gcafmodid_desc,g_gcaf_m.gcafmoddt,g_gcaf_m.gcafcnfid,g_gcaf_m.gcafcnfid_desc,g_gcaf_m.gcafcnfdt, 
          g_gcaf_m.gcaf027,g_gcaf_m.gcaf028,g_gcaf_m.gcaf029,g_gcaf_m.gcaf030
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
                  IF NOT l_success THEN
      CALL s_transaction_end('N','0')
   ELSE      
      CALL s_transaction_end('Y','0')
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
                  CALL agcm300_fetch('')
   #end add-point  
 
   CLOSE agcm300_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agcm300_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agcm300.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION agcm300_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
               
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_gcag_d.getLength() THEN
         LET g_detail_idx = g_gcag_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gcag_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gcag_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_gcag2_d.getLength() THEN
         LET g_detail_idx = g_gcag2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gcag2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gcag2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_gcag3_d.getLength() THEN
         LET g_detail_idx = g_gcag3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gcag3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gcag3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_gcag4_d.getLength() THEN
         LET g_detail_idx = g_gcag4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gcag4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gcag4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
               
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION agcm300_b_fill2(pi_idx)
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
   
   CALL agcm300_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION agcm300_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1')  AND 
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
                              
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300.status_show" >}
PRIVATE FUNCTION agcm300_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="agcm300.mask_functions" >}
&include "erp/agc/agcm300_mask.4gl"
 
{</section>}
 
{<section id="agcm300.signature" >}
   
 
{</section>}
 
{<section id="agcm300.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION agcm300_set_pk_array()
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
   LET g_pk_array[1].values = g_gcaf_m.gcaf001
   LET g_pk_array[1].column = 'gcaf001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agcm300.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="agcm300.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION agcm300_msgcentre_notify(lc_state)
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
   CALL agcm300_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gcaf_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agcm300.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION agcm300_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#14 -s by 08172
   SELECT gcafstus  INTO g_gcaf_m.gcafstus
     FROM gcaf_t
    WHERE gcafent = g_enterprise
      AND gcaf001 = g_gcaf_m.gcaf001
   LET g_errno = ''
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_gcaf_m.gcafstus
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
        LET g_errparam.extend = g_gcaf_m.gcaf001
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL agcm300_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#14 -e by 08172
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION agcm300_gcafunit_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcaf_m.gcafunit
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcaf_m.gcafunit_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcaf_m.gcafunit_desc
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcafunit_chk()
DEFINE l_cnt      LIKE type_t.num5
DEFINE l_cnt1     LIKE type_t.num5 
DEFINE l_sql      STRING

   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno = NULL
   #LET l_sql="SELECT COUNT(*)  FROM ooed_t WHERE ooed004 ='",g_gcaf_m.gcafunit,"' AND ooed001='2' ",  #160905-00007#2  mark
   LET l_sql="SELECT COUNT(1)  FROM ooed_t WHERE ooedent = ",g_enterprise," AND ooed004 ='",g_gcaf_m.gcafunit,"' AND ooed001='2' ",  #160905-00007#2 add  count(*) --> count(1)
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null) ",
             "   AND ooed004 IN ((select DISTINCT ooed004 FROM ooed_t START WITH ooed005='",g_site,"' CONNECT BY  NOCYCLE PRIOR ooed004=ooed005 AND ooed001='2' ",
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null))",
             "          UNION ",
             #"         (SELECT ooed004 FROM ooed_t WHERE ooed004='",g_site,"'))"   #160905-00007#2  mark
             "         (SELECT ooed004 FROM ooed_t WHERE ooedent = ",g_enterprise," AND ooed004='",g_site,"'))"   #160905-00007#2 add
   PREPARE agct300_sql_ooea_pre1 FROM l_sql
   EXECUTE agct300_sql_ooea_pre1 INTO l_cnt   
   IF l_cnt <= 0 THEN
      LET g_errno = "aoo-00163"
   ELSE
      #LET l_sql="SELECT COUNT(*)  FROM ooed_t,ooea_t WHERE ooea001=ooed004 AND ooed004 ='",g_gcaf_m.gcafunit,"' AND ooed001='2' AND ooeastus='Y' ",      #160905-00007#2  mark  
      LET l_sql="SELECT COUNT(1)  FROM ooed_t,ooea_t WHERE ooedent=ooeaent AND ooedent = ",g_enterprise," AND  ooea001=ooed004 AND ooed004 ='",g_gcaf_m.gcafunit,"' AND ooed001='2' AND ooeastus='Y' ",   #160905-00007#2 add count(*) --> count(1)    
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null)",
             "   AND ooea001 IN ((select DISTINCT ooed004 FROM ooed_t START WITH ooed005='",g_site,"' CONNECT BY  NOCYCLE PRIOR ooed004=ooed005 AND ooed001='2' ",
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null))",
             "          UNION ",
             #"         (SELECT ooea001 FROM ooea_t WHERE ooea001='",g_site,"'))"   #160905-00007#2  mark
             "         (SELECT ooea001 FROM ooea_t WHERE ooeaent = ",g_enterprise," AND ooea001='",g_site,"'))"   #160905-00007#2 add
      PREPARE agct300_sql_ooea_pre2 FROM l_sql
      EXECUTE agct300_sql_ooea_pre2 INTO l_cnt1       
      IF l_cnt1 <= 0 THEN
         LET g_errno = 'sub-01302'   #"amm-00007" #160318-00005#12 mod 
      END IF         
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf007_chk()
DEFINE l_str   STRING

   INITIALIZE g_errno TO NULL
   IF NOT cl_null(g_gcaf_m.gcaf006) THEN
      IF g_gcaf_m.gcaf007 > g_gcaf_m.gcaf006 THEN
         LET g_errno = 'agc-00007' #券号固定代码长度必须小于等于券号总码长
         RETURN
      END IF
   END IF
   IF NOT cl_null(g_gcaf_m.gcaf008) THEN
      LET l_str = g_gcaf_m.gcaf008
      IF g_gcaf_m.gcaf007 != l_str.getLength() THEN
         LET g_errno = 'agc-00008' #券号固定代码字元长度必须等于券号固定代码长度
         RETURN
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf008_chk()
DEFINE l_str   STRING

   INITIALIZE g_errno TO NULL
   IF NOT cl_null(g_gcaf_m.gcaf007) THEN
      LET l_str = g_gcaf_m.gcaf008
      IF g_gcaf_m.gcaf007 != l_str.getLength() THEN
         LET g_errno = 'agc-00008' #券号固定代码字元长度必须等于券号固定代码长度
         RETURN
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf010_init()
DEFINE l_num   STRING
DEFINE l_i     LIKE type_t.num5

   IF NOT cl_null(g_gcaf_m.gcaf006) AND NOT cl_null(g_gcaf_m.gcaf007) AND 
      #NOT cl_null(g_gcaf_m.gcaf008) AND NOT cl_null(g_gcaf_m.gcaf009) THEN   #160615-00028#4 160623 by sakura mark
      NOT cl_null(g_gcaf_m.gcaf009) THEN   #160615-00028#4 160623 by sakura add
      LET l_num = '1'
      FOR l_i = 2 TO g_gcaf_m.gcaf009 
         LET l_num = '0',l_num
      END FOR
      IF g_gcaf_m.gcaf009 = 0 THEN
         LET g_gcaf_m.gcaf010 = g_gcaf_m.gcaf008
      ELSE
         #160615-00028#4 160623 by sakura add(S)
         IF cl_null(g_gcaf_m.gcaf008) THEN
            LET g_gcaf_m.gcaf010 = l_num
         ELSE
         #160615-00028#4 160623 by sakura add(E)      
            LET g_gcaf_m.gcaf010 = g_gcaf_m.gcaf008,l_num
         END IF   #160615-00028#4 160623 by sakura add
      END IF
      LET g_gcaf_m.gcaf011 = g_gcaf_m.gcaf010
      DISPLAY BY NAME g_gcaf_m.gcaf010,g_gcaf_m.gcaf011
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf010_chk(p_gcaf010)
DEFINE p_gcaf010   LIKE gcaf_t.gcaf010
DEFINE l_str       STRING
DEFINE l_num       STRING
   
   INITIALIZE g_errno TO NULL
   
   IF NOT cl_null(g_gcaf_m.gcaf006) AND NOT cl_null(g_gcaf_m.gcaf007) AND 
      NOT cl_null(g_gcaf_m.gcaf008) AND NOT cl_null(g_gcaf_m.gcaf009) THEN
      LET l_str = p_gcaf010
      IF g_gcaf_m.gcaf006 != l_str.getLength() THEN
         LET g_errno = 'agc-00009' #该券号不符合当前券种编码规则
         RETURN
      END IF
      IF g_gcaf_m.gcaf008 != l_str.subString(1,g_gcaf_m.gcaf007) THEN
         LET g_errno = 'agc-00009' #该券号不符合当前券种编码规则
         RETURN
      END IF
      IF g_gcaf_m.gcaf009 > 0 THEN
         IF NOT s_chr_alphanumeric(l_str.subString(g_gcaf_m.gcaf007+1,l_str.getLength()),1) THEN
            LET g_errno = 'agc-00009' #该券号不符合当前券种编码规则
            RETURN
         END IF
      END IF
   END IF
   IF NOT cl_null(g_gcaf_m.gcaf010) AND NOT cl_null(g_gcaf_m.gcaf011) THEN
      IF g_gcaf_m.gcaf010 > g_gcaf_m.gcaf011 THEN
         LET g_errno = 'agc-00010' #开始券号不可大于结束券号
         RETURN
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf012_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcaf_m.gcaf012
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2071' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcaf_m.gcaf012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcaf_m.gcaf012_desc
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf012_chk()
DEFINE l_oocqstus   LIKE oocq_t.oocqstus
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_oocq019    LIKE oocq_t.oocq019

   INITIALIZE g_errno TO NULL
   SELECT oocqstus,oocq019 INTO l_oocqstus,l_oocq019
     FROM oocq_t
    WHERE oocqent = g_enterprise AND oocq001 = '2071' AND oocq002 = g_gcaf_m.gcaf012
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'agc-00011' #该券面额编号不存在
      WHEN l_oocqstus <> 'Y'   LET g_errno = 'agc-00012' #该券面额编号已无效
      WHEN cl_null(l_oocq019) OR l_oocq019 <> '40' LET g_errno = 'agc-00089' #该面额编号非券面额编号
   END CASE
   
   IF cl_null(g_errno) AND NOT cl_null(g_gcaf_m_t.gcaf012) THEN
      SELECT COUNT(1) INTO l_cnt  #160905-00007#2 count(*) --> count(1)
        FROM gcas_t
       WHERE gcasent = g_enterprise AND gcas001 = g_gcaf_m.gcaf001 AND gcas002 = g_gcaf_m_t.gcaf012
      IF l_cnt > 0 THEN
         LET g_errno = 'agc-00057'   #該券面額編號已在提貨商品設定中使用，不可異動或刪除
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf013_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcaf_m.gcaf013
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcaf_m.gcaf013_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcaf_m.gcaf013_desc
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf013_chk()
DEFINE l_rtdxstus   LIKE rtdx_t.rtdxstus

   INITIALIZE g_errno TO NULL
   SELECT rtdxstus INTO l_rtdxstus
     FROM rtdx_t
    WHERE rtdxent = g_enterprise AND rtdxsite = g_gcaf_m.gcafunit AND rtdx001 = g_gcaf_m.gcaf013
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'agc-00013' #该商品不存在或在当前组织不可使用
      WHEN l_rtdxstus <> 'Y'   LET g_errno = 'agc-00014' #该商品在当前组织已无效
   END CASE
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf017_chk()
DEFINE l_success    LIKE type_t.num5

   LET l_success = TRUE
   INITIALIZE g_errno TO NULL

   #规则 --当[效期控管起算基准gcaf017]为0.无时，[有效期至gcaf018]必须为1.指定日期
   #故若[有效期至gcaf018]为1.指定日期且[效期指定日期]不为空，则[效期控管起算基准gcaf017]更改时要询问是否清空原先设定
   IF g_gcaf_m.gcaf017 <> '0' THEN
      IF NOT cl_null(g_gcaf_m.gcaf019) THEN
         IF NOT cl_ask_confirm('agc-00015') THEN #已设定效期指定日期，是否清空？(Y/N)
            LET l_success = FALSE
            RETURN l_success
         END IF
      END IF
      LET g_gcaf_m.gcaf018 = '2'
      LET g_gcaf_m.gcaf019 = ''
      DISPLAY BY NAME g_gcaf_m.gcaf018,g_gcaf_m.gcaf019
   END IF
   
   #规则 --当[效期控管起算基准gcaf017]为0.无时，[有效期至gcaf018]必须为1.指定日期
   #故若[有效期至gcaf018]为2.指定月份長度或3.指定天數長度，且[效期指定长度]不为空，则[效期控管起算基准gcaf017]更改时要询问是否清空原先设定
   IF g_gcaf_m.gcaf017 = '0' THEN
      IF NOT cl_null(g_gcaf_m.gcaf020) THEN
         IF NOT cl_ask_confirm('agc-00016') THEN #已设定效期指定长度，是否清空？(Y/N)
            LET l_success = FALSE
            RETURN l_success
         END IF
      END IF
      LET g_gcaf_m.gcaf018 = '1'
      LET g_gcaf_m.gcaf020 = ''
      DISPLAY BY NAME g_gcaf_m.gcaf018,g_gcaf_m.gcaf020
   END IF
   
   RETURN l_success
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf018_chk()
   
   INITIALIZE g_errno TO NULL
   
   IF NOT cl_null(g_gcaf_m.gcaf017) THEN
      IF g_gcaf_m.gcaf018 <> '1' THEN
         IF g_gcaf_m.gcaf017 = '0' THEN
            LET g_errno = 'agc-00017' #當[C:效期控管起算基準gcaf017]='0.(無)'時則[C:有效期至gcaf018]必須='1.指定日期'
            RETURN
         END IF
         LET g_gcaf_m.gcaf019 = ''
         DISPLAY BY NAME g_gcaf_m.gcaf019
      END IF
      IF g_gcaf_m.gcaf018 = '1' THEN
         IF g_gcaf_m.gcaf017 <> '0' THEN
            LET g_errno = 'agc-00018' #當[C:有效期至gcaf018]='1.指定日期'時,則[C:效期控管起算基準gcaf017]必須='0.(無)'
            RETURN
         END IF
         LET g_gcaf_m.gcaf020 = ''
         DISPLAY BY NAME g_gcaf_m.gcaf020
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf006_chk()
   
   INITIALIZE g_errno TO NULL
   IF NOT cl_null(g_gcaf_m.gcaf007) THEN
      IF g_gcaf_m.gcaf006 < g_gcaf_m.gcaf007 THEN
         LET g_errno = 'agc-00007' #
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf009_init()
   
   IF NOT cl_null(g_gcaf_m.gcaf006) AND NOT cl_null(g_gcaf_m.gcaf007) THEN
      LET g_gcaf_m.gcaf009 = g_gcaf_m.gcaf006 - g_gcaf_m.gcaf007
      DISPLAY BY NAME g_gcaf_m.gcaf009
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf015_chk()
   
   INITIALIZE g_errno TO NULL
   IF NOT cl_null(g_gcaf_m.gcaf003) AND NOT cl_null(g_gcaf_m.gcaf006) AND 
      NOT cl_null(g_gcaf_m.gcaf007) AND NOT cl_null(g_gcaf_m.gcaf015) THEN
      IF g_gcaf_m.gcaf003 = '4' AND g_gcaf_m.gcaf015 = 'N' AND g_gcaf_m.gcaf006 != g_gcaf_m.gcaf007 THEN
         LET g_errno = 'agc-00022' #当[券种类别]为'4.折价券'且[需产生券号明细资讯]为'N'时,[券代号总码长]必须=[券号固定代码长度]
         RETURN
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf030_chk()
   
   INITIALIZE g_errno TO NULL
   IF NOT cl_null(g_gcaf_m.gcaf029) THEN
      IF g_gcaf_m.gcaf029 = '0' AND g_gcaf_m.gcaf030 <> '0' THEN
         LET g_errno = 'agc-00023' #當[折價券收券比例條件gcaf029]='0.無'時則[額滿/量滿gcaf030]必須='0.無'
      END IF
      #add by geza 20150818(S)
      IF g_gcaf_m.gcaf029 <> '0' AND g_gcaf_m.gcaf030 = '0' THEN
         LET g_errno = 'agc-00117' #當[折價券收券比例條件gcaa029]<>'0.無'時則[額滿/量滿gcaa030]必須<>'0.無'
      END IF
      #add by geza 20150818(E)
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcag002_init()
   
   SELECT MAX(gcag002) + 1 INTO g_gcag_d[l_ac].gcag002
     FROM gcag_t
    WHERE gcagent = g_enterprise AND gcag001 = g_gcaf_m.gcaf001
   IF cl_null(g_gcag_d[l_ac].gcag002) OR g_gcag_d[l_ac].gcag002 = 0 THEN
      LET g_gcag_d[l_ac].gcag002 = 1
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcag005_chk()
   
   INITIALIZE g_errno TO NULL
   IF NOT cl_null(g_gcag_d[l_ac].gcag005) AND NOT cl_null(g_gcag_d[l_ac].gcag006) THEN
      IF g_gcag_d[l_ac].gcag005 > g_gcag_d[l_ac].gcag006 THEN
         LET g_errno = 'agc-00025' #[單位收券金額gcag005]必須<=[收券金額上限gcag006]
         RETURN
      END IF
      IF g_gcag_d[l_ac].gcag006 MOD g_gcag_d[l_ac].gcag005 > 0 THEN
         LET g_errno = 'agc-00026' #[收券金額上限gcag006]必須為[單位收券金額gcag005]的整數倍
         RETURN
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_set_combo()
DEFINE l_values   STRING
DEFINE l_items    STRING
DEFINE l_gzcb002  LIKE gzcb_t.gzcb002
DEFINE l_gzcbl004 LIKE gzcbl_t.gzcbl004

   LET l_values = NULL
   LET l_items = NULL
   LET l_gzcb002 = NULL
   LET l_gzcbl004 = NULL
   DECLARE agcm300_gzcb_cs1 CURSOR FOR
    SELECT gzcb002,gzcbl004 FROM gzcb_t,gzcbl_t
     WHERE gzcb001 = gzcbl001 AND gzcb002 = gzcbl002
       AND gzcb001 = '6517'   AND gzcbl003 = g_dlang
       AND gzcb002 IN ('4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L')
     ORDER BY gzcb001
   FOREACH agcm300_gzcb_cs1 INTO l_gzcb002,l_gzcbl004
      LET l_values = l_values CLIPPED ,",",l_gzcb002
      LET l_items  = l_items CLIPPED ,",",l_gzcb002 CLIPPED,':',l_gzcbl004
   END FOREACH
   CALL cl_set_combo_items("b_gcah002",l_values,l_items)
   CALL cl_set_combo_items("gcah002",l_values,l_items)
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcah003_chk()
DEFINE l_rtax005   LIKE rtax_t.rtax005
DEFINE l_stus      LIKE type_t.chr1
DEFINE l_oocq001   LIKE oocq_t.oocq001
DEFINE l_success   LIKE type_t.num5

   INITIALIZE g_errno TO NULL
   LET l_success = TRUE
   IF cl_null(g_gcag2_d[l_ac].gcah002) THEN
      RETURN l_success
   END IF
   CASE g_gcag2_d[l_ac].gcah002
      WHEN '4'
         SELECT rtdxstus INTO l_stus
           FROM rtdx_t
          WHERE rtdxent = g_enterprise AND rtdxsite = g_gcaf_m.gcafunit AND rtdx001 = g_gcag2_d[l_ac].gcah003
         CASE
            WHEN SQLCA.sqlcode = 100 LET g_errno = 'agc-00013' #该商品不存在或在当前组织不可使用
            WHEN l_stus <> 'Y'       LET g_errno = 'agc-00014' #该商品在当前组织已无效
         END CASE
      WHEN '5'
         SELECT rtax005,rtaxstus INTO l_rtax005,l_stus
           FROM rtax_t
          WHERE rtaxent = g_enterprise AND rtax001 = g_gcag2_d[l_ac].gcah003
         CASE
            WHEN SQLCA.sqlcode = 100 LET g_errno = 'agc-00027' #该品类编号不存在
            WHEN l_stus <> 'Y'       LET g_errno = 'agc-00028' #该品类编号已无效
            WHEN l_rtax005 <> 0      LET g_errno = 'agc-00029' #该品类编号存在下级品类
         END CASE
      WHEN '6'
         LET l_oocq001 = '2000'
      WHEN '7'
         LET l_oocq001 = '2001'
      WHEN '8'
         LET l_oocq001 = '2002'
      WHEN '9'
         LET l_oocq001 = '2003'
      WHEN 'A'
         LET l_oocq001 = '2004'
      WHEN 'B'
         LET l_oocq001 = '2005'
      WHEN 'C'
         LET l_oocq001 = '2006'
      WHEN 'D'
         LET l_oocq001 = '2007'
      WHEN 'E'
         LET l_oocq001 = '2008'
      WHEN 'F'
         LET l_oocq001 = '2009'
      WHEN 'G'
         LET l_oocq001 = '2010'
      WHEN 'H'
         LET l_oocq001 = '2011'
      WHEN 'I'
         LET l_oocq001 = '2012'
      WHEN 'J'
         LET l_oocq001 = '2013'
      WHEN 'K'
         LET l_oocq001 = '2014'
      WHEN 'L'
         LET l_oocq001 = '2015'
   END CASE
   CASE g_gcag2_d[l_ac].gcah002
      WHEN '4'
         IF NOT cl_null(g_errno) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_gcag2_d[l_ac].gcah003
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET l_success = FALSE
            RETURN l_success
         END IF
      WHEN '5'
         IF NOT cl_null(g_errno) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_gcag2_d[l_ac].gcah003
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET l_success = FALSE
            RETURN l_success
         END IF
      OTHERWISE
         SELECT oocqstus INTO l_stus
           FROM oocq_t
          WHERE oocqent = g_enterprise AND oocq001 = l_oocq001 AND oocq002 = g_gcag2_d[l_ac].gcah003
         CASE
            WHEN SQLCA.sqlcode = 100 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00013'
               LET g_errparam.extend = g_gcag2_d[l_ac].gcah003
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = l_oocq001
               CALL cl_err()

               LET l_success = FALSE
               RETURN l_success
            WHEN l_stus <> 'Y'
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00014'
               LET g_errparam.extend = g_gcag2_d[l_ac].gcah003
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = l_oocq001
               CALL cl_err()

               LET l_success = FALSE
               RETURN l_success
         END CASE
   END CASE
   RETURN l_success
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcah003_ref()
DEFINE l_oocq001   LIKE oocq_t.oocq001

   IF cl_null(g_gcag2_d[l_ac].gcah002) THEN
      RETURN
   END IF
   CASE g_gcag2_d[l_ac].gcah002
      WHEN '6'
         LET l_oocq001 = '2000'
      WHEN '7'
         LET l_oocq001 = '2001'
      WHEN '8'
         LET l_oocq001 = '2002'
      WHEN '9'
         LET l_oocq001 = '2003'
      WHEN 'A'
         LET l_oocq001 = '2004'
      WHEN 'B'
         LET l_oocq001 = '2005'
      WHEN 'C'
         LET l_oocq001 = '2006'
      WHEN 'D'
         LET l_oocq001 = '2007'
      WHEN 'E'
         LET l_oocq001 = '2008'
      WHEN 'F'
         LET l_oocq001 = '2009'
      WHEN 'G'
         LET l_oocq001 = '2010'
      WHEN 'H'
         LET l_oocq001 = '2011'
      WHEN 'I'
         LET l_oocq001 = '2012'
      WHEN 'J'
         LET l_oocq001 = '2013'
      WHEN 'K'
         LET l_oocq001 = '2014'
      WHEN 'L'
         LET l_oocq001 = '2015'
   END CASE
   CASE g_gcag2_d[l_ac].gcah002
      WHEN '4'
         SELECT imaal003 INTO g_gcag2_d[l_ac].gcah003_desc
           FROM imaal_t
          WHERE imaalent = g_enterprise AND imaal001 = g_gcag2_d[l_ac].gcah003 AND imaal002 = g_dlang
      WHEN '5'
         SELECT rtaxl003 INTO g_gcag2_d[l_ac].gcah003_desc
           FROM rtaxl_t
          WHERE rtaxlent = g_enterprise AND rtaxl001 = g_gcag2_d[l_ac].gcah003 AND rtaxl002 = g_dlang
      OTHERWISE
         SELECT oocql004 INTO g_gcag2_d[l_ac].gcah003_desc
           FROM oocql_t
          WHERE oocqlent = g_enterprise AND oocql001 = l_oocq001 AND oocql002 = g_gcag2_d[l_ac].gcah003 AND oocql003 = g_dlang
   END CASE
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcah003_ctp()
   
   CASE g_gcag2_d[l_ac].gcah002
      WHEN '4'
         LET g_qryparam.arg1 = g_gcaf_m.gcafunit
      WHEN '6'
         LET g_qryparam.arg1 = '2000'
      WHEN '7'
         LET g_qryparam.arg1 = '2001'
      WHEN '8'
         LET g_qryparam.arg1 = '2002'
      WHEN '9'
         LET g_qryparam.arg1 = '2003'
      WHEN 'A'
         LET g_qryparam.arg1 = '2004'
      WHEN 'B'
         LET g_qryparam.arg1 = '2005'
      WHEN 'C'
         LET g_qryparam.arg1 = '2006'
      WHEN 'D'
         LET g_qryparam.arg1 = '2007'
      WHEN 'E'
         LET g_qryparam.arg1 = '2008'
      WHEN 'F'
         LET g_qryparam.arg1 = '2009'
      WHEN 'G'
         LET g_qryparam.arg1 = '2010'
      WHEN 'H'
         LET g_qryparam.arg1 = '2011'
      WHEN 'I'
         LET g_qryparam.arg1 = '2012'
      WHEN 'J'
         LET g_qryparam.arg1 = '2013'
      WHEN 'K'
         LET g_qryparam.arg1 = '2014'
      WHEN 'L'
         LET g_qryparam.arg1 = '2015'
   END CASE
   CASE g_gcag2_d[l_ac].gcah002
      WHEN '4'
         CALL q_rtdx001_1()
      WHEN '5'
         CALL q_rtax001()
      OTHERWISE
		 LET g_qryparam.where = " oocq019 = '40' "
         CALL q_oocq002()
   END CASE
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcai002_init()
   
   SELECT MAX(gcai002) + 1 INTO g_gcag3_d[l_ac].gcai002
     FROM gcai_t
    WHERE gcaient = g_enterprise AND gcai001 = g_gcaf_m.gcaf001
   IF cl_null(g_gcag3_d[l_ac].gcai002) OR g_gcag3_d[l_ac].gcai002 = 0 THEN
      LET g_gcag3_d[l_ac].gcai002 = 1
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcai003_chk()
   
   INITIALIZE g_errno TO NULL
   IF NOT cl_null(g_gcag3_d[l_ac].gcai003) AND NOT cl_null(g_gcag3_d[l_ac].gcai004) THEN
      IF g_gcag3_d[l_ac].gcai003 > g_gcag3_d[l_ac].gcai004 THEN
         LET g_errno = 'amm-00080' #[開始日期gcai003]必須<=[結束日期gcai004]
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcai005_chk()
   
   INITIALIZE g_errno TO NULL
   IF NOT cl_null(g_gcag3_d[l_ac].gcai005) AND NOT cl_null(g_gcag3_d[l_ac].gcai006) THEN
      IF g_gcag3_d[l_ac].gcai005 > g_gcag3_d[l_ac].gcai006 THEN
         LET g_errno = 'amm-00067' #,[每日開始時間gcai005]必須<[每日結束時間gcai006]
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaj002_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcag4_d[l_ac].gcaj002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcag4_d[l_ac].gcaj002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcag4_d[l_ac].gcaj002_desc
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaj002_chk()
DEFINE l_ooea004   LIKE ooea_t.ooea004
DEFINE l_ooeastus  LIKE ooea_t.ooeastus

   INITIALIZE g_errno TO NULL
   SELECT ooea004,ooeastus INTO l_ooea004,l_ooeastus
     FROM ooea_t
    WHERE ooeaent = g_enterprise AND ooea001 = g_gcag4_d[l_ac].gcaj002
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'amm-00083' #
      WHEN l_ooeastus <> 'Y'   LET g_errno = 'amm-00084' #
      WHEN l_ooea004 <> 'Y'    LET g_errno = 'amm-00085' #
   END CASE
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf018_desc()
DEFINE l_msg   STRING

   IF NOT cl_null(g_gcaf_m.gcaf018) AND g_gcaf_m.gcaf018 != '1' THEN
      CASE g_gcaf_m.gcaf018
         WHEN '2'
            CALL cl_getmsg('aoo-00215',g_lang) RETURNING l_msg #月
         WHEN '3'
            CALL cl_getmsg('agc-00038',g_lang) RETURNING l_msg #天
      END CASE
   ELSE
      LET l_msg = ' '
   END IF
   
   CALL agcm300_set_comp_att_text("lbl_gcaf018_desc",l_msg)
END FUNCTION
#+
PRIVATE FUNCTION agcm300_set_comp_att_text(ps_fields,ps_att_value)
DEFINE   ps_fields          STRING,
         ps_att_value       STRING
DEFINE   lst_fields         base.StringTokenizer,
         lst_string         base.StringTokenizer,
         ls_field_name      STRING,
         ls_field_value     STRING,
         ls_win_name        STRING
DEFINE   lnode_root         om.DomNode,
         lnode_win          om.DomNode,
         lnode_pre          om.DomNode,
         llst_items         om.NodeList,
         lnode_list         om.NodeList,
         li_i               LIKE type_t.num5,
         lnode_item         om.DomNode,
         ls_item_name       STRING,
         lnode_item_child   om.DomNode,
         ls_item_pre_tag    STRING,
         ls_item_tag_name   STRING
DEFINE   g_chg              DYNAMIC ARRAY OF RECORD
            item            STRING,
            value           STRING
                            END RECORD
DEFINE   lwin_curr          ui.Window
DEFINE   ls_btn_name        STRING
DEFINE   l_str              STRING
DEFINE   l_cnt              SMALLINT
DEFINE   lnode_p            om.DomNode,
         ls_item_tag_name_p STRING,
         ls_item_name_p     STRING,
         ls_str_p           LIKE type_t.chr100

   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]" THEN
      RETURN
   END IF

   IF (ps_fields IS NULL) THEN
      RETURN
   ELSE
      LET ps_fields = ps_fields.toLowerCase()
   END IF

   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()
   LET ls_win_name = lnode_win.getAttribute("name")

   LET llst_items = lnode_win.selectByPath("//Form//*")
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
   LET lst_string = base.StringTokenizer.create(ps_att_value,",")
   WHILE lst_fields.hasMoreTokens() AND lst_string.hasMoreTokens()
      LET ls_field_name = lst_fields.nextToken()
      LET ls_field_value = lst_string.nextToken()
      LET ls_field_name = ls_field_name.trim()

      IF ls_field_name.equals(ls_win_name) THEN
         CALL lnode_win.setAttribute("text",ls_field_value)
      END IF

      FOR li_i = 1 TO llst_items.getLength()
         LET lnode_item = llst_items.item(li_i)
         LET ls_item_name = lnode_item.getAttribute("colName")

         IF (ls_item_name IS NULL) THEN
            LET ls_item_name = lnode_item.getAttribute("name")

            LET ls_item_tag_name = lnode_item.getTagName()
            IF ls_item_tag_name.equals("Item") THEN
               IF (ls_item_name IS NOT NULL) THEN
                  LET lnode_p = lnode_item.getParent()   #取父結點
                  LET ls_item_tag_name_p = lnode_p.getTagName()   #父結點類型
                  IF ls_item_tag_name_p.equals("RadioGroup") OR ls_item_tag_name_p.equals("ComboBox") THEN
                     LET ls_item_name_p = lnode_p.getAttribute("comment")  #取comment因為裡面一定會有[***]
                     LET ls_str_p = ls_item_name_p
                     #取[]之間的東西
                     select substr(ls_str_p,instr(ls_str_p,'[',1)+1,length(ls_str_p)-instr(ls_str_p,'[',1)-1) INTO ls_str_p from dual
                     LET ls_item_name = ls_str_p CLIPPED || '_' || ls_item_name
                  END IF
               END IF
            END IF

            IF (ls_item_name IS NULL) THEN
               CONTINUE FOR
            END IF
         END IF

         IF (ls_item_name.equals(ls_field_name)) THEN
            LET ls_item_tag_name = lnode_item.getTagName()
            LET lnode_list = lnode_item.selectByTagName("CheckBox")
            LET l_cnt = lnode_list.getlength()
            IF ls_item_tag_name.equals("TableColumn") OR
               ls_item_tag_name.equals("Page") OR
               ls_item_tag_name.equals("Item") OR
               ls_item_tag_name.equals("Group") OR
               ls_item_tag_name.equals("Label") OR
               ls_item_tag_name.equals("Window")OR
               ls_item_tag_name.equals("Button") THEN
               CALL lnode_item.setAttribute("text",ls_field_value.trim())
            ELSE
               IF l_cnt > 0 THEN
                  LET lnode_item_child = lnode_item.getFirstChild()
                  CALL lnode_item_child.setAttribute("text",ls_field_value.trim())
               ELSE
                  LET lnode_pre = lnode_item.getPrevious()
                  LET ls_item_pre_tag = lnode_pre.getTagName()
                  IF ls_item_pre_tag.equals("Label") THEN
                     CALL lnode_pre.setAttribute("text",ls_field_value.trim())
                  ELSE
                     IF ls_item_pre_tag.equals("Button") THEN
                        LET ls_btn_name = lnode_pre.getAttribute("name")
                        IF ls_btn_name.subString(1,4) = "btn_" THEN
                           LET lnode_pre = lnode_pre.getPrevious()
                           LET ls_item_pre_tag = lnode_pre.getTagName()
                           IF ls_item_pre_tag.equals("Label") THEN
                              CALL lnode_pre.setAttribute("text",ls_field_value.trim())
                           END IF
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            EXIT FOR
         END IF
      END FOR
   END WHILE
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf003_chk(p_cmd)
DEFINE p_cmd      LIKE type_t.chr1  #a.AFTER FIELD d.delete
DEFINE l_cnt      LIKE type_t.num5
DEFINE l_cnt2     LIKE type_t.num5
DEFINE r_success  LIKE type_t.num5

   LET l_cnt = 0
   LET l_cnt2= 0
   LET r_success = TRUE #无需控管
   IF g_gcaf_m.gcaf003 <> '3' AND g_gcaf_m_t.gcaf003 = '3' AND NOT cl_null(g_gcaf_m.gcaf001) THEN
      SELECT COUNT(1) INTO l_cnt    #160905-00007#2 count(*) --> count(1)
        FROM gcas_t
       WHERE gcasent = g_enterprise AND gcas001 = g_gcaf_m.gcaf001
      IF l_cnt > 0 THEN
         CASE p_cmd
            WHEN 'a'
               IF NOT cl_ask_confirm('agc-00049') THEN #已存在提货商品设置资料,若修改则会删除对应资料!是否修改？(Y/N)
                  LET r_success = FALSE #用户不删除资料，控管
               ELSE
                  LET r_success = TRUE  #无需控管
               END IF
               RETURN r_success
            WHEN 'd'
               DELETE FROM gcas_t WHERE gcasent = g_enterprise AND gcas001 = g_gcaf_m.gcaf001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'del gcas_t'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE #删除报错，控管
                  RETURN r_success
               END IF
         END CASE
      END IF
   END IF
   IF g_gcaf_m.gcaf003 <> '4' AND g_gcaf_m_t.gcaf003 = '4' AND NOT cl_null(g_gcaf_m.gcaf001) THEN
      SELECT COUNT(1) INTO l_cnt   #160905-00007#2 count(*) --> count(1)
        FROM gcag_t
       WHERE gcagent = g_enterprise AND gcag001 = g_gcaf_m.gcaf001
      SELECT COUNT(1) INTO l_cnt2   #160905-00007#2 count(*) --> count(1)
        FROM gcah_t
       WHERE gcahent = g_enterprise AND gcah001 = g_gcaf_m.gcaf001
      IF l_cnt > 0 OR l_cnt2 > 0 THEN
         CASE p_cmd
            WHEN 'a'
               IF NOT cl_ask_confirm('agc-00054') THEN #已存在折价券限定资料,若修改则会删除对应资料!是否修改？(Y/N)
                  LET r_success = FALSE #用户不删除资料，控管
               ELSE
                  LET r_success = TRUE  #无需控管
               END IF
               RETURN r_success
            WHEN 'd'
               DELETE FROM gcag_t WHERE gcagent = g_enterprise AND gcag001 = g_gcaf_m.gcaf001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'del gcag_t'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE #删除报错，控管
                  RETURN r_success
               END IF
               DELETE FROM gcah_t WHERE gcahent = g_enterprise AND gcah001 = g_gcaf_m.gcaf001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'del gcah_t'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE #删除报错，控管
                  RETURN r_success
               END IF
         END CASE
      END IF
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 顯示ooia001的說明
# Memo...........:
# Usage..........: CALL agcm300_gcaf031_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/02/06 By ming 
# Modify.........:
################################################################################
PUBLIC FUNCTION agcm300_gcaf031_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcaf_m.gcaf031
   CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcaf_m.gcaf031_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcaf_m.gcaf031_desc
END FUNCTION
#+
PRIVATE FUNCTION agcm300_gcaf015_init()
   
   INITIALIZE g_errno TO NULL
   IF NOT cl_null(g_gcaf_m.gcaf006) AND NOT cl_null(g_gcaf_m.gcaf007) AND NOT cl_null(g_gcaf_m.gcaf015) THEN
      IF g_gcaf_m.gcaf006 - g_gcaf_m.gcaf007 = 0 AND g_gcaf_m.gcaf015 = 'Y' THEN
         LET g_errno = 'agc-00055' #當[需产生券号明细资讯]为'Y'時,券號流水碼長度必須大於0
         RETURN
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_currency_chk()
DEFINE l_cnt   LIKE type_t.num5
DEFINE l_sql   STRING
DEFINE l_ooie002   LIKE ooie_t.ooie002
   INITIALIZE g_errno TO NULL
   
   CASE
      WHEN INFIELD(gcaf012)
         #检查发型面额中是否存在不相同币别的面额
         LET l_cnt = 0
         SELECT COUNT(DISTINCT oocq004) INTO l_cnt
           FROM oocq_t
          WHERE oocqent = g_enterprise AND oocq001 = '2071' 
            AND (oocq002 IN (SELECT gcar002
                               FROM gcar_t
                              WHERE gcarent = g_enterprise AND gcar001 = g_gcaf_m.gcaf001 AND gcar002 != g_gcaf_m_t.gcaf012)
             OR oocq002 = g_gcaf_m.gcaf012)
         IF l_cnt > 1 THEN
            LET g_errno = 'agc-00084' #发行面额中存在不同币别的面额编号,请检查
            RETURN
         END IF
         
         #检查和款别的面额是否一致
         IF cl_null(g_gcaf_m.gcaf031) THEN RETURN END IF
         LET l_cnt = 0
#         LET l_sql = "SELECT COUNT(DISTINCT ooie002) ",
#                     "  FROM ( ",
#                     "        SELECT ooie002 ",
#                     "          FROM ooie_t ",
#                     "         WHERE ooieent = '",g_enterprise,"' ",
#                     "           AND ooiesite = '",g_gcaf_m.gcafunit,"' AND ooie001 = '",g_gcaf_m.gcaf031,"' ",
#                     "        UNION ALL ",
#                     "        SELECT oocq004 ",
#                     "          FROM oocq_t ",
#                     "         WHERE oocqent = '",g_enterprise,"' AND oocq001 = '2071' ",
#                     "           AND oocq002 = '",g_gcaf_m.gcaf012,"' ",
#                     "        ) "
#         PREPARE agcm300_currency_chk_pre1 FROM l_sql
#         EXECUTE agcm300_currency_chk_pre1 INTO l_cnt
#         IF l_cnt > 1 THEN
#            LET g_errno = 'agc-00085' #当前面额的币别与对应款别的币别不一致,请检查
#            RETURN
#         END IF
         CALL s_money_ooie_get('','ooie002',g_gcaf_m.gcafunit,g_gcaf_m.gcaf031) RETURNING l_ooie002
         IF NOT cl_null(g_errno) THEN 
            RETURN 
         END IF          
         SELECT COUNT(1) INTO l_cnt    #160905-00007#2 count(*) --> count(1)
           FROM  oocq_t
          WHERE oocqent = g_enterprise
            AND oocq001 = '2071' 
            AND oocq002 = g_gcaf_m.gcaf012
            AND oocq004 <> l_ooie002
         IF l_cnt > 0 THEN
            LET g_errno = 'agc-00085' #当前面额的币别与对应款别的币别不一致,请检查
            RETURN
         END IF
      WHEN INFIELD(gcaf031)
         #检查和面额的币别是否一致
         IF cl_null(g_gcaf_m.gcaf012) THEN RETURN END IF
         LET l_cnt = 0
#         LET l_sql = "SELECT COUNT(DISTINCT ooie002) ",
#                     "  FROM ( ",
#                     "        SELECT ooie002 ",
#                     "          FROM ooie_t ",
#                     "         WHERE ooieent = '",g_enterprise,"' ",
#                     "           AND ooiesite = '",g_gcaf_m.gcafunit,"' AND ooie001 = '",g_gcaf_m.gcaf031,"' ",
#                     "        UNION ALL ",
#                     "        SELECT oocq004 ",
#                     "          FROM oocq_t ",
#                     "         WHERE oocqent = '",g_enterprise,"' AND oocq001 = '2071' ",
#                     "           AND oocq002 = '",g_gcaf_m.gcaf012,"' ",
#                     "        ) "
#         PREPARE agcm300_currency_chk_pre2 FROM l_sql
#         EXECUTE agcm300_currency_chk_pre2 INTO l_cnt
#         IF l_cnt > 1 THEN
#            LET g_errno = 'agc-00086' #当前款别的币别与面额对应的币别不一致,请检查
#            RETURN
#         END IF
         CALL s_money_ooie_get('','ooie002',g_gcaf_m.gcafunit,g_gcaf_m.gcaf031) RETURNING l_ooie002
         IF NOT cl_null(g_errno) THEN 
            RETURN 
         END IF   
         SELECT COUNT(1) INTO l_cnt    #160905-00007#2 count(*) --> count(1)
           FROM  oocq_t
          WHERE oocqent = g_enterprise
            AND oocq001 = '2071' 
            AND oocq002 = g_gcaf_m.gcaf012
            AND oocq004 <> l_ooie002
         IF l_cnt > 0 THEN
            LET g_errno = 'agc-00086' #当前面额的币别与对应款别的币别不一致,请检查
            RETURN
         END IF
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 获取券消费认列方式
# 传入参数       ： p_gcaf031   款别编号
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016-04-06 by lanjj
# Modify.........:
################################################################################
PRIVATE FUNCTION agcm300_get_gcaf040(p_gcaf031)
DEFINE   l_gcaf040      LIKE gcaf_t.gcaf040
DEFINE   l_rtaa001      LIKE rtaa_t.rtaa001
DEFINE   p_gcaf031      LIKE gcaf_t.gcaf031

 #取所属据点的默认券消费认列方式
 SELECT ooie032 INTO l_gcaf040
   FROM ooie_t
  WHERE ooieent = g_enterprise
    AND ooiesite = g_gcaf_m.gcafunit
    AND ooie001 = p_gcaf031
 #若取不到，取所属店群的默认券消费认列方式
 IF cl_null(l_gcaf040) THEN 
    SELECT DISTINCT rtaa001
      INTO l_rtaa001
      FROM rtak_t,rtab_t,rtaa_t 
      LEFT JOIN rtaal_t ON rtaaent = rtaalent AND rtaa001 = rtaal001 AND rtaal002 = g_lang
     WHERE rtaaent = g_enterprise
       AND rtaa001 = rtab001
       AND rtabent = rtaaent
       AND rtab002 = g_gcaf_m.gcafunit
       AND rtakent = rtaaent
       AND rtak001 = rtaa001
       AND rtak002 ='5'
       AND rtak003 ='Y'
       AND rtaastus = 'Y'
       
    SELECT ooif032 INTO l_gcaf040
      FROM ooif_t
     WHERE ooifent = g_enterprise
       AND ooif000 = l_rtaa001
       AND ooif001 = p_gcaf031
    #若再取不到，取企业层级的默认券消费认列方式
    IF cl_null(l_gcaf040) THEN 
       SELECT ooia039 INTO l_gcaf040
         FROM ooia_t
        WHERE ooiaent = g_enterprise
          AND ooia001 = p_gcaf031
       #若还是取不到，取aoos010企业参数
       IF cl_null(l_gcaf040) THEN 
          LET l_gcaf040 = cl_get_para(g_enterprise,"","E-CIR-0059")
       END IF
    END IF
 END IF

 DISPLAY l_gcaf040 TO gcaf040
 RETURN l_gcaf040

END FUNCTION

 
{</section>}
 
