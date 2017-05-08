#該程式未解開Section, 採用最新樣板產出!
{<section id="aprm551.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2015-10-16 19:37:32), PR版次:0011(2017-02-06 11:02:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000136
#+ Filename...: aprm551
#+ Description: 促銷規則主檔維護作業
#+ Creator....: 02296(2014-06-06 00:00:00)
#+ Modifier...: 02003 -SD/PR- 06814
 
{</section>}
 
{<section id="aprm551.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00005#39   2016/03/30   By 07900    重复错误讯息修改
#160318-00025#15   2016/04/06   BY 07900    重复错误讯息的修改
#161024-00025#3    2016/10/26   By dongsz   prdlunit查询开窗替换q_ooef001_24 where ooef201 = 'Y' 
#161111-00028#2    2016/11/11   BY 02481    标准程式定义采用宣告模式,弃用.*写法
#170203-00002#9    2017/02/06   By 06814    新舊值寫法調整
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
PRIVATE type type_g_prdl_m        RECORD
       prdlunit LIKE prdl_t.prdlunit, 
   prdlunit_desc LIKE type_t.chr80, 
   prdl001 LIKE prdl_t.prdl001, 
   prdl002 LIKE prdl_t.prdl002, 
   prdll003 LIKE prdll_t.prdll003, 
   prdl006 LIKE prdl_t.prdl006, 
   prdl006_desc LIKE type_t.chr80, 
   prdl007 LIKE prdl_t.prdl007, 
   prdl007_desc LIKE type_t.chr80, 
   prdl027 LIKE prdl_t.prdl027, 
   prdl099 LIKE prdl_t.prdl099, 
   prdl100 LIKE prdl_t.prdl100, 
   prdlstus LIKE prdl_t.prdlstus, 
   prdl004 LIKE prdl_t.prdl004, 
   prdl004_desc LIKE type_t.chr80, 
   prdl005 LIKE prdl_t.prdl005, 
   prdl005_desc LIKE type_t.chr80, 
   prdlsite LIKE prdl_t.prdlsite, 
   prdl003 LIKE prdl_t.prdl003, 
   prdl012 LIKE prdl_t.prdl012, 
   prdl010 LIKE prdl_t.prdl010, 
   prdl013 LIKE prdl_t.prdl013, 
   prdl011 LIKE prdl_t.prdl011, 
   prdl014 LIKE prdl_t.prdl014, 
   prdo003 LIKE prdo_t.prdo003, 
   prdo004 LIKE prdo_t.prdo004, 
   prdl098 LIKE prdl_t.prdl098, 
   prdl017 LIKE prdl_t.prdl017, 
   prdl020 LIKE prdl_t.prdl020, 
   prdl021 LIKE prdl_t.prdl021, 
   prdl008 LIKE prdl_t.prdl008, 
   prdl008_desc LIKE type_t.chr80, 
   prdl009 LIKE prdl_t.prdl009, 
   prdl009_desc LIKE type_t.chr80, 
   prdl022 LIKE prdl_t.prdl022, 
   prdl026 LIKE prdl_t.prdl026, 
   prdl023 LIKE prdl_t.prdl023, 
   prdl025 LIKE prdl_t.prdl025, 
   prdl028 LIKE prdl_t.prdl028, 
   prdl029 LIKE prdl_t.prdl029, 
   prdl030 LIKE prdl_t.prdl030, 
   prdl031 LIKE prdl_t.prdl031, 
   prdlcrtid LIKE prdl_t.prdlcrtid, 
   prdlcrtid_desc LIKE type_t.chr80, 
   prdlcrtdp LIKE prdl_t.prdlcrtdp, 
   prdlcrtdp_desc LIKE type_t.chr80, 
   prdlcrtdt LIKE prdl_t.prdlcrtdt, 
   prdlownid LIKE prdl_t.prdlownid, 
   prdlownid_desc LIKE type_t.chr80, 
   prdlowndp LIKE prdl_t.prdlowndp, 
   prdlowndp_desc LIKE type_t.chr80, 
   prdlmodid LIKE prdl_t.prdlmodid, 
   prdlmodid_desc LIKE type_t.chr80, 
   prdlmoddt LIKE prdl_t.prdlmoddt, 
   prdlcnfid LIKE prdl_t.prdlcnfid, 
   prdlcnfid_desc LIKE type_t.chr80, 
   prdlcnfdt LIKE prdl_t.prdlcnfdt, 
   prdl018 LIKE prdl_t.prdl018, 
   prdl032 LIKE prdl_t.prdl032, 
   prdl019 LIKE prdl_t.prdl019
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prdn_d        RECORD
       prdnstus LIKE prdn_t.prdnstus, 
   prdn002 LIKE prdn_t.prdn002, 
   prdn003 LIKE prdn_t.prdn003, 
   prdn004 LIKE prdn_t.prdn004, 
   prdn004_desc LIKE type_t.chr500, 
   prdnsite LIKE prdn_t.prdnsite, 
   prdnunit LIKE prdn_t.prdnunit
       END RECORD
PRIVATE TYPE type_g_prdn2_d RECORD
       prdsstus LIKE prds_t.prdsstus, 
   prds002 LIKE prds_t.prds002, 
   prds000 LIKE prds_t.prds000, 
   prds003 LIKE prds_t.prds003, 
   prds005 LIKE prds_t.prds005, 
   prds006 LIKE prds_t.prds006, 
   prds008 LIKE prds_t.prds008, 
   prds009 LIKE prds_t.prds009, 
   prdb005 LIKE type_t.num20_6, 
   prds010 LIKE prds_t.prds010, 
   prds011 LIKE prds_t.prds011, 
   prds012 LIKE prds_t.prds012, 
   prds013 LIKE prds_t.prds013, 
   prds004 LIKE prds_t.prds004, 
   prds007 LIKE prds_t.prds007, 
   prdssite LIKE prds_t.prdssite, 
   prdsunit LIKE prds_t.prdsunit
       END RECORD
PRIVATE TYPE type_g_prdn3_d RECORD
       prdrstus LIKE prdr_t.prdrstus, 
   prdr010 LIKE prdr_t.prdr010, 
   prdr002 LIKE prdr_t.prdr002, 
   prdr003 LIKE prdr_t.prdr003, 
   prdr004 LIKE prdr_t.prdr004, 
   prdr004_desc LIKE type_t.chr500, 
   prdr006 LIKE prdr_t.prdr006, 
   prdr006_desc LIKE type_t.chr500, 
   prdr007 LIKE prdr_t.prdr007, 
   prdr008 LIKE prdr_t.prdr008, 
   prdr009 LIKE prdr_t.prdr009, 
   prdrsite LIKE prdr_t.prdrsite, 
   prdrunit LIKE prdr_t.prdrunit, 
   prdr005 LIKE prdr_t.prdr005
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_prdlunit LIKE prdl_t.prdlunit,
   b_prdlunit_desc LIKE type_t.chr80,
      b_prdl001 LIKE prdl_t.prdl001,
      b_prdl002 LIKE prdl_t.prdl002,
      b_prdl006 LIKE prdl_t.prdl006,
   b_prdl006_desc LIKE type_t.chr80,
      b_prdl007 LIKE prdl_t.prdl007,
   b_prdl007_desc LIKE type_t.chr80,
      b_prdl027 LIKE prdl_t.prdl027
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_success             LIKE type_t.num5
#DEFINE g_prdl_m_o            type_g_prdl_m
DEFINE g_ooef004             LIKE ooef_t.ooef004
 TYPE type_g_prdn4_d RECORD
       prdvstus LIKE prdv_t.prdvstus, 
   prdu003 LIKE prdu_t.prdu003, 
   prdv003 like prdv_t.prdv003,
   prdv005 like prdv_t.prdv005,
   prdv005_desc like type_t.chr100,
   prdv007 like prdv_t.prdv007,
   prdv007_desc like type_t.chr100,
   prdv008 like prdv_t.prdv008,
   prdu005 like prdu_t.prdu005,
   prdu002 like prdu_t.prdu002
       END RECORD
 TYPE type_g_prdn5_d RECORD
       prdustus_1 LIKE prdu_t.prdustus, 
   prdu003_1 LIKE prdu_t.prdu003, 
   prdu002_1 like prdu_t.prdu002,
   prdu005_1 like prdu_t.prdu005  
       END RECORD 
 TYPE type_g_prdn6_d RECORD
       prdvstus_1 LIKE prdv_t.prdvstus, 
   prdv002_1 LIKE prdv_t.prdv002, 
   prdv003_1 like prdv_t.prdv003,
   prdv004_1 like prdv_t.prdv004,
   prdv005_1 like prdv_t.prdv005,
   prdv005_1_desc like type_t.chr100,
   prdv007_1 like prdv_t.prdv007,
   prdv007_1_desc like type_t.chr100,
   prdv008_1 like prdv_t.prdv008
       END RECORD
DEFINE g_prdn4_d   DYNAMIC ARRAY OF type_g_prdn4_d
DEFINE g_prdn4_d_t type_g_prdn4_d 
DEFINE g_prdn5_d   DYNAMIC ARRAY OF type_g_prdn5_d
DEFINE g_prdn5_d_t type_g_prdn4_d
DEFINE g_prdn6_d   DYNAMIC ARRAY OF type_g_prdn6_d
DEFINE g_prdn6_d_t type_g_prdn4_d
DEFINE l_ac4       LIKE type_t.num5
DEFINE l_ac5       LIKE type_t.num5
DEFINE l_ac6       LIKE type_t.num5
DEFINE g_wc2_table4   STRING
DEFINE g_wc2_table5   STRING
DEFINE g_wc2_table6   STRING
#end add-point
       
#模組變數(Module Variables)
DEFINE g_prdl_m          type_g_prdl_m
DEFINE g_prdl_m_t        type_g_prdl_m
DEFINE g_prdl_m_o        type_g_prdl_m
DEFINE g_prdl_m_mask_o   type_g_prdl_m #轉換遮罩前資料
DEFINE g_prdl_m_mask_n   type_g_prdl_m #轉換遮罩後資料
 
   DEFINE g_prdl001_t LIKE prdl_t.prdl001
 
 
DEFINE g_prdn_d          DYNAMIC ARRAY OF type_g_prdn_d
DEFINE g_prdn_d_t        type_g_prdn_d
DEFINE g_prdn_d_o        type_g_prdn_d
DEFINE g_prdn_d_mask_o   DYNAMIC ARRAY OF type_g_prdn_d #轉換遮罩前資料
DEFINE g_prdn_d_mask_n   DYNAMIC ARRAY OF type_g_prdn_d #轉換遮罩後資料
DEFINE g_prdn2_d          DYNAMIC ARRAY OF type_g_prdn2_d
DEFINE g_prdn2_d_t        type_g_prdn2_d
DEFINE g_prdn2_d_o        type_g_prdn2_d
DEFINE g_prdn2_d_mask_o   DYNAMIC ARRAY OF type_g_prdn2_d #轉換遮罩前資料
DEFINE g_prdn2_d_mask_n   DYNAMIC ARRAY OF type_g_prdn2_d #轉換遮罩後資料
DEFINE g_prdn3_d          DYNAMIC ARRAY OF type_g_prdn3_d
DEFINE g_prdn3_d_t        type_g_prdn3_d
DEFINE g_prdn3_d_o        type_g_prdn3_d
DEFINE g_prdn3_d_mask_o   DYNAMIC ARRAY OF type_g_prdn3_d #轉換遮罩前資料
DEFINE g_prdn3_d_mask_n   DYNAMIC ARRAY OF type_g_prdn3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      prdll001 LIKE prdll_t.prdll001,
      prdll003 LIKE prdll_t.prdll003
      END RECORD
 
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
 
{<section id="aprm551.main" >}
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
   CALL cl_ap_init("apr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT prdlunit,'',prdl001,prdl002,'',prdl006,'',prdl007,'',prdl027,prdl099, 
       prdl100,prdlstus,prdl004,'',prdl005,'',prdlsite,prdl003,prdl012,prdl010,prdl013,prdl011,prdl014, 
       '','',prdl098,prdl017,prdl020,prdl021,prdl008,'',prdl009,'',prdl022,prdl026,prdl023,prdl025,prdl028, 
       prdl029,prdl030,prdl031,prdlcrtid,'',prdlcrtdp,'',prdlcrtdt,prdlownid,'',prdlowndp,'',prdlmodid, 
       '',prdlmoddt,prdlcnfid,'',prdlcnfdt,prdl018,prdl032,prdl019", 
                      " FROM prdl_t",
                      " WHERE prdlent= ? AND prdl001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprm551_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.prdlunit,t0.prdl001,t0.prdl002,t0.prdl006,t0.prdl007,t0.prdl027, 
       t0.prdl099,t0.prdl100,t0.prdlstus,t0.prdl004,t0.prdl005,t0.prdlsite,t0.prdl003,t0.prdl012,t0.prdl010, 
       t0.prdl013,t0.prdl011,t0.prdl014,t0.prdl098,t0.prdl017,t0.prdl020,t0.prdl021,t0.prdl008,t0.prdl009, 
       t0.prdl022,t0.prdl026,t0.prdl023,t0.prdl025,t0.prdl028,t0.prdl029,t0.prdl030,t0.prdl031,t0.prdlcrtid, 
       t0.prdlcrtdp,t0.prdlcrtdt,t0.prdlownid,t0.prdlowndp,t0.prdlmodid,t0.prdlmoddt,t0.prdlcnfid,t0.prdlcnfdt, 
       t0.prdl018,t0.prdl032,t0.prdl019,t1.ooefl003 ,t2.prcfl003 ,t3.prcdl003 ,t4.ooag011 ,t5.ooefl003 , 
       t6.oocql004 ,t7.oocql004 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooefl003 ,t12.ooag011 ,t13.ooag011", 
 
               " FROM prdl_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prdlunit AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN prcfl_t t2 ON t2.prcflent="||g_enterprise||" AND t2.prcfl001=t0.prdl006 AND t2.prcfl002='"||g_dlang||"' ",
               " LEFT JOIN prcdl_t t3 ON t3.prcdlent="||g_enterprise||" AND t3.prcdl001=t0.prdl007 AND t3.prcdl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prdl004  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prdl005 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='2100' AND t6.oocql002=t0.prdl008 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='2101' AND t7.oocql002=t0.prdl009 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.prdlcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.prdlcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.prdlownid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.prdlowndp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.prdlmodid  ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.prdlcnfid  ",
 
               " WHERE t0.prdlent = " ||g_enterprise|| " AND t0.prdl001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprm551_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprm551 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprm551_init()   
 
      #進入選單 Menu (="N")
      CALL aprm551_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprm551
      
   END IF 
   
   CLOSE aprm551_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprm551.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprm551_init()
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
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('prdlstus','50','N,Y,X')
 
      CALL cl_set_combo_scc('prdl017','6561') 
   CALL cl_set_combo_scc('prdl021','6563') 
   CALL cl_set_combo_scc('prdl026','6566') 
   CALL cl_set_combo_scc('prdl025','6565') 
   CALL cl_set_combo_scc('prdl028','6715') 
   CALL cl_set_combo_scc('prdl018','6562') 
   CALL cl_set_combo_scc('prdl032','6716') 
   CALL cl_set_combo_scc('prdl019','6714') 
   CALL cl_set_combo_scc('prds000','6717') 
   CALL cl_set_combo_scc('prds003','6503') 
   CALL cl_set_combo_scc('prds008','6570') 
   CALL cl_set_combo_scc('prds009','6719') 
   CALL cl_set_combo_scc('prds004','6569') 
   CALL cl_set_combo_scc('prdr003','6517') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('prdn003','6035')
  #CALL cl_set_combo_scc_part('prds000','6717','1,3,4')
   CALL cl_set_combo_scc_part('prdr003','6517','4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L') 
   CALL cl_set_comp_entry("prdl019",FALSE)   
   #end add-point
   
   #初始化搜尋條件
   CALL aprm551_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprm551.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprm551_ui_dialog()
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
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_prdl_m.* TO NULL
         CALL g_prdn_d.clear()
         CALL g_prdn2_d.clear()
         CALL g_prdn3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aprm551_init()
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
               
               CALL aprm551_fetch('') # reload data
               LET l_ac = 1
               CALL aprm551_ui_detailshow() #Setting the current row 
         
               CALL aprm551_idx_chk()
               #NEXT FIELD prdn002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_prdn_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprm551_idx_chk()
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
               CALL aprm551_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_prdn2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprm551_idx_chk()
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
               CALL aprm551_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_prdn3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprm551_idx_chk()
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
               CALL aprm551_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_prdn4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL aprm551_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               
               #add-point:page3, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               CALL aprm551_idx_chk()
               #add-point:page3自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_prdn5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL aprm551_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               
               #add-point:page3, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 4
               CALL aprm551_idx_chk()
               #add-point:page3自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_prdn6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL aprm551_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx = l_ac
               
               #add-point:page3, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page = 4
               CALL aprm551_idx_chk()
               #add-point:page3自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aprm551_browser_fill("")
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
               CALL aprm551_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprm551_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprm551_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aprm551_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aprm551_set_act_visible()   
            CALL aprm551_set_act_no_visible()
            IF NOT (g_prdl_m.prdl001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " prdlent = " ||g_enterprise|| " AND",
                                  " prdl001 = '", g_prdl_m.prdl001, "' "
 
               #填到對應位置
               CALL aprm551_browser_fill("")
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
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "prdl_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prdn_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prds_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "prdr_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
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
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aprm551_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "prdl_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prdn_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prds_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "prdr_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
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
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aprm551_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aprm551_fetch("F")
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
               CALL aprm551_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aprm551_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprm551_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aprm551_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprm551_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aprm551_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprm551_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aprm551_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprm551_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aprm551_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprm551_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_prdn_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_prdn2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_prdn3_d)
                  LET g_export_id[3]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[4] = base.typeInfo.create(g_prdn4_d)
                  LET g_export_id[4]   = "s_detail4"
                  LET g_export_node[5] = base.typeInfo.create(g_prdn5_d)
                  LET g_export_id[5]   = "s_detail5"
                  LET g_export_node[6] = base.typeInfo.create(g_prdn6_d)
                  LET g_export_id[6]   = "s_detail6"
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
               NEXT FIELD prdn002
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aprm551_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
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
         ON ACTION release
            LET g_action_choice="release"
            IF cl_auth_chk_act("release") THEN
               
               #add-point:ON ACTION release name="menu.release"
               IF g_prdl_m.prdl099 = 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "apr-00329"
                  LET g_errparam.extend = g_prdl_m.prdl001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
               ELSE
                  CALL s_transaction_begin()
                  CALL s_aprm211_release_chk(g_prdl_m.prdl001,g_prdl_m.prdlstus) RETURNING l_success,g_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prdl_m.prdl001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     CALL s_transaction_end('N','0')
                  ELSE
                     IF NOT cl_ask_confirm('amm-00178') THEN
                        CALL s_transaction_end('N','0')
                     ELSE
                       CALL s_aprm211_release_upd(g_prdl_m.prdl001,g_prdl_m.prdlstus) RETURNING l_success
                       IF NOT l_success THEN
                          CALL s_transaction_end('N','0')
                       END IF
                     END IF
                  END IF
                  CALL s_transaction_end('Y','0')
                  SELECT prdl099,prdl100 INTO g_prdl_m.prdl099,g_prdl_m.prdl100
                    FROM prdl_t
                   WHERE prdlent = g_enterprise AND prdl001 = g_prdl_m.prdl001
                  DISPLAY BY NAME g_prdl_m.prdl099,g_prdl_m.prdl100
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aprm551_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprm551_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprm551_set_pk_array()
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
 
{<section id="aprm551.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprm551_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   CALL g_prdn4_d.clear()
   CALL g_prdn5_d.clear()
   CALL g_prdn6_d.clear()
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
      LET l_sub_sql = " SELECT DISTINCT prdl001 ",
                      " FROM prdl_t ",
                      " ",
                      " LEFT JOIN prdn_t ON prdnent = prdlent AND prdl001 = prdn001 ", "  ",
                      #add-point:browser_fill段sql(prdn_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN prds_t ON prdsent = prdlent AND prdl001 = prds001", "  ",
                      #add-point:browser_fill段sql(prds_t1) name="browser_fill.cnt.join.prds_t1"
                      
                      #end add-point
 
                      " LEFT JOIN prdr_t ON prdrent = prdlent AND prdl001 = prdr001", "  ",
                      #add-point:browser_fill段sql(prdr_t1) name="browser_fill.cnt.join.prdr_t1"
                      
                      #end add-point
 
 
 
                      " LEFT JOIN prdll_t ON prdllent = "||g_enterprise||" AND prdl001 = prdll001 AND prdll002 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE prdlent = " ||g_enterprise|| " AND prdnent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prdl_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT prdl001 ",
                      " FROM prdl_t ", 
                      "  ",
                      "  LEFT JOIN prdll_t ON prdllent = "||g_enterprise||" AND prdl001 = prdll001 AND prdll002 = '",g_dlang,"' ",
                      " WHERE prdlent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("prdl_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
      IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE prdl001 ",
 
                        " FROM prdl_t ",
                              " ",
                              " LEFT JOIN prdn_t ON prdnent = prdlent AND prdl001 = prdn001 ",
                              " LEFT JOIN prds_t ON prdsent = prdlent AND prdl001 = prds001", 
 
                              " LEFT JOIN prdr_t ON prdrent = prdlent AND prdl001 = prdr001", 
                              " LEFT JOIN prdu_t ON prduent = prdlent AND prdl001 = prdu001",
                              " LEFT JOIN prdv_t ON prdvent = prdlent AND prdl001 = prdv001",
 
                              " LEFT JOIN prdll_t ON prdl001 = prdll001 AND prdll002 = '",g_lang,"' ", 
                              " ", 
                       " WHERE prdlent = '" ||g_enterprise|| "' AND prdl098 = '2' AND prdnent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prdl_t")
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE prdl001 ",
 
                        " FROM prdl_t ", 
                              " ",
                              " LEFT JOIN prdll_t ON prdl001 = prdll001 AND prdll002 = '",g_lang,"' ",
                        "WHERE prdlent = '" ||g_enterprise|| "' AND prdl098 = '2' AND ",l_wc CLIPPED, cl_sql_add_filter("prdl_t")
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
      INITIALIZE g_prdl_m.* TO NULL
      CALL g_prdn_d.clear()        
      CALL g_prdn2_d.clear() 
      CALL g_prdn3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.prdlunit,t0.prdl001,t0.prdl002,t0.prdl006,t0.prdl007,t0.prdl027 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prdlstus,t0.prdlunit,t0.prdl001,t0.prdl002,t0.prdl006,t0.prdl007, 
          t0.prdl027,t1.ooefl003 ,t2.prcfl003 ,t3.prcdl003 ",
                  " FROM prdl_t t0",
                  "  ",
                  "  LEFT JOIN prdn_t ON prdnent = prdlent AND prdl001 = prdn001 ", "  ", 
                  #add-point:browser_fill段sql(prdn_t1) name="browser_fill.join.prdn_t1"
                  
                  #end add-point
                  "  LEFT JOIN prds_t ON prdsent = prdlent AND prdl001 = prds001", "  ", 
                  #add-point:browser_fill段sql(prds_t1) name="browser_fill.join.prds_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN prdr_t ON prdrent = prdlent AND prdl001 = prdr001", "  ", 
                  #add-point:browser_fill段sql(prdr_t1) name="browser_fill.join.prdr_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prdlunit AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN prcfl_t t2 ON t2.prcflent="||g_enterprise||" AND t2.prcfl001=t0.prdl006 AND t2.prcfl002='"||g_dlang||"' ",
               " LEFT JOIN prcdl_t t3 ON t3.prcdlent="||g_enterprise||" AND t3.prcdl001=t0.prdl007 AND t3.prcdl002='"||g_dlang||"' ",
 
               " LEFT JOIN prdll_t ON prdllent = "||g_enterprise||" AND prdl001 = prdll001 AND prdll002 = '",g_dlang,"' ",
                  " WHERE t0.prdlent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("prdl_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prdlstus,t0.prdlunit,t0.prdl001,t0.prdl002,t0.prdl006,t0.prdl007, 
          t0.prdl027,t1.ooefl003 ,t2.prcfl003 ,t3.prcdl003 ",
                  " FROM prdl_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prdlunit AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN prcfl_t t2 ON t2.prcflent="||g_enterprise||" AND t2.prcfl001=t0.prdl006 AND t2.prcfl002='"||g_dlang||"' ",
               " LEFT JOIN prcdl_t t3 ON t3.prcdlent="||g_enterprise||" AND t3.prcdl001=t0.prdl007 AND t3.prcdl002='"||g_dlang||"' ",
 
               " LEFT JOIN prdll_t ON prdllent = "||g_enterprise||" AND prdl001 = prdll001 AND prdll002 = '",g_dlang,"' ",
                  " WHERE t0.prdlent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("prdl_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY prdl001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
    LET g_sql = " SELECT DISTINCT prdlstus,prdlunit,prdl001,prdl002,prdl006,prdl007,prdl027, 
                t1.ooefl003 ,t2.prcfl003 ,t3.prcdl003 ",
                        " FROM prdl_t ",
                              " ",
                              " LEFT JOIN prdn_t ON prdnent = prdlent AND prdl001 = prdn001 ",
                              " LEFT JOIN prds_t ON prdsent = prdlent AND prdl001 = prds001",
 
                              " LEFT JOIN prdr_t ON prdrent = prdlent AND prdl001 = prdr001",
                              " LEFT JOIN prdu_t ON prduent = prdlent AND prdl001 = prdu001",
                              " LEFT JOIN prdv_t ON prdvent = prdlent AND prdl001 = prdv001", 
                              " LEFT JOIN prdll_t ON prdl001 = prdll001 AND prdll002 = '",g_lang,"' ",
                              " ",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=prdlunit AND t1.ooefl002='"||g_lang||"' ",
                              " LEFT JOIN prcfl_t t2 ON t2.prcflent='"||g_enterprise||"' AND t2.prcfl001=prdl006 AND t2.prcfl002='"||g_lang||"' ",
                              " LEFT JOIN prcdl_t t3 ON t3.prcdlent='"||g_enterprise||"' AND t3.prcdl001=prdl007 AND t3.prcdl002='"||g_lang||"' ",
                       " ",
                       " WHERE prdlent = '" ||g_enterprise|| "' AND prdl098 = '2'  AND ",g_wc," AND ",g_wc2, cl_sql_add_filter("prdl_t")
                      #" WHERE prdlent = '" ||g_enterprise|| "' AND prdl098 = '2'  AND ",g_wc," AND ",g_wc2, cl_sql_add_filter("prdl_t"),
                      #" ORDER BY ",l_searchcol," ",g_order
#   ELSE
#      #單身無輸入資料
#      LET l_sql_rank = "SELECT DISTINCT prdlstus,prdlunit,'',prdl001,prdl002,prdl006,'',prdl007,'',prdl027, 
#          DENSE_RANK() OVER(ORDER BY prdl001 ",g_order,") AS RANK ",
#                       " FROM prdl_t ",
#                            "  ",
#                            "  LEFT JOIN prdll_t ON prdl001 = prdll001 AND prdll002 = '",g_lang,"' ",
#                       " WHERE prdlent = '" ||g_enterprise|| "' AND prdl098 = '2'  AND ", g_wc, cl_sql_add_filter("prdl_t")
#   END IF
#   
#   #定義翻頁CURSOR
#   LET g_sql= "SELECT prdlstus,prdlunit,'',prdl001,prdl002,prdl006,'',prdl007,'',prdl027 FROM (",l_sql_rank, 
#       ") WHERE ",
#              " RANK >= ",1," AND RANK<",1+g_max_browse,
#              " ORDER BY ",l_searchcol," ",g_order
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"prdl_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_prdlunit,g_browser[g_cnt].b_prdl001, 
          g_browser[g_cnt].b_prdl002,g_browser[g_cnt].b_prdl006,g_browser[g_cnt].b_prdl007,g_browser[g_cnt].b_prdl027, 
          g_browser[g_cnt].b_prdlunit_desc,g_browser[g_cnt].b_prdl006_desc,g_browser[g_cnt].b_prdl007_desc 
 
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
         CALL aprm551_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_prdl001) THEN
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
 
{<section id="aprm551.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprm551_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_prdl_m.prdl001 = g_browser[g_current_idx].b_prdl001   
 
   EXECUTE aprm551_master_referesh USING g_prdl_m.prdl001 INTO g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002, 
       g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus, 
       g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012,g_prdl_m.prdl010, 
       g_prdl_m.prdl013,g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdl098,g_prdl_m.prdl017,g_prdl_m.prdl020, 
       g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdl022,g_prdl_m.prdl026,g_prdl_m.prdl023, 
       g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029,g_prdl_m.prdl030,g_prdl_m.prdl031,g_prdl_m.prdlcrtid, 
       g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlowndp,g_prdl_m.prdlmodid, 
       g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt,g_prdl_m.prdl018,g_prdl_m.prdl032,g_prdl_m.prdl019, 
       g_prdl_m.prdlunit_desc,g_prdl_m.prdl006_desc,g_prdl_m.prdl007_desc,g_prdl_m.prdl004_desc,g_prdl_m.prdl005_desc, 
       g_prdl_m.prdl008_desc,g_prdl_m.prdl009_desc,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp_desc,g_prdl_m.prdlownid_desc, 
       g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlcnfid_desc
   
   CALL aprm551_prdl_t_mask()
   CALL aprm551_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aprm551.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprm551_ui_detailshow()
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
 
{<section id="aprm551.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprm551_ui_browser_refresh()
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
      IF g_browser[l_i].b_prdl001 = g_prdl_m.prdl001 
 
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
 
{<section id="aprm551.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprm551_construct()
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
   CALL g_prdn4_d.clear()
   CALL g_prdn5_d.clear()
   CALL g_prdn6_d.clear()
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_prdl_m.* TO NULL
   CALL g_prdn_d.clear()        
   CALL g_prdn2_d.clear() 
   CALL g_prdn3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON prdlunit,prdl001,prdl002,prdll003,prdl006,prdl007,prdl027,prdl099,prdl100, 
          prdlstus,prdl004,prdl005,prdlsite,prdl003,prdl012,prdl010,prdl013,prdl011,prdl014,prdl098, 
          prdl017,prdl020,prdl021,prdl008,prdl009,prdl022,prdl026,prdl023,prdl025,prdl028,prdl029,prdl030, 
          prdl031,prdlcrtid,prdlcrtdp,prdlcrtdt,prdlownid,prdlowndp,prdlmodid,prdlmoddt,prdlcnfid,prdlcnfdt, 
          prdl018,prdl032,prdl019
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prdlcrtdt>>----
         AFTER FIELD prdlcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prdlmoddt>>----
         AFTER FIELD prdlmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdlcnfdt>>----
         AFTER FIELD prdlcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prdlpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.prdlunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdlunit
            #add-point:ON ACTION controlp INFIELD prdlunit name="construct.c.prdlunit"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_14()                    #呼叫開窗    #161024-00025#3 mark
            LET g_qryparam.where = " ooef201 = 'Y' "    #161024-00025#3 add
            CALL q_ooef001_24()                     #161024-00025#3 add
            DISPLAY g_qryparam.return1 TO prdlunit  #顯示到畫面上
            NEXT FIELD prdlunit                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlunit
            #add-point:BEFORE FIELD prdlunit name="construct.b.prdlunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdlunit
            
            #add-point:AFTER FIELD prdlunit name="construct.a.prdlunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl001
            #add-point:ON ACTION controlp INFIELD prdl001 name="construct.c.prdl001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '31'
            LET g_qryparam.arg2 = '2'
            CALL q_prdl001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdl001  #顯示到畫面上
            NEXT FIELD prdl001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl001
            #add-point:BEFORE FIELD prdl001 name="construct.b.prdl001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl001
            
            #add-point:AFTER FIELD prdl001 name="construct.a.prdl001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl002
            #add-point:BEFORE FIELD prdl002 name="construct.b.prdl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl002
            
            #add-point:AFTER FIELD prdl002 name="construct.a.prdl002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl002
            #add-point:ON ACTION controlp INFIELD prdl002 name="construct.c.prdl002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdll003
            #add-point:BEFORE FIELD prdll003 name="construct.b.prdll003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdll003
            
            #add-point:AFTER FIELD prdll003 name="construct.a.prdll003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdll003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdll003
            #add-point:ON ACTION controlp INFIELD prdll003 name="construct.c.prdll003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prdl006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl006
            #add-point:ON ACTION controlp INFIELD prdl006 name="construct.c.prdl006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2'
            CALL q_prcf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdl006  #顯示到畫面上
            NEXT FIELD prdl006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl006
            #add-point:BEFORE FIELD prdl006 name="construct.b.prdl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl006
            
            #add-point:AFTER FIELD prdl006 name="construct.a.prdl006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl007
            #add-point:ON ACTION controlp INFIELD prdl007 name="construct.c.prdl007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2'
            CALL q_prcd001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdl007  #顯示到畫面上
            NEXT FIELD prdl007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl007
            #add-point:BEFORE FIELD prdl007 name="construct.b.prdl007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl007
            
            #add-point:AFTER FIELD prdl007 name="construct.a.prdl007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl027
            #add-point:BEFORE FIELD prdl027 name="construct.b.prdl027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl027
            
            #add-point:AFTER FIELD prdl027 name="construct.a.prdl027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl027
            #add-point:ON ACTION controlp INFIELD prdl027 name="construct.c.prdl027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl099
            #add-point:BEFORE FIELD prdl099 name="construct.b.prdl099"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl099
            
            #add-point:AFTER FIELD prdl099 name="construct.a.prdl099"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl099
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl099
            #add-point:ON ACTION controlp INFIELD prdl099 name="construct.c.prdl099"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl100
            #add-point:BEFORE FIELD prdl100 name="construct.b.prdl100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl100
            
            #add-point:AFTER FIELD prdl100 name="construct.a.prdl100"
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl100
            #add-point:ON ACTION controlp INFIELD prdl100 name="construct.c.prdl100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlstus
            #add-point:BEFORE FIELD prdlstus name="construct.b.prdlstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdlstus
            
            #add-point:AFTER FIELD prdlstus name="construct.a.prdlstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdlstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdlstus
            #add-point:ON ACTION controlp INFIELD prdlstus name="construct.c.prdlstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prdl004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl004
            #add-point:ON ACTION controlp INFIELD prdl004 name="construct.c.prdl004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdl004  #顯示到畫面上
            NEXT FIELD prdl004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl004
            #add-point:BEFORE FIELD prdl004 name="construct.b.prdl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl004
            
            #add-point:AFTER FIELD prdl004 name="construct.a.prdl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl005
            #add-point:ON ACTION controlp INFIELD prdl005 name="construct.c.prdl005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdl005  #顯示到畫面上
            NEXT FIELD prdl005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl005
            #add-point:BEFORE FIELD prdl005 name="construct.b.prdl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl005
            
            #add-point:AFTER FIELD prdl005 name="construct.a.prdl005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlsite
            #add-point:BEFORE FIELD prdlsite name="construct.b.prdlsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdlsite
            
            #add-point:AFTER FIELD prdlsite name="construct.a.prdlsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdlsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdlsite
            #add-point:ON ACTION controlp INFIELD prdlsite name="construct.c.prdlsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl003
            #add-point:BEFORE FIELD prdl003 name="construct.b.prdl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl003
            
            #add-point:AFTER FIELD prdl003 name="construct.a.prdl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl003
            #add-point:ON ACTION controlp INFIELD prdl003 name="construct.c.prdl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl012
            #add-point:BEFORE FIELD prdl012 name="construct.b.prdl012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl012
            
            #add-point:AFTER FIELD prdl012 name="construct.a.prdl012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl012
            #add-point:ON ACTION controlp INFIELD prdl012 name="construct.c.prdl012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl010
            #add-point:BEFORE FIELD prdl010 name="construct.b.prdl010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl010
            
            #add-point:AFTER FIELD prdl010 name="construct.a.prdl010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl010
            #add-point:ON ACTION controlp INFIELD prdl010 name="construct.c.prdl010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl013
            #add-point:BEFORE FIELD prdl013 name="construct.b.prdl013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl013
            
            #add-point:AFTER FIELD prdl013 name="construct.a.prdl013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl013
            #add-point:ON ACTION controlp INFIELD prdl013 name="construct.c.prdl013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl011
            #add-point:BEFORE FIELD prdl011 name="construct.b.prdl011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl011
            
            #add-point:AFTER FIELD prdl011 name="construct.a.prdl011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl011
            #add-point:ON ACTION controlp INFIELD prdl011 name="construct.c.prdl011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl014
            #add-point:BEFORE FIELD prdl014 name="construct.b.prdl014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl014
            
            #add-point:AFTER FIELD prdl014 name="construct.a.prdl014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl014
            #add-point:ON ACTION controlp INFIELD prdl014 name="construct.c.prdl014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl098
            #add-point:BEFORE FIELD prdl098 name="construct.b.prdl098"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl098
            
            #add-point:AFTER FIELD prdl098 name="construct.a.prdl098"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl098
            #add-point:ON ACTION controlp INFIELD prdl098 name="construct.c.prdl098"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl017
            #add-point:BEFORE FIELD prdl017 name="construct.b.prdl017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl017
            
            #add-point:AFTER FIELD prdl017 name="construct.a.prdl017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl017
            #add-point:ON ACTION controlp INFIELD prdl017 name="construct.c.prdl017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl020
            #add-point:BEFORE FIELD prdl020 name="construct.b.prdl020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl020
            
            #add-point:AFTER FIELD prdl020 name="construct.a.prdl020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl020
            #add-point:ON ACTION controlp INFIELD prdl020 name="construct.c.prdl020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl021
            #add-point:BEFORE FIELD prdl021 name="construct.b.prdl021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl021
            
            #add-point:AFTER FIELD prdl021 name="construct.a.prdl021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl021
            #add-point:ON ACTION controlp INFIELD prdl021 name="construct.c.prdl021"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prdl008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl008
            #add-point:ON ACTION controlp INFIELD prdl008 name="construct.c.prdl008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2100'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdl008  #顯示到畫面上
            NEXT FIELD prdl008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl008
            #add-point:BEFORE FIELD prdl008 name="construct.b.prdl008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl008
            
            #add-point:AFTER FIELD prdl008 name="construct.a.prdl008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl009
            #add-point:ON ACTION controlp INFIELD prdl009 name="construct.c.prdl009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2101'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdl009  #顯示到畫面上
            NEXT FIELD prdl009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl009
            #add-point:BEFORE FIELD prdl009 name="construct.b.prdl009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl009
            
            #add-point:AFTER FIELD prdl009 name="construct.a.prdl009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl022
            #add-point:BEFORE FIELD prdl022 name="construct.b.prdl022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl022
            
            #add-point:AFTER FIELD prdl022 name="construct.a.prdl022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl022
            #add-point:ON ACTION controlp INFIELD prdl022 name="construct.c.prdl022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl026
            #add-point:BEFORE FIELD prdl026 name="construct.b.prdl026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl026
            
            #add-point:AFTER FIELD prdl026 name="construct.a.prdl026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl026
            #add-point:ON ACTION controlp INFIELD prdl026 name="construct.c.prdl026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl023
            #add-point:BEFORE FIELD prdl023 name="construct.b.prdl023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl023
            
            #add-point:AFTER FIELD prdl023 name="construct.a.prdl023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl023
            #add-point:ON ACTION controlp INFIELD prdl023 name="construct.c.prdl023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl025
            #add-point:BEFORE FIELD prdl025 name="construct.b.prdl025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl025
            
            #add-point:AFTER FIELD prdl025 name="construct.a.prdl025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl025
            #add-point:ON ACTION controlp INFIELD prdl025 name="construct.c.prdl025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl028
            #add-point:BEFORE FIELD prdl028 name="construct.b.prdl028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl028
            
            #add-point:AFTER FIELD prdl028 name="construct.a.prdl028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl028
            #add-point:ON ACTION controlp INFIELD prdl028 name="construct.c.prdl028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl029
            #add-point:BEFORE FIELD prdl029 name="construct.b.prdl029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl029
            
            #add-point:AFTER FIELD prdl029 name="construct.a.prdl029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl029
            #add-point:ON ACTION controlp INFIELD prdl029 name="construct.c.prdl029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl030
            #add-point:BEFORE FIELD prdl030 name="construct.b.prdl030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl030
            
            #add-point:AFTER FIELD prdl030 name="construct.a.prdl030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl030
            #add-point:ON ACTION controlp INFIELD prdl030 name="construct.c.prdl030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl031
            #add-point:BEFORE FIELD prdl031 name="construct.b.prdl031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl031
            
            #add-point:AFTER FIELD prdl031 name="construct.a.prdl031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl031
            #add-point:ON ACTION controlp INFIELD prdl031 name="construct.c.prdl031"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prdlcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdlcrtid
            #add-point:ON ACTION controlp INFIELD prdlcrtid name="construct.c.prdlcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdlcrtid  #顯示到畫面上
            NEXT FIELD prdlcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlcrtid
            #add-point:BEFORE FIELD prdlcrtid name="construct.b.prdlcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdlcrtid
            
            #add-point:AFTER FIELD prdlcrtid name="construct.a.prdlcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdlcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdlcrtdp
            #add-point:ON ACTION controlp INFIELD prdlcrtdp name="construct.c.prdlcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdlcrtdp  #顯示到畫面上
            NEXT FIELD prdlcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlcrtdp
            #add-point:BEFORE FIELD prdlcrtdp name="construct.b.prdlcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdlcrtdp
            
            #add-point:AFTER FIELD prdlcrtdp name="construct.a.prdlcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlcrtdt
            #add-point:BEFORE FIELD prdlcrtdt name="construct.b.prdlcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prdlownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdlownid
            #add-point:ON ACTION controlp INFIELD prdlownid name="construct.c.prdlownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdlownid  #顯示到畫面上
            NEXT FIELD prdlownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlownid
            #add-point:BEFORE FIELD prdlownid name="construct.b.prdlownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdlownid
            
            #add-point:AFTER FIELD prdlownid name="construct.a.prdlownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdlowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdlowndp
            #add-point:ON ACTION controlp INFIELD prdlowndp name="construct.c.prdlowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdlowndp  #顯示到畫面上
            NEXT FIELD prdlowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlowndp
            #add-point:BEFORE FIELD prdlowndp name="construct.b.prdlowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdlowndp
            
            #add-point:AFTER FIELD prdlowndp name="construct.a.prdlowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdlmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdlmodid
            #add-point:ON ACTION controlp INFIELD prdlmodid name="construct.c.prdlmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdlmodid  #顯示到畫面上
            NEXT FIELD prdlmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlmodid
            #add-point:BEFORE FIELD prdlmodid name="construct.b.prdlmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdlmodid
            
            #add-point:AFTER FIELD prdlmodid name="construct.a.prdlmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlmoddt
            #add-point:BEFORE FIELD prdlmoddt name="construct.b.prdlmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prdlcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdlcnfid
            #add-point:ON ACTION controlp INFIELD prdlcnfid name="construct.c.prdlcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdlcnfid  #顯示到畫面上
            NEXT FIELD prdlcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlcnfid
            #add-point:BEFORE FIELD prdlcnfid name="construct.b.prdlcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdlcnfid
            
            #add-point:AFTER FIELD prdlcnfid name="construct.a.prdlcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlcnfdt
            #add-point:BEFORE FIELD prdlcnfdt name="construct.b.prdlcnfdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl018
            #add-point:BEFORE FIELD prdl018 name="construct.b.prdl018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl018
            
            #add-point:AFTER FIELD prdl018 name="construct.a.prdl018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl018
            #add-point:ON ACTION controlp INFIELD prdl018 name="construct.c.prdl018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl032
            #add-point:BEFORE FIELD prdl032 name="construct.b.prdl032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl032
            
            #add-point:AFTER FIELD prdl032 name="construct.a.prdl032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl032
            #add-point:ON ACTION controlp INFIELD prdl032 name="construct.c.prdl032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl019
            #add-point:BEFORE FIELD prdl019 name="construct.b.prdl019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl019
            
            #add-point:AFTER FIELD prdl019 name="construct.a.prdl019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prdl019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl019
            #add-point:ON ACTION controlp INFIELD prdl019 name="construct.c.prdl019"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON prdnstus,prdn002,prdn003,prdn004,prdnsite,prdnunit
           FROM s_detail1[1].prdnstus,s_detail1[1].prdn002,s_detail1[1].prdn003,s_detail1[1].prdn004, 
               s_detail1[1].prdnsite,s_detail1[1].prdnunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prdncrtdt>>----
 
         #----<<prdnmoddt>>----
         
         #----<<prdncnfdt>>----
         
         #----<<prdnpstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdnstus
            #add-point:BEFORE FIELD prdnstus name="construct.b.page1.prdnstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdnstus
            
            #add-point:AFTER FIELD prdnstus name="construct.a.page1.prdnstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prdnstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdnstus
            #add-point:ON ACTION controlp INFIELD prdnstus name="construct.c.page1.prdnstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdn002
            #add-point:BEFORE FIELD prdn002 name="construct.b.page1.prdn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdn002
            
            #add-point:AFTER FIELD prdn002 name="construct.a.page1.prdn002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prdn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdn002
            #add-point:ON ACTION controlp INFIELD prdn002 name="construct.c.page1.prdn002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdn003
            #add-point:BEFORE FIELD prdn003 name="construct.b.page1.prdn003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdn003
            
            #add-point:AFTER FIELD prdn003 name="construct.a.page1.prdn003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prdn003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdn003
            #add-point:ON ACTION controlp INFIELD prdn003 name="construct.c.page1.prdn003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prdn004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdn004
            #add-point:ON ACTION controlp INFIELD prdn004 name="construct.c.page1.prdn004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2'
            LET g_qryparam.arg2 = '31'
            CALL q_prdn004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdn004  #顯示到畫面上
            NEXT FIELD prdn004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdn004
            #add-point:BEFORE FIELD prdn004 name="construct.b.page1.prdn004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdn004
            
            #add-point:AFTER FIELD prdn004 name="construct.a.page1.prdn004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdnsite
            #add-point:BEFORE FIELD prdnsite name="construct.b.page1.prdnsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdnsite
            
            #add-point:AFTER FIELD prdnsite name="construct.a.page1.prdnsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prdnsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdnsite
            #add-point:ON ACTION controlp INFIELD prdnsite name="construct.c.page1.prdnsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdnunit
            #add-point:BEFORE FIELD prdnunit name="construct.b.page1.prdnunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdnunit
            
            #add-point:AFTER FIELD prdnunit name="construct.a.page1.prdnunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prdnunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdnunit
            #add-point:ON ACTION controlp INFIELD prdnunit name="construct.c.page1.prdnunit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON prdsstus,prds002,prds000,prds003,prds005,prds006,prds008,prds009,prds010, 
          prds011,prds012,prds013,prds004,prds007,prdssite,prdsunit
           FROM s_detail2[1].prdsstus,s_detail2[1].prds002,s_detail2[1].prds000,s_detail2[1].prds003, 
               s_detail2[1].prds005,s_detail2[1].prds006,s_detail2[1].prds008,s_detail2[1].prds009,s_detail2[1].prds010, 
               s_detail2[1].prds011,s_detail2[1].prds012,s_detail2[1].prds013,s_detail2[1].prds004,s_detail2[1].prds007, 
               s_detail2[1].prdssite,s_detail2[1].prdsunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prdscrtdt>>----
 
         #----<<prdsmoddt>>----
         
         #----<<prdscnfdt>>----
         
         #----<<prdspstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdsstus
            #add-point:BEFORE FIELD prdsstus name="construct.b.page2.prdsstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdsstus
            
            #add-point:AFTER FIELD prdsstus name="construct.a.page2.prdsstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prdsstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdsstus
            #add-point:ON ACTION controlp INFIELD prdsstus name="construct.c.page2.prdsstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds002
            #add-point:BEFORE FIELD prds002 name="construct.b.page2.prds002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds002
            
            #add-point:AFTER FIELD prds002 name="construct.a.page2.prds002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prds002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds002
            #add-point:ON ACTION controlp INFIELD prds002 name="construct.c.page2.prds002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds000
            #add-point:BEFORE FIELD prds000 name="construct.b.page2.prds000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds000
            
            #add-point:AFTER FIELD prds000 name="construct.a.page2.prds000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prds000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds000
            #add-point:ON ACTION controlp INFIELD prds000 name="construct.c.page2.prds000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds003
            #add-point:BEFORE FIELD prds003 name="construct.b.page2.prds003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds003
            
            #add-point:AFTER FIELD prds003 name="construct.a.page2.prds003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prds003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds003
            #add-point:ON ACTION controlp INFIELD prds003 name="construct.c.page2.prds003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds005
            #add-point:BEFORE FIELD prds005 name="construct.b.page2.prds005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds005
            
            #add-point:AFTER FIELD prds005 name="construct.a.page2.prds005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prds005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds005
            #add-point:ON ACTION controlp INFIELD prds005 name="construct.c.page2.prds005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds006
            #add-point:BEFORE FIELD prds006 name="construct.b.page2.prds006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds006
            
            #add-point:AFTER FIELD prds006 name="construct.a.page2.prds006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prds006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds006
            #add-point:ON ACTION controlp INFIELD prds006 name="construct.c.page2.prds006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds008
            #add-point:BEFORE FIELD prds008 name="construct.b.page2.prds008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds008
            
            #add-point:AFTER FIELD prds008 name="construct.a.page2.prds008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prds008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds008
            #add-point:ON ACTION controlp INFIELD prds008 name="construct.c.page2.prds008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds009
            #add-point:BEFORE FIELD prds009 name="construct.b.page2.prds009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds009
            
            #add-point:AFTER FIELD prds009 name="construct.a.page2.prds009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prds009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds009
            #add-point:ON ACTION controlp INFIELD prds009 name="construct.c.page2.prds009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds010
            #add-point:BEFORE FIELD prds010 name="construct.b.page2.prds010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds010
            
            #add-point:AFTER FIELD prds010 name="construct.a.page2.prds010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prds010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds010
            #add-point:ON ACTION controlp INFIELD prds010 name="construct.c.page2.prds010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds011
            #add-point:BEFORE FIELD prds011 name="construct.b.page2.prds011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds011
            
            #add-point:AFTER FIELD prds011 name="construct.a.page2.prds011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prds011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds011
            #add-point:ON ACTION controlp INFIELD prds011 name="construct.c.page2.prds011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds012
            #add-point:BEFORE FIELD prds012 name="construct.b.page2.prds012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds012
            
            #add-point:AFTER FIELD prds012 name="construct.a.page2.prds012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prds012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds012
            #add-point:ON ACTION controlp INFIELD prds012 name="construct.c.page2.prds012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds013
            #add-point:BEFORE FIELD prds013 name="construct.b.page2.prds013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds013
            
            #add-point:AFTER FIELD prds013 name="construct.a.page2.prds013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prds013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds013
            #add-point:ON ACTION controlp INFIELD prds013 name="construct.c.page2.prds013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds004
            #add-point:BEFORE FIELD prds004 name="construct.b.page2.prds004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds004
            
            #add-point:AFTER FIELD prds004 name="construct.a.page2.prds004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prds004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds004
            #add-point:ON ACTION controlp INFIELD prds004 name="construct.c.page2.prds004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds007
            #add-point:BEFORE FIELD prds007 name="construct.b.page2.prds007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds007
            
            #add-point:AFTER FIELD prds007 name="construct.a.page2.prds007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prds007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds007
            #add-point:ON ACTION controlp INFIELD prds007 name="construct.c.page2.prds007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdssite
            #add-point:BEFORE FIELD prdssite name="construct.b.page2.prdssite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdssite
            
            #add-point:AFTER FIELD prdssite name="construct.a.page2.prdssite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prdssite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdssite
            #add-point:ON ACTION controlp INFIELD prdssite name="construct.c.page2.prdssite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdsunit
            #add-point:BEFORE FIELD prdsunit name="construct.b.page2.prdsunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdsunit
            
            #add-point:AFTER FIELD prdsunit name="construct.a.page2.prdsunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prdsunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdsunit
            #add-point:ON ACTION controlp INFIELD prdsunit name="construct.c.page2.prdsunit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON prdrstus,prdr010,prdr002,prdr003,prdr004,prdr006,prdr007,prdr008,prdr009, 
          prdrsite,prdrunit,prdr005
           FROM s_detail3[1].prdrstus,s_detail3[1].prdr010,s_detail3[1].prdr002,s_detail3[1].prdr003, 
               s_detail3[1].prdr004,s_detail3[1].prdr006,s_detail3[1].prdr007,s_detail3[1].prdr008,s_detail3[1].prdr009, 
               s_detail3[1].prdrsite,s_detail3[1].prdrunit,s_detail3[1].prdr005
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prdrcrtdt>>----
 
         #----<<prdrmoddt>>----
         
         #----<<prdrcnfdt>>----
         
         #----<<prdrpstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdrstus
            #add-point:BEFORE FIELD prdrstus name="construct.b.page3.prdrstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdrstus
            
            #add-point:AFTER FIELD prdrstus name="construct.a.page3.prdrstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdrstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdrstus
            #add-point:ON ACTION controlp INFIELD prdrstus name="construct.c.page3.prdrstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr010
            #add-point:BEFORE FIELD prdr010 name="construct.b.page3.prdr010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr010
            
            #add-point:AFTER FIELD prdr010 name="construct.a.page3.prdr010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdr010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr010
            #add-point:ON ACTION controlp INFIELD prdr010 name="construct.c.page3.prdr010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr002
            #add-point:BEFORE FIELD prdr002 name="construct.b.page3.prdr002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr002
            
            #add-point:AFTER FIELD prdr002 name="construct.a.page3.prdr002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdr002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr002
            #add-point:ON ACTION controlp INFIELD prdr002 name="construct.c.page3.prdr002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr003
            #add-point:BEFORE FIELD prdr003 name="construct.b.page3.prdr003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr003
            
            #add-point:AFTER FIELD prdr003 name="construct.a.page3.prdr003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdr003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr003
            #add-point:ON ACTION controlp INFIELD prdr003 name="construct.c.page3.prdr003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.prdr004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr004
            #add-point:ON ACTION controlp INFIELD prdr004 name="construct.c.page3.prdr004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2'
            LET g_qryparam.arg2 = '31'
            CALL q_prdr004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdr004  #顯示到畫面上
            NEXT FIELD prdr004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr004
            #add-point:BEFORE FIELD prdr004 name="construct.b.page3.prdr004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr004
            
            #add-point:AFTER FIELD prdr004 name="construct.a.page3.prdr004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdr006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr006
            #add-point:ON ACTION controlp INFIELD prdr006 name="construct.c.page3.prdr006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdr006  #顯示到畫面上
            NEXT FIELD prdr006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr006
            #add-point:BEFORE FIELD prdr006 name="construct.b.page3.prdr006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr006
            
            #add-point:AFTER FIELD prdr006 name="construct.a.page3.prdr006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr007
            #add-point:BEFORE FIELD prdr007 name="construct.b.page3.prdr007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr007
            
            #add-point:AFTER FIELD prdr007 name="construct.a.page3.prdr007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdr007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr007
            #add-point:ON ACTION controlp INFIELD prdr007 name="construct.c.page3.prdr007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr008
            #add-point:BEFORE FIELD prdr008 name="construct.b.page3.prdr008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr008
            
            #add-point:AFTER FIELD prdr008 name="construct.a.page3.prdr008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdr008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr008
            #add-point:ON ACTION controlp INFIELD prdr008 name="construct.c.page3.prdr008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr009
            #add-point:BEFORE FIELD prdr009 name="construct.b.page3.prdr009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr009
            
            #add-point:AFTER FIELD prdr009 name="construct.a.page3.prdr009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdr009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr009
            #add-point:ON ACTION controlp INFIELD prdr009 name="construct.c.page3.prdr009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdrsite
            #add-point:BEFORE FIELD prdrsite name="construct.b.page3.prdrsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdrsite
            
            #add-point:AFTER FIELD prdrsite name="construct.a.page3.prdrsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdrsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdrsite
            #add-point:ON ACTION controlp INFIELD prdrsite name="construct.c.page3.prdrsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdrunit
            #add-point:BEFORE FIELD prdrunit name="construct.b.page3.prdrunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdrunit
            
            #add-point:AFTER FIELD prdrunit name="construct.a.page3.prdrunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prdrunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdrunit
            #add-point:ON ACTION controlp INFIELD prdrunit name="construct.c.page3.prdrunit"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.prdr005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr005
            #add-point:ON ACTION controlp INFIELD prdr005 name="construct.c.page3.prdr005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdr005  #顯示到畫面上
            NEXT FIELD prdr005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr005
            #add-point:BEFORE FIELD prdr005 name="construct.b.page3.prdr005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr005
            
            #add-point:AFTER FIELD prdr005 name="construct.a.page3.prdr005"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      CONSTRUCT g_wc2_table4 ON prdvstus,prdu003,prdv003,prdv005,prdv007,prdv008,prdu005
           FROM s_detail4[1].prdvstus,s_detail4[1].prdu003,s_detail4[1].prdv003,s_detail4[1].prdv005, 
               s_detail4[1].prdv007,s_detail4[1].prdv008,s_detail4[1].prdu005 

                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       
         #此段落由子樣板a02產生
         AFTER FIELD prdv005
            
            #add-point:AFTER FIELD prdv005

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdv005
         ON ACTION controlp INFIELD prdv005
            #add-point:ON ACTION controlp INFIELD prdv005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	         LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_imaa001()
            DISPLAY g_qryparam.return1 TO prdv005  #顯示到畫面上
            NEXT FIELD prdv005
            #END add-point
 
         #----<<prdv002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdv007
            #add-point:BEFORE FIELD prdv007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdv007
            
            #add-point:AFTER FIELD prdv007

            #END add-point
            
 
         #Ctrlp:construct.c.page3.prdv007
         ON ACTION controlp INFIELD prdv007
            #add-point:ON ACTION controlp INFIELD prdv007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prdv007  #顯示到畫面上
            NEXT FIELD prdv007                     #返回原欄位
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
            INITIALIZE g_wc2_table2 TO NULL
 
            INITIALIZE g_wc2_table3 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "prdl_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prdn_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prds_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "prdr_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
 
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
   IF cl_null(g_wc2_table4) THEN
      LET g_wc2_table4 = " 1=1"
   END IF
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprm551.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aprm551_filter()
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
      CONSTRUCT g_wc_filter ON prdlunit,prdl001,prdl002,prdl006,prdl007,prdl027
                          FROM s_browse[1].b_prdlunit,s_browse[1].b_prdl001,s_browse[1].b_prdl002,s_browse[1].b_prdl006, 
                              s_browse[1].b_prdl007,s_browse[1].b_prdl027
 
         BEFORE CONSTRUCT
               DISPLAY aprm551_filter_parser('prdlunit') TO s_browse[1].b_prdlunit
            DISPLAY aprm551_filter_parser('prdl001') TO s_browse[1].b_prdl001
            DISPLAY aprm551_filter_parser('prdl002') TO s_browse[1].b_prdl002
            DISPLAY aprm551_filter_parser('prdl006') TO s_browse[1].b_prdl006
            DISPLAY aprm551_filter_parser('prdl007') TO s_browse[1].b_prdl007
            DISPLAY aprm551_filter_parser('prdl027') TO s_browse[1].b_prdl027
      
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
 
      CALL aprm551_filter_show('prdlunit')
   CALL aprm551_filter_show('prdl001')
   CALL aprm551_filter_show('prdl002')
   CALL aprm551_filter_show('prdl006')
   CALL aprm551_filter_show('prdl007')
   CALL aprm551_filter_show('prdl027')
 
END FUNCTION
 
{</section>}
 
{<section id="aprm551.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aprm551_filter_parser(ps_field)
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
 
{<section id="aprm551.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aprm551_filter_show(ps_field)
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
   LET ls_condition = aprm551_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprm551.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprm551_query()
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
   CALL g_prdn_d.clear()
   CALL g_prdn2_d.clear()
   CALL g_prdn3_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL g_prdn4_d.clear()
   CALL g_prdn5_d.clear()
   CALL g_prdn6_d.clear()
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aprm551_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aprm551_browser_fill("")
      CALL aprm551_fetch("")
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
      CALL aprm551_filter_show('prdlunit')
   CALL aprm551_filter_show('prdl001')
   CALL aprm551_filter_show('prdl002')
   CALL aprm551_filter_show('prdl006')
   CALL aprm551_filter_show('prdl007')
   CALL aprm551_filter_show('prdl027')
   CALL aprm551_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aprm551_fetch("F") 
      #顯示單身筆數
      CALL aprm551_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprm551.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprm551_fetch(p_flag)
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
   
   LET g_prdl_m.prdl001 = g_browser[g_current_idx].b_prdl001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aprm551_master_referesh USING g_prdl_m.prdl001 INTO g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002, 
       g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus, 
       g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012,g_prdl_m.prdl010, 
       g_prdl_m.prdl013,g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdl098,g_prdl_m.prdl017,g_prdl_m.prdl020, 
       g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdl022,g_prdl_m.prdl026,g_prdl_m.prdl023, 
       g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029,g_prdl_m.prdl030,g_prdl_m.prdl031,g_prdl_m.prdlcrtid, 
       g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlowndp,g_prdl_m.prdlmodid, 
       g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt,g_prdl_m.prdl018,g_prdl_m.prdl032,g_prdl_m.prdl019, 
       g_prdl_m.prdlunit_desc,g_prdl_m.prdl006_desc,g_prdl_m.prdl007_desc,g_prdl_m.prdl004_desc,g_prdl_m.prdl005_desc, 
       g_prdl_m.prdl008_desc,g_prdl_m.prdl009_desc,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp_desc,g_prdl_m.prdlownid_desc, 
       g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlcnfid_desc
   
   #遮罩相關處理
   LET g_prdl_m_mask_o.* =  g_prdl_m.*
   CALL aprm551_prdl_t_mask()
   LET g_prdl_m_mask_n.* =  g_prdl_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprm551_set_act_visible()   
   CALL aprm551_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   IF g_prdl_m.prdl019='1' THEN
      CALL cl_set_comp_visible("s_detail4",true)
      CALL cl_set_comp_visible("s_detail5,s_detail6",false)
   END IF
   IF g_prdl_m.prdl019='2' THEN
      CALL cl_set_comp_visible("s_detail5,s_detail6",true)
      CALL cl_set_comp_visible("s_detail4",false)
   END IF
   IF g_prdl_m.prdlstus<>'N' THEN
      CALL cl_set_act_visible("modify,delete", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete", TRUE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prdl_m_t.* = g_prdl_m.*
   LET g_prdl_m_o.* = g_prdl_m.*
   
   LET g_data_owner = g_prdl_m.prdlownid      
   LET g_data_dept  = g_prdl_m.prdlowndp
   
   #重新顯示   
   CALL aprm551_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aprm551.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprm551_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   CALL g_prdn4_d.clear()
   CALL g_prdn5_d.clear()
   CALL g_prdn6_d.clear()
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_prdn_d.clear()   
   CALL g_prdn2_d.clear()  
   CALL g_prdn3_d.clear()  
 
 
   INITIALIZE g_prdl_m.* TO NULL             #DEFAULT 設定
   
   LET g_prdl001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prdl_m.prdlownid = g_user
      LET g_prdl_m.prdlowndp = g_dept
      LET g_prdl_m.prdlcrtid = g_user
      LET g_prdl_m.prdlcrtdp = g_dept 
      LET g_prdl_m.prdlcrtdt = cl_get_current()
      LET g_prdl_m.prdlmodid = g_user
      LET g_prdl_m.prdlmoddt = cl_get_current()
      LET g_prdl_m.prdlstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_prdl_m.prdl099 = "N"
      LET g_prdl_m.prdlstus = "N"
      LET g_prdl_m.prdl012 = "N"
      LET g_prdl_m.prdl010 = "N"
      LET g_prdl_m.prdl013 = "N"
      LET g_prdl_m.prdl011 = "N"
      LET g_prdl_m.prdl017 = "1"
      LET g_prdl_m.prdl021 = "0"
      LET g_prdl_m.prdl022 = "0"
      LET g_prdl_m.prdl026 = "3"
      LET g_prdl_m.prdl023 = "0"
      LET g_prdl_m.prdl025 = "1"
      LET g_prdl_m.prdl028 = "1"
      LET g_prdl_m.prdl018 = "1"
      LET g_prdl_m.prdl032 = "1"
      LET g_prdl_m.prdl019 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_prdl_m.prdl003 = "31"
      LET g_prdl_m.prdl014 = 0
      LET g_prdl_m.prdl017 = "2"
      LET g_prdl_m.prdl020 = "N"
      LET g_prdl_m.prdl026 = "4"
      INITIALIZE g_prdl_m_o.* TO NULL
      LET g_prdl_m.prdlunit = g_site
      LET g_prdl_m.prdlsite = g_site
      LET g_prdl_m.prdl004 = g_user
      LET g_prdl_m.prdl005 = g_dept
      LET g_prdl_m.prdl002 = 1
      LET g_prdl_m.prdl098 = '2'
      CALL aprm551_desc()
      LET g_prdl_m_t.*= g_prdl_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_prdl_m_t.* = g_prdl_m.*
      LET g_prdl_m_o.* = g_prdl_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prdl_m.prdlstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
    
      CALL aprm551_input("a")
      
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
         INITIALIZE g_prdl_m.* TO NULL
         INITIALIZE g_prdn_d TO NULL
         INITIALIZE g_prdn2_d TO NULL
         INITIALIZE g_prdn3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aprm551_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_prdn_d.clear()
      #CALL g_prdn2_d.clear()
      #CALL g_prdn3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprm551_set_act_visible()   
   CALL aprm551_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prdl001_t = g_prdl_m.prdl001
 
   
   #組合新增資料的條件
   LET g_add_browse = " prdlent = " ||g_enterprise|| " AND",
                      " prdl001 = '", g_prdl_m.prdl001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprm551_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aprm551_cl
   
   CALL aprm551_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aprm551_master_referesh USING g_prdl_m.prdl001 INTO g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002, 
       g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus, 
       g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012,g_prdl_m.prdl010, 
       g_prdl_m.prdl013,g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdl098,g_prdl_m.prdl017,g_prdl_m.prdl020, 
       g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdl022,g_prdl_m.prdl026,g_prdl_m.prdl023, 
       g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029,g_prdl_m.prdl030,g_prdl_m.prdl031,g_prdl_m.prdlcrtid, 
       g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlowndp,g_prdl_m.prdlmodid, 
       g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt,g_prdl_m.prdl018,g_prdl_m.prdl032,g_prdl_m.prdl019, 
       g_prdl_m.prdlunit_desc,g_prdl_m.prdl006_desc,g_prdl_m.prdl007_desc,g_prdl_m.prdl004_desc,g_prdl_m.prdl005_desc, 
       g_prdl_m.prdl008_desc,g_prdl_m.prdl009_desc,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp_desc,g_prdl_m.prdlownid_desc, 
       g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlcnfid_desc
   
   
   #遮罩相關處理
   LET g_prdl_m_mask_o.* =  g_prdl_m.*
   CALL aprm551_prdl_t_mask()
   LET g_prdl_m_mask_n.* =  g_prdl_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prdl_m.prdlunit,g_prdl_m.prdlunit_desc,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdll003, 
       g_prdl_m.prdl006,g_prdl_m.prdl006_desc,g_prdl_m.prdl007,g_prdl_m.prdl007_desc,g_prdl_m.prdl027, 
       g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl004,g_prdl_m.prdl004_desc,g_prdl_m.prdl005, 
       g_prdl_m.prdl005_desc,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012,g_prdl_m.prdl010,g_prdl_m.prdl013, 
       g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdo003,g_prdl_m.prdo004,g_prdl_m.prdl098,g_prdl_m.prdl017, 
       g_prdl_m.prdl020,g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl008_desc,g_prdl_m.prdl009,g_prdl_m.prdl009_desc, 
       g_prdl_m.prdl022,g_prdl_m.prdl026,g_prdl_m.prdl023,g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029, 
       g_prdl_m.prdl030,g_prdl_m.prdl031,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp, 
       g_prdl_m.prdlcrtdp_desc,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp, 
       g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid, 
       g_prdl_m.prdlcnfid_desc,g_prdl_m.prdlcnfdt,g_prdl_m.prdl018,g_prdl_m.prdl032,g_prdl_m.prdl019 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_prdl_m.prdlownid      
   LET g_data_dept  = g_prdl_m.prdlowndp
   
   #功能已完成,通報訊息中心
   CALL aprm551_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aprm551.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprm551_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   IF g_prdl_m.prdlstus NOT MATCHES "[NDR]" THEN
      RETURN
   END IF
   IF g_prdl_m.prdlstus MATCHES "[DR]" THEN
      LET g_prdl_m.prdlstus='N'
   END IF
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prdl_m_t.* = g_prdl_m.*
   LET g_prdl_m_o.* = g_prdl_m.*
   
   IF g_prdl_m.prdl001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_prdl001_t = g_prdl_m.prdl001
 
   CALL s_transaction_begin()
   
   OPEN aprm551_cl USING g_enterprise,g_prdl_m.prdl001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprm551_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprm551_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprm551_master_referesh USING g_prdl_m.prdl001 INTO g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002, 
       g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus, 
       g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012,g_prdl_m.prdl010, 
       g_prdl_m.prdl013,g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdl098,g_prdl_m.prdl017,g_prdl_m.prdl020, 
       g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdl022,g_prdl_m.prdl026,g_prdl_m.prdl023, 
       g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029,g_prdl_m.prdl030,g_prdl_m.prdl031,g_prdl_m.prdlcrtid, 
       g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlowndp,g_prdl_m.prdlmodid, 
       g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt,g_prdl_m.prdl018,g_prdl_m.prdl032,g_prdl_m.prdl019, 
       g_prdl_m.prdlunit_desc,g_prdl_m.prdl006_desc,g_prdl_m.prdl007_desc,g_prdl_m.prdl004_desc,g_prdl_m.prdl005_desc, 
       g_prdl_m.prdl008_desc,g_prdl_m.prdl009_desc,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp_desc,g_prdl_m.prdlownid_desc, 
       g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlcnfid_desc
   
   #檢查是否允許此動作
   IF NOT aprm551_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prdl_m_mask_o.* =  g_prdl_m.*
   CALL aprm551_prdl_t_mask()
   LET g_prdl_m_mask_n.* =  g_prdl_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
 
   
   CALL aprm551_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
 
    
   WHILE TRUE
      LET g_prdl001_t = g_prdl_m.prdl001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_prdl_m.prdlmodid = g_user 
LET g_prdl_m.prdlmoddt = cl_get_current()
LET g_prdl_m.prdlmodid_desc = cl_get_username(g_prdl_m.prdlmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aprm551_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE prdl_t SET (prdlmodid,prdlmoddt) = (g_prdl_m.prdlmodid,g_prdl_m.prdlmoddt)
          WHERE prdlent = g_enterprise AND prdl001 = g_prdl001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_prdl_m.* = g_prdl_m_t.*
            CALL aprm551_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_prdl_m.prdl001 != g_prdl_m_t.prdl001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE prdn_t SET prdn001 = g_prdl_m.prdl001
 
          WHERE prdnent = g_enterprise AND prdn001 = g_prdl_m_t.prdl001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prdn_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prdn_t:",SQLERRMESSAGE 
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
         
         UPDATE prds_t
            SET prds001 = g_prdl_m.prdl001
 
          WHERE prdsent = g_enterprise AND
                prds001 = g_prdl001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prds_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prds_t:",SQLERRMESSAGE 
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
         
         UPDATE prdr_t
            SET prdr001 = g_prdl_m.prdl001
 
          WHERE prdrent = g_enterprise AND
                prdr001 = g_prdl001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prdr_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prdr_t:",SQLERRMESSAGE 
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
   CALL aprm551_set_act_visible()   
   CALL aprm551_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " prdlent = " ||g_enterprise|| " AND",
                      " prdl001 = '", g_prdl_m.prdl001, "' "
 
   #填到對應位置
   CALL aprm551_browser_fill("")
 
   CLOSE aprm551_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprm551_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aprm551.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprm551_input(p_cmd)
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
   DEFINE  l_n1                  LIKE type_t.num5 
   DEFINE  l_prdl001             LIKE prdl_t.prdl001
   DEFINE  l_prdl002             LIKE prdl_t.prdl002
   DEFINE  l_cnt1                LIKE type_t.num5
   DEFINE  l_cnt2                LIKE type_t.num5
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
   DISPLAY BY NAME g_prdl_m.prdlunit,g_prdl_m.prdlunit_desc,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdll003, 
       g_prdl_m.prdl006,g_prdl_m.prdl006_desc,g_prdl_m.prdl007,g_prdl_m.prdl007_desc,g_prdl_m.prdl027, 
       g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl004,g_prdl_m.prdl004_desc,g_prdl_m.prdl005, 
       g_prdl_m.prdl005_desc,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012,g_prdl_m.prdl010,g_prdl_m.prdl013, 
       g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdo003,g_prdl_m.prdo004,g_prdl_m.prdl098,g_prdl_m.prdl017, 
       g_prdl_m.prdl020,g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl008_desc,g_prdl_m.prdl009,g_prdl_m.prdl009_desc, 
       g_prdl_m.prdl022,g_prdl_m.prdl026,g_prdl_m.prdl023,g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029, 
       g_prdl_m.prdl030,g_prdl_m.prdl031,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp, 
       g_prdl_m.prdlcrtdp_desc,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp, 
       g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid, 
       g_prdl_m.prdlcnfid_desc,g_prdl_m.prdlcnfdt,g_prdl_m.prdl018,g_prdl_m.prdl032,g_prdl_m.prdl019 
 
   
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
   LET g_forupd_sql = "SELECT prdnstus,prdn002,prdn003,prdn004,prdnsite,prdnunit FROM prdn_t WHERE prdnent=?  
       AND prdn001=? AND prdn002=? AND prdn003=? AND prdn004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprm551_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT prdsstus,prds002,prds000,prds003,prds005,prds006,prds008,prds009,prds010, 
       prds011,prds012,prds013,prds004,prds007,prdssite,prdsunit FROM prds_t WHERE prdsent=? AND prds001=?  
       AND prds002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprm551_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT prdrstus,prdr010,prdr002,prdr003,prdr004,prdr006,prdr007,prdr008,prdr009, 
       prdrsite,prdrunit,prdr005 FROM prdr_t WHERE prdrent=? AND prdr001=? AND prdr002=? AND prdr003=?  
       AND prdr004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprm551_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   LET g_forupd_sql = "SELECT prdvstus,prdu003,prdv003,prdv005,'',prdv007,'',prdv008,prdu005,prdu002
       FROM prdv_t ,prdu_t WHERE prdvent=prduent AND prdv001=prdu001 AND prdu002=prdv002 AND prdu004=0 AND prdvent=? AND prdv001=? AND prdv002=?  
       AND prdv003=? AND prdv005=? AND prdu003=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aprm551_bcl4 CURSOR FROM g_forupd_sql
   
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   LET g_errshow=1
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprm551_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aprm551_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdll003,g_prdl_m.prdl006, 
       g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl004, 
       g_prdl_m.prdl005,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012,g_prdl_m.prdl010,g_prdl_m.prdl013, 
       g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdo003,g_prdl_m.prdo004,g_prdl_m.prdl098,g_prdl_m.prdl017, 
       g_prdl_m.prdl020,g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdl022,g_prdl_m.prdl026, 
       g_prdl_m.prdl023,g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029,g_prdl_m.prdl030,g_prdl_m.prdl031, 
       g_prdl_m.prdl018,g_prdl_m.prdl032,g_prdl_m.prdl019
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_prdl_m_o.* = g_prdl_m.*
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aprm551.input.head" >}
      #單頭段
      INPUT BY NAME g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdll003,g_prdl_m.prdl006, 
          g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl004, 
          g_prdl_m.prdl005,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012,g_prdl_m.prdl010,g_prdl_m.prdl013, 
          g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdo003,g_prdl_m.prdo004,g_prdl_m.prdl098,g_prdl_m.prdl017, 
          g_prdl_m.prdl020,g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdl022,g_prdl_m.prdl026, 
          g_prdl_m.prdl023,g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029,g_prdl_m.prdl030,g_prdl_m.prdl031, 
          g_prdl_m.prdl018,g_prdl_m.prdl032,g_prdl_m.prdl019 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               CALL n_prdll(g_prdl_m.prdl001)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prdl_m.prdl001
               CALL ap_ref_array2(g_ref_fields," SELECT prdll003 FROM prdll_t WHERE prdllent = '"
                ||g_enterprise||"' AND prdll001 = ? AND prdll002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prdl_m.prdll003 = g_rtn_fields[1]
               DISPLAY BY NAME g_prdl_m.prdll003
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aprm551_cl USING g_enterprise,g_prdl_m.prdl001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprm551_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprm551_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.prdll001 = g_prdl_m.prdl001
LET g_master_multi_table_t.prdll003 = g_prdl_m.prdll003
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.prdll001 = ''
LET g_master_multi_table_t.prdll003 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aprm551_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL aprm551_set_entry(p_cmd)

            CALL aprm551_set_no_entry(p_cmd) 
            #end add-point
            CALL aprm551_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdlunit
            
            #add-point:AFTER FIELD prdlunit name="input.a.prdlunit"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdl_m.prdlunit
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdl_m.prdlunit_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdl_m.prdlunit_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlunit
            #add-point:BEFORE FIELD prdlunit name="input.b.prdlunit"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdlunit
            #add-point:ON CHANGE prdlunit name="input.g.prdlunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl001
            #add-point:BEFORE FIELD prdl001 name="input.b.prdl001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl001
            
            #add-point:AFTER FIELD prdl001 name="input.a.prdl001"
            IF NOT cl_null(g_prdl_m.prdl001) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prdl_m.prdl001 != g_prdl_m_t.prdl001 or g_prdl_m_t.prdl001 is null)) THEN    #170203-00002#9 20170206 mark by beckxie
               IF g_prdl_m.prdl001 != g_prdl_m_o.prdl001 OR cl_null(g_prdl_m_o.prdl001) THEN    #170203-00002#9 20170206 add by beckxie
                  CALL aprm551_chk_prdl001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prdl_m.prdl001
                     #160318-00005#39    By 07900  --add-str
                     LET g_errparam.replace[1] = 'aprm212'
                     LET g_errparam.replace[2] = cl_get_progname("aprm212",g_lang,"2")
                     LET g_errparam.exeprog = 'aprm212'
                     #160318-00005#39    By 07900  --add-end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prdl_m.prdl001 = g_prdl_m_t.prdl001   #170203-00002#9 20170206 mark by beckxie
                     #170203-00002#9 20170206 add by beckxie---S
                     LET g_prdl_m.prdl001 = g_prdl_m_o.prdl001
                     LET g_prdl_m.prdl002  = g_prdl_m_o.prdl002
                     LET g_prdl_m.prdl003  = g_prdl_m_o.prdl003
                     LET g_prdl_m.prdll003 = g_prdl_m_o.prdll003
                     LET g_prdl_m.prdl004  = g_prdl_m_o.prdl004
                     LET g_prdl_m.prdl005  = g_prdl_m_o.prdl005
                     LET g_prdl_m.prdl006  = g_prdl_m_o.prdl006
                     LET g_prdl_m.prdlstus = g_prdl_m_o.prdlstus
                     LET g_prdl_m.prdl007  = g_prdl_m_o.prdl007
                     LET g_prdl_m.prdl008  = g_prdl_m_o.prdl008
                     LET g_prdl_m.prdl009  = g_prdl_m_o.prdl009
                     LET g_prdl_m.prdl018  = g_prdl_m_o.prdl018
                     LET g_prdl_m.prdl019  = g_prdl_m_o.prdl019
                     LET g_prdl_m.prdl027  = g_prdl_m_o.prdl027
                     LET g_prdl_m.prdl028  = g_prdl_m_o.prdl028
                     LET g_prdl_m.prdo003  = g_prdl_m_o.prdo003
                     LET g_prdl_m.prdo004  = g_prdl_m_o.prdo004
                     LET g_prdl_m.prdl098  = g_prdl_m_o.prdl098
                     LET g_prdl_m.prdl019  = g_prdl_m_o.prdl019
                     LET g_prdl_m.prdl030  = g_prdl_m_o.prdl030
                     LET g_prdl_m.prdl031  = g_prdl_m_o.prdl031
                     LET g_prdl_m.prdl032  = g_prdl_m_o.prdl032
                     #170203-00002#9 20170206 add by beckxie---E
                     NEXT FIELD prdl001
                  END IF
                  
                  IF g_prdl_m.prdl001 != g_prdl_m_o.prdl001 OR cl_null(g_prdl_m_o.prdl001) THEN
                     CALL aprm551_prdl001_init()
                  END IF
               END IF
               
            END IF
            LET g_prdl_m_o.* = g_prdl_m.*
            CALL aprm551_set_entry(p_cmd)
            CALL aprm551_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl001
            #add-point:ON CHANGE prdl001 name="input.g.prdl001"
            CALL aprm551_set_entry(p_cmd)
            CALL aprm551_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl002
            #add-point:BEFORE FIELD prdl002 name="input.b.prdl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl002
            
            #add-point:AFTER FIELD prdl002 name="input.a.prdl002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl002
            #add-point:ON CHANGE prdl002 name="input.g.prdl002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdll003
            #add-point:BEFORE FIELD prdll003 name="input.b.prdll003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdll003
            
            #add-point:AFTER FIELD prdll003 name="input.a.prdll003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdll003
            #add-point:ON CHANGE prdll003 name="input.g.prdll003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl006
            
            #add-point:AFTER FIELD prdl006 name="input.a.prdl006"
            LET g_prdl_m.prdl006_desc = null
            DISPLAY BY NAME g_prdl_m.prdl006_desc
            IF NOT cl_null(g_prdl_m.prdl006) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prdl_m.prdl006 != g_prdl_m_t.prdl006 or g_prdl_m_t.prdl006 is null )) THEN   #170203-00002#9 20170206 mark by beckxie
               IF g_prdl_m.prdl006 != g_prdl_m_o.prdl006 OR cl_null(g_prdl_m_o.prdl006) THEN   #170203-00002#9 20170206 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prdl_m.prdl006
                  LET g_chkparam.arg2 = '2'
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="apr-00060:sub-01307|aprm201|",cl_get_progname("aprm201",g_lang,"2"),"|:EXEPROGaprm201"
                  #160318-00025#15 by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_prcf001_1") THEN
                  #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_prdl_m.prdl006 = g_prdl_m_t.prdl006   #170203-00002#9 20170206 mark by beckxie
                     #170203-00002#9 20170206 add by beckxie---S
                     LET g_prdl_m.prdl006 = g_prdl_m_o.prdl006  
                     LET g_prdl_m.prdl007      = g_prdl_m_o.prdl007
                     LET g_prdl_m.prdl007_desc = g_prdl_m_o.prdl007_desc
                     LET g_prdl_m.prdl008      = g_prdl_m_o.prdl008
                     LET g_prdl_m.prdl008_desc = g_prdl_m_o.prdl008_desc
                     LET g_prdl_m.prdl009      = g_prdl_m_o.prdl009
                     LET g_prdl_m.prdl009_desc = g_prdl_m_o.prdl009_desc                     
                     #170203-00002#9 20170206 add by beckxie---E
                     CALL aprm551_prdl006_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprm551_chk_prdl006()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prdl_m.prdl006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prdl_m.prdl006 = g_prdl_m_t.prdl006   #170203-00002#9 20170206 mark by beckxie
                     #170203-00002#9 20170206 add by beckxie---S
                     LET g_prdl_m.prdl006 = g_prdl_m_o.prdl006  
                     LET g_prdl_m.prdl007      = g_prdl_m_o.prdl007
                     LET g_prdl_m.prdl007_desc = g_prdl_m_o.prdl007_desc
                     LET g_prdl_m.prdl008      = g_prdl_m_o.prdl008
                     LET g_prdl_m.prdl008_desc = g_prdl_m_o.prdl008_desc
                     LET g_prdl_m.prdl009      = g_prdl_m_o.prdl009
                     LET g_prdl_m.prdl009_desc = g_prdl_m_o.prdl009_desc                     
                     #170203-00002#9 20170206 add by beckxie---E
                     CALL aprm551_prdl006_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprm551_create_prdl006()
               END IF

            END IF 
            CALL aprm551_prdl006_ref()
            LET g_prdl_m_o.* = g_prdl_m.*   #170203-00002#9 20170206 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl006
            #add-point:BEFORE FIELD prdl006 name="input.b.prdl006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl006
            #add-point:ON CHANGE prdl006 name="input.g.prdl006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl007
            
            #add-point:AFTER FIELD prdl007 name="input.a.prdl007"
            LET g_prdl_m.prdl007_desc = NULL
            DISPLAY BY NAME g_prdl_m.prdl007_desc
            IF NOT cl_null(g_prdl_m.prdl007) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prdl_m.prdl007 != g_prdl_m_t.prdl007 OR g_prdl_m_t.prdl007 IS NULL )) THEN   #170203-00002#9 20170206 mark by beckxie
               IF g_prdl_m.prdl007 != g_prdl_m_o.prdl007 OR cl_null(g_prdl_m_o.prdl007) THEN   #170203-00002#9 20170206 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prdl_m.prdl007
                  LET g_chkparam.arg2 = '2'
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="apr-00004:sub-01302|aprm200|",cl_get_progname("aprm200",g_lang,"2"),"|:EXEPROGaprm200"
                  #160318-00025#15 by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_prcd001_1") THEN
                  #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_prdl_m.prdl007 = g_prdl_m_t.prdl007   #170203-00002#9 20170206 mark by beckxie
                     #170203-00002#9 20170206 add by beckxie---S
                     LET g_prdl_m.prdl007      = g_prdl_m_o.prdl007
                     LET g_prdl_m.prdl008      = g_prdl_m_o.prdl008
                     LET g_prdl_m.prdl008_desc = g_prdl_m_o.prdl008_desc
                     LET g_prdl_m.prdl009      = g_prdl_m_o.prdl009
                     LET g_prdl_m.prdl009_desc = g_prdl_m_o.prdl009_desc
                     #170203-00002#9 20170206 add by beckxie---E
                     CALL aprm551_prdl007_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprm551_chk_prdl006()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prdl_m.prdl007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prdl_m.prdl007 = g_prdl_m_t.prdl007   #170203-00002#9 20170206 mark by beckxie
                     #170203-00002#9 20170206 add by beckxie---S
                     LET g_prdl_m.prdl007      = g_prdl_m_o.prdl007
                     LET g_prdl_m.prdl008      = g_prdl_m_o.prdl008
                     LET g_prdl_m.prdl008_desc = g_prdl_m_o.prdl008_desc
                     LET g_prdl_m.prdl009      = g_prdl_m_o.prdl009
                     LET g_prdl_m.prdl009_desc = g_prdl_m_o.prdl009_desc
                     #170203-00002#9 20170206 add by beckxie---E
                     CALL aprm551_prdl007_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprm551_create_prdl007()
               END IF
            END IF 
            CALL aprm551_prdl007_ref()
            LET g_prdl_m_o.* = g_prdl_m.*   #170203-00002#9 20170206 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl007
            #add-point:BEFORE FIELD prdl007 name="input.b.prdl007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl007
            #add-point:ON CHANGE prdl007 name="input.g.prdl007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl027
            #add-point:BEFORE FIELD prdl027 name="input.b.prdl027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl027
            
            #add-point:AFTER FIELD prdl027 name="input.a.prdl027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl027
            #add-point:ON CHANGE prdl027 name="input.g.prdl027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl099
            #add-point:BEFORE FIELD prdl099 name="input.b.prdl099"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl099
            
            #add-point:AFTER FIELD prdl099 name="input.a.prdl099"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl099
            #add-point:ON CHANGE prdl099 name="input.g.prdl099"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl100
            #add-point:BEFORE FIELD prdl100 name="input.b.prdl100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl100
            
            #add-point:AFTER FIELD prdl100 name="input.a.prdl100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl100
            #add-point:ON CHANGE prdl100 name="input.g.prdl100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlstus
            #add-point:BEFORE FIELD prdlstus name="input.b.prdlstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdlstus
            
            #add-point:AFTER FIELD prdlstus name="input.a.prdlstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdlstus
            #add-point:ON CHANGE prdlstus name="input.g.prdlstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl004
            
            #add-point:AFTER FIELD prdl004 name="input.a.prdl004"
            LET g_prdl_m.prdl004_desc = NULL
            DISPLAY BY NAME g_prdl_m.prdl004_desc
            IF NOT cl_null(g_prdl_m.prdl004) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prdl_m.prdl004 != g_prdl_m_t.prdl004 OR g_prdl_m_t.prdl004 IS NULL )) THEN   #170203-00002#9 20170206 mark by beckxie
               IF g_prdl_m.prdl004 != g_prdl_m_o.prdl004 OR cl_null(g_prdl_m_o.prdl004) THEN   #170203-00002#9 20170206 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1= g_prdl_m.prdl004
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#15 by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_prdl_m.prdl004 = g_prdl_m_t.prdl004   #170203-00002#9 20170206 mark by beckxie
                     #170203-00002#9 20170206 add by beckxie---S
                     LET g_prdl_m.prdl004 = g_prdl_m_o.prdl004
                     LET g_prdl_m.prdl005 = g_prdl_m_o.prdl005
                     LET g_prdl_m.prdl005_desc = g_prdl_m_o.prdl005_desc
                     #170203-00002#9 20170206 add by beckxie---E
                     CALL aprm551_prdl004_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprm551_create_prdl004()
               END IF

            END IF 
            CALL aprm551_prdl004_ref()
            LET g_prdl_m_o.* = g_prdl_m.*   #170203-00002#9 20170206 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl004
            #add-point:BEFORE FIELD prdl004 name="input.b.prdl004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl004
            #add-point:ON CHANGE prdl004 name="input.g.prdl004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl005
            
            #add-point:AFTER FIELD prdl005 name="input.a.prdl005"
            LET g_prdl_m.prdl005_desc = NULL
            DISPLAY BY NAME g_prdl_m.prdl005_desc
            IF NOT cl_null(g_prdl_m.prdl005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prdl_m.prdl005 != g_prdl_m_t.prdl005 OR g_prdl_m_t.prdl005 IS NULL )) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prdl_m.prdl005
                  LET g_chkparam.arg2 = g_today
                   #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#15 by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prdl_m.prdl005 = g_prdl_m_t.prdl005
                     CALL aprm551_prdl005_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprm551_chk_prdl004()
                  IF NOT cl_null(g_errno) THEN
                     LET g_prdl_m.prdl005 = g_prdl_m_t.prdl005
                     CALL aprm551_prdl005_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            CALL aprm551_prdl005_ref()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl005
            #add-point:BEFORE FIELD prdl005 name="input.b.prdl005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl005
            #add-point:ON CHANGE prdl005 name="input.g.prdl005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdlsite
            #add-point:BEFORE FIELD prdlsite name="input.b.prdlsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdlsite
            
            #add-point:AFTER FIELD prdlsite name="input.a.prdlsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdlsite
            #add-point:ON CHANGE prdlsite name="input.g.prdlsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl003
            #add-point:BEFORE FIELD prdl003 name="input.b.prdl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl003
            
            #add-point:AFTER FIELD prdl003 name="input.a.prdl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl003
            #add-point:ON CHANGE prdl003 name="input.g.prdl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl012
            #add-point:BEFORE FIELD prdl012 name="input.b.prdl012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl012
            
            #add-point:AFTER FIELD prdl012 name="input.a.prdl012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl012
            #add-point:ON CHANGE prdl012 name="input.g.prdl012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl010
            #add-point:BEFORE FIELD prdl010 name="input.b.prdl010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl010
            
            #add-point:AFTER FIELD prdl010 name="input.a.prdl010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl010
            #add-point:ON CHANGE prdl010 name="input.g.prdl010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl013
            #add-point:BEFORE FIELD prdl013 name="input.b.prdl013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl013
            
            #add-point:AFTER FIELD prdl013 name="input.a.prdl013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl013
            #add-point:ON CHANGE prdl013 name="input.g.prdl013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl011
            #add-point:BEFORE FIELD prdl011 name="input.b.prdl011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl011
            
            #add-point:AFTER FIELD prdl011 name="input.a.prdl011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl011
            #add-point:ON CHANGE prdl011 name="input.g.prdl011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdl_m.prdl014,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prdl014
            END IF 
 
 
 
            #add-point:AFTER FIELD prdl014 name="input.a.prdl014"
            IF NOT cl_null(g_prdl_m.prdl014) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl014
            #add-point:BEFORE FIELD prdl014 name="input.b.prdl014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl014
            #add-point:ON CHANGE prdl014 name="input.g.prdl014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo003
            #add-point:BEFORE FIELD prdo003 name="input.b.prdo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo003
            
            #add-point:AFTER FIELD prdo003 name="input.a.prdo003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdo003
            #add-point:ON CHANGE prdo003 name="input.g.prdo003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdo004
            #add-point:BEFORE FIELD prdo004 name="input.b.prdo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdo004
            
            #add-point:AFTER FIELD prdo004 name="input.a.prdo004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdo004
            #add-point:ON CHANGE prdo004 name="input.g.prdo004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl098
            #add-point:BEFORE FIELD prdl098 name="input.b.prdl098"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl098
            
            #add-point:AFTER FIELD prdl098 name="input.a.prdl098"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl098
            #add-point:ON CHANGE prdl098 name="input.g.prdl098"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl017
            #add-point:BEFORE FIELD prdl017 name="input.b.prdl017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl017
            
            #add-point:AFTER FIELD prdl017 name="input.a.prdl017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl017
            #add-point:ON CHANGE prdl017 name="input.g.prdl017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl020
            #add-point:BEFORE FIELD prdl020 name="input.b.prdl020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl020
            
            #add-point:AFTER FIELD prdl020 name="input.a.prdl020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl020
            #add-point:ON CHANGE prdl020 name="input.g.prdl020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl021
            #add-point:BEFORE FIELD prdl021 name="input.b.prdl021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl021
            
            #add-point:AFTER FIELD prdl021 name="input.a.prdl021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl021
            #add-point:ON CHANGE prdl021 name="input.g.prdl021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl008
            
            #add-point:AFTER FIELD prdl008 name="input.a.prdl008"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdl_m.prdl008
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2100' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdl_m.prdl008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdl_m.prdl008_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl008
            #add-point:BEFORE FIELD prdl008 name="input.b.prdl008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl008
            #add-point:ON CHANGE prdl008 name="input.g.prdl008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl009
            
            #add-point:AFTER FIELD prdl009 name="input.a.prdl009"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdl_m.prdl009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdl_m.prdl009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdl_m.prdl009_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl009
            #add-point:BEFORE FIELD prdl009 name="input.b.prdl009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl009
            #add-point:ON CHANGE prdl009 name="input.g.prdl009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdl_m.prdl022,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prdl022
            END IF 
 
 
 
            #add-point:AFTER FIELD prdl022 name="input.a.prdl022"
            IF NOT cl_null(g_prdl_m.prdl022) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl022
            #add-point:BEFORE FIELD prdl022 name="input.b.prdl022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl022
            #add-point:ON CHANGE prdl022 name="input.g.prdl022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl026
            #add-point:BEFORE FIELD prdl026 name="input.b.prdl026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl026
            
            #add-point:AFTER FIELD prdl026 name="input.a.prdl026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl026
            #add-point:ON CHANGE prdl026 name="input.g.prdl026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl023
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdl_m.prdl023,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prdl023
            END IF 
 
 
 
            #add-point:AFTER FIELD prdl023 name="input.a.prdl023"
            IF NOT cl_null(g_prdl_m.prdl023) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl023
            #add-point:BEFORE FIELD prdl023 name="input.b.prdl023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl023
            #add-point:ON CHANGE prdl023 name="input.g.prdl023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl025
            #add-point:BEFORE FIELD prdl025 name="input.b.prdl025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl025
            
            #add-point:AFTER FIELD prdl025 name="input.a.prdl025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl025
            #add-point:ON CHANGE prdl025 name="input.g.prdl025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl028
            #add-point:BEFORE FIELD prdl028 name="input.b.prdl028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl028
            
            #add-point:AFTER FIELD prdl028 name="input.a.prdl028"

            IF NOT cl_null(g_prdl_m.prdl028) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prdl_m.prdl028 != g_prdl_m_t.prdl028 OR g_prdl_m_t.prdl028 IS NULL )) THEN   #170203-00002#9 20170206 mark by beckxie
               IF g_prdl_m.prdl028 != g_prdl_m_o.prdl028 OR cl_null(g_prdl_m_o.prdl028) THEN   #170203-00002#9 20170206 add by beckxie
                  CALL aprm551_chk_prdl028()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prdl_m.prdl028
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prdl_m.prdl028 = g_prdl_m_t.prdl028   #170203-00002#9 20170206 mark by beckxie
                     #170203-00002#9 20170206 add by beckxie---S
                     LET g_prdl_m.prdl028 = g_prdl_m_o.prdl028
                     LET g_prdl_m.prdl029 = g_prdl_m_o.prdl029
                     LET g_prdl_m.prdl030 = g_prdl_m_o.prdl030
                     LET g_prdl_m.prdl031 = g_prdl_m_o.prdl031
                     #170203-00002#9 20170206 add by beckxie---E
                     NEXT FIELD CURRENT
                  END IF
                 
               END IF

            END IF 
            IF g_prdl_m.prdl028='1' THEN
               LET g_prdl_m.prdl029 = NULL
               LET g_prdl_m.prdl030 = NULL
               LET g_prdl_m.prdl031 = NULL
               DISPLAY BY NAME g_prdl_m.prdl029,g_prdl_m.prdl030,g_prdl_m.prdl031
               CALL cl_set_comp_entry("prdl029,prdl030,prdl031",false)
            ELSE
               CALL cl_set_comp_entry("prdl029,prdl030,prdl031",true)
            END IF
            LET g_prdl_m_o.* = g_prdl_m.*   #170203-00002#9 20170206 add by beckxie
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl028
            #add-point:ON CHANGE prdl028 name="input.g.prdl028"
            #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prdl_m.prdl028 != g_prdl_m_t.prdl028 OR g_prdl_m_t.prdl028 IS NULL )) THEN   #170203-00002#9 20170206 mark by beckxie
            IF g_prdl_m.prdl028 != g_prdl_m_o.prdl028 OR cl_null(g_prdl_m_o.prdl028) THEN   #170203-00002#9 20170206 add by beckxie
               CALL aprm551_chk_prdl028()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prdl_m.prdl028
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_prdl_m.prdl028 = g_prdl_m_t.prdl028   #170203-00002#9 20170206 mark by beckxie
                  #170203-00002#9 20170206 add by beckxie---S
                  LET g_prdl_m.prdl028 = g_prdl_m_o.prdl028
                  LET g_prdl_m.prdl029 = g_prdl_m_o.prdl029
                  LET g_prdl_m.prdl030 = g_prdl_m_o.prdl030
                  LET g_prdl_m.prdl031 = g_prdl_m_o.prdl031
                  #170203-00002#9 20170206 add by beckxie---E
                  NEXT FIELD CURRENT
               END IF
                 
            END IF
            IF g_prdl_m.prdl028='1' THEN
               LET g_prdl_m.prdl029 = NULL
               LET g_prdl_m.prdl030 = NULL
               LET g_prdl_m.prdl031 = NULL
               DISPLAY BY NAME g_prdl_m.prdl029,g_prdl_m.prdl030,g_prdl_m.prdl031
               CALL cl_set_comp_entry("prdl029,prdl030,prdl031",false)
            ELSE
               CALL cl_set_comp_entry("prdl029,prdl030,prdl031",true)
            END IF
            LET g_prdl_m_o.* = g_prdl_m.*   #170203-00002#9 20170206 add by beckxie
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl029
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdl_m.prdl029,"0.000000","1","100.000000","1","azz-00087",1) THEN
               NEXT FIELD prdl029
            END IF 
 
 
 
            #add-point:AFTER FIELD prdl029 name="input.a.prdl029"
            IF NOT cl_null(g_prdl_m.prdl029) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl029
            #add-point:BEFORE FIELD prdl029 name="input.b.prdl029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl029
            #add-point:ON CHANGE prdl029 name="input.g.prdl029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl030
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdl_m.prdl030,"0.000000","1","100.000000","1","azz-00087",1) THEN
               NEXT FIELD prdl030
            END IF 
 
 
 
            #add-point:AFTER FIELD prdl030 name="input.a.prdl030"
            IF NOT cl_null(g_prdl_m.prdl030) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl030
            #add-point:BEFORE FIELD prdl030 name="input.b.prdl030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl030
            #add-point:ON CHANGE prdl030 name="input.g.prdl030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl031
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdl_m.prdl031,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD prdl031
            END IF 
 
 
 
            #add-point:AFTER FIELD prdl031 name="input.a.prdl031"
            IF NOT cl_null(g_prdl_m.prdl031) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl031
            #add-point:BEFORE FIELD prdl031 name="input.b.prdl031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl031
            #add-point:ON CHANGE prdl031 name="input.g.prdl031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl018
            #add-point:BEFORE FIELD prdl018 name="input.b.prdl018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl018
            
            #add-point:AFTER FIELD prdl018 name="input.a.prdl018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl018
            #add-point:ON CHANGE prdl018 name="input.g.prdl018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl032
            #add-point:BEFORE FIELD prdl032 name="input.b.prdl032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl032
            
            #add-point:AFTER FIELD prdl032 name="input.a.prdl032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl032
            #add-point:ON CHANGE prdl032 name="input.g.prdl032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdl019
            #add-point:BEFORE FIELD prdl019 name="input.b.prdl019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdl019
            
            #add-point:AFTER FIELD prdl019 name="input.a.prdl019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdl019
            #add-point:ON CHANGE prdl019 name="input.g.prdl019"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.prdlunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdlunit
            #add-point:ON ACTION controlp INFIELD prdlunit name="input.c.prdlunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl001
            #add-point:ON ACTION controlp INFIELD prdl001 name="input.c.prdl001"
            #此段落由子樣板a07產生            
            #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE

               LET g_qryparam.default1 = g_prdl_m.prdl001             #給予default值
               LET g_qryparam.where = " prdlunit = '",g_site,"'"
               #給予arg
               LET g_qryparam.arg1 = '31'
               LET g_qryparam.arg2 = '2'
            
               CALL q_prdl001()                                #呼叫開窗

               LET g_prdl_m.prdl001 = g_qryparam.return1              
 
               DISPLAY g_prdl_m.prdl001 TO prdl001              #

               NEXT FIELD prdl001                          #返回原欄位
            

            #END add-point
 
 
         #Ctrlp:input.c.prdl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl002
            #add-point:ON ACTION controlp INFIELD prdl002 name="input.c.prdl002"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdll003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdll003
            #add-point:ON ACTION controlp INFIELD prdll003 name="input.c.prdll003"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl006
            #add-point:ON ACTION controlp INFIELD prdl006 name="input.c.prdl006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdl_m.prdl006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2" #
            IF NOT cl_null(g_prdl_m.prdl007) THEN
               LET g_qryparam.where  = "prcf002='",g_prdl_m.prdl007,"'"
            END IF
            
            CALL q_prcf001()                                #呼叫開窗

            LET g_prdl_m.prdl006 = g_qryparam.return1              

            DISPLAY g_prdl_m.prdl006 TO prdl006              #
            IF NOT cl_null(g_prdl_m.prdl006) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prdl_m.prdl006 != g_prdl_m_t.prdl006 or g_prdl_m_t.prdl006 is null )) THEN   #170203-00002#9 20170206 mark by beckxie
               IF g_prdl_m.prdl006 != g_prdl_m_o.prdl006 OR cl_null(g_prdl_m_o.prdl006) THEN   #170203-00002#9 20170206 add by beckxie
                  CALL aprm551_chk_prdl006()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prdl_m.prdl006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prdl_m.prdl006 = g_prdl_m_t.prdl006   #170203-00002#9 20170206 mark by beckxie
                     #170203-00002#9 20170206 add by beckxie---S
                     LET g_prdl_m.prdl006 = g_prdl_m_o.prdl006  
                     LET g_prdl_m.prdl007      = g_prdl_m_o.prdl007
                     LET g_prdl_m.prdl007_desc = g_prdl_m_o.prdl007_desc
                     LET g_prdl_m.prdl008      = g_prdl_m_o.prdl008
                     LET g_prdl_m.prdl008_desc = g_prdl_m_o.prdl008_desc
                     LET g_prdl_m.prdl009      = g_prdl_m_o.prdl009
                     LET g_prdl_m.prdl009_desc = g_prdl_m_o.prdl009_desc                     
                     #170203-00002#9 20170206 add by beckxie---E
                     CALL aprm551_prdl006_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprm551_create_prdl006()
               END IF

            END IF 
            CALL aprm551_prdl006_ref()
            NEXT FIELD prdl006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prdl007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl007
            #add-point:ON ACTION controlp INFIELD prdl007 name="input.c.prdl007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdl_m.prdl007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2" #
            IF NOT cl_null(g_prdl_m.prdl006) THEN
               LET g_qryparam.where = "prcd001 IN (SELECT prcf002 FROM prcf_t WHERE prcf001='",g_prdl_m.prdl006,"' AND prcfent=",g_enterprise,")"
            END IF
            
            CALL q_prcd001_1()                                #呼叫開窗

            LET g_prdl_m.prdl007 = g_qryparam.return1              

            DISPLAY g_prdl_m.prdl007 TO prdl007              #
            IF NOT cl_null(g_prdl_m.prdl007) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prdl_m.prdl007 != g_prdl_m_t.prdl007 OR g_prdl_m_t.prdl007 IS NULL )) THEN     #170203-00002#9 20170206 mark by beckxie
               IF g_prdl_m.prdl007 != g_prdl_m_o.prdl007 OR cl_null(g_prdl_m_o.prdl007) THEN     #170203-00002#9 20170206 add by beckxie
                  
                  CALL aprm551_chk_prdl006()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prdl_m.prdl007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prdl_m.prdl007 = g_prdl_m_t.prdl007   #170203-00002#9 20170206 mark by beckxie
                     #170203-00002#9 20170206 add by beckxie---S
                     LET g_prdl_m.prdl007      = g_prdl_m_o.prdl007
                     LET g_prdl_m.prdl008      = g_prdl_m_o.prdl008
                     LET g_prdl_m.prdl008_desc = g_prdl_m_o.prdl008_desc
                     LET g_prdl_m.prdl009      = g_prdl_m_o.prdl009
                     LET g_prdl_m.prdl009_desc = g_prdl_m_o.prdl009_desc
                     #170203-00002#9 20170206 add by beckxie---E
                     CALL aprm551_prdl007_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprm551_create_prdl007()
               END IF
            END IF 
            CALL aprm551_prdl007_ref()
            NEXT FIELD prdl007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prdl027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl027
            #add-point:ON ACTION controlp INFIELD prdl027 name="input.c.prdl027"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl099
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl099
            #add-point:ON ACTION controlp INFIELD prdl099 name="input.c.prdl099"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl100
            #add-point:ON ACTION controlp INFIELD prdl100 name="input.c.prdl100"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdlstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdlstus
            #add-point:ON ACTION controlp INFIELD prdlstus name="input.c.prdlstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl004
            #add-point:ON ACTION controlp INFIELD prdl004 name="input.c.prdl004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdl_m.prdl004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_prdl_m.prdl004 = g_qryparam.return1              

            DISPLAY g_prdl_m.prdl004 TO prdl004              #
            IF NOT cl_null(g_prdl_m.prdl004) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prdl_m.prdl004 != g_prdl_m_t.prdl004 OR g_prdl_m_t.prdl004 IS NULL )) THEN   #170203-00002#9 20170206 mark by beckxie
               IF g_prdl_m.prdl004 != g_prdl_m_o.prdl004 OR cl_null(g_prdl_m_o.prdl004) THEN   #170203-00002#9 20170206 add by beckxie
                  CALL aprm551_create_prdl004()
               END IF

            END IF 
            CALL aprm551_prdl004_ref()
            NEXT FIELD prdl004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prdl005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl005
            #add-point:ON ACTION controlp INFIELD prdl005 name="input.c.prdl005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdl_m.prdl005             #給予default值
            LET g_qryparam.default2 = "" #g_prdl_m.ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_today #

            
            CALL q_ooeg001()                                #呼叫開窗

            LET g_prdl_m.prdl005 = g_qryparam.return1              
            #LET g_prdl_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_prdl_m.prdl005 TO prdl005              #
            #DISPLAY g_prdl_m.ooeg001 TO ooeg001 #部門編號
            CALL aprm551_prdl005_ref()
            NEXT FIELD prdl005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prdlsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdlsite
            #add-point:ON ACTION controlp INFIELD prdlsite name="input.c.prdlsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl003
            #add-point:ON ACTION controlp INFIELD prdl003 name="input.c.prdl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl012
            #add-point:ON ACTION controlp INFIELD prdl012 name="input.c.prdl012"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl010
            #add-point:ON ACTION controlp INFIELD prdl010 name="input.c.prdl010"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl013
            #add-point:ON ACTION controlp INFIELD prdl013 name="input.c.prdl013"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl011
            #add-point:ON ACTION controlp INFIELD prdl011 name="input.c.prdl011"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl014
            #add-point:ON ACTION controlp INFIELD prdl014 name="input.c.prdl014"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdo003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo003
            #add-point:ON ACTION controlp INFIELD prdo003 name="input.c.prdo003"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdo004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdo004
            #add-point:ON ACTION controlp INFIELD prdo004 name="input.c.prdo004"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl098
            #add-point:ON ACTION controlp INFIELD prdl098 name="input.c.prdl098"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl017
            #add-point:ON ACTION controlp INFIELD prdl017 name="input.c.prdl017"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl020
            #add-point:ON ACTION controlp INFIELD prdl020 name="input.c.prdl020"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl021
            #add-point:ON ACTION controlp INFIELD prdl021 name="input.c.prdl021"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl008
            #add-point:ON ACTION controlp INFIELD prdl008 name="input.c.prdl008"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl009
            #add-point:ON ACTION controlp INFIELD prdl009 name="input.c.prdl009"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl022
            #add-point:ON ACTION controlp INFIELD prdl022 name="input.c.prdl022"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl026
            #add-point:ON ACTION controlp INFIELD prdl026 name="input.c.prdl026"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl023
            #add-point:ON ACTION controlp INFIELD prdl023 name="input.c.prdl023"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl025
            #add-point:ON ACTION controlp INFIELD prdl025 name="input.c.prdl025"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl028
            #add-point:ON ACTION controlp INFIELD prdl028 name="input.c.prdl028"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl029
            #add-point:ON ACTION controlp INFIELD prdl029 name="input.c.prdl029"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl030
            #add-point:ON ACTION controlp INFIELD prdl030 name="input.c.prdl030"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl031
            #add-point:ON ACTION controlp INFIELD prdl031 name="input.c.prdl031"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl018
            #add-point:ON ACTION controlp INFIELD prdl018 name="input.c.prdl018"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl032
            #add-point:ON ACTION controlp INFIELD prdl032 name="input.c.prdl032"
            
            #END add-point
 
 
         #Ctrlp:input.c.prdl019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdl019
            #add-point:ON ACTION controlp INFIELD prdl019 name="input.c.prdl019"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_prdl_m.prdl001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO prdl_t (prdlent,prdlunit,prdl001,prdl002,prdl006,prdl007,prdl027,prdl099, 
                   prdl100,prdlstus,prdl004,prdl005,prdlsite,prdl003,prdl012,prdl010,prdl013,prdl011, 
                   prdl014,prdl098,prdl017,prdl020,prdl021,prdl008,prdl009,prdl022,prdl026,prdl023,prdl025, 
                   prdl028,prdl029,prdl030,prdl031,prdlcrtid,prdlcrtdp,prdlcrtdt,prdlownid,prdlowndp, 
                   prdlmodid,prdlmoddt,prdlcnfid,prdlcnfdt,prdl018,prdl032,prdl019)
               VALUES (g_enterprise,g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdl006, 
                   g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus, 
                   g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012, 
                   g_prdl_m.prdl010,g_prdl_m.prdl013,g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdl098, 
                   g_prdl_m.prdl017,g_prdl_m.prdl020,g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl009, 
                   g_prdl_m.prdl022,g_prdl_m.prdl026,g_prdl_m.prdl023,g_prdl_m.prdl025,g_prdl_m.prdl028, 
                   g_prdl_m.prdl029,g_prdl_m.prdl030,g_prdl_m.prdl031,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtdp, 
                   g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlowndp,g_prdl_m.prdlmodid,g_prdl_m.prdlmoddt, 
                   g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt,g_prdl_m.prdl018,g_prdl_m.prdl032,g_prdl_m.prdl019)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_prdl_m:",SQLERRMESSAGE 
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
         IF g_prdl_m.prdl001 = g_master_multi_table_t.prdll001 AND
         g_prdl_m.prdll003 = g_master_multi_table_t.prdll003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'prdllent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_prdl_m.prdl001
            LET l_field_keys[02] = 'prdll001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.prdll001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'prdll002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_prdl_m.prdll003
            LET l_fields[01] = 'prdll003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'prdll_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
                 
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aprm551_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aprm551_b_fill()
                  CALL aprm551_b_fill2('0')
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
               CALL aprm551_prdl_t_mask_restore('restore_mask_o')
               
               UPDATE prdl_t SET (prdlunit,prdl001,prdl002,prdl006,prdl007,prdl027,prdl099,prdl100,prdlstus, 
                   prdl004,prdl005,prdlsite,prdl003,prdl012,prdl010,prdl013,prdl011,prdl014,prdl098, 
                   prdl017,prdl020,prdl021,prdl008,prdl009,prdl022,prdl026,prdl023,prdl025,prdl028,prdl029, 
                   prdl030,prdl031,prdlcrtid,prdlcrtdp,prdlcrtdt,prdlownid,prdlowndp,prdlmodid,prdlmoddt, 
                   prdlcnfid,prdlcnfdt,prdl018,prdl032,prdl019) = (g_prdl_m.prdlunit,g_prdl_m.prdl001, 
                   g_prdl_m.prdl002,g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099, 
                   g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdlsite, 
                   g_prdl_m.prdl003,g_prdl_m.prdl012,g_prdl_m.prdl010,g_prdl_m.prdl013,g_prdl_m.prdl011, 
                   g_prdl_m.prdl014,g_prdl_m.prdl098,g_prdl_m.prdl017,g_prdl_m.prdl020,g_prdl_m.prdl021, 
                   g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdl022,g_prdl_m.prdl026,g_prdl_m.prdl023, 
                   g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029,g_prdl_m.prdl030,g_prdl_m.prdl031, 
                   g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlowndp, 
                   g_prdl_m.prdlmodid,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt,g_prdl_m.prdl018, 
                   g_prdl_m.prdl032,g_prdl_m.prdl019)
                WHERE prdlent = g_enterprise AND prdl001 = g_prdl001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "prdl_t:",SQLERRMESSAGE 
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
         IF g_prdl_m.prdl001 = g_master_multi_table_t.prdll001 AND
         g_prdl_m.prdll003 = g_master_multi_table_t.prdll003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'prdllent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_prdl_m.prdl001
            LET l_field_keys[02] = 'prdll001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.prdll001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'prdll002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_prdl_m.prdll003
            LET l_fields[01] = 'prdll003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'prdll_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL aprm551_prdl_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_prdl_m_t)
               LET g_log2 = util.JSON.stringify(g_prdl_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_prdl001_t = g_prdl_m.prdl001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aprm551.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prdn_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prdn_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprm551_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_prdn_d.getLength()
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
            OPEN aprm551_cl USING g_enterprise,g_prdl_m.prdl001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprm551_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprm551_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prdn_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prdn_d[l_ac].prdn002 IS NOT NULL
               AND g_prdn_d[l_ac].prdn003 IS NOT NULL
               AND g_prdn_d[l_ac].prdn004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prdn_d_t.* = g_prdn_d[l_ac].*  #BACKUP
               LET g_prdn_d_o.* = g_prdn_d[l_ac].*  #BACKUP
               CALL aprm551_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aprm551_set_no_entry_b(l_cmd)
               IF NOT aprm551_lock_b("prdn_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprm551_bcl INTO g_prdn_d[l_ac].prdnstus,g_prdn_d[l_ac].prdn002,g_prdn_d[l_ac].prdn003, 
                      g_prdn_d[l_ac].prdn004,g_prdn_d[l_ac].prdnsite,g_prdn_d[l_ac].prdnunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_prdn_d_t.prdn002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prdn_d_mask_o[l_ac].* =  g_prdn_d[l_ac].*
                  CALL aprm551_prdn_t_mask()
                  LET g_prdn_d_mask_n[l_ac].* =  g_prdn_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprm551_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF l_cmd = 'u' THEN
               CALL cl_set_comp_entry("prdn002",false)
            ELSE
               CALL cl_set_comp_entry("prdn002",true)
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
            INITIALIZE g_prdn_d[l_ac].* TO NULL 
            INITIALIZE g_prdn_d_t.* TO NULL 
            INITIALIZE g_prdn_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prdn_d[l_ac].prdnstus = 'N'
 
 
 
            #自定義預設值
                  LET g_prdn_d[l_ac].prdnstus = "Y"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_prdn_d_t.* = g_prdn_d[l_ac].*     #新輸入資料
            LET g_prdn_d_o.* = g_prdn_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprm551_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aprm551_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prdn_d[li_reproduce_target].* = g_prdn_d[li_reproduce].*
 
               LET g_prdn_d[li_reproduce_target].prdn002 = NULL
               LET g_prdn_d[li_reproduce_target].prdn003 = NULL
               LET g_prdn_d[li_reproduce_target].prdn004 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"

            LET g_prdn_d[l_ac].prdnunit = g_prdl_m.prdlunit
            LET g_prdn_d[l_ac].prdnsite = g_prdl_m.prdlsite
            CALL aprm551_create_prdn002()
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
            SELECT COUNT(1) INTO l_count FROM prdn_t 
             WHERE prdnent = g_enterprise AND prdn001 = g_prdl_m.prdl001
 
               AND prdn002 = g_prdn_d[l_ac].prdn002
               AND prdn003 = g_prdn_d[l_ac].prdn003
               AND prdn004 = g_prdn_d[l_ac].prdn004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys[2] = g_prdn_d[g_detail_idx].prdn002
               LET gs_keys[3] = g_prdn_d[g_detail_idx].prdn003
               LET gs_keys[4] = g_prdn_d[g_detail_idx].prdn004
               CALL aprm551_insert_b('prdn_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_prdn_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prdn_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprm551_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               CALL aprm551_ins_prdn_prdb()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = "prdn_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT
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
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_prdl_m.prdl001
 
               LET gs_keys[gs_keys.getLength()+1] = g_prdn_d_t.prdn002
               LET gs_keys[gs_keys.getLength()+1] = g_prdn_d_t.prdn003
               LET gs_keys[gs_keys.getLength()+1] = g_prdn_d_t.prdn004
 
            
               #刪除同層單身
               IF NOT aprm551_delete_b('prdn_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm551_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprm551_key_delete_b(gs_keys,'prdn_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm551_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aprm551_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                                    
               #end add-point
               LET l_count = g_prdn_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prdn_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdnstus
            #add-point:BEFORE FIELD prdnstus name="input.b.page1.prdnstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdnstus
            
            #add-point:AFTER FIELD prdnstus name="input.a.page1.prdnstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdnstus
            #add-point:ON CHANGE prdnstus name="input.g.page1.prdnstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdn002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdn_d[l_ac].prdn002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD prdn002
            END IF 
 
 
 
            #add-point:AFTER FIELD prdn002 name="input.a.page1.prdn002"
            IF NOT cl_null(g_prdn_d[l_ac].prdn002) THEN 
            END IF 


            #此段落由子樣板a05產生
            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdn002
            #add-point:BEFORE FIELD prdn002 name="input.b.page1.prdn002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdn002
            #add-point:ON CHANGE prdn002 name="input.g.page1.prdn002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdn003
            #add-point:BEFORE FIELD prdn003 name="input.b.page1.prdn003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdn003
            
            #add-point:AFTER FIELD prdn003 name="input.a.page1.prdn003"
            #此段落由子樣板a05產生
            


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdn003
            #add-point:ON CHANGE prdn003 name="input.g.page1.prdn003"
            LET g_prdn_d[l_ac].prdn004 = ""
            LET g_prdn_d[l_ac].prdn004_desc = ""
            DISPLAY BY NAME g_prdn_d[l_ac].prdn004,g_prdn_d[l_ac].prdn004_desc
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdn004
            
            #add-point:AFTER FIELD prdn004 name="input.a.page1.prdn004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdn_d[l_ac].prdn004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdn_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdn_d[l_ac].prdn004_desc


            #此段落由子樣板a05產生
            LET g_prdn_d[l_ac].prdn004_desc = null
            DISPLAY BY NAME g_prdn_d[l_ac].prdn004_desc
            IF  g_prdl_m.prdl001 IS NOT NULL AND g_prdn_d[g_detail_idx].prdn002 IS NOT NULL AND g_prdn_d[g_detail_idx].prdn003 IS NOT NULL AND g_prdn_d[g_detail_idx].prdn004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prdn_d[g_detail_idx].prdn002 != g_prdn_d_t.prdn002 OR g_prdn_d[g_detail_idx].prdn003 != g_prdn_d_t.prdn003 OR g_prdn_d[g_detail_idx].prdn004 != g_prdn_d_t.prdn004)) THEN 
                  
                  IF NOT cl_null(g_prdn_d[l_ac].prdn004) THEN
               
                     CASE g_prdn_d[l_ac].prdn003
                        WHEN '1'
                           #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                           INITIALIZE g_chkparam.* TO NULL
                            #160318-00025#15 by 07900 --add-str 
                           LET g_errshow = TRUE #是否開窗
                            #160318-00025#15 by 07900 --add-end
                           #設定g_chkparam.*的參數
                           LET g_chkparam.arg1 = g_prdn_d[l_ac].prdn004
                           #160318-00025#15 by 07900 --add-str 
                           LET g_chkparam.err_str[1] ="apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
                           #160318-00025#15 by 07900 --add-end 
                           #呼叫檢查存在並帶值的library
                           IF NOT cl_chk_exist("v_pmaa001_10") THEN
                              LET g_prdn_d[l_ac].prdn004 = g_prdn_d_t.prdn004
                              CALL aprm551_prdn004_ref()
                              NEXT FIELD CURRENT
                           END IF
                        WHEN '2'
                           IF NOT s_azzi650_chk_exist('281',g_prdn_d[l_ac].prdn004) THEN
                              LET g_prdn_d[l_ac].prdn004 = g_prdn_d_t.prdn004
                              CALL aprm551_prdn004_ref()
                              NEXT FIELD CURRENT
                           END IF
                        WHEN '3'
                           IF NOT s_azzi650_chk_exist('2061',g_prdn_d[l_ac].prdn004) THEN
                              LET g_prdn_d[l_ac].prdn004 = g_prdn_d_t.prdn004
                              CALL aprm551_prdn004_ref()
                              NEXT FIELD CURRENT
                           END IF
                        WHEN '4'
                           IF NOT s_azzi650_chk_exist('2062',g_prdn_d[l_ac].prdn004) THEN
                              LET g_prdn_d[l_ac].prdn004 = g_prdn_d_t.prdn004
                              CALL aprm551_prdn004_ref()
                              NEXT FIELD CURRENT
                           END IF
                        WHEN '5'
                           IF NOT s_azzi650_chk_exist('2063',g_prdn_d[l_ac].prdn004) THEN
                              LET g_prdn_d[l_ac].prdn004 = g_prdn_d_t.prdn004
                              CALL aprm551_prdn004_ref()
                              NEXT FIELD CURRENT
                           END IF
                        WHEN '6'
                           IF NOT s_azzi650_chk_exist('2064',g_prdn_d[l_ac].prdn004) THEN
                              LET g_prdn_d[l_ac].prdn004 = g_prdn_d_t.prdn004
                              CALL aprm551_prdn004_ref()
                              NEXT FIELD CURRENT
                           END IF
                        WHEN '7'
                           IF NOT s_azzi650_chk_exist('2065',g_prdn_d[l_ac].prdn004) THEN
                              LET g_prdn_d[l_ac].prdn004 = g_prdn_d_t.prdn004
                              CALL aprm551_prdn004_ref()
                              NEXT FIELD CURRENT
                           END IF
                        WHEN '8'
                           IF NOT s_azzi650_chk_exist('2066',g_prdn_d[l_ac].prdn004) THEN
                              LET g_prdn_d[l_ac].prdn004 = g_prdn_d_t.prdn004
                              CALL aprm551_prdn004_ref()
                              NEXT FIELD CURRENT
                           END IF
                        WHEN '9'
                           IF NOT s_azzi650_chk_exist('2067',g_prdn_d[l_ac].prdn004) THEN
                              LET g_prdn_d[l_ac].prdn004 = g_prdn_d_t.prdn004
                              CALL aprm551_prdn004_ref()
                              NEXT FIELD CURRENT
                           END IF
                        WHEN '10'
                           IF NOT s_azzi650_chk_exist('2068',g_prdn_d[l_ac].prdn004) THEN
                              LET g_prdn_d[l_ac].prdn004 = g_prdn_d_t.prdn004
                              CALL aprm551_prdn004_ref()
                              NEXT FIELD CURRENT
                           END IF
                        WHEN '11'
                           IF NOT s_azzi650_chk_exist('2069',g_prdn_d[l_ac].prdn004) THEN
                              LET g_prdn_d[l_ac].prdn004 = g_prdn_d_t.prdn004
                              CALL aprm551_prdn004_ref()
                              NEXT FIELD CURRENT
                           END IF
                        WHEN '12'
                           IF NOT s_azzi650_chk_exist('2070',g_prdn_d[l_ac].prdn004) THEN
                              LET g_prdn_d[l_ac].prdn004 = g_prdn_d_t.prdn004
                              CALL aprm551_prdn004_ref()
                              NEXT FIELD CURRENT
                           END IF
                     END CASE
                  END IF
               END IF
            END IF
            CALL aprm551_prdn004_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdn004
            #add-point:BEFORE FIELD prdn004 name="input.b.page1.prdn004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdn004
            #add-point:ON CHANGE prdn004 name="input.g.page1.prdn004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdnsite
            #add-point:BEFORE FIELD prdnsite name="input.b.page1.prdnsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdnsite
            
            #add-point:AFTER FIELD prdnsite name="input.a.page1.prdnsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdnsite
            #add-point:ON CHANGE prdnsite name="input.g.page1.prdnsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdnunit
            #add-point:BEFORE FIELD prdnunit name="input.b.page1.prdnunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdnunit
            
            #add-point:AFTER FIELD prdnunit name="input.a.page1.prdnunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdnunit
            #add-point:ON CHANGE prdnunit name="input.g.page1.prdnunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.prdnstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdnstus
            #add-point:ON ACTION controlp INFIELD prdnstus name="input.c.page1.prdnstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prdn002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdn002
            #add-point:ON ACTION controlp INFIELD prdn002 name="input.c.page1.prdn002"
            #此段落由子樣板a07產生            
           
            #END add-point
 
 
         #Ctrlp:input.c.page1.prdn003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdn003
            #add-point:ON ACTION controlp INFIELD prdn003 name="input.c.page1.prdn003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prdn004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdn004
            #add-point:ON ACTION controlp INFIELD prdn004 name="input.c.page1.prdn004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdn_d[l_ac].prdn004             #給予default值
            LET g_qryparam.default2 = "" #g_prdn_d[l_ac].oocq002 #應用分類碼
            #給予arg
            CASE g_prdn_d[l_ac].prdn003
               WHEN '1'
                  LET g_qryparam.arg1 = 'ALL'
                  CALL q_pmaa001_6()
               WHEN '2'
                  LET g_qryparam.arg1 =281
                  CALL q_oocq002()
               WHEN '3'
                  LET g_qryparam.arg1=2061
                  CALL q_oocq002()
               WHEN '4'
                  LET g_qryparam.arg1=2062
                  CALL q_oocq002()
               WHEN '5'
                  LET g_qryparam.arg1=2063
                  CALL q_oocq002()
               WHEN '6'
                  LET g_qryparam.arg1=2064
                  CALL q_oocq002()
               WHEN '7'
                  LET g_qryparam.arg1=2065
                  CALL q_oocq002()
               WHEN '8'
                  LET g_qryparam.arg1=2066
                  CALL q_oocq002()
               WHEN '9'
                  LET g_qryparam.arg1=2067
                  CALL q_oocq002()
               WHEN '10'
                  LET g_qryparam.arg1=2068
                  CALL q_oocq002()
               WHEN '11'
                  LET g_qryparam.arg1=2069
                  CALL q_oocq002()
               WHEN '12'
                  LET g_qryparam.arg1=2070
                  CALL q_oocq002()
            END CASE
#            LET g_qryparam.arg1 = "" #
#
#            
#            CALL q_oocq002()                                #呼叫開窗

            LET g_prdn_d[l_ac].prdn004 = g_qryparam.return1              
            #LET g_prdn_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_prdn_d[l_ac].prdn004 TO prdn004              #
            #DISPLAY g_prdn_d[l_ac].oocq002 TO oocq002 #應用分類碼
            CALL aprm551_prdn004_ref()
            NEXT FIELD prdn004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prdnsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdnsite
            #add-point:ON ACTION controlp INFIELD prdnsite name="input.c.page1.prdnsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prdnunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdnunit
            #add-point:ON ACTION controlp INFIELD prdnunit name="input.c.page1.prdnunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prdn_d[l_ac].* = g_prdn_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprm551_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_prdn_d[l_ac].prdn002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prdn_d[l_ac].* = g_prdn_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
      
               #將遮罩欄位還原
               CALL aprm551_prdn_t_mask_restore('restore_mask_o')
      
               UPDATE prdn_t SET (prdn001,prdnstus,prdn002,prdn003,prdn004,prdnsite,prdnunit) = (g_prdl_m.prdl001, 
                   g_prdn_d[l_ac].prdnstus,g_prdn_d[l_ac].prdn002,g_prdn_d[l_ac].prdn003,g_prdn_d[l_ac].prdn004, 
                   g_prdn_d[l_ac].prdnsite,g_prdn_d[l_ac].prdnunit)
                WHERE prdnent = g_enterprise AND prdn001 = g_prdl_m.prdl001 
 
                  AND prdn002 = g_prdn_d_t.prdn002 #項次   
                  AND prdn003 = g_prdn_d_t.prdn003  
                  AND prdn004 = g_prdn_d_t.prdn004  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prdn_d[l_ac].* = g_prdn_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prdn_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prdn_d[l_ac].* = g_prdn_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prdn_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys_bak[1] = g_prdl001_t
               LET gs_keys[2] = g_prdn_d[g_detail_idx].prdn002
               LET gs_keys_bak[2] = g_prdn_d_t.prdn002
               LET gs_keys[3] = g_prdn_d[g_detail_idx].prdn003
               LET gs_keys_bak[3] = g_prdn_d_t.prdn003
               LET gs_keys[4] = g_prdn_d[g_detail_idx].prdn004
               LET gs_keys_bak[4] = g_prdn_d_t.prdn004
               CALL aprm551_update_b('prdn_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aprm551_prdn_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_prdn_d[g_detail_idx].prdn002 = g_prdn_d_t.prdn002 
                  AND g_prdn_d[g_detail_idx].prdn003 = g_prdn_d_t.prdn003 
                  AND g_prdn_d[g_detail_idx].prdn004 = g_prdn_d_t.prdn004 
 
                  ) THEN
                  LET gs_keys[01] = g_prdl_m.prdl001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_prdn_d_t.prdn002
                  LET gs_keys[gs_keys.getLength()+1] = g_prdn_d_t.prdn003
                  LET gs_keys[gs_keys.getLength()+1] = g_prdn_d_t.prdn004
 
                  CALL aprm551_key_update_b(gs_keys,'prdn_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdn_d_t)
               LET g_log2 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdn_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aprm551_unlock_b("prdn_t","'1'")
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
               LET g_prdn_d[li_reproduce_target].* = g_prdn_d[li_reproduce].*
 
               LET g_prdn_d[li_reproduce_target].prdn002 = NULL
               LET g_prdn_d[li_reproduce_target].prdn003 = NULL
               LET g_prdn_d[li_reproduce_target].prdn004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_prdn_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prdn_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_prdn2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prdn2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprm551_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_prdn2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            SELECT count(*) INTO l_cnt FROM prdn_t
            WHERE prdnent = g_enterprise AND prdn001 = g_prdl_m.prdl001
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            IF l_cnt<=0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "art-00073"
               LET g_errparam.extend = 'prdn_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               RETURN
            END IF
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prdn2_d[l_ac].* TO NULL 
            INITIALIZE g_prdn2_d_t.* TO NULL 
            INITIALIZE g_prdn2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prdn2_d[l_ac].prdsstus = 'N'
 
 
 
            #自定義預設值(單身2)
                  LET g_prdn2_d[l_ac].prdsstus = "Y"
      LET g_prdn2_d[l_ac].prds000 = "1"
      LET g_prdn2_d[l_ac].prds005 = "0"
      LET g_prdn2_d[l_ac].prds008 = "0"
      LET g_prdn2_d[l_ac].prds009 = "1"
      LET g_prdn2_d[l_ac].prdb005 = "0"
      LET g_prdn2_d[l_ac].prds010 = "Y"
      LET g_prdn2_d[l_ac].prds011 = "0"
      LET g_prdn2_d[l_ac].prds012 = "0"
      LET g_prdn2_d[l_ac].prds013 = "0"
      LET g_prdn2_d[l_ac].prds004 = "1"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_prdn2_d_t.* = g_prdn2_d[l_ac].*     #新輸入資料
            LET g_prdn2_d_o.* = g_prdn2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprm551_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL aprm551_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prdn2_d[li_reproduce_target].* = g_prdn2_d[li_reproduce].*
 
               LET g_prdn2_d[li_reproduce_target].prds002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"

            LET g_prdn2_d[l_ac].prdsunit = g_prdl_m.prdlunit
            LET g_prdn2_d[l_ac].prdssite = g_prdl_m.prdlsite
            CALL aprm551_create_prds002()
            CALL cl_set_comp_entry("prds003,prch005",true)
            IF g_prdn2_d[l_ac].prds000='1' THEN
               LET g_prdn2_d[l_ac].prds003='0'
               LET g_prdn2_d[l_ac].prds005='0'
               CALL cl_set_comp_entry("prds003,prds005",false)
               DISPLAY g_prdn2_d[l_ac].prds003,g_prdn2_d[l_ac].prds005
                    TO s_detail2[l_ac].prds003,s_detail2[l_ac].prds005
            END IF
            IF g_prdn2_d[l_ac].prds000='3' THEN
               LET g_prdn2_d[l_ac].prds003='1'
            END IF
#            IF g_prdn2_d[l_ac].prds009<>'4' THEN
#               LET g_prdn2_d[l_ac].prdb005 = 0
#            END IF   
            CALL aprm551_set_prds_entry()
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
            OPEN aprm551_cl USING g_enterprise,g_prdl_m.prdl001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprm551_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprm551_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prdn2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prdn2_d[l_ac].prds002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prdn2_d_t.* = g_prdn2_d[l_ac].*  #BACKUP
               LET g_prdn2_d_o.* = g_prdn2_d[l_ac].*  #BACKUP
               CALL aprm551_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               CALL aprm551_set_prds_entry()
               #end add-point  
               CALL aprm551_set_no_entry_b(l_cmd)
               IF NOT aprm551_lock_b("prds_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprm551_bcl2 INTO g_prdn2_d[l_ac].prdsstus,g_prdn2_d[l_ac].prds002,g_prdn2_d[l_ac].prds000, 
                      g_prdn2_d[l_ac].prds003,g_prdn2_d[l_ac].prds005,g_prdn2_d[l_ac].prds006,g_prdn2_d[l_ac].prds008, 
                      g_prdn2_d[l_ac].prds009,g_prdn2_d[l_ac].prds010,g_prdn2_d[l_ac].prds011,g_prdn2_d[l_ac].prds012, 
                      g_prdn2_d[l_ac].prds013,g_prdn2_d[l_ac].prds004,g_prdn2_d[l_ac].prds007,g_prdn2_d[l_ac].prdssite, 
                      g_prdn2_d[l_ac].prdsunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prdn2_d_mask_o[l_ac].* =  g_prdn2_d[l_ac].*
                  CALL aprm551_prds_t_mask()
                  LET g_prdn2_d_mask_n[l_ac].* =  g_prdn2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprm551_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            IF l_cmd = 'u' THEN
               CALL cl_set_comp_entry("prds002",false)
            ELSE
               CALL cl_set_comp_entry("prds002",true)
            END IF
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
               SELECT count(*) INTO l_cnt1 FROM prdr_t WHERE prdrent=g_enterprise
                  AND prdr001 = g_prdl_m.prdl001 AND prdr010 = g_prdn2_d_t.prds002
               SELECT count(*) INTO l_cnt2 FROM prdu_t WHERE prduent=g_enterprise
                  AND prdu001 = g_prdl_m.prdl001 AND prdu003 = g_prdn2_d_t.prds002
               IF l_cnt1>0 OR l_cnt2>0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "apr-00317"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_prdl_m.prdl001
               LET gs_keys[gs_keys.getLength()+1] = g_prdn2_d_t.prds002
            
               #刪除同層單身
               IF NOT aprm551_delete_b('prds_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm551_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprm551_key_delete_b(gs_keys,'prds_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm551_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aprm551_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
                  DELETE FROM prdb_t
                   WHERE prdbent = g_enterprise AND prdbdocno = g_prdl_m.prdl001 AND
                      prdb004 = g_prdn2_d_t.prds002
                                     
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "prdb_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE   
                  END IF 
               #end add-point
               LET l_count = g_prdn_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prdn2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM prds_t 
             WHERE prdsent = g_enterprise AND prds001 = g_prdl_m.prdl001
               AND prds002 = g_prdn2_d[l_ac].prds002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys[2] = g_prdn2_d[g_detail_idx].prds002
               CALL aprm551_insert_b('prds_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_prdn_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "prds_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprm551_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               CALL aprm551_ins_prdb()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = "prds_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT
               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prdn2_d[l_ac].* = g_prdn2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprm551_bcl2
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
               LET g_prdn2_d[l_ac].* = g_prdn2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (( g_prdn2_d[l_ac].prds002 != g_prdn2_d_t.prds002 OR g_prdn2_d_t.prds002 IS null) or ( g_prdn2_d[l_ac].prdb005 != g_prdn2_d_t.prdb005 OR g_prdn2_d_t.prdb005 IS null))) THEN 
                  UPDATE prdb_t SET prdb005 = g_prdn2_d[l_ac].prdb005
                   WHERE prdbent = g_enterprise AND prdbdocno = g_prdl_m.prdl001
                     AND prdb004 = g_prdn2_d_t.prds002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "prds_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_prdn2_d[l_ac].* = g_prdn2_d_t.* 
                     RETURN
                  END IF                     
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               #將遮罩欄位還原
               CALL aprm551_prds_t_mask_restore('restore_mask_o')
                              
               UPDATE prds_t SET (prds001,prdsstus,prds002,prds000,prds003,prds005,prds006,prds008,prds009, 
                   prds010,prds011,prds012,prds013,prds004,prds007,prdssite,prdsunit) = (g_prdl_m.prdl001, 
                   g_prdn2_d[l_ac].prdsstus,g_prdn2_d[l_ac].prds002,g_prdn2_d[l_ac].prds000,g_prdn2_d[l_ac].prds003, 
                   g_prdn2_d[l_ac].prds005,g_prdn2_d[l_ac].prds006,g_prdn2_d[l_ac].prds008,g_prdn2_d[l_ac].prds009, 
                   g_prdn2_d[l_ac].prds010,g_prdn2_d[l_ac].prds011,g_prdn2_d[l_ac].prds012,g_prdn2_d[l_ac].prds013, 
                   g_prdn2_d[l_ac].prds004,g_prdn2_d[l_ac].prds007,g_prdn2_d[l_ac].prdssite,g_prdn2_d[l_ac].prdsunit)  
                   #自訂欄位頁簽
                WHERE prdsent = g_enterprise AND prds001 = g_prdl_m.prdl001
                  AND prds002 = g_prdn2_d_t.prds002 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prdn2_d[l_ac].* = g_prdn2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prds_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prdn2_d[l_ac].* = g_prdn2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prds_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys_bak[1] = g_prdl001_t
               LET gs_keys[2] = g_prdn2_d[g_detail_idx].prds002
               LET gs_keys_bak[2] = g_prdn2_d_t.prds002
               CALL aprm551_update_b('prds_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aprm551_prds_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_prdn2_d[g_detail_idx].prds002 = g_prdn2_d_t.prds002 
                  ) THEN
                  LET gs_keys[01] = g_prdl_m.prdl001
                  LET gs_keys[gs_keys.getLength()+1] = g_prdn2_d_t.prds002
                  CALL aprm551_key_update_b(gs_keys,'prds_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdn2_d_t)
               LET g_log2 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdn2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdsstus
            #add-point:BEFORE FIELD prdsstus name="input.b.page2.prdsstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdsstus
            
            #add-point:AFTER FIELD prdsstus name="input.a.page2.prdsstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdsstus
            #add-point:ON CHANGE prdsstus name="input.g.page2.prdsstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdn2_d[l_ac].prds002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD prds002
            END IF 
 
 
 
            #add-point:AFTER FIELD prds002 name="input.a.page2.prds002"
            #此段落由子樣板a05產生
            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds002
            #add-point:BEFORE FIELD prds002 name="input.b.page2.prds002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prds002
            #add-point:ON CHANGE prds002 name="input.g.page2.prds002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds000
            #add-point:BEFORE FIELD prds000 name="input.b.page2.prds000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds000
            
            #add-point:AFTER FIELD prds000 name="input.a.page2.prds000"
            IF g_prdn2_d[g_detail_idx].prds000 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prdn2_d[g_detail_idx].prds000 != g_prdn2_d_t.prds000 OR g_prdn2_d_t.prds000 IS NULL )) THEN 
                  CALL aprm551_chk_prds000()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prdn2_d[l_ac].prds000
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdn2_d[l_ac].prds000 = g_prdn2_d_t.prds000
                     NEXT FIELD prds000 
                  END IF
               END IF
            END IF
            CALL aprm551_set_prds_entry()            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prds000
            #add-point:ON CHANGE prds000 name="input.g.page2.prds000"
            CALL cl_set_comp_entry("prds003,prds005,prds008",true)
            IF g_prdn2_d[l_ac].prds000='1' THEN
               LET g_prdn2_d[l_ac].prds003='0'
               LET g_prdn2_d[l_ac].prds005='0'
               LET g_prdn2_d[l_ac].prds008='0'
               CALL cl_set_comp_entry("prds003,prds005,prds008",false)
               DISPLAY g_prdn2_d[l_ac].prds003,g_prdn2_d[l_ac].prds005,g_prdn2_d[l_ac].prds008
                    TO s_detail2[l_ac].prds003,s_detail2[l_ac].prds005,s_detail2[l_ac].prds008
            END IF
            IF g_prdn2_d[l_ac].prds000='3' THEN
               LET g_prdn2_d[l_ac].prds003='1'               
            END IF
            CALL aprm551_set_prds_entry()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds003
            #add-point:BEFORE FIELD prds003 name="input.b.page2.prds003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds003
            
            #add-point:AFTER FIELD prds003 name="input.a.page2.prds003"
            IF NOT cl_null(g_prdn2_d[l_ac].prds003) THEN
               IF g_prdn2_d[l_ac].prds000<>'1' THEN
                  IF g_prdn2_d[l_ac].prds003='0' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apr-00319"
                     LET g_errparam.extend = g_prdn2_d[l_ac].prds003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdn2_d[l_ac].prds003 = g_prdn2_d_t.prds003
                     NEXT FIELD prds003
                  END IF
               END IF
               
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prds003
            #add-point:ON CHANGE prds003 name="input.g.page2.prds003"
            IF g_prdn2_d[l_ac].prds003='0' THEN
               LET g_prdn2_d[l_ac].prds005='0'
               CALL cl_set_comp_entry("prds005",false)
               DISPLAY g_prdn2_d[l_ac].prds005
                    TO s_detail2[l_ac].prds005
            ELSE
               CALL cl_set_comp_entry("prds005",TRUE)            
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdn2_d[l_ac].prds005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prds005
            END IF 
 
 
 
            #add-point:AFTER FIELD prds005 name="input.a.page2.prds005"
            IF NOT cl_null(g_prdn2_d[l_ac].prds005) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds005
            #add-point:BEFORE FIELD prds005 name="input.b.page2.prds005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prds005
            #add-point:ON CHANGE prds005 name="input.g.page2.prds005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdn2_d[l_ac].prds006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prds006
            END IF 
 
 
 
            #add-point:AFTER FIELD prds006 name="input.a.page2.prds006"
            IF NOT cl_null(g_prdn2_d[l_ac].prds006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds006
            #add-point:BEFORE FIELD prds006 name="input.b.page2.prds006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prds006
            #add-point:ON CHANGE prds006 name="input.g.page2.prds006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds008
            #add-point:BEFORE FIELD prds008 name="input.b.page2.prds008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds008
            
            #add-point:AFTER FIELD prds008 name="input.a.page2.prds008"
            IF NOT cl_null(g_prdn2_d[l_ac].prds008) THEN
               IF g_prdn2_d[l_ac].prds000='1' THEN
                  IF g_prdn2_d[l_ac].prds008<>'0' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apr-00320"
                     LET g_errparam.extend = g_prdn2_d[l_ac].prds008
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdn2_d[l_ac].prds008 = g_prdn2_d_t.prds008
                     NEXT FIELD prds008
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prds008
            #add-point:ON CHANGE prds008 name="input.g.page2.prds008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds009
            #add-point:BEFORE FIELD prds009 name="input.b.page2.prds009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds009
            
            #add-point:AFTER FIELD prds009 name="input.a.page2.prds009"
            IF g_prdn2_d[l_ac].prds009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prdn2_d[l_ac].prds009 != g_prdn2_d_t.prds009 OR g_prdn2_d_t.prds009 IS null)) THEN 
                  IF g_prdl_m.prdl028='2' THEN
                     IF g_prdn2_d[l_ac].prds009='5' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code =  "apr-00321"
                        LET g_errparam.extend = g_prdn2_d[l_ac].prds009
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prdn2_d[l_ac].prds009 = g_prdn2_d_t.prds009
                        NEXT FIELD prds009
                     END IF
                  END IF
                  SELECT count(*) INTO l_cnt1 FROM prdr_t WHERE prdrent=g_enterprise
                     AND prdr001 = g_prdl_m.prdl001 AND prdr010 = g_prdn2_d_t.prds002
                  SELECT count(*) INTO l_cnt2 FROM prdu_t WHERE prduent=g_enterprise
                     AND prdu001 = g_prdl_m.prdl001 AND prdu003 = g_prdn2_d_t.prds002
                  IF l_cnt1>0 OR l_cnt2>0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  "apr-00317"
                     LET g_errparam.extend = g_prdn2_d[l_ac].prds009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdn2_d[l_ac].prds009 = g_prdn2_d_t.prds009
                     NEXT FIELD prds009
                  END IF
                  CALL aprm551_set_prds_entry()
                  IF g_prdn2_d[l_ac].prds009='4' THEN
                     LET g_prdn2_d[l_ac].prdb005 = NULL
                     DISPLAY g_prdn2_d[l_ac].prdb005 TO s_detail2[l_ac].prdb005
                     NEXT FIELD prds010
                  END IF
               END IF
            END IF
            CALL aprm551_set_prds_entry()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prds009
            #add-point:ON CHANGE prds009 name="input.g.page2.prds009"
            CALL aprm551_set_prds_entry()
            LET g_prdn2_d[l_ac].prdb005 = NULL
            DISPLAY g_prdn2_d[l_ac].prdb005 TO s_detail2[l_ac].prdb005
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdb005
            #add-point:BEFORE FIELD prdb005 name="input.b.page2.prdb005"
            IF g_prdn2_d[l_ac].prds009='4' THEN
               LET g_prdn2_d[l_ac].prdb005 = NULL
               DISPLAY g_prdn2_d[l_ac].prdb005 TO s_detail2[l_ac].prdb005
               NEXT FIELD prds010
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdb005
            
            #add-point:AFTER FIELD prdb005 name="input.a.page2.prdb005"
            IF  g_prdn2_d[l_ac].prdb005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prdn2_d[l_ac].prdb005 != g_prdn2_d_t.prdb005 OR g_prdn2_d_t.prdb005 IS null)) THEN 
                  CALL aprm551_chk_prds005()
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
LET g_errparam.code = g_errno
LET g_errparam.extend = g_prdn2_d[l_ac].prdb005
LET g_errparam.popup = TRUE
CALL cl_err()

                     LET g_prdn2_d[l_ac].prdb005 = g_prdn2_d_t.prdb005
                     NEXT FIELD CURRENT
                  END IF
                  IF g_prdn2_d[l_ac].prdb005<0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "aim-00009"
                     LET g_errparam.extend = g_prdn2_d[l_ac].prdb005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdn2_d[l_ac].prdb005 = g_prdn2_d_t.prdb005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdb005
            #add-point:ON CHANGE prdb005 name="input.g.page2.prdb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds010
            #add-point:BEFORE FIELD prds010 name="input.b.page2.prds010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds010
            
            #add-point:AFTER FIELD prds010 name="input.a.page2.prds010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prds010
            #add-point:ON CHANGE prds010 name="input.g.page2.prds010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdn2_d[l_ac].prds011,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD prds011
            END IF 
 
 
 
            #add-point:AFTER FIELD prds011 name="input.a.page2.prds011"
            IF NOT cl_null(g_prdn2_d[l_ac].prds011) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds011
            #add-point:BEFORE FIELD prds011 name="input.b.page2.prds011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prds011
            #add-point:ON CHANGE prds011 name="input.g.page2.prds011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdn2_d[l_ac].prds012,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prds012
            END IF 
 
 
 
            #add-point:AFTER FIELD prds012 name="input.a.page2.prds012"
            IF NOT cl_null(g_prdn2_d[l_ac].prds012) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds012
            #add-point:BEFORE FIELD prds012 name="input.b.page2.prds012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prds012
            #add-point:ON CHANGE prds012 name="input.g.page2.prds012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdn2_d[l_ac].prds013,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prds013
            END IF 
 
 
 
            #add-point:AFTER FIELD prds013 name="input.a.page2.prds013"
            IF NOT cl_null(g_prdn2_d[l_ac].prds013) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds013
            #add-point:BEFORE FIELD prds013 name="input.b.page2.prds013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prds013
            #add-point:ON CHANGE prds013 name="input.g.page2.prds013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds004
            #add-point:BEFORE FIELD prds004 name="input.b.page2.prds004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds004
            
            #add-point:AFTER FIELD prds004 name="input.a.page2.prds004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prds004
            #add-point:ON CHANGE prds004 name="input.g.page2.prds004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prds007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdn2_d[l_ac].prds007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prds007
            END IF 
 
 
 
            #add-point:AFTER FIELD prds007 name="input.a.page2.prds007"
            IF NOT cl_null(g_prdn2_d[l_ac].prds007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prds007
            #add-point:BEFORE FIELD prds007 name="input.b.page2.prds007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prds007
            #add-point:ON CHANGE prds007 name="input.g.page2.prds007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdssite
            #add-point:BEFORE FIELD prdssite name="input.b.page2.prdssite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdssite
            
            #add-point:AFTER FIELD prdssite name="input.a.page2.prdssite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdssite
            #add-point:ON CHANGE prdssite name="input.g.page2.prdssite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdsunit
            #add-point:BEFORE FIELD prdsunit name="input.b.page2.prdsunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdsunit
            
            #add-point:AFTER FIELD prdsunit name="input.a.page2.prdsunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdsunit
            #add-point:ON CHANGE prdsunit name="input.g.page2.prdsunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.prdsstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdsstus
            #add-point:ON ACTION controlp INFIELD prdsstus name="input.c.page2.prdsstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prds002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds002
            #add-point:ON ACTION controlp INFIELD prds002 name="input.c.page2.prds002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prds000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds000
            #add-point:ON ACTION controlp INFIELD prds000 name="input.c.page2.prds000"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prds003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds003
            #add-point:ON ACTION controlp INFIELD prds003 name="input.c.page2.prds003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prds005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds005
            #add-point:ON ACTION controlp INFIELD prds005 name="input.c.page2.prds005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prds006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds006
            #add-point:ON ACTION controlp INFIELD prds006 name="input.c.page2.prds006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prds008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds008
            #add-point:ON ACTION controlp INFIELD prds008 name="input.c.page2.prds008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prds009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds009
            #add-point:ON ACTION controlp INFIELD prds009 name="input.c.page2.prds009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prdb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdb005
            #add-point:ON ACTION controlp INFIELD prdb005 name="input.c.page2.prdb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prds010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds010
            #add-point:ON ACTION controlp INFIELD prds010 name="input.c.page2.prds010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prds011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds011
            #add-point:ON ACTION controlp INFIELD prds011 name="input.c.page2.prds011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prds012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds012
            #add-point:ON ACTION controlp INFIELD prds012 name="input.c.page2.prds012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prds013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds013
            #add-point:ON ACTION controlp INFIELD prds013 name="input.c.page2.prds013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prds004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds004
            #add-point:ON ACTION controlp INFIELD prds004 name="input.c.page2.prds004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prds007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prds007
            #add-point:ON ACTION controlp INFIELD prds007 name="input.c.page2.prds007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prdssite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdssite
            #add-point:ON ACTION controlp INFIELD prdssite name="input.c.page2.prdssite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prdsunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdsunit
            #add-point:ON ACTION controlp INFIELD prdsunit name="input.c.page2.prdsunit"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prdn2_d[l_ac].* = g_prdn2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprm551_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprm551_unlock_b("prds_t","'2'")
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
               LET g_prdn2_d[li_reproduce_target].* = g_prdn2_d[li_reproduce].*
 
               LET g_prdn2_d[li_reproduce_target].prds002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_prdn2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prdn2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_prdn3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prdn3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprm551_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_prdn3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prdn3_d[l_ac].* TO NULL 
            INITIALIZE g_prdn3_d_t.* TO NULL 
            INITIALIZE g_prdn3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prdn3_d[l_ac].prdrstus = 'N'
 
 
 
            #自定義預設值(單身3)
                  LET g_prdn3_d[l_ac].prdrstus = "Y"
      LET g_prdn3_d[l_ac].prdr003 = "4"
      LET g_prdn3_d[l_ac].prdr007 = "0"
      LET g_prdn3_d[l_ac].prdr008 = "0"
      LET g_prdn3_d[l_ac].prdr009 = "0"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_prdn3_d_t.* = g_prdn3_d[l_ac].*     #新輸入資料
            LET g_prdn3_d_o.* = g_prdn3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprm551_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL aprm551_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prdn3_d[li_reproduce_target].* = g_prdn3_d[li_reproduce].*
 
               LET g_prdn3_d[li_reproduce_target].prdr002 = NULL
               LET g_prdn3_d[li_reproduce_target].prdr003 = NULL
               LET g_prdn3_d[li_reproduce_target].prdr004 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"

            LET g_prdn3_d[l_ac].prdrsite = g_prdl_m.prdlsite
            LET g_prdn3_d[l_ac].prdrunit = g_prdl_m.prdlunit
            CALL aprm551_create_prdr002()
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
            OPEN aprm551_cl USING g_enterprise,g_prdl_m.prdl001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprm551_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprm551_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prdn3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prdn3_d[l_ac].prdr002 IS NOT NULL
               AND g_prdn3_d[l_ac].prdr003 IS NOT NULL
               AND g_prdn3_d[l_ac].prdr004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prdn3_d_t.* = g_prdn3_d[l_ac].*  #BACKUP
               LET g_prdn3_d_o.* = g_prdn3_d[l_ac].*  #BACKUP
               CALL aprm551_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL aprm551_set_no_entry_b(l_cmd)
               IF NOT aprm551_lock_b("prdr_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprm551_bcl3 INTO g_prdn3_d[l_ac].prdrstus,g_prdn3_d[l_ac].prdr010,g_prdn3_d[l_ac].prdr002, 
                      g_prdn3_d[l_ac].prdr003,g_prdn3_d[l_ac].prdr004,g_prdn3_d[l_ac].prdr006,g_prdn3_d[l_ac].prdr007, 
                      g_prdn3_d[l_ac].prdr008,g_prdn3_d[l_ac].prdr009,g_prdn3_d[l_ac].prdrsite,g_prdn3_d[l_ac].prdrunit, 
                      g_prdn3_d[l_ac].prdr005
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prdn3_d_mask_o[l_ac].* =  g_prdn3_d[l_ac].*
                  CALL aprm551_prdr_t_mask()
                  LET g_prdn3_d_mask_n[l_ac].* =  g_prdn3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprm551_show()
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
               LET gs_keys[01] = g_prdl_m.prdl001
               LET gs_keys[gs_keys.getLength()+1] = g_prdn3_d_t.prdr002
               LET gs_keys[gs_keys.getLength()+1] = g_prdn3_d_t.prdr003
               LET gs_keys[gs_keys.getLength()+1] = g_prdn3_d_t.prdr004
            
               #刪除同層單身
               IF NOT aprm551_delete_b('prdr_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm551_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprm551_key_delete_b(gs_keys,'prdr_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprm551_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aprm551_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_prdn_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prdn3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM prdr_t 
             WHERE prdrent = g_enterprise AND prdr001 = g_prdl_m.prdl001
               AND prdr002 = g_prdn3_d[l_ac].prdr002
               AND prdr003 = g_prdn3_d[l_ac].prdr003
               AND prdr004 = g_prdn3_d[l_ac].prdr004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys[2] = g_prdn3_d[g_detail_idx].prdr002
               LET gs_keys[3] = g_prdn3_d[g_detail_idx].prdr003
               LET gs_keys[4] = g_prdn3_d[g_detail_idx].prdr004
               CALL aprm551_insert_b('prdr_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_prdn_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "prdr_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprm551_b_fill()
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
               LET g_prdn3_d[l_ac].* = g_prdn3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprm551_bcl3
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
               LET g_prdn3_d[l_ac].* = g_prdn3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               #將遮罩欄位還原
               CALL aprm551_prdr_t_mask_restore('restore_mask_o')
                              
               UPDATE prdr_t SET (prdr001,prdrstus,prdr010,prdr002,prdr003,prdr004,prdr006,prdr007,prdr008, 
                   prdr009,prdrsite,prdrunit,prdr005) = (g_prdl_m.prdl001,g_prdn3_d[l_ac].prdrstus,g_prdn3_d[l_ac].prdr010, 
                   g_prdn3_d[l_ac].prdr002,g_prdn3_d[l_ac].prdr003,g_prdn3_d[l_ac].prdr004,g_prdn3_d[l_ac].prdr006, 
                   g_prdn3_d[l_ac].prdr007,g_prdn3_d[l_ac].prdr008,g_prdn3_d[l_ac].prdr009,g_prdn3_d[l_ac].prdrsite, 
                   g_prdn3_d[l_ac].prdrunit,g_prdn3_d[l_ac].prdr005) #自訂欄位頁簽
                WHERE prdrent = g_enterprise AND prdr001 = g_prdl_m.prdl001
                  AND prdr002 = g_prdn3_d_t.prdr002 #項次 
                  AND prdr003 = g_prdn3_d_t.prdr003
                  AND prdr004 = g_prdn3_d_t.prdr004
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prdn3_d[l_ac].* = g_prdn3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prdr_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prdn3_d[l_ac].* = g_prdn3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prdr_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys_bak[1] = g_prdl001_t
               LET gs_keys[2] = g_prdn3_d[g_detail_idx].prdr002
               LET gs_keys_bak[2] = g_prdn3_d_t.prdr002
               LET gs_keys[3] = g_prdn3_d[g_detail_idx].prdr003
               LET gs_keys_bak[3] = g_prdn3_d_t.prdr003
               LET gs_keys[4] = g_prdn3_d[g_detail_idx].prdr004
               LET gs_keys_bak[4] = g_prdn3_d_t.prdr004
               CALL aprm551_update_b('prdr_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aprm551_prdr_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_prdn3_d[g_detail_idx].prdr002 = g_prdn3_d_t.prdr002 
                  AND g_prdn3_d[g_detail_idx].prdr003 = g_prdn3_d_t.prdr003 
                  AND g_prdn3_d[g_detail_idx].prdr004 = g_prdn3_d_t.prdr004 
                  ) THEN
                  LET gs_keys[01] = g_prdl_m.prdl001
                  LET gs_keys[gs_keys.getLength()+1] = g_prdn3_d_t.prdr002
                  LET gs_keys[gs_keys.getLength()+1] = g_prdn3_d_t.prdr003
                  LET gs_keys[gs_keys.getLength()+1] = g_prdn3_d_t.prdr004
                  CALL aprm551_key_update_b(gs_keys,'prdr_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdn3_d_t)
               LET g_log2 = util.JSON.stringify(g_prdl_m),util.JSON.stringify(g_prdn3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdrstus
            #add-point:BEFORE FIELD prdrstus name="input.b.page3.prdrstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdrstus
            
            #add-point:AFTER FIELD prdrstus name="input.a.page3.prdrstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdrstus
            #add-point:ON CHANGE prdrstus name="input.g.page3.prdrstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdn3_d[l_ac].prdr010,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prdr010
            END IF 
 
 
 
            #add-point:AFTER FIELD prdr010 name="input.a.page3.prdr010"
            IF NOT cl_null(g_prdn3_d[l_ac].prdr010) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prdn3_d[l_ac].prdr010 != g_prdn3_d_t.prdr010 OR g_prdn3_d_t.prdr010 IS NULL )) THEN 
                  CALL aprm551_chk_prdr010()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prdn3_d[l_ac].prdr010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdn3_d[l_ac].prdr010 = g_prdn3_d_t.prdr010
                     NEXT FIELD prdr010
                  END IF
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr010
            #add-point:BEFORE FIELD prdr010 name="input.b.page3.prdr010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr010
            #add-point:ON CHANGE prdr010 name="input.g.page3.prdr010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdn3_d[l_ac].prdr002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD prdr002
            END IF 
 
 
 
            #add-point:AFTER FIELD prdr002 name="input.a.page3.prdr002"
            IF NOT cl_null(g_prdn3_d[l_ac].prdr002) THEN 
            END IF 


            #此段落由子樣板a05產生
            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr002
            #add-point:BEFORE FIELD prdr002 name="input.b.page3.prdr002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr002
            #add-point:ON CHANGE prdr002 name="input.g.page3.prdr002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr003
            #add-point:BEFORE FIELD prdr003 name="input.b.page3.prdr003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr003
            
            #add-point:AFTER FIELD prdr003 name="input.a.page3.prdr003"
            #此段落由子樣板a05產生
            


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr003
            #add-point:ON CHANGE prdr003 name="input.g.page3.prdr003"
            LET g_prdn3_d[l_ac].prdr004 = ""
            DISPLAY BY NAME g_prdn3_d[l_ac].prdr004
            LET g_prdn3_d[l_ac].prdr004_desc = ""
            DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
            LET g_prdn3_d[l_ac].prdr005 = ""
            DISPLAY BY NAME g_prdn3_d[l_ac].prdr005
            LET g_prdn3_d[l_ac].prdr006 = ""
            DISPLAY BY NAME g_prdn3_d[l_ac].prdr006
            LET g_prdn3_d[l_ac].prdr006_desc = ""
            DISPLAY BY NAME g_prdn3_d[l_ac].prdr006_desc
            CALL aprm551_set_entry_b(l_cmd)
            CALL aprm551_set_no_entry_b(l_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr004
            
            #add-point:AFTER FIELD prdr004 name="input.a.page3.prdr004"
            
            #此段落由子樣板a05產生
            LET g_prdn3_d[l_ac].prdr004_desc = null
            DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
            IF  g_prdl_m.prdl001 IS NOT NULL AND g_prdn3_d[g_detail_idx].prdr002 IS NOT NULL AND g_prdn3_d[g_detail_idx].prdr003 IS NOT NULL AND g_prdn3_d[g_detail_idx].prdr004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prdn3_d[g_detail_idx].prdr002 != g_prdn3_d_t.prdr002 OR g_prdn3_d[g_detail_idx].prdr003 != g_prdn3_d_t.prdr003 OR g_prdn3_d[g_detail_idx].prdr004 != g_prdn3_d_t.prdr004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prdr_t WHERE "||"prdrent = '" ||g_enterprise|| "' AND "||"prdr001 = '"||g_prdl_m.prdl001 ||"' AND "|| "prdr002 = '"||g_prdn3_d[g_detail_idx].prdr002 ||"' AND "|| "prdr003 = '"||g_prdn3_d[g_detail_idx].prdr003 ||"' AND "|| "prdr004 = '"||g_prdn3_d[g_detail_idx].prdr004 ||"'",'std-00004',0) THEN 
                     LET g_prdn3_d[l_ac].prdr004 = g_prdn3_d_t.prdr004
                     CALL aprm551_prdr_desc()
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_prdn3_d[l_ac].prdr003) THEN
                     IF NOT aprm551_chk_prdr004() THEN
                        LET g_prdn3_d[l_ac].prdr004 = g_prdn3_d_t.prdr004
                        CALL aprm551_prdr_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL aprm551_prdr_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr004
            #add-point:BEFORE FIELD prdr004 name="input.b.page3.prdr004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr004
            #add-point:ON CHANGE prdr004 name="input.g.page3.prdr004"
            IF NOT cl_null(g_prdn3_d[l_ac].prdr004) THEN
               IF g_prdn3_d[l_ac].prdr003 = '4' THEN
                  CALL aprm551_prdr004_ref()
               END IF
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr006
            
            #add-point:AFTER FIELD prdr006 name="input.a.page3.prdr006"
            IF NOT cl_null(g_prdn3_d[l_ac].prdr006) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #160318-00025#15 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               #160318-00025#15 by 07900 --add-end
               #設定g_chkparam.*的參數
               
               #160318-00025#15 by 07900 --add-str 
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#15 by 07900 --add-end 
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr006
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prdn3_d[l_ac].prdr006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prdn3_d[l_ac].prdr006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr006
            #add-point:BEFORE FIELD prdr006 name="input.b.page3.prdr006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr006
            #add-point:ON CHANGE prdr006 name="input.g.page3.prdr006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr007
            #add-point:BEFORE FIELD prdr007 name="input.b.page3.prdr007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr007
            
            #add-point:AFTER FIELD prdr007 name="input.a.page3.prdr007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr007
            #add-point:ON CHANGE prdr007 name="input.g.page3.prdr007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdn3_d[l_ac].prdr008,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prdr008
            END IF 
 
 
 
            #add-point:AFTER FIELD prdr008 name="input.a.page3.prdr008"
            IF NOT cl_null(g_prdn3_d[l_ac].prdr008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr008
            #add-point:BEFORE FIELD prdr008 name="input.b.page3.prdr008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr008
            #add-point:ON CHANGE prdr008 name="input.g.page3.prdr008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prdn3_d[l_ac].prdr009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prdr009
            END IF 
 
 
 
            #add-point:AFTER FIELD prdr009 name="input.a.page3.prdr009"
            IF NOT cl_null(g_prdn3_d[l_ac].prdr009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr009
            #add-point:BEFORE FIELD prdr009 name="input.b.page3.prdr009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr009
            #add-point:ON CHANGE prdr009 name="input.g.page3.prdr009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdrsite
            #add-point:BEFORE FIELD prdrsite name="input.b.page3.prdrsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdrsite
            
            #add-point:AFTER FIELD prdrsite name="input.a.page3.prdrsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdrsite
            #add-point:ON CHANGE prdrsite name="input.g.page3.prdrsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdrunit
            #add-point:BEFORE FIELD prdrunit name="input.b.page3.prdrunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdrunit
            
            #add-point:AFTER FIELD prdrunit name="input.a.page3.prdrunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdrunit
            #add-point:ON CHANGE prdrunit name="input.g.page3.prdrunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prdr005
            #add-point:BEFORE FIELD prdr005 name="input.b.page3.prdr005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prdr005
            
            #add-point:AFTER FIELD prdr005 name="input.a.page3.prdr005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prdr005
            #add-point:ON CHANGE prdr005 name="input.g.page3.prdr005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.prdrstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdrstus
            #add-point:ON ACTION controlp INFIELD prdrstus name="input.c.page3.prdrstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prdr010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr010
            #add-point:ON ACTION controlp INFIELD prdr010 name="input.c.page3.prdr010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prdr002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr002
            #add-point:ON ACTION controlp INFIELD prdr002 name="input.c.page3.prdr002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prdr003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr003
            #add-point:ON ACTION controlp INFIELD prdr003 name="input.c.page3.prdr003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prdr004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr004
            #add-point:ON ACTION controlp INFIELD prdr004 name="input.c.page3.prdr004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_prdn3_d[l_ac].prdr004             #給予default值

            IF g_prdn3_d[l_ac].prdr003 = '4' THEN
               LET g_qryparam.arg1 = g_site
               CALL q_imaa001()
            END IF                      
            IF g_prdn3_d[l_ac].prdr003 = '5' THEN
               CALL q_rtax001()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = '6' THEN
               LET g_qryparam.arg1 = '2000'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = '7' THEN
               LET g_qryparam.arg1 = '2001'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = '8' THEN
               LET g_qryparam.arg1 = '2002'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = '9' THEN
               LET g_qryparam.arg1 = '2003'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = 'A' THEN
               LET g_qryparam.arg1 = '2004'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = 'B' THEN
               LET g_qryparam.arg1 = '2005'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = 'C' THEN
               LET g_qryparam.arg1 = '2006'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = 'D' THEN
               LET g_qryparam.arg1 = '2007'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = 'E' THEN
               LET g_qryparam.arg1 = '2008'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = 'F' THEN
               LET g_qryparam.arg1 = '2009'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = 'G' THEN
               LET g_qryparam.arg1 = '2010'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = 'H' THEN
               LET g_qryparam.arg1 = '2011'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = 'I' THEN
               LET g_qryparam.arg1 = '2012'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = 'J' THEN
               LET g_qryparam.arg1 = '2013'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = 'K' THEN
               LET g_qryparam.arg1 = '2014'
               CALL q_oocq002()
            END IF
            IF g_prdn3_d[l_ac].prdr003 = 'L' THEN
               LET g_qryparam.arg1 = '2015'
               CALL q_oocq002()
            END IF
            
            LET g_prdn3_d[l_ac].prdr004 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_prdn3_d[l_ac].prdr004 TO prdr004              #顯示到畫面上
            IF g_prdn3_d[l_ac].prdr003 = '4' THEN
               CALL aprm551_prdr004_ref()
            END IF
            CALL aprm551_prdr_desc()
            NEXT FIELD prdr004
            #END add-point
 
 
         #Ctrlp:input.c.page3.prdr006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr006
            #add-point:ON ACTION controlp INFIELD prdr006 name="input.c.page3.prdr006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdn3_d[l_ac].prdr006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_prdn3_d[l_ac].prdr006 = g_qryparam.return1              

            DISPLAY g_prdn3_d[l_ac].prdr006 TO prdr006              #

            NEXT FIELD prdr006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.prdr007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr007
            #add-point:ON ACTION controlp INFIELD prdr007 name="input.c.page3.prdr007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prdr008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr008
            #add-point:ON ACTION controlp INFIELD prdr008 name="input.c.page3.prdr008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prdr009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr009
            #add-point:ON ACTION controlp INFIELD prdr009 name="input.c.page3.prdr009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prdrsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdrsite
            #add-point:ON ACTION controlp INFIELD prdrsite name="input.c.page3.prdrsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prdrunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdrunit
            #add-point:ON ACTION controlp INFIELD prdrunit name="input.c.page3.prdrunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prdr005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prdr005
            #add-point:ON ACTION controlp INFIELD prdr005 name="input.c.page3.prdr005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prdn3_d[l_ac].prdr005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imay003_2()                                #呼叫開窗

            LET g_prdn3_d[l_ac].prdr005 = g_qryparam.return1              

            DISPLAY g_prdn3_d[l_ac].prdr005 TO prdr005              #

            NEXT FIELD prdr005                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prdn3_d[l_ac].* = g_prdn3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprm551_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprm551_unlock_b("prdr_t","'3'")
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
               LET g_prdn3_d[li_reproduce_target].* = g_prdn3_d[li_reproduce].*
 
               LET g_prdn3_d[li_reproduce_target].prdr002 = NULL
               LET g_prdn3_d[li_reproduce_target].prdr003 = NULL
               LET g_prdn3_d[li_reproduce_target].prdr004 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_prdn3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prdn3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aprm551.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      INPUT ARRAY g_prdn4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prdn4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprm551_b_fill()
            LET g_rec_b = g_prdn4_d.getLength()
            #add-point:資料輸入前
            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prdn4_d[l_ac].* TO NULL 
                  LET g_prdn4_d[l_ac].prdvstus = "Y"
 
 
            LET g_prdn4_d_t.* = g_prdn4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprm551_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b

            #end add-point
            CALL aprm551_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prdn4_d[li_reproduce_target].* = g_prdn4_d[li_reproduce].*
 
               LET g_prdn4_d[li_reproduce_target].prdv003 = NULL
            END IF
            #公用欄位給值(單身2)
            
            
            #add-point:modify段before insert
            #end add-point  
            
         BEFORE ROW     
            #add-point:modify段before row2

            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aprm551_cl USING g_enterprise,g_prdl_m.prdl001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aprm551_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aprm551_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_prdn4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prdn4_d[l_ac].prdv003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prdn4_d_t.* = g_prdn4_d[l_ac].*  #BACKUP
               CALL aprm551_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               #end add-point  
               CALL aprm551_set_no_entry_b(l_cmd)
               IF NOT aprm551_lock_b("prdv_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprm551_bcl4 INTO g_prdn4_d[l_ac].prdvstus,g_prdn4_d[l_ac].prdu003, 
                      g_prdn4_d[l_ac].prdv003,g_prdn4_d[l_ac].prdv005,g_prdn4_d[l_ac].prdv005_desc,g_prdn4_d[l_ac].prdv007, 
                      g_prdn4_d[l_ac].prdv007_desc,g_prdn4_d[l_ac].prdv008,g_prdn4_d[l_ac].prdu005,g_prdn4_d[l_ac].prdu002 
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL aprm551_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_prdn4_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_prdn4_d.deleteElement(l_ac)
               NEXT FIELD prdv003
            END IF
         
            IF g_prdn4_d[l_ac].prdv003 IS NOT NULL
            THEN
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
               
               #add-point:單身2刪除前
               DELETE FROM prdu_t
               WHERE prduent = g_enterprise AND prdu001 = g_prdl_m.prdl001 AND 
                     prdu002 = g_prdn4_d_t.prdv003 and prdu003 = g_prdn4_d_t.prdu003
                 AND prdu004 = 0
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prdu_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               #end add-point    
               
               DELETE FROM prdv_t
                WHERE prdvent = g_enterprise AND prdv001 = g_prdl_m.prdl001 AND
                      prdv002 = g_prdn4_d_t.prdv003 AND prdv003 = g_prdn4_d_t.prdv003
                  
               #add-point:單身2刪除中
               
               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prdn_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身2刪除後
                   
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aprm551_bcl
               LET l_count = g_prdn_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys[2] = g_prdn4_d[g_detail_idx].prdv003
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 

            #end add-point
            DELETE FROM prdu_t
             WHERE prduent = g_enterprise AND prdu001 = g_prdl_m.prdl001 AND 
                   prdu002 = g_prdn4_d_t.prdv003 and prdu003 = g_prdn4_d_t.prdu003
               AND prdu004 = 0
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdu_t"
               LET g_errparam.popup = FALSE
               CALL cl_err()
  
            END IF 
               #end add-point    
               
            DELETE FROM prdv_t
             WHERE prdvent = g_enterprise AND prdv001 = g_prdl_m.prdl001 AND
                   prdv002 = g_prdn4_d_t.prdv003 AND prdv003 = g_prdn4_d_t.prdv003
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prdu_t"
               LET g_errparam.popup = FALSE
               CALL cl_err()
  
            END IF      
               #add-point:單身2刪除中
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前

            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM prdv_t 
             WHERE prdvent = g_enterprise AND prdv001 = g_prdl_m.prdl001
               AND prdv002 = g_prdn4_d[l_ac].prdv003 AND prdv003 = g_prdn4_d[l_ac].prdv003
               AND prdv005 = g_prdn4_d[l_ac].prdv005
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前
               IF NOT cl_null(g_prdn4_d[l_ac].prdu003) AND NOT cl_null(g_prdn4_d[l_ac].prdv003) THEN
                  SELECT count(*) INTO l_cnt FROM prdu_t 
                   WHERE prduent = g_enterprise AND prdu001 = g_prdl_m.prdl001
                     AND prdu002 = g_prdn4_d[l_ac].prdv003 AND prdu003 = g_prdn4_d[l_ac].prdu003
                  IF l_cnt>0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apr-00324"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD prdu003 
                  END IF
               END IF
               #end add-point
                                 
               INSERT INTO prdv_t (prdvent,prdvsite,prdvunit,prdv001,prdv001,prdv002,prdv003,prdv004,prdv005,prdv007,prdv008,prdvstus)
                VALUES (g_enterprise,g_prdl_m.prdlsite,g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl001,g_prdn4_d[l_ac].prdv003,g_prdn4_d[l_ac].prdv003,'4',g_prdn4_d[l_ac].prdv005,g_prdn4_d[l_ac].prdv007,g_prdn4_d[l_ac].prdv008,g_prdn4_d[l_ac].prdvstus)
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prdv_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT
               ELSE
                  INSERT INTO prdu_t (prduent,prdusite,prduunit,prdu001,prdu001,prdu002,prdu003,prdu004,prdu005,prdustus)
                  VALUES (g_enterprise,g_prdl_m.prdlsite,g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl001,g_prdn4_d[l_ac].prdv003,g_prdn4_d[l_ac].prdu003,0,g_prdn4_d[l_ac].prdu005,g_prdn4_d[l_ac].prdvstus)
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prdu_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                     CALL s_transaction_end('N','0')                    
                     CANCEL INSERT
                  ELSE
                     #先刷新資料
                     #CALL aprm551_b_fill()
                     #資料多語言用-增/改
                     UPDATE prdl_t SET prdl018 = g_prdl_m.prdl018,
                                       prdl019 = g_prdl_m.prdl019,
                                       prdl032 = g_prdl_m.prdl032
                      WHERE prdlent = g_enterprise AND prdl001 = g_prdl_m.prdl001
                     IF SQLCA.SQLcode  THEN
                        INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prdv_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                        CALL s_transaction_end('N','0')                    
                        CANCEL INSERT
                     ELSE                      
                     #add-point:單身新增後
                     #end add-point
                        CALL s_transaction_end('Y','0')
                        ERROR 'INSERT O.K'
                        LET g_rec_b = g_rec_b + 1
                     END IF   
                  END IF
               END IF
                           
               #add-point:單身新增後2

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_prdn_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_prdn4_d[l_ac].* = g_prdn4_d_t.*
               CLOSE aprm551_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_prdn4_d[l_ac].* = g_prdn4_d_t.*
            ELSE
               #add-point:單身page2修改前
               UPDATE prdl_t SET prdl018 = g_prdl_m.prdl018,
                                 prdl019 = g_prdl_m.prdl019,
                                 prdl032 = g_prdl_m.prdl032
                WHERE prdlent = g_enterprise AND prdl001 = g_prdl_m.prdl001
               IF SQLCA.sqlcode THEN #其他錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prdv_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  LET g_prdn4_d[l_ac].* = g_prdn4_d_t.*
                  RETURN
               END IF 
               UPDATE prdu_t SET (prdu001,prdustus,prdu002,prdu003,prdu005)=(g_prdl_m.prdl001, 
                   g_prdn4_d[l_ac].prdvstus,g_prdn4_d[l_ac].prdv003,g_prdn4_d[l_ac].prdu003,g_prdn4_d[l_ac].prdu005)
                WHERE prduent = g_enterprise AND prdu001 = g_prdl_m.prdl001
                  AND prdu002 = g_prdn4_d_t.prdv003 AND prdu003 =  g_prdn4_d_t.prdu003
                  AND prdu004 = 0
               IF SQLCA.sqlcode THEN #其他錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prdv_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  LET g_prdn4_d[l_ac].* = g_prdn4_d_t.*
                  RETURN
               END IF 
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               UPDATE prdv_t SET (prdv001,prdvstus,prdv002,prdv003,prdv005,prdv007,prdv008,prdvsite,prdvunit) = 
(g_prdl_m.prdl001, g_prdn4_d[l_ac].prdvstus,g_prdn4_d[l_ac].prdv003,g_prdn4_d[l_ac].prdv003,g_prdn4_d[l_ac].prdv005, 
                   g_prdn4_d[l_ac].prdv007,g_prdn4_d[l_ac].prdv008,g_prdl_m.prdlsite,g_prdl_m.prdlunit) #自訂欄位頁簽
                WHERE prdvent = g_enterprise AND prdv001 = g_prdl_m.prdl001
                  AND prdv002 = g_prdn4_d_t.prdv003 AND prdv003 = g_prdn4_d_t.prdv003
                  AND prdv004 = '4' AND prdv005=g_prdn4_d_t.prdv005
                  
               #add-point:單身page2修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "prdv_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     LET g_prdn4_d[l_ac].* = g_prdn4_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prdv_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_prdn4_d[l_ac].* = g_prdn4_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prdl_m.prdl001
               LET gs_keys_bak[1] = g_prdl001_t
               LET gs_keys[2] = g_prdn4_d[g_detail_idx].prdv003
               LET gs_keys_bak[2] = g_prdn4_d_t.prdv003
               CALL aprm551_update_b('prdv_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page2修改後

               #end add-point
            END IF
         
         #---------------------<  Detail: page2  >---------------------
         #----<<prdvstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdvstus
            #add-point:BEFORE FIELD prdvstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdvstus
            
            #add-point:AFTER FIELD prdvstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdvstus
            #add-point:ON CHANGE prdvstus

            #END add-point
 
         #----<<prdv002>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdu003
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_prdn4_d[l_ac].prdu003,"0","1","","","azz-00079",1) THEN
               LET g_prdn4_d[l_ac].prdu003 = g_prdn4_d_t.prdu003
               NEXT FIELD prdu003
            END IF
 
 
            #add-point:AFTER FIELD prdu003
            #此段落由子樣板a05產生
            IF  g_prdl_m.prdl001 IS NOT NULL AND g_prdn4_d[g_detail_idx].prdu003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prdn4_d[l_ac].prdu003 != g_prdn4_d_t.prdu003)) THEN 
                                       
                  CALL aprm551_chk_prdu003()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prdn4_d[l_ac].prdu003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prdn4_d[l_ac].prdu003 = g_prdn4_d_t.prdu003
                     NEXT FIELD prdu003 
                  END IF
                  IF NOT cl_null(g_prdn4_d[l_ac].prdv003) THEN
                     SELECT count(*) INTO l_cnt FROM prdu_t 
                      WHERE prduent = g_enterprise AND prdu001 = g_prdl_m.prdl001
                        AND prdu002 = g_prdn4_d[l_ac].prdv003 AND prdu003 = g_prdn4_d[l_ac].prdu003
                     IF l_cnt>0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "apr-00324"
                        LET g_errparam.extend = g_prdn4_d[l_ac].prdu003
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prdn4_d[l_ac].prdu003 = g_prdn4_d_t.prdu003
                        NEXT FIELD prdu003 
                     END IF
                  END IF                  
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdu003
            #add-point:BEFORE FIELD prdv002

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdu003
            #add-point:ON CHANGE prdv002

            #END add-point

 
         #----<<prdv003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdv003
            #add-point:BEFORE FIELD prdv003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdv003
            
            #add-point:AFTER FIELD prdv003
            IF NOT cl_ap_chk_Range(g_prdn4_d[l_ac].prdv003,"0","1","","","azz-00079",1) THEN
               LET g_prdn4_d[l_ac].prdv003 = g_prdn4_d_t.prdv003
               NEXT FIELD prdv003
            END IF

           
            #END add-point
            
         #----<<prdv004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prdv005
            #add-point:BEFORE FIELD prdv004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prdv005
            
            #add-point:AFTER FIELD prdv004
#            LET g_prdn4_d[l_ac].prdv005_desc = null
#            DISPLAY BY NAME g_prdn4_d[l_ac].prdv005_desc
#            IF  g_prdl_m.prdadocno IS NOT NULL AND g_prdn4_d[g_detail_idx].prdv003 IS NOT NULL AND g_prdn4_d[g_detail_idx].prdv005 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prdl_m.prdadocno != g_prdldocno_t OR g_prdn4_d[g_detail_idx].prdv003 != g_prdn4_d_t.prdv003 OR g_prdn4_d[g_detail_idx].prdv005 != g_prdn4_d_t.prdv005)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prdv_t WHERE "||"prdvent = '" ||g_enterprise|| "' AND "||"prdv001 = '"||g_prdl_m.prdadocno ||"' AND "|| "prdv002 = '"||g_prdn4_d[g_detail_idx].prdv003 ||"' AND "|| "prdv003 = '"||g_prdn4_d[g_detail_idx].prdv003 ||"' AND "|| "prdv005 = '"||g_prdn4_d[g_detail_idx].prdv005 ||"'",'std-00004',0) THEN 
#                     LET g_prdn4_d[l_ac].prdv005 = g_prdn4_d_t.prdv005
#                     CALL aprm551_prdv005_ref()
#                     NEXT FIELD CURRENT
#                  END IF
#                  IF NOT cl_null(g_prdn4_d[l_ac].prdv003) THEN
#                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                     INITIALIZE g_chkparam.* TO NULL
#                     #設定g_chkparam.*的參數
#                     LET g_chkparam.arg1 = g_prdn4_d[l_ac].prdv005
##                     LET g_chkparam.arg2 = g_site
#                     #呼叫檢查存在並帶值的library
#                     IF NOT cl_chk_exist("v_imaa001_5") THEN
#                        LET g_prdn4_d[l_ac].prdv005 = g_prdn4_d_t.prdv005
#                        CALL aprm551_prdv005_ref()
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
#               END IF
#            END IF
#            CALL aprm551_prdv005_ref()
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prdv005
            #add-point:ON CHANGE prdv004

            #END add-point
 
         #----<<prdv006>>----
         #此段落由子樣板a02產生
         AFTER FIELD prdu005
            #此段落由子樣板a15產生
#            IF NOT cl_ap_chk_Range(g_prdn4_d[l_ac].prdu005,"","","0","0","azz-00080",1) THEN
#               LET g_prdn4_d[l_ac].prdu005 = g_prdn4_d_t.prdu005
#               NEXT FIELD prdu005
#            END IF
            IF NOT cl_ap_chk_Range(g_prdn4_d[l_ac].prdu005,"0","1","","","azz-00079",1) THEN
               LET g_prdn4_d[l_ac].prdu005 = g_prdn4_d_t.prdu005
               NEXT FIELD prdu005
            END IF
 
            #add-point:AFTER FIELD prdv006
            IF NOT cl_null(g_prdn4_d[l_ac].prdu005) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD prdu005
            #add-point:BEFORE FIELD prdv006

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE prdu005
            #add-point:ON CHANGE prdv006

            #END add-poin
 
         
         #Ctrlp:input.c.page2.prdv003
         ON ACTION controlp INFIELD prdv003
            #add-point:ON ACTION controlp INFIELD prdv003

            #END add-point
 
         #----<<prdv005>>----
         #Ctrlp:input.c.page2.prdv005
         ON ACTION controlp INFIELD prdv005
            #add-point:ON ACTION controlp INFIELD prdv005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	         LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_prdn4_d[l_ac].prdv005             #給予default值
            LET g_qryparam.arg1 = g_site
#            CALL q_rtdx001_12()
            call q_imaa001()
            LET g_prdn4_d[l_ac].prdv005  = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_prdn4_d[l_ac].prdv005  TO prdv005              #顯示到畫面上
            CALL aprm551_prdv005_ref()
            NEXT FIELD prdv005
            #END add-point
 
         #----<<prdv008>>----
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row

            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prdn4_d[l_ac].* = g_prdn4_d_t.*
               END IF
               CLOSE aprm551_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CLOSE aprm551_bcl4
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2

            #end add-point
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_prdn4_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_prdn4_d.getLength()+1
 
      END INPUT
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
            NEXT FIELD prdl001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prdnstus
               WHEN "s_detail2"
                  NEXT FIELD prdsstus
               WHEN "s_detail3"
                  NEXT FIELD prdrstus
 
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
 
{<section id="aprm551.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprm551_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aprm551_b_fill() #單身填充
      CALL aprm551_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aprm551_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

   SELECT prdo003,prdo004 INTO g_prdl_m.prdo003,g_prdl_m.prdo004 FROM prdo_t
    WHERE prdoent = g_enterprise AND prdo001 = g_prdl_m.prdl001 AND prdo002=1
   DISPLAY BY NAME g_prdl_m.prdo003,g_prdl_m.prdo004
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdl_m.prdl001
   CALL ap_ref_array2(g_ref_fields," SELECT prdll003 FROM prdll_t WHERE prdllent = '"||g_enterprise||"' AND prdll001 = ? AND prdll002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_prdl_m.prdll003 = g_rtn_fields[1] 
   DISPLAY g_prdl_m.prdll003 TO prdll003
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prdl_m.prdlunit
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prdl_m.prdlunit_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prdl_m.prdlunit_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prdl_m.prdl006
#            CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prdl_m.prdl006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prdl_m.prdl006_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prdl_m.prdl007
#            CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prdl_m.prdl007_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prdl_m.prdl007_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prdl_m.prdl004
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prdl_m.prdl004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prdl_m.prdl004_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prdl_m.prdl005
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prdl_m.prdl005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prdl_m.prdl005_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prdl_m.prdl008
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2100' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prdl_m.prdl008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prdl_m.prdl008_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prdl_m.prdl009
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prdl_m.prdl009_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prdl_m.prdl009_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prdl_m.prdlcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prdl_m.prdlcrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prdl_m.prdlcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prdl_m.prdlcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prdl_m.prdlcrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prdl_m.prdlcrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prdl_m.prdlownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prdl_m.prdlownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prdl_m.prdlownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prdl_m.prdlowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prdl_m.prdlowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prdl_m.prdlowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prdl_m.prdlmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prdl_m.prdlmodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prdl_m.prdlmodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prdl_m.prdlcnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prdl_m.prdlcnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prdl_m.prdlcnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_prdl_m_mask_o.* =  g_prdl_m.*
   CALL aprm551_prdl_t_mask()
   LET g_prdl_m_mask_n.* =  g_prdl_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prdl_m.prdlunit,g_prdl_m.prdlunit_desc,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdll003, 
       g_prdl_m.prdl006,g_prdl_m.prdl006_desc,g_prdl_m.prdl007,g_prdl_m.prdl007_desc,g_prdl_m.prdl027, 
       g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl004,g_prdl_m.prdl004_desc,g_prdl_m.prdl005, 
       g_prdl_m.prdl005_desc,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012,g_prdl_m.prdl010,g_prdl_m.prdl013, 
       g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdo003,g_prdl_m.prdo004,g_prdl_m.prdl098,g_prdl_m.prdl017, 
       g_prdl_m.prdl020,g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl008_desc,g_prdl_m.prdl009,g_prdl_m.prdl009_desc, 
       g_prdl_m.prdl022,g_prdl_m.prdl026,g_prdl_m.prdl023,g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029, 
       g_prdl_m.prdl030,g_prdl_m.prdl031,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp, 
       g_prdl_m.prdlcrtdp_desc,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp, 
       g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid, 
       g_prdl_m.prdlcnfid_desc,g_prdl_m.prdlcnfdt,g_prdl_m.prdl018,g_prdl_m.prdl032,g_prdl_m.prdl019 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prdl_m.prdlstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_prdn_d.getLength()
      #add-point:show段單身reference name="show.body.reference"

            CALL aprm551_prdn004_ref()

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_prdn2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      IF g_prdn2_d[l_ac].prds009<>'4' THEN
         SELECT prdm005 INTO g_prdn2_d[l_ac].prdb005 FROM prdm_t
          WHERE prdment = g_enterprise AND prdm001 = g_prdl_m.prdl001
            AND prdm004 = g_prdn2_d[l_ac].prds002 AND rownum = 1
         DISPLAY g_prdn2_d[l_ac].prdb005 TO s_detail2[l_ac].prdb005
      END IF         
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_prdn3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"

            CALL aprm551_prdr_desc()

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr006
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prdn3_d[l_ac].prdr006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prdn3_d[l_ac].prdr006_desc

      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   FOR l_ac = 1 TO g_prdn4_d.getLength()

#       INITIALIZE g_ref_fields TO NULL
#       LET g_ref_fields[1] = g_prdn4_d[l_ac].prdv005
#       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#       LET g_prdn4_d[l_ac].prdv005_desc = '', g_rtn_fields[1] , ''
#       DISPLAY BY NAME g_prdn4_d[l_ac].prdv005_desc
#
#       INITIALIZE g_ref_fields TO NULL
#       LET g_ref_fields[1] = g_prdn4_d[l_ac].prdv007
#       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#       LET g_prdn4_d[l_ac].prdv007_desc = '', g_rtn_fields[1] , ''
#       DISPLAY BY NAME g_prdn4_d[l_ac].prdv007_desc
      #end add-point
   END FOR
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprm551_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprm551.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aprm551_detail_show()
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
 
{<section id="aprm551.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprm551_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE prdl_t.prdl001 
   DEFINE l_oldno     LIKE prdl_t.prdl001 
 
   DEFINE l_master    RECORD LIKE prdl_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE prdn_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE prds_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE prdr_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_prdl_m.prdl001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_prdl001_t = g_prdl_m.prdl001
 
    
   LET g_prdl_m.prdl001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prdl_m.prdlownid = g_user
      LET g_prdl_m.prdlowndp = g_dept
      LET g_prdl_m.prdlcrtid = g_user
      LET g_prdl_m.prdlcrtdp = g_dept 
      LET g_prdl_m.prdlcrtdt = cl_get_current()
      LET g_prdl_m.prdlmodid = g_user
      LET g_prdl_m.prdlmoddt = cl_get_current()
      LET g_prdl_m.prdlstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prdl_m.prdlstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL aprm551_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_prdl_m.* TO NULL
      INITIALIZE g_prdn_d TO NULL
      INITIALIZE g_prdn2_d TO NULL
      INITIALIZE g_prdn3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aprm551_show()
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
   CALL aprm551_set_act_visible()   
   CALL aprm551_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prdl001_t = g_prdl_m.prdl001
 
   
   #組合新增資料的條件
   LET g_add_browse = " prdlent = " ||g_enterprise|| " AND",
                      " prdl001 = '", g_prdl_m.prdl001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprm551_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aprm551_idx_chk()
   
   LET g_data_owner = g_prdl_m.prdlownid      
   LET g_data_dept  = g_prdl_m.prdlowndp
   
   #功能已完成,通報訊息中心
   CALL aprm551_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aprm551.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprm551_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prdn_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE prds_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE prdr_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprm551_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prdn_t
    WHERE prdnent = g_enterprise AND prdn001 = g_prdl001_t
 
    INTO TEMP aprm551_detail
 
   #將key修正為調整後   
   UPDATE aprm551_detail 
      #更新key欄位
      SET prdn001 = g_prdl_m.prdl001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
      #, prdnstus = "Y" 
 
 
#應用 a13 樣板自動產生(Version:4)
      #, prdsstus = "Y" 
 
 
#應用 a13 樣板自動產生(Version:4)
      #, prdrstus = "Y" 
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO prdn_t SELECT * FROM aprm551_detail
   
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
   DROP TABLE aprm551_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prds_t 
    WHERE prdsent = g_enterprise AND prds001 = g_prdl001_t
 
    INTO TEMP aprm551_detail
 
   #將key修正為調整後   
   UPDATE aprm551_detail SET prds001 = g_prdl_m.prdl001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO prds_t SELECT * FROM aprm551_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprm551_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prdr_t 
    WHERE prdrent = g_enterprise AND prdr001 = g_prdl001_t
 
    INTO TEMP aprm551_detail
 
   #將key修正為調整後   
   UPDATE aprm551_detail SET prdr001 = g_prdl_m.prdl001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO prdr_t SELECT * FROM aprm551_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprm551_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_prdl001_t = g_prdl_m.prdl001
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprm551.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprm551_delete()
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
   
   IF g_prdl_m.prdl001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.prdll001 = g_prdl_m.prdl001
LET g_master_multi_table_t.prdll003 = g_prdl_m.prdll003
 
   
   CALL s_transaction_begin()
 
   OPEN aprm551_cl USING g_enterprise,g_prdl_m.prdl001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprm551_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprm551_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprm551_master_referesh USING g_prdl_m.prdl001 INTO g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002, 
       g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus, 
       g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012,g_prdl_m.prdl010, 
       g_prdl_m.prdl013,g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdl098,g_prdl_m.prdl017,g_prdl_m.prdl020, 
       g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdl022,g_prdl_m.prdl026,g_prdl_m.prdl023, 
       g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029,g_prdl_m.prdl030,g_prdl_m.prdl031,g_prdl_m.prdlcrtid, 
       g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlowndp,g_prdl_m.prdlmodid, 
       g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt,g_prdl_m.prdl018,g_prdl_m.prdl032,g_prdl_m.prdl019, 
       g_prdl_m.prdlunit_desc,g_prdl_m.prdl006_desc,g_prdl_m.prdl007_desc,g_prdl_m.prdl004_desc,g_prdl_m.prdl005_desc, 
       g_prdl_m.prdl008_desc,g_prdl_m.prdl009_desc,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp_desc,g_prdl_m.prdlownid_desc, 
       g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aprm551_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prdl_m_mask_o.* =  g_prdl_m.*
   CALL aprm551_prdl_t_mask()
   LET g_prdl_m_mask_n.* =  g_prdl_m.*
   
   CALL aprm551_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aprm551_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_prdl001_t = g_prdl_m.prdl001
 
 
      DELETE FROM prdl_t
       WHERE prdlent = g_enterprise AND prdl001 = g_prdl_m.prdl001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_prdl_m.prdl001,":",SQLERRMESSAGE  
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
      
      DELETE FROM prdn_t
       WHERE prdnent = g_enterprise AND prdn001 = g_prdl_m.prdl001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdn_t:",SQLERRMESSAGE 
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
      DELETE FROM prds_t
       WHERE prdsent = g_enterprise AND
             prds001 = g_prdl_m.prdl001
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prds_t:",SQLERRMESSAGE 
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
      DELETE FROM prdr_t
       WHERE prdrent = g_enterprise AND
             prdr001 = g_prdl_m.prdl001
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdr_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      DELETE FROM prdd_t
       WHERE prddent = g_enterprise AND
             prdddocno = g_prdl_m.prdl001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdd_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      DELETE FROM prdb_t
       WHERE prdbent = g_enterprise AND
             prdbdocno = g_prdl_m.prdl001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      DELETE FROM prdu_t
       WHERE prduent = g_enterprise AND
             prdu001 = g_prdl_m.prdl001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdu_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      DELETE FROM prdv_t
       WHERE prdvent = g_enterprise AND
             prdv001 = g_prdl_m.prdl001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prdv_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      CALL g_prdn4_d.clear() 
      CALL g_prdn5_d.clear()
      CALL g_prdn6_d.clear()      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_prdl_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aprm551_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_prdn_d.clear() 
      CALL g_prdn2_d.clear()       
      CALL g_prdn3_d.clear()       
 
     
      CALL aprm551_ui_browser_refresh()  
      #CALL aprm551_ui_headershow()  
      #CALL aprm551_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'prdllent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.prdll001
   LET l_field_keys[02] = 'prdll001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'prdll_t')
 
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aprm551_browser_fill("")
         CALL aprm551_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprm551_cl
 
   #功能已完成,通報訊息中心
   CALL aprm551_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aprm551.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprm551_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_prdn_d.clear()
   CALL g_prdn2_d.clear()
   CALL g_prdn3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_prdn4_d.clear()
   CALL g_prdn5_d.clear()
   CALL g_prdn6_d.clear()
   #end add-point
   
   #判斷是否填充
   IF aprm551_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prdnstus,prdn002,prdn003,prdn004,prdnsite,prdnunit  FROM prdn_t", 
                
                     " INNER JOIN prdl_t ON prdlent = " ||g_enterprise|| " AND prdl001 = prdn001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE prdnent=? AND prdn001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prdn_t.prdn002,prdn_t.prdn003,prdn_t.prdn004"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprm551_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aprm551_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_prdl_m.prdl001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_prdl_m.prdl001 INTO g_prdn_d[l_ac].prdnstus,g_prdn_d[l_ac].prdn002, 
          g_prdn_d[l_ac].prdn003,g_prdn_d[l_ac].prdn004,g_prdn_d[l_ac].prdnsite,g_prdn_d[l_ac].prdnunit  
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
   IF aprm551_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prdsstus,prds002,prds000,prds003,prds005,prds006,prds008,prds009, 
             prds010,prds011,prds012,prds013,prds004,prds007,prdssite,prdsunit  FROM prds_t",   
                     " INNER JOIN  prdl_t ON prdlent = " ||g_enterprise|| " AND prdl001 = prds001 ",
 
                     "",
                     
                     
                     " WHERE prdsent=? AND prds001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prds_t.prds002"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprm551_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aprm551_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_prdl_m.prdl001   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_prdl_m.prdl001 INTO g_prdn2_d[l_ac].prdsstus,g_prdn2_d[l_ac].prds002, 
          g_prdn2_d[l_ac].prds000,g_prdn2_d[l_ac].prds003,g_prdn2_d[l_ac].prds005,g_prdn2_d[l_ac].prds006, 
          g_prdn2_d[l_ac].prds008,g_prdn2_d[l_ac].prds009,g_prdn2_d[l_ac].prds010,g_prdn2_d[l_ac].prds011, 
          g_prdn2_d[l_ac].prds012,g_prdn2_d[l_ac].prds013,g_prdn2_d[l_ac].prds004,g_prdn2_d[l_ac].prds007, 
          g_prdn2_d[l_ac].prdssite,g_prdn2_d[l_ac].prdsunit   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         SELECT prdb005 INTO g_prdn2_d[l_ac].prdb005 FROM prdb_t
          WHERE prdbent = g_enterprise AND prdbdocno = g_prdl_m.prdl001
            AND prdb004 = g_prdn2_d[l_ac].prds002 AND rownum = 1
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
   IF aprm551_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prdrstus,prdr010,prdr002,prdr003,prdr004,prdr006,prdr007,prdr008, 
             prdr009,prdrsite,prdrunit,prdr005 ,t1.oocal003 FROM prdr_t",   
                     " INNER JOIN  prdl_t ON prdlent = " ||g_enterprise|| " AND prdl001 = prdr001 ",
 
                     "",
                     
                                    " LEFT JOIN oocal_t t1 ON t1.oocalent="||g_enterprise||" AND t1.oocal001=prdr006 AND t1.oocal002='"||g_dlang||"' ",
 
                     " WHERE prdrent=? AND prdr001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prdr_t.prdr002,prdr_t.prdr003,prdr_t.prdr004"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprm551_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR aprm551_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_prdl_m.prdl001   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_prdl_m.prdl001 INTO g_prdn3_d[l_ac].prdrstus,g_prdn3_d[l_ac].prdr010, 
          g_prdn3_d[l_ac].prdr002,g_prdn3_d[l_ac].prdr003,g_prdn3_d[l_ac].prdr004,g_prdn3_d[l_ac].prdr006, 
          g_prdn3_d[l_ac].prdr007,g_prdn3_d[l_ac].prdr008,g_prdn3_d[l_ac].prdr009,g_prdn3_d[l_ac].prdrsite, 
          g_prdn3_d[l_ac].prdrunit,g_prdn3_d[l_ac].prdr005,g_prdn3_d[l_ac].prdr006_desc   #(ver:78)
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
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   LET g_sql = "SELECT  UNIQUE prdvstus,prdu003,prdv003,prdv005,'',prdv007,'',prdu005,prdu002 FROM prdu_t",   
                  " INNER JOIN prdv_t ON prdu001 = prdv001 AND prdu002=prdv002 AND prdu002=prdv003 ",
 
                  "",
                  
                  " WHERE prduent=? AND prdu001=?"   
      #add-point:b_fill段sql_before

      #end add-point
      IF NOT cl_null(g_wc2_table4) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY prdu_t.prdu003,prdv_t.prdv003,prdv_t.prdv005"
      
      #add-point:單身填充控制

      #end add-point
      
      PREPARE aprm551_pb4 FROM g_sql
      DECLARE b_fill_cs4 CURSOR FOR aprm551_pb4
      
      LET l_ac = 1
      
      OPEN b_fill_cs4 USING g_enterprise,g_prdl_m.prdl001
 
                                               
      FOREACH b_fill_cs4 INTO g_prdn4_d[l_ac].prdvstus,g_prdn4_d[l_ac].prdu003,g_prdn4_d[l_ac].prdv003, 
          g_prdn4_d[l_ac].prdv005,g_prdn4_d[l_ac].prdv005_desc,g_prdn4_d[l_ac].prdv007,g_prdn4_d[l_ac].prdv007_desc, 
          g_prdn4_d[l_ac].prdu005,g_prdn4_d[l_ac].prdu002

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充

         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
   CALL g_prdn4_d.deleteElement(g_prdn4_d.getLength()) 
   FREE aprm551_pb4   

   #end add-point
   
   CALL g_prdn_d.deleteElement(g_prdn_d.getLength())
   CALL g_prdn2_d.deleteElement(g_prdn2_d.getLength())
   CALL g_prdn3_d.deleteElement(g_prdn3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprm551_pb
   FREE aprm551_pb2
 
   FREE aprm551_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_prdn_d.getLength()
      LET g_prdn_d_mask_o[l_ac].* =  g_prdn_d[l_ac].*
      CALL aprm551_prdn_t_mask()
      LET g_prdn_d_mask_n[l_ac].* =  g_prdn_d[l_ac].*
   END FOR
   
   LET g_prdn2_d_mask_o.* =  g_prdn2_d.*
   FOR l_ac = 1 TO g_prdn2_d.getLength()
      LET g_prdn2_d_mask_o[l_ac].* =  g_prdn2_d[l_ac].*
      CALL aprm551_prds_t_mask()
      LET g_prdn2_d_mask_n[l_ac].* =  g_prdn2_d[l_ac].*
   END FOR
   LET g_prdn3_d_mask_o.* =  g_prdn3_d.*
   FOR l_ac = 1 TO g_prdn3_d.getLength()
      LET g_prdn3_d_mask_o[l_ac].* =  g_prdn3_d[l_ac].*
      CALL aprm551_prdr_t_mask()
      LET g_prdn3_d_mask_n[l_ac].* =  g_prdn3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aprm551.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprm551_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM prdn_t
       WHERE prdnent = g_enterprise AND
         prdn001 = ps_keys_bak[1] AND prdn002 = ps_keys_bak[2] AND prdn003 = ps_keys_bak[3] AND prdn004 = ps_keys_bak[4]
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
         CALL g_prdn_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM prds_t
       WHERE prdsent = g_enterprise AND
             prds001 = ps_keys_bak[1] AND prds002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prds_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_prdn2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM prdr_t
       WHERE prdrent = g_enterprise AND
             prdr001 = ps_keys_bak[1] AND prdr002 = ps_keys_bak[2] AND prdr003 = ps_keys_bak[3] AND prdr004 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdr_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_prdn3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprm551.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprm551_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO prdn_t
                  (prdnent,
                   prdn001,
                   prdn002,prdn003,prdn004
                   ,prdnstus,prdnsite,prdnunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_prdn_d[g_detail_idx].prdnstus,g_prdn_d[g_detail_idx].prdnsite,g_prdn_d[g_detail_idx].prdnunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_prdn_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO prds_t
                  (prdsent,
                   prds001,
                   prds002
                   ,prdsstus,prds000,prds003,prds005,prds006,prds008,prds009,prds010,prds011,prds012,prds013,prds004,prds007,prdssite,prdsunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prdn2_d[g_detail_idx].prdsstus,g_prdn2_d[g_detail_idx].prds000,g_prdn2_d[g_detail_idx].prds003, 
                       g_prdn2_d[g_detail_idx].prds005,g_prdn2_d[g_detail_idx].prds006,g_prdn2_d[g_detail_idx].prds008, 
                       g_prdn2_d[g_detail_idx].prds009,g_prdn2_d[g_detail_idx].prds010,g_prdn2_d[g_detail_idx].prds011, 
                       g_prdn2_d[g_detail_idx].prds012,g_prdn2_d[g_detail_idx].prds013,g_prdn2_d[g_detail_idx].prds004, 
                       g_prdn2_d[g_detail_idx].prds007,g_prdn2_d[g_detail_idx].prdssite,g_prdn2_d[g_detail_idx].prdsunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prds_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_prdn2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO prdr_t
                  (prdrent,
                   prdr001,
                   prdr002,prdr003,prdr004
                   ,prdrstus,prdr010,prdr006,prdr007,prdr008,prdr009,prdrsite,prdrunit,prdr005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_prdn3_d[g_detail_idx].prdrstus,g_prdn3_d[g_detail_idx].prdr010,g_prdn3_d[g_detail_idx].prdr006, 
                       g_prdn3_d[g_detail_idx].prdr007,g_prdn3_d[g_detail_idx].prdr008,g_prdn3_d[g_detail_idx].prdr009, 
                       g_prdn3_d[g_detail_idx].prdrsite,g_prdn3_d[g_detail_idx].prdrunit,g_prdn3_d[g_detail_idx].prdr005) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prdr_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_prdn3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aprm551.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprm551_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prdn_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aprm551_prdn_t_mask_restore('restore_mask_o')
               
      UPDATE prdn_t 
         SET (prdn001,
              prdn002,prdn003,prdn004
              ,prdnstus,prdnsite,prdnunit) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_prdn_d[g_detail_idx].prdnstus,g_prdn_d[g_detail_idx].prdnsite,g_prdn_d[g_detail_idx].prdnunit)  
 
         WHERE prdnent = g_enterprise AND prdn001 = ps_keys_bak[1] AND prdn002 = ps_keys_bak[2] AND prdn003 = ps_keys_bak[3] AND prdn004 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prdn_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prdn_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprm551_prdn_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prds_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aprm551_prds_t_mask_restore('restore_mask_o')
               
      UPDATE prds_t 
         SET (prds001,
              prds002
              ,prdsstus,prds000,prds003,prds005,prds006,prds008,prds009,prds010,prds011,prds012,prds013,prds004,prds007,prdssite,prdsunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prdn2_d[g_detail_idx].prdsstus,g_prdn2_d[g_detail_idx].prds000,g_prdn2_d[g_detail_idx].prds003, 
                  g_prdn2_d[g_detail_idx].prds005,g_prdn2_d[g_detail_idx].prds006,g_prdn2_d[g_detail_idx].prds008, 
                  g_prdn2_d[g_detail_idx].prds009,g_prdn2_d[g_detail_idx].prds010,g_prdn2_d[g_detail_idx].prds011, 
                  g_prdn2_d[g_detail_idx].prds012,g_prdn2_d[g_detail_idx].prds013,g_prdn2_d[g_detail_idx].prds004, 
                  g_prdn2_d[g_detail_idx].prds007,g_prdn2_d[g_detail_idx].prdssite,g_prdn2_d[g_detail_idx].prdsunit)  
 
         WHERE prdsent = g_enterprise AND prds001 = ps_keys_bak[1] AND prds002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prds_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prds_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprm551_prds_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prdr_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aprm551_prdr_t_mask_restore('restore_mask_o')
               
      UPDATE prdr_t 
         SET (prdr001,
              prdr002,prdr003,prdr004
              ,prdrstus,prdr010,prdr006,prdr007,prdr008,prdr009,prdrsite,prdrunit,prdr005) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_prdn3_d[g_detail_idx].prdrstus,g_prdn3_d[g_detail_idx].prdr010,g_prdn3_d[g_detail_idx].prdr006, 
                  g_prdn3_d[g_detail_idx].prdr007,g_prdn3_d[g_detail_idx].prdr008,g_prdn3_d[g_detail_idx].prdr009, 
                  g_prdn3_d[g_detail_idx].prdrsite,g_prdn3_d[g_detail_idx].prdrunit,g_prdn3_d[g_detail_idx].prdr005)  
 
         WHERE prdrent = g_enterprise AND prdr001 = ps_keys_bak[1] AND prdr002 = ps_keys_bak[2] AND prdr003 = ps_keys_bak[3] AND prdr004 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prdr_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prdr_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprm551_prdr_t_mask_restore('restore_mask_n')
 
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
 
{<section id="aprm551.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aprm551_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aprm551.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aprm551_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aprm551.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprm551_lock_b(ps_table,ps_page)
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
   #CALL aprm551_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "prdn_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprm551_bcl USING g_enterprise,
                                       g_prdl_m.prdl001,g_prdn_d[g_detail_idx].prdn002,g_prdn_d[g_detail_idx].prdn003, 
                                           g_prdn_d[g_detail_idx].prdn004     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprm551_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "prds_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprm551_bcl2 USING g_enterprise,
                                             g_prdl_m.prdl001,g_prdn2_d[g_detail_idx].prds002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprm551_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "prdr_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprm551_bcl3 USING g_enterprise,
                                             g_prdl_m.prdl001,g_prdn3_d[g_detail_idx].prdr002,g_prdn3_d[g_detail_idx].prdr003, 
                                                 g_prdn3_d[g_detail_idx].prdr004
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprm551_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   LET ls_group = "prdv_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprm551_bcl4 USING g_enterprise,
                                             g_prdl_m.prdl001,g_prdn4_d[g_detail_idx].prdv003,g_prdn4_d[g_detail_idx].prdv003,g_prdn4_d[g_detail_idx].prdv005,g_prdn4_d[g_detail_idx].prdu003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aprm551_bcl4"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aprm551.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprm551_unlock_b(ps_table,ps_page)
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
      CLOSE aprm551_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprm551_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprm551_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprm551_bcl4
   END IF
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprm551.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprm551_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("prdl001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("prdl029,prdl030,prdl031",true)
   CALL cl_set_comp_entry("prdl001",TRUE)
   CALL cl_set_comp_entry("prdl001",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprm551.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprm551_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("prdl001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"

      CALL cl_set_comp_entry("prdl001",FALSE)  
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
   IF g_prdl_m.prdl028='1' THEN
      CALL cl_set_comp_entry("prdl029,prdl030,prdl031",false)
   ELSE
               
   END IF 
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprm551.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprm551_set_entry_b(p_cmd)
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
 
{<section id="aprm551.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprm551_set_no_entry_b(p_cmd)
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
 
{<section id="aprm551.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aprm551_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprm551.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aprm551_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprm551.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aprm551_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprm551.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aprm551_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprm551.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprm551_default_search()
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
      LET ls_wc = ls_wc, " prdl001 = '", g_argv[01], "' AND "
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
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "prdl_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prdn_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prds_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "prdr_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
 
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
 
{<section id="aprm551.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aprm551_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_time    DATETIME YEAR TO SECOND
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   RETURN
   IF g_prdl_m.prdlstus='Y' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_prdl_m.prdl001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aprm551_cl USING g_enterprise,g_prdl_m.prdl001
   IF STATUS THEN
      CLOSE aprm551_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprm551_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aprm551_master_referesh USING g_prdl_m.prdl001 INTO g_prdl_m.prdlunit,g_prdl_m.prdl001,g_prdl_m.prdl002, 
       g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus, 
       g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012,g_prdl_m.prdl010, 
       g_prdl_m.prdl013,g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdl098,g_prdl_m.prdl017,g_prdl_m.prdl020, 
       g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdl022,g_prdl_m.prdl026,g_prdl_m.prdl023, 
       g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029,g_prdl_m.prdl030,g_prdl_m.prdl031,g_prdl_m.prdlcrtid, 
       g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlowndp,g_prdl_m.prdlmodid, 
       g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt,g_prdl_m.prdl018,g_prdl_m.prdl032,g_prdl_m.prdl019, 
       g_prdl_m.prdlunit_desc,g_prdl_m.prdl006_desc,g_prdl_m.prdl007_desc,g_prdl_m.prdl004_desc,g_prdl_m.prdl005_desc, 
       g_prdl_m.prdl008_desc,g_prdl_m.prdl009_desc,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp_desc,g_prdl_m.prdlownid_desc, 
       g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aprm551_action_chk() THEN
      CLOSE aprm551_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prdl_m.prdlunit,g_prdl_m.prdlunit_desc,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdll003, 
       g_prdl_m.prdl006,g_prdl_m.prdl006_desc,g_prdl_m.prdl007,g_prdl_m.prdl007_desc,g_prdl_m.prdl027, 
       g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl004,g_prdl_m.prdl004_desc,g_prdl_m.prdl005, 
       g_prdl_m.prdl005_desc,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012,g_prdl_m.prdl010,g_prdl_m.prdl013, 
       g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdo003,g_prdl_m.prdo004,g_prdl_m.prdl098,g_prdl_m.prdl017, 
       g_prdl_m.prdl020,g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl008_desc,g_prdl_m.prdl009,g_prdl_m.prdl009_desc, 
       g_prdl_m.prdl022,g_prdl_m.prdl026,g_prdl_m.prdl023,g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029, 
       g_prdl_m.prdl030,g_prdl_m.prdl031,g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp, 
       g_prdl_m.prdlcrtdp_desc,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp, 
       g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid,g_prdl_m.prdlmodid_desc,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid, 
       g_prdl_m.prdlcnfid_desc,g_prdl_m.prdlcnfdt,g_prdl_m.prdl018,g_prdl_m.prdl032,g_prdl_m.prdl019 
 
 
   CASE g_prdl_m.prdlstus
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
         CASE g_prdl_m.prdlstus
            
            WHEN "N"
               HIDE OPTION "open"
            WHEN "Y"
               HIDE OPTION "valid"
            WHEN "X"
               HIDE OPTION "void"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      IF g_prdl_m.prdlstus <> 'N' THEN
         CALL cl_set_act_visible("invalid", FALSE)
      ELSE
         CALL cl_set_act_visible("invalid", FALSE)       
      END IF
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
      g_prdl_m.prdlstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aprm551_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CALL s_transaction_begin()
   IF lc_state = 'Y' THEN
      CALL s_aprt211_conf_chk(g_prdl_m.prdl001,g_prdl_m.prdlstus) RETURNING l_success,g_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = g_prdl_m.prdl001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_aprt211_conf_upd(g_prdl_m.prdl001,g_prdl_m.prdlstus) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
      END IF
   END IF
   LET l_time = cl_get_current()
   IF (lc_state = 'Y' AND g_prdl_m.prdlstus = 'X') OR lc_state = 'X' OR lc_state = 'N'  THEN
      UPDATE prdl_t SET prdlmodid = g_user,
                        prdlmoddt = l_time
       WHERE prdlent = g_enterprise
         AND prdl001 = g_prdl_m.prdl001
   END IF
   #end add-point
   
   LET g_prdl_m.prdlmodid = g_user
   LET g_prdl_m.prdlmoddt = cl_get_current()
   LET g_prdl_m.prdlstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE prdl_t 
      SET (prdlstus,prdlmodid,prdlmoddt) 
        = (g_prdl_m.prdlstus,g_prdl_m.prdlmodid,g_prdl_m.prdlmoddt)     
    WHERE prdlent = g_enterprise AND prdl001 = g_prdl_m.prdl001
 
    
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
      EXECUTE aprm551_master_referesh USING g_prdl_m.prdl001 INTO g_prdl_m.prdlunit,g_prdl_m.prdl001, 
          g_prdl_m.prdl002,g_prdl_m.prdl006,g_prdl_m.prdl007,g_prdl_m.prdl027,g_prdl_m.prdl099,g_prdl_m.prdl100, 
          g_prdl_m.prdlstus,g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012, 
          g_prdl_m.prdl010,g_prdl_m.prdl013,g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdl098,g_prdl_m.prdl017, 
          g_prdl_m.prdl020,g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdl022,g_prdl_m.prdl026, 
          g_prdl_m.prdl023,g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029,g_prdl_m.prdl030,g_prdl_m.prdl031, 
          g_prdl_m.prdlcrtid,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid,g_prdl_m.prdlowndp, 
          g_prdl_m.prdlmodid,g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfdt,g_prdl_m.prdl018, 
          g_prdl_m.prdl032,g_prdl_m.prdl019,g_prdl_m.prdlunit_desc,g_prdl_m.prdl006_desc,g_prdl_m.prdl007_desc, 
          g_prdl_m.prdl004_desc,g_prdl_m.prdl005_desc,g_prdl_m.prdl008_desc,g_prdl_m.prdl009_desc,g_prdl_m.prdlcrtid_desc, 
          g_prdl_m.prdlcrtdp_desc,g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid_desc, 
          g_prdl_m.prdlcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_prdl_m.prdlunit,g_prdl_m.prdlunit_desc,g_prdl_m.prdl001,g_prdl_m.prdl002,g_prdl_m.prdll003, 
          g_prdl_m.prdl006,g_prdl_m.prdl006_desc,g_prdl_m.prdl007,g_prdl_m.prdl007_desc,g_prdl_m.prdl027, 
          g_prdl_m.prdl099,g_prdl_m.prdl100,g_prdl_m.prdlstus,g_prdl_m.prdl004,g_prdl_m.prdl004_desc, 
          g_prdl_m.prdl005,g_prdl_m.prdl005_desc,g_prdl_m.prdlsite,g_prdl_m.prdl003,g_prdl_m.prdl012, 
          g_prdl_m.prdl010,g_prdl_m.prdl013,g_prdl_m.prdl011,g_prdl_m.prdl014,g_prdl_m.prdo003,g_prdl_m.prdo004, 
          g_prdl_m.prdl098,g_prdl_m.prdl017,g_prdl_m.prdl020,g_prdl_m.prdl021,g_prdl_m.prdl008,g_prdl_m.prdl008_desc, 
          g_prdl_m.prdl009,g_prdl_m.prdl009_desc,g_prdl_m.prdl022,g_prdl_m.prdl026,g_prdl_m.prdl023, 
          g_prdl_m.prdl025,g_prdl_m.prdl028,g_prdl_m.prdl029,g_prdl_m.prdl030,g_prdl_m.prdl031,g_prdl_m.prdlcrtid, 
          g_prdl_m.prdlcrtid_desc,g_prdl_m.prdlcrtdp,g_prdl_m.prdlcrtdp_desc,g_prdl_m.prdlcrtdt,g_prdl_m.prdlownid, 
          g_prdl_m.prdlownid_desc,g_prdl_m.prdlowndp,g_prdl_m.prdlowndp_desc,g_prdl_m.prdlmodid,g_prdl_m.prdlmodid_desc, 
          g_prdl_m.prdlmoddt,g_prdl_m.prdlcnfid,g_prdl_m.prdlcnfid_desc,g_prdl_m.prdlcnfdt,g_prdl_m.prdl018, 
          g_prdl_m.prdl032,g_prdl_m.prdl019
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aprm551_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprm551_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprm551.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aprm551_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prdn_d.getLength() THEN
         LET g_detail_idx = g_prdn_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdn_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prdn_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_prdn2_d.getLength() THEN
         LET g_detail_idx = g_prdn2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdn2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prdn2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_prdn3_d.getLength() THEN
         LET g_detail_idx = g_prdn3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdn3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prdn3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_prdn4_d.getLength() THEN
         LET g_detail_idx = g_prdn3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prdn4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prdn4_d.getLength() TO FORMONLY.cnt
   END IF
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprm551.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprm551_b_fill2(pi_idx)
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
   
   CALL aprm551_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aprm551.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprm551_fill_chk(ps_idx)
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
 
{<section id="aprm551.status_show" >}
PRIVATE FUNCTION aprm551_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprm551.mask_functions" >}
&include "erp/apr/aprm551_mask.4gl"
 
{</section>}
 
{<section id="aprm551.signature" >}
   
 
{</section>}
 
{<section id="aprm551.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aprm551_set_pk_array()
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
   LET g_pk_array[1].values = g_prdl_m.prdl001
   LET g_pk_array[1].column = 'prdl001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprm551.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aprm551.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aprm551_msgcentre_notify(lc_state)
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
   CALL aprm551_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_prdl_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprm551.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aprm551_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprm551.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 單頭帶值欄位顯示
# Memo...........:
# Usage..........: CALL aprm551_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/15 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm551_desc()

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdl_m.prdlunit
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdl_m.prdlunit_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdl_m.prdlunit_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdl_m.prdl006
   CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdl_m.prdl006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdl_m.prdl006_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdl_m.prdl007
   CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdl_m.prdl007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdl_m.prdl007_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdl_m.prdl004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prdl_m.prdl004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdl_m.prdl004_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdl_m.prdl005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdl_m.prdl005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdl_m.prdl005_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdl_m.prdl008
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2100' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdl_m.prdl008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdl_m.prdl008_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdl_m.prdl009
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdl_m.prdl009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdl_m.prdl009_desc
END FUNCTION

#display prdl006
PRIVATE FUNCTION aprm551_prdl006_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdl_m.prdl006
   CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdl_m.prdl006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdl_m.prdl006_desc
END FUNCTION

#chk prdl006,prdl007
PRIVATE FUNCTION aprm551_chk_prdl006()
   DEFINE  l_cnt  LIKE type_t.num5
   LET g_errno = NULL
   LET l_cnt = 0
   IF NOT cl_null(g_prdl_m.prdl006) AND NOT cl_null(g_prdl_m.prdl007) THEN
      SELECT count(*) INTO l_cnt FROM prcf_t
       WHERE prcf001 = g_prdl_m.prdl006 AND prcf002 = g_prdl_m.prdl007
         AND prcfent = g_enterprise
      IF l_cnt<=0 THEN
         LET g_errno = "apr-00065"
      END IF      
   END IF
END FUNCTION

#create prcf006
PRIVATE FUNCTION aprm551_create_prdl006()
   SELECT prcf002,prcf007,prcf008
     INTO g_prdl_m.prdl007,g_prdl_m.prdl008,g_prdl_m.prdl009
     FROM prcf_t
    WHERE prcfent = g_enterprise AND prcf001 = g_prdl_m.prdl006
   CALL aprm551_prdl007_ref()
   CALL aprm551_prdl008_ref()
   CALL aprm551_prdl009_ref()
   DISPLAY BY NAME  g_prdl_m.prdl007,g_prdl_m.prdl008,g_prdl_m.prdl009  
END FUNCTION

#display prdl007
PRIVATE FUNCTION aprm551_prdl007_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdl_m.prdl007
   CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdl_m.prdl007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdl_m.prdl007_desc
   SELECT prcd004,prcd005
     INTO g_prdl_m.prdo003,g_prdl_m.prdo004
     FROM prcd_t
    WHERE prcdent = g_enterprise AND prcd001 = g_prdl_m.prdl007
   DISPLAY BY NAME  g_prdl_m.prdo003,g_prdl_m.prdo004
END FUNCTION

#display prdl004
PRIVATE FUNCTION aprm551_prdl004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdl_m.prdl004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prdl_m.prdl004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdl_m.prdl004_desc
   
END FUNCTION

#display prdl005
PRIVATE FUNCTION aprm551_prdl005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdl_m.prdl005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdl_m.prdl005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdl_m.prdl005_desc
END FUNCTION

#display prdl008
PRIVATE FUNCTION aprm551_prdl008_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdl_m.prdl008
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2100' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdl_m.prdl008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdl_m.prdl008_desc
END FUNCTION

#display prdl009
PRIVATE FUNCTION aprm551_prdl009_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdl_m.prdl009
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdl_m.prdl009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdl_m.prdl009_desc
END FUNCTION

#display prdl008,prdl009
PRIVATE FUNCTION aprm551_create_prdl007()
   IF cl_null(g_prdl_m.prdl006) THEN
      SELECT prcd002,prcd003
        INTO g_prdl_m.prdl008,g_prdl_m.prdl009
        FROM prcd_t
       WHERE prcdent = g_enterprise AND prcd001 = g_prdl_m.prdl007
      CALL aprm551_prdl008_ref()
      CALL aprm551_prdl009_ref()
      DISPLAY BY NAME  g_prdl_m.prdl007,g_prdl_m.prdl008,g_prdl_m.prdl009  
   END IF
   
END FUNCTION

#create prdl005
PRIVATE FUNCTION aprm551_create_prdl004()
   SELECT ooag003 INTO g_prdl_m.prdl005
     FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = g_prdl_m.prdl004
   DISPLAY BY NAME g_prdl_m.prdl005 
   CALL aprm551_prdl005_ref()   
END FUNCTION

#chk prdl004,prdl005
PRIVATE FUNCTION aprm551_chk_prdl004()
   DEFINE l_cnt  LIKE type_t.num5
   LET g_errno = NULL
   LET l_cnt = 0
   IF NOT cl_null(g_prdl_m.prdl004) AND NOT cl_null(g_prdl_m.prdl005) THEN
      SELECT count(*) INTO l_cnt FROM ooag_t
       WHERE ooagent = g_enterprise AND ooag001 = g_prdl_m.prdl004
         AND ooag003 = g_prdl_m.prdl005
      IF l_cnt<=0 THEN
         LET g_errno="apr-00307"
      END IF      
   END IF       
END FUNCTION

#chk prdl001
PRIVATE FUNCTION aprm551_chk_prdl001()
DEFINE l_n              LIKE type_t.num5
DEFINE l_prdlstus       LIKE prdl_t.prdlstus
DEFINE l_prdlunit       LIKE prdl_t.prdlunit

   LET g_errno = ""
   
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM prdl_t
       WHERE prdlent = g_enterprise
         AND prdl001 = g_prdl_m.prdl001
      IF l_n > 0 THEN
         LET g_errno = 'sub-01319'  #apr-00248  #160318-00005#39 by 07900 --mod
         RETURN
      END IF
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM prdl_t
       WHERE prdlent = g_enterprise
         AND prdl001 = g_prdl_m.prdl001
         AND prdl001 <> g_prdl_m.prdl001
      IF l_n > 0 THEN
         LET g_errno = 'apr-00305'
         RETURN
      END IF
   
END FUNCTION

################################################################################
# Descriptions...: 添加數據
# Memo...........:
# Usage..........: CALL aprm551_prdl001_init()
# Date & Author..: 2014/05/19 By qiaozy
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm551_prdl001_init()
#DEFINE l_prdl               RECORD LIKE prdl_t.*  #161111-00028#2--mark
#161111-00028#2--add--begin---------------
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
       prdl042 LIKE prdl_t.prdl042  #當天銷售積分否
END RECORD
#161111-00028#2--add--end---------------
DEFINE l_prdo003            LIKE prdo_t.prdo003
DEFINE l_prdo004            LIKE prdo_t.prdo004
   IF cl_null(g_prdl_m.prdl001) THEN
      RETURN
   END IF 
   
      INITIALIZE g_prdl_m.prdl002,g_prdl_m.prdl003,g_prdl_m.prdll003,g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdl006,
                 g_prdl_m.prdlstus,g_prdl_m.prdl007,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdl018,g_prdl_m.prdl019,
                 g_prdl_m.prdl027,g_prdl_m.prdl028,g_prdl_m.prdo003,g_prdl_m.prdo004,g_prdl_m.prdl098,g_prdl_m.prdl019,
                 g_prdl_m.prdl030,g_prdl_m.prdl031,g_prdl_m.prdl032 TO NULL
      LET g_prdl_m.prdlstus = "N"
      LET g_prdl_m.prdl003 = '31'
      LET g_prdl_m.prdl004 = g_user
      LET g_prdl_m.prdl005 = g_dept
      LET g_prdl_m.prdl002 = 1
      LET g_prdl_m.prdl098 = '2'
      LET g_prdl_m.prdl010 = 'N'
      LET g_prdl_m.prdl011 = 'N'
      LET g_prdl_m.prdl012 = 'N'
      LET g_prdl_m.prdl013 = 'N'
      LET g_prdl_m.prdl014 = 0
      LET g_prdl_m.prdl017 = '2'
      LET g_prdl_m.prdl018 = '1'
      LET g_prdl_m.prdl019 = '1'
      LET g_prdl_m.prdl020 = 'N'
      LET g_prdl_m.prdl021 = 0
      LET g_prdl_m.prdl022 = 0
      LET g_prdl_m.prdl023 = 0
      LET g_prdl_m.prdl025 = '1'
      LET g_prdl_m.prdl026 = '4'
      LET g_prdl_m.prdl028 = "1"
      LET g_prdl_m.prdl032 = '1'
      
   CALL aprm551_desc()
#   CALL aprm551_set_comp_visible()
   DISPLAY BY NAME g_prdl_m.prdl002,g_prdl_m.prdl003,g_prdl_m.prdll003,g_prdl_m.prdl004,g_prdl_m.prdl005,g_prdl_m.prdl006,
                 g_prdl_m.prdlstus,g_prdl_m.prdl007,g_prdl_m.prdl008,g_prdl_m.prdl009,g_prdl_m.prdl018,g_prdl_m.prdl019,
                 g_prdl_m.prdl027,g_prdl_m.prdl028,g_prdl_m.prdo003,g_prdl_m.prdo004,g_prdl_m.prdl098,g_prdl_m.prdl019,
                 g_prdl_m.prdl030,g_prdl_m.prdl031,g_prdl_m.prdl032
                 
END FUNCTION

##create prdn002
PRIVATE FUNCTION aprm551_create_prdn002()
   SELECT max(prdn002)+1 INTO g_prdn_d[l_ac].prdn002
     FROM prdn_t
    WHERE prdnent = g_enterprise
      AND prdn001 = g_prdl_m.prdl001
   IF cl_null(g_prdn_d[l_ac].prdn002) OR g_prdn_d[l_ac].prdn002=0 THEN
      LET g_prdn_d[l_ac].prdn002 = 1
   END IF   
END FUNCTION

#display prdn004
PRIVATE FUNCTION aprm551_prdn004_ref()
   IF g_prdn_d[l_ac].prdn003 = '1' THEN #客戶編號
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdn_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdn_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdn_d[l_ac].prdn004_desc
      END IF
      
      IF g_prdn_d[l_ac].prdn003 = '2' THEN #客戶分類
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdn_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdn_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdn_d[l_ac].prdn004_desc
      END IF 
      
      IF g_prdn_d[l_ac].prdn003 = '3' THEN 
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdn_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2061' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdn_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdn_d[l_ac].prdn004_desc
      END IF
      
      IF g_prdn_d[l_ac].prdn003 = '4' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdn_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2062' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdn_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdn_d[l_ac].prdn004_desc
      END IF     

      IF g_prdn_d[l_ac].prdn003 = '5' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdn_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2063' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdn_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdn_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdn_d[l_ac].prdn003 = '6' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdn_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2064' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdn_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdn_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdn_d[l_ac].prdn003 = '7' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdn_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2065' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdn_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdn_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdn_d[l_ac].prdn003 = '8' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdn_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2066' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdn_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdn_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdn_d[l_ac].prdn003 = '9' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdn_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2067' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdn_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdn_d[l_ac].prdn004_desc
      END IF  
      
      
      IF g_prdn_d[l_ac].prdn003 = '10' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdn_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2068' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdn_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdn_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdn_d[l_ac].prdn003 = '11' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdn_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2069' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdn_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdn_d[l_ac].prdn004_desc
      END IF  
      
      IF g_prdn_d[l_ac].prdn003 = '12' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prdn_d[l_ac].prdn004
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2070' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prdn_d[l_ac].prdn004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prdn_d[l_ac].prdn004_desc
      END IF  
END FUNCTION

#create prds002
PRIVATE FUNCTION aprm551_create_prds002()
   SELECT max(prds002)+1 INTO g_prdn2_d[l_ac].prds002
     FROM prds_t
    WHERE prdsent = g_enterprise AND prds001 = g_prdl_m.prdl001
   IF cl_null(g_prdn2_d[l_ac].prds002) OR g_prdn2_d[l_ac].prds002=0 THEN
      LET g_prdn2_d[l_ac].prds002 = 1
   END IF     
END FUNCTION

#set prdh entry
PRIVATE FUNCTION aprm551_set_prds_entry()
   CALL cl_set_comp_entry("prds005,prds003",true)
   CALL cl_set_comp_required("prds005",true)
   
   IF g_prdn2_d[l_ac].prds003='0' THEN
      CALL cl_set_comp_entry("prds005",false)
   ELSE
      CALL cl_set_comp_entry("prds005",TRUE)            
   END IF
   IF g_prdn2_d[l_ac].prds009='4' THEN
      CALL cl_set_comp_entry("prdb005",false)
      CALL cl_set_comp_required("prdb005",false)
   ELSE
      CALL cl_set_comp_required("prdb005",true)   
   END IF
   IF (g_prdn2_d[l_ac].prds000='1')  THEN
      CALL cl_set_comp_entry("prds003,prds008",false)
   ELSE
      CALL cl_set_comp_entry("prds003,prds008",TRUE)   
   END IF
   
END FUNCTION

##chk prds005
PRIVATE FUNCTION aprm551_chk_prds005()
   DEFINE l_cnt  LIKE type_t.num5
   LET l_cnt=0
   LET g_errno = NULL
   IF g_prdn2_d[l_ac].prds009='2' OR g_prdn2_d[l_ac].prds009='5' THEN
      IF g_prdn2_d[l_ac].prdb005>100 THEN
         LET g_errno = "apr-00308"
      END IF
   END IF
END FUNCTION

##create prdr002
PRIVATE FUNCTION aprm551_create_prdr002()
   SELECT max(prdr002)+1 INTO g_prdn3_d[l_ac].prdr002
     FROM prdr_t
    WHERE prdrent = g_enterprise AND prdr001 = g_prdl_m.prdl001
   IF cl_null(g_prdn3_d[l_ac].prdr002) OR g_prdn3_d[l_ac].prdr002=0 THEN
      LET g_prdn3_d[l_ac].prdr002 = 1
   END IF 
END FUNCTION

##display prdg
PRIVATE FUNCTION aprm551_prdr_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdn3_d[l_ac].prdr006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdn3_d[l_ac].prdr006_desc
   
   IF g_prdn3_d[l_ac].prdr003 = '4' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = '5' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = '6' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2000' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = '7' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2001' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = '8' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2002' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = '9' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2003' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'A' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2004' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'B' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2005' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'C' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2006' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'D' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2007' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'E' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2008' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'F' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2009' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'G' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2010' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'H' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2011' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'I' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2012' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'J' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2013' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'K' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2014' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'L' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prdn3_d[l_ac].prdr004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '2015' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prdn3_d[l_ac].prdr004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prdn3_d[l_ac].prdr004_desc
   END IF
END FUNCTION

##chk prdr004
PRIVATE FUNCTION aprm551_chk_prdr004()
      IF g_prdn3_d[l_ac].prdr003 = '4' THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      #160318-00025#15 by 07900 --add-str 
      LET g_errshow = TRUE #是否開窗
      #160318-00025#15 by 07900 --add-end
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_prdn3_d[l_ac].prdr004
      #160318-00025#15 by 07900 --add-str 
      LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
      LET g_chkparam.err_str[2] ="aim-00121:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
      #160318-00025#15 by 07900 --add-end 
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_imaa001_5") THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = '5' THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_prdn3_d[l_ac].prdr004
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_rtax001_1") THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = '6' THEN
      IF NOT s_azzi650_chk_exist('2000',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = '7' THEN
      IF NOT s_azzi650_chk_exist('2001',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = '8' THEN
      IF NOT s_azzi650_chk_exist('2002',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = '9' THEN
      IF NOT s_azzi650_chk_exist('2003',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'A' THEN
      IF NOT s_azzi650_chk_exist('2004',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'B' THEN
      IF NOT s_azzi650_chk_exist('2005',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'C' THEN
      IF NOT s_azzi650_chk_exist('2006',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'D' THEN
      IF NOT s_azzi650_chk_exist('2007',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'E' THEN
      IF NOT s_azzi650_chk_exist('2008',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'F' THEN
      IF NOT s_azzi650_chk_exist('2009',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'G' THEN
      IF NOT s_azzi650_chk_exist('2010',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'H' THEN
      IF NOT s_azzi650_chk_exist('2011',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'I' THEN
      IF NOT s_azzi650_chk_exist('2012',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'J' THEN
      IF NOT s_azzi650_chk_exist('2013',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'K' THEN
      IF NOT s_azzi650_chk_exist('2014',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_prdn3_d[l_ac].prdr003 = 'L' THEN
      IF NOT s_azzi650_chk_exist('2015',g_prdn3_d[l_ac].prdr004) THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

##display prdr004,prdr005
PRIVATE FUNCTION aprm551_prdr004_ref()
   #150312-00002#5 Modify-S By Ken 150317
   #SELECT rtdx002,rtdx033 INTO g_prdn3_d[l_ac].prdr005,g_prdn3_d[l_ac].prdr006
   #  FROM rtdx_t
   # WHERE rtdxent = g_enterprise
   #   AND rtdxsite = g_site
   #   AND rtdx001 = g_prdn3_d[l_ac].prdr004
   SELECT rtdx002,imaa106 INTO g_prdn3_d[l_ac].prdr005,g_prdn3_d[l_ac].prdr006
     FROM rtdx_t,imaa_t
    WHERE rtdxent  = imaaent
      AND rtdx001  = imaa001  
      AND rtdxent  = g_enterprise
      AND rtdxsite = g_site
      AND rtdx001  = g_prdn3_d[l_ac].prdr004 
   #150312-00002#5 Modify-E   
   CALL aprm551_prdr_desc()
END FUNCTION

#insert prdb_t
PRIVATE FUNCTION aprm551_ins_prdb()
   DEFINE  l_cnt  LIKE type_t.num5
   DEFINE  l_cnt1 LIKE type_t.num5
   DEFINE  l_prdn002 LIKE prdn_t.prdn002
   DEFINE  l_sql  STRING 
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno=null
   LET l_sql="SELECT DISTINCT prdn002  FROM prdn_t WHERE prdnent=",g_enterprise," AND prdn001='",g_prdl_m.prdl001,"' "
   PREPARE l_sql_prdn_pre1 FROM l_sql
   DECLARE l_sql_prdn_cs1 CURSOR FOR l_sql_prdn_pre1
   SELECT count(*) INTO l_cnt FROM prdn_t
    WHERE prdnent = g_enterprise AND prdn001 = g_prdl_m.prdl001
   SELECT count(*) INTO l_cnt1 FROM prds_t
    WHERE prdsent = g_enterprise AND prds001 = g_prdl_m.prdl001
   IF cl_null(l_cnt) THEN
      LET l_cnt = 0
   END IF
   IF cl_null(l_cnt1) THEN
      LET l_cnt1 = 0
   END IF
   IF l_cnt>0 AND l_cnt1>0 THEN
      FOREACH l_sql_prdn_cs1 INTO l_prdn002
         INSERT INTO prdb_t (prdbent,prdbunit,prdbsite,prdbdocno,prdb001,prdb002,prdb003,prdb004,prdb005,prdbacti)
           VALUES (g_enterprise,g_prdl_m.prdlunit,g_prdl_m.prdlsite,g_prdl_m.prdl001,g_prdl_m.prdl001,l_prdn002,'3',
                   g_prdn2_d[l_ac].prds002,g_prdn2_d[l_ac].prdb005,g_prdn2_d[l_ac].prdsstus)
         IF sqlca.sqlcode THEN
            LET g_errno=sqlca.sqlcode
            RETURN
         END IF 
         LET l_prdn002 = NULL         
      END FOREACH
   END IF   
END FUNCTION

##ins prdb_t
PRIVATE FUNCTION aprm551_ins_prdn_prdb()
   DEFINE  l_cnt  LIKE type_t.num5
   DEFINE  l_cnt1 LIKE type_t.num5
   DEFINE  l_prds002 LIKE prds_t.prds002
   DEFINE  l_prdb005 LIKE prdb_t.prdb005
   DEFINE  l_count   LIKE type_t.num5
   DEFINE  l_sql  STRING 
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno=null
   LET l_count = 0
   SELECT count(*) INTO l_count FROM prdn_t 
    WHERE prdnent = g_enterprise AND prdn001 = g_prdl_m.prdl001
      AND prdn002 = g_prdn_d[l_ac].prdn002
   IF l_count>1 THEN
      RETURN
   END IF   
   LET l_sql="SELECT DISTINCT prdb004,prdb005  FROM prdb_t WHERE prdbent=",g_enterprise," AND prdbdocno='",g_prdl_m.prdl001,"' "
   PREPARE l_sql_prdn_pre2 FROM l_sql
   DECLARE l_sql_prdn_cs2 CURSOR FOR l_sql_prdn_pre2
   SELECT count(*) INTO l_cnt FROM prdn_t
    WHERE prdnent = g_enterprise AND prdn001 = g_prdl_m.prdl001
   SELECT count(*) INTO l_cnt1 FROM prds_t
    WHERE prdsent = g_enterprise AND prds001 = g_prdl_m.prdl001
   IF cl_null(l_cnt) THEN
      LET l_cnt = 0
   END IF
   IF cl_null(l_cnt1) THEN
      LET l_cnt1 = 0
   END IF
   IF l_cnt>0 AND l_cnt1>0 THEN
      FOREACH l_sql_prdn_cs2 INTO l_prds002,l_prdb005
#         select count(*) into l_count from prdb_t where prdbent = g_enterprise
#            and prdbdocno = g_prdl_m.prdadocno and prdb002 = g_prdn_d[l_ac].prdn002
#            and prdb004 = l_prds002
#         if  l_count>0 then
#            LET g_errno=sqlca.sqlcode
#            RETURN
#         end if           
         INSERT INTO prdb_t (prdbent,prdbunit,prdbsite,prdbdocno,prdb001,prdb002,prdb003,prdb004,prdb005,prdbacti)
           VALUES (g_enterprise,g_prdl_m.prdlunit,g_prdl_m.prdlsite,g_prdl_m.prdl001,g_prdl_m.prdl001,g_prdn_d[l_ac].prdn002,'3',
                   l_prds002,l_prdb005,g_prdn_d[l_ac].prdnstus)
         IF sqlca.sqlcode THEN
            LET g_errno=sqlca.sqlcode
            RETURN
         END IF
         LET l_prds002 = NULL
         LET l_prdb005 = NULL         
      END FOREACH
   END IF
END FUNCTION

##chk prdr010
PRIVATE FUNCTION aprm551_chk_prdr010()
   DEFINE l_cnt  LIKE type_t.num5
   DEFINE l_cnt1 LIKE type_t.num5
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno = NULL
   SELECT count(*) INTO l_cnt1 FROM prdr_t WHERE prdrent = g_enterprise
      AND prdr001 = g_prdl_m.prdl001
   IF l_cnt1 >0 THEN  
   SELECT count(*) INTO l_cnt FROM prdr_t WHERE prdrent = g_enterprise
      AND prdr001 = g_prdl_m.prdl001 AND prdr010 = 0
   IF l_cnt>0 THEN
      IF g_prdn3_d[l_ac].prdr010<>0 THEN
         LET g_errno="apr-00315"
      END IF
   ELSE
      IF g_prdn3_d[l_ac].prdr010=0 THEN
         LET g_errno="apr-00315"
      END IF
   END IF 
   END IF
   IF NOT cl_null(g_errno) THEN
      RETURN
   END IF   
   IF g_prdn3_d[l_ac].prdr010<>'0' THEN
      SELECT count(*) INTO l_cnt FROM prds_t WHERE prdsent = g_enterprise
         AND prds001 = g_prdl_m.prdl001 AND prds001 = g_prdl_m.prdl001
         AND prds002 = g_prdn3_d[l_ac].prdr010
      IF l_cnt<=0 THEN
         LET g_errno = "apr-00312"
      ELSE
         SELECT count(*) INTO l_cnt FROM prds_t WHERE prdsent = g_enterprise
            AND prds001 = g_prdl_m.prdl001 AND prds001 = g_prdl_m.prdl001
            AND prds002 = g_prdn3_d[l_ac].prdr010 AND prdsstus = 'Y' 
         IF l_cnt<=0 THEN
            LET g_errno = "apr-00313"
         END IF           
      END IF
      IF cl_null(g_errno) THEN
         SELECT count(*) INTO l_cnt FROM prdr_t WHERE prdrent = g_enterprise
            AND prdr001 = g_prdl_m.prdl001 AND prdr010 = g_prdn3_d[l_ac].prdr010
         IF l_cnt>=1 THEN
            LET g_errno = "apr-00314"
         END IF         
      END IF 
   END IF      
END FUNCTION

##chk prdu003
PRIVATE FUNCTION aprm551_chk_prdu003()
   DEFINE l_cnt  LIKE type_t.num5
   DEFINE l_cnt1 LIKE type_t.num5
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno = NULL
   SELECT count(*) INTO l_cnt1 FROM prdu_t WHERE prduent = g_enterprise
      AND prdu001 = g_prdl_m.prdl001
   IF l_cnt1 >0 THEN   
   SELECT count(*) INTO l_cnt FROM prdu_t WHERE prduent = g_enterprise
      AND prdu001 = g_prdl_m.prdl001 AND prdu003 = 0
   IF l_cnt>0 THEN
      IF g_prdn4_d[l_ac].prdu003<>0 THEN
         LET g_errno="apr-00315"
      END IF
   ELSE
      IF g_prdn4_d[l_ac].prdu003=0 THEN
         LET g_errno="apr-00315"
      END IF
   END IF 
   END IF
   IF NOT cl_null(g_errno) THEN
      RETURN
   END IF   
   IF g_prdn4_d[l_ac].prdu003<>'0' THEN
      SELECT count(*) INTO l_cnt FROM prds_t WHERE prdsent = g_enterprise
         AND prds001 = g_prdl_m.prdl001 AND prds001 = g_prdl_m.prdl001
         AND prds002 = g_prdn4_d[l_ac].prdu003
      IF l_cnt<=0 THEN
         LET g_errno = "apr-00312"
      ELSE
         SELECT count(*) INTO l_cnt FROM prds_t WHERE prdsent = g_enterprise
            AND prds001 = g_prdl_m.prdl001 AND prds001 = g_prdl_m.prdl001
            AND prds002 = g_prdn4_d[l_ac].prdu003 AND prdsstus = 'Y' 
         IF l_cnt<=0 THEN
            LET g_errno = "apr-00313"
         END IF           
      END IF
      IF cl_null(g_errno) THEN
         SELECT count(*) INTO l_cnt FROM prds_t WHERE prdsent = g_enterprise
            AND prds001 = g_prdl_m.prdl001 AND prds001 = g_prdl_m.prdl001
            AND prds002 = g_prdn4_d[l_ac].prdu003 AND prds009='4'
         IF l_cnt<=0 THEN
            LET g_errno = "apr-00316"
         END IF         
      END IF 
   END If
END FUNCTION

#chk prdv005
PRIVATE FUNCTION aprm551_prdv005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdn4_d[l_ac].prdv005
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdn4_d[l_ac].prdv005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdn4_d[l_ac].prdv005_desc
   #150312-00002#5 Modify-S By Ken 150317
   #SELECT rtdx033 INTO g_prdn4_d[l_ac].prdv007
   #  FROM rtdx_t
   # WHERE rtdxent = g_enterprise AND rtdx001 =  g_prdn4_d[l_ac].prdv005
   SELECT imaa106 INTO g_prdn4_d[l_ac].prdv007
     FROM imaa_t
    WHERE imaaent = g_enterprise AND imaa001 =  g_prdn4_d[l_ac].prdv005
   #150312-00002#5 Modify-E
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prdn4_d[l_ac].prdv007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prdn4_d[l_ac].prdv007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prdn4_d[l_ac].prdv007_desc   
END FUNCTION

#chk prds000
PRIVATE FUNCTION aprm551_chk_prds000()
   DEFINE l_cnt   LIKE type_t.num5
   LET l_cnt = 0
   LET g_errno = NULL
   IF g_prdn2_d[l_ac].prds000='3' OR g_prdn2_d[l_ac].prds000='4' THEN
      
      IF cl_null(g_prdn2_d_t.prds002) THEN
         IF g_prdn2_d[l_ac].prds000='3' THEN
            SELECT count(*) INTO l_cnt FROM prds_t
             WHERE prdsent = g_enterprise AND prds001 = g_prdl_m.prdl001
               AND prds000='4'
         END IF
         IF g_prdn2_d[l_ac].prds000='4' THEN
            SELECT count(*) INTO l_cnt FROM prds_t
             WHERE prdsent = g_enterprise AND prds001 = g_prdl_m.prdl001
               AND prds000='3'
         END IF
         
      ELSE
         IF g_prdn2_d[l_ac].prds000='3' THEN
            SELECT count(*) INTO l_cnt FROM prds_t
             WHERE prdsent = g_enterprise AND prds001 = g_prdl_m.prdl001
               AND prds000='4' AND prds002<>g_prdn2_d_t.prds002
         END IF
         IF g_prdn2_d[l_ac].prds000='4' THEN
            SELECT count(*) INTO l_cnt FROM prds_t
             WHERE prdsent = g_enterprise AND prds001 = g_prdl_m.prdl001
               AND prds000='3' AND prds002<>g_prdn2_d_t.prds002
         END IF      
      END IF
      IF l_cnt>0 THEN
         LET g_errno='apr-00322'
      END IF
   END IF
END FUNCTION

#chk prdl028
PRIVATE FUNCTION aprm551_chk_prdl028()
   DEFINE  l_cnt   LIKE type_t.num5
   LET l_cnt = 0
   LET g_errno = NULL
   SELECT count(*) INTO l_cnt FROM prds_t
    WHERE prdsent = g_enterprise AND prds001 = g_prdl_m.prdl001
      AND prds009 = '5'
   IF l_cnt >0 THEN
      LET g_errno="apr-00323"
   END IF   
END FUNCTION

 
{</section>}
 
